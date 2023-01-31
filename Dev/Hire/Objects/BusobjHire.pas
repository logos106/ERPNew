unit BusobjHire;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  05/02/16  1.00.00  A.  Initial Version.
}

interface

uses BusObjStock, {BusObjEquipment,} BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjClient,
  busobjPQA, ClientDiscountObj, BusObjTaxCodes, BusObjShippingAddress, busobjduration,
  BusobjSaleBase, BusObjSmartOrder, BusobjAssetHire, ERPDbComponents;

type
  TAssetHireRec = record
    AssetID: Integer;
    ProductID: Integer;
    OnHireQty: Double;
    MaxOnHireQty: Double;
    EquipQty: Double;
  end;

  TAssetHireArray = Array of TAssetHireRec;

  THireLineAsset = class;
  THireLines = class(TProdQty)
  private
    fPlanner: boolean;
    function GetHireID: Integer;
    function GetEmployeeId: Integer;
    function GetEmployeeName: string;
    function GetHireFromtime: string;
    function GetHireTotime: string;
    function GetActualHireFromTime: string;
    function GetActualHireToTime: string;
    function GetDurationId: Integer;
    function GetDurationName: string;
    function GetDurationRate: Double;
    function GetDurationQty: Double;
    function GetUOMID: Integer;
    function GetUOM: string;
    function GetUOMMult: Double;
    function GetHireQty: Double;
    function GetHireFrom: TDateTime;
    function GetActualHirefrom: TDateTime;
    function GetHireTo: TDateTime;
    function GetActualHireTo: TDateTime;
    function GetStatus: String;
    function GetLineAmount: Double;
    function GetLineTaxCode: string;
    function GetLineTaxRate: Double;
    function GetLineAmountInc: Double;
    function GetPriceEx: Double;
    function GetPriceInc: Double;
    Function GetDeleted: Boolean;
    Function GetConverted: Boolean;
    procedure SetHireID(const Value: Integer);
    procedure SetEmployeeId(const Value: Integer);
    procedure SetEmployeeName(const Value: string);
    procedure SetHireFromtime(const Value: string);
    procedure SetHireTotime(const Value: string);
    procedure SetActualHireFromTime(const Value: string);
    procedure SetActualHireToTime(const Value: string);
    procedure SetDurationId(const Value: Integer);
    procedure SetDurationName(const Value: string);
    procedure SetDurationRate(const Value: Double);
    procedure SetDurationQty(const Value: Double);
    procedure SetUOMID(const Value: Integer);
    procedure SetUOM(const Value: string);
    procedure SetUOMMult(Value: Double);
    procedure SetHireQty(const Value: Double);
    procedure SetHireFrom(const Value: TDateTime);
    procedure SetActualHirefrom(const Value: TDateTime);
    procedure SetHireTo(const Value: TDateTime);
    procedure SetActualHireTo(const Value: TDateTime);
    procedure SetStatus(const Value: String);
    procedure SetLineAmount(const Value: Double);
    procedure SetLineTaxCode(const Value: string);
    procedure SetLineTaxRate(const Value: Double);
    procedure SetLineAmountInc(const Value: Double);
    procedure SetPriceEx(const Value: Double);
    procedure SetPriceInc(const Value: Double);
    Procedure SetDeleted(Const Value: Boolean);
    Procedure SetConverted(Const Value: Boolean);
    function GetHireReturnPQA: TPQA;
    function getTaxObj: TTaxcode;
    function getProduct: TProduct;
    procedure CalcLinetotals;
    Procedure CalculateHireTotals;
    procedure GetToDate;
    function getDuration: TDuration;
    function GetIncomeAccountId: Integer;
    procedure SetIncomeAccountId(const Value: Integer);
    function GetAssetId: Integer;
    function GetAssetName: string;
    function GetHireProductId: integer;
    function GetHireProductName: string;
    function GetHireProductPrintName: string;
    procedure SetAssetId(const Value: Integer);
    procedure SetAssetName(const Value: string);
    procedure SetHireProductId(const Value: integer);
    procedure SetHireProductName(const Value: string);
    procedure SetHireProductPrintName(const Value: string);
    function GetAssetCode: string;
    procedure SetAssetCode(const Value: string);
    function GetAssetLines: THireLineAsset;
    procedure SelectAssets;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforeDelete(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforeInsert(Sender: TDatasetBusObj): Boolean; override;
    procedure OnBeforeDataIdChange; override;
    Function DoCalcFields(Sender: TDatasetBusObj): Boolean; override;

    function GetUnitOfMeasure: String; Override;
    function GetUnitOfMeasureID: Integer; Override;
    procedure SetUnitOfMeasureID(const Value: Integer); Override;
    Function GetProductID: Integer; override;
    procedure SetProductID(const Value: Integer); Override;
    procedure SetProductName(const Value: string); Override;
    procedure SetProductPrintName(const Value: string); Override;
    Function GetProductName: String; Override;
    Function GetProductPrintName: String; Override;
    procedure SetMatrixRef(const Value: String); Override;
    function GetMatrixRef: String; Override;
    function GetMatrixDesc: String; Override;
    function GetMatrixPrice: Double; Override;
    procedure SetMatrixDesc(const Value: String); Override;
    procedure SetMatrixPrice(const Value: Double); Override;
    Function GetQty: Double; Override;
    function GetUOMQty: Double; Override;

    Procedure CreateInstance; Override;
    Function GetHeaderID: Integer; Override;
    function GetUOMMultiplier: Double; Override;
    Function GetClassID: Integer; Override;
    Function GetAllocType: String; override;
    Function GetActive: Boolean; Override;
    Function GetTransDate: TDateTime; Override;
    Function GetBOQty: Double; Override;
    Function GetBOUOMQty: Double; Override;
    function GetSerialnos: String; Override;
    function GetCleanClassID: Integer; Override;
    function GetcleanProductId: Integer; Override;
    function GetOrderQty: Double; Override;
    function GetUOMOrderQty: Double; Override;
    Procedure ClonePropertyObjects; Override;
    procedure SetQty(const Value: Double); Override;
    procedure SetUOMQty(const Value: Double); Override;
    Procedure GetBaseLinePrice;
    function GetProductType: string; override;
    procedure SetProductType(const Value: string); override;
    procedure SetUOMMultiplier(const Value: Double); Override;
    Procedure SetUnitOfMeasure(Const Value: String); Override;
    function GetIsPQAItem: Boolean; Override;
    procedure CalcQtyandPriceFromDates(Actual: boolean);
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    Property TaxObj: TTaxcode REad getTaxObj;
    Property Product: TProduct read getProduct;
    Property Duration: TDuration read getDuration;
    function IsAvailable(var msg: string): boolean;
    function Delete: boolean; overload; override;
  published
    property HireID: Integer read GetHireID write SetHireID;
    property EmployeeId: Integer read GetEmployeeId write SetEmployeeId;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property HireFromtime: string read GetHireFromtime write SetHireFromtime;
    property HireTotime: string read GetHireTotime write SetHireTotime;
    property ActualHireFromTime: string read GetActualHireFromTime write SetActualHireFromTime;
    property ActualHireToTime: string read GetActualHireToTime write SetActualHireToTime;
    property DurationId: Integer read GetDurationId write SetDurationId;
    property DurationName: string read GetDurationName write SetDurationName;
    property DurationRate: Double read GetDurationRate write SetDurationRate;
    property DurationQty: Double read GetDurationQty write SetDurationQty;
    property UOMID: Integer read GetUOMID write SetUOMID;
    property UOM: string read GetUOM write SetUOM;
    property UOMMult: Double read GetUOMMult write SetUOMMult;
    property HireQty: Double read GetHireQty write SetHireQty;
    property HireFrom: TDateTime read GetHireFrom write SetHireFrom;
    property ActualHirefrom: TDateTime read GetActualHirefrom write SetActualHirefrom;
    property HireTo: TDateTime read GetHireTo write SetHireTo;
    property ActualHireTo: TDateTime read GetActualHireTo write SetActualHireTo;
    property Status: String read GetStatus write SetStatus;
    property LineAmount: Double read GetLineAmount write SetLineAmount;
    property LineTaxCode: string read GetLineTaxCode write SetLineTaxCode;
    property LineTaxRate: Double read GetLineTaxRate write SetLineTaxRate;
    property LineAmountInc: Double read GetLineAmountInc write SetLineAmountInc;
    property PriceEx: Double read GetPriceEx write SetPriceEx;
    property PriceInc: Double read GetPriceInc write SetPriceInc;
    Property Deleted: Boolean read GetDeleted write SetDeleted;
    Property Converted: Boolean read GetConverted write SetConverted;
    Property HireReturnPQA: TPQA read GetHireReturnPQA;
    property IncomeAccountId: Integer read GetIncomeAccountId write SetIncomeAccountId;
    property HireProductName: string read GetHireProductName write SetHireProductName;
    property HireProductPrintName: string read GetHireProductPrintName write SetHireProductPrintName;
    property HireProductId: integer read GetHireProductId write SetHireProductId;
    property AssetName: string read GetAssetName write SetAssetName;
    property AssetId: Integer read GetAssetId write SetAssetId;
    property AssetCode: string read GetAssetCode write SetAssetCode;
    property AssetLines: THireLineAsset read GetAssetLines;

    property Planner : boolean read fPlanner write fPlanner;
  end;

  THireLineAsset = class(TMSBusObj)
  private
    function GetAssetCode: string;
    function GetAssetId: integer;
    function GetAssetName: string;
    function GetHireLineId: integer;
    procedure SetAssetCode(const Value: string);
    procedure SetAssetId(const Value: integer);
    procedure SetAssetName(const Value: string);
    procedure SetHireLineId(const Value: integer);
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    procedure DoFieldOnChange(Sender: TField); override;
  public
    class function GetIDField: string; override;
    class function GetKeyStringField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property HireLineId: integer read GetHireLineId write SetHireLineId;
    property AssetId: integer read GetAssetId write SetAssetId;
    property AssetName: string read GetAssetName write SetAssetName;
    property AssetCode: string read GetAssetCode write SetAssetCode;
  end;

  THirePartsSale = class(TProdQty)
  private
    AddingRelatedParts: Boolean;
    fClientDiscountObj: TClientDiscountObj;
    fLastDiscountRetMsg: string;
    ParentQty :Double;
    fsRelatedParentLineRef :String;
    fiParentProductId:Integer;
    function GetHirePartsSaleID: Integer;
    function GetHireID: Integer;
    function GetDescription: string;
    function GetUnitofMeasureMultiplier: Double;
    function GetLinecost: Double;
    function GetPriceEx: Double;
    function GetPriceInc: Double;
    function GetTaxCode: string;
    function GetTaxRate: Double;
    function GetLineTotalEx: Double;
    function GetLineTotalInc: Double;
    function GetDiscount: Double;
    function GetMarkup: Double;
    function GetDiscountPercent: Double;
    function GetMarkupPercent: Double;
    function GetDeleted: Boolean;
    function GetConverted: Boolean;
    function GetParentProductID: Integer;
    function GetParentLineRef: string;
    function GetRelatedProductQty: Double;
    function GetIsRelatedProduct: Boolean;
    function GetPartBarcode: string;
    function getPartIssuedOn: TDateTime;
    procedure SetHirePartsSaleID(const Value: Integer);
    procedure SetHireID(const Value: Integer);
    procedure SetDescription(const Value: string);
    procedure SetUnitOfMeasureMultiplier(Value: Double);
    procedure SetLinecost(const Value: Double);
    procedure SetPriceEx(const Value: Double);
    procedure SetPriceInc(const Value: Double);
    procedure SetTaxCode(const Value: string);
    procedure SetTaxRate(const Value: Double);
    procedure SetLineTotalEx(const Value: Double);
    procedure SetLineTotalInc(const Value: Double);
    procedure SetDiscount(const Value: Double);
    procedure SetMarkup(const Value: Double);
    procedure SetDiscountPercent(const Value: Double);
    procedure SetMarkupPercent(const Value: Double);
    procedure SetDeleted(const Value: Boolean);
    procedure SetConverted(const Value: Boolean);
    procedure SetParentProductID(const Value: Integer);
    procedure SetParentLineRef(const Value: string);
    procedure SetRelatedProductQty(const Value: Double);
    procedure SetIsRelatedProduct(const Value: Boolean);
    procedure SetPartBarcode(const Value: string);
    Procedure SetPartIssuedOn(Const Value: TDateTime);
    function getInvoiceToclientID: Integer;
    function GetClientDiscountObj: TClientDiscountObj;
    procedure AddRelatedParts;
    Procedure CalcLinetotals;
    function getTaxObj: TTaxcode;
    Procedure CalculateHireTotals;
    function getHireTerms: String;
    procedure updaterelatedPartsQty;
    procedure updateRelPrQtyCallback(const Sender: TBusObj; var Abort: Boolean);
    function AutoRoundRelatedQty(const Qty: double): Double;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;

    function GetUnitOfMeasure: String; Override;
    function GetUnitOfMeasureID: Integer; Override;
    Function GetProductID: Integer; override;
    Function GetProductName: String; Override;
    Function GetProductPrintName: String; Override;
    procedure SetMatrixRef(const Value: String); Override;
    function GetMatrixRef: String; Override;
    function GetMatrixDesc: String; Override;
    function GetMatrixPrice: Double; Override;
    procedure SetMatrixDesc(const Value: String); Override;
    procedure SetMatrixPrice(const Value: Double); Override;

    Procedure CreateInstance; Override;
    Function GetHeaderID: Integer; Override;
    function GetUOMMultiplier: Double; Override;
    Function GetClassID: Integer; Override;
    Function GetAllocType: String; override;
    Function GetActive: Boolean; Override;
    Function GetTransDate: TDateTime; Override;
    function GetSerialnos: String; Override;
    function GetCleanClassID: Integer; Override;
    function GetcleanProductId: Integer; Override;
    Procedure ClonePropertyObjects; Override;
    Procedure GetBaseLinePrice;
    function GetProductType: string; override;
    procedure SetProductType(const Value: string); override;
    procedure SetUOMMultiplier(const Value: Double); Override;

    Function GetBOQty: Double; Override;
    Function GetQty: Double; Override;
    function GetUOMQty: Double; Override;
    function GetOrderQty: Double; Override;
    function GetUOMOrderQty: Double; Override;

    procedure SetQty(const Value: Double); Override;
    procedure SetUOMQty(const Value: Double); Override;
    procedure SetProductID(const Value: Integer); Override;
    procedure SetProductName(const Value: string); Override;
    procedure SetProductPrintName(const Value: string); Override;
    procedure SetUnitOfMeasureID(const Value: Integer); Override;
    procedure SetUnitOfMeasure(const Value: string); Override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    Property InvoiceToclientID: Integer read getInvoiceToclientID;
    property ClientDiscountObj: TClientDiscountObj Read GetClientDiscountObj;
    Property TaxObj: TTaxcode REad getTaxObj;
    Property HireTerms: String read getHireTerms;
  published
    property HirePartsSaleID: Integer read GetHirePartsSaleID write SetHirePartsSaleID;
    property HireID: Integer read GetHireID write SetHireID;
    property Description: string read GetDescription write SetDescription;
    property PartType: string read GetProductType write SetProductType;
    property UnitofMeasureMultiplier: Double read GetUnitofMeasureMultiplier
      write SetUnitOfMeasureMultiplier;
    property Linecost: Double read GetLinecost write SetLinecost;
    property PriceEx: Double read GetPriceEx write SetPriceEx;
    property PriceInc: Double read GetPriceInc write SetPriceInc;
    property TaxCode: string read GetTaxCode write SetTaxCode;
    property TaxRate: Double read GetTaxRate write SetTaxRate;
    property LineTotalEx: Double read GetLineTotalEx write SetLineTotalEx;
    property LineTotalInc: Double read GetLineTotalInc write SetLineTotalInc;
    property Discount: Double read GetDiscount write SetDiscount;
    property Markup: Double read GetMarkup write SetMarkup;
    property DiscountPercent: Double read GetDiscountPercent write SetDiscountPercent;
    property MarkupPercent: Double read GetMarkupPercent write SetMarkupPercent;
    property Deleted: Boolean read GetDeleted write SetDeleted;
    property Converted: Boolean read GetConverted write SetConverted;
    property ParentProductID: Integer read GetParentProductID write SetParentProductID;
    property ParentLineRef: string read GetParentLineRef write SetParentLineRef;
    property RelatedProductQty: Double read GetRelatedProductQty write SetRelatedProductQty;
    property IsRelatedProduct: Boolean read GetIsRelatedProduct write SetIsRelatedProduct;
    property PartBarcode: string read GetPartBarcode write SetPartBarcode;
    Property PartIssuedOn: TDateTime read getPartIssuedOn write SetPartIssuedOn;

  end;

  THire = class(TMSBusObj)
  private
    AllLinesValid: Boolean;
    fdSalestotal, fdHiretotal: Double;
    salesObj: TSalesBase;
    SmartOrder: TSmartOrder;

    function GetCreatedDate: TDateTime;
    function GetHireDate: TDateTime;
    function GetCustomerID: Integer;
    function GetShipAddressID: Integer;
    Function getUseBillCust: Boolean;
    Function GetConverted: Boolean;
    function GetBillCustomerID: Integer;
    function GetEmployeeId: Integer;
    function GetBilltoAddress: string;
    function GetShipToAddress: string;
    function GetCustomerName: string;
    function GetClientPrintName: string;
    function GetBillCustomerName: string;
    function GetBillClientPrintName: string;
    function GetClassname: string;
    function GetEmployeeName: string;
    function GetContactID: Integer;
    function GetClassID: Integer;
    function GetHiretotal: Double;
    function GetSalesTotal: Double;
    function GetTotalAmount: Double;
    function GetNotes: string;
    function GetStatus: String;
    function GetTermsID: Integer;
    function GetTerms: string;
    procedure SetCreatedDate(const Value: TDateTime);
    procedure SetHireDate(const Value: TDateTime);
    procedure SetCustomerID(const Value: Integer);
    procedure SetShipAddressID(const Value: Integer);
    Procedure SetUseBillCust(const Value: Boolean);
    Procedure SetConverted(const Value: Boolean);
    procedure SetBillCustomerID(const Value: Integer);
    procedure SetEmployeeId(const Value: Integer);
    procedure SetBilltoAddress(const Value: string);
    procedure SetShipToAddress(const Value: string);
    procedure SetCustomerName(const Value: string);
    procedure SetClientPrintName(const Value: string);
    procedure SetBillCustomerName(const Value: string);
    procedure SetBillClientPrintName(const Value: string);
    procedure SetClassname(const Value: string);
    procedure SetEmployeeName(const Value: string);
    procedure SetContactID(const Value: Integer);
    procedure SetClassID(const Value: Integer);
    procedure SetHiretotal(const Value: Double);
    procedure SetSalesTotal(const Value: Double);
    procedure SetTotalAmount(const Value: Double);
    procedure SetNotes(const Value: string);
    procedure SetStatus(const Value: String);
    procedure SetTermsID(const Value: Integer);
    procedure SetTerms(const Value: string);
    function getHireLines: THireLines;
    function getHirePartsSale: THirePartsSale;
    function GetCustomer: TCustomer;
    function GetBillCustomer: TCustomer;
    function getCleanDepartmentID: Integer;
    Procedure HirelinesValidateCallback(Const Sender: TBusObj; var Abort: Boolean);
    Procedure hirepartssaleValidateCallback(Const Sender: TBusObj; var Abort: Boolean);
    Function DeleteFlaggedLines: Boolean;
    Procedure DeleteLinesCallBack(Const Sender: TBusObj; var Abort: Boolean);
    function getShippingAddressObj: TShippingAddress;
    Procedure CalculateHireTotals;
    Procedure CalculateHireTotalsCallback(Const Sender: TBusObj; var Abort: Boolean);
    Function HasEquipmenttoconvert: Boolean;
    Function HaveSaleProductToConvert: Boolean;
    Procedure checkforToBeInvoiced(Const Sender: TBusObj; var Abort: Boolean);
    Procedure CopytoSales(Const Sender: TBusObj; var Abort: Boolean);
    Procedure CopytoSmartOrderCallback(Const Sender: TBusObj; var Abort: Boolean);

    function copysales: Integer;
    function GetCustomerPONumber: string;
    procedure SetCustomerPONumber(const Value: string);
    function GetDeleted: boolean;
    procedure SetDeleted(const Value: boolean);
    function GetDefaultActualDurationQty: double;
    function GetDefaultActualDurationId: integer;
    function GetDefaultActualHireFrom: TDateTime;
    function GetDefaultActualHireTo: TDateTime;
    function GetDefaultDurationQty: double;
    function GetDefaultDurationId: integer;
    function GetDefaultHireFrom: TDateTime;
    function GetDefaultHireTo: TDateTime;
    procedure SetDefaultActualDurationQty(const Value: double);
    procedure SetDefaultActualDurationId(const Value: integer);
    procedure SetDefaultActualHireFrom(const Value: TDateTime);
    procedure SetDefaultActualHireTo(const Value: TDateTime);
    procedure SetDefaultDurationQty(const Value: double);
    procedure SetDefaultDurationId(const Value: integer);
    procedure SetDefaultHireFrom(const Value: TDateTime);
    procedure SetDefaultHireTo(const Value: TDateTime);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    Function DoCalcFields(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetKeyStringField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    Property Customer: TCustomer Read GetCustomer;
    Property BillCustomer: TCustomer Read GetBillCustomer;
    Property CleanDepartmentID: Integer read getCleanDepartmentID;
    function ValidateNPostMain: Boolean;
    function CopyToInvoice: Integer;
    function CopyToCashsale: Integer;
    function CopyTosaleSOrder: Integer;
    function CopyToSmartOrder: Integer;
    Property ShippingAddressObj: TShippingAddress read getShippingAddressObj;
    function RepeatHire(const dates: array of TDateTime): Boolean;
  published
    property CreatedDate: TDateTime read GetCreatedDate write SetCreatedDate;
    property HireDate: TDateTime read GetHireDate write SetHireDate;
    property CustomerID: Integer read GetCustomerID write SetCustomerID;
    property ShipAddressID: Integer read GetShipAddressID write SetShipAddressID;
    Property UseBillCust: Boolean read getUseBillCust write SetUseBillCust;
    Property Converted: Boolean read GetConverted write SetConverted;
    property BillCustomerID: Integer read GetBillCustomerID write SetBillCustomerID;
    property EmployeeId: Integer read GetEmployeeId write SetEmployeeId;
    property BilltoAddress: string read GetBilltoAddress write SetBilltoAddress;
    property ShipToAddress: string read GetShipToAddress write SetShipToAddress;
    property CustomerName: string read GetCustomerName write SetCustomerName;
    property ClientPrintName: string read GetClientPrintName write SetClientPrintName;
    property BillCustomerName: string read GetBillCustomerName write SetBillCustomerName;
    property BillClientPrintName: string read GetBillClientPrintName write SetBillClientPrintName;
    property DepartmentName: string read GetClassname write SetClassname;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property ContactID: Integer read GetContactID write SetContactID;
    property DepartmentID: Integer read GetClassID write SetClassID;
    property Hiretotal: Double read GetHiretotal write SetHiretotal;
    property SalesTotal: Double read GetSalesTotal write SetSalesTotal;
    property TotalAmount: Double read GetTotalAmount write SetTotalAmount;
    property Notes: string read GetNotes write SetNotes;
    property Status: String read GetStatus write SetStatus;
    property TermsID: Integer read GetTermsID write SetTermsID;
    property Terms: string read GetTerms write SetTerms;
    Property HireLines: THireLines read getHireLines;
    Property HirePartsSale: THirePartsSale read getHirePartsSale;
    property CustomerPONumber: string read GetCustomerPONumber write SetCustomerPONumber;
    property Deleted: boolean read GetDeleted write SetDeleted;
    property DefaultHireFrom: TDateTime read GetDefaultHireFrom write SetDefaultHireFrom;
    property DefaultHireTo: TDateTime read GetDefaultHireTo write SetDefaultHireTo;
    property DefaultDurationId: integer read GetDefaultDurationId write SetDefaultDurationId;
    property DefaultDurationQty: double read GetDefaultDurationQty write SetDefaultDurationQty;
    property DefaultActualHireFrom: TDateTime read GetDefaultActualHireFrom write SetDefaultActualHireFrom;
    property DefaultActualHireTo: TDateTime read GetDefaultActualHireTo write SetDefaultActualHireTo;
    property DefaultActualDurationId: integer read GetDefaultActualDurationId write SetDefaultActualDurationId;
    property DefaultActualDurationQty: double read GetDefaultActualDurationQty write SetDefaultActualDurationQty;
  end;

implementation

uses tcDataUtils, CommonLib, sysutils, BusObjEmployee, BusObjClass,
  BusObjCommon, BusObjSales,
  PartsPriceMatrixLib, AppEnvironment, BusObjConst, BusobjCash, variants,
  tcConst, DateTimeUtils, dateutils, DbSharedObjectsObj,
  Dialogs, controls, CommonDbLib, timelib, BusobjProduct, BusObjGLAccount,
  MySQLConst, LogLib, frmMessageWithList, frmMessageBase, HireLib,
  BusObjFixedAsset, BusObjHirePricingLine;

{ THire }

constructor THire.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'Hire';
  fSQL := 'SELECT * FROM tblhire';
end;

Procedure THire.DeleteLinesCallBack(Const Sender: TBusObj; var Abort: Boolean);
begin
  if Sender is THireLines then begin
    if THireLines(Sender).Deleted or
       (THireLines(Sender).AssetLines.Count = 0) then
    begin
      THireLines(Sender).Delete;
    end;
  end
  else if Sender is THirePartsSale then begin
    if THirePartsSale(Sender).Deleted then begin
      THirePartsSale(Sender).Delete;
    end;
  end;
end;

function THire.DeleteFlaggedLines: Boolean;
var
  TempAccessLevel: Integer;
begin
  TempAccessLevel := AccessManager.AccessLevel;
  If Self.CleanID < 1 Then
    AccessManager.AccessLevel := 1;
  try
    HireLines.IterateRecordsReverse(DeleteLinesCallBack, True);
    HirePartsSale.IterateRecordsReverse(DeleteLinesCallBack, True);
    Result := True;
  finally
    If Self.CleanID < 1 Then
      AccessManager.AccessLevel := TempAccessLevel;
  end;
end;

destructor THire.Destroy;
begin
  inherited;
end;

procedure THire.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node, 'CreatedDate');
  SetDateTimePropertyFromNode(node, 'HireDate');
  SetPropertyFromNode(node, 'CustomerID');
  SetPropertyFromNode(node, 'ShipAddressID');
  SetBooleanPropertyFromNode(node, 'UseBillCust');
  SetBooleanPropertyFromNode(node, 'Converted');
  SetPropertyFromNode(node, 'BillCustomerID');
  SetPropertyFromNode(node, 'EmployeeID');
  SetPropertyFromNode(node, 'BilltoAddress');
  SetPropertyFromNode(node, 'ShipToAddress');
  SetPropertyFromNode(node, 'CustomerName');
  SetPropertyFromNode(node, 'ClientPrintName');
  SetPropertyFromNode(node, 'BillCustomerName');
  SetPropertyFromNode(node, 'BillClientPrintName');
  SetPropertyFromNode(node, 'DepartmentName');
  SetPropertyFromNode(node, 'EmployeeName');
  SetPropertyFromNode(node, 'ContactID');
  SetPropertyFromNode(node, 'DepartmentID');
  SetPropertyFromNode(node, 'Hiretotal');
  SetPropertyFromNode(node, 'SalesTotal');
  SetPropertyFromNode(node, 'Notes');
  SetPropertyFromNode(node, 'Status');
  SetPropertyFromNode(node, 'TermsID');
  SetPropertyFromNode(node, 'Terms');
end;

procedure THire.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'CreatedDate', CreatedDate);
  AddXMLNode(node, 'HireDate', HireDate);
  AddXMLNode(node, 'CustomerID', CustomerID);
  AddXMLNode(node, 'ShipAddressID', ShipAddressID);
  AddXMLNode(node, 'UseBillCust', UseBillCust);
  AddXMLNode(node, 'Converted', Converted);
  AddXMLNode(node, 'BillCustomerID', BillCustomerID);
  AddXMLNode(node, 'EmployeeID', EmployeeId);
  AddXMLNode(node, 'BilltoAddress', BilltoAddress);
  AddXMLNode(node, 'ShipToAddress', ShipToAddress);
  AddXMLNode(node, 'CustomerName', CustomerName);
  AddXMLNode(node, 'ClientPrintName', ClientPrintName);
  AddXMLNode(node, 'BillCustomerName', BillCustomerName);
  AddXMLNode(node, 'BillClientPrintName', BillClientPrintName);
  AddXMLNode(node, 'DepartmentName', DepartmentName);
  AddXMLNode(node, 'EmployeeName', EmployeeName);
  AddXMLNode(node, 'ContactID', ContactID);

  AddXMLNode(node, 'DepartmentID', DepartmentID);
  AddXMLNode(node, 'Hiretotal', Hiretotal);
  AddXMLNode(node, 'SalesTotal', SalesTotal);
  AddXMLNode(node, 'Notes', Notes);
  AddXMLNode(node, 'Status', Status);
  AddXMLNode(node, 'TermsID', TermsID);
  AddXMLNode(node, 'Terms', Terms);
end;

function THire.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if not ValidateNPostMain then
    exit;
  if (HirePartsSale.count > 0) and (HireLines.count = 0) then begin
    Resultstatus.AddItem(False, rssWarning, 0, 'Please Choose at least one Item to hire');
    exit;
  end;
  AllLinesValid := True;
  HireLines.IterateRecords(HirelinesValidateCallback);
  if not AllLinesValid then
    exit;

  HirePartsSale.IterateRecords(hirepartssaleValidateCallback);
  if not AllLinesValid then
    exit;

  Result := True;
end;

function THire.HasEquipmenttoconvert: Boolean;
begin
  AllLinesValid := False;
  HireLines.IterateRecords(checkforToBeInvoiced);
  Result := AllLinesValid;
end;

function THire.HaveSaleProductToConvert: Boolean;
begin
  AllLinesValid := False;
  HirePartsSale.IterateRecords(checkforToBeInvoiced);
  Result := AllLinesValid;
end;

procedure THire.checkforToBeInvoiced(const Sender: TBusObj; var Abort: Boolean);
begin
  if Sender is THireLines then begin
    if THireLines(Sender).Converted = False then begin
      AllLinesValid := True;
      Abort := True;
      exit;
    end;
  end
  else if Sender is THirePartsSale then begin
    if THirePartsSale(Sender).Converted = False then begin
      AllLinesValid := True;
      Abort := True;
      exit;
    end;
  end;
end;

Procedure THire.HirelinesValidateCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is THireLines) then
    exit;
  if not(THireLines(Sender).ValidateData) then begin
    AllLinesValid := False;
    Abort := True;
    exit;
  end;
end;

Procedure THire.hirepartssaleValidateCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is THirePartsSale) then
    exit;
  if not(THirePartsSale(Sender).ValidateData) then begin
    AllLinesValid := False;
    Abort := True;
    exit;
  end;
end;

function THire.ValidateNPostMain: Boolean;
begin
  Result := False;
  if (CustomerID = 0) or (CustomerName = '') then begin
    Resultstatus.AddItem(False, rssWarning, 0, 'Customer should not be blank');
    exit;
  end;
  if UseBillCust then
    if (BillCustomerID = 0) or (BillCustomerName = '') then begin
      Resultstatus.AddItem(False, rssWarning, 0, 'Bill Customer should not be blank');
      exit;
    end;
  if (DepartmentID = 0) or (DepartmentName = '') then begin
    Resultstatus.AddItem(False, rssWarning, 0, Appenv.DefaultClass.ClassHeading +
      ' should not be blank');
    exit;
  end;

  if (EmployeeId = 0) or (EmployeeName = '') then begin
    Resultstatus.AddItem(False, rssWarning, 0, 'Employee should not be blank');
    exit;
  end;
  if Status = '' then
    Status := 'Q';
  Result := True;
end;

function THire.Save: Boolean;
begin
  if (self.HireLines.Count = 0) and (self.HirePartsSale.Count = 0) then
    Deleted:= true;
  PostDb;
  Result := False;
  if not ValidateData then
    exit;
  Result := inherited Save;

  If Result Then Begin
    If DeleteFlaggedLines Then Begin
      Dirty := False;
    End
    Else
      Result := False;
  End;

end;

procedure THire.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

function THire.RepeatHire(const dates: array of TDateTime): Boolean;
var
  ctr: Integer;
begin
  for ctr := Low(dates) to high(dates) do begin

    if FieldsnotToclone <> '' then
      FieldsnotToclone := FieldsnotToclone + ',';
    FieldsnotToclone := FieldsnotToclone + 'CreatedDate';
    if Self.CloneBusObj('HireDate', dates[ctr], False, 'HireID') = nil then begin
      Result := False;
      exit;
    end;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
    THire(ObjInstanceToClone).CreatedDate := dates[ctr];
    THire(ObjInstanceToClone).Status := 'Q';
    THire(ObjInstanceToClone).Save;
  end;
  Result := True;
end;

procedure THire.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then
      exit; // we are only interested in data fields.
  inherited;

  If sysutils.SameText(Sender.FieldName, 'CustomerID') Then Begin
    ContactID := 0;
    CustomerName := Customer.ClientName;
    ClientPrintName:= Customer.Printname;
    ShipToAddress := Customer.ShipToAddress;

    if (BillCustomerName = '') or (not(UseBillCust)) then begin
      BillCustomerID := CustomerID;
      DoFieldOnChange(Dataset.FindField('BillCustomerID'));
    end;

    Terms := Customer.TermsName;
    if Terms = '' then
      Terms := TERMS_ON_RCPT;
    DoFieldOnChange(Dataset.FindField('Terms'));
  end
  else If sysutils.SameText(Sender.FieldName, 'CustomerName') Then Begin
    If CustomerName = '' Then
      CustomerID := 0
    else begin
      CustomerID := TCustomer.IDToggle(Sender.AsString, Connection.Connection);
      DoFieldOnChange(Dataset.FindField('CustomerID'));
    end;
  end
  else If sysutils.SameText(Sender.FieldName, 'BillCustomerID') Then Begin
    BillCustomerName := BillCustomer.ClientName;
    BilltoAddress := BillCustomer.BillingAddress;
    BillClientPrintName:= BillCustomer.Printname;
    if BilltoAddress = '' then
      BilltoAddress := BillCustomer.ShipToAddress;
    Terms := BillCustomer.TermsName;
    TermsID := BillCustomer.TermsID;
  end
  else If sysutils.SameText(Sender.FieldName, 'BillCustomerName') Then Begin
    If BillCustomerName = '' Then
      BillCustomerID := 0
    else begin
      BillCustomerID := TCustomer.IDToggle(Sender.AsString, Connection.Connection);
      DoFieldOnChange(Dataset.FindField('BillCustomerID'));
    end;
  end
  else if sysutils.SameText(Sender.FieldName, 'EmployeeName') Then Begin
    EmployeeId := TEmployee.IDToggle(EmployeeName, Connection.Connection);
  end
  else if sysutils.SameText(Sender.FieldName, 'EmployeeID') Then Begin
    EmployeeName := TEmployee.IDToggle(EmployeeId, Connection.Connection);
  end
  else if sysutils.SameText(Sender.FieldName, 'ClassName') then begin
    DepartmentID := TDeptClass.IDToggle(DepartmentName, Connection.Connection);
  end
  else if sysutils.SameText(Sender.FieldName, 'ClassID') then begin
    DepartmentName := TDeptClass.IDToggle(DepartmentID, Connection.Connection);
  end
  else If sysutils.SameText(Sender.FieldName, 'TermsID') Then Begin
    Terms := TTerms.IDToggle(TermsID, Connection.Connection);
  end
  else If sysutils.SameText(Sender.FieldName, 'Terms') Then Begin
    TermsID := TTerms.IDToggle(Terms, Connection.Connection);
  end
  else If sysutils.SameText(Sender.FieldName, 'UseBillCust') Then Begin
    if not UseBillCust then begin
      BillCustomerID := CustomerID;
      DoFieldOnChange(Dataset.FindField('BillCustomerID'));
    end;
  end
  else If sysutils.SameText(Sender.FieldName, 'ShipAddressID') Then Begin
    ShipToAddress := ShippingAddressObj.AddressAsString;
  End;
end;

function THire.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function THire.GetIDField: string;
begin
  Result := 'HireID'
end;

class function THire.GetKeyStringField: string;
begin
  Result := 'Globalref';
end;

class function THire.GetBusObjectTablename: string;
begin
  Result := 'tblhire';
end;

function THire.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then
    exit;

  Status := 'Q';
  CreatedDate := Date;
  HireDate := Date;
  EmployeeId := Appenv.Employee.EmployeeId;
  DepartmentID := Appenv.DefaultClass.ClassID;
end;

function THire.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function THire.DoCalcFields(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoCalcFields(Sender);
  if not Result then
    exit;
  TotalAmount := Hiretotal + SalesTotal;
end;

function THire.getShippingAddressObj: TShippingAddress;
begin
  Result := TShippingAddress(getcontainercomponent(TShippingAddress,
    'ShipAddressID = ' + IntToStr(ShipAddressID), True, True));
end;

{ Property Functions }
function THire.GetCreatedDate: TDateTime;
begin
  Result := GetDateTimeField('CreatedDate');
end;

function THire.GetHireDate: TDateTime;
begin
  Result := GetDateTimeField('HireDate');
end;

function THire.GetCustomerID: Integer;
begin
  Result := GetIntegerField('CustomerID');
end;

function THire.GetShipAddressID: Integer;
begin
  Result := GetIntegerField('ShipAddressID');
end;

function THire.GetBillCustomerID: Integer;
begin
  Result := GetIntegerField('BillCustomerID');
end;

function THire.getUseBillCust: Boolean;
begin
  Result := GetBooleanField('UseBillCust');
end;

function THire.GetConverted: Boolean;
begin
  Result := GetBooleanField('Converted');
end;

function THire.GetEmployeeId: Integer;
begin
  Result := GetIntegerField('EmployeeID');
end;

function THire.GetBilltoAddress: string;
begin
  Result := GetStringField('BilltoAddress');
end;

function THire.GetShipToAddress: string;
begin
  Result := GetStringField('ShipToAddress');
end;

function THire.GetCustomerName: string;
begin
  Result := GetStringField('CustomerName');
end;
function THire.GetClientPrintName: string;
begin
  Result := GetStringField('ClientPrintName');
end;

function THire.GetCustomerPONumber: string;
begin
  Result := GetStringField('CustomerPONumber');
end;

function THire.GetDefaultActualDurationQty: double;
begin
  result := GetFloatField('DefaultActualDurationQty');
end;

function THire.GetDefaultActualDurationId: integer;
begin
  result := GetIntegerField('DefaultActualDuratiopnId');
end;

function THire.GetDefaultActualHireFrom: TDateTime;
begin
  result := GetDateTimeField('DefaultActualHireFrom');
end;

function THire.GetDefaultActualHireTo: TDateTime;
begin
  result := GetDateTimeField('DefaultActualHireTo');
end;

function THire.GetDefaultDurationQty: double;
begin
  result := GetFloatField('DefaultDurationQty');
end;

function THire.GetDefaultDurationId: integer;
begin
  result := GetIntegerField('DefaultDurationId');
end;

function THire.GetDefaultHireFrom: TDateTime;
begin
  result := GetDateTimeField('DefaultHireFrom');
end;

function THire.GetDefaultHireTo: TDateTime;
begin
  result := GetDateTimeField('DefaultHireTo');
end;

function THire.GetDeleted: boolean;
begin
  result := GetBooleanField('Deleted');
end;

function THire.GetBillCustomerName: string;
begin
  Result := GetStringField('BillCustomerName');
end;
function THire.GetBillClientPrintName: string;
begin
  Result := GetStringField('BillClientPrintName');
end;

function THire.GetClassname: string;
begin
  Result := GetStringField('Classname');
end;

function THire.GetEmployeeName: string;
begin
  Result := GetStringField('EmployeeName');
end;

function THire.GetContactID: Integer;
begin
  Result := GetIntegerField('ContactID');
end;

function THire.GetClassID: Integer;
begin
  Result := GetIntegerField('ClassID');
end;

function THire.GetHiretotal: Double;
begin
  Result := GetFloatField('Hiretotal');
end;

function THire.GetSalesTotal: Double;
begin
  Result := GetFloatField('SalesTotal');
end;

function THire.GetTotalAmount: Double;
begin
  Result := GetFloatField('TotalAmount');
end;

function THire.GetNotes: string;
begin
  Result := GetStringField('Notes');
end;

function THire.GetStatus: string;
begin
  Result := GetStringField('Status');
end;

function THire.GetTermsID: Integer;
begin
  Result := GetIntegerField('TermsID');
end;

function THire.GetTerms: string;
begin
  Result := GetStringField('Terms');
end;

procedure THire.SetCreatedDate(const Value: TDateTime);
begin
  SetDateTimeField('CreatedDate', Value);
end;

procedure THire.SetHireDate(const Value: TDateTime);
begin
  SetDateTimeField('HireDate', Value);
end;

procedure THire.SetCustomerID(const Value: Integer);
begin
  SetIntegerField('CustomerID', Value);
end;

procedure THire.SetShipAddressID(const Value: Integer);
begin
  SetIntegerField('ShipAddressID', Value);
end;

procedure THire.SetUseBillCust(const Value: Boolean);
begin
  SetBooleanField('UseBillCust', Value);
end;

procedure THire.SetConverted(const Value: Boolean);
begin
  SetBooleanField('Converted', Value);
end;

procedure THire.SetBillCustomerID(const Value: Integer);
begin
  SetIntegerField('BillCustomerID', Value);
end;

procedure THire.SetEmployeeId(const Value: Integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

procedure THire.SetBilltoAddress(const Value: string);
begin
  SetStringField('BilltoAddress', Value);
end;

procedure THire.SetShipToAddress(const Value: string);
begin
  SetStringField('ShipToAddress', Value);
end;

procedure THire.SetCustomerName(const Value: string);
begin
  SetStringField('CustomerName', Value);
end;
procedure THire.SetClientPrintName(const Value: string);
begin
  SetStringField('ClientPrintName', Value);
end;

procedure THire.SetCustomerPONumber(const Value: string);
begin
  SetStringField('CustomerPONumber', Value);
end;

procedure THire.SetDefaultActualDurationQty(const Value: double);
begin

end;

procedure THire.SetDefaultActualDurationId(const Value: integer);
begin
  SetIntegerField('DefaultActualDuratiopnId',Value);
end;

procedure THire.SetDefaultActualHireFrom(const Value: TDateTime);
begin
  SetDateTimeField('DefaultActualHireFrom',Value);
end;

procedure THire.SetDefaultActualHireTo(const Value: TDateTime);
begin
  SetDateTimeField('DefaultActualHireTo',Value);
end;

procedure THire.SetDefaultDurationQty(const Value: double);
begin
  SetFloatField('DefaultDurationQty',Value);
end;

procedure THire.SetDefaultDurationId(const Value: integer);
begin
  SetIntegerField('DefaultDurationId',Value);
end;

procedure THire.SetDefaultHireFrom(const Value: TDateTime);
begin
  SetDateTimeField('DefaultHireFrom',Value);
end;

procedure THire.SetDefaultHireTo(const Value: TDateTime);
begin
  SetDateTimeField('DefaultHireTo',Value);
end;

procedure THire.SetDeleted(const Value: boolean);
begin
  SetBooleanField('Deleted',Value);
end;

procedure THire.SetBillCustomerName(const Value: string);
begin
  SetStringField('BillCustomerName', Value);
end;
procedure THire.SetBillClientPrintName(const Value: string);
begin
  SetStringField('BillClientPrintName', Value);
end;

procedure THire.SetClassname(const Value: string);
begin
  SetStringField('Classname', Value);
end;

procedure THire.SetEmployeeName(const Value: string);
begin
  SetStringField('EmployeeName', Value);
end;

procedure THire.SetContactID(const Value: Integer);
begin
  SetIntegerField('ContactID', Value);
end;

procedure THire.SetClassID(const Value: Integer);
begin
  SetIntegerField('ClassID', Value);
end;

procedure THire.SetHiretotal(const Value: Double);
begin
  SetFloatField('Hiretotal', Value);
end;

procedure THire.SetSalesTotal(const Value: Double);
begin
  SetFloatField('SalesTotal', Value);
end;

procedure THire.SetTotalAmount(const Value: Double);
begin
  SetFloatField('TotalAmount', Value);
end;

procedure THire.SetNotes(const Value: string);
begin
  SetStringField('Notes', Value);
end;

procedure THire.SetStatus(const Value: string);
begin
  SetStringField('Status', Value);
end;

procedure THire.SetTermsID(const Value: Integer);
begin
  SetIntegerField('TermsID', Value);
end;

procedure THire.SetTerms(const Value: string);
begin
  SetStringField('Terms', Value);
end;

function THire.GetCustomer: TCustomer;
var
  strSQL: String;
begin
  if (Self.CustomerID > 0) then
    strSQL := 'ClientId = ' + IntToStr(Self.CustomerID)
  else if (Self.CustomerName <> '') then
    strSQL := 'Company = ' + QuotedStr(Self.CustomerName);
  Result := TCustomer(getcontainercomponent(TCustomer, strSQL, True, True, True, '', True));
  Result.BusObjEvent := Self.BusObjEvent;
end;

function THire.GetBillCustomer: TCustomer;
var
  strSQL: String;
begin
  if (Self.BillCustomerID > 0) then
    strSQL := 'ClientId = ' + IntToStr(Self.BillCustomerID)
  else if (Self.BillCustomerName <> '') then
    strSQL := 'Company = ' + QuotedStr(Self.BillCustomerName);
  Result := TCustomer(getcontainercomponent(TCustomer, strSQL, True, True, True, '', True));
  Result.BusObjEvent := Self.BusObjEvent;
end;

function THire.getCleanDepartmentID: Integer;
begin
  Result := GetXMLNodeIntegerValue(CleanXMLNOde, 'DepartmentID');
end;

function THire.getHireLines: THireLines;
begin
  Result := THireLines(getcontainercomponent(THireLines, 'HireID = ' + IntToStr(Id)));
end;

function THire.getHirePartsSale: THirePartsSale;
begin
  Result := THirePartsSale(getcontainercomponent(THirePartsSale, 'HireID = ' + IntToStr(Id)));
end;

function THire.CopyToInvoice: Integer;
begin
  salesObj := TInvoice.Create(Self);
  try
    Result := copysales;
  finally
    Freeandnil(salesObj);
  end;
end;

function THire.copysales: Integer;
begin
  Result := 0;
  try
    if not(HasEquipmenttoconvert) and not(HaveSaleProductToConvert) then
      if not silentMode then
        if MessageDlgXP_vista('This is Already Converted. Do you Want to Convert it Again?',
          mtWarning, [mbYes, mbNo], 0) = mrNo then
          exit;

    salesObj.Connection := Self.Connection;
    salesObj.Connection.beginTransaction;
    try
      salesObj.load(0);
      salesObj.New;
      salesObj.ConvertingRepairs := True;
      if salesObj is TCashSale then
        salesObj.PayMethod := PAY_CASH;
      salesObj.CustomerName := Self.CustomerName;
      salesObj.ClientPrintName := Self.ClientPrintName;
      salesObj.ShipToDesc := Self.ShipToAddress;
      salesObj.InvoiceToDesc := Self.BilltoAddress;
      salesObj.ShipToID := Self.ShipAddressID;
      salesObj.SaleClassName := Self.DepartmentName;
      salesObj.HireGlobalref := Self.GlobalRef;
      salesObj.TermsName := Self.Terms;
      salesObj.PostDB;
      HireLines.IterateRecords(CopytoSales);
      HirePartsSale.IterateRecords(CopytoSales);
      salesObj.CalcOrderTotals;
      if salesObj.Save Then begin
        Result := salesObj.Id;
        Self.Converted := True;
        if (Self.Status <> 'O') and (Self.Status <> 'R') then
          Status := 'O';
        PostDB;
        salesObj.Connection.CommitTransaction;
        Dirty := False;
        exit;
      end;
      salesObj.Connection.RollbackTransaction;
    Except
      on E: Exception do begin
        salesObj.Connection.RollbackTransaction;
      end;
    end;
  finally
  end;
end;

Procedure THire.CopytoSales(Const Sender: TBusObj; var Abort: Boolean);
begin
  if Sender is THireLines then begin
    salesObj.Lines.New;
    salesObj.Lines.ProductName := PART_HIRE;
    salesObj.Lines.ProductDescription := 'Hire ' +
      THireLines(Sender).AssetName + ' for ' +
      FloatToStrF(THireLines(Sender).DurationQty, ffGeneral, 15, 2) + ' ' + THireLines(Sender)
      .DurationName + '(' + FloatToStrF(THireLines(Sender).Duration.Qty, ffGeneral, 15, 2) + ' ' +
      Durationdesc(THireLines(Sender).Duration.DurationType) + ')' + ' @ ' +
      FloatToStrF(THireLines(Sender).DurationRate, ffcurrency, 15, 2) + ' / ' + THireLines(Sender)
      .DurationName;
    salesObj.Lines.UnitOfMeasure := THireLines(Sender).UOM;
    salesObj.Lines.UnitOfMeasureID := THireLines(Sender).UOMID;
    salesObj.Lines.UOMMultiplier := THireLines(Sender).UOMMult;
    salesObj.Lines.UOMQtySold := 1;
    salesObj.Lines.UOMQtyShipped := 1;
    salesObj.Lines.LinePrice := THireLines(Sender).PriceEx * THireLines(Sender).DurationQty;
    salesObj.Lines.LineTaxCode := THireLines(Sender).LineTaxCode;
    salesObj.Lines.LineTaxRate := THireLines(Sender).LineTaxRate;
    salesObj.Lines.HireLineId := THireLines(Sender).Id;
    if THireLines(Sender).IncomeAccountId > 0 then
      salesObj.Lines.IncomeAccount := TAccount.IDToggle(THireLines(Sender).IncomeAccountId);
    salesObj.Lines.PostDB;
    salesObj.Lines.CalcLinetotals;
    THireLines(Sender).Converted := True;
    if THireLines(Sender).ActualHirefrom = 0 then
      THireLines(Sender).ActualHirefrom := THireLines(Sender).HireFrom;
    if THireLines(Sender).ActualHireTo = 0 then
      THireLines(Sender).ActualHireTo := THireLines(Sender).HireTo;
    THireLines(Sender).PostDB;
  end
  else if Sender is THirePartsSale then begin
    salesObj.Lines.New;
    salesObj.Lines.ProductName := THirePartsSale(Sender).ProductName;
    salesObj.Lines.ProductDescription := 'Sale :' + THirePartsSale(Sender).Description;
    salesObj.Lines.UnitOfMeasure := THirePartsSale(Sender).UnitOfMeasure;
    salesObj.Lines.UnitOfMeasureID := THirePartsSale(Sender).UnitOfMeasureID;
    salesObj.Lines.UOMMultiplier := THirePartsSale(Sender).UnitofMeasureMultiplier;
    salesObj.Lines.UOMQtySold := THirePartsSale(Sender).UOMQty;
    salesObj.Lines.UOMQtyShipped := THirePartsSale(Sender).UOMQty;
    salesObj.Lines.LinePrice := THirePartsSale(Sender).PriceEx;
    salesObj.Lines.LineTaxCode := THirePartsSale(Sender).TaxCode;
    salesObj.Lines.LineTaxRate := THirePartsSale(Sender).TaxRate;
    salesObj.Lines.HirePartsSaleID := THirePartsSale(Sender).Id;
    salesObj.Lines.PostDB;
    salesObj.Lines.CalcLinetotals;
    THirePartsSale(Sender).Converted := True;
    THirePartsSale(Sender).PostDB;
  end;
end;

procedure THire.CalculateHireTotals;
begin
  fdSalestotal := 0;
  fdHiretotal := 0;
  HireLines.IterateRecords(CalculateHireTotalsCallback);
  HirePartsSale.IterateRecords(CalculateHireTotalsCallback);
  SalesTotal := fdSalestotal;
  Hiretotal := fdHiretotal;
  PostDB;
end;

Procedure THire.CalculateHireTotalsCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
  if Sender is THireLines then begin
    if not THireLines(Sender).Deleted then
      fdHiretotal := fdHiretotal + THireLines(Sender).LineAmountInc;
  end
  else if Sender is THirePartsSale then begin
    fdSalestotal := fdSalestotal + THirePartsSale(Sender).LineTotalInc;
  end;
end;

function THire.CopyToCashsale: Integer;
begin
  salesObj := TCashSale.Create(Self);
  try
    Result := copysales;
  finally
    Freeandnil(salesObj);
  end;

end;

function THire.CopyTosaleSOrder: Integer;
begin
  salesObj := TSalesOrder.Create(Self);
  try
    Result := copysales;
  finally
    Freeandnil(salesObj);
  end;

end;

procedure THire.CopytoSmartOrderCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if Sender is THirePartsSale then begin
    SmartOrder.Lines.New;
    SmartOrder.Lines.ProductName := THirePartsSale(Sender).ProductName;
    SmartOrder.Lines.PODesc := THirePartsSale(Sender).Description;
    SmartOrder.Lines.UnitOfMeasure := THirePartsSale(Sender).UnitOfMeasure;
    SmartOrder.Lines.UnitOfMeasureID := THirePartsSale(Sender).UnitOfMeasureID;
    SmartOrder.Lines.UOMMultiplier := THirePartsSale(Sender).UnitofMeasureMultiplier;
    SmartOrder.Lines.ToPurchaseQty := THirePartsSale(Sender).UOMQty;
    SmartOrder.Lines.PostDB;
  end;
end;

function THire.CopyToSmartOrder: Integer;
begin

  SmartOrder := TSmartOrder.Create(Self);
  try
    Result := 0;

    SmartOrder.Connection := Self.Connection;
    SmartOrder.Connection.beginTransaction;
    try
      SmartOrder.load(0);
      SmartOrder.New;
      SmartOrder.SmartOrderDesc := 'From Hire # ' + IntToStr(Id);
      SmartOrder.HireGlobalref := GlobalRef;
      SmartOrder.PostDB;
      HirePartsSale.IterateRecords(CopytoSmartOrderCallback);
      if SmartOrder.Save Then begin
        Result := SmartOrder.Id;
        SmartOrder.Connection.CommitTransaction;
        Self.PostDB;
        Self.Dirty := False;
        if Result > 0 then
          MessageDlgXP_vista(SmartOrder.XMLNodeName + ' # ' + IntToStr(SmartOrder.Id) +
            ' is created.', mtInformation, [mbOK], 0);
        exit;
      end;
      SmartOrder.Connection.RollbackTransaction;
    Except
      on E: Exception do begin
        SmartOrder.Connection.RollbackTransaction;
      end;
    end;

  finally
    Freeandnil(salesObj);
  end;

end;

{ THireLines }

procedure THireLines.CalcQtyandPriceFromDates(Actual: boolean);
var
  aQty: double;
begin
  if Actual then begin
    if (ActualHireFrom = 0) or (ActualHireTo = 0) then exit;
    self.DurationId := TAssetHire.CalcHireQty(ActualHireFrom,ActualHireTo,THirePricingLine.DurationIdListForAsset(AssetId,Connection.Connection),aQty);
  end
  else begin
    if (HireFrom = 0) or (HireTo = 0) then exit;
    self.DurationId := TAssetHire.CalcHireQty(HireFrom,HireTo,THirePricingLine.DurationIdListForAsset(AssetId,Connection.Connection),aQty);
  end;
  DurationName := TDuration.IDToggle(DurationId, Connection.Connection);
  AddEvent(BusObjEvent_Change, BusObjEventVal_Duration, Id, Self);

  self.DurationQty := aQty;
  self.DurationRate := THirePricingLine.RateForAssetAndDuration(AssetId,DurationID,Connection.Connection);
  self.PriceEx := self.DurationRate;
  self.CalcLinetotals;
end;

procedure THireLines.CalculateHireTotals;
begin
  if Assigned(Owner) then
    if Owner is THire then
      THire(Owner).CalculateHireTotals;
end;

procedure THireLines.ClonePropertyObjects;
begin
  inherited;

end;

constructor THireLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'HireLines';
  fSQL := 'SELECT * FROM tblhirelines';
end;

procedure THireLines.CreateInstance;
begin
  inherited;
  if Owner is THire then
    if Assigned(THire(Owner).ObjInstanceToClone) then
      if THire(Owner).ObjInstanceToClone is THire then
        ObjInstanceToClone := THire(THire(Owner).ObjInstanceToClone).HireLines
      else if THire(Owner).ObjInstanceToClone is TInvoice then
        ObjInstanceToClone := TInvoice(THire(Owner).ObjInstanceToClone).Lines
      else if THire(Owner).ObjInstanceToClone is TSalesOrder then
        ObjInstanceToClone := TSalesOrder(THire(Owner).ObjInstanceToClone).Lines;
end;

function THireLines.Delete: boolean;
begin
  result := AssetLines.DeleteAll;
  if not result then
    exit;
  result := inherited;
end;

destructor THireLines.Destroy;
begin
  inherited;
end;

procedure THireLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'HireID');
  SetPropertyFromNode(node, 'EmployeeName');
  SetPropertyFromNode(node, 'ProductID');
  SetPropertyFromNode(node, 'ProductName');
  SetPropertyFromNode(node, 'DurationId');
  SetPropertyFromNode(node, 'DurationName');
  SetPropertyFromNode(node, 'DurationRate');
  SetPropertyFromNode(node, 'DurationQty');
  SetPropertyFromNode(node, 'UOMID');
  SetPropertyFromNode(node, 'UOM');
  SetDateTimePropertyFromNode(node, 'HireFrom');
  SetDateTimePropertyFromNode(node, 'ActualHirefrom');
  SetDateTimePropertyFromNode(node, 'HireTo');
  SetDateTimePropertyFromNode(node, 'ActualHireTo');
  SetPropertyFromNode(node, 'Status');
  SetPropertyFromNode(node, 'LineAmount');
  SetPropertyFromNode(node, 'LineTaxCode');
  SetPropertyFromNode(node, 'LineTaxRate');
  SetPropertyFromNode(node, 'LineAmountInc');
  SetPropertyFromNode(node, 'PriceEx');
  SetPropertyFromNode(node, 'PriceInc');
  SetPropertyFromNode(node, 'UOMMult');
  SetPropertyFromNode(node, 'HireQty');
  SetBooleanPropertyFromNode(node, 'Deleted');
  SetBooleanPropertyFromNode(node, 'Converted');
  SetPropertyFromNode(node, 'AssetId');
  SetPropertyFromNode(node, 'AssetName');

end;

procedure THireLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'HireID', HireID);
  AddXMLNode(node, 'EmployeeId', EmployeeId);
  AddXMLNode(node, 'EmployeeName', EmployeeName);
  AddXMLNode(node, 'ProductID', ProductID);
  AddXMLNode(node, 'ProductName', ProductName);
  AddXMLNode(node, 'DurationId', DurationId);
  AddXMLNode(node, 'DurationName', DurationName);
  AddXMLNode(node, 'DurationRate', DurationRate);
  AddXMLNode(node, 'DurationQty', DurationQty);
  AddXMLNode(node, 'UOMID', UOMID);
  AddXMLNode(node, 'UOM', UOM);
  AddXMLNode(node, 'HireFrom', HireFrom);
  AddXMLNode(node, 'ActualHirefrom', ActualHirefrom);
  AddXMLNode(node, 'HireTo', HireTo);
  AddXMLNode(node, 'ActualHireTo', ActualHireTo);
  AddXMLNode(node, 'Status', Status);
  AddXMLNode(node, 'LineAmount', LineAmount);
  AddXMLNode(node, 'LineTaxCode', LineTaxCode);
  AddXMLNode(node, 'LineTaxRate', LineTaxRate);
  AddXMLNode(node, 'LineAmountInc', LineAmountInc);
  AddXMLNode(node, 'PriceEx', PriceEx);
  AddXMLNode(node, 'PriceInc', PriceInc);
  AddXMLNode(node, 'UOMMult', UOMMult);
  AddXMLNode(node, 'HireQty', HireQty);
  AddXMLNode(node, 'Deleted', Deleted);
  AddXMLNode(node, 'Converted', Converted);
  AddXMLNode(node, 'AssetId', AssetId);
  AddXMLNode(node, 'AssetName', AssetName);
end;

function THireLines.ValidateData: Boolean;
begin
  Result := inherited ValidateData;
  if not Result then
    exit;
  if not Deleted then begin
    if (HireFrom = 0) or (HireTo = 0) then begin
      Resultstatus.AddItem(False, rssWarning, 0, 'Please Choose the Date Range');
      Result := False;
      exit;
    end;
    if (self.AssetLines.Count <> HireQty) then begin
      Resultstatus.AddItem(False, rssWarning, 0, 'Hire Qty does not match Quantity of Items');
      Result := False;
      exit;
    end;
  end;
end;

function THireLines.Save: Boolean;
begin
  Result := False;
  if not ValidateData then
    exit;
  Result := inherited Save;
end;

procedure THireLines.OnBeforeDataIdChange;
begin
  inherited;
end;

procedure THireLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure THireLines.DoFieldOnChange(Sender: TField);
var
  DurID: integer;
  DurQty: double;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then
      exit; // we are only interested in data fields.
  inherited;
  if sysutils.SameText(Sender.FieldName, 'EmployeeName') Then Begin
    EmployeeId := TEmployee.IDToggle(EmployeeName, Connection.Connection);
  end
  else if sysutils.SameText(Sender.FieldName, 'EmployeeID') Then Begin
    EmployeeName := TEmployee.IDToggle(EmployeeId, Connection.Connection);
  end
  else if sysutils.SameText(Sender.FieldName, 'AssetName') Then Begin
    AssetId := -1;
  end
  else if sysutils.SameText(Sender.FieldName, 'AssetID') Then Begin
    AssetName := TFixedAssets.AssetNameForId(AssetId, Connection.Connection);
    AssetCode := TFixedAssets.AssetCodeForID(AssetID, Connection.Connection);
    ProductName := TAssetHire.HireProductForAssetId(AssetId, Connection.Connection);
    ProductId := TProduct.IDToggle(ProductName,Connection.Connection);
    Deleted := false;
    InitUOM(Product.UOMSales, '');
    LineTaxCode := Product.TaxCodeSales;
    DoFieldOnChange(Dataset.FindField('LineTaxCode'));
    SendEvent(BusObjEvent_Change, BusObjEventVal_ProductID, Self);
    { if we have defaults set them here .. }
    { .. first send notification to GUI so user can choose to add rates if they want }
    SendEvent(BusObjEvent_Change, BusObjEventVal_HireAssetID, Self);
    { get the default values for this hire }
    if (THire(Owner).DefaultActualHireFrom > 0) and (THire(Owner).DefaultActualHireTo > 0) then begin
      DurId := THire(Owner).DefaultActualDurationId;
      DurQty := THire(Owner).DefaultActualDurationQty;
    end
    else begin
      DurId := THire(Owner).DefaultDurationId;
      DurQty := THire(Owner).DefaultDurationQty;
    end;
    HireFrom := THire(Owner).DefaultHireFrom;
    ActualHireFrom := THire(Owner).DefaultActualHireFrom;
    if TAssetHire.HasDurationPrice(AssetId,DurId, Connection.Connection) then begin
      DurationID := DurId;
      DurationName := TDuration.IDToggle(DurationId, Connection.Connection);
      DurationRate := THirePricingLine.RateForAssetAndDuration(AssetId,DurationID,Connection.Connection);
      PriceEx := self.DurationRate;
      DurationQty := DurQty;
      GetToDate;
      CalcLinetotals;
    end
    else begin
      HireTo := THire(Owner).DefaultHireTo;
      ActualHireTo := THire(Owner).DefaultActualHireTo;
    end;
    if HireFrom > 0 then
      HireFromTime := FormatDateTime('hh:nn AM/PM', HireFrom);
    if HireTo > 0 then
      HireToTime := FormatDateTime('hh:nn AM/PM', HireTo);
    if ActualHireFrom > 0 then
      ActualHireFromTime := FormatDateTime('hh:nn AM/PM', ActualHireFrom);
    if ActualHireTo > 0 then
      ActualHireToTime := FormatDateTime('hh:nn AM/PM', ActualHireTo);

    SelectAssets;
    CalcLinetotals;
  end
  else if sysutils.SameText(Sender.FieldName, 'LineTaxCode') Then Begin
    LineTaxRate := TaxObj.Rate;
  end
  else If sysutils.SameText(Sender.FieldName, 'Hirefrom') Then Begin
    if HireFrom <> 0 then begin
      HireFromtime := formatDatetime('hh:nn AM/PM', HireFrom);
    end;
    if not Planner then
    begin
      AssetLines.DeleteAll;
      SelectAssets;
    end;
    CalcQtyandPriceFromDates(false);
  end
  else If sysutils.SameText(Sender.FieldName, 'Hireto') Then Begin
    if HireTo <> 0 then begin
      HireTotime := formatDatetime('hh:nn AM/PM', HireTo);
    end;
    if not Planner then
    begin
      AssetLines.DeleteAll;
      SelectAssets;
    end;
    CalcQtyandPriceFromDates(false);
  end
  else If sysutils.SameText(Sender.FieldName, 'ActualHireFrom') Then Begin
    if ActualHirefrom <> 0 then begin
      ActualHireFromTime := formatDatetime('hh:nn AM/PM', ActualHirefrom);
    end;
    if not Planner then
    begin
      AssetLines.DeleteAll;
      SelectAssets;
    end;
    CalcQtyandPriceFromDates(true);
  end
  else If sysutils.SameText(Sender.FieldName, 'ActualHireTo') Then Begin
    if ActualHireTo <> 0 then begin
      ActualHireToTime := formatDatetime('hh:nn AM/PM', ActualHireTo);
    end;
    if not Planner then
    begin
      AssetLines.DeleteAll;
      SelectAssets;
    end;
    CalcQtyandPriceFromDates(true);
  end
  else If sysutils.SameText(Sender.FieldName, 'Status') Then Begin
    SendEvent(BusObjEvent_Change, BusObjEventVal_status, Self);
  end
  else If sysutils.SameText(Sender.FieldName, 'DurationID') Then Begin
    DurationName := TDuration.IDToggle(DurationId, Connection.Connection);
    GetToDate;
    AddEvent(BusObjEvent_Change, BusObjEventVal_Duration, Id, Self);
    self.DurationRate := THirePricingLine.RateForAssetAndDuration(AssetId,DurationID,Connection.Connection);
    self.PriceEx := self.DurationRate;
    self.CalcLinetotals;
  end
  else If sysutils.SameText(Sender.FieldName, 'DurationQty') Then Begin
    if DurationQty <= 0 then
      DurationQty := 1;
    GetToDate;
    CalcLinetotals;
    if AssetLines.Count = 0 then
      SelectAssets;
  end
  else If sysutils.SameText(Sender.FieldName, 'DurationRate') Then Begin
    PriceEx := DurationRate;
    CalcLinetotals;
  end
  else If sysutils.SameText(Sender.FieldName, 'Converted') Then Begin
    if Converted then begin
      if ActualHirefrom = 0 then
        ActualHirefrom := HireFrom;
      if ActualHireTo = 0 then
        ActualHireTo := HireTo;
    end;
  end
  else If sysutils.SameText(Sender.FieldName, 'HireFromtime') then begin
    HireFrom := DateOf(HireFrom) + ValidStrToTime(HireFromtime);
    CalcQtyandPriceFromDates(false);
  end
  else If sysutils.SameText(Sender.FieldName, 'HireTotime') then begin
    HireTo := DateOf(HireTo) + ValidStrToTime(HireTotime);
    CalcQtyandPriceFromDates(false);
  end
  else If sysutils.SameText(Sender.FieldName, 'ActualHireFromTime') then begin
    ActualHirefrom := DateOf(ActualHirefrom) + ValidStrToTime(ActualHireFromTime);
    CalcQtyandPriceFromDates(true);
  end
  else If sysutils.SameText(Sender.FieldName, 'ActualHireToTime') then begin
    ActualHireTo := DateOf(ActualHireTo) + ValidStrToTime(ActualHireToTime);
    CalcQtyandPriceFromDates(true);
  end
  else If sysutils.SameText(Sender.FieldName, 'Deleted') Then Begin
    CalcLinetotals;
  end
  else if sysutils.SameText(Sender.FieldName, 'HireQty') then begin
//   if not SelectAssets then
//     exit;
   DurQty := HireQty;
   SelectAssets;
   if DurQty <> HireQty then
     exit;
   CalcLinetotals;
  end;
end;

procedure THireLines.GetToDate;
begin
  if (DurationName <> '') and (DurationQty <> 0) then begin
    if HireFrom <> 0 then begin
      HireTo := TAssetHire.CalcHireToDate(HireFrom,DurationId,DurationQty,Connection.Connection);
      HireTotime := formatDatetime('hh:nn AM/PM', HireTo);
    end;
    if ActualHirefrom <> 0 then begin
      ActualHireTo := TAssetHire.CalcHireToDate(ActualHireFrom,DurationId,DurationQty,Connection.Connection);
      ActualHireToTime := formatDatetime('hh:nn AM/PM', ActualHireTo);
    end;
  end;
  PostDB;
end;

procedure THireLines.CalcLinetotals;
begin
  if (Id = 0) or (AssetID = 0) then
    exit;
  PriceInc := GetAmountInc(PriceEx, LineTaxRate);
  LineAmount := PriceEx * HireQty * DurationQty;
  LineAmountInc := PriceInc * HireQty * DurationQty;
  PostDB;
  CalculateHireTotals;
end;

function THireLines.GetSerialnos: String;
begin
  Result := '';
end;

function THireLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function THireLines.GetIDField: string;
begin
  Result := 'HireLineID'
end;

function THireLines.GetIncomeAccountId: Integer;
begin
  Result := GetIntegerField('IncomeAccountId');
end;

function THireLines.GetIsPQAItem: Boolean;
begin
  result := false;
end;

procedure THireLines.GetBaseLinePrice;
begin
  //
end;

function THireLines.GetBOQty: Double;
begin
  Result := 0;
end;

function THireLines.GetBOUOMQty: Double;
begin
  Result := 0;
end;

class function THireLines.GetBusObjectTablename: string;
begin
  Result := 'tblhirelines';
end;

function THireLines.GetClassID: Integer;
begin
  Result := 0;
  if Assigned(Self.Owner) then
    if Self.Owner is THire then
      Result := THire(Self.Owner).DepartmentID;
end;

function THireLines.GetCleanClassID: Integer;
begin
  Result := 0;
  if Assigned(Self.Owner) then
    if Self.Owner is THire then
      Result := THire(Self.Owner).CleanDepartmentID;
end;

function THireLines.GetcleanProductId: Integer;
begin
  Result := GetXMLNodeIntegerValue(CleanXMLNOde, 'ProductID');
end;

function THireLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then
    exit;

  if Assigned(Owner) then
    if Owner is THire then begin
      HireID := THire(Owner).Id;
      EmployeeId := THire(Owner).EmployeeId;
    end;
  HireQty := 1;
  (*   HireUOMQty := 1; *)
end;

function THireLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function THireLines.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
var
  fPQA: TPQA;
begin
  Result := inherited DoBeforeDelete(Sender);
  if not Result then
    exit;

  if IsPQAItem then begin
    fPQA := HireReturnPQA;
    if Assigned(fPQA) then
      fPQA.deleteall;
  end;

end;

function THireLines.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeInsert(Sender);
  if not Result then
    exit;
  if (Id <> 0) and (AssetID = 0) and ((ProductID = 0)) then begin
    Deleted := True;
    PostDB;
  end;
end;

function THireLines.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not Result then
    exit;
  if (AssetID = 0) and ((ProductID = 0)) then begin
    Deleted := True;
    Result := True;
    exit;
  end;
end;

function THireLines.DoCalcFields(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoCalcFields(Sender);
  if not Result then
    exit;
end;

function THireLines.getProduct: TProduct;
begin
  //Result := TProduct(getcontainercomponent(TProduct, 'PartsID = ' + IntToStr(ProductID)));
  Result := TProduct(getContainerComponent(TProduct, ProductID,'PartsID' ));
end;

{ Property Functions }
function THireLines.GetHireID: Integer;
begin
  Result := GetIntegerField('HireID');
end;

function THireLines.GetHireProductId: integer;
begin
  result := GetIntegerField('HireProductId');
end;

function THireLines.GetHireProductName: string;
begin
  result := GetStringField('HireProductName');
end;
function THireLines.GetHireProductPrintName: string;
begin
  result := GetStringField('HireProductPrintName');
end;

function THireLines.GetEmployeeId: Integer;
begin
  Result := GetIntegerField('EmployeeId');
end;

function THireLines.GetEmployeeName: string;
begin
  Result := GetStringField('EmployeeName');
end;

function THireLines.GetHireFromtime: string;
begin
  Result := GetStringField('HireFromtime');
end;

function THireLines.GetHireTotime: string;
begin
  Result := GetStringField('HireTotime');
end;

function THireLines.GetActualHireFromTime: string;
begin
  Result := GetStringField('ActualHireFromTime');
end;

function THireLines.GetActualHireToTime: string;
begin
  Result := GetStringField('ActualHireToTime');
end;

function THireLines.GetDurationId: Integer;
begin
  Result := GetIntegerField('DurationId');
end;

function THireLines.GetDurationName: string;
begin
  Result := GetStringField('DurationName');
end;

function THireLines.GetDurationRate: Double;
begin
  Result := GetFloatField('DurationRate');
end;

function THireLines.GetDurationQty: Double;
begin
  Result := GetFloatField('DurationQty');
end;

function THireLines.GetUOMID: Integer;
begin
  Result := GetIntegerField('UOMID');
end;

function THireLines.GetUOM: string;
begin
  Result := GetStringField('UOM');
end;

function THireLines.GetHireFrom: TDateTime;
begin
  Result := GetDateTimeField('HireFrom');
end;

function THireLines.GetActualHirefrom: TDateTime;
begin
  Result := GetDateTimeField('ActualHirefrom');
end;

function THireLines.GetHireTo: TDateTime;
begin
  Result := GetDateTimeField('HireTo');
end;

function THireLines.GetActualHireTo: TDateTime;
begin
  Result := GetDateTimeField('ActualHireTo');
end;

function THireLines.GetStatus: string;
begin
  Result := GetStringField('Status');
end;

function THireLines.GetLineAmount: Double;
begin
  Result := GetFloatField('LineAmount');
end;

function THireLines.GetLineTaxCode: string;
begin
  Result := GetStringField('LineTaxCode');
end;

function THireLines.GetLineTaxRate: Double;
begin
  Result := GetFloatField('LineTaxRate');
end;

function THireLines.GetLineAmountInc: Double;
begin
  Result := GetFloatField('LineAmountInc');
end;

function THireLines.GetPriceEx: Double;
begin
  Result := GetFloatField('PriceEx');
end;

function THireLines.GetPriceInc: Double;
begin
  Result := GetFloatField('PriceInc');
end;

function THireLines.GetDeleted: Boolean;
begin
  Result := GetBooleanField('Deleted');
end;

function THireLines.GetConverted: Boolean;
begin
  Result := GetBooleanField('Converted');
end;

function THireLines.GetUOMMult: Double;
begin
  Result := GetFloatField('UOMMult');
  if Result = 0 then
    Result := 1;
end;

function THireLines.GetHireQty: Double;
begin
  Result := GetFloatField('HireQty');
end;

procedure THireLines.SetHireID(const Value: Integer);
begin
  SetIntegerField('HireID', Value);
end;

procedure THireLines.SetHireProductId(const Value: integer);
begin
SetIntegerField('HireProductId', Value);
end;

procedure THireLines.SetHireProductName(const Value: string);
begin
  SetStringField('HireProductName', Value);
end;
procedure THireLines.SetHireProductPrintName(const Value: string);
begin
  SetStringField('HireProductPrintName', Value);
end;

procedure THireLines.SetEmployeeId(const Value: Integer);
begin
  SetIntegerField('EmployeeId', Value);
end;

procedure THireLines.SetEmployeeName(const Value: string);
begin
  SetStringField('EmployeeName', Value);
end;

procedure THireLines.SetHireFromtime(const Value: string);
begin
  SetStringField('HireFromtime', Value);
end;

procedure THireLines.SetHireTotime(const Value: string);
begin
  SetStringField('HireTotime', Value);
end;

procedure THireLines.SetActualHireFromTime(const Value: string);
begin
  SetStringField('ActualHireFromTime', Value);
end;

procedure THireLines.SetActualHireToTime(const Value: string);
begin
  SetStringField('ActualHireToTime', Value);
end;

procedure THireLines.SetAssetCode(const Value: string);
begin
  SetStringField('AssetCode',Value);
end;

procedure THireLines.SetAssetId(const Value: Integer);
begin
  SetIntegerField('AssetId', Value);
end;

procedure THireLines.SetAssetName(const Value: string);
begin
  SetStringField('AssetName', Value);
end;

procedure THireLines.SetDurationId(const Value: Integer);
begin
  SetIntegerField('DurationId', Value);
end;

procedure THireLines.SetDurationName(const Value: string);
begin
  SetStringField('DurationName', Value);
end;

procedure THireLines.SetDurationRate(const Value: Double);
begin
  SetFloatField('DurationRate', Value);
end;

procedure THireLines.SetDurationQty(const Value: Double);
begin
  SetFloatField('DurationQty', Value);
end;

procedure THireLines.SetUOMID(const Value: Integer);
begin
  SetIntegerField('UOMID', Value);
end;

procedure THireLines.SetUOM(const Value: string);
begin
  SetStringField('UOM', Value);
end;

procedure THireLines.SetHireFrom(const Value: TDateTime);
begin
  SetDateTimeField('HireFrom', Value);
end;

procedure THireLines.SelectAssets;
var
  qry: TERPQuery;
  qryOnHire: TERPQuery;
  HireFromStr, HireToStr: string;
begin
  if Planner then exit;

  if not (((HireFrom > 0) and (HireTo > 0)) or ((ActualHireFrom > 0) and (ActualHireTo > 0))) then exit;

  qry := DbSharedObj.GetQuery(self.Connection.Connection);
  qryOnHire := DbSharedObj.GetQuery(self.Connection.Connection);
  try
    if (ActualHireFrom > 0) and (ActualHireto > 0) then begin
      { this line is using actual times .. }
      HireFromStr := '"' + FormatDateTime(MysqlDateTimeFormat,ActualHireFrom) + '"';
      HireToStr := '"' + FormatDateTime(MysqlDateTimeFormat,ActualHireTo) + '"';
    end
    else begin
      { not actual times }
      HireFromStr := '"' + FormatDateTime(MysqlDateTimeFormat,HireFrom) + '"';
      HireToStr := '"' + FormatDateTime(MysqlDateTimeFormat,HireTo) + '"';
    end;

    qryOnHire.SQL.Add('select distinct tblfixedassets.AssetId');
    qryOnHire.SQL.Add('from tblassethire');
    qryOnHire.SQL.Add('inner join tblfixedassets on tblfixedassets.AssetID = tblassethire.AssetId');
    qryOnHire.SQL.Add('inner join tblhirelineasset on tblhirelineasset.AssetId = tblassethire.AssetId and tblassethire.Active = "T"');
    qryOnHire.SQL.Add('inner join tblhirelines on tblhirelines.HireLineID = tblhirelineasset.HireLineID and tblhirelines.Converted = "F" and tblhirelines.Deleted = "F"');
    qryOnHire.SQL.Add('and tblhirelines.HireLineId <> ' + IntToStr(Id));

    qryOnHire.SQL.Add('and (');

    qryOnHire.SQL.Add('((tblhirelines.ActualHireTo > tblhirelines.ActualHireFrom)');
    qryOnHire.SQL.Add('and ((tblhirelines.ActualHireFrom < ' + HireFromStr + ' and tblhirelines.ActualHireTo > ' + HireFromStr +') or (tblhirelines.ActualHireFrom < ' + HireFromStr + ' and tblhirelines.ActualHireTo > ' + HireFromStr + ')))');

    qryOnHire.SQL.Add('or');

    qryOnHire.SQL.Add('((tblhirelines.HireTo > tblhirelines.HireFrom)');
    qryOnHire.SQL.Add('and ((tblhirelines.HireFrom > ' + HireFromStr + ' and tblhirelines.HireTo > ' + HireFromStr +') or (tblhirelines.HireFrom < ' + HireFromStr + ' and tblhirelines.HireTo > ' + HireFromStr + ')))');

    qryOnHire.SQL.Add(')');
    qryOnHire.SQL.Add('inner join tblhire on tblhire.HireID = tblhirelines.HireID and tblhire.Converted = "F" and tblhire.Deleted = "F"');
    qryOnHire.Open;

    qry.SQL.Add('select tblfixedassets.AssetId, tblfixedassets.AssetCode, tblfixedassets.AssetName from tblassethire');
    qry.SQL.Add('inner join tblfixedassets on tblfixedassets.AssetID = tblassethire.AssetID and tblfixedassets.AssetName = ' + QuotedStr(AssetName));
    qry.SQL.Add('where tblassethire.Active = "T"');
    qry.Open;
    if qry.IsEmpty then
      exit;


    { 1 - if we have existing asset lines with wrong AssetName delete them  }
    if (AssetLines.Count > 0) and (AssetLines.AssetName <> AssetName) then
      AssetLines.DeleteAll;

    { 2 - check that any existing asset lines are still available for the selected hire period }
    AssetLines.First;
    while not AssetLines.EOF do begin
      if qryOnHire.Locate('AssetId',AssetLines.AssetId,[]) then begin
        if not AssetLines.Delete then
        begin
          exit;
        end;
      end
      else
        AssetLines.Next;
    end;

    { 3 - if we have to many asset lines delete the ones we dont need }
    AssetLines.Last;
    while AssetLines.Count > HireQty do begin
      if not AssetLines.Delete then
      begin
        exit;
      end;
    end;

    { 4 - add new asset lines }

    if AssetLines.Count < HireQty then begin
      qry.First;
      while not qry.Eof do begin
        { skip on hire items .. }
        if not qryOnHire.Locate('AssetId',qry.FieldByName('AssetID').AsInteger,[]) then begin
          { make sure it is not on hire already }
          if not AssetLines.Locate('AssetId', qry.FieldByName('AssetID').AsInteger, []) then begin
            AssetLines.New;
            AssetLines.AssetId := qry.FieldByName('AssetID').AsInteger;
            AssetLines.PostDb;
            if AssetLines.Count >= HireQty then
              break;
          end;
        end;
        qry.Next;
      end;
    end;

    { 5 - make sure hire line matches first asset line record }

    AssetLines.First;
    if AssetId <> AssetLines.AssetId then begin
      AssetId := AssetLines.AssetId;
      AssetName := AssetLines.AssetName;
      AssetCode := AssetLines.AssetCode;
    end;

    { if we don't have enough qty of available assets send message to gui }
    if AssetLines.Count < HireQty then
    begin
      SendEvent(BusObjEvent_Change ,BusobjEventVal_HireLineQtyUnavailable);
      HireQty := AssetLines.Count;
    end;

  finally
    DbSharedObj.ReleaseObj(qry);
    DbSharedObj.ReleaseObj(qryOnHire);
  end;
end;

procedure THireLines.SetActualHirefrom(const Value: TDateTime);
begin
  SetDateTimeField('ActualHirefrom', Value);
end;

procedure THireLines.SetHireTo(const Value: TDateTime);
begin
  SetDateTimeField('HireTo', Value);
end;

procedure THireLines.SetActualHireTo(const Value: TDateTime);
begin
  SetDateTimeField('ActualHireTo', Value);
end;

procedure THireLines.SetStatus(const Value: string);
begin
  SetStringField('Status', Value);
end;

procedure THireLines.SetUnitOfMeasure(const Value: String);
begin
  UOM := Value;
end;

procedure THireLines.SetUnitOfMeasureID(const Value: Integer);
begin
  inherited;
  UOMID := Value;
end;

procedure THireLines.SetUOMMultiplier(const Value: Double);
begin
  inherited;
  UOMMult := Value;
end;

procedure THireLines.SetUOMQty(const Value: Double);
begin
//  HireUOMQty := Value;
end;

procedure THireLines.SetLineAmount(const Value: Double);
begin
  SetFloatField('LineAmount', Value);
end;

procedure THireLines.SetLineTaxCode(const Value: string);
begin
  SetStringField('LineTaxCode', Value);
end;

procedure THireLines.SetLineTaxRate(const Value: Double);
begin
  SetFloatField('LineTaxRate', Value);
end;

procedure THireLines.SetLineAmountInc(const Value: Double);
begin
  SetFloatField('LineAmountInc', Value);
end;

procedure THireLines.SetPriceEx(const Value: Double);
begin
  SetFloatField('PriceEx', Value);
end;

procedure THireLines.SetPriceInc(const Value: Double);
begin
  SetFloatField('PriceInc', Value);
end;

procedure THireLines.SetUOMMult(Value: Double);
begin
  if Value = 0 then
    Value := 1;
  SetFloatField('UOMMult', Value);
end;

procedure THireLines.SetHireQty(const Value: Double);
begin
  SetFloatField('HireQty', Value);
end;

procedure THireLines.SetIncomeAccountId(const Value: Integer);
begin
  SetIntegerField('IncomeAccountId', Value);
end;

procedure THireLines.SetDeleted(const Value: Boolean);
begin
  SetBooleanField('Deleted', Value);
end;

procedure THireLines.SetConverted(const Value: Boolean);
begin
  SetBooleanField('Converted', Value);
end;

function THireLines.GetActive: Boolean;
begin
  Result := not(Deleted);
end;

function THireLines.GetAllocType: String;
begin
  Result := 'OUT';
end;

function THireLines.GetAssetCode: string;
begin
  result := GetStringField('AssetCode');
end;

function THireLines.GetAssetId: Integer;
begin
  result := GetIntegerField('AssetId');
end;

function THireLines.GetAssetLines: THireLineAsset;
begin
  Result := THireLineAsset(GetContainerComponent(THireLineAsset, 'HireLineID = ' + IntToStr(Id)));
end;

function THireLines.GetAssetName: string;
begin
  result := GetStringField('AssetName');
end;

function THireLines.GetTransDate: TDateTime;
begin
  if ActualHirefrom <> 0 then
    Result := ActualHirefrom
  else
    Result := HireFrom;
end;

function THireLines.GetUnitOfMeasure: String;
begin
  Result := UOM;
end;

function THireLines.GetUnitOfMeasureID: Integer;
begin
  Result := UOMID;
end;

function THireLines.GetUOMMultiplier: Double;
begin
  Result := UOMMult;
end;

function THireLines.GetUOMOrderQty: Double;
begin
  result := inherited GetUOMOrderQty;
end;

function THireLines.GetUOMQty: Double;
begin
  result := inherited GetUOMQty;
end;

function THireLines.IsAvailable(var msg: string): boolean;
var
  qry: TERPQuery;
begin
  result := true;
  if (ActualHireFrom > 0) and (ActualHireTo = 0) then exit;
  if (HireFrom = 0) or (HireTo = 0) then exit;

  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection.Connection);
  try
    qry.SQL.Add('select * from tblhire');
    qry.SQL.Add('inner join tblhirelines on tblhire.HireID = tblhirelines.HireID');
    qry.SQL.Add('and tblhirelines.AssetId = ' + IntToStr(AssetId));
    qry.SQL.Add('and tblhirelines.Deleted = "F"');
    qry.SQL.Add('where tblHire.HireId <> ' + IntToStr(HireId));
    qry.SQL.Add('and tblhire.Deleted = "F"');
    if (ActualHireFrom > 0) and (ActualHireTo > 0) then begin
      qry.SQL.Add('and');

      qry.SQL.Add('((IfNull(ActualHireFrom,HireFrom) >= ' + QuotedStr(FormatDateTime(MySQLConst.MysqlDateTimeFormat,ActualHireFrom)));
      qry.SQL.Add('and IfNull(ActualHireFrom,HireFrom) < ' + QuotedStr(FormatDateTime(MySQLConst.MysqlDateTimeFormat,ActualHireTo)) + ')');

      qry.SQL.Add('or (IfNull(ActualHireTo,HireTo) < ' + QuotedStr(FormatDateTime(MySQLConst.MysqlDateTimeFormat,ActualHireFrom)));
      qry.SQL.Add('and IfNull(ActualHireTo,HireTo) >= ' + QuotedStr(FormatDateTime(MySQLConst.MysqlDateTimeFormat,ActualHireTo)) + '))');
    end
    else begin
      qry.SQL.Add('and');

      qry.SQL.Add('((IfNull(ActualHireFrom,HireFrom) >= ' + QuotedStr(FormatDateTime(MySQLConst.MysqlDateTimeFormat,HireFrom)));
      qry.SQL.Add('and IfNull(ActualHireFrom,HireFrom) < ' + QuotedStr(FormatDateTime(MySQLConst.MysqlDateTimeFormat,HireTo)) + ')');

      qry.SQL.Add('or (IfNull(ActualHireTo,HireTo) < ' + QuotedStr(FormatDateTime(MySQLConst.MysqlDateTimeFormat,HireFrom)));
      qry.SQL.Add('and IfNull(ActualHireTo,HireTo) >= ' + QuotedStr(FormatDateTime(MySQLConst.MysqlDateTimeFormat,HireTo)) + '))');
    end;
    qry.Open;
    if not qry.IsEmpty then begin
      result := false;
      msg := AssetName + ' is not available for the date range selected. The following Customers have the item booked:';
      while not qry.Eof do begin
        if qry.RecNo <> 0 then msg := msg + ',';
        msg := msg + ' ' + qry.FieldByName('CustomerName').AsString;
        qry.Next;
      end;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function THireLines.GetMatrixDesc: String;
begin
  Result := '';
end;

function THireLines.GetMatrixPrice: Double;
begin
  Result := 0;
end;

function THireLines.GetMatrixRef: String;
begin
  Result := '';
end;

function THireLines.GetOrderQty: Double;
begin
  result := inherited GetOrderQty;
end;

function THireLines.GetProductID: Integer;
begin
  Result := HireProductID;
end;

function THireLines.GetProductName: String;
begin
  Result := HireProductName;
end;
function THireLines.GetProductPrintName: String;
begin
  Result := HireProductPrintName;
end;

function THireLines.GetProductType: string;
begin
  Result := Product.ProductType;
end;

function THireLines.GetQty: Double;
begin
  result := inherited GetQty;
end;

procedure THireLines.SetMatrixDesc(const Value: String);
begin
  inherited;
end;

procedure THireLines.SetMatrixPrice(const Value: Double);
begin
  inherited;
end;

procedure THireLines.SetMatrixRef(const Value: String);
begin
  inherited;
end;

procedure THireLines.SetProductID(const Value: Integer);
begin
  HireProductID := Value;
end;

procedure THireLines.SetProductName(const Value: string);
begin
  inherited;
  HireProductName := Value;
end;
procedure THireLines.SetProductPrintName(const Value: string);
begin
  inherited;
  HireProductPrintName := Value;
end;

procedure THireLines.SetProductType(const Value: string);
begin
  inherited;
end;

procedure THireLines.SetQty(const Value: Double);
begin
//  HireQty := Value;
end;

function THireLines.getTaxObj: TTaxcode;
begin
  Result := TTaxcode(getcontainercomponent(TTaxcode, 'Name = ' + QuotedStr(LineTaxCode)));
end;

function THireLines.getDuration: TDuration;
begin
  Result := TDuration(getcontainercomponent(TDuration, 'DurationId = ' + IntToStr(DurationId)));
end;

function THireLines.GetHireReturnPQA: TPQA;
var
  s: String;
begin
  Self.PostDB;
  s := 'TRansLineID = ' + IntToStr(Self.Id) + ' and ifnull(TransType,"") = ' +
    QuotedStr(Self.Classname + 'IN');
  Result := TPQA(getcontainercomponent(TPQA, s));
  if (Id <> 0) and (Result.count = 0) and (IsPQAItem) then begin
    Result.New;
  end;
end;

function THireLines.GetHeaderID: Integer;
begin
  Result := 0;
  if Assigned(Self.Owner) then
    if Self.Owner is THire then
      Result := THire(Self.Owner).Id;
end;

{ THirePartsSale }
procedure THirePartsSale.CalcLinetotals;
begin
  if (ProductID = 0) then
    exit;
  PriceInc := GetAmountInc(PriceEx, TaxRate);
  LineTotalEx := PriceEx * Qty;
  LineTotalInc := PriceInc * Qty;
  CalculateHireTotals;
end;

procedure THirePartsSale.CalculateHireTotals;
begin
  if Assigned(Owner) then
    if Owner is THire then
      THire(Owner).CalculateHireTotals;
end;

procedure THirePartsSale.ClonePropertyObjects;
begin
  inherited;
end;

constructor THirePartsSale.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'HirePartsSale';
  fSQL := 'SELECT * FROM tblhirepartssale';
  fClientDiscountObj := nil;
  AddingRelatedParts := False;
end;

procedure THirePartsSale.CreateInstance;
begin
  inherited;
  if Owner is THire then
    if Assigned(THire(Owner).ObjInstanceToClone) then
      if THire(Owner).ObjInstanceToClone is THire then
        ObjInstanceToClone := THire(THire(Owner).ObjInstanceToClone).HirePartsSale
      else if THire(Owner).ObjInstanceToClone is TInvoice then
        ObjInstanceToClone := TInvoice(THire(Owner).ObjInstanceToClone).Lines
      else if THire(Owner).ObjInstanceToClone is TSalesOrder then
        ObjInstanceToClone := TSalesOrder(THire(Owner).ObjInstanceToClone).Lines;

end;

destructor THirePartsSale.Destroy;
begin
  Freeandnil(fClientDiscountObj);
  inherited;
end;

procedure THirePartsSale.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'HirePartsSaleID');
  SetPropertyFromNode(node, 'HireID');
  SetPropertyFromNode(node, 'Description');
  SetPropertyFromNode(node, 'Linecost');
  SetPropertyFromNode(node, 'PriceEx');
  SetPropertyFromNode(node, 'PriceInc');
  SetPropertyFromNode(node, 'TaxCode');
  SetPropertyFromNode(node, 'TaxRate');
  SetPropertyFromNode(node, 'LineTotalEx');
  SetPropertyFromNode(node, 'LineTotalInc');
  SetPropertyFromNode(node, 'Discount');
  SetPropertyFromNode(node, 'Markup');
  SetPropertyFromNode(node, 'DiscountPercent');
  SetPropertyFromNode(node, 'MarkupPercent');
  SetBooleanPropertyFromNode(node, 'Deleted');
  SetBooleanPropertyFromNode(node, 'Converted');
  SetPropertyFromNode(node, 'ParentProductID');
  SetPropertyFromNode(node, 'ParentLineRef');
  SetPropertyFromNode(node, 'RelatedProductQty');
  SetBooleanPropertyFromNode(node, 'IsRelatedProduct');
  SetPropertyFromNode(node, 'PartBarcode');
  SetDateTimePropertyFromNode(node, 'PartIssuedOn');

end;

procedure THirePartsSale.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'HirePartsSaleID', HirePartsSaleID);
  AddXMLNode(node, 'HireID', HireID);
  AddXMLNode(node, 'Description', Description);
  AddXMLNode(node, 'UnitofMeasureMultiplier', UnitofMeasureMultiplier);
  AddXMLNode(node, 'Linecost', Linecost);
  AddXMLNode(node, 'PriceEx', PriceEx);
  AddXMLNode(node, 'PriceInc', PriceInc);
  AddXMLNode(node, 'TaxCode', TaxCode);
  AddXMLNode(node, 'TaxRate', TaxRate);
  AddXMLNode(node, 'LineTotalEx', LineTotalEx);
  AddXMLNode(node, 'LineTotalInc', LineTotalInc);
  AddXMLNode(node, 'Discount', Discount);
  AddXMLNode(node, 'Markup', Markup);
  AddXMLNode(node, 'DiscountPercent', DiscountPercent);
  AddXMLNode(node, 'MarkupPercent', MarkupPercent);
  AddXMLNode(node, 'Deleted', Deleted);
  AddXMLNode(node, 'Converted', Converted);
  AddXMLNode(node, 'ParentProductID', ParentProductID);
  AddXMLNode(node, 'ParentLineRef', ParentLineRef);
  AddXMLNode(node, 'RelatedProductQty', RelatedProductQty);
  AddXMLNode(node, 'IsRelatedProduct', IsRelatedProduct);
  AddXMLNode(node, 'PartBarcode', PartBarcode);
  AddXMLNode(node, 'PartIssuedOn', PartIssuedOn);
end;

function THirePartsSale.ValidateData: Boolean;
begin
  Result := inherited ValidateData;
end;

function THirePartsSale.Save: Boolean;
begin
  Result := False;
  if not ValidateData then
    exit;
  Result := inherited Save;
end;

procedure THirePartsSale.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  Freeandnil(fClientDiscountObj);
end;
procedure THirePartsSale.updaterelatedPartsQty;
begin
  if (Product.HasRelatedProducts) then begin
    ParentQty := self.Qty;
    fsRelatedParentLineRef := globalref;
    fiParentProductId := self.ProductId;
    IterateRecords(updateRelPrQtyCallback);
  end;
end;

procedure THirePartsSale.updateRelPrQtyCallback(const Sender: TBusObj; var Abort: Boolean);
var
  SaveDofieldChange: Boolean;
begin

  if (not(IsRelatedProduct)) then
    Exit;
  if not(self is THirePartsSale) then
    Exit;

  if THirePartsSale(Sender).ParentLineRef <> fsRelatedParentLineRef then Exit;
  if THirePartsSale(Sender).ParentProductID <> fiParentProductId then Exit;

  SaveDofieldChange := DofieldChange;
  DoFieldChangewhenDisabled := True;
  Try
    DofieldChange := True;
    if self.qty <> ParentQty * self.RelatedProductQty then begin
      self.qty := AutoRoundRelatedQty(ParentQty);
      PostDB;
    end;
  finally
    DofieldChange := SaveDofieldChange;
    DoFieldChangewhenDisabled := false;
  end;
end;
function THirePartsSale.AutoRoundRelatedQty(const Qty:double):Double;
begin
  result := tcdatautils.AutoRoundRelatedQty(Qty  , ParentProductID , ProductID);
end;

procedure THirePartsSale.DoFieldOnChange(Sender: TField);
var
  x: String;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then
      exit; // we are only interested in data fields.
  inherited;
  if sysutils.SameText(Sender.FieldName, 'ProductName') Then Begin
    DoFieldOnChange(Dataset.FindField('ProductID'));
  end
  else if sysutils.SameText(Sender.FieldName, 'ProductID') Then Begin
    ProductName := TProductsimple.IDToggle(ProductID, Connection.Connection);
    InitUOM(Product.UOMSales, '');
    Description := Product.SalesDescription;
    if not AddingRelatedParts then
      AddRelatedParts;
    if UOMQty <= 0 then
      UOMQty := 1.0;
    Qty := UOMQty * UnitofMeasureMultiplier;
    DoFieldOnChange(Dataset.FindField('UOMQty'));
    TaxCode := Product.TaxCodeSales;
    TaxRate := Product.TaxSales.Rate;
    PriceEx := Product.PriceForQty(Product.Id, Qty);
    CalcLinetotals;
  end
  else if sysutils.SameText(Sender.FieldName, 'UOMQty') Then Begin
    Qty := UOMQty * UnitofMeasureMultiplier;
    CalcLinetotals;
    updaterelatedPartsQty;
  end
  else if sysutils.SameText(Sender.FieldName, 'Qty') Then Begin
    UOMQty := DivZer(Qty, UnitofMeasureMultiplier);
    DoFieldOnChange(Dataset.findfield('uomqty'));
  end
  else if sysutils.SameText(Sender.FieldName, 'TaxCode') Then Begin
    TaxRate := TaxObj.Rate;
    CalcLinetotals;
  end
  else if sysutils.SameText(Sender.FieldName, 'UOMQty') Then Begin
    CalcLinetotals;
  end
  else if SameText(Sender.FieldName, 'PriceEx') then
  begin
    LineTotalEx := UOMQty * PriceEx;
    CalcLineTotals;
  end
  else if SameText(Sender.FieldName, 'LineTotalEx') then
  begin
    if UOMQty > 0 then
      PriceEx := LineTotalEx / UOMQty
    else
      PriceEx := LineTotalEx;
    CalcLineTotals;
  end
  else if sysutils.SameText(Sender.FieldName, 'PartBarcode') then begin
    if not RawMode then begin
      x := tcDataUtils.GetProductForbarCode(PartBarcode);
      if SameText(x, 'InactiveProduct') then
        PartBarcode := ''
      else if (SameText(x, 'Inactivebarcode')) or (x = '') then begin
        SendEvent(BusobjEvent_ToDo, BusObjEvent_PartBarcodeNotfound, Self);
        if ProductName <> '' then
          DoFieldOnChange(Dataset.FindField('ProductName'));
      end
      else begin
        ProductName := x;
        DoFieldOnChange(Dataset.FindField('ProductName'));
      end;
    end;

  End;
end;

procedure THirePartsSale.AddRelatedParts;
var
  RelatedProducts: TRelatedProduct;
  fParentProductId: Integer;
  fsRelatedParentRef: String;
  SaveDofieldChange: Boolean;
  bm: TBookmark;
begin
  if Product.HasRelatedProducts then begin
    RelatedProducts := TRelatedProduct.Create(nil);
    Self.PostDB;
    bm := Self.Dataset.GetBookmark;
    try
      fParentProductId := Self.ProductID;
      fsRelatedParentRef := Self.GlobalRef;
      RelatedProducts.loadSelect('ParentID = ' + IntToStr(Product.Id));
      SaveDofieldChange := DoFieldChange;
      DoFieldChange := True;
      AddingRelatedParts := True;
      // as the new records are getting added set this to false to trigger the DoFieldOnChange
      Try
        while not RelatedProducts.EOF do begin
          { add the record only if the record already doesn't exists }
          if not(Self.Dataset.Locate('ProductId;ParentProductID;ParentLineRef',
            varArrayof([RelatedProducts.ProductID, fParentProductId, fsRelatedParentRef]), [])) then
          begin
            Self.Dataset.Append;
            Self.IsRelatedProduct := True;
            Self.ProductID := RelatedProducts.ProductID;
            Self.ParentProductID := fParentProductId;
            Self.RelatedProductQty := RelatedProducts.Quantity;
            Self.ParentLineRef := fsRelatedParentRef;
            Self.Qty := 0;
            Self.UOMQty := 0;
            Self.PostDB;
          End;
          RelatedProducts.Next;
        end;
      finally
        DoFieldChange := SaveDofieldChange;
      end;
    finally
      AddingRelatedParts := False;
      Self.Dataset.GotoBookmark(bm);
      Self.Dataset.FreeBookmark(bm);
      Freeandnil(RelatedProducts);
    end;
  end
end;

function THirePartsSale.GetSerialnos: String;
begin
  Result := '';
end;

function THirePartsSale.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function THirePartsSale.GetIDField: string;
begin
  Result := 'HirePartsSaleID'
end;

function THirePartsSale.getInvoiceToclientID: Integer;
begin
  Result := 0;
  if not(Assigned(Self.Owner)) then
    exit;
  if not(Self.Owner is THire) then
    exit;

  Result := THire(Self.Owner).BillCustomerID;
  if Result = 0 then
    Result := THire(Self.Owner).CustomerID;
end;

function THirePartsSale.GetActive: Boolean;
begin
  Result := not(Deleted);
end;

function THirePartsSale.GetAllocType: String;
begin
  Result := 'OUT';
end;

procedure THirePartsSale.GetBaseLinePrice;
var
  RetPriceEx: Double;
  RetDiscountPercent: Double;
  RetDesc: String;
  RetMsg: String;
begin
  if ParthasPriceMatrix(Product.Id) and (MatrixPrice <> 0) then
    PriceEx := MatrixPrice
  else
    PriceEx := Product.GetPriceForQty(Qty);

  if InvoiceToclientID > 0 then begin
    { Calculate price after discounts }
    RetMsg := '';
    if ClientDiscountObj.ClientPrice_Discounts(InvoiceToclientID, HireTerms, ProductID,
      UnitOfMeasureID, ClassID, Qty, PartIssuedOn, False, RetPriceEx, RetDiscountPercent, RetDesc,
      RetMsg, True, MatrixRef) then begin
      Self.DiscountPercent := RetDiscountPercent * 100;
      DoFieldOnChange(Dataset.FindField('DiscountPercent'));
      Self.PriceEx := RetPriceEx;
      if RetDesc <> '' then
        Self.Description := RetDesc;
      if RetMsg <> '' then begin
        if fLastDiscountRetMsg <> RetMsg then begin
          fLastDiscountRetMsg := RetMsg;
          AddResult(True, rssinfo, 0, RetMsg);
        end;
      end;
    end
    else begin
      if RetMsg <> '' then
        AddResult(False, rssWarning, 0, RetMsg);
    end;
  end;
  PriceInc := GetAmountInc(PriceEx, TaxRate);
end;

function THirePartsSale.GetBOQty: Double;
begin
  Result := 0;
end;

class function THirePartsSale.GetBusObjectTablename: string;
begin
  Result := 'tblhirepartssale';
end;

function THirePartsSale.GetClassID: Integer;
begin
  Result := 0;
  if Assigned(Self.Owner) then
    if Self.Owner is THire then
      Result := THire(Self.Owner).DepartmentID;
end;

function THirePartsSale.GetCleanClassID: Integer;
begin
  Result := 0;
  if Assigned(Self.Owner) then
    if Self.Owner is THire then
      Result := THire(Self.Owner).CleanDepartmentID;
end;

function THirePartsSale.GetcleanProductId: Integer;
begin
  Result := GetXMLNodeIntegerValue(CleanXMLNOde, 'ProductID');
end;

function THirePartsSale.GetClientDiscountObj: TClientDiscountObj;
begin
  if not Assigned(fClientDiscountObj) then begin
    fClientDiscountObj := TClientDiscountObj.Create;
  end;
  Result := fClientDiscountObj;
end;

function THirePartsSale.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then
    exit;
  if Assigned(Owner) then
    if Owner is THire then begin
      HireID := THire(Owner).Id;
    end;
end;

function THirePartsSale.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if (not(Result)) or (not(active)) or (Id = 0) then
    exit; { id is 0 if the record is filtered out }

  if IsPQAItem then begin
    if Converted then begin
      PQA.active := False;
      PQA.PostDB;
    end;
  end;

end;

{ Property Functions }
function THirePartsSale.GetHirePartsSaleID: Integer;
begin
  Result := GetIntegerField('HirePartsSaleID');
end;

function THirePartsSale.getHireTerms: String;
begin
  Result := '';
  if Assigned(Self.Owner) then
    if Owner is THire then
      Result := THire(Owner).Terms;
end;

function THirePartsSale.GetHeaderID: Integer;
begin
  Result := 0;
  if Assigned(Self.Owner) then
    if Self.Owner is THire then
      Result := THire(Self.Owner).Id;
end;

function THirePartsSale.GetHireID: Integer;
begin
  Result := GetIntegerField('HireID');
end;

function THirePartsSale.GetProductID: Integer;
begin
  Result := GetIntegerField('ProductID');
end;

function THirePartsSale.GetProductName: string;
begin
  Result := GetStringField('ProductName');
end;
function THirePartsSale.GetProductPrintName: string;
begin
  Result := GetStringField('ProductPrintName');
end;

function THirePartsSale.GetDescription: string;
begin
  Result := GetStringField('Description');
end;

function THirePartsSale.GetProductType: string;
begin
  Result := Product.ProductType;
end;

function THirePartsSale.GetQty: Double;
begin
  Result := GetFloatField('Qty');
end;

function THirePartsSale.GetUnitOfMeasure: string;
begin
  Result := GetStringField('UnitofMeasure');
end;

function THirePartsSale.GetUnitOfMeasureID: Integer;
begin
  Result := GetIntegerField('UnitofMeasureID');
end;

function THirePartsSale.GetUnitofMeasureMultiplier: Double;
begin
  Result := GetFloatField('UnitofMeasureMultiplier');
  if Result = 0 then
    Result := 1;
end;

function THirePartsSale.GetUOMQty: Double;
begin
  Result := GetFloatField('UOMQty');
end;

function THirePartsSale.GetLinecost: Double;
begin
  Result := GetFloatField('Linecost');
end;

function THirePartsSale.GetPriceEx: Double;
begin
  Result := GetFloatField('PriceEx');
end;

function THirePartsSale.GetPriceInc: Double;
begin
  Result := GetFloatField('PriceInc');
end;

function THirePartsSale.GetTaxCode: string;
begin
  Result := GetStringField('TaxCode');
end;

function THirePartsSale.GetTaxRate: Double;
begin
  Result := GetFloatField('TaxRate');
end;

function THirePartsSale.GetLineTotalEx: Double;
begin
  Result := GetFloatField('LineTotalEx');
end;

function THirePartsSale.GetLineTotalInc: Double;
begin
  Result := GetFloatField('LineTotalInc');
end;

function THirePartsSale.GetDiscount: Double;
begin
  Result := GetFloatField('Discount');
end;

function THirePartsSale.GetMarkup: Double;
begin
  Result := GetFloatField('Markup');
end;

function THirePartsSale.GetDiscountPercent: Double;
begin
  Result := GetFloatField('DiscountPercent');
end;

function THirePartsSale.GetMarkupPercent: Double;
begin
  Result := GetFloatField('MarkupPercent');
end;

function THirePartsSale.GetDeleted: Boolean;
begin
  Result := GetBooleanField('Deleted');
end;

function THirePartsSale.GetConverted: Boolean;
begin
  Result := GetBooleanField('Converted');
end;

function THirePartsSale.GetParentProductID: Integer;
begin
  Result := GetIntegerField('ParentProductID');
end;

function THirePartsSale.GetParentLineRef: string;
begin
  Result := GetStringField('ParentLineRef');
end;

function THirePartsSale.GetRelatedProductQty: Double;
begin
  Result := GetFloatField('RelatedProductQty');
end;

function THirePartsSale.GetIsRelatedProduct: Boolean;
begin
  Result := GetBooleanField('IsRelatedProduct');
end;

function THirePartsSale.GetMatrixDesc: string;
begin
  Result := GetStringField('MatrixDesc');
end;

function THirePartsSale.GetMatrixRef: string;
begin
  Result := GetStringField('MatrixRef');
end;

function THirePartsSale.GetOrderQty: Double;
begin
  Result := Qty;
end;

function THirePartsSale.GetMatrixPrice: Double;
begin
  Result := GetFloatField('MatrixPrice');
end;

function THirePartsSale.GetPartBarcode: string;
begin
  Result := GetStringField('PartBarcode');
end;

Function THirePartsSale.getPartIssuedOn: TDateTime;
begin
  Result := GetDateTimeField('PartIssuedOn');
End;

function THirePartsSale.GetUOMMultiplier: Double;
begin
  Result := UnitofMeasureMultiplier;
end;

function THirePartsSale.GetUOMOrderQty: Double;
begin
  Result := UOMQty;
end;

procedure THirePartsSale.SetHirePartsSaleID(const Value: Integer);
begin
  SetIntegerField('HirePartsSaleID', Value);
end;

procedure THirePartsSale.SetHireID(const Value: Integer);
begin
  SetIntegerField('HireID', Value);
end;

procedure THirePartsSale.SetProductID(const Value: Integer);
begin
  SetIntegerField('ProductID', Value);
end;

procedure THirePartsSale.SetProductName(const Value: string);
begin
  SetStringField('ProductName', Value);
end;
procedure THirePartsSale.SetProductPrintName(const Value: string);
begin
  SetStringField('ProductPrintName', Value);
end;

procedure THirePartsSale.SetDescription(const Value: string);
begin
  SetStringField('Description', Value);
end;

procedure THirePartsSale.SetProductType(const Value: string);
begin
  inherited;
end;

procedure THirePartsSale.SetQty(const Value: Double);
begin
  SetFloatField('Qty', Value);
end;

procedure THirePartsSale.SetUnitOfMeasure(const Value: string);
begin
  SetStringField('UnitofMeasure', Value);
end;

procedure THirePartsSale.SetUnitOfMeasureID(const Value: Integer);
begin
  SetIntegerField('UnitofMeasureID', Value);
end;

procedure THirePartsSale.SetUnitOfMeasureMultiplier(Value: Double);
begin
  if Value = 0 then
    Value := 1;
  SetFloatField('UnitofMeasureMultiplier', Value);
end;

procedure THirePartsSale.SetUOMMultiplier(const Value: Double);
begin
  inherited;
  UnitofMeasureMultiplier := Value;
end;

procedure THirePartsSale.SetUOMQty(const Value: Double);
begin
  SetFloatField('UOMQty', Value);
end;

procedure THirePartsSale.SetLinecost(const Value: Double);
begin
  SetFloatField('Linecost', Value);
end;

procedure THirePartsSale.SetPriceEx(const Value: Double);
begin
  SetFloatField('PriceEx', Value);
end;

procedure THirePartsSale.SetPriceInc(const Value: Double);
begin
  SetFloatField('PriceInc', Value);
end;

procedure THirePartsSale.SetTaxCode(const Value: string);
begin
  SetStringField('TaxCode', Value);
end;

procedure THirePartsSale.SetTaxRate(const Value: Double);
begin
  SetFloatField('TaxRate', Value);
end;

procedure THirePartsSale.SetLineTotalEx(const Value: Double);
begin
  SetFloatField('LineTotalEx', Value);
end;

procedure THirePartsSale.SetLineTotalInc(const Value: Double);
begin
  SetFloatField('LineTotalInc', Value);
end;

procedure THirePartsSale.SetDiscount(const Value: Double);
begin
  SetFloatField('Discount', Value);
end;

procedure THirePartsSale.SetMarkup(const Value: Double);
begin
  SetFloatField('Markup', Value);
end;

procedure THirePartsSale.SetDiscountPercent(const Value: Double);
begin
  SetFloatField('DiscountPercent', Value);
end;

procedure THirePartsSale.SetMarkupPercent(const Value: Double);
begin
  SetFloatField('MarkupPercent', Value);
end;

procedure THirePartsSale.SetDeleted(const Value: Boolean);
begin
  SetBooleanField('Deleted', Value);
end;

procedure THirePartsSale.SetConverted(const Value: Boolean);
begin
  SetBooleanField('Converted', Value);
end;

procedure THirePartsSale.SetParentProductID(const Value: Integer);
begin
  SetIntegerField('ParentProductID', Value);
end;

procedure THirePartsSale.SetParentLineRef(const Value: string);
begin
  SetStringField('ParentLineRef', Value);
end;

procedure THirePartsSale.SetRelatedProductQty(const Value: Double);
begin
  SetFloatField('RelatedProductQty', Value);
end;

procedure THirePartsSale.SetIsRelatedProduct(const Value: Boolean);
begin
  SetBooleanField('IsRelatedProduct', Value);
end;

procedure THirePartsSale.SetMatrixDesc(const Value: string);
begin
  SetStringField('MatrixDesc', Value);
end;

procedure THirePartsSale.SetMatrixRef(const Value: string);
begin
  SetStringField('MatrixRef', Value);
end;

procedure THirePartsSale.SetMatrixPrice(const Value: Double);
begin
  SetFloatField('MatrixPrice', Value);
end;

procedure THirePartsSale.SetPartBarcode(const Value: string);
begin
  SetStringField('PartBarcode', Value);
end;

Procedure THirePartsSale.SetPartIssuedOn(const Value: TDateTime);
begin
  SetDateTimeField('PartIssuedOn', Value);
end;

function THirePartsSale.getTaxObj: TTaxcode;
begin
  Result := TTaxcode(getcontainercomponent(TTaxcode, 'Name = ' + QuotedStr(TaxCode)));
end;

function THirePartsSale.GetTransDate: TDateTime;
begin
  Result := PartIssuedOn;
  if Assigned(Self.Owner) then
    if Self.Owner is THire then
      Result := THire(Self.Owner).HireDate;
end;

{ THireLineAsset }

constructor THireLineAsset.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'HireLineAsset';
  fSQL := 'SELECT * FROM tblhirelineasset';
end;

destructor THireLineAsset.Destroy;
begin

  inherited;
end;

function THireLineAsset.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if Assigned(Owner) and (Owner is THireLines) then
    HireLineId := THireLines(Owner).ID;
end;

procedure THireLineAsset.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then
      exit; // we are only interested in data fields.
  inherited;
  if sysutils.SameText(Sender.FieldName, 'AssetID') Then Begin
    if AssetId <> 0 then begin
      AssetName := TFixedAssets.AssetNameForId(AssetId, Connection.Connection);
      AssetCode := TFixedAssets.AssetCodeForID(AssetID, Connection.Connection);
    end
    else begin
      AssetName := '';
      AssetCode := '';
    end;
  end;
end;

function THireLineAsset.GetAssetCode: string;
begin
  result := GetStringField('AssetCode');
end;

function THireLineAsset.GetAssetId: integer;
begin
  result := GetIntegerField('AssetId');
end;

function THireLineAsset.GetAssetName: string;
begin
  result := GetStringField('AssetName');
end;

class function THireLineAsset.GetBusObjectTablename: string;
begin
  result := 'tblhirelineasset';
end;

function THireLineAsset.GetHireLineId: integer;
begin
  result := GetIntegerField('HireLineId');
end;

class function THireLineAsset.GetIDField: string;
begin
  result := 'HireLineAssetID';
end;

class function THireLineAsset.GetKeyStringField: string;
begin
  result := inherited;
end;

procedure THireLineAsset.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

end;

function THireLineAsset.Save: Boolean;
begin
  result := inherited Save;
end;

procedure THireLineAsset.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure THireLineAsset.SetAssetCode(const Value: string);
begin
  SetStringField('AssetCode',Value);
end;

procedure THireLineAsset.SetAssetId(const Value: integer);
begin
  SetIntegerField('AssetId',Value);
end;

procedure THireLineAsset.SetAssetName(const Value: string);
begin
  SetStringField('AssetName',Value);
end;

procedure THireLineAsset.SetHireLineId(const Value: integer);
begin
  SetIntegerField('HireLineId',Value);
end;

function THireLineAsset.ValidateData: Boolean;
begin
  result := inherited;
end;

initialization

RegisterClass(THirePartsSale);
RegisterClass(THireLines);
RegisterClass(THire);

end.
