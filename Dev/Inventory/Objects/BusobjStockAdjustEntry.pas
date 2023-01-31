unit BusobjStockAdjustEntry;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  13/05/08  1.00.01  BJ  Initial Version.
  }


interface


Uses TypesLib, Windows, BusObjBase, DB, Classes, XMLDoc, XMLIntf, busobjPQA,
  busobjStockMovement, ComCtrls, wwDbGrid, ERPDbComponents;

const
    STOCKADJUSTEXPORTFIELDNAMES =  'ProductColumn1,ProductColumn2,ProductColumn3,'+
                                    'ProductName,PartsDescription,ClassName,UOM,'+
                                    'UOMMultiplier,Finalcount,AccountGroup,AccountName,'+
                                    'Batchnumber,ExpiryDate,BinLocation,BinNumber,'+
                                    'Serialnumber,BinBatchFinalcount,Cost,Active,ProductBarCode';
type
  TCreateBin = Procedure (const classID:Integer; const BinLocation, Binnumber:STring) of object;
  TStockAdjustEntryPQADetails = class(TPQADetails)
    Private
    Public
        constructor      Create(AOwner: TComponent);override;
    Protected
        function  DoAfterInsert(Sender: TDatasetBusObj): boolean; Override;
        function GetSQL:String; override;
  end;
  TStockAdjustEntryPQA = class(TPQA)
    Private
        function getPQADetails: TStockAdjustEntryPQADetails;reintroduce;
    Public
        constructor      Create(AOwner: TComponent);override;
        Property PQADetails :TStockAdjustEntryPQADetails Read getPQADetails;
        Function PQAdetailtablename:string ; Override;
    Protected
        function  DoAfterInsert(Sender: TDatasetBusObj): boolean; Override;
        Function GetSQL:String; override;
        Function GetPQABatch         : TPQABatch; Override;
        Function GeTPQABins          : TPQABins;Override;
        Function GeTPQASN            : TPQASN;Override;
        Function PQAtablename:string ; Override;
  end;
  TStockAdjustEntryPQABatch = class(TPQABatch)
    private
    Public
      constructor      Create(AOwner: TComponent);override;
    Protected
      Function GetSQL:String; override;
      Function GeTPQABins          : TPQABins;override;
      Function GeTPQASN            : TPQASN;override;

  end;
  TStockAdjustEntryPQABins = class(TPQABins)
    private
    Public
      constructor      Create(AOwner: TComponent);override;
    Protected
      Function GetSQL:String; override;
      Function GeTPQASN            : TPQASN;override;

  end;
  TStockAdjustEntryPQASN = class(TPQASN)
    private
    Public
      constructor      Create(AOwner: TComponent);override;
    Protected
      Function GetSQL:String; override;
      Function         ValidateSN :Boolean;Override;
      function  DoAfterInsert(Sender: TDatasetBusObj): boolean; Override;
  end;

  TSAELines = class(TProdQty)
  private
    cleanProductDetails   :String;
    fbCalcQtyFromformula:Boolean;
    Function  ProductDetails: String;
    function GetDescription                  : string    ;
    function GetDeptID                       : Integer   ;
    function GetDeptName                     : string    ;
    function GetJobID                        : Integer   ;
    function GetJobName                      : string    ;
    function GetAccountID                    : Integer   ;
    function GetAccountName                  : string    ;
    function GetAvailableQty                 : Double    ;
    function GetInStockQty                   : Double    ;
    function GetFinalQty                     : Double    ;
    function GetAdjustQty                    : Double    ;
    function GetAvailableUOMQty              : Double    ;
    function GetFinalUOMQty                  : Double    ;
    function GetAdjustUOMQty                 : Double    ;
    function GetCost                         : Double    ;
    function GetUOM                          : string    ;
    function GetDeleted                      : Boolean   ;
    function GetUOMID                        : Integer   ;
    function GetAdjustmentDate: TDateTime;
    procedure SetDescription                  (const Value: string    );
    procedure SetDeptID                       (const Value: Integer   );
    procedure SetDeptName                     (const Value: string    );
    procedure SetJobID                        (const Value: Integer   );
    procedure SetJobName                      (const Value: string    );
    procedure SetAccountID                    (const Value: Integer   );
    procedure SetAccountName                  (const Value: string    );
    procedure SetAvailableQty                 (const Value: Double    );
    procedure SetInStockQty                   (const Value: Double    );
    procedure SetFinalQty                     (const Value: Double    );
    procedure SetAdjustQty                    (const Value: Double    );
    procedure SetAvailableUOMQty              (const Value: Double    );
    procedure SetFinalUOMQty                  (const Value: Double    );
    procedure SetAdjustUOMQty                 (const Value: Double    );
    procedure SetCost                         (const Value: Double    );
    procedure SetUOM                          (const Value: string    );
    procedure SetDeleted                      (const Value: Boolean   );
    procedure SetUOMID                        (const Value: Integer   );
    Function  ProductChanged :Boolean;
    function getLockAdjustQty: TGeneralBooleanProc;
    function getLockAllocAdjustQty: TGeneralBooleanProc;
    function GetAdjustonInStock: Boolean;
    function getEnforceUOM: Boolean;
    function getInStockUOMQty: Double;
    procedure SetInStockUOMQty(const Value: Double);
    function getTotalCost: Double;
    function getUOMCost: Double;
    function getPartBarcode: String;
    procedure setPartBarcode(const Value: String);
    procedure CalcQtyFromformula;
    procedure getCalcQtYformulaValue(Sender: TObject; const VarName: string;
      var Value: extended; var FieldFound: Boolean);
    function GetNotes: string;
    procedure SetNotes(const Value: string);
    procedure DoOnProductchange;
    procedure Calcfinalqty;
    function getprocessed: Boolean;
    Function CreatingTreeModeData:Boolean;

  protected
    procedure SetProductID                    (const Value: Integer   );override;
    procedure SetProductName                  (const Value: string    );override;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    function  DoBeforePost(Sender: TDatasetBusObj): Boolean;              override;
    function  DoAfterInsert(Sender: TDatasetBusObj): boolean; Override;
    Function GetUnitOfMeasure    :String;    Override;
    Function GetUnitOfMeasureID  :Integer;   Override;
    function GetUOMMultiplier    :Double;    Override;
    Function GetClassID          :Integer;   Override;
    Function GetProductID        :Integer;   Override;
    function GetProductName      :String;    Override;
    Function GetActive           :Boolean;   Override;
    Function GetTransDate        :TDatetime; Override;
    Function GetBOQty            :Double;    Override;
    Function GetBOUOMQty         :Double;    Override;
    function GetSerialnos        :String;    Override;
    function GetCleanClassID     :Integer;   Override;
    function GetcleanProductId   :Integer;   Override;
    Procedure SetUnitOfMeasure  (const Value :String);  Override;
    Procedure SetUnitOfMeasureID(Const Value :Integer); Override;
    Procedure SetUOMMultiplier  (Const Value :Double);  Override;
    procedure SetSerialNos      (const Value: String);  Override;
    procedure SetTransDate(const Value: TDatetime); override;
    procedure CheckProduct(ForceCheckProduct:Boolean=False); virtual; abstract;
    Procedure CreateInstance;override;
    Procedure ClonePropertyObjects;Override;
    procedure SetOrderQty(const Value: double); override;
    function GetOrderQty: double; override;
    procedure SetUOMOrderQty(const Value: double); override;
    function GetUOMOrderQty: double; override;
    function GetProductType: string;override;
    procedure SetProductType(const Value: string);override;
    procedure SetMatrixRef(const Value: String);Override;
    function GetMatrixRef: String;Override;
    function GetMatrixDesc: String;Override;
    function GetMatrixPrice:Double;Override;
    procedure SetMatrixDesc(const Value: String);Override;
    procedure SetMatrixPrice(const Value: Double);Override;
    procedure InitUOM(const UOMName, UOMNameOldValue: String);Overload;Override;
    function isProcessed:boolean;
    procedure SetUOMNameProductKey(const Value: string); override;
    procedure CalcAdjustQty;Virtual;
    function GetStockAdjustEntryID           : Integer   ;
    procedure SetStockAdjustEntryID           (const Value: Integer   );
  public
    class function GetBusObjectTablename: string; override;
    constructor      Create(AOwner: TComponent);                         override;
    destructor       Destroy;                                            override;
    procedure        LoadFromXMLNode(const node: IXMLNode);              override;
    procedure        SaveToXMLNode(const node: IXMLNode);                override;
    function         ValidateData: Boolean;                              override;
    function         Save: Boolean;                                      override;
    Class function   GetIDField              : string;                   override;
    Class function   GetKeyStringField       : string;                   override;
    property AdjustmentDate         :TDateTime   read GetAdjustmentDate;
    Procedure calcAvailableQty(force: boolean = false);
    Property LockAdjustQty : TGeneralBooleanProc read getLockAdjustQty;
    Property LockAllocAdjustQty : TGeneralBooleanProc read getLockAllocAdjustQty;
    Property EnforceUOM:Boolean Read getEnforceUOM;
    Property AdjustonInStock :Boolean Read GetAdjustonInStock;
    Property TotalCost :Double read getTotalCost;
    Property UOMCost :Double read getUOMCost;
    Function CloneBusObj(const Changefield :String; const ChangeValue :Variant; const SaveAfterCopy : Boolean = True; const FilterFields :String = ''):TBusObj; Override;
    property StockAdjustEntryID            :Integer     read GetStockAdjustEntryID          write SetStockAdjustEntryID       ;
    class function _Schema: string; override;
    Property processed :Boolean read getprocessed;
  published
    property Description                   :string      read GetDescription                 write SetDescription              ;
    property DeptID                        :Integer     read GetDeptID                      write SetDeptID                  ;
    property DeptName                      :string      read GetDeptNAme                    write SetDeptName                ;
    property AccountID                     :Integer     read GetAccountID                   write SetAccountID                  ;
    property AccountName                   :string      read GetAccountName                 write SetAccountName                ;
    property AvailableQty                  :Double      read GetAvailableQty                write SetAvailableQty             ;
    property InStockQty                    :Double      read GetInStockQty                  write SetInStockQty             ;
    Property InStockUOMQty                 :Double      Read getInStockUOMQty               Write SetInStockUOMQty;
    property FinalQty                      :Double      read GetFinalQty                    write SetFinalQty                 ;
    property AdjustQty                     :Double      read GetAdjustQty                   write SetAdjustQty                ;
    property AvailableUOMQty               :Double      read GetAvailableUOMQty             write SetAvailableUOMQty          ;
    property FinalUOMQty                   :Double      read GetFinalUOMQty                 write SetFinalUOMQty              ;
    property AdjustUOMQty                  :Double      read GetAdjustUOMQty                write SetAdjustUOMQty             ;
    property Cost                          :Double      read GetCost                        write SetCost                     ;
    property UOM                           :string      read GetUOM                         write SetUOM                      ;
    property UOMMultiplier                 :Double      read GetUOMMultiplier               write SetUOMMultiplier            ;
    property UOMID                         :Integer     read GetUOMID                       write SetUOMID                    ;
    property Deleted                       :Boolean     read GetDeleted                     write SetDeleted                  ;
    property PartBarcode :String read getPartBarcode write setPartBarcode;
    property Notes: string read GetNotes write SetNotes;
    property JobID                         :Integer     read GetJobID                       write SetJobID                    ;
    property JobName                       :string      read GetJobName                     write SetJobName                  ;
  end;

    TSAELinesTree = class(TSAELines)
    Private
        function getSAEPQA: TStockAdjustEntryPQA;
        function getPQAAllocation: String;
        procedure setPQAAllocation(const Value: String);
    Protected
        Function GetPQA : TPQA  ; Override;
        Function GetSQL : String; override;
        Function GetQty : Double; override;
        procedure DoFieldOnChange(Sender: TField); override;
        function GetAllocType      : String;   override;
        Function GetUOMQty           :Double;    Override;
        procedure SetActive(const Value: Boolean); override;
        procedure SetBOQty(const Value: Double); override;
        procedure SetBOUOMQty(const Value: Double); override;
        procedure SetQty(const Value: Double); override;
        procedure SetUOMQty(const Value: Double); override;
        procedure CheckProduct(ForceCheckProduct:Boolean=False); override;
        function GetOrderQty         :Double;    override;
        procedure SetOrderQty(const Value: Double);override;
        function GetUOMOrderQty         :Double;    override;
        procedure SetUOMOrderQty(const Value: Double);override;
        function  DoAfterInsert(Sender: TDatasetBusObj): boolean; Override;
        function  DoAfterOpen(Sender: TDatasetBusObj): boolean; Override;
    Public
        constructor Create(AOwner:TComponent); override;
        Property SAEPQA :TStockAdjustEntryPQA read getSAEPQA;
        Property PQAAllocation :String read getPQAAllocation write setPQAAllocation;
    Published
  End;

  { Include in Site Intergration }
  TSAELinesFlat = class(TSAELines)
  private
    fCreatebin: TCreatebin;
    function GetBatchNo                      : string    ;
    function GetExpirydate                   : TDateTime ;
    function GetBinLocation                  : string    ;
    Function getBinID                        : Integer   ;
    function GetBinNumber                    : string    ;
    function GetSerialNumber                 : string    ;
    function GetAllocationAvailableQty       : Double    ;
    function GetAllocationInStockQty         : Double    ;
    function GetAllocationFinalqty           : Double    ;
    function GetAllocationAdjustQty          : Double    ;
    function GetAllocationAvailableUOMQty    : Double    ;
    function GetAllocationFinalUOMQty        : Double    ;
    function GetAllocationAdjustUOMQty       : Double    ;
    procedure SetBatchNo                      (const Value: string    );
    procedure SetExpirydate                   (const Value: TDateTime );
    procedure SetBinLocation                  (const Value: string    );
    Procedure SetBinID                        (Const Value: Integer);
    procedure SetBinNumber                    (const Value: string    );
    procedure SetSerialNumber                 (const Value: string    );
    procedure SetAllocationAvailableQty       (const Value: Double    );
    procedure SetAllocationInStockQty         (const Value: Double    );
    procedure SetAllocationFinalqty           (const Value: Double    );
    procedure SetAllocationAdjustQty          (const Value: Double    );
    procedure SetAllocationAvailableUOMQty    (const Value: Double    );
    procedure SetAllocationFinalUOMQty        (const Value: Double    );
    procedure SetAllocationAdjustUOMQty       (const Value: Double    );
    procedure EditnSetStringField(const FieldName: string; const Value: string);
    procedure EditnSetFloatField(const FieldName: string; const Value: double);
    procedure EditnSetIntegerField(const FieldName: string; const Value: Integer);
    procedure EditnSetDateTimeField(const FieldName: string; const Value: TDateTime);
    function getXMLTocopyLine: String;
    Procedure storeValues;
    function GetAllocationInStockUOMQty: Double;
    procedure setAllocationInStockUOMQty(const Value: Double);
    Procedure clearalloc;
    function ImportingStockAdjustment :boolean;
    procedure Calcallocfinalqty;
    procedure CalcallocAdjustQty;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    function  DoBeforePost(Sender: TDatasetBusObj): Boolean;             override;
    function  DoAfterInsert(Sender: TDatasetBusObj): Boolean;            override;
    function  DoBeforeInsert(Sender: TDatasetBusObj): Boolean;            override;
    function  GetHeaderID: Integer;                                      override;
    Function  GetIsPQAItem       :Boolean;                               override;
    function  GetAllocType      : String;                                Override;
    Function GetQty              :Double;    Override;
    Function GetUOMQty           :Double;    Override;
    procedure CheckProduct(ForceCheckProduct:Boolean=False); Override;
    procedure SetActive(const Value: Boolean); override;
    procedure SetBOQty(const Value: Double); override;
    procedure SetBOUOMQty(const Value: Double); override;
    procedure SetQty(const Value: Double); override;
    procedure SetUOMQty(const Value: Double); override;
    procedure CalcAdjustQty;override;
  public
    constructor      Create(AOwner: TComponent);                         override;
    destructor       Destroy;                                            override;
    procedure        LoadFromXMLNode(const node: IXMLNode);            override;
    procedure        SaveToXMLNode(const node: IXMLNode);              override;
    function         ValidateData: Boolean;                              override;
    function         ValidateAllocationAttribs:Boolean;
    function         Save: Boolean;                                      override;
    Class function   GetBusObjectTablename   : string;                   override;
    Property         HeaderID :Integer Read getHeaderID;
    Procedure        calcAllocAvailableQty;
    Property         XMLTocopyLine :String REad getXMLTocopyLine;
    Property Createbin :TCreatebin Read fCreatebin Write fCreatebin;
    Procedure OnProductchange;
    procedure Onallocationchange;
  published
    property BatchNo                       :string      read GetBatchNo                     write SetBatchNo                  ;
    property ExpiryDate                    :TDateTime   read GetExpirydate                  write SetExpirydate               ;
    property BinLocation                   :string      read GetBinLocation                 write SetBinLocation              ;
    Property BinID                         :Integer     Read getBinID                       Write setbinId;
    property BinNumber                     :string      read GetBinNumber                   write SetBinNumber                ;
    property SerialNumber                  :string      read GetSerialNumber                write SetSerialNumber             ;
    property AllocationAvailableQty        :Double      read GetAllocationAvailableQty      write SetAllocationAvailableQty   ;
    property AllocationInStockQty          :Double      read GetAllocationInStockQty        write SetAllocationInStockQty          ;
    Property AllocationInStockUOMQty            :Double      Read GetAllocationInStockUOMQty          Write setAllocationInStockUOMQty;
    property AllocationFinalQty            :Double      read GetAllocationFinalqty          write SetAllocationFinalqty       ;
    property AllocationAdjustQty           :Double      read GetAllocationAdjustQty         write SetAllocationAdjustQty      ;
    property AllocationAvailableUOMQty     :Double      read GetAllocationAvailableUOMQty   write SetAllocationAvailableUOMQty;
    property AllocationFinalUOMQty         :Double      read GetAllocationFinalUOMQty       write SetAllocationFinalUOMQty    ;
    property AllocationAdjustUOMQty        :Double      read GetAllocationAdjustUOMQty      write SetAllocationAdjustUOMQty   ;
  end;

  { Include in Site Intergration }
  TStockAdjustEntry = class(TMSBusObj)
  private
    fsPQAtablename          : String;
    fsPQADetailstablename   : String;
    fsLinesProductstablename: String;
    //fProgressbar: TProgressbar;
    fShowStatus: TGeneralStringProc;
    fCreatebin: TCreatebin;
    fLockAdjustQty: TGeneralBooleanProc;
    fLockAllocAdjustQty: TGeneralBooleanProc;
    fbinTreemode: Boolean;
    AllLinesValid :Boolean;
    fbTempSave: boolean;
    fbProcessing: Boolean;
    fscountcaption: String;
    fbImportingStockAdjustment :Boolean;
    CreateTreeModeDataDone: boolean;
    CreatingTreeModeData:Boolean;
    fbDoProcessonSave: boolean;
    function GetCreationDate          : TDateTime ;
    function GetAdjustmentDate        : TDateTime ;
    function GetAccountID             : Integer   ;
    function GetAccountname           : string    ;
    function GetNotes                 : string    ;
    function GetIsStocktake           : Boolean   ;
    function GetEmployee              : string    ;
    function GetDeleted               : Boolean   ;
    procedure SetCreationDate          (const Value: TDateTime );
    procedure SetAdjustmentDate        (const Value: TDateTime );
    procedure SetAccountID             (const Value: Integer   );
    procedure SetAccountname           (const Value: string    );
    procedure SetNotes                 (const Value: string    );
    procedure SetIsStocktake           (const Value: Boolean   );
    procedure SetEmployee              (const Value: string    );
    procedure SetDeleted               (const Value: Boolean   );
    function GetLines: TSAELinesFlat;
    function GetProcessed: Boolean;
    procedure SetProcessed(const Value: Boolean);
    function getLineProducts: TSAELinestree;
    function getLinesProductstablename: String;
    procedure setLinesProductstablename(const Value: String);
    function getPQADetailstablename: String;
    procedure setPQADetailsTablename(const Value: String);
    function getPQAtablename: String;
    procedure setPQATablename(const Value: String);
    function GetCleanDeleted: Boolean;
    Procedure DeleteStockAdjust;
    Procedure checkAlloctype(Const Sender: TBusObj; var Abort: boolean);
    Procedure UpdateAvgcost(Const Sender: TBusObj; var Abort: boolean);
    Procedure AssignAccountID(Const Sender: TBusObj; var Abort: boolean);
    Procedure CallbackValidateData(Const Sender: TBusObj; var Abort: boolean);
    Procedure CallbackValidateLineProducts(Const Sender: TBusObj; var Abort: boolean);
    Procedure CallbackSaveLines(Const Sender: TBusObj; var Abort: boolean);
    //Procedure showProgressbar(const total:Integer; const Msg:String);
    //Procedure HideProgressbar;
    //Procedure incProgressbar(const Value :String );Overload;
    //Procedure incProgressbar;Overload;
    Procedure DeleteFlagedLines;
    function getStockMovement: TStockMovement;
    function getAdjustOnInstock: Boolean;
    function getEnforceUOM: Boolean;
    procedure SetAdjustOnInstock(const Value: Boolean);
    procedure SetEnforceUOM(const Value: Boolean);
    procedure CloneLines(const Sender: TBusObj; var Abort: boolean);
    function getImportgroupOriginalno: String;
    procedure setImportgroupOriginalno(const Value: String);
    function getAdjusttype: String;
    procedure setAdjusttype(const Value: String);
    function GetApproved: boolean;
    procedure SetApproved(const Value: boolean);
    function GetLineProductsAssigned: Boolean;
    procedure qryAfterCloseDatasetLog(DataSet: TDataSet);
    function GetTotalCostEx: double;
    Function DeletelineIf0Qty:Boolean;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    function  DoAfterInsert(Sender: TDatasetBusObj): boolean; Override;
    Procedure CreateInstance;override;
    Procedure ClonePropertyObjects;Override;
  public
    Procedure GetPropertyXMLCallback (Const Sender: TBusObj; var Abort: boolean); override;
    constructor Create(AOwner: TComponent);                         override;
    destructor  Destroy;                                            override;
    procedure   LoadFromXMLNode(const node: IXMLNode);              override;
    procedure   SaveToXMLNode(const node: IXMLNode);                override;
    function    ValidateData: Boolean;                              override;
    function    Save: Boolean;                                      override;
    Function    Process :Boolean;
    Class function   GetIDField              : string;                   override;
    Class function   GetKeyStringField       : string;                   override;
    Class function   GetBusObjectTablename   : string;                   override;
    Class function   Transtype               : String;
    Property LineProducts           : TSAELinestree read getLineProducts;
    Property PQATablename           : String        read getPQAtablename           Write setPQATablename;
    Property PQADetailsTablename    : String        read getPQADetailstablename    Write setPQADetailsTablename;
    Property LinesProductstablename : String        read getLinesProductstablename Write setLinesProductstablename;
    Property CleanDeleted           : Boolean       Read GetCleanDeleted;
    Property CountCaption :String read fscountcaption write fscountcaption ;
    Function CreateTreeModeData: boolean;
    Function CreateFlatModeData: Boolean;
    function Lock() :Boolean ; override;
    //Property Progressbar : TProgressbar       REad fProgressbar Write fProgressbar;
    Property ShowStatus  : TGeneralStringProc REad fShowStatus  write fShowStatus;
    Property Createbin :TCreatebin read fCreatebin write fCreatebin;
    Property StockMovement :TStockMovement read getStockMovement;
    Property LockAdjustQty :TGeneralBooleanProc REad fLockAdjustQty Write fLockAdjustQty;
    Property LockAllocAdjustQty :TGeneralBooleanProc REad fLockAllocAdjustQty Write fLockAllocAdjustQty;
    Property inTreemode:Boolean read fbinTreemode write fbinTreemode;
    Property TempSave:boolean REad    fbTempSave Write fbTempSave;
    //Property Processing :Boolean read fbProcessing Write fbProcessing;
    Property ImportingStockAdjustment :Boolean read fbImportingStockAdjustment write fbImportingStockAdjustment;
    property Processed              :Boolean     read GetProcessed            write SetProcessed         ;
    Function CloneBusObj(const Changefield :String; const ChangeValue :Variant; const SaveAfterCopy : Boolean = True; const FilterFields :String = ''):TBusObj; Override;
    //class Function AutoAdjustBin(const fProductID:Integer =0; const fClassID:Integer=0 ; fFilter:String=''; AdjustBatchno:String = ''; SAOriginalno:String = '';fStockAdjust:TStockAdjustEntry=nil; SelectGrid: TwwDbGrid = nil; Emptybin:Boolean =False):String;
    class Function AutoAdjustBin(const fProductIDs:String =''; const fClassIDs:String ='' ; fFilter:String=''; AdjustBatchno:String = ''; SAOriginalno:String = '';fStockAdjust:TStockAdjustEntry=nil; SelectGrid: TwwDbGrid = nil; Emptybin:Boolean =False):String;
    class Function EmptyStock(const AdjDate:TDatetime; Const StockBasedoninstock:Boolean; const fProductIDs:String =''; const fClassIDs:String ='' ):String;
    Function AutoAdjusttoDefaultBin(DefaultBinID:Integer; const fProductID:Integer ; const fClassID:Integer; AssignUnallocatedasWell:boolean; AdjustBatchno:String):String;
    class function CreateStockAdjust(const fProductID:Integer ; const fClassID:Integer ;  const fQty :double; const fuom:String; const fIsQtyFromStock:boolean; const fBatchno:String = ''; const fexpirydate:Tdatetime=0; const fbinlocation:String='' ;const fbinnumber:String=''; const fserialnumber:String = ''):Integer;
    class function _Schema: string; override;
    Property LineProductsAssigned:Boolean read GetLineProductsAssigned ;
    procedure DeleteSAELineTables;
  published
    property CreationDate           :TDateTime   read GetCreationDate         write SetCreationDate      ;
    property AdjustmentDate         :TDateTime   read GetAdjustmentDate       write SetAdjustmentDate    ;
    property AccountID              :Integer     read GetAccountID            write SetAccountID         ;
    property AccountName            :string      read GetAccountname          write SetAccountname       ;
    property Notes                  :string      read GetNotes                write SetNotes             ;
    property IsStockTake            :Boolean     read GetIsStocktake          write SetIsStocktake       ;
    Property EnforceUOM             :Boolean     Read getEnforceUOM           Write SetEnforceUOM;
    Property AdjustmentOnInStock    :Boolean     Read getAdjustOnInstock      Write SetAdjustOnInstock;
    property Employee               :string      read GetEmployee             write SetEmployee          ;
    property Deleted                :Boolean     read GetDeleted              write SetDeleted           ;
    Property ImportGroupOriginalNo  :String      read getImportgroupOriginalno write setImportgroupOriginalno;
    Property AdjustType  :String      read getAdjusttype write setAdjusttype;
    Property Lines                  : TSAELinesFlat read GetLines;
    property Approved: boolean read GetApproved write SetApproved;
    property TotalCostEx : double read GetTotalCostEx;
    Property DoProcessonSave :boolean read fbDoProcessonSave write fbDoProcessonSave;
    property IsProcessed            :Boolean     read GetProcessed;
  end;

  function ReadLineTablename: String;
  function ReadPQADetailTablename: String;
  function ReadPQAtablename: String;
  function UnallocatedBinQty(Productfilter:String; emptybin:Boolean =False):String;

implementation

uses  tcDataUtils, CommonLib, CommonDbLib, sysutils,
  AppEnvironment, BusObjStock, BusObjConst, AppContextObj, Variants,
  ProgressDialog, BusObjGLAccount, MySQLConst, ProductQtyLib, BusObjClass,
  MyAccess, Dialogs, Controls, BusObjProductbin,
  ParserLib, BusObjSchemaLib, BusObjUom, tcConst, LogLib, SystemLib,
  PQALib, SharedObjs, TempTableUtils, DbSharedObjectsObj, ApprovalObj;

{ TSAELinesFlat }

constructor TSAELines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ExportExcludeList.Add('orderqty');
  ExportExcludeList.Add('uomorderqty');
  fbCalcQtyFromformula:= False;
  ExportExcludeList.Add('deptid');
  ExportExcludeList.Add('accountid');
  ExportExcludeList.Add('uomid');
  FieldsnotToclone := 'UOMNameProductKey';
end;

Class function TSAELines.GetIDField: string;
begin
  Result := 'StockAdjustEntryLinesID'
end;

Class function TSAELines.GetKeyStringField: string;
begin
  Result := ''
end;

destructor TSAELines.Destroy;
begin
  logtext(Classname+':destroyed');
  inherited;
end;


procedure TSAELines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'StockAdjustEntryID');
  SetPropertyFromNode(node,'ProductID');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'DeptID');
  SetPropertyFromNode(node,'DeptName');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'AccountName');
  SetPropertyFromNode(node,'AvailableQty');
  SetPropertyFromNode(node,'InStockQty');
  SetPropertyFromNode(node,'InStockUOMQty');
  SetPropertyFromNode(node,'FinalQty');
  SetPropertyFromNode(node,'AdjustQty');
  SetPropertyFromNode(node,'AvailableUOMQty');
  SetPropertyFromNode(node,'FinalUOMQty');
  SetPropertyFromNode(node,'AdjustUOMQty');
  SetPropertyFromNode(node,'Cost');
  SetPropertyFromNode(node,'UnitOfMeasure');
  SetPropertyFromNode(node,'UOMMultiplier');
  SetBooleanPropertyFromNode(node,'Deleted');
  SetPropertyFromNode(node,'UnitOfMeasureID');
  SetPropertyFromNode(node,'PartBarcode');
  SetPropertyFromNode(node,'Notes');
end;

procedure TSAELines.SaveToXMLNode(const node: IXMLNode);
begin
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'DeptID' ,DeptID);
  AddXMLNode(node,'DeptName' ,DeptName);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'AccountName' ,AccountName);
  AddXMLNode(node,'AvailableQty' ,AvailableQty);
  AddXMLNode(node,'InStockQty' ,InStockQty);
  AddXMLNode(node,'InStockUOMQty' ,InStockUOMQty);
  AddXMLNode(node,'FinalQty' ,FinalQty);
  AddXMLNode(node,'AdjustQty' ,AdjustQty);
  AddXMLNode(node,'AvailableUOMQty' ,AvailableUOMQty);
  AddXMLNode(node,'FinalUOMQty' ,FinalUOMQty);
  AddXMLNode(node,'AdjustUOMQty' ,AdjustUOMQty);
  AddXMLNode(node,'AdjustmentDate' ,AdjustmentDate);
  AddXMLNode(node,'Cost' ,Cost);
  AddXMLNode(node,'UnitOfMeasure' ,UnitOfMeasure);
  AddXMLNode(node,'UOMMultiplier' ,UOMMultiplier);
  AddXMLNode(node,'Deleted' ,Deleted);
  AddXMLNode(node,'UnitOfMeasureID' ,UnitOfMeasureID);
  AddXMLNode(node,'PartBarcode' ,PartBarcode);
  AddXMLNode(node,'Notes', Notes);
  inherited;
end;

function TSAELines.ValidateData: Boolean ;
var
  UOMObj: TUnitOfMeasure;
begin
  result := inherited;
  if not result then exit;
  Result := False;
  if ProductId =0 then begin
    if productname<> '' then AddResult(False, rssWarning, 0 , 'Product not found : ' +Productname)
    else AddResult(False, rssWarning, 0 , 'Product should not be blank');
    Exit;
  end;
  if DeptID = 0 then begin
    if Deptname<> '' then AddResult(False, rssWarning, 0 , Appenv.DefaultClass.ClassHeading +' not found : ' +Deptname)
    else AddResult(False, rssWarning, 0 , Appenv.DefaultClass.ClassHeading +' should not be blank');
    Exit;
  end;
  if self.UnitOfMeasureID < 1 then begin
    { no UOM }
    if UnitOfMeasure = '' then begin
      if self.UOMID = -1 then begin
        AddResult(False, rssWarning, 0 , 'Unit of Measure not found for ' + self.ProductName);
        exit;
      end
      else begin
        AddResult(False, rssWarning, 0 , 'Unit of Measure is missing for ' + self.ProductName);
        exit;
      end;
    end;
    { UOM ID missing }
    { check for inactive }
    UOMObj := TUnitOfMeasure.Create(nil);
    try
      UOMObj.Connection := TMyDacDataConnection.Create(UOMObj);
      UOMObj.Connection.Connection := self.Connection.Connection;
      UOMObj.LoadSelect('UnitProductKeyName = "' + UnitOfMeasure + ':' + ProductName + '"');
      if UOMObj.Count = 0 then begin
        AddResult(False, rssWarning, 0 , 'Unit of Measure not found for Unit ' + UnitOfMeasure + ' and Product ' + self.ProductName);
        exit;
      end;
      if UOMObj.Count = 1 then begin
        if not UOMObj.Active then begin
          AddResult(False, rssWarning, 0 , 'Unit of Measure is Inactive for Unit ' + UnitOfMeasure + ' and Product ' + self.ProductName);
          exit;
        end
        else begin
          UnitOfMeasureID := UOMObj.ID;
          PostDb;
        end;
      end;
      if UOMObj.Count > 1 then begin
        AddResult(False, rssWarning, 0 , 'Multiple Units of Measure found for Unit ' + UnitOfMeasure + ' and Product ' + self.ProductName);
        exit;
      end;
    finally
      UOMObj.Free;
    end;
  end
  else if Trim(AccountName) = '' then begin
    AddResult(false, rssWarning, 0, 'Account Name missing from line (' + ProductName + ')');
    exit;
  end
  else if AccountID = 0 then begin
    AddResult(false, rssWarning, 0, 'Account ID missing from line (' + ProductName + ')');
    exit;
  end;
  Result := True;
end;


class function TSAELines._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TAccount','AccountObj','AccountID','ID');
  TBOSchema.AddRefType(result,'TAccount','AccountObj','AccountName','AccountName');
  TBOSchema.AddRefType(result,'TDeptClass','DeptClassObj','DeptID','ID');
  TBOSchema.AddRefType(result,'TDeptClass','DeptClassObj','DeptName','DeptClassName');
end;

function TSAELines.Save: Boolean ;
var
  qry: TERPQuery;
begin
    if RawMode then begin
      { this is probably coming from the tablet .. which dos not have accurate
        in stock quantities so we need to do calcs here.
        Assume tablet is sending final quantities as opposed to adjustments }

      CheckProduct;
      { first get in stock qty }
      CalcAvailableQty(true);

      if AccountID = 0 then begin
        { default to Header .. }
        if TStockAdjustEntry(Owner).AccountID > 0 then begin
          AccountID := TStockAdjustEntry(Owner).AccountID;
          AccountName := TStockAdjustEntry(Owner).AccountNAme;
        end;
      end;

      if (UOMID = 0) and (UOM <> '') and (ProductName <> '') then begin
        qry := DbSharedObj.GetQuery(Connection.Connection);
        try
          qry.SQL.Add('select * from tblUnitsOfMeasure');
          qry.SQL.Add('where UnitName = ' + QuotedStr(UOM));
          qry.SQL.Add('and (PartID = ' + IntToStr(self.ProductID) + ' or IfNull(PartID,0) = 0)');
          qry.SQL.Add('and Active = "T"');
          qry.SQL.Add('order by PartID DESC');
          qry.Open;
          if not qry.IsEmpty then begin
            self.UOMID := qry.FieldByName('UnitID').AsInteger;
            self.UOMMultiplier := qry.FieldByName('Multiplier').AsFloat;
          end;
        finally
          DbSharedObj.ReleaseObj(qry);
        end;
      end;

      FinalUOMQty := FinalQty / UOMMultiplier;
      FinalQty := FinalUOMQty * UOMMultiplier;

      CalcAdjustQty;
    end;
    PostDB;

    Result := False;
    if not ValidateData then Exit;
    Result := inherited Save;
end;


procedure TSAELines.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  Sendevent(BusObjEvent_Dataset, BusObjEvent_IDChanged , Self);
//  if not isProcessed then CheckProduct;
end;

function TSAELines.ProductChanged: Boolean;
begin
  REsult := not(Sysutils.SameText(ProductDetails , cleanProductDetails));
end;

function TSAELines.ProductDetails: String;
var
  xnode :IXMLNode;
begin
  With TXMLDocument.Create(nil) do try
    active := true;
    xnode:= AddChild('Record');
    AddXMLNode(xnode,IDFieldName, ID);
    AddXMLNode(xnode,'ProductID', ProductID);
    AddXMLNode(xnode,'DeptID',DeptID);
    AddXMLNode(xnode,'UOM' ,UOM);
    AddXMLNode(xnode,'AdjustmentDate' ,AdjustmentDate);
    result := XML.text;
  finally
//      Free;
  end;
end;
Procedure TSAELines.DoOnProductchange;
begin
      Description := Product.SalesDescription;
      ProductType := Product.ProductType;
      Cost := Product.AverageCost;
      if cost = 0 then Cost := Product.BuyQty1Cost;
      if not RawMode then begin
        Sendevent(BusObjEvent_Change, BusobjEventVal_StockAdjustproduct , Self);
        InitUOM(Product.UOMSales , '');
        CheckProduct;
      end;
end;
procedure TSAELinesFlat.OnProductchange;
begin
  calcAvailableQty;
  CalcAdjustQty;
end;

Procedure TSAELines.Calcfinalqty;
begin
  if AdjustonInStock=false then begin
    FinalQty        := AvailableQty + AdjustQty;
    FinalUOMQty     := AvailableUOMQty + AdjustUOMQty;
  end
  else begin
    FinalQty        := InStockQty + AdjustQty;
    FinalUOMQty     := InStockUOMQty + AdjustUOMQty;
  end;
end;
procedure TSAELines.DoFieldOnChange(Sender: TField);
var
  x: String;


  Procedure CalcUOMQty;
  begin
    AdjustUOMQty    := AdjustQty/UOMMultiplier;
    FinalUOMQty     := FinalQty/UOMMultiplier;
    AvailableUOMQty := AvailableQty/UOMMultiplier;
    InstockUOMQty  := InstockQty/UOMMultiplier;
  end;

begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    if processed then exit;
  inherited;
    if Sysutils.SameText(Sender.FieldName , 'DEleted') then begin
    end else if Sysutils.SameText(Sender.FieldName , 'FormulaQtyValue') or
      Sysutils.SameText(Sender.FieldName , 'FormulaQtyValue1') or
      Sysutils.SameText(Sender.FieldName , 'FormulaQtyValue2') or
      Sysutils.SameText(Sender.FieldName , 'FormulaQtyValue3') or
      Sysutils.SameText(Sender.FieldName , 'FormulaQtyValue4') or
      Sysutils.SameText(Sender.FieldName , 'FormulaQtyValue5')  then begin
      if not rawmode then CalcQtyFromformula;
    end else if SameText(Sender.FieldName , 'ProductID') then begin
      if Productname <> Product.Productname then
        ProductName     := Product.ProductName;
      if Productname <> '' then
        DoOnProductchange;

    end else if SameText(Sender.fieldName , 'ProductName' ) then begin
      self.ProductID := tcdatautils.GetProduct(ProductName);// TProduct.IDToggle(ProductName, Connection.Connection);
      if self.ProductID <> 0 then
        DoOnProductchange;
        (*if not RawMode then begin
          PostDB;
          DoFieldOnChange(dataset.Findfield('ProductID'));
        end;*)
    end else if SameText(Sender.fieldname , 'classid') then begin
        DeptName        :=  GetClassName(deptID);// TDeptClass.IDToggle(DeptID , Self.Connection.connection );
        CheckProduct;
    end else if SameText(Sender.fieldname , 'ClassName') then begin
        DeptID        := tcdatautils.GetDeptID(DeptName);;// TDeptClass.IDToggle(DeptName , Self.Connection.connection );
//        Vars.Values.ByName['Department_Done'].AsBoolean := true;
        CheckProduct;
      if not RawMode then begin
        DoFieldOnChange(Dataset.findfield('ClassId'));
      end;
    end else if SameText(Sender.fieldname , 'AccountID') then begin
        AccountName        := tcdatautils.getAccountNAme(AccountID);
    end else if Sysutils.SameText(sender.fieldname , 'AccountName') then begin
      AccountID := tcDatautils.getAccountID(AccountName);
    end else if SameText(Sender.Fieldname , 'FinalUOMQty') then begin
      if not RawMode then begin
        FinalQty        := FinalUOMQty*UOMMultiplier;
        calcAdjustQty
      end;
    end else if SameText(Sender.Fieldname , 'FinalQty') then begin
      if not RawMode then begin
        FinalUOMQty     := FinalQty/UOMMultiplier;
        calcAdjustQty
      end;
    end else if SameText(Sender.Fieldname , 'AdjustQty') then begin
      if not RawMode then begin
        AdjustUOMQty    := AdjustQty/UOMMultiplier;
        CalcFinalQty;
      end;
    end else if SameText(Sender.Fieldname , 'AdjustUOMQty') then begin
      if not RawMode then begin
        AdjustQty       := AdjustUOMQty*UOMMultiplier;
        Calcfinalqty;
        if CreatingTreeModeData then else
        AddEvent(BusObjEvent_Change, BusObjEventVal_QtyShipped, Self.ID);
      end;
    end else if SameText(Sender.fieldName , 'UOM') then begin
      InitUOM(Sender);
    end else if SameText(Sender.fieldname , 'UOMID') then begin
      if not RawMode then begin
        UOMMultiplier := tcDataUtils.getUnitMultiplier(UOMID);
        CalcUOMQty;
        CheckProduct;
      end;
    end else if Sysutils.SameText(Sender.FieldName , 'PartBarcode') then begin
      if partbarcode <> '' then begin
        if not RawMode then begin
          x := tcdatautils.GetProductForbarCode(PartBarcode);
          if sametext(x,'InactiveProduct') then
            partbarcode := ''
          else if (sametext(x,'Inactivebarcode')) or (x='') then begin
              SendEvent(BusobjEvent_ToDo, BusObjEvent_PartBarcodeNotfound, self);
              if productname <> '' then
                DoFieldOnChange(Dataset.findfield('ProductName'));
          end else begin
            ProductName := x;
            DoFieldOnChange(Dataset.findfield('ProductName'));
          end;
        end;
      end;
    end ;
    if (SameText(Sender.FieldName , 'ProductID')) then begin

      if not RawMode then begin
        Sendevent(BusObjEvent_Change, BusObjEventVal_ProductChanged , Self);
      end;
    end;
    if (SameText(Sender.FieldName , 'ProductID')) or
        (SameText(Sender.FieldName , 'ProductName')) or
        (SameText(Sender.FieldName , 'UOM')) or
        (SameText(Sender.FieldName , 'ClassId')) then begin
      if not RawMode then begin
        calcAvailableQty;
        AdjustQty := 0;
        AdjustUOMQty := 0;
        CalcFinalQty;
        Sendevent(BusObjEvent_Change, BusobjEventVal_StockAdjustproduct , Self);
      end;
    end;

    (*
    if RawMode then begin
      { good chance that data is coming to from a device that does not any
        in stock data .. so we check set this here }
      if AccountID = 0 then begin
        { default to Header .. }
        if TStockAdjustEntry(Owner).AccountID > 0 then begin
          AccountID := TStockAdjustEntry(Owner).AccountID;
          AccountName := TStockAdjustEntry(Owner).AccountNAme;
        end;
      end;

      if (SameText(Sender.FieldName , 'ProductName')) or
       (SameText(Sender.FieldName , 'UOM')) or
       (SameText(Sender.FieldName , 'ClassName')) then begin
        CheckProduct;
        if (not Vars.Values.ByName['CalcAvailableQty_Done'].AsBoolean) and
          (ProductName <> '') and (UOM <> '') and (ClassName <> '') then begin
          CalcAvailableQty;
          Vars.Values.ByName['CalcAvailableQty_Done'].AsBoolean := true;
        end;
      end;

      if (UOMID = 0) and (UOM <> '') and (ProductName <> '') then begin
        qry := DbSharedObj.GetQuery(Connection.Connection);
        try
          qry.SQL.Add('select * from tblUnitsOfMeasure');
          qry.SQL.Add('where UnitName = ' + QuotedStr(UOM));
          qry.SQL.Add('and (PartID = ' + IntToStr(self.ProductID) + ' or IfNull(PartID,0) = 0)');
          qry.SQL.Add('and Active = "T"');
          qry.SQL.Add('order by PartID DESC');
          qry.Open;
          if not qry.IsEmpty then begin
            self.UOMID := qry.FieldByName('UnitID').AsInteger;
            self.UOMMultiplier := qry.FieldByName('Multiplier').AsFloat;
          end;
        finally
          DbSharedObj.ReleaseObj(qry);
        end;
        Vars.Values.ByName['UOMMultiplier_Done'].AsBoolean := true;
      end;

      if SameText(Sender.FieldName, 'FinalQty') and Vars.Values.ByName['UOMMultiplier_Done'].AsBoolean then begin
        FinalUOMQty := FinalQty / UOMMultiplier;
        Vars.Values.ByName['FinalQty_Done'].AsBoolean := true;
      end;
      if SameText(Sender.FieldName, 'FinalUOMQty') and Vars.Values.ByName['UOMMultiplier_Done'].AsBoolean then begin
        FinalQty := FinalUOMQty * UOMMultiplier;
        Vars.Values.ByName['FinalQty_Done'].AsBoolean := true;
      end;

      if not Vars.Values.ByName['Adjustment_Done'].AsBoolean then begin
        if Vars.Values.ByName['CalcAvailableQty_Done'].AsBoolean and
           Vars.Values.ByName['UOMMultiplier_Done'].AsBoolean and
           Vars.Values.ByName['FinalQty_Done'].AsBoolean and
           Vars.Values.ByName['Department_Done'].AsBoolean then begin

          CalcAdjustQty;

          Vars.Values.ByName['Adjustment_Done'].AsBoolean := true;
        end;
      end;

    end;
    *)
end;

Procedure TSAELines.InitUOM(const UOMName, UOMNameOldValue:String);
begin
  inherited;
  if productID<> 0 then begin
    PostDB;
    SendEvent(BusObjEvent_Change, BusObjEventVal_uomChanged, self);
    DoFieldOnChange(Dataset.findfield('UOMID'));
  end;
end;

function TSAELines.isProcessed: boolean;
begin
  result := False;
  if Assigned(Owner) then
    if owner is TStockAdjustEntry then
      result := TStockAdjustEntry(Owner).Processed;
end;

function TSAELines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TSAELines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


function  TSAELines.GetUOMMultiplier            : Double    ; begin
    Result := GetFloatField('UOMMultiplier');
    if result = 0 then result := 1;
end;
function  TSAELines.GetStockAdjustEntryID       : Integer   ; begin Result := GetIntegerField('StockAdjustEntryID');end;
function  TSAELines.GetProductID                : Integer   ; begin Result := GetIntegerField('ProductID');end;
function  TSAELines.GetProductName              : string    ; begin Result := GetStringField('ProductName');end;
function  TSAELines.GetDescription              : string    ; begin Result := GetStringField('Description');end;
function  TSAELines.GetDeptID                   : Integer   ; begin Result := GetIntegerField('ClassID');end;
function  TSAELines.GetDeptName                 : string    ; begin Result := GetStringField('ClassName');end;
function  TSAELines.GetJobID                    : Integer   ; begin Result := GetIntegerField('JobID');end;
function  TSAELines.GetJobName                  : string    ; begin Result := GetStringField('JobName');end;
function  TSAELines.GetAccountID                : Integer   ; begin Result := GetIntegerField('AccountID');end;
function  TSAELines.GetAccountName              : string    ; begin Result := GetStringField('AccountName');end;
function  TSAELines.GetAvailableQty             : Double    ; begin Result := GetFloatField('AvailableQty');end;
function  TSAELines.GetInStockQty               : Double    ; begin Result := GetFloatField('InStockQty');end;
function  TSAELines.GetFinalQty                 : Double    ; begin Result := GetFloatField('FinalQty');end;
function  TSAELines.GetAdjustQty                : Double    ; begin Result := GetFloatField('AdjustQty');end;
function  TSAELines.GetAvailableUOMQty          : Double    ; begin Result := GetFloatField('AvailableUOMQty');end;
function  TSAELines.GetFinalUOMQty              : Double    ; begin Result := GetFloatField('FinalUOMQty');end;
function  TSAELines.GetAdjustUOMQty             : Double    ; begin Result := GetFloatField('AdjustUOMQty');end;
function  TSAELines.GetCost                     : Double    ; begin Result := GetFloatField('Cost');end;
function  TSAELines.GetUOM                      : string    ; begin Result := GetStringField('UOM');end;
function  TSAELines.GetDeleted                  : Boolean   ; begin Result := GetBooleanField('Deleted');end;
function  TSAELines.GetUOMID                    : Integer   ; begin Result := GetIntegerField('UOMID');end;
function  TSAELines.GetInStockUOMQty            : Double    ; begin Result := GetFloatField('InStockUOMQty');end;
procedure TSAELines.SetStockAdjustEntryID       (const Value: Integer   ); begin SetIntegerField('StockAdjustEntryID'        , Value);end;
procedure TSAELines.SetProductID                (const Value: Integer   ); begin SetIntegerField('ProductID'                 , Value);end;
procedure TSAELines.SetProductName              (const Value: string    ); begin SetStringField('ProductName'               , Value);end;
procedure TSAELines.SetDescription              (const Value: string    ); begin SetStringField('Description'               , Value);end;
procedure TSAELines.SetDeptID                   (const Value: Integer   ); begin SetIntegerField('ClassID'                   , Value);end;
procedure TSAELines.SetDeptName                 (const Value: string    ); begin SetStringField('ClassName'                 , Value);end;
procedure TSAELines.SetJobID                    (const Value: Integer   ); begin SetIntegerField('JobID'                    , Value);end;
procedure TSAELines.SetJobName                  (const Value: string    ); begin SetStringField('JobName'                   , Value);end;
procedure TSAELines.SetAccountID                (const Value: Integer   ); begin SetIntegerField('AccountID'                   , Value);end;
procedure TSAELines.SetAccountName              (const Value: string    ); begin SetStringField('AccountName'                 , Value);end;
procedure TSAELines.SetAvailableQty             (const Value: Double    ); begin SetFloatField('AvailableQty'              , Value);end;
procedure TSAELines.SetInStockQty               (const Value: Double    ); begin SetFloatField('InStockQty'              , Value);end;
procedure TSAELines.SetInStockUOMQty            (const Value: Double    ); begin SetFloatField('InStockUOMQty'              , Value);end;
procedure TSAELines.SetFinalQty                 (const Value: Double    ); begin SetFloatField('FinalQty'                  , Value);end;
procedure TSAELines.SetAdjustQty                (const Value: Double    ); begin SetFloatField('AdjustQty'                , Value);end;
procedure TSAELines.SetAvailableUOMQty          (const Value: Double    ); begin SetFloatField('AvailableUOMQty'           , Value);end;
procedure TSAELines.SetFinalUOMQty              (const Value: Double    ); begin SetFloatField('FinalUOMQty'               , Value);end;
procedure TSAELines.SetAdjustUOMQty             (const Value: Double    ); begin SetFloatField('AdjustUOMQty'              , Value);end;
procedure TSAELines.SetCost                     (const Value: Double    ); begin SetFloatField('Cost'                      , Value);end;
procedure TSAELines.SetUOM                      (const Value: string    ); begin SetStringField('UOM'                       , Value);end;
procedure TSAELines.SetUOMMultiplier            (const Value: Double    ); begin SetFloatField('UOMMultiplier'             , Value);end;
procedure TSAELines.SetUOMNameProductKey(const Value: string);
begin
  inherited;
  { if the UOM was not found set UOMId to -1 so validate can let user know that it was not found }
  if (Value <> '') and (self.UnitOfMeasureID = 0) then begin
    self.UnitOfMeasureID := -1;
    self.UnitOfMeasure := '';
  end;
end;

procedure TSAELines.SetDeleted                  (const Value: Boolean   ); begin
  SetBooleanField('Deleted', Value);
end;

procedure TSAELines.SetUOMID                    (const Value: Integer   ); begin SetIntegerField('UOMID'                     , Value);end;
 {Property functions}

function  TSAELinesFlat.GetBatchNo                  : string    ; begin Result := GetStringField('BatchNo');end;
function  TSAELinesFlat.GetExpirydate               : TDateTime ; begin Result := GetDateTimeField('Expirydate');end;
function  TSAELinesFlat.GetBinLocation              : string    ; begin Result := GetStringField('BinLocation');end;
function  TSAELinesFlat.GetBinNumber                : string    ; begin Result := GetStringField('BinNumber');end;
function  TSAELinesFlat.GetSerialNumber             : string    ; begin Result := GetStringField('SerialNumber');end;
function  TSAELinesFlat.GetAllocationAvailableQty   : Double    ; begin Result := GetFloatField('AllocationAvailableQty');end;
function  TSAELinesFlat.GetAllocationInStockQty     : Double    ; begin Result := GetFloatField('AllocationInStockQty');end;
function  TSAELinesFlat.GetAllocationInStockUOMQty       : Double    ; begin Result := GetFloatField('AllocationInStockUOMQty');end;
function  TSAELinesFlat.GetAllocationFinalqty       : Double    ; begin Result := GetFloatField('AllocationFinalqty');end;
function  TSAELinesFlat.GetAllocationAdjustQty      : Double    ; begin Result := GetFloatField('AllocationAdjustQty');end;
function  TSAELinesFlat.GetAllocationAvailableUOMQty: Double    ; begin Result := GetFloatField('AllocationAvailableUOMQty');end;
function  TSAELinesFlat.GetAllocationFinalUOMQty    : Double    ; begin Result := GetFloatField('AllocationFinalUOMQty');end;
function  TSAELinesFlat.GetAllocationAdjustUOMQty   : Double    ; begin Result := GetFloatField('AllocationAdjustUOMQty');end;
function  TSAELinesFlat.getBinID                    : Integer   ; begin Result := GetIntegerField('binId');end;
{override the readonly as the readonly is set for GUI}
procedure TSAELinesFlat.SetBatchNo                  (const Value: string    ); begin EditnSetStringField('BatchNo'                   , Value);end;
procedure TSAELinesFlat.SetExpirydate               (const Value: TDateTime ); begin EditnSetDateTimeField('Expirydate'                , Value);end;
procedure TSAELinesFlat.SetBinLocation              (const Value: string    ); begin EditnSetStringField('BinLocation'               , Value);end;
procedure TSAELinesFlat.SetBinNumber                (const Value: string    ); begin EditnSetStringField('BinNumber'                 , Value);end;
procedure TSAELinesFlat.SetSerialNumber             (const Value: string    ); begin EditnSetStringField('SerialNumber'              , Value);end;
procedure TSAELinesFlat.SetAllocationAvailableQty   (const Value: Double    ); begin EditnSetFloatField('AllocationAvailableQty'    , Value);end;
procedure TSAELinesFlat.SetAllocationInStockQty     (const Value: Double    ); begin EditnSetFloatField('AllocationInStockQty'    , Value);end;
procedure TSAELinesFlat.SetAllocationInStockUOMQty       (const Value: Double    ); begin EditnSetFloatField('AllocationInStockUOMQty'    , Value);end;
procedure TSAELinesFlat.SetAllocationFinalqty       (const Value: Double    ); begin EditnSetFloatField('AllocationFinalqty'        , Value);end;
procedure TSAELinesFlat.SetAllocationAdjustQty      (const Value: Double    ); begin EditnSetFloatField('AllocationAdjustQty'       , Value);end;
procedure TSAELinesFlat.SetAllocationAvailableUOMQty(const Value: Double    ); begin EditnSetFloatField('AllocationAvailableUOMQty' , Value);end;
procedure TSAELinesFlat.SetAllocationFinalUOMQty    (const Value: Double    ); begin EditnSetFloatField('AllocationFinalUOMQty'     , Value);end;
procedure TSAELinesFlat.SetAllocationAdjustUOMQty   (const Value: Double    );begin  EditnSetFloatField('AllocationAdjustUOMQty'    , Value);end;
procedure TSAELinesFlat.SetBinID                    (const Value: Integer   ); begin EditnSetIntegerfield('binId' , Value);end;


procedure TSAELinesFlat.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'BatchNo');
  SetDatetimePropertyFromNode(node,'Expirydate');
  SetPropertyFromNode(node,'BinLocation');
  SetPropertyFromNode(node,'BinNumber');
  SetPropertyFromNode(node,'SerialNumber');
  SetPropertyFromNode(node,'AllocationAvailableQty');
  SetPropertyFromNode(node,'AllocationInStockQty');
  SetPropertyFromNode(node,'AllocationInStockUOMQty');
  SetPropertyFromNode(node,'AllocationFinalqty');
  SetPropertyFromNode(node,'AllocationAdjustQty');
  SetPropertyFromNode(node,'AllocationAvailableUOMQty');
  SetPropertyFromNode(node,'AllocationFinalUOMQty');
  SetPropertyFromNode(node,'AllocationAdjustUOMQty');
end;
procedure TSAELinesFlat.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'BatchNo' ,BatchNo);
  AddXMLNode(node,'Expirydate' ,Expirydate);
  AddXMLNode(node,'BinLocation' ,BinLocation);
  AddXMLNode(node,'BinNumber' ,BinNumber);
  AddXMLNode(node,'SerialNumber' ,SerialNumber);
  AddXMLNode(node,'AllocationAvailableQty' ,AllocationAvailableQty);
  AddXMLNode(node,'AllocationInStockQty' ,AllocationInStockQty);
  AddXMLNode(node,'AllocationInStockUOMQty' ,AllocationInStockUOMQty);
  AddXMLNode(node,'AllocationFinalqty' ,AllocationFinalqty);
  AddXMLNode(node,'AllocationAdjustQty' ,AllocationAdjustQty);
  AddXMLNode(node,'AllocationAvailableUOMQty' ,AllocationAvailableUOMQty);
  AddXMLNode(node,'AllocationFinalUOMQty' ,AllocationFinalUOMQty);
  AddXMLNode(node,'AllocationAdjustUOMQty' ,AllocationAdjustUOMQty);
end;
function TSAELinesFlat.getXMLTocopyLine: String;
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

    AddXMLNode(xnode,'ProductID' ,ProductID);
    AddXMLNode(xnode,'ProductName' ,ProductName);
    AddXMLNode(xnode,'Description' ,Description);
    AddXMLNode(xnode,'DeptID' ,DeptID);
    AddXMLNode(xnode,'DeptName' ,DeptName);
    AddXMLNode(xnode,'AccountID' ,AccountID);
    AddXMLNode(xnode,'AccountName' ,AccountName);
    AddXMLNode(xnode,'Cost' ,Cost);
    AddXMLNode(xnode,'UnitOfMeasure' ,UnitOfMeasure);
    AddXMLNode(xnode,'UOMMultiplier' ,UOMMultiplier);
    AddXMLNode(xnode,'UnitOfMeasureID' ,UnitOfMeasureID);
    AddXMLNode(xnode,'BatchNo' ,BatchNo);
    AddXMLNode(xnode,'Expirydate' ,Expirydate);
    AddXMLNode(xnode,'BinLocation' ,BinLocation);
    AddXMLNode(xnode,'BinNumber' ,BinNumber);
    result := xXMLDoc.XML.Text;
  finally
    freeandNil(xXMLDoc);
  end;
end;
function TSAELinesFlat.ImportingStockAdjustment: boolean;
begin
  result := False;
  if assigned(Owner) then
    if owner is TStockAdjustEntry then
      result := TStockAdjustEntry(Owner).ImportingStockAdjustment;
end;

constructor TSAELinesFlat.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription:= 'StockAdjustLines';
  fSQL := 'SELECT * FROM tblstockadjustentrylines';
  fCreateBin := nil;
  fIsList := true;
  ExportExcludeList.Add('pqa');
end;

destructor TSAELinesFlat.Destroy;
begin
  logtext(Classname+':destroyed');
  inherited;
end;

function TSAELinesFlat.DoAfterPost(
  Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited    DoAfterPost(Sender);
  if not result then exit;
end;
Procedure TSAELinesFlat.Calcallocfinalqty;
begin
  if AdjustonInStock then begin
    AllocationFinalqty        := AllocationInStockQty + AllocationAdjustQty;
    AllocationFinalUOMqty     := AllocationInStockUOMQty + AllocationAdjustUOMQty;
  end else begin
    AllocationFinalqty        := AllocationAvailableQty + AllocationAdjustQty;
    AllocationFinalUOMqty     := AllocationAvailableUOMQty + AllocationAdjustUOMQty;
  end;
end;
Procedure TSAELinesFlat.CalcallocAdjustQty;
begin
  if AdjustonInStock then begin
    AllocationAdjustQty       :=  AllocationFinalQty-AllocationInStockQty;
    AllocationAdjustUOMQty    :=  AllocationFinalUOMQty-AllocationInStockUOMQty;
  end else begin
    AllocationAdjustQty       :=  AllocationFinalQty-AllocationAvailableQty;
    AllocationAdjustUOMQty    :=  AllocationFinalUOMQty-AllocationAvailableUOMQty;
  end;
end;
Procedure TSAELinesFlat.Onallocationchange;
begin
        calcAllocAvailableQty;
        CalcallocAdjustQty;
        Sendevent(BusObjEvent_Change, BusobjEventVal_StockAdjustproduct , Self);
        PostDB;
        //CheckProduct;
end;
procedure TSAELinesFlat.DoFieldOnChange(Sender: TField);

    Function isfieldChangeInValid :boolean; begin
      REsult := true;
      if (SameText(Sender.fieldName, 'binlocation')) or (SameText(Sender.fieldName, 'binnumber')) then
        if product.Multiplebins = False then begin
          binlocation := '';
          binnumber := '';
          Exit;
        end;
      if (SameText(Sender.fieldName, 'Batchno')) or (SameText(Sender.fieldName, 'ExpiryDate')) then
        if Product.Batch = False then begin
            Batchno := '';
            ExpiryDate := 0;
            Exit;
        end;
      if SameText(Sender.Fieldname , 'Serialnumber') then
          if Product.SnTracking = False then begin
              Serialnumber := '';
              Exit;
          end;
      Result := false;
    end;
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    if processed then exit;
    inherited;
    if IsfieldChangeinValid then Exit;

    if (SameText(Sender.fieldName, 'binlocation')) or (SameText(Sender.fieldName, 'binnumber')) then begin
        binId := ProductBinIDToggle(ClassID, binlocation, binnumber);
        if (binId<> 0) and  Product.BAtch and (Batchno = '') then
            Resultstatus.AddItem(False , rssWarning, 0 , 'Please Choose A Batch' );

    end;
    if SameText(Sender.Fieldname , 'AllocationFinalUOMQty') then begin
      (*if not RawMode then begin*)if not ImportingStockAdjustment then begin
        AllocationFinalQty        := AllocationFinalUOMQty*UOMMultiplier;
        CalcallocAdjustQty;
      end;
    end else if SameText(Sender.Fieldname , 'AllocationFinalQty') then begin
      (*if not RawMode then begin*)if not ImportingStockAdjustment then begin
        AllocationFinalUOMQty     := AllocationFinalQty/UOMMultiplier;
        CalcallocAdjustQty;
      end;
    end else if SameText(Sender.Fieldname , 'AllocationAdjustQty') then begin
      if not RawMode then begin
        AllocationAdjustUOMQty    := AllocationAdjustQty/UOMMultiplier;
        Calcallocfinalqty;
      end;
    end else if SameText(Sender.Fieldname , 'AllocationAdjustUOMQty') then begin
      if not RawMode then begin
        AllocationAdjustQty       := AllocationAdjustUOMQty*UOMMultiplier;
        Calcallocfinalqty;
      end;
    end else if SameText(Sender.fieldname , 'Serialnumber') then begin
        if (Serialnumber<> '') and  Product.multiplebins and (Binlocation = '') and (BinNumber = '') then
            Resultstatus.AddItem(False , rssWarning, 0 , 'Please Choose A Bin' )
        else if (Serialnumber<> '') and  Product.BAtch and (Batchno = '') then
            Resultstatus.AddItem(False , rssWarning, 0 , 'Please Choose A Batch' );

    end;
    if (SameText(Sender.FieldName , 'binlocation')) or
        (SameText(Sender.FieldName , 'Binnumber')) then begin
      (*if not RawMode then begin*)if not ImportingStockAdjustment then begin
        if (binId = 0) and (binlocation <>'') and (binnumber<>'') then if Assigned(Createbin) then begin
            Createbin(DeptID, BinLocation, BinNumber);
            binId := ProductBinIDToggle(ClassID, binlocation, binnumber);
        end;
      end;
    end else if (SameText(Sender.FieldName , 'binId')) then begin
        binlocation :=ProductBinIDToggle(binID,true);
        binnumber   :=ProductBinIDToggle(binID,False);
    end;
    if (SameText(Sender.FieldName , 'ProductID')) or
        (SameText(Sender.FieldName , 'UOMID')) or
        (SameText(Sender.FieldName , 'ClassId')) then begin
      if not RawMode then begin
        clearalloc;
      end;
    end;
    if (SameText(Sender.FieldName , 'binlocation')) or
        (SameText(Sender.FieldName , 'Binnumber')) or
        (SameText(Sender.FieldName , 'BinId')) or
        (SameText(Sender.fieldname , 'Serialnumber')) or
        (SameText(Sender.FieldName , 'Batchno')) or
        (SameText(Sender.FieldName , 'ExpiryDate')) then begin
      //if not RawMode then begin
      if not ImportingStockAdjustment then begin
        onallocationchange;
      end;
    end;
 (*   if (SameText(Sender.FieldName , 'binlocation')) or
        (SameText(Sender.FieldName , 'Binnumber')) or
        (SameText(Sender.FieldName , 'BinId')) or
        (SameText(Sender.FieldName , 'Batchno')) or
        (SameText(Sender.FieldName , 'Serialnumber')) or
        (SameText(Sender.FieldName , 'ExpiryDate')) then
      if not RawMode then begin
        CheckProduct;
      end;*)
end;

class function TSAELinesFlat.GetBusObjectTablename: string;
begin
  Result := 'tblstockadjustentrylines'
end;


procedure TSAELinesFlat.OnDataIdChange(
  const ChangeType: TBusObjDataChangeType);
begin
  inherited;
    StoreValues;
end;


function TSAELinesFlat.Save: Boolean;
begin
    PostDB;
    Result := inherited Save;
    if result then
      Checkproduct(True);
end;

function TSAELinesFlat.ValidateAllocationAttribs: Boolean;
begin
  result:= True;
          if (BatchNo <> '') or (binlocation <>'') or (serialnumber <> '') or (binnumber<> '') or (expirydate <>0) then
              if ((Product.Batch) and (BatchNo= '')) or
                ((Product.MultipleBins) and (binlocation= '')) or
                ((Product.SnTracking) and (Serialnumber= '' )) then begin
                  AddResult(False, rssWarning, 0 , 'Incomplete Batch-bin-Serialised allocation adjustments - '+NL + quotedstr(ProductName) +' has the following Allocations' + NL +
                          iif(Product.Batch, 'Batch enabled, '+NL , '') +
                          iif(Product.MultipleBins, 'Bin enabled, ' +NL, '') +
                          iif(Product.SnTracking, 'SN tracking Enabled'+NL , '') +'.' +
                          'Batch :' + BatchNo + iif(expirydate >0 , ', ' +FormatDateTime(FormatSettings.ShortDateFormat , expirydate) , '') + NL+
                          'Bin :' + Binlocation + iif(Binnumber<> '' , ', ' +Binnumber , '') + NL+
                          'SN :' + Serialnumber , False);
                  Result:= false;
                end;


end;

function TSAELinesFlat.ValidateData: Boolean;
begin
  Result := inherited ValidateData;
  if not result then exit;
end;

procedure TSAELinesFlat.CalcAdjustQty;
begin
  inherited;
end;

procedure TSAELinesFlat.calcAllocAvailableQty;
var
    StrSQL:String;
    Qry :TERPQuery;
begin
    AllocationAvailableQty    := 0;
    AllocationAvailableUOMQty := 0;
    if EnforceUOM then
          strSQL := ProductQtyLib.SQL4ProductAvailableQty(AdjustmentDate ,  UOM,  iif(SerialNumber<>'' , tDetailswithSno , tExtraDetails),ProductId,DeptId,Batchno,expirydate,BinLocation,binnumber,SerialNumber , tAvailable , '' , '' , 0 , False , False , False)
    else  strSQL := ProductQtyLib.SQL4ProductAvailableQty(AdjustmentDate ,   '',  iif(SerialNumber<>'' , tDetailswithSno , tExtraDetails),ProductId,DeptId,Batchno,expirydate,BinLocation,binnumber,SerialNumber, tAvailable , '' , '' , 0 , False , False , False);
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection, strSQL);
    try
      with Qry(*getNewDataset(strSQL)*) do begin
          AllocationAvailableQty    := Round(FieldByname('Qty').asFloat , tcConst.GeneralRoundPlaces);
          if EnforceUOm then
               AllocationAvailableUOMQty := Round(FieldByname('UOMQty').asFloat,tcConst.GeneralRoundPlaces)
          else AllocationAvailableUOMQty := Round(FieldByname('Qty').asFloat/UOMMultiplier , tcConst.GeneralRoundPlaces) ;
      end;
    finally
        DbSharedObj.ReleaseObj(qry);
    end;
    if enforceUOM then
         strSQL := ProductQtyLib.SQL4ProductAvailableQty(AdjustmentDate ,  UOM,  iif(SerialNumber<>'' , tDetailswithSno , tExtraDetails),ProductId,DeptId,Batchno,expirydate,BinLocation,binnumber,SerialNumber, tinStock, '' , '' , 0 , False , False , False)
    else strSQL := ProductQtyLib.SQL4ProductAvailableQty(AdjustmentDate ,  '',  iif(SerialNumber<>'' , tDetailswithSno , tExtraDetails),ProductId,DeptId,Batchno,expirydate,BinLocation,binnumber,SerialNumber, tinStock, '' , '' , 0 , False , False , False);

    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection, strSQL);
    try
      with Qry(*getNewDataset(strSQL) *)do begin
        AllocationInStockQty    := Round(FieldByname('Qty').asFloat/UOMMultiplier , tcConst.GeneralRoundPlaces) ;
        if EnforceUOM then
              AllocationInStockUOMQty    := FieldByname('UOMQty').asFloat
        else  AllocationInStockUOMQty    := Round(FieldByname('Qty').asFloat/UOMMultiplier , tcConst.GeneralRoundPlaces) ;
      end;
    finally
        DbSharedObj.ReleaseObj(qry);
    end;
end;
function TSAELinesFlat.getHeaderID: Integer;
begin
    Result := 0;
    if assigned(Self.Owner) then
        if self.Owner is TStockAdjustEntry then
            REsult := TStockAdjustEntry(Self.Owner).ID;
end;

function TSAELinesFlat.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  StoreValues;
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  Sendevent(BusObjEvent_Dataset, BusObjEvent_AfterInsert , Self);
  
  //DeptID := appenv.DefaultClass.ClassID;
  //PostDB;

end;


function TSAELinesFlat.GetIsPQAItem: Boolean;
begin
    REsult := False;
end;

procedure TSAELinesFlat.EditnSetDateTimeField(const FieldName: string;const Value: TDateTime);
var fb:Boolean;
begin
    if (not(Assigned(dataset))) or (dataset.findfield(fieldname)=nil) then Exit;
    fb:= Dataset.Findfield(FieldName).readonly;
    Dataset.Findfield(FieldName).readonly:= False;
    try
         SetDateTimeField(fieldName, Value);
    finally
        Dataset.Findfield(FieldName).readonly := fb;
    end;
end;

procedure TSAELinesFlat.EditnSetFloatField(const FieldName: string;const Value: double);
var fb:Boolean;
begin
    if (not(Assigned(dataset))) or (dataset.findfield(fieldname)=nil) then Exit;
    fb:= Dataset.Findfield(FieldName).readonly;
    Dataset.Findfield(FieldName).readonly:= False;
    try
         SetFloatField(fieldName, Value);
    finally
        Dataset.Findfield(FieldName).readonly := fb;
    end;
end;

procedure TSAELinesFlat.EditnSetIntegerField(const FieldName: string;const Value: Integer);
var fb:Boolean;
begin
    if (not(Assigned(dataset))) or (dataset.findfield(fieldname)=nil) then Exit;
    fb:= Dataset.Findfield(FieldName).readonly;
    Dataset.Findfield(FieldName).readonly:= False;
    try
         SetIntegerField(fieldName, Value);
    finally
        Dataset.Findfield(FieldName).readonly := fb;
    end;
end;

procedure TSAELinesFlat.EditnSetStringField(const FieldName,Value: string);
var fb:Boolean;
begin
    if (not(Assigned(dataset))) or (dataset.findfield(fieldname)=nil) then Exit;
    fb:= Dataset.Findfield(FieldName).readonly;
    Dataset.Findfield(FieldName).readonly:= False;
    try
         SetStringField(fieldName, Value);
    finally
        Dataset.Findfield(FieldName).readonly := fb;
    end;
end;

function TSAELinesFlat.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
    Result := inherited DoBeforePost(Sender);
    if not result then exit;
    if  {(not DatasetPosting) and} (ProductID = 0) and ((ProductNAme = '') or (tcdatautils.GetProduct(ProductName) = 0)) then begin
        Deleted := True;
        Result := True;
        Exit;
    end(*
    Binny : not sure y this code is here
    When a record is deleted from the gui by chooseing the Grid's delete button, this reverse it
    else if (ProductID <> 0) and (Deleted = true) then
      Deleted := False*);
    if not ImportingStockAdjustment then
      if SerialNumber <> '' then begin
             if (round(AllocationAdjustUOMQty,2) > 0) and (round(AllocationAdjustUOMQty,2) <>  1) then AllocationAdjustUOMQty := 1
        else if (round(AllocationAdjustUOMQty,2) < 0) and (round(AllocationAdjustUOMQty,2) <> -1) then AllocationAdjustUOMQty := -1;
        AllocationAdjustQty       := AllocationAdjustUOMQty*UOMMultiplier;
      end;
end;


function TSAELinesFlat.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
    Result := inherited DoBeforeInsert(Sender);
    if not result then exit;
    Sendevent(BusObjEvent_Dataset, BusObjEvent_BeforeInsert , Self);
end;
function TSAELinesFlat.Getalloctype: String;
begin
  REsult := 'IN';
end;

function TSAELinesFlat.GetQty: Double;
begin
  REsult := AdjustQty;
end;

function TSAELinesFlat.GetUOMQty: Double;
begin
  REsult := AdjustUOMQty;
end;

procedure TSAELinesFlat.storeValues;
begin
  cleanProductDetails  := ProductDetails;
end;
procedure TSAELinesFlat.SetActive(const Value: Boolean);
begin
  Deleted := not(Value);
end;

procedure TSAELinesFlat.SetBOQty(const Value: Double);
begin
  //
end;
procedure TSAELinesFlat.SetBOUOMQty(const Value: Double);
begin
  //
end;

procedure TSAELinesFlat.SetQty(const Value: Double);
begin
  inherited;
    AdjustQty:= Value;
end;

procedure TSAELinesFlat.SetUOMQty(const Value: Double);
begin
  AdjustUOMQty := value;

end;

procedure TSAELinesFlat.CheckProduct(ForceCheckProduct:Boolean=False);
var
  strSQL:String;
  Qry :TERPQuery;
begin
  if SilentMode and not(ForceCheckProduct) then exit;

  strSQL:= 'select * from tblstockadjustentrylines '+
            ' where StockAdjustEntryLinesID <> ' + IntToStr(ID) +
            ' and StockAdjustentryID = ' + IntToStr(StockAdjustEntryID) +
            ' and ProductId= ' + IntToStr(ProductID) +
            ' and ClassID= ' + IntToStr(ClassId) +
            ' and Deleted <> "T" '+ iif(ForceCheckProduct , '' , 'and ifnull(AdjustQty,0)<>0 ' );
  if EnforceUOM then
    strSQL := strSQL + ' and UOMID               = ' + IntToStr(UOMID) ;
  qry := DbSharedObj.GetQuery(Connection.Connection, strSQL);
  try
  with Qry(*getnewdataset(StrSQL,true)*) do begin
    if recordcount    >  0 then begin
      if AdjustQty    <> 0 then AdjustQty := 0;
      if AdjustUOMQty <> 0 then AdjustUOMQty := 0;
    end;
    if Assigned(self.LockAdjustQty) then Self.LockAdjustQty(Recordcount>0);
  end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
  if (BatchNo <> '') or (BinLocation <> '') or (SerialNumber <> '') then begin
      strSQL:= 'select * from tblstockadjustentrylines '+
            ' where StockAdjustEntryLinesID <> ' + IntToStr(ID) +
            ' and StockAdjustentryID  = ' + IntToStr(StockAdjustEntryID) +
            ' and ProductId           = ' + IntToStr(ProductID) +
            ' and ClassID             = ' + IntToStr(ClassId) +
            ' and ifnull(Batchno,"")             = ' + QuotedStr(Batchno) +
            ' and ifnull(BinLocation,"")         = ' + QuotedStr(BinLocation) +
            ' and ifnull(binNumber,"")           = ' + QuotedStr(binNumber) +
            ' and ifnull(Serialnumber,"")        = ' + QuotedStr(Serialnumber) +
            ' and ifnull(allocationAdjustQty,0)<>0 and Deleted <> "T"' ;
            if Expirydate = 0 then strSQL:= strSQL + ' and ifnull(expiryDate,0) = 0'
            else strSQL:= strSQL + ' and expiryDate = ' + QuotedStr(FormatDatetime(MysqlDateFormat ,expiryDate));
      if EnforceUOM then
        strSQL := strSQL + ' and UOMID               = ' + IntToStr(UOMID) ;
      qry := DbSharedObj.GetQuery(Connection.Connection, strSQL);
      try
      with Qry(*getnewdataset(StrSQL,true)*) do begin
        if recordcount    >  0 then begin
          if AllocationAdjustQty    <> 0 then AllocationAdjustQty    := 0;
          if AllocationAdjustUOMQty <> 0 then AllocationAdjustUOMQty := 0;
        end;
        if Assigned(self.LockAllocAdjustQty) then Self.LockAllocAdjustQty(Recordcount>0);
      end;
      finally
          DbSharedObj.ReleaseObj(qry);
      end;
  end;
end;


procedure TSAELinesFlat.clearalloc;
begin
  BatchNo:= '';
  if Expirydate<> 0 then Dataset.FieldByname('ExpiryDate').Value := null;
  BinLocation               := '';
  BinNumber                 := '';
  AllocationAvailableQty    := 0;
  AllocationInStockQty      := 0;
  AllocationInStockUOMQty   := 0;
  AllocationFinalqty        := 0;
  AllocationAdjustQty       := 0;
  AllocationAvailableUOMQty := 0;
  AllocationFinalUOMQty     := 0;
  AllocationAdjustUOMQty    := 0;
end;

{ TStockAdjustEntry }

constructor TStockAdjustEntry.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
    CreatingTreeModeData := False;
    CreateTreeModeDataDone := false;
    fbinTreemode := False;
    fBusObjectTypeDescription:= 'StockAdjust';
    fSQL := 'SELECT * FROM tblstockadjustentry';
    fsPQAtablename:='';
    fsPQADetailstablename:='';
    //fProgressbar := nil;
    fShowStatus := nil;
    fLockAdjustQty := nil;
    fLockAllocAdjustQty := nil;
    fCreatebin := nil;
    fbTempSave := FAlse;
    fbProcessing := False;
    fsCountCaption := '1 of 1';
    ExportExcludeList.Add('accoountid');
    fbImportingStockAdjustment := False;
    fbDoProcessonSave := False;
end;


Class function TStockAdjustEntry.GetIDField: string;
begin
  Result := 'StockAdjustEntryID'
end;


Class function TStockAdjustEntry.GetKeyStringField: string;
begin
  Result := 'Globalref'
end;


function TStockAdjustEntry.GetApproved: boolean;
begin
  result := GetBooleanField('Approved');
end;

Class function TStockAdjustEntry.GetBusObjectTablename: string;
begin
  Result := 'tblstockadjustentry'
end;


destructor TStockAdjustEntry.Destroy;
begin
  logtext(Classname+':destroyed');
  DeleteSAELineTables;
  inherited;
end;


procedure TStockAdjustEntry.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'CreationDate');
  SetPropertyFromNode(node,'AdjustmentDate');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'Accountname');
  SetPropertyFromNode(node,'Notes');
  SetPropertyFromNode(node,'IsStocktake');
  SetPropertyFromNode(node,'ImportgroupOriginalno');
  SetPropertyFromNode(node,'Adjusttype');
  SetPropertyFromNode(node,'Employee');
  SetBooleanPropertyFromNode(node,'Deleted');
  SetBooleanPropertyFromNode(node,'EnforceUOM');
  SetBooleanPropertyFromNode(node,'AdjustmentonInstock');
  SetBooleanPropertyFromNode(node,'Approved');
end;


procedure TStockAdjustEntry.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'CreationDate' ,CreationDate);
  AddXMLNode(node,'AdjustmentDate' ,AdjustmentDate);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'Accountname' ,Accountname);
  AddXMLNode(node,'Notes' ,Notes);
  AddXMLNode(node,'IsStocktake' ,IsStocktake);
  AddXMLNode(node,'Employee' ,Employee);
  AddXMLNode(node,'Deleted' ,Deleted);
  AddXMLNode(node,'EnforceUOM' ,EnforceUOM);
  AddXMLNode(node,'AdjustmentonInstock' ,AdjustmentonInstock);
  AddXMLNode(node,'SMEGlobalref' ,Globalref); // for processing
  AddXMLNode(node,'ImportgroupOriginalno' ,Globalref);
  AddXMLNode(node,'Adjusttype' ,AdjustType);
  AddXMLNode(node,'Approved' ,Approved);
  AddXMLNode(node,'TotalCostEx',self.TotalCostEx);

  if CreateTreeModeDataDone and (ReadPQAtablename <> '') then begin
    self.LineProducts.XMLPropertyNode := node.AddChild(LineProducts.XMLBranchName);
    self.LineProducts.XMLPropertyName:= LineProducts.XMLNodeName;
    showProgressbar(LineProducts.count, 'Generating XML');

    self.LineProducts.IterateRecords(GetPropertyXMLCallback);
    HideProgressbar;
  end;
end;

procedure TStockAdjustEntry.CallbackSaveLines(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not(Sender is TSAELines) then exit;
  StepProgressBar;
  if not TSAELines(Sender).Save then begin
      Abort := true;
      AllLinesValid := False;
  end;
end;

procedure TStockAdjustEntry.CallbackValidateData(const Sender: TBusObj;  var Abort: boolean);
begin
  if not(Sender is TSAELines) then exit;
  stepProgressbar;
  if not TSAELines(Sender).ValidateData then begin
      Abort := true;
      AllLinesValid := False;
  end;
end;

procedure TStockAdjustEntry.CallbackValidateLineProducts(const Sender: TBusObj;  var Abort: boolean);
begin
  if not(Sender is TSAELinestree) then exit;
  stepProgressbar;
  if not TSAELinestree(Sender).ValidateData then begin
      Abort := true;
      AllLinesValid := False;
  end;
end;

function TStockAdjustEntry.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  self.PostDb;
  if LineProductsAssigned then LineProducts.PostDb;
  Lines.PostDb;
  if (not Deleted) and (not TApprovalCheck.Approved(self)) then begin
    exit;
  end;
  if (not Deleted) and (AccountID = 0) then begin
    AddResult(False , rssWarning, 0 , 'Account Should not be Blank.' );
    Exit;
  end;
  if (not Deleted) and (CreationDate = 0) then begin
    AddResult(false, rssWarning, 0, 'Creation Date is Blank.');
    exit;
  end;
  if (not Deleted) and (AdjustmentDate = 0) then begin
    AddResult(false, rssWarning, 0, 'Adjustment Date is Blank.');
    exit;
  end;
  if (not Deleted) and (Employee = '') then begin
    AddResult(false, rssWarning, 0, 'Employee is Blank.');
    exit;
  end;
  if fbTempSave = False then
    if (not Deleted) and (Lines.count =0) and (ReadLineTablename <> '') and (LineProductsAssigned and (LineProducts.count =0)) then begin
      Resultstatus.AddItem(False , rssWarning, 0 , 'No Products For Adjustment.' );
      Exit;
    end;

  if (not Deleted) then begin
    AllLinesValid := true;
    ShowProgressbar(Lines.count, 'Validating lines');
    try
      if LineProductsAssigned then LineProducts.IterateRecords(CallbackValidateLineProducts{CallbackValidateData});
    finally
      HideProgressbar;
    end;
    if not AllLinesValid then Exit;
//    AllLinesValid := true;

//    ShowProgressbar(Lines.count, 'Validating lines');
//    try
//      Lines.IterateRecords(CallbackValidateData);
//    finally
//      HideProgressbar;
//    end;
//    if not AllLinesValid then Exit;
  end;

  Result := True;
end;


class function TStockAdjustEntry._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TAccount','AccountObj','AccountID','ID');
  TBOSchema.AddRefType(result,'TAccount','AccountObj','AccountName','AccountName');
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','Employee','EmployeeName');
end;

function TStockAdjustEntry.Save: Boolean ;
var
  i:Integer;
begin
  Result := False;
  if deleted then begin
    PostDB;
    {deleting stockadjustemnt should
        flag the Stock adjustment header as deleted
        Lines should not be deleted
        stockmovement , movementlines, pqa , pqa details all should be physically deleted}
      if PRocessed then begin
        i:= accessmanager.accesslevel;
        accessmanager.accesslevel := 1;
        try
          DeleteStockAdjust;
        finally
          accessmanager.accesslevel:= i;
        end;
      end;
      result := true;
  end else begin
    if not ValidateData then Exit;
    PostDB;
    Lines.PostDB;

    AllLinesValid := true;
    ShowProgressbar(Lines.count, 'Saving Lines');
    try
      Lines.IterateRecords(CallbackSaveLines);
    finally
      HideProgressbar;
    end;
    if not AllLinesValid then exit;


    Result := inherited Save;
    DeleteFlagedLines;
  end;
  if not PostList.Execute then begin
    Result := False;
    Exit;
  end;

  if result and not (Deleted) and DoProcessonSave and (Lines.count >0) then
      REsult := Process ;
  if result then Dirty := False;
end;

procedure TStockAdjustEntry.DeleteStockAdjust;
begin
   StockMovement.DeleteStockMovement ;
end;

procedure TStockAdjustEntry.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if Processed then NoRightReason := 'The Stock Adjsutment is already Processed';
  fbDoProcessonSave := False;
  fbprocessing := False;
end;


procedure TStockAdjustEntry.DoFieldOnChange(Sender: TField);
var
  fDoFieldChangewhenDisabled :Boolean;
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    if processed then exit;
    inherited;
    if SameText(Sender.fieldName , 'Globalref') then begin
      if not RawMode then begin
        if ImportgroupOriginalno = '' then ImportgroupOriginalno := Globalref;
      end;
    end else if SameText(Sender.FieldName , 'AdjustmentDate') then begin
      if not RawMode then begin
        //Sendevent(BusObjEvent_Change, BusobjEventVal_StockAdjustproduct , Self);
      end;
    end else if SameText(Sender.fieldName , 'AccountID') then begin
      if AccountID > 0 then
        AccountName := tcdatautils.GetAccountName(AccountID)//TAccount.IDToggle(AccountID, Self.connection.connection)
      else
        AccountName := '';
      if not RawMode then begin
        if Lines.count >0 then   begin
          showProgressbar(Lines.count, 'Assign AccountID');
          fDoFieldChangewhenDisabled := Lines.DoFieldChangewhenDisabled;
          Lines.DoFieldChangewhenDisabled := true;
          try
            Lines.IterateRecords(AssignAccountID);
          finally
            Lines.DoFieldChangewhenDisabled := fDoFieldChangewhenDisabled;
          end;
          hideProgressbar;
        end;
        if ReadPQAtablename <> '' then begin
          showProgressbar(LineProducts.count, 'Assign AccountID');
          fDoFieldChangewhenDisabled := self.LineProducts.DoFieldChangewhenDisabled;
          self.LineProducts.DoFieldChangewhenDisabled := true;
          try
            self.LineProducts.IterateRecords(AssignAccountID);
          finally
            self.LineProducts.DoFieldChangewhenDisabled := fDoFieldChangewhenDisabled;
          end;
          hideProgressbar;
        end;
      end;
    end else if SameText(Sender.fieldName , 'AccountName') then begin
      if AccountName <> '' then
        AccountID := tcdatautils.AccountIDForName(AccountName)//  TAccount.IDToggle(AccountName, Self.connection.connection)
      else
        AccountID := 0;
      if not RawMode then begin
        DoFieldOnChange(dataset.findfield('AccountID'));
      end;
    end;
    if Sysutils.SameText(Sender.fieldname , 'Approved') then begin
      TApprovalCheck.Approved(self, Sender);
    end;
end;

procedure TStockAdjustEntry.qryAfterCloseDatasetLog(DataSet: TDataSet);
begin
end;

class function TStockAdjustEntry.EmptyStock(const AdjDate:TDatetime; Const StockBasedoninstock:Boolean;const fProductIDs,fClassIDs: String): String;
var
  Originalno:String;
  StockAdjust:TStockAdjustEntry;
  Qry :TERPQuery;
  ctr:Integer;
  fiProductID, fiClassId, fiUOMID:Integer;
  ProgressDialog: TProgressDialog;
  fbFoundrec:Boolean;
  fConnection :TERPConnection;
  saNo:Integer;

  Procedure MakeStockAdjustObj;
  begin
      StockAdjust:= TStockAdjustEntry.create(Nil);
      StockAdjust.connection := TMyDacDataConnection.create(StockAdjust);
      StockAdjust.Connection.Connection := fConnection;
      StockAdjust.Connection.BeginTransaction;
      StockAdjust.ClearContainerListOnNew := True;
      StockAdjust.Load(0);
  end;

  Procedure NewStock;
  begin
    StockAdjust.pOSTdb;
    StockAdjust.New;
    StockAdjust.EnforceUOM := True;
    StockAdjust.AdjustmentOnInstock := StockBasedoninstock;
    StockAdjust.AdjustmentDate := AdjDate;
    StockAdjust.PostDB;
    if Originalno = '' then Originalno := StockAdjust.globalref;
    StockAdjust.ImportgroupOriginalno := Originalno;
    StockAdjust.PostDB;
    StockAdjust.Lines.DoFieldChangewhenDisabled := true;
    StockAdjust.Lines.ClearContainerListOnNew := true;
    saNo := saNo +1;
  end;

begin
  fbFoundrec:=False;
  Originalno := '';
  result:= '';
  saNo := 0;

  ProgressDialog := TProgressDialog.Create(nil);
  try
    ProgressDialog.Caption := 'Please Wait .......';
    ProgressDialog.ShowPercent:= False;
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := 10;//recordcount;
    ProgressDialog.Step := 1;
    ProgressDialog.Execute;
    ProgressDialog.StepIt;
          try
            Qry := commonDBLib.TempMyQuery;
            fConnection := CommonDbLib.GetNewMyDacConnection(StockAdjust);
            try
                  MakeStockAdjustobj;
                  try
                      TERPQuery(Qry).Connection :=fConnection;
                      TERPQuery(Qry).afterclose := StockAdjust.qryAfterCloseDatasetLog;

                        TERPQuery(Qry).SQL.Clear;
                        TERPQuery(Qry).SQL.text := ProductQtyLib.StockQtyNonAllocProducts(true, 0, 0, AdjDate)+
                                                    ' Union all ' +
                                                    ProductQtyLib.StockQtyDetailswithSno(true, 0, 0, AdjDate, True, False);
                        if (fProductIDs <> '') and (fClassIds<>'') then TERPQuery(Qry).SQL.text := replacestr(TERPQuery(Qry).SQL.text , 'where' , 'Where (PQA.ProductID in ('+ fProductIDs+') and PQA.DepartmentID in (' +fClassIds +')) and ')
                        else if (fProductIDs = '') and (fClassIds<>'') then TERPQuery(Qry).SQL.text := replacestr(TERPQuery(Qry).SQL.text , 'where' , 'Where (PQA.DepartmentID in (' +fClassIds +')) and ')
                        else if (fProductIDs <> '') and (fClassIds='') then TERPQuery(Qry).SQL.text := replacestr(TERPQuery(Qry).SQL.text , 'where' , 'Where (PQA.ProductID in ('+ fProductIDs+') ) and ');
                        clog(qry.sql.text);
                        ProgressDialog.StepIt;
                        Qry.open;
                        ProgressDialog.StepIt;

                        if Qry.recordcount = 0 then Exit;

                        ProgressDialog.StepIt;

                        NewStock;
                        fiProductID:=0; fiClassId:=0 ; fiUOMID:=0;
                        With Qry do begin
                            ProgressDialog.MaxValue := recordcount;
                            ProgressDialog.Value := 1;
                              first;
                              ctr:= 0;

                              While Eof = False do begin
                                if (StockBasedoninstock and (Fieldbyname('InstockUOMQty').AsFloat <> 0)) or
                                    (not(StockBasedoninstock) and (Fieldbyname('UOMQty').AsFloat <> 0)) then begin
                                  if (Qry.FieldByName('Serialnumber').asString <>'')  and  (Fieldbyname('UOMQty').AsFloat  <0) then begin
                                    Next;
                                    continue;
                                  end;
                                  if (fiProductID<>Fieldbyname('PartsId').asInteger) or ( fiClassId<> fieldByname('DepartmentId').asInteger) or (fiUOMID<>FieldByname('UOMID').asInteger) then begin
                                    fbFoundrec:=True;
                                    StockAdjust.Lines.New;
                                    StockAdjust.Lines.ProductID   := Fieldbyname('PartsId').asInteger;
                                    StockAdjust.Lines.DeptID      := fieldByname('DepartmentId').asInteger;
                                    StockAdjust.Lines.UOM         := fieldByname('UOM').asString;
                                    StockAdjust.Lines.UOMID       := FieldByname('UOMID').asInteger;
                                    StockAdjust.Lines.FinalQty    := 0;
                                    StockAdjust.Lines.FinalUOMQty := 0;
                                    StockAdjust.Lines.PostDB;
                                    fiProductID:= Fieldbyname('PartsId').asInteger;
                                    fiClassId  := fieldByname('DepartmentId').asInteger;
                                    fiUOMID    := FieldByname('UOMID').asInteger;
                                    //if (Qry.FieldByName('Batchnumber').AsString <> '') OR (Qry.FieldByName('binLocation').AsString <> '') OR (Qry.FieldByName('Serialnumber').asString <>'') then continue;
                                  end;

                                  if (Qry.FieldByName('Batchnumber').AsString <> '') OR (Qry.FieldByName('binLocation').AsString <> '') OR (Qry.FieldByName('Serialnumber').asString <>'') then begin
                                    fbFoundrec:=True;
                                    StockAdjust.Lines.New;
                                    StockAdjust.Lines.ProductID   := Fieldbyname('PartsId').asInteger;
                                    StockAdjust.Lines.DeptID      := fieldByname('DepartmentId').asInteger;
                                    StockAdjust.Lines.UOM         := fieldByname('UOM').asString;
                                    StockAdjust.Lines.UOMID       := FieldByname('UOMID').asInteger;
                                    StockAdjust.Lines.BatchNo     := Qry.FieldByName('Batchnumber').AsString ;
                                    StockAdjust.Lines.ExpiryDate  := Qry.FieldByName('BatchExpiryDate').asDatetime;
                                    StockAdjust.Lines.BinLocation := Qry.FieldByName('binLocation').asString;
                                    StockAdjust.Lines.Binnumber   := Qry.FieldByName('Binnumber').asString;
                                    StockAdjust.Lines.SerialNumber:= Qry.FieldByName('Serialnumber').asString;
                                    StockAdjust.Lines.AllocationFinalQty :=0;
                                    StockAdjust.Lines.AllocationFinalUOMQty :=0;
                                    StockAdjust.Lines.PostDB;
                                  end;
                                ctr:= ctr+1;
                                if ctr >= 400 then begin
                                  StockAdjust.Lines.PostDB;
                                  StockAdjust.PostDB;
                                  if Originalno = '' then Originalno := StockAdjust.globalref;
                                  StockAdjust.Lines.closedb;
                                  StockAdjust.closedb;
                                  (*Freeandnil( StockAdjust);
                                  MakeStockAdjustObj;*)
                                  StockAdjust.Load(0);
                                  NewStock;
                                  ctr:= 0;
                                end;
                              end;
                              ProgressDialog.Message := 'SA # ' +inttostr(saNo) +':' +inttostr(recno)+' of ' + inttostr(recordcount)+' Products -> ' +quotedstr(Fieldbyname('Productname').AsString);
                              ProgressDialog.StepIt;
                              Next;
                            end;
                            if fbFoundrec then result := Originalno;
                            StockAdjust.Connection.CommitTransaction;
                      end;
                  Except
                    on E:Exception do begin
                      CommonLib.MessageDlgXP_Vista('Empty Stock Failed'+ chr(13) + chr(13) + E.Message , mtWarning, [mbok], 0);
                      result :='';
                    end;
                  end;
            finally
              Freeandnil(fConnection);
            end;
          finally
            freeandnil(StockAdjust);
            if Qry.active then Qry.close;
            Freeandnil(Qry);
          end;
    finally
            ProgressDialog.CloseDialog;
            Freeandnil(ProgressDialog);
    end;
end;

function TStockAdjustEntry.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TStockAdjustEntry.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
end;


{Property functions}
function  TStockAdjustEntry.GetCreationDate      : TDateTime ; begin Result := GetDateTimeField('CreationDate');end;
function  TStockAdjustEntry.GetAdjustmentDate    : TDateTime ; begin Result := GetDateTimeField('AdjustmentDate');end;
function  TStockAdjustEntry.GetAccountID         : Integer   ; begin Result := GetIntegerField('AccountID');end;
function  TStockAdjustEntry.GetAccountname       : string    ; begin Result := GetStringField('Accountname');end;
function  TStockAdjustEntry.GetNotes             : string    ; begin Result := GetStringField('Notes');end;
function  TStockAdjustEntry.GetIsStocktake       : Boolean   ; begin Result := GetBooleanField('IsStocktake');end;
function  TStockAdjustEntry.GetEmployee          : string    ; begin Result := GetStringField('Employee');end;
function  TStockAdjustEntry.GetDeleted           : Boolean   ; begin Result := GetBooleanField('Deleted');end;
function  TStockAdjustEntry.GetProcessed         : Boolean   ; begin REsult := GetBooleanField('Processed'); end;
function  TStockAdjustEntry.getAdjustOnInstock   : Boolean   ; begin Result := GetBooleanField('AdjustmentOnInstock');end;
function  TStockAdjustEntry.getEnforceUOM        : Boolean   ; begin Result := GetBooleanField('EnforceUOM');end;
procedure TStockAdjustEntry.SetAdjustOnInstock   (const Value: Boolean   ); begin SetBooleanfield('AdjustmentOnInstock' , Value);end;
procedure TStockAdjustEntry.SetEnforceUOM        (const Value: Boolean   ); begin SetBooleanfield('EnforceUOM'          , Value);end;
procedure TStockAdjustEntry.SetApproved(const Value: boolean);
begin
  SetBooleanField('Approved', Value);
end;

procedure TStockAdjustEntry.SetCreationDate      (const Value: TDateTime ); begin SetDateTimeField('CreationDate'       , Value);end;
procedure TStockAdjustEntry.SetAdjustmentDate    (const Value: TDateTime ); begin SetDateTimeField('AdjustmentDate'     , Value);end;
procedure TStockAdjustEntry.SetAccountID         (const Value: Integer   ); begin SetIntegerField('AccountID'           , Value);end;
procedure TStockAdjustEntry.SetAccountname       (const Value: string    ); begin SetStringField('Accountname'          , Value);end;
procedure TStockAdjustEntry.SetNotes             (const Value: string    ); begin SetStringField('Notes'                , Value);end;
procedure TStockAdjustEntry.SetIsStocktake       (const Value: Boolean   ); begin SetBooleanField('IsStocktake'         , Value);end;

procedure TStockAdjustEntry.SetEmployee          (const Value: string    ); begin SetStringField('Employee'             , Value);end;
procedure TStockAdjustEntry.SetDeleted           (const Value: Boolean   ); begin SetBooleanField('Deleted'             , Value);end;
procedure TStockAdjustEntry.SetProcessed         (const Value: Boolean   ); begin SetBooleanField('Processed'           , Value);end;

function TStockAdjustEntry.GetLineProductsAssigned: Boolean;
begin
  result := Assigned(getContainerComponentifExists(TSAELinestree));
end;

function TStockAdjustEntry.GetLines: TSAELinesFlat;
begin
    postDB;
    Result := TSAELinesFlat(getContainerComponent(TSAELinesFlat, 'StockAdjustEntryID = '+ IntToStr(Self.Id)));
    Result.Createbin := Createbin;
end;



function TStockAdjustEntry.getLineProducts: TSAELinestree;
begin
    PostDB;
    Result := TSAELinestree(getContainerComponent(TSAELinestree, 'StockAdjustEntryID = '+ IntToStr(Self.Id)));
end;

Function TStockAdjustEntry.CreateTreeModeData:Boolean;
var
    StrSQL:String;
    fiProductID     :Integer;
    fiDeptID       :Integer;
    fiUOMID         :Integer;
    fsBatchNo       :STring;
    fdExpirydate    :TDatetime;
    fsBinLocation   :STring;
    fsBinNumber     :STring;
    fsSerialNumber  :STring;
    //fqry             :TDataset;
    Qry :TERPQuery;
    batchglobalref, binglobalref:String;
    fsMatrixREf:String;
    st :TStringlist;
    Function IsAllocationRec:Boolean;
    begin
      REsult:= False;
          if trim(Qry.FieldByname('BatchNo').asString) <> '' then begin
            REsult:= True;
            Exit;
          end;

          if trim(Qry.FieldByname('binlocation').asString) <> '' then begin
            REsult:= True;
            Exit;
          end;

          if Trim(Qry.FieldByname('Serialnumber').asString) <> '' then begin
            Result := True;
            Exit;
          end;
    end;

    Procedure CreatePQA;
    begin
        if  (fiProductID<> Qry.FieldByname('ProductID').asInteger) or
            (fiDeptId  <> Qry.FieldByname('ClassId').asInteger) or
            (fiUOMID    <> Qry.FieldByname('UOMID').asInteger) or
            (fsMatrixREf <> Qry.FieldByname('MatrixREf').asString) then begin
          LineProducts.New;
          LineProducts.Globalref      := Qry.FieldByname('Globalref').asString;
          LineProducts.ProductName    := Qry.FieldByname('ProductName').AsString;
          LineProducts.productId      := Qry.FieldByname('ProductID').asInteger;
          LineProducts.Description    := Qry.FieldByname('Description').AsString;
          LineProducts.ProductPrintName:= Qry.FieldByname('ProductPrintName').AsString;
          LineProducts.DeptID         := Qry.FieldByname('ClassID').asInteger;
          LineProducts.DeptName       := Qry.FieldByname('ClassName').AsString;
          LineProducts.AccountID      := Qry.FieldByname('AccountID').asInteger;
          LineProducts.AccountName    := Qry.FieldByname('AccountNAme').AsString;
          LineProducts.UOM            := Qry.FieldByname('UOM').AsString;
          LineProducts.UOMMultiplier  := Qry.FieldByname('UOMMultiplier').asFloat;
          LineProducts.UOMID          := Qry.FieldByname('UOMID').asInteger;
          LineProducts.MatrixRef      := Qry.FieldByname('MatrixRef').asString;
          LineProducts.MatrixDesc     := Qry.FieldByname('MatrixDesc').AsString;
          LineProducts.MatrixPrice    := Qry.FieldByname('MatrixPrice').AsFloat;
          LineProducts.Notes          := Qry.FieldByname('Notes').AsString;
          LineProducts.JobID          := Qry.FieldByname('JobID').AsInteger;
          LineProducts.JobName        := Qry.FieldByname('JobName').AsString;
          fiProductID     := Qry.FieldByname('ProductID').asInteger;
          fiDeptId        := Qry.FieldByname('ClassId').asInteger;
          fiUOMID         := Qry.FieldByname('UOMID').asInteger;
          fsMatrixREf     := Qry.fieldByname('MatrixREf').asString;
          batchglobalref  := '';
          binglobalref    := '';
          fsBinlocation   := '';
          fsBinnumber     := '';
          fsBatchNo       := '';
          fdExpirydate    := 0;
//        end;
(*          if Qry.FieldByname('AdjustQty').Asfloat <> 0 then begin
            LineProducts.AvailableQty     := Qry.FieldByname('AvailableQty').Asfloat;
            LineProducts.FinalQty         := Qry.FieldByname('FinalQty').Asfloat;
            LineProducts.InstockQty       := Qry.FieldByname('InstockQty').Asfloat;

            LineProducts.AvailableUOMQty  := Qry.FieldByname('AvailableuomQty').Asfloat;
            LineProducts.FinalUOMQty      := Qry.FieldByname('FinalUOMQty').Asfloat;
            LineProducts.InstockUOMQty    := Qry.FieldByname('InstockUOMQty').Asfloat;
            //LineProducts.AdjustQty      := LineProducts.AdjustQty +Qry.FieldByname('AdjustQty').Asfloat;
          end else if Qry.FieldByname('AdjustUOMQty').Asfloat <> 0 then begin
            LineProducts.AvailableUOMQty  := Qry.FieldByname('AvailableUOMQty').Asfloat;
            LineProducts.InstockUOMQty    := Qry.FieldByname('InstockUOMQty').Asfloat;
            LineProducts.FinalUOMQty      := Qry.FieldByname('FinalUOMQty').Asfloat;

            LineProducts.AvailableQty := Qry.FieldByname('AvailableQty').Asfloat;
            LineProducts.InstockQty   := Qry.FieldByname('InstockQty').Asfloat;
            LineProducts.FinalQty     := Qry.FieldByname('FinalQty').Asfloat;
            //LineProducts.AdjustUOMQty   := LineProducts.AdjustUOMQty + Qry.FieldByname('AdjustUOMQty').Asfloat;
          end;*)
            LineProducts.AvailableQty     := Qry.FieldByname('AvailableQty').Asfloat;
            LineProducts.FinalQty         := Qry.FieldByname('FinalQty').Asfloat;
            LineProducts.InstockQty       := Qry.FieldByname('InstockQty').Asfloat;
            LineProducts.AdjustQty        := Qry.FieldByname('AdjustQty').Asfloat;

            LineProducts.AvailableUOMQty  := Qry.FieldByname('AvailableuomQty').Asfloat;
            LineProducts.FinalUOMQty      := Qry.FieldByname('FinalUOMQty').Asfloat;
            LineProducts.InstockUOMQty    := Qry.FieldByname('InstockUOMQty').Asfloat;
            LineProducts.AdjustUOMQty     := Qry.FieldByname('AdjustUOMQty').Asfloat;

          if (LineProducts.Cost         <> Qry.FieldByname('Cost').Asfloat) and (Qry.FieldByname('Cost').Asfloat<>0) then
            LineProducts.Cost         := Qry.FieldByname('Cost').Asfloat;

end;
        LineProducts.PostDB;
        if LineProducts.PQA.count = 0 then begin
            LineProducts.PQA.New;
            LineProducts.PQA.TransLineID    := LineProducts.ID;
            LineProducts.PQA.ProductID      := LineProducts.ProductID;
            LineProducts.PQA.ProductName    := LineProducts.ProductName;
            LineProducts.PQA.DepartmentID   := LineProducts.DeptID;
            LineProducts.PQA.UnitOfMeasure  := LineProducts.UOM;
            LineProducts.PQA.UnitOfMeasureID:= LineProducts.UOMID;
            LineProducts.PQA.UOMMultiplier  := LineProducts.UOMMultiplier;
        end;
        LineProducts.PQA.PostDB;
    end;

    Procedure stadd(const Value:String);
    begin
      if st.IndexOf(Value) >= 0 then exit;
      st.Add(Value);
    end;

    function ValidAdjustmentLinerec:Boolean;
    begin
      REsult := False;
      try
        if ( Qry.FieldByname('BatchNo').asString = '') and (Qry.FieldByname('binlocation').asString = '') and   (Qry.FieldByname('Serialnumber').asString = '') then
          Exit;

        if LineProducts.Product.Batch then
          if Qry.FieldByname('BatchNo').asString = '' then
            if (Qry.FieldByname('binlocation').asString <> '') or (Qry.FieldByname('Serialnumber').asString <>'')  then
              Exit;

        if LineProducts.Product.MultipleBins then
          if Qry.FieldByname('binlocation').asString = '' then
            if (Qry.FieldByname('Serialnumber').asString <>'')  then
            Exit;

       (* if LineProducts.Product.SnTracking then
          if Qry.FieldByname('Serialnumber').asString = '' then
            Exit;*)

        Result := True;
      finally
      end;
    end;

    Procedure Createbins;
    var
        fbDoFieldChange:boolean;
        fsbinID:String;
    begin
        if not(ValidAdjustmentLinerec) then exit;
        if Qry.FieldByname('binlocation').asString <> '' then begin
            fsBinid := IntToStr(ProductBinIDToggle(Qry.FieldByname('ClassId').asInteger, Qry.FieldByname('binLocation').asString, Qry.FieldByname('BinNumber').asString));
            if  (fsBinlocation <> Qry.FieldByname('Binlocation').asString) or
                (fsBinnumber   <> Qry.FieldByname('Binnumber').asString) or
                not(LineProducts.SAEPQA.PQADetails.Dataset.Locate('PQAID;ParentRef;PQAType;Value' ,
                    Vararrayof([LineProducts.SAEPQA.ID,batchglobalref,TPQABins.PQADetailtype,fsbinID]), []) ) then begin
                LineProducts.SAEPQA.PQADetails.new;
                LineProducts.SAEPQA.PQADetails.PQAID       :=LineProducts.SAEPQA.ID;
                LineProducts.SAEPQA.PQADetails.ParentRef   := batchglobalref;
                LineProducts.SAEPQA.PQADetails.PQAType     := TPQABins.PQADetailtype;
                LineProducts.SAEPQA.PQADetails.PQAValue    := fsbinID;
                if ISInteger(fsbinID) then
                  TStockAdjustEntryPQABins(LineProducts.SAEPQA.PQADetails).BinId       := strToInt(fsbinID);
                LineProducts.SAEPQA.PQADetails.PostDB;
                Binglobalref :=LineProducts.SAEPQA.PQADetails.Globalref;
                fsBinlocation := Qry.FieldByname('Binlocation').asString;
                fsBinnumber   := Qry.FieldByname('Binnumber').asString;
                fsSerialNumber  :='';
            end else begin

            end;
          fbDoFieldChange:= LineProducts.SAEPQA.PQADetails.DoFieldChange;
          LineProducts.SAEPQA.PQADetails.DoFieldChange := False;
          try
                LineProducts.SAEPQA.PQADetails.Qty     := LineProducts.SAEPQA.PQADetails.Qty +Qry.FieldByname('AllocationAdjustQty').asfloat;
                LineProducts.SAEPQA.PQADetails.UOMQty  := LineProducts.SAEPQA.PQADetails.UOMQty + Qry.FieldByname('AllocationAdjustUOMQty').asfloat;
                LineProducts.SAEPQA.PQADetails.PostDB;
          finally
            LineProducts.SAEPQA.PQADetails.DoFieldChange :=fbDoFieldChange;
          end;
      end;
    end;

    Procedure CreateBatch;
      var
        fbDoFieldChange:boolean;
    begin
        if not(ValidAdjustmentLinerec) then exit;
        if Qry.FieldByname('BatchNo').asString <> '' then begin
            if  (fsBatchNo <> Qry.FieldByname('BatchNo').asString) or
                (fdExpirydate <> Qry.FieldByname('Expirydate').asDateTime) then begin
                LineProducts.SAEPQA.PQADetails.new;
                LineProducts.SAEPQA.PQADetails.PQAID       :=LineProducts.SAEPQA.ID;
                LineProducts.SAEPQA.PQADetails.ParentRef   := '';
                LineProducts.SAEPQA.PQADetails.PQAType     := TPQABatch.PQADetailtype;
                LineProducts.SAEPQA.PQADetails.PQAValue    :=Qry.FieldByname('BatchNo').asString;
                LineProducts.SAEPQA.PQADetails.ExpiryDate  :=Qry.FieldByname('Expirydate').asDatetime;
                LineProducts.SAEPQA.PQADetails.PostDB;
                batchglobalref :=LineProducts.SAEPQA.PQADetails.Globalref;
                fsBatchNo       := Qry.FieldByname('BatchNo').asString;
                fdExpirydate    := Qry.FieldByname('Expirydate').asDateTime;
                Binglobalref := '';
                fsBinNumber     :='';
                fsBinlocation:= '';
                fsSerialNumber  :='';
            end else begin
                if not LineProducts.SAEPQA.PQADetails.Dataset.Locate('PQAID;PQAType;Value;ExpiryDate',
                      VarArrayof([LineProducts.SAEPQA.ID, TPQABatch.PQADetailtype, Qry.FieldByname('BatchNo').asString, Qry.FieldByname('Expirydate').Value ]), [])  then begin
                end;
            end;
          fbDoFieldChange:= LineProducts.SAEPQA.PQADetails.DoFieldChange;
          LineProducts.SAEPQA.PQADetails.DoFieldChange := False;
          try
                LineProducts.SAEPQA.PQADetails.Qty     := LineProducts.SAEPQA.PQADetails.Qty +Qry.FieldByname('AllocationAdjustQty').asfloat;
                LineProducts.SAEPQA.PQADetails.UOMQty  := LineProducts.SAEPQA.PQADetails.UOMQty + Qry.FieldByname('AllocationAdjustUOMQty').asfloat;
                LineProducts.SAEPQA.PQADetails.PostDB;
          finally
            LineProducts.SAEPQA.PQADetails.DoFieldChange :=fbDoFieldChange;
          end;
        end;
    end;

    Procedure CreateSerialnumber;
    var
        fbDoFieldChange:boolean;
        fsParentRef:String;
    begin
        if not(ValidAdjustmentLinerec) then exit;
        if Qry.FieldByname('Serialnumber').asString <> '' then begin
            if binglobalref <> '' then fsParentRef:= binGlobalref
                else if batchGlobalref <> '' then fsParentRef:= batchGlobalref
                else fsParentRef:= '';
            if  (fsSerialnumber <> Qry.FieldByname('Serialnumber').asString) or
                (LineProducts.SAEPQA.PQADetails.dataset.locate('PQAID;ParentRef;PQAType;Value',
                                                               VarArrayof([LineProducts.SAEPQA.ID, fsParentRef, TPQASN.PQADetailtype, Qry.FieldByname('Serialnumber').asString]), []) ) then begin
                LineProducts.SAEPQA.PQADetails.new;
                LineProducts.SAEPQA.PQADetails.PQAID           := LineProducts.SAEPQA.ID;
                LineProducts.SAEPQA.PQADetails.ParentRef       := fsParentRef;
                LineProducts.SAEPQA.PQADetails.PQAType         := TPQASN.PQADetailtype;
                LineProducts.SAEPQA.PQADetails.PQAValue        := Qry.FieldByname('Serialnumber').asString;
                LineProducts.SAEPQA.PQADetails.PostDB;
                LineProducts.SAEPQA.PQADetails.RepopulateCustFld2Callback;
                fsSerialnumber       := Qry.FieldByname('Serialnumber').asString;
            end else begin
            end;
          fbDoFieldChange:= LineProducts.SAEPQA.PQADetails.DoFieldChange;
          LineProducts.SAEPQA.PQADetails.DoFieldChange := False;
          try
                LineProducts.SAEPQA.PQADetails.Qty     := LineProducts.SAEPQA.PQADetails.Qty +Qry.FieldByname('AllocationAdjustQty').asfloat;
                LineProducts.SAEPQA.PQADetails.UOMQty  := LineProducts.SAEPQA.PQADetails.UOMQty + Qry.FieldByname('AllocationAdjustUOMQty').asfloat;
                LineProducts.SAEPQA.PQADetails.PostDB;
          finally
            LineProducts.SAEPQA.PQADetails.DoFieldChange :=fbDoFieldChange;
          end;
        end;
    end;
begin
  result := True;
  CreatingTreeModeData := True;
  try
        st:= TStringlist.create;
        try
          st.Duplicates := dupIgnore;
          if (fsPQATableName            = '') or not(Commondblib.TableExists(fsPQATableName           )) then PQATableName          := CreateUserTemporaryTable('tblPQA'          , StockAdjustEntryType,'MYISAM');
          if (fsPQADetailsTableName     = '') or not(Commondblib.TableExists(fsPQADetailsTableName    )) then PQADetailsTableName   := CreateUserTemporaryTable('tblPQADetails'   , StockAdjustEntryType,'MYISAM');
          if (fsLinesProductsTableName  = '') or not(Commondblib.TableExists(fsLinesProductsTableName )) then LinesProductsTableName:= CreateUserTemporaryTable('tmp_saeProducts' , StockAdjustEntryType,'MYISAM');
          Logtext ('1:' + NL+ fsPQATableName+NL+ fsPQADetailsTableName+NL+   fsLinesProductsTableName+NL+'Tables Created');
          try LineProducts.Closedb; Except End; // if the object exists, then free it so that the SQL will be populated with the new table created here
          LineProducts;
          strSQL:= 'SELECT  * ' +
                  ' From tblstockadjustEntryLines ' +
                  ' where Deleted <> "T" and StockAdjustEntryID  = '+ IntToStr(ID) +
                  ' Order by  ProductID,ClassID, UOMID, abs(AdjustUOMQty) desc,BatchNo,Expirydate,  BinLocation,BinNumber,SerialNumber,Cost desc';
          Qry := DbSharedObj.GetQuery(connection.Connection, strSQL);(*getNewDataset(StrSQl, true) ;*)
          try
              if Qry.recordcount = 0 then exit;
              fiProductID     :=0;
              fiDeptID       :=0;
              fiUOMID         :=0;
              fsBatchNo       :='';
              fdExpirydate    :=0;
              fsBinLocation   :='';
              fsBinNumber     :='';
              fsSerialNumber  :='';
              fsMatrixREf     := '';
              showProgressbar(Qry.recordcount, 'Converting to Tree Mode');
              try

                {the following code is commented as when a stock adjustment with lines with 0 adjustment qty is saved and re-opend, it was opening blank }
                while Qry.eof = False do begin
                    stepProgressbar;
                    createPQA;
                    if (IsAllocationRec)   then begin
                      CreateBatch;
                      Createbins;
                      CreateSerialnumber;
                    end;
                  Qry.next;
                end;

                (*while qry.eof = False do begin
                  stepProgressbar;
                  if ((IsAllocationRec) and (Qry.FieldByName('AllocationAdjustQty').AsFloat <> 0)) or
                     (Qry.FieldByName('AdjustQty').AsFloat <> 0) then begin
                    {Qty with 0 adjustment can be ignored}
                    createPQA;
                    if ((IsAllocationRec) and (Qry.FieldByName('AllocationAdjustQty').AsFloat <> 0))  then begin
                      CreateBatch;
                      Createbins;
                      CreateSerialnumber;
                    end else begin
                      if IsAllocationRec then
                        if Qry.FindField('AllocnotAdjsuted') <> nil then begin
                          Qry.Edit;
                          Qry.FindField('AllocnotAdjsuted').AsBoolean := true;
                          QRy.Post;
                        end;
                    end;
                  end else begin
                    if Qry.FindField('notAdjsuted') <> nil then begin
                      Qry.Edit;
                      Qry.FindField('notAdjsuted').AsBoolean := true;
                      QRy.Post;
                    end;
                    if IsAllocationRec then
                      if Qry.FindField('AllocnotAdjsuted') <> nil then begin
                        Qry.Edit;
                        Qry.FindField('AllocnotAdjsuted').AsBoolean := true;
                        QRy.Post;
                      end;
                  end;
                  qry.next;
                end;*)
              finally
                HideProgressbar;
              end;
          finally
              (*if Qry.Active then qry.close;
              Freeandnil(qry);*)
              DbSharedObj.ReleaseObj(Qry);
          end;
          REsult := True;
          Dirty:= False;
        finally
          CreateTreeModeDataDone := true;
          if st.count >0 then begin
            //if devmode then logtext(st.text);
            st.SaveToFile(Commonlib.TempDir  + '\StockAdjutmentBinbatchissues.txt');
            ResultStatus.AddItem(True, rssInfo , 0 , 'There were incomplete Batch-bin-Serialised allocation adjustments. Please refer to '+quotedstr(Commonlib.TempDir  + '\StockAdjutmentBinbatchissues.txt') +' for details');
          end;
          Freeandnil(st);
        end;
  finally
    CreatingTreeModeData := False;
  end;
end;


function TStockAdjustEntry.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
    Result := inherited DoAfterInsert(Sender);
    if not result then exit;
    adjustmentdate := Now;
    CreationDate   := Date;
    Employee := Appenv.Employee.EmployeeName;
    AccountID := tcdatautils.AccountIDForName('Stock Adjustment');//TAccount.IDToggle('Stock Adjustment');
    EditDB;
end;
procedure TStockAdjustEntry.setPQATablename(const Value: String);
begin
  fsPQAtablename := Value;
  AppContext['SAETreeTableName'].VarByname['PQA'] := Value;
  Logtext ('2:appcontext PQA :' + AppContext['SAETreeTableName'].VarByname['PQA']);
end;
procedure TStockAdjustEntry.setPQADetailsTablename(const Value: String);
begin
  fsPQADetailstablename:= Value;
  AppContext['SAETreeTableName'].VarByname['PQADetail'] := Value;
  Logtext ('2:appcontext PQADetail :' + AppContext['SAETreeTableName'].VarByname['PQADetail']);
end;
procedure TStockAdjustEntry.setLinesProductstablename(const Value: String);
begin
  fsLinesProductstablename := Value;
  AppContext['SAETreeTableName'].VarByname['Line'] := Value;
  Logtext ('2:appcontext Line :' + AppContext['SAETreeTableName'].VarByname['Line']);
//  logtext('setLinesProductstablename=' + value);
end;

function TStockAdjustEntry.getLinesProductstablename: String;
begin
  if fsLinesProductstablename = '' then fsLinesProductstablename:= ReadLineTablename;
  result := fsLinesProductstablename;
end;

function TStockAdjustEntry.getPQADetailstablename: String;
begin
  if fsPQADetailstablename = '' then fsPQADetailstablename:= ReadPQADetailTablename ;
  Result := fsPQADetailstablename;
end;
function TStockAdjustEntry.getPQAtablename: String;
begin
  if fsPQAtablename = '' then fsPQAtablename:= ReadPQATablename ;
  REsult := fsPQAtablename;
end;

Function TStockAdjustEntry.CreateFlatModeData:Boolean;
var
  SQLList :TStringList;
  fbDoFieldChange :Boolean;
  fiProductId:Integer;
  ficlassId:Integer;
  fiUOMID :Integer;
  fsMatrixREf:String;
  Qry :TERPQuery;
begin
  result := True;
  SQLList :=TStringList.create;
  try
    SQLList.add('Select distinct SAELines.*,');
    SQLList.add('PQABatch.VALUE  as BatchNo, PQABatch.EXPIRYDATE   as ExpiryDate , ');
    SQLList.add('tblProductBin.binlocation, tblProductBin.binnumber, PQABins.Value as BinID, ');
    SQLList.add('PQASN.Value as Serialnumber,');
    SQLList.add('if(ifnull(PQASn.Qty,0) <> 0 ,PQASN.Qty,');
    SQLList.add('if(ifnull(PQAbins.Qty,0) <> 0 ,PQAbins.Qty,');
    SQLList.add('if(ifnull(PQAbatch.Qty,0) <> 0 , PQAbatch.Qty,0))) as Qty,');
    SQLList.add('if(ifnull(PQASn.UOMQty,0) <> 0 ,PQASN.UOMQty,');
    SQLList.add('if(ifnull(PQAbins.UOMQty,0) <> 0 ,PQAbins.UOMQty,');
    SQLList.add('if(ifnull(PQAbatch.UOMQty,0) <> 0 , PQAbatch.UOMQty,0))) as UOMQty');
    SQLList.add('from '+ReadLineTablename+' as SAELines');
    SQLList.add('Left join  '+ReadPQAtablename+' as PQA ');
    SQLList.add('on PQA.TransLineId = SAELines.STOCKADJUSTENTRYLINESID');
    SQLList.add('left join '+ReadPQADetailTablename+' as PQABatch on ');
    SQLList.add('PQABatch.PQAId = PQA.PQAID and PQABatch.ParentREf = "" ');
    SQLList.add('and PQABatch.PQAType = "BATCH"');
    SQLList.add('Left join '+ReadPQADetailTablename+' as PQAbins  ');
    SQLList.add('on PQAbins.PQAId = PQA.PQAID ');
    SQLList.add('and (PQAbins.ParentRef = "" or PQAbins.ParentRef = PQABatch.Globalref) ');
    SQLList.add('and PQABins.PQAType = "BIN"');
    SQLList.add('Left join '+ReadPQADetailTablename+' as PQASN  ');
    SQLList.add('on PQASN.PQAId = PQA.PQAID ');
    SQLList.add('and (PQASN.ParentRef = "" or PQASN.ParentRef = PQABatch.Globalref or PQASN.ParentREf = PQAbins.globalref) ');
    SQLList.add('and PQASN.PQAType = "SN" and ifnull(PQASN.Value , "")<> ""');
    SQLList.add('Left join tblProductBin on  tblProductBin.binId = PQAbins.value');
    SQLList.add('Where SAELines.StockAdjustEntryId = '+IntToStr(ID));
    Lines.DeleteAll;
    Qry := DbSharedObj.GetQuery(connection.Connection , SQLList.Text);
    Try
    With (*getNewdataset(SQLList,true)*)Qry do begin
      if recordcount = 0 then Exit;
      First;
      fbDoFieldChange := Lines.DoFieldChange;
      try
        fiProductID :=0;
        fiClassId :=0;
        fiUOMID := 0;
        fsMatrixREf:= '';
        while eof = False do begin
          Lines.New;
          Lines.dofieldchange         := False;
          Lines.ProductID             := FieldByname('ProductId').asInteger;
          Lines.Productname           := FieldByname('ProductName').AsString;
          Lines.Description           := FieldByname('Description').AsString;
          Lines.ProductPrintName      := FieldByname('ProductPrintName').AsString;
          Lines.DeptID                := FieldByname('ClassId').asInteger;
          Lines.DeptName              := FieldByname('Classname').AsString;
          Lines.JobID                 := FieldByname('JobID').asInteger;
          Lines.JobName               := FieldByname('JobName').AsString;
          Lines.AccountID             := FieldByname('AccountID').asInteger;
          Lines.AccountName           := FieldByname('AccountName').AsString;
          Lines.AvailableQty          := FieldByname('AvailableQty').asFloat;
          Lines.AvailableUOMQty       := FieldByname('AvailableUOMQty').asFloat;
          Lines.InstockQty            := FieldByname('InstockQty').asFloat;
          Lines.InstockUOMQty         := FieldByname('InstockUOMQty').asFloat;
          Lines.MatrixRef             := FieldByname('MatrixRef').AsString;
          Lines.MatrixDesc            := FieldByname('MatrixDesc').asString;
          Lines.MatrixPrice           := FieldByname('MatrixPrice').asFloat;
          Lines.Notes := FieldByname('Notes').asString;

          if (fiProductID =FieldByname('ProductId').asInteger) and (fiClassId =FieldByname('ClassId').asInteger)  and (fsMatrixREf = Fieldbyname('MatrixREf').asString) and
            ((EnforceUOM = False) or (fiUOMId = FieldByname('UOMID').asInteger)) then begin
           if AdjustmentOnInstock then
            Lines.FinalQty              := Lines.AvailableQty
           else Lines.FinalQty          := Lines.InstockQty ;
           Lines.AdjustQty              := 0;

           if AdjustmentOnInstock then
            Lines.FinalUOMQty           := Lines.AvailableUOMQty
           else Lines.FinalUOMQty       := Lines.InstockUOMQty ;
           Lines.AdjustUOMQty           := 0;

          end else begin
            fiProductID :=FieldByname('ProductId').asInteger;
            fiClassId   :=FieldByname('ClassId').asInteger;
            fiUOMId     := FieldByname('UOMID').asInteger;
            fsMatrixREf := FieldByname('MatrixREf').asString;
            Lines.FinalQty              := FieldByname('FinalQty').asFloat;
            Lines.AdjustQty             := FieldByname('AdjustQty').asFloat;
            Lines.FinalUOMQty           := FieldByname('FinalUOMQty').asFloat;
            Lines.AdjustUOMQty          := FieldByname('AdjustUOMQty').asFloat;
          end;
          Lines.COST                  := FieldByname('COST').asFloat;
          Lines.UOM                   := FieldByname('UOM').AsString;
          Lines.UOMMULTIPLIER         := FieldByname('UOMMULTIPLIER').asFloat;
          Lines.Deleted               := FieldByname('DELETED').asBoolean;
          Lines.UOMID                 := FieldByname('UOMID').asInteger;
          Lines.BatchNo               := FieldByname('BatchNo').AsString;
          Lines.ExpiryDate            := FieldByname('ExpiryDate').aSDatetime;
          Lines.binlocation           := FieldByname('binlocation').AsString;
          Lines.binnumber             := FieldByname('binnumber').AsString;
          if FieldByname('BinID').AsString <> '' then
            Lines.BinID                 := FieldByname('BinID').asInteger;
          Lines.Serialnumber          := FieldByname('Serialnumber').AsString;
          Lines.allocationadjustQty   := FieldByname('Qty').asFloat;
          Lines.AllocationAdjustUOMQty:= FieldByname('UOMQty').asFloat;
          Lines.calcAllocAvailableQty;
          if AdjustmentOnInstock then begin
            Lines.AllocationFinalqty    := Lines.AllocationAvailableQty + Lines.AllocationAdjustQty;
            Lines.AllocationFinalUOMqty := Lines.AllocationAvailableUOMQty + Lines.AllocationAdjustUOMQty;
          end else begin
            Lines.AllocationFinalqty    := Lines.AllocationInStockQty + Lines.AllocationAdjustQty;
            Lines.AllocationFinalUOMqty := Lines.AllocationInstockUOMQty + Lines.AllocationAdjustUOMQty;
          end;
          Lines.PostDB;
        Next;
      end;
      Finally
            Lines.DoFieldChange := fbDoFieldChange;
      end;
    end;
    finally
      (*if active then close;
      Free;*)
      DbSharedObj.ReleaseObj(qry);
      //DeleteSAELineTables;
    end;
    REsult := True;
    Dirty := false;
  finally
     FreeandNil(SQLList);
  end;
end;

Procedure TStockAdjustEntry.DeleteSAELineTables;
var
  strSQL: String;
begin
      strSQL := '';
      if ReadLineTablename <> '' then
        strSQL := strSQL + 'Drop table if exists ' + ReadLineTablename+';';
      if ReadPQAtablename <> '' then
        strSQL := strSQL + 'Drop table if exists ' + ReadPQAtablename+';';
      if ReadPQADetailTablename <> '' then
        strSQL := strSQL + 'Drop table if exists ' + ReadPQADetailTablename+';';
      try
        if strSQL <> '' then begin
          logtext('3: Tables deleted ' + NL+StrSQL);
          ExecuteSQL(strSQL , false);
        end;
        //GetNewDataset(strSQL, False); // drop should be outside transaction
      Except {kill the exception} End;
      if AppContext['SAETreeTableName'].VarExists('Line')       then AppContext['SAETreeTableName'].DeleteVar('Line');
      if AppContext['SAETreeTableName'].VarExists('PQADetail')  then AppContext['SAETreeTableName'].DeleteVar('PQADetail');
      if AppContext['SAETreeTableName'].VarExists('PQA')        then AppContext['SAETreeTableName'].DeleteVar('PQA');
end;

function TStockAdjustEntry.Process: Boolean;
//var
//  EntryXML:String;
begin
  if fbprocessing then begin
    REsult := True;
    Exit;
  end;
  fbprocessing := true;
  try
  if Processed then begin
    ResultStatus.AddItem(True, rssInfo , 0 , 'This record is already Processed. Cannot Process it again');
      REsult := True;
      Exit;
  end;
  Result := False;
  DoShowProgressbar(6 , 'Processing :' + CountCaption);
  try
    if not inTreemode then begin
      if not CreateTreeModeData then exit;
    end;
    if Connection.Connection.InTransaction then  begin
      if not Save then Exit;
      Connection.CommitTransaction;
    end;
    DoStepProgressbar('Saved ... Creating PQA');
    fbProcessing := True;
    try
      DoStepProgressbar('PQA Created .... Processing');
      self.LineProducts.Dataset.Close;
      self.LineProducts.Dataset.Open;
      if StockMovement.count = 0 then begin
        StockMovement.Connection.BeginTransaction;
        if CloneBusObj('', '' , False, '') = nil then exit;
        SilentMode := False;
        DoStepProgressbar('PQA Created .... Saving');
        if not StockMovement.Save then begin
          result := False;
          StockMovement.Connection.RollbackTransaction;
          Exit;
        end;
        DoStepProgressbar('Processed .... Finalising');
        Self.Processed:= True;
        Self.PostDB;
        StockMovement.Connection.CommitTransaction;
        ShowProgressbar(StockMovement.Lines.count, 'Updating Average Cost');
        StockMovement.Lines.IterateREcords(UpdateAvgcost);
        DoStepProgressbar('Done');
        HideProgressbar;
      end;
    finally
        fbProcessing := False;
    end;
    REsult := True;
  finally
    DoHideProgressbar;
  end;
  finally
    fbprocessing := False;
    Connection.BeginTransaction;
  end;
end;

Procedure TStockAdjustEntry.checkAlloctype(Const Sender: TBusObj; var Abort: boolean);
begin
    if (Sender is TStockMovementLines) then begin
      TStockMovementLines(Sender).PQA.IterateRecords(checkAlloctype);
    end else if (Sender is TPQA) then begin
      TPQA(Sender).Alloctype := 'IN';
      TPQA(Sender).Qty := TPQA(Sender).Qty;
      TPQA(Sender).UOMQty := TPQA(Sender).UOMQty;
      TPQA(Sender).PostDB;
    end;
end;
procedure TStockAdjustEntry.UpdateAvgcost(const Sender: TBusObj;var Abort: boolean);
var
    msg :String;
begin
    stepProgressbar;
    if TStockMovementLines(Sender).Product.Lock then begin
      Try
          //TStockMovementLines(Sender).Product.UpdateAvgCosts;
          TProduct.UpdateAvgCosts(TStockMovementLines(Sender), TStockMovementLines(Sender).Connection , TStockMovementLines(Sender).Product.ID);
      Finally
          TStockMovementLines(Sender).Product.Unlock;
      end;
    end else begin
      msg := 'Unable to update ' + TStockMovementLines(Sender).Product.ProductName + '''s cost record as product is being updated by "' +
          TStockMovementLines(Sender).Product.UserLock.LockInfo.UserName + '" with: ' + TStockMovementLines(Sender).Product.UserLock.LockInfo.LockingForm;
      ResultStatus.AddItem(true, rssWarning, 1, msg, False);
    end;
end;

function TStockAdjustEntry.GetCleanDeleted: Boolean;
begin
  Result:= GetXMLNodeBooleanValue(CleanXMLNode, 'Deleted');
end;

function TStockAdjustEntry.Lock(): Boolean;
begin
  { use an ID of 0 to only allow one person to create a stock adjustment at
    any one time }
  UserLock.Enabled:= true;
  result:= UserLock.Lock(BusObjectTableName, ID, BusObjectTypeDescription);
end;

procedure TStockAdjustEntry.DeleteFlagedLines;
var
  IsFiltered: boolean;
  TempAccessLevel: integer;
  deleteEmptylines:Integer;


  Function LinesWithZeroQtyExists :Boolean ;
  var
    Qry:TERPQuery;
  begin
      Qry := DbSharedObj.GetQuery(Connection.connection);
      try
        With qry do begin
          SQL.Text := 'Select count(StockAdjustEntryLinesID) as ctr '+
                           ' from '  +Lines.BusObjectTableName +
                           ' where ifnull(AdjustQty,0)            = 0 '+
                           ' and ifnull(AdjustUOMQty,0)           = 0 '+
                           ' and ifnull(AllocationAdjustUOMQty,0) = 0 '+
                           ' and ifnull(AllocationAdjustQty,0)    = 0 '+
                           ' and ifnull(Deleted , "F")            = "F"' ;
          open;
          result := fieldByname('ctr').asInteger <> 0;
        end;
      finally
          DbSharedObj.ReleaseObj(qry);
      end;
  end;
begin
  TempAccessLevel:= AccessManager.AccessLevel;
  try
    AccessManager.AccessLevel:= 1;
      if ReadLineTablename <> '' then begin
        LineProducts.Dataset.DisableControls;
        IsFiltered := LineProducts.Dataset.Filtered;
        LineProducts.Dataset.Filtered := false;
        if LineProducts.Count > 0 then begin
          LineProducts.First;
          showProgressbar(lineProducts.count, 'Delete Flagged lines');
          while not LineProducts.Dataset.Eof do begin
            stepProgressbar;
            if LineProducts.Deleted then begin
              LineProducts.PQA.Delete;
              LineProducts.Delete;
            end else LineProducts.Dataset.Next;
          end;
          HideProgressbar;
          LineProducts.Dataset.Filtered := IsFiltered;
        end;
        LineProducts.Dataset.EnableControls;
      end;
      Lines.Dataset.DisableControls;
      IsFiltered := Lines.Dataset.Filtered;
      Lines.Dataset.Filtered := false;
      if LinesWithZeroQtyExists = False then deleteEmptylines := mrNo
      else
        if assigned(confirmFromGUI) then
          deleteEmptylines :=fconfirmFromGUI('Do you wish to delete the Lines with 0 adjustment?' , [mbYes,mbNo])
        else deleteEmptylines :=mrNo;

      if Lines.Count > 0 then begin
        Lines.First;
        ShowProgressbar(Lines.count, 'Delete Flagged Lines');
        while not Lines.Dataset.Eof do begin
          stepProgressbar;
          if (Lines.Deleted) or
            ((deleteEmptylines = mryes) and (Lines.AdjustQty =0) and (Lines.AdjustUOMQty=0) and
             (Lines.AllocationAdjustUOMQty =0) and (Lines.AllocationAdjustQty =0) and (Lines.UnitOfMeasureID <> -1)) then begin
            Lines.Delete;
          end else Lines.Dataset.Next;
        end;
        HideProgressbar;
        Lines.Dataset.Filtered := IsFiltered;
      end;
      Lines.Dataset.EnableControls;
  finally
      AccessManager.AccessLevel:= TempAccessLevel;
  end;

end;

function TStockAdjustEntry.getStockMovement: TStockMovement;
begin
  result := TStockMovement(getcontainercomponent(TStockMovement, 'StockmovementEntryglobalref = ' +quotedStr(Self.Globalref) +' and StockmovementEntryType =' + QuotedStr(XMLNodeName) ));
  result.ShowStatus      := ShowStatus;
  result.Rawmode := True;
end;

function TStockAdjustEntry.GetTotalCostEx: double;
var
  qry: TERPQuery;
begin

  qry := DbSharedObj.GetQuery(Connection.Connection);
  try
    qry.SQL.Add('select sum(Cost * AdjustQty) as TotalCostEx');
    if LineProductsAssigned then
      qry.SQL.Add('from ' + LinesProductstablename)
    else
      qry.SQL.Add('from tblstockadjustentrylines');
    qry.SQL.Add('where StockAdjustEntryID = ' + IntToStr(self.ID));
    qry.SQL.Add('and Deleted = "F"');
    qry.Open;
    result := Abs(Round(qry.FieldByName('TotalCostEx').AsFloat,RoundPlacesGeneral));
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TStockAdjustEntry.AssignAccountID(const Sender: TBusObj;
  var Abort: boolean);
begin
  stepProgressbar;
  if (Sender is TSAELinesFlat) then begin
    TSAELinesFlat(Sender).AccountId := AccountID;
    TSAELinesFlat(Sender).PostDB;
  end else if Sender is TSAELinesTree then begin
    TSAELinesTree(Sender).AccountId := AccountID;
    TSAELinesTree(Sender).PostDB;
  end;

end;

class function TStockAdjustEntry.Transtype: String;
begin
  REsult := 'Stock Adjustment';
end;


procedure TStockAdjustEntry.GetPropertyXMLCallback(const Sender: TBusObj;
  var Abort: boolean);
begin
  stepProgressbar;
  inherited;

end;

procedure TStockAdjustEntry.CreateInstance;
begin
  inherited;
  if fbProcessing then begin
    ObjInstanceToClone := StockMovement;
  end;
end;

function TStockAdjustEntry.CloneBusObj(const Changefield: String;
  const ChangeValue: Variant; const SaveAfterCopy: Boolean;
  const FilterFields: String): TBusObj;
begin
    Result := inherited CloneBusObj(ChangeField, changeValue, SaveAfterCopy,FilterFields);
    if Result = nil then Exit;
    Result := ObjInstanceToClone;
    TStockMovement(REsult).MovementDate :=AdjustmentDate;
    TStockMovement(REsult).postDB;
end;

procedure TStockAdjustEntry.ClonePropertyObjects;
begin
  inherited;
  showProgressbar(LineProducts.count, 'Processing');
  try
    LineProducts.IterateRecords(CloneLines);
  finally
      HideProgressbar;
  end;
end;

procedure TStockAdjustEntry.CloneLines(const Sender: TBusObj;  var Abort: boolean);
begin
  stepProgressbar;//(LineProducts.Productname + '->' +  MemoryStatusDetails);
  Sender.CloneBusObj('' , '', False);
  if Sender.ObjInstanceToClone  = nil then begin
    fbObjectCopied := False;
    Exit;
  end else begin
    if (Sender.ObjInstanceToClone is TStockMovementLines) and (Sender is TSAELinestree) then begin
      TStockMovementLines(Sender.ObjInstanceToClone).SMELineGlobalref :=TSAELinestree(Sender).GlobalRef;
      TStockMovementLines(Sender.ObjInstanceToClone).PostDB;
    end;
  End;
end;

function TStockAdjustEntry.getImportgroupOriginalno: String;
begin
  Result := getStringfield('ImportgroupOriginalno');
end;

procedure TStockAdjustEntry.setImportgroupOriginalno(const Value: String);
begin
  SetStringfield('ImportgroupOriginalno' , Value);
end;
function TStockAdjustEntry.getAdjusttype: String;
begin
  Result := getStringfield('Adjusttype');
end;

procedure TStockAdjustEntry.setAdjusttype(const Value: String);
begin
  SetStringfield('Adjusttype' , Value);
end;

Function TStockAdjustEntry.AutoAdjusttoDefaultBin(DefaultBinID:Integer; const fProductID:Integer ; const fClassID:Integer; AssignUnallocatedasWell:boolean; AdjustBatchno:String):String;
var
  bbatch,bbin, bsn :Boolean;
  ProgressDialog: TProgressDialog;
  //StockAdjust:TStockAdjustEntry;
  Originalno :String;
  ctr:Integer;
  Qry :TERPQuery;
  fiBinID:Integer;
  Procedure NewStock;
  begin
    postdb;
    New;
    EnforceUOM := True;
    AdjustmentOnInstock := False;
    AdjustmentDate := Now;
    PostDB;
    if Originalno = '' then Originalno := globalref;
    ImportgroupOriginalno := Originalno;
    PostDB;
    Lines.DoFieldChangewhenDisabled := true;
  end;
  function LocateLine(ClassID,UOMID,ProductID:Integer; BatchNo:String; Expirydate:TDateTime; binId:Integer; SerialNumber:String):Boolean;
  begin
       if expirydate =0 then
          result := Lines.locate('ClassID;UOMID;ProductID;BatchNo;binId;SerialNumber' ,
                            vararrayof([ClassID,UOMID,ProductID,BatchNo,binId,SerialNumber]), [])
       else
        result := Lines.locate('ClassID;UOMID;ProductID;BatchNo;expirydate;binId;SerialNumber' ,
                            vararrayof([ClassID,UOMID,ProductID,BatchNo,expirydate,binId,SerialNumber]), []);
  end;

begin
  //if AdjustBatchno = '' then AdjustBatchno :='Auto Adjust - ' +formatDateTime(FormatSettings.shortDAteformat , now);
  if tcdatautils.AccountIDForName('Stock Adjustment')= 0 then begin
      CommonLib.MessageDlgXP_Vista('Auto Adjust failed - Stock Adjustment Account Entry is missing.' , mtInformation , [mbok], 0);
      Exit;
  end;

  Originalno := '';
  result:= '';
  TProduct.checkAllocation(fProductID, bbatch,bbin, bsn);
  if bbin=False  then begin
    CommonLib.MessageDlgXP_Vista('The product is not using Bin' , mtInformation , [mbok], 0);
    exit;
  end;

  Qry := commonDBLib.TempMyQuery;
    try

      Qry.Connection :=Connection.Connection ;
      Qry.SQL.Clear;
      Qry.SQL.text := ProductQtyLib.StockQtyDetailswithSno(False , fProductID, fClassID );
      Qry.open;
      if (Lines.count=0)  then begin
        Lines.PostDB;
        PostDB;
        NewStock;
      end;
      With Qry do begin
            ProgressDialog := TProgressDialog.Create(nil);
            try
              ProgressDialog.Caption := 'Please Wait .......';
              ProgressDialog.MinValue := 0;
              ProgressDialog.MaxValue := recordcount;
              ProgressDialog.Step := 1;
              ProgressDialog.Execute;
              first;
              ctr:= 0;

              While Eof = False do begin
                  fiBinID:= tcdatautils.GetBinID(fieldbyname('Binlocation').AsString,fieldbyname('Binnumber').AsString , fieldbyname('DepartmentID').AsInteger);
                  if DefaultBinID <> fiBinId then begin
                    if not (LocateLine(fieldByname('DepartmentId').asInteger,
                                        FieldByname('UOMID').asInteger,
                                        Fieldbyname('PartsID').asInteger,
                                        Fieldbyname('batchnumber').AsString,
                                        Qry.fieldbyname('batchExpirydate').AsDateTime,
                                        fibinId,
                                        FieldByname('Serialnumber').AsString )) then begin
                      Lines.New;
                      Lines.ProductID  := Fieldbyname('PartsID').asInteger;
                      Lines.DeptID     := fieldByname('DepartmentId').asInteger;
                      Lines.UOM        := fieldByname('UOM').asString;
                      Lines.UOMID      := FieldByname('UOMID').asInteger;
                      if bbatch then begin
                        Lines.Batchno  := Fieldbyname('batchnumber').AsString;
                        if fieldbyname('batchExpirydate').AsDateTime <> 0 then
                          Lines.Expirydate := Fieldbyname('batchExpirydate').AsDateTime;
                      end;
                      Lines.binId      := fibinId;
                      Lines.SerialNumber := FieldByname('Serialnumber').AsString;
                    Lines.AllocationAdjustQty := (*Lines.AllocationAdjustQty*)0 - FieldByname('Qty').asFloat; // this is the available qty.
                    end else begin
                    Lines.AllocationAdjustQty := Lines.AllocationAdjustQty - FieldByname('Qty').asFloat; // this is the available qty.
                    end;
                    Lines.PostDB;
                    if not DeleteLineif0Qty then ctr:= ctr+1;

                    if not (LocateLine(fieldByname('DepartmentId').asInteger,
                                        FieldByname('UOMID').asInteger,
                                        Fieldbyname('PartsID').asInteger,
                                        Fieldbyname('batchnumber').AsString,
                                        Qry.fieldbyname('batchExpirydate').AsDateTime,
                                        DefaultbinId,
                                        FieldByname('Serialnumber').AsString )) then begin
                      Lines.New;
                      Lines.ProductID  := Fieldbyname('PartsID').asInteger;
                      Lines.DeptID     := fieldByname('DepartmentId').asInteger;
                      Lines.UOM        := fieldByname('UOM').asString;
                      Lines.UOMID      := FieldByname('UOMID').asInteger;
                      if bbatch then begin
                        Lines.Batchno  := Fieldbyname('batchnumber').AsString;
                        if fieldbyname('batchExpirydate').AsDateTime <> 0 then
                          Lines.Expirydate := Fieldbyname('batchExpirydate').AsDateTime;
                      end;
                      Lines.binId      := DefaultbinId;
                      Lines.SerialNumber := FieldByname('Serialnumber').AsString;
                    Lines.AllocationAdjustQty := (*Lines.AllocationAdjustQty +*)FieldByname('Qty').asFloat; // this is the available qty.
                    end else begin
                    Lines.AllocationAdjustQty := Lines.AllocationAdjustQty +FieldByname('Qty').asFloat; // this is the available qty.
                    end;
                    Lines.PostDB;

                    if not DeleteLineif0Qty then ctr:= ctr+1;
                    if ctr >= 400 then begin
                      Lines.PostDB;
                      PostDB;
                      NewStock;
                      ctr:= 0;
                    end;
                  end;
                ProgressDialog.StepIt;
                Next;
              end;
              if AssignUnallocatedasWell then begin
                if Originalno = '' then Originalno := globalref;
                AutoAdjustBin(inttostr(fProductID), inttostr(fClassID),'' , AdjustBatchno , Originalno , self);
              end;
            finally
                ProgressDialog.CloseDialog;
                Freeandnil(ProgressDialog);
            end;
            result := Originalno;
            (*StockAdjust.Connection.CommitTransaction;*)
      end;
    Except
      on E:Exception do begin
        CommonLib.MessageDlgXP_Vista('Auto Adjust bin Stock Failed'+ chr(13) + chr(13) + E.Message , mtWarning, [mbok], 0);
        result :='';
      end;
    end;
  (*finally
      StockAdjust.Free;
      if Qry.active then Qry.close;
      Freeandnil(Qry);
  end;*)

end;
function TStockAdjustEntry.DeletelineIf0Qty:Boolean;
begin
  REsult := False;
    if (Lines.AdjustQty=0) and
       (Lines.AdjustUOMQty=0) and
       (Lines.AllocationAdjustQty=0) and
       (Lines.AllocationAdjustUOMQty=0) then begin
        Lines.Delete;
        Result := True;
    end;

end;
//class function TStockAdjustEntry.AutoAdjustBin(const fProductID:Integer =0; const fClassID:Integer=0 ; fFilter:String=''; AdjustBatchno:String = ''; SAOriginalno:String = '';fStockAdjust:TStockAdjustEntry=nil; SelectGrid: TwwDbGrid = nil; Emptybin:Boolean =False):String;
class function TStockAdjustEntry.AutoAdjustBin(const fProductIDs:String =''; const fClassIDs:String ='' ; fFilter:String=''; AdjustBatchno:String = ''; SAOriginalno:String = '';fStockAdjust:TStockAdjustEntry=nil; SelectGrid: TwwDbGrid = nil; Emptybin:Boolean =False):String;
var
  bbatch,bbin, bsn :Boolean;
  ProgressDialog: TProgressDialog;
  StockAdjust:TStockAdjustEntry;
  Originalno :String;
  ctr:Integer;
  Qry: TDataset; // TERPQuery;
  SelItem: integer;

  function Productfilter:String;
  begin
    result := '';
      (*if fProductID <> 0 then *)if fProductIDs <> '' then result := result  + ' and PQA.ProductId  in   ( ' +fProductIDs +')';
      (*if fClassID   <> 0 then *)if fClassIDs   <> '' then result := result  + ' and PQA.DepartmentId in ( ' +fClassIDs+')';
      if fFilter <> '' then result := result  + ' and ( ' +ffilter +')';
  end;

  Procedure UpDateBatchFrombin;
  var
    tablename :String;
    s, idList: String;
  begin
    tablename := GetUserTemporaryTableName('UpDateBatchFrombin');
    s:= 'Drop table if exists ' + tablename +' ; '+
        ' create table ' + tablename +'  engine myisam '+
        ' Select '+
                      ' Batch.PQADetailID, Batch.Qty batchQty, sum(bin.Qty) binQty  , sum(bin.uomQty) binUomQty '+
                      ' from '+
                      ' tblpqadetails Batch '+
                      ' inner join tblpqadetails bin on Batch.PQAId = bin.PQAId and Batch.GlobalRef = ifnull(bin.ParentRef , "") and bin.PQAType = "Bin" '+
                      ' where Batch.PQAType = "Batch" '+
                      ' group by PQADetailID ; ';
    StockAdjust.ExecuteSQL(s , False);

    with TempMyQuery(TERPConnection(StockAdjust.Connection.Connection)) do begin
      try
        SQL.Add('select distinct T.PQADetailID from ' + tablename + ' T');
        SQL.Add('inner join tblPQADEtails Batch on Batch.PQADetailID = T.PQADetailID ');
        SQL.Add('where round(Batch.Qty,0) <> round(T.binQty,0)');
        Open;
        idList:= GroupConcat('PQADetailID');
      finally
        Free;
      end;

    end;
    if idList <> '' then begin

      s:= ' update  tblpqadetails Batch ' +
                      ' inner join  ' + tablename +' T on Batch.PQADetailID = T.PQADetailID ' +
                      ' Set Batch.Qty = T.binQty, Batch.uomQty = t.binUomQty  ' +
                      ' where T.PQADetailID in (' + idList + ')';

      StockAdjust.executeSQL(s, true);
    end;
    (*s:= 'Drop table if exists ' + tablename +' ; ';
    StockAdjust.ExecuteSQL(s , False);*)
    TAfterTransList.Inst.AddAfterTransSQL(TERPConnection (StockAdjust.Connection.Connection), 'drop table if exists ' + tablename + ';');
    //Logtext(Tablename);
  end;

  Procedure NewStock;
  begin
    StockAdjust.pOSTdb;
    StockAdjust.New;
    StockAdjust.EnforceUOM := True;
    StockAdjust.AdjustmentOnInstock := True;
    StockAdjust.AdjustmentDate := Now;
    StockAdjust.PostDB;
    if Originalno = '' then Originalno := StockAdjust.globalref;
    StockAdjust.ImportgroupOriginalno := Originalno;
    StockAdjust.PostDB;
    StockAdjust.Lines.DoFieldChangewhenDisabled := true;
  end;

  Procedure MakeStockAdjustObj;
  begin
    if fStockAdjust = nil then begin
      StockAdjust:= TStockAdjustEntry.create(Nil);
      StockAdjust.connection := TMyDacDataConnection.create(StockAdjust);
      StockAdjust.Connection.Connection := CommonDbLib.GetNewMyDacConnection(StockAdjust);
      StockAdjust.Connection.BeginTransaction;
    end else begin
      StockAdjust := fStockAdjust;
      StockAdjust.Connection.BeginnestedTransaction;
    end;
  end;
  function Locateline(ProductID,ClassID,UOMID:Integer; BatchNo:String; binID:Integer):boolean;
  begin
    result := StockAdjust.Lines.locate('ClassID;UOMID;ProductID;BatchNo;binId' ,vararrayof([ClassID,UOMID,ProductID,BatchNo,binId]), []);
  end;
begin
  if SAOriginalno <> '' then Originalno := SAOriginalno;
  if AdjustBatchno = '' then AdjustBatchno :='Auto Adjust - ' +formatDateTime(FormatSettings.shortDAteformat , now);
  if tcdatautils.AccountIDForName('Stock Adjustment') = 0 then begin
      CommonLib.MessageDlgXP_Vista('Auto Adjust failed - Stock Adjustment Account Entry is missing.' , mtInformation , [mbok], 0);
      Exit;
  end;

  Originalno := '';
  result:= '';
  TProduct.checkAllocation(bbatch,bbin, bsn);
  if bbin=False  then begin
    CommonLib.MessageDlgXP_Vista('None of the product is using Bin.  Auto Adjust not possible.' , mtInformation , [mbok], 0);
    exit;
  end;

  if Assigned(SelectGrid) then
    Qry := SelectGrid.DataSource.DataSet
  else
    Qry := commonDBLib.TempMyQuery;
  MakeStockAdjustobj;
  try
    try
      if not Assigned(SelectGrid) then
        TERPQuery(Qry).Connection :=StockAdjust.Connection.Connection ;

      UpdateBatchFromBin;

      if not Assigned(SelectGrid) then begin
        TERPQuery(Qry).SQL.Clear;
        TERPQuery(Qry).SQL.text := UnallocatedBinQty(Productfilter, Emptybin);
        Qry.open;
        if Qry.recordcount = 0 then begin
          //commonLib.MessageDlgXP_Vista('Un allocated Qty not found for Product/Classes with default bin assigned.'+chr(13)+chr(13)+'Only Bin Products Where Batch Is Not Enabled Can Be Adjusted From Auto-Adjust.' , mtWarning, [mbok],0);
          Exit;
        end;
      end;
      if Assigned(fstockAdjust) then begin
        ctr:=fstockAdjust.lines.count;
        if ctr > 400 then
          newStock;
      end
      else
        NewStock;

      With Qry do begin
            ProgressDialog := TProgressDialog.Create(nil);
            try
              ProgressDialog.Caption := 'Please Wait .......';
              ProgressDialog.ShowPercent:= False;
              ProgressDialog.MinValue := 0;
              if Assigned(SelectGrid) then
                ProgressDialog.MaxValue := SelectGrid.SelectedList.Count
              else
                ProgressDialog.MaxValue := recordcount;
              ProgressDialog.Step := 1;
              ProgressDialog.Execute;
              first;
              ctr:= 0;
              SelItem := 0;

              While (Assigned(SelectGrid) and (SelItem < SelectGrid.SelectedList.Count)) or ((not Assigned(SelectGrid)) and (Eof = False)) do begin
                if Assigned(SelectGrid) then Qry.GotoBookmark(SelectGrid.SelectedList[SelItem]);

                if Locateline(Fieldbyname('ProductID').asInteger , fieldByname('DepartmentId').asInteger, FieldByname('UOMID').asInteger, AdjustBatchno, Fieldbyname('DefaultbinId').asInteger)= false  then begin
                  StockAdjust.Lines.New;
                  StockAdjust.Lines.ProductID  := Fieldbyname('ProductID').asInteger;
                  StockAdjust.Lines.DeptID     := fieldByname('DepartmentId').asInteger;
                  StockAdjust.Lines.UOM        := fieldByname('UOM').asString;
                  StockAdjust.Lines.UOMID      := FieldByname('UOMID').asInteger;
                  if Fieldbyname('batch').asBoolean then
                    StockAdjust.Lines.Batchno := AdjustBatchno;
                  StockAdjust.Lines.binId      := Fieldbyname('DefaultbinId').asInteger;
                end;
                if not Emptybin then begin
                  StockAdjust.Lines.AllocationAdjustQty := StockAdjust.Lines.AllocationAdjustQty  +FieldByname('Qtydiff').asFloat;//round(Fieldbyname('Qty').asFloat - fieldbyname('bQty').asfloat , tcConst.GeneralRoundPlaces);
                end else begin
                  StockAdjust.Lines.AllocationfinalQty := 0;
                end;

                StockAdjust.Lines.PostDB;
                if not StockAdjust.DeleteLineif0Qty then ctr:= ctr+1;
                if ctr >= 400 then begin
                  StockAdjust.Lines.PostDB;
                  StockAdjust.PostDB;
                  NewStock;
                  ctr:= 0;
                end;
                ProgressDialog.Message := inttostr(recno)+' of ' + inttostr(recordcount)+' Products -> ' +quotedstr(Fieldbyname('Productname').AsString);
                ProgressDialog.StepIt;
                if Assigned(SelectGrid) then
                  Inc(SelItem)
                else
                  Next;
              end;
            finally
                ProgressDialog.CloseDialog;
                Freeandnil(ProgressDialog);
            end;
            result := Originalno;
            if fStockAdjust = nil then StockAdjust.Connection.CommitTransaction else StockAdjust.Connection.commitNestedTransaction;
      end;
    Except
      on E:Exception do begin
        CommonLib.MessageDlgXP_Vista('Auto Adjust bin Stock Failed'+ chr(13) + chr(13) + E.Message , mtWarning, [mbok], 0);
        result :='';
      end;
    end;
  finally
    if fStockAdjust = nil then freeandnil(StockAdjust);
    if not Assigned(SelectGrid) then begin
      if Qry.active then Qry.close;
      Freeandnil(Qry);
    end;
  end;
end;

class function TStockAdjustEntry.CreateStockAdjust(const fProductID:Integer ; const fClassID:Integer ;  const fQty :double; const fuom:String; const fIsQtyFromStock:boolean; const fBatchno:String = ''; const fexpirydate:Tdatetime=0; const fbinlocation:String='' ;const fbinnumber:String=''; const fserialnumber:String = ''):Integer;
var
  StockAdjust :TStockAdjustEntry;
begin
  Result:= 0;
  StockAdjust:= TStockAdjustEntry.create(Nil);
  try
  StockAdjust.connection := TMyDacDataConnection.create(StockAdjust);
  StockAdjust.Connection.Connection := CommonDbLib.GetNewMyDacConnection(StockAdjust);
  StockAdjust.Connection.BeginTransaction;
  try
    StockAdjust.pOSTdb;
    StockAdjust.New;
    StockAdjust.EnforceUOM := True;
    StockAdjust.AdjustmentOnInstock := True;
    StockAdjust.AdjustmentDate := Now;
    StockAdjust.AdjustmentOnInstock := fIsQtyFromStock;
    StockAdjust.EnforceUOM := True;
    StockAdjust.PostDB;
    StockAdjust.Lines.DoFieldChangewhenDisabled := true;
    StockAdjust.Lines.New;
    StockAdjust.Lines.ProductId := fProductID;
    StockAdjust.Lines.DeptID:= fClassId;
    StockAdjust.Lines.UOM := fUOM;
    if (fBatchno= '') and (fbinlocation='')  and (fserialnumber='') then begin
      StockAdjust.Lines.AdjustQty := fQty;
    end else begin
      StockAdjust.Lines.BatchNo:= fBatchno;
      StockAdjust.Lines.ExpiryDate := fexpirydate;
      StockAdjust.Lines.BinLocation := fbinlocation;
      StockAdjust.Lines.BinNumber := fbinnumber;
      StockAdjust.Lines.SerialNumber := fserialnumber;
      StockAdjust.Lines.AllocationAdjustQty := 0-fQty;
    end;
    StockAdjust.Lines.PostDb;
    if StockAdjust.Save then begin
      StockAdjust.Connection.CommitTransaction;
      REsult := StockAdjust.ID;
    end;
    Except
      on E:Exception do begin
        CommonLib.MessageDlgXP_Vista('Auto Adjust bin Stock Failed'+ chr(13) + chr(13) + E.Message , mtWarning, [mbok], 0);
        result :=0;
      end;
    end;
  finally
    Freeandnil(StockAdjust);
  end;
end;
{ TStockAdjustEntryPQA }
constructor TStockAdjustEntryPQA.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM ' + REadPQATablename;
  FieldsnotToclone := 'UOMNameProductKey';
end;

function TStockAdjustEntryPQA.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
    REsult := inherited DoAfterInsert(Sender);
    if not result then exit;

    if Self.Owner is TSAELines then
        Self.TransLineId := TSAELines(Self.Owner).Id;
end;
Function  TStockAdjustEntryPQA.getPQABatch; begin
    Result := TPQABatch(getContainerComponent(TStockAdjustEntryPQABatch, 'PQAType = ' +QuotedStr(TPQABatch.PQADetailtype)+  ' and PQAID = '+ IntToStr(Self.Id)+ ' and ifnull(ParentRef,"") = ""'));
End;
Function  TStockAdjustEntryPQA.geTPQABins; begin
    Result := TPQABins(getContainerComponent(TStockAdjustEntryPQABins, 'PQAType = ' +QuotedStr(TPQABins.PQADetailtype)+  ' and PQAID = '+ IntToStr(Self.Id)+ ' and ifnull(ParentRef,"") = ""'));
End;
Function  TStockAdjustEntryPQA.geTPQASN; begin
    Result := TPQASN(getContainerComponent(TStockAdjustEntryPQASN, 'PQAType = ' +QuotedStr(TPQASN.PQADetailtype)+  ' and PQAID = '+ IntToStr(Self.Id)+ ' and ifnull(ParentRef,"") = ""'));
End;

function TStockAdjustEntryPQA.getPQADetails: TStockAdjustEntryPQADetails;
begin
   Result := TStockAdjustEntryPQADetails(getContainerComponent(TStockAdjustEntryPQADetails, 'PQAID = '+ IntToStr(Self.Id)));
end;

function TStockAdjustEntryPQA.GetSQL: String;
begin
    if FSQL = '' then
        fSQL := 'SELECT * FROM ' + REadPQATablename;
    REsult := inherited GetSQL;
end;

function TStockAdjustEntryPQA.PQAdetailtablename: string;
begin
  REsult :=ReadPQADetailTablename;
end;

function TStockAdjustEntryPQA.PQAtablename: string;
begin
  REsult :=ReadPQAtablename;
end;

{ TStockAdjustEntryPQADetails }
constructor TStockAdjustEntryPQADetails.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM ' + ReadPQADetailTablename;
end;

function ReadLineTablename: String;
begin
  REsult:= '';
  if AppContext['SAETreeTableName'].VarExists('Line') then
    REsult:= AppContext['SAETreeTableName'].VarByname['Line'];
end;
function ReadPQADetailTablename: String;
begin
  REsult:= '';
  if AppContext['SAETreeTableName'].VarExists('PQADetail') then
    REsult:= AppContext['SAETreeTableName'].VarByname['PQADetail'];

end;
function ReadPQAtablename: String;
begin
  REsult:= '';
  if AppContext['SAETreeTableName'].VarExists('PQA') then
    REsult:= AppContext['SAETreeTableName'].VarByname['PQA'];
end;
function TStockAdjustEntryPQADetails.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
    REsult := inherited DoAfterInsert(Sender);
    if not result then exit;

    if Self.Owner is TStockAdjustEntryPQA then
        Self.PQAID :=TStockAdjustEntryPQA(Self.Owner).Id;
end;

function TStockAdjustEntryPQADetails.GetSQL: String;
begin
    if fSQL = '' then
        fSQL := 'SELECT * FROM ' + ReadPQADetailTablename;
    REsult := inherited GetSQL;
end;

{ TSAELinestree }
procedure TSAELinestree.CheckProduct(ForceCheckProduct:Boolean=False);
var
  strSQL:String;
  Qry:TERPQuery;
begin
  if Trim(ReadLineTablename) = '' then exit;
  if not (Commondblib.TableExists(ReadLineTablename)) then exit;

  strSQL:= 'select * from ' +  ReadLineTablename +
            ' where StockAdjustEntryLinesID <> ' + IntToStr(ID) +
            ' and StockAdjustentryID  = ' + IntToStr(StockAdjustEntryID) +
            ' and ProductId           = ' + IntToStr(ProductID) +
            ' and ClassID             = ' + IntToStr(classId) +
            ' and ifnull(AdjustQty,0)<>0 and Deleted <> "T"' ;
  if EnforceUOM then
    strSQL := strSQL + ' and UOMID               = ' + IntToStr(UOMID) ;
  Qry := DbSharedObj.GetQuery(Connection.connection, strSQL);
  try
    with (*getnewdataset(StrSQL,true) *) Qry do begin
      if recordcount    >  0 then begin
        if AdjustQty    <> 0 then AdjustQty := 0;
        if AdjustUOMQty <> 0 then AdjustUOMQty := 0;
      end;
      if Assigned(self.LockAdjustQty) then Self.LockAdjustQty(Recordcount>0);
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

constructor TSAELinestree.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
end;

function TSAELinestree.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
end;

function TSAELinestree.DoAfterOpen(Sender: TDatasetBusObj): boolean;
begin
  result := inherited DoAfterOpen(sender);
//  if not(result) then exit;
//  logtext('TSAELinestree.DoAfterOpen : ' + sql);
end;

procedure TSAELinestree.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  if processed then exit;
  inherited;
end;

function TSAELinestree.Getalloctype: String;
begin
  REsult := 'IN';
end;

function TSAELinestree.GetOrderQty: Double;
begin
  Result := Qty;
end;

function TSAELinestree.GetPQA: TPQA;
begin
  Result := TPQA(getSAEPQA);
  if (ID<> 0) and (Result.count = 0) and (ISPQAItem) then begin
        Result.New;
    end;
end;

function TSAELinestree.getPQAAllocation: String;begin  REsult := GetStringField('PQAAllocation');end;


function TSAELinestree.GetQty: Double;
begin
  Result := AdjustQty;
end;

function TSAELinestree.getSAEPQA: TStockAdjustEntryPQA;
begin
    Result := TStockAdjustEntryPQA(getContainerComponent(TStockAdjustEntryPQA, 'TransLineID = '+ IntToStr(Self.Id)+' and TransType = ' + quotedstr(Self.classname)));
end;


function TSAELines.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
    REsult := inherited DoAfterInsert(Sender);
    if not result then exit;

    if Self.Owner is TStockAdjustEntry then begin
        Self.StockAdjustentryId :=TStockAdjustEntry(Self.Owner).Id;
        if not RawMode then begin
          Self.AccountId :=TStockAdjustEntry(Self.Owner).AccountID;
          Self.Accountname:=TStockAdjustEntry(Self.Owner).accountname;
        end;
    end;
    DeptId := AppEnv.DefaultClass.ClassId;
    UnitOfMeasure := AppEnv.DefaultClass.DefaultUOM;
    Deleted := False;
end;

function TSAELines.GetAdjustmentDate: TDateTime;
begin
    REsult := Date;
    if Assigned(Self.Owner) then
        if Self.Owner is TStockAdjustEntry then
            Result := TStockAdjustEntry(Self.Owner).AdjustmentDate;
end;

function TSAELines.GetActive         : Boolean;  begin Result := not(Deleted); end;
function TSAELines.GetBOQty          : Double;   begin Result := 0;     end;
function TSAELines.GetBOUOMQty       : Double;   begin Result := 0;     end;
class function TSAELines.GetBusObjectTablename: string;
begin
  REsult :='';
end;

function TSAELines.GetClassID        : Integer;  begin Result := DeptID;end;
function TSAELines.GetCleanClassID   : Integer;  begin Result := 0;     end;
function TSAELines.GetcleanProductId : Integer;  begin Result := 0;     end;
function TSAELines.GetSerialnos      : String;   begin Result := GetStringfield('Serialnos'); end;
function TSAELines.GetTransDate      : TDatetime;begin Result := AdjustmentDate; end;
function TSAELines.GetUnitOfMeasure  : String;   begin Result := UOM; end;
function TSAELines.GetUnitOfMeasureID: Integer;  begin Result := UomID; end;
procedure TSAELines.SetSerialNos(const Value: String);begin SetStringfield('Serialnos', Value);  end;
procedure TSAELines.SetUnitOfMeasure(const Value: String);begin UOM:= Value; end;
procedure TSAELines.SetUnitOfMeasureID(const Value: Integer);begin UOMId := Value;end;
procedure TSAELines.SetTransDate(const Value: TDatetime);begin  {transdate not in the line - nothng to be done} end;
function TSAELinestree.GetSQL: String;
begin
    if fSQL = '' then
        fSQL := 'SELECT * FROM ' + ReadLineTablename;
    result := inherited GetSQL;
end;

function TSAELinestree.GetUOMOrderQty: Double;
begin
  Result := UOMQty;
end;

function TSAELinestree.GetUOMQty: Double;
begin
  Result := ADjustUOMQty ;
end;


procedure TSAELinestree.SetActive(const Value: Boolean);
begin
  Deleted := not(Value);
end;

procedure TSAELinestree.SetBOQty(const Value: Double);
begin
  //
end;
procedure TSAELinestree.SetBOUOMQty(const Value: Double);
begin
  //
end;

procedure TSAELinestree.SetOrderQty(const Value: Double);
begin
  inherited;
  Qty := Value;
end;

procedure TSAELinestree.setPQAAllocation(const Value: String);
begin
  SetStringfield('PQAAllocation' , Value);
end;



procedure TSAELinestree.SetQty(const Value: Double);
begin
  inherited;
    AdjustQty:= Value;
end;

procedure TSAELinestree.SetUOMOrderQty(const Value: Double);
begin
  inherited;
    UOMQty := Value;
end;

procedure TSAELinestree.SetUOMQty(const Value: Double);
begin
  inherited;
  ADjustUOMQty := Value;
end;

{ TStockAdjustEntryPQASN }

constructor TStockAdjustEntryPQASN.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM ' + ReadPQADetailTablename;
  if PQADetailtype <> '' then
    fSQL := fSQL + ' where PQAType = ' + Quotedstr(PQADetailtype);
end;

function TStockAdjustEntryPQASN.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
    REsult := inherited DoAfterInsert(Sender);
    if not result then exit;
end;

function TStockAdjustEntryPQASN.GetSQL: String;
begin
   if fSQL = '' then
        fSQL := 'SELECT * FROM ' + ReadPQADetailTablename;
   result := inherited GetSQL;
end;

function TStockAdjustEntryPQASN.ValidateSN: Boolean;
begin
  // ignore the validationas the process will validate it
  REsult := True; 
end;

{ TStockAdjustEntryPQABins }

constructor TStockAdjustEntryPQABins.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM ' + ReadPQADetailTablename;
  if PQADetailtype <> '' then
    fSQL := fSQL + ' where PQAType = ' + Quotedstr(PQADetailtype);
end;

function TStockAdjustEntryPQABins.GeTPQASN: TPQASN;
begin

//    Result := TPQASN(getContainerComponent(TStockAdjustEntryPQASN, 'PQAType = ' +QuotedStr(TPQASN.PQADetailtype)+  ' and PQAID = '+ IntToStr(Self.PQAId) + ' and ParentRef = ' + QuotedStr(Self.Globalref)));

(*    result := TPQASN(Container.ItemByClass(TStockAdjustEntryPQASN, false));
    if not Assigned(result) then
    begin
        if (self.ID = 0) and (self.Dataset.State <> dsCalcFields) then
          self.PostDB;
        result:= TPQASN(TComponentClass(TStockAdjustEntryPQASN).Create(nil));
        Container.Add(result);
        REsult.LogChangesOnSave := False;

        result.LockGroupName:= self.LockGroupName;

        if Self.ConnectionAssigned then
          result.Connection := Self.Connection
        else
          result.Connection := GetSharedDataConnection;
        result.SilentMode := Self.SilentMode;
    end;*)

    {binny : the above code doesn't filter the Serial numbers for the current line.
    ie: when the stock adjustmnet got multiple lines, they all show the same set of seral numbers  }
    Result := TPQASN(getContainerComponent(TStockAdjustEntryPQASN, 'PQAType = ' +QuotedStr(TPQASN.PQADetailtype)+  ' and PQAID = '+ IntToStr(Self.PQAId) + ' and ParentRef = ' + QuotedStr(Self.Globalref)));

    (*if Assigned(Result) then
    begin
      Result.SQL   :='select @r := @r+1 as LineNum, z.* from(' +
            'Select * from ' + ReadPQADetailTablename + ' where PQAType = '+QuotedStr(TPQASn.pqadetailtype) +  ' and  PQAID = ' + IntToStr(PQA.ID) + ' and ParentRef = "' + Self.GlobalRef + '"' +
            ')z, (select @r:=0)y;';
    Result.Load();
  end;*)
end;

function TStockAdjustEntryPQABins.GetSQL: String;
begin
   if fSQL = '' then
        fSQL := 'SELECT * FROM ' + ReadPQADetailTablename;
    result := inherited GetSQL;
end;

{ TStockAdjustEntryPQABatch }

constructor TStockAdjustEntryPQABatch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM ' + ReadPQADetailTablename;
  if PQADetailtype <> '' then
    fSQL := fSQL + ' where PQAType = ' + Quotedstr(PQADetailtype);
end;

function TStockAdjustEntryPQABatch.GeTPQABins: TPQABins;
begin
      Result := TPQABins(getContainerComponent(TStockAdjustEntryPQAbins, 'PQAType = ' +QuotedStr(TPQABins.PQADetailtype)+  ' and PQAID = '+ IntToStr(Self.PQAId) + ' and ParentRef = ' + QuotedStr(Self.Globalref)));
end;

function TStockAdjustEntryPQABatch.GeTPQASN: TPQASN;
begin
      Result := TPQASN(getContainerComponent(TStockAdjustEntryPQASN, 'PQAType = ' +QuotedStr(TPQASN.PQADetailtype)+  ' and PQAID = '+ IntToStr(Self.PQAId) + ' and ParentRef = ' + QuotedStr(Self.Globalref)));
end;

function TStockAdjustEntryPQABatch.GetSQL: String;
begin
   if fSQL = '' then
        fSQL := 'SELECT * FROM ' + ReadPQADetailTablename;
    result := inherited GetSQL;
end;
procedure TSAELines.CalcAdjustQty;
begin
  if AdjustonInStock=False then begin
    AdjustQty       :=  FinalQty-AvailableQty;
    AdjustUOMQty    :=  FinalUOMQty-AvailableUOMQty;
  end
  else begin
    AdjustQty       :=  FinalQty-InStockQty;
    AdjustUOMQty    :=  FinalUOMQty-InStockUOMQty;
  end;
end;

procedure TSAELines.CalcAvailableQty(force: boolean);
var
    StrSQL:String;
    Qry:TERPQuery;

begin
    if (not ProductChanged) and (not force) then exit;
    if processed then exit;
    AvailableQty    := 0;
    AvailableUOMQty := 0;
    if (ProductID <> 0) and (DeptID <> 0 ) and (UOM <> '') and (Adjustmentdate <> 0) then begin
      UOMId := tcdatautils.GetUnitOfMeasureID(UOM , ProductID);
      if EnforceUOM then
           strSQL := ProductQtyLib.SQL4ProductAvailableQty(AdjustmentDate ,  UOM,  tsummary,ProductId,DeptId)
      else strSQL := ProductQtyLib.SQL4ProductAvailableQty(AdjustmentDate ,  '',  tsummary,ProductId,DeptId);
      //Qry :=  getNewDataset(strSQL);
      Qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection , strSQL);
      try
        with qry do begin
            AvailableQty    := Round(FieldByname('Qty').asFloat,tcConst.GeneralRoundPlaces);
            if EnforceUOM then
              AvailableUOMQty := Round(FieldByname('UOMQty').asFloat , tcConst.GeneralRoundPlaces)
            else AvailableUOMQty := Round(FieldByname('Qty').asFloat / UOMMultiplier, tcConst.GeneralRoundPlaces) ;
        end;
      finally
          DbSharedObj.ReleaseObj(qry);
      end;

      if EnforceUOM then
           strSQL := ProductQtyLib.SQL4ProductAvailableQty(AdjustmentDate ,  UOM,  tsummary,ProductId,DeptId,'',0,'','','',tinStock)
      else strSQL := ProductQtyLib.SQL4ProductAvailableQty(AdjustmentDate ,  '',  tsummary,ProductId,DeptId,'',0,'','','',tinStock);
      //Qry :=  getNewDataset(strSQL);
      Qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection, strSQL);
      try
        with qry do begin
            InStockQty:= FieldByname('Qty').asFloat;
            if EnforceUOM then
              InStockUOMQty:= FieldByname('UOMQty').asFloat
            else
              InStockUOMQty:= Round(FieldByname('Qty').asFloat / UOMMultiplier, tcConst.GeneralRoundPlaces) ;
        end;
      finally
          DbSharedObj.ReleaseObj(qry);
      end;
    end;
end;


function TSAELines.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited  DoBeforePost(SendeR);

  if not result then exit;

  if  {(not DatasetPosting) and} (ProductID = 0) and ((ProductNAme = '') or (tcdatautils.GetProduct(Productname) = 0)) then begin
      Deleted := True;
      Result := True;
      Exit;
  end else if (ProductID<> 0) and (Deleted = False) then Deleted := False;
end;

function TSAELines.getLockAdjustQty: TGeneralBooleanProc;
begin
  result := nil;
  if Assigned(Self.Owner) then
    if Self.Owner is TStockAdjustEntry then
      Result := TStockAdjustEntry(Self.Owner).LockAdjustQty;
end;
function TSAELines.getLockAllocAdjustQty: TGeneralBooleanProc;
begin
  result := nil;
  if Assigned(Self.Owner) then
    if Self.Owner is TStockAdjustEntry then
      Result := TStockAdjustEntry(Self.Owner).LockAllocAdjustQty;
end;

function TSAELines.GetAdjustonInStock: Boolean;
begin
  Result := True;
  if Assigned(Self.Owner) and (Self.Owner is TStockAdjustEntry) then
    REsult := TStockAdjustEntry(Self.Owner).AdjustmentOnInstock;
end;

function TSAELines.getEnforceUOM: Boolean;
begin
  Result := False;
  if Assigned(Self.Owner) and (Self.Owner is TStockAdjustEntry) then
    REsult := TStockAdjustEntry(Self.Owner).EnforceUOM;
end;


function TSAELines.getTotalCost: Double;
begin
  REsult := GetFloatField('TotalCost');
end;

function TSAELines.getUOMCost: Double;
begin
  REsult := GetFloatField('UOMCost');
end;

procedure TSAELines.CreateInstance;
begin
  inherited;
  if Assigned(Self.Owner) then
    if Self.Owner is TStockAdjustEntry then
      ObjInstanceToClone :=  TStockAdjustEntry(Self.Owner).StockMovement.Lines;
end;

function TSAELines.CreatingTreeModeData: Boolean;
begin
  REsult := False;
  if Assigned(Owner) then
    if owner is TStockAdjustEntry then
      Result := TStockAdjustEntry(Owner).CreatingTreeModeData;
end;

function TSAELines.CloneBusObj(const Changefield: String;
  const ChangeValue: Variant; const SaveAfterCopy: Boolean;
  const FilterFields: String): TBusObj;
begin
    Result := inherited CloneBusObj(ChangeField, changeValue, SaveAfterCopy,FilterFields);
    if Result = nil then Exit;
    Result := ObjInstanceToClone;
    if ObjInstanceToClone is TStockMovementLines then begin
      TStockMovementLines(ObjInstanceToClone).AssetAccountID:= tcdatautils.AccountIDForName(TStockMovementLines(ObjInstanceToClone).Product.AssetAccount);//TAccount.IDToggle(TStockMovementLines(ObjInstanceToClone).Product.AssetAccount , Self.Connection.connection);
      TStockMovementLines(ObjInstanceToClone).AccountName   := tcdatautils.GetAccountName(TStockMovementLines(ObjInstanceToClone).AccountID);//TAccount.IDToggle(TStockMovementLines(ObjInstanceToClone).AccountID, Self.connection.connection);
      TStockMovementLines(ObjInstanceToClone).Value         := TStockMovementLines(ObjInstanceToClone).Qty*TStockMovementLines(ObjInstanceToClone).cost;
      TStockMovementLines(ObjInstanceToClone).ProductName   := TStockMovementLines(ObjInstanceToClone).Product.Productname;
      TStockMovementLines(ObjInstanceToClone).Description   := TStockMovementLines(ObjInstanceToClone).Product.SalesDescription;
      TStockMovementLines(ObjInstanceToClone).ProductPrintName   := TStockMovementLines(ObjInstanceToClone).Product.ProductPrintName;
    end;
    TStockMovementLines(REsult).postDB;
    ObjInstanceToClone.FreeContainerObjects;
    Self.FreeContainerObjects;
end;

procedure TSAELines.ClonePropertyObjects;
begin
  inherited;
  Copyallocation;
end;


function TSAELines.GetOrderQty: double;
begin
  result:= 0;
end;

procedure TSAELines.SetOrderQty(const Value: double);
begin
  inherited;

end;

function TSAELines.GetUOMOrderQty: double;
begin
  result:= 0;
end;

procedure TSAELines.SetUOMOrderQty(const Value: double);
begin
  inherited;

end;

function TSAELines.getPartBarcode: String;
begin
  REsult := getStringfield('PartBarcode');
end;

function TSAELines.getprocessed: Boolean;
begin
  if Assigned(Owner) then
    if Owner is TStockAdjustEntry then
      result := TStockAdjustEntry(Owner).Processed;
end;

procedure TSAELines.setPartBarcode(const Value: String);
begin
  SetStringfield('PartBarcode' , Value);
end;

function TSAELines.GetProductType: string;
begin
  Result := GetStringField('PartType');
end;

procedure TSAELines.SetProductType(const Value: string);
begin
  inherited;
  SetStringField('PartType', Value);
end;


procedure TSAELines.getCalcQtYformulaValue(Sender: TObject;const VarName: string; var Value: extended; var FieldFound: Boolean);
begin
              if SameText(varname, 'Field1') then begin Value := FormulaQtyValue1 ;FieldFound:= True;
     end else if SameText(varname, 'Field2') then begin Value := FormulaQtyValue2 ;FieldFound:= True;
     end else if SameText(varname, 'Field3') then begin Value := FormulaQtyValue3 ;FieldFound:= True;
     end else if SameText(varname, 'Field4') then begin Value := FormulaQtyValue4 ;FieldFound:= True;
     end else if SameText(varname, 'Field5') then begin Value := FormulaQtyValue5 ;FieldFound:= True; end;

end;
procedure TSAELines.CalcQtyFromformula;
var
  Qty :Double;
  ErrMsg:String;
begin
  PostDB;
  if ProductId =0 then exit;
  postDB;
  if QtyCalcFormulaDetails.PartCalcformula = '' then exit;
  fbCalcQtyFromformula:= True;
  try
    Qty :=ProductQtyParseValue(Self , getCalcQtYformulaValue ,ErrMsg , Self , formulaQtyvalue);
    AdjustUOMQty := Qty;
    DoFieldOnChange(dataset.Findfield('AdjustUOMQty'));
  finally
    fbCalcQtyFromformula:= False;
  end;
end;


procedure TSAELines.SetMatrixDesc(const Value: String);begin  SetStringField('MatrixDesc' , Value);end;
procedure TSAELines.SetMatrixPrice(const Value: Double);begin  SetFloatfield('MatrixPrice' , Value);end;
procedure TSAELines.SetMatrixRef(const Value: String);begin  SetStringField('MatrixRef' , Value);end;
procedure TSAELines.SetNotes(const Value: string);
begin
  SetStringField('Notes', Value);
end;

function TSAELines.getMatrixDesc: String;begin  Result := GetStringfield('MatrixDesc');end;
function TSAELines.getMatrixPrice: Double;begin  REsult := getFloatfield('MatrixPrice');end;
function TSAELines.getMatrixRef: String;begin  Result := GetStringfield('MatrixRef');end;


function TSAELines.GetNotes: string;
begin
  result := GetStringField('Notes');
end;

function UnallocatedBinQty(Productfilter:String; emptybin:Boolean =False):String;
  begin
    {sub query within query Select from(Select from(Select from) as A1 ) as A2) as A3}
    result :=
      'Select * ,  round(Qty-BQty,' +inttostr(GeneralRoundPlaces) +') Qtydiff, round(UOMQty - BUOMQty,' +inttostr(GeneralRoundPlaces) +') uomQtydiff ' +
      ' from (' +  chr(13) +
            ' select ProductId, ProductName, departmentId, uomid, uom ,DefaultbinId , P.Batch, P.multipleBins , ' +
            ' Sum(Qty) Qty, sum(UOMQty) UOMqty, sum(round(BQty,' +inttostr(GeneralRoundPlaces) +')) BQty , sum(round(BUOMQty,' +inttostr(GeneralRoundPlaces) +')) BUOMQty ' +
            ' from ('  +chr(13) +
                ' select PQA.PQAID, PQA.ProductID, PQA.ProductName, PQA.UOM, PQA.UOMID, pqa.DepartmentID, ' +
                SQL4QtyField(tinstock , 'PQA' , 'PQA.Qty' ) + ' as Qty, '+
                SQL4Qty(tinstock , 'PQA' , 'PQABi.Qty') + ' as BQty, '+
                SQL4QtyField(tinstock , 'PQA' , 'PQA.UOMQTY') + ' as UOMQty, '+
                SQL4Qty(tinstock , 'PQA' , 'PQABi.UOMQty') + ' as BUOMQty, '+
                ' PC.DefaultbinId ' +chr(13) +
                ' from tblPQA PQA ' +chr(13) +
                ' Left join tblPQAdetails PQAbi  on PQa.PQAID = PQABi.PQAID  and PQABi.PQAType = "Bin" /*and ifnull(PQABi.ParentREf,"") = "" */' +chr(13) +
                //' Left join tblPQAdetails PQAba  on PQa.PQAID = PQABa.PQAID  and PQABa.PQAType = "Batch" /*and ifnull(PQABi.ParentREf,"") = "" */' +chr(13) +
                ' Inner Join tblproductclasses AS PC  ' +
                ' ON PQA.ProductID = PC.ProductID AND PQA.DepartmentID = PC.ClassID ' +chr(13) +
                ' where ifnull(PC.DefaultbinId,0)<> 0 ' + Productfilter +chr(13) +
                ' group by PQA.PQAID) as A2 ' +chr(13) +
                ' inner join tblParts P on P.PartsId = A2.ProductID   ' +
                ' /*and ifnull(P.Batch,"F") = "F" */and ifnull(P.multipleBins,"F") = "T" '+
            ' group by ProductId, departmentId, uomid) as A1'+chr(13) ;
      if emptybin = false then
        result := result + ' where abs(round(ifnull(Qty,0)  - ifnull(BQty,0), ' + inttostr(tcConst.GeneralRoundPlaces)+'))>0 or abs(Round(ifnull(UOMQty,0)- ifnull(BUOMQty,0), ' + inttostr(tcConst.GeneralRoundPlaces)+'))>0 ';

  end;


initialization
  RegisterClassOnce(TStockAdjustEntry);
  RegisterClassOnce(TSAELinesFlat);
  RegisterClassOnce(TSAELinesTree);
end.





