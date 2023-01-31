unit tcTypes;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 06/07/06  1.00.02 DMS  Added TShippingOption type.
  // 18/07/06  1.00.04 DMS  1. Added following types: TDataAction, TDataActions, TBoolStr.
  //                        2. Moved some types from HireForm unit.
  // 19/07/06  1.00.05 DMS  1. Added field to THireSalesLineData record structure.
  // 20/07/06  1.00.06 DMS  1. Moved some types from HireObj unit.
  //                        2. Modified TInvLinesRec type to add more fields.
  // 04/10/05  1.00.07  AL  1. Added Incurrence fields to TInvLinesRec record
  //                        2. Added AmountInvEx field to TInvLinesRec record
  // 15/05/06  1.00.08  AL  moved pLineItemRec from POSScreenGUI


interface

uses SysUtils, DB, MyAccess,ERPdbComponents, Graphics, Classes;

type

  TRegionType     = (rOther, rAust, rUK, rNZ, rRSA , rUSA, rCAN);
  TDefaultcontactMethod= (dcmEmail=1, dcmFax=2,dcmPrint=3,dcmPhone=4,dcmMobile=5,dcmVisit=6, dcmnone=7);
  TProductQtyRec = record
    ProductID: integer;
    ClassID: integer;
  end;

  pSubProductRec = ^TSubProductRec;
  TSubProductRec = record
    ProductID: integer;
    Units: string;
    UnitsID: integer;
    UnitsMultiplier: double;
    SubProductDesc: string;
    PriceEx: double;
    Valid: boolean;
  end;

  pLineItemRec = ^TLineItemRec; // used in POS Screen and POS Customer Display
  TLineItemRec = record
    ProductID: integer;
    Qty: double;
    ProductDescription: string;
    DiscountDetails: string;
    ProductName: string;
    ProductPrintName: string;
    PartType: string;
    Amount: currency;
    LinePrice: currency;
    Multiplier: double;
    LinePriceInc: currency;
    LaybyId: integer;           // layby payment for  this ID
    LaybyBal: currency;         // Balance for layby for which this is a payment
    LaybyAmount: currency;
    TaxCode: string;
    TaxRate: double;
    GlobalRef: integer;
    IncomeAccnt: string;
    AssetAccnt: string;
    CogsAccnt: string;
    ProductGroup: string;
    LineCost: currency;
    LineCostInc: currency;
    ApplyDisc: boolean;         // true if ok to apply cust discount to this item
    IsProduct: boolean;
    IsDiscount: boolean;        // true if this is a entered discount
    DiscRatio: double;          // discount to be applied to this product
    IsChild: boolean;           // true if this is a child (eg discount) of the preceding line
    PriceChanged: boolean;      // true if price-change is applied to this product
    IsSNTracking: boolean;      // true if Serial number tracking on for this item
    SoldSerials: string;        // string showing serial numbers
    IsVoucher: boolean;         // true if issue-ing a voucher
    IsRedeeming: boolean;       // true if redeeming a voucher
    VoucherNo: string;
    IssuedBy: string;           // store the voucher was issued by
    IsToBeDeleted: boolean;
    SubProduct: TSubProductRec; // sub product attributes
    FixedPrice: boolean;        // Set when user has set price override - stops price change during qyt
    UnitID: integer;            // set to unitID of product (usually zero)
    IsFrozen: boolean;          // set to true if disable delete of this item
    IsAccountPayment: boolean;  // set to true if this is an account payment
    AcntPayMethodID: integer;   // if account payment, then this is the pay method
    AcntPaymentID: integer;     // if account payment, then this is the pay method
    Area: string;               // area from which this product came eg: mensware
    SuppClientID: integer;      // Supplier Client ID For Advanced Matrix
    PCCTransHandle : integer;   // need to identify PCC Transaction
    PCCDispenser : integer;     // need to store DispenserNo
    PCCTankNo : integer;
    PCCHoseNo : integer;
    PCCVolume : Double;
    PCCValue : Double;
    PCCClientType : Integer;
    PCCGradeDesc : string;
    PCCVolumeName : string;
    PCCUnitPrice : double;
    BarTabID:Integer;
    BarTabLineID:Integer;
    CustomData: string;         // extra data in XML structure
    MatrixDesc:String;
    MatrixRef:String;
    MatrixPrice:Double;
    CanDeleteInPOS:Boolean;
    CanDeleteRelated:Boolean;
    IsrelatedHidden:Boolean;
    GridIndex:Integer; // -1 when not displayed on the grid : related parts when choosen to hide
    ID:Integer;
    RelatedParentID :Integer;
    RelatedParentProductId :Integer;
    RelatedQtyMultiplier:Double;
    RelatedParentQty:double;
    RefundedSalesLineID:Integer;
    HireLineId :Integer;
    HirePartsSaleID:Integer;
    Selected : boolean; // @@@@
  end;

  TBalanceType = (btNormal,
    btSO,
    btAR,
    btAP, btNone);

  TMailMergeType = (mmCustomers,
    mmSuppliers,
    mmEmployees,
    mmOtherContact,
    mmLoyalty);
  
  TMergeFieldRec = record
    ID: integer;
    GlobalRef: string;
    TableName: string;
    FieldName: string;
    FieldLabel: string;
    EditedFlag: boolean;
    IsDate: boolean;
    Success: boolean; 
  end;
  
  TDNMSpeedButtonEntryRec = record
    Description: string;
    Hint: string;
    ButtonNumber: integer;
    ButtonOrder: integer;
    CallFunction: string;
    Success: boolean;
  end;
  
  TExportRec = record
    ExportID: integer;
    TableName: string;
    SQL: string;
    TableDescription: string;
    IndexDefs: string;
    Success: boolean;
  end;
  
  TQueryType = (qtUpdate, qtInsert);
  
  TMySQLField = (ftTINYINT,
    ftSMALLINT,
    ftMEDIUMINT,
    ftINT,
    ftINTEGER,
    ftBIGINT,
    ftREAL,
    ftDOUBLE,
    ftFLOAT,
    ftDECIMAL,
    ftNUMERIC,
    ftDATE,
    ftTIME,
    ftTIMESTAMP,
    ftDATETIME,
    ftCHAR,
    ftVARCHAR,
    ftTINYBLOB,
    ftBLOB,
    ftMEDIUMBLOB,
    ftLONGBLOB,
    ftTINYTEXT,
    ftTEXT,
    ftMEDIUMTEXT,
    ftLONGTEXT,
    ftENUM,
    ftSET);
  
  PDBCreateRec = ^TDBCreateRec;
  TDBCreateRec = packed record
    DBName: string;
    CreateIfNotExists: boolean;
  end;
  
  TTaxOnType = (tcOnPurchase, tcOnSale);

  TUoMType = (uomOnPurchase, uomOnSale);

  TMathOperation = (moAddition, moSubtraction, moMultiply, moDivision);
  
  TTaxCalc = (taxExclusive, taxInclusive);
  
  TProductQty = (pqInStock,
    pqSalesOrders,
    pqInvoiceBO,
    pqOnOrder,
    pqReorderPoint,
    pqPreferredLevel,
    pqReOrderAmount,
    pqSalesOrderBO,
    pqOnLayby,
    pqAvailable);

  TProductQtys = set of TProductQty;

  TID        = integer;
  TProductID = integer;

  PProductQuantityRec = ^TProductQuantityRec;
  TProductQuantityRec = record
    ProductID: integer;
    InStock: double;
    SalesOrders: double;
    InvoiceBO: double;
    OnOrder: double;
    ReOrderPoint: double;
    PrefferedLevel: double;
    ReOrderAmount: double;
    SalesOrderBO: double;
    OnLayby: double;
    Available: double;
    OnBuildQty: double;
    BuildingQty: double;
    Success: boolean;
  end;

  TOnIndexChangeEvent = procedure(Sender: TObject; FromIndex, ToIndex: integer) of object;

  TBasicEmailInfoRec = record
    Address: string;
    Host: string;
    Port: integer;
    Success: boolean;
  end;
  
  { Invoice - related parts types }

  PInvLinesRec = ^TInvLinesRec;

  TInvLinesRec = record
    ProductID: integer;
    ProductName: string;
    ProductPrintName: string;
    ProductDescription: string;
    ClassID: integer;
    Units: string;
    QtySold: double;
    QtyShipped: double;
    QtyUOMBackOrder: double;
    QtyUOMSold: double;
    QtyUOMShipped: double;
    MultiplierUOM: double;
    LineCostInc: currency;
    LinePriceInc: currency;
    LineTaxCode: string;
    AmountInv: currency;
    IsRelated: boolean;
    IsSaleItem: boolean;
    UnitOfMeasureID: integer;
    IsIncurrence: boolean;
    IsAfterTax: boolean;
    IncurrenceRate: double;
    IncurrencePartsID: integer;
    AmountInvEx: currency;
  end;

  TDataAction  = (daInsert, daEdit, daPost, daEditAfterPost);
  TDataActions = set of TDataAction;
  TBoolStr     = array[false..true] of string;

  TShippingOption = (sonone, soShipInStock, soShipAnyway);

  TCompanyInfoRec = packed record
    Name: string;
    Email: string;
    Address: string;
    Address2: string;
    City: string;
    State: string;
    Postcode: string;
    Country: string;
    PhoneNumber: string;
    FaxNumber: string;
    ABN: string;
  end;
  
  { TMenuCustomiseRec }
  TMenuCustomiseRec = packed record
    PrefGroup: string;
    PrefName: string;
    PackageID: integer;
    UserID: integer;
    IndustryId : integer;
  end;

  { TPrefRec is a basic structure holding preference key properties }
  TPrefRec = packed record
    PackageID: integer;
    UserID: integer;
    PrefGroup: string;
    PrefName: string;
    PrefDesc: string;
    Value: Variant;
  end;

  { TMyQueryMode }
  TMyQueryMode = (qmUpdate, qmInsert, qmSelect);


  TColorMapRec = record
    Name: string;
    Color: TColor;
    AdjLuma: Integer;
  end;

  TFieldTypeInfo = record
    FieldName: string;
    TableName: string;
    DataType: string;
    AllowNull: Boolean;
    Default: String;
  end;


  TTransLockType = (ltNone, ltDeposited, ltPaymentApplied, ltClosingDate, ltInUse, ltOnHoldRec, ltReconciled , ltProgressPaymentApplied, ltTermProgressTransPaid);

  TGeneralDatasetProc    = Procedure (const Value:TDataset) of Object;

  TCorrespondenceType = (ctEmail, ctFax, ctLetter);

  function CorrespondenceTypeToStr(aType: TCorrespondenceType): string;

  function CleanStringList(AList : TStringList) : TStringList;

implementation

function CorrespondenceTypeToStr(aType: TCorrespondenceType): string;
begin
  case aType of
    ctEmail: result := 'Email';
    ctFax: result := 'Fax';
    ctLetter: result := 'Letter';
    else
      raise Exception.Create('CorrespondenceTypeToStr - Invalid Correspondence Type.');
  end;
end;

function CleanStringList(AList : TStringList) : TStringList;
var
  idx : integer;
begin
  for idx := AList.Count - 1 downto 0 do
    if AList[idx]='' then
      AList.Delete(idx);
  Result := AList;

end;

end.

