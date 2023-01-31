unit BusObjProcResource;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  08/06/07  1.00.01  A  Initial Version.
  }


interface


uses BusObjBase, DB, Classes,  BusObjProcessStep, IntegerListObj, XMLDoc, XMLIntf;


type

  TProcResourceProcess = class;
  TProcResource = class;
  TProcResourceProducts = class;
  TProcResourceProductList = class;
  TProcResourceProductClean = class;
  TProcResourceDays = class(TMSBusObj)
  private
    function GetProcResourceID    : Integer   ;
    function GetSunday            : Boolean   ;
    function GetMonday            : Boolean   ;
    function GetTuesday           : Boolean   ;
    function GetWednesday         : Boolean   ;
    function GetThursday          : Boolean   ;
    function GetFriday            : Boolean   ;
    function GetSaturday          : Boolean   ;
    function GetSundayCapacityHoursDay            : Double    ;
    function GetMondayCapacityHoursDay            : Double    ;
    function GetTuesdayCapacityHoursDay           : Double    ;
    function GetWednesdayCapacityHoursDay         : Double    ;
    function GetThursdayCapacityHoursDay          : Double    ;
    function GetFridayCapacityHoursDay            : Double    ;
    function GetSaturdayCapacityHoursDay          : Double    ;

    function GetSundayTotCapacityHoursDay            : Double    ;
    function GetMondayTotCapacityHoursDay            : Double    ;
    function GetTuesdayTotCapacityHoursDay           : Double    ;
    function GetWednesdayTotCapacityHoursDay         : Double    ;
    function GetThursdayTotCapacityHoursDay          : Double    ;
    function GetFridayTotCapacityHoursDay            : Double    ;
    function GetSaturdayTotCapacityHoursDay          : Double    ;

    function  getSundayStartAt    :Ttime;
    function  getMondayStartAt    :Ttime;
    function  getTuesdayStartAt   :Ttime;
    function  getWednesdayStartAt :Ttime;
    function  getThursdayStartAt  :Ttime;
    function  getFridayStartAt    :Ttime;
    function  getSaturdayStartAt  :Ttime;
    procedure SetSunday            (const Value: Boolean   );
    procedure SetMonday            (const Value: Boolean   );
    procedure SetTuesday           (const Value: Boolean   );
    procedure SetWednesday         (const Value: Boolean   );
    procedure SetThursday          (const Value: Boolean   );
    procedure SetFriday            (const Value: Boolean   );
    procedure SetSaturday          (const Value: Boolean   );
    procedure SetProcResourceID    (const Value: Integer   );

    procedure SetSundayCapacityHoursDay            (const Value: Double    );
    procedure SetMondayCapacityHoursDay            (const Value: Double    );
    procedure SetTuesdayCapacityHoursDay           (const Value: Double    );
    procedure SetWednesdayCapacityHoursDay         (const Value: Double    );
    procedure SetThursdayCapacityHoursDay          (const Value: Double    );
    procedure SetFridayCapacityHoursDay            (const Value: Double    );
    procedure SetSaturdayCapacityHoursDay          (const Value: Double    );

    procedure SetSundayTotCapacityHoursDay            (const Value: Double    );
    procedure SetMondayTotCapacityHoursDay            (const Value: Double    );
    procedure SetTuesdayTotCapacityHoursDay           (const Value: Double    );
    procedure SetWednesdayTotCapacityHoursDay         (const Value: Double    );
    procedure SetThursdayTotCapacityHoursDay          (const Value: Double    );
    procedure SetFridayTotCapacityHoursDay            (const Value: Double    );
    procedure SetSaturdayTotCapacityHoursDay          (const Value: Double    );

    Procedure  SetSundayStartAt     (const Value:Ttime);
    Procedure  SetMondayStartAt     (const Value:Ttime);
    Procedure  SetTuesdayStartAt    (const Value:Ttime);
    Procedure  SetWednesdayStartAt  (const Value:Ttime);
    Procedure  SetThursdayStartAt   (const Value:Ttime);
    Procedure  SetFridayStartAt     (const Value:Ttime);
    Procedure  SetSaturdayStartAt   (const Value:Ttime);
    Function ProcResource:TProcResource;
    procedure ValidateDaysnotSelected;
    function ValidateDaysSelected: Boolean;
    Function BreakdownHours :double;
    function SetupHours :double;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property ProcResourceID     :Integer     read GetProcResourceID   write SetProcResourceID;
    property Sunday             :Boolean     read GetSunday           write SetSunday        ;
    property Monday             :Boolean     read GetMonday           write SetMonday        ;
    property Tuesday            :Boolean     read GetTuesday          write SetTuesday       ;
    property Wednesday          :Boolean     read GetWednesday        write SetWednesday     ;
    property Thursday           :Boolean     read GetThursday         write SetThursday      ;
    property Friday             :Boolean     read GetFriday           write SetFriday        ;
    property Saturday           :Boolean     read GetSaturday         write SetSaturday      ;

    property SundayCapacityHoursDay             :Double     read GetSundayCapacityHoursDay           write SetSundayCapacityHoursDay        ;
    property MondayCapacityHoursDay             :Double     read GetMondayCapacityHoursDay           write SetMondayCapacityHoursDay        ;
    property TuesdayCapacityHoursDay            :Double     read GetTuesdayCapacityHoursDay          write SetTuesdayCapacityHoursDay       ;
    property WednesdayCapacityHoursDay          :Double     read GetWednesdayCapacityHoursDay        write SetWednesdayCapacityHoursDay     ;
    property ThursdayCapacityHoursDay           :Double     read GetThursdayCapacityHoursDay         write SetThursdayCapacityHoursDay      ;
    property FridayCapacityHoursDay             :Double     read GetFridayCapacityHoursDay           write SetFridayCapacityHoursDay        ;
    property SaturdayCapacityHoursDay           :Double     read GetSaturdayCapacityHoursDay         write SetSaturdayCapacityHoursDay      ;

    property SundayTotCapacityHoursDay             :Double     read GetSundayTotCapacityHoursDay           write SetSundayTotCapacityHoursDay        ;
    property MondayTotCapacityHoursDay             :Double     read GetMondayTotCapacityHoursDay           write SetMondayTotCapacityHoursDay        ;
    property TuesdayTotCapacityHoursDay            :Double     read GetTuesdayTotCapacityHoursDay          write SetTuesdayTotCapacityHoursDay       ;
    property WednesdayTotCapacityHoursDay          :Double     read GetWednesdayTotCapacityHoursDay        write SetWednesdayTotCapacityHoursDay     ;
    property ThursdayTotCapacityHoursDay           :Double     read GetThursdayTotCapacityHoursDay         write SetThursdayTotCapacityHoursDay      ;
    property FridayTotCapacityHoursDay             :Double     read GetFridayTotCapacityHoursDay           write SetFridayTotCapacityHoursDay        ;
    property SaturdayTotCapacityHoursDay           :Double     read GetSaturdayTotCapacityHoursDay         write SetSaturdayTotCapacityHoursDay      ;

    Property SundayStartAt    :Ttime read getSundayStartAt    write SetSundayStartAt;
    Property MondayStartAt    :Ttime read getMondayStartAt    write SetMondayStartAt;
    Property TuesdayStartAt   :Ttime read getTuesdayStartAt   write SetTuesdayStartAt;
    Property WednesdayStartAt :Ttime read getWednesdayStartAt write SetWednesdayStartAt;
    Property ThursdayStartAt  :Ttime read getThursdayStartAt  write SetThursdayStartAt;
    Property FridayStartAt    :Ttime read getFridayStartAt    write SetFridayStartAt;
    Property SaturdayStartAt  :Ttime read getSaturdayStartAt  write SetSaturdayStartAt;
  end;

  TProcResourceUnAvailability = class(TMSBusObj)
  private
    function GetProcResourceId                  : Integer   ;
    function GetProcResourceDetailId            : Integer   ;
    function GetDescription                     : string    ;
    function GetTimeStart                       : TDateTime ;
    function GetTimeEnd                         : TDateTime ;
    procedure SetProcResourceId                  (const Value: Integer   );
    procedure SetProcResourceDetailId            (const Value: Integer   );
    procedure SetDescription                     (const Value: string    );
    procedure SetTimeStart                       (const Value: TDateTime );
    procedure SetTimeEnd                         (const Value: TDateTime );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property ProcResourceId                   :Integer     read GetProcResourceId                 write SetProcResourceId              ;
    property ProcResourceDetailId             :Integer     read GetProcResourceDetailId           write SetProcResourceDetailId        ;
    property Description                      :string      read GetDescription                    write SetDescription                 ;
    property TimeStart                        :TDateTime   read GetTimeStart                      write SetTimeStart                   ;
    property TimeEnd                          :TDateTime   read GetTimeEnd                        write SetTimeEnd                     ;
  end;

  TProcResourceDetails = class(TMSBusObj)
  private
    //TotNoOfResources :Integer;
    AlllinesValid :Boolean;
    function GetProcResourceId       : Integer   ;
    function GetDescription          : string    ;
    function GetFixedAssetID         : Integer   ;
    function GetUOMQty               : Double ;
    function GetUOMMult              : Double ;
    function GetNoOfResources        : Integer   ;
    function GetUOMID                : Integer   ;
    function GetFixedAsset           : string    ;
    function GetResourceAvailable    : Boolean   ;
    function GetUsedWithProductsInSeq : Boolean   ;
    function GetClosedOnPHs          : Boolean   ;
    function GetActive               : Boolean   ;
    procedure SetProcResourceId       (const Value: Integer   );
    procedure SetDescription          (const Value: string    );
    procedure SetFixedAssetID         (const Value: Integer   );
    procedure SetUOMQty               (const Value: Double    );
    procedure SetUOMMult              (const Value: Double    );
    procedure SetNoOfResources        (const Value: Integer   );
    procedure SetUOMID                (const Value: Integer   );
    procedure SetFixedAsset           (const Value: string    );
    procedure SetResourceAvailable    (const Value: Boolean   );
    procedure SetClosedOnPHs          (const Value: Boolean   );
    procedure SetActive               (const Value: Boolean   );
    function getProcResourceUnAvailability: TProcResourceUnAvailability;
    Function GetProcResourceProducts : TProcResourceProductList;
    Function GetProcResourceProductClean : TProcResourceProductClean;
    function ValidateProcResourceProducts: Boolean;
    procedure ValidateProcResourceProductsCallback(const Sender: TBusObj;
      var Abort: boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function  DoBeforeDelete(Sender :TDatasetBusObj ):Boolean;          override;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    function     TotNoOfResourcesinProduct: Integer;
  published
    property ProcResourceId        :Integer     read GetProcResourceId        write SetProcResourceId   ;
    property Description           :string      read GetDescription           write SetDescription      ;
    property FixedAssetID          :Integer     read GetFixedAssetID          write SetFixedAssetID     ;
    property UOMQty                :Double      read GetUOMQty                write SetUOMQty           ;
    property UOMMult               :Double      read GetUOMMult               write SetUOMMult          ;
    property NoOfResources         :Integer     read GetNoOfResources         write SetNoOfResources    ;
    property UOMID                 :Integer     read GetUOMID                 write SetUOMID            ;
    property FixedAsset            :string      read GetFixedAsset            write SetFixedAsset       ;
    property ResourceAvailable     :Boolean     read GetResourceAvailable     write SetResourceAvailable;
    property UsedWithProductsInSeq  :Boolean     read GetUsedWithProductsInSeq  ;
    property ClosedOnPHs           :Boolean     read GetClosedOnPHs           write SetClosedOnPHs      ;
    property Active                :Boolean     read GetActive                write SetActive           ;
    Property ProcResourceUnAvailability : TProcResourceUnAvailability read getProcResourceUnAvailability;
    Property ProcResourceProducts        : TProcResourceProductList read GetProcResourceProducts;
    Property ProcResourceProductClean    : TProcResourceProductClean read GetProcResourceProductClean;
  end;
  TProcResourceProducts = class(TMSBusObj)
  private
    updatingNoOfResources:Boolean;
    function GetProcresourcedetailID     : Integer   ;
    function GetProductId                 : Integer   ;
    function GetProductName               : string    ;
    function GetSeqno                    : Integer   ;
    function GetNoOfResources            : Integer   ;
    function GetActive                   : Boolean   ;
    Function getResourceDate              : Tdatetime;
    procedure SetProcresourcedetailID     (const Value: Integer   );
    procedure SetProductId                 (const Value: Integer   );
    procedure SetProductName               (const Value: string    );
    procedure SetSeqno                    (const Value: Integer   );
    procedure SetNoOfResources            (const Value: Integer   );
    procedure SetActive                   (const Value: Boolean   );
    Procedure SetResourceDate             (Const Value :TDatetime);
    function LastSeqno: Integer;
    function TotNoOfResourcesinProduct: Integer;
    function TotNoOfResources: Integer;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property ProcresourcedetailID      :Integer     read GetProcresourcedetailID    write SetProcresourcedetailID ;
    property ProductId                  :Integer     read GetProductId                write SetProductId             ;
    property ProductName                :string      read GetProductName              write SetProductName           ;
    property Seqno                     :Integer     read GetSeqno                   write SetSeqno                ;
    property NoOfResources             :Integer     read GetNoOfResources           write SetNoOfResources        ;
    property Active                    :Boolean     read GetActive                  write SetActive               ;
    Property ResourceDate             :TdateTime    read getResourceDate            write setResourceDate;
  end;
  TProcResourceProductClean = class(TProcResourceProducts)
  Protected
    procedure DoFieldOnChange(Sender: TField); override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;override;
    function  DoBeforeInsert(Sender:TDatasetBusObj) : Boolean;override;
  public
    constructor  Create(AOwner: TComponent); override;
  end;
  TProcResourceProductList = Class(TProcResourceProducts)
  Private
    //ilastno:Integer;
  Protected
    procedure DoFieldOnChange(Sender: TField); override;
    function  DoBeforeInsert(Sender:TDatasetBusObj) : Boolean;override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;override;
  public
    constructor  Create(AOwner: TComponent); override;
  End;
  TProcResourceSchedule = class(TMSBusObj)
  private
    function GetResourceProductID    : Integer   ;
    function GetSaleLineId           : Integer   ;
    function GetProcesspartID        : Integer   ;
    function GetProcesstimeID        : Integer   ;
    function Getproctreeid           : Integer   ;
    function GetSaleID               : Integer   ;
    function GetSeqno                : Integer   ;
    function GetScheduledQty         : Double    ;
    function GetScheduleDate         : TDateTime ;
    procedure SetResourceProductID    (const Value: Integer   );
    procedure SetSaleLineId           (const Value: Integer   );
    procedure SetProcesspartID        (const Value: Integer   );
    procedure SetProcesstimeID        (const Value: Integer   );
    procedure Setproctreeid           (const Value: Integer   );
    procedure SetSaleID               (const Value: Integer   );
    procedure SetSeqno                (const Value: Integer   );
    procedure SetScheduledQty         (const Value: Double    );
    procedure SetScheduleDate         (const Value: TDateTime );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property ResourceProductID     :Integer     read GetResourceProductID   write SetResourceProductID;
    property SaleLineId            :Integer     read GetSaleLineId          write SetSaleLineId       ;
    property ProcesspartID         :Integer     read GetProcesspartID       write SetProcesspartID    ;
    property ProcesstimeID         :Integer     read GetProcesstimeID       write SetProcesstimeID    ;
    property proctreeid            :Integer     read Getproctreeid          write Setproctreeid       ;
    property SaleID                :Integer     read GetSaleID              write SetSaleID           ;
    property Seqno                 :Integer     read GetSeqno               write SetSeqno            ;
    property ScheduledQty          :Double      read GetScheduledQty        write SetScheduledQty     ;
    property ScheduleDate          :TDateTime   read GetScheduleDate        write SetScheduleDate     ;
  end;

  TProcResource = class(TMSBusObj)
  private
    fProcesses: TProcResourceProcess;
    AllLinesValied:Boolean;
    function GetDescription           : string    ;
    function GetResourceName          : string    ;
    function GetResourceAvailable     : Boolean   ;
    function GetUsedWithProductsInSeq  : Boolean   ;
    function GetClosedOnPHs           : Boolean   ;
    function GetActive     : Boolean   ;
    (* function GetCapacityHoursDay      : Double    ; *)
    function GetSetupHoursDay         : Double    ;
    function GetBreakdownHoursDay     : Double    ;
    function GetHourlyLabourRate      : Double    ;
    function GetHourlyOverheadRate    : Double    ;
    Function getResourceCount:Integer;
    function GetProcesses: TProcResourceProcess;
    function ValidateResProcesses: boolean;
    function ValidateResourceDetails: boolean;
    function getProcResourceDays: TProcResourceDays;
    procedure ValidateResProcessesCallback(Const Sender: TBusObj; var Abort: boolean);
    procedure ValidateResourceDetailsCallback(Const Sender: TBusObj; var Abort: boolean);
    function getProcResourceDetails: TProcResourceDetails;
    function getCleanHourlyLabourRate: Double;

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    Function  DoAfterInsert(Sender:TDatasetBusObj):Boolean;Override;
    procedure SetDescription           (const Value: string    );Virtual;
    procedure SetResourceName          (const Value: string    );Virtual;
    procedure SetResourceAvailable     (const Value: Boolean   );Virtual;
    procedure SetUsedWithProductsInSeq  (const Value: Boolean   );
    procedure SetClosedOnPHs           (const Value: Boolean   );Virtual;
    (* procedure SetCapacityHoursDay      (const Value: Double    );Virtual; *)
    procedure SetSetupHoursDay         (const Value: Double    );Virtual;
    procedure SetBreakdownHoursDay     (const Value: Double    );Virtual;
    procedure SetHourlyLabourRate      (const Value: Double    );Virtual;
    procedure SetHourlyOverheadRate    (const Value: Double    );Virtual;
    Procedure SetResourceCount(Const Value:Integer);Virtual;
    procedure SetActive     (const Value: Boolean   );Virtual;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    constructor  Create(AOwner: TComponent);                             override;
    destructor   Destroy;                                                override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                  override;
    procedure    SaveToXMLNode(const node: IXMLNode);                    override;
    function     ValidateData: Boolean ;                                 override;
    function     Save: Boolean;                                         override;
    property Processes: TProcResourceProcess read GetProcesses;
    procedure InitializeNewObject; override;
    function ProcessUsedByOtherResource(ProcessStepIdList: TIntegerList; var ResourceName: string): boolean; overload;
    function ProcessUsedByOtherResource(ProcessStepId: Integer; var ResourceName: string): boolean;overload;
    function ProcessUsedByOtherResource(ProcessStepIds:String; var ResourceName: string): boolean;overload;


    Property ProcResourceDays :TProcResourceDays read getProcResourceDays;
    Procedure ValidateHrs(var hrs:Double;var StartAt:TTime; SetUp:double;Breakdown:Double;Change:String='Hr');
    function AnyRostered:Boolean;
    (*Procedure AustoRoster;*)
    Property CleanHourlyLabourRate :Double read getCleanHourlyLabourRate;
    Class Function ResourceForProcess(const aProcessStepID:Integer):Integer;
  published
    property Description            :string      read GetDescription          write SetDescription       ;
    property ResourceName           :string      read GetResourceName         write SetResourceName      ;
    property ResourceAvailable      :Boolean     read GetResourceAvailable    write SetResourceAvailable ;
    property UsedWithProductsInSeq   :Boolean     read GetUsedWithProductsInSeq write SetUsedWithProductsInSeq;
    property ClosedOnPHs            :Boolean     read GetClosedOnPHs          write SetClosedOnPHs       ;
    property Active      :Boolean     read GetActive    write SetActive ;
    (* property CapacityHoursDay       :Double      read GetCapacityHoursDay     write SetCapacityHoursDay  ; *)
    property SetupHoursDay          :Double      read GetSetupHoursDay        write SetSetupHoursDay     ;
    property BreakdownHoursDay      :Double      read GetBreakdownHoursDay    write SetBreakdownHoursDay ;
    property HourlyLabourRate       :Double      read GetHourlyLabourRate     write SetHourlyLabourRate  ;
    property HourlyOverheadRate     :Double      read GetHourlyOverheadRate   write SetHourlyOverheadRate;
    Property ResourceCount          :Integer     read getResourceCount        write setResourceCount;
    Property ProcResourceDetails    :TProcResourceDetails read getProcResourceDetails;
  end;
  TProcResourceProcessDetails = class(TProcResource)
  Private
    function getProcessStepid: Integer;
    function getProcResource: TProcResource;
  Protected
    procedure SetDescription           (const Value: string    );Override;
    procedure SetResourceName          (const Value: string    );Override;
    procedure SetResourceAvailable     (const Value: Boolean   );Override;
    procedure SetClosedOnPHs           (const Value: Boolean   );Override;
    (* procedure SetCapacityHoursDay      (const Value: Double    );Override; *)
    procedure SetSetupHoursDay         (const Value: Double    );Override;
    procedure SetBreakdownHoursDay     (const Value: Double    );Override;
    procedure SetHourlyLabourRate      (const Value: Double    );Override;
    procedure SetHourlyOverheadRate    (const Value: Double    );Override;
    Procedure SetResourceCount(Const Value:Integer);Override;
    procedure SetActive     (const Value: Boolean   );Override;

  public
    constructor  Create(AOwner: TComponent);override;
    Property ProcResource :TProcResource read getProcResource;
  Published
    Property ProcessStepid :Integer read getProcessStepid;
  end;
  TProcResourceProcess = class(TMSBusObj)
  private
    fProcessStep: TProcessStep;
    fProcResource: TProcResource;
    function GetProcessStepId            : Integer   ;
    procedure SetProcessStepId            (const Value: Integer   );
    function GetProcessStep: TProcessStep;
    function GetProcResourceId: Integer;
    procedure SetProcResourceId(const Value: Integer);
    function GetProcResource: TProcResource;
    function GetProcessStepDescription: string;
    procedure SetProcessStepDescription(const Value: string);
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    function getNoOfEmployeesReqd: Integer;
    procedure setNoOfEmployeesReqd(const Value: Integer);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    Function  DoBeforePost(Sender:TDatasetBusobj): Boolean;              Override;
    Function  DoAfterInsert(Sender:TDatasetBusObj):Boolean;              Override;
    Function  DoNewRecord(Sender :TDatasetBusObj ):Boolean; override;
    Function  DoAfterDelete(Sender :TDatasetBusObj ):Boolean; override;
    Function  DoBeforeEdit(Sender :TDatasetBusObj ):Boolean; override;
    procedure InitializeNewObject; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    constructor  Create(AOwner: TComponent);                             override;
    destructor   Destroy;                                                override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                  override;
    procedure    SaveToXMLNode(const node: IXMLNode);                    override;
    function     ValidateData: Boolean ;                                 override;
    function     Save: Boolean ;                                         override;
    property     ProcessStep: TProcessStep read GetProcessStep;
    property     ProcResource: TProcResource read GetProcResource;
    procedure New; override;
  published
    property ProcResourceId         :Integer   read GetProcResourceId       write SetProcResourceId;
    property ProcessStepId          :Integer   read GetProcessStepId        write SetProcessStepId;
    property ProcessStepDescription :string    read GetProcessStepDescription write SetProcessStepDescription;
    property Active: boolean read GetActive write SetActive;
    Property NoOfEmployeesReqd :Integer read getNoOfEmployeesReqd write setNoOfEmployeesReqd;
  end;

procedure Register;

implementation

uses
  CommonLib, SysUtils, BusObjConst, MyAccess,ERPdbComponents, tcConst,
  AppEnvironment, ManufactureLib, dateutils, Variants, DbSharedObjectsObj,
  tcDataUtils, BusObjSimpleTypes, CommonDbLib, BusobjProduct;

procedure Register;
begin
  //RegisterComponents('BO Manuf', [TProcResource]);
  RegisterNoIcon([TProcResource]);

end;

 {TProcResourceDays}

function TProcResourceDays.BreakdownHours: double;
begin
  Result :=0;
  if assigned(Self.Owner) then
    if Self.owner is TProcResource then
      result := TProcResource(Self.Owner).BreakdownHoursDay;

end;

constructor TProcResourceDays.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ProcResourceDays';
  fSQL := 'SELECT * FROM tblprocresourcedays';
end;


destructor TProcResourceDays.Destroy;
begin
  inherited;
end;


procedure TProcResourceDays.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProcResourceID');
  SetBooleanPropertyFromNode(node,'Sunday');
  SetBooleanPropertyFromNode(node,'Monday');
  SetBooleanPropertyFromNode(node,'Tuesday');
  SetBooleanPropertyFromNode(node,'Wednesday');
  SetBooleanPropertyFromNode(node,'Thursday');
  SetBooleanPropertyFromNode(node,'Friday');
  SetBooleanPropertyFromNode(node,'Saturday');
  SetPropertyFromNode(node,'SundayCapacityHoursDay');
  SetPropertyFromNode(node,'MondayCapacityHoursDay');
  SetPropertyFromNode(node,'TuesdayeCapacityHoursDay');
  SetPropertyFromNode(node,'WednesdayCapacityHoursDay');
  SetPropertyFromNode(node,'ThursdayCapacityHoursDay');
  SetPropertyFromNode(node,'FridayCapacityHoursDay');
  SetPropertyFromNode(node,'SaturdayCapacityHoursDay');
  SetDatetimePropertyFromNode(node,'SundayStartAt');
  SetDatetimePropertyFromNode(node,'MondayStartAt');
  SetDatetimePropertyFromNode(node,'TuesdayeStartAt');
  SetDatetimePropertyFromNode(node,'WednesdayStartAt');
  SetDatetimePropertyFromNode(node,'ThursdayStartAt');
  SetDatetimePropertyFromNode(node,'FridayStartAt');
  SetDatetimePropertyFromNode(node,'SaturdayStartAt');
end;


procedure TProcResourceDays.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProcResourceID' ,ProcResourceID);
  AddXMLNode(node,'Sunday'    ,Sunday);
  AddXMLNode(node,'Monday'    ,Monday);
  AddXMLNode(node,'Tuesday'   ,Tuesday);
  AddXMLNode(node,'Wednesday' ,Wednesday);
  AddXMLNode(node,'Thursday'  ,Thursday);
  AddXMLNode(node,'Friday'    ,Friday);
  AddXMLNode(node,'Saturday'  ,Saturday);
  AddXMLNode(node,'sundayCapacityHoursDay'    ,SundayCapacityHoursDay);
  AddXMLNode(node,'MondayCapacityHoursDay'    ,MondayCapacityHoursDay);
  AddXMLNode(node,'TuesdayCapacityHoursDay'   ,TuesdayCapacityHoursDay);
  AddXMLNode(node,'wednesdayCapacityHoursDay' ,WednesdayCapacityHoursDay);
  AddXMLNode(node,'thursdayCapacityHoursDay'  ,ThursdayCapacityHoursDay);
  AddXMLNode(node,'FridayCapacityHoursDay'    ,FridayCapacityHoursDay);
  AddXMLNode(node,'SaturdayCapacityHoursDay'  ,SaturdayCapacityHoursDay);
  AddXMLNode(node,'sundayStartAt'    ,SundayStartAt);
  AddXMLNode(node,'MondayStartAt'    ,MondayStartAt);
  AddXMLNode(node,'TuesdayStartAt'   ,TuesdayStartAt);
  AddXMLNode(node,'wednesdayStartAt' ,WednesdayStartAt);
  AddXMLNode(node,'thursdayStartAt'  ,ThursdayStartAt);
  AddXMLNode(node,'FridayStartAt'    ,FridayStartAt);
  AddXMLNode(node,'SaturdayStartAt'  ,SaturdayStartAt);
end;


function TProcResourceDays.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if ProcResourceID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ProcResourceID should not be 0' , False );
    Exit;
  end;
  ValidateDaysnotSelected;
  Result := ValidateDaysSelected;
  if not result then exit;
  Result := True;
end;
Function TProcResourceDays.ValidateDaysSelected:Boolean;
var
  s:String;
begin
  REsult := false;
  if ProcResource = nil then exit;
  With ProcResource do begin
    if (Sunday) and ((SundayCapacityHoursDay =0) or
                   (Round(self.SundayCapacityHoursDay - BreakdownHours - SetupHours,GeneralRoundPlaces) <= 0))  then begin
      s:= 'Resource total available capacity hours for Sunday must be greater than zero';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      Result := False;
      SendEvent(BusObjEvent_GUIFocusField,'SundayCapacityHours');
      exit;
    end;
    if (monday) and ((MondayCapacityHoursDay =0) or
                   (Round(self.MondayCapacityHoursDay - BreakdownHours - SetupHours,GeneralRoundPlaces) <= 0))  then begin
      s:= 'Resource total available capacity hours for Monday must be greater than zero';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      Result := False;
      SendEvent(BusObjEvent_GUIFocusField,'MondayCapacityHours');
      exit;
    end;
    if (Tuesday) and  ((TuesdayCapacityHoursDay =0) or
                     (Round(self.TuesdayCapacityHoursDay - BreakdownHours - SetupHours,GeneralRoundPlaces) <= 0))  then begin
      s:= 'Resource total available capacity hours for Tuesday must be greater than zero';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      Result := False;
      SendEvent(BusObjEvent_GUIFocusField,'TuesdayCapacityHours');
      exit;
    end;
    if (Wednesday) and  ((WednesdayCapacityHoursDay =0) or
                       (Round(self.WednesdayCapacityHoursDay - BreakdownHours - SetupHours,GeneralRoundPlaces) <= 0))  then begin
      s:= 'Resource total available capacity hours for Wednesday must be greater than zero';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      Result := False;
      SendEvent(BusObjEvent_GUIFocusField,'WednesdayCapacityHours');
      exit;
    end;
    if (Thursday) and  ((ThursdayCapacityHoursDay =0) or
                      (Round(self.ThursdayCapacityHoursDay - BreakdownHours - SetupHours,GeneralRoundPlaces) <= 0))  then begin
      s:= 'Resource total available capacity hours for Thursday must be greater than zero';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      Result := False;
      SendEvent(BusObjEvent_GUIFocusField,'ThursdayCapacityHours');
      exit;
    end;
    if (Friday) and  ((FridayCapacityHoursDay =0) or
                    (Round(self.FridayCapacityHoursDay - BreakdownHours - SetupHours,GeneralRoundPlaces) <= 0))  then begin
      s:= 'Resource total available capacity hours for Friday must be greater than zero';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      Result := False;
      SendEvent(BusObjEvent_GUIFocusField,'FridayCapacityHours');
      exit;
    end;
    if (SAturday) and  ((SaturdayCapacityHoursDay =0) or
                      (Round(self.SAturdayCapacityHoursDay - BreakdownHours - SetupHours,GeneralRoundPlaces) <= 0))  then begin
      s:= 'Resource total available capacity hours for Saturday must be greater than zero';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      Result := False;
      SendEvent(BusObjEvent_GUIFocusField,'SaturdayCapacityHours');
      exit;
    end;
    if (Sunday) and (SundayCapacityHoursDay >0) and (Self.dataset.fieldbyname('SundayStartAt').value = Null) then begin
      s:= 'Sunday - Resource Starting time should be provided';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      Result := False;
      SendEvent(BusObjEvent_GUIFocusField,'SundayStartAt');
      exit;
    end;
    if (Monday) and (MondayCapacityHoursDay >0) and (Self.dataset.fieldbyname('MondayStartAt').value = Null) then begin
      s:= 'Monday - Resource Starting time should be provided';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      Result := False;
      SendEvent(BusObjEvent_GUIFocusField,'MondayStartAt');
      exit;
    end;
    if (Tuesday) and (TuesdayCapacityHoursDay >0) and (Self.dataset.fieldbyname('TuesdayStartAt').value = Null) then begin
      s:= 'Tuesday - Resource Starting time should be provided';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      Result := False;
      SendEvent(BusObjEvent_GUIFocusField,'TuesdayStartAt');
      exit;
    end;
    if (Wednesday) and (WednesdayCapacityHoursDay >0) and (Self.dataset.fieldbyname('WednesdayStartAt').value = Null) then begin
      s:= 'Wednesday - Resource Starting time should be provided';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      Result := False;
      SendEvent(BusObjEvent_GUIFocusField,'WednesdayStartAt');
      exit;
    end;
    if (Thursday) and (ThursdayCapacityHoursDay >0) and (Self.dataset.fieldbyname('ThursdayStartAt').value = Null) then begin
      s:= 'Thursday - Resource Starting time should be provided';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      Result := False;
      SendEvent(BusObjEvent_GUIFocusField,'ThursdayStartAt');
      exit;
    end;
    if (Friday) and (FridayCapacityHoursDay >0) and (Self.dataset.fieldbyname('FridayStartAt').value = Null) then begin
      s:= 'Friday - Resource Starting time should be provided';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      Result := False;
      SendEvent(BusObjEvent_GUIFocusField,'FridayStartAt');
      exit;
    end;
    if (Saturday) and (SaturdayCapacityHoursDay >0) and (Self.dataset.fieldbyname('SaturdayStartAt').value = Null) then begin
      s:= 'Saturday - Resource Starting time should be provided';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      Result := False;
      SendEvent(BusObjEvent_GUIFocusField,'SaturdayStartAt');
      exit;
    end;
  end;
  Result := true;
end;

Procedure TProcResourceDays.ValidateDaysnotSelected;
var
  s:String;
begin
  if not(sunday) and (SundayCapacityHoursDay <>0) then begin
      s:= 'Resource capacity hours for Sunday must be zero';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      SundayCapacityHoursDay:=0;
      SendEvent(BusObjEvent_Change,BusObjEvent_ResourceCapacity);
    end;
    if not(monday) and (MondayCapacityHoursDay <>0) then begin
      s:= 'Resource capacity hours for Monday must be zero';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      MondayCapacityHoursDay:=0;
      SendEvent(BusObjEvent_Change,BusObjEvent_ResourceCapacity);
    end;
    if not(Tuesday) and (TuesdayCapacityHoursDay <>0) then begin
      s:= 'Resource capacity hours for Tuesday must be zero';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      TuesdayCapacityHoursDay:=0;
      SendEvent(BusObjEvent_Change,BusObjEvent_ResourceCapacity);
    end;
    if not(Wednesday) and (WednesdayCapacityHoursDay <>0) then begin
      s:= 'Resource capacity hours for Wednesday must be zero';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      WednesdayCapacityHoursDay:=0;
      SendEvent(BusObjEvent_Change,BusObjEvent_ResourceCapacity);
    end;
    if not(Thursday) and (ThursdayCapacityHoursDay <>0) then begin
      s:= 'Resource capacity hours for Thursday must be zero';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      thursdayCapacityHoursDay:=0;
      SendEvent(BusObjEvent_Change,BusObjEvent_ResourceCapacity);
    end;
    if not(Friday) and (FridayCapacityHoursDay <>0) then begin
      s:= 'Resource capacity hours for Friday must be zero';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      FridayCapacityHoursDay:=0;
      SendEvent(BusObjEvent_Change,BusObjEvent_ResourceCapacity);
    end;
    if not(SAturday) and (SaturdayCapacityHoursDay <>0) then begin
      s:= 'Resource capacity hours for Saturday must be zero';
      self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
      saturdayCapacityHoursDay:=0;
      SendEvent(BusObjEvent_Change,BusObjEvent_ResourceCapacity);
    end;
end;
function TProcResourceDays.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProcResourceDays.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


function TProcResourceDays.ProcResource: TProcResource;
begin
  REsult := nil;
  if Assigned(Owner) then
    if owner is TProcResource  then
      REsult := TProcResource(Owner);
end;

procedure TProcResourceDays.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
(*  if SameText(Sender.FieldName, 'SundayCapacityHoursDay') then begin
    if SundayStartAt=0 then SundayStartAt := Appenv.CompanyPrefs.StartOfDay;
  end;*)
end;

function TProcResourceDays.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProcResourceDays.GetIDField: string;
begin
  Result := 'ID'
end;


class function TProcResourceDays.GetBusObjectTablename: string;
begin
  Result:= 'tblprocresourcedays';
end;


function TProcResourceDays.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
const
  DefaultDayCapacity = 8 * 60 * 60;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Owner) then
    if owner is TProcResource then
      ProcResourceID :=TProcResource(Self.Owner).ID;
  Sunday    := not IsWeekendday(7);
  Monday    := not IsWeekendday(1);
  Tuesday   := not IsWeekendday(2);
  Wednesday := not IsWeekendday(3);
  Thursday  := not IsWeekendday(4);
  Friday    := not IsWeekendday(5);
  Saturday  := not IsWeekendday(6);
  SundayStartAt   := Appenv.CompanyPrefs.StartOfDay;
  MondayStartAt   := Appenv.CompanyPrefs.StartOfDay;
  TuesdayStartAt  := Appenv.CompanyPrefs.StartOfDay;
  WednesdayStartAt:= Appenv.CompanyPrefs.StartOfDay;
  ThursdayStartAt := Appenv.CompanyPrefs.StartOfDay;
  FridayStartAt   := Appenv.CompanyPrefs.StartOfDay;
  SaturdayStartAt := Appenv.CompanyPrefs.StartOfDay;
  if Sunday then self.SundayCapacityHoursDay := DefaultDayCapacity;
  if Monday then self.MondayCapacityHoursDay := DefaultDayCapacity;
  if Tuesday then self.TuesdayCapacityHoursDay := DefaultDayCapacity;
  if Wednesday then self.WednesdayCapacityHoursDay := DefaultDayCapacity;
  if Thursday then self.ThursdayCapacityHoursDay := DefaultDayCapacity;
  if Friday then self.FridayCapacityHoursDay := DefaultDayCapacity;
  if Saturday then self.SaturdayCapacityHoursDay := DefaultDayCapacity;
end;

function TProcResourceDays.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TProcResourceDays.GetProcResourceID: Integer   ; begin Result := GetIntegerField('ProcResourceID');end;
function  TProcResourceDays.GetSunday        : Boolean   ; begin Result := GetBooleanField('Sunday');end;
function  TProcResourceDays.GetMonday        : Boolean   ; begin Result := GetBooleanField('Monday');end;
function  TProcResourceDays.GetTuesday       : Boolean   ; begin Result := GetBooleanField('Tuesday');end;
function  TProcResourceDays.GetWednesday     : Boolean   ; begin Result := GetBooleanField('Wednesday');end;
function  TProcResourceDays.GetThursday      : Boolean   ; begin Result := GetBooleanField('Thursday');end;
function  TProcResourceDays.GetFriday        : Boolean   ; begin Result := GetBooleanField('Friday');end;
function  TProcResourceDays.GetSaturday      : Boolean   ; begin Result := GetBooleanField('Saturday');end;

function  TProcResourceDays.GetSundayCapacityHoursDay        : Double    ; begin Result := GetFloatfield('SundayCapacityHoursDay');end;
function  TProcResourceDays.GetMondayCapacityHoursDay        : Double    ; begin Result := GetFloatfield('MondayCapacityHoursDay');end;
function  TProcResourceDays.GetTuesdayCapacityHoursDay       : Double    ; begin Result := GetFloatfield('TuesdayCapacityHoursDay');end;
function  TProcResourceDays.GetWednesdayCapacityHoursDay     : Double    ; begin Result := GetFloatfield('WednesdayCapacityHoursDay');end;
function  TProcResourceDays.GetThursdayCapacityHoursDay      : Double    ; begin Result := GetFloatfield('ThursdayCapacityHoursDay');end;
function  TProcResourceDays.GetFridayCapacityHoursDay        : Double    ; begin Result := GetFloatfield('FridayCapacityHoursDay');end;
function  TProcResourceDays.GetSaturdayCapacityHoursDay      : Double    ; begin Result := GetFloatfield('SaturdayCapacityHoursDay');end;

function  TProcResourceDays.GetSundayTotCapacityHoursDay        : Double    ; begin Result := GetFloatfield('SundayTotCapacityHoursDay');end;
function  TProcResourceDays.GetMondayTotCapacityHoursDay        : Double    ; begin Result := GetFloatfield('MondayTotCapacityHoursDay');end;
function  TProcResourceDays.GetTuesdayTotCapacityHoursDay       : Double    ; begin Result := GetFloatfield('TuesdayTotCapacityHoursDay');end;
function  TProcResourceDays.GetWednesdayTotCapacityHoursDay     : Double    ; begin Result := GetFloatfield('WednesdayTotCapacityHoursDay');end;
function  TProcResourceDays.GetThursdayTotCapacityHoursDay      : Double    ; begin Result := GetFloatfield('ThursdayTotCapacityHoursDay');end;
function  TProcResourceDays.GetFridayTotCapacityHoursDay        : Double    ; begin Result := GetFloatfield('FridayTotCapacityHoursDay');end;
function  TProcResourceDays.GetSaturdayTotCapacityHoursDay      : Double    ; begin Result := GetFloatfield('SaturdayTotCapacityHoursDay');end;


function  TprocResourceDays.GetSundayStartAt    :Ttime; begin result := getDateTimeField('SundayStartAt'); end;
function  TprocResourceDays.GetMondayStartAt    :Ttime; begin result := getDateTimeField('MondayStartAt'); end;
function  TprocResourceDays.GetTuesdayStartAt   :Ttime; begin result := getDateTimeField('TuesdayStartAt'); end;
function  TprocResourceDays.GetWednesdayStartAt :Ttime; begin result := getDateTimeField('WednesdayStartAt'); end;
function  TprocResourceDays.GetThursdayStartAt  :Ttime; begin result := getDateTimeField('ThursdayStartAt'); end;
function  TprocResourceDays.GetFridayStartAt    :Ttime; begin result := getDateTimeField('FridayStartAt'); end;
function  TprocResourceDays.GetSaturdayStartAt  :Ttime; begin result := getDateTimeField('SaturdayStartAt'); end;
procedure TProcResourceDays.SetProcResourceID(const Value: Integer   ); begin SetIntegerField('ProcResourceID' , Value);end;
procedure TProcResourceDays.SetSunday        (const Value: Boolean   ); begin SetBooleanField('Sunday'         , Value);end;
procedure TProcResourceDays.SetMonday        (const Value: Boolean   ); begin SetBooleanField('Monday'         , Value);end;
procedure TProcResourceDays.SetTuesday       (const Value: Boolean   ); begin SetBooleanField('Tuesday'        , Value);end;
procedure TProcResourceDays.SetWednesday     (const Value: Boolean   ); begin SetBooleanField('Wednesday'      , Value);end;
procedure TProcResourceDays.SetThursday      (const Value: Boolean   ); begin SetBooleanField('Thursday'       , Value);end;
procedure TProcResourceDays.SetFriday        (const Value: Boolean   ); begin SetBooleanField('Friday'         , Value);end;
procedure TProcResourceDays.SetSaturday      (const Value: Boolean   ); begin SetBooleanField('Saturday'       , Value);end;

procedure TProcResourceDays.SetSundayCapacityHoursDay        (const Value: Double    ); begin SetFloatfield('SundayCapacityHoursDay'         , Value);end;
procedure TProcResourceDays.SetMondayCapacityHoursDay        (const Value: Double    ); begin SetFloatfield('MondayCapacityHoursDay'         , Value);end;
procedure TProcResourceDays.SetTuesdayCapacityHoursDay       (const Value: Double    ); begin SetFloatfield('TuesdayCapacityHoursDay'        , Value);end;
procedure TProcResourceDays.SetWednesdayCapacityHoursDay     (const Value: Double    ); begin SetFloatfield('WednesdayCapacityHoursDay'      , Value);end;
procedure TProcResourceDays.SetThursdayCapacityHoursDay      (const Value: Double    ); begin SetFloatfield('ThursdayCapacityHoursDay'       , Value);end;
procedure TProcResourceDays.SetFridayCapacityHoursDay        (const Value: Double    ); begin SetFloatfield('FridayCapacityHoursDay'         , Value);end;
procedure TProcResourceDays.SetSaturdayCapacityHoursDay      (const Value: Double    ); begin SetFloatfield('SaturdayCapacityHoursDay'       , Value);end;

procedure TProcResourceDays.SetSundayTotCapacityHoursDay        (const Value: Double    ); begin SetFloatfield('SundayTotCapacityHoursDay'         , Value);end;
procedure TProcResourceDays.SetMondayTotCapacityHoursDay        (const Value: Double    ); begin SetFloatfield('MondayTotCapacityHoursDay'         , Value);end;
procedure TProcResourceDays.SetTuesdayTotCapacityHoursDay       (const Value: Double    ); begin SetFloatfield('TuesdayTotCapacityHoursDay'        , Value);end;
procedure TProcResourceDays.SetWednesdayTotCapacityHoursDay     (const Value: Double    ); begin SetFloatfield('WednesdayTotCapacityHoursDay'      , Value);end;
procedure TProcResourceDays.SetThursdayTotCapacityHoursDay      (const Value: Double    ); begin SetFloatfield('ThursdayTotCapacityHoursDay'       , Value);end;
procedure TProcResourceDays.SetFridayTotCapacityHoursDay        (const Value: Double    ); begin SetFloatfield('FridayTotCapacityHoursDay'         , Value);end;
procedure TProcResourceDays.SetSaturdayTotCapacityHoursDay      (const Value: Double    ); begin SetFloatfield('SaturdayTotCapacityHoursDay'       , Value);end;

Procedure TprocResourceDays.SetSundayStartAt    (const Value:Ttime); begin SetDateTimefield('SundayStartAt'   , Value);end;
Procedure TprocResourceDays.SetMondayStartAt    (const Value:Ttime); begin SetDateTimefield('MondayStartAt'   , Value);end;
Procedure TprocResourceDays.SetTuesdayStartAt   (const Value:Ttime); begin SetDateTimefield('TuesdayStartAt'  , Value);end;
Procedure TprocResourceDays.SetWednesdayStartAt (const Value:Ttime); begin SetDateTimefield('WednesdayStartAt', Value);end;
Procedure TprocResourceDays.SetThursdayStartAt  (const Value:Ttime); begin SetDateTimefield('ThursdayStartAt' , Value);end;
Procedure TprocResourceDays.SetFridayStartAt    (const Value:Ttime); begin SetDateTimefield('FridayStartAt'   , Value);end;
Procedure TprocResourceDays.SetSaturdayStartAt  (const Value:Ttime); begin SetDateTimefield('SaturdayStartAt' , Value);end;
function TProcResourceDays.SetupHours: double;
begin
  Result :=0;
  if assigned(Self.Owner) then
    if Self.owner is TProcResource then
      result := TProcResource(Self.Owner).SetupHoursDay;
end;
{TProcResource}
function TProcResource.AnyRostered: Boolean;
var
  Qry : TERPQuery;
begin
  Qry := GetSharedDataSet('Select count(*) as ctr from tblempresprocschedule where resourceId = ' + inttostr(ID), true);
  try
    REsult := Qry.fieldbyname('ctr').asInteger >0;
  finally
    DBSharedObj.ReleaseObj(Qry);
  end;

end;

(*procedure TProcResource.AustoRoster;
var
  Script :TERPScript;
begin
  Script := GetSharedScript('' , True);
  try
    script.SQL.clear;
    script.SQL.add('Delete from tblempresprocschedule where resourceId = ' + inttostr(ID)+';');

  finally
    DBSharedobj.ReleaseObj(script);
  end;
end;*)

constructor TProcResource.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Process Resource';
  fSQL := 'SELECT * FROM tblProcResource';
end;


destructor TProcResource.Destroy;
begin
  inherited;
end;


procedure TProcResource.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'ResourceName');
  SetPropertyFromNode(node,'ResourceAvailable');
  SetPropertyFromNode(node,'UsedWithProductsInSeq');
  SetPropertyFromNode(node,'ClosedOnPHs');
  SetPropertyFromNode(node,'Active');
  (* SetPropertyFromNode(node,'CapacityHoursDay'); *)
  SetPropertyFromNode(node,'SetupHoursDay');
  SetPropertyFromNode(node,'BreakdownHoursDay');
  SetPropertyFromNode(node,'HourlyLabourRate');
  SetPropertyFromNode(node,'HourlyOverheadRate');
  SetPropertyFromNode(node,'ResourceCount');
end;


procedure TProcResource.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'ResourceName' ,ResourceName);
  AddXMLNode(node,'ResourceAvailable' ,ResourceAvailable);
  AddXMLNode(node,'UsedWithProductsInSeq' ,UsedWithProductsInSeq);
  AddXMLNode(node,'ClosedOnPHs' ,ClosedOnPHs);
  AddXMLNode(node,'Active' ,Active);
  (* AddXMLNode(node,'CapacityHoursDay' ,CapacityHoursDay); *)
  AddXMLNode(node,'SetupHoursDay' ,SetupHoursDay);
  AddXMLNode(node,'BreakdownHoursDay' ,BreakdownHoursDay);
  AddXMLNode(node,'HourlyLabourRate' ,HourlyLabourRate);
  AddXMLNode(node,'HourlyOverheadRate' ,HourlyOverheadRate);
  AddXMLNode(node,'ResourceCount' ,ResourceCount);

//  SaveSubItemToXMLNode(node, Processes, 'Processes');
end;


function TProcResource.ValidateData: Boolean ;
var s: string;
begin
//  Result := true;
  Resultstatus.Clear;
  if (self.ResourceName = '') then begin
    s:= 'Resource name can not be blank';
    self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
    Result := False;
    SendEvent(BusObjEvent_GUIFocusField,'ResourceName');
    exit;
  (* end
  else if (Round(self.CapacityHoursDay - self.BreakdownHoursDay - self.SetupHoursDay,GeneralRoundPlaces) <= 0) then begin
    s:= 'Resource total available capacity hours must be greater than zero';
    self.ResultStatus.AddItem(false, rssInfo, BOR_General_Err, s);
    Result := False;
    SendEvent(BusObjEvent_GUIFocusField,'CapacityHours');
    exit; *)
  end;
  REsult := ProcResourceDays.Validatedata;
  if not result then exit;
  result:= ValidateResProcesses;
  if not result then exit;
  result:= ValidateResourceDetails;
end;

function TProcResource.Save: Boolean ;
begin
  Result := False;
  postdb;
  ProcResourceDays.POSTDB;
  if not ValidateData then Exit;
  (*if Assigned(self.fProcesses) then
    result:= fProcesses.Save;
  if result then*)
    Result := inherited Save;
end;
Procedure TProcResource.ValidateHrs(var hrs:Double;var StartAt:TTime; SetUp:double;Breakdown:Double;Change:String='Hr');
var
  SecondsInDay:Integer;
begin
  SecondsInDay :=24*60*60;
  if  hrs> SecondsInDay then hrs := SecondsInDay;
  if hrs+ breakdown+ setup + StartAt*SecondsInDay > SecondsInDay then begin
    if Change ='Hr' then
      Hrs:=SecondsInDay -(breakdown + setup + StartAt*SecondsInDay)
    else
      StartAt := (SecondsInDay-(Hrs-breakdown-setup))/SecondsInDay;
  end;
end;


procedure TProcResource.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if Assigned(fProcesses) then begin
    fProcesses.LoadSelect('ProcResourceId = '+ QuotedStr(IntToStr(Id)));
  end;
end;


procedure TProcResource.DoFieldOnChange(Sender: TField);
begin
      if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
          if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
      inherited;
{----}if (Sysutils.SameText(Sender.FieldName, 'AreaQty')) then begin

{----}end else if (Sysutils.SameText(Sender.FieldName, 'ResourceCount')) then begin
          PostDB;
          SendEvent(BusObjEvent_Change,BusObjEvent_ResourceCount);
{----}end else if (Sysutils.SameText(Sender.FieldName, 'ResourceName')) then begin
          PostDB;
          if Description = '' then Description := ResourceName;
          SendEvent(BusObjEvent_Change,BusObjEvent_ResourceName);
      end;
end;


function TProcResource.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProcResource.GetIDField: string;
begin
  Result := 'ProcResourceId'
end;

class function TProcResource.GetBusObjectTablename: string;
begin
  Result := 'tblProcResource';
end;


function TProcResource.getCleanHourlyLabourRate: Double;
begin
  result:= GetXMLNodeFloatValue(CleanXMLNode, 'HourlyLabourRate');
end;

function TProcResource.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;

  InitializeNewObject;
end;

function TProcResource.DoAfterPost(Sender: TDatasetBusObj): Boolean;
const Days : array[1..7] of string = ('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');

//function isMonday:Boolean;
//begin
//       if (Sametext(AppEnv.CompanyPrefs.StartWorkWeek , Days[3])) and (AppEnv.CompanyPrefs.noofweekenddays>=1) then result := False
//  else if (Sametext(AppEnv.CompanyPrefs.StartWorkWeek , Days[4])) and (AppEnv.CompanyPrefs.noofweekenddays>=2) then result := False
//  else if (Sametext(AppEnv.CompanyPrefs.StartWorkWeek , Days[5])) and (AppEnv.CompanyPrefs.noofweekenddays>=3) then result := False
//  else if (Sametext(AppEnv.CompanyPrefs.StartWorkWeek , Days[6])) and (AppEnv.CompanyPrefs.noofweekenddays>=4) then result := False
//  else if (Sametext(AppEnv.CompanyPrefs.StartWorkWeek , Days[7])) and (AppEnv.CompanyPrefs.noofweekenddays>=5) then result := False
//  else if (Sametext(AppEnv.CompanyPrefs.StartWorkWeek , Days[1])) and (AppEnv.CompanyPrefs.noofweekenddays>=6) then result := False
//  else if (Sametext(AppEnv.CompanyPrefs.StartWorkWeek , Days[2])) and (AppEnv.CompanyPrefs.noofweekenddays>=7) then result := False
//  else result := True;
//end;
  function isDayWeekend(Dayno:Integer):boolean;
  var
    ctr:Integer;
  begin
    REsult := False;
    if dayno = 7 then dayno := 1 else dayno := dayno +1;
    for ctr:= low(days) to high(days) do begin
      if (Sametext(AppEnv.CompanyPrefs.StartWorkWeek , Days[Dayno])) and (AppEnv.CompanyPrefs.noofweekenddays>=ctr) then begin
        result := True;
        Exit;
      end;
      if dayno = 7 then dayno := 1 else dayno := dayno +1;
    end;
  end;
Procedure UpdateREsourceDetails;
var
  ctr:Integer;
begin
  for ctr:= ProcResourceDetails.count+1 to ResourceCount do begin
    if ResourceName <> '' then begin
      ProcResourceDetails.New;
      ProcResourceDetails.Description := ResourceName +'-' + inttostr(ctr);
      ProcResourceDetails.active := Active;
      ProcResourceDetails.ResourceAvailable := ResourceAvailable;
      ProcResourceDetails.ClosedOnPHs := ClosedOnPHs;
      ProcResourceDetails.PostDB;
    end;
  end;
  for ctr:= ProcResourceDetails.count downto ResourceCount+1 do begin
      ProcResourceDetails.Last;
      ProcResourceDetails.Delete;
  end;
end;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;

  if ProcResourceDays.count =0 then begin
    ProcResourceDays.New;
    ProcResourceDays.Monday   := not(isDayWeekend(2));//not(Sametext(AppEnv.CompanyPrefs.StartWorkWeek , 'Tuesday') or Sametext(AppEnv.CompanyPrefs.StartWorkWeek , 'Wednesday'));
    ProcResourceDays.Tuesday  := not(isDayWeekend(3));//not(Sametext(AppEnv.CompanyPrefs.StartWorkWeek , 'Wednesday') or Sametext(AppEnv.CompanyPrefs.StartWorkWeek , 'Thursday'));
    ProcResourceDays.Wednesday:= not(isDayWeekend(4));//not(Sametext(AppEnv.CompanyPrefs.StartWorkWeek , 'Thursday') or Sametext(AppEnv.CompanyPrefs.StartWorkWeek , 'Friday'));
    ProcResourceDays.Thursday := not(isDayWeekend(5));//not(Sametext(AppEnv.CompanyPrefs.StartWorkWeek , 'Friday') or Sametext(AppEnv.CompanyPrefs.StartWorkWeek , 'Saturday'));
    ProcResourceDays.Friday   := not(isDayWeekend(6));//not(Sametext(AppEnv.CompanyPrefs.StartWorkWeek , 'Saturday') or Sametext(AppEnv.CompanyPrefs.StartWorkWeek , 'Sunday'));
    ProcResourceDays.Saturday := not(isDayWeekend(7));//not(Sametext(AppEnv.CompanyPrefs.StartWorkWeek , 'Sunday') or Sametext(AppEnv.CompanyPrefs.StartWorkWeek , 'Monday'));
    ProcResourceDays.Sunday   := not(isDayWeekend(1));//not(Sametext(AppEnv.CompanyPrefs.StartWorkWeek , 'Monday') or Sametext(AppEnv.CompanyPrefs.StartWorkWeek , 'Tuesday'));
    ProcResourceDays.PostDB;
  end;

  UpdateREsourceDetails;

end;

{Property functions}
function  TProcResource.GetDescription       : string    ; begin Result := GetStringField('Description');end;
function  TProcResource.GetResourceName      : string    ; begin Result := GetStringField('ResourceName');end;
function  TProcResource.GetResourceAvailable : Boolean   ; begin Result := GetBooleanField('ResourceAvailable');end;
function  TProcResource.GetUsedWithProductsInSeq: Boolean   ; begin Result := GetBooleanField('UsedWithProductsInSeq');end;
function  TProcResource.GetClosedOnPHs       : Boolean   ; begin Result := GetBooleanField('ClosedOnPublicHolidays');end;
function  TProcResource.GetActive : Boolean   ; begin Result := GetBooleanField('Active');end;
(* function  TProcResource.GetCapacityHoursDay  : Double    ; begin Result := GetFloatField('CapacityHoursDay');end; *)
function  TProcResource.GetSetupHoursDay     : Double    ; begin Result := GetFloatField('SetupHoursDay');end;
function  TProcResource.GetBreakdownHoursDay : Double    ; begin Result := GetFloatField('BreakdownHoursDay');end;
function  TProcResource.GetHourlyLabourRate  : Double    ; begin Result := GetFloatField('HourlyLabourRate');end;
function  TProcResource.GetHourlyOverheadRate: Double    ; begin Result := GetFloatField('HourlyOverheadRate');end;
function  TProcResource.GetResourceCount     : Integer   ; begin Result := GetIntegerField('ResourceCount');end;

procedure TProcResource.SetDescription       (const Value: string    ); begin SetStringField('Description'        , Value);end;
procedure TProcResource.SetResourceName      (const Value: string    ); begin SetStringField('ResourceName'       , Value);end;
procedure TProcResource.SetResourceAvailable (const Value: Boolean   ); begin SetBooleanField('ResourceAvailable'       , Value);end;
procedure TProcResource.SetUsedWithProductsInSeq (const Value: Boolean   ); begin SetBooleanField('UsedWithProductsInSeq'       , Value);end;
procedure TProcResource.SetClosedOnPHs       (const Value: Boolean   ); begin SetBooleanField('ClosedOnPublicHolidays'       , Value);end;
procedure TProcResource.SetActive (const Value: Boolean   ); begin SetBooleanField('Active'       , Value);end;
(* procedure TProcResource.SetCapacityHoursDay  (const Value: Double    ); begin SetFloatField('CapacityHoursDay'   , Value);end; *)
procedure TProcResource.SetSetupHoursDay     (const Value: Double    ); begin SetFloatField('SetupHoursDay'      , Value);end;
procedure TProcResource.SetBreakdownHoursDay (const Value: Double    ); begin SetFloatField('BreakdownHoursDay'      , Value);end;
procedure TProcResource.SetHourlyLabourRate  (const Value: Double    ); begin SetFloatField('HourlyLabourRate'   , Value);end;
procedure TProcResource.SetHourlyOverheadRate(const Value: Double    ); begin SetFloatField('HourlyOverheadRate'   , Value);end;
procedure TProcResource.SetResourceCount     (const Value: Integer   ); begin SetIntegerField('ResourceCount'   , Value);end;



function TProcResource.GetProcesses: TProcResourceProcess;
begin
  if not Assigned(fProcesses) then
    fProcesses:= TProcResourceProcess.Create(self);
  if (not fProcesses.Dataset.Active) or (fProcesses.ProcResourceId <> self.Id) then
    fProcesses.LoadSelect('ProcResourceId = '+ QuotedStr(IntToStr(Id)));

  result:= fProcesses;
end;


function TProcResource.getProcResourceDays: TProcResourceDays;
begin
  REsult :=   TProcResourceDays(getcontainercomponent(TProcResourceDays , 'procresourceID = ' +inttostr(ID)));
end;

function TProcResource.getProcResourceDetails: TProcResourceDetails;
begin
  Result :=   TProcResourceDetails(getcontainercomponent(TProcResourceDetails , 'ProcResourceId = ' +inttostr(ID)));
end;

procedure TProcResource.InitializeNewObject;
begin
  inherited;
  if self.Id < 1 then
    self.PostDb;
end;
procedure TProcResource.ValidateResProcessesCallback(Const Sender: TBusObj; var Abort: boolean);
begin
  if not(Sender is TProcResourceProcess) then exit;
  if TProcResourceProcess(Sender).Validatedata = False then begin
      AllLinesValied:= False;
      Abort:= true;
      Exit;
  end;
end;
procedure TProcResource.ValidateResourceDetailsCallback(Const Sender: TBusObj; var Abort: boolean);
begin
  if not(Sender is TProcResourceDetails) then exit;
  if TProcResourceDetails(Sender).Validatedata = False then begin
      AllLinesValied:= False;
      Abort:= true;
      Exit;
  end;
end;
function TProcResource.ValidateResourceDetails: boolean;
begin
  AllLinesValied:= True;
  ProcresourceDetails.IterateRecords(ValidateResourceDetailsCallback);
  result:= AllLinesValied;
end;
function TProcResource.ValidateResProcesses: boolean;
begin
  AllLinesValied:= True;
  Processes.IterateRecords(ValidateResProcessesCallback);
  result:= AllLinesValied;
(*var
  bm: TBookmark;
  IdList: TIntegerList;
  ResName: string;
begin
  result:= true;
  if self.Processes.Count > 0 then begin
    IdList:= TIntegerList.Create;
    try
      Processes.Dataset.DisableControls;
      try
        bm:= Processes.Dataset.GetBookmark;
        try
          Processes.First;
          while not Processes.EOF do begin
            if not Processes.ValidateData then begin
              result:= false;
              break;
            end;
            if IdList.InList(Processes.ProcessStepId) then begin
              result:= false;
              self.ResultStatus.AddItem(false,rssInfo,0,
              'The same Process Step (' + Processes.ProcessStepDescription +
              ') can only be used for a Resource once.');
              break;
            end
            else
              IdList.Add(Processes.ProcessStepId);
            Processes.Next;
          end;
        finally
          Processes.Dataset.GotoBookmark(bm);
          Processes.Dataset.FreeBookmark(bm);
         end;
      finally
        Processes.Dataset.EnableControls;
      end;
      { now check that this process step has not been used for a different resource }
      if ProcessUsedByOtherResource(IdList, ResName) then begin
        result:= false;
        self.ResultStatus.AddItem(false,rssInfo,0,
         'Process step(s) have already been assigned to Resource: "' + ResName + '"');
      end;
    finally
      IdList.Free;
    end;
  end;*)
end;

function TProcResource.ProcessUsedByOtherResource(ProcessStepIdList: TIntegerList; var ResourceName: string): boolean;
begin
   result:= ProcessUsedByOtherResource(ProcessStepIdList.CommaText , ResourceName);
end;
function TProcResource.ProcessUsedByOtherResource(ProcessStepId: Integer; var ResourceName: string): boolean;
begin
  result:= ProcessUsedByOtherResource(inttostr(ProcessStepId) , ResourceName);
end;

function TProcResource.ProcessUsedByOtherResource(ProcessStepIds:String; var ResourceName: string): boolean;
var
  qry: TERPQuery;
begin
  result:= false;
  if ProcessStepIds = '' then begin
    result:= TRue;
    exit;
  end;
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= self.Connection.Connection;
    qry.SQL.Text:=
      'SELECT * FROM tblProcResourceProcess RP, tblProcResource R' +
      ' WHERE R.ProcResourceId = RP.ProcResourceId' +
      ' AND R.Active = "T"' +
      ' AND RP.ProcResourceId <> ' + IntToStr(self.Id) +
      ' AND RP.ProcessStepId IN (' + ProcessStepIds + ')';

    qry.Open;
    if qry.RecordCount > 0 then begin
      result:= true;
      ResourceName:= qry.fieldByName('ResourceName').AsString;
    end;
  finally
    qry.Free;
  end;
end;

class function TProcResource.ResourceForProcess(const aProcessStepID: Integer): Integer;
var
  ProcResource : TProcResource;
begin
  ProcResource := TProcResource.CreateWithNewConn(nil);
  try
    ProcResource.load(ProcesstepResourceID(aProcessStepID));
    if ProcResource.count =0 then ProcResource.loadselect('ResourceName =' +Quotedstr(Processtep( aProcessStepID)));
    if ProcResource.count =0 then begin
      ProcResource.New;
      ProcResource.Resourcename := Processtep( aProcessStepID);
      ProcResource.ResourceCount := 1;
      ProcResource.PostDB;
    end;
    if not ProcResource.Processes.locate('ProcessStepId' , aProcessStepID , []) then begin
      ProcResource.Processes.new;
      ProcResource.Processes.ProcessStepId := aProcessStepID;
      ProcResource.Processes.PostDb;
    end;
  finally
    result := ProcResource.ID;
    Freeandnil(ProcResource);
  end;
end;

{TProcResourceProcess}

constructor TProcResourceProcess.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblprocresourceprocess';
  fBusObjectTypeDescription:= 'Process Resource Process Step';
end;


destructor TProcResourceProcess.Destroy;
begin
  inherited;
end;


procedure TProcResourceProcess.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProcessStepId');
  SetPropertyFromNode(node,'ProcessStepDescription');
  SetPropertyFromNode(node,'ProcResourceId');
  SetPropertyFromNode(node,'NoOfEmployeesReqd');
  SetPropertyFromNode(node,'Active');
end;


procedure TProcResourceProcess.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProcessStepId' ,ProcessStepId);
  AddXMLNode(node,'ProcessStepDescription' ,ProcessStepId);
  AddXMLNode(node,'ProcResourceId' ,ProcessStepId);
  AddXMLNode(node,'NoOfEmployeesReqd' ,NoOfEmployeesReqd);
  AddXMLNode(node,'Active' ,Active);
end;


function TProcResourceProcess.ValidateData: Boolean ;
var
  s: string;
  ResName:String;
begin
  Result := true;
  Resultstatus.Clear;
  if Active then begin
    if (self.ProcessStepId < 1) then begin
      s:= 'No process step selected';
      self.ResultStatus.AddItem(false, rssError, BOR_General_Err, s);
      Result := False;
      exit;
    end;
    if not(ISunique(ID, 'ProcessStepId = ' + inttostr(ProcessStepId), connection.Connection)) then begin
      Result:= False;
      self.AddResult(false, rssWarning, 0, 'Record already exists for ' + Quotedstr(ProcessStep.Description ));
      Exit;
    end;
    if Assigned(Owner) and (Owner is TProcResource) then
    if TProcResource(Owner).ProcessUsedByOtherResource(ID, ResName) then begin
          result:= false;
          self.ResultStatus.AddItem(false,rssInfo,0,'Process step(s) have already been assigned to Resource: "' + ResName + '"');
          exit;
    end;
  end;
end;


function TProcResourceProcess.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProcResourceProcess.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TProcResourceProcess.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName , 'NoOfEmployeesReqd') then begin
    if NoOfEmployeesReqd <=0 then NoOfEmployeesReqd := 1;
  end;
end;


function TProcResourceProcess.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProcResourceProcess.GetIDField: string;
begin
  Result := 'ProcResourceProcessId'
end;

function TProcResourceProcess.getNoOfEmployeesReqd: Integer;
begin
  Result := getIntegerfield('NoOfEmployeesReqd');
end;

class function TProcResourceProcess.GetBusObjectTablename: string;
begin
  Result := 'tblprocresourceprocess';
end;

function TProcResourceProcess.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property functions}
function  TProcResourceProcess.GetProcessStepId    : Integer;  begin Result := GetIntegerField('ProcessStepId'); end;
procedure TProcResourceProcess.SetProcessStepId    (const Value: Integer);  begin SetIntegerField('ProcessStepId', Value); end;
function  TProcResourceProcess.GetProcResourceId   : Integer;  begin Result := GetIntegerField('ProcResourceId'); end;
procedure TProcResourceProcess.SetProcResourceId   (const Value: Integer);  begin SetIntegerField('ProcResourceId', Value); end;


function TProcResourceProcess.GetProcessStep: TProcessStep;
begin
  if not Assigned(fProcessStep) then
    fProcessStep:= TProcessStep.Create(self);
  if fProcessStep.Id <> ProcessStepId then
    fProcessStep.Load(ProcessStepId);
  result:= fProcessStep;
end;

function TProcResourceProcess.GetProcResource: TProcResource;
begin
  if (Owner is TProcResource) then
    result:= TProcResource(Owner)
  else begin
    if not Assigned(fProcResource) then
      fProcResource:= TProcResource.Create(self);
    if fProcResource.Id <> ProcResourceId then
      fProcResource.Load(ProcResourceId);
    result:= fProcResource;
  end;
end;

function TProcResourceProcess.GetProcessStepDescription: string;
begin
  result:= ProcessStep.Description;
end;

procedure TProcResourceProcess.SetProcessStepDescription(
  const Value: string);
begin
  if ProcessStep.Description <> Value then begin
    ProcessStep.LoadSelect('Description = ' + QuotedStr(Value));
    ProcessStepId:= ProcessStep.Id;
  end;
end;

function TProcResourceProcess.DoNewRecord(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoNewRecord(Sender);
  if result and Assigned(Owner) and (Owner is TProcResource) then begin
    self.ProcResourceId := TProcResource(Owner).Id;
    TProcResource(Owner).FlagAsUpdated;
  end;
end;

function TProcResourceProcess.DoAfterDelete(
  Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterDelete(Sender);
  if result and Assigned(Owner) and (Owner is TMSBusObj) then
      TMSBusObj(Owner).FlagAsUpdated;
end;

function TProcResourceProcess.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  NoOfEmployeesReqd := 1;
  if Assigned(Owner) and (Owner is TProcResource) then
    self.ProcResourceId:= TProcResource(Owner).Id;
end;

function TProcResourceProcess.DoBeforeEdit(
  Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoBeforeEdit(Sender);
  if result and Assigned(Owner) and (Owner is TMSBusObj) then
      TMSBusObj(Owner).FlagAsUpdated;
end;

function TProcResourceProcess.DoBeforePost(Sender: TDatasetBusobj): Boolean;
begin
  result:= inherited DoBeforePost(Sender);
  if not result then exit;
  if not(ISunique(ID, 'ProcessStepId = ' + inttostr(ProcessStepId))) then begin
    Result:= False;
    self.AddResult(false, rssWarning, 0, 'Record already exists for ' + Quotedstr(ProcessStep.Description ));
    Abort;
    Exit;
  end;
end;

procedure TProcResourceProcess.InitializeNewObject;
begin
  inherited;
  if Assigned(Owner) and (Owner is TProcResource) then
    self.ProcResourceId:= TProcResource(Owner).Id;
end;

procedure TProcResourceProcess.New;
begin
  inherited;
  InitializeNewObject;
end;

function TProcResourceProcess.GetActive: boolean;
begin
  result:= GetBooleanField('Active');
end;

procedure TProcResourceProcess.SetActive(const Value: boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TProcResourceProcess.setNoOfEmployeesReqd(const Value: Integer);
begin
  SetIntegerField('NoOfEmployeesReqd', Value);
end;

{ TProcResourceProcessDetails }

constructor TProcResourceProcessDetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL:= 'Select PR.*,PRP.ProcessStepid from tblProcResource  PR inner join tblProcResourceProcess PRP on PRP.ProcResourceId = PR.ProcResourceId ';
end;

function TProcResourceProcessDetails.getProcessStepid: Integer;
begin
  REsult := GetIntegerField('ProcessStepid');
end;
function TProcResourceProcessDetails.getProcResource: TProcResource;
begin
  Result :=   TProcResource(getcontainercomponent(TProcResource , IDFieldName +' = ' +inttostr(ID)));
end;

{this is a readonly object }
procedure TProcResourceProcessDetails.SetBreakdownHoursDay  (const Value: Double);begin (*inherited*)end;
{procedure TProcResourceProcessDetails.SetCapacityHoursDay   (const Value: Double);begin (*inherited*)end;}
procedure TProcResourceProcessDetails.SetDescription        (const Value: string);begin (*inherited*)end;
procedure TProcResourceProcessDetails.SetHourlyLabourRate   (const Value: Double);begin (*inherited*)end;
procedure TProcResourceProcessDetails.SetHourlyOverheadRate (const Value: Double);begin (*inherited*)end;
procedure TProcResourceProcessDetails.SetResourceAvailable  (const Value: Boolean);begin (*inherited*)end;
procedure TProcResourceProcessDetails.SetClosedOnPHs        (const Value: Boolean);begin (*inherited*)end;
procedure TProcResourceProcessDetails.SetResourceName       (const Value: string);begin   (*inherited*)end;
Procedure TProcResourceProcessDetails.SetResourceCount(Const Value:Integer);begin   (*inherited*)end;
procedure TProcResourceProcessDetails.SetActive     (const Value: Boolean   );begin   (*inherited*)end;


procedure TProcResourceProcessDetails.SetSetupHoursDay(
  const Value: Double);
begin
  inherited;

end;
  {TProcResourceUnAvailability}

constructor TProcResourceUnAvailability.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ProcResourceUnAvailability';
  fSQL := 'SELECT * FROM tblprocresourceunavailability';
end;


destructor TProcResourceUnAvailability.Destroy;
begin
  inherited;
end;


procedure TProcResourceUnAvailability.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProcResourceId');
  SetPropertyFromNode(node,'ProcResourceDetailId');
  SetPropertyFromNode(node,'Description');
  SetDateTimePropertyFromNode(node,'TimeStart');
  SetDateTimePropertyFromNode(node,'TimeEnd');
end;


procedure TProcResourceUnAvailability.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProcResourceId' ,ProcResourceId);
  AddXMLNode(node,'ProcResourceDetailId' ,ProcResourceDetailId);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'TimeStart' ,TimeStart);
  AddXMLNode(node,'TimeEnd' ,TimeEnd);
end;


function TProcResourceUnAvailability.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if ProcResourceId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ProcResourceId should not be 0' , False );
    Exit;
  end;
  if ProcResourceDetailId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ProcResourceDetailId should not be 0' , False );
    Exit;
  end;
  if TimeStart = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'TimeStart should not be blank' , False );
    Exit;
  end;
  if TimeEnd = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'TimeEnd should not be blank' , False );
    Exit;
  end;
  if Description = ''  then begin
    Resultstatus.AddItem(False , rssError , 0,  'Description should not be blank' , False );
    Exit;
  end;
  Result := True;
end;


function TProcResourceUnAvailability.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProcResourceUnAvailability.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TProcResourceUnAvailability.DoFieldOnChange(Sender: TField);
begin
      if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
          if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
      inherited;
{----}if (Sysutils.SameText(Sender.FieldName, 'TimeStart')) then begin
        if (TimeEnd > TimeStart) or (Timeend =0) then Timeend := Dayend(timestart);
{----}end else if (Sysutils.SameText(Sender.FieldName, 'TimeEnd')) then begin
        if (TimeEnd > TimeStart) or (TimeStart =0) then TimeStart := DayStart(TimeEnd);
      end;
end;


function TProcResourceUnAvailability.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProcResourceUnAvailability.GetIDField: string;
begin
  Result := 'ProcResourceUnAvailabilityId'
end;


class function TProcResourceUnAvailability.GetBusObjectTablename: string;
begin
  Result:= 'tblprocresourceunavailability';
end;


function TProcResourceUnAvailability.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not(Result) then exit;
  if Assigned(Owner) then
    if Owner is  TProcResourceDetails then begin
      ProcResourceDetailId := TProcResourceDetails(Owner).ID;
      ProcResourceId := TProcResourceDetails(Owner).ProcResourceId;
    end;
end;

function TProcResourceUnAvailability.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not(Result) then exit;
  if (Description='') and (TimeStart=0) and (TimeEnd=0) then Delete;
end;


{Property Functions}
function  TProcResourceUnAvailability.GetProcResourceId              : Integer   ; begin Result := GetIntegerField('ProcResourceId');end;
function  TProcResourceUnAvailability.GetProcResourceDetailId        : Integer   ; begin Result := GetIntegerField('ProcResourceDetailId');end;
function  TProcResourceUnAvailability.GetDescription                 : string    ; begin Result := GetStringField('Description');end;
function  TProcResourceUnAvailability.GetTimeStart                   : TDateTime ; begin Result := GetDateTimeField('TimeStart');end;
function  TProcResourceUnAvailability.GetTimeEnd                     : TDateTime ; begin Result := GetDateTimeField('TimeEnd');end;
procedure TProcResourceUnAvailability.SetProcResourceId              (const Value: Integer   ); begin SetIntegerField('ProcResourceId'               , Value);end;
procedure TProcResourceUnAvailability.SetProcResourceDetailId        (const Value: Integer   ); begin SetIntegerField('ProcResourceDetailId'         , Value);end;
procedure TProcResourceUnAvailability.SetDescription                 (const Value: string    ); begin SetStringField('Description'                  , Value);end;
procedure TProcResourceUnAvailability.SetTimeStart                   (const Value: TDateTime ); begin SetDateTimeField('TimeStart'                    , Value);end;
procedure TProcResourceUnAvailability.SetTimeEnd                     (const Value: TDateTime ); begin SetDateTimeField('TimeEnd'                      , Value);end;

  {TProcResourceDetails}
constructor TProcResourceDetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ProcResourceDetails';
  fSQL := 'SELECT * FROM tblprocresourcedetails';
end;


destructor TProcResourceDetails.Destroy;
begin
  inherited;
end;


procedure TProcResourceDetails.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProcResourceId');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'FixedAssetID');
  SetPropertyFromNode(node,'UOMQty');
  SetPropertyFromNode(node,'UOMMult');
  SetPropertyFromNode(node,'NoOfResources');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'FixedAsset');
  SetBooleanPropertyFromNode(node,'ResourceAvailable');
  SetBooleanPropertyFromNode(node,'ClosedOnPublicHolidays');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TProcResourceDetails.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProcResourceId' ,ProcResourceId);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'FixedAssetID' ,FixedAssetID);
  AddXMLNode(node,'UOMQty' ,UOMQty);
  AddXMLNode(node,'UOMMult' ,UOMMult);
  AddXMLNode(node,'NoOfResources' ,NoOfResources);
  AddXMLNode(node,'UOMID' ,UOMID);
  AddXMLNode(node,'FixedAsset' ,FixedAsset);
  AddXMLNode(node,'ResourceAvailable' ,ResourceAvailable);
  AddXMLNode(node,'ClosedOnPHs' ,ClosedOnPHs);
  AddXMLNode(node,'Active' ,Active);
end;
function TProcResourceDetails.TotNoOfResourcesinProduct:Integer;
begin
  result := tcdatautils.TotNoOfResourcesinProduct(ID, connection.connection);
end;
function TProcResourceDetails.ValidateData: Boolean ;
var
  fiTotNoOfResources:Integer;
begin
  Result := False;
  Resultstatus.Clear;
  if ProcResourceId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ProcResourceId should not be 0' , False );
    Exit;
  end;

  Result := ValidateProcResourceProducts;
  if not result then exit;

  fiTotNoOfResources := TotNoOfResourcesinProduct;
  if (NoOfResources>0) and (fiTotNoOfResources > NoOfResources) then begin
    Resultstatus.AddItem(False , rssError , 0,  'Total ' +inttostr(fitotNoOfResources) +' found in Products and only '+ floattostr(NoOfResources) +' Resouses Available.', False );
    Exit;
  end;
end;

function TProcResourceDetails.ValidateProcResourceProducts:Boolean;
begin
  //TotNoOfResources := 0;
  AlllinesValid:= true;
  ProcResourceProductClean.PostDB;
  ProcResourceProductClean.IterateREcords(ValidateProcResourceProductsCallback);
  ProcResourceProducts.PostDB;
  ProcResourceProducts.IterateREcords(ValidateProcResourceProductsCallback);
  Result := AlllinesValid;
end;
Procedure TProcResourceDetails.ValidateProcResourceProductsCallback(Const Sender: TBusObj; var Abort: boolean);
begin
  if Sender is  TProcResourceProducts then begin
    if not TProcResourceProducts(Sender).validatedata then begin
      AlllinesValid:= False;
      Abort := TRue;
      Exit;
    end;
    //TotNoOfResources := TotNoOfResources + TProcResourceProducts(Sender).NoOfResources;
  end;
end;

function TProcResourceDetails.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProcResourceDetails.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  ProcResourceProducts.closedb;
  ProcResourceUnAvailability.closedb;
  ProcResourceProducts;
  ProcResourceUnAvailability;
end;


procedure TProcResourceDetails.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TProcResourceDetails.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProcResourceDetails.GetIDField: string;
begin
  Result := 'ID'
end;


class function TProcResourceDetails.GetBusObjectTablename: string;
begin
  Result:= 'tblprocresourcedetails';
end;


function TProcResourceDetails.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if Owner is TProcResource then begin
      ProcResourceId := TProcResource(Owner).Id;
    end;
end;

function TProcResourceDetails.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
end;


function TProcResourceDetails.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if Owner is TProcResource then begin
      TProcResource(Owner).ResourceCount := TProcResource(Owner).ResourceCount-1;
      TProcResource(Owner).PostDB;
    end;

end;

{Property Functions}
function  TProcResourceDetails.GetProcResourceId   : Integer   ; begin Result := GetIntegerField('ProcResourceId'   );end;
function  TProcResourceDetails.GetDescription      : string    ; begin Result := GetStringField('Description'       );end;
function  TProcResourceDetails.GetFixedAssetID     : Integer   ; begin Result := GetIntegerField('FixedAssetID'     );end;
function  TProcResourceDetails.GetUOMQty           : Double    ; begin Result := GetFloatField('UOMQty'             );end;
function  TProcResourceDetails.GetUOMMult          : Double    ; begin Result := GetFloatField('UOMMult'            );end;
function  TProcResourceDetails.GetNoOfResources    : Integer   ; begin Result := GetIntegerField('NoOfResources'    );end;
function  TProcResourceDetails.GetUOMID            : Integer   ; begin Result := GetIntegerField('UOMID'            );end;
function  TProcResourceDetails.GetFixedAsset       : string    ; begin Result := GetStringField('FixedAsset'        );end;
function  TProcResourceDetails.GetResourceAvailable: Boolean   ; begin Result := GetBooleanField('ResourceAvailable');end;
function  TProcResourceDetails.GetUsedWithProductsInSeq: Boolean   ; begin Result := False; if Assigned(Owner) then if owner is TProcResource then result := TProcResource(Owner).UsedWithProductsInSeq;end;
function  TProcResourceDetails.GetClosedOnPHs      : Boolean   ; begin Result := GetBooleanField('ClosedOnPublicHolidays');end;
function  TProcResourceDetails.GetActive           : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TProcResourceDetails.SetProcResourceId   (const Value: Integer   ); begin SetIntegerField('ProcResourceId'    , Value);end;
procedure TProcResourceDetails.SetDescription      (const Value: string    ); begin SetStringField('Description'       , Value);end;
procedure TProcResourceDetails.SetFixedAssetID     (const Value: Integer   ); begin SetIntegerField('FixedAssetID'      , Value);end;
procedure TProcResourceDetails.SetUOMQty           (const Value: Double    ); begin SetFloatField('UOMQty'      , Value);end;
procedure TProcResourceDetails.SetUOMMult          (const Value: Double    ); begin SetFloatField('UOMMult'      , Value);end;
procedure TProcResourceDetails.SetNoOfResources    (const Value: Integer   ); begin SetIntegerField('NoOfResources'      , Value);end;
procedure TProcResourceDetails.SetUOMID            (const Value: Integer   ); begin SetIntegerField('UOMID'      , Value);end;
procedure TProcResourceDetails.SetFixedAsset       (const Value: string    ); begin SetStringField('FixedAsset'        , Value);end;
procedure TProcResourceDetails.SetResourceAvailable(const Value: Boolean   ); begin SetBooleanField('ResourceAvailable' , Value);end;
procedure TProcResourceDetails.SetClosedOnPHs      (const Value: Boolean   ); begin SetBooleanField('ClosedOnPublicHolidays' , Value);end;
procedure TProcResourceDetails.SetActive           (const Value: Boolean   ); begin SetBooleanField('Active'            , Value);end;

function TProcResourceDetails.getProcResourceUnAvailability: TProcResourceUnAvailability;
begin
  REsult :=   TProcResourceUnAvailability(getcontainercomponent(TProcResourceUnAvailability , 'ProcResourceDetailId = ' +inttostr(ID)));
end;
function TProcResourceDetails.getProcResourceProducts: TProcResourceProductList;
begin
  REsult :=   TProcResourceProductList(getcontainercomponent(TProcResourceProductList , 'ProcresourcedetailID = ' +inttostr(ID)+' and Seqno >1'));
end;
function TProcResourceDetails.getProcResourceProductclean: TProcResourceProductClean;
begin
  REsult :=   TProcResourceProductClean(getcontainercomponent(TProcResourceProductClean , 'ProcresourcedetailID = ' +inttostr(ID)+' and Seqno =1'));
end;


  {TProcResourceProducts}

constructor TProcResourceProducts.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ProcResourceProducts';
  fSQL := 'SELECT * FROM tblprocresourceProducts';
  SQLOrder := 'Seqno';
  updatingNoOfResources := False;
end;


destructor TProcResourceProducts.Destroy;
begin
  inherited;
end;


procedure TProcResourceProducts.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProcresourcedetailID');
  SetPropertyFromNode(node,'ProductId');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'Seqno');
  SetPropertyFromNode(node,'NoOfResources');
  SetBooleanPropertyFromNode(node,'Active');
  SetDatetimePropertyFromNode(node,'ResourceDate');

end;


procedure TProcResourceProducts.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProcresourcedetailID' ,ProcresourcedetailID);
  AddXMLNode(node,'ProductId' ,ProductId);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'Seqno' ,Seqno);
  AddXMLNode(node,'NoOfResources' ,NoOfResources);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'ResourceDate' ,ResourceDate);
end;


function TProcResourceProducts.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if ProcresourcedetailID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ProcresourcedetailID should not be 0' , False );
    Exit;
  end;
  if ProductId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ProductId should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TProcResourceProducts.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProcResourceProducts.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TProcResourceProducts.DoFieldOnChange(Sender: TField);
begin
      if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
          if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
      inherited;
{----}if (Sysutils.SameText(Sender.FieldName, 'ProductName')) then begin
        ProductID := TProductsimple.IDToggle(ProductName);
        DoFieldOnChange(Dataset.findfield('ProductID'));
{----}end else if (Sysutils.SameText(Sender.FieldName, 'ProductID')) then begin
        if not TProcResourceProducts.IsUnique(ID, 'ProductId = ' + inttostr(ProductId)+' and ProcresourcedetailID ='+ inttostr(ProcresourcedetailID)) then begin
          SendEvent(BusObjEvent_Change,BusObjEventVal_DuplicateProduct);
          ProductID := 0;
          Productname := '';
        end;
      end;

end;


function TProcResourceProducts.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProcResourceProducts.GetIDField: string;
begin
  Result := 'ID'
end;


class function TProcResourceProducts.GetBusObjectTablename: string;
begin
  Result:= 'tblprocresourceProducts';
end;


function TProcResourceProducts.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  Active := True;
  if Assigned(Owner) then
    if Owner is  TProcResourceDetails then begin
      ProcResourceDetailId := TProcResourceDetails(Owner).ID;
    end;
  Seqno := LastSeqno+1;
  ResourceDate := Date;
end;
function TProcResourceProducts.LastSeqno:Integer;
var
  Qry :TERPQuery;
begin
  Qry := SharedQuery;
  try
     commondblib.Closedb(Qry);
     Qry.sql.text := 'Select max(Seqno) LastSeqno  '+
                     ' from tblprocresourceProducts   '+
                     ' where ProcresourcedetailID = ' + inttostr(ProcResourceDetailId) +
                     ' and ID<>'+ inttostr(ID);
     commondblib.Opendb(Qry);
     result := Qry.Fieldbyname('LastSeqno').asInteger;
  finally
     DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
function TProcResourceProducts.TotNoOfResourcesinProduct:Integer;
begin
  result := tcdatautils.TotNoOfResourcesinProduct(ProcresourcedetailID, connection.connection);
end;
function TProcResourceProducts.TotNoOfResources :Integer;
begin
  REsult := NoOfResources;
  if assigned(Owner) then
    if Owner is TProcResourceDetails then
      result := TProcResourceDetails(Owner).NoOfResources;
end;
function TProcResourceProducts.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  if updatingNoOfResources then exit;
  updatingNoOfResources:= true;
  try
  if ProductId =0 then begin
    Delete;
    Exit;
  end;
  if TotNoOfResources < TotNoOfResourcesinProduct then begin
    NoOfResources := TotNoOfResources -   tcdatautils.TotNoOfResourcesinProduct(ProcresourcedetailID, connection.connection, ID);
    PostDB;
  end;
  finally
    updatingNoOfResources:= False;
  end;
end;


{Property Functions}
function  TProcResourceProducts.GetProcresourcedetailID : Integer   ; begin Result := GetIntegerField('ProcresourcedetailID');end;
function  TProcResourceProducts.GetProductId            : Integer   ; begin Result := GetIntegerField('ProductId');end;
function  TProcResourceProducts.GetProductName          : string    ; begin Result := GetStringField('ProductName');end;
function  TProcResourceProducts.GetSeqno                : Integer   ; begin Result := GetIntegerField('Seqno');end;
function  TProcResourceProducts.GetResourceDate         : TDateTime ; begin Result := GetDateTimeField('ResourceDate');end;
function  TProcResourceProducts.GetNoOfResources        : Integer   ; begin Result := GetIntegerField('NoOfResources');end;
function  TProcResourceProducts.GetActive               : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TProcResourceProducts.SetProcresourcedetailID (const Value: Integer   ); begin SetIntegerField('ProcresourcedetailID' , Value);end;
procedure TProcResourceProducts.SetProductId            (const Value: Integer   ); begin SetIntegerField('ProductId'             , Value);end;
procedure TProcResourceProducts.SetProductName          (const Value: string    ); begin SetStringField('ProductName'            , Value);end;
procedure TProcResourceProducts.SetSeqno                (const Value: Integer   ); begin SetIntegerField('Seqno'                , Value);end;
procedure TProcResourceProducts.SetResourceDate         (const Value: TDatetime ); begin SetDAtetimeField('ResourceDate'         , Value);end;
procedure TProcResourceProducts.SetNoOfResources        (const Value: Integer   ); begin SetIntegerField('NoOfResources'        , Value);end;
procedure TProcResourceProducts.SetActive               (const Value: Boolean   ); begin SetBooleanField('Active'               , Value);end;

  {TProcResourceSchedule}

constructor TProcResourceSchedule.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ProcResourceSchedule';
  fSQL := 'SELECT * FROM tblprocresourceschedule';
end;


destructor TProcResourceSchedule.Destroy;
begin
  inherited;
end;


procedure TProcResourceSchedule.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ResourceProductID');
  SetPropertyFromNode(node,'SaleID');
  SetPropertyFromNode(node,'SaleLineId');
  SetPropertyFromNode(node,'ProcesspartID');
  SetPropertyFromNode(node,'ProcesstimeID');
  SetPropertyFromNode(node,'proctreeid');
  SetPropertyFromNode(node,'Seqno');
  SetPropertyFromNode(node,'ScheduledQty');
  SetDateTimePropertyFromNode(node,'ScheduleDate');
end;


procedure TProcResourceSchedule.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ResourceProductID' ,ResourceProductID);
  AddXMLNode(node,'SaleLineId' ,SaleLineId);
  AddXMLNode(node,'ProcesspartID' ,ProcesspartID);
  AddXMLNode(node,'ProcesstimeID' ,ProcesstimeID);
  AddXMLNode(node,'proctreeid' ,proctreeid);
  AddXMLNode(node,'SaleID' ,SaleID);
  AddXMLNode(node,'Seqno' ,Seqno);
  AddXMLNode(node,'ScheduledQty' ,ScheduledQty);
  AddXMLNode(node,'ScheduleDate' ,ScheduleDate);
end;


function TProcResourceSchedule.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TProcResourceSchedule.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProcResourceSchedule.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TProcResourceSchedule.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TProcResourceSchedule.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProcResourceSchedule.GetIDField: string;
begin
  Result := 'ID'
end;


class function TProcResourceSchedule.GetBusObjectTablename: string;
begin
  Result:= 'tblprocresourceschedule';
end;


function TProcResourceSchedule.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TProcResourceSchedule.GetResourceProductID: Integer   ; begin Result := GetIntegerField('ResourceProductID');end;
function  TProcResourceSchedule.GetSaleLineId       : Integer   ; begin Result := GetIntegerField('SaleLineId');end;
function  TProcResourceSchedule.GetProcesspartID    : Integer   ; begin Result := GetIntegerField('ProcesspartID');end;
function  TProcResourceSchedule.GetProcesstimeID    : Integer   ; begin Result := GetIntegerField('ProcesstimeID');end;
function  TProcResourceSchedule.Getproctreeid       : Integer   ; begin Result := GetIntegerField('proctreeid');end;
function  TProcResourceSchedule.GetSaleID           : Integer   ; begin Result := GetIntegerField('SaleID');end;
function  TProcResourceSchedule.GetSeqno            : Integer   ; begin Result := GetIntegerField('Seqno');end;
function  TProcResourceSchedule.GetScheduledQty     : Double    ; begin Result := GetFloatField('ScheduledQty');end;
function  TProcResourceSchedule.GetScheduleDate     : TDateTime ; begin Result := GetDateTimeField('ScheduleDate');end;
procedure TProcResourceSchedule.SetResourceProductID(const Value: Integer   ); begin SetIntegerField('ResourceProductID' , Value);end;
procedure TProcResourceSchedule.SetSaleLineId       (const Value: Integer   ); begin SetIntegerField('SaleLineId'        , Value);end;
procedure TProcResourceSchedule.SetProcesspartID    (const Value: Integer   ); begin SetIntegerField('ProcesspartID'     , Value);end;
procedure TProcResourceSchedule.SetProcesstimeID    (const Value: Integer   ); begin SetIntegerField('ProcesstimeID'     , Value);end;
procedure TProcResourceSchedule.Setproctreeid       (const Value: Integer   ); begin SetIntegerField('proctreeid'        , Value);end;
procedure TProcResourceSchedule.SetSaleID           (const Value: Integer   ); begin SetIntegerField('SaleID'            , Value);end;
procedure TProcResourceSchedule.SetSeqno            (const Value: Integer   ); begin SetIntegerField('Seqno'             , Value);end;
procedure TProcResourceSchedule.SetScheduledQty     (const Value: Double    ); begin SetFloatField('ScheduledQty'      , Value);end;
procedure TProcResourceSchedule.SetScheduleDate     (const Value: TDateTime ); begin SetDateTimeField('ScheduleDate'      , Value);end;


{ TProcResourceProductClean }

constructor TProcResourceProductClean.Create(AOwner: TComponent);
begin
  inherited;
  fSQLSelect := 'Seqno =1';
end;

function TProcResourceProductClean.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  Seqno := 1;
  if Assigned(Owner) then
    if owner is TProcResourceDetails then
      noofresources := TProcResourceDetails(Owner).noofresources;
end;

function TProcResourceProductClean.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforeInsert(Sender);
  if not result then Exit;
  if count >0 then result := False; // this allows only 1 record as this is the clean product which holds the clean qty
end;

procedure TProcResourceProductClean.DoFieldOnChange(Sender: TField);
begin
      if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
          if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
      inherited;
{----}if (Sysutils.SameText(Sender.FieldName, 'Seqno')) then begin
        if Seqno > 1 then begin
          Seqno := 1;
        end;
      end;
end;

function TProcResourceProductList.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  //Seqno := iLastNo +2;
  noofresources := 0;
end;

function TProcResourceProductList.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
var
  qry :TERPQuery;
begin
  result := inherited DoBeforeInsert(Sender);
  if not result then exit;
  (*qry := GetSharedDataSet('Select max(Seqno) as Seqno FROM tblprocresourceproducts where ProcresourcedetailID = ' + inttostr(ProcresourcedetailID ));
  try
    iLastNo :=qry.fieldbyname('Seqno').asInteger;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;*)


end;

procedure TProcResourceProductList.DoFieldOnChange(Sender: TField);
begin
      if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
          if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
      inherited;
{----}if (Sysutils.SameText(Sender.FieldName, 'Seqno')) then begin
        if Seqno <= 1 then begin
          Seqno := count+2;
        end;
      end;
end;

{ TProcResourceProductList }

constructor TProcResourceProductList.Create(AOwner: TComponent);
begin
  inherited;
  fSQLSelect := 'Seqno >1';
  //iLastNo :=0;
end;

initialization
  RegisterClass(TProcResourceSchedule);
  RegisterClass(TProcResourceProducts);
  RegisterClass(TProcResourceDetails);
  RegisterClassOnce(TProcResource);
  RegisterClassOnce(TProcResourceProcess);
  RegisterClass(TProcResourceDays);
  RegisterClass(TProcResourceUnAvailability);


end.
