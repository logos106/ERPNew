unit BusobjProduct;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  20/01/15  1.00.00  A.  Initial Version.
  }


interface


uses
  ERPdbComponents,BusObjBase, DB, Classes, XMLDoc, XMLIntf,
  BusobjProductProperties , BusObjProductRewardPoints, busobjProductcommission,
  BusObjProductPicture, BusObjProductBarcode, busobjTaxCodes,
  BusObjProductClass, MyAccess ,
  BusObjCommon;


type
  TProductSimple = class(TMSBusObj)
  private
    fQtyQuery: TERPQuery;
    fRunningQtyQuery: TERPQuery;
    fsFormulaname:String;
    fQryValidateAllocation:TERPQuery;
    fbIgnoreBarcodeUpdate: Boolean;
    function GetPARTTYPE                               : string    ;
    function GetPRODUCTGROUP                           : string    ;
    function GetPartname                               : string    ;
    function GetProductPrintName                       : string    ;
    function GetPARTSDESCRIPTION                       : string    ;
    function GetSKU                                    : string    ;
    function GetPARTSDESCRIPTION_Memo                  : string    ;
    function GetPURCHASEDESC_Memo                      : string    ;
    function GetPURCHASEDESC                           : string    ;
    function GetINCOMEACCNT                            : string    ;
    function GetASSETACCNT                             : string    ;
    function GetCOGSACCNT                              : string    ;
    function GetBARCODE                                : string    ;
    function GetPRODUCTCODE                            : string    ;
    function GetTAXCODE                                : string    ;
    function GetPURCHTAXCODE                           : string    ;
    function GetPREFEREDSUPP                           : string    ;
    function GetSpecialDiscount                        : Boolean   ;
    function GetSNTracking                             : Boolean   ;
    function GetMultipleBins                           : Boolean   ;
    function Getbatch                                  : Boolean   ;
    function GetAutoBatch                              : Boolean   ;
    function GetAutoReorder                            : Boolean   ;
    function GetProductOptions                         : Boolean   ;
    function GetBuyQTY1                                : Integer   ;
    function GetBuyQTY2                                : Integer   ;
    function GetBuyQTY3                                : Integer   ;
    function GetCOST1                                  : Double    ;
    function GetCOST2                                  : Double    ;
    function GetCOST3                                  : Double    ;
    function GetAvgCost                                : Double    ;
    function GetCOSTINC1                               : Double    ;
    function GetCOSTINC2                               : Double    ;
    function GetCOSTINC3                               : Double    ;
    function GetSellQTY1                               : Integer   ;
    function GetSellQTY2                               : Integer   ;
    function GetSellQTY3                               : Integer   ;
    function GetPRICE1                                 : Double    ;
    function GetPRICE2                                 : Double    ;
    function GetPRICE3                                 : Double    ;
    function GetPRICEINC1                              : Double    ;
    function GetPRICEINC2                              : Double    ;
    function GetPRICEINC3                              : Double    ;
    function GetOrgPrice1                              : Double    ;
    function GetOrgPrice2                              : Double    ;
    function GetOrgPrice3                              : Double    ;
    function GetWHOLESALEPRICE                         : Double    ;
    function GetActive                                 : Boolean   ;
    function GetOrderTime                              : Integer   ;
    function GetManufactureTime                        : Integer   ;
    function GetOverrunTime                            : Integer   ;
    function GetDuration                               : Integer   ;
    function GetProductComment                         : string    ;
    function GetAttrib1Sale                            : Double    ;
    function GetAttrib2Sale                            : Double    ;
    function GetAttrib1SaleRate                        : Double    ;
    function GetAttrib1Purchase                        : Double    ;
    function GetAttrib2Purchase                        : Double    ;
    function GetAttrib1PurchaseRate                    : Double    ;
    function GetSupplierProductCode                    : string    ;
    function GetRequired                               : Boolean   ;
    function GetDateCreated                            : TDateTime ;
    function GetDateUpdated                            : TDateTime ;
    function GetShowProductPopUp                       : Boolean   ;
    function GetShowPurchaseProductPopUp               : Boolean   ;
    function GetProductPopUpNotes                      : string    ;
    function GetProductPurchasePopUpNotes              : string    ;
    function GetArea                                   : string    ;
    function GetDiscontinued                           : Boolean   ;
    function GetOnSpecial                              : Boolean   ;
    function GetUseAdvancedMatrix                      : Boolean   ;
    function GetUseHedgingFormula                      : Boolean   ;
    function GetOnCostIncrease                         : Boolean   ;
    function GetOnCostDecrease                         : Boolean   ;
    function GetCostUpdateFromPurchase                 : Boolean   ;
    function GetNormalDeliveryTime                     : Double    ;
    function GetLastUpdated                            : TDateTime ;
    function GetLatestCost                             : Double    ;
    function GetLatestCostDate                         : TDateTime ;
    function GetPDAMinSellQty                          : Double    ;
    function GetLandedCost                             : Double    ;
    function GetIsVariable                             : Boolean   ;
    function GetIncludeInAnalysis                      : Boolean   ;
    function GetHideOnPrint                            : Boolean   ;
    function GetHideonPickSlip                         : Boolean   ;
    function GetHideonDelDocket                        : Boolean   ;
    function GetSell_Cost_Percentage                   : Double    ;
    function GetCreateJobwhenconvert                   : Boolean   ;
    function GetTotalQty                               : Double    ;
    function GetTotalQty_UOM                           : string    ;
    function GetIsSegregatedProduct                    : Boolean   ;
    function GetVolume                                 : Double    ;
    function GetAutoBin                                : Boolean   ;
    function GetHasFormulaAttached                     : Boolean   ;
    function GetAutoSmartOrder                         : Boolean   ;
    function GetNetWeightKg                            : Double    ;
    function GetCommodityCode                          : string    ;
    function GetisEquipment                            : Boolean   ;
    function GetGrossMarginMode                        : Boolean   ;
    function GetCUSTFLD1                               : string    ;
    function GetCUSTFLD2                               : string    ;
    function GetCUSTFLD3                               : string    ;
    function GetCUSTFLD4                               : string    ;
    function GetCUSTFLD5                               : string    ;
    function GetCUSTFLD6                               : string    ;
    function GetCUSTFLD7                               : string    ;
    function GetCUSTFLD8                               : string    ;
    function GetCUSTFLD9                               : string    ;
    function GetCUSTFLD10                              : string    ;
    function GetCUSTFLD11                              : string    ;
    function GetCUSTFLD12                              : string    ;
    function GetCUSTFLD13                              : string    ;
    function GetCUSTFLD14                              : string    ;
    function GetCUSTFLD15                              : string    ;
    function GetCUSTDATE1                              : TDateTime ;
    function GetCUSTDATE2                              : TDateTime ;
    function GetCUSTDATE3                              : TDateTime ;
    function GetProductionNotes                        : string    ;
    function GetGeneralNotes                           : string    ;
    function GetDescription                            : string    ;
    function GetUOMtobeUsedinManufacture               : String    ;
    function GetCountryofOriginID                      : Integer   ;
    function GetEx_Works                               : Double    ;
    function GetProductUOMID                           : Integer   ;
    function GetProductUOM                             : string    ;
    function GetExtraSellPriceOverridesAllDiscounts    : Boolean   ;
    function GetLockExtraSell                          : Boolean   ;
    function GetPublishOnWeb                           : Boolean   ;
    function GetFormulaID                              : Integer   ;
    function GetPartCalcformula                        : string    ;
    function GetPartCalcformulaField                   : string    ;
    function GetPartCalcformulaUOM                     : string    ;
    function GetPartCalcformulaUOMID                   : Integer   ;
    function GetPartCalcformulaUOMMult                 : Double    ;
    function GetPartCalcFormulaMult                    : Double    ;
    function GetFormulaQtyValue1                       : Double    ;
    function GetFormulaQtyValue2                       : Double    ;
    function GetFormulaQtyValue3                       : Double    ;
    function GetFormulaQtyValue4                       : Double    ;
    function GetFormulaQtyValue5                       : Double    ;
    function GetFormulaQty                             : Double    ;
    function GetFormulaQty1                            : Double    ;
    function GetFormulaQty2                            : Double    ;
    function GetFormulaQty3                            : Double    ;
    function GetFormulaQty4                            : Double    ;
    function GetFormulaQty5                            : Double    ;
    function GetCanDeleteInPOS                         : Boolean   ;
    function GetIsBOMTemplate                          : Boolean   ;
    function GetIsSystemProduct                        : Boolean   ;
    function GetMancostWithLabour                      : Double    ;
    function GetPRODUCTAttrib1                         : Double    ;
    function GetDangerousProduct                       : Boolean   ;
    function GetReqdinsurance                          : Boolean   ;
    function GetInsuranceAmount                        : Double    ;
    function GetUndeliveredAction                      : string    ;
    function GetTariffcode                             : string    ;
    function GetconsignmentProducttype                 : string    ;
    function GetProductclassification                  : string    ;
    function GetEnableAutoSplitQtyintoUOMinSales       : Boolean   ;
    function GetAreaCoverageofsingleQty                : Double    ;
    function GetBOMPriceCalculatedfromTree             : Boolean   ;
    function GetBOMCostCalculatedFromTree              : Boolean   ;
    function GetRequiresAssembly                       : Boolean   ;
    function GetManAvgCost                             : Double    ;
    function GetManLatestCost                          : Double    ;
    function GetManLatestCostDate                      : TDateTime ;
    function GetProductPriceCalctype                   : Integer   ;
    function GetDefaultWarrantyDuration                : Integer   ;
    function GetProductMarkupPrice                     : Double    ;
    function GetProductMarkupPricePercent              : Double    ;
    function getTotalStockQty                          : Double    ;
    function GetMultibuy                               : Boolean   ;
    function GetEnablePackWeight                       : Boolean   ;
    function GetIsOTFProduct                           : Boolean   ;
    function GetLineNo                                 : Integer   ;
    function GetPublishOnVS1                           : Boolean   ;
    function GetIsManufactured                         : Boolean   ;

    procedure SetPARTTYPE                               (const Value: string    );
    procedure SetPRODUCTGROUP                           (const Value: string    );
    procedure SetPartname                               (const Value: string    );
    procedure SetProductPrintName                       (const Value: string    );
    procedure SetPARTSDESCRIPTION                       (const Value: string    );
    procedure SetSKU                                    (const Value: string    );
    procedure SetPARTSDESCRIPTION_Memo                  (const Value: string    );
    procedure SetPURCHASEDESC_Memo                      (const Value: string    );
    procedure SetPURCHASEDESC                           (const Value: string    );
    procedure SetINCOMEACCNT                            (const Value: string    );
    procedure SetASSETACCNT                             (const Value: string    );
    procedure SetCOGSACCNT                              (const Value: string    );
    procedure SetBARCODE                                (const Value: string    );
    procedure SetPRODUCTCODE                            (const Value: string    );
    procedure SetTAXCODE                                (const Value: string    );
    procedure SetPURCHTAXCODE                           (const Value: string    );
    procedure SetPREFEREDSUPP                           (const Value: string    );
    procedure SetSpecialDiscount                        (const Value: Boolean   );
    procedure SetSNTracking                             (const Value: Boolean   );
    procedure SetMultipleBins                           (const Value: Boolean   );
    procedure Setbatch                                  (const Value: Boolean   );
    procedure SetAutoBatch                              (const Value: Boolean   );
    procedure SetAutoReorder                            (const Value: Boolean   );
    procedure SetProductOptions                         (const Value: Boolean   );
    procedure SetBuyQTY1                                (const Value: Integer   );
    procedure SetBuyQTY2                                (const Value: Integer   );
    procedure SetBuyQTY3                                (const Value: Integer   );
    procedure SetCOST1                                  (const Value: Double    );
    procedure SetCOST2                                  (const Value: Double    );
    procedure SetCOST3                                  (const Value: Double    );
    procedure SetAvgCost                                (const Value: Double    );
    procedure SetCOSTINC1                               (const Value: Double    );
    procedure SetCOSTINC2                               (const Value: Double    );
    procedure SetCOSTINC3                               (const Value: Double    );
    procedure SetSellQTY1                               (const Value: Integer   );
    procedure SetSellQTY2                               (const Value: Integer   );
    procedure SetSellQTY3                               (const Value: Integer   );
    procedure SetPRICE1                                 (const Value: Double    );
    procedure SetPRICE2                                 (const Value: Double    );
    procedure SetPRICE3                                 (const Value: Double    );
    procedure SetPRICEINC1                              (const Value: Double    );
    procedure SetPRICEINC2                              (const Value: Double    );
    procedure SetPRICEINC3                              (const Value: Double    );
    procedure SetOrgPrice1                              (const Value: Double    );
    procedure SetOrgPrice2                              (const Value: Double    );
    procedure SetOrgPrice3                              (const Value: Double    );
    procedure SetWHOLESALEPRICE                         (const Value: Double    );
    procedure SetActive                                 (const Value: Boolean   );
    procedure SetOrderTime                              (const Value: Integer   );
    procedure SetManufactureTime                        (const Value: Integer   );
    procedure SetOverrunTime                            (const Value: Integer   );
    procedure SetDuration                               (const Value: Integer   );
    procedure SetProductComment                         (const Value: string    );
    procedure SetAttrib1Sale                            (const Value: Double    );
    procedure SetAttrib2Sale                            (const Value: Double    );
    procedure SetAttrib1SaleRate                        (const Value: Double    );
    procedure SetAttrib1Purchase                        (const Value: Double    );
    procedure SetAttrib2Purchase                        (const Value: Double    );
    procedure SetAttrib1PurchaseRate                    (const Value: Double    );
    procedure SetSupplierProductCode                    (const Value: string    );
    procedure SetRequired                               (const Value: Boolean   );
    procedure SetDateCreated                            (const Value: TDateTime );
    procedure SetDateUpdated                            (const Value: TDateTime );
    procedure SetShowProductPopUp                       (const Value: Boolean   );
    procedure SetShowPurchaseProductPopUp               (const Value: Boolean   );
    procedure SetProductPopUpNotes                      (const Value: string    );
    procedure SetProductPurchasePopUpNotes              (const Value: string    );
    procedure SetArea                                   (const Value: string    );
    procedure SetDiscontinued                           (const Value: Boolean   );
    procedure SetOnSpecial                              (const Value: Boolean   );
    procedure SetUseAdvancedMatrix                      (const Value: Boolean   );
    procedure SetUseHedgingFormula                      (const Value: Boolean   );
    procedure SetOnCostIncrease                         (const Value: Boolean   );
    procedure SetOnCostDecrease                         (const Value: Boolean   );
    procedure SetCostUpdateFromPurchase                 (const Value: Boolean   );
    procedure SetNormalDeliveryTime                     (const Value: Double    );
    procedure SetLastUpdated                            (const Value: TDateTime );
    procedure SetLatestCost                             (const Value: Double    );
    procedure SetLatestCostDate                         (const Value: TDateTime );
    procedure SetPDAMinSellQty                          (const Value: Double    );
    procedure SetLandedCost                             (const Value: Double    );
    procedure SetIsVariable                             (const Value: Boolean   );
    procedure SetIncludeInAnalysis                      (const Value: Boolean   );
    procedure SetHideOnPrint                            (const Value: Boolean   );
    procedure SetHideonPickSlip                         (const Value: Boolean   );
    procedure SetHideonDelDocket                        (const Value: Boolean   );
    procedure SetCreateJobwhenconvert                   (const Value: Boolean   );
    procedure SetTotalQty                               (const Value: Double    );
    procedure SetTotalQty_UOM                           (const Value: string    );
    procedure SetIsSegregatedProduct                    (const Value: Boolean   );
    procedure SetVolume                                 (const Value: Double    );
    procedure SetAutoBin                                (const Value: Boolean   );
    //procedure SetHasFormulaAttached                     (const Value: Boolean   );
    procedure SetAutoSmartOrder                         (const Value: Boolean   );
    procedure SetNetWeightKg                            (const Value: Double    );
    procedure SetCommodityCode                          (const Value: string    );
    procedure SetisEquipment                            (const Value: Boolean   );
    procedure SetGrossMarginMode                        (const Value: Boolean   );
    procedure SetCUSTFLD1                               (const Value: string    );
    procedure SetCUSTFLD2                               (const Value: string    );
    procedure SetCUSTFLD3                               (const Value: string    );
    procedure SetCUSTFLD4                               (const Value: string    );
    procedure SetCUSTFLD5                               (const Value: string    );
    procedure SetCUSTFLD6                               (const Value: string    );
    procedure SetCUSTFLD7                               (const Value: string    );
    procedure SetCUSTFLD8                               (const Value: string    );
    procedure SetCUSTFLD9                               (const Value: string    );
    procedure SetCUSTFLD10                              (const Value: string    );
    procedure SetCUSTFLD11                              (const Value: string    );
    procedure SetCUSTFLD12                              (const Value: string    );
    procedure SetCUSTFLD13                              (const Value: string    );
    procedure SetCUSTFLD14                              (const Value: string    );
    procedure SetCUSTFLD15                              (const Value: string    );
    procedure SetCUSTDATE1                              (const Value: TDateTime );
    procedure SetCUSTDATE2                              (const Value: TDateTime );
    procedure SetCUSTDATE3                              (const Value: TDateTime );
    procedure SetProductionNotes                        (const Value: string    );
    procedure SetGeneralNotes                           (const Value: string    );
    procedure SetDescription                            (const Value: string    );
    procedure SetUOMtobeUsedinManufacture               (const Value: string    );
    procedure SetCountryofOriginID                      (const Value: Integer   );
    procedure SetEx_Works                               (const Value: Double    );
    procedure SetProductUOMID                           (const Value: Integer   );
    procedure SetProductUOM                             (const Value: string    );
    procedure SetExtraSellPriceOverridesAllDiscounts    (const Value: Boolean   );
    procedure SetLockExtraSell                          (const Value: Boolean   );
    procedure SetPublishOnWeb                           (const Value: Boolean   );
    procedure SetFormulaID                              (const Value: Integer   );
    procedure SetPartCalcformula                        (const Value: string    );
    procedure SetPartCalcformulaField                   (const Value: string    );
    procedure SetPartCalcformulaUOM                     (const Value: string    );
    procedure SetPartCalcformulaUOMID                   (const Value: Integer   );
    procedure SetPartCalcformulaUOMMult                 (const Value: Double    );
    procedure SetPartCalcFormulaMult                    (const Value: Double    );
    procedure SetFormulaQtyValue1                       (const Value: Double    );
    procedure SetFormulaQtyValue2                       (const Value: Double    );
    procedure SetFormulaQtyValue3                       (const Value: Double    );
    procedure SetFormulaQtyValue4                       (const Value: Double    );
    procedure SetFormulaQtyValue5                       (const Value: Double    );
    procedure SetFormulaQty                             (const Value: Double    );
    procedure SetFormulaQty1                            (const Value: Double    );
    procedure SetFormulaQty2                            (const Value: Double    );
    procedure SetFormulaQty3                            (const Value: Double    );
    procedure SetFormulaQty4                            (const Value: Double    );
    procedure SetFormulaQty5                            (const Value: Double    );
    procedure SetCanDeleteInPOS                         (const Value: Boolean   );
    procedure SetIsBOMTemplate                          (const Value: Boolean   );
    procedure SetIsSystemProduct                        (const Value: Boolean   );
    procedure SetMancostWithLabour                      (const Value: Double    );
    procedure SetPRODUCTAttrib1                         (const Value: Double    );
    procedure SetDangerousProduct                       (const Value: Boolean   );
    procedure SetReqdinsurance                          (const Value: Boolean   );
    procedure SetInsuranceAmount                        (const Value: Double    );
    procedure SetUndeliveredAction                      (const Value: string    );
    procedure SetTariffcode                             (const Value: string    );
    procedure SetconsignmentProducttype                 (const Value: string    );
    procedure SetProductclassification                  (const Value: string    );
    procedure SetEnableAutoSplitQtyintoUOMinSales       (const Value: Boolean   );
    procedure SetAreaCoverageofsingleQty                (const Value: Double    );
    procedure SetBOMPriceCalculatedfromTree             (const Value: Boolean   );
    procedure SetBOMCostCalculatedFromTree              (const Value: Boolean   );
    procedure SetRequiresAssembly                       (const Value: Boolean   );
    Function  ProductNameUnique :Boolean;
    procedure SetManAvgCost                             (const Value: Double    );
    procedure SetManLatestCost                          (const Value: Double    );
    procedure SetManLatestCostDate                      (const Value: TDateTime );
    procedure SetProductPriceCalctype                   (const Value: Integer   );
    procedure SetDefaultWarrantyDuration                (const Value: Integer   );
    procedure SetProductMarkupPrice                     (const Value: Double    );
    procedure SetProductMarkupPricePercent              (const Value: Double    );
    procedure SetMultibuy                               (const Value: Boolean   );
    procedure SetEnablePackWeight                       (const Value: Boolean   );
    procedure SetIsOTFProduct                           (const Value: Boolean   );
    procedure SetLineNo                                 (const Value: Integer   );
    procedure SetPublishOnVS1                           (const Value: Boolean   );
    procedure SetIsManufactured                         (const Value: Boolean   );

    function GetExtraSellPrice: TProductExtraSellPrice;
    function GetAlternateProducts: TAlternateProduct;
    function GetExtraBuyPrice: TProductExtraBuyPrice;
    function GetForeignPriceBuy: TProductForeignBuyPrice;
    function GetForeignPriceSell: TProductForeignSellPrice;
    function geTProductBarcode: TProductBarcode;
    function getProductCommission: TProductCommission;
    function GeTProductProcessPart: TProductProcessPart;
    function GetProductRewardPoints: TProductRewardPoints;
    function GetProductSpecs: TProductSpecs;
    function GetTaxPurchase: TTaxCode;
    function GetTaxSales: TTaxCode;
    function GetQtyQuery(const FilterCondition:String): TERPQuery;Overload;
    function GetQtyQuery: TERPQuery;Overload;
    function ValidatePartCalcformulaField: Boolean;
    procedure PartCalcffieldsToformula;
    procedure DoSearchPartCalcformulaFieldVar(Sender: TObject; const VarName: string;var Value: extended; var FieldFound: Boolean);
    function getabandonGoods: Boolean;
    function getreDirbyAir: Boolean;
    function getReDirBySea: Boolean;
    function getReturnByAir: Boolean;
    function getReturnBySea: Boolean;
    function GetProductGroup1: string;
    procedure SetProductGroup1(const Value: string);
    procedure SetProductGroup2(const Value: string);
    function GetProductGroup2: string;
    function GetProductGroup3: string;
    procedure SetProductGroup3(const Value: string);
    function GetDocumentPath: string;
    procedure SetDocumentPath(const Value: string);
    function GetProductClass: TProductClass;
    function getService: TServices;
    Procedure UpdateProductNameinProductClass(const Sender: TBusObj; var Abort: Boolean);
    function GetExcludeFromSmartOrder: boolean;
    function GetHideWastage: boolean;
    function GetRequireSignature: Boolean;
    procedure SetExcludeFromSmartOrder(const Value: boolean);
    procedure SetHideWastage(const Value: boolean);
    procedure SetRequireSignature(const Value: Boolean);
    function QryValidateAllocation: TERPQuery;
    function GetExternalRef: string;
    procedure SetExternalRef(const Value: string);
    function GetHyperlink: string;
    procedure SetHyperlink(const Value: string);
    function GetSalesTaxBasedon: string;
    procedure SetSalesTaxBasedon(const Value: string);
    function getIsInvProduct: Boolean;
    function DefaultBin(aDeptID: Integer; datatype: String): String;
    function getSalesTaxBasedonProductPrice: Boolean;
    function getSalesTaxBasedonSalesPrice: Boolean;
    function GetAvailableQty : Double;
    function GetAllocatedBOQty : Double;
    function GetSOQty : Double;
    function GetSOBOQty : Double;
    function GetInstockQty : Double;
    function GetPOBOQty : Double;
    Function getPQAtimestamp :TDatetime;
    function GetRunningAvailableQty : Double;
    function GetRunningAllocatedBOQty : Double;
    function GetRunningSOQty : Double;
    function GetRunningSOBOQty : Double;
    function GetRunningInstockQty : Double;
    function GetRunningPOBOQty : Double;
    Function getRunningPQAtimestamp :TDatetime;
    function GetRunningQtyQuery: TERPQuery;Overload;
    function GetRunningQtyQuery(const FilterCondition:String): TERPQuery;Overload;
    function getMagentoID: Integer;
    procedure DeleteProductSubObjects;
    procedure DeleteProductSubObjectsCallback(const Sender: TBusObj;
      var Abort: Boolean);
  protected
    DetaislFromAttribtempproduct :boolean;
    fbCostPriceMarkupCalc :Boolean;

    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    procedure SetSell_Cost_Percentage                   (const Value: Double    );Virtual;
    procedure SetPropertyFromNodeifisOk(const aNode: IXMLNode; const aPropertyName: string; const Obj: TObject = nil);
    procedure SetBooleanPropertyFromNodeifisOk(const aNode: IXMLNode; const aPropertyName: string; const Obj: TObject = nil);
    procedure SetDateTimePropertyFromNodeifisOk(const aNode: IXMLNode; const aPropertyName: string; const Obj: TObject = nil);
    function ProductAlreadyHasAllocation: Boolean;
    function GetPictures: TProductPicture;virtual;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    class function GetKeyStringField: string; Override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    function isOktoSet(const TagName:String):Boolean;Virtual;
    property ExtraBuyPrice			: TProductExtraBuyPrice     Read GetExtraBuyPrice;
    property AlternateProducts  : TAlternateProduct         read GetAlternateProducts;
    Property ProductProcessPart : TProductProcessPart       Read geTProductProcessPart;
    property TaxSales				    : TTaxCode                  Read GetTaxSales;
    property TaxPurchase			  : TTaxCode                  Read GetTaxPurchase;
    property ForeignPriceSell		: TProductForeignSellPrice  Read GetForeignPriceSell;
    property ForeignPriceBuy		: TProductForeignBuyPrice   Read GetForeignPriceBuy;
    property ProductSpecs			  : TProductSpecs             Read GetProductSpecs;
    Property ProductBarcodes    : TProductBarcode           read geTProductBarcode;
    Property Pictures           : TProductPicture           Read GetPictures;
    Property ProductCommission  : TProductCommission        read getProductCommission;
    property ProductRewardPoints: TProductRewardPoints      read GetProductRewardPoints;
    property PRODUCTGROUP       :string      read GetPRODUCTGROUP    write SetPRODUCTGROUP                       ;
    property IsSystemProduct    :Boolean     read GetIsSystemProduct write SetIsSystemProduct                    ;
    Function Validateformula:Boolean;
    function ValidateAllocation(var Msg:String; ToTurnOffalloc:Boolean = False): Boolean;
    Property IgnoreBarcodeUpdate :Boolean read fbIgnoreBarcodeUpdate write fbIgnoreBarcodeUpdate;
    Property isInvProduct:Boolean read getIsInvProduct;
    Class function ChecknMakeProduct(Const aProductname:String;aConnection: TCustomMyconnection=nil; Enablebatch:Boolean = false;enablebin :boolean = False; enableSN:Boolean = False; aPREFEREDSUPP:String = '';aProductGroup:String =''):Integer;
    class function MakeProduct(const aProductname: String;aConnection: TCustomMyconnection=nil; Enablebatch:Boolean = false;enablebin :boolean = False; enableSN:Boolean = False;SearchonPrintName:Boolean =False; aPREFEREDSUPP:String = '';aProductGroup:String =''): Boolean;
    Function DefaultBinLocation(aDeptID:Integer):String;
    Function DefaultBinNumber(aDeptID:Integer):String;
    Property AvailableQty : Double Read GetAvailableQty;
    Property InvBOQty     : Double Read GetAllocatedBOQty;
    Property SOQty        : Double Read GetSOQty;
    Property SOBOQty      : Double Read GetSOBOQty;
    Property InStockQty   : Double Read GetInstockQty;
    Property POBOQty      : Double Read GetPOBOQty;
    Property PQAtimestamp : TDatetime read getPQAtimestamp;

    Property RunningAvailableQty : Double Read GetRunningAvailableQty;
    Property RunningInvBOQty     : Double Read GetRunningAllocatedBOQty;
    Property RunningSOQty        : Double Read GetRunningSOQty;
    Property RunningSOBOQty      : Double Read GetRunningSOBOQty;
    Property RunningInStockQty   : Double Read GetRunningInstockQty;
    Property RunningPOBOQty      : Double Read GetRunningPOBOQty;
    Property RunningPQAtimestamp : TDatetime read getRunningPQAtimestamp;

    Property QtyQuery[const FilterCondition:String]: TERPQuery read  GetQtyQuery;

    Property MagentoID:Integer read getMagentoID;
    class function IdForSKU(const aSKU: string; aConnection: TCustomMyConnection = nil; CheckProductname:Boolean =False): Integer;
    class function ProductPrice(Const aProductID:Integer;aConnection: TCustomMyconnection=nil):Double;

    //Function ChecknMakeProduct(AOwner:TComponent;const aProductname: String;  CreatenewifnotExits: boolean = true): Integer;

  published
    property ProductType                             :string      read GetPARTTYPE                              write SetPARTTYPE                           ;
    property ProductName                             :string      read GetPartname                              write SetPartname                           ;
    property ProductPrintName                        :string      read GetProductPrintName                      write SetProductPrintName                   ;
    property SalesDescription                        :string      read GetPARTSDESCRIPTION                      write SetPARTSDESCRIPTION                   ;
    property SKU                                     :string      read GetSKU                                   write SetSKU                                ;
    property SalesDescriptionMemo                    :string      read GetPARTSDESCRIPTION_Memo                 write SetPARTSDESCRIPTION_Memo              ;
    property PurchaseDescriptionMemo                 :string      read GetPURCHASEDESC_Memo                     write SetPURCHASEDESC_Memo                  ;
    property PurchaseDescription                     :string      read GetPURCHASEDESC                          write SetPURCHASEDESC                       ;
    property PreferedSupplierName                    :string      read GetPREFEREDSUPP                          write SetPREFEREDSUPP                       ;
    property IncomeAccount                           :string      read GetINCOMEACCNT                           write SetINCOMEACCNT                        ;
    property AssetAccount                            :string      read GetASSETACCNT                            write SetASSETACCNT                         ;
    property CogsAccount                             :string      read GetCOGSACCNT                             write SetCOGSACCNT                          ;
    property BARCODE                                 :string      read GetBARCODE                               write SetBARCODE                            ;
    property PRODUCTCODE                             :string      read GetPRODUCTCODE                           write SetPRODUCTCODE                        ;
    property TaxCodeSales                            :string      read GetTAXCODE                               write SetTAXCODE                            ;
    property TaxCodePurchase                         :string      read GetPURCHTAXCODE                          write SetPURCHTAXCODE                       ;
    property SpecialDiscount                         :Boolean     read GetSpecialDiscount                       write SetSpecialDiscount                    ;
    property SNTracking                              :Boolean     read GetSNTracking                            write SetSNTracking                         ;
    property MultipleBins                            :Boolean     read GetMultipleBins                          write SetMultipleBins                       ;
    property Batch                                   :Boolean     read Getbatch                                 write Setbatch                              ;
    property AutoAllocBatch                          :Boolean     read GetAutoBatch                             write SetAutoBatch                          ;
    property AutoReorder                             :Boolean     read GetAutoReorder                           write SetAutoReorder                        ;
    property HasProductOptions                       :Boolean     read GetProductOptions                        write SetProductOptions                     ;
    property BuyQTY1                                 :Integer     read GetBuyQTY1                               write SetBuyQTY1                            ;
    property BuyQTY2                                 :Integer     read GetBuyQTY2                               write SetBuyQTY2                            ;
    property BuyQTY3                                 :Integer     read GetBuyQTY3                               write SetBuyQTY3                            ;
    property BuyQty1Cost                             :Double      read GetCOST1                                 write SetCOST1                              ;
    property BuyQty2Cost                             :Double      read GetCOST2                                 write SetCOST2                              ;
    property BuyQty3Cost                             :Double      read GetCOST3                                 write SetCOST3                              ;
    property AverageCost                             :Double      read GetAvgCost                               write SetAvgCost                            ;
    property BuyQty1CostInc                          :Double      read GetCOSTINC1                              write SetCOSTINC1                           ;
    property BuyQty2CostInc                          :Double      read GetCOSTINC2                              write SetCOSTINC2                           ;
    property BuyQty3CostInc                          :Double      read GetCOSTINC3                              write SetCOSTINC3                           ;
    property SellQTY1                                :Integer     read GetSellQTY1                              write SetSellQTY1                           ;
    property SellQTY2                                :Integer     read GetSellQTY2                              write SetSellQTY2                           ;
    property SellQTY3                                :Integer     read GetSellQTY3                              write SetSellQTY3                           ;
    property SellQty1Price                           :Double      read GetPRICE1                                write SetPRICE1                             ;
    property SellQty2Price                           :Double      read GetPRICE2                                write SetPRICE2                             ;
    property SellQty3Price                           :Double      read GetPRICE3                                write SetPRICE3                             ;
    property SellQty1PriceInc                        :Double      read GetPRICEINC1                             write SetPRICEINC1                          ;
    property SellQty2PriceInc                        :Double      read GetPRICEINC2                             write SetPRICEINC2                          ;
    property SellQty3PriceInc                        :Double      read GetPRICEINC3                             write SetPRICEINC3                          ;
    property OrgPrice1                               :Double      read GetOrgPrice1                             write SetOrgPrice1                          ;
    property OrgPrice2                               :Double      read GetOrgPrice2                             write SetOrgPrice2                          ;
    property OrgPrice3                               :Double      read GetOrgPrice3                             write SetOrgPrice3                          ;
    property WHOLESALEPRICE                          :Double      read GetWHOLESALEPRICE                        write SetWHOLESALEPRICE                     ;
    property Active                                  :Boolean     read GetActive                                write SetActive                             ;
    property OrderTime                               :Integer     read GetOrderTime                             write SetOrderTime                          ;
    property ManufactureTime                         :Integer     read GetManufactureTime                       write SetManufactureTime                    ;
    property OverrunTime                             :Integer     read GetOverrunTime                           write SetOverrunTime                        ;
    property Duration                                :Integer     read GetDuration                              write SetDuration                           ;
    property ProductComment                          :string      read GetProductComment                        write SetProductComment                     ;
    property Attrib1Sale                             :Double      read GetAttrib1Sale                           write SetAttrib1Sale                        ;
    property Attrib2Sale                             :Double      read GetAttrib2Sale                           write SetAttrib2Sale                        ;
    property Attrib1SaleRate                         :Double      read GetAttrib1SaleRate                       write SetAttrib1SaleRate                    ;
    property Attrib1Purchase                         :Double      read GetAttrib1Purchase                       write SetAttrib1Purchase                    ;
    property Attrib2Purchase                         :Double      read GetAttrib2Purchase                       write SetAttrib2Purchase                    ;
    property Attrib1PurchaseRate                     :Double      read GetAttrib1PurchaseRate                   write SetAttrib1PurchaseRate                ;
    property SupplierProductCode                     :string      read GetSupplierProductCode                   write SetSupplierProductCode                ;
    property Required                                :Boolean     read GetRequired                              write SetRequired                           ;
    property DateCreated                             :TDateTime   read GetDateCreated                           write SetDateCreated                        ;
    property DateUpdated                             :TDateTime   read GetDateUpdated                           write SetDateUpdated                        ;
    property ShowProductPopUp                        :Boolean     read GetShowProductPopUp                      write SetShowProductPopUp                   ;
    property ShowPurchaseProductPopUp                :Boolean     read GetShowPurchaseProductPopUp              write SetShowPurchaseProductPopUp           ;
    property ProductPopUpNotes                       :string      read GetProductPopUpNotes                     write SetProductPopUpNotes                  ;
    property ProductPurchasePopUpNotes               :string      read GetProductPurchasePopUpNotes             write SetProductPurchasePopUpNotes          ;
    property Area                                    :string      read GetArea                                  write SetArea                               ;
    property IsDiscontinued                          :Boolean     read GetDiscontinued                          write SetDiscontinued                       ;
    property OnSpecial                               :Boolean     read GetOnSpecial                             write SetOnSpecial                          ;
    property UseAdvancedMatrix                       :Boolean     read GetUseAdvancedMatrix                     write SetUseAdvancedMatrix                  ;
    property UseHedgingFormula                       :Boolean     read GetUseHedgingFormula                     write SetUseHedgingFormula                  ;
    property UpdPriceOnCostInc                       :Boolean     read GetOnCostIncrease                        write SetOnCostIncrease                     ;
    property UpdPriceOnCostDec                       :Boolean     read GetOnCostDecrease                        write SetOnCostDecrease                     ;
    property CostUpdateFromPurchase                  :Boolean     read GetCostUpdateFromPurchase                write SetCostUpdateFromPurchase             ;
    property NormalDeliveryTime                      :Double      read GetNormalDeliveryTime                    write SetNormalDeliveryTime                 ;
    property LastUpdated                             :TDateTime   read GetLastUpdated                           write SetLastUpdated                        ;
    property LatestCost                              :Double      read GetLatestCost                            write SetLatestCost                         ;
    property LatestCostDate                          :TDateTime   read GetLatestCostDate                        write SetLatestCostDate                     ;
    property PDAMinSellQty                           :Double      read GetPDAMinSellQty                         write SetPDAMinSellQty                      ;
    property LandedCost                              :Double      read GetLandedCost                            write SetLandedCost                         ;
    property IsVariable                              :Boolean     read GetIsVariable                            write SetIsVariable                         ;
    property IncludeInAnalysis                       :Boolean     read GetIncludeInAnalysis                     write SetIncludeInAnalysis                  ;
    property HideOnPrint                             :Boolean     read GetHideOnPrint                           write SetHideOnPrint                        ;
    property HideonPickSlip                          :Boolean     read GetHideonPickSlip                        write SetHideonPickSlip                     ;
    property HideonDelDocket                         :Boolean     read GetHideonDelDocket                       write SetHideonDelDocket                    ;
    property MarkupPercentage                        :Double      read GetSell_Cost_Percentage                  write SetSell_Cost_Percentage               ;
    property CreateJobWhenConvert                    :Boolean     read GetCreateJobwhenconvert                  write SetCreateJobwhenconvert               ;
    property TotalQty                                :Double      read GetTotalQty                              write SetTotalQty                           ;
    property TotalQty_UOM                            :string      read GetTotalQty_UOM                          write SetTotalQty_UOM                       ;
    property IsSegregatedProduct                     :Boolean     read GetIsSegregatedProduct                   write SetIsSegregatedProduct                ;
    property Volume                                  :Double      read GetVolume                                write SetVolume                             ;
    property AutoAllocBin                            :Boolean     read GetAutoBin                               write SetAutoBin                            ;
    property HasFormulaAttached                      :Boolean     read GetHasFormulaAttached                    ;//write SetHasFormulaAttached                 ;
    property AutoSmartOrder                          :Boolean     read GetAutoSmartOrder                        write SetAutoSmartOrder                     ;
    property ExcludeFromSmartOrder                   :boolean     read GetExcludeFromSmartOrder                 write SetExcludeFromSmartOrder              ;
    property HideWastage                             :boolean     read GetHideWastage                           write SetHideWastage                        ;
    property RequireSignature                       :Boolean     read GetRequireSignature                     write SetRequireSignature;
    property NetWeightKg                             :Double      read GetNetWeightKg                           write SetNetWeightKg                        ;
    property CommodityCode                           :string      read GetCommodityCode                         write SetCommodityCode                      ;
    property IsEquipment                             :Boolean     read GetisEquipment                           write SetisEquipment                        ;
    property GrossMarginMode                         :Boolean     read GetGrossMarginMode                       write SetGrossMarginMode                    ;
    property CUSTFLD1                                :string      read GetCUSTFLD1                              write SetCUSTFLD1                           ;
    property CUSTFLD2                                :string      read GetCUSTFLD2                              write SetCUSTFLD2                           ;
    property CUSTFLD3                                :string      read GetCUSTFLD3                              write SetCUSTFLD3                           ;
    property CUSTFLD4                                :string      read GetCUSTFLD4                              write SetCUSTFLD4                           ;
    property CUSTFLD5                                :string      read GetCUSTFLD5                              write SetCUSTFLD5                           ;
    property CUSTFLD6                                :string      read GetCUSTFLD6                              write SetCUSTFLD6                           ;
    property CUSTFLD7                                :string      read GetCUSTFLD7                              write SetCUSTFLD7                           ;
    property CUSTFLD8                                :string      read GetCUSTFLD8                              write SetCUSTFLD8                           ;
    property CUSTFLD9                                :string      read GetCUSTFLD9                              write SetCUSTFLD9                           ;
    property CUSTFLD10                               :string      read GetCUSTFLD10                             write SetCUSTFLD10                          ;
    property CUSTFLD11                               :string      read GetCUSTFLD11                             write SetCUSTFLD11                          ;
    property CUSTFLD12                               :string      read GetCUSTFLD12                             write SetCUSTFLD12                          ;
    property CUSTFLD13                               :string      read GetCUSTFLD13                             write SetCUSTFLD13                          ;
    property CUSTFLD14                               :string      read GetCUSTFLD14                             write SetCUSTFLD14                          ;
    property CUSTFLD15                               :string      read GetCUSTFLD15                             write SetCUSTFLD15                          ;
    property CUSTDATE1                               :TDateTime   read GetCUSTDATE1                             write SetCUSTDATE1                          ;
    property CUSTDATE2                               :TDateTime   read GetCUSTDATE2                             write SetCUSTDATE2                          ;
    property CUSTDATE3                               :TDateTime   read GetCUSTDATE3                             write SetCUSTDATE3                          ;
    property ProductionNotes                         :string      read GetProductionNotes                       write SetProductionNotes                    ;
    property GeneralNotes                            :string      read GetGeneralNotes                          write SetGeneralNotes                       ;
    property ProductDescription                      :string      read GetDescription                           write SetDescription                        ;
    property UOMToBeUsedInManufacture                :string      read GetUOMtobeUsedinManufacture              write SetUOMtobeUsedinManufacture           ;
    property CountryofOriginID                       :Integer     read GetCountryofOriginID                     write SetCountryofOriginID                  ;
    property Ex_Works                                :Double      read GetEx_Works                              write SetEx_Works                           ;
    property ProductUOMID                            :Integer     read GetProductUOMID                          write SetProductUOMID                       ;
    property ProductUOM                              :string      read GetProductUOM                            write SetProductUOM                         ;
    property ExtraSellPriceOverridesAllDiscounts     :Boolean     read GetExtraSellPriceOverridesAllDiscounts   write SetExtraSellPriceOverridesAllDiscounts;
    property LockExtraSell                           :Boolean     read GetLockExtraSell                         write SetLockExtraSell                      ;
    property PublishOnWeb                            :Boolean     read GetPublishOnWeb                          write SetPublishOnWeb                       ;
    property FormulaID                               :Integer     read GetFormulaID                             write SetFormulaID                          ;
    property PartCalcformula                         :string      read GetPartCalcformula                       write SetPartCalcformula                    ;
    property PartCalcformulaField                    :string      read GetPartCalcformulaField                  write SetPartCalcformulaField               ;
    property PartCalcformulaUOM                      :string      read GetPartCalcformulaUOM                    write SetPartCalcformulaUOM                 ;
    property PartCalcformulaUOMID                    :Integer     read GetPartCalcformulaUOMID                  write SetPartCalcformulaUOMID               ;
    property PartCalcformulaUOMMult                  :Double      read GetPartCalcformulaUOMMult                write SetPartCalcformulaUOMMult             ;
    property PartCalcFormulaMult                     :Double      read GetPartCalcFormulaMult                   write SetPartCalcFormulaMult                ;
    property FormulaQtyValue1                        :Double      read GetFormulaQtyValue1                      write SetFormulaQtyValue1                   ;
    property FormulaQtyValue2                        :Double      read GetFormulaQtyValue2                      write SetFormulaQtyValue2                   ;
    property FormulaQtyValue3                        :Double      read GetFormulaQtyValue3                      write SetFormulaQtyValue3                   ;
    property FormulaQtyValue4                        :Double      read GetFormulaQtyValue4                      write SetFormulaQtyValue4                   ;
    property FormulaQtyValue5                        :Double      read GetFormulaQtyValue5                      write SetFormulaQtyValue5                   ;
    property FormulaQty                              :Double      read GetFormulaQty                            write SetFormulaQty                         ;
    property FormulaQty1                             :Double      read GetFormulaQty1                           write SetFormulaQty1                        ;
    property FormulaQty2                             :Double      read GetFormulaQty2                           write SetFormulaQty2                        ;
    property FormulaQty3                             :Double      read GetFormulaQty3                           write SetFormulaQty3                        ;
    property FormulaQty4                             :Double      read GetFormulaQty4                           write SetFormulaQty4                        ;
    property FormulaQty5                             :Double      read GetFormulaQty5                           write SetFormulaQty5                        ;
    property CanDeleteInPOS                          :Boolean     read GetCanDeleteInPOS                        write SetCanDeleteInPOS                     ;
    property IsBOMTemplate                           :Boolean     read GetIsBOMTemplate                         write SetIsBOMTemplate                      ;
    property MancostWithLabour                       :Double      read GetMancostWithLabour                     write SetMancostWithLabour                  ;
    property PRODUCTAttrib1                          :Double      read GetPRODUCTAttrib1                        write SetPRODUCTAttrib1                     ;
    property DangerousProduct                        :Boolean     read GetDangerousProduct                      write SetDangerousProduct                   ;
    property ReqdInsurance                           :Boolean     read GetReqdinsurance                         write SetReqdinsurance                      ;
    property InsuranceAmount                         :Double      read GetInsuranceAmount                       write SetInsuranceAmount                    ;
    property UndeliveredAction                       :string      read GetUndeliveredAction                     write SetUndeliveredAction                  ;
    property Tariffcode                              :string      read GetTariffcode                            write SetTariffcode                         ;
    property ConsignmentProducttype                  :string      read GetconsignmentProducttype                write SetconsignmentProducttype             ;
    property Productclassification                   :string      read GetProductclassification                 write SetProductclassification              ;
    property EnableAutoSplitQtyintoUOMinSales        :Boolean     read GetEnableAutoSplitQtyintoUOMinSales      write SetEnableAutoSplitQtyintoUOMinSales   ;
    property AreaCoverageofsingleQty                 :Double      read GetAreaCoverageofsingleQty               write SetAreaCoverageofsingleQty            ;
    property BOMPriceCalculatedfromTree              :Boolean     read GetBOMPriceCalculatedfromTree            write SetBOMPriceCalculatedfromTree         ;
    property BOMCostCalculatedFromTree               :Boolean     read GetBOMCostCalculatedFromTree             write SetBOMCostCalculatedFromTree          ;
    property RequiresAssembly                        :Boolean     read GetRequiresAssembly                      write SetRequiresAssembly                   ;
    Property ReturnBySea                             :Boolean     read getReturnBySea ;
    Property ReturnByAir                             :Boolean     read getReturnByAir ;
    Property AbandonGoods                            :Boolean     read getabandonGoods ;
    Property ReDirBySea                              :Boolean     read getReDirBySea ;
    Property ReDirbyAir                              :Boolean     read getreDirbyAir ;
    property ProductGroup1                           :string      read GetProductGroup1                         write SetProductGroup1;
    property ProductGroup2                           :string      read GetProductGroup2                         write SetProductGroup2;
    property ProductGroup3                           :string      read GetProductGroup3                         write SetProductGroup3;
    property DocumentPath                            :string      read GetDocumentPath                          write SetDocumentPath;
    property ManAverageCost                          :Double      read GetManAvgCost                            write SetManAvgCost                         ;
    property ProductMarkupPrice                      :Double      read GetProductMarkupPrice                    write SetProductMarkupPrice                 ;
    property ProductMarkupPricePercent               :Double      read GetProductMarkupPricePercent             write SetProductMarkupPricePercent          ;
    property ManLatestCost                           :Double      read GetManLatestCost                         write SetManLatestCost                      ;
    property ManLatestCostDate                       :TDateTime   read GetManLatestCostDate                     write SetManLatestCostDate                  ;
    property ProductPriceCalctype                    :Integer     read GetProductPriceCalctype                  write SetProductPriceCalctype               ;
    property DefaultWarrantyDuration                 :Integer     read GetDefaultWarrantyDuration               write SetDefaultWarrantyDuration            ;
    property Multibuy                                :Boolean     read GetMultibuy                              write SetMultibuy                           ;
    property EnablePackWeight                        :Boolean     read GetEnablePackWeight                      write SetEnablePackWeight                   ;
    property IsOTFProduct                            :Boolean     read GetIsOTFProduct                          write SetIsOTFProduct                       ;
    property LineNo                                  :Integer     read GetLineNo                                write SetLineNo                             ;
    Property TotalStockQty                           :Double      read getTotalStockQty;
    property ExternalRef                             :string      read GetExternalRef                           write SetExternalRef;
    property ProductClass			                       :TProductClass    Read GetProductClass;
    property Hyperlink                               :string      read GetHyperlink                             write SetHyperlink;
    property SalesTaxBasedon                         :string      read GetSalesTaxBasedon                       write SetSalesTaxBasedon;
    Property SalesTaxBasedonProductPrice             :Boolean     read getSalesTaxBasedonProductPrice;
    Property SalesTaxBasedonSalesPrice               :Boolean     read getSalesTaxBasedonSalesPrice;
    property PublishOnVS1                            :Boolean     read GetPublishOnVS1                          write SetPublishOnVS1;
    property ExtraSellPrice			                     :TProductExtraSellPrice    Read GetExtraSellPrice;
    Property Services                                :TServices   read getService;
    Property IsManufactured                          : Boolean    read GetIsManufactured                        write SetIsManufactured;

  end;


implementation


uses tcDataUtils, CommonLib, BusObjectListObj, BusObjConst, sysutils,
  BusObjClient, CommonDbLib, ProductQtyLib, PQALib, tcConst, AppEnvironment,
  ParserObj, types , StrUtils, BusObjUtils, DbSharedObjectsObj,
  BusobjExternalXRef(*, utMagentoService, MagentoLib*), utCoreEDIConst;
class function TProductSimple.ProductPrice(const aProductID: Integer;aConnection: TCustomMyconnection=nil): Double;
var
  ProdObj :TProductSimple;
begin
  REsult := 0;
  ProdObj := TProductSimple.createwithNewConn(nil);
  try
    if (aConnection <> nil) and (aConnection.Connected) then ProdObj.connection.connection := aConnection;
    ProdObj.load(aProductId);
    if ProdObj.count <>0 then begin
      Result := ProdObj.SellQty1PriceInc;
    end;
  finally
    Freeandnil(ProdObj);
  end;
end;

class function TProductSimple.ChecknMakeProduct(const aProductname: String;aConnection: TCustomMyconnection=nil; Enablebatch:Boolean = false;enablebin :boolean = False; enableSN:Boolean = False; aPREFEREDSUPP:String = '';aProductGroup:String =''): Integer;
begin
  TProductSimple.MakeProduct(aProductname,aConnection,Enablebatch,enablebin,enableSN ,false,  aPREFEREDSUPP,aProductGroup);
  REsult := TProductSimple.IDToggle(aProductname);
end;
class function TProductSimple.MakeProduct(const aProductname: String;aConnection: TCustomMyconnection=nil; Enablebatch:Boolean = false;enablebin :boolean = False; enableSN:Boolean = False;SearchonPrintName:Boolean =False; aPREFEREDSUPP:String = '';aProductGroup:String =''): Boolean;
var
  ProdObj :TProductSimple;
begin
  REsult := False;
  ProdObj := TProductSimple.createwithNewConn(nil);
  try
    if (aConnection <> nil) and (aConnection.Connected) then ProdObj.connection.connection := aConnection;
    if SearchonPrintName then
      ProdObj.loadselect('ProductPrintName = ' + quotedstr(aProductname))
    else ProdObj.loadselect('Partname = ' + quotedstr(aProductname));
    if ProdObj.count =0 then begin
      ProdObj.New;
      ProdObj.Productname := aProductname;
      ProdObj.ProductPrintName := aProductname;
      if Enablebatch  then ProdObj.Batch        := true;
      if enablebin    then ProdObj.Multiplebins := true;
      if enableSN     then ProdObj.SNTracking   := true;
      if trim(aPREFEREDSUPP)<>'' then ProdObj.PreferedSupplierName := aPREFEREDSUPP;
      if aProductGroup <> '' then ProdObj.ProductGroup := aProductGroup;
      ProdObj.PostDB;
      Result := True;
    end;
  finally
    Freeandnil(ProdObj);
  end;

end;
Function TProductSimple.DefaultBin(aDeptID:Integer;datatype:String):String;
var
  qry: TERPQuery;
begin
  result := '';
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Qry.sql.text := 'SELECT   PB.*  '+
                    ' FROM tblproductclasses PC   '+
                    ' INNER JOIN tblProductbin PB ON PC.DefaultbinId = PB.binid   '+
                    ' WHERE productId = ' + inttostr(ID)+ ' and PC.classid = ' + inttostr(aDeptID);
    Qry.open;
    if (Qry.FieldByName('classid').AsInteger = aDeptID) then begin
      if datatype = 'Loc' then result := Qry.FieldByName('Binlocation').AsString
      else if datatype = 'Num' then result := Qry.FieldByName('BinNumber').AsString
      else result := inttostr(Qry.FieldByName('binid').asInteger);
      Exit;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

Function TProductSimple.DefaultBinLocation(aDeptID:Integer):String;
begin
  result := DefaultBin(aDeptID , 'Loc');
end;
Function TProductSimple.DefaultBinNumber(aDeptID:Integer):String;
begin
  result := DefaultBin(aDeptID , 'Num');
end;

constructor TProductSimple.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ProductSimple';
  fSQL := 'SELECT * FROM tblparts';
  DetaislFromAttribtempproduct := False;
  fbCostPriceMarkupCalc:= True;
  fQryValidateAllocation:= nil;
  fbIgnoreBarcodeUpdate := False;
end;


destructor TProductSimple.Destroy;
begin
  if Assigned(fQryValidateAllocation) then
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(fQryValidateAllocation);
  inherited;
end;


(*function TProductSimple.ChecknMakeProduct(AOwner: TComponent; const aProductname: String; CreatenewifnotExits): Integer;
var
  ProductSimple :TProductSimple;
begin
  REsult := 0;
  ProductSimple := TProductSimple.CreateWithNewConn(AOwner);
  try
    ProductSimple.loadselect('Partname=' + Quotedstr(aProductname));
    if (ProductSimple.count <>0) then begin
      result := ProductSimple.ID;
      Exit;
    end;
     if CreatenewifnotExits then begin
          ProductSimple.Connection.begintransaction;
          try
            ProductSimple.new;
            ProductSimple.Productname := aProductname;
            ProductSimple.PostDB;
            if not ProductSimple.save then begin
              ProductSimple.Connection.RollbackTransaction;
              Exit;
            end;
            ProductSimple.Connection.CommitTransaction;
            result := ProductSimple.ID;
          Except
            on E:Exception do begin
              ProductSimple.Connection.RollbackTransaction;
              ResultStatus.AddItem(False, rssWarning, 0, 'Creating Product '+ quotedstr(aProductName) + ' Failed' + NL+ E.message );
              Exit;
            end;
          end;
     end;
  finally

    Freeandnil(ProductSimple);
  end;
end;*)

procedure TProductSimple.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
    SetBooleanPropertyFromNodeifisOk(Node, 'active');
    SetPropertyFromNodeifisOk(Node, 'ProductName');
    SetPropertyFromNodeifisOk(Node, 'SKU');
    SetPropertyFromNodeifisOk(Node, 'Equipmentname');
    SetBooleanPropertyFromNodeifisOk(Node, 'UpdPriceOnCostInc');
    SetBooleanPropertyFromNodeifisOk(Node, 'UpdPriceOnCostDec');
    if DetaislFromAttribtempproduct then fbCostPriceMarkupCalc := False;
    Try
      SetPropertyFromNodeifisOk(Node, 'UOMtobeUsedinManufacture');
      SetBooleanPropertyFromNodeifisOk(Node, 'GrossMarginMode');
      if DetaislFromAttribtempproduct then begin
        SetPropertyFromNodeifisOk(Node, 'MarkupPercentage');
        SetPropertyFromNodeifisOk(Node, 'Sell_Cost_Percentage');
      end;
      SetPropertyFromNodeifisOk(Node, 'BuyQty1');
      SetPropertyFromNodeifisOk(Node, 'BuyQty1Cost');
      SetPropertyFromNodeifisOk(Node, 'BuyQty2');
      SetPropertyFromNodeifisOk(Node, 'BuyQty2Cost');
      SetPropertyFromNodeifisOk(Node, 'BuyQty3');
      SetPropertyFromNodeifisOk(Node, 'BuyQty3Cost');
      SetPropertyFromNodeifisOk(Node, 'SellQty1');
      SetPropertyFromNodeifisOk(Node, 'SellQty1Price');
      SetPropertyFromNodeifisOk(Node, 'SellQty2');
      SetPropertyFromNodeifisOk(Node, 'SellQty2Price');
      SetPropertyFromNodeifisOk(Node, 'SellQty3');
      SetPropertyFromNodeifisOk(Node, 'SellQty3Price');

    finally
       fbCostPriceMarkupCalc := true;
    end;

    SetPropertyFromNodeifisOk(Node, 'Attrib1Purchase');
    SetPropertyFromNodeifisOk(Node, 'Attrib2Purchase');
    SetPropertyFromNodeifisOk(Node, 'PRODUCTAttrib1');
    SetPropertyFromNodeifisOk(Node, 'Attrib1PurchaseRate');
    SetPropertyFromNodeifisOk(Node, 'Attrib1Sale');
    SetPropertyFromNodeifisOk(Node, 'Attrib1SaleRate');
    SetPropertyFromNodeifisOk(Node, 'Attrib2Sale');
    SetPropertyFromNodeifisOk(Node, 'ProductGroup');
    SetPropertyFromNodeifisOk(Node, 'PurchaseDescription');
    SetPropertyFromNodeifisOk(Node, 'ProductDescription');
    SetPropertyFromNodeifisOk(Node, 'ProductType');
    SetPropertyFromNodeifisOk(Node, 'Area');
    SetPropertyFromNodeifisOk(Node, 'IncomeAccount');
    SetPropertyFromNodeifisOk(Node, 'AssetAccount');
    SetPropertyFromNodeifisOk(Node, 'CogsAccount');
    SetPropertyFromNodeifisOk(Node, 'TaxCodePurchase');
    SetPropertyFromNodeifisOk(Node, 'TaxCodeSales');
    SetPropertyFromNodeifisOk(Node, 'SalesDescription');
    SetPropertyFromNodeifisOk(Node, 'PreferedSupplierName');
    SetPropertyFromNodeifisOk(node, 'SupplierProductCode');
    SetBooleanPropertyFromNodeifisOk(Node, 'UseHedgingFormula');
    SetPropertyFromNodeifisOk(Node, 'LandedCost');
    SetPropertyFromNodeifisOk(Node, 'MancostWithLabour');
    SetPropertyFromNodeifisOk(Node, 'NormalDeliveryTime');
    SetBooleanPropertyFromNodeifisOk(Node, 'ShowProductPopUp');
    SetBooleanPropertyFromNodeifisOk(Node, 'ShowPurchaseProductPopUp');
    SetPropertyFromNodeifisOk(Node, 'ProductPopUpNotes');
    SetPropertyFromNodeifisOk(Node, 'ProductPurchasePopUpNotes');
    SetBooleanPropertyFromNodeifisOk(Node, 'IsDiscontinued');
    SetBooleanPropertyFromNodeifisOk(Node, 'Multiplebins');
    SetBooleanPropertyFromNodeifisOk(Node, 'Batch');
    SetBooleanPropertyFromNodeifisOk(Node, 'Autoallocbin');
    SetBooleanPropertyFromNodeifisOk(Node, 'AutoAllocBatch');
    SetBooleanPropertyFromNodeifisOk(Node, 'SnTracking');
    SetBooleanPropertyFromNodeifisOk(Node, 'SpecialDiscount');
    SetPropertyFromNodeifisOk(Node, 'Volume');
    SetBooleanPropertyFromNodeifisOk(Node, 'AutoReorder');
    SetBooleanPropertyFromNodeifisOk(Node, 'HasProductOptions');
    SetBooleanPropertyFromNodeifisOk(Node, 'OnSpecial');
    SetBooleanPropertyFromNodeifisOk(Node, 'AutoSmartOrder');
    SetBooleanPropertyFromNodeifisOk(Node, 'RequireSignature');
    SetBooleanPropertyFromNodeifisOk(Node, 'ExcludeFromSmartOrder');
    SetBooleanPropertyFromNodeifisOk(Node, 'HideWastage');
    SetBooleanPropertyFromNodeifisOk(Node, 'RequiresAssembly');
    SetBooleanPropertyFromNodeifisOk(Node, 'IncludeInAnalysis');
    SetBooleanPropertyFromNodeifisOk(Node, 'HideOnPrint');
    SetBooleanPropertyFromNodeifisOk(Node, 'HideonPickSlip');
    SetBooleanPropertyFromNodeifisOk(Node, 'HideonDelDocket');
    SetBooleanPropertyFromNodeifisOk(Node, 'isEquipment');
    SetBooleanPropertyFromNodeifisOk(Node, 'ExtraSellPriceOverridesAllDiscounts');
    SetPropertyFromNodeifisOk(Node, 'PDAMinSellQty');
    SetPropertyFromNodeifisOk(Node, 'ProductComment');
    SetPropertyFromNodeifisOk(Node, 'ProductionNotes');
    SetPropertyFromNodeifisOk(Node, 'GeneralNotes');
    SetPropertyFromNodeifisOk(Node, 'PRODUCTCODE');
    SetPropertyFromNodeifisOk(Node, 'Barcode');
    SetPropertyFromNodeifisOk(Node, 'LatestCost');
    SetDateTimePropertyFromNodeifisOk(Node,'LatestCostDate');
    SetPropertyFromNodeifisOk(node , 'CUSTFLD1');
    SetPropertyFromNodeifisOk(node , 'CUSTFLD2');
    SetPropertyFromNodeifisOk(node , 'CUSTFLD3');
    SetPropertyFromNodeifisOk(node , 'CUSTFLD4');
    SetPropertyFromNodeifisOk(node , 'CUSTFLD5');
    SetPropertyFromNodeifisOk(node , 'CUSTFLD6');
    SetPropertyFromNodeifisOk(node , 'CUSTFLD7');
    SetPropertyFromNodeifisOk(node , 'CUSTFLD8');
    SetPropertyFromNodeifisOk(node , 'CUSTFLD9');
    SetPropertyFromNodeifisOk(node , 'CUSTFLD10');
    SetPropertyFromNodeifisOk(node , 'CUSTFLD11');
    SetPropertyFromNodeifisOk(node , 'CUSTFLD12');
    SetPropertyFromNodeifisOk(node , 'CUSTFLD13');
    SetPropertyFromNodeifisOk(node , 'CUSTFLD14');
    SetPropertyFromNodeifisOk(node , 'CUSTFLD15');
    SetDateTimePropertyFromNodeifisOk(node , 'CUSTDATE1');
    SetDateTimePropertyFromNodeifisOk(node , 'CUSTDATE2');
    SetDateTimePropertyFromNodeifisOk(node , 'CUSTDATE3');
    SetPropertyFromNodeifisOk(Node, 'PartCalcformulaField');
    SetPropertyFromNodeifisOk(Node, 'PartCalcformula');
    SetPropertyFromNodeifisOk(Node, 'PartCalcformulaUOM');
    SetPropertyFromNodeifisOk(Node, 'PartCalcformulaUOMID');
    SetPropertyFromNodeifisOk(Node, 'PartCalcFormulaMult');
    SetPropertyFromNodeifisOk(Node, 'PartCalcformulaUOMMult');
    SetPropertyFromNodeifisOk(Node, 'DangerousProduct');
    SetBooleanPropertyFromNodeifisOk(Node, 'Reqdinsurance');
    SetPropertyFromNodeifisOk(Node, 'InsuranceAmount');
    SetPropertyFromNodeifisOk(Node, 'AreaCoverageofsingleQty');
    SetPropertyFromNodeifisOk(Node, 'UndeliveredAction');
    SetPropertyFromNodeifisOk(Node, 'Tariffcode');
    SetPropertyFromNodeifisOk(Node, 'consignmentProducttype');
    SetPropertyFromNodeifisOk(Node, 'Productclassification');
    SetBooleanPropertyFromNodeifisOk(Node, 'LockExtraSell');
    SetPropertyFromNodeifisOk(Node, 'ManLatestCost');
    SetPropertyFromNodeifisOk(Node, 'ManAverageCost');
    SetPropertyFromNodeifisOk(Node, 'ProductMarkupPrice');
    SetPropertyFromNodeifisOk(Node, 'ProductMarkupPricePercent');
    SetDateTimePropertyFromNodeifisOk(Node,'ManLatestCostDate');
    SetPropertyFromNodeifisOk(Node, 'ProductPriceCalctype');
    SetPropertyFromNodeifisOk(Node, 'DefaultWarrantyDuration');
    SetBooleanPropertyFromNodeifisOk(Node, 'Multibuy');
    SetBooleanPropertyFromNodeifisOk(Node, 'EnablePackWeight');
    SetBooleanPropertyFromNodeifisOk(Node, 'IsOTFProduct');
    SetPropertyFromNodeifisOk(Node, 'LineNo');
    SetPropertyFromNodeifisOk(Node, 'Hyperlink');
    SetPropertyFromNodeifisOk(Node, 'SalesTaxBasedon');
    SetBooleanPropertyFromNodeifisOk(Node, 'PublishOnVS1');
end;


procedure TProductSimple.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
    AddXMLNode(node , 'active'              , active);
    AddXMLNode(node , 'ProductName'         , ProductName);
    AddXMLNode(node , 'SKU'                 , SKU);
    AddXMLNode(node , 'ProductGroup'        , ProductGroup);
    AddXMLNode(node , 'ProductType'         , ProductType);
    AddXMLNode(node , 'UOMtobeUsedinManufacture'     , UOMtobeUsedinManufacture);
    AddXMLNode(node , 'GrossMarginMode'     , GrossMarginMode);
    AddXMLNode(node , 'PurchaseDescription' , PurchaseDescription);
    AddXMLNode(node , 'ProductDescription' , ProductDescription);
    AddXMLNode(node , 'SalesDescription'    , SalesDescription);
    AddXMLNode(node , 'PreferedSupplierName' , PreferedSupplierName);
    AddXMLNode(node , 'SupplierProductCode' ,  SupplierProductCode);
    AddXMLNode(node , 'UseHedgingFormula'   , UseHedgingFormula);
    AddXMLNode(node , 'SellQty1'            , SellQty1);
    AddXMLNode(node , 'SellQty1Price'       , SellQty1Price);
    AddXMLNode(node , 'SellQty2'            , SellQty2);
    AddXMLNode(node , 'SellQty2Price'       , SellQty2Price);
    AddXMLNode(node , 'SellQty3'            , SellQty3);
    AddXMLNode(node , 'SellQty3Price'		, SellQty3Price);
    AddXMLNode(node , 'BuyQty1'	            , BuyQty1);
    AddXMLNode(node , 'BuyQty1Cost'         , BuyQty1Cost);
    AddXMLNode(node , 'BuyQty2'             , BuyQty2);
    AddXMLNode(node , 'BuyQty2Cost'         , BuyQty2Cost);
    AddXMLNode(node , 'BuyQty3'             , BuyQty3);
    AddXMLNode(node , 'BuyQty3Cost'         , BuyQty3Cost);
    AddXMLNode(node , 'LandedCost'          , LandedCost);
    AddXMLNode(node , 'MancostWithLabour'   , MancostWithLabour);
    AddXMLNode(node , 'Attrib1Purchase'     , Attrib1Purchase);
    AddXMLNode(node , 'Attrib2Purchase'     , Attrib2Purchase);
    AddXMLNode(node , 'PRODUCTAttrib1'     , PRODUCTAttrib1);
    AddXMLNode(node , 'Attrib1PurchaseRate' , Attrib1PurchaseRate);
    AddXMLNode(node , 'Attrib1Sale'         , Attrib1Sale);
    AddXMLNode(node , 'Attrib1SaleRate'     , Attrib1SaleRate);
    AddXMLNode(node , 'Attrib2Sale'         , Attrib2Sale);
    AddXMLNode(node , 'Area'                ,  Area);
    AddXMLNode(node , 'IncomeAccount'       , IncomeAccount);
    AddXMLNode(node , 'AssetAccount'        , AssetAccount);
    AddXMLNode(node , 'CogsAccount'         , CogsAccount);
    AddXMLNode(node , 'AverageCost'         , AverageCost);
    AddXMLNode(node , 'LatestCost'          , LatestCost);
    AddXMLNode(node , 'LatestCostDate'      , LatestCostDate);
    AddXMLNode(node , 'TaxCodePurchase'     , TaxCodePurchase);
    AddXMLNode(node , 'TaxCodeSales'        , TaxCodeSales);
    AddXMLNode(node , 'UpdPriceOnCostInc'   , UpdPriceOnCostInc);
    AddXMLNode(node , 'UpdPriceOnCostDec'   , UpdPriceOnCostDec);
    AddXMLNode(node , 'MarkupPercentage'    , MarkupPercentage);
    AddXMLNode(node , 'NormalDeliveryTime'  ,  NormalDeliveryTime);
    AddXMLNode(node , 'ShowProductPopUp'    , ShowProductPopUp);
    AddXMLNode(node , 'ShowPurchaseProductPopUp'    , ShowPurchaseProductPopUp);
    AddXMLNode(node , 'ProductPopUpNotes'   , ProductPopUpNotes);
    AddXMLNode(node , 'ProductPurchasePopUpNotes'   , ProductPurchasePopUpNotes);
    AddXMLNode(node , 'IsDiscontinued'      , IsDiscontinued);
    AddXMLNode(node , 'Multiplebins'        , Multiplebins);
    AddXMLNode(node , 'Batch'               , Batch);
    AddXMLNode(node , 'Autoallocbin'        , Autoallocbin);
    AddXMLNode(node , 'AutoAllocBatch'      , AutoAllocBatch);
    AddXMLNode(node , 'SnTracking'          , SnTracking);
    AddXMLNode(node , 'SpecialDiscount'     , SpecialDiscount);
    AddXMLNode(node , 'Volume'              , Volume);
    AddXMLNode(node , 'AutoReorder'         , AutoReorder);
    AddXMLNode(node , 'ProductOptions'      , HasProductOptions);
    AddXMLNode(node , 'OnSpecial'           , OnSpecial);
    AddXMLNode(node , 'AutoSmartOrder'      , AutoSmartOrder);
    AddXMLNode(node , 'RequireSignature'    , RequireSignature);
    AddXMLNode(node , 'ExcludeFromSmartOrder', ExcludeFromSmartOrder);
    AddXMLNode(node , 'HideWastage', HideWastage);
    AddXMLNode(node , 'RequiresAssembly'    , RequiresAssembly);
    AddXMLNode(node , 'IncludeInAnalysis'   , IncludeInAnalysis);
    AddXMLNode(node , 'HideOnPrint'         , HideOnPrint);
    AddXMLNode(node , 'HideonPickSlip'      , HideonPickSlip);
    AddXMLNode(node , 'HideonDelDocket'     , HideonDelDocket);
    AddXMLNode(node , 'PDAMinSellQty'       , PDAMinSellQty);
    AddXMLNode(node , 'ProductComment'      ,  ProductComment);
    AddXMLNode(node , 'ProductionNotes'      ,  ProductionNotes);
    AddXMLNode(node , 'GeneralNotes'      ,  GeneralNotes);
    AddXMLNode(node , 'PRODUCTCODE'         ,  PRODUCTCODE);
    AddXMLNode(node , 'BarCode'             ,  BarCode);
    AddXMLNode(node , 'isEquipment'         ,  isEquipment);
    AddXMLNode(node , 'CUSTFLD1'         ,  CustFld1);
    AddXMLNode(node , 'CUSTFLD2'         ,  CustFld2);
    AddXMLNode(node , 'CUSTFLD3'         ,  CustFld3);
    AddXMLNode(node , 'CUSTFLD4'         ,  CustFld4);
    AddXMLNode(node , 'CUSTFLD5'         ,  CustFld5);
    AddXMLNode(node , 'CUSTFLD6'         ,  CustFld6);
    AddXMLNode(node , 'CUSTFLD7'         ,  CustFld7);
    AddXMLNode(node , 'CUSTFLD8'         ,  CustFld8);
    AddXMLNode(node , 'CUSTFLD9'         ,  CustFld9);
    AddXMLNode(node , 'CUSTFLD10'         ,  CustFld10);
    AddXMLNode(node , 'CUSTFLD11'         ,  CustFld11);
    AddXMLNode(node , 'CUSTFLD12'         ,  CustFld12);
    AddXMLNode(node , 'CUSTFLD13'         ,  CustFld13);
    AddXMLNode(node , 'CUSTFLD14'         ,  CustFld14);
    AddXMLNode(node , 'CUSTFLD15'         ,  CustFld15);
    AddXMLNode(node , 'CUSTDATE1'         ,  CustDate1);
    AddXMLNode(node , 'CUSTDATE2'         ,  CustDate2);
    AddXMLNode(node , 'CUSTDATE3'         ,  CustDate3);
    AddXMLNode(node , 'PartCalcformulaField'       ,PartCalcformulaField);
    AddXMLNode(node , 'PartCalcformula' ,PartCalcformula);
	  AddXMLNode(node , 'PartCalcformulaUOM'    ,PartCalcformulaUOM);
	  AddXMLNode(node , 'PartCalcformulaUOMID'  ,PartCalcformulaUOMID);
	  AddXMLNode(node , 'PartCalcFormulaMult',PartCalcFormulaMult);
    AddXMLNode(node , 'PartCalcformulaUOMMult',PartCalcformulaUOMMult);
    AddXMLNode(node , 'DangerousProduct',DangerousProduct);
    AddXMLNode(node , 'Reqdinsurance',Reqdinsurance );
    AddXMLNode(node , 'InsuranceAmount',InsuranceAmount );
    AddXMLNode(node , 'AreaCoverageofsingleQty',AreaCoverageofsingleQty );
    AddXMLNode(node , 'UndeliveredAction',UndeliveredAction);
    AddXMLNode(node , 'Tariffcode',Tariffcode );
    AddXMLNode(node , 'consignmentProducttype',consignmentProducttype );
    AddXMLNode(node , 'Productclassification',Productclassification );
    AddXMLNode(node , 'LockExtraSell',LockExtraSell );
    AddXMLNode(node , 'ManLatestCost'       , ManLatestCost);
    AddXMLNode(node , 'ManAverageCost'       , ManAverageCost);
    AddXMLNode(node , 'ProductMarkupPrice'       , ProductMarkupPrice);
    AddXMLNode(node , 'ProductMarkupPricePercent'       , ProductMarkupPricePercent);
    AddXMLNode(node , 'ManLatestCostDate'   , ManLatestCostDate);
    AddXMLNode(node , 'ProductPriceCalctype'  ,ProductPriceCalctype);
    AddXMLNode(node , 'DefaultWarrantyDuration'  ,DefaultWarrantyDuration);
    AddXMLNode(node , 'Multibuy'    , Multibuy);
    AddXMLNode(node , 'EnablePackWeight'    , EnablePackWeight);
    AddXMLNode(node , 'IsOTFProduct'    , IsOTFProduct);
    AddXMLNode(node , 'LineNo'  ,LineNo);
    AddXMLNode(node , 'Hyperlink'  ,Hyperlink);
    AddXMLNode(node , 'SalesTaxBasedon'  ,SalesTaxBasedon);
    AddXMLNode(node , 'PublishOnVS1'    , PublishOnVS1);
end;


function TProductSimple.ValidateData: Boolean ;
var
  s: string;
  CleanProductName: string;
begin
    result := inherited ValidateData;
    if not result then Exit;
    CleanProductName:= GetXMLNodeStringValue(CleanXMLNode, 'ProductName');
    Result := False;
    ResultStatus.Clear;

    if Self.ProductName = '' then begin
        s := 'Product Name cannot be blank.';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
    end;
    if (CleanProductName <> '') and (CleanProductName <> ProductName) then begin
        s := 'Product Name cannot be changed for and existing record.';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
    end;

    if (ProductType <> 'INV') and (ProductType <> 'NONINV') and (ProductType <> 'OTHER') then begin
        s := 'Product Type must be INV, NONINV or OTHER, current value "' + ProductType + '" is not valid.';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
    end;

    Self.PostDB;
    if not ProductNameUnique() then begin
        s :='Product already exists with this name, name cannot be duplicate.';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
    end;
    if not TProductType.IsValidTypeCode(ProductType) then begin
        s :='Product Type "' + ProductType + '" is invalid';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
    end;
    if CogsAccount = ''  then begin
        s :='Product COGS Account should not be blank';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
    end;
    if GetAccountID(CogsAccount) = 0 then begin
        s :='Product COGS Account '+ CogsAccount + ' is invalid';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
    end;

    if IncomeAccount = ''  then begin
        s :='Product income Account should not be blank';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
    end;
    if GetAccountID(IncomeAccount) = 0 then begin
        s :='Product Income Account '+ IncomeAccount + ' is invalid';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
    end;
    if AssetAccount = ''  then begin
        s :='Product Asset Account should not be blank';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
    end;
    if GetAccountID(AssetAccount) = 0 then begin
        s :='Product Asset Account '+ AssetAccount + ' is invalid';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
    end;

    if TaxCodeSales = ''  then begin
        s :='Product Sales Tax code should not be blank';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
    end
    else if TaxSales.Count = 0 then begin
        s :='Product Sales Tax code "' + TaxCodeSales + '" is invalid';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
    end;

    if TaxCodePurchase = ''  then begin
        s :='Product Purchase Tax code should not be blank';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
    end
    else if TaxPurchase.Count = 0 then begin
        s :='Product Purchase Tax code "' + TaxCodePurchase + '" is invalid';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
    end;
    if FormulaID < 0 then begin
      AddResult(false, rssWarning, 0, 'Formula not found');
      Exit;
    end;
    if PreferedSupplierName <> '' then begin
      if TSupplier.IDToggle(PreferedSupplierName, Connection.Connection) = 0 then begin
        self.AddResult(false, rssWarning, 0, 'Preferred Supplier "' + PreferedSupplierName + '" not found');
        Exit;
      end;
    end;

    if (UOMtobeUsedinManufacture <> 'P') and (UOMtobeUsedinManufacture <> 'S') then begin
        s:= 'UOMtobeUsedInManufacture should be either "P" or "S"';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
    end;

    if (ProductType <> 'INV') and SnTracking then begin
      s := 'Serial Number Tracking can only be enabled for Inventory Type products';
      AddResult(false, rssWarning, BOR_Product_Err_Main, s);
      Exit;
    end;


    if (BuyQty1Cost <> 0) or (BuyQty2Cost <> 0) or (BuyQty3Cost <> 0) then begin
      if (BuyQty1Cost = 0) then begin
        s:='Product Cost 1 should have a value';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end
      else if (BuyQty2Cost = 0) then begin
        s:='Product Cost 2 should have a value';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end
      else if (BuyQty3Cost = 0) then begin
        s:='Product Cost 3 should have a value';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end
    end;
    if (BuyQty1CostInc <> 0) or (BuyQty2CostInc <> 0) or (BuyQty3CostInc <> 0) then begin
      if (BuyQty1CostInc = 0) then begin
        s:='Product Cost 1 Inc should have a value';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end
      else if (BuyQty2CostInc = 0) then begin
        s:='Product Cost 2 Inc should have a value';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end
      else if (BuyQty3CostInc = 0) then begin
        s:='Product Cost 3 Inc should have a value';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end
    end;
    if (SellQty1Price <> 0) or (SellQty2Price <> 0) or (SellQty3Price <> 0) then begin
      if (SellQty1Price = 0) then begin
        s:='Product Price 1 should have a value';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end
      else if (SellQty2Price = 0) then begin
        s:='Product Price 2 should have a value';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end
      else if (SellQty3Price = 0) then begin
        s:='Product Price 3 should have a value';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end
    end;
    if (SellQty1PriceInc <> 0) or (SellQty2PriceInc <> 0) or (SellQty3PriceInc <> 0) then begin
      if (SellQty1PriceInc = 0) then begin
        s:='Product Price 1 Inc should have a value';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end
      else if (SellQty2PriceInc = 0) then begin
        s:='Product Price 2 Inc should have a value';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end
      else if (SellQty3PriceInc = 0) then begin
        s:='Product Price 3 Inc should have a value';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end
    end;

    if (ProductType = 'INV') and (not Active) then begin
      if (GetQtyQuery.FieldByName('InstockQty').AsFloat <> 0) then begin
        s:= 'This product can''t be made Inactive, there is stock on hand';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end
      else if (GetQtyQuery.FieldByName('SOQty').AsFloat <> 0) then begin
        s:= 'This product can''t be made Inactive, there is stock allocated to Sales Orders';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end
      else if (GetQtyQuery.FieldByName('AllocatedBOQty').AsFloat <> 0) then begin
        s:= 'This product can''t be made Inactive, there is stock allocated to Invoice back orders';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end
      else if (GetQtyQuery.FieldByName('POBOQty').AsFloat <> 0) then begin
        s:= 'This product can''t be made Inactive, there is stock on order';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end
      else if (GetQtyQuery.FieldByName('SOBOQty').AsFloat <> 0) then begin
        s:= 'This product can''t be made Inactive, there is stock allocated to Sales Order back orders';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end;
    end;
    if (fsFormulaname <> '') and (Formulaid =0 ) then begin
        s:= 'Formula Name ' + fsFormulaname + ' is not unique in the Formula Entry List';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
    end;

    if not ValidateSubObject(ExtraBuyPrice) then exit;
    if not ValidateSubObject(ExtraSellPrice) then exit;
    if not ValidateSubObject(ForeignPriceBuy) then exit;
    if not ValidateSubObject(ForeignPriceSell) then exit;
    if not ValidateSubObject(Pictures) then exit;
    if not ValidateSubObject(ProductProcessPart) then exit;
    if not ValidateSubObject(ProductSpecs) then exit;
    if not validatePartCalcformulaField then exit;
//    if not ValidateSubObject(TaxPurchase) then exit;
//    if not ValidateSubObject(TaxSales) then exit;
//    if not ValidateSubObject(UOMList) then exit;

    Result := True;
end;


function TProductSimple.Validateformula: Boolean;
var
  Parser: TMathParser;
begin
  Parser := TMathParser.Create(Self);
  try
    Parser.OnGetVar := DoSearchPartCalcformulaFieldVar;
    Parser.ParseString := PartCalcformulaField;
    Parser.Parse;
    if Parser.ParseError then begin
      Result := False;
      ResultStatus.AddItem(False, rssWarning, 0, Parser.ErrorMessage);
      Exit;
    end;
    Result := True;
  finally
    freeandNil(Parser);
  end;
end;

function TProductSimple.ValidatePartCalcformulaField: Boolean;
begin
    result := False;
    if PartCalcformulaField <> '' then begin
      if not Validateformula then Exit;
      if (PartCalcformulaUOM = '') or (PartCalcformulaUOMID =0) or (PartCalcformulaUOMMult =0) then begin
        AddResult(False, rssWarning, 0, 'Product Has the formula to Calculate the quantity and the unit of meassure is blank');
        Exit;
      end;
   end;
   result := true;
   if not RawMode then
     PartCalcffieldsToformula;

end;

function TProductSimple.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  DeleteProductSubObjects;


  Result := inherited Save;
  if not result then
    exit;
  ProductClass.IterateRecords(UpdateProductNameinProductClass);
  {classes should be created only for the first time when the product is created}
  if Productclass.Dataset.Recordcount = 0 then begin
    if Appenv.DefaultClass.ClassID <> 0 then begin
       if not ProductClass.Dataset.Locate('ClassId' , Appenv.DefaultClass.ClassID, []) then begin
          Productclass.New;
          Productclass.DeptName     := Appenv.DefaultClass.DefaultClassName;
          ProductClass.ProductId    := Self.ID;
          Productclass.PostDB;
        end;
    end;
  end;
end;
procedure TProductSimple.DeleteProductSubObjectsCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if Sender is TServices then begin
    if TServices(Sender).Active <> Self.Active then begin
      Connection.beginnestedtransaction;
      try
        TServices(Sender).Active := Self.Active;
        TServices(Sender).PostDB;
        if not TServices(Sender).Save then begin
          Connection.rollbacknestedtransaction;
          Exit;
        end;
        Connection.commitnestedtransaction;
      Except
        Connection.rollbacknestedtransaction;
      end;
    end;
  end;
end;
procedure TProductSimple.DeleteProductSubObjects;
begin
  if (Active) or (active= GetXMLNodeBooleanValue(CleanXMLNode, 'Active')) then Exit;
  Services.Iteraterecords(DeleteProductSubObjectsCallback);
end;
procedure TProductSimple.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;
procedure TProductSimple.PartCalcffieldsToformula;
var
  s:STring;
begin
  s:= PartCalcformulaField;
  s:= replacestr(s , appenv.CompanyPrefs.PartCalcField1Name, 'Field1');
  s:= replacestr(s , appenv.CompanyPrefs.PartCalcField2Name, 'Field2');
  s:= replacestr(s , appenv.CompanyPrefs.PartCalcField3Name, 'Field3');
  s:= replacestr(s , appenv.CompanyPrefs.PartCalcField4Name, 'Field4');
  s:= replacestr(s , appenv.CompanyPrefs.PartCalcField5Name, 'Field5');
  if not (SameText(PartCalcformula, s)) then begin
    PartCalcformula := s;
    PostDB;
  end;
end;

function TProductSimple.ProductAlreadyHasAllocation: Boolean;
begin
  result := ProductHasAllocation(ID);
  if result then begin
    ResultStatus.AddItem(False, rssWarning, 0 , 'Serial No''s / Batches / Bins already Exist For This Product - Cannot change Allocation for this product !' , true);
    Exit;
  end;
end;

function TProductSimple.ProductNameUnique: Boolean;
var
    strSql :String;
begin
    strSql := 'Select PArtsId from tblParts where PartName = ' +
        quotedStr(Self.ProductName) + ' and PartsId <> ' + IntToStr(Self.ID);
    with getNewDataset(strSQL) DO trY
        Result := RecordCount = 0;
    finally
        if Active then Close;
        Free;
    end;
end;


procedure TProductSimple.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.fieldName, 'Partname') then begin
    if ProductName <> trim(ProductName) then begin
      ProductName :=trim(ProductName) ;
      PostDB;
    end;
  end;
end;


procedure TProductSimple.DoSearchPartCalcformulaFieldVar(Sender: TObject;
  const VarName: string; var Value: extended; var FieldFound: Boolean);
begin
  FieldFound :=  Sametext (trim(VarName) , Appenv.CompanyPrefs.PartCalcField1Name) or
                 Sametext (trim(VarName) , Appenv.CompanyPrefs.PartCalcField2Name) or
                 Sametext (trim(VarName) , Appenv.CompanyPrefs.PartCalcField3Name) or
                 Sametext (trim(VarName) , Appenv.CompanyPrefs.PartCalcField4Name) or
                 Sametext (trim(VarName) , Appenv.CompanyPrefs.PartCalcField5Name);

end;

function TProductSimple.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProductSimple.GetIDField: string;
begin
  Result := 'PARTSID'
end;


class function TProductSimple.GetBusObjectTablename: string;
begin
  Result:= 'tblparts';
end;


function TProductSimple.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not(Result) then exit;
  DocumentPath := Appenv.DocPath.DocumentPath;
  ProductType := 'INV';

        if not Empty(GetAccountName(AppEnv.CompanyPrefs.DefPartsCOGSAccount)) then
             CogsAccount := GetAccountName(AppEnv.CompanyPrefs.DefPartsCOGSAccount)
        else CogsAccount := GLACCOUNT_COGS;

        if not Empty(GetAccountName(AppEnv.CompanyPrefs.DefPartsIncomeAccount)) then
             IncomeAccount := GetAccountName(AppEnv.CompanyPrefs.DefPartsIncomeAccount)
        else IncomeAccount := GLACCOUNT_SALES;
        if not Empty(GetAccountName(AppEnv.CompanyPrefs.DefPartsAssetAccount)) then
             AssetAccount := GetAccountName(AppEnv.CompanyPrefs.DefPartsAssetAccount)
        else AssetAccount := GLACCOUNT_INVASST;
        DateCreated       := Now;
        Active            := TRue;
        AutoReorder       := true;
        HasProductOptions := false;
        TaxCodePurchase   := appenv.CompanyPrefs.DefaultPurchaseTaxCode;
        TaxCodeSales      := appenv.CompanyPrefs.DefaultSalesTaxCode;
        BuyQTY1           := 1;
        BuyQTY2           := 1;
        BuyQTY3           := 1;
        BuyQty1Cost       := 0.00;
        BuyQty2Cost       := 0.00;
        BuyQty3Cost       := 0.00;
        BuyQty1Costinc    := 0.00;
        BuyQty2Costinc    := 0.00;
        BuyQty3Costinc    := 0.00;
        SellQTY3          := 1;
        SellQTY2          := 1;
        SellQTY1          := 1;
        SellQty1Price     := 0;
        SellQty2Price     := 0;
        SellQty3Price     := 0;
        SellQty1PriceInc  := 0;
        SellQty2PriceInc  := 0;
        SellQty3PriceInc  := 0;
        AverageCost       := 0;
        PublishOnVS1      := False;
end;

function TProductSimple.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  if not fbIgnoreBarcodeUpdate then begin
    if barcode <> '' then begin
      if ProductBarcodes.barcode <> barcode then
        if not ProductBarcodes.locate('BarCode' , Barcode , []) then begin
          ProductBarcodes.New;
          ProductBarcodes.barcode := Barcode;
        end;
      if not ProductBarcodes.IsprimaryBarcode  then begin
        ProductBarcodes.IsprimaryBarcode := True;
        ProductBarcodes.PostDb;
      end;
    end;
  end;
end;
class function TProductSimple.GetKeyStringField: string;
begin
    Result := 'Partname';
end;
function TProductSimple.isOktoSet(const TagName: String): Boolean;
begin
  REsult := True;
end;
function TProductSimple.GetAvailableQty   : Double;begin  result := GetQtyQuery.FieldByName('AvailableQty').AsFloat  ; end;
function TProductSimple.GetAllocatedBOQty : Double;begin  result := GetQtyQuery.FieldByName('AllocatedBOQty').AsFloat; end;
function TProductSimple.GetSOQty          : Double;begin  result := GetQtyQuery.FieldByName('SOQty').AsFloat         ; end;
function TProductSimple.GetSOBOQty        : Double;begin  result := GetQtyQuery.FieldByName('SOBOQty').AsFloat       ; end;
function TProductSimple.GetInstockQty     : Double;begin  result := GetQtyQuery.FieldByName('InstockQty').AsFloat    ; end;
function TProductSimple.GetPOBOQty        : Double;begin  result := GetQtyQuery.FieldByName('POBOQty').AsFloat       ; end;
Function TProductSimple.getPQAtimestamp   : TDatetime;begin  result := GetQtyQuery.FieldByName('msTimeStamp').asDateTime       ; end;
function TProductSimple.GetQtyQuery: TERPQuery;
begin
  REsult := GetQtyQuery('');
end;
function TProductSimple.GetQtyQuery(const FilterCondition:String): TERPQuery;
begin
  if not Assigned(fQtyQuery) then begin
    fQtyQuery:= TempMyquery;
    fQtyQuery.connection := self.Connection.Connection;
    fQtyQuery.SQL.add('Select distinct PQA.ProductID, ');
    //fQtyQuery.SQL.add('PQA.DepartmentID, ');
    fQtyQuery.SQL.add('Round(' + ProductQtyLib.SQL4Qty( tAvailable ) + ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as AvailableQty, ');
    fQtyQuery.SQL.add('Round(' + ProductQtyLib.SQL4Qty( tInvBO     ) + ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as AllocatedBOQty, ');
    fQtyQuery.SQL.add('Round(' + ProductQtyLib.SQL4Qty( tSO        ) + ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as SOQty, ');
    fQtyQuery.SQL.add('Round(' + ProductQtyLib.SQL4Qty( tSOBO      ) + ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as SOBOQty, ');
    fQtyQuery.SQL.add('Round(' + ProductQtyLib.SQL4Qty( tInStock   ) + ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as InstockQty, ');
    fQtyQuery.SQL.add('Round(' + ProductQtyLib.SQL4Qty( tPOBO      ) + ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as POBOQty ,');
    fQtyQuery.SQL.add('max(pqa.mstimestamp) as mstimestamp');
    fQtyQuery.SQL.add('from tblPQA as PQA where PQA.ProductID = :ProductID');
    if FilterCondition <> '' then fQtyQuery.SQL.add(' and ' + FilterCondition);
    fQtyQuery.SQL.add('group by PQA.ProductID');
    //fQtyQuery.SQL.add(', PQA.DepartmentID');
  end;
  if fQtyQuery.ParamByName('ProductID').AsInteger <> ID  then begin
      if fQtyQuery.Active then fQtyQuery.close;
      fQtyQuery.ParamByName('ProductID').AsInteger:= ID;
  end;
  if fQtyQuery.Active = false then fQtyQuery.Open;
  result:= fQtyQuery;
end;
function TProductSimple.GetRunningAvailableQty   : Double;begin  result := GetRunningQtyQuery.FieldByName('AvailableQty').AsFloat  ; end;
function TProductSimple.GetRunningAllocatedBOQty : Double;begin  result := GetRunningQtyQuery.FieldByName('AllocatedBOQty').AsFloat; end;
function TProductSimple.GetRunningSOQty          : Double;begin  result := GetRunningQtyQuery.FieldByName('SOQty').AsFloat         ; end;
function TProductSimple.GetRunningSOBOQty        : Double;begin  result := GetRunningQtyQuery.FieldByName('SOBOQty').AsFloat       ; end;
function TProductSimple.GetRunningInstockQty     : Double;begin  result := GetRunningQtyQuery.FieldByName('InstockQty').AsFloat    ; end;
function TProductSimple.GetRunningPOBOQty        : Double;begin  result := GetRunningQtyQuery.FieldByName('POBOQty').AsFloat       ; end;
Function TProductSimple.getRunningPQAtimestamp   : TDatetime;begin  result := GetRunningQtyQuery.FieldByName('msTimeStamp').asDatetime; end;
function TProductSimple.GetRunningQtyQuery: TERPQuery;
begin
  REsult := GetRunningQtyQuery('');
end;
function TProductSimple.GetRunningQtyQuery(const FilterCondition:String): TERPQuery;
begin
  if Appenv.companyprefs.DoUpdateProductQtySum then begin
    if not Assigned(fRunningQtyQuery) then begin
      fRunningQtyQuery:= TempMyquery;
      fRunningQtyQuery.connection := self.Connection.Connection;
      fRunningQtyQuery.SQL.add('Select distinct PQA.ProductID, ');
      //fRunningQtyQuery.SQL.add('PQA.DepartmentID, ');
      fRunningQtyQuery.SQL.add('Round(Available, '    + IntToStr(tcConst.GeneralRoundPlaces)+') as AvailableQty, ');
      fRunningQtyQuery.SQL.add('Round(InvBO, '        + IntToStr(tcConst.GeneralRoundPlaces)+') as AllocatedBOQty, ');
      fRunningQtyQuery.SQL.add('Round(AllocatedSO, '  + IntToStr(tcConst.GeneralRoundPlaces)+') as SOQty, ');
      fRunningQtyQuery.SQL.add('Round(SOBO, '         + IntToStr(tcConst.GeneralRoundPlaces)+') as SOBOQty, ');
      fRunningQtyQuery.SQL.add('Round(InStock, '      + IntToStr(tcConst.GeneralRoundPlaces)+') as InstockQty, ');
      fRunningQtyQuery.SQL.add('Round(POBO, '         + IntToStr(tcConst.GeneralRoundPlaces)+') as POBOQty ,');
      fRunningQtyQuery.SQL.add('max(pqa.mstimestamp) as mstimestamp');
      fRunningQtyQuery.SQL.add('from tblproductQtysum as PQA where PQA.ProductID = :ProductID');
      if FilterCondition <> '' then fRunningQtyQuery.SQL.add(' and ' + FilterCondition);
      fRunningQtyQuery.SQL.add('group by PQA.ProductID');
      //fRunningQtyQuery.SQL.add(', PQA.DepartmentID');
    end;
    if fRunningQtyQuery.ParamByName('ProductID').AsInteger <> ID  then begin
        if fRunningQtyQuery.Active then fRunningQtyQuery.close;
        fRunningQtyQuery.ParamByName('ProductID').AsInteger:= ID;
    end;
    if fRunningQtyQuery.Active = false then fRunningQtyQuery.Open;
    result:= fRunningQtyQuery;
  end else begin
    result := GetQtyQuery(FilterCondition);
  end;
end;



function TProductSimple.GetDocumentPath: string;
begin
  result := GetStringField('DocumentPath');
end;
function TProductSimple.GetProductClass: TProductClass;
begin
  result := TProductClass(getContainercomponent(TProductClass , 'ProductID = ' + IntToStr(self.ID)));
end;
function TProductSimple.getService: TServices;
begin
  result := TServices(getContainercomponent(TServices , 'ProductID = ' + IntToStr(self.ID)));
end;

procedure TProductSimple.UpdateProductNameinProductClass(const Sender: TBusObj;
  var Abort: Boolean);
var
  msg:String;
begin
   if not (Sender is TProductClass) then Exit;
   if not IsOwnerProduct(Sender) then Exit;

   if TProductClass(Sender).ProductName <> OwnerProductname(TProductClass(Sender)) then begin
      if TProductClass(Sender).Lock then begin
        Try
          TProductClass(Sender).ProductName := OwnerProductname(TProductClass(Sender));
          TProductClass(Sender).PostDB;
        Finally
            TProductClass(Sender).unlock;
        End;
       end else begin
            msg := 'Unable to update ' + OwnerProductname(Self) + '''s class record as it is being updated by "' +
                TProductClass(Sender).UserLock.LockInfo.UserName + '" with: ' + TProductClass(Sender).UserLock.LockInfo.LockingForm;
            AddResult(true, rssWarning, 1, msg );
       end;
   End;
end;

{Property Functions}
function  TProductSimple.GetPARTTYPE                           : string    ; begin Result := GetStringField('PARTTYPE');end;
function  TProductSimple.GetPRODUCTGROUP                       : string    ; begin Result := GetStringField('PRODUCTGROUP');end;
function  TProductSimple.GetPartname                           : string    ; begin Result := GetStringField('PARTNAME');end;
function  TProductSimple.GetProductPrintName                   : string    ; begin Result := GetStringField('ProductPrintName');end;
function  TProductSimple.GetPARTSDESCRIPTION                   : string    ; begin Result := GetStringField('PARTSDESCRIPTION');end;
function  TProductSimple.GetSKU                                : string    ; begin Result := GetStringField('SKU');end;
function  TProductSimple.GetPARTSDESCRIPTION_Memo              : string    ; begin Result := GetStringField('PARTSDESCRIPTION_Memo');end;
function  TProductSimple.GetPURCHASEDESC_Memo                  : string    ; begin Result := GetStringField('PURCHASEDESC_Memo');end;
function  TProductSimple.GetPURCHASEDESC                       : string    ; begin Result := GetStringField('PURCHASEDESC');end;
function  TProductSimple.GetINCOMEACCNT                        : string    ; begin Result := GetStringField('INCOMEACCNT');end;
function  TProductSimple.GetASSETACCNT                         : string    ; begin Result := GetStringField('ASSETACCNT');end;
function  TProductSimple.GetCOGSACCNT                          : string    ; begin Result := GetStringField('COGSACCNT');end;
function  TProductSimple.GetBARCODE                            : string    ; begin Result := GetStringField('BARCODE');end;
function  TProductSimple.GetPRODUCTCODE                        : string    ; begin Result := GetStringField('PRODUCTCODE');end;
function  TProductSimple.GetTAXCODE                            : string    ; begin Result := GetStringField('TAXCODE');end;
function  TProductSimple.GetPURCHTAXCODE                       : string    ; begin Result := GetStringField('PURCHTAXCODE');end;
function  TProductSimple.GetPREFEREDSUPP                       : string    ; begin Result := GetStringField('PREFEREDSUPP');end;
function  TProductSimple.GetSpecialDiscount                    : Boolean   ; begin Result := GetBooleanField('SpecialDiscount');end;
function  TProductSimple.GetSNTracking                         : Boolean   ; begin Result := GetBooleanField('SNTracking');end;
function  TProductSimple.GetMultipleBins                       : Boolean   ; begin Result := GetBooleanField('MultipleBins');end;
function  TProductSimple.Getbatch                              : Boolean   ; begin Result := GetBooleanField('batch');end;
function  TProductSimple.GetAutoBatch                          : Boolean   ; begin Result := GetBooleanField('AutoBatch');end;
function  TProductSimple.GetAutoReorder                        : Boolean   ; begin Result := GetBooleanField('AutoReorder');end;
function  TProductSimple.GetProductOptions                     : Boolean   ; begin Result := GetBooleanField('HasProductOptions');end;
function  TProductSimple.GetBuyQTY1                            : Integer   ; begin Result := GetIntegerField('BuyQTY1');end;
function  TProductSimple.GetBuyQTY2                            : Integer   ; begin Result := GetIntegerField('BuyQTY2');end;
function  TProductSimple.GetBuyQTY3                            : Integer   ; begin Result := GetIntegerField('BuyQTY3');end;
function  TProductSimple.GetCOST1                              : Double    ; begin Result := GetFloatField('COST1');end;
function  TProductSimple.GetCOST2                              : Double    ; begin Result := GetFloatField('COST2');end;
function  TProductSimple.GetCOST3                              : Double    ; begin Result := GetFloatField('COST3');end;
function  TProductSimple.GetAvgCost                            : Double    ; begin Result := GetFloatField('AvgCost');end;
function  TProductSimple.GetCOSTINC1                           : Double    ; begin Result := GetFloatField('COSTINC1');end;
function  TProductSimple.GetCOSTINC2                           : Double    ; begin Result := GetFloatField('COSTINC2');end;
function  TProductSimple.GetCOSTINC3                           : Double    ; begin Result := GetFloatField('COSTINC3');end;
function  TProductSimple.GetSellQTY1                           : Integer   ; begin Result := GetIntegerField('SellQTY1');end;
function  TProductSimple.GetSellQTY2                           : Integer   ; begin Result := GetIntegerField('SellQTY2');end;
function  TProductSimple.GetSellQTY3                           : Integer   ; begin Result := GetIntegerField('SellQTY3');end;
function  TProductSimple.GetPRICE1                             : Double    ; begin Result := GetFloatField('PRICE1');end;
function  TProductSimple.GetPRICE2                             : Double    ; begin Result := GetFloatField('PRICE2');end;
function  TProductSimple.GetPRICE3                             : Double    ; begin Result := GetFloatField('PRICE3');end;
function  TProductSimple.GetPRICEINC1                          : Double    ; begin Result := GetFloatField('PRICEINC1');end;
function  TProductSimple.GetPRICEINC2                          : Double    ; begin Result := GetFloatField('PRICEINC2');end;
function  TProductSimple.GetPRICEINC3                          : Double    ; begin Result := GetFloatField('PRICEINC3');end;
function  TProductSimple.GetOrgPrice1                          : Double    ; begin Result := GetFloatField('OrgPrice1');end;
function  TProductSimple.GetOrgPrice2                          : Double    ; begin Result := GetFloatField('OrgPrice2');end;
function  TProductSimple.GetOrgPrice3                          : Double    ; begin Result := GetFloatField('OrgPrice3');end;
function  TProductSimple.GetWHOLESALEPRICE                     : Double    ; begin Result := GetFloatField('WHOLESALEPRICE');end;
class function TProductSimple.IdForSKU(const aSKU: string; aConnection: TCustomMyConnection = nil; CheckProductname:Boolean =False): Integer;
var
  ProdObj :TProductSimple;
begin
  ProdObj := TProductSimple.createwithNewConn(nil);
  try
    if (aConnection <> nil) and (aConnection.Connected) then ProdObj.connection.connection := aConnection;
    ProdObj.LoadSelect('Sku='+  QuotedStr(aSKU));
    if ProdObj.count>0 then begin
      REsult := ProdObj.ID;
      Exit;
    end;
    if CheckProductname then begin
      ProdObj.LoadSelect('partname='+  QuotedStr(aSKU));
      if ProdObj.count>0 then begin
        if ProdObj.Lock then try
          ProdObj.SKU := aSKU;
          ProdObj.PostDB;
          REsult := ProdObj.ID;
          Exit;
        finally
          ProdObj.UnLock;
        end;
      end;
    end;
  finally
    FreeandNil(ProdObj);
  end;

(*var
  qry: TERPQuery;
begin
  if Assigned(Connection) then
    qry := DbSharedObj.GetQuery(Connection)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Text := 'SELECT PartsId from tblParts where SKU = ' + QuotedStr(aSKU);
    qry.Open;
    result := qry.FieldByName('PartsId').AsInteger;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;*)
end;

function  TProductSimple.GetActive                             : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TProductSimple.GetOrderTime                          : Integer   ; begin Result := GetIntegerField('OrderTime');end;
function  TProductSimple.GetManufactureTime                    : Integer   ; begin Result := GetIntegerField('ManufactureTime');end;
function  TProductSimple.GetOverrunTime                        : Integer   ; begin Result := GetIntegerField('OverrunTime');end;
function  TProductSimple.GetDuration                           : Integer   ; begin Result := GetIntegerField('Duration');end;
function  TProductSimple.GetProductComment                     : string    ; begin Result := GetStringField('ProductComment');end;
function  TProductSimple.GetAttrib1Sale                        : Double    ; begin Result := GetFloatField('Attrib1Sale');end;
function  TProductSimple.GetAttrib2Sale                        : Double    ; begin Result := GetFloatField('Attrib2Sale');end;
function  TProductSimple.GetAttrib1SaleRate                    : Double    ; begin Result := GetFloatField('Attrib1SaleRate');end;
function  TProductSimple.GetAttrib1Purchase                    : Double    ; begin Result := GetFloatField('Attrib1Purchase');end;
function  TProductSimple.GetAttrib2Purchase                    : Double    ; begin Result := GetFloatField('Attrib2Purchase');end;
function  TProductSimple.GetAttrib1PurchaseRate                : Double    ; begin Result := GetFloatField('Attrib1PurchaseRate');end;
function  TProductSimple.GetSupplierProductCode                : string    ; begin Result := GetStringField('SupplierProductCode');end;
function  TProductSimple.GetRequired                           : Boolean   ; begin Result := GetBooleanField('Required');end;
function  TProductSimple.GetDateCreated                        : TDateTime ; begin Result := GetDateTimeField('DateCreated');end;
function  TProductSimple.GetDateUpdated                        : TDateTime ; begin Result := GetDateTimeField('DateUpdated');end;
function  TProductSimple.GetShowProductPopUp                   : Boolean   ; begin Result := GetBooleanField('ShowProductPopUp');end;
function  TProductSimple.GetShowPurchaseProductPopUp           : Boolean   ; begin Result := GetBooleanField('ShowPurchaseProductPopUp');end;
function  TProductSimple.GetProductPopUpNotes                  : string    ; begin Result := GetStringField('ProductPopUpNotes');end;
function  TProductSimple.GetProductPurchasePopUpNotes          : string    ; begin Result := GetStringField('ProductPurchasePopUpNotes');end;
function  TProductSimple.GetArea                               : string    ; begin Result := GetStringField('Area');end;
function  TProductSimple.GetDiscontinued                       : Boolean   ; begin Result := GetBooleanField('Discontinued');end;
function  TProductSimple.GetOnSpecial                          : Boolean   ; begin Result := GetBooleanField('OnSpecial');end;
function  TProductSimple.GetUseAdvancedMatrix                  : Boolean   ; begin Result := GetBooleanField('UseAdvancedMatrix');end;
function  TProductSimple.GetUseHedgingFormula                  : Boolean   ; begin Result := GetBooleanField('UseHedgingFormula');end;
function  TProductSimple.GetOnCostIncrease                     : Boolean   ; begin Result := GetBooleanField('OnCostIncrease');end;
function  TProductSimple.GetOnCostDecrease                     : Boolean   ; begin Result := GetBooleanField('OnCostDecrease');end;
function  TProductSimple.GetCostUpdateFromPurchase             : Boolean   ; begin Result := GetBooleanField('CostUpdateFromPurchase');end;
function  TProductSimple.GetNormalDeliveryTime                 : Double    ; begin Result := GetFloatField('NormalDeliveryTime');end;
function  TProductSimple.GetLastUpdated                        : TDateTime ; begin Result := GetDateTimeField('LastUpdated');end;
function  TProductSimple.GetLatestCost                         : Double    ; begin Result := GetFloatField('LatestCost');end;
function  TProductSimple.GetLatestCostDate                     : TDateTime ; begin Result := GetDateTimeField('LatestCostDate');end;
function  TProductSimple.GetPDAMinSellQty                      : Double    ; begin Result := GetFloatField('PDAMinSellQty');end;
function  TProductSimple.GetLandedCost                         : Double    ; begin Result := GetFloatField('LandedCost');end;
function  TProductSimple.GetIsVariable                         : Boolean   ; begin Result := GetBooleanField('IsVariable');end;
function  TProductSimple.GetIncludeInAnalysis                  : Boolean   ; begin Result := GetBooleanField('IncludeInAnalysis');end;
function  TProductSimple.GetHideOnPrint                        : Boolean   ; begin Result := GetBooleanField('HideOnPrint');end;
function  TProductSimple.GetHideonPickSlip                     : Boolean   ; begin Result := GetBooleanField('HideonPickSlip');end;
function  TProductSimple.GetHideonDelDocket                    : Boolean   ; begin Result := GetBooleanField('HideonDelDocket');end;
function  TProductSimple.GetSell_Cost_Percentage               : Double    ; begin Result := GetFloatField('Sell_Cost_Percentage');end;
function  TProductSimple.GetCreateJobwhenconvert               : Boolean   ; begin Result := GetBooleanField('CreateJobwhenconvert');end;
function  TProductSimple.GetTotalQty                           : Double    ; begin Result := GetFloatField('TotalQty');end;
function  TProductSimple.GetTotalQty_UOM                       : string    ; begin Result := GetStringField('TotalQty_UOM');end;
function  TProductSimple.GetIsSegregatedProduct                : Boolean   ; begin Result := GetBooleanField('IsSegregatedProduct');end;
function  TProductSimple.GetVolume                             : Double    ; begin Result := GetFloatField('Volume');end;
function  TProductSimple.GetAutoBin                            : Boolean   ; begin Result := GetBooleanField('AutoBin');end;
function  TProductSimple.GetAutoSmartOrder                     : Boolean   ; begin Result := GetBooleanField('AutoSmartOrder');end;
function  TProductSimple.GetNetWeightKg                        : Double    ; begin Result := GetFloatField('NetWeightKg');end;
function  TProductSimple.GetCommodityCode                      : string    ; begin Result := GetStringField('CommodityCode');end;
function  TProductSimple.GetisEquipment                        : Boolean   ; begin Result := GetBooleanField('isEquipment');end;
function  TProductSimple.getIsInvProduct                       : Boolean   ; begin  result := sametext(ProductType , 'INV');end;
function  TProductSimple.GetGrossMarginMode                    : Boolean   ; begin Result := GetBooleanField('GrossMarginMode');end;
function  TProductSimple.GetCUSTFLD1                           : string    ; begin Result := GetStringField('CUSTFLD1');end;
function  TProductSimple.GetCUSTFLD2                           : string    ; begin Result := GetStringField('CUSTFLD2');end;
function  TProductSimple.GetCUSTFLD3                           : string    ; begin Result := GetStringField('CUSTFLD3');end;
function  TProductSimple.GetCUSTFLD4                           : string    ; begin Result := GetStringField('CUSTFLD4');end;
function  TProductSimple.GetCUSTFLD5                           : string    ; begin Result := GetStringField('CUSTFLD5');end;
function  TProductSimple.GetCUSTFLD6                           : string    ; begin Result := GetStringField('CUSTFLD6');end;
function  TProductSimple.GetCUSTFLD7                           : string    ; begin Result := GetStringField('CUSTFLD7');end;
function  TProductSimple.GetCUSTFLD8                           : string    ; begin Result := GetStringField('CUSTFLD8');end;
function  TProductSimple.GetCUSTFLD9                           : string    ; begin Result := GetStringField('CUSTFLD9');end;
function  TProductSimple.GetCUSTFLD10                          : string    ; begin Result := GetStringField('CUSTFLD10');end;
function  TProductSimple.GetCUSTFLD11                          : string    ; begin Result := GetStringField('CUSTFLD11');end;
function  TProductSimple.GetCUSTFLD12                          : string    ; begin Result := GetStringField('CUSTFLD12');end;
function  TProductSimple.GetCUSTFLD13                          : string    ; begin Result := GetStringField('CUSTFLD13');end;
function  TProductSimple.GetCUSTFLD14                          : string    ; begin Result := GetStringField('CUSTFLD14');end;
function  TProductSimple.GetCUSTFLD15                          : string    ; begin Result := GetStringField('CUSTFLD15');end;
function  TProductSimple.GetCUSTDATE1                          : TDateTime ; begin Result := GetDateTimeField('CUSTDATE1');end;
function  TProductSimple.GetCUSTDATE2                          : TDateTime ; begin Result := GetDateTimeField('CUSTDATE2');end;
function  TProductSimple.GetCUSTDATE3                          : TDateTime ; begin Result := GetDateTimeField('CUSTDATE3');end;
function  TProductSimple.GetProductionNotes                    : string    ; begin Result := GetStringField('ProductionNotes');end;
function  TProductSimple.GetGeneralNotes                       : string    ; begin Result := GetStringField('GeneralNotes');end;
function  TProductSimple.GetDescription                        : string    ; begin Result := GetStringField('Description');end;
function  TProductSimple.GetUOMtobeUsedinManufacture           : string    ; begin Result := GetStringField('UOMtobeUsedinManufacture');end;
function  TProductSimple.GetCountryofOriginID                  : Integer   ; begin Result := GetIntegerField('CountryofOriginID');end;
function  TProductSimple.GetEx_Works                           : Double    ; begin Result := GetFloatField('Ex_Works');end;
function  TProductSimple.GetProductUOMID                       : Integer   ; begin Result := GetIntegerField('ProductUOMID');end;
function  TProductSimple.GetProductUOM                         : string    ; begin Result := GetStringField('ProductUOM');end;
function  TProductSimple.GetExtraSellPriceOverridesAllDiscounts: Boolean   ; begin Result := GetBooleanField('ExtraSellPriceOverridesAllDiscounts');end;
function  TProductSimple.GetLockExtraSell                      : Boolean   ; begin Result := GetBooleanField('LockExtraSell');end;
function  TProductSimple.GetPublishOnWeb                       : Boolean   ; begin Result := GetBooleanField('PublishOnWeb');end;
function  TProductSimple.GetFormulaID                          : Integer   ; begin Result := GetIntegerField('FormulaID');end;
function  TProductSimple.GetPartCalcformula                    : string    ; begin Result := GetStringField('PartCalcformula');end;
function  TProductSimple.GetPartCalcformulaField               : string    ; begin Result := GetStringField('PartCalcformulaField');end;
function  TProductSimple.GetPartCalcformulaUOM                 : string    ; begin Result := GetStringField('PartCalcformulaUOM');end;
function  TProductSimple.GetPartCalcformulaUOMID               : Integer   ; begin Result := GetIntegerField('PartCalcformulaUOMID');end;
function  TProductSimple.GetPartCalcformulaUOMMult             : Double    ; begin Result := GetFloatField('PartCalcformulaUOMMult');end;
function  TProductSimple.GetPartCalcFormulaMult                : Double    ; begin Result := GetFloatField('PartCalcFormulaMult');end;
function  TProductSimple.GetFormulaQtyValue1                   : Double    ; begin Result := GetFloatField('FormulaQtyValue1');end;
function  TProductSimple.GetFormulaQtyValue2                   : Double    ; begin Result := GetFloatField('FormulaQtyValue2');end;
function  TProductSimple.GetFormulaQtyValue3                   : Double    ; begin Result := GetFloatField('FormulaQtyValue3');end;
function  TProductSimple.GetFormulaQtyValue4                   : Double    ; begin Result := GetFloatField('FormulaQtyValue4');end;
function  TProductSimple.GetFormulaQtyValue5                   : Double    ; begin Result := GetFloatField('FormulaQtyValue5');end;
function  TProductSimple.GetFormulaQty                         : Double    ; begin Result := GetFloatField('FormulaQty');end;
function  TProductSimple.GetFormulaQty1                        : Double    ; begin Result := GetFloatField('FormulaQty1');end;
function  TProductSimple.GetFormulaQty2                        : Double    ; begin Result := GetFloatField('FormulaQty2');end;
function  TProductSimple.GetFormulaQty3                        : Double    ; begin Result := GetFloatField('FormulaQty3');end;
function  TProductSimple.GetFormulaQty4                        : Double    ; begin Result := GetFloatField('FormulaQty4');end;
function  TProductSimple.GetFormulaQty5                        : Double    ; begin Result := GetFloatField('FormulaQty5');end;
function  TProductSimple.GetCanDeleteInPOS                     : Boolean   ; begin Result := GetBooleanField('CanDeleteInPOS');end;
function  TProductSimple.GetIsBOMTemplate                      : Boolean   ; begin Result := GetBooleanField('IsBOMTemplate');end;
function  TProductSimple.GetIsSystemProduct                    : Boolean   ; begin Result := GetBooleanField('IsSystemProduct');end;
function  TProductSimple.GetMancostWithLabour                  : Double    ; begin Result := GetFloatField('MancostWithLabour');end;
function  TProductSimple.GetPRODUCTAttrib1                     : Double    ; begin Result := GetFloatField('PRODUCTAttrib1');end;
function  TProductSimple.GetDangerousProduct                   : Boolean   ; begin Result := GetBooleanField('DangerousProduct');end;
function  TProductSimple.GetReqdinsurance                      : Boolean   ; begin Result := GetBooleanField('Reqdinsurance');end;
function  TProductSimple.GetInsuranceAmount                    : Double    ; begin Result := GetFloatField('InsuranceAmount');end;
function  TProductSimple.GetUndeliveredAction                  : string    ; begin Result := GetStringField('UndeliveredAction');end;
function  TProductSimple.GetTariffcode                         : string    ; begin Result := GetStringField('Tariffcode');end;
function  TProductSimple.GetconsignmentProducttype             : string    ; begin Result := GetStringField('consignmentProducttype');end;
function  TProductSimple.GetProductclassification              : string    ; begin Result := GetStringField('Productclassification');end;
function  TProductSimple.GetEnableAutoSplitQtyintoUOMinSales   : Boolean   ; begin Result := GetBooleanField('EnableAutoSplitQtyintoUOMinSales');end;
function  TProductSimple.GetAreaCoverageofsingleQty            : Double    ; begin Result := GetFloatField('AreaCoverageofsingleQty');end;
function  TProductSimple.GetBOMPriceCalculatedfromTree         : Boolean   ; begin Result := GetBooleanField('BOMPriceCalculatedfromTree');end;
function  TProductSimple.GetBOMCostCalculatedFromTree          : Boolean   ; begin Result := GetBooleanField('BOMCostCalculatedFromTree');end;
function  TProductSimple.GetRequiresAssembly                   : Boolean   ; begin Result := GetBooleanField('RequiresAssembly');end;
function  TProductSimple.GetMultibuy                           : Boolean   ; begin Result := GetBooleanField('Multibuy');end;
function  TProductSimple.GetEnablePackWeight                   : Boolean   ; begin Result := GetBooleanField('EnablePackWeight');end;
function  TProductSimple.GetPublishOnVS1                       : Boolean   ; begin Result := GetBooleanField('PublishOnVS1');end;
function  TProductSimple.GetIsOTFProduct                       : Boolean   ; begin Result := GetBooleanField('IsOTFProduct');end;
function  TProductSimple.GetRequireSignature                   : Boolean   ; begin Result := GetBooleanField('RequireSignature');end;
function TProductSimple.getReturnBySea                         : Boolean   ; begin REsult := UndeliveredAction = 'RS'; end;
function TProductSimple.getReturnByAir                         : Boolean   ; begin REsult := UndeliveredAction = 'RA'; end;
function TProductSimple.getabandonGoods                        : Boolean   ; begin REsult := UndeliveredAction = 'A'; end;
function TProductSimple.getReDirBySea                          : Boolean   ; begin REsult := UndeliveredAction = 'DS'; end;
function TProductSimple.getreDirbyAir                          : Boolean   ; begin REsult := UndeliveredAction = 'DA'; end;
function  TProductSimple.GetManAvgCost                         : Double    ; begin Result := GetFloatField('ManAvgCost');end;
function  TProductSimple.GetManLatestCost                      : Double    ; begin Result := GetFloatField('ManLatestCost');end;
function  TProductSimple.GetManLatestCostDate                  : TDateTime ; begin Result := GetDateTimeField('ManLatestCostDate');end;
function  TProductSimple.GetProductPriceCalctype               : Integer   ; begin Result := GetIntegerField('ProductPriceCalctype');end;
function  TProductSimple.GetDefaultWarrantyDuration            : Integer   ; begin Result := GetIntegerField('DefaultWarrantyDuration');end;
function  TProductSimple.GetProductMarkupPrice                 : Double    ; begin Result := GetFloatField('ProductMarkupPrice');end;
function  TProductSimple.GetProductMarkupPricePercent          : Double    ; begin Result := GetFloatField('ProductMarkupPricePercent');end;
function  TProductSimple.GetLineNo                             : Integer   ; begin Result := GetIntegerField('LineNo');end;
function  TProductSimple.GetExcludeFromSmartOrder              : boolean   ; begin Result := GetBooleanField('ExcludeFromSmartOrder');end;
function  TProductSimple.GetHideWastage                        : boolean   ; begin Result := GetBooleanField('HideWastage');end;
function  TProductSimple.GetExternalRef                        : string    ; begin result := GetStringField('ExternalRef');end;
function  TProductSimple.GetHyperlink                          : string    ; begin result := GetStringField('Hyperlink');end;
function  TProductSimple.GetSalesTaxBasedon                         : string    ; begin result := GetStringField('SalesTaxBasedon');end;
function  TProductSimple.GetHasFormulaAttached                 : Boolean   ; begin Result := formulaID>0;end;
function TProductSimple.getSalesTaxBasedonProductPrice              : Boolean   ; begin result := Sametext(SalesTaxBasedon , 'PP');end;
function TProductSimple.getSalesTaxBasedonSalesPrice                : Boolean   ; begin result := Sametext(SalesTaxBasedon , 'SP');end;
function  TProductSimple.GetIsManufactured                     : Boolean   ; begin Result := GetBooleanField('IsManufactured');end;

procedure TProductSimple.SetPRODUCTGROUP                       (const Value: string    ); begin SetStringField('PRODUCTGROUP'                        , Value);end;
procedure TProductSimple.SetPartname                           (const Value: string    ); begin SetStringField('PARTNAME'                            , Value);end;
procedure TProductSimple.SetProductPrintName                   (const Value: string    ); begin SetStringField('ProductPrintName'                    , Value);end;
procedure TProductSimple.SetPARTSDESCRIPTION                   (const Value: string    ); begin SetStringField('PARTSDESCRIPTION'                    , Value);end;
procedure TProductSimple.SetSKU                                (const Value: string    ); begin SetStringField('SKU'                                 , Value);end;
procedure TProductSimple.SetPARTSDESCRIPTION_Memo              (const Value: string    ); begin SetStringField('PARTSDESCRIPTION_Memo'               , Value);end;
procedure TProductSimple.SetPURCHASEDESC_Memo                  (const Value: string    ); begin SetStringField('PURCHASEDESC_Memo'                   , Value);end;
procedure TProductSimple.SetPURCHASEDESC                       (const Value: string    ); begin SetStringField('PURCHASEDESC'                        , Value);end;
procedure TProductSimple.SetINCOMEACCNT                        (const Value: string    ); begin SetStringField('INCOMEACCNT'                         , Value);end;
procedure TProductSimple.SetASSETACCNT                         (const Value: string    ); begin SetStringField('ASSETACCNT'                          , Value);end;
procedure TProductSimple.SetCOGSACCNT                          (const Value: string    ); begin SetStringField('COGSACCNT'                           , Value);end;
procedure TProductSimple.SetBARCODE                            (const Value: string    ); begin SetStringField('BARCODE'                             , Value);end;
procedure TProductSimple.SetPRODUCTCODE                        (const Value: string    ); begin SetStringField('PRODUCTCODE'                         , Value);end;
procedure TProductSimple.SetTAXCODE                            (const Value: string    ); begin SetStringField('TAXCODE'                             , Value);end;
procedure TProductSimple.SetPURCHTAXCODE                       (const Value: string    ); begin SetStringField('PURCHTAXCODE'                        , Value);end;
procedure TProductSimple.SetPREFEREDSUPP                       (const Value: string    ); begin SetStringField('PREFEREDSUPP'                        , Value);end;
procedure TProductSimple.SetSpecialDiscount                    (const Value: Boolean   ); begin SetBooleanField('SpecialDiscount'                     , Value);end;
procedure TProductSimple.SetAutoBatch                          (const Value: Boolean   ); begin SetBooleanField('AutoBatch'                           , Value);end;
procedure TProductSimple.SetAutoReorder                        (const Value: Boolean   ); begin SetBooleanField('AutoReorder'                         , Value);end;
procedure TProductSimple.SetProductOptions                     (const Value: Boolean   ); begin SetBooleanField('HasProductOptions'                   , Value);end;
procedure TProductSimple.SetBuyQTY1                            (const Value: Integer   ); begin SetIntegerField('BuyQTY1'                             , Value);end;
procedure TProductSimple.SetBuyQTY2                            (const Value: Integer   ); begin SetIntegerField('BuyQTY2'                             , Value);end;
procedure TProductSimple.SetBuyQTY3                            (const Value: Integer   ); begin SetIntegerField('BuyQTY3'                             , Value);end;
procedure TProductSimple.SetCOST1                              (const Value: Double    ); begin SetFloatField('COST1'                               , Value);end;
procedure TProductSimple.SetCOST2                              (const Value: Double    ); begin SetFloatField('COST2'                               , Value);end;
procedure TProductSimple.SetCOST3                              (const Value: Double    ); begin SetFloatField('COST3'                               , Value);end;
procedure TProductSimple.SetAvgCost                            (const Value: Double    ); begin SetFloatField('AvgCost'                             , Value);end;
procedure TProductSimple.SetCOSTINC1                           (const Value: Double    ); begin SetFloatField('COSTINC1'                            , Value);end;
procedure TProductSimple.SetCOSTINC2                           (const Value: Double    ); begin SetFloatField('COSTINC2'                            , Value);end;
procedure TProductSimple.SetCOSTINC3                           (const Value: Double    ); begin SetFloatField('COSTINC3'                            , Value);end;
procedure TProductSimple.SetSellQTY1                           (const Value: Integer   ); begin SetIntegerField('SellQTY1'                            , Value);end;
procedure TProductSimple.SetSellQTY2                           (const Value: Integer   ); begin SetIntegerField('SellQTY2'                            , Value);end;
procedure TProductSimple.SetSellQTY3                           (const Value: Integer   ); begin SetIntegerField('SellQTY3'                            , Value);end;
procedure TProductSimple.SetPRICE1                             (const Value: Double    ); begin SetFloatField('PRICE1'                              , Value);end;
procedure TProductSimple.SetPRICE2                             (const Value: Double    ); begin SetFloatField('PRICE2'                              , Value);end;
procedure TProductSimple.SetPRICE3                             (const Value: Double    ); begin SetFloatField('PRICE3'                              , Value);end;
procedure TProductSimple.SetPRICEINC1                          (const Value: Double    ); begin SetFloatField('PRICEINC1'                           , Value);end;
procedure TProductSimple.SetPRICEINC2                          (const Value: Double    ); begin SetFloatField('PRICEINC2'                           , Value);end;
procedure TProductSimple.SetPRICEINC3                          (const Value: Double    ); begin SetFloatField('PRICEINC3'                           , Value);end;
procedure TProductSimple.SetOrgPrice1                          (const Value: Double    ); begin SetFloatField('OrgPrice1'                           , Value);end;
procedure TProductSimple.SetOrgPrice2                          (const Value: Double    ); begin SetFloatField('OrgPrice2'                           , Value);end;
procedure TProductSimple.SetOrgPrice3                          (const Value: Double    ); begin SetFloatField('OrgPrice3'                           , Value);end;
procedure TProductSimple.SetWHOLESALEPRICE                     (const Value: Double    ); begin SetFloatField('WHOLESALEPRICE'                      , Value);end;
procedure TProductSimple.SetRequireSignature                   (const Value: Boolean   ); begin SetBooleanField('RequireSignature'                  , Value);end;
procedure TProductSimple.SetActive                             (const Value: Boolean   ); begin SetBooleanField('Active'                              , Value);end;
procedure TProductSimple.SetOrderTime                          (const Value: Integer   ); begin SetIntegerField('OrderTime'                           , Value);end;
procedure TProductSimple.SetManufactureTime                    (const Value: Integer   ); begin SetIntegerField('ManufactureTime'                     , Value);end;
procedure TProductSimple.SetOverrunTime                        (const Value: Integer   ); begin SetIntegerField('OverrunTime'                         , Value);end;
procedure TProductSimple.SetDuration                           (const Value: Integer   ); begin SetIntegerField('Duration'                            , Value);end;
procedure TProductSimple.SetProductComment                     (const Value: string    ); begin SetStringField('ProductComment'                      , Value);end;
procedure TProductSimple.SetAttrib1Sale                        (const Value: Double    ); begin SetFloatField('Attrib1Sale'                         , Value);end;
procedure TProductSimple.SetAttrib2Sale                        (const Value: Double    ); begin SetFloatField('Attrib2Sale'                         , Value);end;
procedure TProductSimple.SetAttrib1SaleRate                    (const Value: Double    ); begin SetFloatField('Attrib1SaleRate'                     , Value);end;
procedure TProductSimple.SetAttrib1Purchase                    (const Value: Double    ); begin SetFloatField('Attrib1Purchase'                     , Value);end;
procedure TProductSimple.SetAttrib2Purchase                    (const Value: Double    ); begin SetFloatField('Attrib2Purchase'                     , Value);end;
procedure TProductSimple.SetAttrib1PurchaseRate                (const Value: Double    ); begin SetFloatField('Attrib1PurchaseRate'                 , Value);end;
procedure TProductSimple.SetSupplierProductCode                (const Value: string    ); begin SetStringField('SupplierProductCode'                 , Value);end;
procedure TProductSimple.SetRequired                           (const Value: Boolean   ); begin SetBooleanField('Required'                            , Value);end;
procedure TProductSimple.SetDateCreated                        (const Value: TDateTime ); begin SetDateTimeField('DateCreated'                         , Value);end;
procedure TProductSimple.SetDateUpdated                        (const Value: TDateTime ); begin SetDateTimeField('DateUpdated'                         , Value);end;
procedure TProductSimple.SetShowProductPopUp                   (const Value: Boolean   ); begin SetBooleanField('ShowProductPopUp'                    , Value);end;
procedure TProductSimple.SetShowPurchaseProductPopUp           (const Value: Boolean   ); begin SetBooleanField('ShowPurchaseProductPopUp'            , Value);end;
procedure TProductSimple.SetProductPopUpNotes                  (const Value: string    ); begin SetStringField('ProductPopUpNotes'                   , Value);end;
procedure TProductSimple.SetProductPurchasePopUpNotes          (const Value: string    ); begin SetStringField('ProductPurchasePopUpNotes'           , Value);end;
procedure TProductSimple.SetArea                               (const Value: string    ); begin SetStringField('Area'                                , Value);end;
procedure TProductSimple.SetDiscontinued                       (const Value: Boolean   ); begin SetBooleanField('Discontinued'                        , Value);end;
procedure TProductSimple.SetDocumentPath                       (const Value: string    ); begin SetStringField('DocumentPath'                         , Value);end;
procedure TProductSimple.SetOnSpecial                          (const Value: Boolean   ); begin SetBooleanField('OnSpecial'                           , Value);end;
procedure TProductSimple.SetUseAdvancedMatrix                  (const Value: Boolean   ); begin SetBooleanField('UseAdvancedMatrix'                   , Value);end;
procedure TProductSimple.SetUseHedgingFormula                  (const Value: Boolean   ); begin SetBooleanField('UseHedgingFormula'                   , Value);end;
procedure TProductSimple.SetOnCostIncrease                     (const Value: Boolean   ); begin SetBooleanField('OnCostIncrease'                      , Value);end;
procedure TProductSimple.SetOnCostDecrease                     (const Value: Boolean   ); begin SetBooleanField('OnCostDecrease'                      , Value);end;
procedure TProductSimple.SetCostUpdateFromPurchase             (const Value: Boolean   ); begin SetBooleanField('CostUpdateFromPurchase'              , Value);end;
procedure TProductSimple.SetNormalDeliveryTime                 (const Value: Double    ); begin SetFloatField('NormalDeliveryTime'                  , Value);end;
procedure TProductSimple.SetLastUpdated                        (const Value: TDateTime ); begin SetDateTimeField('LastUpdated'                         , Value);end;
procedure TProductSimple.SetLatestCost                         (const Value: Double    ); begin SetFloatField('LatestCost'                          , Value);end;
procedure TProductSimple.SetLatestCostDate                     (const Value: TDateTime ); begin SetDateTimeField('LatestCostDate'                      , Value);end;
procedure TProductSimple.SetPDAMinSellQty                      (const Value: Double    ); begin SetFloatField('PDAMinSellQty'                       , Value);end;
procedure TProductSimple.SetLandedCost                         (const Value: Double    ); begin SetFloatField('LandedCost'                          , Value);end;
procedure TProductSimple.SetIsVariable                         (const Value: Boolean   ); begin SetBooleanField('IsVariable'                          , Value);end;
procedure TProductSimple.SetIncludeInAnalysis                  (const Value: Boolean   ); begin SetBooleanField('IncludeInAnalysis'                   , Value);end;
procedure TProductSimple.SetHideOnPrint                        (const Value: Boolean   ); begin SetBooleanField('HideOnPrint'                         , Value);end;
procedure TProductSimple.SetHideonPickSlip                     (const Value: Boolean   ); begin SetBooleanField('HideonPickSlip'                      , Value);end;
procedure TProductSimple.SetHideonDelDocket                    (const Value: Boolean   ); begin SetBooleanField('HideonDelDocket'                     , Value);end;
procedure TProductSimple.SetSell_Cost_Percentage               (const Value: Double    ); begin SetFloatField('Sell_Cost_Percentage'                , Value);end;
procedure TProductSimple.SetCreateJobwhenconvert               (const Value: Boolean   ); begin SetBooleanField('CreateJobwhenconvert'                , Value);end;
procedure TProductSimple.SetTotalQty                           (const Value: Double    ); begin SetFloatField('TotalQty'                            , Value);end;
procedure TProductSimple.SetTotalQty_UOM                       (const Value: string    ); begin SetStringField('TotalQty_UOM'                        , Value);end;
procedure TProductSimple.SetIsSegregatedProduct                (const Value: Boolean   ); begin SetBooleanField('IsSegregatedProduct'                 , Value);end;
procedure TProductSimple.SetVolume                             (const Value: Double    ); begin SetFloatField('Volume'                              , Value);end;
procedure TProductSimple.SetAutoBin                            (const Value: Boolean   ); begin SetBooleanField('AutoBin'                             , Value);end;
//procedure TProductSimple.SetHasFormulaAttached                 (const Value: Boolean   ); begin SetBooleanField('HasFormulaAttached'                  , Value);end;
procedure TProductSimple.SetAutoSmartOrder                     (const Value: Boolean   ); begin SetBooleanField('AutoSmartOrder'                      , Value);end;
procedure TProductSimple.SetNetWeightKg                        (const Value: Double    ); begin SetFloatField('NetWeightKg'                         , Value);end;
procedure TProductSimple.SetCommodityCode                      (const Value: string    ); begin SetStringField('CommodityCode'                       , Value);end;
procedure TProductSimple.SetisEquipment                        (const Value: Boolean   ); begin SetBooleanField('isEquipment'                         , Value);end;
procedure TProductSimple.SetGrossMarginMode                    (const Value: Boolean   ); begin SetBooleanField('GrossMarginMode'                     , Value);end;
procedure TProductSimple.SetCUSTFLD1                           (const Value: string    ); begin SetStringField('CUSTFLD1'                            , Value);end;
procedure TProductSimple.SetCUSTFLD2                           (const Value: string    ); begin SetStringField('CUSTFLD2'                            , Value);end;
procedure TProductSimple.SetCUSTFLD3                           (const Value: string    ); begin SetStringField('CUSTFLD3'                            , Value);end;
procedure TProductSimple.SetCUSTFLD4                           (const Value: string    ); begin SetStringField('CUSTFLD4'                            , Value);end;
procedure TProductSimple.SetCUSTFLD5                           (const Value: string    ); begin SetStringField('CUSTFLD5'                            , Value);end;
procedure TProductSimple.SetCUSTFLD6                           (const Value: string    ); begin SetStringField('CUSTFLD6'                            , Value);end;
procedure TProductSimple.SetCUSTFLD7                           (const Value: string    ); begin SetStringField('CUSTFLD7'                            , Value);end;
procedure TProductSimple.SetCUSTFLD8                           (const Value: string    ); begin SetStringField('CUSTFLD8'                            , Value);end;
procedure TProductSimple.SetCUSTFLD9                           (const Value: string    ); begin SetStringField('CUSTFLD9'                            , Value);end;
procedure TProductSimple.SetCUSTFLD10                          (const Value: string    ); begin SetStringField('CUSTFLD10'                           , Value);end;
procedure TProductSimple.SetCUSTFLD11                          (const Value: string    ); begin SetStringField('CUSTFLD11'                           , Value);end;
procedure TProductSimple.SetCUSTFLD12                          (const Value: string    ); begin SetStringField('CUSTFLD12'                           , Value);end;
procedure TProductSimple.SetCUSTFLD13                          (const Value: string    ); begin SetStringField('CUSTFLD13'                           , Value);end;
procedure TProductSimple.SetCUSTFLD14                          (const Value: string    ); begin SetStringField('CUSTFLD14'                           , Value);end;
procedure TProductSimple.SetCUSTFLD15                          (const Value: string    ); begin SetStringField('CUSTFLD15'                           , Value);end;
procedure TProductSimple.SetCUSTDATE1                          (const Value: TDateTime ); begin SetDateTimeField('CUSTDATE1'                           , Value);end;
procedure TProductSimple.SetCUSTDATE2                          (const Value: TDateTime ); begin SetDateTimeField('CUSTDATE2'                           , Value);end;
procedure TProductSimple.SetCUSTDATE3                          (const Value: TDateTime ); begin SetDateTimeField('CUSTDATE3'                           , Value);end;
procedure TProductSimple.SetProductionNotes                    (const Value: string    ); begin SetStringField('ProductionNotes'                     , Value);end;
procedure TProductSimple.SetGeneralNotes                       (const Value: string    ); begin SetStringField('GeneralNotes'                        , Value);end;
procedure TProductSimple.SetDescription                        (const Value: string    ); begin SetStringField('Description'                         , Value);end;
procedure TProductSimple.SetUOMtobeUsedinManufacture           (const Value: string    ); begin SetStringField('UOMtobeUsedinManufacture'            , Value);end;
procedure TProductSimple.SetCountryofOriginID                  (const Value: Integer   ); begin SetIntegerField('CountryofOriginID'                   , Value);end;
procedure TProductSimple.SetEx_Works                           (const Value: Double    ); begin SetFloatField('Ex_Works'                            , Value);end;
procedure TProductSimple.SetProductUOMID                       (const Value: Integer   ); begin SetIntegerField('ProductUOMID'                        , Value);end;
procedure TProductSimple.SetProductUOM                         (const Value: string    ); begin SetStringField('ProductUOM'                          , Value);end;
procedure TProductSimple.SetExcludeFromSmartOrder              (const Value: boolean   ); begin  SetBooleanField('ExcludeFromSmartOrder'              , Value);end;
procedure TProductSimple.SetHideWastage                        (const Value: boolean   ); begin  SetBooleanField('HideWastage'                        , Value);end;
procedure TProductSimple.SetExternalRef                        (const Value: string    ); begin  SetStringField('ExternalRef'                         ,Value);end;
procedure TProductSimple.SetHyperlink                          (const Value: string    ); begin  SetStringField('Hyperlink'                           ,Value);end;
procedure TProductSimple.SetSalesTaxBasedon                         (const Value: string    ); begin  SetStringField('SalesTaxBasedon'                          ,Value);end;
procedure TProductSimple.SetExtraSellPriceOverridesAllDiscounts(const Value: Boolean   ); begin SetBooleanField('ExtraSellPriceOverridesAllDiscounts' , Value);end;
procedure TProductSimple.SetLockExtraSell                      (const Value: Boolean   ); begin SetBooleanField('LockExtraSell'                       , Value);end;
procedure TProductSimple.SetPublishOnWeb                       (const Value: Boolean   ); begin SetBooleanField('PublishOnWeb'                        , Value);end;
procedure TProductSimple.SetFormulaID                          (const Value: Integer   ); begin SetIntegerField('FormulaID'                           , Value);end;
procedure TProductSimple.SetPartCalcformula                    (const Value: string    ); begin SetStringField('PartCalcformula'                     , Value);end;
procedure TProductSimple.SetPartCalcformulaField               (const Value: string    ); begin SetStringField('PartCalcformulaField'                , Value);end;
procedure TProductSimple.SetPartCalcformulaUOM                 (const Value: string    ); begin SetStringField('PartCalcformulaUOM'                  , Value);end;
procedure TProductSimple.SetPartCalcformulaUOMID               (const Value: Integer   ); begin SetIntegerField('PartCalcformulaUOMID'                , Value);end;
procedure TProductSimple.SetPartCalcformulaUOMMult             (const Value: Double    ); begin SetFloatField('PartCalcformulaUOMMult'              , Value);end;
procedure TProductSimple.SetPartCalcFormulaMult                (const Value: Double    ); begin SetFloatField('PartCalcFormulaMult'                 , Value);end;
procedure TProductSimple.SetFormulaQtyValue1                   (const Value: Double    ); begin SetFloatField('FormulaQtyValue1'                    , Value);end;
procedure TProductSimple.SetFormulaQtyValue2                   (const Value: Double    ); begin SetFloatField('FormulaQtyValue2'                    , Value);end;
procedure TProductSimple.SetFormulaQtyValue3                   (const Value: Double    ); begin SetFloatField('FormulaQtyValue3'                    , Value);end;
procedure TProductSimple.SetFormulaQtyValue4                   (const Value: Double    ); begin SetFloatField('FormulaQtyValue4'                    , Value);end;
procedure TProductSimple.SetFormulaQtyValue5                   (const Value: Double    ); begin SetFloatField('FormulaQtyValue5'                    , Value);end;
procedure TProductSimple.SetFormulaQty                         (const Value: Double    ); begin SetFloatField('FormulaQty'                          , Value);end;
procedure TProductSimple.SetFormulaQty1                        (const Value: Double    ); begin SetFloatField('FormulaQty1'                         , Value);end;
procedure TProductSimple.SetFormulaQty2                        (const Value: Double    ); begin SetFloatField('FormulaQty2'                         , Value);end;
procedure TProductSimple.SetFormulaQty3                        (const Value: Double    ); begin SetFloatField('FormulaQty3'                         , Value);end;
procedure TProductSimple.SetFormulaQty4                        (const Value: Double    ); begin SetFloatField('FormulaQty4'                         , Value);end;
procedure TProductSimple.SetFormulaQty5                        (const Value: Double    ); begin SetFloatField('FormulaQty5'                         , Value);end;
procedure TProductSimple.SetCanDeleteInPOS                     (const Value: Boolean   ); begin SetBooleanField('CanDeleteInPOS'                      , Value);end;
procedure TProductSimple.SetIsBOMTemplate                      (const Value: Boolean   ); begin SetBooleanField('IsBOMTemplate'                       , Value);end;
procedure TProductSimple.SetIsSystemProduct                    (const Value: Boolean   ); begin SetBooleanField('IsSystemProduct'                     , Value);end;
procedure TProductSimple.SetMancostWithLabour                  (const Value: Double    ); begin SetFloatField('MancostWithLabour'                   , Value);end;
procedure TProductSimple.SetPRODUCTAttrib1                     (const Value: Double    ); begin SetFloatField('PRODUCTAttrib1'                      , Value);end;
procedure TProductSimple.SetDangerousProduct                   (const Value: Boolean   ); begin SetBooleanField('DangerousProduct'                    , Value);end;
procedure TProductSimple.SetReqdinsurance                      (const Value: Boolean   ); begin SetBooleanField('Reqdinsurance'                       , Value);end;
procedure TProductSimple.SetInsuranceAmount                    (const Value: Double    ); begin SetFloatField('InsuranceAmount'                     , Value);end;
procedure TProductSimple.SetUndeliveredAction                  (const Value: string    ); begin SetStringField('UndeliveredAction'                   , Value);end;
procedure TProductSimple.SetTariffcode                         (const Value: string    ); begin SetStringField('Tariffcode'                          , Value);end;
procedure TProductSimple.SetconsignmentProducttype             (const Value: string    ); begin SetStringField('consignmentProducttype'              , Value);end;
procedure TProductSimple.SetProductclassification              (const Value: string    ); begin SetStringField('Productclassification'               , Value);end;
procedure TProductSimple.SetEnableAutoSplitQtyintoUOMinSales   (const Value: Boolean   ); begin SetBooleanField('EnableAutoSplitQtyintoUOMinSales'    , Value);end;
procedure TProductSimple.SetAreaCoverageofsingleQty            (const Value: Double    ); begin SetFloatField('AreaCoverageofsingleQty'             , Value);end;
procedure TProductSimple.SetBOMPriceCalculatedfromTree         (const Value: Boolean   ); begin SetBooleanField('BOMPriceCalculatedfromTree'          , Value);end;
procedure TProductSimple.SetBOMCostCalculatedFromTree          (const Value: Boolean   ); begin SetBooleanField('BOMCostCalculatedFromTree'           , Value);end;
procedure TProductSimple.SetRequiresAssembly                   (const Value: Boolean   ); begin SetBooleanField('RequiresAssembly'                    , Value);end;
procedure TProductSimple.SetMultibuy                           (const Value: Boolean   ); begin SetBooleanField('Multibuy'                            , Value);end;
procedure TProductSimple.SetEnablePackWeight                   (const Value: Boolean   ); begin SetBooleanField('EnablePackWeight'                    , Value);end;
procedure TProductSimple.SetPublishOnVS1                       (const Value: Boolean   ); begin SetBooleanField('PublishOnVS1'                       , Value);end;
procedure TProductSimple.SetIsOTFProduct                       (const Value: Boolean   ); begin SetBooleanField('IsOTFProduct'                        , Value);end;
procedure TProductSimple.SetManAvgCost                         (const Value: Double    ); begin SetFloatField('ManAvgCost'                          , Value);end;
procedure TProductSimple.SetManLatestCost                      (const Value: Double    ); begin SetFloatField('ManLatestCost'                       , Value);end;
procedure TProductSimple.SetManLatestCostDate                  (const Value: TDateTime ); begin SetDateTimeField('ManLatestCostDate'                   , Value);end;
procedure TProductSimple.SetProductPriceCalctype               (const Value: Integer   ); begin SetIntegerField('ProductPriceCalctype'                , Value);end;
procedure TProductSimple.SetDefaultWarrantyDuration            (const Value: Integer   ); begin SetIntegerField('DefaultWarrantyDuration'             , Value);end;
procedure TProductSimple.SetProductMarkupPrice                 (const Value: Double    ); begin SetFloatField('ProductMarkupPrice'                    , Value);end;
procedure TProductSimple.SetProductMarkupPricePercent          (const Value: Double    ); begin SetFloatField('ProductMarkupPricePercent'             , Value);end;
procedure TProductSimple.SetLineNo                             (const Value: Integer   ); begin SetIntegerField('LineNo'                              , Value);end;
procedure TProductSimple.SetIsManufactured                     (const Value: Boolean   ); begin SetBooleanField('IsManufactured'                      , Value);end;

function TProductSimple.getMagentoID: Integer;
var
  XRefDone: boolean;
  ExID:String;
begin
  result := 0;
  if TExternalXRef.GetExternalRef((*TMagentoCoreService.GetServiceName*)Servicename_Magento, ExRef_Objtype_Product, ID, ExId, XRefDone) then begin
    if (trim(ExId)<> '') and isinteger(ExId) then
      result := strtoint(trim(ExId));
  end;
end;



function TProductSimple.GetProductGroup1: string;
var
  strArray: TStringDynArray;
begin
  result:= '';
  if ProductGroup <> '' then begin
    strArray:= StrUtils.SplitString(ProductGroup,'^');
    result:= strArray[0];
    finalize(strArray);
  end;
end;

function TProductSimple.GetProductGroup2: string;
var
  strArray: TStringDynArray;
begin
  result:= '';
  if ProductGroup <> '' then begin
    strArray:= StrUtils.SplitString(ProductGroup,'^');
    if High(strArray) >= 1 then
      result:= strArray[1];
    finalize(strArray);
  end;
end;

function TProductSimple.GetProductGroup3: string;
var
  strArray: TStringDynArray;
begin
  result:= '';
  if ProductGroup <> '' then begin
    strArray:= StrUtils.SplitString(ProductGroup,'^');
    if High(strArray) >= 2 then
      result:= strArray[2];
    finalize(strArray);
  end;
end;
procedure TProductSimple.SetProductGroup1(const Value: string);
var
  s: string;
begin
  s:= Value + '^' + ProductGroup2 + '^' + ProductGroup3;
  while Copy(s,Length(s),1) = '^' do
    s:= Copy(s,1,Length(s)-1);
  ProductGroup:= s;
end;

procedure TProductSimple.SetProductGroup2(const Value: string);
var
  s: string;
begin
  s:= ProductGroup1 + '^' + Value + '^' + ProductGroup3;
  while Copy(s,Length(s),1) = '^' do
    s:= Copy(s,1,Length(s)-1);
  ProductGroup:= s;
end;

procedure TProductSimple.SetProductGroup3(const Value: string);
var
  s: string;
begin
  s:= ProductGroup1 + '^' + ProductGroup2 + '^' + Value;
  while Copy(s,Length(s),1) = '^' do
    s:= Copy(s,1,Length(s)-1);
  ProductGroup:= s;
end;



procedure TProductSimple.Setbatch(const Value: Boolean   );
begin
  if Value = Batch then exit;
  if Appenv.CompanyPrefs.AllowChangingProductAllocationFlags and not(Value)  then
  else if (ProductAlreadyHasAllocation) then exit;
  SetBooleanField('batch' , Value);
  if GetXMLNodeBooleanValue(CleanXMLNode, 'Batch') and not(batch) then begin
     multiplebins := False;
     SNTracking := False;
  end;
end;
procedure TProductSimple.SetMultipleBins                       (const Value: Boolean   );
begin
  if Value = multiplebins then exit;
  if Appenv.CompanyPrefs.AllowChangingProductAllocationFlags and not(Value)  then
  else if (ProductAlreadyHasAllocation) then exit;
  SetBooleanfield('multiplebins' , Value);
  if GetXMLNodeBooleanValue(CleanXMLNode, 'multiplebins')  and not(multiplebins) then begin
     SNTracking := False;
  end;
end;
procedure TProductSimple.SetSNTracking                         (const Value: Boolean   );
begin
  if Value = SnTracking then exit;
  if Appenv.CompanyPrefs.AllowChangingProductAllocationFlags and not(Value)  then
  else if (ProductAlreadyHasAllocation) then exit;
  SetBooleanField('SnTracking' , Value);
end;
procedure TProductSimple.SetPARTTYPE                           (const Value: string    );
begin
  if ProductType = value then exit;
  if (ProductType = 'INV') and (GetXMLNodeStringValue(CleanXMLNode, 'Producttype')<>'') then exit;// cannot change the type if its INV
  if (ProductType ='') or (ProductType ='NONINV') or (GetXMLNodeStringValue(CleanXMLNode, 'Producttype')='') then
    SetStringField('PartType', Value);
end;
procedure TProductSimple.SetBooleanPropertyFromNodeifisOk(const aNode: IXMLNode; const aPropertyName: string; const Obj: TObject = nil);
begin
    if isOkToSet(aPropertyName) then SetBooleanPropertyFromNode(anode, apropertyname ,  Obj);
end;

procedure TProductSimple.SetDateTimePropertyFromNodeifisOk(const aNode: IXMLNode; const aPropertyName: string; const Obj: TObject = nil);
begin
    if isOkToSet(aPropertyName) then SetDateTimePropertyFromNode(anode, apropertyname ,Obj);
end;

procedure TProductSimple.SetPropertyFromNodeifisOk(const aNode: IXMLNode; const aPropertyName: string; const Obj: TObject = nil);
begin
    if isOkToSet(aPropertyName) then SetPropertyFromNode(anode, apropertyname , Obj);
end;
function TProductSimple.GetExtraSellPrice: TProductExtraSellPrice;
begin
  REsult := TProductExtraSellPrice(getcontainercomponent(TProductExtraSellPrice , 'PartsID = ' +  IntToStr(ID)));
end;
function TProductSimple.GetExtraBuyPrice: TProductExtraBuyPrice;
begin
  REsult := TProductExtraBuyPrice(getcontainercomponent(TProductExtraBuyPrice , 'PartsID = ' +  IntToStr(ID)));
end;
function TProductSimple.GetAlternateProducts: TAlternateProduct;
begin
  Result := TAlternateProduct(getcontainercomponent(TAlternateProduct , 'ProductID = ' + IntToStr(self.Id)));
end;
Function TProductSimple.GeTProductProcessPart :TProductProcessPart;
begin
    REsult := TProductProcessPart(getcontainercomponent(TProductProcessPart , 'PartId = ' + IntToStr(Self.ID)));
end;
function TProductSimple.GetTaxSales: TTaxCode;
begin
  REsult := TTaxCode(getContainercomponent(TTaxCode , 'Name = ' + QuotedStr(self.TaxCodeSales)));
end;
function TProductSimple.GetTaxPurchase: TTaxCode;
begin
  REsult := TTaxCode(getContainercomponent(TTaxCode , 'Name = ' + QuotedStr(self.TaxCodePurchase)));
end;
function TProductSimple.GetForeignPriceSell: TProductForeignSellPrice;
begin
  result := TProductForeignSellPrice(getContainerComponent(TProductForeignSellPrice ,'PartsId = ' + IntToStr(Self.ID) + ' AND IsSellPrice = "T"' ));
end;
function TProductSimple.GetForeignPriceBuy: TProductForeignBuyPrice;
begin
  Result := TProductForeignBuyPrice(getContainerComponent(TProductForeignBuyPrice , 'PartsId = ' + IntToStr(Self.ID) + ' AND IsSellPrice = "F"'));
end;
function TProductSimple.GetProductSpecs: TProductSpecs;
begin
  Result := TProductSpecs(GetContainercomponent(TProductSpecs , 'PartsID = ' + IntToStr(self.ID)));
end;
function TProductSimple.geTProductBarcode: TProductBarcode;
begin
    REsult := TProductBarcode(getcontainercomponent(TProductBarcode , 'PartsId = ' +  IntToStr(ID)));
end;
function TProductSimple.getProductCommission: TProductCommission;
begin
  REsult := TProductCommission(getcontainercomponent(TProductCommission , 'PartsID= ' +  IntToStr(ID)));
end;
function TProductSimple.GetProductRewardPoints: TProductRewardPoints;
begin
  Result := TProductRewardPoints(GetContainerComponent(TProductRewardPoints , 'PartsID = ' + IntToStr(self.ID)));
end;
function TProductSimple.getPictures: TProductPicture;
begin
    REsult := TProductPicture(getcontainercomponent(TProductPicture , 'PartId = ' +  IntToStr(ID)));
end;
function TProductSimple.QryValidateAllocation:TERPQuery;
begin
  if fQryValidateAllocation = nil then begin
     fQryValidateAllocation :=DbSharedObjectsObj.DbSharedObj.GetQuery(Self.connection.connection , (*StockQtyDetailswithSno(TRue,ID)*)
                                  'select pqa.* ' +
                                  ' from tblpqa pqa inner join tblpqadetails pqad on pqa.pqaid = pqad.pqaid '+
                                  ' where pqa.productId = :ProductID ' +
                                  'limit 1');
  end;
  if (fQryValidateAllocation.active = False ) or (fQryValidateAllocation.parambyname('ProductID').asInteger <> ID) then begin
    commondblib.Closedb(fQryValidateAllocation);
    fQryValidateAllocation.parambyname('ProductID').asInteger  := id;
    commondblib.Opendb(fQryValidateAllocation);
  end;
  result := fQryValidateAllocation;
end;

function TProductSimple.ValidateAllocation(var Msg:String; ToTurnOffalloc:Boolean = False):Boolean;
begin
  inherited;
  Result:= False;

  if not(Sametext(ProductType , 'INV')) then begin
      Msg := ProductName   + ' is ' + Quotedstr(ProductType) +'. Only ''Inventory Parts'' can have ''Batch / Bin / Serial Number tracking'' !';
      Exit;
  end;
  (*qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.connection.connection , {StockQtyDetailswithSno(TRue,ID)}
                                  'select pqa.* ' +
                                  ' from tblpqa pqa inner join tblpqadetails pqad on pqa.pqaid = pqad.pqaid '+
                                  ' where pqa.productId = ' + inttostr(ID) +
                                  'limit 1');
  Try
  //With getNewDataset(StockQtyDetailswithSno(TRue,ID), true) do try
        filter := '    ((Batchnumber  <> ' + QuotedStr('') + ') and (Batchnumber  <> null)) '+
                  ' or ((binlocation  <> ' + QuotedStr('') + ') and (binlocation  <> null))  '+
                  ' or ((Serialnumber <> ' + QuotedStr('') + ') and (Serialnumber <> null))';
        Filtered := true;*)
      if Appenv.CompanyPrefs.AllowChangingProductAllocationFlags and ToTurnOffalloc  then begin
          REsult:= true;
          exit;
      end;
      With QryValidateAllocation do begin

        if recordcount =0 then begin
          REsult:= true;
          exit;
        end;
        if recordcount >0 then begin
          result:= False;
          Msg:= 'Serial No''s / Batches / Bins already Exist For This Product - Cannot Change the allocation!';
          Exit;
        end;
      end;
end;

function TProductSimple.getTotalStockQty: Double;
var
  strSQL:String;
  Qry :TERPQuery;
begin
  strSQL :=
    'Select ' +SQL4Qty(tStockQty) + ' as Qty' +
    ' FROM ' + ProductTables(tSummary) +
    ' Where P.PartsId = ' + IntToStr(ID);
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.connection.connection , strSQL);
  Try
    result := qry.Fieldbyname('Qty').Asfloat;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

initialization
  RegisterClass(TProductSimple);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Product','TProductSimple','TProductListGUI');

end.
