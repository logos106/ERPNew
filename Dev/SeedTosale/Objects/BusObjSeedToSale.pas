unit BusObjSeedToSale;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  04/03/20  1.00.00  A.  Initial Version.
  }


interface


uses busobjPQA, busobjStockMovement, BusobjStSStrain, BusObjBase, DB, Classes,
     XMLDoc, XMLIntf, ERPdbComponents,Graphics, Types;

const
  Phase_color_Immature  = $00A4FFA4;
  Phase_color_Vegetative= $0046FF46;
  Phase_color_Flowering = clGreen;
  Phase_color_Harvest   = $00A8C5FF;
  Phase_color_Product   = $000080FF;
  Phase_color_Destroy   = clRed;
type
  TStSTagProduct = class(TMSBusObj)
  private
    function GetTagID               : Integer   ;
    function GetEmployeeId          : Integer   ;
    function GetProductTagID        : Integer   ;
    function GetProductcount        : Integer   ;
    function GetStSProducttype      : string    ;
    function GetProductionDate      : TDateTime ;
    function GetDescription         : string    ;
    procedure SetTagID               (const Value: Integer   );
    procedure SetEmployeeId          (const Value: Integer   );
    procedure SetProductTagID        (const Value: Integer   );
    procedure SetProductcount        (const Value: Integer   );
    procedure SetStSProducttype      (const Value: string    );
    procedure SetProductionDate      (const Value: TDateTime );
    procedure SetDescription         (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
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
    procedure DoFieldOnChange(Sender: TField);                          override;
  published
    property TagID                :Integer     read GetTagID              write SetTagID           ;
    property EmployeeId           :Integer     read GetEmployeeId         write SetEmployeeId      ;
    property ProductTagID         :Integer     read GetProductTagID       write SetProductTagID    ;
    property Productcount         :Integer     read GetProductcount       write SetProductcount    ;
    property StSProducttype       :string      read GetStSProducttype     write SetStSProducttype  ;
    property ProductionDate       :TDateTime   read GetProductionDate     write SetProductionDate  ;
    property Description          :string      read GetDescription        write SetDescription     ;
  end;

  TStSTag_Actions = class(TMSBusObj)
  private
    function GetTagID               : Integer   ;
    function GetStatusDate          : TDateTime ;
    function GetStatusActionId      : Integer   ;
    function GetStSProductID        : Integer   ;
    function GetTagProductID        : Integer   ;
    function GetStatusAction        : string    ;
    function GetDescription         : string    ;
    function GetChangeToRoomID      : Integer   ;
    function GetReplaceTagId        : Integer   ;
    function GetActionQty           : Integer;
    function GetSMLLineID           : Integer   ;
    procedure SetTagID               (const Value: Integer   );
    procedure SetStatusDate          (const Value: TDateTime );
    procedure SetStatusActionId      (const Value: Integer   );
    procedure SetStSProductID        (const Value: Integer   );
    procedure SetTagProductID        (const Value: Integer   );
    procedure SetStatusAction        (const Value: string    );
    procedure SetDescription         (const Value: string    );
    procedure SetChangeToRoomID      (const Value: Integer   );
    procedure SetReplaceTagId        (const Value: Integer   );
    procedure SetActionQty           (const Value: Integer   );
    procedure SetSMLLineID           (const Value: Integer   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
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
    procedure DoFieldOnChange(Sender: TField);                          override;
  published
    // TagID = tblststags.ID
    property TagID :Integer     read GetTagID              write SetTagID           ;
    property StatusDate           :TDateTime   read GetStatusDate         write SetStatusDate      ;
    property StatusActionId       :Integer     read GetStatusActionId     write SetStatusActionId  ;
    property StSProductID         :Integer     read GetStSProductID       write SetStSProductID    ;
    // TagProductID = tblparts.ID
    property TagProductID         :Integer     read GetTagProductID       write SetTagProductID    ;
    property StatusAction         :string      read GetStatusAction       write SetStatusAction    ;
    property Description          :string      read GetDescription        write SetDescription     ;
    property ChangeToRoomID       :Integer     read GetChangeToRoomID     write SetChangeToRoomID  ;
    property ReplaceTagId         :Integer     read GetReplaceTagId       write SetReplaceTagId    ;
    property ActionQty            :Integer     read GetActionQty          write SetActionQty       ;
    property SMLLineID            :Integer     read GetSMLLineID          write SetSMLLineID       ;
  end;
  TStSTagPhases = class(TMSBusObj)
  private
    function GetTagID               : Integer   ;
    function GetQtyPerTag           : Integer   ;
    function GetNoOfTags            : Integer   ;
    function GetPhaseProductID      : Integer   ;
    function GetSMLineID            : Integer   ;
    function GetTagChanged          : Boolean   ;
    function GetPhaseCreatedOn      : TDateTime ;
    Function getStSPhase            : String    ;
    procedure SetTagID               (const Value: Integer   );
    procedure SetQtyPerTag           (const Value: Integer   );
    procedure SetNoOfTags            (const Value: Integer   );
    procedure SetPhaseProductID      (const Value: Integer   );
    procedure SetSMLineID            (const Value: Integer   );
    procedure SetTagChanged          (const Value: Boolean   );
    procedure SetPhaseCreatedOn      (const Value: TDateTime );
    Procedure SetStSPhase            (Const Value: String    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property TagID                :Integer     read GetTagID              write SetTagID           ;
    property QtyPerTag            :Integer     read GetQtyPerTag          write SetQtyPerTag       ;
    property NoOfTags             :Integer     read GetNoOfTags           write SetNoOfTags        ;
    property PhaseProductID       :Integer     read GetPhaseProductID     write SetPhaseProductID  ;
    property SMLineID             :Integer     read GetSMLineID           write SetSMLineID        ;
    property TagChanged           :Boolean     read GetTagChanged         write SetTagChanged      ;
    property PhaseCreatedOn       :TDateTime   read GetPhaseCreatedOn     write SetPhaseCreatedOn  ;
    Property StSPhase             :String      read getStSPhase           Write SetStSPhase        ;
  end;
  TStSTags = class(TMSBusObj)
  private
    fiPhaseProductID: Integer;
    fbTagChanged :boolean;
    StSTagSM:TStockMovement;
    StSTagSMLSN:TPQASN;
    fStSTagProductLookup :TERPQuery;
    fsRoomLocation       : string    ;
    fsRoomNumber         : string    ;
    function GetStsTag                        : string    ;
    function GetTagProductID                  : Integer   ;
    function GetSourceTagID                   : Integer   ;
    function GetSourceTag                     : string    ;
    function GetSourcetype                    : string    ;
    function GetStSPhase                      : string    ;
    function GetStSTagPhaseID                 : Integer   ;
    function GetStSActionID                   : Integer   ;
    function GetDeptID                        : Integer   ;
    function GetDept                          : string    ;
    function GetUOMID                         : Integer   ;
    function GetBinID                         : Integer   ;
    function GetPlanttype                     : string    ;
    function GetUsedOn                        : TDateTime ;
    function GetStrainID                      : Integer   ;
    function GetStrainName                    : string    ;
    function GetPlantcount                    : Integer   ;
    function GetChangedCount                  : Integer   ;
    function GetWastedCount                   : Integer   ;
    function GetDestroycount                  : Integer   ;
    function GetHarvestcount                  : Integer   ;
    function GetTransferedCount               : Integer   ;
    function GetUsedCount                     : Integer   ;
    function GetActivecount                   : Integer   ;
    function GetStSProductID                  : Integer   ;
    function GetReplacedByTagID               : Integer   ;
    function GetEmployeeID                    : Integer   ;
    function GetRoomLocation                  : string    ;
    function GetRoomNumber                    : string    ;
    procedure SetStsTag                        (const Value: string    );
    procedure SetTagProductID                  (const Value: Integer   );
    procedure SetSourceTagID                   (const Value: Integer   );
    procedure SetSourceTag                     (const Value: string    );
    procedure SetSourcetype                    (const Value: string    );
    procedure SetStSPhase                      (const Value: string    );
    procedure SetStSTagPhaseID                 (const Value: Integer   );
    procedure SetStSActionID                   (const Value: Integer   );
    procedure SetDeptID                        (const Value: Integer   );
    procedure SetDept                          (const Value: string    );
    procedure SetUOMID                         (const Value: Integer   );
    procedure SetBinID                         (const Value: Integer   );
    procedure SetPlanttype                     (const Value: string    );
    procedure SetUsedOn                        (const Value: TDateTime );
    procedure SetStrainID                      (const Value: Integer   );
    procedure SetStrainName                    (const Value: string    );
    procedure SetPlantcount                    (const Value: Integer   );
    procedure SetChangedCount                  (const Value: Integer   );
    procedure SetWastedCount                   (const Value: Integer   );
    procedure SetDestroycount                  (const Value: Integer   );
    procedure SetHarvestcount                  (const Value: Integer   );
    procedure SetTransferedCount               (const Value: Integer   );
    procedure SetUsedCount                     (const Value: Integer   );
    procedure SetStSProductID                  (const Value: Integer   );
    procedure SetReplacedByTagID               (const Value: Integer   );
    procedure SetEmployeeID                    (const Value: Integer   );
    procedure SetRoomLocation                  (const Value: string    );
    procedure SetRoomNumber                    (const Value: string    );
    function getStSStrain: TStSStrain;
    function getStSTag_Actions: TStSTag_Actions;
    function getStSTagProduct: TStSTagProduct;
    function getStSTagPhases: TStSTagPhases;
    function getCleanStsPhase: String;
    procedure initStSPhaseProduct;
    function getPhaseDescription: String;
    function getCleanChangedCount: Integer;
    function getCleanWastedCount: Integer;
    function getCleanDestroycount: Integer;
    function getCleanTransferedCount: Integer;
    function getCleanUsedCount: Integer;
    procedure SaveCallback(Const Sender: TBusObj; var Abort: boolean);
    function getTagChanged: Boolean;
    procedure TagchangedcheckCallback(const Sender: TBusObj;var Abort: boolean);
    procedure StSTagsSaveCallback(const Sender: TBusObj; var Abort: boolean);
    function getSourceTagDate: TDatetime;
    function getStSTagProductLookup: TERPQuery;
    procedure initBinID;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetKeyStringField            : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    class function NewStsAction(const Value: String): Integer; static;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     ValidatePackageData: Boolean;
    function     Save: Boolean ;                                        override;
    function     SavePackage: Boolean ;
    Class function StSTagrec(AOwner:Tcomponent; const aTagID:Integer;aConnection: TERPConnection      ; aBusObjEvent: TBusObjEvent): TStSTags; Overload;
    Class function StSTagrec(AOwner:Tcomponent; const aTagID:Integer;aConnection: TMyDAcDataconnection; aBusObjEvent: TBusObjEvent): TStSTags; Overload;
    Property StSStrain :TStSStrain read getStSStrain;
    property CleanStsPhase :String read getCleanStsPhase;
    Procedure InitfieldsAfterclone;
    Property PhaseProductID:Integer read fiPhaseProductID write fiPhaseProductID;
    Property PhaseDescription :String read getPhaseDescription;
    property Activecount                 : Integer     read GetActivecount;
    Property CleanChangedCount :Integer read getCleanChangedCount;
    Property CleanWastedCount  :Integer read getCleanWastedCount;
    Property CleanDestroycount :Integer read getCleanDestroycount;
    Property CleanTransferedCount :Integer read getCleanTransferedCount;
    Property CleanUsedCount    :Integer read getCleanUsedCount;
    Property TagChanged :Boolean read getTagChanged;

    Function TransferTagto(aClassID, aBinId:Integer; aTransferingemployeeId:Integer; TransferDate:TDateTime):Boolean;
    function isTagActive: Boolean;

    Function DestroyPlant(const DoDestroy: Boolean = True):boolean;
    Function RecordWastage(fiWastageQty: Integer; const DoWaste: Boolean = True):Boolean;
    function UseTag: Boolean;
    function UsePackageTag: Boolean;
    function MakePlant(aQty:Double): Boolean;
    function ChangeGrowthPhase(aID: Integer; aQty: Double): Boolean;
    Property SourceTagDate : TDatetime read getSourceTagDate;
    class Procedure TagDate(aTagID:Integer; var aQty:double; var aTransdate:TDateTime);
    Property StSTagProductLookup :TERPQuery read getStSTagProductLookup;
    Function UseTagnMakePlant:Boolean;
    Function NewPhase(const NewActionDesc:String; ChangePhaseFunc:TBusObjBoolFunc ):Boolean;
  published
    property StsTag                         : string      read GetStsTag                         write SetStsTag                ;
    property TagProductID                   : Integer     read GetTagProductID                   write SetTagProductID          ;
    property SourceTagID                    : Integer     read GetSourceTagID                    write SetSourceTagID           ;
    property SourceTag                      : string      read GetSourceTag                      write SetSourceTag             ;
    property Sourcetype                     : string      read GetSourcetype                     write SetSourcetype            ;
    property StSPhase                       : string      read GetStSPhase                       write SetStSPhase              ;
    property StSTagPhaseID                  : Integer     read GetStSTagPhaseID                  write SetStSTagPhaseID         ;
    property StSActionID                    : Integer     read GetStSActionID                    write SetStSActionID           ;
    property DeptID                         : Integer     read GetDeptID                         write SetDeptID                ;
    property Dept                           : string      read GetDept                           write SetDept                  ;
    property UOMID                          : Integer     read GetUOMID                          write SetUOMID                 ;
    property BinID                          : Integer     read GetBinID                          write SetBinID                 ;
    property RoomLocation                   : string      read GetRoomLocation                   write SetRoomLocation   ;
    property RoomNumber                     : string      read GetRoomNumber                     write SetRoomNumber     ;
    property Planttype                      : string      read GetPlanttype                      write SetPlanttype             ;
    property UsedOn                         : TDateTime   read GetUsedOn                         write SetUsedOn                ;
    property StrainID                       : Integer     read GetStrainID                       write SetStrainID              ;
    property StrainName                     : string      read GetStrainName                     write SetStrainName            ;
    property Plantcount                     : Integer     read GetPlantcount                     write SetPlantcount            ;
    property ChangedCount                   : Integer     read GetChangedCount                   write SetChangedCount          ;
    property WastedCount                    : Integer     read GetWastedCount                    write SetWastedCount           ;
    property Destroycount                   : Integer     read GetDestroycount                   write SetDestroycount          ;
    property Harvestcount                   : Integer     read GetHarvestcount                   write SetHarvestcount          ;
    property TransferedCount                : Integer     read GetTransferedCount                write SetTransferedCount       ;
    property UsedCount                      : Integer     read GetUsedCount                      write SetUsedCount             ;
    property StSProductID                   : Integer     read GetStSProductID                   write SetStSProductID          ;
    property ReplacedByTagID                : Integer     read GetReplacedByTagID                write SetReplacedByTagID       ;
    property EmployeeID                     : Integer     read GetEmployeeID                     write SetEmployeeID            ;
    property StSTag_Actions                 : TStSTag_Actions read getStSTag_Actions;
    property StSTagProduct                  : TStSTagProduct  read getStSTagProduct;
    property StSTagPhases                   : TStSTagPhases  read getStSTagPhases;
  end;
  TStSHarvestLines = class(TMSBusObj)
  private
    function GetHarvestID           : Integer   ;
    function GetSMLLineID           : Integer   ;
    function GetTagID               : Integer   ;
    function GetQty                 : Double    ;
    function GetUOMQty              : Double    ;
    function GetStSActionID         : Integer   ;
    Function getStsTag              : String;
    procedure SetHarvestID           (const Value: Integer   );
    procedure SetSMLLineID           (const Value: Integer   );
    procedure SetTagID               (const Value: Integer   );
    procedure SetQty                 (const Value: Double    );
    procedure SetUOMQty              (const Value: Double    );
    procedure SetStSActionID         (const Value: Integer   );
    Procedure SetStsTag              (const Value: String    );
    function GetStSTagObj: TStSTags;

    {Header Properties}
    Function getUOMMultiplier :Double;
    Function getStSProductID  :Integer;
    Function getDeptID        :Integer;
    Function getUOMID         :Integer;
    Function getBinID         :Integer;
    Function getHarvestDate   :TDatetime;
    Function GetUOM           :String;
    Function MakeStockMovementLine:Boolean;

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Procedure CalcTotals;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;

    {Header Properties}
    Property UOMMultiplier:Double     Read getUOMMultiplier;
    Property StSProductID :Integer    Read getStSProductID;
    Property DeptID       :Integer    Read getDeptID;
    Property UOMID        :Integer    Read getUOMID;
    Property BinID        :Integer    Read getBinID;
    Property HarvestDate  :TDatetime  Read getHarvestDate;
    Property UOM          :String     Read getUOM;
  published
    property HarvestID            :Integer     read GetHarvestID          write SetHarvestID       ;
    property SMLLineID            :Integer     read GetSMLLineID          write SetSMLLineID       ;
    property TagID{tblStsTags.ID} :Integer     read GetTagID              write SetTagID           ;
    property Qty                  :Double      read GetQty                write SetQty             ;
    property UOMQty               :Double      read GetUOMQty             write SetUOMQty          ;
    property StSActionID          :Integer     read GetStSActionID        write SetStSActionID     ;
    Property StsTag               :String      read getStsTag             write setStsTag          ;
    Property StSTagObj : TStSTags read GetStSTagObj;
  end;

  TStSHarvest = class(TMSBusObj)
  private
    fdTotalQty :double;
    fbCalculatingTotal:Boolean;
    AllLinesValid : Boolean;
    StSTagSM:TStockMovement;
    function GetDeptID              : Integer   ;
    function GetBinID               : Integer   ;
    function GetHarvestDate         : TDateTime ;
    function GetHarvestName         : string    ;
    function GetStrainID            : Integer   ;
    function GetStrainName          : string    ;
    function GetUOMID               : Integer   ;
    function GetUOM                 : string    ;
    function GetUOMMultiplier       : Double    ;
    function GetTotalQty            : Double    ;
    function GetPackedQty           : Double    ;
    function GetStSProductId        : Integer   ;
    function GetHarvestdone         : Boolean   ;

    procedure SetDeptID              (const Value: Integer   );
    procedure SetBinID               (const Value: Integer   );
    procedure SetHarvestDate         (const Value: TDateTime );
    procedure SetHarvestName         (const Value: string    );
    procedure SetStrainID            (const Value: Integer   );
    procedure SetStrainName          (const Value: string    );
    procedure SetUOMID               (const Value: Integer   );
    procedure SetUOM                 (const Value: string    );
    procedure SetUOMMultiplier       (const Value: Double    );
    procedure SetTotalQty            (const Value: Double    );
    procedure SetPackedQty           (const Value: Double    );
    procedure SetStSProductId        (const Value: Integer   );
    Procedure SetHarvestdone         (Const Value: Boolean   );

    function getStSHarvestLines: TStSHarvestLines;
    Procedure CalcTotals;
    procedure CalcTotalsCallback(const Sender: TBusObj; var Abort: boolean);
    function getCleanHarvestName: String;
    procedure CheckForHarvestProductUOM;
    procedure SaveLinesCallback(const Sender: TBusObj; var Abort: boolean);
    procedure Validatecallback(const Sender: TBusObj; var Abort: boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetKeyStringField            : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property     CleanHarvestName :String read getCleanHarvestName;
    function DefaultHarvestname: String;
  published
    property DeptID               :Integer     read GetDeptID             write SetDeptID          ;
    property BinID                :Integer     read GetBinID              write SetBinID           ;
    property HarvestDate          :TDateTime   read GetHarvestDate        write SetHarvestDate     ;
    property HarvestName          :string      read GetHarvestName        write SetHarvestName     ;
    property StrainID             :Integer     read GetStrainID           write SetStrainID        ;
    property StrainName           :string      read GetStrainName         write SetStrainName      ;
    property UOMID                :Integer     read GetUOMID              write SetUOMID           ;
    property UOM                  :string      read GetUOM                write SetUOM             ;
    property UOMMultiplier        :Double      read GetUOMMultiplier      write SetUOMMultiplier   ;
    property TotalQty             :Double      read GetTotalQty           write SetTotalQty        ;
    property PackedQty            :Double      read GetPackedQty          write SetPackedQty       ;
    property StSProductId         :Integer     read GetStSProductId       write SetStSProductId    ;
    Property Harvestdone          :Boolean     read getHarvestdone        write SetHarvestdone;
    Property Lines                :TStSHarvestLines read getStSHarvestLines;
   end;

  ///<summary> Package can be created from Harvest, Immature, Vegetative and can be created from other packages.
  ///          It cannot be created from Flowering. </summary>
  TStsPackageType = (pkgUnknown, pkgImmature, pkgVegetative, pkgHarvest, pkgPackage);

  const
    PackageTypeNames: array [TStsPackageType] of string = ('<Unknown>', 'Immature plant', 'Vegetative plant', 'Harvest', 'Another package');

type
  TStSPackageLines = class(TMSBusObj)
  private
    function GetPackageID           : Integer;
    function GetSMLLineID           : Integer;
    function GetStsTagsID           : Integer;
    function GetQty                 : Integer;
    function GetUOMQty              : Integer;
    function GetStSActionID         : Integer;
    function GetStSProductID        : Integer;

    procedure SetPackageID           (const Value: Integer);
    procedure SetSMLLineID           (const Value: Integer);
    procedure SetStsTagsID           (const Value: Integer);
    procedure SetQty                 (const Value: Integer);
    procedure SetUOMQty              (const Value: Integer);
    procedure SetStSActionID         (const Value: Integer);
    procedure SetStSProductID        (const Value: Integer);

    function GetStSTagObj: TStSTags;

    {Header Properties}
    Function getUOMMultiplier :Integer;
    Function getUOMID         :Integer;
    Function getPackageDate   :TDatetime;
    Function GetUOM           :String;

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
    function     OwnerProductID: Integer;

    {Header Properties}
    Property UOMMultiplier:Integer    Read getUOMMultiplier;
    Property UOMID        :Integer    Read getUOMID;
    Property PackageDate  :TDatetime  Read getPackageDate;
    Property UOM          :String     Read getUOM;
  published
    property PackageID            :Integer     read GetPackageID          write SetPackageID    ;
    property SMLLineID            :Integer     read GetSMLLineID          write SetSMLLineID    ;
    property StsTagsID            :Integer     read GetStsTagsID          write SetStsTagsID    ;
    property Qty                  :Integer     read GetQty                write SetQty          ;
    property UOMQty               :Integer     read GetUOMQty             write SetUOMQty       ;
    property StSActionID          :Integer     read GetStSActionID        write SetStSActionID  ;
    Property StSProductID         :Integer     read GetStSProductID       write SetStSProductID ;
    Property StSTagObj            :TStSTags    read GetStSTagObj;
  end;

  TStSPackage = class(TMSBusObj)
  private
    FInitDeptID: Integer;
    FTotLinesQty: Integer;
  private
   function GetStsTagsID:     Integer;
   function GetParentPkgID:   Integer;
   function GetPackageName:   string;
   function GetPackageDate:   TDateTime;
   function GetPackageType:   TStsPackageType;
   function GetHarvestID:     Integer;
   function GetUOMID:         Integer;
   function GetUOM:           string;
   function GetUOMMultiplier: Double;
   function GetPackedQty:     Double;
   function GetDone:          string;

   function GetStSPackageLines: TStSPackageLines;
   function GetStSTagObj: TStSTags;

   procedure SetStsTagsID    (const AValue: Integer  );
   procedure SetParentPkgID  (const AValue: Integer  );
   procedure SetPackageName  (const AValue: string   );
   procedure SetPackageDate  (const AValue: TDateTime);
   procedure SetPackageType  (const AValue: TStsPackageType);
   procedure SetHarvestID    (const AValue: Integer  );
   procedure SetUOMID        (const AValue: Integer  );
   procedure SetUOM          (const AValue: string   );
   procedure SetUOMMultiplier(const AValue: Double   );
   procedure SetPackedQty    (const AValue: Double   );
   procedure SetDone         (const AValue: string   );

   procedure CalcTotalsCallback(const Sender: TBusObj; var Abort: boolean);
   procedure SaveLinesCallback(const Sender: TBusObj; var Abort: boolean);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetKeyStringField            : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;

    function     DefaultPackageName(const aSpecifier: string = ''): String;
    ///<summary> Calculates the total Qty for all Lines records and assigns the result to the PackedQty property </summary>
    procedure CalcNSetTotalPackedQty;

    ///<returns> tblParts.PartsID  </returns>
    class function ProductID: Integer;
    function CreatePackage(const NewActionDesc: string; aCreatePackageFunc: TBusObjBoolFunc ):Boolean;
    //<summary> Runtime DeptID value used in TfmStSCreatePackage to prepare list of available Harvests </summary>
    property InitDeptID: Integer  read FInitDeptID write FInitDeptID;
    Property StSTagObj:  TStSTags read GetStSTagObj;

  published
    property StsTagsID:     Integer          read GetStsTagsID      write SetStsTagsID;
    property ParentPkgID:   Integer          read GetParentPkgID    write SetParentPkgID;
    property PackageName:   string           read GetPackageName    write SetPackageName;
    property PackageDate:   TDateTime        read GetPackageDate    write SetPackageDate;
    property PackageType:   TStsPackageType  read GetPackageType    write SetPackageType;
    property HarvestID:     Integer          read GetHarvestID      write SetHarvestID;
    property UOMID:         Integer          read GetUOMID          write SetUOMID;
    property UOM:           string           read GetUOM            write SetUOM;
    property UOMMultiplier: Double           read GetUOMMultiplier  write SetUOMMultiplier;
    property PackedQty:     Double           read GetPackedQty      write SetPackedQty;
    property Done:          string           read GetDone           write SetDone;
    Property Lines:         TStSPackageLines read GetStSPackageLines;
  end;

  TStSPkgTransferLines = class(TMSBusObj)
  private
    function GetTransferID          : Integer;
    function GetPackageID           : Integer;
    function GetSMLLineID           : Integer;
    function GetTagID               : Integer;
    function GetUOMQty              : Integer;
    function GetStSActionID         : Integer;
    function GetStSProductID        : Integer;
    function GetRejected            : String;

    procedure SetTransferID          (const Value: Integer);
    procedure SetPackageID           (const Value: Integer);
    procedure SetSMLLineID           (const Value: Integer);
    procedure SetTagID               (const Value: Integer);
    procedure SetUOMQty              (const Value: Integer);
    procedure SetStSActionID         (const Value: Integer);
    procedure SetStSProductID        (const Value: Integer);
    procedure SetRejected            (const Value: String );

    function GetStSTagObj: TStSTags;
    function GetStSPkgObj: TStSPackage;

    {Header Properties}
    Function getUOMMultiplier :Integer;
    Function getDeptID        :Integer;
    Function getUOMID         :Integer;
    Function getTransferDate  :TDatetime;
    Function GetUOM           :String;

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

    {Header Properties}
    Property UOMMultiplier:Integer    Read getUOMMultiplier;
    Property DeptID       :Integer    Read getDeptID;
    Property UOMID        :Integer    Read getUOMID;
    Property TransferDate :TDatetime  Read getTransferDate;
    Property UOM          :String     Read getUOM;
  published
    property TransferID           :Integer     read GetTransferID         write SetTransferID    ;
    property PackageID            :Integer     read GetPackageID          write SetPackageID    ;
    property SMLLineID            :Integer     read GetSMLLineID          write SetSMLLineID    ;
    property TagID{tblStsTags.ID} :Integer     read GetTagID              write SetTagID        ;
    property UOMQty               :Integer     read GetUOMQty             write SetUOMQty       ;
    property StSActionID          :Integer     read GetStSActionID        write SetStSActionID  ;
    Property StSProductID         :Integer     read GetStSProductID       write SetStSProductID ;
    Property Rejected             :String      read GetRejected           write SetRejected     ;
    Property StSTagObj : TStSTags    read GetStSTagObj;
    Property StSPkgObj : TStSPackage read GetStSPkgObj;
  end;

  TStSPkgTransfer = class(TMSBusObj)
  private
    function GetSourceDeptID: Integer;
    function GetDestDeptID:   Integer;
    function GetTransferType: string;
    function GetRoute:        string;
    function GetEstDeparture: TDateTime;
    function GetEstArrival:   TDateTime;
    function GetDriverID:     Integer;
    function GetVehicleID:    Integer;
    function GetDone:         string;
    function GetPkgTransferLines: TStSPkgTransferLines;

    procedure SetSourceDeptID (const AValue: Integer  );
    procedure SetDestDeptID   (const AValue: Integer  );
    procedure SetTransferType (const AValue: string   );
    procedure SetRoute        (const AValue: string   );
    procedure SetEstDeparture (const AValue: TDateTime);
    procedure SetEstArrival   (const AValue: TDateTime);
    procedure SetDriverID     (const AValue: Integer  );
    procedure SetVehicleID    (const AValue: Integer  );
    procedure SetDone         (const AValue: string   );

    procedure SaveLinesCallback(const Sender: TBusObj; var Abort: boolean);

  public
    class function  GetIDField            : string; override;
    class function  GetKeyStringField     : string; override;
    class function  GetBusObjectTablename : string; override;

    constructor  Create(AOwner: TComponent); override;
    destructor   Destroy;                    override;
    function     ValidateData: Boolean;      override;
    function     Save: Boolean;              override;

    function UOM: string;
    function UOMID: Integer;
    function TransferDate: TDateTime;

    property DeptID: Integer read GetSourceDeptID;

  published
    property SourceDeptID: Integer   read GetSourceDeptID write SetSourceDeptID;
    property DestDeptID:   Integer   read GetDestDeptID   write SetDestDeptID;
    property TransferType: string    read GetTransferType write SetTransferType;
    property Route:        string    read GetRoute        write SetRoute;
    property EstDeparture: TDateTime read GetEstDeparture write SetEstDeparture;
    property EstArrival:   TDateTime read GetEstArrival   write SetEstArrival;
    property DriverID:     Integer   read GetDriverID     write SetDriverID;
    property VehicleID:    Integer   read GetVehicleID    write SetVehicleID;
    property Done:         string    read GetDone         write SetDone;
    property Lines: TStSPkgTransferLines read GetPkgTransferLines;
  end;

  TStSVehicle = class(TMSBusObj)
  private
    function GetManufacture: string;
    function GetModel:       string;
    function GetSerial:      string;
    function GetPartName:    string;
    procedure SetManufacture(const AValue: string);
    procedure SetModel      (const AValue: string);
    procedure SetSerial     (const AValue: string);
    procedure SetPartName   (const AValue: string);
  protected
    function  GetSQL: string; override;
  public
    class function  GetIDField            : string;  override;
    class function  GetBusObjectTablename : string;  override;
          function  Save                  : Boolean; override;
  published
    property Manufacture: string  read GetManufacture write SetManufacture;
    property Model:       string  read GetModel       write SetModel;
    property Serial:      string  read GetSerial      write SetSerial;
    property PartName:    string  read GetPartName    write SetPartName;
  end;


implementation


uses tcDataUtils, CommonLib , SysUtils, AppEnvironment,
  BusObjClass, BusObjGLAccount, BusObjEmployeeDetails,
  BusObjStock, BusobjUOM, DbSharedObjectsObj, BusObjConst, LogLib,
  BusObjSimpleTypes, StSConst, BusObjProductbin, dateutils, BusObjStSCommon, BusobjProduct,
  ProductQtyLib, PQALib, variants, CommonDbLib, StSLib;



  {TStSTags}

constructor TStSTags.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fsRoomLocation  := '';
  fsRoomNumber    := '';
  fStSTagProductLookup :=nil;
  PhaseProductID := 0;
  fBusObjectTypeDescription:= 'StSTags';
  fSQL := 'SELECT * FROM tblststags';
  FieldsnotToclone :=ExcludeFromclone+','+
                     QuotedStr('TagProductID')+',' +
                     QuotedStr('SourceTagID')+',' +
                     QuotedStr('SourceTag')+',' +
                     QuotedStr('Sourcetype')+',' +
                     QuotedStr('UOMID')+',' +
                     QuotedStr('UsedOn')+',' +
                     QuotedStr('Plantcount')+',' +
                     QuotedStr('ChangedCount')+',' +
                     QuotedStr('WastedCount')+',' +
                     QuotedStr('Destroycount')+',' +
                     QuotedStr('Harvestcount')+',' +
                     QuotedStr('TransferedCount')+',' +
                     QuotedStr('UsedCount')+',' +
                     QuotedStr('StSPhase')+',' +
                     QuotedStr('StSProductID ')+',' +
                     QuotedStr('EmployeeId')+',' +
                     QuotedStr('ReplacedByTagID')+',' +
                     QuotedStr('StsPhase');
end;


destructor TStSTags.Destroy;
begin
  if fStSTagProductLookup <> nil then fStSTagProductLookup.Free;
  inherited;
end;


function TStSTags.DestroyPlant(const DoDestroy: Boolean): boolean;
var
  iActiveCount: Integer;
begin
  Result := False;
  if DoDestroy and not isTagActive then begin
    exit;
  end;
        if count =0 then exit; // shouldn't happen
        if DoDestroy and (activecount+wastedCount <> plantcount) then begin
          REsultStatus.AddItem(False , rssError , 0,  Quotedstr(StSTag)+' Tag is already Started Processing. It is not Possible to Destroy it');
          Exit;
        end;

        if DoDestroy then
          iActiveCount := ActiveCount
        else
          iActiveCount := 0 - Destroycount;

        StSTag_Actions.New;
        StSTag_Actions.StatusDate     := Now;
        StSTag_Actions.StatusAction   := STS_ACTION_DESTROY_PLANTS;
        StSTag_Actions.ActionQty      := iActiveCount;
        StSTag_Actions.StatusActionId := NewStsAction(STS_ACTION_DESTROY_PLANTS);
        StSTag_Actions.PostDB;

        StsPhase    := 'D';
        UsedOn      := Now;
        Destroycount := Destroycount + iActiveCount;
        PostDB;
        if not Save then exit;
        Result := TRue;
end;
function TStSTags.RecordWastage(fiWastageQty: Integer; const DoWaste: Boolean): Boolean;
var
  iQty: Integer;
begin
  REsult := False;
  if fiWastageQty =0 then exit;
  if DoWaste and not isTagActive then begin
    REsultStatus.AddItem(False , rssError , 0,  'Tag ' + STSTag+' is not Active' , true );
    exit;
  end;
      if DoWaste and (ActiveCount =0) then begin
        REsultStatus.AddItem(False , rssError , 0,  'Tag ' + STSTag+' is Used' , true );
        exit;
      end;

      if DoWaste then begin
        if fiWastageQty > ActiveCount then fiWastageQty :=  ActiveCount;
        iQty := 0-fiWastageQty;
      end  else begin
        if fiWastageQty > WastedCount then fiWastageQty :=  WastedCount;
        iQty := fiWastageQty;
      end;

      StSTag_Actions.New;
      StSTag_Actions.ActionQty     := iQty;
      StSTag_Actions.StatusDate    := Now;
      StSTag_Actions.StatusAction  := STS_ACTION_RECORD_WASTE;
      StSTag_Actions.StatusActionId := NewStsAction(STS_ACTION_RECORD_WASTE);
      StSTag_Actions.PostDB;

      Wastedcount := Wastedcount - iQty;
      PostDB;
      if not Save then Exit;
      Result := True;
end;

procedure TStSTags.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'StsTag');
  SetPropertyFromNode(node,'TagProductID');
  SetPropertyFromNode(node,'SourceTagID');
  SetPropertyFromNode(node,'SourceTag');
  SetPropertyFromNode(node,'Sourcetype');
  SetPropertyFromNode(node,'StSPhase');
  SetPropertyFromNode(node,'StSTagPhaseID');
  SetPropertyFromNode(node,'StSActionID');
  SetPropertyFromNode(node,'DeptID');
  SetPropertyFromNode(node,'Dept');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'BinID');
  SetPropertyFromNode(node,'Planttype');
  SetDateTimePropertyFromNode(node,'UsedOn');
  SetPropertyFromNode(node,'StrainID');
  SetPropertyFromNode(node,'StrainName');
  SetPropertyFromNode(node,'Plantcount');
  SetPropertyFromNode(node,'ChangedCount');
  SetPropertyFromNode(node,'WastedCount');
  SetPropertyFromNode(node,'Destroycount');
  SetPropertyFromNode(node,'Harvestcount');
  SetPropertyFromNode(node,'TransferedCount');
  SetPropertyFromNode(node,'UsedCount');
  SetPropertyFromNode(node,'StSProductID');
  SetPropertyFromNode(node,'ReplacedByTagID');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'RoomLocation');
  SetPropertyFromNode(node,'RoomNumber');
end;


procedure TStSTags.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'StsTag' ,StsTag);
  AddXMLNode(node,'TagProductID' ,TagProductID);
  AddXMLNode(node,'SourceTagID' ,SourceTagID);
  AddXMLNode(node,'SourceTag' ,SourceTag);
  AddXMLNode(node,'Sourcetype' ,Sourcetype);
  AddXMLNode(node,'StSPhase' ,StSPhase);
  AddXMLNode(node,'StSTagPhaseID' ,StSTagPhaseID);
  AddXMLNode(node,'StSActionID' ,StSActionID);
  AddXMLNode(node,'DeptID' ,DeptID);
  AddXMLNode(node,'Dept' ,Dept);
  AddXMLNode(node,'UOMID' ,UOMID);
  AddXMLNode(node,'BinID' ,BinID);
  AddXMLNode(node,'Planttype' ,Planttype);
  AddXMLNode(node,'UsedOn' ,UsedOn);
  AddXMLNode(node,'StrainID' ,StrainID);
  AddXMLNode(node,'StrainName' ,StrainName);
  AddXMLNode(node,'Plantcount' ,Plantcount);
  AddXMLNode(node,'ChangedCount' ,ChangedCount);
  AddXMLNode(node,'WastedCount' ,WastedCount);
  AddXMLNode(node,'Destroycount' ,Destroycount);
  AddXMLNode(node,'Harvestcount' ,Harvestcount);
  AddXMLNode(node,'TransferedCount' ,TransferedCount);
  AddXMLNode(node,'UsedCount' ,UsedCount);
  AddXMLNode(node,'StSProductID' ,StSProductID);
  AddXMLNode(node,'ReplacedByTagID' ,ReplacedByTagID);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'RoomLocation' ,RoomLocation);
  AddXMLNode(node,'RoomNumber' ,RoomNumber);
end;


function TStSTags.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if TagProductID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'TagProductID should not be 0' , true );
    Exit;
  end;
  if DeptID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Dept should not be 0' , true );
    Exit;
  end;
  if UOMID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'UOMID should not be 0' , true );
    Exit;
  end;
  if StrainID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'StrainID should not be 0' , true );
    Exit;
  end;
  if Plantcount = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Plantcount should not be 0' , true );
    Exit;
  end;
  if (CleanStsPhase<> '') AND(CleanStsPhase<>StsPhase)  then begin
    StsPhase := CleanStsPhase;
    PostDB;
  end;
  if Appenv.Companyprefs.StsConfig.StSUsesBins then begin
    initBinID;
    if binid =0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Plantcount should not be 0' , true );
      Exit;
    end;
  end;
  Result := True;
end;

function TStSTags.ValidatePackageData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;

  if TagProductID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'TagProductID should not be 0' , true );
    Exit;
  end;
  if DeptID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Dept should not be 0' , true );
    Exit;
  end;
  if UOMID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'UOMID should not be 0' , true );
    Exit;
  end;

  Result := True;
end;

Procedure TStSTags.SaveCallback(Const Sender: TBusObj; var Abort: boolean);
begin
end;

Procedure TStSTags.StSTagsSaveCallback(const Sender: TBusObj;var Abort: boolean);
Procedure LogSaveDetails;
begin
  Logtext(inttostr(ID)+','+
          inttostr(TStSTag_Actions(Sender).count)+','+
          inttostr(TStSTag_Actions(Sender).ID)+','+
          inttostr(StSTagSM.Lines.id)+','+
          StSTagSM.Lines.Productname+','+
          TStSTag_Actions(Sender).StatusAction+','+
          Floattostr(StSTagSM.Lines.Qty)+','+
          StSTagSM.Lines.alloctype+','+
          FormatDateTime('dd-mm-yy hh:nn:ss am/pm', StSTagSM.Lines.movementdate)+','+
          StSTag);
end;
begin
  if sender is TStSTag_Actions then begin
    if (TStSTag_Actions(Sender).SMLLineID=0) and (TStSTag_Actions(Sender).ActionQty<>0)  then begin
       if TStSTag_Actions(Sender).StSProductID <> 0 then begin
          if Is_Inv_Product(TStSTag_Actions(Sender).StSProductID ) then begin
            StSTagSM.Lines.New;
            StSTagSM.Lines.MovementDate := TStSTag_Actions(Sender).Statusdate;

            StSTagSM.Lines.ProductID := TStSTag_Actions(Sender).StSProductID;

            StSTagSM.Lines.DeptID := DeptID;
            StSTagSM.Lines.UOMID  := StSTagSM.Lines.Product.UOMSalesID;
            StSTagSM.Lines.Unitofmeasure  := TUnitOfMeasure.NameforID(StSTagSM.Lines.UOMID);
            StSTagSM.Lines.UOMMultiplier  := Plantcount;
            StSTagSM.Lines.Qty := TStSTag_Actions(Sender).ActionQty;
            try StSTagSM.Lines.UOMQty := StSTagSM.Lines.Qty / StSTagSM.Lines.UOMMultiplier; Except end;
            StSTagSM.Lines.Serials:= StsTag;
            StSTagSM.Lines.DoOnProductchange;
            StSTagSM.Lines.PostDB;
            StSTagSM.Lines.CreateProductClass;

              if binID <> 0 then begin
                if StSTagSM.Lines.PQA.PQABins.count =0 then begin
                  StSTagSM.Lines.PQA.PQABins.New;
                  StSTagSM.Lines.PQA.PQABins.BinID := binID;
                end;
                StSTagSM.Lines.PQA.PQABins.Qty := StSTagSM.Lines.Qty;
                StSTagSM.Lines.PQA.PQABins.uomQty := StSTagSM.Lines.uomQty;
                StSTagSM.Lines.PQA.PQABins.PostDB;
                StSTagSMLSN:= StSTagSM.Lines.PQA.PQABins.PQASN;
              end else begin
                StSTagSMLSN:= StSTagSM.Lines.PQA.PQASN;
              end;
              if StSTagSMLSN.count =0 then begin
                StSTagSMLSN.New;
                StSTagSMLSN.SerialNumber := StSTag;
              end;
              StSTagSMLSN.AllowFractionQty := true;
              StSTagSMLSN.Qty := StSTagSM.Lines.Qty;
              StSTagSMLSN.uomQty := StSTagSM.Lines.uomQty;
              StSTagSMLSN.PostDB;

            TStSTag_Actions(Sender).SMLLineID := StSTagSM.Lines.ID;
            PostDB;
            LogSaveDetails;
          end;
        end else begin
          if Is_Inv_Product(TStSTag_Actions(Sender).TagProductID ) then begin
            StSTagSM.Lines.New;
            StSTagSM.Lines.MovementDate := TStSTag_Actions(Sender).Statusdate;
            StSTagSM.Lines.ProductID := TStSTag_Actions(Sender).TagProductID;
            StSTagSM.Lines.DeptID := DeptID;
            StSTagSM.Lines.UOMID  := StSTagSM.Lines.Product.UOMSalesID;
            StSTagSM.Lines.Unitofmeasure  := TUnitOfMeasure.NameforID(StSTagSM.Lines.UOMID);
            StSTagSM.Lines.UOMMultiplier:= 1;
            StSTagSM.Lines.Qty := TStSTag_Actions(Sender).ActionQty;
            try StSTagSM.Lines.UOMQty := StSTagSM.Lines.Qty / StSTagSM.Lines.UOMMultiplier; Except end;
            StSTagSM.Lines.Serials:= StsTag;
            StSTagSM.Lines.DoOnProductchange;
            StSTagSM.Lines.PostDB;
            StSTagSM.Lines.CreateProductClass;

              StSTagSMLSN:= StSTagSM.Lines.PQA.PQASN;
              if StSTagSMLSN.count =0 then begin
                StSTagSMLSN.New;
                StSTagSMLSN.SerialNumber := StSTag;
              end;
              StSTagSMLSN.AllowFractionQty:= true;
              StSTagSMLSN.Qty := StSTagSM.Lines.Qty;
              StSTagSMLSN.uomQty := StSTagSM.Lines.uomQty;
              StSTagSMLSN.PostDB;
            TStSTag_Actions(Sender).SMLLineID := StSTagSM.Lines.ID;
            PostDB;
            LogSaveDetails;
          end;
        end;
    end;
    stepProgress;
  end;
end;
Function TStSTags.ChangeGrowthPhase(aID:Integer;aQty:Double):Boolean;
var
  fiActionid:Integer;
begin
          //if StSTag_Actions.Locate('ID', aid, []) = false then begin
          fiActionid := NewStsAction(STS_ACTION_CHANGE_GROWTH_PHASE);
          if StSTag_Actions.Locate('StSProductID;StatusActionId', vararrayof([StSProductID,fiActionid ]), []) = false then begin
              StSTag_Actions.New;
              StSTag_Actions.StatusDate     := UsedOn;
              StSTag_Actions.StatusAction   := STS_ACTION_CHANGE_GROWTH_PHASE;
              StSTag_Actions.StSProductID   := StSProductID;
              StSTag_Actions.StatusActionId := fiActionid;
          end;
          StSTag_Actions.ActionQty      := StSTag_Actions.ActionQty + (0-trunc(aQty));
          StSTag_Actions.TagProductID   := 0;
          StSTag_Actions.PostDB;
          stepProgress;
          Result:= true;

end;

function TStSTags.UsePackageTag: Boolean;
begin
  Result:= False;
  if (StSTag_Actions.count=0) or ( not StSTag_Actions.locate('StatusAction', STS_ACTION_Use_Package_Tag, []) ) then
  begin
    StSTag_Actions.New;
    StSTag_Actions.StatusDate     := UsedOn;
    StSTag_Actions.StatusAction   := STS_ACTION_Use_Package_Tag;
    StSTag_Actions.ActionQty      := -1;
    StSTag_Actions.TagProductID   := TagProductID;
    StSTag_Actions.StSProductID   := 0;
    StSTag_Actions.StatusActionId := NewStsAction(STS_ACTION_Use_Package_Tag);
    StSTag_Actions.PostDB;
    stepProgress;
    Result:= True;
  end;
end;

Function TStSTags.UseTag:Boolean;
begin
          if (StSTag_Actions.count=0) or
              ((not(StSTag_Actions.locate('StatusAction' ,STS_ACTION_Use_Plant_Tag      , []))) and
               (not(StSTag_Actions.locate('StatusAction' ,STS_ACTION_CHANGE_GROWTH_PHASE, []))) ) then begin
              StSTag_Actions.New;
              StSTag_Actions.StatusDate     := UsedOn;
              StSTag_Actions.StatusAction   := STS_ACTION_Use_Plant_Tag;
              StSTag_Actions.ActionQty      := -1;
              StSTag_Actions.TagProductID   := TagProductID;
              StSTag_Actions.StSProductID   := 0;
              StSTag_Actions.StatusActionId := NewStsAction(STS_ACTION_Use_Plant_Tag);
              StSTag_Actions.PostDB;
              stepProgress;
          end;
          Result:= true;
end;
function TStSTags.UseTagnMakePlant: Boolean;
begin
  UseTag;
  MakePlant(Plantcount);
  Result := Save;
end;

Function TStSTags.MakePlant(aQty:Double):Boolean;
begin
          if (StSTag_Actions.count=0) or
              (not(StSTag_Actions.locate('StatusAction' ,STS_ACTION_Make_Plant      , [])))   then begin
              StSTag_Actions.New;
              StSTag_Actions.StatusDate     := UsedOn;
              StSTag_Actions.StatusAction   := STS_ACTION_Make_Plant;
              StSTag_Actions.ActionQty      := trunc(aQty);
              StSTag_Actions.TagProductID   := 0;
              StSTag_Actions.StSProductID   := StSProductID;
              StSTag_Actions.StatusActionId := NewStsAction(STS_ACTION_Use_Plant_Tag);
              StSTag_Actions.PostDB;
              stepProgress;
          end;
          Result:= true;
end;


function TStSTags.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  PostDB;
  Result := inherited Save;
  if not result then exit;
    StSTagSM:= TStockMovement.create(Self);
    try
      StSTagSM.loadSelect('StockmovementEntryType =' + Quotedstr(XMLNodename)+' and StockmovementEntryglobalref =' + quotedstr(Globalref));
      if StSTagSM.count =0 then begin
        StSTagSM.New;
        StSTagSM.SMEType      := XMLNodename;
        StSTagSM.SMEGlobalref := Globalref;
        StSTagSM.MovementDate := UsedOn;
        StSTagSM.EmployeeID   := EmployeeID;
        StSTagSM.AccountID    :=  TAccount.IDToggle(Appenv.companyprefs.StSStockAccount);
        if StSTagSM.AccountID =0 then StSTagSM.AccountID := TAccount.IDToggle('Stock Adjustment');
        StSTagSM.employeeID   := EmployeeID;
        StSTagSM.PostDB;
        stepProgress;
      end;
      StsTagPhases.IterateRecords(SaveCallback);
      StSTag_Actions.Iteraterecords(StSTagsSaveCallback, false, true);
    finally
      Freeandnil(StSTagSM);
    end;
end;

function TStSTags.SavePackage: Boolean;
begin
  Result := False;
  if not ValidatePackageData then Exit;
  PostDB;
  Result := inherited Save;
  if not Result then exit;

  StSTagSM:= TStockMovement.create(Self);
  try
    StSTagSM.loadSelect('StockmovementEntryType =' + Quotedstr(XMLNodename)+' and StockmovementEntryglobalref =' + quotedstr(Globalref));
    if StSTagSM.count =0 then begin
      StSTagSM.New;
      StSTagSM.SMEType      := XMLNodename;
      StSTagSM.SMEGlobalref := Globalref;
      StSTagSM.MovementDate := UsedOn;
      StSTagSM.EmployeeID   := EmployeeID;
      StSTagSM.AccountID    :=  TAccount.IDToggle(Appenv.companyprefs.StSStockAccount);
      if StSTagSM.AccountID =0 then StSTagSM.AccountID := TAccount.IDToggle('Stock Adjustment');
      StSTagSM.employeeID   := EmployeeID;
      StSTagSM.PostDB;
      stepProgress;
    end;
    StSTag_Actions.Iteraterecords(StSTagsSaveCallback, false, true);
  finally
    Freeandnil(StSTagSM);
  end;
end;

procedure TStSTags.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  fsRoomLocation  := '';
  fsRoomNumber    := '';
end;


procedure TStSTags.InitfieldsAfterclone;
begin
    DoFieldOnChange(Dataset.findfield('TagProductId'));
    initStSPhaseProduct;
end;
Procedure TStSTags.initStSPhaseProduct;
begin
  if (StrainID<>0) and ( StsPhase<>'') then begin
             if PhaseProductID <> 0 then StSProductID := PhaseProductID
        else if StsPhase ='I' then StSProductID := StSStrain.ImmatureProductID
        else if StsPhase ='V' then StSProductID := StSStrain.VegetativeProductId
        else if StsPhase ='F' then StSProductID := StSStrain.FloweringProductID
        else StSProductID := 0;
  end else StSProductID :=0;
  SendEvent(BusObjEvent_Change, BusObjEventVal_StsPhaseChanged, self);
end;

procedure TStSTags.DoFieldOnChange(Sender: TField);
var
  Qry:TERPQuery;
  Procedure ValidatePlantcount;
  begin
        if (Plantcount<>1) and ((StsPhase ='V') or (StsPhase ='F')) then begin
          Plantcount:= 1;
          Resultstatus.AddItem(False , rssError , 0,  'Each Plant is assigned a separate tag in  ' +PhaseDescription+ ' Phase.' , true );
        end;
  end;
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
      inherited;
      if Sysutils.SameText(Sender.FieldName, 'StsTag') then begin
          with StSTagProductLookup do begin
            if recordcount >0 then begin
                First;
                TagProductID:= Fieldbyname('productID').asInteger;
                UOMID       := Fieldbyname('uomid').asInteger;
                Deptid      := Fieldbyname('departmentId').asinteger;
            end;
          end;
      end else if Sysutils.SameText(Sender.FieldName, 'StrainName') then begin
        StrainId :=  TStSStrain.IDToggle(StrainName);
        DoFieldOnChange(Dataset.Findfield('StrainId'));
      end else if Sysutils.SameText(Sender.FieldName, 'StrainId') then begin
        initStSPhaseProduct;
      end else if Sysutils.SameText(Sender.FieldName, 'StSPhase') then begin
        initStSPhaseProduct;
        ValidatePlantcount;
      end else if Sysutils.SameText(Sender.FieldName, 'Dept') then begin
        DeptId := TDEptClass.IdToggle(Dept);
        DoFieldOnChange(Dataset.Findfield('DeptId'));
      end else if Sysutils.SameText(Sender.FieldName, 'DeptId') then begin
        Dept := TDEptClass.IdToggle(DeptID);
        if (binId=0) and (DeptID<>0) and (StSProductID<>0) then begin
            Qry := SharedQuery;
            try
               Qry.SQL.Text := 'select defaultbinid '+
                               ' FROM tblproductclasses  '+
                               ' WHERE productId =' + inttostr(stsProductID)+
                               ' AND classId = ' + inttostr(DeptID);
               Qry.Open;
               if Qry.fieldbyname('DefaultBinID').asInteger <> 0 then
            finally
               DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
            end;
        end;
        SendEvent(BusObjEvent_Change, BusObjEventVal_DeptChanged, self);
      end else if Sysutils.SameText(Sender.FieldName, 'Plantcount') then begin
        ValidatePlantcount;
      end else if Sysutils.SameText(Sender.FieldName, 'TagProductId') then begin
        if TagProductId <> 0 then
          With TProduct.create(self) do try
            connection := Self.connection;
            Load(TagProductId);
            UOMID :=  UOMSalesID
          finally
            Free;
          end;
      end else if Sysutils.SameText(Sender.FieldName, 'UsedOn') then begin
        if SourceTagDate >0 then
          if usedon < SourceTagDate then if devmode then UsedOn := incday(SourceTagDate,1) else UsedOn := incsecond(SourceTagDate,10);
      end;

end;


function TStSTags.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TStSTags.GetIDField: string;
begin
  Result := 'ID'
end;


class function TStSTags.GetKeyStringField: string;
begin
  Result := 'StSTag'
end;

class function TStSTags.GetBusObjectTablename: string;
begin
  Result:= 'tblststags';
end;

function TStSTags.getCleanStsPhase: String;
begin
  Result := GetXMLNodeStringValue(CleanXMLNOde, 'StsPhase');
end;

function TStSTags.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  Plantcount := 1;
  DeptID := AppEnv.CompanyPrefs.StSConfig.StsDefaultclassId;
  SendEvent(BusObjEvent_Change, BusObjEvent_StSTAgClassChanged, self);
  StSPhase := 'I';
  UsedOn := now;
end;

function TStSTags.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TStSTags.getStSStrain: TStSStrain;
begin
  Result :=TStSStrain (GetContainercomponent(TStSStrain , 'ID =' +inttostr(StrainID)));
end;
function TStSTags.getStSTag_Actions: TStSTag_Actions;
begin
  Result := TStSTag_Actions(GetcontainerComponent(TStSTag_Actions , 'TagID=' + inttostr(ID)));
end;
function TStSTags.getTagChanged: Boolean;
begin
  fbTagChanged := False;
  if StSTagPhases.Tagchanged then fbTagChanged := true
  else StSTagPhases.iteraterecords(TagchangedcheckCallback);
  Result := fbTagChanged;
end;
Procedure TStSTags.TagchangedcheckCallback(Const Sender: TBusObj; var Abort: boolean);
begin
  if sender is   TStSTagPhases then begin
    if TStSTagPhases(Sender).Tagchanged then begin
       fbTagChanged := true;
       Abort := true;
    end;
  end;
end;
Function TStSTags.NewPhase(const NewActionDesc:String; ChangePhaseFunc:TBusObjBoolFunc ):Boolean;
var
  fiActionID :Integer;
begin
   Result := False;
   fiActionID := NewStsAction(NewActionDesc);
   if fiActionID = 0 then begin
    REsult := False;
    Exit;
   end;
   ChangeGrowthPhase(0, 0); // makes the action record with 0 qty
   StSTagPhases.new;
   StSTagPhases.PostDB;
   if Assigned(ChangePhaseFunc) then
    Result := ChangePhaseFunc(Self)
   else Result := True;
   if result then
    REsult := Save;
end;

Class Function TStSTags.NewStsAction(const Value:String):Integer;
begin
  Result := TSimpleTypes.ChecknMakeSimpleType(TStSAction.SimpleTypecode,Value);
end;

Function TStSTags.isTagActive:Boolean;
begin
    Result := False;

    if StSPhase ='D' then begin
      Resultstatus.AddItem(False , rssError , 0,  quotedstr(stsTAg)+ ' Tag is Destroyed' , true );
      Exit;
    end;
    if Activecount = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  quotedstr(stsTAg)+ ' Tag''s Phase Changed / Replaced / Wasted / Transferred / Used.' , true );
      Exit;
    end;
    Result := True;
end;

Function  TStSTags.TransferTagto(aClassID,abinID: Integer; aTransferingemployeeId:Integer; TransferDate:TDateTime):boolean;
var
  fiTransferedcount :Integer;
  aStSTags :TStSTags;
begin
  REsult := False;
  if not isTagActive then exit;
  fiTransferedcount := ActiveCount;
  stepProgress;
  {Tag +1}
    {IN-bring it back to stock}
      StSTag_Actions.New;
      StSTag_Actions.StatusDate := incsecond(TransferDate,-5);// less 1 seconds for the stockmovement
      StSTag_Actions.StatusAction := STS_SOURCE_TYPE_TransferFrom;
      StSTag_Actions.StatusActionId := NewStsAction(STS_SOURCE_TYPE_TransferFrom);
      StSTag_Actions.StsProductId := 0;
      StSTag_Actions.TagProductId := TagProductId;
      StSTag_Actions.ActionQty := 1;
      StSTag_Actions.PostDB;
      stepProgress;
    {OUT-transfer to the other dept }
      StSTag_Actions.New;
      StSTag_Actions.StatusDate := incsecond(TransferDate,-4);// less 1 seconds for the stockmovement
      StSTag_Actions.StatusAction := STS_SOURCE_TYPE_TransferFrom;
      StSTag_Actions.StatusActionId := NewStsAction(STS_SOURCE_TYPE_TransferFrom);
      StSTag_Actions.StsProductId := 0;
      StSTag_Actions.TagProductId := TagProductId;
      StSTag_Actions.ActionQty := -1;
      StSTag_Actions.PostDB;
      stepProgress;

  {Plant -1}
    {take to the other department}
      StSTag_Actions.New;
      StSTag_Actions.StatusDate := incsecond(TransferDate,-3); // less 1 seconds for the stockmovement
      StSTag_Actions.StatusAction := STS_SOURCE_TYPE_TransferFrom;
      StSTag_Actions.StatusActionId := NewStsAction(STS_SOURCE_TYPE_TransferFrom);
      StSTag_Actions.StsProductId := stsProductId;
      StSTag_Actions.TagProductId := 0;
      StSTag_Actions.ActionQty := 0-fiTransferedcount;
      StSTag_Actions.PostDB;
      stepProgress;


  Transferedcount := Transferedcount + fiTransferedcount;
  PostDB;
  REsult := Save;
  if not result then exit;

  stepProgress;
  aStSTags := TStSTags(GetComponentByClassType(TStSTags, False));
  try
      aStSTags.Load(0);
      aStSTags.new;
      aStSTags.StsTag := self.StsTag;
      aStSTags.TagProductID := self.TagProductID;
      aStSTags.StSProductID := self.StSProductID;
      aStSTags.SourceTagID := self.ID;
      aStSTags.SourceTag := self.StsTag;
      aStSTags.Sourcetype := STS_SOURCE_TYPE_TransferTo;
      aStSTags.StSTagPhaseID := 0;
      aStSTags.StSActionID := 0;
      aStSTags.DeptID := aClassID;
      aStSTags.UOMID := self.UOMID;
      aStSTags.Planttype := self.Planttype;
      aStSTags.UsedOn := TransferDate;
      aStSTags.StrainID := self.StrainID;
      aStSTags.StrainName := self.StrainName;
      aStSTags.Plantcount := fiTransferedcount;
      aStSTags.ChangedCount := 0;
      aStSTags.WastedCount := 0;
      aStSTags.Destroycount := 0;
      aStSTags.Harvestcount := 0;
      aStSTags.UsedCount := 0;
      aStSTags.TransferedCount := 0;
      aStSTags.StSPhase := self.StSPhase;
      aStSTags.EmployeeId := aTransferingemployeeId;
      aStSTags.ReplacedByTagID := 0;
      if (self.binid <> 0) then
        if (abinID =0) then
             aStSTags.BinID:=  TProductBin.MakebinforClass(Self, self.binid, aClassID)
        else aStSTags.BinID:=  abinID;
      aStSTags.PostDB;
    {plant}
      {into the stock}
      stepProgress;
      aStSTags.StSTag_Actions.New;
      aStSTags.StSTag_Actions.StatusDate := incsecond(TransferDate,-2);
      aStSTags.StSTag_Actions.StatusAction := STS_SOURCE_TYPE_TransferTo;
      aStSTags.StSTag_Actions.StatusActionId := NewStsAction(STS_SOURCE_TYPE_TransferTo);
      aStSTags.StSTag_Actions.StsProductId := aStSTags.StsProductId;
      aStSTags.StSTag_Actions.TagProductId := 0;
      aStSTags.StSTag_Actions.ActionQty := fiTransferedcount;
      aStSTags.StSTag_Actions.PostDB;
      stepProgress;
     {tag}
      {bring tag into the department}
      aStSTags.StSTag_Actions.New;
      aStSTags.StSTag_Actions.StatusDate := incsecond(TransferDate,-1);
      aStSTags.StSTag_Actions.StatusAction := STS_SOURCE_TYPE_TransferTo;
      aStSTags.StSTag_Actions.StatusActionId := NewStsAction(STS_SOURCE_TYPE_TransferTo);
      aStSTags.StSTag_Actions.StsProductId := 0;
      aStSTags.StSTag_Actions.TagProductId := aStSTags.TagProductId;
      aStSTags.StSTag_Actions.ActionQty := 1;
      aStSTags.StSTag_Actions.PostDB;
      stepProgress;
      Result := aStSTags.Save;

      {use tag from stock}
      aStSTags.StSTag_Actions.New;
      aStSTags.StSTag_Actions.StatusDate := TransferDate;
      aStSTags.StSTag_Actions.StatusAction := STS_SOURCE_TYPE_TransferTo;
      aStSTags.StSTag_Actions.StatusActionId := NewStsAction(STS_SOURCE_TYPE_TransferTo);
      aStSTags.StSTag_Actions.StsProductId := 0;
      aStSTags.StSTag_Actions.TagProductId := aStSTags.TagProductId;
      aStSTags.StSTag_Actions.ActionQty := 0-1;
      aStSTags.StSTag_Actions.PostDB;
      stepProgress;
      Result := aStSTags.Save;
      stepProgress;
  finally
     Freeandnil(aStSTags)
  end;
end;

function TStSTags.getStSTagProduct: TStSTagProduct;
begin
  Result := TStSTagProduct(GetcontainerComponent(TStSTagProduct , 'TagID=' + inttostr(ID)));
end;
function TStSTags.getStSTagProductLookup: TERPQuery;
begin
  if fStSTagProductLookup = nil then begin
    fStSTagProductLookup:= TERPQuery.Create(Self);
    fStSTagProductLookup.Connection := Self.connection.connection;
(*    fStSTagProductLookup.SQL.Text :=  'SELECT distinct pqa.productname, pqa.productID , pqa.uomid, pqa.uom , pqa.DepartmentId '+
                                       ' FROM tblpqadetails PQASN '+
                                       ' INNER JOIN tblpqa pqa ON pqasn.pqaid = pqa.pqaid WHERE PQASN.PQAType ="SN" '+
                                       ' AND pqasn.value = :StSTag';*)
    fStSTagProductLookup.SQL.Text :=  'SELECT distinct pqa.productname, pqa.productID , pqa.uomid, pqa.uom , pqa.departmentid ' +
                               ' FROM tblpqadetails PQASN ' +
                               ' INNER JOIN tblpqa pqa ON pqasn.pqaid = pqa.pqaid  ' +
                               ' AND productId IN (' + inttostr(TProduct.IDToggle(Appenv.companyprefs.StSPackageTagProduct))+',' + inttostr(TProduct.IDToggle(Appenv.companyprefs.StSPlantTagProduct))+') ' +
                               ' WHERE PQASN.PQAType ="SN" ' +
                               ' AND pqasn.value = :StSTag ' ;
  end;
  if not(fStSTagProductLookup.active) or (not(Sametext(fStSTagProductLookup.Parambyname('StSTag').asString, ststag))) then begin
    commondblib.closedb(fStSTagProductLookup);
    fStSTagProductLookup.Parambyname('StSTag').asString:= ststag;
    commondblib.Opendb(fStSTagProductLookup);
  end;
  result := fStSTagProductLookup;
end;

function TStSTags.getStSTagPhases: TStSTagPhases;
begin
  Result := TStSTagPhases(GetcontainerComponent(TStSTagPhases , 'TagID=' + inttostr(ID)));
end;
function TStSTags.getPhaseDescription: String;
begin
  REsult := StsPhaseCodeTodesc(StSPhase);
end;
function TStSTags.getSourceTagDate: TDatetime;
var
  aQty:double;
  aTransdate:TDateTime;
begin
  result :=0;
  if SourceTagID <> 0 then begin
     TStSTags.TagDate(SourceTagID, aQty, aTransdate);
     result := aTransdate;
  end;
end;
Class Procedure  TStSTags.TagDate(aTagID:Integer; var aQty:double; var aTransdate:TDateTime);
var
  aStSTag :TStSTags;
  Qry:TERPQuery;
begin
  aStSTag := TStSTags.CreateWithNewConn(nil);
  Try
    aStSTag.load(aTagID);
    aTransdate :=aStSTag.UsedOn;
    Qry := aStSTag.SharedQuery;
    try
       Qry.SQL.Text := SQL4ProductQty(0, '', tDetailswithSno, aStSTag.TagProductId, aStSTag.DeptID, '', 0, '', '', aStSTag.StsTag, tAvailable, 'PQA.transdate as TransDate');
       Qry.Open;
       aQty:= Qry.fieldbyname('uomQty').asFloat;
       if aTransdate < Qry.fieldbyname('transdate').asDatetime then aTransdate := Qry.fieldbyname('transdate').asDatetime;
    finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
  Finally
    Freeandnil(aStSTag);
  End;

end;

{Property Functions}
function  TStSTags.getCleanChangedCount             : Integer   ; begin Result := GetXMLNodeIntegerValue(CleanXMLNOde, 'ChangedCount');end;
function  TStSTags.getCleanWastedCount              : Integer   ; begin Result := GetXMLNodeIntegerValue(CleanXMLNOde, 'WastedCount' );end;
function  TStSTags.getCleanDestroycount             : Integer   ; begin Result := GetXMLNodeIntegerValue(CleanXMLNOde, 'Destroycount');end;
function  TStSTags.getCleanTransferedCount          : Integer   ; begin Result := GetXMLNodeIntegerValue(CleanXMLNOde, 'TransferedCount');end;
function  TStSTags.getCleanUsedCount                : Integer   ; begin Result := GetXMLNodeIntegerValue(CleanXMLNOde, 'UsedCount'   );end;
function  TStSTags.GetStsTag                        : string    ; begin Result := GetStringField('StsTag')                        ;end;
function  TStSTags.GetTagProductID                  : Integer   ; begin Result := GetIntegerField('TagProductID')                 ;end;
function  TStSTags.GetSourceTagID                   : Integer   ; begin Result := GetIntegerField('SourceTagID')                  ;end;
function  TStSTags.GetSourceTag                     : string    ; begin Result := GetStringField('SourceTag')                     ;end;
function  TStSTags.GetSourcetype                    : string    ; begin Result := GetStringField('Sourcetype')                    ;end;
function  TStSTags.GetStSPhase                      : string    ; begin Result := GetStringField('StSPhase')                      ;end;
function  TStSTags.GetStSTagPhaseID                 : Integer   ; begin Result := GetIntegerField('StSTagPhaseID')                ;end;
function  TStSTags.GetStSActionID                   : Integer   ; begin Result := GetIntegerField('StSActionID')                  ;end;
function  TStSTags.GetDeptID                        : Integer   ; begin Result := GetIntegerField('DeptID')                       ;end;
function  TStSTags.GetDept                          : string    ; begin Result := GetStringField('Dept')                          ;end;
function  TStSTags.GetUOMID                         : Integer   ; begin Result := GetIntegerField('UOMID')                        ;end;
function  TStSTags.GetBinID                         : Integer   ; begin Result := GetIntegerField('BinID')                        ;end;
function  TStSTags.GetPlanttype                     : string    ; begin Result := GetStringField('Planttype')                     ;end;
function  TStSTags.GetUsedOn                        : TDateTime ; begin Result := GetDateTimeField('UsedOn')                      ;end;
function  TStSTags.GetStrainID                      : Integer   ; begin Result := GetIntegerField('StrainID')                     ;end;
function  TStSTags.GetStrainName                    : string    ; begin Result := GetStringField('StrainName')                    ;end;
function  TStSTags.GetPlantcount                    : Integer   ; begin Result := GetIntegerField('Plantcount')                   ;end;
function  TStSTags.GetChangedCount                  : Integer   ; begin Result := GetIntegerField('ChangedCount')                 ;end;
function  TStSTags.GetWastedCount                   : Integer   ; begin Result := GetIntegerField('WastedCount')                  ;end;
function  TStSTags.GetDestroycount                  : Integer   ; begin Result := GetIntegerField('Destroycount')                 ;end;
function  TStSTags.GetHarvestcount                  : Integer   ; begin Result := GetIntegerField('Harvestcount')                 ;end;
function  TStSTags.GetTransferedCount               : Integer   ; begin Result := GetIntegerField('TransferedCount')              ;end;
function  TStSTags.GetUsedCount                     : Integer   ; begin Result := GetIntegerField('UsedCount')                    ;end;
function  TStSTags.GetStSProductID                  : Integer   ; begin Result := GetIntegerField('StSProductID')                 ;end;
function  TStSTags.GetReplacedByTagID               : Integer   ; begin Result := GetIntegerField('ReplacedByTagID')              ;end;
function  TStSTags.GetEmployeeID                    : Integer   ; begin Result := GetIntegerField('EmployeeID')                   ;end;
function  TStSTags.GetActivecount                   : Integer   ; begin Result := Plantcount - (ChangedCount +WastedCount+Destroycount+Harvestcount+TransferedCount+UsedCount);end;
function  TStSTags.GetRoomLocation                  : string    ; begin Result := tcdatautils.GetBinLocation(BinID);end;
function  TStSTags.GetRoomNumber                    : string    ; begin Result := tcdatautils.GetBinnumber(BinID);end;

procedure TStSTags.SetStsTag                        (const Value: string    ); begin SetStringField('StsTag'                        , Value);end;
procedure TStSTags.SetTagProductID                  (const Value: Integer   ); begin SetIntegerField('TagProductID'                 , Value);end;
procedure TStSTags.SetSourceTagID                   (const Value: Integer   ); begin SetIntegerField('SourceTagID'                  , Value);end;
procedure TStSTags.SetSourceTag                     (const Value: string    ); begin SetStringField('SourceTag'                     , Value);end;
procedure TStSTags.SetSourcetype                    (const Value: string    ); begin SetStringField('Sourcetype'                    , Value);end;
procedure TStSTags.SetStSPhase                      (const Value: string    ); begin SetStringField('StSPhase'                      , Value);end;
procedure TStSTags.SetStSTagPhaseID                 (const Value: Integer   ); begin SetIntegerField('StSTagPhaseID'                , Value);end;
procedure TStSTags.SetStSActionID                   (const Value: Integer   ); begin SetIntegerField('StSActionID'                  , Value);end;
procedure TStSTags.SetDeptID                        (const Value: Integer   ); begin SetIntegerField('DeptID'                       , Value);end;
procedure TStSTags.SetDept                          (const Value: string    ); begin SetStringField('Dept'                          , Value);end;
procedure TStSTags.SetUOMID                         (const Value: Integer   ); begin SetIntegerField('UOMID'                        , Value);end;
procedure TStSTags.SetBinID                         (const Value: Integer   ); begin SetIntegerField('BinID'                        , Value);end;
procedure TStSTags.SetPlanttype                     (const Value: string    ); begin SetStringField('Planttype'                     , Value);end;
procedure TStSTags.SetUsedOn                        (const Value: TDateTime ); begin SetDateTimeField('UsedOn'                      , Value);end;
procedure TStSTags.SetStrainID                      (const Value: Integer   ); begin SetIntegerField('StrainID'                     , Value);end;
procedure TStSTags.SetStrainName                    (const Value: string    ); begin SetStringField('StrainName'                    , Value);end;
procedure TStSTags.SetPlantcount                    (const Value: Integer   ); begin SetIntegerField('Plantcount'                   , Value);end;
procedure TStSTags.SetChangedCount                  (const Value: Integer   ); begin SetIntegerField('ChangedCount'                 , Value);end;
procedure TStSTags.SetWastedCount                   (const Value: Integer   ); begin SetIntegerField('WastedCount'                  , Value);end;
procedure TStSTags.SetDestroycount                  (const Value: Integer   ); begin SetIntegerField('Destroycount'                 , Value);end;
procedure TStSTags.SetHarvestcount                  (const Value: Integer   ); begin SetIntegerField('Harvestcount'                 , Value);end;
procedure TStSTags.SetTransferedCount               (const Value: Integer   ); begin SetIntegerField('TransferedCount'              , Value);end;
procedure TStSTags.SetUsedCount                     (const Value: Integer   ); begin SetIntegerField('UsedCount'                    , Value);end;
procedure TStSTags.SetStSProductID                  (const Value: Integer   ); begin SetIntegerField('StSProductID'                 , Value);end;
procedure TStSTags.SetReplacedByTagID               (const Value: Integer   ); begin SetIntegerField('ReplacedByTagID'              , Value);end;
procedure TStSTags.SetEmployeeID                    (const Value: Integer   ); begin SetIntegerField('EmployeeID'                   , Value);end;
procedure TStSTags.SetRoomLocation                  (const Value: string    ); begin fsRoomLocation := value; initBinID; end;
procedure TStSTags.SetRoomNumber                    (const Value: string    ); begin fsRoomNumber   := value; initBinID;end;
procedure TStSTags.initBinID;
begin
  if (trim(fsRoomLocation) <> '') and (trim(fsRoomNumber)<> '') then begin
    BinID  :=   tcdatautils.GetBinID(fsRoomLocation, fsRoomNumber, DeptID);
    if (BinID =0) then
      BinID:= TProductBin.MakebinforClass(self, DeptID, fsRoomLocation, fsRoomNumber,1 );
  end;
end;


class function TStSTags.StSTagrec(AOwner:Tcomponent; Const aTagID:Integer;aConnection: TERPConnection      ; aBusObjEvent: TBusObjEvent): TStSTags;
begin
  Result := TStSTags.CreateWithNewConn(AOwner,aConnection);
  Result.BusObjEvent := aBusObjEvent;
  Result.Load(aTagID);
end;
Class function TStSTags.StSTagrec(AOwner:Tcomponent; (*const aTag: String;*)const aTagID:Integer;aConnection: TMyDAcDataconnection; aBusObjEvent: TBusObjEvent): TStSTags;
begin
  if aConnection <> nil then begin
    Result := TStSTags.Create(AOwner);
    Result.Connection := aconnection;
  end else begin
    Result := TStSTags.CreateWithNewConn(AOwner);
  end;
  Result.BusObjEvent := aBusObjEvent;
  Result.Closedb;
  Result.Load(aTagID);
end;

  {TStSTagPhases}

constructor TStSTagPhases.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'StSTagPhases';
  fSQL := 'SELECT * FROM tblststagphases';
end;


destructor TStSTagPhases.Destroy;
begin
  inherited;
end;


procedure TStSTagPhases.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TagID');
  SetPropertyFromNode(node,'QtyPerTag');
  SetPropertyFromNode(node,'NoOfTags');
  SetPropertyFromNode(node,'PhaseProductID');
  SetPropertyFromNode(node,'SMLineID');
  SetBooleanPropertyFromNode(node,'TagChanged');
  SetDateTimePropertyFromNode(node,'PhaseCreatedOn');
  SetPropertyFromNode(node,'StSPhase');
end;


procedure TStSTagPhases.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TagID' ,TagID);
  AddXMLNode(node,'QtyPerTag' ,QtyPerTag);
  AddXMLNode(node,'NoOfTags' ,NoOfTags);
  AddXMLNode(node,'PhaseProductID' ,PhaseProductID);
  AddXMLNode(node,'SMLineID' ,SMLineID);
  AddXMLNode(node,'TagChanged' ,TagChanged);
  AddXMLNode(node,'PhaseCreatedOn' ,PhaseCreatedOn);
  AddXMLNode(node,'StSPhase' ,StSPhase);
end;


function TStSTagPhases.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if TagID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'TagID should not be 0' , False );
    Exit;
  end;
  if QtyPerTag = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'QtyPerTag should not be 0' , False );
    Exit;
  end;
  if NoOfTags = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'NoOfTags should not be 0' , False );
    Exit;
  end;
  if PhaseProductID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PhaseProductID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TStSTagPhases.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TStSTagPhases.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TStSTagPhases.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
      inherited;
    if Sysutils.SameText(Sender.FieldName, 'QtyPerTag')  or Sysutils.SameText(Sender.FieldName, 'NoOfTags')  then begin
      if Assigned(Owner) then
        if Owner is TStsTags then begin
          TStsTags(Owner).ChangedCount := TStsTags(Owner).CleanChangedCount +  QtyPerTag* NoOfTags;
          TStsTags(Owner).PostDB;
        end;
    end;
end;


function TStSTagPhases.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TStSTagPhases.GetIDField: string;
begin
  Result := 'ID'
end;


class function TStSTagPhases.GetBusObjectTablename: string;
begin
  Result:= 'tblststagphases';
end;


function TStSTagPhases.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  if assigned (Owner) then
    if Owner is TStSTags then begin
      TagID :=TStSTags(Owner).Id;
    end;
  QtyPerTag := 1;
  NoOfTags :=0;
  PhaseCreatedOn := now;
end;

function TStSTagPhases.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TStSTagPhases.GetTagID           : Integer   ; begin Result := GetIntegerField('TagID');end;
function  TStSTagPhases.GetQtyPerTag       : Integer   ; begin Result := GetIntegerField('QtyPerTag');end;
function  TStSTagPhases.GetNoOfTags        : Integer   ; begin Result := GetIntegerField('NoOfTags');end;
function  TStSTagPhases.GetPhaseProductID  : Integer   ; begin Result := GetIntegerField('PhaseProductID');end;
function  TStSTagPhases.GetSMLineID        : Integer   ; begin Result := GetIntegerField('SMLineID');end;
function  TStSTagPhases.GetTagChanged      : Boolean   ; begin Result := GetBooleanField('TagChanged');end;
function  TStSTagPhases.GetPhaseCreatedOn  : TDateTime ; begin Result := GetDateTimeField('PhaseCreatedOn');end;
function  TStSTagPhases.GetStSPhase        : String    ; begin Result := GetStringField('StSPhase');end;

procedure TStSTagPhases.SetTagID           (const Value: Integer   ); begin SetIntegerField('TagID'            , Value);end;
procedure TStSTagPhases.SetQtyPerTag       (const Value: Integer   ); begin SetIntegerField('QtyPerTag'        , Value);end;
procedure TStSTagPhases.SetNoOfTags        (const Value: Integer   ); begin SetIntegerField('NoOfTags'         , Value);end;
procedure TStSTagPhases.SetPhaseProductID  (const Value: Integer   ); begin SetIntegerField('PhaseProductID'   , Value);end;
procedure TStSTagPhases.SetSMLineID        (const Value: Integer   ); begin SetIntegerField('SMLineID'         , Value);end;
procedure TStSTagPhases.SetTagChanged      (const Value: Boolean   ); begin SetBooleanField('TagChanged'       , Value);end;
procedure TStSTagPhases.SetPhaseCreatedOn  (const Value: TDateTime ); begin SetDateTimeField('PhaseCreatedOn'  , Value);end;
procedure TStSTagPhases.SetStSPhase        (const Value: String    ); begin SetStringField('StSPhase'          , Value);end;


{TStSTag_Actions}

constructor TStSTag_Actions.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'StSTag_Actions';
  fSQL := 'SELECT * FROM tblststag_actions';
end;


destructor TStSTag_Actions.Destroy;
begin
  inherited;
end;


procedure TStSTag_Actions.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TagID');
  SetDateTimePropertyFromNode(node,'StatusDate');
  SetPropertyFromNode(node,'StatusActionId');
  SetPropertyFromNode(node,'StSProductID');
  SetPropertyFromNode(node,'TagProductID');
  SetPropertyFromNode(node,'StatusAction');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'ChangeToRoomID');
  SetPropertyFromNode(node,'ReplaceTagId');
  SetPropertyFromNode(node,'ActionQty');
  SetPropertyFromNode(node,'SMLLineID');
end;


procedure TStSTag_Actions.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TagID' ,TagID);
  AddXMLNode(node,'StatusDate' ,StatusDate);
  AddXMLNode(node,'StatusActionId' ,StatusActionId);
  AddXMLNode(node,'StSProductID' ,StSProductID);
  AddXMLNode(node,'TagProductID' ,TagProductID);
  AddXMLNode(node,'StatusAction' ,StatusAction);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'ChangeToRoomID' ,ChangeToRoomID);
  AddXMLNode(node,'ReplaceTagId' ,ReplaceTagId);
  AddXMLNode(node,'ActionQty' ,ActionQty);
  AddXMLNode(node,'SMLLineID' ,SMLLineID);
end;


function TStSTag_Actions.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if TagID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'TagID should not be 0' , False );
    Exit;
  end;
  if StatusDate = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'StatusDate should not be blank' , False );
    Exit;
  end;
  if StatusActionId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'StatusActionId should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TStSTag_Actions.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TStSTag_Actions.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TStSTag_Actions.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TStSTag_Actions.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TStSTag_Actions.GetIDField: string;
begin
  Result := 'ID'
end;


class function TStSTag_Actions.GetBusObjectTablename: string;
begin
  Result:= 'tblststag_actions';
end;


function TStSTag_Actions.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  if assigned (Owner) then
    if Owner is TStSTags then begin
      TagID :=TStSTags(Owner).Id;
    end;
end;

function TStSTag_Actions.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TStSTag_Actions.GetTagID           : Integer   ; begin Result := GetIntegerField('TagID');end;
function  TStSTag_Actions.GetStatusDate      : TDateTime ; begin Result := GetDateTimeField('StatusDate');end;
function  TStSTag_Actions.GetStatusActionId  : Integer   ; begin Result := GetIntegerField('StatusActionId');end;
function  TStSTag_Actions.GetStSProductID    : Integer   ; begin Result := GetIntegerField('StSProductID');end;
function  TStSTag_Actions.GetTagProductID    : Integer   ; begin Result := GetIntegerField('TagProductID');end;
function  TStSTag_Actions.GetStatusAction    : string    ; begin Result := GetStringField('StatusAction');end;
function  TStSTag_Actions.GetDescription     : string    ; begin Result := GetStringField('Description');end;
function  TStSTag_Actions.GetChangeToRoomID  : Integer   ; begin Result := GetIntegerField('ChangeToRoomID');end;
function  TStSTag_Actions.GetReplaceTagId    : Integer   ; begin Result := GetIntegerField('ReplaceTagId');end;
function  TStSTag_Actions.GetActionQty       : Integer   ; begin Result := GetIntegerField('ActionQty');end;
function  TStSTag_Actions.GetSMLLineID       : Integer   ; begin Result := GetIntegerField('SMLLineID');end;
procedure TStSTag_Actions.SetTagID           (const Value: Integer   ); begin SetIntegerField('TagID'            , Value);end;
procedure TStSTag_Actions.SetStatusDate      (const Value: TDateTime ); begin SetDateTimeField('StatusDate'       , Value);end;
procedure TStSTag_Actions.SetStatusActionId  (const Value: Integer   ); begin SetIntegerField('StatusActionId'   , Value);end;
procedure TStSTag_Actions.SetStSProductID    (const Value: Integer   ); begin SetIntegerField('StSProductID'   , Value);end;
procedure TStSTag_Actions.SetTagProductID    (const Value: Integer   ); begin SetIntegerField('TagProductID'   , Value);end;
procedure TStSTag_Actions.SetStatusAction    (const Value: string    ); begin SetStringField('StatusAction'     , Value);end;
procedure TStSTag_Actions.SetDescription     (const Value: string    ); begin SetStringField('Description'      , Value);end;
procedure TStSTag_Actions.SetChangeToRoomID  (const Value: Integer   ); begin SetIntegerField('ChangeToRoomID'   , Value);end;
procedure TStSTag_Actions.SetReplaceTagId    (const Value: Integer   ); begin SetIntegerField('ReplaceTagId'     , Value);end;
procedure TStSTag_Actions.SetActionQty       (const Value: Integer   ); begin SetIntegerField('ActionQty'     , Value);end;
procedure TStSTag_Actions.SetSMLLineID       (const Value: Integer   ); begin SetIntegerField('SMLLineID'     , Value);end;


{TStSTagProduct}

constructor TStSTagProduct.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
  fBusObjectTypeDescription:= 'StSTagProduct';
  fSQL := 'SELECT * FROM tblststagproduct';
end;


destructor TStSTagProduct.Destroy;
begin
  inherited;
end;


procedure TStSTagProduct.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TagID');
  SetPropertyFromNode(node,'EmployeeId');
  SetPropertyFromNode(node,'ProductTagID');
  SetPropertyFromNode(node,'Productcount');
  SetPropertyFromNode(node,'StSProducttype');
  SetDateTimePropertyFromNode(node,'ProductionDate');
  SetPropertyFromNode(node,'Description');
end;


procedure TStSTagProduct.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TagID' ,TagID);
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
  AddXMLNode(node,'ProductTagID' ,ProductTagID);
  AddXMLNode(node,'Productcount' ,Productcount);
  AddXMLNode(node,'StSProducttype' ,StSProducttype);
  AddXMLNode(node,'ProductionDate' ,ProductionDate);
  AddXMLNode(node,'Description' ,Description);
end;


function TStSTagProduct.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if TagID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'TagID should not be 0' , True );
    Exit;
  end;
  if ProductTagID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ProductTagID should not be 0' , True );
    Exit;
  end;
  Result := True;
end;


function TStSTagProduct.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TStSTagProduct.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TStSTagProduct.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TStSTagProduct.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TStSTagProduct.GetIDField: string;
begin
  Result := 'ID'
end;


class function TStSTagProduct.GetBusObjectTablename: string;
begin
  Result:= 'tblststagproduct';
end;


function TStSTagProduct.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if owner is TStSTags then
      TagID:= TStSTags(Owner).ID;
  Productcount := 1;
  StSProducttype := 'Cutting';
  ProductionDate := now;
end;

function TStSTagProduct.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TStSTagProduct.GetTagID           : Integer   ; begin Result := GetIntegerField('TagID');end;
function  TStSTagProduct.GetEmployeeId      : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
function  TStSTagProduct.GetProductTagID    : Integer   ; begin Result := GetIntegerField('ProductTagID');end;
function  TStSTagProduct.GetProductcount    : Integer   ; begin Result := GetIntegerField('Productcount');end;
function  TStSTagProduct.GetStSProducttype  : string    ; begin Result := GetStringField('StSProducttype');end;
function  TStSTagProduct.GetProductionDate  : TDateTime ; begin Result := GetDateTimeField('ProductionDate');end;
function  TStSTagProduct.GetDescription     : string    ; begin Result := GetStringField('Description');end;
procedure TStSTagProduct.SetTagID           (const Value: Integer   ); begin SetIntegerField('TagID'            , Value);end;
procedure TStSTagProduct.SetEmployeeId      (const Value: Integer   ); begin SetIntegerField('EmployeeId'       , Value);end;
procedure TStSTagProduct.SetProductTagID    (const Value: Integer   ); begin SetIntegerField('ProductTagID'     , Value);end;
procedure TStSTagProduct.SetProductcount    (const Value: Integer   ); begin SetIntegerField('Productcount'     , Value);end;
procedure TStSTagProduct.SetStSProducttype  (const Value: string    ); begin SetStringField('StSProducttype'   , Value);end;
procedure TStSTagProduct.SetProductionDate  (const Value: TDateTime ); begin SetDateTimeField('ProductionDate'   , Value);end;
procedure TStSTagProduct.SetDescription     (const Value: string    ); begin SetStringField('Description'      , Value);end;


  {TStSHarvestLines}

procedure TStSHarvestLines.CalcTotals;
begin
  if Assigned(Owner) then
    if owner is TstsHarvest then
      TstsHarvest(Owner).CalcTotals;
end;

constructor TStSHarvestLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'StSHarvestLines';
  fSQL := 'SELECT * FROM tblstsharvestlines';
end;


destructor TStSHarvestLines.Destroy;
begin
  inherited;
end;


procedure TStSHarvestLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'HarvestID');
  SetPropertyFromNode(node,'SMLLineID');
  SetPropertyFromNode(node,'TagID');
  SetPropertyFromNode(node,'Qty');
  SetPropertyFromNode(node,'UOMQty');
  SetPropertyFromNode(node,'StSActionID');
  SetPropertyFromNode(node,'StsTag');
end;


procedure TStSHarvestLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'HarvestID' ,HarvestID);
  AddXMLNode(node,'SMLLineID' ,SMLLineID);
  AddXMLNode(node,'TagID' ,TagID);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'UOMQty' ,UOMQty);
  AddXMLNode(node,'StSActionID' ,StSActionID);
  AddXMLNode(node,'StsTag' , StsTag);
end;


function TStSHarvestLines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if (TagID =0) or (trim(StsTag) = '') then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please Choose a Tag.' , True );
    Exit;
  end;
  if (Qty =0) or (UOMQty =0) then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please Provide the Weight of ' + quotedstr(StsTag) +'.' , True );
    Exit;
  end;
  Result := True;
end;

Function TStSHarvestLines.MakeStockMovementLine:boolean;
var
  StSTagSM : TStockmovement;
begin
  REsult := False;
  if not Is_Inv_Product(StsProductID ) then begin
    // no need for stock movement
    REsult := True;
    Exit;
  end;
  Result := True;
  if SMLLineID =0 then begin
    if StSProductID <> 0 then begin
      if Assigned(Owner) and (Owner is TStSHarvest) then StSTagSM := TStSHarvest(Owner).StSTagSM else exit;
      StSTagSM.Lines.New;
      StSTagSM.Lines.MovementDate := HarvestDate;
      StSTagSM.Lines.ProductID    := StSProductID;
      StSTagSM.Lines.DeptID       := DeptID;
      StSTagSM.Lines.UOMID        := UOMID;
      StSTagSM.Lines.Unitofmeasure:= UOM;
      StSTagSM.Lines.UOMMultiplier:= UOMMultiplier;
      StSTagSM.Lines.Qty          := Qty;
      StSTagSM.Lines.UOMQty       := UOMQty;
      StSTagSM.Lines.DoOnProductchange;
      StSTagSM.Lines.PostDB;
      StSTagSM.Lines.CreateProductClass;

        if binID <> 0 then begin
          if StSTagSM.Lines.PQA.PQABins.count =0 then begin
            StSTagSM.Lines.PQA.PQABins.New;
            StSTagSM.Lines.PQA.PQABins.BinID := binID;
          end;
          StSTagSM.Lines.PQA.PQABins.Qty := Qty;
          StSTagSM.Lines.PQA.PQABins.uomQty := uomQty;
          StSTagSM.Lines.PQA.PQABins.PostDB;

        end;

      SMLLineID := StSTagSM.Lines.ID;
      PostDB;
    end;
  end;
end;

function TStSHarvestLines.Save: Boolean ;
begin
  Result := False;
  PostDB;
  if not ValidateData then Exit;
  if not StSTagObj.save then exit;
  if not MakeStockMovementLine then begin
    Resultstatus.AddItem(False , rssError , 0,  'Failed To update Stock for ' + quotedstr(StsTag) +'.' , True );
    Exit;
  end;
  Result := inherited Save;
end;


procedure TStSHarvestLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TStSHarvestLines.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
      inherited;
      if Sysutils.SameText(Sender.FieldName, 'Qty') then begin
        UOMQty := Divzer(Qty, UOMMultiplier);
      end else if Sysutils.SameText(Sender.FieldName, 'UOMQty') then begin
        Qty := UOMQty * UOMMultiplier;
      end;
end;


function TStSHarvestLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TStSHarvestLines.GetIDField: string;
begin
  Result := 'ID'
end;


class function TStSHarvestLines.GetBusObjectTablename: string;
begin
  Result:= 'tblstsharvestlines';
end;


function TStSHarvestLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Owner) then
    if owner is TStSHarvest then
      HarvestID := TStSHarvest(Owner).Id;

end;

function TStSHarvestLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then exit;
  Calctotals;
end;


{Property Functions}
function  TStSHarvestLines.GetHarvestID       : Integer   ; begin Result := GetIntegerField('HarvestID');end;
function  TStSHarvestLines.GetSMLLineID       : Integer   ; begin Result := GetIntegerField('SMLLineID');end;
function  TStSHarvestLines.GetTagID           : Integer   ; begin Result := GetIntegerField('TagID');end;
function  TStSHarvestLines.GetQty             : Double    ; begin Result := GetFloatField('Qty');end;
function  TStSHarvestLines.GetUOMQty          : Double    ; begin Result := GetFloatField('UOMQty');end;
function  TStSHarvestLines.GetStSActionID     : Integer   ; begin Result := GetIntegerField('StSActionID');end;
Function  TStSHarvestLines.GetStsTag          : String    ; begin Result := GetStringField('StsTag'); end;
procedure TStSHarvestLines.SetHarvestID       (const Value: Integer   ); begin SetIntegerField('HarvestID'        , Value);end;
procedure TStSHarvestLines.SetSMLLineID       (const Value: Integer   ); begin SetIntegerField('SMLLineID'        , Value);end;
procedure TStSHarvestLines.SetTagID           (const Value: Integer   ); begin SetIntegerField('TagID'            , Value);end;
procedure TStSHarvestLines.SetQty             (const Value: Double    ); begin SetFloatField('Qty'              , Value);end;
procedure TStSHarvestLines.SetUOMQty          (const Value: Double    ); begin SetFloatField('UOMQty'           , Value);end;
procedure TStSHarvestLines.SetStSActionID     (const Value: Integer   ); begin SetIntegerField('StSActionID'      , Value);end;
Procedure TStSHarvestLines.SetStsTag          (const Value: String    ); begin SetStringfield('StsTag'        , Value); end;

function TStSHarvestLines.getHarvestDate    : TDatetime ;begin Result := 0;  if AssigneD(Owner) then  if owner is TStSHarvest then Result := TStSHarvest(Owner).HarvestDate   ; end;
function TStSHarvestLines.getStSProductID   : Integer   ;begin Result := 0;  if AssigneD(Owner) then  if owner is TStSHarvest then Result := TStSHarvest(Owner).StSProductID  ; end;
function TStSHarvestLines.getDeptID         : Integer   ;begin Result := 0;  if AssigneD(Owner) then  if owner is TStSHarvest then Result := TStSHarvest(Owner).DeptID        ; end;
function TStSHarvestLines.getUOMID          : Integer   ;begin Result := 0;  if AssigneD(Owner) then  if owner is TStSHarvest then Result := TStSHarvest(Owner).UOMID         ; end;
function TStSHarvestLines.getBinID          : Integer   ;begin Result := 0;  if AssigneD(Owner) then  if owner is TStSHarvest then Result := TStSHarvest(Owner).BinID         ; end;
function TStSHarvestLines.getUOMMultiplier  : Double    ;begin Result := 1;  if AssigneD(Owner) then  if owner is TStSHarvest then Result := TStSHarvest(Owner).UOMMultiplier ; end;
function TStSHarvestLines.GetUOM            : String    ;begin Result := '';  if AssigneD(Owner) then  if owner is TStSHarvest then Result := TStSHarvest(Owner).UOM          ; end;

function TStSHarvestLines.GetStSTagObj: TStSTags;
begin
  Result := TStSTags(GetcontainerComponent(TStSTags , 'ID=' + inttostr(TagID)));
end;


{TStSHarvest}

procedure TStSHarvest.CalcTotals;
begin
  if fbCalculatingTotal then Exit;
  fbCalculatingTotal := True;
  try
    fdTotalQty :=0;
    Lines.Iteraterecords(CalcTotalsCallback);
    TotalQty := fdTotalQty;
    Postdb;
  finally
    fbCalculatingTotal := False;
  end;
end;
procedure TStSHarvest.CalcTotalsCallback(Const Sender: TBusObj; var Abort: boolean);
begin
  if sender is TStSHarvestLines then begin
    fdTotalQty := fdTotalQty +TStSHarvestLines(Sender).uomQty;
  end;
end;
constructor TStSHarvest.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fbCalculatingTotal := False;
  fBusObjectTypeDescription:= 'StSHarvest';
  fSQL := 'SELECT * FROM tblstsharvest';
  AllLinesValid := False;
end;


destructor TStSHarvest.Destroy;
begin
  inherited;
end;


procedure TStSHarvest.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'DeptID');
  SetPropertyFromNode(node,'BinID');
  SetDateTimePropertyFromNode(node,'HarvestDate');
  SetPropertyFromNode(node,'HarvestName');
  SetPropertyFromNode(node,'StrainID');
  SetPropertyFromNode(node,'StrainName');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'UOM');
  SetPropertyFromNode(node,'UOMMultiplier');
  SetPropertyFromNode(node,'TotalQty');
  SetPropertyFromNode(node,'PackedQty');
  SetPropertyFromNode(node,'StSProductId');
  SetBooleanPropertyFromNode(node,'Harvestdone');

end;


procedure TStSHarvest.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DeptID' ,DeptID);
  AddXMLNode(node,'BinID' ,BinID);
  AddXMLNode(node,'HarvestDate' ,HarvestDate);
  AddXMLNode(node,'HarvestName' ,HarvestName);
  AddXMLNode(node,'StrainID' ,StrainID);
  AddXMLNode(node,'StrainName' ,StrainName);
  AddXMLNode(node,'UOMID' ,UOMID);
  AddXMLNode(node,'UOM' ,UOM);
  AddXMLNode(node,'UOMMultiplier' ,UOMMultiplier);
  AddXMLNode(node,'TotalQty' ,TotalQty);
  AddXMLNode(node,'PackedQty' ,PackedQty);
  AddXMLNode(node,'StSProductId' ,StSProductId);
  AddXMLNode(node,'Harvestdone' , Harvestdone);
end;


function TStSHarvest.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if DeptID =0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please Choose a ' +Appenv.DefaultClass.classheading+'.' , True );
    Exit;
  end;
  if BinID =0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please Choose a Room.' , True );
    Exit;
  end;
  if HarvestDate =0 then HarvestDate := now;
  if HarvestName ='' then HarvestName := DefaultHarvestName;
  if StrainID =0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please Choose a Strain.' , True );
    Exit;
  end;
  if (uomid=0) or (trim(UOM) ='') then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please Choose a Weight UOM.' , True );
    Exit;
  end;
  if StSProductId =0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please Choose the Harvest Product for the Strain (in The Strain Form).' , True );
    Exit;
  end;
  if Lines.Count =0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please Choose the Flowering Plant(s) for Harvest.' , True );
    Exit;
  end;
  allLinesValid := true;
  Lines.IterateRecords(Validatecallback);
  Result := allLinesValid;
end;
Procedure TStSHarvest.Validatecallback(Const Sender: TBusObj; var Abort: boolean);
begin
  if sender is TStSHarvestLines then begin
    if not TStSHarvestLines(Sender).ValidateData then begin
        allLinesValid := False;
        Abort := true;
    end;
  end;
end;

function TStSHarvest.Save: Boolean ;
begin
  Result := False;
  PostDB;
  Lines.PostDB;
  if not ValidateData then Exit;
  AllLinesValid:= true;
  StSTagSM:= TStockMovement.create(Self);
  try
    if Is_Inv_Product(StsProductID ) then begin
      StSTagSM.loadSelect('StockmovementEntryType =' + Quotedstr(XMLNodename)+' and StockmovementEntryglobalref =' + quotedstr(Globalref));
      if StSTagSM.count =0 then begin
        StSTagSM.New;
        StSTagSM.SMEType      := XMLNodename;
        StSTagSM.SMEGlobalref := Globalref;
        StSTagSM.MovementDate := HarvestDate;
        StSTagSM.EmployeeID   := Appenv.Employee.EmployeeID;
        StSTagSM.AccountID    := TAccount.IDToggle(Appenv.companyprefs.StSStockAccount);
        if StSTagSM.AccountID =0 then StSTagSM.AccountID := TAccount.IDToggle('Stock Adjustment');
        StSTagSM.PostDB;
        stepProgress;
      end;
    end;
    Lines.iteraterecords(SaveLinesCallback);
  finally
    Freeandnil(StSTagSM);
  end;
  REsult :=AllLinesValid;
  if not Result then exit;
  Result := inherited Save;
  if not Result then exit;

end;

procedure TStSHarvest.SaveLinesCallback(Const Sender: TBusObj; var Abort: boolean);
begin
  if Sender is TStSHarvestLines then begin
    if not TStSHarvestLines(Sender).Save then begin
      AllLinesValid:= false;
      Abort := True;
    end;
  end;
end;
procedure TStSHarvest.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TStSHarvest.DoFieldOnChange(Sender: TField);
begin
    if sender = nil then exit;
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
      inherited;
      if Sysutils.SameText(Sender.FieldName, 'HarvestName') then begin
        if not self.IsUnique(ID,'HarvestName = ' + QuotedStr(HarvestName),Connection.Connection) then begin
          Resultstatus.AddItem(False , rssError , 0,  'Harvest Name '+quotedstr(HarvestName)+' Already Exists.' , True );
          HarvestName := CleanHarvestName;
          SendEvent(BusObjEvent_Change, BusObjEvent_StSDupHarvestName, self);
        end;
      end else if Sysutils.SameText(Sender.FieldName, 'StrainName') then begin
        StrainId :=  TStSStrain.IDToggle(StrainName);
        Self.DoFieldOnChange(Self.Dataset.Findfield('StrainId'));
      end else if Sysutils.SameText(Sender.FieldName, 'StrainId') then begin
        with TStSStrain.create(Self) do try
          Connection := self.connection;
          Load(StrainId);
          Self.StrainName :=  StrainName ;
          StSProductId := HarvestProductId;
          Self.DoFieldOnChange(Self.Dataset.Findfield('StSProductId'));
        finally
          Free;
        end;
        SendEvent(BusObjEvent_Change, BusObjEvent_StsStrain, self);
      end else if Sysutils.SameText(Sender.FieldName, 'StsProductId') then begin
        CheckForHarvestProductUOM;
        SendEvent(BusObjEvent_Change, BusObjEvent_StsProductId, self);
      end else if Sysutils.SameText(Sender.FieldName, 'DeptID') then begin
        if DeptID <> 0 then begin
          SendEvent(BusObjEvent_Change, BusObjEvent_StSHarvestDept, self);
          if binID<>0 then begin
            if TProductBin.DeptIDOfbin(Self.owner, binID) <>DeptID then
              BinID := TStSClass.DefaultStSBinIDForDept(Self.owner,DeptID);
            Exit;
          end  else begin
            BinID := TStSClass.DefaultStSBinIDForDept(Self.owner,DeptID);
          end;
        end;
      end else if Sysutils.SameText(Sender.FieldName, 'UOM') then begin
        CheckForHarvestProductUOM;
      end;
end;

Procedure TStSHarvest.CheckForHarvestProductUOM;
begin
  if (StsProductId<>0) and (trim(UOM)<>'') then begin
        With TUnitofmeasure.ReadnCreateNewUOM(nil,StsProductId,UOM,0,'', '') do try
          Self.UOMID:= ID;
          Self.UOMMultiplier :=Multiplier;
          PostDB;
        finally
          Free;
        end;
  end;
end;
function TStSHarvest.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TStSHarvest.GetIDField: string;
begin
  Result := 'ID'
end;


class function TStSHarvest.GetKeyStringField: string;
begin
  Result := 'HarvestName';
end;

class function TStSHarvest.GetBusObjectTablename: string;
begin
  Result:= 'tblstsharvest';
end;


function TStSHarvest.getCleanHarvestName: String;
begin
  Result := GetXMLNodeStringValue(CleanXMLNOde, 'HarvestName');
end;

function TStSHarvest.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  HarvestDate := Now;
  DeptID := AppEnv.CompanyPrefs.StSConfig.StsDefaultclassId;
  uom := AppEnv.CompanyPrefs.StSConfig.StsDefaultWeightUOM;
  HarvestName :=DefaultHarvestname;
end;
function TStSHarvest.DefaultHarvestname:String;
var
  fsHarvestname, fs:String;
  ctr:Integer;
begin
  ctr:=0;
  fsHarvestname := FormatDatetime('yyyy-mm-dd' , now) +'-'+ GetBinLocationnnumber(Binid);//  'Harvest on ' + FormatDateTime(shortdateformat, date);
  fs:=fsHarvestname;
  While  not (self.IsUnique(ID,'HarvestName = ' + QuotedStr(fs),Connection.Connection)) do begin
    ctr:= ctr+1;
    fs:= fsHarvestname+' ('+trim(inttostr(ctr))+')';
  end;
  REsult := fs;
end;
function TStSHarvest.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  Calctotals;
end;


{Property Functions}
function  TStSHarvest.GetDeptID          : Integer   ; begin Result := GetIntegerField('DeptID');end;
function  TStSHarvest.GetBinID           : Integer   ; begin Result := GetIntegerField('BinID');end;
function  TStSHarvest.GetHarvestDate     : TDateTime ; begin Result := GetDateTimeField('HarvestDate');end;
function  TStSHarvest.GetHarvestName     : string    ; begin Result := GetStringField('HarvestName');end;
function  TStSHarvest.GetStrainID        : Integer   ; begin Result := GetIntegerField('StrainID');end;
function  TStSHarvest.GetStrainName      : string    ; begin Result := GetStringField('StrainName');end;
function  TStSHarvest.GetUOMID           : Integer   ; begin Result := GetIntegerField('UOMID');end;
function  TStSHarvest.GetUOM             : string    ; begin Result := GetStringField('UOM');end;
function  TStSHarvest.GetUOMMultiplier   : Double    ; begin Result := GetFloatField('UOMMultiplier');end;
function  TStSHarvest.GetTotalQty        : Double    ; begin Result := GetFloatField('TotalQty');end;
function  TStSHarvest.GetPackedQty       : Double    ; begin Result := GetFloatField('PackedQty');end;
function  TStSHarvest.GetStSProductId    : Integer   ; begin Result := GetIntegerField('StSProductId');end;
function  TStSHarvest.GetHarvestdone     : Boolean   ; begin Result := GetbooleanField('done'); end;
procedure TStSHarvest.SetDeptID          (const Value: Integer   ); begin SetIntegerField('DeptID'           , Value);end;
procedure TStSHarvest.SetBinID           (const Value: Integer   ); begin SetIntegerField('BinID'            , Value);end;
procedure TStSHarvest.SetHarvestDate     (const Value: TDateTime ); begin SetDateTimeField('HarvestDate'      , Value);end;
procedure TStSHarvest.SetHarvestName     (const Value: string    ); begin SetStringField('HarvestName'        , Value);end;
procedure TStSHarvest.SetStrainID        (const Value: Integer   ); begin SetIntegerField('StrainID'         , Value);end;
procedure TStSHarvest.SetStrainName      (const Value: string    ); begin SetStringField('StrainName'       , Value);end;
procedure TStSHarvest.SetUOMID           (const Value: Integer   ); begin SetIntegerField('UOMID'            , Value);end;
procedure TStSHarvest.SetUOM             (const Value: string    ); begin SetStringField('UOM'              , Value);end;
procedure TStSHarvest.SetUOMMultiplier   (const Value: Double    ); begin SetFloatField('UOMMultiplier'    , Value);end;
procedure TStSHarvest.SetTotalQty        (const Value: Double    ); begin SetFloatField('TotalQty'         , Value);end;
procedure TStSHarvest.SetPackedQty       (const Value: Double    ); begin SetFloatField('PackedQty'         , Value);end;
procedure TStSHarvest.SetStSProductId    (const Value: Integer   ); begin SetIntegerField('StSProductId'     , Value);end;
procedure TStSHarvest.SetHarvestdone     (Const Value: Boolean   ); begin SetBooleanField('Done'            , Value); end;


function TStSHarvest.getStSHarvestLines: TStSHarvestLines;
begin
  Result := TStSHarvestLines(GetcontainerComponent(TStSHarvestLines , 'HarvestID=' + inttostr(ID)));
end;


{ TStSPackage }

procedure TStSPackage.CalcNSetTotalPackedQty;
begin
  FTotLinesQty := 0;
  Lines.IterateRecords(CalcTotalsCallback);
  PackedQty := FTotLinesQty;
  PostDB;
end;

procedure TStSPackage.CalcTotalsCallback(const Sender: TBusObj; var Abort: boolean);
begin
  if Sender is TStSPackageLines then
    FTotLinesQty := FTotLinesQty + TStSPackageLines(Sender).Qty;
end;

constructor TStSPackage.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription:= 'StSPackage';
  fSQL := 'SELECT * FROM tblstspackage';
end;

function TStSPackage.CreatePackage(const NewActionDesc: string; aCreatePackageFunc: TBusObjBoolFunc): Boolean;
begin
  Result := (TStSTags.NewStsAction(NewActionDesc) <> 0);

  if Result and (ProductID > 0) and Assigned(aCreatePackageFunc) then
    Result := aCreatePackageFunc(Self)
end;

function TStSPackage.DefaultPackageName(const aSpecifier: string): String;
var
  sSpecifier: string;
begin
  sSpecifier := aSpecifier;

  if Length(Trim(aSpecifier)) > 0 then
    sSpecifier := '-' + aSpecifier;

  Result := Format('Package%s-%s-%s', [sSpecifier, FormatDateTime('yyyymmdd', Now), FormatDateTime('hhnnsszzz', Now)]);
end;

class function TStSPackage.GetBusObjectTablename: string;
begin
  Result:= 'tblstspackage';
end;

class function TStSPackage.GetIDField: string;
begin
  Result := 'ID';
end;

class function TStSPackage.GetKeyStringField: string;
begin
  Result := 'StsTag';
end;

function TStSPackage.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

procedure TStSPackage.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
//
end;

procedure TStSPackage.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
//
end;

class function TStSPackage.ProductID: Integer;
begin
  // TProductSimple.ChecknMakeProduct(const aProductname: String;aConnection: TCustomMyconnection=nil; Enablebatch:Boolean = false;enablebin :boolean = False; enableSN:Boolean = False; aPREFEREDSUPP:String = '';aProductGroup:String =''): Integer;
  // TProductSimple.ChecknMakeProduct searches for a record in tblparts by aProductname. If it does, it returns tblparts.PartsId. If not found, creates a new entry and returns tblparts.PartsId.
  Result := TProductSimple.ChecknMakeProduct(STS_PACKAGE_PRODUCT, nil, False, False, True, '', 'StS^' + STS_PACKAGE_PRODUCT);
end;

function TStSPackage.Save: Boolean;
begin
  Lines.IterateRecords(SaveLinesCallback);
end;

procedure TStSPackage.SaveLinesCallback(const Sender: TBusObj; var Abort: boolean);
begin
  if Sender is TStSPackageLines then
    if not TStSPackageLines(Sender).Save then
      Abort := True;
end;

procedure TStSPackage.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
//
end;

function TStSPackage.ValidateData: Boolean;
begin
  Result := True;
end;

// Set for properties
procedure TStSPackage.SetStsTagsID    (const AValue: Integer);         begin   SetIntegerField ('StsTagsID',      AValue);   end;
procedure TStSPackage.SetParentPkgID  (const AValue: Integer);         begin   SetIntegerField ('ParentPkgID',    AValue);   end;
procedure TStSPackage.SetPackageName  (const AValue: string);          begin   SetStringField  ('PackageName',    AValue);   end;
procedure TStSPackage.SetPackageDate  (const AValue: TDateTime);       begin   SetDateTimeField('PackageDate',    AValue);   end;
procedure TStSPackage.SetPackageType  (const AValue: TStsPackageType); begin   SetIntegerField ('PackageType',Ord(AValue));  end;
procedure TStSPackage.SetHarvestID    (const AValue: Integer);         begin   SetIntegerField ('HarvestID',      AValue);   end;
procedure TStSPackage.SetUOM          (const AValue: string);          begin   SetStringField  ('UOM',            AValue);   end;
procedure TStSPackage.SetUOMID        (const AValue: Integer);         begin   SetIntegerField ('UOMID',          AValue);   end;
procedure TStSPackage.SetUOMMultiplier(const AValue: Double);          begin   SetFloatField   ('UOMMultiplier',  AValue);   end;
procedure TStSPackage.SetPackedQty    (const AValue: Double);          begin   SetFloatField   ('PackedQty',      AValue);   end;
procedure TStSPackage.SetDone         (const AValue: string);          begin   SetStringField  ('Done',           AValue);   end;

// Get for properties
function TStSPackage.GetStsTagsID:     Integer;         begin  Result := GetIntegerField                ('StsTagsID');     end;
function TStSPackage.GetParentPkgID:   Integer;         begin  Result := GetIntegerField                ('ParentPkgID');   end;
function TStSPackage.GetPackageName:   string;          begin  Result := GetStringField                 ('PackageName');   end;
function TStSPackage.GetPackageType:   TStsPackageType; begin  Result := TStsPackageType(GetIntegerField('PackageType'));  end;
function TStSPackage.GetPackageDate:   TDateTime;       begin  Result := GetDateTimeField               ('PackageDate');   end;
function TStSPackage.GetHarvestID:     Integer;         begin  Result := GetIntegerField                ('HarvestID');     end;
function TStSPackage.GetUOM:           string;          begin  Result := GetStringField                 ('UOM');           end;
function TStSPackage.GetUOMID:         Integer;         begin  Result := GetIntegerField                ('UOMID');         end;
function TStSPackage.GetUOMMultiplier: Double;          begin  Result := GetFloatField                  ('UOMMultiplier'); end;
function TStSPackage.GetPackedQty:     Double;          begin  Result := GetFloatField                  ('PackedQty');     end;
function TStSPackage.GetDone:          string;          begin  Result := GetStringField                 ('Done');          end;

function TStSPackage.GetStSPackageLines: TStSPackageLines;
begin
  Result := TStSPackageLines(GetContainerComponent(TStSPackageLines , 'PackageID=' + IntToStr(ID)));
end;

function TStSPackage.GetStSTagObj: TStSTags;
begin
  Result := TStSTags(GetcontainerComponent(TStSTags , 'ID=' + IntToStr(StsTagsID)));
end;

{TStSPackageLines}

constructor TStSPackageLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'StSPackageLines';
  fSQL := 'SELECT * FROM tblstspackagelines';
end;

destructor TStSPackageLines.Destroy;
begin
  inherited;
end;

procedure TStSPackageLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PackageID');
  SetPropertyFromNode(node,'SMLLineID');
  SetPropertyFromNode(node,'StsTagsID');
  SetPropertyFromNode(node,'Qty');
  SetPropertyFromNode(node,'UOMQty');
  SetPropertyFromNode(node,'StSActionID');
  SetPropertyFromNode(node,'StSProductId');
end;

procedure TStSPackageLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PackageID'   ,PackageID);
  AddXMLNode(node,'SMLLineID'   ,SMLLineID);
  AddXMLNode(node,'StsTagsID'   ,StsTagsID);
  AddXMLNode(node,'Qty'         ,Qty);
  AddXMLNode(node,'UOMQty'      ,UOMQty);
  AddXMLNode(node,'StSActionID' ,StSActionID);
  AddXMLNode(node,'StSProductId',StSProductId);
end;


function TStSPackageLines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;

  if StsTagsID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please Choose a Tag.' , True );
    Exit;
  end;
  if (Qty =0) or (UOMQty =0) then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please Provide the Qty' , True );
    Exit;
  end;
  Result := True;
end;

function TStSPackageLines.Save: Boolean ;
begin
  Result := False;
  PostDB;
  if not ValidateData then Exit;

  with StSTagObj do begin
    StSTag_Actions.New;
    StSTag_Actions.StatusDate     := PackageDate;
    StSTag_Actions.StatusAction   := STS_ACTION_CREATE_PACKAGES_PRODUCT;
    StSTag_Actions.ActionQty      := -1; // tag moved to package
    StSTag_Actions.TagProductID   := TagProductID;
    StSTag_Actions.StSProductID   := StSProductID;
    StSTag_Actions.StatusActionId := TStSTags.NewStsAction(STS_ACTION_CREATE_PACKAGES_PRODUCT);
    StSTag_Actions.PostDB;

    // in case "Create package from Plant"
    if TagProductID = StSLib.StSPlantTagProductID then begin
      // Increasing UseCount you decrease available ActiveCount that is calculated:  ActiveCount = (Plantcount - ChangedCount - WastedCount - Destroycount - TransferedCount - UsedCount)
      UsedCount := UsedCount + Qty; // Qty is TStSPackageLines's property
      PostDB;
      if not Save then Exit;
    end;

    // in case "Create package from Another package"
    if TagProductID = Self.OwnerProductID then
      if not SavePackage then Exit;
  end;

  Result := inherited Save;
end;

procedure TStSPackageLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

function TStSPackageLines.OwnerProductID: Integer;
begin
  Result := 0;

  if Assigned(Owner) and (Owner is TStsPackage) then
    Result := TStsPackage(Owner).ProductID;
end;

procedure TStSPackageLines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TStSPackageLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TStSPackageLines.GetIDField: string;
begin
  Result := 'ID'
end;

class function TStSPackageLines.GetBusObjectTablename: string;
begin
  Result:= 'tblstspackagelines';
end;

function TStSPackageLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if Owner is TStSPackage then
      PackageID := TStSPackage(Owner).Id;
end;

function TStSPackageLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then exit;
end;


{Property Functions}
function  TStSPackageLines.GetPackageID       : Integer   ; begin Result := GetIntegerField('PackageID');    end;
function  TStSPackageLines.GetSMLLineID       : Integer   ; begin Result := GetIntegerField('SMLLineID');    end;
function  TStSPackageLines.GetStsTagsID       : Integer   ; begin Result := GetIntegerField('StsTagsID');    end;
function  TStSPackageLines.GetQty             : Integer   ; begin Result := GetIntegerField('Qty');          end;
function  TStSPackageLines.GetUOMQty          : Integer   ; begin Result := GetIntegerField('UOMQty');       end;
function  TStSPackageLines.GetStSActionID     : Integer   ; begin Result := GetIntegerField('StSActionID');  end;
//Function  TStSPackageLines.GetStsTag          : String    ; begin Result := GetStringField( 'StsTag');       end;
function  TStSPackageLines.GetStSProductID    : Integer   ; begin Result := GetIntegerField('StSProductId'); end;

procedure TStSPackageLines.SetPackageID       (const Value: Integer   ); begin SetIntegerField('PackageID'        , Value);end;
procedure TStSPackageLines.SetSMLLineID       (const Value: Integer   ); begin SetIntegerField('SMLLineID'        , Value);end;
procedure TStSPackageLines.SetStsTagsID       (const Value: Integer   ); begin SetIntegerField('StsTagsID'        , Value);end;
procedure TStSPackageLines.SetQty             (const Value: Integer   ); begin SetIntegerField('Qty'              , Value);end;
procedure TStSPackageLines.SetUOMQty          (const Value: Integer   ); begin SetIntegerField('UOMQty'           , Value);end;
procedure TStSPackageLines.SetStSActionID     (const Value: Integer   ); begin SetIntegerField('StSActionID'      , Value);end;
//Procedure TStSPackageLines.SetStsTag          (const Value: String    ); begin SetStringfield( 'StsTag'           , Value);end;
procedure TStSPackageLines.SetStSProductId    (const Value: Integer   ); begin SetIntegerField('StSProductId'     , Value);end;

function TStSPackageLines.getPackageDate    : TDatetime ;begin Result := 0;  if AssigneD(Owner) then  if owner is TStSPackage then Result := TStSPackage(Owner).PackageDate   ; end;
//function TStSPackageLines.getDeptID         : Integer   ;begin Result := 0;  if AssigneD(Owner) then  if owner is TStSPackage then Result := TStSPackage(Owner).DeptID        ; end;
function TStSPackageLines.getUOMID          : Integer   ;begin Result := 0;  if AssigneD(Owner) then  if owner is TStSPackage then Result := TStSPackage(Owner).UOMID         ; end;
function TStSPackageLines.getUOMMultiplier  : Integer   ;begin Result := 1; end;
function TStSPackageLines.GetUOM            : String    ;begin Result :='';  if AssigneD(Owner) then  if owner is TStSPackage then Result := TStSPackage(Owner).UOM           ; end;

function TStSPackageLines.GetStSTagObj: TStSTags;
begin
  Result := TStSTags(GetcontainerComponent(TStSTags , 'ID=' + IntToStr(StsTagsID)));
end;


  { TStSPkgTransferLines }

constructor TStSPkgTransferLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'StSPackageTransferLines';
  fSQL := 'SELECT * FROM tblststransferpackagelines';
end;

destructor TStSPkgTransferLines.Destroy;
begin
  inherited;
end;

procedure TStSPkgTransferLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TransferID');
  SetPropertyFromNode(node,'PackageID');
  SetPropertyFromNode(node,'TagID');
  SetPropertyFromNode(node,'UOMQty');
  SetPropertyFromNode(node,'StSProductId');
  SetPropertyFromNode(node,'SMLLineID');
  SetPropertyFromNode(node,'StSActionID');
end;

procedure TStSPkgTransferLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TransferID'  , TransferID);
  AddXMLNode(node,'PackageID'   , PackageID);
  AddXMLNode(node,'TagID'       , TagID);
  AddXMLNode(node,'UOMQty'      , UOMQty);
  AddXMLNode(node,'StSActionID' , StSActionID);
  AddXMLNode(node,'StSProductId', StSProductId);
  AddXMLNode(node,'SMLLineID'   , SMLLineID);
end;

function TStSPkgTransferLines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;

  if TagID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please Choose a Tag.' , True );
    Exit;
  end;
  if (UOMQty =0) then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please Provide the Qty', True );
    Exit;
  end;
  Result := True;
end;

function TStSPkgTransferLines.Save: Boolean ;
var
  iActionQty: Integer;
  pkgTransfer: TStSPkgTransfer;
  objTags: TStSTags;
begin
  Result := False;
  PostDB;
  if not ValidateData then Exit;

  if SameText(Rejected, 'T') then Exit(True); // ignore Rejected items but return True to avoid Abort in TStSPkgTransfer.SaveLinesCallback because it is not an Error

  Assert(Owner is TStSPkgTransfer, 'Owner is TStSPkgTransfer');
  pkgTransfer := Owner as TStSPkgTransfer;

  objTags := StSTagObj;

  iActionQty := 0;
  if pkgTransfer.SourceDeptID = objTags.DeptID then iActionQty := -1;
  if pkgTransfer.DestDeptID   = objTags.DeptID then iActionQty := 1;

  with objTags do begin
    StSTag_Actions.New;
    StSTag_Actions.StatusDate     := TransferDate;
    StSTag_Actions.StatusAction   := STS_ACTION_TRANSFER_PACKAGES;
    StSTag_Actions.ActionQty      := iActionQty;
    StSTag_Actions.TagProductID   := TagProductID;
    StSTag_Actions.StSProductID   := StSProductID;
    StSTag_Actions.StatusActionId := TStSTags.NewStsAction(STS_ACTION_TRANSFER_PACKAGES);
    StSTag_Actions.PostDB;

    TransferedCount := 1;
    PostDB;

    Result := SavePackage;
    if not Result then Exit;
  end;

  Result := inherited Save;
end;

procedure TStSPkgTransferLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TStSPkgTransferLines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TStSPkgTransferLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TStSPkgTransferLines.GetIDField: string;
begin
  Result := 'ID'
end;

class function TStSPkgTransferLines.GetBusObjectTablename: string;
begin
  Result:= 'tblststransferpackagelines';
end;

function TStSPkgTransferLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if Owner is TStSPkgTransfer then
      TransferID := TStSPkgTransfer(Owner).Id;
end;

function TStSPkgTransferLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then exit;
end;


{Property Functions}
function  TStSPkgTransferLines.GetTransferID      : Integer   ; begin Result := GetIntegerField('TransferID');   end;
function  TStSPkgTransferLines.GetPackageID       : Integer   ; begin Result := GetIntegerField('PackageID');    end;
function  TStSPkgTransferLines.GetSMLLineID       : Integer   ; begin Result := GetIntegerField('SMLLineID');    end;
function  TStSPkgTransferLines.GetTagID           : Integer   ; begin Result := GetIntegerField('TagID');        end;
function  TStSPkgTransferLines.GetUOMQty          : Integer   ; begin Result := GetIntegerField('UOMQty');       end;
function  TStSPkgTransferLines.GetStSActionID     : Integer   ; begin Result := GetIntegerField('StSActionID');  end;
Function  TStSPkgTransferLines.GetRejected        : String    ; begin Result := GetStringField( 'Rejected');     end;
function  TStSPkgTransferLines.GetStSProductID    : Integer   ; begin Result := GetIntegerField('StSProductId'); end;

procedure TStSPkgTransferLines.SetTransferID      (const Value: Integer   ); begin SetIntegerField('TransferID'       , Value);end;
procedure TStSPkgTransferLines.SetPackageID       (const Value: Integer   ); begin SetIntegerField('PackageID'       , Value);end;
procedure TStSPkgTransferLines.SetSMLLineID       (const Value: Integer   ); begin SetIntegerField('SMLLineID'        , Value);end;
procedure TStSPkgTransferLines.SetTagID           (const Value: Integer   ); begin SetIntegerField('TagID'            , Value);end;
procedure TStSPkgTransferLines.SetUOMQty          (const Value: Integer   ); begin SetIntegerField('UOMQty'           , Value);end;
procedure TStSPkgTransferLines.SetStSActionID     (const Value: Integer   ); begin SetIntegerField('StSActionID'      , Value);end;
Procedure TStSPkgTransferLines.SetRejected        (const Value: String    ); begin SetStringfield( 'Rejected'         , Value);end;
procedure TStSPkgTransferLines.SetStSProductId    (const Value: Integer   ); begin SetIntegerField('StSProductId'     , Value);end;

function TStSPkgTransferLines.getTransferDate   : TDatetime ;begin Result := 0;  if AssigneD(Owner) then  if owner is TStSPkgTransfer then Result := TStSPkgTransfer(Owner).TransferDate  ; end;
function TStSPkgTransferLines.getDeptID         : Integer   ;begin Result := 0;  if AssigneD(Owner) then  if owner is TStSPkgTransfer then Result := TStSPkgTransfer(Owner).DeptID        ; end;
function TStSPkgTransferLines.getUOMID          : Integer   ;begin Result := 0;  if AssigneD(Owner) then  if owner is TStSPkgTransfer then Result := TStSPkgTransfer(Owner).UOMID         ; end;
function TStSPkgTransferLines.getUOMMultiplier  : Integer   ;begin Result := 1; end;
function TStSPkgTransferLines.GetUOM            : String    ;begin Result :='';  if AssigneD(Owner) then  if owner is TStSPkgTransfer then Result := TStSPkgTransfer(Owner).UOM           ; end;

function TStSPkgTransferLines.GetStSTagObj: TStSTags;
begin
  Result := TStSTags(GetcontainerComponent(TStSTags , 'ID=' + inttostr(TagID)));
end;

function TStSPkgTransferLines.GetStSPkgObj: TStSPackage;
begin
  Result := TStSPackage(GetcontainerComponent(TStSPackage , 'ID=' + inttostr(PackageID)));
end;



{ TStSPkgTransfer }

constructor TStSPkgTransfer.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription:= 'StSPackageTransfer';
  fSQL := 'SELECT * FROM tblststransferpackage';

end;

destructor TStSPkgTransfer.Destroy;
begin
  inherited;
end;

class function TStSPkgTransfer.GetBusObjectTablename: string;
begin
  Result := 'tblststransferpackage';
end;

class function TStSPkgTransfer.GetIDField: string;
begin
  Result := 'ID';
end;

class function TStSPkgTransfer.GetKeyStringField: string;
begin
  Result := 'StsTag';
end;

function TStSPkgTransfer.GetPkgTransferLines: TStSPkgTransferLines;
begin
  Result := TStSPkgTransferLines(GetContainerComponent(TStSPkgTransferLines , 'TransferID=' + IntToStr(ID)));
end;

function TStSPkgTransfer.Save: Boolean;
begin
  Lines.IterateRecords(SaveLinesCallback);
end;

procedure TStSPkgTransfer.SaveLinesCallback(const Sender: TBusObj; var Abort: boolean);
begin
  if Sender is TStSPkgTransferLines then
    if not TStSPkgTransferLines(Sender).Save then
      Abort := True;
end;

function TStSPkgTransfer.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;

  if EstDeparture > EstArrival then begin
    Resultstatus.AddItem(False , rssError , 0,  'The  Est.Arrival cannot be less than the Est.Departure' , True );
    Exit;
  end;

  Result := True;
end;

function TStSPkgTransfer.GetDestDeptID:   Integer;   begin Result := GetIntegerField ('DestDeptID'   ); end;
function TStSPkgTransfer.GetDone:         string;    begin Result := GetStringField  ('Done'         ); end;
function TStSPkgTransfer.GetDriverID:     Integer;   begin Result := GetIntegerField ('DriverID'     ); end;
function TStSPkgTransfer.GetEstArrival:   TDateTime; begin Result := GetDateTimeField('EstArrival'   ); end;
function TStSPkgTransfer.GetEstDeparture: TDateTime; begin Result := GetDateTimeField('EstDeparture' ); end;
function TStSPkgTransfer.GetRoute:        string;    begin Result := GetStringField  ('Route'        ); end;
function TStSPkgTransfer.GetSourceDeptID: Integer;   begin Result := GetIntegerField ('SourceDeptID' ); end;
function TStSPkgTransfer.GetTransferType: string;    begin Result := GetStringField  ('TransferType' ); end;
function TStSPkgTransfer.GetVehicleID:    Integer;   begin Result := GetIntegerField ('VehicleID'    ); end;

procedure TStSPkgTransfer.SetDestDeptID  (const AValue: Integer  ); begin SetIntegerField ('DestDeptID'   , AValue); end;
procedure TStSPkgTransfer.SetDone        (const AValue: string   ); begin SetStringField  ('Done'         , AValue); end;
procedure TStSPkgTransfer.SetDriverID    (const AValue: Integer  ); begin SetIntegerField ('DriverID'     , AValue); end;
procedure TStSPkgTransfer.SetEstArrival  (const AValue: TDateTime); begin SetDateTimeField('EstArrival'   , AValue); end;
procedure TStSPkgTransfer.SetEstDeparture(const AValue: TDateTime); begin SetDateTimeField('EstDeparture' , AValue); end;
procedure TStSPkgTransfer.SetRoute       (const AValue: string   ); begin SetStringField  ('Route'        , AValue); end;
procedure TStSPkgTransfer.SetSourceDeptID(const AValue: Integer  ); begin SetIntegerField ('SourceDeptID' , AValue); end;
procedure TStSPkgTransfer.SetTransferType(const AValue: string   ); begin SetStringField  ('TransferType' , AValue); end;
procedure TStSPkgTransfer.SetVehicleID   (const AValue: Integer  ); begin SetIntegerField ('VehicleID'    , AValue); end;

function TStSPkgTransfer.TransferDate: TDateTime;
begin
  Result := GetDateTimeField('msTimeStamp');
end;

function TStSPkgTransfer.UOM: string;
begin
  Result := '';
end;

function TStSPkgTransfer.UOMID: Integer;
begin
  Result := 0;
end;

{ TStSVehicle }

class function TStSVehicle.GetBusObjectTablename: string;
begin
  Result := 'tblfixedassets';
end;

class function TStSVehicle.GetIDField: string;
begin
  Result := 'AssetID';
end;

function TStSVehicle.GetSQL: string;
begin
  SQL := 'SELECT * FROM tblfixedassets WHERE PartName="STSVEHICLE"';
  Result := inherited GetSQL;
end;

function TStSVehicle.Save: Boolean;
begin
   Result := inherited Save;
   PostDb;
end;

function TStSVehicle.GetManufacture: string; begin Result := GetStringField('Manufacture'); end;
function TStSVehicle.GetModel:       string; begin Result := GetStringField('Model'      ); end;
function TStSVehicle.GetSerial:      string; begin Result := GetStringField('Serial'     ); end;
function TStSVehicle.GetPartName:    string; begin Result := GetStringField('PartName'   ); end;

procedure TStSVehicle.SetManufacture(const AValue: string); begin SetStringField('Manufacture', AValue); end;
procedure TStSVehicle.SetModel      (const AValue: string); begin SetStringField('Model'      , AValue); end;
procedure TStSVehicle.SetSerial     (const AValue: string); begin SetStringField('Serial'     , AValue); end;
procedure TStSVehicle.SetPartName   (const AValue: string); begin SetStringField('PartName'   , AValue); end;

initialization
  RegisterClass(TStSHarvestLines);
  RegisterClass(TStSHarvest);
  RegisterClass(TStSTagProduct);
  RegisterClass(TStSTag_Actions);
  RegisterClass(TStSTags);
  RegisterClass(TStSTagPhases);
  RegisterClass(TStSPackageLines);
  RegisterClass(TStSPackage);
  RegisterClass(TStSPkgTransferLines);
  RegisterClass(TStSPkgTransfer);
  RegisterClass(TStSVehicle);

end.

