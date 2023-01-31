unit BusObjPickingAssembly;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  15/05/08  1.00.00  A  Initial Version.
  }


interface


uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf,
  BusObjEmployee, BusObjSales, busobjStock;


type

  {these classes are created to have 2 instance of the TEMployee type for picking employee and packing employee in the container}
  TPickingEmployee = class(TEmployee)
  end;

  TPackingEmployee = class(TEmployee)
  end;

  TPickingAssembly = Class;
  TPickingAssemblies = Class;

  TSalesSummaryLineForPackingforGUI = class(TBusObj)
  private
    fiPickingAssemblyEntryID :Integer;
    function GetproductId             : Integer   ;
    function Getproductname           : string    ;
    function GetProductDescription    : string    ;
    function GetQtyRequired           : Double    ;
    function GetTotalshipped          : Double    ;
    function GetQtyBackorder          : Double    ;
    function GetQtyPacked             : Double    ;
    function GetUOM                   : string    ;
    function GetUOMId                 : Integer   ;
    function GetUOMMultiplier       : Double    ;
    function GetDone                  : Boolean   ;
    procedure SetProductID             (const Value: Integer   );
    procedure Setproductname           (const Value: string    );
    procedure SetProductDescription    (const Value: string    );
    procedure SetQtyRequired           (const Value: Double    );
    procedure SetTotalshipped          (const Value: Double    );
    procedure SetQtyBackorder          (const Value: Double    );
    procedure SetQtyPacked             (const Value: Double    );
    procedure SetUOM                   (const Value: string    );
    procedure SetUOMId                 (const Value: Integer   );
    procedure SetUOMMultiplier       (const Value: Double    );
    procedure SetDone                  (const Value: Boolean   );
    function getPickingAssemblyEntryID: Integer;
    //function SalesSummaryLineForPackingforGUITablename: String;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforeOpen(Sender:TDatasetBusObj) : Boolean;            override;
    Function  DoCalcFields(Sender :TDatasetBusObj):Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
(*    procedure Load(Const aId: integer;const fIsReadonly:boolean =False); override;
    procedure Load(const fIsReadonly:boolean =False); override;*)
    property PickingAssemblyEntryID :Integer read getPickingAssemblyEntryID write fiPickingAssemblyEntryID;

  published
    property productId              :Integer     read GetproductId            write SetProductID         ;
    property productname            :string      read Getproductname          write Setproductname       ;
    property ProductDescription     :string      read GetProductDescription   write SetProductDescription;
    property QtyRequired            :Double      read GetQtyRequired          write SetQtyRequired       ;
    property Totalshipped           :Double      read GetTotalshipped         write SetTotalshipped      ;
    property QtyBackorder           :Double      read GetQtyBackorder         write SetQtyBackorder      ;
    property QtyPacked              :Double      read GetQtyPacked            write SetQtyPacked         ;
    property UOM                    :string      read GetUOM                  write SetUOM               ;
    property UOMId                  :Integer     read GetUOMId                write SetUOMId             ;
    property UOMMultiplier          :Double      read GetUOMMultiplier      write SetUOMMultiplier   ;
    property Done                   :Boolean     read GetDone                 write SetDone              ;
  end;

  TPickAssemEntrylines = class(TMSBusObj)
  private
    fiPackNumber: Integer;
    function GetPickingAssemblyEntryID         : Integer   ;
    function GetProductID                      : Integer   ;
    function GetProductName                    : string    ;
    function GetDescription                    : string    ;
    function GetSOPickingRef                   : string    ;
    function GetQty                            : Double    ;
    function GetQtyMultiplier                  : Double    ;
    function GetUOM                            : string    ;
    function GetUOMID                          : Integer   ;
    function GetSaleID                         : Integer   ;
    function GetPackNumber                     : Integer   ;
    procedure SetPickingAssemblyEntryID         (const Value: Integer   );
    procedure SetProductID                      (const Value: Integer   );
    procedure SetProductName                    (const Value: string    );
    procedure SetDescription                    (const Value: string    );
    procedure SetSOPickingRef                   (const Value: string    );
    procedure SetQty                            (const Value: Double    );
    procedure SetQtyMultiplier                  (const Value: Double    );
    procedure SetUOM                            (const Value: string    );
    procedure SetUOMID                          (const Value: Integer   );
    procedure SetSaleID                         (const Value: Integer   );
    procedure SetPackNumber                     (const Value: Integer   );
    function GetSale: TSales;
    function GetDispatched: boolean;
    procedure SetDispatched(const Value: boolean);
    //function CopyingSOPickingToInvoice :Boolean;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function  DoBeforeInsert(Sender:TDatasetBusObj) : Boolean;          override;
    Procedure CreateInstance; Override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    function isSaleEditable:Boolean;
    property Sale: TSales read GetSale;

  published
    property PickingAssemblyEntryID          :Integer     read GetPickingAssemblyEntryID        write SetPickingAssemblyEntryID     ;
    property ProductID                       :Integer     read GetProductID                     write SetProductID                  ;
    property ProductName                     :string      read GetProductName                   write SetProductName                ;
    property Description                     :string      read GetDescription                   write SetDescription                ;
    property SOPickingRef                    :string      read GetSOPickingRef                  write SetSOPickingRef               ;
    property Qty                             :Double      read GetQty                           write SetQty                        ;
    property QtyMultiplier                   :Double      read GetQtyMultiplier                 write SetQtyMultiplier              ;
    property UOM                             :string      read GetUOM                           write SetUOM                        ;
    property UOMID                           :Integer     read GetUOMID                         write SetUOMID                      ;
    property SaleID                          :Integer     read GetSaleID                        write SetSaleID                      ;
    property PackNumber                      :Integer     read GetPackNumber                    write SetPackNumber                 ;
    property Dispatched: boolean read GetDispatched write SetDispatched;
  end;


  TPickAssemEntry = class(TMSBusObj)
  private
    //fbSalesQtypicked:Boolean;
    SalesSummaryLineForPackingforGUITablename :String;
    fdQtyToshipfromBO:Double;
    AllLinesValid :Boolean;
    fiPacknumber:Integer;
    PickingSaleID:Integer;
    fsPacknumber:String;
    CopyingSOPickingToInvoice :Boolean;
    CopySOPickingToInvoiceFailed:Boolean;
    function GetSaleID                    : Integer   ;
    function GetBarcode                   : string    ;
    function GetSOPickingRef              : string    ;
    function GetPickingEmployeeID         : Integer   ;
    function GetStartPicking              : Boolean   ;
    function GetStartPickingTime          : TDateTime ;
    function GetFinishedPicking           : Boolean   ;
    function GetFinishedPickingTime       : TDateTime ;
    function GetPackingEmployeeID         : Integer   ;
    function GetStartPacking              : Boolean   ;
    function GetStartPackingTime          : TDateTime ;
    function GetFinishedPacking           : Boolean   ;
    function GetFinishedPackingTime       : TDateTime ;
    function GetCreatedOn                 : TDateTime ;
    function GetConverted                 : Boolean   ;
    procedure SetSaleID                    (const Value: Integer   );
    procedure SetBarcode                   (const Value: string    );
    procedure SetSOPickingRef              (const Value: string    );
    procedure SetPickingEmployeeID         (const Value: Integer   );
    procedure SetStartPicking              (const Value: Boolean   );
    procedure SetStartPickingTime          (const Value: TDateTime );
    procedure SetFinishedPicking           (const Value: Boolean   );
    procedure SetFinishedPickingTime       (const Value: TDateTime );
    procedure SetPackingEmployeeID         (const Value: Integer   );
    procedure SetStartPacking              (const Value: Boolean   );
    procedure SetStartPackingTime          (const Value: TDateTime );
    procedure SetFinishedPacking           (const Value: Boolean   );
    procedure SetFinishedPackingTime       (const Value: TDateTime );
    procedure SetCreatedOn                 (const Value: TDateTime );
    procedure SetConverted                 (const Value: Boolean   );
    function getLines: TPickAssemEntrylines;
    function getSalesSummaryLineForPacking: TSalesSummaryLineForPackingforGUI;
    function GetSale: TSales;
    function NewSaleObj: TSales;
    function getSalesPickingAssembly: TPickingAssembly;
    procedure PickQtyFromSalesGroup(QtytoBeshipped: double; sPacknumber:String = '');
    function ProductQtytoBeShipped(const fSaleID:Integer ;const ProductID: Integer; const uomid:Integer =0): Double;
    procedure PickQtyFromSalesGroupCallback(const Sender: TBusObj; var Abort: Boolean);
    function QtyPackedForProduct(const fSaleID:Integer ;const aProductId: integer; const uomid:Integer =0): double;
    function QtyshippedForProduct(const fSaleID:Integer ;const aProductId: integer; const uomid:Integer =0): double;
    procedure Savecallback(const Sender: TBusObj; var Abort: Boolean);
    procedure HasAnytopickCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure HasAnytopickinBOCallback(const Sender: TBusObj; var Abort: Boolean);
    function GetStatusText: string;
    procedure MaxLinePackNumberCallback(const Sender: TBusObj; var Abort: Boolean);
    function getPickingAssemblies: TPickingAssemblies;
    Procedure LoadSalesSummaryLineForPacking;
    function InvoiceID(const SOID: Integer): Integer;
    Procedure CloneLines(Const Sender: TBusObj; Var Abort: Boolean);
    function GetDispatchingEmployeeID: Integer;
    function GetFinishedDispatch: Boolean;
    function GetFinishedDispatchTime: TDateTime;
    function GetStartDispatch: Boolean;
    function GetStartDispatchTime: TDateTime;
    procedure SetDispatchingEmployeeID(const Value: Integer);
    procedure SetFinishedDispatch(const Value: Boolean);
    procedure SetFinishedDispatchTime(const Value: TDateTime);
    procedure SetStartDispatch(const Value: Boolean);
    procedure SetStartDispatchTime(const Value: TDateTime);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function  DoBeforeDelete(Sender :TDatasetBusObj ):Boolean;          Override;
    Procedure ClonePropertyObjects; Override;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Procedure    PicksalesQty(PickBOQty:Boolean = False; sPacknumber:String = '');Overload;
    Procedure    PicksalesQty(SalesLine: TSalesLine);Overload;
    Procedure    PicksalesQty(SalesLine: TSalesLine; Qtypicking:double; sPacknumber: String = '');Overload;
    Procedure    PickQty(SalesLine: TSalesLine; Qtypicking:double;IgnoreUOM:Boolean; sPacknumber: String = '');Overload;
    //procedure PicksalesQty(QtytoBeshipped: double; PickBOQty: Boolean);Overload;
    Procedure    AdjustPicksalesQty(fdQty:Double);
    Property SalesSummaryLineForPacking : TSalesSummaryLineForPackingforGUI REad getSalesSummaryLineForPacking;
    property Sale: TSales read GetSale;
    //Property SalesQtypicked :Boolean read fbSalesQtypicked write fbSalesQtypicked;
    Property SalesPickingAssembly :TPickingAssembly REad getSalesPickingAssembly;
    Property PickingAssemblies : TPickingAssemblies read getPickingAssemblies;
    property StatusText: string read GetStatusText;
    function MaxLinePackNumber: integer;
    function HasAnytopick(checkBOs:Boolean =False):Boolean;
    Function CopySOPickingToInvoice :Boolean;
    function FlagAsDispatched(aPackNo: integer): boolean;
  published
    property SaleID                     :Integer     read GetSaleID                   write SetSaleID                ;
    property Barcode                    :string      read GetBarcode                  write SetBarcode               ;
    property SOPickingRef               :string      read GetSOPickingRef             write SetSOPickingRef          ;
    property PickingEmployeeID          :Integer     read GetPickingEmployeeID        write SetPickingEmployeeID     ;
    property StartPicking               :Boolean     read GetStartPicking             write SetStartPicking          ;
    property StartPickingTime           :TDateTime   read GetStartPickingTime         write SetStartPickingTime      ;
    property FinishedPicking            :Boolean     read GetFinishedPicking          write SetFinishedPicking       ;
    property FinishedPickingTime        :TDateTime   read GetFinishedPickingTime      write SetFinishedPickingTime   ;
    property PackingEmployeeID          :Integer     read GetPackingEmployeeID        write SetPackingEmployeeID     ;
    property StartPacking               :Boolean     read GetStartPacking             write SetStartPacking          ;
    property StartPackingTime           :TDateTime   read GetStartPackingTime         write SetStartPackingTime      ;
    property FinishedPacking            :Boolean     read GetFinishedPacking          write SetFinishedPacking       ;
    property FinishedPackingTime        :TDateTime   read GetFinishedPackingTime      write SetFinishedPackingTime   ;

    property DispatchingEmployeeID      :Integer     read GetDispatchingEmployeeID    write SetDispatchingEmployeeID ;
    property StartDispatch              :Boolean     read GetStartDispatch           write SetStartDispatch         ;
    property StartDispatchTime          :TDateTime   read GetStartDispatchTime        write SetStartDispatchTime     ;
    property FinishedDispatch           :Boolean     read GetFinishedDispatch         write SetFinishedDispatch      ;
    property FinishedDispatchTime       :TDateTime   read GetFinishedDispatchTime     write SetFinishedDispatchTime  ;

    property CreatedOn                  :TDateTime   read GetCreatedOn                write SetCreatedOn   ;
    property Converted                  :Boolean     read GetConverted                write SetConverted             ;
    Property Lines :TPickAssemEntrylines read getLines;

  end;
  TPickingAssemblyLine = class(TMSBusObj)
  private
    function GetPickingAssemblyID         : Integer   ;
    function GetPickingAssemblyentrylinesID: Integer   ;
    function GetProductID                 : Integer   ;
    function GetProductName               : string    ;
    function GetDescription               : string    ;
    function GetSOPickingRef              : string    ;
    function GetQty                       : double    ;
    function GetQtyMultiplier             : double    ;
    function GetUOM                       : string    ;
    function GetUOMID                     : Integer   ;
    function GetPackNumber                : Integer   ;
    procedure SetPickingAssemblyID         (const Value: Integer   );
    procedure SetPickingAssemblyentrylinesID(const Value: Integer   );
    procedure SetProductID                 (const Value: Integer   );
    procedure SetProductName               (const Value: string    );
    procedure SetDescription               (const Value: string    );
    procedure SetSOPickingRef              (const Value: string    );
    procedure SetQty                       (const Value: double    );
    procedure SetQtyMultiplier             (const Value: double    );
    procedure SetUOM                       (const Value: string    );
    procedure SetUOMID                     (const Value: Integer   );
    procedure SetPackNumber                (const Value: Integer   );
    function GetProduct: TProduct;
    Function Entrylineref:String;
    function GetDispatched: boolean;
    procedure SetDispatched(const Value: boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Procedure CreateInstance; Override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property Product: TProduct read GetProduct;
    procedure New; override;
  published
    property PickingAssemblyID          :Integer     read GetPickingAssemblyID        write SetPickingAssemblyID     ;
    property PickingAssemblyentrylinesID:Integer     read GetPickingAssemblyentrylinesID        write SetPickingAssemblyentrylinesID     ;
    property ProductID                  :Integer     read GetProductID                write SetProductID             ;
    property ProductName                :string      read GetProductName              write SetProductName           ;
    property Description                :string      read GetDescription              write SetDescription           ;
    property SOPickingRef               :string      read GetSOPickingRef             write SetSOPickingRef          ;
    property Qty                        :double      read GetQty                      write SetQty                   ;
    property QtyMultiplier              :double      read GetQtyMultiplier            write SetQtyMultiplier         ;
    property UOM                        :string      read GetUOM                      write SetUOM                   ;
    property UOMID                      :Integer     read GetUOMID                    write SetUOMID                 ;
    property PackNumber                 :Integer     read GetPackNumber               write SetPackNumber            ;
    property Dispatched: boolean read GetDispatched write SetDispatched;
  end;


  TPickingAssembly = class(TMSBusObj)
  private
    function GetSaleID                 : Integer   ;
    function GetBarcode                : string    ;
    function GetSOPickingRef           : string    ;
    function GetPickingEmployeeID      : Integer   ;
    function GetPickingAssemblyEntryID : Integer   ;
    function GetStartPicking           : Boolean   ;
    function GetStartPickingTime       : TDateTime ;
    function GetFinishedPicking        : Boolean   ;
    function GetFinishedPickingTime    : TDateTime ;
    function GetPackingEmployeeID      : Integer   ;
    function GetStartPacking           : Boolean   ;
    function GetStartPackingTime       : TDateTime ;
    function GetFinishedPacking        : Boolean   ;
    function GetFinishedPackingTime    : TDateTime ;
    function GetConverted              : Boolean   ;
    procedure SetSaleID                 (const Value: Integer   );
    procedure SetBarcode                (const Value: string    );
    procedure SetSOPickingRef           (const Value: string    );
    procedure SetPickingEmployeeID      (const Value: Integer   );
    procedure SetPickingAssemblyEntryID (const Value: Integer   );
    procedure SetStartPicking           (const Value: Boolean   );
    procedure SetStartPickingTime       (const Value: TDateTime );
    procedure SetFinishedPicking        (const Value: Boolean   );
    procedure SetFinishedPickingTime    (const Value: TDateTime );
    procedure SetPackingEmployeeID      (const Value: Integer   );
    procedure SetStartPacking           (const Value: Boolean   );
    procedure SetStartPackingTime       (const Value: TDateTime );
    procedure SetFinishedPacking        (const Value: Boolean   );
    procedure SetFinishedPackingTime    (const Value: TDateTime );
    procedure SetConverted              (const Value: Boolean   );
    function GetLines: TPickingAssemblyLine;
    function GetStatusText: string;
    function GetPackingEmployee: TPackingEmployee;
    function GetPickingEmployee: TPickingEmployee;
    function GetSale: TSales;
    function ValidateLines: boolean;
    function GetDispatchingEmployeeID: Integer;
    function GetFinishedDispatch: Boolean;
    function GetFinishedDispatchTime: TDateTime;
    function GetStartDispatch: Boolean;
    function GetStartDispatchTime: TDateTime;
    procedure SetDispatchingEmployeeID(const Value: Integer);
    procedure SetFinishedDispatch(const Value: Boolean);
    procedure SetFinishedDispatchTime(const Value: TDateTime);
    procedure SetStartDispatch(const Value: Boolean);
    procedure SetStartDispatchTime(const Value: TDateTime);


  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    Function  DoBeforeDelete(Sender :TDatasetBusObj ):Boolean;          Override;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property Lines: TPickingAssemblyLine read GetLines;
    property Sale: TSales read GetSale;
    property PickingEmployee: TPickingEmployee read GetPickingEmployee;
    property PackinggEmployee: TPackingEmployee read GetPackingEmployee;
    class function IsComplete(const aSaleId: integer): boolean;
    function MaxLinePackNumber: integer;
    procedure Load(const fIsReadonly:boolean =False); override;
    procedure Closedb; override;
  published
    property SaleID                  :Integer     read GetSaleID                write SetSaleID             ;
    property Barcode                 :string      read GetBarcode               write SetBarcode            ;
    property SOPickingRef            :string      read GetSOPickingRef          write SetSOPickingRef       ;
    property PickingEmployeeID       :Integer     read GetPickingEmployeeID     write SetPickingEmployeeID  ;
    property PickingAssemblyEntryID  :Integer     read GetPickingAssemblyEntryID write SetPickingAssemblyEntryID  ;
    property StartPicking            :Boolean     read GetStartPicking          write SetStartPicking       ;
    property StartPickingTime        :TDateTime   read GetStartPickingTime      write SetStartPickingTime   ;
    property FinishedPicking         :Boolean     read GetFinishedPicking       write SetFinishedPicking    ;
    property FinishedPickingTime     :TDateTime   read GetFinishedPickingTime   write SetFinishedPickingTime;
    property PackingEmployeeID       :Integer     read GetPackingEmployeeID     write SetPackingEmployeeID  ;
    property StartPacking            :Boolean     read GetStartPacking          write SetStartPacking       ;
    property StartPackingTime        :TDateTime   read GetStartPackingTime      write SetStartPackingTime   ;
    property FinishedPacking         :Boolean     read GetFinishedPacking       write SetFinishedPacking    ;
    property FinishedPackingTime     :TDateTime   read GetFinishedPackingTime   write SetFinishedPackingTime;

    property DispatchingEmployeeID      :Integer     read GetDispatchingEmployeeID    write SetDispatchingEmployeeID ;
    property StartDispatch              :Boolean     read GetStartDispatch           write SetStartDispatch         ;
    property StartDispatchTime          :TDateTime   read GetStartDispatchTime        write SetStartDispatchTime     ;
    property FinishedDispatch           :Boolean     read GetFinishedDispatch         write SetFinishedDispatch      ;
    property FinishedDispatchTime       :TDateTime   read GetFinishedDispatchTime     write SetFinishedDispatchTime  ;

    property Converted               :Boolean     read GetConverted             write SetConverted          ;
    property StatusText: string read GetStatusText;
  end;

  TPickingAssemblies = class(TPickingAssembly)
  Private
    CopySOPickingToInvoiceFailed:Boolean;
    Function ClonedEntrylineIDforRef(const Ref:String):Integer;
  Protected
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Procedure CreateInstance; Override;
    Procedure ClonePropertyObjects; Override;
    Procedure CloneLines(Const Sender: TBusObj; Var Abort: Boolean);
  Public
    constructor  Create(AOwner: TComponent);                            override;
  end;
implementation


uses
  CommonLib, {FastFuncs,} SalesConst, BusobjSaleBase, CommonDbLib,
  MyAccess,ERPdbComponents ,Sysutils, tcDataUtils, variants, tcConst, BusObjConst,  AppEnvironment;

  {TPickingAssembly}

constructor TPickingAssembly.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'PickingAssembly';
  fSQL := 'SELECT * FROM tblpickingassembly';
end;


destructor TPickingAssembly.Destroy;
begin
  inherited;
end;


procedure TPickingAssembly.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SaleID');
  SetPropertyFromNode(node,'Barcode');
  SetPropertyFromNode(node,'SOPickingRef');
  SetPropertyFromNode(node,'PickingEmployeeID');
  SetPropertyFromNode(node,'PickingAssemblyEntryID');
  SetBooleanPropertyFromNode(node,'StartPicking');
  SetDateTimePropertyFromNode(node,'StartPickingTime');
  SetBooleanPropertyFromNode(node,'FinishedPicking');
  SetDateTimePropertyFromNode(node,'FinishedPickingTime');
  SetPropertyFromNode(node,'PackingEmployeeID');
  SetBooleanPropertyFromNode(node,'StartPacking');
  SetDateTimePropertyFromNode(node,'StartPackingTime');
  SetBooleanPropertyFromNode(node,'FinishedPacking');
  SetDateTimePropertyFromNode(node,'FinishedPackingTime');
  SetBooleanPropertyFromNode(node,'Converted');
end;


procedure TPickingAssembly.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SaleID' ,SaleID);
  AddXMLNode(node,'Barcode' ,Barcode);
  AddXMLNode(node,'SOPickingRef' ,SOPickingRef);
  AddXMLNode(node,'PickingEmployeeID' ,PickingEmployeeID);
  AddXMLNode(node,'PickingAssemblyEntryID' ,PickingAssemblyEntryID);
  AddXMLNode(node,'StartPicking' ,StartPicking);
  AddXMLNode(node,'StartPickingTime' ,StartPickingTime);
  AddXMLNode(node,'FinishedPicking' ,FinishedPicking);
  AddXMLNode(node,'FinishedPickingTime' ,FinishedPickingTime);
  AddXMLNode(node,'PackingEmployeeID' ,PackingEmployeeID);
  AddXMLNode(node,'StartPacking' ,StartPacking);
  AddXMLNode(node,'StartPackingTime' ,StartPackingTime);
  AddXMLNode(node,'FinishedPacking' ,FinishedPacking);
  AddXMLNode(node,'FinishedPackingTime' ,FinishedPackingTime);
  AddXMLNode(node,'Converted' ,Converted);
end;


function TPickingAssembly.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if SaleID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'SaleID should not be 0' , true );
    Exit;
  end;
  if not ValidateLines then
    exit;
  Result := True;
end;


function TPickingAssembly.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPickingAssembly.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TPickingAssembly.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TPickingAssembly.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TPickingAssembly.GetIDField: string;
begin
  Result := 'PickingAssemblyID'
end;


class function TPickingAssembly.GetBusObjectTablename: string;
begin
  Result:= 'tblpickingassembly';
end;


function TPickingAssembly.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


function TPickingAssembly.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeDelete(Sender);
  if not result then exit;
  Lines.deleteAll;
end;

{Property Functions}
function  TPickingAssembly.GetSaleID             : Integer   ; begin Result := GetIntegerField('SaleID');end;
function  TPickingAssembly.GetBarcode            : string    ; begin Result := GetStringField('Barcode');end;
function  TPickingAssembly.GetSOPickingRef       : string    ; begin Result := GetStringField('SOPickingRef');end;
function  TPickingAssembly.GetPickingEmployeeID  : Integer   ; begin Result := GetIntegerField('PickingEmployeeID');end;
function  TPickingAssembly.GetPickingAssemblyEntryID  : Integer   ; begin Result := GetIntegerField('PickingAssemblyEntryID');end;
function  TPickingAssembly.GetStartPicking       : Boolean   ; begin Result := GetBooleanField('StartPicking');end;
function  TPickingAssembly.GetStartPickingTime   : TDateTime ; begin Result := GetDateTimeField('StartPickingTime');end;
function  TPickingAssembly.GetFinishedPicking    : Boolean   ; begin Result := GetBooleanField('FinishedPicking');end;
function  TPickingAssembly.GetFinishedPickingTime: TDateTime ; begin Result := GetDateTimeField('FinishedPickingTime');end;
function  TPickingAssembly.GetPackingEmployeeID  : Integer   ; begin Result := GetIntegerField('PackingEmployeeID');end;
function TPickingAssembly.GetStartDispatch: Boolean;
begin
  result := GetBooleanField('StartDispatch');
end;

function TPickingAssembly.GetStartDispatchTime: TDateTime;
begin
  result := GetDateTimeField('StartDispatchTime');
end;

function  TPickingAssembly.GetStartPacking       : Boolean   ; begin Result := GetBooleanField('StartPacking');end;
function  TPickingAssembly.GetStartPackingTime   : TDateTime ; begin Result := GetDateTimeField('StartPackingTime');end;
function TPickingAssembly.GetFinishedDispatch: Boolean;
begin
  result := GetBooleanField('FinishedDispatch');
end;

function TPickingAssembly.GetFinishedDispatchTime: TDateTime;
begin
  result := GetDateTimeField('FinishedDispatchTime');
end;

function  TPickingAssembly.GetFinishedPacking    : Boolean   ; begin Result := GetBooleanField('FinishedPacking');end;
function  TPickingAssembly.GetFinishedPackingTime: TDateTime ; begin Result := GetDateTimeField('FinishedPackingTime');end;
function  TPickingAssembly.GetConverted          : Boolean   ; begin Result := GetBooleanField('Converted');end;
function TPickingAssembly.GetDispatchingEmployeeID: Integer;
begin
  result := GetIntegerField('DispatchingEmployeeID');
end;

procedure TPickingAssembly.SetSaleID             (const Value: Integer   ); begin SetIntegerField('SaleID'              , Value);end;
procedure TPickingAssembly.SetBarcode            (const Value: string    ); begin SetStringField('Barcode'             , Value);end;
procedure TPickingAssembly.SetSOPickingRef       (const Value: string    ); begin SetStringField('SOPickingRef'        , Value);end;
procedure TPickingAssembly.SetPickingEmployeeID  (const Value: Integer   ); begin SetIntegerField('PickingEmployeeID'   , Value);end;
procedure TPickingAssembly.SetPickingAssemblyEntryID  (const Value: Integer   ); begin SetIntegerField('PickingAssemblyEntryID'   , Value);end;
procedure TPickingAssembly.SetStartPicking       (const Value: Boolean   ); begin SetBooleanField('StartPicking'        , Value);end;
procedure TPickingAssembly.SetStartPickingTime   (const Value: TDateTime ); begin SetDateTimeField('StartPickingTime'    , Value);end;
procedure TPickingAssembly.SetFinishedPicking    (const Value: Boolean   ); begin SetBooleanField('FinishedPicking'     , Value);end;
procedure TPickingAssembly.SetFinishedPickingTime(const Value: TDateTime ); begin SetDateTimeField('FinishedPickingTime' , Value);end;
procedure TPickingAssembly.SetPackingEmployeeID  (const Value: Integer   ); begin SetIntegerField('PackingEmployeeID'   , Value);end;
procedure TPickingAssembly.SetStartDispatch(const Value: Boolean);
begin
  SetBooleanField('StartDispatch',Value);
end;

procedure TPickingAssembly.SetStartDispatchTime(const Value: TDateTime);
begin
  SetDateTimeField('StartDispatchTime',Value);
end;

procedure TPickingAssembly.SetStartPacking       (const Value: Boolean   ); begin SetBooleanField('StartPacking'        , Value);end;
procedure TPickingAssembly.SetStartPackingTime   (const Value: TDateTime ); begin SetDateTimeField('StartPackingTime'    , Value);end;
procedure TPickingAssembly.SetFinishedDispatch(const Value: Boolean);
begin
  SetBooleanField('FinishedDispatch',Value);
end;

procedure TPickingAssembly.SetFinishedDispatchTime(const Value: TDateTime);
begin
  SetDateTimeField('FinishedDispatchTime',Value);
end;

procedure TPickingAssembly.SetFinishedPacking    (const Value: Boolean   ); begin SetBooleanField('FinishedPacking'     , Value);end;
procedure TPickingAssembly.SetFinishedPackingTime(const Value: TDateTime ); begin SetDateTimeField('FinishedPackingTime', Value);end;
procedure TPickingAssembly.SetConverted          (const Value: Boolean   ); begin SetBooleanField('Converted'     , Value);end;


procedure TPickingAssembly.SetDispatchingEmployeeID(const Value: Integer);
begin
  SetIntegerField('DispatchingEmployeeID', Value);
end;

function TPickingAssembly.GetLines: TPickingAssemblyLine;
begin
  Result:= TPickingAssemblyLine(getContainerComponent(TPickingAssemblyLine, 'PickingAssemblyID = '+ IntToStr(Self.Id)));
end;

function TPickingAssembly.GetStatusText: string;
begin
  if self.FinishedPacking then
    result:= 'Packing Finished'
  else if self.StartPacking then
    result:= 'Packing Started'
  else if self.FinishedPicking then
    result:= 'Picking Finished'
  else if self.StartPicking then
    result:= 'Picking Started'
  else
    result:= 'Not Started';
end;

function TPickingAssembly.GetPackingEmployee: TPackingEmployee;
begin
  if self.PackingEmployeeID > 0 then begin
    Result:= TPackingEmployee(getContainerComponent(TPackingEmployee, 'EmployeeID = 0'));
    if result.Id <> self.PackingEmployeeID then
      result.Load(PackingEmployeeID);
  end
  else begin
    result:= nil;
  end;
end;

function TPickingAssembly.GetPickingEmployee: TPickingEmployee;
begin
  if self.PickingEmployeeID > 0 then begin
    Result:= TPickingEmployee(getContainerComponent(TPickingEmployee, 'EmployeeID = 0'));
    if result.Id <> self.PickingEmployeeID then
      result.Load(PickingEmployeeID);
  end
  else begin
    result:= nil;
  end;
end;

function TPickingAssembly.GetSale: TSales;
var
  SaleType: TSaleType;
begin
  result:= nil;
  if self.SaleID < 1 then exit;
  SaleType:= TSales.GetSaleType(SaleId);
  if SaleType = stSalesOrder then  Result:= Tsales(getContainerComponent(TsalesOrder, 'SaleID = '+ IntToStr(Self.SaleId)))
  else Result:= Tsales(getContainerComponent(TInvoice, 'SaleID = '+ IntToStr(Self.SaleId)));

(*  result:= nil;
  if self.SaleID < 1 then exit;

  SaleType:= TSales.GetSaleType(SaleId);
  result:= TSales(container.ItemByClass(TSales,false));
  if Assigned(result) then begin
    if ((SaleType = stSalesOrder) and (not result.IsSalesOrder)) or
       ((SaleType = stInvoice) and (not result.IsInvoice)) then begin
      container.Clear(TSales);
      result:= nil;
    end;
  end;


  if not Assigned(result) then begin
    if SaleType = stInvoice then begin
      result:= TInvoice.Create(nil);
      Container.Add(result);
    end
    else if SaleType = stSalesOrder then begin
      result:= TSalesOrder.Create(nil);
      Container.Add(result);
    end;
    if Assigned(result) then begin
      result.LockGroupName:= self.LockGroupName;
//      if Self.ConnectionAssigned then
//        result.Connection := Self.Connection;
      result.Connection := TMyDacDataConnection.Create(result);
      result.Connection.Connection:= self.Dataset.Connection;
      if Self.SilentMode then
        result.SilentMode := True;
    end;
  end;

  if Assigned(result) and (result.Id <> SaleId) then begin
    result.Load(SaleId);
    //if Result is TSales then TSales(Result).InstantiateAllTrees; // load the trees to copy
  end;*)
end;

class function TPickingAssembly.IsComplete(const aSaleId: integer): boolean;
var
  qry: TERPQuery;
begin
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Add('select FinishedPicking, FinishedPacking from tblPickingAssembly');
    qry.SQL.Add('where SaleId = ' + IntToStr(aSaleId));
    qry.Open;
    result:= qry.FieldByName('FinishedPicking').AsBoolean and
             qry.FieldByName('FinishedPacking').AsBoolean;
  finally
    qry.Free;
  end;
end;

function TPickingAssembly.ValidateLines: boolean;
var
  bm: TBookMark;
begin
  result:= true;
  if Lines.Count > 0 then begin
    Lines.Dataset.DisableControls;
    bm:= Lines.Dataset.GetBookmark;
    try
      Lines.Dataset.First;
      while not Lines.Dataset.Eof do begin
        if not Lines.ValidateData then begin
          result:= false;
          break;
        end;
        Lines.Dataset.Next;
      end;
    finally
      Lines.Dataset.GotoBookmark(bm);
      Lines.Dataset.FreeBookmark(bm);
      Lines.Dataset.EnableControls;
    end;
  end;
end;

function TPickingAssembly.MaxLinePackNumber: integer;
var
  bm: TBookMark;
begin
  result:= 0;
  if Lines.Count > 0 then begin
    Lines.Dataset.DisableControls;
    bm:= Lines.Dataset.GetBookmark;
    try
      Lines.Dataset.First;
      while not Lines.Dataset.Eof do begin
        if Lines.PackNumber > result then
          result:= Lines.PackNumber;
        Lines.Dataset.Next;
      end;
    finally
      Lines.Dataset.GotoBookmark(bm);
      Lines.Dataset.FreeBookmark(bm);
      Lines.Dataset.EnableControls;
    end;
  end;
end;

procedure TPickingAssembly.Load(const fIsReadonly:boolean =False);
begin
  inherited;
  Lines.LoadSelect('PickingAssemblyID = ' + IntToStr(ID));
end;
function TPickAssemEntry.QtyshippedForProduct(const fSaleID:Integer ;const aProductId: integer; const uomid:Integer =0): double;
var
  s:String;
begin
  s:= 'select sum(SL.shipped) qty ' +
        ' from tblsaleslines SL   ' +
        ' where SL.ProductID = ' + inttostr(aProductID) +' and SL.SaleID = ' + inttostr(fSaleID);
  if uomid <> 0 then s:= s +' and SL.UnitOfMeasureID = ' + inttostr(UOMID);
  with getNewdataset(s, true) do try
    result := fieldbyname('Qty').AsFloat;
  finally
    if Active then close;
    Free;
  end;
end;
function TPickAssemEntry.QtyPackedForProduct(const fSaleID:Integer ;const aProductId: integer; const uomid:Integer =0): double;
var
  s:String;
begin
  (*s:= 'select Sum(PAL.Qty * PAL.QtyMultiplier) qty ' +
        ' from tblpickingassembly PA  ' +
        ' inner join  tblpickingassemblylines PAL on PA.PickingAssemblyID = PAL.PickingAssemblyID   ' +
        ' where PAL.ProductID = ' + inttostr(aProductID) +' and PA.SaleID = ' + inttostr(fSaleID);*)
  s:= 'Select Sum(Qty) as Qty from tblpickingassemblyentrylines where ProductID = ' + inttostr(aProductID) +' and SaleID = ' + inttostr(fSaleID);
  if uomid <> 0 then s:= s +' and UOMID = ' + inttostr(UOMID);
  with getNewdataset(s, true) do try
    result := fieldbyname('Qty').AsFloat;
  finally
    if Active then close;
    Free;
  end;

(*var
  bm: TbookMark;
begin
  Result := 0;
  if self.Lines.Count > 0 then begin
    self.Lines.DataSet.DisableControls;
    try
      bm:= self.Lines.DataSet.getBookMark;
      try
        Lines.First;
        while not Lines.Eof do begin
          if Lines.ProductID = aProductId then
            result:= result + (Lines.Qty * Lines.QtyMultiplier);
          Lines.Next;
        end;
        Lines.Dataset.gotoBookMark(bm);
      finally
        Lines.Dataset.FreeBookmark(bm);
      end;
    finally
      Lines.DataSet.enableControls;
    end;
  end;*)
end;


procedure TPickingAssemblies.ClonePropertyObjects;
begin
  inherited;
  Lines.IterateRecords(CloneLines);
end;
function TPickingAssemblies.ClonedEntrylineIDforRef(const Ref: String): Integer;
begin
  REsult := 0;
  if Assigned(ObjInstanceToClone) and (ObjInstanceToClone is TPickingAssemblies) then
    if Assigned(TPickingAssemblies(ObjInstanceToClone).Owner ) and (TPickingAssemblies(ObjInstanceToClone).Owner is  TPickAssemEntry) then
      if TPickAssemEntry(TPickingAssemblies(ObjInstanceToClone).Owner).Lines.Locate('SOPickingREf' , Ref, []) then
        Result :=TPickAssemEntry(TPickingAssemblies(ObjInstanceToClone).Owner).Lines.ID;
end;


procedure TPickingAssembly.Closedb;
begin
//  Lines.Closedb;
  Container.Clear;
  inherited;
end;

  {TPickAssemEntry}
function TPickAssemEntry.ProductQtytoBeShipped(const fSaleID:Integer ;Const ProductID:Integer; const uomid:Integer =0):Double;
var
  TotalPacked, SaleTotQty  :double;
begin
  TotalPacked:= QtyPackedForProduct(fsaleID, ProductID, uomid);
  SaleTotQty:= QtyShippedForProduct(fsaleID, ProductID , uomid);
  Result := SaleTotQty - TotalPacked;
end;
Procedure    TPickAssemEntry.AdjustPicksalesQty(fdQty:Double);
var
  QtytoBeshipped:Double;
begin
  fdQty :=   fdQty - Lines.Qty;
  if fdQty = 0 then exit;
  if fdQty > 0 then begin {increased Qty}
      QtytoBeshipped := ProductQtytoBeShipped(Lines.SaleID, Lines.productID, Lines.UOMID);
      if QtytoBeshipped >= fdQty then begin
        Lines.Qty := Lines.Qty  + fdQty;
        Lines.PostDb;
      end else begin
        if QtytoBeshipped >0 then begin
          Lines.Qty := Lines.Qty  + QtytoBeshipped;
          Lines.PostDb;
          fdQty := fdQty - QtytoBeshipped;
        end;
        if not SalesSummaryLineForPacking.Locate('ProductID;UOMID' , vararrayof([Lines.ProductID,Lines.UOMID]) ,[] ) then
          if not SalesSummaryLineForPacking.Locate('ProductID' , Lines.ProductID ,[] ) then exit;
        PickQtyFromSalesGroup( fdQty);

      end;
  end else begin {Qty decreased}
    Lines.Qty := Lines.Qty  - abs(fdQty);
    Lines.PostDb;
  end;
end;
Procedure    TPickAssemEntry.PicksalesQty(SalesLine : TSalesLine);
var
  QtytoBeshipped :double;
begin
  if not SalesSummaryLineForPacking.Locate('ProductID' , SalesLine.productID , []) then exit;
  QtytoBeshipped := ProductQtytoBeShipped(SalesLine.SaleID, SalesLine.productID, SalesLine.UnitOfMeasureID);
  if  QtytoBeshipped > salesline.QtyShipped then QtytoBeshipped :=salesline.QtyShipped;
  PicksalesQty(SalesLine,QtytoBeshipped);
end;
Procedure    TPickAssemEntry.PickQty(SalesLine: TSalesLine; Qtypicking:double;IgnoreUOM:Boolean; sPacknumber: String);
var
  QtytoBeshipped :double;
  fiSaleLineID:Integer;
  fiProductID:Integer;
begin
  if not SalesSummaryLineForPacking.Locate('ProductID' , SalesLine.productID , []) then exit;

  QtytoBeshipped := ProductQtytoBeShipped(SalesLine.SaleID, SalesLine.productID, SalesLine.UnitOfMeasureID);

  if (QtytoBeshipped <= 0 ) and IgnoreUOM then begin
    fiSaleLineID:=SalesLine.ID;
    try
      fiProductID :=SalesLine.ProductID;
      SalesLine.first;
      while SalesLine.Eof= false do begin
        if (fiProductID =SalesLine.ProductID) and (fiSaleLineID <> SalesLine.ID) then begin
          QtytoBeshipped := ProductQtytoBeShipped(SalesLine.SaleID, SalesLine.productID, SalesLine.UnitOfMeasureID);
          if QtytoBeshipped  >0 then break;
        end;
        SalesLine.Next;
      end;
    finally
      SalesLine.Locate(SalesLine.IdFieldname ,  fiSaleLineID , []);
    end;
  end;

  if QtytoBeshipped <= 0 then begin
    Resultstatus.Clear;
    Resultstatus.AddItem(False , rssError , 0,  'Quantity left to be picked is 0 for product '  + SalesLine.Productname, true );
    Exit;
  end;

  if  Qtypicking> QtytoBeshipped then begin
    Resultstatus.Clear;
    Resultstatus.AddItem(False , rssError , 0,  'Quantity left to be picked is ' + FloatToStrF(QtytoBeshipped , ffGeneral, 15,2) +' for product '  + SalesLine.Productname, true );
    Qtypicking :=QtytoBeshipped;
  end;
  PicksalesQty(SalesLine,Qtypicking,sPacknumber);
end;

Procedure TPickAssemEntry.PicksalesQty(SalesLine: TSalesLine; Qtypicking:double; sPacknumber: string);
begin
  if not SalesSummaryLineForPacking.Locate('ProductID' , SalesLine.productID , []) then exit;
  if Qtypicking <=0 then exit;
  if ((sPacknumber = '') and (not(Lines.locate('ProductID;UOMID;SaleID' , vararrayof([salesline.ProductID,salesline.UnitOfMeasureID,salesline.SaleID]),[])))) or
     ((sPacknumber<> '') and not(Lines.locate('ProductID;UOMID;SaleID;Packnumber' , vararrayof([SalesSummaryLineForPacking.ProductID,SalesSummaryLineForPacking.UOMID,SaleID,sPacknumber]),[])))  then begin
    Lines.New;
    Lines.ProductID     := salesline.productId;
    Lines.UOMID         := salesline.UnitOfMeasureID;
    Lines.Description   := salesline.ProductDescription;
    Lines.Qty           := 0;
    Lines.QtyMultiplier := SalesLine.UOMMultiplier;
  end;
  Lines.Qty           := Lines.Qty +Qtypicking;
  Lines.PostDB;
end;
procedure TPickAssemEntry.PickQtyFromSalesGroup(QtytoBeshipped:double; sPacknumber:String = '');
var
  s:STring;
  SalesObj :TSales;
  fiBackorderforProductInGroup:Integer;
begin
  fsPacknumber:=  sPacknumber;
  try
    if QtytoBeshipped =0 then exit;
    s:= getSalesIDsofgroup(SaleID, true);
    //if s = '' then exit;
    if s = '' then  s:= inttostr(SaleID);

    SalesObj := NewSaleObj;
    try
            SalesObj.LoadSelect('SaleId in (' + s +')');
            if SalesObj.Count =0 then exit;

            if (SalesObj.Count=1) and (SalesObj.Id = saleID) then begin
                    SalesObj.Silentmode := False;
                    Resultstatus.AddItem(False , rssWarning , 0,'Quantity left to be picked is 0 for this product.' +NL +NL+
                                                                'There is no Back Order to pick the Extra Quantity to be picked : ' +floattostrF(fdQtyToshipfromBO , ffGeneral , 15, 0)+'.' , true );
                    Exit;
            end else if Appenv.companyprefs.AllowToPickFromOthersalesIntheGroup = False then begin
                    SalesObj.Silentmode := False;
                    Resultstatus.AddItem(False , rssWarning , 0,  'In Preference you have disabled to ''Allow To Pick For Other Sales In the Group''.' +NL+NL+
                                      'Extra Quantity to be picked : ' +floattostrF(QtytoBeshipped , ffGeneral , 15, 0)+'.' +NL +NL+
                                      'It is not possible to Pick qty for Other ' + SalesObj.XMLNodename +'(s) in the group # ' + s +'.' , true );
                    Exit;
            end;


            fdQtyToshipfromBO:=QtytoBeshipped;
            SalesObj.IterateRecords(PickQtyFromSalesGroupCallback);

              if fdQtyToshipfromBO >0 then begin
                fiBackorderforProductInGroup:= SalesObj.BackorderforProductInGroup(SalesSummaryLineForPacking.ProductID) ;
                if fiBackorderforProductInGroup >0 then begin
                  if Appenv.companyprefs.AllowtoshipnPickFromBackorderinthegroup = False then begin
                    SalesObj.Silentmode := False;
                    Resultstatus.AddItem(False , rssWarning , 0,  'In Preference you have disabled to ''Allow to Ship and Pick for Backorder in the Group''.'+NL+NL+
                                    'Extra Quantity to be picked : ' +floattostrF(fdQtyToshipfromBO , ffGeneral , 15, 0)+'.' +NL +NL+
                                    'It is not possible to Pick qty for the backorder # ' + inttostr(fiBackorderforProductInGroup)+'.' , true );
                    Exit;
                  end;
                  SalesObj.Connection.BeginNestedTransaction;
                  try
                    SalesObj.Load(fiBackorderforProductInGroup);
                    if SalesObj.lines.Locate('ProductID',SalesSummaryLineForPacking.ProductID , [] ) then begin
                      if SalesObj.lines.Qtybackorder > fdQtyToshipfromBO then
                        SalesObj.lines.QtyShipped := SalesObj.lines.Qtybackorder
                      else SalesObj.lines.QtyShipped :=fdQtyToshipfromBO;
                      SalesObj.lines.PostDB;
                      if not SalesObj.Save then begin
                        SalesObj.Connection.rollbackNestedTransaction;
                      end else begin
                        SalesObj.Connection.CommitNestedTransaction;
                        SalesObj.IterateRecords(PickQtyFromSalesGroupCallback);
                      end;
                    end;
                  Except
                    on E:Exception do begin
                      SalesObj.Connection.rollbackNestedTransaction;
                    end;
                  end;
                end else begin
                    SalesObj.Silentmode := False;
                    Resultstatus.AddItem(False , rssWarning , 0,'There is no Back Order to pick the Extra Quantity to be picked : ' +floattostrF(fdQtyToshipfromBO , ffGeneral , 15, 0)+'.' , true );
                    Exit;
                end;
              end;
    finally
       SalesObj.silentmode := False;
       Freeandnil(SalesObj);
    end;
  finally
    fsPacknumber:= '';
  end;
end;
procedure TPickAssemEntry.PickQtyFromSalesGroupCallback(const Sender: TBusObj; var Abort: Boolean);
var
  QtytoBeshipped:Double;
begin
    if not (Sender is TSales) then exit;
    if fdQtyToshipfromBO <= 0 then begin
      Abort := True;
      exit;
    end;
     QtytoBeshipped := ProductQtytoBeShipped(TSales(Sender).ID,SalesSummaryLineForPacking.ProductID);
     if QtytoBeshipped <=0 then exit;
     if QtytoBeshipped > fdQtyToshipfromBO then QtytoBeshipped :=  fdQtyToshipfromBO;
     //if not(Lines.locate('ProductID;UOMID;SaleID' , vararrayof([SalesSummaryLineForPacking.ProductID,SalesSummaryLineForPacking.UOMID,Tsales(Sender).ID]),[])) then begin
     if ((fsPacknumber = '') and not(Lines.locate('ProductID;UOMID;SaleID' , vararrayof([SalesSummaryLineForPacking.ProductID,SalesSummaryLineForPacking.UOMID,Tsales(Sender).ID]),[]))) or
       ((fsPacknumber<> '') and not(Lines.locate('ProductID;UOMID;SaleID;Packnumber' , vararrayof([SalesSummaryLineForPacking.ProductID,SalesSummaryLineForPacking.UOMID,Tsales(Sender).ID,fsPacknumber]),[])))  then begin
      Lines.New;
      Lines.ProductID     := SalesSummaryLineForPacking.ProductID;
      Lines.UOMID         := SalesSummaryLineForPacking.UOMID;
      Lines.Description   := SalesSummaryLineForPacking.ProductDescription;
      Lines.Qty           := 0;
      Lines.SaleID        := TsaleS(Sender).ID;
      Lines.QtyMultiplier := SalesSummaryLineForPacking.UOMMultiplier;
    end;
    Lines.Qty             := Lines.Qty +QtytoBeshipped;
    Lines.PostDB;
    fdQtyToshipfromBO := fdQtyToshipfromBO -QtytoBeshipped;
    if fdQtyToshipfromBO <=0 then abort := TRue;
(*      PickAssyofOtherSalesinGroup:= TPickingAssembly.create(nil); // owner nil so that the same dataset will not be used;
      try
        PickAssyofOtherSalesinGroup.loadSelect(TSales(Sender).ID);
        if PickAssyofOtherSalesinGroup.count =0 then begin
        end;

      finally
        FreeandNil(PickAssyofOtherSalesinGroup);
      end;*)
end;
procedure TPickAssemEntry.PicksalesQty( PickBOQty:Boolean = False; sPacknumber:String = '');
var
  QtytoBeshipped :double;
begin
  QtytoBeshipped := ProductQtytoBeShipped(SaleID,SalesSummaryLineForPacking.ProductID);

  if QtytoBeshipped >0 then begin
    if SalesSummaryLineForPacking.productId =0 then exit;
    if ((sPacknumber = '') and not(Lines.locate('ProductID;UOMID;SaleID' , vararrayof([SalesSummaryLineForPacking.ProductID,SalesSummaryLineForPacking.UOMID,SaleID]),[]))) or
       ((sPacknumber<> '') and not(Lines.locate('ProductID;UOMID;SaleID;Packnumber' , vararrayof([SalesSummaryLineForPacking.ProductID,SalesSummaryLineForPacking.UOMID,SaleID,sPacknumber]),[])))  then begin
      Lines.New;
      Lines.ProductID     := SalesSummaryLineForPacking.productId;
      Lines.UOMID         := SalesSummaryLineForPacking.UOMID;
      Lines.Description   := SalesSummaryLineForPacking.ProductDescription;
      Lines.Qty           := 0;
      Lines.QtyMultiplier := SalesSummaryLineForPacking.UOMMultiplier;
    end;
    Lines.Qty           := Lines.Qty +QtytoBeshipped;
    Lines.PostDB;
  end;


  if PickBOQty =False then exit;
  QtytoBeshipped :=SalesSummaryLineForPacking.QtyBackorder;
  if QtytoBeshipped<=0 then exit;
  PickQtyFromSalesGroup(QtytoBeshipped,sPacknumber);

end;
function TPickAssemEntry.InvoiceID(Const SOID:Integer):Integer;
begin
  With Getnewdataset('Select Inv.SaleID '+
                      ' from tblsales SO  '+
                      ' inner join tblsales Inv on Inv.SalesorderGlobalref = SO.globalref and INv.deleted ="F" and Inv.Cancelled ="F"  '+
                      ' where  SO.saleID = ' + inttostr(SOID), true) do try
    REsult := fieldbyname('SaleID').asInteger;
  finally
    if active then close;
    Free;
  end;
end;





constructor TPickAssemEntry.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CopyingSOPickingToInvoice := False;
  CopySOPickingToInvoiceFailed := False;
  fsPacknumber:='';
  fBusObjectTypeDescription:= 'pickingassemblyentry';
  fSQL := 'SELECT * FROM tblpickingassemblyentry';
  //fbSalesQtypicked := False;
  fdQtyToshipfromBO:=0;
  PickingSaleID := -1;
  SalesSummaryLineForPackingforGUITablename := GetUserTemporaryTableName('Picking');
end;

destructor TPickAssemEntry.Destroy;
begin
  DestroyUserTemporaryTable(SalesSummaryLineForPackingforGUITablename);
  inherited;
end;


procedure TPickAssemEntry.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SaleID');
  SetPropertyFromNode(node,'Barcode');
  SetPropertyFromNode(node,'SOPickingRef');
  SetPropertyFromNode(node,'PickingEmployeeID');
  SetBooleanPropertyFromNode(node,'StartPicking');
  SetDateTimePropertyFromNode(node,'StartPickingTime');
  SetBooleanPropertyFromNode(node,'FinishedPicking');
  SetDateTimePropertyFromNode(node,'FinishedPickingTime');
  SetPropertyFromNode(node,'PackingEmployeeID');
  SetBooleanPropertyFromNode(node,'StartPacking');
  SetDateTimePropertyFromNode(node,'StartPackingTime');
  SetBooleanPropertyFromNode(node,'FinishedPacking');
  SetBooleanPropertyFromNode(node,'Converted');
  SetDateTimePropertyFromNode(node,'FinishedPackingTime');
  SetDateTimePropertyFromNode(node,'CreatedOn');
end;


procedure TPickAssemEntry.LoadSalesSummaryLineForPacking;
var
s:String;
begin
  if PickingSaleID = SaleID then Exit;
  try
 s:= 'Drop table if exists ' + SalesSummaryLineForPackingforGUITablename +';'+NL+
              ' CREATE TABLE `' + SalesSummaryLineForPackingforGUITablename +'` ('+NL+
              '   `productId` int(11) DEFAULT 0,'+NL+
              '   `productname` varchar(60) DEFAULT NULL,'+NL+
              '   `ProductDescription` varchar(255) DEFAULT NULL,'+NL+
              '   `totalShipped` double DEFAULT NULL,'+NL+
              '   `ShippedinGroup` double DEFAULT NULL,'+NL+
              '   `SalesBOQty` double DEFAULT NULL,'+NL+
              '   `QtyPacked` double DEFAULT NULL,'+NL+
              '   `QtyPackedinGroup` double DEFAULT NULL,'+NL+
              '   `Qtybackorder` double DEFAULT NULL,'+NL+
              '   `UOM` varchar(255) DEFAULT NULL,'+NL+
              '   `UOMId` int(11) NOT NULL DEFAULT 0,'+NL+
              '   `UOMMultiplier` double NOT NULL DEFAULT 1'+NL+
              ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;' +NL+
              ' insert into ' + SalesSummaryLineForPackingforGUITablename +' (ProductID , ProductNAme , ProductDescription , totalShipped ,  UOM , UOMId , UOMMultiplier) '+NL+
                            ' Select productId, ProductName, Product_Description , Shipped , UnitofMeasureSaleLines , UnitOfMeasureID, UnitofMeasureMultiplier from tblsaleslines '+NL+
                            ' where saleID = ' + inttostr(SaleID) +';'+NL+
              ' Drop table if exists ' + SalesSummaryLineForPackingforGUITablename +'_1;'+NL+
              ' create table ' + SalesSummaryLineForPackingforGUITablename +'_1 '+NL+
                            ' Select  productId, sum(if(ifnull(S.BOID,"")="" , backorder , 0)) bo , sum(if(S.saleID<> ' + inttostr(SaleID) +',shipped,0)) as shipped '+NL+
                            ' from tblsaleslines SL inner join tblsales S on s.saleId = Sl.saleID '+NL+
                            ' where S.OriginalNo = (Select originalno from tblsales where saleID = ' + inttostr(SaleID) +') group by productID;'+NL+
              ' update ' + SalesSummaryLineForPackingforGUITablename +' T1 '+NL+
                            ' inner join ' + SalesSummaryLineForPackingforGUITablename +'_1 T2 on T1.productID = T2.productID set T1.SalesBOQty = T2.BO , T1.ShippedinGroup = T2.shipped;'+NL+
              ' Drop table if exists ' + SalesSummaryLineForPackingforGUITablename +'_1;'+NL+
              ' create table ' + SalesSummaryLineForPackingforGUITablename +'_1 '+NL+
                            ' Select PAE.ProductID ,  Sum(PAE.Qty) qty '+NL+
                            ' from tblpickingassembly PA inner join tblpickingassemblylines PAE on PA.PickingAssemblyID = PAE.PickingAssemblyID '+NL+
                            ' where PA.SaleID =   ' + inttostr(SaleID) +' group by ProductID;'+NL+
              ' update ' + SalesSummaryLineForPackingforGUITablename +' T1 inner join ' + SalesSummaryLineForPackingforGUITablename +'_1 T2 on T1.productID = T2.productID set T1.QtyPacked = T2.qty ;'+NL+
              ' Drop table if exists ' + SalesSummaryLineForPackingforGUITablename +'_1;'+NL+
              ' create table ' + SalesSummaryLineForPackingforGUITablename +'_1 '+NL+
                            ' Select PAE.ProductID ,  Sum(PAE.Qty) qty '+NL+
                            ' from tblpickingassembly PA inner join tblpickingassemblylines PAE on PA.PickingAssemblyID = PAE.PickingAssemblyID '+NL+
                            ' where PA.SaleID in (Select saleId from tblsales '+NL+
                            ' where Originalno = (Select originalno from tblsales where saleID = ' + inttostr(SaleID) +') and SaleID <>' + inttostr(SaleID) +') group by ProductID;'+NL+
              ' update ' + SalesSummaryLineForPackingforGUITablename +' T1 inner join ' + SalesSummaryLineForPackingforGUITablename +'_1 T2 on T1.productID = T2.productID set T1.QtyPackedinGroup = T2.qty ;'+NL+
              ' update ' + SalesSummaryLineForPackingforGUITablename +' set Qtybackorder = ifnull(ShippedinGroup,0) - ifnull(QtyPackedinGroup,0) +ifnull(SalesBOQty,0) ;'+NL+
              ' Drop table if exists ' + SalesSummaryLineForPackingforGUITablename +'_1;';
    ExecuteSQL(s , false);
    PickingSaleID := SaleID;
    SendEvent(BusobjEvent_ToDo,BusobjEvent_closeBarcodeSummary, self);
  Except
  end;
end;

function TPickAssemEntry.MaxLinePackNumber: integer;
begin
  fiPacknumber := 0;
  Lines.IterateRecords(MaxLinePackNumberCallback);
  result:= fiPacknumber;
end;
procedure TPickAssemEntry.MaxLinePackNumberCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TPickAssemEntryLines) then exit;
  if TPickAssemEntryLines(Sender).PackNumber >fiPacknumber then
    fiPacknumber:= TPickAssemEntryLines(Sender).PackNumber;
end;
procedure TPickAssemEntry.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SaleID' ,SaleID);
  AddXMLNode(node,'Barcode' ,Barcode);
  AddXMLNode(node,'SOPickingRef' ,SOPickingRef);
  AddXMLNode(node,'PickingEmployeeID' ,PickingEmployeeID);
  AddXMLNode(node,'StartPicking' ,StartPicking);
  AddXMLNode(node,'StartPickingTime' ,StartPickingTime);
  AddXMLNode(node,'FinishedPicking' ,FinishedPicking);
  AddXMLNode(node,'FinishedPickingTime' ,FinishedPickingTime);
  AddXMLNode(node,'PackingEmployeeID' ,PackingEmployeeID);
  AddXMLNode(node,'StartPacking' ,StartPacking);
  AddXMLNode(node,'StartPackingTime' ,StartPackingTime);
  AddXMLNode(node,'FinishedPacking' ,FinishedPacking);
  AddXMLNode(node,'FinishedPackingTime' ,FinishedPackingTime);
  AddXMLNode(node,'Converted' ,Converted);
  AddXMLNode(node,'CreatedOn' ,CreatedOn);
end;


function TPickAssemEntry.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if SaleID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'SaleID should not be 0' , true );
    Exit;
  end;
  if PickingEmployeeID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Employee not Logged in' , true );
    Exit;
  end;
  Result := True;
end;


function TPickAssemEntry.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
  if not result then exit;
  AllLinesValid := True;
  Lines.IterateRecords(Savecallback);
  REsult := AllLinesValid;
end;

procedure TPickAssemEntry.Savecallback(const Sender: TBusObj; var Abort: Boolean);
var
  PickAss : TPickingAssembly;
begin
  if not (sender is TPickAssemEntrylines) then exit;
  PickAss := TPickingAssembly.Create(Self);
  try
    PickAss.Connection := Self.Connection;
    PickAss.LoadSelect('SaleId = ' + inttostr(TPickAssemEntrylines(Sender).SaleID)+' and PickingAssemblyEntryID = ' + inttostr(ID));
    if PickAss.count =0 then begin
      PickAss.New;
      PickAss.SaleID := TPickAssemEntrylines(Sender).SaleId;
      PickAss.PostDB;
    end;
    PickAss.PickingEmployeeID := PickingEmployeeID;
    PickAss.PickingAssemblyEntryID := ID;
    PickAss.StartPicking      := StartPicking;
    PickAss.FinishedPicking   := FinishedPicking;
    PickAss.PackingEmployeeID := PackingEmployeeID;
    PickAss.StartPacking      := StartPacking;
    PickAss.FinishedPacking   := FinishedPacking;
    PickAss.DispatchingEmployeeID := DispatchingEmployeeID;
    PickAss.StartDispatch := StartDispatch;
    PickAss.StartDispatchTime := StartDispatchTime;
    PickAss.FinishedDispatch := FinishedDispatch;
    PickAss.FinishedDispatchTime := FinishedDispatchTime;
    if PickAss.StartPickingTime     = 0 then PickAss.StartPickingTime     := StartPickingTime;
    if PickAss.FinishedPickingTime  = 0 then PickAss.FinishedPickingTime  := FinishedPickingTime;
    if PickAss.StartPackingTime     = 0 then PickAss.StartPackingTime     := StartPackingTime;
    if PickAss.FinishedPackingTime  = 0 then PickAss.FinishedPackingTime  := FinishedPackingTime;
    PickAss.PostDB;

    if PickAss.Lines.count >0  then begin
      PickAss.Lines.First;
      While PickAss.Lines.Eof = False do begin
        if PickAss.Lines.PickingAssemblyentrylinesID =  TPickAssemEntrylines(Sender).ID then PickAss.Lines.Delete
        else PickAss.Lines.Next;
      end;
    end;

    PickAss.Lines.New;
    PickAss.Lines.PickingAssemblyentrylinesID := TPickAssemEntrylines(Sender).ID;
    PickAss.Lines.ProductID           := TPickAssemEntrylines(Sender).ProductID;
    PickAss.Lines.ProductName         := TPickAssemEntrylines(Sender).ProductName;
    PickAss.Lines.Description         := TPickAssemEntrylines(Sender).Description;
    PickAss.Lines.Qty                 := TPickAssemEntrylines(Sender).Qty;
    PickAss.Lines.QtyMultiplier       := TPickAssemEntrylines(Sender).QtyMultiplier;
    PickAss.Lines.UOM                 := TPickAssemEntrylines(Sender).UOM;
    PickAss.Lines.UOMID               := TPickAssemEntrylines(Sender).UOMID;
    PickAss.Lines.PackNumber          := TPickAssemEntrylines(Sender).PackNumber;
    PickAss.Lines.PostDB;
  finally
    FreeandNil(PickAss);
  end;
end;
procedure TPickAssemEntry.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  //SalesQtypicked := False;
  fdQtyToshipfromBO:=0;
  if getContainerComponentifExists(TSalesSummaryLineForPackingforGUI) <> nil then
      TSalesSummaryLineForPackingforGUI(getContainerComponentifExists(TSalesSummaryLineForPackingforGUI)).Closedb;
end;

procedure TPickAssemEntry.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TPickAssemEntry.FlagAsDispatched(aPackNo: integer): boolean;
var
  bm: TBookmark;
begin
  result := false;
  Lines.Dataset.DisableControls;
  try
    bm := Lines.Dataset.GetBookmark;
    try
      Lines.First;
      while not Lines.EOF do begin
        if Lines.PackNumber = aPackNo then begin
          Lines.Dispatched := true;
          result := true;
        end;
        Lines.Next;
      end;
      Lines.Dataset.GotoBookmark(bm);
    finally
      Lines.Dataset.FreeBookmark(bm);
    end;
  finally
    Lines.Dataset.EnableControls;
  end;
end;

function TPickAssemEntry.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

function TPickAssemEntry.GetStartDispatch: Boolean;
begin
  result := GetBooleanField('StartDispatch');
end;

class function TPickAssemEntry.GetIDField: string;
begin
  Result := 'PickingAssemblyEntryID'
end;


function TPickAssemEntry.getLines: TPickAssemEntrylines;
begin
  Result:= TPickAssemEntrylines(getContainerComponent(TPickAssemEntrylines, 'PickingAssemblyEntryID = '+ IntToStr(Self.Id)));
end;

class function TPickAssemEntry.GetBusObjectTablename: string;
begin
  Result:= 'tblpickingassemblyentry';
end;


function TPickAssemEntry.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not (result) then exit;
  CreatedOn := now;
end;

function TPickAssemEntry.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not(result) then exit;
end;


function TPickAssemEntry.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeDelete(Sender);
  if not(result) then exit;
  result:= Lines.DeleteAll;
  if not result then exit;
  result := PickingAssemblies.DeleteAll;
end;

{Property Functions}
function TPickAssemEntry.GetSale: TSales;
var
  SaleType: TSaleType;
begin
  result:= nil;
  if self.SaleID < 1 then exit;
  SaleType:= TSales.GetSaleType(SaleId);
  if SaleType = stSalesOrder then  Result:= Tsales(getContainerComponent(TsalesOrder, 'SaleID = '+ IntToStr(Self.SaleId)))
  else Result:= Tsales(getContainerComponent(TInvoice, 'SaleID = '+ IntToStr(Self.SaleId)));
end;
function TPickAssemEntry.NewSaleObj: TSales;
var
  SaleType: TSaleType;
begin
  SaleType:= TSales.GetSaleType(SaleId);
  if SaleType = stSalesOrder then  Result:= TsalesOrder.Create(Self)
  else Result:= TInvoice.Create(Self);
  REsult.Connection := self.Connection;
  result.silentmode := True;
end;
function  TPickAssemEntry.GetSaleID                : Integer   ; begin Result := GetIntegerField('SaleID');end;
function TPickAssemEntry.getSalesPickingAssembly: TPickingAssembly;
begin
  Result:= TPickingAssembly(getContainerComponent(TPickingAssembly, 'saleID = '+ IntToStr(Self.saleId)));
end;

function TPickAssemEntry.getSalesSummaryLineForPacking: TSalesSummaryLineForPackingforGUI;
begin
  LoadSalesSummaryLineForPacking;
  Result:= TSalesSummaryLineForPackingforGUI(getContainerComponent(TSalesSummaryLineForPackingforGUI, (*'s.saleID = '+ IntToStr(Self.saleId)*)''));
end;

function  TPickAssemEntry.GetBarcode               : string    ; begin Result := GetStringField('Barcode');end;
function  TPickAssemEntry.GetSOPickingRef          : string    ; begin Result := GetStringField('SOPickingRef');end;
function  TPickAssemEntry.GetPickingEmployeeID     : Integer   ; begin Result := GetIntegerField('PickingEmployeeID');end;
function  TPickAssemEntry.GetStartPicking          : Boolean   ; begin Result := GetBooleanField('StartPicking');end;
function  TPickAssemEntry.GetStartPickingTime      : TDateTime ; begin Result := GetDateTimeField('StartPickingTime');end;
function  TPickAssemEntry.GetFinishedPicking       : Boolean   ; begin Result := GetBooleanField('FinishedPicking');end;
function  TPickAssemEntry.GetFinishedPickingTime   : TDateTime ; begin Result := GetDateTimeField('FinishedPickingTime');end;
function  TPickAssemEntry.GetPackingEmployeeID     : Integer   ; begin Result := GetIntegerField('PackingEmployeeID');end;

function TPickAssemEntry.GetStartDispatchTime: TDateTime;
begin
  result := GetDateTimeField('StartDispatchTime');
end;

function  TPickAssemEntry.GetStartPacking          : Boolean   ; begin Result := GetBooleanField('StartPacking');end;
function  TPickAssemEntry.GetStartPackingTime      : TDateTime ; begin Result := GetDateTimeField('StartPackingTime');end;
function TPickAssemEntry.GetFinishedDispatch: Boolean;
begin
  result := GetBooleanField('FinishedDispatch');
end;

function TPickAssemEntry.GetFinishedDispatchTime: TDateTime;
begin
  result := GetDateTimeField('FinishedDispatchTime');
end;

function  TPickAssemEntry.GetFinishedPacking       : Boolean   ; begin Result := GetBooleanField('FinishedPacking');end;
function  TPickAssemEntry.GetConverted             : Boolean   ; begin Result := GetBooleanField('Converted');end;
function  TPickAssemEntry.GetFinishedPackingTime   : TDateTime ; begin Result := GetDateTimeField('FinishedPackingTime');end;
function  TPickAssemEntry.GetCreatedOn             : TDateTime ; begin Result := GetDateTimeField('CreatedOn');end;
function TPickAssemEntry.GetDispatchingEmployeeID: Integer;
begin
  result := GetIntegerField('DispatchingEmployeeID');
end;

procedure TPickAssemEntry.SetSaleID                (const Value: Integer   ); begin SetIntegerField('SaleID'                 , Value);end;
procedure TPickAssemEntry.SetBarcode               (const Value: string    ); begin SetStringField('Barcode'                , Value);end;
procedure TPickAssemEntry.SetSOPickingRef          (const Value: string    ); begin SetStringField('SOPickingRef'           , Value);end;
procedure TPickAssemEntry.SetPickingEmployeeID     (const Value: Integer   ); begin SetIntegerField('PickingEmployeeID'      , Value);end;
procedure TPickAssemEntry.SetStartPicking          (const Value: Boolean   ); begin SetBooleanField('StartPicking'           , Value);end;
procedure TPickAssemEntry.SetStartPickingTime      (const Value: TDateTime ); begin SetDateTimeField('StartPickingTime'       , Value);end;
procedure TPickAssemEntry.SetFinishedPicking       (const Value: Boolean   ); begin SetBooleanField('FinishedPicking'        , Value);end;
procedure TPickAssemEntry.SetFinishedPickingTime   (const Value: TDateTime ); begin SetDateTimeField('FinishedPickingTime'    , Value);end;
procedure TPickAssemEntry.SetPackingEmployeeID     (const Value: Integer   ); begin SetIntegerField('PackingEmployeeID'      , Value);end;
procedure TPickAssemEntry.SetStartDispatch(const Value: Boolean);
begin
  SetBooleanField('StartDispatch',Value);
end;

procedure TPickAssemEntry.SetStartDispatchTime(const Value: TDateTime);
begin
  SetDateTimeField('StartDispatchTime',Value);
end;

procedure TPickAssemEntry.SetStartPacking          (const Value: Boolean   ); begin SetBooleanField('StartPacking'           , Value);end;
procedure TPickAssemEntry.SetStartPackingTime      (const Value: TDateTime ); begin SetDateTimeField('StartPackingTime'       , Value);end;
procedure TPickAssemEntry.SetFinishedDispatch(const Value: Boolean);
begin
  SetBooleanField('FinishedDispatch',Value);
end;

procedure TPickAssemEntry.SetFinishedDispatchTime(const Value: TDateTime);
begin
  SetDateTimeField('FinishedDispatchTime',Value);
end;

procedure TPickAssemEntry.SetFinishedPacking       (const Value: Boolean   ); begin SetBooleanField('FinishedPacking'        , Value);end;
procedure TPickAssemEntry.SetFinishedPackingTime   (const Value: TDateTime ); begin SetDateTimeField('FinishedPackingTime'    , Value);end;
procedure TPickAssemEntry.SetConverted             (const Value: Boolean   ); begin SetBooleanField('Converted'        , Value);end;
procedure TPickAssemEntry.SetCreatedOn             (const Value: TDateTime ); begin SetDateTimeField('CreatedOn'    , Value);end;
procedure TPickAssemEntry.SetDispatchingEmployeeID(const Value: Integer);
begin
  SetIntegerField('DispatchingEmployeeID', Value);
end;

function TPickAssemEntry.getPickingAssemblies: TPickingAssemblies;
begin
  Result:= TPickingAssemblies(getContainerComponent(TPickingAssemblies, 'PickingAssemblyEntryID = '+ IntToStr(Id)));
end;

function TPickAssemEntry.GetStatusText: string;
begin
  if self.FinishedDispatch then
    result:= 'Dispatch Finished'
  else if self.StartDispatch then
    result:= 'Dispatch Started'
  else if self.FinishedPacking then
    result:= 'Packing Finished'
  else if self.StartPacking then
    result:= 'Packing Started'
  else if self.FinishedPicking then
    result:= 'Picking Finished'
  else if self.StartPicking then
    result:= 'Picking Started'
  else
    result:= 'Not Started';
end;

function TPickAssemEntry.HasAnytopick(checkBOs:Boolean =False): Boolean;
begin
  AllLinesValid := False;
  SalesSummaryLineForPacking.IterateRecords(HasAnytopickCallback);
  Result := AllLinesValid;
  if result then exit;
  if not checkBOs then exit;
  AllLinesValid := False;
  SalesSummaryLineForPacking.IterateRecords(HasAnytopickinBOCallback);
  Result := AllLinesValid;


end;
procedure TPickAssemEntry.HasAnytopickCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is   TSalesSummaryLineForPackingforGUI) then exit;
  if TSalesSummaryLineForPackingforGUI(Sender).QtyRequired <> 0 then begin
     AllLinesValid := True;
     Abort :=  true;
  end;
end;
procedure TPickAssemEntry.HasAnytopickinBOCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is   TSalesSummaryLineForPackingforGUI) then exit;
  if (TSalesSummaryLineForPackingforGUI(Sender).QtyBackorder <> 0) and
    (TSalesSummaryLineForPackingforGUI(Sender).QtyBackorder + TSalesSummaryLineForPackingforGUI(Sender).totalshipped - TSalesSummaryLineForPackingforGUI(Sender).QtyPacked<> 0) then begin
     AllLinesValid := True;
     Abort :=  true;
  end;
end;

  {TPickAssemEntrylines}


(*function TPickAssemEntrylines.CopyingSOPickingToInvoice: Boolean;
begin
  REsult := False;
  if Assigned(Owner) then
    if owner is TPickAssemEntry then
      result := TPickAssemEntry(Owner).CopyingSOPickingToInvoice;
end;*)

constructor TPickAssemEntrylines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'pickingassemblyentrylines';
  fSQL := 'SELECT * FROM tblpickingassemblyentrylines';
  fSQLOrder := 'ProductId,SaleID';
end;


procedure TPickAssemEntrylines.CreateInstance;
begin
  If Owner Is TPickAssemEntry Then
    If Assigned(TPickAssemEntry(Owner).ObjInstanceToClone) Then
      if TPickAssemEntry(Owner).ObjInstanceToClone is TPickAssemEntry then
        ObjInstanceToClone    := TPickAssemEntry(TPickAssemEntry(Owner).ObjInstanceToClone).Lines;
end;

destructor TPickAssemEntrylines.Destroy;
begin
  inherited;
end;


procedure TPickAssemEntrylines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PickingAssemblyEntryID');
  SetPropertyFromNode(node,'ProductID');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'SOPickingRef');
  SetPropertyFromNode(node,'Qty');
  SetPropertyFromNode(node,'QtyMultiplier');
  SetPropertyFromNode(node,'UOM');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'SaleID');
  SetPropertyFromNode(node,'PackNumber');
end;


procedure TPickAssemEntrylines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PickingAssemblyEntryID' ,PickingAssemblyEntryID);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'SOPickingRef' ,SOPickingRef);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'QtyMultiplier' ,QtyMultiplier);
  AddXMLNode(node,'UOM' ,UOM);
  AddXMLNode(node,'UOMID' ,UOMID);
  AddXMLNode(node,'SaleID' ,SaleID);
  AddXMLNode(node,'PackNumber' ,PackNumber);
end;


function TPickAssemEntrylines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if ProductID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Product not selected' , true );
    Exit;
  end;
  if Qty = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Qty should not be 0' , true );
    Exit;
  end;
  if UOMID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'UOM not selected' , true );
    Exit;
  end;
  Result := True;
end;


function TPickAssemEntrylines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPickAssemEntrylines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TPickAssemEntrylines.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sametext(Sender.fieldname , 'ProductID') then begin
    Productname := tcdatautils.getProduct(ProductID);
  end else if Sametext(Sender.fieldname , 'ProductName') then begin
    ProductID := tcdatautils.getProduct(ProductName);
  end else if Sametext(Sender.fieldname , 'UOMID') then begin
    UOM := GetUOMName(UOMID);
    QtyMultiplier := getUnitMultiplier(UOMID);
  end else if Sametext(Sender.fieldname , 'UOM') then begin
    UOMID := GetUnitOfMeasureID(UOM, ProductID);
    DoFieldOnChange(dataset.FindField('UOMID'));
  end;
end;



function TPickAssemEntrylines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TPickAssemEntrylines.GetIDField: string;
begin
  Result := 'PickingAssemblyentrylinesID'
end;


class function TPickAssemEntrylines.GetBusObjectTablename: string;
begin
  Result:= 'tblpickingassemblyentrylines';
end;


function TPickAssemEntrylines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not(result) then exit;
  if Assigned(Owner) then
    if owner is TPickAssemEntry then begin
      PickingAssemblyEntryID := TPickAssemEntry(Owner).ID;
      SaleID := TPickAssemEntry(Owner).SaleID;
      //TPickAssemEntry(Owner).SalesQtypicked := true;
    end;
  PackNumber := fiPackNumber;
  if PackNumber =0 then PackNumber := 1;
  fiPackNumber:= 0;
end;

function TPickAssemEntrylines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  (*if Assigned(Owner) then
    if owner is TPickAssemEntry then
      TPickAssemEntry(Owner).SalesQtypicked := true;*)
end;


function TPickAssemEntrylines.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforeInsert(Sender);
  if not Result then exit;

  fiPacknumber:= 0;
  if assigned(Owner) then
    if owner is TPickAssemEntry then
      fiPacknumber := TPickAssemEntry(Owner).MaxLinePackNumber;
  if fiPackNumber = 0 then fiPacknumber:= 1;
end;

{Property Functions}
function  TPickAssemEntrylines.GetPickingAssemblyEntryID     : Integer   ; begin Result := GetIntegerField('PickingAssemblyEntryID');end;
function  TPickAssemEntrylines.GetProductID                  : Integer   ; begin Result := GetIntegerField('ProductID');end;
function  TPickAssemEntrylines.GetProductName                : string    ; begin Result := GetStringField('ProductName');end;
function  TPickAssemEntrylines.GetDescription                : string    ; begin Result := GetStringField('Description');end;
function TPickAssemEntrylines.GetDispatched: boolean;
begin
  result := GetBooleanField('Dispatched');
end;

function  TPickAssemEntrylines.GetSOPickingRef               : string    ; begin Result := GetStringField('SOPickingRef');end;
function  TPickAssemEntrylines.GetQty                        : Double    ; begin Result := GetFloatField('Qty');end;
function  TPickAssemEntrylines.GetQtyMultiplier              : Double    ; begin Result := GetFloatField('QtyMultiplier');end;
function  TPickAssemEntrylines.GetUOM                        : string    ; begin Result := GetStringField('UOM');end;
function  TPickAssemEntrylines.GetUOMID                      : Integer   ; begin Result := GetIntegerField('UOMID');end;
function TPickAssemEntrylines.isSaleEditable: Boolean;
begin
  REsult := TRue;
 if Sale.IsInvoice then begin
    if (Sale.TotalPaid <> 0) or (Sale.IsPaid) then begin
      Resultstatus.AddItem(False , rssError , 0,  'Can not update invoice as payments have been made');
      result:= false;
      exit;
    end else if (Sale.SaleDate <= AppEnv.CompanyPrefs.ClosingDateAR) then begin
      Resultstatus.AddItem(False , rssError , 0,  'Can not update invoice as period has been closed');
      result:= false;
      exit;
    end;
  end;
end;

function TPickAssemEntrylines.GetSale: TSales;
var
  SaleType: TSaleType;
begin
  result:= nil;
  if self.SaleID < 1 then exit;
  SaleType:= TSales.GetSaleType(SaleId);
  if SaleType = stSalesOrder then  Result:= Tsales(getContainerComponent(TsalesOrder, 'SaleID = '+ IntToStr(Self.SaleId)))
  else Result:= Tsales(getContainerComponent(TInvoice, 'SaleID = '+ IntToStr(Self.SaleId)));
end;

function  TPickAssemEntrylines.GetSaleID                     : Integer   ; begin Result := GetIntegerField('SaleID');end;
function  TPickAssemEntrylines.GetPackNumber                 : Integer   ; begin Result := GetIntegerField('PackNumber');end;
procedure TPickAssemEntrylines.SetPickingAssemblyEntryID     (const Value: Integer   ); begin SetIntegerField('PickingAssemblyEntryID'      , Value);end;
procedure TPickAssemEntrylines.SetProductID                  (const Value: Integer   ); begin SetIntegerField('ProductID'                   , Value);end;
procedure TPickAssemEntrylines.SetProductName                (const Value: string    ); begin SetStringField('ProductName'                 , Value);end;
procedure TPickAssemEntrylines.SetDescription                (const Value: string    ); begin SetStringField('Description'                 , Value);end;
procedure TPickAssemEntrylines.SetDispatched(const Value: boolean);
begin
  SetBooleanField('Dispatched', Value);
end;

procedure TPickAssemEntrylines.SetSOPickingRef               (const Value: string    ); begin SetStringField('SOPickingRef'                 , Value);end;
procedure TPickAssemEntrylines.SetQty                        (const Value: Double    ); begin SetFloatField('Qty'                         , Value);end;
procedure TPickAssemEntrylines.SetQtyMultiplier              (const Value: Double    ); begin SetFloatField('QtyMultiplier'               , Value);end;
procedure TPickAssemEntrylines.SetUOM                        (const Value: string    ); begin SetStringField('UOM'                         , Value);end;
procedure TPickAssemEntrylines.SetUOMID                      (const Value: Integer   ); begin SetIntegerField('UOMID'                       , Value);end;
procedure TPickAssemEntrylines.SetSaleID                     (const Value: Integer   ); begin SetIntegerField('SaleID'                       , Value);end;
procedure TPickAssemEntrylines.SetPackNumber                 (const Value: Integer   ); begin SetIntegerField('PackNumber'                  , Value);end;


  {TPickingAssemblyLines}

function TPickingAssemblyLine.Entrylineref: String;
begin
  REsult := '';
  If Assigned(Owner) and (Owner is TPickingAssemblies) then
    if assigned(TPickingAssemblies(Owner).Owner) and (TPickingAssemblies(Owner).Owner is TPickAssemEntry) then
      if TPickAssemEntry(TPickingAssemblies(Owner).Owner).Lines.Locate('PickingAssemblyentrylinesID' , PickingAssemblyentrylinesID, []) then
        REsult := TPickAssemEntry(TPickingAssemblies(Owner).Owner).Lines.Globalref;
end;

constructor TPickingAssemblyLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'PickingAssemblyLine';
  fSQL := 'SELECT * FROM tblpickingassemblylines';
end;


procedure TPickingAssemblyLine.CreateInstance;
begin
  inherited;
  If Owner Is TPickingAssembly Then
    If Assigned(TPickingAssembly(Owner).ObjInstanceToClone) Then
      if TPickingAssembly(Owner).ObjInstanceToClone is TPickingAssembly then
        ObjInstanceToClone    := TPickingAssembly(TPickingAssembly(Owner).ObjInstanceToClone).Lines;

end;

destructor TPickingAssemblyLine.Destroy;
begin
  inherited;
end;


procedure TPickingAssemblyLine.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PickingAssemblyID');
  SetPropertyFromNode(node,'PickingAssemblyentrylinesID');
  SetPropertyFromNode(node,'ProductID');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'SOPickingRef');
  SetPropertyFromNode(node,'Qty');
  SetPropertyFromNode(node,'UOM');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'PackNumber');
end;


procedure TPickingAssemblyLine.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PickingAssemblyID' ,PickingAssemblyID);
  AddXMLNode(node,'PickingAssemblyentrylinesID' ,PickingAssemblyentrylinesID);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'SOPickingRef' ,SOPickingRef);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'UOM' ,UOM);
  AddXMLNode(node,'UOMID' ,UOMID);
  AddXMLNode(node,'PackNumber' ,PackNumber);
end;


function TPickingAssemblyLine.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if PickingAssemblyID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PickingAssemblyID should not be 0' , True);
    Exit;
  end;
  if ProductID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Product not selected' , True);
    Exit;
  end;
  if Qty = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Qty should not be 0' , True);
    Exit;
  end;
  if UOMID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'UOM not selected' , True);
    Exit;
  end;
  if UOM = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'UOM not selected' , True);
    Exit;
  end;
  if PackNumber = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PackNumber not selected' , True);
    Exit;
  end;
  Result := True;
end;


function TPickingAssemblyLine.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPickingAssemblyLine.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TPickingAssemblyLine.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  if Sysutils.SameText(Sender.FieldName , 'ProductID') then begin
    ProductName:= TProduct.IDToggle(Sender.AsInteger, self.Connection.Connection);
    Description:= GetProductDescription(ProductId);
  end
  else if Sysutils.SameText(Sender.FieldName , 'ProductName') then begin
    ProductId:= TProduct.IDToggle(Sender.AsString, self.Connection.Connection);
    Description:= GetProductDescription(ProductId);
  end
  else if Sysutils.SameText(Sender.FieldName , 'UOMID') then begin
    if ProductId > 0 then begin
      if Product.UOMList.LocateByID(sender.AsInteger) then begin
        UOM:= Product.UOMList.UOMName;
        QtyMultiplier:= Product.UOMList.Multiplier;
      end;
    end;
  end
  else if Sysutils.SameText(Sender.FieldName , 'UOM') then begin
    if ProductId > 0 then begin
      if Product.UOMList.LocateByName(Sender.AsString) then begin
        UOMID:= Product.UOMList.UnitId;
        QtyMultiplier:= Product.UOMList.Multiplier;
      end
      else begin
        UOMID:= 0;
        QtyMultiplier:= 1;
      end;
    end
    else begin
      UOMID:= 0;
      QtyMultiplier:= 1;
    end;
  end;
end;


function TPickingAssemblyLine.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TPickingAssemblyLine.GetIDField: string;
begin
  Result := 'PickingAssemblylinesID'
end;


class function TPickingAssemblyLine.GetBusObjectTablename: string;
begin
  Result:= 'tblpickingassemblylines';
end;


function TPickingAssemblyLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not(result) then exit;
  if assigned(Owner) then
    if owner is TPickingAssembly then
      PickingAssemblyID := TPickingAssembly(Owner).ID;
end;

function TPickingAssemblyLine.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TPickingAssemblyLine.GetPickingAssemblyID     : Integer   ; begin Result := GetIntegerField('PickingAssemblyID');end;
function  TPickingAssemblyLine.GetPickingAssemblyentrylinesID     : Integer   ; begin Result := GetIntegerField('PickingAssemblyentrylinesID');end;
function  TPickingAssemblyLine.GetProductID             : Integer   ; begin Result := GetIntegerField('ProductID');end;
function  TPickingAssemblyLine.GetProductName           : string    ; begin Result := GetStringField('ProductName');end;
function  TPickingAssemblyLine.GetDescription           : string    ; begin Result := GetStringField('Description');end;
function TPickingAssemblyLine.GetDispatched: boolean;
begin
  result := GetBooleanField('Dispatched');
end;

function  TPickingAssemblyLine.GetSOPickingRef          : string    ; begin Result := GetStringField('SOPickingRef');end;
function  TPickingAssemblyLine.GetQty                   : double    ; begin Result := GetFloatField('Qty');end;
function  TPickingAssemblyLine.GetQtyMultiplier         : double    ; begin Result := GetFloatField('QtyMultiplier');end;
function  TPickingAssemblyLine.GetUOM                   : string    ; begin Result := GetStringField('UOM');end;
function  TPickingAssemblyLine.GetUOMID                 : Integer   ; begin Result := GetIntegerField('UOMID');end;
function  TPickingAssemblyLine.GetPackNumber            : Integer   ; begin Result := GetIntegerField('PackNumber');end;
procedure TPickingAssemblyLine.SetPickingAssemblyID     (const Value: Integer   ); begin SetIntegerField('PickingAssemblyID'      , Value);end;
procedure TPickingAssemblyLine.SetPickingAssemblyentrylinesID     (const Value: Integer   ); begin SetIntegerField('PickingAssemblyentrylinesID'      , Value);end;
procedure TPickingAssemblyLine.SetProductID             (const Value: Integer   ); begin SetIntegerField('ProductID'              , Value);end;
procedure TPickingAssemblyLine.SetProductName           (const Value: string    ); begin SetStringField('ProductName'            , Value);end;
procedure TPickingAssemblyLine.SetDescription           (const Value: string    ); begin SetStringField('Description'            , Value);end;
procedure TPickingAssemblyLine.SetDispatched(const Value: boolean);
begin
  SetBooleanField('Dispatched', Value);
end;

procedure TPickingAssemblyLine.SetSOPickingRef          (const Value: string    ); begin SetStringField('SOPickingRef'           , Value);end;
procedure TPickingAssemblyLine.SetQty                   (const Value: double    ); begin SetFloatField('Qty'                    , Value);end;
procedure TPickingAssemblyLine.SetQtyMultiplier         (const Value: double    ); begin SetFloatField('QtyMultiplier'            , Value);end;
procedure TPickingAssemblyLine.SetUOM                   (const Value: string    ); begin SetStringField('UOM'                    , Value);end;
procedure TPickingAssemblyLine.SetUOMID                 (const Value: Integer   ); begin SetIntegerField('UOMID'                  , Value);end;
procedure TPickingAssemblyLine.SetPackNumber            (const Value: Integer   ); begin SetIntegerField('PackNumber'             , Value);end;


function TPickingAssemblyLine.GetProduct: TProduct;
begin
  if self.ProductID > 0 then begin
    //Result:= TProduct(getContainerComponent(TProduct, 'PartsID = ' +inttostr(ProductID)));
    Result := TProduct(getContainerComponent(TProduct, ProductID,'PartsID' ));
    if result.Id <> self.ProductID then
      result.Load(ProductID);
  end
  else begin
    result:= nil;
  end;
end;

procedure TPickingAssemblyLine.New;
begin
  inherited;
  if Assigned(Owner) and (Owner is TPickingAssembly) then
    PickingAssemblyID:= TPickingAssembly(Owner).Id;
end;

  {TSalesSummaryLineForPackingforGUI}

constructor TSalesSummaryLineForPackingforGUI.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fiPickingAssemblyEntryID:= 0;
  fBusObjectTypeDescription:= 'SalesSummaryLineForPacking';
(*  fSQL := 'Select SL.productId , SL.productname , Product_Description as ProductDescription ,' +
            ' sum(Shipped) as Totalshipped,' +
            ' sum(if(ifnull(shipped,0)=0 , BackOrder,0))  as QtyBackorder,' +
            ' (Select Sum(Qty) from tblpickingassemblylines PAL where PA.PickingAssemblyID = PAL.PickingAssemblyID and PAL.ProductID = SL.productID)  as QtyPacked,' +
            ' UnitofMeasureSaleLines as UOM,' +
            ' UnitOfMeasureID as UOMId,' +
            ' UnitofMeasureMultiplier UOMMultiplier,' +
            ' PA.FinishedPacking as Done' +
            ' From tblsales S' +
            ' inner join tblsalesLines SL on S.saleId = SL.saleID' +
            ' Left join tblpickingassembly PA on PA.SaleID = S.saleID' ;*)
  (*fSQL:= 'Select SL.productId , SL.productname , Product_Description as ProductDescription ,' +
            ' sum(Shipped) as Totalshipped,' +
            {' sum(if(ifnull(shipped,0)=0 , BackOrder,0))  as QtyBackorder,' +}
            ' (Select  sum(SLBO.shipped + if(ifnull(SBO.BOID,"")="" , backorder , 0) ) -' +
                    ' sum(ifnull((Select Sum(Qty) from tblpickingassemblylines PAL  ' +
                                            ' inner join tblpickingassembly PA on PA.PickingAssemblyID = PAL.PickingAssemblyID    ' +
                                            ' where PA.SaleID = sBO.saleid and PA.PickingAssemblyEntryID <> :PickingAssemblyEntryID   ' +
                                            ' and  PA.PickingAssemblyID = PAL.PickingAssemblyID   and PAL.ProductID = SLBO.productID )  ,0) )  ' +
                    ' from tblsales SBO  ' +
                    ' inner join tblsaleslines SLBO on SBO.saleID = SLBO.saleId  ' +
                    ' where SLBO.ProductID = SL.productId  ' +
                    ' and SLBO.SeqNo = SL.seqno  ' +
                    ' and  SBO.saleID <> S.saleId  ' +
                    ' and SBO.Originalno = S.originalno)  as QtyBackorder, ' +
            ' (Select Sum(Qty) from tblpickingassemblylines PAL ' +
                    ' inner join tblpickingassembly PA on PA.PickingAssemblyID = PAL.PickingAssemblyID  ' +
                    ' where PA.SaleID = s.saleid and PA.PickingAssemblyEntryID <> :PickingAssemblyEntryID  ' +
                    ' and  PA.PickingAssemblyID = PAL.PickingAssemblyID  ' +
                    ' and PAL.ProductID = SL.productID )  as QtyPacked,' +
            ' UnitofMeasureSaleLines as UOM,' +
            ' UnitOfMeasureID as UOMId,' +
            ' UnitofMeasureMultiplier UOMMultiplier/*,' +
            ' SPA.FinishedPacking   as Done*/' +
            ' From tblsales S' +
            ' inner join tblsalesLines SL on S.saleId = SL.saleID' +
            ' /*Left join tblpickingassembly SPA on SPA.SaleID = S.saleID*/ ';
  fSQLGroup:= 'Sl.productID';
  fSQLOrder := 'SortId';*)
end;


destructor TSalesSummaryLineForPackingforGUI.Destroy;
begin
  inherited;
end;



(*procedure TSalesSummaryLineForPackingforGUI.Load(const aId: integer; const fIsReadonly: boolean);
begin
//  inheritd Load(aid,  fIsReadonly);
// this is not a proper busobj, but a temp readonly obj based on a dataset
  fSQLSelect :=  'S.SAleID = ' + IntToStr(aid);
  Load(fIsReadonly);
end;*)

(*procedure TSalesSummaryLineForPackingforGUI.Load(const fIsReadonly: boolean);
begin
//  inherited;
// this is not a proper busobj, but a temp readonly obj based on a dataset
  try
    inherited Load(fIsReadonly);
  Except
    on E:Exception do begin
        SendEvent(BusObjEvent_Error,E.message +NL+ self.classname +' is not a proper busobj, but a temp readonly obj based on a dataset, Please check the SQL' +NL +SQL, self);
    end;
  end;
end;*)

procedure TSalesSummaryLineForPackingforGUI.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'productId');
  SetPropertyFromNode(node,'productname');
  SetPropertyFromNode(node,'ProductDescription');
  SetPropertyFromNode(node,'QtyRequired');
  SetPropertyFromNode(node,'Totalshipped');
  SetPropertyFromNode(node,'QtyBackorder');
  SetPropertyFromNode(node,'QtyPacked');
  SetPropertyFromNode(node,'UOM');
  SetPropertyFromNode(node,'UOMId');
  SetPropertyFromNode(node,'UOMMultiplier');
  SetBooleanPropertyFromNode(node,'Done');
end;


procedure TSalesSummaryLineForPackingforGUI.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'productId' ,productId);
  AddXMLNode(node,'productname' ,productname);
  AddXMLNode(node,'ProductDescription' ,ProductDescription);
  AddXMLNode(node,'QtyRequired' ,QtyRequired);
  AddXMLNode(node,'Totalshipped' ,Totalshipped);
  AddXMLNode(node,'QtyBackorder' ,QtyBackorder);
  AddXMLNode(node,'QtyPacked' ,QtyPacked);
  AddXMLNode(node,'UOM' ,UOM);
  AddXMLNode(node,'UOMId' ,UOMId);
  AddXMLNode(node,'UOMMultiplier' ,UOMMultiplier);
  AddXMLNode(node,'Done' ,Done);
end;


function TSalesSummaryLineForPackingforGUI.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


(*function TSalesSummaryLineForPackingforGUI.SalesSummaryLineForPackingforGUITablename: String;
begin
  result:= '';
  if assigned(Owner) then
    if owner is TPickAssemEntry then
      result := TPickAssemEntry(Owner).SalesSummaryLineForPackingforGUITablename;
end;*)

function TSalesSummaryLineForPackingforGUI.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSalesSummaryLineForPackingforGUI.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSalesSummaryLineForPackingforGUI.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TSalesSummaryLineForPackingforGUI.GetSQL: string;
begin
    if FSQL = '' then
        if Assigned(Self.Owner) then
            if Self.Owner is TPickAssemEntry then
                fSQL := 'Select * from ' + TPickAssemEntry(Self.Owner).SalesSummaryLineForPackingforGUITablename;
    Result := inherited GetSQL;
end;


class function TSalesSummaryLineForPackingforGUI.GetIDField: string;
begin
  Result := 's.saleID'
end;


function TSalesSummaryLineForPackingforGUI.getPickingAssemblyEntryID: Integer;
begin
  Result := fiPickingAssemblyEntryID;
  if result <> 0 then exit;
  if assigned(Owner) then
    if owner is TPickAssemEntry then
      result :=TPickAssemEntry(Owner).ID;
end;

class function TSalesSummaryLineForPackingforGUI.GetBusObjectTablename: string;
begin
  Result:= '';
end;


function TSalesSummaryLineForPackingforGUI.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


function TSalesSummaryLineForPackingforGUI.DoBeforeOpen(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforeOpen(Sender);
  if not(result) then exit;
end;

function TSalesSummaryLineForPackingforGUI.DoCalcFields(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoCalcFields(Sender);
  if not(result) then exit;
  QtyRequired := totalshipped - QtyPacked;
  if QtyRequired <0 then QtyRequired := 0;
end;

{Property Functions}
function  TSalesSummaryLineForPackingforGUI.GetproductId         : Integer   ; begin Result := GetIntegerField('productId');end;
function  TSalesSummaryLineForPackingforGUI.Getproductname       : string    ; begin Result := GetStringField('productname');end;
function  TSalesSummaryLineForPackingforGUI.GetProductDescription: string    ; begin Result := GetStringField('ProductDescription');end;
function  TSalesSummaryLineForPackingforGUI.GetQtyRequired       : Double    ; begin Result := GetFloatField('QtyRequired');end;
function  TSalesSummaryLineForPackingforGUI.GetTotalshipped      : Double    ; begin Result := GetFloatField('Totalshipped');end;
function  TSalesSummaryLineForPackingforGUI.GetQtyBackorder      : Double    ; begin Result := GetFloatField('QtyBackorder');end;
function  TSalesSummaryLineForPackingforGUI.GetQtyPacked         : Double    ; begin Result := GetFloatField('QtyPacked');end;
function  TSalesSummaryLineForPackingforGUI.GetUOM               : string    ; begin Result := GetStringField('UOM');end;
function  TSalesSummaryLineForPackingforGUI.GetUOMId             : Integer   ; begin Result := GetIntegerField('UOMId');end;
function  TSalesSummaryLineForPackingforGUI.GetUOMMultiplier   : Double    ; begin Result := GetFloatField('UOMMultiplier');end;
function  TSalesSummaryLineForPackingforGUI.GetDone              : Boolean   ; begin Result := GetBooleanField('Done');end;
procedure TSalesSummaryLineForPackingforGUI.SetProductID         (const Value: Integer   ); begin SetIntegerField('productId'         , Value);end;
procedure TSalesSummaryLineForPackingforGUI.Setproductname       (const Value: string    ); begin SetStringField('productname'        , Value);end;
procedure TSalesSummaryLineForPackingforGUI.SetProductDescription(const Value: string    ); begin SetStringField('ProductDescription' , Value);end;
procedure TSalesSummaryLineForPackingforGUI.SetQtyRequired       (const Value: Double    ); begin SetFloatField('QtyRequired'         , Value);end;
procedure TSalesSummaryLineForPackingforGUI.SetTotalshipped      (const Value: Double    ); begin SetFloatField('Totalshipped'        , Value);end;
procedure TSalesSummaryLineForPackingforGUI.SetQtyBackorder      (const Value: Double    ); begin SetFloatField('QtyBackorder'        , Value);end;
procedure TSalesSummaryLineForPackingforGUI.SetQtyPacked         (const Value: Double    ); begin SetFloatField('QtyPacked'           , Value);end;
procedure TSalesSummaryLineForPackingforGUI.SetUOM               (const Value: string    ); begin SetStringField('UOM'                , Value);end;
procedure TSalesSummaryLineForPackingforGUI.SetUOMId             (const Value: Integer   ); begin SetIntegerField('UOMId'             , Value);end;
procedure TSalesSummaryLineForPackingforGUI.SetUOMMultiplier   (const Value: Double    ); begin SetFloatField('UOMMultiplier'    , Value);end;
procedure TSalesSummaryLineForPackingforGUI.SetDone              (const Value: Boolean   ); begin SetBooleanField('Done'               , Value);end;


{ TPickingAssemblies }

constructor TPickingAssemblies.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CopySOPickingToInvoiceFailed := False;
end;

procedure TPickingAssemblies.CreateInstance;
begin
  inherited;
  If Owner Is TPickAssemEntry Then
    If Assigned(TPickAssemEntry(Owner).ObjInstanceToClone) Then
      if TPickAssemEntry(Owner).ObjInstanceToClone is TPickAssemEntry then
        ObjInstanceToClone    := TPickAssemEntry(TPickAssemEntry(Owner).ObjInstanceToClone).PickingAssemblies;
end;

function TPickingAssemblies.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not(result) then exit;
  if Assigned(Owner) then
    if owner is TPickAssemEntry then
      PickingAssemblyEntryID := TPickAssemEntry(Owner).ID;
end;

function TPickAssemEntry.CopySOPickingToInvoice: Boolean;
var
  invID:Integer;
begin
  REsult := False;
  invID:=InvoiceID(SaleID);
  if invID=0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Invoice doesn''t exists for Sales #' + inttostr(SaleID) +'.', True);
    Exit;
  end;
  Connection.BeginNestedTransaction;
  try
    CopySOPickingToInvoiceFailed := false;
    CopyingSOPickingToInvoice := True;
    Try
      If (Self.CloneBusObj('SaleID', invID, False, 'SaleID') <> Nil) and (CopySOPickingToInvoiceFailed =False) Then Begin
        TPickAssemEntry(ObjInstanceToClone).SOPickingRef := Globalref;
        TPickAssemEntry(ObjInstanceToClone).Converted :=False;
        TPickAssemEntry(ObjInstanceToClone).PostDB;
        Self.Converted := TRue;
        PostDB;
        connection.CommitNestedTransaction;
        Result := True;
        Exit;
      End;
      connection.RollbackNestedTransaction;
    Finally
      CopyingSOPickingToInvoice := False;
      CopySOPickingToInvoiceFailed:= False;
    End;
  Except
    on E:Exception do begin
      connection.RollbackNestedTransaction;
    end;
  end;
end;
procedure TPickAssemEntry.ClonePropertyObjects;
begin
  inherited;
  Lines.IterateRecords(CloneLines);
  if CopySOPickingToInvoiceFailed then exit;
  PickingAssemblies.IterateRecords(CloneLines);
end;
procedure TPickAssemEntry.CloneLines(const Sender: TBusObj; var Abort: Boolean);
var
  invID:Integer;
begin
  if (Sender is TPickAssemEntryLines) then begin
    invID := InvoiceID(TPickAssemEntryLines(Sender).SaleID);
    if invID=0 then exit;// the invoice is missing - should not happen though
    TPickAssemEntryLines(Sender).FieldsnotToclone := 'SaleID';
    if Sender.CloneBusObj('PickingAssemblyEntryID', ObjInstanceToClone.ID, False)= nil then begin
      CopySOPickingToInvoiceFailed:=true;
      Abort := True;
      Exit;
    end;
    TPickAssemEntryLines(TPickAssemEntryLines(Sender).ObjInstanceToClone).SaleID := invID;
    TPickAssemEntryLines(TPickAssemEntryLines(Sender).ObjInstanceToClone).SOPickingREf := TPickAssemEntryLines(Sender).Globalref;
    TPickAssemEntryLines(TPickAssemEntryLines(Sender).ObjInstanceToClone).PostDB;
  end else if Sender is TPickingAssemblies then begin
    invID := InvoiceID(TPickingAssemblies(Sender).SaleID);
    if invID=0 then exit;// the invoice is missing - should not happen though
    TPickingAssemblies(Sender).FieldsnotToclone := 'SaleID';
    if (Sender.CloneBusObj('PickingAssemblyEntryID', ObjInstanceToClone.ID, False)= nil) or (TPickingAssemblies(Sender).CopySOPickingToInvoiceFailed) then begin
      CopySOPickingToInvoiceFailed:=true;
      Abort := True;
      Exit;
    end;
    TPickingAssemblies(TPickingAssemblies(Sender).ObjInstanceToClone).SaleID := invID;
    TPickingAssemblies(TPickingAssemblies(Sender).ObjInstanceToClone).SOPickingREf := TPickingAssemblies(Sender).Globalref;
    TPickingAssemblies(TPickingAssemblies(Sender).ObjInstanceToClone).Converted :=True;
    TPickingAssemblies(TPickingAssemblies(Sender).ObjInstanceToClone).PostDB;
  end;
end;
procedure TPickingAssemblies.CloneLines(const Sender: TBusObj; var Abort: Boolean);
var
  EntryLineID:Integer;
begin
  if not (Sender is TPickingAssemblyLine) then exit;
  EntryLineID :=   ClonedEntrylineIDforRef(TPickingAssemblyLine(Sender).Entrylineref);
  if EntryLineID=0 then exit;// the invoice is missing - should not happen though
  TPickingAssemblyLine(Sender).FieldsnotToclone := 'PickingAssemblyentrylinesID';
  if Sender.CloneBusObj('PickingAssemblyID', ObjInstanceToClone.ID, False)= nil then begin
    CopySOPickingToInvoiceFailed:=true;
    Abort := True;
    Exit;
  end;
  TPickingAssemblyLine(TPickingAssemblyLine(Sender).ObjInstanceToClone).PickingAssemblyentrylinesID := EntryLineID;
  TPickingAssemblyLine(TPickingAssemblyLine(Sender).ObjInstanceToClone).SOPickingREf := TPickingAssemblyLine(Sender).Globalref;
  TPickingAssemblyLine(TPickingAssemblyLine(Sender).ObjInstanceToClone).PostDB;
end;

initialization
  RegisterClass(TSalesSummaryLineForPackingforGUI);
  RegisterClassOnce(TPickingAssemblyLine);
  RegisterClass(TPickAssemEntrylines);
  RegisterClass(TPickAssemEntry);
  RegisterClassOnce(TPickingAssembly);
  RegisterClassOnce(TPickingEmployee);
  RegisterClassOnce(TPackingEmployee);


end.
