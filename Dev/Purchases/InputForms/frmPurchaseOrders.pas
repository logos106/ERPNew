Unit frmPurchaseOrders;
{

  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  07/04/05  1.00.01 IJB  Changed foreign currency conversion to use historical
  rate based on InvoveDate or OrderDate.
  11/04/05  1.00.02 IJB  Changed Cost Centre drop-down to also show
  cost centre description, added GlobalEvent notify to
  cost centre close up.

  *** NOTE ****
  When Use Foreign Currency is turned on in prefs AND user changes cost (4 places)
  "Do you wish to Alter the Saved Cost" message is displaying twice because
  LineCost is being rounded to 2 places in DNMLib functions (eg ForeignCurrency_To_AUD).
  11/04/2005  1.00.03 BJ A new datamodule is added for the purchase order to handle the
  notinlist cost centeres entered. The event is notified from the
  'Notinlist' event of the combo which is defined in the new
  datamodule - datModuleSalesPurch
  POLines list: Product should be selected before selecting a cost centre.
  13/05/05  1.00.04 IJB  Moved most of form calculation logic into new Business
  Objects (TPurchaseOrder etc) including new foreign
  currency and Hedging formula calculations.
  18/05/05  1.00.05 IJB  Added TfmForeignPurchaseList to registration.
  08/06/05  1.01.06 ISB  Added Specifications Combo Ect
  23/06/05  1.00.07 BJ   Bug fixed:
  --> Serial nos were getting created for the default
  class - when the PO line has a separate class selected
  --> After creating the Serial nos, if the class is changed
  the serial nos's class also should be changed.
  --> SerialNos feild in the tblPurchaseLines were never
  updated. Created a new property in the Serialnumber form
  to return the Serial nos newly created - purchaseSerialNos
  (similar to SoldSerialNos)
  23/06/05  1.00.07 BJ   New fields
  (1)tblPurchaseOrder.BasePONo:- introduced in the PurchaseOrder
  table to link all the related (Back Order) records to the
  original Purchase Order record
  (2)tblPurchaseOrder.SeqNo :This field stores the sequence
  of the POs (back orders) created
  (3)tblPurchaseLines.SeqNo: As it is possible to have the same
  product added twice with a different qty. SeqNo is unique
  within the purchaseOrder. All the backorders can use this
  field to identify the record.For getting the originaly
  ordered Qty of the product, we need to identify the product
  within the purchase order.
  The form has the PUrchaseOrderNumber-SeqNo field displayed at the top.
  Display the 'Original Qty Ordered' in the Grid for each Part. This
  is a calculated feild which gets the qty from the base PO.
  The focus is set to the next field when it receives the focus
  Lock the PO records for the qty if there is a backorder
  record exists for it. Lock the whole record except the invoice
  number and invoice date once if it is being invoiced.
  08/07/05  1.00.08 BJ   A PO Lines' qty will be locked when a BO is created for the PO
  The PO itself is locked when the payment is made(partially/fully)
  against to the PO.
  An attempt to change teh receivedQty in the locked PO should
  prompt the user about unlocking it
  if the backorder is created : Take a confirmation form the
  user and open the backorder record to change the qty.
  20/07/05  1.00.09 BJ   A product with ordered quantity 0 is allowed  in the PO.
  Confirmation taken before saving such record.
  22/07/05  1.00.10 BJ   Adding a new part to the PO should be allowed at any point
  before payment. If the BO exists for a PO, the shipped qty
  should be equal to the ordered qty.
  25/07/05  1.00.11 BJ   added new field newForeignxchangerate to store the exchange rate
  for the currency variation record.
  26/07/05  1.00.12 BJ   bug fixed :When Seqno is null in the table(for existing records).
  29/07/05  1.00.13 IJB  Added code to user lock supplier in ValidData.
  04/08/05  1.00.14 BJ   Before deleting the purchaseOrder lines check whether the serial
  number is already sold/hired.
  Serialnumber object is used to open the Serialnumber form.

  10/08/05  1.00.15 DSP  Made change in FormShow for use of ExceptionMagic.
  12/08/05  1.00.16 BJ   Serialno object inroduced. Serialno fieldtype is changed to mediumtext
  29/08/05  1.00.17 BJ   handled adding and refreshing new supplier when NotInList.
  31/08/05  1.00.18 IJB  Modified UpdateMe, was using wrong dataset when calling
  cboClientCloseUp.
  21/09/05  1.00.19 ISB  Modified Product Spec's to readonly by fIsPOLineLocked;
  11/10/05  1.00.20 DSP  Added 'ETA Date' and 10 custom fields.
  11/10/05  1.00.21 MV   Added cboBaseForeignCurrencyCodeCloseUp procedure.
  12/10/05  1.00.22 MV   Added Back Order Parameters
  19/10/05  1.00.23 DLS  Added RegisterClass
  11/11/05  1.00.24 DSP  The 'ETA Date' and 10 custom fields had been lost from
  the grid somehow. These have been re-entered.
  04/01/06  1.00.25 AL   Added new Search mode (like)
  Changed name of component "cboProduct" to "cboProductX"
  10/01/06  1.00.26 AL   Changed Search modes to use SearchEngineObj
  30/01/06  1.00.27 IJB  Added preference function FnEditPurchaseCost to prevent
  user from edit line cost.
  01/02/06  1.00.28 DSP  Added GuiPrefs calls.
  02/02/06  1.00.29 DSP  Rearranged fields in tbldetails.
  06/02/06  1.00.30 DSP  Product_Description field is visible again.
  09/02/06  1.00.31 DSP  Changed HiddenFields to HideField.
  06/04/06  1.00.32 AL   Added call of AddToPayAuthorisations on Save
  27/04/06  1.00.33 BJ   CboProductQry has LatestCostDate field added to its SQL
  When the PO is invoiced, the cost of the product is updated in the
  parts table using this field.
  15/05/06  1.00.34 BJ   1.confirmation added for deleting the line records
  2. Save Validation was reading th UOMQtyshipped as integer which kills
  the decimal part. Shanged to read as float
  26/05/06  1.00.45 BJ   PO object is implemented(the object was already there but was incompelte)
  10/07/06  1.00.46 BJ   closeonPrint preference is being removed, so the form is closed when
  printed.
  Error debuged- access violation on print/preview
  10/07/06  1.00.47 AL   Moved GuiPrefs depended field Addings e.g. "grdTransaction.AddField"
  to the bottom of fromshow, otherwise it did not work, becouse
  some property changes were reloading dataset and all added fields options were reset
  08/08/06  1.00.48 BJ   Finding an invalid line because of the incomplete bin/batch allocation
  while saving, will open the bin batch allocation form after the warning message
  14/08/06  1.00.49 BJ   Business object does the validation of orderdate which is compared with companypref.closing date
  So cboCreationDateExit is overiden as and ignore the inherited;
  15/08/06  1.00.50 BJ   BusObjqueries initialised in the formcreate for tblmaster and tbldetails
  PO and PO.Lines useing these tables.
  29/08/06  1.00.51 BJ   checking for the Write permission before deleting the blank lines from the address field
  Teh blank lines are deleted before saving as well(was only in onenter and exit of the GUI component).
  30/08/06  1.00.52 BJ   The PO used to be locked if there is BO created against to it.
  this is changed to lock all other than the last 2 in the group(Ward's change)

  BO fields in the PO
  __________________________________________________________
  | POID  | GlobalRef | POno  | OriginalNo |BaseNo |BOID   |
  |-------|-----------|-------|------------|-------|-------|
  | 110   | DEF110    | 110   | DEF110     |       |DEF111 |
  | 111   | DEF111    | 111   | DEF110     |       |DEF112 |
  | 112   | DEF112    | 112   | DEF110     |       |DEF113 |
  | 113   | DEF113    | 113   | DEF110     |       |       |
  ----------------------------------------------------------
  23/01/07  1.00.53 BJ   ShowStatus procedure and lblProcessmsg is moved to basetrans
  24/01/07  1.00.54 DSP  Added code to email to contact if one is selected.
  25/01/07  1.00.55 DSP  Now uses default purchase order template, if available,
  for printing.
  20/04/07 1.00.46 IJB  Removed calls to SetTerms, terms calcualtions are handled
  by PO business object logic.

}

Interface
{$I ERP.inc}


Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Order, DB, StdCtrls, wwcheckbox, wwdbdatetimepicker, wwdblook,
  DBCtrls, Mask, ExtCtrls, Buttons, DNMSpeedButton, BaseInputForm, DNMPanel,
  Grids, Wwdbgrid, ActnList, Menus, AdvMenus, BatchObj, ImgList,
  SelectionDialog, AppEvnts, wwdbedit, MemDS, DBAccess, MyAccess,
  ERPdbComponents, DataState, ForeignExchangeObj, Wwdbigrd, EmailUtils, DMComps,
  IdGlobal, BusObjOrders, busobjbase, Shader, dmGUIStylers, ProgressDialog,
  ERPDbLookupCombo, BactchReceiveObj, wwclearbuttongroup, wwradiogroup, AdvShape;

Const SX_ForeignCurrencyAdd = WM_USER + 110; SX_OpenPOofBO = WM_USER + 200;

Type
  TPurchaseGUI = Class(TBaseOrderGUI)
    txtSalesComments: TDBMemo;
    Label3: TLabel;
    cboETADate: TwwDBDateTimePicker;
    Label5: TLabel;
    cboInvoiceDate: TwwDBDateTimePicker;
    Label6: TLabel;
    edtBarcode: TEdit;
    Label9: TLabel;
    Bevel1: TBevel;
    Label10: TLabel;
    cmdIncudeLandeCost: TDNMSpeedButton;
    qryProduct: TERPQuery;
    lblEstimatedFinalAmt: TLabel;
    EstimatedFinalAmt: TLabel;
    dsTotals: TDataSource;
    actImportCosts: TAction;
    cboCostCentre: TwwDBLookupCombo;
    tblDetailsDocketNumber: TWideStringField;
    tblmasterPickupFromDesc: TWideStringField;
    tblDetailsCostCentreName: TWideStringField;
    tblDetailsCostCentreId: TIntegerField;
    qryPartsSpecs: TERPQuery;
    tblMasterSeqNo: TIntegerField;
    tblDetailsOriginalQtyOrdered: TFloatField;
    qryPOQuantities: TERPQuery;
    tblDetailsSEQNo: TIntegerField;
    qryPOQuantitiesProductId: TIntegerField;
    qryPOQuantitiesSeqNo: TIntegerField;
    qryPOQuantitiesQtySold: TFloatField;
    qryPONumber: TERPQuery;
    qryPONumberPurchaseOrderId: TAutoIncField;
    qryPONumberPurchaseOrderNumber: TWideStringField;
    tblMasterPONum_Seq: TWideStringField;
    edt_PONum_Seq: TDBText;
    tblDetailsNewForeignExchangeRate: TFloatField;
    tblDetailsBaseLineno: TIntegerField;
    tblMasterForeignExchangeCode: TWideStringField;
    tblMasterForeignExchangeRate: TFloatField;
    tblMasterForeignTotalAmount: TFloatField;
    tblMasterForeignPaidAmount: TFloatField;
    tblMasterForeignBalanceAmount: TFloatField;
    tblMastermsTimeStamp: TDateTimeField;
    tblDetailsForeignTotalLineAmount: TFloatField;
    tblDetailsmsTimeStamp: TDateTimeField;
    DNMPanel1: TDNMPanel;
    tblMasterApproved: TWideStringField;
    qryPONumberGlobalREf: TWideStringField;
    qryPONumberBaseNo: TWideStringField;
    lblProductReceiptsOnly: TLabel;
    tblDetailsLineNotes: TWideMemoField;
    tblDetailsINCOMEACCNTID: TIntegerField;
    tblDetailsASSETACCNTID: TIntegerField;
    tblDetailsCOGSACCNTID: TIntegerField;
    DataSource1: TDataSource;
    tblMasterOrgPONumber: TWideStringField;
    lblEmployeeExpenseClaim: TLabel;
    cboExpenseClaimEmployee: TwwDBLookupCombo;
    tblMasterExpenseClaimEmployee: TIntegerField;
    GroupProducts: TCheckBox;
    qryShipContainerLookup: TERPQuery;
    tblDetailsShipContainerName: TWideStringField;
    tblDetailsSaleLineID: TIntegerField;
    tblmasterPickUpfromID: TIntegerField;
    tblmasterShiptoClassID: TIntegerField;
    tblDetailsShipContainerETA: TDateField;
    edShipContainerETA: TwwDBEdit;
    tblMasterSalesglobalref: TWideStringField;
    tblMasterShipToCustomer: TWideStringField;
    tblDetailsProcTreeId: TIntegerField;
    tblDetailsPrintedValue: TFloatField;
    tblDetailsDiscountPercent: TFloatField;
    btndiscount: TDNMSpeedButton;
    Label2: TLabel;
    Bevel5: TBevel;
    tblMasterTotalDiscount: TFloatField;
    tblDetailsDiscountAmount: TFloatField;
    edtTotalDiscount: TDBEdit;
    tblDetailsOriginalCost: TFloatField;
    tblDetailscOriginalCost: TFloatField;
    lblEstimatedForeignAmt: TLabel;
    EstimatedForeignAmt: TLabel;
    DNMPanel3: TDNMPanel;
    Label8: TLabel;
    CustPONumber: TDBEdit;
    txtConsignmentNotes: TDBMemo;
    Label12: TLabel;
    lblShipTitle: TLabel;
    lblOrdTitle: TLabel;
    lblBO: TLabel;
    lblShipped: TLabel;
    lblOrdered: TLabel;
    Bevel2: TBevel;
    edtLineNotes: TwwDBEdit;
    ProductStatus1: TMenuItem;
    PrintStoreAwaySlip1: TMenuItem;
    tblDetailsSmartOrderID: TIntegerField;
    tblDetailsSmartOrderLineID: TIntegerField;
    mnuSalesOrder: TMenuItem;
    mnuInvoice: TMenuItem;
    btnfix: TButton;
    btnCopy: TDNMSpeedButton;
    tblMasterEquipmentId: TIntegerField;
    tblMasterEquipmentName: TWideStringField;
    cboEquipmentLookup: TERPQuery;
    cboEquipmentLookupEquipmentName: TWideStringField;
    cboEquipmentLookupEquipmentDescription: TWideStringField;
    cboEquipmentLookupEquipmentID: TIntegerField;
    cboEquipmentLookupProductID: TLargeintField;
    cboEquipmentLookupModel: TWideStringField;
    cboEquipmentLookupManufacture: TWideStringField;
    tblMasterShipToId: TIntegerField;
    tblMastermsUpdateSiteCode: TWideStringField;
    edtBatch: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    btnPrepayment: TDNMSpeedButton;
    actPrepayment: TAction;
    tblDetailsStandardCost: TFloatField;
    dtDueDate: TwwDBDateTimePicker;
    Label15: TLabel;
    Label4: TLabel;
    cboEquipment: TERPDbLookupCombo;
    mnuAllocateSerialNumberstoHire: TMenuItem;
    DNMSpeedButton1: TDNMSpeedButton;
    actConvertToAsset: TAction;
    tblDetailsGeneralNotes: TWideMemoField;
    tblDetailsLineDescription: TWideStringField;
    cboProductQryGeneralNotes: TWideMemoField;
    tblDetailsSellPrice: TFloatField;
    tblMasterFuturePO: TWideStringField;
    tblDetailsBoxesReceived: TIntegerField;
    tblDetailsBoxesOrdered: TIntegerField;
    pnlFutureOrder: TDNMPanel;
    chkFuturePO: TdbCheckBox;
    N3: TMenuItem;
    mnuCopyDocketNumbers: TMenuItem;
    mnuPasteDocketNumbers: TMenuItem;
    N4: TMenuItem;
    dsPurchaseLinePackWeightLinesSum: TDataSource;
    QryPurchaseLinePackWeightLinesSum: TERPQuery;
    tblDetailsPackWeightField1: TFloatField;
    tblDetailsPackWeightfield2: TFloatField;
    tblDetailsPackCount: TFloatField;
    QryPurchaseLinePackWeightLinesSumPurchaseOrderId: TIntegerField;
    QryPurchaseLinePackWeightLinesSumPurchaseLineId: TIntegerField;
    QryPurchaseLinePackWeightLinesSumAttribValue1: TFloatField;
    QryPurchaseLinePackWeightLinesSumAttribValue2: TFloatField;
    QryPurchaseLinePackWeightLinesSumPackcount: TFloatField;
    mnuCreateReturnAuthority: TMenuItem;
    QryProductsellPrice: TERPQuery;
    QryProductsellPricepartsId: TIntegerField;
    QryProductsellPricePRICE1: TFloatField;
    qryCostCentre: TERPQuery;
    tblMasterLinkPOref: TWideStringField;
    txtShipTo: TDBMemo;
    btnPickUpFrom: TDNMSpeedButton;
    lblPickUpFrom: TLabel;
    tblMasterShipToDefaultAddress: TWideStringField;
    tblMasterShipToClass: TWideStringField;
    DNMPanel6: TDNMPanel;
    chkShipToClass: TDBCheckBox;
    chkShipToCustomer: TDBCheckBox;
    chkShipToDefaultAddress: TDBCheckBox;
    pnlApproved: TDNMPanel;
    chkApproved: TwwCheckBox;
    tblMasterApproverID: TIntegerField;
    tblMasterSOApprovedBy: TIntegerField;
    tblMasterCreatedFromSO: TIntegerField;
    tblMasterIsRefundCheque: TWideStringField;
    tblMasterRefundGlobalref: TWideStringField;
    tblMasterAPNotes: TWideMemoField;
    tblMasterRARef: TWideStringField;
    tblMasterSaleLineRef: TWideStringField;
    tblMasterSignature: TBlobField;
    tblMasterSignatureTime: TDateTimeField;
    tblMasterContractorPayment: TWideStringField;
    Label7: TLabel;
    qryPOSeqno: TERPQuery;
    qryPOSeqnoSeqNo: TLargeintField;
    qryPurchaseLookup: TERPQuery;
    Procedure btnCompletedClick(Sender: TObject);
    Procedure FormShow(Sender: TObject);
    Procedure txtShipToDblClick(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure FormDestroy(Sender: TObject);
    Procedure tblMasterInvoiceNumberChange(Sender: TField);
    Procedure tblMasterInvoiceNumberGetText(Sender: TField; Var Text: String; DisplayText: Boolean);
    // procedure cboProductXCloseUp(Sender: TObject; LookupTable,
    // FillTable: TDataSet; modified: Boolean);
    Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
    Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    Procedure cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    //Procedure cmdEmailClick(Sender: TObject);
    Procedure FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure edtBarcodeKeyPress(Sender: TObject; Var Key: Char);
    Procedure edtBarcodeEnter(Sender: TObject);
    Procedure txtInvNumberChange(Sender: TObject);
    Procedure grdTransactionsEnter(Sender: TObject);
    Procedure tblDetailsForeignCurrencyLineCostChange(Sender: TField);
    Procedure actPreviewExecute(Sender: TObject);
    Procedure btnDeleteClick(Sender: TObject);
    Procedure actPrintExecute(Sender: TObject);
    Procedure cboInvoiceDateChange(Sender: TObject);
    Procedure cmdFaxClick(Sender: TObject);
    Procedure txtInvNumberExit(Sender: TObject);
    Procedure edtCompanySearchFilterExit(Sender: TObject);
    Procedure tmrRequesterTimer(Sender: TObject);
    Procedure cboInvoiceDateExit(Sender: TObject);
    Procedure grdTransactionsRowChanged(Sender: TObject);
    Procedure actImportCostsExecute(Sender: TObject);
    Procedure grdTransactionsFieldChanged(Sender: TObject; Field: TField);
    Procedure tblDetailsForeignExchangeCodeChange(Sender: TField);
    Procedure cboCostCentreCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    Procedure cboCostCentreNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: Boolean);
    Procedure tblDetailsCostCentreIdSetText(Sender: TField; Const Text: String);
    Procedure grdTransactionsDrawFooterCell(Sender: TObject; Canvas: TCanvas; FooterCellRect: TRect; Field: TField; FooterText: String; Var DefaultDrawing: Boolean);
    Procedure grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: String);
    Procedure cboPartSpecsEnter(Sender: TObject);
    Procedure cboPartSpecsNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: Boolean);
    Procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    Procedure tblDetailsCalcFields(DataSet: TDataSet);
    Procedure tblMasterCalcFields(DataSet: TDataSet);
    Procedure grdTransactionsColEnter(Sender: TObject);
    Procedure grdTransactionsKeyPress(Sender: TObject; Var Key: Char);
    Procedure tblDetailsUnitofMeasureQtySoldChange(Sender: TField);
    Procedure cboBaseForeignCurrencyCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    Procedure cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    Procedure cboTaxCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    Procedure cboUnitOfMeasureCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    Procedure FormKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure cboCreationDateExit(Sender: TObject);
    Procedure grdTransactionsExit(Sender: TObject);
    Procedure txtShipToExit(Sender: TObject);
    Procedure txtShipToEnter(Sender: TObject);
    Procedure QuantityAndBinLocations1Click(Sender: TObject);
    Procedure cboExpenseClaimEmployeeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    Procedure cboExpenseClaimEmployeeExit(Sender: TObject);
    Procedure edtBaseExchangeRateExit(Sender: TObject);
    Procedure edShipContainerETADblClick(Sender: TObject);
    Procedure grdTransactionsCalcTitleAttributes(Sender: TObject; AFieldName: String; AFont: TFont; ABrush: TBrush; Var ATitleAlignment: TAlignment);
    Procedure tblDetailsForeignTotalLineAmountSetText(Sender: TField; Const Text: String);
    Procedure actCustomerContactsExecute(Sender: TObject);
    Procedure btnCloseClick(Sender: TObject);
    Procedure grdTransactionsDblClick(Sender: TObject);
    Procedure txtCustomIDDblClick(Sender: TObject);
    Procedure btndiscountClick(Sender: TObject);
    Procedure tblDetailsAfterInsert(DataSet: TDataSet);
    Procedure cboETADateCloseUp(Sender: TObject);
    procedure cboProductRAfterchange(Sender: TObject);
    procedure PrintStoreAwaySlip1Click(Sender: TObject);
    procedure tblMasterPurchaseOrderNumberSetText(Sender: TField;
      const Text: string);
    procedure grdTransactionsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure OverrideAccessLevel(Sender: TObject);
    procedure tblMasterAfterOpen(DataSet: TDataSet);
    procedure mnuSalesOrderClick(Sender: TObject);
    procedure mnuInvoiceClick(Sender: TObject);
    procedure btnfixClick(Sender: TObject);
    procedure btnPDFClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure chkShipTocustomer1Click(Sender: TObject);
    procedure edtBatchKeyPress(Sender: TObject; var Key: Char);
    procedure actPrepaymentExecute(Sender: TObject);
    procedure btnPaymentsClick(Sender: TObject);
    procedure mnuAllocateSerialNumberstoHireClick(Sender: TObject);
    procedure actConvertToAssetExecute(Sender: TObject);
    procedure chkApprovedClick(Sender: TObject);
    procedure dtDueDateExit(Sender: TObject);
    procedure dtDueDateEnter(Sender: TObject);
    procedure chkFuturePOClick(Sender: TObject);
    procedure tblDetailsAfterScroll(DataSet: TDataSet);
    procedure mnuPasteDocketNumbersClick(Sender: TObject);
    procedure mnuCopyDocketNumbersClick(Sender: TObject);
    procedure cboClientLookupAfterOpen(DataSet: TDataSet);
    procedure tblDetailsAfterClose(DataSet: TDataSet);
    procedure tblMasterBeforeOpen(DataSet: TDataSet);
    procedure edtMemoLineDblClick(Sender: TObject);
    procedure edtLineNotesDblClick(Sender: TObject);
    procedure mnuCreateReturnAuthorityClick(Sender: TObject);
    procedure btnPickUpFromClick(Sender: TObject);
    procedure chkShipToClassClick(Sender: TObject);
    procedure chkShipToCustomerClick(Sender: TObject);
    procedure chkShipToDefaultAddressClick(Sender: TObject);
    procedure cboShippingContainerCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboShippingContainerChange(Sender: TObject);
    procedure tblDetailsETADateChange(Sender: TField);

    Private
      { Private declarations }
      fxtotex ,    fxtotinc ,   fxTax: double;
      iCustomerID             : Integer;
      bLineDeleted            : Boolean;
      bForeignCodeUpdated     : Boolean;
      bPartSelected           : Boolean;
      bInitialiseStartup      : Boolean;
      fbForeignCurrencyChanged: Boolean;
      (* PreferedSupp            : Word; *)
      (* PreferedSuppCost        : Word; *)
      (* fbShowingOrClosing      : Boolean; *)
      fbGoodsReceived         : Boolean;
      fbbingoodsReceived      : Boolean;
      BatchObj                : tBatchObj;
      fIsLandedCosts          : Boolean;
      (* HoldPreferedSuppCost    : Boolean; *)
      fFxObj                  : TForeignExchangeObj;
      fNewRec                 : Boolean;
      fPassedConnection       : TERPConnection;
      PrefSuppList            : TStringList;
      fPrintBarCodesMode      : String;
      InvoiceToOpen           : Integer;
      SOToOpen                : Integer;
      fiProctreeId: Integer;
      KeysPressed:String;
      fBactchReceive: TBatchReceive;
      fbconfirmtoautoloadHireProducts: boolean;
      fInFormShow: boolean;
      fNeedEmailOnSave: boolean;
      fDoEmail: boolean;
      fDoEmployee: boolean;
      qryTemp: TERPQuery;
      fOldDueDate: TDateTime;
    fbdoSavenclosinOpen: Boolean;
      //fbhasPackWeightfield ,fbhasPackCount : Boolean;

      Procedure SetIsLandedCosts(Const Value: Boolean);
      function StoreAwayslipSQL(LineIDs:String=''): String;
      procedure beforeshowSupplierCreditListGUI(Sender: TObject);
      function ValidateInvoiceDate:Boolean;
      procedure Shiptodept(Sender: TwwDbGrid);
      procedure UseAddressClasslist(Sender: TObject);
      procedure MakeEquipmentPartsLines(const Sender: TBusObj; var Abort: Boolean);
      procedure OnEquipemntchange;
      procedure PrintBatchBarcodes(Sender:TObject);
      procedure DoChangeShippingContainer(Sender: TObject);
      procedure DonOnShippingContainerSelect(Sender: TwwDbGrid);
      procedure DoCopyValuesForSelectedRows(Value: TDateTime);
      procedure DoPrintBarcodes(Sender:TObject);
      procedure PrintProductLabels(Sender : TObject);overload;
      procedure PrintProductLabels(aPurchaseOrderId : integer; aProductId : integer = 0);overload;
      procedure PrintBoxLabels(ALine : TPurchaseOrderLine);
      procedure LoadEquipProducts;
      procedure initSerialsAllocatedInPO(Sender: Tobject);
      procedure OnSelectSerialsAllocatedInPO(Sender: TwwDbGrid);
      procedure OnSerialsAllocatedInPOMultiselect(Grid: TwwDBGrid;
        Selecting: Boolean; var Accept: Boolean);
      procedure DoPackWeight;
      procedure initProductQtyBinETA(Sender: TObject);
      procedure Doimportcost;
      procedure ShowPickupFromHint;



      Property IsLandedCosts: Boolean
        Read   fIsLandedCosts
        Write  SetIsLandedCosts;
      Procedure SetPurchaseOrderState(Const InvNum: String);
      Procedure PrintBarcodes(Const FromOrdered: Boolean);
      Function QtyforBarcodeprinting(FromOrdered: Boolean): Integer;
      Procedure CreateBackOrderReminder;


      Procedure MatchBarcode(Const sBarcode: String);
//      Procedure AssignLandedCosts(Const TotalLandedCost: Double);
      Procedure RemoveLandedCosts;
      Procedure UpdateProductLatestCosts;
      Procedure LockPO;
      Procedure SetComboFocus(Var Msg: TMessage); Message TX_SetFocus;
      Function SavePO: Boolean;
      Procedure OpenPOOfBO(Var Msg: TMessage); Message SX_OpenPOofBO;
      Procedure UpdatePrefSupp;
      Procedure ProcessBackOrderItems;
      Procedure HandlePurchaseErrors;
      Procedure OpenPO(Const boid: String);
      Procedure ApplyDiscountPercent(Const Sender: TBusObj; Var Abort: Boolean);
      Procedure DoPOMatchLineETAToHeaderETA(Const Sender: TBusObj; Var Abort: Boolean);
      procedure DoAllReceivedIterate(const Sender : TBusObj; var Abort : boolean);
      Procedure CalcAll(Const Sender: TBusObj; Var Abort: Boolean);
      function PrintStowAway: boolean;
      function SendPrintEmailSilent: boolean;
      function SendPrintEmail: boolean;
      function SendPrintSMSSilent: boolean;
      function SendPrintSMS: boolean;
      procedure SendCreateEmail;
      procedure DoOnAddressListGridDataSelect(Sender: TwwDbGrid);
      procedure OpenPrepayList;
      procedure OrderPrepaymentBeforeOpen(Sender: TObject);
      function HasLinkedPrepayments: boolean;
      function HasPayments: boolean;
      Procedure CheckForSNEquipmentnAllocateForHire;
      property NeedEmailOnSave : boolean read fNeedEmailOnSave write fNeedEmailOnSave;
      procedure OpenPOChangeApproval(Sender: TObject);
      //Procedure MakepackweightFields(Lookupds :Tdataset);
      procedure BeforePurchaseOrderChangeShow(Sender: TObject);
    Protected
      // SE : TSearchEngineObj;
      function EmailTransaction(const RecipientAddress :String ='';ASilent: boolean=True; ASecret : boolean=True): boolean;Override;
      Procedure PrintReport(Const ReportName: String; Const bPrint: Boolean);
      Function GetReportTypeID: Integer; Override;
      Function FxObj: TForeignExchangeObj;
      Procedure CompleteComboNotInList(Const aObserver: TObject); Override;
      Procedure AfterCommit; Override;
      Procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; Const EventType, Value: String); Override;
      Function Saverecord: Boolean; Override;
      Procedure ShowForeignCurrencycomponnets; Override;
      Procedure LoadTransRec; Override;
      procedure DoOnProductchange;Override;
      function ValidData: boolean; override;
      Function IstransLineLocked: Boolean;Override;
      function IsOktodeleteLine: Boolean; Override;
      Function IstransLineCostLocked: Boolean;
      Procedure ShowControlhints;Override;
      Procedure CommitAndNotify;Override;
      procedure SkipReadonlyfield;Override;
      function TransStatustype:String;Override;
      procedure NewTransBusObjinstance;override;
      Procedure AddExtraMenuItems;override;
      procedure AfterSubFormShow(Sender: TObject); override;
      function CanEditTransPricenCost:Boolean;Override;
      function SaveTrans:Boolean ; Override;

      procedure CopyDocketnoToClipboard;
      procedure ImportDocketnoFromClipBoard;

      property InFormShow : boolean read fInFormShow write fInFormShow;
      property DoEmail : boolean read fDoEmail write fDoEmail;
      property DoEmployee : boolean read fDoEmployee write fDoEmployee;
      property OldDueDate : TDateTime read fOldDueDate write fOldDueDate;
      Procedure OnGuiPrefsActive(Sender :TObject);Override;
      procedure SetDatasetconn;Override;
      Procedure AfterFormShow; Override;
      Function IsPOLocked: Boolean;Virtual;
      function Save4NewTrans: Boolean;Override;
    Public
      PO: TPurchaseOrder;
      Class Procedure CloseMe; Override;
      (* Property QPreferedSupp: Word        Read   PreferedSupp        Write  PreferedSupp; *)
      Property CustomerID: Integer        Read   iCustomerID        Write  iCustomerID;
      Property InitialiseStartup: Boolean        Read   bInitialiseStartup        Write  bInitialiseStartup;
      Procedure UpdateMe(Const Cancelled: Boolean; Const aObject: TObject = Nil); Override;
      Property PassedConnection: TERPConnection        Read   fPassedConnection        Write  fPassedConnection;
      Procedure UpdateExchangeRate;
      Property ProctreeId :Integer read fiProctreeId write fiProctreeId ;
      Property confirmtoautoloadHireProducts :boolean read fbconfirmtoautoloadHireProducts write fbconfirmtoautoloadHireProducts;
      Property doSavenclosinOpen: Boolean read fbdoSavenclosinOpen write fbdoSavenclosinOpen;
      Procedure MakeLinkPO(aLinkPORef:String);
      Function MakeaStSOrder:Boolean;
  End;

Implementation
{$R *.dfm}
Uses FormFactory, ShipAddressListForm, DNMLib, StrUtils, DateUtils,
  BackOrderListForm, DNMExceptions, CommonDbLib, ImportCostForm, FaxObj, QueryManipulationObj, GlobalEventsObj, BaseTransForm, CommonLib, tcDataUtils, BusObjConst, frmSupplier, frmProductQtyBinGUI,
  AppEnvironment, FastFuncs, BusObjTrans, frmAllocation, ProductQtyLib, frmShippingContainerListGUI, frmProductQtysBinsETAs, frmShippingContainerGUI, BaseListingForm, BusObjShippingContainer,
  BusObjSaleBase, BusObjSales, BusObjStock, BaseFormForm, frmStockStatus, BusObjCurrency, tcTypes, BusObjPrintDoc, MemoDialog,
  CommonFormLib, SupplierCreditList, MySQLConst, BusObjClass,
  SMSUtils, tcconst, frmReportingOptions, XMLEmailObj, BusObjEquipment,
  busobjAreaCodes, IdFTP, URLObj, BusObjShippingAddress, frmDelayMessageDlg,
  DbSharedObjectsObj, TemplateReportsLib, ProductQtylist, LogLib,
  frmSuppPrepayments, OrderPrepayments, CorrespondenceObj,
  ProductSerialNumbersForHire, frmPurchasePackWeight, frmStockToFixedAsset, BusObjApprovals,
  EmailExtraUtils, Clipbrd, BackOrderSOForm, frmSuppPayments,
  frmPurchaseOrderChange, frmPickupFromAddressPopup , IntegerListobj;

Const
  PO_STATE: Array [0 .. 2] Of String = ('', 'Product Receipt Only', 'Invoice Received');
  TODO_REMINDER: String = 'Goods received for Back Orders(s). Check Purchase Order # %s ' + 'for details.';

Procedure TPurchaseGUI.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
  // If user does not have access to this form don't process any further
  If ErrorOccurred then Exit;

  CanClose := False;
  If PO.Dirty then begin
    Case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) Of
      mrYes: Begin
          If SavePO then begin
            CanClose := true;
          End;
        End;
      mrNo: Begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          PO.Dirty := False;
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

End;

Procedure TPurchaseGUI.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
  Inherited;
  Action             := caFree;
  (* fbShowingOrClosing := true; *)
End;

Procedure TPurchaseGUI.PrintReport(Const ReportName: String; Const bPrint: Boolean);
Var sSQL: String;
Begin
  sSQL := Format('AND PO.PurchaseOrderID = %d ORDER BY P.PartName', [tblMasterPurchaseOrderID.asInteger]);

  sSQL := Format('AND PO.PurchaseOrderID = %d ORDER BY P.PartName', [tblMasterPurchaseOrderID.asInteger]);

  PrintTemplateReport(ReportName, sSQL, bPrint, 1);
End;

procedure TPurchaseGUI.PrintStoreAwaySlip1Click(Sender: TObject);
var
  sIds:String;
  SQL:String;
begin
  inherited;
  if PO.lines.count = 0 then exit;
  sIds:= SelectedIDs(grdTransactions , 'purchaseLineID');
  if sIds = '' then
    if MessageDlgXP_Vista('You haven''t selected the products to print the ''Store Away Slip'' for. Do you wish to Print All Products?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  SQL:=StoreAwaySlipSQL(sIds);
  fbReportSQLSupplied := true;
  Try
    ReportToPrint:= tcdatautils.GetDefaultReport(102);
    if ReportToPrint = '' then ReportToPrint := 'Store Away Slip';
    PrintTemplateReport(ReportToPrint, SQL, Not AppEnv.Employee.ShowPreview, 1);
    PO.Printdoc.Printdoc(PO.classname, PO.ID, dtStawySlip, Self.classname, PreviewToDocumentOutputType(AppEnv.Employee.ShowPreview) , ReportToPrint);
  Finally
    fbReportSQLSupplied := False;
  End;

end;

function TPurchaseGUI.PrintStowAway: boolean;
begin
  result := false;
  If Not SavePO then Exit;
  Try
    Self.CommitAndNotify;
    Try
      GroupReportByClass := GroupProducts.Checked;
      ReportToPrint      := Appenv.companyPrefs.POStoreAwayTemplate;
      if ReportToPrint = '' then ReportToPrint      := 'Purchase Order (Store Away)';
      PO.Dirty := False;
      chkChooseRpt.Checked:= False;
      Inherited actPreviewExecute(actPreview);
      result := true;
    Finally
      Self.BeginTransaction;
    End;
  Except
    On e: Exception Do Begin
      CommonLib.MessageDlgXP_Vista('Print failed.' + chr(13) + chr(13) + e.message, mtWarning, [mbOk], 0);
      Self.BeginTransaction;
    End;
  End;
end;

Class Procedure TPurchaseGUI.CloseMe;
Begin
  If FormStillOpen('TPurchaseGUI') then begin
    TPurchaseGUI(FindExistingComponent('TPurchaseGUI')).Close;
    Application.ProcessMessages;
  End;
End;

Function TPurchaseGUI.SavePO: Boolean;
var
  msgTo: string;

  // Need local thing since we are creating SALES e-mails from Purchase
  procedure PopulateMessageSubstituteList(sl : TStringList);
  var
  s: string;
  qry : TERPQuery;
begin

  qry := TERPQuery.Create(nil);
  try
    qry.Connection := tblDetails.Connection;
  s:=
    'Select p.PurchaseOrderId ,  ' +
    ' C.FirstName, ' +
    ' S.ShipTo, ' +  // SO Address
    ' concat(PL.Productname ,"     : Shipped " ,  PL.UnitofMeasureShipped , "  of  " , PL.QtySold, " ",    concat(PL.UnitofMeasurePOLines , " (" , PL.UnitofMeasureMultiplier , ")" )) details, ' +
    ' S.SaleId ' +
    ' from tblpurchaseorders p ' +
    ' inner join tblpurchaselines PL on P.PurchaseOrderId = PL.PurchaseOrderId   ' +
    ' inner join tblclients c on c.clientId = p.clientID' +
    ' inner join tblSales S on p.SalesGlobalRef = s.GlobalRef ' +
    ' where P.PurchaseOrderId = ' + tblMasterPurchaseOrderId.AsString;

    qry.SQL.Text := s;
    qry.Open;

    SL.Values['#POID#'] := tblMasterPurchaseOrderId.AsString;
    SL.Values['#SaleId#'] := qry.FieldByName('SaleId').AsString;
    SL.Values['#ShippingAddress#'] := qry.Fieldbyname('ShipTo').asString;
    SL.Values['#Products#'] := qry.Groupconcat('Details' , '' , False, #13#10 );
    SL.Values['#FirstName#'] := qry.Fieldbyname('FirstName').asString;
  finally
    qry.Free;
  end;
end;

  procedure SendMessageToCust(AEmployee : boolean = false);
  var
    Inv: TInvoice;
    SO: TSalesOrder;
    qry : TERPQuery;
    id : integer;
    lInvoiceToMail,
    lSOToMail : integer;
    sl : TStringList;
    EmployeeEmail : string;
  begin
    lInvoiceToMail :=  0;
    lSOToMail := 0;
    if (DoEmail and ((InvoiceToOpen=0) and (SOToOpen=0))) or AEmployee then
    begin
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := tblDetails.Connection;
//        qry.SQL.Text := 'select tblClients.Email from tblClients inner join tblSales on tblSales.ClientId=tblClients.ClientId ' +
//        'where tblSales.GlobalRef=' + tblMasterSalesGlobalRef.asString;
        //qry.SQL.Text := 'select IsInvoice, IsSalesOrder, SaleId from tblSales where tblSales.GlobalRef="'+ tblMasterSalesGlobalRef.asString + '"';
        qry.SQL.text := 'Select distinct S.IsInvoice, S.IsSalesOrder, S.SaleId ' +
                        ' from tblSales S ' +
                        ' inner join tblsaleslines SL on S.saleId = SL.saleId ' +
                        ' inner join tblpurchaselines PL on SL.saleLineId = PL.SaleLineId and PL.purchaseorderId = ' + inttostr(PO.ID)+
                        ' where ifnull(PL.SaleLineId,0)>0;';
        qry.Open;
        if qry.RecordCount > 0 then
          if qry.FieldByName('IsInvoice').AsString = 'T' then
            lInvoiceToMail := qry.FieldByName('SaleId').AsInteger
          else if qry.FieldByName('IsSalesOrder').AsString = 'T' then
            lSOToMail := qry.FieldByName('SaleId').AsInteger;
        qry.Close;
        if AEmployee then
        begin
          qry.SQL.Text := 'select email from tblemployees where employeeid=' + tblMasterEmployeeID.AsString;
          qry.Open;
          EmployeeEmail := qry.Fields[0].AsString;
        end;
      finally
        qry.Free;
      end;
    end;

    if (InvoiceToOpen <> 0) or (lInvoiceToMail <> 0) then
    begin
      id := lInvoiceToMail;
      if id = 0 then
        id := InvoiceToOpen;
      Inv:= TInvoice.Create(nil);
      try
        Inv.Connection := TMyDacDataConnection.Create(Inv);
        Inv.Connection.Connection := tblDetails.Connection; //CommonDbLib.GetSharedMyDacConnection;

//        Inv.Load(InvoiceToOpen,true);
        inv.Load(id, true);

        sl := TStringList.Create;
        try
          PopulateMessageSubstituteList(sl);

          if AEmployee then
            msgTo := EmployeeEmail
          else
          begin
            msgTo := Inv.ContactEmail;
            if msgTo = '' then msgTo := Inv.Customer.Email;
          end;

          if ((not AEmployee and (AppEnv.CompanyPrefs.EnablePOReceiveInvEmail or AppEnv.CompanyPrefs.EmailCustomerOnReceipt))
             or (AEmployee and AppEnv.CompanyPrefs.EmailEmployeeOnReceipt))
//             and ((Inv.ContactEmail <> '') or (Inv.Customer.Email <> '')) then
             and (msgTo <> '') then
          begin

            if msgTo = '' then
              exit;

            if AEmployee then
              TCorrespondenceGui.EmailEmployee(msgTo,
                TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POReceiveInvEmailSubject, sl),
                TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POReceiveInvEmailText, sl),
                tblMasterEmployeeId.asInteger, true)
            else
              TCorrespondenceGui.EmailCustomer(msgTo,
                TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POReceiveInvEmailSubject, sl),
                TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POReceiveInvEmailText, sl),
                Inv.CustomerID, true);
        end;

        if AppEnv.CompanyPrefs.SMSEnabled and
           AppEnv.CompanyPrefs.EnablePOReceiveInvSMS and
           not AEmployee and
           ((Inv.ContactMobile <> '') or (Inv.Customer.Mobile <> '')) then
        begin
          { send SMS silently }

          msgTo := Inv.ContactMobile;
          if msgTo = '' then msgTo := Inv.Customer.Mobile;

          { send SMS silently }
          TCorrespondenceGui.SMSCustomer(msgTo,
//            TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POReceiveInvSMSText, PopulateMessageSubstituteList),
            TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POReceiveInvSMSText, sl),
            Inv.CustomerID, true);
        end;
        finally
            sl.Free;
        end;
      finally
        Inv.Free;
      end;
    end;

    if (SOToOpen <> 0) or (lSOToMail <> 0) then
    begin
      SO:= TSalesOrder.Create(nil);
      try
        SO.Connection := TMyDacDataConnection.Create(SO);
        SO.Connection.Connection := tblDetails.Connection;   // CommonDbLib.GetSharedMyDacConnection;
        id := lSOToMail;
        if id = 0 then
          id := SOToOpen;
//        SO.Load(SOToOpen,true);
        SO.Load(id, true);
        sl := TStringList.Create;
        try
          PopulateMessageSubstituteList(sl);
          if AEmployee then
            msgTo := EmployeeEMail
          else
          begin
            msgTo := SO.ContactEmail;
            if msgTo = '' then msgTo := SO.Customer.Email;
          end;

//          if (AppEnv.CompanyPrefs.EnablePOReceiveSOEmail or AppEnv.CompanyPrefs.EmailCustomerOnReceipt or (AEmployee and AppEnv.CompanyPrefs.EmailEmployeeOnReceipt))
//             and ((SO.ContactEmail <> '') or (SO.Customer.Email <> '')) then
          if ((not AEmployee and (AppEnv.CompanyPrefs.EnablePOReceiveInvEmail or AppEnv.CompanyPrefs.EmailCustomerOnReceipt))
             or (AEmployee and AppEnv.CompanyPrefs.EmailEmployeeOnReceipt))
             and (msgTo <> '') then
          begin
            if AEmployee then
              TCorrespondenceGui.EmailEmployee(msgTo,
                TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POReceiveSOEmailSubject, sl),
                TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POReceiveSOEmailText, sl),
                tblMasterEmployeeId.asInteger, true)
            else
              TCorrespondenceGui.EmailCustomer(msgTo,
                TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POReceiveSOEmailSubject, sl),
                TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POReceiveSOEmailText, sl),
                SO.CustomerID, true);
          end;

          if AppEnv.CompanyPrefs.SMSEnabled and
             AppEnv.CompanyPrefs.EnablePOReceiveSOSMS and
             not AEmployee and
             ((SO.ContactMobile <> '') or (SO.Customer.Mobile <> '')) then
          begin
            msgTo := SO.ContactMobile;
            if msgTo = '' then msgTo := SO.Customer.Mobile;

            { send SMS silently }
            TCorrespondenceGui.SMSCustomer(msgTo,
//            TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POReceiveSOSMSText, PopulateMessageSubstituteList),
              TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POReceiveSOSMSText, sl),
              SO.CustomerId, true);
        end;
        finally
            sl.Free;
        end;
      finally
        SO.Free;
      end;
    end;
  end;

Begin
  result := true;
  { readonly access doesn;t allow editing , so nothing should be there to be saved, so just ignore the process }
  SetControlFocus(btnCompleted);
  If accesslevel >= 5 then begin
    PO.CancelDB;
    PO.Dirty := False;
    Exit;
  End;

  If PO.Dirty then begin
    Processingcursor(True);
    TRy
      PO.Lines.PostDB;
      PO.PostDB;

      if AppEnv.CompanyPrefs.EmailCustomerOnReceipt and (*(tblMasterSalesGlobalRef.AsString<> '') *) (PO.lines.SaleLineId =0) then
      begin
        DoEmail := true;
        DoEmployee := false;
        qryTemp := TERPQuery.Create(nil);
        try
          qryTemp.Connection := GetSharedMyDacConnection;
          qryTemp.SQL.Text := 'select PurchaseLineId, ProductId, QtySold, Shipped from tblPurchaseLines where PurchaseOrderId=' + tblMasterPurchaseOrderId.AsString;
          qryTemp.Open;
          PO.Lines.IterateRecords(DoAllReceivedIterate);
          if DoEmail then
            SendMessageToCust;
          if DoEmployee then
            SendMessageToCust(true);
        finally
          qryTemp.Free;
        end;
      end;


      TfmSupplier.CloseMe; // This Is To Stop Lock Timeout Errors
//      PO.Validated := true;
      If Not PO.Save then begin
        result := False;
        Exit;
      End;
      PO.Validated := False;
      PO.Dirty     := False;
      CommitAndNotify;
      If assigned(Self.Owner) And (Self.Owner Is TfmStockStatus) Then
      Else Begin
        If InvoiceToOpen <> 0 then
        begin
          if not DoEmail then
            SendMessageToCust;
          If FormStillOpen('TInvoiceGUI') Then
              CommonLib.MessageDlgXP_Vista('Invoice #' + IntToStr(InvoiceToOpen) + ' is updated. Can''t open the Invoice for as it is already open.', mtInformation, [mbOk], 0)
          Else
            With TBaseInputGUI(GetComponentByClassName('TInvoiceGUI', true)) Do Begin
              keyId     := InvoiceToOpen;
              formstyle := fsMDIChild;
              bringtoFront;
              Application.ProcessMessages;
            End;
        End
        Else If SOToOpen <> 0 then
        begin
          if not DoEmail then  // was not send
            SendMessageToCust;
          If FormStillOpen('TSalesOrderGUI') Then
              CommonLib.MessageDlgXP_Vista('Sales Order #' + IntToStr(SOToOpen) + ' is updated. Can''t open the Sales Order form as it is already open.', mtInformation, [mbOk], 0)
          Else
            With TBaseInputGUI(GetComponentByClassName('TSalesOrderGUI', true)) Do Begin
              keyId     := SOToOpen;
              formstyle := fsMDIChild;
              bringtoFront;
              Application.ProcessMessages;
            End;
        End;
      End;
      (* BeginTransaction; *)
      PO.Dirty            := False;
    Finally
      Processingcursor(False);
      PO.ResultStatus.Clear;
    End;
  End;
End;

Procedure TPurchaseGUI.btnCompletedClick(Sender: TObject);
Var
  SQL: String;
Begin
  DisableForm;
  Try
    lblProcessMessage.Caption := 'Saving....';
    lblProcessMessage.Visible := true;
    Try
      btnNext.Enabled      := False;
      btnCompleted.Enabled := False;
      Update;
      DeleteEmptyLines(txtShipTo);
      DeleteEmptyLines(txtClientDetails);

      If SavePO then
      begin
        If fbbingoodsReceived And AppEnv.CompanyPrefs.PrintStoreAwayOnReceival then begin
          GroupReportByClass := GroupProducts.Checked;
          SQL := StoreAwaySlipSQL;
          fbReportSQLSupplied := true;
          Try
            ReportToPrint:= tcdatautils.GetDefaultReport(102);
            if ReportToPrint = '' then ReportToPrint := 'Store Away Slip';
            PrintTemplateReport(ReportToPrint, SQL, Not AppEnv.Employee.ShowPreview, 1);
            PO.Printdoc.Printdoc(PO.classname, PO.ID, dtStawySlip, Self.classname, PreviewToDocumentOutputType(AppEnv.Employee.ShowPreview) , ReportToPrint);
            PO.Dirty := False;
          Finally
            fbReportSQLSupplied := False;
          End;
        End;
        SendCreateEmail;
      End Else
      Begin
        HandlePurchaseErrors;
        Exit;
      End;
    Finally
      lblProcessMessage.Visible := False;
      btnNext.Enabled           := true;
      btnCompleted.Enabled      := true;
    End;

    Self.Close;
  Finally EnableForm;
  End;
End;
procedure TPurchaseGUI.btnCopyClick(Sender: TObject);
var
  iNewID:Integer;
begin
  DisableForm;
  try
      if not SavePO then exit;
      PO.connection.CommitTransaction;
      PO.Accessmanager.AccessLevel:= Appenv.AccessLevels.GetEmployeeAccessLevel(Self.classname);
      PO.Connection.BeginTransaction;
      DoShowProgressbar(PO.Lines.count +2 , 'Copying Purchase Order');
      try
        iNewID:= PO.CopyPOToPO;
      finally
        DohideProgressbar;
      end;
      if iNewID <> 0 then begin
        NewAuditTrialentry('Invoice Created(Copied)');
        PO.connection.CommitTransaction;
        (*KeyId := iNewID;
        showProgressbar(WaitMsg, 2);
        try
          LoadTransRec;
          PO.Connection.BeginTransaction;
          SetcontrolFocus(cboClientR);
        finally
          HideProgressbar;
        end;*)
        PO.Dirty := False;
        OpenERPForm('TPurchaseGUI', iNewID, nil, nil, False, false); // opne invoice in a differnet instance of the form
        closewait;
      end else begin
        PO.connection.RollbackTransaction;
        PO.Connection.BeginTransaction;
        MessageDlgXP_Vista('Copying PO Failed' , mtWarning, [mbok] ,0 );
      end;
  finally
    EnableForm;
  end;

end;

Function TPurchaseGUI.StoreAwayslipSQL(LineIDs:String=''): String;
begin
  Result :=   '{companyInfo}SELECT CompanyName, Address, Address2, City, State, ' + ' Postcode, PhoneNumber AS PhoneNumber, FaxNumber AS FaxNumber, ' + ' ABN from tblCompanyInformation ~|||~' +
            ' {PO}SELECT ' +
              ' Replace(Replace(PQABatch.Value , Left(SUBSTRING_INDEX(PQABatch.Value,concat("PO-",PO.purchaseOrderID, "-"),1),255) , "") , concat("PO-",PO.purchaseOrderID, "-") , "") as Rollno,'+
              ' po.PurchaseOrderNumber, '+
              ' po.SupplierName, '+
              ' po.OrderDate,   ' +
              ' p.PartName, '+
              ' p.PartsDescription, '+
              ' c.ClassName     ,  '+
              ' PBin.Binlocation, ' +
              ' PBin.binnumber,'+
              ' PQABatch.Value as batchno, '+
              ' PQABatch.ExpiryDate, ' +
              ' POL.UnitOfMeasureShipped as POQty,  ' +
              ' if(P.Batch="F" and P.Multiplebins="F" ,"","[   ]") as Done,' +
              ' if(P.Batch="F" and P.Multiplebins="F" ,"","Done") as DoneCaption,' +
              ' if(P.Batch="T","Batch Number" , "") as BatchnoCaption,' +
              ' if(P.Batch="T","Expiry Date" , "") as ExpiryDateCaption,' +
              ' if(P.Multiplebins="T","Bin Location " , "") as BinLocationCaption,' +
              ' if(P.Multiplebins="T","Bin Number " , "") as BinNumberCaption,' +
              ' sum(if (ifnull(PQABins.PQADEtailID,0)=0 , PQABatch.UOMQty , PQABins.UOMQty)) as Qty, ' +
              'CL.Company as Customername, CL.JobName as CustomerJobName, CL.JobNumber as CustomerJobnumber, POL.SupplierProductCode , P.BARCODE , POL.purchaselineID'+
              ' FROM  '+ //'(SELECT  @TranslineID:=0,@Seqno:=0,@Seqno2:=0) r , ' +
            ProductTables(tExtraDetails) +
            ' inner join tblPurchaseLines POL on POL.PurchaseLineID = PQA.TRansLineID and POL.PurchaseOrderID = PQA.TransID and PQA.TransType ="TPurchaseOrderLine"  ' +
            ' Left join tblclients CL on CL.ClientID = POL.CustomerJobID ' +
            ' inner join tblpurchaseorders PO on PO.PurchaseOrderID = POL.PurchaseOrderID' + ' where PO.PurchaseOrderID = ' + IntToStr(PO.ID) ;
            if LineIDs <> '' then Result := result +' and POL.purchaselineid in (' + LineIDs +')';
            Result := result +' Group by  purchaselineID , p.PartName, c.ClassName,ifnull(PBin.binnumber,""),ifnull(PBin.Binlocation,""), ifnull(PQABatch.Value,"") , ifnull(PQABatch.ExpiryDate,0)'+
            ' order by purchaselineID , Rollno ';
end;
procedure TPurchaseGUI.AddExtraMenuItems;
var
  mnuItem : TMenuItem;
begin
    if self.AccessLevel <= 3 then
      NewMenuForTransGrid('Change Shipping Container' , DoChangeShippingContainer , False);
    NewMenuForTransGrid('Print Batch BarCodes' , PrintBatchBarcodes , False);
    NewMenuForTransGrid('Print BarCodes' , DoPrintBarcodes , False);
    mnuItem := NewMenuForTransGrid('Print Product Labels', PrintProductLabels, false);
    //if tblMasterSalesGlobalRef.AsString = '' then
    if PO.lines.SaleLineId =0 then mnuItem.Enabled := false;

end;
procedure TPurchaseGUI.DoPrintBarcodes(Sender:TObject);
begin
    Printbarcodes(true);
end;
Procedure TPurchaseGUI.AfterCommit;

  Procedure OpenBackOrders;
  Var sFilter: String; BackOrdersList: TComponent;
  Begin
    If PO.salesGlobalref <> '' then Exit;
    If (fbGoodsReceived) then begin
      doShowProgressbar( PO.lines.count, 'Checking for Back Orders');
      try
        sFilter := PO.BuildBackOrderFilter;
      finally
        dohideprogressbar;
      end;
      If sFilter <> '' then begin
        If CommonLib.MessageDlgXP_Vista('Do you want to view Outstanding Back Orders for the goods received on this Purchase Order?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
          if AppEnv.CompanyPrefs.SalesBackorderCheckType = 'Invoice' then begin
            BackOrdersList := GetComponentByClassName('TBackOrdersListGUI');
            If assigned(BackOrdersList) then begin
              TBackOrdersListGUI(BackOrdersList).chkIgnoreDates.Checked := true;
              TBackOrdersListGUI(BackOrdersList).FilterString := sFilter;
              TBackOrdersListGUI(BackOrdersList).formstyle    := fsMDIChild;
              TBackOrdersListGUI(BackOrdersList).bringtoFront;
            End;
          end
          else if AppEnv.CompanyPrefs.SalesBackorderCheckType = 'Sales Order' then begin
            BackOrdersList := GetComponentByClassName('TBackOrderSOGUI');
            if Assigned(BackOrdersList) then begin
              TBackOrderSOGUI(BackOrdersList).chkIgnoreDates.Checked := true;
              TBackOrderSOGUI(BackOrdersList).FilterString := sFilter;
              TBackOrderSOGUI(BackOrdersList).formstyle    := fsMDIChild;
              TBackOrderSOGUI(BackOrdersList).bringtoFront;
            end;
          end;
        End;
        CreateBackOrderReminder;
      End;
    End;
  End;

Begin
  fNewRec            := False;
  fbGoodsReceived    := PO.GoodsReceived;
  fbbingoodsReceived := PO.binGoodsREceived;
  if accesslevel <=3 then PO.UpdateProductAvgCosts;
  OpenBackOrders;
  UpdateProductLatestCosts;
  UserLock.UnlockAllCurrentInstance;
  CheckForSNEquipmentnAllocateForHire;
  PO.dirty := False;
End;

procedure TPurchaseGUI.AfterFormShow;
begin
  inherited;
  if doSavenclosinOpen then begin
     btnCompleted.click;
  end;
end;

procedure TPurchaseGUI.AfterSubFormShow(Sender: TObject);
begin
//  StateParams.I['KeyID']:= PO.ID;
  if (Sender is TfmSuppPrepayments) then  begin
    TfmSuppPrepayments(Sender).AttachObserver(Self);
    if (TfmSuppPrepayments(Sender).KeyId = 0) and (TfmSuppPrepayments(Sender).AccessLevel < 5) then begin
      if Self.tblMaster.FieldByName('ClientID').AsInteger <> 0 then begin
        TfmSuppPrepayments(Sender).SuppPrePayment.ClientID := Self.tblMaster.FieldByName('ClientID').AsInteger;
        TfmSuppPrepayments(Sender).cboClientCloseUp(TfmSuppPrepayments(Sender).cboClient, TfmSuppPrepayments(Sender).cboClient.LookupTable,
          TfmSuppPrepayments(Sender).cboClient.Datasource.DataSet, true);
        TfmSuppPrepayments(Sender).LinkToOrderRef := PO.Globalref;
        TfmSuppPrepayments(Sender).LinkToOrderOriginalRef := PO.OriginalDocNumber;
        TfmSuppPrepayments(Sender).SuppPrePayment.ForeignExchangeCode := PO.ForeignExchangeCode;
//        TfmSuppPrepayments(Sender).SuppPrePayment.ClassID := PO. SaleClassId;
      end;
    end;
  end
  else if (Sender is TfmSuppPayments) then begin
//    TfmSuppPayments(Sender).OpenForOrderId := PO.ID;
  end;
end;

Procedure TPurchaseGUI.CommitAndNotify;
Begin
  CommitTransaction;
  AfterCommit; // virtual method used in decendants
  Notify;
End;

Procedure TPurchaseGUI.CreateBackOrderReminder;
Var qryReminder: TERPQuery;
Begin
  if AppEnv.Employee.ReceivedBOAppearDays < 1 then
    exit;

  qryReminder := TERPQuery.Create(Self);
  Try
    With TERPQuery.Create(Self) Do
      Try
        Connection := MyConnection;
        SQL.Add('Select EmployeeID, ReceivedBOAppearDays from tblPersonalPreferences where ReceivedBOAppearDays > 0');
        Open;
        If Not IsEmpty then begin
          While Not Eof Do Begin
            qryReminder.Connection := MyConnection;
            qryReminder.SQL.Clear;
            qryReminder.SQL.Add(Format('Select * from tblToDo Where POID = %d and EmployeeID = %d', [tblMasterPurchaseOrderID.asInteger, FieldByName('EmployeeID').asInteger]));
            qryReminder.Open;

            If qryReminder.IsEmpty then begin
              qryReminder.Insert;
              qryReminder.FieldByName('EmployeeID').asInteger          := FieldByName('EmployeeID').asInteger;
              qryReminder.FieldByName('Description').AsString          := Format(TODO_REMINDER, [tblMasterPurchaseOrderNumber.AsString]);
              qryReminder.FieldByName('CreatedByEmployeeID').asInteger := AppEnv.Employee.EmployeeID;
              qryReminder.FieldByName('POID').asInteger                := tblMasterPurchaseOrderID.asInteger;
              qryReminder.FieldByName('CreatedDate').AsDateTime        := Now;
              qryReminder.FieldByName('ToDoByDate').AsDateTime         := Now - 1;
              qryReminder.Post;
            End;
            next;
          End;
        End;
      Finally free;
      End;
  Finally FreeAndNil(qryReminder);
  End;
End;


Procedure TPurchaseGUI.FormShow(Sender: TObject);
Var OriginalProductSQL: String; qryEmailedList: TERPQuery;
Begin

  stepProgressbar;
  Try
    DisableForm;
    InFormShow := true;
    chkShipTocustomer.hint := 'Load Customer Address for the last edited customer per line';
    Try
      PrefSuppList.Clear;
      If PassedConnection <> Nil then begin
        Self.MyConnection        := PassedConnection;
        PO.Connection.Connection := MyConnection;
        If tblmaster.active then tblmaster.Close;
        If tblDetails.active then tblDetails.Close;
        tblmaster.Connection  := MyConnection;
        tblDetails.Connection := MyConnection;
      End;

      fNewRec := keyId = 0;
      NeedEmailOnSave := KeyId = 0;
      If AppEnv.CompanyPrefs.UseForeignCurrencyonPO then begin
        lblBaseForeignTotal.Visible    := true;
        edtBaseForeignTotal.Visible    := true;
        lblEstimatedForeignAmt.Visible := true;
        EstimatedForeignAmt.Visible    := true;
      End;

      Try
        (* fbShowingOrClosing := true; *)

        qryPOQuantities.ParamByName('xpurchaseOrderId').AsString := PO.OriginalDocNumber;

        qryProduct.ParamByName('xPartsID').asInteger := 0;

        OriginalProductSQL := cboProductQry.SQL.Text;
        (* if (cboProductQry.SQL.Strings[cboProductQry.SQL.Count - 1] = 'LIMIT 0') or
          (cboProductQry.SQL.Strings[cboProductQry.SQL.Count - 1] = 'LIMIT 0;')
          then else cboProductQry.SQL.Add('Limit 0'); *)

        Inherited;


        GuiPrefs.DbGridElement[grdTransactions].RemoveFields('RAStatus,RAQty');
        //if not {Appenv.CompanyPrefs.EnablePackWeight}PO.Lines.Product.EnablePackWeight then GuiPrefs.DbGridElement[grdTransactions].RemoveFields('Packcount,packweightField');

        If keyId <> 0 then begin
          { IJB 17/5/12 this was commented out, don't know why as it caused problems being removed }
          If (PO.IsBOInvoiced) then begin
            //CommonLib.MessageDlgXP_Vista('Please be Aware that Access to This ' + TypeToDescription(ClassNameToTranType(Self.classname)) + ' Record is Read-Only.', mtWarning, [mbOk], 0);
            TransAccessMsg:= 'Grid is Read-Only.  Back Order already invoiced';
            TransTimerMsg(TransAccessMsg , 5);
            Transaccesslevel := 5;
          End;

          If (accesslevel > 3) then begin
            { Set the form to read only because we don't want to allow edits when a backorder has been invoiced }
            If dgEditing In grdTransactions.Options then grdTransactions.Options := grdTransactions.Options - [dgEditing];

            If dgAllowInsert In grdTransactions.KeyOptions then grdTransactions.KeyOptions := grdTransactions.KeyOptions - [dgAllowInsert];
            cboProductR.ReadOnly := True;
            cboCustJob.ReadOnly  := True;
            cboClass.ReadOnly    := True;
            cboTaxCode.ReadOnly  := True;

            grdTransactions.ColumnByName('UnitOfMeasureShipped').ReadOnly                  := true;

            If PO.IsBOInvoiced then begin
              TransAccessMsg :='This Purchase Order''s BackOrder already ''Received Goods''';
              Caption := TitleLabel.Caption + '(Frozen) - ' + TransAccessMsg;
            end;

          End;
        End;
        { if BO exists PO lines are non editable }

        cboProductQry.Open;

        qryProduct.Close;
        qryProduct.Connection := CommonDbLib.GetSharedMyDacConnection;
        edtBarcode.Clear;
        edtBatch.Clear;

        // if not AppEnv.CompanyPrefs.IncludeLandedCostsinAvgCost then    begin
        // cmdIncudeLandeCost.Enabled := False;
        // Bevel1.Left:=298;                           {centre the control}
        // Label9.Left:=306;
        // Label10.Left:=484;
        // edtBarCode.left:= 306;
        // end;
        //FormatProductCombo(cboProductR);

        If keyId <> 0 then begin
          If Trim(PO.DocNumber) = '' then PO.DocNumber := Trim(PO.OrgPurchaseOrderNumber) + '-' + IntToStr(PO.SeqNo);

          qryEmailedList                     := TERPQuery.Create(Nil);
          qryEmailedList.Options.FlatBuffers := true;
          qryEmailedList.Connection          := CommonDbLib.GetSharedMyDacConnection;

          Try
            qryEmailedList.SQL.Clear;
            qryEmailedList.SQL.Add('SELECT * FROM tblEmailedReports WHERE reporttype = "Purchase Order" and TransactionID = ');
            qryEmailedList.SQL.Add(IntToStr(keyId));

            qryEmailedList.Open;

            If qryEmailedList.FieldByName('ContactID').asInteger <> 0 then begin
              EmailContactID := qryEmailedList.FieldByName('ContactID').asInteger;
            End;
          Finally FreeAndNil(qryEmailedList);
          End;
        End;

        IsLandedCosts := PO.HasImportCosts;

        tblDetails.First;
        LockPO;
        // Are we opening up with given parameters? : eg:PO from supplier form
        If InitialiseStartup then begin
          PO.SupplierName := GetClientName(CustomerID);
          PO.clientID     := CustomerID;
          PO.PostDB;
          PO.EditDB;
          cboClientR.Text := PO.SupplierName;
          // edtCompanySearchFilter.Text := PO.SupplierName;
          DoOnClientchange;
        End;

        SetPurchaseOrderState(tblMasterInvoiceNumber.AsString);
        PO.Lines.DataSet.Filter   := 'Deleted <> ' + QuotedStr('T');
        PO.Lines.DataSet.Filtered := true;

        grdTransactions.RemoveField('Discountamount');
        GuiPrefs.DbGridElement[grdTransactions].HideField('Discountamount');

        grdTransactions.RemoveField('OriginalCost');
        GuiPrefs.DbGridElement[grdTransactions].HideField('OriginalCost');

        If Not AppEnv.CompanyPrefs.ShowDocketNumberColumnOnPurchases then begin
          grdTransactions.RemoveField('DocketNumber');
          GuiPrefs.DbGridElement[grdTransactions].HideField('DocketNumber');
        End
        Else grdTransactions.AddField('DocketNumber');

        If AppEnv.CompanyPrefs.UseCostCentres then begin
          grdTransactions.AddField('CostCentreName');
          qryCostCentre.Open;
        End Else Begin
          grdTransactions.RemoveField('CostCentreName');
          GuiPrefs.DbGridElement[grdTransactions].HideField('CostCentreName');
        End;

        GuiPrefs.DbGridElement[grdTransactions].RemoveField(tbldetailsProctreeId.fieldname);
        GuiPrefs.DbGridElement[grdTransactions].RemoveField(tbldetailsSaleLineId.fieldname);
        GuiPrefs.DbGridElement[grdTransactions].RemoveField(tbldetailsSmartorderId.fieldname);
        GuiPrefs.DbGridElement[grdTransactions].RemoveField(tbldetailsSmartOrderlineId.fieldname);

        GuiPrefs.DbGridElement[grdTransactions].HideField(tbldetailsProctreeId.fieldname);
        GuiPrefs.DbGridElement[grdTransactions].HideField(tbldetailsSaleLineId.fieldname);
        GuiPrefs.DbGridElement[grdTransactions].HideField(tbldetailsSmartorderId.fieldname);
        GuiPrefs.DbGridElement[grdTransactions].HideField(tbldetailsSmartOrderlineId.fieldname);

        Setcolumn({Appenv.CompanyPrefs.EnablePackWeight}PO.Lines.Product.EnablePackWeight and (Appenv.companyPrefs.PackWeightQtyField <>2), tblDetailsPackWeightField2.fieldname , Appenv.CompanyPrefs.PackWeightField2  );
        Setcolumn({Appenv.CompanyPrefs.EnablePackWeight}PO.Lines.Product.EnablePackWeight and (Appenv.companyPrefs.PackWeightQtyField <>1), tblDetailsPackWeightField1.fieldname , Appenv.CompanyPrefs.PackWeightField1  );

        { Not Using  Foreign Currency }
        If Not AppEnv.CompanyPrefs.UseForeignCurrencyonPO then begin
          grdTransactions.RemoveField('ForeignCurrencyLineCost');
          grdTransactions.RemoveField('ForeignTotalLineAmount');
          GuiPrefs.DbGridElement[grdTransactions].HideField('ForeignCus thrrencyLineCost');
          GuiPrefs.DbGridElement[grdTransactions].HideField('ForeignTotalLineAmount');
        End Else Begin
          // grdTransactions.AddField('ForeignExchangeCode');
          grdTransactions.AddField('ForeignCurrencyLineCost');
          grdTransactions.AddField('ForeignTotalLineAmount');
        End;

        // Don't show foreign exchange code on each line
        grdTransactions.RemoveField('ForeignExchangeCode');
        GuiPrefs.DbGridElement[grdTransactions].HideField('ForeignExchangeCode');

        { Not Product Specifications Calc }
        If Not AppEnv.CompanyPrefs.UseProductSpecsCalcsPO then begin
          grdTransactions.RemoveField('SpecDescription');
          grdTransactions.RemoveField('SpecValue');
          GuiPrefs.DbGridElement[grdTransactions].HideField('SpecDescription');
          GuiPrefs.DbGridElement[grdTransactions].HideField('SpecValue');
        End Else Begin
          grdTransactions.AddField('SpecDescription');
          grdTransactions.AddField('SpecValue');
        End;

        if tblDetails.IndExFieldNames ='' then tblDetails.IndExFieldNames := 'LinesOrder ASC';
        cboCostCentre.PopupMenu := grdTransactions.PopupMenu;

        lblBaseForeignCurrencyCode.Enabled := AppEnv.CompanyPrefs.UseForeignCurrencyonPO;
        cboBaseForeignCurrencyCode.Enabled := AppEnv.CompanyPrefs.UseForeignCurrencyonPO;
        lblBaseExchangeRate.Enabled        := AppEnv.CompanyPrefs.UseForeignCurrencyonPO;
        edtBaseExchangeRate.Enabled        := AppEnv.CompanyPrefs.UseForeignCurrencyonPO;

        if (AccessLevel < 3) then begin
          if HasLinkedPrepayments or HasPayments then
            btnPayments.Visible := true
          else
            btnPayments.Visible := false;
        end
        else
          btnPayments.Visible := false;

      Except
        On EAbort Do HandleEAbortException;
        On e: ENoAccess Do HandleNoAccessException(e);
        On e: Exception Do Begin
          (* fbShowingOrClosing := False; *)
          Raise;
        End;
      End;
      (* fbShowingOrClosing        := False; *)
      fPrintBarCodesMode        := 'ThisOne';
      lblProcessMessage.Visible := False;

    Finally
      EnableForm;
      SetControlFocus(cboClientR);
    End;
  Finally
    Enabledisable;
    hideProgressbar;
    ShowGridLockMsg;
    InFormShow := false;
  End;

End;

Procedure TPurchaseGUI.txtShipToDblClick(Sender: TObject);
Var ShipAddressList: TShipAddressListGUI;
Begin
  Inherited;
  If PO.clientID > 0 then begin
    If Not EditNoAbort(tblmaster) then Exit;
    ShipAddressList := TShipAddressListGUI(GetComponentByClassName('TShipAddressListGUI'));

    If assigned(ShipAddressList) then begin
      ShipAddressList.OnGridDataSelect := DoOnAddressListGridDataSelect;
      ShipAddressList.CustomerID := PO.ClientId;
      ShipAddressList.formstyle    := fsMDIChild;
      ShipAddressList.bringtoFront;
    End;
  End Else Begin
    CommonLib.MessageDlgXP_Vista('Choose A Supplier Before Assigning An Address !', mtWarning, [mbOk], 0);
  End;
End;

Procedure TPurchaseGUI.FormCreate(Sender: TObject);
Begin
  doSavenclosinOpen := False;
  fbconfirmtoautoloadHireProducts := False;
  btnfix.visible := devmode;
  fbExludeDiscontProductinProductcombo:= TRue;
  fiproctreeId:= 0;
  mnuTransactionSequence.Visible := true;
  AllowCustomiseGrid             := true;
  Inherited;
  IF qryShipContainerLookup.active then qryShipContainerLookup.Close;
  PrefSuppList                      := TStringList.Create;
  qryShipContainerLookup.Connection := MyConnection;
  qryShipContainerLookup.Open;

  Setlength(BusObjqueries, 2);
  BusObjqueries[0] := 'tblMaster';
  BusObjqueries[1] := 'tblDetails';
  IsUsingBusObj    := true;

  bPartSelected            := False;
  bLineDeleted             := False;
  fbGoodsReceived          := False;
  fbbingoodsReceived       := False;
  BatchObj                 := tBatchObj.Create(MyConnection);
  fbForeignCurrencyChanged := False;
  InvoiceToOpen            := 0;
  SOToOpen                 := 0;

  pnlApproved.Visible := AppEnv.CompanyPrefs.UseApprovalLevels;
  TransApprovalInit(chkApproved ,  PO.Approvaltype , PO, 'TotalAmountInc',true, nil, nil, nil);
  NewMenuForTrans('Change PO for Approval',OpenPOChangeApproval,true,'Open Purchase Order Change for Approval Form');
End;

Procedure TPurchaseGUI.FormDestroy(Sender: TObject);
Begin

  PrefSuppList.free;
  FreeAndNil(BatchObj);
  If assigned(fFxObj) then FreeAndNil(fFxObj);
  fBactchReceive.Free;
  PO := Nil; (* if Assigned(PO) then FreeandNil(PO); *)
  If assigned(PassedConnection) then begin
    PassedConnection := Nil;
    MyConnection     := Nil;
  End;
  Inherited;
End;

Procedure TPurchaseGUI.tblMasterInvoiceNumberChange(Sender: TField);
Var TestStr: String;
Begin
  Inherited;
  if (AppEnv.AccessLevels.GetEmployeeAccessLevel('fnAllowEntryOfSupplierInvNoOnPO')<> 1) then begin
    CommonLib.MessageDlgXP_Vista('You don''t have access to change Supplier Invoice Numbers on Purchase Orders.', mtWarning, [mbOk], 0);
    tblMaster.Cancel;
    //abort;
    exit;
  end;


  { If the InvoiceNumber field is empty and the OldValue of same isn't, show an error message }
  if Appenv.CompanyPrefs.CanRemoveSupplierInvoiceNoInPO then exit;

  If Empty(Sender.AsString) then begin
    If VarIsNull(Sender.OldValue) then begin
      TestStr := '';
    End Else Begin
      TestStr := Sender.OldValue;
    End;
    If Not Empty(TestStr) then begin
      CommonLib.MessageDlgXP_Vista('Cannot remove Supplier Invoice # once the Invoice has been received.', mtWarning, [mbOk], 0);
      Sender.AsString := TestStr;
    End;
  End;
  SetPurchaseOrderState(Sender.AsString);
End;

Procedure TPurchaseGUI.SetPurchaseOrderState(Const InvNum: String);
Begin
  lblProductReceiptsOnly.Alignment := taCenter;
  lblProductReceiptsOnly.AutoSize  := False;
  If Self.keyId = 0 then begin
    lblProductReceiptsOnly.Caption := PO_STATE[0];
    Exit;
  End;

  If Self.FullBackOrder And (Self.keyId <> 0) then begin
    lblProductReceiptsOnly.Caption := PO_STATE[0];
    Exit;
  End;

  If Empty(Trim(InvNum)) then begin
    lblProductReceiptsOnly.Caption := PO_STATE[1];
  End Else Begin
    lblProductReceiptsOnly.Caption := PO_STATE[2];
  End;
End;

Procedure TPurchaseGUI.ShowForeignCurrencycomponnets;
Begin
  Inherited;
  lblEstimatedForeignAmt.Visible := lblBaseForeignTotal.Visible;
  EstimatedForeignAmt.Visible    := edtBaseForeignTotal.Visible;
End;

procedure TPurchaseGUI.SkipReadonlyfield;
begin
  if GrdTransactions.Columnbyname(GrdTransactions.GetActiveField.FieldName).readonly or tbldetails.FindField(GrdTransactions.GetActiveField.FieldName).readonly or (accesslevel >3) then begin
    GrdTransactions.Options := GrdTransactions.Options - [Wwdbigrd.dgEditing];
  end else begin
    GrdTransactions.Options := GrdTransactions.Options + [Wwdbigrd.dgEditing];
  end;
end;

procedure TPurchaseGUI.ShowControlhints;
begin
  inherited;
  ShowControlhint(chkShipToClass , 'This will open the list of ' +appenv.DefaultClass.ClassHeading+'(s).'+NL+
                  'Selecting a ' +appenv.DefaultClass.ClassHeading+' will update the ''Ship To'' of the current Purchase Order with the ' +appenv.DefaultClass.ClassHeading+'''s Address'+NL);
  //ShowControlhint(chkShipToClass , 'Choose to Select a Department for Shipment');
  ShowControlhint(chkShipTocustomer, 'Choose to Have the Customer/Job Address for Shipment - If Customer/Job is Chosen, Otehrwise, "Default Address" will be used');
  if Appenv.CompanyPrefs.UseEmployeeDeptAddressinPOShipto then begin
    if PO.Employee.DefaultClass.useAddress then ShowControlhint(chkShipToDefaultAddress, 'Choose To Use Default Department of the Employee. If Employee Doesn''t have a Dfault Address, "Default Address" will be used' +Quotedstr(PO.Employee.Name)+NL+NL+PO.Employee.DefaultClass.Address);
  end else if AppEnv.DefaultClass.ShipToAddress <> '' then
    ShowControlhint(chkShipToDefaultAddress, 'Choose to Have the Default Department Address for Shipment.'+NL+NL+AppEnv.DefaultClass.ShipToAddress)
  else ShowControlhint(chkShipToDefaultAddress, 'Choose to Have the Company Address for Shipment.' +NL+NL+getCompanyAddress);
end;

Procedure TPurchaseGUI.tblMasterInvoiceNumberGetText(Sender: TField; Var Text: String; DisplayText: Boolean);
Begin
  Inherited;
  SetPurchaseOrderState(Sender.AsString);
  Text := Sender.AsString;
End;

procedure TPurchaseGUI.tblMasterPurchaseOrderNumberSetText(Sender: TField;
  const Text: string);
begin
  inherited;
  if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnPONumber') = 1 then begin
    Sender.AsString:= Text;
  end
  else begin
    MessageDlgXP_Vista('Your do not have rights to change PO Number.',mtInformation,[mbOk],0);
  end;
end;

Procedure TPurchaseGUI.PrintBatchBarcodes(Sender:TObject);
var
  MsgOption :Word;
  Tablename :String;
  Script :TERPScript;
  Qry:TERpQuery;
  ctr:Integer;
  ssql:String;
  Function RndDblToNextInt(const Value :Double):Integer;
  begin
    result := trunc(Value);
    if value = result then exit;
    result := result +1;
  end;

begin
  if PO.Lines.Count =1 then begin
    if MessageDlgXP_Vista('Print the barcodes?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
    MsgOption := 100;
  end else begin
    MsgOption := MessageDlgXP_vista('Print Current Product or All products in the order?', mtWarning, [], 0 , nil, '' , '' ,false, nil , 'Current Product,All Product(s),Cancel');
  end;

  if MsgOption = 102 then exit;
  TableName := GetUserTemporaryTableName('PrintPOBarCode', MyConnection);
  try
    Qry := DbSharedObj.GetQuery(PO.Connection.Connection);
    Script := DbSharedObj.GetScript(CommonDbLib.GetSharedMyDacConnection);
    try
      Script.SQL.Text := 'Drop table if exists '+tablename +'; ' +
                        ' CREATE TABLE '+tablename +' ( ' +
                        '   ID int(10) NOT NULL AUTO_INCREMENT, ' +
                        '   ProductID int(10) NOT NULL DEFAULT 0, ' +
                        '   POLineID int(10) NOT NULL DEFAULT 0, ' +
                        '   batchID int(10) NOT NULL DEFAULT 0, ' +
                        '   BatchNo varchar(255) DEFAULT NULL, ' +
                        '   Qty double, ' +
                        '   ISBO Enum("T","F") default "F", '+
                        '   PRIMARY KEY (ID) ' +
                        ' ) ENGINE=MyIsam DEFAULT CHARSET=utf8;';
      (*Qry.SQL.Text := 'SELECT ' +
                        ' POL.productID, POL.PurchaseLineID, PQABatch.Value as batchno,  POL.UnitofMeasureShipped,  PQABatch.uomQty , PQABatch.PQAdetailID as BatchID ' +
                        ' FROM  tblpurchaselines AS POL ' +
                        ' Left join tblPQA as PQA on PQA.transId = POL.PurchaseOrderID and PQA.translineId = POL.PurchaseLineID and PQA.transtype = "TPurchaseOrderLine" ' +
                        ' Left join tblPqaDetails PQABatch  on PQABatch.PQAId  = PQA.PQAID and PQABatch.PQAType = "Batch"  and PQABatch.Active= "T" ' +
                        ' Where ' + iif(msgOption = 100 , ' POL.PurchaseLineID = ' + inttostr(PO.Lines.ID) , 'POL.PurchaseOrderID = '+ inttostr(PO.ID));*)

Qry.SQL.Text := 'SELECT  POL.productID, POL.PurchaseLineID, PQABatch.Value as batchno,  POL.UnitofMeasureShipped,  PQABatch.uomQty , PQABatch.PQAdetailID as BatchID   , "F" as isbo ' +
                        ' FROM  tblpurchaselines AS POL ' +
                        ' Left join tblPQA as PQA on PQA.transId = POL.PurchaseOrderID and PQA.translineId = POL.PurchaseLineID and PQA.transtype = "TPurchaseOrderLine" ' +
                        ' Left join tblPqaDetails PQABatch  on PQABatch.PQAId  = PQA.PQAID and PQABatch.PQAType = "Batch"  and PQABatch.Active= "T" ' +
                        ' Where ' + iif(msgOption = 100 , ' POL.PurchaseLineID = ' + inttostr(PO.Lines.ID) , 'POL.PurchaseOrderID = '+ inttostr(PO.ID)) +

                        ' union all ' +
                        ' SELECT  POL.productID, POL.PurchaseLineID, PQABatch.Value as batchno,  POL.UnitofMeasureBackorder,  PQABatch.bouomQty , PQABatch.PQAdetailID as BatchID  , "T" as isbo ' +
                        ' FROM  tblpurchaselines AS POL ' +
                        ' Left join tblPQA as PQA on PQA.transId = POL.PurchaseOrderID and PQA.translineId = POL.PurchaseLineID and PQA.transtype = "TPurchaseOrderLine" ' +
                        ' Left join tblPqaDetails PQABatch  on PQABatch.PQAId  = PQA.PQAID and PQABatch.PQAType = "Batch"  and PQABatch.Active= "T" ' +
                        ' Where ' + iif(msgOption = 100 , ' POL.PurchaseLineID = ' + inttostr(PO.Lines.ID) , 'POL.PurchaseOrderID = '+ inttostr(PO.ID)) ;


      Qry.open;
      if Qry.RecordCount>0 then begin
        Qry.First;
        While Qry.Eof = False do begin
          if Qry.FieldByName('uomQty').AsFloat <> 0 then begin
            for ctr := 1 to RndDblToNextInt(Qry.FieldByName('uomQty').AsFloat) do
              Script.SQL.Add('insert into '+ tablename +' ( ProductId, batchno , POLineID , Qty, batchID, isbo) values (' +inttostr(Qry.FieldByName('productID').AsInteger)+','+
                                                                                                            Quotedstr(Qry.FieldByName('batchno').asString)+','+
                                                                                                            inttostr(Qry.FieldByName('PurchaseLineID').AsInteger)+','+
                                                                                                            FloatToStr(Qry.FieldByName('uomQty').asFloat)+','+
                                                                                                            inttostr(Qry.FieldByName('batchID').AsInteger)+','+
                                                                                                            Quotedstr(Qry.FieldByName('IsBO').asString)+');');
(*          end else begin
            for ctr := 1 to RndDblToNextInt(Qry.FieldByName('UnitofMeasureShipped').AsFloat)do
              Script.SQL.Add('insert into '+ tablename +' ( ProductId, batchno , POLineID , Qty , batchID, isbo) values (' +inttostr(Qry.FieldByName('productID').AsInteger)+','+
                                                                                                            Quotedstr('')+','+
                                                                                                            inttostr(Qry.FieldByName('PurchaseLineID').AsInteger)+','+
                                                                                                            FloatToStr(Qry.FieldByName('UnitofMeasureShipped').asFloat)+',0'+','+
                                                                                                            Quotedstr(Qry.FieldByName('IsBO').asString)+');');*)

          end;
          Qry.Next;
        end;
        Script.Execute;
      end;
      ssql := companyInfoSQL +
            ' ~|||~{PO}SELECT  PO.supplierName, C.street as SuppStreet,  C.street2 as SuppStreet2,  C.street3 as SuppStreet3,   ' +
            ' C.suburb as SuppSuburb,  C.state as SuppState,  C.country as SuppCountry,   C.postcode as SuppPostcode, ' +
            ' PO.ShipTo,PO.OrderTo,  PO.PurchaseOrderID,PO.PurchaseOrderNumber,PO.OriginalNo,PO.TotalAmount,PO.TotalAmountInc, ' +
            ' PO.EmployeeName,PO.InvoiceNumber,PO.ETADate,PO.DueDate,PO.Comments,PO.SalesComments,PO.Terms,PO.Balance,PO.Payment, ' +
            ' PO.AmountDue,PO.EnteredBy,PO.CustPONumber,PO.ForeignExchangeCode,PO.ForeignExchangeRate,PO.ForeignTotalAmount,PO.ForeignPaidAmount,PO.ForeignBalanceAmount,PO.ContactName,PO.EquipmentName, ' +
            ' C.BillStreet , C.BillStreet2 , C.BillStreet3 , C.BillSuburb , C.BillState , C.BillCountry , C.BillPostcode ' +
            ' FROM  tblPurchaseOrders PO ' +
            ' INNER JOIN tblClients C on C.clientID = PO.ClientID ' +
            ' Left join tblemployees e on e.EmployeeID = PO.EmployeeID ' +
            ' where PO.purchaseOrderId = ' + inttostr(PO.ID)+
            ' ~|||~ {POLine} SELECT   POL.PurchaseLineID,POL.PARTTYPE,POL.ProductGroup,POL.QtySold,POL.UnitofMeasureQtySold,POL.Shipped, ' +
            ' POL.UnitofMeasureShipped,POL.BackOrder,POL.UnitofMeasureBackorder,concat(POL.UnitofMeasurePOLines , "(" , POL.UnitofMeasureMultiplier, ")") as UOM, POL.Class,POL.CustomerJob, ' +
            ' POL.TotalLineAmount,POL.TotalLineAmountInc,POL.LineTaxCode,POL.LineTax,POL.ReceivedDate,POL.CustomField1,POL.CustomField2,POL.CustomField3, ' +
            ' POL.CustomField4,POL.CustomField5,POL.CustomField6,POL.CustomField7,POL.CustomField8,POL.CustomField9,POL.CustomField10,POL.LineNotes,POL.MemoLine,   ' +
            ' POL.ProductName,POL.Product_Description,    POL.QtySold * POL.LineCostInc as EstLineCostInc,    POL.QtySold * POL.LineCost as EstCostEx,    ' +
            ' P.PURCHASEDESC_Memo as ProductPURCHASEDESC_Memo, P.CUSTFLD1 as ProductcustFld1,P.CUSTFLD2 as ProductcustFld2,P.CUSTFLD3  as ProductcustFld3,P.CUSTFLD4 as ProductcustFld4, ' +
            ' P.CUSTFLD5 as ProductcustFld5,P.CUSTFLD6 as ProductcustFld6,P.CUSTFLD7 as ProductcustFld7,P.CUSTFLD8 as ProductcustFld8,P.CUSTFLD9 as ProductcustFld9, ' +
            ' P.CUSTFLD10 as ProductcustFld10,P.CUSTFLD11 as ProductcustFld11,P.CUSTFLD12 as ProductcustFld12,P.CUSTFLD13 as ProductcustFld13, ' +
            ' P.CUSTDATE1 as ProductcustDate1,P.CUSTDATE2 as ProductcustDate2,P.CUSTDATE3 as ProductcustDate3,  ' +
            Firstcolumn +'  AS PartHeader,     ' +
            secondcolumn +' AS PartSubLevel1,     ' +
            Thirdcolumn+' AS PartSubLevel2,   ' +
            ' P.Barcode ProductBarCode ,ProductCode, ' +
            ' (POL.QtySold* POL.ForeignCurrencyLineCost) EstForeingPrice  ,  (POL.QtySold* POL.ForeignCurrencyLineCost + POL.QtySold* POL.ForeignCurrencyLineCost * POL.LineTaxRate) EstForeignPriceinc ,  ' +
            ' (POL.QtySold* POL.LineTaxRate) as EstTax  , ' +
            ' PQABatch.value as Batchno,  concat(POL.productId, "-" ,  PQABatch.value ) ProductIDnBatchnumber, PQABatch.expirydate , PQABatch.TruckLoadNo, PQABatch.UoMqty batchqty , T.ISBo' +
            ' FROM ' +Tablename + ' T inner join   tblpurchaselines AS POL  on POL.purchaseLineId = T.POLineID ' +
            ' Inner JOIN tblparts P on T.ProductID=P.PartsID ' +
            ' left join tblPqaDetails PQABatch  on PQABatch.PQAdetailID = T.batchID';
            fbreportSQLSupplied := True;
            ConnectionFormReport := Myconnection;
            PrintTemplateReport(TemplateToPrint('Batch Barcode(PO)', chkChooseRpt.checked, 'Batch Barcode - summary') , ssql, False, 1 );
    finally
//      DestroyUserTemporaryTable(Tablename);
      DbSharedObj.ReleaseObj(Script);
      DbSharedObj.ReleaseObj(Qry);
    end;
  finally

  end;
end;

procedure TPurchaseGUI.PrintBoxLabels(ALine: TPurchaseOrderLine);
const
  csSQL = '{Details}select P.PartName, C.Company as Supplier,PL.LineCost * (1 + PL.LineTaxRate) as PriceInc, '+
          'PL.BoxesOrdered as Ordered, PL.BoxesReceived as Received, %d as Current '+
          'from tblPurchaseOrders PO inner join tblPurchaseLines PL on PL.PurchaseOrderId=PO.PurchaseOrderId ' +
          'inner join tblParts P on P.PartsId = PL.ProductId ' +
          'inner join tblClients C on PO.ClientId=C.ClientId ' +
          'where PO.PurchaseOrderId=%d and PL.ProductId=%d';
var
  sSQL : string;
  idx : integer;
begin
//
//  if tblMasterSalesGlobalRef.AsString = '' then
//    exit;
  for idx := 1 to ALine.BoxesReceived do
  begin
    sSQL := Format(csSql, [idx, ALine.PurchaseOrderId, ALine.ProductID]);
    fbreportSQLSupplied := True;
    ConnectionFormReport := Myconnection;
    PrintTemplateReport('Product Received Box', sSQL, true, 1);
  end;
end;

procedure TPurchaseGUI.PrintProductLabels(aPurchaseOrderId,
  aProductId: integer);
var
  sSQL : string;
begin
//
//  if tblMasterSalesGlobalRef.AsString = '' then
//    exit;
  sSQL := '{Details}select P.PartName, P.Price1 as MainSellPrice, P.Price1 * (1 + SL.LineTaxRate) as MainSellPriceInc, ' +
          'S.CustomerName, sl.LinePriceInc as TxnSellPriceInc, PL.QtySold as Ordered, PL.Shipped as Received, pl.BackOrder as BackOrdered '+
          'from tblPurchaseOrders PO ' +
          'inner join tblPurchaseLines PL on PL.PurchaseOrderId=PO.PurchaseOrderId ' +
          ' inner join tblParts P on P.PartsId = PL.ProductId  ' +
          //' inner join tblSales S on s.GlobalRef = PO.SalesGlobalRef ' +
          ' inner join tblsaleslines SL on SL.SaleLineId=PL.SaleLineId '+
          ' inner join tblSales S on s.saleId = SL.saleID ' +
          'where (ifnull(PL.SaleLineId, 0) > 0) ' +
          'and PO.PurchaseOrderId=' + IntToStr(aPurchaseOrderId);
  if aProductId > 0 then
    sSql := sSQL + ' and PL.ProductId=' + IntToStr(aProductId);

  fbreportSQLSupplied := True;
  ConnectionFormReport := Myconnection;
  PrintTemplateReport('Product Received Label', sSQL, true, 1);

end;

procedure TPurchaseGUI.PrintProductLabels(Sender: TObject);
begin
//
  //if tblMasterSalesGlobalRef.AsString = '' then
  if sender is TMenuItem then
    if PO.lines.SaleLineId  =0 then exit;

  if sender is TPurchaseOrderLine then
    if TPurchaseOrderLine(Sender).SaleLineId = 0 then  exit;

  PrintProductLabels(tblMasterPurchaseOrderId.AsInteger);

end;

Procedure TPurchaseGUI.PrintBarcodes(Const FromOrdered: Boolean);
Var i: Integer;
  fsReportName: String;
  Qty: Integer;
Begin
  Inherited;

  Processingcursor;
  Try
    With TempMyQuery Do
      Try
        SQL.Clear;
        SQL.Add('TRUNCATE TABLE tblbarcodestoprint;');
        Execute;
        PO.Lines.PostDB;
        (* if FromOrdered then Qty:=tblDetailsUnitofMeasureQtySold.AsInteger else Qty :=  tblDetailsUnitofMeasureShipped.AsInteger; *)
        Qty := QtyforBarcodeprinting(FromOrdered);
        If Qty = 0 then Exit;

        SQL.Clear;
        For i := 1 To Qty Do Begin
          SQL.Add('INSERT HIGH_PRIORITY INTO tblbarcodestoprint (ProductID,BatchNo, ClassId) VALUES (' + tblDetailsProductID.AsString + ',' + tblMasterPurchaseOrderID.AsString + ',' +
              IntToStr(tblDetailsClassID.asInteger) + ');');
        End;
        If SQL.count > 0 then Execute;
      Finally
        If active then Close;
        free;
      End;
  Finally Processingcursor(False);
  End;
  If GetTableRecordCount('tblbarcodestoprint') <> 0 then begin
    fsReportName                             := tcdatautils.GetDefaultReport(3); // 'Barcode Labels'
    If Empty(fsReportName) then fsReportName := 'Barcode Labels';
    fbTemplateUsesNonFormConnection          := true;
    fbReportSQLSupplied                      := true;
    PrintTemplateReport(fsReportName, ReportSQLforBarCodeLabels, not (Devmode) and Not(AppEnv.Employee.ShowPreview), 0);
    fbReportSQLSupplied := False;
  End;
End;

Function TPurchaseGUI.GetReportTypeID: Integer;
Begin
  result := 19;
End;

// procedure TPurchaseGUI.cboProductXCloseUp(Sender: TObject; LookupTable,
// FillTable: TDataSet; modified: Boolean);
// begin
// if (modified = false) then Exit;
// if Matrixshown then exit;
//
// if Sender is TwwDBLookupCombo then    LastComboAccessed := TwwDBLookupCombo(Sender);
// if cboProductX.Text = '' then
// exit;
// UpdatePrefSupp;
// if (AppEnv.CompanyPrefs.StoreForeignCurrencyValue) then  begin
// bPartSelected := True;
// end;
//
// if not cboProductX.LookupTable.Locate('PARTNAME', cboProductX.text,
// [loCaseInsensitive]) then  begin
// Exit;
// end;
//
// inherited;
//
// tblDetails.Edit;
// PreferedSupp := mrRetry;
// PreferedSuppCost := mrNo;
// HoldPreferedSuppCost := True;
//
// tblDetails.Edit;
// Application.ProcessMessages;
//
// if not fbRecordCancelled then
// begin
// tblDetails.Edit;
// end
// else
// begin
// fbRecordCancelled := False;
// end;
//
// if (AppEnv.CompanyPrefs.StoreForeignCurrencyValue) then
// begin
// bPartSelected := False;
// end;
//
// HoldPreferedSuppCost := False;
// if tbldetailsClassId.asInteger <> 0 then
// if cboClass.LookupTable.Locate('ClassId' , tblDetailsClassID.asInteger , []) then
// cboClassCloseUp(cboClass,cboClass.LookupTable, grdTransactions.Datasource.DAtaset , True);
// end;

Procedure TPurchaseGUI.cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
Begin
  If Not modified then Exit;
  If cboInvoiceDate.Date <> 0 then begin
  End Else Begin
    Inherited;
  End;

End;

function TPurchaseGUI.Save4NewTrans: Boolean;
begin
  Result := False;
  DisableForm;
  Try
    If ErrorOccurred then Exit;

    if not EmployeeHasAccess('FnCreatePurchaseOrder') then
    begin
      CommonLib.MessageDlgXP_Vista('You Do Not Have Rights To Create New Purchase Orders', mtWarning, [mbOK], 0);
      Exit;
    end;

    lblProcessMessage.Caption := 'Saving....';
    lblProcessMessage.Visible := true;
    Try
      btnNext.Enabled      := False;
      btnCompleted.Enabled := False;
      Update;

      If PO.Dirty then begin
        Case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) Of
          mrYes: Begin
              If SavePO then begin
                Result := true;
              End Else Exit;
            End;
          mrNo: Begin
              RollbackTransaction;
              Result := true;
            End;
          mrCancel: Begin
              Exit;
            End;
        End;
      end else begin
        REsult := True;
      End;
    Finally
      lblProcessMessage.Visible := False;
      btnNext.Enabled           := true;
      btnCompleted.Enabled      := true;
    End;
  Finally
    EnableForm;
  End;
End;

procedure TPurchaseGUI.btnPaymentsClick(Sender: TObject);
var
  choice: word;
begin
  Choice := MessageDlgXP_Vista('Please Select the List You Wish to Open.', mtConfirmation, [] , 0 , nil , '' , '' , False , nil ,
                  'Payment List,Pre-Payment List,Cancel');

  if choice = 100 then inherited
  else if choice = 101 then begin
    OpenPrepayList;
  end
  else begin
    exit;
  end;
end;

procedure TPurchaseGUI.btnPDFClick(Sender: TObject);
begin
  DisableForm;
  Try
    actPreview.Enabled := False;

    Try
      If Not SavePO then Exit;
        Self.CommitAndNotify;
        Try
          GroupReportByClass := GroupProducts.Checked;
          if chkChooseRpt.checked = False then  ReportToPrint      := tcDataUtils.GetTemplate(PO.Supplier.DefaultPOTemplateID);
          PO.Dirty := False;
          Inherited;
          CloseAfterPrint;
      except
        on E:Exception do begin
            commonlib.MessageDlgXP_Vista('Export to PDF failed.' +CHR(13) +CHR(13) + E.Message , mtWarning, [mbok] , 0);
            Self.BeginTransaction;
        End;
      End;
    Finally
      actPreview.Enabled := true;
    End;
  Finally
    EnableForm;
  End;

end;

procedure TPurchaseGUI.btnPickUpFromClick(Sender: TObject);
var
  frm: TPickFromPopupGUI;
  tmpComponent:TComponent;
begin
  inherited;
  if self.AccessLevel > 3 then exit;
  tmpComponent:=  GetComponentByClassName('TPickFromPopupGUI');
  if not assigned(tmpComponent) then exit;
  frm := TPickFromPopupGUI(tmpComponent);
  frm.CallingFormType := ftPurchaseOrder;
  frm.CallingForm := Self;

  frm.ClientDetails := PO.PickupFromDesc;

  frm.ShowModal;
  ShowPickupFromHint;
end;

procedure TPurchaseGUI.btnPrintClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
  IsEnabled: boolean;
begin
  If Not SavePO then Exit;
  Self.CommitAndNotify;
    OptsForm := EmailOptsForm;//TfmReportingOptions.Create(nil);
    try
      OptsForm.ActionList.AddDivider('Print');
      OptsForm.ActionList.Add('Print' ,'Print a Purchase Order',actPrintExecute, true, true);
      OptsForm.ActionList.Add('Preview', 'Preview a Purchase Order', self.actPreviewExecute, true, true);
      OptsForm.ActionList.Add('Picking', 'Print a Picking Slip',self.PrintStowAway, false, true);
      OptsForm.ActionList.Add('Save PDF','Save a PDF Purchase Order to your computer', SaveTransToPDF, true, true);

      OptsForm.ActionList.AddDivider('Email');
      OptsForm.ActionList.Add('Email PO', 'Email a copy of the Purchase Order', DoEmailTransactionSilentnSecret, true, true);
      OptsForm.ActionList.Add('Email PO (Edit)', 'Edit Email Message Before Sending, With a Copy of the Purchase Order', DoEmailTransactionnonsilent, true, true);
      if AppEnv.CompanyPrefs.EnableInvoiceMail and ((PO.ContactEmail <> '') or (PO.Supplier.Email <> '')) then begin
        OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without Purchase Order', self.SendPrintEmailSilent, true, true);
      end
      else begin
        OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without Purchase Order', self.SendPrintEmailSilent, true, false);
      end;
      OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without Purchase Order', self.SendPrintEmail, true, true);

      OptsForm.ActionList.AddDivider('SMS');
      IsEnabled := AppEnv.CompanyPrefs.SMSEnabled and
         AppEnv.CompanyPrefs.EnablePOPrintSMS and
         ((PO.ContactMobile <> '') or (PO.Supplier.Email <> ''));
      OptsForm.ActionList.Add('SMS', 'Just send SMS', self.SendPrintSMSSilent, true, IsEnabled);
      OptsForm.ActionList.Add('SMS (Edit)', 'Edit SMS before sending', self.SendPrintSMS, true, AppEnv.CompanyPrefs.SMSEnabled);

      OptsForm.ShowModal;
      CloseAfterPrint(OptsForm.CloseWhenDone);
    finally
      OptsForm.Free;
    end;
end;
Procedure TPurchaseGUI.FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
  Inherited;
  If Key = VK_F9 then begin
    SetControlFocus(edtBarcode);
  End else If Key = VK_F8 then begin
    SetControlFocus(edtBatch);
  End;
End;

Procedure TPurchaseGUI.MatchBarcode(Const sBarcode: String);
Var iProductID: Integer;
Begin
  If Not Empty(sBarcode) then begin
    iProductID := TProduct.ProductIdForBarcode(sBarcode);
    If iProductID <> 0 then begin
      If tblDetails.Recordcount = 0 then Exit;
      If tblDetails.Locate('ProductID', iProductID, []) then grdTransactions.SetActiveField('Shipped');
    End;
  End;
End;

procedure TPurchaseGUI.mnuAllocateSerialNumberstoHireClick(Sender: TObject);
begin
  inherited;
  if not Appenv.CompanyPrefs.UseHire then exit;
  if not PO.HasEquipnSerailProduct then exit;
  If PO.Dirty then begin
        if CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo], 0) = mrno then exit;
        If SavePO then Self.Close; // after commit will do the serial number popup
  end else begin
    CheckForSNEquipmentnAllocateForHire;
    Self.close;
  end;
end;

procedure TPurchaseGUI.mnuCopyDocketNumbersClick(Sender: TObject);
begin
  CopyDocketnoToClipboard;
end;

procedure TPurchaseGUI.mnuCreateReturnAuthorityClick(Sender: TObject);
var
  iNewID:Integer;
begin
  DisableForm;
  try
    if not SavePO then exit;
    PO.connection.CommitTransaction;
    PO.Accessmanager.AccessLevel:= Appenv.AccessLevels.GetEmployeeAccessLevel(Self.classname);
    PO.Connection.BeginTransaction;
    DoShowProgressbar(PO.Lines.count +2 , 'Copying Purchase Order to RA');
    try
      iNewID:= PO.CopyPOToRA;
    finally
      DohideProgressbar;
    end;
    if iNewID <> 0 then begin
      PO.connection.CommitTransaction;
      OpenERPForm('TReturnAGUI',iNewID);
    end else begin
      PO.connection.RollbackTransaction;
      PO.Connection.BeginTransaction;
      MessageDlgXP_Vista('Copying PO to RA Failed' , mtWarning, [mbok] ,0 );
    end;
  finally
    EnableForm;
  end;
end;

procedure TPurchaseGUI.mnuInvoiceClick(Sender: TObject);
var
  InvoiceID:Integer;
begin
  inherited;
  InvoiceID:= PO.InvoiceId;
  if InvoiceID<> 0 then
    openERPForm('TInvoiceGUI' , InvoiceID);
end;

procedure TPurchaseGUI.mnuPasteDocketNumbersClick(Sender: TObject);
begin
  ImportDocketnoFromClipBoard;
end;

procedure TPurchaseGUI.mnuSalesOrderClick(Sender: TObject);
var
  SOID:Integer;
begin
  inherited;
  SOID:= PO.SalesORderID;
  if SOID<> 0 then
    openERPForm('TSalesOrderGUI' , SOID);
end;

procedure TPurchaseGUI.NewTransBusObjinstance;
begin
  Freeandnil(PO);
  PO := TPurchaseorder.Create(Self);
  PO.Name:= 'POObj';
  PO.DoProductallocation := Self.DoProductallocation;
  Order                  := PO;
  inherited;
end;

Procedure TPurchaseGUI.edtBarcodeKeyPress(Sender: TObject; Var Key: Char);
Begin
  Inherited;
  // check if CR is recieved  => Barcode complete
  If Key = #13 then begin
    SetControlFocus(grdTransactions);
    MatchBarcode(edtBarcode.Text);
    Key := #0;
  End;
End;

Procedure TPurchaseGUI.edtBarcodeEnter(Sender: TObject);
Begin
  Inherited;
  edtBarcode.Clear;

End;

Procedure TPurchaseGUI.txtInvNumberChange(Sender: TObject);
Begin
  Inherited;

  If char_length(txtInvNumber.Text) < 1 then cboInvoiceDate.Clear;
End;

Procedure TPurchaseGUI.grdTransactionsEnter(Sender: TObject);
Begin
  Inherited;
  (* PreferedSupp := mrRetry; *)

  If PO.Lines.DataSet.State In [dsEdit, dsInsert] then Exit;

  PO.Lines.DataSet.Disablecontrols;
  Try
    If PO.Lines.DataSet.Recordcount = 0 Then
      If PO.Lines.DataSet.State In [dsEdit, dsInsert] Then
      Else PO.Lines.New;
  Finally PO.Lines.DataSet.EnableControls;
  End;
  LockPO;
  SkipReadonlyfield;
End;
(*
Procedure TPurchaseGUI.AssignLandedCosts(Const TotalLandedCost: Double);
Var BMark: TBookmark;
Begin
  BMark := tblDetails.GetBookmark;
  With tblDetails Do
    Try
      First;
      While Not Eof Do Begin
        PO.lines.TotalOrderLandedCost   := TotalLandedCost;
        PO.lines.TotalLineLandedCostPerc := RoundCurrency(DivZer(1, PO.lines.count) * 100);
        PO.lines.PostDB;
        next;
      End;
    Finally
      GotoBookmark(BMark);
      FreeBookmark(BMark);
    End;
End;
*)
procedure TPurchaseGUI.actPrepaymentExecute(Sender: TObject);
var
  s: string;
begin
  inherited;
  s := '';

  if PO.Dirty then
    s := 'Prepayments Can be Created only for Saved ' + PO.XMLNodeName + '.' +
      #13 + #10 + 'Do you Wish to Save this ' + PO.XMLNodeName +
      ' and Create a Prepayment Against it?'
  else s:= 'Do you Wish to Create a Prepayment Against this ' + SeparateWords(PO.XMLNodeName)+'?';

  if MessageDlgXP_Vista(s , mtconfirmation, [mbyes, mbno], 0) = mrNo then Exit;

  { this is to make sure the PO record is saved so that the prePayment can eb libnked to it }
  if not SavePO then Exit;
  PO.connection.CommitTransaction;
  PO.Dirty:= False;
  PO.Connection.BeginTransaction;

//  Openrecord(0 , 'TfmSuppPrepayments');
  OpenERPForm('TfmSuppPrepayments' ,0 ,AfterSubFormShow);
  Self.CloseWait;
end;

Procedure TPurchaseGUI.actPreviewExecute(Sender: TObject);
Begin
  DisableForm;
  Try
    actPreview.Enabled := False;

    Try
      If Not SavePO then Exit;
      Try
        Self.CommitAndNotify;
        Try
          GroupReportByClass := GroupProducts.Checked;
          if chkChooseRpt.checked = False then  ReportToPrint      := tcDataUtils.GetTemplate(PO.Supplier.DefaultPOTemplateID);
          PO.Dirty := False;

          Inherited;
//          closeAfterPrint;
        Finally
//          If Not AppEnv.Employee.CloseOnPrint then
          Self.BeginTransaction;
        End;
      Except
        On e: Exception Do Begin
          CommonLib.MessageDlgXP_Vista('Print failed.' + chr(13) + chr(13) + e.message, mtWarning, [mbOk], 0);
          Self.BeginTransaction;
        End;
      End;

    Finally actPreview.Enabled := true;
    End;
  Finally EnableForm;
  End;
End;

(* function TPurchaseGUI.deleteLine:boolean;
  var
  isFiltered :Boolean;
  fId :Integer;
  begin
  isFiltered :=PO.Lines.dataset.filtered;
  PO.Lines.dataset.disableControls;
  try
  fId :=PO.Lines.ID;
  PO.Lines.Dataset.filtered := False;
  try
  PO.Lines.Dataset.Locate('PurchaseLineId' , fId , []);
  PO.Lines.DoFieldChangewhenDisabled := True;
  Try
  PO.Lines.Deleted:= true;
  REsult := True;
  finally
  PO.Lines.DoFieldChangewhenDisabled := False;
  End;
  if PO.Lines.Count > 0 then PO.Lines.PostDB;
  finally
  PO.Lines.Dataset.filtered := isFiltered;
  end;
  PO.CalcOrderTotals;
  finally
  PO.Lines.dataset.EnableControls;
  end;
  end; *)
Procedure TPurchaseGUI.btnDeleteClick(Sender: TObject);
Begin
(*  If PO.IsBOInvoiced and (PO.Lines.QtyBackOrder <> 0) then begin
    CommonLib.MessageDlgXP_Vista('Backorder already Shipped for this record, not possible to delete the record', mtWarning, [mbOk], 0);
    Exit;
  End;*)
  if not PO.Lines.ISOkTodelete then begin
    exit;
  end;
  Inherited;
End;

Procedure TPurchaseGUI.actPrintExecute(Sender: TObject);
Begin
  DisableForm;
  Try
    actPrint.Enabled := False;

    Try
      If Not SavePO then Exit;
      Try
        Self.CommitAndNotify;
        Try
          GroupReportByClass := GroupProducts.Checked;
          if chkChooseRpt.checked = False then  ReportToPrint      := tcDataUtils.GetTemplate(PO.Supplier.DefaultPOTemplateID);
          PO.Dirty := False;
          Inherited;
//          closeAfterPrint;
        Finally
//          If Not AppEnv.Employee.CloseOnPrint then
          Self.BeginTransaction;
        End;
      Except
        On e: Exception Do Begin
          CommonLib.MessageDlgXP_Vista('Print failed.' + chr(13) + chr(13) + e.message, mtWarning, [mbOk], 0);
          Self.BeginTransaction;
        End;
      End;
    Finally
      actPrint.Enabled := true;
    End;
  Finally
    EnableForm;
  End;
End;

Procedure TPurchaseGUI.cboInvoiceDateChange(Sender: TObject);
Begin
  If tblmaster.active then begin
    If cboInvoiceDate.Date <> 0 then begin
    End Else Begin
      if not ValidateInvoiceDate then exit;
      Inherited;
    End;
  End;
End;

Procedure TPurchaseGUI.cmdFaxClick(Sender: TObject);
Var Fax: TFaxObj; FaxNo: String; Faxed: Boolean;
Begin
  Faxed         := False;
  if chkChooseRpt.checked = False then  ReportToPrint := tcDataUtils.GetTemplate(PO.Supplier.DefaultPOTemplateID);
  DisableForm;
  Try
    If Not SavePO then Exit;
    Try
      GroupReportByClass := GroupProducts.Checked;
      Inherited;
      FaxNo := PO.Supplier.Faxnumber;

      If Empty(FaxNo) then begin
        CommonLib.MessageDlgXP_Vista(PO.SupplierName + ' does not have an Fax Number to Send to.' + chr(13) + chr(13) + 'Please Review Supplier information to Add an Fax Number.', mtWarning,
          [mbOk], 0);
      End Else Begin
        lblEmail.Visible    := true;
        lblEmailMsg.Caption := 'Adding to Fax Spool...';
        fsFax               := true;
        LoadTemplate(true, true, true, 'PO_' + tblMasterGlobalRef.AsString);
        Fax := TFaxObj.Create;
        Try
          Fax.AddToFaxSpool(PO.EmployeeName, PO.SupplierName, FaxNo, 'Purchase Order', PO.globalref, '', ExtractFilePath(ParamStr(0)) + 'IMG0001.BMP', Now());
          Faxed := true;
        Finally FreeAndNil(Fax);
        End;
        lblEmail.Visible := False;
        DeleteFiles(ExtractFilePath(ParamStr(0)), '*.BMP');
      End;
    Finally
      LogFaxed(Faxed , ReportToPrint);
      ReportToPrint:= '';
      closeAfterPrint(faxed);

    End;
  Finally EnableForm;
  End;
End;

Procedure TPurchaseGUI.txtInvNumberExit(Sender: TObject);
Begin
  PO.ISInvNoUnique;
  If TDBEdit(Sender).Text = '' then begin
    LockPO; { if the invoice no is removed then unlock the components. }
    PO.EditDB;
    If tblMasterInvoiceNumber.AsVariant <> null then tblMasterInvoiceNumber.AsVariant := null;
    If tblMasterInvoiceDate.AsVariant <> null then tblMasterInvoiceDate.AsVariant     := null;
    PO.PostDB;
  End;
End;

Procedure TPurchaseGUI.edtCompanySearchFilterExit(Sender: TObject);
Begin
  Inherited;
  //
End;

procedure TPurchaseGUI.edtLineNotesDblClick(Sender: TObject);
begin
  inherited;
  grdTransactionsDblClick(grdTransactions);
end;

procedure TPurchaseGUI.edtMemoLineDblClick(Sender: TObject);
begin
  inherited;
  grdTransactionsDblClick(grdTransactions);
end;

function TPurchaseGUI.EmailTransaction(const RecipientAddress :String ='';ASilent: boolean=True; ASecret : boolean=True): boolean;
Var
  f: File;
  ReportType, OutGoingFileName: String;
  TransactionID, UserID, TransactionDescription: String;
  EmailDate: TDateTime; qryEmailedList: TERPQuery; intResult: Integer;
  strResult: String;
  XMLEmailObj :TXMLEmailObj;
  sXMLAddress:String;

  ftp: TIdFTP;
  stream: TMemoryStream;
  url: TURLObj;
  fileName: string;
  StringStream: TStringStream;
  ReportAttachmentfiles: String;
  Corres: TCorrespondenceGui;
  Recipients : string;
Begin
  result:= False;
  if chkChooseRpt.checked = False then
    ReportToPrint := tcDataUtils.GetTemplate(PO.Supplier.DefaultPOTemplateID);
    if REportToPrint = '' then
        if chkChooseRpt.Checked then begin
          LoadReportTypes;
          if dlgReportSelect.Execute then begin
            ReportToPrint := dlgReportSelect.SelectedItems.Text;
          end;
        end else if (tblMaster.FieldByName('TotalAmountInc').AsFloat < 0) then begin
            {negative so use Credit Return template}
            ReportToPrint:= 'Credit Return';
        end;
    if REportToPrint = '' then REportToPrint := tcDataUtils.GetDefaultReport(GetReportTypeID);
  DisableForm;
  Try
    If Not SavePO then Exit;
    Try

      if PO.Supplier.SendXMLPOs then begin
        XMLEmailObj := TXMLEmailObj.Create;       //Send XML email
        try
          sXMLAddress := ClientPOXMLEmail(PO.Supplierid );
          if sXMLAddress <> '' then begin
            ReportType := 'Purchase Order';
            intResult := CommonLib.MessageDlgXP_Vista('You are about to Email this XML ' + ReportType + ' to ' +
            sXMLAddress + '.' + #13 + #10 + #13 + #10 +
            'Would you like to specify a subject for this email?' + #13 + #10 + #13 + #10 +
            'Please select Yes to enter new email subject line. No to use standard subject line.', mtConfirmation,
            [mbYes, mbNo, mbCancel], 0);

            if intResult = mrYes then begin
              strResult := InputBox('SUBJECT DECLARATION', 'Please specify subject for this email',
                ReportType + ' #' + PO.DocNumber +
                ' for ' + PO.SupplierName);
            end else if intResult = mrNo then begin
              strResult := 'XML PurchaseOrder';
            end else begin
              Exit;
            end;

            { use XMLDoc.SaveToStream to force inclusion of "encoding" .. PO.XML removes encoding for default UTF-8 }
            StringStream := TStringStream.Create;
            try
              PO.XMLDoc.SaveToStream(StringStream);
              StringStream.Position := 0;
              XMLEmailObj.SendEmail(getEmailFrom, sXMLAddress,StringStream.DataString,strResult,'PurchaseOrder XML in attached file',0,PO.SupplierId);
            finally
              StringStream.Free;
            end;
          end;
        finally
          FreeAndNil(XMLEmailObj);
          strResult := '';
        end;
      end;

      if PO.Supplier.SendFTPXMLPOs then begin
        ftp := TIdFTP.Create(nil);
        stream := TMemoryStream.Create;
        url := TURLObj.Create(PO.Supplier.FTPAddress);
        try
          ftp.Host := url.Host;  //PO.Supplier.FTPAddress;
          ftp.Username := PO.Supplier.FTPUserName;
          ftp.Password := PO.Supplier.FTPPassword;
          PO.XMLDoc.SaveToStream(stream);
          stream.Position := 0;
          try
            fileNAme := url.Path;
            if (fileName <> '') and (copy(fileName,Length(fileName),1) <> '/') then
              fileName := fileName + '/';
            fileName := fileName + 'TrueERP_PO_' + IntToStr(PO.ID) + '.xml';
            ftp.Connect;
            ftp.Put(stream,fileName);
            ftp.Disconnect;
          except
            on e: exception do begin
              CommonLib.MessageDlgXP_Vista('Error sending XML PO to FTP site: ' + e.Message,mtWarning,[mbOK],0);
            end;
          end;
        finally
          ftp.Free;
          stream.Free;
          url.Free;
        end;
      end;


      Corres := TCorrespondenceGui.Create;
      try
        // Clear all previous params/data
        //RecipientAddress := '';
        ReportType       := '';
        OutGoingFileName := '';

        Recipients := GetContactEmails(PO.ClientId, 'MainContactForPO');
        if RecipientAddress <> '' then
          Recipients := AddEmailToList(RecipientAddress, RecipientAddress);

        //If RecipientAddress = '' then // no recipient address
        if Recipients = '' then
        begin
         If CommonLib.MessageDlgXP_Vista(PO.SupplierName + ' does not have an email address.' + #13 + #10 +
           'Do you wish to load the email program anyway?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
          ASilent := false;
        end;

        ReportType := 'Purchase Order';

        // Ask the user if they want to specify a new subject
        intResult := CommonLib.MessageDlgXP_Vista('You are about to Email this ' + ReportType + ' to ' + PO.SupplierName + '.' + chr(13) + chr(13) + 'Would you like to specify a subject for this email?'
            + chr(13) + chr(13) + 'Please select ''Yes'' to enter new email subject line or ''No'' to use standard subject line.', mtConfirmation, [mbYes, mbNo, mbCancel], 0);

        If intResult = mrYes then begin
          strResult := InputBox('SUBJECT DECLARATION', 'Please specify subject for this email', ReportType + ' #' + PO.DocNumber + ' for ' +
              PO.SupplierName);
        End
        Else If intResult = mrNo then begin
          strResult := '';
        End Else Begin
          Exit;
        End;

        Try
          lblEmail.Visible    := true;
          lblEmailMsg.Caption := 'Emailing, ' + WAITMSG;

          GroupReportByClass := GroupProducts.Checked;

          LoadTemplate(true, true);
          OutGoingFileName := getOutGoingFileName('', ' ' + ReportType + ' #' + PO.DocNumber, '.PDF');
          assignfile(f, CommonLib.TempDir + 'EmailReport.PDF');
          if not FileExists(Commonlib.TempDir +  'EmailReport.PDF') then begin
            CommonLib.MessageDlgXP_Vista('Can''t Find Attachment'+#13+#10+#13+#10+'Email Failed !', mtWarning, [mbOK], 0);
            Exit;
          end;
          Copyfile(PChar(Commonlib.TempDir + 'EmailReport.PDF'), PChar(Commonlib.TempDir  + OutGoingFileName), false);


          If strResult <> '' Then
            // Our new specified subject.
              Corres.Subject := strResult
          Else
            // Default Subject / Pre set
              Corres.Subject := ReportType + ' #' + PO.DocNumber + ' for ' + PO.SupplierName;

          //Corres.RecipientList := RecipientAddress;
          Corres.RecipientList := Recipients;

          Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;
          Corres.SupplierId := PO.SupplierId;

          Corres.AttachmentList.Add(CommonLib.TempDir + OutGoingFileName);
          ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres , GetTemplate(REportToPrint));

(*          if ASilent then
            if not EmailShortSendMode(ASilent, ASecret) then
              exit;*)

          if Corres.Execute(ASilent, ASecret) then begin
            result := true;

            TransactionID := PO.DocNumber;
            UserID        := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
            EmailDate     := Now;

            // ReportType already defined at start of procedure
            TransactionDescription := GetCompanyName + ' ' + ReportType + ' #' + PO.DocNumber + ' for ' + PO.SupplierName;

            qryEmailedList            := TERPQuery.Create(Nil);
            qryEmailedList.Connection := CommonDbLib.GetSharedMyDacConnection;

            Try
              qryEmailedList.SQL.Clear;
              qryEmailedList.SQL.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType,');
              qryEmailedList.SQL.Add(' TransactionDescription,ContactID,EmailAddressUsed) Values ("' + TransactionID + '","' + UserID + '", "' + FormatDateTime(MysqlDateFormat, EmailDate) + '", "' +
                  ReportType + '", "' + TransactionDescription + '", "' + IntToStr(EmailContactID) + '", "' + RecipientAddress + '")');
              qryEmailedList.Execute;
            Finally
              If assigned(qryEmailedList) then FreeAndNil(qryEmailedList);
            End;
          end;

          DeleteFiles(CommonLib.TempDir, '*.PDF');
          DeleteMultipleFiles(Commonlib.TempDir , ReportAttachmentfiles);

          lblEmail.Visible := False;

        Except
          On e: Exception Do Begin
            lblEmail.Visible := False;
            CommonLib.MessageDlgXP_Vista('There was an error sending email : ' + e.message, mtWarning, [mbOk], 0);
          End;
        End;
      finally
        Corres.Free;
      end;
    Finally
      LogEmailed(result , ReportToPrint);
      ReportToPrint:= '';
      Self.BeginTransaction;
    End;
  Finally EnableForm;
  End;
end;

Procedure TPurchaseGUI.tmrRequesterTimer(Sender: TObject);
Begin
  Inherited;
  //
End;

Procedure TPurchaseGUI.cboInvoiceDateExit(Sender: TObject);
Begin
  Inherited;
  ValidateInvoiceDate;
  If Not(tblmaster.FieldByName(cboInvoiceDate.DataField).AsDateTime = 0) then begin
    If (tblmaster.FieldByName(TwwDBDateTimePicker(Sender).DataField).AsDateTime <= AppEnv.CompanyPrefs.ClosingDateAR) then begin
      If EditNoAbort(tblmaster) then begin
        CommonLib.MessageDlgXP_Vista('You Have Set This Date Before The Closing Date !' + #13 + #10 + '' + #13 + #10 + 'The Date Will Automatically be Set To Today''s Date ' + #13 + #10 + '' + #13 +
            #10 + 'OR' + #13 + #10 + '' + #13 + #10 + 'Reset The Closing Date In Preferences.', mtWarning, [mbOk], 0);
        tblmaster.FieldByName(TwwDBDateTimePicker(Sender).DataField).AsDateTime := Now;
      End;
    End;
  End;
  txtInvNumberExit(Sender);
End;

Procedure TPurchaseGUI.grdTransactionsRowChanged(Sender: TObject);
Begin
  Inherited;
  (* PreferedSupp                                      := mrRetry; *)
  (* If Not HoldPreferedSuppCost then PreferedSuppCost := mrRetry; *)
  try
    If (tblDetails.Recordcount <> 0) then
//      if screen.ActiveControl.Parent = pnlDetail then
      if assigned(Screen.ActiveControl) and (screen.ActiveControl.Parent=pnlDetail) then
        LockPO;
    SkipReadonlyfield;
  Except
  end;
End;

Procedure TPurchaseGUI.Doimportcost;
Var tmpComponent: TComponent;
  Function OrderHasShipContainer: Boolean;
  var  qry: TERPQuery;
  begin
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(PO.Connection.Connection);
    try
      Qry.SQL.Text := 'SELECT ContainerName,SD.PurchaseLineID,POL.SaleLineID,SC.ETA,SC.Active ' +
                      ' FROM tblshippingcontainer SC ' +
                      ' INNER JOIN tblshipcontainerdetails SD ON SC.ShippingContainerID = SD.ShippingContainerID ' +
                      ' INNER JOIN tblpurchaselines POL ON SD.PurchaseLineID = POL.PurchaseLineID ' +
                      ' WHERE SC.Active = "T" and POL.PurchaseorderId =' + inttostr(PO.ID) +
                      ' having ifnull(ContainerName, "")<> "" ';

      Qry.open;
      result := Qry.recordcount >0
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
  End;

  procedure ProcessLandedCosts;
  Var
    BMark: TBookmark;
  Begin
    BMark := tblDetails.GetBookmark;
    With tblDetails Do
    Try
      First;
      While Not Eof Do Begin
        Edit;
(*
        tblDetailsLandedCostsTotal.asCurrency   := TImportCostGUI(tmpComponent).LandedCost[tblDetailsProductId.AsInteger];
//        tblDetailsLandedCostsPercentage.asFloat := RoundCurrency(DivZer(1, tblDetails.Recordcount) * 100);
        tblDetailsLandedCostsPercentage.asFloat := RoundCurrency(DivZer(tblDetailsLandedCostsTotal.asCurrency, TImportCostGUI(tmpComponent).TotalLandedCost) * 100);
*)
        tblDetailsLandedCostsTotal.asCurrency   := TImportCostGUI(tmpComponent).TotalLandedCost;
        if TImportCostGUI(tmpComponent).Products.CostsExistForProduct(tblDetailsProductId.AsInteger) then
          tblDetailsLandedCostsPercentage.asFloat := RoundCurrency(DivZer(TImportCostGUI(tmpComponent).LandedCost[tblDetailsProductId.AsInteger], tblDetailsLandedCostsTotal.asCurrency) * 100)
        else begin
          { not a product with duty or handling .. split general costs relative to line portion of whole order .. }
          tblDetailsLandedCostsPercentage.asFloat := RoundCurrency(DivZer(tblDetailsTotalLineAmountInc.AsFloat, PO.TotalAmountInc) * 100);
        end;
        next;
      End;
    Finally
      FreeBookmark(BMark);
    End;
  end;

 begin
  If OrderHasShipContainer then begin
      CommonLib.MessageDlgXP_Vista('There is a shipping container assigned to at least one line.' + #13 + #10 + 'You can not assign import costs from here, use the Shipping container screen.',
        mtInformation, [mbOk], 0);
      Exit;
    End;

    tmpComponent := GetComponentByClassName('TImportCostGUI');
    If assigned(tmpComponent) then begin
      With TImportCostGUI(tmpComponent) Do Begin
        ImportCostOwner := Self;
        SupplierName    := Self.tblMasterSupplierName.AsString;
        clientID        := Self.tblMasterClientID.asInteger;
        keyId           := Self.tblMasterPurchaseOrderID.asInteger;
        POAmount        := Self.tblMasterTotalAmountinc.asFloat;
        If ShowModal = mrOK then
        begin
//          If (TotalLandedCost <> 0.00) then begin
//            AssignLandedCosts(TotalLandedCost);
          If (TotalLandedCost <> 0.00) then begin
            ProcessLandedCosts;
            IsLandedCosts := true;
          End Else Begin
            RemoveLandedCosts;
            IsLandedCosts := False;
          End;
        End;
      End;
    End;
end;

procedure TPurchaseGUI.DonOnShippingContainerSelect(Sender: TwwDbGrid);
var
  i, ContainerID, SelectedContainerID: integer;
  Container: TShippingContainer;
begin
  PO.Dirty := true;
  grdTransactions.DataSource.DataSet.DisableControls;
  try
    for i := 0 to grdTransactions.SelectedList.Count - 1 do begin
      grdTransactions.DataSource.DataSet.GotoBookmark(grdTransactions.SelectedList.Items[i]);
      SelectedContainerID := Sender.DataSource.DataSet.FieldByName('ShippingContainerID').AsInteger;
      ContainerID := TShippingContainer.ContainerIdForPurchaseLineId(tblDetailsPurchaseLineID.AsInteger);
      Container := TShippingContainer.Create(nil);
      try
        Container.Connection := PO.Connection;
        Container.Load(ContainerID);
        Container.Connection.BeginNestedTransaction;
        if ContainerID > 0  then begin
          { allready on a container .. }
          if ContainerId <> SelectedContainerID then begin
            { user is moving to a different container .. so delete from current }
            if Container.ContainerDetails.Locate('PurchaseLineID', tblDetailsPurchaseLineID.AsInteger, []) then begin
              Container.ContainerDetails.Delete;
              if Container.Save then begin

              end
              else begin
                Container.Connection.RollbackNestedTransaction;
                exit;
              end;

            end;
          end
          else begin
            { same container .. do nothing }
            exit;
          end;
        end;

        { now add to container }
        Container.Load(SelectedContainerID);
        Container.ContainerDetails.New;
        Container.ContainerDetails.PurchaseLineID := tblDetailsPurchaseLineID.AsInteger;
        Container.ContainerDetails.PostDb;
        if Container.Save then begin

        end
        else begin
          Container.Connection.RollbackNestedTransaction;
          exit;
        end;
        Container.Connection.CommitNestedTransaction;
      finally
        Container.Free;
      end;
    end;
    qryShipContainerLookup.Close;
    qryShipContainerLookup.Open;
    PO.Lines.RefreshDB;
  finally
    grdTransactions.DataSource.DataSet.EnableControls;
  end;
end;

Procedure TPurchaseGUI.actImportCostsExecute(Sender: TObject);
Begin
  DisableForm;
  Try
    if MessageDlgXP_Vista('This will Save the Current changes. Do you Wish To Continue? ', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
    If Not SavePO then Exit;
    Try
      Self.CommitAndNotify;
      Try
        PO.Dirty := False;
        DoImportcost;
      Finally
        Self.BeginTransaction;
      End;
    Except
      On e: Exception Do Begin
        CommonLib.MessageDlgXP_Vista('Importing Cost Failed.' + chr(13) + chr(13) + e.message, mtWarning, [mbOk], 0);
        Self.BeginTransaction;
      End;
    End;
  Finally
    EnableForm;
  End;
End;

Procedure TPurchaseGUI.RemoveLandedCosts;
Var BMark: TBookmark;
Begin
  BMark := tblDetails.GetBookmark;
  With tblDetails Do
    Try
      Disablecontrols;
      First;
      While Not Eof Do Begin
        Edit;
        tblDetailsLandedCostsTotal.asFloat      := 0.00;
        tblDetailsLandedCostsPerItem.asFloat    := 0.00;
        tblDetailsLandedCostsPercentage.asFloat := 0.00;
        next;
      End;
    Finally
      EnableControls;
      GotoBookmark(BMark);
      FreeBookmark(BMark);
    End;
End;

Procedure TPurchaseGUI.grdTransactionsFieldChanged(Sender: TObject; Field: TField);
Begin
  Inherited;
  if tblDetails.State in [dsInsert] then exit;
  if Field = tblDetailsETADate then begin
     tblDetailsETADateChange(tblDetailsETADate);

  end;
  (* If (Field = tblDetailsLineCost) And Not HoldPreferedSuppCost then begin
    PreferedSuppCost := mrRetry;
  End; *)
End;

Procedure TPurchaseGUI.tblDetailsForeignCurrencyLineCostChange(Sender: TField);
Begin
  If bPartSelected then Exit;
  If bForeignCodeUpdated then begin
    bForeignCodeUpdated := False;
    Exit;
  End;

  Inherited;
  PostMessage(Self.Handle, SX_ForeignCurrencyAdd, 0, 0);
End;

Procedure TPurchaseGUI.tblDetailsForeignExchangeCodeChange(Sender: TField);
Begin
  Inherited;
  bForeignCodeUpdated := true;
End;

Procedure TPurchaseGUI.UpdateProductLatestCosts;
Var
  // QM: TQueryManipulationObj;
    slPartIDs: TStringList;

Begin
  If Empty(txtInvNumber.Text) Or (cboInvoiceDate.Date = 0) then Exit;

  slPartIDs := TStringList.Create;
  Try
    slPartIDs.Clear;

    // Goto first record.
    tblDetails.Disablecontrols;
    try
      tblDetails.First;

      // Grab all part ID's
      While Not tblDetails.Eof Do Begin
        // Add product Key ID to list.
        slPartIDs.Add(IntToStr(PO.Lines.ProductID));
        // Fetch next record.
        tblDetails.next;
      End;

      // Create our query manipulation object.
      If (cboProductQry.SQL.Strings[cboProductQry.SQL.count - 1] = 'LIMIT 0') Or (cboProductQry.SQL.Strings[cboProductQry.SQL.count - 1] = 'LIMIT 0;') then begin
        cboProductQry.SQL.Delete(cboProductQry.SQL.count - 1);
      End;

      // QM := TQueryManipulationObj.Create(SE.OriginalSQL);
      Try
        // QM.ProcessSearchOR('PARTSID', uppercase('tblParts.Active = ') +
        // QuotedStr('T'), slPartIDs);

        cboProductQry.Close;
        // cboProductQry.SQL.Text := QM.ModifiedSQL;
        cboProductQry.Open;
      Finally
        // if Assigned(QM) then FreeAndNil(QM);
      End;
      // end;

      // Goto first record.
      if PO.supplier.IgnoreSupplierforProductLatestCost = False then begin
        tblDetails.First;
        While Not tblDetails.Eof Do Begin
          If (cboProductR.LookupTable.FindField('LatestCostDate') <> Nil) And (cboInvoiceDate.DateTime >= cboProductR.LookupTable.FieldByName('LatestCostDate').AsDateTime) then begin
            UpdateLatestCost(PO.Lines.ProductID, PO.Lines.LineCost, cboInvoiceDate.DateTime);
          End;
          // Fetch next record.
          tblDetails.next;
        End;
      end;
    finally
      tblDetails.EnableControls;
    end;
  Finally
    // Release our used objects.
    If assigned(slPartIDs) then FreeAndNil(slPartIDs);
  End;

End;


function TPurchaseGUI.ValidData: boolean;
var
  Option :Integer;
  supCreditbalance :Double;
function supplierCreditListOption:String;
begin
  REsult := '';
  if AppEnv.AccessLevels.GetEmployeeAccessLevel('TSupplierCreditListGUI') <> 6 then REsult :=   'Show Supplier Credit List';
end;
begin
  result:= inherited;
  if not result then
    exit;
  if AppEnv.CompanyPrefs.CreditCheckPO then begin
    SupcreditBalance := PO.Supplier.TotalSupplierCredit (*+  PO.TotalAmountInc -PO.CleanTRansTotalAmountInc*);
    if SupcreditBalance > PO.Supplier.SupplierCreditLimit then begin
      Option:= 0;
      While (Option <> mrno) and (Option <> mrYes) do begin
        Option := CommonLib.MessageDlgXP_Vista(
          'Suppliers credit limit has been exceeded' + #13#10 +
          'Limit: ' + CurrToStrF(PO.Supplier.SupplierCreditLimit, ffCurrency, 2) +
          '   Amount: ' +  CurrToStrF(SupcreditBalance, ffCurrency, 2) +
          #13#10 + 'Continue with purchase?', mtConfirmation,[mbYes,mbNo],0 , nil , '' , '' , False, nil ,supplierCreditListOption );
        if Option = 100 then OpenERPListFormModal('TSupplierCreditListGUI' , nil, beforeshowSupplierCreditListGUI);
      end;
      if option = mrNo then result:= false;
    end;
  end;
end;

procedure TPurchaseGUI.dtDueDateEnter(Sender: TObject);
begin
  If not Self.tblmaster.active then Exit;
  inherited;
  if (tblMasterFuturePo.AsString='T') and (tblMasterDueDate.AsDateTime=0) then
    tblMasterDueDate.AsDateTime := IncDay(DateOf(now), AppEnv.CompanyPrefs.FuturePODays);
  oldDuedate := tblMasterDueDate.AsDatetime;
end;

procedure TPurchaseGUI.dtDueDateExit(Sender: TObject);
begin
  inherited;
  if Not chkFuturePO.Checked AND AppEnv.CompanyPrefs.UseFuturePO then
    if OldDueDate <> tblMasterDueDate.asDateTime then
        if tblMasterDueDate.asDateTime  - DateOf(now) > AppEnv.CompanyPrefs.FuturePODays then
            if CommonLib.MessageDlgXP_Vista('Is this a Future Purchase Order?' ,
                        mtconfirmation , [mbYes, mbNo] , 0) = mrYes then
            begin
               if not (tblMaster.state in [dsEdit,dsInsert]) then
                 tblMaster.Edit;
               tblMasterFuturePO.asString := 'T';
            end;
end;

Procedure TPurchaseGUI.beforeshowSupplierCreditListGUI(Sender: TObject);
begin
   if not(Sender is TSupplierCreditListGUI) then exit;
   TSupplierCreditListGUI(Sender).supplierId := PO.SupplierId;
   TSupplierCreditListGUI(Sender).PurchaseOrderId := PO.ID;
   TSupplierCreditListGUI(Sender).listconnection := Self.MyConnection;
   TSupplierCreditListGUI(Sender).pnlsupplier.Enabled := False;
end;
Function TPurchaseGUI.FxObj: TForeignExchangeObj;
Begin
  If Not assigned(fFxObj) then fFxObj := TForeignExchangeObj.Create;
  result                              := fFxObj;
End;

Procedure TPurchaseGUI.cboCostCentreCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
Begin
  If Not modified then Exit;
  Inherited;
  GlobalEvents.Notify(Sender, GEVENT_ComboCloseUp);
End;

Procedure TPurchaseGUI.cboCostCentreNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: Boolean);
Begin
  Inherited;
  GlobalEvents.Notify(Sender, GEVENT_ComboNotInList);
End;

Procedure TPurchaseGUI.tblDetailsCostCentreIdSetText(Sender: TField; Const Text: String);
Begin
  Inherited;
  If Not(isnumeric(Text)) then Abort;
End;

procedure TPurchaseGUI.tblDetailsETADateChange(Sender: TField);
begin
  inherited;
  //// checking for the following to avoid execution of do field on change for new records / dofieldchange etc.
  ///   should be done only when use changes the ETA date
  if sametext(GrdTransactions.GetActiveField.FieldName, tblDetailsETADate.fieldname) then
    if (PO.Lines.CleanETADate = 0) or (PO.Lines.CleanETADate <> PO.Lines.ETADate) then begin
      Application.Processmessages;
      DoCopyValuesForSelectedRows(grdTransactions.Datasource.Dataset.fieldbyname('ETADate').AsDateTime);
    end;
end;

Procedure TPurchaseGUI.grdTransactionsDrawFooterCell(Sender: TObject; Canvas: TCanvas; FooterCellRect: TRect; Field: TField; FooterText: String; Var DefaultDrawing: Boolean);
Begin
  Inherited;
  EstimatedFinalAmt.Caption   := FloatToStrF(PO.TotalEstimatedAmountInc, ffCurrency, 15, CurrencyRoundPlaces);
  EstimatedForeignAmt.Caption := TCurrency.CurrencySymbolForCode(PO.ForeignExchangeCode) + FloatToStrF(PO.EstimatedForeignAmountInc, ffNumber, 15, CurrencyRoundPlaces);
  lblOrdered.Caption          := FloatToStrF(PO.TotalQtyOrdered, ffFixed, 15, 2);
  lblShipped.Caption          := FloatToStrF(PO.TotalQtyShipped, ffFixed, 15, 2);
  lblBO.Caption               := FloatToStrF(PO.TotalQtyBackOrdered, ffFixed, 15, 2);

  If AppEnv.CompanyPrefs.UseForeignCurrencyonPO And AppEnv.CompanyPrefs.SumReceivedOnlyForeignCurrencyonPO then begin
    grdTransactions.ColumnByName('ForeignTotalLineAmount').FooterValue := FloatToStrF(PO.ForeignTotalAmount, ffFixed, 15, 4);
  End;
End;

Procedure TPurchaseGUI.grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: String);
var
  fbFlag:Boolean;
Begin
  If SysUtils.SameText(AFieldName, tblDetailsUnitofMeasureBackorder.fieldname) then begin
    ProcessBackOrderItems;
    CancelGridSort:= TRue;
  End
  Else Inherited;
  // Base class sets these fields to read only, we need to alow user to change them
  fbFlag:=(IstransLineCostLocked or (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnEditPurchaseCost') >=3));
  With TwwDBGrid(Sender) Do Begin
    If assigned(ColumnByName('TotalLineAmountInc')) then ColumnByName('TotalLineAmountInc').ReadOnly:= fbFlag;
    If assigned(ColumnByName('TotalLineAmount'))    then ColumnByName('TotalLineAmount').ReadOnly   := fbFlag;
    If assigned(ColumnByName('LineCost'))           then ColumnByName('LineCost').ReadOnly          := fbFlag;
    If assigned(ColumnByName('LineCostInc'))        then ColumnByName('LineCostInc').ReadOnly       := fbFlag;
  End;
End;

Procedure TPurchaseGUI.cboPartSpecsEnter(Sender: TObject);
Begin
  Inherited;
  qryPartsSpecs.Close;
  qryPartsSpecs.Params.ParamByName('xPartsID').asInteger := tblDetailsProductID.asInteger;
  qryPartsSpecs.Open;
End;

Procedure TPurchaseGUI.cboPartSpecsNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: Boolean);
Begin
  // inherited;  No Not In list;
End;

Procedure TPurchaseGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
Begin
  If Not modified then Exit;
  Inherited;
  { if the class is changed after creating the serial nos for the quanitty
    change the class of the serialnos to the newly selected class }
  If PO.Lines.ID = 0 then Exit;
End;

procedure TPurchaseGUI.tblDetailsAfterClose(DataSet: TDataSet);
begin
  inherited;
(*  if tbldetails.findfield(cPackWeightfieldField)  <> nil then tbldetails.fieldbyname(cPackWeightfieldField).free;
  if tbldetails.findfield(cPackcountfield)        <> nil then tbldetails.fieldbyname(cPackcountfield).Free ;*)

end;

Procedure TPurchaseGUI.tblDetailsAfterInsert(DataSet: TDataSet);
Begin
  Inherited;
  If AppEnv.CompanyPrefs.POMatchLineETAToHeaderETA then begin
    PO.Lines.ChangingETADate := true;
    try
      PO.Lines.ETADate := PO.ETADate;
    finally
      PO.Lines.ChangingETADate := False;
    end;
  end;
End;

procedure TPurchaseGUI.tblDetailsAfterScroll(DataSet: TDataSet);
begin
  inherited;
//
end;

Procedure TPurchaseGUI.tblDetailsCalcFields(DataSet: TDataSet);
Begin
  Inherited;
  If (Not tblmaster.active) OR (Not tblDetails.active) then Exit;
  { open the qry if it is not opened.
    Also makesure that the table is openend for the same PurchaseOrderID }
  If keyId <> 0 then begin
    If qryPOQuantities.ParamByName('xpurchaseOrderId').AsString <> PO.OriginalDocNumber Then
      If qryPOQuantities.active then qryPOQuantities.Close;
    If qryPOQuantities.active = False then begin
      qryPOQuantities.ParamByName('xpurchaseOrderId').AsString := PO.OriginalDocNumber;
      qryPOQuantities.Open;
    End;

    If qryPOQuantities.Locate('ProductId;SeqNo', varArrayof([PO.Lines.ProductID, PO.Lines.SeqNo]), []) then PO.Lines.OriginalQtyOrdered := qryPOQuantities.FieldByName('QtySold').asFloat;
    If PO.Lines.OriginalQtyOrdered = 0 then
      PO.Lines.OriginalQtyOrdered := PO.Lines.QtySold;
  End
  Else PO.Lines.OriginalQtyOrdered := PO.Lines.QtySold;
  tblDetailscOriginalCost.asFloat  := tblDetailsOriginalCost.asFloat;
End;

Function TPurchaseGUI.IstransLineCostLocked: Boolean;
begin
  Result := inherited IstransLineLocked;
  if result then exit;
  result := IsPOLocked;
  if result then exit;
  if accesslevel > 2 then result := true;

end;

Function TPurchaseGUI.IstransLineLocked: Boolean;
Begin
  Result := inherited IstransLineLocked;
  if result then exit;

  If PO.IsBOInvoiced  then begin
    LineLockMsg :='This transaction has a shipped backorder';
    result := True;
  End;

End;

function TPurchaseGUI.IsOktodeleteLine: Boolean;
begin
  Result := not(inherited IstransLineLocked);
  if not result then exit;

  If PO.IsBOInvoiced and (PO.Lines.QtyBackOrder<>0) then begin
    LineLockMsg :='This transaction has a shipped backorder';
    result := False;
    Exit;
  End;
  Result:= True;

end;

Function TPurchaseGUI.IsPOLocked: Boolean;
Begin
  result := False;
  If Not tblmaster.active then Exit;

  If fNewRec = False Then
    If PO.TotalAmountInc > 0 Then begin
      if PO.AnyApproved then begin
        TransAccessMsg := 'Purchase Oredr is Approved.';
        REsult := True;
        Exit;
      end;
      If ((PO.IsPaid) OR
          (CommonLib.Round(PO.TotalBalance, CurrencyRoundPlaces) <> CommonLib.Round(PO.TotalAmountInc, CurrencyRoundPlaces)) OR
          (AppEnv.CompanyPrefs.UseApprovalLevels and (not PO.Approved) and (not (TApprovalLevels.Approve(PO.Approvaltype, PO.TotalAmountInc, PO.Approved))))) then begin
            Result := true;
            Exit;
          end;
    end;
End;

Procedure TPurchaseGUI.LoadTransRec;
Begin
  Inherited;
  // self.tblDetailsUnitofMeasurePOLines.ReadOnly:= false;
  grdTransactions.ColumnByName('UnitOfMeasurePOLines').ReadOnly := False;
End;

Procedure TPurchaseGUI.LockPO;
Var
  intX: Integer; fIsPOLineLocked: Boolean;
  ctr:Integer;
  lIsLocked : boolean;
Begin
  { lock the po when it is beign invoiced - given the invoice no.
    This will not lock the invoiceno and invoice date : an option to
    correct a data entry mistake.
    The quantity fields in the PO is locked after creating a
    BO for the PO. }
  // IsPOLocked function make at least 2 calls to DB, so need to use local variable!!
  lIsLocked := IsPOLocked;
  For intX := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[intX] Is TwwDBDateTimePicker then TwwDBDateTimePicker(Self.Components[intX]).ReadOnly := lIsLocked //IsPOLocked
    Else If Self.Components[intX] Is TwwDBLookupCombo then TwwDBLookupCombo(Self.Components[intX]).ReadOnly  := lIsLocked //IsPOLocked
    Else If Self.Components[intX] Is TDBMemo then TDBMemo(Self.Components[intX]).ReadOnly                    := lIsLocked //IsPOLocked
    Else If Self.Components[intX] Is TDBEdit then TDBEdit(Self.Components[intX]).ReadOnly                    := lIsLocked //IsPOLocked
    Else If Self.Components[intX] Is TEdit then TEdit(Self.Components[intX]).ReadOnly                        := lIsLocked //IsPOLocked
    Else If Self.Components[intX] Is twwIButton then twwIButton(Self.Components[intX]).Enabled               := Not(lIsLocked); //IsPOLocked);
    If Self.Components[intX] Is TwwDBGrid Then
      If Not IsPOLocked then begin
        If Not(dgEditing In TwwDBGrid(Self.Components[intX]).Options) then TwwDBGrid(Self.Components[intX]).Options := TwwDBGrid(Self.Components[intX]).Options + [dgEditing];
      end else
        If dgEditing In TwwDBGrid(Self.Components[intX]).Options  then TwwDBGrid(Self.Components[intX]).Options := TwwDBGrid(Self.Components[intX]).Options - [dgEditing];

  End;


//  If Not IsPOLocked then begin
  if not lIsLocked then
  begin
    If keyId <> 0 then begin
      fIsPOLineLocked                         := IstransLineLocked;
      for ctr:= 0 to tbldetails.Fields.Count-1 do
        try
          grdtransactions.ColumnByName(tbldetails.Fields[ctr].fieldname).ReadOnly:= fIsPOLineLocked;
        Except
          // kill exception if the column doesn't exists
        end;
      cboProductR.ReadOnly                    := fIsPOLineLocked;
      if fIsPOLineLocked then begin
        if dgEditing      in grdTransactions.Options    then grdTransactions.Options    := grdTransactions.Options    - [dgEditing];
        if dgAllowInsert  in grdTransactions.KeyOptions then grdTransactions.Keyoptions := grdTransactions.KeyOptions - [dgAllowInsert];
      end;
    End;
  End;

  if not IstransLineCostLocked  then begin
        grdtransactions.ColumnByName(tblDetailsLineCost.fieldname).readonly               := (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnEditPurchaseCost') >=3);
        grdtransactions.ColumnByName(tblDetailsLineCostInc.fieldname).readonly            := (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnEditPurchaseCost') >=3);
        grdtransactions.ColumnByName(tblDetailsTotalLineAmount.fieldname).readonly        := (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnEditPurchaseCost') >=3);
        grdtransactions.ColumnByName(tblDetailsTotalLineAmountInc.fieldname).readonly     := (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnEditPurchaseCost') >=3);

        grdtransactions.ColumnByName(tblDetailsUnitofMeasureQtySold.fieldname).readonly   :=  (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanEditPOSoldQty') >=3);

  end else begin
        grdtransactions.ColumnByName(tblDetailsLineCost.fieldname).readonly               := True;
        grdtransactions.ColumnByName(tblDetailsLineCostInc.fieldname).readonly            := True;
        grdtransactions.ColumnByName(tblDetailsTotalLineAmount.fieldname).readonly        := True;
        grdtransactions.ColumnByName(tblDetailsTotalLineAmountInc.fieldname).readonly     := True;
        grdtransactions.ColumnByName(tblDetailsUnitofMeasureQtySold.FieldName).ReadOnly   := true;
        grdtransactions.ColumnByName(tblDetailsUnitofMeasureShipped.FieldName).ReadOnly   := true;
        grdtransactions.ColumnByName(tblDetailsUnitofMeasureBackorder.FieldName).ReadOnly := true;
  end;
  if PO.isboinvoiced then begin
        grdtransactions.ColumnByName(tblDetailsUnitofMeasureQtySold.FieldName).ReadOnly := true;
        grdtransactions.ColumnByName(tblDetailsUnitofMeasureShipped.FieldName).ReadOnly := true;
        grdtransactions.ColumnByName(tblDetailsUnitofMeasureBackorder.FieldName).ReadOnly := true;
  end;

  ApplyTransAccesslevel(IsPOLocked , IstransLineLocked);
  grdtransactions.ColumnByName(tblDetailsLinesOrder.FieldName).ReadOnly := true;
  if tblDetailsReceivedDate.readonly = false then
    Readonlyfield(tblDetailsReceivedDate.FieldName        ,((PO.Lines.cleanReceivedDate  >0) and  (PO.CleanID<>0 ) and not(EmployeeHasAccess('FnCanChangeReceiveDate'))) OR
                                                           ((PO.Lines.cleanReceivedDate  =0) and not(EmployeeHasAccess('FnCanChangeReceiveDateonNew')))  );
  { total fields are always readonly as they are calculated and displayed }
  txtSubTotal.ReadOnly         := true;
  txtTotalTax.ReadOnly         := true;
  txtTotalAmount.ReadOnly      := true;
  edtBaseForeignTotal.ReadOnly := true;
  edtTotalDiscount.ReadOnly    := true;
  btnEdit.Enabled :=  not(IstransLineCostLocked) and not (IsPOLocked) and (PO.IsBOInvoiced);
  if txtInvNumber.readonly = false then txtInvNumber.readonly :=IsPOLocked;
  if cboInvoiceDate.readonly = false then cboInvoiceDate.readonly :=IsPOLocked;
  tbldetailsLineDescription.readonly := True;

End;

procedure TPurchaseGUI.tblMasterAfterOpen(DataSet: TDataSet);
begin
  inherited;
  fxtotex := PO.totalamount;
  fxtotinc:= PO.totalamountinc;
  fxTax   := PO.totalTax;
  mnuSalesOrder.Enabled := (PO.Count >0) and (PO.SalesORderID<>0);
  mnuInvoice.Enabled    := (PO.Count >0) and (PO.invoiceID<>0);
  mnuAllocateSerialNumberstoHire.Visible := Appenv.CompanyPrefs.UseHire and
                                            (PO.Lines.Count >0) and
                                            (PO.HasEquipnSerailProduct);
  if PO.LinkPORef <> '' then TransTimerMsg('This is a linked PurChase Order for PO #' + inttostr(TPurchaseOrder.IDToggle(PO.LinkPORef)));

  ShowPickupFromHint;
end;
Procedure TPurchaseGUI.ShowPickupFromHint;
begin
//  if PO.pickupfromdesc <> '' then begin
    Showcontrolhint(btnPickUpFrom ,PO.pickupfromdesc);
    Showcontrolhint(lblPickUpFrom ,PO.pickupfromdesc);
//  end;

end;
procedure TPurchaseGUI.tblMasterBeforeOpen(DataSet: TDataSet);
var
  fs:String;
begin
  inherited;
  fs:=OriginalPODocNumber(KeyID);
  closedb(qryPOSeqno);
  qryPOSeqno.parambyname('Originalno').asString := fs;
  qryPOSeqno.parambyname('PurchaseOrderID').asInteger := KeyID;
  Opendb(qryPOSeqno);

  closedb(qryPONumber);
  qryPONumber.parambyname('Originalno').asString := fs;
  Opendb(qryPONumber);

end;

Procedure TPurchaseGUI.tblMasterCalcFields(DataSet: TDataSet);
Begin
  Inherited;
  (*If Trim(DataSet.FieldByName('SeqNo').AsString) <> '' Then begin
    DataSet.FieldByName('PONum_Seq').AsString :=
      Trim(DataSet.FieldByName('OrgPONumber').AsString) + '-' + Trim(DataSet.FieldByName('SeqNo').AsString);
    edt_PONum_Seq.Hint := DataSet.FieldByName('OrgPONumber').AsString;
    edt_PONum_Seq.ShowHint := true;
  end
  Else begin
    DataSet.FieldByName('PONum_Seq').AsString := '';
    edt_PONum_Seq.ShowHint := false;
  end;*)

  if not (Dataset.State in [dsEdit,dsCalcFields]) then EditDb(Dataset);
  if (Dataset.State in [dsEdit,dsCalcFields]) then begin
    if (KeyId > 0)  and (qryPOSeqnoSeqNo.asInteger >0) then
        DataSet.FieldByName('PONum_Seq').AsString  := Trim(DataSet.FieldByName('OrgPONumber').AsString) + '-' + inttostr(qryPOSeqnoSeqNo.asInteger)
    else DataSet.FieldByName('PONum_Seq').AsString  := '';
  end;
End;

Procedure TPurchaseGUI.grdTransactionsColEnter(Sender: TObject);
Var Key: Char;
Begin
  Inherited;
  { Original qty ordered is a display field, not allowed to change and
    setting the focus to the next field when gets the focus }
  Key := #9;
  If (grdTransactions.GetActiveField = tblDetailsOriginalQtyOrdered) Or (grdTransactions.GetActiveField = tblDetailsOriginalCost) then FormKeyPress(Sender, Key);
End;

Procedure TPurchaseGUI.grdTransactionsKeyPress(Sender: TObject; Var Key: Char);
Var ErrMsg: String; Editable: Boolean; POID: Integer; POLineId: Integer;
Begin
  Inherited;
  { if try to change the qty of a locked PO, take a confirmation to redirect to
    the Back order of the purchase order. }
  If (grdTransactions.GetActiveField = tblDetailsUnitofMeasureBackorder) Or (grdTransactions.GetActiveField = tblDetailsLineTax) then begin
    If (Key >= '0') And (Key <= '9') then Key := chr(0);
    Exit;
  End;
  If grdTransactions.GetActiveField = tblDetailsUnitofMeasureShipped then begin
    If tblDetailsUnitofMeasureShipped.ReadOnly then begin
      If (Key >= '0') And (Key <= '9') then begin
        If Not ValidData then Exit;
        { this method of he objects checks for any open backorder for the current PO for the
          selected product, and if found returns the PurchaseOrderId of the record.
          If the record not found, it returns the message the ErrMsg. }
        POID := PO.Lines.getCurrentBackOrderId(ErrMsg, Editable, POLineId);
        If Editable = False then begin
          CommonLib.MessageDlgXP_Vista(ErrMsg, mtWarning, [mbOk], 0);
          Exit;
        End;

        If POID = PO.ID then begin
        End Else Begin
          If CommonLib.MessageDlgXP_Vista('The Purchase Order is locked as it has a invoiced Back Order. ' + chr(13) + 'The quantity can be changed only in the Back Order.' + chr(13) +
              'Do you want to open the Back Order of this Purchase Order?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
            PostMessage(Self.Handle, SX_OpenPOofBO, POID, POLineId);
            Exit;
          End;
        End;
      End;
    End;
  End
  Else If (grdTransactions.GetActiveField = tblDetailsUnitofMeasureQtySold) And (Key = TAB) then begin
  End  Else If (grdTransactions.ColumnByName(grdTransactions.GetActiveField.fieldname).ReadOnly) And (Key <> TAB) then begin
    if SysUtils.SameText(grdTransactions.GetActiveField.fieldname, 'repairID') then begin
      CommonLib.MessageDlgXP_Vista('Please Alter Equipment Name Column to Adjust This Number.', mtWarning, [mbOk], 0);
    end else if SysUtils.SameText(grdTransactions.GetActiveField.fieldname, tbldetailsLineDescription.fieldname) then begin
      CommonLib.MessageDlgXP_Vista('This is the Description of Changes After Approval, Automatically Updated from '+NL+'"Change PO For Approval" and is Read-only.', mtWarning, [mbOk], 0);
    End Else Begin
      CommonLib.MessageDlgXP_Vista(trim('You do not have Access to change "' + grdTransactions.ColumnByName(grdTransactions.GetActiveField.fieldname).DisplayLabel + '"'+NL+NL+TransAccessMsg), mtWarning, [mbOk], 0);
    End;

  End;
End;

Procedure TPurchaseGUI.UpdatePrefSupp;
Var Msg: String;
Begin
  If PO.Lines.ProductID = 0 then Exit;
  If (Not AppEnv.CompanyPrefs.NoPreferredSuppQuestion) then begin
    If (uppercase(PO.Lines.Product.PreferedSupplierName) <> uppercase(PO.SupplierName)) then begin
      If PrefSuppList.IndexOf(PO.Lines.ProductName) > -1 then Exit
      Else Begin
        PrefSuppList.Add(PO.Lines.ProductName);
      End;
      If PO.LineAlreadyExixts4Product(PO.Lines.ProductID, PO.Lines.ID) then Exit;
      If PO.Lines.Product.Lock then begin
        Try
          If CommonLib.MessageDlgXP_Vista('Do you want to set ' + PO.SupplierName + ' as the Preferred Supplier for product ' + PO.Lines.Product.ProductName + '?', mtConfirmation, [mbYes, mbNo], 0)= mrYes then begin
            Try
              PO.Lines.getNewdataset('update tblparts set PREFEREDSUPP = ' + QuotedStr(PO.SupplierName) + ' where PartsId = ' + IntToStr(PO.Lines.ProductID), False);
            Finally
              PO.Lines.Product.UnLock;
              PO.Lines.Product.closeDB;
              PO.Lines.Product;
            End;
          End Else Begin

          End;
        Finally
          PO.Lines.Product.UnLock;
        End;
      End Else Begin
        Msg := 'Unable to update ' + PO.Lines.Product.ProductName + ' Preferred supplier as product is being updated by "' + PO.Lines.Product.UserLock.LockInfo.UserName + '" with: ' +
          PO.Lines.Product.UserLock.LockInfo.LockingForm;
        PO.ResultStatus.AddItem(true, rssWarning, 1, Msg, False);
      End;
    End;
  End;
End;

Procedure TPurchaseGUI.OpenPOOfBO(Var Msg: TMessage);
Begin
  If Not SavePO then Exit;
  tblmaster.Close;
  tblDetails.Close;
  Self.Close;
  With TPurchaseGUI.Create(Application) Do Begin
    keyId     := Msg.wParam;
    formstyle := fsMDIChild;
    bringtoFront;
    SetControlFocus(grdTransactions);
    If Msg.Lparam <> 0 then begin
      tblDetails.Locate('PurchaseLineId', Msg.Lparam, []);
      grdTransactions.SetActiveField('UnitofMeasureShipped');
    End;
  End;
End;

procedure TPurchaseGUI.OpenPrepayList;
begin
    if not HasLinkedPrepayments then begin
      MessageDlgXP_Vista('There Are No Pre-Payments For This Purchase Order.' , mtInformation, [mbOk],0);
      exit;
    end;

    if PO.dirty then
      if MessageDlgXP_Vista('This Will Save The Changes and Close The Purchase Order.  Do You Wish To Proceed?' , mtConfirmation, [mbyes,mbno],0) = mrno then exit;

    if not self.SavePO then exit;
    DetachAll;
    CommitAndNotify;
    openERPlistform('TOrderPrepaymentsGUI' , OrderPrepaymentBeforeOpen);

    Self.Close;
end;

procedure TPurchaseGUI.OrderPrepaymentBeforeOpen(Sender: TObject);
begin
 if not(sender is TOrderPrepaymentsGUI) then exit;
 TOrderPrepaymentsGUI(Sender).Originalno := PO.OriginalDocNumber;
end;

function TPurchaseGUI.TransStatustype: String;
begin
  result:= SimpleTypes_OrderStatus;
end;

Procedure TPurchaseGUI.tblDetailsUnitofMeasureQtySoldChange(Sender: TField);
// var
// option:Word;
Begin
  Inherited;
  (* if AppEnv.CompanyPrefs.PrintBarcodesOnOrder and not ProductInSelection then
    if fPrintBarCodesMode = 'ThisOne' then begin
    option := CommonLib.MessageDlgXP_Vista(Format('Do you want to print %d Barcodes for %s?',
    [tblDetailsUnitofMeasureQtySold.AsInteger,
    tblDetailsProductName.AsString]),
    mtConfirmation, [mbYes, mbNo], 0,nil , '','', False, nil,'Auto Print,No Printing');

    if option = mrYes then PrintBarcodes(True)
    else if Option = 100 then begin
    fPrintBarCodesMode := 'All';
    PrintBarcodes(True);
    end else if  Option = 101 then begin
    fPrintBarCodesMode := 'None';
    end;
    end else if  fPrintBarCodesMode = 'All' then begin
    PrintBarcodes(True);
    end; *)

  // if CommonLib.MessageDlgXP_Vista(Format('Do you want to print %d Barcodes for %s?',
  // [tblDetailsUnitofMeasureQtySold.AsInteger,
  // tblDetailsProductName.AsString]) + 'Yes to All,No to All',
  // mtConfirmation, [mbYes, mbNo], 0,nil , '','', False, nil,'Yes to All,No to All') = mrYes then
  // PrintBarcodes(True);
End;

procedure TPurchaseGUI.cboProductRAfterchange(Sender: TObject);
begin
  inherited;
  //DoOnProductChange;
end;


procedure TPurchaseGUI.cboShippingContainerChange(Sender: TObject);
begin
  inherited;
  //
end;

procedure TPurchaseGUI.cboShippingContainerCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  //
end;

Procedure TPurchaseGUI.UpdateMe(Const Cancelled: Boolean; Const aObject: TObject = Nil);
Begin
  If Cancelled then Exit;
    (*If assigned(LastComboAccessed) then begin
      //LastComboAccessed.Text := '';
      If (SysUtils.SameText(LastComboAccessed.Name, 'cboProductR')) Or (SysUtils.SameText(LastComboAccessed.Name, 'cboClientR')) then begin
        LastComboAccessed.LookupTable.Close;
        LastComboAccessed.LookupTable.Open;
      if not LastComboAccessed.LookupTable.Locate(LastComboAccessed.LookupField, LastComboAccessed.Text, []) then
          LastComboAccessed.Datasource.DataSet.FieldByName(LastComboAccessed.DataField).Clear;

      End;
    End;
    end;*)
  If (assigned(aObject) And (aObject Is TBaseInputGUI) And assigned(LastComboAccessed)) then begin
    If SysUtils.SameText(LastComboAccessed.Name, 'cboProductR') then begin
      With LastComboAccessed Do Begin
        LookupTable.Close;
        LookupTable.Open;
        If LookupTable.Locate('PartsId', TBaseInputGUI(aObject).keyId, []) then begin
          If Not(tblDetails.State In [dsEdit, dsInsert]) then tblDetails.Edit;
          PO.Lines.ProductName := LookupTable.FieldByName('PartName').AsString;
          PO.Lines.ProductID   := LookupTable.FieldByName('PartsId').asInteger;
          // cboProductRCloseUp(LastComboAccessed, LookupTable,tblDetails , True);
        End;
      End
    End Else If SysUtils.SameText(LastComboAccessed.Name, 'cboClientR') then begin
      With LastComboAccessed Do Begin
        LookupTable.Close;
        LookupTable.Open;
        If LookupTable.Locate('ClientID', TBaseInputGUI(aObject).keyId, []) then begin
          If Not(tblmaster.State In [dsEdit, dsInsert]) then tblmaster.Edit;
          PO.clientID     := LookupTable.FieldByName('ClientId').asInteger;
          PO.SupplierName := LookupTable.FieldByName('Company').AsString;
          doOnclientchange;
        End;
      End
    End;
  End;
  inherited UpdateMe(cancelled, aObject);
End;

Procedure TPurchaseGUI.CompleteComboNotInList(Const aObserver: TObject);
Begin
  If assigned(LastComboAccessed) then SetControlFocus(LastComboAccessed);
  InComboNotinList := False;
End;

procedure TPurchaseGUI.CopyDocketnoToClipboard;
var
//  x, y:Integer;
  Buff:String;
  bookMark : TBookMark;
begin
  bookMark := tblDetails.GetBookmark;
  Try
    Buff := 'PurchaseOrderId'#9'SeqNo'#9'DocketNumber'#13#10;
    tblDetails.First;
    while not tblDetails.eof do
    begin
      buff := buff + tbldetailsPurchaseOrderId.AsString + #9 +
        tblDetailsSeqNo.AsString + #9 +
        '"' + tblDetailsDocketNumber.AsString + '"'#13#10;
      tblDetails.next;
    end;
  Finally
    tblDetails.GotoBookmark(bookMark);
    tblDetails.FreeBookmark(bookMark);
  End;
  (*
  Buff:= '';
  for y := 0 to grdMatrix.RowCount-1 do begin
    for x := 0 to grdMatrix.Colcount-1 do begin
      if (x=0) and (y=0) then begin
        if GrpAmountField.itemindex = 0 then Buff:= 'Cost' else Buff:= 'Price';
      end else begin
        if (x<>0) then Buff:= Buff + #9;
        Buff:= Buff + grdMatrix.cells[x,y];
      end;
    end;
    Buff:= Buff + #$D#$A;
  end;
  *)
  Clipboard.asText:= Buff;
end;

procedure TPurchaseGUI.SendCreateEmail;
var
  msgTo: string;
begin
  if not NeedEmailOnSave then
    exit;

  if not AppEnv.CompanyPrefs.EnablePOCreateEmail then
    exit;

  msgTo := PO.ContactEmail;
  if msgTo = '' then
    msgTo := PO.Supplier.Email;

  TCorrespondenceGui.EmailSupplier(msgTo,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POCreateEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POCreateEmailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger, true);
end;

function TPurchaseGUI.SendPrintEmail: boolean;
var
  msgTo: string;
begin
  msgTo := PO.ContactEmail;
  if msgTo = '' then msgTo := PO.Supplier.Email;

  result := TCorrespondenceGui.EmailSupplier(msgTo,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POPrintEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POPrintEmailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);
end;

function TPurchaseGUI.SendPrintEmailSilent: boolean;
var
  toEmail: string;
begin
  toEmail := PO.ContactEmail;
  if toEmail = '' then
    toEmail := PO.Supplier.Email;

  result := TCorrespondenceGui.EmailSupplier(toEmail,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POPrintEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POPrintemailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger,true);
end;

function TPurchaseGUI.SendPrintSMS: boolean;
var
  number: string;
begin
  result := false;
  number := GetOrAddMobileNumber;
  if number = '' then exit;

  result := TCorrespondenceGui.SMSSupplier(number,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POPrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);
end;

function TPurchaseGUI.SendPrintSMSSilent: boolean;
var
  toMobile: string;
begin
  toMobile := PO.ContactMobile;
  if toMobile = '' then
    toMobile := PO.Supplier.Mobile;

  result := TCorrespondenceGui.SMSSupplier(toMobile,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POPrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger, true);
end;

Procedure TPurchaseGUI.SetComboFocus(Var Msg: TMessage);
Begin
  If assigned(LastComboAccessed) Then
    If SysUtils.SameText(LastComboAccessed.Name, 'cboProductR') then grdTransactions.SetActiveField('ProductName')
    Else SetControlFocus(LastComboAccessed);
End;

procedure TPurchaseGUI.SetDatasetconn;
begin
  inherited;
  QryPurchaseLinePackWeightLinesSum.Connection := MyConnection;
end;

procedure TPurchaseGUI.cboClientLookupAfterOpen(DataSet: TDataSet);
begin
  inherited;
  //MakepackweightFields(PO.PurchaseLinePackWeightSum.dataset);
end;


Procedure TPurchaseGUI.cboBaseForeignCurrencyCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
Begin
  If Not modified then Exit;
  Inherited;
  If cboBaseForeignCurrencyCode.Text <> Self.tblMasterForeignExchangeCode.AsString then cboBaseForeignCurrencyCode.Text := Self.tblMasterForeignExchangeCode.AsString;
  If (PO.Supplier.ForeignExchangeCode = AppEnv.RegionalOptions.ForeignExDefault) And (PO.Supplier.ForeignExchangeCode <> cboBaseForeignCurrencyCode.Text) then begin
    If PO.UserLock.Lock('tblclients', PO.Supplier.ID) then begin
      PO.ExecuteSQL('update tblClients Set ForeignExchangeSellCode = ' + QuotedStr(cboBaseForeignCurrencyCode.Text) + ' where clientId = ' + IntToStr(PO.Supplier.ID), true);
      (* PO.Supplier.ForeignExchangeCode:= cboBaseForeignCurrencyCode.Text;
        PO.Supplier.PostDb; *)
    End;
  End;
End;

Procedure TPurchaseGUI.cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
Begin
  If Not modified then Exit;
  Inherited;

End;

Procedure TPurchaseGUI.cboTaxCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
Begin
  If Not modified then Exit;
  Inherited;

End;

Procedure TPurchaseGUI.cboUnitOfMeasureCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
Begin
  If Not modified then Exit;
  Inherited;

End;

procedure TPurchaseGUI.CheckForSNEquipmentnAllocateForHire;
begin
  If not AppEnv.CompanyPrefs.UseHire then Exit;
  if not PO.HasEquipnSerailProduct then Exit;

  OpenERPListFormultiselectModal('TProductSerialNumbersForHireGUI' , initSerialsAllocatedInPO , OnSelectSerialsAllocatedInPO)
end;
Procedure TPurchaseGUI.initSerialsAllocatedInPO(Sender:Tobject);
begin
    if not(Sender is TProductSerialNumbersForHireGUI) then exit;
    TProductSerialNumbersForHireGUI(Sender).PurchaseorderId := PO.ID;
    TProductSerialNumbersForHireGUI(Sender).OnGidMultiselect := OnSerialsAllocatedInPOMultiselect;
end;
Procedure TPurchaseGUI.OnSelectSerialsAllocatedInPO(Sender: TwwDbGrid);
begin
    if not(Assigned(Sender.owner)) or not(Sender.owner is TProductSerialNumbersForHireGUI) then exit;
    TProductSerialNumbersForHireGUI(Sender.owner).CreateEquipsForSelectedSerials;
end;
Procedure TPurchaseGUI.OnSerialsAllocatedInPOMultiselect(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  if Selecting then begin
    if grid.datasource.dataset.findfield('Details') <> nil then
      if grid.datasource.dataset.findfield('Details').asInteger =1 then begin
        Accept := False;
        Exit;
      end;

    if grid.datasource.dataset.findfield('EquipmentId') <> nil then
      if grid.datasource.dataset.findfield('EquipmentId').asInteger >0 then begin
        Accept := False;
        Exit;
      end;

  end;
end;
Procedure TPurchaseGUI.FormKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
  if (ssCtrl in Shift ) and (Key in [ord('R') , ord('O') , ord('U') , ord('N') , ord('D'), ord('F'), ord('I'), ord('X')]) then
  begin
      KeysPressed :=KeysPressed +chr(key);
    if Sysutils.SameText(KeysPressed , 'ROUNDFIX') then
    begin
      ExecuteSQL('INSERT IGNORE INTO `tblclass` (`ClassName`, `SiteCode`) VALUES ("Roundfix", "RND");');
      btnfix.visible := True;
    end;
  end
  else
    KeysPressed := '';

(*  if ssCtrl in shift then
  begin
    if (Key = ord('V')) or (Key =Ord('v')) then
    begin
      ImportDocketnoFromClipBoard;
      Key := 0;
    end
    else if (Key = ord('C')) or (Key =Ord('c')) then
    begin
      CopyDocketnoToClipboard;
      Key := 0;
    end;
  end;*)
  if Key <> 0 then
    inherited;
End;

Procedure TPurchaseGUI.Shiptodept(Sender: TwwDbGrid);
var
  classID:Integer;
begin
    classId := Sender.Datasource.dataset.fieldbyname('classID').asInteger;
    if classId <> 0 then
      PO.Shiptodept(classId);
(*var
  classID:Integer;
  s:String;
  DeptClassObj : TDeptClass;
  ShippingAddressObj :TShippingAddress;
begin
    classId := Sender.Datasource.dataset.fieldbyname('classID').asInteger;
    if classId <> 0 then begin
      PO.ShiptoClassID := ClassId;
      PO.PostDB;
      DeptClassObj := TDeptClass.create(Self);
      try
          DeptClassObj.connection := PO.connection;
          DeptClassObj.Load(ClassId);
          ShippingAddressObj := TShippingAddress.create(Self);
          try
            ShippingAddressObj.connection := PO.connection;
            ShippingAddressObj.LoadSelect('DeptID=' + inttostr(DeptClassObj.Id)+' and DeptAddresstype =' + iif(DeptClassObj.UseAddress , '"D"', '"C"'));

            ShippingAddressObj.connection.beginNestedTransaction;
            try
              if ShippingAddressObj.count =0 then begin
                  ShippingAddressObj.New;
                  ShippingAddressObj.DeptID         := DeptClassObj.ID;
                  ShippingAddressObj.CompanyName := Appenv.CompanyInfo.Companyname;
                  if DeptClassObj.UseAddress then begin
                      ShippingAddressObj.DeptAddresstype  := 'D';
                      ShippingAddressObj.ShipAddress      := DeptClassObj.Street;
                      ShippingAddressObj.ShipAddress1     := DeptClassObj.Street2;
                      ShippingAddressObj.ShipAddress2     := DeptClassObj.Street3;
                      ShippingAddressObj.ShipCity         := DeptClassObj.Suburb;
                      ShippingAddressObj.ShipPostCode     := DeptClassObj.Postcode;
                      ShippingAddressObj.ShipState        := DeptClassObj.State;
                      ShippingAddressObj.ShipCountry      := DeptClassObj.Country;
                      ShippingAddressObj.AddressValidated := true;
                  end else begin
                     ShippingAddressObj.DeptAddresstype   := 'C';
                      ShippingAddressObj.ShipAddress      := Appenv.CompanyInfo.Address;
                      ShippingAddressObj.ShipAddress1     := Appenv.CompanyInfo.Address2;
                      ShippingAddressObj.ShipAddress2     := Appenv.CompanyInfo.Address3;
                      ShippingAddressObj.ShipCity         := Appenv.CompanyInfo.City;
                      ShippingAddressObj.ShipPostCode     := Appenv.CompanyInfo.Postcode;
                      ShippingAddressObj.ShipState        := Appenv.CompanyInfo.State;
                      ShippingAddressObj.ShipCountry      := Appenv.CompanyInfo.Country;
                      ShippingAddressObj.AddressValidated := true;
                  end;
                  ShippingAddressObj.PostDB;
                  if ShippingAddressObj.Save then begin
                    ShippingAddressObj.connection.commitNestedTransaction;
                  end else begin
                    ShippingAddressObj.connection.RollbackNestedTransaction;
                  end;
              end;
            Except
              on E:Exception do begin
                  ShippingAddressObj.connection.RollbackNestedTransaction;
              end;
            end;
            if ShippingAddressObj.count >0 then begin
              PO.ShiptoId :=ShippingAddressObj.ID;
              PO.ShipTo := ShippingAddressObj.CompanyName + #13#10 +  ShippingAddressObj.AddressAsString;
              PO.PostDB;
              Exit;
            end;
          finally
            Freeandnil(ShippingAddressObj);
          end;

          s:= DeptClassObj.Address;
          if s<> '' then begin
            PO.shipto := s;
            PO.PostDB;
          end;
      finally
        Freeandnil(DeptClassObj);
      end;
    end;*)
end;
Procedure TPurchaseGUI.UseAddressClasslist(Sender:TObject);
begin
  if Sender is TBaseListingGUI then
    TBaseListingGUI(Sender).FilterString := 'UseAddress ="T"';
end;

Procedure TPurchaseGUI.LoadEquipProducts;
var
  qry :TERPQuery;
begin
  Qry := DbSharedObj.GetQuery(PO.Connection.Connection);
  try
    closedb(Qry);
    Qry.SQL.Text := 'select '+
                    ' Distinct P.partsId, P.partname '+
                    ' from tblequipment E inner join tblParts P on P.partsId = E.ProductId and E.OnHire ="T" '+
                    ' Left join tblpqa pqa on pqa.productId = p.partsId '+
                    ' Where ifnull(pqa.pqaID,0)=0 '+
                    ' order by partname';
    Qry.Open;
    if Qry.recordcount >0 then begin
      if MessageDlgXP_Vista('There are ' + inttostr(Qry.RecordCount)+' New Equipment Products. Do you want to add those products automatically?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
        Qry.First;
        While Qry.Eof = False do begin
          PO.Lines.New;
          PO.Lines.ProductName := Qry.FieldByName('Partname').AsString;
          PO.Lines.PostDB;
        end;
      end;

    end;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;
procedure TPurchaseGUI.DoAllReceivedIterate(const Sender: TBusObj;
  var Abort: boolean);
begin
  If Not(Sender Is TPurchaseOrderLine) then
    Exit;
  if TPurchaseOrderLine(Sender).QtySold <> TPurchaseOrderLine(Sender).QtyShipped then
  begin
//    Abort := true;
    DoEmail := False;
  end;
  if AppEnv.CompanyPrefs.EmailEmployeeOnReceipt  then
    if qryTemp.Locate('ProductId', TPurchaseOrderLine(Sender).ProductID, [])  then
    begin
      if TPurchaseOrderLine(Sender).QtyShipped <> qryTemp.FieldByName('Shipped').asFloat then
        DoEmployee := true;
    end;
end;

Procedure TPurchaseGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; Const EventType, Value: String);
Var
  option: Word;
  s: String;
  fd:TDateTime;
  msg: string;
  Line : TPurchaseOrderLine;
Begin
  If ((Sender Is TSalesBase) Or (Sender Is TSalesLineBase)) And ((EventType = BusObjEvent_Dataset) And (Value = BusObjEvent_AssignDataset)) then begin
    Exit;
  End;
  Inherited;
        if self.IsFlag('DisableAllocation') then
          If (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_QtyShipped) then begin
            if not self.IsFlag('DisableAllocation') then begin
              TPurchaseOrderLine(Sender).postdb;
              TfmAllocation.DoBinBatchform(TPurchaseOrderLine(Sender).PQA, Self);
            end;
          End;
{-->}   If (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_QtyShipped) then begin
          if AppEnv.CompanyPrefs.PrintLabelsOnReceipt and (*(tblMasterSalesglobalref.AsString <> '')*)(TPurchaseOrderLine(Sender).SaleLineId <> 0) then begin
            if MessageDlgXP_Vista('Do You Want To Print Label For This Product?', mtConfirmation, [mbYes, mbNo], 0)=mrYes then
              PrintProductLabels(TPurchaseOrderLine(Sender).PurchaseOrderId, TPurchaseOrderLine(Sender).ProductID);
          end;
{-->}   end else If (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_BoxesShipped) then begin
          line := TPurchaseOrderLine(Sender);
          s := IntToStr(line.BoxesReceived);
          if line.BoxesReceived = 1 then
            s := 'Do You Want To Print Label For The Box Received For This Product?'
          else
            s := 'Do You Want To Print ' + s + ' Labels For The ' + s + ' Boxes Received For This Product?';

          if MessageDlgXP_Vista(s, mtConfirmation, [mbYes, mbNo], 0)=mrYes then
            PrintBoxLabels(Line);
{-->}   end;

{-->}   If (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_Equipment) then begin
          OnEquipemntchange;
{-->}   end else If (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_SupplierChanged) then begin
          if confirmtoautoloadHireProducts then begin
            confirmtoautoloadHireProducts := False;
            LoadEquipProducts;
          end;
{-->}   end else If (EventType = BusObjEvent_Change) And (Value = BusObjEvent_POETADateChanged) then begin

          if AppEnv.CompanyPrefs.MatchInvoiceDateToETADate then
            if (PO.ETADate <> 0) and (PO.SupplierInvoiceDate<>0) and (trim(PO.SupplierInvoiceNumber) <> '') then
          (*    if MessageDlgXP_Vista('As Per Company Preferences, The ''Invoice Date'' Matches the ''ETA Date''. '+NL+
               'Invoice Date is ' + Quotedstr(FormatDatetime(ShortDAteformat, PO.SupplierInvoiceDate))+'.'+NL+NL+
               'Do You Want to Change this To the ''ETA Date''  ' + Quotedstr(FormatDatetime(ShortDAteformat, PO.ETADate))+'?', mtConfirmation, [mbYes, mbNo], 0) = mryes then*)
                PO.SupplierInvoiceDate := PO.ETADAte;


          if (PO.Lines.ChangingETADate =False) and (PO.ChangingETADate =False) then begin
            PO.Lines.ChangingETADate:= true;
            try
              If AppEnv.CompanyPrefs.POMatchLineETAToHeaderETA then begin
                PO.Lines.IterateRecords(DoPOMatchLineETAToHeaderETA);
                MessageDlgXP_Vista('This is Changing All the Line''s ''ETA Date'' to the Header''s ''ETA Date'' -' + FormatDateTime(FormatSettings.ShortDateFormat, PO.ETADate) + ' .', mtInformation, [mbOk], 0);
              End;
            finally
              PO.Lines.ChangingETADate:= False;
            end;
          end;
{-->}   end else If (EventType = BusObjEvent_Change) And (Value = BusObjEvent_POLinesETADateChanged) then begin
          if (PO.Lines.ChangingETADate =False) and (PO.ChangingETADate =False) and (PO.Lines.ProductID<>0) then begin
            PO.ChangingETADate:= true;
            try
              If AppEnv.CompanyPrefs.POMatchHeaderETAToLineETA then begin
                PO.Lines.PostDb;
                fd:=PO.Lines.SmalletstETADate;
                if fd<> 0 then PO.ETADate := fd;
                PO.PostDB;
              end;
            finally
              PO.ChangingETADate:= False;
            end;
          end;
{-->}   end else If (EventType = BusObjEvent_Change) And (Value = BusObjEventVal_OrderTotalsCalculated) then begin
{-->}   end else If (EventType = BusObjEvent_Change) And (Value = BusObjEventVal_Approved) then begin
{-->}   end else If (EventType = BusObjEvent_OpenInvForm) And (strtoint(Value) <> 0) then begin
          InvoiceToOpen := strtoint(Value);
{-->}   end else if  (EventType = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
          if Sender is TPurchaseLinePackWeightLinesSum then TPurchaseLinePackWeightLinesSum(Sender).DataSet := QryPurchaseLinePackWeightLinesSum;
{-->}   end else if  (EventType = BusobjEvent_Event) then begin

{-->}   end else if  (EventType = BusObjEvent_Change) And (Value = BusObjEventVal_ClientID) then begin
          EmailContactID                 := 0;
          lblBaseForeignTotal.Visible    :=  (not SameText(PO.ForeignExchangeCode, AppEnv.RegionalOptions.ForeignExDefault)); //  (PO.ForeignExchangeRate <> 1);
          edtBaseForeignTotal.Visible    := (not SameText(PO.ForeignExchangeCode, AppEnv.RegionalOptions.ForeignExDefault));
          lblEstimatedForeignAmt.Visible := (not SameText(PO.ForeignExchangeCode, AppEnv.RegionalOptions.ForeignExDefault));
          EstimatedForeignAmt.Visible    := (not SameText(PO.ForeignExchangeCode, AppEnv.RegionalOptions.ForeignExDefault));
{-->}   end else if  (EventType = BusObjEvent_OpenSOForm) And (strtoint(Value) <> 0) then begin
          SOToOpen := strtoint(Value);
{-->}   end else if  (EventType = BusObjEvent_Change) and  (Value = BusObjEvent_PromptBarCode) then begin
          if (tblDetailsUnitofMeasureShipped.AsFloat > 0) then begin
            s := grdTransactions.GetActiveField.fieldname;
            If (AppEnv.CompanyPrefs.PrintBarcodesOnReceival And
            (SameText(s, 'UnitofMeasureShipped'))) Or (AppEnv.CompanyPrefs.PrintBarcodesOnReceival And (SameText(s, 'UnitofMeasureQtySold'))) and
            (not devmode) Then
              If fPrintBarCodesMode = 'ThisOne' then begin
                option := CommonLib.MessageDlgXP_Vista('Do you want to print ' + IntToStr(QtyforBarcodeprinting(SameText(s, 'UnitofMeasureQtySold'))) + ' Barcodes for ' + tblDetailsProductName.AsString +
                    '?', mtConfirmation, [mbYes, mbNo], 0, Nil, '', '', False, Nil, 'Auto Print,No Printing');
                If option = mrYes then PrintBarcodes(SameText(s, 'UnitofMeasureQtySold'))
                else If option = 100 then begin
                  fPrintBarCodesMode := 'All';
                  PrintBarcodes(SameText(s, 'UnitofMeasureQtySold'));
                end else if option = 101 then begin
                  fPrintBarCodesMode := 'None';
                end;
              end else if fPrintBarCodesMode = 'All' then begin
                PrintBarcodes(SameText(s, 'UnitofMeasureQtySold'));
              end;
          end;
{-->}   end else if (EventType = BusObjEvent_Warning) then begin
          If Value = BusobjEventVal_OrderQtyLessThanSuppMinOrderQty then begin
            CommonLib.MessageDlgXP_Vista('The Order quantity is less than the suppliers minimum order quantity of ' + FloatToStr(TPurchaseOrderLine(Sender).Product.ExtraBuyPrice.MinimumOrderQty),
              mtInformation, [mbOk], 0);
          end;
{-->}   end else if (EventType = BusObjEvent_Error) And (value = BusobjEventVal_FailedLandedCostValidation) then begin
          { laned costs don't total 100 % }
            Msg := 'You Have Allocated ' + FloatToStrF(PO.PercentageUseImportCost, ffNumber, 15, 2) +
                   '% Of the Landed Costs, 100% should be the Maximum Allocated.' + #13#10 + #13#10 +
                   'Do you wish the Landed costs for all lines on the Purchase Order to be Re-Calculated to Match the Total Landed Cost?';

           if CommonLib.MessageDlgXP_Vista(msg,  mtInformation, [mbYes, mbNo], 0) = mrYes then begin
             PO.ReDistributeLineLandedCost;
           end;

{-->}   end else if (EventType = BusObjEvent_Change) And (value = BusObjEventVal_ProductChanged) then begin
          (* DoOnProductchange; *)
        if TPurchaseOrderLine(Sender).Product.ShowPurchaseProductPopUp then
          DelayMessageDlg(TSalesLineBase(Sender).Product.ProductPurchasePopUpNotes, mtInformation, [mbOK], 0);
            //CommonLib.MessageDlgXP_Vista(TPurchaseOrderLine(Sender).Product.ProductPurchasePopUpNotes, mtInformation, [mbOK], 0);
{-->}   end else if (EventType = BusObjEvent_Change) And (value = BusObjEvent_CostRecalculateonQtychange) then begin
            TransTimerMsg('Cost for '+TPurchaseOrderLine(Sender).Productname+' is Re-calculated based on the Produc''s Cost as the Purchase Quantity is Changed');
{-->}   end else if (EventType = BusObjEvent_Change) And (value = BusObjEvent_CrosscompanySaleCreated) then begin
           Application.ProcessMessages;
           SetControlfocus(txtComments);
{-->}   end else if (EventType = BusObjEvent_Change) And (value =  BusObjEvent_POShipToClass) then begin
          //OpenERPListFormSingleselect('TClassListGUI' , Shiptodept, UseAddressClasslist);
          OpenERPListFormSingleselectModal('TClassListGUI' ,Shiptodept, UseAddressClasslist);
{-->}   end else if (EventType = BusObjEvent_Change) And (value =  BusObjEvent_POShipTo) then begin
(*          chkShipToClass.checked          := PO.ShipToClass;
          chkShipToCustomer.checked       := PO.ShipToCustomer;
          chkShipToDefaultAddress.checked := PO.ShipToDefaultAddress;*)
{-->}   end else if (EventType = BusObjEvent_Change) And (value =  BusObjEvent_POLineClassChanged) and (Sender is TPurchaseorderline) then begin
          if not cboClassQry.Locate('ClassId', TPurchaseorderline(Sender).LineClassId, []) then begin
            TransTimerMsg('Selected '+appenv.DefaultClass.ClassHeading +' '+ quotedstr(PO.Lines.LineClassName)+' Doesn''t Exists,  choosing the First '+appenv.DefaultClass.ClassHeading +' in the List' );
            cboClassQry.First;
            PO.Lines.LineClassName:= cboClassQry.fieldbyname('ClassName').asString;
            PO.Lines.LineClassId  := cboClassQry.fieldbyname('ClassID').asInteger;
          end;
        end else if (EventType = BusObjEvent_Change) and  (Value = BusObjEvent_PickupFrom) then begin
            Showcontrolhint(lblPickUpFrom ,PO.PickupFromDesc);
        end else if (EventType = BusObjEvent_Dataset) and  (Value = BusObjEvent_OnDataIDChange) and (Sender is TPurchaseOrder) then begin
            Showcontrolhint(lblPickUpFrom ,PO.PickupFromDesc);
{-->}   End;
End;

procedure TPurchaseGUI.DoChangeShippingContainer(Sender: TObject);
begin
  //if tblDetailsShipContainerName.AsString = '' then begin
  //  CommonLib.MessageDlgXP_Vista('This Purchase Line is not currently listed on any Shipping Container.', mtInformation, [mbOk], 0);
  //  exit;
  //end;
  OpenERPListFormSingleselectModal('TfrmShippingContainerList',DonOnShippingContainerSelect);
end;

procedure TPurchaseGUI.DoCopyValuesForSelectedRows(Value: TDateTime);
var
  i : integer;
begin
  grdTransactions.DataSource.DataSet.DisableControls;
  try
    for i := 0 to grdTransactions.SelectedList.Count - 1 do begin
      grdTransactions.DataSource.DataSet.GotoBookmark(grdTransactions.SelectedList.Items[i]);
      grdTransactions.DataSource.DataSet.Edit;
      grdTransactions.DataSource.DataSet.FieldByName('ETADate').AsDateTime := Value;
    end;
  finally
    grdTransactions.DataSource.DataSet.EnableControls;
  end;
end;

procedure TPurchaseGUI.DoOnAddressListGridDataSelect(Sender: TwwDbGrid);
var
  ShipAddress: TShippingAddress;
begin
    ShipAddress := TShippingAddress.Create(nil, TMyQuery(Sender.DataSource.DataSet).Connection);
    try
      ShipAddress.Load(Sender.DataSource.DataSet.FieldByName('ShipAddressId').AsInteger);
      PO.ShipToId := ShipAddress.ID;
      PO.ShipTo := ShipAddress.CompanyName + #13#10 +  ShipAddress.AddressAsString;
    finally
      ShipAddress.Free;
    end;
end;

Procedure TPurchaseGUI.DoOnProductchange;
var
  NewProductId: Integer;
begin
  if Matrixshown then exit;
  //NewProductId := ProductOptionsShown;
  //if NewProductId = -1 then exit;
  //PO.Lines.ProductID := NewProductId;
    if ProductOptionsShown >0 then
      Exit;
  inherited;
  if (IsProductDiscontinued(tblDetails.FieldByName('ProductID').AsInteger)) and (Self.ClassName = 'TPurchaseGUI') then begin
    CommonLib.MessageDlgXP_Vista('The product ' + cboProductQry.FieldByName('partname').AsString + ' has been discontinued!',
      mtWarning, [mbOK], 0);
    Order.Lines.Deleted := True;
    fbRecordCancelled := true;
    grdTransactions.SetActiveField('ProductPrintName');
  end;

  If cboProductR.ReadOnly Then
    Exit;
  If PO.Lines.Deleted then begin
    PO.Lines.PostDB;
    Exit;
  End;
  SaveLastComboAccessed(fLastComboAccessed ,cboProductR);
  UpdatePrefSupp;
  If (AppEnv.CompanyPrefs.StoreForeignCurrencyValue) then begin
    bPartSelected := true;
  End;

  tblDetails.Edit;
  Application.ProcessMessages;

  If Not fbRecordCancelled then begin
    tblDetails.Edit;
  End Else Begin
    fbRecordCancelled := False;
  End;

  If (AppEnv.CompanyPrefs.StoreForeignCurrencyValue) then begin
    bPartSelected := False;
  End;

  If tblDetailsClassID.asInteger <> 0 Then
    If cboClass.LookupTable.Locate('ClassId',tblDetailsClassID.asInteger, []) Then
    begin
      cboClassCloseUp(cboClass, cboClass.LookupTable, grdTransactions.DataSource.DataSet, true);
      tblDetails.Edit;
    end;

  if  (PO.Lines.QtySold=0) and (PO.Lines.packweightField=0)   then DoPackWeight;
  PO.Lines.EditDB;
  tblDetailsGeneralNotes.Value := cboProductQryGeneralNotes.Value;
end;

Procedure TPurchaseGUI.DoPackWeight;
begin
  if AccessLevel <=3 then
    if {Appenv.CompanyPrefs.EnablePackWeight}PO.Lines.Product.EnablePackWeight then
      if (PO.Lines.ProductID <>0) and IsInvProduct(PO.Lines.ProductType)  then begin
        if TfmPurchasePackWeight.DoPackWeight(Self, PO.Lines) then begin
          grdTransactions.SetActiveField(tblDetailsUnitofMeasureQtySold.FieldName);
        end;
      end;
end;

Procedure TPurchaseGUI.DoPOMatchLineETAToHeaderETA(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TPurchaseOrderLine) then Exit;
  TPurchaseOrderLine(Sender).ETADate := PO.ETADate;
  TPurchaseOrderLine(Sender).PostDB;
End;

Procedure TPurchaseGUI.cboCreationDateExit(Sender: TObject);
Begin
  // template is doing the checking for AppEnv.CompanyPrefs.ClosingDate which is done in the object
  // so skip the inherited;
  // inherited
//  ValidateCreationDate;
  if not ValidateCreationDateWithAccess('FnAllowFutureDateForPODate', 'FnAllowPastDateForPODate') then
    PO.CancelDb;

  (*if fdCreationdate<>cboCreationDate.Date  then
    if cboCreationDate.Date > now then
        CommonLib.MessageDlgXP_Vista('You Have Set This Date to the future!', mtWarning, [mbOK], 0);*)
End;


Procedure TPurchaseGUI.grdTransactionsExit(Sender: TObject);
Begin
  // skip the inherited as the form is using busobj
  // inherited;

End;

Procedure TPurchaseGUI.txtShipToExit(Sender: TObject);
Begin
  Inherited;
  DeleteEmptyLines(TDBMemo(Sender));
End;

Procedure TPurchaseGUI.txtShipToEnter(Sender: TObject);
Begin
  Inherited;
  DeleteEmptyLines(TDBMemo(Sender));
End;

Function TPurchaseGUI.QtyforBarcodeprinting(FromOrdered: Boolean): Integer;
Begin
  If FromOrdered then result := tblDetailsUnitofMeasureQtySold.asInteger
  Else result                := tblDetailsUnitofMeasureShipped.asInteger;
End;
Procedure TPurchaseGUI.initProductQtyBinETA(Sender: TObject);
begin
  With TfrmProductQtyBinETA(Sender) Do Begin
        TfrmProductQtyBinETA(Sender).Connection := Self.MyConnection;
        TfrmProductQtyBinETA(Sender).keyId      := tblDetailsProductID.asInteger;
        TfrmProductQtyBinETA(Sender).ClassID    := tblDetailsClassID.asInteger;
        TfrmProductQtyBinETA(Sender).POObj := PO;

        If tblDetails.FieldByName('SaleLineID').asInteger > 0 then begin
          TfrmProductQtyBinETA(Sender).SaleLineID := tblDetails.FieldByName('SaleLineID').asInteger;
        End Else TfrmProductQtyBinETA(Sender).PurchaseLineID := tblDetails.FieldByName('PurchaseLineID').asInteger;
  End;
end;
Procedure TPurchaseGUI.QuantityAndBinLocations1Click(Sender: TObject);
begin
    if OpenERPFormModal('TfrmProductQtyBinETA' , 0 , initProductQtyBinETA) = mrok then
      Setcontrolfocus( txtComments);
End;
procedure TPurchaseGUI.MakeEquipmentPartsLines(Const Sender: TBusObj; Var Abort: Boolean);
var
  s:String;
begin
  stepProgressbar;
  if not(Sender is TEquipmentParts) then exit;
  if not (TEquipmentParts(Sender).active) then exit;
  s:= PO.equipmentname +'#' + inttostr( PO.ID);
  if TAreaCode.MakeNewArea(s , PO.connection)>0 then begin
    PO.lines.new;
    PO.lines.AreaCode:= s;
    PO.lines.Productname:= TEquipmentParts(Sender).ProductName;
    PO.lines.QtySold    := TEquipmentParts(Sender).Quantity;
    PO.lines.PostDB;
  end;
end;
procedure TPurchaseGUI.MakeLinkPO(aLinkPORef: String);
begin
  PO.LinkPORef := aLinkPORef;
  SetControlfocus(grdtransactions);
end;

(*procedure TPurchaseGUI.MakepackweightFields(Lookupds :Tdataset);
var
  FldpackweightField , FldPackcount :TFloatfield;
begin
  inherited;
  if not {Appenv.CompanyPrefs.EnablePackWeight}PO.Lines.Product.EnablePackWeight then exit;
  if tbldetails.findfield(cPackWeightfieldField) = nil then begin
    try
                closedb(tbldetails);
                FldpackweightField :=  TFloatfield.Create(tbldetails.Owner);
                FldpackweightField.FieldKind           := fkLookup;
                FldpackweightField.FieldName           := cPackWeightfieldField ;
                FldpackweightField.LookupDataSet       := LookupDS;
                FldpackweightField.LookupKeyFields     := 'PurchaseLineId';
                if Appenv.companyPrefs.PackWeightQtyField =2 then FldpackweightField.LookupResultField:= 'AttribValue1' else FldpackweightField.LookupResultField := 'AttribValue2';
                FldpackweightField.KeyFields           := 'PurchaseLineID' ;
                FldpackweightField.Lookup              := True;
                FldpackweightField.Name                := 'tbldetailspackweightField';
                FldpackweightField.DataSet             := tblDetails;
                FldpackweightField.DisplayLabel        := iif(Appenv.companyPrefs.PackWeightQtyField =2 , Appenv.CompanyPrefs.PackWeightField1 , Appenv.CompanyPrefs.PackWeightField2);
                FldpackweightField.DisplayWidth        := 10;
                grdTransactions.AddField(cPackWeightfieldField);
                if fbhasPackWeightfield  then GuiPrefs.DbGridElement[grdTransactions].AddField(cPackWeightfieldField);
    Except
      on E:Exception do begin
        if devmode then
        MessageDlg('Error creating lookup field : ' + E.message, mtWarning, [mbOK], 0);
      end;
    end;
  end;

  if tbldetails.findfield(cPackcountfield) = nil then begin
    try
                closedb(tbldetails);
                FldPackcount :=  TFloatfield.Create(tbldetails.Owner);
                FldPackcount.FieldKind           := fkLookup;
                FldPackcount.FieldName           := cPackcountfield;
                FldPackcount.LookupDataSet       := LookupDS;
                FldPackcount.LookupKeyFields     := 'PurchaseLineId';
                FldPackcount.LookupResultField   := cPackcountfield;
                FldPackcount.KeyFields           := 'PurchaseLineID' ;
                FldPackcount.Lookup              := True;
                FldPackcount.Name                := 'tbldetailsPackcount';
                FldPackcount.DataSet             := tblDetails;
                FldPackcount.DisplayLabel        := 'Pack Count';
                FldPackcount.DisplayWidth        := 10;
                grdTransactions.AddField(cPackcountfield);
                if fbhasPackCount then GuiPrefs.DbGridElement[grdTransactions].AddField(cPackcountfield);

    Except
      on E:Exception do begin
        if devmode then
        MessageDlg('Error creating lookup field : ' + E.message, mtWarning, [mbOK], 0);
      end;
    end;
  end;
end;*)

Procedure TPurchaseGUI.OnEquipemntchange;
var
  Equip:TEquipment;
begin
  inherited;
  if (PO.Equipmentname  = '')  then exit;
  if PO.Lines.Count= 0 then begin
    Equip:= TEquipment.Create(Self);
    try
      Equip.Connection := PO.Connection;
      Equip.Load(PO.EquipmentId);
      showProgressbar(WaitMsg, Equip.EquipmentParts.count);
      try
        Equip.EquipmentParts.IterateRecords(MakeEquipmentPartsLines);
      finally
        HideProgressbar;
      end;
    finally
      FreeandNil(Equip);
    end;
  end;
end;

procedure TPurchaseGUI.OnGuiPrefsActive(Sender: TObject);
begin
  inherited;
(*  fbhasPackWeightfield :=   Pos(cPackWeightfieldField,GuiPrefs.DbGridElement[grdtransactions].node.itembyname['GridFields'].AsString) >0;
  fbhasPackCount       :=   Pos(cPackcountfield      ,GuiPrefs.DbGridElement[grdtransactions].node.itembyname['GridFields'].AsString) >0;*)

end;

Procedure TPurchaseGUI.cboETADateCloseUp(Sender: TObject);
Begin
  Inherited;
  SetControlFocus(txtInvNumber);
End;

Procedure TPurchaseGUI.cboExpenseClaimEmployeeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
Begin
  If Not modified then Exit;
  Inherited;
End;

Procedure TPurchaseGUI.cboExpenseClaimEmployeeExit(Sender: TObject);
Begin
  If (cboExpenseClaimEmployee.Text = '') then begin
    tblmaster.Edit;
    tblMasterExpenseClaimEmployee.asInteger := 0;
  End;
End;

Procedure TPurchaseGUI.edtBaseExchangeRateExit(Sender: TObject);
Begin
  Inherited;
  lblBaseForeignTotal.Visible    := (PO.ForeignExchangeRate <> 1);
  edtBaseForeignTotal.Visible    := (PO.ForeignExchangeRate <> 1);
  lblEstimatedForeignAmt.Visible := (PO.ForeignExchangeRate <> 1);
  EstimatedForeignAmt.Visible    := (PO.ForeignExchangeRate <> 1);
End;

procedure TPurchaseGUI.edtBatchKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Key = #13 then begin
    if Trim(edtBatch.Text) = '' then exit;
    if (AccessLevel > 2) or (TransAccessLevel > 2)  then exit;

    if not Assigned(fBactchReceive) then
      fBactchReceive := TBatchReceive.Create(PO);

    self.AddFlag('DisableAllocation');
    try
      if fBactchReceive.ReceiveBatch(edtBatch.Text) then
        edtBatch.Text := ''
      else
       CommonLib.MessageDlgXP_Vista('Batch Number not found', mtInformation, [mbOk], 0);
    finally
      self.RemoveFlag('DisableAllocation');
    end;
    Key := #0;
  End;
end;

Procedure TPurchaseGUI.edShipContainerETADblClick(Sender: TObject);
Var tmpComponent: TComponent;
Begin
  If (grdTransactions.GetActiveField.DisplayName = 'ShipContainerETA') then begin
    tmpComponent := GetComponentByClassName('TfrmShipContainer');
    If assigned(tmpComponent) then begin
      With TfrmShipContainer(tmpComponent) Do Begin
        Connection                            := MyConnection;
        TfrmShipContainer(tmpComponent).keyId := tcDataUtils.getShipContainerID(tblDetails.FieldByName('ShipContainerName').AsString);
        AttachObserver(Self);
        formstyle := fsMDIChild;
        bringtoFront;
        Exit;
      End;
    End;
  End;
  Inherited;
End;

procedure TPurchaseGUI.chkApprovedClick(Sender: TObject);
begin
(*  if TwwCheckBox(Sender).Focused then
    TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsBoolean := TwwCheckBox(Sender).Checked;*)
end;

procedure TPurchaseGUI.chkFuturePOClick(Sender: TObject);
begin
  inherited;
//  if tblMasterFuturePO.AsString='T' then
  if (ComponentState * [csDestroying]) <> [] then
    exit;
  if tblDetails.state = dsInactive then
    exit;
  if chkFuturePo.Checked then
  begin
    tblDetails.First;
    while not tblDetails.eof do
    begin
      tblDetails.Edit;
      tblDetails.FieldByName('Shipped').AsFloat := 0;
      tblDetails.Next;
    end;
//    tblDetails.Post;
  end;
end;

procedure TPurchaseGUI.chkShipTocustomer1Click(Sender: TObject);
begin
  inherited;
  if screen.activecontrol = chkShipTocustomer then
    if PO.ShipToCustomer <> chkShipTocustomer.Checked then
      PO.ShipToCustomer := chkShipTocustomer.Checked;
//  chkShipTocustomer.DataSource.DataSet.FieldByName(chkShipTocustomer.DataField).OnChange(chkShipTocustomer.DataSource.DataSet.FieldByName(chkShipTocustomer.DataField));
end;

procedure TPurchaseGUI.grdTransactionsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if fiproctreeId <> 0 then
    if PO.Lines.proctreeId = fiproctreeId then
      AFont.Style := AFont.Style + [fsBold] ;
end;

Procedure TPurchaseGUI.grdTransactionsCalcTitleAttributes(Sender: TObject; AFieldName: String; AFont: TFont; ABrush: TBrush; Var ATitleAlignment: TAlignment);
Begin
  Inherited grdTransactionsCalcTitleAttributes(Sender, AFieldName, AFont, ABrush, ATitleAlignment);
  If accesslevel = 1 Then
    If SysUtils.SameText(AFieldName, tblDetailsUnitofMeasureBackorder.fieldname) then begin
      AFont.Color     := clmaroon;
      ATitleAlignment := taCenter;
      ABrush.Color    := pnlTitle.Color;
    End;
End;

Procedure TPurchaseGUI.ProcessBackOrderItems;
Begin
  If PO.BOCount = 0 then Exit; // no need to continue
  If accesslevel <> 1 then Exit;
  If MessageDlgXP_Vista('Do you wish to receive all the Backorders? ', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    grdTransactions.SetActiveField('UnitofMeasureShipped');
    doShowProgressbar( PO.lines.count, 'Shipping all Backorders');
    try
      PO.shipAll;
    finally
      DoHideProgressbar;
    end;
  End;
End;

Procedure TPurchaseGUI.tblDetailsForeignTotalLineAmountSetText(Sender: TField; Const Text: String);
Begin
  Inherited;
  If Not(Sender.DataSet.State In [dsEdit, dsInsert]) then Exit;
  If Text = '' then Sender.AsString := '0'
  Else Sender.AsString              := Text;
End;

procedure TPurchaseGUI.actConvertToAssetExecute(Sender: TObject);
var
  StockToFixedAsset: TfmStockToFixedAsset;
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This will save any changes you have made and allow you to Convert Purchased Products to Fixed Assets, Ok to continue?',  mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;
  If Not SavePO then Exit;
  Self.CommitAndNotify;
  self.BeginTransaction;
  StockToFixedAsset := TfmStockToFixedAsset(GetComponentByClassName(TfmStockToFixedAsset.ClassName));
  if Assigned(StockToFixedAsset) then begin
    StockToFixedAsset.PurchaseOrderId := self.Order.ID;
    StockToFixedAsset.FormStyle := fsMdiChild;
    StockToFixedAsset.BringToFront;
    StockToFixedAsset.HighlightControl(StockToFixedAsset.btnSelect);
  end;
end;

Procedure TPurchaseGUI.actCustomerContactsExecute(Sender: TObject);
Begin
  DisableForm;
  Try Inherited;
  Finally EnableForm;
  End;
End;

Procedure TPurchaseGUI.btnCloseClick(Sender: TObject);
Begin
  DisableForm;
  Try Inherited;
  Finally EnableForm;
  End;
End;

Procedure TPurchaseGUI.HandlePurchaseErrors;
Var FatalStatusItem: TResultStatusItem;
Begin
  FatalStatusItem := PO.Lines.ResultStatus.GetLastFatalStatusItem;
  If assigned(FatalStatusItem) then begin
    Case FatalStatusItem.Code Of
      BOR_Order__NoProductETA: Begin
          grdTransactions.SetActiveField('ETADate');
          grdTransactions.SetFocus;
        End;
    End;
  End;
End;

function TPurchaseGUI.HasLinkedPrepayments: boolean;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(MyConnection);
  try
    qry.SQL.Text := 'select count(*) as RecCount from tblordersprepayments where OrderOriginalRef = ' + QuotedStr(PO.OriginalDocNumber);
    qry.Open;
    result := qry.FieldByName('RecCount').AsInteger > 0;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function TPurchaseGUI.HasPayments: boolean;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(MyConnection);
  try
    qry.SQL.Add('SELECT COUNT(tblwithdrawal.PaymentID) as RecCount');
    qry.SQL.Add('FROM tblwithdrawal');
    qry.SQL.Add('INNER JOIN tblwithdrawallines Using(PaymentID)');
    qry.SQL.Add('WHERE SupplierPayment="T" AND tblwithdrawal.Supplier="T"');
    qry.SQL.Add('AND Deleted="F" AND TrnType <> "Prepayment" AND POID = ' +IntToStr(PO.ID));
    qry.Open;
    result := qry.FieldByName('RecCount').AsInteger > 0;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TPurchaseGUI.ImportDocketnoFromClipBoard;
var
  Buff : String;
  sf,
  sl : TStringList;
  s1 : string;
//  f1, f2, f3 : string;
  bookMark : TBookmark;
  pono,
  idx : integer;
begin
  buff := Clipboard.AsText;
  sl := TStringList.Create;
  sl.Text := Buff;
  if sl.Count = 0 then
    exit;
  sf := TSTringList.Create;
  try
    try
      Split(sl[0], #9, sf);
      sl.Delete(0);
      if sl.Count = 0 then
        exit;
      if sf.Count <> 3 then
      begin
        s1 := 'Bad Data Format When Pasting: Expected PurchaseOrderId, SeqNo, DocketNumber, Received ';
        if sf.Count = 0 then
          s1 := s1 + ' Nothing'
        else if sf.Count = 1 then
          s1 := s1 + sf[0]
        else s1 := s1 + sf[0] + ' ' + sf[1];
        MessageDlgXP_Vista(s1, mtWarning, [mbOk], 0);
        exit;
      end;
      if not SameTExt(sf[0], 'PurchaseOrderId') or
         not SameText(sf[1], 'SeqNo') or
         not SameText(sf[2], 'DocketNumber') then
         begin
           MessageDlgXP_Vista('Wrong Data Format on Pasting:'#13#10'Expected: PurchaseOrderId, SeqNo, DocketNumber'#13#10+
             'Received: ' + sf[0] + ' ' + sf[1] + ' ' + sf[2], mtWarning, [mbOk], 0);
           exit;
         end;
      sf.Clear;
      bookmark := tblDetails.GetBookmark;;
      try
         for idx := 0 to sl.Count - 1 do
         begin
           Split(sl[idx], #9, sf);
           if not TryStrToInt(sf[0], poNo) or (poNo <> tblDetailsPurchaseOrderId.AsInteger) then
           begin
             MessageDlgXP_Vista('Wrong Purchase Order Number when Pasting Data:'#13#10 +
              'Expected ' + tblDetailsPurchaseOrderId.AsString + ', Received ' + sf[0], mtWarning, [mbOk], 0);
             Continue;
           end;

           if not tblDetails.Locate('SeqNo', strToInt(sf[1]), []) then
           begin
             MessageDlgXP_Vista('Error In Data: Cannot Locate Line No ' + sf[1] + ' in Purchase Order ' + sf[0],
               mtWarning, [mbOk], 0);
             Continue;
           end;
           tblDetails.Edit;
           if (sf.Count = 2) then
             tblDetails.FieldByName('DocketNumber').Clear
           else
             tblDetails.FieldByName('DocketNumber').asString := trim(sf[2]);
           tblDetails.Post;
           sf.Clear;
         end;
      finally
        tblDetails.GotoBookmark(bookMark);
        tblDetails.FreeBookmark(BookMark);
      end;
    finally
      sf.Free;
    end;
  finally
    sl.Free;
  end;
end;
Function TPurchaseGUI.ValidateInvoiceDate:Boolean;
begin
  result := True;
  if cboInvoiceDate.Date = 0 then exit;

  If cboInvoiceDate.Date > Now then
  begin
    if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAllowPOInvoicedatefuture') =1 then
      CommonLib.MessageDlgXP_Vista('You Have Set The Purchase Order Invoice Date to the future!', mtWarning, [mbOk], 0)
    else begin
      CommonLib.MessageDlgXP_Vista('You don''t have access to set the Purchase Order Invoice Date to the future!', mtWarning, [mbOk], 0);
      PO.CancelDb;
      REsult := False;
    end;
  end
  else if cboInvoiceDate.Date < Today() then
  begin
    if AppEnv.AccessLevels.GetEmployeeAccessLevel('fnAllowReverseDateForInvoiceDate') < 5 then
      MessageDlgXP_Vista('You Have Set The Purchase Order Invoice Date To The Past!', mtWarning, [mbOk], 0)
    else
    begin
      MessageDlgXP_Vista('You Don''t Have Access To Set The Purchase Order Invoice Date To The Past!', mtWarning, [mbOk], 0);
      PO.CancelDb;
      Result := false;
    end;

  end;

End;

Procedure TPurchaseGUI.SetIsLandedCosts(Const Value: Boolean);
Begin
  fIsLandedCosts := Value;
  // if fIsLandedCosts then begin
  // grdTransactions.AddField('LandedCostsPercentage');
  // grdTransactions.AddField('TotalLineLandedCost');
  // GuiPrefs.DbGridElement[grdTransactions].UnHideFields('LandedCostsPercentage,TotalLineLandedCost');
  // end
  // else begin
  // grdTransactions.RemoveField('LandedCostsPercentage');
  // grdTransactions.RemoveField('TotalLineLandedCost');
  // GuiPrefs.DbGridElement[grdTransactions].HideFields('LandedCostsPercentage,TotalLineLandedCost');
  // end;
End;

Procedure TPurchaseGUI.UpdateExchangeRate;
Begin
  { only do this if this is a new PO }
  If Self.keyId <> 0 then Exit;
  qryBaseForeignCurrency.refresh;
  Self.PO.UpdateForeignRateForDate;
End;

Procedure TPurchaseGUI.grdTransactionsDblClick(Sender: TObject);
Var Frm: TBaseInputGUI;
Begin
  If (SameText(grdTransactions.GetActiveField.fieldname, 'UnitofMeasureBackorder')) Or (SameText(grdTransactions.GetActiveField.fieldname, 'BackOrder')) then begin
    If (PO.Lines.QtyBackOrder <> 0) And (PO.BackOrderGlobalRef <> '') Then
      If CommonLib.MessageDlgXP_Vista('Do You wish To Save This Purchase Order and Open its Back Order#' + PO.BackOrderGlobalRef + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
        If Not SavePO then Exit;
        CommitAndNotify;
        OpenPO(PO.BackOrderGlobalRef);
      End;
  end else if (SameText(grdTransactions.GetActiveField.fieldname, 'RepairID')) And (tblDetailsRepairId.asInteger > 0) then begin
    Frm := TBaseInputGUI(GetComponentByClassName('TRepairsGUI'));
    If assigned(Frm) then begin
      Frm.keyId := tblDetailsRepairId.asInteger;
      Frm.AttachObserver(Self);
      Frm.formstyle := fsMDIChild;
      Frm.bringtoFront;
    End;
  end else if (SameText(ActiveField(Sender).fieldname, 'LineNotes')) then begin
    DoDBMemoDialog(tblDetailsLineNotes.AsString, tblDetailsLineNotes.DisplayLabel, tblDetailsLineNotes);
  end else if (SameText(ActiveField(Sender).fieldname, 'UnitofMeasureQtySold')) then begin
    DoPackWeight
  end else
    Inherited;
End;

Procedure TPurchaseGUI.OpenPO(Const boid: String);
Begin
  Self.BeginTransaction;
  accesslevel               := 1;
  AccessManager.accesslevel := accesslevel;
  keyId                     := PO.IDToggle(boid);
  PrefSuppList.Clear;
  LoadTransRec;
  PO.Dirty := False;
  SetControlFocus(cboClientR);
End;

procedure TPurchaseGUI.OpenPOChangeApproval(Sender: TObject);
begin
  DisableForm;
  Try
    Try
      If Not SavePO then Exit;
      Try
        Self.CommitAndNotify;
        Try
          OpenERPForm('TfmPurchaseOrderChange',0,nil,BeforePurchaseOrderChangeShow);
          Close;
        Finally
//          Self.BeginTransaction;
        End;
      Except
        On e: Exception Do Begin
          CommonLib.MessageDlgXP_Vista('Failed to Open the PO Change Form' + chr(13) + chr(13) + e.message, mtWarning, [mbOk], 0);
          Self.BeginTransaction;
        End;
      End;
    Finally

    End;
  Finally
    EnableForm;
  End;
end;

Function TPurchaseGUI.Saverecord: Boolean;
Begin
  result                := SavePO;
  If result then result := Inherited Saverecord;
End;

function TPurchaseGUI.SaveTrans: Boolean;
begin
  result := SavePO;
end;

procedure TPurchaseGUI.OverrideAccessLevel(Sender: TObject);
begin
  inherited;
  if (sender =txtInvNumber) or (Sender = cboInvoiceDate) then
    if IsPOLocked and (PO.TotalPaid<>0) then begin
      txtInvNumber.readonly := True;
      cboInvoiceDate.readonly := True;
    end;
  if accesslevel = 1 then PO.PostDb;
end;
Procedure TPurchaseGUI.txtCustomIDDblClick(Sender: TObject);
Begin
  OpenTransactionSequence;
  Inherited;
End;

Procedure TPurchaseGUI.btndiscountClick(Sender: TObject);
Var dvalue: Double; fbDoFieldChangewhenDisabled: Boolean;
Begin
  Inherited;
  dvalue := 0;
  While true Do Begin
    dvalue := CommonLib.CustomInputFloat('Discount', 'Enter a Discount Percentage for All Lines', '0');
    If dvalue < 100 then break;
  End;
  If dvalue < 0 then Exit;

  If MessageDlgXP_Vista
    ('This Will Delete Discount from All Products in This Purchase Order and recalculate the Cost and Hence the Average Cost of the Product Based on the Discount.  do you wish to Continue?',
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;

  fbDoFieldChangewhenDisabled                := PO.Lines.DoFieldChangeWhenDisabled;
  PO.DiscountPercent                         := dvalue;
  PO.Lines.DoFieldChangeWhenDisabled         := true;
  PO.Lines.TempData.s['CostsUpdateResponce'] := 'Unknown';
  Try PO.Lines.IterateRecords(ApplyDiscountPercent);
  Finally
    PO.Lines.TempData.Delete('CostsUpdateResponce');
    PO.Lines.DoFieldChangeWhenDisabled := fbDoFieldChangewhenDisabled;
    PO.DiscountPercent                 := 0;
    PO.CalcOrderTotals;
  End;
End;

Procedure TPurchaseGUI.CalcAll(Const Sender: TBusObj; Var Abort: Boolean);
begin
  if not(Sender is TPurchaseorderline) then exit;
  TPurchaseorderline(Sender).TotalLineAmountinc := round(TPurchaseorderline(Sender).TotalLineAmountinc,CurrencyRoundPlaces);
  TPurchaseorderline(Sender).TotalLineAmount := round(TPurchaseorderline(Sender).TotalLineAmountInc / (1 + TPurchaseorderline(Sender).LineTaxRate),CurrencyRoundPlaces);
  TPurchaseorderline(Sender).LineTaxTotal    := TPurchaseorderline(Sender).TotalLineAmountInc - TPurchaseorderline(Sender).TotalLineAmount;
  TPurchaseorderline(Sender).CalcLineCostFromTotal;
  TPurchaseorderline(Sender).PostDB;
end;

function TPurchaseGUI.CanEditTransPricenCost: Boolean;
begin
      result  := not (IstransLineCostLocked or  (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnEditPurchaseCost') >=3));
end;

procedure TPurchaseGUI.btnfixClick(Sender: TObject);
begin
  inherited;

    PO.accessmanager.accesslevel := 1;
    PO.Lines.IterateRecords(CalcAll);
    PO.CalcOrdertotals;
    if round(fxtax-PO.TotalTax,5) = 0 then Exit;

      if not (PO.Lines.Locate('ProductName;QtySold;Shipped;ClassID;Product_Description' , vararrayof([PART_ROUNDING,1,1,GetDeptID('Roundfix'),'Rounding Adjustment Fix']) , [])) then begin
        PO.AllowNewRecordWhenLocked := True;
        PO.lines.New;
        PO.lines.productname := PART_ROUNDING;
        PO.lines.ProductDescription := 'Rounding Adjustment Fix';
        PO.lines.UOMQtySold := 1;
        PO.Lines.UOMQtyShipped := 1;
        PO.Lines.LineClassName := 'Roundfix';
      end;
      PO.Lines.DoFieldChange:= False;
      try
        PO.Lines.LineCostinc :=  round(fxtotinc-PO.totalamountinc,CurrencyRoundPlaces);
        PO.Lines.TotalLineAmountinc :=  PO.Lines.LineCostinc;
        PO.Lines.LineTaxTotal :=  round(fxtax-PO.TotalTax,5);
        PO.Lines.TotalLineAmount := PO.Lines.TotalLineAmountinc-PO.Lines.LineTaxTotal;
        PO.Lines.CalcLineCostFromTotal;
        PO.Lines.TotalLineamount :=  PO.Lines.LineCost;
        PO.Lines.PostDB;
        PO.CalcOrderTotals;
        PO.Lines.TotalLineamount :=  PO.Lines.LineCost;
      finally
        PO.Lines.DoFieldChange:= true;
      end;
    btnfix.visible := devmode;
end;

Procedure TPurchaseGUI.ApplyDiscountPercent(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TPurchaseOrderLine) then Exit;
  TPurchaseOrderLine(Sender).ApplyPODiscountPercent;
End;

procedure TPurchaseGUI.BeforePurchaseOrderChangeShow(Sender: TObject);
begin
  TfmPurchaseOrderChange(Sender).PurchaseOrderID := PO.ID;
end;
procedure TPurchaseGUI.chkShipToDefaultAddressClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol = chkShipToDefaultAddress then
    if PO.ShipToDefaultAddress <> chkShipToDefaultAddress.Checked then begin
      PO.ShipToDefaultAddress := chkShipToDefaultAddress.Checked;
    end;
  Setcontrolfocus(txtShipTo);
end;
procedure TPurchaseGUI.chkShipToCustomerClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol = chkShipTocustomer then
    if PO.ShipToCustomer <> chkShipTocustomer.Checked then
      PO.ShipToCustomer := chkShipTocustomer.Checked;
  Setcontrolfocus(txtShipTo);
end;
procedure TPurchaseGUI.chkShipToClassClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol = chkShipToClass then
    if PO.ShipToClass <> chkShipToClass.Checked then
      PO.ShipToClass := chkShipToClass.Checked;
  Setcontrolfocus(txtShipTo);
end;
Function TPurchaseGUI.MakeaStSOrder:boolean;
begin
  Result := False;
  if KeyId =0 then begin
    CloseDb(cboClassQry);
    cboClassQry.SQL.Text := 'SELECT ' +
                            ' C.ClassID, C.ClassName, C.UseAddress, C.Street, C.Street2, C.Suburb, C.State, C.Postcode ' +
                            ' from tblclass C ' +
                            ' INNER JOIN tblstsclass StSC ON C.classId = StSC.classId ' +
                            ' WHERE (((C.ClassName) Is Not Null) And (C.Active<>"F")) ' +
                            ' ORDER BY C.ClassName;';
    OpenDb(cboClassQry);
    if cboClassQry.Recordcount =0 then begin
      MessageDlgXP_Vista('No ' +appenv.DefaultClass.ClassHeading+' found for Seed To Sale. This will Allow You to Create the Order in the Default ' +appenv.DefaultClass.ClassHeading+'.'+NL+NL+
                          'Or Please Cancel and Make a ' +appenv.DefaultClass.ClassHeading+' for Seed to Sale and Create the Order', mtWarning, [mbOK], 0);
      CloseDb(cboClassQry);
      cboClassQry.SQL.Text := 'SELECT ' +
                              ' C.ClassID, C.ClassName, C.UseAddress, C.Street, C.Street2, C.Suburb, C.State, C.Postcode ' +
                              ' from tblclass C ' +
                              ' WHERE (((C.ClassName) Is Not Null) And (C.Active<>"F") and C.clasSId =' + inttostr(AppEnv.DefaultClass.ClassID) +' ) ' +
                              ' ORDER BY C.ClassName;';
      OpenDb(cboClassQry);
    end;
    if not cboClassQry.Locate('ClassId', AppEnv.Companyprefs.StsConfig.StSDefaultClassID, []) then
      if not cboClassQry.Locate('ClassId', AppEnv.DefaultClass.ClassID, []) then
        cboClassQry.First;
    if Appenv.companyprefs.StSSupplier = '' then begin
      MessageDlgXP_Vista('Please Choose Seed To Sale Tag Supplier (Preference).', mtWarning, [mbOK], 0);
      SetcontrolFocus(cboClientR);
      Exit;
    end;
    PO.suppliername := Appenv.companyprefs.StSSupplier;
    PO.PostDB;
    PO.Lines.New;
    PO.Lines.ProductName  := Appenv.companyprefs.StSPackageTagProduct;
    PO.Lines.UOMQtysold   := 1;
    PO.Lines.LineClassName:= cboClassQry.fieldbyname('ClassName').asString;
    PO.Lines.LineClassId  := cboClassQry.fieldbyname('ClassID').asInteger;
    PO.Lines.PostDB;
    PO.Lines.New;
    PO.Lines.ProductName  := Appenv.companyprefs.StSPlantTagProduct;
    PO.Lines.UOMQtysold   := 1;
    PO.Lines.LineClassName:= cboClassQry.fieldbyname('ClassName').asString;
    PO.Lines.LineClassId  := cboClassQry.fieldbyname('ClassID').asInteger;
    PO.Lines.PostDB;
    Result := True;
  end;
end;

Initialization
RegisterClassOnce(TPurchaseGUI);
With FormFact Do Begin
  RegisterMe(TPurchaseGUI, 'TPurchaseOrderListGUI_*_Purchase Order=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TStSTagOrdersGUI_*=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TIncomingOrdersList_*=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TUnInvoicedPOListGUI_*=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TProductPurchaseMovementDetailsGUI_*=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TPurchaseOrderListExpressGUI_*=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TNonERPPOListGUI_*_Purchase Order=ERPTransId');
  RegisterMe(TPurchaseGUI, 'TPOsInvoicedBeforeOrderGUI_*=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TSalesPurchaseOrderListGUI_*=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TPurchaseOrderPrnGUI_*=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TPurchaseOrderDetailListGUI_*_Purchase Order=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TBackOrderPurchaseListGUI_*=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TBackorderPurchaseOrderExpressGUI_*=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TForeignBackorderPurchaseOrderExpressGUI_*=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TForeignPurchaseOrderListExpressGUI_*=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TBackOrderPurchaseListGUI_BackOrder=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TTransAccountDetailsGUI_*_Purchase Order=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TSupplierReportGUI_*_Purchase Order=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TAccountsPayListGUI_*_PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TMemTransListGUI_*_TPurchaseGUI=TransID');
  RegisterMe(TPurchaseGUI, 'TSupplierProductReportGUI_*_Purchase Order=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TBalTransListGUI_*_PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TInventoryAssetVsStockStautsGUI_*_Purchase Order=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TToBeReconciledGUI_*_PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TReconListDetailFormGUI_*_PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TTrialBalTransListGUI_*_PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TTransactionListGUI_*_PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TBASTransReturnListGUI_*_PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TNZTransReturnListGUI_*_PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TVATTransReturnListGUI_*_PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TGlobalsearchGUI_*_PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TGlobalsearchGUI_*_UnInvoiced PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TGlobalsearchGUI_*_POBO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TGlobalsearchGUI_*_Cancelled Purchase Order=PurchaseOrderID');

  RegisterMe(TPurchaseGUI, 'TTransAccountDetailsGUI_*_PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TGeneralLedgerReportGUI_*_PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TUnpaidBillGUI_*_Purchase Order=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TJobProfitabilityGUI_*_Purchase Order=SaleID');
  RegisterMe(TPurchaseGUI, 'TJobProfitabilityforCustomerGUI_*_Purchase Order=SaleID');
  RegisterMe(TPurchaseGUI, 'TEmailedReportsList_*_Purchase Order=Transaction');
  RegisterMe(TPurchaseGUI, 'TFaxSpoolListingGUI_TransGlobal_Purchase Order=TransGlobal');
  RegisterMe(TPurchaseGUI, 'TFaxSpoolListingGUI_TransType_Purchase Order=TransGlobal');
  RegisterMe(TPurchaseGUI, 'TSupplierStatementGUI_*_Purchase Order=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TTransAccountDetailsGUI_*_Un-Invoiced PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TTransMissingBOList_*_Purchase Order=ID');
  RegisterMe(TPurchaseGUI, 'TBalTransListGUI_*_Un-Invoiced PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TInventoryAssetVsStockStautsGUI_*_Un-Invoiced PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TPnLEmployeereportGUI_*_PO=TransId');
  RegisterMe(TPurchaseGUI, 'TToBeReconciledGUI_*_Un-Invoiced PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TReconListDetailFormGUI_*_Un-Invoiced PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TTrialBalTransListGUI_*_Un-Invoiced PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TTransactionListGUI_*_Un-Invoiced PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TBASTransReturnListGUI_*_Un-Invoiced PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TNZTransReturnListGUI_*_Un-Invoiced PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TVATTransReturnListGUI_*_Un-Invoiced PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TGlobalsearchGUI_*_Un-Invoiced PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TTransAccountDetailsGUI_*_Un-Invoiced PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TGeneralLedgerReportGUI_*_Un-Invoiced PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TStockStatusRoling_*_Purchase Order=TransactionNo');
  RegisterMe(TPurchaseGUI, 'TAccountsPayableNotes_*_PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TExpenseClaimListGUI_*_PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TApprovalReminderListGUI_*_PO=PurchaseOrderID');
  (*RegisterMe(TPurchaseGUI, 'TRemindersListGUI_*_PO=ID');*)
  RegisterMe(TPurchaseGUI, 'TReminderListGUI_*_PO=ID');
  RegisterMe(TPurchaseGUI, 'TAllTransactionGUI_*_PurchaseOrder=TransNo');
  RegisterMe(TPurchaseGUI, 'TBankAccountListGUI_*_Un-Invoiced PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TBankAccountListGUI_*_PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TMemTransListGUI_*_Purchase Order=TransID');
  RegisterMe(TPurchaseGUI, 'TApprovalListGUI_*_PO=PurchaseORderID');
  RegisterMe(TPurchaseGUI, 'TTransactionswith0QtyGUI_*_Purchase Order=TrasnsId');
  RegisterMe(TPurchaseGUI, 'TBillsnCheque_LinesDeletedGUI_*_PO=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TTransactionSequenceGUI_*_PO=TransID');
  RegisterMe(TPurchaseGUI, 'TNumberSequenceListGUI_*_Purchase Order=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TNumberSequenceListGUI_*_PO Credit=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TfmUnInvoicedPurchasesList_*=PurchaseOrderId');
  RegisterMe(TPurchaseGUI, 'TSupplierOrderShipmentsGUI_*=PurchaseOrderId');
  RegisterMe(TPurchaseGUI, 'TSalesSmartPOListGUI_*_PO=PurchaseOrderId');
  RegisterMe(TPurchaseGUI, 'TProductTransactionListGUI_*_Purchase Order=TransID');
  RegisterMe(TPurchaseGUI, 'TTranswithBOMissingGUI_*_PO=ID');
  RegisterMe(TPurchaseGUI, 'THireSmartOrderListGUI_*_Purchase Order=ID');
  RegisterMe(TPurchaseGUI, 'TPurchaseOrderAuditGUI_*=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TSmartOrderPOListGUI_*=PurchaseOrderID');
  RegisterMe(TPurchaseGUI, 'TStSTagOrdersGUI_*_Purchase Order=PurchaseOrderID');
End;

End.
