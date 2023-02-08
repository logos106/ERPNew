Unit BusObjTrans;

{ Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  27/04/05  1.00.00 IJB  Initial version.
  19/05/05  1.00.01 IJB  Added ForeignExchangeCode property to TPurchaseOrder
  and code to prevent multiple currencies on PO lines.
  24/05/05  1.00.02 IJB  Added LandedCostProcessing and updating of Product
  to TPurchaseOrderLine.
  10/06/05  1.00.03 BJ   The buy cost given in the tblparts is the cost of the
  the base unit. When the purchase unit of the product is
  not a base unit / a non-baseunit is selected for the PO
  the cost should be multiplied by the Multiplier of the
  UOM and QTY.
  When the Cost Inc is modified and needs to change the
  LINECOST of the product, the cost is calculated as follows
  LINECOST for the selected unit := costInc - tax
  LINECOST for base unit := LINECOST
  / multiplier of the UOM
  /QTY
  27/07/05  1.00.04 BJ   Adding a new product to a PO with a BO will have the
  QtySold = qty shipped. It is because as the BO already exists
  cannot create the BO.
  Deleting a poline updating  the ordered qty of all its
  Original POs
  PO and POLine object's connection is initilised from the form
  28/07/05  1.00.05 IJB  Added code to set foreign currency code when product is
  selected on purchase order line. Fixed bug with
  TPurchaseOrder.Supplier returning wrong supplier.
  03/08/05  1.00.06 IJB  Modified UpdateProductBuyCostFromLineCost
  21/09/05  1.00.07 ISB  Modified so ReceivedDate should not be cleared after Received.
  28/09/05  1.00.08 IJB  Added foreign currency properties to TPurchaseOrder.
  11/10/05  1.00.09 MV   Modified to support the implementation of the revised
  foreign currency.
  23/10/05  1.00.10 IJB  Added GLAccount property to TransBase.
  27/10/05  1.00.11 MV   Fixed issue with Exchange Rate and recalculation of line data
  01/12/05  1.00.12 BJ   Printflag, printedBy and PickPrintFlag is being removed from
  Sales Table. object changed to read the new table for those
  Properties.
  12/12/05  1.00.13 BJ   (1)Purchaseorder.Save checks for the bin-batch allocation and
  takes confirmation before saving, if not allocated
  (2)Deleted records(lines) are deleted after saving.
  (3)Temporary solution implemeted to Save the XML for Clean Qtys for
  bin-batch allocation.
  06/01/06  1.00.14 IJB  Added Terms to TRansBase and modified SetPaymentTerms to
  use these terms rather than Client Terms
  16/03/06 1.00.10 BJ    DoFieldOnChange is updates the rpoduct properties whent eh productId or
  productname ischanged. Module changed to do it only if the value of the
  field is not blank. When the data is imported from an XML file, the productId
  is usually blank
  14/08/06 1.00.11 BJ    Selecting a client with UseCustomerInvoiceNo is true when the client is
  locked by another user/form the lastinvnumber cannot be updated and clientId
  is set back to 0
  15/08/06 1.00.21 BJ    printdoc object property is outdside transaction.
  23/08/06 1.00.22 BJ    CloneLines updates the parentProductID of the copied record
  With the id of line being copied. this field shoudl have a
  non zero value only if its a related product. The following
  code does the upsatiuon for the related product parent ID
  29/08/06 1.00.23 BJ    Lock is overridden to lock all records in the Group.
  This functionality has problems when combined back order is True.
  08/09/06 1.00.24 BJ    DoFieldOnChange was checking the current field's name using an =
  which is case sensitive, this is changed to using Sametext function
  18/09/06 1.00.25 BJ    Transline.doonfieldchange updates the EmployeeId when Employeename is changed

  ------------------------------------------------------------------------------
  Object Hierarchy

  TDatasetBusObj
  |
  |
  TBusObj
  |
  |
  TMSBusObj
  |
  |
  TTransBase / TTransLineBase
  |
  |-- TExpenseBase
  |      |
  |      |-- TBill
  |      |-- TCredit
  |      |-- TCheque
  |
  |-- TOrderBase(BusObjOrders.Pas)
  |      |
  |      |-- TPurchaseOrder
  |      |-- TReturn
  |
  |-- TSalesBase(BusObjSalesBase.Pas)
  |      |
  |      |--TSales(BusobjSales.PAs)
  |          |
  |          |-- TInvoice
  |          |-- TQuote
  |          |-- TSalesOrder
  |      |--TCash
  |          |-- TCashSale
  |          |-- TRefundSale

  25/05/06 1.00.11 BJ    PO related stuff is moved into new module - busobjOrders
  |-- TOrderBase/TOrderLineBase
  |      |
  |      |-- TPurchaseOrder
  |      |-- TReturn
  23/01/07  1.00.12 BJ   Show_status functin for showing the status in the GUI.
  Conversion fo SO to invoice checks for the allocation already done in the invoice
  and ignores the allocation after conversion
}
Interface

Uses
  BusObjBase, BusObjClient, Classes, DB, ForeignExchangeObj, BusObjGLAccount, Variants, MyAccess, ERPdbComponents, BusObjPrintDoc, BusObjCommon, BusObjTaxCodes, BusobjPQA, XMLDoc, XMLIntf,
  BusObjContact,BusobjTransTaxCodes , BusObjTransLinetotals, BusObjAttachment;

Type
  TTransProc1 = Procedure(Const Value: String) Of Object;

  // TTransLineBase = class(TProductQty)
  TTransLineBase = Class(TProdQty)
  Private
    FTaxCode                : TTaxCode;
    FbIsCreatingBORec       : Boolean;
    FAnyLineShipped         : Boolean;
    FAnyLineBackOrdered     : Boolean;
    FbCalcQtysoldFromformula: Boolean;
    FbCalcQtyFromformula    : Boolean;
    Function GetLineCost: Double;
    Function GetLineCostInc: Double;
    Function GetLineTaxRate: Double;
    Function GetLineTaxTotal: Double;
    Function GetQtyShipped: Double;
    Function GetTotalLineAmount: Double;
    Function GetTotalLineAmountInc: Double;
    Procedure SetLineCost(Const Value: Double);
    Procedure SetLineCostInc(Const Value: Double);
    Procedure SetLineTaxRate(Const Value: Double);
    Procedure SetLineTaxTotal(Const Value: Double);
    Procedure SetQtyShipped(Const Value: Double);
    Procedure SetTotalLineAmount(Const Value: Double);
    Procedure SetTotalLineAmountInc(Const Value: Double);
    Function GetQtyBackOrder: Double;
    Function GetQtySold: Double;
    Function GetUOMQtyBackOrder: Double;
    Function GetUOMQtyShipped: Double;
    Procedure SetQtyBackOrder(Const Value: Double);
    Procedure SetQtySold(Const Value: Double);
    Procedure SetUOMQtyBackOrder(Const Value: Double);
    Procedure SetUOMQtySold(Const Value: Double);
    Function GetAssetAccount: String;
    Function GetCogsAccount: String;
    Function GetIncomeAccount: String;
    Function GetProductDescription: String;
    Function GetProductGroup: String;

    Function GetLineTaxCode: String;
    Function GetVoucherNo: String;
    Function GetIsvoucher: Boolean;

    Procedure SetAssetAccount(Const Value: String);
    Procedure SetCogsAccount(Const Value: String);
    Procedure SetIncomeAccount(Const Value: String);
    Procedure SetProductGroup(Const Value: String);

    Procedure SetLineTaxCode(Const Value: String);
    Function GetInvoiced: Boolean;
    Procedure SetInvoiced(Const Value: Boolean);
    Procedure SetDeleted(Const Value: Boolean);
    Function GetSearchFilter: String;
    Function GetSearchFilterCopy: String;
    Procedure SetSearchFilter(Const Value: String);
    Procedure SetSearchFilterCopy(Const Value: String);
    // function  GetCostCentreId: integer;
    // procedure SetCostCentreId(const Value: integer);
    Function GetForeignTotalLineAmount: Double;
    Procedure SetForeignTotalLineAmount(Const Value: Double);
    Function GetLineNotes: String;
    Procedure SetLineNotes(Const Value: String);
    Function GetSeqNo: Integer;
    Procedure SetSeqNo(Const Value: Integer);
    Function GetSortID: Integer;
    Function GetLinesOrder: Integer;
    Procedure SetSortID(Const Value: Integer);
    Procedure SetLinesOrder(Const Value: Integer);
    Function GetCleanProductName: String;
    Function GetTaxCode: TTaxCode;
    Function GetPQAlloation: String;
    Procedure SetPQAlloation(Const Value: STring);
    Function GetPartBarcode: String;
    Procedure SetPartBarcode(Const Value: String);
    Function GetBaseLineno: Integer;
    Procedure SetBaseLineno(Const Value: Integer);
    Procedure PopulateTaxcodeLines(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure DoChangeTaxCode;
    Procedure CopyTransTax;
    Procedure AnyLineShippedCallback(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure AnyLineBackOrdredCallback(Const Sender: TBusObj; Var Abort: Boolean);
    Function GetBaseLineGlobalRef: String;
    Procedure SetBaseLineGlobalRef(Const Value: String);
    Procedure GetCalcQtYformulaValue(Sender: TObject; Const VarName: String; Var Value: Extended; Var FieldFound: Boolean);
    Procedure CalcQtysoldFromformula;
    Procedure CalcQtyshippedFromformula;
    Procedure SetVoucherNo(Const Value: String);
    Procedure SetIsvoucher(Const Value: Boolean);
    Function GetAllowNewRecordWhenLocked: Boolean;
    function GetUOMLineCost: double;
    function GetUOMLineCostInc: double;
    function GetStandardCost: double;
    procedure SetStandardCost(const Value: double);
    function getCrossStockAdjustTransForinvoice: Boolean;
    function getLineInserting: Boolean;
    procedure setLineInserting(const Value: Boolean);
    procedure ResetLinesOrder(Sender: TBusObj);

  Protected
    FdLastSeqNo : Integer;
    FiSortId    : Integer;
    FiLinesOrder: Integer;
    Procedure DoFieldOnChange(Sender: TField); Override;
    Procedure SetUOMMultiplier(Const Value: Double); Override;
    Procedure SetProductID(Const Value: Integer); Override;
    Procedure SetProductName(Const Value: String); Override;
    Procedure SetQty(Const Value: Double); Override;
    Function GetOrderQty: Double; Override;
    Procedure SetOrderQty(Const Value: Double); Override;
    Function GetUOMOrderQty: Double; Override;
    Procedure SetUOMOrderQty(Const Value: Double); Override;
    Procedure SetUOMQty(Const Value: Double); Override;
    Procedure SetUOMQtyShipped(Const Value: Double);
    Procedure SetActive(Const Value: Boolean); Override;
    Procedure SetBOQty(Const Value: Double); Override;
    Procedure SetBOUOMQty(Const Value: Double); Override;
    Function DoAfterPost(Sender: TDatasetBusObj): Boolean; Override;
    Procedure ClonePropertyObjects; Override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
    Function DoBeforeInsert(Sender: TDatasetBusObj): Boolean; Override;
    Procedure ClonePQA(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure SetProductDescription(Const Value: String);Virtual;

    Function GetUOMMultiplier: Double; Override;
    Function GetCleanXMLNode: IXMLNode; Override;
    Function GetProductID: Integer; Override;
    Function GetProductName: String; Override;
    Function GetDeleted: Boolean; // Virtual;
    Function GetUOMQtySold: Double;
    Function ProductChanged: Boolean;Virtual;
    Procedure OnProductChanged;Virtual;
    Procedure Show_Status(Const Value: String);
    Function GetcleanQtyTotal: Double; Virtual; Abstract;
    Function GetActive: Boolean; Override;
    Function GetQty: Double; Override;
    Function GetBOQty: Double; Override;
    Function GetBOUOMQty: Double; Override;
    Function GetUOMQty: Double; Override;
    Function ExportsubClasses(Const Node: IXMLNode): Boolean; Override;
    Procedure GetProductDetails; Virtual;
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
    Procedure AfterCloneBusObj; Override;
    Function GetProductType: String; Override;
    Procedure SetProductType(Const Value: String); Override;
    Procedure SetMatrixRef(Const Value: String); Override;
    Function GetMatrixRef: String; Override;
    Function GetMatrixDesc: String; Override;
    Function GetMatrixPrice: Double; Override;
    Procedure SetMatrixDesc(Const Value: String); Override;
    Procedure SetMatrixPrice(Const Value: Double); Override;
    Function GetTransTaxCode: TTransTaxCode; Virtual;
    Procedure CalcTaxcodeTotals;
    Function GetIsList: Boolean; Override;
    Function GetLineDesc: String; Virtual;

    Function GetFormulaQtySoldValue: Double; Override;
    Function GetFormulaQtyValue: Double; Override;
    Function GetFormulaQtyValue1: Double; Override;
    Function GetFormulaQtyValue2: Double; Override;
    Function GetFormulaQtyValue3: Double; Override;
    Function GetFormulaQtyValue4: Double; Override;
    Function GetFormulaQtyValue5: Double; Override;
    Procedure SetFormulaQtyValue(Const Value: Double); Override;
    Procedure SetFormulaQtyValue1(Const Value: Double); Override;
    Procedure SetFormulaQtyValue2(Const Value: Double); Override;
    Procedure SetFormulaQtyValue3(Const Value: Double); Override;
    Procedure SetFormulaQtyValue4(Const Value: Double); Override;
    Procedure SetFormulaQtyValue5(Const Value: Double); Override;

    function GetFormulaID: Integer;
    Function getFormulaName:String;
    Function GetFormulaQtySoldValue1: Double; Override;
    Function GetFormulaQtySoldValue2: Double; Override;
    Function GetFormulaQtySoldValue3: Double; Override;
    Function GetFormulaQtySoldValue4: Double; Override;
    Function GetFormulaQtySoldValue5: Double; Override;
    Function GetFormulaQtyShippedValue: Double; Override;
    Function GetFormulaQtyShippedValue1: Double; Override;
    Function GetFormulaQtyShippedValue2: Double; Override;
    Function GetFormulaQtyShippedValue3: Double; Override;
    Function GetFormulaQtyShippedValue4: Double; Override;
    Function GetFormulaQtyShippedValue5: Double; Override;

    procedure SetFormulaID(const Value: Integer);
    Procedure SetFormulaName(Const Value:String);
    Procedure SetFormulaQtySoldValue(Const Value: Double); Override;
    Procedure SetFormulaQtySoldValue1(Const Value: Double); Override;
    Procedure SetFormulaQtySoldValue2(Const Value: Double); Override;
    Procedure SetFormulaQtySoldValue3(Const Value: Double); Override;
    Procedure SetFormulaQtySoldValue4(Const Value: Double); Override;
    Procedure SetFormulaQtySoldValue5(Const Value: Double); Override;
    Procedure SetFormulaQtyShippedValue(Const Value: Double); Override;
    Procedure SetFormulaQtyShippedValue1(Const Value: Double); Override;
    Procedure SetFormulaQtyShippedValue2(Const Value: Double); Override;
    Procedure SetFormulaQtyShippedValue3(Const Value: Double); Override;
    Procedure SetFormulaQtyShippedValue4(Const Value: Double); Override;
    Procedure SetFormulaQtyShippedValue5(Const Value: Double); Override;
    Function GetLinedescription: String; Virtual;
    Procedure InitUOM(Const UOMName, UOMNameOldValue: String); Overload; Override;
    Function getAreaCode: String; Virtual;
    Procedure SetAreaCode(Const Value: String); Virtual;
    Procedure ProgressProcesswithRecno;
    Procedure CalcLineForeingAmount;Virtual;
    procedure DoGetFormulaFieldValueForSold(Sender: TObject;const VarName: string; var Value: extended; var FieldFound: Boolean);
    procedure DoGetFormulaFieldValueForshipped(Sender: TObject;const VarName: string; var Value: extended; var FieldFound: Boolean);
    procedure initRelatedProductFormulaDescription;Virtual;
    Function ProductStandardCost:Double; Override;
    procedure OnReGenerateNumber;Override;


  Public
    Procedure Load(Const FIsReadonly: Boolean = False); Override;
    Constructor Create(AOwner: TComponent); Override;
    Function Save: Boolean; Override;
    Procedure ReCalculateLineAmounts;
    Procedure SaveToXMLNode(Const Node: IXMLNode); Override;
    Procedure LoadFromXMLNode(Const Node: IXMLNode); Override;
    Function ValidateData: Boolean; Override;
    Property CleanQtyTotal: Double Read GetcleanQtyTotal;
    Property PQAlloation: String Read GetPQAlloation Write SETPQAlloation;
    Class Function XMLBranchName: String; Override;
    Property IsCreatingBORec: Boolean Read FbIsCreatingBORec Write FbIsCreatingBORec;
    Procedure CalcLineTotals; Virtual;
    Procedure CalculateLinetotalsfromPrice; Virtual;
    Property TransTaxCode: TTransTaxCode Read GetTransTaxCode;
    Function AnyLineShipped: Boolean;
    Function AnyLineBackOrdered: Boolean;
    Class Function _Schema: String; Override;
    Property TaxCode: TTaxCode Read GetTaxCode Write FTaxCode;
    Property LineDesc: String Read GetLineDesc;
    Property CalcQtyFromformula: Boolean Read FbCalcQtyFromformula;
    Property Linedescription: String Read GetLinedescription;
    Property AllowNewRecordWhenLocked: Boolean Read GetAllowNewRecordWhenLocked;
    function UpdatingBO: boolean;Override;
    Property CrossStockAdjustTransForinvoice :Boolean read getCrossStockAdjustTransForinvoice;
    Property LineInserting :Boolean read getLineInserting write setLineInserting;

  Published
    // single unit cost excluding tax
    Property LineCost: Double Read GetLineCost Write SetLineCost;
    // single unit cost including tax
    Property LineCostInc: Double Read GetLineCostInc Write SetLineCostInc;
    // tax rate
    Property LineTaxRate: Double Read GetLineTaxRate Write SetLineTaxRate;
    // total tax amount for line
    Property LineTaxTotal: Double Read GetLineTaxTotal Write SetLineTaxTotal;
    Property QtyShipped  : Double Read GetQtyShipped Write SetQtyShipped;
    Property QtySold     : Double Read GetQtySold Write SetQtySold;
    Property QtyBackOrder: Double Read GetQtyBackOrder Write SetQtyBackOrder;
    // rate used to convert foreign price from/to AUD
    Property TotalLineAmount       : Double Read GetTotalLineAmount Write SetTotalLineAmount;
    Property TotalLineAmountInc    : Double Read GetTotalLineAmountInc Write SetTotalLineAmountInc;
    Property ForeignTotalLineAmount: Double Read GetForeignTotalLineAmount Write SetForeignTotalLineAmount;
    Property UOMQtyShipped         : Double Read GetUOMQtyShipped Write SetUOMQtyShipped;
    Property UOMQtySold            : Double Read GetUOMQtySold Write SetUOMQtySold;
    Property UOMQtyBackOrder       : Double Read GetUOMQtyBackOrder Write SetUOMQtyBackOrder;
    // property ProductId: integer read GetProductID write SetProductID;
    // property ProductName: string read GetProductName write SetProductName;
    Property ProductGroup      : String Read GetProductGroup Write SetProductGroup;
    Property ProductDescription: String Read GetProductDescription Write SetProductDescription;
    // property ProductType: string read GetProductType write SetProductType;
    Property IncomeAccount    : String Read GetIncomeAccount Write SetIncomeAccount;
    Property AssetAccount     : String Read GetAssetAccount Write SetAssetAccount;
    Property CogsAccount      : String Read GetCogsAccount Write SetCogsAccount;
    Property LineTaxCode      : String Read GetLineTaxCode Write SetLineTaxCode;
    Property Invoiced         : Boolean Read GetInvoiced Write SetInvoiced;
    Property Deleted          : Boolean Read GetDeleted Write SetDeleted;
    Property SeqNo            : Integer Read GetSeqNo Write SetSeqNo;
    Property SortID           : Integer Read GetSortID Write SetSortID;
    Property LinesOrder       : Integer Read GetLinesOrder Write SetLinesOrder;
    Property SearchFilter     : String Read GetSearchFilter Write SetSearchFilter;
    Property SearchFilterCopy : String Read GetSearchFilterCopy Write SetSearchFilterCopy;
    Property LineNotes        : String Read GetLineNotes Write SetLineNotes;
    Property CleanProductName : String Read GetCleanProductName;
    Property PartBarcode      : String Read GetPartBarcode Write SetPartBarcode;
    Property BaseLineNo       : Integer Read GetBaseLineno Write SetBaseLineno;
    Property BaseLineGlobalRef: String Read GetBaseLineGlobalRef Write SetBaseLineGlobalRef;

    property FormulaID: Integer read GetFormulaID write SetFormulaID;
    Property FormulaName :String read getFormulaName write setFormulaName;
    Property FormulaQtySoldValue    : Double Read GetFormulaQtySoldValue Write SetFormulaQtySoldValue;
    Property FormulaQtySoldValue1   : Double Read GetFormulaQtySoldValue1 Write SetFormulaQtySoldValue1;
    Property FormulaQtySoldValue2   : Double Read GetFormulaQtySoldValue2 Write SetFormulaQtySoldValue2;
    Property FormulaQtySoldValue3   : Double Read GetFormulaQtySoldValue3 Write SetFormulaQtySoldValue3;
    Property FormulaQtySoldValue4   : Double Read GetFormulaQtySoldValue4 Write SetFormulaQtySoldValue4;
    Property FormulaQtySoldValue5   : Double Read GetFormulaQtySoldValue5 Write SetFormulaQtySoldValue5;
    Property FormulaQtyShippedValue : Double Read GetFormulaQtyShippedValue Write SetFormulaQtyShippedValue;
    Property FormulaQtyShippedValue1: Double Read GetFormulaQtyShippedValue1 Write SetFormulaQtyShippedValue1;
    Property FormulaQtyShippedValue2: Double Read GetFormulaQtyShippedValue2 Write SetFormulaQtyShippedValue2;
    Property FormulaQtyShippedValue3: Double Read GetFormulaQtyShippedValue3 Write SetFormulaQtyShippedValue3;
    Property FormulaQtyShippedValue4: Double Read GetFormulaQtyShippedValue4 Write SetFormulaQtyShippedValue4;
    Property FormulaQtyShippedValue5: Double Read GetFormulaQtyShippedValue5 Write SetFormulaQtyShippedValue5;
    Property VoucherNo              : String Read GetVoucherNo Write SetVoucherNo;
    Property Isvoucher              : Boolean Read GetIsvoucher Write SetIsvoucher;
    Property AreaCode               : String Read getAreaCode Write SetAreaCode;

    property UOMLineCost: double read GetUOMLineCost;
    property UOMLineCostInc: double read GetUOMLineCostInc;
    property StandardCost: double read GetStandardCost write SetStandardCost;

    { the following don't seem to be used any more }
    // property CostCentreId: integer read GetCostCentreId write SetCostCentreId;
  End;

  TDoProductallocation = Function(Const LineObj: (* TTransLineBase *) TProdQty): Boolean Of Object;

  TTransBase = Class(TMSBusObj)
  Private
    FFXObj                 : TForeignExchangeObj;
    FDisableCalcOrderTotals: Boolean;
    TempLinesXMLNode       : IXMLNode;
    FTerms                 : TTerms;
    FPrintPickSlip         : TBusObjPrintDoc;
    ISeqNo                 : Integer;
    FShowStatus            : TTransProc1;
    // allLinesValid :Boolean;
    FiInvalidAllocationLine   : Integer;
    FiinCompleteAllocationLine: Integer;
    FiBOCount                 : Integer;
    FbUpdatingBo              : Boolean;
    FHasNonInvProducts        : Boolean;
    FLastSortId               : Integer;
    //FLastLinesOrder           : Integer;
    FdTotalLineAmountInc      : Double;
    Anylinesshipped           : Boolean;
    FbAllowNewRecordWhenLocked: Boolean;
    fsDisabledMaincontactName:String;
    fbCrossStockAdjustTransForinvoice :Boolean;
    fbLineInserting: Boolean;
    Function GetTotalAmount: Double;
    Function GetTotalAmountInc: Double;
    Function GetTotalTax: Double;
    Procedure SetTotalAmount(Const Value: Double);
    Procedure SetTotalAmountInc(Const Value: Double);
    Procedure SetTotalTax(Const Value: Double);
    Function GetClientId: Integer;
    Procedure SetClientId(Const Value: Integer);
    Function GetFXObj: TForeignExchangeObj;
    Function GetOriginalDocNumber: String;
    Function GetBaseNo: String;
    Procedure SetOriginalDocNumber(Const Value: String);
    Procedure SetBaseNo(Const Value: String);
    Function GetGLAccountName: String;
    Function GetGLAccountId: Integer;
    Procedure SetGLAccountName(Const Value: String);
    Procedure SetGLAccountId(Const Value: Integer);
    Procedure SetBackOrderGlobalRef(Const Value: String);
    Function GetEmployeeId: Integer;
    Function GetEmployeeName: String;
    Procedure SetEmployeeId(Const Value: Integer);
    Procedure SetEmployeeName(Const Value: String);
    Function GetDueDate: TDateTime;
    Procedure SetDueDate(Const Value: TDateTime);
    Function GetPrintedBy: String;
    Function GetPrintFlag: Boolean;
    Function GetIsPaid: Boolean;
    Function GetTermsName: String;
    Procedure SetIsPaid(Const Value: Boolean);
    Procedure SetTermsName(Const Value: String);
    Function GetTotalBalance: Double;
    Function GetTotalPaid: Double;
    Procedure SetTotalBalance(Const Value: Double);
    Procedure SetTotalPaid(Const Value: Double);
    Function GetDeleted: Boolean;
    Function GetCancelled: Boolean;
    Procedure SetDeleted(Const Value: Boolean);
    Function GetEnteredAt: String;
    Function GetEnteredBy: String;
    Procedure SetEnteredAt(Const Value: String);
    Procedure SetEnteredBy(Const Value: String);
    Function GetForeignBalanceAmount: Double;
    Procedure SetForeignBalanceAmount(Const Value: Double);
    Function GetForeignExchangeCode: String;
    Function GetForeignExchangeRate: Double;
    Function GetForeignPaidAmount: Double;
    Function GetForeignTotalAmount: Double;
    Procedure SetForeignExchangeCode(Const Value: String);
    Procedure SetForeignExchangeRate(Const Value: Double);
    Procedure SetForeignPaidAmount(Const Value: Double);
    Procedure SetForeignTotalAmount(Const Value: Double);
    Function GetGlAccount: TAccount;
    Function GetTerms: TTerms;
    Function GetRepeated: Integer;
    Procedure SetRepeated(Const Value: Integer);

    Procedure AssignSeqNonSortIDnLinesOrder(Const Sender: TBusObj; Var Abort: Boolean);
    Function GetPrintPickSlip: TBusObjPrintDoc;

    Function GetEditedFlag: Boolean;
    Procedure SetEditedFlag(Const Value: Boolean);
    Procedure Callbackshipall(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure CallbackBOCount(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure TotalLineAmountIncCallback(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure GetInvoicedCallback(Const Sender: TBusObj; Var Abort: Boolean);

    Function GetBOCount: Integer;
    Function GetcontactId: Integer;
    Function GetShipTocontactID: Integer;
    Function GetcontactName: String;
    Procedure SetcontactId(Const Value: Integer);
    Procedure SetShipTocontactID(Const Value: Integer);
    Procedure SetcontactName(Const Value: String);
    Function GetPrintedAt: String;
    Function GetPrintedOn: String;
    Procedure DeleteWith0QtyCallback(Const Sender: TBusObj; Var Abort: Boolean);
    Function GetInvoiced: Boolean;
    Procedure SetCancelled(Const Value: Boolean);
    Procedure MakeSoBO(Const Sender: TBusObj; Var Abort: Boolean);
    Function GetCleanTRansTotalAmountInc: Double;
    Function GetContactEmail: String;
    Function GetContactMobile: String;
    function getTranstoDesc: String;
    procedure setTranstoDesc(const Value: String);
    function getTransContact: TContact;
    Procedure CalcLineTotalsCallback(Const Sender: TBusObj; Var Abort: Boolean);
    function GetIsBackOrder: boolean;
    Function  GetComments		            : String;
    Procedure SetComments               (Const Value : String);
    function Getattachments: TAttachment;
    procedure DeleteallLinesCallback(const Sender: TBusObj; var Abort: Boolean);
    //function GetDetailLastSortno: Integer;
    //function GetDetailLastLinesOrder: Integer;

  Protected
    AllLinesValid        : Boolean;
    FoDoProductallocation: TDoProductallocation;

    Procedure LineValidateCallbackProc(Const Sender: TBusObj; Var Abort: Boolean); Virtual;
    Function ValidateLines: Boolean;
    Function GetLines: TTransLineBase; Virtual; Abstract;
    Function GetPrintDoc: TBusObjPrintDoc;
    // function GetClient: TClient; //virtual;
    Function GetClientName: String; Virtual; Abstract;
    Procedure SetClientName(Const Value: String); Virtual; Abstract;
    Procedure DoFieldOnChange(Sender: TField); Override;
    Property FXObj: TForeignExchangeObj Read GetFXObj;
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
    Function GetDocNumber: String; Virtual; Abstract;
    Procedure SetDocNumber(Const Value: String); Virtual; Abstract;
    // procedure SetDefaultData; override;
    Procedure PopulateClientData; Virtual;
    Procedure check4MainContact; virtual;

    Procedure CalcTotalsCallback(Const Sender: TBusObj; Var Abort: Boolean); Virtual;
    Procedure GetLineXMLCallback(Sender: TBusObj; Var Abort: Boolean);
    Function DeleteFlaggedLines: Boolean; Virtual;
    Procedure ProcessDeletedLine; Virtual;
    Procedure DeletePackWeightLines; Virtual;
    Procedure DeleteTaxLines; Virtual;
    Procedure ProcessLine; Virtual;
    // procedure InitializeNewObject; override;
    Procedure ClonePropertyObjects; Override;
    Function GetBackOrderGlobalRef: String;
    Function ImportsubClasses(Const Node: IXMLNode): Boolean; Override;
    Function ExportsubClasses(Const Node: IXMLNode): Boolean; Override;
    Function DoAfterPost(Sender: TDatasetBusObj): Boolean; Override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
    Procedure Show_Status(Const Value: String);
    Procedure UpdateInvoiced(Const Sender: TBusObj; Var Abort: Boolean);
    (* procedure DeleteemptyLines(Const Sender: TBusObj; var Abort: boolean); virtual; *)
    Procedure DeleteLineRecord(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure NewBOInit(BackOrder: TTransBase); Virtual;
    Procedure BOLinesInit(BackOrder: TTransBase); Virtual;
    Procedure ReadBO(BackOrder: TTransBase; Const IsCombinedBo: Boolean; Var CombinedTransRef: String);
    Procedure UpdateBO(BackOrder: TTransBase);
    Procedure UpdateBORefs;Virtual;
    Procedure BeforeupdateBOLine(BackOrder: TTransBase); Virtual;
    Function Validtocommit: Boolean; Override;
    Procedure CloneLines(Const Sender: TBusObj; Var Abort: Boolean); Virtual;
    function SaveCancelled: boolean; Virtual;
    Procedure AfterBODeleteCallback(Const Sender: TBusObj; Var Abort: Boolean); Virtual;
    Function GetClient: TClient; Virtual; Abstract;
    Property Client: TClient Read GetClient;
    Function ProcessPQADetailClasses: STring;
    Function GetTransName: String; Virtual;
    Function GetTransDate: TDateTime; Virtual; Abstract;
    Function RroundProductfilter: String; Virtual;
    Function SaveGuiValidate: Boolean; Virtual;
    Function GetTransStatus: String; Virtual; Abstract;
    Procedure SetTransStatus(Const Value: String); Virtual; Abstract;
    Procedure MaxNosofLines(Var iLinesID, iLinesOrder , iSortID , iSeqno:Integer);
    procedure ProgressprocesswithRecno(Sender:Tbusobj);
    function GetClientPrintName: String;Virtual;
    procedure SetClientPrintName(const Value: String);Virtual;
    procedure CalcForeignAmount;Virtual;
    Procedure GetClientDetails; Virtual;
    function getTransLinetotals: TTransLinetotals;Virtual;
    function  DoAfterOpen(Sender:TDatasetBusObj) : Boolean;             override;
    function getApprovaltype: String;Virtual;

  Public
    FbSaveGUIValidate: Boolean;

    Function LockTrans(Var ErrMsg: String): Boolean; Virtual;
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy; Override;
    Procedure New; Override;
    Procedure CalcOrderTotals; Virtual;
    Procedure CalcAllLineTotals; Virtual;
    Procedure DoCalcOrderTotals;
    Procedure SaveToXMLNode(Const Node: IXMLNode); Override;
    Procedure LoadFromXMLNode(Const Node: IXMLNode); Override;
    Procedure Load(Const FIsReadonly: Boolean = False); Override;
    Function ValidateData: Boolean; Override;
    Function GetDetailLastSeqNo: Integer;
    Procedure SetPaymentTerms(Const BaseDate: TDateTime); Virtual;
    Function IsBOInvoiced: Boolean; Virtual;
    Function IsTotalBackOrder: Boolean; Virtual; // if any shipped or not
    Property Lines: TTransLineBase Read GetLines;
    Property PrintPickSlip: TBusObjPrintDoc Read GetPrintPickSlip;
    // property Client: TClient read GetClient;
    Property BOCount: Integer REad GetBOCount;
    Property UpdatingBo: Boolean Read FbUpdatingBo Write FbUpdatingBo;
    Function QtyShippedForProduct(Const AProductId: Integer): Double;
    Procedure ShipAll;
    Function LineHasNonInvProduct(IId: Integer): Boolean;
    Function LineHasInvProduct(IId: Integer): Boolean;
    Function LineHasBO: Boolean;
    Procedure DeleteBackOrder(Const BackOrder: TTransBase);
    Procedure UpdateRelatedIDsInCopiedLines(DsSource, DsTarget: TTransBase); Virtual;
    Class Function TotalCalc(Const FsfieldName: String; Const FiTransID: Integer; Const FsIDFieldName: String; Const Fstablename: String; Conn: TCustomMyConnection = Nil): Double;
    Property HasNonInvProducts: Boolean Read FHasNonInvProducts Write FHasNonInvProducts;
    Function AvailableRewardPoints(Const CustomerID: Integer; Const SaleDate: TDatetime): Double;
    Function DeleteWith0Qty: Boolean;
    Function TotalLineAmountInc: Double;
    Property Invoiced: Boolean Read GetInvoiced;
    Property GLAccount: TAccount Read GetGlAccount;
    Property Terms: TTerms Read GetTerms;
    Property DoProductallocation: TDoProductallocation Read FoDoProductallocation Write FoDoProductallocation;
    Property ShowStatus: TTransProc1 REad FShowStatus Write FShowStatus;
    Property TransName: String Read GetTransName;
    Class Function _Schema: String; Override;
    Property CleanTRansTotalAmountInc: Double Read GetCleanTRansTotalAmountInc;
    Property TransDate: TDateTime Read GetTransDate;
    Function TranslineFilter(Const AddfilterforroundProduct: Boolean = True): String; Virtual;
    Property PrintDoc: TBusObjPrintDoc Read GetPrintDoc;
    Property AllowNewRecordWhenLocked: Boolean Read FbAllowNewRecordWhenLocked Write FbAllowNewRecordWhenLocked;
    Procedure PopulateMessageSubstituteList(SL: TStringList); Virtual;
    Property TransStatus: String Read GetTransStatus Write SetTransStatus;
    Function HasAllocation: Boolean;
    Property TranstoDesc :String read getTranstoDesc write setTranstoDesc;
    Property TransContact :TContact read getTransContact;
    Property DisabledMaincontactName :String read fsDisabledMaincontactName;
    Procedure InitARAccount; virtual;
    Procedure InitAPAccount; Virtual;
    Procedure InitPaymentAccount; Virtual;
    Procedure Recalculateall;
    Property CrossStockAdjustTransForinvoice :Boolean read fbCrossStockAdjustTransForinvoice write fbCrossStockAdjustTransForinvoice;
    Property TransLinetotals : TTransLinetotals read getTransLinetotals;
    Property LineInserting :Boolean read fbLineInserting write fbLineInserting;
    Function AnyApproved :Boolean;
    (*Procedure UnApproveTrans;*)
    Property Approvaltype :String read getApprovaltype;
    class function TransTotalBalance(TransId: integer; Conn: TCustomMyConnection = nil): double;
    property Attachments: TAttachment read Getattachments;

  Published
    Property ClientId: Integer Read GetClientId Write SetClientId;
    // property Client: TClient read GetClient;
    Property ClientName            : String Read GetClientName Write SetClientName;
    Property ClientPrintName       : String Read GetClientPrintName Write SetClientPrintName;
    Property DocNumber             : String Read GetDocNumber Write SetDocNumber;
    Property OriginalDocNumber     : String Read GetOriginalDocNumber Write SetOriginalDocNumber;
    Property BaseNo                : String Read GetBaseNo Write SetBaseNo;
    Property TotalTax              : Double Read GetTotalTax Write SetTotalTax;
    Property TotalAmount           : Double Read GetTotalAmount Write SetTotalAmount;
    Property TotalAmountInc        : Double Read GetTotalAmountInc Write SetTotalAmountInc;
    Property TotalPaid             : Double Read GetTotalPaid Write SetTotalPaid;
    Property TotalBalance          : Double Read GetTotalBalance Write SetTotalBalance;
    Property IsPaid                : Boolean Read GetIsPaid Write SetIsPaid;
    Property GLAccountName         : String Read GetGLAccountName Write SetGLAccountName;
    Property GLAccountId           : Integer Read GetGLAccountId Write SetGLAccountId;
    Property BackOrderGlobalRef    : String Read GetBackOrderGlobalRef Write SetBackOrderGlobalRef;
    Property EmployeeName          : String Read GetEmployeeName Write SetEmployeeName;
    Property EmployeeId            : Integer Read GetEmployeeId Write SetEmployeeId;
    Property DueDate               : TDateTime Read GetDueDate Write SetDueDate;
    Property PrintFlag             : Boolean Read GetPrintFlag; // write SetPrintFlag;
    Property PrintedBy             : String Read GetPrintedBy; // write SetPrintedBy;
    Property PrintedAt             : String REad GetPrintedAt;
    Property PrintedOn             : String Read GetPrintedOn;
    Property TermsName             : String Read GetTermsName Write SetTermsName;
    Property Deleted               : Boolean Read GetDeleted Write SetDeleted;
    Property Cancelled             : Boolean Read GetCancelled Write SetCancelled;
    Property EnteredBy             : String Read GetEnteredBy Write SetEnteredBy;
    Property EnteredAt             : String Read GetEnteredAt Write SetEnteredAt;
    Property EditedFlag            : Boolean Read GetEditedFlag Write SetEditedFlag;
    Property ForeignExchangeCode   : String Read GetForeignExchangeCode Write SetForeignExchangeCode;
    Property ForeignExchangeRate   : Double Read GetForeignExchangeRate Write SetForeignExchangeRate;
    Property ForeignTotalAmount    : Double Read GetForeignTotalAmount Write SetForeignTotalAmount;
    Property ForeignBalanceAmount  : Double Read GetForeignBalanceAmount Write SetForeignBalanceAmount;
    Property ForeignPaidAmount     : Double Read GetForeignPaidAmount Write SetForeignPaidAmount;
    Property DisableCalcOrderTotals: Boolean Read FDisableCalcOrderTotals Write FDisableCalcOrderTotals;
    Function CloneBusObj(Const Changefield: String; Const ChangeValue: Variant; Const SaveAfterCopy: Boolean = True; Const FilterFields: String = ''): TBusObj; Override;
    { link to tblContacts }
    Property ContactID: Integer Read GetcontactId Write SetcontactId;
    Property ShipTocontactID: Integer Read GetShipTocontactID Write SetShipTocontactID;
    Property ContactName: String Read GetcontactName Write SetcontactName;
    Function LockRec: Boolean;
    Function Lock: Boolean; Override;
    Property InvalidAllocationLine: Integer Read FiInvalidAllocationLine Write FiInvalidAllocationLine;
    Property IncompleteAllocationLine: Integer Read FiinCompleteAllocationLine Write FiinCompleteAllocationLine;
    property IsBackOrder: boolean read GetIsBackOrder;
    Property Comments	    : String		Read getComments		Write SetComments;
    Property ContactEmail: String Read GetContactEmail;
    Property ContactMobile: String Read GetContactMobile;
    Property RepeatedFrom: Integer  Read GetRepeated    Write SetRepeated;

  End;

  TPackWeightLinesBase = class(TMSBusObj)
  private
    AllLinesValid :Boolean;
    function GetPackCount           : Integer   ;
    function GetAttribValue1        : Double    ;
    function GetAttribValue2        : Double    ;
    function GetDeleted             : Boolean;
    procedure SetPackCount           (const Value: Integer   );
    procedure SetAttribValue1        (const Value: Double    );
    procedure SetAttribValue2        (const Value: Double    );
    Procedure SetDeleted             (Const Value: Boolean   );
    Procedure ValidateCallback(Const Sender: TBusObj; Var Abort: Boolean);
    function getTotalAttribValue1: double;
    function getTotalAttribValue2: double;
    function getTotalPackCount: Integer;
    procedure SetTransLineID      (const Value: Integer   );
    function GetTransLineID      : Integer   ;
    function GetTotal(Fieldno: Integer): Double;
    Procedure DeleteFlaggedLines;
  protected

    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
    function  DoAfterOpen(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function getTranslineIDField:String; virtual; Abstract;

  public
    class function  GetIDField                   : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property TotalAttribValue1 :double read getTotalAttribValue1;
    Property TotalAttribValue2 :double read getTotalAttribValue2;
    Property TotalPackCount    :Integer read getTotalPackCount;
    Property TranslineIDField :String read getTranslineIDField;
  published
    property TransLineID  :Integer  read GetTransLineID   write SetTransLineID  ;
    property PackCount    :Integer  read GetPackCount     write SetPackCount       ;
    property AttribValue1 :Double   read GetAttribValue1  write SetAttribValue1    ;
    property AttribValue2 :Double   read GetAttribValue2  write SetAttribValue2    ;
    Property Deleted      :Boolean  read getDeleted       write SetDeleted;
  end;


Implementation

Uses
  SysUtils, Dialogs, Controls,
  // ERP stuff
  CommonLib,

  DateUtils, BusObjSales, BusObjOrders, TcDataUtils, BusobjSaleBase, Windows,
  AppEnvironment, SalesConst, BusobjCash, BusobjExpenses, BusObjConst,
  BusObjUtils, LogUtils, CommonDbLib, TcConst, Forms, BusObjSchemaLib,
  BusObjEmployee, DNMLib, ParserLib, BusObjOrderBase, busobjvouchersale,
  busobjPOS, BusObjPOSSale, BusObjProcess, LogLib, DbSharedObjectsObj,
  BusObjFeTransLines, BusobjProductFormula, AppEnvVirtualObj;

// ------------------------------------------------------------------------------
{ TTransBase }
// ------------------------------------------------------------------------------

Constructor TTransBase.Create(AOwner: TComponent);
Begin
  CrossStockAdjustTransForinvoice := False;
  Inherited Create(AOwner);
  FFXObj                  := Nil;
  FTerms                  := Nil;
  FDisableCalcOrderTotals := False;
  FShowStatus             := Nil;
  FHasNonInvProducts      := False;
  ExportExcludeList.Add('clientid');
  ExportExcludeList.Add('contactid');
  ExportExcludeList.Add('ShipTocontactID');
  ExportExcludeList.Add('glaccountid');
  ExportExcludeList.Add('employeeid');
  ExportExcludeList.Add('editedflag');
  ExportExcludeList.Add('disablecalcordertotals');
  ExportExcludeList.Add('invalidallocationline');
  ExportExcludeList.Add('incompleteallocationline');
  AllowNewRecordWhenLocked := False;
  FieldChangetoIgnoreInRawMode('TotalAmount');
  FieldChangetoIgnoreInRawMode('Totalamountinc');
  FieldChangetoIgnoreInRawMode('TotalTax');
  FieldChangetoIgnoreInRawMode('balance');
  FieldChangetoIgnoreInRawMode('Payment');
  FieldChangetoIgnoreInRawMode('ForeignTotalAmount');
  FieldChangetoIgnoreInRawMode('ForeignPaidAmount');
  FieldChangetoIgnoreInRawMode('ForeignBalanceAmount');
End;

Destructor TTransBase.Destroy;
Begin
  FreeAndNil(FFXObj);
  Inherited;
End;

procedure TTransBase.GetClientDetails;
var
  strTemp:String;
begin
  if clientID>0 then begin
    ClientName := Client.ClientName;
    ClientPrintName:= Client.Printname;
    If Not RawMode Then begin
        strTemp :=ForeignExchangeCode;
        PopulateClientData;
        if not (sametext(strTemp , ForeignExchangeCode)) then
          DofieldOnchange(Dataset.FindField('ForeignExchangeCode'));
    end;
    If ClientID = 0 Then Begin
      ClientName := '';
    End;
  end;
end;
Procedure TTransBase.DeleteallLinesCallback(Const Sender: TBusObj; Var Abort: Boolean);
begin
  if deleted then begin
    Lines.deleted := True;
    PostDB;
  end;
end;
Procedure TTransBase.DoFieldOnChange(Sender: TField);
var
  strTemp:String;
Begin
  Inherited;
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then Exit; // we are only interested in data fields.
  If Sysutils.SameText(Sender.FieldName, 'Deleted') Then Begin
    if Deleted then
      Lines.iteraterecords(DeleteallLinesCallback);
  end else If Sysutils.SameText(Sender.FieldName, 'ClientID') Then Begin
    ContactId :=0;
    ContactId :=0;
    If Not RawMode Then begin
        strTemp :=ForeignExchangeCode;
        GetClientDetails;
        //PopulateClientData;
        if not (sametext(strTemp , ForeignExchangeCode)) then
          DofieldOnchange(Dataset.FindField('ForeignExchangeCode'));
    end;
  End Else If Sysutils.SameText(Sender.FieldName, 'CustomerName') Then Begin
    If ClientName = '' Then
      ClientId := 0
    Else Begin
      ClientID := TClient.IDToggle(Sender.AsString, Connection.Connection); // tcDAtautils.GetClientID(ClientName);
      DofieldOnchange(Dataset.FindField('ClientID'));
      (*ContactId :=0;
      If Not RawMode Then begin
        strTemp :=ForeignExchangeCode;
        PopulateClientData;
        if not (sametext(strTemp , ForeignExchangeCode)) then
          DofieldOnchange(Dataset.FindField('ForeignExchangeCode'));
      end;*)
    End;

    If ClientID = 0 Then Begin
      ClientName := '';
    End;
  End Else If Sysutils.SameText(SEnder.Fieldname, 'ContactID') Then Begin
    if ContactId > 0 then begin
      Contactname := TransContact.contactfullname;
      strTemp := TransContact.ContactDetails;
      if not(Sametext(Client.clientName, Client.Printname)) then StrTemp  := Client.Printname + #13#10 + StrTemp;
      if StartsWith(strTemp , ClientName) and (Appenv.CompanyPrefs.IncludeContactNameInSalesShippingAddress) then else StrTemp  := ClientName + #13#10 + StrTemp;
      TranstoDesc := strTemp;
      PostDB;
    end else begin
      Contactname :='';
    end;

  End Else If Sysutils.SameText(SEnder.Fieldname, 'ContactName') Then Begin
    ContactID := TContact.ContactID(ContactName, ClientName, TERPConnection(Connection.Connection));
    DofieldOnchange(Dataset.FindField('contactID'));
  End  Else If Sysutils.SameText(Sender.FieldName, 'EmployeeName') Then Begin
    EmployeeID := TEmployee.IDToggle(EmployeeName, Connection.Connection);
  End Else If Sysutils.SameText(Sender.FieldName, 'EmployeeID') Then Begin
    EmployeeName := TEmployee.IDToggle(EmployeeID, Connection.Connection);
  End Else If Sysutils.SameText(Sender.FieldName, 'AccountID') Then Begin
    GLAccountName := TAccount.IDToggle(GLAccountID, Connection.Connection);
  End Else If Sysutils.SameText(Sender.FieldName, 'Account') Then Begin
    GLAccountID := TAccount.IDToggle(GLAccountName, Connection.Connection);
  End Else If Sysutils.SameText(Sender.FieldName, 'ForeignExchangeCode') Then Begin
    SendEvent(BusObjEvent_Change, BusObjEventVal_FCChanged, Self);
  End Else If Sysutils.SameText(Sender.FieldName, 'ForeignExchangeRate') Then Begin
    CalcForeignAmount;
  End;
End;

// function TTransBase.GetClient: TClient;
// var
// strSQL:String;
// begin
// if (self.ClientId > 0) then
// strSQL:= 'ClientId = ' + IntToStr(self.ClientId)
// else if (self.ClientName <> '') then
// strSQL:= 'Company = ' + QuotedStr(self.ClientName);
// result := TClient(getContainerComponent(TClient, strSQL , true, true,true,'',true));
// result.BusObjEvent := Self.BusObjEvent;
// end;

Function TTransBase.GetPrintPickSlip: TBusObjPrintDoc;
Begin
  { print doc is outside transaction
    this will update the printcout even when the doc is rinted and then cancelled }
  If Not Assigned(FPrintPickSlip) Then Begin
    FPrintPickSlip := TBusObjPrintDoc.CreateWithSharedConn(Self);  // should not be within transaction to avoid the locking
  End;
  If (FPrintPickSlip.DocName <> Self.ClassName) Or (Self.Id <> FPrintPickSlip.DocId) Then FPrintPickSlip.LoadSelect('docName = ' + QuotedStr('PickingSlip') + ' and DocId = ' + IntToStr(Self.ID));
  Result := FPrintPickSlip;
End;

Function TTransBase.GetPrintDoc: TBusObjPrintDoc;
Begin
  Result := TBusObjPrintDoc(Getcontainercomponent(TBusObjPrintDoc, 'docName = ' + QuotedStr(Self.ClassName) + ' and DocId = ' + IntToStr(Self.ID)));
  If Assigned(Result) Then Result.IsList := True;
End;

Procedure TTransBase.PopulateClientData;

  function IsStopCredit: boolean;
  begin
    result := Client.StopCredit;
    if not result then exit;
    if (self is TInvoice) then begin
      result := (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnOverideInvoiceStopCredit') <> 1);
    end
    else if (self is TSalesOrder) then begin
      result := (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnOverideSalesOrderStopCredit') <> 1);
    end
  end;

Begin
  If Self.ClientId > 0 Then Begin
    If IsStopCredit Then Begin
      if (self is TInvoice) and  AppEnv.CompanyPrefs.PreventInvoiceOnStopCredit then
        ResultStatus.AddItem(False, RssWarning, 0, 'This Customer is on Stop Credit so it is not possible to make an Invoice for this customer.' + #13#10 + #13#10 +
          'The invoice will now close automatically.' )
      else
      if (self is TSalesOrder) and  AppEnv.CompanyPrefs.PreventSalesOrderOnStopCredit then
        ResultStatus.AddItem(False, RssWarning, 0, 'This Customer is on Stop Credit so it is not possible to make a Sales Order for this customer.' + #13#10 + #13#10 +
          'The Sales Order will now close automatically.' )
      else
        ResultStatus.AddItem(False, RssWarning, 0, 'This Customer is on Stop Credit !');
      self.SendEvent(BusObjEvent_Warning, BusobjEventVal_StopCredit, self);
    End;
    If UpdatingBo = False Then
      If (Client.RepId > 0) And (AppEnv.CompanyPrefs.DefaultRepUser = False) Then Begin
        // use the rep assigned to this customer
        EmployeeId   := Client.RepId;
        EmployeeName := Client.RepName;
      End Else Begin
        // ... else use the current logged in employee
        EmployeeId   := AppEnv.Employee.EmployeeID;
        EmployeeName := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
      End;
    if ContactId =0 then begin
      check4MainContact;
      if contactID<> 0 then
        DofieldOnchange(Dataset.FindField('contactID'));
    end;
  End;
  SendEvent(BusObjEvent_Change, BusObjEventVal_ClientID, Self);
End;

Procedure TTransBase.PopulateMessageSubstituteList(SL: TStringList);
Begin

End;

Function TTransBase.GetGLAccount: TAccount;
Var
  StrSQL: String;
Begin
  If (GLAccountId > 0) Then StrSQL          := 'AccountID = ' + IntToStr(GLAccountId)
  Else If (GLAccountName <> '') Then StrSQL := 'AccountName = ' + QuotedStr(GLAccountName);
  Result                                    := TAccount(GetContainerComponent(TAccount, StrSQL));
End;

Function TTransBase.GetTerms: TTerms;
Begin
  If Not Assigned(FTerms) Then FTerms := TTerms.Create(Self);
  If (TermsName <> FTerms.TermsName) Then FTerms.LoadSelect('Terms = ' + QuotedStr(TermsName));
  Result := FTerms;
End;

function TTransBase.Getattachments: TAttachment;
begin
  Result := TAttachment(GetcontainerComponent(TAttachment,
    'Tablename = ' + Quotedstr(GetBusObjectTablename) + ' and TableID =' + IntToStr(ID)));
end;

Function TTransBase.GetBackOrderGlobalRef: String;
Begin
  Result := GetStringField('BOID');
End;

Function TTransBase.GetClientId: Integer;
Begin
  Result := GetIntegerField('ClientId');
End;

function TTransBase.GetClientPrintName: String;
begin
  Result := GetStringField('ClientPrintName');
end;

function TTransBase.GetRepeated: Integer;
begin
  Result := GetIntegerField('RepeatedFrom');
end;

Function TTransBase.GetContactEmail: String;
Var
  Contact: TContact;
Begin
  Result := '';
  If Self.ContactId > 0 Then Begin
    Contact := TContact.Create(Nil);
    Try
      Contact.Connection := Self.Connection;
      Contact.Load(Self.ContactID, True);
      Result := Contact.ContactEmail;
    Finally Contact.Free;
    End;
  End;
End;

Function TTransBase.GetDeleted: Boolean;
Begin
  Result := GetBooleanField('Deleted');
End;

Function TTransBase.GetCancelled: Boolean;
Begin
  Result := GetBooleanField('Cancelled');
End;

Function TTransBase.GetDueDate: TDateTime;
Begin
  Result := GetDateTimeField('DueDate');
End;

Function TTransBase.GetEmployeeId: Integer;
Begin
  Result := GetIntegerField('EmployeeId');
End;

Function TTransBase.GetEmployeeName: String;
Begin
  Result := GetStringField('EmployeeName');
End;

Function TTransBase.GetEnteredAt: String;
Begin
  Result := GetStringField('EnteredAt');
End;

Function TTransBase.GetEnteredBy: String;
Begin
  Result := GetStringField('EnteredBy');
End;

Function TTransBase.GetFXObj: TForeignExchangeObj;
Begin
  If Not Assigned(FFXObj) Then FFXObj := TForeignExchangeObj.Create;
  Result                              := FFXObj;
End;

Function TTransBase.GetGLAccountName: String;
Begin
  Result := GetStringField('Account');
End;

Function TTransBase.GetGLAccountId: Integer;
Begin
  Result := GetIntegerField('AccountId');
End;

function TTransBase.GetIsBackOrder: boolean;
begin
  if not ((Self is TPurchaseOrder) or (Self is TInvoice) or (Self is TSalesOrder)) then Result := False
  else result := (BackOrderGlobalRef = '') and (Lines.Count > 0) and (Lines.Invoiced = false); { any line }
end;

Function TTransBase.GetIsPaid: Boolean;
Begin
  Result := GetBooleanField('Paid');
End;

Function TTransBase.GetOriginalDocNumber: String;
Begin
  Result := GetStringField('OriginalNo');
End;

Function TTransBase.GetBaseNo: String;
Begin
  Result := GetStringField('BaseNo');
End;

Function TTransBase.GetPrintedBy: String;
Begin
  // result:= GetStringField('PrintedBy');
  Result := TcDatautils.GetUserName(Printdoc.PrintedBy);
End;

Function TTransBase.GetPrintFlag: Boolean;
Begin
  // result:= GetBooleanField('PrintFlag');
  Result := PrintedBy <> '';
End;

Function TTransBase.GetTermsName: String;
Begin
  Result := GetStringField('Terms');
End;

Function TTransBase.GetTotalAmount: Double;
Begin
  Result := GetFloatField('TotalAmount');
End;

Function TTransBase.GetTotalAmountInc: Double;
Begin
  Result := GetFloatField('TotalAmountInc');
End;

Function TTransBase.GetTotalBalance: Double;
Begin
  Result := GetFloatField('Balance');
End;

Function TTransBase.GetTotalPaid: Double;
Begin
  Result := GetFloatField('Payment');
End;

Function TTransBase.GetTotalTax: Double;
Begin
  Result := GetFloatField('TotalTax');
End;

function TTransBase.getTransContact: TContact;
begin
  Result := TContact(Getcontainercomponent(TContact, 'contactID = ' +inttostr(contactID) ));
end;

function TTransBase.getTransLinetotals: TTransLinetotals;
begin
  REsult := nil;
end;

Function TTransBase.GetTransName: String;
Begin
  Result := '';
End;

function TTransBase.getTranstoDesc: String;
begin
  if self is TSalesBase then Result := TSalesBase(Self).InvoiceToDesc
  else if self is TOrderbase then result := TOrderbase(Self).orderto
  else result := '';
end;

Function TTransBase.HasAllocation: Boolean;
Begin
  With GetNewDataset('Select count(pqad.pqadetailid) as ctr from tblpqa pqa inner join tblpqadetails pqad on pqa.pqaid = pqad.pqaid where transtype = ' + Quotedstr(Lines.ClassName) +
    ' and pqa.TransId = ' + Inttostr(ID), True) Do
    Try Result := Fieldbyname('ctr').AsInteger > 0;
    Finally
      If Active Then Close;
      Free;
    End;
End;

Procedure TTransBase.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
Begin
  Inherited;
  FreeAndNil(FTerms);
End;

Procedure TTransBase.SetBackOrderGlobalRef(Const Value: String);
Begin
  SetStringField('BOID', Value);
End;

Procedure TTransBase.SetClientId(Const Value: Integer);
Begin
  SetIntegerField('ClientId', Value);
End;

procedure TTransBase.SetClientPrintName(const Value: String);
begin
  SetStringField('ClientPrintName', Value);
end;

Procedure TTransBase.SetDeleted(Const Value: Boolean);
Begin
  SetBooleanField('Deleted', Value);
End;

Procedure TTransBase.SetCancelled(Const Value: Boolean);
Begin
  SetBooleanField('Cancelled', Value);
End;

Procedure TTransBase.SetDueDate(Const Value: TDateTime);
Begin
  SetDateTimeField('DueDate', Value);
End;

Procedure TTransBase.SetEmployeeId(Const Value: Integer);
Begin
  SetIntegerField('EmployeeId', Value);
End;

Procedure TTransBase.SetEmployeeName(Const Value: String);
Begin
  SetStringField('EmployeeName', Value);
End;

Function TTransBase.GetEditedFlag: Boolean;
Begin
  REsult := GetBooleanfield('EditedFlag');
End;

Procedure TTransBase.SetEditedFlag(Const Value: Boolean);
Begin
  SetBooleanField('editedFlag', Value);
End;

Procedure TTransBase.SetEnteredAt(Const Value: String);
Begin
  SetStringField('EnteredAt', Value);
End;

Procedure TTransBase.SetEnteredBy(Const Value: String);
Begin
  SetStringField('EnteredBy', Value);
End;

Procedure TTransBase.SetGLAccountName(Const Value: String);
Begin
  SetStringField('Account', Value);
End;

Procedure TTransBase.SetGLAccountId(Const Value: Integer);
Begin
  SetIntegerField('AccountId', Value);
End;

Procedure TTransBase.SetIsPaid(Const Value: Boolean);
Begin
  SetBooleanField('Paid', Value);
End;

Procedure TTransBase.SetOriginalDocNumber(Const Value: String);
Begin
  SetStringField('OriginalNo', Value);
End;

Procedure TTransBase.SetBaseNo(Const Value: String);
Begin
  SetStringField('BaseNo', Value);
End;

{ procedure TTransBase.SetPrintedBy(const Value: string);
  begin
  SetStringField('PrintedBy', Value);
  end; }

{ procedure TTransBase.SetPrintFlag(const Value: boolean);
  begin
  SetBooleanField('PrintFlag', Value);
  end; }

Procedure TTransBase.SetTermsName(Const Value: String);
Begin
  SetStringField('Terms', Value);
End;

Procedure TTransBase.SetTotalAmount(Const Value: Double);
Begin
  SetFloatField('TotalAmount', Value);
End;

Procedure TTransBase.SetTotalAmountInc(Const Value: Double);
Begin
  SetFloatField('TotalAmountInc', Value);
End;

Procedure TTransBase.SetTotalBalance(Const Value: Double);
Begin
  SetFloatField('Balance', Value);
End;

Procedure TTransBase.SetTotalPaid(Const Value: Double);
Begin
  SetFloatField('Payment', Value);
End;

Procedure TTransBase.SetTotalTax(Const Value: Double);
Begin
  SetFloatField('TotalTax', Value);
End;

procedure TTransBase.setTranstoDesc(const Value: String);
begin
       if self is TSalesBase    then TSalesBase(Self).InvoiceToDesc := Value
  else if self is TOrderbase    then TOrderbase(Self).orderto       := value
  else if self is TExpenseBase  then TExpenseBase(Self).orderto     := value;
end;
Function TTransBase.GetComments:String;begin	Result := GetStringfield('Comments');End;
Procedure TTransBase.SetComments(Const Value :String);begin	SetStringfield('Comments',Value);End;

Function TTransBase.GetForeignBalanceAmount: Double;
Begin
  Result := GetFloatField('ForeignBalanceAmount');
End;

Procedure TTransBase.SetForeignBalanceAmount(Const Value: Double);
Begin
  SetFloatField('ForeignBalanceAmount', Value);
End;

Function TTransBase.GetForeignExchangeCode: String;
Begin
  Result := GetStringField('ForeignExchangeCode');
End;

Function TTransBase.GetForeignExchangeRate: Double;
Begin
  Result := GetFloatField('ForeignExchangeRate');
End;

Function TTransBase.GetForeignPaidAmount: Double;
Begin
  Result := GetFloatField('ForeignPaidAmount');
End;

Function TTransBase.GetForeignTotalAmount: Double;
Begin
  Result := GetFloatField('ForeignTotalAmount');
End;

Procedure TTransBase.SetForeignExchangeCode(Const Value: String);
Begin
  SetStringField('ForeignExchangeCode', Value);
End;

Procedure TTransBase.SetForeignExchangeRate(Const Value: Double);
Begin
  SetFloatField('ForeignExchangeRate', Value);
End;

Procedure TTransBase.SetForeignPaidAmount(Const Value: Double);
Begin
  SetFloatField('ForeignPaidAmount', Value);
End;

Procedure TTransBase.SetForeignTotalAmount(Const Value: Double);
Begin
  SetFloatField('ForeignTotalAmount', Value);
End;

procedure TTransBase.CalcAllLineTotals;
begin
//  Progressbarmsg:= 'Calculating Totals';
//  self.Progresscount := self.Lines.Count;
//  SendEvent(BusobjEvent_ToDo,BusobjEvent_ShowProgressbar, self.Lines);
  ShowProgressBar(Lines.Count,'Calculating Totals');
  Lines.iteraterecords(CalcLineTotalsCallback);
  HideProgressbar;
end;

procedure TTransBase.CalcLineTotalsCallback(const Sender: TBusObj;
  var Abort: Boolean);
begin
  if not(sender is TTranslinebase) then exit;
  TTranslinebase(Sender).CalcLineTotals;
  TTranslinebase(Sender).PostDB;
  self.stepProgressbar();
end;

Procedure TTransBase.CalcOrderTotals;
Begin
  If FDisableCalcOrderTotals Then Exit;
  { Override in ancesters }
End;

Procedure TTransBase.CalcTotalsCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  { Override in ancesters }
End;

Function TTransBase.IsTotalBackOrder: Boolean;
var
  Qry :TERPQuery;
Begin
  result := False;
  if lines.count =0 then exit;

  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.Connection.Connection);
  try
    commondblib.closedb(qry);
    qry.sql.text := ' SELECT Sum(abs(ifnull(TransLines.Shipped,0))) as ShippedSum ' +
                    ' FROM ' + Lines.BusObjectTableName+ ' as TransLines ' +
                    ' WHERE TransLines.' + IDFieldname+' =   ' + inttostr(ID);
    commondblib.opendb(qry);
    Result := qry.FieldByname('ShippedSum').asFloat = 0;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
End;

Procedure TTransBase.SetPaymentTerms(Const BaseDate: TDateTime);
Begin
  If BaseDate = 0 Then Exit;

  // if Assigned(Client) and Assigned(Client.Terms) then begin
  // if not Client.Terms.EOM then begin
  // DueDate := IncDay(BaseDate, Client.Terms.Days);
  // end else begin
  // { EOM = true }
  // if Client.Terms.EOMPlus then begin
  // DueDate := IncDay(IncHOur(EndOfTheMonth(IncMonth(BaseDate, 1)), - 1), Client.Terms.Days);
  // end else begin
  // { not EOMPlus}
  // DueDate := IncDay(IncHour(EndOfTheMonth(BaseDate), - 1), Client.Terms.Days);
  // end;
  // end;
  // end;

  (*If (Terms.TermsName <> '') Then Begin
    If Not Terms.EOM Then Begin
      DueDate := IncDay(BaseDate, Terms.Days);
    End Else Begin
      { EOM = true }
      If Terms.EOMPlus Then Begin
        DueDate := IncDay(IncHOur(EndOfTheMonth(IncMonth(BaseDate, 1)), -1), Terms.Days);
      End Else Begin
        { not EOMPlus }
        DueDate := IncDay(IncHour(EndOfTheMonth(BaseDate), -1), Terms.Days);
      End;
    End;
  End;*)
  Duedate := Terms.Duedate(Basedate , self);

End;

Function TTransBase.CloneBusObj(Const Changefield: String; Const ChangeValue: Variant; Const SaveAfterCopy: Boolean = True; Const FilterFields: String = ''): TBusObj;
Begin
  Result := Inherited CloneBusObj(ChangeField, ChangeValue, SaveAfterCopy, FilterFields);
  If Result = Nil Then Exit;
  Result := ObjInstanceToClone;
  // TTransBase(ObjInstanceToClone).GlobalRef       := AppEnv.Branch.SiteCode + IntToStr(ObjInstanceToClone.Id);
  TTransBase(ObjInstanceToClone).BackOrderGlobalRef := '';
  TTransBase(ObjInstanceToClone).DocNumber          := IntToStr(TTransBase(ObjInstanceToClone).Id);
  TTransBase(ObjInstanceToClone).OriginalDocNumber  := TTransBase(ObjInstanceToClone).GlobalRef;
  TTransBase(ObjInstanceToClone).BaseNo             := '';
  TTransBase(ObjInstanceToClone).PostDB;
  TTransBase(ObjInstanceToClone).CalcOrderTotals;
  TTransBase(ObjInstanceToClone).PostDB;

  { copy attachments }
  CopyAttachments(Self.TableName, Self.ID, ObjInstanceToClone.TableName, ObjInstanceToClone.ID, Self.Connection.Connection);
End;

Procedure TTransBase.ClonePropertyObjects;
Begin
  Lines.IterateRecords(CloneLines);
End;

Procedure TTransBase.CloneLines(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  // copy line only if the line has records in it.
  If Sender.Dataset.REcordcount > 0 Then Begin

    Lines.FieldsnotToclone := Lines.ExcludeFromclone + ',' + Lines.FieldsnotToclone;
    If (Self Is TSalesOrder) And ((TSalesOrder(Self).CopyingToCashSale) Or (TSalesOrder(Self).CopyingToInvoice)) Then
        TSalesLineBase(Sender).FieldsnotToclone := ReplaceStr(TSalesLineBase(Sender).FieldsnotToclone, QuotedStr('SoldSerials'), '');
    if (Self is TPurchaseOrder)  and (TPurchaseOrder(Self).CopyingToPO) then
      TSalesLineBase(Sender).FieldsnotToclone := ReplaceStr(TSalesLineBase(Sender).FieldsnotToclone, QuotedStr('serialno'), '');

    Sender.CloneBusObj(IDFieldNAme, ObjInstanceToClone.ID, False);
    If Sender.ObjInstanceToClone = Nil Then Begin
      FbObjectCopied := False;
      Exit;
    End;
    { search for Product for Purchase and Sales and account for the expense forms }
    If ((Self Is TPurchaseOrder) Or (Self Is TSales) Or (Self Is TCashBase) Or (Self Is TReturnAuthority)) And
      (Not(Sender.ObjInstanceToClone.Dataset.Locate(Self.IDfieldname + ';ProductID;SeqNo', VarArrayof([Self.ObjInstanceToClone.ID, TTransLineBase(Sender).ProductID, TTransLineBase(Sender).SeqNo]), [])
      )) Then Begin
      FbObjectCopied := False;
      Exit;
    End
    Else If (Self Is TExpensebase) And (Not(Sender.ObjInstancetoclone.Dataset.Locate(Self.IDFieldName + ';AccountName;SeqNo',
      VarArrayof([Self.ObjInstanceToClone.ID, TExpenseLineBase(Sender).Accountname, TExpenseLineBase(Sender).SeqNo]), []))) Then Begin
      FbObjectCopied := False;
      Exit;
      // End else if (Sender.ObjInstanceToClone is TRefundSaleLine) then begin
      // TRefundSaleLine(Sender.ObjInstanceToClone).RefundQty := 0-TSalesLineBase(Sender).UOMQtyShipped;
      // TRefundSaleLine(Sender.ObjInstanceToClone).ClonedFromId := TSalesLineBase(Sender).ID;
    End;
    // if Self is TSales then begin
    // TSalesLineBase(Sender.ObjInstanceToClone).ParentProductID := TSalesLineBase(Sender).ID;
    // PostDB;
    // end;
    If (Self Is TSalesBase) Then TSalesBase(ObjInstanceToClone).ConvertingSO := TSalesBase(Self).ConvertingSO;
    { do the defualt Qty for a converted Quote before the allocation }
    If ((ObjInstanceToClone Is TSalesBase) And (TSalesBase(ObjInstanceToClone).ConvertingQuote)) (*OR ((ObjInstanceToClone Is TInvoice) And (TInvoice(ObjInstanceToClone).ConvertingSO))*) Then
      If TSalesLineBase(Sender.ObjInstanceToClone).Dataset.Locate('ProductID;SeqNo', Vararrayof([TSalesLineBase(Sender).ProductID, TSalesLineBase(Sender).SeqNo]), []) Then Begin
        TSalesBase(Self.ObjInstanceToClone).ConvertingQuote := TSalesBase(Self).ConvertingQuote;
        If TSalesLineBase(Sender.ObjInstanceToClone).QtyShipped = 0 Then TSalesBase(Self).AssignDefaultShipped(Sender.ObjInstanceToClone, Abort);
        // TSalesLineBase(Sender.ObjInstanceToClone).OriginalLinePrice := TSalesLineBase(Sender).OriginalLinePrice;
        // TSalesLineBase(Sender.ObjInstanceToClone).LinePrice := TSalesLineBase(Sender).LinePrice;
        //
        // if TSalesLineBase(Sender).DiscountAmount <> 0 then
        // TSalesLineBase(Sender.ObjInstanceToClone).Discountamount := TSalesLineBase(Sender).Discountamount;
        // if TSalesLineBase(Sender).DiscountPercent <> 0 then
        // TSalesLineBase(Sender.ObjInstanceToClone).DiscountPercent := TSalesLineBase(Sender).DiscountPercent;
        // if TSalesLineBase(Sender).MarkupAmount <> 0 then
        // TSalesLineBase(Sender.ObjInstanceToClone).MarkupAmount := TSalesLineBase(Sender).MarkupAmount;
        // if TSalesLineBase(Sender).MarkupPercent <> 0 then
        // TSalesLineBase(Sender.ObjInstanceToClone).MarkupPercent := TSalesLineBase(Sender).MarkupPercent;
      End;
    If ((ObjInstanceToClone Is TSalesorder) And (TSalesBase(Self).ConvertingQuote)) Then
      If AppEnv.CompanyPrefs.BOByDefaultOnSO Then TSalesorder(ObjInstanceToClone).Lines.Iteraterecords(MakeSoBO);
    If (ObjInstanceToClone Is TPurchaseOrder) Or ((ObjInstanceToClone Is TSalesOrder) And (AppEnv.CompanyPrefs.BarcodePickingInSOMode) And
      Not((Self Is TSalesOrder) And (TSalesOrder(Self).CopyingToSalesorder))) Or ((ObjInstanceToClone Is TInvoice) And (TInvoice(ObjInstanceToClone).ConvertingSO = False)) Or
      ((ObjInstanceToClone Is TInvoice) And (TInvoice(ObjInstanceToClone).ConvertingQuote)) Or
      ((ObjInstanceToClone Is TCashSale) And (TCashSale(ObjInstanceToClone).ConvertingSO) And (Not(AppEnv.CompanyPrefs.BarcodePickingInSOMode))) Or
      ((ObjInstanceToClone Is TCashSale) And (TCashSale(ObjInstanceToClone).ConvertingQuote)) Or
      ((ObjInstanceToClone Is TInvoice) And (TInvoice(ObjInstanceToClone).ConvertingSO) And (Not(AppEnv.CompanyPrefs.BarcodePickingInSOMode))) Then
      If Assigned(FoDoProductallocation) Then Begin
        FoDoProductallocation(TTransLineBase(Sender.ObjInstanceToClone));
        Sender.ObjInstanceToClone.ShowRec(ObjInstanceToClone.ID, '');
      End;
      {Beri had a couple of transactions with wrong margin percentage
      and converting a so to invoice is recalculating the price}
    if Sender.ObjInstanceToClone is TSalesLineBase then
          if TSalesLineBase(Sender.ObjInstanceToClone).MarginPercent <> 0 then
            if (TSalesLineBase(Sender.ObjInstanceToClone).MarginAmount =0) and (TSalesLineBase(Sender.ObjInstanceToClone).LinePrice<>0) and (TSalesLineBase(Sender.ObjInstanceToClone).LineCost<>0) then
              try
                TSalesLineBase(Sender.ObjInstanceToClone).MarginPercent := DivZer((TSalesLineBase(Sender.ObjInstanceToClone).LinePrice-TSalesLineBase(Sender.ObjInstanceToClone).LineCost),TSalesLineBase(Sender.ObjInstanceToClone).LinePrice)*100;
              Except
                on E:Exception do begin
                    MessageDlgXP_Vista(E.message, mtWarning, [mbOK], 0);
                end;
              end;
    if (Sender.ObjInstanceToClone is TSalesLineBase) and (Sender is TSalesLineBase) then
      if TSalesLineBase(Sender).discountamount<>0 then
        TSalesLineBase(Sender.ObjInstanceToClone).discountamount :=TSalesLineBase(Sender).discountamount
      else if TSalesLineBase(Sender).DiscountPercent<>0 then
        TSalesLineBase(Sender.ObjInstanceToClone).DiscountPercent :=TSalesLineBase(Sender).DiscountPercent
      else if TSalesLineBase(Sender).MarginAmount<>0 then
        TSalesLineBase(Sender.ObjInstanceToClone).MarginAmount :=TSalesLineBase(Sender).MarginAmount;


    if Sender.ObjInstanceToClone is TTranslinebase then
      //TTranslinebase(Sender.ObjInstanceToClone).CalcLineTotals;
      TTranslinebase(Sender.ObjInstanceToClone).CalculateLinetotalsfromPrice;

  End;
End;

Function TTransBase.TranslineFilter(Const AddfilterforroundProduct: Boolean = True): String;
Begin
  REsult := 'Deleted <> ' + QuotedStr('T');
  if self is TSales then
    if Appenv.CompanyPrefs.ShowRelatedProductsinSales = False then
      REsult := Result +' and IsRelatedProduct <> ' + QuotedStr('T');
  (* if AddfilterforroundProduct then
    result:= result +' and ' +  RroundProductfilter; *)
End;

class function TTransBase.TransTotalBalance(TransId: integer;
  Conn: TCustomMyConnection): double;
var
  qry: TERPQuery;
begin
  if Assigned(Conn) then
    qry := DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Text := 'Select Balance from ' + self.GetBusObjectTablename + ' where ' + self.GetIDField + ' = ' + IntToStr(TransId);
    qry.Open;
    result := qry.FieldByName('Balance').AsFloat;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

Function TTransBase.RroundProductfilter: String;
Begin
  Result                                                       := '';
  If Lines.Dataset.Findfield('Productname') <> Nil Then Result := ' Productname <> ' + Quotedstr(PART_ROUNDING);

End;

Procedure TTransBase.MakeSoBO(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TSalesorderLine) Then Exit;
  TSalesorderLine(Sender).QtyShipped      := 0;
  TSalesorderLine(Sender).UOmqtyshipped   := 0;
  TSalesorderLine(Sender).QtyBackOrder    := TSalesorderLine(Sender).Qtysold;
  TSalesorderLine(Sender).UOMQtyBackOrder := TSalesorderLine(Sender).UOMQtySold;
  Sender.PostDb;
End;

function TTransBase.AnyApproved: Boolean;
var
  Qry :TERPQuery;
begin
  result := False;
  if not AppEnv.CompanyPrefs.UseApprovalLevels then exit;
  if Approvaltype = '' then exit;
    Qry :=GetSharedDataSet('SELECT count(*) as ctr '+
                           ' FROM tbltransapprovals TA  '+
                           ' WHERE  TA.TransType = '+Quotedstr(ApprovalType)+
                           ' AND TA.TransID = '+inttostr(ID)+
                           ' AND approved ="T"', true);
    Try
      result :=Qry.Fieldbyname('ctr').asInteger >0;
    finally
      DbSharedObj.ReleaseObj(Qry);
    end;
end;

Procedure TTransBase.AssignSeqNonSortIDnLinesOrder(Const Sender: TBusObj; Var Abort: Boolean);
Var
  DoPost: Boolean;
Begin
  DoPost := False;
  If TTransLineBase(Sender).SeqNo = 0 Then Begin
    TTransLineBase(Sender).SeqNo := ISeqno;
    ISeqno                       := ISeqno + 1;
    DoPost                       := True;
  End
  Else ISeqno := TTransLineBase(Sender).SeqNo;

  If (TTransLineBase(Sender).SortID <= FLastSortId) Then Begin
    TTransLineBase(Sender).SortID := FLastSortId + 10;
    TTransLineBase(Sender).PostDB;
    DoPost := True;
  End;
  FLastSortId := TTransLineBase(Sender).SortID;

  (* if (TTransLineBase(Sender).LinesOrder <= fLastLinesOrder) then begin
    TTransLineBase(Sender).LinesOrder := fLastLinesOrder + 10;
    TTransLineBase(Sender).PostDB;
    DoPost := True;
    end; *)
  //FLastLinesOrder := TTransLineBase(Sender).LinesOrder;

  If DoPost Then TTransLineBase(Sender).PostDB;
End;

Function TTransBase.ValidateData: Boolean;
Begin
  Result := Inherited ValidateData;
  If Not Result Then Exit;
  (* allLinesValid := True;
    Lines.iteraterecords(DeleteemptyLines, true);
    if not allLinesValid then begin
    result := allLinesValid;
    Exit;
    end; *)
  If (Self.Count = 0) Or (Self.Lines.Count = 0) Then Begin
    Deleted := True;
    Postdb;
  End;
  If (GLAccountName <> '') And (GLAccountID = 0) Then Begin
    GLAccountID := TAccount.IDToggle(GLAccountName, Connection.Connection);   // try to get the accountId of the name
    if GLAccountID = 0 then begin
      Result := False;
      AddResult(False, RssWarning, 0, 'AccountID missing for Account: ' + GLAccountName);
      Exit;
    end;
  End;
  If (GLAccountName = '') And (GLAccountID > 0) Then Begin
    GLAccountName := TAccount.IDToggle(GLAccountID, Connection.Connection);
    if GLAccountName = '' then begin
      Result := False;
      AddResult(False, RssWarning, 0, 'Account Name missing for AccountID: ' + IntToStr(GLAccountID)+' in '+ ObjectUserName +' # ' + inttostr(ID)+'.');
      SendEvent(BusobjEvent_ToDo, BusObjEvent_BlankAccount, Self);
      Exit;
    end;
  End;
  If (GLAccountName = '') And (GLAccountID = 0) Then Begin
    result := false;
    AddResult(false, rssWarning, 0, 'Account is missing in '+ ObjectUserName +' # ' + inttostr(ID)+'.');
    SendEvent(BusobjEvent_ToDo, BusObjEvent_BlankAccount, Self);
    exit;
  End;
  if (ClientID > 0) and (not(self is TCashBase) and not(Self is TQuote)) and (not (self Is TCheque)) then begin
    if (Trim(TermsName) = '') then begin
      result := false;
      AddResult(false,rssWarning,0,'Trading Terms is missing in '+ ObjectUserName +' # ' + inttostr(ID)+'.');
      exit;
    end;
    if (TermsName <> Terms.TermsName) then begin
      result := false;
      AddResult(false,rssWarning,0,'Trading Terms ' + Quotedstr(TermsName) + ' for '+ ObjectUserName +' # ' + inttostr(ID)+' can not be found in the Trading Terms List.');
      exit;
    end;
  end;
End;

(* procedure TTransBase.DeleteemptyLines(Const Sender: TBusObj; var Abort: boolean);
  begin
  if not TTransLineBase(Sender).deleted then
  if (TTransLineBase(Sender).QtyShipped = 0) and (TTransLineBase(Sender).QtySold = 0) then begin
  REsultstatus.AddItem(False, rssWarning , 0 , 'Ordered Qty cannot be 0. Please delete the line');
  allLinesValid := False;
  abort := True;
  end;
  end; *)
Procedure TTransBase.Load(Const FIsReadonly: Boolean = False);
Begin
  Progressbarmsg := 'Loading ' + Self.XMLNodename;
  SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
  Inherited;
  If Self.Count = 0 Then Exit;
  If Lines.Dataset.Recordcount = 0 Then Exit;
  ISeqno          := 1;
  FLastSortId     := 0;
  //FLastLinesOrder := 0;
  If (Lines.Count > 1) Then
    If (not FIsReadonly) and (AccessManager.AccessLevel = 1) And (Not(IsLocked)) Then Begin
      Lines.IterateRecords(AssignSeqNonSortIDnLinesOrder);
    End;
  FHasNonInvProducts := Self.LineHasNonInvProduct(Self.ID);
End;

Procedure TTransBase.LoadFromXMLNode(Const Node: IXMLNode);
Var
  LinesNode: IXMLNode;
  X        : Integer;
Begin
  Inherited;
    SetPropertyFromNode(Node, 'Comments');
  If Self Is TSales Then Begin
    LinesNode := Node.ChildNodes.FindNode('Pickslip');
    If Assigned(LinesNode) Then Begin
      If PrintPickSlip.Dataset.RecordCount > 0 Then Begin
        PrintPickSlip.LoadFromXMLNode(LinesNode);
      End;
    End;
  End;

  LinesNode := Node.ChildNodes.FindNode('Print');
  If Assigned(LinesNode) Then Begin
    If Printdoc.Dataset.RecordCount > 0 Then Begin
      Printdoc.LoadFromXMLNode(LinesNode);
    End;
  End;
  { lines importing is handled in the importsubclasses when importing from external file }
  If ImportingFromXMLFile Then Exit;

  { delete existing lines if they exist }
  While Lines.Count > 0 Do Lines.Delete;
  LinesNode := Node.ChildNodes.FindNode(Lines.XMLBranchName);
  If Assigned(LinesNode) Then Begin
    For X := 0 To LinesNode.ChildNodes.Count - 1 Do Begin
      Lines.New;
      Lines.LoadFromXMLNode(LinesNode.ChildNodes[X]);
      Lines.Postdb;
    End;
  End;
End;

Function TTransBase.ImportsubClasses(Const Node: IXMLNode): Boolean;
Var
  X        : Integer;
  Singlerec: IXMLNode;
Begin
  Result          := False;
  ImportFailed    := False;
  XMLPropertyName := Lines.XMLBranchName;
  XMLPropertyNode := Node.ChildNodes.FindNode(XMLPropertyName);
  If Assigned(XMLPropertyNode) Then Begin
    For X                        := 0 To XMLPropertyNode.ChildNodes.Count - 1 Do Begin
      Lines.ImportingFromXMLFile := True;
      Singlerec                  := XMLPropertyNode.ChildNodes[X];
      Lines.ImportFromXML(SingleRec);
      ImportFailed := Lines.ImportFailed;
      If Error Then Exit;
    End;
  End;
  ImportFailed := False;
  Result       := True;
End;

procedure TTransBase.InitAPAccount;
begin
  if clientID >0 then
    GLAccountId := client.DefaultAPAccountID;
  if GLAccountId   = 0  then GLAccountId   := AppEnv.CompanyPrefs.DefaultPurchasesAccount;
  if (GLAccountId <> 0 ) and (GLAccountname <> '') then DofieldOnchange(Dataset.FindField('AccountId'))
  else SendEvent(BusobjEvent_ToDo, BusObjEvent_BlankAccount, Self);

end;

procedure TTransBase.InitARAccount;
begin
  if clientID >0 then begin
    GLAccountId := client.DefaultARAccountID;
    if GLAccountId   = 0  then GLAccountId := client.ClientType.DefaultPostAccountId;
  end;
  if GLAccountId   = 0  then GLAccountId   := AppEnv.CompanyPrefs.DefaultSalesAccount;
  if (GLAccountId <> 0 ) and (GLAccountname <> '') then DofieldOnchange(Dataset.FindField('AccountId'))
  else SendEvent(BusobjEvent_ToDo, BusObjEvent_BlankAccount, Self);
end;

procedure TTransBase.InitPaymentAccount;
begin
  if GLAccountId   = 0  then GLAccountId   := AppEnv.CompanyPrefs.DefaultSuppPaymentAccount
  else DofieldOnchange(Dataset.FindField('AccountId'));
end;

Function TTransBase.DoAfterPost(Sender: TDatasetBusObj): Boolean;
Begin
  Result := Inherited DoAfterPost(Sender);
  If Not Result Then Exit;
  If OriginalDocNumber = '' Then OriginalDocNumber := GlobalRef;
End;

Function TTransBase.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
Begin
  REsult := Inherited DoAfterInsert(Sender);
  If Not Result Then Exit;
  EnteredBy  := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
  EnteredAt  := TimeToStr(Now);
  EmployeeID := AppEnv.Employee.EmployeeID;
  (* if AppEnv.CompanyPrefs.DefaultRepUser then begin
    EmployeeID := AppEnv.Employee.EmployeeID;
    end else begin
    EmployeeID := client.repid;
    end; *)

End;

function TTransBase.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterOpen(Sender);
  if not result then Exit;
  LineInserting := False;
end;

Procedure TTransBase.UpdateInvoiced(Const Sender: TBusObj; Var Abort: Boolean);
Var
  BInvoiced: Boolean;
Begin
  If Not(Sender Is TTransLineBase) Then Exit;
  BInvoiced := TTransLineBase(Sender).QtyShipped <> 0;
  If TTransLineBase(Sender).Invoiced <> BInvoiced Then Begin
    TTransLineBase(Sender).Invoiced := BInvoiced;
    TTransLineBase(Sender).PostDB;
  End;
End;

Procedure TTransBase.Show_Status(Const Value: String);
Begin
  LogD('TTransBase.Show_Status', LbBegin);
  Try
    If Assigned(FShowStatus) Then FShowStatus(Value);
  Finally LogD('', LbEnd);
  End;
End;

Function TTransBase.ExportsubClasses(Const Node: IXMLNode): Boolean;
Begin
  Self.Lines.XMLPropertyNode := Node.AddChild(Lines.XMLBranchName);
  Self.Lines.XMLPropertyName := XMLNodeName + 'Line';
  Self.Lines.IterateRecords(GetPropertyXMLCallback);
  REsult := True;
End;

function TTransBase.getApprovaltype: String;
begin
  REsult := '';
end;

Procedure TTransBase.SaveToXMLNode(Const Node: IXMLNode);
Begin
  Inherited;
  AddXMLNode(node,'Comments',Comments);
  If Printdoc.Dataset.Recordcount > 0 Then Printdoc.SaveToXMLNode(Node.AddChild('Print'));
  If Self Is TSales Then
    If PrintPickSlip.Dataset.Recordcount > 0 Then PrintPickSlip.SaveToXMLNode(Node.AddChild('PickSlip'));
  ExportsubClasses(Node);
End;

Procedure TTransBase.GetLineXMLCallback(Sender: TBusObj; Var Abort: Boolean);
Begin
  Sender.SaveToXMLNode(TempLinesXMLNode.AddChild(Copy(Sender.ClassName, 2, Char_length(Sender.ClassName))));
End;

Function TTransBase.DeleteFlaggedLines: Boolean;
Var
  IsFiltered     : Boolean;
  TempAccessLevel: Integer;
Begin
  Result := True;
  Try
    Lines.Dataset.DisableControls;
    IsFiltered             := Lines.Dataset.Filtered;
    Lines.Dataset.Filtered := False;
    { if this is a new trans allow deleting of lines }
    TempAccessLevel                                    := AccessManager.AccessLevel;
    If Self.CleanID < 1 Then AccessManager.AccessLevel := 1;
    Try
      If Lines.Count > 0 Then Begin
        Lines.First;
        While Not Lines.Dataset.Eof Do Begin
          If Lines.Deleted Then Begin
            // log(Self.Lines.Classname+':' +IntToStr(ID) , LogType_Error);
            If (Lines.IsPQAItem) Or (Lines.HasPQACreated) Then Begin
              If Not Lines.PQA.Delete Then Begin
                Result := False;
                Exit;
              End;
              // log('         PQA:' +IntToStr(Lines.PQA.ID), LogType_Error);
            End;
            DeleteTaxLines;
            ProcessDeletedLine;
            DeletePackWeightLines;
            If Not Lines.Deleted Then Begin // processline undeletes the record
              Result := False;
              Exit;
            End;

            If Not Lines.Delete Then Begin
              Result := False;
              Exit;
            End;
            // log('         Line:' +IntToStr(ID) , LogType_Error);
          End Else Begin
            ProcessLine;
            Lines.Dataset.Next;
          End;
        End;
      End;
    Finally
      Lines.Dataset.Filtered := IsFiltered;
      Lines.Dataset.EnableControls;
      If Self.CleanID < 1 Then AccessManager.AccessLevel := TempAccessLevel;
    End;
  Except
  End;
End;

Function TTransBase.LockTrans(Var ErrMsg: String): Boolean;
Var
  StrSQL     : String;
  FLockFailed: Boolean;
  Qry :TERPQuery;
Begin
  Result := False;
  { Cashsale  and refund doesn't have any back order }
  StrSQL := 'Select ' + IDFieldName + ' as ID, ' + Quotedstr(BusObjectTableName) +' as Tablename from ' + BusObjectTableName +
    ' where (OriginalNo = ' + QuotedStr(Self.OriginalDocNumber) + ')' +' /*all in the group of BOs*/' +NL +
    ' or (GlobalRef = ' + QuotedStr(BackOrderGlobalRef) + ')'         +' /* BO*/'                     +NL +
    ' or (GlobalRef = ' + QuotedStr(GlobalRef) + ')'                  +' /*this trans */'             +NL +
    ' or (GlobalRef = ' + QuotedStr(BaseNo) + ') '                    +'/* base trans*/'              +NL;

  If Self.Classnameis('TSalesOrder') Then
      StrSQL := StrSQL + NL+' or ((SOProgressPaymentOriginalRef   = ' + QuotedStr(Self.OriginalDocNumber) + ') and (SOProgressPaymentOriginalRef  <>""))'+'/* Progress Payments of SO*/' +NL;

  If Self.Classnameis('TInvoice') Then begin
      StrSQL := StrSQL + NL+' or ((OriginalNo              = ' + QuotedStr(TInvoice(Self).SOProgressPaymentOriginalRef) + ') and (OriginalNo <>""))'+'/* Progress payments from SO*/'+NL;
      StrSQL := StrSQL + NL+' or ((Globalref               = ' + QuotedStr(TInvoice(Self).ProgressPaymentInvRef)        + ') and (Globalref <>""))'+'/* Original Inv of Term based progress Payment inv*/'              +NL;
      StrSQL := StrSQL + NL+' or ((OriginalNo             = ' + QuotedStr(TInvoice(Self).ProgressPaymentInvRef)        + ') and (OriginalNo <>""))'+'/* any bo of the Original Inv of Term based progress Payment inv*/'              +NL;
      StrSQL := StrSQL + NL+' or ((ProgressPaymentInvRef   = ' + QuotedStr(TInvoice(Self).Globalref)                    + ') and (ProgressPaymentInvRef <>""))'+'/*Term based Progress payments of this invoice*/'              +NL;
      StrSQL := StrSQL + NL+' or ((ProgressPaymentInvRef   = ' + QuotedStr(TInvoice(Self).ProgressPaymentInvRef)        + ') and (ProgressPaymentInvRef <>""))'+'/*All Term based Progress payments of this invoice*/'              +NL;
  end;
  If Self.Classnameis('TRefundSale') Then
     StrSQL :=StrSQL + ' union Select PurchaseOrderID as ID, ' + Quotedstr('tblpurchaseorders') +' as Tablename from tblpurchaseorders where ifnull(RefundGlobalref , """") = ' +Quotedstr(Globalref) +' and ifnull(RefundGlobalref , """") <> ""';

  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.Connection.Connection);
  Try
    With qry do begin
      qry.sql.text := strSQL;
      qry.open;
      If Recordcount = 0 Then Begin
        Result := True;
        Exit;
      End;

      First;
      FLockFailed := False;
      Try
        While Eof = False Do Begin
          If Not(Userlock.Lock(Fieldbyname('Tablename').asString, FieldByname('ID').AsInteger, LockGroupName)) Then Begin
            { alter the lock message for the locked record
              the locked record can be the current record, any of the BO record, or the parent record }
            If FieldByname('ID').AsInteger = Id Then ErrMsg      := Userlock.LockMessage
            Else If FieldByname('ID').AsInteger > Id Then ErrMsg := ReplaceStr(Userlock.LockMessage, 'this record', 'one of the Back order record of this record')
            Else ErrMsg                                                 := ReplaceStr(Userlock.LockMessage, 'this record', 'one of the parent record of this back order record');

            FLockFailed := True;
          End;
          Next;
        End;
      Finally
        If FLockFailed Then Begin
          First;
          While Eof = False Do Begin
            Userlock.UnLock(Fieldbyname('Tablename').asString, FieldByname('ID').AsInteger, LockGroupName);
            Next;
          End;
        End;
      End;
    End;
  Finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  End;
  If Not FLockFailed Then Result := True;
End;

Function TTransBase.Lock: Boolean;
Var
  ErrMsg: String;
Begin
  ErrMsg := '';
  Result := LockTrans(ErrMsg);;
  If Not Result Then Begin
    Resultstatus.AddItem(False, RssWarning, 0, ErrMsg);
  End;
End;

Function TTransBase.LockRec: Boolean;
Begin
  Result := Userlock.Lock(BusobjectTableName, ID, LockGroupName);
End;
// -----------------------------------------------------------------------------
{ TTransLineBase }
// -----------------------------------------------------------------------------

Constructor TTransLineBase.Create(AOwner: TComponent);
Begin
  Inherited;
  FbCalcQtysoldFromformula := False;
  FbCalcQtyFromformula     := False;
  SQLOrder                 := 'SortID';
  FbIsCreatingBORec        := False;
  FTaxCode                 := Nil;
  ExportExcludeList.Add('searchfilter');
  ExportExcludeList.Add('searchfiltercopy');
  ExportExcludeList.Add('cleanproductname');
  ExportExcludeList.Add('baselineno');
End;

Procedure TTransLineBase.DoFieldOnChange(Sender: TField);
Var
  X: String;
  Msg:String;
Begin

  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If DoFieldChangewhenDisabled = False Then Exit;

  Inherited;
  (* if Sysutils.SameText(Sender.FieldName , 'FormulaQtySoldValue')  then begin
    if FormulaQtySoldValue =0 then FormulaQtySoldValue := 1;
    end; *)
  (* if Sysutils.SameText(Sender.FieldName , 'FormulaQtyShippedValue')  then begin
    if FormulaQtyShippedValue =0 then FormulaQtyShippedValue := 1;
    end; *)

  If Sysutils.SameText(Sender.FieldName, 'FormulaQtySoldValue1') Then
    If FormulaQtyShippedValue1 = 0 Then FormulaQtyShippedValue1 := FormulaQtySoldValue1;
  If Sysutils.SameText(Sender.FieldName, 'FormulaQtySoldValue2') Then
    If FormulaQtyShippedValue2 = 0 Then FormulaQtyShippedValue2 := FormulaQtySoldValue2;
  If Sysutils.SameText(Sender.FieldName, 'FormulaQtySoldValue3') Then
    If FormulaQtyShippedValue3 = 0 Then FormulaQtyShippedValue3 := FormulaQtySoldValue3;
  If Sysutils.SameText(Sender.FieldName, 'FormulaQtySoldValue4') Then
    If FormulaQtyShippedValue4 = 0 Then FormulaQtyShippedValue4 := FormulaQtySoldValue4;
  If Sysutils.SameText(Sender.FieldName, 'FormulaQtySoldValue5') Then
    If FormulaQtyShippedValue5 = 0 Then FormulaQtyShippedValue5 := FormulaQtySoldValue5;

  If Sysutils.SameText(Sender.FieldName, 'FormulaQtySoldValue') Or Sysutils.SameText(Sender.FieldName, 'FormulaQtySoldValue1') Or Sysutils.SameText(Sender.FieldName, 'FormulaQtySoldValue2') Or
    Sysutils.SameText(Sender.FieldName, 'FormulaQtySoldValue3') Or Sysutils.SameText(Sender.FieldName, 'FormulaQtySoldValue4') Or Sysutils.SameText(Sender.FieldName, 'FormulaQtySoldValue5') Then Begin
    If Not Rawmode Then CalcQtysoldFromformula;
  End
  Else If Sysutils.SameText(Sender.FieldName, 'FormulaQtyShippedValue') Or Sysutils.SameText(Sender.FieldName, 'FormulaQtyShippedValue1') Or
    Sysutils.SameText(Sender.FieldName, 'FormulaQtyShippedValue2') Or Sysutils.SameText(Sender.FieldName, 'FormulaQtyShippedValue3') Or Sysutils.SameText(Sender.FieldName, 'FormulaQtyShippedValue4')
    Or Sysutils.SameText(Sender.FieldName, 'FormulaQtyShippedValue5') Then Begin
    If Not Rawmode Then CalcQtyshippedFromformula;
  End
  Else If Sysutils.SameText(Sender.FieldName, 'ProductName') Or Sysutils.SameText(Sender.FieldName, 'ProductId') Then Begin
    If AllowNewRecordWhenLocked And (UOMQtysold = 0) And (ProductID <> 0) Then UOMQtysold := 1;
  End
  Else If Sysutils.SameText(Sender.FieldName, 'Deleted') Then Begin
  End
  Else If Sysutils.SameText(Sender.FieldName, 'PartBarcode') Then Begin
    if PartBarcode <> '' then begin
      If Not RawMode Then Begin
        X := Tcdatautils.GetProductForbarCode(PartBarcode);
        If Sametext(X, 'InactiveProduct') Then Partbarcode := ''
        Else If (Sametext(X, 'Inactivebarcode')) Or (X = '') Then Begin
          SendEvent(BusobjEvent_ToDo, BusObjEvent_PartBarcodeNotfound, Self);
          If Productname <> '' Then DoFieldOnChange(Dataset.Findfield('ProductName'));
        End Else Begin
          ProductName := X;
          DoFieldOnChange(Dataset.Findfield('ProductName'));
          if Product.ProductBarcodes.Dataset.Locate('BarCode',PartBarcode,[loCaseInsensitive]) then begin
            if Product.ProductBarcodes.UnitOfMeasureId > 0 then begin
              UnitOfMeasureID := Product.ProductBarcodes.UnitOfMeasureId;
              if Product.UOMList.LocateByID(UnitOfMeasureID) then begin
                self.UnitOfMeasure := Product.UOMList.UOMName;
                if Assigned(Dataset.FindField('UnitOfMeasureSaleLine')) then
                  DoFieldOnChange(Dataset.Findfield('UnitOfMeasureSaleLines'))
                else if Assigned(Dataset.FindField('UnitOfMeasurePOLines')) then
                  DoFieldOnChange(Dataset.Findfield('UnitOfMeasurePOLines'));
              end;
            end;
          end;
        End;
      End;
    end;
  End
  Else If Sysutils.SameText(Sender.FieldName, 'LineTaxCode') Then Begin
    If Not RawMode Then DochangeTaxcode;
  End
  Else If Sysutils.SameText(Sender.FieldName, 'TotalLineAmountInc') Then Begin
    If Not RawMode Then begin
      DochangeTaxcode;
    end;
  End
  Else If Sysutils.SameText(Sender.FieldName, 'TotalLineAmount') Then Begin
    If Not RawMode Then DochangeTaxcode;
  End
  Else If Sysutils.SameText(Sender.FieldName, 'UnitofMeasureShipped') Then Begin
    SendEvent(BusObjEvent_Change, BusObjEventVal_TransQtyChanged, Self);
  End
  Else If Sysutils.SameText(Sender.FieldName, 'UnitofMeasureQtySold') Then Begin
    SendEvent(BusObjEvent_Change, BusObjEventVal_TransQtyChanged, Self);
  end else if Sysutils.sametext(Sender.fieldname , 'LineTaxRate') then begin
    if LineTaxRate =0 then begin
      If (TransTaxCode.Count > 0) And (TransTaxCode.TaxCode <> LineTaxCode) Then TransTaxCode.Lines.Deleteall;
      if self is TSalesLineBase then
            DoFieldOnChange(Dataset.Findfield('linePrice'))
      else  DoFieldOnChange(Dataset.Findfield('LineCost'));
    end;
(*  end else if Sysutils.sametext(Sender.fieldname , 'LineTax') then begin
        Linecostinc := linecost+Linetaxtotal;
        totalLineamountinc := totalLineAmount+Linetaxtotal;*)
{----}end else if Sysutils.SameText(Sender.FieldName, 'FormulaID') then begin
                  if (formulaId <> 0) then begin
                    Formulaname := TFormula.idtoggle(FormulaID);
                    FormulaQtySoldValue := round(ParserValue(Self , DoGetFormulaFieldValueForSold , getFormula(FormulaID), Msg),5);
                    FormulaQtyShippedValue := round(ParserValue(Self , DoGetFormulaFieldValueForshipped , getFormula(FormulaID), Msg),5);
                    initRelatedProductFormulaDescription;
                  end;
                  SendEvent(BusObjEvent_Change, BusObjEventVal_FormulaValue, self);
{----}end else if Sysutils.SameText(Sender.FieldName, 'FormulaQtySoldValue1') or
                  Sysutils.SameText(Sender.FieldName, 'FormulaQtySoldValue2') or
                  Sysutils.SameText(Sender.FieldName, 'FormulaQtySoldValue3') or
                  Sysutils.SameText(Sender.FieldName, 'FormulaQtySoldValue4') or
                  Sysutils.SameText(Sender.FieldName, 'FormulaQtySoldValue5')  then begin
                  if (formulaId <> 0) then begin
                    FormulaQtySoldValue := round(ParserValue(Self , DoGetFormulaFieldValueForSold , getFormula(FormulaID), Msg),5);
                    initRelatedProductFormulaDescription;
                  end;
                  SendEvent(BusObjEvent_Change, BusObjEventVal_FormulaValue, self);
{----}end else if Sysutils.SameText(Sender.FieldName, 'FormulaQtyShippedValue1') or
                  Sysutils.SameText(Sender.FieldName, 'FormulaQtyShippedValue2') or
                  Sysutils.SameText(Sender.FieldName, 'FormulaQtyShippedValue3') or
                  Sysutils.SameText(Sender.FieldName, 'FormulaQtyShippedValue4') or
                  Sysutils.SameText(Sender.FieldName, 'FormulaQtyShippedValue5')  then begin
                  if (formulaId <> 0) then begin
                    FormulaQtyShippedValue := round(ParserValue(Self , DoGetFormulaFieldValueForshipped , getFormula(FormulaID), Msg),5);
                    initRelatedProductFormulaDescription;
                  end;
                  SendEvent(BusObjEvent_Change, BusObjEventVal_FormulaValue, self);  End;
End;
procedure TTransLineBase.DoGetFormulaFieldValueForSold(Sender: TObject; const VarName: string; var Value: extended; var FieldFound: Boolean);
begin
  FieldFound:= True;
       if SameText(VarName , 'field1') then  Value := FormulaQtySoldValue1
  else if SameText(VarName , 'field2') then  Value := FormulaQtySoldValue2
  else if SameText(VarName , 'field3') then  Value := FormulaQtySoldValue3
  else if SameText(VarName , 'field4') then  Value := FormulaQtySoldValue4
  else if SameText(VarName , 'field5') then  Value := FormulaQtySoldValue5
  else FieldFound:= False;
end;
procedure TTransLineBase.DoGetFormulaFieldValueForshipped(Sender: TObject; const VarName: string; var Value: extended; var FieldFound: Boolean);
begin
  FieldFound:= True;
       if SameText(VarName , 'field1') then  Value := FormulaQtyShippedValue1
  else if SameText(VarName , 'field2') then  Value := FormulaQtyShippedValue2
  else if SameText(VarName , 'field3') then  Value := FormulaQtyShippedValue3
  else if SameText(VarName , 'field4') then  Value := FormulaQtyShippedValue4
  else if SameText(VarName , 'field5') then  Value := FormulaQtyShippedValue5
  else FieldFound:= False;
end;

Procedure TTransLineBase.DoChangeTaxCode;
Begin
  PostDB;
  If Id = 0 Then Exit;
  If (TransTaxCode.Count > 0) And (TransTaxCode.TaxCode <> LineTaxCode) Then TransTaxCode.Lines.Deleteall;
  If HeaderId = 0 Then Exit;
  TransTaxCode.TaxCode := LineTaxCode;
  TransTaxCode.PostDB;
  TransTaxCode.TaxcodeObj.Lines.IterateRecords(PopulateTaxcodeLines);
  CalcTaxcodeTotals;
End;
procedure TTransLineBase.initRelatedProductFormulaDescription;
begin

end;
Procedure TTransLineBase.PopulateTaxcodeLines(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TTaxCodeLines) Then Exit;
  If Not(TransTaxCode.Lines.Locate('SubTaxID', TTaxCodeLines(Sender).SubTaxID, [])) Then Begin
    TransTaxCode.Lines.New;
    TransTaxCode.Lines.SubTaxID     := TTaxCodeLines(Sender).SubTaxID;
    TransTaxCode.Lines.SubTaxCode   := TTaxCodeLines(Sender).SubTaxCode;
    TransTaxCode.Lines.Percentage   := TTaxCodeLines(Sender).Percentage;
    TransTaxCode.Lines.PercentageOn := TTaxCodeLines(Sender).PercentageOn;
    TransTaxCode.Lines.CapAmount    := TTaxCodeLines(Sender).CapAmount;
    TransTaxCode.Lines.AmountPerUnit := TTaxCodeLines(Sender).AmountPerUnit;
    TransTaxCode.Lines.UOM := TTaxCodeLines(Sender).UOM;
    TransTaxCode.Lines.ThresholdAmount := TTaxCodeLines(Sender).ThresholdAmount;
    TransTaxCode.Lines.PostDB;
  End;
End;

Function TTransLineBase.GetAssetAccount: String;
Begin
  Result := GetStringField('AssetAccnt');
End;

Function TTransLineBase.GetBaseLineGlobalRef: String;
Var
  Qry: TERPQuery;
Begin
  If Self.BaseLineNo > 0 Then Begin
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection.Connection);
    Try
      Qry.SQL.Add('select globalref from ' + Self.GetBusObjectTablename);
      Qry.SQL.Add('where ' + Self.GetIDField + ' = ' + IntToStr(Self.BaseLineNo));
      Qry.Open;
      Result := Qry.FieldByName('globalref').AsString;
    Finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    End;
  End
  Else Result := '';
End;

Function TTransLineBase.GetCogsAccount: String;
Begin
  Result := GetStringField('CogsAccnt');
End;

Function TTransLineBase.GetIncomeAccount: String;
Begin
  Result := GetStringField('IncomeAccnt');
End;

Function TTransLineBase.GetLineCost: Double;
Begin
  Result := GetFloatField('LineCost');
End;

Function TTransLineBase.GetLineCostInc: Double;
Begin
  Result := GetFloatField('LineCostInc');
End;

Function TTransLineBase.GetLineDesc: String;
Begin
  Result                                                   := '';
  If Assigned(Owner) And (Owner Is TTransbase) Then Result := TTransbase(Owner).Transname + ' # ' + Inttostr(TTransbase(Owner).ID);
End;

Function TTransLineBase.GetLinedescription: String;
Begin
  REsult := Productname;
End;

function TTransLineBase.getLineInserting: Boolean;
begin
  result := False;
  if Assigned(Owner) then
    if owner is TTransBase then
      result := TTransBase(Owner).LineInserting ;
end;

Function TTransLineBase.GetLineTaxRate: Double;
Begin
  Result := GetFloatField('LineTaxRate');
End;

Function TTransLineBase.GetLineTaxTotal: Double;
Begin
  Result := GetFloatField('LineTax');
End;

Procedure TTransLineBase.ReCalculateLineAmounts;
Var
  SaveDoFieldChange: Boolean;
Begin
  SaveDoFieldChange := DoFieldChange;
  Try
    If DoFieldChange Then DoFieldChange := False;
    TPurchaseOrder(Owner).Lines.CheckAndUpdateProductForeignBuyPrice;
    TPurchaseOrder(Owner).Lines.LineCost := TPurchaseOrderline(TPurchaseOrder(Owner).Lines).CalcBaseLineAmount;
    // TPurchaseOrder(Owner).Lines.LineCostInc := 0;
    TPurchaseOrder(Owner).Lines.LineCostInc := Round(TPurchaseOrder(Owner).Lines.LineCost * (1 + TPurchaseOrder(Owner).Lines.LineTaxRate), RoundPlacesGeneral);
    TPurchaseOrder(Owner).Lines.CalcLineTotals;
  Finally DoFieldChange := SaveDoFieldChange;
  End;
End;

Function TTransLineBase.GetProductDescription: String;
Begin
  Result := GetStringField('Product_Description');
End;

Function TTransLineBase.GetProductGroup: String;
Begin
  Result := GetStringField('ProductGroup');
End;

Function TTransLineBase.GetProductID: Integer;
Begin
  Result := GetIntegerField('ProductId');
End;

Function TTransLineBase.GetProductType: String;
Begin
  Result := GetStringField('PartType');
End;

Function TTransLineBase.GetQtyBackOrder: Double;
Begin
  Result := GetFloatField('BackOrder');
End;

Function TTransLineBase.GetQtyShipped: Double;
Begin
  Result := GetFloatField('Shipped');
End;

Function TTransLineBase.GetQtySold: Double;
Begin
  Result := GetFloatField('QtySold');
End;

Function TTransLineBase.GetLineTaxCode: String;
Begin
  Result := GetStringField('LineTaxCode');
End;

Function TTransLineBase.GetIsvoucher: Boolean;
Begin
  REsult := GetbooleanField('Isvoucher');
End;

Function TTransLineBase.GetVoucherNo: String;
Begin
  Result := GetStringfield('VoucherNo');
End;

Procedure TTransLineBase.SetIsvoucher(Const Value: Boolean);
Begin
  SetBooleanField('Isvoucher', Value);
End;

Procedure TTransLineBase.SetVoucherNo(Const Value: String);
Begin
  SetStringfield('VoucherNo', Value);
End;

Function TTransLineBase.GetTotalLineAmount: Double;
Begin
  Result := GetFloatField('TotalLineAmount');
End;

Function TTransLineBase.GetTotalLineAmountInc: Double;
Begin
  Result := GetFloatField('TotalLineAmountInc');
End;

Function TTransLineBase.GetTransTaxCode: TTransTaxCode;
Begin
  Raise Exception.Create(Self.ClassName + ' - GetTransTaxCode Not Implemented');
End;

function TTransLineBase.GetUOMLineCost: double;
begin
  result := Round(LineCost * UOMMultiplier, RoundPlacesGeneral);
end;

function TTransLineBase.GetUOMLineCostInc: double;
begin
  result := Round(LineCostInc * UOMMultiplier, RoundPlacesGeneral);
end;

Function TTransLineBase.GetUOMMultiplier: Double;
Begin
  Result := GetFloatField('UnitOfMeasureMultiplier');
  // DEFAULT TO 1 !!!!
  If Result = 0 Then Result := 1;
End;

Function TTransLineBase.GetUOMQtyBackOrder: Double;
Begin
  Result := GetFloatField('UnitOfMeasureBackOrder');
End;

Function TTransLineBase.GetUOMQtyShipped: Double;
Begin
  Result := GetFloatField('UnitOfMeasureShipped');
End;

Function TTransLineBase.GetUOMQtySold: Double;
Begin
  Result := GetFloatField('UnitOfMeasureQtySold');
End;

Procedure TTransLineBase.InitUOM(Const UOMName, UOMNameOldValue: String);
Begin
  Inherited;
  If Not RawMode Then Begin
    CalcLineTotals;
    UOMQtySold      := Round(DivZer(QtySold, UOMMultiplier), Self.RoundPlacesGeneral);
    UOMQtyShipped   := Round(DivZer(QtyShipped, UOMMultiplier), Self.RoundPlacesGeneral);
    UOMQtyBackOrder := Round(DivZer(QtyBackOrder, UOMMultiplier), Self.RoundPlacesGeneral);
  End;
End;

Function TTransLineBase.GetForeignTotalLineAmount: Double;
Begin
  Result := GetFloatField('ForeignTotalLineAmount');
End;

Procedure TTransLineBase.SetAssetAccount(Const Value: String);
Begin
  SetStringField('AssetAccnt', Value);
End;

Procedure TTransLineBase.SetCogsAccount(Const Value: String);
Begin
  SetStringField('CogsAccnt', Value);
End;

Procedure TTransLineBase.SetIncomeAccount(Const Value: String);
Begin
  SetStringField('IncomeAccnt', Value);
End;

Procedure TTransLineBase.SetLineCost(Const Value: Double);
Begin
  SetFloatField('LineCost', Value);
End;

Procedure TTransLineBase.SetLineCostInc(Const Value: Double);
Begin
  SetFloatField('LineCostInc', Value);
End;

procedure TTransLineBase.setLineInserting(const Value: Boolean);
begin
  if Assigned(Owner) then
    if owner is TTransBase then
      TTransBase(Owner).LineInserting := Value;
end;

Procedure TTransLineBase.SetLineTaxRate(Const Value: Double);
Begin
  SetFloatField('LineTaxRate', Value);
End;

Procedure TTransLineBase.SetLineTaxTotal(Const Value: Double);
Begin
  SetFloatField('LineTax', Value);
End;

Procedure TTransLineBase.SetProductDescription(Const Value: String);
Begin
  SetStringField('Product_Description', Value);
End;

Procedure TTransLineBase.SetProductGroup(Const Value: String);
Begin
  SetStringField('ProductGroup', Value);
End;

Procedure TTransLineBase.SetProductID(Const Value: Integer);
Begin
  SetIntegerField('ProductId', Value);
End;

Procedure TTransLineBase.SetProductType(Const Value: String);
Begin
  SetStringField('PartType', Value);
End;

Procedure TTransLineBase.SetMatrixDesc(Const Value: String);
Begin
  SetStringField('MatrixDesc', Value);
End;

Procedure TTransLineBase.SetMatrixPrice(Const Value: Double);
Begin
  SetFloatfield('MatrixPrice', Value);
End;

Procedure TTransLineBase.SetMatrixRef(Const Value: String);
Begin
  SetStringField('MatrixRef', Value);
End;

Function TTransLineBase.GetMatrixDesc: String;
Begin
  Result := GetStringfield('MatrixDesc');
End;

Function TTransLineBase.GetMatrixPrice: Double;
Begin
  REsult := GetFloatfield('MatrixPrice');
End;

Function TTransLineBase.GetMatrixRef: String;
Begin
  Result := GetStringfield('MatrixRef');
End;

Procedure TTransLineBase.SetQtyBackOrder(Const Value: Double);
Begin
  SetFloatField('BackOrder', Value);
End;

Procedure TTransLineBase.SetQtyShipped(Const Value: Double);
Begin
  SetFloatField('Shipped', Value);
End;

Procedure TTransLineBase.SetQtySold(Const Value: Double);
Begin
  SetFloatField('QtySold', Value);
End;

Procedure TTransLineBase.SetLineTaxCode(Const Value: String);
Begin
  If Value = LineTaxcode Then Exit;
  SetStringField('LineTaxCode', Value);
  { IJB 6 Nov 2017 - changed as was not not calling DoChangeTaxCode }
  //  If Not RawMode and DoFieldChange Then DoChangeTaxCode;
  If Not RawMode Then
    DoChangeTaxCode;
End;

Procedure TTransLineBase.SetTotalLineAmount(Const Value: Double);
Begin
  If Value = TotalLineAmount Then Exit;
  SetFloatField('TotalLineAmount', Value);
End;

Procedure TTransLineBase.SetTotalLineAmountInc(Const Value: Double);
Begin
  SetFloatField('TotalLineAmountInc', Value);
End;

Procedure TTransLineBase.SetUOMMultiplier(Const Value: Double);
Begin
  SetFloatField('UnitOfMeasureMultiplier', Value);
End;

Procedure TTransLineBase.SetUOMQtyBackOrder(Const Value: Double);
Begin
  SetFloatField('UnitOfMeasureBackOrder', Value);
End;

Procedure TTransLineBase.SetUOMQtyShipped(Const Value: Double);
Begin
    SetFloatField('UnitOfMeasureShipped', Value);
End;

Function TTransLineBase.DoAfterPost(Sender: TDatasetBusObj): Boolean;
Begin
  Result := Inherited DoAfterPost(Sender);
  If Not Result Then Exit;
  If Not Deleted Then
    If Assigned(Self.Owner) Then
      If (Self.Owner Is TTransbase) And (Not SameText(Owner.ClassName, 'TQuote')) Then
        If TTransBase(Self.Owner).Deleted Then Begin
          TTransBase(Self.Owner).Deleted := False;
          TTransBase(Self.Owner).PostDB;
        End;
    if (Linesorder =0) and (deleted =False) and (id>0) then begin
      LinesOrder := fiLinesOrder;

      if (count > 1) and (LineInserting) then begin
        if Dataset.State in [dsEdit,dsInsert] then Dataset.Post;
        RunProc(ResetLinesOrder);
      end;
      LineInserting := False;
    end;
End;
Procedure TTransLineBase.ResetLinesOrder(Sender:TBusObj);
begin
  ReGenerateNumber('LinesOrder' , 10);
end;
Procedure TTransLineBase.OnReGenerateNumber;
begin
  logtext(inttostr(ID)+','+ Productname+',' +inttostr(linesorder));
end;
Procedure TTransLineBase.SetUOMQtySold(Const Value: Double);
Begin
  SetFloatField('UnitOfMeasureQtySold', Value);
End;

Function TTransLineBase.GetInvoiced: Boolean;
Begin
  Result := GetBooleanField('Invoiced');
End;

Function TTransLineBase.GetIsList: Boolean;
Begin
  Result := Inherited;
End;

Procedure TTransLineBase.SetInvoiced(Const Value: Boolean);
Begin
  SetBooleanField('Invoiced', Value);
End;

Procedure TTransLineBase.SetForeignTotalLineAmount(Const Value: Double);
Begin
  SetFloatField('ForeignTotalLineAmount', Value);
End;

Procedure TTransLineBase.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
Begin
  Inherited;
  If Assigned(FTaxCode) Then FreeAndNil(FTaxCode);
  (* Progressbarmsg:= 'Loading '+Self.XMLNodename;
    SendEvent(BusobjEvent_ToDo,BusobjEvent_ProgressbarProgress, self); *)
End;


procedure TTransLineBase.OnProductChanged;
begin

end;

Function TTransLineBase.GetDeleted: Boolean;
Begin
  Result := GetBooleanField('Deleted');
End;

Procedure TTransLineBase.SetDeleted(Const Value: Boolean);
Begin
  SetBooleanField('Deleted', Value);
  If Value And Assigned(Owner) And (Owner Is TTransBase) Then Begin
    TTransBase(Owner).HasNonInvProducts := TTransBase(Owner).LineHasNonInvProduct(TTransBase(Owner).ID);
  End;
End;

Function TTransLineBase.GetSearchFilter: String;
Begin
  Result := GetStringField('SearchFilter');
End;

Function TTransLineBase.GetSearchFilterCopy: String;
Begin
  Result := GetStringField('SearchFilterCopy');
End;

Procedure TTransLineBase.SetSearchFilter(Const Value: String);
Begin
  SetStringField('SearchFilter', Value);
End;

Procedure TTransLineBase.SetSearchFilterCopy(Const Value: String);
Begin
  SetStringField('SearchFilterCopy', Value);
End;

// function TTransLineBase.GetCostCentreId: integer;
// begin
// Result := 0;
// If Dataset.FindField('CostCentreId')<>nil then
// Result := GetIntegerField('CostCentreId');
// end;

// procedure TTransLineBase.SetCostCentreId(const Value: integer);
// begin
// If Dataset.FindField('CostCentreId')<>nil then
// SetIntegerField('CostCentreId', Value);
// end;

Function TTransLineBase.GetProductName: String;
Begin
  Result := GetStringField('ProductName');
End;

Procedure TTransLineBase.SetProductName(Const Value: String);
Begin
  SetStringField('ProductName', Value);
End;

Procedure TTransLineBase.LoadFromXMLNode(Const Node: IXMLNode);
Begin
  Inherited;
  SetPropertyFromNode(Node, 'FormulaQtySoldValue');
  SetPropertyFromNode(Node, 'FormulaQtySoldValue1');
  SetPropertyFromNode(Node, 'FormulaQtySoldValue2');
  SetPropertyFromNode(Node, 'FormulaQtySoldValue3');
  SetPropertyFromNode(Node, 'FormulaQtySoldValue4');
  SetPropertyFromNode(Node, 'FormulaQtySoldValue5');
  SetPropertyFromNode(Node, 'FormulaQtyShippedValue');
  SetPropertyFromNode(Node, 'FormulaQtyShippedValue1');
  SetPropertyFromNode(Node, 'FormulaQtyShippedValue2');
  SetPropertyFromNode(Node, 'FormulaQtyShippedValue3');
  SetPropertyFromNode(Node, 'FormulaQtyShippedValue4');
  SetPropertyFromNode(Node, 'FormulaQtyShippedValue5');
End;

Function TTransLineBase.ValidateData: Boolean;
Begin
  if self.Deleted then begin
    result := true;
    exit;
  end;
  Result := Inherited ValidateData;
  If Not Result Then Exit;
End;

Class Function TTransLineBase.XMLBranchName: String;
Begin
  REsult := 'Lines';
End;

Class Function TTransLineBase._Schema: String;
Begin
  Result := Inherited;
  TBOSchema.AddRefType(Result, 'TAccount', 'IncomeAccountObj', 'IncomeAccount', 'AccountName');
  TBOSchema.AddRefType(Result, 'TAccount', 'AssetAccountObj', 'AssetAccount', 'AccountName');
  TBOSchema.AddRefType(Result, 'TAccount', 'COGSAccountObj', 'COGSAccount', 'AccountName');
  TBOSchema.AddRefType(Result, 'TTaxCode', 'TaxCodeObj', 'LineTaxCode', 'CodeName');
  TBOSchema.AddRefType(result,'TFormula','FormulaObj','FormulaID','ID');

End;

Function TTransLineBase.Save: Boolean;
Begin
  Result := Inherited Save;
  If Result And (Not Deleted) And (ProductId > 0) Then Begin
    Result := GetTransTaxCode.Save;
  End;
End;

Procedure TTransLineBase.SaveToXMLNode(Const Node: IXMLNode);
Begin
  Inherited;
  AddXMLNode(Node, 'FormulaQtySoldValue', FormulaQtySoldValue);
  AddXMLNode(Node, 'FormulaQtySoldValue1', FormulaQtySoldValue1);
  AddXMLNode(Node, 'FormulaQtySoldValue2', FormulaQtySoldValue2);
  AddXMLNode(Node, 'FormulaQtySoldValue3', FormulaQtySoldValue3);
  AddXMLNode(Node, 'FormulaQtySoldValue4', FormulaQtySoldValue4);
  AddXMLNode(Node, 'FormulaQtySoldValue5', FormulaQtySoldValue5);
  AddXMLNode(Node, 'FormulaQtyShippedValue', FormulaQtyShippedValue);
  AddXMLNode(Node, 'FormulaQtyShippedValue1', FormulaQtyShippedValue1);
  AddXMLNode(Node, 'FormulaQtyShippedValue2', FormulaQtyShippedValue2);
  AddXMLNode(Node, 'FormulaQtyShippedValue3', FormulaQtyShippedValue3);
  AddXMLNode(Node, 'FormulaQtyShippedValue4', FormulaQtyShippedValue4);
  AddXMLNode(Node, 'FormulaQtyShippedValue5', FormulaQtyShippedValue5);
  // ExportsubClasses(node);
End;

Function TTransLineBase.ExportsubClasses(Const Node: IXMLNode): Boolean;
Begin
  REsult := True;
  If Not IsPQAItem Then Exit;
  PQA.XMLPropertyNode := Node.AddChild(PQA.XMLBranchName);
  PQA.XMLPropertyName := PQA.XMLNodeName;
  PQA.IterateRecords(GetPropertyXMLCallback);

End;

Procedure TTransLineBase.SetQty(Const Value: Double);
Begin
  Inherited;
  QtyShipped := Value;
End;

Procedure TTransLineBase.SetUOMQty(Const Value: Double);
Begin
  Inherited;
  UOMQtyShipped := Value;
End;

Function TTransLineBase.GetCleanXMLNode: IXMLNode;
Begin
  REsult := Inherited GetCleanXMLNode;
End;

Function TTransLineBase.GetLineNotes: String;
Begin
  Result := GetStringField('LineNotes');
End;

Procedure TTransLineBase.SetLineNotes(Const Value: String);
Begin
  SetStringField('LineNotes', Value);
End;

Function TTransLineBase.GetCleanProductName: STring;
Begin
  Result := GetXMLNodeStringValue(CleanXMLNode, 'ProductNAme');
End;

Function TTransBase.GetCleanTRansTotalAmountInc: Double;
Begin
  Result := GetXMLNodeFloatValue(CleanXMLNode, 'TotalAmountinc');
End;

Function TTransLineBase.GetTaxCode: TTaxCode;
Begin
  If Not Assigned(FTaxCode) Then Begin
    FTaxCode                                              := TTaxCode.Create(Self);
    If Assigned(Self.Connection) Then FTaxCode.Connection := Self.Connection;
  End;
  If FTaxCode.CodeName <> Self.LineTaxCode Then FTaxCode.LoadSelect('Name = ' + QuotedStr(Self.LineTaxCode));
  Result := FTaxCode;
End;

Procedure TTransLineBase.Show_Status(Const Value: String);
Begin
  If Assigned(Self.Owner) Then
    If Self.Owner Is TTransBase Then
      If Assigned(TTransBase(Self.Owner).ShowStatus) Then TTransBase(Self.Owner).ShowStatus(Value);
End;


Function TTransLineBase.GetActive: Boolean;
Begin
  REsult := Not(Deleted);
End;

Function TTransLineBase.GetAllowNewRecordWhenLocked: Boolean;
Begin
  Result := False;
  If Assigned(Owner) Then
    If Owner Is TTransbase Then Result := TTransbase(Owner).AllowNewRecordWhenLocked;

End;

Function TTransLineBase.getAreaCode: String;
Begin
  REsult := GetStringfield('Area');
End;

Function TTransLineBase.GetUOMQty: Double;
Begin
  REsult := UOMQtyShipped;
End;

Function TTransLineBase.GetQty: Double;
Begin
  REsult := QtyShipped;
End;

Function TTransLineBase.GetBOQty: Double;
Begin
  REsult := QtyBackOrder;
End;
Function TTransLineBase.GetBOUOMQty: Double;
Begin
  REsult := UOMQtyBackOrder;
End;

Function TTransLineBase.GetPQAlloation: String;
Begin
  REsult := GetStringfield('PQA');
End;

Procedure TTransLineBase.SetPQAlloation(Const Value: STring);
Begin
  SetStringfield('PQA', Value);
End;

Function TTransLineBase.GetSeqNo: Integer;
Begin
  Result := GetIntegerField('SeqNo');
End;

Procedure TTransLineBase.SetSeqNo(Const Value: Integer);
Begin
  SetIntegerField('SeqNo', Value);
End;

Function TTransLineBase.GetSortID: Integer;
Begin
  Result := GetIntegerField('SortID');
End;

function TTransLineBase.GetStandardCost: double;
begin
  result := GetFloatField('StandardCost');
end;

Function TTransLineBase.GetLinesOrder: Integer;
Begin
  Result := GetIntegerField('LinesOrder');
End;

Procedure TTransLineBase.SetSortID(Const Value: Integer);
Begin
  SetIntegerField('SortID', Value);
End;

procedure TTransLineBase.SetStandardCost(const Value: double);
begin
  SetFloatField('StandardCost', Value);
end;
function TTransLineBase.getCrossStockAdjustTransForinvoice: Boolean;
begin
  Result := False;
  if Assigned(Owner) and (Owner is TTRansbase) then
    REsult := TTRansbase(Owner).CrossStockAdjustTransForinvoice;
end;

Procedure TTransLineBase.SetLinesOrder(Const Value: Integer);
Begin
  SetIntegerField('LinesOrder', Value);
End;

Function TTransLineBase.ProductChanged: Boolean;
Var
  FiProductID  : Integer;
  FsProductName: String;
  FsXML        : STring;
Begin
  Try
    Result := False;
    If (CleanProductId <> ProductId) And (CleanProductId <> 0) Then Begin
      FiProductID      := ProductID;
      FsProductName    := ProductName;;//CleanProductName;
      FsXML            := XmlDoc.XML.Text;
      ProductId        := CleanProductID;
      ProductName      := CleanProductName;//FsProductName;
      Dataset.Filtered := False;
      Deleted          := True;
      If Assigned(Container) Then
        (* Container.DoEvent *) DoContainerEvent(Self, EvSalesLineDeletedChange);
      PostDB;
      Product.Load(ProductID);
      Dataset.Filtered := True;
      Dataset.Insert; // not NEW, Insert to have the record in the same position, New does an append, will add at the end
      Dataset.DisableControls;
      Try
        XML := FsXML;
      Finally
        Dataset.EnableControls;
      End;
      ProductId  := FiProductID;
      ProductName := FsProductName;
      Baselineno := 0;
      OnProductChanged;
      GetProductDetails;
      PostDB;
      //DoFieldOnChange(Dataset.FindField('ProductID'));
      Result := True;
    End;
  Finally LogD('', LbEnd);
  End;
End;

function TTransLineBase.ProductStandardCost: Double;
begin
  REsult := StandardCost;
end;

procedure TTransLineBase.ProgressProcesswithRecno;
begin
  if Assigned(Owner) then
    if owner is TTransbase then
      TTransbase(Owner).ProgressProcesswithRecno(Self);
end;

Procedure TTransLineBase.CopyTransTax;
Begin
  If ObjInstanceToClone Is TTransLineBase Then Begin
    TTransLineBase(ObjInstanceToClone).DochangeTaxcode;
  End;
End;

Procedure TTransLineBase.ClonePropertyObjects;
Begin
  Inherited;
  Copyallocation;
  CopyTransTax;
  CopyformulaDetails;
  { NOTE: self.ObjectInstanceToClone is the new line that has just been created }
  // #IBJ ExtenderList.DoEvent(self,ExEvent_Clone);
  If Self.ObjInstanceToClone Is TSalesline Then begin
    if self.Container.Exists(TSaleslineProctree) then
      TSalesline(Self.ObjInstanceToClone).InstantiateTree(true);
  end;
  (* Container.DoEvent *)
  DoContainerEvent(Self, EvSalesLineClonePropertyObjects, Self.ObjInstanceToClone);
End;

Function TTransLineBase.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
Begin
  Result := Inherited DoAfterInsert(Sender);
  If Not Result Then Exit;
  SeqNo      := FdLastSeqNo + 1;
  SortId     := FiSortID;
  //LinesOrder := FiLinesOrder;
End;

Function TTransLineBase.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
Begin
  Result := Inherited DoBeforeInsert(Sender);
  If Not Result Then Exit;
 (* //FiSortId     := Self.SortID;
  If Assigned(Self.Owner) Then
    If Self.Owner Is TTransbase Then begin
      FiLinesOrder := TTransBase(Owner).GetDetailLastLinesOrder;
      FdLastSeqNo := TTransBase(Owner).GetDetailLastSeqNo;
      FiSortID    := TTransBase(Owner).GetDetailLastSortno;
    end;*)
  FiSortId     := Self.SortID;
  FiLinesOrder := Self.LinesOrder;
  if LineInserting then fiLinesOrder := fiLinesOrder -5 else fiLinesOrder := fiLinesOrder+10;
  If Assigned(Self.Owner) Then
    If Self.Owner Is TTransbase Then FdLastSeqNo := TTransBase(Owner).GetDetailLastSeqNo;

  Result := True;
end;

(*Function TTransBase.GetDetailLastSortno: Integer;
Var
  Qry: TERPQuery;
begin
  Lines.postdb;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection.Connection);
  Try
    Qry.SQL.Add('select max(sortid) as sortid from ' + Lines.GetBusObjectTablename);
    Qry.SQL.Add('where ' + GetIDField + ' = ' + IntToStr(ID));
    Qry.Open;
    Result := Qry.FieldByName('sortid').asInteger;
  Finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  End;
end;*)
(*Function TTransBase.GetDetailLastLinesOrder: Integer;
  Var
  Qry: TERPQuery;
begin
  Lines.postdb;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection.Connection);
  Try
    Qry.SQL.Add('select max(LinesOrder) as LinesOrder from ' + Lines.GetBusObjectTablename);
    Qry.SQL.Add('where ' + GetIDField + ' = ' + IntToStr(ID));
    Qry.Open;
    Result := Qry.FieldByName('LinesOrder').asInteger;
  Finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  End;
end;*)
Function TTransBase.GetDetailLastSeqNo: Integer;
  Var
  Qry: TERPQuery;
begin
  Lines.postdb;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection.Connection);
  Try
    Qry.SQL.Add('select max(seqno) as seqno from ' + Lines.GetBusObjectTablename);
    Qry.SQL.Add('where ' + GetIDField + ' = ' + IntToStr(ID));
    Qry.Open;
    Result := Qry.FieldByName('seqno').asInteger;
  Finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  End;
(*Var
  Bm: TbookMark;
  fbfiltered:boolean;
Begin
  Result := 0;
  fbfiltered:= Self.Lines.Filtered;
  Self.Lines.Filtered := False;
  try
    If Self.Lines.Count > 0 Then Begin
      Self.Lines.PostDB;
      Self.Lines.DataSet.DisableControls;
      Try
        Bm := Self.Lines.DataSet.GetBookMark;
        Try
            Self.Lines.First;
            While Self.Lines.Eof = False Do Begin
              If (Lines.SeqNo <> 0) and not (Lines.Deleted) Then  //  Added check for deleted
                If Lines.SeqNo > Result Then Result := Lines.SeqNo;
              Lines.Next;
            End;
        Finally
          Self.Lines.Dataset.GotoBookMark(Bm);
          Self.Lines.Dataset.FreeBookmark(Bm);
        End;
      Finally Self.Lines.DataSet.EnableControls;
      End;
    End;
  finally
    Self.Lines.Filtered := fbFiltered;
  end;*)
End;

Function TTransBase.QtyShippedForProduct(Const AProductId: Integer): Double;
Var
  Bm: TbookMark;
Begin
  Result := 0;
  If Self.Lines.Count > 0 Then Begin
    Self.Lines.DataSet.DisableControls;
    Try
      Bm := Self.Lines.DataSet.GetBookMark;
      Try
        Lines.First;
        While Not Lines.Eof Do Begin
          If Lines.ProductId = AProductId Then Result := Result + Lines.QtyShipped;
          Lines.Next;
        End;
      Finally
        Lines.Dataset.GotoBookMark(Bm);
        Lines.Dataset.FreeBookmark(Bm);
      End;
    Finally Lines.DataSet.EnableControls;
    End;
  End;
End;

Procedure TTransLineBase.ClonePQA(Const Sender: TBusObj; Var Abort: Boolean);
Begin

End;

Procedure TTransLineBase.SetActive(Const Value: Boolean);
Begin
  Inherited;
  Deleted := Not(Value);
End;

Procedure TTransLineBase.SetAreaCode(Const Value: String);
Begin
  SetStringfield('Area', Value);
End;

Procedure TTransLineBase.SetBOQty(Const Value: Double);
Begin
  Inherited;
  QtyBackOrder := Value;

End;
Procedure TTransLineBase.SetBOUOMQty(Const Value: Double);
Begin
  Inherited;
  UOMQtyBackOrder := Value;

End;

Function TTransLineBase.GetOrderQty: Double;
Begin
  REsult := QtySold;
End;

Procedure TTransLineBase.SetOrderQty(Const Value: Double);
Begin
  Inherited;
  QtySold := Value;
End;

Function TTransLineBase.GetUOMOrderQty: Double;
Begin
  REsult := UOMQtysold;
End;

Procedure TTransLineBase.SetUOMOrderQty(Const Value: Double);
Begin
  Inherited;
  UOMQtysold := Value;
End;

Procedure TTransBase.LineValidateCallbackProc(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  // descendants will override if required;
End;

Function TTransBase.ValidateLines: Boolean;
Begin
  AllLinesValid                     := True;
  Lines.IteraterecordProgressbarMsg := 'Validating';
  Lines.IterateRecords(LineValidateCallbackProc);
  Result := AllLinesValid;
End;

Procedure TTransBase.ShipAll;
var
  fbflag:Boolean;
Begin
  fbflag:= DisableCalcOrderTotals;
  DisableCalcOrderTotals := True;
  try
    Lines.PostDB;
    Lines.IterateRecords(Callbackshipall);
  finally
    DisableCalcOrderTotals := fbflag;
    CalcOrderTotals;
  end;
End;

Procedure TTransBase.Callbackshipall(Const Sender: TBusObj; Var Abort: Boolean);
Var
  FbDoFieldChangewhenDisabled: Boolean;
Begin
  If Not(Sender Is TTransLineBase) Then Exit;
  ProgressprocesswithRecno(Sender);
  FbDoFieldChangewhenDisabled                      := TTransLineBase(Sender).DoFieldChangewhenDisabled;
  TTransLineBase(Sender).DoFieldChangewhenDisabled := True;
  Try
    If TTransLineBase(Sender).UOMQtyBackOrder > 0 Then Begin
      If (Appenv.CompanyPRefs.PartCalcfieldVisible) And (TTransLineBase(Sender).FormulaQtySoldValue <> 0) And
        (TTransLineBase(Sender).FormulaQtySoldValue1 = TTransLineBase(Sender).FormulaQtyshippedValue1) And
        (TTransLineBase(Sender).FormulaQtySoldValue2 = TTransLineBase(Sender).FormulaQtyshippedValue2) And
        (TTransLineBase(Sender).FormulaQtySoldValue3 = TTransLineBase(Sender).FormulaQtyshippedValue3) And
        (TTransLineBase(Sender).FormulaQtySoldValue4 = TTransLineBase(Sender).FormulaQtyshippedValue4) And
        (TTransLineBase(Sender).FormulaQtySoldValue5 = TTransLineBase(Sender).FormulaQtyshippedValue5) Then Begin
        SendEvent(BusobjEvent_Event, BusObjEventVal_ShipAllFormula, Self);
        TTransLineBase(Sender).FormulaQtyShippedValue := TTransLineBase(Sender).FormulaQtySoldValue;
      End Else Begin
        SendEvent(BusobjEvent_Event, BusObjEventVal_ShipAllQty, Self);
        TTransLineBase(Sender).UomQtyShipped := TTransLineBase(Sender).UomQtyShipped + TTransLineBase(Sender).UOMQtyBackOrder;
      End;

      TTransLineBase(Sender).PostDB;
    End;
  Finally TTransLineBase(Sender).DoFieldChangewhenDisabled := FbDoFieldChangewhenDisabled;
  End;
End;

procedure TTransBase.check4MainContact;
begin
  fsDisabledMaincontactName := '';
  try
    if contactId <> 0 then exit;
         if Self is TCashSale         then contactId := Client.MainContactIDforCashSale
    else if Self is TVoucherCashSale  then contactId := Client.MainContactIDforVoucher
    else if Self is TVoucherInvoice   then contactId := Client.MainContactIDforVoucher
    else if Self is TRefundSale       then contactId := Client.MainContactIDforRefund
    else if Self is TInvoice          then contactId := Client.MainContactIDforInvoice
    else if Self is TSalesOrder       then contactId := Client.MainContactIDforSalesOrder
    else if Self is TQuote            then contactId := Client.MainContactIDforQuote
    else if Self is TCheque           then contactId := Client.MainContactIDforCheque
    else if Self is TCredit           then contactId := Client.MainContactIDforCredit
    else if Self is TBill             then contactId := Client.MainContactIDforBill
    else if Self is TPurchaseOrder    then contactId := Client.MainContactIDforPO
    else if Self is TPOS              then contactId := Client.MainContactIDforPOS
    else if Self is TPOSCashSale      then contactId := Client.MainContactIDforPOS
    else if Self is TReturnAuthority  then contactId := Client.MainContactIDforRA;
    if contactId =0 then begin
      contactId := client.PrimarycontactID;
           if Self is TCashSale         then fsDisabledMainContactName := tcdatautils.getcontactNAme(Client.DisabledMainContactIDforCashSale)
      else if Self is TVoucherCashSale  then fsDisabledMainContactName := tcdatautils.getcontactNAme(Client.DisabledMainContactIDforVoucher)
      else if Self is TVoucherInvoice   then fsDisabledMainContactName := tcdatautils.getcontactNAme(Client.DisabledMainContactIDforVoucher)
      else if Self is TRefundSale       then fsDisabledMainContactName := tcdatautils.getcontactNAme(Client.DisabledMainContactIDforRefund)
      else if Self is TInvoice          then fsDisabledMainContactName := tcdatautils.getcontactNAme(Client.DisabledMainContactIDforInvoice)
      else if Self is TSalesOrder       then fsDisabledMainContactName := tcdatautils.getcontactNAme(Client.DisabledMainContactIDforSalesOrder)
      else if Self is TQuote            then fsDisabledMainContactName := tcdatautils.getcontactNAme(Client.DisabledMainContactIDforQuote)
      else if Self is TCheque           then fsDisabledMainContactName := tcdatautils.getcontactNAme(Client.DisabledMainContactIDforCheque)
      else if Self is TCredit           then fsDisabledMainContactName := tcdatautils.getcontactNAme(Client.DisabledMainContactIDforCredit)
      else if Self is TBill             then fsDisabledMainContactName := tcdatautils.getcontactNAme(Client.DisabledMainContactIDforBill)
      else if Self is TPurchaseOrder    then fsDisabledMainContactName := tcdatautils.getcontactNAme(Client.DisabledMainContactIDforPO)
      else if Self is TPOS              then fsDisabledMainContactName := tcdatautils.getcontactNAme(Client.DisabledMainContactIDforPOS)
      else if Self is TPOSCashSale      then fsDisabledMainContactName := tcdatautils.getcontactNAme(Client.DisabledMainContactIDforPOS)
      else if Self is TReturnAuthority  then fsDisabledMainContactName := tcdatautils.getcontactNAme(Client.DisabledMainContactIDforRA);
      SendEvent(BusobjEvent_Event, BusObjEventVal_maincontactDisabled);
  end;
    finally
      fsDisabledMaincontactName := '';
    end;
end;

Function TTransBase.GetBOCount: Integer;
Begin
  FiBOCount := 0;
  Lines.IterateRecords(CallbackBOCount);
  REsult := FiBOCount;
End;

Procedure TTransBase.CallbackBOCount(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TTransLineBase) Then Exit;
  If TTransLineBase(Sender).UOMQtyBackOrder > 0 Then FiBOCount := FiBOCount + 1;
End;

Function TTransBase.GetcontactId: Integer;
Begin
  Result := GetIntegerfield('contactID');
End;
Function TTransBase.GetShipTocontactID: Integer;
Begin
  Result := GetIntegerfield('ShipTocontactID');
End;

Function TTransBase.GetContactMobile: String;
Var
  Contact: TContact;
Begin
  Result := '';
  If Self.ContactId > 0 Then Begin
    Contact := TContact.Create(Nil);
    Try
      Contact.Connection := Self.Connection;
      Contact.Load(Self.ContactID, True);
      Result := Contact.ContactMOB;
    Finally Contact.Free;
    End;
  End;
End;

Function TTransBase.GetcontactName: String;
Begin
  Result := Getstringfield('contactName');
End;

Procedure TTransBase.SetcontactId(Const Value: Integer);
Begin
  SetIntegerfield('contactID', Value);
End;

Procedure TTransBase.SetShipTocontactID(Const Value: Integer);
Begin
  SetIntegerfield('ShipTocontactID', Value);
End;

Procedure TTransBase.SetcontactName(Const Value: String);
Begin
  Setstringfield('contactName', Value);
End;

Procedure TTransBase.SetRepeated(Const Value: Integer);
Begin
  SetIntegerField('RepeatedFrom', Value);
End;

Procedure TTransBase.ProcessDeletedLine;
Begin
  // descendants will override if required
End;

Function TTransBase.LineHasNonInvProduct(IID: Integer): Boolean;
Var
  StrSQL: String;
Begin
  StrSQL := 'Select count(*) as ctr from ' + Lines.BusObjectTableName + ' where  PARTTYPE = "OTHER" ' + ' AND ' + IdFieldName + ' = ' + IntToStr(IID) + ' and Deleted = "F"';
  With GetnewDataset(StrSQL, True) Do
    Try Result := Fieldbyname('ctr').AsInteger <> 0;
    Finally
      If Active Then Close;
      Free;
    End;

End;

Function TTransBase.LineHasInvProduct(IID: Integer): Boolean;
Var
  StrSQL: String;
Begin
  StrSQL := 'Select count(*) as ctr from ' + Lines.BusObjectTableName + ' where  PARTTYPE <> "OTHER" ' + ' AND ' + IdFieldName + ' = ' + IntToStr(IID) + ' and Deleted = "F"';
  With GetnewDataset(StrSQL, True) Do
    Try Result := Fieldbyname('ctr').AsInteger <> 0;
    Finally
      If Active Then Close;
      Free;
    End;

End;

procedure TTransBase.MaxNosofLines(var iLinesID, iLinesOrder, iSortID, iSeqno: Integer);
begin
  With getNewDataset('Select '+
                    ' Max('+Lines.IDFieldName+') as LinesID,  '+
                    ' max(LinesOrder) as LinesOrder , '+
                    ' Max(SortID) as SortID, '+
                    ' Max(Seqno) as Seqno '+
                    ' from ' + Lines.BusObjectTableName+' where '+ IDfieldname +' = ' + inttostr(ID) , true) do try
    iLinesOrder := fieldbyname('LinesOrder').AsInteger;
    iSeqno      := fieldbyname('Seqno').AsInteger;
    iSortID     := fieldbyname('SortID').AsInteger;
    iLinesID    := FieldByname('LinesID').AsInteger;
  finally
    if active then close;
    Free;
  end;
end;

Function TTransBase.LineHasBO: Boolean;
Var
  StrSQL: String;
Begin
  StrSQL := 'Select count(*) as ctr from ' + Lines.BusObjectTableName + ' where  PARTTYPE = "INV" and  ifnull(BackOrder,0) <> 0 ';
  With GetnewDataset(StrSQL, True) Do
    Try Result := Fieldbyname('ctr').AsInteger <> 0;
    Finally
      If Active Then Close;
      Free;
    End;
End;

Procedure TTransBase.DeleteBackOrder(Const BackOrder: TTransBase);
var
  s:String;
Begin
  { this is when a back order record exists and the origanl record is changed
    not to havea  back order. So delete the backorder }
  If (Self.BackOrderGlobalRef <> Self.GlobalRef) And (Self.BackOrderGlobalRef <> '') Then Begin
    BackOrder.Connection := Self.Connection; // this connection expected to be wihtin transaction
    BackOrder.LoadSelect('GlobalRef = ' + QuotedStr(Self.BackOrderGlobalRef));
    BackOrder.UpdatingBo := True;
    If BackOrder.Dataset.REcordcount = 0 Then Exit;
    s:=BackOrder.Lines.filter;
    if BackOrder.Lines.filter <> '' then BackOrder.Lines.filter  := '(' + BackOrder.Lines.filter +') and BaseLineno <>0' else BackOrder.Lines.filter  := 'BaseLineno <>0';
    try
      BackOrder.Lines.filtered := True;
      BackOrder.Lines.IterateREcords(DeleteLineRecord);
    finally
      BackOrder.Lines.filter := s;
      BackOrder.Lines.filtered := BackOrder.Lines.filter <>'';
    end;
    BackOrder.Deleted := BackOrder.Lines.count =0;
    BackOrder.PostDB;
    BackOrder.Save;
    if BackOrder.count >0 then begin
      BackOrder.Deleted := ( BackOrder.Lines.count =0);
      BackOrder.OriginalDocNumber := BackOrder.globalref;
      BackOrder.BaseNo := '';
      BackOrder.PostDB;
    end;
  End;

  Self.BackOrderGlobalRef := '';
  Self.PostDB;
  Self.Lines.IterateREcords(UpdateInvoiced);
End;

Procedure TTransBase.DeleteLineRecord(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TTransLineBase) Then Exit;
  TTransLineBase(Sender).Deleted := True;
  TTransLineBase(Sender).PostDB;
End;

procedure TTransBase.DeletePackWeightLines;
begin
  if Self is TPurchaseOrder then
  begin
    if TPurchaseOrder(self).Lines.PurchaseLinePackWeight <> nil then
      TPurchaseOrder(self).Lines.PurchaseLinePackWeight.DeleteAll;
  end
  else if Self is TSales then
    TSalesLine(TSales(Self).Lines).SalesLinePackWeight.DeleteAll;
end;

Procedure TTransBase.DeleteTaxLines;
Begin
  Lines.TransTaxCode.Delete;
End;

Procedure TTransBase.New;
var
  SavedConn: TCustomMyConnection;
  aNewId: integer;
Begin
  SavedConn := nil;
  try
    if SaveCancelled then begin
      CancelDb;
      SavedConn := self.Connection.Connection;
//      RefreshDb;
      self.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
      self.Dataset.Connection := CommonDbLib.GetSharedMyDacConnection;
    end;

    Inherited;
//  SaveCancelled;
  finally
    if Assigned(SavedConn) then begin
      Cancelled := True;
      PostDb;
      aNewId := ID;
      self.Connection.Connection := SavedConn;
      self.Dataset.Connection := SavedConn;
      Load(aNewId);
      IsNew:= true;
//      OnDataIdChange(dcNew);
      fsOldSQL := '';
      Dirty:= false;
      if assigned(fCleanXMLDoc) then fCleanXMLDoc.ChildNodes.Clear;

      Cancelled := False;
    end;
  end;
End;

function TTransBase.SaveCancelled: boolean;
Begin
  result:= false;
  If (UpdatingBo) And (Count = 0) Then Exit;
  if CrossStockAdjustTransForinvoice then exit;
  result := true;

//  If Connection.InTransaction Then Begin
//    Try
//      Deleted   := True;
//      Cancelled := True;
//      PostDb;
//      Connection.CommitTransaction;
//    Finally
//      Connection.BeginTransaction;
//      Deleted   := False;
//      Cancelled := False;
//    End;
//  End;
End;

Function TTransBase.SaveGuiValidate: Boolean;
Begin
  Try
    FbSaveGUIValidate := True;
    SendEvent(BusobjEvent_ToDo, BusObjEventVal_SaveValidate);
  Finally REsult := FbSaveGUIValidate;
  End;
End;

Procedure TTransBase.NewBOInit(BackOrder: TTransBase);
Begin
  // descendants will overrride if necessary
End;

Procedure TTransBase.ReadBO(BackOrder: TTransBase; Const IsCombinedBo: Boolean; Var CombinedTransRef: String);
Var
  Node   : IXMLNode;
  AXMLDoc: IXMLDocument;
Begin
  AXMLDoc := TXMLDocument.Create(Nil);
  Try
    Node                 := Nil;
    BackOrder.UpdatingBo := True;
    If (BackOrderGlobalRef <> '') Then Begin
      BackOrder.LoadSelect('GlobalRef = ' + QuotedStr(BackOrderGlobalRef));
    End
    Else If IsCombinedBo And (CombinedTransRef <> '') And (NOT(CombinedTransRef = Self.Globalref)) And (Not POBackOrderIsInvoiced(CombinedTransRef)) And
      (Self.SilentMode Or ((Not Self.SilentMode) And (CommonLib.MessageDlgXP_Vista('Do you wish to use the existing combined back order for this ' + #13 + #10 + 'Supplier?', MtInformation,
      [MbYes, MbNo], 0) = MrYes))) Then Begin
      BackOrder.LoadSelect('GlobalRef = ' + QuotedStr(CombinedTransRef));
    End Else Begin
      AXMLDoc.LoadFromXML(Self.XML);
      AXMLDoc.Active                                              := True;
      If AXMLDoc.ChildNodes.FindNode(XMLDocRoot) <> Nil Then Node := AXMLDoc.ChildNodes.FindNode(XMLDocRoot);
      If Node = Nil Then Begin
        If AXMLDoc.ChildNodes.FindNode(XMLDocRequest) <> Nil Then Node := AXMLDoc.ChildNodes.FindNode(XMLDocRequest);
      End
      Else If Node.ChildNodes.FindNode(XMLDocRequest) <> Nil Then Node := Node.ChildNodes.FindNode(XMLDocRequest);
      If Node = Nil Then Node                                          := AXMLDoc.ChildNodes.FindNode(XMLNodeName)
      Else Node                                                        := Node.ChildNodes.FindNode(XMLNodeName);

      { remove lines from xml, we only want to copy header }
      If Assigned(Node) Then Node.ChildNodes.Delete('Lines');
      BackOrder.New;
      BackOrder.XML       := AXMLDoc.XML.Text;
      BackOrder.BaseNo    := Self.GlobalREf;
      BackOrder.DocNumber := IntToStr(BackOrder.Id);
      BackOrder.BaseNo    := Self.GlobalREf;
      NewBOinit(BackOrder);
      sleep(MilliSeconds(1));
      Self.BackOrderGlobalRef := BackOrder.GlobalRef;
      Self.Postdb;
      CombinedTransRef := BackOrder.GlobalRef;
    End;
    If IsCombinedBo Then Begin
      BackOrder.BaseNo        := 'Combined-Bo';
      Self.BackOrderGlobalRef := CombinedTransRef;
      If Self.Dataset.State In [DsEdit, DsInsert] Then Self.PostDB;
      BackOrder.PostDB;
    End;
  Finally
    // aXMLDoc.Free;
  End;
End;

procedure TTransBase.Recalculateall;
var
  fiAccesslevel:Integer;
begin
    executeSQL(
              'create table if not exists erpfix_'+trim(BusobjectTablename)      +replacestr(AppEnv.AppDb.TableVersion,'.','')+' like '+trim(BusobjectTablename)+';'+
              'create table if not exists erpfix_'+trim(Lines.BusobjectTablename)+replacestr(AppEnv.AppDb.TableVersion,'.','')+' like '+trim(Lines.BusobjectTablename)+';'+

              'insert ignore into erpfix_'+trim(BusobjectTablename)      +replacestr(AppEnv.AppDb.TableVersion,'.','')+' select * from  '+trim(BusobjectTablename)+';'+
              'insert ignore into erpfix_'+trim(Lines.BusobjectTablename)+replacestr(AppEnv.AppDb.TableVersion,'.','')+' select * from  '+trim(Lines.BusobjectTablename)+';');
    fiAccesslevel := Accessmanager.accesslevel;
    AccessManager.accessLevel := 1;
    try
    CalcAllLineTotals;
    CalcOrderTotals;
    finally
      AccessManager.accessLevel :=fiAccesslevel;
    end;
end;

Procedure TTransBase.AfterBODeleteCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TTransLineBase) Then Exit;
  If (Self Is TPurchaseOrder) Or (Self Is TInvoice) Or ((Self Is TSalesOrder) And (TSalesOrder(Self).Converted = False)) Then
    If TTransLineBase(Sender).IsPQAItem Then
      If BackorderGlobalref = '' Then Begin
        TTransLineBase(Sender).PQA.Active := True;
        TTransLineBase(Sender).PQA.PostDB;
      End;
End;

(*procedure TTransBase.UnApproveTrans;
var
  sct :TERPScript;
begin
  if not AppEnv.CompanyPrefs.UseApprovalLevels then exit;
  if Approvaltype = '' then exit;
    sct :=getSharedScript('update  tbltransapprovals TA Set Approved ="F" WHERE  TA.TransType = '+Quotedstr(ApprovalType)+' AND TA.TransID = '+inttostr(ID)+' AND approved ="T"', true);
    Try
      sct.Execute;
    finally
      DbSharedObj.ReleaseObj(sct);
    end;

end;*)

Procedure TTransBase.UpdateBO(BackOrder: TTransBase);
Var
  BOLinefound    : Boolean;
  FSeqno, FsortId: Integer;
  FLinesOrder    : Integer;
Begin
  Self.Lines.Dataset.DisableControls;
  Lines.Dataset.Filtered := False;
  Try
    Lines.Dataset.First;
    While Not Lines.Dataset.Eof Do Begin
      Show_Status('Back Orders: ' + IntToStr(Self.Lines.Dataset.Recno) + ' of ' + IntToStr(Self.Lines.Dataset.Recordcount));
      BOLinefound := False;
      FSeqno      := Lines.SeqNo;
      If (Lines.CleanProductName = '') And (Not Lines.Deleted) And (Lines.QtyBackOrder <> 0) Then Begin
        If BackOrder.Lines.Dataset.Locate('SeqNo;ProductID', Vararrayof([TTransLineBase(Lines).SeqNo, Lines.ProductID]), []) Then Begin
          BOLinefound := True;
        End Else Begin
          BackOrder.Lines.New;
          BackOrder.Lines.SortID     := Lines.SortID;
          BackOrder.Lines.LinesOrder := Lines.LinesOrder;
          BOLinefound                := True;
        End;
      End Else Begin
        If BackOrder.Lines.Dataset.Locate('SeqNo;ProductID', Vararrayof([TTransLineBase(Lines).SeqNo, Lines.ProductID]), []) Then Begin
          BOLinefound := True;
        End Else Begin
          If (Not Lines.Deleted) And (Lines.QtyBackOrder <> 0) Then Begin
            BackOrder.Lines.New;
            BackOrder.Lines.SortID     := Lines.SortID;
            BackOrder.Lines.LinesOrder := Lines.LinesOrder;
            BOLinefound                := True;
          End;
        End;
      End;
      If BOLinefound Then Begin
        BackOrder.Lines.pqa.Delete;
        BeforeupdateBOLine(BackOrder);

        (* if Lines.Deleted then begin
          if BackOrder.Lines.QtyShipped = 0 then begin
          BackOrder.Lines.Deleted := true;
          BackOrder.Lines.PostDB;
          end else begin
          BackOrder.Lines.uomQtySold:= BackOrder.Lines.uomQtySold - Lines.uomQtyBackOrder;
          if BackOrder.Lines.uomQtySold <BackOrder.Lines.uomQtyShipped then BackOrder.Lines.uomQtySold := BackOrder.Lines.uomQtyShipped;
          BackOrder.Lines.uomQtyBackOrder := BackOrder.Lines.uomQtySold - BackOrder.Lines.uomQtyShipped;
          BackOrder.Lines.PostDB;
          end;
          end else *)
        if (BackOrder.Lines.Qtysold <> 0) and (Lines.QtyShipped<>0) then begin
          //if a transaction with an existing BO changed by increasing the Qty
        end;
        If BackOrder.Lines.QtyShipped = 0 Then Begin
          BackOrder.Lines.IsCreatingBORec := True;
          FsortId                         := BackOrder.Lines.SortID;
          FLinesOrder                     := BackOrder.Lines.LinesOrder;
          BackOrder.Lines.XML             := Lines.XML;
          BackOrder.Lines.SortID          := FsortID;
          BackOrder.Lines.LinesOrder      := FLinesOrder;
          BackOrder.Lines.SeqNo           := FSeqNo;
          BackOrder.Lines.PostDB;
(*          Lines.PQA.copyAllocation(BackOrder.Lines.PQA.ID , False);
          BackOrder.Lines.PQA.CloseAllAllocationObj;*)

          BackOrder.Lines.FormulaQtyShippedValue := 0;
          BackOrder.Lines.FormulaQtysoldValue    := Lines.FormulaQtysoldValue - Lines.FormulaQtyShippedValue;
          BackOrder.Lines.UOMQtyShipped := 0;
          BackOrder.Lines.SerialNumbers := '';
          //
          if BackOrder.Lines is TPurchaseOrderLine then begin
            TPurchaseOrderLine(BackOrder.Lines).UnitLandedCost := 0;
            TPurchaseOrderLine(BackOrder.Lines).TotalOrderLandedCost := 0;
            TPurchaseOrderLine(BackOrder.Lines).TotalLineLandedCostPerc := 0;
          end;
          //
          If BackOrder.Lines.UomQtySold <> Lines.UomQtyBackOrder Then Begin
            BackOrder.Lines.FormulaQtySoldValue     := 0;
            BackOrder.Lines.FormulaQtySoldValue1    := 0;
            BackOrder.Lines.FormulaQtySoldValue2    := 0;
            BackOrder.Lines.FormulaQtySoldValue3    := 0;
            BackOrder.Lines.FormulaQtySoldValue4    := 0;
            BackOrder.Lines.FormulaQtySoldValue5    := 0;
            BackOrder.Lines.FormulaQtyShippedValue1 := 0;
            BackOrder.Lines.FormulaQtyShippedValue2 := 0;
            BackOrder.Lines.FormulaQtyShippedValue3 := 0;
            BackOrder.Lines.FormulaQtyShippedValue4 := 0;
            BackOrder.Lines.FormulaQtyShippedValue5 := 0;
            BackOrder.Lines.UomQtySold              := Lines.UomQtyBackOrder;
          End;


          BOLinesInit(BackOrder);

          If (BackOrder.Lines.QtySold = 0) And (BackOrder.Lines.QtyBackOrder = 0) Then BackOrder.Lines.Deleted := True
          else begin
                Lines.PQA.copyAllocation(BackOrder.Lines.PQA.ID , False);
                BackOrder.Lines.PQA.CloseAllAllocationObj;
          end;
          BackOrder.Lines.Invoiced := false;
          BackOrder.Lines.PostDB;
          If BackOrder.Lines.ISPQAItem Then Begin
            If (Backorder.BackOrderGlobalRef = '') Or (BackOrder.Lines.QtyShipped <> 0) Then BackOrder.Lines.PQA.Active := True;
            BackOrder.Lines.PQA.PostDB;
            BackOrder.Lines.PQA.RemoveShippedAllocationFromBO;{Remove Copied allocation for shipped qty and keep the backorder qty}
            BackOrder.Lines.PQA.PostDB;
          End;
          Lines.Invoiced := True;
          Lines.PostDB;
          If Lines.ISPQAItem Then Begin
            If Lines.Qty = 0 Then Lines.PQA.Active := False
            Else Lines.PQA.Active                  := True;
            Lines.PQA.PostDB;
          End;
        End;
      End;
      Lines.Dataset.Next;
    End;
    Lines.first;
    While Lines.EOf = False do begin
      Lines.PQa.RemoveShippedBOFromAllocation;
      Lines.Next;
    end;
  Finally
    Lines.Dataset.Filtered := True;
    Lines.Dataset.EnableControls;
  End;
  If BackOrder.Lines.Count > 0 Then Begin
    UpdateRelatedIDsInCopiedLines(Self, BackOrder);
    (* BackOrder.CleanXMLDoc.ChildNodes.Clear;
      BackOrder.CleanXMLDoc.LoadFromXML(BackOrder.XML);
      BackOrder.CleanXMLDoc.Active:= true; *)
    if BackOrder is TInvoice then begin
      if (TInvoice(BackOrder).TotalBalance - TInvoice(BackOrder).TotalPrePayments) <= 0 then
        TInvoice(BackOrder).HoldSale := false;
    end
    else if BackOrder is TSalesOrder then begin
      if (TSalesOrder(BackOrder).TotalBalance - TSalesOrder(BackOrder).TotalPrePayments - TSalesOrder(Backorder).TotalProgressPayments) <= 0 then
        TSalesOrder(BackOrder).HoldSale := false;
    end;
    BackOrder.PostDB;
    BackOrder.Save;
  End;
  If BackOrder.Lines.Count = 0 Then Begin
    { no more lines in back order so remove reference to this BO }
    If Self.BackOrderGlobalRef = BackOrder.GlobalRef Then Begin
      Self.BackOrderGlobalRef := '';
      Self.PostDB;
    End;
  End;

End;

procedure TTransBase.UpdateBORefs;
begin
        if Deleted and (Lines.count =0) then begin
            if not(UpdatingBo) and (Baseno <> '') then
              ExecuteSQL('update ' + busobjecttablename +' set BOID = "" where globalref = '+quotedstr(Baseno)+' and Originalno =' +Quotedstr(OriginalDocNumber), true);
            Baseno := '';
            OriginalDocNumber := Globalref;
            PostDB;
        end;
end;

Procedure TTransBase.BeforeupdateBOLine(BackOrder: TTransBase);
Begin
  // descendants will overrride if required
End;

Procedure TTransBase.BOLinesInit(BackOrder: TTransBase);
Begin
  // descendants will override if required
End;

Procedure TTransBase.UpdateRelatedIDsInCopiedLines(DsSource, DsTarget: TTransBase);
Begin
  // descendants will override if necessary
End;

Class Function TTransBase.TotalCalc(Const FsfieldName: String; Const FiTransID: Integer; Const FsIDFieldName: String; Const Fstablename: String; Conn: TCustomMyConnection = Nil): Double;
Var
  StrSQL: String;
Begin
  Result := 0;
  Try
    StrSQL := 'Select Sum(' + FsFieldName + ') as Total ' + ' from  ' + Fstablename + ' where ' + FsIDFieldName + ' = ' + IntToStr(FiTransID);
    With CommonDbLib.TempMyQuery Do
      Try
        If Conn <> Nil Then Connection := Conn;
        SQL.Clear;
        SQL.Add(StrSQL);
        Open;
        Result := FieldByname('Total').AsFloat;
      Finally
        If Active Then Close;
        Free;
      End;
  Except
    On E: Exception Do Begin
      // kill the exception
    End;
  End;
End;

Procedure TTransLineBase.GetProductDetails;
Begin
  If Self.ProductType = 'OTHER' Then Begin
    If Assigned(Owner) And (Owner Is TTransBase) Then TTransBase(Owner).HasNonInvProducts := True;
  End;
  (* if ProductID>0 then begin
    PartCalcformula := Product.PartCalcformula;
    end; *)
End;
Function TTransLineBase.AnyLineBackOrdered: Boolean;
Begin
  FAnyLineBackOrdered := False;
  Self.IterateRecords(AnyLineBackOrdredCallback);
  Result := FAnyLineBackOrdered;
End;

Procedure TTransLineBase.AnyLineBackOrdredCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If TTransLineBase(Sender).QtyBackOrder <> 0 Then Begin
    FAnyLineBackOrdered := True;
    Abort               := True;
  End;
End;

Function TTransLineBase.AnyLineShipped: Boolean;
Begin
  FAnyLineShipped := False;
  Self.IterateRecords(AnyLineShippedCallback);
  Result := FAnyLineShipped;
End;

Procedure TTransLineBase.AnyLineShippedCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If TTransLineBase(Sender).QtyShipped <> 0 Then Begin
    FAnyLineShipped := True;
    Abort           := True;
  End;
End;
Procedure TTransLineBase.CalculateLinetotalsfromPrice;
var
  xDoFieldChange , xDoFieldChangewhenDisabled :Boolean;
begin
  //if self is TExpenseLineBase then exit;
  {this should just calculate the totals, but don't fire the do field on change event}
  xDoFieldChange :=DoFieldChange;
  xDoFieldChangewhenDisabled := DoFieldChangewhenDisabled;
  DoFieldChange:= False; // sets for the default values
  DoFieldChangewhenDisabled := False;
  try
    CalcLineTotals;
    try
      //ShowRec(Id, 'before post');
      PostDB;
    Except
      on E:Exception do begin
        ShowRec(Id, 'Error:' +E.Message);
      end;
    end;
  finally
  DoFieldChange := xDoFieldChange;
  DoFieldChangewhenDisabled := xDoFieldChangewhenDisabled;
  end;
end;

Procedure TTransLineBase.CalcLineTotals;
Begin
  if not (self is TSalesLineBase) then
    CalcTaxcodeTotals;
End;

Procedure TTransLineBase.CalcTaxcodeTotals;
Begin
  If (TransTaxCode.Count > 0) And (TransTaxCode.TotalLineAmount <> Self.TotalLineAmount) Then
    TransTaxCode.TotalLineAmount := Self.TotalLineAmount;
  PostDB;
  If ID > 0 Then begin
    if TransTaxCode.CalcTax then begin
      self.LineTaxTotal := TransTaxCode.TotalTax;
      self.TotalLineAmountInc := TransTaxCode.TotalLineAmountInc;
    end;
  end;
End;

Function TTransBase.Validtocommit: Boolean;
(* var
  strSQL:String;
  hTotinc, htot, ltotinC, ltot:Double; *)
Begin
  Result := True;
  (* PostDB;
    Lines.postdb;
    if (count = 0) then exit;
    //result := False;
    strSQL:= 'SELECT  H.' +IDFieldName + ',H.totalamountInc , H.TotalAmount,'+
    ' ROUND(SUM(IFNULL(L.totalLineAmountInc,0)),' + IntToStr(CurrencyRoundPlaces) +') as linestotalamountInc,' +
    ' ROUND(SUM(IFNULL(L.TotalLineAmount,0)),' + IntToStr(CurrencyRoundPlaces) +') as linesTotalAmount ' +
    ' FROM  ' + BusObjectTableName + ' as H ' +
    ' INNER JOIN ' + Lines.BusObjectTableName +' as L ' +
    ' ON H.' + IDFieldName+'  = L.' +IDFieldName +
    ' WHERE ifnull(L.Deleted, "F" ) = "F" and H.' +IDFieldName + '=' +IntToStr(ID)+
    ' group by H.' +IDFieldName ;
    with getNewDataset(strSQL, true) do try
    hTotinc:=fieldbyname('totalAmountinc').asFloat;
    htot:=fieldbyname('totalAmount').asFloat;
    lTotinc :=fieldbyname('linestotalamountInc').asFloat;
    ltot    :=fieldbyname('linesTotalAmount').asFloat;
    if (hTotinc <> ltotinc) or (htot <> ltot) then begin
    if (abs(hTotinc - ltotinc) > 0.1) or (abs(htot - ltot) > 0.1) then begin
    SendEvent(BusObjEvent_Error , BOR_CommitValidationFailed ,self);
    exit;
    end;
    end ;
    Result := true;
    finally
    if active then close;
    Free;
    end; *)
End;

Class Function TTransBase._Schema: String;
Begin
  Result := Inherited;
  TBOSchema.AddRefType(Result, 'TAccount', 'GLAccount', 'GLAccountName', 'AccountName');
  // TBOSchema.AddRefType(result,'TAccount','GLAccount','GLAccountID','ID');
  // TBOSchema.AddRefType(Result, 'TEmployee', 'emp_1', 'EmployeeID', 'ID');
  TBOSchema.AddRefType(Result, 'TEmployee', 'emp_1', 'EmployeeName', 'EmployeeName');
  TBOSchema.AddRefType(Result, 'TTerms', 'Terms', 'TermsName', 'TermsName');
  TBOSchema.AddRefType(Result, 'TEmployee', 'emp_2', 'EnteredBy', 'EmployeeName');
  TBOSchema.AddRefType(Result, 'TCurrency', 'CurrencyObj', 'ForeignExchangeCode', 'Code');
End;

Procedure TTransBase.ProcessLine;
Begin
  // descendants will override if required
End;

Function TTransBase.ProcessPQADetailClasses: STring;
Begin
  SendEvent(BusobjEvent_ToDo, BusobjProcessPQADetailClasses);
End;

Function TTransBase.AvailableRewardPoints(Const CustomerID: Integer; Const SaleDate: TDatetime): Double;
Begin
  Result := Tcdatautils.Availablerewardpoints(CustomerID, SaleDate, Self.Connection.Connection);
End;

Function TTransBase.GetPrintedAt: String;
Begin
  Result := '';
  If Printdoc.Count = 0 Then Exit;
  If TimeOf(Printdoc.PrintDate) = 0 Then Exit;
  Result := FormatDateTime(FormatSettings.ShortTimeFormat, Printdoc.PrintDate);
End;

Function TTransBase.GetPrintedOn: String;
Begin
  Result := '';
  If Printdoc.Count = 0 Then Exit;
  Result := FormatDateTime(FormatSettings.ShortDateformat, Printdoc.PrintDate);

End;

Procedure TTransLineBase.Load(Const FIsReadonly: Boolean = False);
Begin
  Inherited;
  If Assigned(Self.Owner) Then
    If Self.Owner Is Tbusobj Then TBusObj(Self.Owner).Progressbarmsg := 'Loading ' + TBusObj(Self.Owner).XMLNodename + ' Lines';;
  SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
End;

Function TTransBase.DeleteWith0Qty: Boolean;
Begin
  AllLinesValid := True;
  Connection.BeginNestedTransaction;
  Try Lines.IterateRecords(DeleteWith0QtyCallback, True);
  Finally
    If AllLinesValid Then Connection.CommitNestedTransaction
    Else Connection.RollbackNestedTransaction;
  End;
  Result := AllLinesValid;
End;

Procedure TTransBase.DeleteWith0QtyCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TTransLineBase) Then Exit;
  If TTransLineBase(Sender).Deleted Then Exit;
  If (Not TTransLineBase(Sender).IsPQAItem) Then Exit;
  If (AccessManager.Accesslevel = 2) And (CleanID <> 0) Then Exit;
  Try
    If (TTransLineBase(Sender).UOMQty = 0) And (TTransLineBase(Sender).UOMOrderQty = 0) Then Begin
      TTransLineBase(Sender).Deleted := True;
      TTransLineBase(Sender).PostDb;
    End;
  Except
    AllLinesValid := False;
    Abort         := True;
  End;
End;

Function TTransBase.TotalLineAmountInc: Double;
Begin
  FdTotalLineAmountInc := 0;
  Lines.IterateRecords(TotalLineAmountIncCallback);
  Result := FdTotalLineAmountInc;
End;

Procedure TTransBase.TotalLineAmountIncCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Sender Is TTranslinebase Then
    If TTranslinebase(Sender).Deleted = False Then FdTotalLineAmountInc := FdTotalLineAmountInc + TTranslinebase(Sender).TotalLineAmountInc;
End;

Function TTransBase.GetInvoiced: Boolean;
Begin
  Anylinesshipped := False;
  Lines.Iteraterecords(GetInvoicedCallback);
  Result := Anylinesshipped;
End;

Procedure TTransBase.GetInvoicedCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TTransLineBase) Then Exit;
  If TTransLineBase(Sender).QtyShipped <> 0 Then Begin
    Anylinesshipped := True;
    Abort           := True;
  End;
End;

Function TTransBase.IsBOInvoiced: Boolean;
Begin
  Result := False;
End;

Procedure TTransLineBase.AfterCloneBusObj;
Begin
  Inherited;
  ProgressProcesswithRecno;
End;

Procedure TTransBase.ProgressprocesswithRecno(Sender:Tbusobj);
begin
  fsProgressMsg := inttostr(Sender.dataset.recno)+' of ' + inttostr(Sender.dataset.recordcount);
  SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
end;

Procedure TTransBase.DoCalcOrderTotals;
Begin
  if Self is TInvoice and TInvoice(SelF).copyingtoinvoice then begin
    // don't do calc total as it does after copy
  end else  if self is TSalesBase then begin
    If ( Appenv.CompanyPrefs.SaleLinesToDisableCalcs = 0) or
      (Lines.Count <= Appenv.CompanyPrefs.SaleLinesToDisableCalcs)  Then CalcOrderTotals;
  end else  if self is TExpenseBase then begin
    If ( Appenv.CompanyPrefs.ExpenseLinesToDisableCalcs = 0) or
      (Lines.Count <= Appenv.CompanyPrefs.ExpenseLinesToDisableCalcs)  Then CalcOrderTotals;
  end  else if self is TOrderBase then begin
    If ( Appenv.CompanyPrefs.OrderLinesToDisableCalcs = 0) or
      (Lines.Count <= Appenv.CompanyPrefs.OrderLinesToDisableCalcs)  Then CalcOrderTotals;
  end;

//  If ( Appenv.CompanyPrefs.TransLinesToDisableCalcs = 0) or
//    (Lines.Count <= Appenv.CompanyPrefs.TransLinesToDisableCalcs)  Then CalcOrderTotals;
  SendEvent(BusobjEvent_ToDo, BusobjEvent_CalculationsDisabled, Self);
End;

procedure TTransBase.CalcForeignAmount;
begin

end;

Function TTransLineBase.GetPartBarcode: String;
Begin
  Result := GetStringfield('PartBarcode');
End;

Procedure TTransLineBase.SetPartBarcode(Const Value: String);
Begin
  SetStringField('PartBarcode', Value);
End;

Function TTransLineBase.GetBaseLineno: Integer;
Begin
  Result := GetIntegerField('BaseLineno');
End;

Procedure TTransLineBase.SetBaseLineGlobalRef(Const Value: String);
Var
  Qry: TERPQuery;
  ID : Integer;
  S  : String;
Begin
  If Value <> '' Then Begin
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection.Connection);
    Try
      Qry.SQL.Add('select ' + Self.GetIDField + ' from ' + Self.GetBusObjectTablename);
      Qry.SQL.Add('where globalref = ' + QuotedStr(Value));
      Qry.Open;
      ID                        := Qry.FieldByName(Self.GetIDField).AsInteger;
      If ID > 0 Then BaseLineNo := ID
      Else Begin
        { fatal error, raise exception }
        S                                                  := 'Error setting BaseLineGlobalRef value "' + Value + '" for';
        If Assigned(Owner) And (Owner Is TMSBusObj) Then S := S + ' ' + TMSBusObj(Owner).ObjectUserName + ' "' + TMSBusObj(Owner).GlobalRef + '"';
        S                                                  := S + ' line "' + Self.GlobalRef + '", Base Line Number not found.';
        Raise Exception.Create(S);
      End;
    Finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    End;
  End
  Else BaseLineNo := 0;
End;

Procedure TTransLineBase.SetBaseLineno(Const Value: Integer);
Begin
  SetIntegerField('BaseLineno', Value);
End;

Procedure TTransLineBase.CalcQtysoldFromformula;
Var
  Qty   : Double;
  ErrMsg: String;
Begin
  PostDB;
  If ProductId = 0 Then Exit;
  PostDB;
  If QtyCalcFormulaDetails.PartCalcformula = '' Then Exit;
  If FormulaQtysoldValue = 0 Then Exit;
  FbCalcQtyFromformula     := True;
  FbCalcQtysoldFromformula := True;
  Try
    Qty := ProductQtyParseValue(Self, GetCalcQtyFormulaValue, ErrMsg, Self, FormulaQtysoldValue);
    If Qty = 0 Then Exit;

    If Self Is TReturnAuthorityLine Then Begin
      TReturnAuthorityLine(Self).RAQty := Qty;
      DoFieldOnchange(Dataset.Findfield('RAQty'));
    End Else Begin
      UOMQtysold := Qty;
      DoFieldOnchange(Dataset.Findfield('UnitOfMeasureQtySold'));
    End;
  Finally
    FbCalcQtysoldFromformula := False;
    FbCalcQtyFromformula     := False;
  End;
End;

Procedure TTransLineBase.CalcQtyshippedFromformula;
Var
  Qty   : Double;
  ErrMsg: String;
Begin
  PostDB;
  If ProductId = 0 Then Exit;
  Postdb;
  If QtyCalcFormulaDetails.PartCalcformula = '' Then Exit;
  If FormulaQtyshippedValue = 0 Then Exit;
  FbCalcQtyFromformula := True;
  Try
    Qty := ProductQtyParseValue(Self, GetCalcQtyFormulaValue, ErrMsg, Self, FormulaQtyshippedValue);
    If Qty = 0 Then Exit;
    If Self Is TRefundSaleLine Then Begin
      TRefundSaleLine(Self).RefundQty := Qty;
      DoFieldOnchange(Dataset.Findfield('RefundQty'));
    End Else Begin
      UOMQtyShipped := Qty;
      DoFieldOnchange(Dataset.Findfield('UnitOfMeasureShipped'));
    End;
  Finally FbCalcQtyFromformula := False;
  End;
End;

Procedure TTransLineBase.GetCalcQtYformulaValue(Sender: TObject; Const VarName: String; Var Value: Extended; Var FieldFound: Boolean);
Begin
  If FbCalcQtysoldFromformula Then Begin
    If SameText(Varname, 'Field1') Then Begin
      Value      := FormulaQtySoldValue1;
      FieldFound := True;
    End
    Else If SameText(Varname, 'Field2') Then Begin
      Value      := FormulaQtySoldValue2;
      FieldFound := True;
    End
    Else If SameText(Varname, 'Field3') Then Begin
      Value      := FormulaQtySoldValue3;
      FieldFound := True;
    End
    Else If SameText(Varname, 'Field4') Then Begin
      Value      := FormulaQtySoldValue4;
      FieldFound := True;
    End
    Else If SameText(Varname, 'Field5') Then Begin
      Value      := FormulaQtySoldValue5;
      FieldFound := True;
    End;
  End Else Begin
    If SameText(Varname, 'Field1') Then Begin
      Value      := FormulaQtyShippedValue1;
      FieldFound := True;
    End
    Else If SameText(Varname, 'Field2') Then Begin
      Value      := FormulaQtyShippedValue2;
      FieldFound := True;
    End
    Else If SameText(Varname, 'Field3') Then Begin
      Value      := FormulaQtyShippedValue3;
      FieldFound := True;
    End
    Else If SameText(Varname, 'Field4') Then Begin
      Value      := FormulaQtyShippedValue4;
      FieldFound := True;
    End
    Else If SameText(Varname, 'Field5') Then Begin
      Value      := FormulaQtyShippedValue5;
      FieldFound := True;
    End;
  End;
End;

Function TTransLineBase.GetFormulaQtySoldValue: Double;
Begin
  Result := Getfloatfield('FormulaQtySoldValue');
End;

Function TTransLineBase.GetFormulaQtySoldValue1: Double;
Begin
  Result := Getfloatfield('FormulaQtySoldValue1');
End;
function TTransLineBase.GetFormulaID: Integer;begin  Result := GetIntegerField('FormulaID');end;
Function TTransLineBase.getformulaName :String; begin result := GetStringfield('formulaName');end;

Function TTransLineBase.GetFormulaQtySoldValue2: Double;
Begin
  Result := Getfloatfield('FormulaQtySoldValue2');
End;

Function TTransLineBase.GetFormulaQtySoldValue3: Double;
Begin
  Result := Getfloatfield('FormulaQtySoldValue3');
End;

Function TTransLineBase.GetFormulaQtySoldValue4: Double;
Begin
  Result := Getfloatfield('FormulaQtySoldValue4');
End;

Function TTransLineBase.GetFormulaQtySoldValue5: Double;
Begin
  Result := Getfloatfield('FormulaQtySoldValue5');
End;

Function TTransLineBase.GetFormulaQtyShippedValue: Double;
Begin
  Result := Getfloatfield('FormulaQtyShippedValue');
End;

Function TTransLineBase.GetFormulaQtyShippedValue1: Double;
Begin
  Result := Getfloatfield('FormulaQtyShippedValue1');
End;

Function TTransLineBase.GetFormulaQtyShippedValue2: Double;
Begin
  Result := Getfloatfield('FormulaQtyShippedValue2');
End;

Function TTransLineBase.GetFormulaQtyShippedValue3: Double;
Begin
  Result := Getfloatfield('FormulaQtyShippedValue3');
End;

Function TTransLineBase.GetFormulaQtyShippedValue4: Double;
Begin
  Result := Getfloatfield('FormulaQtyShippedValue4');
End;

Function TTransLineBase.GetFormulaQtyShippedValue5: Double;
Begin
  Result := Getfloatfield('FormulaQtyShippedValue5');
End;

Procedure TTransLineBase.SetFormulaQtySoldValue(Const Value: Double);
Begin
  Setfloatfield('FormulaQtySoldValue', Value);
End;
procedure TTransLineBase.SetFormulaID(const Value: Integer);begin  SetIntegerField('FormulaID', Value);end;
procedure TTransLineBase.SetformulaName(const Value: String);begin  SetStringField('formulaName', Value);end;

Procedure TTransLineBase.SetFormulaQtySoldValue1(Const Value: Double);
Begin
  Setfloatfield('FormulaQtySoldValue1', Value);
End;

Procedure TTransLineBase.SetFormulaQtySoldValue2(Const Value: Double);
Begin
  Setfloatfield('FormulaQtySoldValue2', Value);
End;

Procedure TTransLineBase.SetFormulaQtySoldValue3(Const Value: Double);
Begin
  Setfloatfield('FormulaQtySoldValue3', Value);
End;

Procedure TTransLineBase.SetFormulaQtySoldValue4(Const Value: Double);
Begin
  Setfloatfield('FormulaQtySoldValue4', Value);
End;

Procedure TTransLineBase.SetFormulaQtySoldValue5(Const Value: Double);
Begin
  Setfloatfield('FormulaQtySoldValue5', Value);
End;

Procedure TTransLineBase.SetFormulaQtyShippedValue(Const Value: Double);
Begin
  Setfloatfield('FormulaQtyShippedValue', Value);
End;

Procedure TTransLineBase.SetFormulaQtyShippedValue1(Const Value: Double);
Begin
  Setfloatfield('FormulaQtyShippedValue1', Value);
End;

Procedure TTransLineBase.SetFormulaQtyShippedValue2(Const Value: Double);
Begin
  Setfloatfield('FormulaQtyShippedValue2', Value);
End;

Procedure TTransLineBase.SetFormulaQtyShippedValue3(Const Value: Double);
Begin
  Setfloatfield('FormulaQtyShippedValue3', Value);
End;

Procedure TTransLineBase.SetFormulaQtyShippedValue4(Const Value: Double);
Begin
  Setfloatfield('FormulaQtyShippedValue4', Value);
End;

Procedure TTransLineBase.SetFormulaQtyShippedValue5(Const Value: Double);
Begin
  Setfloatfield('FormulaQtyShippedValue5', Value);
End;

Function TTransLineBase.GetFormulaQtyValue: Double;
Begin
  Result := FormulaQtyShippedValue;
End;

Function TTransLineBase.GetFormulaQtyValue1: Double;
Begin
  Result := FormulaQtyShippedValue1;
End;

Function TTransLineBase.GetFormulaQtyValue2: Double;
Begin
  Result := FormulaQtyShippedValue2;
End;

Function TTransLineBase.GetFormulaQtyValue3: Double;
Begin
  Result := FormulaQtyShippedValue3;
End;

Function TTransLineBase.GetFormulaQtyValue4: Double;
Begin
  Result := FormulaQtyShippedValue4;
End;

Function TTransLineBase.GetFormulaQtyValue5: Double;
Begin
  Result := FormulaQtyShippedValue5;
End;

Procedure TTransLineBase.SetFormulaQtyValue(Const Value: Double);
Begin
  FormulaQtyShippedValue := Value;
End;

Procedure TTransLineBase.SetFormulaQtyValue1(Const Value: Double);
Begin
  FormulaQtyShippedValue1 := Value;
End;

Procedure TTransLineBase.SetFormulaQtyValue2(Const Value: Double);
Begin
  FormulaQtyShippedValue2 := Value;
End;

Procedure TTransLineBase.SetFormulaQtyValue3(Const Value: Double);
Begin
  FormulaQtyShippedValue3 := Value;
End;

Procedure TTransLineBase.SetFormulaQtyValue4(Const Value: Double);
Begin
  FormulaQtyShippedValue4 := Value;
End;

Procedure TTransLineBase.SetFormulaQtyValue5(Const Value: Double);
Begin
  FormulaQtyShippedValue5 := Value;
End;
function TTransLineBase.updatingBO: boolean;
begin
  result:= False;
  if Assigned(Owner) then
    if Owner is TTransBase then
      result:= TTransBase(Owner).UpdatingBo;
end;
procedure TTransLineBase.CalcLineForeingAmount;
begin

end;
    {TPackWeightLinesBase}

constructor TPackWeightLinesBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;


procedure TPackWeightLinesBase.DeleteFlaggedLines;
begin
  dataset.DisableControls;
  try
      If Count > 0 Then Begin
        dataset.Filtered := False;
        try
          First;
          While Not Dataset.Eof Do Begin
            if Deleted then begin
              delete;
            end else begin
              Next;
            end;
          End;
        finally
          dataset.filtered := dataset.filter<>'';
        end;
      End;
  finally
    Dataset.EnableControls;
  end;
end;

destructor TPackWeightLinesBase.Destroy;
begin
  inherited;
end;


procedure TPackWeightLinesBase.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TransLineID');
  SetPropertyFromNode(node,'PackCount');
  SetPropertyFromNode(node,'AttribValue1');
  SetPropertyFromNode(node,'AttribValue2');
  SetBooleanPropertyFromNode(node,'Deleted');
end;


procedure TPackWeightLinesBase.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TransLineID' ,TransLineID);
  AddXMLNode(node,'PackCount' ,PackCount);
  AddXMLNode(node,'AttribValue1' ,AttribValue1);
  AddXMLNode(node,'AttribValue2' ,AttribValue2);
  AddXMLNode(node,'Deleted' ,Deleted);
end;


function TPackWeightLinesBase.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  AllLinesValid := true;
  IterateRecords(ValidateCallback);
  Result := AllLinesValid ;
end;
Procedure TPackWeightLinesBase.ValidateCallback(Const Sender: TBusObj; Var Abort: Boolean);
begin
  if (not(Sender is TPackWeightLinesBase)) then exit;
  if TPackWeightLinesBase(Sender).TransLineID = 0 then begin
    TPackWeightLinesBase(Sender).Resultstatus.AddItem(False , rssError , 0,  'LineID should not be 0' , False );
    AllLinesValid:= False;
    Abort := True;
    Exit;
  end;
end;
function TPackWeightLinesBase.Save: Boolean ;
begin
  Result := False;
  DeleteFlaggedLines;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPackWeightLinesBase.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TPackWeightLinesBase.DoFieldOnChange(Sender: TField);
begin
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If DoFieldChangewhenDisabled = False Then Exit;

  Inherited;
  if not(sametext(Sender.fieldname ,'PackCount') ) then
    if PackCount =0 then PackCount := 1;

  if sametext(Sender.fieldname ,'PackCount') or
    sametext(Sender.fieldname ,'AttribValue1' ) or
    sametext(Sender.fieldname ,'AttribValue2' )   then begin
    if (Deleted) or  ((AttribValue1<>0) or (AttribValue2<>0)) then PostDB;
  end;

  end;


function TPackWeightLinesBase.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TPackWeightLinesBase.getTotalAttribValue1: double  ; begin Result := GetTotal(1); end;
function TPackWeightLinesBase.getTotalAttribValue2: double  ; begin Result := GetTotal(2); end;
function TPackWeightLinesBase.getTotalPackCount   : Integer ; begin Result := trunc(GetTotal(3)); end;

Function TPackWeightLinesBase.GetTotal(Fieldno:Integer):Double;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(connection.Connection);
  try
    qry.SQL.text :=' Select  sum(Packcount*AttribValue1) AttribValue1  ,  sum(Packcount*AttribValue2) AttribValue2 ,  sum(Packcount) Packcount  '+
              ' from ' +  GetBusObjectTablename + ' where ' + TranslineIDField +' =' + inttostr(TranslineID)+' and Deleted ="F"';
    qry.Open;
         if Fieldno =1 then REsult := qry.fieldbyname('AttribValue1').asFloat
    else if Fieldno =2 then REsult := qry.fieldbyname('AttribValue2').asFloat
    else if Fieldno =3 then REsult := qry.fieldbyname('Packcount').asfloat
    else Result := 0;

  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;



class function TPackWeightLinesBase.GetIDField: string;
begin
  Result := 'ID'
end;




function TPackWeightLinesBase.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not(result) then exit;
  Deleted := False;
  if Assigned(Owner) then
    if owner is TPurchaseOrderline then
      TransLineID := TPurchaseOrderline(Owner).ID
    else if owner is TSalesline then
      TransLineID := TSalesline(Owner).ID;

end;

function TPackWeightLinesBase.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterOpen(Sender);
  if not(Result) then exit;
  if self is TSalesLinePackWeightLinesSum then exit;
  if self is TPurchaseLinePackWeightLinesSum then exit;
  Dataset.Filter :='Deleted =' +quotedstr('F');
  Dataset.Filtered := TRue;
end;

function TPackWeightLinesBase.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


function TPackWeightLinesBase.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(sender);
  if not(Result) then exit;
  if (AttribValue1 =0) and (AttribValue2 =0) then deleted := TRue;
end;

{Property Functions}
function  TPackWeightLinesBase.GetPackCount       : Integer   ; begin Result := GetIntegerField('PackCount');end;
function  TPackWeightLinesBase.GetAttribValue1    : Double    ; begin Result := GetFloatField('AttribValue1');end;
function  TPackWeightLinesBase.GetAttribValue2    : Double    ; begin Result := GetFloatField('AttribValue2');end;
Function  TPackWeightLinesBase.GetDeleted         : Boolean   ; begin Result := getBooleanfield('Deleted'); end;
function TPackWeightLinesBase.GetTransLineID      : Integer;begin  result := getIntegerField(TranslineIDField);end;
procedure TPackWeightLinesBase.SetPackCount       (const Value: Integer   ); begin SetIntegerField('PackCount'        , Value);end;
procedure TPackWeightLinesBase.SetTransLineID     (const Value: Integer);begin  SetIntegerField(TranslineIDField , Value);end;
procedure TPackWeightLinesBase.SetAttribValue1    (const Value: Double    ); begin SetFloatField('AttribValue1'     , Value);end;
procedure TPackWeightLinesBase.SetAttribValue2    (const Value: Double    ); begin SetFloatField('AttribValue2'     , Value);end;
procedure TPackWeightLinesBase.SetDeleted         (Const Value: Boolean   ); begin SetBooleanfield('Deleted'        , Value); end;
End.
