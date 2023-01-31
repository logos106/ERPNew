unit BusobjTraining;

interface

uses ERPdbComponents, BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjEmployeeDetails, controls, BusObjRoster;

type
  (* const
    ERPProjectManager = 'Project Manager'; *)

  TTrainingEmployeeModules = class;
  TTraining = class;

  TTrainingRoster = class(TRoster)
  private
    function GetTrainingID: integer;
    procedure SetTrainingID(const Value: integer);
  public
    function ValidateData: Boolean; override;
  published
    property TrainingID: integer read GetTrainingID write SetTrainingID;
  end;


  TTrainingBase = class(TMSBusObj)
  private
    function getTRaining: TTraining;
    function getTrainingID: Integer;
    procedure setTrainingID(const Value: Integer);
  public
    property TRaining: TTraining read getTRaining;
  protected
  published
    property TrainingID: Integer read getTrainingID write setTrainingID;
  end;

  TTrainingDay = class(TTrainingBase)
  private
    function GetDescription: string;
    function GetTimeFrom: string;
    function GetTimeTo: string;
    function GettTimeFrom: TDateTime;
    function GettTimeto: TDateTime;

    function GetActive: Boolean;
    procedure SetDescription(const Value: string);
    procedure SetTimeFrom(const Value: string);
    procedure SetTimeTo(const Value: string);
    procedure SettTimeFrom(const Value: TDateTime);
    procedure SettTimeto(const Value: TDateTime);
    procedure SetActive(const Value: Boolean);
//    function getTrainingID: Integer;
//    procedure setTrainingID(const Value: Integer);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
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
  published
    property Description: string read GetDescription write SetDescription;
    property TimeFrom: string read GetTimeFrom write SetTimeFrom;
    property TimeTo: string read GetTimeTo write SetTimeTo;
    property tTimeFrom: TDateTime read GettTimeFrom write SettTimeFrom;
    property tTimeTo: TDateTime read GettTimeto write SettTimeto;
    property Active: Boolean read GetActive write SetActive;
//    property TrainingID: Integer read getTrainingID write setTrainingID;
  end;

  TTrainingModules = class(TTrainingBase)
  private
    fQryTotalHours: TErpQuery;
    function GetTrainingModuleName: string;
    function GetTEMFieldname: string;
    function GetActive: Boolean;
    procedure SetTrainingModuleName(const Value: string);
    procedure SetTEMFieldname(const Value: string);
    procedure SetActive(const Value: Boolean);
    function getVideofilename: string;
    procedure setVideofilename(const Value: string);
//    function getTrainingID: Integer;
//    procedure setTrainingID(const Value: Integer);
    function getTrainingEmployeeModules: TTrainingEmployeeModules;
    function getTrainingHrs: Double;
    procedure setTrainingHrs(const Value: Double);
    function getSeqno: Integer;
    procedure setSeqno(const Value: Integer);
    function getQryTotalHours: TErpQuery;
    function getModuleHelpcontextID: string;
    procedure setModuleHelpcontextID(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;


  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    Class function   GetKeyStringField       : string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    property TrainingEmployeeModules: TTrainingEmployeeModules read getTrainingEmployeeModules;
    property QryTotalHours: TErpQuery read getQryTotalHours;
    class function _Schema: string; override;
  published
    property TrainingModuleName: string read GetTrainingModuleName write SetTrainingModuleName;
    property ModuleHelpContextID: string read getModuleHelpcontextID write setModuleHelpcontextID;
    property Active: Boolean read GetActive write SetActive;
    property VideoFileName: string read getVideofilename write setVideofilename;
    property TEMFieldName: string read GetTEMFieldname write SetTEMFieldname;
//    property TrainingID: Integer read getTrainingID write setTrainingID;
    property TrainingHrs: Double read getTrainingHrs write setTrainingHrs;
    property SeqNo: Integer read getSeqno write setSeqno;
  end;

  TTrainingEmployeeModules = class(TTrainingBase)
  private
    fTrainingModules: TTrainingModules;
    ficurrentId: Integer;
    function GetEmployeeId: Integer;
    function GetEmployeeName: string;
    function GetMoreTrainingDetails: string;
    function GetBasicFeatures: Boolean;
    function GetPurchase_FX: Boolean;
    function GetERPSetup: Boolean;
    function GetDataImport: Boolean;
    function GetMoreTraining: Boolean;
    function GetEmployee: Boolean;
    function GetAccounts: Boolean;
    function GetInventory_Basics: Boolean;
    function GetFileMaintenance: Boolean;
    function GetPurchase: Boolean;
    function GetCRM: Boolean;
    function GetMarketing: Boolean;
    function GetSales: Boolean;
    function GetPos: Boolean;
    function GetCustomerPayments: Boolean;
    function GetSupplierPayments: Boolean;
    function GetBanking: Boolean;
    function GetReports: Boolean;
    function GetGeneral_Templates: Boolean;
    function GetUtilities: Boolean;
    function GetInventory_Advanced: Boolean;
    function GetManufacturing: Boolean;
    function GetAppointments: Boolean;
    function GetPayroll: Boolean;
    function GetFixedAssets: Boolean;
    function GetWorkshop: Boolean;
    function Getbudgets: Boolean;
    function GetDelivery: Boolean;
    function GetMatrix: Boolean;
    function GetDateCreated: TDateTime;
    function GetEnteredby: Integer;
    procedure SetEmployeeId(const Value: Integer);
    procedure SetEmployeeName(const Value: string);
    procedure SetMoreTrainingDetails(const Value: string);
    procedure SetBasicFeatures(const Value: Boolean);
    procedure SetPurchase_FX(const Value: Boolean);
    procedure SetERPSetup(const Value: Boolean);
    procedure SetDataImport(const Value: Boolean);
    procedure SetMoreTraining(const Value: Boolean);
    procedure SetEmployee(const Value: Boolean);
    procedure SetAccounts(const Value: Boolean);
    procedure SetInventory_Basics(const Value: Boolean);
    procedure SetFileMaintenance(const Value: Boolean);
    procedure SetPurchase(const Value: Boolean);
    procedure SetCRM(const Value: Boolean);
    procedure SetMarketing(const Value: Boolean);
    procedure SetSales(const Value: Boolean);
    procedure SetPos(const Value: Boolean);
    procedure SetCustomerPayments(const Value: Boolean);
    procedure SetSupplierPayments(const Value: Boolean);
    procedure SetBanking(const Value: Boolean);
    procedure SetReports(const Value: Boolean);
    procedure SetGeneral_Templates(const Value: Boolean);
    procedure SetUtilities(const Value: Boolean);
    procedure SetInventory_Advanced(const Value: Boolean);
    procedure SetManufacturing(const Value: Boolean);
    procedure SetAppointments(const Value: Boolean);
    procedure SetPayroll(const Value: Boolean);
    procedure SetFixedAssets(const Value: Boolean);
    procedure SetWorkshop(const Value: Boolean);
    procedure Setbudgets(const Value: Boolean);
    procedure SetDelivery(const Value: Boolean);
    procedure SetMatrix(const Value: Boolean);
    procedure SetDateCreated(const Value: TDateTime);
    procedure SetEnteredby(const Value: Integer);
    function getEmployeeObj: TEmployeeDetails;
    procedure CreateTaskrecords(const Sender: TBusObj; var Abort: Boolean); overload;
    procedure CreateTaskrecords(const ModuleSelected: Boolean; const Modulename: string); overload;
    function getTrainingModules: TTrainingModules;
    function ModuleId(const Modulename: string): Integer;
    function ModuleSeqno(ModuleId: Integer): Integer;
    function IsModuleActive(const Modulename: string): Boolean;
    function GetHire: boolean;
    function GetHow_To: boolean;
    procedure SetHire(const Value: boolean);
    procedure SetHow_To(const Value: boolean);
//    function getTrainingID: Integer;
//    procedure setTrainingID(const Value: Integer);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
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
    property EmployeeObj: TEmployeeDetails read getEmployeeObj;
    property TrainingModules: TTrainingModules read getTrainingModules;
    function AnyModuleAssigned: Boolean;
    function IsModuleAssigned(const fsModulename: string): Boolean;
    property currentId: Integer read ficurrentId;
  published
    property EmployeeId: Integer read GetEmployeeId write SetEmployeeId;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property MoreTrainingDetails: string read GetMoreTrainingDetails write SetMoreTrainingDetails;
    property BasicFeatures: Boolean read GetBasicFeatures write SetBasicFeatures;
    property Purchase_FX: Boolean read GetPurchase_FX write SetPurchase_FX;
    property ERPSetup: Boolean read GetERPSetup write SetERPSetup;
    property DataImport: Boolean read GetDataImport write SetDataImport;
    property MoreTraining: Boolean read GetMoreTraining write SetMoreTraining;
    property Employee: Boolean read GetEmployee write SetEmployee;
    property Accounts: Boolean read GetAccounts write SetAccounts;
    property Inventory_Basics: Boolean read GetInventory_Basics write SetInventory_Basics;
    property FileMaintenance: Boolean read GetFileMaintenance write SetFileMaintenance;
    property Purchase: Boolean read GetPurchase write SetPurchase;
    property CRM: Boolean read GetCRM write SetCRM;
    property Marketing: Boolean read GetMarketing write SetMarketing;
    property Sales: Boolean read GetSales write SetSales;
    property Pos: Boolean read GetPos write SetPos;
    property CustomerPayments: Boolean read GetCustomerPayments write SetCustomerPayments;
    property SupplierPayments: Boolean read GetSupplierPayments write SetSupplierPayments;
    property Banking: Boolean read GetBanking write SetBanking;
    property Reports: Boolean read GetReports write SetReports;
    property General_Templates: Boolean read GetGeneral_Templates write SetGeneral_Templates;
    property Utilities: Boolean read GetUtilities write SetUtilities;
    property Inventory_Advanced: Boolean read GetInventory_Advanced write SetInventory_Advanced;
    property Manufacturing: Boolean read GetManufacturing write SetManufacturing;
    property Appointments: Boolean read GetAppointments write SetAppointments;
    property Payroll: Boolean read GetPayroll write SetPayroll;
    property FixedAssets: Boolean read GetFixedAssets write SetFixedAssets;
    property Workshop: Boolean read GetWorkshop write SetWorkshop;
    property budgets: Boolean read Getbudgets write Setbudgets;
    property Delivery: Boolean read GetDelivery write SetDelivery;
    property Matrix: Boolean read GetMatrix write SetMatrix;
    property DateCreated: TDateTime read GetDateCreated write SetDateCreated;
    property Enteredby: Integer read GetEnteredby write SetEnteredby;
    property How_To: boolean read GetHow_To write SetHow_To;
    property Hire: boolean read GetHire write SetHire;
//    property TrainingID: Integer read getTrainingID write setTrainingID;
  end;

  TTrainingDays = class(TTrainingBase)
  private
    function GetTrainingDate: TDate;
    function GetActive: Boolean;
    function GetStartTime: TDateTime;
    function GetEndTime: TDateTime;
    procedure SetTrainingDate(const Value: TDate);
    procedure SetActive(const Value: Boolean);
    procedure SetStartTime(const Value: TDateTime);
    procedure SetEndTime(const Value: TDateTime);
//    function getTrainingID: Integer;
//    procedure setTrainingID(const Value: Integer);
    (* function getTRaining: TTraining; *)
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

  published
    property TrainingDate: TDate read GetTrainingDate write SetTrainingDate;
    property Active: Boolean read GetActive write SetActive;
    property StartTime: TDateTime read GetStartTime write SetStartTime;
    property EndTime: TDateTime read GetEndTime write SetEndTime;
//    property TrainingID: Integer read getTrainingID write setTrainingID;
  end;

  TTrainingModuleTask = class(TMSBusObj)
  private
    function getSeqno: Integer;
    function GetTrainingModuleId: Integer;
    function GetTrainingModuleName: string;
    function GetTrainingModuleTaskTitle: string;
    function GetTrainingModuleTaskDescription: string;
    procedure setSeqno(const Value: Integer);
    procedure SetTrainingModuleId(const Value: Integer);
    procedure SetTrainingModuleName(const Value: string);
    procedure SetTrainingModuleTaskTitle(const Value: string);
    procedure SetTrainingModuleTaskDescription(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property Seqno: Integer read getSeqno write setSeqno;
    property TrainingModuleId: Integer read GetTrainingModuleId write SetTrainingModuleId;
    property TrainingModuleName: string read GetTrainingModuleName write SetTrainingModuleName;
    property TrainingModuleTaskTitle: string read GetTrainingModuleTaskTitle write SetTrainingModuleTaskTitle;
    property TrainingModuleTaskDescription: string read GetTrainingModuleTaskDescription write SetTrainingModuleTaskDescription;
  end;

  TTrainingEmployeeModuleStatusDetails = class(TMSBusObj)
  private
    function GettrainingemployeemoduleStatusID: Integer;
    function GetTaskID: Integer;
    function GetDone: Boolean;
    function GetDoneon: TDateTime;
    procedure SettrainingemployeemoduleStatusID(const Value: Integer);
    procedure SetTaskID(const Value: Integer);
    procedure SetDone(const Value: Boolean);
    procedure SetDoneon(const Value: TDateTime);
    function getSeqno: Integer;
    procedure setSeqno(const Value: Integer);
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
  published
    property trainingemployeemoduleStatusID: Integer read GettrainingemployeemoduleStatusID write SettrainingemployeemoduleStatusID;
    property TaskID: Integer read GetTaskID write SetTaskID;
    property Done: Boolean read GetDone write SetDone;
    property Doneon: TDateTime read GetDoneon write SetDoneon;
    property Seqno: Integer read getSeqno write setSeqno;
  end;

  TTrainingEmployeeModuleStatus = class(TTrainingBase)
  private
    function GetEmployeeId: Integer;
    function GetEmployeeName: string;
    function GetModuleId: Integer;
    function GetModulename: string;
    function GetVideoWatched: Boolean;
    function GetVideoWatchedon: TDateTime;
    (* function GetDateStarted                       : TDateTime ;
      function GetDatefinished                      : TDateTime ; *)
    procedure SetEmployeeId(const Value: Integer);
    procedure SetEmployeeName(const Value: string);
    procedure SetModuleId(const Value: Integer);
    procedure SetModulename(const Value: string);
    procedure SetVideoWatched(const Value: Boolean);
    procedure SetVideoWatchedon(const Value: TDateTime);
    (* procedure SetDateStarted                       (const Value: TDateTime );
      procedure SetDatefinished                      (const Value: TDateTime ); *)
    function getTrainingEmployeeModuleStatusDetails: TTrainingEmployeeModuleStatusDetails;
    function getDetails: TTrainingEmployeeModuleStatusDetails;
    function getModule: TTrainingModules;
//    function getTrainingID: Integer;
//    procedure setTrainingID(const Value: Integer);
    function getTrainingroster: TTrainingRoster;
    function getModuleSeqNo: Integer;
    procedure setModuleSeqNo(const Value: Integer);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforeDelete(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    property TrainingEmployeeModuleStatusDetails: TTrainingEmployeeModuleStatusDetails read getTrainingEmployeeModuleStatusDetails;
    property Trainingroster: TTrainingRoster read getTrainingroster;
    property Details: TTrainingEmployeeModuleStatusDetails read getDetails;
    property Module: TTrainingModules read getModule;
  published
    property EmployeeId: Integer read GetEmployeeId write SetEmployeeId;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property ModuleId: Integer read GetModuleId write SetModuleId;
    property Modulename: string read GetModulename write SetModulename;
    property VideoWatched: Boolean read GetVideoWatched write SetVideoWatched;
    property VideoWatchedOn: TDateTime read GetVideoWatchedon write SetVideoWatchedon;
    property ModuleSeqNo: Integer read getModuleSeqNo write setModuleSeqNo;
    (* property DateStarted                        :TDateTime   read GetDateStarted                      write SetDateStarted                   ;
      property Datefinished                       :TDateTime   read GetDatefinished                     write SetDatefinished                  ; *)
//    property TrainingID: Integer read getTrainingID write setTrainingID;
  end;

  TTraining = class(TMSBusObj)
  private
    AutoScheduled: Boolean;
    AllAutoScheduled: Boolean;
    dt: TDateTime;
    TrainingDayId: Integer;
    (* timetoallocate:Integer; *)
    ctr: Integer;
    fitotalBreak: Integer;

    { variables for autoschedule }
    SchedulingTrainingModuleID: Integer;
    SchedulingHours: Double;
    SchedulingCtr: Integer;
    TotaltoSchedule: Integer;
    TrainingHrsmultiplier: Double;
    fTrainingDaysDay: TDataset;
    fsTablename: string;
    TrainingDaysDayID: Integer;
    ScheduledAt: TDateTime;
    ScheduleFrom: TDateTime;
    AllLinesValid: boolean;
    fdTotalHoursforActivemodeuls:Double;
    function GetDescription: string;
    function GetTrainingDate: TDateTime;
    procedure SetDescription(const Value: string);
    procedure SetTrainingDate(const Value: TDateTime);
    function getTrainingDays: TTrainingDays;
    function getTrainingEmployeeModules: TTrainingEmployeeModules;
    function getTrainingEmployeeModuleStatus: TTrainingEmployeeModuleStatus;
    function getTrainingModules: TTrainingModules;
    function getTrainingroster: TTrainingRoster;
    (* Procedure DoAutoSchedule(Const Sender: TBusObj; var Abort: boolean); *)
    procedure DoAutoScheduleModule(const Sender: TBusObj; var Abort: Boolean);
    procedure TotalHoursforActivemodeulsCallback(const Sender: TBusObj; var Abort: Boolean);

    (* function Availabletime(timerequired:Integer):Integer; *)
    function getActiveTrainingModules: TTrainingModules;
    function getTrainingDay: TTrainingDay;
    function getTotalHours: Double;
    procedure setTotalHours(const Value: Double);
    procedure setMinutesInADay(const Value: Integer);
    procedure calctotalBreak(const Sender: TBusObj; var Abort: Boolean);
    function getHoursInaDay: string;
    procedure setHoursInaDay(const Value: string);
    function gettotalBreak: Integer;
    function getEndOftheDay: TTime;
    function getStartOfTheDay: TTime;
    procedure setEndOftheDay(const Value: TTime);
    procedure setStartOfTheDay(const Value: TTime);
    procedure NextSlot;
    procedure TrainingDaysDay(StartSchedulingFrom: TDateTime);
    function MinutesAlreadyScheduled(xTRainingModuleId, xEmployeeID: Integer): Integer;
    procedure TrainingDayValidateCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure TrainingDaysValidateCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure TrainingEmployeeModulesValidateCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure TrainingEmployeeModuleStatusValidateCallback(const Sender: TBusObj; var Abort: Boolean);
    function getTotalHoursforActivemodeuls: Double;
    function GetTotalTrainingDays: integer;
    procedure SetTotalTrainingDays(const Value: integer);
//    procedure TrainingModulesValidateCallback(const Sender: TBusObj; var Abort: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoCalcFields(Sender: TDatasetBusObj): Boolean; override;
  public
    AutoSelectDates: array of TDate;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    function AutoSchedule: Boolean;
    property TrainingDays: TTrainingDays read getTrainingDays;
    property TrainingEmployeeModules: TTrainingEmployeeModules read getTrainingEmployeeModules;
    property TrainingEmployeeModuleStatus: TTrainingEmployeeModuleStatus read getTrainingEmployeeModuleStatus;
    property TrainingModules: TTrainingModules read getTrainingModules;
    property ActiveTrainingModules: TTrainingModules read getActiveTrainingModules;
    property TrainingRoster: TTrainingRoster read getTrainingroster;
    property TrainingDay: TTrainingDay read getTrainingDay;
    function CalcMinutesInADay: Integer;
    function DaysPlan: string;
    procedure AutoSelectDays(Datefrom: TDateTime);
    property TotalBreak: Integer read gettotalBreak;
    function AutoScheduleFrom(StartSchedulingFrom: TDateTime): Boolean;
    function DaysRequiredForTraining: Integer;
    property MinutesInADay: Integer write setMinutesInADay;
    property HoursInADay: string read getHoursInaDay write setHoursInaDay;
  published
    property Description: string read GetDescription write SetDescription;
    property TrainingDate: TDateTime read GetTrainingDate write SetTrainingDate;
    property TotalHours: Double read getTotalHours write setTotalHours;
    property TotalHoursforActivemodeuls: Double read getTotalHoursforActivemodeuls;
    property StartOfTheDay: TTime read getStartOfTheDay write setStartOfTheDay;
    property EndOfTheDay: TTime read getEndOftheDay write setEndOftheDay;
    property TotalTrainingDays: integer read GetTotalTrainingDays write SetTotalTrainingDays;
  end;

implementation

uses tcDataUtils, CommonLib, AppEnvironment, EmployeeObj, sysutils,
  Progressdialog, TrainingLib, DefaultClassObj, DateUtils, BusObjConst, timelib,
  CompanyPrefObj, CommonDbLib, tcConst, BusObjSchemaLib;

{ TTrainingModules }

constructor TTrainingModules.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'TrainingModules';
  fSQL := 'SELECT * FROM tbltrainingmodules';
  fSQLOrder := 'SeqNo';
  fQryTotalHours := nil;
end;

destructor TTrainingModules.Destroy;
begin
  inherited;
end;

procedure TTrainingModules.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'TrainingModuleName');
  SetBooleanPropertyFromNode(node, 'Active');
  SetPropertyFromNode(node, 'Videofilename');
  SetPropertyFromNode(node, 'TrainingHrs');
  SetPropertyFromNode(node, 'ModuleHelpcontextID');

end;

procedure TTrainingModules.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'TrainingModuleName', TrainingModuleName);
  AddXMLNode(node, 'Videofilename', Videofilename);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'TrainingHrs', TrainingHrs);
  AddXMLNode(node, 'ModuleHelpcontextID', ModuleHelpcontextID);
end;

function TTrainingModules.ValidateData: Boolean;
begin
  { note this table is not edatible by user }
  Resultstatus.Clear;
  result := false;
  if TrainingModuleName = '' then begin
    AddResult(False, rssError, 0, 'Training Module Name should not be blank');
    Exit;
  end;
  if self.SeqNo  < 0 then begin
    AddResult(False, rssError, 0, 'Sequence No should be greater than zero');
    Exit;
  end;
  if TEMFieldName = '' then begin
    AddResult(False, rssError, 0, 'TEM Field Name should not be blank');
    Exit;
  end;

  Result := True;
end;

class function TTrainingModules._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TTraining','TrainingObj','TrainingID','ID');
end;

function TTrainingModules.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
  if not Result then Exit;
end;

procedure TTrainingModules.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TTrainingModules.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
  inherited;
end;

function TTrainingModules.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TTrainingModules.GetIDField: string;
begin
  Result := 'TrainingModuleID'
end;

class function TTrainingModules.GetKeyStringField: string;
begin
  result := 'TrainingModuleName';
end;

class function TTrainingModules.GetBusObjectTablename: string;
begin
  Result := 'tbltrainingmodules';
end;

function TTrainingModules.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
  if TRaining.TotalHours <> QryTotalHours.FieldByname('TotalHours').asFloat then begin
    TRaining.TotalHours := QryTotalHours.FieldByname('TotalHours').asFloat;
    TRaining.PostDB;
    SendEvent(BusObjEvent_Change, BusObjEventVal_TotalHours, Self);
  end;
end;

{ Property Functions }
function TTrainingModules.GetTrainingModuleName: string;
begin
  Result := GetStringField('TrainingModuleName');
end;

function TTrainingModules.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

procedure TTrainingModules.SetTrainingModuleName(const Value: string);
begin
  SetStringField('TrainingModuleName', Value);
end;

procedure TTrainingModules.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

constructor TTrainingEmployeeModules.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'TrainingEmployeeModules';
  fSQL := 'SELECT * FROM tbltrainingemployeemodules';
  fTrainingModules := nil;
end;

destructor TTrainingEmployeeModules.Destroy;
begin
  inherited;
end;

procedure TTrainingEmployeeModules.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'EmployeeId');
  SetPropertyFromNode(node, 'EmployeeName');
  SetPropertyFromNode(node, 'MoreTrainingDetails');
  SetBooleanPropertyFromNode(node, 'BasicFeatures');
  SetBooleanPropertyFromNode(node, 'Purchase_FX');
  SetBooleanPropertyFromNode(node, 'ERPSetup');
  SetBooleanPropertyFromNode(node, 'DataImport');
  SetBooleanPropertyFromNode(node, 'MoreTraining');
  SetBooleanPropertyFromNode(node, 'Employee');
  SetBooleanPropertyFromNode(node, 'Accounts');
  SetBooleanPropertyFromNode(node, 'Inventory_Basics');
  SetBooleanPropertyFromNode(node, 'FileMaintenance');
  SetBooleanPropertyFromNode(node, 'Purchase');
  SetBooleanPropertyFromNode(node, 'CRM');
  SetBooleanPropertyFromNode(node, 'Marketing');
  SetBooleanPropertyFromNode(node, 'Sales');
  SetBooleanPropertyFromNode(node, 'Pos');
  SetBooleanPropertyFromNode(node, 'CustomerPayments');
  SetBooleanPropertyFromNode(node, 'SupplierPayments');
  SetBooleanPropertyFromNode(node, 'Banking');
  SetBooleanPropertyFromNode(node, 'Reports');
  SetBooleanPropertyFromNode(node, 'General_Templates');
  SetBooleanPropertyFromNode(node, 'Utilities');
  SetBooleanPropertyFromNode(node, 'Inventory_Advanced');
  SetBooleanPropertyFromNode(node, 'Manufacturing');
  SetBooleanPropertyFromNode(node, 'Appointments');
  SetBooleanPropertyFromNode(node, 'Payroll');
  SetBooleanPropertyFromNode(node, 'FixedAssets');
  SetBooleanPropertyFromNode(node, 'Workshop');
  SetBooleanPropertyFromNode(node, 'budgets');
  SetBooleanPropertyFromNode(node, 'Delivery');
  SetBooleanPropertyFromNode(node, 'Matrix');
  SetBooleanPropertyFromNode(node, 'How_To');
  SetBooleanPropertyFromNode(node, 'Hire');
  SetDateTimePropertyFromNode(node, 'DateCreated');
  SetPropertyFromNode(node, 'Enteredby');
end;

procedure TTrainingEmployeeModules.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'EmployeeId', EmployeeId);
  AddXMLNode(node, 'EmployeeName', EmployeeName);
  AddXMLNode(node, 'MoreTrainingDetails', MoreTrainingDetails);
  AddXMLNode(node, 'BasicFeatures', BasicFeatures);
  AddXMLNode(node, 'Purchase_FX', Purchase_FX);
  AddXMLNode(node, 'ERPSetup', ERPSetup);
  AddXMLNode(node, 'DataImport', DataImport);
  AddXMLNode(node, 'MoreTraining', MoreTraining);
  AddXMLNode(node, 'Employee', Employee);
  AddXMLNode(node, 'Accounts', Accounts);
  AddXMLNode(node, 'Inventory_Basics', Inventory_Basics);
  AddXMLNode(node, 'FileMaintenance', FileMaintenance);
  AddXMLNode(node, 'Purchase', Purchase);
  AddXMLNode(node, 'CRM', CRM);
  AddXMLNode(node, 'Marketing', Marketing);
  AddXMLNode(node, 'Sales', Sales);
  AddXMLNode(node, 'Pos', Pos);
  AddXMLNode(node, 'CustomerPayments', CustomerPayments);
  AddXMLNode(node, 'SupplierPayments', SupplierPayments);
  AddXMLNode(node, 'Banking', Banking);
  AddXMLNode(node, 'Reports', Reports);
  AddXMLNode(node, 'General_Templates', General_Templates);
  AddXMLNode(node, 'Utilities', Utilities);
  AddXMLNode(node, 'Inventory_Advanced', Inventory_Advanced);
  AddXMLNode(node, 'Manufacturing', Manufacturing);
  AddXMLNode(node, 'Appointments', Appointments);
  AddXMLNode(node, 'Payroll', Payroll);
  AddXMLNode(node, 'FixedAssets', FixedAssets);
  AddXMLNode(node, 'Workshop', Workshop);
  AddXMLNode(node, 'budgets', budgets);
  AddXMLNode(node, 'Delivery', Delivery);
  AddXMLNode(node, 'Matrix', Matrix);
  AddXMLNode(node, 'How_To', How_To);
  AddXMLNode(node, 'Hire', Hire);
  AddXMLNode(node, 'DateCreated', DateCreated);
  AddXMLNode(node, 'Enteredby', Enteredby);
end;

function TTrainingEmployeeModules.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;

  if (TrainingId = 0) then begin
    AddResult(False, rssError, 0, 'Training ID should not be 0');
    Exit;
  end;
  if (EmployeeId = 0) then begin
    AddResult(False, rssError, 0, 'Employee ID should not be 0');
    Exit;
  end;
  if (EmployeeName = '')  then begin
    AddResult(False, rssError, 0, 'Employee Name should not be 0');
    Exit;
  end;
  Result := True;
end;

function TTrainingEmployeeModules.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
  if not Result then Exit;
  DoShowProgressbar(25 * count, 'Please Wait');
  try Iteraterecords(CreateTaskrecords);
  finally DoHideProgressbar;
  end;
end;

procedure TTrainingEmployeeModules.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  ficurrentId := Id;
end;

procedure TTrainingEmployeeModules.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
  inherited;
  if sysutils.SameText(Sender.FieldName, 'EmployeeID') then begin
    EmployeeName := EmployeeObj.EmployeeName;
  end
  else if sysutils.SameText(Sender.FieldName, 'MoreTraining') then begin
    if MoreTraining then
      if not AnyModuleAssigned then MoreTraining := False;
  end
  else if sysutils.SameText(Sender.FieldName, 'MoreTrainingDetails') then begin
    if MoreTrainingDetails <> '' then
      if not AnyModuleAssigned then MoreTrainingDetails := '';
  end;

end;

function TTrainingEmployeeModules.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TTrainingEmployeeModules.GetIDField: string;
begin
  Result := 'TrainingEmployeeModuleID'
end;

class function TTrainingEmployeeModules.GetBusObjectTablename: string;
begin
  Result := 'tbltrainingemployeemodules';
end;

function TTrainingEmployeeModules.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TTrainingEmployeeModules.GetEmployeeId: Integer;
begin
  Result := GetIntegerField('EmployeeId');
end;

function TTrainingEmployeeModules.GetEmployeeName: string;
begin
  Result := GetStringField('EmployeeName');
end;

function TTrainingEmployeeModules.GetMoreTrainingDetails: string;
begin
  Result := GetStringField('MoreTrainingDetails');
end;

function TTrainingEmployeeModules.GetBasicFeatures: Boolean;
begin
  Result := GetBooleanField('BasicFeatures');
end;

function TTrainingEmployeeModules.GetPurchase_FX: Boolean;
begin
  Result := GetBooleanField('Purchase_FX');
end;

function TTrainingEmployeeModules.GetERPSetup: Boolean;
begin
  Result := GetBooleanField('ERPSetup');
end;

function TTrainingEmployeeModules.GetDataImport: Boolean;
begin
  Result := GetBooleanField('DataImport');
end;

function TTrainingEmployeeModules.GetMoreTraining: Boolean;
begin
  Result := GetBooleanField('MoreTraining');
end;

function TTrainingEmployeeModules.GetEmployee: Boolean;
begin
  Result := GetBooleanField('Employee');
end;

function TTrainingEmployeeModules.GetAccounts: Boolean;
begin
  Result := GetBooleanField('Accounts');
end;

function TTrainingEmployeeModules.GetInventory_Basics: Boolean;
begin
  Result := GetBooleanField('Inventory_Basics');
end;

function TTrainingEmployeeModules.GetFileMaintenance: Boolean;
begin
  Result := GetBooleanField('FileMaintenance');
end;

function TTrainingEmployeeModules.GetPurchase: Boolean;
begin
  Result := GetBooleanField('Purchase');
end;

function TTrainingEmployeeModules.GetCRM: Boolean;
begin
  Result := GetBooleanField('CRM');
end;

function TTrainingEmployeeModules.GetMarketing: Boolean;
begin
  Result := GetBooleanField('Marketing');
end;

function TTrainingEmployeeModules.GetSales: Boolean;
begin
  Result := GetBooleanField('Sales');
end;

function TTrainingEmployeeModules.GetPos: Boolean;
begin
  Result := GetBooleanField('Pos');
end;

function TTrainingEmployeeModules.GetCustomerPayments: Boolean;
begin
  Result := GetBooleanField('CustomerPayments');
end;

function TTrainingEmployeeModules.GetSupplierPayments: Boolean;
begin
  Result := GetBooleanField('SupplierPayments');
end;

function TTrainingEmployeeModules.GetBanking: Boolean;
begin
  Result := GetBooleanField('Banking');
end;

function TTrainingEmployeeModules.GetReports: Boolean;
begin
  Result := GetBooleanField('Reports');
end;

function TTrainingEmployeeModules.GetGeneral_Templates: Boolean;
begin
  Result := GetBooleanField('General_Templates');
end;

function TTrainingEmployeeModules.GetHire: boolean;
begin
  result := GetBooleanField('Hire');
end;

function TTrainingEmployeeModules.GetHow_To: boolean;
begin
  result := GetBooleanField('How_To');
end;

function TTrainingEmployeeModules.GetUtilities: Boolean;
begin
  Result := GetBooleanField('Utilities');
end;

function TTrainingEmployeeModules.GetInventory_Advanced: Boolean;
begin
  Result := GetBooleanField('Inventory_Advanced');
end;

function TTrainingEmployeeModules.GetManufacturing: Boolean;
begin
  Result := GetBooleanField('Manufacturing');
end;

function TTrainingEmployeeModules.GetAppointments: Boolean;
begin
  Result := GetBooleanField('Appointments');
end;

function TTrainingEmployeeModules.GetPayroll: Boolean;
begin
  Result := GetBooleanField('Payroll');
end;

function TTrainingEmployeeModules.GetFixedAssets: Boolean;
begin
  Result := GetBooleanField('FixedAssets');
end;

function TTrainingEmployeeModules.GetWorkshop: Boolean;
begin
  Result := GetBooleanField('Workshop');
end;

function TTrainingEmployeeModules.Getbudgets: Boolean;
begin
  Result := GetBooleanField('budgets');
end;

function TTrainingEmployeeModules.GetDelivery: Boolean;
begin
  Result := GetBooleanField('Delivery');
end;

function TTrainingEmployeeModules.GetMatrix: Boolean;
begin
  Result := GetBooleanField('Matrix');
end;

function TTrainingEmployeeModules.GetDateCreated: TDateTime;
begin
  Result := GetDateTimeField('DateCreated');
end;

function TTrainingEmployeeModules.GetEnteredby: Integer;
begin
  Result := GetIntegerField('Enteredby');
end;

procedure TTrainingEmployeeModules.SetEmployeeId(const Value: Integer);
begin
  SetIntegerField('EmployeeId', Value);
end;

procedure TTrainingEmployeeModules.SetEmployeeName(const Value: string);
begin
  SetStringField('EmployeeName', Value);
end;

procedure TTrainingEmployeeModules.SetMoreTrainingDetails(const Value: string);
begin
  SetStringField('MoreTrainingDetails', Value);
end;

procedure TTrainingEmployeeModules.SetBasicFeatures(const Value: Boolean);
begin
  SetBooleanField('BasicFeatures', Value);
end;

procedure TTrainingEmployeeModules.SetPurchase_FX(const Value: Boolean);
begin
  SetBooleanField('Purchase_FX', Value);
end;

procedure TTrainingEmployeeModules.SetERPSetup(const Value: Boolean);
begin
  SetBooleanField('ERPSetup', Value);
end;

procedure TTrainingEmployeeModules.SetDataImport(const Value: Boolean);
begin
  SetBooleanField('DataImport', Value);
end;

procedure TTrainingEmployeeModules.SetMoreTraining(const Value: Boolean);
begin
  SetBooleanField('MoreTraining', Value);
end;

procedure TTrainingEmployeeModules.SetEmployee(const Value: Boolean);
begin
  SetBooleanField('Employee', Value);
end;

procedure TTrainingEmployeeModules.SetAccounts(const Value: Boolean);
begin
  SetBooleanField('Accounts', Value);
end;

procedure TTrainingEmployeeModules.SetInventory_Basics(const Value: Boolean);
begin
  SetBooleanField('Inventory_Basics', Value);
end;

procedure TTrainingEmployeeModules.SetFileMaintenance(const Value: Boolean);
begin
  SetBooleanField('FileMaintenance', Value);
end;

procedure TTrainingEmployeeModules.SetPurchase(const Value: Boolean);
begin
  SetBooleanField('Purchase', Value);
end;

procedure TTrainingEmployeeModules.SetCRM(const Value: Boolean);
begin
  SetBooleanField('CRM', Value);
end;

procedure TTrainingEmployeeModules.SetMarketing(const Value: Boolean);
begin
  SetBooleanField('Marketing', Value);
end;

procedure TTrainingEmployeeModules.SetSales(const Value: Boolean);
begin
  SetBooleanField('Sales', Value);
end;

procedure TTrainingEmployeeModules.SetPos(const Value: Boolean);
begin
  SetBooleanField('Pos', Value);
end;

procedure TTrainingEmployeeModules.SetCustomerPayments(const Value: Boolean);
begin
  SetBooleanField('CustomerPayments', Value);
end;

procedure TTrainingEmployeeModules.SetSupplierPayments(const Value: Boolean);
begin
  SetBooleanField('SupplierPayments', Value);
end;

procedure TTrainingEmployeeModules.SetBanking(const Value: Boolean);
begin
  SetBooleanField('Banking', Value);
end;

procedure TTrainingEmployeeModules.SetReports(const Value: Boolean);
begin
  SetBooleanField('Reports', Value);
end;

procedure TTrainingEmployeeModules.SetGeneral_Templates(const Value: Boolean);
begin
  SetBooleanField('General_Templates', Value);
end;

procedure TTrainingEmployeeModules.SetHire(const Value: boolean);
begin
  SetBooleanField('Hire',Value);
end;

procedure TTrainingEmployeeModules.SetHow_To(const Value: boolean);
begin
  SetBooleanField('How_To',Value);
end;

procedure TTrainingEmployeeModules.SetUtilities(const Value: Boolean);
begin
  SetBooleanField('Utilities', Value);
end;

procedure TTrainingEmployeeModules.SetInventory_Advanced(const Value: Boolean);
begin
  SetBooleanField('Inventory_Advanced', Value);
end;

procedure TTrainingEmployeeModules.SetManufacturing(const Value: Boolean);
begin
  SetBooleanField('Manufacturing', Value);
end;

procedure TTrainingEmployeeModules.SetAppointments(const Value: Boolean);
begin
  SetBooleanField('Appointments', Value);
end;

procedure TTrainingEmployeeModules.SetPayroll(const Value: Boolean);
begin
  SetBooleanField('Payroll', Value);
end;

procedure TTrainingEmployeeModules.SetFixedAssets(const Value: Boolean);
begin
  SetBooleanField('FixedAssets', Value);
end;

procedure TTrainingEmployeeModules.SetWorkshop(const Value: Boolean);
begin
  SetBooleanField('Workshop', Value);
end;

procedure TTrainingEmployeeModules.Setbudgets(const Value: Boolean);
begin
  SetBooleanField('budgets', Value);
end;

procedure TTrainingEmployeeModules.SetDelivery(const Value: Boolean);
begin
  SetBooleanField('Delivery', Value);
end;

procedure TTrainingEmployeeModules.SetMatrix(const Value: Boolean);
begin
  SetBooleanField('Matrix', Value);
end;

procedure TTrainingEmployeeModules.SetDateCreated(const Value: TDateTime);
begin
  SetDateTimeField('DateCreated', Value);
end;

procedure TTrainingEmployeeModules.SetEnteredby(const Value: Integer);
begin
  SetIntegerField('Enteredby', Value);
end;

constructor TTrainingModuleTask.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'TrainingModuleTask';
  fSQL := 'SELECT * FROM tbltrainingmoduletask';
end;

destructor TTrainingModuleTask.Destroy;
begin
  inherited;
end;

procedure TTrainingModuleTask.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'Seqno');
  SetPropertyFromNode(node, 'TrainingModuleId');
  SetPropertyFromNode(node, 'TrainingModuleName');
  SetPropertyFromNode(node, 'TrainingModuleTaskTitle');
  SetPropertyFromNode(node, 'TrainingModuleTaskDescription');
end;

procedure TTrainingModuleTask.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Seqno', Seqno);
  AddXMLNode(node, 'TrainingModuleId', TrainingModuleId);
  AddXMLNode(node, 'TrainingModuleName', TrainingModuleName);
  AddXMLNode(node, 'TrainingModuleTaskTitle', TrainingModuleTaskTitle);
  AddXMLNode(node, 'TrainingModuleTaskDescription', TrainingModuleTaskDescription);
end;

function TTrainingModuleTask.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if Seqno = 0 then begin
    Resultstatus.AddItem(False, rssError, 0, 'Seqno should not be 0', False);
    Exit;
  end;
  Result := True;
end;

function TTrainingModuleTask.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TTrainingModuleTask.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TTrainingModuleTask.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TTrainingModuleTask.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TTrainingModuleTask.GetIDField: string;
begin
  Result := 'TrainingModuleTaskID'
end;

class function TTrainingModuleTask.GetBusObjectTablename: string;
begin
  Result := 'tbltrainingmoduletask';
end;

function TTrainingModuleTask.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TTrainingModuleTask.getSeqno: Integer;
begin
  Result := GetIntegerField('Seqno');
end;

function TTrainingModuleTask.GetTrainingModuleId: Integer;
begin
  Result := GetIntegerField('TrainingModuleId');
end;

function TTrainingModuleTask.GetTrainingModuleName: string;
begin
  Result := GetStringField('TrainingModuleName');
end;

function TTrainingModuleTask.GetTrainingModuleTaskTitle: string;
begin
  Result := GetStringField('TrainingModuleTaskTitle');
end;

function TTrainingModuleTask.GetTrainingModuleTaskDescription: string;
begin
  Result := GetStringField('TrainingModuleTaskDescription');
end;

procedure TTrainingModuleTask.setSeqno(const Value: Integer);
begin
  SetIntegerField('Seqno', Value);
end;

procedure TTrainingModuleTask.SetTrainingModuleId(const Value: Integer);
begin
  SetIntegerField('TrainingModuleId', Value);
end;

procedure TTrainingModuleTask.SetTrainingModuleName(const Value: string);
begin
  SetStringField('TrainingModuleName', Value);
end;

procedure TTrainingModuleTask.SetTrainingModuleTaskTitle(const Value: string);
begin
  SetStringField('TrainingModuleTaskTitle', Value);
end;

procedure TTrainingModuleTask.SetTrainingModuleTaskDescription(const Value: string);
begin
  SetStringField('TrainingModuleTaskDescription', Value);
end;

function TTrainingEmployeeModules.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;

  if assigned(Self.Owner) then
    if Self.Owner is TTraining then TrainingID := TTraining(Self.Owner).Id;

  DateCreated := now();
  Enteredby := Appenv.Employee.EmployeeId;
end;

function TTrainingEmployeeModules.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
//  if not Result then Exit;
//  if EmployeeId = 0 then begin
//    Resultstatus.AddItem(False, rssWarning, 0, 'Employee Should Not Be Blank..');
//    Result := False;
//    Exit;
//  end;
//  if not IsUnique(Self.Id, 'EmployeeId = ' + IntToStr(EmployeeId)) then begin
//    Resultstatus.AddItem(False, rssWarning, 0, 'Training Modules are Already Assigned For ' + EmployeeName + '.');
//    Result := False;
//    Exit;
//  end;
end;

function TTrainingEmployeeModules.getEmployeeObj: TEmployeeDetails;
begin
  Result := TEmployeeDetails(getContainerComponent(TEmployeeDetails, 'EmployeeId = ' + IntToStr(EmployeeId)));
end;

function TTrainingModules.getVideofilename: string;
begin
  Result := GetStringField('Videofilename');
end;

procedure TTrainingModules.setVideofilename(const Value: string);
begin
  SetStringField('Videofilename', Value);
end;

function TTrainingModules.GetTEMFieldname: string;
begin
  Result := GetStringField('TEMFieldname');
end;

procedure TTrainingModules.SetTEMFieldname(const Value: string);
begin
  SetStringField('TEMFieldname', Value);
end;

//function TTrainingModules.getTrainingID: Integer;
//begin
//  Result := GetIntegerField('TrainingId');
//end;

//procedure TTrainingModules.setTrainingID(const Value: Integer);
//begin
//  SetIntegerField('TrainingId', Value)
//end;

function TTrainingModules.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;

  if assigned(Self.Owner) then
    if Self.Owner is TTraining then TrainingID := TTraining(Self.Owner).Id;
end;

function TTrainingModules.getTrainingEmployeeModules: TTrainingEmployeeModules;
var
  id: integer;
begin
  if Assigned(Owner) and (Owner is TTraining) then
    id := TTraining(Owner).ID
  else
    id := TrainingId;

  Result := TTrainingEmployeeModules(getContainerComponent(TTrainingEmployeeModules, 'TrainingId= ' + IntToStr(id) + ' and ' + TEMFieldname + '= ' + QuotedStr('T')));
end;

function TTrainingModules.getTrainingHrs: Double;
begin
  Result := getFloatfield('TrainingHrs');
end;

procedure TTrainingModules.setTrainingHrs(const Value: Double);
begin
  SetFloatfield('TrainingHrs', Value);
end;

function TTrainingModules.getSeqno: Integer;
begin
  Result := GetIntegerField('Seqno');
end;

procedure TTrainingModules.setSeqno(const Value: Integer);
begin
  SetIntegerField('Seqno', Value);
end;

(* function TTrainingModules.getTraining: TTraining;
  begin
  result := TTraining(getContainerComponent(TTraining , 'TrainingID = ' +IntToStr(TrainingID)));
  end; *)

function TTrainingModules.getQryTotalHours: TErpQuery;
begin
  if not(assigned(fQryTotalHours)) then begin
    fQryTotalHours := TErpQuery(getNewDataset('Select sum(TrainingHrs) TotalHours from tbltrainingmodules where trainingId = ' + IntToStr(TrainingID), True));
  end;
  if fQryTotalHours.Active then fQryTotalHours.close;
  fQryTotalHours.open;
  Result := fQryTotalHours;
end;

function TTrainingModules.getModuleHelpcontextID: string;
begin
  Result := GetStringField('ModuleHelpcontextID');
end;

procedure TTrainingModules.setModuleHelpcontextID(const Value: string);
begin
  SetStringField('ModuleHelpcontextID', Value);
end;

{ TTrainingEmployeeModuleStatus }

constructor TTrainingEmployeeModuleStatus.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'TrainingEmployeeModuleStatus';
  fSQL := 'SELECT * FROM tbltrainingemployeemodulestatus';
  fSQLOrder := 'ModuleSeqNo';
end;

destructor TTrainingEmployeeModuleStatus.Destroy;
begin
  inherited;
end;

procedure TTrainingEmployeeModuleStatus.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'EmployeeId');
  SetPropertyFromNode(node, 'EmployeeName');
  SetPropertyFromNode(node, 'ModuleId');
  SetPropertyFromNode(node, 'Modulename');
  SetBooleanPropertyFromNode(node, 'VideoWatched');
  SetDateTimePropertyFromNode(node, 'VideoWatchedon');
  (* SetDateTimePropertyFromNode(node,'DateStarted');
    SetDateTimePropertyFromNode(node,'Datefinished'); *)
end;

procedure TTrainingEmployeeModuleStatus.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'EmployeeId', EmployeeId);
  AddXMLNode(node, 'EmployeeName', EmployeeName);
  AddXMLNode(node, 'ModuleId', ModuleId);
  AddXMLNode(node, 'Modulename', Modulename);
  AddXMLNode(node, 'VideoWatched', VideoWatched);
  AddXMLNode(node, 'VideoWatchedon', VideoWatchedon);
  (* AddXMLNode(node,'DateStarted' ,DateStarted);
    AddXMLNode(node,'Datefinished' ,Datefinished); *)
end;

function TTrainingEmployeeModuleStatus.ValidateData: Boolean;
begin
  Resultstatus.Clear;
  Result := True;
  if self.EmployeeId = 0 then begin
    AddResult(False, rssWArning, 0, 'Employee ID should not be blank');
    exit;
  end;
  if self.EmployeeName = '' then begin
    AddResult(False, rssWArning, 0, 'Employee Name should not be blank');
    exit;
  end;
  if self.TrainingId = 0 then begin
    AddResult(False, rssWArning, 0, 'Training should not be blank');
    exit;
  end;
  if self.ModuleId = 0 then begin
    AddResult(False, rssWArning, 0, 'Module ID should not be blank');
    exit;
  end;
  if self.ModuleName = '' then begin
    AddResult(False, rssWArning, 0, 'Module Name should not be blank');
    exit;
  end;
  if self.ModuleSeqNo < 1 then begin
    AddResult(False, rssWArning, 0, 'Module SEquence No should not be greater than zero');
    exit;
  end;

  Result := True;
end;

function TTrainingEmployeeModuleStatus.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TTrainingEmployeeModuleStatus.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  { as the form shows grid- multiple records- and the dataset is on the form, to reopen
    the dataset, it has to be closed }
  if getContainerComponentifExists(TTrainingEmployeeModuleStatusDetails) <> nil then TTrainingEmployeeModuleStatusDetails(getContainerComponentifExists(TTrainingEmployeeModuleStatusDetails)).closeDB;
end;

procedure TTrainingEmployeeModuleStatus.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
  inherited;
  if sysutils.SameText(Sender.FieldName, 'VideoWatched') then begin
    if VideoWatched then
      if VideoWatchedon = 0 then VideoWatchedon := date;
    (* end else if (Sysutils.SameText(Sender.FieldName , 'DateStarted')) then begin
      if (DateStarted > DateFinished) and (DateFinished <> 0) then
      DateStarted := DateFinished;
      end else if (Sysutils.SameText(Sender.FieldName , 'DateFinished')) then begin
      if (DateStarted > DateFinished)  then
      DateFinished:= DateStarted; *)
  end;
end;

function TTrainingEmployeeModuleStatus.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TTrainingEmployeeModuleStatus.GetIDField: string;
begin
  Result := 'trainingemployeemoduleStatusID'
end;

class function TTrainingEmployeeModuleStatus.GetBusObjectTablename: string;
begin
  Result := 'tbltrainingemployeemodulestatus';
end;

function TTrainingEmployeeModuleStatus.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TTrainingEmployeeModuleStatus.GetEmployeeId: Integer;
begin
  Result := GetIntegerField('EmployeeId');
end;

function TTrainingEmployeeModuleStatus.GetEmployeeName: string;
begin
  Result := GetStringField('EmployeeName');
end;

function TTrainingEmployeeModuleStatus.GetModuleId: Integer;
begin
  Result := GetIntegerField('ModuleId');
end;

function TTrainingEmployeeModuleStatus.GetModulename: string;
begin
  Result := GetStringField('Modulename');
end;

function TTrainingEmployeeModuleStatus.GetVideoWatched: Boolean;
begin
  Result := GetBooleanField('VideoWatched');
end;

function TTrainingEmployeeModuleStatus.GetVideoWatchedon: TDateTime;
begin
  Result := GetDateTimeField('VideoWatchedon');
end;
(* function  TTrainingEmployeeModuleStatus.GetDateStarted                   : TDateTime ; begin Result := GetDateTimeField('DateStarted');end;
  function  TTrainingEmployeeModuleStatus.GetDatefinished                  : TDateTime ; begin Result := GetDateTimeField('Datefinished');end; *)

procedure TTrainingEmployeeModuleStatus.SetEmployeeId(const Value: Integer);
begin
  SetIntegerField('EmployeeId', Value);
end;

procedure TTrainingEmployeeModuleStatus.SetEmployeeName(const Value: string);
begin
  SetStringField('EmployeeName', Value);
end;

procedure TTrainingEmployeeModuleStatus.SetModuleId(const Value: Integer);
begin
  SetIntegerField('ModuleId', Value);
end;

procedure TTrainingEmployeeModuleStatus.SetModulename(const Value: string);
begin
  SetStringField('Modulename', Value);
end;

procedure TTrainingEmployeeModuleStatus.SetVideoWatched(const Value: Boolean);
begin
  SetBooleanField('VideoWatched', Value);
end;

procedure TTrainingEmployeeModuleStatus.SetVideoWatchedon(const Value: TDateTime);
begin
  SetDateTimeField('VideoWatchedon', Value);
end;

(* procedure TTrainingEmployeeModuleStatus.SetDateStarted                   (const Value: TDateTime ); begin SetDateTimeField('DateStarted'                    , Value);end;
  procedure TTrainingEmployeeModuleStatus.SetDatefinished                  (const Value: TDateTime ); begin SetDateTimeField('Datefinished'                   , Value);end; *)
//function TTrainingEmployeeModuleStatus.getTrainingID: Integer;
//begin
//  Result := GetIntegerField('TrainingId');
//end;

//procedure TTrainingEmployeeModuleStatus.setTrainingID(const Value: Integer);
//begin
//  SetIntegerField('TrainingId', Value)
//end;

function TTrainingEmployeeModuleStatus.getTrainingEmployeeModuleStatusDetails: TTrainingEmployeeModuleStatusDetails;
begin
  Result := TTrainingEmployeeModuleStatusDetails(getContainerComponent(TTrainingEmployeeModuleStatusDetails, 'trainingemployeemoduleStatusID = ' + IntToStr(Id)));
end;

function TTrainingEmployeeModuleStatus.getDetails: TTrainingEmployeeModuleStatusDetails;
begin
  Result := TTrainingEmployeeModuleStatusDetails(getContainerComponent(TTrainingEmployeeModuleStatusDetails, 'trainingemployeemoduleStatusID = ' + IntToStr(Id)));
end;

function TTrainingEmployeeModuleStatus.getModule: TTrainingModules;
begin
  Result := TTrainingModules(getContainerComponent(TTrainingModules, 'TrainingModuleID = ' + IntToStr(ModuleId)));
end;

function TTrainingEmployeeModuleStatus.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;

  if assigned(Self.Owner) then
    if Self.Owner is TTraining then TrainingID := TTraining(Self.Owner).Id;
end;

function TTrainingEmployeeModuleStatus.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeDelete(Sender);
  if not Result then Exit;
  TrainingEmployeeModuleStatusDetails.DeleteAll;
  Trainingroster.DeleteAll;
end;

function TTrainingEmployeeModuleStatus.getTrainingroster: TTrainingRoster;
begin
  Result := TTrainingRoster(getContainerComponent(TTrainingRoster, ' Type = ' + QuotedStr('Training') + ' and TrainingID = ' + IntToStr(self.TrainingID) + ' and TrainingModuleId=' + IntToStr(ModuleId) + ' and employeeId = ' + IntToStr(EmployeeId)));
end;

function TTrainingEmployeeModuleStatus.getModuleSeqNo: Integer;
begin
  Result := GetIntegerField('ModuleSeqNo');
end;

procedure TTrainingEmployeeModuleStatus.setModuleSeqNo(const Value: Integer);
begin
  SetIntegerField('ModuleSeqNo', Value);
end;

{ TTrainingEmployeeModuleStatusDetails }

constructor TTrainingEmployeeModuleStatusDetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'TrainingEmployeeModuleStatusDetails';
  fSQL := 'SELECT * FROM tbltrainingemployeemodulestatusdetails';
end;

destructor TTrainingEmployeeModuleStatusDetails.Destroy;
begin
  inherited;
end;

procedure TTrainingEmployeeModuleStatusDetails.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'trainingemployeemoduleStatusID');
  SetPropertyFromNode(node, 'TaskID');
  SetBooleanPropertyFromNode(node, 'Done');
  SetDateTimePropertyFromNode(node, 'Doneon');
end;

procedure TTrainingEmployeeModuleStatusDetails.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'trainingemployeemoduleStatusID', trainingemployeemoduleStatusID);
  AddXMLNode(node, 'TaskID', TaskID);
  AddXMLNode(node, 'Done', Done);
  AddXMLNode(node, 'Doneon', Doneon);
end;

function TTrainingEmployeeModuleStatusDetails.ValidateData: Boolean;
begin
  Resultstatus.Clear;
  Result := True;
end;

function TTrainingEmployeeModuleStatusDetails.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TTrainingEmployeeModuleStatusDetails.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TTrainingEmployeeModuleStatusDetails.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if sysutils.SameText(Sender.FieldName, 'done') then begin
    if Done then begin
      if Doneon = 0 then Doneon := date;
    end else begin
      if Doneon <> 0 then Doneon := 0;
    end;
    (* end else if Sysutils.SameText(Sender.FieldName , 'doneon') then begin
      if doneon <> 0 then
      if Assigned(Self.Owner) then
      if Self.Owner is TTrainingEmployeeModuleStatus then
      if TTrainingEmployeeModuleStatus(Self.Owner).DateStarted > doneon then begin
      TTrainingEmployeeModuleStatus(Self.Owner).DateStarted:= doneOn;
      TTrainingEmployeeModuleStatus(Self.Owner).DateStarted.PostDB;
      end else if (TTrainingEmployeeModuleStatus(Self.Owner).Datefinished < doneon) and (TTrainingEmployeeModuleStatus(Self.Owner).Datefinished<> 0) then begin
      TTrainingEmployeeModuleStatus(Self.Owner).Datefinished:= doneOn;
      TTrainingEmployeeModuleStatus(Self.Owner).Datefinished.PostDB;
      end; *)
  end;
end;

function TTrainingEmployeeModuleStatusDetails.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TTrainingEmployeeModuleStatusDetails.GetIDField: string;
begin
  Result := 'TrainingEmployeeModuleStatusDetailsID'
end;

class function TTrainingEmployeeModuleStatusDetails.GetBusObjectTablename: string;
begin
  Result := 'tbltrainingemployeemodulestatusdetails';
end;

function TTrainingEmployeeModuleStatusDetails.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TTrainingEmployeeModuleStatusDetails.GettrainingemployeemoduleStatusID: Integer;
begin
  Result := GetIntegerField('trainingemployeemoduleStatusID');
end;

function TTrainingEmployeeModuleStatusDetails.GetTaskID: Integer;
begin
  Result := GetIntegerField('TaskID');
end;

function TTrainingEmployeeModuleStatusDetails.GetDone: Boolean;
begin
  Result := GetBooleanField('Done');
end;

function TTrainingEmployeeModuleStatusDetails.GetDoneon: TDateTime;
begin
  Result := GetDateTimeField('Doneon');
end;

procedure TTrainingEmployeeModuleStatusDetails.SettrainingemployeemoduleStatusID(const Value: Integer);
begin
  SetIntegerField('trainingemployeemoduleStatusID', Value);
end;

procedure TTrainingEmployeeModuleStatusDetails.SetTaskID(const Value: Integer);
begin
  SetIntegerField('TaskID', Value);
end;

procedure TTrainingEmployeeModuleStatusDetails.SetDone(const Value: Boolean);
begin
  SetBooleanField('Done', Value);
end;

procedure TTrainingEmployeeModuleStatusDetails.SetDoneon(const Value: TDateTime);
begin
  SetDateTimeField('Doneon', Value);
end;

procedure TTrainingEmployeeModules.CreateTaskrecords(const Sender: TBusObj; var Abort: Boolean);
begin
  CreateTaskrecords(ERPSetup, 'ERP Setup');
  CreateTaskrecords(DataImport, 'Data Import');
  CreateTaskrecords(BasicFeatures, 'Basic Features');
  CreateTaskrecords(Employee, 'Employee');
  CreateTaskrecords(Accounts, 'Accounts');
  CreateTaskrecords(Inventory_Basics, 'Inventory (Basics)');
  CreateTaskrecords(Purchase, 'Purchase');
  CreateTaskrecords(Sales, 'Sales');
  CreateTaskrecords(CustomerPayments, 'Customer Payments');
  CreateTaskrecords(SupplierPayments, 'Supplier Payments');
  CreateTaskrecords(Banking, 'Banking');
  CreateTaskrecords(Reports, 'Reports');
  CreateTaskrecords(Appointments, 'Appointments');
  CreateTaskrecords(General_Templates, 'General Templates');
  CreateTaskrecords(Utilities, 'Utilities');
  CreateTaskrecords(Inventory_Advanced, 'Inventory (Advanced)');
  CreateTaskrecords(Manufacturing, 'Manufacturing');
  CreateTaskrecords(FileMaintenance, 'File Maintenance');
  CreateTaskrecords(How_To, 'How To');
  CreateTaskrecords(Payroll, 'Payroll');
  CreateTaskrecords(CRM, 'CRM');
  CreateTaskrecords(Marketing, 'Marketing');
  CreateTaskrecords(budgets, 'Budgets');
  CreateTaskrecords(Purchase_FX, 'Purchase FX');
  CreateTaskrecords(Matrix, 'Matrix');
  CreateTaskrecords(Pos, 'Pos');
  CreateTaskrecords(Hire, 'Hire');
  CreateTaskrecords(Workshop, 'Workshop');
  CreateTaskrecords(FixedAssets, 'Fixed Assets');
  CreateTaskrecords(Delivery, 'Delivery');
  CreateTaskrecords(MoreTraining, 'More Training');
end;

function TTrainingEmployeeModules.ModuleSeqno(ModuleId: Integer): Integer;
begin
  Result := 0;
  if TrainingModules.Locate(TrainingModules.IDFieldName, ModuleId, []) then Result := TrainingModules.Seqno;
end;

function TTrainingEmployeeModules.ModuleId(const Modulename: string): Integer;
begin
  Result := 0;
  if TrainingModules.Locate('TrainingModuleName', Modulename, []) then Result := TrainingModules.Id;
end;

procedure TTrainingEmployeeModules.CreateTaskrecords(const ModuleSelected: Boolean; const Modulename: string);
var
  TrainingModuleTask: TTrainingModuleTask;
  TrainingEmployeeModuleStatus: TTrainingEmployeeModuleStatus;
begin
  DoStepProgressbar(Modulename);
  if (not(ModuleSelected)) or (not(IsModuleActive(Modulename))) then begin
    TrainingEmployeeModuleStatus := TTrainingEmployeeModuleStatus.Create(Self);
    try
      TrainingEmployeeModuleStatus.connection := Self.connection;
      TrainingEmployeeModuleStatus.LoadSelect('EmployeeId = ' + IntToStr(Self.EmployeeId) + ' and ModuleId = ' + IntToStr(ModuleId(Modulename)));
      TrainingEmployeeModuleStatus.DeleteAll;
    finally Freeandnil(TrainingEmployeeModuleStatus);
    end;
  end else begin
    TrainingModuleTask := TTrainingModuleTask.Create(Self);
    try
      TrainingModuleTask.connection := Self.connection;
      TrainingModuleTask.LoadSelect('TrainingModuleId =' + IntToStr(ModuleId(Modulename)));
      if TrainingModuleTask.count = 0 then Exit;
      TrainingEmployeeModuleStatus := TTrainingEmployeeModuleStatus.Create(Self);
      try
        TrainingEmployeeModuleStatus.connection := Self.connection;
        TrainingEmployeeModuleStatus.LoadSelect('TrainingID = ' + IntToStr(self.TrainingID) + ' and EmployeeId = ' + IntToStr(Self.EmployeeId) + ' and ModuleId = ' + IntToStr(ModuleId(Modulename)));
        if TrainingEmployeeModuleStatus.count = 0 then begin
          TrainingEmployeeModuleStatus.New;
          TrainingEmployeeModuleStatus.TrainingID := TrainingID;
          TrainingEmployeeModuleStatus.EmployeeId := Self.EmployeeId;
          TrainingEmployeeModuleStatus.EmployeeName := tcDataUtils.GetEmployeeName(Self.EmployeeId);
          TrainingEmployeeModuleStatus.ModuleId := ModuleId(Modulename);
          TrainingEmployeeModuleStatus.ModuleSeqno := ModuleSeqno(TrainingEmployeeModuleStatus.ModuleId);
          TrainingEmployeeModuleStatus.Modulename := Modulename;
          TrainingEmployeeModuleStatus.PostDB;
        end;
        TrainingModuleTask.first;
        while TrainingModuleTask.Eof = False do begin
          if TrainingEmployeeModuleStatus.TrainingEmployeeModuleStatusDetails.Locate('TaskID', TrainingModuleTask.Id, []) then
          else begin
            TrainingEmployeeModuleStatus.TrainingEmployeeModuleStatusDetails.New;
            TrainingEmployeeModuleStatus.TrainingEmployeeModuleStatusDetails.TaskID := TrainingModuleTask.Id;
            TrainingEmployeeModuleStatus.TrainingEmployeeModuleStatusDetails.Seqno := TrainingModuleTask.Seqno;
            TrainingEmployeeModuleStatus.TrainingEmployeeModuleStatusDetails.PostDB;
          end;
          TrainingModuleTask.next;
        end;
      finally Freeandnil(TrainingEmployeeModuleStatus);
      end;
    finally Freeandnil(TrainingModuleTask);
    end;
  end;
end;

function TTrainingEmployeeModuleStatusDetails.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  if assigned(Self.Owner) then
    if Self.Owner is TTrainingEmployeeModuleStatus then trainingemployeemoduleStatusID := TTrainingEmployeeModuleStatus(Self.Owner).Id;
end;

function TTrainingEmployeeModules.getTrainingModules: TTrainingModules;
begin
  if fTrainingModules = nil then begin
    fTrainingModules := TTrainingModules.Create(Self);
    fTrainingModules.connection := Self.connection;
    fTrainingModules.Load;
  end;
  Result := fTrainingModules;
end;

function TTrainingEmployeeModuleStatusDetails.getSeqno: Integer;
begin
  Result := GetIntegerField('Seqno');
end;

procedure TTrainingEmployeeModuleStatusDetails.setSeqno(const Value: Integer);
begin
  SetIntegerField('Seqno', Value);
end;

function TTrainingEmployeeModules.IsModuleAssigned(const fsModulename: string): Boolean;
begin
  Result := False;
  if not TrainingModules.Locate('TrainingModuleName', fsModulename, []) then Exit;
  if Dataset.findfield(TrainingModules.TEMFieldname) <> nil then Result := Dataset.FieldByname(TrainingModules.TEMFieldname).asBoolean;
end;

function TTrainingEmployeeModules.AnyModuleAssigned: Boolean;
begin
  Result :=
    BasicFeatures or
    Purchase_FX or
    ERPSetup or
    DataImport or
    Employee or
    Accounts or
    Inventory_Basics or
    FileMaintenance or
    Purchase or
    CRM or
    Marketing or
    Sales or
    Pos or
    CustomerPayments or
    SupplierPayments or
    Banking or
    Reports or
    General_Templates or
    How_To or
    Hire or
    Utilities or
    Inventory_Advanced or
    Manufacturing or
    Appointments or
    Payroll or
    FixedAssets or
    Workshop or
    budgets or
    Delivery or
    Matrix;
end;
{ TTrainingDays }

constructor TTrainingDays.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'TrainingDays';
  fSQL := 'SELECT * FROM tbltrainingdays';
  fSQLOrder := 'TrainingDate';
end;

destructor TTrainingDays.Destroy;
begin
  inherited;
end;

procedure TTrainingDays.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node, 'TrainingDate');
  SetBooleanPropertyFromNode(node, 'Active');
  SetDateTimePropertyFromNode(node, 'StartTime');
  SetDateTimePropertyFromNode(node, 'EndTime');
end;

procedure TTrainingDays.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'TrainingDate', TrainingDate);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'StartTime', StartTime);
  AddXMLNode(node, 'EndTime', EndTime);
end;

function TTrainingDays.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if TrainingId = 0 then begin
    AddResult(False, rssError, 0, 'Training ID should not be blank');
    Exit;
  end;
  if TrainingDate = 0 then begin
    AddResult(False, rssError, 0, 'Training Date should not be blank');
    Exit;
  end;
  if StartTime = 0 then begin
    AddResult(False, rssError, 0, 'Start Time should not be blank');
    Exit;
  end;
  if EndTime = 0 then begin
    AddResult(False, rssError, 0, 'End Time should not be blank');
    Exit;
  end;
  Result := True;
end;

function TTrainingDays.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TTrainingDays.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TTrainingDays.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if sysutils.SameText(Sender.FieldName, 'TrainingDate') then begin
    if TrainingDate <> 0 then begin
      StartTime := TrainingDate + TRaining.StartOfTheDay;
      EndTime := TrainingDate + TRaining.EndOftheDay;
      if EndTime < StartTime then
        EndTime := EndTime + 1;
    end;
  end;
end;

function TTrainingDays.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TTrainingDays.GetIDField: string;
begin
  Result := 'TrainingdayID'
end;

class function TTrainingDays.GetBusObjectTablename: string;
begin
  Result := 'tbltrainingdays';
end;

function TTrainingDays.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TTrainingDays.GetTrainingDate: TDate;
begin
  Result := GetDateTimeField('TrainingDate');
end;

function TTrainingDays.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TTrainingDays.GetStartTime: TDateTime;
begin
  Result := GetDateTimeField('StartTime');
end;

function TTrainingDays.GetEndTime: TDateTime;
begin
  Result := GetDateTimeField('EndTime');
end;

procedure TTrainingDays.SetTrainingDate(const Value: TDate);
begin
  SetDateTimeField('TrainingDate', Value);
end;

procedure TTrainingDays.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TTrainingDays.SetStartTime(const Value: TDateTime);
begin
  SetDateTimeField('StartTime', Value);
end;

procedure TTrainingDays.SetEndTime(const Value: TDateTime);
begin
  SetDateTimeField('EndTime', Value);
end;

//function TTrainingDays.getTrainingID: Integer;
//begin
//  Result := GetIntegerField('TrainingId');
//end;

//procedure TTrainingDays.setTrainingID(const Value: Integer);
//begin
//  SetIntegerField('TrainingId', Value)
//end;

function TTrainingDays.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;

  if assigned(Self.Owner) then
    if Self.Owner is TTraining then TrainingID := TTraining(Self.Owner).Id;
end;

(* function TTrainingDays.getTRaining: TTraining;
  begin
  if assigned(Self.owner) and (Self.Owner is TTraining) then result := TTraining(Self.Owner)
  else result := TTraining(getContainerComponent(TTRaining , 'TrainingId= ' +IntToStr(TRainingID)));
  end; *)

{ TTraining }

constructor TTraining.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'Training';
  fSQL := 'SELECT * FROM tbltraining';
end;

destructor TTraining.Destroy;
begin
  inherited;
end;

procedure TTraining.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'Description');
  SetDateTimePropertyFromNode(node, 'TrainingDate');
  SetPropertyFromNode(node, 'TotalHours');

end;

procedure TTraining.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Description', Description);
  AddXMLNode(node, 'TrainingDate', TrainingDate);
  AddXMLNode(node, 'TotalHours', TotalHours);
end;

function TTraining.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if TrainingDate = 0 then begin
    AddResult(False, rssError, 0, 'TrainingDate should not be blank');
    Exit;
  end;
  AllLinesValid := true;
  TrainingDay.PostDb;
  TrainingDay.IterateRecords(self.TrainingDayValidateCallback);
  if not AllLinesValid then
    exit;
  TrainingDays.PostDb;
  TrainingDays.IterateRecords(self.TrainingDaysValidateCallback);
  if not AllLinesValid then
    exit;
  TrainingEmployeeModules.PostDb;
  TrainingEmployeeModules.IterateRecords(self.TrainingEmployeeModulesValidateCallback);
  if not AllLinesValid then
    exit;
  TrainingEmployeeModuleStatus.PostDb;
  TrainingEmployeeModuleStatus.IterateRecords(self.TrainingEmployeeModuleStatusValidateCallback);
  if not AllLinesValid then
    exit;
  { NOTE TrainingModules does not need to be validated as it is not editable by users }
//  IterateRecords(self.TrainingModulesValidateCallback);
//  if not AllLinesValid then
//    exit;


  Result := True;
end;

function TTraining.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TTraining.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TTraining.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TTraining.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TTraining.GetIDField: string;
begin
  Result := 'TrainingID'

end;

class function TTraining.GetBusObjectTablename: string;
begin
  Result := 'tbltraining';
end;

function TTraining.DoAfterPost(Sender: TDatasetBusObj): Boolean;
var
  iempID: Integer;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
  if TrainingEmployeeModules.count = 0 then begin
    iempID := tcDataUtils.GetEmployeeId(ERPAdminEmployeeName);
    if iempID <> 0 then begin
      if not(TrainingEmployeeModules.locate('EmployeeId' , iempID , [])) then begin
        TrainingEmployeeModules.New;
        TrainingEmployeeModules.TrainingID := self.ID;
        TrainingEmployeeModules.EmployeeId := iempID;
        TrainingEmployeeModules.EmployeeName := ERPAdminEmployeeName;
        TrainingEmployeeModules.ERPSetup := True;
//        TrainingEmployeeModules.TemplateDesign := True;
        TrainingEmployeeModules.DataImport := True;
        TrainingEmployeeModules.PostDB;
      end;
    end;
  end;
end;

{ Property Functions }
function TTraining.GetDescription: string;
begin
  Result := GetStringField('Description');
end;

function TTraining.GetTotalTrainingDays: integer;
begin
  result := GetIntegerField('TotalTrainingDays');
end;

function TTraining.GetTrainingDate: TDateTime;
begin
  Result := GetDateTimeField('TrainingDate');
end;

procedure TTraining.SetDescription(const Value: string);
begin
  SetStringField('Description', Value);
end;

procedure TTraining.SetTotalTrainingDays(const Value: integer);
begin
  SetIntegerField('TotalTrainingDays',Value);
end;

procedure TTraining.SetTrainingDate(const Value: TDateTime);
begin
  SetDateTimeField('TrainingDate', Value);
end;

//function TTrainingEmployeeModules.getTrainingID: Integer;
//begin
//  Result := GetIntegerField('TrainingId');
//end;

//procedure TTrainingEmployeeModules.setTrainingID(const Value: Integer);
//begin
//  SetIntegerField('TrainingId', Value)
//end;

function TTraining.getTrainingDays: TTrainingDays;
begin
  Result := TTrainingDays(getContainerComponent(TTrainingDays, 'trainingID = ' + IntToStr(Id)));
end;

function TTraining.getTrainingEmployeeModules: TTrainingEmployeeModules;
begin
  Result := TTrainingEmployeeModules(getContainerComponent(TTrainingEmployeeModules, 'trainingID = ' + IntToStr(Id)));
end;

function TTraining.getTrainingEmployeeModuleStatus: TTrainingEmployeeModuleStatus;
begin
  Result := TTrainingEmployeeModuleStatus(getContainerComponent(TTrainingEmployeeModuleStatus, 'trainingID = ' + IntToStr(Id)));
end;

function TTraining.getTrainingModules: TTrainingModules;
begin
//  Result := TTrainingModules(getContainerComponent(TTrainingModules, 'trainingID = ' + IntToStr(Id)));
  Result := TTrainingModules(getContainerComponent(TTrainingModules, ''));
end;

function TTraining.getTrainingroster: TTrainingRoster;
begin
  Result := TTrainingRoster(getContainerComponent(TTrainingRoster, ' Type = ' + QuotedStr('Training') + ' and TrainingID = ' + IntToStr(Id) + ' and TrainingModuleId  in (Select TrainingModuleID from tblTrainingModules Where TrainingId =  ' +
    IntToStr(Id) + ')'));
end;

function TTraining.AutoSchedule: Boolean;
begin
  Result := False;
  if Trainingroster.count > 0 then begin
    SendEvent(BusObjEventCall, BusobjEventVal_EmptyTrainingroster, Self);
    if Trainingroster.count > 0 then begin
      Resultstatus.AddItem(False, rssWarning, 1, 'This Training is already started Scheduling. Its not possible to Auto Schedule');
      Exit;
    end;
  end;

  if not HasTRainingAssigned then begin
    Resultstatus.AddItem(False, rssWarning, 2, 'No Modules is Assigned to Any Employees For Training.  Nothing to Auto-Schedule.');
    Exit;
  end;
  if TrainingDays.count = 0 then begin
    Resultstatus.AddItem(False, rssWarning, 3, 'Please Select the Training Days.');
    Exit;
  end;
  Result := AutoScheduleFrom(0);
end;

function TTraining.AutoScheduleFrom(StartSchedulingFrom: TDateTime): Boolean;
begin
  AllAutoScheduled := True;
  AutoScheduled := True;
  TrainingDays.closeDB;
  TrainingDays.opendb; // to reorder the date
  TrainingDays.first;
  dt := TrainingDays.StartTime;
  TrainingDayId := TrainingDays.Id;
  ctr := 1;
  // ActiveTrainingModules.IterateRecords(DoAutoSchedule);
  TrainingDays.first;
  // ShedulingAt :=Dateof(TrainingDays.TrainingDate) + StartOfTheDay;

  TrainingHrsmultiplier := 1; // Round((CalcMinutesInADay  * TrainingDays.count)/(TotalHours*60),1);

  TrainingDaysDay(StartSchedulingFrom);
  try
    if fTrainingDaysDay.recordcount > 0 then fTrainingDaysDay.first;
    fTrainingDaysDay.first;
    TrainingDaysDayID := fTrainingDaysDay.FieldByname('ID').asInteger;
    ScheduledAt := fTrainingDaysDay.FieldByname('DAteFrom').asDateTime;
    ctr := 0;
    ActiveTrainingModules.Iteraterecords(DoAutoScheduleModule);
  finally
    if fTrainingDaysDay.Active then fTrainingDaysDay.close;
    Freeandnil(fTrainingDaysDay);
  end;
  Result := AutoScheduled;
  if not AllAutoScheduled then
      Resultstatus.AddItem(False, rssWarning, 0, 'Auto Schedule is Incomplete as Days Allocated For Training is not Enough for All Selected Employees/Modules.' + chr(13) + chr(13) +
      'This Could be Either Because Total Days Allocated is Less Than ' + IntToStr(DaysRequiredForTraining) + ' or Required Multiple Batches');
end;

procedure TTraining.TrainingDaysDay(StartSchedulingFrom: TDateTime);
var
  dt: TDate;
  dtt: TDateTime;
  dte: TDateTime;
begin
  fsTablename := CommonDbLib.GetUserTemporaryTableName('TrainingDaysDay');
  with CommonDbLib.TempMyScript do
    try
      SQL.add('Drop table if exists ' + fsTablename + ';');
      SQL.add('CREATE TABLE ' + fsTablename + ' (ID INT UNSIGNED AUTO_INCREMENT,  ' + ' DateFrom DATETIME,  ' + ' DAteTo DATETIME,  ' + ' PRIMARY KEY(ID), UNIQUE(ID));');
      Execute;
    finally free;
    end;
  fTrainingDaysDay := getNewDataset('Select * from ' + fsTablename, False);

//  with getNewDataset('Select ' + ' Addtime(DS.TRainingdate ,T.StartOfTheDay ) DayStart, ' +
//    ' Addtime(DS.TRainingdate ,d.tTimeFrom ) TimeFrom, ' +
//    ' Addtime(DS.TRainingdate ,d.ttimeto )  Timeto , ' +
//    ' Addtime(DS.TRainingdate ,T.EndOfTheDay ) DayEnd ' + ' FROM tblTraining T ' +
//    ' INNER join tbltrainingdays Ds on T.TrainingId = ds.TrainingId and not IsNUll(Ds.TrainingDate)' +
//    ' INNER join tbltrainingday D on d.TrainingId = T.TrainingID ' +
//    ' WHERE T.TrainingId =  ' + IntToStr(Id) +
//    ' ORDER BY TimeFrom ,timeto ', True) do
  with GetNewDataset('Select' +
    ' Convert(Addtime(DS.TRainingdate ,T.StartOfTheDay),DateTime) as DayStart,' +
    ' Convert(if (IsNull(D.tTimeFrom), DS.StartTime, Addtime(DS.TrainingDate, D.tTimeFrom)),DateTime) as TimeFrom,' +
    ' Convert(if (IsNull(D.tTimeTo), DS.EndTime, Addtime(DS.TrainingDate ,d.tTimeTo)),DateTime) as TimeTo,' +
    ' Convert(Addtime(DS.TRainingdate ,T.EndOfTheDay),DateTime) as DayEnd' +
    ' FROM tblTraining T' +
    ' left join tbltrainingdays DS on T.TrainingId = DS.TrainingId and not IsNUll(DS.TrainingDate) and DS.Active = "T"' +
    ' left join tbltrainingday D on D.TrainingId = T.TrainingID  and D.Active = "T"' +
    ' WHERE T.TrainingId = ' + IntToStr(Id) +
    ' ORDER BY TimeFrom, TimeTo') do
    try
      if recordcount > 0 then begin
        first;
        if (FieldByName('DayStart').AsDateTime = FieldByName('TimeFrom').AsDateTime) and
          (FieldByName('DayEnd').AsDateTime = FieldByName('TimeTo').AsDateTime) then begin
          while not EOF do begin
            fTrainingDaysDay.Append;
            fTrainingDaysDay.FieldByname('DateFrom').asDateTime := FieldByName('TimeFrom').AsDateTime;
            fTrainingDaysDay.FieldByname('DateTo').asDateTime := FieldByName('TimeTo').AsDateTime;
            fTrainingDaysDay.Post;
            Next;
          end;
        end
        else begin

          dt := DateOf(FieldByname('TimeFrom').asDateTime);
          dtt := FieldByname('DayStart').asDateTime;
          while Eof = False do begin
            if (dtt < StartSchedulingFrom) and (StartSchedulingFrom <= FieldByname('TimeFrom').asDateTime) then
              dtt := StartSchedulingFrom;

            if dtt >= StartSchedulingFrom then begin
              fTrainingDaysDay.Append;
              fTrainingDaysDay.FieldByname('DateFrom').asDateTime := dtt;
              fTrainingDaysDay.FieldByname('DateTo').asDateTime := FieldByname('TimeFrom').asDateTime;
              fTrainingDaysDay.Post;
            end;
            dtt := FieldByname('TimeTo').asDateTime;
            dte := FieldByname('DayEnd').asDateTime;
            next;
            if (Eof) or (dt <> DateOf(FieldByname('DayStart').asDateTime)) then begin
              if (dtt < StartSchedulingFrom) and (StartSchedulingFrom <= dte) then dtt := StartSchedulingFrom;
              if dtt >= StartSchedulingFrom then begin
                fTrainingDaysDay.Append;
                fTrainingDaysDay.FieldByname('DateFrom').asDateTime := dtt;
                fTrainingDaysDay.FieldByname('DateTo').asDateTime := dte;
                fTrainingDaysDay.Post;
              end;
              dt := DateOf(FieldByname('TimeFrom').asDateTime);
              dtt := FieldByname('DayStart').asDateTime;
            end;
          end;
        end;
      end;
    finally
      if Active then close;
      free;
    end;
end;

procedure TTraining.TrainingDaysValidateCallback(const Sender: TBusObj;
  var Abort: Boolean);
begin
  if not TTrainingDays(Sender).ValidateData then
  begin
    AllLinesValid:= false;
    Abort:= true;
  end;
end;

procedure TTraining.TrainingDayValidateCallback(const Sender: TBusObj;
  var Abort: Boolean);
begin
  if not TTrainingDay(Sender).ValidateData then
  begin
    AllLinesValid:= false;
    Abort:= true;
  end;
end;

procedure TTraining.TrainingEmployeeModuleStatusValidateCallback(
  const Sender: TBusObj; var Abort: Boolean);
begin
  if not TTrainingEmployeeModuleStatus(Sender).ValidateData then
  begin
    AllLinesValid:= false;
    Abort:= true;
  end;
end;

procedure TTraining.TrainingEmployeeModulesValidateCallback(
  const Sender: TBusObj; var Abort: Boolean);
begin
  if not TTrainingEmployeeModules(Sender).ValidateData then
  begin
    AllLinesValid:= false;
    Abort:= true;
  end;
end;

//procedure TTraining.TrainingModulesValidateCallback(const Sender: TBusObj;
//  var Abort: Boolean);
//begin
//  if not TTrainingModules(Sender).ValidateData then
//  begin
//    AllLinesValid:= false;
//    Abort:= true;
//  end;
//end;

procedure TTraining.NextSlot;
begin
  TrainingDaysDayID := fTrainingDaysDay.FieldByname('ID').asInteger;
  SchedulingCtr := 1;
  ScheduledAt := ScheduleFrom;
end;

function TTraining.MinutesAlreadyScheduled(xTRainingModuleId, xEmployeeID: Integer): Integer;
begin
  Result := 0;
  with getNewDataset('SELECT * FROM tblroster ' + ' WHERE TrainingID = ' + IntToStr(Id) + ' and TrainingModuleId = ' + IntToStr(xTRainingModuleId) + ' AND EmployeeID = ' + IntToStr(xEmployeeID), True) do
    try
      if recordcount = 0 then Exit;
      first;
      while Eof = False do begin
        Result := Result + MinutesBetween(FieldByname('Starttime').asDateTime, IncSecond(FieldByname('endtime').asDateTime, 1));
        next;
      end;
    finally
      if Active then close;
      free;
    end;
end;

procedure TTraining.DoAutoScheduleModule(const Sender: TBusObj; var Abort: Boolean);
var
  minutestoSchedule: Integer;
  mints: Integer;
  AlreadyScheduled: Integer;
begin
  if Sender is TTrainingModules then begin
    SchedulingHours := trunc(TTrainingModules(Sender).TrainingHrs * TrainingHrsmultiplier);
    if SchedulingHours - TTrainingModules(Sender).TrainingHrs * TrainingHrsmultiplier = 0 then
    else if SchedulingHours - TTrainingModules(Sender).TrainingHrs * TrainingHrsmultiplier < 0.5 then SchedulingHours := SchedulingHours + 0.5
    else SchedulingHours := SchedulingHours + 1;

    SchedulingTrainingModuleID := TTrainingModules(Sender).Id;
    SchedulingCtr := 0;
    TotaltoSchedule := TTrainingModules(Sender).TrainingEmployeeModules.count;
    ScheduleFrom := ScheduledAt;
    TTrainingModules(Sender).TrainingEmployeeModules.Iteraterecords(DoAutoScheduleModule);
    if ScheduleFrom = 0 then Abort := True
    else ScheduledAt := ScheduleFrom;

    TrainingDaysDayID := fTrainingDaysDay.FieldByname('ID').asInteger;

  end
  else if Sender is TTrainingEmployeeModules then begin
    SchedulingCtr := SchedulingCtr + 1;
    if (SchedulingCtr > 3) (* and (TotaltoSchedule>1) *) then begin
      NextSlot;
    end
    else if (SchedulingCtr = 3) and (TotaltoSchedule = 2) then begin
      NextSlot;
    end;
    TotaltoSchedule := TotaltoSchedule - 1;
    AlreadyScheduled := MinutesAlreadyScheduled(SchedulingTrainingModuleID, TTrainingEmployeeModules(Sender).EmployeeId);

    minutestoSchedule := trunc(SchedulingHours * 60) - AlreadyScheduled;
    fTrainingDaysDay.Locate('ID', TrainingDaysDayID, []);
    ScheduleFrom := ScheduledAt;
    while (minutestoSchedule > 0) and (fTrainingDaysDay.Eof = False) do begin
      mints := MinutesBetween(ScheduleFrom, IncSecond(fTrainingDaysDay.FieldByname('DateTo').asDateTime, 1));
      if mints <= minutestoSchedule then
      else mints := minutestoSchedule;
      if mints > 0 then begin

        Trainingroster.connection.BeginNestedTransaction;
        try
          Trainingroster.New;
          ctr := ctr + 1;
          TrainingRoster.TrainingID := self.ID;
          Trainingroster.PlannerID := Appenv.DefaultClass.DefaultClassName + FormatDateTime('yy:m:d:h:n:s:z', now()) + IntToStr(ctr);
          Trainingroster.RosterType := 'Training';
          Trainingroster.EmployeeId := TTrainingEmployeeModules(Sender).EmployeeId;
          Trainingroster.ClassID := Appenv.DefaultClass.ClassID;
          Trainingroster.Notes := '';
          Trainingroster.date := DateOf(ScheduleFrom);
          Trainingroster.StartTime := ScheduleFrom;
          Trainingroster.EndTime := incMinute(ScheduleFrom, mints);
          ScheduleFrom := Trainingroster.EndTime;
          Trainingroster.Hours := Round(mints / 60,2);
          Trainingroster.TypeCatagory := 'Training';
          Trainingroster.TrainingModuleId := SchedulingTrainingModuleID;
          Trainingroster.PostDB;
  //        if not TrainingRoster.Save then begin
  //          Abort := true;
  //          Trainingroster.connection.RollbackNestedTransaction;
  //          exit;
  //        end;
          Trainingroster.connection.CommitNestedTransaction;
        except
          on E: Exception do begin
            Trainingroster.connection.RollbackNestedTransaction;
            AutoScheduled := False;
          end;
        end;
      end;
      minutestoSchedule := minutestoSchedule - mints;
      if minutestoSchedule > 0 then begin
        fTrainingDaysDay.next;
        if fTrainingDaysDay.Eof then begin
          ScheduleFrom := 0;
          AllAutoScheduled := False;
        end
        else ScheduleFrom := fTrainingDaysDay.FieldByname('DAteFrom').asDateTime;
      end;
    end;
  end;
end;
(* procedure TTraining.DoAutoSchedule(const Sender: TBusObj;var Abort: boolean);
  var
  totaltime:Integer;
  begin
  ctr:= ctr+1;
  if (Sender is TTrainingModules) then begin
  try
  totalTime := trunc(TTrainingModules(Sender).TrainingHrs*60);
  while totaltime >0 do begin
  timetoallocate :=Availabletime(totaltime);
  if timetoallocate = 0 then begin
  abort := true;
  exit;
  end;
  SchedulingTrainingModuleID :=TTrainingModules(Sender).id;
  TTrainingModules(Sender).TrainingEmployeeModules.iteraterecords(DoAutoSchedule);
  dt:= incminute(dt ,timetoallocate);
  Totaltime:= totaltime -  timetoallocate;
  end;
  Except
  on E:Exception do begin
  AutoScheduled := False;
  end;
  end;
  end else if (Sender is TTrainingEmployeeModules) then begin
  TrainingRoster.Connection.BeginNestedTransaction;
  try
  TrainingRoster.New;
  TrainingRoster.PlannerID := AppEnv.DefaultClass.DefaultClassName +
  FormatDateTime('yy:m:d:h:n:s:z:', Now()) +
  IntToStr(ctr);
  TrainingRoster.RosterType := 'Training';
  TrainingRoster.EmployeeID := TTrainingEmployeeModules(Sender).EmployeeId;
  TrainingRoster.ClassID := Appenv.DefaultClass.ClassID;
  TrainingRoster.Notes := '';
  TrainingRoster.Date := dt;
  TrainingRoster.StartTime :=dt;
  TrainingRoster.EndTime := incMinute(dt,timetoallocate);
  TrainingRoster.Hours :=timetoallocate/60;
  TrainingRoster.TypeCatagory := 'Training';
  TrainingRoster.TrainingModuleId :=schedulingTrainingModuleID;
  TrainingRoster.PostDB;
  TrainingRoster.Connection.CommitNestedTransaction;
  Except
  on E:Exception do begin
  TrainingRoster.Connection.RollbackNestedTransaction;
  AutoScheduled := False;
  end;
  end;
  end;
  end; *)

(* function TTraining.Availabletime(timerequired: Integer): Integer;
  var
  x:Integer;
  begin
  REsult := 0;
  x := MinutesBetween(dt , IncSecond(Trainingdays.EndTime,1));
  if x=0 then begin
  Trainingdays.Next;
  if Trainingdays.eof then Exit;
  dt :=Trainingdays.StartTime;
  x := MinutesBetween(dt , IncSecond(Trainingdays.EndTime,1));
  end;

  if x>  timerequired then begin
  result := timerequired;
  end else begin
  result := x;
  end;

  end; *)

function TTraining.getActiveTrainingModules: TTrainingModules;
begin
//  Result := TTrainingModules(getContainerComponent(TTrainingModules, 'trainingID = ' + IntToStr(Id) + ' and Active ="T"'));
  Result := TTrainingModules(getContainerComponent(TTrainingModules, 'Active ="T"'));
end;

function TTrainingEmployeeModules.IsModuleActive(const Modulename: string): Boolean;
begin
  Result := False;
  if TrainingModules.Locate('TrainingModuleName', Modulename, []) then Result := TrainingModules.Active;

end;

function TTraining.getTrainingDay: TTrainingDay;
begin
  Result := TTrainingDay(getContainerComponent(TTrainingDay, 'trainingid = ' + IntToStr(Id)));
end;

function TTraining.getTotalHours: Double;
begin
  Result := getFloatfield('TotalHours');
end;

function TTraining.getTotalHoursforActivemodeuls: Double;
begin
  fdTotalHoursforActivemodeuls:=0;
  TrainingModules.IterateRecords(TotalHoursforActivemodeulsCallback);
  result:= fdTotalHoursforActivemodeuls;
end;
procedure TTraining.TotalHoursforActivemodeulsCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TTrainingModules ) then exit;
  if TTrainingModules(Sender).active then
    fdTotalHoursforActivemodeuls := fdTotalHoursforActivemodeuls + TTrainingModules(Sender).TrainingHrs;
end;
procedure TTraining.setTotalHours(const Value: Double);
begin
  SetFloatfield('TotalHours', Value);
end;

function TTraining.DoCalcFields(Sender: TDatasetBusObj): Boolean;
var
  x: Integer;
begin
  Result := inherited DoCalcFields(Sender);
  if not Result then Exit;
  if Id=0 then exit;
  x := CalcMinutesInADay;
  MinutesInADay := x;
  HoursInaDay := minToHours(x);
end;

function TTraining.CalcMinutesInADay: Integer;
var
  x: Integer;
  dt1, dt2: TDateTime;
begin
  dt1:= Date + StartOfTheDay;
  dt2:= Date + EndOfTheDay;
  if dt2 < dt1 then
    dt2 := dt2 + 1;

//  Result := MinutesBetween(StartOfTheDay, IncSecond(EndOftheDay, 1) (* appenv.CompanyPrefs.StartOfDay ,appenv.CompanyPrefs.EndOfDay *) );
  Result := MinutesBetween(dt1, IncSecond(dt2, 1) (* appenv.CompanyPrefs.StartOfDay ,appenv.CompanyPrefs.EndOfDay *) );
  x := totalBreak;
  Result := (Result - x);
end;

procedure TTraining.calctotalBreak(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TTrainingDay) then Exit;
  if TTrainingDay(Sender).Active then
    fitotalBreak := fitotalBreak + MinutesBetween(TTrainingDay(Sender).tTimeFrom, IncSecond(TTrainingDay(Sender).tTimeto, 1));
end;

function TTraining.gettotalBreak: Integer;
begin
  fitotalBreak := 0;
  TrainingDay.Iteraterecords(calctotalBreak);
  Result := fitotalBreak;
end;

procedure TTraining.setMinutesInADay(const Value: Integer);
begin
  SetIntegerField('MinutesInADay', Value);
end;

function TTraining.getHoursInaDay: string;
begin
  Result := GetStringField('HoursInaDay');
end;

procedure TTraining.setHoursInaDay(const Value: string);
begin
  SetStringField('HoursInaDay', Value);
end;

function TTraining.DaysRequiredForTraining: Integer;
var
  days, r: Integer;
begin
  if TotalTrainingDays > 0 then begin
    days := TotalTrainingDays;

  end
  else begin
    r := CalcMinutesInADay;
    days := trunc(TotalHours / (CalcMinutesInADay / 60));
    if days < TotalHours / (r / 60) then days := days + 1;
  end;
  Result := days;

end;

function TTraining.Daysplan: string;
var
  days: Integer;
begin
  days := DaysRequiredForTraining;
  Result := replacestr(ReplicateStr('5+', trunc(days / 5)) + IntToStr(days - trunc(days / 5) * 5), '+0', '');
end;

function TTraining.getStartOfTheDay: TTime;
begin
  Result := GetDateTimeField('StartOfTheDay');
end;

procedure TTraining.setStartOfTheDay(const Value: TTime);
begin
  SetDateTimeField('StartOfTheDay', Value);
end;

function TTraining.getEndOftheDay: TTime;
begin
  Result := GetDateTimeField('EndOftheDay');
end;

procedure TTraining.setEndOftheDay(const Value: TTime);
begin
  SetDateTimeField('EndOftheDay', Value);
end;

function TTraining.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  StartOfTheDay := Appenv.CompanyPrefs.StartOfDay;
  EndOftheDay := Appenv.CompanyPrefs.endOfDay;
//  with getNewDataset('Select Sum(TrainingHrs) as TrainingHrs from tbltrainingmodules where trainingId = ' + IntToStr(Id), True) do
  with getNewDataset('Select Sum(TrainingHrs) as TrainingHrs from tbltrainingmodules', True) do
    try TotalHours := FieldByname('TrainingHrs').asFloat;
    finally
      if Active then close;
      free;
    end;
end;

procedure TTraining.AutoSelectDays(Datefrom: TDateTime);
var
  days: Integer;
  x, r: Integer;
begin
  x := 0;
  r := CalcMinutesInADay;
  Setlength(AutoSelectDates, x);
  if TotalTrainingDays > 0 then begin
    days := TotalTrainingDays;
  end
  else begin
    days := trunc(TotalHours / (r / 60));
    if days < TotalHours / (r / 60) then days := days + 1;
  end;
  while days > 0 do begin
    if (DayOfTheWeek(Datefrom) = day1) or (DayOfTheWeek(Datefrom) = day2) or (DayOfTheWeek(Datefrom) = day3)  or (DayOfTheWeek(Datefrom) = day4)  or (DayOfTheWeek(Datefrom) = day5) then begin
      x := x + 1;
      Setlength(AutoSelectDates, x);
      AutoSelectDates[ high(AutoSelectDates)] := Datefrom;
      days := days - 1;
    end;
    Datefrom := incday(Datefrom, 1);
  end;
end;

{ TTrainingDay }
constructor TTrainingDay.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'TrainingDay';
  fSQL := 'SELECT * FROM tbltrainingday';
end;

destructor TTrainingDay.Destroy;
begin
  inherited;
end;

procedure TTrainingDay.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'Description');
  SetDateTimePropertyFromNode(node, 'TimeFrom');
  SetDateTimePropertyFromNode(node, 'TimeTo');
  SetDateTimePropertyFromNode(node, 'tTimeFrom');
  SetDateTimePropertyFromNode(node, 'tTimeto');
  SetBooleanPropertyFromNode(node, 'Active');
end;

procedure TTrainingDay.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Description', Description);
  AddXMLNode(node, 'TimeFrom', TimeFrom);
  AddXMLNode(node, 'TimeTo', TimeTo);
  AddXMLNode(node, 'tTimeFrom', tTimeFrom);
  AddXMLNode(node, 'tTimeto', tTimeto);
  AddXMLNode(node, 'Active', Active);
end;

function TTrainingDay.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if tTimeFrom = 0 then begin
    AddResult(False, rssError, 0, 'TimeFrom should not be blank');
    Exit;
  end;
  if Description = '' then begin
    AddResult(False, rssError, 0, 'Description should not be blank');
    Exit;
  end;
  if TrainingID = 0 then begin
    AddResult(False, rssError, 0, 'Training ID should not be blank');
    Exit;
  end;
  if tTimeto = 0 then begin
    AddResult(False, rssError, 0, 'TimeTo should not be blank');
    Exit;
  end;
  if not IsUnique(Id, '((TTimeFrom<=' + QuotedStr(FormatDateTime('hh:nn:ss', tTimeFrom)) + ' and tTimeTo>=' + QuotedStr(FormatDateTime('hh:nn:ss', tTimeFrom)) + ' ) ' + ' or (TTimeFrom<=' +
    QuotedStr(FormatDateTime('hh:nn:ss', tTimeto)) + ' and tTimeTo>=' + QuotedStr(FormatDateTime('hh:nn:ss', tTimeto)) + ' ) ' + ' or (TTimeFrom>=' + QuotedStr(FormatDateTime('hh:nn:ss', tTimeFrom)) +
    ' and tTimeTo<=' + QuotedStr(FormatDateTime('hh:nn:ss', tTimeto)) + ' )) and TrainingID = ' + IntToStr(TrainingID)) then begin
    AddResult(False, rssWarning, 0, 'Record Already Exists within this Time');
    Exit;
  end;
  Result := True;
end;

function TTrainingDay.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TTrainingDay.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TTrainingDay.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
  inherited;
  if sysutils.SameText(Sender.FieldName, 'timefrom') then begin
    tTimeFrom := ValidStrToTime(Sender.asString);
    if (tTimeto = 0) or (tTimeto < tTimeFrom) then begin
      TimeTo := FormatDateTime('HH:nn:ss AM/PM', incMinute(tTimeFrom, 30));
      DoFieldOnChange(Dataset.findfield('timeTo'));
    end;
  end
  else if sysutils.SameText(Sender.FieldName, 'timeto') then begin
    tTimeto := ValidStrToTime(Sender.asString);
  end;
end;

function TTrainingDay.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TTrainingDay.GetIDField: string;
begin
  Result := 'ID'
end;

class function TTrainingDay.GetBusObjectTablename: string;
begin
  Result := 'tbltrainingday';
end;

function TTrainingDay.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
  SendEvent(BusObjEvent_Change, BusObjEventVal_TotalHours, Self);
end;

{ Property Functions }
function TTrainingDay.GetDescription: string;
begin
  Result := GetStringField('Description');
end;

function TTrainingDay.GetTimeFrom: string;
begin
  Result := GetStringField('TimeFrom');
end;

function TTrainingDay.GetTimeTo: string;
begin
  Result := GetStringField('TimeTo');
end;

function TTrainingDay.GettTimeFrom: TDateTime;
begin
  Result := GetDateTimeField('tTimeFrom');
end;

function TTrainingDay.GettTimeto: TDateTime;
begin
  Result := GetDateTimeField('tTimeto');
end;

function TTrainingDay.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

procedure TTrainingDay.SetDescription(const Value: string);
begin
  SetStringField('Description', Value);
end;

procedure TTrainingDay.SetTimeFrom(const Value: string);
begin
  SetStringField('TimeFrom', Value);
end;

procedure TTrainingDay.SetTimeTo(const Value: string);
begin
  SetStringField('TimeTo', Value);
end;

procedure TTrainingDay.SettTimeFrom(const Value: TDateTime);
begin
  SetDateTimeField('tTimeFrom', Value);
end;

procedure TTrainingDay.SettTimeto(const Value: TDateTime);
begin
  SetDateTimeField('tTimeto', Value);
end;

procedure TTrainingDay.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

//function TTrainingDay.getTrainingID: Integer;
//begin
//  Result := GetIntegerField('TrainingID');
//end;

//procedure TTrainingDay.setTrainingID(const Value: Integer);
//begin
//  SetIntegerField('TrainingID', Value);
//end;

function TTrainingDay.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;

  if assigned(Self.Owner) then
    if Self.Owner is TTraining then begin
      TrainingID := TTraining(Self.Owner).Id;
      TimeFrom := FormatDateTime('HH:nn:ss AM/PM', TRaining.StartOfTheDay (* appenv.CompanyPrefs.StartOfDay *) );
    end;
end;

function TTrainingDay.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not Result then Exit;
  if (Description = '') then begin
    CancelDB;
    Abort;
  end;
  //  if not ValidateData then begin
//    Abort;
//  end;
end;

{ TTrainingbase }
function TTrainingBase.getTrainingID: Integer;
begin
  Result := GetIntegerField('TrainingId');
end;

procedure TTrainingBase.setTrainingID(const Value: Integer);
begin
  SetIntegerField('TrainingId', Value)
end;

function TTrainingBase.getTRaining: TTraining;
var
  obj: TComponent;
begin
  Result := nil;
  obj := Self.Owner;
  while (obj <> nil) and (obj is TBusObj) do begin
    if obj is TTraining then begin
      Result := TTraining(obj);
      break;
    end
    else obj := obj.Owner;
  end;
  if assigned(Result) then Exit
  else Result := TTraining(getContainerComponent(TTraining, 'TrainingId= ' + IntToStr(TrainingID)));
end;

{ TTrainingRoster }

function TTrainingRoster.GetTrainingID: integer;
begin
  result := GetIntegerField('TrainingID');
end;

procedure TTrainingRoster.SetTrainingID(const Value: integer);
begin
  SetIntegerField('TrainingID', Value);
end;

function TTrainingRoster.ValidateData: Boolean;
begin
  result := inherited;
  if not result then exit;
  result := false;
  if self.TrainingModuleID = 0 then begin
    AddResult(false, rssWarning, 0, 'Training Module ID is 0');
    exit;
  end;
  if self.TrainingID = 0 then begin
    AddResult(false, rssWarning, 0, 'Training ID is 0');
    exit;
  end;
  result := true;
end;

initialization

RegisterClass(TTrainingRoster);
RegisterClass(TTrainingDay);
RegisterClass(TTraining);
RegisterClass(TTrainingDays);
RegisterClass(TTrainingEmployeeModuleStatusDetails);
RegisterClass(TTrainingEmployeeModuleStatus);
RegisterClass(TTrainingModuleTask);
RegisterClass(TTrainingEmployeeModules);
RegisterClass(TTrainingModules);

end.
