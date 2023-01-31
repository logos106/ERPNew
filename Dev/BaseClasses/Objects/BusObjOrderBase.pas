{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 25/05/06  1.00.00  BJ  Initial version - busobjTrans is Split into 2 units(busobjtrans and busobjOrders).
                        XML is created on TOrderbase / TOrderbaseline
                        (same in Sales object - to make it easy to search for the field in XML).
 04/07/06  1.00.01  BJ  Sorting the details on the sortId is handled for inserting records in the line
 12/07/06  1.00.02  BJ  warning message displayed when the qty was 0 is being removed - the record gets
                        saved as BO line without any message.
 08/08/06  1.00.03  BJ  Purchaseorder.LineValidateCallbackProc stores the Id of the line record when its invalid.
                        and Adds the line's resutlstatus items to the PO's resultstatus.
                        When the bin/batch allocation is wrong, the form uses this Id to locate the recordand open the allocation form for the record.
 14/08/06 1.00.04   BJ  orderdate is compared with companypref.closing date (this was done in the form and moved into the object)
                        Introduced the cleanOrderdate to do this check only when the date is changed
 15/08/06 1.00.05 BJ    1)Dataset.. procedures are changed to normal private procedures , the
                            descendants are supposed to Override the Do... procedures
                        Supplier object property is outdside transaction.
 21/08/06 1.00.06 BJ    Event list stores the Id of the object as well, so the Addevent Function
                        is called with the ID
 24/08/06 1.00.07 BJ    UpdateAccounts is doing the supplier / account updations only after
                        the PO is invoiced.
                        Supplier's Balance was updated, but is updating the AP balance as well.
 29/08/06 1.00.08 BJ    1.UpdateGlobalref is made a virtual Function in Transbase as the sales obejcts also need it
                        2.Lines.Beforedelete is not locking the related records as loading the PO locks the whole group.
                        3.CalcOrderTotals of the header is called when the line is opened. This calcualtes the totals in
                        the calcualted field and updates the fields in the table. THE TABLE UPDATION IS ONLY DONE
                        IF THE CALCULATED VALUE IS DIFFERENT FROM THE TABLE VALUE. this is to avoid changing the
                        table's mode to edit - which causes a problem when is Readonly
 08/09/06 1.00.09 BJ    DoFieldOnChange was checking the current field's name using an =
                        which is case sensitive, this is changed to using Sametext Function
 23/01/07 1.00.10 BJ    show_status procedure is moved to usob_trans inorder to use in all transactions
 05/02/07 1.00.11 DSP   Added procedure UpdateNewPrices

}
unit BusObjOrderBase;

interface

uses
  BusObjBase, BusObjClient, Classes, DB, Variants,
  BusObjTrans, BusObjGLAccount, XMLDoc, XMLIntf, TransSumLinesObj , BusobjTransTaxCodes,BusobjPurchaseTaxCodes, BusobjUOM,
  BusObjShippingAddress,BusObjSalesLookup, BusObjFeTransLines , BusObjTransLinetotals, BusObjClass;

type

  TOrderLineBase = class(TTransLineBase)
  private
    fFEPOLines: TFEPOLines;
    Function GetAttrib1Purchase         : Double;
    Function GetAttrib1PurchaseRate     : Double;
    Function GetAttrib2Purchase         : Double;
    Function GetAttrib1PurchaseEst      : Double;
    Function GetAttrib2PurchaseEst      : Double;
    Function GetLineClassId             : Integer;
    Function GetLineClassName           : String;
    Function GetPurchaseLineId          : Integer;
    Function GetPurchaseOrderId         : Integer;
    Function GetAverageCost             : Double;
    Function GetReceivedDate            : TDateTime;
    Function GetForeignExchangeCode     : String;
    Function GetForeignExchangeRate     : Double;
    Function GetAccountNumber			: String;
    Function GetAccountName				: String;
    function GetLineGLAccount           : TAccount;
    Function GetAccountGroup			: String;
    Function GetCustomerJob				: String;
    Function GetCustomerPrintJob	: String;
    Function GetCustomerJobID			: Integer;
    Function GetCustomerJobobj          : TClient;
    Function GetRAQty					: Double;
    Function GetRAstatus				: String;
    Function GetBatch					: String;
    Function GetUseTimecost				: Boolean;
    Function GetSaleID_Timecost			: Integer;
    Function GetTimecostMarkupPer		: Double;
    Function GetTimecostPrice			: Double;
    Function GetTimecostMarkupDol		: Double;
    Function GetCOGSTotalLineAmount		: Double;
    Function GetCOGSTotalLineAmountInc	: Double;
    Function GetEditedFlag				: Boolean;
    Function GetRAInvoiceNo				: String;
    Function GetLastLineID				: Integer;
    Function GetRelatedPOIDUsed			: Boolean;
    Function GetRelatedPOID				: Integer;
    Function GetDocketNumber			: String;
    Function GetNewForeignExchangeRate  : Double;
    Function GetETADate					: TDateTime;
    Function GetCustomField1			: String;
    Function GetCustomField2			: String;
    Function GetCustomField3			: String;
    Function GetCustomField4			: String;
    Function GetCustomField5			: String;
    Function GetCustomField6			: String;
    Function GetCustomField7			: String;
    Function GetCustomField8			: String;
    Function GetCustomField9			: String;
    Function GetCustomField10			: String;
    Function GetINCOMEACCNTID			: Integer;
    Function GetAssetAccntId			: Integer;
    Function GetCogsAccntId				: Integer;
    Function GetPartSpecID              : Integer;
    Function GetSpecDescription         : String;
    Function GetSpecValue               : Double;
    Function GetUnitLandedCost          : Double;
    Function GetTotalOrderLandedCost     : Double;
    Function GetOriginalQtyOrdered      : Double;
    Function GetTotalLineLandedCostPerc : Double;
    Function GetSaleLineID              : Integer;

    procedure SetPartSpecID             (const Value : Integer);
    procedure SetSpecDescription        (const Value : String);
    procedure SetSpecValue              (const Value : Double);
    procedure SetUnitLandedCost         (const Value : Double);
    procedure SetTotalOrderLandedCost    (const Value : Double);
    procedure SetOriginalQtyOrdered     (const Value : Double);
    procedure SetTotalLineLandedCostPerc(const Value : Double);
    Procedure SetAccountNumber          (Const Value : String);
    Procedure SetAccountName            (Const Value : String);
    Procedure SetAccountGroup           (Const Value : String);
    Procedure SetCustomerJob            (Const Value : String);
    Procedure SetCustomerPrintJob       (Const Value : String);
    Procedure SetCustomerJobID          (Const Value : Integer);
    Procedure SetRAQty                  (Const Value : Double);
    Procedure SetRAstatus               (Const Value : String);
    Procedure SetBatch                  (Const Value : String);
    Procedure SetUseTimecost            (Const Value : Boolean);
    Procedure SetSaleID_Timecost        (Const Value : Integer);
    Procedure SetTimecostMarkupPer      (Const Value : Double);
    Procedure SetTimecostPrice          (Const Value : Double);
    Procedure SetTimecostMarkupDol      (Const Value : Double);
    Procedure SetCOGSTotalLineAmount    (Const Value : Double);
    Procedure SetCOGSTotalLineAmountInc (Const Value : Double);
    Procedure SetEditedFlag             (Const Value : Boolean);
    Procedure SetRAInvoiceNo            (Const Value : String);
    Procedure SetLastLineID             (Const Value : Integer);
    Procedure SetRelatedPOIDUsed        (Const Value : Boolean);
    Procedure SetRelatedPOID            (Const Value : Integer);
    Procedure SetDocketNumber           (Const Value : String);
    Procedure SetNewForeignExchangeRate (Const Value : Double);
    Procedure SetETADate                (Const Value : TDateTime);
    Procedure SetCustomField1           (Const Value : String);
    Procedure SetCustomField2           (Const Value : String);
    Procedure SetCustomField3           (Const Value : String);
    Procedure SetCustomField4           (Const Value : String);
    Procedure SetCustomField5           (Const Value : String);
    Procedure SetCustomField6           (Const Value : String);
    Procedure SetCustomField7           (Const Value : String);
    Procedure SetCustomField8           (Const Value : String);
    Procedure SetCustomField9           (Const Value : String);
    Procedure SetCustomField10          (Const Value : String);
    Procedure SetINCOMEACCNTID          (Const Value : Integer);
    Procedure SetAssetAccntId           (Const Value : Integer);
    Procedure SetCogsAccntId            (Const Value : Integer);
    Procedure SetAttrib1Purchase        (const Value : Double);
    Procedure SetAttrib1PurchaseRate    (const Value : Double);
    Procedure SetAttrib2Purchase        (const Value : Double);
    Procedure SetAttrib1PurchaseEst     (const Value : Double);
    Procedure SetAttrib2PurchaseEst     (const Value : Double);
    Procedure SetLineClassId            (const Value : Integer);
    Procedure SetLineClassName          (const Value : String);
    Procedure SetPurchaseOrderId        (const Value : Integer);
    Procedure SetAverageCost            (const Value : Double);
    Procedure SetReceivedDate           (const Value : TDateTime);
    Procedure SetForeignExchangeCode    (const Value : String);
    Procedure SetForeignExchangeRate    (const Value : Double);
    Procedure SetSaleLineId             (Const Value : Integer);
    function getSupplierName: String;
    function getsupplierID: Integer;
    function getCustomerEquipmentID: Integer;
    function getEquipmentName: String;
    function getRepairId: Integer;
    procedure setCustomerEquipmentID(const Value: Integer);
    procedure SetEquipmentName(const Value: String);
    procedure setRepairId(const Value: Integer);
    function GetTotalLineLandedCost: double;
    function getCleanLinecost: double;
    function getCleanReceivedDate :TDateTime;
    Function getCleanRepairId :Integer;
    function getProcTreeId: Integer;
    procedure setProcTreeId(const Value: Integer);
    function GetSupplierProductCode: string;
    function GetSupplierProductName: string;
    function GetSupplierBarCode: string;
    procedure SetSupplierProductCode(const Value: string);
    procedure SetSupplierProductName(const Value: string);
    procedure SetSupplierBarCode(const Value: string);
    function getRALineRef: String;
    function getEmployeeName: String;
    procedure setRALineRef(const Value: String);
    procedure setEmployeeName(const Value: String);
    function getPrintedValue: Double;
    procedure setPrintedValue(const Value: Double);
    function getDiscountPercent: double;
    procedure setDiscountPercent(const Value: double);
    function getDiscountAmount: double;
    procedure setDiscountAmount(const Value: double);
    function getOriginalCost: Double;
    procedure setOriginalCost(const Value: Double);
    Function GetPurchaseTaxCode: TPurchaseTaxCode;
    function getPOLinesUOMDetails: TTransLinesUOMDetails;
    function getSmartOrderID: Integer;
    function getEmployeeID: Integer;
    function getSmartOrderLineID: Integer;
    procedure setSmartOrderID(const Value: Integer);
    procedure setEmployeeID(const Value: Integer);
    procedure setSmartOrderLineID(const Value: Integer);
    function GetRepairDocNo: string;
    procedure SetRepairDocNo(const Value: string);
    function geTTransLineProductCustomFields: TTransLineProductCustomFields;
    function supplierAreaCode: String;
    function GetCustomerJobName: string;
    procedure SetCustomerJobName(const Value: string);
    function GetForeignUOMLineCost: double;
    function getFEPOLines: TFEPOLines;
    procedure SetFEPOLines(const Value: TFEPOLines);
    procedure CheckREceivedDate;
    function getLineClass: TDeptClass;
  protected
    GetProductDetailsCount: integer;
    Function  GetUnitOfMeasure          : String; Override;
    Function  GetUnitOfMeasureID        : Integer;Override;
    Function  GetId                     : Integer;Override;
    Function  GetClassID                : Integer;Override;
    Function  GetSerialnos              : String; Override;
    Function  GetCleanClassID           : Integer;Override;
    Function  GetcleanProductId         : Integer;Override;
    Function  GetcleanQtyTotal          : Double; Override;
    Function  GetCleanQty               : Double;
    function ExcludeFromclone:String; override;
    Function  GetSQL                    : String; Override;
    Function  GetForeignLineCost        : Double;
    Function  DoAfterDelete     (Sender : TDatasetBusObj ):Boolean; Override;
    Function  DoAfterInsert     (Sender : TDatasetBusObj ):Boolean; Override;
    Function  DoBeforePost (Sender:TDatasetBusobj):boolean; override;
    procedure DoFieldOnChange   (Sender : TField);                  Override;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure SetUnitOfMeasure  (const Value : String);             Override;
    procedure SetUnitOfMeasureID(const Value : Integer);            Override;
    procedure SetSerialNos      (const Value : String);             Override;
    procedure SetForeignLineCost(const Value : Double);
    procedure InitializeNewObject;                                  Override;
    Procedure CreateInstance;                                       Override;
    procedure GetProductDetails;                                    override;
    Procedure ApplyDiscount;
    procedure UpdateProductBuyCostFromLineCost;
    Function  GetAllocType        :String; override;
    Function GetTransDate        :TDatetime; override;
    procedure SetTransDate(const Value: TDatetime); override;
    function DoCalcFields(sender :TDatasetBusObj): boolean; override;
    function GetTransTaxCode: TTransTaxCode;Override;
    Function  DoNewRecord(Sender :TDatasetBusObj )  : Boolean;  Override;
    function getAreaCode: String;override;
    procedure SetAreaCode(const Value: String);override;
    procedure CalcLineForeingAmount;override;
  public
    class Function  GetIDField: String; Override;
    class function GetBusObjectTablename: string; Override;
    constructor Create(AOwner: TComponent);                         Override;
    destructor Destroy; override;
    procedure   FlagAsUpdated(aTimeStamp: TDateTime = 0);           Override;
    procedure   SaveToXMLNode   (Const Node: IXMLNode);             Override;
    procedure   LoadFromXMLNode (Const Node: IXMLNode);             Override;
    Function    CalcBaseLineAmount: Double;                         virtual;
    procedure   CalcLineTotals;                                     override;
    Property    CleanQty    :Double Read GetCleanQty;
    Property    LeanLinecost:double read getCleanLinecost;
    Property CleanReceivedDate :TDatetime read getcleanReceivedDate;
    Property    CleanRepairId :Integer read getcleanRepairId;
    function    Delete: boolean; override;
    function    ValidateData: Boolean;                             Override;
    Property    SupplierName :String Read getSupplierName;
    Property    SupplierID   :Integer read getsupplierID;
    procedure   CheckAndUpdateProductForeignBuyPrice;Virtual;
    Property    POLinesUOMDetails : TTransLinesUOMDetails read getPOLinesUOMDetails;
    Property    OrderlineProductCustomFields : TTransLineProductCustomFields read geTTransLineProductCustomFields;
    procedure CalcLineCostFromTotal;                                virtual;
    Property CustomerJobObj         : TClient       Read GetCustomerJobobj;
    Property EditedFlag				: Boolean		Read getEditedFlag				Write SetEditedFlag;
    Property LineGLAccount          : TAccount      Read getLineGLAccount;
    procedure PostFERecords;
    Property LineClass :TDeptClass read getLineClass;
Published
    property PurchaseLineId         : Integer       Read GetPurchaseLineId;
    property PurchaseOrderId        : Integer       Read GetPurchaseOrderId         Write SetPurchaseOrderId;
    property Attrib1Purchase        : Double        Read GetAttrib1Purchase         Write SetAttrib1Purchase;
    property Attrib2Purchase        : Double        Read GetAttrib2Purchase         Write SetAttrib2Purchase;
    property Attrib1PurchaseRate    : Double        Read GetAttrib1PurchaseRate     Write SetAttrib1PurchaseRate;
    property Attrib1PurchaseEst     : Double        Read GetAttrib1PurchaseEst         Write SetAttrib1PurchaseEst;
    property Attrib2PurchaseEst     : Double        Read GetAttrib2PurchaseEst         Write SetAttrib2PurchaseEst;
    property LineClassName          : String        Read GetLineClassName           Write SetLineClassName;
    property LineClassId            : Integer       Read GetLineClassId             Write SetLineClassId;
    property AverageCost            : Double        Read GetAverageCost             Write SetAverageCost;
    property ReceivedDate           : TDateTime     Read GetReceivedDate            Write SetReceivedDate;
    Property ForeignExchangeCode    : String        Read getForeignExchangeCode     Write setForeignExchangeCode;
    Property ForeignExchangeRate    : Double        Read getForeignExchangeRate     Write setForeignExchangeRate;
    Property AccountNumber		    : String		Read getAccountNumber			Write SetAccountNumber;
    Property AccountName		    : String		Read getAccountName				Write SetAccountName;
    Property AccountGroup		    : String		Read getAccountGroup			Write SetAccountGroup;
    Property CustomerJob		    : String		Read getCustomerJob				Write SetCustomerJob;
    Property CustomerPrintJob   : String		Read getCustomerPrintJob	Write SetCustomerPrintJob;
    Property CustomerJobID		    : Integer		Read getCustomerJobID			Write SetCustomerJobID;
    property CustomerJobName: string read GetCustomerJobName write SetCustomerJobName;
    Property RAQty				    : Double		Read getRAQty					Write SetRAQty;
    Property RAstatus				: String		Read getRAstatus				Write SetRAstatus;
    Property Batch					: String		Read getBatch					Write SetBatch;
    Property UseTimecost			: Boolean		Read getUseTimecost				Write SetUseTimecost;
    Property SaleID_Timecost		: Integer		Read getSaleID_Timecost			Write SetSaleID_Timecost;
    Property TimecostMarkupPer		: Double		Read getTimecostMarkupPer		Write SetTimecostMarkupPer;
    Property TimecostPrice			: Double		Read getTimecostPrice			Write SetTimecostPrice;
    Property TimecostMarkupDol		: Double		Read getTimecostMarkupDol		Write SetTimecostMarkupDol;
    Property COGSTotalLineAmount	: Double		Read getCOGSTotalLineAmount		Write SetCOGSTotalLineAmount;
    Property COGSTotalLineAmountInc	: Double		Read getCOGSTotalLineAmountInc	Write SetCOGSTotalLineAmountInc;
    Property RAInvoiceNo			: String		Read getRAInvoiceNo				Write SetRAInvoiceNo;
    Property LastLineID				: Integer		Read getLastLineID				Write SetLastLineID;
    Property RelatedPOIDUsed		: Boolean		Read getRelatedPOIDUsed			Write SetRelatedPOIDUsed;
    Property RelatedPOID			: Integer		Read getRelatedPOID				Write SetRelatedPOID;
    Property DocketNumber			: String		Read getDocketNumber			Write SetDocketNumber;
    Property NewForeignExchangeRate	: Double		Read getNewForeignExchangeRate	Write SetNewForeignExchangeRate;
    Property ETADate				: TDateTime	    Read getETADate					Write SetETADate;
    Property CustomField1			: String		Read getCustomField1			Write SetCustomField1;
    Property CustomField2			: String		Read getCustomField2			Write SetCustomField2;
    Property CustomField3			: String		Read getCustomField3			Write SetCustomField3;
    Property CustomField4			: String		Read getCustomField4			Write SetCustomField4;
    Property CustomField5			: String		Read getCustomField5			Write SetCustomField5;
    Property CustomField6			: String		Read getCustomField6			Write SetCustomField6;
    Property CustomField7			: String		Read getCustomField7			Write SetCustomField7;
    Property CustomField8			: String		Read getCustomField8			Write SetCustomField8;
    Property CustomField9			: String		Read getCustomField9			Write SetCustomField9;
    Property CustomField10			: String		Read getCustomField10			Write SetCustomField10;
    Property INCOMEACCNTID			: Integer		Read getINCOMEACCNTID			Write SetINCOMEACCNTID;
    Property AssetAccntId			: Integer		Read getAssetAccntId			Write SetAssetAccntId;
    Property CogsAccntId			: Integer		Read getCogsAccntId				Write SetCogsAccntId;
    Property RepairId         : Integer   Read getRepairId          Write setRepairId;
    Property RepairDocNo      : string   read GetRepairDocNo          write SetRepairDocNo;
    Property CustomerEquipmentID :Integer Read getCustomerEquipmentID Write setCustomerEquipmentID;
    Property EquipmentName    : String    REad getEquipmentName     Write SetEquipmentName;
    Property SmartOrderID :Integer read getSmartOrderID write setSmartOrderID;
    Property EmployeeID :Integer read getEmployeeID write setEmployeeID;
    Property SmartOrderLineID :Integer read getSmartOrderLineID write setSmartOrderLineID;

    Property SpecDescription        : String        Read GetSpecDescription         Write SetSpecDescription;
    Property UnitLandedCost         : Double        Read GetUnitLandedCost          Write SetUnitLandedCost;
    property TotalLineLandedCost: double read GetTotalLineLandedCost;
    Property TotalLineLandedCostPerc: Double        Read GetTotalLineLandedCostPerc Write SetTotalLineLandedCostPerc;
    Property OriginalQtyOrdered     : Double        Read GetOriginalQtyOrdered      Write SetOriginalQtyOrdered     ;
    Property TotalOrderLandedCost    : Double        Read GetTotalOrderLandedCost     Write SetTotalOrderLandedCost;
    Property PartSpecID             : Integer       Read GetPartSpecID              Write SetPartSpecID;
    Property SpecValue              : Double        Read GetSpecValue               Write SetSpecValue;
    Property ForeignLineCost        : Double        Read GetForeignLineCost         Write SetForeignLineCost;
    property ForeignUOMLineCost: double read GetForeignUOMLineCost;

    Property SaleLineID             : Integer       Read GetSaleLineID              Write SetSaleLineID;
    Property  ProcTreeId   : Integer   Read getProcTreeId  write setProcTreeId;
    property SupplierProductCode: string read GetSupplierProductCode write SetSupplierProductCode;
    Property PrintedValue :Double read getPrintedValue Write setPrintedValue;
    property SupplierProductName: string read GetSupplierProductName write SetSupplierProductName;
    property SupplierBarCode: string read GetSupplierBarCode write SetSupplierBarCode;
    Property RALineRef :String read getRALineRef write setRALineRef;
    Property EmployeeName :String read getEmployeeName write setEmployeeName;
    Property DiscountPercent :double read getDiscountPercent write setDiscountPercent;
    Property DiscountAmount :double read getDiscountAmount write setDiscountAmount;
    Property OriginalCost :Double Read getOriginalCost Write setOriginalCost;
    property FEPOLines: TFEPOLines read getFEPOLines write SetFEPOLines;
    property PurchaseTaxCode: TPurchaseTaxCode read GetPurchaseTaxCode;
  end;

  TPaysActionAuthorisations = class(TMSBusObj)
  private
    Function GetType               : string    ;
    Function GetWho                : string    ;
    Function GetDate               : TDateTime ;
    Function GetActionSuccess      : Boolean   ;
    Procedure SetType               (const Value: string    );
    Procedure SetWho                (const Value: string    );
    Procedure SetDate               (const Value: TDateTime );
    Procedure SetActionSuccess      (const Value: Boolean   );
  Protected
    Procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    Function  GetSQL: string;                                            override;
    Function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
  Public
    Class Function  GetIDField: string;                                  override;
    Class function  GetBusObjectTablename   :String;                     Override;
    Constructor  Create(AOwner: TComponent);                             override;
    Destructor   Destroy;                                                override;
    Procedure DoFieldOnChange(Sender: TField);                           override;
    Procedure    LoadFromXMLNode(const node: IXMLNode);                  override;
    Procedure    SaveToXMLNode(const node: IXMLNode);                    override;
    Function     ValidateData: Boolean ;                                 override;
    Function     Save: Boolean ;                                         override;
  Published
    property ActionType          :string      read GetType              write SetType           ;
    property Who                 :string      read GetWho               write SetWho            ;
    property Date                :TDateTime   read GetDate              write SetDate           ;
    property ActionSuccess       :Boolean     read GetActionSuccess     write SetActionSuccess  ;
  end;

(*  TAddressRec = class(TObject)
  private
    fState: string;
    fLine2: string;
    fId: integer;
    fLine3: string;
    fLine1: string;
    fCountry: string;
    fPostcode: string;
    fCity: string;
  public
    property Id: integer read fId write fId;
    property Line1: string read fLine1 write fLine1;
    property Line2: string read fLine2 write fLine2;
    property Line3: string read fLine3 write fLine3;
    property City: string read fCity write fCity;
    property State: string read fState write fState;
    property Postcode: string read fPostcode write fPostcode;
    property Country: string read fCountry write fCountry;
  end;*)

  TOrderBase = class(TTransBase)
  private
    fSupplier           : TSupplier;
    LineSum             : TTransLineSum;
    fPopupDisplayed     : Boolean;
    fShipToAddressRec   : TAddressRec;
//    fCleanPrice: Double;
    function  ShipToAddressRec          : TAddressRec;
    Function  GetPurchaseOrderId        : Integer;
    Function  GetSupplierName           : String;
    Function  GetSupplierId             : Integer;
    Function  GetOrderDate              : TDateTime;
    Function  GetSupplier               : TSupplier;
    Function  GetSupplierInvoiceDate    : TDateTime;
    Function  GetSupplierInvoiceNumber  : String;
    Function  GetInvoiced               : boolean;
    Function  GetOrderTo			          : String;
    Function  GetShipTo			            : String;
    Function  GetRefNo			            : String;
    Function  GetETADate			          : TDateTime;
    Function  GetOrgPurchaseOrderNumber : String;
    Function  GetSalesComments          : String;
    Function  GetShipping		            : String;
    Function  GetApplyFlag		          : Boolean;
    Function  GetAmountDue		          : Double;
    Function  GetPayMethod		          : Integer;
    Function  GetIsPO			              : Boolean;
    Function  GetIsRA			              : Boolean;
    Function  GetIsBill			            : Boolean;
    Function  GetIsCredit		            : Boolean;
    Function  GetIsCheque		            : Boolean;
    Function  GetIsRefundCheque         : Boolean;
    Function  GetRefundGlobalref        : String;
    Function  GetIsPOCredit		          : Boolean;
    Function  GetEditedFlag		          : Boolean;
    Function  GetConNote			          : String;
    Function  GetCustPONumber	          : String;
    Function  GetLastUpdated		        : TDateTime;
    Function  GetApproved		            : Boolean;
    function  GetCleanApproved          : Boolean;
    Function  getcleanOrderDate         : TDateTime;
    Function  GetExpenseClaimEmployee   : Integer;
    Function  GetPaysActions            : TPaysActionAuthorisations;
    Function  GetArea                   : String;
    Function  GetCustField1             : String;
    Function  GetCustField2             : String;
    Function  GetCustField3             : String;
    Function  GetCustField4             : String;
    Function  GetCustField5             : String;
    Function  GetCustField6             : String;
    Function  GetCustField7             : String;
    Function  GetCustField8             : String;
    Function  GetCustField9             : String;
    Function  GetCustField10            : String;

    procedure SetSupplierName           (const Value : String);
    procedure SetSupplierId             (const Value : Integer);
    procedure SetOrderDate              (const Value : TDateTime);
    procedure SetSupplierInvoiceDate    (const Value : TDateTime);
    procedure SetSupplierInvoiceNumber  (const Value : String);
    Procedure SetOrderTo                (Const Value : String);
    Procedure SetShipTo                 (Const Value : String);
    Procedure SetRefNo                  (Const Value : String);
    Procedure SetETADate                (Const Value : TDateTime);
    Procedure SetOrgPurchaseOrderNumber (Const Value : String);
    Procedure SetSalesComments          (Const Value : String);
    Procedure SetShipping               (Const Value : String);
    Procedure SetApplyFlag              (Const Value : Boolean);
    Procedure SetAmountDue              (Const Value : Double);
    Procedure SetPayMethod              (Const Value : Integer);
    Procedure SetIsPO                   (Const Value : Boolean);
    Procedure SetIsRA                   (Const Value : Boolean);
    Procedure SetIsBill                 (Const Value : Boolean);
    Procedure SetIsCredit               (Const Value : Boolean);
    Procedure SetIsCheque               (Const Value : Boolean);
    Procedure SetIsRefundCheque         (Const Value : Boolean);
    Procedure SetRefundGlobalref        (Const Value : String);
    Procedure SetIsPOCredit             (Const Value : Boolean);
    Procedure SetEditedFlag             (Const Value : Boolean);
    Procedure SetConNote                (Const Value : String);
    Procedure SetCustPONumber           (Const Value : String);
    Procedure SetLastUpdated            (Const Value : TDateTime);
    Procedure SetApproved               (Const Value : Boolean);
    Procedure SetArea                   (Const Value : String);
    Procedure SetCustField1             (Const VAlue : String);
    Procedure SetCustField2             (Const VAlue : String);
    Procedure SetCustField3             (Const VAlue : String);
    Procedure SetCustField4             (Const VAlue : String);
    Procedure SetCustField5             (Const VAlue : String);
    Procedure SetCustField6             (Const VAlue : String);
    Procedure SetCustField7             (Const VAlue : String);
    Procedure SetCustField8             (Const VAlue : String);
    Procedure SetCustField9             (Const VAlue : String);
    Procedure SetCustField10            (Const VAlue : String);
    procedure SetExpenseClaimEmployee   (const Value : Integer);
    function getShipToCustomer: boolean;
    procedure SetShipToCustomer(const Value: boolean);
    function getShipToDefaultAddress: boolean;
    procedure SetShipToDefaultAddress(const Value: boolean);
    function getShipToClass: boolean;
    procedure SetShipToClass(const Value: boolean);
    Procedure checkforUniqueInvoiceno;
    function getRARef: String;
    function getOrderStatus: String;
    procedure setRARef(const Value: String);
    procedure setOrderStatus(const Value: String);
    function getTotalDiscount: Double;
    procedure setTotalDiscount(const Value: Double);
    function GetOrderCountry: string;
    function GetOrderPostcode: string;
    function GetOrderState: string;
    function GetOrderStreet1: string;
    function GetOrderStreet2: string;
    function GetOrderStreet3: string;
    function GetOrderSuburb: string;
    function GetShipToId: integer;
    procedure SetShipToId(const Value: integer);
    function GetShipCountry: string;
    function GetShipPostcode: string;
    function GetShipState: string;
    function GetShipStreet1: string;
    function GetShipStreet2: string;
    function GetShipStreet3: string;
    function GetShipSuburb: string;
    function GetApproverID: integer;
    procedure SetApproverID(const Value: integer);
    function GetPickUpfromID: integer;
    function GetShiptoClassID: integer;
    procedure SetPickUpfromID(const Value: integer);
    procedure SetShiptoClassID(const Value: integer);
    function getPickupFromDesc: String;
    procedure setPickupFromDesc(const Value: String);
    function getSupplierEmailId: String;

    function GetTypeOfBasedOn   : String;
    function GetFrequencyValues : String;
    function GetCopyStartDate   : TDateTime;
    function GetCopyFinishDate  : TDateTime;

    procedure SetTypeOfBasedOn(Const Value: String);
    procedure SetFrequencyValues(Const Value: String);
    procedure SetCopyStartDate(Const Value: TDateTime);
    procedure SetCopyFinishDate(Const Value: TDateTime);

  protected
    fdTotalForeignAmount:Double;
    Function GetId                      : Integer; Override;
    Function GetDocNumber               : String;  Override;
    Function GetClientName              : String;  Override;
    Function GetSQL                     : String;  Override;
    procedure OnDataIdChange            (Const ChangeType: TBusObjDataChangeType);  Override;
    procedure DoFieldOnChange   (Sender : TField);                  Override;
    procedure CalcTotalsCallback        (Const Sender: TBusObj; var Abort: boolean);Override;
    procedure SetDocNumber              (const Value : String);                     Override;
    procedure SetClientName             (const Value : String);                     Override;
    procedure CheckOrderDate;
    Function  UpdateAccounts             : Boolean;                                  Virtual;
    procedure LineBalanceCallbackProc   (Const Sender: TBusObj; var Abort: Boolean);Virtual;
    procedure AddToPayAuthorisations;
    function getOrderLines: TOrderLineBase;Virtual;
    function GetClient: TClient; override;
    function GetTransName: String;Override;
    function GetTransDate:TDateTime ; Override;
//    Function Approvaltype:String;Virtual;
    Function AmountToApprove:double;virtual;
//    function ValidateApproval: boolean;
    function GetTransStatus: String;Override;
    procedure SetTransStatus(const Value: String);Override;
    Function  DoAfterInsert     (Sender : TDatasetBusObj ):Boolean; Override;
    procedure CalcForeignAmountCallback(const Sender: TBusObj;var Abort: Boolean);
    procedure CalcForeignAmount;Override;
    Procedure GetClientDetails; Override;
    procedure ProcessDeletedLine;Override;
    function getTransLinetotals: TTransLinetotals;override;
  public
    class Function  GetIDField: String; Override;
    class function GetBusObjectTablename: string; Override;
    constructor Create(AOwner: TComponent); Override;
    destructor Destroy; override;
    procedure   CalcOrderTotals; Override;
    procedure   SaveToXMLNode(Const Node: IXMLNode);    Override;
    procedure   LoadFromXMLNode(Const Node: IXMLNode);  Override;
    Function    IsBOInvoiced : boolean  ;               Override;
    Function    ISInvNoUnique:Boolean;
    function    ValidateData: Boolean;                             Override;
//    function ValidateApproval: boolean;virtual;
    property Lines                  : TOrderLineBase Read getOrderLines;
    property Supplier       : TSupplier     Read GetSupplier;
    procedure PopulateMessageSubstituteList(SL: TStringList); override;
    property PurchaseOrderId: Integer       Read GetPurchaseOrderId;
Published
    property OrderDate      : TDateTime     Read GetOrderDate       Write SetOrderDate;
    property SupplierName   : String        Read GetSupplierName    Write SetSupplierName;
    property SupplierId     : Integer       Read GetSupplierId      Write SetSupplierId;

    Property OrderTo	    : String		Read getOrderTo			Write SetOrderTo;
    Property ShipTo	        : String		Read getShipTo			Write SetShipTo;

    property OrderStreet1: string read GetOrderStreet1;
    property OrderStreet2: string read GetOrderStreet2;
    property OrderStreet3: string read GetOrderStreet3;
    property OrderSuburb: string read GetOrderSuburb;
    property OrderState: string read GetOrderState;
    property OrderCountry: string read GetOrderCountry;
    property OrderPostcode:string read GetOrderPostcode;

    property ShipStreet1: string read GetShipStreet1;
    property ShipStreet2: string read GetShipStreet2;
    property ShipStreet3: string read GetShipStreet3;
    property ShipSuburb: string read GetShipSuburb;
    property ShipState: string read GetShipState;
    property ShipCountry: string read GetShipCountry;
    property ShipPostcode:string read GetShipPostcode;

    Property RefNo	        : String		Read getRefNo			Write SetRefNo;
    Property ETADate	    : TDateTime		Read getETADate			Write SetETADate;
    Property SalesComments	: String		Read getSalesComments	Write SetSalesComments;
    Property Shipping	    : String		Read getShipping		Write SetShipping;
    Property ApplyFlag	    : Boolean		Read getApplyFlag		Write SetApplyFlag;
    Property AmountDue	    : Double		Read getAmountDue		Write SetAmountDue;
    Property PayMethod	    : Integer		Read getPayMethod		Write SetPayMethod;
    Property IsPO	        : Boolean		Read getIsPO			Write SetIsPO;
    Property IsRA	        : Boolean		Read getIsRA			Write SetIsRA;
    Property IsBill	        : Boolean		Read getIsBill			Write SetIsBill;
    Property IsCredit	    : Boolean		Read getIsCredit		Write SetIsCredit;
    Property IsCheque	    : Boolean		Read getIsCheque		Write SetIsCheque;
    Property IsRefundCheque : Boolean		Read getIsRefundCheque		Write SetIsRefundCheque;
    Property RefundGlobalref: String		Read getRefundGlobalref		Write SetRefundGlobalref;
    Property IsPOCredit	    : Boolean		Read getIsPOCredit		Write SetIsPOCredit;
    Property EditedFlag	    : Boolean		Read getEditedFlag		Write SetEditedFlag;
    Property ShipToCustomer : boolean   Read getShipToCustomer Write SetShipToCustomer;
    Property ShipToDefaultAddress : boolean   Read getShipToDefaultAddress Write SetShipToDefaultAddress;
    Property ShipToClass : boolean   Read getShipToClass Write SetShipToClass;
    Property ConNote	    : String		Read getConNote			Write SetConNote;
    Property CustPONumber   : String		Read getCustPONumber	Write SetCustPONumber;
    Property LastUpdated	: TDateTime	    Read getLastUpdated		Write SetLastUpdated;
    Property Approved	    : Boolean		Read getApproved		Write SetApproved;
    Property Area         : String read getArea write setArea;
    Property CleanOrderDate : TDateTime     Read getcleanOrderDate;
    Property CleanApproved  : Boolean        Read GetCleanApproved;
//    property CleanPrice     : Double read fCleanPrice write fCleanPrice;
    property Invoiced       : boolean       Read GetInvoiced;
    Property OrgPurchaseOrderNumber	    : String    Read getOrgPurchaseOrderNumber	Write SetOrgPurchaseOrderNumber;
    property SupplierInvoiceNumber      : String    Read GetSupplierInvoiceNumber   Write SetSupplierInvoiceNumber;
    property SupplierInvoiceDate        : TDateTime Read GetSupplierInvoiceDate     Write SetSupplierInvoiceDate;
    property ExpenseClaimEmployee       : Integer   Read GetExpenseClaimEmployee    Write SetExpenseClaimEmployee;
    Property PaysActionAuthorisations   : TPaysActionAuthorisations Read getPaysActions;
    Property RARef :String read getRARef write setRARef;
    Property OrderStatus :String read getOrderStatus write setOrderStatus;
    Property TotalDiscount :Double read getTotalDiscount write setTotalDiscount;
    property ShipToId: integer read GetShipToId write SetShipToId;
    property ApproverID: integer read GetApproverID write SetApproverID;
    property PickUpfromID: integer read GetPickUpfromID write SetPickUpfromID;
    property ShiptoClassID: integer read GetShiptoClassID write SetShiptoClassID;
    Property PickupFromDesc :String read getPickupFromDesc write setPickupFromDesc;
    Property SupplierEmailId :String read getSupplierEmailId;
    Property CustField1:  String    read GetCustField1    write SetCustField1;
    Property CustField2:  String    read GetCustField2    write SetCustField2;
    Property CustField3:  String    read GetCustField3    write SetCustField3;
    Property CustField4:  String    read GetCustField4    write SetCustField4;
    Property CustField5:  String    read GetCustField5    write SetCustField5;
    Property CustField6:  String    read GetCustField6    write SetCustField6;
    Property CustField7:  String    read GetCustField7    write SetCustField7;
    Property CustField8:  String    read GetCustField8    write SetCustField8;
    Property CustField9:  String    read GetCustField9    write SetCustField9;
    Property CustField10: String    read GetCustField10   write SetCustField10;
    Property TypeOfBasedOn      : String    read GetTypeOfBasedOn     write SetTypeOfBasedOn;
    Property FrequenctyValues   : String    read GetFrequencyValues   write SetFrequencyValues;
    Property CopyStartDate      : TDateTime read GetCopyStartDate     write SetCopyStartDate;
    Property CopyFinishDate     : TDateTime read GetCopyFinishDate    write SetCopyFinishDate;
  end;

implementation

uses
  SysUtils, Dialogs, Controls, CommonLib,   MyAccess,ERPdbComponents,
  BusObjStock,tcDataUtils, DateUtils,BusObjConst,
  tcConst,BusObjGeneral, tcTypes,
  DNMLib, AppEnvironment, busobjOrders,
  busobjExpenses,  BusObjRepairs, BusObjApprovals, LogLib,
   ApprovalObj, DbSharedObjectsObj;

const
  DoMsgLogging = true;


procedure DoLog(const msg: String);
begin
  if DoMsgLogging then Log(Msg, 'Debug');
end;


  // -----------------------------------------------------------------------------
  { TOrderLineBase }
  // -----------------------------------------------------------------------------

constructor TOrderLineBase.Create(AOwner: TComponent);
begin
  inherited;
  fFEPOLines := nil;
  fSQL := 'Select * from tblPurchaseLines';
  GetProductDetailsCount:= 0;
  fBusObjectTypeDescription := 'Base Order Line Object';
    FieldsnotToclone :=ExcludeFromclone+','+
                        QuotedStr('ReceivedDate')+',' +
                        QuotedStr('PurchaseOrderID')
end;
procedure TOrderLineBase.GetProductDetails;
var
  fdPrintedValue , aCost: Double;
  SuppProdCode, SuppProdName, suppbarcode: string;
begin
  inherited;
    self.UOMQtyShipped    := 0;
    self.UOMQtySold       := 0;
    self.UOMQtyBackOrder  := 0;
    self.QtyShipped       := 0;
    self.QtySold          := 0;
    self.QtyBackOrder     := 0;
    self.LineClassName    := AppEnv.DefaultClass.DefaultClassName;
    self.LineClassId      := AppEnv.DefaultClass.ClassID;
    SendEvent(BusObjEvent_Change, BusObjEvent_POLineClassChanged, self);

    if Assigned(Owner) then begin
      if Owner is TOrderBase then self.PurchaseOrderId := TOrderBase(Owner).PurchaseOrderId;
    end;
  self.ProductId            := Product.ProductId;
  self.ProductGroup         := Product.ProductGroup;
  self.ProductPrintName     := Product.ProductPrintName;
  self.ProductDescription   := Product.PurchaseDescription;
  self.ProductType          := Product.ProductType;
  self.IncomeAccount        := Product.IncomeAccount;
  self.AssetAccount         := Product.AssetAccount;
  self.CogsAccount          := Product.CogsAccount;
  DiscountPercent :=0;
  DiscountAmount :=0;
  self.Attrib1Purchase      := Product.Attrib1Purchase * self.QtyShipped;
  self.Attrib2Purchase      := Product.Attrib2Purchase * self.QtyShipped;
  self.Attrib1PurchaseRate  := Product.Attrib1PurchaseRate;
  self.Attrib1PurchaseEst   := Product.Attrib1Purchase * self.QtySold;
  self.Attrib2PurchaseEst   := Product.Attrib2Purchase * self.QtySold;
  aCost:= Round(Product.ExtraBuyPrice.GetCostForUOM(
    TOrderBase(Owner).ClientId, UnitOfMeasureID, SuppProdCode, SuppProdName , suppbarcode, fdPrintedValue),RoundPlacesGeneral  );
  if aCost <> 0 then
       OriginalCost             := aCost
  else OriginalCost             := Product.BuyQty1Cost;

  if SuppProdCode <> '' then begin
    self.SupplierProductCode:= SuppProdCode;
    self.SupplierProductName:= SuppProdName;
    self.SupplierBarCode    := SuppBarCode;
  end else begin
    self.SupplierProductCode := Product.SupplierProductCode;
    self.SupplierProductName := '';
    self.SupplierBarCode := '';
  end;
  if self.SupplierBarCode     = '' then self.SupplierBarCode    := Product.barcode;
  Self.PrintedValue := fdPrintedValue;
  if Product.AverageCost > 0 then self.AverageCost := Product.AverageCost
  else self.AverageCost     := Product.BuyQty1Cost;
  if OriginalCost=0 then OriginalCost :=self.AverageCost;
  StandardCost := Product.BuyQty1Cost;
  LineCost:= OriginalCost;
  if Product.TaxCodePurchase <> '' then begin
    self.LineTaxCode        := Product.TaxCodePurchase;
    self.LineTaxRate        := self.Product.TaxPurchase.Rate;
  end else begin
    self.LineTaxCode        := '';
    self.LineTaxRate        := 0;
  end;
  LineCostInc := Round(LineCost * (1 + LineTaxRate),RoundPlacesGeneral);

  if self.UnitOfMeasure = '' then initUOM(Product.UOMPurchases , '');

  if Appenv.CompanyPrefs.PurchaseETAFromProductNormalDeliveryTime then  begin
    self.ETADate:= IncDay(now ,trunc( Product.NormalDeliveryTime));
    if Assigned(Self.Owner) then
      if owner is TPurchaseOrder then
        TPurchaseOrder(Owner).ETAdate :=IncDay(now,trunc(Product.NormalDeliveryTime));
  end;
  if AreaCode = '' then
    if Appenv.CompanyPrefs.PODefaultValueForAreaFrom ='P' then
      if product <> nil then
        Areacode:= Product.Area;
end;

Function TOrderLineBase.CalcBaseLineAmount: Double;
var
  SuppProdCode, SuppProdName,SuppBarCode: string;
  fdPrintedValue:Double;
begin
  result:= Product.ExtraBuyPrice.GetCostForUOM(
    TOrderBase(Owner).ClientId , UnitOfMeasureID,  SuppProdCode, SuppProdName ,SuppBarCode, fdPrintedValue);
  if result = 0 then begin
    Result := Product.GetCostForQty(QtySold);
  end;
  self.SupplierProductCode:= SuppProdCode;
  self.SupplierProductName:= SuppProdName;
  self.SupplierBarCode:= SuppBarCode;
  Self.PrintedValue := fdPrintedValue;
end;

procedure TOrderLineBase.CalcLineTotals;
begin
    if self.Id = 0 then
      exit;
    TotalLineAmount     := Round(LineCost * QtyShipped, CurrencyRoundPlaces);
    TotalLineAmountInc  := Round(LineCostInc * QtyShipped, CurrencyRoundPlaces);
    LineTaxTotal        := TotalLineAmountInc - TotalLineAmount;

    if (Self is TPurchaseOrderLine) or (Self is TReturnAuthorityLine) then begin
        Attrib1Purchase       := Product.Attrib1Purchase * self.QtyShipped;
        Attrib2Purchase       := Product.Attrib2Purchase * self.QtyShipped;
        Attrib1PurchaseRate   := Product.Attrib1PurchaseRate;
        Attrib1PurchaseEst    := Product.Attrib1Purchase * self.QtySold;
        Attrib2PurchaseEst    := Product.Attrib2Purchase * self.QtySold;
    end;
    inherited;
end;

procedure TOrderLineBase.CalcLineCostFromTotal;
var
  oldLinecost : Double;
  OldOriginalcost:Double;
begin
    oldLinecost       :=Linecost;
    OldOriginalcost:= OriginalCost;
    if QtyShipped > 0 then begin
        LineCost          := Round(TotalLineAmount   / QtyShipped, RoundPlacesGeneral);
        LineCostInc       := Round(TotalLineAmountInc/ QtyShipped, RoundPlacesGeneral);
    End;
    if DiscountPercent= 0 then OriginalCost:= LineCost
    else OriginalCost:= GetAmountInc(LineCost, discountPercent);

    if (oldLinecost <> LineCost) or (OldOriginalcost <> OriginalCost) then begin
        if (not SilentMode) and (not AppEnv.CompanyPrefs.DisableAltSaveCost) then begin
            if (oldLinecost <> LineCost) or (OldOriginalcost <> OriginalCost) then begin
              if self.Product.CostUpdateFromPurchase then
                DoDelayObjectProcedure(UpdateProductBuyCostFromLineCost,10);
            end;
        end;
    end;
end;

Function TOrderLineBase.Getalloctype: String;
begin
    result := 'IN';
end;

procedure TOrderLineBase.UpdateProductBuyCostFromLineCost;
var
  msg: String;
  ReadOnlySave: boolean;
  DlgResult: integer;

  function PriceUpdateNote:string;
  begin
    
    result:=
      'Existing Cost: ' + FloatToStrF(Product.BuyQty1Cost, ffCurrency, 15, CurrencyRoundPlaces) +
      '  New Cost: ' + FloatToStrF(LineCost, ffCurrency, 15, CurrencyRoundPlaces) + NL + NL +
      'Note : If the supplier selected is the Product''s Preferred Supplier, It''s Main cost will be updated and the Buy Quantity''s will all be set back to 1.' + NL +  NL+
      'When Product has a different Preferred supplier or the Preferred supplier is not selected, an Extra Buy price will be added for the product for the selected supplier and Unit of measure combination'
  end;

begin
  if SilentMode or IsCreatingBORec then Exit;
  {22/04/2014 Dene asked for change to update product buy prices even if it is
              a foreign purchase (for client Protserv) }
//  if TPurchaseOrder(Owner).ForeignExchangeCode <> appenv.RegionalOptions.ForeignExDefault then Exit; // add to the foreign exchange rate
  if GetProductDetailsCount > 0 then exit;

  if Product.Lock then begin
    try
      //if TempData.StringExists('CostsUpdateResponce') then begin
        if TempData.StringExists('CostsUpdateResponce')  and (TempData.S['CostsUpdateResponce'] = 'All') then  begin
          { don't ask the question, just update the cost }
        end else if TempData.StringExists('CostsUpdateResponce')  and (TempData.S['CostsUpdateResponce'] = 'None') then  begin
          { don't update }
          exit;
        end else begin
          DlgResult:= CommonLib.MessageDlgXP_Vista('Do you wish to Alter the Saved Cost for product ' +
            Product.ProductName + '?' +NL+NL +
            PriceupdateNote , mtConfirmation, [mbYes, mbNo, mbYesToAll, mbNoToAll], 0);
          case DlgResult of
            mrYes:;
            mrNo: exit;
            101: {mrYesToAll}
              begin
                TempData.S['CostsUpdateResponce']:= 'All';
              end;
            100: {mrNoToAll}
              begin
                TempData.S['CostsUpdateResponce']:= 'None';
                exit;
              end;
          end;
        end;
      ReadOnlySave:= Product.IsReadonly;
      with Product do try
        IsReadonly:= false;
        if (Assigned(PreferedSupplier) and  (SupplierId = PreferedSupplier.ID))  then begin
          BuyQty1 := 1;
          BuyQty2 := 1;
          BuyQty3 := 1;
          BuyQty1Cost := LineCost;
          BuyQty2Cost := LineCost;
          BuyQty3Cost := LineCost;
        end else if  (BuyQty1Cost =0) and (BuyQty2Cost =0) and (BuyQty3Cost =0) then begin
          BuyQty1 := 1;
          BuyQty2 := 1;
          BuyQty3 := 1;
          BuyQty1Cost := LineCost;
          BuyQty2Cost := LineCost;
          BuyQty3Cost := LineCost;
        end else begin
          {update extra buy prices}
          if ExtraBuyPrice.LocateSupplier(SupplierId, UnitOfMeasureID, True) then begin
             ExtraBuyPrice.BuyQty1Price:= LineCost;
              {only update next 2 if user has not changed qty breaks}
             ExtraBuyPrice.PostDb;
          end;
        end;
        Save;
      finally
        IsReadonly:= ReadOnlySave;
      end;
    finally
      Product.UnLock;
    end;
  end else begin
    msg := 'Unable to update ' + Product.ProductName + '''s cost record as product is being updated by "' +
      Product.UserLock.LockInfo.UserName + '" with: ' + Product.UserLock.LockInfo.LockingForm;
      ResultStatus.AddItem(true, rssWarning, 1, msg );
  end;
end;
procedure TOrderLineBase.DoFieldOnChange(Sender: TField);
var
  fdlinecost, fdforeigncost:Double;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
            if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.

   if (self.PurchaseLineId < 1) and ((self.ProductId > 0) or (self.ProductName <> '')) then
      InitializeNewObject;

  inherited;
  if (Sysutils.SameText(Sender.FieldName , 'DiscountPercent')) then begin
    ApplyDiscount;
   end else if (Sysutils.SameText(Sender.FieldName , 'CustomerJob')) or
      (Sysutils.SameText(Sender.FieldName , 'CustomerJobID')) then begin
      if Sysutils.SameText(Sender.FieldName , 'CustomerJob') then
        CustomerJobID:= TCustomer.IDToggle(Sender.AsString, Connection.Connection)
      else
        CustomerJob:= TCustomer.IDToggle(Sender.AsInteger, Connection.Connection);
      if CustomerJobID >0 then begin
        CustomerPrintJob := CustomerJobObj.PrintName;
        if Assigned(Self.Owner) then
          if Self.Owner is TPurchaseOrder then
            if TPurchaseOrder(Self.Owner).ShiptoCustomer then begin
              TPurchaseOrder(Self.Owner).Shipto   := CustomerJobobj.ShipToAddress;
              TPurchaseOrder(Self.Owner).ShipToId := 0;
            end;
      end;
   end else if Sysutils.SameText(Sender.FieldName , 'ProductID') then begin
     if Self.ProductId <> 0 then begin
        ProductNAme := tcDataUtils.GetProduct(Self.ProductID);
        self.ProductPrintName     := Product.ProductPrintName;
        PostDB;
        if ProductChanged then Exit;
        If (CleanProductId = ProductId) And (CleanProductId <> 0) Then  Exit;
        GetProductDetails;
        CalcLineTotals;
        PostDB;
        if Assigned(Owner) and (Owner is TOrderBase) then TOrderBase(Owner).DoCalcOrderTotals;
        self.UOMMultiplier := tcDatautils.getUnitMultiplier(self.UnitOfMeasureID);
        AddEvent(BusObjEvent_Change, BusObjEventVal_ProductChanged, Self.ID);
    end;
  end else if Sysutils.SameText(Sender.fieldname,'EmployeeName') then begin
        EmployeeId := tcdatautils.GetEmployeeID(EmployeEName);
  end else if Sysutils.SameText(Sender.FieldName , 'Class') then begin
    LineClassId := TcDatautils.GetDeptID(LineClassName);
  end else if Sysutils.SameText(Sender.FieldName , 'ClassID') then begin
    LineClassName := TcDatautils.GetClassName(LineclassId);
  end else if Sysutils.SameText(Sender.FieldName , 'ProductName') then begin
    if Sender.AsString = '' then exit;
    PostDb;
    ProductId := tcDataUtils.GetProduct(Self.ProductName);
    DoFieldOnChange(Dataset.findfield('ProductId'));

  end else if Sysutils.SameText(Sender.FieldName, 'LineCost') then begin
//    LineCostInc := 0; // fore re-calc of inc price in CalcLineTotals
    self.Originalcost     := self.linecost;
    self.DiscountAmount   := 0;
    self.DiscountPercent  := 0;

    LineCostInc           := Round(LineCost * (1 + LineTaxRate),RoundPlacesGeneral);
    CalcLineTotals;
    if Assigned(Owner) and (Owner is TOrderBase) then TOrderBase(Owner).DoCalcOrderTotals;
  end else if Sysutils.SameText(Sender.FieldName , 'LineCostInc') then begin
    Linecost              := Round((LineCostInc / (100 + (LineTaxRate * 100))) * 100, RoundPLacesGeneral);
    CalcLineTotals;
    if Assigned(Owner) and (Owner is TOrderBase) then TOrderBase(Owner).DoCalcOrderTotals;
  end else if Sysutils.SameText(Sender.FieldName ,'AvgCost') then begin
  end else if Sysutils.SameText(Sender.FieldName , 'LineTaxCode') then begin
//    LineTaxRate := tcDataUtils.GetTaxRateForCode(LineTaxCode);
    LineTaxRate           := Self.TaxCode.Rate;
//    LineCostInc := 0; // to force re-calculation
    LineCostInc           := Round(LineCost * (1 + LineTaxRate),RoundPlacesGeneral);
    CalcLineTotals;
    if Assigned(Owner) and (Owner is TOrderBase) then TOrderBase(Owner).DoCalcOrderTotals;
  end else if Sysutils.SameText(Sender.FieldName , 'LineTaxRate') then begin
  end else if Sysutils.SameText(Sender.FieldName , 'LineTax') then begin
  end else if Sysutils.SameText(Sender.FieldName , 'UnitofMeasurePOLines') then begin
    initUOM(Sender);
  end else if Sysutils.SameText(Sender.FieldName , 'UnitOfMeasureMultiplier') then begin
  end else if Sysutils.SameText(Sender.FieldName , 'QtySold') then begin
          UOMQtySold:= Round(DivZer(QtySold, UOMMultiplier), RoundPlacesGeneral);
          QtyBackOrder    := Round(QtySold - QtyShipped, RoundPlacesGeneral);
          UOMQtyBackOrder := Round(DivZer(QtyBackOrder, UOMMultiplier), RoundPLacesGeneral);
          DoFieldOnChange(dataset.findfield('UnitofMeasureQtySold'));
  end else if Sysutils.SameText(Sender.FieldName , 'UnitofMeasureQtySold') then begin
//    AddEvent(BusObjEvent_Change, BusObjEvent_PromptBarCode, Self.ID);
    fdLineCost := linecost; fdforeigncost := ForeignLineCost;
    try
      QtySold := CommonLib.Round(UOMQtySold * UOMMultiplier, self.RoundPlacesGeneral);
      if UOMQtyShipped <> 0 then begin
        if UOMQtyShipped <= UOMQtySold then begin
          if QtyShipped <> CommonLib.Round(UOMQtyShipped * UOMMultiplier, self.RoundPlacesGeneral) then begin
              QtyShipped := CommonLib.Round(UOMQtyShipped * UOMMultiplier, self.RoundPlacesGeneral);
              AddEvent(BusObjEvent_Change, BusObjEventVal_QtyShipped, Self.ID);
          end;
        end;
      end else QtyShipped := 0;

      // calc new back order qty
      QtyBackOrder    := CommonLib.Round(QtySold - QtyShipped, self.RoundPlacesGeneral);
      UOMQtyBackOrder := CommonLib.Round(QtyBackOrder / UOMMultiplier, self.RoundPlacesGeneral);

      // look up new cost based on new quantity
      OriginalCost := Round(self.CalcBaseLineAmount,RoundPlacesGeneral);
      Linecost := GetAmountEx(OriginalCost,DiscountPercent/100);
  //    LineCostInc := 0; // force recalculation of inc cost
      LineCostInc := Round(LineCost * (1 + LineTaxRate),RoundPlacesGeneral);

      // re calc totals
      CalcLineTotals;
      if Assigned(Owner) and (Owner is TOrderBase) then TOrderBase(Owner).DoCalcOrderTotals;
    finally
      if (fdLineCost <> linecost) or (fdforeigncost <>ForeignLineCost) then
        AddEvent(BusObjEvent_Change, BusObjEvent_CostRecalculateonQtychange, self.id);
    end;
  end else if Sysutils.SameText(Sender.FieldName , 'Shipped') then begin
    if QtySold< Qtyshipped then Qtyshipped := Qtysold;
    UOMQtyShipped:= Round(DivZer(QtyShipped, UOMMultiplier), RoundPlacesGeneral);
    DoFieldOnChange(dataset.findfield('UnitofMeasureShipped'));
  end else if Sysutils.SameText(Sender.FieldName , 'UnitofMeasureShipped') then begin
    QtyShipped := CommonLib.Round(UOMQtyShipped * UOMMultiplier, self.RoundPlacesGeneral);
    QtyBackOrder    := CommonLib.Round(QtySold - QtyShipped, self.RoundPlacesGeneral);// calc new back order qty
    UOMQtyBackOrder := CommonLib.Round(QtyBackOrder / UOMMultiplier, self.RoundPlacesGeneral);
    NullWhenDateIs0 := True;
    if (QtyShipped <> 0) then
      if ReceivedDate  =0 then
        ReceivedDate    := Now
      else if EmployeeHasAccess('FnCanChangeReceiveDate') then ReceivedDate    := Now
    else if EmployeeHasAccess('FnCanChangeReceiveDate')  then ReceivedDate    := 0;

    AddEvent(BusObjEvent_Change, BusObjEventVal_QtyShipped, Self.ID);
    AddEvent(BusObjEvent_Change, BusObjEvent_PromptBarCode, Self.ID);
    // re calc totals
    CalcLineTotals;
    if Assigned(Owner) and (Owner is TOrderBase) then TOrderBase(Owner).doCalcOrderTotals;

    //call event processing on PO form
    self.CallSavedFieldEvent(Dataset.FieldByName('Shipped'), OnChange);

    // do this if this is  OrderLineBase also in ExpenseLineBase
    Invoiced := QtyShipped <> 0;
    DoFieldOnChange(Dataset.findfield('ReceivedDate'));
  end else if Sysutils.SameText(Sender.FieldName , 'ReceivedDate') then begin
    if ReceivedDate <> 0 then CheckReceivedDate;
  end else if Sysutils.SameText(Sender.FieldName , 'BackOrder') then begin
  end else if Sysutils.SameText(Sender.FieldName , 'UnitOfMeasureBackOrder') then begin
  end else if Sysutils.SameText(Sender.FieldName , 'ForeignExchangeRate') then begin
  end else if Sysutils.SameText(Sender.FieldName , 'ForeignCurrencyLineCost') then begin
  end else if Sysutils.SameText(Sender.FieldName , 'ForeignExchangeCode') then begin
  end else if Sysutils.SameText(Sender.FieldName , 'Attrib1Purchase') then begin
    if Attrib1Purchase < 0 then Attrib1Purchase := Attrib1Purchase * -1;
  end else if Sysutils.SameText(Sender.FieldName , 'Attrib2Purchase') then begin
    if Attrib2Purchase < 0 then Attrib2Purchase := Attrib2Purchase * -1;
  end else if Sysutils.SameText(Sender.FieldName , 'Attrib1PurchaseEst') then begin
    if Attrib1PurchaseEst < 0 then Attrib1PurchaseEst := Attrib1PurchaseEst * -1;
  end else if Sysutils.SameText(Sender.FieldName , 'Attrib2PurchaseEst') then begin
    if Attrib2PurchaseEst < 0 then Attrib2PurchaseEst := Attrib2PurchaseEst * -1;
  end else if Sysutils.SameText(Sender.FieldName , 'TotalLineAmount') then begin
    TotalLineAmountInc := Round(TotalLineAmount * (1 + LineTaxRate), CurrencyRoundPlaces);
    LineTaxTotal       := TotalLineAmountInc - TotalLineAmount;

    CalcLineCostFromTotal;
    if Assigned(Owner) and (Owner is TOrderBase) then TOrderBase(Owner).DoCalcOrderTotals;
  end else if Sysutils.SameText(Sender.FieldName , 'TotalLineAmountInc') then begin
    TotalLineAmount := TotalLineAmountInc / (1 + LineTaxRate);
    LineTaxTotal    := TotalLineAmountInc - TotalLineAmount;

    CalcLineCostFromTotal;
    if Assigned(Owner) and (Owner is TOrderBase) then TOrderBase(Owner).DoCalcOrderTotals;
  end
  else if Sysutils.SameText(Sender.FieldName , 'AccountNumber') then begin
    if (Trim(Sender.AsString) <> '') then begin
      AccountName:= TAccount.AccountNameForNumber(Sender.AsString,self.Connection.Connection);
      if AccountName = '' then
        AccountNumber:= '';
    end
    else begin
//      AccountName:= '';
      AccountNumber:= '';
    end;
  end
  else if Sysutils.SameText(Sender.FieldName , 'AccountName') then begin
    if (Sender.AsString = '') or (TAccount.IDToggle(Sender.AsString,self.Connection.Connection) = 0) then begin
//      AccountName:= '';
      AccountNumber:= ''
    end
    else begin
      AccountNumber:= TAccount.AccountNumberForName(Sender.AsString,Connection.Connection);
    end;
  end;
  //@@if AppEnv.CompanyPrefs.UseApprovalLevels then

//  if Assigned(Owner) and (Self.Owner is TPurchaseOrder) then begin
//    { only do  }
//    if not ((Sender is TWideMemoField) or (Sender is TWideStringField)) then begin
//      { only do this if we have a product else this will cause the line to be deleted .. }
//      if ProductID > 0 then
//        //TPurchaseOrder(Self.Owner).Validateapproval;
//        TApprovalCheck.Approved(TPurchaseOrder(self.Owner));
//    end;
//  end;
end;
procedure TOrderLineBase.CheckREceivedDate;
begin
try
  if cleanREceivedDate = ReceivedDate then Exit;
Except

end;

    if (REceivedDate <= AppEnv.CompanyPrefs.ClosingDate) then begin
      ResultStatus.AddItem(False, rssWarning , 0 , 'You Have Set This Date Before The Closing Date !' + #13 + #10 + '' + #13 + #10 +
        'The Date Will Automatically be Set To Today''s Date ' + #13 + #10 + '' + #13 + #10 + 'OR' + #13 +
        #10 + '' + #13 + #10 + 'Reset The Closing Date In Preferences.');
      REceivedDate:= Now;
    end else if (REceivedDate <= AppEnv.CompanyPrefs.ClosingDateAP) then begin
      ResultStatus.AddItem(False, rssWarning , 0 , 'You Have Set This Date Before The Closing Date !' + #13 + #10 + '' + #13 +
        #10 + 'The Date Will Automatically be Set To Today''s Date ' + #13 + #10 + '' + #13 + #10 + 'OR' +
        #13 + #10 + '' + #13 + #10 + 'Reset The Closing Date In Preferences.');
      REceivedDate := Now;
    end;
end;

function TOrderLineBase.DoNewRecord(Sender: TDatasetBusObj): Boolean;
var
    iPurchaseOrderID :Integer;
    strSQL:String;
begin
  inherited;
  REsult := True;
  if not assigned(self.Owner) then Exit;
  if not (self.Owner is TOrderBase) then Exit;
  if not Eof then begin
    iPurchaseOrderID := TOrderBase(Self.Owner).ID;
    strSQL:= 'update tblPurchaseLines '+
                ' set SortID = SortId + 10 where PurchaseOrderID = ' + IntToStr(iPurchaseOrderID) +
                ' and SortId >= ' + IntToStr(fiSortID)+';' +
             'update tblPurchaseLines '+
                ' set LinesOrder = LinesOrder + 10 where PurchaseOrderID = ' + IntToStr(iPurchaseOrderID) +
                ' and LinesOrder >= ' + IntToStr(fiLinesOrder)+';' ;
    getNewDataset(strSQL, True);
  End else begin
    fiSortId := fiSortId + 10;
    fiLinesOrder := fiLinesOrder + 10;
  end;
  if fiSortId = 0 then fiSortId := fiSortId + 10;
  if fiLinesOrder = 0 then fiLinesOrder := fiLinesOrder + 10;
end;

Function TOrderLineBase.DoAfterDelete(Sender :TDatasetBusObj ):Boolean;
begin
  inherited DoAfterDelete(Sender );
  if Assigned(Owner) and (Owner is TOrderBase) then TOrderBase(Owner).DoCalcOrderTotals;
  Result := true;
end;

procedure TOrderLineBase.FlagAsUpdated(aTimeStamp: TDateTime = 0);
begin
  inherited;
  SeTDateTimeField('LastUpdated', Now);
end;
Function TOrderLineBase.GetCustomerJobobj:TClient;
begin
    result := TClient(getContainerComponent(TClient , 'clientId = ' + IntToStr(CustomerjobID)));
end;
function TOrderLineBase.GetLineGLAccount: TAccount;
begin
    Result := TAccount(Getcontainercomponent(TAccount , 'AccountName = ' +quotedStr(StringDataForSQL(AccountName))));
end;
function TOrderLineBase.getLineClass: TDeptClass;
begin
  Result := TDeptClass(Getcontainercomponent(TDeptClass , 'classid = ' +inttostr(lineclassId)));
end;

Function	TOrderLineBase.GetPurchaseLineId	        : Integer;	begin	Result := GetIntegerField('PurchaseLineId');	End;
Function	TOrderLineBase.GetPurchaseOrderId	        : Integer;	begin	Result := GetIntegerField('PurchaseOrderId');	End;
Function	TOrderLineBase.GetPartSpecID	            : Integer;	begin	Result := GetIntegerField('PartSpecID');	End;
Function	TOrderLineBase.GetUnitLandedCost	        : Double;	begin	Result := GetFloatField('LandedCostsPerItem');	End;
Function	TOrderLineBase.GetTotalOrderLandedCost	    : Double;	begin	Result := GetFloatField('LandedCostsTotal');	End;
Function	TOrderLineBase.GetTotalLineLandedCostPerc	: Double;	begin	Result := GetFloatField('LandedCostsPercentage');	End;
Function	TOrderLineBase.GetOriginalQtyOrdered     	: Double;	begin	Result := GetFloatField('OriginalQtyOrdered');	End;
Function	TOrderLineBase.GetSpecDescription	        : String;	begin	Result := GetStringField('SpecDescription');	End;
Function	TOrderLineBase.GetSpecValue	                : Double;	begin	Result := GetFloatField('SpecValue');	End;
Function	TOrderLineBase.GetForeignExchangeRate	    : Double;	begin	Result := GetFloatField('ForeignExchangeRate');	End;
Function	TOrderLineBase.GetId	                    : Integer;	begin	Result := PurchaseLineId;	End;
Function	TOrderLineBase.GetUnitOfMeasure	            : String;	begin	Result := GetStringField('UnitOfMeasurePOLines');	End;
Function	TOrderLineBase.GetUnitOfMeasureID	        : Integer;	begin	Result := GetIntegerField('UnitOfMeasureID');	End;
Function	TOrderLineBase.GetAttrib1Purchase	        : Double;	begin	Result := GetFloatField('Attrib1Purchase');	End;
Function	TOrderLineBase.GetAttrib1PurchaseRate	    : Double;	begin	Result := GetFloatField('Attrib1PurchaseRate');	End;
Function	TOrderLineBase.GetAttrib2Purchase	        : Double;	begin	Result := GetFloatField('Attrib2Purchase');	End;
Function	TOrderLineBase.GetAttrib1PurchaseEst      : Double;	begin	Result := GetFloatField('Attrib1PurchaseEst');	End;
Function	TOrderLineBase.GetAttrib2PurchaseEst      : Double;	begin	Result := GetFloatField('Attrib2PurchaseEst');	End;
Function	TOrderLineBase.GetAccountNumber	            : String;	begin	Result := GetStringField('AccountNumber');	End;
Function	TOrderLineBase.GetAccountName	            : String;	begin	Result := GetStringField('AccountName');	End;
Function	TOrderLineBase.GetAccountGroup	            : String;	begin	Result := GetStringField('AccountGroup');	End;
Function	TOrderLineBase.GetCustomerJob	            : String;	begin	Result := GetStringField('CustomerJob');	End;
Function	TOrderLineBase.GetCustomerPrintJob        : String;	begin	Result := GetStringField('CustomerPrintJob');	End;
Function	TOrderLineBase.GetCustomerJobID	            : Integer;	begin	Result := GetIntegerField('CustomerJobID');	End;
Function	TOrderLineBase.GetRAQty	                    : Double;	begin	Result := GetFloatField('RAQty');	End;
Function	TOrderLineBase.GetRAstatus	                : String;	begin	Result := GetStringField('RAstatus');	End;
Function	TOrderLineBase.GetBatch	                    : String;	begin	Result := GetStringField('Batch');	End;
Function	TOrderLineBase.GetUseTimecost	            : Boolean;	begin	Result := GetBooleanField('UseTimecost');	End;
Function	TOrderLineBase.GetSaleID_Timecost	        : Integer;	begin	Result := GetIntegerField('SaleID_Timecost');	End;
Function	TOrderLineBase.GetTimecostMarkupPer	        : Double;	begin	Result := GetFloatField('TimecostMarkupPer');	End;
Function	TOrderLineBase.GetTimecostPrice	            : Double;	begin	Result := GetFloatField('TimecostPrice');	End;
Function	TOrderLineBase.GetTimecostMarkupDol	        : Double;	begin	Result := GetFloatField('TimecostMarkupDol');	End;
Function	TOrderLineBase.GetCOGSTotalLineAmount	    : Double;	begin	Result := GetFloatField('COGSTotalLineAmount');	End;
Function	TOrderLineBase.GetCOGSTotalLineAmountInc	: Double;	begin	Result := GetFloatField('COGSTotalLineAmountInc');	End;
Function	TOrderLineBase.GetEditedFlag	            : Boolean;	begin	Result := GetBooleanField('EditedFlag');	End;
Function	TOrderLineBase.GetRAInvoiceNo	            : String;	begin	Result := GetStringField('RAInvoiceNo');	End;
Function	TOrderLineBase.GetLastLineID	            : Integer;	begin	Result := GetIntegerField('LastLineID');	End;
Function	TOrderLineBase.GetRelatedPOIDUsed	        : Boolean;	begin	Result := GetBooleanField('RelatedPOIDUsed');	End;
Function	TOrderLineBase.GetRelatedPOID	            : Integer;	begin	Result := GetIntegerField('RelatedPOID');	End;
Function	TOrderLineBase.GetDocketNumber	          : String;	begin	Result := GetStringField('DocketNumber');	End;
Function	TOrderLineBase.GetNewForeignExchangeRate	: Double;	begin	Result := GetFloatField('NewForeignExchangeRate');	End;
Function	TOrderLineBase.GetETADate	                : TDateTime;begin	Result := GeTDateTimefield('ETADate');	End;
Function	TOrderLineBase.GetCustomField1              : String;	begin	Result := GetStringField('CustomField1');	End;
Function	TOrderLineBase.GetCustomField2              : String;	begin	Result := GetStringField('CustomField2');	End;
Function	TOrderLineBase.GetCustomField3              : String;	begin	Result := GetStringField('CustomField3');	End;
Function	TOrderLineBase.GetCustomField4              : String;	begin	Result := GetStringField('CustomField4');	End;
Function	TOrderLineBase.GetCustomField5              : String;	begin	Result := GetStringField('CustomField5');	End;
Function	TOrderLineBase.GetCustomField6              : String;	begin	Result := GetStringField('CustomField6');	End;
Function	TOrderLineBase.GetCustomField7              : String;	begin	Result := GetStringField('CustomField7');	End;
Function	TOrderLineBase.GetCustomField8              : String;	begin	Result := GetStringField('CustomField8');	End;
Function	TOrderLineBase.GetCustomField9              : String;	begin	Result := GetStringField('CustomField9');	End;
Function	TOrderLineBase.GetCustomField10             : String;	begin	Result := GetStringField('CustomField10');	End;
Function	TOrderLineBase.GetINCOMEACCNTID             : Integer;	begin	Result := GetIntegerField('INCOMEACCNTID');	End;
Function	TOrderLineBase.GetAssetAccntId              : Integer;	begin	Result := GetIntegerField('AssetAccntId');	End;
Function	TOrderLineBase.GetCogsAccntId               : Integer;	begin	Result := GetIntegerField('CogsAccntId');	End;
Function	TOrderLineBase.GetAverageCost               : Double;	begin	Result := GetFloatField('AvgCost');	End;
Function	TOrderLineBase.GetLineClassId               : Integer;	begin	Result := GetIntegerField('ClassId');	End;
Function	TOrderLineBase.GetLineClassName             : String;	begin	Result := GetStringField('Class');	End;
Function	TOrderLineBase.GetReceivedDate              : TDateTime;begin	Result := GeTDateTimeField('ReceivedDate');	End;
Function	TOrderLineBase.GetForeignExchangeCode       : String;	begin	Result := GetStringField('ForeignExchangeCode');	End;
Function TOrderLineBase.GetForeignLineCost            : Double;   begin   Result := GetFloatField('ForeignCurrencyLineCost');end;
function TOrderLineBase.GetForeignUOMLineCost         : double;   begin  result := self.ForeignLineCost * self.UOMMultiplier;end;
Function TOrderLineBase.GetClassID                   : Integer;  begin   Result := LineClassId;end;
Function TOrderLineBase.GetSerialnos                 : String;   begin   Result := GetStringField('SerialNo');end;
function TOrderLineBase.getSmartOrderID: Integer;begin  REsult := GetIntegerField('SmartOrderID');end;
function TOrderLineBase.getEmployeeID: Integer;begin  REsult := GetIntegerField('EmployeeID');end;
function TOrderLineBase.getSmartOrderLineID: Integer;begin  REsult := GetIntegerField('SmartOrderLineID');end;
Function    TOrderLineBase.GetCleanClassID              : Integer;  begin  REsult := GetXMLNodeIntegerValue(Self.CleanXMLNOde, 'Lineclassid' );end;
Function    TOrderLineBase.GetCleanProductId            : Integer;  begin  Result := GetXMLNodeIntegerValue(CleanXMLNode,      'Productid'   );end;
function    TOrderLineBase.getCleanLinecost             : double;   begin  Result  := GetXMLNodeFloatValue(Self.CleanXMLNOde,   'Linecost'    );end;
Function    TOrderLineBase.getcleanReceivedDate         : TDatetime;begin  result := GetXMLNodeDateTimeValue(Self.CleanXMLNOde,   'ReceivedDate'); end;
Function    TOrderLineBase.getCleanRepairId             : Integer;  begin  Result  := GetXMLNodeIntegerValue(Self.CleanXMLNOde, 'RepairId'    );end;
Function    TOrderLineBase.GetcleanQtyTotal             : Double;   begin  Result  := GetXMLNodeFloatValue(Self.CleanXMLNOde,   'QtySold'    );end;
Function    TOrderLineBase.GetCleanQty                  : Double;   begin  Result  := GetXMLNodeFloatValue(Self.CleanXMLNOde,   'Qtyshipped'    );end;
Function    TOrderLineBase.GetSaleLineID                : Integer;  begin  Result := GetIntegerField('SaleLineID');	End;
procedure TOrderLineBase.SetUnitLandedCost(const Value : Double);         begin SetFloatField('LandedCostsPerItem', Value);     end;
procedure TOrderLineBase.SetTotalOrderLandedCost(const Value : Double);begin  SetFloatField('LandedCostsTotal', Value);end;
procedure TOrderLineBase.SetTotalLineLandedCostPerc(const Value : Double);begin SetFloatField('LandedCostsPercentage', Value);  end;
procedure TOrderLineBase.SetOriginalQtyOrdered     (const Value : Double);begin SetFloatField('OriginalQtyOrdered', Value);  end;
procedure TOrderLineBase.SetPartSpecID(const Value : Integer);            begin SetIntegerField('PartSpecID', Value);           end;
procedure TOrderLineBase.SetSpecDescription(const Value : String);        begin SetStringField('SpecDescription', Value);       end;
procedure TOrderLineBase.SetSpecValue(const Value : Double);              begin SetFloatField('SpecValue', Value);              end;
procedure TOrderLineBase.SetPurchaseOrderId(const Value : Integer);       begin SetIntegerField('PurchaseOrderId', Value);      end;
procedure TOrderLineBase.SetUnitOfMeasure(const Value : String);          begin SetStringField('UnitOfMeasurePOLines', Value);  end;
procedure TOrderLineBase.SetUnitOfMeasureID(const Value : Integer);       begin SetIntegerField('UnitOfMeasureID', Value);      end;
procedure TOrderLineBase.SetForeignExchangeRate(const Value : Double);    begin SetFloatField('ForeignExchangeRate', Value);    end;
Procedure TOrderLineBase.SetAccountNumber(Const Value :String);           begin SetStringField('AccountNumber', Value);         End;
Procedure TOrderLineBase.SetAccountName(Const Value :String);             begin SetStringField('AccountName', Value);           End;
Procedure TOrderLineBase.SetAccountGroup(Const Value :String);            begin SetStringField('AccountGroup', Value);          End;
Procedure TOrderLineBase.SetCustomerJob(Const Value :String);             begin SetStringField('CustomerJob', Value);           End;
Procedure TOrderLineBase.SetCustomerPrintJob(Const Value :String);        begin SetStringField('CustomerPrintJob', Value);      End;
Procedure TOrderLineBase.SetCustomerJobID(Const Value :Integer);		  begin SetIntegerField('CustomerJobID', Value);        End;
Procedure TOrderLineBase.SetRAQty(Const Value :Double);                   begin SetFloatField('RAQty', Value);                  End;
Procedure TOrderLineBase.SetRAstatus(Const Value :String);				  begin SetStringField('RAstatus', Value);              End;
Procedure TOrderLineBase.SetBatch(Const Value :String);                   begin SetStringField('Batch', Value);                 End;
Procedure TOrderLineBase.SetUseTimecost(Const Value :Boolean);            begin SetBooleanField('UseTimecost', Value);          End;
Procedure TOrderLineBase.SetSaleID_Timecost(Const Value :Integer);        begin SetIntegerField('SaleID_Timecost', Value);      End;
Procedure TOrderLineBase.SetTimecostMarkupPer(Const Value :Double);		  begin SetFloatField('TimecostMarkupPer', Value);      End;
Procedure TOrderLineBase.SetTimecostPrice(Const Value :Double);			  begin SetFloatField('TimecostPrice', Value);          End;
Procedure TOrderLineBase.SetTimecostMarkupDol(Const Value :Double);		  begin SetFloatField('TimecostMarkupDol', Value);      End;
Procedure TOrderLineBase.SetCOGSTotalLineAmount(Const Value :Double);	  begin SetFloatField('COGSTotalLineAmount', Value);    End;
Procedure TOrderLineBase.SetCOGSTotalLineAmountInc(Const Value :Double);  begin SetFloatField('COGSTotalLineAmountInc', Value); End;
Procedure TOrderLineBase.SetEditedFlag(Const Value :Boolean);             begin SetBooleanField('EditedFlag', Value);           End;
Procedure TOrderLineBase.SetRAInvoiceNo(Const Value :String);			  begin SetStringField('RAInvoiceNo', Value);           End;
Procedure TOrderLineBase.SetLastLineID(Const Value :Integer);			  begin SetIntegerField('LastLineID', Value);           End;
Procedure TOrderLineBase.SetRelatedPOIDUsed(Const Value :Boolean);		  begin SetBooleanField('RelatedPOIDUsed', Value);      End;
Procedure TOrderLineBase.SetRelatedPOID(Const Value :Integer);            begin SetIntegerField('RelatedPOID', Value);          End;
Procedure TOrderLineBase.SetDocketNumber(Const Value :String);			  begin SetStringField('DocketNumber', Value);          End;
Procedure TOrderLineBase.SetNewForeignExchangeRate(Const Value :Double);  begin SetFloatField('NewForeignExchangeRate', Value); End;
Procedure TOrderLineBase.SetETADate(Const Value :TDateTime);			  begin SeTDateTimefield('ETADate', Value);             End;
Procedure TOrderLineBase.SetCustomField1(Const Value :String);			  begin SetStringField('CustomField1', Value);          End;
Procedure TOrderLineBase.SetCustomField2(Const Value :String);			  begin SetStringField('CustomField2', Value);          End;
Procedure TOrderLineBase.SetCustomField3(Const Value :String);			  begin SetStringField('CustomField3', Value);          End;
Procedure TOrderLineBase.SetCustomField4(Const Value :String);			  begin SetStringField('CustomField4', Value);          End;
Procedure TOrderLineBase.SetCustomField5(Const Value :String);			  begin SetStringField('CustomField5', Value);          End;
Procedure TOrderLineBase.SetCustomField6(Const Value :String);			  begin SetStringField('CustomField6', Value);          End;
Procedure TOrderLineBase.SetCustomField7(Const Value :String);			  begin SetStringField('CustomField7', Value);          End;
Procedure TOrderLineBase.SetCustomField8(Const Value :String);			  begin SetStringField('CustomField8', Value);          End;
Procedure TOrderLineBase.SetCustomField9(Const Value :String);			  begin SetStringField('CustomField9', Value);          End;
Procedure TOrderLineBase.SetCustomField10(Const Value :String);           begin SetStringField('CustomField10', Value);         End;
Procedure TOrderLineBase.SetINCOMEACCNTID(Const Value :Integer);		  begin SetIntegerField('INCOMEACCNTID', Value);        End;
Procedure TOrderLineBase.SetAssetAccntId(Const Value :Integer);			  begin SetIntegerField('AssetAccntId', Value);         End;
Procedure TOrderLineBase.SetCogsAccntId(Const Value :Integer);            begin SetIntegerField('CogsAccntId', Value);          End;
procedure TOrderLineBase.SetAttrib1Purchase(const Value : Double);        begin SetFloatField('Attrib1Purchase', Value);        end;
procedure TOrderLineBase.SetAttrib1PurchaseRate(const Value : Double);    begin SetFloatField('Attrib1PurchaseRate', Value);    end;
procedure TOrderLineBase.SetAttrib2Purchase(const Value : Double);        begin SetFloatField('Attrib2Purchase', Value);        end;
procedure TOrderLineBase.SetAttrib1PurchaseEst(const Value : Double);     begin SetFloatField('Attrib1PurchaseEst', Value);        end;
procedure TOrderLineBase.SetAttrib2PurchaseEst(const Value : Double);     begin SetFloatField('Attrib2PurchaseEst', Value);        end;
procedure TOrderLineBase.SetLineClassId(const Value : Integer);           begin SetIntegerField('ClassId', Value);              end;
procedure TOrderLineBase.SetLineClassName(const Value : String);          begin SetStringField('Class', Value);                 end;
procedure TOrderLineBase.SetAverageCost(const Value : Double);            begin SetFloatField('AvgCost', Value);                end;
procedure TOrderLineBase.SetReceivedDate(const Value : TDateTime);
var
  fbFlag:Boolean;
begin
  fbFlag := dataset.findfield('ReceivedDate').Readonly;
  dataset.findfield('ReceivedDate').Readonly := False;
  try
    SeTDateTimeField('ReceivedDate', Value);
  finally
    dataset.findfield('ReceivedDate').Readonly := fbFlag;
  end;
end;
procedure TOrderLineBase.SetFEPOLines(const Value: TFEPOLines);begin fFEPOLines := Value;end;
procedure TOrderLineBase.SetForeignExchangeCode(const Value : String);    begin SetStringField('ForeignExchangeCode', Value);   end;
procedure TOrderLineBase.SetForeignLineCost(const Value : Double);        begin SetFloatField('ForeignCurrencyLineCost', Value);end;
procedure TOrderLineBase.SetSaleLineId(const Value : Integer);            begin SetIntegerField('SaleLineId', Value);      end;
procedure TOrderLineBase.SetSerialNos(const Value : String);begin  SetStringField('SerialNo', Value);end;
procedure TOrderLineBase.setSmartOrderID(const Value: Integer);begin SetIntegerField('SmartOrderID' , Value);end;
procedure TOrderLineBase.setEmployeeID(const Value: Integer);begin SetIntegerField('EmployeeID' , Value);end;
procedure TOrderLineBase.setSmartOrderLineID(const Value: Integer);begin SetIntegerField('SmartOrderLineID' , Value);end;
function TOrderLineBase.getFEPOLines: TFEPOLines;
begin
  if not Assigned(fFEPOLines) then begin
    fFEPOLines := TFEPOLines.Create(Self);
    fFEPOLines.connection := Self.connection;
    fFEPOLines.SilentMode := Self.SilentMode;
  end;
  // if (fFEPOLines.Dataset.Recordcount = 0) or (fFEPOLines.SaleslineId <> Self.ID) then
  if (fFEPOLines.SQLSelect <> 'POLineId = ' + inttostr(Self.ID)) or (fFEPOLines.Dataset.Active = False) then
    fFEPOLines.LoadSelect('POLineId = ' + inttostr(Self.ID));
  Result := fFEPOLines;
end;
function TOrderLineBase.GetCustomerJobName: string;
begin
  if CustomerJobId > 0 then
    CustomerJobObj.ClientName
  else
    result := '';
end;
function TOrderLineBase.GetRepairDocNo: string;
begin
  if RepairID > 0 then
    result:= TRepairs.DocNoForID(self.RepairId, Connection.Connection)
  else
    result:= '';
end;
procedure TOrderLineBase.SetRepairDocNo(const Value: string);
begin
  if Value <> '' then
    RepairID:= TRepairs.IDForDocNo(Value, Connection.Connection)
  else
    RepairID:= 0;
end;
procedure TOrderLineBase.SetCustomerJobName(const Value: string);
begin
  if Trim(Value) <> '' then
    CustomerJobID := TClient.IDToggle(Value, Connection.Connection)
  else
    CustomerJobID := 0;
end;

procedure TOrderLineBase.LoadFromXMLNode(Const Node: IXMLNode);
begin
    SetPropertyFromNode(Node, 'Productid');
    SetPropertyFromNode(Node, 'Productname');
    SetPropertyFromNode(Node, 'Assetaccount');
    SetPropertyFromNode(Node, 'Qtybackorder');
    SetPropertyFromNode(Node, 'Cogsaccount');
//    SetPropertyFromNode(Node, 'Costcentreid');
    SetPropertyFromNode(Node, 'SalelineId');
    SetPropertyFromNode(Node, 'ProcTreeId');
    SetBooleanPropertyFromNode(Node, 'Deleted');
    SetPropertyFromNode(Node, 'Foreigntotallineamount');
    SetPropertyFromNode(Node, 'Incomeaccount');
    SetBooleanPropertyFromNode(Node, 'Invoiced');
    SetPropertyFromNode(Node, 'OriginalCost');
    SetPropertyFromNode(Node, 'DiscountPercent');
    SetPropertyFromNode(Node, 'DiscountAmount');
    SetPropertyFromNode(Node, 'Linecost');
    SetPropertyFromNode(Node, 'Linecostinc');
    SetPropertyFromNode(Node, 'Linenotes');
    SetPropertyFromNode(Node, 'Linetaxtotal');
    SetPropertyFromNode(Node, 'Linetaxcode');
    SetPropertyFromNode(Node, 'Linetaxrate');
    SetPropertyFromNode(Node, 'Producttype');
    SetPropertyFromNode(Node, 'Productgroup');
    SetPropertyFromNode(Node, 'Qtysold');
    SetPropertyFromNode(Node, 'Searchfilter');
    SetPropertyFromNode(Node, 'Searchfiltercopy');
    SetPropertyFromNode(Node, 'Qtyshipped');
    SetPropertyFromNode(Node, 'Totallineamount');
    SetPropertyFromNode(Node, 'Totallineamountinc');
    SetPropertyFromNode(Node, 'Uomqtybackorder');
    SetPropertyFromNode(Node, 'Uommultiplier');
    SetPropertyFromNode(Node, 'Uomqtysold');
    SetPropertyFromNode(Node, 'Uomqtyshipped');
    SetPropertyFromNode(Node,  'Serialnumbers');
    SetPropertyFromNode(Node,   'Attrib1Purchase');
    SetPropertyFromNode(Node,   'Attrib1Purchaserate');
    SetPropertyFromNode(Node,   'Attrib2Purchase');
    SetPropertyFromNode(Node,   'Attrib1PurchaseEst');
    SetPropertyFromNode(Node,   'Attrib2PurchaseEst');
    SetPropertyFromNode(Node,   'Averagecost');
    SetPropertyFromNode(Node,  'Lineclassname');
    SetPropertyFromNode(Node, 'Lineclassid');
    SeTDateTimePropertyFromNode(Node,    'Receiveddate');
    SetPropertyFromNode(Node, 'Unitofmeasureid');
    SetPropertyFromNode(Node,  'Unitofmeasure');
    SetPropertyFromNode(Node, 'Productdescription');
    SetPropertyFromNode(Node, 'Accountgroup');
    SetPropertyFromNode(Node, 'Accountname');
    SetPropertyFromNode(Node, 'Accountnumber');
    SetPropertyFromNode(Node, 'Assetaccntid');
    SetPropertyFromNode(Node, 'Baselineno');
    SetPropertyFromNode(Node, 'Batch');
    SetPropertyFromNode(Node, 'Cogsaccntid');
    SetPropertyFromNode(Node, 'Cogstotallineamount');
    SetPropertyFromNode(Node, 'Cogstotallineamountinc');
    SetPropertyFromNode(Node, 'Customerjob');
    SetPropertyFromNode(Node, 'CustomerPrintJob');
    SetPropertyFromNode(Node, 'Customerjobid');
    SetPropertyFromNode(Node, 'Customfield1');
    SetPropertyFromNode(Node, 'Customfield10');
    SetPropertyFromNode(Node, 'Customfield2');
    SetPropertyFromNode(Node, 'Customfield3');
    SetPropertyFromNode(Node, 'Customfield4');
    SetPropertyFromNode(Node, 'Customfield5');
    SetPropertyFromNode(Node, 'Customfield6');
    SetPropertyFromNode(Node, 'Customfield7');
    SetPropertyFromNode(Node, 'Customfield8');
    SetPropertyFromNode(Node, 'Customfield9');
    SetPropertyFromNode(Node, 'Docketnumber');
//    SetBooleanPropertyFromNode(Node, 'Editedflag');
    SeTDateTimePropertyFromNode(Node, 'Etadate');
    SetPropertyFromNode(Node, 'Incomeaccntid');
    SetPropertyFromNode(Node, 'TotalLineLandedCostPerc');
    SetPropertyFromNode(Node, 'OriginalQtyOrdered');
    SetPropertyFromNode(Node, 'UnitLandedCost');
    SetPropertyFromNode(Node, 'TotalOrderLandedCost');
    SetPropertyFromNode(Node, 'Lastlineid');
    SetPropertyFromNode(Node, 'Newforeignexchangerate');
    SetPropertyFromNode(Node, 'Partspecid');
    SetPropertyFromNode(Node, 'Rainvoiceno');
    SetPropertyFromNode(Node, 'Raqty');
    SetPropertyFromNode(Node, 'Rastatus');
    SetPropertyFromNode(Node, 'Relatedpoid');
    SetBooleanPropertyFromNode(Node, 'Relatedpoidused');
    SetPropertyFromNode(Node, 'Saleid_Timecost');
    SetPropertyFromNode(Node, 'Seqno');
    SetPropertyFromNode(Node, 'Specdescription');
    SetPropertyFromNode(Node, 'Specvalue');
    SetPropertyFromNode(Node, 'Timecostmarkupdol');
    SetPropertyFromNode(Node, 'Timecostmarkupper');
    SetPropertyFromNode(Node, 'Timecostprice');
    SetBooleanPropertyFromNode(Node, 'Usetimecost');
    SetPropertyFromNode(Node,   'Foreignlinecost');
    SetPropertyFromNode(Node, 'SortID');
    SetPropertyFromNode(Node, 'LinesOrder');
    SetPropertyFromNode(Node, 'SupplierProductCode');
    SetPropertyFromNode(Node, 'SupplierProductName');
    SetPropertyFromNode(Node, 'SupplierBarCode');
    SetPropertyFromNode(node, 'PrintedValue');
    SetPropertyFromNode(Node, 'SmartOrderId');
    SetPropertyFromNode(Node, 'EmployeeID');
    SetPropertyFromNode(Node, 'EmployeeName');
    SetPropertyFromNode(Node, 'AreaCode');
    SetPropertyFromNode(Node, 'RALineRef');
    SetPropertyFromNode(Node, 'smartOrderLineID');

    inherited;
end;


procedure TOrderLineBase.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  // if Assigned(fFEPOLines)      then    FreeAndNil(fFEPOLines);
  if Assigned(fFEPOLines) then begin
    if (not fFEPOLines.ExternalDatasetAssigned) then FreeAndNil(fFEPOLines)
    else fFEPOLines.Dataset.close;
  end;

end;

Procedure Torderlinebase.SaveToXMLNode(Const Node: IXMLNode);
Begin
    AddXMLNode(node,'Accountgroup',Accountgroup);
    AddXMLNode(node,'Accountname',Accountname);
    AddXMLNode(node,'Accountnumber',Accountnumber);
    AddXMLNode(node,'Assetaccntid',Assetaccntid);
    AddXMLNode(node,'SaleLineId',SaleLineId);
    AddXMLNode(node,'ProcTreeId',ProcTreeId);
    AddXMLNode(node,'Baselineno',Baselineno);
    AddXMLNode(node,'Batch',Batch);
    AddXMLNode(node,'Cogsaccntid',Cogsaccntid);
    AddXMLNode(node,'Cogstotallineamount',Cogstotallineamount);
    AddXMLNode(node,'Cogstotallineamountinc',Cogstotallineamountinc);
    AddXMLNode(node,'Customerjob',Customerjob);
    AddXMLNode(node,'CustomerPrintJob',CustomerPrintJob);
    AddXMLNode(node,'Customerjobid',Customerjobid);
    AddXMLNode(node,'Customfield1',Customfield1);
    AddXMLNode(node,'Customfield10',Customfield10);
    AddXMLNode(node,'Customfield2',Customfield2);
    AddXMLNode(node,'Customfield3',Customfield3);
    AddXMLNode(node,'Customfield4',Customfield4);
    AddXMLNode(node,'Customfield5',Customfield5);
    AddXMLNode(node,'Customfield6',Customfield6);
    AddXMLNode(node,'Customfield7',Customfield7);
    AddXMLNode(node,'Customfield8',Customfield8);
    AddXMLNode(node,'Customfield9',Customfield9);
    AddXMLNode(node,'Docketnumber',Docketnumber);
//    AddXMLNode(node,'Editedflag',Editedflag);
    AddXMLNode(node,'Etadate',Etadate);
    AddXMLNode(node,'Incomeaccntid',Incomeaccntid);
    AddXMLNode(node,'TotalLineLandedCostPerc',TotalLineLandedCostPerc);
    AddXMLNode(node,'OriginalQtyOrdered',OriginalQtyOrdered);
    AddXMLNode(node,'UnitlandedCost',UnitLandedCost);
    AddXMLNode(node,'TotalOrderlandedCost',TotalOrderLandedCost);
    AddXMLNode(node,'Lastlineid',Lastlineid);
    AddXMLNode(node,'Newforeignexchangerate',Newforeignexchangerate);
    AddXMLNode(node,'Partspecid',Partspecid);
    AddXMLNode(node,'Rainvoiceno',Rainvoiceno);
    AddXMLNode(node,'Raqty',Raqty);
    AddXMLNode(node,'Rastatus',Rastatus);
    AddXMLNode(node,'Relatedpoid',Relatedpoid);
    AddXMLNode(node,'Relatedpoidused',Relatedpoidused);
    AddXMLNode(node,'Saleid_Timecost',Saleid_Timecost);
    AddXMLNode(node,'Seqno',Seqno);
    AddXMLNode(node,'Specdescription',Specdescription);
    AddXMLNode(node,'Specvalue',Specvalue);
    AddXMLNode(node,'Timecostmarkupdol',Timecostmarkupdol);
    AddXMLNode(node,'Timecostmarkupper',Timecostmarkupper);
    AddXMLNode(node,'Timecostprice',Timecostprice);
    AddXMLNode(node,'Usetimecost',Usetimecost);
    AddXMLNode(node,'Foreignlinecost',Foreignlinecost);
    AddXMLNode(node,'Assetaccount',Assetaccount);
    AddXMLNode(node,'Qtybackorder',Qtybackorder);
    AddXMLNode(node,'Cogsaccount',Cogsaccount);
//    AddXMLNode(node,'Costcentreid',Costcentreid);
    AddXMLNode(node,'Deleted',Deleted);
    AddXMLNode(node,'Foreigntotallineamount',Foreigntotallineamount);
    AddXMLNode(node,'Incomeaccount',Incomeaccount);
    AddXMLNode(node,'Invoiced',Invoiced);
    AddXMLNode(node,'DiscountPercent',DiscountPercent);
    AddXMLNode(node,'DiscountAmount',DiscountAmount);
    AddXMLNode(node,'OriginalCost',OriginalCost);
    AddXMLNode(node,'Linecost',Linecost);
    AddXMLNode(node,'Linecostinc',Linecostinc);
    AddXMLNode(node,'Linenotes',Linenotes);
    AddXMLNode(node,'Linetaxtotal',Linetaxtotal);
    AddXMLNode(node,'Linetaxcode',Linetaxcode);
    AddXMLNode(node,'Linetaxrate',Linetaxrate);
    AddXMLNode(node,'Producttype',Producttype);
    AddXMLNode(node,'Productdescription',Productdescription);
    AddXMLNode(node,'Productgroup',Productgroup);
    AddXMLNode(node,'Productid',Productid);
    AddXMLNode(node,'Productname',Productname);

    AddXMLNode(node,'Qtysold',Qtysold);
    AddXMLNode(node,'Searchfilter',Searchfilter);
    AddXMLNode(node,'Searchfiltercopy',Searchfiltercopy);
    AddXMLNode(node,'Qtyshipped',Qtyshipped);
    AddXMLNode(node,'Totallineamount',Totallineamount);
    AddXMLNode(node,'Totallineamountinc',Totallineamountinc);
    AddXMLNode(node,'Uomqtybackorder',Uomqtybackorder);
    AddXMLNode(node,'Uommultiplier',Uommultiplier);
    AddXMLNode(node,'Uomqtysold',Uomqtysold);
    AddXMLNode(node,'Uomqtyshipped',Uomqtyshipped);
    AddXMLNode(node,'Serialnumbers',Serialnumbers);
    AddXMLNode(node,'Attrib1Purchase',Attrib1Purchase);
    AddXMLNode(node,'Attrib1Purchaserate',Attrib1Purchaserate);
    AddXMLNode(node,'Attrib2Purchase',Attrib2Purchase);
    AddXMLNode(node,'Attrib1PurchaseEst',Attrib1PurchaseEst);
    AddXMLNode(node,'Attrib2PurchaseEst',Attrib2PurchaseEst);
    AddXMLNode(node,'Averagecost',Averagecost);
    AddXMLNode(node,'Lineclassname',Lineclassname);
    AddXMLNode(node,'Lineclassid',Lineclassid);
    AddXMLNode(node,'Purchaselineid',Purchaselineid);
    AddXMLNode(node,'Purchaseorderid',Purchaseorderid);
    AddXMLNode(node,'Receiveddate',Receiveddate);
    AddXMLNode(node,'Unitofmeasureid',Unitofmeasureid);
    AddXMLNode(node,'Unitofmeasure',Unitofmeasure);
    AddXMLNode(node,'SortID',SortID);
    AddXMLNode(node,'LinesOrder',LinesOrder);
    AddXMLNode(node,'SmartOrderId',SmartOrderId);
    AddXMLNode(node,'EmployeeName',EmployeeName);
    AddXMLNode(node,'AreaCode',AreaCode);
    AddXMLNode(node,'RALineRef',RALineRef);
    AddXMLNode(node,'EmployeeID',EmployeeID);
    AddXMLNode(node,'SmartOrderlineId',SmartOrderLineId);
    AddXMLNode(Node,'SupplierProductCode',SupplierProductCode);
    AddXMLNode(Node,'SupplierProductName',SupplierProductName);
    AddXMLNode(Node,'SupplierBarCode',SupplierBarCode);
    AddXMLNode(Node,'PrintedValue',PrintedValue);
    Inherited;
end;

procedure TOrderLineBase.InitializeNewObject;
begin
  inherited;
    if TOrderBase(self.Owner).Id < 1 then exit;

    if assigned(Self.Owner) then
        if self.Owner is TPurchaseOrder then
            PurchaseOrderId := TPurchaseOrder(Self.Owner).Id;

    Deleted := False;
End;

Function TOrderLineBase.GetSQL: String;
begin
    result:= inherited GetSQL;
end;

Procedure TOrderLineBase.CreateInstance;
begin
    if Owner is TOrderBase then
        if Assigned(TOrderBase(Owner).ObjInstanceToClone) then
            ObjInstanceToClone :=TOrderBase(TOrderBase(Owner).ObjInstanceToClone).Lines;

end;

  //------------------------------------------------------------------------------
  { TOrderBase }
  //------------------------------------------------------------------------------

function TOrderBase.AmountToApprove: double;
begin
  REsult:= TotalAmountinc;
end;

procedure TOrderBase.SetTransStatus(const Value: String);
begin
  inherited;
  Orderstatus := value;
end;
function TOrderBase.ShipToAddressRec: TAddressRec;
var
  ShipAddress: TShippingAddress;
  bm: TBookmark;
  fbaddressfound:Boolean;
begin
  REsult := nil;
  fbaddressfound:=false;
  if not Assigned(fShipToAddressRec) then begin
    fShipToAddressRec := TAddressRec.Create;
    if ShipToId > 0 then begin
      ShipAddress := TShippingAddress.Create(nil, self.Connection.Connection);
      try
          ShipAddress.Load(ShipToId);
          fShipToAddressRec.Line1 := ShipAddress.ShipAddress;
          fShipToAddressRec.Line2 := ShipAddress.ShipAddress1;
          fShipToAddressRec.Line3 := ShipAddress.ShipAddress2;
          fShipToAddressRec.City := ShipAddress.ShipCity;
          fShipToAddressRec.State := ShipAddress.ShipState;
          fShipToAddressRec.Postcode := ShipAddress.ShipPostcode;
          fShipToAddressRec.Country := ShipAddress.ShipCountry;
          fbaddressfound:=true;
      finally
        ShipAddress.Free;
      end;
    end else if self.ShipToCustomer then begin
      { find line with customer/job .. }
      if Lines.Count = 0 then exit;
      bm := Lines.Dataset.GetBookmark;
      try
        Lines.Dataset.DisableControls;
        try
          Lines.Dataset.First;
          while not Lines.Dataset.Eof do begin
            if Assigned(Lines.CustomerJobObj) and (Lines.CustomerJobObj.ID > 0) then begin
              fShipToAddressRec.Line1 := Lines.CustomerJobObj.Street;
              fShipToAddressRec.Line2 := Lines.CustomerJobObj.Street2;
              fShipToAddressRec.Line3 := Lines.CustomerJobObj.Street3;
              fShipToAddressRec.City := Lines.CustomerJobObj.Suburb;
              fShipToAddressRec.State := Lines.CustomerJobObj.State;
              fShipToAddressRec.Postcode := Lines.CustomerJobObj.Postcode;
              fShipToAddressRec.Country := Lines.CustomerJobObj.Country;
              fbaddressfound:=True;
              break;
            end;
            Lines.Dataset.Next;
          end;

          Lines.Dataset.GotoBookmark(bm);
        finally
          Lines.Dataset.EnableControls;
        end;
      finally
        Lines.Dataset.FreeBookmark(bm);
      end;
    end;
    if fbaddressfound = false then begin
        if ShipToClass and (ShiptoClassID<> 0) then begin
          TDeptclass.ReadShipToAddress(ShiptoClassID ,fShipToAddressRec);
        end else begin
          fShipToAddressRec.Line1 := AppEnv.CompanyInfo.Address;
          fShipToAddressRec.Line2 := AppEnv.CompanyInfo.Address2;
          fShipToAddressRec.Line3 := AppEnv.CompanyInfo.Address3;
          fShipToAddressRec.City := AppEnv.CompanyInfo.City;
          fShipToAddressRec.State := AppEnv.CompanyInfo.State;
          fShipToAddressRec.Postcode := AppEnv.CompanyInfo.Postcode;
          fShipToAddressRec.Country := AppEnv.CompanyInfo.Country;
        end;
    end;
  end;
  result := fShipToAddressRec;
end;

function TOrderBase.GetTransStatus: String;
begin
  REsult := OrderStatus;
end;
procedure TOrderBase.CalcOrderTotals;
begin
  inherited;
    Progressbarmsg:= 'Calculating Totals';
    SendEvent(BusobjEvent_ToDo,BusobjEvent_ProgressbarProgress, self.Lines);
    LineSum.Clear;

    // Iterate through all records and total
    Lines.IterateRecords(CalcTotalsCallback , true);

    LineSum.SumTotals(True, True);

    // set properties to results
    // Binny : only if they are different - this will avoid Editing the dataset when loaded
    if TotalAmount    <> LineSum.SumAmountEx        then  TotalAmount   := LineSum.SumAmountEx;
    if TotalAmountInc <> LineSum.SumAmountInc       then  TotalAmountInc:= LineSum.SumAmountInc;
    if TotalTax       <> LineSum.SumTax             then  TotalTax      := LineSum.SumTax;
    if TotalDiscount  <> LineSum.SumTotaldiscount   then  TotalDiscount := LineSum.SumTotaldiscount;
    if TotalBalance   <> TotalAmountInc - totalPaid then  TotalBalance  := TotalAmountInc - totalPaid;
    if IsPaid         <> (TotalAmountInc <> 0) and (TotalBalance = 0) then
      IsPaid         := (TotalAmountInc <> 0) and (TotalBalance = 0);
    SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, self.Lines);
    SendEvent(BusObjEvent_Change, BusObjEvent_OnCalcOrderTotals, self);
end;

procedure TOrderBase.CalcTotalsCallback(Const Sender: TBusObj; var Abort: boolean);
begin
  if TOrderLineBase(Sender).Deleted then Exit;
  LineSum.Add(TOrderLineBase(Sender).ClassID,
              TOrderLineBase(Sender).TotalLineAmount,
              TOrderLineBase(Sender).TotalLineAmountInc,
              TOrderLineBase(Sender).LineTaxTotal,
              TOrderLineBase(Sender).DiscountAmount);
end;

constructor TOrderBase.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'Select * from tblPurchaseOrders';
  fPopupDisplayed         :=False;
  fSupplier := nil;
  fBusObjectTypeDescription := 'Order Base Object';
  LineSum:= TTransLineSum.Create;
  FieldsNottoclone :=ExcludeFromclone+','+
                        QuotedStr('OriginalNo') + ',' +
                        QuotedStr('BaseNo') + ',' +
                        QuotedStr('BOID')+','    +
                        QuotedStr('PAID')+','    +
                        QuotedStr('Balance')+','    +
                        QuotedStr('Payment')+','    +
                        QuotedStr('ForeignPaidAmount')+','    +
                        QuotedStr('ForeignBalanceAmount')+','    +
                        QuotedStr('PrintFlag')+','    +
                        QuotedStr('PrintedBy')+','    +
                        QuotedStr('InvoiceDate')+','    +
                        QuotedStr('InvoiceNumber')+','    +
                        QuotedStr('PurchaseOrderNumber')+','    +
                        QuotedStr('InvoiceDate');

end;

function TOrderBase.GetClient: TClient;
begin
  result:= Supplier;
end;

Function TOrderBase.GetClientName: String;
begin
  Result := SupplierName;
end;

Function TOrderBase.GetDocNumber: String;
begin
  Result := GetStringField('PurchaseOrderNumber');
end;

Function TOrderBase.GetId: Integer;
begin
  Result := PurchaseOrderId;
end;

Function TOrderBase.GetInvoiced: boolean;
begin
  result := SupplierInvoiceNumber <> '';
end;

function TOrderBase.GetOrderCountry: string;
var s: string;
begin
  result := '';
  s := Lowercase(OrderTo);
  if (Supplier.Country <> '') and (Pos(Lowercase(Supplier.Country), s) > 0) then
    result := Supplier.Country;
end;

Function TOrderBase.GetOrderDate: TDateTime;
begin
  Result := GeTDateTimeField('OrderDate');
end;

Function TOrderBase.GetPurchaseOrderId: Integer;
begin
  Result := GetIntegerField('PurchaseOrderId');
end;

Function TOrderBase.GetSupplier: TSupplier;
var
  strSQL:String;
begin
  if (self.ClientId > 0) then
        strSQL:= 'ClientId = ' + IntToStr(self.ClientId)
  else if (self.ClientName <> '') then
        strSQL:= 'Company = ' + QuotedStr(StringDataForSQL(self.ClientName));
  result := TSupplier(getContainerComponent(TSupplier, strSQL , true, true,true,'',true));
  result.BusObjEvent := Self.BusObjEvent;
end;

function TOrderBase.getSupplierEmailId: String;
begin
  Result := '';
  if supplierId = 0 then exit;
  result := Supplier.Email;

end;

Function TOrderBase.GetSupplierId: Integer; begin  Result := ClientId;end;
Function TOrderBase.GetSupplierInvoiceDate: TDateTime;begin  Result := GeTDateTimeField('InvoiceDate');end;
Function TOrderBase.GetSupplierInvoiceNumber: String;begin   Result := GetStringField('InvoiceNumber');end;
Function TOrderBase.GetSupplierName: String;begin  Result := GetStringField('SupplierName');end;
function TOrderBase.GetOrderStreet1: string;
var s: string;
begin
  result := '';
  s := Lowercase(OrderTo);
  if (Supplier.Street <> '') and (Pos(Lowercase(Supplier.Street), s) > 0) then
    result := Supplier.Street;
end;

function TOrderBase.GetOrderStreet2: string;
var s: string;
begin
  result := '';
  s := Lowercase(OrderTo);
  if (Supplier.Street2 <> '') and (Pos(Lowercase(Supplier.Street2), s) > 0) then
    result := Supplier.Street2;
end;

function TOrderBase.GetOrderStreet3: string;
var s: string;
begin
  result := '';
  s := Lowercase(OrderTo);
  if (Supplier.Street3 <> '') and (Pos(Lowercase(Supplier.Street3), s) > 0) then
    result := Supplier.Street3;
end;

function TOrderBase.GetOrderSuburb: string;
var s: string;
begin
  result := '';
  s := Lowercase(OrderTo);
  if (Supplier.Suburb <> '') and (Pos(Lowercase(Supplier.Suburb), s) > 0) then
    result := Supplier.Suburb;
end;

Function TOrderbase.GetOrderTo:String;begin	Result := GetStringfield('OrderTo');End;
Function TOrderbase.GetShipTo:String;begin	Result := GetStringfield('ShipTo');End;
Function TOrderbase.GetRefNo:String;begin	Result := GetStringfield('RefNo');End;
Function TOrderbase.GetETADate:TDateTime;begin	Result := GeTDateTimefield('ETADate');End;
Function TOrderbase.GetSalesComments:String;begin	Result := GetStringfield('SalesComments');End;
Function TOrderbase.GetOrgPurchaseOrderNumber:String;begin	Result := GetStringfield('OrgPurchaseOrderNumber');End;
function TOrderBase.GetShipCountry: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipTo);
  if (ShipToAddressRec.Country <> '') and (Pos(Lowercase(ShipToAddressRec.Country), s) > 0) then
    result := ShipToAddressRec.Country;
end;

Function TOrderbase.GetShipping:String;begin	Result := GetStringfield('Shipping');End;

function TOrderBase.GetShipPostcode: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipTo);
  if (ShipToAddressRec.Postcode <> '') and (Pos(Lowercase(ShipToAddressRec.Postcode), s) > 0) then
    result := ShipToAddressRec.postcode;
end;

function TOrderBase.GetShipState: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipTo);
  if (ShipToAddressRec.State <> '') and (Pos(Lowercase(ShipToAddressRec.State), s) > 0) then
    result := ShipToAddressRec.State;
end;

function TOrderBase.GetShipStreet1: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipTo);
  if (ShipToAddressRec.Line1 <> '') and (Pos(Lowercase(ShipToAddressRec.Line1), s) > 0) then
    result := ShipToAddressRec.Line1;
end;

function TOrderBase.GetShipStreet2: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipTo);
  if (ShipToAddressRec.Line2 <> '') and (Pos(Lowercase(ShipToAddressRec.Line2), s) > 0) then
    result := ShipToAddressRec.Line2;
end;

function TOrderBase.GetShipStreet3: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipTo);
  if (ShipToAddressRec.Line3 <> '') and (Pos(Lowercase(ShipToAddressRec.Line3), s) > 0) then
    result := ShipToAddressRec.Line3;
end;

function TOrderBase.GetShipSuburb: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipTo);
  if (ShipToAddressRec.City <> '') and (Pos(Lowercase(ShipToAddressRec.City), s) > 0) then
    result := ShipToAddressRec.City;
end;
Procedure TOrderbase.SetShipTo(Const Value :String);
begin
  SetStringfield('ShipTo',Value);
  FreeAndNil(fShipToAddressRec);
End;

Function TOrderbase.GetApplyFlag:Boolean;begin	Result := GetBooleanfield('ApplyFlag');End;
Function TOrderbase.GetAmountDue:Double;begin	Result := GetFloatField('AmountDue');End;
Function TOrderbase.GetPayMethod:Integer;begin	Result := GetIntegerfield('PayMethod');End;
Function TOrderbase.GetIsPO:Boolean;begin	Result := GetBooleanfield('IsPO');End;
Function TOrderbase.GetIsRA:Boolean;begin	Result := GetBooleanfield('IsRA');End;
Function TOrderbase.GetIsBill:Boolean;begin	Result := GetBooleanfield('IsBill');End;
Function TOrderbase.GetIsCredit:Boolean;begin	Result := GetBooleanfield('IsCredit');End;
Function TOrderbase.GetIsCheque:Boolean;begin	Result := GetBooleanfield('IsCheque');End;
Function TOrderbase.GetIsRefundCheque:Boolean;begin	Result := GetBooleanfield('IsRefundCheque');End;
Function TOrderbase.GetRefundGlobalref:String;begin	Result := GetStringfield('RefundGlobalref');End;
Function TOrderbase.GetIsPOCredit:Boolean;begin	Result := GetBooleanfield('IsPOCredit');End;
Function TOrderbase.GetEditedFlag:Boolean;begin	Result := GetBooleanfield('EditedFlag');End;
Function TOrderbase.GetConNote:String;begin	Result := GetStringfield('ConNote');End;
Function TOrderbase.GetCustPONumber:String;begin	Result := GetStringfield('CustPONumber');End;
Function TOrderbase.GetLastUpdated:TDateTime;begin	Result := GeTDateTimefield('LastUpdated');End;
Function TOrderbase.GetApproved:Boolean;begin	Result := GetBooleanfield('Approved');End;
function TOrderBase.GetApproverID: integer;begin  result := GetIntegerField('ApproverID');end;
function TOrderBase.GetPickUpfromID: integer;begin  result := GetIntegerField('PickUpfromID');end;
function TOrderBase.GetShiptoClassID: integer;begin  result := GetIntegerField('ShiptoClassID');end;
Function TOrderbase.getArea:String;begin  Result:= GetStringfield('Area');end;
Function TOrderbase.getcleanApproved :Boolean;begin    result:= GetXMLNodeBooleanValue(CleanXMLNOde, 'Approved')end;
Function TOrderbase.getcleanOrderDate  : TDateTime;begin    result:= GetXMLNodeDatetimeValue(CleanXMLNOde, 'OrderDate')end;
Function TOrderbase.GetCustField1:  String;  begin	Result := GetStringfield('CustField1'); End;
Function TOrderbase.GetCustField2:  String;  begin	Result := GetStringfield('CustField2'); End;
Function TOrderbase.GetCustField3:  String;  begin	Result := GetStringfield('CustField3'); End;
Function TOrderbase.GetCustField4:  String;  begin	Result := GetStringfield('CustField4'); End;
Function TOrderbase.GetCustField5:  String;  begin	Result := GetStringfield('CustField5'); End;
Function TOrderbase.GetCustField6:  String;  begin	Result := GetStringfield('CustField6'); End;
Function TOrderbase.GetCustField7:  String;  begin	Result := GetStringfield('CustField7'); End;
Function TOrderbase.GetCustField8:  String;  begin	Result := GetStringfield('CustField8'); End;
Function TOrderbase.GetCustField9:  String;  begin	Result := GetStringfield('CustField9'); End;
Function TOrderbase.GetCustField10: String;  begin	Result := GetStringfield('CustField10'); End;
Function TOrderbase.GetTypeOfBasedOn    : String;     Begin Result := GetStringField('TypeOfBasedOn'); End;
Function TOrderbase.GetFrequencyValues  : String;     Begin Result := GetStringField('FrequencyValues'); End;
Function TOrderbase.GetCopyStartDate    : TDateTime;  Begin Result := GetDateTimeField('CopyStartDate'); End;
Function TOrderbase.GetCopyFinishDate   : TDateTime;  Begin Result := GetDateTimeField('CopyFinishDate'); End;

Procedure TOrderbase.SetOrderTo(Const Value :String);begin	SetStringfield('OrderTo',Value);End;
Procedure TOrderbase.SetRefNo(Const Value :String);begin	SetStringfield('RefNo',Value);End;
Procedure TOrderbase.SetETADate(Const Value :TDateTime);begin	SeTDateTimefield('ETADate',Value);End;
Procedure TOrderbase.SetSalesComments(Const Value :String);begin	SetStringfield('SalesComments',Value);End;
Procedure TOrderbase.SetOrgPurchaseOrderNumber(Const Value :String);begin	SetStringfield('OrgPurchaseOrderNumber',Value);End;
Procedure TOrderbase.SetShipping(Const Value :String);begin	SetStringfield('Shipping',Value);End;
Procedure TOrderbase.SetApplyFlag(Const Value :Boolean);begin	SetBooleanfield('ApplyFlag',Value);End;
Procedure TOrderbase.SetAmountDue(Const Value :Double);begin	SetFloatField('AmountDue',Value);End;
Procedure TOrderbase.SetPayMethod(Const Value :Integer);begin	SetIntegerfield('PayMethod',Value);End;
Procedure TOrderbase.SetIsPO(Const Value :Boolean);begin	SetBooleanfield('IsPO',Value);End;
Procedure TOrderbase.SetIsRA(Const Value :Boolean);begin	SetBooleanfield('IsRA',Value);End;
Procedure TOrderbase.SetIsBill(Const Value :Boolean);begin	SetBooleanfield('IsBill',Value);End;
Procedure TOrderbase.SetIsCredit(Const Value :Boolean);begin	SetBooleanfield('IsCredit',Value);End;
Procedure TOrderbase.SetIsCheque(Const Value :Boolean);begin	SetBooleanfield('IsCheque',Value);End;
Procedure TOrderbase.SetIsRefundCheque(Const Value :Boolean);begin	SetBooleanfield('IsRefundCheque',Value);End;
Procedure TOrderbase.SetRefundGlobalref(Const Value :String);begin	SetStringfield('RefundGlobalref',Value);End;
Procedure TOrderbase.SetIsPOCredit(Const Value :Boolean);begin	SetBooleanfield('IsPOCredit',Value);End;
Procedure TOrderbase.SetEditedFlag(Const Value :Boolean);begin	SetBooleanfield('EditedFlag',Value);End;
Procedure TOrderbase.SetConNote(Const Value :String);begin	SetStringfield('ConNote',Value);End;
Procedure TOrderbase.SetCustPONumber(Const Value :String);begin	SetStringfield('CustPONumber',Value);End;
Procedure TOrderbase.SetLastUpdated(Const Value :TDateTime);begin	SeTDateTimefield('LastUpdated',Value);End;
Procedure TOrderbase.SetApproved(Const Value :Boolean);begin  SetBooleanfield('Approved',Value);End;
procedure TOrderBase.SetApproverID(const Value: integer);begin  SetIntegerField('ApproverID', Value);end;
procedure TOrderBase.SetPickUpfromID(const Value: integer);begin  SetIntegerField('PickUpfromID', Value);end;
procedure TOrderBase.SetShiptoClassID(const Value: integer);begin  SetIntegerField('ShiptoClassID', Value);end;
procedure TOrderBase.SetCustField1(const Value : String);   begin SetStringfield('CustField1',   Value);   end;
procedure TOrderBase.SetCustField2(const Value : String);   begin SetStringfield('CustField2',   Value);   end;
procedure TOrderBase.SetCustField3(const Value : String);   begin SetStringfield('CustField3',   Value);   end;
procedure TOrderBase.SetCustField4(const Value : String);   begin SetStringfield('CustField4',   Value);   end;
procedure TOrderBase.SetCustField5(const Value : String);   begin SetStringfield('CustField5',   Value);   end;
procedure TOrderBase.SetCustField6(const Value : String);   begin SetStringfield('CustField6',   Value);   end;
procedure TOrderBase.SetCustField7(const Value : String);   begin SetStringfield('CustField7',   Value);   end;
procedure TOrderBase.SetCustField8(const Value : String);   begin SetStringfield('CustField8',   Value);   end;
procedure TOrderBase.SetCustField9(const Value : String);   begin SetStringfield('CustField9',   Value);   end;
procedure TOrderBase.SetCustField10(const Value: String);   begin SetStringfield('CustField10',  Value);   end;
Procedure TOrderbase.SetArea(const Value: String);begin  SetStringField('Area' , Value);end;
procedure TOrderBase.SetClientName(const Value : String);begin  SupplierName := Value;end;
Procedure TOrderBase.SetTypeOfBasedOn(Const Value: String);       Begin  SetStringField('TypeOfBasedOn', Value);  End;
Procedure TOrderBase.SetFrequencyValues(Const Value: String);     Begin  SetStringField('FrequencyValues', Value);  End;
Procedure TOrderBase.SetCopyStartDate(Const Value: TDateTime);    Begin  SetDateTimeField('CopyStartDate', Value);  End;
Procedure TOrderBase.SetCopyFinishDate(Const Value: TDateTime);   Begin  SetDateTimeField('CopyFinishDate', Value);  End;

procedure TOrderBase.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if Assigned(fSupplier)        then Freeandnil(fSupplier);
  fPopupDisplayed := False;
end;

procedure TOrderBase.PopulateMessageSubstituteList(SL: TStringList);
var
  s: string;
  qry : TERPQuery;
begin
  inherited;
  s:=
    'Select p.PurchaseOrderId ,  ' +
    ' C.FirstName, ' +
    ' P.ShipTo, ' +
//    ' concat(PL.Productname ,"     : Shipped " ,  PL.UnitofMeasureShipped , "  of  " ,   concat(PL.UnitofMeasurePOLines , " (" , PL.UnitofMeasureMultiplier , ")" )) details ' +
    ' concat(PL.Productname ,"     : Shipped " ,  PL.UnitofMeasureShipped , "  of  " , PL.QtySold, " ",    concat(PL.UnitofMeasurePOLines , " (" , PL.UnitofMeasureMultiplier , ")" )) details ' +
    ' from tblpurchaseorders p ' +
    ' inner join tblpurchaselines PL on P.PurchaseOrderId = PL.PurchaseOrderId   ' +
    ' inner join tblclients c on c.clientId = p.clientID' +
//    ' where ifnull(PL.UnitofMeasureShipped,0) <> 0 and
    ' where P.PurchaseOrderId = ' + IntToStr(ID);

  qry := TERPQuery(GetNewDataset(s));
  try
    SL.Values['#POID#'] := IntToStr(ID);
    SL.Values['#ShippingAddress#'] := qry.Fieldbyname('ShipTo').asString;
    SL.Values['#Products#'] := qry.Groupconcat('Details' , '' , False, #13#10 );
    SL.Values['#FirstName#'] := qry.Fieldbyname('FirstName').asString;
  finally
    qry.Free;
  end;
end;

function TOrderBase.GetShipToId: integer;
begin
  result := GetIntegerField('ShipToId');
end;

Function TOrderBase.GetSQL: String;
begin
    result:= inherited GetSQL;
end;

Function TOrderbase.UpdateAccounts:Boolean;
var
  CleanSupplierID: Integer;
  CleanTotalAmountInc: Double;
  CleanNode: IXMLNode;
  CleanGlaccountid: Integer;
  TaxPaidID: Integer;
begin
    Show_Status('Update Accounts.');
    if not Self.Invoiced then begin
        REsult := True;
        Exit;
    end;

    TaxPaidID:= tcDataUtils.getAccountID(tcConst.GLACCOUNT_TAX_PAID);
    CleanNode:= self.CleanXMLNode;
    if assigned(CleanNode) and (GetXMLNodeBooleanValue(CleanNode,'Invoiced')) then  begin
        CleanTotalAmountInc:= GetXMLNodeFloatValue(CleanNode,'Totalamountinc');
        CleanSupplierID:= GetXMLNodeIntegerValue(CleanNode,'Clientid');
        if (CleanTotalAmountInc=0) and (CleanSupplierID =0) then else begin
          POstList.AddAmount(Supplier.ClassName, Supplier.BusObjectTableName,
            CleanSupplierID, -(CleanTotalAmountInc) , btAP);

          CleanGlaccountid:= GetXMLNodeIntegerValue(CleanNode,'Glaccountid');
          PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
            CleanGlaccountid, -(CleanTotalAmountInc));

          PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
            TaxPaidID, -(GetXMLNodeFloatValue(CleanNode,'Totaltax')));
        end;
    end;


    PostList.AddAmount(Supplier.ClassName, Supplier.BusObjectTableName,
         SupplierID,  TotalAmountInc , btAP);

    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
      Glaccountid,  TotalAmountInc);

    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
      TaxPaidID, TotalTax);

    Lines.IterateRecords(LineBalanceCallbackProc, True);

    REsult := True;
end;
Procedure TOrderBase.AddToPayAuthorisations;
var
    ActionType :String;
    IsReadOnlySave: boolean;
begin
         if Self is TBill           then ActionType := 'Bill no'
    else if Self is TPurchaseOrder  then ActionType := 'Purchase Order No'
    else if Self is TCredit         then ActionType := 'Credit No'
    else Exit;{not applicable for cheque  and RA which is also a descendant of this class}
    IsReadOnlySave:= PaysActionAuthorisations.IsReadonly;
    PaysActionAuthorisations.IsReadonly:= false;
    try
      PaysActionAuthorisations.New;
      PaysActionAuthorisations.ActionType     := ActionType + ' ' + IntToStr(ID);
      PaysActionAuthorisations.Who            := AppEnv.Employee.LogonName;
      PaysActionAuthorisations.Date           := now;
      PaysActionAuthorisations.Actionsuccess  := (Approved= True);
      PaysActionAuthorisations.PostDB;
    finally
      PaysActionAuthorisations.IsReadonly:= IsReadOnlySave;
    end;
end;
function TOrderBase.ISInvNoUnique:Boolean;
begin
  Result := true;
    checkforUniqueInvoiceno;
end;
Function TOrderBase.IsBOInvoiced:boolean;
var
    StrSQL:String;
begin
    StrSQL :=   ' SELECT Sum(PL.Shipped) as ShippedSum ' +
                ' FROM tblPurchaseLines PL, tblPurchaseOrders  P' +
                ' WHERE PL.PurchaseOrderId = P.PurchaseOrderID ' +
                ' AND P.Baseno = ' + QuotedStr(Globalref);
    With getNewDataset(StrSQL) do try
        REsult := FieldByName('ShippedSum').AsFloat <> 0;
    finally
        if Active then close;
        Free;
    end;
end;

procedure TOrderBase.LineBalanceCallbackProc(Const Sender: TBusObj; var Abort: Boolean);
var
  CleanNode: IXMLNode;
  cleanProductType :String;
  CleanCogsAccntId :Integer;
  cleanCogsAmt :Double ;
  CleanTotLineAmt :Double;
begin
  CleanNode:= TPurchaseOrderLine(Sender).CleanXMLNode;
  if Assigned(CleanNode) then  begin
    cleanProductType := GetXMLNodeStringValue(CleanNode,'Producttype');
    CleanCogsAccntId    := GetXMLNodeIntegerValue(CleanNode,'Cogsaccntid');
    if Commonlib.IsInvProduct(cleanProductType) then begin

        cleanCogsAmt        := GetXMLNodeFloatValue(CleanNode,'Cogstotallineamount');
        CleanTotLineAmt     := GetXMLNodeFloatValue(CleanNode,'Totallineamount');

        PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
            CleanCogsAccntId, - cleanCogsAmt);

        PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
            GetXMLNodeIntegerValue(CleanNode,'Assetaccntid'), -(CleanTotLineAmt -   cleanCogsAmt ));
    end else if cleanProductType = 'NONINV' then begin
        cleanCogsAmt        := GetXMLNodeFloatValue(CleanNode,'CogstotallineAmount');
        PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
            CleanCogsAccntId, - cleanCogsAmt);
    end;
  end;
  if TPurchaseOrderLine(Sender).Deleted = False then begin
    if Commonlib.IsInvProduct(TPurchaseOrderLine(Sender).ProductType) then begin
        PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
            TPurchaseOrderLine(Sender).CogsAccntId, TPurchaseOrderLine(Sender).COGSTotalLineAmount);

        PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
            TPurchaseOrderLine(Sender).AssetAccntId, (TPurchaseOrderLine(Sender).TotalLineamount -   TPurchaseOrderLine(Sender).COGSTotalLineAmount ));
    end else if (TPurchaseOrderLine(Sender).ProductType = 'NONINV')  then begin
        PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,
            TPurchaseOrderLine(Sender).CogsAccntId, TPurchaseOrderLine(Sender).COGSTotalLineAmount);
    end;
  end;
end;
procedure TOrderBase.CheckOrderDate;
begin
  if cleanOrderDate = OrderDate then Exit;

    if (OrderDate <= AppEnv.CompanyPrefs.ClosingDate) then begin
      ResultStatus.AddItem(False, rssWarning , 0 , 'You Have Set This Date Before The Closing Date !' + #13 + #10 + '' + #13 + #10 +
        'The Date Will Automatically be Set To Today''s Date ' + #13 + #10 + '' + #13 + #10 + 'OR' + #13 +
        #10 + '' + #13 + #10 + 'Reset The Closing Date In Preferences.');
      OrderDate:= Now;
    end else if (OrderDate <= AppEnv.CompanyPrefs.ClosingDateAP) then begin
      ResultStatus.AddItem(False, rssWarning , 0 , 'You Have Set This Date Before The Closing Date !' + #13 + #10 + '' + #13 +
        #10 + 'The Date Will Automatically be Set To Today''s Date ' + #13 + #10 + '' + #13 + #10 + 'OR' +
        #13 + #10 + '' + #13 + #10 + 'Reset The Closing Date In Preferences.');
      OrderDAte := Now;
    end;
end;
procedure TOrderBase.SetDocNumber(const Value : String);
begin
  SetStringField('PurchaseOrderNumber', Value);
end;

procedure TOrderBase.SetOrderDate(const Value : TDateTime);
begin
  SeTDateTimeField('OrderDate', Value);
end;

procedure TOrderBase.SetSupplierId(const Value : Integer);
begin
  ClientId := Value;
end;

procedure TOrderBase.SetSupplierInvoiceDate(const Value : TDateTime);
begin
  SeTDateTimeField('InvoiceDate', Value);
end;

procedure TOrderBase.SetSupplierInvoiceNumber(const Value : String);
begin
  SetStringField('InvoiceNumber', Value);
end;

procedure TOrderBase.SetSupplierName(const Value : String);
begin
  SetStringField('SupplierName', Value);
end;
procedure TOrderBase.SaveToXMLNode(Const Node: IXMLNode);
begin
    AddXMLNode(node,'Refno',Refno);
    AddXMLNode(node,'Etadate',Etadate);
    AddXMLNode(node,'Salescomments',Salescomments);
    AddXMLNode(node,'OrgPurchaseOrderNumber',OrgPurchaseOrderNumber);
    AddXMLNode(node,'Shipping',Shipping);
    AddXMLNode(node,'Applyflag',Applyflag);
    AddXMLNode(node,'Amountdue',Amountdue);
    AddXMLNode(node,'Paymethod',Paymethod);
    AddXMLNode(node,'Ispo',Ispo);
    AddXMLNode(node,'Isra',Isra);
    AddXMLNode(node,'Isbill',Isbill);
    AddXMLNode(node,'Iscredit',Iscredit);
    AddXMLNode(node,'Ischeque',Ischeque);
    AddXMLNode(node,'IsRefundCheque',IsRefundCheque);
    AddXMLNode(node,'RefundGlobalref',RefundGlobalref);
    AddXMLNode(node,'Ispocredit',Ispocredit);
    AddXMLNode(node,'Editedflag',Editedflag);
    AddXMLNode(node,'Connote',Connote);
    AddXMLNode(node,'ShipToCustomer',ShipToCustomer);
    AddXMLNode(node,'ShipToClass',ShipToClass);
    AddXMLNode(node,'ShipToDefaultAddress',ShipToDefaultAddress);
    AddXMLNode(node,'Custponumber',Custponumber);
    AddXMLNode(node,'Lastupdated',Lastupdated);
    AddXMLNode(node,'Approved',Approved);
    AddXMLNode(node,'Area',Area);
    AddXMLNode(node,'Suppliername',Suppliername);
    AddXMLNode(node,'Orderto',Orderto);
    AddXMLNode(node,'Shipto',Shipto);
    AddXMLNode(node,'Supplierid',Supplierid);
    AddXMLNode(node,'Docnumber',Docnumber);
    AddXMLNode(node,'Glaccountname',Glaccountname);
    AddXMLNode(node,'Glaccountid',Glaccountid);
    AddXMLNode(node,'Totalbalance',Totalbalance);
    AddXMLNode(node,'Baseno',Baseno);
    AddXMLNode(node,'Backorderglobalref',Backorderglobalref);
    AddXMLNode(node,'Clientid',Clientid);
    AddXMLNode(node,'Deleted',Deleted);
    AddXMLNode(node,'Duedate',Duedate);
    AddXMLNode(node,'Employeeid',Employeeid);
    AddXMLNode(node,'Employeename',Employeename);
    AddXMLNode(node,'Enteredat',Enteredat);
    AddXMLNode(node,'Foreignbalanceamount',Foreignbalanceamount);
    AddXMLNode(node,'Foreignexchangecode',Foreignexchangecode);
    AddXMLNode(node,'Foreignexchangerate',Foreignexchangerate);
    AddXMLNode(node,'Foreignpaidamount',Foreignpaidamount);
    AddXMLNode(node,'Foreigntotalamount',Foreigntotalamount);
    AddXMLNode(node,'TotalDiscount',TotalDiscount);
    AddXMLNode(node,'Originaldocnumber',Originaldocnumber);
    AddXMLNode(node,'Ispaid',Ispaid);
    AddXMLNode(node,'Totalpaid',Totalpaid);
    AddXMLNode(node,'Termsname',Termsname);
    AddXMLNode(node,'Totalamount',Totalamount);
    AddXMLNode(node,'Totalamountinc',Totalamountinc);
    AddXMLNode(node,'Totaltax',Totaltax);
    AddXMLNode(node,'Enteredby',Enteredby);
    AddXMLNode(node,'Supplierinvoicedate',Supplierinvoicedate);
    AddXMLNode(node,'Supplierinvoicenumber',Supplierinvoicenumber);
    AddXMLNode(node,'Orderdate',Orderdate);
    AddXMLNode(node,'Suppliername',Suppliername);
    AddXMLNode(node,'Invoiced',Invoiced);
    AddXMLNode(node,'RARef',RARef);
    AddXMLNode(node,'OrderStatus',OrderStatus);
    AddXMLNode(node,'OrderStreet1', OrderStreet1);
    AddXMLNode(node,'OrderStreet2', OrderStreet2);
    AddXMLNode(node,'OrderStreet3', OrderStreet3);
    AddXMLNode(node,'OrderSuburb', OrderSuburb);
    AddXMLNode(node,'OrderState', OrderState);
    AddXMLNode(node,'OrderCountry', OrderCountry);
    AddXMLNode(node,'OrderPostcode', OrderPostcode);
    AddXMLNode(node,'ShipStreet1', ShipStreet1);
    AddXMLNode(node,'ShipStreet2', ShipStreet2);
    AddXMLNode(node,'ShipStreet3', ShipStreet3);
    AddXMLNode(node,'ShipSuburb', ShipSuburb);
    AddXMLNode(node,'ShipState', ShipState);
    AddXMLNode(node,'ShipCountry', ShipCountry);
    AddXMLNode(node,'ShipPostode', ShipPostcode);
    AddXMLNode(node,'OrderStatus',OrderStatus);
    inherited;

end;

procedure TOrderBase.LoadFromXMLNode(Const Node: IXMLNode);
begin
    SetPropertyFromNode(Node, 'Suppliername');
    SetPropertyFromNode(Node, 'Supplierid');
    SetPropertyFromNode(Node, 'Orderto');
    SetPropertyFromNode(Node, 'Shipto');
    SetPropertyFromNode(Node, 'Refno');
    SetPropertyFromNode(Node, 'Salescomments');
    SetPropertyFromNode(Node, 'OrgPurchaseOrderNumber');
    SetPropertyFromNode(Node, 'Shipping');
    SetPropertyFromNode(Node, 'Connote');
    SetPropertyFromNode(Node, 'Custponumber');
    SetBooleanPropertyFromNode(Node, 'ShipToCustomer');
    SetBooleanPropertyFromNode(Node, 'ShipToClass');
    SetBooleanPropertyFromNode(Node, 'ShipToDefaultAddress');
    SetBooleanPropertyFromNode(Node,'Applyflag');
    SetBooleanPropertyFromNode(Node,'Ispo');
    SetBooleanPropertyFromNode(Node,'Isra');
    SetBooleanPropertyFromNode(Node,'Isbill');
    SetBooleanPropertyFromNode(Node,'Iscredit');
    SetBooleanPropertyFromNode(Node,'Ischeque');
    SetBooleanPropertyFromNode(Node,'IsRefundCheque');
    SetPropertyFromNode(Node,'RefundGlobalref');
    SetBooleanPropertyFromNode(Node,'Ispocredit');
    SetBooleanPropertyFromNode(Node,'Editedflag');
    SetBooleanPropertyFromNode(Node,'Approved');
    SetPropertyFromNode(Node, 'Area');

    SetPropertyFromNode(Node,'Paymethod');
    SeTDateTimePropertyFromNode(Node,'Etadate');
    SeTDateTimePropertyFromNode(Node,'Lastupdated');
    SetPropertyFromNode(Node,   'Amountdue');
    SetPropertyFromNode(Node, 'Docnumber');
    SetPropertyFromNode(Node, 'Glaccountname');
    SetPropertyFromNode(Node, 'Glaccountid');
    SetPropertyFromNode(Node, 'Totalbalance');

    SetBooleanPropertyFromNode(Node, 'Deleted');
    SeTDateTimePropertyFromNode(Node, 'Duedate');
    SetPropertyFromNode(Node, 'Employeeid');
    SetPropertyFromNode(Node, 'Employeename');
    SetPropertyFromNode(Node, 'AreaCode');
    SetPropertyFromNode(Node, 'Enteredat');
    SetPropertyFromNode(Node, 'Foreignbalanceamount');
    SetPropertyFromNode(Node, 'Foreignexchangecode');
    SetPropertyFromNode(Node, 'Foreignexchangerate');
    SetPropertyFromNode(Node, 'Foreignpaidamount');
    SetPropertyFromNode(Node, 'Foreigntotalamount');
    SetPropertyFromNode(Node, 'TotalDiscount');
    if not ImportingFromXMLFile then begin
      SetPropertyFromNode(Node, 'Originaldocnumber');
      SetPropertyFromNode(Node, 'Baseno');
      SetPropertyFromNode(Node, 'Backorderglobalref');
    End;
    SetBooleanPropertyFromNode(Node, 'Ispaid');
    SetPropertyFromNode(Node, 'Totalpaid');
    SetPropertyFromNode(Node, 'Termsname');
    SetPropertyFromNode(Node, 'Totalamount');
    SetPropertyFromNode(Node, 'Totalamountinc');
    SetPropertyFromNode(Node, 'Totaltax');
    SetPropertyFromNode(Node, 'Enteredby');
    SetPropertyFromNode(Node, 'RARef');
    SetPropertyFromNode(Node, 'OrderStatus');
    SeTDateTimePropertyFromNode(Node, 'Supplierinvoicedate');
    SetPropertyFromNode(Node, 'Supplierinvoicenumber');
    SeTDateTimePropertyFromNode(Node, 'Orderdate');
    inherited;
end;




function TOrderbase.GetPaysActions : TPaysActionAuthorisations;
var
    strSQL :String;
begin
    REsult := nil;
         if Self is TBill           then strSQL := 'Bill no '
    else if Self is TPurchaseOrder  then strSQL := 'Purchase Order No'
    else if Self is TCredit         then strSQL := 'Credit No'
    else Exit;
    strSQL := 'Type = ' + quotedStr(strSQL + IntToStr(ID));
    REsult := TPaysActionAuthorisations(getcontainercomponent(TPaysActionAuthorisations , strSQL));
end;
Function TOrderBase.GetExpenseClaimEmployee: Integer;
begin
  Result := GetIntegerField('ExpenseClaimEmployee');
end;

procedure TOrderBase.SetExpenseClaimEmployee(const Value : Integer);
begin
  SetIntegerField('ExpenseClaimEmployee', Value);
end;

class Function TOrderLineBase.GetIDField :String ;
begin
  Result :='PurchaseLineId';
end;

class function TOrderLineBase.GetBusObjectTablename: string;
begin
  Result := 'tblPurchaseLines';
end;

class Function TOrderBase.GetIDField :String ;
begin
  Result := 'PurchaseOrderId';
end;

class function TOrderBase.GetBusObjectTablename: string;
begin
  Result := 'tblPurchaseOrders';
end;
      {TPaysActionAuthorisations}

Constructor TPaysActionAuthorisations.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblpaysactionauthorisations';
end;


Destructor TPaysActionAuthorisations.Destroy;
begin
  inherited;
end;


Procedure TPaysActionAuthorisations.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Type');
  SetPropertyFromNode(node,'Who');
  SetPropertyFromNode(node,'Date');
  SetPropertyFromNode(node,'ActionSuccess');
end;


Procedure TPaysActionAuthorisations.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Type' ,ActionType);
  AddXMLNode(node,'Who' ,Who);
  AddXMLNode(node,'Date' ,Date);
  AddXMLNode(node,'ActionSuccess' ,ActionSuccess);
end;


Function TPaysActionAuthorisations.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


Function TPaysActionAuthorisations.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


Procedure TPaysActionAuthorisations.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


Procedure TPaysActionAuthorisations.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


Function TPaysActionAuthorisations.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class Function TPaysActionAuthorisations.GetIDField: string;
begin
  Result := 'AuthorisationID'
end;
Class Function TPaysActionAuthorisations.GetBusObjectTablename :STring;
begin
    Result := 'tblpaysactionauthorisations';
end;

Function TPaysActionAuthorisations.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
Function  TPaysActionAuthorisations.GetType           : string    ; begin Result := GetStringField('Type');end;
Function  TPaysActionAuthorisations.GetWho            : string    ; begin Result := GetStringField('Who');end;
Function  TPaysActionAuthorisations.GetDate           : TDateTime ; begin Result := GetDateTimeField('Date');end;
Function  TPaysActionAuthorisations.GetActionSuccess  : Boolean   ; begin Result := GetBooleanField('ActionSuccess');end;
Procedure TPaysActionAuthorisations.SetType           (const Value: string    ); begin SetStringField('Type'            , Value);end;
Procedure TPaysActionAuthorisations.SetWho            (const Value: string    ); begin SetStringField('Who'             , Value);end;
Procedure TPaysActionAuthorisations.SetDate           (const Value: TDateTime ); begin SetDateTimeField('Date'            , Value);end;
Procedure TPaysActionAuthorisations.SetActionSuccess  (const Value: Boolean   ); begin SetBooleanField('ActionSuccess'   , Value);end;


function TOrderLineBase.ExcludeFromclone: String;
begin
        REsult := inherited ExcludeFromclone + ',' +QuotedStr('PurchaseOrderID');
end;

function TOrderLineBase.Delete: boolean;
var
  cmd: TERPCommand;
begin
  cmd:= TERPCommand.Create(nil);
  try
    cmd.Connection:= self.Connection.Connection;
    cmd.SQL.Text:= 'delete FROM tblShipContainerDetails WHERE  PurchaseLineId = ' + IntToStr(self.Id);
    try
      cmd.Execute;
    except
      on E: exception do begin
        result:= false;
        self.ResultStatus.AddItem(false,rssWarning,0,'Unable to remove Purchase Line from linked ShipContainerLine with message: ' + E.Message);
        exit;
      end;
    end;
  finally
    cmd.Free;
  end;
  result:= inherited Delete;
end;


destructor TOrderLineBase.Destroy;
begin
  if Assigned(fFEPOLines) then begin
    if (not fFEPOLines.ExternalDatasetAssigned) then FreeAndNil(fFEPOLines)
    else fFEPOLines.Dataset.close;
  end;
  inherited;
end;

function TOrderLineBase.ValidateData: Boolean;
begin
  result:= inherited ValidateData;
  if not result then exit;
  if self.ProductName = '' then begin
    Result:= false;
    ResultStatus.AddItem(false, rssWarning, 0,
      'Product name missing');
    exit;
  end;
  if (ProductId < 1) and (ProductName <> '') then begin
    AddResult(false,rssWarning,0,'Product not found: "' + ProductName + '"');
    Result:= false;
    exit;
  end;
  if AppEnv.CompanyPrefs.POEnforceETA then begin
    if Qtyshipped =0 then
      if self.ETADate = 0 then begin
        Result:= false;
        ResultStatus.AddItem(False, rssWarning, BOR_Order__NoProductETA,
        'ETA for Product ' + Self.Product.ProductName + ' is missing.');
        exit;
      end;
  end;
end;

function TOrderLineBase.GetTransDate: TDatetime;
begin
  // not required for bills
  result:= self.ReceivedDate;
end;
function TOrderLineBase.geTTransLineProductCustomFields: TTransLineProductCustomFields;
begin
  Result := TTransLineProductCustomFields(getContainerComponent(TTransLineProductCustomFields, 'PARTSID = '+ IntToStr(Self.ProductId)));
end;


Function TOrderLineBase.GetPurchaseTaxCode: TPurchaseTaxCode;
begin
  REsult :=TPurchaseTaxCode(getContainercomponent(TPurchaseTaxCode , 'PurchaseOrderID = ' +inttostr(HeaderID) +' and PurchaseLineId = ' +inttostr(ID)));
  Result.IgnoreAccesslevel := True;
end;
function TOrderLineBase.getTransTaxCode: TTransTaxCode;
begin
  result := PurchaseTaxCode;
end;

procedure TOrderLineBase.SetTransDate(const Value: TDatetime);
begin
  inherited;

end;


function TOrderLineBase.getSupplierName: String;
begin
  Result := '';
  if Assigned(Self.Owner) then
    if Self.owner is TPurchaseOrder then
      Result := TPurchaseOrder(Self.Owner).SupplierName;
end;

function TOrderLineBase.getsupplierID: Integer;
begin
  Result := 0;
  if Assigned(Self.Owner) then
    if Self.owner is TPurchaseOrder then
      Result := TPurchaseOrder(Self.Owner).SupplierId;
end;

function TOrderLineBase.getCustomerEquipmentID: Integer;
begin
   REsult := GetIntegerField('CustomerEquipmentID');
end;

function TOrderLineBase.getEquipmentName: String;
begin
  Result := GetStringField('EquipmentName')
end;

function TOrderLineBase.getRepairId: Integer;
begin
     REsult := GetIntegerField('RepairId');
end;

procedure TOrderLineBase.setCustomerEquipmentID(const Value: Integer);
begin
  SetIntegerField('CustomerEquipmentID' , Value);
end;

procedure TOrderLineBase.SetEquipmentName(const Value: String);
begin
  SetStringfield('EquipmentName' ,Value);
end;

procedure TOrderLineBase.setRepairId(const Value: Integer);
begin
  SetIntegerField('RepairId' , value);
end;


function TOrderBase.getShipToCustomer: boolean;
begin
  Result := getBooleanfield('ShipToCustomer');
end;
function TOrderBase.getShipToClass: boolean;
begin
  Result := getBooleanfield('ShipToClass');
end;
function TOrderBase.getShipToDefaultAddress: boolean;
begin
  Result := getBooleanfield('ShipToDefaultAddress');
end;

procedure TOrderBase.SetShipToCustomer(const Value: boolean);
begin
  SetBooleanfield('ShipToCustomer' , Value);
end;
procedure TOrderBase.SetShipToClass(const Value: boolean);
begin
  SetBooleanfield('ShipToClass' , Value);
end;
procedure TOrderBase.SetShipToDefaultAddress(const Value: boolean);
begin
  SetBooleanfield('ShipToDefaultAddress' , Value);
end;

procedure TOrderBase.SetShipToId(const Value: integer);
begin
  SetIntegerField('ShipToId', Value);
end;

destructor TOrderBase.Destroy;
begin
  LineSum.Free;
  FreeAndNil(fShipToAddressRec);
  inherited;
end;

function TOrderBase.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
end;

procedure TOrderBase.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
{---} if Sysutils.SameText(Sender.FieldName , 'SupplierName') then begin
        if Self.Supplier.POCommentPopUp then begin
          If (not fPopupDisplayed) then Begin
            AddEvent(BusObjEvent_POCommentPopUp, self.Supplier.POComment, Self.ID);
            fPopupDisplayed := True;
          end;
        end else if self.Comments = '' then
          self.Comments :=  self.Supplier.POComment;
{---} end else if Sysutils.SameText(Sender.fieldName, 'ClientID') then begin
        if clientId <> 0 then begin
            suppliername := Supplier.clientName;
            ClientPrintName := Supplier.PrintName;
        end;
{---} end else if Sysutils.SameText(Sender.fieldName, 'ApproverID') then begin
        SendEvent(BusObjEvent_Change, BusobjEventVal_ApproverID, self);
{---} end;
end;

function TOrderLineBase.GetTotalLineLandedCost: double;
begin
//  result:= CommonLib.Round(UnitLandedCost * QtySold,CurrencyRoundPlaces);
  result:= CommonLib.Round(UnitLandedCost * QtyShipped, CurrencyRoundPlaces);
end;

function TOrderLineBase.DoCalcFields(sender: TDatasetBusObj): boolean;
var
  fld: TField;
begin
  REsult := True;
  try
    Result:= inherited DoCalcFields(Sender);
    if not result then Exit;
    fld:= Dataset.FindField('TotalLineLandedCost');
    if Assigned(fld) then
      fld.AsFloat:= self.TotalLineLandedCost;
  Except
  end;
end;


function TOrderBase.ValidateData: Boolean;
begin
  result := inherited;
  if not result then
    exit;
  checkforUniqueInvoiceno;
end;

procedure TOrderBase.checkforUniqueInvoiceno;
begin
  if SupplierInvoiceNumber<> '' then begin
        with getNewdataset('select PO.PurchaseOrderId  from tblpurchaseorders PO  inner join tblpurchaselines PL on PL.PurchaseOrderId = PO.PurchaseOrderId' +
                          ' where PO.InvoiceNumber =' +quotedStr(SupplierInvoiceNumber)+
                          ' and ifnull(PO.Deleted,"F") ="F" ' +
                          ' and PO.ClientID = ' + IntToStr(self.ClientId) +
                          ' and PO.PurchaseOrderId <>' +IntToStr(ID)) do try
            if  recordcount > 0 then begin
                ResultStatus.addItem(False, rssInfo , 0 ,
                        'Invoice Number #' +SupplierInvoiceNumber+' already exists in  ' +chr(13)+
                        PO_Type(FieldByname('PurchaseOrderID').asInteger)+'#' +IntToStr(FieldByname('PurchaseOrderId').asInteger) +'.'+ chr(13) +chr(13)+
                        'Changed to ' +SupplierInvoiceNumber+'(' +IntToStr(ID)+')');
                SupplierInvoiceNumber := SupplierInvoiceNumber  +'(' +IntToStr(ID)+')';
                PostDB;
            end;
        finally
            if active then close;
            Free;
        end;
    end;
end;

//procedure TOrderLineBase.UpdateProductBuyPrice(const aBuyPrice: double);
//var
//  msg: String;
//begin
//  if AppEnv.CompanyPrefs.DisableAltSaveCost then exit;
//  if Product.BuyQty1Cost = aBuyPrice then exit;
//  if Product.Lock then begin
//    try
//      Product.BuyQty1 := 1;
//      Product.BuyQty2 := 1;
//      Product.BuyQty3 := 1;
//      Product.BuyQty1Cost := aBuyPrice;
//      Product.BuyQty2Cost := aBuyPrice;
//      Product.BuyQty3Cost := aBuyPrice;
//      Product.Save;
//    finally
//      Product.UnLock;
//    end;
//  end
//  else begin
//    if not self.SilentMode then begin
//      msg := 'Unable to update ' + Product.ProductName + '''s cost record as product is being updated by "' +
//        Product.UserLock.LockInfo.UserName + '" with: ' + Product.UserLock.LockInfo.LockingForm;
//        //ResultStatus.AddItem(true, rssWarning, 1, msg );
//      MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
//    end;
//  end;
//end;

function TOrderLineBase.getProcTreeId: Integer;
begin
  REsult := GetIntegerField('ProcTreeId');
end;

procedure TOrderLineBase.setProcTreeId(const Value: Integer);
begin
    SetIntegerField('ProcTreeId' , Value);
end;

function TOrderLineBase.GetSupplierProductCode: string;
begin
  result:= GetStringField('SupplierProductCode');
end;

function TOrderLineBase.GetSupplierProductName: string;
begin
  result:= GetStringField('SupplierProductName');
end;
function TOrderLineBase.GetSupplierBarCode: string;
begin
  result:= GetStringField('SupplierBarCode');
end;

procedure TOrderLineBase.SetSupplierProductCode(const Value: string);
begin
  SetStringField('SupplierProductCode', Value);
end;

procedure TOrderLineBase.SetSupplierProductName(const Value: string);
begin
  SetStringField('SupplierProductName', Value);
end;
procedure TOrderLineBase.SetSupplierBarCode(const Value: string);
begin
  SetStringField('SupplierBarCode', Value);
end;

function TOrderLineBase.getRALineRef: String;begin  REsult := getStringfield('RALineRef' );end;
function TOrderLineBase.getEmployeeName: String;begin  REsult := getStringfield('EmployeeName' );end;
function TOrderLineBase.getAreaCode: String;begin  REsult := getStringfield('AreaCode' );end;
procedure TOrderLineBase.setRALineRef(const Value: String);begin  SetStringfield('RALineRef' , Value);end;
procedure TOrderLineBase.setEmployeeName(const Value: String);begin  SetStringfield('EmployeeName' , Value);end;
procedure TOrderLineBase.SetAreaCode(const Value: String);begin  SetStringfield('AreaCode' , Value);end;
function TOrderBase.getRARef: String;begin  REsult := getStringfield('RARef' );end;
function TOrderBase.getOrderStatus: String;begin  REsult := getStringfield('OrderStatus' );end;
function TOrderBase.getPickupFromDesc: String;begin  REsult := getStringfield('PickupFromDesc' );end;
procedure TOrderBase.setRARef(const Value: String);begin  SetStringfield('RARef' , Value);end;
procedure TOrderBase.setOrderStatus(const Value: String);begin  SetStringfield('OrderStatus' , Value);end;
procedure TOrderBase.setPickupFromDesc(const Value: String);begin  SetStringfield('PickupFromDesc' , Value);end;

function TOrderLineBase.getPOLinesUOMDetails: TTransLinesUOMDetails;
begin
  Result := TTransLinesUOMDetails(getContainerComponent(TTransLinesUOMDetails, 'UnitID = '+ IntToStr(Self.UnitOfMeasureID)));
end;

function TOrderLineBase.getPrintedValue: Double;
begin
  REsult := getfloatfield('PrintedValue' );
end;

procedure TOrderLineBase.setPrintedValue(const Value: Double);
begin
  SetFloatfield('PrintedValue' , Value);
end;


function TOrderBase.getOrderLines: TOrderLineBase;
begin
    result := nil;
end;

function TOrderBase.GetOrderPostcode: string;
var s: string;
begin
  result := '';
  s := Lowercase(OrderTo);
  if (Supplier.PostCode <> '') and (Pos(Lowercase(Supplier.PostCode), s) > 0) then
    result := Supplier.PostCode;
end;

function TOrderBase.GetOrderState: string;
var s: string;
begin
  result := '';
  s := Lowercase(OrderTo);
  if (Supplier.State <> '') and (Pos(Lowercase(Supplier.State), s) > 0) then
    result := Supplier.State;
end;

function TOrderLineBase.getDiscountPercent: double;
begin
  Result := getFloatfield('DiscountPercent');
end;

procedure TOrderLineBase.setDiscountPercent(const Value: double);
begin
  SetFloatfield('DiscountPercent' , Value);
end;
function TOrderLineBase.getDiscountAmount: double;
begin
  Result := getFloatfield('DiscountAmount');
end;

procedure TOrderLineBase.setDiscountAmount(const Value: double);
begin
  SetFloatfield('DiscountAmount' , Value);
end;

function TOrderLineBase.getOriginalCost: Double;
begin
  Result := getfloatfield('OriginalCost');
end;

procedure TOrderLineBase.setOriginalCost(const Value: Double);
begin
  SetfloatField('OriginalCost' , Value);
end;

function TOrderLineBase.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;

  if assigned(Self.Owner) then
    if self.Owner is TOrderBase then
      PurchaseOrderId := TOrderBase(Self.Owner).Id;

  DiscountPercent:=0;
  DiscountAmount:=0;
  EmployeeName :=AppEnv.Employee.EmployeeName;
  EmployeeID := AppEnv.Employee.EmployeeID;
  if appenv.CompanyPrefs.PODefaultValueForAreaFrom ='S' then
    AreaCode := supplierAreaCode;
end;
function TOrderLineBase.supplierAreaCode:String;
begin
  Result:= '';
  if Assigned(Owner) then
    if owner is TOrderBase then
      result:= TOrderBase(Owner).Supplier.Area;
end;
procedure TOrderLineBase.PostFERecords;
var
  bm: TBookMArk;
  POlinehasformula: Boolean;
  fdQty :double;
begin
  bm := Self.Dataset.Getbookmark;
  try
    { if formula selected for the same product then apply }
    POlinehasformula := False;
    if FEPOLines.Lines.Locate('ProductId', Self.ProductID, []) then begin
      POlinehasformula := True;

      FormulaQtySoldValue1 := FEPOLines.Field1;
      FormulaQtySoldValue2 := FEPOLines.Field2;
      FormulaQtySoldValue3 := FEPOLines.Field3;
      FormulaQtySoldValue4 := FEPOLines.Field4;
      FormulaQtySoldValue5 := FEPOLines.Field5;
      FormulaQtySoldValue  := FEPOLines.Lines.RelatedQty;

      FormulaQtyShippedValue1 := FEPOLines.ShippedField1;
      FormulaQtyShippedValue2 := FEPOLines.ShippedField2;
      FormulaQtyShippedValue3 := FEPOLines.ShippedField3;
      FormulaQtyShippedValue4 := FEPOLines.ShippedField4;
      FormulaQtyShippedValue5 := FEPOLines.ShippedField5;
      FormulaQtyShippedValue  := FEPOLines.Lines.RelatedShippedQty;


      fdQty := FormulaQtySoldValue;
      QtySold := fdQty;
      UOMQtySold := CommonLib.Round(QtySold / UOMMultiplier, Self.RoundPlacesGeneral);
      PostDB;

      fdQty := FormulaQtyShippedValue;
      if QtySold <fdQty then begin
        QtySold := fdQty;
        UOMQtySold := CommonLib.Round(QtySold / UOMMultiplier, Self.RoundPlacesGeneral);
      end;
      QtyShipped := fdQty;
      UOMQtyShipped := CommonLib.Round(QtyShipped / UOMMultiplier, Self.RoundPlacesGeneral);

      FormulaID := FEPOLines.Lines.FormulaID;
      PostDB;

    end;
    if (((FEPOLines.Count >= 1) and (POlinehasformula = False)) or (FEPOLines.Count > 2)) and (Product.isDiscontinued = False) and (UOMQtySold = 0) then begin
      UOMQtySold := 1;
      PostDB;
    end;
  finally
    Self.Dataset.gotobookmark(bm);
    Self.Dataset.FreeBookmark(bm);
  end;
end;

function TOrderBase.getTotalDiscount: Double;
begin
  result := GetFloatField('TotalDiscount');
end;

function TOrderBase.GetTransDate: TDateTime;
begin
  Result := OrderDate;
end;

function TOrderBase.getTransLinetotals: TTransLinetotals;
begin
  Result := TTransLinetotals(getContainerComponent(TTransLinetotals , 'PurchaseOrderID = ' + IntToStr(ID)));
end;

function TOrderBase.GetTransName: String;
begin
    Result := '';
         if IsPO           then result := 'Purchase Order'
    else if IsRA	         then result := 'Return Authority'
    else if IsBill	       then result := 'Bill'
    else if IsCredit	     then result := 'Credit'
    else if IsCheque	     then result := 'Cheque'
    else if IsPOCredit	   then result := 'PO Credit'
    else result := 'Purchase';
end;

procedure TOrderBase.setTotalDiscount(const Value: Double);
begin
  SetFloatfield('TotalDiscount' , Value);
end;
function TOrderLineBase.DoBeforePost(Sender: TDatasetBusobj): boolean;
var
  disc: double;
begin
  result := inherited DoBeforePost(Sender);
  if not result then exit;
  disc := Round(OriginalCost*QtyShipped * (1 + LineTaxRate),CurrencyRoundPlaces)  - TotalLineAmountInc;
  if DiscountAmount <> disc then
    DiscountAmount := disc;
end;

procedure TOrderLineBase.Applydiscount;
var
  oldLinecost : Double;
  OldOriginalcost:Double;
begin
    OldLinecost       :=Linecost;
    OldOriginalcost:= OriginalCost;

    Linecost := Round(OriginalCost - (OriginalCost * (DiscountPercent/100)), RoundPlacesGeneral);
    LineCostInc := Round(LineCost * (1 + LineTaxRate),RoundPlacesGeneral);
    CalcLineTotals;
    if productID<> 0 then if Assigned(Owner) and (Owner is TOrderBase) then TOrderBase(Owner).DoCalcOrderTotals;

//    if (oldLinecost <> LineCost) or (OldOriginalcost <>OriginalCost) then
//        if (not SilentMode) and (not AppEnv.CompanyPrefs.DisableAltSaveCost) then begin
//            UpdateProductBuyCostFromLineCost;
//            CheckAndUpdateProductForeignBuyPrice;
//        end;

    if (oldLinecost <> LineCost) or (OldOriginalcost <> OriginalCost) then begin
        if (not SilentMode) and (not AppEnv.CompanyPrefs.DisableAltSaveCost) then begin
            if (oldLinecost <> LineCost) or (OldOriginalcost <> OriginalCost) then begin
              if self.Product.CostUpdateFromPurchase then
                UpdateProductBuyCostFromLineCost;
            end;
            CheckAndUpdateProductForeignBuyPrice;
        end;
    end;
end;

procedure TOrderLineBase.CheckAndUpdateProductForeignBuyPrice;
begin
//desendants will overrride
end;
procedure TOrderLineBase.CalcLineForeingAmount;
begin
  ForeignLineCost := CommonLib.LocalToForeign(LineCostinc, TOrderBase(Owner).ForeignExchangeRate, RoundPlacesGeneral);
  if self is TExpenseLineBase then
    ForeignTotalLineAmount :=ForeignLineCost
  else ForeignTotalLineAmount := Round(ForeignLineCost * QtyShipped, CurrencyRoundPlaces);
end;
procedure TOrderBase.CalcForeignAmount;
begin
  inherited;
  fdTotalForeignAmount := 0;
  Lines.IterateREcords(CalcForeignAmountCallback);
  ForeignTotalAmount := Round(fdTotalForeignAmount, CurrencyRoundPlaces);
end;

procedure TOrderBase.CalcForeignAmountCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if TOrderLineBase(Sender).Deleted then Exit;  { deleted records amount should not be added into total }
  inherited;
  TOrderLineBase(Sender).CalcLineForeingAmount;
  fdTotalForeignAmount := fdTotalForeignAmount + TOrderLineBase(Sender).ForeignTotalLineAmount;
end;
Procedure TOrderBase.GetClientDetails;
begin
  inherited;
  if ClientId <> 0 then begin
     if AppEnv.CompanyPrefs.PurchaseDefaultAreaFromSupplier and (Area = '') then
      Area := Supplier.Area;
  end;
end;

procedure TOrderBase.ProcessDeletedLine;
var
  IsFiltered: Boolean;
begin
  inherited;
  Lines.FEPOLines.Lines.Dataset.DisableControls;
  IsFiltered := Lines.FEPOLines.Lines.Dataset.Filtered;
  Lines.FEPOLines.Lines.Dataset.Filtered := False;
  if Lines.FEPOLines.Lines.Count > 0 then begin
    Lines.FEPOLines.Lines.first;
    while not Lines.FEPOLines.Lines.Dataset.EOF do begin
      if (Lines.FEPOLines.Lines.Deleted) or (Lines.Deleted) then Lines.FEPOLines.Lines.delete
      else Lines.FEPOLines.Lines.Dataset.Next;
    end;
    Lines.FEPOLines.Lines.Dataset.Filtered := IsFiltered;
  end;
  Lines.FEPOLines.Lines.Dataset.EnableControls;

end;

initialization
  RegisterClassOnce(TPaysActionAuthorisations);
end.




















