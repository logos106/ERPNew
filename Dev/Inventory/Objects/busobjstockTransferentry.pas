unit busobjstockTransferentry;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  03/06/08  1.00.01  bS  Initial Version.
  }


interface


Uses TypesLib,MyAccess,ERPdbComponents,BusObjBase, DB, Classes, XMLDoc, XMLIntf, busobjPQA, busobjStockMovement;


type
  TTransProc1 = procedure(Const Value :String)  of object;
  TTransProc2 = Procedure(Const Value :Boolean) of object;

  { Include in Site Intergration }
  TSTEPQABatch = class(TPQABatch)
    private
    Public
      constructor      Create(AOwner: TComponent);override;
      class function GetBusObjectTablename: string; override;
    Protected
      Function GeTPQABins          : TPQABins;override;
      Function GeTPQASN            : TPQASN;override;

  end;
  TSTEPQABins = class(TPQABins)
    private
    Public
      constructor      Create(AOwner: TComponent);override;
      class function GetBusObjectTablename: string; override;
    Protected
      Function GeTPQASN            : TPQASN;override;

  end;
  TSTEPQASN = class(TPQASN)
    private
    Public
      constructor      Create(AOwner: TComponent);override;
      class function GetBusObjectTablename: string; override;
    Protected
      Function         ValidateSN :Boolean;Override;
  end;

  TSTELines = class(TProdQty)
  private
    fOpenLookups        : TGeneralProc;
    fDisableBatchcombos : TTransProc2;
    fDisableBincombos   : TTransProc2;
    cleanProductDetails   : STring;
    cleanTransferQty              : double;
    cleanUOMTransferQty           : double;
    diffQty                       : double;
    diffUOMQty                    : double;
    fiid                          : Integer;
    fiProductID                   : Integer;
    fUOM                          : String;
    fbCalcQtyFromformula          : Boolean;

    function GetclientID                 : Integer   ;
    function GetAccountID                : Integer   ;
    function GetAssetValue               : Double    ;
    function GetValue                    : Double    ;
    function GetCustomerName             : string    ;
    function GetTransferEntryID          : Integer   ;
    function GetClassIDTo                : Integer   ;
    function GetClassNameTo              : string    ;
    function GetPQADetailClassRef        : string    ;
    function GetEmployeeID               : Integer   ;
    function GetProductDesc              : string    ;
    function GetAvailableQty             : Double    ;
    function GetUOMAvailableQty          : Double    ;
    function GetTransferQty              : Double    ;
    function GetUOMTransferQty           : Double    ;
    function GetDeleted                  : Boolean   ;
    function GetDatetransferred          : TDatetime ;
    function BinProduct                  : boolean   ;
    function BatchProduct                : boolean   ;
    function GetClassIDFrom              : Integer   ;
    procedure SetclientID                 (const Value: Integer   );
    procedure SetAccountID                (const Value: Integer   );
    procedure SetAssetValue               (const Value: Double    );
    procedure SetValue                    (const Value: Double    );
    procedure Setcost                     (const Value: Double    );
    procedure SetCustomerName             (const Value: string    );
    procedure SetTransferEntryID          (const Value: Integer   );
    procedure SetClassIDTo                (const Value: Integer   );
    procedure SetClassNameTo              (const Value: string    );
    procedure SetPQADetailClassRef        (const Value: string    );
    procedure SetEmployeeID               (const Value: Integer   );
    procedure SetProductDesc              (const Value: string    );
    procedure SetAvailableQty             (const Value: Double    );
    procedure SetUOMAvailableQty          (const Value: Double    );
    procedure SetTransferQty              (const Value: Double    );
    procedure SetUOMTransferQty           (const Value: Double    );
    procedure SetDeleted                  (const Value: Boolean   );
    Procedure LockbinBatchFields          (const Value :boolean); overload;
    Procedure LockbinBatchFields; overload;
    Procedure RecalculateAvailQty;
    Function  ProductDetails: String;
    Function  ProductChanged :Boolean;
    Procedure CallBackRecalculateAvailQty(Const Sender: TBusObj; var Abort: boolean);
    function getEnforceUOM: Boolean;
    function getPartBarcode: String;
    procedure setPartBarcode(const Value: String);
    procedure CalcQtyFromformula;
    procedure getCalcQtYformulaValue(Sender: TObject; const VarName: string;var Value: extended; var FieldFound: Boolean);
    function GetAccountName: string;
    procedure SetAccountName(const Value: string);
    function GetEmployeeName: string;
    procedure SetEmployeeName(const Value: string);
    function Getcost: Double;
    function getCrossStockAdjustTransForinvoice: Boolean;
  protected
    Procedure StoreValues;virtual;
    procedure OnDataIdChange(const ChanGetype: TBusObjDataChanGetype);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    procedure CheckUOM;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    function  DoBeforePost(Sender: TDatasetBusObj): Boolean;              override;
    Function  DoAfterInsert(Sender :TDatasetBusobj):Boolean;             Override;
    Function  DoBeforeInsert(Sender :TDatasetBusobj):Boolean;             Override;
    function  GetIsPQAItem :boolean; override;
    Function GetTransDate      : TDatetime ; override;
    function GetProductID      : Integer   ; override;
    function GetProductName    : string    ; override;
    function GetUOMMultiplier  : Double    ; override;
    function GetUnitOfMeasureID: Integer   ; override;
    function GetUnitOfMeasure  : string    ; override;
    function GetSerialnos      : string    ; override;
    Function GetClassID        : Integer   ; override;
    Function GetAllocType      : String    ; Override;
    Function GetActive         : Boolean   ; override;
    Function GetQty            : Double    ; override;
    Function GetBOQty          : Double    ; override;
    Function GetBOUOMQty       : Double    ; override;
    Function GetUOMQty         : Double    ; override;
    (*Function GetISBO           : Boolean   ; Override;*)
    function GetCleanClassID   : Integer   ; Override;
    function GetcleanProductId : Integer   ; override;
    procedure SetUnitOfMeasureID(const Value: Integer   ); override;
    procedure SetUnitOfMeasure  (const Value: string    ); override;
    procedure SetSerialNos      (const Value: string    ); override;
    procedure SetUOMMultiplier  (const Value: Double    ); override;
    procedure SetTransDate      (const Value: TDatetime ); override;
    procedure SetProductID      (const Value: Integer   );override;
    procedure SetProductName    (const Value: string    );override;
    procedure SetActive(const Value: Boolean); Override;
    procedure SetBOQty(const Value: Double); Override;
    procedure SetBOUOMQty(const Value: Double); Override;
    procedure SetQty(const Value: Double); Override;
    procedure SetUOMQty(const Value: Double); Override;
    function  GetOrderQty         :Double;    override;
    procedure SetOrderQty(const Value: Double);override;
    function  GetUOMOrderQty         :Double;    override;
    procedure SetUOMOrderQty(const Value: Double);override;
    function GetProductType: string;override;
    procedure SetProductType(const Value: string);override;
    procedure SetMatrixRef(const Value: String);Override;
    function GetMatrixRef: String;Override;
    function GetMatrixDesc: String;Override;
    function GetMatrixPrice:Double;Override;
    procedure SetMatrixDesc(const Value: String);Override;
    procedure SetMatrixPrice(const Value: Double);Override;
    procedure InitUOM(const UOMName, UOMNameOldValue: String);Overload;override;
    procedure CreateInstance;override;
    procedure AfterCloneBusObj;override;
    procedure ExtraValidation;Virtual;
    function DoBeforeDelete(Sender: TDatasetBusObj): Boolean; override;


  public
    Procedure PostnEditDB;Override;
    constructor     Create(AOwner: TComponent);                     override;
    destructor      Destroy;                                        override;
    procedure       LoadFromXMLNode(const node: IXMLNode);        override;
    procedure       SaveToXMLNode(const node: IXMLNode);          override;
    function        ValidateData: Boolean;                          override;
    function        Save: Boolean;                                  override;
    Class function  GetIDField              : string;               override;
    Class function  GetKeyStringField       : string;               override;
    Class function  GetBusObjectTablename   : string;               override;
    Procedure       CalcQtys;Virtual;
    Property OpenLookups            : TGeneralProc  Read fOpenLookups             write fOpenLookups;
    Property Disablebincombos       : TTransProc2   Read fDisableBincombos        write fDisableBincombos;
    Property DisableBatchcombos     : TTransProc2   Read fDisableBatchcombos      write fDisableBatchcombos;
    Property Datetransferred        : TDatetime     Read GetDatetransferred;
    Property ClassIDFrom            : Integer       read GetClassIDFrom;
    Property EnforceUOM             : Boolean       Read getEnforceUOM;
    property TransferEntryID           :Integer     read GetTransferEntryID         write SetTransferEntryID      ;
    class function _Schema: string; override;
    procedure ProductQty(AutoAdjusttransferQty:boolean = TRue);Virtual;
    function PQAcount: Integer;Override;
    Property CrossStockAdjustTransForinvoice :Boolean read getCrossStockAdjustTransForinvoice;
  published
    property ClientID                  :Integer     read GetclientID                write SetclientID             ;
    property CustomerName              :string      read GetCustomerName            write SetCustomerName         ;
    property AccountID                 :Integer     read GetAccountID               write SetAccountID            ;
    property AccountName: string read GetAccountName write SetAccountName;
    property AssetValue                :Double      read GetAssetValue              write SetAssetValue           ;
    property Value                     :Double      read GetValue                   write SetValue                ;
    Property Cost                      :Double      read Getcost                    write Setcost                 ;
    property ClassIDTo                 :Integer     read GetClassIDTo               write SetClassIDTo            ;
    property ClassNameTo               :string      read GetClassNameTo             write SetClassNameTo          ;
    property PQADetailClassRef         :string      read GetPQADetailClassRef       write SetPQADetailClassRef    ;
    property EmployeeID                :Integer     read GetEmployeeID              write SetEmployeeID           ;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property ProductDesc               :string      read GetProductDesc             write SetProductDesc          ;
    property AvailableQty              :Double      read GetAvailableQty            write SetAvailableQty         ;
    property UOMAvailableQty           :Double      read GetUOMAvailableQty         write SetUOMAvailableQty      ;
    property TransferQty               :Double      read GetTransferQty             write SetTransferQty          ;
    property UOMTransferQty            :Double      read GetUOMTransferQty          write SetUOMTransferQty       ;
    property Deleted                   :Boolean     read GetDeleted                 write SetDeleted              ;
    property PartBarcode :String read getPartBarcode write setPartBarcode;
  end;
  TSTEPQADetails = class(TPQADetails)
    Private
    Public
        constructor      Create(AOwner: TComponent);override;
        class function GetBusObjectTablename: string; override;
    Protected
        function  DoAfterInsert(Sender: TDatasetBusObj): boolean; Override;
        procedure CreateInstance;Override;
  end;

  TSTEPQA = class(TPQA)
  Private
      procedure CloneLines(const Sender: TBusObj; var Abort: boolean);
  Public
      constructor      Create(AOwner: TComponent);override;
      class function GetBusObjectTablename: string; override;
      function PQAdetailtablename: string; Override;
      function PQAtablename: string; Override;
      function NewPQADetailObj(const ObjInstanceToCloneID:Integer): TPQADetails;Override;
      //Property PQADetails :TSTEPQADetails Read getPQADetails;
  Protected
      function  DoAfterInsert(Sender: TDatasetBusObj): boolean; Override;
      Function GetPQABatch         : TPQABatch; Override;
      Function GeTPQABins          : TPQABins;Override;
      Function GeTPQASN            : TPQASN;Override;
      procedure CreateInstance;Override;
      procedure ClonePropertyObjects; override;
      function getPQAdetails: TPQADetails;override;
  end;

(*  TSTEPQAFrom = class(TSTEPQA)
  Private
  Public
      constructor      Create(AOwner: TComponent);override;
  end;
  TSTEPQATo = Class(TSTEPQA)
  Private
  Public
      constructor      Create(AOwner: TComponent);override;
  End;*)
  TSTELinesTree = class(TSTELines)
    Private
      function getPQAFromAllocation: String;
      function getPQAToAllocation: String;
      procedure setPQAFromAllocation(const Value: String);
      procedure setPQAToAllocation(const Value: String);
      function getSTEPQA: TSTEPQA;
    Protected
      function GetPQA: TPQA;Override;
      Procedure ClonePropertyObjects; override;
      Function GetAllocType      : String    ; Override;
      procedure AfterCloneBusObj;Override;
      procedure DoFieldOnChange(Sender: TField);                           override;
    Public
      Property PQAFromAllocation :String read getPQAFromAllocation write setPQAFromAllocation;
      Property PQAToAllocation :String read getPQAToAllocation write setPQAToAllocation;
      Property STEPQA :TSTEPQA read getSTEPQA;
    Published
  end;
  TSTELinesTreeIn = class(TSTELinesTree)
    Private
    Protected
      Function GetAllocType      : String    ; Override;
      function GetClassID: Integer; Override;
      Procedure ClonePropertyObjects; override;
    Public
  end;

  TSTELinesFlat = class(TSTELines)
  Private
    CleanAllocationDetails: String;
    cleanTransferAllocatedQty     : double;
    cleanTransferUOMAllocatedQty  : double;
    function GetBatchNoFrom              : string    ;
    function GetexpiryDateFrom           : TDateTime ;
    function GetBinLocationFrom          : string    ;
    function GetBinNumberFrom            : string    ;
    function GetBatchNoTo                : string    ;
    function GetexpiryDateTo             : TDateTime ;
    function GetBinLocationTo            : string    ;
    function GetBinNumberTo              : string    ;
    function GetSerialNumber             : string    ;
    function GetAllocatedQty             : Double    ;
    function GetUOMAllocatedQty          : Double    ;
    function GetTransferAllocatedQty     : Double    ;
    function GetUOMTransferAllocatedQty  : Double    ;
    function GetTransferSerialnos        : string    ;
    procedure SetBatchNoFrom              (const Value: string    );
    procedure SetexpiryDateFrom           (const Value: TDateTime );
    procedure SetBinLocationFrom          (const Value: string    );
    procedure SetBinNumberFrom            (const Value: string    );
    procedure SetBatchNoTo                (const Value: string    );
    procedure SetexpiryDateTo             (const Value: TDateTime );
    procedure SetBinLocationTo            (const Value: string    );
    procedure SetBinNumberTo              (const Value: string    );
    procedure SetSerialNumber             (const Value: string    );
    procedure SetAllocatedQty             (const Value: Double    );
    procedure SetUOMAllocatedQty          (const Value: Double    );
    procedure SetTransferAllocatedQty     (const Value: Double    );
    procedure SetUOMTransferAllocatedQty  (const Value: Double    );
    procedure SetTransferSerialnos        (const Value: string    );
    Function  AllocationChanged :Boolean;
    function getbinIDFrom: Integer;
    function getbinIdTo: Integer;
    function AllocationDetails: String;

  Protected
    procedure ExtraValidation;Override;
    procedure OnDataIdChange(const ChanGetype: TBusObjDataChanGetype);   override;
    Function  DoAfterInsert(Sender :TDatasetBusobj):Boolean;             Override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    procedure AfterCloneBusObj;override;
    Procedure StoreValues;Override;
    procedure SetSerialNos(const Value: string);Override;
  Public
    Property binIdFrom              : Integer       Read getbinIDFrom;
    Property binIDto                : Integer       Read getbinIdTo;
    Procedure       CalcQtys;Override;
    procedure       LoadFromXMLNode(const node: IXMLNode);        override;
    procedure       SaveToXMLNode(const node: IXMLNode);          override;
    function        ValidateData: Boolean;                          override;
    procedure ProductQty(AutoAdjusttransferQty: boolean= true);Override;
  Published
    property BatchNoFrom               :string      read GetBatchNoFrom             write SetBatchNoFrom          ;
    property ExpiryDateFrom            :TDateTime   read GetexpiryDateFrom          write SetexpiryDateFrom       ;
    property BinLocationFrom           :string      read GetBinLocationFrom         write SetBinLocationFrom      ;
    property BinNumberFrom             :string      read GetBinNumberFrom           write SetBinNumberFrom        ;
    property BatchNoTo                 :string      read GetBatchNoTo               write SetBatchNoTo            ;
    property ExpiryDateTo              :TDateTime   read GetexpiryDateTo            write SetexpiryDateTo         ;
    property BinLocationTo             :string      read GetBinLocationTo           write SetBinLocationTo        ;
    property BinNumberTo               :string      read GetBinNumberTo             write SetBinNumberTo          ;
    property SerialNumber              :string      read GetSerialNumber            write SetSerialNumber         ;
    property AllocatedQty              :Double      read GetAllocatedQty            write SetAllocatedQty         ;
    property UOMAllocatedQty           :Double      read GetUOMAllocatedQty         write SetUOMAllocatedQty      ;
    property TransferAllocatedQty      :Double      read GetTransferAllocatedQty    write SetTransferAllocatedQty         ;
    property TransferUOMAllocatedQty   :Double      read GetUOMTransferAllocatedQty write SetUOMTransferAllocatedQty      ;
    property TransferSerialnos         :string      read GetTransferSerialnos       write SetTransferSerialnos    ;

  end;

  { Include in Site Intergration }
  TStockTransferEntry = class(TMSBusObj)
  private
    fOpenLookups :TGeneralProc;
    AllLinesValid:Boolean;
    fAutoTransferDeptList: TGeneralProc;
    fsAutoTransfertoClassIDs: String;
    (*StockMovement :TStockMovement;*)
    MovementLines:TERPQuery;
    fShowStatus: TTransProc1;
    fbProcessing:boolean;
    fbuserallocating:Boolean;
    fbCrossStockAdjustTransForinvoice:Boolean;
    CancelAutoTransfer: boolean;
    fbDoProcessonSave: boolean;
    function GetTransferFromClassID      : Integer   ;
    function GetTransferFromClassName    : string    ;
    function getDescription              : String;
    function GetAccountID                : Integer   ;
    function GetAccountname              : string    ;
    function GetEmployeeID               : Integer   ;
    function GetEmployeeName             : string    ;
    function GetDateTransferred          : TDateTime ;
    Function GetStockMovementGlobalref   : String;
    function GetDeleted                  : Boolean   ;
    function GetCreationDate             : TDateTime ;
    function GetNotes                    : string    ;
    function GetProcessed                : Boolean   ;
    function getEnforceUOM: Boolean;
    procedure SetEnforceUOM(const Value: Boolean);
    Function getSalesRef:String;
    Function getTransfertype:String;
    Function getShipping:String;
    Procedure SetSalesREf(const Value:String);
    Procedure SetTransfertype(const Value:String);
    Procedure SetShipping(const Value:String);
    procedure SetTransferFromClassID      (const Value: Integer   );
    procedure SetTransferFromClassName    (const Value: string    );
    Procedure SetDescription              (Const Value: String    );
    procedure SetAccountID                (const Value: Integer   );
    procedure SetAccountName              (const Value: string    );
    procedure SetEmployeeID               (const Value: Integer   );
    procedure SetEmployeeName             (const Value: string    );
    procedure SetDateTransferred          (const Value: TDateTime );
    Procedure SetStockMovementGlobalref   (Const Value: String    );
    procedure SetDeleted                  (const Value: Boolean   );
    procedure SetCreationDate             (const Value: TDateTime );
    procedure SetNotes                    (const Value: string    );
    procedure SetProcessed                (const Value: Boolean   );
    procedure CalcualteAvailableQty   (Const Sender: TBusObj; var Abort: boolean);
    function GetLines: TSTELines;
    function getTreeLines :TSTELinesTree;
    function getTreeLinesIn :TSTELinesTreeIn;
    procedure LineValidateCallbackProc(Const Sender: TBusObj; var Abort: boolean);
    procedure KillInvlaidLines(Const Sender: TBusObj; var Abort: boolean);
    procedure DeleteLine(Const Sender: TBusObj; var Abort: boolean);
    procedure CallbackProcess(Const Sender: TBusObj; var Abort: boolean);
    Procedure Show_Status(Const Value :String);
    Procedure DeleteFlagedLines;
    Procedure Deletetransfer;
    function getStockMovement: TStockMovement;
    procedure CloneLines(const Sender: TBusObj; var Abort: boolean);
    function GetCleanDeleted: Boolean;
    function GetPQFromAlloation :String;
    Procedure SetPQFromAlloation(const Value :STring);
    function GetPQToAlloation :String;
    Procedure SetPQToAlloation(const Value :STring);
    procedure DoCancelAutoTransfer(Sender: TObject);
    function getCleanProcessed: Boolean;
    function DoProcessST: Boolean;

  protected
    procedure OnDataIdChange(const ChanGetype: TBusObjDataChanGetype);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    function  DoAfterInsert(Sender: TDatasetBusObj): Boolean;            override;
    procedure ClonePropertyObjects;                                      override;
    procedure CreateInstance;Override;
    procedure AfterCloneBusObj;Override;

  public
    constructor      Create(AOwner: TComponent);                         override;
    destructor       Destroy;                                            override;
    procedure        LoadFromXMLNode(const node: IXMLNode);            override;
    procedure        SaveToXMLNode(const node: IXMLNode);              override;
    Function         AutoTransfer(const IgnoreAvailable: boolean = false): boolean;
    function         DoAutoTransfer(const IgnoreAvailable: boolean): boolean;
    function         ValidateData: Boolean;                              override;
    function         Save: Boolean;                                      override;
    Function         Process                 : Boolean;
    Class function   GetIDField              : string;                   override;
    Class function   GetKeyStringField       : string;                   override;
    Class function   GetBusObjectTablename   : string;                   override;
    Class function   Transtype:STring;
    Property    OpenLookups             : TGeneralProc  Read fOpenLookups             write fOpenLookups;
    Property    AutoTransferDeptList    : TGeneralProc  REad fAutoTransferDeptList    write fAutoTransferDeptList;
    Property    AutoTransfertoClassIDs  : String        REad fsAutoTransfertoClassIDs Write fsAutoTransfertoClassIDs;
    Property    ShowStatus              : TTransProc1   Read fShowStatus              Write fShowStatus;
    Property StockMovement :TStockMovement read getStockMovement;
    class function _Schema: string; override;
    function CopyStockTransfer(var ErrMsg:String):Integer;
    Property CleanDeleted           : Boolean       Read GetCleanDeleted;
    Property PQFromAlloation :String Read getPQFromAlloation Write SETPQFromAlloation;
    Property PQToAlloation :String Read getPQToAlloation Write SETPQToAlloation;
    Property userallocating :Boolean read fbuserallocating write fbuserallocating;
    Property CrossStockAdjustTransForinvoice :Boolean read fbCrossStockAdjustTransForinvoice write fbCrossStockAdjustTransForinvoice;
    Property CleanProcessed :Boolean read getCleanProcessed;
    Function AnylinehasSerialNos :Boolean;
  published
    property TransferFromClassID       :Integer     read GetTransferFromClassID     write SetTransferFromClassID  ;
    property TransferFromClassName     :string      read GetTransferFromClassName   write SetTransferFromClassName;
    Property Description               :String      read getDescription             write setDescription;
    property AccountID                 :Integer     read GetAccountID               write SetAccountID ;
    property AccountName               :string      read GetAccountName             write SetAccountName;
    property EmployeeID                :Integer     read GetEmployeeID              write SetEmployeeID           ;
    property EmployeeName              :string      read GetEmployeeName            write SetEmployeeName         ;
    property DateTransferred           :TDateTime   read GetDateTransferred         write SetDateTransferred      ;
    Property StockMovementGlobalref    :String      read getStockMovementGlobalref  Write setStockMovementGlobalref;
    property Deleted                   :Boolean     read GetDeleted                 write SetDeleted              ;
    property CreationDate              :TDateTime   read GetCreationDate            write SetCreationDate         ;
    property Notes                     :string      read GetNotes                   write SetNotes                ;
    property Processed                 :Boolean     read GetProcessed               write SetProcessed            ;
    property EnforceUOM                :Boolean     Read getEnforceUOM              Write SetEnforceUOM;
    property SalesRef                  :String      read getSalesRef                write setSalesRef;
    property Transfertype              :String      read getTransfertype            write setTransfertype;
    property Shipping                  :String      read getShipping                write setShipping;
    Property DoProcessonSave :boolean read fbDoProcessonSave write fbDoProcessonSave;
    property Lines: TSTELines read GetLines;
    Property TreeLines :TSTELinesTree read getTreeLines;
    Property TreeLinesIn :TSTELinesTreeIn read getTreeLinesIn;

  end;


implementation


uses  tcDataUtils, CommonLib, BusObjConst, BusObjStock, MySQLConst, tcConst,
  CommonDbLib, sysutils, variants, BusObjClass,  ProductQtyLib,
  ProgressDialog,BusObjGLAccount, AppEnvironment, EmployeeObj ,
  BusObjProductbin, ParserLib, BusObjSchemaLib, BusObjEmployee, BusObjSales,
  BusObjClient,Dateutils , StockLib, PQALib, DbSharedObjectsObj;



{ TStockTransferEntry }

constructor TStockTransferEntry.Create(AOwner: TComponent);
begin
  CrossStockAdjustTransForinvoice := FAlse;
  fbuserallocating:= False;
  fbProcessing:= False;
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'StockTransfer';
  fSQL := 'SELECT * FROM tblstocktransferentry';
  fOpenLookups := nil;
  ExportExcludeList.Add('transferfromclassid');
  ExportExcludeList.Add('accountid');
  ExportExcludeList.Add('employeeid');
  fbDoProcessonSave := False;
end;


Class function TStockTransferEntry.GetIDField: string;
begin
  Result := 'TransferEntryID'
end;


Class function TStockTransferEntry.GetKeyStringField: string;
begin
  Result := 'Globalref'
end;


Class function TStockTransferEntry.GetBusObjectTablename: string;
begin
  Result := 'tblstocktransferentry'
end;


destructor TStockTransferEntry.Destroy;
begin
  inherited;
end;


procedure TStockTransferEntry.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TransferFromClassID');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'TransferFromClassName');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'Accountname');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'EmployeeName');
  SetPropertyFromNode(node,'DateTransferred');
  SetPropertyFromNode(node,'StockMovementGlobalref');
  SetPropertyFromNode(node,'Deleted');
  SetPropertyFromNode(node,'CreationDate');
  SetPropertyFromNode(node,'Notes');
  SetPropertyFromNode(node,'SalesRef');
  SetPropertyFromNode(node,'Transfertype');
  SetPropertyFromNode(node,'Shipping');
  SetPropertyFromNode(node,'Processed');
end;


procedure TStockTransferEntry.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TransferFromClassID' ,TransferFromClassID);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'TransferFromClassName' ,TransferFromClassName);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'AccountName' ,AccountName );
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'DateTransferred' ,DateTransferred);
  AddXMLNode(node, 'StockMovementGlobalref' , StockMovementGlobalref);
  AddXMLNode(node,'Deleted' ,Deleted);
  AddXMLNode(node,'CreationDate' ,CreationDate);
  AddXMLNode(node,'Notes' ,Notes);
  AddXMLNode(node,'SalesRef' ,SalesRef);
  AddXMLNode(node,'Transfertype' ,Transfertype);
  AddXMLNode(node,'Shipping' ,Shipping);
  AddXMLNode(node,'Processed' ,Processed);
end;


function TStockTransferEntry.ValidateData: Boolean ;
begin
    ResultStatus.Clear;
    result := inherited ValidateData;
    if not result then Exit;

    Result := False;
    if lines.dataset.recordcount = 0 then begin
        AddResult(True, rssWarning ,0 , 'Detail section is empty.');
        exit;
    end;
    if TransferFromClassID = 0 then begin
        AddResult(True, rssWarning ,0 , 'Transfer from class should not be blank.');
        exit;
    end;
    if AccountId = 0 then begin
        AddResult(True, rssWarning ,0 , 'Account should not be blank.');
        exit;
    end;
    if SalesRef <> '' then begin
      if TSales.IDGlobalRefToggle(SalesRef,Connection.Connection) < 1 then begin
        AddResult(True, rssWarning ,0 , 'Refrence Sale for Global Ref ' + SalesRef + ' not found.');
        exit;
      end;
    end;
    Lines.IterateRecords(KillInvlaidLines,true); {binny :filter should be disabled here }
    AllLinesValid:= true;
    Lines.IterateRecords(LineValidateCallbackProc );
    result:= AllLinesValid;
    if not result then exit;

end;
class function TStockTransferEntry._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TDeptClass','DeptClassObj','TransferFromClassID','ID');
  TBOSchema.AddRefType(result,'TDeptClass','DeptClassObj','DeptName','DeptClassName');
  TBOSchema.AddRefType(result,'TAccount','AccountObj','AccountID','ID');
  TBOSchema.AddRefType(result,'TAccount','AccountObj','AccountName','AccountName');
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','EmployeeID','ID');
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','EmployeeName','EmployeeName');
end;

procedure TStockTransferEntry.KillInvlaidLines(const Sender: TBusObj;  var Abort: boolean);
begin
  if not(Sender is TSTELinesFlat) then Exit;
  if TSTELinesFlat(Sender).Deleted then exit;
  if TSTELinesFlat(Sender).ClassIDFrom = TSTELinesFlat(Sender).ClassIDTo then begin
    if ((not(TSTELinesFlat(Sender).binproduct)) and (not (TSTELinesFlat(Sender).BatchProduct)) ) or
        ( (TSTELinesFlat(Sender).batchnofrom  = TSTELinesFlat(Sender).batchnoto) and
          (TSTELinesFlat(Sender).ExpiryDatefrom = TSTELinesFlat(Sender).ExpiryDateto) and
          (TSTELinesFlat(Sender).BinLocationFrom = TSTELinesFlat(Sender).BinLocationTo) and
          (TSTELinesFlat(Sender).Binnumberfrom = TSTELinesFlat(Sender).BinnumberTo)) then begin
        {from and to are all the same - so is invalid}
        Deleted := true;
        PostDB;
    end;
  end;
end;

procedure TStockTransferEntry.LineValidateCallbackProc(
  const Sender: TBusObj; var Abort: boolean);
begin
  if not(Sender is TSTELines) then Exit;
  if not (TSTELines(Sender).ValidateData) then  begin
    AllLinesValid := False;
    Abort := true;
  end;
end;

function TStockTransferEntry.Save: Boolean ;
var
  cmd: TERPCommand;
begin
  Result := False;
  ResultStatus.Clear;
  if deleted then begin
    if not (CleanDeleted) then begin
    PostDB;
    {deleting stock transfer should
        flag the Stock transfer header as deleted
        Lines should not be deleted
        stockmovement , movementlines, pqa , pqa details all should be physically deleted}
      if PRocessed then begin
        Deletetransfer;
      end
      else begin
        { delete pqa stuff }
        cmd := DbSharedObj.GetCommand(Connection.Connection);
        try
          cmd.SQL.Text := 'delete from tblstocktransferentrypqadetails where PQAID in ' +
            '(select distinct PQAID from tblstocktransferentrypqa where TransID = ' + IntToStr(self.ID) + ')';
          cmd.Execute;
          cmd.SQL.Text := 'delete from tblstocktransferentrypqa where TransID = ' + IntToStr(self.ID);
          cmd.Execute;
        finally
          DbSharedObj.ReleaseObj(cmd);
        end;

      end;
    end;
    result := true;
    exit;
  end else if processed and not(CleanProcessed) and not(fbProcessing) then begin
    if not ValidateData then Exit;
    DeleteFlagedLines;
    Result := inherited Save;
    if result then dirty := False;
    REsult := DoProcessST;
    Exit;
  end else if not(processed) and fbDoProcessonSave then begin
    if not ValidateData then Exit;
    DeleteFlagedLines;
    Result := inherited Save;
    if result then dirty := False;
    REsult := DoProcessST;
    Exit;
  end else if processed then begin
      PostDB;
      Result := true;
      Exit;
  end;
  if not ValidateData then Exit;
  DeleteFlagedLines;
  Result := inherited Save;
  if result then dirty := False;
end;


procedure TStockTransferEntry.CallbackProcess(const Sender: TBusObj;  var Abort: boolean);
var
  fromMovementLineID: Integer;
  ToMovementLineID  : Integer;
  PQABatch          : TPQABatch;
  PQABins           : TPQABins;
  PQASN             : TPQASN;
  ctr               : Integer;
  st:TStringList;

  Function nullifEmpty(date:TDAteTime) :Variant ; begin
    if date = 0 then result := null else result := Date;
  End;
  function getPQABatch:TPQABatch;begin
    result := nil;
    if not TSTELinesFlat(Sender).Product.Batch then Exit;
    result := Stockmovement.Lines.PQA.PQABatch
  end;
  function getPQABins:TPQABins; begin
    result := nil;
    if not TSTELinesFlat(Sender).Product.multiplebins then exit;
    if TSTELinesFlat(Sender).Product.Batch then      result := Stockmovement.Lines.PQA.PQABatch.PQAbins
    else result := Stockmovement.Lines.PQA.PQAbins;
  end;
  function getPQASN:TPQASN; begin
    result := nil;
    if not TSTELinesFlat(Sender).Product.SNtracking then exit;
    if (TSTELinesFlat(Sender).Product.Batch) and (TSTELinesFlat(Sender).Product.multiplebins) then
      result := Stockmovement.Lines.PQA.PQABatch.PQAbins.PQASN
    else if (TSTELinesFlat(Sender).Product.Batch) then result := Stockmovement.Lines.PQA.PQABatch.PQASN
    else if (TSTELinesFlat(Sender).Product.multiplebins) then result := Stockmovement.Lines.PQA.PQAbins.PQASN
    else result := Stockmovement.Lines.PQA.PQASN;
  end;

  function CreateBatch(const Batchno :STring; const expiryDate:TDatetime):Boolean;begin
    result := False;
    PQABatch := getPQABatch;
    if not Assigned(PQABatch) then exit;
    if not(PQABatch.Dataset.Locate('Value;ExpiryDate' ,VarArrayof([batchno, nullifEmpty(ExpiryDate)]), [])) then begin
        PQABatch.NEw;
        PQABatch.Batchno :=batchno;
        PQABatch.ExpiryDate:=expirydate;
        PQABatch.PostDB;
    end;
    result := True;
  end;
  function CreateBinLocation(const xclassid:Integer; const binlocation:STring; const binnumber:String):Boolean;
  var
    binID:Integer;
  begin
    result := False;
    PQABins := getPQABins;
    if not Assigned(PQABins) then exit;
    //binID:=tcDatautils.getBinID(binlocation, binnumber);
    binID := TProductBin.IDToggle(xClassid, binlocation, binnumber);
    if (binID = 0) or (not(PQABins.Dataset.Locate('Value' ,IntToStr(binID), []))) then begin
        PQABins.NEw;
        if binID <> 0 then begin
          PQABins.BinID := binID;
        end else begin
          PQABins.binlocation := binlocation;
          PQABins.binnumber   := binnumber;;
          if (PQABins.BinId = 0) then
            PQABins.BinId := TProductBin.IDToggle(PQABins.DepartmentID ,PQABins.fsbinlocation, PQABins.fsBinnumber);
        end;
        PQABins.PostDB;
    end;
    result := True;
  end;
  function CreateSN(const Serialnumber:STring; CONST fQty :Double):Boolean;  begin
    result := False;
    PQASN:= getPQASN;
    if not(Assigned(PQASN)) then exit;
    if not(PQASN.dataset.Locate('Value' , Serialnumber,[])) then begin
        PQASN.New;
        PQASN.Qty := fQty;
        PQASN.SerialNumber :=Serialnumber;
        PQASN.PostDB;
    end;
    result := true;
  end;
  Procedure AddFromMovementLine;begin
    if fromMovementLineID= 0 then Stockmovement.Lines.New
    else Stockmovement.Lines.Locate(Stockmovement.Lines.IdFieldname , fromMovementLineID , []);
    Stockmovement.Lines.MovementDate   :=incsecond(TSTELines(Sender).DateTransferred, -1);
    Stockmovement.Lines.ProductId      :=TSTELines(Sender).ProductId;
    Stockmovement.Lines.DeptID         :=TSTELines(Sender).classIDFrom;
    Stockmovement.Lines.ProductName    :=TSTELines(Sender).ProductName;
    Stockmovement.Lines.Description    :=TSTELines(Sender).ProductDesc;
    Stockmovement.Lines.DeptName       :=TransferFromClassName;
    Stockmovement.Lines.UnitOfMeasure  :=TSTELines(Sender).UnitOfMeasure;
    Stockmovement.Lines.UnitOfMeasureID:=TSTELines(Sender).UnitOfMeasureID;
    Stockmovement.Lines.UOMMultiplier  :=TSTELines(Sender).UOMMultiplier;
    Stockmovement.Lines.Qty            :=Stockmovement.Lines.Qty+TSTELines(Sender).TransferQty;
    Stockmovement.Lines.UOMQty         :=Stockmovement.Lines.UOMQty +TSTELines(Sender).UOMTransferQty;
    Stockmovement.Lines.AssetAccountID :=TSTELines(Sender).AccountID;
    Stockmovement.Lines.AccountId      :=AccountID;
    Stockmovement.Lines.Value          :=TSTELines(Sender).AssetValue;
    Stockmovement.Lines.Cost           :=TSTELines(Sender).AssetValue;
    Stockmovement.Lines.MatrixDesc     :=TSTELines(Sender).MatrixDesc;
    Stockmovement.Lines.MatrixRef      :=TSTELines(Sender).MatrixRef;
    Stockmovement.Lines.MatrixPrice    :=TSTELines(Sender).MatrixPrice;
    Stockmovement.Lines.PostDB;
    Stockmovement.Lines.PQA.Alloctype := 'OUT';
    Stockmovement.Lines.PQA.PostDB;
    fromMovementLineID :=Stockmovement.Lines.id;
    if MovementLines.Active then MovementLines.Close;
    MovementLines.open;
  end;
  Procedure AddToMovementLine;begin
    if ToMovementLineID  = 0 then Stockmovement.Lines.New
    else Stockmovement.Lines.Locate(Stockmovement.Lines.IdFieldname , ToMovementLineID , []);
    Stockmovement.Lines.MovementDate   :=TSTELines(Sender).DateTransferred;
    Stockmovement.Lines.ProductId      :=TSTELines(Sender).ProductId;
    Stockmovement.Lines.DeptID         :=TSTELines(Sender).ClassIDTo;
    Stockmovement.Lines.ProductName    :=TSTELines(Sender).ProductName;
    Stockmovement.Lines.Description    :=TSTELines(Sender).ProductDesc;
    Stockmovement.Lines.DeptName       :=TSTELines(Sender).ClassNameTo;
    Stockmovement.Lines.UnitOfMeasure  :=TSTELines(Sender).UnitOfMeasure;
    Stockmovement.Lines.UnitOfMeasureID:=TSTELines(Sender).UnitOfMeasureID;
    Stockmovement.Lines.UOMMultiplier  :=TSTELines(Sender).UOMMultiplier;
    Stockmovement.Lines.Qty            :=Stockmovement.Lines.Qty +TSTELines(Sender).TransferQty;
    Stockmovement.Lines.UOMQty         :=Stockmovement.Lines.UOMQty+TSTELines(Sender).UOMTransferQty;
    Stockmovement.Lines.AssetAccountID :=TSTELines(Sender).AccountID;
    Stockmovement.Lines.AccountId      :=AccountID;
    Stockmovement.Lines.Value          :=TSTELines(Sender).AssetValue;
    Stockmovement.Lines.Cost           :=TSTELines(Sender).AssetValue;
    Stockmovement.Lines.MatrixDesc     :=TSTELines(Sender).MatrixDesc;
    Stockmovement.Lines.MatrixRef      :=TSTELines(Sender).MatrixRef;
    Stockmovement.Lines.MatrixPrice    :=TSTELines(Sender).MatrixPrice;
    Stockmovement.Lines.PostDB;
    Stockmovement.Lines.PQA.Alloctype := 'IN';
    Stockmovement.Lines.PQA.PostDB;
    TOMovementLineID :=Stockmovement.Lines.id;
    if MovementLines.Active then MovementLines.Close;
    MovementLines.open;
  end;
begin
  ProgressDialog.DoStepProgressbar;
    if not (Sender is TSTELinesFlat) then exit;
    fromMovementLineID:= 0;
    ToMovementLineID  := 0;
    Show_Status('Moving ' + TSTELinesFlat(Sender).ProductName + ' from ' +TransferFromClassName + ' to ' + TSTELinesFlat(Sender).ClassNameTo + chr(13)+'Record :' + IntToStr(TSTELinesFlat(Sender).dataset.recno) +' of ' + IntToStr(TSTELinesFlat(Sender).dataset.recordcount));

    if MovementLines.Locate('ProductID;ClassID;UOMID;Alloctype',
      vararrayof([TSTELinesFlat(Sender).ProductId,TSTELinesFlat(Sender).classIDFrom,TSTELinesFlat(Sender).UnitOfMeasureID,'IN']),[]) then
      fromMovementLineID:=MovementLines.fieldByname('StockMovementLinesID').asInteger;

    if MovementLines.Locate('ProductID;ClassID;UOMID;Alloctype',
      vararrayof([TSTELinesFlat(Sender).ProductId,TSTELinesFlat(Sender).ClassIDTo,TSTELinesFlat(Sender).UnitOfMeasureID,'IN']),[]) then
      toMovementLineID:=MovementLines.fieldByname('StockMovementLinesID').asInteger;



    (*if fromMovementLineID= 0 then *)AddfromMovementLine;
   (*if ToMovementLineID  = 0 then *)AddToMovementLine;
      if TSTELinesFlat(Sender).BatchNoFrom <> '' then begin
        Stockmovement.Lines.Dataset.Locate(Stockmovement.Lines.IDFieldName , fromMovementLineID, []);

        if CreateBatch(TSTELinesFlat(Sender).BatchNoFrom , TSTELinesFlat(Sender).expirydateFrom) then begin
          PQABatch.Qty    := PQABatch.Qty+ ((*0-*)TSTELinesFlat(Sender).TransferAllocatedQty);
          PQABatch.PostDB;
        end;
      end;

      if TSTELinesFlat(Sender).BatchNoTo<> '' then begin
        Stockmovement.Lines.Dataset.Locate(Stockmovement.Lines.IDFieldName , ToMovementLineID, []);
        if CreateBatch(TSTELinesFlat(Sender).BatchNoTo , TSTELinesFlat(Sender).expiryDateTo) then begin
          PQABatch.Qty    := PQABatch.Qty+ (TSTELinesFlat(Sender).TransferAllocatedQty);
          PQABatch.PostDB;
        end;
      end;


      if TSTELinesFlat(Sender).BinLocationFrom <> '' then begin
        Stockmovement.Lines.Dataset.Locate(Stockmovement.Lines.IDFieldName , fromMovementLineID, []);
        if CreateBinLocation(TSTELinesFlat(Sender).classidfrom, TSTELinesFlat(Sender).BinLocationFrom, TSTELinesFlat(Sender).BinnumberFrom) then begin
          PQABins.Qty    := PQABins.Qty+ ((*0-*)TSTELinesFlat(Sender).TransferAllocatedQty);
          PQABins.PostDB;
        end;
      end;

      if TSTELinesFlat(Sender).BinLocationTo <> '' then begin
        Stockmovement.Lines.Dataset.Locate(Stockmovement.Lines.IDFieldName , ToMovementLineID, []);
        if CreateBinLocation(TSTELinesFlat(Sender).classidto, TSTELinesFlat(Sender).BinLocationto, TSTELinesFlat(Sender).Binnumberto) then begin
          PQABins.Qty    := PQABins.Qty+ (TSTELinesFlat(Sender).TransferAllocatedQty);
          PQABins.PostDB;
        end;
      end;
      if trim(TSTELinesFlat(Sender).TransferSerialnos)<> '' then begin
          st:=TStringList.Create ;
          try
            st.Commatext :=TSTELinesFlat(Sender).TransferSerialnos;
            for ctr:= 0 to st.count-1 do begin
                Stockmovement.Lines.Dataset.Locate(Stockmovement.Lines.IDFieldName , fromMovementLineID, []);
                if CreateSN(st[ctr] , 1) then begin
                  PQASN.PostDB;
                end;
                Stockmovement.Lines.Dataset.Locate(Stockmovement.Lines.IDFieldName , ToMovementLineID, []);
                if CreateSN(st[ctr]  , 1) then begin
                  PQASN.PostDB;
                end;
            end;
          finally
            Freeandnil(st);
          end;
      end else if TSTELinesFlat(Sender).SerialNumbers<> '' then begin
        Stockmovement.Lines.Dataset.Locate(Stockmovement.Lines.IDFieldName , fromMovementLineID, []);
        if CreateSN(TSTELinesFlat(Sender).SerialNumbers , 1) then begin
          PQASN.PostDB;
        end;
        Stockmovement.Lines.Dataset.Locate(Stockmovement.Lines.IDFieldName , ToMovementLineID, []);
        if CreateSN(TSTELinesFlat(Sender).SerialNumbers , 1) then begin
          PQASN.PostDB;
        end;
      end;
      if fromMovementLineID <> 0 then Stockmovement.Lines.Dataset.Locate(Stockmovement.Lines.IDFieldName , fromMovementLineID, []);
end;

Function TStockTransferEntry.CopyStockTransfer(var ErrMsg:String):Integer;
begin
Result := 0;
       FieldsnotToclone:=
                QuotedStr('StockMovementGlobalref') + ',' +
                QuotedStr('Deleted') + ',' +
                QuotedStr('CreationDate') + ',' +
                QuotedStr('Processed') + ',' +
                QuotedStr('msUpdateSiteCode') + ',' +
                QuotedStr('SalesRef') ;
        if Self.CloneBusObj('CreationDate',DateOf(now),False, 'TransferEntryID') <> nil then begin
          if TStockTransferEntry(ObjInstanceToClone).Save then begin
            Result := TStockTransferEntry(ObjInstanceToClone).ID;
            UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
          end else begin
            ErrMsg:= TStockTransferEntry(ObjInstanceToClone).ResultStatus.GetLastFatalStatusItem.Message;
          end;
        end;
end;

procedure TStockTransferEntry.OnDataIdChange(const ChanGetype: TBusObjDataChanGetype);
begin
  inherited;
  if Processed then NoRightReason := 'The Stock Transfer is already Processed';
end;


procedure TStockTransferEntry.DoFieldOnChange(Sender: TField);
begin
if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.FieldName , 'TransferFromClassName') then begin
      TransferfromClassId:= TDeptClass.IDToggle(TransferFromClassName , self.connection.connection);
      if not RawMode then begin
        DoFieldOnChange(Dataset.findfield('TransferfromClassId'));
      end;
    end else if Sysutils.SameText(Sender.fieldname, 'TransferfromClassId') then begin
      TransferfromClassName:= TDeptClass.IDToggle(TransferFromClassId , self.connection.connection);
      if not RawMode then begin
        PostDB;
        if (Lines.Dataset.Recordcount> 0) then begin
            Lines.IterateRecords(CalcualteAvailableQty)
        end;
        if Assigned(OpenLookups) then OpenLookups;
      end;
    end else if Sysutils.SameText(Sender.fieldName , 'AccountName') then begin
      AccountID := TAccount.IDToggle(AccountName);
      if not RawMode then begin
        DoFieldOnChange(dataset.findfield('AccountID'));
      end;
    end else if Sysutils.SameText(Sender.fieldName , 'AccountID') then begin
      AccountName := TAccount.IDToggle(AccountID);
    end
    else if Sysutils.SameText(Sender.fieldName , 'EmployeeID') then begin
      EmployeeName := TEmployee.IDToggle(EmployeeID, Connection.Connection);
    end
    else if Sysutils.SameText(Sender.fieldName , 'EmployeeName') then begin
      EmployeeID := TEmployee.IDToggle(EmployeeName, Connection.Connection);
    end;
end;


function TStockTransferEntry.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TStockTransferEntry.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property functions}
function  TStockTransferEntry.GetTransferFromClassID  : Integer   ; begin Result := GetIntegerField('TransferFromClassID');end;
function  TStockTransferEntry.GetTransferFromClassName: string    ; begin Result := GetStringField('TransferFromClassName');end;
function  TStockTransferEntry.GetDescription          : string    ; begin Result := GetStringField('Description');end;
function  TStockTransferEntry.GetAccountID            : Integer   ; begin Result := GetIntegerField('AccountID');end;
function  TStockTransferEntry.GetAccountName          : string    ; begin Result := GetStringField('AccountName');end;
function  TStockTransferEntry.GetEmployeeID           : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TStockTransferEntry.GetEmployeeName         : string    ; begin Result := GetStringField('EmployeeName');end;
function  TStockTransferEntry.GetDateTransferred      : TDateTime ; begin Result := GetDateTimeField('DateTransferred');end;
Function  TStockTransferEntry.getStockMovementGlobalref:String    ; begin Result := GetStringField('StockMovementGlobalref'); end;
function  TStockTransferEntry.GetDeleted              : Boolean   ; begin Result := GetBooleanField('Deleted');end;
function TStockTransferEntry.GetCleanDeleted: Boolean;begin  Result:= GetXMLNodeBooleanValue(CleanXMLNode, 'Deleted');end;
function  TStockTransferEntry.GetCreationDate         : TDateTime ; begin Result := GetDateTimeField('CreationDate');end;
function  TStockTransferEntry.GetNotes                : string    ; begin Result := GetStringField('Notes');end;
function  TStockTransferEntry.GetProcessed            : Boolean   ; begin Result := GetBooleanField('Processed');end;
function  TStockTransferEntry.getEnforceUOM           : Boolean   ; begin REsult := Getbooleanfield('EnforceUOM');end;
function  TStockTransferEntry.GetSalesRef             : string    ; begin Result := GetStringField('SalesRef');end;
function  TStockTransferEntry.GetTransfertype         : string    ; begin Result := GetStringField('Transfertype');end;
function  TStockTransferEntry.GetShipping             : string    ; begin Result := GetStringField('Shipping');end;
procedure TStockTransferEntry.SetEnforceUOM           (const Value: Boolean   ); begin SetBooleanField('EnforceUOM' , Value);end;
procedure TStockTransferEntry.SetSalesRef             (const Value: string    ); begin SetStringField('SalesRef' , Value);end;
procedure TStockTransferEntry.SetTransfertype         (const Value: string    ); begin SetStringField('Transfertype' , Value);end;
procedure TStockTransferEntry.SetShipping             (const Value: string    ); begin SetStringField('Shipping' , Value);end;
procedure TStockTransferEntry.SetAccountID            (const Value: Integer   ); begin SetIntegerField('AccountID'   , Value);end;
procedure TStockTransferEntry.SetAccountName          (const Value: string    ); begin SetStringField('AccountNAme' , Value);end;
procedure TStockTransferEntry.SetTransferFromClassID  (const Value: Integer   ); begin SetIntegerField('TransferFromClassID'   , Value);end;
procedure TStockTransferEntry.SetTransferFromClassName(const Value: string    ); begin SetStringField('TransferFromClassName' , Value);end;
procedure TStockTransferEntry.SetDescription          (const Value: string    ); begin SetStringField('Description' , Value);end;
procedure TStockTransferEntry.SetEmployeeID           (const Value: Integer   ); begin SetIntegerField('EmployeeID'            , Value);end;
procedure TStockTransferEntry.SetEmployeeName         (const Value: string    ); begin SetStringField('EmployeeName'          , Value);end;
procedure TStockTransferEntry.SetDateTransferred      (const Value: TDateTime ); begin SetDateTimeField('DateTransferred'       , Value);end;
Procedure TStockTransferEntry.SetStockMovementGlobalref(Const Value:String    ); begin SetStringField('StockMovementGlobalref',Value);end;
procedure TStockTransferEntry.SetDeleted              (const Value: Boolean   ); begin SetBooleanField('Deleted'               , Value);end;
procedure TStockTransferEntry.SetCreationDate         (const Value: TDateTime ); begin SetDateTimeField('CreationDate'          , Value);end;
procedure TStockTransferEntry.SetNotes                (const Value: string    ); begin SetStringField('Notes'                 , Value);end;
procedure TStockTransferEntry.SetProcessed            (const Value: Boolean   ); begin SetBooleanField('Processed'             , Value);end;

Function TStockTransferEntry.GetPQFromAlloation       :String; begin REsult := getStringfield('PQAFrom');         end;
Function TStockTransferEntry.GetPQToAlloation         :String; begin REsult := getStringfield('PQATo');         end;
Procedure TStockTransferEntry.SetPQFromAlloation      (const Value :STring); begin SetStringfield('PQAFrom' , Value);         end;
Procedure TStockTransferEntry.SetPQToAlloation        (const Value :STring); begin SetStringfield('PQATo' , Value);         end;
function TStockTransferEntry.getCleanProcessed: Boolean;
begin
  result := GetXMLNodeBooleanValue(CleanXMLNOde, 'Processed');
end;

procedure TStockTransferEntry.CalcualteAvailableQty(const Sender: TBusObj;
  var Abort: boolean);
begin
    if not (sender is TSTELinesFlat) then Exit;
    TSTELinesFlat(Sender).ProductQty;
    TSTELinesFlat(Sender).CalcQtys;
end;


function TStockTransferEntry.GetTreeLines: TSTELinesTree;
begin
  Result := TSTELinesTree(GetContainerComponent(TSTELinesTree , 'TransferEntryID= ' + IntToStr(ID)));
  if assigned(Result) then begin
    Result.OpenLookups := OpenLookups;
  end;
end;

function TStockTransferEntry.getTreeLinesIn: TSTELinesTreeIn;
begin
  Result := TSTELinesTreeIn(GetContainerComponent(TSTELinesTreeIn , 'TransferEntryID= ' + IntToStr(ID)));
  if assigned(Result) then begin
    Result.OpenLookups := OpenLookups;
  end;
end;

function TStockTransferEntry.GetLines: TSTELines;
begin
  if Transfertype = StockTransfertypetoStr(sttGen) then begin
    Result := TSTELinesFlat(GetContainerComponent(TSTELinesFlat , 'TransferEntryID= ' + IntToStr(ID)));
  end else begin
    Result :=TreeLines;
  end;
  if assigned(Result) then begin
    Result.OpenLookups := OpenLookups;
  end;

end;
Procedure TStockTransferEntry.Show_Status(Const Value :String);
begin
  if Assigned(fShowStatus) then fShowStatus(Value);
end;

procedure TStockTransferEntry.DeleteLine(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not(Sender is TSTELines) then exit;
  TSTELines(Sender).Deleted:= true;
  TSTELines(Sender).PostDB;
end;


function TStockTransferEntry.AnylinehasSerialNos: Boolean;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Qry.Sql.text := 'Select count(*) ctr from tblstocktransferentrylines where TransferEntryID =' + inttostr(ID)+' and ifnull(Serialnos,"")<> ""';
    Qry.open;
    result := Qry.Fieldbyname('ctr').asInteger >0;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function TStockTransferEntry.AutoTransfer(const IgnoreAvailable: boolean): boolean;
begin
    REsult := False;
    if TransferfromClassID = 0 then exit;
    if Assigned(fAutoTransferDeptList) then fAutoTransferDeptList;
    Result :=   DoAutoTransfer(IgnoreAvailable);
end;
function TStockTransferEntry.DoAutoTransfer(const IgnoreAvailable: boolean): boolean;
var
    strSQL :String;
    ProductsofToClassTableName, ProductsofFromClassTableName :String;
    ProductsofToClass : TERPQuery;
    ProductsofFromClass: TERPQuery;
    dTotal:Double;
    dAvailable :double;
    PqaQtys:STring;
    autoID:Integer;
    xProductID:Integer;
    PreferedLevel:double;
begin
  REsult := False;
  CancelAutoTransfer := false;
    {delete all the existing lines}
    strSQL := '';
    
    xProductID :=Lines.ProductID;
    if Lines.count > 0 then
      Lines.Iteraterecords(DeleteLine);
        (*getNewDataset('update tblstocktransferentrylines Set Deleted = "T" where TransferEntryId = ' + IntToStr(ID) , True);*)

    ProductsofToClassTableName := GetUserTemporaryTableName('ProductsofToClass');
    ProductsofFromClassTableName := GetUserTemporaryTableName('ProductsofFromClass');

    strSQL :=strSQL+ chr(13)+'/*1*/Drop table if Exists ' +ProductsofToClassTableName+';';
    strSQL :=strSQL+ chr(13)+'/*2*/Drop table if Exists ' +ProductsofFromClassTableName+';';
    TRy

        Show_Status('Reading Available stock  to transfer'  );
        strSQL :=strSQL+ chr(13)+'/*3*/create table ' + ProductsofToClassTableName +' '  +
              ' Select PC.ProductID , PC.ProductName , PC.ClassId, PC.classname, '+
              ' PC.ReorderPoint, PC.PreferredLevel, PC.ReorderAmount, '+
              ProductQtyLib.SQL4Qty(tAvailable)+'  as Available  '+
              ' from tblProductClasses as PC'+
              ' Left join tblPQA as PQA on PC.classId = PQA.DepartmentId and PC.ProductID = PQA.ProductID';
        if xProductID <> 0 then
          strSQL := strSQL + ' WHERE PC.ProductID = ' +IntToStr(xProductID)
        else strSQL := strSQL + ' WHERE PC.ProductID <> 0';

        if AutoTransfertoClassIDs <> '' then
            strSQL := strSQL + ' AND PC.ClassID in (' + AutoTransfertoClassIDs+')'
        else
            strSQL := strSQL + ' AND PC.ClassID <> ' + IntToStr(TransferfromClassID) ;

        strSQL:= strSQL + ' group by ProductID , ClassId';
        strSQL := strSQL + '  Order by PC.ProductID, PC.ClassId;';
        strSQL := strSQL+ chr(13)+'/*3-1*/ALTER TABLE  ' +ProductsofToClassTableName +  ' 	ENGINE=MYISAM;';
        strSQL := strSQL+ chr(13)+'/*4*/Delete from ' +ProductsofToClassTableName +  ' Where Available > Reorderpoint;';
        strSQL := strSQL+ chr(13)+'/*5*/ALTER TABLE ' +ProductsofToClassTableName +  ' ADD `AutoID` INT AUTO_INCREMENT First ,add PRIMARY KEY(`AutoID`);';

        Show_Status('Reading classes need stock'  );

        PqaQtys :=  SQL4Qty(tAvailable,'PQA' , DetailQtyfield(tSummary)) +' as PQAQty,'+
                    SQL4Qty(tAvailable,'PQA' , DetailQtyfield(tSummary, true)) +' as PQAUOMQty';
        strSQL := strSQL+ chr(13)+'/*6*/create table ' + ProductsofFromClassTableName + '  ' +
          ProductQtyLib.SQL4ProductAvailableQty(DateTransferred , '' , tDetailswithSno,xProductID , TransferFromClassID, '' , 0 , '' , '', '' , tAvailable , PQAQtys , '' , 0 , false , false , true)+';';

        strSQL := strSQL+ chr(13)+'/*7*/ALTER TABLE ' +ProductsofFromClassTableName +  ' ADD `AutoID` INT AUTO_INCREMENT First ,add PRIMARY KEY(`AutoID`);';
        getNewDataset(strSQL,False);
        ProductsofToClass := TERPQuery(getNewDataset('Select * from ' +ProductsofToClassTableName +' Order by PreferredLevel' ,False));
        if ProductsofToClass.Recordcount = 0 then Exit;
        ProductsofFromClass := TERPQuery(getNewDataset('Select * from ' +ProductsofFromClassTableName ,False));
        if ProductsofFromClass.REcordcount = 0 then exit;
        ProgressDialog.DoShowProgressbar(ProductsofToClass.recordcount, 'Auto Transfer Stock', 'Please Wait', True, false, DoCancelAutoTransfer, true);
        try
          Lines.Dataset.disablecontrols;
          Try
              ProductsofFromClass.first;
              While ProductsofToClass.eof = False do begin
                  Show_Status('Transfering ' + ProductsofToClass.FieldByname('ProductName').asString);
                  dTotal := (ProductsofToClass.FieldByName('PreferredLevel').AsFloat - ProductsofToClass.FieldByName('Available').AsFloat);
                  if ProductsofFromClass.Locate('PartsId' ,ProductsofToClass.FieldByname('ProductID').asInteger , []) then begin
                      PreferedLevel := ProductsofFromClass.FieldByname('PreferredLevel').asFloat;
                      While (ProductsofFromClass.Eof = False) and (dTotal > 0) and
                              (ProductsofFromClass.FieldByname('PartsID').asInteger = ProductsofToClass.FieldByname('ProductID').asInteger) do begin
                          if (ProductsofFromClass.FieldByname('Batchno').asString <> '') or (ProductsofFromClass.FieldByname('Binlocation').asString <> '') or (ProductsofFromClass.FieldByname('Serialnumber').asString <> '') then begin
                              if IgnoreAvailable then
                                dAvailable := dTotal
                              else
                                dAvailable := ProductsofFromClass.FieldByname('Qty').asFloat - PreferedLevel;
                              if  PreferedLevel>0 then PreferedLevel := PreferedLevel -ProductsofFromClass.FieldByname('Qty').asFloat;
                              if PreferedLevel<0 then PreferedLevel := 0;
                          end
                          else begin
                            if IgnoreAvailable then
                              dAvailable := dTotal
                            else
                              dAvailable := ProductsofFromClass.FieldByname('PQAQty').asFloat - PreferedLevel;
                          end;

                          if  ((dAvailable > 0) (*and (ProductsofFromClass.fieldByname('PQAQty').asFloat > 0))  and
                              (((ProductsofFromClass.FieldByname('Batchno').asString <> '') or (ProductsofFromClass.FieldByname('Binlocation').asString <> '') or (ProductsofFromClass.FieldByname('Serialnumber').asString <> '')) and (ProductsofFromClass.fieldByname('Qty').asFloat > 0)  *))
                                then begin
                              Lines.New;
                              Lines.DoFieldChangewhenDisabled:= True;
                              Lines.LockbinBatchFields(False);
                              Lines.Classidto     :=ProductsofToClass.FieldByname('ClassId').asInteger;
                              Lines.ClassnameTo   := ProductsofToClass.FieldByname('Classname').asString;
                              Lines.ProductID     := ProductsofToClass.FieldByname('ProductID').asInteger;
                              Lines.ProductDesc   := Lines.Product.SalesDescription;
                              Lines.ProductName   := TProduct.IDToggle(Lines.ProductID , self.Connection.Connection);

                              if ProductsofFromClass.FieldByname('Batchno').asString <> '' then begin
                                  TSTELinesFlat(Lines).BatchNoFrom   := ProductsofFromClass.FieldByname('Batchno').asString;
                                  TSTELinesFlat(Lines).ExpiryDateFrom:= ProductsofFromClass.FieldByname('ExpiryDate').asDatetime;
                                  TSTELinesFlat(Lines).BatchNoTo     := ProductsofFromClass.FieldByname('Batchno').asString;
                                  TSTELinesFlat(Lines).ExpiryDateTO  := ProductsofFromClass.FieldByname('ExpiryDate').asDatetime;
                              end;
                              if ProductsofFromClass.FieldByname('Binlocation').asString <> '' then  begin
                                  TSTELinesFlat(Lines).Binlocationfrom   := ProductsofFromClass.FieldByname('BinLocation').asString;
                                  TSTELinesFlat(Lines).Binnumberfrom     := ProductsofFromClass.FieldByname('BinNumber').asString;
                                  TSTELinesFlat(Lines).BinlocationTo     := ProductsofFromClass.FieldByname('BinLocation').asString;
                                  TSTELinesFlat(Lines).BinnumberTo       := ProductsofFromClass.FieldByname('BinNumber').AsString;
                              end;
                              if ProductsofFromClass.FieldByname('Serialnumber').asString <> '' then
                                Lines.SerialNumbers := ProductsofFromClass.FieldByname('Serialnumber').asString;

                              {TODO PQA - check whether DoFieldOnChange is not triggered or not, available qty should be calcualted by DoFieldOnChange otherwise}
                              Lines.AvailableQty         := ProductsofFromClass.fieldByname('PQAQty').asFloat;
                              Lines.UOMAvailableQty      := Lines.AvailableQty/Lines.Uommultiplier;

                              if (dtotal <=dAvailable) then begin
                                Lines.Transferqty := dtotal;
                              end else begin
                                Lines.Transferqty := dAvailable;
                              end;
                              Lines.UOMTransferqty     := Lines.Transferqty/Lines.Uommultiplier;


                              if (TSTELinesFlat(Lines).BatchNoFrom <> '') or (TSTELinesFlat(Lines).BinLocationFrom <> '') or (TSTELinesFlat(Lines).serialnumbers <> '') then begin
                                TSTELinesFlat(Lines).AllocatedQty         := ProductsofFromClass.fieldByname('Qty').asFloat;
                                TSTELinesFlat(Lines).UOMAllocatedQty      := TSTELinesFlat(Lines).AllocatedQty/TSTELinesFlat(Lines).Uommultiplier;
                                //TSTELinesFlat(Lines).AllocatedQty        := ProductsofFromClass.fieldByname('Qty').asFloat;
                                if (dtotal <=dAvailable) then begin
                                  TSTELinesFlat(Lines).TransferAllocatedQty := dtotal;
                                end else begin
                                  TSTELinesFlat(Lines).TransferAllocatedQty := dAvailable;
                                end;
                                TSTELinesFlat(Lines).TransferUOMAllocatedQty     := TSTELinesFlat(Lines).TransferAllocatedQty/Lines.Uommultiplier;
                              end;



                              if (TSTELinesFlat(Lines).BatchNoFrom <> '') or (TSTELinesFlat(Lines).BinLocationFrom <> '') or (TSTELinesFlat(Lines).serialnumbers <> '') then
                                TSTELinesFlat(Lines).TransferAllocatedQty := Lines.Transferqty;

                              Lines.Uomtransferqty :=Lines.Transferqty /Lines.Uommultiplier;
                              if TSTELinesFlat(Lines).TransferAllocatedQty<> 0 then  TSTELinesFlat(Lines).TransferUOMAllocatedQty:= TSTELinesFlat(Lines).TransferAllocatedQty/Lines.Uommultiplier;

                              dTotal := dTotal - Lines.Transferqty;
                              //dAvailable:= dAvailable -Lines.Transferqty;

                              AutoID :=ProductsofFromClass.FieldByname('AutoID').asInteger;
                              strSQL:= 'update  ' +  ProductsofFromClassTableName  + ' Set PQAQty = PQAQty - ' +floattoStr(Lines.Transferqty) +' where /*autoId >= ' + IntToStr(AutoID)+ ' and */ PartsId = ' +IntToStr(ProductsofFromClass.FieldByname('PartsID').asInteger)+';';
                              if (TSTELinesFlat(Lines).BatchNoFrom <> '') or (TSTELinesFlat(Lines).BinLocationFrom <> '') or (TSTELinesFlat(Lines).serialnumbers <> '') then
                                strSQL:= strSQL+'update  ' +  ProductsofFromClassTableName  + ' Set Qty = Qty - ' +floattoStr(TSTELinesFlat(Lines).TransferAllocatedQty) +' where AutoId ='+IntToStr(AutoID);
                              getnewDataset(strSQL);
                              ProductsofFromClass.close;
                              ProductsofFromClass.Open;
                              ProductsofFromClass.locate('AutoID' , autoId , []);
                              Lines.PostDB;
                          end;

                          ProductsofFromClass.Next;
                      End;
                  end;
                  ProductsofToClass.Next;
                  ProgressDialog.DoStepProgressbar(ProductsofToClass.FieldByname('ProductName').asString);
                  if CancelAutoTransfer then
                    break;
              end;
          Finally
              Lines.LockbinBatchFields;
              Lines.Dataset.Enablecontrols;
          end;
        Finally
              ProgressDialog.DoHideProgressbar;
        end;
    finally
        getnewDataset('Drop table if Exists ' +ProductsofToClassTableName, False);
        getnewDataset('Drop table if Exists ' +ProductsofFromClassTableName, False);
    end;
    REsult := True;
end;



procedure TStockTransferEntry.DoCancelAutoTransfer(Sender: TObject);
begin
  CancelAutoTransfer := true;
end;

procedure TStockTransferEntry.DeleteFlagedLines;
var
  IsFiltered: boolean;
  TempAccessLevel: integer;
begin
  TempAccessLevel:= AccessManager.AccessLevel;
  try
    AccessManager.AccessLevel:= 1;
    Lines.Dataset.DisableControls;
    IsFiltered := Lines.Dataset.Filtered;
    Lines.Dataset.Filtered := false;
    if Lines.Count > 0 then begin
      Lines.First;
      while not Lines.Dataset.Eof do begin
        if Lines.Deleted then begin
          Lines.Delete;
        end else Lines.Dataset.Next;
      end;
      Lines.Dataset.Filtered := IsFiltered;
    end;
    Lines.Dataset.EnableControls;
  finally
      AccessManager.AccessLevel:= TempAccessLevel;
  end;
end;

function TStockTransferEntry.DoAfterInsert(
  Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then exit;

  DateTransferred := Now;
  CreationDate := Now;
  EmployeeName := AppEnv.Employee.EmployeeName;
  EmployeeID := AppEnv.Employee.EmployeeID;
  EnforceUOM              := False;
  AccountID :=   TAccount.IDToggle(AppEnv.Companyprefs.DefaultStockTransferAccount); //TAccount.IDToggle('Stock Adjustment');
  if accountID =0 then AccountID := TAccount.IDToggle('Stock Adjustment');
  TransferFromClassName := Appenv.DefaultClass.DefaultClassName;
end;


class function TStockTransferEntry.Transtype: STring;begin    Result := 'Stock Transfer';end;




procedure TStockTransferEntry.Deletetransfer;
begin
   StockMovement.DeleteStockMovement ;
end;

function TStockTransferEntry.getStockMovement: TStockMovement;
begin
  result := TStockMovement(getcontainercomponent(TStockMovement , 'StockmovementEntryglobalref = ' +quotedStr(Self.Globalref) +' and StockmovementEntryType =' + QuotedStr(XMLNodeName) ));
  result.Silentmode := true;
end;

{ TSTELines }

constructor TSTELines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'StockTransferLines';
  fSQL := 'SELECT * FROM tblstocktransferentrylines';
  fbCalcQtyFromformula:= False;
  fIsList:= true;
  ExportExcludeList.Add('clientid');
  ExportExcludeList.Add('accountid');
  ExportExcludeList.Add('classidto');
  ExportExcludeList.Add('pqa');
end;


Class function TSTELines.GetIDField: string;
begin
  Result := 'TransferEntryLinesID'
end;


Class function TSTELines.GetKeyStringField: string;
begin
  Result := ''
end;


Class function TSTELines.GetBusObjectTablename: string;
begin
  Result := 'tblstocktransferentrylines'
end;


destructor TSTELines.Destroy;
begin
  inherited;
end;


procedure TSTELines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'clientID');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'AssetValue');
  SetPropertyFromNode(node,'CustomerName');
  SetPropertyFromNode(node,'ClassIDTo');
  SetPropertyFromNode(node,'ClassNameTo');
  SetPropertyFromNode(node,'PQADetailClassRef');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'ProductID');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'ProductDesc');
  SetPropertyFromNode(node,'UnitOfMeasureID');
  SetPropertyFromNode(node,'UnitOfMeasure');
  SetPropertyFromNode(node,'UOMMultiplier');
  SetPropertyFromNode(node,'AvailableQty');
  SetPropertyFromNode(node,'UOMAvailableQty');
  SetPropertyFromNode(node,'TransferQty');
  SetPropertyFromNode(node,'UOMTransferQty');
  SetPropertyFromNode(node,'Deleted');
  SetPropertyFromNode(node,'PartBarcode');
end;


procedure TSTELines.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'clientID' ,clientID);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'AssetValue' ,AssetValue);
  AddXMLNode(node,'CustomerName' ,CustomerName);
  AddXMLNode(node,'ClassIDTo' ,ClassIDTo);
  AddXMLNode(node,'ClassNameTo' ,ClassNameTo);
  AddXMLNode(node,'PQADetailClassRef' ,PQADetailClassRef);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'ProductDesc' ,ProductDesc);
  AddXMLNode(node,'UnitOfMeasureID' ,UnitOfMeasureID);
  AddXMLNode(node,'UnitOfMeasure' ,UnitOfMeasure);
  AddXMLNode(node,'UOMMultiplier' ,UOMMultiplier);
  AddXMLNode(node,'AvailableQty' ,AvailableQty);
  AddXMLNode(node,'UOMAvailableQty' ,UOMAvailableQty);
  AddXMLNode(node,'TransferQty' ,TransferQty);
  AddXMLNode(node,'UOMTransferQty' ,UOMTransferQty);
  AddXMLNode(node,'Deleted' ,Deleted);
  AddXMLNode(node,'PartBarcode' ,PartBarcode);
end;


function TSTELines.ValidateData: Boolean ;
begin
   Result := False;
   Resultstatus.Clear;
   if ProductId = 0 then begin
       AddResult(False , rssWarning, 0 , 'Product should not be blank');
       Exit;
   end;
   if classIDTo = 0 then begin
       AddResult(False , rssWarning, 0 , '''Transfer To'' should not be blank');
       Exit;
   end;
   if EmployeeID < 0 then begin
     AddResult(false, rssWarning, 0, 'Employee not found.');
     exit;
   end;
   if AccountID < 0 then begin
     AddResult(false, rssWarning, 0, 'Account not found.');
     exit;
   end;
   if PQADetailClassRef <> '' then begin
     if TPQADetailsClass.IDGlobalRefToggle(PQADetailClassRef , self.Connection.Connection) < 1 then begin
       AddResult(false, rssWarning, 0, 'PQA Details Class Reference not found.');
       exit;
     end;
   end;
   result := inherited ValidateData;
end;


class function TSTELines._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TCustomer','CustomerObj','ClientID','ID');
  TBOSchema.AddRefType(result,'TCustomer','CustomerObj','CustomerName','ClientName');
  TBOSchema.AddRefType(result,'TAccount','AccountObj','AccountID','ID');
  TBOSchema.AddRefType(result,'TAccount','AccountObj','AccountName','AccountName');
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','EmployeeID','ID');
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','EmployeeName','EmployeeName');
end;

function TSTELines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSTELines.OnDataIdChange(const ChanGetype: TBusObjDataChanGetype);
begin
  inherited;
  if assigned(OpenLookups) then OpenLookups;
  cleanTransferQty              := TransferQty;
  cleanUOMTransferQty           := UOMTransferQty;
  StoreValues;
  if Id<> 0 then begin
    LockbinBatchFields;
  end;
  SendEvent(BusObjEvent_Warning, BusobjEvent_ToDo, self);
end;

  Procedure TSTELines.CheckUOM;  begin
    if ProductID <> 0 then begin
      if UnitOfMeasure = '' then UnitOfMeasure := AppEnv.DefaultClass.DefaultUOM;
      if UnitOfMeasureid = 0 then UnitOfMeasureid := TcDatautils.GetUnitOfMeasureID(UnitOfMeasure, ProductID);
      if Uommultiplier = 0 then Uommultiplier := GetUnitMultiplier(UnitOfMeasureid);
    end;
  end;

procedure TSTELines.DoFieldOnChange(Sender: TField);
  var
    x:String;

begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.FieldName , 'FormulaQtyValue') or
      Sysutils.SameText(Sender.FieldName , 'FormulaQtyValue1') or
      Sysutils.SameText(Sender.FieldName , 'FormulaQtyValue2') or
      Sysutils.SameText(Sender.FieldName , 'FormulaQtyValue3') or
      Sysutils.SameText(Sender.FieldName , 'FormulaQtyValue4') or
      Sysutils.SameText(Sender.FieldName , 'FormulaQtyValue5')  then begin
      if not rawmode then CalcQtyFromformula;
    end else if Sysutils.SameText(Sender.FieldName , 'Deleted') then begin
      if not RawMode then begin
        AddEvent(BusObjEvent_Change, BusObjEventVal_LineDeleted, Self.ID);
      end;
    end else If Sysutils.SameText(Sender.fieldname , 'ProductName') then begin
      ProductID := TProduct.IDToggle(ProductName , self.Connection.Connection);
      if not RawMode then begin
        DoFieldOnChange(Dataset.FindField('ProductID'));
      end;
    end else if (Sysutils.SameText(Sender.fieldName , 'ProductID'))  then begin
        ProductName := TProduct.IDToggle(ProductID , self.Connection.Connection);
      if not RawMode then begin
        ProductDesc      := Product.SalesDescription;
        ProductType          := Product.ProductType;
        if UnitOfMeasureID = 0 then begin
            UnitOfMeasureID := Product.UOMPurchasesID;
            UnitOfMeasure := tcdatautils.GetUOMName(UnitOfMeasureID);
            Uommultiplier := tcdataUtils.GetUnitMultiplier(UnitOfMeasureID);
        end;
        if assigned(OpenLookups) then OpenLookups;
        LockbinBatchFields;
        AccountID:= TAccount.IDToggle(Product.AssetAccount, Self.Connection.Connection);
        AssetValue := Product.AvgCost;
        ExtraValidation;//SNQtyValidation;
        if AssetValue =0 then
          AssetValue := Product.BuyQty1Cost;
        AddEvent(BusObjEvent_Change, BusObjEventVal_ProductID, Self.ID);
      end;
    end else if (Sysutils.SameText(Sender.fieldname , 'UOM')) then begin
        //UnitOfMeasureID :=tcdatautils.GetUnitOfMeasureID(UnitOfMeasure , ProductID);
        (*if productId<>0 then begin
            if Product.ProductUOMLocate(Sender.Value)  then begin
              Self.uomMultiplier := Product.UOMList.Multiplier;
              Self.UnitOfMeasureID := Product.UOMList.ID;
              Self.UnitOfMeasure := Product.UOMList.UOMName;
              SendEvent(BusObjEvent_Change, BusObjEventVal_uomChanged, self);
            end else begin
              if not VarIsNull(Sender.OldValue) then begin
                Sender.Value := Sender.OldValue;
                Exit;
              end
              else Self.UOMMultiplier := 0;
            end;
            PostDB;
          if not RawMode then begin
            Uommultiplier := tcdataUtils.GetUnitMultiplier(UnitOfMeasureID);
          end;
        end;*)
        InitUOM(Sender);
    end else if (Sysutils.SameText(Sender.fieldname , 'Classidto')) then begin
      Classnameto := TDeptClass.IDToggle(ClassidTo, Connection.Connection);
      if not RawMode then begin
        if assigned(OpenLookups) then OpenLookups;
      end;
    end else if Sysutils.SameText(Sender.FieldName , 'Uomtransferqty') then begin
      if not RawMode then begin
        PostDB;
        ExtraValidation;//SNQtyValidation;
        checkUOM;
        TransferQty := Uomtransferqty*Uommultiplier;
        {DENE - need to be able to transfer when stock not Available}
        (*if (UOMAvailableQty < UOMTransferqty) or (AvailableQty    < Transferqty) then begin
          s :=' Its not possible to transfer the requested quantity [' +floatToStr(UOMTransferqty) +']' + chr(13)+
                  'as the available Quantity [' + FloatToStr(UOMAvailableQty) + '] is less.';
          ResultStatus.Additem(True, rssInfo ,0 , s ,true);
          UOMTransferQty := UOMAvailableQty;
          TransferQty := AvailableQty;
          PostDB;
        end;*)
        RecalculateAvailQty;
      end;
    end else if Sysutils.SameText(Sender.FieldName , 'transferqty') then begin
      if not RawMode then begin
        PostDB;
        ExtraValidation;//SNQtyValidation;
        checkUOM;
        uomTransferQty := DivZer(transferqty,Uommultiplier);
        (*if (UOMAvailableQty < UOMTransferqty) or (AvailableQty    < Transferqty) then begin
          s :=' Its not possible to transfer the requested quantity [' +floatToStr(UOMTransferqty) +']' + chr(13) +
                  'as the available Quantity [' + FloatToStr(UOMAvailableQty) + '] is less.';
          ResultStatus.Additem(True, rssInfo ,0 , s ,true);
          UOMTransferQty := UOMAvailableQty;
          TransferQty := AvailableQty;
        end;*)
        RecalculateAvailQty;
      end;
    end else if Sysutils.SameText(Sender.FieldName , 'Uommultiplier') then begin
      if not RawMode then begin
        Uomtransferqty := DivZer(Transferqty,Uommultiplier);
      end;
    end else if Sysutils.SameText(Sender.Fieldname , 'ClassnameTo') then begin
      ClassIDTo := TDeptClass.IDToggle(ClassnameTo , self.connection.connection);
      if not RawMode then begin
        DoFieldOnChange(Dataset.findfield('ClassIDTo'));
      end;
    end else if Sysutils.SameText(Sender.FieldName , 'PartBarcode') then begin
      if not RawMode then begin
        (*Productname := tcdatautils.GetProductForbarCode(PartBarcode);
        if Productname = '' then begin
          PartBarcode := '';
        end else begin
            DoFieldOnChange(Dataset.findfield('ProductName'));
        end;*)
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
    end
    else if Sysutils.SameText(sender.FieldName, 'clientID') then begin
      if ClientID > 0 then
        CustomerName := TCustomer.IDToggle(ClientID, Connection.Connection)
      else
        CustomerName := '';
    end
    else if Sysutils.SameText(sender.FieldName, 'CustomerName') then begin
      if CustomerName <> '' then
        ClientID := TCustomer.IDToggle(CustomerName, Connection.Connection)
      else
        ClientID := 0;
    end;
end;
procedure TSTELines.ExtraValidation;
begin

end;

procedure TSTELines.InitUOM(const UOMName, UOMNameOldValue: String);
begin
  inherited;
  if productId<>0 then begin
    SendEvent(BusObjEvent_Change, BusObjEventVal_uomChanged, self);
  end;
end;
function TSTELines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TSTELines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
end;


{Property functions}
function  TSTELines.GetCustomerName           : string    ; begin Result := GetStringField('CustomerName');end;
function  TSTELines.GetClassNameTo            : string    ; begin Result := GetStringField('ClassNameTo');end;
function  TSTELines.GetPQADetailClassRef      : string    ; begin Result := GetStringField('PQADetailClassRef');end;
function  TSTELines.GetProductName            : string    ; begin Result := GetStringField('ProductName');end;
function  TSTELines.GetProductDesc            : string    ; begin Result := GetStringField('ProductDesc');end;
function  TSTELines.GetUnitOfMeasure          : string    ; begin Result := GetStringField('UOM');end;
function  TSTELines.GetSerialnos              : string    ; begin Result := GetStringField('SerialNumber');end;
function  TSTELines.GetclientID               : Integer   ; begin Result := GetIntegerField('clientID');end;
function TSTELines.Getcost: Double;begin  Result := AssetValue;end;

function TSTELines.getCrossStockAdjustTransForinvoice: Boolean;
begin
  REsult := false;
  if assigned(Owner) and (Owner is TStockTransferEntry) then
    REsult := TStockTransferEntry(Owner).CrossStockAdjustTransForinvoice;
end;

function  TSTELines.GetAccountID              : Integer   ; begin Result := GetIntegerField('AccountID');end;
function TSTELines.GetAccountName: string;
begin
  if AccountID > 0 then
    result := TAccount.IDToggle(AccountID, Connection.Connection)
  else
    result := '';
end;
function TSTELines.GetEmployeeName: string;
begin
  if EmployeeID > 0 then
    result := TEmployee.IDToggle(EmployeeID, Connection.Connection)
  else
    result := '';
end;
procedure TSTELines.SetEmployeeName(const Value: string);
begin
  if Value <> '' then begin
    EmployeeID := TEmployee.IDToggle(Value, Connection.Connection);
    if EmployeeID = 0 then
      EmployeeID := -1;
  end
  else
    EmployeeID := 0;
end;

procedure TSTELines.SetAccountName(const Value: string);
begin
  if Value <> '' then begin
    AccountID := TAccount.IDToggle(Value, Connection.Connection);
    if AccountID = 0 then
      AccountID := -1;
  end
  else
    AccountId := 0;
end;

function  TSTELines.GetTransferEntryID        : Integer   ; begin Result := GetIntegerField('TransferEntryID');end;
function  TSTELines.GetClassIDTo              : Integer   ; begin Result := GetIntegerField('ClassIDTo');end;
function  TSTELines.GetEmployeeID             : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TSTELines.GetProductID              : Integer   ; begin Result := GetIntegerField('ProductID');end;
function  TSTELines.GetUnitOfMeasureID        : Integer   ; begin Result := GetIntegerField('UOMID');end;
function  TSTELines.GetUOMMultiplier          : Double    ; begin Result := GetFloatField('UOMMultiplier');end;
function  TSTELines.GetAssetValue             : Double    ; begin Result := GetFloatField('AssetValue');end;
function  TSTELines.GetValue                  : Double    ; begin Result := AssetValue *TransferQty;end;
function  TSTELines.GetAvailableQty           : Double    ; begin Result := GetFloatField('AvailableQty');end;
function  TSTELines.GetUOMAvailableQty        : Double    ; begin Result := GetFloatField('UOMAvailableQty');end;
function  TSTELines.GetTransferQty            : Double    ; begin Result := GetFloatField('TransferQty');end;
function  TSTELines.GetUOMTransferQty         : Double    ; begin Result := GetFloatField('UOMTransferQty');end;
function  TSTELines.GetDeleted                : Boolean   ; begin Result := GetBooleanField('Deleted');end;
procedure TSTELines.SetclientID               (const Value: Integer   ); begin SetIntegerField('clientID'              , Value);end;
procedure TSTELines.SetAccountID              (const Value: Integer   ); begin SetIntegerField('AccountID'             , Value);end;
procedure TSTELines.SetAssetValue             (const Value: Double    ); begin SetFloatField('AssetValue'            , Value);end;
procedure TSTELines.SetValue                  (const Value: Double    ); begin AssetValue := divzer(Value,TransferQty );end;
procedure TSTELines.Setcost                   (const Value: Double    ); begin AssetValue := Value                           ;end;
procedure TSTELines.SetCustomerName           (const Value: string    ); begin SetStringField('CustomerName'          , Value);end;
procedure TSTELines.SetTransferEntryID        (const Value: Integer   ); begin SetIntegerField('TransferEntryID'       , Value);end;
procedure TSTELines.SetClassIDTo              (const Value: Integer   ); begin SetIntegerField('ClassIDTo'             , Value);end;
procedure TSTELines.SetClassNameTo            (const Value: string    ); begin SetStringField('ClassNameTo'           , Value);end;
procedure TSTELines.SetPQADetailClassRef      (const Value: string    ); begin SetStringField('PQADetailClassRef'     , Value);end;
procedure TSTELines.SetEmployeeID             (const Value: Integer   ); begin SetIntegerField('EmployeeID'            , Value);end;
procedure TSTELines.SetProductID              (const Value: Integer   ); begin SetIntegerField('ProductID'             , Value);end;
procedure TSTELines.SetProductName            (const Value: string    ); begin SetStringField('ProductName'           , Value);end;
procedure TSTELines.SetProductDesc            (const Value: string    ); begin SetStringField('ProductDesc'           , Value);end;
procedure TSTELines.SetUnitOfMeasureID        (const Value: Integer   ); begin SetIntegerField('UOMID'                 , Value);end;
procedure TSTELines.SetUnitOfMeasure          (const Value: string    ); begin SetStringField('UOM'                   , Value);end;
procedure TSTELines.SetUOMMultiplier          (const Value: Double    ); begin SetFloatField('UOMMultiplier'         , Value);end;
procedure TSTELines.SetAvailableQty           (const Value: Double    ); begin SetFloatField('AvailableQty'          , Value);end;
procedure TSTELines.SetUOMAvailableQty        (const Value: Double    ); begin SetFloatField('UOMAvailableQty'       , Value);end;
procedure TSTELines.SetTransferQty            (const Value: Double    ); begin SetFloatField('TransferQty'           , Value);end;
procedure TSTELines.SetUOMTransferQty         (const Value: Double    ); begin SetFloatField('UOMTransferQty'        , Value);end;
procedure TSTELines.SetDeleted                (const Value: Boolean   ); begin SetBooleanField('Deleted'               , Value);end;
procedure TSTELines.SetMatrixDesc(const Value: String);begin  SetStringField('MatrixDesc' , Value);end;
procedure TSTELines.SetMatrixPrice(const Value: Double);begin  SetFloatfield('MatrixPrice' , Value);end;
procedure TSTELines.SetMatrixRef(const Value: String);begin  SetStringField('MatrixRef' , Value);end;
function TSTELines.getMatrixDesc: String;begin  Result := GetStringfield('MatrixDesc');end;
function TSTELines.getMatrixPrice: Double;begin  REsult := getFloatfield('MatrixPrice');end;
function TSTELines.getMatrixRef: String;begin  Result := GetStringfield('MatrixRef');end;



procedure TSTELines.CalcQtys;
begin
  if UOMMultiplier = 0 then UOMMultiplier := 1;
  if TransferQty <> 0 then UOMTransferQty := DivZer(TransferQty, UOMMultiplier);
end;


procedure TSTELines.LockbinBatchFields(const Value :boolean);
begin
    if Dataset.FindField('BinLocationFrom') <> nil then Dataset.fieldByname('BinLocationFrom').Readonly := Value;
    if Dataset.FindField('BinNumberFrom')   <> nil then Dataset.fieldByname('BinNumberFrom').Readonly   := Value;
    if Dataset.FindField('BinLocationTo')   <> nil then Dataset.fieldByname('BinLocationTo').Readonly   := Value;
    if Dataset.FindField('BinNumberTo')     <> nil then Dataset.fieldByname('BinNumberTo').Readonly     := Value;
    if Dataset.FindField('BatchNoFrom')     <> nil then Dataset.fieldByname('BatchNoFrom').Readonly     := Value;
    if Dataset.FindField('BatchNoTo')       <> nil then Dataset.fieldByname('BatchNoTo').Readonly       := Value;
    if Dataset.FindField('ExpiryDateFrom')  <> nil then Dataset.fieldByname('ExpiryDateFrom').Readonly  := Value;
    if Dataset.FindField('ExpiryDateto')    <> nil then Dataset.fieldByname('ExpiryDateto').Readonly    := Value;
    if assigned(fDisableBincombos)    then fDisableBincombos(Value);
    if assigned(fDisableBatchcombos)  then fDisableBatchcombos(Value);
end;

procedure TSTELines.LockbinBatchFields;
begin
    if Dataset.FindField('BinLocationFrom') <> nil then Dataset.fieldByname('BinLocationFrom').Readonly := not(BinProduct);
    if Dataset.FindField('BinNumberFrom')   <> nil then Dataset.fieldByname('BinNumberFrom').Readonly   := not(BinProduct);
    if Dataset.FindField('BinLocationTo')   <> nil then Dataset.fieldByname('BinLocationTo').Readonly   := not(BinProduct);
    if Dataset.FindField('BinNumberTo')     <> nil then Dataset.fieldByname('BinNumberTo').Readonly     := not(BinProduct);
    if Dataset.FindField('BatchNoFrom')     <> nil then Dataset.fieldByname('BatchNoFrom').Readonly     := not(BatchProduct);
    if Dataset.FindField('BatchNoTo')       <> nil then Dataset.fieldByname('BatchNoTo').Readonly       := not(BatchProduct);
    if Dataset.FindField('ExpiryDateFrom')  <> nil then Dataset.fieldByname('ExpiryDateFrom').Readonly  := not(BatchProduct);
    if Dataset.FindField('ExpiryDateto')    <> nil then Dataset.fieldByname('ExpiryDateto').Readonly    := not(BatchProduct);
    if assigned(fDisableBincombos)    then fDisableBincombos(BinProduct);
    if assigned(fDisableBatchcombos)  then fDisableBatchcombos(BatchProduct);
end;

function TSTELines.DoAfterInsert( Sender: TDatasetBusobj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  if Assigned(Self.Owner) then
    if self.Owner is TStockTransferentry then begin
      TStockTransferentry(Self.Owner).PostDB;
      TransferEntryID := TStockTransferentry(Self.Owner).Id;
    end;
  if not RawMode then begin
    if ProductID <> 0 then begin
      UnitOfMeasure           := AppEnv.DefaultClass.DefaultUOM;
      UnitOfMeasureid         := TcDatautils.GetUnitOfMeasureID(UnitOfMeasure, ProductID);
      Uommultiplier := GetUnitMultiplier(UnitOfMeasureid);
      cleanTransferQty              := TransferQty;
      cleanUOMTransferQty           := UOMTransferQty;
    end;
  end;
end;

function TSTELines.GetDatetransferred: TDatetime;
begin
  Result := 0;
  if Assigned(Self.Owner) then
    if Self.Owner is TStockTransferEntry then
      Result := TStockTransferEntry(Self.Owner).Datetransferred;
end;

procedure TSTELines.StoreValues;
begin
  cleanProductDetails  := ProductDetails;
end;

function TSTELines.BinProduct: boolean;
begin
    Result := False;
    if ProductId = 0 then Exit;
    Result := Product.MUltiplebins;
end;

function TSTELines.BatchProduct: boolean;
begin
    Result := False;
    if ProductId = 0 then Exit;
    Result := Product.Batch;
end;
function TSTELines.GetClassIDFrom: Integer;
begin
  result := 0;
  if Assigned(Self.Owner) then
    if self.Owner is TStockTransferentry then
      result := TStockTransferentry(Self.Owner).TransferFromClassID;
end;

{PQA related overriden functions - but as its not a PQA item, these functions are redundant }
function TSTELines.GetClassID: Integer;begin  Result := ClassIDFrom;end;
function TSTELines.Getalloctype: String;begin  Result := 'OUT';end;
function TSTELines.GetActive: Boolean;begin  REsult := not (Deleted);end;
function TSTELines.GetTransDate: TDatetime;begin  REsult := Datetransferred;end;
procedure TSTELines.SetTransDate(const Value: TDatetime);begin {date is in the header - nothing to be done} end;

function TSTELines.GetBOQty: Double;
begin
  result := 0;
end;
function TSTELines.GetBOUOMQty: Double;
begin
  result := 0;
end;

function TSTELines.GetQty: Double;
begin
  REsult := TransferQty;
end;

function TSTELines.GetUOMQty: Double;
begin
  REsult := UOMTransferQty;
end;

(*function TSTELines.GetISBO: Boolean;
begin
  REsult := False;
end;*)

function TSTELines.GetCleanClassID: Integer;
begin
  result := GetXMLNodeIntegerValue(TStockTransferEntry(Self.Owner).CleanXMLNOde, 'TransferFromClassID');
end;

function TSTELines.GetcleanProductId: Integer;
begin
  result := GetXMLNodeIntegerValue(CleanXMLNOde, 'ProductID')
end;


function TSTELines.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeDelete(Sender);
  if not Result then Exit;

  {transfer from PQA is alredy handled in the inherited as its a TProdQty object }
  if not IsPQAItem then Exit;
  if Assigned(Owner) then
    if Owner is TStocktransferEntry then
      if Assigned(TStocktransferEntry(Owner).TreeLinesIn) and (TStocktransferEntry(Owner).TreeLinesIn.count>0) then
        if (TStocktransferEntry(Owner).TreeLinesIn.Id = self.ID) or (TStocktransferEntry(Owner).TreeLinesIn.Locate(TStocktransferEntry(Owner).TreeLinesIn.IDfieldname , Id, [])) then
          if TStocktransferEntry(Owner).TreeLinesIn.PQA.count>0 then
                TStocktransferEntry(Owner).TreeLinesIn.PQA.Delete;

end;

function TSTELines.DoBeforeInsert(
  Sender: TDatasetBusobj): Boolean;
begin
  result := inherited DoBeforeInsert(Sender);
  if not result then exit;
  LockbinBatchFields(False);
end;

function TSTELines.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(Sender);
  if not result then exit;
  (*if (not DatasetPosting) and (ProductID =0) and (Deleted = False) then begin
    deleted := TRue;
  end;*)
  if  (Count > 1) and (ProductID = 0) and ((ProductNAme = '') or (TProduct.IDToggle(Productname,Connection.Connection) = 0)) then begin
        Deleted := True;
        Result := True;
        Exit;
  end ;
end;

procedure TSTELines.RecalculateAvailQty;
var
  fs:String;
  oldFs:String;
begin
  fiid        := ID;
  fiProductID := ProductID;
  fUOM        := UnitOfMeasure;
  diffQty     := TRansferQty-  cleanTransferQty;
  diffUOMQty  := UOMTransferQty-  cleanUOMTransferQty;
  if (diffQty = 0) and   (diffUOMQty = 0) then exit;

    fs := IDfieldname +'>' + intToStr(ID) +
        ' and ProductId = ' + intToStr(ProductID);
    if EnforceUOM then
      fs := fs + ' and UnitOfMeasure = ' +quotedstr(UnitOfMeasure);
    dataset.disablecontrols;
    try
      oldfs:= dataset.filter;
      if oldfs<> '' then fs:= '(' +oldfs +') and ' +fs;
      dataset.filter:= fs;
      dataset.filtered:= true;
      try
        IterateREcords(CallBackRecalculateAvailQty);
      finally
        dataset.filter := oldFs;
        dataset.filtered:= oldfs<>'';
        dataset.Locate(IDFieldName , fiid, []);
      end;
    finally
      dataset.enablecontrols;
    end;

end;

function TSTELines.ProductDetails: String;
var
  xnode :IXMLNode;
begin
  result := '';
  if productId = 0 then exit;

  With TXMLDocument.Create(nil) do try
      active := true;
      xnode:= AddChild('Record');
      AddXMLNode(xnode,IDFieldName, ID);
      AddXMLNode(xnode,'Datetransferred', Datetransferred);
      AddXMLNode(xnode,'UnitOfMeasure',UnitOfMeasure);
      AddXMLNode(xnode,'ProductID' ,ProductID);
      AddXMLNode(xnode,'CLassId' ,CLassId);
      REsult := XML.Text;
  finally
//    free;
  end;
end;
procedure TSTELines.PostnEditDB;
begin
  inherited;
end;

function TSTELines.PQAcount: Integer;
begin
  Result:= 0;
  TRy
    if Assigned(PQA) then
      Result:= PQA.count
    else
      result := inherited PQAcount;
  Except
    On E:Exception do begin
       if devmode then
        ResultStatus.AddItem(False, rssWarning, 0 , E.Message);
    end;
  End;
end;

function TSTELines.ProductChanged: Boolean;
begin
  REsult := not(Sysutils.SameText(ProductDetails , cleanProductDetails));
end;
procedure TSTELines.AfterCloneBusObj;
begin
  inherited;
end;

procedure TSTELines.CallBackRecalculateAvailQty(const Sender: TBusObj; var Abort: boolean);
begin
  if not (Sender is TSTELines) then exit;
  if (fiid        <TSTELines(Sender).ID ) and
      (TSTELines(Sender).ProductId = fiProductID) and
      ((TSTELines(Sender).UnitOfMeasure = fUOM) or (EnforceUOM = False) ) then begin
      TSTELines(Sender).AvailableQty   := TSTELines(Sender).AvailableQty    - diffQty;
      if EnforceUOM then TSTELines(Sender).UOMAvailableQty:= TSTELines(Sender).UOMAvailableQty - diffUOMQty
      else TSTELines(Sender).UOMAvailableQty:= TSTELines(Sender).AvailableQty   / TSTELines(Sender).UOMMultiplier;
      TSTELines(Sender).PostDB;
  end;
end;

function TSTELines.GetIsPQAItem: boolean;
begin
    Result := (Self.ProductID > 0) and (IsInvProduct(ProductType)) and (Self is TSTELinesTRee);
end;

procedure TSTELines.SetActive(const Value: Boolean);
begin
  Deleted := not(Value);
end;

procedure TSTELines.SetBOQty(const Value: Double);
begin
//
end;
procedure TSTELines.SetBOUOMQty(const Value: Double);
begin
//
end;

procedure TSTELines.SetQty(const Value: Double);
begin
    TransferQty:= value;
end;

procedure TSTELines.SetSerialNos(const Value: string);
begin
  inherited;

end;

procedure TSTELines.SetUOMQty(const Value: Double);
begin
  UOMTransferQty := value;
end;

function TSTELines.GetOrderQty: Double;
begin
  Result := TransferQty;
end;

procedure TSTELines.SetOrderQty(const Value: Double);
begin
  inherited;
  TransferQty := Value;
end;

function TSTELines.GetUOMOrderQty: Double;
begin
  REsult := UOMTransferQty;
end;

procedure TSTELines.SetUOMOrderQty(const Value: Double);
begin
  UOMTransferQty := Value

end;

function TSTELines.getEnforceUOM: Boolean;
begin
 result := False;
  if Assigned(Self.Owner) then
    if self.Owner is TStockTransferentry then
      result := TStockTransferentry(Self.Owner).EnforceUOM;
end;


function TSTELines.getPartBarcode: String;
begin
  REsult := getStringfield('PartBarcode');
end;

procedure TSTELines.setPartBarcode(const Value: String);
begin
  SetStringfield('PartBarcode' , Value);
end;

function TSTELines.GetProductType: string;
begin
    Result := GetStringField('PartType');
end;

procedure TSTELines.SetProductType(const Value: string);
begin
  inherited;
  SetStringField('PartType', Value);
end;

procedure TSTELines.getCalcQtYformulaValue(Sender: TObject;const VarName: string; var Value: extended; var FieldFound: Boolean);
begin
              if SameText(varname, 'Field1') then begin Value := FormulaQtyValue1 ;FieldFound:= True;
     end else if SameText(varname, 'Field2') then begin Value := FormulaQtyValue2 ;FieldFound:= True;
     end else if SameText(varname, 'Field3') then begin Value := FormulaQtyValue3 ;FieldFound:= True;
     end else if SameText(varname, 'Field4') then begin Value := FormulaQtyValue4 ;FieldFound:= True;
     end else if SameText(varname, 'Field5') then begin Value := FormulaQtyValue5 ;FieldFound:= True; end;

end;
procedure TSTELines.CalcQtyFromformula;
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
    UOMTransferQty := Qty;
    DoFieldOnChange(dataset.Findfield('UOMTransferQty'));
  finally
    fbCalcQtyFromformula:= False;
  end;
end;


{ TSTEPQADetails }

constructor TSTEPQADetails.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tblstocktransferentrypqaDetails'  ;

end;


function TSTEPQADetails.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
    REsult := inherited DoAfterInsert(Sender);
    if not result then exit;

    if Self.Owner is TSTEPQA then
        Self.PQAID :=TSTEPQA(Self.Owner).Id;
end;

class function TSTEPQADetails.GetBusObjectTablename: string;
begin
  REsult:= 'tblstocktransferentrypqaDetails';
end;


{ TSTEPQA }


constructor TSTEPQA.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tblstocktransferentrypqa '  ;
end;


function TSTEPQA.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
    REsult := inherited DoAfterInsert(Sender);
    if not result then exit;

    if Self.Owner is TSTELinesTree then
        Self.TransLineId := TSTELinesTree(Self.Owner).Id;

end;

class function TSTEPQA.GetBusObjectTablename: string;
begin
  REsult:= 'tblstocktransferentrypqa';
end;

function TSTEPQA.GetPQABatch: TPQABatch;
begin
    Result := TPQABatch(getContainerComponent(TSTEPQABatch, 'PQAType = ' +QuotedStr(TPQABatch.PQADetailtype)+  ' and PQAID = '+ IntToStr(Self.Id)+ ' and ifnull(ParentRef,"") = ""'));
end;

function TSTEPQA.GeTPQABins: TPQABins;
begin
  Result := TPQABins(getContainerComponent(TSTEPQABins, 'PQAType = ' +QuotedStr(TPQABins.PQADetailtype)+  ' and PQAID = '+ IntToStr(Self.Id)+ ' and ifnull(ParentRef,"") = ""'));
end;

function TSTEPQA.getPQAdetails: TPQADetails;
begin
   Result := TPQADetails(getContainerComponent(TSTEPQADetails, 'PQAID = '+ IntToStr(Self.Id)));
end;

function TSTEPQA.GeTPQASN: TPQASN;
begin
  Result := TPQASN(getContainerComponent(TSTEPQASN, 'PQAType = ' +QuotedStr(TPQASN.PQADetailtype)+  ' and PQAID = '+ IntToStr(Self.Id)+ ' and ifnull(ParentRef,"") = ""'));
end;



function TSTEPQA.NewPQADetailObj(const ObjInstanceToCloneID:Integer): TPQADetails;
begin
  Result := TSTEPQADetails.Create(Self);
  Result.Connection := Self.Connection;
  Result.LoadSelect(' PQAID = ' + inttostr(ObjInstanceToCloneID));
  Result.DEleteall;
end;

function TSTEPQA.PQAdetailtablename: string;
begin
  result:= 'tblstocktransferentrypqadetails';
end;

function TSTEPQA.PQAtablename: string;
begin
  REsult:= 'tblstocktransferentrypqa';
end;

{ TSTEPQABatch }

constructor TSTEPQABatch.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'PQADetails';
  fSQL := 'SELECT * FROM tblstocktransferentrypqaDetails';
  if PQADetailtype <> '' then fSQL := fSQL + ' where PQAType = ' + Quotedstr(PQADetailtype);
end;

class function TSTEPQABatch.GetBusObjectTablename: string;
begin
  Result := 'tblstocktransferentrypqaDetails';
end;

function TSTEPQABatch.GeTPQABins: TPQABins;
begin
      Result := TPQABins(getContainerComponent(TSTEPQABins, 'PQAType = ' +QuotedStr(TPQABins.PQADetailtype)+  ' and PQAID = '+ IntToStr(Self.PQAId) + ' and ParentRef = ' + QuotedStr(Self.Globalref)));
end;

function TSTEPQABatch.GeTPQASN: TPQASN;
begin
      Result := TPQASN(getContainerComponent(TSTEPQASN, 'PQAType = ' +QuotedStr(TPQASN.PQADetailtype)+  ' and PQAID = '+ IntToStr(Self.PQAId) + ' and ParentRef = ' + QuotedStr(Self.Globalref)));
end;


{ TSTEPQABins }

constructor TSTEPQABins.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'PQADetails';
  fSQL := 'SELECT * FROM tblstocktransferentrypqaDetails';
  if PQADetailtype <> '' then fSQL := fSQL + ' where PQAType = ' + Quotedstr(PQADetailtype);
end;

class function TSTEPQABins.GetBusObjectTablename: string;
begin
  Result := 'tblstocktransferentrypqaDetails';
end;

function TSTEPQABins.GeTPQASN: TPQASN;
begin
    Result := TPQASN(getContainerComponent(TSTEPQASN, 'PQAType = ' +QuotedStr(TPQASN.PQADetailtype)+  ' and PQAID = '+ IntToStr(Self.PQAId) + ' and ParentRef = ' + QuotedStr(Self.Globalref)));

end;

{ TSTEPQASN }

constructor TSTEPQASN.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'PQADetails';
  fSQL := 'SELECT * FROM tblstocktransferentrypqaDetails';
  if PQADetailtype <> '' then fSQL := fSQL + ' where PQAType = ' + Quotedstr(PQADetailtype);
end;

class function TSTEPQASN.GetBusObjectTablename: string;
begin
  Result := 'tblstocktransferentrypqaDetails';
end;

function TSTEPQASN.ValidateSN: Boolean;
begin
  // ignore the validationas the process will validate it
  REsult := True;
end;

(*{ TSTEPQAFrom }

constructor TSTEPQAFrom.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tblstocktransferentrypqa Where Alloctype ="OUT"'  ;

end;

{ TSTEPQATo }

constructor TSTEPQATo.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tblstocktransferentrypqa Where Alloctype ="IN"'  ;
end;*)

{TSTELinesFlat}
function  TSTELinesFlat.GetBatchNoFrom            : string    ; begin Result := GetStringField('BatchNoFrom');end;
function  TSTELinesFlat.GetBinLocationFrom        : string    ; begin Result := GetStringField('BinLocationFrom');end;
function  TSTELinesFlat.GetBinNumberFrom          : string    ; begin Result := GetStringField('BinNumberFrom');end;
function  TSTELinesFlat.GetBatchNoTo              : string    ; begin Result := GetStringField('BatchNoTo');end;
function  TSTELinesFlat.GetBinLocationTo          : string    ; begin Result := GetStringField('BinLocationTo');end;
function  TSTELinesFlat.GetBinNumberTo            : string    ; begin Result := GetStringField('BinNumberTo');end;
function  TSTELinesFlat.GetSerialNumber           : string    ; begin Result := GetStringField('SerialNumber');end;
function  TSTELinesFlat.GetTransferSerialnos      : string    ; begin Result := GetStringField('Serialnos');end;
procedure TSTELinesFlat.AfterCloneBusObj;
begin
  inherited;
  inherited;
  if Assigned(ObjInstancetoclone) then
    if ObjInstancetoclone is TSTELinesFlat then begin
        TSTELinesFlat(ObjInstancetoclone).ProductQty(false);
        TSTELinesFlat(ObjInstancetoclone).CalcQtys;
    end;
end;

procedure TSTELinesFlat.CalcQtys;
begin
  inherited;
  if TransferAllocatedQty <> 0 then TransferUOMAllocatedQty := TransferAllocatedQty/UOMMultiplier;
end;

function TSTELinesFlat.DoAfterInsert(Sender: TDatasetBusobj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  if not RawMode then begin
    cleanTransferAllocatedQty     := TransferAllocatedQty;
    cleanTransferUOMAllocatedQty  := TransferUOMAllocatedQty;
  end;
end;
Procedure TSTELinesFlat.ExtraValidation;//SNQtyValidation;
begin
  if ProductID<>0 then
    if (Product.SnTracking) and (serialnumbers<> '') then begin
      Uomtransferqty:= 1;
      TransferQty := Uomtransferqty*Uommultiplier;
      TransferUOMAllocatedQty:= 1;
      TransferAllocatedQty := TransferUOMAllocatedQty *Uommultiplier;
      SendEvent(BusobjEvent_ToDo, BusObjEventVal_Changed, self);
    end;
end;

procedure TSTELinesFlat.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
    inherited;
    if (Sysutils.SameText(sender.FieldName , 'BinNumberFrom')) then begin
      if not RawMode then begin
        if BinNumberTo   = '' then BinNumberTo := BinNumberfrom;
      end;
    end else if (Sysutils.SameText(sender.FieldName , 'BatchNoFrom')) then begin
      if not RawMode then begin
        if BatchNoto     = '' then BatchNoto := BatchNoFrom;
      end;
    end else if (Sysutils.SameText(sender.FieldName , 'ExpiryDatefrom')) then begin
      if not RawMode then begin
        NullWhenDateIs0 := true;
        ExpiryDateto := ExpiryDateFrom;
      end;
    end else if (Sysutils.SameText(sender.FieldName , 'BinLocationTo')) then begin
      if not RawMode then begin
        if assigned(OpenLookups) then OpenLookups;
      end;
    end else if (Sysutils.SameText(sender.FieldName , 'BinLocationFrom')) then begin
      if not RawMode then begin
        if assigned(OpenLookups) then OpenLookups;
        //if BinLocationTo = '' then BinLocationTo := BinLocationFrom;
      end;
    end else if Sysutils.SameText(Sender.FieldName , 'TransferAllocatedQty') then begin
      if not RawMode then begin
        PostDB;
        ExtraValidation;//SNQtyValidation;
        checkUOM;
        TransferUOMAllocatedQty := TransferAllocatedQty/Uommultiplier;
        if UOMAllocatedqty < TransferUOMAllocatedQty then TransferUOMAllocatedQty := UOMAllocatedqty;
        if Allocatedqty    < TransferAllocatedQty    then TransferAllocatedQty := Allocatedqty;
      end;
    end else if Sysutils.SameText(Sender.FieldName , 'TransferUOMAllocatedQty') then begin
      if not RawMode then begin
        PostDB;
        ExtraValidation;//SNQtyValidation;
        checkUOM;
        TransferAllocatedQty := TransferUOMAllocatedQty *Uommultiplier;
        if UOMAllocatedqty < TransferUOMAllocatedQty then TransferUOMAllocatedQty := UOMAllocatedqty;
        if Allocatedqty    < TransferAllocatedQty    then TransferAllocatedQty := Allocatedqty;
      end;
    end else if Sysutils.SameText(Sender.FieldName , 'SerialNumber') then begin
      if not RawMode then begin
        uomTransferQty := Qty;
        DoFieldOnChange(Dataset.findfield('uomTransferQty'));
      end;
    end;
    if (Sysutils.SameText(sender.FieldName , 'ExpiryDatefrom')) or
       (Sysutils.SameText(sender.FieldName , 'BatchNoFrom')) or
       (Sysutils.SameText(sender.FieldName , 'BinNumberFrom')) or
       (Sysutils.SameText(sender.FieldName , 'BinLocationFrom')) or
       (Sysutils.SameText(Sender.fieldName , 'ProductID')) or
       (Sysutils.SameText(Sender.fieldname , 'UOM')) or
       (Sysutils.SameText(Sender.fieldname , 'Serialnumber')) or
       (Sysutils.SameText(sender.FieldName , 'ExpiryDatefrom')) then begin
      if not RawMode then begin
        ProductQty;
        CalcQtys;
        if Sysutils.SameText(Sender.fieldname , 'Serialnumber') then begin
          TransferUOMAllocatedQty := 1;
          DoFieldOnChange(Dataset.FindField('TransferUOMAllocatedQty'));
        end;
      end;
    end;

end;

function  TSTELinesFlat.GetAllocatedQty           : Double    ; begin Result := GetFloatField('AllocatedQty');end;
function  TSTELinesFlat.GetUOMAllocatedQty        : Double    ; begin Result := GetFloatField('UOMAllocatedQty');end;
function  TSTELinesFlat.GetTransferAllocatedQty   : Double    ; begin Result := GetFloatField('TransferAllocatedQty');end;
function  TSTELinesFlat.GetUOMTransferAllocatedQty: Double    ; begin Result := GetFloatField('TransferUOMAllocatedQty');end;
procedure TSTELinesFlat.LoadFromXMLNode(const node: IXMLNode) ;
begin
  inherited;
  SetPropertyFromNode(node,'BatchNoFrom');
  SetPropertyFromNode(node,'expiryDateFrom');
  SetPropertyFromNode(node,'BinLocationFrom');
  SetPropertyFromNode(node,'BinNumberFrom');
  SetPropertyFromNode(node,'BatchNoTo');
  SetPropertyFromNode(node,'expiryDateTo');
  SetPropertyFromNode(node,'BinLocationTo');
  SetPropertyFromNode(node,'BinNumberTo');
  SetPropertyFromNode(node,'SerialNumbers');
  SetPropertyFromNode(node,'AllocatedQty');
  SetPropertyFromNode(node,'UOMAllocatedQty');
  SetPropertyFromNode(node,'TransferAllocatedQty');
  SetPropertyFromNode(node,'TransferUOMAllocatedQty');
end;

procedure TSTELinesFlat.OnDataIdChange(const ChanGetype: TBusObjDataChanGetype);
begin
  cleanTransferAllocatedQty     := TransferAllocatedQty;
  cleanTransferUOMAllocatedQty  := TransferUOMAllocatedQty;
  inherited;
end;

function  TSTELinesFlat.GetexpiryDateFrom         : TDateTime ; begin Result := GetDateTimeField('expiryDateFrom');end;
function  TSTELinesFlat.GetexpiryDateTo           : TDateTime ; begin Result := GetDateTimeField('expiryDateTo');end;
procedure TSTELinesFlat.SetBatchNoFrom            (const Value: string    ); begin SetStringField('BatchNoFrom'           , Value);end;
procedure TSTELinesFlat.SetexpiryDateFrom         (const Value: TDateTime ); begin SetDateTimeField('expiryDateFrom'        , Value);end;
procedure TSTELinesFlat.SetBatchNoTo              (const Value: string    ); begin SetStringField('BatchNoTo'             , Value);end;
procedure TSTELinesFlat.SetexpiryDateTo           (const Value: TDateTime ); begin SetDateTimeField('expiryDateTo'          , Value);end;
procedure TSTELinesFlat.SetSerialNos              (const Value: string    ); begin SetStringField('SerialNumber'          , Value);end;
procedure TSTELinesFlat.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'BatchNoFrom' ,BatchNoFrom);
  AddXMLNode(node,'expiryDateFrom' ,expiryDateFrom);
  AddXMLNode(node,'BinLocationFrom' ,BinLocationFrom);
  AddXMLNode(node,'BinNumberFrom' ,BinNumberFrom);
  AddXMLNode(node,'BatchNoTo' ,BatchNoTo);
  AddXMLNode(node,'expiryDateTo' ,expiryDateTo);
  AddXMLNode(node,'BinLocationTo' ,BinLocationTo);
  AddXMLNode(node,'BinNumberTo' ,BinNumberTo);
  AddXMLNode(node,'SerialNumbers' ,SerialNumbers);
  AddXMLNode(node,'AllocatedQty' ,AllocatedQty);
  AddXMLNode(node,'UOMAllocatedQty' ,UOMAllocatedQty);
  AddXMLNode(node,'TransferAllocatedQty' ,TransferAllocatedQty);
  AddXMLNode(node,'TransferUOMAllocatedQty' ,TransferUOMAllocatedQty);
end;

procedure TSTELinesFlat.SetAllocatedQty           (const Value: Double    ); begin SetFloatField('AllocatedQty'          , Value);end;
procedure TSTELinesFlat.SetUOMAllocatedQty        (const Value: Double    ); begin SetFloatField('UOMAllocatedQty'       , Value);end;
procedure TSTELinesFlat.SetTransferAllocatedQty   (const Value: Double    ); begin SetFloatField('TransferAllocatedQty'          , Value);end;
procedure TSTELinesFlat.SetUOMTransferAllocatedQty(const Value: Double    ); begin SetFloatField('TransferUOMAllocatedQty'       , Value);end;
procedure TSTELinesFlat.StoreValues;
begin
  inherited;
  CleanAllocationDetails := AllocationDetails;
end;

function TSTELinesFlat.ValidateData: Boolean;
begin
  result:= inherited ValidateData;
  if not result then exit;
   if BinProduct then begin
       if ((Binlocationfrom='') and  ( Binnumberfrom<>'') ) or
       ((Binlocationto='' ) and   (Binnumberto<>'')) then begin
          AddResult(False , rssWarning, 0 , 'This is a bin enabled product, Bin number should not be provided without Bin Location');
          REsult:= False;
          Exit;
       end;
   end;

   if (TransferQty = 0) and (TransferAllocatedQty=0) then begin
       AddResult(False , rssWarning, 0 , 'You cannot transfer a 0 quantity');
       REsult:= False;
       Exit;
   end;
   Result := True;

end;

procedure TSTELinesFlat.SetBinLocationFrom        (const Value: string    );begin  SetStringField('BinLocationFrom'       , Value);end;
procedure TSTELinesFlat.SetBinNumberFrom          (const Value: string    );begin  SetStringField('BinNumberFrom'         , Value);end;
procedure TSTELinesFlat.SetBinLocationTo          (const Value: string    );begin  SetStringField('BinLocationTo'         , Value);end;
procedure TSTELinesFlat.SetBinNumberTo            (const Value: string    );begin  SetStringField('BinNumberTo'           , Value);end;
procedure TSTELinesFlat.SetTransferSerialnos      (const Value: string    );begin  SetStringField('Serialnos'     , Value);end;
procedure TSTELinesFlat.SetSerialNumber           (const Value: string    );begin  SetStringField('SerialNumber'          , Value);end;

procedure TSTELines.ProductQty(AutoAdjusttransferQty:boolean = TRue);
var
  strSQL:String;
  function GetUOMField4Report:STring;begin
    if EnforceUOM then result := UnitOfMeasure else result := '';
  end;

begin
  if (ProductID = 0) or (classId = 0) then Exit;
  if (ProductChanged) then begin
    strSQL:= ProductQtyLib.SQL4ProductAvailableQty(Datetransferred ,GetUOMField4Report  , tSummary, ProductID, CLassId );
    with GetnewDataset(StrSQL, true) do try
            AvailableQty    := CommonLib.Round(FieldByname('Qty').asFloat, (*appEnv.CompanyPrefs.QtyRoundTo*)tcConst.GeneralRoundPlaces);
            if EnforceUOM then
              UOMAvailableQty := CommonLib.Round(FieldByname('UOMQty').asFloat,(*appEnv.CompanyPrefs.QtyRoundTo*)tcConst.GeneralRoundPlaces)
            else
              UOMAvailableQty := CommonLib.Round(FieldByname('Qty').asFloat/UOMMultiplier,(*appEnv.CompanyPrefs.QtyRoundTo*)tcConst.GeneralRoundPlaces);

            if AutoAdjusttransferQty then
              if UOMTransferQty > UOMAvailableQty then UOMTransferQty := UOMAvailableQty;
    finally
        if active then close;Free;
    end;
    strSQL:= 'SELECT sum(UOMTransferQty) as UOMQty,Sum(TRansferQty) as Qty '+
              ' from tblstockTransferEntryLines ' +
              ' where ProductID=' + IntToStr(ProductID) +
              ' and TransferEntryID = ' + IntToStr(HeaderID) +
              ' and TransferEntryLinesID < ' + IntToStr(ID);
    if EnforceUOM then
      strSQL := strSQL+' ANd UOM = ' +Quotedstr(UnitofMeasure) ;

    with getNewDataset(strSQL, true) do try
      AvailableQty    := AvailableQty   - CommonLib.Round(FieldByname('Qty').asFloat, (*appEnv.CompanyPrefs.QtyRoundTo*)tcConst.GeneralRoundPlaces);
      if EnforceUOM then
        UOMAvailableQty := UOMAvailableQty- CommonLib.Round(FieldByname('UOMQty').asFloat, (*appEnv.CompanyPrefs.QtyRoundTo*)tcConst.GeneralRoundPlaces)
      else
        UOMAvailableQty := CommonLib.Round(AvailableQty/UOMMultiplier , (*appEnv.CompanyPrefs.QtyRoundTo*)tcConst.GeneralRoundPlaces);
    finally
      if Active then close; free;
    end;
    if AutoAdjusttransferQty then begin
      if UOMTransferQty           > UOMAvailableQty then UOMTransferQty           := UOMAvailableQty;
      if TransferQty              > AvailableQty    then TransferQty              := AvailableQty;
    end;
  end;
  if AutoAdjusttransferQty then begin
    if UOMTransferQty < 0 then UOMTransferQty := 0;
    if TransferQty    < 0 then TransferQty    := 0;
  end;
end;

procedure TSTELinesFlat.ProductQty(AutoAdjusttransferQty:boolean = TRue);
var
  strSQL:String;
  function GetUOMField4Report:STring;begin
    if EnforceUOM then result := UnitOfMeasure else result := '';
  end;

begin
   inherited;

  if AllocationChanged then begin
    if (BatchNoFrom='')     and (expiryDateFrom=0) and (BinLocationFrom='') and
        (BinNumberFrom='') and (SerialNumbers='') then exit;
    if SerialNumbers <> '' then
      strSQL:= ProductQtyLib.SQL4ProductAvailableQty(Datetransferred , GetUOMField4Report , tDetailswithSno, ProductID, CLassId, batchnofrom, expirydatefrom, binlocationfrom, binnumberfrom , serialnumbers ,  tAvailable , '' , '' , 0 , False , False , False)
    else if binlocationfrom <> '' then
      strSQL:= ProductQtyLib.SQL4ProductAvailableQty(Datetransferred , GetUOMField4Report , tExtraDetails, ProductID, CLassId, batchnofrom, expirydatefrom, binlocationfrom, binnumberfrom )
    else
      strSQL:= ProductQtyLib.SQL4ProductAvailableQty(Datetransferred , GetUOMField4Report , tDetails, ProductID, CLassId, batchnofrom, expirydatefrom);

    with GetnewDataset(StrSQL, true) do try
        if recordcount > 0 then begin
            AllocatedQty    := CommonLib.Round(FieldByname('Qty').asFloat, (*appEnv.CompanyPrefs.QtyRoundTo*)tcConst.GeneralRoundPlaces);
            if EnforceUOM then
              UOMAllocatedQty := CommonLib.Round(FieldByname('UOMQty').asFloat, (*appEnv.CompanyPrefs.QtyRoundTo*)tcConst.GeneralRoundPlaces)
            else UOMAllocatedQty := CommonLib.Round(FieldByname('Qty').asFloat/UOMMultiplier, (*appEnv.CompanyPrefs.QtyRoundTo*)tcConst.GeneralRoundPlaces);
        end;
    finally
        if active then close; Free;
    end;
    strSQL:=  ' SELECT sum(UOMTransferQty) as UOMQty,Sum(TRansferQty) as Qty '+
              ' from tblstockTransferEntryLines     '+
              ' where  ProductID   = ' + IntToStr(ProductID) +
              ' and Batchnofrom = ' + quotedStr(Batchnofrom)+
              ' and (ifnull(ExpiryDatefrom,0) = 0 or ExpiryDatefrom = ' + QuotedStr(FormatDateTime(MysqlDateFormat , Expirydatefrom))+')' +
              ' and binlocationfrom = ' + quotedStr(binlocationfrom)+
              ' and binNumberfrom   = ' + quotedStr(binNumberfrom)+
              ' and TransferEntryID = ' + IntToStr(HeaderID) +
              ' and TransferEntryLinesID  < ' + IntToStr(ID);
    if EnforceUOM then
      strSQL:= strSQL+' and UOM       = ' + Quotedstr(UnitofMeasure) ;

    with getNewDataset(strSQL) do try
      AllocatedQty    := AllocatedQty - CommonLib.Round(FieldByname('Qty').asFloat, (*appEnv.CompanyPrefs.QtyRoundTo*)tcConst.GeneralRoundPlaces);
      if EnforceUOM then
        UOMAllocatedQty := UOMAllocatedQty- CommonLib.Round(FieldByname('UOMQty').asFloat, (*appEnv.CompanyPrefs.QtyRoundTo*)tcConst.GeneralRoundPlaces)
      else UOMAllocatedQty := AllocatedQty /UOMMultiplier;
    finally
      if Active then close;free;
    end;
    if AutoAdjusttransferQty then begin
      if TransferUOMAllocatedQty  > UOMAllocatedQty then TransferUOMAllocatedQty  := UOMAllocatedQty;
      if TransferAllocatedQty     > AllocatedQty    then TransferAllocatedQty     := AllocatedQty;
    end;
  end;

  StoreValues;
end;
function TSTELinesFlat.AllocationDetails: String;
var
  xnode :IXMLNode;
begin
  result := '';
  if (batchnofrom = '') and (binlocationfrom = '') and (Serialnumbers='') then exit;

  With TXMLDocument.Create('') do try
    active := true;
    xnode:= AddChild('Allocation');
    AddXMLNode(xnode,IDFieldName, ID);
    AddXMLNode(xnode,'BatchNoFrom' , BatchNoFrom);
    AddXMLNode(xnode,'expiryDateFrom' , expiryDateFrom);
    AddXMLNode(xnode,'BinLocationFrom', BinLocationFrom);
    AddXMLNode(xnode,'BinNumberFrom' , BinNumberFrom);
    AddXMLNode(xnode,'SerialNumbers', SerialNumbers);
    result := XML.text;
  finally
      //Free;
  end;
end;
function TSTELinesFlat.AllocationChanged: Boolean;
begin
    REsult := not(Sysutils.SameText(AllocationDetails , CleanAllocationDetails));
end;
function TSTELinesFlat.getbinIDFrom: Integer;
begin
  REsult := TProductBin.IDToggle(ClassIDFrom , BinLocationFrom , BinnumberFrom , self.connection.connection);
end;

function TSTELinesFlat.getbinIdTo: Integer;
begin
  REsult := TProductBin.IDToggle(classIDTO , BinLocationto , Binnumberto , self.connection.connection);
end;

{ TSTELinesTree }


function TSTELinesTree.getPQAFromAllocation : String;begin result := getStringfield('PQAFRom');end;
function TSTELinesTree.getPQAToAllocation   : String;begin result := GetStringfield('PQATO')  ;end;
function TSTELinesTree.getSTEPQA: TSTEPQA;
begin
    Result := TSTEPQA(getContainerComponent(TSTEPQA, 'TRansLineID = ' + inttostr(Self.ID) + ' and ifnull(TransType,"") = ' + Quotedstr(Self.Classname)+' and Alloctype = ' +quotedstr(alloctype)));
    if not RawMode then begin
      if (ID <> 0) and (Result.count = 0) and (IsPQAItem) then begin
        Result.New;
      end;
    end;
end;

function TSTELinesTree.GetAllocType: String;
begin
  Result := 'OUT';
end;
procedure TSTELinesTree.AfterCloneBusObj;
begin
  inherited;
  if assigned(ObjInstanceToClone) and (ObjInstanceToClone is TStockMovementLines) then
    With TStockMovementLines(ObjInstanceToClone) do begin
      PostDB;
      if Self is TSTELinesTreeIn then PQA.Alloctype := 'IN' else PQA.AllocType := 'OUT';
      PQA.PostDB;
      if AccountID <> 0 then AccountName := TAccount.IDToggle(AccountID, Self.connection.connection);
      Value := Qty*cost;
      if ProductID<> 0 then begin
          ProductName := Product.Productname;
          ProductPrintName := Product.ProductPrintName;
          Description := Product.SalesDescription;
          AssetAccountID := TAccount.IDToggle(Product.AssetAccount , Self.Connection.connection);
          ProductType          := Product.ProductType;
      end;
      if ClassID > 0 then DeptName := TDeptClass.IDToggle(DeptID, Connection.Connection)
      else  if DeptName <> '' then DeptID := TDeptClass.IDToggle(DeptName, Connection.Connection);
    end;
end;

function TSTELinesTree.GetPQA: TPQA;
begin
  if ID = 0 then PostnEditDB;
  Result := STEPQA;
  if not RawMode then begin
    if (ID <> 0) and (Result.count = 0) and (IsPQAItem) then begin
      Result.New;
    end;
  end;
end;

procedure TSTELinesTree.setPQAFromAllocation(const Value: String);begin SetStringfield('PQAFrom', value);end;
procedure TSTELinesTree.setPQAToAllocation  (const Value: String);begin SetStringField('PQATo'  , Value);end;

{ TSTELinesTreeIn }

function TSTELinesTreeIn.GetAllocType: String;
begin
  Result := 'IN'
end;

function TSTELinesTreeIn.GetClassID: Integer;
begin
  REsult := ClassIDTo;
end;
Function TStockTransferEntry.Process:Boolean;
begin
      result := false;
      if not Save then exit;

      if Processed then begin
        result:=true;
        Exit;
      end;

      Result := DoProcessST;
end;
Function TStockTransferEntry.DoProcessST:Boolean;
var
  fsOrder:String;
  strSQL:String;
begin
try
    if StockMovement.count > 0 then Exit;

    if Transfertype = StockTransfertypetoStr(sttGen) then begin
            fsOrder :=Lines.SQLOrder;
            StockMovement.lines.dataset.DisableControls;
            try
              fsOrder :=Lines.SQLOrder;
              Lines.SQLOrder := 'ProductID,UOMID, ClassIDTo, BatchNoFrom,expiryDateFrom, BinLocationFrom ,BinNumberFrom , SerialNumber, BatchNoTo, expiryDateTo , BinLocationTo , BinNumberTo';
              Lines.closeDB;
              Lines;
              Show_Status('Creating Stock Movement records');
              StockMovement.New;
              StockMovement.MovementDate        :=DateTransferred;
              StockMovement.AccountID           :=AccountID;
              StockMovement.Notes               :=Notes;
              StockMovement.EmployeeID          :=EmployeeID;
              StockMovement.Postdb;
              strSQL:= 'select SML.StockMovementLinesID , SML.ProductId,  '+
                    ' SML.classID , SML.UOMID, PQA.Alloctype' +
                    ' from tblstockMovementLines  SML '+
                    ' inner join tblPQA as PQA on PQA.TransLineID = SML.StockMovementLinesID  '+
                    ' and PQA.TRanstype = ' +quotedStr(TStockMovementLines.classname) +'  and PQA.active <> "F"' +
                    ' where SML.stockmovementID = ' + IntToStr(StockMovement.ID);
              MovementLines := TERPQuery(GetNewDataset(strSQL, true));
              try
                ProgressDialog.DoShowProgressbar(Lines.count,'Please Wait', 'Processing Stock Transfer', true);
                try
                  Lines.Iteraterecords(CallbackProcess);
                finally
                  ProgressDialog.DoHideProgressbar;
                end;
              finally
                  if MovementLines.active then MovementLines.close;
                  FreeandNil(MovementLines);
              end;
            finally
              Lines.SQLOrder := fsOrder;
              Lines.closeDB;
              Lines;
              StockMovement.lines.dataset.enablecontrols;
              Processed := TRue;
              PostDB;
              StockMovement.Save;
              REsult := True;
              Dirty := False;
            end;
    end else begin
      fbProcessing := True;
      try
        if Self.CloneBusObj('','',False ,'') <> nil then begin
          if TStockMovement(ObjInstanceToClone).Save then begin
                Processed := TRue;
                PostDB;
                REsult := True;
                Dirty := False;
          end;
        end;
      finally
        fbProcessing:= False;
      end;
    end;
  finally
  end;
end;
Procedure TStockTransferEntry.AfterCloneBusObj;
begin
  if assigned(ObjInstanceToClone) and (ObjInstanceToClone is TStockMovement) then
  With TStockMovement(ObjInstanceToClone) do begin
    if EmployeeID > 0 then
      EmployeeName := TEmployee.IDToggle(EmployeeID, Connection.Connection)
    else if EmployeeName <>'' then
      EmployeeID := TEmployee.IDToggle(EmployeeName, Connection.Connection);
  end;
end;
Procedure TStockTransferEntry.CreateInstance;
begin
  if fbProcessing then begin
      ObjInstanceToClone := StockMovement;
  end else begin
      ObjInstanceToClone := TStockTransferEntry.Create(nil);
      ObjInstanceToClone.connection := self.connection;
      ObjInstanceToClone.Load(0);
  end;
end;
Procedure TStockTransferEntry.ClonePropertyObjects;
begin
  if fbProcessing then begin
    TreeLines.IterateRecords(CloneLines);

    TreeLinesIn.IterateRecords(CloneLines);

  end else begin
    Lines.IterateRecords(CloneLines);
  end;
End;
procedure TStockTransferEntry.CloneLines(const Sender: TBusObj; var Abort: boolean);
begin
  if fbProcessing then begin
    Sender.CloneBusObj( 'StockmovementID' , ObjInstanceToClone.ID, False);
    if Sender.ObjInstanceToClone  = nil then begin
      fbObjectCopied := False;
      Exit;
    End;
    if sender.ObjInstanceToClone is TStockMovementLines then begin
      if sender is TSTELinesTreeIn then begin
        TStockMovementLines(sender.ObjInstanceToClone).deptID := TSTELinesTreeIn(Sender).ClassIDTo;
        //in transaction should be 1 seconds after
        TStockMovementLines(sender.ObjInstanceToClone).MovementDate := incsecond(TStockMovementLines(sender.ObjInstanceToClone).MovementDate , 1);
        TStockMovementLines(sender.ObjInstanceToClone).PostDB;
      end else if sender is TSTELinesTree then begin
        TStockMovementLines(sender.ObjInstanceToClone).deptID := TSTELinesTree(Sender).ClassIDFrom;
        TStockMovementLines(sender.ObjInstanceToClone).Qty    := (*0-*)TStockMovementLines(sender.ObjInstanceToClone).Qty;
        TStockMovementLines(sender.ObjInstanceToClone).uomQty    := (*0-*)TStockMovementLines(sender.ObjInstanceToClone).uomQty;
        TStockMovementLines(sender.ObjInstanceToClone).PostDB;
      end;
    end;
  end else begin
        Lines.FieldsnotToclone :=
          QuotedStr('AvailableQty') + ',' +
          QuotedStr('UOMAvailableQty') + ',' +
          QuotedStr('SerialNumber') + ',' +
          QuotedStr('AllocatedQty') + ',' +
          QuotedStr('UOMAllocatedQty') + ',' +
          QuotedStr('PQADetailClassRef');
        Sender.CloneBusObj(IDFieldNAme , ObjInstanceToClone.ID, False);
        if Sender.ObjInstanceToClone  = nil then begin
            fbObjectCopied := False;
            Exit;
        End;
    end;
end;
Procedure TSTELines.CreateInstance;
begin
    if Owner is TStockTransferEntry then
        if Assigned(TStockTransferEntry(Owner).ObjInstanceToClone) then
          if TStockTransferEntry(Owner).ObjInstanceToClone is TStockTransferEntry then
            ObjInstanceToClone :=TStockTransferEntry(TStockTransferEntry(Owner).ObjInstanceToClone).Lines
          else if TStockTransferEntry(Owner).ObjInstanceToClone is TStockMovement then
            ObjInstanceToClone :=TStockMovement(TStockTransferEntry(Owner).ObjInstanceToClone).Lines;
end;


procedure TSTELinesTree.ClonePropertyObjects;
begin
  inherited;
  (*if Assigned(ObjInstanceToClone) then
    if ObjInstanceToClone is TStockmovementlines then TStockmovementlines(ObjInstanceToClone).PQA.deleteAll;
  PQA.FieldsnotToclone := QuotedStr('TansID') + ',' + QuotedStr('TranslineID') + ',' + QuotedStr('Transtype');
  PQA.CloneBusObj('','', false, '');*)
  Copyallocation;

end;
procedure TSTELinesTree.DoFieldOnChange(Sender: TField);
begin
  inherited;
    if (Sysutils.SameText(Sender.fieldName , 'ProductID')) or
       (Sysutils.SameText(Sender.fieldname , 'UOM'))  then begin
      if not RawMode then begin
        ProductQty;
        CalcQtys;
      end;
    end;

end;

procedure TSTELinesTreeIn.ClonePropertyObjects;
begin
  inherited;
  (*if Assigned(ObjInstanceToClone) then
    if ObjInstanceToClone is TStockmovementlines then TStockmovementlines(ObjInstanceToClone).PQA.deleteAll;
    PQA.FieldsnotToclone := QuotedStr('TansID') + ',' + QuotedStr('TranslineID') + ',' + QuotedStr('Transtype');
    PQA.CloneBusObj('','', false, '')*)
    //Copyallocation;
end;

procedure TSTEPQA.CreateInstance;
begin
  if Assigned(Owner) then
    if Owner is TSTELinesTree then begin
        if Assigned(TSTELinesTree(Owner).ObjInstanceToClone) then begin
          if TSTELinesTree(Owner).ObjInstanceToClone is TStockMovementLines then begin
            ObjInstanceToClone :=TStockMovementLines(TSTELinesTree(Owner).ObjInstanceToClone).PQA;
            //ObjInstanceToClone.deleteAll;
          end;
        end else if (Assigned(Owner)) and (Owner is TSTELinesTree) and Assigned(TSTELinesTree(Owner).owner) and (TSTELinesTree(Owner).owner is TStockTransferEntry) and (TStockTransferEntry(TSTELinesTree(Owner).owner).userallocating) then begin
            ObjInstanceToClone :=TStockTransferEntry(TSTELinesTree(Owner).owner).TreeLinesIn.STEPQA;
        end else if Assigned(TSTELinesTree(Owner).owner) and (TSTELinesTree(Owner).owner is TStockTransferEntry) then begin
            if TStockTransferEntry(TSTELinesTree(Owner).owner).ObjInstanceToClone is TStockMovement  then begin
            ObjInstanceToClone :=TStockMovement(TStockTransferEntry(TSTELinesTree(Owner).owner).ObjInstanceToClone).lines.pqa;
            //ObjInstanceToClone.deleteAll;
          end;
        end;
    end;
end;
procedure TSTEPQA.ClonePropertyObjects;
begin
  inherited;
  //PQADetails.CloneBusObj('PQAID',ObjInstanceToClone.ID, false, '');
  //PQADetails.IterateRecords(CloneLines);
  if Product.Batch then PQAbatch.IterateRecords(CloneLines);

       if Product.MultipleBins and Product.Batch  then PQAbatch.PQAbins.IterateRecords(CloneLines)
  else if Product.MultipleBins and not(Product.Batch)  then PQAbins.IterateRecords(CloneLines);

        if Product.SnTracking and      Product.MultipleBins   and     Product.Batch  then PQAbatch.PQAbins.PQASN.IterateRecords(CloneLines)
  else if Product.SnTracking  and      Product.MultipleBins   and not(Product.Batch) then PQAbins.PQASN.IterateRecords(CloneLines)
  else if Product.SnTracking  and  not(Product.MultipleBins)  and     Product.Batch  then PQAbatch.PQASN.IterateRecords(CloneLines)
  else if Product.SnTracking  and  not(Product.MultipleBins)  and not(Product.Batch) then PQASN.IterateRecords(CloneLines);
end;
procedure TSTEPQA.CloneLines(const Sender: TBusObj; var Abort: boolean);
begin
    Sender.CloneBusObj('PQAID',ObjInstanceToClone.ID, false, '');
end;

procedure TSTEPQADetails.CreateInstance;
begin
  if Assigned(Owner) then
    if Owner is TSTEPQA then begin
        if Assigned(TSTEPQA(Owner).ObjInstanceToClone) then begin
          if TSTEPQA(Owner).ObjInstanceToClone is TPQA then begin
              if pqatype = 'Batch'  then begin
                      ObjInstanceToClone := TPQA(TSTEPQA(Owner).ObjInstanceToClone).PQABatch;
              end else  if pqatype = 'Bin'    then begin
                if Product.Batch then
                      ObjInstanceToClone := TPQA(TSTEPQA(Owner).ObjInstanceToClone).PQABatch.PQABins
                else  ObjInstanceToClone := TPQA(TSTEPQA(Owner).ObjInstanceToClone).PQAbins;
              end else   begin
                if Product.Batch  and Product.MultipleBins then
                      ObjInstanceToClone := TPQA(TSTEPQA(Owner).ObjInstanceToClone).PQABatch.PQAbins.PQASN
                else if Product.Batch  and not(Product.MultipleBins) then
                      ObjInstanceToClone := TPQA(TSTEPQA(Owner).ObjInstanceToClone).PQABatch.PQASN
                else if not(Product.Batch)  and Product.MultipleBins then
                      ObjInstanceToClone := TPQA(TSTEPQA(Owner).ObjInstanceToClone).PQABins.PQASN
                else if not(Product.Batch)  and not(Product.MultipleBins) then
                      ObjInstanceToClone := TPQA(TSTEPQA(Owner).ObjInstanceToClone).PQASN
              end;
          end;
        end;
    end;
end;

initialization
  RegisterClassOnce(TSTELines);
  RegisterClassOnce(TSTELinesFlat);
  RegisterClassOnce(TStockTransferEntry);
end.


