unit BusobjSaleBase;
{

  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  27/05/05  1.00.00 IJB  Initial version.

  TSalesBase
  TSalesLineBase
}

interface

uses BusObjBase, MyAccess, ERPdbComponents, BusObjTrans, BusObjClient, BusObjClass, DB, Classes, ClientDiscountObj, ComCtrls, AdvOfficeStatusBar, XMLDoc, XMLIntf, SalesConst, BusObjEmployeeDetails,
  BusObjSalesLinesPoints, BusObjSalesRedeemPoints, BusobjTransTaxCodes, busobjsalesTaxcodes , BusobjSalesQtySplit, BusObjShippingAddress, BusObjFeTransLines , BusObjTransLinetotals, JSONObject;

type



  TSalesLineBase = class(TTransLineBase)
  private
    fClientDiscountObj: TClientDiscountObj;
    fFESalesLines: TFESalesLines;
    ParentQtySold : Double;
    ParentQtyShipped: Double;
    fsRelatedParentLineRef: string;
    fiPArentProductId: Integer;
    fsRefundedSnos: string;
    fbHasTree: Boolean;
    fbignoreCheckSaveSpecialPrice: Boolean;
    fdQtyrequiredforAlternateProduct: Double;
    fbAddingAlternateProduct: Boolean;
    fAutoLoadRelatedProducts: boolean;
    fiRelatedProductFormulaDescriptionUsing: Integer;
    fdBOMPrice: Double;
    fbAllowTaxinput: Boolean;
    fsPriceCalcDesc : String;
    function getconvertingQuote: Boolean;
    // function GetConvertingRepair    : Boolean;
    function getconvertingSO: Boolean;
    function getConvertingRepairs: Boolean;
    function getConvertingHire: Boolean;
    function GetLinePrice: Double;
    function GetDiscountedPrice: Double;
    function GetTotalDiscountedPrice: Double;
    function GetLinePriceInc: Double;
    function GetDiscountedPriceInc: Double;
    function GetTotalDiscountedPriceInc: Double;
    function GetForeignLinePrice: Double;
    function GetSaleLineId: Integer;
    function GetAttrib1Sale: Double;
    function GetAttrib1SaleRate: Double;
    function GetAttrib2Sale: Double;
    function GetAttrib1SaleEst: Double;
    function GetAttrib2SaleEst: Double;
    function GetDiscountAmount: Double;
    function GetDiscountPercent: Double;
    function GetMarkupAmount: Double;
    function GetMarginAmount: Double;
    function GetMarkupPercent: Double;
    function GetMarginPercent: Double;
    function GetSaleId: Integer;
    function GetSoldSerials: string;
    function GetSupplierName: string;
//    function GetHireQuantity: Double;
    function GetPartSpecID: Integer;
//    function GetClonedFromId: Integer;
    function GetSpecValue: string;
    function GetAreaQty: Double;
    function GetIsRelatedProduct: Boolean;
    function GetAutoSmartOrder: Boolean;
    function getSmartOrderCreated: Boolean;
    function getisFormulaRelProduct: Boolean;
    function GetIsQuote: Boolean;
    function GetParentProductID: Integer;
    function GetRefundedSalesLineID: Integer;
    function getRelatedProductQty: Double;
    function GetProfit: Double;
    function GetProfitInc: Double;
    function GetProfitPercent: Double;
    function GetProfitPercentInc: Double;

    function GetProfitbasedLatestCost: Double;
    function GetProfitbasedLatestCostInc: Double;
    function GetProfitbasedLatestCostPercent: Double;
    function GetProfitbasedLatestCostPercentInc: Double;
    function GetGrossProfitbasedLatestCostPercInc: Double;

    function GetSpecDescription: string;
    function GetCleanQtyShipped: Double;
    function GetCustomData: string;
    function GetTimeCostUsed: Boolean;
    function GetRequiresAssembly: Boolean;
    function GetAssembled: Boolean;
    function GetDocketNumber: string;
    function GetRelatedParentLineRef: string;
    function 	GetISContainer      : Boolean;
    function 	GetIsPallet         : Boolean;
    function GetOriginalLinePrice: Double;
    function GetForeignHedgingUsed: Boolean;
    function GetGrossProfitPercInc: Double;
    function GetForeignExchangeRate: Double;
    function GetForeignExchangeCode: string;
    function getProduct_Description: string;
    function getProduct_Description_Memo: string;
    function getCalcGrossProfitPercentInc: Double;
    function getLatestCostPriceInc: Double;
    function getLatestCostPrice: Double;
    function getRefundQty: Double;
    function GetClientDiscountObj: TClientDiscountObj;
    function getFESalesLines: TFESalesLines;
    function getLaybyID: string;
    function getCreationDate: TDatetime;
    function getMemoLine: string;
    function getSalesLinesCustField1: string;
    function getSalesLinesCustField10: string;
    function getSalesLinesCustField2: string;
    function getSalesLinesCustField3: string;
    function getSalesLinesCustField4: string;
    function getSalesLinesCustField5: string;
    function getSalesLinesCustField6: string;
    function getSalesLinesCustField7: string;
    function getSalesLinesCustField8: string;
    function getSalesLinesCustField9: string;
    function GetOriginalTotalLineAmount: Double;
    function GetOriginalTotalLineAmountInc: Double;

    procedure SetMemoLine(const Value: string);
    procedure SetSalesLinesCustField1(const Value: string);
    procedure SetSalesLinesCustField10(const Value: string);
    procedure SetSalesLinesCustField2(const Value: string);
    procedure SetSalesLinesCustField3(const Value: string);
    procedure SetSalesLinesCustField4(const Value: string);
    procedure SetSalesLinesCustField5(const Value: string);
    procedure SetSalesLinesCustField6(const Value: string);
    procedure SetSalesLinesCustField7(const Value: string);
    procedure SetSalesLinesCustField8(const Value: string);
    procedure SetSalesLinesCustField9(const Value: string);
    procedure SetLinePrice(const Value: Double);
    procedure SetLinePriceInc(const Value: Double);
    procedure SetDiscountedPrice(const Value: Double);
    procedure SetTotalDiscountedPrice(const Value: Double);
    procedure SetDiscountedPriceInc(const Value: Double);
    procedure SetTotalDiscountedPriceInc(const Value: Double);
    procedure SetForeignLinePrice(const Value: Double);
    procedure SetAttrib1Sale(const Value: Double);
    procedure SetAttrib1SaleRate(const Value: Double);
    procedure SetAttrib2Sale(const Value: Double);
    procedure SetAttrib1SaleEst(const Value: Double);
    procedure SetAttrib2SaleEst(const Value: Double);
    procedure SetDiscountAmount(const Value: Double);
    procedure SetDiscountPercent(const Value: Double);
    procedure SetMarkupAmount(const Value: Double);
    procedure SetMarginAmount(const Value: Double);
    procedure SetMarkupPercent(const Value: Double);
    procedure SetMarginPercent(const Value: Double);
    procedure SetSaleId(const Value: Integer);
    procedure SetSoldSerials(const Value: string);
    procedure SetSupplierName(const Value: string);
//    procedure SetHireQuantity(const Value: Double);
    procedure SetForeignHedgingUsed(const Value: Boolean);
    procedure SetPartSpecID(const Value: Integer);
//    procedure SetClonedFromId(const Value: Integer);
    procedure SetAreaQty(const Value: Double);
    procedure SetSpecValue(const Value: string);
    procedure SetIsRelatedProduct(const Value: Boolean);
    procedure SetAutoSmartOrder(const Value: Boolean);
    procedure SetSmartOrderCreated(const Value: Boolean);
    procedure SetISFormulaRElProduct(const Value: Boolean);
    procedure SetIsQuote(const Value: Boolean);
    procedure SetParentProductID(const Value: Integer);
    procedure SetRefundedSalesLineID(const Value: Integer);
    procedure SetRelatedProductQty(const Value: Double);
    procedure SetRelatedParentLineRef(const Value: string);
    procedure	setISContainer      (const Value: Boolean);
    procedure	setIsPallet         (const Value: Boolean);
    procedure SetOriginalLinePrice(const Value: Double);
    procedure SetSpecDescription(const Value: string);
    procedure SetCustomData(const Value: string);
    procedure SetTimeCostUsed(const Value: Boolean);
    procedure SetRequiresAssembly(const Value: Boolean);
    procedure SetAssembled(const Value: Boolean);
    procedure SetDocketNumber(const Value: string);
    procedure SetForeignExchangeRate(const Value: Double);
    procedure SetForeignExchangeCode(const Value: string);
    procedure SetProduct_Description(const Value: string);
    procedure SetProduct_Description_Memo(const Value: string);
    procedure SetCalcGrossProfitPercentInc(const Value: Double);
    procedure SetLatestCostPriceInc(const Value: Double);
    procedure SetLatestCostPrice(const Value: Double);
    procedure SetRefundQty(const Value: Double);
    procedure SetFESalesLines(const Value: TFESalesLines);
    procedure SetLayByID(const Value: string);
    procedure SetCreationDate(const Value: TDatetime);
    procedure updateRelPrQtyCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure CreateSalesLinesfromFELines(const Sender: TBusObj; var Abort: Boolean);
    function GetShipDate: TDatetime;
    function GetETDDate: TDatetime;
    procedure SetShipDate(const Value: TDatetime);
    procedure SetETDDate(const Value: TDatetime);
    function getCleanSoldSerials: string;
    function GetCleanUOMQtyShipped: Double;
    function getProductcost: Double;
    function getProductcostInc: Double;
    function getSaleDate: TDatetime;
    function ClientTypeID: Integer;
    // procedure RemoveDeletedFELines(Sender: TBusObj; var Abort: boolean);
    function GetBOCleanQty: Double;
    function GetSalesTaxCode: TSalesTaxCode;
    Function GetUOM_Height:Double;
    Function GetUOM_Width:Double;
    Function GetUOM_Length:Double;
    Function GetUOM_Weight:Double;
    Function GetTotalUOM_WeightSold:Double;
    Function GetTotalUOM_WeightShipped:Double;
    Function GetTotalUOM_WeightBO:Double;
    Function GetTotalUOM_LengthSold:Double;
    Function GetTotalUOM_LengthShipped:Double;
    Function GetTotalUOM_LengthBO:Double;
    Function GetOriginalQtyOrdered:Double;
    Function GetUOM_Volume:Double;
    Procedure SetUOM_Height(Const Value :Double);
    Procedure SetUOM_Width(Const Value :Double);
    Procedure SetUOM_Length(Const Value :Double);
    Procedure SetUOM_Weight(Const Value :Double);
    Procedure SetTotalUOM_WeightSold(Const Value :Double);
    Procedure SetTotalUOM_WeightShipped(Const Value :Double);
    Procedure SetTotalUOM_WeightBO(Const Value :Double);
    Procedure SetTotalUOM_LengthSold(Const Value :Double);
    Procedure SetTotalUOM_LengthShipped(Const Value :Double);
    Procedure SetTotalUOM_LengthBO(Const Value :Double);
    Procedure SetOriginalQtyOrdered(Const Value :Double);
    Procedure SetUOM_Volume(Const Value :Double);
    function GetParentProductName: string;
    procedure SetParentProductName(const Value: string);
    function AutoRoundRelatedQty(const Qty:double):Double;
    function ProductUsescustomerTax :Boolean;
    function ProductUsesClassTax :Boolean;
    function CustomerAreaCode: String;
    //function getupdatingBO: boolean;
    function geTSalesLinesAutoSplitQty: TSalesLinesAutoSplitQty;
    function getSalesAutoSplitQty: TSalesAutoSplitQty;
    function getlineTaxclean: Double;
    procedure SetlineTaxclean(const Value: Double);
    function getlinepriceincclean: Double;
    procedure Setlinepriceincclean(const Value: Double);
    function getTotallineamountclean: Double;
    procedure SetTotallineamountclean(const Value: Double);
    function getTotallineAmountincclean: Double;
    procedure SetTotallineAmountincclean(const Value: Double);
    function GetProductBarcode: string;
    function GetRelatedProductPatternName: string;
    function GetRelatedProductFormulaDescription: string;
    procedure SetProductBarcode(const Value: string);
    procedure SetRelatedProductPatternName(const Value: string);
    procedure SetRelatedProductFormulaDescription(const Value: string);
    function GetUOMLinePrice: double;
    function GetUOMLinePriceInc: double;
    function GetBatchAllocated: boolean;
    procedure SetBatchAllocated(const Value: boolean);
    function GetDetailsCust1Total: double;
    function GetPurchaseCost: double;
    procedure SetDetailsCust1Total(const Value: double);
    procedure SetPurchaseCost(const Value: double);
    function GetHireLineId: Integer;
    function GetHirePartsSaleID: Integer;
    function GetRelatedProductProdLine: Integer;
    procedure SetHireLineId(const Value: Integer);
    procedure SetHirePartsSaleID(const Value: Integer);
    procedure SetRelatedProductProdLine(const Value: Integer);
    function GetExcludeFromSmartOrder: boolean;
    procedure SetExcludeFromSmartOrder(const Value: boolean);
    procedure DoAddRElatedProducts;
    function GetOriginalLinePriceInc: double;
    procedure InitProductFormula;
    function getHasRelatedProducts: boolean;
    function GetAvailableUOMQtyUOMQty: double;
    function GetInStockUOMQty: double;
    function GetProfitOnLanded: Double;
    function GetProfitOnLandedInc: Double;
    function GetProfitOnLandedPercent: Double;
    function GetProfitOnLandedPercentInc: Double;
    function getBOMPrice: Double;
    function GetSalesTaxBasedon: string;
    procedure SetSalesTaxBasedon(const Value: string);
    function getSalesTaxBasedonProductPrice: Boolean;
    function getSalesTaxBasedonSalesPrice: Boolean;
    function getAutoResetingPrices: Boolean;
    procedure SetAutoResetingPrices(const Value: Boolean);
    function getAvaTaxID: String;
    function getDuedate :TdateTime;
    procedure setDuedate(const Value: TdateTime);
    function getHeadershipdate :TdateTime;
    procedure setHeadershipdate(const Value: TdateTime);
  protected
    fbAddingRelatedProducts: Boolean;
    fbAddingProdToSpecialPrice: Boolean;
    fbupdatingRelPrQty :Boolean;
    fbInstantiatingTree:Boolean;
    function GetUnitOfMeasure: string; override;
    function GetUnitOfMeasureID: Integer; override;
    function GetClassID: Integer; override;
    function GetSerialnos: string; override;
    function GetCleanClassID: Integer; override;
    function GetcleanProductId: Integer; override;
    function GetcleanQtyTotal: Double; override;
    function GetCleanQty: Double;
    function ExcludeFromclone: string; override;
    procedure SetUnitOfMeasure(const Value: string); override;
    procedure SetUnitOfMeasureID(const Value: Integer); override;
    procedure SetSerialNos(const Value: string); override;
    procedure GetProductDetails; override;
    procedure GetBaseLineCost;
    procedure CalcLinePriceFromTotal;
    procedure DoFieldOnChange(Sender: TField); override;
    procedure CheckSaveSpecialPrice;
    procedure GetBaseLinePrice; virtual;
    property ClientDiscountObj: TClientDiscountObj read GetClientDiscountObj;
    function GetTransDate: TDatetime; override;
    procedure SetTransDate(const Value: TDatetime); override;
    function GetAllocType: string; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function InternalQuantityChange: Boolean;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforeEdit(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function SoldQtyforProductInthisSale: Double;
    function ShippedQtyforProductInthisSale: Double;
    function GetTransTaxCode: TTransTaxCode; override;
    function GetLineDesc: String ; override;
    Procedure OnProductChanged;override;
    Function ProductChanged: Boolean;override;
    Procedure CalcProductLatestCost;Virtual;
    Function  DoCalcFields(Sender :TDatasetBusObj):Boolean;Override;
    Procedure LogDoFieldchange(Sender :TField);Override;
    procedure OnBeforeDataIdChange; override;
    Procedure CalcLineForeingAmount;Override;
    procedure LoadInStockQty;
    function IgnoreBOMCalcPriceOnSale: Boolean;Virtual;
    //Procedure SetUOMQtyShipped(Const Value: Double);Override;
(*    Procedure InitUOM(Const Sender: TField);Overload;
    Procedure InitUOM(const UOMName, UOMNameOldValue:String);Overload;*)

  public
    property ignoreCheckSaveSpecialPrice: Boolean read fbignoreCheckSaveSpecialPrice write fbignoreCheckSaveSpecialPrice;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    procedure UpdateRelatedPartsQty;
    procedure DoProductSelect;
    function ValidateData: Boolean; override;
    function ValidateSrnos: Boolean;
    procedure CallDoFieldOnChange(Sender: TField);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure PostFERecords;
    procedure CalcLineTotals; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ExportsubClasses(const node: IXMLNode): Boolean; override;
    Function ImportsubClasses(Const Node: IXMLNode): Boolean; Override;
    property RefundedSnos: string read fsRefundedSnos write fsRefundedSnos;
    property CleanQty: Double read GetCleanQty;
    property AddingProdToSpecialPrice: Boolean read fbAddingProdToSpecialPrice write fbAddingProdToSpecialPrice;
    property updatingRelPrQty: Boolean read fbupdatingRelPrQty write fbupdatingRelPrQty;
    property Productcost: Double read getProductcost;
    property Productcostinc: Double read getProductcostInc;
    function ProductRewardPoints: TDataset;
    property SaleDate: TDatetime read getSaleDate;
    property HasTree: Boolean read fbHasTree write fbHasTree;
    Property BOMPrice :Double read getBOMPrice write fdBOMPrice; // this property is based on a local variable. read function wills end an event to the tree and get the root node price
    function isTreeItem: Boolean;
    property CleanBOQty: Double read GetBOCleanQty;
    property QtyrequiredforAlternateProduct: Double read fdQtyrequiredforAlternateProduct write fdQtyrequiredforAlternateProduct;
    property AddingAlternateProduct: Boolean read fbAddingAlternateProduct write fbAddingAlternateProduct;
    property  UOM_Height: double read getUOM_Height write setUOM_Height;
    property  UOM_Width: double read getUOM_Width write setUOM_Width;
    property  UOM_Length: double read getUOM_Length write setUOM_Length;
    property  UOM_Weight: double read getUOM_Weight write setUOM_Weight;
    property  TotalUOM_WeightSold: double read getTotalUOM_WeightSold write setTotalUOM_WeightSold;
    property  TotalUOM_WeightShipped: double read getTotalUOM_WeightShipped write setTotalUOM_WeightShipped;
    property  TotalUOM_WeightBO: double read getTotalUOM_WeightBO write setTotalUOM_WeightBO;
    property  TotalUOM_LengthSold: double read getTotalUOM_LengthSold write setTotalUOM_LengthSold;
    property  TotalUOM_LengthShipped: double read getTotalUOM_LengthShipped write setTotalUOM_LengthShipped;
    property  TotalUOM_LengthBO: double read getTotalUOM_LengthBO write setTotalUOM_LengthBO;
    property  OriginalQtyOrdered: double read getOriginalQtyOrdered write setOriginalQtyOrdered;
    property  UOM_Volume: double read getUOM_Volume write setUOM_Volume;
    property SaleLineId: Integer read GetSaleLineId;
    class function _Schema: string; override;
    Procedure FinaliseTree; Virtual;
    Procedure CalcTreePrice; virtual;
    function    SalesTreePartIDs :String;
    property AutoLoadRelatedProducts: boolean read fAutoLoadRelatedProducts write fAutoLoadRelatedProducts;
    Function SelectedProductIds :String;
    Function AddRElatedProducts:Boolean;
    Function ParentLineQtySold :double;
    Function ParentLineQtyShipped :double;
    Property HasRelatedProducts :boolean read getHasRelatedProducts;
    Property RelatedProductFormulaDescriptionUsing :Integer read fiRelatedProductFormulaDescriptionUsing write fiRelatedProductFormulaDescriptionUsing;
    procedure initRelatedProductFormulaDescription;Override;
    Procedure TreeQtyChanged;
    procedure DoBaseLinePricecalc;
    Property AllowTaxinput :Boolean read fbAllowTaxinput write fbAllowTaxinput;
    Property SalesTaxBasedonProductPrice :Boolean read getSalesTaxBasedonProductPrice;
    Property SalesTaxBasedonSalesPrice :Boolean read getSalesTaxBasedonSalesPrice;
    Property AutoResetingPrices :Boolean read getAutoResetingPrices write SetAutoResetingPrices;
    Procedure DoOnLineTaxChange;
    Function CalcAvaTax :Boolean;
    //function ChangeTotalQty(fdUOMQty: Double):Boolean;
    //Property updatingBO :boolean read getupdatingBO;
  published
    property SaleId: Integer read GetSaleId write SetSaleId;
    property LinePrice: Double read GetLinePrice write SetLinePrice; { * Single unit price excluding tax, including discounts and markups. }
    property DiscountedPrice: Double read GetDiscountedPrice write SetDiscountedPrice;
    property TotalDiscountedPrice: Double read GetTotalDiscountedPrice write SetTotalDiscountedPrice;
    property OriginalLinePrice: Double read GetOriginalLinePrice write SetOriginalLinePrice;
    property OriginalLinePriceInc: double read GetOriginalLinePriceInc;
    property LinePriceInc: Double read GetLinePriceInc write SetLinePriceInc; { * Single unit price including tax. }
    property DiscountedPriceInc: Double read GetDiscountedPriceInc write SetDiscountedPriceInc;
    property TotalDiscountedPriceInc: Double read GetTotalDiscountedPriceInc write SetTotalDiscountedPriceInc;
    property ForeignLinePrice: Double read GetForeignLinePrice write SetForeignLinePrice; { * Single unit foreign price. }
    property DiscountAmount: Double read GetDiscountAmount write SetDiscountAmount;
    property DiscountPercent: Double read GetDiscountPercent write SetDiscountPercent;
    property MarkupAmount: Double read GetMarkupAmount write SetMarkupAmount;
    property MarkupPercent: Double read GetMarkupPercent write SetMarkupPercent;
    property MarginAmount: Double read GetMarginAmount write SetMarginAmount;
    property MarginPercent: Double read GetMarginPercent write SetMarginPercent;
    property Attrib1Sale: Double read GetAttrib1Sale write SetAttrib1Sale;
    property Attrib2Sale: Double read GetAttrib2Sale write SetAttrib2Sale;
    property Attrib1SaleRate: Double read GetAttrib1SaleRate write SetAttrib1SaleRate;
    property Attrib1SaleEst: Double read GetAttrib1SaleEst write SetAttrib1SaleEst;
    property Attrib2SaleEst: Double read GetAttrib2SaleEst write SetAttrib2SaleEst;
    property SoldSerials: string read GetSoldSerials write SetSoldSerials; { * A list of serial numbers for this sale line (i.e. one serial number for each) }
    property CleanSoldSerials: string read getCleanSoldSerials;
    property SupplierName: string read GetSupplierName write SetSupplierName; { * The name of thge supplier that will be used to order this lines's product from. }
    property ForeignHedgingUsed: Boolean read GetForeignHedgingUsed write SetForeignHedgingUsed; { If true then a hedging formula was used in the calculation of        foreign amounts. }
    property PartSpecID: Integer read GetPartSpecID write SetPartSpecID;
    property SpecValue: string read GetSpecValue write SetSpecValue;
    property AreaQty: double read GetAreaQty write SetAreaQty;
    property IsRelatedProduct: Boolean read GetIsRelatedProduct write SetIsRelatedProduct;
    property AutoSmartOrder: Boolean read GetAutoSmartOrder write SetAutoSmartOrder;
    property SmartOrderCreated: Boolean read getSmartOrderCreated write SetSmartOrderCreated;
    property IsFormulaRElatedProduct: Boolean read getisFormulaRelProduct write SetISFormulaRElProduct;
    property IsQuote: Boolean read GetIsQuote write SetIsQuote;
    property ParentProductID: Integer read GetParentProductID write SetParentProductID;
    property RefundedSalesLineID: Integer read GetRefundedSalesLineID write SetRefundedSalesLineID;
    property ParentProductName: string read GetParentProductName write SetParentProductName;
    property RelatedProductQty: Double read getRelatedProductQty write SetRelatedProductQty;
    property RelatedParentLineRef: string read GetRelatedParentLineRef write SetRelatedParentLineRef;
    property ISContainer        : Boolean   Read GetISContainer       Write SetISContainer;
    property IsPallet           : Boolean   Read GetIsPallet          Write SetIsPallet;
    property Profit: Double read GetProfit;
    property ProfitPercent: Double read GetProfitPercent;
    property ProfitInc: Double read GetProfitInc;
    property ProfitPercentInc: Double read GetProfitPercentInc;
    property GrossProfitPercentInc: Double read GetGrossProfitPercInc;
    property ProfitbasedLatestCost: Double read GetProfitbasedLatestCost;
    property ProfitbasedLatestCostPercent: Double read GetProfitbasedLatestCostPercent;
    property ProfitbasedLatestCostInc: Double read GetProfitbasedLatestCostInc;
    property ProfitbasedLatestCostPercentInc: Double read GetProfitbasedLatestCostPercentInc;
    property GrossProfitbasedLatestCostPercentInc: Double read GetGrossProfitbasedLatestCostPercInc;
    property SpecDescription: string read GetSpecDescription write SetSpecDescription;
    property CleanQtyShipped: Double read GetCleanQtyShipped;
    property CleanUOMQtyShipped: Double read GetCleanUOMQtyShipped;
    property CustomData: string read GetCustomData write SetCustomData;
    property TimeCostUsed: Boolean read GetTimeCostUsed write SetTimeCostUsed;
    property RequiresAssembly: Boolean read GetRequiresAssembly write SetRequiresAssembly;
    property Assembled: Boolean read GetAssembled write SetAssembled;
    property DocketNumber: string read GetDocketNumber write SetDocketNumber;
    property ForeignExchangeCode: string read GetForeignExchangeCode write SetForeignExchangeCode;
    property ForeignExchangeRate: Double read GetForeignExchangeRate write SetForeignExchangeRate;
    property Product_Description: string read getProduct_Description write SetProduct_Description;
    property Product_Description_Memo: string read getProduct_Description_Memo write SetProduct_Description_Memo;
    property convertingQuote: Boolean read getconvertingQuote;
    property convertingSO: Boolean read getconvertingSO;
    property ConvertingRepairs: Boolean read getConvertingRepairs;
    property ConvertingHire: Boolean read getConvertingHire;
    property LatestCostPriceInc: Double read getLatestCostPriceInc write SetLatestCostPriceInc;
    property LatestCostPrice: Double read getLatestCostPrice write SetLatestCostPrice;
    property RefundQty: Double read getRefundQty write SetRefundQty;
    property CalcGrossProfitPercentInc: Double read getCalcGrossProfitPercentInc write SetCalcGrossProfitPercentInc;
    property FESalesLines: TFESalesLines read getFESalesLines write SetFESalesLines;
    property LaybyId: string read getLaybyID write SetLayByID;
    property CreationDate: TDatetime read getCreationDate write SetCreationDate;
    property MemoLine: string read getMemoLine write SetMemoLine;
    property SalesLinesCustField1: string read getSalesLinesCustField1 write SetSalesLinesCustField1;
    property SalesLinesCustField2: string read getSalesLinesCustField2 write SetSalesLinesCustField2;
    property SalesLinesCustField3: string read getSalesLinesCustField3 write SetSalesLinesCustField3;
    property SalesLinesCustField4: string read getSalesLinesCustField4 write SetSalesLinesCustField4;
    property SalesLinesCustField5: string read getSalesLinesCustField5 write SetSalesLinesCustField5;
    property SalesLinesCustField6: string read getSalesLinesCustField6 write SetSalesLinesCustField6;
    property SalesLinesCustField7: string read getSalesLinesCustField7 write SetSalesLinesCustField7;
    property SalesLinesCustField8: string read getSalesLinesCustField8 write SetSalesLinesCustField8;
    property SalesLinesCustField9: string read getSalesLinesCustField9 write SetSalesLinesCustField9;
    property SalesLinesCustField10: string read getSalesLinesCustField10 write SetSalesLinesCustField10;
    property ShipDate: TDatetime read GetShipDate write SetShipDate;
    property ETDDate: TDatetime read GetETDDate write SetETDDate;
    Property SalesAutoSplitQtyLines : TSalesLinesAutoSplitQty read geTSalesLinesAutoSplitQty;
    Property SalesAutoSplitQty : TSalesAutoSplitQty read getSalesAutoSplitQty;
    property lineTaxclean: Double read getlineTaxclean write SetlineTaxclean;
    property linepriceincclean: Double read getlinepriceincclean write Setlinepriceincclean;
    property Totallineamountclean: Double read getTotallineamountclean write SetTotallineamountclean;
    property TotallineAmountincclean: Double read getTotallineAmountincclean write SetTotallineAmountincclean;
    property ProductBarcode: string read GetProductBarcode write SetProductBarcode;
    property RelatedProductPatternName: string read GetRelatedProductPatternName write SetRelatedProductPatternName;
    property RelatedProductFormulaDescription: string read GetRelatedProductFormulaDescription write SetRelatedProductFormulaDescription;
    property UOMLinePrice: double read GetUOMLinePrice;
    property UOMLinePriceInc: double read GetUOMLinePriceInc;
    property BatchAllocated: boolean read GetBatchAllocated write SetBatchAllocated;
    property DetailsCust1Total: double read GetDetailsCust1Total write SetDetailsCust1Total;
    property PurchaseCost: double read GetPurchaseCost write SetPurchaseCost;
    property HireLineId: Integer read GetHireLineId write SetHireLineId;
    property HirePartsSaleID: Integer read GetHirePartsSaleID write SetHirePartsSaleID;
    property RelatedProductProdLine: Integer read GetRelatedProductProdLine write SetRelatedProductProdLine;
    property ExcludeFromSmartOrder: boolean read GetExcludeFromSmartOrder write SetExcludeFromSmartOrder;
    property InStockUOMQty: double read GetInStockUOMQty;
    property AvailableUOMQty: double read GetAvailableUOMQtyUOMQty;
    property ProfitOnLanded: Double read GetProfitOnLanded;
    property ProfitOnLandedInc: Double read GetProfitOnLandedInc;
    property ProfitOnLandedPercent: Double read GetProfitOnLandedPercent;
    property ProfitOnLandedPercentInc: Double read GetProfitOnLandedPercentInc;
    property SalesTaxBasedon: string read GetSalesTaxBasedon write SetSalesTaxBasedon;
    property SalesTaxCode: TSalesTaxCode read GetSalesTaxCode;
    Property AvaTaxID:String read getAvaTaxID;
    Property Duedate : TdateTime read getDuedate write setDuedate;
    Property Headershipdate : TdateTime read getHeadershipdate write setHeadershipdate;

    Property OriginalTotalLineAmount: Double read GetOriginalTotalLineAmount; {Wang}
    Property OriginalTotalLineAmountInc: Double read GetOriginalTotalLineAmountInc; {Wang}

    { fields no longer used }
//    property HireQuantity: Double read GetHireQuantity write SetHireQuantity; { * The quantity of this item that is to be hired out. }
//    property ClonedFromId: Integer read GetClonedFromId write SetClonedFromId;
  end;

  TSalesBase = class(TTransBase)
  private
    fUseWholesalePrice: Boolean;
    fbconvertingQuote: Boolean;
    fbconvertingSO: Boolean;
    fbConvertingRepairs: Boolean;
    fbConvertingHire: Boolean;
    fTotalLandedCost: Double;
    fTotalProductTotalLandedCost : double;
    fTotalProductcost: Double;
    LinesLog: string;
    fiSaleCommissionCalcId: Integer;
    fdPoints: Double;
    fbChangePartSourceToManufacture: Boolean;
    ChangePartSourcesalesLineId: Integer;
    fbUserConfirmedPartsourceStock: Boolean;
    fMakeJEforManCOGSDiff: TNotifyEvent;
    TmpTotalEstimatedAmountInc: Double;
    fbCalculatedAvaTax: Boolean;

    function GetSaleId: Integer;
    function GetCustomerName: string;
    function GetInvoiceToDesc: string;
    function GetPickupFromDesc: string;
    function GetPickupFromClientName: string;
    Function getPickUpfromID :Integer;
    function getSaleDate: TDatetime;
    function GetShipToDesc: string;
    function GetShipping: string;
    function GetPickMemo: string;
    function GetConNote: string;
    function getPOCreated: Boolean;
    function getAutoSmartOrderRef: string;
    function GetIsCashSale: Boolean;
    function GetIsInvoice: Boolean;
    function GetIsQuote: Boolean;
    function getIsPos: Boolean;
    function GetIsRefund: Boolean;
    function GetIsSalesOrder: Boolean;
    function GetIsLaybyPayment: Boolean;
    function GetIsCustomerreturn: Boolean;
    function GetIsLaybyTOS: Boolean;
    function GetIsVoucher: Boolean;
    function GetIsLayby: Boolean;
    function GetMemo: string;
    function GetOrderNumber: string;
    function GetPayMethod: string;
    function GetQuoteGlobalRef: string;
    Function getSOQuteGlobalref:String;
    function GetSaleClassId: Integer;
    function GetSaleClassName: string;
    function GetSOGlobalRef: string;
    function getCleanSaleDate: TDatetime;
    function GetTotalQuoteAmount: Double;
    function getTotalQuoteAmInc: Double;
    function GetChequeNumber: string;
    function GetCustomer: TCustomer;
    function GetSaleClass: TDeptClass;
    function GetShipDate: TDatetime;
    function GetHoldSale: Boolean;
    function GetCustPONumber: string;
    function GetCustomerID: Integer;
    function getCreationDate: TDatetime;
    function GetTotalMarkup: Double;
    function GetTotalWEGTax: Double;
    function GetTotalWETTax: Double;
    function GetTotalDiscount: Double;
    function GetInvoiceprintdesc: string;
    function GetPrinthold: Boolean;
    function GetPayduedate: string;
    function GetApplyflag: Boolean;
    //function GetAmountdue: Double;
    function GetTimeofsale: string;
    function GetPos: Boolean;
//    function getLaybyID: string;
    function GetDeposited: Boolean;
    function GetTillid: Integer;
    function GetTillname: string;
    function GetCommissionpaid: Boolean;
    function GetIsmanifest: Boolean;
    function GetUsedonmanifest: Boolean;
    function GetAddtomanifest: Boolean;
    function GetIsbarcodepicking: Boolean;
    function GetRepairglobalref: string;
    function GetBarcodepickingdone: Boolean;
    function GetArnotes: string;
//    function GetDespatchid: Integer;
//    function GetRunid: Integer;
//    function GetRunname: string;
    function getIsGeneratedFromHire: Boolean;
    function GetBlindbalanceprdid: Integer;
    function GetSaledatetime: TDatetime;
    function GetShippingCost: Double;
    function getPOSPostCode: string;
    function getArea: string;
    function getRepairID: Integer;
    function getTotalLandedCost: Double;
    {Wang}
    function GetOriginalTotalAmount: Double;
    function GetOriginalTotalAmountInc: Double;
    function GetOriginalTotalTax: Double;

    procedure CallbackTotalLandedCost(const Sender: TBusObj; var Abort: Boolean);
    procedure CallbackTotalProductTotalLandedCost(const Sender : TBusObj; var Abort : boolean);
    procedure CallbackTotalProductCost(const Sender: TBusObj; var Abort: Boolean);
    procedure CallbackTotalProductCostInc(const Sender: TBusObj; var Abort: Boolean);
    function getEmployee: TEmployeeDetails;
    procedure setPOSPostCode(const Value: string);
    procedure setArea(const Value: string);
    procedure SetInvoiceToDesc(const Value: string);
    procedure SetPickupFromDesc(const Value: string);
    procedure SetPickupFromClientName(const Value: String);
    Procedure SetPickUpfromID(const Value :Integer);
    procedure SetSaleDate(const Value: TDatetime);
    procedure SetShipToDesc(const Value: string);
    procedure SetShipping(const Value: string);
    procedure SetPickMemo(const Value: string);
    procedure SetConNote(const Value: string);
    procedure SetIsCashSale(const Value: Boolean);
    procedure SetPOCreated(const Value: Boolean);
    procedure SetAutoSmartOrderRef(const Value: string);
    procedure SetIsInvoice(const Value: Boolean);
    procedure SetIsQuote(const Value: Boolean);
    procedure SetIsPos(const Value: Boolean);
    procedure SetIsRefund(const Value: Boolean);
    procedure SetIsSalesOrder(const Value: Boolean);
    procedure SetIsLaybyPayment(const Value: Boolean);
    procedure SetIsCustomerreturn(const Value: Boolean);
    procedure SetIsLaybyTOS(const Value: Boolean);
    procedure SetIsVoucher(const Value: Boolean);
    procedure SetIsLayby(const Value: Boolean);
    procedure SetMemo(const Value: string);
    procedure SetOrderNumber(const Value: string);
    procedure SetPayMethod(const Value: string);
    procedure SetQuoteGlobalRef(const Value: string);
    procedure SetSaleClassId(const Value: Integer);
    procedure SetSaleClassName(const Value: string);
    procedure SetSOGlobalRef(const Value: string);
    procedure SetChequeNumber(const Value: string);
    procedure SetTotalQuoteAmount(const Value: Double);
    procedure SetHoldSale(const Value: Boolean);
    procedure SetCustPONumber(const Value: string);
    procedure SetCustomerID(const Value: Integer);
    procedure SetCreationDate(const Value: TDatetime);
    procedure SetTotalMarkup(const Value: Double);
    procedure SetTotalWEGTax(const Value: Double);
    procedure SetTotalWETTax(const Value: Double);
    procedure SetTotalDiscount(const Value: Double);
    procedure SetRepairID(const Value: Integer);
    procedure SetInvoiceprintdesc(const Value: string);
    procedure SetPrinthold(const Value: Boolean);
    procedure SetPayduedate(const Value: string);
    procedure SetApplyflag(const Value: Boolean);
    //procedure SetAmountdue(const Value: Double);
    procedure SetTimeofsale(const Value: string);
    procedure SetPos(const Value: Boolean);
//    procedure SetLayByID(const Value: string);
    procedure SetDeposited(const Value: Boolean);
    procedure SetTillid(const Value: Integer);
    procedure SetTillname(const Value: string);
    procedure SetCommissionpaid(const Value: Boolean);
    procedure SetIsmanifest(const Value: Boolean);
    procedure SetUsedonmanifest(const Value: Boolean);
    procedure SetAddtomanifest(const Value: Boolean);
    procedure SetRepairglobalref(const Value: string);
    procedure SetIsbarcodepicking(const Value: Boolean);
    procedure SetBarcodepickingdone(const Value: Boolean);
    procedure SetArnotes(const Value: string);
//    procedure SetDespatchid(const Value: Integer);
//    procedure SetRunid(const Value: Integer);
//    procedure SetRunname(const Value: string);
    procedure SetIsGeneratedFromHire(const Value: Boolean);
    procedure SetBlindbalperiodid(const Value: Integer);
    procedure SetSaledatetime(const Value: TDatetime);
    procedure SetShippingCost(const Value: Double);
    procedure AppyUpdatesPQA(const Sender: TBusObj; var Abort: Boolean);
    procedure CalcCommissionCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure RewardPointsCallBack(const Sender: TBusObj; var Abort: Boolean);
    function getMedtypeId: Integer;
    function getMedtype: string;
    procedure setMedtypeId(const Value: Integer);
    procedure setMedtype(const Value: string);
    function getTotalProductcost: Double;
    function getTotalProductcostinc: Double;
    function getSalesLinesPoints: TSalesLinesPoints;
    function getSalesRedeemPoints: TSalesRedeemPoints;
    procedure SalesLinesPointsBalanceCallbackProc(const Sender: TBusObj; var Abort: Boolean);
    procedure CalcredeemedPoints(const Sender: TBusObj; var Abort: Boolean);
    procedure ChangePartSourceToManufacturecallback(const Sender: TBusObj; var Abort: Boolean);
    procedure calcSalesPoints(const Sender: TBusObj; var Abort: Boolean);
    function getredeemedPoints: Double;
    function getsalePoints: Double;
    function GetIsInternalOrder: Boolean;
    procedure SetIsInternalOrder(const Value: Boolean);
    function getPartsourceStock: Boolean;
    function getNoOfBoxes: Integer;
    procedure setNoOfBoxes(const Value: Integer);
    function getContributionAmount: Double;
    procedure SetContributionAmount(const Value: Double);
//    function getISManTrans: Boolean;
//    procedure setISManTrans(const Value: Boolean);
    function getCleanContributionAmount: Double;
    function ValidateContributionAmount: Boolean;
    function getShipToID: Integer;
    procedure setShipToID(const Value: Integer);
    function GetSalesStatus: string;
    function GetHireGlobalref: string;
    procedure SetSalesStatus(const Value: string);
    procedure SetHireGlobalref(const Value: string);
    function getShippingAddressObj: TShippingAddress;
    function gettotalAmountclean :double;
    Procedure settotalAmountclean(const Value:Double);
    function gettotalAmountincclean :double;
    Procedure settotalAmountincclean(const Value:Double);
    function getTotalTaxclean :double;
    Procedure setTotalTaxclean(const Value:Double);
    function GetInvoiceCountry: string;
    function GetInvoicePostcode: string;
    function GetInvoiceState: string;
    function GetInvoiceStreet1: string;
    function GetInvoiceStreet2: string;
    function GetInvoiceStreet3: string;
    function GetInvoiceSuburb: string;
    function GetShipCountry: string;
    function GetShipPostcode: string;
    function GetShipState: string;
    function GetShipStreet1: string;
    function GetShipStreet2: string;
    function GetShipStreet3: string;
    function GetShipSuburb: string;
    function getTotalProductTotalLandedCost: double;
    function GetSaleCustField1: string;
    function GetSaleCustField10: string;
    function GetSaleCustField2: string;
    function GetSaleCustField3: string;
    function GetSaleCustField4: string;
    function GetSaleCustField5: string;
    function GetSaleCustField6: string;
    function GetSaleCustField7: string;
    function GetSaleCustField8: string;
    function GetSaleCustField9: string;
    procedure SetSaleCustField1(const Value: string);
    procedure SetSaleCustField10(const Value: string);
    procedure SetSaleCustField2(const Value: string);
    procedure SetSaleCustField3(const Value: string);
    procedure SetSaleCustField4(const Value: string);
    procedure SetSaleCustField5(const Value: string);
    procedure SetSaleCustField6(const Value: string);
    procedure SetSaleCustField7(const Value: string);
    procedure SetSaleCustField8(const Value: string);
    procedure SetSaleCustField9(const Value: string);
    procedure CalcForeignAmountCallback(const Sender: TBusObj;var Abort: Boolean);
    function getProductIDs: String;
    procedure AutoResetPricesCallback(const Sender: TBusObj;var Abort: Boolean);
    function getCustomerEmailId: String;
    //procedure CalcAvaTaxNoTaxCallback(const Sender: TBusObj;var Abort: Boolean);
    function getAvaTaxID: String;
    function getOriginal_Quote_SO_Invoice_Ref: String;
    function getAvaTaxCode: String;
    function AssignPickupfrom(JoShipFrom: TJsonObject): Boolean;
    procedure DeleteAllTaxLinesCallback(const Sender: TBusObj;
      var Abort: Boolean);
    procedure InitToNoTaxcallback(const Sender: TBusObj; var Abort: Boolean);


  protected
    fAttrib1Sale: Double;
    fAttrib2Sale: Double;
    fAttrib1SaleRate: Double;
    fAttrib1SaleEst: Double;
    fAttrib2SaleEst: Double;
    fTotalCost: Double;
    fdTotalQuoteAmtInc: Double;
    fWETTaxRate: Double;
    fWEGTaxRate: Double;
    fTotMarkup: Double;
    fTotDiscount: Double;
    fTotWETTax: Double;
    fTotWEGTax: Double;
    fTotTax: Double;
    fTotalAmountInc: Double;
    fTotalAmount: Double;
    fTotalOrdered: Double;
    fTotalShipped: Double;
    fTotalshippedUOMWeight: Double;
    fTotalshippedUOMLength: Double;
    fForeignTotalAmount: Double;
    fSaleClass: TDeptClass;
    clonedId: Integer;
    DoingCalcOrderTotals: Boolean;
    fbAutoResetingPrices :Boolean;
    //CalculatingAvaTax:Boolean;
    function GetClient: TClient; override;
    function GetClientName: string; override;
    procedure SetClientName(const Value: string); override;
    function GetDocNumber: string; override;
    procedure SetDocNumber(const Value: string); override;
    function GetSaleLines: TSalesLineBase; virtual;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure CalcTotalsCallback(const Sender: TBusObj; var Abort: Boolean); override;
    function DeleteFlaggedLines: Boolean; override;
    procedure ProcessDeletedLine; override;
    procedure CheckLineShipDateCallback(const Sender: TBusObj; var Abort: Boolean); // virtual;
    procedure DoFieldOnChange(Sender: TField); override;
    procedure BOLinesInit(BackOrder: TTransBase); override;
    procedure NewBOInit(BackOrder: TTransBase); override;
    function ExportsubClasses(const node: IXMLNode): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function GetLines: TTransLineBase; override;
    function SaveCancelled: boolean; override;
    function GetTransName: String;Override;
    function GetTransDate:TDateTime ; Override;
    procedure BeforeupdateBOLine(BackOrder: TTransBase);Override;
    procedure SetCustomerName(Value: string);Virtual;
    function GetTransStatus: String;Override;
    procedure SetTransStatus(const Value: String);Override;
    Procedure GetClientDetails; Override;
    function getTransLinetotals: TTransLinetotals;override;
    procedure SetShipDate(const Value: TDatetime); virtual;

  public
    InternalQuantityChange: Boolean;
    property TotalQtyOrdered: Double read fTotalOrdered;
    property TotalQtyShipped: Double read fTotalShipped;
    Property TotalshippedUOMWeight :Double read fTotalshippedUOMWeight;
    Property TotalshippedUOMLength :Double read fTotalshippedUOMLength;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    procedure CalcOrderTotals; override;
    procedure CalcForeignAmount;override;
    constructor Create(AOwner: TComponent); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    function CloneBusObj(const Changefield: string; const ChangeValue: Variant; const SaveAfterCopy: Boolean = True; const FilterFields: string = ''): TBusObj; override;
    procedure AssignDefaultShipped(const Sender: TBusObj; var Abort: Boolean);
    function ValidateData: Boolean; override;
    procedure AfterCopy; override;
    function IsBOInvoiced: Boolean; override;
    procedure updateUninvoicedSObalance(IsInternalOrder: Boolean);
    class function GetSaleType(const aSaleId: Integer; Conn: TCustomMyConnection = nil): TSaleType;
    class function GetSaleTypeClassName(const aSaleId: Integer; Conn: TCustomMyConnection = nil): string;
    class function SaleTypeAndId(const aSaleLineId: Integer; var aSaleId: Integer; Conn: TCustomMyConnection = nil): TSaleType; overload;
    class function SaleTypeAndId(const aGlobalref: string; var aSaleId: Integer; Conn: TCustomMyConnection = nil): TSaleType; overload;
    class function SaleClientId(const aSaleId: Integer; Conn: TCustomMyConnection = nil): integer;
    class function CustPONumberForSaleID(const aSaleId: Integer; Conn: TCustomMyConnection = nil): string;
    property convertingSO: Boolean read fbconvertingSO write fbconvertingSO;
    property ConvertingRepairs: Boolean read fbConvertingRepairs write fbConvertingRepairs;
    property ConvertingHire: Boolean read fbConvertingHire write fbConvertingHire;
    class function GetKeyStringField: string; override;
    procedure BusObjCopy(const Sender: TBusObj; var Abort: Boolean); override;
    procedure updateCustomerEquipQty(const Sender: TBusObj; var Abort: Boolean);
    property TotalLandedCost: Double read getTotalLandedCost;
    property TotalProductTotalLandedCost : double read getTotalProductTotalLandedCost;
    property TotalProductcost: Double read getTotalProductcost;
    property TotalProductcostinc: Double read getTotalProductcostinc;
    property Employee: TEmployeeDetails read getEmployee;
    function CalcCommission: string;
    property SaleCommissionCalcId: Integer read fiSaleCommissionCalcId write fiSaleCommissionCalcId;
    function RewardPoints: Boolean;
    property SalesLinesPoints: TSalesLinesPoints read getSalesLinesPoints;
    property SalesRedeemPoints: TSalesRedeemPoints read getSalesRedeemPoints;
    property redeemedPoints: Double read getredeemedPoints;
    property salePoints: Double read getsalePoints;
    property PartsourceStock: Boolean read getPartsourceStock;
    property UserConfirmedPartsourceStock: Boolean read fbUserConfirmedPartsourceStock write fbUserConfirmedPartsourceStock;
    procedure ChangePartSourceToManufacture(const fisalesLineId: Integer);
    procedure DoSalesLineProcTreeIDchange;
    procedure DoSalesLineProcTreeDestroy;
    procedure SendEmailtoErp(const Msg: string);
    property convertingQuote: Boolean read fbconvertingQuote write fbconvertingQuote;
    property SaleClass: TDeptClass read GetSaleClass;
    property Customer: TCustomer read GetCustomer;
    class function _Schema: string; override;
    procedure PartSourceToManufacture(Const Value:Boolean);
    procedure PopulateMessageSubstituteList(SL: TStringList); Overload; override;
    Class procedure PopulateMessageSubstituteList(aSaleId:Integer ; SL: TStringList); Overload;
    Property ShippingAddressObj : TShippingAddress read getShippingAddressObj;
    Property PickUpfromID :Integer read getPickUpfromID write setPickUpfromID;
    Class Function SaleObjInstance(Const saleId:Integer; conn : TMyDacDataConnection = nil; AOwner :Tcomponent = nil):TSalesBase;
    Class Function SaleComponentClass(Const saleId:Integer):TComponentClass;
    Property MakeJEforManCOGSDiff :TNotifyEvent read fMakeJEforManCOGSDiff write fMakeJEforManCOGSDiff;
    procedure AddStateFreight;
    function FirstPPGDate: TDateTime;
    Property ProductIDs :String read getProductIDs;
    Procedure AutoResetPricesOncustomerchange;
    Property AutoResetingPrices :boolean read fbAutoResetingPrices write fbAutoResetingPrices;
    Function CalcAvaTax:boolean;virtual;
    Procedure AvaTaxRelated(ajson :TJsonObject);
    function AvaTaxRelatedData: String;
    function Save: Boolean;Override;
    Property CalculatedAvaTax :Boolean read fbCalculatedAvaTax write fbCalculatedAvaTax;
    function ValidateforAvaTax: Boolean;
    function CommitInAvaTax: Boolean;
    Procedure DeleteAllTaxLines;
    Procedure InitToNoTax;

  published
    property TotalAttrib1Sale: Double read fAttrib1Sale;
    property TotalAttrib2Sale: Double read fAttrib2Sale;
    property TotalAttrib1SaleRate: Double read fAttrib1SaleRate;
    property TotalAttrib1SaleEst: Double read fAttrib1SaleEst;
    property TotalAttrib2SaleEst: Double read fAttrib2SaleEst;
    property TotalCost: Double read fTotalCost;
    property TotalQuoteAmount: Double read GetTotalQuoteAmount write SetTotalQuoteAmount;
    property TotalQuoteAmtInc: Double read getTotalQuoteAmInc write fdTotalQuoteAmtInc;
    property SaleId: Integer read GetSaleId;
    property CustomerID: Integer read GetCustomerID write SetCustomerID;
    property SaleClassId: Integer read GetSaleClassId write SetSaleClassId;
    property SaleClassName: string read GetSaleClassName write SetSaleClassName;
    property CustomerName: string read GetCustomerName write SetCustomerName;

    property InvoiceToDesc: string read GetInvoiceToDesc write SetInvoiceToDesc;
    property ShipToDesc: string read GetShipToDesc write SetShipToDesc;

    property InvoiceStreet1: string read GetInvoiceStreet1;
    property InvoiceStreet2: string read GetInvoiceStreet2;
    property InvoiceStreet3: string read GetInvoiceStreet3;
    property InvoiceSuburb: string read GetInvoiceSuburb;
    property InvoiceState: string read GetInvoiceState;
    property InvoiceCountry: string read GetInvoiceCountry;
    property InvoicePostcode:string read GetInvoicePostcode;

    property ShipStreet1: string read GetShipStreet1;
    property ShipStreet2: string read GetShipStreet2;
    property ShipStreet3: string read GetShipStreet3;
    property ShipSuburb: string read GetShipSuburb;
    property ShipState: string read GetShipState;
    property ShipCountry: string read GetShipCountry;
    property ShipPostcode:string read GetShipPostcode;

    property PickupFromDesc: string read GetPickupFromDesc write SetPickupFromDesc;
    property PickupFromClientName: string read GetPickupFromClientName write SetPickupFromClientName;
    property OrderNumber: string read GetOrderNumber write SetOrderNumber;
    property ChequeNumber: string read GetChequeNumber write SetChequeNumber;
    property ConNote: string read GetConNote write SetConNote;
    property Memo: string read GetMemo write SetMemo;
    property PayMethod: string read GetPayMethod write SetPayMethod;
    property SalesOrderGlobalRef: string read GetSOGlobalRef write SetSOGlobalRef;
    property QuoteGlobalRef: string read GetQuoteGlobalRef write SetQuoteGlobalRef;
    Property SOQuteGlobalref :String read getSOQuteGlobalref;
    property CustPONumber: string read GetCustPONumber write SetCustPONumber;
    property Shipping: string read GetShipping write SetShipping;
    property PickMemo: string read GetPickMemo write SetPickMemo;
    property HoldSale: Boolean read GetHoldSale write SetHoldSale;
    property IsCashSale: Boolean read GetIsCashSale write SetIsCashSale;
    property POCreated: Boolean read getPOCreated write SetPOCreated;
    property AutoSmartOrderRef: string read getAutoSmartOrderRef write SetAutoSmartOrderRef;
    property IsRefund: Boolean read GetIsRefund write SetIsRefund;
    property IsInvoice: Boolean read GetIsInvoice write SetIsInvoice;
    property IsSalesOrder: Boolean read GetIsSalesOrder write SetIsSalesOrder;
    property IsLaybyPayment: Boolean read GetIsLaybyPayment write SetIsLaybyPayment;
    property IsCustomerreturn: Boolean read GetIsCustomerreturn write SetIsCustomerreturn;
    property IsLaybyTOS: Boolean read GetIsLaybyTOS write SetIsLaybyTOS;
    property IsVoucher: Boolean read GetIsVoucher write SetIsVoucher;
    property POSPostCode: string read getPOSPostCode write setPOSPostCode;
    property Area: string read getArea write setArea;
    property IsLayby: Boolean read GetIsLayby write SetIsLayby;
    property IsQuote: Boolean read GetIsQuote write SetIsQuote;
    property IsPOS: Boolean read getIsPos write SetIsPos;
    property TotalWETTax: Double read GetTotalWETTax write SetTotalWETTax;
    property TotalWEGTax: Double read GetTotalWEGTax write SetTotalWEGTax;
    property TotalMarkup: Double read GetTotalMarkup write SetTotalMarkup;
    property TotalDiscount: Double read GetTotalDiscount write SetTotalDiscount;
    property UseWholesalePrice: Boolean read fUseWholesalePrice write fUseWholesalePrice;
    property SaleDate: TDatetime read getSaleDate write SetSaleDate;
    property ShipDate: TDatetime read GetShipDate write SetShipDate;
    property CreationDate: TDatetime read getCreationDate write SetCreationDate;
    property Lines: TSalesLineBase read GetSaleLines;
    property CleanSaleDate: TDatetime read getCleanSaleDate;
    property CleanContributionAmount: Double read getCleanContributionAmount;
    property InvoicePrintDesc: string read GetInvoiceprintdesc write SetInvoiceprintdesc;
    property PrintHold: Boolean read GetPrinthold write SetPrinthold;
    property PayDueDate: string read GetPayduedate write SetPayduedate;
    property ApplyFlag: Boolean read GetApplyflag write SetApplyflag;
    //property AmountDue: Double read GetAmountdue write SetAmountdue;
    property TimeOfSale: string read GetTimeofsale write SetTimeofsale;
    property EOP_POS: Boolean read GetPos write SetPos;
    property Deposited: Boolean read GetDeposited write SetDeposited;
    property TillID: Integer read GetTillid write SetTillid;
    property TillName: string read GetTillname write SetTillname;
    property CommissionPaid: Boolean read GetCommissionpaid write SetCommissionpaid;
    property IsManifest: Boolean read GetIsmanifest write SetIsmanifest;
    property UsedOnManifest: Boolean read GetUsedonmanifest write SetUsedonmanifest;
    property AddToManifest: Boolean read GetAddtomanifest write SetAddtomanifest;
    property IsBarcodePicking: Boolean read GetIsbarcodepicking write SetIsbarcodepicking;
    property BarcodePickingDone: Boolean read GetBarcodepickingdone write SetBarcodepickingdone;
    property ARNotes: string read GetArnotes write SetArnotes;
    property RepairGlobalRef: string read GetRepairglobalref write SetRepairglobalref;
    property RepairID: Integer read getRepairID write SetRepairID;
    property IsGeneratedFromHire: Boolean read getIsGeneratedFromHire write SetIsGeneratedFromHire;
    property BlindBalancePeriodID: Integer read GetBlindbalanceprdid write SetBlindbalperiodid;
    property SaleDateTime: TDatetime read GetSaledatetime write SetSaledatetime;
    property ShippingCost: Double read GetShippingCost write SetShippingCost;
    property MedTypeId: Integer read getMedtypeId write setMedtypeId;
    property MedType: string read getMedtype write setMedtype;
    property IsInternalOrder: Boolean read GetIsInternalOrder write SetIsInternalOrder;
    property NoOfBoxes: Integer read getNoOfBoxes write setNoOfBoxes;
    property ContributionAmount: Double read getContributionAmount write SetContributionAmount;
    Property ShipToID :Integer read getShipToID write setShipToID;
    property SalesStatus: string Read GetSalesStatus write SetSalesStatus;
    property HireGlobalref: string Read GetHireGlobalref write SetHireGlobalref;
    Property totalAmountclean :double read gettotalAmountclean write settotalAmountclean;
    Property totalAmountincclean :double read gettotalAmountincclean write settotalAmountincclean;
    Property TotalTaxclean :double read getTotalTaxclean write setTotalTaxclean;
    Property TotalEstimatedAmountInc: Double Read TmpTotalEstimatedAmountInc;
    property SaleCustField1: string read GetSaleCustField1 write SetSaleCustField1;
    property SaleCustField2: string read GetSaleCustField2 write SetSaleCustField2;
    property SaleCustField3: string read GetSaleCustField3 write SetSaleCustField3;
    property SaleCustField4: string read GetSaleCustField4 write SetSaleCustField4;
    property SaleCustField5: string read GetSaleCustField5 write SetSaleCustField5;
    property SaleCustField6: string read GetSaleCustField6 write SetSaleCustField6;
    property SaleCustField7: string read GetSaleCustField7 write SetSaleCustField7;
    property SaleCustField8: string read GetSaleCustField8 write SetSaleCustField8;
    property SaleCustField9: string read GetSaleCustField9 write SetSaleCustField9;
    property SaleCustField10: string read GetSaleCustField10 write SetSaleCustField10;
    Property CustomerEmailId :String read getCustomerEmailId;
    Property AvaTaxID:String read getAvaTaxID;
    Property Original_Quote_SO_Invoice_Ref:String read getOriginal_Quote_SO_Invoice_Ref;
    Property AvaTaxCode:String read getAvaTaxCode; // do not remove this property from publish, used by avatax

    Property OriginalTotalAmount:     Double read GetOriginalTotalAmount;
    Property OriginalTotalAmountInc:  Double read GetOriginalTotalAmountInc;
    Property OriginalTotalTax:        Double read GetOriginalTotalTax;

    { Fields no longer used }
//    property LaybyId: string read getLaybyID write SetLayByID;
//    property RunID: Integer read GetRunid write SetRunid;
//    property RunName: string read GetRunname write SetRunname;
//    property DespatchID: Integer read GetDespatchid write SetDespatchid;
//    property IsManTrans: Boolean read getISManTrans write setISManTrans;
  end;

implementation

uses
  CommonLib, Sysutils, BusObjStock, BusObjSales, MySQLConst, tcDataUtils,
  Variants, BusObjConst, DNMLib, BusObjCommon, AppEnvironment,
  tcTypes, CommonDbLib, BusObjUtils, busobjPQA,
  LogUtils, math, BusobjSalesCommission, CompanyPrefObj, BusObjPOSSale,
  DefaultClassObj, strutils, PartsPriceMatrixLib, BusObjSchemaLib,
  BusObjPosTill, dateutils, ParserLib, tcConst, BusobjCash, BusObjProcPrefs,
  BusObjSimpleTypes, busobjvouchersale, DbSharedObjectsObj,
  SalesDiscountValidationObj, LogLib, UtilsLib, BusObjProductClass,
  BusObjStateFreight, BusobjProductFormula, ProductQtyLib, PQALib,
  BusObjTaxCodes, SystemLib, dialogs, controls, BusobjExternalXRef,
  utCoreEDIConst, busobjPOS;

function TSalesLineBase.getconvertingQuote: Boolean;
begin
  Result := False;
  if Assigned(Self.Owner) then
    if Self.Owner is TSales then Result := TSales(Self.Owner).convertingQuote;
end;

function TSalesLineBase.GetLinePrice: Double;begin  Result := GetFloatField('LinePrice');end;
function TSalesLineBase.GetDiscountedPrice: Double;begin  Result := GetFloatField('DiscountedPrice');end;
function TSalesLineBase.GetTotalDiscountedPrice: Double;begin  Result := GetFloatField('TotalDiscountedPrice');end;
function TSalesLineBase.GetLinePriceInc: Double;begin  Result := GetFloatField('LinePriceInc');end;
function TSalesLineBase.GetDiscountedPriceInc: Double;begin  Result := GetFloatField('DiscountedPriceInc');end;
function TSalesLineBase.GetTotalDiscountedPriceInc: Double;begin  Result := GetFloatField('TotalDiscountedPriceInc');end;
function TSalesLineBase.GetSaleLineId: Integer;begin  Result := GetIntegerField('SaleLineId');end;
function TSalesLineBase.GetUnitOfMeasure: string;begin  Result := GetStringField('UnitOfMeasureSaleLines');end;
procedure TSalesLineBase.SetUnitOfMeasure(const Value: string);begin  SetStringField('UnitOfMeasureSaleLines', Value);end;
function TSalesLineBase.GetUnitOfMeasureID: Integer;begin  Result := GetIntegerField('UnitOfMeasureID');end;
function TSalesLineBase.GetForeignExchangeRate: Double;begin  Result := GetFloatField('ForeignExchangeSellRate');end;
function TSalesLineBase.getLatestCostPriceInc: Double;begin  Result := GetFloatField('LatestCostPriceInc');end;
function TSalesLineBase.getLatestCostPrice: Double;begin  Result := GetFloatField('LatestCostPrice');end;
function TSalesLineBase.getCalcGrossProfitPercentInc: Double;begin  Result := GetFloatField('CalcGrossProfitPercentInc');end;
function TSalesLineBase.getProduct_Description: string;begin  Result := GetStringField('Product_Description');end;
function TSalesLineBase.getProduct_Description_Memo: string;begin  Result := GetStringField('Product_Description_Memo');end;
function TSalesLineBase.GetForeignExchangeCode: string;begin  Result := GetStringField('ForeignExchangeSellCode');end;

procedure TSalesLineBase.SetUnitOfMeasureID(const Value: Integer);begin  SetIntegerField('UnitOfMeasureID', Value);end;
procedure TSalesLineBase.SetForeignLinePrice(const Value: Double);begin   SetFloatField('ForeignCurrencyLinePrice', Value);end;
procedure TSalesLineBase.SetLinePrice(const Value: Double);begin  SetFloatField('LinePrice', Value);end;
procedure TSalesLineBase.SetLinePriceInc(const Value: Double);begin  SetFloatField('LinePriceInc', Value);end;
procedure TSalesLineBase.SetForeignExchangeCode(const Value: string);begin  SetStringField('ForeignExchangeSellCode', Value);end;
procedure TSalesLineBase.SetCalcGrossProfitPercentInc(const Value: Double);begin  SetFloatField('CalcGrossProfitPercentInc', Value);end;
procedure TSalesLineBase.SetLatestCostPriceInc(const Value: Double);begin  SetFloatField('LatestCostPriceInc', Value);end;
procedure TSalesLineBase.SetLatestCostPrice(const Value: Double);begin  SetFloatField('LatestCostPrice', Value);end;
procedure TSalesLineBase.SetProductBarcode(const Value: string); begin  SetStringField('ProductBarcode', Value);end;
procedure TSalesLineBase.SetSalesTaxBasedon(const Value: string);begin  SetStringField('SalesTaxBasedon', Value);end;
procedure TSalesLineBase.SetRelatedProductPatternName(const Value: string);begin  SetStringField('RelatedProductPatternName', Value);end;
procedure TSalesLineBase.SetRelatedProductFormulaDescription(const Value: string);begin  SetStringField('RelatedProductFormulaDescription', Value);end;
procedure TSalesLineBase.SetProduct_Description(const Value: string);begin  SetStringField('Product_Description', Value);end;
procedure TSalesLineBase.SetProduct_Description_Memo(const Value: string);begin  SetStringField('Product_Description_Memo', Value);end;
procedure TSalesLineBase.SetDiscountedPrice(const Value: Double);begin  SetFloatField('DiscountedPrice', Value);end;
procedure TSalesLineBase.SetTotalDiscountedPrice(const Value: Double);begin  SetFloatField('TotalDiscountedPrice', Value);end;
procedure TSalesLineBase.SetDiscountedPriceInc(const Value: Double);begin  SetFloatField('DiscountedPriceInc', Value);end;
procedure TSalesLineBase.SetTotalDiscountedPriceInc(const Value: Double);begin  SetFloatField('TotalDiscountedPriceInc', Value);end;

function TSalesLineBase.ShippedQtyforProductInthisSale: Double;
var
  fdcleanQty, fdQty: Double;
  s: string;
begin
  s := 'Select Sum(Shipped) as Shipped  from tblsaleslines ' + ' where productId = ' + inttostr(ProductID) + ' and saleId =' + inttostr(SaleId) + ' and SaleLineId <> ' + inttostr(ID);
  with GetNewDataset(s, True) do
    try fdQty := FieldByname('Shipped').asFloat;
    finally
      if Active then close;
      Free;
    end;
  with GetNewDataset(s, False) do
    try fdcleanQty := FieldByname('Shipped').asFloat;
    finally
      if Active then close;
      Free;
    end;
  Result := fdQty - fdcleanQty;

end;

function TSalesLineBase.SoldQtyforProductInthisSale: Double;
var
  fdcleanQty, fdQty: Double;
  s: string;
begin
  s := 'Select Sum(Qtysold) as Qtysold  from tblsaleslines ' + ' where productId = ' + inttostr(ProductID) + ' and saleId =' + inttostr(SaleId) + ' and SaleLineId <> ' + inttostr(ID);
  with GetNewDataset(s, True) do
    try fdQty := FieldByname('Qtysold').asFloat;
    finally
      if Active then close;
      Free;
    end;
  with GetNewDataset(s, False) do
    try fdcleanQty := FieldByname('Qtysold').asFloat;
    finally
      if Active then close;
      Free;
    end;
  Result := fdQty - fdcleanQty;
end;

procedure TSalesLineBase.TreeQtyChanged;
begin
  MarginAmount :=0;
  MarginPercent :=0;
  calcLineTotals;
end;

function TSalesLineBase.SalesTreePartIDs: String;
begin
  With TERPQuery(getNewDataset('Select PTP.procTreePartID from tblproctree PT inner join tblproctreepart PTP on Pt.ProctreeId = PTP.ProctreeId where PT.masterId = ' + inttostr(ID)+' and PT.mastertype <> "mtProduct"' , true)) do try
    Result := groupconcat('procTreePartID');
    if result ='' then result :='0';
  finally
    if active then close;
    free;
  end;

end;

procedure TSalesLineBase.SetForeignExchangeRate(const Value: Double);
begin
  if DatasetAssigned then Dataset.FieldByname('ForeignExchangeSellRate').asFloat := Value;
end;
function TSalesLineBase.CalcAvaTax: Boolean;
begin
  REsult := False;
  if assigned(Owner) then
    if owner is TSalesbase then
      REsult := TSalesbase(Owner).CalcAvaTax;
end;

procedure TSalesLineBase.CalcLineForeingAmount;
begin
  inherited;
  if Appenv.CompanyPrefs.UseForeignCurrencyOnSales then begin
    if (Self is TSalesLine) and (Assigned(Owner)) and (Owner is TSales) then begin
      ForeignLinePrice := LocalToForeign(LinePriceInc, TSales(Owner).ForeignExchangeRate, RoundPlacesGeneral);
      ForeignTotalLineAmount := Round(ForeignLinePrice * QtyShipped, CurrencyRoundPlaces);
    end;
  end;
end;

procedure TSalesLineBase.CalcLinePriceFromTotal;
begin
  if QtyShipped = 0 then Exit;

  (*if QtySold < QtyShipped then QtySold := QtyShipped;
  QtyBackOrder := CommonLib.Round(QtySold - QtyShipped, Self.RoundPlacesGeneral);
  UOMQtySold := CommonLib.Round(QtySold / UOMMultiplier, Self.RoundPlacesGeneral);
  UOMQtyShipped := CommonLib.Round(QtyShipped / UOMMultiplier, Self.RoundPlacesGeneral);
  UOMQtyBackOrder := CommonLib.Round(QtyBackOrder / UOMMultiplier, Self.RoundPlacesGeneral);*)

  LinePrice := TotalLineAmount / QtyShipped;
  LinePriceInc := Round(TotalLineAmountInc / QtyShipped, RoundPlacesGeneral);

  {binny :change in the lineprice /line price inc was changing the original price and the totallineamount and totallineamountinc was not
  when converted (quote->SO or SO->Invoice), the price is calculated on the basis of original price and loosed the price change made in the original transaction
  so updating the original line price when total changed }
  self.OriginalLinePrice:= self.LinePrice;
  if Assigned (Owner) and (Owner is TSales) then
    if TSales(self.Owner).ForeignExchangeRate <> 0 then      begin
                self.ForeignLinePrice:= CommonLib.LocalToForeign(self.LinePriceinc,
                                        TSales(self.Owner).ForeignExchangeRate,
                                        self.RoundPlacesGeneral);
  end;

end;
procedure TSalesLineBase.CalcLineTotals;
var
  UOMLinePrice: double;
  UOMLinePriceInc: double;
  fdTax:Double;
  fdTotalex, fdTotalinc:double;
  Procedure AddPriceCalcDesc(Const Value:String);   begin    fsPriceCalcDesc := trim (fsPriceCalcDesc +NL+Value);  end;
  Function CurrValue(Const Value:Double):STring;  begin    Result := Floattostrf(Value, ffCurrency, 15,2);  end;
  Function PerValue(Const Value:Double):STring;  begin    Result := Floattostrf(Value, ffGeneral, 15,2)+'%';  end;
  Function FloatValue(Const Value:Double):STring;  begin    Result := Floattostrf(Value, ffGeneral, 15,2);  end;
  Procedure LogPrice;
  begin
      AddPriceCalcDesc('Unit price (Ex) :' + CurrValue(LinePrice));
      AddPriceCalcDesc('Unit price (Inc) :' + CurrValue(LinePriceInc));
      AddPriceCalcDesc('Tax:' + CurrValue(LineTaxTotal));
      if SalesTaxCode.Lines.count >0 then begin
          SalesTaxCode.Lines.First;
          While SalesTaxCode.Lines.Eof = False do begin
              AddPriceCalcDesc('         Code : '+SalesTaxCode.Lines.SubTaxCode +':' +
                                       '         Percetage :' +PerValue(SalesTaxCode.Lines.Percentage )+
                                       '         TaxAmount:' +CurrValue(SalesTaxCode.Lines.TaxAmount ));
              SalesTaxCode.Lines.Next;
          end;
      end;
      AddPriceCalcDesc('ShippedQty :' + FloatValue(QtyShipped));
      AddPriceCalcDesc('Discount :' + CurrValue(DiscountAmount));
      AddPriceCalcDesc('Discount %:' + PerValue(DiscountPercent));
      AddPriceCalcDesc('Markup :' + CurrValue(MarkupAmount));
      AddPriceCalcDesc('Markup %:' + PerValue(MarkupPercent));
      AddPriceCalcDesc('Total price (Ex) :' + CurrValue(TotalLineamount));
      AddPriceCalcDesc('Total price (Inc) :' + CurrValue(TotalLineamountInc));
      if OriginalLinePrice <> 0 then Logtext(fsPriceCalcDesc);
  end;
begin
  if Self.ID = 0 then Exit;
try
  fsPriceCalcDesc := '';
  try
      AddPriceCalcDesc('Base Price : ' + CurrValue(OriginalLinePrice));
      if OriginalLinePrice <>0 then begin // this condition is added as the memorise transactions were overwiting the price to 0 - RSL: had invoices with line price non 0 and origline price 0.
        LinePrice := OriginalLinePrice;
      end;

      if (lineCost <> 0) and (DiscountPercent =0) and (MarkupPercent=0) and (DiscountAmount=0) and (MarkupAmount=0) then begin
             if MarginAmount <> 0 then LinePrice := Round(LineCost +MarginAmount, RoundPlacesGeneral)
        else if MarginPercent <> 0 then LinePrice := DivZer(LineCost,(1-(MarginPercent/100)));//Round(GetAmountInc(LineCost, MarginPercent/100), RoundPlacesGeneral);
      end;
      AddPriceCalcDesc('Unit price (Ex) :' + CurrValue(LinePrice));
(*      if CalcAvaTax then begin
        Logtext('avatax calculated');
        exit;
      end;*)

      if TransTaxCode.Lines.Count = 0 then begin
              AddPriceCalcDesc('Single Tax');
              if LineTaxRate = 0 then begin
                 LinePriceInc :=LinePrice;
                 UOMLinePrice := LinePrice * UOMMultiplier;
                 UOMLinePriceInc := UOMLinePrice;
              end else begin
                    LinePriceInc := Round(LinePrice * (1.0 + LineTaxRate), RoundPlacesGeneral); { New Discounted LinePrice (Inc) }
                    AddPriceCalcDesc('Unit Price Inc : ' + CurrValue(LinePriceInc ));

                    { NOTE: changed this to do calcs using UOM values to avoid rounding issues when dealing with fractional quantities }
                    UOMLinePrice := LinePrice * UOMMultiplier;
                    UOMLinePriceInc := Round(UOMLinePrice * (1 + LineTaxRate), RoundPlacesGeneral);
              end;

              fdTotalex  := UOMQtyShipped *UOMLinePrice ;
              fdTotalinc := UOMQtyShipped *UOMLinePriceinc ;
              TotalLineAmount :=  fdTotalex;
              AddPriceCalcDesc('TotalLineAmount :'    + CurrValue(TotalLineAmount ));

              if not SalesTaxBasedonProductPrice then begin
                      AddPriceCalcDesc('Sales Tax Based on :  Sales Price:' );
                      TotalLineAmount := TotalLineAmount
                                            - fdTotalEx*DiscountPercent/100
                                            - DiscountAmount
                                            + MarkupAmount
                                            + fdTotalEx *MarkupPercent /100; { Adjust total for line discount and markup. }
                      AddPriceCalcDesc('Discounted TotalLineAmount :'   + CurrValue(TotalLineAmount ));
              end;

              if (QtyShipped <> 0.00) then begin
                    {2 Feb 2018 IJB removed ABS as this is resulting in a negative lineprice when qty is negative eg on a refund}
                    LinePrice    := Round(DivZer(TotalLineAmount, QtyShipped), RoundPlacesGeneral); { New Discounted LinePrice (Ex) }
                    if LineTaxRate = 0 then
                         LinePriceInc := LinePrice
                    else LinePriceInc := Round(LinePrice * (1.0 + LineTaxRate), RoundPlacesGeneral); { New Discounted LinePrice (Inc) }
                    //TotalLineAmountinc := CommonLib.Round(LinePriceinc * QtyShipped, CurrencyRoundPlaces); { New Discounted LineTotal (Ex) }
              end else begin
                    {Dene / Simon wants to calculate the price on backorder as well }
                    { NOTE: we dont need to do this as LinePrice with discount / markup percent already done above }
                    //LinePrice := Round(LinePrice -
                    //              (LinePrice * (DiscountPercent / 100)) +
                    //              (LinePrice * (MarkupPercent / 100)), RoundPlacesGeneral);
                    if LineTaxRate = 0 then
                         LinePriceInc := LinePrice
                    else LinePriceInc := Round(LinePrice * (1.0 + LineTaxRate), RoundPlacesGeneral); { New Discounted LinePrice (Inc) }
              end;

              TotalLineAmountinc := CommonLib.Round(LinePriceinc * QtyShipped, CurrencyRoundPlaces); { New Discounted LineTotal (Ex) }

              AddPriceCalcDesc('LinePrice  :' + CurrValue(linePrice));
              AddPriceCalcDesc('LinePriceinc  :' + CurrValue(linePrice));


              CalcLineForeingAmount;
              //if LineTaxRate <> 0 then begin
              if LineTaxRate =0 then begin
                TotallineAmount := TotallineAmountinc;
                fdTax := 0;
              end else fdTax:=Round(TotallineAmountinc- TotallineAmount, RoundPlacesGeneral); // since the amt and intInc is rounded, no need to round ; { tax }

              AddPriceCalcDesc('Tax  :' + CurrValue(fdTax));
              if SalesTaxBasedonProductPrice then begin
                      TotalLineAmountInc := TotalLineAmountInc
                                            - fdTotalEx*DiscountPercent/100
                                            - DiscountAmount
                                            + MarkupAmount
                                            + fdTotalEx *MarkupPercent /100; { Adjust total for line discount and markup. }
                      TotalLineAmount :=TotallineAmountinc-fdTax;
                      LinePrice    := Round(DivZer(TotalLineAmount, QtyShipped), RoundPlacesGeneral); { New Discounted LinePrice (Ex) }
                      LinePriceInc := Round(DivZer(TotalLineAmountinc, QtyShipped), RoundPlacesGeneral); { New Discounted LinePrice (Ex) }
                      AddPriceCalcDesc('Discounted TotalLineAmountInc :'   + CurrValue(TotalLineAmountInc ));
                      AddPriceCalcDesc('Discounted TotalLineAmount :'   + CurrValue(TotalLineAmount ));

                      if not math.SameValue(LineTaxTotal, TotalLineAmountInc - TotalLineAmount, (*0.0000001*)0) then begin
                              LineTaxTotal :=Round(TotallineAmountinc- TotallineAmount, RoundPlacesGeneral); // since the amt and intInc is rounded, no need to round ;
                              AddPriceCalcDesc('LineTaxTotal= (inc - ex) = '+ CurrValue(LineTaxTotal));
                      end;
              end else begin
                      LineTaxTotal := fdTax;
              end;
      end else begin
              { we have a line with sub tax codes .. }
              { NOTE: changed this to do calcs using UOM values to avoid rounding issues when dealing with fractional quantities }
              UOMLinePrice := LinePrice * UOMMultiplier;
              fdtotalEx := UOMQtyShipped* UOMLinePrice;
              AddPriceCalcDesc('TotalEx :' + CurrValue(fdtotalEx ));
              if SalesTaxBasedonProductPrice then begin
                   AddPriceCalcDesc('Sales Tax Based on :  Product Price' );
                   TotalLineAmount := Round(fdtotalEx , CurrencyRoundPlaces);
                   AddPriceCalcDesc('TotalLineAmount  :' + CurrValue(TotalLineAmount ));
              end else begin
                   AddPriceCalcDesc('Sales Tax Based on :  Sales Price' );
//                   TotalLineAmount := Round(fdtotalEx -
//                                            fdtotalEx * DiscountPercent/100 +
//                                            fdtotalEx * MarkupPercent  /100 -
//                                            DiscountAmount +
//                                            MarkupAmount, CurrencyRoundPlaces);
                   TotalLineAmount := fdtotalEx -
                                            fdtotalEx * DiscountPercent/100 +
                                            fdtotalEx * MarkupPercent  /100 -
                                            DiscountAmount +
                                            MarkupAmount;
                   AddPriceCalcDesc('TotalLineAmount Discounted:'   + CurrValue(TotalLineAmount ));
              end;
              CalcTaxcodeTotals;
              SalesTaxCode.Lines.First;
              While SalesTaxCode.Lines.Eof = False do begin
                      AddPriceCalcDesc('         Code : '+SalesTaxCode.Lines.SubTaxCode +':' +
                                       '         Percetage :' +CurrValue(SalesTaxCode.Lines.Percentage )+
                                       '         TaxAmount:' +CurrValue(SalesTaxCode.Lines.TaxAmount ));

                      SalesTaxCode.Lines.Next;
              end;

              LineTaxTotal      := SalesTaxCode.TotalTax;
              AddPriceCalcDesc('LineTaxTotal :' + CurrValue(LineTaxTotal));
              TotalLineAmountInc:= SalesTaxCode.TotalLineAmountInc;
              AddPriceCalcDesc('TotalLineAmountInc :' + CurrValue(TotalLineAmountInc));
              fdTotalinc:=TotalLineAmountInc;
              if SalesTaxBasedonProductPrice then begin
                      AddPriceCalcDesc('Sales Tax Based on :  Product Price' );
                      TotalLineAmountInc := Round(TotalLineAmountInc -
                                                  fdTotalEx * DiscountPercent/100 +
                                                  fdTotalEx * MarkupPercent  /100-
                                                  Discountamount +
                                                  MarkupAmount, CurrencyRoundPlaces);
                      AddPriceCalcDesc('TotalLineAmountInc Discounted:'   + CurrValue(TotalLineAmountInc ));
              end;
              TotalLineAmount := TotalLineAmountInc - LineTaxTotal;
              AddPriceCalcDesc('TotalLineAmount (TotalLineAmountInc- tax) :'   + CurrValue(TotalLineAmount ));
              if (QtyShipped <> 0.00) then begin
                UOMLinePrice := Round(DivZer(TotalLineAmount,self.UOMQtyShipped), RoundPlacesGeneral);
                UOMLinePriceInc   := Round(DivZer(TotalLineAmountInc,UOMQtyShipped) ,CurrencyRoundPlaces);
                LinePriceInc      := Round(DivZer(UOMLinePriceInc,UOMMultiplier), CurrencyRoundPlaces);
                LinePrice := Round(DivZer(UOMLinePrice,UOMMultiplier),RoundPlacesGeneral);
              end else begin
                if LineTaxRate =0 then
                     LinePriceInc := LinePrice
                else LinePriceInc := Round(LinePrice * (1.0 + LineTaxRate), RoundPlacesGeneral); { New Discounted LinePrice (Inc) }
              end;

(* //// I think this is repetitive
              if (Self.DiscountAmount <> 0) or (Self.MarkupAmount <> 0) or (Self.DiscountPercent <> 0) or (Self.MarkupPercent <> 0) then begin
                      { we need to apply markup and/or to total inc price then work back to calc tax }
                      TotalLineAmountInc := TotalLineAmountInc - DiscountAmount + MarkupAmount; { Adjust total for line discount and markup. }
                      {  back calculate taxes and total ex .. }
                      if SalesTaxBasedonSalesPrice then begin
                              SalesTaxCode.CalcTaxFromLineTotalInc(TotalLineAmountInc);
                              TotalLineAmount := SalesTaxCode.TotalLineAmount;
                              LineTaxTotal := SalesTaxCode.TotalTax;
                      end else begin
                              TotalLineAmount := TotalLineAmountinc -LineTaxTotal;
                      end;

                      if (QtyShipped <> 0.00) then begin
                              UOMLinePrice := Round(DivZer(TotalLineAmount,self.UOMQtyShipped), RoundPlacesGeneral);
                              LinePrice := Round(DivZer(UOMLinePrice,UOMMultiplier),RoundPlacesGeneral);
                              UOMLinePriceInc := Round(DivZer(TotalLineAmountInc,self.UOMQtyShipped), RoundPlacesGeneral);
                              LinePriceInc := Round(DivZer(UOMLinePriceInc,UOMMultiplier),RoundPlacesGeneral);
                      end else begin
                              { nothing shipped .. }
                              {Dene / Simon wants to calculate the price on backorder as well }
                              { NOTE: we dont need to do this as LinePrice with discount / markup percent already done above }
                              //LinePrice := Round(LinePrice -
                              //              (LinePrice * (DiscountPercent / 100)) +
                              //              (LinePrice * (MarkupPercent / 100)), RoundPlacesGeneral);

                              { NOTE this may not be correct if and of the sub taxes have a cap amount ..
                                  really need to re do calc steps assuming whole order quantity shipped to get this figure}
                              LinePriceInc := Round(LinePrice * (1.0 + LineTaxRate), RoundPlacesGeneral); { New Discounted LinePrice (Inc) }
                      end;

              end;*)

      end;

      Self.LineCostInc := Round(GetAmountInc(LineCost, LineTaxRate), RoundPlacesGeneral);
      Self.Attrib1Sale := Product.Attrib1Sale * Self.QtyShipped;
      Self.Attrib2Sale := Product.Attrib2Purchase * Self.QtyShipped;
      Self.Attrib1SaleRate := Product.Attrib1SaleRate;
      Self.Attrib1SaleEst := Product.Attrib1Sale * Self.QtySold;
      Self.Attrib2SaleEst := Product.Attrib2Purchase * Self.Qtysold;
      //LogPrice;
      inherited;
  finally
    if (MarginAmount =0) and (LinePrice<>0) and (LineCost<>0) then
      MarginPercent := DivZer((LinePrice-LineCost),LinePrice)*100;
    if MarginPercent >0 then
      if Appenv.Employee.MinimumMarginPercentage >0 then
        if MarginPercent < Appenv.Employee.MinimumMarginPercentage then
                ResultStatus.AddItem(True, rssInfo, BOR_Sales_ErrorSalesMargin, 'Current Margin ' + FloattostrF(MarginPercent , ffGeneral, 15,2)+' % is less than ' +
                            ' the Minimum Margin Set ' + FloattostrF(Appenv.Employee.MinimumMarginPercentage , ffGeneral, 15,2) +'% in the Preference.');
  end;
finally
	Self.DiscountedPrice        := LinePrice;
	Self.DiscountedPriceInc     := LinePriceInc;
	Self.TotalDiscountedPrice   := totalLineamount;
	Self.TotalDiscountedPriceInc:= totalLineamountinc;
end;
end;

procedure TSalesLineBase.CalcProductLatestCost;
var
  fd:Double;
begin
  if ProductID =0 then exit;

  fd     := LineCost;
  if (AppEnv.CompanyPrefs.ShowLatestCost)  then
         if AppEnv.CompanyPrefs.SalesLineLatestCostBasedOn = lcbPurchaseOrder   then fd:= Product.LatestCost
    else if AppEnv.CompanyPrefs.SalesLineLatestCostBasedOn = lcbProductCard     then fd:= Product.BuyQty1Cost
    else if AppEnv.CompanyPrefs.SalesLineLatestCostBasedOn = lcbAvgCost         then fd:= Product.AverageCost
    else if AppEnv.CompanyPrefs.SalesLineLatestCostBasedOn = lcbHighest         then fd:= Highest([Product.LatestCost,Product.BuyQty1Cost ,Product.AverageCost])
    else fd:= Lowest([Product.LatestCost,Product.BuyQty1Cost ,Product.AverageCost]);

  if not SameValue(LatestCostPrice   , fd ,0 ) then begin
    LatestCostPrice   := fd;
    LatestCostPriceInc:= GetAmountInc(fd, Product.TaxSales.Rate);
    //SendEvent(BusObjEvent_Change, BusObjEventVal_SalesLineCost, self);
  end;
end;
Function TSalesLineBase.IgnoreBOMCalcPriceOnSale :Boolean;
begin
  REsult := Appenv.companyprefs.IgnoreBOMCalcPriceOnSale;
end;
function TSalesLineBase.ImportsubClasses(const Node: IXMLNode): Boolean;
Var
  X        : Integer;
  Singlerec: IXMLNode;
Begin
  Result          := False;
  ImportFailed    := False;
  XMLPropertyName := FESalesLines.XMLBranchName;
  XMLPropertyNode := Node.ChildNodes.FindNode(XMLPropertyName);
  If Assigned(XMLPropertyNode) Then Begin
    For X                        := 0 To XMLPropertyNode.ChildNodes.Count - 1 Do Begin
      FESalesLines.ImportingFromXMLFile := True;
      Singlerec                  := XMLPropertyNode.ChildNodes[X];
      FESalesLines.ImportFromXML(SingleRec);
      ImportFailed := FESalesLines.ImportFailed;
      If Error Then Exit;
    End;
  End;
  ImportFailed := False;
  Result       := True;

end;

procedure TSalesLineBase.CalcTreePrice;
begin
end;

procedure TSalesLineBase.CallDoFieldOnChange(Sender: TField);
begin
  DoFieldOnChange(Sender);
end;

function TSalesLineBase.GetTransDate: TDatetime;
begin
  Result := 0;
  if Assigned(Self.Owner) then
    if Self.Owner is TSalesBase then Result := TSalesBase(Self.Owner).Saledatetime;
end;

function TSalesLineBase.GetSalesTaxCode: TSalesTaxCode;
begin
  Result := TSalesTaxCode(getContainercomponent(TSalesTaxCode, 'SaleID = ' + inttostr(HeaderID) + ' and SaleLineId = ' + inttostr(ID)));
  Result.IgnoreAccesslevel := True;
end;

function TSalesLineBase.GetTransTaxCode: TTransTaxCode;
begin
  Result := GetSalesTaxCode;
end;

function TSalesLineBase.Getalloctype: string;
begin
  Result := 'OUT';
end;

procedure TSalesLineBase.GetBaseLinePrice;
var
  RetPriceEx, RetDiscountPercent: Double;
  RetDesc, RetMsg: string;
begin
    LogD('TSalesLineBase.GetBaseLinePrice', lbBegin);
  try
  if Assigned(Self.Owner) then
    if Self.Owner is TSalesbase then
    if (not Sysutils.SameText(Self.ProductName, 'CONVERT FROM QUOTE')) and (not TSalesBase(Self.Owner).convertingSO) and (not TSalesBase(Self.Owner).convertingQuote) then begin
      Self.LinePrice              := 0;
      Self.DiscountPercent        := 0;
      Self.DiscountAmount         := 0;
      Self.MarkupAmount           := 0;
      Self.MarkupPercent          := 0;
      Self.MarginAmount           := 0;
      Self.MarginPercent          := 0;
      Self.DiscountedPrice        := 0;
      Self.DiscountedPriceInc     := 0;
      Self.TotalDiscountedPrice   := 0;
      Self.TotalDiscountedPriceInc:= 0;

      if ProductID < 1 then Exit;

           if ParthasPriceMatrix(Product.ID) and (MatrixPrice <> 0) then Self.OriginalLinePrice := MatrixPrice
      //else if hasTree and appenv.companyprefs.BOMPriceOverridesAllOtherPrice then DoContainerEvent(Self, evSalesAfterGetBaseLinePrice)
      else begin
        Self.OriginalLinePrice := Product.GetPriceForQty(Self.QtySold);
        //Self.OriginalLinePrice := Product.SellQty1Price;
        CalcTreePrice;
      end;

//      if Self.HireQuantity <> 0 then begin

//      end else begin

            if TSalesBase(Self.Owner).ClientID > 0 then begin
              { Calculate price after discounts }
              RetMsg := '';
              if ClientDiscountObj.ClientPrice_Discounts(TSalesBase(Self.Owner).ClientID,TSalesBase(Self.Owner).TermsName, ProductID, UnitOfMeasureID, TSalesBase(Self.Owner).SaleClassId, QtySold, TSalesBase(Self.Owner).SaleDate,
                TSalesBase(Self.Owner).UseWholesalePrice, RetPriceEx, RetDiscountPercent, RetDesc, RetMsg, True, MatrixRef, hastree) then begin
                Self.DiscountPercent := RetDiscountPercent * 100;
                if (ClientDiscountObj.DiscountType = SPEC_PRICE_DISC) and (ClientDiscountObj.OverrideProductspecialPrice) and (RetPriceEx<>0) then
                  Self.OriginalLinePrice := RetPriceEx
                else if (ClientDiscountObj.DiscountType = PROD_GROUP_DISC) and (ClientDiscountObj.OverridePartsGroupDiscount) and (RetPriceEx<>0) then
                  Self.OriginalLinePrice := RetPriceEx
                else if not(Appenv.companyprefs.BOMPriceOverridesAllOtherPrice) OR (Self.OriginalLinePrice=0) then begin
                      if hastree and (OriginalLinePrice < RetPriceEx) then
                      else if RetDiscountPercent = 0 then Self.OriginalLinePrice := RetPriceEx;
                      if RetDesc <> '' then Self.ProductDescription := RetDesc;
                      if RetMsg <> '' then begin
                        ResultStatus.AddItem(True, rssInfo, 0, RetMsg);
                      end;
                end;
              end else begin
                if RetMsg <> '' then ResultStatus.AddItem(False, rssWarning, 0, RetMsg);
              end;
            end;

        { Get foreign price from product. }
//        Self.ForeignLinePrice := GetAmountInc(Product.ForeignPriceSell.GetSellPriceForCurrencyCode(TSalesBase(Self.Owner).ForeignExchangeCode, Self.QtySold, UnitOfMeasureID), LineTaxRate);
        { 13/3/15 should be no tax (gst) on foreign }
        if (TSalesBase(Self.Owner).ForeignExchangeCode<>'') and (TSalesBase(Self.Owner).ForeignExchangeCode <> Appenv.RegionalOptions.ForeignExDefault) then begin
            Self.ForeignLinePrice := Product.ForeignPriceSell.GetSellPriceForCurrencyCode(TSalesBase(Self.Owner).ForeignExchangeCode, Self.QtySold, UnitOfMeasureID);
            if Self.ForeignLinePrice <> 0 then begin

              { Should we use hedging with this product? }
              if Product.UseHedgingFormula then begin

                { Don't use discounts/markups with hedging }
                Self.DiscountPercent := 0;
                Self.DiscountAmount := 0;
                Self.MarkupAmount := 0;
                Self.MarkupPercent := 0;
                Self.MarginAmount := 0;
                Self.MarginPercent := 0;

                { Used for reporting. }
                Self.ForeignHedgingUsed := True;

                { Calculate hedged foreign price. }
                ForeignLinePrice := TSalesBase(Self.Owner).FxObj.GetHedgedAmountForRate(ForeignLinePrice, TSalesBase(Self.Owner).ForeignExchangeCode, TSalesBase(Self.Owner).ForeignExchangeRate);

              end else begin
                { Used for reporting. }
                Self.ForeignHedgingUsed := False;
              end;
            { Calculate line price from foreign price }
            Self.OriginalLinePrice := GetAmountEx(CommonLib.ForeignToLocal(Self.ForeignLinePrice, TSalesBase(Self.Owner).ForeignExchangeRate, Self.RoundPlacesGeneral), LineTaxRate);
          end;
        end
//      end;
    end;
    DoContainerEvent(Self, evSalesAfterGetBaseLinePrice);
  finally LogD('', lbEnd);
  end;
end;

function TSalesLineBase.GetBatchAllocated: boolean;
begin
  result := GetBooleanField('BatchAllocated');
end;

(*function TSalesLineBase.ChangeTotalQty(fdUOMQty: Double): Boolean;
var
  fbFlag:Boolean;
begin
  fbflag := DoFieldChangewhenDisabled;
  DoFieldChangewhenDisabled := True;
  try
    Self.UOMQtySold := fdUOMQty;
  finally
    DoFieldChangewhenDisabled := fbflag;
  end;
  PostDB;
end;*)

procedure TSalesLineBase.CheckSaveSpecialPrice;
begin
  if ProductName = TOTALDISCOUNT_PRODUCT then Exit;
  if fbignoreCheckSaveSpecialPrice then Exit;
  if (Self.AddingProdToSpecialPrice = False) and (Self.updatingRelPrQty = False) then begin
    Self.AddingProdToSpecialPrice := True;
    try
      if (not Self.SilentMode) then
        if (Assigned(Self.Owner)) and (Self.Owner is TCashSAle) and (sametext(TCashSAle(Self.Owner).CustomerName , CLIENT_CASH)) then begin
          if  (not AppEnv.CompanyPrefs.NoCashCustSpecialPriceQuestion) then begin
            AddEvent(BusObjEvent_Change, BusObjEventVal_SpecialPrice, Self.ID);
          end;
        end else if  (not AppEnv.CompanyPrefs.NoCustSpecialPriceQuestion) then begin
          AddEvent(BusObjEvent_Change, BusObjEventVal_SpecialPrice, Self.ID);
        end;
    finally Self.AddingProdToSpecialPrice := False;
    end;
  end;
end;

procedure TSalesLineBase.OnBeforeDataIdChange;
begin
  inherited;
  if Dataset.RecordCount > 500 then begin
    Container.Clear(TPQA);
    Container.Clear(TProductClass);
    Container.Clear(TProduct);
  end;
end;

procedure TSalesLineBase.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  fbInstantiatingTree := False;
  if Assigned(fClientDiscountObj) then FreeAndNil(fClientDiscountObj);
  // if Assigned(fFESalesLines)      then    FreeAndNil(fFESalesLines);
  if Assigned(fFESalesLines) then begin
    if (not fFESalesLines.ExternalDatasetAssigned) then begin
      FreeAndNil(fFESalesLines);
    end else begin
      fFESalesLines.Dataset.close;
    end;
  end;
end;

Procedure TSalesLineBase.OnProductChanged;
begin
  SendEvent(BusObjEvent_todo,BusObjEventVal_OpenLookuponProductChange , self);
  inherited OnProductChanged;
  //CalcProductLatestCost;
end;

procedure TSalesLineBase.LoadFromXMLNode(const node: IXMLNode);
var
//  fiCostCentreId: Integer;
  fiProductID: Integer;
  fiPartSpecID: Integer;
  // fiPrescriberTypeID: Integer;
  fiPArentProductId: Integer;
  fiUOMID: Integer;

begin
  { get IDs when importing from file }
//  fiCostCentreId := 0;
  fiProductID := 0;
  fiPartSpecID := 0;
  fiPArentProductId := 0;
  fiUOMID := 0;

  if ImportingFromXMLFile then begin
//    if GetXMLNodeStringValue(node, 'CostCentre') <> '' then fiCostCentreId := tcDataUtils.GetCostCentreID(GetXMLNodeStringValue(node, 'CostCentre'));
    if GetXMLNodeStringValue(node, 'ProductName') <> '' then fiProductID := tcDataUtils.GetProduct(GetXMLNodeStringValue(node, 'ProductName'));
    if GetXMLNodeStringValue(node, 'SpecDescription') <> '' then PartSpecID := tcDataUtils.GetPartSpecID(fiProductID, GetXMLNodeStringValue(node, 'SpecDescription'));
    if GetXMLNodeStringValue(node, 'ParentProductName') <> '' then fiPArentProductId := tcDataUtils.GetProduct(GetXMLNodeStringValue(node, 'ParentProductName'));
    if GetXMLNodeStringValue(node, 'UOM') <> '' then fiUOMID := tcDataUtils.GetUnitOfMeasureID(GetXMLNodeStringValue(node, 'UOM'));

  end else begin
//    SetPropertyFromNode(node, 'CostCentreId');
    SetPropertyFromNode(node, 'ProductID');
    SetPropertyFromNode(node, 'PartSpecID');
//    SetPropertyFromNode(node, 'ClonedFromId');
    SetPropertyFromNode(node, 'ParentProductID');
    SetPropertyFromNode(node, 'RefundedSalesLineID');
    SetPropertyFromNode(node, 'UnitOfMeasureID', 'UOMID');
//    fiCostCentreId := CostCentreId;
    fiProductID := ProductID;
    PartSpecID := PartSpecID;
    fiPArentProductId := ParentProductID;
    fiUOMID := UnitOfMeasureID;
    SetPropertyFromNode(node, 'HireLineId');
    SetPropertyFromNode(node, 'HirePartsSaleID');
    SetPropertyFromNode(node, 'RelatedProductProdLine');
  end;

  ProductID := fiProductID;
  SetPropertyFromNode(node, 'ProductName');
  SetPropertyFromNode(node, 'ProductGroup');
  SetPropertyFromNode(node, 'ProductDescription');
  SetPropertyFromNode(node, 'Product_Description_Memo');
  SetPropertyFromNode(node, 'ProductBarcode');
  SetPropertyFromNode(node, 'SalesTaxBasedon');
  SetPropertyFromNode(node, 'RelatedProductPatternName');
  SetPropertyFromNode(node, 'RelatedProductFormulaDescription');
  SetPropertyFromNode(node, 'BaseLineno');
  SetPropertyFromNode(node, 'MemoLine');
  SetPropertyFromNode(node, 'SalesLinesCustField1');
  SetPropertyFromNode(node, 'SalesLinesCustField2');
  SetPropertyFromNode(node, 'SalesLinesCustField3');
  SetPropertyFromNode(node, 'SalesLinesCustField4');
  SetPropertyFromNode(node, 'SalesLinesCustField5');
  SetPropertyFromNode(node, 'SalesLinesCustField6');
  SetPropertyFromNode(node, 'SalesLinesCustField7');
  SetPropertyFromNode(node, 'SalesLinesCustField8');
  SetPropertyFromNode(node, 'SalesLinesCustField9');
  SetPropertyFromNode(node, 'SalesLinesCustField10');
  SetPropertyFromNode(node, 'AssetAccount');
  SetPropertyFromNode(node, 'CogsAccount');
//  CostCentreId := fiCostCentreId;
  SetBooleanPropertyFromNode(node, 'Deleted');
  SetPropertyFromNode(node, 'ForeignTotalLineAmount');
  SetPropertyFromNode(node, 'IncomeAccount');
  SetBooleanPropertyFromNode(node, 'Invoiced');
  SetPropertyFromNode(node, 'Linecost');
  SetPropertyFromNode(node, 'LineCostInc');
  SetPropertyFromNode(node, 'LineNotes');
  SetPropertyFromNode(node, 'LineTaxTotal');
  SetPropertyFromNode(node, 'LineTaxCode');
  SetPropertyFromNode(node, 'LineTaxRate');
  SetPropertyFromNode(node, 'ProductType');
  if fiUOMID <> 0 then UnitOfMeasureID := fiUOMID;
  SetPropertyFromNode(node, 'UnitOfMeasure', 'UOM');
  SetPropertyFromNode(node, 'UOMMultiplier');
  if UpdatingBO=False then begin
    SetPropertyFromNode(node, 'QtySold');
    SetPropertyFromNode(node, 'Qtyshipped');
    SetPropertyFromNode(node, 'QtyBackOrder');
    SetPropertyFromNode(node, 'UOMQtyBackOrder');
    SetPropertyFromNode(node, 'UOMQtySold');
    SetPropertyFromNode(node, 'UOMQtyShipped');
  end else begin
    SetPropertyFromNode(node, 'QtySold' ,'QtyBackOrder');
    SetPropertyFromNode(node, 'UOMQtySold' , 'UOMQtyBackOrder');
    Qtyshipped    := 0;
    UOMQtyShipped := 0;
    SetPropertyFromNode(node, 'QtyBackOrder');
    SetPropertyFromNode(node, 'UOMQtyBackOrder');
  end;

  SetPropertyFromNode(node, 'SearchFilter');
  SetPropertyFromNode(node, 'SearchFilterCopy');
  SetPropertyFromNode(node, 'TotalLineAmount');
  SetPropertyFromNode(node, 'TotalLineAmountInc');
  SetPropertyFromNode(node, 'SerialNumbers');
  SetPropertyFromNode(node, 'LinePrice');
  SetPropertyFromNode(node, 'DiscountedPrice');
  SetPropertyFromNode(node, 'TotalDiscountedPrice');
  SetPropertyFromNode(node, 'OriginalLinePrice');
  SetPropertyFromNode(node, 'LinePriceInc');
  SetPropertyFromNode(node, 'DiscountedPriceInc');
  SetPropertyFromNode(node, 'TotalDiscountedPriceInc');
  SetPropertyFromNode(node, 'ForeignLinePrice');

  SetPropertyFromNode(node, 'DiscountAmount');
  SetPropertyFromNode(node, 'DiscountPercent');
  SetPropertyFromNode(node, 'MarkupAmount');
  SetPropertyFromNode(node, 'MarkupPercent');
  SetPropertyFromNode(node, 'MarginAmount');
  SetPropertyFromNode(node, 'MarginPercent');
  SetPropertyFromNode(node, 'Attrib1Sale');
  SetPropertyFromNode(node, 'Attrib2Sale');
  SetPropertyFromNode(node, 'Attrib1SaleRate');
  SetPropertyFromNode(node, 'Attrib1SaleEst');
  SetPropertyFromNode(node, 'Attrib2SaleEst');
  SetPropertyFromNode(node, 'SoldSerials');
  SetPropertyFromNode(node, 'SupplierName');
  SetBooleanPropertyFromNode(node, 'ForeignHedgingUsed');
  PartSpecID := fiPartSpecID;
  SetPropertyFromNode(node, 'SpecValue');
  SetPropertyFromNode(node, 'AreaQty');
  SetBooleanPropertyFromNode(node, 'IsRelatedProduct');
  SetBooleanPropertyFromNode(node, 'AutoSmartOrder');
  SetBooleanPropertyFromNode(node, 'SmartOrderCreated');
  SetPropertyFromNode(node, 'RelatedParentLineRef');
  SetBooleanPropertyFromNode(node, 'ISContainer');
  SetBooleanPropertyFromNode(node, 'IsPallet');
  SetPropertyFromNode(node, 'RelatedProductQty');
  ParentProductID := fiPArentProductId;
  SetPropertyFromNode(node, 'SpecDescription');
  SetPropertyFromNode(node, 'SortID');
  SetPropertyFromNode(node, 'LinesOrder');
  SetPropertyFromNode(node, 'SeqNo');
  SetDateTimePropertyFromNode(node, 'ShipDate');
  SetDateTimePropertyFromNode(node, 'ETDDate');
  SetPropertyFromNode(node, 'CustomData');
  ImportsubClasses(node);
  { this needs to be last so we have a id for PQA to work correctly }
  inherited;
end;

procedure TSalesLineBase.LoadInStockQty;
var
  qry: TERPQuery;
begin
  qry := DbSharedObj.GetQuery(Connection.Connection);
  try
    qry.SQL.add('Select ');
    qry.SQL.add('PC.ClassID            as ClassID, ');
    qry.SQL.add('PC.ClassName          as ClassName,');
    qry.SQL.add('P.PartsID             as PartsID,  ');
    qry.SQL.add('P.PartName            as PartName,');
    qry.SQL.add('P.ProductPrintName    as ProductPrintName,');
    qry.SQL.add(SQL4Qty(tAvailable) +' as   AvailableQty,');
    qry.SQL.add(SQL4Qty(tInstock)   +' as   InStockQty');
//    qry.SQL.add(SQL4Qty(tSO)        +' as   SOQty,');
//    qry.SQL.add(SQL4Qty(tSOBO)      +' as   SOBOQty,');
//    qry.SQL.add(SQL4Qty(tInvBO)     +' as   BOQty,');
//    qry.SQL.add(SQL4Qty(tPOBO)      +' as   OnOrderQty');
    qry.SQL.add('FROM ' + ProductTables(tProductList));
    qry.SQL.add('Where PC.ProductID = ' + IntToStr(self.ProductID));
    qry.SQL.add('AND PC.ClassID = ' + IntToStr(TSalesBase(Owner).SaleClassId));
    qry.SQL.add('group by PC.ClassID, PC.ClassName , PC.ProductID');
    qry.SQL.add('Order by  ClassName , PartName');
    qry.Open;
    Vars.Values.ByName['InStockUOMQty'].AsFloat := DivZer(qry.FieldByName('InStockQty').asFloat,self.UOMMultiplier);
    Vars.Values.ByName['AvailableUOMQty'].AsFloat := DivZer(qry.FieldByName('AvailableQty').asFloat,self.UOMMultiplier);
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
  Vars.Values.ByName['InStockQtyLoaded'].AsBoolean := true;
end;

procedure TSalesLineBase.LogDoFieldchange(Sender: TField);
begin
  inherited;
end;

procedure TSalesLineBase.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  if not SavingXMLTofile then begin
//    AddXMLNode(node, 'CostCentreId', CostCentreId);
    AddXMLNode(node, 'ProductID', ProductID);
    AddXMLNode(node, 'PartSpecID', PartSpecID);
//    AddXMLNode(node, 'ClonedFromId', ClonedFromId);
    // AddXMLNode(node,'PrescriberTypeID',PrescriberTypeID);
    AddXMLNode(node, 'ParentProductID', ParentProductID);
    AddXMLNode(node, 'RefundedSalesLineID', RefundedSalesLineID);
    AddXMLNode(node, 'UOMID', UnitOfMeasureID);
    AddXMLNode(node, 'HireLineId', HireLineId);
    AddXMLNode(node, 'HirePartsSaleID', HirePartsSaleID);
  end else begin
    // AddXMLNode(node,'SaleLineId',SaleLineId);
//    AddXMLNode(node, 'CostCentre', tcDataUtils.getCostCentrename(CostCentreId));
  end;;
  AddXMLNode(node, 'SortId', SortId);
  AddXMLNode(node, 'LinesOrder', LinesOrder);
  AddXMLNode(node, 'SeqNo', SeqNo);
  AddXMLNode(node, 'AssetAccount', AssetAccount);
  AddXMLNode(node, 'QtyBackOrder', QtyBackOrder);
  AddXMLNode(node, 'CogsAccount', CogsAccount);
  AddXMLNode(node, 'Deleted', Deleted);
  AddXMLNode(node, 'ForeignTotalLineAmount', ForeignTotalLineAmount);
  AddXMLNode(node, 'IncomeAccount', IncomeAccount);
  AddXMLNode(node, 'Invoiced', Invoiced);
  AddXMLNode(node, 'Linecost', LineCost);
  AddXMLNode(node, 'LineCostInc', LineCostInc);
  AddXMLNode(node, 'LineNotes', LineNotes);
  AddXMLNode(node, 'LineTaxTotal', LineTaxTotal);
  AddXMLNode(node, 'LineTaxCode', LineTaxCode);
  AddXMLNode(node, 'LineTaxRate', LineTaxRate);
  AddXMLNode(node, 'ProductType', ProductType);
  AddXMLNode(node, 'ProductDescription', ProductDescription);
  AddXMLNode(node, 'Product_Description_Memo', Product_Description_Memo);
  AddXMLNode(node, 'ProductBarcode', ProductBarcode);
  AddXMLNode(node, 'SalesTaxBasedon', SalesTaxBasedon);
  AddXMLNode(node, 'RelatedProductPatternName', RelatedProductPatternName);
  AddXMLNode(node, 'RelatedProductFormulaDescription', RelatedProductFormulaDescription);
  AddXMLNode(node, 'BaseLineno', BaseLineno);
  AddXMLNode(node, 'MemoLine', MemoLine);
  AddXMLNode(node, 'SalesLinesCustField1', SalesLinesCustField1);
  AddXMLNode(node, 'SalesLinesCustField2', SalesLinesCustField2);
  AddXMLNode(node, 'SalesLinesCustField3', SalesLinesCustField3);
  AddXMLNode(node, 'SalesLinesCustField4', SalesLinesCustField4);
  AddXMLNode(node, 'SalesLinesCustField5', SalesLinesCustField5);
  AddXMLNode(node, 'SalesLinesCustField6', SalesLinesCustField6);
  AddXMLNode(node, 'SalesLinesCustField7', SalesLinesCustField7);
  AddXMLNode(node, 'SalesLinesCustField8', SalesLinesCustField8);
  AddXMLNode(node, 'SalesLinesCustField9', SalesLinesCustField9);
  AddXMLNode(node, 'SalesLinesCustField10', SalesLinesCustField10);
  AddXMLNode(node, 'ProductGroup', ProductGroup);
  AddXMLNode(node, 'ProductName', ProductName);
  AddXMLNode(node, 'UOM', UnitOfMeasure);
  AddXMLNode(node, 'UOMMultiplier', UOMMultiplier);
  AddXMLNode(node, 'ParentProductName', tcDataUtils.GetProduct(ParentProductID));
  AddXMLNode(node, 'QtySold', QtySold);
  AddXMLNode(node, 'SearchFilter', SearchFilter);
  AddXMLNode(node, 'SearchFilterCopy', SearchFilterCopy);
  AddXMLNode(node, 'Qtyshipped', QtyShipped);
  AddXMLNode(node, 'TotalLineAmount', TotalLineAmount);
  AddXMLNode(node, 'TotalLineAmountInc', TotalLineAmountInc);
  AddXMLNode(node, 'UOMQtyBackOrder', UOMQtyBackOrder);
  AddXMLNode(node, 'UOMQtySold', UOMQtySold);
  AddXMLNode(node, 'UOMQtyShipped', UOMQtyShipped);
  AddXMLNode(node, 'SerialNumbers', SerialNumbers);
  AddXMLNode(node, 'LinePrice', LinePrice);
  AddXMLNode(node, 'DiscountedPrice', DiscountedPrice);
  AddXMLNode(node, 'TotalDiscountedPrice', TotalDiscountedPrice);
  AddXMLNode(node, 'OriginalLinePrice', OriginalLinePrice);
  AddXMLNode(node, 'LinePriceInc', LinePriceInc);
  AddXMLNode(node, 'DiscountedPriceInc', DiscountedPriceInc);
  AddXMLNode(node, 'TotalDiscountedPriceInc', TotalDiscountedPriceInc);
  AddXMLNode(node, 'ForeignLinePrice', ForeignLinePrice);
  AddXMLNode(node, 'DiscountAmount', DiscountAmount);
  AddXMLNode(node, 'DiscountPercent', DiscountPercent);
  AddXMLNode(node, 'MarkupAmount', MarkupAmount);
  AddXMLNode(node, 'MarkupPercent', MarkupPercent);
  AddXMLNode(node, 'MarginAmount', MarginAmount);
  AddXMLNode(node, 'MarginPercent', MarginPercent);
  AddXMLNode(node, 'Attrib1Sale', Attrib1Sale);
  AddXMLNode(node, 'Attrib2Sale', Attrib2Sale);
  AddXMLNode(node, 'Attrib1SaleRate', Attrib1SaleRate);
  AddXMLNode(node, 'Attrib1SaleEst', Attrib1SaleEst);
  AddXMLNode(node, 'Attrib2SaleEst', Attrib2SaleEst);
  AddXMLNode(node, 'SoldSerials', SoldSerials);
  AddXMLNode(node, 'SupplierName', SupplierName);
  AddXMLNode(node, 'ForeignHedgingUsed', ForeignHedgingUsed);
  AddXMLNode(node, 'SpecValue', SpecValue);
  AddXMLNode(node, 'AreaQty', AreaQty);
  AddXMLNode(node, 'IsRelatedProduct', IsRelatedProduct);
  AddXMLNode(node, 'AutoSmartOrder', AutoSmartOrder);
  AddXMLNode(node, 'SmartOrderCreated', SmartOrderCreated);
  AddXMLNode(node, 'RelatedParentLineRef', RelatedParentLineRef);
  AddXMLNode(node, 'ISContainer', ISContainer);
  AddXMLNode(node, 'IsPallet', IsPallet);
  AddXMLNode(node, 'RelatedProductQty', RelatedProductQty);
  AddXMLNode(node, 'Profit', Profit);
  AddXMLNode(node, 'ProfitPercent', ProfitPercent);
  AddXMLNode(node, 'ProfitInc', ProfitInc);
  AddXMLNode(node, 'ProfitPercentInc', ProfitPercentInc);
  AddXMLNode(node, 'GrossProfitPercentInc', GrossProfitPercentInc);
  AddXMLNode(node, 'SpecDescription', SpecDescription);
  AddXMLNode(node, 'ShipDate', ShipDate);
  AddXMLNode(node, 'ETDDate', ETDDate);
  AddXMLNode(node, 'CustomData', CustomData);
  AddXMLNode(node, 'RelatedProductProdLine', RelatedProductProdLine);

  // inherited;
end;


procedure TSalesLineBase.PostFERecords;
var
  bm: TBookMArk;
  Salelinehasformula: Boolean;
  fdQty :double;
begin
  fsRelatedParentLineRef := Self.Globalref;
  fiPArentProductId := Self.ProductID;
  // Iteraterecords(RemoveDeletedFELines);
  bm := Self.Dataset.Getbookmark;
  try
    { if formula selected for the same product then apply }
    Salelinehasformula := False;
    if FESalesLines.Lines.Locate('ProductId', Self.ProductID, []) then begin
      Salelinehasformula := True;

      FormulaQtySoldValue1 := FESalesLines.Field1;
      FormulaQtySoldValue2 := FESalesLines.Field2;
      FormulaQtySoldValue3 := FESalesLines.Field3;
      FormulaQtySoldValue4 := FESalesLines.Field4;
      FormulaQtySoldValue5 := FESalesLines.Field5;
      FormulaQtySoldValue  := FESalesLines.Lines.RelatedQty;

      FormulaQtyShippedValue1 := FESalesLines.ShippedField1;
      FormulaQtyShippedValue2 := FESalesLines.ShippedField2;
      FormulaQtyShippedValue3 := FESalesLines.ShippedField3;
      FormulaQtyShippedValue4 := FESalesLines.ShippedField4;
      FormulaQtyShippedValue5 := FESalesLines.ShippedField5;
      FormulaQtyShippedValue  := FESalesLines.Lines.RelatedShippedQty;


      fdQty := FormulaQtySoldValue;
      if IsRelatedProduct then fdQty := fdQty * ParentLineQtySold;
      QtySold := fdQty;
      UOMQtySold := CommonLib.Round(QtySold / UOMMultiplier, Self.RoundPlacesGeneral);

      If Appenv.CompanyPrefs.EnableBoinBOMsalesOrder Then Begin
        fdQty := FormulaQtyShippedValue;
        if IsRelatedProduct then fdQty := fdQty * ParentLineQtyShipped;
        if QtySold <fdQty then begin
          QtySold := fdQty;
          UOMQtySold := CommonLib.Round(QtySold / UOMMultiplier, Self.RoundPlacesGeneral);
        end;
      End;
      QtyShipped := fdQty;
      UOMQtyShipped := CommonLib.Round(QtyShipped / UOMMultiplier, Self.RoundPlacesGeneral);

      FormulaID := FESalesLines.Lines.FormulaID;
      PostDB;
    end;
    if (((FESalesLines.Count >= 1) and (Salelinehasformula = False)) or (FESalesLines.Count > 2)) and (Product.isDiscontinued = False) and (UOMQtySold = 0) then begin
      UOMQtySold := 1;
      PostDB;
    end;
    FESalesLines.Lines.IterateREcords(CreateSalesLinesfromFELines, True);
  finally
    Self.Dataset.gotobookmark(bm);
    Self.Dataset.FreeBookmark(bm);
  end;
  updaterelatedPartsQty;
end;
function TSalesLineBase.ParentLineQtySold: double;
var
  Qry :TERPQuery;
begin
  Qry := DbSharedObj.GetQuery(connection.Connection);
  try
    Qry.sql.text := 'Select QtySold from tblsaleslines where globalref = '+quotedstr(RelatedParentLineRef);
    Qry.open;
    Result := Qry.fieldbyname('QtySold').asFloat;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;

function TSalesLineBase.ParentLineQtyShipped: double;
var
  Qry :TERPQuery;
begin
  Qry := DbSharedObj.GetQuery(connection.Connection);
  try
    Qry.sql.text := 'Select Shipped from tblsaleslines where globalref = '+quotedstr(RelatedParentLineRef);
    Qry.open;
    Result := Qry.fieldbyname('Shipped').asFloat;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;
procedure TSalesLineBase.CreateSalesLinesfromFELines(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TFESaleslinesRelatedPrs) then Exit;
  if fiPArentProductId = TFESaleslinesRelatedPrs(Sender).ProductID then begin
  end else begin
    if not(Dataset.Locate('IsFormulaRElatedProduct;ProductID;RelatedParentLineRef;RelatedParentProductID;FormulaID', VarArrayof(['T', TFESaleslinesRelatedPrs(Sender).ProductID, fsRelatedParentLineRef,
      fiPArentProductId, TFESaleslinesRelatedPrs(Sender).FormulaID]), [])) then begin
      if TFESaleslinesRelatedPrs(Sender).Deleted = False then begin
        Self.Dataset.Last;
        Self.Dataset.Append;
        Self.IsRelatedProduct := False;
        Self.IsFormulaRElatedProduct := True;
        Self.ProductID := TFESaleslinesRelatedPrs(Sender).ProductID;
        Self.ParentProductID := fiPArentProductId;
        Self.RelatedProductQty := TFESaleslinesRelatedPrs(Sender).RelatedQty;
        Self.RelatedParentLineRef := fsRelatedParentLineRef;
        Self.FormulaID := TFESaleslinesRelatedPrs(Sender).FormulaID;
        Self.QtySold := 0;
        Self.QtyShipped := 0;
        QtyBackOrder := 0;
        UOMQtySold := 0;
        UOMQtyShipped := 0;
        UOMQtyBackOrder := 0;
        Self.PostDB;
      end;
    end else begin
      if TFESaleslinesRelatedPrs(Sender).Deleted then Self.DeleteRecord
      else Self.RelatedProductQty := TFESaleslinesRelatedPrs(Sender).RelatedQty;
      Self.PostDB;
    end;
  end;
end;

(*Procedure TSalesLineBase.InitUOM(Const Sender: TField);
begin
  InitUOM(Sender.Value , sender.OldValue);
end;
Procedure TSalesLineBase.InitUOM(const UOMName, UOMNameOldValue:String);
begin
  if productId<>0 then begin
      Product.UOMList.Closedb;
      Product.UOMList.OpenDb;
      if Product.ProductUOMLocate(UOMName)  then begin
        Self.UOMMultiplier := Product.UOMList.Multiplier;
        Self.UnitOfMeasureID := Product.UOMList.ID;
        Self.UnitOfMeasure := Product.UOMList.UOMName;
        SendEvent(BusObjEvent_Change, BusObjEventVal_uomChanged, self);
      end else begin
        if not VarIsNull(UOMNameOldValue) then begin
          unitofmeasure:= UOMNameOldValue;
          Exit;
        end
        else Self.UOMMultiplier := 0;
      end;
      PostDB;
      if not RawMode then begin
        CalcLineTotals;
        UOMQtySold := Round(DivZer(QtySold, UOMMultiplier), Self.RoundPlacesGeneral);
        UOMQtyShipped := Round(DivZer(QtyShipped, UOMMultiplier), Self.RoundPlacesGeneral);
        UOMQtyBackOrder := Round(DivZer(QtyBackOrder, UOMMultiplier), Self.RoundPlacesGeneral);
      end;
    end;
end;*)
procedure TSalesLineBase.DoFieldOnChange(Sender: TField);
var
  doCalc: boolean;
  ADiscPrice:Double;
  Msg:String;
  aDiscountPercent, aDiscountAmount, aLinePrice:double;

  Procedure RemoveOtherDiscounts;
  begin
    if not Sysutils.SameText(Sender.FieldName, 'Discounts')       then Self.Discountamount  := 0;
    if not Sysutils.SameText(Sender.FieldName, 'DiscountPercent') then Self.DiscountPercent := 0;
    if not Sysutils.SameText(Sender.FieldName, 'Markup')          then Self.MarkupAmount    := 0;
    if not Sysutils.SameText(Sender.FieldName, 'MarkupPercent')   then Self.MarkupPercent   := 0;
    if not Sysutils.SameText(Sender.FieldName, 'Margin')          then Self.MarginAmount    := 0;
    if not Sysutils.SameText(Sender.FieldName, 'MarginPercent')   then Self.MarginPercent   := 0;
  end;

begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
      inherited;
      if Sysutils.SameText(Sender.FieldName, 'TotalLineAmount') or
        Sysutils.SameText(Sender.FieldName, 'TotalLineAmountinc') or
        Sysutils.SameText(Sender.FieldName, 'LinePrice') or
        Sysutils.SameText(Sender.FieldName, 'LinePriceInc') or
        Sysutils.SameText(Sender.FieldName, 'Discount') or
        Sysutils.SameText(Sender.FieldName, 'Markup') or
        Sysutils.SameText(Sender.FieldName, 'DiscountPercent') or
        Sysutils.SameText(Sender.FieldName, 'Markuppercent')  or
        Sysutils.SameText(Sender.FieldName, 'ForeignCurrencyLinePrice')  or
        Sysutils.SameText(Sender.FieldName, 'ForeignTotalLineAmount')  or
        Sysutils.SameText(Sender.FieldName, 'QtySold')  or
        Sysutils.SameText(Sender.FieldName, 'UnitofMeasureQtySold') or
        Sysutils.SameText(Sender.FieldName, 'ProductID') or
        Sysutils.SameText(Sender.FieldName, 'Productname') or
        Sysutils.SameText(Sender.FieldName, 'ProductPrintName') or
        Sysutils.SameText(Sender.FieldName, 'UnitofMeasureSaleLines') then begin
          MarginPercent:= 0;
          MarginAmount := 0;
        end;
      if Sysutils.SameText(Sender.FieldName, 'MarginPercent') then MarginAmount:= 0;
      if Sysutils.SameText(Sender.FieldName, 'Margin')        then MarginPercent := 0;

{----}if (Sysutils.SameText(Sender.FieldName, 'AreaQty')) then begin
        if AreaQty >0 then begin
          if product.AreaCoverageofsingleQty <>0 then begin
            QtySold := divzer(AreaQty , product.AreaCoverageofsingleQty);
            DoFieldOnChange(Dataset.findfield('QtySold'));
            if ((Self is TSalesOrderLine) and (Appenv.CompanyPrefs.SingleQtySO)) or
               (Self is TCashLineBase) or
               (Self is TQuoteLine) then begin
              QtyShipped := QtySold;
              DoFieldOnChange(Dataset.findfield('Shipped'));
            end;
          end;
        end;
{----}end else if (Sysutils.SameText(Sender.FieldName, 'UnitofMeasureQtySold')) or (Sysutils.SameText(Sender.FieldName, 'QtySold')) then begin
          if Appenv.CompanyPrefs.EnableAutoSplitQtyintoUOMinSales then
            if product.EnableAutoSplitQtyintoUOMinSales then
              if   (UOMQtySold <> 0) and ((trunc(divzer(UOMQtySold, UOMMultiplier)) <> divzer(UOMQtySold, UOMMultiplier)) or (UOMMultiplier=1)) then begin
                AddEvent(BusobjEvent_ToDo, BusobjEvent_AutosplitQty , Self.id);
              end;
          Vars.Values.ByName['InStockQtyLoaded'].AsBoolean := false;
{----}end else if (Sysutils.SameText(Sender.FieldName, 'Shipped')) or (Sysutils.SameText(Sender.FieldName, 'UnitOfMeasureShipped')) then begin
        if not RawMode then begin
          if (CleanQty = 0) and (Sender.AsFloat <> 0) then
            if AppEnv.CompanyPrefs.CurrentDateforSalesshipment then begin
              ShipDate := now;
              if Assigned(Owner) and (Owner is TSalesBase) then TSalesBase(Owner).SaleDate := now;
            end;
          Vars.Values.ByName['InStockQtyLoaded'].AsBoolean := false;
        end;
{----}end else if Sysutils.SameText(Sender.FieldName, 'UnitofMeasureSaleLines') then begin
        initUOM(Sender);
        Vars.Values.ByName['InStockQtyLoaded'].AsBoolean := false;
{----}end else if Sysutils.SameText(Sender.FieldName, 'LineCostInc') then begin
        if not RawMode then begin
          Self.LineCost := Round(Self.LineCostInc * (1 / (1 + Self.LineTaxRate)), RoundPlacesGeneral);
        end;
{----}end else if Sysutils.SameText(Sender.FieldName, 'LineCost') then begin
        if not RawMode then begin
          Self.LineCostInc := Round(Self.LineCost * (1 + Self.LineTaxRate), RoundPlacesGeneral);
        end;
{----}end else if Sysutils.SameText(Sender.FieldName, 'LineTaxCode') then begin
        if not RawMode then begin
          LineTaxRate := tcDataUtils.GetTaxRateForCode(LineTaxCode);
//          DiscountPercent := 0;
//          DiscountAmount := 0;
          CalcLineTotals;
        end;
{----}end else if Sysutils.SameText(Sender.FieldName, 'LineTax') then begin
        {Binny  - move this stuff to the XML processing }
        if not RawMode then begin
          if AllowTaxinput and (linetaxrate=0) and (linetaxtotal<>0)  then
            if not samevalue(totallineamountinc-totallineAmount , linetaxtotal) then begin
              //linetaxrate := GetPercent(totallineamountinc , totallineamountinc-LineTaxtotal);
              // walmart oders has the tax and inc amount in it, this is calculating the ex from it
              DoOnLineTaxChange;
            end;
          if (not convertingSO) and not(AllowTaxinput) then begin
            if Sender.asFloat <> 0 then begin
              Sender.Value := Sender.OldValue;
            end else begin
              LineTaxRate := 0;
              CalcLineTotals;
            end;
          end;
        end;
{----}end else if Sysutils.SameText(Sender.FieldName, 'Discounts') then begin
        if not RawMode then begin

          ADiscPrice :=0;
          aDiscountAmount := DiscountAmount;
          aDiscountPercent := 0;
          aLinePrice:= self.OriginalLinePrice*Qtyshipped;
          if IsGUI and (not TSalesDiscountValidationObj.ValidateDiscount(Self, aDiscountAmount , aDiscountPercent , Linecost , aLinePrice , ADiscPrice ,QtyShipped , ProductId , True, False, Msg)) then begin
            ResultStatus.AddItem(True, rssInfo, 0, Msg);
            Self.DiscountAmount := Sender.OldValue;
          end
          else begin
            RemoveOtherdiscounts;
            CalcLineTotals;
          end;
        end;
{----}end else if Sysutils.SameText(Sender.FieldName, 'DiscountPercent') then begin
        if not RawMode then begin

          doCalc := true;
          ADiscPrice :=0;
          aDiscountAmount := 0;
          aDiscountPercent := DiscountPercent;
          aLinePrice:=OriginalLinePrice*Qtyshipped;
          if IsGUI and (not TSalesDiscountValidationObj.ValidateDiscount(Self, aDiscountAmount , aDiscountPercent , Linecost , aLinePrice , ADiscPrice ,QtyShipped , ProductId , True, False, Msg))  then begin
              if Msg <> '' then ResultStatus.AddItem(True, rssInfo, 0, Msg);
              DiscountPercent := Sender.OldValue;
              doCalc := false;
          end;
          if doCalc then begin
            RemoveOtherDiscounts;
            CalcLineTotals;
          end;
        end;
{----}end else if Sysutils.SameText(Sender.FieldName, 'Markup') then begin
        if not RawMode then begin
          RemoveOtherDiscounts;
          CalcLineTotals;
        end;
{----}end else if Sysutils.SameText(Sender.FieldName, 'MarkupPercent') then begin
        if not RawMode then begin
          RemoveOtherDiscounts;
          CalcLineTotals;
        end;
{----}end else if Sysutils.SameText(Sender.FieldName, 'MarginPercent') then begin
          if not RawMode then begin
            if (Appenv.Employee.MinimumMarginPercentage >0) and (MarginPercent>0) then
              if MarginPercent/100 < Appenv.Employee.MinimumMarginPercentage then begin
                ResultStatus.AddItem(True, rssInfo, BOR_Sales_ErrorSalesMargin, 'Current Margin ' + FloattostrF(MarginPercent , ffGeneral, 15,2)+' % is less than ' +  NL+
                            'the Minimum Margin Set (' + FloattostrF(Appenv.Employee.MinimumMarginPercentage*100 , ffGeneral, 15,2) +'%) in the Preference.' + NL +  NL+
                            'Margin is set the the Minimum Required');

                PostDB;
                MarginPercent :=  Appenv.Employee.MinimumMarginPercentage*100;
                PostDB;
              end;
            RemoveOtherDiscounts;
            CalcLineTotals;
          end;
{----}end else if Sysutils.SameText(Sender.FieldName, 'Margin') then begin
          if not RawMode then begin
            RemoveOtherDiscounts;
            CalcLineTotals;
          end;
{----}end else if Sysutils.SameText(Sender.FieldName, 'TotalLineAmount') then begin
        if not RawMode then begin
          if QtyShipped = 0 then begin
            PostDB;
            TotalLineAmountInc := 0;
            TotalLineAmount := 0;
            LineTaxTotal := 0;
          end else begin
            TotalLineAmountInc := Round(TotalLineAmount * (1 + LineTaxRate), (*RoundPlacesGeneral*)CurrencyRoundPlaces);
            LineTaxTotal := Round(TotalLineAmountInc - TotalLineAmount,RoundPlacesGeneral);
            if not(convertingQuote or convertingSO or ConvertingRepairs or ConvertingHire) then CalcLinePriceFromTotal;
          end;
          TotalDiscountedPrice := TotalLineamount;
          TotalDiscountedPriceInc :=TotalLineamountInc;
        end;
{----}end else if Sysutils.SameText(Sender.FieldName, 'TotalLineAmountInc') then begin
        if not RawMode then begin
          if QtyShipped = 0 then begin
            PostDB;
            EditDB;
            TotalLineAmountInc := 0;
            TotalLineAmount := 0;
            LineTaxTotal := 0;
            PostDB;
          end else begin
            TotalLineAmount := Round(TotalLineAmountInc / (1 + LineTaxRate), (*Self.RoundPlacesGeneral*)CurrencyRoundPlaces);
            LineTaxTotal := Round(TotalLineAmountInc - TotalLineAmount,RoundPlacesGeneral);
            try
              if not(convertingQuote or convertingSO or ConvertingRepairs or ConvertingHire) then CalcLinePriceFromTotal;
            Except
            end;
          end;
          TotalDiscountedPrice := TotalLineamount;
          TotalDiscountedPriceInc :=TotalLineamountInc;
        end;
{----}end else if Sysutils.SameText(Sender.FieldName, 'ShipDate') then begin
        if not RawMode then begin
          DoContainerEvent(Self, evSalesLineShipDateChange, Sender);
        end;
{----}end else if Sysutils.SameText(Sender.FieldName, 'Assembled') and Assembled then begin
        if not RequiresAssembly then  Assembled := false;
{----}end else if Sysutils.SameText(Sender.FieldName, 'TillId') then begin
        SendEvent(BusObjEvent_Change, BusObjEventVal_tillChanged, self);
(*{----}end else if Sysutils.SameText(Sender.FieldName, 'FormulaID') then begin
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
                  SendEvent(BusObjEvent_Change, BusObjEventVal_FormulaValue, self);*)
{----}end else if Sysutils.SameText(Sender.FieldName, 'RelatedProductFormulaDescription') then begin
{----}end else if Sysutils.SameText(Sender.FieldName, 'DiscountedPrice') then begin
          if DiscountedPrice <> lineprice then begin
            if originallineprice <> 0 then begin
              DiscountAmount := (originallineprice - DiscountedPrice)*Qtyshipped;
              DoFieldOnChange(Dataset.findfield('Discounts'));
            end else if  lineprice <> 0 then begin
              DiscountAmount := (lineprice - DiscountedPrice)*Qtyshipped;
              DoFieldOnChange(Dataset.findfield('Discounts'));
            end else begin
              lineprice := DiscountedPrice;
              DoFieldOnChange(Dataset.findfield('lineprice'));
            end;
          end;
{----}end else if Sysutils.SameText(Sender.FieldName, 'DiscountedPriceinc') then begin
            if originallinepriceinc <> 0 then begin
              DiscountAmount := (originallinepriceinc - DiscountedPriceinc)*Qtyshipped;
              DoFieldOnChange(Dataset.findfield('Discounts'));
            end else if  linepriceinc <> 0 then begin
              DiscountAmount := (linepriceinc - DiscountedPriceinc)*Qtyshipped;
              DoFieldOnChange(Dataset.findfield('Discounts'));
            end else begin
              linepriceinc := DiscountedPriceinc;
              DoFieldOnChange(Dataset.findfield('linepriceinc'));
            end;
{----}end else if Sysutils.SameText(Sender.FieldName, 'TotalDiscountedPrice') then begin
          if TotalDiscountedPrice <> TotalLineamount then begin
              (*DiscountedPrice := DivZer(TotalDiscountedPrice, qtyshipped);
              DoFieldOnChange(Dataset.findfield('DiscountedPrice'));*)
              DiscountAmount := originallineprice*qtyshipped - TotalDiscountedPrice;
              DoFieldOnChange(Dataset.findfield('Discounts'));
          end;
{----}end else if Sysutils.SameText(Sender.FieldName, 'TotalDiscountedPriceinc') then begin
(*              DiscountedPriceinc := DivZer(TotalDiscountedPrice, qtyshipped);
              DoFieldOnChange(Dataset.findfield('DiscountedPriceinc'));*)
              DiscountAmount := originallinepriceinc*qtyshipped - TotalDiscountedPriceinc;
              DoFieldOnChange(Dataset.findfield('Discounts'));
{----}end else if Sysutils.SameText(Sender.FieldName, 'LinePrice') then begin
          DiscountedPrice := linePrice;
          DiscountedPriceInc :=LinePriceInc;
{----}end else if Sysutils.SameText(Sender.FieldName, 'LinePriceInc') then begin
          DiscountedPrice := linePrice;
          DiscountedPriceInc :=LinePriceInc;
      end;
end;
procedure TSalesLineBase.DoOnLineTaxChange;
begin
              // totalamountinc and Tax rate is from Avalara
              totallineAmount := Round(GetAmountEx(totallineAmountInc, LineTaxRate), CurrencyRoundPlaces);
              linePriceinc := Round(divzer(totallineAmountinc,qtyshipped), RoundPlacesGeneral);
              linePrice := Round(GetAmountEx(linePriceInc, LineTaxRate), RoundPlacesGeneral);
end;

Procedure TSalesLineBase.initRelatedProductFormulaDescription;
var
  Qry :TERPQuery;
begin
  postdb;
  Qry := DbSharedObj.GetQuery(connection.Connection);
  try
    Qry.sql.text := 'select ' +
                    ' replace(replace(replace(replace(replace(replace(fe.Formula ,  "Field1" , ifnull(sl.FormulaQtyShippedValue1,0)),  ' +
                                                                                  ' "Field2" , ifnull(sl.FormulaQtyShippedValue2,0)),  ' +
                                                                                  ' "Field3" , ifnull(sl.FormulaQtyShippedValue3,0)),  ' +
                                                                                  ' "Field4" , ifnull(sl.FormulaQtyShippedValue4,0)),  ' +
                                                                                  ' "Field5" , ifnull(sl.FormulaQtyShippedValue5,0)) , "*" , " X ") as formulavalue,  ' +
                    'sl.FormulaQtyShippedValue1,sl.FormulaQtyShippedValue2,sl.FormulaQtyShippedValue3,sl.FormulaQtyShippedValue4,sl.FormulaQtyShippedValue5 '+
                    ' from tblsaleslines sl inner join tblfeformula fe on sl.FormulaID = fe.FormulaID ' +
                    ' Where sl.salelineid = '+inttostr(ID);
    Qry.open;
    SendEvent(BusObjEvent_ToDo, BusObjEvent_CheckDescriptionField, Self);
    if RelatedProductFormulaDescriptionUsing =0 then
      RelatedProductFormulaDescription := Productname +' ' + Qry.FieldByName('formulavalue').AsString
    else
      RelatedProductFormulaDescription := Productname +' ' +
                                          iif(Appenv.companyprefs.Fe1Visible ,        Floattostrf(Qry.FieldByName('FormulaQtyShippedValue1').asFloat ,ffGeneral , 15,2)+
                                          iif(Appenv.companyprefs.Fe2Visible , ' X ' +Floattostrf(Qry.FieldByName('FormulaQtyShippedValue2').asFloat ,ffGeneral , 15,2)+
                                          iif(Appenv.companyprefs.Fe3Visible , ' X ' +Floattostrf(Qry.FieldByName('FormulaQtyShippedValue3').asFloat ,ffGeneral , 15,2)+
                                          iif(Appenv.companyprefs.Fe4Visible , ' X ' +Floattostrf(Qry.FieldByName('FormulaQtyShippedValue4').asFloat ,ffGeneral , 15,2)+
                                          iif(Appenv.companyprefs.Fe5Visible , ' X ' +Floattostrf(Qry.FieldByName('FormulaQtyShippedValue5').asFloat ,ffGeneral , 15,2) , '') , '') , '') , '') , '') ;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
(*  RelatedProductFormulaDescription := Productname;
  if Appenv.companyprefs.Fe1Visible then RelatedProductFormulaDescription := RelatedProductFormulaDescription + Trim(FloattostrF(ffGeneral ,FormulaQtySoldValue1 , 15, 2));
  if Appenv.companyprefs.Fe2Visible then RelatedProductFormulaDescription := RelatedProductFormulaDescription + Trim(FloattostrF(ffGeneral ,FormulaQtySoldValue2 , 15, 2));
  if Appenv.companyprefs.Fe3Visible then RelatedProductFormulaDescription := RelatedProductFormulaDescription + Trim(FloattostrF(ffGeneral ,FormulaQtySoldValue3 , 15, 2));
  if Appenv.companyprefs.Fe4Visible then RelatedProductFormulaDescription := RelatedProductFormulaDescription + Trim(FloattostrF(ffGeneral ,FormulaQtySoldValue4 , 15, 2));
  if Appenv.companyprefs.Fe5Visible then RelatedProductFormulaDescription := RelatedProductFormulaDescription + Trim(FloattostrF(ffGeneral ,FormulaQtySoldValue5 , 15, 2));*)


end;
procedure TSalesLineBase.DoProductSelect;
begin
  //if ProcPrefs.WastageCalculationEnabled  then begin
    if (Self is TSalesOrderLine) and   not(TSalesOrderLine(Self).TreeFinalized) then begin
      DoContainerEvent(Self, evSalesLineMakeCleanTree);
      SendEvent(BusObjEvent_Change, BusObjEventVal_QtyShipped, Self);
    end;
  //end;
end;
Procedure TSaleslineBase.DoAddRElatedProducts;
var
  fiId :Integer;
  fbFlag:Boolean;
begin
  Dataset.DisableControls;
  try
    fbFlag := DoFieldChangewhenDisabled;
    DoFieldChangewhenDisabled := True;
    try
      fiId :=id;
      Dataset.filtered := False;
      try
        try
          AddRElatedProducts;
        finally
          fAutoLoadRelatedProducts := True;
        end;
      finally
        Dataset.locate(Idfieldname , fiId, []);
        Dataset.filtered := True;
        SendEvent(BusobjEvent_ToDo, BusobjEvent_AddRelatedPartsDone, Self);
      end;
    finally
      DoFieldChangewhenDisabled := fbflag;
    end;
  finally
    Dataset.EnableControls;
  end;
end;

function TSaleslineBase.AddRElatedProducts:Boolean;
var
  bm: TBookMArk;
  RelatedProduct: TRelatedProduct;
  fsRelatedParentRef: string;
  fParentProductId: Integer;
  SaveDofieldChange: Boolean;
  SubrelatedProduct: Boolean;
  function LastSortID: Integer;
  begin
    with GetNewDataset('Select max(SortID) as SortID from tblsaleslines where saleId = ' + inttostr(SaleId), True) do
      try Result := FieldByname('SortId').asInteger;
      finally
        if Active then close;
        Free;
      end;
  end;
  function LastLinesOrder: Integer;
  begin
    with GetNewDataset('Select max(LinesOrder) as LinesOrder from tblsaleslines where saleId = ' + inttostr(SaleId), True) do
      try Result := FieldByname('LinesOrder').asInteger;
      finally
        if Active then close;
        Free;
      end;
  end;

begin
  REsult := False;
          if Product.HasRelatedProducts then begin
            SubrelatedProduct := IsRelatedProduct;
            RelatedProduct := TRelatedProduct.Create(nil);
            Self.PostDB;
            bm := Self.Dataset.Getbookmark;
            try
              fParentProductId := Self.ProductID;
              fsRelatedParentRef := Self.Globalref;
              if Appenv.companyprefs.SortRelatedProductsinSale then
                RelatedProduct.SQLOrder := 'if(IScontainer="T" , "" , Partname)';
              RelatedProduct.LoadSelect('ParentID = ' + inttostr(Product.ID));
              fbAddingRelatedProducts := True;
              SaveDofieldChange := DofieldChange;
              DofieldChange := True; // as the new records are getting added set this to false to trigger the DoFieldOnChange
              Progressbarmsg := 'Loading Related Parts';
              if SubrelatedProduct  then exit;

              REsult := True;
              fiSortId := LastSortID;
              fiLinesOrder := LastLinesOrder;
              SendEvent(BusobjEvent_ToDo, BusobjEvent_AddRelatedParts, RelatedProduct);
              try
                    while not RelatedProduct.EOF do begin
                      { add the record only if the record already doesn't exists }

                      if not Locate('ProductID;RelatedParentLineRef;RelatedParentProductID;IsRelatedProduct;IsFormulaRElatedProduct' ,
                                    varArrayof([RelatedProduct.ProductID , fsRelatedParentRef,fParentProductId, 'T','F']) , []) then begin
                        Self.Dataset.Append;
                        Self.SortId := fiSortId + 10;
                        Self.LinesOrder := fiLinesOrder + 10;
                        Self.IsRelatedProduct := True;
                        Self.IsFormulaRElatedProduct := False;
                        Self.ProductID := RelatedProduct.ProductID;
                        Self.IsRelatedProduct := True;
                        Self.ParentProductID := fParentProductId;
                        Self.RelatedProductQty := RelatedProduct.Quantity / RelatedProduct.ParentQty;
                        Self.RelatedParentLineRef := fsRelatedParentRef;
                        Self.ISContainer      := RelatedProduct.ISContainer;
                        Self.IsPallet         := RelatedProduct.IsPallet;
                        Self.initRelatedProductFormulaDescription;
                        Self.PostDB;
                        fiSortId := SortId;
                        fiLinesOrder := LinesOrder;
                        SendEvent(BusobjEvent_ToDo, BusobjEvent_AddingRelatedParts, Self);
                      end else begin
                        if fiSortId     < SortId      then fiSortId := SortId;
                        if fiLinesOrder < LinesOrder  then fiLinesOrder := LinesOrder;
                      end;

                      RelatedProduct.Next;
                    end;
              finally
                if not SubrelatedProduct then SendEvent(BusobjEvent_ToDo, BusobjEvent_AddedRelatedParts, Self);
                DofieldChange := SaveDofieldChange;
              end;
              fbAddingRelatedProducts := False;
              AutoLoadRelatedProducts := TRue;
            finally
              Self.Dataset.gotobookmark(bm);
              Self.Dataset.FreeBookmark(bm);
              FreeAndNil(RelatedProduct);
            end;
        end;
end;
procedure TSalesLineBase.GetProductDetails;
begin
  LogD('TSalesLineBase.GetProductDetails', lbBegin);
  try
    SendEvent(BusObjEvent_Change, BusObjEventVal_OnProductChange, Self);
    inherited;
    // set defaults
    Self.UOMQtyShipped := 0;
    Self.UOMQtySold := 0;
    Self.UOMQtyBackOrder := 0;
    Self.QtyShipped := 0;
    Self.QtySold := 0;
    Self.QtyBackOrder := 0;
    Self.DiscountAmount := 0;
    Self.DiscountPercent := 0;
    Self.MarkupAmount := 0;
    Self.MarkupPercent := 0;
    Self.MarginAmount := 0;
    Self.MarginPercent := 0;
    Self.OriginalLinePrice := 0;

    { Clear any custom data for this line }
    Self.CustomData := '';

    if Self.ProductID <> Product.ProductID then Self.ProductID := Product.ProductID;
    Self.ProductGroup := Product.ProductGroup;
    Self.ProductDescription := Product.SalesDescription;
    Self.Product_Description_Memo := Product.SalesDescriptionMemo;
    self.ProductPrintName     := Product.ProductPrintName;
    Self.ProductType := Product.ProductType;
    Self.IncomeAccount := Product.IncomeAccount;
    Self.AssetAccount := Product.AssetAccount;
    Self.CogsAccount := Product.CogsAccount;
    Self.AutoSmartOrder := Product.AutoSmartOrder;
    self.PartBarcode := Product.BARCODE;
    Self.SmartOrderCreated := False; // new record should havea  defualt value of False
    // Also if the product is changed
    Self.Attrib1Sale := Product.Attrib1Sale * Self.QtyShipped;
    Self.Attrib2Sale := Product.Attrib2Sale * Self.QtyShipped;
    Self.Attrib1SaleRate := Product.Attrib1SaleRate;
    Self.Attrib1SaleEst := Product.Attrib1Sale * Self.QtySold;
    Self.Attrib2SaleEst := Product.Attrib2Sale * Self.QtySold;
    Self.RequiresAssembly := Product.RequiresAssembly;
    Self.ProductBarcode := Product.BARCODE;
    Self.SalesTaxBasedon := Product.SalesTaxBasedon;
    { Has product been discontinued }

    // using UOM ID now
    (*Self.UnitOfMeasureID := Product.UOMSalesID;
    Self.UnitOfMeasure := Product.UOMSales;
    Self.UOMMultiplier := tcDataUtils.getUnitMultiplier(Self.UnitOfMeasureID);*)
    InitUOM(Product.UOMSales , '');

    Self.GetBaseLineCost;

    { Tax for this product. }
    if Assigned(Owner) and (Owner is TSalesBase) then
        if (TSalesBase(Self.Owner).Saleclass.TaxID > 0) and (ProductUsesClassTax) then begin
          Self.LineTaxCode := TSalesBase(Self.Owner).SaleClass.TaxCode.CodeName;
          Self.LineTaxRate := TSalesBase(Self.Owner).SaleClass.TaxCode.Rate;
        end else if (TSalesBase(Self.Owner).Customer.TaxID > 0) and (ProductUsescustomerTax) then begin
          { Use customer tax rate }
          Self.LineTaxCode := TSalesBase(Self.Owner).Customer.TaxCode.CodeName;
          Self.LineTaxRate := TSalesBase(Self.Owner).Customer.TaxCode.Rate;
        end else begin
          if Product.TaxCodeSales <> '' then begin
            { Use product tax rate. }
            Self.LineTaxRate := Product.TaxSales.Rate;
            Self.LineTaxCode := Product.TaxSales.CodeName;
          end else begin
            Self.LineTaxCode := '';
            Self.LineTaxRate := 0;
          end;
        end;

    Self.LineCostInc := Round(GetAmountInc(LineCost, LineTaxRate), RoundPlacesGeneral);
    { Add any related products to sale - importing from XML file will have all lines within it, so don;t handle it }

    initProductformula;

    if Assigned(Owner) and (Owner is TSalesBase) then
        if (ImportingFromXMLFile = False) and (IsCreatingBORec = False)
          and (not (TSalesBase(Self.Owner).ConvertingRepairs))
          and (not (TSalesBase(Self.Owner).ConvertingHire))
          and (not (TSalesBase(Self.Owner).convertingSO)) and
          (not (TSalesBase(Self.Owner).convertingQuote)) then
          if AutoLoadRelatedProducts then begin
            if not fbAddingRelatedProducts then begin
              DoDelayObjectProcedure(DoAddRElatedProducts,50, Self.classname +'.DoAddRElatedProducts');
              AutoLoadRelatedProducts := False;
            end;
            // AddRelatedProducts;
          end;
      if AreaCode = '' then
        if Appenv.CompanyPrefs.SalesDefaultValueForAreaFrom ='P' then
          if product <> nil then
            Areacode:= Product.Area;
      (*if productId <> 0 then
        If Assigned(Container) Then
          DoContainerEvent(Self, EvSalesLineProductChange);*)

  finally LogD('', lbEnd);
  end;
end;
Procedure TSalesLineBase.InitProductFormula;
var
  errMsg:String;
begin
if (Product.HasFormulaAttached) or (Product.formulaId <> 0) then begin
      FormulaId :=Product.formulaId ;

      FormulaQtySoldValue1 := Product.FormulaQtyValue1;
      FormulaQtySoldValue2 := Product.FormulaQtyValue2;
      FormulaQtySoldValue3 := Product.FormulaQtyValue3;
      FormulaQtySoldValue4 := Product.FormulaQtyValue4;
      FormulaQtySoldValue5 := Product.FormulaQtyValue5;
      FormulaQtySoldValue := round(ParserValue(Self , DoGetFormulaFieldValueForSold , getFormula(FormulaID), errMsg),5);

      FormulaQtyShippedValue1 := Product.FormulaQtyValue1;
      FormulaQtyShippedValue2 := Product.FormulaQtyValue2;
      FormulaQtyShippedValue3 := Product.FormulaQtyValue3;
      FormulaQtyShippedValue4 := Product.FormulaQtyValue4;
      FormulaQtyShippedValue5 := Product.FormulaQtyValue5;
      FormulaQtyShippedValue := round(ParserValue(Self , DoGetFormulaFieldValueForshipped , getFormula(FormulaID), errMsg),5);
  end;
end;

function TSalesLineBase.getHasRelatedProducts: boolean;
var
  Qry :TERPQuery;
begin
  Qry := DbSharedObj.GetQuery(connection.Connection);
  try
    Qry.sql.text := 'Select count(*) ctr from tblsaleslines where ifnull(RelatedParentLineRef ,"") = '+quotedstr(globalref);
    Qry.open;
    Result := Qry.fieldbyname('ctr').asInteger > 0;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;

end;

function TSalesLineBase.getFESalesLines: TFESalesLines;
begin
  if not Assigned(fFESalesLines) then begin
    fFESalesLines := TFESalesLines.Create(Self);
    fFESalesLines.connection := Self.connection;
    fFESalesLines.SilentMode := Self.SilentMode;
  end;
  if (fFESalesLines.SQLSelect <> 'SaleLineID = ' + inttostr(Self.ID)) or (fFESalesLines.Dataset.Active = False) then begin
    fFESalesLines.LoadSelect('SaleLineID = ' + inttostr(Self.ID));
  end;
  Result := fFESalesLines;
end;

function TSalesLineBase.GetClientDiscountObj: TClientDiscountObj;
begin
  if not Assigned(fClientDiscountObj) then begin
    fClientDiscountObj := TClientDiscountObj.Create;
  end;
  Result := fClientDiscountObj;
end;

function TSalesLineBase.GetForeignHedgingUsed: Boolean;
begin
  Result := GetBooleanField('UseHedging');
end;

procedure TSalesLineBase.SetForeignHedgingUsed(const Value: Boolean);
begin
  SetBooleanField('UseHedging', Value);
end;

function TSalesLineBase.GetProfit: Double;
begin
  if QtySold <> 0 then Result := CommonLib.Round((LinePrice - LineCost) * QtySold, CurrencyRoundPlaces)
  else Result := 0;
end;

function TSalesLineBase.GetProfitInc: Double;
begin
  if QtySold <> 0 then Result := Round((LinePriceInc - LineCostInc) * QtySold, CurrencyRoundPlaces)
  else Result := 0;
end;

function TSalesLineBase.GetProfitOnLanded: Double;
begin
  if QtySold <> 0 then
    Result := CommonLib.Round((LinePrice - Product.LandedCost) * QtySold, CurrencyRoundPlaces)
  else
    Result := 0;
end;

function TSalesLineBase.GetProfitOnLandedInc: Double;
begin
  result := Round(ProfitOnLanded * (1.0 + LineTaxRate), RoundPlacesGeneral)
end;

function TSalesLineBase.GetProfitOnLandedPercent: Double;
begin
  if (QtySold <> 0) then begin
    if ProfitOnLanded = 0 then
      result := -100
    else
      result := Round(DivZer(LinePrice - Product.LandedCost, Product.LandedCost) * 100, CurrencyRoundPlaces)
    end
  else
    result := 0;
end;

function TSalesLineBase.GetProfitOnLandedPercentInc: Double;
var
  LandedInc: double;
begin
  if (QtySold <> 0) then begin
    if ProfitOnLanded = 0 then
      result := -100
    else begin
      LandedInc := Product.LandedCost * (1.0 + LineTaxRate);
      result := Round(DivZer(LinePriceInc - LandedInc, LandedInc) * 100, CurrencyRoundPlaces);
    end;
    end
  else
    result := 0;
end;

function TSalesLineBase.GetProfitPercent: Double;
begin
  if (QtySold <> 0) and ((LinePriceInc <> 0) or (LineCostInc <> 0)) then begin
    if LinePriceInc = 0 then Result := -100
    else if LineCostInc = 0 then Result := 100
    else Result := Round(DivZer((LinePrice - LineCost), LineCost) * 100, CurrencyRoundPlaces)
  end
  else Result := 0;
end;

function TSalesLineBase.GetProfitPercentInc: Double;
begin
  if (QtySold <> 0) and ((LinePriceInc <> 0) or (LineCostInc <> 0)) then begin
    if LinePriceInc = 0 then Result := -100
    else if LineCostInc = 0 then Result := 100
    else Result := Round(DivZer((LinePriceInc - LineCostInc), LineCostInc) * 100, CurrencyRoundPlaces)
  end
  else Result := 0;
end;

function TSalesLineBase.GetGrossProfitPercInc: Double;
begin
  if (QtySold <> 0) and ((LinePriceInc <> 0) or (LineCostInc <> 0)) then begin
    if LinePriceInc = 0 then Result := -100
    else if LineCostInc = 0 then Result := 100
    else Result := Round(DivZer(LinePriceInc - LineCostInc, LinePriceInc) * 100, CurrencyRoundPlaces);
  end
  else Result := 0;
end;

function TSalesLineBase.GetClassID: Integer;
begin
  if Assigned(Owner) and (Owner is TSalesBase) then Result := TSalesBase(Owner).SaleClassId
  else Result := 0;
end;

function TSalesLineBase.GetCleanClassID: Integer;
begin
  if Assigned(Owner) and (Owner is TBusObj) then Result := GetXMLNodeIntegerValue(TBusObj(Owner).CleanXMLNOde, 'SaleClassID')
  else Result := 0;
end;

function TSalesLineBase.GetAttrib1Sale: Double;begin  Result := GetFloatField('Attrib1Sale');end;
function TSalesLineBase.GetAttrib1SaleRate: Double;begin  Result := GetFloatField('Attrib1SaleRate');end;
function TSalesLineBase.GetAttrib2Sale: Double;begin  Result := GetFloatField('Attrib2Sale');end;
function TSalesLineBase.GetAttrib1SaleEst: Double;begin  Result := GetFloatField('Attrib1SaleEst');end;
function TSalesLineBase.GetAttrib2SaleEst: Double;begin  Result := GetFloatField('Attrib2SaleEst');end;
function TSalesLineBase.GetDetailsCust1Total: double;begin  result := GetFloatField('DetailsCust1Total');end;
function TSalesLineBase.GetPurchaseCost: double;begin  result := GetFloatField('PurchaseCost');end;
function TSalesLineBase.GetDiscountAmount: Double;begin  Result := GetFloatField('Discounts');end;
function TSalesLineBase.GetDiscountPercent: Double;begin  Result := GetFloatField('DiscountPercent');end;
function TSalesLineBase.GetMarkupAmount: Double;begin  Result := GetFloatField('Markup');end;
function TSalesLineBase.GetMarkupPercent: Double;begin  Result := GetFloatField('MarkupPercent');end;
function TSalesLineBase.GetMarginAmount: Double;begin  Result := GetFloatField('Margin');end;
function TSalesLineBase.GetMarginPercent: Double;begin  Result := GetFloatField('MarginPercent');end;
function TSalesLineBase.GetSaleId: Integer;begin  Result := GetIntegerField('SaleId');end;
procedure TSalesLineBase.SetAttrib1Sale(const Value: Double);begin  SetFloatField('Attrib1Sale', Value);end;
procedure TSalesLineBase.SetAttrib1SaleRate(const Value: Double);begin  SetFloatField('Attrib1SaleRate', Value);end;
procedure TSalesLineBase.SetAttrib2Sale(const Value: Double);begin  SetFloatField('Attrib2Sale', Value);end;
procedure TSalesLineBase.SetAttrib1SaleEst(const Value: Double);begin  SetFloatField('Attrib1SaleEst', Value);end;
procedure TSalesLineBase.SetAttrib2SaleEst(const Value: Double);begin  SetFloatField('Attrib2SaleEst', Value);end;
procedure TSalesLineBase.SetDetailsCust1Total(const Value: double);begin  SetFloatField('DetailsCust1Total', Value);end;
procedure TSalesLineBase.SetPurchaseCost(const Value: double);begin  SetFloatField('PurchaseCost', Value);end;
procedure TSalesLineBase.SetDiscountAmount(const Value: Double);begin  SetFloatField('Discounts', Value);end;
procedure TSalesLineBase.SetDiscountPercent(const Value: Double);begin  SetFloatField('DiscountPercent', Value);end;
procedure TSalesLineBase.SetMarkupAmount(const Value: Double);begin  SetFloatField('Markup', Value);end;
procedure TSalesLineBase.SetMarkupPercent(const Value: Double);begin  SetFloatField('MarkupPercent', Value);end;
procedure TSalesLineBase.SetMarginAmount(const Value: Double);begin  SetFloatField('Margin', Value);end;
procedure TSalesLineBase.SetMarginPercent(const Value: Double);begin  SetFloatField('MarginPercent', Value);end;
procedure TSalesLineBase.SetSaleId(const Value: Integer);begin  SetIntegerField('SaleId', Value);end;
function TSalesLineBase.GetSoldSerials: string;begin  Result := GetStringField('SoldSerials');end;
procedure TSalesLineBase.SetSoldSerials(const Value: string);begin  SetStringField('SoldSerials', Value);end;
function TSalesLineBase.GetSupplierName: string;begin  Result := GetStringField('Supplier');end;
procedure TSalesLineBase.SetSupplierName(const Value: string);begin  SetStringField('Supplier', Value);end;
function TSalesLineBase.GetPartSpecID: Integer;begin  Result := GetIntegerField('PartSpecId');;end;
function TSalesLineBase.GetProductBarcode: string;begin  result := GetStringField('ProductBarcode');end;
function TSalesLineBase.GetSalesTaxBasedon: string;begin  result := GetStringField('SalesTaxBasedon');end;
function TSalesLineBase.getSalesTaxBasedonProductPrice: Boolean;begin  result := Sametext(SalesTaxBasedon , 'PP');end;
function TSalesLineBase.getSalesTaxBasedonSalesPrice: Boolean;begin  result := Sametext(SalesTaxBasedon , 'SP');end;
function TSalesLineBase.GetRelatedProductPatternName: string;begin  result := GetStringField('RelatedProductPatternName');end;
function TSalesLineBase.GetRelatedProductFormulaDescription: string;begin  result := GetStringField('RelatedProductFormulaDescription');end;
function TSalesLineBase.GetSpecValue: string;begin  Result := GetStringField('SpecValue');end;
function TSalesLineBase.GetAreaQty: Double;begin  Result := GetFloatField('AreaQty');end;
function TSalesLineBase.GetHireLineId: Integer;begin  Result := GetIntegerField('HireLineId');end;
function TSalesLineBase.GetHirePartsSaleID: Integer;begin  Result := GetIntegerField('HirePartsSaleID');end;
function TSalesLineBase.GetRelatedProductProdLine: Integer;begin  Result := GetIntegerField('RelatedProductProdLine');end;
procedure TSalesLineBase.SetPartSpecID(const Value: Integer);begin  SetIntegerField('PartSpecId', Value);end;
procedure TSalesLineBase.SetSpecValue(const Value: string);begin  SetStringField('SpecValue', Value);end;
procedure TSalesLineBase.SetAreaQty(const Value: Double);begin  SetFloatField('AreaQty', Value);end;
function TSalesLineBase.getisFormulaRelProduct: Boolean;begin  Result := GetBooleanField('IsFormulaRElatedProduct');end;
function TSalesLineBase.GetIsQuote: Boolean;begin  Result := GetBooleanField('IsQuote');end;
function TSalesLineBase.getSmartOrderCreated: Boolean;begin  Result := GetBooleanField('SmartOrderCreated');end;
function TSalesLineBase.GetAutoSmartOrder: Boolean;begin  Result := GetBooleanField('AutoSmartOrder');end;
function TSalesLineBase.GetIsRelatedProduct: Boolean;begin  Result := GetBooleanField('IsRelatedProduct');end;
function TSalesLineBase.getRelatedProductQty: Double;begin  Result := GetFloatField('RelatedProductQty');end;
function TSalesLineBase.GetParentProductID: Integer;begin  Result := GetIntegerField('RelatedParentProductID');end;
function TSalesLineBase.GetRefundedSalesLineID: Integer;begin  Result := GetIntegerField('RefundedSalesLineID');end;
function TSalesLineBase.GetRelatedParentLineRef: string;begin  Result := GetStringField('RelatedParentLineRef');end;
function TSalesLineBase.GetISContainer       : Boolean ;begin  Result:= GetBooleanField('ISContainer');end;
function TSalesLineBase.GetIsPallet          : Boolean ;begin  Result:= GetBooleanField('IsPallet');end;
function TSalesLineBase.GetForeignLinePrice: Double;begin  Result := GetFloatField('ForeignCurrencyLinePrice');end;
function TSalesLineBase.GetSpecDescription: string;begin  Result := GetStringField('SpecDescription');end;
function TSalesLineBase.getRefundQty: Double;begin  Result := GetFloatField('RefundQty');end;
function TSalesLineBase.GetcleanProductId: Integer;begin  Result := GetXMLNodeIntegerValue(CleanXMLNOde, 'ProductID');end;
function TSalesLineBase.GetCleanQty: Double;begin  Result := GetXMLNodeFloatValue(CleanXMLNOde, 'QtyShipped');end;
function TSalesLineBase.GetcleanQtyTotal: Double;begin  Result := GetXMLNodeFloatValue(CleanXMLNOde, 'QtySold');end;
function TSalesLineBase.GetCleanQtyShipped: Double;begin  Result := Self.CleanQty;end;
function TSalesLineBase.GetCustomData: string;begin  Result := GetStringField('CustomData');end;
function TSalesLineBase.GetSerialnos: string;begin  Result := SoldSerials;end;
function TSalesLineBase.GetTimeCostUsed: Boolean;begin  Result := GetBooleanField('TimeCostUsed');end;
function TSalesLineBase.GetRequiresAssembly: Boolean;begin  Result := GetBooleanField('RequiresAssembly');end;
function TSalesLineBase.GetAssembled: Boolean;begin  Result := GetBooleanField('Assembled');end;
function TSalesLineBase.GetDocketNumber: string;begin  Result := GetStringField('DocketNumber');end;
function TSalesLineBase.GetExcludeFromSmartOrder: boolean;begin  Result := GetBooleanField('ExcludeFromSmartOrder');end;
function TSalesLineBase.GetOriginalLinePrice: Double;begin  Result := GetFloatField('OrgLinePrice');end;
function TSalesLineBase.GetOriginalLinePriceInc: double;begin  result := Round(OriginalLinePrice * (1.0 + LineTaxRate), RoundPlacesGeneral);end;
function TSalesLineBase.getLaybyID: string;begin  Result := GetStringField('LaybyID');end;
function TSalesLineBase.GetLineDesc: String;begin  REsult := inherited GetLineDesc;  Result := result + NL+'Product :' + Productname;end;
function TSalesLineBase.getCreationDate: TDatetime;begin  Result := getDatetimeField('CreationDate');end;
procedure TSalesLineBase.SetTimeCostUsed(const Value: Boolean);begin  SetBooleanField('TimeCostUsed', Value);end;
procedure TSalesLineBase.SetRequiresAssembly(const Value: Boolean);begin  SetBooleanField('RequiresAssembly', Value);end;
procedure TSalesLineBase.SetAssembled(const Value: Boolean);begin  SetBooleanField('Assembled', Value);end;
procedure TSalesLineBase.SetCustomData(const Value: string);begin  SetStringField('CustomData', Value);end;
procedure TSalesLineBase.SetSpecDescription(const Value: string);begin  SetStringField('SpecDescription', Value);end;
procedure TSalesLineBase.SetLayByID(const Value: string);begin  SetStringField('LaybyId', Value);end;
procedure TSalesLineBase.SetCreationDate(const Value: TDatetime);begin  SetDatetimeField('CreationDate', Value);end;
procedure TSalesLineBase.SetDocketNumber(const Value: string);begin  SetStringField('DocketNumber', Value);end;
procedure TSalesLineBase.SetExcludeFromSmartOrder(const Value: boolean);begin  SetBooleanField('ExcludeFromSmartOrder', Value);end;
procedure TSalesLineBase.SetSerialNos(const Value: string);begin  SoldSerials := Value;end;
procedure TSalesLineBase.SetISFormulaRElProduct(const Value: Boolean);begin  SetBooleanField('IsFormulaRElatedProduct', Value);end;
procedure TSalesLineBase.SetIsQuote(const Value: Boolean);begin  SetBooleanField('IsQuote', Value);end;
procedure TSalesLineBase.SetSmartOrderCreated(const Value: Boolean);begin  SetBooleanField('SmartOrderCreated', Value);end;
procedure TSalesLineBase.SetAutoSmartOrder(const Value: Boolean);begin  SetBooleanField('AutoSmartOrder', Value);end;
procedure TSalesLineBase.SetBatchAllocated(const Value: boolean);begin  SetBooleanField('BatchAllocated', Value);end;
procedure TSalesLineBase.SetIsRelatedProduct(const Value: Boolean);begin  SetBooleanField('IsRelatedProduct', Value);end;
procedure TSalesLineBase.SetRelatedProductQty(const Value: Double);begin  SetFloatField('RelatedProductQty', Value);end;
procedure TSalesLineBase.SetParentProductID(const Value: Integer);begin  SetIntegerField('RelatedParentProductID', Value);end;
procedure TSalesLineBase.SetRefundedSalesLineID(const Value: Integer);begin  SetIntegerField('RefundedSalesLineID', Value);end;
procedure TSalesLineBase.SetRelatedParentLineRef(const Value: string);begin  SetStringField('RelatedParentLineRef', Value);end;
procedure TSalesLineBase.SetISContainer      (const Value: Boolean);begin  SetBooleanField('ISContainer', Value);end;
procedure TSalesLineBase.SetIsPallet         (const Value: Boolean);begin  SetBooleanField('IsPallet', Value);end;
procedure TSalesLineBase.SetOriginalLinePrice(const Value: Double);begin  SetFloatField('OrgLinePrice', Value);  end;
procedure TSalesLineBase.SetRefundQty(const Value: Double);begin  SetFloatField('RefundQty', Value);end;
procedure TSalesLineBase.SetFESalesLines(const Value: TFESalesLines);begin  fFESalesLines := Value; end;
procedure TSalesLineBase.SetHireLineId(const Value: Integer);begin SetIntegerField('HireLineId', Value);end;
procedure TSalesLineBase.SetHirePartsSaleID(const Value: Integer); begin SetIntegerField('HirePartsSaleID', Value);end;
procedure TSalesLineBase.SetRelatedProductProdLine(const Value: Integer); begin SetIntegerField('RelatedProductProdLine', Value);end;
function TSalesLineBase.getlineTaxclean           : Double;begin  Result := 0;  if Dataset.findfield('lineTaxclean')            <> nil then Result := GetFloatField('lineTaxclean');end;
function TSalesLineBase.getlinepriceincclean      : Double;begin  Result := 0;  if Dataset.findfield('linepriceincclean')       <> nil then Result := GetFloatField('linepriceincclean');end;
function TSalesLineBase.getTotallineamountclean   : Double;begin  Result := 0;  if Dataset.findfield('Totallineamountclean')    <> nil then Result := GetFloatField('Totallineamountclean');end;
function TSalesLineBase.getTotallineAmountincclean: Double;begin  Result := 0;  if Dataset.findfield('TotallineAmountincclean') <> nil then Result := GetFloatField('TotallineAmountincclean');end;
procedure TSalesLineBase.SetlineTaxclean            (const Value: Double);begin  if Dataset.findfield('lineTaxclean')           <> nil then SetFloatField('lineTaxclean', Value);end;
procedure TSalesLineBase.Setlinepriceincclean       (const Value: Double);begin  if Dataset.findfield('linepriceincclean')      <> nil then SetFloatField('linepriceincclean', Value);end;
procedure TSalesLineBase.SetTotallineamountclean    (const Value: Double);begin  if Dataset.findfield('Totallineamountclean')   <> nil then SetFloatField('Totallineamountclean', Value);end;
procedure TSalesLineBase.SetTotallineAmountincclean (const Value: Double);begin  if Dataset.findfield('TotallineAmountincclean')<> nil then SetFloatField('TotallineAmountincclean', Value);end;
function TSalesLineBase.getDuedate: TdateTime;
begin
  Result := 0;
  if assigned(Owner) then
    if owner is TSalesbase then
      REsult := TSalesbase(OwneR).Duedate;
end;
procedure TSalesLineBase.setDuedate(const Value: TdateTime);
begin
  if assigned(Owner) then
    if owner is TSalesbase then
      TSalesbase(OwneR).Duedate := Value;

end;
function TSalesLineBase.getHeadershipdate: TdateTime;
begin
  Result := 0;
  if assigned(Owner) then
    if owner is TSalesbase then
      REsult := TSalesbase(OwneR).Shipdate;
end;
procedure TSalesLineBase.setHeadershipdate(const Value: TdateTime);
begin
  if assigned(Owner) then
    if owner is TSalesbase then
      TSalesbase(OwneR).Shipdate := Value;

end;
function TSalesLineBase.getAutoResetingPrices: Boolean;
begin
  result := false;
  if assigned(Owner) and (Owner is TSalesbase) then result := TSalesBase(Owner).AutoResetingPrices;
end;
procedure TSalesLineBase.SetAutoResetingPrices(const Value: Boolean);
begin
  if assigned(Owner) and (Owner is TSalesbase) then TSalesBase(Owner).AutoResetingPrices := Value;
end;

function TSalesLineBase.GetAvailableUOMQtyUOMQty: double;
begin
  result := 0;
  if not AppEnv.CompanyPrefs.ShowSaleLineInStockQty then exit;

  if not Vars.Values.ByName['InStockQtyLoaded'].AsBoolean then
    LoadInStockQty;
  result := Vars.Values.ByName['AvailableUOMQty'].AsFloat;
end;

function TSalesLineBase.getAvaTaxID: String;
var
  XRefDone: boolean;
  ExID:String;
begin
  result := '';
  if TExternalXRef.GetExternalRef(Servicename_AvaTax, ExRef_Objtype_SalesLines, ID, ExId, XRefDone) then begin
    Result := ExId;
  end;
end;

function TSalesLineBase.SelectedProductIds: String;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.Connection.Connection);
  try
    Qry.SQL.text := 'Select ProductID from tblsaleslines ' +
                    ' where ifnull(RelatedParentLineRef,"") <> "" and ifnull(RelatedParentLineRef,"") = ' + quotedstr(Globalref)+
                    ' and   ifnull(RelatedParentProductID,0) <>0 and ifnull(RelatedParentProductID,0) = ' + inttostr(Self.ProductID)+
                    ' and IsRelatedProduct="T" and IsFormulaRElatedProduct ="F"';
    Qry.open;
    result := Qry.GroupConcat('ProductId');

  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

end;

function TSalesLineBase.GetParentProductName: string;
begin
  if ParentProductID > 0 then
    result:= TProduct.IDToggle(ParentProductID, Connection.Connection)
  else
    result:= '';
end;

procedure TSalesLineBase.SetParentProductName(const Value: string);
begin
  if Value <> '' then begin
    ParentProductID:= TProduct.IDToggle(Value, Connection.Connection);
    if ParentProductID = 0 then
      ParentProductID:= -1;
  end
  else
    ParentProductID:= 0;
end;

function TSalesLineBase.ValidateSrnos: Boolean;
begin
  Result := True;
  if Product.SnTracking = False then Exit;
  if AppEnv.CompanyPrefs.MatchUOMonSerialNoSelection then begin
    if UOMQtyShipped <> countwords(SerialNumbers) then begin
      Result := False;
      Exit;
    end;
  end else begin
    if QtyShipped <> countwords(SerialNumbers) then begin
      Result := False;
      Exit;
    end;
  end;
end;

class function TSalesLineBase._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TSupplier','SupplierObj','SupplierName','ClientName');
  TBOSchema.AddRefType(result,'TProductSpecs','ProductSpecObj','PartSpecID','ID');
  TBOSchema.AddRefType(result,'TProductWeb','ParentProductObj','ParentProductName','ProductName');
  TBOSchema.AddRefType(result,'TPOSLayby','LaybyObj','LaybyID','GlobalRef');
//  TBOSchema.AddPropSeqList(result,'ProductName,UnitOfMeasure,UOMMultiplier,UOMNameProductKey,UOMQtySold,UOMQtyShipped');
end;

function TSalesLineBase.ValidateData: Boolean;
var
  Msg: string;
  aDiscountPercent, aDiscountAmount, aLinePrice, aDiscPrice: double;
begin
  Result := inherited ValidateData;
  if not Result then Exit;
  if Self.ProductName = '' then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'Product name missing');
    Exit;
  end;
  if (ProductId < 1) and (ProductName <> '') then begin
    AddResult(false,rssWarning,0,'Product not found: "' + ProductName + '"');
    Result:= false;
    exit;
  end;
  if Self.ProductId < 1 then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'Product ID is either blank or Product is not found');
    Exit;
  end;
  if ParentProductID = -1 then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'Parent Product Name is invalid (product not found)');
    Exit;
  end;
  aDiscPrice :=0;
  aDiscountAmount := DiscountAmount;
  aDiscountPercent := DiscountPercent;
  aLinePrice:=OriginalLinePrice*Qtyshipped;
  if (not TSalesDiscountValidationObj.ValidateDiscount(Self, aDiscountAmount , aDiscountPercent , Linecost , aLinePrice , aDiscPrice ,QtyShipped , ProductId , True, False, Msg)) then begin
    result := false;
    AddResult(false, rssWarning, 0, Msg);
    exit;
  end;
end;

destructor TSalesLineBase.Destroy;
begin
  if Assigned(fClientDiscountObj) then FreeAndNil(fClientDiscountObj);
  if Assigned(fFESalesLines) then begin
    if (not fFESalesLines.ExternalDatasetAssigned) then FreeAndNil(fFESalesLines)
    else fFESalesLines.Dataset.close;
  end;
  inherited;
end;

constructor TSalesLineBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fbInstantiatingTree := False;
  AllowTaxinput := False;
  fbupdatingRelPrQty := False;
  fAutoLoadRelatedProducts := true;
  fClientDiscountObj := nil;
  fFESalesLines := nil;
  RefundedSnos := '';
  fbignoreCheckSaveSpecialPrice := False;
  fdQtyrequiredforAlternateProduct := 0;
  fbAddingAlternateProduct := False;
  ExportExcludeList.Add('saleid');
  ExportExcludeList.Add('cleansoldserials');
  ExportExcludeList.Add('convertingso');
  ExportExcludeList.Add('convertingrepairs');
  ExportExcludeList.Add('ConvertingHire');
  ExportExcludeList.Add('convertingquote');
  ExportExcludeList.Add('parentproductid');
  ExportExcludeList.Add('RefundedSalesLineID');
  ExportExcludeList.Add('cleanqtyshipped');
  ExportExcludeList.Add('cleanuomqtyshipped');
  ExportExcludeList.Add('HireLineId');
  ExportExcludeList.Add('HirePartsSaleID');
end;
function TSalesLineBase.AutoRoundRelatedQty(const Qty:double):Double;
begin
  result := tcdatautils.AutoRoundRelatedQty(Qty  , ParentProductID , ProductID);
  (*result:= Qty;
  if not(IsRelatedProduct) then exit;
  with getNewdataset('Select ZeroWhenLessthan1 , IsToRoundtoNextNumberinSales , IsToRoundtoPreviousNumberinSales , ParentQty, qty '+
                    ' from tblrelatedparts where ParentID = ' + inttostr( ParentProductID) +'  and ProductID = ' + inttostr(ProductID) , true) do try

        try
          result := result * (fieldbyname('Qty').AsFloat / fieldbyname('ParentQty').AsFloat);
        Except
          On E:Exception do begin
            result := result * fieldbyname('Qty').AsFloat;
          end;
        end;

    if fieldbyname('ZeroWhenLessthan1').AsBoolean and (result <1 ) then result:= 0
    else if FieldByname('IsToRoundtoNextNumberinSales').AsBoolean then begin
      if trunc(result) < result then result := trunc(result) +1;
    end else if FieldByname('IsToRoundtoPreviousNumberinSales').AsBoolean then begin
      if trunc(result) < result then result := trunc(result) ;
    end;
  finally
    if active then close;
    Free;
  end;*)
end;
procedure TSalesLineBase.UpdateRelPrQtyCallback(const Sender: TBusObj; var Abort: Boolean);
var
  SaveDofieldChange: Boolean;
  SaveRunningEventListEvents: Boolean;
  fdQty :double;
begin
  SendEvent(BusobjEvent_ToDo, BusobjEvent_AddingRelatedParts, Self);
  if (not(IsRelatedProduct)) and (not(IsFormulaRElatedProduct)) then Exit;
  if not(Self is TSalesLineBase) then Exit;

  if TSalesLineBase(Sender).RelatedParentLineRef <> fsRelatedParentLineRef then Exit;
  if TSalesLineBase(Sender).ParentProductID <> fiPArentProductId then Exit;

  SaveDofieldChange := DofieldChange;
  DoFieldChangewhenDisabled := True;
  try
    DofieldChange := True;
    SaveRunningEventListEvents := RunningEventListEvents;
    if Assigned(Self.Owner) and (Self.Owner is TSalesBase) then SaveRunningEventListEvents := TSalesBase(Self.Owner).RunningEventListEvents;
    RunningEventListEvents := False;
    if Assigned(Self.Owner) and (Self.Owner is TSalesBase) then TSalesBase(Self.Owner).RunningEventListEvents := False;
    try

      fdQty := AutoRoundRelatedQty(ParentQtySold (** Self.RelatedProductQty*));
      if FormulaQtySoldValue <> 0 then fdQty := fdQty *FormulaQtySoldValue;
      if Self.QtySold <> fdQty then Self.QtySold := fdQty;

      fdQty := AutoRoundRelatedQty(ParentQtyShipped (** Self.RelatedProductQty*));
      if FormulaQtyShippedValue <> 0 then fdQty := fdQty *FormulaQtyShippedValue;
      if Self.QtySold < fdQty then Self.QtySold := fdQty;
      if Self.QtyShipped <>fdQty then Self.QtyShipped := fdQty;
    finally
      if Assigned(Self.Owner) and (Self.Owner is TSalesBase) then TSalesBase(Self.Owner).RunningEventListEvents := SaveRunningEventListEvents;
      RunningEventListEvents := SaveRunningEventListEvents;
    end;
    if Self is TSalesLine then // back order only applicable for the sales lines
      if Self.UOMQtyBackOrder <> Self.UOMQtySold - Self.UOMQtyShipped then
        Self.UOMQtyBackOrder := Self.UOMQtySold - Self.UOMQtyShipped;
  finally
    DofieldChange := SaveDofieldChange;
    DoFieldChangewhenDisabled := False;
  end;
end;

procedure TSalesLineBase.updaterelatedPartsQty;
var
  SubrelatedProduct: Boolean;
  dParentQtyShipped: Double;
  dParentQtySold: Double;
  dfsRelatedParentLineRef: string;
  dfiParentProductId: Integer;

  procedure StoreValues;
  begin
    dParentQtyShipped := ParentQtyShipped;
    dParentQtySold := ParentQtySold;
    dfsRelatedParentLineRef := fsRelatedParentLineRef;
    dfiParentProductId := fiPArentProductId;
  end;
  procedure reStoreValues;
  begin
    ParentQtyShipped := dParentQtyShipped;
    ParentQtySold := dParentQtySold;
    fsRelatedParentLineRef := dfsRelatedParentLineRef;
    fiPArentProductId := dfiParentProductId;
  end;

begin
  if (ImportingFromXMLFile) or (IsCreatingBORec) then Exit;

  if (Product.HasRelatedProducts) or (Product.HasFormulaAttached) then begin
    SubrelatedProduct := IsRelatedProduct;
    PostDB;
    StoreValues;
    ParentQtyShipped := Self.QtyShipped;
    ParentQtySold := Self.QtySold;
    fsRelatedParentLineRef := Globalref;
    fiParentProductId := Self.ProductID;

    if not SubrelatedProduct then SendEvent(BusobjEvent_ToDo, BusobjEvent_AddRelatedParts, Self);
    try
      fbupdatingRelPrQty:= True;
      try
        IterateREcords(updateRelPrQtyCallback, true);
      finally
        fbupdatingRelPrQty := False;
      end;
    finally
      if not SubrelatedProduct then SendEvent(BusobjEvent_ToDo, BusobjEvent_AddedRelatedParts, Self);
    end;
    reStoreValues;
    RunningEventListEvents := False;
    if Assigned(Self.Owner) and (Self.Owner is TSalesBase) then begin
      TSalesBase(Self.Owner).RunningEventListEvents := False;
      TSales(Owner).DoCalcOrderTotals;
    end;
  end;
end;
Function TSalesBase.ValidateforAvaTax:Boolean;
var
  aJO:TJsonObject;
begin
  Result := False;
  if trim(Customer.ClientNo) ='' then begin
    ResultStatus.AddItem(True, rssWarning, 0, 'Missing Account Number for Customer ]' + quotedstr(Customername)+'].'+NL+
                                              'Avalara Tax Needs an Account Number for each Customer.'+NL+
                                              'Please Provide the Account Number in the Customer Card->Accounts->AccountNumber');
    Exit;
  end;
  aJo := jo;
  try
    AvaTaxRelated(aJO);

    if  (Trim(aJo.O['fields'].O['ShipFrom'].S['Street1'])='') or
        (Trim(aJo.O['fields'].O['ShipFrom'].S['City'])='') or
        (Trim(aJo.O['fields'].O['ShipFrom'].S['State'])='') or
        (Trim(aJo.O['fields'].O['ShipFrom'].S['PostCode'])='') or
        (Trim(aJo.O['fields'].O['ShipFrom'].S['Country'])='') then begin
        ResultStatus.AddItem(True, rssWarning, 0, 'Missing / Incomplete Ship From address.');
        Exit;
    end;
    if not aJO.O['fields'].B['singleLocation'] then begin
    if  (Trim(ShipStreet1)='') or
        (Trim(ShipSuburb)='') or
        (Trim(ShipState)='') or
        (Trim(ShipPostcode)='') or
        (Trim(ShipCountry)='') then begin
        ResultStatus.AddItem(True, rssWarning, 0, 'Missing / Incomplete Ship To address.');
        Exit;
        end;
    end;
  finally
    aJo.free;
  end;
  Result := True;
end;
Function TSalesBase.CalcAvaTax:Boolean;
begin
  CalculatedAvaTax := False;
  try
    SendEvent(BusobjEvent_ToDo, BusobjEvent_CalcAvaTax, Self);
  finally
    result := CalculatedAvaTax;
  end;

end;
(*Function TSalesBase.CalcAvaTax:Boolean;
var
  fsBody :String;
  aAvaTaxERPObj :TAvaTaxERPObj;
  function TaxCodeNoTax :String;
  begin
    if trim(Appenv.companyprefs.AvaTaxConfig.NotaxTaxcode) <> '' then
         Result := Appenv.companyprefs.AvaTaxConfig.NotaxTaxcode
    else Result := appenv.regionaloptions.TaxCodeNoTax;
  end;
begin
    REsult := False;
    if not Appenv.companyPrefs.EnableAvaTax then exit;
    if not Appenv.companyPrefs.AvaTaxCredentialsValidated then  Exit;
    if CalculatingAvaTax then exit;

    if Not (ValidateforAvaTax) then exit;

    CalculatingAvaTax := True;
    try
            if not save then exit;
            Connection.CommitTransaction;
            try
                  Processingcursor(True);
                  try
                      if sametext(Customer.TaxCodeName , TaxCodeNoTax) then begin
                        BusobjMessageDlg('Avalara Tax Calculation Ignored as Customer [' + Customername +'] has the NoTax TaxCode [' +TaxCodeNoTax +'] Selected.', mtinformation, [mbok] , 0);
                        Lines.iteraterecords(CalcAvaTaxNoTaxCallback);
                      end else begin
                        Connection.beginNestedTransaction;
                        try
                          aAvaTaxERPObj := TAvaTaxERPObj.create(Self);
                          try
                            if aAvaTaxERPObj.CalcAvaTax(Self) then begin
                              Connection.CommitNestedTransaction;
                              save;
                              Dirty := False;
                              Result := True;
                              Exit;
                            end;
                            Connection.RollbackNestedTransaction;
                          finally
                            FreeandNil(aAvaTaxERPObj);
                          end;
                        Except
                          on E:Exception do begin
                            logtext(E.message);
                            Connection.RollbackNestedTransaction;
                          end;
                        end;
                      end;
                  finally
                    Processingcursor(False);
                  end;
              finally
                Connection.BeginTransaction;
              end;
    finally
       CalculatingAvaTax := False;
    end;
end;*)
(*Procedure TSalesBase.CalcAvaTaxNoTaxCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is TSalesLineBase then begin
    TSalesLineBase(Sender).Linetaxrate := 0;
    TSalesLineBase(Sender).PostDB;
    TSalesLineBase(Sender).CalcLinetotals;
  end;
end;*)
function TSalesBase.CalcCommission: string;
begin
  Result := '';
  with TSalesCommission(getContainercomponent(TSalesCommission, 'EmployeeId = ' + inttostr(EmployeeId) + ' and ifnull(SaleLineId,0) = 0 and SaleID = ' + inttostr(Self.ID))) do begin
    SalesObj := Self;
    if (Self.Employee.EmployeeHasCommission = False) or (Self.Lines.Count = 0) or (TotalAmount = 0) or (Self.Deleted) or ((Self.Employee.IsCommissiononpaidInvoice) and (Self.IsPaid = False)) then
    begin
      if amountPaid = 0 then begin
        Deleted := True;
        PostDB;
      end else begin
        CommissionAmount := 0;
        PostDB;
      end;
    end else begin

      if Count = 0 then begin
        New;
        SaleId := Self.ID;
        EmployeeId := Self.EmployeeId;
      end
      else if Deleted then Deleted := False;
      SaleDate := Self.SaleDate;
      SalescommissionCalcId := Self.SaleCommissionCalcId;
      Result := CalcEmployeeCommission;
    end;
  end;
  LinesLog := '';
  Lines.IterateREcords(CalcCommissionCallback, True);
  Result := Result + chr(13) + LinesLog;
  with TSalesCommission(getContainercomponent(TSalesCommission, 'EmployeeId = ' + inttostr(EmployeeId) + ' and ifnull(SaleLineId,0) <> 0 and SaleID = ' + inttostr(Self.ID))) do begin
    if Count = 0 then Exit;
    first;
    while EOF = False do begin
      if not Lines.Locate('saleLineId', SaleLineId, []) then begin
        if amountPaid = 0 then delete
        else begin
          CommissionAmount := 0;
          PostDB;
          Next;
        end;
      end
      else Next;
    end;
  end;
end;

procedure TSalesBase.CalcCommissionCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TSalesLineBase) then Exit;


  with TSalesCommission(TSalesLineBase(Sender).getContainercomponent(TSalesCommission, 'EmployeeId = ' + inttostr(EmployeeId) + ' and SaleLineID = ' + inttostr(Sender.ID))) do begin
    SalesObj := Self;
    Product := TSalesLineBase(Sender).Product;
    if ((TSalesLineBase(Sender).Deleted) or (Self.Employee.ProductHascommission = False) or (TSalesLineBase(Sender).Product.ProductCommission.Count = 0)) or
      ((Self.Employee.IsCommissiononpaidInvoice) and (Self.IsPaid = False)) then begin
      if amountPaid = 0 then delete
      else begin
        CommissionAmount := 0;
        PostDB;
      end;
    end else begin
      if TSalesLineBase(Sender).Qty = 0 then begin
        LinesLog := LinesLog + chr(13) + 'Product Name :' + TSalesLineBase(Sender).ProductName + chr(13) + '======================================================' + chr(13) + 'Back Order';
        Exit;
      end;
      if Count = 0 then begin
        New;
        SaleId := Self.ID;
        SaleLineId := TSalesLineBase(Sender).ID;
        EmployeeId := Self.EmployeeId; { employeeId should be set before the productID }
        ProductID := TSalesLineBase(Sender).ProductID;
      end;
      SaleDate := Self.SaleDate;
      SalescommissionCalcId := Self.SaleCommissionCalcId;
      LinesLog := LinesLog + chr(13) + CalcProductCommission;
    end;
  end;
end;

procedure TSalesBase.CalcForeignAmount;
begin
  inherited;
  FForeignTotalAmount := 0;
  Lines.IterateREcords(CalcForeignAmountCallback);
  ForeignTotalAmount := Round(fForeignTotalAmount, CurrencyRoundPlaces);
end;
procedure TSalesBase.CalcForeignAmountCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if TSalesLineBase(Sender).Deleted then Exit;  { deleted records amount should not be added into total }
  inherited;
  try
    TSalesLineBase(Sender).CalcLineForeingAmount;
    fForeignTotalAmount := fForeignTotalAmount + TSalesLineBase(Sender).ForeignTotalLineAmount;
  except
    // kill the exception
  end;
end;

function TSalesBase.GetSaleClass: TDeptClass;
begin
  if not Assigned(fSaleClass) then fSaleClass := TDeptClass.Create(Self);
  if (Self.SaleClassId > 0) and (Self.SaleClassId <> fSaleClass.ID) then begin
    fSaleClass.LoadSelect('ClassId = ' + inttostr(Self.SaleClassId));
  end
  else if (Self.SaleClassName <> '') and (Self.SaleClassName <> fSaleClass.DeptClassName) then begin
    fSaleClass.LoadSelect('ClassName = ' + QuotedStr(Self.SaleClassName));
  end;
  Result := fSaleClass;
end;

function TSalesBase.GetCustomer: TCustomer;
var
  strSQL:String;
begin
  if (self.ClientId > 0) then
        strSQL:= 'ClientId = ' + IntToStr(self.ClientId)
  else (*if (self.ClientName <> '') then*)
        strSQL:= 'Company = ' + QuotedStr(StringDataForSQL(self.ClientName));
  result := TCustomer(getContainerComponent(TCustomer, strSQL , true, true,true,'',true));
  result.BusObjEvent := Self.BusObjEvent;
end;

procedure TSalesBase.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if Assigned(fSaleClass) then FreeAndNil(fSaleClass);
end;

function TSalesBase.GetSaleLines: TSalesLineBase;
begin
  Result := nil;
  // descendants will override it
end;

function TSalesBase.getTotalQuoteAmInc: Double;
begin
  Result := fdTotalQuoteAmtInc;
  if Result = 0 then Result := TotalAmountInc;
end;

function TSalesBase.GetSaleId: Integer;
begin
  Result := GetIntegerField('SaleId');
end;

function TSalesBase.GetDocNumber: string;
begin
  Result := GetStringField('InvoiceDocNumber');
end;

procedure TSalesBase.SetDocNumber(const Value: string);
begin
  SetStringField('InvoiceDocNumber', Value);
end;

function TSalesBase.GetCustomerName: string;
begin
  Result := GetStringField('CustomerName');
end;

procedure TSalesBase.SetCustomerName(Value: string);
begin
  SetStringField('CustomerName', Value);
end;

function TSalesBase.GetInvoiceToDesc: string;
begin
  Result := GetStringField('InvoiceTo');
end;

function TSalesBase.GetPickupFromDesc: string;
begin
  Result := GetStringField('PickUpFrom');
end;
Function TSalesBase.GetPickUpfromID :Integer;
begin
  REsult := getIntegerfield('PickUpfromID');
end;
function TSalesBase.GetPickupFromClientName: string;
begin
  result := TCustomer.IDToggle(PickupfromId);
end;

function TSalesBase.getSaleDate: TDatetime;
begin
  Result := getDatetimeField('SaleDate');
end;

function TSalesBase.GetShipToDesc: string;
begin
  Result := GetStringField('ShipTo');
end;

function TSalesBase.getShipToID: Integer;
begin
  Result := GetIntegerfield('ShipToID');
end;

function TSalesBase.GetShipping: string;
begin
  Result := GetStringField('Shipping');
end;

function TSalesBase.getShippingAddressObj: TShippingAddress;
begin
  Result := TShippingAddress(getcontainercomponent(TShippingAddress , 'ShipAddressID = ' + IntToStr(shipToId) , true , true));
end;

function TSalesBase.GetPickMemo: string;
begin
  Result := GetStringField('PickMemo');
end;

procedure TSalesBase.SetInvoiceToDesc(const Value: string);
begin
  SetStringField('InvoiceTo', Value);
end;

procedure TSalesBase.SetPickupFromDesc(const Value: string);
begin
  SetStringField('PickupFrom', Value);
end;
procedure TSalesBase.SetPickupFromClientName(const Value: string);
begin
  Pickupfromid := TCustomer.IDToggle(Value);
end;
procedure TSalesBase.setPickUpfromID(const Value: Integer);
begin
  SetIntegerField('PickUpfromID' , value);
end;

procedure TSalesBase.SetSaleDate(const Value: TDatetime);
begin
  SetDatetimeField('SaleDate', Value);
end;

procedure TSalesBase.SetShipToDesc(const Value: string);
begin
  SetStringField('ShipTo', Value);
end;

procedure TSalesBase.setShipToID(const Value: Integer);
begin
  SetIntegerField('ShipToID' , Value);
end;

procedure TSalesBase.SetShipping(const Value: string);
begin
  SetStringField('Shipping', Value);
end;

procedure TSalesBase.SetPickMemo(const Value: string);
begin
  SetStringField('PickMemo', Value);
end;


function TSalesBase.GetConNote: string;
begin
  Result := GetStringField('ConNote');
end;

function TSalesBase.getAutoSmartOrderRef: string;
begin
  Result := GetStringField('AutoSmartOrderRef');
end;
function TSalesBase.getOriginal_Quote_SO_Invoice_Ref: String;
begin
  result := '';
  if Globalref ='' then PostDB;
  result := trim(QuoteGlobalref);
  if result ='' then  REsult := SOQuteGlobalref;

  if result = '' then result := trim(SalesOrderGlobalref);
  if result = '' then result := trim(Globalref);
end;
function TSalesBase.getAvaTaxID: String;
var
  XRefDone: boolean;
  ExID:String;
begin
  result := '';
  if TExternalXRef.GetExternalRef(Servicename_AvaTax, ExRef_Objtype_Sales, ID, ExId, XRefDone) then begin
    Result := ExId;
  end;
end;
function TSalesBase.getAvaTaxCode: String;
var
  XRefDone: boolean;
  ExID:String;
begin
  result := '';
  if TExternalXRef.GetExternalRef(Servicename_AvaTax, ExRef_Objtype_Sales, ID, ExId, XRefDone, nil, true) then begin
    Result := ExId;
  end;
end;

function TSalesBase.getPOCreated: Boolean;
begin
  Result := GetBooleanField('POCreated');
end;

function TSalesBase.GetIsCashSale: Boolean;
begin
  Result := GetBooleanField('IsCashSale');
end;

function TSalesBase.GetIsInvoice: Boolean;
begin
  Result := GetBooleanField('IsInvoice');
end;

function TSalesBase.GetIsQuote: Boolean;
begin
  Result := GetBooleanField('IsQuote');
end;

//function TSalesBase.getISManTrans: Boolean;
//begin
//  Result := GetBooleanField('ISManTrans');
//end;

function TSalesBase.getIsPos: Boolean;
begin
  Result := GetBooleanField('IsPOS');
end;

function TSalesBase.GetIsRefund: Boolean;
begin
  Result := GetBooleanField('IsRefund');
end;

function TSalesBase.GetIsSalesOrder: Boolean;
begin
  Result := GetBooleanField('IsSalesOrder');
end;

function TSalesBase.GetIsLaybyPayment: Boolean;
begin
  Result := GetBooleanField('IsLaybyPayment');
end;
function TSalesBase.GetIsCustomerreturn: Boolean;
begin
  Result := GetBooleanField('IsCustomerreturn');
end;

function TSalesBase.GetIsLaybyTOS: Boolean;
begin
  Result := GetBooleanField('IsLaybyTOS');
end;

function TSalesBase.GetIsVoucher: Boolean;
begin
  Result := GetBooleanField('IsVoucher');
end;

function TSalesBase.GetIsLayby: Boolean;
begin
  Result := GetBooleanField('IsLayby');
end;

function TSalesBase.GetMemo: string;
begin
  Result := GetStringField('Memo');
end;

function TSalesBase.GetOrderNumber: string;
begin
  Result := GetStringField('OrderNumber');
end;

function TSalesBase.GetPayMethod: string;
begin
  Result := GetStringField('PayMethod');
end;
function TSalesBase.GetSOQuteGlobalref:String;
begin
  REsult := '';
  if trim(SalesOrderGlobalref) ='' then Exit;
  Result :=tcdatautils.SOQuteGlobalref(SalesOrderGlobalref);
end;
function TSalesBase.GetQuoteGlobalRef: string;
begin
  Result := GetStringField('QuoteGlobalRef');
end;

function TSalesBase.GetSaleClassId: Integer;
begin
  Result := GetIntegerField('ClassId');
end;

function TSalesBase.GetSaleClassName: string;
begin
  Result := GetStringField('Class');
end;

function TSalesBase.GetSaleCustField1: string;
begin
  result := GetStringField('SaleCustField1');
end;

function TSalesBase.GetSaleCustField10: string;
begin
  result := GetStringField('SaleCustField10');
end;

function TSalesBase.GetSaleCustField2: string;
begin
  result := GetStringField('SaleCustField2');
end;

function TSalesBase.GetSaleCustField3: string;
begin
  result := GetStringField('SaleCustField3');
end;

function TSalesBase.GetSaleCustField4: string;
begin
  result := GetStringField('SaleCustField4');
end;

function TSalesBase.GetSaleCustField5: string;
begin
  result := GetStringField('SaleCustField5');
end;

function TSalesBase.GetSaleCustField6: string;
begin
  result := GetStringField('SaleCustField6');
end;

function TSalesBase.GetSaleCustField7: string;
begin
  result := GetStringField('SaleCustField7');
end;

function TSalesBase.GetSaleCustField8: string;
begin
  result := GetStringField('SaleCustField8');
end;

function TSalesBase.GetSaleCustField9: string;
begin
  result := GetStringField('SaleCustField9');
end;

function TSalesBase.GetSOGlobalRef: string;
begin
  Result := GetStringField('SalesOrderGlobalRef');
end;

function TSalesBase.getCleanContributionAmount: Double;
begin
  Result := GetXMLNodeFloatValue(CleanXMLNOde, 'ContributionAmount')
end;

function TSalesBase.getCleanSaleDate: TDatetime;
begin
  Result := GetXMLNodeDatetimeValue(CleanXMLNOde, 'SaleDate')
end;

function TSalesBase.GetChequeNumber: string;
begin
  Result := GetStringField('ChequeNo');
end;

function TSalesBase.getPOSPostCode: string;
begin
  Result := GetStringField('POSPostCode');
end;
function TSalesBase.getArea: string;
begin
  Result := GetStringField('Area');
end;

function TSalesBase.GetOriginalTotalAmount: Double;
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

function TSalesBase.GetOriginalTotalAmountInc: Double;
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

function TSalesBase.GetOriginalTotalTax: Double;
begin
  Result := Round(GetOriginalTotalAmountInc - GetOriginalTotalAmount, CurrencyRoundPlaces);
end;

procedure TSalesBase.PartSourceToManufacture(const Value: Boolean);
begin
  fbChangePartSourceToManufacture:= Value;
end;
Class procedure TSalesBase.PopulateMessageSubstituteList(aSaleId:Integer ; SL: TStringList);
var
  qry: TERPQuery;
  s:String;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    commondblib.closedb(qry);
    qry.sql.text := 'Select s.SaleId ,  ' +
                    ' c.Company,' +
                    ' c.Title as ClientTitle,' +
                    ' C.FirstName as ClientFirstName,' +
                    ' c.LastName as ClientLastName,' +
                    ' t.ContactId,' +
                    ' t.ContactTitle,' +
                    ' t.ContactFirstName,' +
                    ' t.ContactSurName as ContactLastName,' +
                    ' S.ShipTo, ' +
                    ' S.PONumber, ' +
                    ' concat(SL.Productname ,"     : " ,  SL.UnitofMeasureShipped , "  of  " ,   concat(SL.UnitofMeasureSaleLines , " (" , SL.UnitofMeasureMultiplier , ")" )) details ' +
                    ' from tblsales s ' +
                    ' inner join tblsaleslines SL on S.SAleId = SL.SaleId   ' +
                    ' inner join tblclients c on c.clientId = s.clientID' +
                    ' left join tblcontacts t on s.contactid = t.contactid' +
                    ' where ifnull(SL.UnitofMeasureShipped,0)<> 0 and  S.SaleID = ' + IntToStr(aSaleID);
    commondblib.opendb(qry);
    With Qry do begin
        SL.Values['#SaleID#'] := IntToStr(aSaleID);
        SL.Values['#ShippingAddress#'] := Fieldbyname('ShipTo').asString;
        SL.Values['#PONumber#'] := Fieldbyname('PONumber').asString;
        SL.Values['#Products#'] := Groupconcat('Details' , '' , False, #13#10 );
        SL.Values['#CustomerName#'] := FieldByName('Company').AsString;
        SL.Values['#CompanyName#'] := AppEnv.CompanyInfo.CompanyName;
        if FieldByName('ContactID').AsInteger > 0 then begin
          SL.Values['#Title#'] := Fieldbyname('ContactTitle').asString;
          SL.Values['#FirstName#'] := Fieldbyname('ContactFirstName').asString;
          SL.Values['#LastName#'] := Fieldbyname('ContactLastName').asString;
        end
        else begin
          SL.Values['#Title#'] := Fieldbyname('ClientTitle').asString;
          SL.Values['#FirstName#'] := Fieldbyname('ClientFirstName').asString;
          SL.Values['#LastName#'] := Fieldbyname('ClientLastName').asString;
        end;
        s := SL.Values['#Title#'];
        if SL.Values['#FirstName#'] <> '' then begin
          if s <> '' then s := s + ' ';
          s := s + SL.Values['#FirstName#'];
        end;
        if SL.Values['#LastName#'] <> '' then begin
          if s <> '' then s := s + ' ';
          s := s + SL.Values['#LastName#'];
        end;
        SL.Values['#ContactName#'] := s;
    end;

  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

end;
procedure TSalesBase.PopulateMessageSubstituteList(SL: TStringList);
begin
  PopulateMessageSubstituteList(ID, SL);
(*var
  s: string;
begin
  inherited;
  s:=
    'Select s.SaleId ,  ' +
    ' c.Company,' +
    ' c.Title as ClientTitle,' +
    ' C.FirstName as ClientFirstName,' +
    ' c.LastName as ClientLastName,' +
    ' t.ContactId,' +
    ' t.ContactTitle,' +
    ' t.ContactFirstName,' +
    ' t.ContactSurName as ContactLastName,' +
    ' S.ShipTo, ' +
    ' concat(SL.Productname ,"     : " ,  SL.UnitofMeasureShipped , "  of  " ,   concat(SL.UnitofMeasureSaleLines , " (" , SL.UnitofMeasureMultiplier , ")" )) details ' +
    ' from tblsales s ' +
    ' inner join tblsaleslines SL on S.SAleId = SL.SaleId   ' +
    ' inner join tblclients c on c.clientId = s.clientID' +
    ' left join tblcontacts t on s.contactid = t.contactid' +
    ' where ifnull(SL.UnitofMeasureShipped,0)<> 0 and  S.SaleID = ' + IntToStr(ID);
  with TERPQuery(GetNewDataset(s)) do try
    SL.Values['#SaleID#'] := IntToStr(ID);
    SL.Values['#ShippingAddress#'] := Fieldbyname('ShipTo').asString;
    SL.Values['#Products#'] := Groupconcat('Details' , '' , False, #13#10 );
    SL.Values['#CustomerName#'] := FieldByName('Company').AsString;
    SL.Values['#CompanyName#'] := AppEnv.CompanyInfo.CompanyName;
    if FieldByName('ContactID').AsInteger > 0 then begin
      SL.Values['#Title#'] := Fieldbyname('ContactTitle').asString;
      SL.Values['#FirstName#'] := Fieldbyname('ContactFirstName').asString;
      SL.Values['#LastName#'] := Fieldbyname('ContactLastName').asString;
    end
    else begin
      SL.Values['#Title#'] := Fieldbyname('ClientTitle').asString;
      SL.Values['#FirstName#'] := Fieldbyname('ClientFirstName').asString;
      SL.Values['#LastName#'] := Fieldbyname('ClientLastName').asString;
    end;
    s := SL.Values['#Title#'];
    if SL.Values['#FirstName#'] <> '' then begin
      if s <> '' then s := s + ' ';
      s := s + SL.Values['#FirstName#'];
    end;
    if SL.Values['#LastName#'] <> '' then begin
      if s <> '' then s := s + ' ';
      s := s + SL.Values['#LastName#'];
    end;
    SL.Values['#ContactName#'] := s;
  finally
    Free;
  end;*)
end;

procedure TSalesBase.SetChequeNumber(const Value: string);
begin
  SetStringField('ChequeNo', Value);
end;

class function TSalesBase.GetIDField: string;
begin
  Result := 'SaleID';
end;

class function TSalesBase.GetBusObjectTablename: string;
begin
  Result := 'tblSales';
end;

function TSalesBase.GetClient: TClient;
begin
  result:= Customer;
end;

function TSalesBase.GetClientName: string;
begin
  Result := CustomerName;
end;

procedure TSalesBase.SetClientName(const Value: string);
begin
  CustomerName := Value;
end;

function TSalesBase.GetShipCountry: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipToDesc);
  if ShipToID = 0 then begin
    if (Customer.Country <> '') and (Pos(Lowercase(Customer.Country), s) > 0) then
      result := Customer.Country;
  end
  else begin
    if (ShippingAddressObj.ShipCountry <> '') and (Pos(Lowercase(ShippingAddressObj.ShipCountry), s) > 0) then
      result := ShippingAddressObj.ShipCountry;
  end;
end;

function TSalesBase.GetShipDate: TDatetime;
begin
  Result := getDatetimeField('ShipDate');
end;

procedure TSalesBase.SetShipDate(const Value: TDatetime);
begin
  SetDatetimeField('ShipDate', Value);
end;

function TSalesBase.GetTotalQuoteAmount: Double;
begin
  Result := GetFloatField('TotalQuoteAmount');
end;

procedure TSalesBase.SetTotalQuoteAmount(const Value: Double);
begin
  SetFloatField('TotalQuoteAmount', Value);
end;

function TSalesBase.GetHoldSale: Boolean;
begin
  Result := GetBooleanField('HoldSale');
end;

procedure TSalesBase.SetHoldSale(const Value: Boolean);
begin
  SetBooleanField('HoldSale', Value);
end;

function TSalesBase.GetCustPONumber: string;
begin
  Result := GetStringField('PONumber');
end;

procedure TSalesBase.SetCustPONumber(const Value: string);
begin
  SetStringField('PONumber', Value);
end;

function TSalesBase.GetCustomerID: Integer;
begin
  Result := ClientID;
end;

procedure TSalesBase.SetCustomerID(const Value: Integer);
begin
  ClientID := Value;
end;

function TSalesBase.getCreationDate: TDatetime;
begin
  Result := getDatetimeField('OriginalCreationDate');
end;

function TSalesBase.getCustomerEmailId: String;
begin
  Result := '';
  if customerId = 0 then exit;
  result := Customer.Email;
end;

function TSalesBase.GetTotalMarkup: Double;
begin
  Result := GetFloatField('TotalMarkup');
end;

function TSalesBase.GetTotalWEGTax: Double;
begin
  Result := GetFloatField('TotalWEGTax');
end;

function TSalesBase.GetTotalWETTax: Double;
begin
  Result := GetFloatField('TotalWETTax');
end;

function TSalesBase.GetTotalDiscount: Double;
begin
  Result := GetFloatField('TotalDiscount');
end;

function TSalesBase.GetInvoiceCountry: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipToDesc);
  if (Customer.Billcountry <> '') and (Pos(Lowercase(Customer.Billcountry), s) > 0) then
    result := Customer.Billcountry;
end;

function TSalesBase.GetInvoicePostcode: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipToDesc);
  if (Customer.Postcode <> '') and (Pos(Lowercase(Customer.Postcode), s) > 0) then
    result := Customer.Postcode;
end;

function TSalesBase.GetInvoiceprintdesc: string;
begin
  Result := GetStringField('Invoiceprintdesc');
end;

function TSalesBase.GetInvoiceState: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipToDesc);
  if (Customer.BillState <> '') and (Pos(Lowercase(Customer.BillState), s) > 0) then
    result := Customer.BillState;
end;

function TSalesBase.GetInvoiceStreet1: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipToDesc);
  if (Customer.BillStreet <> '') and (Pos(Lowercase(Customer.BillStreet), s) > 0) then
    result := Customer.BillStreet;
end;

function TSalesBase.GetInvoiceStreet2: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipToDesc);
  if (Customer.BillStreet2 <> '') and (Pos(Lowercase(Customer.BillStreet2), s) > 0) then
    result := Customer.BillStreet2;
end;

function TSalesBase.GetInvoiceStreet3: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipToDesc);
  if (Customer.BillStreet3 <> '') and (Pos(Lowercase(Customer.BillStreet3), s) > 0) then
    result := Customer.BillStreet3;
end;

function TSalesBase.GetInvoiceSuburb: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipToDesc);
  if (Customer.Billsuburb <> '') and (Pos(Lowercase(Customer.Billsuburb), s) > 0) then
    result := Customer.Billsuburb;
end;

function TSalesBase.GetPrinthold: Boolean;
begin
  Result := GetBooleanField('Printhold');
end;

function TSalesBase.getProductIDs: String;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.Connection.Connection);
  try
    Qry.SQL.text := 'Select ProductID from tblsaleslines ' +
                    ' where SaleId = ' + inttostr(ID);
    Qry.open;
    result := Qry.GroupConcat('ProductId');
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function TSalesBase.GetPayduedate: string;
begin
  Result := GetStringField('Payduedate');
end;

function TSalesBase.GetApplyflag: Boolean;
begin
  Result := GetBooleanField('Applyflag');
end;

(*function TSalesBase.GetAmountdue: Double;
begin
  Result := GetFloatField('Amountdue');
end;*)

function TSalesBase.GetTimeofsale: string;
begin
  Result := GetStringField('Timeofsale');
end;

function TSalesBase.GetPos: Boolean;
begin
  Result := GetBooleanField('Pos');
end;

//function TSalesBase.getLaybyID: string;
//begin
//  Result := GetStringField('Laybyid');
//end;

function TSalesBase.GetLines: TTransLineBase;
begin
  Result := nil;
  { this function is overriden in descendants
    as an instance of this is created in busobjsalescommission, is overriden }
end;

function TSalesBase.GetDeposited: Boolean;
begin
  Result := GetBooleanField('Deposited');
end;

function TSalesBase.GetTillid: Integer;
begin
  Result := GetIntegerField('Tillid');
end;

function TSalesBase.GetTillname: string;
begin
  result := TPosTill.IDToggle(TillId, Connection.Connection);
end;

function TSalesBase.GetCommissionpaid: Boolean;
begin
  Result := GetBooleanField('Commissionpaid');
end;

function TSalesBase.GetIsmanifest: Boolean;
begin
  Result := GetBooleanField('Ismanifest');
end;

function TSalesBase.GetUsedonmanifest: Boolean;
begin
  Result := GetBooleanField('Usedonmanifest');
end;

function TSalesBase.GetAddtomanifest: Boolean;
begin
  Result := GetBooleanField('Addtomanifest');
end;

function TSalesBase.GetRepairglobalref: string;
begin
  Result := GetStringField('Repairglobalref');
end;

function TSalesBase.getRepairID: Integer;
begin
  Result := GetIntegerField('RepairID');
end;

function TSalesBase.GetIsbarcodepicking: Boolean;
begin
  Result := GetBooleanField('Isbarcodepicking');
end;

function TSalesBase.GetBarcodepickingdone: Boolean;
begin
  Result := GetBooleanField('Barcodepickingdone');
end;

function TSalesBase.GetArnotes: string;
begin
  Result := GetStringField('Arnotes');
end;

//function TSalesBase.GetDespatchid: Integer;
//begin
//  Result := GetIntegerField('Despatchid');
//end;

//function TSalesBase.GetRunid: Integer;
//begin
//  Result := GetIntegerField('Runid');
//end;

//function TSalesBase.GetRunname: string;
//begin
//  Result := GetStringField('Runname');
//end;

function TSalesBase.getIsGeneratedFromHire: Boolean;
begin
  Result := GetBooleanField('Isgeneratedfromhire');
end;
function TSalesBase.GetBlindbalanceprdid: Integer;
begin
  Result := GetIntegerField('Blindbalanceperiodid');
end;

function TSalesBase.GetSaledatetime: TDatetime;
begin
  Result := getDatetimeField('SaleDateTime');
end;

procedure TSalesBase.SetInvoiceprintdesc(const Value: string);
begin
  SetStringField('Invoiceprintdesc', Value);
end;

procedure TSalesBase.SetPrinthold(const Value: Boolean);
begin
  SetBooleanField('Printhold', Value);
end;

procedure TSalesBase.SetPayduedate(const Value: string);
begin
  SetStringField('Payduedate', Value);
end;

procedure TSalesBase.SetApplyflag(const Value: Boolean);
begin
  SetBooleanField('Applyflag', Value);
end;

(*procedure TSalesBase.SetAmountdue(const Value: Double);
begin
  SetFloatField('Amountdue', Value);
end;*)

procedure TSalesBase.SetTimeofsale(const Value: string);
begin
  SetStringField('Timeofsale', Value);
end;

procedure TSalesBase.SetPos(const Value: Boolean);
begin
  SetBooleanField('Pos', Value);
end;

//procedure TSalesBase.SetLayByID(const Value: string);
//begin
//  SetStringField('Laybyid', Value);
//end;

procedure TSalesBase.SetDeposited(const Value: Boolean);
begin
  SetBooleanField('Deposited', Value);
end;

procedure TSalesBase.SetTillid(const Value: Integer);
begin
  SetIntegerField('Tillid', Value);
end;

procedure TSalesBase.SetTillname(const Value: string);
begin
  TillId := TPosTill.IDToggle(Value, Connection.Connection);
end;

procedure TSalesBase.SetCommissionpaid(const Value: Boolean);
begin
  SetBooleanField('Commissionpaid', Value);
end;

procedure TSalesBase.SetIsmanifest(const Value: Boolean);
begin
  SetBooleanField('Ismanifest', Value);
end;

//procedure TSalesBase.setISManTrans(const Value: Boolean);
//begin
//  SetBooleanField('ISManTrans', Value)
//end;

procedure TSalesBase.SetUsedonmanifest(const Value: Boolean);
begin
  SetBooleanField('Usedonmanifest', Value);
end;

procedure TSalesBase.SendEmailtoErp(const Msg: string);
begin
  SendEvent(BusobjEvent_ToDo, BusObjProcTreePartWrongProduct);
end;

procedure TSalesBase.SetAddtomanifest(const Value: Boolean);
begin
  SetBooleanField('Addtomanifest', Value);
end;

procedure TSalesBase.SetRepairglobalref(const Value: string);
begin
  SetStringField('Repairglobalref', Value);
end;

procedure TSalesBase.SetRepairID(const Value: Integer);
begin
  SetIntegerField('RepairId', Value);
end;

procedure TSalesBase.SetIsbarcodepicking(const Value: Boolean);
begin
  SetBooleanField('Isbarcodepicking', Value);
end;

procedure TSalesBase.SetBarcodepickingdone(const Value: Boolean);
begin
  SetBooleanField('Barcodepickingdone', Value);
end;

procedure TSalesBase.SetArnotes(const Value: string);
begin
  SetStringField('Arnotes', Value);
end;

//procedure TSalesBase.SetDespatchid(const Value: Integer);
//begin
//  SetIntegerField('Despatchid', Value);
//end;

//procedure TSalesBase.SetRunid(const Value: Integer);
//begin
//  SetIntegerField('Runid', Value);
//end;

//procedure TSalesBase.SetRunname(const Value: string);
//begin
//  SetStringField('Runname', Value);
//end;

procedure TSalesBase.SetIsGeneratedFromHire(const Value: Boolean);
begin
  SetBooleanField('Isgeneratedfromhire', Value);
end;

procedure TSalesBase.SetBlindbalperiodid(const Value: Integer);
begin
  SetIntegerField('Blindbalanceperiodid', Value);
end;

procedure TSalesBase.SetSaledatetime(const Value: TDatetime);
begin
  SetDatetimeField('SaleDateTime', Value);
end;

procedure TSalesBase.SetSalesStatus(const Value: string);
begin
  SetStringField('QuoteStatus', Value);
end;
procedure TSalesBase.SetHireGlobalref(const Value: string);
begin
  SetStringField('HireGlobalref', Value);
end;

procedure TSalesBase.SetCreationDate(const Value: TDatetime);
begin
  SetDatetimeField('OriginalCreationDate', Value);
end;


procedure TSalesBase.SetConNote(const Value: string);
begin
  SetStringField('ConNote', Value);
end;

procedure TSalesBase.SetAutoSmartOrderRef(const Value: string);
begin
  SetStringField('AutoSmartOrderRef', Value);
end;

procedure TSalesBase.SetPOCreated(const Value: Boolean);
begin
  SetBooleanField('POCreated', Value);
end;

procedure TSalesBase.SetIsCashSale(const Value: Boolean);
begin
  SetBooleanField('IsCashSale', Value);
end;

procedure TSalesBase.SetIsInvoice(const Value: Boolean);
begin
  SetBooleanField('IsInvoice', Value);
end;

procedure TSalesBase.SetIsQuote(const Value: Boolean);
begin
  SetBooleanField('IsQuote', Value);
end;

procedure TSalesBase.SetIsPos(const Value: Boolean);
begin
  SetBooleanField('IsPOS', Value);
end;

procedure TSalesBase.SetIsRefund(const Value: Boolean);
begin
  SetBooleanField('IsRefund', Value);
end;

procedure TSalesBase.SetIsSalesOrder(const Value: Boolean);
begin
  SetBooleanField('IsSalesOrder', Value);
end;

procedure TSalesBase.SetIsLaybyPayment(const Value: Boolean);
begin
  SetBooleanField('IsLaybyPayment', Value);
end;
procedure TSalesBase.SetIsCustomerreturn(const Value: Boolean);
begin
  SetBooleanField('IsCustomerreturn', Value);
end;

procedure TSalesBase.SetIsLaybyTOS(const Value: Boolean);
begin
  SetBooleanField('IsLaybyTOS', Value);
end;

procedure TSalesBase.SetIsVoucher(const Value: Boolean);
begin
  SetBooleanField('IsVoucher', Value);
end;

procedure TSalesBase.SetIsLayby(const Value: Boolean);
begin
  SetBooleanField('IsLayby', Value);
end;

procedure TSalesBase.SetMemo(const Value: string);
begin
  SetStringField('Memo', Value);
end;

procedure TSalesBase.SetOrderNumber(const Value: string);
begin
  SetStringField('OrderNumber', Value);
end;

procedure TSalesBase.SetPayMethod(const Value: string);
begin
  SetStringField('PayMethod', Value);
end;

procedure TSalesBase.SetQuoteGlobalRef(const Value: string);
begin
  SetStringField('QuoteGlobalRef', Value);
end;

procedure TSalesBase.SetSaleClassId(const Value: Integer);
begin
  SetIntegerField('ClassId', Value);
end;

procedure TSalesBase.SetSaleClassName(const Value: string);
begin
  SetStringField('Class', Value);
end;

procedure TSalesBase.SetSaleCustField1(const Value: string);
begin
  SetStringField('SaleCustField1',Value);
end;

procedure TSalesBase.SetSaleCustField10(const Value: string);
begin
  SetStringField('SaleCustField10',Value);
end;

procedure TSalesBase.SetSaleCustField2(const Value: string);
begin
  SetStringField('SaleCustField2',Value);
end;

procedure TSalesBase.SetSaleCustField3(const Value: string);
begin
  SetStringField('SaleCustField3',Value);
end;

procedure TSalesBase.SetSaleCustField4(const Value: string);
begin
  SetStringField('SaleCustField4',Value);
end;

procedure TSalesBase.SetSaleCustField5(const Value: string);
begin
  SetStringField('SaleCustField5',Value);
end;

procedure TSalesBase.SetSaleCustField6(const Value: string);
begin
  SetStringField('SaleCustField6',Value);
end;

procedure TSalesBase.SetSaleCustField7(const Value: string);
begin
  SetStringField('SaleCustField7',Value);
end;

procedure TSalesBase.SetSaleCustField8(const Value: string);
begin
  SetStringField('SaleCustField8',Value);
end;

procedure TSalesBase.SetSaleCustField9(const Value: string);
begin
  SetStringField('SaleCustField9',Value);
end;

procedure TSalesBase.SetSOGlobalRef(const Value: string);
begin
  SetStringField('SalesOrderGlobalRef', Value);
end;

procedure TSalesBase.SetTotalMarkup(const Value: Double);
begin
  SetFloatField('TotalMarkup', Value);
end;

procedure TSalesBase.SetTotalWEGTax(const Value: Double);
begin
  SetFloatField('TotalWEGTax', Value);
end;

procedure TSalesBase.SetTotalWETTax(const Value: Double);
begin
  SetFloatField('TotalWETTax', Value);
end;

procedure TSalesBase.SetTransStatus(const Value: String);
begin
  inherited;
  SalesStatus:= Value;
end;

procedure TSalesBase.SetTotalDiscount(const Value: Double);
begin
  SetFloatField('TotalDiscount', Value);
end;

procedure TSalesBase.setPOSPostCode(const Value: string);
begin
  SetStringField('POSPostCode', Value);
end;
procedure TSalesBase.setArea(const Value: string);
begin
  SetStringField('Area', Value);
end;

function TSalesBase.GetShippingCost: Double;
begin
  Result := GetFloatField('ShippingCost');
end;

function TSalesBase.GetShipPostcode: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipToDesc);
  if ShipToID = 0 then begin
    if (Customer.Postcode <> '') and (Pos(Lowercase(Customer.Postcode), s) > 0) then
      result := Customer.Postcode;
  end
  else begin
    if (ShippingAddressObj.ShipPostcode <> '') and (Pos(Lowercase(ShippingAddressObj.ShipPostcode), s) > 0) then
      result := ShippingAddressObj.ShipPostcode;
  end;
end;

function TSalesBase.GetShipState: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipToDesc);
  if ShipToID = 0 then begin
    if (Customer.State <> '') and (Pos(Lowercase(Customer.State), s) > 0) then
      result := Customer.State;
  end
  else begin
    if (ShippingAddressObj.ShipState <> '') and (Pos(Lowercase(ShippingAddressObj.ShipState), s) > 0) then
      result := ShippingAddressObj.ShipState;
  end;
end;

function TSalesBase.GetShipStreet1: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipToDesc);
  if ShipToID = 0 then begin
    if (Customer.Street <> '') and (Pos(Lowercase(Customer.Street), s) > 0) then
      result := Customer.Street;
  end
  else begin
    if (ShippingAddressObj.ShipAddress <> '') and (Pos(Lowercase(ShippingAddressObj.ShipAddress), s) > 0) then
      result := ShippingAddressObj.ShipAddress;
  end;
end;

function TSalesBase.GetShipStreet2: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipToDesc);
  if ShipToID = 0 then begin
    if (Customer.Street2 <> '') and (Pos(Lowercase(Customer.Street2), s) > 0) then
      result := Customer.Street2;
  end
  else begin
    if (ShippingAddressObj.ShipAddress1 <> '') and (Pos(Lowercase(ShippingAddressObj.ShipAddress1), s) > 0) then
      result := ShippingAddressObj.ShipAddress1;
  end;
end;

function TSalesBase.GetShipStreet3: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipToDesc);
  if ShipToID = 0 then begin
    if (Customer.Street3 <> '') and (Pos(Lowercase(Customer.Street3), s) > 0) then
      result := Customer.Street3;
  end
  else begin
    if (ShippingAddressObj.ShipAddress2 <> '') and (Pos(Lowercase(ShippingAddressObj.ShipAddress2), s) > 0) then
      result := ShippingAddressObj.ShipAddress2;
  end;
end;

function TSalesBase.GetShipSuburb: string;
var s: string;
begin
  result := '';
  s := Lowercase(ShipToDesc);
  if ShipToID = 0 then begin
    if (Customer.Suburb <> '') and (Pos(Lowercase(Customer.Suburb), s) > 0) then
      result := Customer.Suburb;
  end
  else begin
    if (ShippingAddressObj.ShipCity <> '') and (Pos(Lowercase(ShippingAddressObj.ShipCity), s) > 0) then
      result := ShippingAddressObj.ShipCity;
  end;
end;

procedure TSalesBase.SetShippingCost(const Value: Double);
begin
  SetFloatField('ShippingCost', Value);
end;

constructor TSalesBase.Create(AOwner: TComponent);
begin
  AutoResetingPrices := False;
  fMakeJEforManCOGSDiff := nil;
  inherited Create(AOwner);
  fbconvertingQuote := False;
  fUseWholesalePrice := False;
  fiSaleCommissionCalcId := 0;
  fbChangePartSourceToManufacture := False;
  InternalQuantityChange := False;
  DoingCalcOrderTotals := False;
  TmpTotalEstimatedAmountInc := 0;
  ExportExcludeList.Add('saleid');
  //ExportExcludeList.Add('customerid');
//  ExportExcludeList.Add('saleclassid');
  ExportExcludeList.Add('cleansaledate');
  ExportExcludeList.Add('isgeneratedfromhire');
  ExportExcludeList.Add('iscashsale');
  ExportExcludeList.Add('isinvoice');
  ExportExcludeList.Add('islayby');
  ExportExcludeList.Add('islaybypayment');
  ExportExcludeList.Add('IsCustomerreturn');
  ExportExcludeList.Add('islaybytos');
  ExportExcludeList.Add('ispos');
  ExportExcludeList.Add('isquote');
  ExportExcludeList.Add('isrefund');
  ExportExcludeList.Add('issalesorder');
  ExportExcludeList.Add('isvoucher');
  ExportExcludeList.Add('eop_pos');
  ExportExcludeList.Add('medtypeid');
  //CalculatingAvaTax:=False;
end;

class function TSalesBase.CustPONumberForSaleID(const aSaleId: Integer;
  Conn: TCustomMyConnection): string;
var
  qry: TERPQuery;
begin
  if Assigned(Conn) then
    qry := DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select PONumber from tblsales where SaleID = ' + IntToStr(aSaleId));
    qry.Open;
    result := qry.FieldByName('PONumber').AsString;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function TSalesBase.ValidateData: Boolean;
begin
  Result := inherited ValidateData;
  if not Result then Exit;
  if Self.SaleClassId < 1 then begin
    ResultStatus.AddItem(False, rssInfo, BOR_Sales_Err_InvalidDepartment, AppEnv.DefaultClass.ClassHeading + ' is missing.');
    Result := False;
  end;
  if not ValidateContributionAmount then begin
    ResultStatus.AddItem(True, rssWarning, 0, 'Customer of ' + XMLNodename + ' #' + inttostr(ID) + '[' + CustomerName +
      '] is not a Related Customer.  The Customer Has to be a Related Customer to Have a Contribution Amount.', True);
    Result := False;
    Exit;
  end;
  if CustPONumber <> '' then
    if AppEnv.CompanyPrefs.UniqueCustomerPONumInSale then begin
      with GetNewDataset('select SaleId ,CustomerName from tblSales ' + ' where Ponumber =' + QuotedStr(CustPONumber) + ' and saleId <>' + inttostr(ID)+' and ClientID = ' + inttostr(clientID)) do
        try
          if recordcount > 0 then begin
            ResultStatus.AddItem(False, rssInfo, 0, 'P.O. number #' + CustPONumber + ' already exists in ' + chr(13) + tcDataUtils.SaleType(FieldByname('saleID').asInteger) + '#' +
              inttostr(FieldByname('SaleId').asInteger) +' For Customer :' + Quotedstr(FieldByname('CustomerName').AsString) + '.'+NL+NL+
              'Based on the preference, ''Customer P.O. Number Must Be Unique'' for the customer.' +NL +NL+
              'It is Changed to ' + CustPONumber + '(' + inttostr(ID) + ')');
            CustPONumber := CustPONumber + '(' + inttostr(ID) + ')';
            PostDB;
          end;
        finally
          if Active then close;
          Free;
        end;
    end;
end;

class function TSalesBase._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TCustomer','CustomerObj','CustomerName','ClientName');
  TBOSchema.AddRefType(result,'TDeptClass','SaleClass','SaleClassName','DeptClassName');
  TBOSchema.AddRefType(result,'TPaymentMethod','PaymentMethodObj','PayMethod','PaymentMethodName');
  TBOSchema.AddRefType(result,'TPosTill','PosTillObj','TillId','ID');
  TBOSchema.AddRefType(result,'TRepairs','RepairObj','RepairID','ID');
  TBOSchema.AddRefType(result,'TSource','SourceObj','MedType','MediaType');
  TBOSchema.AddRefType(result,'TShippingAddress','ShippingAddressObj','ShipToID','ID');
end;

procedure TSalesBase.AssignDefaultShipped(const Sender: TBusObj; var Abort: Boolean);
var
  fDoFieldChangewhenDisabled: Boolean;
begin
  { if Qtyshipped is <> 0 and if < the qtysold, its a SO already having a BO,
    convertion will convert the BOs as well - so can't change the qty }
  if (TSalesLineBase(Sender).QtyShipped <> 0) and (TSalesLineBase(Sender).QtyShipped <> TSalesLineBase(Sender).QtySold) then Exit;
  { this is to call the dofield on change and get the default shipped qty
    this proc is called after cloning the busobj - to copy a quote to invoice/SO/cashsale }
  fDoFieldChangewhenDisabled := TSalesLineBase(Sender).DoFieldChangewhenDisabled;
  TSalesLineBase(Sender).DoFieldChangewhenDisabled := True;
  try
    TSalesLineBase(Sender).QtySold := TSalesLineBase(Sender).QtySold;
    TSalesLineBase(Sender).Invoiced := (TSalesLineBase(Sender).QtyShipped <> 0);
  finally TSalesLineBase(Sender).DoFieldChangewhenDisabled := fDoFieldChangewhenDisabled;
  end;
  TSalesLineBase(Sender).PostDB;
  TSalesLineBase(Sender).CalcLineTotals;
end;

procedure TSalesBase.AutoResetPricesOncustomerchange;
begin
  if lines.count =0 then exit;
  AutoResetingPrices := True;
  try
      If Assigned(ConfirmFromGUI) and
        (FconfirmFromGUI('There are '+ inttostr(lines.count)+' Products .' + Chr(13)  +  'Do you Wish To Keep the Price?', [MbYes, MbNo]) = mrNo) Then Exit;
    Lines.IterateRecords(AutoResetPricesCallback);
  finally
    AutoResetingPrices := False;
  end;
end;
Function TSalesBase.AvaTaxRelatedData:String;
var
  aJO:TJsonObject;
begin
  aJo := jo;
  try
    AvaTaxRelated(aJO);
    if aJO.O['fields'].B['singleLocation'] then begin
      aJO.O['fields'].O['ShipTo'].S['Street1']  := aJO.O['fields'].O['ShipFrom'].S['Street1'];
      aJO.O['fields'].O['ShipTo'].S['Street2']  := aJO.O['fields'].O['ShipFrom'].S['Street2'];
      aJO.O['fields'].O['ShipTo'].S['Street3']  := aJO.O['fields'].O['ShipFrom'].S['Street3'];
      aJO.O['fields'].O['ShipTo'].S['City']     := aJO.O['fields'].O['ShipFrom'].S['City'];
      aJO.O['fields'].O['ShipTo'].S['State']    := aJO.O['fields'].O['ShipFrom'].S['State'];
      aJO.O['fields'].O['ShipTo'].S['PostCode'] := aJO.O['fields'].O['ShipFrom'].S['PostCode'];
      aJO.O['fields'].O['ShipTo'].S['Country']  := aJO.O['fields'].O['ShipFrom'].S['Country'];
    end else begin
      aJO.O['fields'].O['ShipTo'].S['Street1']  := ShipStreet1;
      aJO.O['fields'].O['ShipTo'].S['Street2']  := ShipStreet2;
      aJO.O['fields'].O['ShipTo'].S['Street3']  := ShipStreet3;
      aJO.O['fields'].O['ShipTo'].S['City']     := ShipSuburb;
      aJO.O['fields'].O['ShipTo'].S['State']    := ShipState;
      aJO.O['fields'].O['ShipTo'].S['PostCode'] := ShipPostcode;
      aJO.O['fields'].O['ShipTo'].S['Country']  := ShipCountry;
    end;
    result := aJo.asString;
  finally
    aJo.free;
  end;
end;
Function TSalesBase.AssignPickupfrom(JoShipFrom:TJsonObject):Boolean;
var
  aClient:TClient;
begin
  REsult := False;
  if pickupfromid =0 then exit;
  aClient:= TClient.CreateWithSharedConn(nil);
  try
    aClient.load(pickupfromid);
    if aClient.count =0 then exit;
    if  (trim(aclient.Street) ='') Or
        (trim(aclient.Suburb) ='') Or
        (trim(aclient.State) ='') Or
        (trim(aclient.PostCode) ='') Or
        (trim(aclient.Country) ='') then exit; // if address blank or incomplete
        JoShipFrom.S['Street1']  := aclient.Street;
        JoShipFrom.S['Street2']  := aclient.Street2;
        JoShipFrom.S['Street3']  := aclient.Street3;
        JoShipFrom.S['City']     := aclient.Suburb;
        JoShipFrom.S['State']    := aclient.State;
        JoShipFrom.S['PostCode'] := aclient.Postcode;
        JoShipFrom.S['Country']  := aclient.Country;
        Result := True;
  finally
    Freeandnil(aClient);
  end;

end;
Function TSalesBase.CommitInAvaTax:Boolean;
begin
  Result := Sametext(Self.SalesStatus, Appenv.companyPrefs.CommittedStatus) and not(((Self is TSalesOrder) or (Self is TQuote)))
end;
procedure TSalesBase.AvaTaxRelated(ajson: TJsonObject);
begin
                ajson.O['fields'].S['customerCode']           := Self.Customer.ClientNo;
                ajson.O['fields'].S['AvaTaxSaleCode']         := trim(AppEnv.CompanyPrefs.AvaTax_AvaTaxSaleCode);
                if ajson.O['fields'].S['AvaTaxSaleCode'] ='' then ajson.O['fields'].S['AvaTaxSaleCode']:= 'Sale From TrueERP';
                ajson.O['fields'].S['AvaTaxSaleCode']:= trim(ajson.O['fields'].S['AvaTaxSaleCode'])+'#'+ Original_Quote_SO_Invoice_Ref;
                ajson.O['fields'].S['adjustmentReason']       := 'Other';
                ajson.O['fields'].S['adjustmentDescription']  := 'Test Description';
                ajson.O['fields'].B['commitinAvatx']          := CommitInAvaTax;//  ((Self is TSales) and (TSales(Self).Converted)) or (Self.AccessManager.AccessLevel >3);
                ajson.O['fields'].B['singleLocation']         := (Self is TCashBase) or (Self is TPOS) or (Self is TPOsCashSale) or sametext(Self.Shipping , appenv.companyprefs.PickupShipingMethod) ;
                if (Self is TCashBase) or (Self is TPOS) or (Self is TPOsCashSale)  then ajson.O['fields'].S['singleLocationDesc']     := 'Single Location - Retail Transaction ('+ Self.classname +')'
                else if sametext(Self.Shipping , appenv.companyprefs.PickupShipingMethod) then ajson.O['fields'].S['singleLocationDesc']     := 'Single Location - ('+ Self.classname +') has Pickup Shipping method - ' +Self.Shipping
                else if ajson.O['fields'].B['singleLocation'] then ajson.O['fields'].S['singleLocationDesc']     := 'Single Location - unknown reason'
                else ajson.O['fields'].S['singleLocationDesc']     := 'Ship to a location';
//if devmode then ajson.O['fields'].S['singleLocationDesc']     := Self.Classname+' [TCashBase/TPOS/TPOsCashSale] '+ Self.Shipping  +' ['+appenv.companyprefs.PickupShipingMethod+']';
                if (pickupfromid <> 0) and AssignPickupfrom(ajson.O['fields'].O['ShipFrom']) then begin
                end else begin
                    ajson.O['fields'].O['ShipFrom'].S['Street1']  := AppEnv.CompanyInfo.Address;
                    ajson.O['fields'].O['ShipFrom'].S['Street2']  := AppEnv.CompanyInfo.Address2;
                    ajson.O['fields'].O['ShipFrom'].S['Street3']  := AppEnv.CompanyInfo.Address3;
                    ajson.O['fields'].O['ShipFrom'].S['City']     := AppEnv.CompanyInfo.City;
                    ajson.O['fields'].O['ShipFrom'].S['State']    := AppEnv.CompanyInfo.State;
                    ajson.O['fields'].O['ShipFrom'].S['PostCode'] := AppEnv.CompanyInfo.Postcode;
                    ajson.O['fields'].O['ShipFrom'].S['Country']  := AppEnv.CompanyInfo.Country;
                end;
end;

procedure TSalesBase.AutoResetPricesCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  TSalesLine(Sender).CalculateLine;
end;

function TSalesBase.CloneBusObj(const Changefield: string; const ChangeValue: Variant; const SaveAfterCopy: Boolean = True; const FilterFields: string = ''): TBusObj;
var
  sShipAddress: string;
begin
  Result := inherited CloneBusObj(Changefield, ChangeValue, SaveAfterCopy, FilterFields);
  if Result = nil then Exit;
  clonedId := ObjInstanceToClone.ID;
  if uppercase(Changefield) = uppercase('ClientID') then begin
    sShipAddress := GetShippingAddress(TSalesBase(ObjInstanceToClone).ClientID);
    TSalesBase(ObjInstanceToClone).CustomerName := tcDataUtils.GetClientName(TSalesBase(ObjInstanceToClone).ClientID);
    TSalesBase(ObjInstanceToClone).InvoiceToDesc := TSalesBase(ObjInstanceToClone).CustomerName + #13 + #10 + GetPhysicalAddress(TSalesBase(ObjInstanceToClone).ClientID);
    if Empty(sShipAddress) then TSalesBase(ObjInstanceToClone).ShipToDesc := TSalesBase(ObjInstanceToClone).InvoiceToDesc
    else TSalesBase(ObjInstanceToClone).ShipToDesc := TSalesBase(ObjInstanceToClone).CustomerName + #13 + #10 + sShipAddress;
    TSalesBase(ObjInstanceToClone).PickupFromDesc := TSalesBase(ObjInstanceToClone).PickupFromDesc;
    TSalesBase(ObjInstanceToClone).PickupFromClientName := TSalesBase(ObjInstanceToClone).PickupFromClientName;
    TSalesBase(ObjInstanceToClone).PostDB;

    { copy attachments }
    CopyAttachments(Self.TableName, Self.ID, ObjInstanceToClone.TableName, ObjInstanceToClone.ID, Self.connection.connection);
  end;
  Result := ObjInstanceToClone;
end;

procedure TSalesBase.LoadFromXMLNode(const node: IXMLNode);
var
  fiGLAccountId: Integer;
  fiClientId: Integer;
  fiEmployeeId: Integer;
  fiSaleClassID: Integer;
begin
  { get the IDs of the description when importing }
  if not ImportingFromXMLFile then begin
    fiGLAccountId := GetXMLNodeIntegerValue(node, 'GLAccountId');
    fiClientId := GetXMLNodeIntegerValue(node, 'ClientId');
    fiEmployeeId := GetXMLNodeIntegerValue(node, 'EmployeeId');
    fiSaleClassID := GetXMLNodeIntegerValue(node, 'SaleClassID');
  end else begin
    fiGLAccountId := tcDataUtils.GetAccountID(GetXMLNodeStringValue(node, 'GLaccountName'));
    fiClientId := TClient.IDToggle(GetXMLNodeStringValue(Node, 'CustomerName'), Connection.Connection);
    fiEmployeeId := tcDataUtils.GetEmployeeId(GetXMLNodeStringValue(node, 'EmployeeName'));
    fiSaleClassID := tcDataUtils.GetDeptID(GetXMLNodeStringValue(node, 'SaleClassName'));
  end;

  SetPropertyFromNode(node, 'GLaccountName');
  if fiGLAccountId <> 0 then GLaccountID := fiGLAccountId;

  if not ImportingFromXMLFile then begin
    SetPropertyFromNode(node, 'DocNumber');
    SetPropertyFromNode(node, 'TotalBalance');
  end;
  ClientID := fiClientId;
  SetBooleanPropertyFromNode(node, 'Deleted');
  SetDateTimePropertyFromNode(node, 'DueDate');
  EmployeeId := fiEmployeeId;
  SetPropertyFromNode(node, 'EmployeeName');
  SetPropertyFromNode(node, 'EnteredAt');
  SetPropertyFromNode(node, 'ForeignExchangeCode');
  SetPropertyFromNode(node, 'ForeignExchangeRate');
  if not ImportingFromXMLFile then begin
    SetPropertyFromNode(node, 'BaseNo');
    SetPropertyFromNode(node, 'BackOrderGlobalRef');
    SetPropertyFromNode(node, 'OriginalDocNumber');
  end;
  if not ImportingFromXMLFile then begin
    SetPropertyFromNode(node, 'ForeignPaidAmount');
    SetPropertyFromNode(node, 'ForeignBalanceAmount');
  end;
  SetPropertyFromNode(node, 'ForeignTotalAmount');

  { Payments should be done separately }
  if not ImportingFromXMLFile then begin
    SetBooleanPropertyFromNode(node, 'IsPaid');
    SetPropertyFromNode(node, 'TotalPaid');
  end;
  SetPropertyFromNode(node, 'TermsName');
  SetPropertyFromNode(node, 'TotalAmount');
  SetPropertyFromNode(node, 'TotalAmountInc');
  SetPropertyFromNode(node, 'TotalTax');
  SetPropertyFromNode(node, 'Enteredby');
  SetPropertyFromNode(node, 'CustomerName');
  SetPropertyFromNode(node, 'InvoiceToDesc');
  SetPropertyFromNode(node, 'ShipToDesc');

  SetPropertyFromNode(node, 'InvoiceStreet1');
  SetPropertyFromNode(node, 'InvoiceStreet2');
  SetPropertyFromNode(node, 'InvoiceStreet3');
  SetPropertyFromNode(node, 'InvoiceSuburb');
  SetPropertyFromNode(node, 'InvoiceState');
  SetPropertyFromNode(node, 'InvoiceCountry');
  SetPropertyFromNode(node, 'InvoicePostcode');

  SetPropertyFromNode(node, 'ShipStreet1');
  SetPropertyFromNode(node, 'ShipStreet2');
  SetPropertyFromNode(node, 'ShipStreet3');
  SetPropertyFromNode(node, 'ShipSuburb');
  SetPropertyFromNode(node, 'ShipState');
  SetPropertyFromNode(node, 'ShipCountry');
  SetPropertyFromNode(node, 'ShipPostcode');

  SetPropertyFromNode(node, 'Shipping');
  SetPropertyFromNode(node, 'PickupFromDesc');
  SetPropertyFromNode(node, 'PickupFromClientName');
  SetPropertyFromNode(node, 'RepairGlobalref');
  SetDateTimePropertyFromNode(node, 'SaleDate');
  SetPropertyFromNode(node, 'TotalWETTax');
  SetPropertyFromNode(node, 'TotalWEGTax');
  SetPropertyFromNode(node, 'TotalMarkup');
  SetPropertyFromNode(node, 'TotalDiscount');
  SetPropertyFromNode(node, 'TotalQuoteAmount');
  SetPropertyFromNode(node, 'SaleClassName');
  SaleClassId := fiSaleClassID;
  SetPropertyFromNode(node, 'OrderNumber');
  SetPropertyFromNode(node, 'ChequeNumber');
  SetPropertyFromNode(node, 'ConNote');
  SetPropertyFromNode(node, 'AutoSmartOrderRef');
  SetPropertyFromNode(node, 'Memo');
  SetPropertyFromNode(node, 'PickMemo');
  SetPropertyFromNode(node, 'PayMethod');
  SetPropertyFromNode(node, 'SalesOrderGlobalRef');
  SetPropertyFromNode(node, 'QuoteGlobalRef');
  SetDateTimePropertyFromNode(node, 'ShipDate');
  SetBooleanPropertyFromNode(node, 'UseWholesalePrice');
  SetBooleanPropertyFromNode(node, 'HoldSale');
  SetPropertyFromNode(node, 'CustPONumber');
  SetPropertyFromNode(node, 'Dvafilenum');
  SetPropertyFromNode(node, 'Timeofsale');
  SetBooleanPropertyFromNode(node, 'IsInvoice');
  SetBooleanPropertyFromNode(node, 'IsRefund');
  SetBooleanPropertyFromNode(node, 'IsQuote');
  SetBooleanPropertyFromNode(node, 'IsSalesOrder');
  SetBooleanPropertyFromNode(node, 'IsLayby');
  SetBooleanPropertyFromNode(node, 'IsCashSale');
  SetBooleanPropertyFromNode(node, 'IsCustomerReturn');
  SetBooleanPropertyFromNode(node, 'IsPOS');
  SetPropertyFromNode(node, 'ShippingCost');
  SetPropertyFromNode(node, 'PosPostCode');
  SetPropertyFromNode(node, 'Area');
  SetPropertyFromNode(node, 'medtypeID');
  SetPropertyFromNode(node, 'NoOfBoxes');
  SetPropertyFromNode(node, 'Medtype');
  SetPropertyFromNode(node, 'ContributionAmount');
  SetPropertyFromNode(node, 'ShipToID');
  SetPropertyFromNode(node,'SalesStatus');
  SetPropertyFromNode(node,'HireGlobalref');
  SetPropertyFromNode(node,'SaleCustField1');
  SetPropertyFromNode(node,'SaleCustField2');
  SetPropertyFromNode(node,'SaleCustField3');
  SetPropertyFromNode(node,'SaleCustField4');
  SetPropertyFromNode(node,'SaleCustField5');
  SetPropertyFromNode(node,'SaleCustField6');
  SetPropertyFromNode(node,'SaleCustField7');
  SetPropertyFromNode(node,'SaleCustField8');
  SetPropertyFromNode(node,'SaleCustField9');
  SetPropertyFromNode(node,'SaleCustField10');
  inherited;
end;

function TSalesBase.Save: Boolean;
begin
  //if not(CalculatingAvaTax) and (Dirty) then CalcAvaTax;
  result := inherited save;
end;

function TSalesBase.SaveCancelled: boolean;
begin
  //if (cleanId<>0) or (Lines.count >0) then CalcAvaTax;
  if Self.convertingSO then
    result := false
  else
    result := inherited;
end;

function TSalesLineBase.GetUOMLinePrice: double;
begin
  result := Round(LinePrice * UOMMultiplier, RoundPlacesGeneral);
end;

function TSalesLineBase.GetUOMLinePriceInc: double;
begin
  result := Round(LinePriceInc * UOMMultiplier, RoundPlacesGeneral);
end;

Function TSalesLineBase.GetUOM_Height:Double            ; begin result := GetFloatField('UOM_Height');end;
Function TSalesLineBase.GetUOM_Width:Double             ; begin result := GetFloatField('UOM_Width');end;
(*function TSalesLineBase.getupdatingBO: boolean;
begin
  result:= False;
  if Assigned(Owner) then
    if Owner is TTransBase then
      result:= TTransBase(Owner).UpdatingBo;
end;*)
(*procedure TSalesLineBase.SetUOMQtyShipped(const Value: Double);
begin
  if (UOMQtyShipped=0) and (Value <> 0) and Assigned(Owner) and (Owner is TSalesbase)  then begin
    TSalesbase(Owner).SaleDateTime := now;
    TSalesbase(Owner).PostDB;
  end;
  inherited;
end;*)

Function TSalesLineBase.GetUOM_Length:Double            ; begin result := GetFloatField('UOM_Length');end;
Function TSalesLineBase.GetUOM_Weight:Double            ; begin result := GetFloatField('UOM_Weight');end;
Function TSalesLineBase.GetTotalUOM_WeightSold:Double   ; begin result := GetFloatField('TotalUOM_WeightSold');end;
Function TSalesLineBase.GetTotalUOM_WeightShipped:Double; begin result := GetFloatField('TotalUOM_WeightShipped');end;
Function TSalesLineBase.GetTotalUOM_WeightBO:Double     ; begin result := GetFloatField('TotalUOM_WeightBO');end;
Function TSalesLineBase.GetTotalUOM_LengthSold:Double   ; begin result := GetFloatField('TotalUOM_LengthSold');end;
Function TSalesLineBase.GetTotalUOM_LengthShipped:Double; begin result := GetFloatField('TotalUOM_LengthShipped');end;
Function TSalesLineBase.GetTotalUOM_LengthBO:Double     ; begin result := GetFloatField('TotalUOM_LengthBO');end;
Function TSalesLineBase.GetOriginalQtyOrdered:Double     ; begin result := GetFloatField('OriginalQtyOrdered');end;
Function TSalesLineBase.GetUOM_Volume:Double            ; begin result := GetFloatField('UOM_Volume');end;
Procedure TSalesLineBase.SetUOM_Height(Const Value :Double)             ;begin setfloatfield('UOM_Height' , value);end;
Procedure TSalesLineBase.SetUOM_Width(Const Value :Double)              ;begin setfloatfield('UOM_Width' , value);end;
Procedure TSalesLineBase.SetUOM_Length(Const Value :Double)             ;begin setfloatfield('UOM_Length' , value);end;
Procedure TSalesLineBase.SetUOM_Weight(Const Value :Double)             ;begin setfloatfield('UOM_Weight' , value);end;
Procedure TSalesLineBase.SetTotalUOM_WeightSold(Const Value :Double)    ;begin setfloatfield('TotalUOM_WeightSold' , value);end;
Procedure TSalesLineBase.SetTotalUOM_WeightShipped(Const Value :Double) ;begin setfloatfield('TotalUOM_WeightShipped' , value);end;
Procedure TSalesLineBase.SetTotalUOM_WeightBO(Const Value :Double)      ;begin setfloatfield('TotalUOM_WeightBO' , value);end;
Procedure TSalesLineBase.SetTotalUOM_LengthSold(Const Value :Double)    ;begin setfloatfield('TotalUOM_LengthSold' , value);end;
Procedure TSalesLineBase.SetTotalUOM_LengthShipped(Const Value :Double) ;begin setfloatfield('TotalUOM_LengthShipped' , value);end;
Procedure TSalesLineBase.SetTotalUOM_LengthBO(Const Value :Double)      ;begin setfloatfield('TotalUOM_LengthBO' , value);end;
Procedure TSalesLineBase.SetOriginalQtyOrdered(Const Value :Double)      ;begin setfloatfield('OriginalQtyOrdered' , value);end;
Procedure TSalesLineBase.SetUOM_Volume(Const Value :Double)             ;begin setfloatfield('UOM_Volume' , value);end;

procedure TSalesBase.SaveToXMLNode(const node: IXMLNode);
begin
  if not SavingXMLTofile then begin
    AddXMLNode(node, 'GLAccountId', GLaccountID);
    AddXMLNode(node, 'ClientID', ClientID);
    AddXMLNode(node, 'EmployeeId', EmployeeId);
    AddXMLNode(node, 'CustomerID', CustomerID);
    AddXMLNode(node, 'SaleClassId', SaleClassId);
//    AddXMLNode(node, 'Runid', Runid);
  end;
  { transaction records have the Id in the xml to handle the import(Edit) }
  AddXMLNode(node, 'DocNumber', DocNumber);
  AddXMLNode(node, 'GLaccountName', GLaccountName);
  AddXMLNode(node, 'TotalBalance', TotalBalance);
  AddXMLNode(node, 'BaseNo', BaseNo);
  AddXMLNode(node, 'BackOrderGlobalRef', BackOrderGlobalRef);
  AddXMLNode(node, 'Deleted', Deleted);
  AddXMLNode(node, 'DueDate', DueDate);
  AddXMLNode(node, 'EmployeeName', EmployeeName);
  AddXMLNode(node, 'EnteredAt', EnteredAt);
  AddXMLNode(node, 'ForeignBalanceAmount', ForeignBalanceAmount);
  AddXMLNode(node, 'ForeignExchangeCode', ForeignExchangeCode);
  AddXMLNode(node, 'ForeignExchangeRate', ForeignExchangeRate);
  AddXMLNode(node, 'ForeignPaidAmount', ForeignPaidAmount);
  AddXMLNode(node, 'ForeignTotalAmount', ForeignTotalAmount);
  AddXMLNode(node, 'OriginalDocNumber', OriginalDocNumber);
  AddXMLNode(node, 'IsPaid', IsPaid);
  AddXMLNode(node, 'TotalPaid', TotalPaid);
  AddXMLNode(node, 'TermsName', TermsName);
  AddXMLNode(node, 'TotalAmount', TotalAmount);
  AddXMLNode(node, 'TotalAmountInc', TotalAmountInc);
  AddXMLNode(node, 'TotalTax', TotalTax);
  AddXMLNode(node, 'Enteredby', Enteredby);
  // AddXMLNode(node , 'SaleID'              ,SaleId);
  AddXMLNode(node, 'CustomerName', CustomerName);
  AddXMLNode(node, 'InvoiceToDesc', InvoiceToDesc);
  AddXMLNode(node, 'ShipToDesc', ShipToDesc);

  AddXMLNode(node, 'InvoiceStreet1', InvoiceStreet1);
  AddXMLNode(node, 'InvoiceStreet2', InvoiceStreet2);
  AddXMLNode(node, 'InvoiceStreet3', InvoiceStreet3);
  AddXMLNode(node, 'InvoiceSuburb', InvoiceSuburb);
  AddXMLNode(node, 'InvoiceState', InvoiceState);
  AddXMLNode(node, 'InvoiceCountry', InvoiceCountry);
  AddXMLNode(node, 'InvoicePostcode', InvoicePostcode);

  AddXMLNode(node, 'ShipStreet1', ShipStreet1);
  AddXMLNode(node, 'ShipStreet2', ShipStreet2);
  AddXMLNode(node, 'ShipStreet3', ShipStreet3);
  AddXMLNode(node, 'ShipSuburb', ShipSuburb);
  AddXMLNode(node, 'ShipState', ShipState);
  AddXMLNode(node, 'ShipCountry', ShipCountry);
  AddXMLNode(node, 'ShipPostcode', ShipPostcode);

  AddXMLNode(node, 'Shipping', Shipping);
  AddXMLNode(node, 'PickupFromDesc', PickupFromDesc);
  AddXMLNode(node, 'PickupFromClientName', PickupFromClientName);
  AddXMLNode(node, 'SaleDate', SaleDate);
  AddXMLNode(node, 'TotalWETTax', TotalWETTax);
  AddXMLNode(node, 'TotalWEGTax', TotalWEGTax);
  AddXMLNode(node, 'TotalMarkup', TotalMarkup);
  AddXMLNode(node, 'TotalDiscount', TotalDiscount);
  // AddXMLNode(node , 'TotalCost'           ,TotalCost);
  AddXMLNode(node, 'TotalQuoteAmount', TotalQuoteAmount);
  AddXMLNode(node, 'SaleClassName', SaleClassName);
  AddXMLNode(node, 'OrderNumber', OrderNumber);
  AddXMLNode(node, 'ChequeNumber', ChequeNumber);
  AddXMLNode(node, 'ConNote', ConNote);
  AddXMLNode(node, 'AutoSmartOrderRef', AutoSmartOrderRef);
  AddXMLNode(node, 'Memo', Memo);
  AddXMLNode(node, 'PickMemo', PickMemo);
  AddXMLNode(node, 'PayMethod', PayMethod);
  AddXMLNode(node, 'SalesOrderGlobalRef', SalesOrderGlobalRef);
  AddXMLNode(node, 'QuoteGlobalRef', QuoteGlobalRef);
  AddXMLNode(node, 'ShipDate', ShipDate);
  AddXMLNode(node, 'UseWholesalePrice', UseWholesalePrice);
  AddXMLNode(node, 'HoldSale', HoldSale);
  AddXMLNode(node, 'CustPONumber', CustPONumber);
  AddXMLNode(node, 'Invoiceprintdesc', Invoiceprintdesc);
  AddXMLNode(node, 'Printhold', Printhold);
  AddXMLNode(node, 'Payduedate', Payduedate);
  AddXMLNode(node, 'Applyflag', Applyflag);
  //AddXMLNode(node, 'Amountdue', Amountdue);
  AddXMLNode(node, 'Timeofsale', Timeofsale);
  AddXMLNode(node, 'Pos', EOP_POS);
//  AddXMLNode(node, 'Laybyid', LaybyId);
  AddXMLNode(node, 'Deposited', Deposited);
  AddXMLNode(node, 'Tillid', Tillid);
  AddXMLNode(node, 'Commissionpaid', Commissionpaid);
  AddXMLNode(node, 'Ismanifest', Ismanifest);
  AddXMLNode(node, 'Usedonmanifest', Usedonmanifest);
  AddXMLNode(node, 'Addtomanifest', Addtomanifest);
  AddXMLNode(node, 'Repairglobalref', RepairGlobalref);
  AddXMLNode(node, 'Isbarcodepicking', Isbarcodepicking);
  AddXMLNode(node, 'Barcodepickingdone', Barcodepickingdone);
  AddXMLNode(node, 'Arnotes', Arnotes);
//  AddXMLNode(node, 'Despatchid', Despatchid);
//  AddXMLNode(node, 'Runname', Runname);
//  AddXMLNode(node, 'ISManTrans', ISManTrans);
  AddXMLNode(node, 'Isgeneratedfromhire', Isgeneratedfromhire);
  AddXMLNode(node, 'Blindbalanceperiodid', Blindbalanceperiodid);
  AddXMLNode(node, 'SaleDateTime', Saledatetime);

  AddXMLNode(node, 'IsInvoice', IsInvoice);
  AddXMLNode(node, 'IsCashSale', IsCashSale);
  AddXMLNode(node, 'IsRefund', IsRefund);
  AddXMLNode(node, 'IsSalesOrder', IsSalesOrder);
  AddXMLNode(node, 'IsLaybyPayment', IsLaybyPayment);
  AddXMLNode(node, 'IsCustomerreturn', IsCustomerreturn);
  AddXMLNode(node, 'IsLaybyTOS', IsLaybyTOS);
  AddXMLNode(node, 'IsVoucher', IsVoucher);
  AddXMLNode(node, 'IsLayby', IsLayby);
  AddXMLNode(node, 'IsQuote', IsQuote);
  AddXMLNode(node, 'IsPOS', IsPos);

  AddXMLNode(node, 'ShippingCost', ShippingCost);
  AddXMLNode(node, 'pospostcode', POSPostCode);
  AddXMLNode(node, 'Area', Area);
  AddXMLNode(node, 'MedtypeID', MedtypeId);
  AddXMLNode(node, 'NoOfBoxes', NoOfBoxes);
  AddXMLNode(node, 'Medtype', Medtype);
  AddXMLNode(node, 'ContributionAmount', ContributionAmount);
  AddXMLNode(node, 'ShipToID', ShipToID);
  AddXMLNode(node , 'SalesStatus', SalesStatus);
  AddXMLNode(node , 'HireGlobalref', HireGlobalref);
  AddXMLNode(node, 'SaleCustField1', SaleCustField1);
  AddXMLNode(node, 'SaleCustField2', SaleCustField2);
  AddXMLNode(node, 'SaleCustField3', SaleCustField3);
  AddXMLNode(node, 'SaleCustField4', SaleCustField4);
  AddXMLNode(node, 'SaleCustField5', SaleCustField5);
  AddXMLNode(node, 'SaleCustField6', SaleCustField6);
  AddXMLNode(node, 'SaleCustField7', SaleCustField7);
  AddXMLNode(node, 'SaleCustField8', SaleCustField8);
  AddXMLNode(node, 'SaleCustField9', SaleCustField9);
  AddXMLNode(node, 'SaleCustField10', SaleCustField10);


  inherited;
end;

procedure TSalesBase.AddStateFreight;
var
  FreightProdName: string;
  FreightValueInc: double;
  FreightDesc: string;
  FreightLineFound: boolean;
  qry: TERPQuery;
  FreightState: string;
begin
  if not AppEnv.CompanyPrefs.StateFreightChargeEnabled then exit;
  if AccessManager.AccessLevel > 2 then exit;

  FreightProdName := AppEnv.CompanyPrefs.FreightChargeProduct;
  if FreightProdName = '' then exit;
  FreightLineFound := false;
  Lines.Dataset.DisableControls;
  try
    if Lines.Locate('ProductName;Deleted', VarArrayOf([FreightProdName,'F']),[loCaseInsensitive]) then begin
      FreightLineFound := true;
    end;
  finally
    Lines.Dataset.EnableControls;
  end;
  if not FreightLineFound then begin
    Lines.Last;
    Lines.New;
    Lines.ProductName := FreightProdName;
    Lines.UOMQtySold := 1;
    Lines.UOMQtyShipped := 1;
    Lines.TotalLineAmountInc := 0;
  end;
  qry := DbSharedObj.GetQuery(Connection.Connection);
  try
    if self.ShipToID > 0 then begin
      qry.SQL.Add('select ShipState as State from tblshippingaddress');
      qry.SQL.Add('where ShipAddressID = ' + IntToStr(self.ShipToID));
    end
    else begin
      qry.SQL.Add('select State as State from tblclients');
      qry.SQL.Add('where ClientID = ' + IntToStr(self.ClientId));
    end;
    qry.Open;
    FreightState := qry.FieldByName('State').AsString;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
  if TStateFreight.FreightForState(FreightState,TotalAmountInc - Lines.TotalLineAmountInc,FreightValueInc,FreightDesc,Connection.Connection) then begin
    Lines.ProductDescription := FreightDesc;
    Lines.TotalLineAmountInc := FreightValueInc;
    self.CalcOrderTotals;
  end;


end;

procedure TSalesBase.AfterCopy;
begin
end;

procedure TSalesBase.CalcOrderTotals;
begin
  if DisableCalcOrderTotals then Exit;
  if DoingCalcOrderTotals then Exit;
//  self.Progresscount := self.Lines.Count;
//  Progressbarmsg:= 'Calculating Totals';
  self.showProgressbar(Lines.Count,'Calculating Totals');
//  SendEvent(BusobjEvent_ToDo,BusobjEvent_ShowProgressbar, self.Lines);


  DoingCalcOrderTotals := True;
  try
    fWETTaxRate := tcDataUtils.GetTaxRateForCode('WET');
    fWEGTaxRate := tcDataUtils.GetTaxRateForCode('WEG');

    fTotMarkup := 0;
    fTotDiscount := 0;
    fTotWETTax := 0;
    fTotWEGTax := 0;
    fTotTax := 0;
    fTotalAmountInc := 0;
    fTotalAmount := 0;
    fTotalCost := 0;
    fTotalOrdered := 0;
    fTotalShipped := 0;
    fTotalshippedUOMWeight:=0;
    fTotalshippedUOMLength:=0;
    fForeignTotalAmount := 0;

    fAttrib1Sale := 0;
    fAttrib2Sale := 0;
    fAttrib1SaleRate := 0;
    fAttrib1SaleEst := 0;
    fAttrib2SaleEst := 0;
    TmpTotalEstimatedAmountInc := 0;

    // Iterate through all records and total
    Lines.IterateREcords(CalcTotalsCallback, true);

    TotalMarkup := Round(fTotMarkup, CurrencyRoundPlaces);
    TotalDiscount := Round(fTotDiscount, CurrencyRoundPlaces);
    TotalWETTax := Round(fTotWETTax, CurrencyRoundPlaces);
    TotalWEGTax := Round(fTotWEGTax, CurrencyRoundPlaces);

    TotalAmount := Round(fTotalAmount, CurrencyRoundPlaces);
    TotalAmountInc := Round(fTotalAmountInc, CurrencyRoundPlaces);
    fTotTax := TotalAmountInc - TotalAmount;
    TotalTax := Round(fTotTax, CurrencyRoundPlaces);
    ForeignTotalAmount := Round(fForeignTotalAmount, CurrencyRoundPlaces);

    (*Lines.postdb;
    TransLinetotals.closedb;
    With TSalesLinetotals(TransLinetotals) do begin
      Self.TotalMarkup          := Round(fTotMarkup, CurrencyRoundPlaces);
      Self.TotalDiscount        := Round(fTotDiscount, CurrencyRoundPlaces);
      Self.TotalWETTax          := Round(fTotWETTax, CurrencyRoundPlaces);
      Self.TotalWEGTax          := Round(fTotWEGTax, CurrencyRoundPlaces);

      Self.TotalAmount          := Round(fTotalAmount, CurrencyRoundPlaces);
      Self.TotalAmountInc       := Round(fTotalAmountInc, CurrencyRoundPlaces);
      Self.fTotTax              := TotalAmountInc - TotalAmount;
      Self.TotalTax             := Round(fTotTax, CurrencyRoundPlaces);
      Self.ForeignTotalAmount   := Round(fForeignTotalAmount, CurrencyRoundPlaces);
      TmpTotalEstimatedAmountInc:= EstimatedAmountInc;
      fTotTax                   := LineTax;
      fTotalAmount              := TotalLineAmount;
      fTotalAmountInc           := TotalLineAmountInc;
      fTotalCost                := TotalCost;
      fTotalOrdered             := QtySold;
      fTotalShipped             := Shipped;
      fTotalshippedUOMWeight    := UOM_WeightShipped;
      fTotalshippedUOMLength    := UOM_LengthShipped;
      fForeignTotalAmount       := ForeignTotalLinePrice;
      fTotWETTax                := WETTax;
      fTotWEGTax                := WEGTax;
      fAttrib1Sale              := Attrib1Sale;
      fAttrib2Sale              := Attrib2Sale;
      fAttrib1SaleRate          := Attrib1SaleRate;
      fAttrib1SaleEst           := Attrib1SaleEst;
      fAttrib2SaleEst           := Attrib2SaleEst;
      fTotMarkup                := Markup;
      fTotDiscount              := DiscountsAmt;
      fTotDiscount              := DiscountPercent;

      Self.TotalMarkup := Round(fTotMarkup, CurrencyRoundPlaces);
      Self.TotalDiscount := Round(fTotDiscount, CurrencyRoundPlaces);
      Self.TotalWETTax := Round(fTotWETTax, CurrencyRoundPlaces);
      Self.TotalWEGTax := Round(fTotWEGTax, CurrencyRoundPlaces);

      Self.TotalAmount := Round(fTotalAmount, CurrencyRoundPlaces);
      Self.TotalAmountInc := Round(fTotalAmountInc, CurrencyRoundPlaces);
      Self.fTotTax := TotalAmountInc - TotalAmount;
      Self.TotalTax := Round(fTotTax, CurrencyRoundPlaces);
      Self.ForeignTotalAmount := Round(fForeignTotalAmount, CurrencyRoundPlaces);
    end;*)

    if (TotalPaid <> 0.00) then begin
      TotalBalance := TotalAmountInc - TotalPaid;
      ForeignBalanceAmount := ForeignTotalAmount - ForeignPaidAmount;
    end else begin
      TotalBalance := TotalAmountInc;
      ForeignBalanceAmount := ForeignTotalAmount;
    end;
    if customerId <> 0 then postdb;
  finally DoingCalcOrderTotals := False;
  end;
  SendEvent(BusobjEvent_ToDo, BusobjEvent_HideProgressbar, self.Lines);
  SendEvent(BusObjEvent_Change, BusObjEvent_OnCalcOrderTotals, Self);
end;

procedure TSalesBase.updateUninvoicedSObalance(IsInternalOrder: Boolean);
begin
  PostList.clear;

  PostList.AddAmount(Customer.ClassName, Customer.BusObjectTableName, CustomerID, -TotalAmountInc, btSO);

  if (not IsInternalOrder) and AppEnv.CompanyPrefs.IncludeUnInvoicedSOtoGL then begin
    if AppEnv.CompanyPrefs.UnInvoicedSOType = 0 then begin // Income
      PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, // From UnInvoicedSO
        tcDataUtils.GetAccountID('UnInvoiced SO'), TotalAmountInc);
      PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, // To Preferred Account
        AppEnv.CompanyPrefs.UnInvoicedSOAccount, -TotalAmountInc);
    end;
    if AppEnv.CompanyPrefs.UnInvoicedSOType = 1 then begin // Cost
      PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, // From UnInvoicedSO
        tcDataUtils.GetAccountID('UnInvoiced SO'), TotalCost);
      PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, // To Preferred Account
        AppEnv.CompanyPrefs.UnInvoicedSOAccount, -TotalCost);
    end;
  end;
  PostList.Execute;
end;

procedure TSalesBase.InitToNoTax;
begin
  Lines.iteraterecords(InitToNoTaxcallback);
end;
procedure TSalesBase.InitToNoTaxcallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is TSalesLineBase then begin
      TSalesLineBase(Sender).linetaxcode := appenv.regionaloptions.TaxCodeNoTax;
      TSalesLineBase(Sender).LineTaxRate := 0;
      TSalesLineBase(Sender).CalcLineTotals;
      TSalesLineBase(Sender).Postdb;
  end;
end;
function TSalesBase.IsBOInvoiced: Boolean;
var
  strSQL: string;
begin
  strSQL := ' SELECT Sum(SL.Shipped) as ShippedSum ' + ' FROM tblSalesLines SL, tblSales S' + ' WHERE SL.SaleID = S.SaleID  ' + ' AND S.GlobalRef = ' + QuotedStr(BackOrderGlobalRef);
  with GetNewDataset(strSQL) do
    try Result := FieldByname('ShippedSum').asFloat <> 0;
    finally
      if Active then close;
      Free;
    end;

end;

procedure TSalesBase.DeleteAllTaxLines;
begin
  Lines.iteraterecords(DeleteAllTaxLinesCallback);
end;
procedure TSalesBase.DeleteAllTaxLinesCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is TSalesLineBase then
  TSalesLineBase(Sender).SalesTaxCode.Lines.DEleteall;
end;
function TSalesBase.DeleteFlaggedLines: Boolean;
begin
  Result := inherited DeleteFlaggedLines;
end;
procedure TSalesBase.CalcTotalsCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if TSalesLineBase(Sender).Deleted then Exit;  { deleted records amount should not be added into total }
  inherited;
  if TSalesLineBase(Sender).SalesTaxCode.HasThresholdAmount and AppEnv.CompanyPrefs.SalesTaxThresholdWholeOrder then
    TSalesLineBase(Sender).CalcLineTotals;
  TmpTotalEstimatedAmountInc := TmpTotalEstimatedAmountInc + (TSalesLineBase(Sender).QtySold * TSalesLineBase(Sender).LinePriceInc);
  fTotMarkup := fTotMarkup + TSalesLineBase(Sender).MarkupAmount;
  fTotDiscount := fTotDiscount + TSalesLineBase(Sender).DiscountAmount;

  if TSalesLineBase(Sender).DiscountPercent <> 0 then begin
    if TSalesLineBase(Sender).DiscountPercent = 100 then
      fTotDiscount := fTotDiscount + TSalesLineBase(Sender).TotalLineAmountInc
    else
      fTotDiscount := fTotDiscount + (TSalesLineBase(Sender).TotalLineAmountInc * (TSalesLineBase(Sender).DiscountPercent / (100 - TSalesLineBase(Sender).DiscountPercent)));
  end;
  fTotTax := fTotTax + TSalesLineBase(Sender).LineTaxTotal;
  fTotalAmountInc := fTotalAmountInc + TSalesLineBase(Sender).TotalLineAmountInc;
  fTotalAmount := fTotalAmount + TSalesLineBase(Sender).TotalLineAmount;

    fTotalCost := fTotalCost + GetAmountInc(TSalesLineBase(Sender).LineCost, TSalesLineBase(Sender).LineTaxRate) * TSalesLineBase(Sender).QtyShipped;

  if sametext(TSalesLineBase(Sender).Productname , PART_SOPROGRESSPAYMENT) or Sametext(TSalesLineBase(Sender).ProductName, PART_PROGRESSShipment) then
  else begin
    fTotalOrdered := fTotalOrdered + TSalesLineBase(Sender).QtySold;
    fTotalShipped := fTotalShipped + TSalesLineBase(Sender).QtyShipped;
    fTotalshippedUOMWeight:= fTotalshippedUOMWeight +TSalesLineBase(Sender).TotalUOM_WeightShipped;
    fTotalshippedUOMLength:= fTotalshippedUOMLength +TSalesLineBase(Sender).TotalUOM_LengthShipped;
  end;

  CalcForeignAmountCallback(Sender,Abort);

  if Sysutils.SameText(TSalesLineBase(Sender).LineTaxCode, 'WC') then begin
    fTotWETTax := fTotWETTax + Round((TSalesLineBase(Sender).QtyShipped * TSalesLineBase(Sender).LineCost) * fWETTaxRate, CurrencyRoundPlaces);

    fTotWEGTax := fTotWEGTax + Round((TSalesLineBase(Sender).QtyShipped * TSalesLineBase(Sender).LineCost) * fWEGTaxRate, CurrencyRoundPlaces);
  end;

  fAttrib1Sale := fAttrib1Sale + TSalesLineBase(Sender).Attrib1Sale;
  fAttrib2Sale := fAttrib2Sale + TSalesLineBase(Sender).Attrib2Sale;
  fAttrib1SaleRate := fAttrib1SaleRate + TSalesLineBase(Sender).Attrib1SaleRate;
  fAttrib1SaleEst := fAttrib1SaleEst + TSalesLineBase(Sender).Attrib1SaleEst;
  fAttrib2SaleEst := fAttrib2SaleEst + TSalesLineBase(Sender).Attrib2SaleEst;
  self.stepProgressbar();
end;


function TSalesLineBase.getconvertingSO: Boolean;
begin
  Result := False;
  if Assigned(Self.Owner) then
    if Self.Owner is TSalesBase then Result := TSalesBase(TSalesLineBase(Self).Owner).convertingSO;
end;

function TSalesLineBase.getConvertingRepairs: Boolean;
begin
  Result := False;
  if Assigned(Self.Owner) then
    if Self.Owner is TSalesBase then Result := TSalesBase(TSalesLineBase(Self).Owner).ConvertingRepairs;
end;
function TSalesLineBase.getConvertingHire: Boolean;
begin
  Result := False;
  if Assigned(Self.Owner) then
    if Self.Owner is TSalesBase then Result := TSalesBase(TSalesLineBase(Self).Owner).ConvertingHire;
end;

procedure TSalesLineBase.GetBaseLineCost;
begin
  if Product.AverageCost <> 0 then Self.LineCost := Product.AverageCost
  else Self.LineCost := Product.BuyQty1Cost;
  purchaseCost := Self.LineCost;
  StandardCost := Product.BuyQty1Cost;
  DoContainerEvent(Self, evSalesLineAfterGetBaseLineCost);
end;

function TSalesLineBase.getMemoLine: string;
begin
  Result := GetStringField('MemoLine');
end;

function TSalesLineBase.getSalesAutoSplitQty: TSalesAutoSplitQty;
begin
  Result := TSalesAutoSplitQty(getContainercomponent(TSalesAutoSplitQty, 'saleLineREf = ' + Quotedstr(globalref)));
end;

function TSalesLineBase.geTSalesLinesAutoSplitQty: TSalesLinesAutoSplitQty;
begin
  Result := TSalesLinesAutoSplitQty(getContainercomponent(TSalesLinesAutoSplitQty, 'saleLineREf = ' + Quotedstr(globalref)));
end;

function TSalesLineBase.getSalesLinesCustField1: string;
begin
  Result := GetStringField('SalesLinesCustField1');
end;

function TSalesLineBase.getSalesLinesCustField10: string;
begin
  Result := GetStringField('SalesLinesCustField10');
end;

function TSalesLineBase.getSalesLinesCustField2: string;
begin
  Result := GetStringField('SalesLinesCustField2');
end;

function TSalesLineBase.getSalesLinesCustField3: string;
begin
  Result := GetStringField('SalesLinesCustField3');
end;

function TSalesLineBase.getSalesLinesCustField4: string;
begin
  Result := GetStringField('SalesLinesCustField4');
end;

function TSalesLineBase.getSalesLinesCustField5: string;
begin
  Result := GetStringField('SalesLinesCustField5');
end;

function TSalesLineBase.getSalesLinesCustField6: string;
begin
  Result := GetStringField('SalesLinesCustField6');
end;

function TSalesLineBase.getSalesLinesCustField7: string;
begin
  Result := GetStringField('SalesLinesCustField7');
end;

function TSalesLineBase.getSalesLinesCustField8: string;
begin
  Result := GetStringField('SalesLinesCustField8');
end;

function TSalesLineBase.getSalesLinesCustField9: string;
begin
  Result := GetStringField('SalesLinesCustField9');
end;

function TSalesLineBase.GetOriginalTotalLineAmount: Double;
var
  fdOrigTotal: Double;
begin
  fdOrigTotal := 0;

  if SalesTaxBasedonProductPrice then
    fdOrigTotal := TotalLineAmount
  else
    fdOrigTotal := DivZer(TotalLineAmount + DiscountPercent - MarkupAmount, 1 - DiscountPercent / 100 + MarkupPercent / 100);
  
  Result := fdOrigTotal;
end;

function TSalesLineBase.GetOriginalTotalLineAmountInc: Double;
var
  fdOrigTotalInc: Double;
begin
  fdOrigTotalInc := 0;

  fdOrigTotalInc := LineTaxTotal + GetOriginalTotalLineAmount;

//  if SalesTaxBasedonProductPrice then
//    fdOrigTotalInc := TotalLineAmountInc
//  else
//    fdOrigTotalInc := DivZer(TotalLineAmount + DiscountPercent - MarkupAmount, 1 - DiscountPercent / 100 + MarkupPercent / 100);

  Result := fdOrigTotalInc;
end;

procedure TSalesLineBase.SetMemoLine(const Value: string);
begin
  SetStringField('MemoLine', Value);
end;

procedure TSalesLineBase.SetSalesLinesCustField1(const Value: string);
begin
  SetStringField('SalesLinesCustField1', Value);
end;

procedure TSalesLineBase.SetSalesLinesCustField10(const Value: string);
begin
  SetStringField('SalesLinesCustField10', Value);
end;

procedure TSalesLineBase.SetSalesLinesCustField2(const Value: string);
begin
  SetStringField('SalesLinesCustField2', Value);
end;

procedure TSalesLineBase.SetSalesLinesCustField3(const Value: string);
begin
  SetStringField('SalesLinesCustField3', Value);
end;

procedure TSalesLineBase.SetSalesLinesCustField4(const Value: string);
begin
  SetStringField('SalesLinesCustField4', Value);
end;

procedure TSalesLineBase.SetSalesLinesCustField5(const Value: string);
begin
  SetStringField('SalesLinesCustField5', Value);
end;

procedure TSalesLineBase.SetSalesLinesCustField6(const Value: string);
begin
  SetStringField('SalesLinesCustField6', Value);
end;

procedure TSalesLineBase.SetSalesLinesCustField7(const Value: string);
begin
  SetStringField('SalesLinesCustField7', Value);
end;

procedure TSalesLineBase.SetSalesLinesCustField8(const Value: string);
begin
  SetStringField('SalesLinesCustField8', Value);
end;

procedure TSalesLineBase.SetSalesLinesCustField9(const Value: string);
begin
  SetStringField('SalesLinesCustField9', Value);
end;

function TSalesLineBase.GetShipDate: TDatetime;
begin
  Result := getDatetimeField('ShipDate');
end;
function TSalesLineBase.GetETDDate: TDatetime;
begin
  Result := getDatetimeField('ETDDate');
end;

procedure TSalesLineBase.SetShipDate(const Value: TDatetime);
begin
  SetDatetimeField('ShipDate', Value);
end;
procedure TSalesLineBase.SetETDDate(const Value: TDatetime);
begin
  SetDatetimeField('ETDDate', Value);
end;

class function TSalesLineBase.GetBusObjectTablename: string;
begin
  Result := 'tblSalesLines';
end;

class function TSalesLineBase.GetIDField: string;
begin
  Result := 'SaleLineId';
end;

function TSalesLineBase.GetInStockUOMQty: double;
begin
  result := 0;
  if not AppEnv.CompanyPrefs.ShowSaleLineInStockQty then exit;

  if not Vars.Values.ByName['InStockQtyLoaded'].AsBoolean then
    LoadInStockQty;
  result := Vars.Values.ByName['InStockUOMQty'].AsFloat;
end;

function TSalesBase.GetSalesStatus: string;
begin
  Result:= GetStringField('QuoteStatus');
end;
function TSalesBase.GetHireGlobalref: string;
begin
  Result:= GetStringField('HireGlobalref');
end;

class function TSalesBase.GetSaleType(const aSaleId: Integer; Conn: TCustomMyConnection = nil): TSaleType;
var
  qry: TERPQuery;
  function connforQry :TCustomMyConnection;
  begin
    if Assigned(Conn) then result := Conn
    else result:= CommonDbLib.GetSharedMyDacConnection;
  end;
begin
  Result := stNone;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(connforQry );
  try
    qry.SQL.add('select IsPos,IsRefund,IsCashSale,IsInvoice,IsQuote,IsSalesOrder,IsVoucher,IsLayBy,IsLaybyPayment,IsCustomerreturn');
    qry.SQL.add('from tblSales where SaleId = ' + inttostr(aSaleId));
    qry.Open;
    if qry.recordcount = 1 then begin
      if qry.FieldByname('IsInvoice').AsBoolean  then
        Result := stInvoice
      else if qry.FieldByname('IsPos').AsBoolean then begin
        if qry.FieldByname('IsLayBy').AsBoolean then
          Result := stPOSLayby
        else if qry.FieldByname('IsLayByPayment').AsBoolean   then
          Result := stPOSLaybyPayment
        else if qry.FieldByname('IsCustomerreturn').AsBoolean then
          Result := stCustomerReturn
        else if qry.FieldByname('IsCashSale').AsBoolean       then
          Result := stPOSCashsale
        else
          Result := stPos;
      end
      else if qry.FieldByname('IsCashSale').AsBoolean     then
        Result := stCashsale
      else if qry.FieldByname('IsSalesOrder').AsBoolean   then
        Result := stSalesOrder
      else if qry.FieldByname('IsQuote').AsBoolean        then
        Result := stQuote;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

class function TSalesBase.GetSaleTypeClassName(const aSaleId: Integer;
  Conn: TCustomMyConnection): string;
begin
  case GetSaleType(aSaleId, Conn) of
    stNone: result := 'Unknown';
    stInvoice: result := 'TInvoce';
    stCashsale: result := 'TCashSale';
    stSalesOrder: result := 'TSalesOrder';
    stPOS: result := 'TPOS';
    stPOSLayby: result := 'TPOSLayby';
    stPOSLaybyPayment: result := 'TPosLaybyPayment';
    stQuote: result := 'TQuote';
    stPOSCashSale: result := 'TPOSCashSale';
    stCustomerReturn: result := 'TCustomerReturn';
    else result := 'Unknown';
  end;
end;

class function TSalesBase.SaleTypeAndId(const aGlobalref: string; var aSaleId: Integer; Conn: TCustomMyConnection): TSaleType;
var
  qry: TERPQuery;
  function connforQry :TCustomMyConnection;
  begin
    if Assigned(Conn) then result := Conn
    else result:= CommonDbLib.GetSharedMyDacConnection;
  end;

begin
  Result := stNone;
  aSaleId := 0;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(connforQry);
  try
    { first check for converted sales orders }
    qry.SQL.add('select distinct ifnull(BO.saleId,  s.SaleId) as saleId,');
    qry.SQL.add('s.IsPos,s.IsRefund,s.IsCashSale,s.IsInvoice,s.IsQuote,s.IsSalesOrder,s.IsVoucher,s.IsLayBy');
    qry.SQL.add('from tblSales s ');
    qry.SQL.add('LEFT join tblSales bo on Bo.originalno = s.globalref');
    qry.SQL.add('Where s.SalesOrderGlobalRef =' + QuotedStr(aGlobalref));
    qry.SQL.add('order by SaleId desc');
    qry.Open;

    if qry.recordcount = 0 then begin
      qry.close;
      qry.SQL.clear;
      qry.SQL.add('select distinct ifnull(BO.saleId,  s.SaleId) as saleId,');
      qry.SQL.add('s.IsPos,s.IsRefund,s.IsCashSale,s.IsInvoice,s.IsQuote,s.IsSalesOrder,s.IsVoucher,s.IsLayBy,s.IsLaybyPayment,s.IsCustomerreturn');
      qry.SQL.add('from tblSales s ');
      qry.SQL.add('LEFT join tblSales bo on Bo.originalno = s.globalref');
      qry.SQL.add('Where s.Globalref =' + QuotedStr(aGlobalref));
      qry.SQL.add('order by SaleId desc');
      qry.Open;
    end;
    if qry.recordcount >= 1 then begin
      aSaleId := qry.FieldByname('SaleId').asInteger;
      if qry.FieldByname('IsInvoice').AsBoolean  then
        Result := stInvoice
      else if qry.FieldByname('IsPos').AsBoolean then begin
        if qry.FieldByname('IsLayBy').AsBoolean          then
          Result := stPOSLayby
        else if qry.FieldByname('IsLayByPayment').AsBoolean   then
          Result := stPOSLaybyPayment
        else if qry.FieldByname('IsCustomerreturn').AsBoolean then
          Result := stCustomerReturn
        else if qry.FieldByname('IsCashSale').AsBoolean       then
          Result := stPOSCashSale
        else
          Result := stPos;
      end
      else if qry.FieldByname('IsCashSale').AsBoolean   then Result := stCashsale
      else if qry.FieldByname('IsSalesOrder').AsBoolean then Result := stSalesOrder
      else if qry.FieldByname('IsQuote').AsBoolean      then Result := stQuote;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

end;

class function TSalesBase.SaleTypeAndId(const aSaleLineId: Integer; var aSaleId: Integer; Conn: TCustomMyConnection): TSaleType;
var
  qry: TERPQuery;
  function connforQry :TCustomMyConnection;
  begin
    if Assigned(Conn) then result := Conn
    else result:= CommonDbLib.GetSharedMyDacConnection;
  end;
begin
  Result := stNone;
  aSaleId := 0;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(connforQry);
  try
    qry.SQL.add('select distinct ifnull(BO.saleId,  s.SaleId) as saleId,');
    qry.SQL.add('s.IsPos,s.IsRefund,s.IsCashSale,s.IsInvoice,s.IsQuote,s.IsSalesOrder,s.IsVoucher,s.IsLayBy,s.IsLaybyPayment,s.IsCustomerreturn');
    qry.SQL.add('from tblSales s inner  join tblSalesLines sl on sl.SaleId = s.SaleId and sl.SaleLineId = ' + inttostr(aSaleLineId));
    qry.SQL.add('inner join tblSales bo on Bo.originalno = s.globalref');
    qry.SQL.add('order by SAleId desc');
    qry.Open;
    if qry.recordcount >= 1 then begin
      aSaleId := qry.FieldByname('SaleId').asInteger;
      if qry.FieldByname('IsInvoice').AsBoolean  then Result := stInvoice
      else if qry.FieldByname('IsPos').AsBoolean      then begin
             if qry.FieldByname('IsLayBy').AsBoolean          then Result := stPOSLayby
        else if qry.FieldByname('IsLayByPayment').AsBoolean   then Result := stPOSLaybyPayment
        else if qry.FieldByname('IsCustomerreturn').AsBoolean then Result := stCustomerReturn
        else if qry.FieldByname('IsCashSale').AsBoolean       then result := stPOSCashSale
        else Result := stPos;
      end
      else if qry.FieldByname('IsCashSale').AsBoolean   then Result := stCashsale
      else if qry.FieldByname('IsSalesOrder').AsBoolean then Result := stSalesOrder
      else if qry.FieldByname('IsQuote').AsBoolean      then Result := stQuote;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function TSalesLineBase.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  if Assigned(Self.Owner) then
    if Self.Owner is TSalesBase then Self.ShipDate := TSalesBase(Owner).ShipDate;
  if appenv.CompanyPrefs.SalesDefaultValueForAreaFrom ='C' then
    AreaCode := CustomerAreaCode;
end;
function  TSalesLineBase.CustomerAreaCode:String;
begin
  Result:= '';
  if Assigned(Owner) then
    if owner is TSalesbase then
      result:= TSalesbase(Owner).Customer.Area;

end;
procedure TSalesBase.CheckLineShipDateCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if (TSalesLineBase(Sender).ShipDate > ShipDate) or (AppEnv.CompanyPrefs.MatchSaleLineShipDateToHeader
    and (not AppEnv.CompanyPrefs.CurrentDateforSalesshipment)) then
      TSalesLineBase(Sender).ShipDate := ShipDate;
end;

function TSalesLineBase.ExcludeFromclone: string;
begin
  Result := inherited ExcludeFromclone + ',' + QuotedStr('SaleId');
end;

function TSalesLineBase.ExportsubClasses(const node: IXMLNode): Boolean;
begin
  Result := inherited ExportsubClasses(node);
  if not Result then Exit;
  Progressbarmsg := 'Loading Sales Lines Points';
  SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);

  FESalesLines.XMLPropertyNode := node.AddChild(FESalesLines.XMLBranchName);
  FESalesLines.XMLPropertyName := XMLNodename + FESalesLines.XMLNodename;
  FESalesLines.IterateREcords(GetPropertyXMLCallback);

end;

procedure TSalesLineBase.FinaliseTree;
begin
end;

function TSalesBase.ValidateContributionAmount: Boolean;
begin
  Result := True;
  // if ContributionAmount <0 then ContributionAmount := 0;
  if ContributionAmount = 0 then Exit;
  // if ContributionAmount > TotalAmountinc then ContributionAmount := TotalAmountinc;
  if IsclientRelatedParent(ClientID) then begin
    ResultStatus.AddItem(True, rssWarning, 0, 'Customer of ' + XMLNodename + '#' + inttostr(ID) + '[' + CustomerName +
      '] is a Parent Client for Related Clients.  It is not Possible to Have a Contribution for Parent Customers', True);
    Result := False;
  end
  else if not(IsclientRelated(ClientID)) then begin
    Result := False;
  end;
end;
function TSalesBase.FirstPPGDate:TDateTime;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection.Connection);
  try
    Qry.SQL.Text := 'Select min(PPG.Progressdate) as Progressdate from ' +
                    ' tblsaleslines SL ' +
                    ' inner join tblProctree PT on SL.saleLineId = PT.masterID and PT.mastertype <> "mtProduct" ' +
                    ' inner join tblprocprogress PPG on PT.procTreeId= PPG.proctreeId ' +
                    ' where SL.saleid= ' + inttostr(ID);
    Qry.open;
    result := Qry.Fieldbyname('Progressdate').AsDateTime;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
procedure TSalesBase.DoFieldOnChange(Sender: TField);
var
  dt:TdateTime;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;

{---} if Sysutils.SameText(Sender.FieldName, 'Class') then begin
        SaleClassId := TDeptClass.IDToggle(SaleClassName, Connection.Connection);
        if not RawMode then begin
          Lines.IterateREcords(AppyUpdatesPQA);
        end;
{---} end  else if Sysutils.SameText(Sender.FieldName, 'SaleDate') then begin
        SendEvent(BusObjEvent_Change, BusObjEventVal_CreationDate, self);
        //if Saledatetime < SaleDate then begin
        if Dateof(Saledatetime) <> dateof(SaleDate) then begin
          Saledatetime := SaleDate+ TimeOf(AppEnv.CompanyPrefs.StartOfDay);
          if not RawMode then begin
            PostDB;
            DoFieldOnChange(Dataset.findfield('Saledatetime'));
          end;
        end;

{---} end  else if Sysutils.SameText(Sender.FieldName, 'Saledatetime') then begin
        if not RawMode then begin
          dt:= FirstPPGDate;
          if (dt>0) and (dt<Saledatetime) then begin
            ResultStatus.AddItem(True, rssWarning, 0, 'This Order is Already Started to Build on ' + FormatdateTime(FormatSettings.Shortdateformat  + ' HH:NN:SS AM/PM' , dt) +' and Sales Date Cannot be Less than the Build Date.'+NL+
                                                      'Setting the Date Back to  ' + FormatdateTime(FormatSettings.Shortdateformat  + ' HH:NN:SS AM/PM' , incSecond(dt, -1)) +'.'  , True);
            Saledatetime := incSecond(dt, -1);
          end;
          SaleDate := Trunc(SaleDateTime);
          Lines.IterateREcords(AppyUpdatesPQA);
        end;
{---} end  else if SameText(Sender.FieldName, 'ContributionAmount') then begin
        if not RawMode then begin
          if not ValidateContributionAmount then SendEvent(BusObjEvent_Change, BusObjEvent_ContributionAmountChanged, Self);
        end;
{---} end  else if SameText(Sender.FieldName, 'InvoiceTo') then begin
{---} end  else if SameText(Sender.FieldName, 'ShipTo') then begin
{---} end  else if SameText(Sender.FieldName, 'TillID') then begin
{---} end  else if SameText(Sender.FieldName, 'MedTypeID') then begin
        if Sender.AsInteger > 0 then
          MedType:= TSource.IDToggle(Sender.AsInteger, Connection.Connection)
        else
          MedType:= '';
{---} end else if SameText(Sender.FieldName, 'MedType') then begin
        if Sender.AsString <> '' then
          MedTypeID:= TSource.IDToggle(Sender.AsString, Connection.Connection)
        else
          MedTypeID:= 0;
{---} end else if Sysutils.SameText(Sender.fieldName, 'ClientID') then begin
{---} end else if Sysutils.SameText(Sender.fieldName, 'ShipToID') then begin
        if Shiptoid <> 0 then
          ShipToDesc := ShippingAddressObj.ShiptoForSales;
{---} end else if Sysutils.SameText(Sender.fieldName, 'PickupFrom') then begin
        SendEvent(BusObjEvent_Change, BusObjEvent_PickupFrom, Self);
{---} end;

end;


procedure TSalesLineBase.SetTransDate(const Value: TDatetime);
begin
  if Assigned(Self.Owner) then
    if Self.Owner is TSalesBase then TSalesBase(Self.Owner).Saledatetime := Value;
end;

class function TSalesBase.GetKeyStringField: string;
begin
  Result := 'GlobalRef';
end;

procedure TSalesBase.AppyUpdatesPQA(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TSalesLineBase) then Exit;
  TSalesLineBase(Sender).EditDB;
  TSalesLineBase(Sender).PostDB; // forces the PQA to Save
  TSalesLineBase(Sender).DoContainerEvent(Self, evSalesDateChange);
end;

procedure TSalesBase.ProcessDeletedLine;
var
  IsFiltered: Boolean;
begin
  inherited;
  Lines.FESalesLines.Lines.Dataset.DisableControls;
  IsFiltered := Lines.FESalesLines.Lines.Dataset.Filtered;
  Lines.FESalesLines.Lines.Dataset.Filtered := False;
  if Lines.FESalesLines.Lines.Count > 0 then begin
    Lines.FESalesLines.Lines.first;
    while not Lines.FESalesLines.Lines.Dataset.EOF do begin
      if (Lines.FESalesLines.Lines.Deleted) or (Lines.Deleted) then Lines.FESalesLines.Lines.delete
      else Lines.FESalesLines.Lines.Dataset.Next;
    end;
    Lines.FESalesLines.Lines.Dataset.Filtered := IsFiltered;
  end;
  Lines.FESalesLines.Lines.Dataset.EnableControls;

  if SalesLinesPoints.Locate('SaleLineID', Lines.ID, []) then SalesLinesPoints.delete;

  if Sysutils.SameText(Lines.ProductName, REDEEM_POINTS) then begin
    SalesRedeemPoints.deleteall;
  end;
end;

procedure TSalesBase.BOLinesInit(BackOrder: TTransBase);
begin
  inherited;
  TSalesBase(BackOrder).Lines.RelatedParentLineRef := Lines.Globalref;
  TSalesBase(BackOrder).Lines.LinePriceInc := Lines.LinePriceInc;
  TSalesBase(BackOrder).Lines.LineCostInc := Lines.LineCostInc;
  TSalesBase(BackOrder).Lines.OriginalLinePrice := Lines.OriginalLinePrice;

  if Lines.DiscountAmount <> 0 then TSalesBase(BackOrder).Lines.DiscountAmount := Lines.DiscountAmount;
  if Lines.DiscountPercent <> 0 then TSalesBase(BackOrder).Lines.DiscountPercent := Lines.DiscountPercent;
  if Lines.MarkupAmount <> 0 then TSalesBase(BackOrder).Lines.MarkupAmount := Lines.MarkupAmount;
  if Lines.MarkupPercent <> 0 then TSalesBase(BackOrder).Lines.MarkupPercent := Lines.MarkupPercent;
  if Lines.MarginAmount <> 0 then TSalesBase(BackOrder).Lines.MarginAmount := Lines.MarginAmount;
  if Lines.MarginPercent <> 0 then TSalesBase(BackOrder).Lines.MarginPercent := Lines.MarginPercent;

  if TSalesLineBase(BackOrder.Lines).BaseLineno = 0 then TSalesLineBase(BackOrder.Lines).BaseLineno := Lines.ID;
end;

procedure TSalesBase.NewBOInit(BackOrder: TTransBase);
begin
  inherited;
  TInvoice(BackOrder).invoicetodesc := invoicetodesc;
  TInvoice(BackOrder).shiptodesc := shiptodesc;
end;

procedure TSalesBase.BusObjCopy(const Sender: TBusObj; var Abort: Boolean);
begin
  inherited;
  if Sender is TSalesLineBase then TSalesLineBase(Sender).Copyallocation;
end;

function TSalesBase.getEmployee: TEmployeeDetails;
begin
  Result := TEmployeeDetails(getContainercomponent(TEmployeeDetails, 'EmployeeID = ' + inttostr(Self.EmployeeId), Self.SilentMode, False));
end;

function TSalesBase.getTotalProductcost: Double;
begin
  fTotalProductcost := 0;
  Lines.IterateREcords(CallbackTotalProductCost);
  Result := fTotalProductcost;
end;

function TSalesBase.getTotalProductcostinc: Double;
begin
  fTotalProductcost := 0;
  Lines.IterateREcords(CallbackTotalProductCostInc);
  Result := fTotalProductcost;
end;

function TSalesBase.getTotalProductTotalLandedCost: double;
begin
  fTotalProductTotalLandedCost := 0;
  Lines.IterateREcords(CallbackTotalProductTotalLandedCost);
  Result := fTotalProductTotalLandedCost;
end;

function TSalesBase.getTotalLandedCost: Double;
begin
  fTotalLandedCost := 0;
  Lines.IterateREcords(CallbackTotalLandedCost);
  Result := fTotalLandedCost;
end;

procedure TSalesBase.CallbackTotalProductCost(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TSalesLineBase) then Exit;
  if TSalesLineBase(Sender).QtyShipped = 0 then Exit;
  if TSalesLineBase(Sender).LineCost <> 0 then fTotalProductcost := fTotalProductcost + (TSalesLineBase(Sender).LineCost * TSalesLineBase(Sender).QtyShipped)
  else if TSalesLineBase(Sender).Product.AverageCost <> 0 then fTotalProductcost := fTotalProductcost + (TSalesLineBase(Sender).Product.AverageCost * TSalesLineBase(Sender).QtyShipped)
  else if TSalesLineBase(Sender).Product.Landedcost <> 0 then fTotalProductcost := fTotalProductcost + (TSalesLineBase(Sender).Product.Landedcost * TSalesLineBase(Sender).QtyShipped)
  else fTotalProductcost := fTotalProductcost + (TSalesLineBase(Sender).Product.BuyQty1Cost * TSalesLineBase(Sender).QtyShipped);
end;

procedure TSalesBase.CallbackTotalProductCostInc(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TSalesLineBase) then Exit;
  if TSalesLineBase(Sender).QtyShipped = 0 then Exit;
  if TSalesLineBase(Sender).LineCostInc <> 0 then fTotalProductcost := fTotalProductcost + (TSalesLineBase(Sender).LineCostInc * TSalesLineBase(Sender).QtyShipped)
  else if TSalesLineBase(Sender).Product.AvgCost <> 0 then fTotalProductcost := fTotalProductcost + (TSalesLineBase(Sender).Product.AvgCost * TSalesLineBase(Sender).QtyShipped)
  else fTotalProductcost := fTotalProductcost + (TSalesLineBase(Sender).Product.BuyQty1Cost * TSalesLineBase(Sender).QtyShipped);
end;

procedure TSalesBase.CallbackTotalProductTotalLandedCost(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not(Sender is TSalesLineBase) then
    Exit;
  if TSalesLineBase(Sender).QtyShipped = 0 then
    Exit;

  if TSalesLineBase(Sender).Product.Landedcost <> 0 then
    fTotalLandedCost := fTotalLandedCost +
      ((TSalesLineBase(Sender).Product.Landedcost + TSalesLineBase(Sender).Product.Latestcost) * TSalesLineBase(Sender).QtyShipped)
  else
    fTotalLandedCost := fTotalLandedCost +
    ((TSalesLineBase(Sender).Product.BuyQty1Cost+ TSalesLineBase(Sender).Product.Latestcost) * TSalesLineBase(Sender).QtyShipped);
end;

procedure TSalesBase.CallbackTotalLandedCost(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TSalesLineBase) then Exit;
  if TSalesLineBase(Sender).QtyShipped = 0 then Exit;

  if TSalesLineBase(Sender).Product.Landedcost <> 0 then fTotalLandedCost := fTotalLandedCost + (TSalesLineBase(Sender).Product.Landedcost * TSalesLineBase(Sender).QtyShipped)
  else fTotalLandedCost := fTotalLandedCost + (TSalesLineBase(Sender).Product.BuyQty1Cost * TSalesLineBase(Sender).QtyShipped);
end;

procedure TSalesBase.updateCustomerEquipQty(const Sender: TBusObj; var Abort: Boolean);
var
  SaveIsReadOnly: Boolean;

  function NewQty: Double;
  begin
    if ((TSalesLineBase(Sender).convertingSO) or (TSalesLineBase(Sender).convertingQuote)) then Result := Customer.CustomerEquipment.UOMqty
    else Result := Customer.CustomerEquipment.UOMqty + (TSalesLineBase(Sender).QtyShipped - TSalesLineBase(Sender).CleanQtyShipped);
    if not(TSalesLineBase(Sender).Product.SnTracking = False) then
        Result := Result - (( high(strutils.SplitString(TSalesLineBase(Sender).SoldSerials, ',')) + 1) - ( high(strutils.SplitString(TSalesLineBase(Sender).CleanSoldSerials, ',')) + 1));
  end;

begin
  SaveIsReadOnly := Customer.IsReadonly;
  Customer.IsReadonly := False;
  try
    if (Sender is TSalesLineBase) then begin
      if not(TSalesLineBase(Sender).Product.isEquipment) then Exit;
      if (TSalesLineBase(Sender).Product.SnTracking = False) and ((TSalesLineBase(Sender).convertingSO) or (TSalesLineBase(Sender).convertingQuote)) then Exit;
      if (TSalesLineBase(Sender).Product.SnTracking = False) or (Empty(TSalesLineBase(Sender).SoldSerials))  then begin
        if Customer.CustomerEquipment.LocateProduct(TSalesLineBase(Sender).ProductID, TSalesLineBase(Sender).ProductName, TSalesLineBase(Sender).UnitOfMeasure, True) then begin
          Customer.CustomerEquipment.UOMqty := NewQty;
          if Customer.CustomerEquipment.WarantyStartDate =0 then Customer.CustomerEquipment.WarantyStartDate := SaleDate;
          if (Customer.CustomerEquipment.WarantyStartDate <>0) and (Customer.CustomerEquipment.WarantyPeriod<> 0) then Customer.CustomerEquipment.WarantyFinishDate := IncMonth(Customer.CustomerEquipment.WarantyStartDate ,trunc(Customer.CustomerEquipment.WarantyPeriod));
          Customer.CustomerEquipment.PostDB;
        end;
      end;
      if TSalesLineBase(Sender).Product.SnTracking then
        if  (Sender is TSalesline) and  TSalesline(Sender).isTreeItem then
          TSalesLineBase(Sender).DoContainerEvent(Self, evupdateCustomerEquipQty)
        else TSalesLineBase(Sender).PQA.AllPQASN.IterateREcords(updateCustomerEquipQty);
    end
    else if Sender is TPQASN then begin
      if Customer.CustomerEquipment.LocateProduct(Lines.ProductID, Lines.ProductName, Lines.UnitOfMeasure, True, TPQASN(Sender).SerialNumber) then begin
        Customer.CustomerEquipment.UOMqty := 1;
        Customer.CustomerEquipment.PostDB;
      end;
    end;
  finally Customer.IsReadonly := SaveIsReadOnly;
  end;
end;

function TSalesLineBase.getCleanSoldSerials: string;
begin
  Result := GetXMLNodeStringValue(CleanXMLNOde, 'Soldserials');
end;

function TSalesLineBase.GetCleanUOMQtyShipped: Double;
begin
  Result := GetXMLNodeFloatValue(CleanXMLNOde, 'UOMQtyShipped');
end;

function TSalesBase.getMedtypeId: Integer;
begin
  Result := GetIntegerField('MedtypeId');
end;

function TSalesBase.getMedtype: string;
begin
  Result := GetStringField('Medtype');
end;

procedure TSalesBase.setMedtypeId(const Value: Integer);
begin
  SetIntegerField('MedtypeId', Value);
end;

procedure TSalesBase.setMedtype(const Value: string);
begin
  SetStringField('Medtype', Value);
end;

function TSalesLineBase.getProductcost: Double;
begin
  Result := LineCost;
  if Result = 0 then Result := Product.AverageCost;
  if Result = 0 then Result := Product.Landedcost;
  if Result = 0 then Result := Product.BuyQty1Cost;
end;

function TSalesLineBase.getProductcostInc: Double;
begin
  Result := LineCostInc;
  if Result = 0 then Result := Product.AverageCost;
  if Result = 0 then Result := Product.Landedcost;
  if Result = 0 then Result := Product.BuyQty1CostInc;

end;

function TSalesBase.RewardPoints: Boolean;
begin
  Result := True;
  if CustomerName = CLIENT_CASH then Exit;
  if (Self is TPOSSale) and (TPOSSale(Self).IsBarTab) then Exit;
  AllLinesValid := True;
  Lines.IterateREcords(RewardPointsCallBack);
  Result := AllLinesValid;

  SalesLinesPoints.IterateREcords(SalesLinesPointsBalanceCallbackProc, True);
  if not PostList.Execute then begin
    Result := False;
    Exit;
  end;
end;

class function TSalesBase.SaleClientId(const aSaleId: Integer; Conn: TCustomMyConnection): integer;
var
  qry: TERPQuery;
  function connforQry :TCustomMyConnection;
  begin
    if Assigned(Conn) then result := Conn
    else result:= CommonDbLib.GetSharedMyDacConnection;
  end;

begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(connforQry);
  try
    qry.SQL.Text := 'select ClientID from tblsales where SaleId = ' + IntToStr(aSaleId);
    qry.Open;
    result:= qry.FieldByName('ClientId').AsInteger;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
Class Function TSalesBase.SaleComponentClass(Const saleId:Integer):TComponentClass;
var
  Qry:TERPQuery;
begin
  Result := TSalesBase;
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    With Qry  do begin
      SQL.text := 'select S.IsPOS, S.IsRefund, S.IsCashSale, S.IsInvoice, S.IsQuote, S.IsSalesOrder, S.IsVoucher, S.IsLayby, S.IsLaybyTOS, S.IsLaybyPayment, S.IsCustomerReturn, s.POS from tblsales S where S.SaleID = ' + inttostr(saleID);
	  open;
           if Fieldbyname('IsRefund').asBoolean     then  Result := TRefundsale
      else if Fieldbyname('IsInvoice').asBoolean    then  Result := TInvoice
      else if Fieldbyname('IsQuote').asBoolean      then  Result := TQuote
      else if Fieldbyname('IsSalesOrder').asBoolean then  Result := TSalesOrder
      else if Fieldbyname('IsCashSale').asBoolean and Fieldbyname('IsPOS').asBoolean and Fieldbyname('POS').asBoolean        and Fieldbyname('IsVoucher').asBoolean       then result := TVoucherCashSale
      else if Fieldbyname('IsLayby').asBoolean    and Fieldbyname('IsPOS').asBoolean and Fieldbyname('IsLaybyTOS').asBoolean and not(Fieldbyname('IsCashSale').asBoolean) then result := TPOSLayby
      else if Fieldbyname('IsCashSale').asBoolean       then  Result := TCashSale
      else if Fieldbyname('IsCustomerReturn').asBoolean then result := TCustomerReturn
      else if Fieldbyname('IsPOS').asBoolean            then  Result := TPOSCashSale
      else exit;
    end;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;
class function TSalesBase.SaleObjInstance(Const saleId:Integer; conn : TMyDacDataConnection = nil; AOwner :Tcomponent = nil):TSalesBase;
var
  Qry:TERPQuery;
begin
  Result := nil;
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    With Qry  do begin
      SQL.text := 'select S.IsPOS, S.IsRefund, S.IsCashSale, S.IsInvoice, S.IsQuote, S.IsSalesOrder, S.IsVoucher, S.IsLayby, S.IsLaybyTOS, S.IsLaybyPayment, S.IsCustomerReturn, s.POS from tblsales S where S.SaleID = ' + inttostr(saleID);
      open;
           if Fieldbyname('IsRefund').asBoolean     then  Result := TRefundsale.Create(AOwner)
      else if Fieldbyname('IsInvoice').asBoolean    then  Result := TInvoice.Create(AOwner)
      else if Fieldbyname('IsQuote').asBoolean      then  Result := TQuote.Create(AOwner)
      else if Fieldbyname('IsSalesOrder').asBoolean then  Result := TSalesOrder.Create(AOwner)
      else if Fieldbyname('IsCashSale').asBoolean and Fieldbyname('IsPOS').asBoolean and Fieldbyname('POS').asBoolean        and Fieldbyname('IsVoucher').asBoolean       then result := TVoucherCashSale.Create(AOwner)
      else if Fieldbyname('IsLayby').asBoolean    and Fieldbyname('IsPOS').asBoolean and Fieldbyname('IsLaybyTOS').asBoolean and not(Fieldbyname('IsCashSale').asBoolean) then result := TPOSLayby.Create(AOwner)
      else if Fieldbyname('IsCashSale').asBoolean       then  Result := TCashSale.Create(AOwner)
      else if Fieldbyname('IsCustomerReturn').asBoolean then result := TCustomerReturn.Create(AOwner)
      else if Fieldbyname('IsPOS').asBoolean            then  Result := TPOSCashSale.Create(AOwner)
      else exit;

      if conn = nil then conn := TMyDAcDataconnection.Create(Result);
      Result.Connection := conn;
      Result.Load(SaleID);
    end;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;

procedure TSalesBase.SalesLinesPointsBalanceCallbackProc(const Sender: TBusObj; var Abort: Boolean);
var
  CleanNode: IXMLNode;
begin
  Show_Status('Update Accounts : ' + inttostr(Sender.Dataset.recno) + ' of ' + inttostr(Sender.Dataset.recordcount));
  CleanNode := Sender.CleanXMLNOde;
  if Assigned(CleanNode) then begin
    { Reverse old values }
    { Income }
    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, AppEnv.CompanyPrefs.RewardPointssoldAccount, 0 - GetXMLNodeFloatValue(CleanNode, 'ValueforRewardPoint') *
      GetXMLNodeFloatValue(CleanNode, 'linePoints'));

    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, AppEnv.CompanyPrefs.ExpenseAccountforRewardPoints, GetXMLNodeFloatValue(CleanNode, 'ValueforRewardPoint') *
      GetXMLNodeFloatValue(CleanNode, 'linePoints'));
  end;
  { New balances }
  if TInvoiceLine(Sender).Deleted = False then begin
    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, AppEnv.CompanyPrefs.RewardPointssoldAccount, TSalesLinesPoints(Sender).ValueforRewardPoint * TSalesLinesPoints(Sender)
      .linePoints);

    PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName, AppEnv.CompanyPrefs.ExpenseAccountforRewardPoints,
      0 - TSalesLinesPoints(Sender).ValueforRewardPoint * TSalesLinesPoints(Sender).linePoints);
  end;
end;

procedure TSalesBase.RewardPointsCallBack(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TSalesLineBase) then Exit;
  if (TSalesLineBase(Sender).Deleted) or (Sysutils.SameText(CustomerName, CLIENT_CASH)) then begin
    if SalesLinesPoints.Locate('SaleLineID', TSalesLineBase(Sender).ID, []) then begin
      SalesLinesPoints.Active := False;
      SalesLinesPoints.PostDB;
    end;
  end
  else
    with Lines.ProductRewardPoints do
      try
        if recordcount > 0 then begin
          if not(SalesLinesPoints.Locate('SaleLineID', TSalesLineBase(Sender).ID, [])) then SalesLinesPoints.New;

          SalesLinesPoints.SaleLineId := TSalesLineBase(Sender).ID;
          SalesLinesPoints.ClientID := ClientID;
          SalesLinesPoints.deptId := Self.SaleClassId;
          SalesLinesPoints.Deptname := Self.SaleClassName;
          SalesLinesPoints.ProductID := TSalesLineBase(Sender).ProductID;
          SalesLinesPoints.ProductName := TSalesLineBase(Sender).ProductName;
          SalesLinesPoints.LineValue := TSalesLineBase(Sender).TotalLineAmountInc;
          SalesLinesPoints.linePoints := Round(SalesLinesPoints.LineValue / FieldByname('Value').asFloat * FieldByname('Points').asFloat, AppEnv.CompanyPrefs.RoundUpPoints);
          SalesLinesPoints.ValueforRewardPoint := AppEnv.CompanyPrefs.ValueforRewardPoints;
          SalesLinesPoints.PointsUOMID := TSalesLineBase(Sender).UnitOfMeasureID;
          SalesLinesPoints.PointsUOMMultiplier := TSalesLineBase(Sender).UOMMultiplier;
          SalesLinesPoints.PointExpiresOn := FieldByname('RewardPointExpiresOn').asDateTime;
          SalesLinesPoints.ExpiresOnNoOfMonthsAfterPurchase := FieldByname('ExpiresOnNoOfMonthsAfterPurchase').asInteger;
          SalesLinesPoints.RewardPointID := FieldByname('ProductRewardPointsId').asInteger;
          SalesLinesPoints.PostDB;
        end;
      finally
        if Active then close;
        Free;
      end;
end;

function TSalesBase.getSalesLinesPoints: TSalesLinesPoints;
begin
  Result := TSalesLinesPoints(getContainercomponent(TSalesLinesPoints, 'SaleId = ' + inttostr(ID)));
end;

function TSalesLineBase.getSaleDate: TDatetime;
begin
  Result := 0;
  if Assigned(Self.Owner) then
    if Self.Owner is TSalesBase then Result := TSalesBase(Self.Owner).SaleDate;
end;

function TSalesLineBase.ProductChanged: Boolean;
begin
  result:= inherited ProductChanged;
  (*IsRelatedProduct := False;
  ParentProductID := 0;
  RelatedProductQty := 0;
  RelatedParentLineRef :='';*)
  PostDB;

end;

function TSalesLineBase.ProductRewardPoints: TDataset;
var
  SQLStr: string;
begin
  SQLStr := 'SELECT clientTypeid, ProductRewardPointsId ,Points ,value ,  RewardPointExpiresOn , ExpiresOnNoOfMonthsAfterPurchase' + ' FROM tblProductRewardPoints' + ' WHERE PartsId = ' +
    inttostr(ProductID) + ' AND Active    = "T"' + ' AND ( ifnull(ClientTypeID,0) = 0 or   ifnull(ClientTypeID,0) = ' + inttostr(ClientTypeID) + ')' + ' And ((USEUOM = "F") OR (UOMID = ' +
    inttostr(Self.UnitOfMeasureID) + ')) ' + ' AND ((UseDate = "F") OR (' + QuotedStr(FormatDateTime(MysqlDateFormat, SaleDate)) + ' BETWEEN DateFrom AND DateTo))' +
    ' ORDER BY DateFrom DESC , clientTypeid  DESC';
  Result := GetNewDataset(SQLStr);
end;


function TSalesLineBase.ProductUsescustomerTax: Boolean;
begin
  REsult:= False;
  if Assigned(Owner) then
    if Owner is TSalesBase then
      With GetNewDataset(' Select * from tblclienttaxexceptionproducts where ProductId = ' + inttostr(ProductID) + ' and clientID =' + inttostr(TSalesBase(Owner).CustomerID)+' and Active ="T"' , true) do try
        REsult:= REcordcount =0;
      finally
        if Active then close;
        Free;
      end;
end;
function TSalesLineBase.ProductUsesClassTax: Boolean;
begin
  REsult:= False;
  if Assigned(Owner) then
    if Owner is TSalesBase then
      With GetNewDataset(' Select * from tblDepttaxexceptionproducts where ProductId = ' + inttostr(ProductID) + ' and DeptID=' + inttostr(TSalesBase(Owner).SaleclassId)+' and Active ="T"' , true) do try
        REsult:= REcordcount =0;
      finally
        if Active then close;
        Free;
      end;
end;

function TSalesBase.ExportsubClasses(const node: IXMLNode): Boolean;
begin
  Result := inherited ExportsubClasses(node);
  if not Result then Exit;
  Progressbarmsg := 'Loading Sales Lines Points';
  SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);

  Self.SalesLinesPoints.XMLPropertyNode := node.AddChild(SalesLinesPoints.XMLBranchName);
  Self.SalesLinesPoints.XMLPropertyName := XMLNodename + 'LinePoints';
  Self.SalesLinesPoints.IterateREcords(GetPropertyXMLCallback);

  Progressbarmsg := 'Loading Redeem Points';
  SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);

  Self.SalesRedeemPoints.XMLPropertyNode := node.AddChild(SalesRedeemPoints.XMLBranchName);
  Self.SalesRedeemPoints.XMLPropertyName := XMLNodename + 'RedeemPoints';
  Self.SalesRedeemPoints.IterateREcords(GetPropertyXMLCallback);
  Result := True;
  Progressbarmsg := 'Loading ' + XMLNodename;
  SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
end;

function TSalesBase.getredeemedPoints: Double;
begin
  fdPoints := 0;
  SalesRedeemPoints.IterateREcords(CalcredeemedPoints);
  Result := fdPoints;
end;

procedure TSalesBase.CalcredeemedPoints(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TSalesRedeemPoints) then Exit;
  fdPoints := fdPoints + TSalesRedeemPoints(Sender).UsedPoints;
end;

function TSalesBase.getsalePoints: Double;
begin
  fdPoints := 0;
  SalesLinesPoints.IterateREcords(calcSalesPoints);
  Result := fdPoints;
end;

procedure TSalesBase.calcSalesPoints(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TSalesLinesPoints) then Exit;
  fdPoints := fdPoints + TSalesLinesPoints(Sender).linePoints;
end;

function TSalesLineBase.ClientTypeID: Integer;
begin
  Result := 0;
  if Assigned(Self.Owner) then
    if Self.Owner is TSalesBase then Result := TSalesBase(Self.Owner).Customer.ClientTypeID;
end;

function TSalesBase.GetIsInternalOrder: Boolean;
begin
  Result := GetBooleanField('IsInternalOrder');
end;

procedure TSalesBase.SetIsInternalOrder(const Value: Boolean);
begin
  SetBooleanField('IsInternalOrder', Value);
end;
Procedure TSalesBase.BeforeupdateBOLine(BackOrder:TTransBase);
begin
  if (backorder is TSalesBase) then
    TSalesBase(BackOrder).PartSourceToManufacture(Lines.isTreeItem);
end;

function TSalesBase.getPartsourceStock: Boolean;
begin
  if IsInternalOrder then begin
    Result := False;
  end
  else if Self is TInvoice then begin
    Result := True;
  end else begin
    if updatingbo then
      result := not(fbChangePartSourceToManufacture)
    else if fbChangePartSourceToManufacture then begin
      Result := False;
     end else if ((AppEnv.CompanyPrefs.ManufacturePartSourceStockConfirm = False) or (AppEnv.Employee.ManufacturePartSourceStockConfirm=False )) and (AppEnv.CompanyPrefs.ManufacturePartSourceStock) then begin
      Result := True;
      SendEvent(BusObjEvent_Change, BusObjEvent_TreePartSourcefromstockforSales, Self);
    end else begin
      Result :=  ((AppEnv.CompanyPrefs.ManufacturePartSourceStockConfirm) and (AppEnv.Employee.ManufacturePartSourceStockConfirm )) and  (not(IsInternalOrder)) and (not(fbChangePartSourceToManufacture));
      if Result then begin
        fbUserConfirmedPartsourceStock := True;
        SendEvent(BusObjEvent_Change, BusObjEvent_ReadTreePartSourceforSales, Self);
        Result := fbUserConfirmedPartsourceStock;
      end;
    end;
  end;

end;

procedure TSalesBase.ChangePartSourceToManufacture(const fisalesLineId: Integer);
begin
  fbChangePartSourceToManufacture := True;
  ChangePartSourcesalesLineId := fisalesLineId;
  Lines.IterateREcords(ChangePartSourceToManufacturecallback);
end;

procedure TSalesBase.ChangePartSourceToManufacturecallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TSalesLineBase) then Exit;
  if ChangePartSourcesalesLineId <> TSalesLineBase(Sender).ID then Exit;

  if Assigned(TSalesLineBase(Sender).Container) then TSalesLineBase(Sender).DoContainerEvent(TSalesLineBase(Sender), (* evSalesLinePartsourceChange *)evSalesBuildWhole);
  PostDB;
end;

function TSalesBase.getSalesRedeemPoints: TSalesRedeemPoints;
begin
  Result := TSalesRedeemPoints(getContainercomponent(TSalesRedeemPoints, 'SaleID = ' + inttostr(ID)));
end;

function TSalesBase.GetTransDate: TDateTime;
begin
  REsult := SaleDate;
end;

function TSalesBase.getTransLinetotals: TTransLinetotals;
begin
    Result := TTransLinetotals(getContainerComponent(TSalesLinetotals , 'SL.SaleId = ' + IntToStr(ID)));
end;

function TSalesBase.GetTransName: String;
begin
         if IsRefund          then Result := 'Refund'
    else if IsInvoice         then Result := 'Invoice'
    else if IsSalesOrder      then Result := 'Sales Order'
    else if IsLaybyPayment    then Result := 'Layby Payment'
    else if IsCustomerreturn  then Result := 'Customer Return'
    else if IsLaybyTOS        then Result := 'Layby Time of Sale'
    else if IsVoucher         then Result := 'Voucher'
    else if IsLayby           then Result := 'Layby'
    else if IsQuote           then Result := 'Quote'
    else if IsPOS             then Result := 'POS'
    else Result := 'Sale';
end;

function TSalesBase.GetTransStatus: String;
begin
  result:= SalesStatus;
end;

function TSalesLineBase.GetGrossProfitbasedLatestCostPercInc: Double;
begin
  if (QtySold <> 0) and ((LinePriceInc <> 0) or (LatestCostPriceInc <> 0)) then begin
    if LinePriceInc = 0 then begin
      Result := -100;
    end
    else if LatestCostPriceInc = 0 then begin
      Result := 100;
    end else begin
      Result := Round(DivZer(LinePriceInc - LatestCostPriceInc, LinePriceInc) * 100, CurrencyRoundPlaces);
    end;
  end else begin
    Result := 0;
  end;
end;

function TSalesLineBase.GetProfitbasedLatestCost: Double;
begin
  if QtySold <> 0 then Result := CommonLib.Round((LinePrice - LatestCostPrice) * QtySold, CurrencyRoundPlaces)
  else Result := 0;

end;

function TSalesLineBase.GetProfitbasedLatestCostInc: Double;
begin
  if QtySold <> 0 then Result := Round((LinePriceInc - LatestCostPriceInc) * QtySold, CurrencyRoundPlaces)
  else Result := 0;

end;

function TSalesLineBase.GetProfitbasedLatestCostPercent: Double;
begin
  if (QtySold <> 0) and ((LinePriceInc <> 0) or (LatestCostPriceInc <> 0)) then begin
    if LinePriceInc = 0 then Result := -100
    else if LatestCostPriceInc = 0 then Result := 100
    else Result := Round(DivZer((LinePrice - LatestCostPrice), LatestCostPrice) * 100, CurrencyRoundPlaces)
  end
  else Result := 0;

end;

function TSalesLineBase.GetProfitbasedLatestCostPercentInc: Double;
begin
  if (QtySold <> 0) and ((LinePriceInc <> 0) or (LatestCostPriceInc <> 0)) then begin
    if LinePriceInc = 0 then Result := -100
    else if LatestCostPriceInc = 0 then Result := 100
    else Result := Round(DivZer((LinePriceInc - LatestCostPriceInc), LatestCostPriceInc) * 100, CurrencyRoundPlaces)
  end
  else Result := 0;
end;

function TSalesLineBase.InternalQuantityChange: Boolean;
begin
  Result := False;
  if Assigned(Self.Owner) then
    if Self.Owner is TSalesBase then Result := TSalesBase(Self.Owner).InternalQuantityChange;
end;

function TSalesLineBase.isTreeItem: Boolean;
begin
  fbHasTree := False;
  if fbInstantiatingTree then begin
    fbHasTree := TRue;
    Exit;
  end;
  if Container.Count > 0 then DoContainerEvent(Self, evSalesLinecheckForTree);
  Result := fbHasTree;
end;

function TSalesLineBase.GetBOCleanQty: Double;
begin
  Result := GetXMLNodeFloatValue(CleanXMLNOde, 'QtyBackOrder');
end;

function TSalesLineBase.getBOMPrice: Double;
begin
  fdBOMPrice := 0;
  try
    if not hastree then exit;
    DoContainerEvent(Self, evSalesReadBOMPrice);
  finally
    result := fdBOMPrice;
  end;

end;

function TSalesBase.getNoOfBoxes: Integer;
begin
  Result := GetIntegerField('NoOfBoxes');
end;

function TSalesBase.getContributionAmount: Double;
begin
  Result := GetFloatField('ContributionAmount');
end;

procedure TSalesBase.setNoOfBoxes(const Value: Integer);
begin
  SetIntegerField('NoOfBoxes', Value);
end;

procedure TSalesBase.SetContributionAmount(const Value: Double);
begin
  SetFloatField('ContributionAmount', Value);
end;

function TSalesBase.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  NoOfBoxes := 0;
  ContributionAmount := 0;
  SalesStatus := TLeadStatusType.DefaultTypeName();
  InitARAccount;
end;

procedure TSalesBase.DoSalesLineProcTreeIDchange;
begin
  Progressbarmsg := 'Loading Salesline Tree';
  SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self.Lines);
end;

procedure TSalesBase.DoSalesLineProcTreeDestroy;
begin
  Progressbarmsg := 'Closing Salesline Tree';
  // SendEvent(BusobjEvent_ToDo,BusobjEvent_ProgressbarProgress, self);
end;


function TSalesLineBase.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not Result then Exit;
end;

function TSalesLineBase.DoCalcFields(Sender: TDatasetBusObj): Boolean;
begin
  CalcProductLatestCost;
  Result := True;
end;

procedure TSalesLineBase.DoBaseLinePricecalc;
begin
  GetBaseLinePrice;
end;

function TSalesLineBase.DoBeforeEdit(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeEdit(Sender);
  if not Result then Exit;
end;

function TSalesLineBase.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;

end;
Function TSalesBase.gettotalAmountclean :double; begin result := GetFloatField('totalAmountclean');End;
Procedure TSalesBase.SettotalAmountclean (const Value:double); begin SetFloatField('totalAmountclean' , value);end;
Function TSalesBase.gettotalAmountincclean :double; begin result := GetFloatField('totalAmountincclean');End;
Procedure TSalesBase.SettotalAmountincclean (const Value:double); begin SetFloatField('totalAmountincclean' , value);end;
Function TSalesBase.getTotalTaxclean :double; begin result := GetFloatField('TotalTaxclean');End;
Procedure TSalesBase.SetTotalTaxclean (const Value:double); begin SetFloatField('TotalTaxclean' , value);end;
Procedure TSalesBase.GetClientDetails;
begin
  inherited;
  if ClientId <> 0 then begin
     if AppEnv.CompanyPrefs.SalesDefaultAreaFromCustomer and (Area = '') then
      Area := Customer.Area;
  end;
end;
initialization

RegisterClassOnce(TSalesLineBase);

end.
