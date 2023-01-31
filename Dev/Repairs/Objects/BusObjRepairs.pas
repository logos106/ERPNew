unit busobjrepairs;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  03/04/07   1.00.01   Binny   Initial Version.
}

interface

uses BusObjBase, ProgressDialog, DB, Classes, XMLDoc, XMLIntf, BusObjClient, BusObjTimeSheet,
  busobjstock, BusObjEquipment, BusObjSmartOrder, busobjtrans, busobjPQA,
  ClientDiscountObj, busobjOrders, BusObjManufacture, MyAccess, ERPdbComponents,
  BusObjCommon, BusObjFixedAsset, BusObjCorrespondence, busobjattachment,
  BusObjShippingAddress;

type
  TDoProductallocation = Function(Const LineObj: TProdQty): Boolean of Object;
  TDiscountMarkuptype = (dmDiscount=1, dmDiscountPercent=2 , dmMarkup=3, dmMarkupPercent=4);

  TRepairs = class;

  TRepairDetails = class(TMSBusObj)
  private
    function GetRepairID: Integer;
    function GetGSFSReceiptNo: string;
    function GetFaultConditionID: Integer;
    function GetFaultSymptomID: Integer;
    function GetFaultDefectID: Integer;
    function GetFaultRepairID: Integer;
    function GetFaultSectionId: Integer;
    function GetFaultConditionDesc: string;
    function GetFaultSymptomDesc: string;
    function GetFaultDefectDesc: string;
    function GetFaultRepairDesc: string;
    function GetFaultSectionDesc: string;
    function GetFaultConditionCode: string;
    function GetFaultSymptomCode: string;
    function GetFaultDefectCode: string;
    function GetFaultRepairCode: string;
    function GetFaultSectionCode: string;
    function GetRepaircode: string;
    function GetMaterialcost: Double;
    function GetFreightcost: Double;
    function GetOtheramount: Double;
    function GetServicetype: string;
    function GetAuthorisationnumber: string;
    procedure SetRepairID(const Value: Integer);
    procedure SetGSFSReceiptNo(const Value: string);
    procedure SetFaultConditionID(const Value: Integer);
    procedure SetFaultSymptomID(const Value: Integer);
    procedure SetFaultDefectID(const Value: Integer);
    procedure SetFaultRepairID(const Value: Integer);
    procedure SetFaultSectionId(const Value: Integer);
    procedure SetFaultConditionDesc(const Value: string);
    procedure SetFaultSymptomDesc(const Value: string);
    procedure SetFaultDefectDesc(const Value: string);
    procedure SetFaultRepairDesc(const Value: string);
    procedure SetFaultSectionDesc(const Value: string);
    procedure SetFaultConditionCode(const Value: string);
    procedure SetFaultSymptomCode(const Value: string);
    procedure SetFaultDefectCode(const Value: string);
    procedure SetFaultRepairCode(const Value: string);
    procedure SetFaultSectionCode(const Value: string);
    procedure SetRepaircode(const Value: string);
    procedure SetMaterialcost(const Value: Double);
    procedure SetFreightcost(const Value: Double);
    procedure SetOtheramount(const Value: Double);
    procedure SetServicetype(const Value: string);
    procedure SetAuthorisationnumber(const Value: string);
    Procedure UpdateRepaircode;
    function getManInvDate: TDatetime;
    function getManInvNo: Integer;
    procedure setManInvDate(const Value: TDatetime);
    procedure setManInvNo(const Value: Integer);
    function getSerialNo: String;
    procedure setModel(const Value: String);
    procedure setSerialNo(const Value: String);
    function getModel: String;
    function getManufacture: String;
    function getManufactureId: Integer;
    procedure setManufacture(const Value: String);
    procedure SetManufactureId(const Value: Integer);
    function getRetailer: String;
    function getRetailerId: Integer;
    procedure setRetailer(const Value: String);
    procedure SetRetailerId(const Value: Integer);
    function getReceiptNumberCaption: String;
    procedure setReceiptNumberCaption(const Value: String);
    function getmanufactureObj: TManufacture;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    Property ManufactureObj: TManufacture Read getmanufactureObj;
    class function _Schema: string; override;
  published
    property RepairID: Integer read GetRepairID write SetRepairID;
    property GSFSReceiptNo: string read GetGSFSReceiptNo write SetGSFSReceiptNo;
    property FaultConditionID: Integer read GetFaultConditionID write SetFaultConditionID;
    property FaultSymptomID: Integer read GetFaultSymptomID write SetFaultSymptomID;
    property FaultDefectID: Integer read GetFaultDefectID write SetFaultDefectID;
    property FaultRepairID: Integer read GetFaultRepairID write SetFaultRepairID;
    property FaultSectionId: Integer read GetFaultSectionId write SetFaultSectionId;
    property FaultConditionDesc: string read GetFaultConditionDesc write SetFaultConditionDesc;
    property FaultSymptomDesc: string read GetFaultSymptomDesc write SetFaultSymptomDesc;
    property FaultDefectDesc: string read GetFaultDefectDesc write SetFaultDefectDesc;
    property FaultRepairDesc: string read GetFaultRepairDesc write SetFaultRepairDesc;
    property FaultSectionDesc: string read GetFaultSectionDesc write SetFaultSectionDesc;
    property FaultConditionCode: string read GetFaultConditionCode write SetFaultConditionCode;
    property FaultSymptomCode: string read GetFaultSymptomCode write SetFaultSymptomCode;
    property FaultDefectCode: string read GetFaultDefectCode write SetFaultDefectCode;
    property FaultRepairCode: string read GetFaultRepairCode write SetFaultRepairCode;
    property FaultSectionCode: string read GetFaultSectionCode write SetFaultSectionCode;
    property RepairCode: string read GetRepaircode write SetRepaircode;
    property MaterialCost: Double read GetMaterialcost write SetMaterialcost;
    property FreightCost: Double read GetFreightcost write SetFreightcost;
    property OtherAmount: Double read GetOtheramount write SetOtheramount;
    property ServiceType: string read GetServicetype write SetServicetype;
    property AuthorisationNumber: string read GetAuthorisationnumber write SetAuthorisationnumber;
    Property ManInvNo: Integer Read getManInvNo Write setManInvNo;
    Property ManInvDate: TDatetime Read getManInvDate Write setManInvDate;
    Property Model: String Read getModel Write setModel;
    Property SerialNo: String read getSerialNo Write setSerialNo;
    Property ManufactureID: Integer Read getManufactureId Write SetManufactureId;
    property Manufacture: String Read getManufacture Write setManufacture;
    Property RetailerID: Integer Read getRetailerId Write SetRetailerId;
    property Retailer: String Read getRetailer Write setRetailer;
    Property ReceiptNumberCaption: String read getReceiptNumberCaption
      Write setReceiptNumberCaption;
  end;

  TRepairEquipmentFault = class(TMSBusObj) // New Binny
  private
    function GetRepairID: Integer;
    function GetTimeSheetID: Integer;
    function GetRepairFault: string;
    function GetCustomerEquipmentID: Integer;
    function GetEquipment: string;
    function GetDeleted: Boolean;
    procedure SetRepairID(const Value: Integer);
    procedure SetTimeSheetID(const Value: Integer);
    procedure SetRepairFault(const Value: string);
    procedure SetCustomerEquipmentID(const Value: Integer);
    procedure SetEquipment(const Value: string);
    procedure SetDeleted(const Value: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    Function DoBeforePost(Sender: TDatasetBusObj): Boolean; Override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function _Schema: string; override;
  published
    property RepairID: Integer read GetRepairID write SetRepairID;
    property TimeSheetID: Integer read GetTimeSheetID write SetTimeSheetID;
    property RepairFault: string read GetRepairFault write SetRepairFault;
    property CustomerEquipmentID: Integer read GetCustomerEquipmentID write SetCustomerEquipmentID;
    property Equipment: string read GetEquipment write SetEquipment;
    property Deleted: Boolean read GetDeleted write SetDeleted;
  end;

  { this is a lookup object used by TRepairDetails }
  TRepairFaults = class(TMSBusObj)
  private
    function Getcode: string;
    function GetCategory: String;
    function GetDescription: string;
    function GetActive: Boolean;
    procedure Setcode(const Value: string);
    procedure SetCategory(const Value: String);
    procedure SetDescription(const Value: string);
    procedure SetActive(const Value: Boolean);
    function getManufacture: String;
    function getManufactureId: Integer;
    procedure setManufacture(const Value: String);
    procedure SetManufactureId(const Value: Integer);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function _Schema: string; override;
  published
    property Code: string read Getcode write Setcode;
    property Category: String read GetCategory write SetCategory;
    property Description: string read GetDescription write SetDescription;
    property Active: Boolean read GetActive write SetActive;
    Property ManufactureID: Integer Read getManufactureId Write SetManufactureId;
    property Manufacture: String Read getManufacture Write setManufacture;
  end;

  TRepairParts = class(TProdQty)
  private
    fProduct: TProduct;
    ParentQty: Double;
    fsRelatedParentLineRef: String;
    fiParentProductId: Integer;
    fClientDiscountObj: TClientDiscountObj;
    fiInvoiceToclientID: Integer;
    fiProductID: Integer;
    fiLineID: Integer;
    PrevCustomerEquipmentID: Integer;
    //fSaleLineGlobalRef: string;
    fbCalcQtyFromformula: Boolean;
    fLastDiscountRetMsg: string;
    Function GetRepairID: Integer;
    Function GetQuantity: Double;
    Function GetDescription: String;
    Function GetPriceex: Double;
    Function GetPriceinc: Double;
    Function GetTaxcode: String;
    Function GetPartBarcode: String;
    Function GetTaxrate: Double;
    Function GetDiscount: Double;
    Function GetMarkup: Double;
    Function GetDiscountpercent: Double;
    Function GetMarkuppercent: Double;
    Function GetLinetotalex: Double;
    Function GetClassname: String;
    Function GetConverttoinvoice: Boolean;
    Function GetEtadate: TDatetime;
    Function GetMemoline: String;
    Function getcalcTax: Double;
    //Function getcalcTotalEx: Double;
    Function getcalcTotalInc: Double;
    Function getcalcTotalIncBase: Double;
    Function GetProduct: TProduct;
    Function EmptyRecord: Boolean;
    function getParentProductID: Integer;
    function getParentLineRef: String;
    function getRelatedProductQty: Double;
    function getinvoiceLineRef: String;
    function getIsRelatedProduct: Boolean;
    Function ProductChanged: Boolean;
    function getCleanProductName: String;
    function GetDeleted: Boolean;
    function getPartIssuedOn: TDatetime;
    function getlineCost: Double;
    function getLinecostInc: Double;
    function getIsconverting: Boolean;
    function getSaleLineId: Integer;
    Procedure SetRepairID(Const Value: Integer);
    Procedure SetQuantity(Const Value: Double);
    Procedure SetDescription(Const Value: String);
    Procedure SetPriceex(Const Value: Double);
    Procedure SetPriceinc(Const Value: Double);
    Procedure SetTaxcode(Const Value: String);
    Procedure SetPartBarcode(Const Value: String);
    Procedure SetTaxrate(Const Value: Double);
    Procedure SetDiscount(Const Value: Double);
    Procedure SetMarkup(Const Value: Double);
    Procedure SetDiscountpercent(Const Value: Double);
    Procedure SetMarkuppercent(Const Value: Double);
    Procedure SetLinetotalex(Const Value: Double);
    Procedure SetClassname(Const Value: String);
    Procedure setClassID(Const Value: Integer);
    Procedure SetConverttoinvoice(Const Value: Boolean);
    Procedure SetEtadate(Const Value: TDatetime);
    Procedure SetMemoline(Const Value: String);
    Procedure SetcalcTax(Const Value: Double);
    //Procedure SetcalcTotalEx(Const Value: Double);
    Procedure SetcalcTotalInc(Const Value: Double);
    Procedure SetcalcTotalIncBase(Const Value: Double);
    Procedure SetProduct(Const Value: TProduct);
    Procedure CalcPartsTotalamount;
    function GetCustomerEquipmentID: Integer;
    function getEquipmentname: String;
    procedure SetCustomerEquipmentID(const Value: Integer);
    procedure SetEquipmentName(const Value: String);
    procedure SetDeleted(const Value: Boolean);
    procedure setPartIssuedOn(const Value: TDatetime);
    procedure SetLinecost(const Value: Double);
    procedure SetLinecostInc(const Value: Double);
    Procedure AddRelatedParts;
    Procedure updaterelatedPartsQty;
    Procedure updateRelPrQtyCallback(Const Sender: TBusObj; var Abort: Boolean);
    procedure setParentProductID(const Value: Integer);
    procedure setParentLineRef(const Value: String);
    procedure setRelatedProductQty(const Value: Double);
    procedure setinvoiceLineRef(const Value: String);
    procedure setIsRelatedProduct(const Value: Boolean);
    procedure SetSaleLineId(const Value: Integer);
    function getInvoiceToclientID: Integer;
    function GetClientDiscountObj: TClientDiscountObj;
    function GetUOMUnitProductKeyName: string;
    procedure SetUOMUnitProductKeyName(const Value: string);
    (*function GetSaleLineGlobalRef: string;
    procedure SetSaleLineGlobalRef(const Value: string);*)
    function GetParentProductName: string;
    procedure SetParentProductName(const Value: string);
    function GetEquipment: TEquipment;
    procedure CalcQtyFromformula;
    procedure getCalcQtYformulaValue(Sender: TObject; const VarName: string; var Value: extended;var FieldFound: Boolean);
    Procedure ProcessDiscountmarkup(const DiscountMarkuptype: TDiscountMarkuptype);
    Function TotalIncBase :Double;
    Function TotalInc :double;
    procedure setAddingRelatedParts(const Value: Boolean);
    function getRepairTerms: String;
    function getPurchaseLineId: integer;
    procedure SetPurchaselineId(const Value: integer);
    function AutoRoundRelatedQty(const Qty: double): Double;
    Property AddingRelatedParts :Boolean write setAddingRelatedParts;
    Procedure CalcLineTotals;

  Protected
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
    procedure DoFieldOnChange(Sender: TField); Override;
    Procedure InitUOM(const UOMName, UOMNameOldValue:String);override;
    Function GetSQL: STring; Override;
    Function DoAfterPost(Sender: TDatasetBusObj): Boolean; Override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
    Function DoBeforeInsert(Sender: TDatasetBusObj): Boolean; Override;
    Function DoAfterOpen(Sender: TDatasetBusObj): Boolean; Override;
    Function DoAfterDelete(Sender: TDatasetBusObj): Boolean; override;
    Function DoCalcFields(Sender: TDatasetBusObj): Boolean; override;
    Procedure CreateInstance; Override;
    Function GetHeaderID: Integer; Override;
    function GetUnitOfMeasure: String; Override;
    function GetUnitOfMeasureID: Integer; Override;
    function GetUOMMultiplier: Double; Override;
    Function GetClassID: Integer; Override;
    Function GetAllocType: String; override;
    Function GetProductID: Integer; override;
    Function GetProductName: String; Override;
    Function GetActive: Boolean; Override;
    Function GetTransDate: TDatetime; Override;
    Function GetQty: Double; Override;
    Function GetBOQty: Double; Override;
    Function GetBOUOMQty: Double; Override;
    function GetUOMQty: Double; Override;
    function GetSerialnos: String; Override;
    function GetCleanClassID: Integer; Override;
    function GetcleanProductId: Integer; Override;
    function GetOrderQty: Double; Override;
    function GetUOMOrderQty: Double; Override;
    Procedure ClonePropertyObjects; Override;
    Procedure GetBaseLinePrice;
    function GetProductType: string; override;
    procedure SetProductType(const Value: string); override;
    procedure SetMatrixRef(const Value: String); Override;
    function GetMatrixRef: String; Override;
    function GetMatrixDesc: String; Override;
    function GetMatrixPrice: Double; Override;
    procedure SetMatrixDesc(const Value: String); Override;
    procedure SetMatrixPrice(const Value: Double); Override;
  Public
    class Function GetIDField: String; Override;
    class function GetBusObjectTablename: string; Override;
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
    procedure LoadFromXMLNode(Const node: IXMLNode); override;
    procedure SaveToXMLNode(Const node: IXMLNode); override;
    Function ValidateData: Boolean; Override;
    Function Save: Boolean; Override;
    Procedure UpdateTaxId;
    Function ValidateXMLData(Const node: IXMLNode): Boolean; Override;
    Function MaximumDiscountExceeded: Boolean;
    procedure SetUnitOfMeasure(const Value: String); Override;
    procedure SetUnitOfMeasureID(const Value: Integer); Override;
    procedure SetUOMMultiplier(const Value: Double); Override;
    procedure SetSerialNos(const Value: String); Override;
    procedure SetActive(const Value: Boolean); Override;
    procedure SetBOQty(const Value: Double); Override;
    procedure SetBOUOMQty(const Value: Double); Override;
    Procedure SetProductID(Const Value: Integer); Override;
    Procedure SetProductName(Const Value: String); Override;
    Procedure SetQty(Const Value: Double); Override;
    procedure SetTransDate(const Value: TDatetime); Override;
    procedure SetUOMQty(const Value: Double); Override;
    procedure SetOrderQty(const Value: Double); Override;
    procedure SetUOMOrderQty(const Value: Double); Override;
    Property CleanProductName: String read getCleanProductName;
    Property IsConverting: Boolean Read getIsconverting;
    Property InvoiceToclientID: Integer read getInvoiceToclientID;
    property ClientDiscountObj: TClientDiscountObj Read GetClientDiscountObj;
    procedure CallDoFieldOnChange(Sender: TField);
    class function _Schema: string; override;
    property Equipment: TEquipment Read GetEquipment;
    Property RepairTerms :String read getRepairTerms;
  Published
    Property RepairID: Integer Read GetRepairID Write SetRepairID;
    Property Quantity: Double Read GetQuantity Write SetQuantity;
    Property Description: String Read GetDescription Write SetDescription;
    Property PriceEx: Double Read GetPriceex Write SetPriceex;
    Property PriceInc: Double Read GetPriceinc Write SetPriceinc;
    Property TaxCode: String Read GetTaxcode Write SetTaxcode;
    Property PartBarcode: String Read GetPartBarcode Write SetPartBarcode;
    Property TaxRate: Double Read GetTaxrate Write SetTaxrate;
    Property Discount: Double Read GetDiscount Write SetDiscount;
    Property Markup: Double Read GetMarkup Write SetMarkup;
    Property DiscountPercent: Double Read GetDiscountpercent Write SetDiscountpercent;
    Property MarkupPercent: Double Read GetMarkuppercent Write SetMarkuppercent;
    Property LineTotalEx: Double Read GetLinetotalex Write SetLinetotalex;
    Property DeptName: String Read GetClassname Write SetClassname;
    Property RepairPartsClassId: Integer Read GetClassID Write setClassID;
    Property ConvertToInvoice: Boolean Read GetConverttoinvoice Write SetConverttoinvoice;
    Property ETADate: TDatetime Read GetEtadate Write SetEtadate;
    Property MemoLine: String Read GetMemoline Write SetMemoline;
    Property CalcTax: Double Read getcalcTax Write SetcalcTax;
    //Property CalcTotalEx: Double Read getcalcTotalEx Write SetcalcTotalEx;
    Property CalcTotalInc: Double Read getcalcTotalInc Write SetcalcTotalInc;
    Property CalcTotalIncBase: Double Read getcalcTotalIncBase Write SetcalcTotalIncBase;
    Property Product: TProduct Read GetProduct Write SetProduct;
    Property InvoiceLineRef: String REad getinvoiceLineRef Write setinvoiceLineRef;
    Property EquipmentName: String Read getEquipmentname Write SetEquipmentName;
    Property CustomerEquipmentID: Integer Read GetCustomerEquipmentID Write SetCustomerEquipmentID;
    Property UnitOfmeasureID: Integer Read GetUnitOfMeasureID Write SetUnitOfMeasureID;
    property UOMUnitProductKeyName: string read GetUOMUnitProductKeyName
      write SetUOMUnitProductKeyName;
    Property UnitOfMeasure: String Read GetUnitOfMeasure Write SetUnitOfMeasure;
    Property UnitOfMeasureMultiplier: Double Read GetUOMMultiplier Write SetUOMMultiplier;
    Property Deleted: Boolean Read GetDeleted Write SetDeleted;
    Property PartIssuedOn: TDatetime REad getPartIssuedOn Write setPartIssuedOn;
    Property SerialNos: String Read GetSerialnos Write SetSerialNos;
    property LineCost: Double REad getlineCost Write SetLinecost;
    property LinecostInc: Double REad getLinecostInc Write SetLinecostInc;
    Property ParentProductID: Integer Read getParentProductID Write setParentProductID;
    property ParentProductName: string read GetParentProductName write SetParentProductName;
    Property ParentLineRef: String Read getParentLineRef Write setParentLineRef;
    Property RelatedProductQty: Double REad getRelatedProductQty Write setRelatedProductQty;
    Property IsRelatedProduct: Boolean Read getIsRelatedProduct Write setIsRelatedProduct;
    Property SaleLineId: Integer Read getSaleLineId Write SetSaleLineId;
    property PurchaseLineId : integer read getPurchaseLineId write SetPurchaselineId;
    //property SaleLineGlobalRef: string read GetSaleLineGlobalRef write SetSaleLineGlobalRef;
    { the following do not appear to be used }
    // Property PurchaseOrderId        :Integer      Read getPurchaseorderid     Write SetPurchaseorderid ;
    // Property POSLineId              :Integer      Read getPOSLineId           Write SetPOSLineId       ;
  End;

  TRepairTimesheetEntry = class(TTimesheetEntry)
  private
    function GetRepairId: integer;
    procedure SetRepairId(const Value: integer);
    function getRepairArea: String;
  published
  public
    constructor Create(AOwner: TComponent); override;
    class function _Schema: string; override;
    Property RepairArea :String read getRepairArea;
  published
    property RepairId: integer read GetRepairId write SetRepairId;
  end;

  TRepairs = class(TMSBusObj)
  private
    Departments: TStringList;
    fbInvoicing: Boolean;
    fBillCustomer: TCustomer;
    fdPartstotalEx: Double;
    fdLineCosttotal, fdLineCosttotalinc, fdTotalCost, fdTotalCostinc, fdtotalEx, fdtotalinc: Double;
    fdPriceEx, fdPriceInc: Double;
    fProgressDialog: TProgressDialog;
    fbIsConverting: Boolean;
    SmartOrder: TSmartOrder;
    curDeptId: Integer;
    fdtotalServiceCharge: Double;
    lsttotalHours, lstEmployees: TStringList;
    TimesheetNotes:String;
    foDoProductallocation: TDoProductallocation;
    InvoiceLineRef, RepairREf: String;
    invocieParentProductID: Integer;
    fsPOIDs: String;
    RAObj: TReturnAuthority;
    fbUseEquipment: Boolean;
    fsInvalidDocNoReplaced: String;
    initIDTodocNo: Boolean;
    AllLinesSavedOK: boolean;
    fbAddingRelatedParts :boolean;
    fPopupDisplayed :Boolean;
    fdInvoiceTotalInc:Double;
    fdInvoiceTotalEx:Double;
    fsconvertedIds:String;
    fbCopyingtoRepair: Boolean;
    Procedure AddServiceChargeofDept(const SalesLine: TBusObj);
    Function getCreditCheckOn: Boolean;
    function getOtherFollowup: TOtherFollowups;
    Function getRepairParts: TRepairParts;
    Function GetRepairEquipmentFault: TRepairEquipmentFault;
    function getRepairAttachments: TAttachment;
    function geTEquipmentxRef: TEquipmentxRef;
    function getTimesheetentry: TRepairTimesheetEntry;
    function GetCustomer: TCustomer;
    function GetBillCustomer: TCustomer;
    Function GetClientID: Integer;
    Function GetCreationdate: TDatetime;
    Function GetUpdatedate: TDatetime;
    Function GetDone: Boolean;
    Function GetNotes: String;
    Function GetFeedbacknotes: String;
    Function GetEnteredBy: String;
    Function GetClassID: Integer;
    Function GetEmployeeid: Integer;
    Function GetCustomerdetails: String;
    Function GetPhone: String;
    Function GetAltphone: String;
    Function GetFax: String;
    Function GetJobduedate: TDatetime;
    Function GetConverted: Boolean;
    Function GetStatus: String;
    Function GetBilltocustomerdetails: String;
    Function GetBillClientID: Integer;
    Function GetUsebillcust: Boolean;
    Function GetBillphone: String;
    Function GetBillaltphone: String;
    Function GetBillfax: String;
    Function GetSoglobalref: String;
    Function GetQuoteglobalref: String;
    Function GetCustomerponumber: String;
    Function GetCompletiontime: String;
    Function GetShipping: String;
    Function GetAllocatedemployeeid: Integer;
    function getEquipmentList: TEquipment;
    Function getClient: TCustomer;
    Procedure SetBillCustomer(Const Value: TCustomer);
    Procedure SetClientID(Const Value: Integer);
    Procedure SetCreationdate(Const Value: TDatetime);
    Procedure SetUpdatedate(Const Value: TDatetime);
    Procedure SetDone(Const Value: Boolean);
    Procedure SetNotes(Const Value: String);
    Procedure SetFeedbacknotes(Const Value: String);
    Procedure SetEnteredBy(Const Value: String);
    Procedure setClassID(Const Value: Integer);
    Procedure SetEmployeeid(Const Value: Integer);
    Procedure SetCustomerdetails(Const Value: String);
    Procedure SetPhone(Const Value: String);
    Procedure SetAltphone(Const Value: String);
    Procedure SetFax(Const Value: String);
    Procedure SetJobduedate(Const Value: TDatetime);
    Procedure SetConverted(Const Value: Boolean);
    Procedure SetStatus(Const Value: String);
    Procedure SetBilltocustomerdetails(Const Value: String);
    Procedure SetBillClientID(Const Value: Integer);
    Procedure SetUsebillcust(Const Value: Boolean);
    Procedure SetBillphone(Const Value: String);
    Procedure SetBillaltphone(Const Value: String);
    Procedure SetBillfax(Const Value: String);
    Procedure SetSoglobalref(Const Value: String);
    Procedure SetQuoteglobalref(Const Value: String);
    Procedure SetCustomerponumber(Const Value: String);
    Procedure SetCompletiontime(Const Value: String);
    Procedure SetShipping(Const Value: String);
    Procedure SetAllocatedemployeeid(Const Value: Integer);
    function IsCustomerOK(Var Msg: STring): Boolean;
    function getPartstotalEx: Double;
    function getCleanPartstotalEx: Double;
    function getCleanClientID: Integer;
    function GetCleanDone: Boolean;
    Procedure calcPartstotalEx(Const Sender: TBusObj; var Abort: Boolean);
    procedure CalcPartsTotalamountCallback(Const Sender: TBusObj; var Abort: Boolean); overload;
    procedure changetimeSheetJob(Const Sender: TBusObj; var Abort: Boolean);
    procedure changeFollowupclient(Const Sender: TBusObj; var Abort: Boolean);
    procedure GeClientPrice(Const Sender: TBusObj; var Abort: Boolean);
    procedure changeTaxID(Const Sender: TBusObj; var Abort: Boolean);
    procedure CloneLines(const Sender: TBusObj; var Abort: Boolean);
    procedure UpdateRelatedRefs(const Sender: TBusObj; var Abort: Boolean);
    procedure copyLines(const Sender: TBusObj; var Abort: Boolean);
    function getTimesheetEntryCreated: Boolean;
    function getContactID: Integer;
    procedure SetContactId(const Value: Integer);
    function getBillMobile: String;
    function getMobile: String;
    function getTerms: String;
    function getTermsId: Integer;
    procedure SetBillMobile(const Value: String);
    procedure SetMobile(const Value: String);
    procedure SetTerms(const Value: String);
    procedure SetTermsId(const Value: Integer);
    Procedure CalcPartsTotalamount; overload;
    Procedure getDepartments(Const Sender: TBusObj; var Abort: Boolean);
    Procedure CaltotalServiceCharge(Const Sender: TBusObj; var Abort: Boolean);
    Procedure RemoveSaleRef(Const Sender: TBusObj; var Abort: Boolean);
    Procedure RemoveEquipmentlink(Const Sender: TBusObj; var Abort: Boolean);
    Procedure CalcInvoiceTotalCallback(Const Sender: TBusObj; var Abort: Boolean);
    function getQuotedAmount: Double;
    procedure setQuotedAmount(const Value: Double);
    function getQuotedAmountinc: Double;
    procedure setQuotedAmountinc(const Value: Double);
    Procedure DeleteFlaggedLines;
    function getHoldRepair: Boolean;
    function getCancelled: Boolean;
    function getDetailsExported: Boolean;
    procedure setHoldRepair(const Value: Boolean);
    procedure setCancelled(const Value: Boolean);
    procedure setDetailsExported(const Value: Boolean);
    function GetCUSTFLD1: string;
    function GetCUSTFLD10: string;
    function GetCUSTFLD11: string;
    function GetCUSTFLD12: string;
    function GetCUSTFLD13: string;
    function GetCUSTFLD14: string;
    function GetCUSTFLD15: string;
    function GetCUSTFLD2: string;
    function GetCUSTFLD3: string;
    function GetCUSTFLD4: string;
    function GetCUSTFLD5: string;
    function GetCUSTFLD6: string;
    function GetCUSTFLD7: string;
    function GetCUSTFLD8: string;
    function GetCUSTFLD9: string;
    procedure SetCUSTFLD1(const Value: string);
    procedure SetCUSTFLD10(const Value: string);
    procedure SetCUSTFLD11(const Value: string);
    procedure SetCUSTFLD12(const Value: string);
    procedure SetCUSTFLD13(const Value: string);
    procedure SetCUSTFLD14(const Value: string);
    procedure SetCUSTFLD15(const Value: string);
    procedure SetCUSTFLD2(const Value: string);
    procedure SetCUSTFLD3(const Value: string);
    procedure SetCUSTFLD4(const Value: string);
    procedure SetCUSTFLD5(const Value: string);
    procedure SetCUSTFLD6(const Value: string);
    procedure SetCUSTFLD7(const Value: string);
    procedure SetCUSTFLD8(const Value: string);
    procedure SetCUSTFLD9(const Value: string);
    function GetCUSTDATE1: TDatetime;
    function GetCUSTDATE2: TDatetime;
    function GetCUSTDATE3: TDatetime;
    procedure SetCUSTDATE1(const Value: TDatetime);
    procedure SetCUSTDATE2(const Value: TDatetime);
    procedure SetCUSTDATE3(const Value: TDatetime);
    function GetAppointments: TBusObj;
    function getInvoices: TBusObj;
    function getSalesOrders: TBusObj;
    function getRepairDetails: TRepairDetails;
    function getRepairDocno: String;
    procedure setRepairDocno(const Value: String);
    procedure ValidateRepairDocno;
    function getTotalBill: Double;
    function GetBillCustomerName: string;
    function GetArea: string;
    function GetCustomerName: string;
    procedure SetBillCustomerName(const Value: string);
    procedure SetArea(const Value: string);
    procedure SetCustomerName(const Value: string);
    function CreatePO(const fiSupplierId: Integer; Qry: TERPQuery): Integer;
    function OutstandingAppointments: Boolean;
    function getShipToID: Integer;
    procedure setShipToID(const Value: Integer);
    function GetDeptClassName: string;
    procedure SetDeptClassName(const Value: string);
    function GetEmployeeName: string;
    procedure SetEmployeeName(const Value: string);
    function GetAllocatedEmployeeName: string;
    procedure SetAllocatedEmployeeName(const Value: string);
    procedure SaveCancelledled;
    function getBilltotalPrice: Double;
    procedure setBilltotalPrice(const Value: Double);
    function GetRepairAssetXRef: TRepairAssetXRef;
    procedure updatecustomFlds;
    function getCorrespondence: TCorrespondence;
    procedure RepairPartsSaveCallbackProc(Const Sender: TBusObj; var Abort: boolean);
    procedure RepairEquipmentSaveCallbackProc(Const Sender: TBusObj; var Abort: boolean);
    procedure OtherFollowUpSaveCallbackProc(Const Sender: TBusObj; var Abort: boolean);
    function GetShippingAddress: TShippingAddress;
    procedure PopulateCustomerDetails;
    procedure PopulateBillCustomerDetails;
    function GetContactEmail: string;
    function GetContactMobile: string;
    function GetContactName: string;
    function getTotalBillEx: double;
    function getInvoiceTotalInc: Double;
    function getInvoiceTotalEx: Double;
  Protected
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
    procedure DoFieldOnChange(Sender: TField); Override;
    Function GetSQL: STring; Override;
    Function DoAfterPost(Sender: TDatasetBusObj): Boolean; Override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
    Function ExportsubClasses(Const node: IXMLNode): Boolean; Override;
    Function ImportsubClasses(const node: IXMLNode): Boolean; Override;
    Procedure ClonePropertyObjects; Override;
    Procedure CopyPropertyObjects(const Mappedfields: STring); Override;
    Procedure AfterCloneBusObj; Override;
  Public
    procedure BusObjCopy(Const Sender: TBusObj; var Abort: Boolean); override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy; Override;
    procedure LoadFromXMLNode(Const node: IXMLNode); override;
    procedure SaveToXMLNode(Const node: IXMLNode); override;
    Function ValidateData: Boolean; Override;
    Function Save: Boolean; Override;
    Function ValidateXMLData(Const node: IXMLNode): Boolean; Override;
    Procedure CalcPartsTotal; overload;
    function Repeatrepairs(const dates: array of TDatetime): Boolean;
    Function CloneBusObj(const Changefield: String; const ChangeValue: Variant;
      const SaveAfterCopy: Boolean = True; const FilterFields: String = ''): TBusObj; override;
    function CopyRepairtoSales(SalesType: String): String;
    function CopyRepairtoSmartOrder(UseEquipment: Boolean): Integer;
    procedure NewTimeSheetEntry;
    Procedure DeleteAllEquipment;
    Procedure UpdateStatus(fsActionName: String);
    function HasNonInvProducts: Boolean;
    function HasInvProducts: Boolean;
    function CopyRepairsToRA(UseEquipment: Boolean = false): string;
    procedure New; override;
    property EquipmentList: TEquipment Read getEquipmentList;
    Property client: TCustomer Read getClient;
    Property IsConverting: Boolean Read fbIsConverting Write fbIsConverting;
    Property TotalEx: Double read fdtotalEx;
    Property TotalCost: Double read fdTotalCost;
    Property TotalCostinc: Double read fdTotalCostinc;
    Property LineCosttotal : double read fdLineCosttotal;
    Property LineCosttotalinc : double read fdLineCosttotalinc;
    Property TotalInc: Double read fdtotalinc;
    Property TotalPriceEx: Double read fdPriceEx;
    Property TotalPriceInc: Double read fdPriceInc;
    Property TotalBill: Double read getTotalBill;
    property TotalBillEx : double read getTotalBillEx;
    Property InvalidDocNoReplaced: String read fsInvalidDocNoReplaced;
    Property DoProductallocation: TDoProductallocation read foDoProductallocation
      Write foDoProductallocation;
    Property Invoices: TBusObj REad getInvoices;
    Property SalesOrders: TBusObj REad getSalesOrders;
    Property Appointments: TBusObj Read GetAppointments;
    Property POIDs: String Read fsPOIDs Write fsPOIDs;
    Property ProgressDialog: TProgressDialog Read fProgressDialog Write fProgressDialog;
    class function DocNoForID(const aRepairID: Integer; Conn: TCustomMyConnection = nil): string;
    class function IDForDocNo(const aDocNo: string; Conn: TCustomMyConnection = nil): Integer;
    class function _Schema: string; override;
    property RepairAssetXRef: TRepairAssetXRef read GetRepairAssetXRef;
    property Correspondence: TCorrespondence REad getCorrespondence;
    Property AddingRelatedParts :Boolean read fbAddingRelatedParts;

    procedure PopulateMessageSubstituteList(SL: TStringList);
    property ContactEmail: string read GetContactEmail;
    property ContactMobile: string read GetContactMobile;
    property ContactName: string read GetContactName;
    function Lock :Boolean ; Overload; Override;
    Function RepairCustomerEquipmentIDforEquip(const fsEquipmentName:string):Integer;
    Property InvoiceTotalInc :Double read getInvoiceTotalInc;
    Property InvoiceTotalEx :Double read getInvoiceTotalEx;
    Property CopyingtoRepair :Boolean read fbCopyingtoRepair write fbCopyingtoRepair;
  Published
    Property RepairDocNo: String Read getRepairDocno Write setRepairDocno;
    property CustomerName: string read GetCustomerName write SetCustomerName;
    Property ClientID: Integer Read GetClientID Write SetClientID;
    Property CreationDate: TDatetime Read GetCreationdate Write SetCreationdate;
    Property UpdateDate: TDatetime Read GetUpdatedate Write SetUpdatedate;
    Property Done: Boolean Read GetDone Write SetDone;
    Property Notes: String Read GetNotes Write SetNotes;
    Property FeedbackNotes: String Read GetFeedbacknotes Write SetFeedbacknotes;
    Property EnteredBy: String Read GetEnteredBy Write SetEnteredBy;
    Property ClassId: Integer Read GetClassID Write setClassID;
    property DeptClassName: string read GetDeptClassName write SetDeptClassName;
    Property EmployeeId: Integer Read GetEmployeeid Write SetEmployeeid;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    Property CustomerDetails: String Read GetCustomerdetails Write SetCustomerdetails;
    Property Phone: String Read GetPhone Write SetPhone;
    Property AltPhone: String Read GetAltphone Write SetAltphone;
    Property Fax: String Read GetFax Write SetFax;
    Property JobDueDate: TDatetime Read GetJobduedate Write SetJobduedate;
    Property Converted: Boolean Read GetConverted Write SetConverted;
    Property Status: String Read GetStatus Write SetStatus;
    Property BillToCustomerDetails: String Read GetBilltocustomerdetails
      Write SetBilltocustomerdetails;
    property BillCustomerName: string read GetBillCustomerName write SetBillCustomerName;
    property Area: string read GetArea write SetArea;
    Property BilltotalPrice: Double read getBilltotalPrice write setBilltotalPrice;
    Property BillClientID: Integer Read GetBillClientID Write SetBillClientID;
    Property UseBillCust: Boolean Read GetUsebillcust Write SetUsebillcust;
    Property BillPhone: String Read GetBillphone Write SetBillphone;
    Property BillAltPhone: String Read GetBillaltphone Write SetBillaltphone;
    Property BillFax: String Read GetBillfax Write SetBillfax;
    Property SOGlobalRef: String Read GetSoglobalref Write SetSoglobalref;
    Property QuoteGlobalRef: String Read GetQuoteglobalref Write SetQuoteglobalref;
    Property CustomerPONumber: String Read GetCustomerponumber Write SetCustomerponumber;
    Property CompletionTime: String Read GetCompletiontime Write SetCompletiontime;
    Property Shipping: String Read GetShipping Write SetShipping;
    Property AllocatedEmployeeId: Integer Read GetAllocatedemployeeid Write SetAllocatedemployeeid;
    property AllocatedEmployeeName: string read GetAllocatedEmployeeName
      write SetAllocatedEmployeeName;
    Property Invoicing: Boolean Read fbInvoicing Write fbInvoicing;
    Property TimesheetEntryCreated: Boolean Read getTimesheetEntryCreated;
    Property PartsTotalEx: Double Read getPartstotalEx;
    Property cleanPartstotalEx: Double Read getCleanPartstotalEx;
    Property CleanClientID: Integer Read getCleanClientID;
    Property CleanDone: Boolean Read GetCleanDone;
    Property CreditCheckOn: Boolean Read getCreditCheckOn;
    Property OtherFollowup: TOtherFollowups Read getOtherFollowup;
    Property RepairParts: TRepairParts Read getRepairParts;
    Property RepairEquipmentFault: TRepairEquipmentFault read GetRepairEquipmentFault;
    Property RepairAttachments: TAttachment read getRepairAttachments;
    Property RepairEquipment: TEquipmentxRef Read geTEquipmentxRef;
    Property TimesheetEntry: TRepairTimesheetEntry Read getTimesheetentry;
    Property Customer: TCustomer Read GetCustomer;
    Property BillCustomer: TCustomer Read GetBillCustomer Write SetBillCustomer;
    Property ContactID: Integer Read getContactID Write SetContactId;
    Property TermsId: Integer Read getTermsId Write SetTermsId;
    Property Terms: String Read getTerms Write SetTerms;
    Property Mobile: String Read getMobile Write SetMobile;
    Property BillMobile: String Read getBillMobile Write SetBillMobile;
    Property QuotedAmount: Double REad getQuotedAmount Write setQuotedAmount;
    Property QuotedAmountInc: Double REad getQuotedAmountinc Write setQuotedAmountinc;
    Property HoldRepair: Boolean Read getHoldRepair write setHoldRepair;
    Property Cancelled: Boolean Read getCancelled write setCancelled;
    Property DetailsExported: Boolean Read getDetailsExported write setDetailsExported;
    property CUSTFLD1: string read GetCUSTFLD1 write SetCUSTFLD1;
    property CUSTFLD2: string read GetCUSTFLD2 write SetCUSTFLD2;
    property CUSTFLD3: string read GetCUSTFLD3 write SetCUSTFLD3;
    property CUSTFLD4: string read GetCUSTFLD4 write SetCUSTFLD4;
    property CUSTFLD5: string read GetCUSTFLD5 write SetCUSTFLD5;
    property CUSTFLD6: string read GetCUSTFLD6 write SetCUSTFLD6;
    property CUSTFLD7: string read GetCUSTFLD7 write SetCUSTFLD7;
    property CUSTFLD8: string read GetCUSTFLD8 write SetCUSTFLD8;
    property CUSTFLD9: string read GetCUSTFLD9 write SetCUSTFLD9;
    property CUSTFLD10: string read GetCUSTFLD10 write SetCUSTFLD10;
    property CUSTFLD11: string read GetCUSTFLD11 write SetCUSTFLD11;
    property CUSTFLD12: string read GetCUSTFLD12 write SetCUSTFLD12;
    property CUSTFLD13: string read GetCUSTFLD13 write SetCUSTFLD13;
    property CUSTFLD14: string read GetCUSTFLD14 write SetCUSTFLD14;
    property CUSTFLD15: string read GetCUSTFLD15 write SetCUSTFLD15;
    property CUSTDATE1: TDatetime read GetCUSTDATE1 write SetCUSTDATE1;
    property CUSTDATE2: TDatetime read GetCUSTDATE2 write SetCUSTDATE2;
    property CUSTDATE3: TDatetime read GetCUSTDATE3 write SetCUSTDATE3;
    Property ShipToId: Integer read getShipToID write setShipToID;
    property ShippingAddress: TShippingAddress read GetShippingAddress;
    Property RepairDetails: TRepairDetails Read getRepairDetails;
  End;

implementation

uses tcDataUtils, sysutils, Math, DNMLib, Dialogs, controls, DateUtils,
  AppContextObj, BusObjConst, AppEnvironment,
  BusObjSales, CommonLib, BusObjTaxCodes,
  BusobjSaleBase, BusobjProductProperties, Variants, CompanyPrefObj, TypInfo,
  BusObjAppointments, busobjSimpletypeActions, PartsPriceMatrixLib,
  BusobjUOM, tcconst,BusObjSimpleTypes, CommonDbLib, IntegerListObj, BusObjClass,
  BusObjSchemaLib, BusObjEmployee,  ParserLib, BusObjContact,
  SalesDiscountValidationObj, BusObjApprovals, LogLib, BusObjUtils;

{ ========================================================
  TRepairs
  ======================================================== }
constructor TRepairs.Create(AOwner: TComponent);
begin
  fsInvalidDocNoReplaced := '';
  initIDTodocNo := false;
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblrepairs';
  fbUseEquipment := false;
  // UseBillCust := False;
  fbIsConverting := false;
  fsPOIDs := '';
  fBusObjectTypeDescription := 'Repair Object';
  ExportExcludeList.Add('clientid');
  ExportExcludeList.Add('classid');
  ExportExcludeList.Add('employeeid');
  ExportExcludeList.Add('billclientid');
  ExportExcludeList.Add('allocatedemployeeid');
  ExportExcludeList.Add('invoicing');
  ExportExcludeList.Add('timesheetentrycreated');
  ExportExcludeList.Add('partstotalex');
  ExportExcludeList.Add('cleanpartstotalex');
  ExportExcludeList.Add('cleanclientid');
  ExportExcludeList.Add('cleandone');
  ExportExcludeList.Add('creditcheckon');
  ExportExcludeList.Add('customer');
  ExportExcludeList.Add('billcustomer');
  ExportExcludeList.Add('shiptoid');
  fPopupDisplayed := False;
  CopyingtoRepair := False;
end;

destructor TRepairs.Destroy;
begin
  inherited;
end;

Function TRepairs.ValidateXMLData(Const node: IXMLNode): Boolean;
var
  fiClientID: Integer;
  fiClassid: Integer;
  fiEmployeeid: Integer;
  fiBillClientID: Integer;
  fiAssetproductid: Integer;
  fiAllocatedemployeeid: Integer;
begin
  Result := inherited ValidateXMLData(node);
  if not Result then
    Exit;
  if not ImportingFromXMLFile then
    Exit;

  if GetXMLNodeIntegerValue(node, 'ImportingID') <> 0 then
    XMLSearchRecorddesc := IDFieldName + ' =' +
      IntToStr(GetXMLNodeIntegerValue(node, 'ImportingID'))
  else
    XMLSearchRecorddesc := IDFieldName + ' =' + IntToStr(GetXMLNodeIntegerValue(node, IDFieldName));

  Result := false;

  if GetXMLNodeStringValue(node, 'CustomerName') <> '' then begin
    fiClientID := TClient.IDToggle(GetXMLNodeStringValue(node, 'CustomerName'),
      Connection.Connection);
    if fiClientID = 0 then begin
      ErrRecordNotfound('CustomerName', GetXMLNodeStringValue(node, 'CustomerName'));
      Exit;
    end;
  End;
  if GetXMLNodeStringValue(node, 'BillCustomerName') <> '' then begin
    fiBillClientID := TClient.IDToggle(GetXMLNodeStringValue(node, 'BillCustomerName'),
      Connection.Connection);
    if fiBillClientID = 0 then begin
      ErrRecordNotfound('BillCustomerName', GetXMLNodeStringValue(node, 'BillCustomerName'));
      Exit;
    end;
  End;
  if GetXMLNodeStringValue(node, 'EmployeeName') <> '' then begin
    fiEmployeeid := tcDataUtils.GetEmployeeid(GetXMLNodeStringValue(node, 'EmployeeName'));
    if fiEmployeeid = 0 then begin
      ErrRecordNotfound('EmployeeName', GetXMLNodeStringValue(node, 'EmployeeName'));
      Exit;
    end;
  End;
  if GetXMLNodeStringValue(node, 'AllocatedEmployeeName') <> '' then begin
    fiAllocatedemployeeid := tcDataUtils.GetEmployeeid(GetXMLNodeStringValue(node,
      'AllocatedEmployeeName'));
    if fiAllocatedemployeeid = 0 then begin
      ErrRecordNotfound('AllocatedEmployeeName', GetXMLNodeStringValue(node,
        'AllocatedEmployeeName'));
      Exit;
    end;
  End;
  if GetXMLNodeStringValue(node, 'RepairClass') <> '' then begin
    fiClassid := tcDataUtils.GetDeptID(GetXMLNodeStringValue(node, 'RepairClass'));
    if fiClassid = 0 then begin
      ErrRecordNotfound('RepairClass', GetXMLNodeStringValue(node, 'RepairClass'));
      Exit;
    end;
  End;

  if GetXMLNodeStringValue(node, 'Assetproduct') <> '' then begin
    fiAssetproductid := tcDataUtils.GetProduct(GetXMLNodeStringValue(node, 'Assetproduct'));
    if fiAssetproductid = 0 then begin
      ErrRecordNotfound('Assetproduct', GetXMLNodeStringValue(node, 'Assetproduct'));
      Exit;
    end;
  End;
  Result := True;
  LocateXMLRecord;
end;

class function TRepairs._Schema: string;
begin
  Result := inherited;
  TBOSchema.AddRefType(Result, 'TCustomer', 'CustomerObj', 'ClientID', 'ID');
  TBOSchema.AddRefType(Result, 'TCustomer', 'BillCustomerObj', 'BillCustomerName', 'ClientName');
  TBOSchema.AddRefType(Result, 'TCustomer', 'BillCustomerObj', 'BillClientID', 'ID');
  TBOSchema.AddRefType(Result, 'TCustomer', 'CustomerObj', 'CustomerName', 'ClientName');
  TBOSchema.AddRefType(Result, 'TDeptClass', 'DeptClassObj', 'ClassID', 'ID');
  TBOSchema.AddRefType(Result, 'TDeptClass', 'DeptClassObj', 'DeptClassName', 'DeptClassName');
  TBOSchema.AddRefType(Result, 'TEmployee', 'EmployeeObj', 'EmployeeID', 'ID');
  TBOSchema.AddRefType(Result, 'TEmployee', 'EmployeeObj', 'EmployeeName', 'EmployeeName');
  TBOSchema.AddRefType(Result, 'TEmployee', 'AllocEmployeeObj', 'AllocatedEmployeeID', 'ID');
  TBOSchema.AddRefType(Result, 'TEmployee', 'AllocEmployeeObj', 'AllocatedEmployeeName',
    'EmployeeName');
  TBOSchema.AddRefType(Result, 'TContact', 'ContactObj', 'ContactID', 'ID');
  TBOSchema.AddRefType(Result, 'TShippingAddress', 'ShippingAddress', 'ShipToID', 'ID');

end;

procedure TRepairs.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  if not ImportingFromXMLFile then begin
    SetPropertyFromNode(node, 'ClientID');
    SetPropertyFromNode(node, 'Classid');
    SetPropertyFromNode(node, 'Employeeid');
    SetPropertyFromNode(node, 'BillClientID');
    SetPropertyFromNode(node, 'Allocatedemployeeid');
  end
  else begin
    if GetXMLNodeStringValue(node, 'CustomerName') <> '' then
      ClientID := TClient.IDToggle(GetXMLNodeStringValue(node, 'CustomerName'),
        Connection.Connection);
    if GetXMLNodeStringValue(node, 'BillCustomerName') <> '' then
      BillClientID := TClient.IDToggle(GetXMLNodeStringValue(node, 'BillCustomerName'),
        Connection.Connection);
    if GetXMLNodeStringValue(node, 'EmployeeName') <> '' then
      EmployeeId := tcDataUtils.GetEmployeeid(GetXMLNodeStringValue(node, 'EmployeeName'));
    if GetXMLNodeStringValue(node, 'AllocatedEmployeeName') <> '' then
      AllocatedEmployeeId := tcDataUtils.GetEmployeeid(GetXMLNodeStringValue(node,
        'AllocatedEmployeeName'));
    if GetXMLNodeStringValue(node, 'RepairClass') <> '' then
      ClassId := tcDataUtils.GetDeptID(GetXMLNodeStringValue(node, 'RepairClass'));
  end;
  SetPropertyFromNode(node, 'ShipToID');
  SetDateTimePropertyFromNode(node, 'Creationdate');
  SetDateTimePropertyFromNode(node, 'Updatedate');
  SetBooleanPropertyFromNode(node, 'Done');
  SetPropertyFromNode(node, 'Notes');
  SetPropertyFromNode(node, 'Feedbacknotes');
  SetPropertyFromNode(node, 'EnteredBy');
  SetPropertyFromNode(node, 'Customerdetails');
  SetPropertyFromNode(node, 'Phone');
  SetPropertyFromNode(node, 'Altphone');
  SetPropertyFromNode(node, 'Fax');
  SetDateTimePropertyFromNode(node, 'Jobduedate');
  SetBooleanPropertyFromNode(node, 'Converted');
  SetPropertyFromNode(node, 'Status');
  SetPropertyFromNode(node, 'Billtocustomerdetails');
  SetBooleanPropertyFromNode(node, 'Usebillcust');
  SetBooleanPropertyFromNode(node, 'HoldRepair');
  SetBooleanPropertyFromNode(node, 'Cancelled');
  SetBooleanPropertyFromNode(node, 'DetailsExported');
  SetPropertyFromNode(node, 'Billphone');
  SetPropertyFromNode(node, 'Billaltphone');
  SetPropertyFromNode(node, 'Billfax');
  SetPropertyFromNode(node, 'Soglobalref');
  SetPropertyFromNode(node, 'Quoteglobalref');
  SetPropertyFromNode(node, 'Customerponumber');
  SetPropertyFromNode(node, 'Completiontime');
  SetPropertyFromNode(node, 'Shipping');
  SetPropertyFromNode(node, 'BilltotalPrice');

end;

function TRepairs.Lock: Boolean;
begin
  result := inherited Lock;
  if not result then exit;

  if done then
    if AppEnv.CompanyPrefs.LockRepairwhenDone then begin
      ResultStatus.AddItem(False, rssWarning, 0 , 'This is a ''Done'' repair and as per the preference the repairs record is locked when Done.');
      Result:= False;
    end;
end;

procedure TRepairs.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  if not SavingXMLTofile then begin
    AddXMLNode(node, 'ClientID', ClientID);
    AddXMLNode(node, 'Classid', ClassId);
    AddXMLNode(node, 'Employeeid', EmployeeId);
    AddXMLNode(node, 'BillClientID', BillClientID);
    AddXMLNode(node, 'Allocatedemployeeid', AllocatedEmployeeId);
  end
  else begin
    AddXMLNode(node, 'CustomerName', tcDataUtils.getclientname(ClientID));
    AddXMLNode(node, 'BillCustomerName', tcDataUtils.getclientname(BillClientID));
    AddXMLNode(node, 'EmployeeName', tcDataUtils.GetEmployeeName(EmployeeId));
    AddXMLNode(node, 'AllocatedEmployeeName', tcDataUtils.GetEmployeeName(AllocatedEmployeeId));
    AddXMLNode(node, 'RepairClass', tcDataUtils.GetClassname(ClassId));
  end;

  AddXMLNode(node, 'ShipToID', ShipToId);
  AddXMLNode(node, 'Creationdate', CreationDate);
  AddXMLNode(node, 'Updatedate', UpdateDate);
  AddXMLNode(node, 'Done', Done);
  AddXMLNode(node, 'Notes', Notes);
  AddXMLNode(node, 'Feedbacknotes', FeedbackNotes);
  AddXMLNode(node, 'EnteredBy', EnteredBy);
  AddXMLNode(node, 'Customerdetails', CustomerDetails);
  AddXMLNode(node, 'Phone', Phone);
  AddXMLNode(node, 'Altphone', AltPhone);
  AddXMLNode(node, 'Fax', Fax);
  AddXMLNode(node, 'Jobduedate', JobDueDate);
  AddXMLNode(node, 'Converted', Converted);
  AddXMLNode(node, 'Status', Status);
  AddXMLNode(node, 'Billtocustomerdetails', BillToCustomerDetails);
  AddXMLNode(node, 'Usebillcust', UseBillCust);
  AddXMLNode(node, 'Billphone', BillPhone);
  AddXMLNode(node, 'Billaltphone', BillAltPhone);
  AddXMLNode(node, 'Billfax', BillFax);
  AddXMLNode(node, 'HoldRepair', HoldRepair);
  AddXMLNode(node, 'Cancelled', Cancelled);
  AddXMLNode(node, 'DetailsExported', DetailsExported);
  AddXMLNode(node, 'Soglobalref', SOGlobalRef);
  AddXMLNode(node, 'Quoteglobalref', QuoteGlobalRef);
  AddXMLNode(node, 'Customerponumber', CustomerPONumber);
  AddXMLNode(node, 'Completiontime', CompletionTime);
  AddXMLNode(node, 'Shipping', Shipping);
  AddXMLNode(node, 'PartsTotalEx', PartsTotalEx);

  AddXMLNode(node, 'Customfield1', CUSTFLD1);
  AddXMLNode(node, 'Customfield2', CUSTFLD2);
  AddXMLNode(node, 'Customfield3', CUSTFLD3);
  AddXMLNode(node, 'Customfield4', CUSTFLD4);
  AddXMLNode(node, 'Customfield5', CUSTFLD5);
  AddXMLNode(node, 'Customfield6', CUSTFLD6);
  AddXMLNode(node, 'Customfield7', CUSTFLD7);
  AddXMLNode(node, 'Customfield8', CUSTFLD8);
  AddXMLNode(node, 'Customfield9', CUSTFLD9);
  AddXMLNode(node, 'Customfield10', CUSTFLD10);
  AddXMLNode(node, 'Customfield11', CUSTFLD11);
  AddXMLNode(node, 'Customfield12', CUSTFLD12);
  AddXMLNode(node, 'Customfield13', CUSTFLD13);
  AddXMLNode(node, 'Customfield14', CUSTFLD14);
  AddXMLNode(node, 'Customfield15', CUSTFLD15);
  AddXMLNode(node, 'CUSTDATE1', CUSTDATE1);
  AddXMLNode(node, 'CUSTDATE2', CUSTDATE2);
  AddXMLNode(node, 'CUSTDATE3', CUSTDATE3);
  AddXMLNode(node, 'BilltotalPrice', BilltotalPrice);

  ExportsubClasses(node);
end;

function TRepairs.ValidateData: Boolean;
var
  Msg: String;
  dtCompletionDate: TDatetime;
  dtCompletionTime: TDate;
  wYear, wMonth, wDay, wHour, wMin, wSec, wMilliSec: word;
begin
  Result := false;
  Resultstatus.Clear;
  if CopyingtoRepair then begin
    result := True;
    if client.ForcePOOnRepair and (CustomerPONumber = '') then begin
      CustomerPONumber := 'AUTO-Generated' ;
      AddResult(true, rssWarning, 0, 'You Must Supply a Customer PO Number.'+ NL+
                                     quotedstr(CustomerPONumber) +' is a Temporary Number Assigned for Repairs Created Internally.'+NL+NL+
                                     'Please Change It.');
    end;
    if TermsId < 0 then begin
       AddResult(false, rssError, 0, 'You Must supply the Terms');
    end;
    Exit;
  end;

  if ClientID = 0 then begin
    AddResult(false, rssError, 0, 'Invoicing Customer should not be blank');
    Exit;
  end;
  if ClassId = 0 then begin
    AddResult(false, rssError, 0, 'Department/Class is balank');
    Exit;
  end;
  if ClassId < 0 then begin
    AddResult(false, rssError, 0, 'Department/Class not found');
    Exit;
  end;
  if EmployeeId = 0 then begin
    AddResult(false, rssError, 0, 'Employee (Representative) is blank');
    Exit;
  end;
  if EmployeeId < 0 then begin
    AddResult(false, rssError, 0, 'Employee not found');
    Exit;
  end;
  if AllocatedEmployeeId < 0 then begin
    AddResult(false, rssError, 0, 'Allocated Employee not found');
    Exit;
  end;
  if (BillClientID = 0) and (not RawMode) then begin
    if not UseBillCust then begin
      BillClientID := ClientID;
      BillToCustomerDetails := CustomerDetails;
      BillPhone := Phone;
      BillAltPhone := AltPhone;
      BillMobile := Mobile;
      BillFax := Fax;
    end;
  end;
  if TermsId < 0 then begin
    AddResult(false, rssError, 0, 'Terms not found');
    Exit;
  end;
  if client.ForcePOOnRepair then
    if CustomerPONumber = '' then begin
      Result := false;
      AddResult(false, rssWarning, 0, 'You must supply a customer PO number');
      Exit;
    end;
  if not RawMode then begin
    PostDB;
    wYear := 0;
    wMonth := 0;
    wDay := 0;
    wHour := 0;
    wMin := 0;
    wSec := 0;
    wMilliSec := 0;

    if (JobDueDate > 1) or ((CompletionTime <> '') and (CompletionTime <> '0:00')) then begin
      dtCompletionTime := StrToTime(CompletionTime);
      DecodeTime(dtCompletionTime, wHour, wMin, wSec, wMilliSec);

      DecodeDate(JobDueDate, wYear, wMonth, wDay);
      wSec := 0;
      wMilliSec := 0;
      if (wHour = 0) and (wMin = 0) then
        Inc(wSec);

      if not TryEncodeDateTime(wYear, wMonth, wDay, wHour, wMin, wSec, wMilliSec, dtCompletionDate)
      then begin
        AddResult(false, rssWarning, 0, 'Invaild Completion Date Or Time !' + #13 + #10 +
          '' + #13 + #10 + 'Please Re-enter And Try Again');
        Result := false;
        Exit;
      end;
      JobDueDate := dtCompletionDate;
      PostDB;
    end;
  end;
  if (dtCompletionDate > 1) and (CreationDate > 1) and (dtCompletionDate < CreationDate) then
  begin
    AddResult(false, rssWarning, 0, 'Job Completion Date Is Less Than The Job Creation Date ');
    Result := false;
    Exit;
  end;

  if not RawMode then begin
    if (not Invoicing) and (CleanClientID <> ClientID) then
      if not IsCustomerOK(Msg) then begin
        if not Assigned(ConfirmFromGUI) then
          AddResult(True, rssWarning, 0, Msg)
        else if fConfirmFromGUI(Msg + chr(13) +
          'Do you wish to proceed with Repair for this Customer', [mbYes, MbNO]) = mrno then begin
          Exit;
        end;
        HoldRepair := True;
      end
      else
        HoldRepair := false;
    PostDB;
  end;
  if TimesheetEntry.ValidateData = false then begin
    Result := false;
    Exit;
  end;
  if not RepairEquipmentFault.ValidateDataList then begin
    Result := false;
    Exit;
  end;
  if not OtherFollowup.ValidateDataList then begin
    Result := false;
    Exit;
  end;
  Result := True;
end;

procedure TRepairs.CalcPartsTotalamountCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
  fdtotalEx := fdtotalEx + TRepairParts(Sender).LineTotalEx;
  fdtotalinc := fdtotalinc + TRepairParts(Sender).TotalInc;// CalcTotalInc;
  fdPriceEx := fdPriceEx + TRepairParts(Sender).PriceEx;
  fdPriceInc := fdPriceInc + TRepairParts(Sender).PriceInc;
  fdTotalCost    := fdTotalCost    + TRepairParts(Sender).LineCost    * TRepairParts(Sender).Quantity;
  fdTotalCostinc := fdTotalCostinc + TRepairParts(Sender).LinecostInc * TRepairParts(Sender).Quantity;
  fdLineCosttotal := fdLineCosttotal+TRepairParts(Sender).LineCost ;
  fdLineCosttotalinc := fdLineCosttotal+TRepairParts(Sender).LineCostinc ;
end;

procedure TRepairs.CalcPartsTotalamount;
begin
  CalcPartsTotal;
  sendEvent(BusObjEvent_Change, BusObjEventVal_Total);
end;

function TRepairs.Save: Boolean;
begin
  PostDB;
  RepairParts.PostDB;
  RepairEquipment.PostDB;
  TimesheetEntry.PostDB;
  TimesheetEntry.Timesheet.PostDB;
  OtherFollowup.PostDB;
  RepairDetails.PostDB;
  Customer.PostDB;

  Resultstatus.Clear;

  AllLinesSavedOK := true;
  RepairParts.IterateRecords(RepairPartsSaveCallbackProc, True);
  Result:= AllLinesSavedOK;
  if not result then exit;

  RepairEquipment.IterateRecords(RepairEquipmentSaveCallbackProc, True);
  Result:= AllLinesSavedOK;
  if not result then exit;

  Result:= TimesheetEntry.Save;
//  TimesheetEntry.Timesheet.Save;
  if not result then exit;

  OtherFollowup.IterateRecords(OtherFollowupSaveCallbackProc, True);
  Result:= AllLinesSavedOK;
  if not result then exit;

  result := RepairDetails.Save;
  if not result then exit;

//  Resultstatus.Clear;
  try
    RepairAssetXRef.PostDB;
  except
  end;
  REsult:= ValidateData;
  if not Result then Exit;

  Result := self.RepairAssetXRef.Save;
  if not Result then
    Exit;

  if dirty then
    Result := Inherited Save;
  if Result then
    DeleteFlaggedLines;
  if Result then
    if Done and not(CleanDone) then
      sendEvent(BusObjEvent_Change, BusobjEvent_RepairDone, self);

end;

procedure TRepairs.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  fPopupDisplayed := False;
  fbIsConverting := false;
  fsPOIDs := '';
  if Assigned(fBillCustomer) then
    if (not fBillCustomer.ExternalDatasetAssigned) then
      FreeAndNil(fBillCustomer)
    else
      fBillCustomer.Dataset.Close;

end;

procedure TRepairs.OtherFollowUpSaveCallbackProc(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not TOtherFollowups(Sender).Save then begin
    AllLinesSavedOK:= false;
    Abort:= true;
  end;
end;

function TRepairs.OutstandingAppointments: Boolean;
var
  Qry: TERPQuery;
begin
  Qry := TERPQuery.Create(nil);
  try
    Qry.Connection := Connection.Connection;
    Qry.SQL.Add('select AppointID from tblAppointments');
    Qry.SQL.Add('where RepairID = ' + IntToStr(ID));
    Qry.SQL.Add('and Active = "T"');
    Qry.SQL.Add('and Status <> "Cancelled"');
    Qry.SQL.Add('and Cancellation <> "T"');
    Qry.SQL.Add('and "' + FormatDateTime('yyyy-mm-dd hh:nn:ss', now) + '" > Actual_EndTime');
    Qry.Open;
    Result := not Qry.IsEmpty;
  finally
    Qry.Free;
  end;
end;

procedure TRepairs.PopulateBillCustomerDetails;
var
  s: string;
begin
  BillToCustomerDetails := BillCustomer.clientName;
  if BillCustomer.BillStreet <> '' then
    BillToCustomerDetails := BillToCustomerDetails + #13#10 + BillCustomer.BillStreet;
  if BillCustomer.BillStreet2 <> '' then
    BillToCustomerDetails := BillToCustomerDetails + #13#10 + BillCustomer.BillStreet2;
  if BillCustomer.BillStreet3 <> '' then
    BillToCustomerDetails := BillToCustomerDetails + #13#10 + BillCustomer.BillStreet3;
  if BillCustomer.BillSuburb <> '' then
    BillToCustomerDetails := BillToCustomerDetails + #13#10 + BillCustomer.BillSuburb;
  s := BillCustomer.BillState;
  if (s <> '') then begin
    if BillCustomer.BillPostcode <> '' then
      s := s + ' ' + BillCustomer.BillPostcode;
  end
  else begin
    if BillCustomer.BillPostcode <> '' then
      s := s + BillCustomer.BillPostcode;
  end;
  if s <> '' then
    BillToCustomerDetails := BillToCustomerDetails + #13#10 + s;

  BillPhone := BillCustomer.Phone;
  BillAltPhone := BillCustomer.AltPhone;
  BillFax := BillCustomer.FaxNumber;
  BillMobile := BillCustomer.mobile;
end;

procedure TRepairs.PopulateCustomerDetails;
begin
  if contactId =0 then contactId := client.MainContactIDforRepair;
  if contactId =0 then contactId := client.PrimarycontactID;
  CustomerDetails := ConcatStrings([Customer.clientName ,contactName , Customer.Street  , Customer.Street2,Customer.Street3 , ConcatStrings([Customer.Suburb ,Customer.State , Customer.Postcode ] , ' ')], #13#10);
  Phone := Customer.Phone;
  AltPhone := Customer.AltPhone;
  Fax := Customer.FaxNumber;
  Mobile := Customer.mobile;

  Terms    := Customer.TermsName;
  TermsId  := Customer.termsid;
  if BillClientID =0 then begin
    BillClientID := ClientID;
    DoFieldOnChange(dataset.findfield('Billcusid'));
  end;

end;

procedure TRepairs.PopulateMessageSubstituteList(SL: TStringList);
var
  s: string;
  qry : TERPQuery;
begin
  inherited;
  s:=
    'Select R.RepairId, ' +
    'C.FirstName, ' +
    'R.CustomerDetails as Address, ' +
    'Concat(RP.PartName ,"     : " ,  RP.UOMQty , "  of  " ,   concat(RP.UnitofMeasure , " (" , RP.UnitofMeasureMultiplier , ")" )) Details ' +
    'from tblrepairs R ' +
    'left join tblrepairparts RP on R.RepairID = RP.RepairID ' +
    'inner join tblclients c on R.CusID  = C.clientId ' +
//    'where ifnull(RP.UOMQty,0)<> 0 ' +
	  'where  R.RepairId = ' + IntToStr(ID);
  qry := TERPQuery(GetNewDataSet(s));
  try
    SL.Values['#RepairID#'] := IntToStr(ID);
    SL.Values['#Address#'] := qry.Fieldbyname('Address').asString;
    SL.Values['#ShippingAddress#'] := qry.Fieldbyname('Address').asString;  // was mistake in template
    SL.Values['#Products#'] := qry.Groupconcat('Details' , '' , False, #13#10 );
    if SL.Values['#Products#'] = '' then
      SL.Values['#Products#'] := 'No Products Defined';

    SL.Values['#FirstName#'] := qry.Fieldbyname('FirstName').asString;
  finally
    qry.Free;
  end;
  (*
  with TERPQuery(GetNewDataset(s)) do try
    SL.Values['#RepairID#'] := IntToStr(ID);
    SL.Values['#Address#'] := Fieldbyname('Address').asString;
    SL.Values['#Products#'] := Groupconcat('Details' , '' , False, #13#10 );
    SL.Values['#FirstName#'] := Fieldbyname('FirstName').asString;
  finally
    Free;
  end;
  *)
end;

procedure TRepairs.changetimeSheetJob(Const Sender: TBusObj; var Abort: Boolean);
var
  fbReadonly: Boolean;
begin
  fbReadonly := TTimesheet(Sender).Dataset.fieldbyname('JobID').REadonly;
  try
    TTimesheet(Sender).Dataset.fieldbyname('JobID').REadonly := false;
    TTimesheet(Sender).JobID := ClientID;
    TTimesheet(Sender).PostDB;
  Finally
    TTimesheet(Sender).Dataset.fieldbyname('JobID').REadonly := fbReadonly;
  end;
end;

procedure TRepairs.changeFollowupclient(Const Sender: TBusObj; var Abort: Boolean);
begin
  TOtherFollowups(Sender).ClientID := ClientID;
  TOtherFollowups(Sender).PostDB;
end;

procedure TRepairs.changeTaxID(Const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TRepairParts) then
    Exit;
  TRepairParts(Sender).UpdateTaxId;
end;

procedure TRepairs.New;
begin
  inherited;
  SaveCancelledled;
end;

procedure TRepairs.SaveCancelledled;
begin
  if Connection.InTransaction then begin
    try
      Cancelled := True;
      PostDB;
      Connection.CommitTransaction;
    finally
      Connection.BeginTransaction;
      Cancelled := false;
    end;
  end;
end;

procedure TRepairs.NewTimeSheetEntry;
begin
  TimesheetEntry.PostDB;
  if TimesheetEntry.count > 0 then
    Exit;
  if accessmanager.accesslevel>2 then exit;
  TimesheetEntry.New;
  TimesheetEntry.TypeName := 'Repair';
  TimesheetEntry.EntryDate := now;
  TimesheetEntry.Whoentered := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
  TimesheetEntry.TypeId := self.ID;
  TimesheetEntry.PostDB;
end;

Procedure TRepairs.ValidateRepairDocno;
var
  Flag: Boolean;

begin
  Flag := false;
  fsInvalidDocNoReplaced := RepairDocNo;
  While not IsUnique(ID, 'RepairDocno = ' + Quotedstr(RepairDocNo), self.Connection.Connection) do
  begin
    if ISInteger(RepairDocNo) then
      RepairDocNo := IntToStr(strToInt(RepairDocNo) + 1)
    else
      RepairDocNo := IntToStr(ID);
    Flag := True;
  end;
  if Flag then
    (* SendEvent(BusobjEvent_Event , BusobjEvent_DocNumGenerated ,self); *)
    if not initIDTodocNo then
      AddResult(True, rssinfo, 0, 'Repair No ' + fsInvalidDocNoReplaced +
        ' is Already Used for another Repair.' + chr(13) +
        'Repair No is Changed to the Next Available Number - ' + RepairDocNo + '.', True);
end;

procedure TRepairs.updatecustomFlds;
begin
  if ClientID = 0 then
    Exit;
  With GetNewDataset('Select CFRepairs1, CFRepairs2,  CFRepairs3,  CFRepairs4,  CFRepairs5,  ' +
    ' CFRepairs6,  CFRepairs7,  CFRepairs8,  CFRepairs9,  CFRepairs10,  CFRepairs11,   ' +
    ' CFRepairs12,  CFRepairs13,  CFRepairs14,  CFRepairs15,  CFRepairs16,  CFRepairs17,  ' +
    ' CFRepairs18 from tblcustomfields', True) do
    try
      try
        if (fieldbyname('CFRepairs1').asBoolean) and (Customer.CUSTFLD1 <> '') then
          CUSTFLD1 := Customer.CUSTFLD1;
        if (fieldbyname('CFRepairs2').asBoolean) and (Customer.CUSTFLD2 <> '') then
          CUSTFLD2 := Customer.CUSTFLD2;
        if (fieldbyname('CFRepairs3').asBoolean) and (Customer.CUSTFLD3 <> '') then
          CUSTFLD3 := Customer.CUSTFLD3;
        if (fieldbyname('CFRepairs4').asBoolean) and (Customer.CUSTFLD4 <> '') then
          CUSTFLD4 := Customer.CUSTFLD4;
        if (fieldbyname('CFRepairs5').asBoolean) and (Customer.CUSTFLD5 <> '') then
          CUSTFLD5 := Customer.CUSTFLD5;
        if (fieldbyname('CFRepairs6').asBoolean) and (Customer.CUSTFLD6 <> '') then
          CUSTFLD6 := Customer.CUSTFLD6;
        if (fieldbyname('CFRepairs7').asBoolean) and (Customer.CUSTFLD7 <> '') then
          CUSTFLD7 := Customer.CUSTFLD7;
        if (fieldbyname('CFRepairs8').asBoolean) and (Customer.CUSTFLD8 <> '') then
          CUSTFLD8 := Customer.CUSTFLD8;
        if (fieldbyname('CFRepairs9').asBoolean) and (Customer.CUSTFLD9 <> '') then
          CUSTFLD9 := Customer.CUSTFLD9;
        if (fieldbyname('CFRepairs10').asBoolean) and (Customer.CUSTFLD10 <> '') then
          CUSTFLD10 := Customer.CUSTFLD10;
        if (fieldbyname('CFRepairs11').asBoolean) and (Customer.CUSTFLD11 <> '') then
          CUSTFLD11 := Customer.CUSTFLD11;
        if (fieldbyname('CFRepairs12').asBoolean) and (Customer.CUSTFLD12 <> '') then
          CUSTFLD12 := Customer.CUSTFLD12;
        if (fieldbyname('CFRepairs13').asBoolean) and (Customer.CUSTFLD13 <> '') then
          CUSTFLD13 := Customer.CUSTFLD13;
        if (fieldbyname('CFRepairs14').asBoolean) and (Customer.CUSTFLD14 <> '') then
          CUSTFLD14 := Customer.CUSTFLD14;
        if (fieldbyname('CFRepairs15').asBoolean) and (Customer.CUSTFLD15 <> '') then
          CUSTFLD15 := Customer.CUSTFLD15;
        if (fieldbyname('CFRepairs16').asBoolean) and (Customer.CUSTDATE1 <> 0) then
          CUSTDATE1 := Customer.CUSTDATE1;
        if (fieldbyname('CFRepairs17').asBoolean) and (Customer.CUSTDATE2 <> 0) then
          CUSTDATE2 := Customer.CUSTDATE2;
        if (fieldbyname('CFRepairs18').asBoolean) and (Customer.CUSTDATE3 <> 0) then
          CUSTDATE3 := Customer.CUSTDATE3;
      except
      end;
    finally
      if Active then
        Close;
      Free;
    end;
end;

procedure TRepairs.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = false then
      Exit; // we are only interested in data fields.
  inherited;
  if sysutils.SameText(Sender.fieldName, 'RepairDocno') then begin
    if not RawMode then begin
      ValidateRepairDocno;
    end;
  end
  else if sysutils.SameText(Sender.fieldName, 'UseBillCust') then begin
    if not RawMode then begin
      RepairParts.IterateRecords(GeClientPrice);
      RepairParts.IterateRecords(changeTaxID);
    end;
  end
  else if sysutils.SameText(Sender.fieldName, 'CusId') then begin
    ContactID :=0;
    CustomerName := TClient.IDToggle(Sender.AsInteger, Connection.Connection);
    if not RawMode then begin
      TimesheetEntry.Timesheet.IterateRecords(changetimeSheetJob);
      OtherFollowup.IterateRecords(changeFollowupclient);
      RepairParts.IterateRecords(GeClientPrice);
      RepairParts.IterateRecords(changeTaxID);
      PopulateCustomerDetails;
      updatecustomFlds;
      PostDB;
      sendEvent(BusObjEvent_Change, BusobjEvent_CustomerinRepair, self);

      { warning message for the user - no confirmation required }
      if Customer.IsJob then
        if Customer.WarrantyFinishDate > 0 then
          if Customer.WarrantyFinishDate < Date then
            AddResult(True, rssinfo, 0, 'The warranty of this job is out of date. ' +
              chr(13) + 'The warranty finish date is ' + FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat,
              Customer.WarrantyFinishDate));
      if AppEnv.CompanyPrefs.DefaultRepUser then
        EmployeeId := AppEnv.Employee.EmployeeId;
      if (EmployeeId = 0) or (not(AppEnv.CompanyPrefs.DefaultRepUser)) then
        EmployeeId := Customer.RepID;

      if Self.Customer.RepairCommentPopUp then begin
          If (not fPopupDisplayed) then Begin
            AddResult(True, rssinfo, 0,self.Customer.RepairComment);
            fPopupDisplayed := True;
          end;
      end else if self.Notes = '' then
            self.Notes :=  self.Customer.RepairComment;
    end;

  end
  else if sysutils.SameText(Sender.fieldName, 'CustomerName') then begin
    ContactID :=0;
    ClientID := TClient.IDToggle(Sender.AsString, Connection.Connection);
    if not RawMode then begin
      TimesheetEntry.Timesheet.IterateRecords(changetimeSheetJob);
      OtherFollowup.IterateRecords(changeFollowupclient);
      RepairParts.IterateRecords(GeClientPrice);
      RepairParts.IterateRecords(changeTaxID);
      PopulateCustomerDetails;
      updatecustomFlds;
      PostDB;
      sendEvent(BusObjEvent_Change, BusobjEvent_CustomerinRepair, self);

      { warning message for the user - no confirmation required }
      if Customer.IsJob then
        if Customer.WarrantyFinishDate > 0 then
          if Customer.WarrantyFinishDate < Date then
            AddResult(True, rssinfo, 0, 'The warranty of this job is out of date. ' +
              chr(13) + 'The warranty finish date is ' + FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat,
              Customer.WarrantyFinishDate));
      if AppEnv.CompanyPrefs.DefaultRepUser then
        EmployeeId := AppEnv.Employee.EmployeeId;
      if (EmployeeId = 0) or (not(AppEnv.CompanyPrefs.DefaultRepUser)) then
        EmployeeId := Customer.RepID;
      if Self.Customer.RepairCommentPopUp then begin
          If (not fPopupDisplayed) then Begin
            AddResult(True, rssinfo, 0,self.Customer.RepairComment);
            fPopupDisplayed := True;
          end;
      end else if self.Notes = '' then
            self.Notes :=  self.Customer.RepairComment;
    end;
  end
  else if sysutils.SameText(Sender.fieldName, 'BillCusID') then begin
    BillCustomerName := TClient.IDToggle(Sender.AsInteger, Connection.Connection);
    if not RawMode then begin
      RepairParts.IterateRecords(changeTaxID);
      PopulateBillCustomerDetails;
      RepairParts.IterateRecords(GeClientPrice);
      PostDB;
    end;
  end
  else if sysutils.SameText(Sender.fieldName, 'BillCustomerName') then begin
    BillClientID := TClient.IDToggle(Sender.AsString, Connection.Connection);
    if not RawMode then begin
      RepairParts.IterateRecords(changeTaxID);
      PopulateBillCustomerDetails;
      RepairParts.IterateRecords(GeClientPrice);
      PostDB;
    end;
  end
  else if sysutils.SameText(Sender.fieldName, 'Terms') then begin
    if not RawMode then begin
      if Terms <> '' then begin
        TermsId := TTerms.IDToggle(Terms, Connection.Connection);
        if TermsId = 0 then
          TermsId := -1;
      end
      else
        TermsId := 0;
    end;
  end
  else if sysutils.SameText(Sender.fieldName, 'TermsID') then begin
    if not RawMode then begin
      if TermsId > 0 then
        Terms := TTerms.IDToggle(TermsId, Connection.Connection)
      else
        Terms := '';
    end;
  end
  else if sysutils.SameText(Sender.fieldName, 'ClassId') then begin
  end
  else if sysutils.SameText(Sender.fieldName, 'AssetproductID') then begin
  end
  else if sysutils.SameText(Sender.fieldName, 'Notes') then begin
    if not RawMode then begin
      UpdateStatus(SimpleTypeAction_NotesAdded);
    end;
  end
  else if sysutils.SameText(Sender.fieldName, 'FeedbackNotes') then begin
    if not RawMode then begin
      UpdateStatus(SimpleTypeAction_NotesAdded);
    end;
  end else if sysutils.SameText(Sender.fieldName, 'Status') then begin
    sendEvent(BusObjEvent_Change, BusobjEvent_Repairstatus, self);
  end;
end;

Function TRepairs.GetSQL: String;
begin
  Result := Inherited GetSQL;
end;

class function TRepairs.GetIDField: String;
begin
  Result := 'Repairid';
end;

class function TRepairs.GetBusObjectTablename: string;
begin
  Result := 'tblrepairs';
end;

Function TRepairs.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then
    Exit;
  if RepairDocNo = '' then begin
    initIDTodocNo := True;
    Try
      RepairDocNo := IntToStr(ID);
    Finally
      initIDTodocNo := false;
    End;
    PostDB;
  end;
end;

class function TRepairs.DocNoForID(const aRepairID: Integer; Conn: TCustomMyConnection): string;
var
  Qry: TERPQuery;
begin
  Qry := TERPQuery.Create(nil);
  try
    if Assigned(Conn) then
      Qry.Connection := Conn
    else
      Qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    Qry.SQL.Add('select RepairDocNo from tblRepairs');
    Qry.SQL.Add('where RepairID = ' + IntToStr(aRepairID));
    Qry.Open;
    Result := Qry.fieldbyname('RepairDocNo').AsString;
  finally
    Qry.Free;
  end;
end;

Function TRepairs.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then
    Exit;
  ClassId := AppEnv.DefaultClass.ClassId;
  CreationDate := now;
  UpdateDate := now;
  JobDueDate := 0.0;
  EmployeeId := AppEnv.Employee.EmployeeId;
  EnteredBy  := AppEnv.Employee.employeeName;
  UseBillCust := false;
  PostDB;
  PostDB;
end;

procedure TRepairs.CloneLines(const Sender: TBusObj; var Abort: Boolean);
begin
  Sender.CloneBusObj(IDFieldName, ObjInstanceToClone.ID, false);
  if Sender.ObjInstanceToClone = nil then begin
    fbObjectCopied := false;
    Exit;
  End;
end;

Procedure TRepairs.CopyPropertyObjects(Const Mappedfields: STring);
begin
  if self.ObjInstanceToClone is TSalesBase then begin
    TSalesBase(ObjInstanceToClone).ConvertingRepairs := True;
    RepairParts.Mappedfields4copy := Mappedfields;
    RepairParts.MappedValues4copy := 'SaleId=' + IntToStr(ObjInstanceToClone.ID) + ', Invoiced=T';
    RepairParts.ObjInstanceToClone := TBusObj(TSalesBase(ObjInstanceToClone).Lines);
    fsconvertedIds := '';
    RepairParts.IterateRecords(BusObjCopy, false);
    if fsconvertedIds  <> '' then ExecuteSQL('update tblrepairparts Set ConvertToInvoice ="T" where RepairPartsID in (' +fsconvertedIds +') ' , true);
    //RepairParts.IterateRecordsReverse(BusObjCopyCallback, false); // reverse as post is applying the filter for converted and record disappears and skips the record
    AddServiceChargeofDept(TSalesBase(ObjInstanceToClone).Lines);
    RepairParts.IterateRecords(UpdateRelatedRefs);
    TSalesBase(ObjInstanceToClone).SilentMode := True;
    RepairEquipment.IterateRecords(UpdateRelatedRefs);
  end;
end;

Function TRepairs.CopyRepairsToRA(UseEquipment: Boolean = false): string;
var
  slOrder: TStringList;
  s: String;
  Qry: TERPQuery;
  CurrentSupplierID: Integer;
  SuppIdList: TIntegerList;
  ErrList: TStringList;
  x: Integer;

begin
  Result := '';
  if not Save then
    Exit;
  if RepairParts.count = 0 then begin
    ResultStatus.AddItem(False, rssWarning, 0 , 'The Repair doesn''t have any Product(s) selected');
    Exit;
  end;

  Connection.BeginTransaction;
  try
    Qry := TERPQuery.Create(nil);
    SuppIdList := TIntegerList.Create;
    ErrList := TStringList.Create;
    try
      Qry.Connection := Connection.Connection;
      if Assigned(fProgressDialog) then begin
        ProgressDialog.Caption := 'Creating Return Authority';
        ProgressDialog.MinValue := 0;
        ProgressDialog.Message := '';
        ProgressDialog.MaxValue := 1;
        ProgressDialog.Step := 1;
        ProgressDialog.Value := 0;
      end;
      RAObj := TReturnAuthority.Create(self);
      RAObj.Connection := self.Connection;
      RAObj.Load(0);
      slOrder := TStringList.Create;
      RAObj.SilentMode := True;
      slOrder.Duplicates := dupIgnore;
      slOrder.Sorted := True;

      if Assigned(fProgressDialog) then begin
        ProgressDialog.MinValue := 1;
        ProgressDialog.Message := 'Getting suppliers ...';
        ProgressDialog.MaxValue := RepairParts.count;
        ProgressDialog.Value := 1;
        ProgressDialog.Execute;
      end;

      if UseEquipment then begin
        Qry.SQL.Add('select');
        Qry.SQL.Add('RP.*,');
        Qry.SQL.Add('P.PartsID as ProductID, P.PartName as ProductName,');
        Qry.SQL.Add('P2.PartsID as RAProductID, P2.PartName as RAProductName,');
        Qry.SQL.Add('P.SupplierProductCode, P.PartsDescription,');
        Qry.SQL.Add('C.ClientID as SupplierID, C.Company as SupplierName,');
        Qry.SQL.Add('C.ShippingMethod');
        Qry.SQL.Add('from tblRepairParts RP');
        Qry.SQL.Add('inner join tblparts P on RP.PartsID = P.PartsID');
        Qry.SQL.Add('left join tblCustomerEquip CE on RP.CustomerEquipmentID = CE.ID');
        Qry.SQL.Add('left join tblEquipment E on CE.EquipmentID = E.EquipmentID');
        Qry.SQL.Add('left join tblParts P2 on E.ProductID = P2.PartsID');
        Qry.SQL.Add('left join tblClients C on C.Company = P2.PREFEREDSUPP');
        Qry.SQL.Add('Where RP.RepairID = ' + IntToStr(ID));
        Qry.SQL.Add('and IfNull(RP.CustomerEquipmentID,0) > 0');
        Qry.SQL.Add('order by C.Company, P2.PartName');
      end
      else begin
        Qry.SQL.Add('select');
        Qry.SQL.Add('RP.*,');
        Qry.SQL.Add('P.PartsID as ProductID, P.PartName as ProductName,');
        Qry.SQL.Add('P.PartsID as RAProductID, P.PartName as RAProductName,');
        Qry.SQL.Add('P.SupplierProductCode, P.PartsDescription,');
        Qry.SQL.Add('C.ClientID as SupplierID, C.Company as SupplierName,');
        Qry.SQL.Add('C.ShippingMethod');
        Qry.SQL.Add('from tblRepairParts RP');
        Qry.SQL.Add('inner join tblparts P on RP.PartsID = P.PartsID');
        Qry.SQL.Add('inner join tblClients C on C.Company = P.PREFEREDSUPP');
        Qry.SQL.Add('Where RP.RepairID = ' + IntToStr(ID));
        Qry.SQL.Add('order by C.Company, P.PartName');
      end;
      Qry.Open;
      if Assigned(fProgressDialog) then
        fProgressDialog.MaxValue := Qry.RecordCount;
      CurrentSupplierID := -1;
      while not Qry.Eof do begin
        if Assigned(fProgressDialog) then
          fProgressDialog.StepIt;
        if CurrentSupplierID <> Qry.fieldbyname('SupplierID').AsInteger then begin
          CurrentSupplierID := Qry.fieldbyname('SupplierID').AsInteger;
          if CurrentSupplierID > 0 then
            SuppIdList.Add(CurrentSupplierID);
        end;
        if UseEquipment then begin
          if Qry.fieldbyname('RAProductID').AsInteger = 0 then begin
            s := 'No product specified for equipment: "' + Qry.fieldbyname('Equipment')
              .AsString + '"';
            if ErrList.IndexOf(s) < 0 then
              ErrList.Add(s);
          end
          else if Qry.fieldbyname('SupplierID').AsInteger = 0 then begin
            s := 'No supplier specified for equipment - product: ' + '"' +
              Qry.fieldbyname('Equipment').AsString + '"' + ' - ' + '"' +
              Qry.fieldbyname('ProductName').AsString + '"';
            if ErrList.IndexOf(s) < 0 then
              ErrList.Add(s);
          end;
        end
        else begin
          if Qry.fieldbyname('SupplierID').AsInteger = 0 then
            ErrList.Add('No supplier specified for product: "' + Qry.fieldbyname('ProductName')
              .AsString + '"');
        end;
        Qry.Next;
      end;

      if Assigned(ProgressDialog) then
        ProgressDialog.MaxValue := SuppIdList.count;

      for x := 0 to SuppIdList.count - 1 do begin
        if Assigned(ProgressDialog) then begin
          ProgressDialog.Message := 'Creating Return Authority ' + IntToStr(x + 1) + ' of ' +
            IntToStr(SuppIdList.count);
          ProgressDialog.StepIt;
        end;
        Qry.Filtered := false;
        Qry.Filter := 'SupplierID = ' + IntToStr(SuppIdList.Item[x]);
        Qry.Filtered := True;
        Qry.First;
        if Result <> '' then
          Result := Result + ',';
        Result := Result + IntToStr(CreatePO(SuppIdList.Item[x], Qry));
      end;

      if ErrList.count > 0 then
        AddResult(True, rssinfo, 0, ErrList.Text);

      Connection.CommitTransaction;
      dirty := false;
      if Assigned(ProgressDialog) then
        ProgressDialog.CloseDialog;
    finally
      Qry.Free;
      SuppIdList.Free;
      ErrList.Free;
    end;
  except
    on E: Exception do begin
      AddResult(false, rssWarning, 0,
        'Conversion of Repair to Return Authority has failed: ' + E.Message);
      Connection.RollbackTransaction;
    End;
  end;
end;

Function TRepairs.CreatePO(const fiSupplierId: Integer; Qry: TERPQuery): Integer;
begin
  Result := 0;
  with Qry do begin
    if RecordCount = 0 then
      Exit;
    if Assigned(ProgressDialog) then begin
      ProgressDialog.MaxValue := RecordCount;
      ProgressDialog.Execute;
    end;

    RAObj.New;
    RAObj.EnteredAt := TimeToStr(Time());
    RAObj.ClientID := fiSupplierId;
    RAObj.EnteredBy := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
    RAObj.SupplierName := fieldbyname('SupplierName').AsString;
    RAObj.OrderDate := Date;
    RAObj.duedate := Date;
    RAObj.Area := Self.Area;
    RAObj.CustPONumber := self.CustomerPONumber;
    RAObj.Shipping := fieldbyname('ShippingMethod').AsString;
    RAObj.ETADate := RAObj.OrderDate + RAObj.Supplier.shiptime;
    RAObj.EmployeeName := AppEnv.Employee.EmployeeName;
    // FirstName + ' ' + AppEnv.Employee.LastName;
    RAObj.PostDB;
    First;
    While Eof = false do begin
      RAObj.Lines.New;
      RAObj.Lines.ProductId := fieldbyname('RAProductID').AsInteger;
      RAObj.Lines.LineTaxRate := fieldbyname('TaxRate').asFloat;
      RAObj.Lines.LineCost := fieldbyname('Linecost').asFloat;
      RAObj.Lines.LinecostInc := fieldbyname('LinecostInc').asFloat;
      RAObj.Lines.UnitOfmeasureID := fieldbyname('UnitofMeasureID').AsInteger;
      RAObj.Lines.UnitOfMeasure := fieldbyname('UnitofMeasure').AsString;
      RAObj.Lines.UOMMultiplier := fieldbyname('UnitofMeasureMultiplier').asFloat;
      RAObj.Lines.RAQty := fieldbyname('UOMQty').asFloat;
      RAObj.Lines.Invoiced := True;
      RAObj.Lines.LineClassId := self.ClassId;
      RAObj.Lines.CustomerJob := self.CustomerName;
      RAObj.Lines.CustomerJobID := self.ClientID;
      RAObj.Lines.RepairID := self.ID;
      RAObj.Lines.CustomerEquipmentID := fieldbyname('CustomerEquipmentID').AsInteger;
      RAObj.Lines.EquipmentName := fieldbyname('Equipment').AsString;
      RAObj.Lines.SupplierProductCode := fieldbyname('SupplierProductCode').AsString;
      RAObj.Lines.SupplierProductName := fieldbyname('SupplierProductCode').AsString;
      RAObj.Lines.ProductDescription := fieldbyname('PARTSDESCRIPTION').AsString;
      RAObj.Lines.FormulaQtyShippedValue := fieldbyname('formulaQtyValue').asFloat;
      RAObj.Lines.FormulaQtyShippedValue1 := fieldbyname('formulaQtyValue1').asFloat;
      RAObj.Lines.FormulaQtyShippedValue2 := fieldbyname('formulaQtyValue2').asFloat;
      RAObj.Lines.FormulaQtyShippedValue3 := fieldbyname('formulaQtyValue3').asFloat;
      RAObj.Lines.FormulaQtyShippedValue4 := fieldbyname('formulaQtyValue4').asFloat;
      RAObj.Lines.FormulaQtyShippedValue5 := fieldbyname('formulaQtyValue5').asFloat;
      RAObj.Lines.FormulaQtySoldValue := fieldbyname('formulaQtyValue').asFloat;
      RAObj.Lines.FormulaQtySoldValue1 := fieldbyname('formulaQtyValue1').asFloat;
      RAObj.Lines.FormulaQtySoldValue2 := fieldbyname('formulaQtyValue2').asFloat;
      RAObj.Lines.FormulaQtySoldValue3 := fieldbyname('formulaQtyValue3').asFloat;
      RAObj.Lines.FormulaQtySoldValue4 := fieldbyname('formulaQtyValue4').asFloat;
      RAObj.Lines.FormulaQtySoldValue5 := fieldbyname('formulaQtyValue5').asFloat;
      RAObj.Lines.PostDB;
      if Assigned(ProgressDialog) then begin
        ProgressDialog.StepIt;
      end;
      Next;
    end;
    RAObj.Save;
    Result := RAObj.ID;
  end;
End;

function TRepairs.CopyRepairtoSmartOrder(UseEquipment: Boolean): Integer;
begin

  POIDs := '';
  Result := 0;
  Try
    Connection.BeginTransaction;
    fbUseEquipment := UseEquipment;
    SmartOrder := TSmartOrder.Create(nil);
    try
      SmartOrder.New;
      SmartOrder.SmartOrderDesc := 'Created from Repair #' + IntToStr(ID);
      SmartOrder.Area := Self.Area;
      SmartOrder.PostDB;
      RepairParts.IterateRecords(copyLines);

      if SmartOrder.Lines.Count > 0 then
      begin
        SmartOrder.CalcOrderTotal;
        if SmartOrder.Save then
        begin
          SmartOrder.Approved := TApprovalLevels.Approve('Smart Order', SmartOrder.TotalCostInc, false);
          UpdateStatus(SimpleTypeAction_SmartOrder);
          Connection.CommitTransaction;
          Result := SmartOrder.ID;
        end
        else
          Connection.RollbackTransaction;
        if Result <> 0 then
          if Assigned(ConfirmFromGUI) then
            if fConfirmFromGUI('Do You Wish To Automatically Create " Purchase Orders " ?',
              [mbYes, MbNO]) = mrYes then
            begin
              POIDs := TSmartOrder(SmartOrder).CopySmartOrderToPO;
              Connection.CommitTransaction;
            end;
      end
      else
      begin
       MessageDlgXP_Vista('No products found to be added to the order',mtWarning, [mbOK], 0);
       Result := 0;
       Connection.RollbackTransaction;
      end;
    finally
      FreeAndNil(SmartOrder);
      fbUseEquipment := false;
    end;
  Except
    Connection.RollbackTransaction;
  end;
End;

procedure TRepairs.copyLines(const Sender: TBusObj; var Abort: Boolean);
begin
  // Called when creating PO from SmartOrder
  // Smart Order from Repairs
  if not(Sender is TRepairParts) then
    Exit;
  if (fbUseEquipment) and ((TRepairParts(Sender).EquipmentName = '') or
    (TRepairParts(Sender).Equipment.count = 0) or
    (TRepairParts(Sender).Equipment.ProductId = 0)) then
    Exit;

  if TRepairParts(Sender).PurchaseLineId <> 0 then
    exit;  // do not create duplicate

  if SameText(TRepairParts(Sender).ProductName, PART_LABOUR) then
    Exit;
  if SameText(TRepairParts(Sender).Producttype, 'OTHER') then
    Exit;
  SmartOrder.PostDB;
  With SmartOrder.Lines do begin
    New;
    if fbUseEquipment then begin
      PARTSNAME := TRepairParts(Sender).Equipment.ProductName
    end
    else begin
      PARTSNAME := TRepairParts(Sender).ProductName;
    end;
    Searchfilter := TRepairParts(Sender).ProductName;
    SearchfilterCopy := TRepairParts(Sender).ProductName;
    ClassId := TRepairParts(Sender).ClassId;
    LineTaxRate := Product.TaxPurchase.Rate;
    UnitOfMeasure := TRepairParts(Sender).UnitOfMeasure;
    UnitOfMeasureMultiplier := TRepairParts(Sender).UnitOfMeasureMultiplier;
    UnitOfmeasureID := TRepairParts(Sender).UnitOfmeasureID;
    ToPurchaseQtyexWastagePercentage(*ToPurchaseQty*) := TRepairParts(Sender).Quantity;
    ToPurchaseUOMQty := TRepairParts(Sender).UOMQty;
    costEx := Product.GetCostForQty(ToPurchaseQty);
    LinePrice := costEx;
    CusJobName := Customer.clientName;
    Groupheader := false;
    PODesc := TRepairParts(Sender).Description;
    if Product.PreferedSupplier <> nil then
      SupplierID := Product.PreferedSupplier.ID;
    RepairID := TRepairParts(Sender).RepairID;
    CustomerEquipmentID := TRepairParts(Sender).CustomerEquipmentID;
    EquipmentName := TRepairParts(Sender).EquipmentName;
    FormulaQtyValue := TRepairParts(Sender).FormulaQtyValue;
    FormulaQtyValue1 := TRepairParts(Sender).FormulaQtyValue1;
    FormulaQtyValue2 := TRepairParts(Sender).FormulaQtyValue2;
    FormulaQtyValue3 := TRepairParts(Sender).FormulaQtyValue3;
    FormulaQtyValue4 := TRepairParts(Sender).FormulaQtyValue4;
    FormulaQtyValue5 := TRepairParts(Sender).FormulaQtyValue5;
    PostDB;
  end;
end;

function TRepairs.CopyRepairtoSales(SalesType: String): string;
var
  Copiedobj: TBusObj;
  idepts: Integer;
  fsFilter: String;

begin
  Copiedobj := nil;
  Result := '';
  Departments := TStringList.Create;
  try
    Departments.Duplicates := dupIgnore;
    Departments.Sorted := True;
    RepairParts.IterateRecords(getDepartments);
    TimesheetEntry.Timesheet.IterateRecords(getDepartments);
    if Departments.count = 0 then begin
      AddResult(True, rssinfo, 0,
        'This repair doesn''t have any products or departments selected');
      Exit;
    end;
    Processingcursor;
    try
    Connection.BeginTransaction;
    try
      for idepts := 0 to Departments.count - 1 do begin
        curDeptId := strToInt(Departments[idepts]);
        fsFilter := RepairParts.Dataset.Filter;
        try

          if fsFilter <> '' then
            RepairParts.Dataset.Filter := fsFilter + ' and  ClassId = ' + Departments[idepts]
          else
            RepairParts.Dataset.Filter := ' ClassId = ' + Departments[idepts];

          RepairParts.Dataset.Filtered := True;
          MappedValues4copy := 'ClassID=' + Departments[idepts];
          Connection.BeginNestedTransaction;
          Copiedobj := CopyUsingTransactionMaper(SalesType);
          if Copiedobj = nil then begin
            if Assigned(ObjInstanceToClone) and
              (ObjInstanceToClone.Accessmanager.Accesslevel > 2) then
            else
              AddResult(True, rssError, 0, 'Repairs conversion failed:Unknown reason');
            Result := '';
            Connection.RollbackTransaction;
            UnlockAfterCopyUsingTransactionMaper(nil);
            Exit;
          end;

          TSalesBase(Copiedobj).ShipToDesc := self.CustomerDetails;
          TSalesBase(Copiedobj).InvoiceToDesc := self.BillToCustomerDetails;
          TSalesBase(CopiedObj).RepairID := Self.ID;
          Copiedobj.PostDb;
          CopyAttachments(self.TableName, ID, Copiedobj.TableName, Copiedobj.ID, self.Connection.Connection);

          { add line for the bill total price }
          if BilltotalPrice <> 0 then begin
            Connection.BeginNestedTransaction;
            try
              if Appenv.CompanyPrefs.IsSalesCategoryMandatory then
                TSales(Copiedobj).SalesCategory := TSalesCategory.DefaultTypeName;

              TSalesBase(Copiedobj).Lines.New;
              TSalesBase(Copiedobj).Lines.ProductName := PART_MEMO;
              TSalesBase(Copiedobj).Lines.QtySold := 1;
              TSalesBase(Copiedobj).Lines.QtyShipped := 1;
              TSalesBase(Copiedobj).Lines.ProductDescription := 'Bill Price from Repairs';
              TSalesBase(Copiedobj).Lines.LinePriceInc := BilltotalPrice;
              TSalesBase(Copiedobj).Lines.PostDB;

              if not TSalesBase(Copiedobj).Save then
                Connection.RollbackNestedTransaction
              else
                Connection.CommitNestedTransaction;
            Except
              on E: Exception do begin
                Connection.RollbackNestedTransaction;
              end;
            end;
          end;

          if TSalesBase(Copiedobj).Lines.count > 0 then begin
            Connection.CommitNestedTransaction;
            if Result <> '' then
              Result := Result + ',';
            Result := Result + IntToStr(Copiedobj.ID);
          end
          else begin
            Copiedobj.Cancel;
            Connection.RollbackNestedTransaction;
          end;
        finally
          RepairParts.Dataset.Filtered := false;
          RepairParts.Dataset.Filter := fsFilter;
        end;
      end;
      if not OutstandingAppointments then begin
        UpdateStatus(SimpleTypeAction_Invoice);
        if AppEnv.CompanyPrefs.RepairDoneOnConversion then
          Done := True;
        PostDB;
      end;
      Connection.CommitTransaction;
      UnlockAfterCopyUsingTransactionMaper(Copiedobj);
    Except
      on E: Exception do begin
        AddResult(True, rssError, 0, 'Repairs conversion failed:' + E.Message);
        Result := '';
        Connection.RollbackTransaction;
      end;
    end;
    finally
      Processingcursor(False);
    end;
  finally
    FreeAndNil(Departments);
  end;
end;

Function TRepairs.CloneBusObj(const Changefield: String; const ChangeValue: Variant;
  const SaveAfterCopy: Boolean = True; Const FilterFields: String = ''): TBusObj;
begin
  Result := inherited CloneBusObj(Changefield, ChangeValue, SaveAfterCopy, FilterFields);
  if Result = nil then
    Exit;
  Result := ObjInstanceToClone;
  TRepairs(Result).RepairDocNo  := IntToStr(TRepairs(Result).ID);
  TRepairs(Result).CreationDate := Date;
  TRepairs(Result).Converted    := false;
  TRepairs(Result).Done         := false;
  TRepairs(Result).RepairParts.IterateRecords(RemoveSaleRef);
  TRepairs(Result).UpdateDate   := Date;
  TRepairs(Result).PostDB;
end;

function TRepairs.RepairCustomerEquipmentIDforEquip(const fsEquipmentName: string): Integer;
begin
  with getNewdataset('Select ID , CustomerEquipmentID from tblequipmentxref where RepairId =' + inttostr(ID) +
                     ' and  CustomerEquipmentID in ' +
                     '(SELECT ID FROM tblcustomerequip where EquipmentID = '+
                     '(Select ID from tblequipment where EquipmentName =' + quotedstr(fsEquipmentName)+'))' , true) do try
     REsult := fieldbyname('CustomerEquipmentID').AsInteger;
 finally
  if active then close;
  Free;
 end;
end;

procedure TRepairs.RepairEquipmentSaveCallbackProc(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not TEquipmentXRef(Sender).Save then begin
    AllLinesSavedOK:= false;
    Abort:= true;
  end;
end;

procedure TRepairs.RepairPartsSaveCallbackProc(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not TRepairParts(Sender).Save then begin
    AllLinesSavedOK:= false;
    Abort:= true;
  end;
end;

function TRepairs.Repeatrepairs(const dates: array of TDatetime): Boolean;
var
  ctr: Integer;
  wYear, wMonth, wDay, wHour, wMin, wSec, wMilliSec: word;
  dtCompletionTime: TDate;
  dtCompletionDate: TDatetime;
begin
  if Assigned(fProgressDialog) then begin
    ProgressDialog.Caption := 'Replicating Repair Jobs .....';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := Length(dates) - 1;
    ProgressDialog.Step := 1;
    ProgressDialog.Value := ProgressDialog.MinValue;
    ProgressDialog.Execute;
  end;
  for ctr := Low(dates) to high(dates) do begin
    wYear := 0;
    wMonth := 0;
    wDay := 0;
    wHour := 0;
    wMin := 0;
    wSec := 0;
    wMilliSec := 0;
    DecodeDate(dates[ctr], wYear, wMonth, wDay);
    dtCompletionTime := StrToTime(CompletionTime);
    DecodeTime(dtCompletionTime, wHour, wMin, wSec, wMilliSec);
    dtCompletionDate := EncodeDateTime(wYear, wMonth, wDay, wHour, wMin, wSec, wMilliSec);
    if FieldsnotToclone <> '' then
      FieldsnotToclone := FieldsnotToclone + ',';
    FieldsnotToclone := FieldsnotToclone + Quotedstr('RepairDocno');
    if self.CloneBusObj('JobDueDate', dtCompletionDate, false, 'RepairID') = nil then begin
      Result := false;
      Exit;
    end;
    TRepairs(ObjInstanceToClone).RepairDocNo := IntToStr(TRepairs(ObjInstanceToClone).ID);
    TRepairs(ObjInstanceToClone).CreationDate := Dateof(dtCompletionDate);
    TRepairs(ObjInstanceToClone).Converted := false;
    TRepairs(ObjInstanceToClone).Done := false;
    TRepairs(ObjInstanceToClone).RepairParts.IterateRecords(RemoveSaleRef);
    TRepairs(ObjInstanceToClone).UpdateDate := Dateof(dtCompletionDate);
    TRepairs(ObjInstanceToClone).Save; // enforce globalref regeneration
    if Assigned(fProgressDialog) then
      ProgressDialog.StepIt;
  end;
  Result := True;
end;

Procedure TRepairs.ClonePropertyObjects;
begin

  RepairParts.IterateRecords(CloneLines);
  RepairEquipment.IterateRecords(CloneLines);
  RepairEquipmentFault.IterateRecords(CloneLines);
  RepairAttachments.IterateRecords(CloneLines);
end;

procedure TRepairs.UpdateRelatedRefs(const Sender: TBusObj; var Abort: Boolean);
begin
  if (Sender is TRepairParts) then BEGIN
    if not(TRepairParts(Sender).Product.HasRelatedProducts) then
      Exit;
    RepairREf := RepairParts.globalref;
    invocieParentProductID := RepairParts.ProductId;
    InvoiceLineRef := RepairParts.InvoiceLineRef;
    TInvoice(ObjInstanceToClone).Lines.IterateRecords(UpdateRelatedRefs);
  end
  else if Sender IS TInvoiceLine then begin
    if TInvoiceLine(Sender).RelatedParentLineRef = RepairREf then begin
      TInvoiceLine(Sender).IsRelatedProduct := True;
      TInvoiceLine(Sender).RelatedParentLineRef := InvoiceLineRef;
      TInvoiceLine(Sender).ParentProductID := invocieParentProductID;
      TInvoiceLine(Sender).PostDB;
    end;
  end
  else if Sender is TEquipmentxRef then begin
    TEquipmentxRef(Sender).InvoiceID := TInvoice(ObjInstanceToClone).ID;
  end;

end;

class function TRepairs.IDForDocNo(const aDocNo: string; Conn: TCustomMyConnection): Integer;
var
  Qry: TERPQuery;
begin
  Qry := TERPQuery.Create(nil);
  try
    if Assigned(Conn) then
      Qry.Connection := Conn
    else
      Qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    Qry.SQL.Add('select RepairID from tblRepairs');
    Qry.SQL.Add('where RepairDocNo = ' + Quotedstr(aDocNo));
    Qry.Open;
    Result := Qry.fieldbyname('RepairID').AsInteger;
  finally
    Qry.Free;
  end;
end;

Function TRepairs.ImportsubClasses(const node: IXMLNode): Boolean;
var
  x: Integer;
  Singlerec: IXMLNode;
begin
  Result := false;
  ImportFailed := false;
  XMLPropertyName := 'OtherFollowup';
  XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
  if Assigned(XMLPropertyNode) then begin
    for x := 0 to XMLPropertyNode.ChildNodes.count - 1 do begin
      OtherFollowup.ImportingFromXMLFile := True;
      Singlerec := XMLPropertyNode.ChildNodes[x];
      OtherFollowup.ImportFromXML(Singlerec);
      ImportFailed := OtherFollowup.ImportFailed;
      if Error then
        Exit;
    end;
  end;

  ImportFailed := false;
  XMLPropertyName := 'RepairProducts';
  XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
  if Assigned(XMLPropertyNode) then begin
    for x := 0 to XMLPropertyNode.ChildNodes.count - 1 do begin
      RepairParts.ImportingFromXMLFile := True;
      Singlerec := XMLPropertyNode.ChildNodes[x];
      RepairParts.ImportFromXML(Singlerec);
      ImportFailed := RepairParts.ImportFailed;
      if Error then
        Exit;
    end;
  end;

  ImportFailed := false;
  XMLPropertyName := 'RepairEquipment';
  XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
  if Assigned(XMLPropertyNode) then begin
    for x := 0 to XMLPropertyNode.ChildNodes.count - 1 do begin
      RepairEquipment.ImportingFromXMLFile := True;
      Singlerec := XMLPropertyNode.ChildNodes[x];
      RepairEquipment.ImportFromXML(Singlerec);
      ImportFailed := RepairEquipment.ImportFailed;
      if Error then
        Exit;
    end;
  end;

  ImportFailed := false;
  XMLPropertyName := 'Timesheetentries';
  XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
  if Assigned(XMLPropertyNode) then begin
    for x := 0 to XMLPropertyNode.ChildNodes.count - 1 do begin
      TimesheetEntry.ImportingFromXMLFile := True;
      Singlerec := XMLPropertyNode.ChildNodes[x];
      TimesheetEntry.ImportFromXML(Singlerec);
      ImportFailed := TimesheetEntry.ImportFailed;
      if Error then
        Exit;
    end;
  end;
  Result := True;
end;

Function TRepairs.ExportsubClasses(Const node: IXMLNode): Boolean;
begin
  self.OtherFollowup.XMLPropertyNode := node.AddChild(OtherFollowup.XMLBranchName);
  self.OtherFollowup.XMLPropertyName := OtherFollowup.XMLNodeName;
  self.OtherFollowup.IterateRecords(GetPropertyXMLCallback);

  self.RepairParts.XMLPropertyNode := node.AddChild(RepairParts.XMLBranchName);
  self.RepairParts.XMLPropertyName := RepairParts.XMLNodeName;
  self.RepairParts.IterateRecords(GetPropertyXMLCallback);

  self.RepairEquipment.XMLPropertyNode := node.AddChild(RepairEquipment.XMLBranchName);
  self.RepairEquipment.XMLPropertyName := RepairEquipment.XMLNodeName;
  self.RepairEquipment.IterateRecords(GetPropertyXMLCallback);

  self.TimesheetEntry.XMLPropertyNode := node.AddChild(TimesheetEntry.XMLBranchName);
  self.TimesheetEntry.XMLPropertyName := TimesheetEntry.XMLNodeName;
  self.TimesheetEntry.IterateRecords(GetPropertyXMLCallback);

  Result := True;
end;

Function TRepairs.getCreditCheckOn: Boolean;
begin
  Result := AppEnv.CompanyPrefs.CreditCheckRepair;
end;

Procedure TRepairs.calcPartstotalEx(Const Sender: TBusObj; var Abort: Boolean);
begin
  fdPartstotalEx := fdPartstotalEx + TRepairParts(Sender).LineTotalEx;
end;

function TRepairs.GetCleanDone: Boolean;
begin
  Result := GetXMLNodeBooleanValue(CleanXMLNOde, 'Done')
end;

function TRepairs.getCleanClientID: Integer;
begin
  Result := GetXMLNodeIntegerValue(CleanXMLNOde, 'ClientID')
end;

function TRepairs.getCleanPartstotalEx: Double;
begin
  Result := GetXMLNodeFloatValue(CleanXMLNOde, 'PartstotalEx')
end;

Function TRepairs.getPartstotalEx: Double;
begin
  fdPartstotalEx := 0;
  RepairParts.IterateRecords(calcPartstotalEx);
  Result := fdPartstotalEx;
end;

function TRepairs.IsCustomerOK(Var Msg: String): Boolean;
var
  rLimit: currency;
  rBalance: currency;
begin
  Result := True;
  if CreditCheckOn then begin
    GetCredit(ClientID, rLimit, rBalance);
    rBalance := rBalance - (PartsTotalEx - cleanPartstotalEx);
    if rLimit <= abs(rBalance) then begin
      Msg := 'Customer has Exceeded Credit Limit'#13 + 'Limit: ' + CurrToStrF(rLimit, ffCurrency, 2)
        + '   Amount: ' + CurrToStrF(rBalance, ffCurrency, 2);
      Result := false;
    end;
  end;
  { credit check is overridden when is silent }
  if SilentMode then begin
    AddResult(True, rssinfo, 0, Msg, false);
    Result := True;
  end;
end;

function TRepairs.getOtherFollowup: TOtherFollowups;
begin
  Result := TOtherFollowups(GetcontainerComponent(TOtherFollowups,
    'repairId = ' + IntToStr(self.ID)));
  if Assigned(Result) then begin
    if Result.ExportExcludeList.IndexOf('leadlineid') < 0 then
      Result.ExportExcludeList.Add('leadlineid');
  end;
end;

function TRepairs.GetRepairEquipmentFault: TRepairEquipmentFault;
begin
  Result := TRepairEquipmentFault(GetcontainerComponent(TRepairEquipmentFault,
    'repairId =' + IntToStr(self.ID)));
end;

function TRepairs.getRepairAttachments: TAttachment;
begin
  Result := TAttachment(GetcontainerComponent(TAttachment, 'Tablename = ' + Quotedstr('tblRepairs')
    + ' and TableID =' + IntToStr(self.ID)));
end;

function TRepairs.getRepairParts: TRepairParts;
begin
  Result := TRepairParts(GetcontainerComponent(TRepairParts, 'repairId =' + IntToStr(self.ID)));
end;

function TRepairs.geTEquipmentxRef: TEquipmentxRef;
begin
  Result := TEquipmentxRef(GetcontainerComponent(TEquipmentxRef,
    'RepairID = ' + IntToStr(self.ID)));
end;

function TRepairs.getTimesheetentry: TRepairTimesheetEntry;
begin
  Result := TRepairTimesheetEntry(GetcontainerComponent(TRepairTimesheetEntry, 'Type = "Repair" and TypeID = ' +    IntToStr(self.ID), False));
end;

function TRepairs.GetBillCustomer: TCustomer;
begin
  if not Assigned(fBillCustomer) then begin
    fBillCustomer := TCustomer.Create(self);
  end;
  if self.BillClientID <> fBillCustomer.ID then
    fBillCustomer.loadSelect('Customer="T" AND clientID= ' + IntToStr(self.BillClientID));
  Result := fBillCustomer;
End;

function TRepairs.GetBillCustomerName: string;
begin
  Result := GetStringField('BillCustomerName');
end;
function TRepairs.GetArea: string;
begin
  Result := GetStringField('Area');
end;

function TRepairs.GetCustomer: TCustomer;
begin
  Result := TCustomer(GetcontainerComponent(TCustomer, 'Customer="T" AND clientID= ' +
    IntToStr(self.ClientID)));
end;

Procedure TRepairs.SetBillCustomer(Const Value: TCustomer);
begin
  fBillCustomer := Value;
end;

procedure TRepairs.SetBillCustomerName(const Value: string);
begin
  SetStringField('BillCustomerName', Value);
end;
procedure TRepairs.SetArea(const Value: string);
begin
  SetStringField('Area', Value);
end;

function TRepairs.getClient: TCustomer;
begin
  { Binny : client is within transaction is used to create the client Equipments
    when SO/quote is converted }
  Result := TCustomer(GetcontainerComponent(TCustomer, 'clientId = ' + IntToStr(ClientID)));
end;

function TRepairs.getEquipmentList: TEquipment;
begin
  Result := TEquipment(GetcontainerComponent(TEquipment));
end;

{ Property functions }
Function TRepairs.GetClientID: Integer;
begin
  Result := GetIntegerField('Cusid');
End;

Function TRepairs.GetCreationdate: TDatetime;
begin
  Result := GetDatetimeField('Creationdate');
End;

Function TRepairs.GetUpdatedate: TDatetime;
begin
  Result := GetDatetimeField('Updatedate');
End;

Function TRepairs.GetDone: Boolean;
begin
  Result := GetBooleanField('Done');
End;

Function TRepairs.GetNotes: String;
begin
  Result := GetStringField('Notes');
End;

Function TRepairs.GetFeedbacknotes: String;
begin
  Result := GetStringField('Feedbacknotes');
End;
Function TRepairs.GetEnteredBy: String;
begin
  Result := GetStringField('EnteredBy');
End;

Function TRepairs.GetClassID: Integer;
begin
  Result := GetIntegerField('Classid');
End;

Function TRepairs.GetEmployeeid: Integer;
begin
  Result := GetIntegerField('Employeeid');
End;

function TRepairs.GetEmployeeName: string;
begin
  if EmployeeId > 0 then
    Result := TEmployee.IDToggle(EmployeeId, Connection.Connection)
  else
    Result := '';
end;

Function TRepairs.GetCustomerdetails: String;
begin
  Result := GetStringField('Customerdetails');
End;

function TRepairs.GetCustomerName: string;
begin
  Result := GetStringField('CustomerName');
end;

Function TRepairs.GetPhone: String;
begin
  Result := GetStringField('Phone');
End;

Function TRepairs.GetAltphone: String;
begin
  Result := GetStringField('Altphone');
End;

Function TRepairs.GetFax: String;
begin
  Result := GetStringField('Fax');
End;

Function TRepairs.GetJobduedate: TDatetime;
begin
  Result := GetDatetimeField('Jobduedate');
End;

function TRepairs.GetContactMobile: string;
var
  Contact: TContact;
begin
  result := '';
  if self.ContactId > 0 then begin
    Contact := TContact.Create(nil);
    try
      Contact.Connection := self.Connection;
      Contact.Load(self.ContactID,True);
      result := Contact.ContactMOB;
    finally
      Contact.Free;
    end;
  end;
end;

function TRepairs.GetContactName: string;
var
  Contact: TContact;
begin
  result := '';
  if self.ContactId > 0 then begin
    Contact := TContact.Create(nil);
    try
      Contact.Connection := self.Connection;
      Contact.Load(self.ContactID,True);
      result := Contact.Company;
    finally
      Contact.Free;
    end;
  end;
end;

Function TRepairs.GetConverted: Boolean;
begin
  Result := GetBooleanField('Converted');
End;

function TRepairs.getCorrespondence: TCorrespondence;
begin
  Result := TCorrespondence(GetcontainerComponent(TCorrespondence,
    'RepairId = ' + IntToStr(self.ID)));
end;

Function TRepairs.GetStatus: String;
begin
  Result := GetStringField('Status');
End;

Function TRepairs.GetBilltocustomerdetails: String;
begin
  Result := GetStringField('Billtocustomerdetails');
End;

function TRepairs.getBilltotalPrice: Double;
begin
  Result := getFloatfield('BilltotalPrice');
end;

Function TRepairs.GetBillClientID: Integer;
begin
  Result := GetIntegerField('Billcusid');
End;

Function TRepairs.GetUsebillcust: Boolean;
begin
  Result := GetBooleanField('Usebillcust');
End;

function TRepairs.HasNonInvProducts: Boolean;
var
  strSQL: String;
begin
  strSQL := 'Select count(*) as ctr from ' + RepairParts.BusObjectTableName +
    ' where  PartType = "OTHER" ' + ' AND ' + IDFieldName + ' = ' + IntToStr(ID) +
    ' and Deleted = "F"';
  with GetNewDataset(strSQL, True) do
    try
      Result := fieldbyname('ctr').AsInteger <> 0;
    finally
      if Active then
        Close;
      Free;
    end;
end;

function TRepairs.HasInvProducts: Boolean;
var
  strSQL: String;
begin
  strSQL := 'Select count(*) as ctr from ' + RepairParts.BusObjectTableName +
    ' where  PartType <> "OTHER" ' + ' AND ' + IDFieldName + ' = ' + IntToStr(ID) +
    ' and Deleted = "F"';
  with GetNewDataset(strSQL, True) do
    try
      Result := fieldbyname('ctr').AsInteger <> 0;
    finally
      if Active then
        Close;
      Free;
    end;
end;

Function TRepairs.getRepairDocno: String;
begin
  Result := GetStringField('RepairDocno');
end;

Function TRepairs.GetBillphone: String;
begin
  Result := GetStringField('Billphone');
End;

Function TRepairs.GetBillaltphone: String;
begin
  Result := GetStringField('Billaltphone');
End;

Function TRepairs.GetBillfax: String;
begin
  Result := GetStringField('Billfax');
End;

Function TRepairs.GetSoglobalref: String;
begin
  Result := GetStringField('Soglobalref');
End;

Function TRepairs.GetQuoteglobalref: String;
begin
  Result := GetStringField('Quoteglobalref');
End;

function TRepairs.GetRepairAssetXRef: TRepairAssetXRef;
begin
  Result := TRepairAssetXRef(GetcontainerComponent(TRepairAssetXRef,
    'RepairId = ' + IntToStr(self.ID)));
end;

Function TRepairs.GetCustomerponumber: String;
begin
  Result := GetStringField('Customerponumber');
End;

Function TRepairs.GetCompletiontime: String;
begin
  Result := GetStringField('Completiontime');
  if Result = '' then
    Result := '0:00'
End;

function TRepairs.GetContactEmail: string;
var
  Contact: TContact;
begin
  result := '';
  if self.ContactId > 0 then begin
    Contact := TContact.Create(nil);
    try
      Contact.Connection := self.Connection;
      Contact.Load(self.ContactID,True);
      result := Contact.ContactEmail;
    finally
      Contact.Free;
    end;
  end;
end;

Function TRepairs.GetShipping: String;
begin
  Result := GetStringField('Shipping');
End;

function TRepairs.GetShippingAddress: TShippingAddress;
begin
  Result := TShippingAddress(GetcontainerComponent(TShippingAddress, 'ShipAddressId = ' + IntToStr(ShipToID)));
end;

function TRepairs.getShipToID: Integer;
begin
  Result := GetIntegerField('ShipToID');
end;

Function TRepairs.GetAllocatedemployeeid: Integer;
begin
  Result := GetIntegerField('Allocatedemployeeid');
End;

function TRepairs.GetAllocatedEmployeeName: string;
begin
  if AllocatedEmployeeId > 0 then
    Result := TEmployee.IDToggle(AllocatedEmployeeId, Connection.Connection)
  else
    Result := '';
end;

function TRepairs.getContactID: Integer;
begin
  Result := GetIntegerField('contactID');
end;

function TRepairs.getBillMobile: String;
begin
  Result := GetStringField('billMobile');
end;

function TRepairs.getMobile: String;
begin
  Result := GetStringField('Mobile');
end;

function TRepairs.getTerms: String;
begin
  Result := GetStringField('Terms');
end;

function TRepairs.getTermsId: Integer;
begin
  Result := GetIntegerField('TermsID');
end;

procedure TRepairs.SetBillMobile(const Value: String);
begin
  SetStringField('BillMobile', Value);
End;

procedure TRepairs.SetMobile(const Value: String);
begin
  SetStringField('Mobile', Value);
End;

procedure TRepairs.SetTerms(const Value: String);
begin
  SetStringField('Terms', Value);
End;

procedure TRepairs.SetTermsId(const Value: Integer);
begin
  SetIntegerField('TermsID', Value);
End;

procedure TRepairs.SetContactId(const Value: Integer);
begin
  SetIntegerField('ContactId', Value);
End;

Procedure TRepairs.SetClientID(Const Value: Integer);
begin
  SetIntegerField('Cusid', Value);
End;

Procedure TRepairs.SetCreationdate(Const Value: TDatetime);
begin
  SetDatetimeField('Creationdate', Value);
End;

Procedure TRepairs.SetUpdatedate(Const Value: TDatetime);
begin
  SetDatetimeField('Updatedate', Value);
End;

Procedure TRepairs.SetDone(Const Value: Boolean);
begin
  SetBooleanField('Done', Value);
End;

Procedure TRepairs.SetNotes(Const Value: String);
begin
  SetStringField('Notes', Value);
End;

Procedure TRepairs.SetFeedbacknotes(Const Value: String);
begin
  SetStringField('Feedbacknotes', Value);
End;
Procedure TRepairs.SetEnteredBy(Const Value: String);
begin
  SetStringField('EnteredBy', Value);
End;

Procedure TRepairs.setClassID(Const Value: Integer);
begin
  SetIntegerField('Classid', Value);
End;

Procedure TRepairs.SetEmployeeid(Const Value: Integer);
begin
  SetIntegerField('Employeeid', Value);
End;

procedure TRepairs.SetEmployeeName(const Value: string);
begin
  if Value <> '' then begin
    EmployeeId := TEmployee.IDToggle(Value, Connection.Connection);
    if EmployeeId = 0 then
      EmployeeId := -1;
  end
  else
    EmployeeId := 0;
end;

Procedure TRepairs.SetCustomerdetails(Const Value: String);
begin
  SetStringField('Customerdetails', Value);
End;

procedure TRepairs.SetCustomerName(const Value: string);
begin
  SetStringField('CustomerName', Value);
end;

Procedure TRepairs.SetPhone(Const Value: String);
begin
  SetStringField('Phone', Value);
End;

Procedure TRepairs.SetAltphone(Const Value: String);
begin
  SetStringField('Altphone', Value);
End;

Procedure TRepairs.SetFax(Const Value: String);
begin
  SetStringField('Fax', Value);
End;

Procedure TRepairs.SetJobduedate(Const Value: TDatetime);
begin
  SetDatetimeField('Jobduedate', Value);
End;

Procedure TRepairs.SetConverted(Const Value: Boolean);
begin
  SetBooleanField('Converted', Value);
End;

Procedure TRepairs.SetStatus(Const Value: String);
begin
  SetStringField('Status', Value);
End;

Procedure TRepairs.SetBilltocustomerdetails(Const Value: String);
begin
  SetStringField('Billtocustomerdetails', Value);
End;

Procedure TRepairs.SetBillClientID(Const Value: Integer);
begin
  SetIntegerField('Billcusid', Value);
End;

Procedure TRepairs.SetUsebillcust(Const Value: Boolean);
begin
  SetBooleanField('Usebillcust', Value);
End;

Procedure TRepairs.SetBillphone(Const Value: String);
begin
  SetStringField('Billphone', Value);
End;

Procedure TRepairs.SetBillaltphone(Const Value: String);
begin
  SetStringField('Billaltphone', Value);
End;

Procedure TRepairs.SetBillfax(Const Value: String);
begin
  SetStringField('Billfax', Value);
End;

Procedure TRepairs.SetSoglobalref(Const Value: String);
begin
  SetStringField('Soglobalref', Value);
End;

Procedure TRepairs.SetQuoteglobalref(Const Value: String);
begin
  SetStringField('Quoteglobalref', Value);
End;

procedure TRepairs.setRepairDocno(const Value: String);
begin
  SetStringField('RepairDocno', Value);
end;

Procedure TRepairs.SetCustomerponumber(Const Value: String);
begin
  SetStringField('Customerponumber', Value);
End;

procedure TRepairs.SetDeptClassName(const Value: string);
begin
  if Value <> '' then begin
    ClassId := TDeptClass.IDToggle(Value, Connection.Connection);
    if ClassId = 0 then
      ClassId := -1;
  end
  else
    ClassId := 0;
end;

Procedure TRepairs.SetCompletiontime(Const Value: String);
begin
  SetStringField('Completiontime', Value);
End;

Procedure TRepairs.SetShipping(Const Value: String);
begin
  SetStringField('Shipping', Value);
End;

procedure TRepairs.setShipToID(const Value: Integer);
begin
  SetIntegerField('ShipToID', Value);
end;

Procedure TRepairs.SetAllocatedemployeeid(Const Value: Integer);
begin
  SetIntegerField('Allocatedemployeeid', Value);
End;

procedure TRepairs.SetAllocatedEmployeeName(const Value: string);
begin
  if Value <> '' then begin
    AllocatedEmployeeId := TEmployee.IDToggle(Value, Connection.Connection);
    if AllocatedEmployeeId = 0 then
      AllocatedEmployeeId := -1;
  end
  else
    AllocatedEmployeeId := 0;

end;

{ TRepairParts }

constructor TRepairParts.Create(AOwner: TComponent);
begin
  fbCalcQtyFromformula := false;
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblrepairparts';
  fSQLOrder := 'RepairPartsID';
  fIsList := True;
  ExportExcludeList.Add('repairid');
  ExportExcludeList.Add('productid');
  ExportExcludeList.Add('RepairPartsClassId');
  ExportExcludeList.Add('product');
  ExportExcludeList.Add('unitofmeasureid');
  ExportExcludeList.Add('parentproductid');
end;

destructor TRepairParts.Destroy;
begin
  FreeAndNil(fClientDiscountObj);
  inherited;
end;

Function TRepairParts.ValidateXMLData(Const node: IXMLNode): Boolean;
var
  fiProductID: Integer;
  fiClassid: Integer;
begin
  Result := inherited ValidateXMLData(node);
  if not Result then
    Exit;
  if not ImportingFromXMLFile then
    Exit;

  if GetXMLNodeIntegerValue(node, 'ImportingID') <> 0 then
    XMLSearchRecorddesc := IDFieldName + ' =' +
      IntToStr(GetXMLNodeIntegerValue(node, 'ImportingID'))
  else
    XMLSearchRecorddesc := IDFieldName + ' =' + IntToStr(GetXMLNodeIntegerValue(node, IDFieldName));
  XMLSearchRecorddesc := ' and Productnmame = ' + GetXMLNodeStringValue(node, 'ProductName');

  Result := false;

  if GetXMLNodeStringValue(node, 'ProductName') <> '' then begin
    fiProductID := tcDataUtils.GetProduct(GetXMLNodeStringValue(node, 'ProductName'));
    if fiProductID = 0 then begin
      ErrRecordNotfound('ProductName', GetXMLNodeStringValue(node, 'ProductName'));
      Exit;
    end;
  end;
  if GetXMLNodeStringValue(node, 'Deptname') <> '' then begin
    fiClassid := tcDataUtils.GetProduct(GetXMLNodeStringValue(node, 'Deptname'));
    if fiClassid = 0 then begin
      ErrRecordNotfound('Deptname', GetXMLNodeStringValue(node, 'Deptname'));
      Exit;
    end;
  end;
  LocateXMLRecord;

end;

class function TRepairParts._Schema: string;
begin
  Result := inherited;
  TBOSchema.AddRefType(Result, 'TProductWeb', 'ProductObj', 'ProductID', 'ID');
  TBOSchema.AddRefType(Result, 'TProductWeb', 'ProductObj', 'ProductName', 'ProductName');
  TBOSchema.AddRefType(Result, 'TTaxCode', 'TaxCodeObj', 'TaxCode', 'CodeName');
  TBOSchema.AddRefType(Result, 'TDeptClass', 'DeptClassObj', 'RepairPartsClassId', 'ID');
  TBOSchema.AddRefType(Result, 'TDeptClass', 'DeptClassObj', 'DeptName', 'DeptClassName');
  TBOSchema.AddRefType(Result, 'TCustomerEquipment', 'CustomerEquipObj',
    'CustomerEquipmentId', 'Id');
  TBOSchema.AddRefType(Result, 'TProductWeb', 'ParentProductObj', 'ParentProductID', 'ID');
  TBOSchema.AddRefType(Result, 'TProductWeb', 'ParentProductObj', 'ParentProductName',
    'ProductName');
end;

procedure TRepairParts.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  if not ImportingFromXMLFile then begin
    SetPropertyFromNode(node, 'ProductID');
    SetPropertyFromNode(node, 'RepairPartsClassId');
  end
  else begin
    ProductId := tcDataUtils.GetProduct(GetXMLNodeStringValue(node, 'ProductName'));
    RepairPartsClassId := tcDataUtils.GetDeptID(GetXMLNodeStringValue(node, 'Deptname'));
  end;
  SetPropertyFromNode(node, 'ProductName');
  SetPropertyFromNode(node, 'Quantity');
  SetPropertyFromNode(node, 'Description');
  SetPropertyFromNode(node, 'Priceex');
  SetPropertyFromNode(node, 'Priceinc');
  SetPropertyFromNode(node, 'Taxcode');
  SetPropertyFromNode(node, 'PartBarcode');
  SetPropertyFromNode(node, 'Taxrate');
  SetPropertyFromNode(node, 'Discount');
  SetPropertyFromNode(node, 'Markup');
  SetPropertyFromNode(node, 'Discountpercent');
  SetPropertyFromNode(node, 'Markuppercent');
  SetPropertyFromNode(node, 'Linetotalex');
  SetPropertyFromNode(node, 'Deptname');
  SetPropertyFromNode(node, 'Producttype');
  SetBooleanPropertyFromNode(node, 'Converttoinvoice');
  SetDateTimePropertyFromNode(node, 'Etadate');
  SetPropertyFromNode(node, 'Memoline');
end;

procedure TRepairParts.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  if not SavingXMLTofile then begin
    AddXMLNode(node, 'ProductID', ProductId);
    AddXMLNode(node, 'RepairPartsClassId', RepairPartsClassId);
  end
  else begin
  end;
  AddXMLNode(node, 'ProductName', ProductName);
  AddXMLNode(node, 'Quantity', Quantity);
  AddXMLNode(node, 'Description', Description);
  AddXMLNode(node, 'Priceex', PriceEx);
  AddXMLNode(node, 'Priceinc', PriceInc);
  AddXMLNode(node, 'Taxcode', TaxCode);
  AddXMLNode(node, 'PartBarcode', PartBarcode);
  AddXMLNode(node, 'Taxrate', TaxRate);
  AddXMLNode(node, 'Discount', Discount);
  AddXMLNode(node, 'Markup', Markup);
  AddXMLNode(node, 'Discountpercent', DiscountPercent);
  AddXMLNode(node, 'Markuppercent', MarkupPercent);
  AddXMLNode(node, 'Linetotalex', LineTotalEx);
  AddXMLNode(node, 'DeptName', DeptName);
  AddXMLNode(node, 'Producttype', Producttype);
  AddXMLNode(node, 'Converttoinvoice', ConvertToInvoice);
  AddXMLNode(node, 'Etadate', ETADate);
  AddXMLNode(node, 'Memoline', MemoLine);
  if not SavingXMLTofile then begin
    AddXMLNode(node, 'calcTax', CalcTax);
    //AddXMLNode(node, 'calcTotalEx', CalcTotalEx);
    AddXMLNode(node, 'calcTotalInc', CalcTotalInc);
    AddXMLNode(node, 'calcTotalIncBase', CalcTotalIncBase);
  end;
end;

function TRepairParts.ValidateData: Boolean;
begin
  Result := false;
  Resultstatus.Clear;
  if deleted then begin
    Result:= TRue;
    Exit;
  end;
  if ProductId = 0 then begin
    AddResult(false, rssWarning, 0, 'Product should not be blank');
    Exit;
  end;
  if MaximumDiscountExceeded then begin
    Exit;
  end;
  if ParentProductID < 0 then begin
    AddResult(false, rssWarning, 0, 'Parent Product not found');
    Exit;
  end;
  Result := True;
end;

function TRepairParts.Save: Boolean;
begin
  Result := false;
  if not ValidateData then
    Exit;
  Result := Inherited Save;
end;

Function TRepairParts.MaximumDiscountExceeded: Boolean;
var
  (*dMaxDiscount, Percent, *)dDiscount, dDiscountPercent, dLineTotalEx, ADiscPrice: Double;
  Msg:String;
begin
  Result := false;
  if (Discount = 0) and (DiscountPercent=0) then    Exit;
  dDiscount := Discount;
  dDiscountPercent:= DiscountPercent;

  (*dMaxDiscount := DivZer(Discount, PriceEx * Quantity);*)
  dLineTotalEx := LineTotalEx;
  if Discount <> 0 then ADiscPrice :=  dLineTotalEx - Discount else ADiscPrice :=  commonlib.GetAmountEx(dLineTotalEx, DiscountPercent);
  if not TSalesDiscountValidationObj.ValidateDiscount(Self, dDiscount  , dDiscountPercent, LineCost , dLineTotalEx , ADiscPrice ,Qty , ProductId , True, True, Msg) then begin
    Discount := dDiscount;
    DiscountPercent := dDiscountPercent;
    AddResult(false, rssWarning, 0,Msg);
     Result:= tRue;
  end;
end;

procedure TRepairParts.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  FreeAndNil(fClientDiscountObj);
end;

Procedure TRepairParts.UpdateTaxId;
var
  strSQL: String;
begin
  { getting the default taxid
    when usebillcustomer is TRUE(check box in the gui - will be false when object is used)
    billtoclient's taxid, otherwise the customer's taxid.
    if the customer's taxid is not given, its the produc's taxid }
  strSQL := 'SELECT "C" as Category , tbltaxcodes.Name,tbltaxcodes.Rate   ' +
    ' FROM tblclients ' +
    ' Inner Join tbltaxcodes ON tblclients.TAXID = tbltaxcodes.TaxCodeID  and tbltaxcodes.regionid= '+IntToStr(AppEnv.RegionalOptions.ID)+
    ' where tblclients.clientId = ' + IntToStr(InvoiceToclientID);

  strSQL := strSQL + ' union ';

  strSQL := strSQL + ' SELECT "P"  as Category, tbltaxcodes.Name,tbltaxcodes.Rate ' +
    ' FROM tbltaxcodes  Inner Join tblParts ON tblParts.TAXCODE = tbltaxcodes.Name  and tbltaxcodes.regionid= '+IntToStr(AppEnv.RegionalOptions.ID) +
    ' where tblParts.PartsId = ' + IntToStr(self.ProductId) + ' Order by Category';
  With GetNewDataset(strSQL) do
    try
      if RecordCount > 0 then begin
        TaxRate := fieldbyname('Rate').asFloat;
        TaxCode := fieldbyname('Name').AsString;
      end;
    Finally
      if Active then
        Close;
      Free;
    end;

end;

procedure TRepairParts.getCalcQtYformulaValue(Sender: TObject; const VarName: string;
  var Value: extended; var FieldFound: Boolean);
begin
  if SameText(VarName, 'Field1') then begin
    Value := FormulaQtyValue1;
    FieldFound := True;
  end
  else if SameText(VarName, 'Field2') then begin
    Value := FormulaQtyValue2;
    FieldFound := True;
  end
  else if SameText(VarName, 'Field3') then begin
    Value := FormulaQtyValue3;
    FieldFound := True;
  end
  else if SameText(VarName, 'Field4') then begin
    Value := FormulaQtyValue4;
    FieldFound := True;
  end
  else if SameText(VarName, 'Field5') then begin
    Value := FormulaQtyValue5;
    FieldFound := True;
  end;
end;

procedure TRepairParts.CalcQtyFromformula;
var
  Qty: Double;
  ErrMsg: string;
begin
  PostDB;
  if ProductId = 0 then
    Exit;
  PostDB;
  if QtyCalcFormulaDetails.PartCalcformula = '' then
    Exit;
  fbCalcQtyFromformula := True;
  try
    Qty := ProductQtyParseValue(self, getCalcQtYformulaValue, ErrMsg, self, FormulaQtyValue);
    UOMQty := Qty;
    DoFieldOnChange(Dataset.Findfield('UOMQty'));
  finally
    fbCalcQtyFromformula := false;
  end;
end;

procedure TRepairParts.DoFieldOnChange(Sender: TField);
var
  x:String;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = false then
      Exit; // we are only interested in data fields.
  inherited;
  if sysutils.SameText(Sender.fieldName, 'FormulaQtyValue') or
    sysutils.SameText(Sender.fieldName, 'FormulaQtyValue1') or
    sysutils.SameText(Sender.fieldName, 'FormulaQtyValue2') or
    sysutils.SameText(Sender.fieldName, 'FormulaQtyValue3') or
    sysutils.SameText(Sender.fieldName, 'FormulaQtyValue4') or
    sysutils.SameText(Sender.fieldName, 'FormulaQtyValue5') then begin
    if not RawMode then
      CalcQtyFromformula;
  end else if Sysutils.SameText(Sender.FieldName , 'PartBarcode') then begin
    if not RawMode then begin
//      x := tcdatautils.GetProductForbarCode(PartBarcode);
      x := tcdatautils.GetProductForbarCodeEx(PartBarcode);
      if sametext(x,'InactiveProduct') then
        partbarcode := ''
      else if (sametext(x,'Inactivebarcode')) or (x='') then begin
          SendEvent(BusobjEvent_ToDo, BusObjEvent_PartBarcodeNotfound, self);
          if productname <> '' then
            DoFieldOnChange(Dataset.findfield('Partname'));
      end else begin
        ProductName := x;
        DoFieldOnChange(Dataset.findfield('Partname'));
      end;
    end;
  end  else if sysutils.SameText(Sender.fieldName, 'classId') then begin
    DeptName := TDeptClass.IDToggle(RepairPartsClassId, Connection.Connection);
  end
  else if sysutils.SameText(Sender.fieldName, 'Partname') then begin
    ProductId := TProduct.IDToggle(ProductName, Connection.Connection);
    if not RawMode then begin
      if ProductId <> 0 then
        DoFieldOnChange(Dataset.Findfield('PartsID'));
    end;
  end
  else if sysutils.SameText(Sender.fieldName, 'PartsID') then begin
    if ProductId <> 0 then begin
      ProductName := Product.ProductName;
    end;
    if not RawMode then begin
      if ProductId <> 0 then begin
        ProductName := Product.ProductName;
        Description := Product.SalesDescription;
        Producttype := Product.Producttype;
      end;
      ConvertToInvoice := False;
      if ProductChanged then Exit;
      UpdateTaxId;
      Discount := 0.0;
      Markup := 0.0;
      GetBaseLinePrice;
      CalcLineTotals;//LineTotalEx := CalcTotalEx;

      if Product.AverageCost <> 0 then begin
        LineCost := Product.AverageCost;
      end else begin
        LineCost := Product.BuyQty1Cost;
      end;
      LineCostinc := GetAmountInc(LineCost, TaxRate);
      if UnitOfmeasureID <> Product.UOMSalesID then begin
        UnitOfMeasure := Product.UOMSales;
        UnitOfmeasureID := Product.UOMSalesID;
        UOMMultiplier := getUnitMultiplier(UnitOfmeasureID);
        Qty := UOMQty * UOMMultiplier;
      end;
      sendEvent(BusObjEvent_Change, BusObjEventVal_ProductChanged, self);
      CalcPartsTotalamount;
      if IsConverting = false then AddRelatedParts;
      if UOMQty <= 0 then begin
        UOMQty := 1.0;
        DoFieldOnChange(Dataset.Findfield('UOMQty'));
      end;
    end;
  end else if sysutils.SameText(Sender.fieldName, 'TaxCode') then begin
    if not RawMode then begin
      TaxRate := GetTaxRateForCode(Taxcode);
      Discount := 0.0;
      Markup := 0.0;
      DiscountPercent := 0.0;
      MarkupPercent := 0.0;
      DoFieldOnChange(Dataset.Findfield('PriceEx'));
    end;
  end  else if sysutils.SameText(Sender.fieldName, 'Discount') then begin
    if ProductId > 0 then begin
      PostDb;
      ProcessDiscountmarkup(dmDiscount);
      PostDb;
    end;
  end  else if sysutils.SameText(Sender.fieldName, 'Discountpercent') then begin
    if ProductId > 0 then begin
      PostDb;
      ProcessDiscountmarkup(dmDiscountPercent);
      PostDb;
    end;
  end  else if sysutils.SameText(Sender.fieldName, 'Markup') then begin
    if ProductId > 0 then begin
      PostDb;
      ProcessDiscountmarkup(dmMarkup);
      PostDb;
    end;
  end else if sysutils.SameText(Sender.fieldName, 'MarkupPercent') then begin
    if ProductId > 0 then begin
      PostDb;
      ProcessDiscountmarkup(dmMarkupPercent);
      PostDb;
    end;
  end else if sysutils.SameText(Sender.fieldName, 'LineTotalEx') then begin
    if not RawMode then begin
      Discount:= 0;
      Markup := 0;
      PriceEx := divzer(LineTotalEx , quantity);
      PriceInc := GetAmountInc(PriceEx, TaxRate);
      CalcLineTotals;//LineTotalEx := CalcTotalEx;
    end;

  end else if sysutils.SameText(Sender.fieldName, 'PriceEx') then begin
    if not RawMode then begin
      PriceInc := GetAmountInc(PriceEx, TaxRate);
      CalcLineTotals;//LineTotalEx := CalcTotalEx;
    end;
  end
  else if sysutils.SameText(Sender.fieldName, 'PriceInc') then begin
    if not RawMode then begin
      CalcLineTotals;//LineTotalEx := CalcTotalEx;
      CalcPartsTotalamount;
    end;
  end else if Sysutils.SameText(Sender.FieldName, 'UnitofMeasure') then begin
    initUOM(Sender);
    GetBaseLinePrice;
  end else if sysutils.SameText(Sender.fieldName, 'UnitofmeasureID') then begin
    UnitOfMeasure := tcdatautils.GetUOMName(UnitOfmeasureID);
    if not RawMode then begin
      UOMMultiplier := getUnitMultiplier(UnitOfmeasureID);
      Qty := UOMQty * UOMMultiplier;
    end;
    GetBaseLinePrice;
    CalcLineTotals;//LineTotalEx := CalcTotalEx;
    CalcPartsTotalamount;
  end
  else if sysutils.SameText(Sender.fieldName, 'UOMQty') then begin
    if not RawMode then begin
      if UOMMultiplier <> 0 then begin
        Qty := UOMQty * UOMMultiplier;
        DoFieldOnChange(Dataset.Findfield('Qty'));
      end;
      sendEvent(BusObjEvent_Change, BusObjEventVal_Qty, self);
    end;
  end
  else if sysutils.SameText(Sender.fieldName, 'Qty') then begin
    if not RawMode then begin
      CalcLineTotals;//LineTotalEx := CalcTotalEx;
      Discount := 0.0;
      Markup := 0.0;
      CalcPartsTotalamount;
      UOMQty := DivZer(Qty, UOMMultiplier);
      updaterelatedPartsQty;
    end;
  end
  else if sysutils.SameText(Sender.fieldName, 'CustomerEquipmentID') then begin
    if not RawMode then begin
      EquipmentName := TCustomerEquipment.EquipmentNameForId(CustomerEquipmentID,
        Connection.Connection);
      if EquipmentName <> '' then
        sendEvent(BusObjEvent_Change, BusObjEventVal_Equipment, self);
    end;
  end
  else if sysutils.SameText(Sender.fieldName, 'Equipment') then begin
    if not RawMode then begin
      if EquipmentName <> '' then
        sendEvent(BusObjEvent_Change, BusObjEventVal_Equipment, self)
      else begin
        self.CustomerEquipmentID := 0;
      end;
    end;
  end;
end;
procedure TRepairParts.InitUOM(const UOMName, UOMNameOldValue: String);
begin
  inherited;
  if not RawMode then begin
    UOMQty := Round(DivZer(Qty, UOMMultiplier), Self.RoundPlacesGeneral);
  end;
end;

Function TRepairParts.GetSQL: String;
begin
  Result := Inherited GetSQL;
end;

class function TRepairParts.GetIDField: String;
begin
  Result := 'Repairpartsid'
end;

class function TRepairParts.GetBusObjectTablename: string;
begin
  Result := 'tblrepairparts';
end;

Function TRepairParts.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then
    Exit;
  (* if count > 0 then
    if EmptyRecord then
    try      Dataset.Delete; except end; *)

  if count > 0 then
    if Assigned(self.Owner) then
      if self.Owner is TRepairs then
        TRepairs(self.Owner).UpdateStatus(SimpleTypeAction_ProductAdded);
End;

function TRepairParts.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeInsert(Sender);
  if not(Result) then
    Exit;
  if count = 0 then
    PrevCustomerEquipmentID := 0
  else begin
    Dataset.last;
    PrevCustomerEquipmentID := CustomerEquipmentID;
  end;
end;

function TRepairParts.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not Result then
    Exit;
  if { (not DatasetPosting) and } (ProductId = 0) and
    ((ProductName = '') or (TProduct.IDToggle(ProductName, Connection.Connection) = 0)) then begin
    Deleted := True;
    Result := True;
    Exit;
  end;
end;

function TRepairParts.DoCalcFields(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoCalcFields(Sender);
  if not(Result) then Exit;
  CalcTotalIncBase  := TotalIncBase;                        //PriceInc * Quantity;
  CalcTotalInc      := TotalInc;                            // PriceInc * Quantity + Markup - Discount;
  //LineTotalEx       := GetAmountEx(CalcTotalInc, TaxRate);  // CalcTotalInc / (1.0 + TaxRate);
  CalcTax           := TaxRate * 100.0; // NOTE : field used to display on the grid. this is not the total tax amount
end;
function TRepairParts.TotalInc: double;begin  REsult:= PriceInc * Quantity + Markup - Discount; end;
function TRepairParts.TotalIncBase: Double;begin  REsult:= PriceInc * Quantity; end;

Procedure TRepairParts.CreateInstance;
begin
  if Owner is TRepairs then
    if Assigned(TRepairs(Owner).ObjInstanceToClone) then
      if TRepairs(Owner).ObjInstanceToClone is TRepairs then
        ObjInstanceToClone := TRepairs(TRepairs(Owner).ObjInstanceToClone).RepairParts
      else if TRepairs(Owner).ObjInstanceToClone is TInvoice then
        ObjInstanceToClone := TInvoice(TRepairs(Owner).ObjInstanceToClone).Lines
      else if TRepairs(Owner).ObjInstanceToClone is TSalesOrder then
        ObjInstanceToClone := TSalesOrder(TRepairs(Owner).ObjInstanceToClone).Lines;
end;

function TRepairParts.DoAfterDelete(Sender: TDatasetBusObj): Boolean;
begin
  CalcPartsTotalamount;
  Result := True;
end;

Function TRepairParts.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then
    Exit;
  ConvertToInvoice := False;
  if Assigned(self.Owner) then
    if self.Owner is TRepairs then begin
      TRepairs(self.Owner).PostDB;
      RepairID := TRepairs(self.Owner).ID;
      RepairPartsClassId := TRepairs(self.Owner).ClassId;
    end;
  PartIssuedOn := now;
  UnitOfMeasure := AppEnv.DefaultClass.DefaultUOM;
  Quantity := 0;
  ParentProductID := 0;
  ParentLineRef := '';
  RelatedProductQty := 0;
  IsRelatedProduct := false;
  { 10/12/2013 Dene requsted removal of following }
//  if PrevCustomerEquipmentID > 0 then
//    CustomerEquipmentID := PrevCustomerEquipmentID;
End;

Function TRepairParts.GetProduct: TProduct;
begin
  if not Assigned(fProduct) then begin
    fProduct := TProduct.Create(self);
  end;
  if (not(fProduct.datasetAssigned)) or (fProduct.ProductId <> ProductId) then begin
    fProduct.loadSelect('PartsID = ' + IntToStr(ProductId));
  end;
  Result := fProduct;
end;

Procedure TRepairParts.SetProduct(Const Value: TProduct);
begin
  fProduct := Value;
end;

procedure TRepairParts.CalcLineTotals;
begin
  PriceEx := GetAmountEx(PriceInc, TaxRate);
  LineTotalEx       := PriceEx * Quantity + Markup - Discount;
  CalcPartsTotalamount;
end;

Procedure TRepairParts.CalcPartsTotalamount;
begin
  if EmptyRecord then
    Exit;
  if Assigned(self.Owner) then
    if self.Owner is TRepairs then
      TRepairs(self.Owner).CalcPartsTotalamount;
end;

procedure TRepairParts.CallDoFieldOnChange(Sender: TField);
begin
  DoFieldOnChange(Sender);
end;

Function TRepairParts.EmptyRecord: Boolean;
begin
  Result := (ProductId = 0);
end;

{ Property functions }
Function TRepairParts.GetRepairID: Integer;
begin
  Result := GetIntegerField('Repairid');
End;

(*function TRepairParts.GetSaleLineGlobalRef: string;
begin
  if SaleLineId > 0 then
    Result := TSalesLineBase.IDGlobalRefToggle(SaleLineId, Connection.Connection)
  else
    Result := '';
end;*)

Function TRepairParts.GetProductID: Integer;
begin
  Result := GetIntegerField('Partsid');
End;

// function  TRepairParts.getPOSLineId       :Integer   ; begin Result := GetIntegerField('PosLineId');End;
Function TRepairParts.GetProductName: String;
begin
  Result := GetStringField('Partname');
End;

Function TRepairParts.GetQuantity: Double;
begin
  Result := getFloatfield('Qty');
End;

Function TRepairParts.GetDescription: String;
begin
  Result := GetStringField('Description');
End;

Function TRepairParts.GetPriceex: Double;
begin
  Result := getFloatfield('Priceex');
End;

Function TRepairParts.GetPriceinc: Double;
begin
  Result := getFloatfield('Priceinc');
End;

Function TRepairParts.GetTaxcode: String;
begin
  Result := GetStringField('Taxcode');
End;
Function TRepairParts.GetPartBarcode: String;
begin
  Result := GetStringField('PartBarcode');
End;

Function TRepairParts.GetTaxrate: Double;
begin
  Result := getFloatfield('Taxrate');
End;

Function TRepairParts.GetDiscount: Double;
begin
  Result := getFloatfield('Discount');
End;

Function TRepairParts.GetMarkup: Double;
begin
  Result := getFloatfield('Markup');
End;

Function TRepairParts.GetDiscountpercent: Double;
begin
  Result := getFloatfield('Discountpercent');
End;

Function TRepairParts.GetMarkuppercent: Double;
begin
  Result := getFloatfield('Markuppercent');
End;

Function TRepairParts.GetLinetotalex: Double;
begin
  Result := getFloatfield('Linetotalex');
End;

Function TRepairParts.GetClassname: String;
begin
  Result := GetStringField('Classname');
End;

Function TRepairParts.GetClassID: Integer;
begin
  Result := GetIntegerField('Classid');
End;

// Function  TRepairParts.GetParttype        :String    ; begin Result := GetStringField('Parttype');End;
Function TRepairParts.GetConverttoinvoice: Boolean;
begin
  Result := GetBooleanField('Converttoinvoice');
End;

Function TRepairParts.GetEtadate: TDatetime;
begin
  Result := GetDatetimeField('Etadate');
End;

// Function  TRepairParts.GetPurchaseorderid :Integer   ; begin Result := GetIntegerField('Purchaseorderid');End;
Function TRepairParts.GetMemoline: String;
begin
  Result := GetStringField('Memoline');
End;

Function TRepairParts.getcalcTax: Double;
begin
  Result := getFloatfield('calcTax');
end;

(*Function TRepairParts.getcalcTotalEx: Double;
begin
  Result := getFloatfield('calcTotalEx');
end;*)

Function TRepairParts.getcalcTotalInc: Double;
begin
  Result := getFloatfield('calcTotalInc');
end;

Function TRepairParts.getcalcTotalIncBase: Double;
begin
  Result := getFloatfield('calcTotalIncBase');
end;

function TRepairParts.GetUnitOfMeasure: String;
begin
  Result := GetStringField('UnitofMeasure');
end;

function TRepairParts.GetUnitOfMeasureID: Integer;
begin
  Result := GetIntegerField('UnitofMeasureID');
end;

function TRepairParts.GetUOMMultiplier: Double;
begin
  Result := getFloatfield('UnitofMeasureMultiplier');
end;

function TRepairParts.GetUOMQty: Double;
begin
  Result := getFloatfield('UOMQty');
end;

function TRepairParts.GetUOMUnitProductKeyName: string;
begin
  if UnitOfmeasureID > 0 then
    Result := TUnitOfMeasure.IDToggle(UnitOfmeasureID, Connection.Connection)
  else
    Result := '';
end;


function TRepairParts.getRepairTerms: String;
begin
  Result := '';
  if Assigned(Self.Owner) then
    if owner is TRepairs then
      Result := TRepairs(Owner).Terms;

end;

function TRepairParts.getSaleLineId: Integer;
begin
  Result := GetIntegerField('SaleLineId');
end;

Procedure TRepairParts.SetRepairID(Const Value: Integer);
begin
  SetIntegerField('Repairid', Value);
End;

Procedure TRepairParts.SetProductID(Const Value: Integer);
begin
  SetIntegerField('Partsid', Value);
End;

// procedure TRepairParts.SetPOSLineId       (const Value: Integer   ); begin SetIntegerField('POSLineID'     , Value);End;
Procedure TRepairParts.SetProductName(Const Value: String);
begin
  SetStringField('Partname', Value);
End;

Procedure TRepairParts.SetQuantity(Const Value: Double);
begin
  SetFloatField('Qty', Value);
End;

Procedure TRepairParts.SetDescription(Const Value: String);
begin
  SetStringField('Description', Value);
End;

Procedure TRepairParts.SetPriceex(Const Value: Double);
begin
  SetFloatField('Priceex', Value);
End;

Procedure TRepairParts.SetPriceinc(Const Value: Double);
begin
  SetFloatField('Priceinc', Value);
End;

Procedure TRepairParts.SetTaxcode(Const Value: String);
begin
  SetStringField('Taxcode', Value);
End;
Procedure TRepairParts.SetPartBarcode(Const Value: String);
begin
  SetStringField('PartBarcode', Value);
End;

Procedure TRepairParts.SetTaxrate(Const Value: Double);
begin
  SetFloatField('Taxrate', Value);
End;

Procedure TRepairParts.SetDiscount(Const Value: Double);
begin
  SetFloatField('Discount', Value);
End;

Procedure TRepairParts.SetMarkup(Const Value: Double);
begin
  SetFloatField('Markup', Value);
End;

Procedure TRepairParts.SetDiscountpercent(Const Value: Double);
begin
  SetFloatField('Discountpercent', Value);
End;

Procedure TRepairParts.SetMarkuppercent(Const Value: Double);
begin
  SetFloatField('Markuppercent', Value);
End;

Procedure TRepairParts.SetLinetotalex(Const Value: Double);
begin
  SetFloatField('Linetotalex', Value);
End;

Procedure TRepairParts.SetClassname(Const Value: String);
begin
  SetStringField('Classname', Value);
End;

Procedure TRepairParts.setClassID(Const Value: Integer);
begin
  SetIntegerField('Classid', Value);
End;

// Procedure TRepairParts.SetParttype        (Const Value :String    ); begin SetStringField('Parttype'       , Value);End;
Procedure TRepairParts.SetEtadate(Const Value: TDatetime);
begin
  SetDatetimeField('Etadate', Value);
End;

Procedure TRepairParts.SetMemoline(Const Value: String);
begin
  SetStringField('Memoline', Value);
End;

Procedure TRepairParts.SetcalcTax(Const Value: Double);
begin
  SetFloatField('calcTax', Value);
End;

(*Procedure TRepairParts.SetcalcTotalEx(Const Value: Double);
begin
  SetFloatField('calcTotalEx', Value);
End;*)

Procedure TRepairParts.SetcalcTotalInc(Const Value: Double);
begin
  SetFloatField('calcTotalInc', Value);
End;

Procedure TRepairParts.SetcalcTotalIncBase(Const Value: Double);
begin
  SetFloatField('calcTotalIncBase', Value);
End;

procedure TRepairParts.SetUnitOfMeasure(const Value: String);
begin
  SetStringField('UnitofMeasure', Value);
end;

procedure TRepairParts.SetUOMQty(const Value: Double);
begin
  SetFloatField('UOMQty', Value);
end;

procedure TRepairParts.SetUOMUnitProductKeyName(const Value: string);
var
  UomObj: TUnitOfMeasure;
begin
  if Value <> '' then begin
    UomObj := TUnitOfMeasure.Create(nil);
    try
      UomObj.Connection := self.Connection;
      UomObj.loadSelect('UnitProductKeyName = ' + Quotedstr(Value));
      if UomObj.count > 0 then begin
        UnitOfmeasureID := UomObj.ID;
        UnitOfMeasure := UomObj.UOMName;
        UOMMultiplier := UomObj.Multiplier;
      end
      else begin
        UnitOfmeasureID := 0;
        UnitOfMeasure := '';
        UOMMultiplier := 1;
      end;
    finally
      UomObj.Free;
    end;
  end
  else begin
    UnitOfmeasureID := 0;
    UnitOfMeasure := '';
    UOMMultiplier := 1;
  end;
end;


(*procedure TRepairParts.SetSaleLineGlobalRef(const Value: string);
begin
  fSaleLineGlobalRef := Value;
  if Value <> '' then begin
    SaleLineId := TSalesLineBase.IDGlobalRefToggle(Value, Connection.Connection);
    if SaleLineId = 0 then
      SaleLineId := -1;
  end
  else
    SaleLineId := 0;
end;*)

procedure TRepairParts.SetSaleLineId(const Value: Integer);
begin
  SetIntegerField('SaleLineId', Value);
end;

procedure TRepairParts.SetUnitOfMeasureID(const Value: Integer);
begin
  SetIntegerField('UnitofMeasureID', Value);
end;

procedure TRepairParts.SetUOMMultiplier(const Value: Double);
begin
  SetFloatField('UnitofMeasureMultiplier', Value);
end;

// Procedure TRepairParts.SetPurchaseorderid (Const Value :Integer   ); begin SetIntegerField('Purchaseorderid'      , Value);End;
Procedure TRepairParts.SetConverttoinvoice(Const Value: Boolean);
begin
  SetBooleanField('convertToinvoice', Value);
End;

procedure TRepairParts.SetMatrixDesc(const Value: String);
begin
  SetStringField('MatrixDesc', Value);
end;

procedure TRepairParts.SetMatrixPrice(const Value: Double);
begin
  SetFloatField('MatrixPrice', Value);
end;

procedure TRepairParts.SetMatrixRef(const Value: String);
begin
  SetStringField('MatrixRef', Value);
end;

function TRepairParts.GetMatrixDesc: String;
begin
  Result := GetStringField('MatrixDesc');
end;

function TRepairParts.GetMatrixPrice: Double;
begin
  Result := getFloatfield('MatrixPrice');
end;

function TRepairParts.GetMatrixRef: String;
begin
  Result := GetStringField('MatrixRef');
end;

function TRepairs.getTimesheetEntryCreated: Boolean;
begin
  Result := TimesheetEntry.count > 0;
end;

function TRepairs.getTotalBill: Double;
begin
  With GetNewDataset
    ('select Sum(PL.`TotalLineAmountInc` ) as TotalLineAmountInc from `tblpurchaselines` PL inner join  tblpurchaseorders PO on PO.PurchaseOrderID = PL.PurchaseOrderID and PO.IsBill ="T" where PL.repairID=  '
    + IntToStr(ID), True) do
    try
      Result := fieldbyname('TotalLineAmountInc').asFloat;
    finally
      if Active then
        Close;
      Free;
    end;
end;

function TRepairs.getTotalBillEx: double;
begin
  With GetNewDataset
    ('select Sum(PL.TotalLineAmount ) as TotalLineAmount from tblpurchaselines PL inner join  tblpurchaseorders PO on PO.PurchaseOrderID = PL.PurchaseOrderID and PO.IsBill ="T" where PL.repairID=  '
    + IntToStr(ID), True) do
    try
      Result := fieldbyname('TotalLineAmount').asFloat;
    finally
      if Active then
        Close;
      Free;
    end;
end;


procedure TRepairs.CalcPartsTotal;
begin
  fdtotalEx := 0;
  fdtotalinc := 0;
  fdPriceEx := 0;
  fdPriceInc := 0;
  fdTotalCost := 0;
  fdLineCosttotal := 0;
  fdLinecosttotalinc := 0;
  fdTotalCostinc := 0;
  RepairParts.IterateRecords(CalcPartsTotalamountCallback);
end;

function TRepairParts.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterOpen(Sender);
  if not Result then
    Exit;
  CalcPartsTotalamount;
end;

procedure TRepairs.getDepartments(const Sender: TBusObj; var Abort: Boolean);
begin
  if (not(Sender is TRepairParts)) and (not(Sender is TTimesheet)) then
    Exit;
  if Sender is TRepairParts then begin
    if TRepairParts(Sender).RepairPartsClassId = 0 then
    else
      Departments.Add(IntToStr(TRepairParts(Sender).RepairPartsClassId));
  end
  else if Sender is TTimesheet then begin
    if TTimesheet(Sender).TimeSheetClassID = 0 then
    else
      Departments.Add(IntToStr(TTimesheet(Sender).TimeSheetClassID));
  end;
end;

function TRepairs.GetDeptClassName: string;
begin
  if ClassId > 0 then
    Result := TDeptClass.IDToggle(ClassId, Connection.Connection)
  else
    ClassId := 0;
end;

procedure TRepairs.AddServiceChargeofDept(const SalesLine: TBusObj);
  function EmployeeHours: String;
  var
    i: Integer;
  begin
    Result := '';
    for i := 0 to lsttotalHours.count - 1 do begin
      if Result <> '' then
        Result := Result + ',';
      Result := Result + lstEmployees[i] + ':' + lsttotalHours[i] + ' hrs';
    end;
  end;


begin
  if not(SalesLine is TSalesLine) then
    Exit;
  fdtotalServiceCharge := 0;
  TimesheetNotes:='';
  lsttotalHours := TStringList.Create;
  lstEmployees := TStringList.Create;
  try
    if AppEnv.CompanyPrefs.CombineRepairTimeSheetLinesOnInvoice then begin

      TimesheetEntry.Timesheet.IterateRecords(CaltotalServiceCharge);
      if fdtotalServiceCharge <> 0 then
        with TSalesLine(SalesLine) do begin
          New;
          ProductName := PART_SERVICE_LABOUR;
          Product_Description := EmployeeHours;
          Product_Description_Memo := TimesheetNotes;
          UOMQtySold := 1;
          UOMQtyShipped := 1;
          { by default get the taxcode of PART_SERVICE_LABOUR }

          LinePriceInc := fdtotalServiceCharge;
          PostDB;
        end;
    end
    else begin
      TimesheetEntry.Timesheet.First;
      while not TimesheetEntry.Timesheet.Eof do begin
        if TimesheetEntry.Timesheet.TimeSheetClassID = curDeptId then begin
          if TimesheetEntry.Timesheet.TotalServicecharge <> 0 then begin
            SalesLine.New;
            TSalesLine(SalesLine).ProductName := PART_SERVICE_LABOUR;
            if TimesheetEntry.Timesheet.InvoiceNotes <> '' then TSalesLine(SalesLine).Product_Description := TimesheetEntry.Timesheet.ServiceName + ':' +TimesheetEntry.Timesheet.InvoiceNotes
            else TSalesLine(SalesLine).Product_Description := TimesheetEntry.Timesheet.ServiceName;
            TSalesLine(SalesLine).UOMQtySold := TimesheetEntry.Timesheet.Quantity; // 1;
            TSalesLine(SalesLine).UOMQtyShipped := TimesheetEntry.Timesheet.Quantity; // 1;
            TSalesLine(SalesLine).LinePriceInc := TimesheetEntry.Timesheet.ChargeRate;
            // TotalServicecharge;
            SalesLine.PostDB;
          end;
        end;
        TimesheetEntry.Timesheet.Next;
      end;
    end;
  finally
    FreeAndNil(lsttotalHours);
    FreeAndNil(lstEmployees);
  end;
end;

procedure TRepairs.CaltotalServiceCharge(const Sender: TBusObj; var Abort: Boolean);
var
  i: Integer;
begin
  if not(Sender is TTimesheet) then
    Exit;
  if TTimesheet(Sender).TimeSheetClassID = curDeptId then begin
    fdtotalServiceCharge := fdtotalServiceCharge + TTimesheet(Sender).TotalServicecharge;
    TimesheetNotes := trim(TimesheetNotes +
                          iif( trim(TTimesheet(Sender).invoiceNotes)<> '' ,  chr(13)+Chr(10) + chr(13)+Chr(10) + 'Invoice Notes : '   + TTimesheet(Sender).invoiceNotes , '') +
                          iif( trim(TTimesheet(Sender).Notes)       <> '' ,  chr(13)+Chr(10) + chr(13)+Chr(10) + 'Technical Notes : ' + TTimesheet(Sender).Notes        , ''));
    if not lstEmployees.Find(TTimesheet(Sender).EmployeeName, i) then begin
      lstEmployees.Add(TTimesheet(Sender).EmployeeName);
      lsttotalHours.Add(floattoStr(TTimesheet(Sender).hours));
    end
    else
      lsttotalHours[i] := (floattoStr(strTofloat(lsttotalHours[i]) + TTimesheet(Sender).hours));
  end;
end;

procedure TRepairs.AfterCloneBusObj;
begin
  inherited;
  if Assigned(ObjInstanceToClone) and (ObjInstanceToClone is TRepairs) then
    if TRepairs(ObjInstanceToClone).repairdocno = self.repairdocno  then
      TRepairs(ObjInstanceToClone).repairdocno  := inttostr(ObjInstanceToClone.Id);
end;

procedure TRepairs.BusObjCopy(const Sender: TBusObj; var Abort: Boolean);
begin
  inherited;

  if Sender is TRepairs then begin
    if TRepairs(Sender).UseBillCust and Assigned(Sender.ObjInstanceToClone) and
      IsClassByString(Sender.ObjInstanceToClone, 'TSales') then begin
      TInvoice(Sender.ObjInstanceToClone).ClientID := TRepairs(Sender).BillClientID;
      TInvoice(Sender.ObjInstanceToClone).ShipToDesc := TRepairs(Sender).client.ShipToAddress;
    end;
  end;
  if Sender is TRepairParts then begin
    if fsconvertedIds <> '' then fsconvertedIds := fsconvertedIds +',' ;fsconvertedIds := fsconvertedIds + inttostr (TRepairParts(Sender).ID);
    if ObjInstanceToClone is TInvoice then
      TRepairParts(Sender).InvoiceLineRef := TInvoice(ObjInstanceToClone).Lines.globalref
    else if ObjInstanceToClone is TSalesOrder then
      TRepairParts(Sender).InvoiceLineRef  := TSalesOrder(ObjInstanceToClone).Lines.globalref;
    //TRepairParts(Sender).ConvertToInvoice := true;
    TRepairParts(Sender).Copyallocation;
    TRepairParts(Sender).PostDB;
  end;
end;
function TRepairParts.GetCustomerEquipmentID: Integer;
begin
  Result := GetIntegerField('CustomerEquipmentId');
end;

function TRepairParts.GetEquipment: TEquipment;
begin
  Result := TEquipment(GetcontainerComponent(TEquipment,
    'EquipmentName = ' + Quotedstr(EquipmentName)));
end;

function TRepairParts.getEquipmentname: String;
begin
  Result := GetStringField('Equipment');
end;

procedure TRepairParts.SetCustomerEquipmentID(const Value: Integer);
begin
  SetIntegerField('customerEquipmentID', Value);
end;

procedure TRepairParts.SetEquipmentName(const Value: String);
begin
  SetStringField('Equipment', Value);
end;

function TRepairParts.GetHeaderID: Integer;
begin
  Result := 0;
  if Assigned(self.Owner) then
    if self.Owner is TRepairs then
      Result := TRepairs(self.Owner).ID;
end;

function TRepairParts.GetAllocType: String;
begin
  Result := 'OUT';
end;

function TRepairParts.GetActive: Boolean;
begin
  Result := not(Deleted);
end;

procedure TRepairParts.SetActive(const Value: Boolean);
begin
  Deleted := not(Value);
end;

procedure TRepairParts.setAddingRelatedParts(const Value: Boolean);
begin
  if Assigned(Owner) then
    if owner is TRepairs then
      TRepairs(Owner).fbAddingRelatedParts := Value;
end;

function TRepairParts.GetDeleted: Boolean;
begin
  Result := GetBooleanField('Deleted');
end;

procedure TRepairParts.SetDeleted(const Value: Boolean);
begin
  SetBooleanField('Deleted', Value);
end;

function TRepairParts.GetTransDate: TDatetime;
begin
  Result := PartIssuedOn;
  if Assigned(self.Owner) then
    if self.Owner is TRepairs then
      Result := TRepairs(self.Owner).CreationDate;
end;

function TRepairParts.getPartIssuedOn: TDatetime;
begin
  Result := GetDatetimeField('PartIssuedOn');
end;

procedure TRepairParts.setPartIssuedOn(const Value: TDatetime);
begin
  SetDatetimeField('PartIssuedOn', Value);
end;

function TRepairParts.GetQty: Double;
begin
  Result := Quantity;
end;

function TRepairParts.GetBOQty: Double;
begin
  Result := 0;
end;
function TRepairParts.GetBOUOMQty: Double;
begin
  Result := 0;
end;

function TRepairParts.GetSerialnos: String;
begin
  Result := GetStringField('Serialnos');
end;

procedure TRepairParts.SetSerialNos(const Value: String);
begin
  SetStringField('Serialnos', Value);
end;

function TRepairParts.GetCleanClassID: Integer;
begin
  Result := GetXMLNodeIntegerValue(CleanXMLNOde, 'RepairPartsClassId');
end;

function TRepairParts.GetcleanProductId: Integer;
begin
  Result := GetXMLNodeIntegerValue(CleanXMLNOde, 'ProductID');
end;

function TRepairParts.GetOrderQty: Double;
begin
  Result := Quantity;
end;

function TRepairParts.GetUOMOrderQty: Double;
begin
  Result := UOMQty;
end;

procedure TRepairParts.SetBOQty(const Value: Double);
begin
  inherited;
  // repair will not have a bo
end;
procedure TRepairParts.SetBOUOMQty(const Value: Double);
begin
  inherited;
  // repair will not have a bo
end;

procedure TRepairParts.SetQty(const Value: Double);
begin
  inherited;
  Quantity := Value;
end;

procedure TRepairParts.SetTransDate(const Value: TDatetime);
begin
  inherited;
  PartIssuedOn := Value;
end;

procedure TRepairParts.SetOrderQty(const Value: Double);
begin
  inherited;
  // repairs doesn't have a order qty
end;

procedure TRepairParts.SetUOMOrderQty(const Value: Double);
begin
  inherited;
  // repairs doesn't have a order qty
end;

procedure TRepairParts.ClonePropertyObjects;
begin
  inherited;

end;

function TRepairParts.getlineCost: Double;
begin
  Result := getFloatfield('Linecost');
end;
function TRepairParts.getLinecostInc: Double;
begin
  Result := getFloatfield('LinecostInc');
end;

procedure TRepairParts.SetLinecost(const Value: Double);
begin
  SetFloatField('Linecost', Value);
end;
procedure TRepairParts.SetLinecostInc(const Value: Double);
begin
  SetFloatField('LinecostInc', Value);
end;

function TRepairs.getQuotedAmount: Double;
begin
  Result := getFloatfield('QuotedAmount');
end;

procedure TRepairs.setQuotedAmount(const Value: Double);
begin
  SetFloatField('QuotedAmount', Value);
end;

function TRepairs.getQuotedAmountinc: Double;
begin
  Result := getFloatfield('QuotedAmountinc');
end;

function TRepairs.getHoldRepair: Boolean;
begin
  Result := GetBooleanField('HoldRepair');
end;

function TRepairs.getCancelled: Boolean;
begin
  Result := GetBooleanField('Cancelled');
end;

function TRepairs.getDetailsExported: Boolean;
begin
  Result := GetBooleanField('DetailsExported');
end;

procedure TRepairs.setHoldRepair(const Value: Boolean);
begin
  SetBooleanField('HoldRepair', Value);
end;

procedure TRepairs.setBilltotalPrice(const Value: Double);
begin
  SetFloatField('BilltotalPrice', Value);
end;

procedure TRepairs.setCancelled(const Value: Boolean);
begin
  SetBooleanField('Cancelled', Value);
end;

procedure TRepairs.setDetailsExported(const Value: Boolean);
begin
  SetBooleanField('DetailsExported', Value);
end;

procedure TRepairs.setQuotedAmountinc(const Value: Double);
begin
  SetFloatField('QuotedAmountinc', Value);
end;

procedure TRepairs.RemoveSaleRef(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TRepairParts) then
    Exit;
  TRepairParts(Sender).InvoiceLineRef := '';
  TRepairParts(Sender).PostDB;

end;

procedure TRepairs.DeleteFlaggedLines;
var
  IsFiltered: Boolean;
begin
  RepairParts.Dataset.DisableControls;
  IsFiltered := RepairParts.Dataset.Filtered;
  RepairParts.Dataset.Filtered := false;
  if RepairParts.count > 0 then begin
    RepairParts.First;
    while not RepairParts.Dataset.Eof do begin
      if RepairParts.Deleted then begin
        if (RepairParts.IsPQAItem) or (RepairParts.HasPQACreated) then begin
          RepairParts.PQA.Delete;
        end;
        RepairParts.Delete;
      end
      else
        RepairParts.Dataset.Next;
    end;
    RepairParts.Dataset.Filtered := IsFiltered;
  end;
  RepairParts.Dataset.EnableControls;

  RepairEquipmentFault.Dataset.DisableControls;
  IsFiltered := RepairEquipmentFault.Dataset.Filtered;
  RepairEquipmentFault.Dataset.Filtered := false;
  if RepairEquipmentFault.count > 0 then begin
    RepairEquipmentFault.First;
    while not RepairEquipmentFault.Dataset.Eof do begin
      if RepairEquipmentFault.Deleted then begin
        RepairEquipmentFault.Delete;
      end
      else
        RepairEquipmentFault.Dataset.Next;
    end;
    RepairEquipmentFault.Dataset.Filtered := IsFiltered;
  end;
  RepairEquipmentFault.Dataset.EnableControls;
end;

procedure TRepairParts.AddRelatedParts;
var
  RelatedProducts: TRelatedProduct;
  fParentProductId: Integer;
  fsRelatedParentRef: String;
  SaveDofieldChange: Boolean;
  bm: TBookmark;
begin
  if Product.HasRelatedProducts then begin
    RelatedProducts := TRelatedProduct.Create(nil);
    self.PostDB;
    bm := self.Dataset.GetBookmark;
    try
      fParentProductId := self.ProductId;
      fsRelatedParentRef := self.globalref;
      RelatedProducts.loadSelect('ParentID = ' + IntToStr(Product.ID));
      SaveDofieldChange := DofieldChange;
      DofieldChange := True; AddingRelatedParts:= True;
      // as the new records are getting added set this to false to trigger the DoFieldOnChange
      Try
        while not RelatedProducts.Eof do begin
          { add the record only if the record already doesn't exists }
          if not(self.Dataset.Locate('Partsid;ParentProductID;ParentLineRef',
            varArrayof([RelatedProducts.ProductId, fParentProductId, fsRelatedParentRef]), [])) then
          begin
            self.Dataset.Append;
            self.IsRelatedProduct := True;
            self.ProductId := RelatedProducts.ProductId;
            self.ParentProductID := fParentProductId;
            self.RelatedProductQty := RelatedProducts.Quantity;
            self.ParentLineRef := fsRelatedParentRef;
            self.Quantity := 0;
            self.UOMQty := 0;
            self.PostDB;
          End;
          RelatedProducts.Next;
        end;
      finally
        DofieldChange := SaveDofieldChange;
      end;
    finally
      AddingRelatedParts := False;
      self.Dataset.GotoBookmark(bm);
      self.Dataset.FreeBookmark(bm);
      FreeAndNil(RelatedProducts);
    end;
  end
end;

function TRepairParts.getParentProductID: Integer;
begin
  Result := GetIntegerField('ParentProductID');
end;

function TRepairParts.GetParentProductName: string;
begin
  if ParentProductID > 0 then
    Result := TProduct.IDToggle(ParentProductID, Connection.Connection)
  else
    Result := '';
end;

procedure TRepairParts.setParentProductID(const Value: Integer);
begin
  SetIntegerField('ParentProductID', Value);
end;

procedure TRepairParts.SetParentProductName(const Value: string);
begin
  if Value <> '' then begin
    ParentProductID := TProduct.IDToggle(Value, Connection.Connection);
    if ParentProductID = 0 then
      ParentProductID := -1;
  end
  else
    ParentProductID := 0;
end;

function TRepairParts.getParentLineRef: String;
begin
  Result := GetStringField('ParentLineRef');
end;

procedure TRepairParts.setParentLineRef(const Value: String);
begin
  SetStringField('ParentLineRef', Value);
end;

function TRepairParts.getRelatedProductQty: Double;
begin
  Result := getFloatfield('RelatedProductQty');
end;

procedure TRepairParts.setRelatedProductQty(const Value: Double);
begin
  SetFloatField('RelatedProductQty', Value);
end;

procedure TRepairParts.updaterelatedPartsQty;
begin
  if (Product.HasRelatedProducts) then begin
    ParentQty := self.Quantity;
    fsRelatedParentLineRef := globalref;
    fiParentProductId := self.ProductId;
    IterateRecords(updateRelPrQtyCallback);
  end;

end;

procedure TRepairParts.updateRelPrQtyCallback(const Sender: TBusObj; var Abort: Boolean);
var
  SaveDofieldChange: Boolean;
begin

  if (not(IsRelatedProduct)) then
    Exit;
  if not(self is TRepairParts) then
    Exit;

  if TRepairParts(Sender).ParentLineRef <> fsRelatedParentLineRef then
    Exit;
  if TRepairParts(Sender).ParentProductID <> fiParentProductId then
    Exit;

  SaveDofieldChange := DofieldChange;
  DoFieldChangewhenDisabled := True;
  Try
    DofieldChange := True;
    if self.Quantity <> ParentQty * self.RelatedProductQty then begin
      //self.Quantity := ParentQty * self.RelatedProductQty;
      self.Quantity := AutoRoundRelatedQty(ParentQty);
      PostDB;
    end;
  finally
    DofieldChange := SaveDofieldChange;
    DoFieldChangewhenDisabled := false;
  end;
end;

function TRepairParts.AutoRoundRelatedQty(const Qty:double):Double;
begin
  result := tcdatautils.AutoRoundRelatedQty(Qty  , ParentProductID , ProductID);
end;
function TRepairParts.getinvoiceLineRef: String;
begin
  Result := GetStringField('invoiceLineRef');
end;

procedure TRepairParts.setinvoiceLineRef(const Value: String);
begin
  SetStringField('invoiceLineRef', Value);
end;

function TRepairParts.getIsRelatedProduct: Boolean;
begin
  Result := GetBooleanField('IsRelatedProduct');
end;

procedure TRepairParts.setIsRelatedProduct(const Value: Boolean);
begin
  SetBooleanField('IsRelatedProduct', Value);
end;

procedure TRepairParts.ProcessDiscountmarkup(const DiscountMarkuptype: TDiscountMarkuptype);
begin
  if not RawMode then begin
    if DiscountMarkuptype = dmDiscount then begin
        Discountpercent := 0;
        Markup := 0;
        MarkupPercent := 0;
        
        if TotalIncBase > 0 then DiscountPercent := RoundTo((Discount / TotalIncBase * 100.0), -2);
        CalcLineTotals; //LineTotalEx := CalcTotalEx;
        CalcPartsTotalamount;
    end else if DiscountMarkuptype = dmDiscountPercent then begin
        Self.Discount := 0;
        Self.Markup := 0;
        Self.MarkupPercent := 0;
        if (DiscountPercent <> 0) and MaximumDiscountExceeded then begin
        end;
        if TotalIncBase > 0 then Discount := RoundTo((TotalIncBase * DiscountPercent / 100.0), -2);
        CalcLineTotals; //LineTotalEx := CalcTotalEx;
        CalcPartsTotalamount;
    end else if DiscountMarkuptype = dmMarkup then begin
        Self.Discount := 0;
        Self.DiscountPercent := 0;
        Self.MarkupPercent := 0;
        if TotalIncBase > 0 then MarkupPercent := Markup / TotalIncBase* 100.0;
        CalcLineTotals;//LineTotalEx := CalcTotalEx;
        CalcPartsTotalamount;
    end else if DiscountMarkuptype = dmMarkupPercent then begin
        Self.Discount := 0;
        Self.DiscountPercent := 0;
        Self.Markup := 0;
        if TotalIncBase > 0 then Markup := TotalIncBase * MarkupPercent / 100.0;
        CalcLineTotals;//LineTotalEx := CalcTotalEx;
        CalcPartsTotalamount;
    end;
  end;
end;

function TRepairParts.ProductChanged: Boolean;
var
  fiProductID: Integer;
  fsProductName: String;
  fsXML: STring;
begin
  Result := false;
  if (CleanProductId <> ProductId) and (CleanProductId <> 0) then begin
    fiProductID := ProductId;
    fsProductName := CleanProductName;
    fsXML := XMLDoc.XML.Text;
    ProductId := CleanProductId;
    ProductName := fsProductName;
    Dataset.Filtered := false;
    Deleted := True;
    PostDB;
    Product.Load(ProductId);
    Dataset.Filtered := True;
    Dataset.Insert;
    // not NEW, Insert to have the record in the same position, New does an append, will add at the end
    Dataset.DisableControls;
    try
      XML := fsXML;
    finally
      Dataset.EnableControls;
    end;
    ProductId := fiProductID;
    PostDB;
    DoFieldOnChange(Dataset.Findfield('PartsID'));
    Result := True;
  end;
end;

function TRepairParts.getCleanProductName: String;
begin
  Result := GetXMLNodeStringValue(CleanXMLNOde, 'ProductName');
end;

procedure TRepairs.DeleteAllEquipment;
begin
  RepairEquipment.DeleteAll;
  RepairParts.IterateRecords(RemoveEquipmentlink);
  TimesheetEntry.Timesheet.IterateRecords(RemoveEquipmentlink);
end;

procedure TRepairs.RemoveEquipmentlink(const Sender: TBusObj; var Abort: Boolean);
begin
  if Sender is TRepairParts then begin
    if TRepairParts(Sender).EquipmentName <> '' then begin
      TRepairParts(Sender).EquipmentName := '';
      TRepairParts(Sender).CustomerEquipmentID := 0;
      TRepairParts(Sender).PostDB;
    end;
  end
  else if Sender is TTimesheet then begin
    if TTimesheet(Sender).EquipmentName <> '' then begin
      TTimesheet(Sender).EquipmentName := '';
      TTimesheet(Sender).CustomerEquipmentID := 0;
      TTimesheet(Sender).PostDB;
    end;
  end;
end;

function TRepairParts.getIsconverting: Boolean;
begin
  Result := false;
  if Assigned(self.Owner) then
    if self.Owner is TRepairs then
      Result := TRepairs(self.Owner).IsConverting;
end;

function TRepairs.GetCUSTFLD1: string;
begin
  Result := GetStringField('CUSTFLD1');
end;

function TRepairs.GetCUSTFLD2: string;
begin
  Result := GetStringField('CUSTFLD2');
end;

function TRepairs.GetCUSTFLD3: string;
begin
  Result := GetStringField('CUSTFLD3');
end;

function TRepairs.GetCUSTFLD4: string;
begin
  Result := GetStringField('CUSTFLD4');
end;

function TRepairs.GetCUSTFLD5: string;
begin
  Result := GetStringField('CUSTFLD5');
end;

function TRepairs.GetCUSTFLD6: string;
begin
  Result := GetStringField('CUSTFLD6');
end;

function TRepairs.GetCUSTFLD7: string;
begin
  Result := GetStringField('CUSTFLD7');
end;

function TRepairs.GetCUSTFLD8: string;
begin
  Result := GetStringField('CUSTFLD8');
end;

function TRepairs.GetCUSTFLD9: string;
begin
  Result := GetStringField('CUSTFLD9');
end;

function TRepairs.GetCUSTFLD10: string;
begin
  Result := GetStringField('CUSTFLD10');
end;

function TRepairs.GetCUSTFLD11: string;
begin
  Result := GetStringField('CUSTFLD11');
end;

function TRepairs.GetCUSTFLD12: string;
begin
  Result := GetStringField('CUSTFLD12');
end;

function TRepairs.GetCUSTFLD13: string;
begin
  Result := GetStringField('CUSTFLD13');
end;

function TRepairs.GetCUSTFLD14: string;
begin
  Result := GetStringField('CUSTFLD14');
end;

function TRepairs.GetCUSTFLD15: string;
begin
  Result := GetStringField('CUSTFLD15');
end;

procedure TRepairs.SetCUSTFLD1(const Value: string);
begin
  SetStringField('CUSTFLD1', Value);
end;

procedure TRepairs.SetCUSTFLD2(const Value: string);
begin
  SetStringField('CUSTFLD2', Value);
end;

procedure TRepairs.SetCUSTFLD3(const Value: string);
begin
  SetStringField('CUSTFLD3', Value);
end;

procedure TRepairs.SetCUSTFLD4(const Value: string);
begin
  SetStringField('CUSTFLD4', Value);
end;

procedure TRepairs.SetCUSTFLD5(const Value: string);
begin
  SetStringField('CUSTFLD5', Value);
end;

procedure TRepairs.SetCUSTFLD6(const Value: string);
begin
  SetStringField('CUSTFLD6', Value);
end;

procedure TRepairs.SetCUSTFLD7(const Value: string);
begin
  SetStringField('CUSTFLD7', Value);
end;

procedure TRepairs.SetCUSTFLD8(const Value: string);
begin
  SetStringField('CUSTFLD8', Value);
end;

procedure TRepairs.SetCUSTFLD9(const Value: string);
begin
  SetStringField('CUSTFLD9', Value);
end;

procedure TRepairs.SetCUSTFLD10(const Value: string);
begin
  SetStringField('CUSTFLD10', Value);
end;

procedure TRepairs.SetCUSTFLD11(const Value: string);
begin
  SetStringField('CUSTFLD11', Value);
end;

procedure TRepairs.SetCUSTFLD12(const Value: string);
begin
  SetStringField('CUSTFLD12', Value);
end;

procedure TRepairs.SetCUSTFLD13(const Value: string);
begin
  SetStringField('CUSTFLD13', Value);
end;

procedure TRepairs.SetCUSTFLD14(const Value: string);
begin
  SetStringField('CUSTFLD14', Value);
end;

procedure TRepairs.SetCUSTFLD15(const Value: string);
begin
  SetStringField('CUSTFLD15', Value);
end;

function TRepairs.GetCUSTDATE1: TDatetime;
begin
  Result := GetDatetimeField('CUSTDATE1');
end;

function TRepairs.GetCUSTDATE2: TDatetime;
begin
  Result := GetDatetimeField('CUSTDATE2');
end;

function TRepairs.GetCUSTDATE3: TDatetime;
begin
  Result := GetDatetimeField('CUSTDATE3');
end;

procedure TRepairs.SetCUSTDATE1(const Value: TDatetime);
begin
  SetDatetimeField('CUSTDATE1', Value);
end;

procedure TRepairs.SetCUSTDATE2(const Value: TDatetime);
begin
  SetDatetimeField('CUSTDATE2', Value);
end;

procedure TRepairs.SetCUSTDATE3(const Value: TDatetime);
begin
  SetDatetimeField('CUSTDATE3', Value);
end;

function TRepairParts.getInvoiceToclientID: Integer;
begin
  Result := 0;
  if not(Assigned(self.Owner)) then
    Exit;
  if not(self.Owner is TRepairs) then
    Exit;

  Result := TRepairs(self.Owner).BillClientID;
  if Result = 0 then
    Result := TRepairs(self.Owner).ClientID;
end;

function TRepairParts.GetClientDiscountObj: TClientDiscountObj;
begin
  if not Assigned(fClientDiscountObj) then begin
    fClientDiscountObj := TClientDiscountObj.Create;
  end;
  Result := fClientDiscountObj;
end;

procedure TRepairs.GeClientPrice(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TRepairParts) then
    Exit;
  TRepairParts(Sender).GetBaseLinePrice;
end;

procedure TRepairParts.GetBaseLinePrice;
var
  RetPriceEx: Double;
  RetDiscountPercent: Double;
  RetDesc: String;
  RetMsg: String;
begin
  if ParthasPriceMatrix(Product.ID) and (MatrixPrice <> 0) then
    PriceEx := MatrixPrice
  else
    PriceEx := Product.GetPriceForQty(Quantity);

  if InvoiceToclientID > 0 then begin
    { Calculate price after discounts }
    RetMsg := '';
    if ClientDiscountObj.ClientPrice_Discounts(InvoiceToclientID,RepairTerms, ProductId, UnitOfmeasureID,
      RepairPartsClassId, Quantity, PartIssuedOn, false, RetPriceEx, RetDiscountPercent, RetDesc,
      RetMsg, True, MatrixRef) then begin
      self.DiscountPercent := RetDiscountPercent * 100;
      DoFieldOnChange(Dataset.Findfield('DiscountPercent'));
      self.PriceEx := RetPriceEx;
      if RetDesc <> '' then
        self.Description := RetDesc;
      if RetMsg <> '' then begin
        if fLastDiscountRetMsg <> RetMsg then begin
          fLastDiscountRetMsg := RetMsg;
          AddResult(True, rssinfo, 0, RetMsg);
        end;
      end;
    end else begin
      if RetMsg <> '' then
        AddResult(false, rssWarning, 0, RetMsg);
    end;
  end;
  PriceInc := GetAmountInc(PriceEx, TaxRate);
  fiInvoiceToclientID := InvoiceToclientID;
  fiProductID := ProductId;
  fiLineID := ID;
end;

function TRepairs.GetAppointments: TBusObj;
begin
  Result := TBusObj(GetcontainerComponent(TAppointment, 'repairId = ' + IntToStr(self.ID)));
end;

function TRepairs.getInvoices: TBusObj;
begin
  Result := TBusObj(GetcontainerComponent(TInvoice, 'IsInvoice = "T" and Repairglobalref = ' +
    Quotedstr(globalref)));
end;

function TRepairs.getInvoiceTotalInc: Double;
begin
  fdInvoiceTotalInc := 0;
  Invoices.IterateRecords(calcInvoiceTotalCallback);
  result := fdInvoiceTotalInc;
end;
function TRepairs.getInvoiceTotalEx: Double;
begin
  fdInvoiceTotalEx := 0;
  Invoices.IterateRecords(calcInvoiceTotalCallback);
  result := fdInvoiceTotalEx;
end;

procedure TRepairs.CalcInvoiceTotalCallback(const Sender: TBusObj;var Abort: Boolean);
begin
  if (Sender is TInvoice) then begin
    fdInvoiceTotalInc := fdInvoiceTotalInc + TInvoice(Sender).TotalAmountInc;
    fdInvoiceTotalEx := fdInvoiceTotalEx + TInvoice(Sender).TotalAmount;
  end;
end;

function TRepairs.getSalesOrders: TBusObj;
begin
  Result := TBusObj(GetcontainerComponent(TSalesOrder, 'ISSalesOrder = "T" and Repairglobalref = ' +
    Quotedstr(globalref)));
end;

{ TRepairFaults }

constructor TRepairFaults.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'RepairFaults';
  fSQL := 'SELECT * FROM tblrepairfaults';
  ExportExcludeList.Add('manufactureid')
end;

destructor TRepairFaults.Destroy;
begin
  inherited;
end;

procedure TRepairFaults.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'code');
  SetPropertyFromNode(node, 'Category');
  SetPropertyFromNode(node, 'Description');
  SetBooleanPropertyFromNode(node, 'Active');
  SetPropertyFromNode(node, 'Manufacture');
  SetPropertyFromNode(node, 'ManufactureId');
end;

procedure TRepairFaults.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'code', code);
  AddXMLNode(node, 'Category', Category);
  AddXMLNode(node, 'Description', Description);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'Manufacture', Manufacture);
  AddXMLNode(node, 'ManufactureID', ManufactureID);
end;

function TRepairFaults.ValidateData: Boolean;
begin
  Result := false;
  Resultstatus.Clear;
  if code = '' then begin
    AddResult(false, rssWarning, 0, 'Code should not be Blank');
    Exit;
  end;
  if Description = '' then begin
    AddResult(false, rssWarning, 0, 'Description should not be Blank');
    Exit;
  end;
  if not IsUnique(ID, 'Category = ' + Quotedstr(Category) + ' and code = ' + Quotedstr(code) +
    ' and ManufactureID = ' + IntToStr(ManufactureID)) then begin
    AddResult(false, rssWarning, 0, 'Code: should be Unique');
    Exit;
  end;
  if not IsUnique(ID, 'Category = ' + Quotedstr(Category) + ' and Description = ' +
    Quotedstr(Description) + ' and ManufactureID = ' + IntToStr(ManufactureID)) then begin
    AddResult(false, rssWarning, 0, 'Description: should be Unique');
    Exit;
  end;
  Result := True;
end;

class function TRepairFaults._Schema: string;
begin
  Result := inherited;
  TBOSchema.AddRefType(Result, 'TManufacture', 'ManufactureObj', 'ManufactureID', 'ID');
  TBOSchema.AddRefType(Result, 'TManufacture', 'ManufactureObj', 'Manufacture', 'ManufactureName');
end;

function TRepairFaults.Save: Boolean;
begin
  Result := false;
  if not ValidateData then
    Exit;
  Result := inherited Save;
end;

procedure TRepairFaults.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TRepairFaults.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = false then
      Exit; // we are only interested in data fields.

  inherited;

  if SameText(Sender.FieldName, 'Manufacture') then begin
    if not RawMode then begin
      ManufactureID := TManufacture.IDToggle(Manufacture, Connection.Connection);
    end;
  end
  else if SameText(Sender.FieldName, 'ManufactureID') then begin
    if not RawMode then begin
      Manufacture := TManufacture.IDToggle(ManufactureID, Connection.Connection);
    end;
  end;
end;

function TRepairFaults.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TRepairFaults.GetIDField: string;
begin
  Result := 'RepairFaultID'
end;

class function TRepairFaults.GetBusObjectTablename: string;
begin
  Result := 'tblrepairfaults';
end;

function TRepairFaults.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TRepairFaults.Getcode: string;
begin
  Result := GetStringField('code');
end;

function TRepairFaults.GetCategory: string;
begin
  Result := GetStringField('Category');
end;

function TRepairFaults.GetDescription: string;
begin
  Result := GetStringField('Description');
end;

function TRepairFaults.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

procedure TRepairFaults.Setcode(const Value: string);
begin
  SetStringField('code', Value);
end;

procedure TRepairFaults.SetCategory(const Value: string);
begin
  SetStringField('Category', Value);
end;

procedure TRepairFaults.SetDescription(const Value: string);
begin
  SetStringField('Description', Value);
end;

procedure TRepairFaults.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

function TRepairFaults.getManufacture: String;
begin
  Result := GetStringField('Manufacture');
end;

function TRepairFaults.getManufactureId: Integer;
begin
  Result := GetIntegerField('ManufactureID');
end;

procedure TRepairFaults.setManufacture(const Value: String);
begin
  SetStringField('Manufacture', Value);
end;

procedure TRepairFaults.SetManufactureId(const Value: Integer);
begin
  SetIntegerField('ManufactureID', Value);
end;

function TRepairFaults.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then
    Exit;
  Active := True;
end;

{ TRepairDetails }

constructor TRepairDetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'RepairDetails';
  fSQL := 'SELECT * FROM tblrepairdetails';
  ExportExcludeList.Add('repairid');
  ExportExcludeList.Add('faultconditionid');
  ExportExcludeList.Add('faultsymptomid');
  ExportExcludeList.Add('faultdefectid');
  ExportExcludeList.Add('faultrepairid');
  ExportExcludeList.Add('faultsectionid');
  ExportExcludeList.Add('manufactureid');
  ExportExcludeList.Add('retailerid');
end;

destructor TRepairDetails.Destroy;
begin
  inherited;
end;

procedure TRepairDetails.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'RepairID');
  SetPropertyFromNode(node, 'GSFSReceiptNo');

  SetPropertyFromNode(node, 'FaultConditionID');
  SetPropertyFromNode(node, 'FaultSymptomID');
  SetPropertyFromNode(node, 'FaultDefectID');
  SetPropertyFromNode(node, 'FaultRepairID');
  SetPropertyFromNode(node, 'FaultSectionId');

  SetPropertyFromNode(node, 'FaultConditionDesc');
  SetPropertyFromNode(node, 'FaultSymptomDesc');
  SetPropertyFromNode(node, 'FaultDefectDesc');
  SetPropertyFromNode(node, 'FaultRepairDesc');
  SetPropertyFromNode(node, 'FaultSectionDesc');

  SetPropertyFromNode(node, 'FaultConditionCode');
  SetPropertyFromNode(node, 'FaultSymptomCode');
  SetPropertyFromNode(node, 'FaultDefectCode');
  SetPropertyFromNode(node, 'FaultRepairCode');
  SetPropertyFromNode(node, 'FaultSectionCode');

  SetPropertyFromNode(node, 'Repaircode');
  SetPropertyFromNode(node, 'Materialcost');
  SetPropertyFromNode(node, 'Freightcost');
  SetPropertyFromNode(node, 'Otheramount');
  SetPropertyFromNode(node, 'Servicetype');
  SetPropertyFromNode(node, 'Authorisationnumber');
  SetPropertyFromNode(node, 'ManInvDate');
  SetPropertyFromNode(node, 'Serialno');
  SetPropertyFromNode(node, 'Model');
  SetPropertyFromNode(node, 'ManInvNo');
  SetPropertyFromNode(node, 'Manufacture');
  SetPropertyFromNode(node, 'ManufactureId');
  SetPropertyFromNode(node, 'Retailer');
  SetPropertyFromNode(node, 'RetailerId');
end;

procedure TRepairDetails.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'RepairID', RepairID);
  AddXMLNode(node, 'GSFSReceiptNo', GSFSReceiptNo);

  AddXMLNode(node, 'FaultConditionID', FaultConditionID);
  AddXMLNode(node, 'FaultSymptomID', FaultSymptomID);
  AddXMLNode(node, 'FaultDefectID', FaultDefectID);
  AddXMLNode(node, 'FaultRepairID', FaultRepairID);
  AddXMLNode(node, 'FaultSectionId', FaultSectionId);

  AddXMLNode(node, 'FaultConditionDesc', FaultConditionDesc);
  AddXMLNode(node, 'FaultSymptomDesc', FaultSymptomDesc);
  AddXMLNode(node, 'FaultDefectDesc', FaultDefectDesc);
  AddXMLNode(node, 'FaultRepairDesc', FaultRepairDesc);
  AddXMLNode(node, 'FaultSectionDesc', FaultSectionDesc);

  AddXMLNode(node, 'FaultConditionCode', FaultConditionCode);
  AddXMLNode(node, 'FaultSymptomCode', FaultSymptomCode);
  AddXMLNode(node, 'FaultDefectCode', FaultDefectCode);
  AddXMLNode(node, 'FaultRepairCode', FaultRepairCode);
  AddXMLNode(node, 'FaultSectionCode', FaultSectionCode);

  AddXMLNode(node, 'Repaircode', Repaircode);
  AddXMLNode(node, 'Materialcost', Materialcost);
  AddXMLNode(node, 'Freightcost', Freightcost);
  AddXMLNode(node, 'Otheramount', Otheramount);
  AddXMLNode(node, 'Servicetype', Servicetype);
  AddXMLNode(node, 'Authorisationnumber', Authorisationnumber);
  AddXMLNode(node, 'ManInvNo', ManInvNo);
  AddXMLNode(node, 'ManInvDate', ManInvDate);
  AddXMLNode(node, 'Serialno', SerialNo);
  AddXMLNode(node, 'Model', Model);
  AddXMLNode(node, 'Manufacture', Manufacture);
  AddXMLNode(node, 'ManufactureID', ManufactureID);
  AddXMLNode(node, 'Retailer', Retailer);
  AddXMLNode(node, 'RetailerID', RetailerID);
end;

function TRepairDetails.ValidateData: Boolean;
begin
  Resultstatus.Clear;
  Result := True;
end;

class function TRepairDetails._Schema: string;
begin
  Result := inherited;
  TBOSchema.AddRefType(Result, 'TRepairFaults', 'RepairFaultsObj', 'FaultConditionID', 'ID');
  TBOSchema.AddRefType(Result, 'TRepairFaults', 'RepairFaultsObj', 'FaultSymptomID', 'ID');
  TBOSchema.AddRefType(Result, 'TRepairFaults', 'RepairFaultsObj', 'FaultDefectID', 'ID');
  TBOSchema.AddRefType(Result, 'TRepairFaults', 'RepairFaultsObj', 'FaultRepairID', 'ID');
  TBOSchema.AddRefType(Result, 'TRepairFaults', 'RepairFaultsObj', 'FaultSectionId', 'ID');
  TBOSchema.AddRefType(Result, 'TManufacture', 'ManufactureObj', 'ManufactureID', 'ID');
  TBOSchema.AddRefType(Result, 'TManufacture', 'ManufactureObj', 'Manufacture', 'ManufactureName');
  TBOSchema.AddRefType(Result, 'TCustomer', 'CustomerObj', 'RetailerID', 'ID');
  TBOSchema.AddRefType(Result, 'TCustomer', 'CustomerObj', 'Retailer', 'ClientName');
end;

function TRepairDetails.Save: Boolean;
begin
  Result := false;
  if not ValidateData then
    Exit;
  Result := inherited Save;
end;

procedure TRepairDetails.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TRepairDetails.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = false then
      Exit; // we are only interested in data fields.
  if (sysutils.SameText(Sender.fieldName, 'FaultConditionCode')) or
    (sysutils.SameText(Sender.fieldName, 'FaultSymptomCode')) or
    (sysutils.SameText(Sender.fieldName, 'FaultDefectCode')) or
    (sysutils.SameText(Sender.fieldName, 'FaultRepairCode')) or
    (sysutils.SameText(Sender.fieldName, 'FaultSectionCode')) then begin
    if not RawMode then
      UpdateRepaircode;
  end
  else if (sysutils.SameText(Sender.fieldName, 'ManufactureID')) then begin
    if not RawMode then begin
      sendEvent(BusObjEvent_Change, BusObjEventVal_Manufacture);
    end;
  end;

end;

function TRepairDetails.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TRepairDetails.GetIDField: string;
begin
  Result := 'RepairDetailId'
end;

class function TRepairDetails.GetBusObjectTablename: string;
begin
  Result := 'tblrepairdetails';
end;

function TRepairDetails.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }

function TRepairDetails.GetRepairID: Integer;
begin
  Result := GetIntegerField('RepairID');
end;

function TRepairDetails.GetGSFSReceiptNo: string;
begin
  Result := GetStringField('GSFSReceiptNo');
end;

function TRepairDetails.GetFaultConditionID: Integer;
begin
  Result := GetIntegerField('FaultConditionID');
end;

function TRepairDetails.GetFaultSymptomID: Integer;
begin
  Result := GetIntegerField('FaultSymptomID');
end;

function TRepairDetails.GetFaultDefectID: Integer;
begin
  Result := GetIntegerField('FaultDefectID');
end;

function TRepairDetails.GetFaultRepairID: Integer;
begin
  Result := GetIntegerField('FaultRepairID');
end;

function TRepairDetails.GetFaultSectionId: Integer;
begin
  Result := GetIntegerField('FaultSectionId');
end;

function TRepairDetails.GetFaultConditionDesc: string;
begin
  Result := GetStringField('FaultConditionDesc');
end;

function TRepairDetails.GetFaultSymptomDesc: string;
begin
  Result := GetStringField('FaultSymptomDesc');
end;

function TRepairDetails.GetFaultDefectDesc: string;
begin
  Result := GetStringField('FaultDefectDesc');
end;

function TRepairDetails.GetFaultRepairDesc: string;
begin
  Result := GetStringField('FaultRepairDesc');
end;

function TRepairDetails.GetFaultSectionDesc: string;
begin
  Result := GetStringField('FaultSectionDesc');
end;

function TRepairDetails.GetFaultConditionCode: string;
begin
  Result := GetStringField('FaultConditionCode');
end;

function TRepairDetails.GetFaultSymptomCode: string;
begin
  Result := GetStringField('FaultSymptomCode');
end;

function TRepairDetails.GetFaultDefectCode: string;
begin
  Result := GetStringField('FaultDefectCode');
end;

function TRepairDetails.GetFaultRepairCode: string;
begin
  Result := GetStringField('FaultRepairCode');
end;

function TRepairDetails.GetFaultSectionCode: string;
begin
  Result := GetStringField('FaultSectionCode');
end;

function TRepairDetails.GetRepaircode: string;
begin
  Result := GetStringField('Repaircode');
end;

function TRepairDetails.GetMaterialcost: Double;
begin
  Result := getFloatfield('Materialcost');
end;

function TRepairDetails.GetFreightcost: Double;
begin
  Result := getFloatfield('Freightcost');
end;

function TRepairDetails.GetOtheramount: Double;
begin
  Result := getFloatfield('Otheramount');
end;

function TRepairDetails.GetServicetype: string;
begin
  Result := GetStringField('Servicetype');
end;

function TRepairDetails.GetAuthorisationnumber: string;
begin
  Result := GetStringField('Authorisationnumber');
end;

procedure TRepairDetails.SetRepairID(const Value: Integer);
begin
  SetIntegerField('RepairID', Value);
end;

procedure TRepairDetails.SetGSFSReceiptNo(const Value: string);
begin
  SetStringField('GSFSReceiptNo', Value);
end;

procedure TRepairDetails.SetFaultConditionID(const Value: Integer);
begin
  SetIntegerField('FaultConditionID', Value);
end;

procedure TRepairDetails.SetFaultSymptomID(const Value: Integer);
begin
  SetIntegerField('FaultSymptomID', Value);
end;

procedure TRepairDetails.SetFaultDefectID(const Value: Integer);
begin
  SetIntegerField('FaultDefectID', Value);
end;

procedure TRepairDetails.SetFaultRepairID(const Value: Integer);
begin
  SetIntegerField('FaultRepairID', Value);
end;

procedure TRepairDetails.SetFaultSectionId(const Value: Integer);
begin
  SetIntegerField('FaultSectionId', Value);
end;

procedure TRepairDetails.SetFaultConditionDesc(const Value: string);
begin
  SetStringField('FaultConditionDEsc', Value);
end;

procedure TRepairDetails.SetFaultSymptomDesc(const Value: string);
begin
  SetStringField('FaultSymptomDesc', Value);
end;

procedure TRepairDetails.SetFaultDefectDesc(const Value: string);
begin
  SetStringField('FaultDefectDesc', Value);
end;

procedure TRepairDetails.SetFaultRepairDesc(const Value: string);
begin
  SetStringField('FaultRepairDesc', Value);
end;

procedure TRepairDetails.SetFaultSectionDesc(const Value: string);
begin
  SetStringField('FaultSectionDesc', Value);
end;

procedure TRepairDetails.SetFaultConditionCode(const Value: string);
begin
  SetStringField('FaultConditionCode', Value);
end;

procedure TRepairDetails.SetFaultSymptomCode(const Value: string);
begin
  SetStringField('FaultSymptomCode', Value);
end;

procedure TRepairDetails.SetFaultDefectCode(const Value: string);
begin
  SetStringField('FaultDefectCode', Value);
end;

procedure TRepairDetails.SetFaultRepairCode(const Value: string);
begin
  SetStringField('FaultRepairCode', Value);
end;

procedure TRepairDetails.SetFaultSectionCode(const Value: string);
begin
  SetStringField('FaultSectionCode', Value);
end;

procedure TRepairDetails.SetRepaircode(const Value: string);
begin
  SetStringField('Repaircode', Value);
end;

procedure TRepairDetails.SetMaterialcost(const Value: Double);
begin
  SetFloatField('Materialcost', Value);
end;

procedure TRepairDetails.SetFreightcost(const Value: Double);
begin
  SetFloatField('Freightcost', Value);
end;

procedure TRepairDetails.SetOtheramount(const Value: Double);
begin
  SetFloatField('Otheramount', Value);
end;

procedure TRepairDetails.SetServicetype(const Value: string);
begin
  SetStringField('Servicetype', Value);
end;

procedure TRepairDetails.SetAuthorisationnumber(const Value: string);
begin
  SetStringField('Servicetype', Value);
end;

function TRepairs.getRepairDetails: TRepairDetails;
begin
  Result := TRepairDetails(GetcontainerComponent(TRepairDetails,
    'repairId = ' + IntToStr(self.ID)));
end;

function TRepairDetails.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then
    Exit;

  if Assigned(self.Owner) then
    if self.Owner is TRepairs then begin
      RepairID := TRepairs(self.Owner).ID;
      if TRepairs(self.Owner).RepairEquipment.count > 0 then begin
        // Model := TRepairs(Self.Owner).RepairEquipment.Model;
        // Serialno := TRepairs(Self.Owner).RepairEquipment.Serialno;
        ManInvDate := TRepairs(self.Owner).RepairEquipment.WarantyStartDate;
        // manufacture :=TRepairs(Self.Owner).RepairEquipment.Manufacture;
        // ManufactureID:= tcDatautils.getManufactureId(manufacture);
      end;
    end;
  ReceiptNumberCaption := 'GSFS Receipt Number';
  Servicetype := 'IH';
end;

procedure TRepairDetails.UpdateRepaircode;
begin
  PostDB;
  Repaircode := FaultConditionCode + ':' + FaultSymptomCode + ':' + FaultDefectCode + ':' +
    FaultRepairCode + ':' + FaultSectionCode;
  PostDB;
end;

function TRepairDetails.getManInvDate: TDatetime;
begin
  Result := GetDatetimeField('ManInvDate');
end;

function TRepairDetails.getManInvNo: Integer;
begin
  Result := GetIntegerField('ManInvNo')
end;

procedure TRepairDetails.setManInvDate(const Value: TDatetime);
begin
  SetDatetimeField('ManInvDate', Value)
end;

procedure TRepairDetails.setManInvNo(const Value: Integer);
begin
  SetIntegerField('ManInvNo', Value);
end;

function TRepairDetails.getSerialNo: String;
begin
  Result := GetStringField('Serialno');
end;

procedure TRepairDetails.setModel(const Value: String);
begin
  SetStringField('Model', Value);
end;

procedure TRepairDetails.setSerialNo(const Value: String);
begin
  SetStringField('SerialNo', Value);
end;

function TRepairDetails.getModel: String;
begin
  Result := GetStringField('Model');
end;

function TRepairDetails.getManufacture: String;
begin
  Result := GetStringField('Manufacture');
end;

function TRepairDetails.getManufactureId: Integer;
begin
  Result := GetIntegerField('ManufactureID');
end;

procedure TRepairDetails.setManufacture(const Value: String);
begin
  SetStringField('Manufacture', Value);
end;

procedure TRepairDetails.SetManufactureId(const Value: Integer);
begin
  SetIntegerField('ManufactureID', Value);
end;

function TRepairDetails.getRetailer: String;
begin
  Result := GetStringField('Retailer');
end;

function TRepairDetails.getRetailerId: Integer;
begin
  Result := GetIntegerField('RetailerID');
end;

procedure TRepairDetails.setRetailer(const Value: String);
begin
  SetStringField('Retailer', Value);
end;

procedure TRepairDetails.SetRetailerId(const Value: Integer);
begin
  SetIntegerField('RetailerId', Value);
end;

function TRepairDetails.getReceiptNumberCaption: String;
begin
  Result := GetStringField('ReceiptNumberCaption');
end;

procedure TRepairDetails.setReceiptNumberCaption(const Value: String);
begin
  SetStringField('ReceiptNumberCaption', Value);
end;

procedure TRepairs.UpdateStatus(fsActionName: String);
var
  choiceSeqNo: Integer;
  StatusSeqNo: Integer;
  StatusIDforAction: Integer;
begin
  StatusIDforAction := TSimpleTypeActions.StatusForchoice(fsActionName, SimpleTypes_StatusType);
  if StatusIDforAction = 0 then
    Exit;
  StatusSeqNo := TSimpleTypeActions.SeqNoForstatus(Status, SimpleTypes_StatusType);
  // if StatusSeqNo = StatusIDforAction  then exit;

  if Status = '' then
  else begin
    choiceSeqNo := TSimpleTypeActions.SeqNoForchoice(fsActionName, SimpleTypes_StatusType);

    if StatusSeqNo = choiceSeqNo then
      Exit;
    if (choiceSeqNo > StatusSeqNo) and (StatusSeqNo <> 0) then
      Exit;
  end;
  Status := GetSimpleType(StatusIDforAction);
  PostDB;
end;

function TRepairDetails.getmanufactureObj: TManufacture;
begin
  Result := TManufacture(GetcontainerComponent(TManufacture, 'ID = ' + IntToStr(ManufactureID)));
end;

// procedure TRepairParts.AssignTheFirstEquipment;
// begin
// if EquipmentName = '' then
// if Assigned(SElf.Owner) then
// if Self.Owner is TRepairs then begin
// if TRepairs(Self.Owner).RepairEquipment.count >0 then begin
// TRepairs(Self.Owner).RepairEquipment.First;
// EquipmentName := TRepairs(Self.Owner).RepairEquipment.EquipmentName;
// end;
// end;
// end;

function TRepairParts.GetProductType: string;
begin
  Result := GetStringField('PartType');
end;

function TRepairParts.getPurchaseLineId: integer;
begin
  Result := GetIntegerField('PurchaseLineId');
end;

procedure TRepairParts.SetProductType(const Value: string);
begin
  inherited;
  SetStringField('PartType', Value);
end;

procedure TRepairParts.SetPurchaselineId(const Value: integer);
begin
  SetIntegerField('PurchaseLineId', Value);
end;

{ TRepairEquipmentFault }
constructor TRepairEquipmentFault.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'RepairEquipmentFault';
  fSQL := 'SELECT * FROM tblrepairsfaults';
  fIsList := True;
end;

destructor TRepairEquipmentFault.Destroy;
begin
  inherited;
end;

procedure TRepairEquipmentFault.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'RepairID');
  SetPropertyFromNode(node, 'TimeSheetID');
  SetPropertyFromNode(node, 'RepairFault');
  SetPropertyFromNode(node, 'CustomerEquipmentID');
  SetPropertyFromNode(node, 'Equipment');
  SetBooleanPropertyFromNode(node, 'Deleted');
end;

procedure TRepairEquipmentFault.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'RepairID', RepairID);
  AddXMLNode(node, 'TimeSheetID', TimeSheetID);
  AddXMLNode(node, 'RepairFault', RepairFault);
  AddXMLNode(node, 'CustomerEquipmentID', CustomerEquipmentID);
  AddXMLNode(node, 'Equipment', Equipment);
  AddXMLNode(node, 'Deleted', Deleted);
end;

function TRepairEquipmentFault.ValidateData: Boolean;
begin
  Result := false;
  Resultstatus.Clear;
  if Deleted = True then
    Exit;

  if RepairID = 0 then begin
    AddResult(false, rssWarning, 0, 'RepairID should not be 0', True);
    Exit;
  end;
  if CustomerEquipmentID = 0 then begin
    AddResult(false, rssWarning, 0, 'Equipment should not be blank', True);
    Exit;
  end;
  if RepairFault = '' then begin
    AddResult(false, rssWarning, 0, 'Repair Fault should not be blank', True);
    Exit;
  end;
  Result := True;
end;

class function TRepairEquipmentFault._Schema: string;
begin
  Result := inherited;
  TBOSchema.AddRefType(Result, 'TTimeSheete', 'TimeSheetObj', 'TimeSheetID', 'ID');
  TBOSchema.AddRefType(Result, 'TCustomerEquipment', 'CustomerEquipObj',
    'CustomerEquipmentId', 'Id');
end;

function TRepairEquipmentFault.Save: Boolean;
begin
  Result := false;
  if not ValidateData then
    Exit;
  Result := inherited Save;
end;

procedure TRepairEquipmentFault.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TRepairEquipmentFault.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = false then
      Exit; // we are only interested in data fields.

  if sysutils.SameText(Sender.fieldName, 'CustomerEquipmentID') then begin
    if not RawMode then begin
      Equipment := TCustomerEquipment.EquipmentNameForId(CustomerEquipmentID,
        Connection.Connection);
      if Equipment <> '' then
        sendEvent(BusObjEvent_Change, BusObjEventVal_Equipment, self);
    end;
  end
end;

function TRepairEquipmentFault.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TRepairEquipmentFault.GetIDField: string;
begin
  Result := 'RepairsFaultId'
end;

class function TRepairEquipmentFault.GetBusObjectTablename: string;
begin
  Result := 'tblrepairsfaults';
end;

function TRepairEquipmentFault.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then
    Exit;
  Deleted := false;
  if Assigned(self.Owner) then
    if self.Owner is TRepairs then
      RepairID := TRepairs(self.Owner).ID;
end;

function TRepairEquipmentFault.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TRepairEquipmentFault.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not Result then
    Exit;
  if { (not DatasetPosting) and } (CustomerEquipmentID = 0) and (Equipment = '') and
    (RepairFault = '') then begin
    Deleted := True;
    Result := True;
    Exit;
  end;

end;

{ Property Functions }
function TRepairEquipmentFault.GetRepairID: Integer;
begin
  Result := GetIntegerField('RepairID');
end;

function TRepairEquipmentFault.GetTimeSheetID: Integer;
begin
  Result := GetIntegerField('TimeSheetID');
end;

function TRepairEquipmentFault.GetRepairFault: string;
begin
  Result := GetStringField('RepairFault');
end;

function TRepairEquipmentFault.GetCustomerEquipmentID: Integer;
begin
  Result := GetIntegerField('CustomerEquipmentID');
end;

function TRepairEquipmentFault.GetEquipment: string;
begin
  Result := GetStringField('Equipment');
end;

function TRepairEquipmentFault.GetDeleted: Boolean;
begin
  Result := GetBooleanField('Deleted');
end;

procedure TRepairEquipmentFault.SetRepairID(const Value: Integer);
begin
  SetIntegerField('RepairID', Value);
end;

procedure TRepairEquipmentFault.SetTimeSheetID(const Value: Integer);
begin
  SetIntegerField('TimeSheetID', Value);
end;

procedure TRepairEquipmentFault.SetRepairFault(const Value: string);
begin
  SetStringField('RepairFault', Value);
end;

procedure TRepairEquipmentFault.SetCustomerEquipmentID(const Value: Integer);
begin
  SetIntegerField('CustomerEquipmentID', Value);
end;

procedure TRepairEquipmentFault.SetEquipment(const Value: string);
begin
  SetStringField('Equipment', Value);
end;

procedure TRepairEquipmentFault.SetDeleted(const Value: Boolean);
begin
  SetBooleanField('Deleted', Value);
end;

{ TRepairTimesheetEntry }

constructor TRepairTimesheetEntry.Create(AOwner: TComponent);
begin
  inherited;
  ExportExcludeList.Add('typeid');
end;

function TRepairTimesheetEntry.getRepairArea: String;
begin
  Result := '';
  if assigned(Owner) then
    if owner is Trepairs then
      REsult :=Trepairs(Owner).Area;
end;

function TRepairTimesheetEntry.GetRepairId: integer;
begin
  result := TypeId;
end;

procedure TRepairTimesheetEntry.SetRepairId(const Value: integer);
begin
  TypeId := Value;
end;

class function TRepairTimesheetEntry._Schema: string;
begin
  result := inherited;
  TBOSchema.AddRefType(Result, 'TRepairs', 'RepairObj', 'RepairId', 'ID');
end;

initialization

RegisterClass(TRepairEquipmentFault);
RegisterClass(TRepairDetails);
RegisterClass(TRepairFaults);
RegisterClassOnce(TRepairs);
RegisterClass(TRepairParts);
RegisterClass(TRepairTimesheetEntry);

end.
