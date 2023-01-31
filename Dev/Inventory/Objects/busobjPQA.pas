unit busobjPQA;
{
  Date     Version  Who     What
  -------- -------- ------- -----------------
  07/04/08  1.00.01  Binny  Initial Version.
}

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, MyAccess, ERPdbComponents,
busobjstock, controls, BusObjProductbin, BusobjBaseProdTrans, BusObjProductClass , BusObjSalesBatches;

type
  TPQABatch = class;
  TPQABins = class;
  TPQASN = class;
  TPQA = class;

  TFuncSearchPQA = function: TPQA of object;

  TPQADetailsClass = class(TMSBusObj)
  private
    function GetPQAID: Integer;
    function GetPQADetailID: Integer;
    function GetPQAType: string;
    function GetClassID: Integer;
    function GetActive: Boolean;
    procedure SetPQAID(const Value: Integer);
    procedure SetPQADetailID(const Value: Integer);
    procedure SetPQAType(const Value: string);
    procedure SetClassID(const Value: Integer);
    procedure SetActive(const Value: Boolean);
    function getQty: Double;
    function getUOMID: Integer;
    function getUOMQty: Double;
    procedure setQty(const Value: Double);
    procedure setUOMID(const Value: Integer);
    procedure setUOMQty(const Value: Double);
    function getbatchno: string;
    function getBinID: Integer;
    function getExpiryDate: TdateTime;
    procedure setBatchno(const Value: string);
    procedure setBinID(const Value: Integer);
    procedure setExpiryDate(const Value: TdateTime);
    function getValue: string;
    procedure setValue(const Value: string);
    function getBinlocation: string;
    function getBinnumber: string;
    procedure setBinlocation(const Value: string);
    procedure setBinnumber(const Value: string);
    function GetDeptClassName: string;
    procedure SetDeptClassName(const Value: string);
    function GetUOMProductKeyName: string;
    procedure SetUOMProductKeyName(const Value: string);
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
    property Binlocation: string read getBinlocation write setBinlocation;
    property Binnumber: string read getBinnumber write setBinnumber;
    property PQAID: Integer read GetPQAID write SetPQAID;
    property PQAType: string read GetPQAType write SetPQAType;
    property Batchno: string read getbatchno write setBatchno;
    property PQAValue: string read getValue write setValue;
    property ExpiryDate: TdateTime read getExpiryDate write setExpiryDate;
    property BinID: Integer read getBinID write setBinID;
    property PQADetailID: Integer read GetPQADetailID write SetPQADetailID;
    class function _Schema: string; override;
  published
    property ClassID: Integer read GetClassID write SetClassID;
    property DeptClassName: string read GetDeptClassName write SetDeptClassName;
    property UOMId: Integer read getUOMID write setUOMID;
    property UOMProductKeyName: string read GetUOMProductKeyName write SetUOMProductKeyName;
    property UOMQty: Double read getUOMQty write setUOMQty;
    property Qty: Double read getQty write setQty;
    property Active: Boolean read GetActive write SetActive;

  end;

  TPQADetailsClassBatch = class(TPQADetailsClass)
  private
    function getPQAbatchno: string;
    function getPQAExpiryDate: TdateTime;
    procedure setPQABatchno(const Value: string);
    procedure setPQAExpiryDate(const Value: TdateTime);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property PQABatchno: string read getPQAbatchno write setPQABatchno;
    property PQAExpiryDate: TdateTime read getPQAExpiryDate write setPQAExpiryDate;
  end;

  TPQADetailsClassBin = class(TPQADetailsClass)
  private
    function getPQABinID: Integer;
    procedure setPQABinID(const Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property PQABinID: Integer read getPQABinID write setPQABinID;
  end;

  TPQADetailsClassSN = class(TPQADetailsClass)
  private
    function getPQASerialno: string;
    procedure SetPQASerialno(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property PQASerialNo: string read getPQASerialno write SetPQASerialno;
  end;

  TPQADetails = class(TMSBusObj)
  private
    AllValid: Boolean;
    fsNodeIDs: string;
    fiProductIDfromform: Integer;
    fiDepartmentIdfromform: Integer;
    fTotalBOQty: double;
    fTotalBOUOMQty: double;
    fTotalQty: double;
    fTotalUOMQty: double;
    fTotalCUSTFLD1Qty: double;
    fTotalCustFld4Qty: double;
    fParentUOMQty, fParentBOUOMQty :Double;
    function getBinID: Integer;
    procedure setBinID(const Value: Integer);
    function GetISBatch: Boolean;
    function getISBins: Boolean;
    function GetISSN: Boolean;
    function GetISBatchProduct: Boolean;
    function getISBinsProduct: Boolean;
    function GetISSNProduct: Boolean;
    function getAllocatype: string;
    function GetUOMMultiplier: Double;
    function GetProductID: Integer;
    function getDepartmentId :Integer;
    function GetProductName: String;

    function GetTranstype: string;
    function GetPQAID: Integer;
    function getQty: Double;
    function getUOMQty: Double;
    function getTotalAllocated: Double;
    function getTotalUOMAllocated: Double;
    function GetPQAType: string;
    function GetParentRef: string;
    function GetPQAValue: string;
    function IsOrChildof(CompClass: TPersistentClass): Boolean;
    procedure SetPQAID(const Value: Integer);
    procedure SetPQAType(const Value: string);
    procedure SetParentRef(const Value: string);
    procedure SetPQAValue(const Value: string);
    procedure TotalAllocatedCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure TotalUOMAllocatedCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure ValidateDataCallback(const Sender: TBusObj; var Abort: Boolean); overload;
    procedure checkAllocateQtyCallback(const Sender: TBusObj; var Abort: Boolean);


    procedure NodeIDsCallback(const Sender: TBusObj; var Abort: Boolean);
    function ChildObj: TPQADetails;
    function NodeIDs: string;
    function GetProduct: TProduct;
    function GetcleanQty: Double;
    function GetActive: Boolean;
    procedure SetActive(const Value: Boolean);
    function Getids: string;
    function GetPQA: TPQA;
    function GetPQADetailsClass: TPQADetailsClass;
    function getIsStockmovement: boolean;
    function GetBOQty: double;
    function GetBOUOMQty: double;
    procedure SetBOQty(const Value: double);
    procedure SetBOUOMQty(const Value: double);
    function getCUSTFLD1: Double;
    procedure setCUSTFLD1(const Value: Double);
    function getCUSTFLD2: Integer;
    procedure setCUSTFLD2(const Value: Integer);
    function getCUSTFLD3: Integer;
    procedure setCUSTFLD3(const Value: Integer);
    Function NextCustfld2:Integer;
    procedure AllocateQtyToBOQtyCallback(const Sender: TBusObj;var Abort: Boolean);
    procedure AllocateQtyfromBOQtyCallback(const Sender: TBusObj; var Abort: Boolean);
    //procedure RemoveShippedAllocationFromBOCallback(const Sender: TBusObj; var Abort: Boolean);
    //procedure RemoveShippedBOFromAllocationCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure LogAllAllocationAllback(const Sender: TBusObj; var Abort: Boolean);
    function getCustFld4: integer;
    procedure SetCustFld4(const Value: integer);
    function getCUSTFLD5: String;
    procedure setCUSTFLD5(const Value: String);
    function getCUSTFLD6: Double;
    procedure setCUSTFLD6(const Value: Double);
    function getCUSTFLD7: Double;
    procedure setCUSTFLD7(const Value: Double);
    Procedure RepopulateCustFld2;
    procedure RepopulateCustFld2Callback(const Sender: TBusObj; var Abort: Boolean);overload;
    function getParentdataRef: String;

  protected
    ffPQA: TPQA;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterOpen(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforeDelete(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterDelete(Sender: TDatasetBusObj): Boolean; override;
    function ExportsubClasses(const node: IXMLNode): Boolean; override;
    function getDescription: string; virtual;
    procedure CreateInstance; override;
    procedure AddErrMsg(const Value: string);
    procedure AddWarnMsg(const Value: string);
    function GetPQABatch: TPQABatch; virtual;
    function GeTPQABins: TPQABins; virtual;
    function GeTPQASN: TPQASN; virtual;
    function GetIsList: Boolean; override;
    function getExpiryDate: TdateTime;
    procedure setExpiryDate(const Value: TdateTime);
    function getAvailableQty: Double;Virtual;
    procedure setQty(const Value: Double);Virtual;
    procedure setUOMQty(const Value: Double);Virtual;

  public
    fdTotalAllocated: Double;
    fdTotalUOMAllocated: Double;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; overload; override;
    function ValidateAllRecs: Boolean;
    Function ValidateAllocation(HasTree:Boolean)   :Boolean;
    function Save: Boolean; override;
    function InTrans: Boolean;
    property PQAValue: string read GetPQAValue write SetPQAValue;
    property ExpiryDate: TdateTime read getExpiryDate write setExpiryDate;
    class function GetIDField: string; override;
    class function GetKeyStringField: string; override;
    class function GetBusObjectTablename: string; override;
    class function PQADetailtype: string; virtual;
    class function PQADetailDesctype: string; virtual;
//    property PQABatch: TPQABatch read GetPQABatch;
    property IsBatch: Boolean read GetISBatch;
    property IsBins: Boolean read getISBins;
    property IsSN: Boolean read GetISSN;
    property IsBatchProduct: Boolean read GetISBatchProduct;
    property IsBinsProduct: Boolean read getISBinsProduct;
    property IsSNProduct: Boolean read GetISSNProduct;
    property AllocType: string read getAllocatype;
    property UOMMultiplier: Double read GetUOMMultiplier;
    property ProductID: Integer read GetProductID;
    Property DepartmentId :Integer read getDepartmentId;
    property ProductName: String read GetProductName;
    Property IsStockmovement:boolean read getIsStockmovement;
    property TransType: string read GetTranstype;
    property TotalAllocated: Double read getTotalAllocated;
    property TotalUOMAllocated: Double read getTotalUOMAllocated;
    property Description: string read getDescription;
    property Product: TProduct read getProduct;
    property CleanQty: Double read getcleanQty;
    property IDs: string read getids;
    property PQA: TPQA read GetPQA write ffPQA;
    property PQADetailsClass: TPQADetailsClass read getPQADetailsClass;
    property ProductIDfromform: Integer read fiProductIDfromform write fiProductIDfromform;
    property DepartmentIdfromform: Integer read fiDepartmentIdfromform write fiDepartmentIdfromform;
    property PQAID: Integer read GetPQAID write SetPQAID;
    class function _Schema: string; override;
    property TotalQty: double read fTotalQty;
    property TotalUOMQty: double read fTotalUOMQty;
    property TotalBOQty: double read fTotalBOQty;
    property TotalBOUOMQty: double read fTotalBOUOMQty;
    property TotalCUSTFLD1Qty: double read fTotalCUSTFLD1Qty;
    property TotalCustFld4Qty: double read fTotalCustFld4Qty;
    procedure RefreshTotals;
    procedure CheckAllocateQty(aUOMQty , aBOUOMQty:Double);
    Procedure RemoveShippedAllocationFromBO;
    Procedure RemoveShippedBOFromAllocation;

    Procedure CloseAll;
    Procedure LogAllAllocation;
    Function MoveAllocation (fdQuantity :Double; ToObj:TPQADetails; Batch, bins, sn:Boolean; AllocateonlyifAvailable :Boolean = False):double;
    procedure RepopulateCustFld2Callback;overload;
    Property ParentdataRef :String read getParentdataRef;
    Property AvailableQty :Double read getAvailableQty;
  published
    property Qty: Double read getQty write setQty;
    property UOMQty: Double read getUOMQty write setUOMQty;
    property PQAType: string read GetPQAType write SetPQAType;
    property BOQty: double read GetBOQty write SetBOQty;
    property BOUOMQty: double read GetBOUOMQty write SetBOUOMQty;
    property ParentRef: string read GetParentRef write SetParentRef;
    property BinID: Integer read getBinID write setBinID;
    property Active: Boolean read GetActive write SetActive;
    Property CUSTFLD1 :Double read getCUSTFLD1 write setCUSTFLD1;   { Length etc. Customisable -Pref:PQADEtailsCUSTFLD1 }
    Property CUSTFLD2 :Integer read getCUSTFLD2 write setCUSTFLD2;  { internal - Seqno within Transline and within Parent }
    Property CUSTFLD3 :Integer read getCUSTFLD3 write setCUSTFLD3;  { internal - Seqno for TfmBatchNoCreateAndPrint }
    property CUSTFLD4 : integer read getCustFld4 write SetCustFld4; { Number of tubes for TfmBatchNoCreateAndPrint }
    Property CUSTFLD5 : String  read getCUSTFLD5 Write setCUSTFLD5; {Shipment Pallet Number / Name (done for DFT)}
    Property CUSTFLD6 :Double read getCUSTFLD6 write setCUSTFLD6;   { Gross Weight(TfmBatchNoCreate)}
    Property CUSTFLD7 :Double read getCUSTFLD7 write setCUSTFLD7;   { Gross Weight(TfmBatchNoCreate)}
    property PQABins: TPQABins read GeTPQABins;
    property PQASN: TPQASN read GeTPQASN;
  end;

  TPQADetailsFlat = class(TPQADetails)
  private
    function GetTruckLoadNo: string;
    procedure SetTruckLoadNo(const Value: string);
  Protected
  public
    constructor Create(AOwner: TComponent); override;
  published
    property PQAID;
    property PQAValue;
    property TruckLoadNo: string read GetTruckLoadNo write SetTruckLoadNo;
    property BatchExpiryDate: TdateTime read getExpiryDate write setExpiryDate;
  end;

  TPQABatch = class(TPQADetails)
  private
    function getbatchno: string;
    function getTruckLoadNo: string;
    function getExpiryDate: TdateTime;
    procedure setBatchno(const Value: string);
    procedure setTruckLoadNo(const Value: string);
    procedure setExpiryDate(const Value: TdateTime);
    function getsalesbatches: Tsalesbatches;
//    function getDetailsClassBatch: TPQADetailsClassBatch;
  protected
    function getDescription: string; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    procedure DoFieldOnChange(Sender: TField); override;
    procedure InactivateAllCallback(const Sender: TBusObj; var Abort: boolean); override;
    function DoBeforeDelete(Sender: TDatasetBusObj): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    class function PQADetailtype: string; override;
    class function PQADetailDesctype: string; override;
    class function XMLBranchName: string; override;
    class function XMLNodeName: string; override;
    function NextSeqBatchNo: string;
    Property salesbatches : Tsalesbatches read getsalesbatches;
  published
    property BatchNo: string read getbatchno write setBatchno;
    property TruckLoadNo: string read getTruckLoadNo write setTruckLoadNo;
    property BatchExpiryDate: TdateTime read getExpiryDate write setExpiryDate;
//    property DetailsClassBatch: TPQADetailsClassBatch read getDetailsClassBatch;
  end;

  TPQABins = class(TPQADetails)
  private
    function getBinlocation: string;
    function getBinnumber: string;
    procedure setBinlocation(const Value: string);
    procedure setBinnumber(const Value: string);
    function getProductBin: TProductBin;
    function getallocType: string;
    procedure SaveCallback(const Sender: TBusObj; var Abort: Boolean);
    function getValue: Integer;
    procedure setValue(const aValue: Integer);
    procedure Doupdatevolume_used(acleanQty, aNewQty:Double);
//    function getDetailsClassBin: TPQADetailsClassBin;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function getDescription: string; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterClose(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterOpen(Sender:TdatasetBusobj):Boolean; override;
    procedure InactivateAllCallback(const Sender: TBusObj; var Abort: boolean); override;
    procedure setQty(const Value: Double);override;
    procedure setUOMQty(const Value: Double);override;
  public
    { binny :the dataset stores the binid in the 'value' field. binlocation and binnumber properties set
      these variables and gets the binid. for 'NOTINLIST' of binlocation and binnumber needs these fs variables
      in the form to crete the bin - thats the reason to have these vars in the public section }
    fsBinNumber, fsBinLocation: string;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    class function PQADetailtype: string; override;
    class function PQADetailDesctype: string; override;
    class function XMLBranchName: string; override;
    class function XMLNodeName: string; override;
    property ProductBin: TProductBin read getProductBin;
    property allocType: string read getallocType;
    function Save: Boolean; override;
    procedure PostDb; override;
    // Function InTrans    : Boolean;
    class function _Schema: string; override;
  published
    property BinLocation: string read getBinlocation write setBinlocation;
    property BinNumber: string read getBinnumber write setBinnumber;
    property Value: Integer read getValue write setValue;
//    property DetailsClassBin: TPQADetailsClassBin read getDetailsClassBin;
  end;

  TPQASN = class(TPQADetails)
  private
    AllRecsValid: boolean;
    fbAllowFractionQty: boolean;
    function getSN: string;
    procedure SetSN(const Value: string);
    procedure SaveCallback(const Sender: TBusObj; var Abort: Boolean);
//    function getDetailsClassSN: TPQADetailsClassSN;
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function getDescription: string; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    procedure DoFieldOnChange(Sender: TField); override;
    function ValidateSN: Boolean; Overload;virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function PQADetailtype: string; override;
    class function PQADetailDesctype: string; override;
    class function XMLBranchName: string; override;
    class function XMLNodeName: string; override;
    Class function ValidateSN(const SN:String; iID, iProdID, iDeptID:integer; conn :TERPConnection; InTrans :Boolean; var ErrMsg:String; pqatransdate:TdateTime =0): Boolean;Overload;
    Property AllowFractionQty :boolean read fbAllowFractionQty write fbAllowFractionQty;
  published
    property SerialNumber: string read getSN write SetSN;
//    property DetailsClassSN: TPQADetailsClassSN read getDetailsClassSN;
  end;

  TProdQty = class(TProdTrans)
  private
    procedure SetInvalidAllocationLine(const Value: Integer);
    procedure SetIncompleteAllocationLine(const Value: Integer);
    function GetProductClass: TProductClass;
    function GetUOMNameProductKey: string;
    {these properties don;t look for the tree , ie. sn with bin within batch. this is just the list of allocation of each type}
      function getPQABatches: TPQABatch;
      function getPQABins: TPQABins;
      function getPQASNs: TPQASN;
    function hasinCompleteAllocationLine: Boolean;
    function hasInvalidAllocationLine: Boolean;

  protected
    procedure SetUOMNameProductKey(const Value: string); virtual;
    function GetPQA: TPQA; virtual;
    function QtyValid: Boolean;Virtual;
    function GetClassID: Integer; virtual; abstract;
    function GetAllocType: string; virtual; abstract;
    function GetTransDate: TdateTime; virtual; abstract;
    function GetQty: Double; virtual; abstract;
    function GetBOQty: Double; virtual; abstract;
    function GetBOUOMQty: Double; virtual; abstract;
    function GetUOMQty: Double; virtual; abstract;
    function GetSerialnos: string; virtual; abstract;
    function GetCleanClassID: Integer; virtual; abstract;
    function GetcleanProductId: Integer; virtual; abstract;
    function GetHasPQACreated: Boolean; virtual;
    function GetOrderQty: Double; virtual; abstract;
    function GetUOMOrderQty: Double; virtual; abstract;
    function GetMatrixRef: string; virtual; abstract;
    function GetMatrixDesc: string; virtual; abstract;
    function GetMatrixPrice: Double; virtual; abstract;
    function GetEnableAllocation: Boolean; virtual;
    function GetIsPQAItem: Boolean; virtual;

    procedure SetSerialNos(const Value: string); virtual; abstract;
    function ExportsubClasses(const node: IXMLNode): Boolean; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforeDelete(Sender: TDatasetBusObj): Boolean; override;
    procedure SetBOQty(const Value: Double); virtual; abstract;
    procedure SetBOUOMQty(const Value: Double); virtual; abstract;
    procedure SetQty(const Value: Double); virtual; abstract;
    procedure SetTransDate(const Value: TdateTime); virtual; abstract;
    procedure SetUOMQty(const Value: Double); virtual; abstract;
    procedure SetOrderQty(const Value: Double); virtual; abstract;
    procedure SetUOMOrderQty(const Value: Double); virtual; abstract;
    function GetProductType: string; virtual; abstract;
    procedure SetProductType(const Value: string); virtual; abstract;
    procedure SetMatrixRef(const Value: string); virtual; abstract;
    procedure SetMatrixDesc(const Value: string); virtual; abstract;
    procedure SetMatrixPrice(const Value: Double); virtual; abstract;
    function GetIsList: Boolean; override;
    procedure InitUOM(const Sender: TField);Overload;
    Procedure InitUOM(const UOMName, UOMNameOldValue:String);Overload;Virtual;
    {these properties don;t look for the tree , ie. sn with bin within batch. this is just the list of allocation of each type}
    Function UpdatingBO :Boolean ;Virtual;
    procedure UpdateproductAverageCost(var Tempcost: Double; intrans: Boolean);
    Function ProductStandardCost:Double; Virtual;

  public
    constructor Create(AOwner: TComponent); override;
    function PQAcount: Integer;virtual;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    property CleanClassId: Integer read GetCleanClassID;
    property CleanProductID: Integer read GetcleanProductId;
    property HasPQACreated: Boolean read GetHasPQACreated;
    property allocType: string read getallocType;
    property IsPQAItem: Boolean read GetIsPQAItem;
    property EnableAllocation: Boolean read GetEnableAllocation;
    function Save: Boolean; override;
    function ValidateData: Boolean; override;
    procedure Copyallocation;virtual;
    property InvalidAllocationLine: Integer write setInvalidAllocationLine;
    property inCompleteAllocationLine: Integer write setinCompleteAllocationLine;
    function CreateProductClass: Boolean;

    property ProductClass: TProductClass read getProductClass;
    class function _Schema: string; override;
      Property PQABatches : TPQABatch read getPQABatches;
      Property PQABins    : TPQABins  read getPQABins;
      Property PQASNs     : TPQASN    read getPQASNs;

    property SerialNumbers: string read GetSerialnos write SetSerialNos;
  published
    property PQA: TPQA read GetPQA;
    property UOMNameProductKey: string read GetUOMNameProductKey write SetUOMNameProductKey;
    property ClassID: Integer read GetClassID;
    property Qty: Double read getQty write setQty;
    property OrderQty: Double read GetOrderQty write SetOrderQty;
    property UOMOrderQty: Double read GetUOMOrderQty write SetUOMOrderQty;
    property MatrixRef: string read getMatrixRef write SetMatrixRef;
    property MatrixDesc: string read getMatrixDesc write SetMatrixDesc;
    property MatrixPrice: Double read getMatrixPrice write SetMatrixPrice;
    property BOQty: Double read GetBOQty write SetBOQty;
    property BOUOMQty: Double read GetBOUOMQty write SetBOUOMQty;
    property UOMQty: Double read getUOMQty write setUOMQty;
    property TransDate: TdateTime read GetTransDate write SetTransDate;
    property ProductType: string read GetProductType write SetProductType;
  end;

  TPQA = class(TMSBusObj)
  private
    fsErrMsg, fsWarnmsg: string;
    fiInvalidDetailID: Integer;
    fsInvalidDetailTyp: string;
    fbISParentInvalid: Boolean;
    fdTotalBatchQty:Double;
    function GetProductID: Integer;
    function GetProductName: string;
    function GetProductPrintName: string;
    function GetTransLineId: Integer;
    function GetTransID: Integer;
    function GetTransDate: TdateTime;
    function GetTranstype: string;
    function getallocType: string;
    function GetIsBO: Boolean;
    function getUOMQty: Double;
    function GetUOM: string;
    function GetUOMMultiplier: Double;
    function GetUnitOfMeasureID: Integer;
    function getDepartmentID: Integer;
    function GetActive: Boolean;
    function GetProduct: TProduct;
    function GetPOnumber: Integer;
    procedure SetProductID(const Value: Integer);
    procedure SetProductName(const Value: string);
    procedure SetProductPrintName(const Value: string);
    procedure SetTransLineId(const Value: Integer);
    procedure SetTransID(const Value: Integer);
    procedure SetTransDate(const Value: TdateTime);
    procedure SetTransType(const Value: string);
    procedure SetAlloctype(const Value: string);
    procedure SetIsBO(const Value: Boolean);
    procedure setUOMQty(const Value: Double);
    procedure SetUOM(const Value: string);
    procedure SetUOMMultiplier(const Value: Double);
    procedure SetUnitOfMeasureID(const Value: Integer);
    procedure SetDepartmentID(const Value: Integer);
    procedure SetActive(const Value: Boolean);
    function getProductClass: TProductClass;
    function GetUOMOrderQty: Double;
    function getREserved: Boolean;
    procedure setREserved(const Value: Boolean);
    procedure updateReserved;
    function getProductDEfaultbinID: Integer;
    function getMatrixRef: string;
    procedure SetMatrixRef(const Value: string);
    function getCleanActive: Boolean;
    function GetUOMNameProductKey: string;
    procedure SetUOMNameProductKey(const Value: string);
    function GetDeptClassName: string;
    procedure SetDeptClassName(const Value: string);
    function ISStockMovement: Boolean;
    function HasAllocationoftype(const Detailtype: String): Boolean;
    function getTotalBatchQty: double;
    Procedure TotalBatchQtyCallback(const Sender: TBusObj; var Abort: Boolean);
    function getTotalUOMBatchAllocatedQty: double;
    function getTotalBOUOMBatchAllocatedQty: Double;
    function getBOUOMQty: Double;
    function isEnforceAllocationValidation: Boolean;
    function getCrossStockAdjustTransForinvoice: Boolean;
    procedure DeleteDetails;
    function HasMultipleAllocation: Boolean;
    procedure AddProductIDtosumQty;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforeDelete(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function ExportsubClasses(const node: IXMLNode): Boolean; override;
    procedure CreateInstance; override;
    function GetPQABatch: TPQABatch; virtual;
    function GeTPQABins: TPQABins; virtual;
    function GeTPQASN: TPQASN; virtual;
    function GetAllPQABins: TPQABins;
    function GetAllPQASN: TPQASN;
    function getQty: Double; // virtual;
    procedure setQty(const Value: Double); // virtual;
    function PQAtablename: string; virtual;
    function QtyValid :Boolean;Virtual;
    function getPQAdetails: TPQADetails;Virtual;
    function GetIsList: Boolean; override;
    Function  DoBeforeClose(Sender :TDatasetBusObj ):Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function ValidateAllocation: Boolean;
    Function CheckforAllocation(ReqQty:Double):Boolean;
    function Save: Boolean; override;
    class function GetIDField: string; override;
    class function GetKeyStringField: string; override;
    class function GetBusObjectTablename: string; override;
    property Product: TProduct read getProduct;
    procedure Refreshall;
    property PONumber: Integer read getPOnumber;
    property Warnmsg: string read fsWarnmsg write fsWarnmsg;
    property Errmsg: string read fsErrMsg write fsErrMsg;
    property ProductClass: TProductClass read getProductClass;
    property UOMOrderQty: Double read GetUOMOrderQty;
    property ProductDEfaultbinID: Integer read getProductDEfaultbinID;
    procedure Copyallocation;overload;
    procedure Copyallocation(const ObjInstanceToCloneID:Integer; InctivateCopyingPQA:Boolean =True);overload;
    function InTrans: Boolean;
    procedure DeleteRecordsWith0Qty;
    procedure AddErrMsg(const Value: string);
    procedure AddWarnMsg(const Value: string);
    function IsRefundTrans: Boolean;
    property CleanActive: Boolean read getCleanActive;
    function PQAdetailtablename: string; virtual;
    property InvalidDetailID: Integer read fiInvalidDetailID write fiInvalidDetailID;
    property InValidDetailtype: string read fsInvalidDetailTyp write fsInvalidDetailTyp;
    property ISParentInvalid: Boolean read fbISParentInvalid write fbISParentInvalid;
    property TransLineId: Integer read GetTransLineId write SetTransLineId;
    property TransID: Integer read GetTransID write SetTransID;
    class function _Schema: string; override;
    function TotalAllocated:Double;
    function TotalUOMAllocated:Double;
    Procedure doAfterAllocate;
    Property PQADetails :TPQADetails read getPQAdetails;
    function NewPQADetailObj(const ObjInstanceToCloneID:Integer): TPQADetails;Virtual;
    function hasBinAllocation:Boolean;
    function hasBatchAllocation:Boolean;
    function hasSNAllocation:Boolean;
    Property TotalBatchQty :double read getTotalBatchQty;
    Property TotalUOMBatchAllocatedQty :double read getTotalUOMBatchAllocatedQty;
    Property TotalBOUOMBatchAllocatedQty :Double read getTotalBOUOMBatchAllocatedQty;
    Property BOUOMQty :Double read getBOUOMQty;
    Procedure CloseAllAllocationObj;
    Procedure RemoveShippedAllocationFromBO;
    Procedure RemoveShippedBOFromAllocation;
    Procedure LogAllAllocation;
    Function IsSalesOrderPQA:Boolean;
    Property CrossStockAdjustTransForinvoice : Boolean read getCrossStockAdjustTransForinvoice;
    Function MakeNextSearialnumberWithTransId :String;
    property AllPQABins: TPQABins read GetAllPQABins;
    property AllPQASN: TPQASN read GetAllPQASN;
  published
    property ProductID: Integer read GetProductID write SetProductID;
    property ProductName: string read GetProductName write SetProductName;
    property ProductPrintName: string read GetProductPrintName write SetProductPrintName;
    property TransDate: TdateTime read GetTransDate write SetTransDate;
    property TransType: string read GetTranstype write SetTransType;
    property AllocType: string read getallocType write SetAlloctype;
    property IsBO: Boolean read GetIsBO write SetIsBO;
    property Qty: Double read getQty write setQty;
    property UOMQty: Double read getUOMQty write setUOMQty;
    property UnitOfMeasure: string read GetUOM write SetUOM;
    property UOMMultiplier: Double read GetUOMMultiplier write SetUOMMultiplier;
    property UnitOfMeasureID: Integer read GetUnitOfMeasureID write SetUnitOfMeasureID;
    property UOMNameProductKey: string read GetUOMNameProductKey write SetUOMNameProductKey;
    property DepartmentID: Integer read getDepartmentID write SetDepartmentID;
    property DeptClassName: string read GetDeptClassName write SetDeptClassName;
    property Active: Boolean read GetActive write SetActive;
    property Reserved: Boolean read getREserved write setREserved;
    property MatrixRef: string read getMatrixRef write SetMatrixRef;
    property PQABatch: TPQABatch read GetPQABatch;
    property PQABins: TPQABins read GeTPQABins;
    property PQASN: TPQASN read GeTPQASN;
  end;

  TPQAFlat = class(TPQA)
  protected
  public
    constructor Create(AOwner: TComponent); override;
  published
    property TransLineId;
    property TransID;
  end;

  TPQASNLastTransDate = class(TMSBusObj)
  private
    fFirstLoad: boolean;
    function GetDepartmentID: integer;
    function GetProductID: integer;
    function GetSerialNumber: string;
    function GetTransDate: TDateTime;
    procedure SetDepartmentID(const Value: integer);
    procedure SetProductID(const Value: integer);
    procedure SetSerialNumber(const Value: string);
    procedure SetTransDate(const Value: TDateTime);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    class procedure UpdateTableData;
    procedure Load(const fIsReadonly: boolean = False); override;
  published
    property ProductID: integer read GetProductID write SetProductID;
    property DepartmentID: integer read GetDepartmentID write SetDepartmentID;
    property SerialNumber: string read GetSerialNumber write SetSerialNumber;
    property TransDate: TDateTime read GetTransDate write SetTransDate;
  end;


implementation

uses tcDataUtils, CommonLib, CommonDbLib, SysUtils, AppEnvironment, TypInfo, BusObjConst, tcConst,
  ProductQtyLib, BusobjCash, BusObjSales, BusObjPOSSale, busobjSerialnumbers, busobjPartsPriceMatrix,
  dialogs, BusObjSchemaLib, BusObjUOM, BusObjClass, Math, Types,
  busobjStockMovement , variants,PQALib, DbSharedObjectsObj, SharedObjs,
  BusObjSaleBase, TempTableUtils, busobjstockTransferentry, dateutils,
  BusObjDeletedItem, BusObjOrderBase, LogLib;

{ TPQA }

constructor TPQA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'PQA';
  fSQL := 'SELECT * FROM tblpqa';
  LogChangesOnSave := False;
  fIsList := true;
  (* need these
  ExportExcludeList.Add('productid');
  ExportExcludeList.Add('unitofmeasureid');
  ExportExcludeList.Add('departmentid');
  *)
end;

class function TPQA.GetIDField: string;
begin
  Result := 'PQAID'
end;

class function TPQA.GetKeyStringField: string;
begin
  Result := ''
end;

class function TPQA.GetBusObjectTablename: string;
begin
  Result := 'tblpqa'
end;

function TPQA.getCleanActive: Boolean;
begin
  Result := GetXMLNodeBooleanValue(CleanXMLNode, 'Active');
end;

function TPQA.getCrossStockAdjustTransForinvoice: Boolean;
begin
  Result := False;
  if Assigned(Owner) then
  if  (Owner is TSalesLineBase) then
    REsult := TSalesLineBase(Owner).CrossStockAdjustTransForinvoice
  else if owner is TStockTransferEntry then
    REsult := TStockTransferEntry(Owner).CrossStockAdjustTransForinvoice;
end;

destructor TPQA.Destroy;
begin
  inherited;
end;

procedure TPQA.DoAfterAllocate;
var
  tot: double;
begin
  { sum up details custom field }
  if Assigned(Owner) and (Owner is TSalesLineBase) and (PQABatch.Count > 0) then begin
    tot := 0;
    PQABatch.Dataset.DisableControls;
    try
      PQABatch.Dataset.First;
      while not PQABatch.Dataset.EOF do begin
        tot := tot + PQABatch.CUSTFLD1;
        PQABatch.Dataset.Next;
      end;
    finally
      PQABatch.Dataset.EnableControls;
    end;
    TSalesLineBase(Owner).DetailsCust1Total := tot;
  end;
end;

function TPQA.ExportsubClasses(const node: IXMLNode): Boolean;
begin
  if PQABatch.count > 0 then begin
    PQABatch.XMLPropertyNode := node.AddChild(TPQABatch.XMLBranchName);
    PQABatch.XMLPropertyName := TPQABatch.XMLNodeName;
    PQABatch.IterateRecords(GetPropertyXMLCallback);
  end
  else if PQABins.count > 0 then begin
    PQABins.XMLPropertyNode := node.AddChild(TPQABins.XMLBranchName);
    PQABins.XMLPropertyName := TPQABins.XMLNodeName;
    PQABins.IterateRecords(GetPropertyXMLCallback);
  end
  else if PQASN.count > 0 then begin
    PQASN.XMLPropertyNode := node.AddChild(TPQASN.XMLBranchName);
    PQASN.XMLPropertyName := TPQASN.XMLNodeName;
    PQASN.IterateRecords(GetPropertyXMLCallback);
  end;
  Result := True;
end;

procedure TPQA.LoadFromXMLNode(const node: IXMLNode);
var
  LinesNode: IXMLNode;
  x: Integer;
begin
  if Assigned(Self.Owner) and (Self.Owner is TProdQty) then begin
    TransLineId := TProdQty(Self.Owner).ID;
    TransID := TProdQty(Self.Owner).HeaderID;
    allocType := TProdQty(Self.Owner).allocType;
    Transtype := TProdQty(Self.Owner).Classname;
  end else begin
    SetPropertyFromNode(node, 'TransLineId');
    SetPropertyFromNode(node, 'TransID');
    SetPropertyFromNode(node, 'Alloctype');
    SetPropertyFromNode(node, 'TransType');
  end;
  SetPropertyFromNode(node, 'ProductID');
  SetPropertyFromNode(node, 'UnitOfMeasureID');
  SetPropertyFromNode(node, 'DepartmentID');
  SetDAtetimePropertyFromNode(node, 'TransDate');
  SetPropertyFromNode(node, 'ProductName');
  SetPropertyFromNode(node, 'ProductPrintName');
  SetPropertyFromNode(node, 'UnitOfMeasure');
  SetPropertyFromNode(node, 'MatrixRef');
  SetBooleanPropertyFromNode(node, 'IsBO');
  SetBooleanPropertyFromNode(node, 'Active');
  SetBooleanPropertyFromNode(node, 'Reserved');
  SetPropertyFromNode(node, 'Qty');
  SetPropertyFromNode(node, 'UOMQty');
  SetPropertyFromNode(node, 'UOMMultiplier');
  inherited;
  DeleteDetails;
  //getnewDataset('delete from tblPQADetails where pqaID = ' + inttostr(ID), True);
  LinesNode := node.ChildNodes.FindNode(TPQABatch.XMLBranchName);
  if Assigned(LinesNode) then begin
    for x := 0 to LinesNode.ChildNodes.count - 1 do begin
      PQABatch.New;
      PQABatch.LoadFromXMLNode(LinesNode.ChildNodes[x]);
      PQABatch.PostDb;
    end;
    Exit;
  end;
  LinesNode := node.ChildNodes.FindNode(TPQABins.XMLBranchName);
  if Assigned(LinesNode) then begin
    for x := 0 to LinesNode.ChildNodes.count - 1 do begin
      PQABins.New;
      PQABins.LoadFromXMLNode(LinesNode.ChildNodes[x]);
      PQABins.PostDb;
    end;
    Exit;
  end;
  LinesNode := node.ChildNodes.FindNode(TPQASN.XMLBranchName);
  if Assigned(LinesNode) then begin
    for x := 0 to LinesNode.ChildNodes.count - 1 do begin
      PQASN.New;
      PQASN.LoadFromXMLNode(LinesNode.ChildNodes[x]);
      PQASN.PostDb;
    end;
    Exit;
  end;

end;

procedure TPQA.LogAllAllocation;
begin
       if Product.Batch        then PQABatch.LogAllAllocation
  else if Product.Multiplebins then PQABins.LogAllAllocation
  else if Product.SnTracking   then PQASN.LogAllAllocation;
end;

function TPQA.MakeNextSearialnumberWithTransId: String;
var
  qry: TERPQuery;
  function AutoSerialnumberPrefix :String; begin result := trim(inttostr(TransID)) + '-'; end;
begin
  result := '';
  if ProductId =0 then exit;
  if Product.SnTracking = false then exit;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(connection.connection);
  try
    Commondblib.closedb(qry);
    qry.SQL.text := 'select pqa.productid, Value  , convert( replace(pqad.value , "'+ AutoSerialnumberPrefix +'" , ""), signed) as num '+
            ' from tblpqa pqa inner join tblpqadetails pqad on pqa.pqaid = pqad.pqaid and pqad.PQAType ="SN" '+
            ' where pqa.ProductID =  '+ inttostr(ProductID) +
            ' and pqad.value like "'+ AutoSerialnumberPrefix +'%" '+
            ' and IsInteger(replace(pqad.value , "'+ AutoSerialnumberPrefix +'" , "")) '+
            ' order by num desc '+
            ' limit 1 ';
    qry.Open;
    result := AutoSerialnumberPrefix +nextnum(qry.Fieldbyname('num').AsInteger+1 , 4 );
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TPQA.SaveToXMLNode(const node: IXMLNode);
begin
  AddXMLNode(node, 'ProductID', ProductID);
  AddXMLNode(node, 'ProductName', ProductName);
  AddXMLNode(node, 'TransLineId', TransLineId);
  AddXMLNode(node, 'TransID', TransID);
  AddXMLNode(node, 'TransDate', TransDate);
  AddXMLNode(node, 'TransType', Transtype);
  AddXMLNode(node, 'Alloctype', allocType);
  AddXMLNode(node, 'IsBO', IsBO);
  AddXMLNode(node, 'Qty', Qty);
  AddXMLNode(node, 'UOMQty', UOMQty);
  AddXMLNode(node, 'UnitOfMeasure', UnitOfMeasure);
  AddXMLNode(node, 'UOMMultiplier', UOMMultiplier);
  AddXMLNode(node, 'UnitOfMeasureID', UnitOfMeasureID);
  AddXMLNode(node, 'DepartmentID', DepartmentID);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'Reserved', Reserved);
  AddXMLNode(node, 'MatrixRef', MatrixRef);
  inherited;
  ExportsubClasses(node);
end;
function TPQA.HasMultipleAllocation:Boolean;
var
  Qry:TERPQuery;
  s:String;
begin

  if ProductID   <> 0  then s:= 'select batch, multiplebins, sntracking from tblparts where PartsId = ' + inttostr(ProductID)
  else if ProductName <> '' then s:= 'select batch, multiplebins, sntracking from tblparts where Partname = ' + quotedstr(Productname)
  else begin result := False; exit; end;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
      Qry.sql.text := s;
      Qry.open;
      result := (Qry.fieldbyname('batch').asBoolean and Qry.fieldbyname('multiplebins').asBoolean) or
                 (Qry.fieldbyname('batch').asBoolean and Qry.fieldbyname('sntracking').asBoolean) or
                 (Qry.fieldbyname('multiplebins').asBoolean and Qry.fieldbyname('sntracking').asBoolean);
      if result then begin
        commondblib.Closedb(Qry);
        Qry.sql.text := 'Select count(*) ctr from tblpqadetails where pqaid = ' + inttostr(ID) +' and ifnull(parentRef, "") <> ""';
        Qry.open;
        result := Qry.fieldbyname('ctr').asInteger >0;
      end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;



end;
function TPQA.ValidateData: Boolean;
var
  s: string;
  Located: Boolean;
  Qry: TERPQuery;
  function Checkqty(const PQAType: string): Boolean;
  begin
    Result := True;
    Located := Qry.Locate('PQAtype', PQAType, []);
//    if Located and ((UOMQty < fieldByname('UOMQty').asFloat) or (Qty < fieldByname('Qty').asFloat)) then begin
    if Located and ((CompareValue(UOMQty,fieldByname('UOMQty').asFloat,0.000001) = LessThanValue) or (CompareValue(Qty,fieldByname('Qty').asFloat,0.000001) = LessThanValue)) then begin
      AddErrMsg(ProductName + ': The Quantity of ' + PQAType + ' Allocated [' + FloattoStr(fieldByname('UOMQty').asFloat) + '] does not match the Quantity to be Allocated[' +
        FloattoStr(Self.UOMQty) + ']');
      Result := False;
      Exit;
    end
    else if isEnforceAllocationValidation then begin
//      if (not(Located)) or (UOMQty <> fieldByname('UOMQty').asFloat) then begin
      if (not(Located)) or (not SameValue(UOMQty,fieldByname('UOMQty').asFloat,0.000001)) then begin
        AddErrMsg(ProductName + ': The Quantity of Serialnumber Allocated [' + FloattoStr(fieldByname('UOMQty').asFloat) + '] does not match the Quantity to be Allocated[' +
          FloattoStr(Self.UOMQty) + ']');
        Result := False;
        Exit;
      end;
    end
//    else if (not(Located)) or ((UOMQty > fieldByname('UOMQty').asFloat) or (Qty > fieldByname('Qty').asFloat)) then begin
    else if (not(Located)) or ((CompareValue(UOMQty,fieldByname('UOMQty').asFloat,0.000001) = GreaterThanValue) or (CompareValue(Qty,fieldByname('Qty').asFloat,0.000001) = GreaterThanValue)) then begin
      AddWarnMsg(ProductName + ': The Quantity of ' + PQAType + ' Allocated [' + FloattoStr(fieldByname('UOMQty').asFloat) + '] does not match the Quantity to be Allocated[' +
        FloattoStr(Self.UOMQty) + ']');
    end;
  end;

begin
  Result := True;
  //CreateProductClass;
  InvalidDetailID := 0;
  InValidDetailtype := '';

  if (UOMQty = 0) or (IsBO) then Exit;


  if not(QtyValid) then begin
    s := 'Select PQAtype, sum(UOMqty) as UOMQty , sum(Qty) as Qty from tblPQADetails ' + ' where PQAID = ' + inttostr(ID) + ' and Active = ' + Quotedstr('T') + ' group by PQAtype';
    Qry := TERPQuery(getnewDataset(s, True));
    try
      if Product.Batch then
        if not(Checkqty(TPQABatch.PQADetailtype)) then begin
          Result := False;
          Exit;
        end;
      if Product.Multiplebins then
        if not(Checkqty(TPQABins.PQADetailtype)) then begin
          Result := False;
          Exit;
        end;
      if Product.SnTracking then
        if not(Checkqty(TPQASN.PQADetailtype)) then begin
          Result := False;
          Exit;
        end;

    finally
      if Qry.Active then Qry.close;
      Qry.Free;
    end;
  end;
  if HasMultipleAllocation then begin
      s := ' select distinct Value, ExpiryDate , PQAType, PBin.BinLocation, Pbin.Binnumber ' + ' from tblPQADetails as PQA ' + ' Left join tblProductBin as PBin  on PBin.binId = PQA.Value ' +
        ' where PQA.PQAID =  ' + inttostr(ID) + ' and (PQA.qty <> 0) and (round(PQA.qty,' + inttostr(GeneralRoundPlaces) +')  <  round((Select Sum(SUBPQA.Qty) from tblPQADetails as SUBPQA where SUBPQA.ParentREf = PQA.globalref and ifnull(SUBPQA.Value,"")<> ""),' + inttostr(GeneralRoundPlaces) +')  ) ';
      stepProgress;
      Qry := TERPQuery(getnewDataset(s, True));
      try
        stepProgress;
        if Qry.recordcount = 0 then Exit;
        Qry.first;
        s := '';
        while Qry.Eof = False do begin
          if s <> '' then s := s + ',';
          if Qry.fieldByname('binlocation').asString <> '' then begin
            s := s + Qry.fieldByname('binlocation').asString;
            if Qry.fieldByname('binnumber').asString <> '' then s := s + '-' + Qry.fieldByname('binnumber').asString;
          end
          else s := s + Qry.fieldByname('Value').asString;
          Qry.next;
        end;
        if s <> '' then begin
          AddErrMsg('Allocation in the following is invalid ' + chr(13) + s);
          Result := False;
          Exit;
        end;
      finally
        if Qry.Active then Qry.close;
        Qry.Free;
      end;
  end;
end;

class function TPQA._Schema: string;
begin
  Result := inherited;
end;
Function TPQA.ISStockMovement :Boolean;
begin
  REsult := False;
  if Assigned(Self.Owner) then
    if Self.Owner is TStockMovementLines then
      REsult := TStockMovementLines(Self.Owner).ISStockAdjustment;
end;
function TPQA.isEnforceAllocationValidation :Boolean;
begin
  if Sametext(Transtype , 'TSalesOrderInvoiceLines') then REsult := Appenv.CompanyPrefs.EnforceAllocationValidationinPI
  else result := Appenv.CompanyPrefs.EnforceAllocationValidation;
end;

function TPQA.ValidateAllocation: Boolean;
  procedure Validmsg(const alloatedqty: Double; const PQADetailtype: string);
  var
    s1: string;
  begin
    s1 := ProductName + ': The Quantity of ' + PQADetailtype + ' Allocated [' + FloattoStr(alloatedqty) + '] does not match the Quantity to be Allocated [' + FloattoStr(Self.UOMQty) + ']';
    if (not(Result)) then AddErrMsg(s1)
    else AddWarnMsg(s1);
  end;
  function HasTree :Boolean;
  begin
    REsult:= False;
    if Transtype = TSalesOrderLine.Classname then
      if assigned(Owner) then
        if owner is TSalesOrderLine then
          result := TSalesOrderLine(Owner).hastree;
  end;
begin
  InvalidDetailID := 0;
  InValidDetailtype := '';
  Result := True;
  Errmsg := '';
  Warnmsg := '';
  if CrossStockAdjustTransForinvoice then exit;
  if (not Assigned(Product)) or (Count = 0) then Exit;
  if not Active then if not((transtype = 'TProcTreePart') or (transtype = 'TProcTreePartIN') ) then exit;

  if (QtyValid) then begin  {Added this validation back as it was needed for manufacturing. Validation call was by-passed}
              if Product.Batch        then begin REsult := PQABatch.ValidateAllocation(HasTree); if InvalidDetailType <> '' then Validmsg(PQABatch.fdTotalUOMAllocated, PQABatch.PQADetailDesctype) ;
     end else if Product.Multiplebins then begin REsult := PQABins.ValidateAllocation (HasTree); if InvalidDetailType <> '' then Validmsg(PQABins.fdTotalUOMAllocated, PQABins.PQADetailDesctype) ;
     end else if Product.SnTracking   then begin REsult := PQASN.ValidateAllocation   (HasTree); if InvalidDetailType <> '' then Validmsg(PQASN.fdTotalUOMAllocated, PQASN.PQADetailDesctype) ;
     end;
  end;
  if result then DeleteRecordsWith0Qty;
end;

function TPQA.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
  if not result then
    exit;
       if Product.Batch        then result := PQABatch.Save
  else if Product.Multiplebins then result := PQABins.Save
  else if Product.SnTracking   then result := PQASN.Save;
  AddProductIDtosumQty;
end;
Procedure TPQA.AddProductIDtosumQty;
begin
  if Appenv.CompanyPrefs.doUpdateProductQtySum then
    TAfterTransList.Inst.AddProductIDtosumQty(TERPConnection (Connection.Connection), ProductId);
end;
procedure TPQA.Refreshall;
begin
  ResultStatus.Clear;
  if Product.Batch then begin
    PQABatch.CloseDB;
    PQABatch.OpenDB;
    if Product.SnTracking then begin
      PQABatch.PQABins.CloseDB;
      PQABatch.PQABins.OpenDB;
      if Product.SnTracking then begin
        PQABatch.PQABins.PQASN.CloseDB;
        PQABatch.PQABins.PQASN.OpenDB;
      end;
    end;
  end
  else if Product.Multiplebins then begin
    PQABins.CloseDB;
    PQABins.OpenDB;
    if Product.SnTracking then begin
      PQABins.PQASN.CloseDB;
      PQABins.PQASN.OpenDB;
    end;
  end
  else if Product.SnTracking then begin
    PQASN.CloseDB;
    PQASN.OpenDB;
  end;
end;

procedure TPQA.RemoveShippedAllocationFromBO;
begin
  if not isbo then exit;
       if Product.Batch        then PQABatch.RemoveShippedAllocationFromBO
  else if Product.Multiplebins then PQABins.RemoveShippedAllocationFromBO
  else if Product.SnTracking   then PQASN.RemoveShippedAllocationFromBO;

end;

procedure TPQA.RemoveShippedBOFromAllocation;
begin
  if isbo then exit;
       if Product.Batch        then PQABatch.RemoveShippedBOFromAllocation
  else if Product.Multiplebins then PQABins.RemoveShippedBOFromAllocation
  else if Product.SnTracking   then PQASN.RemoveShippedBOFromAllocation;

end;

procedure TPQA.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TPQA.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SameText(Sender.fieldname, 'Active') then begin
  end else if SameText(Sender.fieldname, 'UOM') then begin
    UnitOfMeasureID := tcDataUtils.GetUnitOfMeasureID(UnitOfMeasure, ProductID);
    if not RawMode then begin
      UOMMultiplier := tcDataUtils.getUnitMultiplier(UnitOfMeasureID);
      if UOMMultiplier <> 0 then begin
        if Qty <> 0 then UOMQty := Qty / UOMMultiplier
        else Qty := UOMQty * UOMMultiplier;
      end;
      //getnewDataset('delete from tblPQADetails where pqaID = ' + inttostr(ID), True);
      DeleteDetails;
    end;
  end
  else if SameText(Sender.fieldname, 'Qty') then begin
    if not RawMode then begin
      if Self.UnitOfMeasureID > 0 then begin
        UOMQty := Qty / UOMMultiplier;
        //getnewDataset('delete from tblPQADetails where pqaID = ' + inttostr(ID), True);
        DeleteDetails;
      end;
    end;
  end
  else if SameText(Sender.fieldname, 'MatrixRef') then begin
  end
  else if SameText(Sender.fieldname, 'UOMQty') then begin
    if not RawMode then begin
      if Self.UnitOfMeasureID > 0 then begin
        Qty := UOMQty * UOMMultiplier;
        //getnewDataset('delete from tblPQADetails where pqaID = ' + inttostr(ID), True);
        DeleteDetails;
      end;
    end;
  end;
end;

function TPQA.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

function TPQA.getTotalBatchQty: double;
begin
  result := 0;
  fdTotalBatchQty:= 0;
  try
    if not Product.batch then exit;
    if PQAbatch.Count =0 then exit;
    PQAbatch.IterateRecords(TotalBatchQtyCallback);
  finally
    result := fdTotalBatchQty;
  end;
end;
function TPQA.getTotalBOUOMBatchAllocatedQty: Double;
begin
  Result := 0;
  if not IsBo then exit;
  with getNewDataset('Select sum(UOMQty) UOMQty from tblpqadetails where PQAId = ' + inttostr(ID) +' and pqatype = ' +quotedstr(TPqaBatch.PQADetailtype), true) do try
    result := fieldbyname('UOMQty').asfloat;
  finally
    if active then close;
    Free;
  end;
end;

function TPQA.getTotalUOMBatchAllocatedQty: double;
begin
  Result := 0;
  if IsBo then exit;
  with getNewDataset('Select sum(UOMQty) UOMQty from tblpqadetails where PQAId = ' + inttostr(ID) +' and pqatype = ' +quotedstr(TPqaBatch.PQADetailtype), true) do try
    result := fieldbyname('UOMQty').asfloat;
  finally
    if active then close;
    Free;
  end;

end;

Procedure TPQA.TotalBatchQtyCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TPQABatch) then exit;
  if TPQABatch(Sender).BatchNo = '' then exit;
  fdTotalBatchQty :=fdTotalBatchQty +TPQABatch(Sender).Qty;
end;
function TPQA.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
  if not result then exit;
end;

function TPQA.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  Reserved := False;
  if Assigned(Self.Owner) then
    if Self.Owner is TProdQty then begin

      TransLineId := TProdQty(Self.Owner).ID;
      TransID := TProdQty(Self.Owner).HeaderID;
      allocType := TProdQty(Self.Owner).allocType;
      Transtype := TProdQty(Self.Owner).Classname;
      PostDb;
      EditDB;
    end;
end;
function TPQA.getPQAdetails: TPQADetails;
begin
  Result := TPQADetails(getContainerComponent(TPQADetails, 'PQAID = ' + inttostr(Self.ID)));
end;

function TPQA.GetPQABatch:TPQABatch;
begin
  Result := TPQABatch(getContainerComponent(TPQABatch, 'PQAID = ' + inttostr(Self.ID) + ' and ifnull(ParentRef,"") = ""'));
end;

function TPQA.GeTPQABins:TPQABins;
begin
  Result := TPQABins(getContainerComponent(TPQABins, 'PQAID = ' + inttostr(Self.ID) + ' and ifnull(ParentRef,"") = ""'));
end;

function TPQA.GeTPQASN:TPQASN;
begin
  Result := TPQASN(getContainerComponent(TPQASN, 'PQAID = ' + inttostr(Self.ID) + ' and ifnull(ParentRef,"") = ""'));
end;
function TPQA.GetAllPQABins: TPQABins;
begin
  Result := TPQABins(getContainerComponent(TPQABins, 'PQAID = ' + inttostr(Self.ID) ));
end;

function TPQA.GetAllPQASN: TPQASN;
begin
  Result := TPQASN(getContainerComponent(TPQASN, 'PQAID = ' + inttostr(Self.ID) ));
end;

function TPQA.getProduct: TProduct;
begin
  Result := nil;

  Result := TProduct(getContainerComponentifExists(TProduct));

  if (Result = nil) and Assigned(Self.Owner) then
    if Self.Owner is TProdQty then Result := TProdQty(Self.Owner).Product;
  if result = nil then
    Result := TProduct(getContainerComponent(TProduct, ProductID,'PARTSID' ,  Self.SilentMode, False, True, '', True));
end;

{ Property functions }
function TPQA.GetTransLineId: Integer; begin  Result := GetIntegerField('TransLineId');end;
function TPQA.GetTransID: Integer;begin  Result := GetIntegerField('TransID');end;
function TPQA.GetTransDate: TdateTime;begin  Result := GetDatetimeField('TransDate');end;
function TPQA.GetTranstype: string;begin  Result := GetStringField('TransType');end;
function TPQA.getallocType: string;begin  Result := GetStringField('Alloctype');end;
function TPQA.getBOUOMQty: Double;
begin
  result := 0;
  if isBo then result := UOMQty;
end;

function TPQA.GetIsBO: Boolean;begin  Result := GetBooleanField('IsBO');end;
function TPQA.GetIsList: Boolean;
begin
  result := false;
end;

function TPQA.getQty: Double;begin  Result := GetFloatField('Qty');end;
function TPQA.getUOMQty: Double;begin  Result := GetFloatField('UOMQty');end;
function TPQA.hasBatchAllocation: Boolean;begin  REsult := HasAllocationoftype(TPQABatch.PQADetailtype);end;
function TPQA.hasBinAllocation: Boolean;begin  REsult := HasAllocationoftype(TPQABins.PQADetailtype);end;
function TPQA.hasSNAllocation: Boolean;begin  REsult := HasAllocationoftype(TPQASN.PQADetailtype);end;
function TPQA.HasAllocationoftype(const Detailtype:String):Boolean;
var
  fs:String;
begin
  result:= False;
  if PQaDetails.Count =0 then exit;
  fs:=PQaDetails.Filter;
  try
    if fs = '' then PQaDetails.Filter :='PQAType = ' +quotedstr(DetailType) else PQaDetails.Filter :='(' +PQaDetails.Filter +')' + ' and PQAType = ' +quotedstr(DetailType);
    PQaDetails.filtered := TRue;
    PQaDetails.Filtered := TRue;
    Result := PQaDetails.count>0;
  finally
    PQaDetails.Filter := fs;
    PQaDetails.filtered := trim(fs)<>'';
  end;
end;
function TPQA.GetUOM: string;begin  Result := GetStringField('UOM');end;
function TPQA.GetUOMMultiplier: Double;begin  Result := GetFloatField('UOMMultiplier');end;

function TPQA.GetUOMNameProductKey: string;
begin
  if UnitOfMeasureID > 0 then Result := TUnitOfMeasure.IDToggle(UnitOfMeasureID, Connection.Connection)
  else Result := '';
end;

function TPQA.GetUnitOfMeasureID: Integer;begin  Result := GetIntegerField('UOMID');end;

function TPQA.getDepartmentID: Integer;begin  Result := GetIntegerField('DepartmentID');end;

function TPQA.GetDeptClassName: string;
begin
  if DepartmentID > 0 then Result := TDeptClass.IDToggle(DepartmentID, Connection.Connection)
  else Result := '';
end;

function TPQA.getActive: Boolean;begin  Result := GetBooleanField('Active');end;
function TPQA.GetProductID: Integer;begin  Result := GetIntegerField('ProductID');end;
function TPQA.GetProductName: string;begin  Result := GetStringField('ProductName');end;
function TPQA.GetProductPrintName: string;begin  Result := GetStringField('ProductPrintName');end;
procedure TPQA.SetTransLineId(const Value: Integer);begin  SetIntegerField('TransLineId', Value);end;
procedure TPQA.SetTransID(const Value: Integer);begin  SetIntegerField('TransID', Value);end;
procedure TPQA.SetTransDate(const Value: TdateTime);begin  SetDatetimeField('TransDate', Value);end;
procedure TPQA.SetTransType(const Value: string);begin  SetStringField('TransType', Value);end;
procedure TPQA.SetAlloctype(const Value: string);begin  SetStringField('Alloctype', Value);end;
procedure TPQA.SetIsBO(const Value: Boolean);begin
  SetBooleanField('IsBO', Value);
end;
procedure TPQA.SetMatrixRef(const Value: string);begin  SetStringField('MatrixRef', Value);end;
procedure TPQA.setQty(const Value: Double);begin
  SetFloatField('Qty', Value);
end;
procedure TPQA.setUOMQty(const Value: Double);begin  SetFloatField('UOMQty', Value);end;
function TPQA.TotalAllocated: Double;
begin
  Result := 0;
  if PQABatch.count > 0 then
    result:= PQABatch.TotalAllocated
  else if PQABins.count > 0 then
    result:= PQABins.TotalAllocated
  else if PQASN.count > 0 then
    result := PQASN.TotalAllocated;
end;
function TPQA.TotalUOMAllocated: Double;
begin
  Result := 0;
  if PQABatch.count > 0 then
    result:= PQABatch.TotalUOMAllocated
  else if PQABins.count > 0 then
    result:= PQABins.TotalUOMAllocated
  else if PQASN.count > 0 then
    result := PQASN.TotalUOMAllocated;
end;

procedure TPQA.SetUOM(const Value: string);begin  SetStringField('UOM', Value);end;
procedure TPQA.SetUOMMultiplier(const Value: Double);begin  SetFloatField('UOMMultiplier', Value);end;
procedure TPQA.SetUOMNameProductKey(const Value: string);
begin
  if Value <> '' then begin
    with SharedUOM_UnitProduct_Obj(Value) do begin
      if count > 0 then begin
        UnitOfMeasureID := ID;
        UnitOfMeasure := UOMName;
      end else begin
        UnitOfMeasureID := 0;
        UnitOfMeasure := '';
      end;
    end;

  end else begin
    UnitOfMeasureID := 0;
    UnitOfMeasure := '';
  end;
end;

procedure TPQA.SetUnitOfMeasureID(const Value: Integer);
begin
  SetIntegerField('UOMID', Value);
end;

procedure TPQA.SetDepartmentID(const Value: Integer);
begin
  SetIntegerField('DepartmentID', Value);
end;

procedure TPQA.SetDeptClassName(const Value: string);
begin
  if Value <> '' then DepartmentID := TDeptClass.IDToggle(Value, Connection.Connection)
  else DepartmentID := 0;
end;

procedure TPQA.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TPQA.SetProductID(const Value: Integer);
begin
  SetIntegerField('ProductID', Value);
end;

procedure TPQA.SetProductName(const Value: string);begin  SetStringField('ProductName', Value);end;
procedure TPQA.SetProductPrintName(const Value: string);
begin
  SetStringField('ProductPrintName', Value);
end;

procedure TPQA.CreateInstance;
begin
  if Owner is TProdQty then
    if Assigned(TProdQty(Owner).ObjInstanceToClone) then ObjInstanceToClone := TProdQty(TProdQty(Owner).ObjInstanceToClone).PQA;
end;

function TPQA.InTrans: Boolean;
begin
  Result := False;
  if SysUtils.SameText(allocType, 'IN') then Result :=True;// not(IsBO);
  if not(Result)  then begin
    if Qty < 0 then Result := True;
  end else if Qty<0 then
    Result := False;
end;

procedure TPQA.DeleteDetails;
var
  ds: TDataSet;
  msg: string;
begin
  ds := GetNewDataset('select * from tblpqadetails where PQAID = ' + IntToStr(ID),true);
  try
    while not ds.Eof do begin
      if not TDeletedItem.AddDeleted('tblPQADetails',
        'TPQADetails',
        ds.FieldByName('GlobalRef').AsString,
        ds.FieldByName('PQADetailsID').AsInteger,
        Connection.Connection,msg) then
          raise Exception.Create('Error - Unable to delete PQADEtails: '+ msg);

      ds.Next;
    end;
  finally
    ds.Free;
  end;
end;

procedure TPQA.DeleteRecordsWith0Qty;
var
  strSQL: string;
  msg: string;
begin
  strSQL := 'Select * from tblpqadetails where (qty=0 and UOMqty = 0) and (boqty=0 and boUOMqty = 0) and PQAId = ' + inttostr(ID);
  with getnewDataset(strSQL, True) do
    try
      if recordcount = 0 then Exit;
      first;
      while Eof = False do begin
        //Delete;
        if not TDeletedItem.AddDeleted('tblPQADetails',
                                       'TPQADetails',
                                       FieldByName('GlobalRef').AsString,
                                       FieldByName('PQADetailID').AsInteger,
                                       Self.Connection.Connection,msg) then

        raise Exception.Create('Error - Unable to delete PQADEtails: '+ msg);
        Next;
      end;
      Refreshall;
    finally
      if Active then close;
      Free;
    end;
end;
function TPQA.getMatrixRef: string;
begin
  Result := GetStringField('MatrixRef');
end;

function TPQA.getPOnumber: Integer;
begin
  Result := 0;
  if Assigned(Self.Owner) and (Self.Owner.classnameis('TPurchaseOrderLine')) then
    if Assigned(Self.Owner.Owner) and (Self.Owner.Owner.classnameis('TPurchaseOrder')) then Result := GetInt64Prop(TBusObj(Self.Owner.Owner), 'ID');
end;

procedure TPQA.AddErrMsg(const Value: string);
begin
  if fsErrMsg <> '' then fsErrMsg := fsErrMsg + chr(13) + chr(13);
  fsErrMsg := fsErrMsg + Value;
end;

procedure TPQA.AddWarnMsg(const Value: string);
begin
  // ignore the qty mismatch error for stock movements as its possible to adjust a different qty in allocation
  if Transtype = TStockMovementLines.classname then
       if pos('does not match the Quantity to be Allocated' , value) <>0 then Exit;


  if fsWarnmsg <> '' then fsWarnmsg := fsWarnmsg + chr(13) + chr(13);
  fsWarnmsg := fsWarnmsg + Value;
end;

function TPQA.getProductClass: TProductClass;
begin
  Result := nil;
  if (ProductID <> 0) and (DepartmentID <> 0) then
      Result := TProductClass(getContainerComponent(TProductClass, 'ProductID = ' + inttostr(ProductID) + ' and ClassID = ' + inttostr(DepartmentID), True, False));
end;

function TPQA.IsRefundTrans: Boolean;
begin
  Result := SysUtils.SameText(Transtype, TRefundSaleLine.Classname);
end;

function TPQA.IsSalesOrderPQA: Boolean;
begin
  REsult := Sametext(Transtype , 'TSalesOrderLine') or
          Sametext(Transtype , 'TProcTreePart') or
          Sametext(Transtype , 'TProcTreePartIN') or
          Sametext(Transtype , 'TProcTreePartINDONE') ;

end;

function TPQA.GetUOMOrderQty: Double;
begin
  Result := 0;
  if (Assigned(Self.Owner)) and (Self.Owner is TProdQty) then Result := TProdQty(Self.Owner).UOMOrderQty;
end;

function TPQA.getREserved: Boolean;
begin
  Result := GetBooleanField('Reserved');
end;

procedure TPQA.setREserved(const Value: Boolean);
begin
  SetBooleanField('Reserved', Value);
end;

function TPQA.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not Result then Exit;
  //CreateProductClass;
  updateReserved;
end;

procedure TPQA.updateReserved;
begin
  if Assigned(Self.Owner) then
    if Self.Owner is TPOSLaybylines then Reserved := not(TPOSLaybylines(Self.Owner).ISFullyPaid);
end;

function TPQA.PQAdetailtablename: string;
begin
  Result := 'tblPQADetails';
end;

function TPQA.PQAtablename: string;
begin
  Result := 'tblPQA';
end;

function TPQA.QtyValid: Boolean;
begin
  Result := False;
  if Assigned(Owner) then
    if owner is TProdQty then
      result := TProdQty(Owner).QtyValid;
end;

function TPQA.DoBeforeClose(Sender: TDatasetBusObj): Boolean;
begin
     result := inherited DoBeforeClose(sender);
     if not result then exit;
end;

function TPQA.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeDelete(Sender);
  if not Result then Exit;
  if Product.Batch then begin
    PQABatch.Deleteall(true);
  end
  else if Product.Multiplebins then begin
    PQABins.Deleteall(true);
  end
  else if Product.SnTracking then begin
    PQASN.Deleteall(true);
  end;
  AddProductIDtosumQty;
end;

function TPQA.getProductDEfaultbinID: Integer;
begin
  Result := TProductClass.DefaultbinId(ProductID, DepartmentID)
end;

{ TPQABatch }
function TPQABatch.ValidateData: Boolean;
begin
  if Batchno = '' then begin
    ResultStatus.AddItem(False, rssWarning, 0, 'Batch number should not be blank');
    Result := False;
    Exit;
  end;
  Result := inherited ValidateData;
end;

constructor TPQABatch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

class function TPQABatch.PQADetailtype: string;
begin
  Result := 'Batch';
end;

class function TPQABatch.XMLBranchName: string;
begin
  Result := 'Batches';
end;

function TPQABatch.getbatchno: string;
begin
  Result := PQAValue;
end;
function TPQABatch.getTruckLoadNo: string;
begin
  Result := GetStringField('TruckLoadNo');
end;

function TPQABatch.getExpiryDate: TdateTime;
begin
  Result := ExpiryDate;
end;

function TPQABatch.getsalesbatches: Tsalesbatches;
begin
  Result := Tsalesbatches(getContainerComponent(Tsalesbatches, 'SalesPQADetailsID = ' + inttostr(ID) + ' or  ManPQAdetailsID = ' + inttostr(Self.PQAID)));
end;

procedure TPQABatch.InactivateAllCallback(const Sender: TBusObj;  var Abort: boolean);
begin
  if Product.MultipleBins then PQABins.InactivateAll
  else if Product.SnTracking then PQASN.InactivateAll;
  inherited;
end;

procedure TPQABatch.setBatchno(const Value: string);
begin
  PQAValue := Value;
end;
procedure TPQABatch.setTruckLoadNo(const Value: string);
begin
  SetStringfield('TruckLoadNo' , Value);
end;

procedure TPQABatch.LoadFromXMLNode(const node: IXMLNode);
begin
  SetPropertyFromNode(node, 'Batchno');
  SetPropertyFromNode(node, 'TruckLoadNo');
  SetDAtetimePropertyFromNode(node, 'BatchExpiryDate');
  inherited LoadFromXMLNode(node);
end;

function TPQABatch.NextSeqBatchNo: string;
var
  bm: TBookmark;
  LastBatchNo: string;
  s: string;
  x: integer;
  iBatch: integer;
begin
  result := '';
  if Count > 0 then begin
    Dataset.DisableControls;
    try
      bm := Dataset.GetBookmark;
      try
        Dataset.Last;
        LastBatchNo := BatchNo;
        s := '';
        x := Length(LastBatchNo);
        while x > 0 do begin
          if CharInSet(LastBatchNo[x], ['0'..'9']) then
            s := LastBatchNo[x] + s
          else
            break;
          dec(x);
        end;
        iBatch := StrToIntDef(s,0);
        Inc(iBatch);
        s := IntToStr(iBatch);
//        s := IntToStr(Inc(StrToInt(s)));
        while Length(s) < (Length(LastBatchNo) - x) do
          s := '0' + s;
        if x > 0 then begin
          s := Copy(LastBatchNo,1,x) + s;
        end;
        result := s;
        Dataset.GotoBookmark(bm);
      finally
        Dataset.FreeBookmark(bm);
      end;
    finally
      Dataset.EnableControls;
    end;
  end;

  if result = '' then
    result := 'Batch01';
end;

procedure TPQABatch.SaveToXMLNode(const node: IXMLNode);
begin
  AddXMLNode(node, 'Batchno', Batchno);
  AddXMLNode(node, 'TruckLoadNo', TruckLoadNo);
  AddXMLNode(node, 'BatchExpirtyDate', BatchExpiryDate);
  inherited SaveToXMLNode(node);
end;

procedure TPQABatch.setExpiryDate(const Value: TdateTime);
begin
  ExpiryDate := Value;
end;

function TPQABatch.getDescription: string;
begin
  Result := Batchno;
  if ExpiryDate <> 0 then Result := Result + formatDatetime('[dd-mm-yyyy]', ExpiryDate);
end;

//function TPQABatch.getDetailsClassBatch: TPQADetailsClassBatch;
//begin
//  Result := TPQADetailsClassBatch(PQADetailsClass);
//end;

class function TPQABatch.XMLNodeName: string;
begin
  Result := PQADetailtype;
end;

function TPQABatch.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
var
  Msg:String;
begin
  Result := inherited DoBeforeDelete(Sender);
  if not Result then Exit;

  if salesbatches.count > 0 then begin
    salesbatches.first;
    while salesbatches.Dataset.Eof = False do begin
      if not TDeletedItem.AddDeleted(salesbatches,msg) then
        raise Exception.Create('Error - Could not delete Related Products Allocation: ' + msg);
    end;
  end;

end;

function TPQABatch.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not Result then Exit;
  if Batchno = '' then Result := False;
end;

procedure TPQABatch.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if sametext(Sender.fieldname , 'Qty') or
     sametext(Sender.fieldname , 'UOMQty') then begin
      SendEvent(BusObjEvent_Change, BusObjEvent_QtyChanged, Self);
  end else if sametext(Sender.fieldname , 'CUSTFLD1') then begin
    SendEvent(BusObjEvent_Change, BusObjEvent_CustFld1Changed, Self);
  end else if sametext(Sender.fieldname , 'CUSTFLD4') then begin
    SendEvent(BusObjEvent_Change, BusObjEvent_CustFld4Changed, Self);
  end else if sametext(Sender.fieldname , 'CUSTFLD6') then begin
    SendEvent(BusObjEvent_Change, BusObjEvent_CustFld6Changed, Self);
  end else if sametext(Sender.fieldname , 'CUSTFLD7') then begin
    SendEvent(BusObjEvent_Change, BusObjEvent_CUSTFLD7Changed, Self);
  end;
end;

destructor TPQABatch.Destroy;
begin
  inherited;
end;

function TPQABatch.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;

end;

function TPQABatch.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

class function TPQABatch.PQADetailDesctype: string;
begin
  Result := 'Batch';
end;

{ TPQABins }

function TPQABins.ValidateData: Boolean;
var
  strSQL: string;
  cleanvolumeused, volumeUsed: Double;
begin
  if (BinID = 0) then begin { force to create if its blank }
    SendEvent(BusObjEvent_Change, BusObjEventVal_ProductBinNotFound, Self);
    BinID := TProductBin.IDToggle(DepartmentID, fsBinLocation, fsBinNumber, Self.Connection.Connection);
  end;
  if (BinID = 0) then begin
    ResultStatus.AddItem(False, rssWarning, 0, 'BinLocation / Binnumber should not be blank');
    Result := False;
    Exit;
  end;

  cleanvolumeused := 0;
  volumeUsed := 0;
  if (InTrans) and (AppEnv.CompanyPrefs.EnforceBinVolume) then begin
    PostDb;
    strSQL := 'SELECT Sum(Qty * ' + '(Select Volume from tblparts where PartsId = ' + inttostr(ProductID) + ')) as totalVolume' + '  FROM tblpqadetails Where BinID = ' + inttostr(BinID) +
      ' and PQAID= ' + inttostr(PQAID);
    with getnewDataset(strSQL, False) do
      try
        if recordcount > 0 then cleanvolumeused := fieldByname('totalVolume').asFloat;
      finally
        if Active then close;
        Free;
      end;
    with getnewDataset(strSQL, True) do
      try
        if recordcount > 0 then volumeUsed := fieldByname('totalVolume').asFloat;
      finally
        if Active then close;
        Free;
      end;

    if ProductBin.Binvolume - ProductBin.BinvolumeUsed < (volumeUsed - cleanvolumeused) then begin
      strSQL := 'Bin ' + Binlocation + ' / ' + Binnumber + ' has a remaining volume of ' + FloattoStr(ProductBin.Binvolume - ProductBin.BinvolumeUsed) + ' Units and needs ' +
        FloattoStr(Qty * Product.volume) + ' units to store ' + FloattoStr(UOMQty) + ' ' + TPQA(Self.Owner).UnitOfMeasure + ' of ' + Product.ProductName;
      strSQL := strSQL + chr(13) + chr(13) + 'Please select a different Bin or split the Quantity over a number of Bins.';
      ResultStatus.AddItem(False, rssWarning, 0, strSQL);
      Result := False;
      Exit;
    end;
  end;
  Result := inherited ValidateData;
end;

procedure TPQABins.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if (ChangeType = dcLoad) and (count = 0) then Exit;
  fsBinNumber := TProductBin.IDToggle(BinID, False, Self.Connection.Connection);
  fsBinLocation := TProductBin.IDToggle(BinID, True, Self.Connection.Connection);
end;

function TPQABins.getDescription: string;
begin
  Result := TProductBin.IDToggle(BinID, True, Self.Connection.Connection) + ' ' + TProductBin.IDToggle(BinID, False, Self.Connection.Connection);
end;

//function TPQABins.getDetailsClassBin: TPQADetailsClassBin;
//begin
//  Result := TPQADetailsClassBin(PQADetailsClass);
//end;

class function TPQABins.PQADetailtype: string;
begin
  Result := 'Bin';
end;

constructor TPQABins.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fsBinNumber := '';
  fsBinLocation := '';
  ExportExcludeList.Add('boqty');
  ExportExcludeList.Add('bouomqty');
end;

procedure TPQABins.LoadFromXMLNode(const node: IXMLNode);
begin
  SetPropertyFromNode(node, 'BinID');
  SetPropertyFromNode(node, 'BinLocation');
  SetPropertyFromNode(node, 'Binnumber');
  inherited LoadFromXMLNode(node);
end;

procedure TPQABins.SaveToXMLNode(const node: IXMLNode);
begin
  // AddXMLNode(node,'BinID' ,BinID);
  AddXMLNode(node, 'Binlocation', Binlocation);
  AddXMLNode(node, 'Binnumber', Binnumber);
  inherited SaveToXMLNode(node);
end;

function TPQADetails.getBinID: Integer;
begin
  Result := GetIntegerField('BinID')
  // Result := PQAValue;
end;

procedure TPQADetails.setBinID(const Value: Integer);
begin
  SetIntegerField('BinID', Value);
  if PQAType = 'Bin' then
    if PQAValue <> inttostr(Value) then
      try PQAValue := inttostr(Value);
      except
        on E: Exception do begin
          ResultStatus.AddItem(False, rssWarning, 0, 'SetbinId:' + E.message);
        end;
      end;
end;

procedure TPQADetails.SetBOQty(const Value: double);
begin
  SetFloatField('BOQty', Value);
end;

procedure TPQADetails.SetBOUOMQty(const Value: double);
begin
  SetFloatField('BOUOMQty', Value);
end;

function TPQABins.getBinlocation: string;
begin
  Result := TProductBin.IDToggle(BinID, True, Self.Connection.Connection);
  // result := fsBinLocation;
end;

function TPQABins.getBinnumber: string;
begin
  Result := TProductBin.IDToggle(BinID, False, Self.Connection.Connection);
  // result := fsBinNumber;
end;

procedure TPQABins.setBinlocation(const Value: string);
begin
  fsBinLocation := Value;
  BinID := TProductBin.IDToggle(DepartmentID, fsBinLocation, fsBinNumber, Self.Connection.Connection);
  if (fsBinLocation <> '') and (fsBinNumber <> '') and (BinID = 0) then SendEvent(BusObjEvent_Change, BusObjEventVal_ProductBinNotFound, Self);

end;

procedure TPQABins.setBinnumber(const Value: string);
begin
  fsBinNumber := Value;
  BinID := TProductBin.IDToggle(DepartmentID, fsBinLocation, fsBinNumber, Self.Connection.Connection);
  if (fsBinLocation <> '') and (fsBinNumber <> '') and (BinID = 0) then SendEvent(BusObjEvent_Change, BusObjEventVal_ProductBinNotFound, Self);
end;

procedure TPQABins.setQty(const Value: Double);
begin
  if Qty = value then exit;
  Doupdatevolume_used(Qty , Value);
  inherited;
end;

procedure TPQABins.setUOMQty(const Value: Double);
begin
  inherited;

end;

procedure TPQABins.setValue(const aValue: Integer);
begin
  PQAValue := inttostr(aValue);
end;

class function TPQABins.XMLBranchName: string;
begin
  Result := 'Bins';
end;

function TPQABins.Save: Boolean;
begin
  IterateRecords(SaveCallback);
  Result := inherited Save;
end;

procedure TPQABins.SaveCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  //
end;
procedure TPQABins.Doupdatevolume_used(acleanQty, aNewQty:Double);
var
  strSQL: string;
begin
  try
    strSQL := 'update tblProductbin Set volume_used = volume_used + ' + FloattoStr(aNewQty * Product.volume - acleanQty * Product.volume) + ' where BINId = ' + inttostr(BinID);
    PostList.AddQuery(strSQL, BinID, TProductBin.GetBusObjectTablename);
  Except
    on E:Exception do begin
      if devmode then
        ResultStatus.AddItem(False, rssWarning, 0, 'SetbinId:' + E.message, true);
    end;
  end;
end;

class function TPQABins.XMLNodeName: string;
begin
  Result := PQADetailtype;
end;

class function TPQABins._Schema: string;
begin
  Result := inherited;
  TBOSchema.AddRefType(Result, 'TProductBin', 'ProductBinObj', 'Value', 'ID');
end;

function TPQABins.getProductBin: TProductBin;
begin
  Result := TProductBin(getContainerComponent(TProductBin, 'binId= ' + inttostr(Self.BinID)));
end;

function TPQABins.getValue: Integer;
begin
  Result := StrToIntDef(PQAValue, 0);
end;

procedure TPQABins.InactivateAllCallback(const Sender: TBusObj;  var Abort: boolean);
begin
  if Product.SnTracking then PQASN.InactivateAll;
  inherited;
end;

function TPQABins.getallocType: string;
begin
  Result := '';
  if Assigned(Self.Owner) then
    if Self.Owner is TPQA then Result := TPQA(Self.Owner).allocType;
end;

destructor TPQABins.Destroy;
begin
  inherited;
end;

function TPQABins.DoAfterClose(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterClose(Sender);
  if not Result then Exit;

end;

function TPQABins.DoAfterOpen(Sender: TdatasetBusobj): Boolean;
begin
  Result := inherited DoAfterOpen(Sender);
  if not Result then Exit;
end;

function TPQABins.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not Result then Exit;
  if PQAValue <> inttostr(BinID) then PQAValue := inttostr(BinID);
  if BinID = 0 then Result := False;
end;

procedure TPQABins.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SameText(Sender.fieldname, 'Value') then begin
    if not RawMode then begin
      if ISInteger(Sender.Value) then
        if BinID <> Sender.AsInteger then BinID := Sender.AsInteger;
    end;
  end;
end;

procedure TPQABins.PostDb;
begin
  try inherited;
  except
    on E: Exception do begin
      ResultStatus.AddItem(False, rssWarning, 0, 'postdb.' + E.message);
    end;
  end;

end;

class function TPQABins.PQADetailDesctype: string;
begin
  Result := 'Bin';
end;

{ TPQASN }
constructor TPQASN.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ExportExcludeList.Add('boqty');
  ExportExcludeList.Add('bouomqty');
  AllowFractionQty := False;
end;

destructor TPQASN.Destroy;
begin
  inherited;
end;

function TPQASN.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  if pqa.qty >0 then
       UOMQty := 1
  else UOMQty := 0-1;
end;

function TPQASN.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TPQASN.getDescription: string;
begin
  Result := SerialNumber;
end;

//function TPQASN.getDetailsClassSN: TPQADetailsClassSN;
//begin
//  Result := TPQADetailsClassSN(PQADetailsClass);
//end;

class function TPQASN.PQADetailtype: string;
begin
  Result := 'SN';
end;

function TPQASN.ValidateData: Boolean;
begin
  if SerialNumber = '' then begin
    ResultStatus.AddItem(False, rssWarning, 0, PQA.Productname + ' - Serial number should not be blank');
    Result := False;
    Exit;
  end;
  if not ValidateSN then begin
    ResultStatus.AddItem(False, rssWarning, 0, PQA.warnmsg);
    Result := False;
    Exit;
  end;
  { Dofield changes does this validation - makes ure the import also works with the DoFieldOnChange }
  Result := inherited ValidateData;
  { we are not validating the Serial number for its uniqueness and availability
    Following shoudl be the validation incase if we need to
    New : Unique no
    Purchase order with a +ive Qty
    Buidl group(Header)
    StockAdjust(IN)

    existing and available
    Purchaseorder wit a -ive qty
    Salesorder/invoice/CashSale/POS
    Buildgroupline/varbuildgorupline
    unbuildroup/unvarbuildgroup
    Stockadjustment.out
    StockTransfter.out

    existing.OUT
    refund
    unBuildGroup/unvarbuildgroup
    stockadjustment.in
    stocktransfer.in
  }
end;

function TPQASN.getSN: string;
begin
  Result := PQAValue;
end;

procedure TPQASN.SetSN(const Value: string);
begin
  PQAValue := Value;
end;

procedure TPQASN.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited LoadFromXMLNode(node);
  SetPropertyFromNode(node, 'SerialNumber');
end;

procedure TPQASN.SaveToXMLNode(const node: IXMLNode);
begin
  inherited SaveToXMLNode(node);
  AddXMLNode(node, 'SerialNumber', SerialNumber);
end;

class function TPQASN.XMLBranchName: string;
begin
  Result := 'SNs';
end;

class function TPQASN.XMLNodeName: string;
begin
  Result := PQADetailtype;
end;

function TPQASN.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
Result := inherited DoBeforePost(Sender);
  if not Result then Exit;
  //if UOMQty <> 1 then UOMQty := 1;
  if AllowFractionQty then begin
    if (pqa.qty >0) and (UOMQty <=0) then
      UOMQty := 1
    else if (pqa.qty <0) and (UOMQty >=0) then
      UOMQty := 0-1;
  end else begin
    if (pqa.qty >0) and (UOMQty <> 1) then
      UOMQty := 1
    else if (pqa.qty <0) and (UOMQty <> -1) then
      UOMQty := 0-1;
  end;

  if Qty <> UOMQty*UOMMultiplier then Qty := UOMQty*UOMMultiplier;
  if SerialNumber = '' then Result := False;
end;

class function TPQASN.PQADetailDesctype: string;
begin
  Result := 'Serial Number'
end;

procedure TPQASN.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SysUtils.SameText(Sender.fieldname, 'Value') then begin
//    if not RawMode then begin
//      if (Sender.Value <> '') then
//        if not ValidateSN then CancelDB;
//    end;
  end;
end;

function TPQASN.ValidateSN: Boolean;
var
  errMsg: string;
begin
  errMsg := '';
  result := TRue;
  if Assigned(PQA) and Assigned(pqa.Owner) and (pqa.Owner is TProdQty) and  not(TProdQty(pqa.owner).active) then exit;
  if (pqa.transtype <> 'THireLinesIN') and (pqa.transtype <> 'THireLines') and (pqa.transtype <> 'TProcProgressOUT') and (pqa.transtype <> 'TProcProgressIn') and (pqa.transtype <> 'TProcTreePartIN')  and (pqa.transtype <> 'TProcTreePart') then begin
    if (pqa.transtype = 'TSalesOrderLine') (*and (pqa.active=False)*) then else begin // ignore the validation - temprary solution for progress build building it after salesorder date
      if rawmode then Result := True
      else
      result := ValidateSN(Serialnumber, ID, ProductID,departmentId,  TERPconnection(Self.Connection.Connection), InTrans, errMsg , pqa.transdate);
      if not(result) and (errmsg<>'') then begin
//        ResultStatus.AddItem(False, rssWarning, 0, ErrMsg);
        PQA.warnmsg :=  errmsg;
      end;
    end;
  end;
end;

Class function TPQASN.ValidateSN(const SN:String; iID, iProdID, iDeptID:integer; conn :TERPConnection; InTrans :Boolean; var ErrMsg:String; pqatransdate:TdateTime =0): Boolean;
var
  strSQL: string;
  Qry :TERPQuery;
begin
  Result := False;
  //strSQL := SQL4ProductAvailableQty(pqatransdate, '', tDetailswithSno, iProdID, iDeptID, '', 0, '', '', SN, tAvailable, '', 'PQASN.PQADetailID <> ' + inttostr(iID), iID , false , false , False);
  strSQL := SQL4ProductQty(incsecond(pqatransdate,1), '', tDetailswithSno, iProdID, iDeptID, '', 0, '', '', SN, tAvailable, '', 'PQASN.PQADetailID <> ' + inttostr(iID), iID , false , false , False, true , true);
  Qry := DbSharedObj.GetQuery(conn);
  try
  //with qry do begin
      if Qry.active then Qry.close;
      Qry.SQL.text :=  strSQL;
      Qry.open;
      Qry.filterOptions := Qry.filterOptions + [foCaseInsensitive];
      Qry.filter := 'Serialnumber = ' + Quotedstr(SN); // + ' and PQADetailID <> ' +IntToStr(ID);
      Qry.Filtered := True;
      if InTrans then begin
          if  (Qry.recordcount > 0) and (Qry.Fieldbyname('Qty').AsFloat>0) then
            errMsg :=  'Product :' + Quotedstr(tcdatautils.getproduct(iProdID)) +NL+ 'Serial number ' + Quotedstr(SN) + ' already exists as on '+quotedstr(formatDatetime(shortdateformat +' HH:nn:ss am/pm' , pqatransdate))
          else result := True;
      end else begin
        if  (Qry.recordcount <= 0  )then begin
          strSQL := 'Serialno = ' + Quotedstr(SN) + ' and (ifnull(ProductId,0) = ' + inttostr(iProdID) + ' or ifnull(ProductId,0) = 0 )' + ' and Active = "T" ' +
            ' and Serialno not in (Select ifnull(Value,"") from tblPQADEtails where tblPQADEtails.PQAType =' + Quotedstr(TPQASN.PQADetailtype) + ' and  tblPQADEtails.PQADetailID <> ' + inttostr(iID)+' )';
          with TSerialJobNumbers.CreateWithNewConn(nil) do
            try
              Connection.Connection := conn;
              LoadSelect(strSQL);
              if count > 0 then begin
                if userLock.Lock('tblSerialNumbers', fieldByname('ID').AsInteger, LockGroupName) then begin
                  Result := True;
                  Exit;
                end;
              end;
            finally
              { he product details are changed - and the object is killed here
                but commit transaction should commit the changes }
                Free;
            end;
          errMsg := 'Product :' + Quotedstr(tcdatautils.getproduct(iProdID)) +NL+ 'Serial number : ' + Quotedstr(SN) + ' doesn''t exist as on '+quotedstr(formatDatetime(shortdateformat +' HH:nn:ss am/pm' , pqatransdate));
        end else if (Qry.Fieldbyname('Qty').AsFloat <=0) then begin
          errMsg := 'Product :' + Quotedstr(tcdatautils.getproduct(iProdID)) +NL+ 'Serial number : ' + Quotedstr(SN) + ' already Sold / Used as on '+quotedstr(formatDatetime(shortdateformat +' HH:nn:ss am/pm' , pqatransdate));
        end else begin
          Result := True;
        end;
      end;
    //end;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;

function TPQASN.Save: Boolean;
begin
  AllRecsValid := true;
  IterateRecords(SaveCallback);
  if not AllRecsValid then begin
    result := false;
    exit;
  end;
  Result := inherited Save;
end;

procedure TPQASN.SaveCallback(const Sender: TBusObj; var Abort: Boolean);
var
  strSQL: string;
begin
  Abort := not ValidateData;
  if Abort then begin
    AllRecsValid := false;
    exit;
  end;


  if InTrans then Exit;
  with TSerialJobNumbers.Create(Self) do
    try
      Connection := Self.Connection;
      LoadSelect('Serialno = ' + Quotedstr(SerialNumber));
      if count > 0 then
        if (ProductID <> Self.ProductID) then begin
          strSQL := 'UPDATE tblSerialNumbers ' + ' SET ProductId = ' + inttostr(Self.ProductID) + ' , ProductName = ' + Quotedstr(tcDataUtils.getProduct(Self.ProductID)) + ' WHERE Serialno = ' +
            Quotedstr(SerialNumber) + ' AND  ifnull(ProductId,0) <> ' + inttostr(Self.ProductID);
          PostList.AddQuery(strSQL, ID, TSerialJobNumbers.GetBusObjectTablename);
        end;
    finally Free;
    end;
end;

{ TPQADetails }
function TPQADetails.GetPQABatch;
begin
  Result := TPQABatch(getContainerComponent(TPQABatch, 'PQAType = ' + Quotedstr(TPQABatch.PQADetailtype) + ' and PQAID = ' + inttostr(Self.PQAID) + ' and ParentRef = ' + Quotedstr(Self.Globalref)));
end;

function TPQADetails.GeTPQABins;
begin
  Result := TPQABins(getContainerComponent(TPQABins, 'PQAType = ' + Quotedstr(TPQABins.PQADetailtype) + ' and PQAID = ' + inttostr(Self.PQAID) + ' and ParentRef = ' + Quotedstr(Self.Globalref)));
end;

function TPQADetails.getPQADetailsClass: TPQADetailsClass;
begin
  Result := TPQADetailsClass(getContainerComponent(TPQADetailsClass, 'PQADetailID = ' + inttostr(ID) + ' and PQAID = ' + inttostr(Self.PQAID)));
end;

function TPQADetails.GeTPQASN;
begin
  Result := TPQASN(getContainerComponent(TPQASN, 'PQAType = ' + Quotedstr(TPQASN.PQADetailtype) + ' and PQAID = ' + inttostr(Self.PQAID) + ' and ParentRef = ' + Quotedstr(Self.Globalref)));
end;

function TPQADetails.IsOrChildof(CompClass: TPersistentClass): Boolean;
var
  obj: TComponent;
begin
  Result := False;
  obj := Self;
  while obj <> nil do begin
    if obj is CompClass then begin
      Result := True;
      Exit;
    end;
    obj := obj.Owner;
  end;
end;

function TPQADetails.GetTranstype: string;
begin
  Result := '';
  if Assigned(Self.Owner) then
    if Self.Owner is TPQA then Result := TPQA(Self.Owner).Transtype;
end;

function TPQADetails.getProduct: TProduct;
begin
  Result := nil;
  if Assigned(Self.Owner) then
    if Self.Owner is TPQA then Result := TPQA(Self.Owner).Product
    else if Self.Owner is TPQABatch then Result := TPQABatch(Self.Owner).Product
    else if Self.Owner is TPQABins then Result := TPQABins(Self.Owner).Product
    else if Assigned(PQA) then Result := PQA.Product;
end;

function TPQADetails.GetProductName: String;
begin
  Result := '';
  if Assigned(Self.Owner) then
    if Self.Owner is TPQA then Result := TPQA(Self.Owner).ProductName
    else if Self.Owner is TPQABatch then Result := TPQABatch(Self.Owner).ProductName
    else if Self.Owner is TPQABins then Result := TPQABins(Self.Owner).ProductName;
  if Result = '' then begin
    ProductIDfromform := 0;
    SendEvent(BusObjEvent_Dataset, BusObjEvent_SearchProductID, Self);
    Result := tcDataUtils.getProduct(ProductIDfromform);
  end;
end;

function TPQADetails.getDepartmentId :Integer;
begin
  Result := 0;
  if Assigned(Self.Owner) then
    if Self.Owner is TPQA then Result := TPQA(Self.Owner).DepartmentId
    else if Self.Owner is TPQABatch then Result := TPQABatch(Self.Owner).DepartmentId
    else if Self.Owner is TPQABins then Result := TPQABins(Self.Owner).DepartmentId;
  if Result = 0 then begin
    DepartmentIdfromform := 0;
    SendEvent(BusObjEvent_Dataset, BusObjEvent_SearchDepartmentId, Self);
    Result := DepartmentIdfromform;
  end;
end;
function TPQADetails.GetProductID: Integer;
begin
  Result := 0;
  if Assigned(Self.Owner) then
    if Self.Owner is TPQA then Result := TPQA(Self.Owner).ProductID
    else if Self.Owner is TPQABatch then Result := TPQABatch(Self.Owner).ProductID
    else if Self.Owner is TPQABins then Result := TPQABins(Self.Owner).ProductID;
  if Result = 0 then begin
    ProductIDfromform := 0;
    SendEvent(BusObjEvent_Dataset, BusObjEvent_SearchProductID, Self);
    Result := ProductIDfromform;
  end;
end;

function TPQADetails.GetUOMMultiplier: Double;
var
  fPQA: TPQA;
begin
  Result := 0;
  if Assigned(Self.Owner) then
    if Self.Owner is TPQA then Result := TPQA(Self.Owner).UOMMultiplier;

  { note: this is for allocation form - the form has a PQA component , but details are not owned by PQA
    PQA property reads the pqa from form, if SELF is not owned by TPQA obj }
  if Result = 0 then begin
    fPQA := PQA;
    if Assigned(fPQA) then Result := fPQA.UOMMultiplier;
  end;

  if Result = 0 then Result := 1;
end;

function TPQADetails.getAllocatype: string;
begin
  Result := '';
  if Assigned(Self.Owner) then
    if Self.Owner is TPQA then Result := TPQA(Self.Owner).allocType;
end;

function TPQADetails.getAvailableQty: Double;
var
  qry: TERPQuery;
  Function aFiltertype : TFiltertype;
  begin
         if self is TPQABatch then result :=tDetails
    else if self is TPQABins  then result := tExtraDetails
    else result := tDetailswithSno;
  end;
  Function aBatchno:String;
  begin
         if self is TPQABatch then result := TPQABatch(Self).Batchno
    else if (Assigned(Owner)) and (Owner is TPQABatch) then result := TPQABatch(Owner).Batchno
    else if (Assigned(Owner)) and (Owner is TPQABins) and (Assigned(TPQABins(Owner).owner)) and (TPQABins(Owner).owner is TPQABatch) then result := TPQABatch(TPQABins(Owner).owner).Batchno
    else result := '';
  end;
  Function aExpiryDate:TDAteTime;
  begin
         if self is TPQABatch then result := TPQABatch(Self).ExpiryDate
    else if (Assigned(Owner)) and (Owner is TPQABatch) then result := TPQABatch(Owner).ExpiryDate
    else result := 0;
  end;
  Function abinlocation:String;
  begin
         if self is TPQABins then result := TPQABins(Self).binlocation
    else if (Assigned(Owner)) and (Owner is TPQABins) then result := TPQABins(Owner).binlocation
    else result := '';
  end;
  Function aBinnumber:String;
  begin
         if self is TPQABins then result := TPQABins(Self).Binnumber
    else if (Assigned(Owner)) and (Owner is TPQABins) then result := TPQABins(Owner).Binnumber
    else result := '';
  end;
  Function aSerialnumber :String;
  begin
    if self is TPQASN then result := TPQASN(SelF).SerialNumber
    else result := '';
  end;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection.Connection);
  try
    qry.SQL.Text := SQL4ProductQty(PQA.TransDAte,
                                   PQA.UnitOfMeasure,
                                   aFiltertype,
                                   PQA.productID,
                                   PQA.DepartmentID,
                                   aBatchno,
                                   aExpiryDate,
                                   abinlocation,
                                   aBinnumber,
                                   aSerialnumber);
    qry.open;
    result := qry.fieldbyname('Qty').AsFloat;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function TPQADetails.GetISBatch: Boolean;
begin
  Result := IsOrChildof(TPQABatch);
end;

function TPQADetails.getISBins: Boolean;
begin
  Result := IsOrChildof(TPQABins)
end;

function TPQADetails.GetIsList: Boolean;
begin
  Result := True;
end;

function TPQADetails.GetISSN: Boolean;
begin
  Result := IsOrChildof(TPQASN)
end;

function TPQADetails.GetISBatchProduct: Boolean;
var
  obj: TComponent;
begin
  Result := False;
  obj := Self.Owner;
  while obj <> nil do
    if obj is TPQA then begin
      Result := TPQA(obj).Product.Batch;
      exit;
    end
    else obj := obj.Owner;
  if assigned(ffPQA) then
    Result := ffPQA.Product.Batch;

end;

function TPQADetails.getISBinsProduct: Boolean;
var
  obj: TComponent;
begin
  Result := False;
  obj := Self.Owner;
  while obj <> nil do
    if obj is TPQA then begin
      Result := TPQA(obj).Product.Multiplebins;
      exit;
    end
    else obj := obj.Owner;
  if assigned(ffPQA) then
    Result := ffPQA.Product.Multiplebins;
end;

function TPQADetails.GetISSNProduct: Boolean;
var
  obj: TComponent;
begin
  Result := False;
  obj := Self.Owner;
  while obj <> nil do
    if obj is TPQA then begin
      Result := TPQA(obj).Product.SnTracking;
      exit;
    end
    else obj := obj.Owner;
  if assigned(ffPQA) then
    Result := ffPQA.Product.SnTracking;
end;

function TPQADetails.getIsStockmovement: boolean;
begin
  Result := False;
  if Assigned(Self.Owner) then
    if Self.Owner is TPQA then Result := Sametext(TPQA(Self.Owner).Transtype ,  'TStockMovementLines')
    else if Self.Owner is TPQABatch then Result := TPQABatch(Self.Owner).IsStockmovement
    else if Self.Owner is TPQABins then Result := TPQABins(Self.Owner).IsStockmovement;
end;

constructor TPQADetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'PQADetails';
  fSQL := 'SELECT * FROM tblpqadetails';
  if PQADetailtype <> '' then
    fSQL := fSQL + ' where PQAType = ' + Quotedstr(PQADetailtype);
  ExportExcludeList.Add('isempty');
end;

class function TPQADetails.GetIDField: string;
begin
  Result := 'PQADetailID'
end;

class function TPQADetails.GetKeyStringField: string;
begin
  Result := ''
end;

function TPQADetails.getParentdataRef: String;
begin
  result := '';
  while Assigned(owner) and (owner is  TPQADetails) do
    if owner is TPQABins then result := result + TPQABins(Owner).binlocation +'-'+TPQABins(Owner).binnumber
    else if owner is TPQABatch then begin
      if result <> '' then result := result +'-';
      result := result + TPQABatch(Owner).BatchNo;
    end;
end;

function TPQADetails.GetBOQty: double;
begin
  result := GetFloatField('BOQty');
end;

function TPQADetails.GetBOUOMQty: double;
begin
  result := GetFloatField('BOUOMQty');
end;

class function TPQADetails.GetBusObjectTablename: string;
begin
  Result := 'tblpqadetails'
end;

class function TPQADetails.PQADetailtype: string;
begin
  Result := '';
end;

procedure TPQADetails.RefreshTotals;
var
  qry: TERPQuery;
begin
  qry := DbSharedObj.GetQuery(self.Connection.Connection);
  try
    qry.SQL.Add('select sum(IfNull(qty,0)) as qty,');
    qry.SQL.Add('sum(IfNull(UOMQty,0)) as UOMQty,');
    qry.SQL.Add('sum(IfNull(BOQty,0)) as BOQty,');
    qry.SQL.Add('sum(IfNull(BOUOMQty,0)) as BOUOMQty,');
    qry.SQL.Add('sum(IfNull(CUSTFLD1,0)) as CUSTFLD1Qty,');
    qry.SQL.Add('sum(IfNull(CUSTFLD4,0)) as CUSTFLD4Qty');
    qry.SQL.Add('from tblpqaDetails where Active = "T" and PQAId = ' + IntToStr(self.PQAID));
    qry.SQL.Add('and PQAType="Batch"');
    qry.Open;
    fTotalQty := qry.FieldByName('qty').AsFloat;
    fTotalUOMQty := qry.FieldByName('UOMQty').AsFloat;
    fTotalBOQty := qry.FieldByName('BOqty').AsFloat;
    fTotalBOUOMQty := qry.FieldByName('BOUOMQty').AsFloat;
    fTotalCUSTFLD1Qty := qry.FieldByName('CUSTFLD1Qty').AsFloat;
    fTotalCustFld4Qty := qry.FieldByName('CUSTFLD4Qty').AsFloat;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TPQADetails.RemoveShippedAllocationFromBO;
var
  msg: string;
begin
        //IterateRecordsReverse(RemoveShippedAllocationFromBOCallback);
  if Assigned(PQA) and (not(PQa.isbo)) then exit;

  if count =0 then exit;
  First;
  while EOf = False do begin

             if (Self is TPQABatch) and (TPQABatch(Self).PQa.Product.Multiplebins) then TPQABatch(Self).PQABins.RemoveShippedAllocationFromBO
        else if (Self is TPQABatch) and (TPQABatch(Self).PQa.Product.SnTracking)   then TPQABatch(Self).PQASN.RemoveShippedAllocationFromBO
        else if (Self is TPQABins ) and (TPQABatch(Self).PQa.Product.SnTracking)   then TPQABins(Self ).PQASN.RemoveShippedAllocationFromBO;


    if qty      <> 0 then begin qty     := 0;end;
    if uomqty   <> 0 then begin uomqty  := 0;end;


    if boqty    = 0 then begin
      //Delete;
      if not TDeletedItem.AddDeleted(self,msg) then
        raise Exception.Create('Error - Could not delete PQADetails: ' + msg);
      //Next;
    end else begin
      PostDB;
      Next;
    end;
  end;


end;

procedure TPQADetails.RemoveShippedBOFromAllocation;
var
  msg: string;
begin
        //IterateRecordsReverse(RemoveShippedBOFromAllocationCallback);
  if Assigned(PQA) and ((PQa.isbo)) then exit;

  if count =0 then exit;
  First;
  while EOf = False do begin

             if (Self is TPQABatch) and (TPQABatch(Self).PQa.Product.Multiplebins) then TPQABatch(Self).PQABins.RemoveShippedBOFromAllocation
        else if (Self is TPQABatch) and (TPQABatch(Self).PQa.Product.SnTracking)   then TPQABatch(Self).PQASN.RemoveShippedBOFromAllocation
        else if (Self is TPQABins ) and (TPQABatch(Self).PQa.Product.SnTracking)   then TPQABins(Self).PQASN.RemoveShippedBOFromAllocation;


  if boqty      <> 0 then begin boqty     := 0;end;
  if bouomqty   <> 0 then begin bouomqty  := 0;end;

  if qty    = 0 then begin
    //Delete;
    if not TDeletedItem.AddDeleted(self,msg) then
      raise Exception.Create('Error - Could not delete PQADetails: ' + msg);
  end else begin
    PostDB;
    next;
    end;
  end;

end;

procedure TPQADetails.RepopulateCustFld2;
begin
  if count =0 then exit;
  iteraterecords(RepopulateCustFld2Callback);
end;
procedure TPQADetails.RepopulateCustFld2Callback(const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is TPQADetails then begin
    TPQADetails(Sender).RepopulateCustFld2Callback;
  end;
end;
procedure TPQADetails.RepopulateCustFld2Callback;
begin
    if custfld2 <> recno then begin
      custfld2 :=recno ;
      PostDB;
    end;
end;
destructor TPQADetails.Destroy;
begin
  inherited;
end;

procedure TPQADetails.LoadFromXMLNode(const node: IXMLNode);
var
  LinesNode: IXMLNode;
  x: Integer;
begin
  inherited;
  SetPropertyFromNode(node, 'Qty');
  SetPropertyFromNode(node, 'BOQty');
  SetPropertyFromNode(node, 'CUSTFLD1');
  SetPropertyFromNode(node, 'UOMQty');
  SetPropertyFromNode(node, 'BOUOMQty');
  SetPropertyFromNode(node, 'PQAType');
  SetPropertyFromNode(node, 'ParentRef');
  SetPropertyFromNode(node, 'CUSTFLD6');
  SetPropertyFromNode(node, 'CUSTFLD7');
  SetBooleanPropertyFromNode(node, 'Active');
  PostDb;
  if Self is TPQABatch then begin
    LinesNode := node.ChildNodes.FindNode(TPQABins.XMLBranchName);
    if Assigned(LinesNode) then begin
      for x := 0 to LinesNode.ChildNodes.count - 1 do begin
        PQABins.New;
        PQABins.LoadFromXMLNode(LinesNode.ChildNodes[x]);
        PQABins.PostDb;
      end;
    end;
  end;
  if (Self is TPQABins) or (Self is TPQABatch) then begin
    LinesNode := node.ChildNodes.FindNode(TPQASN.XMLBranchName);
    if Assigned(LinesNode) then begin
      for x := 0 to LinesNode.ChildNodes.count - 1 do begin
        PQASN.New;
        PQASN.LoadFromXMLNode(LinesNode.ChildNodes[x]);
        PQASN.PostDb;
      end;
    end;
  end;
end;

procedure TPQADetails.LogAllAllocation;
begin
        IterateRecords(LogAllAllocationAllback);
end;
procedure TPQADetails.LogAllAllocationAllback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TPQADetails) then exit;
       if (Sender is TPQABatch) and (TPQABatch(Sender).PQa.Product.Multiplebins) then TPQABatch(Sender).PQABins.LogAllAllocation
  else if (Sender is TPQABatch) and (TPQABatch(Sender).PQa.Product.SnTracking)   then TPQABatch(Sender).PQASN.LogAllAllocation
  else if (Sender is TPQABins ) and (TPQABatch(Sender).PQa.Product.SnTracking)   then TPQABins(Sender ).PQASN.LogAllAllocation;
end;
Function TPQADetails.MoveAllocation(fdQuantity: Double; ToObj: TPQADetails; Batch, bins, sn:Boolean; AllocateonlyifAvailable :Boolean = False):Double;
var
  fdQty1, fdQty2 , fdQty3 :Double;
  Function QtytoUse:double;
  begin
    if AllocateonlyifAvailable = false then result := Qty
    else result := AvailableQty;
  end;
begin
  fdQty1 := fdQuantity;
  try
    if fdQty1 =0 then exit;
    if count=0 then exit;
    first;
    While (EOF=False) and (fdQty1 >0) do begin
      if ((*Qty*)QtytoUse >0) then begin
        if (toobj is Tpqabatch) then begin
          {differnt locate for the combination as locate fails with null value}
               if ((toobj.locate('Value'                     ,             Tpqabatch(Self).Batchno                                                           , [])) and (Tpqabatch(ToObj).ExpiryDate   = Tpqabatch(Self).ExpiryDate)   and (Tpqabatch(ToObj).TruckLoadNo  = Tpqabatch(Self).TruckLoadNo)) then
          else if ((toobj.locate('Value;ExpiryDate'          , vararrayof([Tpqabatch(Self).Batchno, Tpqabatch(Self).ExpiryDate])                             , [])) and (Tpqabatch(ToObj).TruckLoadNo  = Tpqabatch(Self).TruckLoadNo)) then
          else if ((toobj.locate('Value;TruckLoadNo'         , vararrayof([Tpqabatch(Self).Batchno, Tpqabatch(Self).TruckLoadNo])                            , [])) and (Tpqabatch(ToObj).ExpiryDate   = Tpqabatch(Self).ExpiryDate )) then
          else if toobj.locate('Value;ExpiryDate;TruckLoadNo', vararrayof([Tpqabatch(Self).Batchno, Tpqabatch(Self).ExpiryDate,Tpqabatch(Self).TruckLoadNo]) , [])=false then begin
            Tpqabatch(ToObj).new;
            Tpqabatch(ToObj).Batchno      := Tpqabatch(Self).BatchNo;
            Tpqabatch(ToObj).ExpiryDate   := Tpqabatch(Self).ExpiryDate;
            Tpqabatch(ToObj).TruckLoadNo  := Tpqabatch(Self).TruckLoadNo;
          end;
        end else if toObj is TPQAbins then begin
          if toobj.locate('Value;binid', Vararrayof([TPQABins(Self).Value,TPQABins(Self).binID]), []) = False then begin
            TPQABins(TOObj).New;
            TPQABins(TOObj).Value := TPQABins(Self).Value;
            TPQABins(TOObj).binid := TPQABins(Self).binid;
          end;
        end else if toObj is TPQASN then begin
            if ToObj.locate('Value' , TPQASN(Self).Serialnumber , []) = false then begin // should never be true
              TPQASN(ToObj).New;
              TPQASN(ToObj).serialnumber :=TPQASN(Self).Serialnumber;
              //TPQASN(Self).Next;
            end;
        end;
        if Self is TPQASN then begin
            fdQty2:= 1;
            ToObj.Qty := 1;
            ToObj.PostDB;
            fdQty1 := fdQty1  - fdQty2;
        end else begin
          if (*Qty*)QtytoUse > fdQty1 then begin
            fdQty2 :=fdQty1;
            Qty       := qty       - fdQty2; PostDB;
            PostDB;
            ToObj.Qty := ToObj.qty + fdQty2; ToObj.PostDB;
            fdQty1 := 0;
          end else begin
            fdQty2 :=(*Qty*)QtytoUse;
            fdQty1 := fdQty1  - fdQty2;
            Qty       := qty       - fdQty2; PostDB;
            PostDB;
            ToObj.Qty := ToObj.qty + fdQty2; ToObj.PostDB;
          end;
        end;
        fdQty3:= 0;
             if (toobj is Tpqabatch) and (Bins) then fdQty3:= pqabins.MoveAllocation(fdQty2,Tpqabatch(ToObj).pqabins, Batch, bins, sn)
        else if (toobj is Tpqabatch) and (SN)   then fdQty3:= PQASN.MoveAllocation  (fdQty2,Tpqabatch(ToObj).PQASN, Batch, bins, sn)
        else if (toobj is TPQABins)  and (SN)   then fdQty3:= PQASN.MoveAllocation  (fdQty2,TPQABins(ToObj).PQASN, Batch, bins, sn)
        else fdQty3:= -1;

        {if qty not available to allocate}
        if fdQty3>0 then begin
          //if ToObj.Qty <> fdQty3 then begin
            Qty       := qty       + fdQty3; PostDB;
            PostDB;
            ToObj.Qty := ToObj.qty - fdQty3; ToObj.PostDB;
            ToObj.PostDB;
          //end;
        end;

      end;
      Next;
    end;
  finally
    Result :=  fdQty1;
  end;
end;

function TPQADetails.ChildObj: TPQADetails;
begin
  Result := nil;
  if (Self is TPQABatch) then begin
    if (TPQABatch(Self).IsBinsProduct) then Result := TPQABatch(Self).PQABins
    else if (TPQABatch(Self).IsSNProduct) then Result := TPQABatch(Self).PQASN;
  end
  else if (Self is TPQABins) then begin
    if (TPQABins(Self).IsSNProduct) then Result := TPQABins(Self).PQASN;
  end;
end;

procedure TPQADetails.CloseAll;
begin
             if (Self is TPQABatch) and (TPQABatch(Self).PQa.Product.Multiplebins) then TPQABatch(Self).PQABins.CloseAll
        else if (Self is TPQABatch) and (TPQABatch(Self).PQa.Product.SnTracking)   then TPQABatch(Self).PQASN.CloseAll
        else if (Self is TPQABins ) and (TPQABatch(Self).PQa.Product.SnTracking)   then TPQABins(Self ).PQASN.CloseAll;
        Closedb;
end;

function TPQADetails.NextCustfld2: Integer;
var
  Qry:TERPQuery;
  aSQL: string;
begin
  result := 0;
  aSQL := self.SQL;
  aSQL := StringReplace(aSQL,'*','Max(CustFld2) as CustFld2',[]) + ' and ParentRef = ' + Quotedstr(ParentRef);
  Qry := GetSharedDataSet(aSQL, true);
  try
    if Qry.recordcount =1 then result := Qry.FieldByName('CustFld2').AsInteger ;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
  REsult := Result +1;
end;

function TPQADetails.NodeIDs: string;
begin
  fsNodeIDs := inttostr(ID);
  if ChildObj <> nil then begin
    ChildObj.fsNodeIDs := '';
    ChildObj.IterateRecords(NodeIDsCallback);
    if fsNodeIDs <> '' then fsNodeIDs := fsNodeIDs + ',';
    fsNodeIDs := fsNodeIDs + TPQADetails(ChildObj).fsNodeIDs;
  end;
end;

procedure TPQADetails.NodeIDsCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  TPQADetails(Sender).NodeIDs;
end;

procedure TPQADetails.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Qty', Qty);
  AddXMLNode(node, 'BOQty', BOQty);
  AddXMLNode(node, 'CUSTFLD1', CUSTFLD1);
  AddXMLNode(node, 'UOMQty', UOMQty);
  AddXMLNode(node, 'BOUOMQty', BOUOMQty);
  AddXMLNode(node, 'PQAType', PQAType);
  AddXMLNode(node, 'ParentRef', ParentRef);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'CUSTFLD6', CUSTFLD6);
  AddXMLNode(node, 'CUSTFLD7', CUSTFLD7);
  ExportsubClasses(node);
end;

function TPQADetails.ExportsubClasses(const node: IXMLNode): Boolean;
begin
  Result := True;
  if Self is TPQABatch then
    if PQABins.count > 0 then begin
      PQABins.XMLPropertyNode := node.AddChild(TPQABins.XMLBranchName);
      PQABins.XMLPropertyName := TPQABins.PQADetailtype;
      PQABins.IterateRecords(GetPropertyXMLCallback);
      Exit;
    end;
  if (Self is TPQABins) or (Self is TPQABatch) then
    if PQASN.count > 0 then begin
      PQASN.XMLPropertyNode := node.AddChild(TPQASN.XMLBranchName);
      PQASN.XMLPropertyName := TPQASN.PQADetailtype;
      PQASN.IterateRecords(GetPropertyXMLCallback);
    end;
end;

function TPQADetails.ValidateData: Boolean;
begin
  Result := True;
end;

procedure TPQADetails.TotalAllocatedCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TPQADetails) then Exit;
  fdTotalAllocated := fdTotalAllocated + TPQADetails(Sender).Qty;
end;
procedure TPQADetails.TotalUOMAllocatedCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TPQADetails) then Exit;
  fdTotalUOMAllocated := fdTotalUOMAllocated + TPQADetails(Sender).UOMQty;
end;

function TPQADetails.getTotalAllocated: Double;
begin
  fdTotalAllocated := 0;
  IterateRecords(TotalAllocatedCallback);
  Result := fdTotalAllocated;
end;
function TPQADetails.getTotalUOMAllocated: Double;
begin
  fdTotalUOMAllocated := 0;
  IterateRecords(TotalUOMAllocatedCallback);
  Result := fdTotalUOMAllocated;
end;

procedure TPQADetails.ValidateDataCallback(const Sender: TBusObj; var Abort: Boolean);

  procedure Validmsg(const alloatedqty: Double; const fPQADetailType: string);
  begin
    if not(AllValid) then AddErrMsg(ProductName + ' : The Quantity of ' + fPQADetailType + ' Allocated [' + FloattoStr(alloatedqty) + '] does not match the Quantity to be Allocated[' + FloattoStr(Self.UOMQty) + ']')
    else AddWarnMsg(ProductName + ' : The Quantity of ' + fPQADetailType + ' Allocated [' + FloattoStr(alloatedqty) + '] does not match the Quantity to be Allocated[' + FloattoStr(Self.UOMQty) + ']');
  end;
  procedure AssignInvalid(InvalidObj: TBusObj);
  begin
    if TPQADetails(InvalidObj).count > 0 then begin
      PQA.InvalidDetailID := TPQADetails(InvalidObj).ID;
      PQA.InValidDetailtype := TPQADetails(InvalidObj).PQADetailtype;
      PQA.ISParentInvalid := False;
    end else begin
      PQA.InvalidDetailID := TPQADetails(Sender).ID;
      PQA.InValidDetailtype := TPQADetails(Sender).PQADetailtype;
      PQA.ISParentInvalid := True;
    end;
  end;

begin
  try
    if TPQADetails(Sender).ValidateData = False then begin
      AllValid := False;
      Abort := True;
      Exit;
    end;
    if (Sender is TPQABatch) and (TPQADetails(Sender).IsBinsProduct) then begin
      if (PQABins.TotalUOMAllocated > UOMQty) and (round(PQABins.TotalUOMAllocated - UOMQty ,RoundPlacesGeneral )<> 0) then begin
        AllValid := False;
        AssignInvalid(PQABins);
        Validmsg(PQABins.fdTotalUOMAllocated, PQABins.PQADetailDesctype);
        Abort := True;
        Exit;
      end
      else if (PQABins.fdTotalUOMAllocated < UOMQty) then begin
        AssignInvalid(PQABins);
        Validmsg(PQABins.fdTotalUOMAllocated, PQABins.PQADetailDesctype);
      end;
      AllValid := PQABins.ValidateAllRecs;
    end
    else if ((Sender is TPQABins) or (Sender is TPQABatch)) and (TPQADetails(Sender).IsSNProduct) then begin
      if (PQASN.TotalUOMAllocated < UOMQty) and (round(PQASN.TotalUOMAllocated -UOMQty , RoundPlacesGeneral)<>0) then begin
        AllValid := False;
        AssignInvalid(PQASN);
        Validmsg(PQASN.fdTotalUOMAllocated, PQASN.PQADetailDesctype);
        Abort := True;
        Exit;
      end
      else if (PQASN.fdTotalUOMAllocated > UOMQty) then begin
        AssignInvalid(PQASN);
        Validmsg(PQASN.fdTotalUOMAllocated, PQASN.PQADetailDesctype);
      end;
      AllValid := PQASN.ValidateAllRecs;
    end;
  finally
    if not AllValid then Abort := True;
  end;
end;

class function TPQADetails._Schema: string;
begin
  Result := inherited;
  TBOSchema.AddRefType(Result, 'TProductBin', 'ProductBinObj', 'BinID', 'ID');
end;
Function TPQADetails.ValidateAllocation(HasTree:Boolean)   :Boolean;
begin
  Result := True;
  //if CrossStockAdjustTransForinvoice then exit;
  if (PQA.ISStockMovement) then Exit;
  if not Appenv.CompanyPrefs.ValidateAllocation then Exit;

          if (abs(TotalUOMAllocated) > abs(PQA.UOMQty))  and (round(abs(TotalUOMAllocated) - abs(PQA.UOMQty) ,RoundPlacesGeneral)<> 0 ) then begin
            if not(PQA.ISStockMovement) then begin
              PQA.InvalidDetailID := ID;
              PQA.InValidDetailtype := PQADetailtype;
              REsult := PQA.isEnforceAllocationValidation ;
            end;
          end  else if ((not(PQA.IsSalesOrderPQA)) or (AppEnv.CompanyPrefs.BarcodePickingInSOMode)) and not(HasTree) then begin
            if (round(abs(TotalUOMAllocated) - abs(PQA.UOMQty) ,RoundPlacesGeneral)<> 0 ) and (abs(fdTotalUOMAllocated) <> abs(PQA.UOMQty)) then begin
              if PQA.isEnforceAllocationValidation then REsult := False;
              PQA.InvalidDetailID := ID;
              PQA.InValidDetailtype := PQADetailtype;
            end;
          end;

          if result then
            if not(ValidateAllRecs) then begin
              Result := False;
              Exit;
            end;
end;
function TPQADetails.ValidateAllRecs: Boolean;
begin
  AllValid := True;
  IterateRecords(ValidateDataCallback);
  Result := AllValid
end;

function TPQADetails.Save: Boolean;
begin
  Result := True;
  if Self is TPQABatch then begin
    if Product.Multiplebins then Result := PQABins.Save
    else if Product.SnTracking then Result := PQASN.Save;
  end
  else if Self is TPQABins then
    if Product.SnTracking then begin
      Result := PQASN.Save;
    end;
  if result and (PQADetailsClass.Count > 0) then
    result:= PQADetailsClass.Save;
end;

procedure TPQADetails.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if (ChangeType = dcLoad) and (count = 0) then Exit;
end;

procedure TPQADetails.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SameText(Sender.fieldname, 'Qty') then begin
    if not RawMode then begin
      UOMQty := Qty / UOMMultiplier;
    end;
  end
  else if SameText(Sender.fieldname, 'UOMQty') then begin
    if not RawMode then begin
      Qty := UOMQty * UOMMultiplier;
    end;
  end
  else if SameText(Sender.fieldname, 'BOQty') then begin
    if not RawMode then begin
      BOUOMQty := BOQty / UOMMultiplier;
    end;
  end
  else if SameText(Sender.fieldname, 'BOUOMQty') then begin
    if not RawMode then begin
      BOQty := BOUOMQty * UOMMultiplier;
    end;
  end
end;

function TPQADetails.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

function TPQADetails.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
end;

function TPQADetails.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterOpen(Sender);
  if not result then exit;
end;

function TPQADetails.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not Result then Exit;
end;

function TPQADetails.DoAfterDelete(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterDelete(Sender);
  if not result then exit;
  RepopulateCustFld2;
end;

function TPQADetails.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;

  if Assigned(Self.Owner) then begin
    if Self.Owner is TPQADetails then begin
      Self.PQAID := TPQADetails(Self.Owner).PQAID;
      Self.ParentRef := TPQADetails(Self.Owner).Globalref;
    end
    else if Self.Owner is TPQA then begin
      Self.PQAID := TPQA(Self.Owner).ID;
      Self.ParentRef := '';
    end else if assigned(PQA) then begin
      Self.PQAID := PQA.ID;
      Self.ParentRef := '';
    end;
  end;
  PQAType := PQADetailtype;
  Custfld2 := NextCustfld2;
end;

{ Property functions }
function TPQADetails.GetPQAID     : Integer   ;begin  Result := GetIntegerField('PQAID')      ;end;
function TPQADetails.getQty       : Double    ;begin  Result := GetFloatField('Qty')          ;end;
function TPQADetails.getUOMQty    : Double    ;begin  Result := GetFloatField('UOMQty')       ;end;
function TPQADetails.GetPQAType   : string    ;begin  Result := GetStringField('PQAType')     ;end;
function TPQADetails.GetParentRef : string    ;begin  Result := GetStringField('ParentRef')   ;end;
function TPQADetails.GetPQAValue  : string    ;begin  Result := GetStringField('Value')       ;end;
function TPQADetails.getExpiryDate: TdateTime ;begin  Result := GetDatetimeField('ExpiryDate');end;
function TPQADetails.getActive    : Boolean   ;begin  Result := GetBooleanField('Active')     ;end;
function TPQADetails.getCUSTFLD1  : Double    ;begin  REsult := GetFloatField('CUSTFLD1' )    ;end;
function TPQADetails.getCUSTFLD2  : Integer   ;begin  REsult := GetIntegerfield('CUSTFLD2')   ;end;
function TPQADetails.getCUSTFLD3  : Integer   ;begin  REsult := GetIntegerfield('CUSTFLD3')   ;end;
function TPQADetails.getCustFld4  : integer   ;begin  Result := GetIntegerField('CUSTFLD4')   ;end;
function TPQADetails.getCUSTFLD5  : String    ;begin  Result := GetStringField('CUSTFLD5')    ;end;
function TPQADetails.getCUSTFLD6  : Double    ;begin  REsult := GetFloatField('CUSTFLD6' )    ;end;
function TPQADetails.getCUSTFLD7  : Double    ;begin  REsult := GetFloatField('CUSTFLD7' )    ;end;
function TPQADetails.getcleanQty  : Double    ;begin  Result := GetXMLNodeFloatValue(CleanXMLNode, 'Qty');end;

procedure TPQADetails.SetPQAID      (const Value: Integer)    ;begin  SetIntegerField('PQAID'       , Value);end;
procedure TPQADetails.setQty        (const Value: Double)     ;begin  SetFloatField('Qty'           , Value);end;
procedure TPQADetails.setUOMQty     (const Value: Double)     ;begin  SetFloatField('UOMQty'        , Value);end;
procedure TPQADetails.SetPQAType    (const Value: string)     ;begin  SetStringField('PQAType'      , Value);end;
procedure TPQADetails.SetParentRef  (const Value: string)     ;begin  SetStringField('ParentRef'    , Value);end;
procedure TPQADetails.SetPQAValue   (const Value: string)     ;begin  SetStringField('Value'        , Value);end;
procedure TPQADetails.setCUSTFLD1   (const Value: Double)     ;begin  Setfloatfield('CUSTFLD1'      , Value);end;
procedure TPQADetails.setCUSTFLD2   (const Value: Integer)    ;begin  SetIntegerField('CUSTFLD2'    , Value);end;
procedure TPQADetails.setCUSTFLD3   (const Value: Integer)    ;begin  SetIntegerField('CUSTFLD3'    , Value);end;
procedure TPQADetails.SetCustFld4   (const Value: integer)    ;begin  SetIntegerField('CUSTFLD4'    , Value);end;
procedure TPQADetails.setCUSTFLD5   (const Value: String)     ;begin  SetStringField('CUSTFLD5'     , Value);end;
procedure TPQADetails.setCUSTFLD6   (const Value: Double)     ;begin  Setfloatfield('CUSTFLD6'      , Value);end;
procedure TPQADetails.setCUSTFLD7   (const Value: Double)     ;begin  Setfloatfield('CUSTFLD7'      , Value);end;
procedure TPQADetails.setExpiryDate (const Value: TdateTime)  ;begin  SetDatetimeField('ExpiryDate' , Value);end;
procedure TPQADetails.SetActive     (const Value: Boolean)    ;begin  SetBooleanField('Active'      , Value);end;

procedure TPQADetails.CreateInstance;
begin
  if Owner is TPQA then begin
    if Assigned(TPQA(Owner).ObjInstanceToClone) then
      if Product.Batch then ObjInstanceToClone := TPQA(TPQA(Owner).ObjInstanceToClone).PQABatch
      else if Product.Multiplebins then ObjInstanceToClone := TPQA(TPQA(Owner).ObjInstanceToClone).PQABins
      else if Product.SnTracking then ObjInstanceToClone := TPQA(TPQA(Owner).ObjInstanceToClone).PQASN;
  end
  else if Owner is TPQABatch then begin
    if Self is TPQABins then begin
      if Assigned(TPQABatch(Owner).ObjInstanceToClone) then TPQABatch(TPQABatch(Owner).ObjInstanceToClone).PQABins;
    end
    else if Self is TPQASN then
      if Assigned(TPQABatch(Owner).ObjInstanceToClone) then TPQABatch(TPQABatch(Owner).ObjInstanceToClone).PQASN;
  end
  else if Owner is TPQABins then
    if Assigned(TPQABins(Owner).ObjInstanceToClone) then TPQABins(TPQABins(Owner).ObjInstanceToClone).PQASN;
end;

function TPQADetails.getDescription: string;
begin
  Result := PQAValue;
end;

procedure TPQADetails.AddErrMsg(const Value: string);
var
  obj: TComponent;
begin
  obj := Self.Owner;
  while (obj <> nil) and not(obj is TPQA) do obj := obj.Owner;
  if obj is TPQA then begin
    TPQA(obj).AddErrMsg(Value);
  end;

end;

procedure TPQADetails.AddWarnMsg(const Value: string);
var
  obj: TComponent;
begin
  obj := Self.Owner;
  while (obj <> nil) and not(obj is TPQA) do obj := obj.Owner;
  if obj is TPQA then begin
    TPQA(obj).AddWarnMsg(Value);
  end;
end;
procedure TPQADetails.checkAllocateQtyCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TPQADetails) then exit;
  fTotalUOMQty := fTotalUOMQty +TPQADetails(Sender).UOMQty;
  fTotalBOUOMQty := fTotalBOUOMQty+TPQADetails(Sender).BOUOMQty;
end;
procedure TPQADetails.AllocateQtyfromBOQtyCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TPQADetails) then exit;
  if (fParentUOMQty = fTotalUOMQty) then begin
    //Abort :=  True;  // Binny: do not abort it as it changes the record pointer of the dataset
    Exit;
  end;
  if TPQADetails(Sender).BOUOMQty>0 then begin
    if TPQADetails(Sender).BOUOMQty >=  (fParentUOMQty -fTotalUOMQty) then begin
      TPQADetails(Sender).UOMQty := TPQADetails(Sender).UOMQty +(fParentUOMQty -fTotalUOMQty);
      TPQADetails(Sender).BOUOMQty := TPQADetails(Sender).BOUOMQty -(fParentUOMQty -fTotalUOMQty);
      fTotalUOMQty :=fTotalUOMQty+(fParentUOMQty -fTotalUOMQty);
      fTotalBOUOMQty :=fTotalBOUOMQty-(fParentUOMQty -fTotalUOMQty);
    end else begin
      TPQADetails(Sender).UOMQty := TPQADetails(Sender).UOMQty +TPQADetails(Sender).BOUOMQty;
      fTotalUOMQty := fTotalUOMQty +TPQADetails(Sender).BOUOMQty;
      fTotalBOUOMQty := fTotalBOUOMQty -TPQADetails(Sender).BOUOMQty;
      TPQADetails(Sender).BOUOMQty := 0;
    end;
    TPQADetails(Sender).Qty := TPQADetails(Sender).UOMQty*TPQADetails(Sender).PQA.UOMMultiplier;
    TPQADetails(Sender).BOQty := TPQADetails(Sender).BOUOMQty*TPQADetails(Sender).PQA.UOMMultiplier;
    TPQADetails(Sender).PostDB;
             if (Sender is TPQABatch) and (PQa.Product.Multiplebins) then TPQABatch(Sender).PQABins.checkAllocateQty(UOMQty , BOUOMQty)
        else if (Sender is TPQABatch) and (PQa.Product.SnTracking)   then TPQABatch(Sender).PQASN.checkAllocateQty(UOMQty , BOUOMQty)
        else if (Sender is TPQABins ) and (PQa.Product.SnTracking)   then TPQABins(Sender ).PQASN.checkAllocateQty(UOMQty , BOUOMQty);
  end;
end;
procedure TPQADetails.AllocateQtyToBOQtyCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TPQADetails) then exit;
  if (fParentUOMQty = fTotalUOMQty) then begin
    Abort :=  True;
    Exit;
  end;
  if TPQADetails(Sender).UOMQty >0 then begin

    if TPQADetails(Sender).UOMQty >=  (fTotalUOMQty-fparentUOMqty) then begin
      TPQADetails(Sender).BOUOMQTY        := TPQADetails(Sender).BOUOMQty +(fTotalUOMQty-fparentUOMqty);
      fTotalUOMQty    := fTotalUOMQty -(fTotalUOMQty-fparentUOMqty);
      fTotalBOUOMQty  := fTotalBOUOMQty  + (fTotalUOMQty-fparentUOMqty);
      TPQADetails(Sender).UOMQty          := TPQADetails(Sender).UOMQty -(fTotalUOMQty-fparentUOMqty);
    end else begin
      TPQADetails(Sender).BOUOMQTY        := TPQADetails(Sender).BOUOMQty +TPQADetails(Sender).UOMQty;
      fTotalUOMQty    := fTotalUOMQty -TPQADetails(Sender).UOMQty;
      fTotalBOUOMQty  := fTotalBOUOMQty  + TPQADetails(Sender).UOMQty;
      TPQADetails(Sender).UOMQty          := 0;
    end;
    if TPQADetails(Sender).BOUOMQTY > fparentBOUOMqty then      TPQADetails(Sender).BOUOMQTY :=  fparentBOUOMqty;
    TPQADetails(Sender).Qty := TPQADetails(Sender).UOMQty*TPQADetails(Sender).PQA.UOMMultiplier;
    TPQADetails(Sender).BOQty := TPQADetails(Sender).BOUOMQty*TPQADetails(Sender).PQA.UOMMultiplier;
    TPQADetails(Sender).PostDB;
             if (Sender is TPQABatch) and (PQa.Product.Multiplebins) then TPQABatch(Sender).PQABins.checkAllocateQty(UOMQty , BOUOMQty)
        else if (Sender is TPQABatch) and (PQa.Product.SnTracking)   then TPQABatch(Sender).PQASN.checkAllocateQty(UOMQty , BOUOMQty)
        else if (Sender is TPQABins ) and (PQa.Product.SnTracking)   then TPQABins(Sender ).PQASN.checkAllocateQty(UOMQty , BOUOMQty);
  end;
end;

{Binny - Shipping a BOI will transfer the Allocation from BO to the Shipped trans.
CHANGING QTY ON A SHIPPED TRANSACTION DOESN'T TRANSFER THE QTY FROM BO TO THE TRANSACTION}
procedure TPQADetails.checkAllocateQty(aUOMQty,aBOUOMQty: Double);
begin
    fTotalUOMQty := 0;
    fTotalBOUOMQty := 0;
    IterateRecords(checkAllocateQtyCallback);

    fParentUOMQty:= aUOMQty;
    fParentBOUOMQty := aBOUOMQty;
    {Bo -> ship}if (fParentUOMQty > fTotalUOMQty) and (fTotalBOUOMQty >0) then IterateRecords(AllocateQtyfromBOQtyCallback);
    {Bo -> ship}if (fParentBOUOMQty > fTotalBOUOMQty) and (fTotalUOMQty >0) then IterateRecords(AllocateQtyToBOQtyCallback);
    {Ship -> BO}if (fParentUOMQty < fTotalUOMQty) then IterateRecordsReverse(AllocateQtyToBOQtyCallback);

end;

function TPQADetails.getids: string;
var
  obj: TComponent;
begin
  obj := Self;
  while (obj <> nil) and (obj is TBusObj) do begin
    Result := obj.Classname + '#' + inttostr(TBusObj(obj).ID) + '~' + Result;
    obj := obj.Owner;
  end

end;

function TPQADetails.GetPQA: TPQA;
var
  obj: TComponent;
begin
  Result := nil;
  if Assigned(ffPQA) then begin
    Result := ffPQA;
    Exit;
  end;
  obj := Self;
  while obj is TBusObj do
    if obj is TPQA then begin
      ffPQA := TPQA(obj);
      Result := TPQA(obj);
      Exit;
    end
    else obj := obj.Owner;

  if Assigned(Self.Owner) then
    if Self.Owner is TPQA then begin
      Result := TPQA(Self.Owner);
    end
    else if Self.Owner is TPQABatch then begin
      Result := TPQABatch(Self.Owner).PQA;
    end
    else if Self.Owner is TPQABins then begin
      Result := TPQABins(Self.Owner).PQA;
    end;

end;

class function TPQADetails.PQADetailDesctype: string;
begin
  Result := '';
end;

function TPQADetails.InTrans: Boolean;
var
  fPQa :TPQA;
begin
  (*if (Assigned(Self.Owner)) and (Self.Owner is TPQA) then Result := TPQA(Self.Owner).InTrans
  else if (Assigned(Self.Owner)) and (Self.Owner is TPQADetails) then Result := TPQADetails(Self.Owner).InTrans
  else Result := PQA.InTrans;*)

  if (Assigned(Self.Owner)) and (Self.Owner is TPQADetails) then begin
    Result := TPQADetails(Self.Owner).InTrans;
    exit;
  end;

  if (Assigned(Self.Owner)) and (Self.Owner is TPQA) then fPQA := TPQA(Self.Owner)
  else fPQA := PQA;
  result := fPQA.Intrans;
  (*REsult := SysUtils.SameText(fPQA.allocType, 'IN') ;
  if not(Result)  then begin
    if Qty < 0 then Result := True;
  end else if Qty<0 then
    Result := False;*)

end;

function TPQADetails.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
var
  msg: string;
begin
  Result := inherited DoBeforeDelete(Sender);
  if not Result then Exit;

  if (ChildObj <> nil) and (ChildObj.count > 0) then begin
    ChildObj.first;
    while ChildObj.Dataset.Eof = False do begin
      //ChildObj.Delete;
      if not TDeletedItem.AddDeleted(ChildObj,msg) then
        raise Exception.Create('Error - Could not delete PQADetails: ' + msg);
      //ChildObj.Next;
    end;
  end;

  if PQADetailsClass.count > 0 then begin
    PQADetailsClass.first;
    while PQADetailsClass.Dataset.Eof = False do begin
      //PQADetailsClass.Delete;
      if not TDeletedItem.AddDeleted(PQADetailsClass,msg) then
        raise Exception.Create('Error - Could not delete PQADetails: ' + msg);
      //PQADetailsClass.Next;
    end;
  end;
end;

{ TProdQty }
procedure TProdQty.LoadFromXMLNode(const node: IXMLNode);
var
  LinesNode: IXMLNode;
  x: Integer;
begin
  inherited;
  if not IsPQAItem then Exit;
  if UpdatingBO then exit;
  LinesNode := node.ChildNodes.FindNode(TPQA.XMLBranchName);
  if Assigned(LinesNode) then begin
    PostDb;
    for x := 0 to LinesNode.ChildNodes.count - 1 do begin
      PQA.LoadFromXMLNode(LinesNode.ChildNodes[x]);
      PQA.TransLineId := Self.ID;
      PQA.TransID := Self.HeaderID;
      PQA.PostDb;
    end;
  end;

end;

procedure TProdQty.SaveToXMLNode(const node: IXMLNode);
begin
  inherited SaveToXMLNode(node);
  ExportsubClasses(node);
end;

function TProdQty.ExportsubClasses(const node: IXMLNode): Boolean;
begin
  Result := True;
  if not IsPQAItem then Exit;
  if PQA.count > 0 then begin
    PQA.XMLPropertyNode := node.AddChild(TPQA.XMLBranchName);
    PQA.XMLPropertyName := TPQA.XMLNodeName;
    PQA.IterateRecords(GetPropertyXMLCallback);
  end;
end;

Function TProdQty.QtyValid:Boolean;
begin
  REsult := not((Self.UOMQty = 0) and (UOMOrderQty = 0)  );
end;

function TProdQty.ValidateData: Boolean;
begin
  Result := True;
  if not CreateProductClass then begin
    result := false;
    exit;
  end;
  if (not IsPQAItem) then Exit;
    if self.UnitOfMeasureID < 1 then begin
      if self.UnitOfMeasure = '' then begin
        if self.UnitOfMeasureID = -1 then
          AddResult(false, rssWarning, 0, 'Unit of Measure not found for product ('+self.ProductName+').')
        else
          AddResult(false, rssWarning, 0, 'Unit of Measure can not be blank.');
      end
      else
        AddResult(false, rssWarning, 0, 'Unit of Measure ('+self.UnitOfMeasure+') not found for product ('+self.ProductName+').');
      result := false;
      exit;
    end;

  if not QtyValid then begin
      if ((self is TSalesLineBase) and (not AppEnv.CompanyPrefs.DisableSaleLineZeroQuantityWarning)) or
         ((self is TOrderLineBase) and (not AppEnv.CompanyPrefs.DisablePurchaseLineZeroQuantityWarning))then begin
        AddEvent(BusObjEvent_Warning, BusObjEventVal_Warn_ZeroLineQty, Self.ID, self);
      end;
      inCompleteAllocationLine := ID;
      Result := true;
      Exit;
  end;
  if (Self.UOMQty = 0)  then Exit;

  PQA.ValidateAllocation;
  if PQA.Errmsg <> '' then begin
    PQA.ResultStatus.AddItem(False, rssError, BOR_ProdQty_BatchBinAllocFailed, PQA.Errmsg, True);
    InvalidAllocationLine := ID;
    Result := False
  end
  else if PQA.Warnmsg <> '' then begin
    PQA.ResultStatus.AddItem(False, rssWarning, BOR_ProdQty_Warn, PQA.Warnmsg, True);
    inCompleteAllocationLine := ID;
  end;
end;

class function TProdQty._Schema: string;
begin
  Result := inherited;
  TBOSchema.AddRefType(Result, 'TProductWeb', 'Product', 'ProductName', 'ProductName');
  TBOSchema.AddRefType(Result, 'TUnitOfMeasure', 'UOMObj', 'UOMNameProductKey', 'UnitProductKeyName');

end;

function TProdQty.Save: Boolean;
var
  s: string;
begin
  PostDb;
  Result := inherited Save;
  if not result then
    exit;
  if not IsPQAItem then Exit;
  if not PQA.Save then begin
    if PQA.Errmsg <> '' then
      PQA.ResultStatus.AddItem(False, rssError, BOR_ProdQty_BatchBinAllocFailed, PQA.Errmsg, True)
    else if PQA.Warnmsg <> '' then
      PQA.ResultStatus.AddItem(False, rssWarning, BOR_ProdQty_Warn, PQA.Warnmsg, True);
    result := false;
    Exit;
  end;

  s := 'select Value from tblPQADetails ' + ' where PQAId = ' + inttostr(PQA.ID) + ' and PQAtype = ' + Quotedstr(TPQASN.PQADetailtype);
  with TERPQuery(getnewDataset(s, True)) do
    try
      s := GroupConcat('value');
	  if s ='' then exit;	
    finally
      if Active then close;
      Free;
    end;
  EnablePropertySetWhenReadonly := true;
  try
    SerialNumbers := s;
    PostDb;
  finally
    EnablePropertySetWhenReadonly := False;
  end;
  PQA.PostDb;
end;

function TProdQty.DoAfterPost(Sender: TDatasetBusObj): Boolean;
var
  fPQA: TPQA;
  cleanISBo: Boolean;
  CleanQty :Double;
  function Quantity: Double;
  begin
    if Qty <> 0 then Result := Qty
    else if BOQty <> 0 then Result := BOQty
    else Result := 0;
  end;

begin
  Result := inherited DoAfterPost(Sender);
  if (not(Result)) or (not(Active)) or (ID = 0) then Exit; { id is 0 if the record is filtered out }
  if not(IsPQAItem) then begin
    fPQA := PQA;
    if fPQA.count >0 then fPQA.DeleteAll(true);
    Exit;
  end;
  fPQA := PQA;
  if fPQA.count = 0 then Exit; // for a deleted record
  fPQA.DoFieldChange := False;
  try

    cleanISBo := fPQA.IsBO;
    cleanQty  := fPQA.Qty;
    try
      if fPQA.TransDate         <> TransDate        then fPQA.TransDate       := TransDate;
      if fPQA.DepartmentID      <> ClassID          then fPQA.DepartmentID    := ClassID;
      if fPQA.ProductID         <> ProductID        then fPQA.ProductID       := ProductID;
      if fPQA.ProductName       <> ProductName      then fPQA.ProductName     := ProductName;
      if fPQA.ProductPrintName  <> ProductPrintName then fPQA.ProductPrintName:= ProductPrintName;
      if fPQA.UnitOfMeasure     <> UnitOfMeasure    then fPQA.UnitOfMeasure   := UnitOfMeasure;
      if fPQA.UnitOfMeasureID   <> UnitOfMeasureID  then fPQA.UnitOfMeasureID := UnitOfMeasureID;
      if fPQA.UOMMultiplier     <> UOMMultiplier    then fPQA.UOMMultiplier   := UOMMultiplier;
      if fPQA.Qty               <> Quantity         then fPQA.Qty             := Quantity;
      if fPQA.UOMMultiplier     <> 0                then fPQA.UOMQty          := fPQA.Qty / fPQA.UOMMultiplier;
      if fPQA.MatrixRef         <> MatrixRef        then fPQA.MatrixRef       := MatrixRef;


      if fPQA.IsBO <> (BOQty <> 0) and (Qty = 0) then fPQA.IsBO := (BOQty <> 0) and (Qty = 0);
      if (fPQA.IsBO = False) and (fPQA.Active = False) and (cleanISBo) then begin
        fPQA.Active := True;
      end;
      fPQA.PostDb;
      if fPQA.IsBO and not(UpdatingBO) then begin
      //      fPQA.getnewDataset('delete from tblPQADetails where pqaID = ' + inttostr(fPQA.ID), True);
            { everything is back ordered so move to BO fields and zero out shipped qty }
            fPQA.getnewDataset('update tblPQADetails set ' +
              'BOUOMQty = IfNull(BOUOMQty,0) + IfNull(UOMQty,0),' +
              'BOQty = IfNull(BOQty,0) + IfNull(Qty,0) ' +
              'where pqaID = ' + inttostr(fPQA.ID), True);
            fPQA.getnewDataset('update tblPQADetails set ' +
              'UOMQty = 0,' +
              'Qty = 0 ' +
              'where pqaID = ' + inttostr(fPQA.ID), True);
            fPQA.CloseAllAllocationObj;
      end;
    Finally
       if (cleanISBo <> fPQA.IsBO) or (cleanQty  <> fPQA.Qty)  then begin
             if fPQA.Product.Batch        then fPQA.PQABatch.checkAllocateQty (UOMQty , BOUOMQty)
        else if fPQA.Product.Multiplebins then fPQA.PQABins.checkAllocateQty  (UOMQty , BOUOMQty)
        else if fPQA.Product.SnTracking   then fPQA.PQASN.checkAllocateQty    (UOMQty , BOUOMQty);
       end;
    end;
  finally
    fPQA.DoFieldChange := True;
  end;
end;

function TProdQty.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
var
  msg: string;
begin
  Result := inherited DoBeforeDelete(Sender);
  if not Result then Exit;
  if not IsPQAItem then Exit;
  if PQAcount > 0 then
    //PQA.Delete;
    if not TDeletedItem.AddDeleted(PQA,msg) then
      raise Exception.Create('Error - Could not delete PQA: ' + msg);
end;

function TProdQty.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not(Result) then Exit;
  //CreateProductClass;
end;

constructor TProdQty.Create(AOwner: TComponent);
begin
  inherited;
//  ExportExcludeList.Add('productid');
  ExportExcludeList.Add('unitofmeasureid');
  ExportExcludeList.Add('classid');
end;

function TProdQty.CreateProductClass: Boolean;
begin
  Result := True;
  if ProductID = 0 then Exit;
  if ProductClass = nil then Exit;
  if ProductClass.count <> 0 then Exit;

  if not userLock.Lock('tblparts', ProductID, LockGroupName) then begin
    Resultstatus.AddItem(False, rssWarning, 0,UserLock.LockMessage, true);
    Result := False;
    Exit;
  end;
  try
    ProductClass.New;
    ProductClass.ProductID := ProductID;
    ProductClass.DeptID := ClassID;
    ProductClass.PostDb;
    Result := True;
  finally userLock.Unlock('tblparts', ProductID, LockGroupName);
  end;

end;

function TProdQty.GetIsList: Boolean;
begin
  Result := true;
end;

Procedure TProdQty.InitUOM(Const Sender: TField);
begin
  if sender.OldValue = null then
    InitUOM(Sender.Value , '')
  else if sender.Value = null then
    InitUOM('' , sender.OldValue)
  else
    InitUOM(Sender.Value , sender.OldValue);
end;
Procedure TProdQty.InitUOM(const UOMName, UOMNameOldValue:String);
begin
  if (productId <> 0) and (self.UnitOfMeasureID <> -1) then begin
      (*Product.UOMList.Closedb;
      Product.UOMList.OpenDb;*)
      SendEvent(BusObjEvent_Change, BusObjEventVal_OnUOMChange, Self);
      if Product.ProductUOMLocate(UOMName)  then begin
        Self.UOMMultiplier := Product.UOMList.Multiplier;
        Self.UnitOfMeasureID := Product.UOMList.ID;
        Self.UnitOfMeasure := Product.UOMList.UOMName;
        SendEvent(BusObjEvent_Change, BusObjEventVal_uomChanged, self);
      end else begin
        Self.UnitOfMeasure := UOMNameOldValue
      end;
      PostDB;
    end;
end;

function TProdQty.GetIsPQAItem: Boolean;
begin
  Result := (Self.ProductID > 0) and (IsInvProduct( ProductType));
end;

function TProdQty.PQAcount: Integer;
var
  PQAobj: TComponent;
begin
  Result := 0;
  if ID = 0 then Exit;
  PQAobj := getContainerComponent(TPQA, 'TRansLineID = ' + inttostr(Self.ID) + ' and ifnull(TransType,"") = ' + Quotedstr(Self.classname));
  if PQAobj = nil then Exit;
  Result := TPQA(PQAobj).count;
end;


function TProdQty.ProductStandardCost: Double;
begin
  REsult := 0;
end;

function TProdQty.GetPQA: TPQA;
begin
  if ID = 0 then PostnEditDB;
  Result := TPQA(getContainerComponent(TPQA, 'TRansLineID = ' + inttostr(Self.ID) + ' and ifnull(TransType,"") = ' + Quotedstr(Self.classname)));
  if not RawMode then begin
    if (ID <> 0) and (Result.count = 0) and (IsPQAItem) then begin
      Result.New;
    end;
  end;
end;

{these properties don;t look for the tree , ie. sn with bin within batch. this is just the list of allocation of each type}
        function TProdQty.getPQABatches: TPQABatch;
        begin
            Result := nil;
            if not(IsPQAITem) then exit;
            Result := TPQABatch(getContainerComponent(TPQABatch, 'PQAID = ' + inttostr(PQA.ID)));
            Result.isReadonly := TRue;
            Result.REfreshdb;
        end;
        function TProdQty.getPQABins   : TPQABins ;
        begin
          Result := nil;
          if not(IsPQAITem) then exit;
          Result := TPQABins(getContainerComponent (TPQABins , 'PQAID = ' + inttostr(PQA.ID)));
          Result.isreadonly := TRue;
          Result.REfreshdb;
        end;
        function TProdQty.getPQASNs    : TPQASN   ;
        begin
          Result := nil;
          if not(IsPQAITem) then exit;
          Result := TPQASN(getContainerComponent   (TPQASN   , 'PQAID = ' + inttostr(PQA.ID)));
          Result.isreadonly := TRue;
          Result.REfreshdb;
        end;

function TProdQty.getProductClass: TProductClass;
begin
  Result := nil;
  if (ProductID <> 0) and (ClassID <> 0) then Result := TProductClass(getContainerComponent(TProductClass, 'ProductID = ' + inttostr(ProductID) + ' and ClassID = ' + inttostr(ClassID), True, False));
end;

function TProdQty.GetUOMNameProductKey: string;
begin
  if UnitOfMeasureID > 0 then Result := TUnitOfMeasure.IDToggle(UnitOfMeasureID, Connection.Connection)
  else Result := '';
end;


procedure TProdQty.Copyallocation;
begin
  CreateInstance;
  if CopyingTrans then Exit;
  if ObjInstanceToClone.classnameis('TSmartOrderLine') then
  else if IsPQAItem then PQA.Copyallocation;
end;
procedure TPQA.Copyallocation;
begin
  CreateInstance;
  if not(Assigned(ObjInstanceToClone)) then Exit;
  Copyallocation(ObjInstanceToClone.ID);
end;
function TPQA.NewPQADetailObj(const ObjInstanceToCloneID:Integer):TPQADetails;
begin
  Result := TPQADetails.Create(Self);
  Result.Connection := Self.Connection;
  Result.LoadSelect(' PQAID = ' + inttostr(ObjInstanceToCloneID));
  Result.Deleteall(true);
end;
function TPQA.CheckforAllocation(ReqQty: Double): Boolean;
var
  qry: TERPQuery;
begin
  result := True;
  ResultStatus.Clear;
  if ReqQty =0 then exit;
  if Qty < ReqQty then begin // this shouldn't happen
    ResultStatus.AddItem(False, rssWarning, 0, ProductName +' : Qty Required :' + floattostrf(ReqQty, ffGeneral, 15,2)+', Not Enough Qty selected.' , False);
    Result :=  False;
    Exit;
  end;
  if AppEnv.Companyprefs.EnforceAllocationValidation or
     AppEnv.Companyprefs.ValidateAllocation then begin
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(connection.connection);
    try
      qry.SQL.text := 'Select  pqad.PQAType , sum(pqad.Qty) qty from tblpqa pqa inner join tblpqadetails pqad on pqa.PQAID = pqad.PQAID where pqa.pqaid =' + inttostr(ID)+' group by pqad.PQAType';
      commondblib.opendb(qry);
      if (qry.recordcount =0)  or
          (product.batch        and (not(qry.locate('PQAType', TPQABatch.PQADetailtype, []))) or (qry.fieldbyname('qty').asfloat<ReqQty )) or
          (product.MultipleBins and (not(qry.locate('PQAType', TPQABins.PQADetailtype , []))) or (qry.fieldbyname('qty').asfloat<ReqQty )) or
          (product.SnTracking   and (not(qry.locate('PQAType', TPQASN.PQADetailtype   , []))) or (qry.fieldbyname('qty').asfloat<ReqQty )) then begin
          //ResultStatus.AddItem(False, rssWarning, 0, ProductName +' - Enough Qty allocated' + floattostrf(ReqQty, ffGeneral, 15,2)+' for Batch/Bin/SN.' );
          ResultStatus.AddItem(False, rssWarning, 0, ProductName +' : Qty Required :' + floattostrf(ReqQty, ffGeneral, 15,2)+', Not Enough Qty selected in Batch/Bin/SN.'+NL+
                                          'Please Scan the Next Batch With Sufficient Quantity to Finish' , False);
          Result :=  not(AppEnv.Companyprefs.EnforceAllocationValidation);
      end;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;

  end;

end;



procedure TPQA.CloseAllAllocationObj;
begin
                 if Product.Batch        then PQABatch.CloseAll
            else if Product.Multiplebins then PQABins.CloseAll
            else if Product.SnTracking   then PQASN.CloseAll;
end;

procedure TPQA.Copyallocation(const ObjInstanceToCloneID:Integer; InctivateCopyingPQA:Boolean =True);
var
  tablename: string;
  clonePQADetails: TPQADetails;
  qryPQADetails, qry: TERPQuery;
  IDs: string;
  SQLs: TStringList;
  x: integer;

  const
    PQADParentREfPrefix = 'Tmp_';
    // use this prefix to avoid the same globalref is being generated in the copy from and copyto
    // this happens for Stock adjustment as the copy from is a different table

begin
  try
    tablename := TempTableUtils.CreateUserTemporaryTable(CommonDbLib.GetSharedMyDacConnection,'tmp_allocation','','MyISAM');
    qryPQADetails := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    try
      qry := DbSharedObj.GetQuery(TERPConnection(Connection.Connection));
      try
        qryPQADetails.SQL.Text := 'select * from ' + tablename;
        qry.SQL.Add('select PQADetailId, ');
        qry.SQL.Add('concat('+ quotedstr(PQADParentREfPrefix) +' , Globalref)  as Globalref, ');
        qry.SQL.Add('if(ifnull(ParentRef,"")<>"" , concat('+ quotedstr(PQADParentREfPrefix) +' , ParentRef) , "") as ParentREf, ');
        qry.SQL.Add('Qty , UOMQty , BOQty, BOUOMQty,PQAType,');
        qry.SQL.Add('Value , ExpiryDate, TruckLoadNo , binId,');
        qry.SQL.Add('CUSTFLD1, CUSTFLD2, CUSTFLD3 ,CUSTFLD4 , CUSTFLD5 ,CUSTFLD6 ,CUSTFLD7  from  ' + PQAdetailtablename);
        qry.SQL.Add('where PQAId = ' + inttostr(ID) + ' and (ifnull(qty,0)<>0 or ifnull(BOqty,0)<>0) Order By GlobalRef');
        qry.Open;
        if qry.IsEmpty then
            Exit;
        qryPQADetails.Open;
        while not qry.Eof do begin
          qryPQADetails.Append;
          for x := 0 to qry.FieldCount -1 do
            qryPQADetails.FieldByName(qry.Fields[x].FieldName).Value := qry.Fields[x].Value;
          qryPQADetails.Post;
          qry.Next;
        end;

        clonePQADetails := TPQADetails.Create(Self);
        try
          clonePQADetails.Connection := Self.Connection;
          clonePQADetails.LoadSelect(' PQAID = ' + inttostr(ObjInstanceToCloneID));
          clonePQADetails.Deleteall(true);
          IDs := '';
          qryPQADetails.first;
          clog('globalref'+','+'Newglobalref'+','+'ParentRef');
          while qryPQADetails.Eof = False do begin
            clonePQADetails.New;
            clonePQADetails.PQAID     := ObjInstanceToCloneID;
            clonePQADetails.Qty       := qryPQADetails.fieldByname('Qty').asFloat;
            clonePQADetails.UOMQty    := qryPQADetails.fieldByname('UOMQty').asFloat;
            clonePQADetails.BOQty     := qryPQADetails.fieldByname('BOQty').asFloat;
            clonePQADetails.BOUOMQty  := qryPQADetails.fieldByname('BOUOMQty').asFloat;
            clonePQADetails.PQAType   := qryPQADetails.fieldByname('PQAType').asString;
            clonePQADetails.ParentRef := qryPQADetails.fieldByname('ParentRef').asString;
            clonePQADetails.PQAValue  := qryPQADetails.fieldByname('Value').asString;
            clonePQADetails.BinID     := qryPQADetails.fieldByname('BinID').AsInteger;
            if (clonePQADetails is TPQAbatch) or (Sametext(clonePQADetails.PQAType , TPQABatch.PQADetailtype)) then begin
              TPQAbatch(clonePQADetails).TruckLoadNo  := qryPQADetails.fieldByname('TruckLoadNo').asString;
              TPQAbatch(clonePQADetails).CUSTFLD1     := qryPQADetails.fieldByname('CUSTFLD1').asFloat;
            end;
            TPQAbatch(clonePQADetails).CUSTFLD2     := qryPQADetails.fieldByname('CUSTFLD2').asInteger;
            TPQAbatch(clonePQADetails).CUSTFLD3     := qryPQADetails.fieldByname('CUSTFLD3').asInteger;
            TPQAbatch(clonePQADetails).CUSTFLD4     := qryPQADetails.fieldByname('CUSTFLD4').asInteger;
            TPQAbatch(clonePQADetails).CUSTFLD5     := qryPQADetails.fieldByname('CUSTFLD5').AsString;
            TPQAbatch(clonePQADetails).CUSTFLD6     := qryPQADetails.fieldByname('CUSTFLD6').asFloat;
            TPQAbatch(clonePQADetails).CUSTFLD7     := qryPQADetails.fieldByname('CUSTFLD7').asFloat;
            if qryPQADetails.fieldByname('ExpiryDate').asDatetime <> 0 then clonePQADetails.ExpiryDate := qryPQADetails.fieldByname('ExpiryDate').asDatetime;
            clonePQADetails.PostDb;
            if IDs <> '' then IDs := IDs + ',';
            IDs := IDs + inttostr(clonePQADetails.ID);
            qryPQADetails.edit;
            qryPQADetails.fieldByname('Newglobalref').asString := clonePQADetails.Globalref;
            //clonePQADetails.Showrec(clonePQADetails.ID , '', true);
            Logtext(qryPQADetails.fieldByname('globalref').asString+','+qryPQADetails.fieldByname('Newglobalref').asString+','+qryPQADetails.fieldByname('ParentRef').asString);
            qryPQADetails.Post;
            qryPQADetails.next;
          end;
          if qryPQADetails.recordcount = 0 then Exit;
          qryPQADetails.first;
          SQLs := TStringList.Create;
          try
            while qryPQADetails.Eof = False do begin
              SQLs.Add('update tblPQADetails set ParentREf = ' + Quotedstr(qryPQADetails.fieldByname('Newglobalref').asString) + ' where ParentRef = ' +
                Quotedstr(qryPQADetails.fieldByname('Globalref').asString) + ' and PQADetailID in (' + IDs + ');');
              SQLs.Add('update tblsalesbatches SB '+
                      ' Set SB.SalesPQADetailsID = (Select PQADetailID from tblpqadetails where globalref ='+ Quotedstr(qryPQADetails.fieldByname('Newglobalref').asString) +')'+
                        ' Where SB.ManPQAdetailsID =  ' + inttostr(qryPQADetails.fieldbyname('PQADetailID').asInteger) +';');
              qryPQADetails.next;
            end;
            if InctivateCopyingPQA then begin
              SQLs.Add('update ' + PQAdetailtablename + ' Set Active = "F" where PQAID = ' + inttostr(ID) + ';');
              SQLs.Add('update ' + PQAtablename + ' Set Active = "F" where PQAID = ' + inttostr(ID));
            end;
            ExecuteSQL(SQLs, True);
          finally FreeandNil(SQLs);
          end;
        finally
          freeandnil(clonePQADetails);
        end;
      finally
        DbSharedObj.ReleaseObj(qry);
      end;
    finally
      qryPQADetails.Close;
      qryPQADetails.SQL.Text := 'drop table if exists ' + tablename;
      qryPQADetails.Execute;
      DbSharedObj.ReleaseObj(qryPQADetails);
    end;
  finally
    if InctivateCopyingPQA  then begin
      Active := False;
      PostDb;
    end;
  end;
end;

function TProdQty.GetEnableAllocation: Boolean;
begin
  Result := False;
  if ProductID > 0 then Result := (Product.Batch) or (Product.Multiplebins) or (Product.SnTracking);
end;
function  TProdQty.hasInvalidAllocationLine:Boolean;
begin
REsult := (Assigned(Self.Owner)) and (Self.Owner is TBusObj) and (TBusObj(owner).PropertyExists('InvalidAllocationLine')) ;
end;
function  TProdQty.hasinCompleteAllocationLine:Boolean;
begin
  REsult := (Assigned(Self.Owner)) and (Self.Owner is TBusObj) and (TBusObj(owner).PropertyExists('inCompleteAllocationLine')) ;
end;
procedure TProdQty.setInvalidAllocationLine(const Value: Integer);
begin
  if hasInvalidAllocationLine then
    if getPropValue(Self.Owner, 'InvalidAllocationLine') = 0 then SetPropValue(Self.Owner, 'InvalidAllocationLine', ID);
end;

procedure TProdQty.SetUOMNameProductKey(const Value: string);
begin
  if Value <> '' then begin
    with SharedUOM_UnitProduct_Obj(Value) do begin
      if count > 0 then begin
        UnitOfMeasureID := ID;
        UnitOfMeasure := UOMName;
      end else begin
        UnitOfMeasureID := 0;
        UnitOfMeasure := '';
      end;
    end;
  end else begin
    UnitOfMeasureID := 0;
    UnitOfMeasure := '';
  end;
end;

function TProdQty.UpdatingBO: Boolean;
begin
  REsult := False;
end;

procedure TProdQty.setinCompleteAllocationLine(const Value: Integer);
begin
  if hasinCompleteAllocationLine then
    if getPropValue(Self.Owner, 'inCompleteAllocationLine') = 0 then SetPropValue(Self.Owner, 'inCompleteAllocationLine', ID);
end;

function TProdQty.GetHasPQACreated: Boolean;
var
  strSQL: string;
begin
  strSQL := 'Select PQAID from tblPQA where TRansLineID = ' + inttostr(Self.ID) + ' and ifnull(TransType,"") = ' + Quotedstr(Self.Classname);
  with getnewDataset(strSQL, True) do
    try Result := recordcount > 0;
    finally
      if Active then close;
      Free;
    end;
end;
Procedure TProdQty.UpdateproductAverageCost(var Tempcost :Double; intrans:Boolean);
var
    msg :String;
    conn : TMyDacDataConnection;
begin
    if Commonlib.IsInvProduct(Product.ProductType) then begin
      if Product.Lock then begin
          Try
            if intrans then conn := Self.connection else conn := GetSharedMyDAcDataconnection;
             if (AppEnv.CompanyPrefs.UseInventoryStandardCosting) and
               (AppEnv.CompanyPrefs.StandardCostPurchaseAdjustmentAccountID > 0) and (ProductStandardCost<>0) then
                  TempCost := TProduct.UpdateAvgCosts(Self, conn, Product.ID, ProductStandardCost)
              else
                  TempCost := TProduct.UpdateAvgCosts(Self, conn, Product.ID);
          Finally
            if not intrans then Product.Unlock;
          end;
      end else begin
          msg := 'Unable to update ' + Product.ProductName + '''s cost record as product is being updated by "' +
            Product.UserLock.LockInfo.UserName + '" with: ' + Product.UserLock.LockInfo.LockingForm;
            ResultStatus.AddItem(true, rssWarning, 1, msg, False);
      end;
    end;
end;
{ TPQADetailsClass }

constructor TPQADetailsClass.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'PQADetailsClass';
  fSQL := 'SELECT * FROM tblpqadetailsclass';
  fIsChild := true;
  self.ExportExcludeList.Add('classid');
  self.ExportExcludeList.Add('uomid');
end;

destructor TPQADetailsClass.Destroy;
begin
  inherited;
end;

procedure TPQADetailsClass.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'PQAID');
  SetPropertyFromNode(node, 'PQADetailID');
  SetPropertyFromNode(node, 'PQAType');
  SetPropertyFromNode(node, 'ClassID');
  SetPropertyFromNode(node, 'UOMID');
  SetPropertyFromNode(node, 'UOMQty');
  SetPropertyFromNode(node, 'Qty');
  SetBooleanPropertyFromNode(node, 'Active');
end;

procedure TPQADetailsClass.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'PQAID', PQAID);
  AddXMLNode(node, 'PQADetailID', PQADetailID);
  AddXMLNode(node, 'PQAType', PQAType);
  AddXMLNode(node, 'ClassID', ClassID);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'UOMID', UOMId);
  AddXMLNode(node, 'Qty', Qty);
  AddXMLNode(node, 'UOMQty', UOMQty);
end;

function TPQADetailsClass.ValidateData: Boolean;
begin
  Result := False;
  ResultStatus.Clear;
  if PQAID = 0 then begin
    AddResult(False, rssError, 0, 'PQAID should not be 0');
    Exit;
  end;
  if PQADetailID = 0 then begin
    AddResult(False, rssError, 0, 'PQADetailID should not be 0');
    Exit;
  end;
  if ClassID = 0 then begin
    AddResult(False, rssError, 0, 'ClassID should not be 0');
    Exit;
  end;
  if ClassID = -1 then begin
    AddResult(False, rssError, 0, 'Class/Department not found');
    Exit;
  end;
  if UOMID = 0 then begin
    AddResult(False, rssError, 0, 'Unit of Measure missing');
    Exit;
  end;
  if UOMID = -1 then begin
    AddResult(False, rssError, 0, 'Unit of Measure not found', False);
    Exit;
  end;
  Result := True;
end;

class function TPQADetailsClass._Schema: string;
begin
  Result := inherited;
  TBOSchema.AddRefType(Result, 'TUnitOfMeasure', 'UOMObj', 'UOMNameProductKey', 'UnitProductKeyName');
  TBOSchema.AddRefType(Result, 'TUnitOfMeasure', 'UOMObj', 'UOMID', 'ID');
  TBOSchema.AddRefType(Result, 'TDeptClass', 'DeptClassObj', 'DeptClassName', 'DeptClassName');
  TBOSchema.AddRefType(Result, 'TDeptClass', 'DeptClassObj', 'ClassID', 'ID');
end;

function TPQADetailsClass.Save: Boolean;
begin
  Result := False;
  POstDb;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TPQADetailsClass.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TPQADetailsClass.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TPQADetailsClass.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

function TPQADetailsClass.GetUOMProductKeyName: string;
begin
  result:= TUnitOfMeasure.IDToggle(UOMId, Connection.Connection);
end;

function TPQADetailsClass.getUOMID: Integer;
begin
  Result := GetIntegerField('Qty');
end;

function TPQADetailsClass.getUOMQty: Double;
begin
  Result := GetFloatField('UOMQty');
end;

function TPQADetailsClass.getValue: string;
begin
  Result := GetStringField('Value');
end;

class function TPQADetailsClass.GetIDField: string;
begin
  Result := 'ID'
end;

class function TPQADetailsClass.GetBusObjectTablename: string;
begin
  Result := 'tblpqadetailsclass';
end;

function TPQADetailsClass.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  if Assigned(Owner) then
    if Owner is TPQADetails then begin
      PQAID := TPQADetails(Owner).PQAID;
      PQADetailID := TPQADetails(Owner).ID;
      PQAType := TPQADetails(Owner).PQAType;
    end;
end;

function TPQADetailsClass.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TPQADetailsClass.GetPQAID: Integer;
begin
  Result := GetIntegerField('PQAID');
end;

function TPQADetailsClass.GetPQADetailID: Integer;
begin
  Result := GetIntegerField('PQADetailID');
end;

function TPQADetailsClass.GetPQAType: string;
begin
  Result := GetStringField('PQAType');
end;

function TPQADetailsClass.getQty: Double;
begin
  Result := GetFloatField('Qty');
end;

function TPQADetailsClass.GetClassID: Integer;
begin
  Result := GetIntegerField('ClassID');
end;

function TPQADetailsClass.GetDeptClassName: string;
begin
  Result := TDeptClass.IDToggle(ClassID, Connection.Connection);
end;

function TPQADetailsClass.getExpiryDate: TdateTime;
begin
  Result := GetDatetimeField('ExpiryDate');
end;

function TPQADetailsClass.getActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TPQADetailsClass.getbatchno: string;
begin
  Result := PQAValue;
end;

function TPQADetailsClass.getBinID: Integer;
begin
  Result := 0;
  if ISInteger(PQAValue) then Result := strtoint(PQAValue);
end;

function TPQADetailsClass.getBinlocation: string;
begin
  Result := Vars.Values.ByName['BinLocation'].asString;
end;

function TPQADetailsClass.getBinnumber: string;
begin
  Result := Vars.Values.ByName['Binnumber'].asString;
end;

procedure TPQADetailsClass.SetPQAID(const Value: Integer);
begin
  SetIntegerField('PQAID', Value);
end;

procedure TPQADetailsClass.SetPQADetailID(const Value: Integer);
begin
  SetIntegerField('PQADetailID', Value);
end;

procedure TPQADetailsClass.SetPQAType(const Value: string);
begin
  SetStringField('PQAType', Value);
end;

procedure TPQADetailsClass.setQty(const Value: Double);
begin
  SetFloatField('Qty', Value);
end;

procedure TPQADetailsClass.SetUOMProductKeyName(const Value: string);
begin
  if Value <> '' then begin
    UOMId:= TUnitOfMeasure.IDToggle(Value, Connection.Connection);
    if UOMId = 0 then
      UOMId:= -1;
  end
  else
    UOMId:= 0;
end;

procedure TPQADetailsClass.setUOMID(const Value: Integer);
begin
  SetIntegerField('UOMID', Value);
end;

procedure TPQADetailsClass.setUOMQty(const Value: Double);
begin
  SetFloatField('UOMQty', Value);
end;

procedure TPQADetailsClass.setValue(const Value: string);
begin
  SetStringField('Value', Value);
end;

procedure TPQADetailsClass.SetClassID(const Value: Integer);
begin
  SetIntegerField('ClassID', Value);
end;
procedure TPQADetailsClass.SetDeptClassName(const Value: string);
begin
  if Value <> '' then begin
    ClassID := TDeptClass.IDToggle(Value, Connection.Connection);
    if ClassID = 0 then ClassID := -1
  end
  else ClassID := 0;
end;

procedure TPQADetailsClass.setExpiryDate(const Value: TdateTime);
begin
  SetDatetimeField('ExpiryDate', Value);
end;

procedure TPQADetailsClass.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TPQADetailsClass.setBatchno(const Value: string);
begin
  PQAValue := Value;
end;

procedure TPQADetailsClass.setBinID(const Value: Integer);
begin
  PQAValue := inttostr(Value)
end;

procedure TPQADetailsClass.setBinlocation(const Value: string);
begin
  Vars.Values.ByName['Binlocation'].asString := Value;
end;

procedure TPQADetailsClass.setBinnumber(const Value: string);
begin
  Vars.Values.ByName['Binnumber'].asString := Value;
end;

{ TPQADetailsClassBatch }

constructor TPQADetailsClassBatch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'PQADetailsClass';
  fSQL := 'SELECT * FROM tblpqadetailsclass Where PQAType = "Batch"';

end;

function TPQADetailsClassBatch.getPQAbatchno: string;
begin
  Result := PQAValue;
end;

function TPQADetailsClassBatch.getPQAExpiryDate: TdateTime;
begin
  Result := ExpiryDate;
end;

procedure TPQADetailsClassBatch.setPQABatchno(const Value: string);
begin
  PQAValue := Value;
end;

procedure TPQADetailsClassBatch.setPQAExpiryDate(const Value: TdateTime);
begin
  ExpiryDate := PQAExpiryDate;
end;

{ TPQADetailsClassBin }

constructor TPQADetailsClassBin.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'PQADetailsClass';
  fSQL := 'SELECT * FROM tblpqadetailsclass where PQAtype ="Bin"';

end;

function TPQADetailsClassBin.getPQABinID: Integer;
begin
  Result := BinID;
end;

procedure TPQADetailsClassBin.setPQABinID(const Value: Integer);
begin
  BinID := Value;
end;

{ TPQADetailsClassSN }

constructor TPQADetailsClassSN.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'PQADetailsClass';
  fSQL := 'SELECT * FROM tblpqadetailsclass where PQAType = "SN"';
end;

function TPQADetailsClassSN.getPQASerialno: string;
begin
  Result := PQAValue;
end;

procedure TPQADetailsClassSN.SetPQASerialno(const Value: string);
begin
  PQAValue := Value;
end;

{ TPQAFlat }

constructor TPQAFlat.Create(AOwner: TComponent);
begin
  inherited;
  self.ExportExcludeList.Add('pqabatch');
  self.ExportExcludeList.Add('pqabins');
  self.ExportExcludeList.Add('pqasn');
end;

{ TPQADetailsFlat }

constructor TPQADetailsFlat.Create(AOwner: TComponent);
begin
  inherited;
  self.ExportExcludeList.Add('pqabins');
  self.ExportExcludeList.Add('pqasn');
end;

function TPQADetailsFlat.GetTruckLoadNo: string;
begin
  Result := GetStringField('TruckLoadNo');
end;

procedure TPQADetailsFlat.SetTruckLoadNo(const Value: string);
begin
  SetStringfield('TruckLoadNo' , Value);
end;

{ TPQASNLastTransDate }

constructor TPQASNLastTransDate.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'PQASNLastTransDate';
  fSQL := 'SELECT * FROM tblPQASNLastTransDate';
  fFirstLoad := true;
end;

class function TPQASNLastTransDate.GetBusObjectTablename: string;
begin
  result := 'tblPQASNLastTransDate';
end;

function TPQASNLastTransDate.GetDepartmentID: integer;
begin
  result := GetIntegerField('DepartmentID');
end;

class function TPQASNLastTransDate.GetIDField: string;
begin
  result := 'ID';
end;

function TPQASNLastTransDate.GetProductID: integer;
begin
  result := GetIntegerField('ProductID');
end;

function TPQASNLastTransDate.GetSerialNumber: string;
begin
  result := GetStringField('SerialNumber');
end;

function TPQASNLastTransDate.GetTransDate: TDateTime;
begin
  result := GetDateTimeField('TransDate');
end;

procedure TPQASNLastTransDate.Load(const fIsReadonly: boolean);
begin
  { if we are opening the whole list, update the data first .. only first time }
  if fFirstLoad then begin
    fFirstLoad := false;
    self.UpdateTableData;
  end;
  inherited;
end;

procedure TPQASNLastTransDate.SetDepartmentID(const Value: integer);
begin
  SetIntegerField('DepartmentID',Value);
end;

procedure TPQASNLastTransDate.SetProductID(const Value: integer);
begin
  SetIntegerField('ProductID',Value);
end;

procedure TPQASNLastTransDate.SetSerialNumber(const Value: string);
begin
  SetStringField('SerialNumber',Value);
end;

procedure TPQASNLastTransDate.SetTransDate(const Value: TDateTime);
begin
  SetDateTimeField('TransDate',Value);
end;

class procedure TPQASNLastTransDate.UpdateTableData;
var
  cmd: TERPCommand;
begin
  cmd := DbSharedObj.GetCommand(CommonDbLib.GetSharedMyDacConnection);
  try
    cmd.SQL.Add('insert into tblPQASNLastTransDate (ProductID, DepartmentID, SerialNumber, TransDate, msUpdatesiteCode)');
    cmd.SQL.Add('select t.ProductID,t.DepartmentID,t.Value,t.TransDate, t.SiteCode');
    cmd.SQL.Add('from');
    cmd.SQL.Add('(select pqa.ProductID  ,pqa.DepartmentId , pqad.value ,   max(pqa.transDate) as TransDate, tblmsbackendid.SiteCode as SiteCode');
    cmd.SQL.Add('from tblPQADetails pqad');
    cmd.SQL.Add('inner join tblpqa pqa on pqa.PQAID = pqad.PQAID');
    cmd.SQL.Add('inner join tblmsbackendid');
    cmd.SQL.Add('where pqad.PQAType = "SN"  and pqad.qty <> 0 and (pqa.Active = "T"');
    cmd.SQL.Add('or  pqa.transtype in ("TProcTreePart","TProcTreePartIN","TProcTreePartINDONE","TProcProgressIn"))');
    cmd.SQL.Add('group by 	pqa.ProductID  ,pqa.DepartmentId,  pqad.value) as t');
    cmd.SQL.Add('on duplicate key update tblPQASNLastTransDate.TransDate =  t.TransDate, tblPQASNLastTransDate.msUpdatesiteCode = t.SiteCode;');
    cmd.Execute;

    cmd.SQL.Clear;
    cmd.SQL.Add('update tblPQASNLastTransDate');
    cmd.SQL.Add('inner join');
    cmd.SQL.Add('(select tblpqa.ProductID, tblPQADetails.Value, tblpqa.TransDate as TransDate, max(tblPQADetails.MsTimeSTamp) as msTimeSTamp from  tblPQADetails');
    cmd.SQL.Add('inner join tblpqa on tblpqa.PQAID = tblPQADetails.PQAID');
    cmd.SQL.Add('where tblPQADetails.PQAType = "SN" and tblPQADetails.Qty <> 0');
    cmd.SQL.Add('group by tblpqa.ProductID, tblPQADetails.Value, tblpqa.TransDate');
    cmd.SQL.Add(') as t');
    cmd.SQL.Add('inner join tblmsbackendid');
    cmd.SQL.Add('on t.ProductID = tblPQASNLastTransDate.ProductID and t.Value = tblPQASNLastTransDate.SerialNumber and t.TransDate = tblPQASNLastTransDate.TransDate');
    cmd.SQL.Add('set tblPQASNLastTransDate.MsTimeSTamp = t.MsTimeStamp, tblPQASNLastTransDate.msUpdateSiteCode = tblmsbackendid.SiteCode');
    cmd.Execute;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;

initialization

  RegisterClass(TPQADetailsClass);
  RegisterClassOnce(TProductBin);
  RegisterClassOnce(TPQABatch);
  RegisterClassOnce(TPQABins);
  RegisterClassOnce(TPQASN);
  RegisterClassOnce(TPQA);
  RegisterClass(TPQADetailsFlat);
  RegisterClass(TPQAFlat);
  RegisterClass(TPQASNLastTransDate);

end.

