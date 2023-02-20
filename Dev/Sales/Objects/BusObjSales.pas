Unit BusObjSales;

{

  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  27/05/05  1.00.00 IJB  Initial version.

  TSales(TSalesBase)
  |-- TInvoice
  |------TInvoiceBackOrder
  |------TInvoiceNonBackOrder
  |-- TQuoteBase
  |--Tquote
  |-- TSalesOrder
  |------TSalesOrderBackOrder
  |------TSalesOrderNonBackOrder

  TSalesLine(TSalesLineBase)
  |-- TInvoiceLine
  |-- TQuoteLine
  |-- TSalesOrderLine

  12/12/05  1.00.01 BJ   Save checks for the bin-batch allocation and takes a confirmation
  to Save the record if  not allocated.
  04/01/06  1.00.02 IJB  Added initialisation of variables to TSales.New
  (some fields not refreshing when user cliks New on
  quote form)
  05/01/06  1.00.04 IJB  Added code to SaleBase to check for unique
  Customer PO Number using new TSaleList object.
  03/01/06  1.00.05 IJB  Modified so Back Orders have correct Document Number
  (was picking up original document number).
  16/01/06  1.00.06 ISB  Modified so PopulateClientData To Physical Address In Ship to Not Billing Address
  And Set Quote Product Qty Default = 1
  25/01/06  1.00.07 BJ   GetBaseLinePrice:ClientDiscountObj.ClientPrice_Discounts - "Qty sold" is passed
  into this function instead of the UOMQty, this qty is compared with the
  sellQty1, seelQty2 and SellQty3 to get the price (from price1 or price2 or price3)
  25/01/06  1.00.08 IJB  Modified profit % calcs to correctly handle negative amounts.
  14/03/06  1.00.09 BJ   when a hire contract is invocied, the invocieline will have the PartsId
  of the actual product, but the product name will be 'Hire'
  DoFieldOnChange reassigns the product properties when either the productId or
  Product name is changed. In a hireinvoice product properties should be of
  the 'Hire' product not the actual product's . So a new property is introduced -
  HireItem which will be True for invoicing a hire item and on change of PartsId
  does the product property updation only when this flag = False.
  16/03/06 1.00.10 BJ    DoFieldOnChange is updates the rpoduct properties whent eh productId or productname is
  changed. Module changed to do it only if the value of the field is not blank
  When the data is imported from an XML file, the productId is usually blank
  23/03/06 1.00.11 DSP   1. Added Shipping property to TSales.
  2. Added QuoteStatus and Reference properties to TQuoteBase.
  29/03/06 1.00.12  AL   In PopulateClientData assign ClassID only if it is not already set,
  it was set to default class on every Client.OnCloseUp
  11/04/06 1.00.13  BJ   TotalLineamount and TotalLineamountInc are not rounding the amount.
  21/04/06 1.00.14  DSP  Changed return value for CopyQuoteToQuote, CopyQuoteToInvoice and
  CopyQuoteToSalesOrder from boolean to integer to allow the
  ID to be returned.
  10/05/06 1.00.15  BJ   ConvertSOAllocation : function converts the bin bach allocation to the
  invoice when converted.
  25/05/06 1.00.16  BJ   XML is created on Tsalesbase / Tsalesbaseline
  (same in PO object - to make it easy to search for the field in XML).
  04/07/06 1.00.17  BJ   Sorting the details on the sortId is handled for inserting records in the line
  24/07/06 1.00.18  BJ   Invoice :Customer's credit is checked against the credit limit only when the preference
  is True(AppEnv.CompanyPrefs.CreditCheckInv)
  SalesOrder :Customer's credit is checked against the Credit limit when the preference
  is True(AppEnv.CompanyPrefs.CreditCheckSO) - Sales order was not doing the credit check.
  Cusotmer's current balance is the invoicebalance + salesorder balance
  10/08/06 1.00.19  BJ   1)Converting SO should reduce the SObalance of the client and update the balance
  2)Creditcheck for both SO and invoice should check the client's invoice balance - not
  SO balance, client's SObalance is used for the projects
  14/08/06 1.00.20  BJ   InvBaseNumber of the client is updated [outside transaction] if the client's
  'UseCustomerInvoiceNo' is true
  SalesDate is compared with companypref.closing date
  Introduced the cleanSalesDate to do this check only when the date is changed
  15/08/06 1.00.21 BJ    client object property is outdside transaction. Note: If don;t set the connection
  explicitly, gets the connection of the parent business object (if any)
  21/08/06 1.00.22 BJ    EventList of the busness object stores the Id of the object
  So AddEvent is called with the ID as well.
  RelatedPartQty updation is moved into a separate procedure from the DoFieldOnChange
  Secondly, the bin/batch allocation(of the related product) is called before
  closeup of the combo in the GUI. This causes the form to show the product
  list over the bin/batch form.
  SetDefaultQtyShiped : is called only if
  the line is not relatedproduct and
  not in the eventlist
  and not importing from the XML
  29/08/06 1.00.23 BJ    1. the customer option for 'enforce PO' is applicable only for Sales order
  and invoice , not for Quote
  (Because ponum is not a field in quote - refer to the quote GUI)
  2. Saving the transaction record(invoice/salesorder/Quote) updates the globalref
  30/08/06 1.00.24 BJ    ParentProductId in the salelines used to store the salelineid.
  Its changed to store the parentProductId in this field and introduced a new field
  RelatedParentLineRef which stores the parent saleline's globalref for the parentLine.
  Both these fields are supposed to be blank when the line is NOT A RELATED line
  05/09/06 1.00.25 BJ    Introduced a middle level class for the sales object in BusobjSalebase.
  Both cashsale/refund and invocie/quote/salesorder are the descendants of this middle level class
  08/09/06 1.00.26 BJ    DoFieldOnChange was checking the current field's name using an =
  which is case sensitive, this is changed to using Sametext function
  23/01/07 1.00.27 BJ    Buildrecord creationf or the group products (when stock not available) is added
  lines' qtyOrdered and UOM are locked when Group record already exists.
  Progressbar propery is removed and using the Show_status from the baseobject
  So to invoice:- converts SO allocation used to change teh salesids of the SO's
  allocation with the InvoiceIds.this is changed to leave the SO allocationa s it is with 'SO'
  stock-in-out type and create new records for the invoice allcoation. this
  will allow the 'picking slip' to be printed from both so and invoice even after conversion.
}

Interface

Uses TypesLib,
  BusObjBase, MyAccess, ERPdbComponents, BusObjTrans, BusobjSaleBase, DB, Classes,
  ComCtrls, AdvOfficeStatusBar, XMLDoc, XMLIntf, BusobjSalesShippingDetails,
  BusObjProcess, BusObjSalesLookup, BusobjPQA,BusobjRelatedSales, BusobjUOM,
  BusobjSalesDelDetails, BusobjBOMGroupLines, BusObjManifest, BusObjShipment,
  UserLockObj , BusobjProctree , IntegerListObj, BusObjAttachment,JSONObject;
  { TODO : Walmart - Backorders }
  (*, busobjwalmartorders*)

(* const
  SOApprovedStatus = 'Approved For Invoicing'; *)
Type

  TQuote = Class;
  TSales = Class;

  TSalesLinePackWeightLines = class(TPackWeightLinesBase)
  private
  protected
    function getTranslineIDField:String; Override;
  public
    Constructor Create(AOwner: TComponent);Override;
    class function GetBusObjectTablename: string; Override;
  end;

  TSalesLinePackWeightLinesSum = class(TSalesLinePackWeightLines)
  private
    function getsaleId: Integer;
  protected
  public
    Constructor Create(AOwner: TComponent);Override;
  Published
    Property SaleId :Integer read getsaleId ;
  end;


  TSalesLine = Class(TSalesLineBase)
  Private
    // this 3 flags will not show that message -> "Add This Product To Customers Special Price List ?"
    FbProductIDChanging  : Boolean;
    FbProductNameChanging: Boolean;
    FbNew                : Boolean;

    FChangeQty                          : Double;
    FdQtyAvailableForDiscontinuedProduct: Double;

    Procedure CheckForeignCodeAndRate;
    Function GetCalcProfit: Double;
    Function GetCalcProfitPercent: Double;
    Function GetCalcProfitEx: Double;
    Function GetCalcProfitPercentEx: Double;
    Procedure SetCalcProfit(Const Value: Double);
    Procedure SetCalcProfitPercent(Const Value: Double);
    Procedure SetCalcProfitEx(Const Value: Double);
    Procedure SetCalcProfitPercentEx(Const Value: Double);
    Function GetcopytoCashSale: Boolean;
    Function GetcopytoInvoice: Boolean;
    Function GetcopytoQuote: Boolean;
    Function GetcopytoSalesOrder: Boolean;
    Function GetHeader: Tsales;
    (* Procedure callbackChangeOrderQty(Const Sender: TBusObj; var Abort: Boolean); *)
    Function GetWarrantyEndsOn: TDateTime;
    Function GetWarrantyPeriod: String;
    Function GetCustomerEquipmentID: Integer;
    Function GetEquipment: String;
    Function GetBOMComments: String;
    Procedure SetWarrantyEndsOn(Const Value: TDateTime);
    Procedure SetWarrantyPeriod(Const Value: String);
    Procedure SetCustomerEquipmentID(Const Value: Integer);
    Procedure SetEquipment(Const Value: String);
    Function GetSalesLinesUOMDetails: TTransLinesUOMDetails;
    Function GeTTransLineProductCustomFields: TTransLineProductCustomFields;
    Function CheckForDiscontinuedProduct: Boolean;
    Function GetBOMGroupedLine: Boolean;
    Function GetBOMProductionLine: Boolean;
    Procedure SetBOMGroupedLine(Const Value: Boolean);
    Procedure SetBOMProductionLine(Const Value: Boolean);
    Function CanLockManifest: Boolean;
    Function Getmanifestline: Tmanifestlines;
    Function Delete0QtyshipmentLines: Boolean;
    function getSalesLinePackWeight: TSalesLinePackWeightLines;
    function getSalesLinePackWeightSum: TSalesLinePackWeightLinesSum;
    function getpackweightField1: Double;
    function getpackweightField2: Double;
    function getConvertCurrent: Boolean;
    Procedure SetBOMComments(Const Value: String);
    function ProductHasProcess: Boolean;
    Function GetReferenceNo: String;
    Procedure SetReferenceNo(Const Value: String);
    function GetShipmentSalelines: TShipmentSaleline;
    // Function CustomermainShipAddressID :Integer;
    // Function CustomerName:String;
  Protected
    Procedure SetDefaultQtyShipped; Virtual;
    Procedure DoFieldOnChange(Sender: TField); Override;
    Function GetId: Integer; Override;
    Function GetSQL: String; Override;
    { * Populate sale line with selected product data. }
    Procedure GetProductDetails; Override;
    Procedure InitializeNewObject; Override;
    Procedure CreateInstance; Override;
    Function DoAfterPost(Sender: TDatasetBusObj): Boolean; Override;
    Function DoBeforeInsert(Sender: TDatasetBusObj): Boolean; Override;
    Function DoBeforePost(Sender: TDatasetBusObj): Boolean; Override;
    Function ValidateXMLData(Const Node: IXMLNode): Boolean; Override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
    Function DoNewRecord(Sender: TDatasetBusObj): Boolean; Override;
    Function DoBeforeDelete(Sender: TDatasetBusObj): Boolean; Override;
    Procedure ChangeOrderQty;
    Procedure AfterCloneBusObj; Override;
    Procedure ClonePropertyObjects; Override;
    function ParentProductname: String;
    function ProductDescNameWithRelatedParent: String;
    procedure LogContianerNames;

Public

    Class Function GetIDField: String; Override;
    Class Function GetBusObjectTablename: String; Override;
    Constructor Create(AOwner: TComponent); Override;
    Function HasProcess: Boolean;
    Procedure CalcLineTotals; Override;
    Destructor Destroy; Override;
    Procedure New; Override;
    Procedure LoadFromXMLNode(Const Node: IXMLNode); Override;
    Procedure SaveToXMLNode(Const Node: IXMLNode); Override;
    Procedure CalculateLine;
    Function ValidateData: Boolean; Override;
    Function Save: Boolean; Override;
    Procedure ShipedQtyChanged;
    Function ISoktoShip: Boolean; Virtual;
    Function GetCurrentBackOrderId(Var ErrMsg: String; Var Editable: Boolean; Var SaleLineId: Integer): Integer;
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
    Property CopyingToInvoice: Boolean Read GetcopytoInvoice;
    Property CopyingToCashSale: Boolean Read GetcopytoCashSale;
    Property CopyingToQuote: Boolean Read GetcopytoQuote;
    Property CopyingToSalesOrder: Boolean Read GetcopytoSalesOrder;
    Function CloneBusObj(Const Changefield: String; Const ChangeValue: Variant; Const SaveAfterCopy: Boolean = True; Const FilterFields: String = ''): TBusObj; Override;
    Property Header: Tsales Read GetHeader;
    Procedure CopyPropertyObjects(Const Mappedfields: STring); Override;
    Property SalesLinesUOMDetails: TTransLinesUOMDetails Read GetSalesLinesUOMDetails;
    Property SaleslineProductCustomFields: TTransLineProductCustomFields Read GeTTransLineProductCustomFields;
    Property QtyAvailableForDiscontinuedProduct: Double Read FdQtyAvailableForDiscontinuedProduct;
    Function ISPartDiscontinuednQtynotEnough: Boolean;
    Function DeletingTomergeOutstandingsale: Boolean;
    Procedure Copyallocation; Override;
    Procedure DoContainerEvent(Const Sender: TObject; Const EventType: Integer; Const Data: TObject = Nil; Proc : TProcBusObjBase= nil); Override;
    Procedure InstantiateTree(CreateIfnotCreated: Boolean = True; Recalccost :Boolean =True);
    Procedure DeleteTree;
    Function IsProgressPayment: Boolean; Virtual;
    Function Tree(Recalccost:Boolean =True): TSaleslineProctree;
    Property Manifestline: Tmanifestlines Read Getmanifestline;
    Property SalesLinePackWeightSum: TSalesLinePackWeightLinesSum read getSalesLinePackWeightSum;
    Property ConvertCurrent :Boolean read getConvertCurrent;
    procedure UpdateLinesRefNo(*(useREfno: Boolean; const aRefNo: String)*);
    Property ShipmentSalelines: TShipmentSaleline Read GetShipmentSalelines;
Published
    { Calculated fields }
    Property
    CalcProfit         : Double Read GetCalcProfit Write SetCalcProfit;
    Property CalcProfitPercent  : Double Read GetCalcProfitPercent Write SetCalcProfitPercent;
    Property CalcProfitEx       : Double Read GetCalcProfitEx Write SetCalcProfitEx;
    Property CalcProfitPercentEx: Double Read GetCalcProfitPercentEx Write SetCalcProfitPercentEx;
    Property WarrantyPeriod     : String Read GetWarrantyPeriod Write SetWarrantyPeriod;
    Property CustomerEquipmentID: Integer Read GetCustomerEquipmentID Write SetCustomerEquipmentID;
    Property Equipment          : String Read GetEquipment Write SetEquipment;
    Property WarrantyEndsOn     : TDateTime Read GetWarrantyEndsOn Write SetWarrantyEndsOn;
    Property BOMGroupedLine     : Boolean Read GetBOMGroupedLine Write SetBOMGroupedLine;
    Property BOMProductionLine  : Boolean Read GetBOMProductionLine Write SetBOMProductionLine;
    Property SalesLinePackWeight: TSalesLinePackWeightLines read getSalesLinePackWeight;
    Property packweightField1    : Double read getpackweightField1;
    Property packweightField2    : Double read getpackweightField2;
    Property BOMComments         : String Read GetBOMComments Write SetBOMComments;
    Property ReferenceNo         : String Read GetReferenceNo Write SetReferenceNo;


  End;

  TSales = Class(TSalesBase)
  Private
    FOverrideHoldSale     : Boolean;
    FPopupDisplayed       : Boolean;
    FsPOIDs               : STring;
    FbcopytoInvoice       : Boolean;
    FbcopytoCashSale      : Boolean;
    FbcopytoQuote         : Boolean;
    FbcopytoSalesOrder    : Boolean;
    FTotalOrdered         : Double;
    FbSalesonHoldconfirmed: Boolean;
    FshowSO               : TGeneralIntProc;
    FshowPO               : TGeneralStringProc;
    RepairsObj            : TBusobj;
    LineCheckFlag         : Boolean;
    (* fSaleLinesofGroup       : TSalesline; *)
    FQuoteSale                : TQuote;
    FbHasNonTreeLines         : Boolean;
    fiNonTreeLines            : Integer;
    FShippedQtyChanged        : Boolean;
    FbCanLockAllManifest      : Boolean;
    fsBOMLineIDs :String;
    xID:Integer;
    fLineIdsToconvert: TIntegerList;
    fbConvertCurrent: Boolean;
    Function GetTotalQtyBackOrdered: Double;
    Function GetEarlyPaymentDiscountAmount: Double;
    Function Getcleancustomer: String;
    Procedure LockLinkedPOnSO(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure DeleteLinkToPOnSO(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure CopyEquipments(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure UpdateRelatedIDs(RepairParts: TBusobj); Overload;
    (* function getSaleLinesofGroup: TSalesline; *)
    Function PONumnotUnique(Const ShowError: Boolean): Boolean;
    Function GetSalesShippingDetails: TSalesShippingDetails;
    Procedure CloneShippingDetails(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure HasNonTreeLinesCallback(Const Sender: TBusObj; Var Abort: Boolean);
    Function GetSalesCategory: String;
    Procedure SetSalesCategory(Const Value: String);
    Function GetQuoteSale: TQuote;
    Function GetCleanSalesStatus: String;
    Procedure UpdatePQACallback(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure UpdateRelatedIDs(OldSaleId, NewsaleId: Integer; SalesLineObj: Tsalesline); Overload;
    Function GetPlannedDeliveryFrom: TDatetime;
    Procedure SetPlannedDeliveryFrom(Const Value: TDatetime);
    Function GetPlannedDeliveryto: TDatetime;
    Procedure SetPlannedDeliveryTo(Const Value: TDatetime);
    Function GetTSalesDeliveryDetails: TSalesDeliveryDetails;
    Procedure CloneSalesDeliveryDetails(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure MakeProductionGropuping;
    Function GetTSalesGroupedLines: TSalesGroupedLines;
    Procedure CopySalesGroupedLinesCallback(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure AnylinehastreeCallback(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure AnylineHasPurchaseCostCallback(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure AnylineIsBatchEnabledCallback(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure OnChangeCustomer;
    Procedure CalcLinepriceCallback(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure CanLockAllManifestCallback(Const Sender: TBusObj; Var Abort: Boolean);
    Function GetCleanCustomerID: Integer;
    Function GetcleanIsInternalOrder: Boolean;
    Function GetShipmentList: TShipmentList;
    Function ChangeIDSQL(Tablename, TransIDFieldname: String; TransId: Integer; AndSQL: String = ''): String;
    Function ChangeGlobalrefSQL(Tablename, GlobalrefFieldname, Globalref: String; AndSQL: String = ''): String;
    Function IsOktoMerge(Const MergingID: Integer): Boolean;
    procedure ERPScriptAfterExecute(Sender: TObject; fsSQL: string);
    function GetJobName: string;
    procedure SetJobName(const Value: string);
    Function GetProgressPaymentInvRef: String;
    Function GetProgressPaymentSeqno: Integer;
    Procedure SetProgressPaymentInvRef(Const Value: String);
    Procedure SetProgressPaymentSeqno(Const Value: Integer);
    function getSalesLinePackWeightLinesSum: TSalesLinePackWeightLinesSum;
    function getcleanTotalAmountInc: Double;
    function OnHoldTerm: String;
    Function GetReferenceNo: String;
    Procedure SetReferenceNo(Const Value: String);
    Function GetDefaultReferenceNoinAllLines: Boolean;
    Procedure SetDefaultReferenceNoinAllLines(Const Value: Boolean);
    Function GetIsdone: Boolean;
    Procedure SetIsdone(Const Value: Boolean);
    procedure MakeCleanTreeCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure UpdateAllLinesRefNoCallback(const Sender: TBusObj;
      var Abort: Boolean);
    function getShipmentIDs: String;
    procedure ShipmentIDsCallback(const Sender: TBusObj; var Abort: Boolean);
    function getSalesShipments: TSalesShipments;
    procedure setEmployeeLogonName(const Value: String);
    function GetAppointID: Integer;
    Procedure SetAppointID(Const Value: Integer);

    function GetTypeOfBasedOn   : String;
    function GetFrequencyValues : String;
    function GetCopyStartDate   : TDateTime;
    function GetCopyFinishDate  : TDateTime;
    function GetQuota           : Double;

    procedure SetTypeOfBasedOn(Const Value: String);
    procedure SetFrequencyValues(Const Value: String);
    procedure SetCopyStartDate(Const Value: TDateTime);
    procedure SetCopyFinishDate(Const Value: TDateTime);
    procedure SetQuota(Const Value: Double);

Protected
    FbAnyLineShipped: Boolean;

    Procedure DoFieldOnChange(Sender: TField); Override;
    Function GetSaleLines: TSalesLineBase; Override;
    Function GetSQL: String; Override;
    Function GetId: Integer; Override;
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
    Procedure PopulateClientData; Override;
    Procedure CalcTotalsCallback(Const Sender: TBusObj; Var Abort: Boolean); Override;
    Procedure InitializeNewObject; Override;
    Function GetConverted: Boolean;
    Function GetCleanconverted: Boolean;
    Procedure SetConverted(Const Value: Boolean);
    Function IsCustomerTermsOk: Boolean; Virtual;
    Procedure SetForeignCurrencyRate;
    Procedure RecalculateAllLinesCallback(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure CheckSaleDate;
    Function ValidateXMLData(Const Node: IXMLNode): Boolean; Override;
    Procedure ClonePropertyObjects; Override;
    Function GetOriginalSaleRec: TSales; Virtual; Abstract;
    Procedure Ordered(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure ReActivatePQAs(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure CopyPropertyObjects(Const Mappedfields: STring); Override;
    Procedure AssignProductcost(Const Sender: TBusObj; Var Abort: Boolean);
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
    Procedure CreateInstance; Override;
    Function CheckBackOrders(Const BackOrder: TSales; Const IsCombinedBo: Boolean; Var CombinedTransRef: String): Boolean;
    Function GeTEquipmentxRef: TBusobj; Virtual;
    Procedure UpdatePQA;
    Procedure AfterCloneBusObj; Override;
    Procedure CloneLines(Const Sender: TBusObj; Var Abort: Boolean); Override;
    Procedure InstantiateAllTreesCallback(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure BOLinesInit(BackOrder: TTransBase); Override;
    Procedure NewBOInit(BackOrder: TTransBase); Override;
    Procedure ShippedQtyChangedCallback(Const Sender: TBusObj; Var Abort: Boolean);
    procedure InitShiptoAddress;

  Public
    DeletingTomergeOutstandingsale: Boolean;
    Procedure RecalculateAllLines;
    Class Function GetIDField: String; Override;
    Class Function GetBusObjectTablename: String; Override;
    Procedure BusObjCopy(Const Sender: TBusObj; Var Abort: Boolean); Override;

    Property OverrideHoldSale: Boolean Read FOverrideHoldSale Write FOverrideHoldSale;
    Property POIDs: String Read FsPOIDs Write FsPOIDs;
    Property Cleancustomer: String Read Getcleancustomer;
    Property CleanCustomerID: Integer Read GetCleanCustomerID;
    Property CleanIsInternalOrder: Boolean Read GetcleanIsInternalOrder;
    Property cleanTotalAmountInc :Double read getcleanTotalAmountInc;

    // Procedure UpdateRelatedIDsInCopiedLines(dsSource , dsTarget :TTransBase);Override;
    Procedure CalcOrderTotals; Override;
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy; Override;
    Procedure New; Override;
    Procedure Load(Const AId: Integer; Const FIsReadonly: Boolean = False); Overload; Override;
    Procedure Load(Const FIsReadonly: Boolean = False); Overload; Override;
    Procedure SaveToXMLNode(Const Node: IXMLNode); Override;
    Function Save: Boolean; Override;
    Procedure LoadFromXMLNode(Const Node: IXMLNode); Override;
    Function ValidateData: Boolean; Override;
    Function CopySalesToRepairs: Integer;
    Function CloneBusObj(Const Changefield: String; Const ChangeValue: Variant; Const SaveAfterCopy: Boolean = True; Const FilterFields: String = ''): TBusObj; Override;
    Property CopyingToInvoice: Boolean Read FbcopytoInvoice Write FbcopytoInvoice;
    Property CopyingToCashSale: Boolean Read FbcopytoCashSale Write FbcopytoCashsale;
    Property CopyingToQuote: Boolean Read FbcopytoQuote Write FbcopytoQuote;
    Property CopyingToSaleSOrder: Boolean Read FbcopytoSalesOrder Write FbcopytoSalesOrder;
    Property SalesonHoldconfirmed: Boolean Read FbSalesonHoldconfirmed Write FbSalesonHoldconfirmed;
    Property ShowSO: TGeneralIntProc REad FshowSO Write FshowSO;
    Property ShowPO: TGeneralStringProc REad FshowPO Write FshowPO;
    Property SalesDeliveryDetails: TSalesDeliveryDetails REad GetTSalesDeliveryDetails;
    (* Property    SaleLinesofGroup :TSalesline read getSaleLinesofGroup; *)
    Property SalesShippingDetails: TSalesShippingDetails Read GetSalesShippingDetails;
    Function TotalLinesingroup: Integer;
    Function CopyToSmartOrder: Integer;
    Property QuoteSale: TQuote Read GetQuoteSale;
    Property CleanSalesStatus: String Read GetCleanSalesStatus;
    Function HasNonTreeLines: Boolean;
    Function NonTreeLines: Integer;
    Property SalesGroupedLines: TSalesGroupedLines Read GetTSalesGroupedLines; // this is public as the manufacturing stuff is not synchronized
    Procedure InstantiateAllTrees;
    Function Anylinehastree: Boolean;
    function AnylineHasPurchaseCost: Boolean;
    Function AnylineIsBatchEnabled: Boolean;
    Function BOMLineIDs:String;
    Procedure SetPaymentTerms(Const BaseDate: TDateTime); Overload; Override;
    Procedure InitPaymentTerms;
    Function ShippedQtyChanged: Boolean;
    Function CanLockAllManifest: Boolean;
    Function AnySOIngrouphastree: Boolean;
    Function BackorderforProductInGroup(Const FProductID: Integer): Integer;
    Function Lock: Boolean; Override;
    Function Anystartedpacking: Boolean;
    Property ShipmentList: TShipmentList Read GetShipmentList;
    Function MergeSale(Const MergingID: Integer): Boolean; Overload; Virtual;
    Function MergeSale(Const MergingIDs: String): Boolean; Overload; Virtual;
    Property SalesLinePackWeightSum : TSalesLinePackWeightLinesSum read getSalesLinePackWeightLinesSum;
    Property LineIdsToconvert: TIntegerList read fLineIdsToconvert;
    Procedure LineIdToconvert(const Value:Integer);Overload;
    Procedure LineIdToconvert(const Value:String);Overload;
    Procedure CleanLineIdsToconvert;
    Function IsCustomerCreditOk: Boolean; Virtual;
    Property ConvertCurrent :Boolean read fbConvertCurrent write fbConvertCurrent;
    Function IsCustomerOk: Boolean;
    Procedure MakeCleanTree;
    procedure UpdateAllLinesRefNo;
    Property ShipmentIDs:String read getShipmentIDs;
    Property SalesShipments: TSalesShipments read getSalesShipments;

  Published
    Property PlannedDeliveryFrom       : TDatetime REad GetPlannedDeliveryFrom Write SetPlannedDeliveryFrom;
    Property PlannedDeliveryTo         : TDatetime REad GetPlannedDeliveryTo Write SetPlannedDeliveryTo;
    Property EarlyPaymentDiscountAmount: Double Read GetEarlyPaymentDiscountAmount;
    Property TotalQtyBackOrdered       : Double Read GetTotalQtyBackOrdered;
    Property Converted                 : Boolean Read GetConverted Write SetConverted;
    Property CleanConverted            : Boolean Read GetCleanconverted;
    Property SalesCategory             : String Read GetSalesCategory Write SetSalesCategory;
    Procedure DLLCalcOrderTotals;
    Property RepairEquipment: TBusobj Read GeTEquipmentxRef;
    property JobName: string read GetJobName write SetJobName;
    Property ProgressPaymentInvRef     : String Read GetProgressPaymentInvRef Write SetProgressPaymentInvRef;
    Property ProgressPaymentSeqNo: Integer Read GetProgressPaymentSeqno Write SetProgressPaymentSeqno;
    Property ReferenceNo     : String Read GetReferenceNo Write SetReferenceNo;
    Property DefaultReferenceNoinAllLines     : Boolean Read GetDefaultReferenceNoinAllLines Write SetDefaultReferenceNoinAllLines;
    Property Isdone     : Boolean Read GetIsdone Write SetIsdone;
    Property EmployeeLogonName :String write setEmployeeLogonName;
    Property AppointID:               Integer read GetAppointID   write SetAppointID;
    Property TypeOfBasedOn      : String    read GetTypeOfBasedOn     write SetTypeOfBasedOn;
    Property FrequenctyValues   : String    read GetFrequencyValues   write SetFrequencyValues;
    Property CopyStartDate      : TDateTime read GetCopyStartDate     write SetCopyStartDate;
    Property CopyFinishDate     : TDateTime read GetCopyFinishDate    write SetCopyFinishDate;
    Property Quota              : Double    read GetQuota             write SetQuota;
  End;

  TInvoiceLine = Class(TSalesLine)
  Private
    Function GetProgresspaymentRef: String;
    Procedure SetProgresspaymentRef(Const Value: String);
    Function GetSOInvoiceLineRef: String;
    Procedure SetSOInvoiceLineRef(Const Value: String);
    function getDispatchstarted: Boolean;
    Function GetPPGInvoiced: Boolean;
    Function GetPPGRef: String;
    Procedure SetPPGInvoiced(Const Value: Boolean);
    Procedure SetPPGRef(Const Value: String);

  Protected
    Procedure DoFieldOnChange(Sender: TField); Override;
    Procedure GetProductDetails; Override;
    Procedure GetBaseLinePrice; Override;
    Procedure SetDefaultQtyShipped; Override;
    Function GetIsPQAItem: Boolean; Override;
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;

  Public
    Procedure CalcLineTotals; Override;
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy; Override;
    Procedure SaveToXMLNode(Const Node: IXMLNode); Override;
    Procedure LoadFromXMLNode(Const Node: IXMLNode); Override;
    Function ISoktoShip: Boolean; Override;
    Function IsProgressPayment: Boolean; Override;
    Property Dispatchstarted :Boolean read getDispatchstarted;
    function ValidateData: boolean; override;
  Published
    Property ProgressPaymentRef: String Read GetProgresspaymentRef Write SetProgresspaymentRef;
    Property SOInvoiceLineRef  : String Read GetSOInvoiceLineRef Write SetSOInvoiceLineRef;
    Property PPGRef: String Read GetPPGRef Write SetPPGRef;
    Property PPGInvoiced: Boolean Read GetPPGInvoiced Write SetPPGInvoiced;
  End;

  TInvoice = Class(TSales)
  Private
    AllLinesSavedOK            : Boolean;
    FOriginalSale              : TSales;
    FbISMergingSO              : Boolean;
    FTotalPrePayment           : Tdataset;
    FbCreatingsalesOrderInvoice: Boolean;
    fSigned : boolean;

    Procedure LineSaveCallbackProc(Const Sender: TBusObj; Var Abort: Boolean);

    Procedure LineBalanceCallbackProc(Const Sender: TBusObj; Var Abort: Boolean);
    Function UpdateAccounts: Boolean;
    Function GetSOProgressPaymentGlobalRef: String;
    Function GetSOInvoiced: Boolean;
    Function GetSOInvoiceRef: String;
    Function GetSOProgressPaymentOriginalRef: String;
    Function GetTotalPrePayment: TDataset;
    Function GetTotalPrePayments: Double;
    function getisPrinted: Boolean;
    function getProgressPaymentLineID: Integer;
    function GetSignatureRequired: boolean;
    function GetSigned: boolean;

    Procedure SetSOProgressPaymentGlobalRef(Const Value: String);
    Procedure SetSOInvoiced(Const Value: Boolean);
    Procedure SetSOInvoiceRef(Const Value: String);
    Procedure SetSOProgressPaymentOriginalRef(Const Value: String);
    Procedure deleteInvoiceCallback(Const Sender: TBusObj; Var Abort: Boolean);
    procedure SetProgressPaymentInvoices(const Value: String);
    procedure SetSigned(const Value: boolean);

    {Wang}
    function GetOriginalTotalAmount: Double;
    function GetOriginalTotalAmountInc: Double;
    function GetOriginalTotalTax: Double;

    (* Procedure SalesLinesPointsBalanceCallbackProc(Const Sender: TBusObj; var Abort: boolean); *)
  Protected
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
    Procedure DoFieldOnChange(Sender: TField); Override;
    Procedure InitializeNewObject; Override;
    Procedure PopulateClientData; Override;
    Function GetInvoiceLines: TInvoiceLine; Virtual;
    Function GetLines: TTransLineBase; Override;
    Function GetSaleLines: TSalesLineBase; Override;
    Function DoAfterPost(Sender: TDatasetBusObj): Boolean; Override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
    (* Function IsCustomerCreditOK:Boolean;Override; *)
    Function GetOriginalSaleRec: TSales; Override;
    Procedure SetIsNew(Const Value: Boolean); Override;
    Procedure LineValidateCallbackProc(Const Sender: TBusObj; Var Abort: Boolean); Override;
    Function GeTEquipmentxRef: TBusobj; Override;
    Procedure ProcessDeletedLine; Override;
    Function DeleteFlaggedLines: Boolean; Override;
    function SaveCancelled: boolean; Override;
    //procedure CalcTotalsCallback(const Sender: TBusObj; var Abort: Boolean); override;
    procedure SetShipDate(const Value: TDatetime); override;
    Function LockTrans(Var ErrMsg: String): Boolean; Override;

  Public
    Class Function GetBusObjectTablename: String; Override;
    Class Function GetIDField: String; Override;
    Procedure CalcOrderTotals; Override;
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy; Override;
    Procedure SaveToXMLNode(Const Node: IXMLNode); Override;
    Procedure LoadFromXMLNode(Const Node: IXMLNode); Override;
    Function ValidateData: Boolean; Override;
    Function Save: Boolean; Override;
    Function CopyInvoiceToSmartOrder: Integer;
    Property ISMergingSO: Boolean Read FbISMergingSO Write FbISMergingSO;
    Function CopyInvoiceToInvoice: Integer;
    Property TotalPrePayments: Double Read GetTotalPrePayments;
    Property TotalPrePayment: TDataset Read GetTotalPrePayment;
    Property CreatingsalesOrderInvoice: Boolean Read FbCreatingsalesOrderInvoice Write FbCreatingsalesOrderInvoice;
    Property isPrinted :Boolean read getisPrinted;
    Property ProgressPaymentLineID :Integer read getProgressPaymentLineID;
    Property ProgressPaymentInvoices :String Write SetProgressPaymentInvoices;
    property SignatureRequired : boolean read GetSignatureRequired;
    property Signed : boolean read GetSigned write SetSigned;
    Function Lock: Boolean; Override;
    Function PayInvoice(aPaymentMethod:String; aDate_paid:TDatetime):Boolean;

  Published
    Property Lines: TInvoiceLine Read GetInvoiceLines;
    Procedure Load(Const FIsReadonly: Boolean = False); Override;
    Property SOProgressPaymentGlobalRef: String Read GetSOProgressPaymentGlobalRef Write SetSOProgressPaymentGlobalRef;
    Property SOProgressPaymentOriginalRef: String Read GetSOProgressPaymentOriginalRef Write SetSOProgressPaymentOriginalRef;
    Property SOInvoiceRef: String Read GetSOInvoiceRef Write SetSOInvoiceRef;
    Property SOInvoiced: Boolean Read GetSOInvoiced Write SetSOInvoiced;
    // Wang
    Property OriginalTotalAmount:     Double  read GetOriginalTotalAmount;
    Property OriginalTotalAmountInc:  Double  read GetOriginalTotalAmountInc;
    Property OriginalTotalTax:        Double  read GetOriginalTotalTax;

  End;

  TQuoteLine = Class(TSalesLine)
  Private
  Protected
    Procedure DoFieldOnChange(Sender: TField); Override;
    Procedure GetProductDetails; Override;
    Procedure GetBaseLinePrice; Override;
    Procedure SetDefaultQtyShipped; Override;
    Procedure InitializeNewObject; Override;
    Function GetIsPQAItem: Boolean; Override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
  Public
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
    Procedure CalcLineTotals; Override;
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy; Override;
    Function ValidateData: Boolean; Override;
    Procedure CalcTreePrice; Override;

  End;

  TQuoteBase = Class(TSales)
  Private
    (* AllLinesValid: boolean; *)
    AllLinesSavedOK: Boolean;
    Function GetFreezeQuoteAmount: Boolean;
    Procedure SetFreezeQuoteAmount(Const Value: Boolean);
    Function GetQuoteLines: TQuoteLine;
    Function GetReference: String;
    Procedure SetReference(Const Value: String);
    Function GetConvertedDate: TDateTime;
    Procedure SetConvertedDate(Const Value: TDateTime);

  Protected
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
    Procedure DoFieldOnChange(Sender: TField); Override;
    Procedure InitializeNewObject; Override;
    Function GetLines: TTransLineBase; Override;
    Function GetSaleLines: TSalesLineBase; Override;
    Procedure LineValidateCallbackProc(Const Sender: TBusObj; Var Abort: Boolean); Override;
    Procedure LineSaveCallbackProc(Const Sender: TBusObj; Var Abort: Boolean);
    Function IsCustomerTermsOk: Boolean; Override;
    Function GetOriginalSaleRec: TSales; Override;

  Public
    Class Function GetIDField: String; Override;
    Class Function GetBusObjectTablename: String; Override;
    Procedure CalcOrderTotals; Override;
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy; Override;
    Procedure SaveToXMLNode(Const Node: IXMLNode); Override;
    Procedure LoadFromXMLNode(Const Node: IXMLNode); Override;
    Procedure SetPaymentTerms(Const BaseDate: TDateTime); Override;
    Function ValidateData: Boolean; Override;
    Procedure Load(Const FIsReadonly: Boolean = False); Override;
    Function Save: Boolean; Override;
    Function CopyQuoteToQuote: Integer;
    Function CopyQuoteToInvoice: Integer;
    Function CopyQuoteToCashSale: Integer;
    Function CopyQuoteToSalesOrder: Integer;
    Function CopyQuoteToSmartOrder: Integer;
    Function HasbinBatchProductSrProduct: Boolean;
    Procedure BusObjCopy(Const Sender: TBusObj; Var Abort: Boolean); Override;
    Function IsCustomerCreditOk: Boolean; Override;
  Published
    Property Lines            : TQuoteLine Read GetQuoteLines;
    Property FreezeQuoteAmount: Boolean Read GetFreezeQuoteAmount Write SetFreezeQuoteAmount;
    Property ConvertedDate: TDateTime Read GetConvertedDate Write SetConvertedDate;
    Property Reference: String Read GetReference Write SetReference;
  End;

  TQuote = Class(TQuoteBase)
  Private
    Function GetSalesGroupRef: String;
    Function GetTRelatedSales: TRelatedSales;
    Function GetTRelatedSale: TRelatedSales;
    Function GetPreviousSale: TRelatedSales;
    Function GetPreviousRef: String;
    Function GetQuoteVaried: Boolean;
    {Wang}
    function GetOriginalTotalAmount: Double;
    function GetOriginalTotalAmountInc: Double;
    function GetOriginalTotalTax: Double;

  Public
    Function MakeVariation(SaleLineIdfilter: String): Integer;
    Property RelatedSales: TRelatedSales Read GetTRelatedSales;
    Property RelatedSale: TRelatedSales Read GetTRelatedSale;
    Property PreviousSale: TRelatedSales Read GetPreviousSale;
    Property SalesGroupRef: String Read GetSalesGroupRef;
    Property PreviousRef: String Read GetPreviousRef;
    Property QuoteVaried: Boolean Read GetQuoteVaried;
    Function Save: Boolean; Override;
    Procedure DoFieldOnChange(Sender: TField); Override;
    Function LockTrans(Var ErrMsg: String): Boolean; Override;
    Procedure CalcOrderTotals; Override;

  Published
        // Wang
    Property OriginalTotalAmount:     Double read GetOriginalTotalAmount;
    Property OriginalTotalAmountInc:  Double read GetOriginalTotalAmountInc;
    Property OriginalTotalTax:        Double read GetOriginalTotalTax;
  End;

  TSalesOrder = Class;

  TManPQA = class(TPQA)
    Private
    Protected
    Public
    function Save: Boolean; override;
  end;

  TSalesOrderLine = Class(TSalesLine)
  Private
    ShippingTreeItem: Boolean;
    AllLinesValid :Boolean;
    Function GetIsMergingSOToInvoice: Boolean;
    Function GetTreeFinalized: Boolean;
    function getSmartOrderLineID :Integer;
    Function getBundleQty :Double;
    Procedure SetTreeFinalized(Const Value: Boolean);
    Procedure SetSmartOrderLineID(const Value:Integer);
    Procedure SetBundleQty(Const Value:Double);
    Function GettotalInvoicedQty: Double;
    Procedure DeleteSalesOrderInvoiceLinesPQAnAllocations;
    Function HasPartialInvoices: Boolean;
    function getManPQA: TManPQA;
    function getRootProcTreePartID: Integer;
    function getproctree: Tproctree;
    function getRootproctree: TproctreeRoot;
    function getLineCompletelyBuilt: Boolean;
    procedure LineCompletelyBuiltCallback(const Sender: TBusObj; var Abort: Boolean);
    //Procedure InstantiateWalmart(CreateIfnotCreated: Boolean;BOLine :TSalesOrderLine; Eventtype: Integer);
    //function GetWalmartOrder: TWalmartOrders;
    function getOriginalSalesDocNumber: String;
    function getXMLTocopyLine: String;
  Protected
    Procedure DoFieldOnChange(Sender: TField); Override;
    Procedure GetProductDetails; Override;
    Procedure GetBaseLinePrice; Override;
    Function GetFutureOrder: Boolean;
    Procedure CreateInstance; Override;
    Function GetIsPQAItem: Boolean; Override;
    Function GetEnableAllocation: Boolean; Override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
    Procedure SetDefaultQtyShipped; Override;

Public
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
    Procedure CalcLineTotals; Override;
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy; Override;
    Property IsMergingSOToInvoice: Boolean Read GetIsMergingSOToInvoice;
    Function SalesOrder: TSalesOrder;
    Procedure SaveToXMLNode(Const Node: IXMLNode); Override;
    Procedure LoadFromXMLNode(Const Node: IXMLNode); Override;
    Procedure FinaliseTree; Override;
    Procedure CalcTreePrice; Override;
    Property TotalInvoicedQty: Double Read GettotalInvoicedQty;
    Procedure Copyallocation; Override;
    Property RootProcTreePartID:Integer read getRootProcTreePartID;
    Property Rootproctree : TproctreeRoot read getRootproctree;
    Property proctree : Tproctree read getproctree;
    Property LineCompletelyBuilt :Boolean read getLineCompletelyBuilt;
    Function HasWalmartOrder: Boolean;
    Procedure DoContainerEvent(Const Sender: TObject; Const EventType: Integer; Const Data: TObject = Nil; Proc : TProcBusObjBase= nil); Override;
    //Property WalmartOrder: TWalmartOrders read getWalmartOrder;
    Property OriginalSalesDocNumber :String read getOriginalSalesDocNumber;
    Property         XMLTocopyLine :String REad getXMLTocopyLine;
    Function Save:Boolean; Override;
  Published
    Property TreeFinalized: Boolean Read GetTreeFinalized Write SetTreeFinalized;
    Property SmartOrderLineID :Integer read getSmartOrderLineID write setSmartOrderLineID;
    Property BundleQty :Double read getBundleQty write setBundleQty;
    Property ManPQA: TManPQA read getManPQA;
  End;

  TSalesOrder = Class(TSales)
  Private
    (* AllLinesValid           : boolean; *)
    AllLinesSavedOK: Boolean;
    //FProgressBar   : TProgressBar;
    FOriginalSale  : TSales;
    // AllMergedOk             : Boolean;
    FbIsMergingSOToInvoice: Boolean;
    MergingInvoice        : TInvoice;
    // MergeCtr                : Integer;
    FTotalProgressPayment: Tdataset;
    FProgressPayments    : Tdataset;
    FTotalPrePayment     : Tdataset;
    FPrePayments         : Tdataset;

    Function GetSalesOrderBalance: Double;
    Function GetFutureSO: Boolean;
    (*Function GetProgressBar: TProgressBar;*)
    Procedure SetSalesOrderBalance(Const Value: Double);
    Procedure SetFutureSO(Const Value: Boolean);
    (* procedure SetIsInternalOrder(const Value: boolean); *)
    (* function  GetIsInternalOrder: boolean; *)
    (* procedure MergeSOs(Const Sender: TBusObj; var Abort: boolean); *)
    (* procedure AssignSeqno(Const Sender: TBusObj; var Abort: boolean); *)
    Procedure SalesInternalOrderchangeCallback(Const Sender: TBusObj; Var Abort: Boolean);

    Class Function GetSOwithAllBOs(SOID: Integer): STring;
    Procedure UpdateBaselineNo(Const OriginalNo: STring);
    Function UpdateAccounts: Boolean;
    Function GetInternalSOGlobalref: String;
    Procedure SetInternalSOGlobalref(Const Value: String);
    Function GetTotalProgressPayments: Double;
    Function GetTotalProgressPayment: TDataset;
    Function GetProgresspayments: TDataset;
    Procedure AddProgresspayments(Inv: TInvoice);
    Function GetTotalPrePayment: TDataset;
    Function GetPrePayments: TDataset;
    Function GetTotalPrePayments: Double;
    Procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; Const EventType, Value: String);
    Function GetSalesOrderInvoiceIds: String;
    Procedure LockSOnSOInvoicesCallback(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure DoconvertInternalOrderCallback(Const Sender: TBusObj; Var Abort: Boolean);
    function CopyPickAssemblies(const SOIDs: String): Boolean;
    procedure CheckDefaultQtyShippedCallback(const Sender: TBusObj;
      var Abort: Boolean);
    function getallBuilt: Boolean;
    procedure allBuiltCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure AnyLineHasWalmartOrderCallback(const Sender: TBusObj;var Abort: Boolean);
    procedure RecalculateTreecostnPriceCallback(const Sender: TBusObj;
      var Abort: Boolean);
    (* function getconvertedtoInvoice: TInvoice; *)
    {Wang}
    function GetOriginalTotalAmount: Double;
    function GetOriginalTotalAmountInc: Double;
    function GetOriginalTotalTax: Double;

  Protected
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
    Procedure DoFieldOnChange(Sender: TField); Override;
    Procedure InitializeNewObject; Override;
    Procedure LineSaveCallbackProc(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure LineValidateCallbackProc(Const Sender: TBusObj; Var Abort: Boolean); Override;
    Function GetLines: TTransLineBase; Override;
    Function GetSaleLines: TSalesLineBase; Override;
    (* function  IsCustomerCreditOk: boolean;                      override; *)
    Function IsCustomerTermsOk: Boolean; Override;
    Function GetOriginalSaleRec: TSales; Override;
    Procedure CreateInstance; Override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
    Function GetSalesOrderLines: TSalesOrderLine; Virtual;
    Procedure ProcessDeletedLine; Override;
    Function DeleteFlaggedLines: Boolean; Override;
    Procedure CloneLines(Const Sender: TBusObj; Var Abort: Boolean); Override;
    Procedure BOLinesInit(BackOrder: TTransBase); Override;
  Public
    Class Function GetIDField: String; Override;
    Class Function GetBusObjectTablename: String; Override;
    Procedure BusObjCopy(Const Sender: TBusObj; Var Abort: Boolean); Override;
    Property IsMergingSOToInvoice: Boolean Read FbIsMergingSOToInvoice Write FbIsMergingSOToInvoice;
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy; Override;
    Procedure CalcOrderTotals; Override;
    Procedure SaveToXMLNode(Const Node: IXMLNode); Override;
    Procedure LoadFromXMLNode(Const Node: IXMLNode); Override;
    Procedure Load(Const FIsReadonly: Boolean = False); Override;
    Function ValidateData: Boolean; Override;
    Function Save: Boolean; Override;
    Function CopyToInvoice(SOID: Integer; IsCashSale: Boolean = False; aUserLock:TUserLock=nil; aLockGroupName:String=''): Integer;
    Function LockSOnSOInvoices: Boolean;
    Function CopySalesOrderToSmartOrder: Integer;
    // function    MergeSalesOrders(SalesIDs: String) : Integer;
    Function HasalreadyConvertedBinBatchSRProduct(FirstSOID: Integer): Boolean;
    Function GetBackOrderMainSOId: Integer;
    Function IsBO: Boolean;
    //Property ProgressBar: TProgressBar Read GetProgressBar Write FProgressBar;
    (* Property convertedtoInvoice :TInvoice read getconvertedtoInvoice; *)
    Function ConvertedtoInvoiceCount: Integer;
    function convertedtoInvoicecID: Integer;

    Property TotalProgressPayments: Double Read GetTotalProgressPayments;
    Property TotalProgressPayment: TDataset Read GetTotalProgressPayment;
    Property Progresspayments: TDataset Read GetProgresspayments;

    Property TotalPrePayments: Double Read GetTotalPrePayments;
    Property TotalPrePayment: TDataset Read GetTotalPrePayment;
    Property PrePayments: TDataset Read GetPrePayments;

    Procedure RecalcProgressPayments;
    Function MakeProgresspayment(Const Progresspaymentamt: Double; var msg: string): Integer;
    Function CopySalesorderToSalesorder: Integer;
    Procedure DoconvertInternalOrder;
    Function UnGroupProductionEntry(Const SaleLineID: Integer; Var MSg: String): Boolean;
    Function LineTreeRootID(LineID: Integer): Integer;
    Procedure ApplyPrepayment(InvoiceObj: TInvoice);
    Property SalesOrderInvoiceIds: String Read GetSalesOrderInvoiceIds;
    Function HasAnyshippednInvoiced: Boolean;
    Property AllBuilt :Boolean read getallBuilt;
    Function IsCustomerCreditOk: Boolean; override;
    Function HasPPG:Boolean;
    Procedure DoContainerEvent(Const Sender: TObject; Const EventType: Integer; Const Data: TObject = Nil; Proc : TProcBusObjBase= nil); Override;
    function IsWalmartOrder: Boolean;
    Class function MakeInvoice(aSaleID :Integer; Conn: TMyDAcDataconnection):Boolean;
    Function RecalculateTreecostnPrice:boolean;
    //Procedure CheckForPPGMismatch;
  Published
    Property Lines              : TSalesOrderLine Read GetSalesOrderLines;
    Property FutureSO           : Boolean Read GetFutureSO Write SetFutureSO;
    Property SalesOrderBalance  : Double Read GetSalesOrderBalance Write SetSalesOrderBalance;
    Property InternalSOGlobalRef: String Read GetInternalSOGlobalref Write SetInternalSOGlobalref;
    (* property IsInternalOrder    : boolean           read    GetIsInternalOrder      write SetIsInternalOrder; *)

      // Wang
    Property OriginalTotalAmount:     Double read GetOriginalTotalAmount;
    Property OriginalTotalAmountInc:  Double read GetOriginalTotalAmountInc;
    Property OriginalTotalTax:        Double read GetOriginalTotalTax;
  End;

  TSaleList = Class(TMSBusObj)
  Private
    Function GetIsCashSale: Boolean;
    Function GetIsInvoice: Boolean;
    Function GetIsQuote: Boolean;
    Function GetIsRefund: Boolean;
    Function GetIsSalesOrder: Boolean;
    Function GetCustPONumber: String;
    Function GetSaleTypeDesc: String;
    // procedure SetIsCashSale(const Value: boolean);
    // procedure SetIsInvoice(const Value: boolean);
    // procedure SetIsQuote(const Value: boolean);
    // procedure SetIsRefund(const Value: boolean);
    // procedure SetIsSalesOrder(const Value: boolean);
  Protected
    // function GetSQL: string; override;
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
    Procedure DoFieldOnChange(Sender: TField); Override;
  Public
    Class Function GetIDField: String; Override;
    Class Function GetBusObjectTablename: String; Override;
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy; Override;
    Function GetId: Integer; Override;
  Published
    Property IsCashSale  : Boolean Read GetIsCashSale; // write SetIsCashSale;
    Property IsRefund    : Boolean Read GetIsRefund; // write SetIsRefund;
    Property IsInvoice   : Boolean Read GetIsInvoice; // write SetIsInvoice;
    Property IsSalesOrder: Boolean Read GetIsSalesOrder; // write SetIsSalesOrder;
    Property IsQuote     : Boolean Read GetIsQuote; // write SetIsQuote;
    Property CustPONumber: String Read GetCustPONumber; // write SetCustPONumber;
    Property SaleTypeDesc: String Read GetSaleTypeDesc;
  End;

  TQuoteEx = class(TQuote)
  published
    property Attachments;
  end;

  TSalesOrderEx = class(TSalesOrder)
  published
    property Attachments;
  end;

  TInvoiceEx = class(TInvoice)
  published
    property Attachments;
  end;

  TInvoiceBackorder = class(TInvoice)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TInvoiceNonBackOrder = class(TInvoice)
  public
    constructor Create(AOwner: TComponent); override;
  end;
  TSalesOrderBackOrder = class(TSalesOrder)
  public
    constructor Create(AOwner: TComponent); override;
  end;
  TSalesOrderNonBackOrder = class(TSalesOrder)
  public
    constructor Create(AOwner: TComponent); override;
  end;


Procedure Register;

Implementation

Uses
  Controls, SysUtils, Dialogs, CommonLib, DNMLib, GlobalEventsObj, BusObjStock, TcDataUtils, DateUtils, BusObjConst, TcTypes, Variants, BusObjClass, BusObjClient, BusobjCash, Forms,
  AppEnvironment, SalesConst, BusObjSmartOrder, BusObjMarketingLeads, tcconst, BusObjRepairs, BusobjOrders, LogUtils,  BusObjEquipment, PartsPriceMatrixLib,
  BusObjUtils, BusobjPrepayments, SystemLib, BusobjSalesorderInvoice, CommonDbLib, ProductQtyLib, LogLib, BusObjPickingAssembly, busobjvouchersale,
  DbSharedObjectsObj, BusObjProductClass, SalesDiscountValidationObj,
  BusObjCommon, math, busobjProcProgress, BusObjPayments,  TPPGFixObj;

Procedure Register;
Begin
  // RegisterComponents('Business Objects', [TPurchaseOrder]);
End;
// -----------------------------------------------------------------------------
{ TSalesLine }
// -----------------------------------------------------------------------------

Constructor TSalesLine.Create(AOwner: TComponent);
Begin
  Inherited;
  FdQtyAvailableForDiscontinuedProduct := 0;
  FSQL                                 := 'SELECT * FROM tblSalesLines';
  FBusObjectTypeDescription            := 'Base Sale Line Object';
  FbAddingRelatedProducts              := False;
  FbProductIDChanging                  := False;
  FbProductNameChanging                := False;
  FieldsnotToclone                     := ExcludeFromclone + ',' + QuotedStr('SoldSerials') + ',' + QuotedStr('Baselineno');
  If Self.ConvertingQuote Then
      FieldsnotToclone := QuotedStr('Shipped') + ',' + QuotedStr('UnitofMeasureShipped') + ',' + QuotedStr('BackOrder') + ',' + QuotedStr('UnitofMeasureBackorder') + ',' + QuotedStr('Invoiced');
End;

Procedure TSalesLine.DeleteTree;
Var
  X: Integer;
Begin
  For X := 0 To Container.Count - 1 Do
    Try
      If (Container.Item[X] Is TSaleslineProctree) Then Begin
        Container.Item[X].Free;
        Container.Delete(X);
        Exit;
      End;
    Except
    End;
End;

Function TSalesLine.DeletingTomergeOutstandingsale: Boolean;
Begin
  REsult := False;
  If Assigned(Self.Owner) Then
    If Self.Owner Is TSales Then Result := TSales(Self.Owner).DeletingTomergeOutstandingsale;
End;

Destructor TSalesLine.Destroy;
Begin

  Inherited;
End;

Procedure TSalesLine.New;
Begin
  Inherited;
  If Assigned(Owner) And (Owner Is TSales) Then Self.SaleId := TSales(Owner).SaleId;
End;

{ Set new lines headder ID and Save to get new line ID }
Procedure TSalesLine.InitializeNewObject;
Begin
  LogD('TSalesLine.InitializeNewObject', LbBegin);
  Try
    Inherited;
    If (Self.Owner Is TSales) And (TSales(Self.Owner).Id > 0) Then Begin
      Self.SaleId   := TSales(Self.Owner).Id;
      Self.Deleted  := False;
      Self.ShipDate := TSales(Owner).ShipDate;
      If Self.Dataset.State = DsInsert Then Begin
        Self.PostDB;
        Self.Editdb;
      End;
    End;
  Finally LogD('', LbEnd);
  End;
End;


Function TSalesLine.HasProcess: Boolean;
Var
  Qry:TERPQuery;
Begin
  qry := DbSharedObj.GetQuery(connection.Connection);
  try
      commondblib.closedb(Qry);
      Qry.SQL.text := 'Select  SL.sAleLineID  from tblSaleslines SL  inner join tblprocTree PT on SL.SaleLineId	= PT.masterID and 	PT.Mastertype <> "mtProduct" ' +
                      ' where SL.sAleLineID = ' +    IntToStr(ID) + ' limit 1';
      //Qry.SQL.text := 'Select  PT.proctreeId from tblproctree PT where PT.MasterId =  ' +    IntToStr(ProductId) + '  and PT.mastertype ="mtProduct" and ifnull(PT.ParentId , 0)=0';
      commondblib.opendb(Qry);
      Result := Qry.Recordcount > 0;
  Finally
      DbSharedObj.ReleaseObj(Qry);
  End;
End;
Procedure TSalesLine.InstantiateTree(CreateIfnotCreated: Boolean = True; Recalccost :Boolean =True);
Var
  X     : Integer;
  BusObj: TBusObjBase;
Begin
  if fbInstantiatingTree then exit;
  fbInstantiatingTree := True;
  try
    LogContianerNames;
    For X := 0 To Container.Count - 1 Do
      Try
        If (Container.Item[X] Is TSaleslineProctree) Then Exit;
      Except
      End;

    If CreateIfnotCreated Or HasProcess Then Begin
      LogContianerNames;
      BusObj := TSaleslineProctree.Create(Self);
      //logtext('Sales Line #' + inttostr(ID)+'.SaleslineProctree =' + inttostr(Integer(Busobj)));
      Container.List.Add(BusObj);
      if AccessManager.Accesslevel <= 3 then
        TSaleslineProctree(BusObj).CalcPrice(True, Recalccost);
    End;
  finally
    fbInstantiatingTree :=False;
  end;
End;

Function TSalesLine.Tree(Recalccost:Boolean =True): TSaleslineProctree;
Var
  X: Integer;
Begin
  Result := Nil;
  InstantiateTree(False , Recalccost);
  For X := 0 To Container.Count - 1 Do
    Try
      If (Container.Item[X] Is TSaleslineProctree) Then Begin
        Result := TSaleslineProctree(Container.Item[X]);
        Exit;
      End;
    Except
    End;
End;

Procedure TSalesLine.CheckForeignCodeAndRate;
Var
  BuyRate, SellRate: Double;
Begin
  LogD('TSalesLine.CheckForeignCodeAndRate', LbBegin);
  Try
    If AppEnv.CompanyPrefs.UseForeignCurrencyOnSales Then Begin

      { Make sure header has required foreign currency info. }
      If TSales(Owner).ForeignExchangeCode = '' Then Begin
        If TSales(Owner).Customer.ForeignExchangeCode <> '' Then Begin
          TSales(Owner).ForeignExchangeCode := TSales(Owner).Customer.ForeignExchangeCode;
        End Else Begin
          TSales(Owner).ForeignExchangeCode := AppEnv.RegionalOptions.ForeignExDefault;
        End;
      End;
    End;
    If (TSales(Owner).ForeignExchangeRate = 0) And (TSales(Owner).Customer.ForeignExchangeCode <> '') Then Begin
      // get the rate for the currency
      TSales(Owner).FXObj.GetForeignExchangeRatesForDate(TSales(Owner).ForeignExchangeCode, TSales(Owner).SaleDate, BuyRate, SellRate);

      // NOTE use the banks buy rate, ie we have to sell the foreign
      // currency back to the the bank (they are buying from us)
      // that we received for payment of invoice from OS customer.
      TSales(Owner).ForeignExchangeRate := SellRate; // BuyRate;
    End;
  Finally LogD('', LbEnd);
  End;
End;

Function TSalesLine.ISPartDiscontinuednQtynotEnough: Boolean;
Begin
  Result := False;
  If QtySold > 0 Then
    If Product.IsDiscontinued Then Begin
      Postdb;
      FdQtyAvailableForDiscontinuedProduct := Round(TProductClass.AvailableQty(ProductID, ClassId) - SoldQtyforProductInthisSale, RoundPlacesGeneral);
      If FdQtyAvailableForDiscontinuedProduct < 0 Then FdQtyAvailableForDiscontinuedProduct := 0;
      If QtySold > FdQtyAvailableForDiscontinuedProduct Then Begin
        QtyrequiredforAlternateProduct := QtySold - FdQtyAvailableForDiscontinuedProduct;
        QtySold                        := FdQtyAvailableForDiscontinuedProduct;
        UOMQtySold                     := Round(DivZer(QtySold, UOMMultiplier), RoundPlacesGeneral);
        If QtyShipped > QtySold Then Begin
          QtyShipped    := QtySold;
          UOMQtyShipped := UOMQtySold
        End;
        QtyBackOrder    := Round(QtySold - QtyShipped, RoundPlacesGeneral);
        UOMQtyBackOrder := Round(DivZer(QtyBackOrder, UOMMultiplier), RoundPLacesGeneral);
        CalcLineTotals;
        Result := QtyrequiredforAlternateProduct > 0;
        PostDB;
      End;
    End;
End;

Function TSalesLine.IsProgressPayment: Boolean;
Begin
  Result := False;
End;

Function TSalesLine.CheckForDiscontinuedProduct: Boolean;
Begin
  Result := False;
  If (Not Self.SilentMode) And ISPartDiscontinuednQtynotEnough Then Begin
    Result := True;
    AddEvent(BusobjEvent_ToDo, BusobjEventVal_ChooseAlternateProduct, Self.ID);
  End;
End;

Function TSalesLine.GetBOMGroupedLine: Boolean;
Begin
  REsult := GetbooleanField('BOMGroupedLine');
End;

Function TSalesLine.GetBOMProductionLine: Boolean;
Begin
  REsult := GetbooleanField('BOMProductionLine');
End;

Procedure TSalesLine.SetBOMGroupedLine(Const Value: Boolean);
Begin
  SetBooleanfield('BOMGroupedLine', Value)
End;

Procedure TSalesLine.SetBOMProductionLine(Const Value: Boolean);
Begin
  SetBooleanfield('BOMProductionLine', Value)
End;
Procedure TSalesLine.DoFieldOnChange(Sender: TField);
Var
  HedgedForeignPrice   : Double;
  FdOldtot, FdOldtotInc: Double;
Begin
  LogD('TSalesLine.DoFieldOnChange ' + Sender.FieldName, LbBegin);
  Try
    FdOldTot    := TotalLineamount;
    FdOldTotInc := TotalLineamountInc;
    Try
      If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
        If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.
      If Sysutils.SameText(Sender.FieldName, 'ProductName') And ((Sender.AsString = '') Or ((Not VarIsNull(Sender.OldValue)) And (Sender.OldValue = Sender.AsString))) Then Exit;
      If (Self.SaleLineId < 1) And ((Self.ProductId > 0) Or (Not ComboLinkedPropBlank(Self.ProductName))) Then InitializeNewObject;
      Inherited;

      If Sysutils.SameText(Sender.FieldName, 'Deleted') Then Begin
        If Not RawMode Then Begin
          If Deleted Then Begin
            If Not CanLockManifest Then Begin
              Deleted := False;
              PostDB;
              Exit;
            End;
          End;
          If Assigned(Container) Then DoContainerEvent(Self, EvSalesLineDeletedChange);
        End;
      End
      Else If Sysutils.SameText(Sender.FieldName, 'ProductID') Then Begin

        If Self.ProductId <> 0 Then Begin
          Productname := '';//Product.Load(Self.ProductId);
          //if not (Sametext(Self.ProductName , Product.ProductName) ) then begin
              Self.ProductName := Product.ProductName;
              Self.ExcludeFromSmartOrder := Product.ExcludeFromSmartOrder;
              If Not RawMode Then Begin
                  If ProductChanged Then Exit;
                  If Assigned(Container) Then begin
                    DoContainerEvent(Self, EvSalesLineProductChange);
                  end;
                  PostDB;
                  GetProductDetails;
                  //If Assigned(Container) Then DoContainerEvent(Self, EvSalesLineProductChange);
                  FbProductIDChanging := True;
                  ProductName         := Product.ProductName;
                  { TODO: Add serial number processing }
                  CheckForeignCodeAndRate;
                  If Not RunningEventListEvents Then begin
                  AddEvent(BusObjEvent_Change, BusObjEventVal_ProductChanged, Self.ID);
                  end;
                CalcLineTotals;
                GlobalEvents.Notify(Self, GEVENT_OnSelectProduct);
                FbProductIDChanging := False;
              End;
          //End;
        End;
      End Else If Sysutils.SameText(Sender.FieldName, 'ProductPrintName') Then Begin
      End Else If Sysutils.SameText(Sender.FieldName, 'ProductName') Then Begin
        FbProductNameChanging := True;
        ProductId := 0;//Product.LoadSelect('PartName = ' + QuotedStr(Self.ProductName));
        //if Self.ProductId <> Product.Id then begin
            Self.ProductId := Product.Id;
            Self.ExcludeFromSmartOrder := Product.ExcludeFromSmartOrder;
            If Not RawMode Then Begin
              If ProductId > 0 Then Begin
                  If ProductChanged Then Exit;

                  If Assigned(Container) Then begin
                    DoContainerEvent(Self, EvSalesLineProductChange );
                  end;
                  PostDB;
                  GetProductDetails;
                  //If Assigned(Container) Then DoContainerEvent(Self, EvSalesLineProductChange);
                  CheckForeignCodeAndRate;

                  // GetProductDetails;
                  If Not RunningEventListEvents Then begin
                    AddEvent(BusObjEvent_Change, BusObjEventVal_ProductChanged, Self.ID);
                  end;
                CalcLineTotals;
                GlobalEvents.Notify(Self, GEVENT_OnSelectProduct);
                FbProductNameChanging := False;
              End;
            End;
        //end;
      End
      Else If Sysutils.SameText(Sender.FieldName, 'QtySold') Then Begin
        // user can't change

        If Not RawMode Then Begin
          UOMQtySold := Round(DivZer(QtySold, UOMMultiplier), RoundPlacesGeneral);
          If (IsRelatedProduct) And (Not ImportingFromXMLFile) Then
          Else SetDefaultQtyShipped;

          { Calc new back order qty }
          QtyBackOrder    := Round(QtySold - QtyShipped, RoundPlacesGeneral);
          UOMQtyBackOrder := Round(DivZer(QtyBackOrder, UOMMultiplier), RoundPLacesGeneral);
          { Binny :converting transactions should not change the price if already given }
          If (Self.Lineprice <> 0) And (Assigned(Self.Owner)) And (Self.Owner Is TSalesOrder) And (TSalesOrder(Self.Owner).ConvertingQuote) Then
          Else If (Self.Lineprice <> 0) And (Assigned(Self.Owner)) And (Self.Owner Is TInvoice) And (TInvoice(Self.Owner).ConvertingSO) Then
          Else If (Self.Lineprice <> 0) And (Assigned(Self.Owner)) And (Self.Owner Is TInvoice) And (TInvoice(Self.Owner).ConvertingRepairs) Then
          Else If (Self.Lineprice <> 0) And (Assigned(Self.Owner)) And (Self.Owner Is TInvoice) And (TInvoice(Self.Owner).ConvertingHire) Then
          Else If (Self.Lineprice <> 0) And (Assigned(Self.Owner)) And (Self.Owner Is TInvoice) And (TInvoice(Self.Owner).ConvertingQuote) Then
          Else If (Self.Lineprice <> 0) And (Assigned(Self.Owner)) And (Self.Owner Is TInvoice) Then
          Else Begin
            Self.GetBaseLinePrice; { Calculate new cost based on new quantity. }
            CalcLineTotals; { Recalculate line totals }
          End;
          { Product Specification calculations }
          If AppEnv.CompanyPrefs.UseProductSpecsCalcsSales Then Begin
            If Product.ProductSpecs.LocateSpecID(Self.PartSpecID) Then Begin
              If (Self.UOMQtySold <> 0.00) And IsNumeric(Product.ProductSpecs.SpecValue) Then Begin
                Self.SpecValue := FloatToStr(Round(DivZer(Self.UOMQtySold, Self.UOMMultiplier) * StringToFloat(Product.ProductSpecs.SpecValue), Self.RoundPlacesGeneral));
              End;
            End;
          End;
          /// /{if not InternalQuantityChange then }DoContainerEvent(Self, evSalesLineQtyChange);

          GlobalEvents.Notify(Sender, GEVENT_OnChange_After);
          (* SendEvent(BusObjEvent_Change, BusObjEventVal_QtySold);
            EditDB; *)
          // Vars.Values.ByName['QtySoldChanged'].asBoolean := true;
          AddEvent(BusObjEvent_Change, BusObjEventVal_QtySold, Self.ID);
          If not(updatingRelPrQty) and Assigned(Owner) And (Owner Is TSales) Then TSales(Owner).DoCalcOrderTotals;
          AddEvent(BusObjEvent_Change, BusObjEventVal_OrderTotalsCalculated, Self.ID);
        End;
      End
      Else If Sysutils.SameText(Sender.FieldName, 'UnitofMeasureQtySold') Then Begin

        If Not RawMode Then Begin
          { Get actual qty sold based on input UOMQtySold. }
          QtySold := Round(UOMQtySold * UOMMultiplier, RoundPlacesGeneral);
          If CheckFordiscontinuedProduct And (Qtysold = 0) Then Exit;
          If (IsRelatedProduct) And (Not ImportingFromXMLFile) And (Not(Self.Classnameis('TQuoteLine'))) Then
          Else SetDefaultQtyShipped;
          { Calc new back order qty }
          QtyBackOrder    := Round(QtySold - QtyShipped, RoundPlacesGeneral);
          UOMQtyBackOrder := Round(DivZer(QtyBackOrder, UOMMultiplier), RoundPLacesGeneral);
          { Binny :converting transactions should not change the price if already given }
          If (Self.Lineprice <> 0) And (Assigned(Self.Owner)) And (Self.Owner Is TSalesOrder) And (TSalesOrder(Self.Owner).ConvertingQuote) Then
          Else If (Self.Lineprice <> 0) And (Assigned(Self.Owner)) And (Self.Owner Is TInvoice) And (TInvoice(Self.Owner).ConvertingSO) Then
          Else If (Self.Lineprice <> 0) And (Assigned(Self.Owner)) And (Self.Owner Is TInvoice) And (TInvoice(Self.Owner).ConvertingRepairs) Then
          Else If (Self.Lineprice <> 0) And (Assigned(Self.Owner)) And (Self.Owner Is TInvoice) And (TInvoice(Self.Owner).ConvertingHire) Then
          Else If (Self.Lineprice <> 0) And (Assigned(Self.Owner)) And (Self.Owner Is TInvoice) And (TInvoice(Self.Owner).ConvertingQuote) Then
          Else Begin
            If Not IsCreatingBoRec Then Begin
              Self.GetBaseLinePrice; { Calculate new cost based on new quantity. }
              CalcLineTotals; { Recalculate line totals }
            End;
          End;
          { Product Specification calculations }
          If AppEnv.CompanyPrefs.UseProductSpecsCalcsSales Then Begin
            If Product.ProductSpecs.LocateSpecID(Self.PartSpecID) Then Begin
              If (Self.UOMQtySold <> 0.00) And IsNumeric(Product.ProductSpecs.SpecValue) Then Begin
                Self.SpecValue := FloatToStr(Round(DivZer(Self.UOMQtySold, Self.UOMMultiplier) * StringToFloat(Product.ProductSpecs.SpecValue), Self.RoundPlacesGeneral));
              End;
            End;
          End;

          GlobalEvents.Notify(Sender, GEVENT_OnChange_After);
          // Vars.Values.ByName['QtySoldChanged'].asBoolean := true;
          // { now need to cause a post so the QtySoldChanged var is acted on }
          // EditDB;
          // PostDB;
          AddEvent(BusObjEvent_Change, BusObjEventVal_QtySold, Self.ID);

          (* SendEvent(BusObjEvent_Change, BusObjEventVal_QtySold);
            Editdb; *)
          If Assigned(Owner) And (Owner Is TSales) Then TSales(Owner).DoCalcOrderTotals;
          AddEvent(BusObjEvent_Change, BusObjEventVal_OrderTotalsCalculated, Self.ID);

          /// /{if not InternalQuantityChange then }DoContainerEvent(Self, evSalesLineQtyChange);
        End;
      End
      Else If Sysutils.SameText(Sender.FieldName, 'UnitofMeasureShipped') Then Begin
        If Not RawMode Then Begin
          ShipedQtyChanged;
          { if not InternalQuantityChange then } DoContainerEvent(Self, EvSalesLineQtyChange);
          // Vars.Values.ByName['QtySoldChanged'].asBoolean := true;
          AddEvent(BusObjEvent_Change, BusObjEventVal_QtySold, Self.ID);
        End;
      End
      Else If Sysutils.SameText(Sender.FieldName, 'Shipped') Then Begin
        If Not RawMode Then Begin
          If Self.QtyShipped > Self.QtySold Then Begin
            ResultStatus.Additem(True, RssInfo, 0, 'Can''t ship a greater quantity than ordered, quantity shipped changed to match quantity ordered!', False);
            AddEvent(BusObjEvent_Error, BusObjEventVal_Warn, Self.ID);
            Self.QtyShipped                                      := Self.QtySold;
            If FormulaQtySoldValue <> 0 Then FormulaQtySoldValue := 0;
          End;

          // convert
          UOMQtyShipped := Round(DivZer(QtyShipped, UOMMultiplier), RoundPlacesGeneral);

          // calc new back order qty
          QtyBackOrder    := Round(QtySold - QtyShipped, Self.RoundPlacesGeneral);
          UOMQtyBackOrder := Round(DivZer(QtyBackOrder, UOMMultiplier), Self.RoundPlacesGeneral);

          If (AppEnv.CompanyPrefs.RecalcCostInvBO) Then Begin
            GetBaseLineCost;
          End;

          Self.LineCostInc := Round(GetAmountInc(LineCost, LineTaxRate), RoundPlacesGeneral);

          { This bit updates the Attrib1/2/3 fields, ie for plaster boards,
            cartons of beer, bulk-buy ear diggers etc }
          Self.Attrib1Sale     := Self.Product.Attrib1Sale * Self.QtyShipped;
          Self.Attrib2Sale     := Self.Product.Attrib2Sale * Self.QtyShipped;
          Self.Attrib1SaleRate := Self.Product.Attrib1SaleRate;
          Self.Attrib1SaleEst  := Self.Product.Attrib1Sale * Self.QtySold;
          Self.Attrib2SaleEst  := Self.Product.Attrib2Sale * Self.QtySold;

          // re calc totals
          CalcLineTotals;
          POstDb;
          AddEvent(BusObjEvent_Change, BusObjEventVal_QtyShipped, Self.ID);
          // Vars.Values.ByName['QtySoldChanged'].asBoolean := true;
          AddEvent(BusObjEvent_Change, BusObjEventVal_QtySold, Self.ID);
          { if not InternalQuantityChange then } DoContainerEvent(Self, EvSalesLineQtyChange);
        End;
      End
      Else If Sysutils.SameText(Sender.FieldName, 'LinePrice') Then Begin
        If Not RawMode Then Begin

          { User has entered a new line price (ex) so assume this is the final
            sell price ie no further discounts/markups }

          If Not(FbAddingRelatedProducts Or FbProductIDChanging Or FbProductNameChanging) Then CheckSaveSpecialPrice;

          Self.OriginalLinePrice := Self.LinePrice;
          Self.DiscountAmount    := 0;
          Self.DiscountPercent   := 0;
          Self.MarkupAmount      := 0;
          Self.MarkupPercent     := 0;

          If TSales(Self.Owner).ForeignExchangeRate <> 0 Then Begin
            Self.ForeignLinePrice := CommonLib.LocalToForeign(Self.LinePriceinc, TSales(Self.Owner).ForeignExchangeRate, Self.RoundPlacesGeneral);
          End;

          Self.CalcLineTotals;
        End;
      End Else If Sysutils.SameText(Sender.FieldName, 'LinePriceInc') Then Begin
        If Not RawMode Then Begin
          DiscountPercent := 0;
          { User has entered a new line price (inc) so assume this is the final
            sell price ie no further discounts/markups }

          { Calculate price ex from price inc }
          Self.LinePrice         := Self.LinePriceInc * (1 / (1 + Self.LineTaxRate));
          Self.OriginalLinePrice := Self.LinePrice;

          If Not(FbAddingRelatedProducts Or FbProductIDChanging Or FbProductNameChanging) Then CheckSaveSpecialPrice;

          { re-calculate foreign amount }
          If TSales(Self.Owner).ForeignExchangeRate <> 0 Then Begin
            Self.ForeignLinePrice := CommonLib.LocalToForeign(Self.LinePriceinc, TSales(Self.Owner).ForeignExchangeRate, Self.RoundPlacesGeneral);
          End;

          Self.CalcLineTotals;
        End;
      End
      Else If Sysutils.SameText(Sender.FieldName, 'OrgLinePrice') Then Begin
        MarginPercent := 0;
        Marginamount:= 0;
        If Not RawMode Then Begin
          Self.CalcLineTotals;
        End;
      End
      Else If Sysutils.SameText(Sender.FieldName, 'ForeignCurrencyLinePrice') Then Begin
        If Not RawMode Then Begin
          If AppEnv.CompanyPrefs.UseForeignCurrencyOnSales Then Begin

            // should we use hedging with this product
            If Product.UseHedgingFormula Then Begin

              HedgedForeignPrice := GetAmountEx(TSales(Owner).FXObj.GetHedgedAmountForRate(ForeignLinePrice, TSales(Owner).ForeignExchangeCode, TSales(Owner).ForeignExchangeRate), LineTaxRate);

              Self.OriginalLinePrice := ForeignToLocal(HedgedForeignPrice, TSales(Owner).ForeignExchangeRate, RoundPlacesGeneral);
            End Else Begin
              Self.OriginalLinePrice := GetAmountEx(ForeignToLocal(ForeignLinePrice, TSales(Owner).ForeignExchangeRate, RoundPlacesGeneral), LineTaxRate);
            End;

            Self.CalcLineTotals;

          End;
        End;
      End
      Else If Sysutils.SameText(Sender.FieldName, 'SpecDescription') Then Begin

        If AppEnv.CompanyPrefs.UseProductSpecsCalcsSales Then Begin
          If Product.ProductSpecs.LocateSpecDescription(Self.SpecDescription) Then Begin
            Self.PartSpecID := Product.ProductSpecs.PartSpecID;
            If Not RawMode Then Begin
              If (UOMQtySold <> 0) And IsNumeric(Product.ProductSpecs.SpecValue) Then
                  Self.SpecValue := FloatToStr(Round(DivZer(UOMQtySold, UOMMultiplier) * StrToFloat(Product.ProductSpecs.SpecValue), RoundPlacesGeneral));
            End;
          End;
        End;

      End
      Else If Sysutils.SameText(Sender.FieldName, 'SpecValue') Then Begin
        If Not RawMode Then Begin

          If AppEnv.CompanyPrefs.UseProductSpecsCalcsSales Then Begin
            If Product.ProductSpecs.LocateSpecID(PartSpecID) Then Begin
              If Product.ProductSpecs.IsMultiplier And (SpecValue <> '') And IsNumeric(SpecValue) And IsNumeric(Product.ProductSpecs.SpecValue) Then Begin
                Self.UOMQtySold := Round(DivZer(StrToFloat(SpecValue), StrToFloat(Product.ProductSpecs.SpecValue)) * UOMMultiplier, RoundPlacesGeneral);

                { Get actual qty sold based on input UOMQtySold. }
                QtySold := Round(UOMQtySold * UOMMultiplier, RoundPlacesGeneral);

                If (IsRelatedProduct) And (Not ImportingFromXMLFile) Then
                Else SetDefaultQtyShipped;

                { Calc new back order qty }
                QtyBackOrder    := Round(QtySold - QtyShipped, RoundPlacesGeneral);
                UOMQtyBackOrder := Round(DivZer(QtyBackOrder, UOMMultiplier), RoundPlacesGeneral);

                { Calculate new cost based on new quantity. }
                Self.GetBaseLinePrice;

                { Recalculate line totals }
                CalcLineTotals;
              End;
            End;

          End;
        End;
      End
      Else If Sysutils.SameText(Sender.FieldName, 'UnitofMeasureSaleLines') Then Begin
        If Not IsCreatingBoRec Then Begin
          Self.GetBaseLinePrice; { Calculate new cost based on new quantity. }
          CalcLineTotals; { Recalculate line totals }
        End;
        If Not RawMode Then Begin
          DoContainerEvent(Self, EvSalesLineUOMChange);
        End;
      End;
    Finally
      if (Sysutils.SameText(Sender.FieldName, 'LineTax') and
        not(samevalue(TSalesLineBase(Self).TotalLineamountinc , TSalesOrderLine(Self).TotalLineamount+TSalesOrderLine(Self).LineTaxtotal))) then
        TSalesLineBase(Self).CalcLineTotals;
      If ((FdOldTot <> TotalLineamount) Or
          (FdOldTotInc <> TotalLineamountInc)) Or
          (Sysutils.SameText(Sender.FieldName, 'LineTax') and not(samevalue(TSalesOrderLine(Self).TotalLineamountinc , TSalesOrderLine(Self).TotalLineamount+TSalesOrderLine(Self).LineTaxtotal))) OR
          Sysutils.SameText(Sender.FieldName, 'UnitofMeasureShipped') Then
        If Not RawMode Then Begin
          if not updatingRelPrQty then TSales(Owner).DoCalcOrderTotals;
        End;
    End;
  Finally LogD('', LbEnd);
  End;
End;

Procedure TSalesLine.ShipedQtyChanged;
Begin
  LogD('TSalesLine.ShipedQtyChanged', LbBegin);
  Try

    If Assigned(Owner) And (Owner Is TSales) Then
      If ((UOMQtyShipped > 0) And (UOMQtySold < 0)) Or ((UOMQtyShipped < 0) And (UOMQtySold > 0)) Then Begin
        ResultStatus.AddItem(False, RssWarning, 0, 'Both Quantity Ordered and shipped should be either positive or negative');
        // set quantity down to equal shipped
        UOMQtyShipped := 0;
        DoFieldOnChange(Self.Dataset.FieldByName('UnitofMeasureShipped'));
      End;

    // if self.UOMQtyShipped > self.UOMQtySold then    begin
    If Abs(Self.UOMQtyShipped) > Abs(Self.UOMQtySold) Then Begin
      ResultStatus.Additem(True, RssInfo, 0, 'Can''t ship a greater quantity than ordered, shipped quantity changed to match ordered quantity!', False);
      AddEvent(BusObjEvent_Error, BusObjEventVal_Warn, Self.ID);
      Self.UOMQtyShipped := Self.UOMQtySold;
      PostDb;
    End;

    If Not ISoktoShip Then Exit;

    // if the qtyshipped is not 0, clac the UOMqtyshipped
    If UOMQtyShipped <> 0 Then Begin
      If Abs(UOMQtyShipped) <= Abs(UOMQtySold) Then QtyShipped := CommonLib.Round(UOMQtyShipped * UOMMultiplier, Self.RoundPlacesGeneral);
    End
    Else QtyShipped := 0;
    // calc new back order qty

    { Changed to calc UOM first to avoid round in issues }
    UOMQtyBackOrder := Round(UOMQtySold - UOMQtyShipped, RoundPlacesGeneral);
    QtyBackOrder :=  Round(UOMQtyBackOrder * UOMMultiplier, RoundPlacesGeneral);

    // if self.UOMQtyShipped > self.UOMQtySold then    begin
    If Abs(Self.UOMQtyShipped) > Abs(Self.UOMQtySold) Then Begin
      Self.UOMQtyShipped := Self.UOMQtySold;
    End;

    If (AppEnv.CompanyPrefs.RecalcCostInvBO) Then Begin
      GetBaseLineCost;
      if UOMQtyShipped <> 0 then
        GetBaseLinePrice;
    End;
    Self.LineCostInc := Round(GetAmountInc(LineCost, LineTaxRate), RoundPlacesGeneral);

    { This bit updates the Attrib1/2/3 fields, ie for plaster boards,
      cartons of beer, bulk-buy ear diggers etc }
    Self.Attrib1Sale     := Self.Product.Attrib1Sale * Self.QtyShipped;
    Self.Attrib2Sale     := Self.Product.Attrib2Sale * Self.QtyShipped;
    Self.Attrib1SaleRate := Self.Product.Attrib1SaleRate;
    Self.Attrib1SaleEst  := Self.Product.Attrib1Sale * Self.QtySold;
    Self.Attrib2SaleEst  := Self.Product.Attrib2Sale * Self.QtySold;
    PostDb;
    AddEvent(BusObjEvent_Change, BusObjEventVal_QtyShipped, Self.ID);
    //SendEvent(BusObjEvent_Change, BusObjEventVal_QtyShipped);

    // re calc totals
    CalcLineTotals;
  Finally LogD('', LbEnd);
  End;
End;

Procedure TSalesLine.GetProductDetails;
Begin
  (* inherited; *)
  LogD('TSalesLine.GetProductDetails', LbBegin);
  Try
    Inherited;

    If AppEnv.CompanyPrefs.UseForeignCurrencyonPO And Product.UseHedgingFormula Then Self.ForeignHedgingUsed := True
    Else Self.ForeignHedgingUsed                                                                             := False;

  Finally LogD('', LbEnd);
  End;
End;

function TSalesLine.getSalesLinePackWeight: TSalesLinePackWeightLines;
begin
  Result := TSalesLinePackWeightLines(Getcontainercomponent(TSalesLinePackWeightLines, 'SaleLineID = ' + IntToStr(ID), True, True));
end;

function TSalesLine.getSalesLinePackWeightSum: TSalesLinePackWeightLinesSum;
begin
  Tsales(Owner).SalesLinePackWeightSum.locate('SaleLineID' , ID , []);
  REsult :=Tsales(Owner).SalesLinePackWeightSum;
end;

Procedure TSalesLine.AfterCloneBusObj;
Begin
  Inherited;
  If Assigned(ObjInstanceToClone) And (ObjInstanceToClone Is TSalesLine) Then Begin
    TSalesLine(ObjInstanceToClone).TransDate := TSales(ObjInstanceToClone.Owner).SaleDateTime;
    TSalesLine(ObjInstanceToClone).PostDB;
  End;

End;

Procedure TSalesLine.CalcLineTotals;
Begin
  LogD('TSalesLine.CalcLineTotals', LbBegin);
  Try
    If Self.Id = 0 Then Exit;
    Inherited;
  Finally LogD('', LbEnd);
  End;
End;
Procedure TSalesLine.SetDefaultQtyShipped;
Var
  FdAvailQty: Double;
Begin
  LogD('TSalesLine.SetDefaultQtyShipped', LbBegin);
  Try
    If ((*ConvertingQuote Or ConvertingSO Or *)ConvertingRepairs  Or ConvertingHire) Then Exit;
    If (Self Is TSalesOrderLine) And IsTreeItem and (Appenv.CompanyPrefs.EnableBoinBOMsalesOrder = False ) then begin
      Self.QtyShipped    := Qtysold;
      Self.UOMQtyShipped := UOMQtySold;
      Exit;
    end;
    { if SalesOrder and Preference 'Single Qty Sales Order' then don't chek availability }
    If (Self Is TSalesOrderLine) And (AppEnv.CompanyPrefs.SingleQtySO) And (Not AppEnv.CompanyPrefs.BOByDefaultOnSO) Then Begin
      Self.QtyShipped    := Self.QtySold;
      Self.UOMQtyShipped := Round(DivZer(QtyShipped, UOMMultiplier), RoundPlacesGeneral);
      PostDb;
      AddEvent(BusObjEvent_Change, BusObjEventVal_QtyShipped, Self.ID);
    End;

    { If Shipped is zero then default to same as ordered (if Available). }
         If ((Self Is TSalesOrderLine) And (AppEnv.CompanyPrefs.SingleQtySO)) Then
    Else If ((Self Is TInvoiceLine) And ConvertingSO And AppEnv.CompanyPrefs.SingleQtySO) and not(AppEnv.CompanyPrefs.SoToInvShipWhenAvailable) Then
    Else If (Self Is TInvoiceLine) And (Self.ConvertingRepairs) And (Self.ConvertingHire) Then
    else If ((Self Is TSalesOrderLine) And (AppEnv.CompanyPrefs.BOByDefaultOnSO)) then begin
      Self.QtyShipped    := 0;
      Self.UOMQtyShipped := 0;
    end else If not(ConvertingSO) and ((Self Is TInvoiceLine) And (AppEnv.CompanyPrefs.BOByDefaultOnInvoice)) Then begin
      Self.QtyShipped    := 0;
      Self.UOMQtyShipped := 0;
    end Else begin
      FdAvailQty := TProductClass.AvailableQty(ProductID, TSales(Self.Owner).SaleClassId) + CleanQty;
      If (Self Is TInvoiceLine) And ConvertingSO then FdAvailQty  := FdAvailQty  +  Self.QtyShipped ;// to add the current SO qty
      If FdAvailQty > 0 Then Begin
        If FdAvailQty >= Self.QtySold Then Begin
          Self.QtyShipped := Self.QtySold;
          PostDb;
          AddEvent(BusObjEvent_Change, BusObjEventVal_QtyShipped, Self.ID);
        End Else Begin
          If (FdAvailQty <> Self.QtyShipped) And (FdAvailQty <> CleanQty) Then Begin
            Self.QtyShipped := FdAvailQty;
            PostDb;
            AddEvent(BusObjEvent_Change, BusObjEventVal_QtyShipped, Self.ID);
            if not fbAddingRelatedProducts then SendEvent(BusobjEvent_ToDo, busobjeventval_checkforStockinOtherDept);
          End;
        End;
      end else begin
        Self.QtyShipped := 0;
        PostDb;
        if not fbAddingRelatedProducts then SendEvent(BusobjEvent_ToDo, busobjeventval_checkforStockinOtherDept);
      End;
      { Convert to user qty amount. }
      Self.UOMQtyShipped := Round(DivZer(QtyShipped, UOMMultiplier), RoundPlacesGeneral);
      { if not InternalQuantityChange then } DoContainerEvent(Self, EvSalesLineQtyChange);
    if ConvertingSO then begin
       if Self.QtyShipped <> Self.QtySold then begin
        Qtybackorder := Self.QtySold-Self.QtyShipped;
        Self.UOMQtybackorder := Round(DivZer(Qtybackorder, UOMMultiplier), RoundPlacesGeneral);
       end;
    end;
    End;
  Finally LogD('', LbEnd);
  End;
End;

Function TSalesLine.ValidateData: Boolean;
Begin
  LogD('TSalesLine.ValidateData', LbBegin);
  Try
    Result := Inherited ValidateData;
    If Not Result Then Exit;
    if not (self is TVoucherInvoiceLine ) then begin
      If AppEnv.CompanyPrefs.SalesWarrantyEndsOnRequired Then
        If WarrantyEndsOn = 0 Then Begin
          Result := False;
          SendEvent(BusobjEvent_ToDo, BusobjEvent_ShowCustomizableInvocieDatefield);
          ResultStatus.AddItem(False, RssWarning, 0, Trim(AppEnv.CompanyPrefs.SalesWarrantyEndsOnCaption) + ' Should not Be Blank');
          Exit;
        End;
      If AppEnv.CompanyPrefs.SalesWarrantyPeriodRequired Then
        If WarrantyPeriod = '' Then Begin
          Result := False;
          SendEvent(BusobjEvent_ToDo, BusobjEvent_ShowCustomizableInvocieTextfield);
          ResultStatus.AddItem(False, RssWarning, 0, Trim(AppEnv.CompanyPrefs.SalesWarrantyPeriodCaption) + ' Should not Be Blank');
          Exit;
        End;
    end;
    Delete0QtyshipmentLines;
  Finally LogD('', LbEnd);
  End;
End;

Function TSalesLine.Delete0QtyshipmentLines: Boolean;
Begin
  Result := True;
End;

Function TSalesLine.GetId: Integer;
Begin
  Result := SaleLineId;
End;

Function TSalesLine.GetSQL: String;
Begin
  Result := Inherited GetSQL;
End;

Function TSalesLine.GetCalcProfit: Double;
Begin
  Result                                                := 0;
  If Dataset.Findfield('CalcProfit') <> Nil Then Result := GetFloatfield('CalcProfit');
End;

Procedure TSalesLine.SetCalcProfit(Const Value: Double);
Begin
  If Dataset.Findfield('CalcProfit') <> Nil Then Setfloatfield('CalcProfit', Value);
End;

Function TSalesLine.GetCalcProfitPercent: Double;
Begin
  Result                                                       := 0;
  If Dataset.Findfield('CalcProfitPercent') <> Nil Then Result := GetFloatfield('CalcProfitPercent');
End;

Procedure TSalesLine.SetCalcProfitPercent(Const Value: Double);
Begin
  If Dataset.Findfield('CalcProfitPercent') <> Nil Then Setfloatfield('CalcProfitPercent', Value);
End;

Function TSalesLine.GetCalcProfitPercentEx: Double;
Begin
  Result                                                         := 0;
  If Dataset.Findfield('CalcProfitPercentEx') <> Nil Then Result := GetFloatfield('CalcProfitPercentEx');
End;

function TSalesLine.getConvertCurrent: Boolean;
begin
  REsult := false;
  if Assigned(owner) and (Owner is TSaleS) then
    Result := TSales(Owner).ConvertCurrent;
end;

Procedure TSalesLine.SetCalcProfitPercentEx(Const Value: Double);
Begin
  If Dataset.Findfield('CalcProfitPercentEx') <> Nil Then Setfloatfield('CalcProfitPercentEx', Value);
End;

Function TSalesLine.GetCalcProfitEx: Double;
Begin
  Result                                                  := 0;
  If Dataset.Findfield('CalcProfitEx') <> Nil Then Result := GetFloatfield('CalcProfitEx');
End;

Procedure TSalesLine.SetCalcProfitEx(Const Value: Double);
Begin
  If Dataset.Findfield('CalcProfitEx') <> Nil Then Setfloatfield('CalcProfitEx', Value);
End;
{ called when user changes the price, asks/saves customers special price }

Function TSalesLine.DoNewRecord(Sender: TDatasetBusObj): Boolean;
Var
  ISaleId: Integer;
  StrSQL : String;
Begin
  LogD('TSalesLine.DoNewRecord', LbBegin);
  Try
    Result := True;
    If Not Assigned(Self.Owner) Then Exit;
    If Not(Self.Owner Is TSales) Then Exit;
    If Not Eof Then Begin
      ISaleId := TSales(Self.Owner).ID;
      StrSQL  := 'update tblSaleslines ' + ' set SortID = SortId + 10 where SaleId = ' + IntToStr(ISAleID) + ' and SortId >= ' + IntToStr(FiSortID) + ';' + 'update tblSaleslines ' +
        ' set LinesOrder = LinesOrder + 10 where SaleId = ' + IntToStr(ISAleID) + ' and LinesOrder >= ' + IntToStr(FiLinesOrder);
      GetNewDataset(StrSQL, True);
    End Else Begin
      FiSortId     := FiSortId + 10;
      FiLinesOrder := FiLinesOrder + 10;
    End;
    If FiSortId = 0 Then FiSortId         := FiSortId + 10;
    If FiLinesOrder = 0 Then FiLinesOrder := FiLinesOrder + 10;
  Finally LogD('', LbEnd);
  End;
End;

Function TSalesLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
Begin
  LogD('TSalesLine.DoAfterInsert', LbBegin);
  Try
    Inherited DoAfterInsert(Sender);
    IsRelatedProduct                                          := False;
    ParentProductID                                           := 0;
    If Assigned(Owner) And (Owner Is TSales) Then Self.SaleId := TSales(Owner).SaleId;
    IsQuote                                                   := Self Is TQuoteLine;
    Result                                                    := True;
  Finally LogD('', LbEnd);
  End;
  BOMGroupedLine    := False;
  BOMProductionLine := False;
  UpdateLinesRefNo;
End;
Procedure TSalesLine.UpdateLinesRefNo;
begin
  if Assigned(Owner) then
    if Owner is TSales then
      if TSales(Owner).DefaultReferenceNoinAllLines and (TSales(Owner).ReferenceNo<> '') then begin
        ReferenceNo := TSales(Owner).ReferenceNo;
      end;
end;
Function TSalesLine.ValidateXMLData(Const Node: IXMLNode): Boolean;
Var
  FiCostCentreId   : Integer;
  FiProductID      : Integer;
  FiPartSpecID     : Integer;
  FiParentProductID: Integer;
Begin
  LogD('TSalesLine.ValidateXMLData', LbBegin);
  Try
    Result := Inherited ValidateXMLData(Node);

    If Not Result Then Exit;
    If Not ImportingFromXMLFile Then Exit;

    If GetXMLNodeIntegerValue(Node, 'ImportingID') <> 0 Then XMLSearchRecorddesc := IDFieldName + ' =' + IntToStr(GetXMLNodeIntegerValue(Node, 'ImportingID'))
    Else XMLSearchRecorddESC                                                     := IDFieldName + ' =' + IntToStr(GetXMLNodeIntegerValue(Node, IDTagInXML));
    Result                                                                       := False;

    FiProductID := 0;

    If GetXMLNodeStringValue(Node, 'CostCentre') <> '' Then Begin
      FicostCentreId := TcDatautils.GetCostCentreID(GetXMLNodeStringValue(Node, 'CostCentre'));
      If FicostCentreId = 0 Then Begin
        ErrRecordNotfound('CostCentre', GetXMLNodeStringValue(Node, 'CostCentre'));
        Exit;
      End;
    End;
    If GetXMLNodeStringValue(Node, 'ProductName') <> '' Then Begin
      FiProductID := TcDatautils.GetProduct(GetXMLNodeStringValue(Node, 'ProductName'));
      If FiProductID = 0 Then Begin
        ErrRecordNotfound('ProductName', GetXMLNodeStringValue(Node, 'ProductName'));
        Exit;
      End;
    End;
    If GetXMLNodeStringValue(Node, 'SpecDescription') <> '' Then Begin
      FiPartSpecID := TcDatautils.GetPartSpecID(FiProductID, GetXMLNodeStringValue(Node, 'SpecDescription'));
      If FiPartSpecID = 0 Then Begin
        ErrRecordNotfound('SpecDescription', GetXMLNodeStringValue(Node, 'SpecDescription'));
        Exit;
      End;
    End;
    If GetXMLNodeStringValue(Node, 'ParentProductName') <> '' Then Begin
      FiParentProductID := TcDatautils.GetProduct(GetXMLNodeStringValue(Node, 'ParentProductName'));
      If FiParentProductID = 0 Then Begin
        ErrRecordNotfound('ParentProduct', GetXMLNodeStringValue(Node, 'ParentProductName'));
        Exit;
      End;
    End;
    Result := True;
    { for the transaction records , the id should exists if its a modification transaction }
    { search on the globalref if exists, otherwise on Id }
    If GetXMLNodeStringValue(Node, 'Globalref') <> '' Then XMLSearchRecord := 'globalref = ' + QuotedStr(GetXMLNodeStringValue(Node, 'Globalref'))
    Else XMLSearchRecord                                                   := 'SaleLineId =' + IntToStr(GetXMLNodeIntegerValue(Node, 'SaleLineId'));
    LocateXMLRecord;
  Finally LogD('', LbEnd);
  End;
End;

Procedure TSalesLine.LoadFromXMLNode(Const Node: IXMLNode);
Begin
  SetPropertyFromNode(Node, 'WarrantyPeriod');
  SetPropertyFromNode(Node, 'Equipment');
  SetPropertyFromNode(Node, 'CustomerEquipmentID');
  SetDateTimePropertyFromNode(Node, 'WarrantyEndsOn');
  SetBooleanPropertyFromNode(Node, 'BOMGroupedLine');
  SetBooleanPropertyFromNode(Node, 'BOMProductionLine');
  SetPropertyFromNode(Node, 'BOMComments');
  SetPropertyFromNode(Node, 'ReferenceNo');
  Inherited;
End;

Procedure TSalesLine.SaveToXMLNode(Const Node: IXMLNode);
Begin
  Inherited;
  AddXMLNode(Node, 'WarrantyPeriod', WarrantyPeriod);
  AddXMLNode(Node, 'CustomerEquipmentID', CustomerEquipmentID);
  AddXMLNode(Node, 'Equipment', Equipment);
  AddXMLNode(Node, 'WarrantyEndsOn', WarrantyEndsOn);
  AddXMLNode(Node, 'BOMGroupedLine', BOMGroupedLine);
  AddXMLNode(Node, 'BOMProductionLine', BOMProductionLine);
  AddXMLNode(Node, 'BOMComments', BOMComments);
  AddXMLNode(Node, 'ReferenceNo', ReferenceNo);
End;

Function TSalesLine.Save: Boolean;
Begin
  Result := Inherited Save;
  If Not Result Then Exit;
End;

Procedure TSalesLine.CalculateLine;
Begin
  Self.GetBaseLinePrice;
  Self.CalcLineTotals;
End;

Function TSalesLine.CanLockManifest: Boolean;
Var
  S: String;
Begin
  REsult := True;
  If Id = 0 Then Exit;
  If Manifestline.Count = 0 Then Exit;

  If Not(USErlock.Lock('tblmanifest', Self.Manifestline.ManifestID)) Then Begin
    S := USErlock.LockMessage;
    S := ReplaceStr(S, 'Unable to update data.', 'Unable to delete ' + ProductName + '.');
    S := ReplaceStr(S, 'this record', 'its manifest record #' + Inttostr(ManifestLine.ManifestID));
    ResultStatus.AddItem(False, RssWarning, 0, S, True);
    Result := False;
    Exit;
  End;
End;

Procedure TSalesLine.CreateInstance;
Begin
  If Owner Is TSales Then
    If Assigned(TSales(Owner).ObjInstanceToClone) Then
      If TSales(Owner).ObjInstanceToClone Is TSalesBase Then ObjInstanceToClone    := TSalesBase(TSales(Owner).ObjInstanceToClone).Lines
      Else If TSales(Owner).ObjInstanceToClone Is TRepairs Then ObjInstanceToClone := TRepairs(TSales(Owner).ObjInstanceToClone).RepairParts
End;

(* function TSalesLine.CustomermainShipAddressID: Integer;
  begin
  REsult:= 0;
  if Assigned(Owner) then
  if owner is Tsales then
  REsult := Tsales(Owner).Customer.CustomerPhysicalAddressshipAddressID;
  end; *)

(* function TSalesLine.CustomerName: String;
  begin
  REsult:= '';
  if Assigned(Owner) then
  if owner is Tsales then
  REsult := Tsales(Owner).Customer.clientName;

  end; *)

Function TSalesLine.DoBeforePost(Sender: TDatasetBusObj): Boolean;
Begin
  LogD('TSalesLine.DoBeforePost', LbBegin);
  Try
    FbNew := Dataset.State = DsInsert;
    If Not SilentMode Then Begin
      If (* (not DatasetPosting) and *) (ProductId = 0) And ((ProductName = '') Or (TProduct.IDToggle(ProductName, Connection.Connection) = 0)) Then Begin
        Deleted := True;
        Result  := True;
        Exit;
      End;
    End;
    Result := True;
  Finally LogD('', LbEnd);
  End;
End;
Function TSalesLine.ProductHasProcess: Boolean;
Var
  Qry:TERPQuery;
Begin
  qry := DbSharedObj.GetQuery(connection.Connection);
  try
      commondblib.closedb(Qry);
      Qry.SQL.text := 'Select  PT.proctreeId from tblproctree PT where PT.MasterId =  ' +    IntToStr(ProductId) + '  and PT.mastertype ="mtProduct" and ifnull(PT.ParentId , 0)=0';
      commondblib.opendb(Qry);
      Result := Qry.Recordcount > 0;
  Finally
      DbSharedObj.ReleaseObj(Qry);
  End;
End;
Procedure TSalesLine.DoContainerEvent(Const Sender: TObject; Const EventType: Integer; Const Data: TObject=nil; Proc : TProcBusObjBase= nil);
Begin
  If Id > 0 then begin
(*    if Assigned(self.CloneSource) and self.CloneSource.Container.Exists(TSaleslineProctree) then
      InstantiateTree(true);*)
      InstantiateTree((Eventtype = evSalesLineProductChange) and ProductHasProcess(*(EventType <> evSalesLinecheckForTree) and (eventtype <> EvSalesLineClonePropertyObjects) and (eventtype <> evSalesLineAfterGetBaseLineCost) and (eventtype <> EvSalesLineQtyChange)*));
  end;
  Inherited DoContainerEvent(Sender, Eventtype, Data, Proc);
End;

Function TSalesLine.DoAfterPost(Sender: TDatasetBusObj): Boolean;
Begin
  Result := Inherited DoAfterPost(Sender);
  If Not Result Then Exit;
End;

Procedure TSalesLine.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
Begin
  LogD('TSalesLine.OnDataIdChange', LbBegin);
  Try
    Inherited OnDataIdChange(ChangeType);
    If ChangeType = DcNew Then Begin
      Dataset.FieldByname('unitofmeasureQtySold').Readonly   := False;
      Dataset.FieldByname('unitofmeasureSaleLines').Readonly := False;
    End;
  Finally LogD('', LbEnd);
  End;
End;

Function TSalesLine.GetCurrentBackOrderId(Var ErrMsg: String; Var Editable: Boolean; Var SaleLineId: Integer): Integer;
Var
  IId   : Integer;
  StrSQL: String;
Begin
  LogD('TSalesLine.getCurrentBackOrderId', LbBegin);
  Try
    ErrMsg   := '';
    Editable := False;
    { The functionality is only for Purchase order and the object expects to
      have a PurchaseOrder which owns the lines. }
    If Not(Self.Owner Is Tsales) Then Begin
      ErrMsg   := 'Not a Invoice/Sales order';
      Editable := False;
      Result   := 0;
      Exit;
    End;
    { if BOID is blank, there is no back order and the current PO is editable for the qty
      This is when the shipmnet was made completely }
    If Trim(Tsales(Self.Owner).GetBackOrderGlobalRef) = '' Then Begin
      Editable := True;
      Result   := Tsales(Self.Owner).ID;
      Exit;
    End;
    StrSQL                         := 'Select Max(SaleLineID) as SaleLineID ' + 'from tblSaleslines ';
    If Baselineno <> 0 Then StrSQL := StrSQL + 'where baselineno = ' + IntToStr(BaselineNo)
    Else StrSQL                    := StrSQL + 'where baselineno = ' + IntToStr(Self.ID);
    With GetNewDataset(StrSQL, True) Do
      Try
        If Recordcount = 0 Then Begin
          Editable := True;
          Result   := Tsales(Self.Owner).ID;
          Exit;
        End;
        If FieldByname('SaleLineID').AsInteger = Self.Id Then Begin
          Editable := True;
          Result   := Tsales(Self.Owner).ID;
          Exit;
        End;
        Iid := FieldByname('SaleLineID').AsInteger;
      Finally
        If Active Then Close;
        Free;
      End;
    StrSQL := 'Select SaleID, SaleLineID, QtySold, backorder, shipped ' + 'from tblSalesLines where SaleLineID= ' + IntToStr(Iid);
    With GetnewDataset(StrSQL, TRue) Do
      Try
        If FieldByname('QtySold').AsFloat = FieldByname('Shipped').AsFloat Then Begin
          ErrMsg     := 'The shipment of this product is completed, so cannot modify the quantity';
          Editable   := False;
          Result     := FieldByname('SaleID').AsInteger;
          SaleLineId := FieldByname('SaleLineID').AsInteger;
          Exit;
        End;
        Result     := FieldByname('SaleID').AsInteger;
        SaleLineId := FieldByname('SaleLineID').AsInteger;
        Editable   := True;
      Finally
        If Active Then Close;
        Free;
      End;
  Finally LogD('', LbEnd);
  End;
End;

Procedure TSalesLine.ChangeOrderQty;
Var
  FOrgNo      : String;
  StrSQL      : String;
  StrSQLUpdate: String;
Begin
  LogD('TSalesLine.ChangeOrderQty', LbBegin);
  Try
    FOrgNo := '';
    If (Baselineno = 0) Or ((CleanQtytotal = Qtysold) And (Deleted = False)) Or (CleanQtytotal = 0) Then Exit;

    If Assigned(Self.Owner) And (Self.Owner Is TSales) Then FOrgNo := TSales(Self.Owner).OriginalDocNumber
    Else
      With GetNewDataset('Select OriginalNo from tblSales where SaleID = ' + IntToStr(HeaderId)) Do
        Try
          If Recordcount <> 0 Then FOrgNo := FieldByname('OriginalNo').AsString;
        Finally
          Close;
          Free;
        End;
    If FOrgNo = '' Then Exit;
    PostDB;
    If Deleted And DeletingTomergeOutstandingsale Then Begin
      If CleanQty <> 0 Then FChangeQty := CleanQty
      Else FChangeQty                  := CleanQtyTotal;
    End
    Else If Deleted Then FChangeQty                 := CleanQtyTotal
    Else If CleanQtyTotal = QtySold Then FchangeQty := 0
    Else FchangeQty                                 := CleanQtyTotal - QtySold;
    If FChangeQty = 0 Then Exit;

    If Assigned(Self.Owner) Then
      If (Self.Owner Is TSalesOrder) Or (Self.Owner Is TInvoice) Then Begin
        (* TSales(Self.Owner).SaleLinesofGroup.IterateRecords(callbackChangeOrderQty); *)
        StrSQL := ' Select SaleLineID From tblSaleslines SL ' + ' inner join tblSales S on S.saleId = SL.saleId and S.Originalno = ' + QuotedStr(FOrgNo) +
        // ' and S.Globalref <> ' +quotedstr(TSales(Self.Owner).Globalref) + ' and S.Globalref <> ' + QuotedStr(TSales(Self.Owner).backorderGlobalref)+
          ' and SL.SaleLineId < ' + Inttostr(ID) + ' where SL.SeqNo = ' + IntToStr(Seqno) + ' and SL.ProductId = ' + IntToStr(ProductId);
        With GetNewdataset(StrSQL) Do
          Try
            If Recordcount > 0 Then Begin
              First;
              StrSQL       := 'update tblSaleslines Set QtySold                = QtySold   -' + FloatToStr(FchangeQty) + ' where SaleLineID = :SaleLineID;';
              StrSQL       := StrSQL + 'update tblSaleslines Set BackOrder              = BackOrder -' + FloatToStr(FchangeQty) + ' where SaleLineID = :SaleLineID;';
              StrSQL       := StrSQL + 'update tblSaleslines Set UnitofMeasureQtySold   = QtySold  /UnitofMeasureMultiplier where SaleLineID = :SaleLineID;';
              StrSQL       := StrSQL + 'update tblSaleslines Set UnitofMeasureBackorder = BackOrder/UnitofMeasureMultiplier where SaleLineID = :SaleLineID;';
              StrSQL       := StrSQL + 'update tblSaleslines Set Deleted = "T" where SaleLineID = :SaleLineID and ifnull(QtySold,0) =0 and ifnull(BackOrder,0) =0 and ifnull(Shipped,0) = 0;';
              StrSQLUpdate := '';
              While Eof = False Do Begin
                StrSQLUpdate := StrSQLUpdate + ReplaceStr(StrSQL, ':SaleLineID', IntToStr(Fieldbyname('SaleLineId').AsInteger));
                Next;
              End;
            End;
          Finally
            If Active Then Close;
            Free;
          End;
        If StrSQLUpdate <> '' Then GetNewDataSet(StrSQLUpdate, True);
      End;
  Finally LogD('', LbEnd);
  End;
End;
(* procedure TSalesLine.callbackChangeOrderQty(const Sender: TBusObj;  var Abort: Boolean);
  begin
  if not(Sender is TSalesLine) then exit;
  if TSalesLine(Sender).Seqno = Self.Seqno then
  if TSalesLine(Sender).ID <> Self.ID then begin
  {TSalesLine(Sender).QtySold:= TSalesLine(Sender).QtySold -fchangeQty;
  TSalesLine(Sender).UOMQtySold:= DivZer(TSalesLine(Sender).QtySold , TSalesLine(Sender).UOMMultiplier);
  TSalesLine(Sender).QtyBackOrder        := TSalesLine(Sender).QtyBackOrder -fchangeQty;
  TSalesLine(Sender).UOMqtyBackOrder:= DivZer(TSalesLine(Sender).QtyBackOrder , TSalesLine(Sender).UOMMultiplier);
  Sender.postDB;}
  SQLForIteraterecords:=SQLForIteraterecords + 'update tblSaleslines Set QtySold = ' +FloattoStr(TSalesLine(Sender).QtySold -fchangeQty) +
  ' where SaleLineID = ' +IntToStr(TSalesLine(Sender).ID)+';';
  SQLForIteraterecords:=SQLForIteraterecords +'update tblSaleslines Set UnitofMeasureQtySold = ' +FloattoStr(DivZer(TSalesLine(Sender).QtySold , TSalesLine(Sender).UOMMultiplier)) +
  ' where SaleLineID = ' +IntToStr(TSalesLine(Sender).ID)+';';
  SQLForIteraterecords:=SQLForIteraterecords +'update tblSaleslines Set BackOrder = ' +FloattoStr(TSalesLine(Sender).QtyBackOrder -fchangeQty) +
  ' where SaleLineID = ' +IntToStr(TSalesLine(Sender).ID)+';';
  SQLForIteraterecords:=SQLForIteraterecords +'update tblSaleslines Set UnitofMeasureBackorder = ' +FloattoStr(DivZer(TSalesLine(Sender).QtyBackOrder , TSalesLine(Sender).UOMMultiplier)) +
  ' where SaleLineID = ' +IntToStr(TSalesLine(Sender).ID)+';';
  end;

  end; *)

Function TSalesLine.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
Var
  Shp: TShipmentList;
  Qry: TERPQuery;
Begin
  Shp    := Nil;
  Result := Inherited DoBeforeDelete(Sender);
  If Not Result Then Exit;
  If Assigned(Owner) And (Owner Is TSalesOrder) Then Begin
    If TSalesOrder(Owner).ShipmentList.Count > 0 Then Shp := TSalesOrder(Owner).ShipmentList;
  End
  Else If Assigned(Owner) And (Owner Is TInvoice) Then Begin
    If TInvoice(Owner).ShipmentList.Count > 0 Then Shp := TInvoice(Owner).ShipmentList;
  End;
  If Assigned(Shp) Then Begin
    Qry := TempQry;
    Qry.Close;
    Qry.SQL.Text := 'delete from tblshipmentsaleline where SaleLineId = ' + IntToStr(Self.ID);
    Qry.Execute;
  End;
End;

Function TSalesLine.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
Begin
  Result := Inherited DoBeforeInsert(Sender);
  If Not Result Then Exit;
  Dataset.FieldByname('unitofmeasureQtySold').Readonly   := False;
  Dataset.FieldByname('unitofmeasureSaleLines').Readonly := False;
End;

(* var
  SenderSale: TSales;
  SaleObj: TSales;
  SeqNo: integer;
  QtySold: double;
  fbDoFieldChange:Boolean;
  begin
  LogD('TSalesLine.DoBeforeDelete',lbBegin);
  try
  Result := inherited DoBeforeDelete(Sender);
  SenderSale := nil;
  if Assigned(Owner) then if (Owner is tInvoice) or (owner is TSalesOrder) then SenderSale := TSales(Owner);

  if not Assigned(SenderSale) then Exit;

  if SenderSale.Deleted then Exit;// Binny :this is deleting BO internally when the original trans' qty is changed

  {process the qty for all the related records}
  SaleObj := SenderSale;
  SeqNo := SaleObj.Lines.DataSet.FieldByName('SeqNo').AsInteger;
  QtySold := SaleObj.Lines.DataSet.FieldByName('QtySold').AsFloat;
  SaleObj := SenderSale.GetOriginalSaleRec;
  while (SaleObj <> nil) do begin
  //if PoObj.Lines.Dataset.Locate('SeqNo', SeqNo, []) then begin
  {if the product is changed the changed line also will have teh same sequence number}
  if SaleObj.Lines.Dataset.Locate('SeqNo;ProductID', VarArrayof([SeqNo,ProductID]), []) then begin
  if SaleObj.Lines.Dataset.FieldByName('QtySold').AsFloat <> SAleObj.Lines.Dataset.FieldByName('Shipped').AsFloat then begin
  fbDoFieldChange:=SaleObj.Lines.DoFieldChange;
  SaleObj.Lines.DoFieldChange := False;
  try
  if not (SaleObj.Lines.Dataset.State in [dsEdit, dsInsert]) then SaleObj.Lines.Dataset.edit;
  SaleObj.Lines.Dataset.FieldByName('QtySold').AsFloat := SaleObj.Lines.Dataset.FieldByName('QtySold').AsFloat - Qtysold;
  if not (SaleObj.Lines.Dataset.State in [dsEdit, dsInsert]) then SaleObj.Lines.Dataset.edit;
  SaleObj.Lines.Dataset.FieldByName('UnitofMeasureQtySold').AsFloat :=
  SAleObj.Lines.Dataset.FieldByName('QtySold').AsFloat * SaleObj.Lines.Dataset.FieldByName('UnitofMeasureMultiplier').AsFloat;
  if not (SaleObj.Lines.Dataset.State in [dsEdit, dsInsert]) then SaleObj.Lines.Dataset.edit;
  SAleObj.Lines.Dataset.FieldByName('BackOrder').AsFloat := 0;
  if not (SAleObj.Lines.Dataset.State in [dsEdit, dsInsert]) then SAleObj.Lines.Dataset.edit;
  SaleObj.Lines.Dataset.FieldByName('UnitofMeasureBackorder').AsFloat := 0;
  SaleObj.Lines.PostDB;
  finally
  SaleObj.Lines.DoFieldChange:=fbDoFieldChange;
  end;
  SaleObj := SaleObj.GetOriginalSaleRec;
  end else begin
  SaleObj := nil;
  end;
  end else begin
  SaleObj := nil;
  end;
  end;
  finally
  LogD('',lbEnd);
  end;
  end; *)

// ------------------------------------------------------------------------------
{ TSales }
// ------------------------------------------------------------------------------
Function TSales.IsCustomerCreditOk: Boolean;
Var
  TmpBalance            : Double;
  DuedatewithGracePeriod: TDateTime;
Begin
  Result := True;
  if silentmode then exit;
  If AppEnv.CompanyPrefs.CreditCheckInv = False Then Exit;
  If TotalAmountInc <= 0 Then Exit;

  if self is TInvoice then begin
    if (TotalBalance - TInvoice(self).TotalPrePayments) <= 0 then
      exit;
  end
  else if self is TSalesOrder then begin
    if (TotalBalance - TSalesOrder(self).TotalPrePayments - TSalesOrder(self).TotalProgressPayments) <= 0 then
      exit;
  end;

  { get the current balance amount - balance amount is the invoice balance + sales order balance }
  TmpBalance := Customer.CreditBalance;
  Result     := (TmpBalance + Self.TotalAmountInc - Self.cleanTotalAmountInc) <= Customer.CreditLimit;
  If (Not Result) And (TmpBalance < Customer.CreditLimit) Then Begin
    DuedatewithGracePeriod := IncDay(DueDate, Customer.GracePeriod);
    Result                 := (Date < DuedatewithGracePeriod);
  End;
  If Not Result Then Begin
    Result := False;
    Self.ResultStatus.AddItem(True, RssWarning, BOR_Sales_Warn_CreditExceeded, 'Customer has Exceeded Credit Limit'#13#10 + 'Limit: ' + CurrToStrF(Customer.CreditLimit, FfCurrency, 2) + '   Amount: '
      + CurrToStrF(TmpBalance + Self.TotalAmountInc, FfCurrency, 2));
  End;
End;

Procedure TSales.CalcLinepriceCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TRepairParts) Then Exit;
  TRepairParts(Sender).Priceex  := DivZer(TRepairParts(Sender).Linetotalex, TRepairParts(Sender).Qty);
  TRepairParts(Sender).Priceinc := GetAmountInc(TRepairParts(Sender).Priceex, TRepairParts(Sender).TaxRate);
  TRepairParts(Sender).PostDB;
End;

Function TSales.CopySalesToRepairs: Integer;
Var
  Copiedobj  : TBusobj;
  Fbconverted: Boolean;
  Bm, BmLines: TBookmark;
Begin
  Result := 0;
  If (Self.Count = 0) Or (Self.Lines.Count = 0) Then Begin
    Resultstatus.AddItem(False, RssWarning, 0, 'Empty Transaction cannot be converted');
    Exit;
  End;
  Dataset.Disablecontrols;
  Lines.Dataset.Disablecontrols;
  Bm      := Dataset.Getbookmark;
  Bmlines := Lines.Dataset.Getbookmark;
  Try
    Try
      Connection.BeginTransaction;
      Fbconverted := Converted;
      Copiedobj   := CopyUsingTransactionMaper(TRepairs.Classname);
      If Copiedobj <> Nil Then Begin
        RepairsObj := TRepairs(Copiedobj);
        Result     := TRepairs(RepairsObj).ID;
        Converted  := Fbconverted;
        If Self Is TQuoteBase Then Begin
          TRepairs(RepairsObj).Quoteglobalref := GlobalRef;
          TRepairs(RepairsObj).Soglobalref    := '';
        End Else Begin
          TRepairs(RepairsObj).Soglobalref    := GlobalRef;
          TRepairs(RepairsObj).Quoteglobalref := Self.QuoteGlobalRef;
        End;

        If Appenv.CompanyPrefs.CopySalesOrderShiptotoRepairs = 'C' Then begin
          TRepairs(RepairsObj).CustomerDetails := ShipToDesc;
          TRepairs(RepairsObj).BillToCustomerDetails := InvoiceToDesc;
        end
        Else If Appenv.CompanyPrefs.CopySalesOrderShiptotoRepairs = 'I' Then begin
          TRepairs(RepairsObj).CustomerDetails := InvoiceToDesc;
          TRepairs(RepairsObj).BillToCustomerDetails := ShipToDesc;
        end
        else begin
          TRepairs(RepairsObj).CustomerDetails :=  self.Customer.ShipToAddress;//self.ShipToDesc;
          TRepairs(RepairsObj).BillToCustomerDetails := self.Customer.BillingAddress;//self.InvoiceToDesc;
        end;

        TRepairs(RepairsObj).Phone    := Customer.Phone;
        TRepairs(RepairsObj).Fax      := Customer.Faxnumber;
        TRepairs(RepairsObj).Altphone := Customer.AltPhone;
        TRepairs(RepairsObj).PostDB;
        TEquipmentxRef(RepairEquipment).IterateRecords(CopyEquipments);
        RepairId := TRepairs(RepairsObj).Id;
        PostDB;
        CopyAttachments(self.TableName, ID, TRepairs(RepairsObj).TableName, TRepairs(RepairsObj).ID, self.Connection.Connection);
        TRepairs(RepairsObj).RepairParts.IterateRecords(CalcLinepriceCallback);
        Dirty := False;
        Connection.CommitTransaction;
        UnlockAfterCopyUsingTransactionMaper(Copiedobj);
      End Else Begin
        Connection.RollbackTransaction;
        UnlockAfterCopyUsingTransactionMaper(Copiedobj);
      End;
    Except Connection.RollbackTransaction;
    End;
  Finally
    Dataset.GotoBookmark(Bm);
    Dataset.FreeBookmark(Bm);
    Lines.Dataset.GotoBookmark(Bmlines);
    Lines.Dataset.FreeBookmark(Bmlines);
    Lines.Dataset.Enablecontrols;
    Dataset.Enablecontrols;
  End;
End;

Constructor TSales.Create(AOwner: TComponent);
Begin
  Inherited;
  ConvertCurrent := False;
  fLineIdsToconvert:= TIntegerList.Create;
  xID:=0;
  DeletingTomergeOutstandingsale := False;
  FbAnyLineShipped               := False;
  FQuoteSale                     := Nil;
  FSQL                           := 'SELECT * FROM tblSales';
  CopyingToInvoice               := False;
  CopyingToSaleSOrder            := False;
  CopyingToCashSale              := False;
  CopyingtoQuote                 := False;
  FShowPO                        := Nil;
  FShowSO                        := Nil;
  (* fSaleLinesofGroup := nil; *)
  { for the complete list this where calsue should be applied . eg : Export to XML
    but if ID is passed into it, override the where clause with the ID. thats becuase
    the conversions opens the record in the converting class.
    eg Sales order to Invoice conversion can open the SO record in a TInvoice Object }
  If Self Is TInvoice Then begin
//    FSQLSelect         := 'IsInvoice = "T"';
    fSQL := 'select * from tblsales where IsInvoice = "T"';
  end
  Else If Self Is TQuoteBase Then begin
//    FSQLSelect  := 'IsQuote = "T"';
    fSQL := 'select * from tblsales where IsQuote = "T"';
  end
  Else If Self Is TSalesOrder Then begin
//    FSQLSelect := 'IsSalesOrder = "T"';
    fSQL := 'select * from tblsales where IsSalesOrder = "T"';
  end;
  FieldsnotToclone := ExcludeFromclone + ',' + QuotedStr('Paid') + ',' + QuotedStr('payment') + ',' + QuotedStr('Balance') + ',' + QuotedStr('RepairID') + ',' + QuotedStr('RepairGlobalref') + ',' +
    QuotedStr('POCreated') + ',' + QuotedStr('AutoSmartOrderRef') + ',' + QuotedStr('Quoteglobalref') + ',' + QuotedStr('Quoteglobalref') + ',' + QuotedStr('ForeignPaidAmount') + ',' +
    QuotedStr('ForeignBalanceAmount');
  { Audit changes for all sales objects }
  FPopupDisplayed := False;
  ExportExcludeList.Add('cleanconverted');
End;

Destructor TSales.Destroy;
Begin
  Freeandnil(FQuoteSale);
  fLineIdsToconvert.Free;
  Inherited;
End;

Procedure TSales.Load(Const AId: Integer; Const FIsReadonly: Boolean = False);
Begin
  Self.FSQLSelect := 'SaleID = ' + IntToStr(AId);
  Inherited Load(AId, FisREadonly);
End;

procedure TSales.LineIdToconvert(const Value: Integer);
begin
  fLineIdsToconvert.Add(Value);
end;

procedure TSales.LineIdToconvert(const Value: String);
begin
  CleanLineIdsToconvert;
  fLineIdsToconvert.Commatext := Value;
end;

Procedure TSales.Load(Const FIsReadonly: Boolean = False);
Begin
  Inherited;
  Lines.LoadSelect('SaleID = ' + IntToStr(SaleID), FIsReadonly);
End;

Function TSales.GetTotalQtyBackOrdered: Double;
Begin
  Result := TotalQtyOrdered - TotalQtyShipped;
End;

Function TSales.GetTSalesDeliveryDetails: TSalesDeliveryDetails;
Begin
  Result := TSalesDeliveryDetails(Getcontainercomponent(TSalesDeliveryDetails, 'SaleId = ' + IntToStr(ID), True, True));
End;

Function TSales.HasNonTreeLines: Boolean;
Begin
  FbHasNonTreeLines := False;
  Lines.IterateRecords(HasNonTreeLinesCallback);
  Result := FbHasNonTreeLines;
End;
Function TSales.NonTreeLines: Integer;
Begin
  fiNonTreeLines := 0;
  Lines.IterateRecords(HasNonTreeLinesCallback);
  Result := fiNonTreeLines;
End;

Procedure TSales.HasNonTreeLinesCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TSalesLine) Then Exit;
  If Not(TSalesLine(Sender).IsTreeItem) Then Begin
    //Abort             := True;
    FbHasNonTreeLines := True;
    fiNonTreeLines := fiNonTreeLines+1;
  End;
End;

Function TSales.GetShipmentList: TShipmentList;
Begin
  Result := TShipmentList(GetContainerComponent(TShipmentList, 'SaleId = ' + IntToStr(Self.ID)));
End;

Function TSales.GetSQL: String;
Begin
  Result := Inherited GetSQL;
End;

Procedure TSales.New;
Begin
  Self.FSQLSelect     := 'SaleID = 0';
  FWETTaxRate         := 0;
  FWEGTaxRate         := 0;
  FTotMarkup          := 0;
  FTotDiscount        := 0;
  FTotWETTax          := 0;
  FTotWEGTax          := 0;
  FTotTax             := 0;
  FTotalAmountInc     := 0;
  FTotalAmount        := 0;
  FTotalCost          := 0;
  FTotalOrdered       := 0;
  FTotalShipped       := 0;
  FForeignTotalAmount := 0;
  FAttrib1Sale        := 0;
  FAttrib2Sale        := 0;
  FAttrib1SaleRate    := 0;
  FAttrib1SaleEst     := 0;
  FAttrib2SaleEst     := 0;
  Inherited;
  SaleClassId   := AppEnv.DefaultClass.ClassID;
  SaleClassName := AppEnv.DefaultClass.DefaultClassName;
  Self.Lines;
End;

Procedure TSales.NewBOInit(BackOrder: TTransBase);
Begin
  Inherited;
  // if BackOrder is Tsales then Tsales(BackOrder).PartSourceToManufacture(Anylinehastree);
End;

Function TSales.AnySOIngrouphastree: Boolean;
Begin
  With GetNewDataset('Select count(Pt.proctreeID) as ctr ' + ' from tblsales S ' + ' inner join tblsaleslines SL on S.saleId = SL.saleId ' +
    ' inner join tblProctree Pt on Pt.masterID = SL.saleLineId and Pt.mastertype <> "mtProduct" ' + ' Where S.originalno = ' + Quotedstr(OriginalDocNumber), True) Do
    Try Result := Fieldbyname('ctr').AsInteger > 0;
    Finally
      If Active Then Close;
      Free;
    End;
End;

function TSales.AnylineHasPurchaseCost: Boolean;
begin
  LineCheckFlag := False;
  { check the current line first whether it has the tree and if yes return true }
  If Lines.IsTreeItem Then LineCheckFlag := True
  Else Lines.IterateRecords(AnylineHasPurchaseCostCallback);
  Result := LineCheckFlag;
end;

procedure TSales.AnylineHasPurchaseCostCallback(const Sender: TBusObj;
  var Abort: Boolean);
begin
  If Not(Sender Is TSalesline) Then Exit;
  If TSalesline(Sender).PurchaseCost <> 0 Then Begin
    LineCheckFlag := True;
    abort := True;
  End;
end;

Function TSales.Anylinehastree: Boolean;
Begin
  LineCheckFlag := False;
  { check the current line first whether it has the tree and if yes return true }
  If Lines.IsTreeItem Then LineCheckFlag := True
  Else Lines.IterateRecords(AnylinehastreeCallback);
  Result := LineCheckFlag;
End;

Function TSales.AnylineIsBatchEnabled: Boolean;
Begin
  LineCheckFlag := False;
  { check the current line first whether it has the tree and if yes return true }
  If Lines.Product.batch Then LineCheckFlag := True
  Else Lines.IterateRecords(AnylineIsBatchEnabledCallback);
  Result := LineCheckFlag;
End;
Procedure TSales.AnylineIsBatchEnabledCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TSalesline) Then Exit;
  If TSalesline(Sender).Product.batch Then Begin
    LineCheckFlag := True;
    abort := True;
  End;
End;


function TSales.BOMLineIDs: String;
begin
  fsBOMLineIDs:= '';
  Lines.IterateRecords(AnylinehastreeCallback);
  Result := fsBOMLineIDs;
end;
Procedure TSales.AnylinehastreeCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TSalesline) Then Exit;
  If TSalesline(Sender).IsTreeItem Then Begin
    LineCheckFlag := True;
    if fsBOMLineIDs <> '' then fsBOMLineIDs := fsBOMLineIDs+',';
    fsBOMLineIDs := fsBOMLineIDs + inttostr(TSalesline(Sender).ID);
  End;
End;

Procedure TSales.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
Begin
  Inherited;
  // tmpTotalEstimatedAmountInc := 0;
  SalesonHoldconfirmed := False;
  (* FreeAndNil(fSaleLinesofGroup); *)
End;

Procedure TSales.InitializeNewObject;
Begin
  Self.PostDB;
  Self.DocNumber    := IntToStr(Self.Id);
  FOverrideHoldSale := False;
  Inherited;
  If Self.SaleDate = 0 Then Begin
    SaleDate     := Date;
    SaleDateTime := Now;
    CreationDate := SaleDate;
    CheckSaleDate;
  End;

  // Sale Date
  If ShipDate = 0 Then ShipDate := Date;
End;

Procedure TSales.InstantiateAllTrees;
Begin
  Lines.Iteraterecords(InstantiateAllTreesCallback);
End;

Procedure TSales.InstantiateAllTreesCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TSalesline) Then Exit;
  {Binny :
  since this is reading the existing salesorder /invoice, tree shouldn't be created if not exists.
  change made to fix posting memorised transaction clearing the Original price to 0
  DB:Madeurne, product : Software Miscellaneous}
  TSalesline(Sender).InstantiateTree(False);
End;

Function TSales.GetConverted: Boolean;
Begin
  Result := GetBooleanField('Converted');
End;

Function TSales.GetCleanconverted: Boolean;
Begin
  Result := GetXMLNodeBooleanValue(CleanXMLNode, 'Converted');
End;

Procedure TSales.SetConverted(Const Value: Boolean);
Begin
  If (CopyingToInvoice) And (Self Is TInvoice) Then SetBooleanField('Converted', False)
  Else SetBooleanField('Converted', Value);
End;

Procedure TSales.OnChangeCustomer;
Begin
  AddEvent(BusObjEvent_Change, BusObjEventVal_CustomerChanged, Self.ID);
End;

Procedure TSales.DoFieldOnChange(Sender: TField);
(* var
  SaleList: TSaleList;
  msg: string; *)
Begin
  Inherited;
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.

  If DocNumber = '' Then InitializeNewObject;
  if Sysutils.SameText(Sender.FieldName, 'ContactID') then begin
    InitShiptoAddress;
  end else if Sysutils.SameText(Sender.FieldName, 'ShipToId') then begin
    InitShiptoAddress;
  end else if Sysutils.SameText(Sender.FieldName, 'ShiptoContactID') then begin
    InitShiptoAddress;
  end else If Sysutils.SameText(Sender.Fieldname, 'HoldSale') Then Begin
    If Not RawMode Then Begin
      SalesonHoldconfirmed := False;
    End;
  End
  Else If Sysutils.SameText(Sender.FieldName, 'ClientID') Then Begin
    If Not RawMode Then Begin
      InitPaymentTerms;
      Shipping := Customer.ShippingMethodName;
      If Self.Customer.InvoiceCommentPopUp Then Begin
        If (Not FPopupDisplayed) Then Begin
          AddEvent(BusObjEvent_InvoiceCommentPopUp, Self.Customer.InvoiceComment, Self.ID);
          FPopupDisplayed := True;
        End;
      End
      Else If Self.Comments = '' Then
        Self.Comments := Self.Customer.InvoiceComment;
    end;
    onchangeCustomer;
  end else if Sysutils.SameText(Sender.FieldName , 'CustomerName') then begin
    if not RawMode then begin
      InitPaymentTerms;
      Shipping := Customer.ShippingMethodName;

//      If Self.Customer.InvoiceCommentPopUp Then Begin
//        If (Not FPopupDisplayed) Then Begin
//          AddEvent(BusObjEvent_InvoiceCommentPopUp, Self.Customer.InvoiceComment, Self.ID);
//          FPopupDisplayed := True;
//        End;
//      End Else If Self.Comments = '' Then Self.Comments := Self.Customer.InvoiceComment;

    End;
    OnChangeCustomer;
  End
  Else If Sysutils.SameText(Sender.FieldName, 'ClassID') Then Begin
    SaleClassName := TDeptClass.IDToggle(SaleClassID, Connection.Connection);
  End
  Else If Sysutils.SameText(Sender.FieldName, 'Class') Then Begin
    SaleClassID := TDeptClass.IDToggle(SaleClassName, Connection.Connection);
  End
  Else If Sysutils.SameText(Sender.FieldName, 'Terms') Then Begin
    If Not RawMode Then Begin
      (* if AppEnv.CompanyPrefs.UseShippedDateForTerms then
        SetPaymentTerms(ShipDate)
        else
        SetPaymentTerms(SaleDate); *)
      InitPaymentTerms;
    End;
  End
  Else If Sysutils.SameText(Sender.FieldName, 'SaleDate') Then Begin
    If Not RawMode Then Begin
      CheckSaleDate;

      If Not AppEnv.CompanyPrefs.UseShippedDateForTerms Then SetPaymentTerms(SaleDate)
      else If AppEnv.CompanyPrefs.UseShippedDateForTerms Then SetPaymentTerms(ShipDate);
    End;
  End
  Else If Sysutils.SameText(Sender.FieldName, 'ShipDate') Then Begin
    If Not RawMode Then Begin
      If AppEnv.CompanyPrefs.UseShippedDateForTerms Then SetPaymentTerms(ShipDate);
      { check ship date on lines }
      Lines.IterateRecords(CheckLineShipDateCallback);

      DoContainerEvent(Self, EvSaleShipDateChange, Sender);
    End;
  End
  Else If Sysutils.SameText(Sender.FieldName, 'ForeignExchangeRate') Then Begin
    If Not RawMode Then Begin
      Self.RecalculateAllLines;
      Self.DoCalcOrderTotals;
    End;
  End
  Else If Sysutils.SameText(Sender.FieldName, 'ForeignExchangeCode') Then Begin
    If Not RawMode Then Begin
      SetForeignCurrencyRate;
      Self.RecalculateAllLines;
      Self.DoCalcOrderTotals;
    End;
  End
  Else If Sysutils.SameText(Sender.FieldName, 'Converted') Then Begin
    If Not RawMode Then Begin
      If Sender.Value = 'T' Then AddEvent(BusObjEvent_Change, BusObjEventVal_Converted, Self.ID);
    End;
  End
  Else If Sysutils.SameText(Sender.FieldName, 'PONumber') Then Begin
    If Not RawMode Then Begin
      PONumnotUnique(True);
    End;
  End
  Else If SameText(Sender.Fieldname, 'PlannedDeliveryFrom') Then Begin
    If Not RawMode Then Begin
      If (PlannedDeliveryFrom <> 0) And (PlannedDeliveryTo <> 0) Then
        If PlannedDeliveryFrom > PlannedDeliveryTo Then PlannedDeliveryTo := Inchour(PlannedDeliveryFrom, 2);
    End;
  End
  Else If SameText(Sender.Fieldname, 'PlannedDeliveryTo') Then Begin
    If Not RawMode Then Begin
      If (PlannedDeliveryFrom <> 0) And (PlannedDeliveryTo <> 0) Then
        If PlannedDeliveryFrom > PlannedDeliveryTo Then PlannedDeliveryfrom := Inchour(PlannedDeliveryto, -2);
    End;
  end else if sametext(Sender.fieldname , 'ReferenceNo') or sametext(Sender.fieldname , 'DefaultReferenceNoinAllLines') then begin
    SendEvent(BusObjEvent_Change, BusObjEventVal_ReferenceNo);
  End;
End;
procedure TSales.UpdateAllLinesRefNo;
begin
  Lines.iteraterecords(UpdateAllLinesRefNoCallback);
end;
procedure TSales.UpdateAllLinesRefNoCallback(Const Sender: TBusObj; Var Abort: Boolean);
begin
  if sender is TSalesLine then begin
    TSalesLine(Sender).UpdateLinesRefNo;
    TSalesLine(Sender).postdb;
  end;
end;
procedure TSales.ERPScriptAfterExecute(Sender: TObject; fsSQL: string);
begin
end;
Procedure TSales.InitShiptoAddress;
var
  Qry :TERPQuery;
  s:String;
  fsClientname, fsPrintname, fsJobname:String;
begin
  Qry := DbSharedObj.GetQuery(connection.Connection);
  try
    Qry.SQL.text := 'Select ' +
                      ' C.Printname as Printname, ' +  NL +
                      ' C.globalref as globalref, ' +  NL +
                      ' PC.globalref as PCglobalref, ' +  NL +
                      ' C.isjob , '+NL+
                      ' C.printjobname , '+NL+
                      ' if(ifnull(SA.ShipAddressID,0)<>0 , SA.CompanyName 	,  C.Company		) as Company, ' +  NL +
                      ' if(ifnull(SA.ShipAddressID,0)<>0 , SA.ShipAddress 	,  C.street			) as Street, ' +NL +
                      ' if(ifnull(SA.ShipAddressID,0)<>0 , SA.ShipAddress1 	,  C.street2		) as street2, ' +NL +
                      ' if(ifnull(SA.ShipAddressID,0)<>0 , SA.ShipAddress2 	,  C.street3		) as street3, ' +NL +
                      ' if(ifnull(SA.ShipAddressID,0)<>0 , SA.ShipCity 			,  C.suburb			) as suburb, ' +NL +
                      ' if(ifnull(SA.ShipAddressID,0)<>0 , SA.ShipState 		,  C.State			) as State, ' +NL +
                      ' if(ifnull(SA.ShipAddressID,0)<>0 , SA.ShipPostCode 	,  C.postcode		) as postcode, ' +NL +
                      ' if(ifnull(SA.ShipAddressID,0)<>0 , SA.ShipCountry 	,  C.country		) as country, ' +NL +
                      ' if(ifnull(SA.ShipAddressID,0)<>0 and ifnull(SA.ContactName,"")<> "", SA.ContactName , if(ifnull(SCC.ContactID,0) <> 0 , SCC.company  ,CC.Company	 )) as ContactName ,   ' +NL +
                      ' if(ifnull(SA.ShipAddressID,0)<>0 and ifnull(SA.Phone,"")      <> "", SA.Phone       , if(ifnull(SCC.ContactID,0) <> 0 , SCC.ContactPH,CC.ContactPH )) as ContactPH  ' +NL +
                      ' from tblclients C ' +NL +
                      ' Left join tblclients PC on C.isjob ="F" or C.parentClientId = PC.clientId ' +NL +
                      ' left join tblcontacts CC on c.clientId = CC.ClientID and Cc.contactId = '+ inttostr(ContactID)+NL +
                      ' left join tblcontacts SCC on c.clientId = SCC.ClientID and SCc.contactId = '+ inttostr(ShiptoContactID)+NL +
                      ' Left join (tblShippingAddress  SA INNER JOIN tblClientToShipAddressLink SAL ON   SAL.ShipAddressID = SA.ShipAddressID ) on SAL.clientId = C.ClientID and SA.ShipAddressID =  '+ inttostr(ShiptOID)+NL +
                      ' where C.clientID = '+ inttostr(customerID);
    Qry.Open;
    s:= '';
    fsClientname:= '';
    fsPrintname:= '';
    fsJobname := '';
    if Appenv.CompanyPrefs.LoadCustnameinNewshippingAddress then begin
        fsClientname := SubStr(Qry.FieldByName('Company').AsString , '^');

        fsPrintname := SubStr(Qry.FieldByName('Printname').AsString , '^');

      if (fsClientname<> '') then
             if                                         sametext(fsClientname,fsPrintname)                                 then fsClientname := ''
        else if                                         sametext(fsClientname,  Qry.FieldByName('Globalref').AsString)     then fsClientname := ''
        else if Qry.FieldByName('ISJob').asBoolean and  sametext(fsClientname, Qry.FieldByName('PCGlobalref').AsString )   then fsClientname := ''
        else fsClientname := fsClientname;

        if (Qry.FieldByName('IsJob').asBoolean) and (Qry.FieldByName('printjobname').AsString<>'') then fsJobname := Qry.FieldByName('printjobname').AsString;
    end;
    s:= ConcatStrings([fsClientname ,
                       fsPrintname,
                       fsJobname ,
                       iif(Appenv.CompanyPrefs.IncludeContactPhoneInSalesshippingAddress  and (trim(Qry.FieldByName('ContactPH').AsString) <> '' ) , 'Ph: ' + trim(Qry.FieldByName('ContactPH').AsString) , ''),
                    iif(not(sametext(Qry.FieldByName('ContactName').AsString,Qry.FieldByName('Company').AsString )) and Appenv.CompanyPrefs.IncludeContactNameInSalesShippingAddress, Qry.FieldByName('ContactName').AsString, ''),
                    Qry.FieldByName('street').AsString,
                    Qry.FieldByName('street2').AsString,
                    Qry.FieldByName('street3').AsString,
                    ConcatStrings([Qry.FieldByName('suburb').AsString , Qry.FieldByName('state').AsString ,Qry.FieldByName('postcode').AsString ],' ') ,
                    Qry.FieldByName('country').AsString],#13+#10);

    ShipToDesc := s;
    PostDB;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;
Procedure TSales.PopulateClientData;
Var
  S                : String;
  Posn             : Integer;
  BuyRate, SellRate: Double;
  fsClientname, fsPrintname:String;
Begin
  Inherited;

  // Invoice To Address
  fsClientname := Customer.ClientName;
  If AppEnv.CompanyPrefs.SuppressJobNamesOnInvoices Then Begin
    Posn               := Pos('^', fsClientname);
    If Posn > 0 Then fsClientname := Copy(fsClientname, 1, Posn - 1);
  End;

  fsPrintname := Customer.Printname;
  If AppEnv.CompanyPrefs.SuppressJobNamesOnInvoices Then Begin
    Posn               := Pos('^', fsPrintname);
    If Posn > 0 Then fsPrintname := Copy(fsPrintname, 1, Posn - 1);
  End;
  s:= fsPrintname;

  if (fsClientname<> '')
      and not(sametext(fsClientname,fsPrintname))
      and not(sametext(fsClientname, Customer.Globalref))
      and not(sametext(fsClientname, Customer.CustomerGlobalRef ))   then s:= s + #13#10 + fsClientname;
  if (Customer.IsJob) and (Customer.printjobname<>'') then s:= s + #13#10 + Customer.printjobname;

  s:= ConcatStrings([s ,
                     iif(Appenv.CompanyPrefs.IncludeContactNameInSalesBillingAddress and (Contactname<> '') and not(Sametext(s,Contactname)) , Contactname , ''),
                     Iif((Customer.BillStreet <> '') Or (Customer.BillStreet2 <> ''), Customer.BillingAddress ,Customer.StreetAddress)] , #13 + #10 );

  InvoiceToDesc := S;
  ShipToDesc    := '';

  InitShiptoAddress;

  // Department/Class
  If (Customer.DefaultClassName <> '') and (Customer.DefaultClass.ID<>0) Then Begin
    SaleClassName := Customer.DefaultClass.DeptClassName;
    SaleClassId   := Customer.DefaultClass.ID;
  End Else Begin
    If SaleClassName = '' Then SaleClassName := AppEnv.DefaultClass.DefaultClassName;
    If SaleClassId = 0 Then SaleClassId      := AppEnv.DefaultClass.ClassID;
  End;

  // Determine what Accounts Receivable Account we are using?
(*  GLAccountId   := AppEnv.CompanyPrefs.DefaultSalesAccount;
  GLAccountName := Self.GLAccount.AccountName;*)

  InitARAccount;
  // Foreign Currency
  If AppEnv.CompanyPrefs.UseForeignCurrencyOnSales Then Begin

    { Make sure header has required foreign currency info. }
    If Customer.ForeignExchangeCode <> '' Then Begin
      ForeignExchangeCode := Customer.ForeignExchangeCode;
    End Else Begin
      ForeignExchangeCode := AppEnv.RegionalOptions.ForeignExDefault;
    End;

    If (ForeignExchangeCode <> AppEnv.RegionalOptions.ForeignExDefault) Then Begin
      // get the rate for the currency
      FXObj.GetForeignExchangeRatesForDate(ForeignExchangeCode, SaleDate, BuyRate, SellRate);

      // NOTE use the banks buy rate, ie we have to sell the foreign
      // currency back to the the bank (they are buying from us)
      // that we received for payment of invoice from OS customer.
      ForeignExchangeRate := SellRate; // BuyRate;
    End
    Else ForeignExchangeRate := 1;
  End Else Begin
    ForeignExchangeCode := AppEnv.RegionalOptions.ForeignExDefault;
    ForeignExchangeRate := 1;
  End;

  // Terms
  If Customer.TermsId > 0 Then TermsName := Customer.Terms.TermsName
  Else TermsName                         := TERMS_ON_RCPT;

  SetPaymentTerms(SaleDate);

  If Not IsCustomerOk Then Begin
    If Not FOverrideHoldSale Then begin
      if Self.TotalBalance > 0 then
        HoldSale := True;
    end;
  End;

  If Customer.IsJob Then Begin
    If (Customer.WarrantyFinishDate > 0) And (Customer.WarrantyFinishDate < Date) Then Begin
      ResultStatus.AddItem(True, RssInfo, 0, 'The warranty of this job is out of date. ' + #13#10 + 'The warranty finish date is ' + DateToStr(Customer.WarrantyFinishDate));
    End;
  End;
End;

Function TSales.ValidateData: Boolean;
Begin
  If Deleted Or Cancelled Then Begin
    Result := True;
    Exit;
  End;
  Result := Inherited ValidateData;
  If Not Result Then Exit;

  If ClientId = 0 Then Begin
                  Result := False;
    ResultStatus.AddItem(False, RssWarning, 0, 'Customer is either blank or not found');
    Exit;
  End;
  If  (SaleClassId < 0) Then Begin
    Result := False;
    ResultStatus.AddItem(False, RssWarning, BOR_Sales_Err_InvalidDepartment, 'Department should not be blank');
    Exit;
  End;
  if AppEnv.CompanyPrefs.EnforceConNoteOnSale and (ConNote = '') then begin
    ResultStatus.Additem(False, rssWarning, 0, 'Con Note Number must be specified.' );
    Result := false;
    Exit;
  end;

  If (Not(SilentMode)) Then begin
    if (CustPONumber = '') then begin
      if ((Self is TInvoice) and Customer.ForcePONumOnInvoice) or ((Self is TSalesOrder) and Customer.ForcePOOnSalesOrder) then begin
        Result := False;
        Self.ResultStatus.AddItem(False, RssWarning, BOR_Sales_InvalidPONumber, 'You must provide a Customer P.O. Number');
        Exit;
      end;
    end;
  end;

  If PONumNotUnique(False) Then Begin
    Result := False;
    Exit;
  End;

  If ((Self Is TInvoice) And (AppEnv.CompanyPrefs.CreditCheckInv)) Or ((Self Is TSalesOrder) And (AppEnv.CompanyPrefs.CreditCheckSO)) Then Begin
    If (Not HoldSale) And (Not FOverrideHoldSale) Then Begin
      If (Not IsCustomerOk) Then Begin
        if self.TotalBalance > 0 then
          HoldSale := True;
      End;
    End;

    If HoldSale And (Not SilentMode) And (Not(SalesonHoldconfirmed)) and not(CrossStockAdjustTransForinvoice) Then Begin
      If BusobjMessageDlg('This Sale will be marked as "Hold"' + #13 + #10 + 'Do you wish to proceed with the Sale for this Customer?', MtConfirmation, [MbYes, MbNo], 0) = MrNo Then Begin
        Result := False;
        Exit;
      End;
      SalesonHoldconfirmed := True;
    End;
  End;
  If (Not RawMode) And Appenv.CompanyPrefs.IsSalesCategoryMandatory Then Begin
    If Salescategory = '' Then Begin
      Result := False;
      Self.ResultStatus.AddItem(False, RssWarning, 0, 'Sales Category should not be blank');
      Exit;
    End;
  End;
  If (PlannedDeliveryFrom <> 0) And (PlannedDeliveryTo <> 0) Then
    If PlannedDeliveryFrom > PlannedDeliveryTo Then Begin
      Result := False;
      Self.ResultStatus.AddItem(False, RssWarning, 0, 'Planned Delivery Date from > planned Delivery date to');
      Exit;
    End;

  AllLinesValid := True;
  Lines.Iteraterecords(LockLinkedPOnSO, True);
  Result := AllLinesValid;
  If Not Result Then Exit;
End;

Procedure TSales.DeleteLinkToPOnSO(Const Sender: TBusObj; Var Abort: Boolean);
Var
  StrSQL: String;
Begin
  If Not(Sender Is TSalesLine) Then Exit;
  If TSalesLine(Sender).Deleted = False Then Exit;
  StrSQL := TPurchaseOrder.DeleteLinkToPO(TSalesLine(Sender).ID);
  If StrSQL <> '' Then GetnewDataset(StrSQL, True);
  StrSQL := TSmartOrder.DeleteLinkToSO(TSalesLine(Sender).ID);
  If StrSQL <> '' Then GetnewDataset(StrSQL, True);
End;

Function TSales.Lock: Boolean;
Begin
  REsult := Inherited Lock;
  If Not Result Then Exit;
  (* if (Self is TInvoice) or (Self is TSalesorder) then
    if anystartedpacking then begin
    Resultstatus.AddItem(False, RssWarning, 0, XMLNodeName + ' # ' + inttostr(ID) +' is already started picking / packing');
    result := False;
    end; *)
End;

Function TSales.Anystartedpacking: Boolean;
Begin
  With GetNewDataset('Select PA.* from tblpickingassembly PA inner join tblpickingassemblylines PAL on PA.PickingAssemblyID = PAL.PickingAssemblyID  where ifnull(PAL.qty,0)<>0 and  PA.SaleId = ' +
    Inttostr(ID), True) Do
    Try Result := Recordcount > 0;
    Finally
      If Active Then Close;
      Free;
    End;
End;

Procedure TSales.LockLinkedPOnSO(Const Sender: TBusObj; Var Abort: Boolean);
Var
  Msg: String;
Begin
  If Not(Sender Is TSalesLine) Then Exit;
  If TSalesLine(Sender).Deleted Then Begin
    Try
      If TPurchaseOrder.LockLinkedPOs(TSalesLine(Sender).ID, UserLock, LockGroupName, TSalesLine(Sender).ProductName, MSG) = False Then Begin
        Self.ResultStatus.AddItem(False, RssWarning, 0, Msg);
        AllLinesValid := False;
        Abort         := True;
        Exit;
      End;
      If TSmartOrder.LockLinkedSOs(TSalesLine(Sender).ID, UserLock, LockGroupName, TSalesLine(Sender).ProductName, MSG) = False Then Begin
        Self.ResultStatus.AddItem(False, RssWarning, 0, Msg);
        AllLinesValid := False;
        Abort         := True;
        Exit;
      End;
    Finally
      If AllLinesValid = False Then Begin
        UserLock.Unlock(LockGroupname + 'LockLinkedTrans');
      End;
    End;
  End;
End;

Procedure TSales.CalcOrderTotals;
Begin
  Inherited;
End;

Procedure TSales.CalcTotalsCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If TSalesLine(Sender).Deleted Then Exit;
  Inherited; // don't remove the inherited. Actual calculation is in the abse class
End;

Function TSales.CanLockAllManifest: Boolean;
Begin
  FbCanLockAllManifest := True;
  Lines.IterateRecords(CanLockAllManifestCallback);
  Result := FbCanLockAllManifest;
End;

Procedure TSales.CanLockAllManifestCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TSalesLine) Then Exit;
  If Not TSalesLine(Sender).CanLockManifest Then Begin
    FbCanLockAllManifest := False;
    Abort                := True;
  End;
End;

Procedure TSales.SetForeignCurrencyRate;
Var
  BuyRate, SellRate: Double;
Begin
  // get the rate for the currency
  FXObj.GetForeignExchangeRatesForDate(ForeignExchangeCode, SaleDate, BuyRate, SellRate);

  // NOTE use the banks buy rate, ie we have to sell the foreign
  // currency back to the the bank (they are buying from us)
  // that we received for payment of invoice from OS customer.
  ForeignExchangeRate := SellRate; // BuyRate;
End;

procedure TSales.SetJobName(const Value: string);
var
  Id, ParentId: integer;
begin
  ParentId := 0;
  if ClientId > 0 then begin
    if Client.ParentClientId > 0 then
      ParentId := Client.ParentClientId
    else
      ParentId := Client.ID;
  end;

  Id := TClient.ClientIdForJobName(Value,ParentId, self.Connection.Connection);
  if (Id > 0) and (self.ClientId <> Id) then begin
    self.ClientId := Id;
    self.DoFieldOnChange(Dataset.FindField('ClientId'));
  end;
end;

Procedure TSales.SetPaymentTerms(Const BaseDate: TDateTime);
Begin
  Inherited;

End;

Procedure TSales.InitPaymentTerms;
Begin
  If AppEnv.CompanyPrefs.UseShippedDateForTerms Then SetPaymentTerms(ShipDate)
  Else SetPaymentTerms(SaleDate);
End;

Procedure TSales.SetPlannedDeliveryFrom(Const Value: TDatetime);
Begin
  SetDatetimefield('PlannedDeliveryFrom', Value);
End;

Procedure TSales.SetPlannedDeliveryTo(Const Value: TDatetime);
Begin
  SetDatetimefield('PlannedDeliveryTo', Value);
End;

Procedure TSales.CheckSaleDate;
Begin
  If CleanSaleDate = SaleDate Then Exit;

  If (SaleDate <= AppEnv.CompanyPrefs.ClosingDateAR) Then Begin
    If AppEnv.CompanyPrefs.ClosingDateAR < Now() Then Begin
      ResultStatus.AddItem(False, RssWarning, 0, 'You Have Set The Sale Date Before The Closing Date !' + #13 + #10 + '' + #13 + #10 + 'The Date Will Automatically be Set To Today''s Date ' + #13 +
        #10 + '' + #13 + #10 + 'OR' + #13 + #10 + '' + #13 + #10 + 'Reset The Closing Date In Preferences.', );
      SaleDate := Now;
    End
    Else If AppEnv.CompanyPrefs.ClosingDateAR > Now() Then Begin
      ResultStatus.AddItem(False, RssWarning, 0, 'You Have Set The Sale Date Before The Closing Date !' + #13 + #10 + '' + #13 + #10 + 'The Date Will Automatically be Set To Closing Date ' + #13 + #10
        + '' + #13 + #10 + 'OR' + #13 + #10 + '' + #13 + #10 + 'Reset The Closing Date In Preferences.');
      SaleDate := AppEnv.CompanyPrefs.ClosingDateAR;
    End
  End;
End;

Function TSales.GetId: Integer;
Begin
  Result := SaleId;
End;

Class Function TSales.GetIDField: String;
Begin
  Result := 'SaleId';
End;


function TSales.GetJobName: string;
begin
  result := '';
  if self.ClientId > 0 then
    result := self.Client.JobName;
end;

Function TSales.GetPlannedDeliveryFrom: TDatetime;
Begin
  REsult := GetDatetimefield('PlannedDeliveryFrom');
End;

Function TSales.GetPlannedDeliveryTo: TDatetime;
Begin
  REsult := GetDatetimefield('PlannedDeliveryTo');
End;

Function TSales.GetQuoteSale: TQuote;
Begin
  If FQuoteSale = Nil Then Begin
    { don't use container component as it assigned self as owner and then fgets dataset from the form }
    FQuoteSale := TQuote.CreateWithNewConn(Nil);
    FQuoteSale.LoadSelect('globalref = ' + Quotedstr(Self.Quoteglobalref));
  End;
  Result := FQuoteSale;
End;

Class Function TSales.GetBusObjectTablename: String;
Begin
  Result := 'tblSales';
End;

Function TSales.GetSaleLines: TSalesLineBase;
Begin
  Result := TSalesLine(Lines);
End;

Function TSales.IsCustomerTermsOk: Boolean;
Var
  Msg: String;
Begin
  Result := True;
  If Not TcDataUtils.IsCustomerTermsOK(ClientId, Msg) Then Begin
    Result := False;
    Self.ResultStatus.AddItem(True, RssWarning, BOR_Sales_Warn_TermsExceeded, Msg);
  End;
End;
Function TSales.OnHoldTerm:String;
begin
  if (Self is TInvoice)    then
    if (Appenv.CompanyPrefs.ChangeCreditCheckTermsInv) then result := Appenv.CompanyPrefs.CreditCheckTermsInv
    else result := Customer.TermsName;

  if (Self is TSalesOrder) then
    if (Appenv.CompanyPrefs.ChangeCreditCheckTermsSO) then result := Appenv.CompanyPrefs.CreditCheckTermsInv
    else result := Customer.TermsName;
  if result = '' then result := terms_ON_RCPT;
end;
Function TSales.IsCustomerOk: Boolean;
Begin
  Result := True;
  If ((Self Is TInvoice) And (AppEnv.CompanyPrefs.CreditCheckInv)) Or ((Self Is TSalesOrder) And (AppEnv.CompanyPrefs.CreditCheckSO)) Then Begin
    If (Not IsCustomerCreditOk) Then Begin
      Result    := False;
      TermsName := OnHoldTerm;
    End (*Else If (Not IsCustomerTermsOk) Then Begin
      Result    := False;
      TermsName := TERMS_PREPAYMENT;
      end; *)
    End;
End;

Procedure TSales.ClonePropertyObjects;
Begin
  Inherited ClonePropertyObjects; // DON;T REMOVE THE INHERITED
  { Binny : CloneLines updates the parentProductID of the copied record
    with the id of line being copied. this field should have a non zero value only if its
    a related product. The following code does the upsatiuon for the related product parent ID }
  SalesShippingDetails.FieldsnotToclone := SalesShippingDetails.FieldsnotToclone + ',' + Quotedstr('SalesID');
  SalesShippingDetails.IterateRecords(CloneShippingDetails);

  SalesDeliveryDetails.FieldsnotToclone := SalesDeliveryDetails.FieldsnotToclone + ',' + Quotedstr('SalesID') + ',' + Quotedstr('Salesglobalref');
  SalesDeliveryDetails.IterateRecords(CloneSalesDeliveryDetails);
  If ((ObjInstanceToClone Is TSalesOrder) Or (ObjInstanceToClone Is TInvoice)) Then
    If Not(ObjInstanceToClone.Classnameis(Self.Classname)) Then MakeProductionGropuping;
  // UpdateRelatedIDsInCopiedLines(Self ,TSales(ObjInstanceToClone));

End;

Procedure TSales.CopySalesGroupedLinesCallback(Const Sender: TBusObj; Var Abort: Boolean);
Var
  IgroupID, IProductionId: Integer;
Begin
  IgroupID      := 0;
  IProductionId := 0;
  If Not(Sender Is TSalesGroupedLines) Then Exit;
  If Lines.Locate('SaleLineID', TSalesGroupedLines(Sender).BOMGroupedLineID, []) Then
    If TSales(ObjInstanceToClone).Lines.Locate('ProductID;seqno', VarArrayof([Lines.ProductID, Lines.SeqNo]), []) Then IgroupID := Tsales(ObjInstanceToClone).Lines.ID;
  If Lines.Locate('SaleLineID', TSalesGroupedLines(Sender).BOMProductionLineID, []) Then
    If TSales(ObjInstanceToClone).Lines.Locate('ProductID;seqno', VarArrayof([Lines.ProductID, Lines.SeqNo]), []) Then IProductionId := Tsales(ObjInstanceToClone).Lines.ID;
  If (IProductionId <> 0) And (IgroupID <> 0) Then
    If Not(TSales(ObjInstanceToClone).SalesGroupedLines.Locate('BOMProductionLineID;BOMGroupedLineID', Vararrayof([IProductionId, IgroupID]), [])) Then Begin
      TSales(ObjInstanceToClone).SalesGroupedLines.New;
      TSales(ObjInstanceToClone).SalesGroupedLines.BOMProductionLineID := IProductionId;
      TSales(ObjInstanceToClone).SalesGroupedLines.BOMGroupedLineID    := IgroupID;
      TSales(ObjInstanceToClone).SalesGroupedLines.PostDb;
    End;
End;

procedure TSales.MakeCleanTree;
begin
  Lines.iterateRecords(MakeCleanTreeCallback);
end;
Procedure TSales.MakeCleanTreeCallback(Const Sender: TBusObj; Var Abort: Boolean);
begin
    if (Sender is TSalesOrderLine) and   not(TSalesOrderLine(Sender).TreeFinalized) then begin
      TSalesOrderLine(Sender).DoContainerEvent(TSalesOrderLine(Sender), evSalesLineMakeCleanTree);
    end;
end;

Procedure TSales.MakeProductionGropuping;
Begin
  If SalesGroupedLines.Count > 0 Then Begin
    SalesGroupedLines.IterateRecords(CopySalesGroupedLinesCallback);
  End;
End;

Function TSales.MergeSale(Const MergingIDs: String): Boolean;
Var
  St       : TIntegerList;
  Ctr      : Integer;
  AnyMerged: Boolean;
  MergedIDs:String;
Begin
  REsult:= False;
  If Not IsOktoMerge(ID) Then Begin
    Result := False;
    Exit;
  End;
  Connection.BeginTransaction;
  Try
    AnyMerged := False;
    REsult    := True;
    St        := TIntegerList.Create;
    Try
      St.CommaText := MergingIDs;
      If St.Count = 0 Then Exit;
      St.Delete(St.IndexOf(Self.ID));
      If St.Count = 0 Then Exit;
      MergedIDs := '';
      For Ctr := 0 To St.Count - 1 Do Begin
        If IsOktoMerge(St[Ctr]) Then Begin
          Result := MergeSale(St[Ctr]);
          If Not(REsult) Then Begin
            Connection.RollbackTransaction;
            Exit;
          end else begin
            if MergedIDs <> '' then MergedIDs := MergedIDs +',';
            MergedIDs := MergedIDs + inttostr(St[Ctr]);
          End;
          AnyMerged := True;
        End;
      End;
      If Not(AnyMerged) Then begin
        Result := False;
        Exit;
      end;
      If Result Then Begin
        Lines.closedb;CloseDB;
        OpenDB;Lines;
        CalcOrderTotals;
        if MergedIDs <> '' then
          Comments := 'Merged ' +XMLNodeName +'(s) ' + MergedIDs +' into ' +XMLNodeName +' # ' + Inttostr(ID)+NL+Comments;
        //Comments := Comments + 'Combined  ' + XMLNodeName + ' # ' + Inttostr(ID);
        PostDB;
        Connection.CommitTransaction;
        Result := True;
      End;
    Finally Freeandnil(St);
    End;
  Except
    On E: Exception Do Begin
      Connection.RollbackTransaction;
    End;
  End;
End;

Function TSales.IsOktoMerge(Const MergingID: Integer): Boolean;
Begin
  REsult:=  False;
  With GetnewDataset('Select * from tblsales where saleId = ' + Inttostr(MergingID), True) Do
    Try
      If MergingID <> Id Then Begin
        If ClientID <> Fieldbyname('clientID').AsInteger Then Begin
          ResultStatus.AddItem(True, RssWarning, 0, XMLNodeName + ' # ' + Inttostr(FieldByname('SaleID').AsInteger) + ' has a differnet customer ' + Quotedstr(Fieldbyname('CustomerName').AsString));
          Result := False;
          Exit;
        End;
        If SaleclassID <> Fieldbyname('classID').AsInteger Then Begin
          ResultStatus.AddItem(True, RssWarning, 0, XMLNodeName + ' # ' + Inttostr(FieldByname('SaleID').AsInteger) + ' has a differnet  ' + Appenv.DefaultClass.Classheading + ' ' +
            Quotedstr(Fieldbyname('Classname').AsString));
          Result := False;
          Exit;
        End;
        If (ForeignExchangeCode <> Fieldbyname('ForeignExchangeCode').AsString) Or (ForeignExchangeRate <> Fieldbyname('ForeignExchangeRate').AsFloat) Then Begin
          ResultStatus.AddItem(True, RssWarning, 0, XMLNodeName + ' # ' + Inttostr(FieldByname('SaleID').AsInteger) + ' has a differnet FX ' +
            Quotedstr(Fieldbyname('ForeignExchangeCode').AsString + ' (' + FloatToStrF(Fieldbyname('ForeignExchangeRate').AsFloat, FfGeneral, 15, 2) + ')'));
          REsult := False;
          Exit;
        End;
        if (fieldbyname('RepairGlobalRef').AsString <> RepairGlobalRef ) then begin
          if (fieldbyname('RepairGlobalRef').AsString <>'') and ( RepairGlobalRef <> '') then
            ResultStatus.AddItem(True, RssWarning, 0, XMLNodeName + ' # ' + Inttostr(FieldByname('SaleID').AsInteger) +' and ' +  NL+ XMLNodeName + ' # ' + inttostr(ID) + ' are of two different repairs and cannot be merged.')
          else if fieldbyname('RepairGlobalRef').AsString  <> '' then
            ResultStatus.AddItem(True, RssWarning, 0, XMLNodeName + ' # ' + Inttostr(FieldByname('SaleID').AsInteger) + ' is a repair '+ XMLNodeName+' and ' + NL+ XMLNodeName + ' # ' + Inttostr(ID) + ' is not , they cannot be merged.')
          else
            ResultStatus.AddItem(True, RssWarning, 0, XMLNodeName + ' # ' + Inttostr(ID) + ' is a repair '+ XMLNodeName+' and ' + NL+ XMLNodeName + ' # ' + Inttostr(FieldByname('SaleID').AsInteger) + ' is not , they cannot be merged.');
          REsult := False;
          Exit;
        end;
      End;
      If Fieldbyname('BOID').AsString <> '' Then Begin
        ResultStatus.AddItem(True, RssWarning, 0, XMLNodeName + ' # ' + Inttostr(FieldByname('SaleID').AsInteger) + ' has a backorder associated with it');
        REsult := False;
        Exit;
      End;
      If Fieldbyname('baseno').AsString <> '' Then Begin
        ResultStatus.AddItem(True, RssWarning, 0, XMLNodeName + ' # ' + Inttostr(FieldByname('SaleID').AsInteger) + ' is a backorder');
        REsult := False;
        Exit;
      End;
      If Not Userlock.Lock('tblsales', Fieldbyname('saleID').AsInteger) Then Begin
        ResultStatus.AddItem(True, RssWarning, 0, Replacestr(Userlock.Lockmessage, 'Unable to update data.', 'Unable to Merge ' + XMLNodeName + ' # ' + Inttostr(FieldByname('SaleID').AsInteger)));
        REsult := False;
        Exit;
      End;
      If (Fieldbyname('Payment').AsFloat <> 0) Or (Fieldbyname('Paid').AsBoolean) Then Begin
        ResultStatus.AddItem(True, RssWarning, 0, XMLNodeName + ' # ' + Inttostr(FieldByname('SaleID').AsInteger) + ' is already paid');
        REsult := False;
        Exit;
      End;
      If (Fieldbyname('converted').AsBoolean) Then Begin
        ResultStatus.AddItem(True, RssWarning, 0, XMLNodeName + ' # ' + Inttostr(FieldByname('SaleID').AsInteger) + ' is already Converted');
        REsult := False;
        Exit;
      End;
      Result := True;
    Finally
      If Not(REsult) Then SendEvent(BusobjEvent_ToDo, BusobjEvent_ShowCustomizableInvocieTextfield);
      If Active Then Close;
      Free;
    End;
End;

Function TSales.MergeSale(Const MergingID: Integer): Boolean;
Var
  SREf                                  : String;
  Mergingsale                           : Tsales;
  ILinesID, ILinesOrder, ISortID, ISeqno: Integer;
  Function MergingsaleObj: Tsales;
  Begin
    REsult := Tsales(GetComponentByClassName(Self.ClassName));
    (* var
      s:String;
      begin
      s:= tcdatautils.SaleType(MergingID);
      if Sametext(s , tcConst.InvType) then result := TInvoice.Create(nil)
      else if sametext(s, 'Sales Order') then result := TSalesOrder.Create(nil)
      else if Sametext(s, 'Quote') then result := TQuote.Create(nil)
      else result := nil; *)
  End;

Begin
  Result := True;
  Try
    Try
      Connection.BeginNestedTransaction;
      SRef := SalesGlobalref(MergingID);
      With TempMyScript(TERPConnection(Self.Connection.Connection)) Do
        Try
          xID:= MergingID;
          MaxNosofLines(ILinesID, ILinesOrder, ISortID, ISeqno);
          SQL.Add('update tblsaleslines set LinesOrder = LinesOrder + ' + Inttostr(ILinesOrder) + ' where SaleID = ' + Inttostr(MergingID) + ';');
          SQL.Add('update tblsaleslines set SortID     = SortID     + ' + Inttostr(ISortID)     + ' where SaleID = ' + Inttostr(MergingID) + ';');
          SQL.Add('update tblsaleslines set Seqno      = Seqno      + ' + Inttostr(ISeqno)      + ' where SaleID = ' + Inttostr(MergingID) + ';');
          SQL.Add(ChangeIDSQL('tblsaleslines'           , 'SaleID'    , MergingID, ''));
          SQL.Add(ChangeIDSQL('tblpqa'                  , 'Transid'   , MergingID, 'Transtype in (' + SalesTransTypes + ')'));
          SQL.Add(ChangeIDSQL('tblproducttrans'         , 'Transid'   , MergingID, 'Transtype in (' + SalesTransTypes + ')'));
          SQL.Add(ChangeIDSQL('tblsalestaxcodes'        , 'SaleID'    , MergingID));
          SQL.Add(ChangeIDSQL('tblsaleslinespoints'     , 'SaleID'    , MergingID));
          SQL.Add(ChangeIDSQL('tblsalescommission'      , 'SaleID'    , MergingID));
          SQL.Add(ChangeIDSQL('tblsalesredeempoints'    , 'SaleID'    , MergingID));
          SQL.Add(ChangeIDSQL('tblsalesdeliverydetails' , 'SaleID'    , MergingID));
          SQL.Add(ChangeIDSQL('tblsalesshippingdetails' , 'SalesId'   , MergingID));
          SQL.Add(ChangeIDSQL('tblshipmentlist'         , 'SaleId'    , MergingID));
          SQL.Add(ChangeIDSQL('tblsalesgroupedlines'    , 'SaleID'    , MergingID));
          SQL.Add(ChangeIDSQL('tblequipmentxref'        , 'SaleID'    , MergingID));
          SQL.Add(ChangeIDSQL('tblequipmentxref'        , 'InvoiceID', MergingID));
          SQL.Add(ChangeIDSQL('tblrelatedsales'         , 'OriginalSaleID'  , MergingID));
          SQL.Add(ChangeIDSQL('tblsalesredeempoints'    , 'PointsfromSaleId', MergingID));
          SQL.Add(ChangeIDSQL('tblbankdepositlinessales', 'TransID'         , MergingID));
          SQL.Add(ChangeIDSQL('tblcar'                  , 'SalesID'         , MergingID));
          SQL.Add(ChangeIDSQL('tblpickingassembly'      , 'SaleID'          , MergingID));
          SQL.Add(ChangeIDSQL('tblpickslip'             , 'SalesID'         , MergingID));
          SQL.Add(ChangeIDSQL('tblpos'                  , 'SalesID'         , MergingID));
          SQL.Add(ChangeIDSQL('tbltimesheets'           , 'SalesID'         , MergingID));
          SQL.Add(ChangeIDSQL('tblcart_sales_ref'       , 'SaleID'          , MergingID));
          SQL.Add(ChangeIDSQL('tblcourse'               , 'SaleID'          , MergingID));
          SQL.Add(ChangeIDSQL('tbldepositline'          , 'SaleID'          , MergingID));
          if TableExists('tblerpclientmessagelog') then
            SQL.Add(ChangeIDSQL('tblerpclientmessagelog'  , 'ERPSaleID'       , MergingID));
          SQL.Add(ChangeIDSQL('tblfesaleslines'         , 'SaleID'          , MergingID));
          SQL.Add(ChangeIDSQL('tbllicenceinvoiced'      , 'SaleID'          , MergingID));
          SQL.Add(ChangeIDSQL('tblorder'                , 'SaleID'          , MergingID));
          SQL.Add(ChangeIDSQL('tblpickingassemblyentry' , 'SaleID'          , MergingID));
          SQL.Add(ChangeIDSQL('tblpickingassemblyentrylines' , 'SaleID'     , MergingID));
          SQL.Add(ChangeIDSQL('tblprocess'              , 'SaleID'          , MergingID));
          SQL.Add(ChangeIDSQL('tblprocpickslipline'     , 'SaleID'          , MergingID));
          SQL.Add(ChangeIDSQL('tblproctreepart'         , 'SaleID'          , MergingID));
          SQL.Add(ChangeIDSQL('tblsalespayments'        , 'SaleID'          , MergingID));
          SQL.Add(ChangeIDSQL('tblvouchers'             , 'SaleID'          , MergingID));
          SQL.Add(ChangeGlobalrefSQL('tblsalesautosplitqty'   , 'SaleRef'         , SRef));
          SQL.Add(ChangeGlobalrefSQL('tblsalesdeliverydetails', 'Salesglobalref'  , SRef));
          SQL.Add(ChangeGlobalrefSQL('tblrelatedsales'        , 'TransRef'        , SRef));
          SQL.Add(ChangeGlobalrefSQL('tblrelatedsales'        , 'PreviousREf'     , SRef));
          SQL.Add(ChangeGlobalrefSQL('tblstocktransferentry'  , 'SalesRef'        , SRef));
          SQL.Add('update tblsaleslines SL inner join tblsales S on S.saleId = SL.saleId set SL.Product_Description =  replace(SL.Product_Description , S.Globalref , ' +quotedstr(Globalref)+') where S.SaleID = ' + Inttostr(MergingID) + ';');
          SQL.Add('update tblsales  set Comments =  replace(Comments, Globalref , ' +quotedstr(Globalref)+') where SaleID = ' + Inttostr(MergingID) + ';');
          SQL.Add(ChangeGlobalrefSQL('tblsales'               , 'SOProgressPaymentGlobalRef'  , SRef));
          SQL.Add(ChangeGlobalrefSQL('tblsales'               , 'SOProgressPaymentOriginalRef', SRef));
          SQL.Add(ChangeGlobalrefSQL('tblsalesprepayments'    , 'SalesRef'                    , SRef));
          SQL.Add(ChangeGlobalrefSQL('tblsalesprepayments'    , 'SalesOriginalRef'            , SRef));
          SQL.Add(ChangeGlobalrefSQL('tblrepairs'             , 'QuoteGlobalRef'              , SRef));
          SQL.Add(ChangeGlobalrefSQL('tblrepairs'             , 'SOGlobalRef'                 , SRef));

          try
            AfterExecute := ERPScriptAfterExecute;
            Execute;
          Except
            on E:Exception do begin
              if Pos('Lock wait timeout',e.Message) > 0 then begin
                ResultStatus.AddItem(True, rssWarning, 0, 'One of the linked table of '+ XMLNodename +' # ' + inttostr(MergingID) +' is locked by another user/Process.  Unable to Merge.'+NL+E.Message);
                REsult:= False;
                Exit;
              end;
            end;
          end;
        Finally Free;
        End;
      Mergingsale := MergingsaleObj;
      If Mergingsale = Nil Then Begin
        REsult := False;
        Exit;
      End;
      Try
        Mergingsale.Connection := Self.Connection;
        Mergingsale.Load(MergingID);
        If Mergingsale.Count = 0 Then Begin
          REsult := False;
          Exit;
        End;
        Mergingsale.Deleted  := True;
        Mergingsale.Comments := 'Merged into ' + Mergingsale.XMLNodeName + ' # ' + Inttostr(ID) + NL + Mergingsale.Comments;
        Mergingsale.CalcOrderTotals;
        Mergingsale.PostDB;
        //Self.Comments := 'Merged  ' + Mergingsale.XMLNodeName + ' # ' + Inttostr(MergingID) + NL + Comments;
        PostDB;
        Connection.CommitNestedTransaction;
        Result := True;
      Finally FreeandNil(Mergingsale);
      End;
    Except
      On E: Exception Do Begin
        REsult := False;
      End;
    End;
  Finally
    If Result = False Then Connection.RollbackNestedTransaction;
  End;
End;

Function TSales.ChangeGlobalrefSQL(Tablename, GlobalrefFieldname: String; Globalref: String; AndSQL: String = ''): String;
Begin
  Result                      := 'update ' + Tablename + ' set  ' + GlobalrefFieldname + ' = ' + Quotedstr(Self.Globalref) + ' where ' + GlobalrefFieldname + ' = ' + Quotedstr(Globalref);
  If AndSQL <> '' Then Result := Result + AndSQL;
  Result                      := Result + ';';
End;

Function TSales.ChangeIDSQL(Tablename, TransIDFieldname: String; TransId: Integer; AndSQL: String = ''): String;
Begin
  Result                      := 'update ' + Tablename + ' set  ' + TransIDFieldname + ' = ' + Inttostr(Self.ID) + ' where  ' + TransIDFieldname + ' = ' + Inttostr(TransId);
  If AndSQL <> '' Then Result := Result + ' and ' + AndSQL;
  Result                      := Result + ';';
End;

Function TSales.ValidateXMLData(Const Node: IXMLNode): Boolean;
Var
  FiGLAccountId: Integer;
  FiClientId   : Integer;
  FiEmployeeId : Integer;
  FiSaleClassID: Integer;
Begin
  Result := Inherited ValidateXMLData(Node);

  If Not Result Then Exit;
  If Not ImportingFromXMLFile Then Exit;
  If GetXMLNodeIntegerValue(Node, 'ImportingID') <> 0 Then XMLSearchRecorddesc := IDFieldName + ' =' + IntToStr(GetXMLNodeIntegerValue(Node, 'ImportingID'))
  Else XMLSearchRecorddesc                                                     := IDFieldName + ' =' + IntToStr(GetXMLNodeIntegerValue(Node, IDTagInXML));
  Result                                                                       := False;

  If GetXMLNodeStringValue(Node, 'GLaccountName') <> '' Then Begin
    FiGLAccountId := TcDatautils.GetAccountId(GetXMLNodeStringValue(Node, 'GLaccountName'));
    If FiGLAccountId = 0 Then Begin
      ErrRecordNotfound('AccountName', GetXMLNodeStringValue(Node, 'GLaccountName'));
      Exit;
    End;
  End;
  If GetXMLNodeStringValue(Node, 'CustomerName') <> '' Then Begin
    FiClientId := TClient.IDToggle(GetXMLNodeStringValue(Node, 'CustomerName'), Connection.Connection);
    If FiClientID = 0 Then Begin
      ErrRecordNotfound('Client', GetXMLNodeStringValue(Node, 'CustomerName'));
      Exit;
    End;
  End;
  If GetXMLNodeStringValue(Node, 'EmployeeName') <> '' Then Begin
    FiEmployeeId := TcDatautils.GetEmployeeId(GetXMLNodeStringValue(Node, 'EmployeeName'));
    If FiemployeeId = 0 Then Begin
      ErrRecordNotfound('Employee', GetXMLNodeStringValue(Node, 'Employeename'));
      Exit;
    End;
  End;
  If GetXMLNodeStringValue(Node, 'SaleClass') <> '' Then Begin
    FiSaleClassID := TcDatautils.GetDeptID(GetXMLNodeStringValue(Node, 'SaleClass'));
    If FiSaleClassID = 0 Then Begin
      ErrRecordNotfound('Class', GetXMLNodeStringValue(Node, 'SaleClass'));
      Exit;
    End;
  End;
  Result := True;
  { for the transaction records , the id should exists if its a modification transaction }
  { search on the globalref if exists, otherwise on Id }
  If GetXMLNodeStringValue(Node, 'Globalref') <> '' Then XMLSearchRecord := 'globalref = ' + QuotedStr(GetXMLNodeStringValue(Node, 'Globalref'))
  Else XMLSearchRecord                                                   := 'SaleID =' + IntToStr(GetXMLNodeIntegerValue(Node, 'SaleID'));
  LocateXMLRecord;
End;

Procedure TSales.LoadFromXMLNode(Const Node: IXMLNode);
Var
  LinesNode: IXMLNode;
Begin
  Inherited;
  SetPropertyFromNode(Node, 'SalesCategory');
  SetDatetimePropertyFromNode(Node, 'PlannedDeliveryFrom');
  SetDatetimePropertyFromNode(Node, 'PlannedDeliveryTo');
  LinesNode := Node.ChildNodes.FindNode('DeliveryDetails');
  If Assigned(LinesNode) Then Begin
    If SalesDeliveryDetails.Dataset.RecordCount > 0 Then Begin
      SalesDeliveryDetails.LoadFromXMLNode(LinesNode);
    End;
  End;
  SetPropertyFromNode(Node, 'ProgressPaymentInvRef');
  SetPropertyFromNode(Node, 'ProgressPaymentSeqno');
  SetPropertyFromNode(Node, 'ReferenceNo');
  SetBooleanPropertyFromNode(Node, 'DefaultReferenceNoinAllLines');
  SetBooleanPropertyFromNode(Node, 'Isdone');
End;

Procedure TSales.SaveToXMLNode(Const Node: IXMLNode);
Begin
  Inherited;
  AddXMLNode(Node, 'SalesCategory', SalesCategory);
  AddXMLNode(Node, 'PlannedDeliveryFrom', PlannedDeliveryFrom);
  AddXMLNode(Node, 'PlannedDeliveryTo', PlannedDeliveryTo);
  If SalesDeliveryDetails.Dataset.Recordcount > 0 Then SalesDeliveryDetails.SaveToXMLNode(Node.AddChild('DeliveryDetails'));
  AddXMLNode(Node, 'ProgressPaymentInvRef', ProgressPaymentInvRef);
  AddXMLNode(Node, 'ProgressPaymentSeqno', ProgressPaymentSeqno);
  AddXMLNode(Node, 'ReferenceNo', ReferenceNo);
  AddXMLNode(Node, 'DefaultReferenceNoinAllLines', DefaultReferenceNoinAllLines);
  AddXMLNode(Node, 'Isdone', Isdone);
End;

Function TSales.Save: Boolean;
Begin
  AllLinesValid := True;
  Lines.Iteraterecords(DeleteLinkToPOnSO, True);
  Result := AllLinesValid;
  If Not Result Then Exit;
  If Not Self.IsQuote Then Self.Deleted := Lines.Count = 0;

  if Self.IsInvoice then Quota := GetEmployeeQuota(EmployeeID);  // Wang 2/17/2023  

  Result := Inherited Save;

  If Not((Self Is TInvoice) Or (Self Is TSalesOrder)) Then Exit;
End;

Procedure TSales.RecalculateAllLines;
Begin
  Lines.IterateRecords(RecalculateAllLinesCallback);
End;

Procedure TSales.RecalculateAllLinesCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not TSalesLine(Sender).Deleted Then TSalesLine(Sender).CalculateLine;
End;

Procedure TSales.AfterCloneBusObj;
Begin
  Inherited;
  If Assigned(ObjInstanceToClone) And (ObjInstanceToClone Is TSales) Then Begin
    If TSales(ObjInstanceToClone).SaleDate = Dateof(Now) Then TSales(ObjInstanceToClone).Saledatetime := Now
    Else TSales(ObjInstanceToClone).Saledatetime                                                      := TSales(ObjInstanceToClone).SaleDate + TimeOf(AppEnv.CompanyPrefs.StartOfDay);
    TSales(ObjInstanceToClone).PostDB;
  End;
End;

procedure TSales.CleanLineIdsToconvert;
begin
    fLineIdsToconvert.clear;
end;

Function TSales.CloneBusObj(Const Changefield: String; Const ChangeValue: Variant; Const SaveAfterCopy: Boolean = True; Const FilterFields: String = ''): TBusObj;
Var
  OldId, NewId: Integer;
Begin
  Result := Inherited CloneBusObj(ChangeField, ChangeValue, SaveAfterCopy, FilterFields);
  If Result = Nil Then Exit;
  OldId := Self.ID;
  NewId := ObjInstanceToClone.Id;
  UpdaterelatedIds(OldId, NewID, Tsalesline(TSales(ObjInstanceToClone).Lines));
  Result                                                                    := ObjInstanceToClone;
  If TSales(Result).SaleDate = Dateof(Now) Then TSales(Result).Saledatetime := Now
  Else TSales(Result).Saledatetime                                          := TSales(Result).SaleDate + TimeOf(AppEnv.CompanyPrefs.StartOfDay);
  /// /TSales(REsult).Saledatetime :=saleDateTime;
  TSales(Result).CalcOrderTotals;
  TSales(Result).PostDB;
End;

Procedure TSales.CloneLines(Const Sender: TBusObj; Var Abort: Boolean);
Var
  Fd: Double;
  fsProductname:String;
  fdQty:Double;
Begin
  If (Sender Is Tsalesline) And (Tsalesline(Sender).BomProductionline) And (Self.ClassNameIs(ObjInstanceToClone.ClassName)) Then // Production lines are not cloned when copied
  Else If Tsalesline(Sender).IsProgressPayment Then
  Else Begin
    Inherited;
    If ObjInstanceToClone <> Nil Then Begin
      If ((Self Is TSalesOrder) Or (ObjInstanceToClone Is TInvoice)) And (CopyingToInvoice) Then Begin
        If Lines Is TSalesorderLine Then Begin
          Fd := TSalesorderLine(Lines).TotalInvoicedQty;
          If Fd > 0 Then Begin
            if ConvertCurrent then begin
              TSalesLine(TSales(ObjInstanceToClone).Lines).QtyShipped         := (*TSalesLine(TSales(ObjInstanceToClone).Lines).Qtysold - *)Fd;
              TSalesLine(TSales(ObjInstanceToClone).Lines).Qtysold            := (*TSalesLine(TSales(ObjInstanceToClone).Lines).Qtysold - *)Fd;
              (*if TSalesLine(TSales(ObjInstanceToClone).Lines).QtyShipped = TSalesLine(TSales(ObjInstanceToClone).Lines).Qtysold then begin
                TSalesLine(TSales(ObjInstanceToClone).Lines).ProductDescription := TSalesLine(TSales(ObjInstanceToClone).Lines).ProductDescription + ':  Full Sales Qty (' + FloattoStr(Fd)+') is already invoiced thru Partial Invoice.';
                TSalesLine(TSales(ObjInstanceToClone).Lines).Invoiced := True;
              end else TSalesLine(TSales(ObjInstanceToClone).Lines).ProductDescription := TSalesLine(TSales(ObjInstanceToClone).Lines).ProductDescription + '  Qty already invoiced Partially :' + FloattoStr(Fd);*)
            end else begin
              fdQty := TSalesLine(TSales(ObjInstanceToClone).Lines).Qtysold;
              TSalesLine(TSales(ObjInstanceToClone).Lines).QtyShipped         := TSalesLine(TSales(ObjInstanceToClone).Lines).Qtysold - Fd;
              TSalesLine(TSales(ObjInstanceToClone).Lines).Qtysold            := TSalesLine(TSales(ObjInstanceToClone).Lines).Qtysold -Fd;
              if TSalesLine(TSales(ObjInstanceToClone).Lines).QtyShipped = TSalesLine(TSales(ObjInstanceToClone).Lines).Qtysold then begin
                TSalesLine(TSales(ObjInstanceToClone).Lines).ProductDescription := TSalesLine(TSales(ObjInstanceToClone).Lines).ProductDescription + ':  Full Sales Qty (' + FloattoStr(fdQty)+') is already invoiced thru Partial Invoice.';
                TSalesLine(TSales(ObjInstanceToClone).Lines).Invoiced := True;
              end else TSalesLine(TSales(ObjInstanceToClone).Lines).ProductDescription := TSalesLine(TSales(ObjInstanceToClone).Lines).ProductDescription + '  Qty already invoiced Partially :' + FloattoStr(Fd);
            end;
              if TSalesLine(TSales(ObjInstanceToClone).Lines).Qtysold =0 then begin
                TSalesLine(TSales(ObjInstanceToClone).Lines).Invoiced := True;
                TSalesLine(TSales(ObjInstanceToClone).Lines).PostDb;
                fsProductname:=TSalesLine(TSales(ObjInstanceToClone).Lines).Productname;
                if TSalesLine(TSales(ObjInstanceToClone).Lines).count = 1 then begin
                  TSalesLine(TSales(ObjInstanceToClone).Lines).New;
                  TSalesLine(TSales(ObjInstanceToClone).Lines).Productname := PART_MEMO;
                  TSalesLine(TSales(ObjInstanceToClone).Lines).Qtysold := 1;
                  TSalesLine(TSales(ObjInstanceToClone).Lines).Qtyshipped := 1;
                  TSalesLine(TSales(ObjInstanceToClone).Lines).ProductDescription := 'Final Invoice of Order # ' +quotedstr(Globalref) +'.  '+
                                                                                      fsProductname+ ':  Full Sales Qty (' + FloattoStr(Fd)+') is already invoiced thru Partial Invoice.';
                  TSales(ObjInstanceToClone).Comments := trim (TSales(ObjInstanceToClone).Comments + NL + TSalesLine(TSales(ObjInstanceToClone).Lines).ProductDescription);
                  TSales(ObjInstanceToClone).PostDB;
                end;
              end else TSalesLine(TSales(ObjInstanceToClone).Lines).ProductDescription := TSalesLine(TSales(ObjInstanceToClone).Lines).ProductDescription + '  Qty already invoiced Partially :' + FloattoStr(Fd);
            TSalesLine(TSales(ObjInstanceToClone).Lines).PostDB;
          End;

        End;
      End;

      If ((ObjInstanceToClone Is TSalesOrder) Or (ObjInstanceToClone Is TInvoice)) And (ObjInstanceToClone.Classnameis(Self.Classname)) Then Begin
        TSalesLine(TSales(ObjInstanceToClone).Lines).BOMGroupedLine    := False;
        TSalesLine(TSales(ObjInstanceToClone).Lines).BOMProductionLine := False;
        TSales(ObjInstanceToClone).Lines.PostDB;
        TSales(ObjInstanceToClone).Lines.Save;
      End
      Else If ((Self Is TSalesOrder) And (ObjInstanceToClone Is TInvoice)) Then Begin
        GetNewDataset('update tblmanifestlines set InvoiceLineID = ' + Inttostr(TSalesLine(TSales(ObjInstanceToClone).Lines).ID) + ' where SaleLineID = ' + Inttostr(Lines.ID) + ';', True);
      End;
      If (Sender Is TSalesOrderLine) then begin
        TSalesOrderLine(TSales(ObjInstanceToClone).Lines).TreeFinalized := False;
        TSalesOrderLine(TSales(ObjInstanceToClone).Lines).postdb;
      end;

      (*
          IMPORTANT
      =================
      {Quote to So/Invoice
            with Preference : BO by default on SO / Invoice
            The amounts to be recalculated as the total amount should be 0 on BO
      }

      if Sender.ObjInstanceToClone is TTranslinebase then
          TTranslinebase(Sender.ObjInstanceToClone).CalcLineTotals;
      {CalcLineTotals Overwrites the changed line price in quote and also makes the discounts to 0
      so CalculateLinetotalsfromPrice is called just to recalculate the totals based on teh shipped qty without changing the line price and discounts }
          *)

      if Sender.ObjInstanceToClone is TTranslinebase then begin
          TTranslinebase(Sender.ObjInstanceToClone).CalculateLinetotalsfromPrice;
      end;


    End;
  End;

End;

Function TSales.GetEarlyPaymentDiscountAmount: Double;
Var
  DiscountPercent: Double;
  DiscountDays: integer;
Begin

  DiscountDays := Terms.EarlyPaymentDays;
  DiscountPercent := Terms.EarlyDiscountPercent;
  If DiscountPercent <> 0 Then begin
    if (DiscountDays = 0) or (Trunc(now - self.SaleDate) <= DiscountDays) then
      DiscountPercent := DiscountPercent / 100;
  end;
  Result := Round(TotalAmountInc * DiscountPercent, CurrencyRoundPlaces);
End;

Function TSales.Getcleancustomer: String;
Begin
  Result := GetXMLNodeStringValue(CleanXMLNode, 'Customername');
End;

Procedure TSales.Ordered(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TSalesLineBase) Then Exit;
  TSalesLineBase(Sender).SmartOrderCreated := True;
  TSalesLineBase(Sender).PostDB;
End;

Function TSales.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
Begin
  Result := Inherited DoAfterInsert(Sender);
  If Not Result Then Exit;
  ForeignExchangeCode := AppEnv.RegionalOptions.ForeignExDefault;
  SalesCategory       := TcDataUtils.GetSimpleTypeDefaultStr(SimpleTypes_SalesCategory);
End;

Procedure TSales.AssignProductcost(Const Sender: TBusObj; Var Abort: Boolean);
Var
  FbDoFieldChangewhenDisabled: Boolean;
Begin
  If Not(Sender Is TSmartOrderLine) Then Exit;
  FbDoFieldChangewhenDisabled                               := TSmartOrderLine(Sender).DoFieldChangewhenDisabled;
  TSmartOrderLine(Sender).DoFieldChangewhenDisabled         := True;
  {binny - this should take the cost from saleslines - not the product cost}
  Try TSmartOrderLine(Sender).CostEx                        := TSmartOrderLine(Sender).Product.GetCostForQty(TSmartOrderLine(Sender).ToPurchaseQty);
  Finally TSmartOrderLine(Sender).DoFieldChangewhenDisabled := FbDoFieldChangewhenDisabled;
  End;
  TSmartOrderLine(Sender).Postdb;
End;

Procedure TSales.SetAppointID(Const Value: Integer);
Begin
  SetIntegerField('AppointID', Value);
End;

Procedure TSales.CopyPropertyObjects(Const Mappedfields: STring);
Begin
  If ObjInstanceToClone Is TSmartOrder Then Begin
    Lines.Mappedfields4copy  := Mappedfields;
    Lines.MappedValues4copy  := 'SmartOrderID=' + IntToStr(ObjInstanceToClone.ID) + ',ClassID=' + IntToStr(Self.SaleClassId);
    Lines.ObjInstanceToClone := TBusObj(TSmartOrder(ObjInstanceToClone).Lines);
    Try
      Lines.IterateREcords(BusObjCopy);
    Finally
    End;
    If (Self Is TSalesOrder) Or (Self Is TInvoice) Then
      If AppEnv.CompanyPrefs.CostonSalesToPO Then TSmartOrder(ObjInstanceToClone).Lines.IterateREcords(AssignProductcost);
  End
  Else If ObjInstanceToClone Is TRepairs Then Begin
    TRepairs(ObjInstanceToClone).IsConverting        := True;
    TRepairs(ObjInstanceToClone).DoProductallocation := DoProductallocation;
    Lines.Mappedfields4copy                          := Mappedfields;
    Lines.MappedValues4copy                          := 'RepairID=' + IntToStr(ObjInstanceToClone.ID);
    Lines.ObjInstanceToClone                         := TBusObj(TRepairs(ObjInstanceToClone).RepairParts);
    Try
      Lines.IterateREcords(BusObjCopy);
      UpdateRelatedIDs(TRepairs(ObjInstanceToClone).RepairParts);
    Finally

    End;
  End;

End;

Procedure TSales.UpdateRelatedIDs(OldSaleId, NewsaleId: Integer; SalesLineObj: Tsalesline);
Var
  StrSQL: String;
Begin
  StrSQL := 'Select   ' + 'Sl2.SaleLineID  NewLineId,PSL2.globalref NewParentref, SL1.RelatedProductQty , SL1.RelatedParentProductID' +
    ' from (tblsaleslines SL1 inner join tblsales S1 on S1.SaleId = Sl1.SaleID and S1.SaleID = ' + Inttostr(OldsaleId) + ' and SL1.IsRelatedProduct = "T" )  ' +
    ' inner join (tblsaleslines SL2 inner join tblsales S2 on S2.SaleID = SL2.saleId and S2.SaleId = ' + Inttostr(NewsaleId) + ') on Sl1.ProductId = Sl2.ProductId and SL1.SeqNo = SL2.Seqno  ' +
    ' inner join tblSaleslines PSL1 on  PSL1.GlobalRef = Sl1.RelatedParentLineRef and PSL1.productId = SL1.RelatedParentProductID  and PSL1.Saleid = ' + Inttostr(OldsaleId) + '  ' +
    ' inner join tblSaleslines PSL2 on   PSL2.SaleId = ' + Inttostr(NewsaleId) + ' and  PSl1.ProductId = PSL2.ProductId and PSL1.SeqNo = PSL2.Seqno';
  With GetNewdataset(StrSQL, True) Do
    Try
      If Recordcount = 0 Then Exit;
      First;
      While Eof = False Do Begin
        If SalesLineObj.Locate('SaleLineId', Fieldbyname('NewLineId').AsInteger, []) Then Begin
          SalesLineObj.IsRelatedProduct     := TRue;
          SalesLineObj.RelatedProductQty    := Fieldbyname('RelatedProductQty').Asfloat;
          SalesLineObj.RelatedParentLineRef := Fieldbyname('NewParentref').AsString;
          SalesLineObj.ParentProductID      := Fieldbyname('RelatedParentProductID').AsInteger;
          SalesLineObj.PostDB;
        End;
        Next;
      End;
    Finally
      If Active Then Close;
      Free;
    End;

End;

Procedure TSales.UpdateRelatedIDs(RepairParts: TBusobj);
Var
  StrSQL: String;
Begin
  StrSQL := 'SELECT ' + ' RP1.RepairPartsID, ' + ' SL1.RelatedProductQty as RelatedProductQty, ' + '`SL1`.RelatedParentProductID as ParentProductID, ' + ' RP2.GlobalRef as ParentLineRef' + ' FROM ' +
    ' tblrepairparts AS RP1 ' + ' Inner Join tblsaleslines AS SL1 ON RP1.SaleLineId = SL1.SaleLineID ' + ' Inner Join tblsaleslines AS SL2 ON SL1.RelatedParentLineRef = SL2.GlobalRef ' +
    ' Inner Join tblrepairparts AS RP2 ON SL2.SaleLineID = RP2.SaleLineId ' + ' WHERE ' + ' RP1.RepairID =  ' + IntToStr(TRepairParts(RepairParts).RepairID);
  With GetNewdataset(StrSQL, True) Do
    Try
      If Recordcount = 0 Then Exit;
      First;
      While Eof = False Do Begin
        If TRepairParts(RepairParts).Locate('RepairPartsID', Fieldbyname('RepairPartsID').AsInteger, []) Then Begin
          TRepairParts(RepairParts).IsRelatedProduct  := TRue;
          TRepairParts(RepairParts).RelatedProductQty := Fieldbyname('RelatedProductQty').Asfloat;
          TRepairParts(RepairParts).ParentLineRef     := Fieldbyname('ParentLineRef').AsString;
          TRepairParts(RepairParts).ParentProductID   := Fieldbyname('ParentProductID').AsInteger;
          TRepairParts(RepairParts).PostDB;
        End;
        Next;
      End;
    Finally
      If Active Then Close;
      Free;
    End;
End;

Function TSales.CopyToSmartOrder: Integer;
Var
  Copiedobj            : TBusObj;
  Fbconverted          : Boolean;
  Bm, BmLines          : TBookmark;
  CleanConInTransaction: Boolean;
Begin
  CleanConInTransaction := Connection.Connection.InTransaction;
  Try
    Result := 0;
    Show_status('Converting ' + Self.XMLNodename + ' to Smart Order');
    Dataset.Disablecontrols;
    Lines.Dataset.Disablecontrols;
    Bm      := Dataset.Getbookmark;
    Bmlines := Lines.Dataset.Getbookmark;
    Try
      Try
        Connection.BeginTransOrNestedTrans(CleanConInTransaction);
        Fbconverted := Converted;
        Copiedobj   := CopyUsingTransactionMaper(TSmartOrder.Classname);
        If Copiedobj <> Nil Then Begin
          Result := Copiedobj.ID;
          Lines.IterateRecords(Ordered);
          Converted         := Fbconverted;
          AutoSmartOrderRef := TSmartOrder(Copiedobj).Globalref;
          POCreated         := True;
          PostDB;
          TSmartOrder(Copiedobj).SilentMode := Self.SilentMode;
          Connection.CommitTransOrNestedTrans(CleanConInTransaction);
          UnlockAfterCopyUsingTransactionMaper(Copiedobj);
          if Appenv.companyprefs.DonotCreatePOOnSalesToSmartOrderconvertion  then begin
            If Assigned(ShowSO) Then FshowSO(Copiedobj.ID);
          end else if (Appenv.companyprefs.CreatePOOnSalesToSmartOrderconvertion) or
             (Appenv.companyprefs.ConfirmPOCreationOnSalesToSmartOrderconvertion and Assigned(ConfirmFromGUI) and
              ( FconfirmFromGUI('Do You Wish To Automatically Create " Purchase Orders " ?', [MbYes, MbNo]) = MrYes )) then begin
              POIDs := TSmartOrder(Copiedobj).CopySmartOrderToPO;
              Connection.CommitTransOrNestedTrans(CleanConInTransaction);
              if POIDs <> '' then If Assigned(ShowPO) Then FshowPO(POIDs);
            End Else If Assigned(ShowSO) Then FshowSO(Copiedobj.ID);
          Dirty := False;
        End Else Begin
          Connection.RollbackTransOrNestedTrans(CleanConInTransaction);
          UnlockAfterCopyUsingTransactionMaper(Copiedobj);
        End;
      Except
        Connection.RollbackTransOrNestedTrans(CleanConInTransaction);
        UnlockAfterCopyUsingTransactionMaper(Nil);
      End;
    Finally
      Dataset.GotoBookmark(Bm);
      Dataset.FreeBookmark(Bm);
      Lines.Dataset.GotoBookmark(Bmlines);
      Lines.Dataset.FreeBookmark(Bmlines);
      Lines.Dataset.Enablecontrols;
      Dataset.Enablecontrols;
    End;
  Finally
    If Not CleanConInTransaction Then Connection.CommitTransaction;
  End;
End;

Function TSales.GetTSalesGroupedLines: TSalesGroupedLines;
Begin
  Result := TSalesGroupedLines(GetContainerComponent(TSalesGroupedLines, 'SaleID = ' + Inttostr(Self.ID)));
End;

// ------------------------------------------------------------------------------
{ TInvoiceLine }
// ------------------------------------------------------------------------------

Procedure TInvoiceLine.GetBaseLinePrice;
Var
  S: String;
Begin
  If (LinePrice = 0) Then
  Else If (Not(CalcQtyFromformula)) And (Not(AddingAlternateProduct)) And Appenv.CompanyPrefs.ConfirmBeforesalePricechange And (Not InternalQuantityChange) Then
    If ParthasPriceMatrix(Product.ID) And (MatrixPrice <> 0) Then
    Else Begin
      S := ProductDescNameWithRelatedParent+'''s Sale Price ' + FloatToStrF(LinePriceinc, FfCurrency, 15, 2) + ' Already Entered.' + Chr(13) + Chr(13);
      If ParthasPriceMatrix(Product.ID) And (MatrixPrice <> 0) Then
          S := S + 'Product has Price Matrix and for the selected Price Matrix Attribute (' + MatrixDesc + '), the Base Price is ' + FloattoStrF(MatrixPrice, FfCurrency, 15, CurrencyRoundPlaces) +
          Chr(13) + 'Changing the Quantity will Reassign this price.'
      Else S := S + 'Changing the Quantity Will Recalculate the Price.';
      S      := S + Chr(13) + Chr(13) + 'Do you Wish To Keep the Price?';
      If not(silentMode) and ((Not(Assigned(ConfirmFromGUI))) Or (FconfirmFromGUI(S, [MbYes, MbNo]) = Mryes)) Then Exit;
    End;

  LogD('TInvoiceLine.GetBaseLinePrice', LbBegin);
  Try Inherited;
  Finally LogD('', LbEnd);
  End;
End;


function TInvoiceLine.getDispatchstarted: Boolean;
var
  Qry:TERPQuery;
begin
  Qry := DbSharedObj.GetQuery(connection.Connection);
  try
    if Qry.Active then Qry.Close;
    Qry.SQL.Text := 'Select sum(Qty) qty from tblsalesdispatchlines where saleLineID =' + inttostr(ID);
    Qry.open;
    result := Qry.FieldByName('Qty').asFloat <> 0;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;

end;

Procedure TInvoiceLine.CalcLineTotals;
Begin
  LogD('TInvoiceLine.CalcLineTotals', LbBegin);
  Try
    If Self.Id = 0 Then Exit;
    Inherited;
    Invoiced := (QtyShipped <> 0);
  Finally LogD('', LbEnd);
  End;
End;

Constructor TInvoiceLine.Create(AOwner: TComponent);
Begin
  Inherited;
  FBusObjectTypeDescription := 'Invoice Line Object';
End;

Destructor TInvoiceLine.Destroy;
Begin
  Inherited;
End;

Procedure TInvoiceLine.DoFieldOnChange(Sender: TField);
Begin
  LogD('TInvoiceLine.DoFieldOnChange - ' + Sender.FieldName, LbBegin);
  Try
    If SysUtils.Sametext(Sender.FieldName, 'ProductName') Then Begin
      If IsComboSpecialVal(Sender.AsString) Then Exit;
    End;
    If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
      If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.
    If Sysutils.SameText(Sender.FieldName, 'UnitofMeasureQtySold') Then Begin
      If Not RawMode Then Begin

      End;
    End
    Else If Sysutils.SameText(Sender.FieldName, 'UnitofMeasureShipped') Then Begin
      If Not RawMode Then Begin
        { change the date when shipped qty changes to a non-zero value }
        If Sender.AsFloat <> 0 Then Begin
          If TInvoice(Self.Owner).SaleDate <> Date Then Begin
            { only the shiped date should be changed, not the salesdate }
            If (ProductName = PAYMENT_DISCOUNT_PRODUCT) Or (ProductName = INVOICE_RETENTION_PRODUCT) Or (ProductName = PART_PCENT_DISC) Or (ProductName = PART_DOL_DISC) Or
              (ProductName = PART_PCENT_SURCH) Or (ProductName = PART_DOL_SURCH)  Or (ProductName = PART_OVERDUE_SURCH) Then Begin
              { don't mess with dates }
            End Else Begin
              TInvoice(Self.Owner).ShipDate := Date;
            End;
          End;
        End;
      End;
    End;
    Inherited;
  Finally LogD('', LbEnd);
  End;
End;

Procedure TInvoiceLine.LoadFromXMLNode(Const Node: IXMLNode);
Begin
  Inherited;
  SetPropertyFromNode(Node, 'ProgresspaymentRef');
  SetPropertyFromNode(Node, 'SOInvoiceLineRef');
  SetPropertyFromNode(Node, 'PPGRef');
  SetBooleanPropertyFromNode(Node, 'PPGInvoiced');
End;

procedure TInvoiceLine.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

Procedure TInvoiceLine.SaveToXMLNode(Const Node: IXMLNode);
Begin
  Inherited;
  AddXMLNode(Node, 'ProgresspaymentRef', ProgresspaymentRef);
  AddXMLNode(Node, 'SOInvoiceLineRef', SOInvoiceLineRef);
  AddXMLNode(Node, 'PPGRef', PPGRef);
  AddXMLNode(Node, 'PPGInvoiced', PPGInvoiced);
End;

Procedure TInvoiceLine.GetProductDetails;
Begin

  LogD('TInvoiceLine.GetProductDetails', LbBegin);
  Try
    Inherited;
  Finally
    LogD('', LbEnd);
  End;
End;

// ------------------------------------------------------------------------------
{ TInvoice }
// ------------------------------------------------------------------------------

Constructor TInvoice.Create(AOwner: TComponent);
Begin
  Inherited;
  FBusObjectTypeDescription := 'Invoice Object';
  ConvertingSO              := False;
  ConvertingRepairs         := False;
  ConvertingHire         := False;
  FOriginalSale             := Nil;
  ISMergingSO               := False;
  FTotalPrePayment          := Nil;
  CreatingsalesOrderInvoice := False;
End;

Function TInvoice.DeleteFlaggedLines: Boolean;
Begin
  Result := Inherited DeleteFlaggedLines;
  If Not(Result) Then Exit;

  GetNewDataset('update tblsales S ' + ' inner join tblsaleslines SL on S.saleId = SL.saleId' +
    ' Set S.UsedOnManifest = if((Select count(*) ctr from tblmanifestlines ML where ML.InvoiceLineID = SL.SaleLineID)>0  , "T","F")' + ' where S.saleId = ' + Inttostr(ID) +
    ' and  S.IsManifest  ="T";', True);
End;

Destructor TInvoice.Destroy;
Begin
  If Assigned(FTotalPrePayment) Then Begin
    If FTotalPrePayment.Active Then FTotalPrePayment.Close;
    Freeandnil(FTotalPrePayment);
  End;
  Inherited;
End;

Function TInvoice.GetInvoiceLines: TInvoiceLine;
Begin
  Result := TInvoiceLine(GetContainerComponent(TInvoiceLine, 'SaleID = ' + IntToStr(Self.Id)));
End;

function TInvoice.getisPrinted: Boolean;
begin
  Result := PrintDoc.Count > 0;
end;

Procedure TInvoice.DoFieldOnChange(Sender: TField);
Begin
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.

  If Sysutils.SameText(Sender.FieldName, 'SaleDate') Then Begin
    If Not RawMode Then Begin
      ShipDate := IncDay(SaleDate, AppEnv.CompanyPrefs.ShippedDaysAfterCreate);

      (* if AppEnv.CompanyPrefs.UseShippedDateForTerms then
        SetPaymentTerms(ShipDate)
        else
        SetPaymentTerms(SaleDate); *)
      InitPaymentTerms;
    End;
  end
  else If Sysutils.SameText(Sender.FieldName, 'ShipDate') Then Begin
    If Not RawMode Then Begin
      if AppEnv.CompanyPrefs.MatchInvoiceDateToShipDate then
        SaleDate := ShipDate;
    End;
  End;

  Inherited;

  If Sysutils.SameText(Sender.FieldName, 'ShipDate') Then Begin
    If Not RawMode Then Begin
      (* if AppEnv.CompanyPrefs.UseShippedDateForTerms then
        SetPaymentTerms(ShipDate)
        else
        SetPaymentTerms(SaleDate); *)
      InitPaymentTerms;
    End;
  End
  Else If Sysutils.SameText(Sender.FieldName, 'QuoteStatus') Then Begin
    SendEvent(BusObjEvent_Change, BusobjEvent_Invoicestatus, Self);
  End;
End;

Procedure TInvoice.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
Begin
  Inherited;
  If Assigned(FTotalPrePayment) Then Begin
    If FTotalPrePayment.Active Then FTotalPrePayment.Close;
    Freeandnil(FTotalPrePayment);
  End;

  If (ChangeType = DcNew) Or ((ChangeType = DcLoad) And (Id < 1)) Then Begin
    // Save so autoinc id is assigned
    If Not IsInvoice Then Begin
      IsInvoice    := True;
      IsCashSale   := False;
      IsRefund     := False;
      IsSalesOrder := False;
      IsQuote      := False;
      IsPos        := False;
      PostDB;
    End;
  End;
  ConvertingSO      := False;
  ConvertingRepairs := False;
  ConvertingHire := False;
  If Assigned(FOriginalSale) Then Freeandnil(FOriginalSale);
End;

Procedure TInvoice.InitializeNewObject;
Begin
  IsInvoice    := True;
  IsCashSale   := False;
  IsRefund     := False;
  IsSalesOrder := False;
  IsQuote      := False;
  Inherited;
End;

Procedure TInvoice.CalcOrderTotals;
Begin
  LogD('TInvoice.CalcOrderTotals', LbBegin);
  Try
    Show_Status('Calculating totals.');
    Try
      Inherited;
      IsPaid := ((TotalBalance = 0) And (TotalAmountInc = TotalPaid)) And (TotalAmountInc <> 0);
    Finally Show_Status('');
    End;
  Finally LogD('', LbEnd);
  End;
End;
function TInvoice.PayInvoice(aPaymentMethod:String; aDate_paid:TDatetime): Boolean;
var
  CustPayment : TCustPayments;
begin
  result := True;
  if TotalBalance <=0 then exit;

  Connection.BeginNestedTransaction;
  try
    CustPayment := TCustPayments.create(Self);
    try
      CustPayment.connection := self.connection;
      CustPayment.load(0);
      CustPayment.New;
      CustPayment.CompanyName   := Self.customerName;
      CustPayment.PayMethodName := aPaymentMethod;
      CustPayment.PaymentDate   := aDate_paid;
      CustPayment.PostDB;
      CustPayment.guiLines;
      if not CustPayment.guiLines.Dataset.locate('SaleID' , ID , []) then begin
        Connection.RollbackNestedTransaction;
        Result := False;
        Exit;
      end;
      CustPayment.guiLines.Applied := true;
      CustPayment.guiLines.PostDB;
      CustPayment.Amount := CustPayment.applied;
      CustPayment.postdb;
      if not CustPayment.Save then begin
        Connection.RollbackNestedTransaction;
        Result := False;
        Exit;
      end;
      Connection.CommitNestedTransaction;
      Result := True;
    finally
      Freeandnil(CustPayment);
    end;
  Except
    on E:Exception do begin
      Connection.RollbackNestedTransaction;
    end;
  end;
end;

Procedure TInvoice.PopulateClientData;
Begin
  Inherited;

  If Customer.UseCustomerInvoiceNo Then
    If ClientID <> 0 Then
      If Customer.Lock Then Begin
        Try
          { the following updation is outside transaction }
          GetNewDataSet(' update tblClients Set  InvBaseNumber := InvBaseNumber + 1 where ClientID = ' + IntToStr(Customer.ID));
          With GetNewDataSet(' Select InvBaseNumber from tblClients  where ClientID = ' + IntToStr(Customer.ID)) Do
            Try DocNumber := FieldByname('InvBaseNumber').AsString;
            Finally
              Close;
              Free;
            End;
        Finally Customer.Unlock;
        End;
      End Else Begin
        ResultStatus.AddItem(False, RssWarning, 0, Customer.ClientName +
          ' has ''Use Individual Invoice No'' set to True. Creating Invoice for this customer needs to update the Customer''s next invoice number.' + Chr(13) + Customer.UserLock.LockMessage, True);
        ClientID := 0;
      End;

  (* if AppEnv.CompanyPrefs.UseShippedDateForTerms then
    SetPaymentTerms(ShipDate)
    else
    SetPaymentTerms(SaleDate); *)
  InitPaymentTerms;

End;

Procedure TInvoice.ProcessDeletedLine;
Begin
  Inherited;
  If Lines.Deleted Then Begin
    If Not Lines.CanLockManifest Then Begin
      Lines.Deleted := False;
      Lines.PostDB;
      Exit;
    End;
    GetNewDataset('Delete from tblmanifestlines where  InvoiceLineID = ' + Inttostr(Lines.ID) + ' and ifnull(SaleLineID,0) = 0; ' +
      'update tblmanifestlines set InvoiceLineID = 0 where ifnull(InvoiceLineID,0) = ' + Inttostr(Lines.ID) + ';', True);
  End;
End;

Function TInvoice.ValidateData: Boolean;
Begin
  Show_Status('Validating .');
  If Deleted Or Cancelled Then Begin
    Result := True;
    Exit;
  End;

  Result := Inherited ValidateData;
  If Not Result Then Exit;

  if (not Signed) and SignatureRequired then
  begin
    ResultSTatus.AddItem(false, RssWarning, 0, 'Invoice: ' + IntToStr(ID) + ' Contains Signature Enforced Product, ' +
     'But Has Not Yet Been Signed');
    Result := false;
    exit;
  end;

  If (Not RawMode) And (SaleDate <= AppEnv.CompanyPrefs.ClosingDateAR) Then Begin
    Resultstatus.AddItem(False, RssWarning, 0, 'Invoice:' + IntToStr(ID) + ' Has Sale Date (' + FormatDateTime(FormatSettings.ShortDateformat, SaleDate) + ')' + ' Prior to the Closing Date (' +
      FormatDateTime(FormatSettings.ShortDateformat, AppEnv.CompanyPrefs.ClosingDateAR) + ').'+NL+
      'To fix this, Under Preferences -> Accounts, Change the 4 Global Closing Dates to Prior to the The Sale Date(' + FormatDateTime(FormatSettings.ShortDateformat, SaleDate) + ')');
    Result := False;
    Exit;
  End;
  REsult := ValidateLines;
End;

Procedure TInvoice.LineValidateCallbackProc(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  Show_Status('Validating Invoice Lines : ' + IntToStr(Sender.Dataset.Recno) + ' of ' + IntToStr(Sender.Dataset.Recordcount));
  If Not TInvoiceLine(Sender).ValidateData Then Begin
    AllLinesValid := False;
    Abort         := True;
  End;
End;

Procedure TInvoice.Load(Const FIsReadonly: Boolean = False);
Begin
  Inherited;
End;

Procedure TInvoice.LoadFromXMLNode(Const Node: IXMLNode);
Begin
  Inherited;
  SetPropertyFromNode(Node, 'SOProgressPaymentGlobalRef');
  SetPropertyFromNode(Node, 'SOInvoiceRef');
  SetPropertyFromNode(Node, 'SOProgressPaymentOriginalRef');
  SetBooleanPropertyFromNode(Node, 'SOInvoiced');

End;

function TInvoice.Lock: Boolean;
begin
  REsult := Inherited Lock;
  If Not Result Then Exit;
  if isinternalOrder then begin
    Result := False;
    AccessManager.AccessLevel := 5;
  end;
end;

function TInvoice.LockTrans(var ErrMsg: String): Boolean;
begin
  result := inherited LockTrans(ErrMsg);
  if not result then exit;
end;

Procedure TInvoice.SaveToXMLNode(Const Node: IXMLNode);
Begin
  Inherited;
  AddXMLNode(Node, 'SOProgressPaymentGlobalRef', SOProgressPaymentGlobalRef);
  AddXMLNode(Node, 'SOProgressPaymentOriginalRef', SOProgressPaymentOriginalRef);
  AddXMLNode(Node, 'SOInvoiceRef', SOInvoiceRef);
  AddXMLNode(Node, 'SOInvoiced', SOInvoiced);
End;

procedure TSales.setEmployeeLogonName(const Value: String);begin  EmployeeId := EmployeeIdforLogonName(Value);end;



Function TInvoice.CopyInvoiceToInvoice: Integer;
Begin
  Result           := 0;
  CopyingToInvoice := True;
  Try
    FieldsnotToclone := QuotedStr('IsPaid') + ',' + QuotedStr('TotalBalance') + ',' + QuotedStr('TotalPaid') + ',' + QuotedStr('ForeignPaidAmount') + ',' + QuotedStr('ForeignBalanceAmount') + ',' +
      QuotedStr('BOID') + ',' + QuotedStr('Originalno') + ',' + QuotedStr('baseno') + ',' + QuotedStr('DueDate');
    If Self.CloneBusObj('SaleDate', DateOf(Now), False, 'SaleID') <> Nil Then Begin
      Lines.Iteraterecords(ReActivatePQAs);
      TInvoice(ObjInstanceToClone).Converted := False;
      TInvoice(ObjInstanceToClone).Deleted   := False;
      TInvoice(ObjInstanceToClone).InitPaymentTerms;
      TInvoice(ObjInstanceToClone).PostDb;
      TInvoice(ObjInstanceToClone).Save;
      Result := TInvoice(ObjInstanceToClone).ID;

      { IJB - Copy Shipment List .. if there is one }
      { only copy is nothing processed }
      If (Self.ShipmentList.Count > 0) And (Self.ShipmentList.Status = 'Not Processed') Then Begin
                  try
                    Self.ShipmentList.Copy(Self, TInvoice(ObjInstanceToClone));
                  Except
                    on E:Exception do begin
                      ResultStatus.AddItem(False, RssWarning, 0, 'Copy of Shipment failed. ' + E.message);
                    end;
                  end;

      End;

      UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
      Self.ShipmentList.UserLock.UnlockAllCurrentInstance;
      TInvoice(ObjInstanceToClone).UserLock.UnlockAllCurrentInstance;
    End;
  Finally CopyingToInvoice := False;
  End;
End;

Function TInvoice.CopyInvoiceToSmartOrder: Integer;
Begin
  Result := CopyToSmartOrder;
  UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
End;

Procedure TInvoice.deleteInvoiceCallback(Const Sender: TBusObj; Var Abort: Boolean);
begin
  if not(Sender is TInvoice) then exit;
  TInvoice(Sender).Lines.DeleteAll;
  TInvoice(Sender).Comments :=TInvoice(Sender).Comments +'Original Invoice of the Progress payment #' + quotedstr(TInvoice(Sender).ProgressPaymentInvRef) +' is Changed';
  TInvoice(Sender).CalcOrdertotals;  // to re calculate the totals after lines deleted
  TInvoice(Sender).Deleted := (TInvoice(Sender).lines.Count =0); // if any line is locked and cannot be deleted, the invoice shouldn't be flagged as deleted
  TInvoice(Sender).PostDB;
end;

Function TInvoice.Save: Boolean;
Var
  Fsfilter        : String;
  Fbfiltered      : Boolean;
  BackOrder       : TInvoice;
  CombinedTransRef: String;
  StrSQL          : String;
  fsComments: STring;

  Function CreateSmartOrder: Boolean;
  Begin
    Result := True;
    If BaseNo = '' Then
      If AutoSmartOrderRef = '' Then
        If Lines.Count > 0 Then Begin
          Fsfilter                                   := Lines.Dataset.Filter;
          Fbfiltered                                 := Lines.Dataset.Filtered;
          If Fsfilter = '' Then Lines.Dataset.Filter := 'AutoSmartOrder = ''T'' '
          Else Lines.Dataset.Filter                  := Lines.Dataset.Filter + ' and AutoSmartOrder = ''T'' ';
          Lines.Dataset.Filtered                     := True;
          Try
            If Lines.Count > 0 Then Begin
              Result := CopyInvoiceToSmartOrder > 0;
            End;
          Finally
            If Result Then Lines.Iteraterecords(Ordered);
            Lines.Dataset.Filter   := FsFilter;
            Lines.Dataset.Filtered := Fbfiltered;
            If Result Then Dirty   := False;
          End;
        End;
  End;
  function  CheckforPPInvoices:Boolean;
    var
      PPInvoice:TInvoice;
      Qry :TERPQuery;
//      PPInvoices:TInvoice;
      fiProgressPaymentLineID:Integer;
      fb:Boolean;
      ctr:Integer;
      ctrOut : integer;
      fdtotalExPPEx     , fdtotalExPPInc:Double;
      fdtotalExPPExInst , fdtotalExPPIncInst:Double;
      fdtotalExPPExDone , fdtotalExPPIncDone:Double;
      sProgressPaymentInvoices :String;
  begin
    REsult := False;
        PPInvoice:=TInvoice.create(nil);// owner nil not to use the form dataset
        try
          SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
          fiProgressPaymentLineID := ProgressPaymentLineID;

          Qry := GetSharedDataSet('Select * from tblSalesLines where saleLineID = '+inttostr(fiProgressPaymentLineID)+' and deleted ="F"' ,True);
          try
            {Sales amount - ex the negated amount}
            fdtotalExPPEx   := TotalAmount - Qry.FieldByName('totalLineAmount').AsFloat;
            fdtotalExPPInc  := TotalAmountinc - Qry.FieldByName('totalLineAmountInc').AsFloat;
          finally {Qry}
              DbSharedObj.ReleaseObj(Qry);
          end;
          sProgressPaymentInvoices :='';
          Connection.BeginNestedTransaction;
          PPInvoice.Connection := Self.Connection;
          SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
          try
            if (fdtotalExPPEx <> 0) and  Terms.ISProgressPayment and (Terms.ProgressPaymentInstallments>1) then begin
    {------------Make the progrss PaymentLine to negate the amount}

                fdtotalExPPExInst := round(DivZer(fdtotalExPPEx  , Terms.ProgressPaymentInstallments), CurrencyRoundPlaces); {installment amount}
                fdtotalExPPIncInst:= round(DivZer(fdtotalExPPInc , Terms.ProgressPaymentInstallments), CurrencyRoundPlaces);


                if fiProgressPaymentLineID =0 then begin
                  Lines.New;
                  Lines.ProductName := PART_PROGRESSPAYMENT_TERMS;
                  Lines.QtySold:= 1;
                  Lines.QtyShipped:=1;
                  //sProgressPaymentInvoices :='Sales Amount Adjusted Based on Progress Payment Terms';
                end else begin
                  Lines.Locate('SaleLineId' ,fiProgressPaymentLineID , [] );
                end;
                if TErms.ProgressPaymentfirstPayonSaleDate then begin
                  fdtotalExPPExDone   := fdtotalExPPExInst; {total Posted}
                  fdtotalExPPIncDone  := fdtotalExPPIncInst;
                end else begin
                  fdtotalExPPExDone   := 0;
                  fdtotalExPPIncDone  := 0;
                end;
                if not(SameValue(Lines.LinePrice   ,  0-(fdtotalExPPEx-fdtotalExPPExDone ) ,0.00001)) or
                   not(SameValue(Lines.LinePriceinc,  0-(fdtotalExPPInc-fdtotalExPPIncDone),0.00001)) then begin
                  fb := Lines.DoFieldChange;
                  Lines.DoFieldChange:= false;
                  try
                    Lines.LinePrice         := 0-(fdtotalExPPEx -fdtotalExPPExDone);
                    Lines.LinePriceinc      := 0-(fdtotalExPPInc-fdtotalExPPIncDone);

                    Lines.totalLineAmount   := Lines.LinePrice;
                    Lines.totalLineAmountInc:= Lines.LinePriceinc;

                    Lines.LineTaxTotal      := 0-(Lines.totalLineAmountInc-Lines.totalLineAmount);
                  finally
                    Lines.DoFieldChange:= fb;
                  end;
                  Lines.PostDB;
                end;

    {------------Make Progress Payment Invoices}
                (*fdtotalExPPExInst := round(DivZer(fdtotalExPPEx  , Terms.ProgressPaymentInstallments), CurrencyRoundPlaces); {installment amount}
                fdtotalExPPIncInst:= round(DivZer(fdtotalExPPInc , Terms.ProgressPaymentInstallments), CurrencyRoundPlaces);*)

                (*fdtotalExPPExDone   := fdtotalExPPExInst; {total Posted}
                fdtotalExPPIncDone  := fdtotalExPPIncInst;*)
                SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
                ctrOut := 0;
                for ctr := 1 to iif(TErms.ProgressPaymentfirstPayonSaleDate , Terms.ProgressPaymentInstallments-1 , Terms.ProgressPaymentInstallments) do begin
                  ctrOut := ctr;
                  PPInvoice.LoadSelect('ProgressPaymentInvRef =' + quotedstr(Globalref)+' and ProgressPaymentSeqno =' + inttostr(ctr));
                  PPInvoice.SilentMode := true;
                  if PPInvoice.count =0  then PPInvoice.New;

                  copyobjRec('SaleId' ,PPInvoice.ID , PPInvoice);
                  PPInvoice.TermsName := TTerms.DueonReceipt;
                  PPInvoice.EmployeeName := EmployeeName;

                  PPInvoice.ProgressPaymentInvRef := GlobalRef;
                  PPInvoice.ProgressPaymentSeqno := ctr;
                  PPInvoice.DocNumber := PPInvoice.DocNumber +'-' + inttostr(ctr);
                  PPInvoice.PostDB;
                  PPInvoice.OriginalDocNumber := PPInvoice.Globalref;
                  PPInvoice.BackOrderGlobalRef := '';
                  PPInvoice.PostDB;
                  if not PPInvoice.Lines.Locate('Productname' , PART_PROGRESSPAYMENT_TERMS , []) then begin
                    PPInvoice.Lines.New;
                    PPInvoice.Lines.ProductName := PART_PROGRESSPAYMENT_TERMS;
                    PPInvoice.Lines.QtySold:= 1;
                    PPInvoice.Lines.QtyShipped:=1;
                    PPInvoice.Lines.shipdate:= Terms.InstallmentDate(duedate , ctr);
                  end;
                  PPInvoice.Duedate   := Terms.InstallmentDate(duedate , ctr);
                  fb :=Lines.DoFieldChange;
                  PPInvoice.Lines.DoFieldChange:= false;
                  Try
                    if ctr < Terms.ProgressPaymentInstallments  then begin
                        PPInvoice.Lines.LinePrice     := (fdtotalExPPExInst );
                        PPInvoice.Lines.LinePriceinc  := (fdtotalExPPIncInst);
                    end else begin
                        {Last installment with the remaining to avoid rounding issue}
                        PPInvoice.Lines.LinePrice     := (fdtotalExPPEx-fdtotalExPPExDone );
                        PPInvoice.Lines.LinePriceinc  := (fdtotalExPPInc-fdtotalExPPIncDone);
                    end;
                    PPInvoice.Lines.totalLineAmount   :=PPInvoice.Lines.LinePrice;
                    PPInvoice.Lines.totalLineAmountInc:= PPInvoice.Lines.LinePriceInc;
                    PPInvoice.Lines.LineTaxTotal      := (PPInvoice.Lines.totalLineAmount - PPInvoice.Lines.totalLineAmountInc);

                    fdtotalExPPExDone  := fdtotalExPPExDone   + PPInvoice.Lines.totalLineAmount; {total Posted}
                    fdtotalExPPIncDone := fdtotalExPPIncDone  + PPInvoice.Lines.totalLineAmountInc;
                  Finally
                     PPInvoice.Lines.DoFieldChange:= fb;
                  End;
                  PPInvoice.Lines.PostDb;
                  if sProgressPaymentInvoices <> '' then sProgressPaymentInvoices := sProgressPaymentInvoices +',';
                  sProgressPaymentInvoices := sProgressPaymentInvoices + inttostr(PPInvoice.ID);
                  if not PPInvoice.Save then begin
                     PPInvoice.Connection.RollbackNestedTransaction;
                     Exit;
                  end;
                  SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
                end;
// ctr after loop can be anything, potencially it is a bug
//                PPInvoice.LoadSelect('ProgressPaymentInvRef =' + quotedstr(Globalref)+' and ProgressPaymentSeqno >' + inttostr(ctr));
                PPInvoice.LoadSelect('ProgressPaymentInvRef =' + quotedstr(Globalref)+' and ProgressPaymentSeqno >' + inttostr(ctrOut));
                PPInvoice.Iteraterecords(deleteInvoiceCallback);
                SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
                ProgressPaymentInvoices :=sProgressPaymentInvoices;
                  //Comments := Trim(Comments +NL+'Sales Amount Adjusted Based on Progress Payment Terms.'+NL+'Progress Payment Invoices : '+sProgressPaymentInvoices'
            end else begin {if not progress payment}
              if (fiProgressPaymentLineID<>0) and Lines.Locate('SaleLineId' ,fiProgressPaymentLineID , [] ) then begin
                Lines.Deleted :=True;
                Lines.PostDB;
              end;
              SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
              PPInvoice.LoadSelect('ProgressPaymentInvRef =' + quotedstr(Globalref));
              PPInvoice.Iteraterecords(deleteInvoiceCallback);
              SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
            end;
            Connection.CommitNestedTransaction;
            REsult := True;

          Except {transaction}
            on E:Exception do begin
              PPInvoice.Connection.RollbackNestedTransaction;
            end;
          end;
        finally {ppinvoice}
          FreeandNil(PPInvoice);
        end;
  end;
Begin
  Result := False;
  ResultStatus.Clear;
  fiProgresscount := 10;
  SendEvent(BusobjEvent_ToDo, BusobjEvent_ShowProgressbar, Self);
  try
    Try
      Try
        PostDB;
        If (Not(ConvertingSO)) And (Not(ConvertingRepairs)) And (Not(ConvertingHire)) Then PostList.Clear;
        SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
        If Not ValidateData Then Exit;
        If Not SaveGUIValidate Then Exit;
        SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
        CalcOrderTotals;
        fsComments:= Comments;
        if ProgressPaymentInvRef = '' then  // if not a progress Payment invoice
          if CheckForPPInvoices then
            CalcOrderTotals;

        SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
        If UpdateAccounts Then Begin
          Result := Inherited Save;
          If Not Result Then Exit;
        SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);

          { now validate then invoice lines }
          AllLinesSavedOK := True;
          //Lines.IterateRecords(LineSaveCallbackProc, True);

          Fbfiltered := Lines.filtered;
          Lines.filtered:= False;
          try
            Lines.IterateRecords(LineSaveCallbackProc, True);
          finally
            Lines.filtered:= Fbfiltered;
          end;
          Result := AllLinesSavedOK;
          SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
          If Result Then Begin
            { converting SO converts its BOs too, so skip the BO creation of invoice. }
            If (UpdatingBo = False) And (DeletingTomergeOutstandingsale = False) Then
              If (Not(ConvertingSO)) Or (ISMergingSO) Then Begin
                BackOrder := TInvoice(TComponentClass(FindClass(Self.ClassName)).Create(nil));
                Try
                  BackOrder.Connection := Self.Connection; // this connection expected to be wihtin transaction
                  BackOrder.LoadSelect('GlobalRef = ' + QuotedStr(Self.BackOrderGlobalRef));
                  (* BackOrder.IgnoreAccesslevel := True; *)
                  BackOrder.IgnoreAccessLevel :=IgnoreAccessLevel ;
                  BackOrder.AccessManager.AccessLevel := 1;
                  BackOrder.IgnoreAccessLevel :=IgnoreAccessLevel ;
                  BackOrder.UpdatingBo                := True;
                  CombinedTransRef                    := Customer.CombinedInvoiceBOID;
                  CheckBackOrders(BackOrder, Appenv.CompanyPrefs.CombinedInvoiceBO, CombinedTransRef);
                  if BackOrder.count =1 then begin
                    BackOrder.Comments := fsComments ;
                    BackOrder.PostDB;
                  end;
                  ProcessPQADetailClasses;
                  If (Appenv.CompanyPrefs.CombinedInvoiceBO) And (CombinedTransRef <> Customer.CombinedInvoiceBOID) Then Begin
                    StrSQL := 'Update tblClients Set  CombinedInvoiceBOID = ' + QuotedStr(CombinedTransRef) + ' where clientId = ' + IntToStr(Customer.ID);
                    PostList.AddQuery(StrSQL, Customer.ID, Customer.BusObjectTableName, True);
                  End;
                Finally
                  FreeandNil(BackOrder);
                End;
              End;
            If Not PostList.Execute Then Begin
              Result := False;
              Exit;
            End;
          End;
          SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
        End Else Begin
          Result := False;
        End;
        If Result Then Begin
          Dirty := False;
          Try
            If Lines.Count = 0 Then begin
                TLeadToAddProgressionRecord.AddProgressionRecord(ClientID, LeadActionInvoice, Id, GlobalRef, Comments, SaleDate, Id, Globalref, True, EmployeeId,
                GetSimpleType('Deleted', SimpleTypes_StatusType));
            end Else Begin
              If CleanCustomerID <> 0 Then begin // delete it from the old client if the client is changed
                  TLeadToAddProgressionRecord.AddProgressionRecord(CleanCustomerID, LeadActionInvoice, Id, GlobalRef, 'Deleted ' + XMLNodeName + ' # ' + Inttostr(ID) + '  from ' +
                  Quotedstr(Cleancustomer) + '. Moved to Customer : ' + Quotedstr(CustomerName) + NL + Comments, SAleDate, Id, Globalref, True, EmployeeId,
                  GetSimpleType('Changed Customer', SimpleTypes_AppointmentStatusType, True));
              end;
              TLeadToAddProgressionRecord.AddProgressionRecord(ClientID, LeadActionInvoice, Id, GlobalRef, Comments, SaleDate, Id, Globalref, True, EmployeeID);
            End;
            UpdateBORefs;
          Except
            On E: Exception Do Begin
            End;
          End;
        End;
        SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
      Finally
        If Result Then Lines.IterateRecords(UpdateCustomerEquipQty);
        If UpdatingBo = False Then Show_Status('');
      End;
    Finally
      If Result Then Result := Validtocommit;
    End;
  finally
      SendEvent(BusobjEvent_ToDo, BusobjEvent_HideProgressbar, Self);
  end;
  If Result Then Begin
    RewardPoints;
    If DeleteFlaggedLines Then Begin
      Dirty  := False;
      Result := CreateSmartOrder;
    End Else begin
      Result := False;
    end;
  End;
End;

function TInvoice.SaveCancelled: boolean;
Begin
  if CreatingsalesOrderInvoice Then result := false
  else result := inherited;
End;

Procedure TInvoice.LineSaveCallbackProc(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  // if Assigned(Progressbar) then Progressbar.Stepit;
  Show_Status('Updating Product''s Quantity : ' + IntToStr(Sender.Dataset.Recno) + ' of ' + IntToStr(Sender.Dataset.Recordcount));
  If UpdatingBo = False Then TInvoiceLine(Sender).ChangeOrderQty;
  If Not TInvoiceLine(Sender).Save Then Begin
    AllLinesSavedOK := False;
    Abort           := True;
  End;
End;

Function TInvoice.UpdateAccounts: Boolean;
Var
  CleanNode          : IXMLNode;
  CleanCustomerID    : Integer;
  CleanTotalAmountInc: Double;
  CleanGLAccountID   : Integer;
  TaxCollectedID     : Integer;
  WETTaxID           : Integer;
Begin
  Show_Status('Update Accounts.');
  // BalancePostList.Clear;
  TaxCollectedID := TcDataUtils.GetAccountID(TcConst.GLACCOUNT_TAX_COLLECTED);
  WETTaxID       := TcDataUtils.GetAccountID(TcConst.GLACCOUNT_TAX_WET);

  CleanNode := Self.CleanXMLNode;
  If Assigned(CleanNode) And (CleanNode.ChildNodes.Count > 0) Then Begin
    CleanTotalAmountInc := GetXMLNodeFloatValue(CleanNode, 'TotalAmountInc');
    CleanCustomerID     := GetXMLNodeIntegerValue(CleanNode, 'CustomerID');
    If (CleanTotalAmountInc = 0) And (CleanCustomerID = 0) Then
    Else Begin
      { we have clean (original) values so these need to be reversed }
      If CleanCustomerID <> 0 Then Begin
        PostList.AddAmount(Customer.ClassName, Customer.BusObjectTableName, CleanCustomerID, -CleanTotalAmountInc, BtAR);

        { Old GL Balance }
        CleanGLAccountID := GetXMLNodeIntegerValue(CleanNode, 'GLAccountID');
        PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, CleanGLAccountID, -CleanTotalAmountInc);

        { Old tax amounts }
        PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, TaxCollectedID, -(GetXMLNodeFloatValue(CleanNode, 'TotalTax') - GetXMLNodeFloatValue(CleanNode, 'TotalWETTax')));

        PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, WETTaxID, -GetXMLNodeFloatValue(CleanNode, 'TotalWETTax'));
      End;
    End;
  End;
  { converting SO should reduce SOBalance and add the balance to the Customer }
  { New customer balance }
  PostList.AddAmount(Customer.ClassName, Customer.BusObjectTableName, CustomerID, Self.TotalAmountInc, BtAR);

  { Now GL balances . }
  PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, GLAccountId, TotalAmountInc);

  { Tax amounts }
  PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, TaxCollectedID, (TotalTax - TotalWETTax));

  PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, WETTaxID, TotalWETTax);

  { Get balance amounts from lines }
  Lines.IterateRecords(LineBalanceCallbackProc, True);
  Result := True;
End;

Procedure TInvoice.LineBalanceCallbackProc(Const Sender: TBusObj; Var Abort: Boolean);
Var
  CleanNode: IXMLNode;
Begin
  Show_Status('Update Accounts : ' + IntToStr(Sender.Dataset.Recno) + ' of ' + IntToStr(Sender.Dataset.Recordcount));
  CleanNode := Sender.CleanXMLNode;
  If Assigned(CleanNode) Then Begin
    { Reverse old values }
    { Income }
    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, TcDataUtils.GetAccountID(GetXMLNOdeStringValue(CleanNode, 'IncomeAccount')),
      -GetXMLNodeFloatValue(CleanNode, 'TotalLineAmount'));

    If IsInvProduct(GetXMLNOdeStringValue(CleanNode, 'ProductType')) Then Begin
      { COGS }
      PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, TcDataUtils.GetAccountID(GetXMLNOdeStringValue(CleanNode, 'CogsAccount')),
        -(GetXMLNodeFloatValue(CleanNode, 'LineCost') * GetXMLNodeFloatValue(CleanNode, 'QtyShipped')));
      { Asset }
      PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, TcDataUtils.GetAccountID(GetXMLNOdeStringValue(CleanNode, 'AssetAccount')),
        (GetXMLNodeFloatValue(CleanNode, 'LineCost') * GetXMLNodeFloatValue(CleanNode, 'QtyShipped')));
    End;
  End;
  { New balances }
  If TInvoiceLine(Sender).Deleted = False Then Begin
    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, TcDataUtils.GetAccountID(TInvoiceLine(Sender).IncomeAccount), TInvoiceLine(Sender).TotalLineAmount);

    If IsInvProduct(TInvoiceLine(Sender).Product.ProductType) Then Begin
      { COGS }
      PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, TcDataUtils.GetAccountID(TInvoiceLine(Sender).CogsAccount),
        (TInvoiceLine(Sender).LineCost * TInvoiceLine(Sender).QtyShipped));
      { Asset }
      PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, TcDataUtils.GetAccountID(TInvoiceLine(Sender).AssetAccount),
        -(TInvoiceLine(Sender).LineCost * TInvoiceLine(Sender).QtyShipped));
    End;
  End;
End;

Function TInvoice.GetLines: TTransLineBase;
Begin
  Result                                    := Self.GetInvoiceLines;
  If Self.SilentMode Then Result.SilentMode := True;
End;

Function TInvoice.GetSaleLines: TSalesLineBase;
Begin
  Result := GetInvoiceLines;
End;


function TInvoice.GetSignatureRequired: boolean;
var
  qry : TERPQuery;
begin
  Qry := DbSharedObj.GetQuery(connection.Connection);
  try
    qry.sql.clear;
    qry.sql.add('select sum(req) from (');
    qry.sql.add('select');
    qry.sql.add('case requiresignature');
    qry.sql.add('when "T" then 1 else 0 end as req');
    qry.sql.add('from tblsales');
    qry.sql.add('inner join tblsaleslines on tblSales.saleid= tblsaleslines.saleid');
    qry.sql.add('inner join tblparts on tblparts.partsid = tblsaleslines.ProductID');
    qry.SQL.Add(Format('where tblsales.saleid=%d) temp', [SaleId]));
    qry.Open;
    Result := qry.Fields[0].AsInteger > 0;
    qry.Close;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;

function TInvoice.GetSigned: boolean;
begin
  Result := fSigned;
end;

Function TInvoice.DoAfterPost(Sender: TDatasetBusObj): Boolean;
Begin
  Inherited DoAfterPost(Sender);
  Self.Lines; // first time when the header is posted, filter the lines for the new id
  Result := True;
End;

Function TInvoice.GetOriginalSaleRec: TSales;
Begin
  If Self.OriginalDocNumber = '' Then Result                                 := Nil
  Else If Self.OriginalDocNumber = Self.GlobalRef Then Result                := Nil
  Else If Trim(Self.OriginalDocNumber) = Trim(IntToStr(Self.ID)) Then Result := Nil
  Else Begin
    If Not Assigned(FOriginalSale) Then Begin
      FOriginalSale                                       := TInvoice.Create(Nil);
      If ConnectionAssigned Then FOriginalSale.Connection := Self.Connection;
    End;
    If FOriginalSale.GlobalRef <> Self.OriginalDocNumber Then Begin
      FOriginalSale.LoadSelect('GlobalRef = ' + QuotedStr(OriginalDocNumber));
    End;
    Result := FOriginalSale;
  End;
End;

(* Function TInvoice.ISCustomerCreditOK:Boolean;
  var
  tmpBalance: double;
  DuedatewithGracePeriod:TDateTime;
  begin
  Result:= true;
  if AppEnv.CompanyPrefs.CreditCheckInv = False then exit;
  if TotalAmountInc <= 0 then exit;

  {get the current balance amount - balance amount is the invoice balance + sales order balance}
  tmpBalance:= Customer.CreditBalance;
  result := (tmpBalance + self.TotalAmountInc) >= Customer.CreditLimit ;
  if NOT result then begin
  DuedatewithGracePeriod :=incDay(DueDate, Customer.GracePeriod);
  result := (Date < DuedatewithGracePeriod) ;
  end;
  if not result  then      begin
  Result:= false;
  self.ResultStatus.AddItem(true, rssWarning, BOR_Sales_Warn_CreditExceeded,
  'Customer has Exceeded Credit Limit'#13#10 +
  'Limit: ' + CurrToStrF(Customer.CreditLimit, ffCurrency, 2) +
  '   Amount: ' +
  CurrToStrF(tmpBalance, ffCurrency, 2));
  end;
  end; *)
// ------------------------------------------------------------------------------
{ TQuoteLine }
// ------------------------------------------------------------------------------

Procedure TQuoteLine.GetBaseLinePrice;
Var
  S: String;
Begin
  If (LinePrice = 0) Then
  Else If (Not(CalcQtyFromformula)) And (Not(AddingAlternateProduct)) And Appenv.CompanyPrefs.ConfirmBeforesalePricechange And (Not InternalQuantityChange) Then
    If ParthasPriceMatrix(Product.ID) And (MatrixPrice <> 0) Then
    else if AutoResetingPrices then
    Else Begin
      S := ProductDescNameWithRelatedParent+'''s Sale Price ' + FloatToStrF(LinePriceinc, FfCurrency, 15, 2) + ' Already Entered.' + Chr(13) + Chr(13);
      //S := 'Sale Price ' + FloatToStrF(LinePriceinc, FfCurrency, 15, 2) + ' Already Entered.' + Chr(13) + Chr(13);
      If ParthasPriceMatrix(Product.ID) And (MatrixPrice <> 0) Then
          S := S + 'Product has Price Matrix and for the selected Price Matrix Attribute (' + MatrixDesc + '), the Base Price is ' + FloattoStrF(MatrixPrice, FfCurrency, 15, CurrencyRoundPlaces) +
          Chr(13) + 'Changing the Quantity will Reassign this price.'
      Else S := S + 'Changing the Quantity Will Recalculate the Price.';
      S      := S + Chr(13) + Chr(13) + 'Do you Wish To Keep the Price?';
      If ((Not(Assigned(ConfirmFromGUI))) Or (FconfirmFromGUI(S, [MbYes, MbNo]) = Mryes)) Then Exit;
    End;

  Inherited;
End;

Procedure TQuoteLine.CalcLineTotals;
Begin
  If Self.Id = 0 Then Exit;
  Inherited;

End;

procedure TQuoteLine.CalcTreePrice;
begin
  if not IsTreeItem then exit;
  if IgnoreBOMCalcPriceOnSale then exit;
  inherited;
  DoContainerEvent(Self, EvSalesLineCalcTreePrice);
end;

Constructor TQuoteLine.Create(AOwner: TComponent);
Begin
  Inherited;
  FBusObjectTypeDescription := 'Quote Line Object';
  // StartLogtime;
End;

Destructor TQuoteLine.Destroy;
Begin

  Inherited;
End;

Function TQuoteLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
Begin
  Result   := Inherited;
  Invoiced := True;
End;

Procedure TQuoteLine.DoFieldOnChange(Sender: TField);
Var
  Fdoldvalue: Double;
Begin
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.

  { as we had issues with the serial number/bin batch allocations, we decided not
    to have a  negative value in the SO/quote quatities -
    Please consult IANOS or DENE before changing }
  If SysUtils.Sametext(Sender.FieldName, 'ProductName') Then Begin
    If IsComboSpecialVal(Sender.AsString) Then Exit;
  End;
  If ((Sysutils.SameText(Sender.FieldName, 'QtySold')) Or (Sysutils.SameText(Sender.FieldName, 'UnitofMeasureQtySold')) Or (Sysutils.SameText(Sender.FieldName, 'Shipped')) Or
    (Sysutils.SameText(Sender.FieldName, 'UnitofMeasureShipped'))) And (Self.ProductName <> TOTALDISCOUNT_PRODUCT) Then Begin
    If Not RawMode Then Begin
      PostDB;
      If Sender.Value < 0.0 Then Begin
        If VarIsNull(Sender.OldValue) Then FdOldValue := 0
        Else FdOldValue                               := Sender.OldValue;
        If FdOldValue < 0.0 Then FdOldValue           := 0.0;
        EditDB;
        Sender.Value := FdoldValue;
        DoFieldOnChange(Sender);
      End;
    End;
  End;
  Inherited;
  If Assigned(Self.Owner) Then
    If Self.Owner Is TQuoteBase Then TQuoteBase(Self.Owner).Validated := False;
End;

Procedure TQuoteLine.GetProductDetails;
Begin
  Inherited;
  SupplierName := Product.PreferedSupplierName;
End;

Procedure TQuoteLine.SetDefaultQtyShipped;
Begin
  { Shipped is always the same as sold on a quote. }
  QtyShipped              := QtySold;
  FormulaQtyShippedValue  := FormulaQtySoldValue;
  FormulaQtyShippedValue1 := FormulaQtySoldValue1;
  FormulaQtyShippedValue2 := FormulaQtySoldValue2;
  FormulaQtyShippedValue3 := FormulaQtySoldValue3;
  FormulaQtyShippedValue4 := FormulaQtySoldValue4;
  FormulaQtyShippedValue5 := FormulaQtySoldValue5;
  { Convert to user qty amount. }
  Self.UOMQtyShipped := Round(DivZer(QtyShipped, UOMMultiplier), RoundPlacesGeneral);
  { if not InternalQuantityChange then } DoContainerEvent(Self, EvSalesLineQtyChange);
  DoContainerEvent(Self, evSalesLineCalcTreePrice);
End;

Function TQuoteLine.ValidateData: Boolean;
Begin
  Result := Inherited ValidateData;
  If Not Result Then Exit;
  FormulaQtyShippedValue  := FormulaQtySoldValue;
  FormulaQtyShippedValue1 := FormulaQtySoldValue1;
  FormulaQtyShippedValue2 := FormulaQtySoldValue2;
  FormulaQtyShippedValue3 := FormulaQtySoldValue3;
  FormulaQtyShippedValue4 := FormulaQtySoldValue4;
  FormulaQtyShippedValue5 := FormulaQtySoldValue5;

End;

Function TQuoteLine.GetIsPQAItem: Boolean;
Begin
  Result := False;
End;

Procedure TQuoteLine.InitializeNewObject;
Begin
  Inherited;
  { Disable product allocation of bins and batches (not used on quotes) }
  { Quote lines are flagged as invoiced }
  Invoiced := True;
End;

Procedure TQuoteLine.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
Begin
  Inherited;
  // Logtime(Productname);
End;

// ------------------------------------------------------------------------------
{ TQuoteBase }
// ------------------------------------------------------------------------------

Constructor TQuoteBase.Create(AOwner: TComponent);
Begin
  Inherited;
  FBusObjectTypeDescription := 'Quote Object';
End;

Function TQuoteBase.CopyQuoteToCashSale: Integer;
Var
  CashSaleObj: TCashSale;
Begin
  Result            := 0;
  ConvertingQuote   := True;
  CopyingToCashSale := True;
  Try
    FieldsnotToclone := ExcludeFromclone + ',' + QuotedStr('IsPOS') + ',' + QuotedStr('IsRefund') + ',' + QuotedStr('IsCashSale') + ',' + QuotedStr('IsInvoice') + ',' + QuotedStr('IsQuote') + ',' +
      QuotedStr('IsSalesOrder') + ',' + QuotedStr('IsVoucher') + ',' + QuotedStr('IsLayby') + ',' + QuotedStr('IsLaybyTOS') + ',' + QuotedStr('IsLaybyPayment');
    Connection.BeginTransaction;
    Try
      If CloneBusObj('SaleDate', DateOf(Now), False, 'SaleID') <> Nil Then Begin
        CashSaleObj                := TCashSale(ObjInstanceToClone);
        CashSaleObj.QuoteGlobalRef := GlobalRef;
        CashSaleObj.GLAccountName  := UNDEPOSITED_FUNDS;
        CashSaleObj.Deleted        := False;
        CashSaleObj.IsQuote        := False;
        CashSaleObj.IsInvoice      := False;
        CashSaleObj.IsCashSale     := True;
        CashSaleObj.PayMethod      := PAY_CASH;
        CashSaleObj.PostDB;
        CashSaleObj.TotalQuoteAmtInc := TotalAmountInc;
        CashSaleObj.CustPONumber     := Reference;
        CashSaleObj.Save;
        SendEvent(BusobjEvent_ToDo, BusobjProcessPQADetailClasses, CashSaleObj);
        Self.Converted := True;
        Self.PostDB;
        Result := CashSaleObj.ID;
        UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
        CashSaleObj.UserLock.UnlockAllCurrentInstance;
      End;
    Finally
      If Result <> 0 Then Connection.CommitTransaction
      Else Connection.RollbackTransaction;
    End;
  Finally CopyingToCashSale := False;
  End;
End;

Function TQuoteBase.CopyQuoteToInvoice: Integer;
Var
  InvoiceObj: TInvoice;
Begin
  Result           := 0;
  ConvertingQuote  := True;
  CopyingToInvoice := True;
  try
    FieldsnotToclone := ExcludeFromclone + ',' + QuotedStr('IsPOS') + ',' + QuotedStr('IsRefund') + ',' + QuotedStr('IsCashSale') + ',' + QuotedStr('IsInvoice') + ',' + QuotedStr('IsQuote') + ',' +
      QuotedStr('IsSalesOrder') + ',' + QuotedStr('IsVoucher') + ',' + QuotedStr('IsLayby') + ',' + QuotedStr('IsLaybyTOS') + ',' + QuotedStr('IsLaybyPayment');
    Connection.BeginTransaction;
    try
      if CloneBusObj('SaleDate', DateOf(Now), False, 'SaleID') <> nil then begin
        InvoiceObj                := TInvoice(ObjInstanceToClone);
        InvoiceObj.Converted      := False;
        InvoiceObj.Deleted        := False;
        InvoiceObj.IsQuote        := False;
        InvoiceObj.IsInvoice      := True;
        InvoiceObj.QuoteGlobalRef := Self.GlobalRef;
        InvoiceObj.CustPONumber   := Self.Reference;
        InvoiceObj.PostDB;
        InvoiceObj.SetPaymentTerms(InvoiceObj.SaleDate);
        InvoiceObj.TotalQuoteAmtInc := TotalAmountInc;
        InvoiceObj.CustPONumber     := Self.Reference;
        InvoiceObj.RecalculateAllLines; { For Auto BO If No Stock }
        InvoiceObj.CalcOrderTotals;
        if AppEnv.CompanyPrefs.UseBarcodePicking And Not(AppEnv.CompanyPrefs.BarcodePickingInSOMode) then begin
          InvoiceObj.IsBarcodePicking := True;
        end;
        InvoiceObj.Save;
        SendEvent(BusobjEvent_ToDo, BusobjProcessPQADetailClasses, InvoiceObj);
        Self.Converted := True;
        Self.ConvertedDate := Now;
        Self.PostDB;
        Result := InvoiceObj.ID;
        UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
        InvoiceObj.UserLock.UnlockAllCurrentInstance;
      end;
    finally
      if Result > 0 then Connection.CommitTransaction
      else Connection.RollbackTransaction;
    End;
  finally CopyingToInvoice := False;
  end;
End;

Function TQuoteBase.CopyQuoteToQuote: Integer;
Begin
  Result         := 0;
  CopyingToQuote := True;
  Try
    If Self.CloneBusObj('SaleDate', DateOf(Now), False, 'SaleID') <> Nil Then Begin
      TQuoteBase(ObjInstanceToClone).Converted      := False;
      TQuoteBase(ObjInstanceToClone).Deleted        := False;
      TQuoteBase(ObjInstanceToClone).RepairID       := 0;
      TQuoteBase(ObjInstanceToClone).QuoteGlobalRef := GlobalRef;
      TQuoteBase(ObjInstanceToClone).PostDb;
      TQuoteBase(ObjInstanceToClone).Save;
      Result := TQuoteBase(ObjInstanceToClone).ID;
      UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
      TQuoteBase(ObjInstanceToClone).UserLock.UnlockAllCurrentInstance;
    End;
  Finally CopyingToQuote := False;
  End;
End;

Function TQuoteBase.CopyQuoteToSmartOrder: Integer;
Begin
  Result := CopyToSmartOrder;
  UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
End;

Function TQuoteBase.CopyQuoteToSalesOrder: Integer;
Var
  SalesOrderObj: TSalesOrder;
Begin
  Result              := 0;
  ConvertingQuote     := True;
  CopyingToSaleSOrder := True;
  Try
    FieldsnotToclone := ExcludeFromclone + ',' + QuotedStr('IsPOS') + ',' + QuotedStr('IsRefund') + ',' + QuotedStr('IsCashSale') + ',' + QuotedStr('IsInvoice') + ',' + QuotedStr('IsQuote') + ',' +
      QuotedStr('IsSalesOrder') + ',' + QuotedStr('IsVoucher') + ',' + QuotedStr('IsLayby') + ',' + QuotedStr('IsLaybyTOS') + ',' + QuotedStr('IsLaybyPayment');
    Connection.BeginTransaction;
    Try
      If Assigned(CloneBusObj('SaleDate', DateOf(Now), False, 'SaleID')) Then Begin
        SalesOrderObj                := TSalesOrder(ObjInstanceToClone);
        SalesOrderObj.Deleted        := False;
        SalesOrderObj.ShipDate       := SalesOrderObj.SaleDate;
        SalesOrderObj.QuoteGlobalRef := GlobalRef;
        SalesOrderObj.IsQuote        := False;
        SalesOrderObj.IsSalesOrder   := True;
        SalesOrderObj.Converted      := False;
        SalesOrderObj.PostDB;
        SalesOrderObj.FcleanxmlDoc     := Nil;
        SalesOrderObj.TotalQuoteAmtInc := TotalAmountInc;
        SalesOrderObj.CustPONumber     := Reference;
        If AppEnv.CompanyPrefs.UseBarcodePicking And AppEnv.CompanyPrefs.BarcodePickingInSOMode Then Begin
          SalesOrderObj.IsBarcodePicking := True;
        End;
        SalesOrderObj.Save;
        SendEvent(BusobjEvent_ToDo, BusobjProcessPQADetailClasses, SalesOrderObj);
        Converted := True;
        ConvertedDate := Now;
        PostDB;
        Result := SalesOrderObj.ID;
        UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
        SalesOrderObj.UserLock.UnlockAllCurrentInstance;
      End;
    Finally
      If Result > 0 Then Connection.CommitTransaction
      Else Connection.RollbackTransaction;
    End;
  Finally CopyingToSaleSOrder := False;
  End;
End;

Destructor TQuoteBase.Destroy;
Begin

  Inherited;
End;

Procedure TQuoteBase.InitializeNewObject;
Begin
  IsInvoice         := False;
  IsCashSale        := False;
  IsRefund          := False;
  IsSalesOrder      := False;
  IsQuote           := True;
  FreezeQuoteAmount := False;
  Inherited;
End;

Procedure TQuoteBase.DoFieldOnChange(Sender: TField);
Begin
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.

  If (Sysutils.SameText(Sender.FieldName, 'QuoteStatus')) Then Begin
    If Not RawMode Then Begin
      // if related to a lead, change leadStatus
      TLeads.UpdateStatus(Self.SalesStatus, Self.ClientId);
    End;
  End;
  Inherited;
  Validated := False;
End;

Procedure TQuoteBase.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
Begin
  Inherited;
  If (ChangeType = DcNew) Or ((ChangeType = DcLoad) And (Id < 1)) Then Begin
    // Save so autoinc id is assigned
    If Not IsQuote Then Begin
      IsInvoice    := False;
      IsCashSale   := False;
      IsRefund     := False;
      IsSalesOrder := False;
      IsQuote      := True;
      IsPos        := False;
      PostDB;
    End;
  End;
  Validated := False;
End;

Procedure TQuoteBase.Load(Const FIsReadonly: Boolean = False);
Begin
  Inherited;

End;

Function TQuoteBase.Save: Boolean;
Begin
  Result := False;
  Try
    Try
      If Not ValidateData Then Exit;

      CalcOrderTotals;
      Result := Inherited Save;
      If Not Result Then Exit;

      { now validate then invoice lines }
      AllLinesSavedOK := True;
      Lines.IterateRecords(LineSaveCallbackProc, True);

      Result := AllLinesSavedOK;

      Validated            := True;
      If Result Then Dirty := False;
      Try
        If Lines.Count = 0 Then
            TLeadToAddProgressionRecord.AddProgressionRecord(ClientID, LeadActionQuote, Id, GlobalRef, Comments, SAleDate, Id, Globalref, True, EmployeeId,
            GetSimpleType('Deleted', SimpleTypes_AppointmentStatusType))
        Else Begin
          If CleanCustomerID <> 0 Then
              TLeadToAddProgressionRecord.AddProgressionRecord(CleanCustomerID, LeadActionQuote, Id, GlobalRef, 'Deleted ' + XMLNodeName + ' # ' + Inttostr(ID) + '  from ' + Quotedstr(Cleancustomer) +
              '. Moved to Customer : ' + Quotedstr(CustomerName) + NL + Comments, SAleDate, Id, Globalref, True, EmployeeId,
              GetSimpleType('Changed Customer', SimpleTypes_AppointmentStatusType, True));
          TLeadToAddProgressionRecord.AddProgressionRecord(ClientID, LeadActionQuote, Id, GlobalRef, Comments, SAleDate, Id, Globalref, True, EmployeeID);
        End;
      Except
        On E: Exception Do Begin
        End;
      End;

    Finally
      If Result Then Lines.IterateRecords(UpdateCustomerEquipQty);
    End;
  Finally
    If Result Then Result := Validtocommit;
  End;
  If Result Then Begin
    If DeleteFlaggedLines Then Dirty := False
    Else Result                      := False;
  End;

End;

Function TQuoteBase.ValidateData: Boolean;
Var
  ADiscPrice, aDiscountPercent, aTotalDiscount , aPrice(*, QuoteMinTotal*): Double;
  Msg:String;
Begin
  Show_Status('Validating .');

  If Deleted Or Cancelled Then Begin
    Result := True;
    Exit;
  End;
  If Validated Then Begin
    Result := True;
    Exit;
  End;
  Result := Inherited ValidateData;
  If Not Result Then Exit;

  { Check that max discount has not ben exceeded }
  If (TotalAmountInc <> 0) And (TotalQuoteAmount <> 0) And (TotalAmountInc > TotalQuoteAmount) Then Begin
    ADiscPrice:=TotalAmountInc;
    aDiscountPercent:=0;
    aTotalDiscount := TotalDiscount;
    aPrice := TotalAmountInc ;
    if not TSalesDiscountValidationObj.ValidateDiscount(Self, aTotalDiscount , aDiscountPercent , TotalCost , aPrice , ADiscPrice ,1 , 0 , False, False, Msg) then begin
        Self.ResultStatus.AddItem(False, RssWarning, BOR_Sales_Err, Msg);
        Result := False;
        Exit;
    end;

    If (Not SilentMode) And (BusobjMessageDlg('The Quoted Price is less than the Actual Total' + #13#10#13#10 + 'Is This OK ?', MtConfirmation, [MbYes, MbNo], 0) = MrNo) Then Begin
      Result := False;
      Exit;
    End;
  End;

  Result := ValidateLines;

  Validated := True;
End;

Procedure TQuoteBase.LineSaveCallbackProc(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not TQuoteLine(Sender).Save Then Begin
    AllLinesSavedOK := False;
    Abort           := True;
  End;
End;

Procedure TQuoteBase.LineValidateCallbackProc(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  Show_Status('Validating Quote Lines : ' + IntToStr(Sender.Dataset.Recno) + ' of ' + IntToStr(Sender.Dataset.Recordcount));
  If Not TQuoteLine(Sender).ValidateData Then Begin
    AllLinesValid := False;
    Abort         := True;
  End;
End;

Procedure TQuoteBase.CalcOrderTotals;
Begin
  Inherited;
  // Show_Status('Calculating Order totals.');
  If Not FreezeQuoteAmount Then TotalQuoteAmount := TotalAmountInc;
End;

Function TQuoteBase.GetFreezeQuoteAmount: Boolean;
Begin
  Result := GetBooleanField('FreezeQuoteAmount');
End;

Procedure TQuoteBase.SetFreezeQuoteAmount(Const Value: Boolean);
Begin
  SetBooleanField('FreezeQuoteAmount', Value);
End;

Function TQuoteBase.GetConvertedDate: TDateTime;
Begin
  Result := GetDateTimeField('ConvertedDate');
End;

Procedure TQuoteBase.SetConvertedDate(Const Value: TDateTime);
Begin
  SetDateTimeField('ConvertedDate', Value);
End;

Function TQuoteBase.GetLines: TTransLineBase;
Begin
  Result                                    := GetQuoteLines;
  If Self.SilentMode Then Result.SilentMode := True;
End;

Function TQuoteBase.GetQuoteLines: TQuoteLine;
Begin
  Result := TQuoteLine(GetContainerComponent(TQuoteLine, 'SaleID = ' + IntToStr(Self.Id)));
End;

Function TQuoteBase.GetSaleLines: TSalesLineBase;
Begin
  Result := Self.GetQuoteLines;
End;

Procedure TQuoteBase.LoadFromXMLNode(Const Node: IXMLNode);
Begin
  Inherited;
  SetBooleanPropertyFromNode(Node, 'FreezeQuoteAmount');
  SetBooleanPropertyFromNode(Node, 'Converted');
  SetPropertyFromNode(Node, 'Reference');
End;

Procedure TQuoteBase.SaveToXMLNode(Const Node: IXMLNode);
Begin
  Inherited;
  AddXMLNode(Node, 'FreezeQuoteAmount', FreezeQuoteAmount);
  AddXMLNode(Node, 'Converted', Converted);
  AddXMLNode(Node, 'Reference', Reference);
End;

Procedure TQuoteBase.SetPaymentTerms(Const BaseDate: TDateTime);
Begin
  DueDate := SaleDate + AppEnv.CompanyPrefs.FollowUpDays;
End;

function TSales.getSalesLinePackWeightLinesSum: TSalesLinePackWeightLinesSum;
begin
  Result := TSalesLinePackWeightLinesSum(GetContainerComponent(TSalesLinePackWeightLinesSum, 'SaleID = ' + IntToStr(Self.Id)));
end;

function TSales.getSalesShipments: TSalesShipments;
begin
  Result := TSalesShipments(GetContainerComponent(TSalesShipments, 'SaleID = ' + inttostr(ID)));
end;

Function TSales.GetAppointID: Integer;
Begin
  Result := GetIntegerField('AppointID');
End;



Function TSales.ShippedQtyChanged: Boolean;
Begin
  FShippedQtyChanged := False;
  Lines.IterateRecords(ShippedQtyChangedCallback);
  Result := FShippedQtyChanged;
End;

Procedure TSales.ShippedQtyChangedCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If (Sender Is TSaleslineBase) Then Begin
    If TSaleslineBase(Sender).CleanUOMQtyShipped <> TSaleslineBase(Sender).UOMQtyShipped Then Begin
      FShippedQtyChanged := True;
      Abort              := True;
    End;
  End;
End;

Function TSales.GetSalesCategory: String;Begin  Result := GetStringField('SalesCategory');End;
Function TSales.GetProgressPaymentInvRef: String;Begin  Result := GetStringField('ProgressPaymentInvRef');End;
Function TSales.GetProgressPaymentSeqno: Integer;Begin  Result := GetIntegerField('ProgressPaymentSeqno');End;
Function TSales.GetDefaultReferenceNoinAllLines: Boolean;Begin  Result := GetBooleanField('DefaultReferenceNoinAllLines');End;
Procedure TSales.SetProgressPaymentInvRef(Const Value: String);Begin  SetStringField('ProgressPaymentInvRef', Value)End;
Function TSales.GetReferenceNo: String;Begin  Result := GetStringField('ReferenceNo');End;
Function TSales.GetIsdone: Boolean;Begin  Result := GetBooleanField('Isdone');End;
Function TSales.GetTypeOfBasedOn    : String;     Begin Result := GetStringField('TypeOfBasedOn'); End;
Function TSales.GetFrequencyValues  : String;     Begin Result := GetStringField('FrequencyValues'); End;
Function TSales.GetCopyStartDate    : TDateTime;  Begin Result := GetDateTimeField('CopyStartDate'); End;
Function TSales.GetCopyFinishDate   : TDateTime;  Begin Result := GetDateTimeField('CopyFinishDate'); End;
Function TSales.GetQuota            : Double;     Begin Result := GetFloatField('Quota'); End;

Procedure TSales.SetProgressPaymentSeqno(Const Value: Integer);Begin  SetIntegerField('ProgressPaymentSeqno', Value)End;
Procedure TSales.SetReferenceNo(Const Value: String);Begin  SetStringField('ReferenceNo', Value)End;
Procedure TSales.SetDefaultReferenceNoinAllLines(Const Value: Boolean);Begin  SetBooleanField('DefaultReferenceNoinAllLines', Value)End;
Procedure TSales.SetIsdone(Const Value: Boolean);Begin  SetBooleanField('Isdone', Value)End;
Procedure TSales.SetSalesCategory(Const Value: String);Begin  SetStringField('SalesCategory', Value);End;
Procedure TSales.SetTypeOfBasedOn(Const Value: String);       Begin  SetStringField('TypeOfBasedOn', Value);  End;
Procedure TSales.SetFrequencyValues(Const Value: String);     Begin  SetStringField('FrequencyValues', Value);  End;
Procedure TSales.SetCopyStartDate(Const Value: TDateTime);    Begin  SetDateTimeField('CopyStartDate', Value);  End;
Procedure TSales.SetCopyFinishDate(Const Value: TDateTime);   Begin  SetDateTimeField('CopyFinishDate', Value);  End;
Procedure TSales.SetQuota(Const Value: Double);               Begin  SetFloatField('Quota', Value);  End;

Function TQuoteBase.GetReference: String;Begin  Result := GetStringField('Reference');End;
Procedure TQuoteBase.SetReference(Const Value: String);Begin  SetStringField('Reference', Value);End;
Function TQuoteBase.IsCustomerCreditOk: Boolean;begin  Result := True;End;
Function TQuoteBase.IsCustomerTermsOk: Boolean;Begin  Result := True;End;
Function TQuoteBase.GetOriginalSaleRec: TSales;Begin  Result := Nil;End;
// ------------------------------------------------------------------------------
{ TSalesOrderLine }
// ------------------------------------------------------------------------------

Function TSalesLine.ParentProductname:String;
var
  Qry :TERPQuery;
begin
  Qry := DbSharedObj.GetQuery(connection.Connection);
  try
    Qry.sql.text := 'Select productname from tblsaleslines where globalref = '+quotedstr(RelatedParentLineRef);
    Qry.open;
    Result := Qry.fieldbyname('Productname').asString;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;
Function TSalesLine.ProductDescNameWithRelatedParent :String;
begin
  Result := '';
  if isrelatedProduct then REsult := ParentProductname;
  if result <>  '' then Result := quotedstr(ParentProductname)+'''s Related ';
  Result := Result +'Product  ' + quotedstr(Productname);
end;
Procedure TSalesOrderLine.GetBaseLinePrice;

Var
  S: String;
Begin
  If ISTreeItem Then
  Else If (LinePrice = 0) Then
  Else If (Not(CalcQtyFromformula)) And (Not(AddingAlternateProduct)) And Appenv.CompanyPrefs.ConfirmBeforesalePricechange And (Not InternalQuantityChange) Then
    If ParthasPriceMatrix(Product.ID) And (MatrixPrice <> 0) Then
    Else Begin
      S := ProductDescNameWithRelatedParent+'''s Sale Price ' + FloatToStrF(LinePriceinc, FfCurrency, 15, 2) + ' Already Entered.' + Chr(13) + Chr(13);
      If ParthasPriceMatrix(Product.ID) And (MatrixPrice <> 0) Then
          S := S + 'Product has Price Matrix and for the selected Price Matrix Attribute (' + MatrixDesc + '), the Base Price is ' + FloattoStrF(MatrixPrice, FfCurrency, 15, CurrencyRoundPlaces) +
          Chr(13) + 'Changing the Quantity will Reassign this price.'
      Else S := S + 'Changing the Quantity Will Recalculate the Price.';
      S      := S + Chr(13) + Chr(13) + 'Do you Wish To Keep the Price?';
      If ((Not(Assigned(ConfirmFromGUI))) Or (FconfirmFromGUI(S, [MbYes, MbNo]) = Mryes)) Then Exit;
    End;

  Inherited;
End;

Function TSalesOrderLine.GetIsMergingSOToInvoice: Boolean;
Begin
  Result := False;
  If Assigned(Self.Owner) Then
    If Self.Owner Is TSalesOrder Then Result := TSalesOrder(Self.Owner).IsMergingSOToInvoice;
End;

Function TSalesOrderLine.GetFutureOrder: Boolean;
Begin
  Result := False;
  If Assigned(Self.Owner) Then
    If Self.Owner Is TSalesOrder Then Result := TSalesOrder(Self.Owner).FutureSO;
End;


Procedure TSalesOrderLine.CalcLineTotals;
Begin
  If Self.Id = 0 Then Exit;
  Inherited;
   Invoiced := (QtyShipped <> 0);
End;

Procedure TSalesOrderLine.CalcTreePrice;
Begin
  if not IsTreeItem then exit;
  if IgnoreBOMCalcPriceOnSale then exit;
  Inherited;
  DoContainerEvent(Self, EvSalesLineCalcTreePrice);
End;

Function TSalesOrderLine.HasPartialInvoices: Boolean;
Begin
  With GetNewDataset('select * from tblsalesorderinvoicelines where SalesOrderLineID = ' + Inttostr(ID)) Do
    Try Result := Recordcount > 0;
    Finally
      If Active Then Close;
      Free;
    End;
End;

Procedure TSalesOrderLine.Copyallocation;
Begin
  Inherited;
  If CopyingToInvoice Then DeleteSalesOrderInvoiceLinesPQAnAllocations;
End;

Procedure TSalesOrderLine.DeleteSalesOrderInvoiceLinesPQAnAllocations;
Var
  S: String;
  Procedure InactivateSalesOrderInvoiceLinePQA;
  Begin
    S := 'Select  PQA.PQAID ' +
      ' from tblpqa PQA  inner join tblSalesOrderInvoiceLines SOIL on SOIL.SOInvoiceLineID = PQA.transLineID and SOIL.SOInvoiceID = PQa.transId and PQA.TransType = ''TSalesOrderInvoiceLines'' ' +
      'inner join tblSaleslines SOL on  SOL.SaleLineID = SOIL.SalesOrderLineID and SOL.SaleLineID=' + Inttostr(ID);
    With TERPQuery(GetNewdataset(S, True)) Do
      Try S := Groupconcat('PQAID');
      Finally ClosenFree;
      End;
    If S = '' Then Exit;
    S := 'Select * from tblPQa where PQAID in (' + S + ')';
    With TERPQuery(GetNewdataset(S, True)) Do
      Try
        If Recordcount = 0 Then Exit;
        First;
        While Eof = False Do Begin
          Edit;
          Fieldbyname('Active').AsBoolean := False;
          Post;
          Next;
        End;
      Finally ClosenFree;
      End;
  End;
  Procedure DeleteSalesOrderInvoiceLineAllocations;
  Var
    Tablename1, Tablename2    : String;
    Tmpfilename1, Tmpfilename2: String;
    Qry1, Qry2                : TERPQuery;
    S1, S2                    : String;
  Begin
    TableName1 := GetUserTemporaryTableName('SOIPQA');
    TableName2 := GetUserTemporaryTableName('IPQA');

    S1 := ' SELECT ' + ' concat(ifnull(pqabatch.value,""),"-", ifnull(pqabatch.expirydate,0),"-",ifnull(pqabins.binID,""), "-", ifnull(PQASN.Value,"") ,' + ' if(not(isnull(PQASN.PQADetailID)) , ' +
      Quotedstr(TPQASN.PQADetailtype) + ' , if(not(isnull(pqabins.PQADetailID)) ,  ' + Quotedstr(TPQABins.PQADetailtype) + ' , ' + Quotedstr(TPQABatch.PQADetailtype) + '))) as batchbinsn, ' +
      ' pqabatch.value as batchno , pqabatch.expirydate, ' + ' pqabins.Value as binID, ' + ' pqasn.value serialnumber, ' + ' if(not(isnull(PQASN.PQADetailID)) , ' + Quotedstr(TPQASN.PQADetailtype) +
      ' , if(not(isnull(pqabins.PQADetailID)) ,  ' + Quotedstr(TPQABins.PQADetailtype) + ' , ' + Quotedstr(TPQABatch.PQADetailtype) + ')) as Category, ' +
      ' sum(ifnull(Pqasn.qty ,  ifnull(PQABins.qty, PQABatch.qty))) as qty,sum(ifnull(Pqasn.uomqty ,  ifnull(PQABins.uomqty, PQABatch.uomqty))) as uomqty, ' + ' PQASN.PQADetailID    pqaSNID, ' +
      ' pqabins.PQADetailID  pqabinid, ' + ' PQAbatch.PQADetailID pqabatchID ' + ' from tblpqa PQA ' + ' inner join tblparts P on P.partsId = PQa.productId ' +
      ' inner join tblSalesOrderInvoiceLines SOIL on SOIL.SOInvoiceLineID = PQA.transLineID and SOIL.SOInvoiceID = PQa.transId and PQA.TransType = "TSalesOrderInvoiceLines" ' +
      ' inner join tblSaleslines SOL on  SOL.SaleLineID = SOIL.SalesOrderLineID and SOL.SaleLineID= ' + Inttostr(ID) +
      ' LEft  JOIN `tblPqaDetails` PQABatch  ON PQABatch.PQAId 	= PQA.PQAID AND PQABatch.PQAType = ' + Quotedstr(TPQABatch.PQADetailtype) + '  AND PQABatch.Active= "T" and ifnull(PQABatch.qty,0)<>0 '
      + ' LEFT JOIN `tblPqaDetails` PQABins  ON PQABins.PQAId 	= PQA.PQAID  AND PQABins.PQAType = ' + Quotedstr(TPQABins.PQADetailtype) + ' AND PQABins.Active = "T"  and ifnull(PQABins.qty,0)<>0 ' +
      '            AND   ( (PQABatch.globalref = IFNULL(PQABins.ParentRef,"") AND P.Batch="T"  AND P.multiplebins = "T") or (ifnull(PQABins.Parentref ,"") = "" ' +
      '            AND P.Batch="F" AND P.multiplebins = "T")) ' + ' LEFT JOIN `tblPqaDetails` PQASN    ON (PQASN.PQAId 	= PQA.PQAID AND PQASN.PQAType = ' + Quotedstr(TPQASN.PQADetailtype) +
      '   AND PQASN.Active = "T" and ifnull(PQASN.qty,0)<>0 ' + ' AND ((PQABatch.globalref = IFNULL(PQASN.ParentRef,"") AND P.Batch="T" AND P.multiplebins = "F" AND P.SNTracking = "T") ' +
      ' OR (PQAbins.Globalref = IFNULL(PQASn.ParentRef,"") AND P.Multiplebins = "T" AND P.SNTracking = "T") or ' +
      ' ifnull(PQASN.Parentref ,"") = "" AND P.Batch="F" AND P.Multiplebins = "F" AND P.SNTracking = "T" )) ' +
      ' group by concat(ifnull(pqabatch.value,""),"-", ifnull(pqabatch.expirydate,0),"-",ifnull(pqabins.Value,""), "-", ifnull(PQASN.Value,"") , ' + ' if(not(isnull(PQASN.PQADetailID)) , ' +
      Quotedstr(TPQASN.PQADetailtype) + ' , if(not(isnull(pqabins.PQADetailID)) ,  ' + Quotedstr(TPQABins.PQADetailtype) + ' , ' + Quotedstr(TPQABatch.PQADetailtype) + '))) ';

    S2 := ' SELECT ' + ' concat(ifnull(pqabatch.value,""),"-", ifnull(pqabatch.expirydate,0),"-",ifnull(pqabins.binID,""), "-", ifnull(PQASN.Value,"") ,' + 'if(not(isnull(PQASN.PQADetailID)) , ' +
      Quotedstr(TPQASN.PQADetailtype) + ' , if(not(isnull(pqabins.PQADetailID)) ,  ' + Quotedstr(TPQABins.PQADetailtype) + ' , ' + Quotedstr(TPQABatch.PQADetailtype) + '))) as batchbinsn, ' +
      ' pqabatch.value as batchno , pqabatch.expirydate, ' + ' pqabins.Value as binID, ' + ' pqasn.value serialnumber, ' + ' if(not(isnull(PQASN.PQADetailID)) , ' + Quotedstr(TPQASN.PQADetailtype) +
      ' , if(not(isnull(pqabins.PQADetailID)) ,  ' + Quotedstr(TPQABins.PQADetailtype) + ' , ' + Quotedstr(TPQABatch.PQADetailtype) + ')) as Category, ' +
      ' sum(ifnull(Pqasn.qty ,  ifnull(PQABins.qty, PQABatch.qty))) as qty,sum(ifnull(Pqasn.uomqty ,  ifnull(PQABins.uomqty, PQABatch.uomqty))) as uomqty, ' + ' PQASN.PQADetailID    pqaSNID, ' +
      ' pqabins.PQADetailID  pqabinid, ' + ' PQAbatch.PQADetailID pqabatchID ' + ' from tblpqa PQA ' + ' inner join tblparts P on P.partsId = PQa.productId ' +
      ' inner join tblSaleslines SOL on SOL.saleLineId = PQA.transLineID and SOL.saleId = PQa.transId and PQA.TransType = "TInvoiceLine"  and SOL.SaleLineID= ' + Inttostr(Objinstancetoclone.ID) +
      ' LEft  JOIN `tblPqaDetails` PQABatch  ON PQABatch.PQAId 	= PQA.PQAID AND PQABatch.PQAType = ' + Quotedstr(TPQABatch.PQADetailtype) + '  AND PQABatch.Active= "T" and ifnull(PQABatch.qty,0)<>0 '
      + ' LEFT JOIN `tblPqaDetails` PQABins  ON PQABins.PQAId 	= PQA.PQAID  AND PQABins.PQAType = ' + Quotedstr(TPQABins.PQADetailtype) + ' AND PQABins.Active = "T"  and ifnull(PQABins.qty,0)<>0 ' +
      '            AND   ( (PQABatch.globalref = IFNULL(PQABins.ParentRef,"") AND P.Batch="T"  AND P.multiplebins = "T") or (ifnull(PQABins.Parentref ,"") = "" ' +
      '            AND P.Batch="F" AND P.multiplebins = "T")) ' + ' LEFT JOIN `tblPqaDetails` PQASN    ON (PQASN.PQAId 	= PQA.PQAID AND PQASN.PQAType = ' + Quotedstr(TPQASN.PQADetailtype) +
      '   AND PQASN.Active = "T" and ifnull(PQASN.qty,0)<>0 ' + ' AND ((PQABatch.globalref = IFNULL(PQASN.ParentRef,"") AND P.Batch="T" AND P.multiplebins = "F" AND P.SNTracking = "T") ' +
      ' OR (PQAbins.Globalref = IFNULL(PQASn.ParentRef,"") AND P.Multiplebins = "T" AND P.SNTracking = "T") or ' +
      ' ifnull(PQASN.Parentref ,"") = "" AND P.Batch="F" AND P.Multiplebins = "F" AND P.SNTracking = "T" )) ' +
      ' group by concat(ifnull(pqabatch.value,""),"-", ifnull(pqabatch.expirydate,0),"-",ifnull(pqabins.Value,""), "-", ifnull(PQASN.Value,"") , ' + ' if(not(isnull(PQASN.PQADetailID)) , ' +
      Quotedstr(TPQASN.PQADetailtype) + ' , if(not(isnull(pqabins.PQADetailID)) ,  ' + Quotedstr(TPQABins.PQADetailtype) + ' , ' + Quotedstr(TPQABatch.PQADetailtype) + '))) ';
    Try
      ExecuteSQL(' DROP TABLE if exists ' + Tablename1 + ';' + ' CREATE TABLE ' + Tablename1 + ' ( ' + ' batchbinsn    varchar(255), ' + ' batchno 	    varchar(255), ' +
        ' expirydate    datetime DEFAULT NULL, ' + ' binID         int(11) DEFAULT NULL, ' + ' serialnumber  varchar(255) DEFAULT NULL, ' + ' Category      varchar(5) NOT NULL DEFAULT "", ' +
        ' qty           double DEFAULT NULL, ' + ' uomqty        double DEFAULT NULL, ' + ' pqaSNID       int(11) DEFAULT 0, ' + ' pqabinid      int(11) DEFAULT 0, ' +
        ' pqabatchID    int(11) DEFAULT 0 ' + ') ENGINE=MyISAM DEFAULT CHARSET=utf8;' + ' DROP TABLE if exists ' + Tablename2 + ';' + ' CREATE TABLE ' + Tablename2 + ' ( ' +
        ' batchbinsn    varchar(255), ' + ' batchno 	    varchar(255), ' + ' expirydate    datetime DEFAULT NULL, ' + ' binID         int(11) DEFAULT NULL, ' +
        ' serialnumber  varchar(255) DEFAULT NULL, ' + ' Category      varchar(5) NOT NULL DEFAULT "", ' + ' qty           double DEFAULT NULL, ' + ' uomqty        double DEFAULT NULL, ' +
        ' pqaSNID       int(11) DEFAULT 0, ' + ' pqabinid      int(11) DEFAULT 0, ' + ' pqabatchID    int(11) DEFAULT 0 ' + ') ENGINE=MyISAM DEFAULT CHARSET=utf8;', False);
      S := CreateTemporaryTableusingfile('', S1, 'batchbinsn,batchno,expirydate,binID,serialnumber,Category,qty,uomqty,pqaSNID,pqabinid,pqabatchID', Tablename1, Tmpfilename1) +
        CreateTemporaryTableusingfile('', S2, 'batchbinsn,batchno,expirydate,binID,serialnumber,Category,qty,uomqty,pqaSNID,pqabinid,pqabatchID', Tablename2, Tmpfilename2);

      ExecuteSQL(S, True);

      S := '';
      Try
        Qry1 := TERPQuery(GetNewDataset('select * from ' + Tablename1, True));
        Qry2 := TERPQuery(GetNewDataset('select * from ' + Tablename2, True));
        Try
          If (Qry1.Recordcount = 0) Or (Qry2.Recordcount = 0) Then Exit;
          Qry1.First;
          While Qry1.Eof = False Do Begin
            If Qry2.Locate('batchbinsn', Qry1.Fieldbyname('batchbinsn').AsString, []) Then Begin
              If Qry1.Fieldbyname('Qty').Asfloat <> 0 Then Begin
                If (Qry1.Fieldbyname('Serialnumber').AsString <> '') And (Qry2.Fieldbyname('PQASNID').AsInteger <> 0) Then
                    S := S + 'delete from tblpqadetails where PQADetailID = ' + Inttostr(Qry2.Fieldbyname('PQASNID').AsInteger) + ';';
                If Qry2.Fieldbyname('PQABinId').AsInteger <> 0 Then
                    S := S + 'update tblpqadetails Set ' + ' Qty = Qty-' + FloatTostr(Qry1.Fieldbyname('Qty').Asfloat) + ',  ' + ' uomQty = uomQty-' + FloatTostr(Qry1.Fieldbyname('uomQty').Asfloat) +
                    '   ' + ' where PQADetailID = ' + Inttostr(Qry2.Fieldbyname('PQABinId').AsInteger) + ';';
                If Qry2.Fieldbyname('PQABatchId').AsInteger <> 0 Then
                    S := S + 'update tblpqadetails Set ' + ' Qty = Qty-' + FloatTostr(Qry1.Fieldbyname('Qty').Asfloat) + ',  ' + ' uomQty = uomQty-' + FloatTostr(Qry1.Fieldbyname('uomQty').Asfloat) +
                    '   ' + ' where PQADetailID = ' + Inttostr(Qry2.Fieldbyname('PQABatchId').AsInteger) + ';';
              End;
            End;
            Qry1.Next;
          End;
        Finally
          If Qry1.Active Then Qry1.Close;
          Freeandnil(Qry1);
          If Qry2.Active Then Qry2.Close;
          Freeandnil(Qry2);
        End;
      Finally
        If S <> '' Then ExecuteSQL(S, True);
      End;
    Finally
      AppEnv.UtilsClient.DeleteServerFiles(ReplaceStr(Tmpfilename1, '.tmp', '*.tmp'));
      AppEnv.UtilsClient.DeleteServerFiles(ReplaceStr(Tmpfilename2, '.tmp', '*.tmp'));
    End;
  End;

Begin
  If Not(HasPartialInvoices) Then Exit;
  If Assigned(Objinstancetoclone) Then DeleteSalesOrderInvoiceLineAllocations;
  InactivateSalesOrderInvoiceLinePQA;
End;

Constructor TSalesOrderLine.Create(AOwner: TComponent);
Begin
  Inherited;
  FBusObjectTypeDescription := 'Sales Order Line Object';
  ShippingTreeItem          := False;
End;

Function TSalesOrder.DeleteFlaggedLines: Boolean;
Begin
  Result := Inherited DeleteFlaggedLines;
  If Not Result Then Exit;
  GetNewDataset('update tblsales S ' + ' inner join tblsaleslines SL on S.saleId = SL.saleId' +
    ' Set S.UsedOnManifest = if((Select count(*) ctr from tblmanifestlines ML where ML.SaleLineID = SL.SaleLineID)>0  , "T","F")' + ' where S.saleId = ' + Inttostr(ID) +
    ' and  S.IsManifest  ="T";', True);
End;

Destructor TSalesOrderLine.Destroy;
Begin

  Inherited;
End;

Function TSalesOrderLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
Begin
  Result := Inherited DoAfterInsert(Sender);
  If Not Result Then Exit;
End;

Procedure TSalesOrderLine.DoFieldOnChange(Sender: TField);
Var
  Fdoldvalue: Double;
Begin
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.

  If SysUtils.Sametext(Sender.FieldName, 'ProductName') Then Begin
    If IsComboSpecialVal(Sender.AsString) Then Exit;
  End
  Else If SameText(Sender.FieldName, 'BOMGroupedLine') Then Begin
    DoContainerEvent(Self, EvBOMMergingLine);
  End
  Else If SameText(Sender.FieldName, 'BOMProductionLine') Then Begin
    DoContainerEvent(Self, EvBOMProductionLine);
  End;

  { as we had issues with the serial number/bin batch allocations, we decided not to havea  negative value in the
    SO/quote quatities - Please consult IANOS or DENE before changing }
  If ((Sysutils.SameText(Sender.FieldName, 'QtySold')) Or (Sysutils.SameText(Sender.FieldName, 'UnitofMeasureQtySold')) Or (Sysutils.SameText(Sender.FieldName, 'Shipped')) Or
    (Sysutils.SameText(Sender.FieldName, 'UnitofMeasureShipped'))) And (Self.ProductName <> TOTALDISCOUNT_PRODUCT) Then Begin
    If Not RawMode Then Begin
      PostDB;
      If Sender.AsFloat < 0.0 Then Begin
        Try
          If Not VarIsNull(Sender.OldValue) Then FdOldValue := Sender.Oldvalue
          Else FdOldValue                                   := 0.0;
        Except FdOldValue                                   := 0.0;
        End;
        If FdOldValue < 0.0 Then FdOldValue := 0.0;
        EditDB;
        Sender.Value := FdoldValue;
        DoFieldOnChange(Sender);
      End;
    End;
  End;
  Inherited;
  If (Sysutils.SameText(Sender.FieldName, 'QtySold')) Or (Sysutils.SameText(Sender.FieldName, 'UnitofMeasureQtySold')) or
      (Sysutils.SameText(Sender.FieldName, 'Shipped')) Or (Sysutils.SameText(Sender.FieldName, 'UnitofMeasureShipped')) Then Begin
  { since ashford's wants to have back orders, this is commented off for the time being }


      {Shipping a differnt quantity should reintialise the clean Tree;}
      if Sysutils.SameText(Sender.FieldName, 'UnitofMeasureShipped') then
        If IsTreeItem Then
          DoContainerEvent(Self, evSalesLineMakeCleanTree);


      If Appenv.CompanyPrefs.EnableBoinBOMsalesOrder = False Then Begin
        { when so with a backorder is converted, the whole group is converted. then partial shipment not possible and is meaning less
          so for BOM product, no Backorder possible }
        If IsTreeItem Then
          If Not ShippingTreeItem Then Begin
            ShippingTreeItem := True;
            Try
              If (Sysutils.SameText(Sender.FieldName, 'QtySold')) Or (Sysutils.SameText(Sender.FieldName, 'UnitofMeasureQtySold')) Then Begin
                UOMQtyShipped := UOMQtySold;
                QtyShipped    := QtySold;
                //DoContainerEvent(Self, evSalesLineQtyChange);
                AddEvent(BusObjEvent_Change, BusObjEventVal_ShippingTreeItem, Self.ID);
                DoFieldOnChange(Dataset.FindField('UnitofMeasureShipped'));
                /// {if not InternalQuantityChange then }DoContainerEvent(Self, evSalesLineQtyChange);
              End;
              If (Sysutils.SameText(Sender.FieldName, 'Shipped')) Or (Sysutils.SameText(Sender.FieldName, 'UnitofMeasureShipped')) Then Begin
                UOMQtySold := UOMQtyShipped;
                QtySold    := QtyShipped;
                AddEvent(BusObjEvent_Change, BusObjEventVal_ShippingTreeItem, Self.ID);
                DoFieldOnChange(Dataset.FindField('UnitofMeasureQtySold'));
                /// /{if not InternalQuantityChange then }DoContainerEvent(Self, evSalesLineQtyChange);
              End;
              PostDB;
            Finally ShippingTreeItem := False;
            End;
          End;
      End;
  End;

End;

Procedure TSalesOrderLine.FinaliseTree;
Begin
  Inherited;
  // if ProcPrefs.WastageCalculationEnabled  then begin
  If Not TreeFinalized Then Begin
    TreeFinalized := True;
    PostDb;
    DoContainerEvent(Self, EvSalesLineMakeCleanTree);
  End;
  // end;
End;
function TSalesOrderLine.getLineCompletelyBuilt: Boolean;
begin
    result := True;
    If Not(IsTreeItem) Then Exit;
    if Round(Rootproctree.TotalQty -  Rootproctree.ManufacturedUOMQty , RoundPlacesGeneral) > 0 then begin
       Result := False;
       Exit;
    end;
    AllLinesValid := True;
    Rootproctree.ProcTreePart.ManufacturedProgress.IterateRecords(LineCompletelyBuiltCallback);
    Result := AllLinesValid ;
end;
procedure TSalesOrderLine.LineCompletelyBuiltCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is TProcProgressIn then begin
    if (TProcProgressIn(Sender).buildstatus <> 'D') and (TProcProgressIn(Sender).buildstatus <> 'W') then begin
         AllLinesValid := False;
         abort := True;
         Exit;
    end;
  end;
end;

Procedure TSalesOrderLine.GetProductDetails;
Begin

  Inherited;
  SupplierName := Product.PreferedSupplierName;
End;

Procedure TSalesOrderLine.CreateInstance;
Begin
  If IsMergingSOToInvoice Then Begin
    If Assigned(Owner) Then
      If Owner Is TSalesOrder Then Begin
        ObjInstanceToClone := TSalesOrder(Owner).MergingInvoice.Lines;
        Exit;
      End;
  End;
  Inherited;
End;

Function TSalesOrderLine.SalesOrder: TSalesOrder;
Begin
  Result := Nil;
  If Assigned(Owner) And (Owner Is TSalesOrder) Then Result := TSalesOrder(Owner);
End;

function TSalesOrderLine.Save: Boolean;
begin
  LogContianerNames;
  result:= inherited Save;
end;
Procedure TSalesLine.LogContianerNames;
begin
  Exit;
(*var x: integer;
begin
  try logtext('Sales Order Line #' + inttostr(ID) +' Containers : '+ inttostr(Container.Count)); except end;
  if Assigned(Container) then begin
    for x:= 0 to Container.Count -1 do begin
      if Container[x] is TBusObjBase then begin
        logtext(inttostr(x)+' : '+ TBusObjBase(Container[x]).Classname +',' + inttostr(Integer(TBusObjBase(Container[x])))+','+
        iif(opSave in TBusObjBase(Container[x]).Options , 'Save' , 'Do Not Save'));
      end else begin
        logtext(inttostr(x)+' : '+ Container[x].Classname );
      end;
    end;
  end;
  logtext('=============================================');*)
end;

Procedure TSalesOrderLine.SaveToXMLNode(Const Node: IXMLNode);
Begin
  Inherited;
  AddXMLNode(Node, 'TreeFinalized', TreeFinalized);
  AddXMLNode(Node, 'SmartOrderLineID', SmartOrderLineID);
  AddXMLNode(Node, 'BundleQty', BundleQty);
  AddXMLNode(Node, 'totalInvoicedQty', TotalInvoicedQty);
End;

Procedure TSalesOrderLine.LoadFromXMLNode(Const Node: IXMLNode);
Begin
  Inherited;
  SetBooleanPropertyFromNode(Node, 'TreeFinalized');
  SetPropertyFromNode(Node, 'SmartOrderLineID');
  SetPropertyFromNode(Node, 'BundleQty');
End;

Function TSalesOrderLine.GettotalInvoicedQty: Double;
var
  qry: TERPQuery;
Begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(connection.connection);
  try
    With qry do begin
      SQL.text := 'select Sum(Qty) totalQty from tblsalesorderinvoicelines where SalesOrderLineID = ' + Inttostr(ID);
      open;
      REsult := Fieldbyname('totalQty').AsFloat;
      Close;
      SQL.text := 'select '+
                  ' Sum(PPG.Qty) as Qty '+
                  ' from tblsaleslines SL '+
                  ' inner join tblproctree PT on SL.saleLineId = PT.masterId and PT.mastertype = "mtsalesOrder" and PT.ProcTreeId = PT.TreeRootId '+
                  ' inner join tblprocprogress PPG on PT.ProcTreeId = PPG.ProcTreeId and PPG.Alloctype ="IN" '+
                  ' where SL.salelineID= ' + inttostr(ID);
      open;
      REsult := result + Fieldbyname('Qty').AsFloat;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
End;

Function TSalesOrderLine.GetTreeFinalized     :Boolean;Begin  result:= GetbooleanField('TreeFinalized')   ;End;
function TSalesOrderLine.getXMLTocopyLine: String;
var
  xnode: IXMLNode;
  xXMLDoc   :TXMLDocument;
begin
    xXMLDoc := TXMLDocument.Create(self);
    try
    xXMLDoc.Active := true;
    xXMLDoc.Version := XMLDocVersion;
    xXMLDoc.Encoding := XMLDocEncoding;
    xnode:= xXMLDoc.AddChild(XMLDocRoot);
    xnode.Attributes['DataVersion'] := getUserVersion;
    xnode := xnode.Addchild(XMLDocRequest);
    xnode.Attributes['OnError'] := XMLDocRequestStopError;
    xnode.Attributes['DataObject'] := Self.ClassName;
    xnode:= xnode.AddChild(XMLNodeName);

    AddXMLNode(xnode, 'ProductName'           , ProductName);
    AddXMLNode(xnode, 'UOM'                   , UnitOfMeasure);
    AddXMLNode(xnode, 'UOMMultiplier'         , UOMMultiplier);
    AddXMLNode(xnode, 'UOMQtySold'            , UOMQtySold);
    AddXMLNode(xnode, 'UOMQtyShipped'         , UOMQtyShipped);
    AddXMLNode(xnode, 'OriginalLinePrice'     , OriginalLinePrice);
    AddXMLNode(xnode, 'LinePrice'             , LinePrice);
    AddXMLNode(xnode, 'DiscountAmount'        , DiscountAmount);
    AddXMLNode(xnode, 'DiscountPercent'       , DiscountPercent);
    AddXMLNode(xnode, 'MarkupAmount'          , MarkupAmount);
    AddXMLNode(xnode, 'MarkupPercent'         , MarkupPercent);
    AddXMLNode(xnode, 'MarginAmount'          , MarginAmount);
    AddXMLNode(xnode, 'MarginPercent'         , MarginPercent);
    AddXMLNode(xnode, 'Attrib1Sale'           , Attrib1Sale);
    AddXMLNode(xnode, 'Attrib2Sale'           , Attrib2Sale);
    AddXMLNode(xnode, 'Attrib1SaleRate'       , Attrib1SaleRate);
    AddXMLNode(xnode, 'Attrib1SaleEst'        , Attrib1SaleEst);
    AddXMLNode(xnode, 'Attrib2SaleEst'        , Attrib2SaleEst);
    AddXMLNode(xnode, 'MemoLine'              , MemoLine);
    AddXMLNode(xnode, 'SalesLinesCustField1'  , SalesLinesCustField1);
    AddXMLNode(xnode, 'SalesLinesCustField2'  , SalesLinesCustField2);
    AddXMLNode(xnode, 'SalesLinesCustField3'  , SalesLinesCustField3);
    AddXMLNode(xnode, 'SalesLinesCustField4'  , SalesLinesCustField4);
    AddXMLNode(xnode, 'SalesLinesCustField5'  , SalesLinesCustField5);
    AddXMLNode(xnode, 'SalesLinesCustField6'  , SalesLinesCustField6);
    AddXMLNode(xnode, 'SalesLinesCustField7'  , SalesLinesCustField7);
    AddXMLNode(xnode, 'SalesLinesCustField8'  , SalesLinesCustField8);
    AddXMLNode(xnode, 'SalesLinesCustField9'  , SalesLinesCustField9);
    AddXMLNode(xnode, 'SalesLinesCustField10' , SalesLinesCustField10);
    AddXMLNode(xnode, 'FormulaQtySoldValue'   , FormulaQtySoldValue);
    AddXMLNode(xnode, 'FormulaQtySoldValue1'  , FormulaQtySoldValue1);
    AddXMLNode(xnode, 'FormulaQtySoldValue2'  , FormulaQtySoldValue2);
    AddXMLNode(xnode, 'FormulaQtySoldValue3'  , FormulaQtySoldValue3);
    AddXMLNode(xnode, 'FormulaQtySoldValue4'  , FormulaQtySoldValue4);
    AddXMLNode(xnode, 'FormulaQtySoldValue5'  , FormulaQtySoldValue5);
    AddXMLNode(xnode, 'FormulaQtyShippedValue', FormulaQtyShippedValue);
    AddXMLNode(xnode, 'FormulaQtyShippedValue1', FormulaQtyShippedValue1);
    AddXMLNode(xnode, 'FormulaQtyShippedValue2', FormulaQtyShippedValue2);
    AddXMLNode(xnode, 'FormulaQtyShippedValue3', FormulaQtyShippedValue3);
    AddXMLNode(xnode, 'FormulaQtyShippedValue4', FormulaQtyShippedValue4);
    AddXMLNode(xnode, 'FormulaQtyShippedValue5', FormulaQtyShippedValue5);

  FESalesLines.XMLPropertyNode := xnode.AddChild(FESalesLines.XMLBranchName);
  FESalesLines.XMLPropertyName := XMLNodename + FESalesLines.XMLNodename;
  FESalesLines.IterateREcords(GetPropertyXMLCallback);


    result := xXMLDoc.XML.Text;
  finally
    freeandNil(xXMLDoc);
  end;

end;

function TSalesOrderLine.getRootproctree: TproctreeRoot;
begin
  Result := TproctreeRoot(Getcontainercomponent(TproctreeRoot, 'MasterId = ' + IntToStr(ID)+' and MasterType <> ' + Quotedstr('mtProduct')+' and ifnull(ParentId,0)=0', True, True));
end;

function TSalesOrderLine.getRootProcTreePartID: Integer;
var
  Qry:TERPQuery;
begin
   Qry := DbSharedObj.GetQuery(Self.Connection.Connection);
   try
     Qry.SQL.Text := 'Select PTP.ProcTreePartId ' +
                      ' from tblproctree PT ' +
                      ' inner join tblproctreepart PTP on PT.ProcTreeId = PTP.ProcTreeId ' +
                      ' Where PT.masterID = ' + inttostr(ID) +' and PT.MasterType <> "mtProduct" and ifnull(PT.ParentId,0)=0 ';
     Qry.Open;
     result := Qry.fieldbyname('ProcTreePartId').AsInteger;
   finally
     DbSharedObj.ReleaseObj(Qry);
   end;
end;

function TSalesOrderLine.getSmartOrderLineID  :Integer;begin  result:= GetIntegerField('SmartOrderLineID');end;
function TSalesOrderLine.getBundleQty  :Double;begin  result:= GetfloatField('BundleQty');end;
Procedure TSalesOrderLine.SetTreeFinalized    (Const Value:Boolean);Begin  SetBooleanfield('TreeFinalized'    , Value);End;
Procedure TSaleSOrderline.SetSmartOrderLineID (const Value:Integer);begin  SetIntegerfield('SmartOrderLineID' , Value);end;
Procedure TSaleSOrderline.SetBundleQty (const Value:Double);begin  SetFloatfield('BundleQty' , Value);end;

procedure TSalesOrderLine.SetDefaultQtyShipped;
begin
  inherited;
  DoContainerEvent(Self, evSalesLineCalcTreePrice);
end;

// ------------------------------------------------------------------------------
{ TSalesOrder }
// ------------------------------------------------------------------------------

Constructor TSalesOrder.Create(AOwner: TComponent);
Begin
  Inherited;
  FTotalProgressPayment := Nil;
  FProgressPayments     := Nil;
  FTotalPrePayment      := Nil;
  FPrePayments          := Nil;

  FBusObjectTypeDescription := 'Sales Order Object';
  FOriginalSale             := Nil;
  POIDs                     := '';
  IsMergingSOToInvoice      := False;
End;

Function TSalesOrder.HasalreadyConvertedBinBatchSRProduct(FirstSOID: Integer): Boolean;
Var
  StrSQL : STring;
  SaleIDs: String;
Begin
  Result := False;
  With GetNewDataset(GetSOwithAllBOs(FirstSOID), True) Do
    Try
      If Recordcount = 0 Then Exit;
      First;
      SaleIDs := '';
      While Eof = False Do Begin
        If SaleIDs <> '' Then SaleIDs := SaleIDs + ',';
        SaleIDs                       := SaleIDs + FieldByname('SaleID').AsString;
        Next;
      End;
    Finally
      If Active Then Close;
      Free;
    End;
  StrSQL := 'Select  distinct tblsales.SaleID ' + ' From tblsales ' + ' inner join tblSalesLines on tblsales.SaleId = tblSalesLines.SaleId ' +
    ' inner join tblParts on tblSalesLines.ProductID = tblParts.PartsID  ' + ' and (tblParts.SNTracking = "T" or tblparts.MultipleBins =  "T" or tblparts.batch =  "T") ' +
    ' inner join tblsales as invoice on  invoice.SalesorderGlobalref =tblsales.globalref ' + ' inner join tblSalesLines as  invoicelines on  invoice.SaleId =  invoicelines.SaleId  ' +
    ' and invoicelines.ProductId = tblSalesLines.ProductId  ' + ' and invoicelines.SeqNo = tblSalesLines.SeqNo ' + ' where 	tblsales.converted = "T" and tblsales.SaleId in (' + SaleIDs + ')';
  With GetNewDataSet(StrSQl) Do
    Try Result := Recordcount > 0;
    Finally
      If Active Then Close;
      Free;
    End;
End;
{ function TSalesOrder.MergeSalesOrders(SalesIDs: String):Integer;
  var
  SOREcordset:TDataset;
  ErrMsg :String;
  begin
  Result :=0;
  if SalesIDs = '' then Exit;
  SalesIDs := ' (' +SalesIDs + ')';
  SOREcordset := GetNewDataset('Select SubSO.*' +
  ' from tblSales MasterSO inner join tblSales SubSO on MasterSO.GlobalRef = SubSO.OriginalNo and SubSO.Deleted <> "T" ' +
  ' Where MasterSO.SaleId in  ' + SalesIDs , True) ;
  try
  with SOrecordSet do begin
  if recordcount = 0 then begin
  exit;
  end;
  first;
  While eof = False do begin
  if not UserLock.Lock('tblsales' , SOREcordset.Fieldbyname('SaleID').asInteger) then begin
  ErrMsg := ReplaceStr(userlock.LockMessage, 'this record' , 'one of the salesorder or the backorder record' );
  Resultstatus.AddItem(false,rssError,0,Errmsg);
  Exit;
  end;
  Next;
  end;
  end;
  MergingInvoice :=TInvoice.create(self);
  try
  MergingInvoice.Connection := Self.Connection;
  MergingInvoice.DoProductallocation:= DoProductallocation;
  LoadSelect('saleid in ' + SalesIDs);
  if count = 0 then Exit;
  MergingInvoice.LockGroupName := Self.LockGroupName;
  Connection.BeginTransaction;
  try
  IsMergingSOToInvoice := True;
  MergingInvoice.ISMergingSO := true;
  try
  AllMergedOk := true;
  MergeCtr := 0;
  MergingInvoice.convertingSO := True;
  IterateRecords(MergeSOs);
  if  AllMergedOk then begin
  MergingInvoice.Globalref := '';
  MergingInvoice.postDB; // force generating the globalref
  MergingInvoice.IsSalesOrder := False;
  MergingInvoice.IsInvoice := True;
  MergingInvoice.OriginalDocNumber:=Globalref;
  (*if AppEnv.CompanyPrefs.UseShippedDateForTerms then // to change DueDate
  MergingInvoice.SetPaymentTerms(MergingInvoice.ShipDate)
  else
  MergingInvoice.SetPaymentTerms(MergingInvoice.SaleDate);*)
  MergingInvoice.InitPaymentTerms;
  MergeCtr := 1;
  MergingInvoice.Lines.Iteraterecords(AssignSeqno);
  MergingInvoice.IsInvoice := True;
  MergingInvoice.IsSalesOrder := False;
  MergingInvoice.PostDB;
  MergingInvoice.Silentmode := False;
  if not MergingInvoice.Save then begin
  connection.RollbackTransaction;
  UserLock.UnlockAllCurrentUser;
  Result := 0;
  Exit;
  end;

  //flag all the selected sales orders and its back orders to converted;
  with SOrecordSet do begin
  if recordcount = 0 then exit;
  first;
  While eof = False do begin
  PostList.AddQuery('update tblSales Set converted = "T" where saleID = ' + FieldByname('SaleID').AsString);
  Next;
  end;
  end;
  if not PostList.Execute then begin
  Result := 0;
  Exit;
  end;

  connection.CommitTransaction;
  UserLock.UnlockAllCurrentUser;
  Result := MergingInvoice.ID;
  end;
  finally
  IsMergingSOToInvoice := False;
  MergingInvoice.ISMergingSO := False;
  end;
  Except
  on E:Exception do begin
  connection.RollbackTransaction;
  ResultStatus.AddItem(false,rssError,0,'Merging of sales orders failed.' + chr(13) + E.Message);
  Self.connection.RollbackTransaction;
  Exit;
  end;
  end;
  Finally
  FreeandNil(MergingInvoice);
  end;
  finally
  if SORecordset.active then SORecordSet.close;
  FreeandNil(SORecordset);
  end;
  end; }

Procedure TSalesOrder.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; Const EventType, Value: String);
Begin
  // this is to cancel calling the busobjevent of sales object
End;


Procedure TSalesOrder.ApplyPrepayment(InvoiceObj: TInvoice);
Var
  CustPrePayments : TCustPrePayments;
  PrepaymentIDs   : String;
  FdInvoiceBalance: Double;
Begin
  With TERPQuery(Getnewdataset('Select PP.* ' + ' from tblSalesPrepayments  SP' + ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  ' + ' Where PP.Deleted = "F" and SP.SalesRef= ' +
    Quotedstr(InvoiceObj.SalesOrderGlobalRef), True)) Do
    Try PrepaymentIDs := GroupConcat('PrePaymentID', 'ForeignExchangeCode = ' + Quotedstr(InvoiceObj.ForeignExchangeCode));
    Finally ClosenFree;
    End;

  If PrepaymentIDs = '' Then Exit;

  If Appenv.AccessLevels.GetEmployeeAccessLevel(TCustPrePayments.ClassName) > 3 Then Begin
    BusobjMessageDlg('You don''t have enough access to create a customer payment. Prepayment(s) are not applied to the Invoice', MtWarning, [MbOK], 0);
    Exit;
  End;
  CustPrePayments := TCustPrePayments.Create(InvoiceObj);
  Try
    CustPrePayments.BusObjEvent := DoBusinessObjectEvent;
    CustPrePayments.Connection  := Self.Connection;
    CustPrePayments.LoadSelect('PrePaymentID in (' + PrepaymentIDs + ')');
    If CustPrePayments.Count = 0 Then Exit;
    CustPrePayments.First;
    FdInvoiceBalance := InvoiceObj.TotalBalance;
    If (InvoiceObj.Count = 1) And (FdInvoiceBalance > 0) Then Begin
      While CustPrePayments.Eof = False Do Begin
        CustPrePayments.ApplyTOInvoice(InvoiceObj.ID, FdInvoiceBalance);
        CustPrePayments.Next;
      End;
    End;

  Finally FreeandNil(CustPrePayments);
  End;
End;

(* procedure TSalesOrder.AssignSeqno(Const Sender: TBusObj; var Abort: boolean);
  begin
  if not (Sender is TSalesLine) then exit;
  TsalesLine(sender).SeqNo := MergeCtr;
  TsalesLine(sender).PostDB;
  inc(MergeCtr);
  end; *)
(* procedure TSalesOrder.MergeSOs(Const Sender: TBusObj; var Abort: boolean);
  begin
  if MergeCtr = 0 then begin
  if CloneBusObj('SaleDate',DateOf(now),False , 'SaleID') = nil then begin
  AllMergedOk := False;
  abort := True;
  Exit;
  end;
  end else ClonePropertyObjects;
  inc(MergeCtr);
  end; *)
Destructor TSalesOrder.Destroy;
Begin
  If Assigned(FTotalProgressPayment) Then Begin
    If FTotalProgressPayment.Active Then FTotalProgressPayment.Close;
    Freeandnil(FTotalProgressPayment);
  End;
  If Assigned(FProgressPayments) Then Begin
    If FProgressPayments.Active Then FProgressPayments.Close;
    Freeandnil(FProgressPayments);
  End;
  If Assigned(FTotalPrePayment) Then Begin
    If FTotalPrePayment.Active Then FTotalPrePayment.Close;
    Freeandnil(FTotalPrePayment);
  End;
  If Assigned(FPrePayments) Then Begin
    If FPrePayments.Active Then FPrePayments.Close;
    Freeandnil(FPrePayments);
  End;

  Inherited;
End;

Procedure TSalesOrder.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
Begin
  Inherited;
  If Assigned(FTotalProgressPayment) Then Begin
    If FTotalProgressPayment.Active Then FTotalProgressPayment.Close;
    Freeandnil(FTotalProgressPayment);
  End;
  If Assigned(FProgressPayments) Then Begin
    If FProgressPayments.Active Then FProgressPayments.Close;
    Freeandnil(FProgressPayments);
  End;
  If Assigned(FTotalPrePayment) Then Begin
    If FTotalPrePayment.Active Then FTotalPrePayment.Close;
    Freeandnil(FTotalPrePayment);
  End;
  If Assigned(FPrePayments) Then Begin
    If FPrePayments.Active Then FPrePayments.Close;
    Freeandnil(FPrePayments);
  End;

  If (ChangeType = DcNew) Or ((ChangeType = DcLoad) And (Id < 1)) Then Begin
    // Save so autoinc id is assigned
    If Not IsSalesOrder Then Begin
      IsInvoice    := False;
      IsCashSale   := False;
      IsRefund     := False;
      IsSalesOrder := True;
      IsQuote      := False;
      IsPos        := False;
      PostDB;
    End;
  End;
  If Assigned(FOriginalSale) Then Freeandnil(FOriginalSale);
  POIDs := '';
End;

Procedure TSalesOrder.DoFieldOnChange(Sender: TField);
Begin
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.
  Inherited;
  If Sysutils.SameText(Sender.FieldName, 'SaleDate') Then Begin
    If Not RawMode Then Begin
      { removed this so we always have the sales original creation date ..
        no idea why we where resetting it here. NOTE OrderKPIListing needs
        original creation date }
      // CreationDate := SaleDate;
      ShipDate := IncDay(SaleDate, AppEnv.CompanyPrefs.ShippedDaysAfterCreate);
    End;
  End
  Else If (Sysutils.SameText(Sender.FieldName, 'QuoteStatus')) Then Begin
    If Not RawMode Then Begin
      If (SalesStatus <> CleanSalesStatus) And (SameText(SalesStatus, 'Approved')) Then
        If AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanApproveSalesOrder') <> 1 Then Begin
          REsultStatus.AddItem(False, RssWarning, 0, AppEnv.Employee.Employeename + ' is not Allowed to Approve Sales Order');
          SalesStatus := CleanSalesStatus;
        End;
      If (SalesStatus <> CleanSalesStatus) And (SameText(SalesStatus, 'Delivered')) Then
        If AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanDeliverSalesOrder') <> 1 Then Begin
          REsultStatus.AddItem(False, RssWarning, 0, AppEnv.Employee.Employeename + ' is not Allowed to Deliver sales Order');
          SalesStatus := CleanSalesStatus;
        End;
    End;
  End
  Else If SameText(Sender.Fieldname, 'IsInternalOrder') Then Begin
    If (Backorderglobalref <> '') Or (BaseNo <> '') Then Begin
      IsInternalOrder := CleanIsInternalOrder;
      SendEvent(BusObjEvent_Cancelchange, BusobjEventVal_InternalOrder, Self);
    End;
    If Not RawMode Then Begin
      If IsInternalOrder Then Lines.Iteraterecords(SalesInternalOrderchangeCallback);
    End;
  End;
End;

function TSalesOrder.getallBuilt: Boolean;
begin
  AllLinesValid := True;
  Lines.IterateRecords(allBuiltCallback);
  result := AllLinesValid;
end;
Procedure TSalesOrder.allBuiltCallback(Const Sender: TBusObj; Var Abort: Boolean);
begin
  If (Sender Is TSalesorderline) Then begin
    If Not(TSalesorderline(Sender).IsTreeItem) Then Exit;
    if not TSalesorderline(Sender).LineCompletelyBuilt then begin
       AllLinesValid := False;
       abort := True;
       Exit;
    end;
  end;
end;
Procedure TSalesOrder.SalesInternalOrderchangeCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TSalesorderline) Then Exit;
  If Not(TSalesorderline(Sender).IsTreeItem) Then Exit;
  TSalesorderline(Sender).DoContainerEvent(Self, EvSalesBuildWhole);
End;

Function TSalesOrder.GetLines: TTransLineBase;
Begin
  Result                                    := GetSalesOrderLines;
  If Self.SilentMode Then Result.SilentMode := True;
End;

Function TSalesOrder.GetSalesOrderLines: TSalesOrderLine;
Begin
  Result := TSalesOrderLine(GetContainerComponent(TSalesOrderLine, 'SaleID = ' + IntToStr(Self.Id)));
End;

Procedure TSalesOrder.InitializeNewObject;
Begin
  IsInvoice    := False;
  IsCashSale   := False;
  IsRefund     := False;
  IsSalesOrder := True;
  IsQuote      := False;
  Inherited;
End;

Function TSalesOrder.GetSaleLines: TSalesLineBase;
Begin
  Result := Self.GetSalesOrderLines;
End;

Function TSalesOrder.Save: Boolean;
Var
  Fsfilter        : String;
  Fbfiltered      : Boolean;
  BackOrder       : TSalesOrder;
  CombinedTransRef: STring;
  // strSQL:String;
  Procedure CreateSmartOrder;
  Begin
    If BaseNo = '' Then
      If AutoSmartOrderRef = '' Then
        If Lines.Count > 0 Then Begin
          Fsfilter                                   := Lines.Dataset.Filter;
          Fbfiltered                                 := Lines.Dataset.Filtered;
          If Fsfilter = '' Then Lines.Dataset.Filter := 'AutoSmartOrder = ''T'' '
          Else Lines.Dataset.Filter                  := Lines.Dataset.Filter + ' and AutoSmartOrder = ''T'' ';
          Lines.Dataset.Filtered                     := True;
          Try
            If Lines.Count > 0 Then CopySalesorderToSmartOrder;
          Finally
            Lines.Iteraterecords(Ordered);
            Lines.Dataset.Filter   := FsFilter;
            Lines.Dataset.Filtered := Fbfiltered;
            Dirty                  := False;
          End;
        End;
  End;

Begin

  Result := False;
  Try
    Try
      PostList.Clear;
      If Not ValidateData Then Exit;
      If Not SaveGUIValidate Then Exit;

      CalcOrderTotals;
      If UpdateAccounts Then Begin
        Result := Inherited Save;
        If Not Result Then Exit;

        { now validate then Sales order lines }
        AllLinesSavedOK := True;
        //Lines.IterateRecords(LineSaveCallbackProc, True);

        Fbfiltered := Lines.filtered;
        Lines.filtered:= False;
        try
          Lines.IterateRecords(LineSaveCallbackProc, True);
        finally
          Lines.filtered:= Fbfiltered;
        end;


        Result := AllLinesSavedOK;

        If Result Then Begin
          If (UpdatingBo = False) And (DeletingTomergeOutstandingsale = False) Then Begin
//            BackOrder := TSalesOrder.Create(Nil);
            BackOrder := TSalesOrder(TComponentClass(FindClass(Self.ClassName)).Create(nil));
            Try
              BackOrder.Connection := Self.Connection; // this connection expected to be wihtin transaction
              BackOrder.LoadSelect('GlobalRef = ' + QuotedStr(Self.BackOrderGlobalRef));
              (* BackOrder.IgnoreAccesslevel := True; *)
              BackOrder.AccessManager.AccessLevel := 1;
              BackOrder.UpdatingBo                := True;
              CombinedTransRef                    := Customer.CombinedSalesOrderBOID;
              CheckBackOrders(BackOrder, Appenv.CompanyPrefs.CombinedSaleOrderBO, CombinedTransRef);
              ProcessPQADetailClasses;
              // if (Appenv.CompanyPrefs.CombinedSaleOrderBO) and (combinedTransRef <> customer.CombinedSalesOrderBOID) then begin
              // strSQL :='Update tblClients Set  CombinedSaleOrderBOID = ' +quotedStr(combinedTransRef) + ' where clientId = ' + IntToStr(customer.ID);
              // PostList.AddQuery(strSQL , customer.ID , customer.BusObjectTableName , True);
              // end;
            Finally FreeandNil(BackOrder);
            End;
          End;
          If Not PostList.Execute Then Begin
            Result := False;
            Exit;
          End;
          { Create the Smart Order for the flagged products }
          CreateSmartOrder;
          UpdateBORefs;
        End;
      End Else Begin
        Result := False;
      End;

      Self.UnLock;
      If Result Then begin
        Dirty := False;
      Try
        If Lines.Count = 0 Then
            TLeadToAddProgressionRecord.AddProgressionRecord(ClientID, LeadActionSalesOrder, Id, GlobalRef, Comments, SAleDate, Id, Globalref, True, EmployeeId,
            GetSimpleType('Deleted', SimpleTypes_StatusType))
        Else Begin
          If CleanCustomerID <> 0 Then
              TLeadToAddProgressionRecord.AddProgressionRecord(CleanCustomerID, LeadActionSalesOrder, Id, GlobalRef, 'Deleted ' + XMLNodeName + ' # ' + Inttostr(ID) + '  from ' +
              Quotedstr(Cleancustomer) + '. Moved to Customer : ' + Quotedstr(CustomerName) + NL + Comments, SAleDate, Id, Globalref, True, EmployeeId,
              GetSimpleType('Changed Customer', SimpleTypes_AppointmentStatusType, True));
          TLeadToAddProgressionRecord.AddProgressionRecord(ClientID, LeadActionSalesOrder, Id, GlobalRef, Comments, SAleDate, Id, Globalref, True, EmployeeId);
        End;
      Except
        On E: Exception Do Begin
        End;
      End;
      end;
    Finally
      If Result Then Lines.IterateRecords(UpdateCustomerEquipQty);
    End;
  Finally
    If Result Then Result := Validtocommit;
    If UpdatingBo = False Then Show_Status('');

  End;
  If Result Then Begin
    If DeleteFlaggedLines Then Begin
      Dirty := False;
      CreateSmartOrder;
    End
    Else Result := False;
  End;
End;

Procedure TSalesOrder.LineSaveCallbackProc(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  stepProgress;
  Show_Status('Updating Product''s Quantity : ' + IntToStr(Sender.Dataset.Recno) + ' of ' + IntToStr(Sender.Dataset.Recordcount));
  If UpdatingBo = False Then TSalesOrderLine(Sender).ChangeOrderQty;
  If Not TSalesOrderLine(Sender).Save Then Begin
    AllLinesSavedOK := False;
    Abort           := True;
  End;
End;

Procedure TSalesOrder.Load(Const FIsReadonly: Boolean = False);
Begin
  Inherited;

End;

Procedure TSalesOrder.LoadFromXMLNode(Const Node: IXMLNode);
Begin
  Inherited;
  SetPropertyFromNode(Node, 'SalesOrderBalance');
  SetBooleanPropertyFromNode(Node, 'Converted');
  SetPropertyFromNode(Node, 'InternalSOGlobalref');
  SetBooleanPropertyFromNode(Node, 'IsInternalOrder');
End;

Function TSalesOrder.LockSOnSOInvoices: Boolean;
Var
  SOInvoices: TInvoice;
  S         : String;
Begin
  REsult := LockRec;
  If Not Result Then Begin
    REsultStatus.AddItem(False, RssWarning, 0, ReplaceStr(Userlock.LockMessage, 'Unable to update data.', 'Unable to convert sales Order # ' + Inttostr(ID) + '.'), True);
    Exit;
  End;
  S := SalesOrderInvoiceIds;
  If S <> '' Then Begin
    SOInvoices := TInvoice.Create(Nil);
    Try
      SOInvoices.LoadSelect('SaleId in (' + S + ')');
      AllLinesValid := True;
      SOInvoices.IterateRecords(LockSOnSOInvoicesCallback);
    Finally Freeandnil(SOInvoices);
    End;
  End;
End;

Procedure TSalesOrder.LockSOnSOInvoicesCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TInvoice) Then Exit;
  If Not Userlock.Lock(TInvoice(Sender).BusobjectTableName, TInvoice(Sender).ID, LockGroupName) Then Begin
    AllLinesValid := False;
    Abort         := True;
    ResultStatus.AddItem(False, RssWarning, 0, ReplaceStr(UserLock.LockMessage, 'Unable to update data.', 'Unable Convert Sales Order # ' + Inttostr(ID) + ' as one of the Partial Invoice #' +
      Inttostr(TInvoice(Sender).ID) + ' is locked.'));
  End;
End;

Procedure TSalesOrder.SaveToXMLNode(Const Node: IXMLNode);
Begin
  Inherited;
  AddXMLNode(Node, 'SalesOrderBalance', SalesOrderBalance);
  AddXMLNode(Node, 'Converted', Converted);
  AddXMLNode(Node, 'InternalSOGlobalref', InternalSOGlobalref);
  AddXMLNode(Node, 'IsInternalOrder', IsInternalOrder);
End;

Function TSalesOrder.ValidateData: Boolean;
Begin
  Show_Status('Validating .');
  if IsInternalOrder then
    if not Anylinehastree then begin
      IsInternalOrder:= False;
      PostDB;
    end;

  If Deleted Or Cancelled Then Begin
    Result := True;
    Exit;
  End;
  Result := Inherited ValidateData;
  If Not Result Then Exit;

  Result := ValidateLines;
End;

Function TSalesOrder.UnGroupProductionEntry(Const SaleLineID: Integer; Var MSG: String): Boolean;
Begin
  REsult := False;
  If Not(Lines.Locate(Lines.IDFieldName, SaleLineID, [])) Then Begin
    Msg := 'Item not found to Ungroup';
    Exit;
  End;
  If Lines.BOMProductionLine = False Then Begin
    Msg := 'This is not a grouped line to ungroup';
    Exit;
  End;
  Connection.BeginTransaction;
  Connection.BeginNestedTransaction;
  Try
    If SalesGroupedLines.Count > 0 Then Begin
      SalesGroupedLines.First;
      While SalesGroupedLines.EOF = False Do Begin
        If SalesGroupedLines.BOMProductionLineID = SalelineId Then Begin
          If Lines.Locate(Lines.IDFieldName, SalesGroupedLines.BOMGroupedLineID, []) Then Begin
            Lines.BOMGroupedLine := False;
            Lines.PostDb;
            Lines.Save;
          End;
        End;
        SalesGroupedLines.Next;
      End;
      SalesGroupedLines.Dataset.Filter   := 'BOMProductionLineID = ' + Inttostr(SalelineId);
      SalesGroupedLines.Dataset.Filtered := True;
      Try SalesGroupedLines.DeleteAll;
      Finally
        SalesGroupedLines.Dataset.Filter   := '';
        SalesGroupedLines.Dataset.Filtered := False;
      End;
    End;
    If Lines.Locate(Lines.IDFieldName, SaleLineID, []) Then Begin
      Lines.Deleted := True;
      Lines.PostDb;
      Lines.Save;
    End;
    If Save Then Begin
      Result := True;
      Connection.CommitNestedTransaction;
    End Else Begin
      Connection.RollbackNestedTransaction;
      Result := False;
    End;
  Except
    On E: Exception Do Begin
      Connection.RollbackNestedTransaction;
    End;
  End;
End;

Function TSalesOrder.UpdateAccounts: Boolean;
Var
  CleanNode                          : IXMLNode;
  CleanCustomerID                    : Integer;
  CleanTotalAmountInc, CleanTotalCost: Double;
Begin
  // BalancePostList.Clear;

  CleanNode := Self.CleanXMLNode;
  If Assigned(CleanNode) And (CleanNode.ChildNodes.Count > 0) Then Begin
    CleanTotalAmountInc := GetXMLNodeFloatValue(CleanNode, 'TotalAmountInc');
    CleanTotalCost      := GetXMLNodeFloatValue(CleanNode, 'TotalCost');
    CleanCustomerID     := GetXMLNodeIntegerValue(CleanNode, 'CustomerID');
    If (CleanTotalAmountInc = 0) And (CleanCustomerID = 0) And (CleanTotalCost = 0) Then
    Else Begin
      { we have clean (original) values so these need to be reversed }
      PostList.AddAmount(Customer.ClassName, Customer.BusObjectTableName, CleanCustomerID, -CleanTotalAmountInc, BtSO);

      // UninvoicedSOtoGL
      If (Not IsInternalOrder) And AppEnv.CompanyPrefs.IncludeUnInvoicedSOtoGL Then Begin
        If AppEnv.CompanyPrefs.UnInvoicedSOType = 0 Then Begin // Income
          PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, // From UnInvoicedSO
            TcDataUtils.GetAccountID('UnInvoiced SO'), CleanTotalAmountInc);
          PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, // To Preferred Account
            AppEnv.CompanyPrefs.UnInvoicedSOAccount, -CleanTotalAmountInc);
        End;
        If AppEnv.CompanyPrefs.UnInvoicedSOType = 1 Then Begin // Cost
          PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, // From UnInvoicedSO
            TcDataUtils.GetAccountID('UnInvoiced SO'), CleanTotalCost);
          PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, // To Preferred Account
            AppEnv.CompanyPrefs.UnInvoicedSOAccount, -CleanTotalCost);
        End;
      End;
    End;
  End;
  { New customer balance }
  PostList.AddAmount(Customer.ClassName, Customer.BusObjectTableName, CustomerID, Self.TotalAmountInc, BtSO);

  // UninvoicedSOtoGL
  If (Not IsInternalOrder) And AppEnv.CompanyPrefs.IncludeUnInvoicedSOtoGL Then Begin
    If AppEnv.CompanyPrefs.UnInvoicedSOType = 0 Then Begin // Income
      PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, // From UnInvoicedSO
        TcDataUtils.GetAccountID('UnInvoiced SO'), -Self.TotalAmountInc);
      PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, // To Preferred Account
        AppEnv.CompanyPrefs.UnInvoicedSOAccount, Self.TotalAmountInc);
    End;
    If AppEnv.CompanyPrefs.UnInvoicedSOType = 1 Then Begin // Cost
      PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, // From UnInvoicedSO
        TcDataUtils.GetAccountID('UnInvoiced SO'), -Self.TotalCost);
      PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, // To Preferred Account
        AppEnv.CompanyPrefs.UnInvoicedSOAccount, Self.TotalCost);
    End;
  End;
  Result := True;
End;

Procedure TSalesOrder.LineValidateCallbackProc(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  Show_Status('Validating SalesOrder Lines : ' + IntToStr(Sender.Dataset.Recno) + ' of ' + IntToStr(Sender.Dataset.Recordcount));
  If Not TSalesOrderLine(Sender).ValidateData Then Begin
    AllLinesValid := False;
    Abort         := True;
  End;
End;

(* function TSalesOrder.IsCustomerCreditOk: boolean;
  var
  tmpBalance: double;
  DuedatewithGracePeriod:TDateTime;
  begin
  Result:= true;
  if AppEnv.CompanyPrefs.CreditCheckInv = False then exit;
  if TotalAmountInc <= 0 then exit;

  {get the current balance amount - balance amount is the invoice balance + sales order balance}
  tmpBalance:= Customer.CreditBalance;
  result := (tmpBalance + self.TotalAmountInc) >= Customer.CreditLimit ;
  if NOT result then begin
  DuedatewithGracePeriod :=incDay(DueDate, Customer.GracePeriod);
  result := (Date > DuedatewithGracePeriod) ;
  end;
  if not result  then      begin
  Result:= false;
  self.ResultStatus.AddItem(true, rssWarning, BOR_Sales_Warn_CreditExceeded,
  'Customer has Exceeded Credit Limit'#13#10 +
  'Limit: ' + CurrToStrF(Customer.CreditLimit, ffCurrency, 2) +
  '   Amount: ' +
  CurrToStrF(tmpBalance, ffCurrency, 2));
  end;
  end; *)
Procedure TSalesOrder.CreateInstance;
Begin
  If IsMergingSOToInvoice Then Begin
    ObjInstanceToClone := MergingInvoice;
  End Else Begin
    Inherited;
  End;
End;

Procedure TSales.CreateInstance;
Begin
  If CopyingToInvoice Then Begin
    ObjInstanceToClone            := TInvoice.Create(Nil);
    ObjInstanceToClone.Connection := Self.Connection;
    ObjInstanceToClone.Load(0); // this is to avoid loading the whole table
    If Assigned(DoProductallocation) Then TInvoice(ObjInstanceToClone).DoProductallocation := DoProductallocation;
  End
  Else If CopyingToCashSale Then Begin
    ObjInstanceToClone            := TCashSale.Create(Nil);
    ObjInstanceToClone.Connection := Self.Connection;
    ObjInstanceToClone.Load(0); // this is to avoid loading the whole table
    If Assigned(DoProductallocation) Then TCashSale(ObjInstanceToClone).DoProductallocation := DoProductallocation;
  End
  Else If CopyingToSalesorder Then Begin
    ObjInstanceToClone            := TSalesOrder.Create(Nil);
    ObjInstanceToClone.Connection := Self.Connection;
    ObjInstanceToClone.Load(0); // this is to avoid loading the whole table
    If Assigned(DoProductallocation) Then TSalesOrder(ObjInstanceToClone).DoProductallocation := DoProductallocation;
  End
  Else If CopyingToQuote Then Begin
    ObjInstanceToClone            := TQuote.Create(Nil);
    ObjInstanceToClone.Connection := Self.Connection;
    ObjInstanceToClone.Load(0); // this is to avoid loading the whole table
  End;
  If Assigned(ObjInstanceToClone) Then Begin
    ObjInstanceToClone.LockGroupName                  := Self.LockGroupName;
    ObjInstanceToClone.UserLock.IgnoreClassnameinLock := True;
    TSalesBase(ObjInstanceToClone).ConvertingQuote    := ConvertingQuote;
    TSalesBase(ObjInstanceToClone).ConvertingSO       := ConvertingSO;
    TSalesBase(ObjInstanceToClone).ConvertingRepairs  := ConvertingRepairs;
  End;
End;

Function TSalesOrder.GetOriginalSaleRec: TSales;
Begin
  If Self.OriginalDocNumber = '' Then Result                                 := Nil
  Else If Self.OriginalDocNumber = Self.GlobalRef Then Result                := Nil
  Else If Trim(Self.OriginalDocNumber) = Trim(IntToStr(Self.ID)) Then Result := Nil
  Else Begin
    If Not Assigned(FOriginalSale) Then Begin
      FOriginalSale                                       := TSalesOrder.Create(Nil);
      If ConnectionAssigned Then FOriginalSale.Connection := Self.Connection;
    End;
    If FOriginalSale.GlobalRef <> Self.OriginalDocNumber Then Begin
      FOriginalSale.LoadSelect('GlobalRef = ' + QuotedStr(OriginalDocNumber));
    End;
    Result := FOriginalSale;
  End;
End;

function TSalesOrder.IsCustomerCreditOk: Boolean;
begin
  result := true;
  if TotalAmountinc-(TotalProgressPayments + TotalPrepayments) <= 0 then
    exit;
  result := inherited;
end;

Function TSalesOrder.IsCustomerTermsOk: Boolean;
Begin
  // Result:= true;
  Result := Inherited IsCustomerTermsOk;
End;

Function TSalesOrder.GetSalesOrderBalance: Double;
Begin
  Result := GetFloatField('SOBalance');
End;

Function TSalesOrder.GetSalesOrderInvoiceIds: String;
var
  qry: TERPQuery;
  s:String;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    With qry do begin
      SQL.text := 'Select  s.saleID  from tblSalesorderinvoices SOI '+
                  ' inner join tblsales S on SOI.globalref = S.SOInvoiceRef  '+
                  ' Where SOI.SalesOrderID = ' + Inttostr(ID);
      open;
      Result := Groupconcat('saleID');
      Close;
      SQL.text := 'select '+
                  ' invlines.saleID '+
                  ' from tblsaleslines SL '+
                  ' inner join tblproctree PT on SL.saleLineId = PT.masterId and PT.mastertype = "mtsalesOrder" and PT.ProcTreeId = PT.TreeRootId '+
                  ' inner join tblprocprogress PPG on PT.ProcTreeId = PPG.ProcTreeId and PPG.Alloctype ="IN" '+
                  ' inner join tblsaleslines invlines on invlines.PPGRef = ppg.globalref and invlines.PPGInvoiced ="T" '+
                  ' where invlines.saleId  = ' + Inttostr(ID);
      open;
      s := Groupconcat('saleID');
      if s<> '' then begin
        if result <> '' then result := result +',';
        result := result + s;
      end;
      Close;
    End;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

    With TERPQuery(GetNewDataset('Select  s.saleID  from tblSalesorderinvoices SOI inner join tblsales S on SOI.globalref = S.SOInvoiceRef Where SOI.SalesOrderID = ' + Inttostr(ID), True)) Do
    Try Result := Groupconcat('saleID');
    Finally
      If Active Then Close;
      Free;
    End;
End;

Procedure TSalesOrder.SetSalesOrderBalance(Const Value: Double);
Begin
  SetFloatField('SOBalance', Value);
End;

Function TSalesOrder.LineTreeRootID(LineID: Integer): Integer;
Begin
  With GetNewDataSet('Select ProctreeId from  tblproctree where mastertype <> "mtProduct" and masterID = ' + Inttostr(LineID) + ' and ifnull(ParentID,0)=0', True) Do
    Try REsult := Fieldbyname('ProctreeId').AsInteger;
    Finally
      If Active Then Close;
      Free;
    End;
End;

Procedure TSalesOrder.CalcOrderTotals;
Begin
  Inherited;
End;
function TSalesOrder.convertedtoInvoicecID: Integer;
Begin
  With GetNewdataset('Select SaleID from tblsales where Deleted ="F" and ifnull(SAlesOrderGlobalref , "") = ' + Quotedstr(Globalref)) Do
    Try
      REsult := Fieldbyname('SaleID').AsInteger
    Finally
      If Active Then Close;
      Free;
    End;
End;

Function TSalesOrder.ConvertedtoInvoiceCount: Integer;
Begin
  With GetNewdataset('Select count(SaleID) ctr from tblsales where Deleted ="F" and ifnull(SAlesOrderGlobalref , "") = ' + Quotedstr(Globalref)) Do
    Try REsult := Fieldbyname('ctr').AsInteger
    Finally
      If Active Then Close;
      Free;
    End;
End;

(* function TSalesOrder.getconvertedtoInvoice: TInvoice;
  begin
  Result := TInvoice(getcontainercomponent(TInvoice , 'SalesOrderglobalref = ' + Quotedstr(Globalref) ));
  end; *)

Function TSalesOrder.GetFutureSO: Boolean;
Begin
  Result := GetBooleanfield('FutureSO');
End;

Procedure TSalesOrder.SetFutureSO(Const Value: Boolean);
Begin
  SetBooleanField('FutureSO', Value);
End;

Function TSalesOrder.GetPrePayments: TDataset;
Var
  S: String;
Begin
  S := 'Select PP.* ' + ' from tblSalesPrepayments  SP' + ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  ' + ' Where PP.Deleted = "F" and SP.SalesRef= ' + Quotedstr(Self.Globalref);
  If Not(Assigned(FPrePayments)) Or (TERPQuery(FPrePayments).SQL.Text <> S) Then Begin
    If Assigned(FPrePayments) And FPrePayments.Active Then FPrePayments.Close;
    FPrePayments := GetNewdataset(S, True);
  End;
  Result := FPrePayments;
End;

(*Function TSalesOrder.GetProgressBar: TProgressBar;
Begin
  If Not Assigned(FProgressBar) Then FProgressBar := TProgressBar.Create(Nil);
  Result                                          := FProgressBar;
End;*)

Function TSalesOrder.CopySalesOrderToSmartOrder: Integer;
Begin
  Result := CopyToSmartOrder;
  UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
End;

Class Function TSalesOrder.GetSOwithAllBOs(SOID: Integer): STring;
Begin
  If AppEnv.CompanyPrefs.CombinedSaleOrderBO Then Begin
    Result := 'Select tblSales.Globalref,tblsales.QuoteStatus, tblSales.SaleID, max(SL.shipped) as shipped' + ' from tblSales ' + ' inner join tblSalesLines SL on tblSales.SaleId = SL.SaleId' +
      ' Where tblSales.SaleId = ' + IntToStr(SOID) + ' group by tblSales.saleID'
  End
  Else Result := 'Select SubSO.Globalref, SubSO.QuoteStatus, SubSO.saleID, max(SL.shipped) as shipped' +
      ' from tblSales MasterSO inner join tblSales SubSO on MasterSO.OriginalNo = SubSO.OriginalNo and SubSO.Deleted <> "T" ' + ' inner join tblSalesLines SL on SubSO.SaleId = SL.SaleId' +
      ' Where MasterSO.SaleId = ' + IntToStr(SOID) + ' group by SubSO.saleID';
End;

Function TSalesOrder.CopySalesorderToSalesorder: Integer;
Begin
  Result              := 0;
  CopyingToSalesorder := True;
  Try
    FieldsnotToclone := QuotedStr('IsPaid') + ',' + QuotedStr('TotalBalance') + ',' + QuotedStr('TotalPaid') + ',' + QuotedStr('ForeignPaidAmount') + ',' + QuotedStr('ForeignBalanceAmount') + ',' +
      QuotedStr('BOID') + ',' + QuotedStr('Originalno') + ',' + QuotedStr('baseno') + ',' + QuotedStr('DueDate');
    If Self.CloneBusObj('SaleDate', DateOf(Now), False, 'SaleID') <> Nil Then Begin
      If CopyingToSalesOrder = False Then Lines.Iteraterecords(ReActivatePQAs);
      TSalesOrder(ObjInstanceToClone).Converted      := False;
      TSalesOrder(ObjInstanceToClone).UsedOnManifest := False;
      TSalesOrder(ObjInstanceToClone).AddToManifest  := False;
      TSalesOrder(ObjInstanceToClone).IsManifest     := False;
      TSalesOrder(ObjInstanceToClone).RepairID       := 0;
      TSalesOrder(ObjInstanceToClone).Quoteglobalref := '';
      TSalesOrder(ObjInstanceToClone).Deleted        := False;
      TSalesOrder(ObjInstanceToClone).PostDb;
      Try
        If Not TSalesOrder(ObjInstanceToClone).Save Then Begin
          If Not Self.SilentMode Then BusobjMessageDlg('Failed to save new Sales Order:' + #13#10 + ObjInstanceToClone.ResultStatus.Messages, MtWarning, [MbOk], 0);
          Exit;
        End;

        { IJB - Copy Shipment List .. if there is one }
        { only copy is nothing processed }
        If (Self.ShipmentList.Count > 0) And (Self.ShipmentList.Status = 'Not Processed') Then Begin
                  try
                    Self.ShipmentList.Copy(Self, TSalesOrder(ObjInstanceToClone));
                  Except
                    on E:Exception do begin
                      ResultStatus.AddItem(False, RssWarning, 0, 'Copy of Shipment failed. ' + E.message);
                    end;
                  end;

        End;

      Except
        On E: Exception Do Begin
          If Not Self.SilentMode Then BusobjMessageDlg('Failed to save new Sales Order:' + #13#10 + E.Message, MtWarning, [MbOk], 0);
          Exit;
        End;
      End;
      SendEvent(BusobjEvent_ToDo, BusobjProcessPQADetailClasses, TSalesOrder(ObjInstanceToClone));
      Result := TSalesOrder(ObjInstanceToClone).ID;
      UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
      Self.ShipmentList.UserLock.UnlockAllCurrentInstance;
      TSalesOrder(ObjInstanceToClone).UserLock.UnlockAllCurrentInstance;
    End;
  Finally CopyingToSalesorder := False;
  End;
End;

Procedure TSales.ReActivatePQAs(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TSalesLine) Then Exit;
  If TSalesLine(SendeR).IsPQAItem Then Begin
    TSalesLine(Sender).PQA.Active := TSalesLine(Sender).PQA.CleanActive;
    TSalesLine(Sender).PQA.PostDB;
    TSalesLine(Sender).PQA.ExecuteSQL('update ' + TSalesLine(Sender).PQA.PQAdetailtablename + ' Set Active = ' + Quotedstr(BooleantoStr(TSalesLine(Sender).PQA.Active)) + ' where PQAID = ' +
      IntToStr(TSalesLine(Sender).PQA.ID) + ';', True);
  End;
End;

Procedure TSales.UpdatePQA;
Begin
  FbAnyLineShipped := Lines.AnyLineShipped;
  Lines.Iteraterecords(UpdatePQACallback);
  FbAnyLineShipped := False;
End;

Procedure TSales.UpdatePQACallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TInvoiceline) Then Exit;
  If TInvoiceline(Sender).ISPQAItem Then Begin
    If (TInvoiceline(Sender).QtyShipped = 0) And (FbAnyLineShipped) Then TInvoiceline(Sender).PQA.Active := False;
    TInvoiceline(Sender).PQA.PostDB;
  End;
End;
Function TSalesOrder.CopyPickAssemblies(const SOIDs:String ) :Boolean;
var
  PickAssemEntry:TPickAssemEntry;
begin
  result := False;
  if SOIDs = '' then begin
    Result := true;
    Exit;
  end;
    PickAssemEntry:= TPickAssemEntry.Create(Self);
    try
      PickAssemEntry.Connection := Self.Connection;
      PickAssemEntry.LoadSelect('saleID in (' + SOIDs +')');
      if PickAssemEntry.count =0 then begin
        Result := true;
        Exit;
      end;
      PickAssemEntry.First;
      While PickAssemEntry.Eof = False do begin
        if not PickAssemEntry.CopySOPickingToInvoice then begin
          ResultStatus.AddItem(False, RssWarning, 0, 'Failed to copy the Picking assembly to the invoice');
          Exit;
        end;
        PickAssemEntry.Next;
      end;
      Result := True;
    finally
      FreeandNil(PickAssemEntry);
    end;
        //TPickAssemEntry.ClonePropertyObjects
end;
Procedure TSalesOrder.CheckDefaultQtyShippedCallback(Const Sender: TBusObj; Var Abort: Boolean);
begin
  if not(Sender is TSalesLine) then exit;
  if TSalesLine(Sender).QtyShipped > 0 then begin
    TSalesLine(Sender).SetDefaultQtyShipped;
    TSalesLine(Sender).PostDb;
  end;
end;
(*procedure TSalesOrder.CheckForPPGMismatch;
begin
  with TPPGFix.Create(self, TERPConnection(connection.connection)) do try
    FixProcProgressDuplicates(ID);
    FixPPG(ID);
    MakeJournals(ID);
  finally
    Free;
  end;
end;*)

procedure TSalesOrder.CloneLines(const Sender: TBusObj; var Abort: Boolean);
begin
  if (sender is TSalesOrderLine) and (CopyingToInvoice) and (IsInternalOrder) and (TSalesOrderLine(sender).IsTreeItem) then exit; // internal Orders should only copy non bom trees to invoice
  inherited;
  if (sender is TSalesOrderLine) and (CopyingToInvoice) and (IsInternalOrder) then begin
    TInvoice(ObjInstanceToClone).Lines.lineprice := 0;
    TInvoice(ObjInstanceToClone).Lines.linepriceinc := 0;
    TInvoice(ObjInstanceToClone).Lines.calclineTotals
  end;

end;

Function TSalesOrder.CopyToInvoice(SOID: Integer; IsCashSale: Boolean = False; aUserLock:TUserLock=nil; aLockGroupName:String=''): Integer;
Var
  StrSQL                     : String;
  SOrecordSet                : TERPQuery;
  StrWhere                   : String;
  SO                         : TSalesOrder;
  PreviousSaleId             : Integer;
  Previousglobalref          : String;
  StrOriginalNo              : String;
  InvoiceObj                 : TInvoice;
  CashSaleObj                : TCashSale;
  InvoiceObjOriginalDocnumber: String;
  UsingNestedTransaction     : Boolean;
  SeqNoList: TIntegerList;
Begin
  Result                 := 0;
  UsingNestedTransaction := False;
  StrSQL                 := GetSOwithAllBOs(SOID);
  (*SOrecordSet            := TERPQuery.Create(Nil);
  SOrecordSet.Connection := Self.Connection.Connection;*)
  SOrecordSet := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.Connection.Connection);
  try
      SOrecordSet.SQL.Text   := StrSQL;
      SOrecordSet.Open;
      PreviousSaleId    := 0;
      Previousglobalref := '';
      If SOrecordSet.RecordCount = 0 Then Exit;
      SOrecordSet.First;

      StrWhere := '';

      If (Appenv.Companyprefs.StatustoMakeInvoice <> '') Then
        While SOrecordSet.Eof = False Do Begin
          If Not(SameText(Appenv.Companyprefs.StatustoMakeInvoice, SOrecordSet.Fieldbyname('QuoteStatus').AsString)) Then Begin
            If StrWhere <> '' Then StrWhere := StrWhere + NL;
            StrWhere                        := StrWhere + '      ' + SOrecordSet.FieldByname('SaleID').AsString;
          End;
          SOrecordSet.Next;
        End;

      If StrWhere <> '' Then Begin
        SOrecordSet.Last;
        If (SameText(Appenv.Companyprefs.StatustoMakeInvoice, SOrecordSet.Fieldbyname('QuoteStatus').AsString)) Then Begin
          ResultStatus.AddItem(False, RssWarning, 0, 'Please Note that' + NL +'As per the preferences, the Sales Order can be Converted to Invoice Only When Status is ' + Quotedstr(Appenv.Companyprefs.StatustoMakeInvoice) +
            ' and is not in the following Sales order(s) in the group.' + NL + StrWhere + NL + NL + 'Since the Currect Order in the Group( # ' + inttostr(SOrecordSet.FieldByname('SaleID').asInteger)+') has ' + Quotedstr(Appenv.Companyprefs.StatustoMakeInvoice) +
            ', So the Whole Group will be converted.');
        End else begin
          ResultStatus.AddItem(False, RssWarning, 0, 'As per the preferences, the Sales Order can be Converted to Invoice Only When Status is ' + Quotedstr(Appenv.Companyprefs.StatustoMakeInvoice) +
            ' and is not in the following Sales order(s) in the group.' + NL + StrWhere + NL + NL + 'Please change the status to ' + Quotedstr(Appenv.Companyprefs.StatustoMakeInvoice) +
            ' to be able to invoice.');
          Result := 0;
          Exit;
        end;
      End;

      StrWhere := '';
      SOrecordSet.First;
      While SOrecordSet.Eof = False Do Begin
        If StrWhere <> '' Then StrWhere := StrWhere + ',';
        StrWhere                        := StrWhere + SOrecordSet.FieldByname('SaleID').AsString;
        SOrecordSet.Next;
      End;
      SOrecordSet.First;
      Try
        SO := TSalesOrder.Create(Nil);
        if aUserLock <> nil then So.userlock := aUserLock;
        if aLockGroupName <> '' then So.LockGroupName := aLockGroupName
        else SO.LockGroupname  := 'ConvertingSOToInvoice' + IntToStr(Integer(SO));
        If Assigned(DoProductallocation) Then SO.DoProductallocation := DoProductallocation;
        SO.UserLock.IgnoreClassnameinLock                            := True;
        SO.Connection                                                := Self.Connection;
        If SO.Connection.InTransaction Then Begin
          UsingNestedTransaction := True;
          SO.Connection.BeginNestedTransaction;
        End
        Else SO.Connection.BeginTransaction;

        InvoiceObjOriginalDocnumber := '';
        While SOrecordSet.Eof = False Do Begin

          SO.BusObjEvent := Nil;
          SO.Load(SORecordSet.FieldByname('SaleId').AsInteger);
          SO.BusObjEvent := Self.BusObjEvent;

          If SORecordSet.FieldByname('SaleId').AsInteger = Self.ID Then Show_status('Converting SO to invoice.')
          Else Show_status('Converting Sales order''s Back orders to invoice - ' + IntToStr(SOrecordSet.Recno - 1) + ' of ' + IntToStr(SOrecordSet.Recordcount - 1) + '.');
          If SO.LockSOnSOInvoices Then Begin

            SO.ConvertingSO := True;
            If (Not(IsCashSale)) Or (SORecordSet.FieldByname('shipped').AsFloat = 0) Then Begin
              SO.CopyingToInvoice := True;
              Try
                Progressbarmsg := 'Converting SO to Invoice';
                If SO.CloneBusObj('SaleDate', DateOf(Now), False, 'SaleID') = Nil Then Begin
                  Result := 0;
                  Exit;
                End;

                InvoiceObj := TInvoice(SO.ObjInstanceToClone);
                InvoiceObj.Converted := False;
                if SO.isinternalOrder then begin
                  InvoiceObj.IsInternalOrder := True;
                  InvoiceObj.comments := Trim('Materials Sold for Internal Order # ' + inttostr(SO.ID)+NL+
                                          InvoiceObj.comments);
                  InvoiceObj.Postdb;
                end;

                if Appenv.Companyprefs.SoToInvShipWhenAvailable then
                  if  (SOrecordSet.recordcount =1) then
                    InvoiceObj.Lines.Iteraterecords(CheckDefaultQtyShippedCallback);

                { IJB - Copy Shipment List .. if there is one }
                { only copy is nothing processed }
                If (Self.ShipmentList.Count > 0) And (Self.ShipmentList.Status = 'Not Processed') Then Begin
                  try
                      SO.ShipmentList.Copy(SO, InvoiceObj);
                  Except
                    on E:Exception do begin
                      ResultStatus.AddItem(False, RssWarning, 0, 'Copy of Shipment failed. ' + E.message);
                    end;
                  end;
                End;

                SO.AddProgresspayments(InvoiceObj);
                //SO.CheckForPPGMismatch;

                If StrOriginalNo = '' Then StrOriginalNo := InvoiceObj.GlobalREf;
                If PreviousSaleId <> 0 Then SO.ObjInstanceToClone.GetNewDataSet('update tblSales set BOID = ' + QuotedStr(InvoiceObj.Globalref) + ' where SaleId = ' + IntToStr(PreviousSaleId), True);
                InvoiceObj.SalesOrderGlobalRef := SO.Globalref; // SOGlobalRef;
                InvoiceObj.RepairGlobalref     := So.RepairGlobalref; // if repair's Salesorder is converted the invoice should also be linked to the sales order
                InvoiceObj.IsSalesOrder        := False;
                InvoiceObj.IsInvoice           := True;
                InvoiceObj.BaseNo              := Previousglobalref;
                InvoiceObj.OriginalDocNumber   := StrOriginalNo;
                If AppEnv.CompanyPrefs.UseBarcodePicking And Not(AppEnv.CompanyPrefs.BarcodePickingInSOMode) Then Begin
                  InvoiceObj.IsBarcodePicking := True;
                End;
                If InvoiceObj.ShipDate < InvoiceObj.SaleDate Then InvoiceObj.ShipDate := InvoiceObj.SaleDate;
                (* if AppEnv.CompanyPrefs.UseShippedDateForTerms then // to change DueDate
                  InvoiceObj.SetPaymentTerms(InvoiceObj.ShipDate)
                  else
                  InvoiceObj.SetPaymentTerms(InvoiceObj.SaleDate); *)
                InvoiceObj.InitPaymentTerms;
                InvoiceObj.PostDB;
                InvoiceObj.UpdatePQA;
                If HasAnyshippednInvoiced Then InvoiceObj.Comments := 'Final Invoice for Sales Order # ' + Quotedstr(Globalref) + '.' + NL + InvoiceObj.Comments;
                if not InvoiceObj.Save then begin
                  Self.ResultStatus.AddItems(InvoiceObj.ResultStatus);
                  result := 0;
                  exit;
                end;
                SendEvent(BusobjEvent_ToDo, BusobjProcessPQADetailClasses, InvoiceObj);
                If Not SO.PostList.Execute Then Begin
                  Result := 0;
                  Exit;
                End;
                If Appenv.CompanyPrefs.ApplyPrepaymentsOnSOConversion Then
                  ApplyPrepayment(InvoiceObj);
                PreviousSaleId              := InvoiceObj.ID;
                Previousglobalref           := InvoiceObj.GlobalRef;
                InvoiceObjOriginalDocnumber := InvoiceObj.OriginalDocNumber;
                If SO.Id = SOID Then Result := InvoiceObj.ID;
                If (Not(SO.Cleanconverted)) Then SO.UpdateUninvoicedSObalance(SO.IsInternalOrder);
              Finally
                SO.CopyingToInvoice := False;
                Freeandnil(InvoiceObj);
              End;
            End
            Else If ISCashSale Then Begin
              SO.CopyingToCashSale := True;
              Try
                SO.ConvertingSO := True;
                If SO.CloneBusObj('SaleDate', DateOf(Now), False, 'SaleID') = Nil Then Begin
                  Result := 0;
                  Exit;
                End;
                CashSaleObj           := TCashSale(SO.ObjInstanceToClone);

                if Assigned(fLineIdsToconvert) and (fLineIdsToconvert.Count > 0) then begin
                  { user ony wants to copy accross some lines ..  }
                  SeqNoList := TIntegerList.Create;
                  try
                    SO.Lines.First;
                    while not SO.Lines.EOF do begin
                      if fLineIdsToconvert.InList(SO.Lines.ID) then
                        SeqNoList.Add(SO.Lines.SeqNo);
                      SO.Lines.Next;
                    end;

                    CashSaleObj.Lines.First;
                    while not CashSaleObj.Lines.EOF do begin
                      if SeqNoList.InList(CashSaleObj.Lines.SeqNo) then
                        CashSaleObj.Lines.Next
                      else
                        CashSaleObj.Lines.Delete;
                    end;

                    CashSaleObj.CalcOrderTotals;

                  finally
                    SeqNoList.Free;
                  end;
                end;

                CashSaleObj.Globalref := '';
                CashSaleObj.PostDB; // force to generate the globalref as the new record should have a diiferent globalref
                CashSaleObj.SalesOrderGlobalRef := SO.Globalref;
                CashSaleObj.IsSalesOrder        := False;
                CashSaleObj.ISCashSale          := True;
                CashSaleObj.BaseNo              := '';
                CashSaleObj.OriginalDocNumber   := CashSaleObj.Globalref;
                CashSaleObj.GLAccountName       := UNDEPOSITED_FUNDS;
                CashSaleObj.GLAccountID         := TcDatautils.GetAccountID(UNDEPOSITED_FUNDS);
                CashSaleObj.PostDB;
                CashSaleObj.ConvertingSO := True;
                CashSaleObj.PayMethod    := PAY_CASH;
                CashSaleObj.Save;
                If SO.Id = SOID Then Result := CashSaleObj.ID;
                If Not SO.PostList.Execute Then Begin
                  Result := 0;
                  Exit;
                End;
                If (Not(Cleanconverted)) Then SO.UpdateUninvoicedSObalance(IsInternalOrder);
              Finally SO.CopyingToCashSale := False;
              End;
            End;
          End Else Begin
            Result := 0;
            ResultStatus.AddItem(False, RssWarning, 0, ReplaceStr(SO.UserLock.LockMessage, 'Unable to update data.', 'Unable to Invoice Sales Order #' + Inttostr(SO.Id) + '.'));
          End;
          SOrecordSet.Next;
        End;
        if result>0 then
          if not CopyPickAssemblies(strWhere) then
            REsult := 0;
      Finally
        If Result > 0 Then Begin
          (* if SO = Self then begin
            Converted := True;
            PostDB;
            end else begin *)
          If StrWhere <> '' Then SO.GetNewDataset('UPDATE tblSales SET Converted = "T" WHERE (SaleID IN (' + StrWhere + ')) AND (SOBalance <= 0)', True);
          If InvoiceObjOriginalDocnumber <> '' Then UpdateBaselineNo(InvoiceObjOriginalDocnumber);
          (* end; *)

          If UsingNestedTransaction Then SO.Connection.CommitNestedTransaction
          Else SO.Connection.CommitTransaction;
        End Else begin
          If UsingNestedTransaction Then SO.Connection.RollbackNestedTransaction Else SO.Connection.RollbackTransaction;
        end;



        UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
        SO.UserLock.UnlockAllCurrentInstance;
        SO.UserLock.Unlock(SO.LockGroupname);
        Try
          (* if SO<> self then *)
            FreeandNil(SO);
        Except
          // kill the exception
        End;
      End;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(SOrecordSet);
  end;

End;

Function TSalesOrder.HasAnyshippednInvoiced: Boolean;
Var
  StrSQL: String;
Begin
  StrSQL := 'Select * from tblsalesorderinvoices SOI where SOI.SalesOrderID =  ' + IntToStr(ID);
  With GetNewDataSet(StrSQL, True) Do
    Try Result := Recordcount > 0;
    Finally
      If Active Then Close;
      Free;
    End;
End;

function TSalesOrder.HasPPG: Boolean;
  var
    qry: TERPQuery;
  begin
    Result := False;
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.Connection.Connection);
    try
      Qry.sql.text := 'Select count(SL.saleLineID) as ctr '+
                      ' from tblSaleslines SL  '+
                      ' inner join tblproctree Pt on SL.saleLineId = PT.masterId and PT.mastertype <> "mtProduct"  '+
                      ' inner join tblprocprogress PPG on PT.proctreEId = PPG.ProcTreeId  '+
                      ' Where SL.saleId in (' + inttostr(ID)+')';
      Qry.Open;
      result := Qry.fieldbyname('ctr').asInteger >0;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
end;

Procedure TSalesOrder.UpdateBaselineNo(Const OriginalNo: STring);
Var
  StrSQL, UpdateSQL: String;
  Ds               : TDataset;
Begin
  // strSQL:= 'update '+
  // ' tblSales InvBO ' +
  // ' inner join tblSaleslines InvLinesBO on InvLinesBO.SaleId = InvBO.SaleId '+
  // ' inner join tblSales Inv on InvBo.Originalno = Inv.globalref '+
  // ' inner join tblSaleslines InvLines on InvLines.SaleId = Inv.SaleId  '+
  // ' and invLines.Seqno = invlinesbo.Seqno and invlines.productID = invlinesbo.productID '+
  // ' set invlinesBo.Baselineno = invlines.SaleLineId '+
  // ' where invbo.originalno = '+ QuotedStr(OriginalNo) +
  // ' and invbo.globalref <> invbo.originalno';
  // getNewDataset(strSQL , True);
  StrSQL := 'select invlinesBo.SaleLineID as boid, invlines.SaleLineId as id ' + 'from tblSales InvBO ' + 'inner join tblSaleslines InvLinesBO on InvLinesBO.SaleId = InvBO.SaleId ' +
    'inner join tblSales Inv on InvBo.Originalno = Inv.globalref ' + 'inner join tblSaleslines InvLines on InvLines.SaleId = Inv.SaleId ' +
    'and invLines.Seqno = invlinesbo.Seqno and invlines.productID = invlinesbo.productID ' + 'and IfNull(invlinesBo.Baselineno,0) <> invlines.SaleLineId ' + 'where invbo.originalno = ' +
    QuotedStr(OriginalNo) + ' ' + 'and invbo.globalref <> invbo.originalno';
  Ds := GetNewDataset(StrSQL, True);
  Try
    While Not Ds.EOF Do Begin
      UpdateSQL := 'update tblsaleslines set baselineno = ' + Ds.FieldByName('id').AsString + ' where salelineid = ' + Ds.FieldByName('boid').AsString;
      GetNewDataset(UpdateSQL, True);
      Ds.Next;
    End;
  Finally Ds.Free;
  End;
End;

(* procedure TSalesOrder.SetIsInternalOrder(const Value: boolean);
  begin
  SetBooleanField('IsInternalOrder', Value);
  end; *)

(* function TSalesOrder.GetIsInternalOrder: boolean;
  begin
  Result:= GetBooleanField('IsInternalOrder');
  end; *)

procedure TSalesOrder.BOLinesInit(BackOrder: TTransBase);
begin
  inherited;
  { TODO : Walmart - Backorders }
  //DoContainerEvent(TSalesOrderLine(TSalesOrder(BackOrder).Lines), evSalesBOLineSave );
end;

Procedure TSalesOrder.BusObjCopy(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Sender Is TRepairs Then TRepairs(Sender).SilentMode := True;
  Inherited;
End;



// ------------------------------------------------------------------------------
{ TSaleList }
// ------------------------------------------------------------------------------

Constructor TSaleList.Create(AOwner: TComponent);
Begin
  Inherited Create(AOwner);
  FSQL                      := 'SELECT * FROM tblSales';
  FBusObjectTypeDescription := 'Sale List Object';
End;

Destructor TSaleList.Destroy;
Begin

  Inherited;
End;

Procedure TSaleList.DoFieldOnChange(Sender: TField);
Begin
  Inherited;

End;

Function TSaleList.GetCustPONumber: String;
Begin
  Result := GetStringField('PONumber');
End;

Function TSaleList.GetId: Integer;
Begin
  Result := GetIntegerField('SaleId');
End;

Function TSaleList.GetIsCashSale: Boolean;
Begin
  Result := GetBooleanField('IsCashSale');
End;

Function TSaleList.GetIsInvoice: Boolean;
Begin
  Result := GetBooleanField('IsInvoice');
End;

Function TSaleList.GetIsQuote: Boolean;
Begin
  Result := GetBooleanField('IsQuote');
End;

Function TSaleList.GetIsRefund: Boolean;
Begin
  Result := GetBooleanField('IsRefund');
End;

Function TSaleList.GetIsSalesOrder: Boolean;
Begin
  Result := GetBooleanField('IsSalesOrder');
End;

Function TSaleList.GetSaleTypeDesc: String;
Begin
  If IsQuote Then Result           := 'Quote'
  Else If IsInvoice Then Result    := 'Invoice'
  Else If IsSalesOrder Then Result := 'Sales Order'
  Else If IsRefund Then Result     := 'Refund'
  Else If IsCashSale Then Result   := 'CaseSale'
  Else Result                      := '';
End;

Procedure TSaleList.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
Begin
  Inherited;

End;

// ------------------------------------------------------------------------------
Procedure TInvoiceLine.SetDefaultQtyShipped;
Begin
  LogD('TInvoiceLine.SetDefaultQtyShipped', LbBegin);
  Try
    Inherited;
    If UOMQtyShipped <> 0 Then Begin
      { if incoice date is already assigned, it shouldn;t be reinitialised }
      // if TInvoice(Self.Owner).SaleDate <> Date then begin
      If (TInvoice(Self.Owner).SaleDate <> Date) And (TInvoice(Self.Owner).SaleDate = 0) Then Begin
        TInvoice(Self.Owner).SaleDate     := Date;
        TInvoice(Self.Owner).ShipDate     := Date;
        TInvoice(Self.Owner).Saledatetime := Now;
      End;
    End;
  Finally LogD('', LbEnd);
  End;
End;

Class Function TSalesLine.GetIDField: String;
Begin
  Result := 'SaleLineId';
End;

Function TSalesLine.Getmanifestline: Tmanifestlines;
Begin
  If Self Is TInvoiceline Then Result := Tmanifestlines(Getcontainercomponent(Tmanifestlines, 'InvoiceLineID = ' + Inttostr(Id)))
  Else Result                         := Tmanifestlines(Getcontainercomponent(Tmanifestlines, 'SaleLineID = ' + Inttostr(Id)));
End;

function TSalesLine.getpackweightField1: Double;
begin
  REsult := Getfloatfield('packweightField1');
end;
function TSalesLine.getpackweightField2: Double;
begin
  REsult := Getfloatfield('packweightField2');
end;

Class Function TSalesLine.GetBusObjectTablename: String;
Begin
  Result := 'tblSalesLines';
End;

Class Function TInvoice.GetBusObjectTablename: String;
Begin
  Result := 'tblSales';
End;

Class Function TInvoice.GetIDField: String;
Begin
  Result := 'SaleID';
End;

Class Function TQuoteBase.GetBusObjectTablename: String;
Begin
  Result := 'tblSales';
End;

Class Function TQuoteBase.GetIDField: String;
Begin
  Result := 'SaleID';
End;

Class Function TSalesOrder.GetBusObjectTablename: String;
Begin
  Result := 'tblSales';
End;

Class Function TSalesOrder.GetIDField: String;
Begin
  Result := 'SaleID';
End;

Class Function TSaleList.GetBusObjectTablename: String;
Begin
  Result := 'tblSales';
End;

Class Function TSaleList.GetIDField: String;
Begin
  Result := 'SaleID';
End;

Procedure TInvoice.SetIsNew(Const Value: Boolean);
Begin
  Inherited;
  If Value Then IsPaid := False;
End;

procedure TInvoice.SetProgressPaymentInvoices(const Value: String);
const
  sPP = 'Progress Payment Invoices:';
begin
  if Pos(sPP + Value , Comments )=0 then
    Comments := TRim(Comments + NL+ sPP + Value);
end;

Function TInvoice.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
Begin
  Result := Inherited DoAfterInsert(Sender);
  If Not Result Then Exit;
  If AppEnv.CompanyPrefs.UseBarcodePicking And Not(AppEnv.CompanyPrefs.BarcodePickingInSOMode) Then Begin
    IsBarcodePicking := True;
  End;
  If AppEnv.CompanyPrefs.UPSConfig.UPSEnabled Then Begin
    Self.Shipping := AppEnv.CompanyPrefs.UPSConfig.DefaultService;
  End;
End;

Function TSalesOrder.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
Begin
  Result := Inherited DoAfterInsert(Sender);
  If Not Result Then Exit;
  If AppEnv.CompanyPrefs.UseBarcodePicking And AppEnv.CompanyPrefs.BarcodePickingInSOMode Then Begin
    IsBarcodePicking := True;
  End;
  If AppEnv.CompanyPrefs.UPSConfig.UPSEnabled Then Begin
    Self.Shipping := AppEnv.CompanyPrefs.UPSConfig.DefaultService;
  End;
End;

Procedure TSalesOrder.DoconvertInternalOrderCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  stepProgress;
  If Not(Sender Is TSalesorderline) Then Exit;
  If Not IsInternalOrder Then Exit;
  If Not TSalesorderline(Sender).IsTreeItem then exit; // non tree items are copied into an invoice
  TSalesorderline(Sender).PQA.Active := False;
  TSalesorderline(Sender).PQA.PostDB;
  TSalesorderline(Sender).DeleteSalesOrderInvoiceLinesPQAnAllocations;
  If TSalesorderline(Sender).Product.Batch Then TSalesorderline(Sender).PQA.PQABatch.InactivateAll
  Else If TSalesorderline(Sender).Product.MultipleBins Then TSalesorderline(Sender).PQA.PQABins.InactivateAll
  Else If TSalesorderline(Sender).Product.SnTracking Then TSalesorderline(Sender).PQA.PQASN.InactivateAll;
End;

Procedure TSalesOrder.DoconvertInternalOrder;
Begin
  If IsInternalOrder Then Begin
    Converted := True;
    PostDb;
    Lines.IterateRecords(DoconvertInternalOrderCallback);
  End;
End;

Function TSalesOrder.GetBackOrderMainSOId: Integer;
Begin
  If OriginalDocNumber <> '' Then Result := Self.IDToggle(OriginalDocNumber)
  Else Result                            := ID;
End;

Function TSalesOrder.IsBO: Boolean;
Begin
  Result := Not(Globalref = OriginalDocNumber);
  // Need A Better IsNumeric function without Exception
  If IsNumeric(OriginalDocNumber) Then Result := Not(IntToStr(Trunc(StrValue(Globalref))) = OriginalDocNumber);
End;

Function TSalesOrderLine.GetIsPQAItem: Boolean;
Begin
  Result := Inherited GetIsPQAItem;
  If Result Then
    If Convertingquote Then
      If TSalesOrder(Self.Owner).Dataset.FieldByname('ISQuote').AsString = 'T' Then Result := False;
  If Result Then
    If BOMGroupedLine Then Result := False;
End;

function TSalesOrderLine.getManPQA: TManPQA;
begin
  if ID = 0 then PostnEditDB;
  Result := TManPQA(getContainerComponent(TManPQA, 'TRansLineID = ' + inttostr(RootProcTreePartID) + ' and ifnull(TransType,"") = ' + Quotedstr('TProcTreePart')+' and Alloctype ="IN"' ));
end;

function TSalesOrderLine.getOriginalSalesDocNumber: String;
begin
  Result := '';
  if Assigned(Owner) and (Owner is TSalesOrder) then begin
    result := TSalesorder(Owner).OriginalDocNumber;
    exit;
  end;
  Result := tcdatautils.OriginalSalesDocNumber(SaleID);
end;

function TSalesOrderLine.getproctree: Tproctree;
begin
  Result := Tproctree(Getcontainercomponent(Tproctree, 'MasterId = ' + IntToStr(ID)+' and MasterType <> ' + Quotedstr('mtProduct'), True, True));
end;

Function TInvoiceLine.GetIsPQAItem: Boolean;
Begin
  Result := Inherited GetIsPQAItem;
  If Result Then
    If Convertingquote Then
      If TInvoice(Self.Owner).Dataset.FieldByname('ISQuote').AsString = 'T' Then Result := False;
  If Result Then
    If BOMGroupedLine Then Result := False;
End;

Function TInvoiceLine.IsProgressPayment: Boolean;
Begin
  Result := False;
  If Not(Sametext(ProductName, PART_SOPROGRESSPAYMENT)) Then Exit;
  If ProgresspaymentRef <> '' Then Begin
    Result := True;
    Exit;
  End;
  If Assigned(Self.Owner) And (Self.Owner Is TInvoice) Then
    If TInvoice(Self.Owner).SOProgressPaymentGlobalRef <> '' Then Begin
      Result := True;
      Exit;
    End;
End;

Function TSalesLine.GetcopytoCashSale: Boolean;
Begin
  Result := False;
  If Assigned(Self.Owner) Then
    If Self.Owner Is TsalesOrder Then Result := TSalesOrder(Self.Owner).CopyingToCashSale;
End;

Function TSalesLine.GetcopytoInvoice: Boolean;
Begin
  Result := False;
  If Assigned(Self.Owner) Then
    If Self.Owner Is TsalesOrder Then Result   := TSalesOrder(Self.Owner).CopyingToInvoice
    Else If Self.Owner Is TInvoice Then Result := TInvoice(Self.Owner).CopyingToInvoice;

End;

Function TSalesLine.GetcopytoQuote: Boolean;
Begin
  Result := False;
  If Assigned(Self.Owner) Then
    If Self.Owner Is TsalesOrder Then Result := TSalesOrder(Self.Owner).CopyingToQuote;
End;

Function TSalesLine.GetcopytoSalesOrder: Boolean;
Begin
  Result := False;
  If Assigned(Self.Owner) Then
    If Self.Owner Is TsalesOrder Then Result := TSalesOrder(Self.Owner).CopyingToSalesOrder;
End;

Function TSalesOrderLine.GetEnableAllocation: Boolean;
Begin
  Result                := Inherited GetEnableAllocation;
  If Result Then Result := AppEnv.CompanyPrefs.BarcodePickingInSOMode;
End;

Function TQuoteBase.HasbinBatchProductSrProduct: Boolean;
Var
  S: String;
Begin
  S := 'select count(tblSalesLines.ProductID) as  binbatchsrrecords ' + ' from tblSales inner join tblSalesLines using (SaleId) ' +
    ' inner join tblParts  on tblParts.PartsId = tblsalesLines.ProductID ' + ' where (tblSales.saleId = ' + IntToStr(ID) + '	) ' + ' and ((ifnull(tblParts.batch,"") = "T")  ' +
    ' or (ifnull(tblParts.multiplebins, "")  = "T")  ' + ' or  (ifnull(tblParts.SNTracking , "") = "T"))';
  With GetNewDataset(S, True) Do
    Try REsult := (Recordcount > 0) And (FieldByname('binbatchsrrecords').AsInteger > 0);
    Finally
      If Active Then Close;
      Free;
    End;
End;

Function TSalesLine.CloneBusObj(Const Changefield: String; Const ChangeValue: Variant; Const SaveAfterCopy: Boolean; Const FilterFields: String): TBusObj;
Begin
  LogD('TSalesLine.CloneBusObj', LbBegin);
  Try Result := Inherited CloneBusObj(ChangeField, ChangeValue, SaveAfterCopy, FilterFields);
  Finally LogD('', LbEnd);
  End;
End;

Procedure TSalesLine.ClonePropertyObjects;
Begin
  Inherited;
  If Not(Assigned(Objinstancetoclone)) Or Not(Assigned(Objinstancetoclone.Owner)) Or Not(Objinstancetoclone Is TSalesline) Or Not(Objinstancetoclone.Owner Is TSales) Then Exit;

End;

Function TSales.BackorderforProductInGroup(Const FProductID: Integer): Integer;
Var
  S: String;
Begin
  S := 'SELECT SL.* ' + ' FROM tblsales S ' + ' INNER JOIN tblsaleslines SL ON S.saleId = SL.saleID ' +
    ' where ifnull(S.BOID,"")="" and ifnull(S.Originalno , "") = (Select Originalno from tblsales where saleId= ' + Inttostr(ID) + ') ' +
    ' and ifnull(SL.shipped,0)=0 and ifnull(SL.BackOrder,0)<>0 and ifnull(SL.productID,0) = ' + Inttostr(FProductID) + '';
  With Getnewdataset(S, True) Do
    Try Result := Fieldbyname('SaleID').AsInteger;
    Finally
      If Active Then Close;
      Free;
    End;
End;

Procedure TSales.BOLinesInit(BackOrder: TTransBase);
Begin
  Inherited;
  TSalesLine(Tsales(BackOrder).Lines).BOMgroupedLine    := False;
  TSalesLine(Tsales(BackOrder).Lines).BOMProductionline := False;
End;


Procedure TSales.BusObjCopy(Const Sender: TBusObj; Var Abort: Boolean);
Var
  SaleLine : TSalesLine;
  OrderLine: TSmartOrderLine;
Begin


  If (Not Abort) And (Sender Is TSalesLine) And (Sender.ObjInstanceToClone Is TSmartOrderLine) Then  begin
    If (TSalesLine(Sender).Producttype = 'OTHER') or (TSalesLine(Sender).ExcludeFromSmartOrder)  Then Exit;
    if (fLineIdsToconvert.count >0) and (fLineIdsToconvert.indexof( TSalesLine(Sender).ID )<0) then exit;
    if (Self is TSalesOrder) and  (lines.isTreeItem) then Exit;
  end;

  Inherited;
  Try
    If (Not Abort) And (Sender Is TSalesLine) And (Sender.ObjInstanceToClone Is TSmartOrderLine) Then Begin
      SaleLine  := TSalesLine(Sender);
      if not SaleLine.ExcludeFromSmartOrder  then
      begin
        OrderLine := TSmartOrderLine(Sender.ObjInstanceToClone);
        OrderLine.ToPurchaseQtyexWastagePercentage:= OrderLine.ToPurchaseQty;
        OrderLine.CusJobID                                          := Saleline.Header.CustomerId;
        OrderLine.CusJobName                                        := Saleline.Header.CustomerName;
        OrderLine.CustPONumber                                      := Saleline.Header.CustPONumber;
        If OrderLine.CustPONumber <> '' Then OrderLine.CustPONumber := OrderLine.CustPONumber + '-';
        OrderLine.CustPONumber                                      := OrderLine.CustPONumber + Saleline.Header.DocNumber;
        OrderLine.GeneralNotes := SaleLine.Product.GeneralNotes;

        if Appenv.CompanyPrefs.ShowPurchasecostinSales then
          if saleline.purchasecost <> 0 then
            OrderLine.CostEx := saleline.purchasecost;

        OrderLine.PostDB;
      end;
    End
    Else If (Not Abort) And (Sender Is TSalesLine) And (Sender.ObjInstanceToClone Is TRepairParts) Then Begin
      TRepairParts(Sender.ObjInstanceToClone).SaleLineId := TSalesLine(SendeR).ID;
      TRepairParts(Sender.ObjInstanceToClone).PostDB;
    End;
  Except
    On E: Exception Do Begin
      Abort := True;
    End;
  End;
End;

Function TSalesLine.GetHeader: Tsales;
Begin
  Result := Nil;
  If Assigned(Self.Owner) Then
    If Self.Owner Is TSales Then REsult := TSales(Self.Owner);
End;


Function TSales.CheckBackOrders(Const BackOrder: TSales; Const IsCombinedBo: Boolean; Var CombinedTransRef: String): Boolean;
Begin
  Show_Status('Update Back Orders.');
  Result := True;
  If (Self.BackOrderGlobalRef = Self.GlobalRef) Or (Not Lines.AnyLineShipped) Or (Not Lines.AnyLineBackOrdered) Then Begin
    DeleteBackOrder(BackOrder);
    Lines.Iteraterecords(AfterBODeleteCallback);
    Exit; { already a back order so do nothing }
  End;

  If UpdatingBo Then Exit;
  BackOrder.SilentMode := True;
  BackOrder.Connection := Self.Connection;
  ReadBO(BackOrder, IsCombinedBo, CombinedTransRef);
  If BackOrder.Deleted Then BackOrder.Deleted     := False;
  If BackOrder.Cancelled Then BackOrder.Cancelled := False;
  UpdateBO(BackOrder);
End;

Function TSales.GeTEquipmentxRef: TBusobj;
Begin
  Result := TBusobj(Getcontainercomponent(TEquipmentxRef, 'SaleId = ' + IntToStr(ID)));
End;

Procedure TSales.CopyEquipments(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TEquipmentxRef) Then Exit;
  TEquipmentxRef(Sender).Repairid := TRepairs(RepairsObj).ID;
  TEquipmentxRef(Sender).PostDB;
End;

Procedure TQuoteBase.BusObjCopy(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Sender Is TRepairs Then TRepairs(Sender).SilentMode := True;
  Inherited;
End;

{ TQuote }
Function TQuote.GetSalesGroupRef: String;
Var
  S: String;
Begin
  S := 'select originalref from tblrelatedsales where transref =' + Quotedstr(Globalref);
  With GetNewDataset(S, True) Do
    Try Result := Fieldbyname('originalref').AsString;
    Finally
      If Active Then Close;
      Free;
    End;
End;

Function TQuote.MakeVariation(SaleLineIdfilter: String): Integer;
Var
  FsPreviousRef   : String;
  FsOriginalref   : String;
  FiOriginalSaleId: Integer;
  LastSeqno       : Integer;
  // fdTotalAmountinc:double;
  Fsfilter            : String;
  FdApprovedAmount    : Double;
  FdContributionAmount: Double;
Begin
  Fsfilter                                                := Lines.Dataset.Filter;
  If Lines.Dataset.Filter <> '' Then Lines.Dataset.Filter := '(' + Lines.Dataset.Filter + ' ) and (' + SaleLineIdfilter + ')'
  Else Lines.Dataset.Filter                               := SaleLineIdfilter;
  Lines.Dataset.Filtered                                  := TRue;
  Try
    REsult := CopyQuoteToQuote;
    If Result = 0 Then Exit;
  Finally
    Lines.Dataset.Filter   := Fsfilter;
    Lines.Dataset.Filtered := Lines.Dataset.Filter <> '';
  End;
  CalcOrderTotals;
  // fdTotalAmountinc:= TotalAmountinc;
  If Relatedsale.Count = 0 Then Begin
    Relatedsale.New;
    Relatedsale.Originalref    := Globalref;
    Relatedsale.Seqno          := 1;
    Relatedsale.TransRef       := Globalref;
    Relatedsale.OriginalSaleId := ID;
    Relatedsale.ApprovedAmount := TotalAmountinc;
  End;

  Relatedsale.VariedOn := Date;
  Relatedsale.PostDB;
  FdApprovedAmount := Relatedsale.ApprovedAmount;
  LastSeqno        := Relatedsale.Seqno;
  FsPreviousRef    := Globalref;
  FsOriginalref    := Relatedsale.Originalref;
  FiOriginalSaleId := Relatedsale.OriginalSaleId;
  (* Load(result);
    Lines;
    Self.ContributionAmount := ContributionAmount + (fdTotalAmountinc-TotalAmountinc);
    PostDB;
    Relatedsale.New;
    Relatedsale.Originalref := Originalref;
    Relatedsale.OriginalSaleId:= OriginalSaleId;
    Relatedsale.PreviousRef :=fsPreviousRef;
    Relatedsale.TransRef :=  globalref;
    Relatedsale.Seqno:=lastSeqno+1;
    Relatedsale.PostDb;
    DocNumber:= inttostr(Relatedsale.OriginalSaleId) + '-' + inttostr(Relatedsale.Seqno);
    PostDB; *)
  With TQuote(ObjInstanceToClone) Do Begin
    Lines;
    FdContributionAmount := TotalAmountinc - FdApprovedAmount;
    ContributionAmount   := FdContributionAmount;
    PostDB;
    Relatedsale.New;
    Relatedsale.Originalref    := FsOriginalref;
    Relatedsale.OriginalSaleId := FiOriginalSaleId;
    Relatedsale.PreviousRef    := FsPreviousRef;
    Relatedsale.TransRef       := Globalref;
    Relatedsale.Seqno          := LastSeqno + 1;
    Relatedsale.ApprovedAmount := FdApprovedAmount;
    Relatedsale.PostDb;

    DocNumber := Inttostr(Relatedsale.OriginalSaleId) + '-' + Inttostr(Relatedsale.Seqno);
    PostDB;
    Save;
  End;
End;

Procedure TQuote.CalcOrderTotals;
Begin
  Inherited;
  If RelatedSales.Count > 0 Then Contributionamount := TotalAmountinc - RelatedSales.ApprovedAmount;
End;

Procedure TQuote.DoFieldOnChange(Sender: TField);
Begin
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.

  If (Sysutils.SameText(Sender.FieldName, 'QuoteStatus')) Then Begin
    If Not RawMode Then Begin
      If (SalesStatus <> CleanSalesStatus) And (SameText(SalesStatus, 'Approved')) Then
        If AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanApproveQuote') <> 1 Then Begin
          REsultStatus.AddItem(False, RssWarning, 0, AppEnv.Employee.Employeename + ' is not Allowed to Approve Quote');
          SalesStatus := CleanSalesStatus;
        End;

      If (SalesStatus <> CleanSalesStatus) And (SameText(SalesStatus, 'Delivered')) Then
        If AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanDeliverQuote') <> 1 Then Begin
          REsultStatus.AddItem(False, RssWarning, 0, AppEnv.Employee.Employeename + ' is not Allowed to Deliver Quote');
          SalesStatus := CleanSalesStatus;
        End;
    End;
  End;

  Inherited;

End;

Function TSales.GetCleanCustomerID: Integer;
Begin
  Result := GetXMLNodeIntegerValue(CleanXMLNode, 'CustomerID');
End;

Function TSales.GetcleanIsInternalOrder: Boolean;
Begin
  Result := GetXMLNodeBooleanValue(CleanXMLNode, 'IsInternalOrder');
End;

Function Tsales.GetCleanSalesStatus: String;
Begin
  Result := GetXMLNodeStringValue(CleanXMLNode, 'SalesStatus');
End;

function TSales.getcleanTotalAmountInc: Double;
begin
  Result := GetXMLNodeFloatValue(CleanXMLNode, 'TotalAmountInc');
end;

Function TQuote.GetPreviousRef: String;
Var
  S: String;
Begin
  S := 'select Previousref from tblrelatedsales where transref =' + Quotedstr(Globalref);
  With GetNewDataset(S, True) Do
    Try Result := Fieldbyname('Previousref').AsString;
    Finally
      If Active Then Close;
      Free;
    End;
End;

Function TQuote.GetPreviousSale: TRelatedSales;
Begin
  Result := TRelatedSales(GetContainerComponent(TRelatedSales, 'TransRef = ' + Quotedstr(PreviousRef) + ' and originalref = ' + Quotedstr(SalesGroupRef)));
End;

Function TQuote.GetQuoteVaried: Boolean;
Var
  S: String;
Begin
  S := 'select Previousref from tblrelatedsales where PreviousRef =' + Quotedstr(Globalref);
  With GetNewDataset(S, True) Do
    Try Result := Recordcount > 0;
    Finally
      If Active Then Close;
      Free;
    End;
End;

Function TQuote.GetTRelatedSale: TRelatedSales;
Begin
  Result := TRelatedSales(GetContainerComponent(TRelatedSales, 'TransRef = ' + Quotedstr(Globalref) + ' and originalref = ' + Quotedstr(SalesGroupRef)));
End;

Function TQuote.GetTRelatedSales: TRelatedSales;
Begin
  Result := TRelatedSales(GetContainerComponent(TRelatedSales, 'originalref = ' + Quotedstr(SalesGroupRef)));
End;

Function TQuote.LockTrans(Var ErrMsg: String): Boolean;
Var
  StrSQL     : String;
  FLockFailed: Boolean;
Begin
  Result := Inherited LockTrans(ErrMsg);
  If Not Result Then Exit;
  If QuoteVaried Then Begin
    ErrMsg := 'This is a Varied Quote, is Read-Only';
    Result := False;
    Exit;
  End;
  StrSQL := 'Select S.SaleID from tblrelatedsales RS inner join tblsales S on Rs.Transref = S.Globalref' + ' where RS.Originalref in (select Originalref from tblrelatedsales   ' + ' where transref = '
    + Quotedstr(Globalref) + ') order by seqno';

  With GetNewDataset(StrSQL, True) Do
    Try
      If Recordcount = 0 Then Begin
        Result := True;
        Exit;
      End;

      First;
      FLockFailed := False;
      Try
        While Eof = False Do Begin
          If Not(Userlock.Lock(BusobjectTableName, FieldByname('SaleId').AsInteger, LockGroupName)) Then Begin
            { alter the lock message for the locked record
              the locked record can be the current record, any of the BO record, or the parent record }
            If FieldByname(IDFieldName).AsInteger = Id Then ErrMsg := Userlock.LockMessage
            Else ErrMsg                                            := ReplaceStr(Userlock.LockMessage, 'this record', 'one of the Quote of this Group');
            FLockFailed                                            := True;
            Break;
          End;
          Next;
        End;
      Finally
        If FLockFailed Then Begin
          Result := False;
          First;
          While Eof = False Do Begin
            Userlock.UnLock(BusobjectTableName, FieldByname('SaleId').AsInteger, LockGroupName);
            Next;
          End;
        End;
      End;
    Finally
      If Active Then Close;
      Free;
    End;
  If Not FLockFailed Then Result := True;

End;

Function TQuote.Save: Boolean;
Begin
  Result := Inherited Save;
  If Result Then
    If SalesGroupRef <> '' Then
      If Lines.Count = 0 Then RelatedSale.Delete;
End;

Procedure TSalesLine.Copyallocation;
Begin
  If (Self Is TinvoiceLine) And (CopyingToInvoice) Then Exit; // Allocation should not be copied across when copying the invoice to invoice
  If (Self Is TSalesOrderLine) And (CopyingToSalesorder) Then Exit;
  Inherited;

End;

Procedure TSalesLine.CopyPropertyObjects(Const Mappedfields: STring);
Var
  FoDoProductallocation: TDoProductallocation;
Begin

  Inherited;
  If Self.ObjInstanceToClone Is TRepairParts Then Begin
    If (Assigned(Self.Owner)) And (Self.Owner Is TSales) Then
      If Assigned(TSales(Self.Owner).DoProductallocation) Then Begin
        FoDoProductallocation := TSales(Self.Owner).DoProductallocation;
        FoDoProductallocation(TProdQty(ObjInstanceToClone));
      End;
  End;
End;

Function TInvoice.GeTEquipmentxRef: TBusobj;
Begin
  Result := TBusobj(Getcontainercomponent(TEquipmentxRef, 'InvoiceId = ' + IntToStr(ID)));
End;

function TInvoice.getProgressPaymentLineID: Integer;
Var
  StrSQL: String;
Begin
  Result := 0;
  if ProgressPaymentInvRef <> '' then exit; // this is a progress Payment invoice
  StrSQL := 'Select SaleLineID from ' + Lines.BusObjectTableName + ' where  Productname =' +Quotedstr(PART_PROGRESSPAYMENT_TERMS)+' and saleId ='+ inttostr(ID);
  With GetnewDataset(StrSQL, True) Do
    Try
      Result := Fieldbyname('SaleLineID').AsInteger ;
    Finally
      If Active Then Close;
      Free;
    End;

end;

Procedure TSales.DLLCalcOrderTotals;
Begin
  CalcOrderTotals;
End;
(* function TSales.getSaleLinesofGroup: TSalesline;
  begin
  if assigned(fsaleLinesofGroup) then else begin
  fsaleLinesofGroup := TSalesLine.create(nil);
  fsaleLinesofGroup.connection := self.connection;
  fsaleLinesofGroup.LoadSelect('SaleID in ' +
  ' (select SaleID from tblsales ' +
  ' where Originalno = ' +QuotedStr(OriginalDocNumber) +
  ' and Globalref <> ' +QuotedStr(Globalref) +')');
  end;
  Result := fsaleLinesofGroup;
  end; *)

Function TInvoiceLine.ISoktoShip: Boolean;
Var
  FdAvailQty: Double;

  function CleanQtyes : boolean;
  begin
    Result := False;
    PostDB;
    UOMQtyShipped   := CleanUOMQtyShipped;
    QtyShipped      := CleanQtyShipped;
    QtyBackOrder    := Round(QtySold - QtyShipped, RoundPlacesGeneral);
    UOMQtyBackOrder := Round(DivZer(QtyBackOrder, UOMMultiplier), RoundPLacesGeneral);
  end;

Begin
  Result := Inherited ISoktoShip;
  If Not Result Then Exit;
  If SilentMode Then Exit;
  If UOMQtyShipped <= CleanUOMQtyShipped Then Exit;
  If Product.ProductType <> 'INV' Then Exit;

  If Appenv.CompanyPrefs.NegativeStockcheckinInvoicebasedon = 'A' Then
  begin
    FdAvailQty := TProductClass.AvailableQty(ProductID, TSales(Self.Owner).SaleClassId, Connection.Connection);
    FdAvailQty := FdAvailQty + Dataset.Fieldbyname('shipped').OldValue;
    // When invoice with Qty 4, shipped 0, BO 4 and we change shipped first time (without saving the original),
    // wAvailableQty returns 0...
    if FDAvailQty = 0 then
      FdAvailQty := DataSet.FieldByName('BackOrder').asInteger;
  end
  Else
  begin
    FdAvailQty := TProductClass.ProductInStockQty(ProductID, TSales(Self.Owner).SaleClassId, Connection.Connection);
    FdAvailQty := FdAvailQty + Dataset.Fieldbyname('shipped').OldValue;
  end;

  If FdAvailQty < UOMQtyShipped * UOMMultiplier Then
  Begin
    If AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAllowInvoiceStockToNegative') > 1 Then
    Begin
      ResultStatus.AddItem(False, RssWarning, 0, 'The Stock on Hand for product ' + ProductName + ' is ' + FloattoStr(FdAvailQty) + '.' + Chr(13) + 'Shipping ' + FloattoStr(UOMQtyShipped) + ' ' +
      UnitOfMeasure + ' will cause a negative stock in your Product List.' + Chr(13) + Chr(13) + 'No rights to create negative stock transaction');
      Result := CleanQtyes;
      Exit;
    End;
    If AppEnv.CompanyPrefs.ConfirmBeforeInvoiceStockToNegative = False Then
      Exit;
    If Assigned(ConfirmFromGUI) Then
      If FconfirmFromGUI('The Stock on Hand for product ' + ProductName + ' is ' + FloattoStr(FdAvailQty) + '.' + Chr(13) + 'Shipping ' + FloattoStr(UOMQtyShipped) + ' ' + UnitOfMeasure +
        ' will cause a negative stock in your Product List.' + Chr(13) + Chr(13) + 'Do you wish to continue?', [MbYes, MbNo]) = Mrno Then
      Begin
        Result := CleanQtyes;
        Exit;
      End;
  End
  else
  begin
    PostDB;
  end;
End;

Function TSalesLine.ISoktoShip: Boolean;
Begin
  REsult := True;
End;

Function TSales.PONumnotUnique(Const ShowError: Boolean): Boolean;
Begin
  Result := False;
  { on hold by DENE-
    as the back orders and converted trasnations copy the details as it is -
    gets ths customer's po number as well which becomes duplicate  - so can't be unique }

  (* var
    strSQL:String;
    begin
    result := False;
    if CustPONumber <> '' then
    strSQL:= 'select SaleId, PONumber '   +
    ' from tblsales where PONumber = ' +quotedStr(CustPONumber) +
    ' and SaleID    <> ' +IntToStr(self.ID)+
    ' and clientID  =  ' +IntToStr(ClientId) +
    ' and globalRef <> ' +quotedStr(SalesOrderGlobalRef)+
    ' and Globalref <> '+QuotedStr(QuoteGlobalRef)+
    ' and BOID <> '+QuotedStr(BackOrderGlobalRef);

    with getNewdataset(strSQL, true) do try
    if recordcount > 0 then begin
    if ShowError or Appenv.CompanyPrefs.UniqueCustomerPONumInSale then
    self.ResultStatus.AddItem(false, rssWarning, BOR_Sales_InvalidPONumber,
    'Customer P.O. Number ('+ CustPONumber + ') is not unique.' +chr(13) +'See Sale#' +fieldbyname('SaleID').asString);
    if Appenv.CompanyPrefs.UniqueCustomerPONumInSale then begin
    CustPONumber := '';
    Result:= true;
    end;
    end;
    finally
    if active then close;
    Free;
    end; *)
End;

Function TSalesLine.GetWarrantyEndsOn: TDateTime;
Begin
  Result := GetDateTimeField('WarrantyEndsOn');
End;

Function TSalesLine.GetWarrantyPeriod: String;
Begin
  Result := GetStringField('WarrantyPeriod');
End;
Function TSalesLine.GetBOMComments: String;
Begin
  Result := GetStringField('BOMComments');
End;
Function TSalesLine.GetReferenceNo: String;
Begin
  Result := GetStringField('ReferenceNo');
End;

Function TSalesLine.GetCustomerEquipmentID: Integer;
Begin
  Result := GetIntegerField('CustomerEquipmentID');
End;

Function TSalesLine.GetEquipment: String;
Begin
  Result := GetStringField('Equipment');
End;


Procedure TSalesLine.SetWarrantyEndsOn(Const Value: TDateTime);
Begin
  SetDateTimeField('WarrantyEndsOn', Value)
End;

Procedure TSalesLine.SetWarrantyPeriod(Const Value: String);
Begin
  SetStringField('WarrantyPeriod', Value)
End;
Procedure TSalesLine.SetBOMComments(Const Value: String);
Begin
  SetStringField('BOMComments', Value)
End;
Procedure TSalesLine.SetReferenceNo(Const Value: String);
Begin
  SetStringField('ReferenceNo', Value)
End;

Procedure TSalesLine.SetCustomerEquipmentID(Const Value: Integer);
Begin
  SetIntegerField('CustomerEquipmentID', Value)
End;

Procedure TSalesLine.SetEquipment(Const Value: String);
Begin
  SetStringField('Equipment', Value)
End;

Function TSalesOrder.GetInternalSOGlobalref: String;
Begin
  Result := GetStringfield('InternalSOGlobalref');
End;

Procedure TSalesOrder.SetInternalSOGlobalref(Const Value: String);
Begin
  SetStringfield('InternalSOGlobalref', Value);
End;

Function TSales.GetSalesShippingDetails: TSalesShippingDetails;
Begin
  Result := TSalesShippingDetails(GetContainerComponent(TSalesShippingDetails, 'SalesID = ' + IntToStr(Self.Id)));
End;

function TSales.getShipmentIDs: String;
begin
  fsAllIds := '';
  Lines.iteraterecords(ShipmentIDsCallback);
  if fsAllIds ='' then fsAllIds := '0';
  result := fsAllIds;
end;
Procedure TSales.ShipmentIDsCallback(Const Sender: TBusObj; Var Abort: Boolean);
var
  s:STring;
begin
  if (sender is TSalesline) then begin
    s:= TSalesline(Sender).shipmentsalelines.AllIds;
    if s <> '' then begin
      if fsAllIds <> '' then fsAllIds := fsAllIds + ',';
      fsAllIds := fsAllIds + s;
    end;
  end;
end;
Procedure TSales.CloneSalesDeliveryDetails(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  Sender.CloneBusObj(IDFieldNAme, ObjInstanceToClone.ID, False);
  If Sender.ObjInstanceToClone = Nil Then Begin
    FbObjectCopied := False;
    Exit;
  End Else Begin
  End;
End;

Procedure TSales.CloneShippingDetails(Const Sender: TBusObj; Var Abort: Boolean);
Begin

  Sender.CloneBusObj(IDFieldNAme, ObjInstanceToClone.ID, False);
  If Sender.ObjInstanceToClone = Nil Then Begin
    FbObjectCopied := False;
    Exit;
  End Else Begin

  End;
End;

Function TSalesLine.GetSalesLinesUOMDetails: TTransLinesUOMDetails;
Begin
  Result := TTransLinesUOMDetails(GetContainerComponent(TTransLinesUOMDetails, 'UnitID = ' + IntToStr(Self.UnitOfMeasureID)));
End;


function TSalesLine.GetShipmentSalelines: TShipmentSaleline;
begin
  Result := TShipmentSaleline(GetContainerComponent(TShipmentSaleline, 'SaleLineId = ' + IntToStr(Self.ID)));
end;

Function TSalesLine.GeTTransLineProductCustomFields: TTransLineProductCustomFields;
Begin
  Result := TTransLineProductCustomFields(GetContainerComponent(TTransLineProductCustomFields, 'PARTSID = ' + IntToStr(Self.ProductId)));
End;

Function TSales.TotalLinesingroup: Integer;
Var
  S: String;
Begin
  S := 'Select count(SaleLineID) ctr from tblSaleslines SL inner join tblSales S on S.SaleID = SL.SaleId and S.OriginalNo = ' + QuotedStr(OriginalDocNumber);
  With GetNewDataSet(S, True) Do
    Try Result := Fieldbyname('Ctr').AsInteger;
    Finally
      If Active Then Close;
      Free;
    End;
End;

Procedure TSalesOrderLine.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
Begin
  Inherited;
End;

Procedure TSalesOrder.ProcessDeletedLine;
Begin
  Inherited;
  If Lines.Deleted Then Begin
    If Not Lines.CanLockManifest Then Begin
      Lines.Deleted := False;
      Lines.PostDB;
      Exit;
    End;
    GetNewDataset('Delete from tblmanifestlines where  SaleLineID = ' + Inttostr(Lines.ID) + ' and ifnull(InvoiceLineID,0) = 0; ' +
      'update tblmanifestlines set SaleLineID = 0 where ifnull(SaleLineID,0) = ' + Inttostr(Lines.ID) + ';', True);
  End;
End;

Function TInvoice.GetSOProgressPaymentGlobalRef: String;
Begin
  Result := GetStringField('SOProgressPaymentGlobalRef');
End;

Function TInvoice.GetSOInvoiceRef: String;
Begin
  Result := GetStringField('SOInvoiceRef');
End;

Function TInvoice.GetSOInvoiced: Boolean;
Begin
  Result := GetBooleanField('SOInvoiced');
End;

Function TSalesOrder.GetTotalProgressPayments: Double;
Begin
  Result := TotalProgressPayment.Fieldbyname('totalLineamountinc').Asfloat;
End;

Procedure TInvoice.SetSOProgressPaymentGlobalRef(Const Value: String);
Begin
  SetStringField('SOProgressPaymentGlobalRef', Value);
End;

Procedure TInvoice.SetSOInvoiceRef(Const Value: String);
Begin
  SetStringField('SOInvoiceRef', Value);
End;

procedure TInvoice.SetShipDate(const Value: TDatetime);
begin
  inherited;
end;

procedure TInvoice.SetSigned(const Value: boolean);
begin
  fSigned := Value;
end;

Procedure TInvoice.SetSOInvoiced(Const Value: Boolean);
Begin
  SetBooleanField('SOInvoiced', Value);
End;

Function TSalesOrder.GetTotalPrePayment: TDataset;
Var
  S: String;
Begin
  If Not(Assigned(FTotalPrePayment)) Then Begin
    S := 'Select Sum(PP.PayAmount) as TotalAmount' + ' from tblSalesPrepayments  SP ' + ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef ' + ' Where PP.Deleted = "F" and SP.SalesREf = ' +
      Quotedstr(Self.Globalref);
    FTotalPrePayment := GetNewdataset(S, True);
  End;
  Result := FTotalPrePayment;
End;

Function TSalesOrder.GetTotalPrePayments: Double;
Begin
  Result := TotalPrePayment.Fieldbyname('TotalAmount').Asfloat;
End;

Function TSalesOrder.GetTotalProgressPayment: TDataset;
Var
  S: String;
Begin
  If Not(Assigned(FTotalProgressPayment)) Then Begin
    S := 'Select Sum(Sl.totalLineamountinc) as totalLineamountinc' +
          ' from tblsales S' +
          ' inner join tblSaleslines SL on S.SaleId = Sl.SaleId  and SL.Productname = ' + Quotedstr(PART_SOPROGRESSPAYMENT) +
          ' where S.SOProgressPaymentGlobalRef = ' + Quotedstr(Self.GlobalRef);
    FTotalProgressPayment := GetNewdataset(S, True);
  End;
  Result := FTotalProgressPayment;
End;

Procedure TSalesOrder.RecalcProgressPayments;
Begin
  If Assigned(FTotalProgressPayment) Then
    If FTotalProgressPayment.Active Then FTotalProgressPayment.Close;
  TotalProgressPayment;
End;

Function TSalesOrder.RecalculateTreecostnPrice:boolean;
begin
  Lines.iteraterecords(RecalculateTreecostnPriceCallback);
  Result := Save;
end;
procedure TSalesOrder.RecalculateTreecostnPriceCallback(const Sender: TBusObj; var Abort: Boolean);
  var
    ProcTree: TSalesLineProcTree;
begin
  if sender is TSalesOrderline then begin
    if TSalesOrderline(SendeR).IsTreeItem then begin
      TSalesOrderline(SendeR).InstantiateTree;
      ProcTree:=  TSalesLineProcTree(TSalesOrderline(SendeR).Container.ItemByClass(TSalesLineProcTree));
      if Assigned(ProcTree) then begin
      ProcTree.CalcTreePrice := true;
        ProcTree.CalcCost;
        ProcTree.CalcPrice;
        ProcTree.SaveNoCheck;
      end;
    end;
  end;
end;
class function TSalesOrder.MakeInvoice(aSaleID: Integer;Conn: TMyDAcDataconnection): Boolean;
var
  SO:TSalesOrder;
  InvID:Integer;
begin
  REsult := False;
  SO:= TSalesOrder.Create(nil);
  try
    SO.Connection := Conn;
    SO.Load(aSaleID);
    if SO.count =0 then exit;
    if SO.converted then begin // if already converted then exit with True as invoice is already created
      Result := True;
      Exit;
    end;
    So.Connection.BeginNestedTransaction;
    try
      InvID:= So.CopyToInvoice(So.ID);
      if InvID >0  then begin
        result := True;
        So.ResultStatus.AddItem(TRue, rssInfo , 0,'Invoice #' + inttostr(invID) +' is Created for ' + SO.CustomerName);
        So.Connection.CommitNestedTransaction;
        Exit;
      end;
      So.Connection.RollbackNestedTransaction;
    Except
      on E:Exception do begin
        So.Connection.RollbackNestedTransaction;
      end;
    end;
  finally
    Freeandnil(SO);
  end;
end;

Function TSalesOrder.MakeProgresspayment(Const Progresspaymentamt: Double; var msg: string): Integer;
Var
  Inv: TInvoice;
Begin
  Result := 0;
  Inv    := TInvoice.Create(Nil);
  Try
    Inv.Connection := Self.Connection;
    Inv.Connection.BeginTransaction;
    Try
      Inv.SilentMode := True;
      Inv.Load(0);
      Inv.New;
      Inv.CustomerName                 := Self.CustomerName;
      Inv.SaleClassName                := Self.SaleClassName;
      Inv.ForeignExchangeCode          := Self.ForeignExchangeCode;
      Inv.ForeignExchangeRate          := Self.ForeignExchangeRate;
      Inv.InvoiceToDesc                := Self.InvoiceToDesc;
      Inv.ShipToDesc                   := Self.ShipToDesc;
      Inv.SOProgressPaymentGlobalRef   := Self.GlobalRef;
      Inv.SOProgressPaymentOriginalRef := Self.OriginalDocNumber;
      Inv.CustPONumber                 := Self.CustPONumber;
      Inv.Comments                     := 'Progress Payment for Sales Order # ' + Quotedstr(GlobalRef) + '.';
      Inv.PostDB;
      Inv.Lines.New;
      Inv.Lines.ProductName         := PART_SOPROGRESSPAYMENT;
      Inv.Lines.Product_Description := 'Progress Payment of Sales Order :' + Globalref;
      Inv.Lines.QtySold             := 1;
      Inv.Lines.QtyShipped          := 1;
      Inv.Lines.LinePriceInc        := Progresspaymentamt;
      Inv.Lines.PostDB;

      If Not Inv.Save Then Begin
        msg := Inv.ResultStatus.Messages;
        result := 0;
        Inv.Connection.RollbackTransaction;
        Exit;
      End;
      Inv.Connection.CommitTransaction;
      Result := Inv.ID;

    Except Inv.Connection.RollbackTransaction;

    End;
  Finally Freeandnil(Inv);
  End;
End;


Function TSalesOrder.GetProgresspayments: TDataset;
Var
  S: String;
Begin
  If Not(Assigned(FProgresspayments)) Then Begin
    S := 'Select S.Globalref as SalesGlobalref, s.saleId, SL.globalref lineref, S.sAleDate, Sl.totalLineamount AmountEx,  Sl.totalLineamountinc Amount, Sl.LineTax as Linetaxtotal , SL.LineTaxRate , SL.LineTaxCode' +
      ' from tblsales S' +
      ' inner join tblSaleslines SL on S.SaleId = Sl.SaleId and SL.Productname = ' + Quotedstr(PART_SOPROGRESSPAYMENT) +
      ' where /*ifnull(S.SOProgressPaymentGlobalRef,"")*/ S.SOProgressPaymentGlobalRef = '      + Quotedstr(Self.GlobalRef) + ' and ifnull(S.SOProgressPaymentGlobalRef,"") <> ""';
    FProgresspayments := GetNewdataset(S, True);
  End;
  Result := FProgresspayments;
End;

Procedure TSalesOrder.AddProgresspayments(Inv: TInvoice);
var
  Flag : Boolean;
Begin
  If Converted Then Exit; // if salesorder is already converted, do not apply the credits

  With Progresspayments Do Begin
    If Recordcount = 0 Then Exit;
    First;
    While Eof = False Do Begin
      Inv.Lines.New;
      Inv.Lines.ProductName         := PART_SOPROGRESSPAYMENT;
      Inv.Lines.Product_Description := PART_SOPROGRESSPAYMENT + ' in Invoice :' + Fieldbyname('SalesGlobalref').AsString;
      Inv.Lines.QtySold             := -1;
      Inv.Lines.QtyShipped          := -1;
      Flag := Inv.lines.DoFieldChange;
      Inv.Lines.DoFieldChange := False;
      try
        Inv.Lines.LinePrice           := FieldByname('AmountEx').AsFloat;
        Inv.Lines.LinePriceInc        := FieldByname('Amount').AsFloat;
        Inv.Lines.LineTaxCode         := FieldByname('LineTaxCode').AsString;
        Inv.Lines.LinetaxRate         := FieldByname('LinetaxRate').AsFloat;
        Inv.Lines.LineTaxTotal        := 0 - FieldByname('Linetaxtotal').AsFloat;
        Inv.Lines.TotalLineAmount     := 0 - FieldByname('AmountEx').AsFloat;
        Inv.Lines.TotalLineAmountinc  := 0 - FieldByname('Amount').AsFloat;
      finally
        Inv.Lines.DoFieldChange := Flag;
      end;
      Inv.Lines.ProgresspaymentRef  := FieldByname('lineref').AsString;
      Inv.Lines.PostDB;
      Next;
    End;
    Inv.CalcOrderTotals;
  End;
End;

Function TInvoice.GetSOProgressPaymentOriginalRef: String;
Begin
  Result := GetStringfield('SOProgressPaymentOriginalRef');
End;

Function TInvoice.GetTotalPrePayment: TDataset;
Var
  StrSQL: String;
Begin
  If Not(Assigned(FTotalPrePayment)) Then Begin
    StrSQL := 'Select Sum(PP.Balance) TotalBalance ' +
              ' from tblSalesPrepayments  SP ' +
              ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef ' +
    // ' Where PP.Deleted = "F" and SP.SalesOriginalRef in ('+Quotedstr(OriginalDocNumber) +' , '+Quotedstr(getSalesOriginalnoForRef(SalesOrderglobalref))+')';
      ' Where PP.Deleted = "F" and SP.SalesRef in (' + Quotedstr(Globalref) + ' , ' + Quotedstr(SalesOrderGlobalref) + ')';
    FTotalPrePayment := GetNewdataset(Strsql, True);
  End;
  Result := FTotalPrePayment;
End;

Function TInvoice.GetTotalPrePayments: Double;
Begin
  Result := TotalPrePayment.Fieldbyname('TotalBalance').Asfloat;
End;

// Wang
function TInvoice.GetOriginalTotalAmount: Double;
var
  fdTotal: Double;
begin
  fdTotal := 0.0;

  Lines.First;
  while not Lines.EOF do begin
    fdTotal := fdTotal + Lines.OriginalTotalLineAmount;
    Lines.Next;
  end;

  Result := Round(fdTotal, CurrencyRoundPlaces);
end;

function TInvoice.GetOriginalTotalAmountInc: Double;
var
  fdTotalInc: Double;
begin
  fdTotalInc := 0.0;

  Lines.First;
  while not Lines.EOF do begin
    fdTotalInc := fdTotalInc + Lines.OriginalTotalLineAmountInc;
    Lines.Next;
  end;

  Result := Round(fdTotalInc, CurrencyRoundPlaces);
end;

function TInvoice.GetOriginalTotalTax: Double;
begin
  Result := Round(GetOriginalTotalAmountInc - GetOriginalTotalAmount, CurrencyRoundPlaces);
end;

// Wang
function TSalesOrder.GetOriginalTotalAmount: Double;
var
  fdTotal: Double;
begin
  fdTotal := 0.0;

  while not Lines.EOF do begin
    fdTotal := fdTotal + Lines.OriginalTotalLineAmount;
    Lines.Next;
  end;

  Result := Round(fdTotal, CurrencyRoundPlaces);
end;

function TSalesOrder.GetOriginalTotalAmountInc: Double;
var
  fdTotalInc: Double;
begin
  fdTotalInc := 0.0;
  while not Lines.EOF do begin
    fdTotalInc := fdTotalInc + Lines.OriginalTotalLineAmountInc;
    Lines.Next;
  end;

  Result := Round(fdTotalInc, CurrencyRoundPlaces);
end;

function TSalesOrder.GetOriginalTotalTax: Double;
begin
  Result := Round(GetOriginalTotalAmountInc - GetOriginalTotalAmount, CurrencyRoundPlaces);
end;


function TQuote.GetOriginalTotalAmount: Double;
var
  fdTotal: Double;
begin
  fdTotal := 0.0;

  while not Lines.EOF do begin
    fdTotal := fdTotal + Lines.OriginalTotalLineAmount;
    Lines.Next;
  end;

  Result := Round(fdTotal, CurrencyRoundPlaces);
end;

function TQuote.GetOriginalTotalAmountInc: Double;
var
  fdTotalInc: Double;
begin
  fdTotalInc := 0.0;
  while not Lines.EOF do begin
    fdTotalInc := fdTotalInc + Lines.OriginalTotalLineAmountInc;
    Lines.Next;
  end;

  Result := Round(fdTotalInc, CurrencyRoundPlaces);
end;

function TQuote.GetOriginalTotalTax: Double;
begin
  Result := Round(GetOriginalTotalAmountInc - GetOriginalTotalAmount, CurrencyRoundPlaces);
end;

Procedure TInvoice.SetSOProgressPaymentOriginalRef(Const Value: String);
Begin
  SetStringfield('SOProgressPaymentOriginalRef', Value);
End;

Function TInvoiceLine.GetProgresspaymentRef: String;
Begin
  Result := GetStringfield('ProgresspaymentRef');
End;

Procedure TInvoiceLine.SetProgresspaymentRef(Const Value: String);
Begin
  SetStringfield('ProgresspaymentRef', Value);
End;

Function TInvoiceLine.GetSOInvoiceLineRef: String;
Begin
  Result := GetStringfield('SOInvoiceLineRef');
End;

Procedure TInvoiceLine.SetSOInvoiceLineRef(Const Value: String);
Begin
  SetStringfield('SOInvoiceLineRef', Value);
End;
Function TInvoiceLine.GetPPGRef: String;
Begin
  Result := GetStringField('PPGRef');
End;
Procedure TInvoiceline.SetPPGRef(Const Value: String);
Begin
  SetStringField('PPGRef', Value);
End;
Procedure TInvoiceline.SetPPGInvoiced(Const Value: Boolean);
Begin
  SetBooleanField('PPGInvoiced', Value);
End;

Function TInvoiceLine.GetPPGInvoiced: Boolean;
Begin
  Result := GetBooleanField('PPGInvoiced');
End;

function TInvoiceLine.ValidateData: boolean;
var
  FdAvailQty: double;
begin
  result := Inherited;
  if not result then exit;

  If Product.ProductType <> 'INV' Then Exit;

//  result := false;
  If AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAllowInvoiceStockToNegative') > 1 then
  begin
    // employee not allowed to overship ..
    if appenv.CompanyPrefs.NegativeStockcheckinInvoicebasedon = 'A' then
      fdAvailQty := TProductClass.AvailableQty(ProductID, TSales(self.Owner).SaleClassId, connection.Connection)
    else
      fdAvailQty := TProductClass.ProductInStockQty(ProductID, TSales(self.Owner).SaleClassId, connection.Connection);
    fdAvailQty := fdAvailQty + dataset.fieldbyname('shipped').oldValue;

    If FdAvailQty < UOMQtyShipped * UOMMultiplier then begin
      If AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAllowInvoiceStockToNegative') > 1 Then
      Begin
        AddResult(False, RssWarning, 0, 'The Stock on Hand for product ' + ProductName + ' is ' + FloattoStr(FdAvailQty) + '.' + Chr(13) + 'Shipping ' + FloattoStr(UOMQtyShipped) + ' ' +
          UnitOfMeasure + ' will cause a negative stock in your Product List.' + Chr(13) + Chr(13) + 'No rights to create negative stock transaction');
        Result := false;
        exit;
      end;
    end;
  end;
  result := true;
end;

  {TSalesLinePackWeightLines}

constructor TSalesLinePackWeightLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'saleslinepackweightlines';
  fSQL := 'SELECT * FROM tblsaleslinepackweightlines';
end;

class function TSalesLinePackWeightLines.GetBusObjectTablename: string;
begin
  Result:= 'tblsaleslinepackweightlines';
end;

{Property Functions}
function TSalesLinePackWeightLines.getTranslineIDField: String;
begin
  result := 'SaleLineID';
end;
{ TManPQA }

function TManPQA.Save: Boolean;
begin
  if Assigned(Owner) and (Owner is TSalesOrderLine) then
    CopyAllocation(TSalesOrderLine(Owner).PQA.ID, false);
  result := inherited;
end;
{ TSalesLinePackWeightLinesSum }

constructor TSalesLinePackWeightLinesSum.Create(AOwner: TComponent);
begin
  inherited;
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'saleslinepackweightlines';
  fSQL := 'SELECT SL.saleId, SLPW.SaleLineId, sum(SLPW.AttribValue1*Packcount) as AttribValue1 , Sum(SLPW.AttribValue2*Packcount) as AttribValue2 , sum(Packcount) as Packcount' +
          ' FROM tblsaleslinepackweightlines SLPW ' +
          ' inner join tblsaleslines SL on SLPW.salelineId = SL.saleLineID ';
  fSQLGroup := 'saleLineId';
end;


function TSalesLinePackWeightLinesSum.getsaleId: Integer;
begin
  REsult := GetIntegerField('SaleId');
end;
procedure TSalesOrderLine.DoContainerEvent(const Sender: TObject;const EventType: Integer; const Data: TObject; Proc: TProcBusObjBase);
begin
 { TODO : Walmart - Backorders }
(*  If (Id > 0) and (eventtype = evSalesBOLineSave) then begin
      InstantiateWalmart(true, TSalesOrderLine(sender) , Eventtype);
      //make sure it updates the status in the right status record -> boline not line
  end;*)
  Inherited DoContainerEvent(Sender, Eventtype, Data, Proc);
End;
{ TODO : Walmart - Backorders }
(*procedure TSalesOrderLine.InstantiateWalmart(CreateIfnotCreated: Boolean;BOLine :TSalesOrderLine; Eventtype: Integer);
Var
  X     : Integer;
  BusObj: TBusObjBase;
  function BOLineBaaselineno:string;
  begin
    if BOLine.baselineno <> 0 then
      result :=  inttostr(BOLine.baselineno)
    else
      result := inttostr(BOLine.id);
  end;
Begin
  For X := 0 To Container.Count - 1 Do
    Try
      If (Container.Item[X] Is TWalmartOrderLineStatus_ERP) Then Exit;
    Except
    End;

  If CreateIfnotCreated Or BOLine.HasWalmartOrder Then Begin
    WalmartOrder.MakeWalmartOrderStatusForLine(BOLine , WalmartOrderStatus_ERPSOCreated);
    getcontainercomponent(TWalmartOrderLineStatus_ERP , 'ERPBaseLineno = ' + BOLineBaaselineno + ' and ERPLineId = ' + inttostr(BOLine.ID)+' and ERPID =  ' + inttostr(BOLine.saleID));

  End;
end;*)
(*function TSalesOrderLine.GetWalmartOrder:TWalmartOrders;
begin
  Result := TWalmartOrders(getcontainercomponent(TWalmartOrders , 'ERPSalesRef =' + quotedstr(OriginalSalesDocNumber)));
end;*)
function TSalesOrderLine.HasWalmartOrder: Boolean;
Var
  Qry:TERPQuery;
Begin
  REsult := False;
  if Assigned(Owner) and (Owner is TSalesOrder) then
    with TSalesOrder(Owner) do begin
      qry := DbSharedObj.GetQuery(connection.Connection);
      try
          commondblib.closedb(Qry);
          Qry.SQL.text := 'Select  SL.* from '+
                          ' tblwalmartorders WO '+
                          ' inner join tblsales S on WO.ERPSalesRef = ifnull(S.OriginalNo , "") '+
                          ' inner join tblsaleslines SL on SL.saleId = S.saleID  and SL.salelineid='+inttostr(baselineno)+
                          ' inner join tblwalmartorderlines WOL on WOL.ERPSalesLineRef = SL.GlobalRef '+
                          ' where WO.ERPsalesRef= ' + quotedstr(OriginalDocnumber);
          commondblib.opendb(Qry);
          Result := Qry.Recordcount > 0;
      Finally
          DbSharedObj.ReleaseObj(Qry);
      End;
    end;
End;
procedure TSalesOrder.DoContainerEvent(const Sender: TObject; const EventType: Integer; const Data: TObject; Proc: TProcBusObjBase);
begin
  if (Eventtype = evSalesBOLineSave) and (Sender is TSalesOrderLine) then begin
    TSalesOrderLine(Sender)(*Lines*).DoContainerEvent(Sender, EventType,Data,Proc);
    Exit;
  end;
  inherited;
end;
function TSalesOrder.IsWalmartOrder:Boolean;
begin
  LineCheckFlag := False;
  If Lines.HasWalmartOrder Then LineCheckFlag := True
  Else Lines.IterateRecords(AnyLineHasWalmartOrderCallback);
  Result := LineCheckFlag;
end;
Procedure TSalesOrder.AnyLineHasWalmartOrderCallback(Const Sender: TBusObj; Var Abort: Boolean);
begin
  if sender is TsalesOrderLine then begin
    If TsalesOrderLine(sender).HasWalmartOrder Then begin
      LineCheckFlag := True;
      Abort := True;
    end;
  end;
end;
{ TInvoiceBackorder }

constructor TInvoiceBackorder.Create(AOwner: TComponent);
begin
  inherited;
  fbIsReadonly := True;
  fSQL :=
    'SELECT DISTINCT S.* ' +
    'FROM tblSales S ' +
    'INNER JOIN tblSalesLines SL Using(SaleID) ' +
    'WHERE S.IsInvoice = "T" AND S.IsRefund = "F" AND S.IsCashSale = "F" AND S.IsSalesOrder = "F" ' +
    'AND S.IsQuote = "F" AND S.Deleted = "F" ' +
    'AND SL.Invoiced = "F" AND SL.BackOrder <> 0 ' +
    'AND IfNull(S.BOID , "") = ""';
end;

{ TSalesOrderBackOrder }

constructor TSalesOrderBackOrder.Create(AOwner: TComponent);
begin
  inherited;
  fbIsReadonly := True;
  fSQL :=
    'SELECT DISTINCT S.* ' +
    'FROM tblSales S ' +
    'INNER JOIN tblSalesLines SL Using(SaleID) ' +
    'WHERE S.IsSalesOrder ="T"' +
    'AND SL.Invoiced = "F" AND SL.BackOrder <> 0 ' +
    'AND IfNull(S.BOID , "") = ""';
end;

{ TInvoiceNonBackOrder }

constructor TInvoiceNonBackOrder.Create(AOwner: TComponent);
begin
  inherited;
  fbIsReadonly := True;
  fSQL :=
    'SELECT DISTINCT S.* ' +
    'FROM tblSales S ' +
    'INNER JOIN tblSalesLines SL Using(SaleID) ' +
    'WHERE S.IsInvoice = "T" AND S.IsRefund = "F" AND S.IsCashSale = "F" AND S.IsSalesOrder = "F" ' +
    'AND S.IsQuote = "F" AND S.Deleted = "F" ' +
    'AND SL.Invoiced = "T" AND  IfNull(SL.Shipped,0) <> 0' ;

end;

{ TSalesOrderNonBackOrder }

constructor TSalesOrderNonBackOrder.Create(AOwner: TComponent);
begin
  inherited;
  fbIsReadonly := True;
  fSQL :=
    'SELECT DISTINCT S.* ' +
    'FROM tblSales S ' +
    'INNER JOIN tblSalesLines SL Using(SaleID) ' +
    'WHERE S.IsSalesOrder ="T"' +
    'AND SL.Invoiced = "T" AND  IfNull(SL.Shipped,0) <> 0' ;

end;

initialization
  RegisterClass(TSalesLinePackWeightLines);

  RegisterClassOnce(TInvoiceLine);
  RegisterClassOnce(TInvoice);

  RegisterClassOnce(TQuoteLine);
  RegisterClassOnce(TQuote);

  RegisterClassOnce(TSalesOrderLine);
  RegisterClassOnce(TSalesOrder);

  RegisterClassOnce(TManPQA);

  RegisterClassOnce(TQuoteEx);
  RegisterClassOnce(TSalesOrderEx);
  RegisterClassOnce(TInvoiceEx);

  RegisterClass(TInvoiceBackorder);
  RegisterClass(TInvoiceNonBackOrder);
  RegisterClass(TSalesOrderBackOrder);
  RegisterClass(TSalesOrderNonBackOrder);

End.
