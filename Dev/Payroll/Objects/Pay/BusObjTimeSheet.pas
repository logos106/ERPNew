                              unit BusObjTimeSheet;

{ Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  14/10/05  1.00.01 AL   Added TTimeSheet business object.
  19/10/05  1.00.02 AL   Moved most logic from frmTimeSheet to TimeSheet
  17/11/05  1.00.03 AL   Fixed Bug with Employees (unknown employees were ading to tblemployees table before)
  12/11/05  1.00.04 AL   Fixed Bug with EmployeeID (GetEmployee)
  14/12/05  1.00.05 Al   Overriden the New method of the object
  15/08/06  1.00.06 BJ   Dataset.. procedures are changed to normal private procedures , the
  descendants are supposed to override the Do... procedures
}

interface

Uses TypesLib,
  BusObjBase, DB, Classes, BusObjEmployeeDetails, BusObjClient, BusObjPayRate,
  XMLDoc, XMLIntf, BusObjSales;

type
  //TTimesheetEntry = Class;
  TTimesheetEntryDetails = Class;

  TTimesheetDetails = class(TMSBusObj)
  private
    function GetTimesheetId                     : Integer   ;
    function GetTimeSheetEntryID                : Integer   ;
    function GetCompany_ID                      : Integer   ;
    function GetCompany                         : string    ;
    function GetWorker_ID                       : Integer   ;
    function GetWorker                          : string    ;
    function GetDept_ID                         : Integer   ;
    function GetDept                            : string    ;
    function GetOrg                             : string    ;
    function GetJob_Number                      : string    ;
    function GetJob_Name                        : string    ;
    function GetPay_Component                   : string    ;
    function GetRate                            : Double    ;
    function GetRate_Number                     : Double    ;
    function GetHours                           : Double    ;
    function GetUnits                           : Integer   ;
    function GetLine_Date                       : TDateTime ;
    function GetAmount                          : Double    ;
    function GetCheck_Seq_Number                : Integer   ;
    function GetOverride_State                  : string    ;
    function GetOverride_Local                  : string    ;
    function GetOverride_Local_Jurisdiction     : string    ;
    function GetLabor_Override                  : string    ;
    function GetCheck_Template                  : string    ;
    function GetOutput_Type                     : Integer   ;
    function GetNet_Pay                         : Double    ;
    function GetCheck_Number                    : Integer   ;
    function GetFIT_Amt                         : Double    ;
    function GetSS_Amt                          : Double    ;
    function GetMedicare_Amt                    : Double    ;
    function GetFed_Backup_Withholding_Amt      : Double    ;
    function GetState_Tax_Jurisdiction          : string    ;
    function GetSIT_Amount                      : Double    ;
    function GetSDI_Amt                         : Double    ;
    function GetFam_Leave                       : Double    ;
    function GetMed_Leave                       : Double    ;
    function GetSUI_Amt                         : Double    ;
    function GetState_Misc_Amt                  : Double    ;
    function GetState_Surcharge_Amt             : Double    ;
    function GetState_WC_Amt                    : Double    ;
    function GetState_Transit_Tax               : Double    ;
    function GetState_Backup_Withholding_Amt    : Double    ;
    function GetState_Allocation_Percent        : Double    ;
    function GetLocal_Tax_Jurisdiction          : string    ;
    function GetLocal_Tax_Name                  : string    ;
    function GetLocal_Amt                       : Double    ;
    function GetLocal_Allocation_Percent        : Double    ;
    Function getPayChexsynched                  : Boolean   ;
    procedure SetTimesheetId                     (const Value: Integer   );
    procedure SetTimeSheetEntryID                (const Value: Integer   );
    procedure SetCompany_ID                      (const Value: Integer   );
    procedure SetCompany                         (const Value: string    );
    procedure SetWorker_ID                       (const Value: Integer   );
    procedure SetWorker                          (const Value: string    );
    procedure SetDept_ID                         (const Value: Integer   );
    procedure SetDept                            (const Value: string    );
    procedure SetOrg                             (const Value: string    );
    procedure SetJob_Number                      (const Value: string    );
    procedure SetJob_Name                        (const Value: string    );
    procedure SetPay_Component                   (const Value: string    );
    procedure SetRate                            (const Value: Double    );
    procedure SetRate_Number                     (const Value: Double    );
    procedure SetHours                           (const Value: Double    );
    procedure SetUnits                           (const Value: Integer   );
    procedure SetLine_Date                       (const Value: TDateTime );
    procedure SetAmount                          (const Value: Double    );
    procedure SetCheck_Seq_Number                (const Value: Integer   );
    procedure SetOverride_State                  (const Value: string    );
    procedure SetOverride_Local                  (const Value: string    );
    procedure SetOverride_Local_Jurisdiction     (const Value: string    );
    procedure SetLabor_Override                  (const Value: string    );
    procedure SetCheck_Template                  (const Value: string    );
    procedure SetOutput_Type                     (const Value: Integer   );
    procedure SetNet_Pay                         (const Value: Double    );
    procedure SetCheck_Number                    (const Value: Integer   );
    procedure SetFIT_Amt                         (const Value: Double    );
    procedure SetSS_Amt                          (const Value: Double    );
    procedure SetMedicare_Amt                    (const Value: Double    );
    procedure SetFed_Backup_Withholding_Amt      (const Value: Double    );
    procedure SetState_Tax_Jurisdiction          (const Value: string    );
    procedure SetSIT_Amount                      (const Value: Double    );
    procedure SetSDI_Amt                         (const Value: Double    );
    procedure SetFam_Leave                       (const Value: Double    );
    procedure SetMed_Leave                       (const Value: Double    );
    procedure SetSUI_Amt                         (const Value: Double    );
    procedure SetState_Misc_Amt                  (const Value: Double    );
    procedure SetState_Surcharge_Amt             (const Value: Double    );
    procedure SetState_WC_Amt                    (const Value: Double    );
    procedure SetState_Transit_Tax               (const Value: Double    );
    procedure SetState_Backup_Withholding_Amt    (const Value: Double    );
    procedure SetState_Allocation_Percent        (const Value: Double    );
    procedure SetLocal_Tax_Jurisdiction          (const Value: string    );
    procedure SetLocal_Tax_Name                  (const Value: string    );
    procedure SetLocal_Amt                       (const Value: Double    );
    procedure SetLocal_Allocation_Percent        (const Value: Double    );
    Procedure SetPayChexsynched                  (Const Value: Boolean   );
    function getTimeSheetEntry: TTimesheetEntryDetails;
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
    Property TimeSheetEntry : TTimesheetEntryDetails read getTimeSheetEntry;
    property TimesheetId                      :Integer     read GetTimesheetId                    write SetTimesheetId                 ;
    property TimeSheetEntryID                 :Integer     read GetTimeSheetEntryID               write SetTimeSheetEntryID            ;
    property Company_ID                       :Integer     read GetCompany_ID                     write SetCompany_ID                  ;
    property Worker_ID                        :Integer     read GetWorker_ID                      write SetWorker_ID                   ;
    property Dept_ID                          :Integer     read GetDept_ID                        write SetDept_ID                   ;
  published
    property Company                          :string      read GetCompany                        write SetCompany                     ;
    property Worker                           :string      read GetWorker                         write SetWorker                      ;
    property Dept                             :string      read GetDept                           write SetDept                      ;
    property Org                              :string      read GetOrg                            write SetOrg                         ;
    property Job_Number                       :string      read GetJob_Number                     write SetJob_Number                  ;
    property Job_Name                         :string      read GetJob_Name                       write SetJob_Name                    ;
    property Pay_Component                    :string      read GetPay_Component                  write SetPay_Component               ;
    property Rate                             :Double      read GetRate                           write SetRate                        ;
    property Rate_Number                      :Double      read GetRate_Number                    write SetRate_Number                 ;
    property Hours                            :Double      read GetHours                          write SetHours                       ;
    property Units                            :Integer     read GetUnits                          write SetUnits                       ;
    property Line_Date                        :TDateTime   read GetLine_Date                      write SetLine_Date                   ;
    property Amount                           :Double      read GetAmount                         write SetAmount                      ;
    property Check_Seq_Number                 :Integer     read GetCheck_Seq_Number               write SetCheck_Seq_Number            ;
    property Override_State                   :string      read GetOverride_State                 write SetOverride_State              ;
    property Override_Local                   :string      read GetOverride_Local                 write SetOverride_Local              ;
    property Override_Local_Jurisdiction      :string      read GetOverride_Local_Jurisdiction    write SetOverride_Local_Jurisdiction ;
    property Labor_Override                   :string      read GetLabor_Override                 write SetLabor_Override              ;
    property Check_Template                   :string      read GetCheck_Template                 write SetCheck_Template              ;
    property Output_Type                      :Integer     read GetOutput_Type                    write SetOutput_Type                 ;
    property Net_Pay                          :Double      read GetNet_Pay                        write SetNet_Pay                     ;
    property Check_Number                     :Integer     read GetCheck_Number                   write SetCheck_Number                ;
    property FIT_Amt                          :Double      read GetFIT_Amt                        write SetFIT_Amt                     ;
    property SS_Amt                           :Double      read GetSS_Amt                         write SetSS_Amt                      ;
    property Medicare_Amt                     :Double      read GetMedicare_Amt                   write SetMedicare_Amt                ;
    property Fed_Backup_Withholding_Amt       :Double      read GetFed_Backup_Withholding_Amt     write SetFed_Backup_Withholding_Amt  ;
    property State_Tax_Jurisdiction           :string      read GetState_Tax_Jurisdiction         write SetState_Tax_Jurisdiction      ;
    property SIT_Amount                       :Double      read GetSIT_Amount                     write SetSIT_Amount                  ;
    property SDI_Amt                          :Double      read GetSDI_Amt                        write SetSDI_Amt                     ;
    property Fam_Leave                        :Double      read GetFam_Leave                      write SetFam_Leave                   ;
    property Med_Leave                        :Double      read GetMed_Leave                      write SetMed_Leave                   ;
    property SUI_Amt                          :Double      read GetSUI_Amt                        write SetSUI_Amt                     ;
    property State_Misc_Amt                   :Double      read GetState_Misc_Amt                 write SetState_Misc_Amt              ;
    property State_Surcharge_Amt              :Double      read GetState_Surcharge_Amt            write SetState_Surcharge_Amt         ;
    property State_WC_Amt                     :Double      read GetState_WC_Amt                   write SetState_WC_Amt                ;
    property State_Transit_Tax                :Double      read GetState_Transit_Tax              write SetState_Transit_Tax           ;
    property State_Backup_Withholding_Amt     :Double      read GetState_Backup_Withholding_Amt   write SetState_Backup_Withholding_Amt;
    property State_Allocation_Percent         :Double      read GetState_Allocation_Percent       write SetState_Allocation_Percent    ;
    property Local_Tax_Jurisdiction           :string      read GetLocal_Tax_Jurisdiction         write SetLocal_Tax_Jurisdiction      ;
    property Local_Tax_Name                   :string      read GetLocal_Tax_Name                 write SetLocal_Tax_Name              ;
    property Local_Amt                        :Double      read GetLocal_Amt                      write SetLocal_Amt                   ;
    property Local_Allocation_Percent         :Double      read GetLocal_Allocation_Percent       write SetLocal_Allocation_Percent    ;
    Property PayChexsynched                   :Boolean     read getPayChexsynched                 write setPayChexsynched              ;
  end;

  TTimeLog = class(TMSBusObj)
  private
    function GetTimeLogID     : Integer;
    function GetTimeSheetID   : Integer;
    function GetEmployeeID    : Integer;
    function GetEmployeeName  : string;
    function GetStartDateTime : TDateTime;
    function GetEndDateTime   : TDateTime;
    function GetDuration      : Double;
    function GetEnteredBy     : Integer;
    function GetDescription   : string;
    function GetProduct       : string;

    procedure SetTimeSheetID(const Value: Integer);
    procedure SetStartDateTime(const Value: TDateTime);
    procedure SetEndDateTime(const Value: TDateTime);
    procedure SetDuration(const Value: Double);
    procedure SetEnteredBy(const Value: Integer);
    procedure SetDescription(const Value: string);
    procedure SetProduct(const Value: string);

  protected
    function GetSQL: string; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetID: integer; override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    function ValidateData : Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj) : Boolean; override;
    Function Save : Boolean; override;

    property TimeLogID  : Integer   read GetTimeLogID;

  published
    property TimeSheetID    : Integer     read GetTimeSheetID   write SetTimeSheetID;
    property EmployeeID     : Integer     read GetEmployeeID;
    property EmployeeName   : string      read GetEmployeeName;
    property StartDatetime  : TDatetime   read GetStartDateTime write SetStartDateTime;
    property EndDatetime    : TDatetime   read GetEndDateTime   write SetEndDateTime;
    property Duration       : Double      read GetDuration      write SetDuration;
    property EnteredBy      : Integer     read GetEnteredBy     write SetEnteredBy;
    property Description    : string      read GetDescription   write SetDescription;
    property Product        : string      read GetProduct       write SetProduct;


  end;

  TTimeSheet = class(TMSBusObj)
  private
    fbCustomerJobChanging: Boolean;
    fbClosingDown: Boolean;
    IsDoCalcsInProgress: Boolean;
    fNewTimeSheetEntry: TGeneralProc;
    fAssigntimeSheetJob: TGeneralProc;
    fbIgnoreLabourcostValidation: boolean;
    // fiObjAccesslevel :Integer;
    function GetDate: TDateTime;
    function GetTimeSheetID: integer;
    
    function GetChargeRate: Double;
    function GetTimeSheetClassID: integer;
    function GetTimeSheetClassName: string;
    function GetEmployeeID: integer;
    function GetEmployeeName: string;
    function GetHourlyRate: Double;
    function GetHours: Double;
    function GetJob: string;
    function GetJobID: integer;
    function GetLabourCost: Double;
    function GetNotes: string;
    function GetPartID: integer;
    function GetPartName: string;
    function GetPartsDescription: string;
    function GetPayRateTypeID: integer;
    function GetRatetypeID: integer;
    function GetPayRateTypeName: string;
    function GetRatetypeName: string;
    function GetArea: string;
    function GetSaleLineID: integer;
    function GetSalesID: integer;
    function GetServiceID: integer;
    function GetServiceName: string;
    function GetSuperAmount: Double;
    function GetSuperInc: Boolean;
    function GetTax: Double;
    function GetTotal: Double;
    function GetUseTimeCost: Boolean;
    Function GetAllowedit: Boolean;
    function getTimesheetEntryID: integer;
    function GetStatus : string;
    function GetLogs : TTimeLog;
    function GetApproved: Boolean;
    function GetDone    : Boolean;
    function GetDoneStatus : string;
    function GetStartTime : TDateTime;
    function GetEndTime : TDateTime;

    procedure SetStatus(const Value: string);
    procedure SetChargeRate(const Value: Double);
    procedure SetTimeSheetClassID(const Value: integer);
    procedure SetTimeSheetClassName(const Value: string);
    procedure SetEmployeeID(const Value: integer);
    procedure SetEmployeeName(const Value: string);
    procedure SetHourlyRate(const Value: Double);
    procedure SetHours(const Value: Double);
    procedure SetJobID(const Value: integer);
    procedure SetLabourCost(const Value: Double);
    procedure SetNotes(const Value: string);
    procedure SetPartID(const Value: integer);
    procedure SetPartName(const Value: string);
    procedure SetPartsDescription(const Value: string);
    procedure SetPayRateTypeID(const Value: integer);
    procedure SetRatetypeID(const Value: integer);
    procedure SetPayRateTypeName(const Value: string);
    procedure SetRatetypeName(const Value: string);
    procedure SetArea(const Value: string);
    procedure SetSaleLineID(const Value: integer);
    procedure SetSalesID(const Value: integer);
    procedure SetServiceID(const Value: integer);
    procedure SetSuperAmount(const Value: Double);
    procedure SetSuperInc(const Value: Boolean);
    procedure SetTax(const Value: Double);
    procedure SetTotal(const Value: Double);
    procedure SetUseTimeCost(const Value: Boolean);
    procedure SetJob(const Value: string);
    procedure SetServiceName(const Value: string);
    Procedure SetAllowedit(Const Value: Boolean);
    Procedure SetTimesheetEntryID(const Value: integer);
    procedure SetApproved(const Value: Boolean);
    procedure SetDone(const Value: Boolean);
    procedure SetDoneStatus(const Value: string);
    procedure SetDate(const Value: TDateTime);
    procedure SetStartTime(const Value: TDateTime);
    procedure SetEndTime(const Value: TDateTime);

    function GetEmployee: Temployeedetails;
    function GetCustomer: TCustomer;
    function GetPayRate: TPayRate;
    function GetActive: Boolean;
    procedure SetActive(const Value: Boolean);
    Function EmptyRecord: Boolean;
    Procedure CalctotalAmount;
    function getTotalServicecharge: Double;
    procedure SetTotalServicecharge(const Value: Double);
    function getQuantity: Double;
    procedure setQuantity(const Value: Double);
    function getServiceDate: TDateTime;
    procedure setServiceDate(const Value: TDateTime);
    function getEquipmentName: String;
    function getRepairId: integer;
    //function getCustomerEquipID: integer;
    //procedure SetCustomerEquipID(const Value: integer);
    function getCustomerEquipmentID: integer;
    procedure setCustomerEquipmentID(const Value: integer);
    procedure SetEquipmentName(const Value: String);
    procedure setRepairId(const Value: integer);
    function getAppointmentID: integer;
    procedure setAppointmentID(const Value: integer);
    function getTimeSheetEntryDesc: String;
    function getprocessparttimesheetID: integer;
    procedure setprocessparttimesheetID(const Value: integer);
    function getRosterID: integer;
    procedure setRosterID(const Value: integer);
    function getSignatureTime :TDateTime;
    Function getContactName :String;
    Procedure SetSignatureTime (const Value :TdateTime);
    Procedure SetContactName(const Value:String);
    function GetSaleGlobalRef: string;
    function GetSaleLineGlobalRef: string;
    procedure SetSaleGlobalRef(const Value: string);
    procedure SetSaleLineGlobalRef(const Value: string);
    function GetAppointmentGlobalRef: string;
    procedure SetAppointmentGlobalRef(const Value: string);
    function GetRosterGlobalRef: string;
    function GetInvoiceNotes: string;
    function GetWorkOrderCouponID: string;
    procedure SetRosterGlobalRef(const Value: string);
    procedure SetInvoiceNotes(const Value: string);
    procedure SetWorkOrderCouponID(const Value: string);
    function GetRepairGlobalRef: string;
    procedure SetRepairGlobalRef(const Value: string);
    function getServideDescription: String;
    function IsFixedService: Boolean;
    function GetOverheadRate: double;
    function GetTotalAdjusted: double;
    procedure SetOverheadRate(const Value: double);
    procedure setTotalAdjusted(const Value: double);
    function GetTotalInc: double;
//    function GetCustomerName: string;
//    function GetJobName: string;
//    procedure SetCustomerName(const Value: string);
//    procedure SetJobName(const Value: string);
  protected
    fEmployee: Temployeedetails;
    fCustomer: TCustomer;
    fPayRate: TPayRate;
    // fCounter: integer;
    fEmployeeFirstName: string;
    fEmployeeLastName: string;
    function GetSQL: string; override;
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    Function DoBeforeDelete(Sender: TDatasetBusObj): Boolean; override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    Function DoBeforeInsert(Sender: TDatasetBusObj): Boolean; override;
    Function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    Function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function CheckLastDate(const TestDate: TDateTime; const EmployeeID: integer): TDateTime;
  public
    fbCustomImportDelete: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoCalcs;
    procedure calcServicecharge;
    function GetId: integer; override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    function ValidateData: Boolean; override;
    procedure LoadFromXMLNode(Const Node: IXMLNode); override;
    procedure SaveToXMLNode(Const Node: IXMLNode); override;
    Function ValidateXMLData(Const Node: IXMLNode): Boolean; Override;
    procedure New; override;
    Function Save: Boolean; override;
    Function EmployeeHasSuper: Boolean;
    Function EmployeeAward: integer;
    Function EmployeePayRateForNormalHours: Double;
    Procedure Invoice(InvoiceObj: TInvoice; curDeptId: integer);
    Property TimeSheetEntryDesc: String read getTimeSheetEntryDesc;
    property TimeSheetID: integer read GetTimeSheetID;
    class function _Schema: string; override;
    Property IgnoreLabourcostValidation :boolean read fbIgnoreLabourcostValidation  write fbIgnoreLabourcostValidation ;
    Property ServideDescription :String read getServideDescription;
    property Customer: TCustomer read GetCustomer;
  Published
//    property JobName: string read GetJobName write SetJobName;
//    property CustomerName: string read GetCustomerName write SetCustomerName;
    property JobID: integer read GetJobID write SetJobID;
    property Job: string read GetJob write SetJob;
    property TimeSheetDate: TDateTime read GetDate write SetDate;
    property Hours: Double read GetHours write SetHours;
    property Total: Double read GetTotal write SetTotal;
    property TotalInc : double read GetTotalInc;
    property TotalAdjusted : double read GetTotalAdjusted write setTotalAdjusted;
    property OverheadRate : double read GetOverheadRate write SetOverheadRate;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property EmployeeID: integer read GetEmployeeID write SetEmployeeID;
    property LabourCost: Double read GetLabourCost write SetLabourCost;
    property TimeSheetClassName: string read GetTimeSheetClassName write SetTimeSheetClassName;
    property TimeSheetClassID: integer read GetTimeSheetClassID write SetTimeSheetClassID;
    property ServiceID: integer read GetServiceID write SetServiceID;
    property ServiceName: string read GetServiceName write SetServiceName;
    property ChargeRate: Double read GetChargeRate write SetChargeRate;
    Property TotalServicecharge: Double Read getTotalServicecharge Write SetTotalServicecharge;
    property PartName: string read GetPartName write SetPartName;
    property PartID: integer read GetPartID write SetPartID;
    property PartsDescription: string read GetPartsDescription write SetPartsDescription;
    property UseTimeCost: Boolean read GetUseTimeCost write SetUseTimeCost;
    property Tax: Double read GetTax write SetTax;
    property PayRateTypeName: string read GetPayRateTypeName write SetPayRateTypeName;
    property RatetypeName: string read GetRatetypeName write SetRatetypeName;
    property Area: string read GetArea write SetArea;
    property PayRateTypeID: integer read GetPayRateTypeID write SetPayRateTypeID;
    property RatetypeID: integer read GetRatetypeID write SetRatetypeID;
    property HourlyRate: Double read GetHourlyRate write SetHourlyRate;
    property SuperInc: Boolean read GetSuperInc write SetSuperInc;
    property SuperAmount: Double read GetSuperAmount write SetSuperAmount;
    property SalesID: integer read GetSalesID write SetSalesID;
    property SaleLineID: integer read GetSaleLineID write SetSaleLineID;
    property SaleGlobalRef: string read GetSaleGlobalRef write SetSaleGlobalRef;
    property SaleLineGlobalRef: string read GetSaleLineGlobalRef write SetSaleLineGlobalRef;
    property ProcessPartTimesheetID: integer read getprocessparttimesheetID
      Write setprocessparttimesheetID;
    property Notes: string read GetNotes write SetNotes;
    property Active: Boolean read GetActive write SetActive;
    Property Allowedit: Boolean Read GetAllowedit Write SetAllowedit;
    Property TimesheetEntryID: integer read getTimesheetEntryID Write SetTimesheetEntryID;
    property Approved: Boolean read getApproved write setApproved;
    property Done: Boolean read getDone write setDone;
    property DoneStatus: string read getDoneStatus write setDoneStatus;
    property Employee: Temployeedetails read GetEmployee;
    property PayRate: TPayRate read GetPayRate;
    Property NewTimeSheetEntry: TGeneralProc read fNewTimeSheetEntry Write fNewTimeSheetEntry;
    Property AssigntimeSheetJob: TGeneralProc Read fAssigntimeSheetJob Write fAssigntimeSheetJob;
    Property Quantity: Double Read getQuantity Write setQuantity;
    Property ServiceDate: TDateTime REad getServiceDate Write setServiceDate;
    Property RepairId: integer Read getRepairId Write setRepairId;
    property RepairGlobalRef: string read GetRepairGlobalRef write SetRepairGlobalRef;
    //Property CustomerEquipID: integer Read getCustomerEquipID Write SetCustomerEquipID;
    Property CustomerEquipmentID: integer Read getCustomerEquipmentID Write setCustomerEquipmentID;
    Property EquipmentName: String REad getEquipmentName Write SetEquipmentName;
    Property AppointmentID: integer read getAppointmentID write setAppointmentID;
    property AppointmentGlobalRef: string read GetAppointmentGlobalRef write SetAppointmentGlobalRef;
    Property RosterID: integer read getRosterID Write setRosterID;
    Property SignatureTime : TdateTime read getSignatureTime write setSignatureTime;
    Property ContactName :String read getContactName write setContactName;
    property RosterGlobalRef: string read GetRosterGlobalRef write SetRosterGlobalRef;
    property InvoiceNotes: string read GetInvoiceNotes write SetInvoiceNotes;
    property WorkOrderCouponID: string read GetWorkOrderCouponID write SetWorkOrderCouponID;
    property Status: string read GetStatus write SetStatus;
    property Logs : TTimeLog read GetLogs;
    property StartTime : TDateTime read GetStartTime write SetStartTime;
    property EndTime : TDateTime read GetEndTime write SetEndTime;

    // Property ObjAccesslevel     : integer       Read fiObjAccesslevel       Write fiObjAccesslevel;
  end;
  TPendingTimeSheetForPayroll = Class(TTimeSheet)
    Private
    Protected
    Public
      constructor Create(AOwner: TComponent); override;
  End;
  TTimesheetEntryBase = class(TMSBusObj)
  private
    ftimeSheet: TTimeSheet;
    fTimeSheetByreapirID: TTimeSheet;
    AllTimeSheetValid: Boolean;
    AllTimeSheetSaved: Boolean;
    fdtotal, fdHours: Double;
    fdTotalAdjusted : double;
    fdtotalService, fdtotalQy: Double;
    fldTotalInc : double;  // pseudo field, not in database
    fRepairObjtoallocatetoRepair :TBusobj;
    Function GetEntrydate: TDateTime;
    Function GetType: String;
    Function GetTypeid: integer;
    Function GetWhoentered: String;
    function GetTimeSheet: TTimeSheet;
    Procedure SetEntrydate(Const Value: TDateTime);
    Procedure SetType(Const Value: String);
    Procedure SetTypeid(Const Value: integer);
    Procedure SetWhoentered(Const Value: String);
    Procedure ValidateDatacallback(Const Sender: TBusObj; var Abort: Boolean);
    Procedure SaveDataCallback(Const Sender: TBusObj; var Abort: Boolean);
    Procedure CalctotalCallback(Const Sender: TBusObj; var Abort: Boolean);
    Procedure CalctotalAmount;
    procedure allocatetoRepairCallback(Const Sender: TBusObj; var Abort: Boolean);
    Procedure RepairObjtoallocatetoRepair(const fiRepairID: Integer);
    function GetTimeSheetByreapirID: TTimeSheet;
    function GetTotalAmountInc: double;
  Protected
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
    procedure DoFieldOnChange(Sender: TField); Override;
    Function GetSQL: STring; Override;
    Function DoAfterPost(Sender: TDatasetBusObj): Boolean; Override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
    Function ExportsubClasses(Const Node: IXMLNode): Boolean; Override;
    Function ImportsubClasses(const Node: IXMLNode): Boolean; Override;
  Public
    class Function GetIDField: String; Override;
    class function GetBusObjectTablename: string; Override;
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
    procedure LoadFromXMLNode(Const Node: IXMLNode); override;
    procedure SaveToXMLNode(Const Node: IXMLNode); override;
    Function ValidateData: Boolean; Override;
    Function Save: Boolean; Override;
    Property TotalAmount: Double read fdtotal;
    property TotalAmountInc : double read GetTotalAmountInc;
    Property TotalHours: Double read fdHours;
    property TotalAdjusted : double read fdTotalAdjusted;
    Property totalServiceCharges: Double read fdtotalService;
    Property totalQy: Double Read fdtotalQy;
    Procedure CalcTimesheetTotal;
    class function _Schema: string; override;
    Procedure allocatetoRepair;
    Property TimeSheetByreapirID: TTimeSheet Read GetTimeSheetByreapirID;
    Property TimeSheet: TTimeSheet Read GetTimeSheet;
  Published
    Property EntryDate: TDateTime Read GetEntrydate Write SetEntrydate;
    Property TypeName: String Read GetType Write SetType;
    Property TypeId: integer Read GetTypeid Write SetTypeid;
    Property WhoEntered: String Read GetWhoentered Write SetWhoentered;
    { the following is a list of time sheets }
  End;

  TTimesheetEntry = class(TTimesheetEntryBase)
  Private
  Protected
  Public
  Published
    Property TimeSheet;
  end;

  TTimesheetEntryDetails = class(TTimesheetEntryBase)
  Private
    AllLinesValid:Boolean;
    function getTimesheetDetails: TTimesheetDetails;
    procedure saveCallback(const Sender: TBusObj; var Abort: Boolean);
  Protected
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
  Public
    Function Save:Boolean;Override;
  Published
    Property TimesheetDetails : TTimesheetDetails read getTimesheetDetails;
  end;

implementation

uses Forms, PayCommon, SysUtils,
  Dialogs, BusObjConst, DNMLib, tcDataUtils, MyAccess, ERPdbComponents, tcTypes,
  CommonLib, BusObjPayBase, BusObjEmployeepayrates, busobjrepairs, tcConst,
  AppEnvironment, BusObjSchemaLib, BusObjClass, BusObjCommon, BusObjStock,
  BusObjSaleBase, BusObjAppointments, BusObjRoster, BusObjEmployee, CommonDbLib,
  DbSharedObjectsObj;

// TTimeLog
constructor TTimeLog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fSQL := 'SELECT * FROM tbltimelogs';

//  FEmployeeId := 0;
//  FStartDateTime := nil;
//  FEndDateTime := nil;
//  FDuration := 0;
//  FEnteredBy := 0;
//  RDescription := '';
end;

destructor TTimeLog.Destroy;
begin
  inherited;
end;

class Function TTimeLog.GetIDField: String;
begin
  Result := 'ID';
end;

function TTimeLog.GetID: integer;
begin
  Result := TimeLogID;
end;

class function TTimeLog.GetBusObjectTablename: string;
begin
  Result := 'tbltimelogs';
end;

function TTimeLog.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

function  TTimeLog.DoAfterInsert(Sender :TDatasetBusObj) : Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;

  if Assigned(Owner) and (Owner is TTimeSheet) then
    TimeSheetID := TTimeSheet(Owner).ID;
end;

function TTimeLog.ValidateData: Boolean;
begin
  Result := inherited ValidateData;
  if not Result then
    Exit;

  Result:= False;

  if TimeSheetID = 0 then begin
    AddResult(False, rssWarning, BOR_TimeSheet_Err, 'TimeSheeID should be specified.');
    Exit;
  end;

  Result := True;
end;

function TTimeLog.Save: Boolean;
begin
  Result := False;
  if Not ValidateData then Exit;

  ResultStatus.Clear;
  Result := Inherited Save;
end;

function TTimeLog.GetTimeLogID: Integer;
begin
  Result := GetIntegerField('ID');
end;

function TTimeLog.GetTimeSheetID: Integer;
begin
  Result := GetIntegerField('TimeSheetID');
end;

function TTimeLog.GetEmployeeID: Integer;
var
  TSID : Integer;
  Qry : TERPQuery;
begin
  TSID := GetIntegerField('TimeSheetID');
  Qry := DbSharedObj.GetQuery(connection.Connection);
  try
    CommonDbLib.CloseDB(Qry);
    Qry.SQL.Text := 'SELECT EmployeeID FROM tblTimeSheets WHERE ID = ' + IntToStr(TSID);
    CommonDbLib.openDB(Qry);
    Result := Qry.FieldByName('EmployeeID').AsInteger;
  Finally
    DbSharedObj.ReleaseObj(Qry);
  End;
end;

function TTimeLog.GetEmployeeName: string;
var
  TSID : Integer;
  Qry : TERPQuery;
begin
  TSID := GetIntegerField('TimeSheetID');
  Qry := DbSharedObj.GetQuery(connection.Connection);
  try
    CommonDbLib.CloseDB(Qry);
    Qry.SQL.Text := 'SELECT EmployeeName FROM tblTimeSheets WHERE ID = ' + IntToStr(TSID);
    CommonDbLib.openDB(Qry);
    Result := Qry.FieldByName('EmployeeName').AsString;
  Finally
    DbSharedObj.ReleaseObj(Qry);
  End;
end;

function TTimeLog.GetStartDateTime: TDateTime;
begin
  Result := GetDateTimeField('StartDateTime');
end;

function TTimeLog.GetEndDateTime: TDateTime;
begin
  Result := GetDateTimeField('EndDateTime');
end;

function TTimeLog.GetDuration: Double;
begin
  Result := GetFloatField('Duration');
end;

function TTimeLog.GetEnteredBy: Integer;
begin
  Result := GetIntegerField('EnteredBy');
end;

function TTimeLog.GetDescription: string;
begin
  Result := GetStringField('Description');
end;

function TTimeLog.GetProduct: string;
begin
  Result := GetStringField('Product');
end;

procedure TTimeLog.SetTimeSheetID(const Value: Integer);
begin
  SetIntegerField('TimeSheetID', Value);
end;

procedure TTimeLog.SetStartDateTime(const Value: TDateTime);
begin
  SetDateTimeField('StartDateTime', Value);
end;

procedure TTimeLog.SetEndDateTime(const Value: TDateTime);
begin
  SetDateTimeField('EndDateTime', Value);
end;

procedure TTimeLog.SetDuration(const Value: Double);
begin
  SetFloatField('Duration', Value);
end;

procedure TTimeLog.SetDescription(const Value: string);
begin
  SetStringField('Description', Value);
end;

procedure TTimeLog.SetEnteredBy(const Value: Integer);
begin
  SetIntegerField('EnteredBy', Value);
end;

procedure TTimeLog.SetProduct(const Value: string);
begin
  SetStringField('Product', Value);
end;


// TTimeSheet
constructor TTimeSheet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT T.* ' + ' FROM tbltimesheets as T ' +
    ' INNER JOIN tbltimesheetentry as TE ON TE.TimesheetEntryID = T.TimesheetEntryID';
  fEmployee := nil;
  fCustomer := nil;
  fbCustomerJobChanging := false;
  ResultStatus.Reset;
  fbCustomImportDelete := false;
  fNewTimeSheetEntry := nil;
  fAssigntimeSheetJob := nil;
  fIsList := true;
  ExportExcludeList.Add('employeeid');
  ExportExcludeList.Add('jobid');
  ExportExcludeList.Add('timesheetclassid');
  ExportExcludeList.Add('serviceid');
  ExportExcludeList.Add('partid');
  ExportExcludeList.Add('payratetypeid');
  ExportExcludeList.Add('Ratetypeid');
  ExportExcludeList.Add('salesid');
  ExportExcludeList.Add('salelineid');
  if Assigned(Owner) and (Owner is TTimesheetEntryBase) then begin
    if TTimesheetEntryBase(Owner).TypeName <> 'Manufacturing' then
      ExportExcludeList.Add('processparttimesheetid');
  end;
  ExportExcludeList.Add('employee');
  ExportExcludeList.Add('customer');
  ExportExcludeList.Add('payrate');
  ExportExcludeList.Add('appointmentid');
  ExportExcludeList.Add('rosterid');
  ExportExcludeList.Add('repairid');
  IgnoreLabourcostValidation:= False;
end;

Function TTimeSheet.EmptyRecord: Boolean;
begin
  Result := (not RawMode) and (EmployeeID = 0) and (Hours = 0) and (CustomerEquipmentID = 0);
end;

Function TTimeSheet.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := Inherited DoAfterPost(Sender);
  if not Result then
    Exit;
End;

Function TTimeSheet.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := Inherited DoAfterPost(Sender);
  if not Result then
    Exit;
  if count > 0 then
    if EmptyRecord then
      Dataset.Delete;
  if count > 0 then
    if assigned(self.Owner) then
      if assigned(self.Owner.Owner) then
        if self.Owner.Owner is TRepairs then
          sendEvent(BusObjEvent_Change, BusObjEvent_TimesheetAdded);
end;

Function TTimeSheet.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
var
  ctr: integer;
begin
  Result := inherited DoBeforeInsert(Sender);
  if not Result then
    Exit;
  for ctr := 0 to Dataset.fields.count - 1 do
    Dataset.fields[ctr].REadonly := false;
End;

Function TTimeSheet.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := Inherited DoAfterInsert(Sender);
  if not Result then
    Exit;

  if assigned(fNewTimeSheetEntry) then
    fNewTimeSheetEntry;
  if assigned(self.Owner) then begin
    if self.Owner is TTimesheetEntryBase then begin
      TimesheetEntryID := TTimesheetEntryBase(self.Owner).ID;
      if assigned(self.Owner.Owner) then
        if self.Owner.Owner is TRepairs then begin
          JobID := TRepairs(self.Owner.Owner).ClientID;
        end;
    end;
    if Owner is TRepairTimesheetEntry then
        Area :=TRepairTimesheetEntry (Owner).RepairArea;
  end;
  if assigned(fAssigntimeSheetJob) then
    fAssigntimeSheetJob;
  Allowedit := true;
  Active := true;
  TimeSheetDate := date;
end;

Function TTimeSheet.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
begin
  Result := true;
  if fbCustomImportDelete then
    Exit;
  if not Active then begin
    CommonLib.MessageDlgXP_Vista
      ('This record cannot be deleted as this timesheet entry has already been loaded into ' +
      EmployeeName + '''s Paysheet!', mtWarning, [mbOK], 0);
    Abort;
  end;

  if (SalesID <> 0) and UseTimeCost then begin
    CommonLib.MessageDlgXP_Vista
      ('This record cannot be deleted as this timesheet entry has already been assigned to ' +
      'an Invoice!', mtWarning, [mbOK], 0);
    Abort;
  end;
end;

destructor TTimeSheet.Destroy;
begin
  if assigned(fEmployee) then
    FreeAndNil(fEmployee);
  if assigned(fCustomer) then
    FreeAndNil(fCustomer);
  if assigned(fPayRate) then
    FreeAndNil(fPayRate);
  inherited;
end;

procedure TTimeSheet.DoCalcs;
var
  TotalAmt: Double;
  iAwardID: integer;
begin
  If Not IsDoCalcsInProgress then Begin
    Application.ProcessMessages;
    if fbClosingDown then
      Exit;
    if EmployeeName = '' then
      Exit;
    IsDoCalcsInProgress := true;
    Try
      TotalAmt := Hours * LabourCost;
      SuperInc := AppEnv.CompanyPrefs.DefaultSuperOnTimesheet;
      if not SuperInc then
        SuperInc := EmployeeHasSuper;
      Editdb;
      if SuperInc then begin
        iAwardID := EmployeeAward;
        if iAwardID = 0 then begin
        end
        else begin
        end;
        { -orobin : Incorporate extra logic in SuperThresholdAmount } // LATER
        EditDb;
      end
      else begin
        SuperAmount := 0;
      end;
      if Total <> TotalAmt then begin
        Total := TotalAmt;
        TotalAdjusted := TotalAmt * (1 + OverheadRate / 100);
        CalctotalAmount;
      end;
      PostDb;
      EditDb;
    finally
      IsDoCalcsInProgress := false;
    end;
  end;
end;

procedure TTimeSheet.DoFieldOnChange(Sender: TField);
var
  fdhourlyrate: Double;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = false then
      Exit; // we are only interested in data fields.
  inherited;

  if SysUtils.SameText(Sender.FieldName, 'TimeSheetDate') then begin

  end
  else if (SysUtils.SameText(Sender.FieldName, 'ClassName')) then begin
    if TimeSheetClassName <> '' then
      TimeSheetClassID := TDeptClass.IDToggle(TimeSheetClassName, Connection.Connection)
    else
      TimeSheetClassID := 0;
    if not RawMode then begin
      DoFieldOnChange(Dataset.FindField('ClassId'));
    end;
  end
  else if (SysUtils.SameText(Sender.FieldName, 'classId')) then begin
    if TimeSheetClassID > 0 then
      TimeSheetClassName := TDeptClass.IDToggle(TimeSheetClassID, Connection.Connection)
    else
      TimeSheetClassName := '';
  end
  else if (SysUtils.SameText(Sender.FieldName, 'Job')) then begin
    if Job <> '' then
      JobID := TClient.IDToggle(Job, Connection.Connection)
    else
      JobID := 0;
    if not RawMode then begin
      DoFieldOnChange(Dataset.FindField('jobID'));
    end;
  end
  else if (SysUtils.SameText(Sender.FieldName, 'JobID')) then begin
    Job := Customer.clientName;
  end
  else if SysUtils.SameText(Sender.FieldName, 'PayRateTypeName') then begin
    if not RawMode then begin
      if PayRate.Description <> '' then begin
        Edit;
        PayRateTypeID := PayRate.RateID;
        LabourCost := PayRate.Multiplier * HourlyRate;
        TotalAdjusted := Hours * LabourCost * (1 + OverheadRate/100);
        DoCalcs;
      end;
    end;
  end
  else if SameText(Sender.FieldName, 'OverheadRate') then
  begin
    if not RawMode then
      TotalAdjusted := Hours * LabourCost * (1 + OverheadRate/100);
  end
  else if SysUtils.SameText(Sender.FieldName, 'Hours') then begin
    if not RawMode then begin
      if fbClosingDown then
        Exit;
      if not IsDoCalcsInProgress then
        DoCalcs;
      if (Quantity = 0) then begin
        Quantity := Hours;
        calcServicecharge;
      end;
    end;
  end
  else if SysUtils.SameText(Sender.FieldName, 'LabourCost') then begin
    if not RawMode then begin
      if fbClosingDown then
        Exit;
      DoCalcs;
    end;
  end
  else if SysUtils.SameText(Sender.FieldName, 'SuperInc') then begin
    if not RawMode then begin
      if fbClosingDown then
        Exit;
      DoCalcs;
    end;
  end
  else if SysUtils.SameText(Sender.FieldName, 'Qty') then begin
    if not RawMode then begin
      calcServicecharge;
    end;
  end else if SysUtils.SameText(Sender.FieldName, 'ChargeRate') then begin
    if not RawMode then begin
      calcServicecharge;
      Editdb;
    end;
  end else if SysUtils.SameText(Sender.FieldName, 'TotalServicecharge') then begin
    if not RawMode then begin
      if IsFixedService then ChargeRate := TotalServicecharge else ChargeRate := divzer(TotalServicecharge,Quantity) ;
      calcServicecharge;
      Editdb;
    end;
  end  else if SysUtils.SameText(Sender.FieldName, 'ServiceName') then begin
    if ServiceName <> '' then
      ServiceID:= getEmpServiceID(ServiceName , EmployeeID) // TServices.IDToggle(ServiceName, Connection.Connection)
    else
      ServiceId := 0;
    if not RawMode then begin
      if ServiceName <> '' then
        if ServiceDate = 0 then
          ServiceDate := TimeSheetDate;
    end;
  end
  else if SysUtils.SameText(Sender.FieldName, 'ServiceID') then begin
    if ServiceId > 0 then
      ServiceName:= getEmpServiceNAme(ServiceID) //TServices.IDToggle(ServiceId, Connection.Connection)
    else
      ServiceNAme := '';
    if not RawMode then begin
      if ServiceName <> '' then
        if ServiceDate = 0 then
          ServiceDate := TimeSheetDate;
    end;
  end else if SysUtils.SameText(Sender.FieldName, 'EmployeeID') then begin
    EmployeeNAme := tcdatautils.getemployeeName(EmployeeID);
    DoFieldOnChange(Self.Dataset.FieldByName('EmployeeName'));
  end else if SysUtils.SameText(Sender.FieldName, 'EmployeeName') then begin
    if not RawMode then begin
      if EmployeeName = '' then
        Exit;
      EmployeeID := Employee.ID;
      PostDb; // This is a Post :-)
      fdhourlyrate := EmployeePayRateForNormalHours;
      if fdhourlyrate = 0 then begin
        Cancel;
        Exit;
      end;
      HourlyRate := fdhourlyrate;
      if PayRateTypeID = 0 then begin
        LabourCost := fdhourlyrate;
      end
      else begin
        LabourCost := HourlyRate * PayRate.Multiplier;
        Total := LabourCost * Hours;
      end;
      OverheadRate :=Employee.OverheadRate;
      TotalAdjusted := Hours * LabourCost * (1 + OverheadRate/100);
      // Since a new employee was selected then clear out the
      // Service details and have the user respecify what they want.
      PayRateTypeName := 'Normal Hours';
      if area = '' then area := Employee.Area;
      ServiceName := '';
      ServiceID := 0;
      ChargeRate := 0;
      PartID := 0;
      PartName := '';
    end;
  end
  else if SysUtils.SameText(Sender.FieldName, 'PartID') then begin
    if PartId > 0 then
      PartName := TProduct.IDToggle(PartId, Connection.Connection)
    else
      PartName := '';
  end
  else if SysUtils.SameText(Sender.FieldName, 'PartName') then begin
    if PartName <> '' then
      PartId := TProduct.IDToggle(PartName, Connection.Connection)
    else
      PartId := 0;
  end else if SysUtils.SameText(Sender.FieldName, 'PayRateTypeID') then begin
    if PayRateTypeID > 0 then
      PayRateTypeName:= TPayRate.IDToggle(PayRateTypeID, Connection.Connection)
    else
      PayRateTypeName := '';
  end else if SysUtils.SameText(Sender.FieldName, 'PayRateTypeName') then begin
    if PayRateTypeName <> '' then
      PayRateTypeID:= TPayRate.IDToggle(PayRateTypeName, Connection.Connection)
    else
      PayRateTypeID := 0;
  end else if SysUtils.SameText(Sender.FieldName, 'RatetypeID') then begin
    if RatetypeID > 0 then
      RatetypeName:= TPayRatetype.IDToggle(RateTypeID, Connection.Connection)
    else
      RatetypeName := '';
  end else if SysUtils.SameText(Sender.FieldName, 'RatetypeName') then begin
    if RatetypeName <> '' then
      RatetypeID:= TPayRatetype.IDToggle(RatetypeName, Connection.Connection)
    else
      RatetypeID := 0;
  end else if SysUtils.SameText(Sender.FieldName, 'WorkOrderCouponID') then begin
    if not(self.IsUnique(ID,'WorkOrderCouponID = ' + QuotedStr(WorkOrderCouponID), self.connection.connection )) then begin
      sendEvent(BusObjEvent_Change, BusObjEvent_DupWorkOrderCouponID);
    end;
  end;
end;

function TTimeSheet.GetCustomer: TCustomer;
begin
  if not assigned(fCustomer) then begin
    fCustomer := TCustomer.Create(self);
  end;
  if (self.JobID > 0) and (fCustomer.ID <> self.JobID) then
    fCustomer.LoadSelect('Active = ''T'' AND (Company NOT LIKE ''Table%'') AND ' + 'ClientID = ' +
      IntToStr(self.JobID))
  else
    fCustomer.LoadSelect('Active = ''T'' AND (Company NOT LIKE ''Table%'') AND ' + 'Company = "' +
      Job + '"');

  Result := fCustomer;
end;

//function TTimeSheet.GetCustomerName: string;
//begin
//  if not Customer.IsJob then
//    result := Job
//  else
//    result := '';
//end;

function TTimeSheet.GetDate: TDateTime;
begin
  Result := GetDateTimeField('TimeSheetDate');
end;
function TTimeSheet.GetSignatureTime: TDateTime;
begin
  Result := GetDateTimeField('SignatureTime');
end;


function TTimeSheet.GetEmployee: Temployeedetails;
begin
  if not assigned(fEmployee) then
    fEmployee := Temployeedetails.Create(self);

  self.EmployeeID := DNMLib.GetEmployeeID(self.EmployeeName);

  if (self.EmployeeID > 0) and (fEmployee.ID <> self.EmployeeID) then
    fEmployee.LoadSelect('EmployeeID = ' + IntToStr(self.EmployeeID));
  Result := fEmployee;
end;

function TTimeSheet.GetPayRate: TPayRate;
begin
  if not assigned(fPayRate) then begin
    fPayRate := TPayRate.Create(self);
  end;
  if (self.JobID > 0) and (fPayRate.RateID <> PayRateTypeID) then
    fPayRate.LoadSelect
      ('Active = "T" AND IsLeave = "F" AND Description NOT LIKE "%Leave%" AND Description NOT LIKE "Termination%" AND '
      + 'RateID = ' + IntToStr(PayRateTypeID))
  else
    fPayRate.LoadSelect
      ('Active = "T" AND IsLeave = "F" AND Description NOT LIKE "%Leave%" AND Description NOT LIKE "Termination%" AND '
      + 'Description = "' + PayRateTypeName + '"');

  Result := fPayRate;
end;

function TTimeSheet.GetEmployeeID: integer;
begin
  Result := GetIntegerField('EmployeeID');
end;

function TTimeSheet.GetEmployeeName: string;
begin
  Result := GetStringField('EmployeeName');
end;

function TTimeSheet.GetHourlyRate: Double;
begin
  Result := GetFloatField('HourlyRate');
end;

function TTimeSheet.GetHours: Double;
begin
  Result := GetFloatField('Hours');
end;

function TTimeSheet.GetId: integer;
begin
  Result := TimeSheetID;
end;

function TTimeSheet.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TTimeSheet.GetChargeRate: Double;
begin
  Result := GetFloatField('ChargeRate');
end;

function TTimeSheet.getContactName: String;
begin
  REsult:= GetStringfield('ContactName');
end;

function TTimeSheet.GetApproved: Boolean;
begin
  Result := GetBooleanField('Approved');
end;

function TTimeSheet.GetDone: Boolean;
begin
  Result := GetBooleanField('Done');
end;

function TTimeSheet.GetDoneStatus: string;
begin
  Result := GetStringField('DoneStatus');
end;

function TTimeSheet.GetTimeSheetClassID: integer;
begin
  Result := GetIntegerField('ClassID');
end;


function TTimeSheet.GetTimeSheetClassName: string;
begin
  Result := GetStringField('ClassName');
end;

function TTimeSheet.GetJob: string;
begin
  Result := GetStringField('Job');
end;

function TTimeSheet.GetJobID: integer;
begin
  Result := GetIntegerField('JobID');
end;

//function TTimeSheet.GetJobName: string;
//begin
//  if Customer.IsJob then
//    result := Job
//  else
//    result := '';
//end;

function TTimeSheet.GetLabourCost: Double;
begin
  Result := GetFloatField('LabourCost');
end;

function TTimeSheet.GetNotes: string;
begin
  Result := GetStringField('Notes');
end;

function TTimeSheet.GetOverheadRate: double;
begin
  Result := GetFloatField('OverheadRate');
end;

Function TTimeSheet.getTimesheetEntryID: integer;
begin
  Result := GetIntegerField('TimesheetEntryID');
End;

Function TTimeSheet.GetAllowedit: Boolean;
begin
  Result := GetBooleanField('Allowedit');
End;

function TTimeSheet.GetAppointmentGlobalRef: string;
begin
  if AppointmentID > 0 then
    result:= TAppointment.IDGlobalRefToggle(AppointmentID, Connection.Connection)
  else
    result := '';
end;

function TTimeSheet.GetPartID: integer;
begin
  Result := GetIntegerField('PartID');
end;

function TTimeSheet.GetPartName: string;
begin
  Result := GetStringField('PartName');
end;

function TTimeSheet.GetPartsDescription: string;
begin
  Result := GetStringField('PartsDescription');
end;

function TTimeSheet.GetPayRateTypeID: integer;
begin
  Result := GetIntegerField('PayRateTypeID');
end;
function TTimeSheet.GetRatetypeID: integer;
begin
  Result := GetIntegerField('RatetypeID');
end;

function TTimeSheet.GetPayRateTypeName: string;
begin
  Result := GetStringField('PayRateTypeName');
end;
function TTimeSheet.GetRatetypeName: string;
begin
  Result := GetStringField('RateTypeName');
end;
function TTimeSheet.GetArea: string;
begin
  Result := GetStringField('Area');
end;

function TTimeSheet.GetSaleGlobalRef: string;
begin
  if SalesID > 0 then
    result := TSalesBase.IDGlobalRefToggle(SalesID, Connection.Connection)
  else
    result := '';
end;

function TTimeSheet.GetSaleLineGlobalRef: string;
begin
  if SaleLineID > 0 then
    result := TSalesLineBase.IDGlobalRefToggle(SaleLineID, Connection.Connection)
  else
    result := '';
end;

function TTimeSheet.GetSaleLineID: integer;
begin
  Result := GetIntegerField('SaleLineID');
end;

function TTimeSheet.GetSalesID: integer;
begin
  Result := GetIntegerField('SalesID');
end;

function TTimeSheet.GetServiceID: integer;
begin
  Result := GetIntegerField('ServiceID');
end;

function TTimeSheet.GetServiceName: string;
begin
  Result := GetStringField('ServiceName');
end;

function TTimeSheet.GetStatus: string;
begin
  Result := GetStringField('Status');
end;

function TTimeSheet.getServideDescription: String;
begin
  REsult := employeeName +NL + Servicename + ' : ' + FloatTostr(Quantity) +' hrs';
end;

function TTimeSheet.GetSuperAmount: Double;
begin
  Result := GetFloatField('SuperAmount');
end;

function TTimeSheet.GetSuperInc: Boolean;
begin
  Result := GetBooleanField('SuperInc');
end;

function TTimeSheet.GetTax: Double;
begin
  Result := GetFloatField('Tax');
end;

function TTimeSheet.GetTimeSheetID: integer;
begin
  Result := GetIntegerField('ID');
end;

function TTimeSheet.GetTotal: Double;
begin
  Result := GetFloatField('Total');
end;

function TTimeSheet.GetTotalAdjusted: double;
begin
  Result := GetFloatField('TotalAdjusted');
end;

function TTimeSheet.GetTotalInc: double;
begin
  Result := Total * (1 + Tax/100);
end;

function TTimeSheet.GetUseTimeCost: Boolean;
begin
  Result := GetBooleanField('UseTimeCost');
end;

function TTimeSheet.GetLogs : TTimeLog;
var
  Logs : TTimeLog;
  SSQL : string;
begin
//  Logs := TTimeLog.Create();
//  SSQL := 'TimeSheetID = ' + IntToStr(GetTimeSheetID);
//  Logs.LoadSelect(SSQL, True);
//
//  Result := Logs;
  Result := TTimeLog(GetContainerComponent(TTimeLog, 'TimeSheetID = ' + IntToStr(Self.ID)));
end;

function TTimeSheet.GetStartTime: TDateTime;
begin
  Result := GetDateTimeField('StartTime');
end;

function TTimeSheet.GetEndTime: TDateTime;
begin
  Result := GetDateTimeField('EndTime');
end;

procedure TTimeSheet.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TTimeSheet.SetChargeRate(const Value: Double);
begin
  SetFloatField('ChargeRate', Value);
end;

procedure TTimeSheet.SetContactName(const Value: String);
begin
  SetStringField('ContactName' , value);
end;

procedure TTimeSheet.SetApproved(const Value: Boolean);
begin
  SetBooleanField('Approved', Value);
end;

procedure TTimeSheet.SetDone(const Value: Boolean);
begin
  SetBooleanField('Done', Value);
end;

procedure TTimeSheet.SetDoneStatus(const Value: string);
begin
  SetStringField('DoneStatus', Value);
end;

procedure TTimeSheet.SetTimeSheetClassID(const Value: integer);
begin
  SetIntegerField('ClassID', Value);
end;

procedure TTimeSheet.SetTimeSheetClassName(const Value: string);
begin
  SetStringField('ClassName', Value);
end;

procedure TTimeSheet.SetStatus(const Value: string);
begin
  SetStringField('Status', Value);
end;

//procedure TTimeSheet.SetCustomerName(const Value: string);
//begin
//  Job := Value;
//end;

procedure TTimeSheet.SetDate(const Value: TDateTime);
begin
  SetDateTimeField('TimeSheetDate', Value);
end;
procedure TTimeSheet.SetSignatureTime(const Value: TDateTime);
begin
  SetDateTimeField('SignatureTime', Value);
end;
procedure TTimeSheet.SetEmployeeID(const Value: integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

procedure TTimeSheet.SetEmployeeName(const Value: string);
begin
  SetStringField('EmployeeName', Value);
end;

procedure TTimeSheet.SetHourlyRate(const Value: Double);
begin
  SetFloatField('HourlyRate', Value);
end;

procedure TTimeSheet.SetHours(const Value: Double);
begin
  SetFloatField('Hours', Value);
end;

procedure TTimeSheet.SetJob(const Value: string);
begin
  SetStringField('Job', Value);
end;

procedure TTimeSheet.SetJobID(const Value: integer);
begin
  SetIntegerField('JobID', Value);
end;

//procedure TTimeSheet.SetJobName(const Value: string);
//begin
//  Job := Value;
//end;

procedure TTimeSheet.SetLabourCost(const Value: Double);
begin
  SetFloatField('LabourCost', Value);
end;

procedure TTimeSheet.SetNotes(const Value: string);
begin
  SetStringField('Notes', Value);
end;

procedure TTimeSheet.SetOverheadRate(const Value: double);
begin
  SetFloatField('OverheadRate', Value);
end;

procedure TTimeSheet.SetPartID(const Value: integer);
begin
  SetIntegerField('PartID', Value);
end;

procedure TTimeSheet.SetPartName(const Value: string);
begin
  SetStringField('PartName', Value);
end;

procedure TTimeSheet.SetPartsDescription(const Value: string);
begin
  SetStringField('PartsDescription', Value);
end;

procedure TTimeSheet.SetPayRateTypeID(const Value: integer);
begin
  SetIntegerField('PayRateTypeID', Value);
end;
procedure TTimeSheet.SetRatetypeID(const Value: integer);
begin
  SetIntegerField('RatetypeID', Value);
end;

procedure TTimeSheet.SetPayRateTypeName(const Value: string);
begin
  SetStringField('PayRateTypeName', Value);
end;
procedure TTimeSheet.SetRatetypeName(const Value: string);
begin
  SetStringField('RatetypeName', Value);
end;
procedure TTimeSheet.SetArea(const Value: string);
begin
  SetStringField('Area', Value);
end;

procedure TTimeSheet.SetSaleGlobalRef(const Value: string);
begin
  if value <> '' then begin
    SalesID:= TSalesBase.IDGlobalRefToggle(Value, Connection.Connection);
    if SalesID = 0 then
      SalesID := -1;
  end
  else
    SalesID:= 0;
end;

procedure TTimeSheet.SetSaleLineGlobalRef(const Value: string);
begin
  if value <> '' then begin
    SaleLineID:= TSalesLineBase.IDGlobalRefToggle(Value, Connection.Connection);
    if SaleLineID = 0 then
      SaleLineID := -1;
  end
  else
    SaleLineID:= 0;
end;

procedure TTimeSheet.SetSaleLineID(const Value: integer);
begin
  SetIntegerField('SaleLineID', Value);
end;

procedure TTimeSheet.SetSalesID(const Value: integer);
begin
  SetIntegerField('SalesID', Value);
end;

procedure TTimeSheet.SetServiceID(const Value: integer);
begin
  SetIntegerField('ServiceID', Value);
end;

procedure TTimeSheet.SetServiceName(const Value: string);
begin
  SetStringField('ServiceName', Value);
end;

Procedure TTimeSheet.SetTimesheetEntryID(Const Value: integer);
begin
  SetIntegerField('TimesheetEntryID', Value);
End;

Procedure TTimeSheet.SetAllowedit(Const Value: Boolean);
begin
  SetBooleanField('Allowedit', Value);
End;

procedure TTimeSheet.SetAppointmentGlobalRef(const Value: string);
begin
  if Value <> '' then begin
    AppointmentID := TAppointment.IDGlobalRefToggle(Value, Connection.Connection);
    if AppointmentID = 0 then
      AppointmentID := -1;
  end
  else
    AppointmentID:= 0;
end;

procedure TTimeSheet.SetSuperAmount(const Value: Double);
begin
  SetFloatField('SuperAmount', Value);
end;

procedure TTimeSheet.SetSuperInc(const Value: Boolean);
begin
  SetBooleanField('SuperInc', Value);
end;

procedure TTimeSheet.SetTax(const Value: Double);
begin
  SetFloatField('Tax', Value);
end;

procedure TTimeSheet.SetTotal(const Value: Double);
begin
  SetFloatField('Total', Value);
end;

procedure TTimeSheet.setTotalAdjusted(const Value: double);
begin
  SetFloatField('TotalAdjusted', Value);
end;

procedure TTimeSheet.SetUseTimeCost(const Value: Boolean);
begin
  SetBooleanField('UseTimeCost', Value);
end;

procedure TTimeSheet.SetStartTime(const Value: TDateTime);
begin
  SetDateTimeField('StartTime', Value);
end;

procedure TTimeSheet.SetEndTime(const Value: TDateTime);
begin
  SetDateTimeField('EndTime', Value);
end;


class Function TTimeSheet.GetIDField: String;
begin
  Result := 'ID';
end;

class function TTimeSheet.GetBusObjectTablename: string;
begin
  Result := 'tbltimesheets';
end;

function TTimeSheet.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

procedure TTimeSheet.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
var
  ctr: integer;
  fballowedit: Boolean;
begin
  inherited;
  fEmployeeFirstName := '';
  fEmployeeLastName := '';
  if assigned(fEmployee) then
    FreeAndNil(fEmployee);
  if assigned(fCustomer) then
    FreeAndNil(fCustomer);
  if assigned(fPayRate) then
    FreeAndNil(fPayRate);

  fballowedit := Allowedit;
  for ctr := 0 to Dataset.fields.count - 1 do
    Dataset.fields[ctr].REadonly := (not fballowedit);

  (* if allowedit then EditDB; *)

  (* if (not allowedit) then begin
    if  (Accessmanager.Accesslevel < 5 ) then AccessManager.AccessLevel := 5;
    end else begin
    Accessmanager.Accesslevel := fiObjAccesslevel;
    EditDB;
    End; *)
end;

function TTimeSheet.ValidateData: Boolean;
begin
  Result := inherited ValidateData;
  if not Result then
    Exit;
  result:= false;
  if Employee.ID = 0 then begin
    AddResult(false, rssWarning, BOR_TimeSheet_Err, 'Unknown Employee: ' + EmployeeName);
    Exit;
  end;
  if ClassName = '' then begin
    AddResult(false, rssWarning, BOR_TimeSheet_Err, 'You must specify a Department for Timesheet Entries.');
    Exit;
  end;
  if (Hours = 0) and (Quantity = 0) then begin
    AddResult(false, rssWarning, BOR_TimeSheet_Err, 'You must specify the number of hours worked for Timesheet Entries.');
    Exit;
  end;

  if TimeSheetDate = 0 then begin
    AddResult(false, rssWarning, BOR_TimeSheet_Err, 'Date should not be blank');
    Exit;
  end;

  if DNMLib.HasPayrollAccess()  then begin
    if LabourCost = 0 then begin
      if not(IgnoreLabourcostValidation) then begin
        AddResult(false, rssWarning, BOR_TimeSheet_Err, 'You must specify the hourly rate for timesheet entries.');
        Exit;
      end;
    end;
  end;
  if SalesID < 0 then begin
    AddResult(false,rssWarning,0, 'Linked Sale not found');
    exit;
  end;
  if SaleLineID < 0 then begin
    AddResult(false,rssWarning,0, 'Linked Sale Line not found');
    exit;
  end;
  if AppointmentID < 0 then begin
    AddResult(false,rssWarning,0, 'Linked Appointment not found');
    exit;
  end;
  if RosterID < 0 then begin
    AddResult(false,rssWarning,0, 'Linked Roster not found');
    exit;
  end;
  if RepairId < 0 then begin
    AddResult(false,rssWarning,0, 'Linked Repair not found');
    exit;
  end;
  Result := true;
end;

function TTimeSheet.CheckLastDate(const TestDate: TDateTime; const EmployeeID: integer): TDateTime;
Var
  LastPayDate: TDateTime;
begin
  Result := TestDate;
  If (EmployeeID <> 0) then Begin
    LastPayDate := GetLastPayDate(EmployeeID) + 1;
    If TestDate < LastPayDate then
      Result := LastPayDate;
  end;
end;

procedure TTimeSheet.LoadFromXMLNode(Const Node: IXMLNode);
begin
  inherited;
  if ImportingFromXMLFile then begin
    if GetXMLNodeStringValue(Node, 'EmployeeName') <> '' then
      EmployeeID := tcDataUtils.GetEmployeeID(GetXMLNodeStringValue(Node, 'EmployeeName'));
    if GetXMLNodeStringValue(Node, 'Job') <> '' then
      JobID := TJob.IDToggle(GetXMLNodeStringValue(Node, 'Job'), Connection.Connection);
    if GetXMLNodeStringValue(Node, 'ServiceName') <> '' then
      ServiceID := tcDataUtils.GetServiceID(GetXMLNodeStringValue(Node, 'ServiceName'));
    if GetXMLNodeStringValue(Node, 'ClassName') <> '' then
      TimeSheetClassID := tcDataUtils.GetDeptID(GetXMLNodeStringValue(Node, 'ClassName'));
    if GetXMLNodeStringValue(Node, 'PartName') <> '' then
      PartID := tcDataUtils.GetProduct(GetXMLNodeStringValue(Node, 'PartName'));
    if GetXMLNodeStringValue(Node, 'PayRateTypeName') <> '' then
      PayRateTypeID := tcDataUtils.getpayrateId(GetXMLNodeStringValue(Node, 'PayRateTypeName'));
    if GetXMLNodeStringValue(Node, 'RatetypeName') <> '' then
      RatetypeID := tcDataUtils.getpayratetypeId(GetXMLNodeStringValue(Node, 'RatetypeName'));
    if GetXMLNodeStringValue(Node, 'SalesRef') <> '' then
      SalesID := tcDataUtils.GetId(GetXMLNodeStringValue(Node, 'SalesRef'), 'SalesID', 'tblSales');
    if GetXMLNodeStringValue(Node, 'SaleLineRef') <> '' then
      SaleLineID := tcDataUtils.GetId(GetXMLNodeStringValue(Node, 'SaleLineRef'), 'SaleLineID',
        'tblsaleslines');
    if GetXMLNodeStringValue(Node, 'TimesheetEntryRef') <> '' then
      TimesheetEntryID := tcDataUtils.GetId(GetXMLNodeStringValue(Node, 'TimesheetEntryRef'),
        'TimesheetEntryID', 'tbltimesheetentry');
  end
  else begin
    SetPropertyFromNode(Node, 'EmployeeID');
    SetPropertyFromNode(Node, 'JobID');
    SetPropertyFromNode(Node, 'ServiceID');
    SetPropertyFromNode(Node, 'ClassID');
    SetPropertyFromNode(Node, 'PartID');
    SetPropertyFromNode(Node, 'PayRateTypeID');
    SetPropertyFromNode(Node, 'RatetypeID');
    SetPropertyFromNode(Node, 'SalesID');
    SetPropertyFromNode(Node, 'SaleLineID');
    SetPropertyFromNode(Node, 'TimesheetEntryID');
  end;
  SetPropertyFromNode(Node, 'AppointmentID');
  SetPropertyFromNode(Node, 'RosterID');
  SetDateTimePropertyFromNode(Node, 'SignatureTime');
  SetPropertyFromNode(Node, 'ContactName');
  SetDateTimePropertyFromNode(Node, 'TimeSheetDate');
  SetDateTimePropertyFromNode(Node, 'ServiceDate');
  SetPropertyFromNode(Node, 'Hours');
  SetPropertyFromNode(Node, 'Job');
  SetPropertyFromNode(Node, 'Total');
  SetPropertyFromNode(Node, 'EmployeeName');
  SetPropertyFromNode(Node, 'LabourCost');
  SetPropertyFromNode(Node, 'ClassName');
  SetPropertyFromNode(Node, 'ServiceName');
  SetPropertyFromNode(Node, 'ChargeRate');
  SetPropertyFromNode(Node, 'PartName');
  SetPropertyFromNode(Node, 'PartsDescription');
  SetBooleanPropertyFromNode(Node, 'UseTimeCost');
  SetPropertyFromNode(Node, 'Tax');
  SetPropertyFromNode(Node, 'PayRateTypeName');
  SetPropertyFromNode(Node, 'RatetypeName');
  SetPropertyFromNode(Node, 'Area');
  SetPropertyFromNode(Node, 'HourlyRate');
  SetBooleanPropertyFromNode(Node, 'SuperInc');
  SetPropertyFromNode(Node, 'SuperAmount');
  SetPropertyFromNode(Node, 'Notes');
  SetPropertyFromNode(Node, 'InvoiceNotes');
  SetPropertyFromNode(Node, 'WorkOrderCouponID');
  SetBooleanPropertyFromNode(Node, 'Allowedit');
  SetBooleanPropertyFromNode(Node, 'Active');
  SetPropertyFromNode(Node, 'OverheadRate');
end;

Function TTimeSheet.ValidateXMLData(Const Node: IXMLNode): Boolean;
var
  fiEmployeeID: integer;
  fiJobID: integer;
  fiClassID: integer;
  fiServiceID: integer;
  fiPartID: integer;
  fiPayRateTypeID: integer;
  fiRatetypeID: integer;
  fiSalesID: integer;
  fiSaleLineID: integer;
  fiTimesheetEntryID: integer;
begin
  Result := inherited ValidateXMLData(Node);
  if not Result then
    Exit;
  if not ImportingFromXMLFile then
    Exit;

  if GetXMLNodeIntegerValue(Node, 'ImportingID') <> 0 then
    XMLSearchRecorddesc := IDFieldName + ' =' +
      IntToStr(GetXMLNodeIntegerValue(Node, 'ImportingID'))
  else
    XMLSearchRecorddesc := IDFieldName + ' =' + IntToStr(GetXMLNodeIntegerValue(Node, IDFieldName));
  XMLSearchRecorddesc := ' and TimeSheetDate = ' + FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat,
    GetXMLNodedatetimeValue(Node, 'TimeSheetDate')) + ' and EmployeeName= ' +
    GetXMLNodeStringValue(Node, 'EmployeeName');

  Result := false;

  if GetXMLNodeStringValue(Node, 'EmployeeName') <> '' then begin
    fiEmployeeID := tcDataUtils.GetEmployeeID(GetXMLNodeStringValue(Node, 'EmployeeName'));
    if fiEmployeeID = 0 then begin
      ErrRecordNotfound('EmployeeName', GetXMLNodeStringValue(Node, 'EmployeeName'));
      Exit;
    end;
  end;
  if GetXMLNodeStringValue(Node, 'Job') <> '' then begin
    fiJobID := TJob.IDToggle(GetXMLNodeStringValue(Node, 'Job'), Connection.Connection);
    if fiJobID = 0 then begin
      ErrRecordNotfound('Job', GetXMLNodeStringValue(Node, 'Job'));
      Exit;
    end;
  end;
  if GetXMLNodeStringValue(Node, 'ServiceName') <> '' then begin
    fiServiceID := tcDataUtils.GetServiceID(GetXMLNodeStringValue(Node, 'ServiceName'));
    if fiServiceID = 0 then begin
      ErrRecordNotfound('ServiceName', GetXMLNodeStringValue(Node, 'ServiceName'));
      Exit;
    end;
  end;
  if GetXMLNodeStringValue(Node, 'ClassName') <> '' then begin
    fiClassID := tcDataUtils.GetDeptID(GetXMLNodeStringValue(Node, 'ClassName'));
    if fiClassID = 0 then begin
      ErrRecordNotfound('ClassName', GetXMLNodeStringValue(Node, 'ClassName'));
      Exit;
    end;
  end;
  if GetXMLNodeStringValue(Node, 'PartName') <> '' then begin
    fiPartID := tcDataUtils.GetProduct(GetXMLNodeStringValue(Node, 'PartName'));
    if fiPartID = 0 then begin
      ErrRecordNotfound('PartName', GetXMLNodeStringValue(Node, 'PartName'));
      Exit;
    end;
  end;
  if GetXMLNodeStringValue(Node, 'PayRateTypeName') <> '' then begin
    fiPayRateTypeID := tcDataUtils.getpayrateId(GetXMLNodeStringValue(Node, 'PayRateTypeName'));
    if fiPayRateTypeID = 0 then begin
      ErrRecordNotfound('PayRateTypeName', GetXMLNodeStringValue(Node, 'PayRateTypeName'));
      Exit;
    end;
  end;
  if GetXMLNodeStringValue(Node, 'RatetypeName') <> '' then begin
    fiRatetypeID := tcDataUtils.getpayratetypeId(GetXMLNodeStringValue(Node, 'RatetypeName'));
    if fiRatetypeID = 0 then begin
      ErrRecordNotfound('RatetypeName', GetXMLNodeStringValue(Node, 'RatetypeName'));
      Exit;
    end;
  end;
  if GetXMLNodeStringValue(Node, 'SalesRef') <> '' then begin
    fiSalesID := tcDataUtils.GetId(GetXMLNodeStringValue(Node, 'SalesRef'), 'SalesID', 'tblSales');
    if fiSalesID = 0 then begin
      ErrRecordNotfound('SalesRef', GetXMLNodeStringValue(Node, 'SalesRef'));
      Exit;
    end;
  end;
  if GetXMLNodeStringValue(Node, 'SaleLineRef') <> '' then begin
    fiSaleLineID := tcDataUtils.GetId(GetXMLNodeStringValue(Node, 'SaleLineRef'), 'SaleLineID',
      'tblsaleslines');
    if fiSaleLineID = 0 then begin
      ErrRecordNotfound('SaleLineRef', GetXMLNodeStringValue(Node, 'SaleLineRef'));
      Exit;
    end;
  end;
  if GetXMLNodeStringValue(Node, 'TimesheetEntryRef') <> '' then begin
    fiTimesheetEntryID := tcDataUtils.GetId(GetXMLNodeStringValue(Node, 'TimesheetEntryRef'),
      'TimesheetEntryID', 'tbltimesheetentry');
    if fiTimesheetEntryID = 0 then begin
      ErrRecordNotfound('TimesheetEntryRef', GetXMLNodeStringValue(Node, 'TimesheetEntryRef'));
      Exit;
    end;
  end;
  LocateXMLRecord;
end;

class function TTimeSheet._Schema: string;
begin
  Result := inherited;
  TBOSchema.AddRefType(Result, 'TEmployee', 'EmpObj', 'EmployeeID', 'ID');
  TBOSchema.AddRefType(Result, 'TEmployee', 'EmpObj', 'EmployeeName', 'EmployeeName');
  TBOSchema.AddRefType(Result, 'TCustomer', 'CustomerObj', 'JobId', 'ID');
  TBOSchema.AddRefType(Result, 'TCustomer', 'CustomerObj', 'Job', 'ClientName');
  TBOSchema.AddRefType(Result, 'TDeptClass', 'DeptClassObj', 'TimeSheetClassID', 'ID');
  TBOSchema.AddRefType(Result, 'TDeptClass', 'DeptClassObj', 'TimeSheetClassName', 'DeptClassName');
  TBOSchema.AddRefType(Result, 'TCustomerEquipment','CustEquipObj','CustomerEquipId','Id');
  TBOSchema.AddRefType(Result, 'TServices', 'ServicesObj', 'ServiceId', 'ID');
  TBOSchema.AddRefType(Result, 'TServices', 'ServicesObj', 'ServiceName', 'ServiceDesc');
  TBOSchema.AddRefType(Result, 'TProductWeb', 'ProductObj', 'PartID', 'ID');
  TBOSchema.AddRefType(Result, 'TProductWeb', 'ProductObj', 'PartName', 'ProductName');
  TBOSchema.AddRefType(Result, 'TCustomerEquipment', 'CustEquipObj', 'CustomerEquipmentID', 'ID');
  TBOSchema.AddRefType(Result, 'TTimesheetEntryBase', 'TimeSheetEntryObj', 'TimeSheetEntryId', 'ID');

end;

function TTimeSheet.Save: Boolean;
begin
  ResultStatus.Clear;
  Result := Inherited Save;
  if not result then Exit;
  result := ValidateData;
end;

procedure TTimeSheet.SaveToXMLNode(Const Node: IXMLNode);
begin
  if not SavingXMLTofile then begin
    AddXMLNode(Node, 'EmployeeID', EmployeeID);
    AddXMLNode(Node, 'JobID', JobID);
    AddXMLNode(Node, 'ClassID', TimeSheetClassID);
    AddXMLNode(Node, 'ServiceID', ServiceID);
    AddXMLNode(Node, 'PartID', PartID);
    AddXMLNode(Node, 'PayRateTypeID', PayRateTypeID);
    AddXMLNode(Node, 'RatetypeID', RatetypeID);
    AddXMLNode(Node, 'SalesID', SalesID);
    AddXMLNode(Node, 'SaleLineID', SaleLineID);
    AddXMLNode(Node, 'TimesheetEntryID', TimesheetEntryID);
  end
  else begin
    AddXMLNode(Node, 'SalesRef', tcDataUtils.getGlobalref('tblSales', 'SalesID', SalesID));
    AddXMLNode(Node, 'SaleLineRef', tcDataUtils.getGlobalref('tblsaleslines', 'SaleLineID',
      SaleLineID));
    AddXMLNode(Node, 'TimesheetEntryRef', tcDataUtils.getGlobalref('tbltimesheetentry',
      'TimesheetEntryID', TimesheetEntryID));
  end;
  AddXMLNode(Node, 'AppointmentID', AppointmentID);
  AddXMLNode(Node, 'RosterID', RosterID);
  AddXMLNode(Node, 'TimeSheetDate', TimeSheetDate);
  AddXMLNode(Node, 'SignatureTime', SignatureTime);
  AddXMLNode(Node, 'ContactName', ContactName);
  AddXMLNode(Node, 'ServiceDate', ServiceDate);
  AddXMLNode(Node, 'Hours', Hours);
  AddXMLNode(Node, 'Job', Job);
  AddXMLNode(Node, 'Total', Total);
  AddXMLNode(Node, 'EmployeeName', EmployeeName);
  AddXMLNode(Node, 'LabourCost', LabourCost);
  AddXMLNode(Node, 'ClassName', TimeSheetClassName);
  AddXMLNode(Node, 'ServiceName', ServiceName);
  AddXMLNode(Node, 'ChargeRate', ChargeRate);
  AddXMLNode(Node, 'PartName', PartName);
  AddXMLNode(Node, 'PartsDescription', PartsDescription);
  AddXMLNode(Node, 'UseTimeCost', UseTimeCost);
  AddXMLNode(Node, 'Tax', Tax);
  AddXMLNode(Node, 'PayRateTypeName', PayRateTypeName);
  AddXMLNode(Node, 'RatetypeName', RatetypeName);
  AddXMLNode(Node, 'Area', Area);
  AddXMLNode(Node, 'HourlyRate', HourlyRate);
  AddXMLNode(Node, 'SuperInc', SuperInc);
  AddXMLNode(Node, 'SuperAmount', SuperAmount);
  AddXMLNode(Node, 'Notes', Notes);
  AddXMLNode(Node, 'Active', Active);
  AddXMLNode(Node, 'Allowedit', Allowedit);
  AddXMLNode(Node, 'InvoiceNotes', InvoiceNotes);
  AddXMLNode(Node, 'WorkOrderCouponID', WorkOrderCouponID);
  AddXMLNode(Node, 'OverheadRate', OverheadRate);
  inherited;
end;

procedure TTimeSheet.New;
begin
  (* self.fSQLSelect := 'ID = 0'; *)
  inherited;
end;

{ ========================================================
  TTimesheetEntryBase
  ======================================================== }
constructor TTimesheetEntryBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tbltimesheetentry';
  fIsChild := true;
  ExportExcludeList.Add('typeid');
  fRepairObjtoallocatetoRepair:= nil;
end;

destructor TTimesheetEntryBase.Destroy;
begin
  FreeAndNil(ftimeSheet);
  FreeAndNil(fTimeSheetByreapirID);
  inherited;
end;

procedure TTimesheetEntryBase.LoadFromXMLNode(Const Node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(Node, 'Entrydate');
  SetPropertyFromNode(Node, 'TypeName');
  SetPropertyFromNode(Node, 'Whoentered');
  ExportsubClasses(Node);
end;

procedure TTimesheetEntryBase.SaveToXMLNode(Const Node: IXMLNode);
begin
  inherited;
  AddXMLNode(Node, 'Entrydate', EntryDate);
  AddXMLNode(Node, 'TypeName', TypeName);
  AddXMLNode(Node, 'Whoentered', WhoEntered);
  ExportsubClasses(Node);
end;

function TTimesheetEntryBase.ValidateData: Boolean;
begin
  ResultStatus.Clear;
  AllTimeSheetValid := true;
  TimeSheet.IterateRecords(ValidateDatacallback);
  Result := AllTimeSheetValid;
end;

function TTimesheetEntryBase.Save: Boolean;
begin
  ResultStatus.Clear;
  PostDB;
  AllTimeSheetSaved := true;
  TimeSheet.IterateRecords(SaveDataCallback);
  Result := AllTimeSheetSaved;
  if not result then exit;
  Result := Inherited Save;
end;

procedure TTimesheetEntryBase.SaveDataCallback(const Sender: TBusObj;
  var Abort: Boolean);
begin
  if not(Sender is TTimeSheet) then
    Exit;
  AllTimeSheetSaved := TTimeSheet(Sender).Save;
  if not AllTimeSheetSaved then
    Abort := true;
end;

procedure TTimesheetEntryBase.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  FreeAndNil(ftimeSheet);
  FreeAndNil(fTimeSheetByreapirID);
end;

procedure TTimesheetEntryBase.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = false then
      Exit; // we are only interested in data fields.
  inherited;

end;

Function TTimesheetEntryBase.GetSQL: String;
begin
  Result := Inherited GetSQL;
end;

class function TTimesheetEntryBase.GetIDField: String;
begin
  Result := 'Timesheetentryid'
end;

class function TTimesheetEntryBase.GetBusObjectTablename: string;
begin
  Result := 'tbltimesheetentry';
end;

Function TTimesheetEntryBase.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then
    Exit;
End;

Function TTimesheetEntryBase.ExportsubClasses(Const Node: IXMLNode): Boolean;
begin
  self.TimeSheet.XMLPropertyNode := Node.AddChild('TimesheetEntries');
  self.TimeSheet.XMLPropertyName := 'TimesheetEntry';
  self.TimeSheet.IterateRecords(GetPropertyXMLCallback);
  Result := true;
end;

Function TTimesheetEntryBase.ImportsubClasses(const Node: IXMLNode): Boolean;
var
  x: integer;
  Singlerec: IXMLNode;
begin
  Result := false;
  ImportFailed := false;
  XMLPropertyName := 'Timeentries';
  XMLPropertyNode := Node.ChildNodes.FindNode(XMLPropertyName);
  if assigned(XMLPropertyNode) then begin
    for x := 0 to XMLPropertyNode.ChildNodes.count - 1 do begin
      TimeSheet.ImportingFromXMLFile := true;
      Singlerec := XMLPropertyNode.ChildNodes[x];
      TimeSheet.ImportFromXML(Singlerec);
      ImportFailed := TimeSheet.ImportFailed;
      if Error then
        Exit;
    end;
  end;
end;

Function TTimesheetEntryBase.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then    Exit;
  WhoEntered := Appenv.employee.Employeename;
  if assigned(self.Owner) then
    if self.Owner is TRepairs then begin
      TRepairs(self.Owner).PostDB;
      TypeId := TRepairs(self.Owner).ID;
      TypeName := 'Repair';
    end;
End;

function TTimesheetEntryBase.GetTimeSheet: TTimeSheet;
begin
  if not assigned(ftimeSheet) then begin
    ftimeSheet := TTimeSheet.Create(self);
    if assigned(self.Connection) then
      ftimeSheet.Connection := self.Connection;
  end;
  if (ftimeSheet.Dataset.Active = false) or
    (ftimeSheet.SQLselect <> 'T.TimesheetEntryID =  ' + IntToStr(self.ID)) then
    ftimeSheet.LoadSelect('T.TimesheetEntryID =  ' + IntToStr(self.ID));
  Result := ftimeSheet;
  (* REsult :=  TTimeSheet(getContainerComponent(TTimeSheet , 'T.TimesheetEntryID =  ' + IntToStr(Self.ID))); *)
end;

function TTimesheetEntryBase.GetTimeSheetByreapirID: TTimeSheet;
begin
  if not assigned(fTimeSheetByreapirID) then begin
    fTimeSheetByreapirID := TTimeSheet.Create(self);
    if assigned(self.Connection) then
      fTimeSheetByreapirID.Connection := self.Connection;
  end;
  if (fTimeSheetByreapirID.Dataset.Active = false) or
    (fTimeSheetByreapirID.SQLselect <> 'T.TimesheetEntryID =  ' + IntToStr(self.ID)) or
    (fTimeSheetByreapirID.SQLOrder <> 'T.REpairID') then begin
    fTimeSheetByreapirID.SQLOrder :=  'T.REpairID';
    fTimeSheetByreapirID.LoadSelect('T.TimesheetEntryID =  ' + IntToStr(self.ID));
    end;
  Result := fTimeSheetByreapirID;
end;

function TTimesheetEntryBase.GetTotalAmountInc: double;
begin
  Result := fldTotalInc;
end;

{ Property functions }
Function TTimesheetEntryBase.GetEntrydate: TDateTime;
begin
  Result := GetDateTimeField('Entrydate');
End;

Function TTimesheetEntryBase.GetType: String;
begin
  Result := GetStringField('Type');
End;

Function TTimesheetEntryBase.GetTypeid: integer;
begin
  Result := GetIntegerField('Typeid');
End;

Function TTimesheetEntryBase.GetWhoentered: String;
begin
  Result := GetStringField('Whoentered');
End;

Procedure TTimesheetEntryBase.SetEntrydate(Const Value: TDateTime);
begin
  SetDateTimeField('Entrydate', Value);
End;

Procedure TTimesheetEntryBase.SetType(Const Value: String);
begin
  SetStringField('Type', Value);
End;

Procedure TTimesheetEntryBase.SetTypeid(Const Value: integer);
begin
  SetIntegerField('Typeid', Value);
End;

Procedure TTimesheetEntryBase.SetWhoentered(Const Value: String);
begin
  SetStringField('Whoentered', Value);
End;

procedure TTimesheetEntryBase.ValidateDatacallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TTimeSheet) then
    Exit;
  AllTimeSheetValid := TTimeSheet(Sender).ValidateData;
  if not AllTimeSheetValid then
    Abort := true;
end;

class function TTimesheetEntryBase._Schema: string;
begin
  Result := inherited;
  TBOSchema.AddRefType(Result, 'TEmployee', 'EmpObj', 'WhoEntered', 'EmployeeName');
end;

function TTimeSheet.EmployeeHasSuper: Boolean;
var
  strSQL: String;
begin
  strSQL := 'SELECT Super FROM tblemployeepayrates' + ' inner join tblPayRateType on ' +
    ' tblPayRateType.typeId =  tblemployeepayrates.typeId ' +
    ' and tblPayRateType.Description in ( "Hourly Rate" ,  "CDEP")' + ' inner join tblPayRates  on '
    + ' tblPayRates.RateId = tblemployeepayrates.PayrateID ' +
    ' and tblPayRates.Description = "Normal Hours"' + ' Where Super = "T" and EmployeeId = ' +
    IntToStr(employeeID);
  with getNewDataset(strSQL, true) do
    try
      Result := recordcount > 0;
    finally
      if Active then
        close;
      Free;
    end;
end;

function TTimeSheet.EmployeeAward: integer;
var
  strSQL: String;
begin
  Result := 0;
  strSQL := 'select Award from tblemployees where  EmployeeId = ' + IntToStr(ID);
  with getNewDataset(strSQL, true) do
    try
      if recordcount > 0 then
        Result := fieldByname('Award').asInteger;
    finally
      if Active then
        close;
      Free;
    end;
end;

function TTimeSheet.EmployeePayRateForNormalHours: Double;
var
  strSQL: String;
begin
  Result := 0;
  strSQL := 'Select Hourlyrate from tblemployeepayrates ' + ' where employeeId =  ' +
    IntToStr(EmployeeID) +
    ' and typeid in (Select typeid from tblpayratetype where Description = "Hourly Rate")' +
    ' and PayRateID in (Select RateId  from tblpayrates where Description = "Normal Hours")';
  with getNewDataset(strSQL, true) do
    try
      if recordcount > 0 then
        Result := fieldByname('Hourlyrate').asfloat;
    finally
      if Active then
        close;
      Free;
    end;

end;

procedure TTimesheetEntryBase.CalctotalCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TTimeSheet) then
    Exit;
  fdtotal := fdtotal + TTimeSheet(Sender).Total;
  fldTotalInc := fldTotalInc + TTimeSheet(Sender).TotalInc;
  fdHours := fdHours + TTimeSheet(Sender).Hours;
  fdtotalService := fdtotalService + TTimeSheet(Sender).TotalServicecharge;
  fdtotalQy := fdtotalQy + TTimeSheet(Sender).Quantity;
  fdTotalAdjusted := fdTotalAdjusted + TTimeSheet(Sender).TotalAdjusted;
end;

procedure TTimesheetEntryBase.CalctotalAmount;
begin
  CalcTimesheetTotal;
  sendEvent(BusObjEvent_Change, BusObjEventVal_Total);
end;

procedure TTimeSheet.CalctotalAmount;
begin
  if assigned(self.Owner) then
    if self.Owner is TTimesheetEntryBase then
      TTimesheetEntryBase(self.Owner).CalctotalAmount;

end;

procedure TTimesheetEntryBase.allocatetoRepair;
begin
  try
    TimeSheetByreapirID.IterateRecords(allocatetoRepairCallback);
  finally
      TimeSheetByreapirID.UserLock.Unlock('TimeSheet Allocation');
     Freeandnil(fRepairObjtoallocatetoRepair);
  end;
end;
Procedure  TTimesheetEntryBase.RepairObjtoallocatetoRepair(const fiRepairID:Integer);
begin
   if fRepairObjtoallocatetoRepair = nil then begin
    fRepairObjtoallocatetoRepair := TRepairs.Create(self);
    TRepairs(fRepairObjtoallocatetoRepair).Connection := Self.Connection;
    TRepairs(fRepairObjtoallocatetoRepair).Load(fiRepairID);
    fRepairObjtoallocatetoRepair.LockGroupName := 'TimeSheet Allocation';
   end;
   if TRepairs(fRepairObjtoallocatetoRepair).Id <> firepairId then
    TRepairs(fRepairObjtoallocatetoRepair).Load(fiRepairID);
   TRepairs(fRepairObjtoallocatetoRepair).NewTimesheetEntry;
end;
procedure TTimesheetEntryBase.allocatetoRepairCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
    if not (Sender is TTimeSheet) then exit;
    if TTimeSheet(Sender).RepairId =0 then exit;
    RepairObjtoallocatetoRepair(TTimeSheet(Sender).RepairId);

    if fRepairObjtoallocatetoRepair = nil then exit;
    if not (fRepairObjtoallocatetoRepair is TRepairs) then exit;
    With TRepairs(fRepairObjtoallocatetoRepair) do begin
          if count =0 then exit;
          if userlock.Lock(BusObjectTableName , Id , LockGroupName) = False then exit;
          TTimeSheet(Sender).TimesheetEntryID :=TimesheetEntry.ID;
          TTimeSheet(Sender).JobID :=  ClientID;
          TTimeSheet(Sender).Job := CustomerName;
          if TTimeSheet(Sender).EquipmentName <> '' then begin
            TTimeSheet(Sender).CustomerEquipmentID := repairCustomerEquipmentIDforEquip(TTimeSheet(Sender).EquipmentName);
          end else begin
            TTimeSheet(Sender).Notes :='Equipment : ' +TTimeSheet(Sender).EquipmentName + NL+ TTimeSheet(Sender).Notes;
            TTimeSheet(Sender).EquipmentName :='';
          end;
    end;
    TTimeSheet(Sender).PostDB;
end;
procedure TTimesheetEntryBase.CalcTimesheetTotal;
begin
  fdtotal := 0;
  fdHours := 0;
  fdtotalService := 0;
  fdtotalQy := 0;
  fdTotalAdjusted := 0;
  fldTotalInc := 0;
  TimeSheet.IterateRecords(CalctotalCallback);
end;

function TTimeSheet.getTotalServicecharge: Double;
begin
  Result := GetFloatField('TotalServicecharge');
end;

procedure TTimeSheet.SetTotalServicecharge(const Value: Double);
begin
  SetFloatField('TotalServicecharge', Value);
end;
Function TTimeSheet.IsFixedService:Boolean;
begin
  with GetNewDataset('Select IsFixed from tblpaysemployeeservices where Servicename = ' + Quotedstr(Servicename) +' and employeeId = ' + inttostr(EmployeeID), true) do try
    result:= fieldByname('IsFixed').asBoolean;
  finally
    if active then close;
    free;
  end;
end;
procedure TTimeSheet.calcServicecharge;
begin
  if IsFixedService then
    TotalServicecharge := ChargeRate
  else
    TotalServicecharge := Quantity * ChargeRate;
  CalctotalAmount;
end;

function TTimeSheet.getQuantity: Double;
begin
  Result := GetFloatField('Qty');
end;

function TTimeSheet.GetRepairGlobalRef: string;
begin
  if RepairId > 0 then
    result := TRepairs.IDGlobalRefToggle(RepairId, Connection.Connection)
  else
    result := '';
end;

procedure TTimeSheet.setQuantity(const Value: Double);
begin
  SetFloatField('Qty', Value);
end;

procedure TTimeSheet.SetRepairGlobalRef(const Value: string);
begin
  if Value <> '' then begin
    RepairId := TRepairs.IDGlobalRefToggle(Value, Connection.Connection);
    if RepairId = 0 then
      RepairId := -1;
  end
  else
    RepairId := 0;
end;

function TTimeSheet.getServiceDate: TDateTime;
begin
  Result := GetDateTimeField('ServiceDate');
end;

procedure TTimeSheet.setServiceDate(const Value: TDateTime);
begin
  SetDateTimeField('ServiceDate', Value);
end;

function TTimeSheet.getCustomerEquipmentID: integer;begin  Result := GetIntegerField('CustomerEquipmentID');end;
//function TTimeSheet.getCustomerEquipID    : integer;begin  Result := GetIntegerField('CustomerEquipmentID');end;

procedure TTimeSheet.setCustomerEquipmentID(const Value: integer);begin  SetIntegerField('CustomerEquipmentID', Value);end;
//procedure TTimeSheet.SetCustomerEquipID    (const Value: integer);begin  SetIntegerField('CustomerEquipmentID', Value);end;

function TTimeSheet.getEquipmentName: String;
begin
  Result := GetStringField('Equipment')
end;

function TTimeSheet.getRepairId: integer;
begin
  Result := GetIntegerField('RepairId');
end;

function TTimeSheet.GetRosterGlobalRef: string;
begin
  if RosterID > 0then
    result :=  TRoster.IDGlobalRefToggle(RosterID, Connection.Connection)
  else
    result := '';
end;
function TTimeSheet.GetInvoiceNotes: string;
begin
  Result := GetStringField('InvoiceNotes');
end;
function TTimeSheet.GetWorkOrderCouponID: string;
begin
  Result := GetStringField('WorkOrderCouponID');
end;

function TTimeSheet.getRosterID: integer;
begin
  Result := GetIntegerField('RosterID');
end;


procedure TTimeSheet.SetEquipmentName(const Value: String);
begin
  SetStringField('Equipment', Value);
end;

procedure TTimeSheet.setRepairId(const Value: integer);
begin
  SetIntegerField('RepairId', Value);
end;

procedure TTimeSheet.SetRosterGlobalRef(const Value: string);
begin
  if Value <> '' then begin
    RosterID := TRoster.IDGlobalRefToggle(Value, Connection.Connection);
    if RosterID = 0 then
      RosterID := -1;
  end
  else
    RosterID:= 0;
end;
procedure TTimeSheet.SetInvoiceNotes(const Value: string);
begin
  SetStringfield('InvoiceNotes' , value);
end;
procedure TTimeSheet.SetWorkOrderCouponID(const Value: string);
begin
  SetStringfield('WorkOrderCouponID' , value);
end;

procedure TTimeSheet.setRosterID(const Value: integer);
begin
  SetIntegerField('RosterID', Value);
end;

function TTimeSheet.getAppointmentID: integer;
begin
  Result := GetIntegerField('AppointmentID')
end;

procedure TTimeSheet.setAppointmentID(const Value: integer);
begin
  SetIntegerField('AppointmentID', Value);
end;

procedure TTimeSheet.Invoice(InvoiceObj: TInvoice; curDeptId: integer);
begin
  if count = 0 then
    Exit;
  First;
  While Eof = false do begin
    if TimeSheetClassID = curDeptId then begin
      InvoiceObj.Lines.New;
      InvoiceObj.Lines.ProductName := PART_LABOUR;
      InvoiceObj.Lines.ProductDescription := ServiceName + ':' + FloatToStr(Hours) + ' hr(s)' + '-['
        + FloatToStrF(ChargeRate, ffCurrency, 15, CurrencyRoundPlaces) + '(Inc) per hour]';
      InvoiceObj.Lines.UnitOfMeasure := AppEnv.DefaultClass.DefaultUOM;
      InvoiceObj.Lines.UOMQtySold := 1;
      InvoiceObj.Lines.UOMQtyShipped := 1;
      InvoiceObj.Lines.LinePrice := GetAmountEx(TotalServicecharge, InvoiceObj.Lines.LineTaxRate);
      InvoiceObj.Lines.PostDB;
    end;
    Next;
  end;
end;

function TTimeSheet.getTimeSheetEntryDesc: String;
begin
  Result := '';
  if assigned(self.Owner) then
    if self.Owner is TTimesheetEntryBase then
      Result := TTimesheetEntryBase(self.Owner).TypeName + '#' +
        IntToStr(TTimesheetEntryBase(self.Owner).TypeId);
end;

function TTimeSheet.getprocessparttimesheetID: integer;
begin
  Result := GetIntegerField('processparttimesheetID');
end;

procedure TTimeSheet.setprocessparttimesheetID(const Value: integer);
begin
  SetIntegerField('processparttimesheetID', Value);
end;

  {TTimesheetDetails}

constructor TTimesheetDetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'TimesheetDetails';
  fSQL := 'SELECT * FROM tbltimesheetdetails';
  fIsList := true;
end;


destructor TTimesheetDetails.Destroy;
begin
  inherited;
end;


procedure TTimesheetDetails.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TimesheetId');
  SetPropertyFromNode(node,'TimeSheetEntryID');
  SetPropertyFromNode(node,'Company_ID');
  SetPropertyFromNode(node,'Company');
  SetPropertyFromNode(node,'Worker_ID');
  SetPropertyFromNode(node,'Worker');
  SetPropertyFromNode(node,'Dept_ID');
  SetPropertyFromNode(node,'Dept');
  SetPropertyFromNode(node,'Org');
  SetPropertyFromNode(node,'Job_Number');
  SetPropertyFromNode(node,'Job_Name');
  SetPropertyFromNode(node,'Pay_Component');
  SetPropertyFromNode(node,'Rate');
  SetPropertyFromNode(node,'Rate_Number');
  SetPropertyFromNode(node,'Hours');
  SetPropertyFromNode(node,'Units');
  SetDateTimePropertyFromNode(node,'Line_Date');
  SetPropertyFromNode(node,'Amount');
  SetPropertyFromNode(node,'Check_Seq_Number');
  SetPropertyFromNode(node,'Override_State');
  SetPropertyFromNode(node,'Override_Local');
  SetPropertyFromNode(node,'Override_Local_Jurisdiction');
  SetPropertyFromNode(node,'Labor_Override');
  SetPropertyFromNode(node,'Check_Template');
  SetPropertyFromNode(node,'Output_Type');
  SetPropertyFromNode(node,'Net_Pay');
  SetPropertyFromNode(node,'Check_Number');
  SetPropertyFromNode(node,'FIT_Amt');
  SetPropertyFromNode(node,'SS_Amt');
  SetPropertyFromNode(node,'Medicare_Amt');
  SetPropertyFromNode(node,'Fed_Backup_Withholding_Amt');
  SetPropertyFromNode(node,'State_Tax_Jurisdiction');
  SetPropertyFromNode(node,'SIT_Amount');
  SetPropertyFromNode(node,'SDI_Amt');
  SetPropertyFromNode(node,'Fam_Leave');
  SetPropertyFromNode(node,'Med_Leave');
  SetPropertyFromNode(node,'SUI_Amt');
  SetPropertyFromNode(node,'State_Misc_Amt');
  SetPropertyFromNode(node,'State_Surcharge_Amt');
  SetPropertyFromNode(node,'State_WC_Amt');
  SetPropertyFromNode(node,'State_Transit_Tax');
  SetPropertyFromNode(node,'State_Backup_Withholding_Amt');
  SetPropertyFromNode(node,'State_Allocation_Percent');
  SetPropertyFromNode(node,'Local_Tax_Jurisdiction');
  SetPropertyFromNode(node,'Local_Tax_Name');
  SetPropertyFromNode(node,'Local_Amt');
  SetPropertyFromNode(node,'Local_Allocation_Percent');
  SetBooleanPropertyFromNode(node,'PayChexsynched');
end;


procedure TTimesheetDetails.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TimesheetId' ,TimesheetId);
  AddXMLNode(node,'TimeSheetEntryID' ,TimeSheetEntryID);
  AddXMLNode(node,'Company_ID' ,Company_ID);
  AddXMLNode(node,'Company' ,Company);
  AddXMLNode(node,'Worker_ID' ,Worker_ID);
  AddXMLNode(node,'Worker' ,Worker);
  AddXMLNode(node,'Dept_ID' ,Dept_ID);
  AddXMLNode(node,'Dept' ,Dept);
  AddXMLNode(node,'Org' ,Org);
  AddXMLNode(node,'Job_Number' ,Job_Number);
  AddXMLNode(node,'Job_Name' ,Job_Name);
  AddXMLNode(node,'Pay_Component' ,Pay_Component);
  AddXMLNode(node,'Rate' ,Rate);
  AddXMLNode(node,'Rate_Number' ,Rate_Number);
  AddXMLNode(node,'Hours' ,Hours);
  AddXMLNode(node,'Units' ,Units);
  AddXMLNode(node,'Line_Date' ,Line_Date);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Check_Seq_Number' ,Check_Seq_Number);
  AddXMLNode(node,'Override_State' ,Override_State);
  AddXMLNode(node,'Override_Local' ,Override_Local);
  AddXMLNode(node,'Override_Local_Jurisdiction' ,Override_Local_Jurisdiction);
  AddXMLNode(node,'Labor_Override' ,Labor_Override);
  AddXMLNode(node,'Check_Template' ,Check_Template);
  AddXMLNode(node,'Output_Type' ,Output_Type);
  AddXMLNode(node,'Net_Pay' ,Net_Pay);
  AddXMLNode(node,'Check_Number' ,Check_Number);
  AddXMLNode(node,'FIT_Amt' ,FIT_Amt);
  AddXMLNode(node,'SS_Amt' ,SS_Amt);
  AddXMLNode(node,'Medicare_Amt' ,Medicare_Amt);
  AddXMLNode(node,'Fed_Backup_Withholding_Amt' ,Fed_Backup_Withholding_Amt);
  AddXMLNode(node,'State_Tax_Jurisdiction' ,State_Tax_Jurisdiction);
  AddXMLNode(node,'SIT_Amount' ,SIT_Amount);
  AddXMLNode(node,'SDI_Amt' ,SDI_Amt);
  AddXMLNode(node,'Fam_Leave' ,Fam_Leave);
  AddXMLNode(node,'Med_Leave' ,Med_Leave);
  AddXMLNode(node,'SUI_Amt' ,SUI_Amt);
  AddXMLNode(node,'State_Misc_Amt' ,State_Misc_Amt);
  AddXMLNode(node,'State_Surcharge_Amt' ,State_Surcharge_Amt);
  AddXMLNode(node,'State_WC_Amt' ,State_WC_Amt);
  AddXMLNode(node,'State_Transit_Tax' ,State_Transit_Tax);
  AddXMLNode(node,'State_Backup_Withholding_Amt' ,State_Backup_Withholding_Amt);
  AddXMLNode(node,'State_Allocation_Percent' ,State_Allocation_Percent);
  AddXMLNode(node,'Local_Tax_Jurisdiction' ,Local_Tax_Jurisdiction);
  AddXMLNode(node,'Local_Tax_Name' ,Local_Tax_Name);
  AddXMLNode(node,'Local_Amt' ,Local_Amt);
  AddXMLNode(node,'Local_Allocation_Percent' ,Local_Allocation_Percent);
  AddXMLNode(node,'PayChexsynched' ,PayChexsynched);

end;


function TTimesheetDetails.ValidateData: Boolean ;
begin
  PostDB;
  Resultstatus.Clear;
  Result := True;
end;


function TTimesheetDetails.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
  if not result then exit;
  if TimeSheetEntry.count =0 then begin
    TimeSheetEntry.New;
    TimeSheetEntry.EntryDate := Date;
    TimeSheetEntry.TypeName := 'Payroll';
    TimeSheetEntry.PostDB;
    TimeSheetEntryID := TimeSheetEntry.ID;
  end;
  if (TimesheetId =0) or (TimeSheetEntry.TimeSheet.locate('ID',TimesheetId, [])=False) then  begin
    TimeSheetEntry.TimeSheet.New;
    TimeSheetEntry.TimeSheet.Job                := Company;
    TimeSheetEntry.TimeSheet.EmployeeName       := Worker;
    TimeSheetEntry.TimeSheet.TimeSheetClassName := Dept;
    TimeSheetEntry.TimeSheet.ServiceDate        := Line_Date;
    TimeSheetEntry.TimeSheet.ChargeRate         := Rate;
    TimeSheetEntry.TimeSheet.Quantity           := Hours;
    TimeSheetEntry.TimeSheet.HourlyRate         := Rate;
    TimeSheetEntry.TimeSheet.PostDB;
    TimesheetId :=TimeSheetEntry.TimeSheet.ID;
  end;
end;


procedure TTimesheetDetails.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TTimesheetDetails.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = false then
      Exit; // we are only interested in data fields.
  inherited;
  if sametext(Sender.fieldname , 'Company_ID') then begin
    if Company_ID <> 0 then begin
      Company := TClient.IDToggle(Company_ID);
    end;
  end else if sametext(Sender.fieldname , 'Company') then begin
    Company_ID := TClient.IDToggle(Company);
    DoFieldOnChange(Dataset.findfield('Company_ID'));
  end else if sametext(Sender.fieldname , 'Worker_ID') then begin
    if Worker_ID <> 0 then begin
      Worker := TEmployee.IDToggle(Worker_ID);
    end;
  end else if sametext(Sender.fieldname , 'Worker') then begin
    Worker_ID := TEmployee.IDToggle(Worker);
    DoFieldOnChange(Dataset.findfield('Worker_ID'));
  end else if sametext(Sender.fieldname , 'Dept_ID') then begin
    if Dept_ID <> 0 then begin
      Dept := TDeptClass.IDToggle(Dept_ID);
    end;
  end else if sametext(Sender.fieldname , 'Dept') then begin
    Dept_ID := TDeptClass.IDToggle(Dept);
    DoFieldOnChange(Dataset.findfield('Dept_ID'));
  end;
end;


function TTimesheetDetails.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TTimesheetDetails.GetIDField: string;
begin
  Result := 'ID'
end;


class function TTimesheetDetails.GetBusObjectTablename: string;
begin
  Result:= 'tbltimesheetdetails';
end;


function TTimesheetDetails.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) and (Owner is TTimesheetEntryDetails) then
    TimeSheetEntryID :=TTimesheetEntryDetails(Owner).Id
  else if Assigned(Owner) and (Owner is TTimesheet) then
    TimesheetId :=TTimesheet(Owner).Id;
  Dept_Id := AppEnv.DefaultClass.ClassId;
end;

function TTimesheetDetails.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TTimesheetDetails.getTimeSheetEntry: TTimesheetEntryDetails;
begin
  if Assigned(Owner) and (Owner is TTimesheetEntryDetails) then
    Result := TTimesheetEntryDetails(Owner)
  else REsult :=  TTimesheetEntryDetails(getContainerComponent(TTimesheetEntryDetails , 'TimesheetEntryID =  ' + IntToStr(TimeSheetEntryID)));
end;


{Property Functions}
function  TTimesheetDetails.GetTimesheetId                 : Integer   ; begin Result := GetIntegerField('TimesheetId');end;
function  TTimesheetDetails.GetTimeSheetEntryID            : Integer   ; begin Result := GetIntegerField('TimeSheetEntryID');end;
function  TTimesheetDetails.GetCompany_ID                  : Integer   ; begin Result := GetIntegerField('Company_ID');end;
function  TTimesheetDetails.GetCompany                     : string    ; begin Result := GetStringField('Company');end;
function  TTimesheetDetails.GetWorker_ID                   : Integer   ; begin Result := GetIntegerField('Worker_ID');end;
function  TTimesheetDetails.GetWorker                      : string    ; begin Result := GetStringField('Worker');end;
function  TTimesheetDetails.GetDept_ID                     : Integer   ; begin Result := GetIntegerField('Dept_ID');end;
function  TTimesheetDetails.GetDept                        : string    ; begin Result := GetStringField('Dept');end;
function  TTimesheetDetails.GetOrg                         : string    ; begin Result := GetStringField('Org');end;
function  TTimesheetDetails.GetJob_Number                  : string    ; begin Result := GetStringField('Job_Number');end;
function  TTimesheetDetails.GetJob_Name                    : string    ; begin Result := GetStringField('Job_Name');end;
function  TTimesheetDetails.GetPay_Component               : string    ; begin Result := GetStringField('Pay_Component');end;
function  TTimesheetDetails.GetRate                        : Double    ; begin Result := GetFloatField('Rate');end;
function  TTimesheetDetails.GetRate_Number                 : Double    ; begin Result := GetFloatField('Rate_Number');end;
function  TTimesheetDetails.GetHours                       : Double    ; begin Result := GetFloatField('Hours');end;
function  TTimesheetDetails.GetUnits                       : Integer   ; begin Result := GetIntegerField('Units');end;
function  TTimesheetDetails.GetLine_Date                   : TDateTime ; begin Result := GetDateTimeField('Line_Date');end;
function  TTimesheetDetails.GetAmount                      : Double    ; begin Result := GetFloatField('Amount');end;
function  TTimesheetDetails.GetCheck_Seq_Number            : Integer   ; begin Result := GetIntegerField('Check_Seq_Number');end;
function  TTimesheetDetails.GetOverride_State              : string    ; begin Result := GetStringField('Override_State');end;
function  TTimesheetDetails.GetOverride_Local              : string    ; begin Result := GetStringField('Override_Local');end;
function  TTimesheetDetails.GetOverride_Local_Jurisdiction : string    ; begin Result := GetStringField('Override_Local_Jurisdiction');end;
function  TTimesheetDetails.GetLabor_Override              : string    ; begin Result := GetStringField('Labor_Override');end;
function  TTimesheetDetails.GetCheck_Template              : string    ; begin Result := GetStringField('Check_Template');end;
function  TTimesheetDetails.GetOutput_Type                 : Integer   ; begin Result := GetIntegerField('Output_Type');end;
function  TTimesheetDetails.GetNet_Pay                     : Double    ; begin Result := GetFloatField('Net_Pay');end;
function  TTimesheetDetails.GetCheck_Number                : Integer   ; begin Result := GetIntegerField('Check_Number');end;
function  TTimesheetDetails.GetFIT_Amt                     : Double    ; begin Result := GetFloatField('FIT_Amt');end;
function  TTimesheetDetails.GetSS_Amt                      : Double    ; begin Result := GetFloatField('SS_Amt');end;
function  TTimesheetDetails.GetMedicare_Amt                : Double    ; begin Result := GetFloatField('Medicare_Amt');end;
function  TTimesheetDetails.GetFed_Backup_Withholding_Amt  : Double    ; begin Result := GetFloatField('Fed_Backup_Withholding_Amt');end;
function  TTimesheetDetails.GetState_Tax_Jurisdiction      : string    ; begin Result := GetStringField('State_Tax_Jurisdiction');end;
function  TTimesheetDetails.GetSIT_Amount                  : Double    ; begin Result := GetFloatField('SIT_Amount');end;
function  TTimesheetDetails.GetSDI_Amt                     : Double    ; begin Result := GetFloatField('SDI_Amt');end;
function  TTimesheetDetails.GetFam_Leave                   : Double    ; begin Result := GetFloatField('Fam_Leave');end;
function  TTimesheetDetails.GetMed_Leave                   : Double    ; begin Result := GetFloatField('Med_Leave');end;
function  TTimesheetDetails.GetSUI_Amt                     : Double    ; begin Result := GetFloatField('SUI_Amt');end;
function  TTimesheetDetails.GetState_Misc_Amt              : Double    ; begin Result := GetFloatField('State_Misc_Amt');end;
function  TTimesheetDetails.GetState_Surcharge_Amt         : Double    ; begin Result := GetFloatField('State_Surcharge_Amt');end;
function  TTimesheetDetails.GetState_WC_Amt                : Double    ; begin Result := GetFloatField('State_WC_Amt');end;
function  TTimesheetDetails.GetState_Transit_Tax           : Double    ; begin Result := GetFloatField('State_Transit_Tax');end;
function  TTimesheetDetails.GetState_Backup_Withholding_Amt: Double    ; begin Result := GetFloatField('State_Backup_Withholding_Amt');end;
function  TTimesheetDetails.GetState_Allocation_Percent    : Double    ; begin Result := GetFloatField('State_Allocation_Percent');end;
function  TTimesheetDetails.GetLocal_Tax_Jurisdiction      : string    ; begin Result := GetStringField('Local_Tax_Jurisdiction');end;
function  TTimesheetDetails.GetLocal_Tax_Name              : string    ; begin Result := GetStringField('Local_Tax_Name');end;
function  TTimesheetDetails.GetLocal_Amt                   : Double    ; begin Result := GetFloatField('Local_Amt');end;
function  TTimesheetDetails.GetLocal_Allocation_Percent    : Double    ; begin Result := GetFloatField('Local_Allocation_Percent');end;
function  TTimesheetDetails.GetPayChexsynched              : Boolean   ; begin Result := GetBooleanField('PayChexsynched');end;

procedure TTimesheetDetails.SetTimesheetId                 (const Value: Integer   ); begin SetIntegerField('TimesheetId'                  , Value);end;
procedure TTimesheetDetails.SetTimeSheetEntryID            (const Value: Integer   ); begin SetIntegerField('TimeSheetEntryID'             , Value);end;
procedure TTimesheetDetails.SetCompany_ID                  (const Value: Integer   ); begin SetIntegerField('Company_ID'                   , Value);end;
procedure TTimesheetDetails.SetCompany                     (const Value: string    ); begin SetStringField('Company'                      , Value);end;
procedure TTimesheetDetails.SetWorker_ID                   (const Value: Integer   ); begin SetIntegerField('Worker_ID'                    , Value);end;
procedure TTimesheetDetails.SetWorker                      (const Value: string    ); begin SetStringField('Worker'                       , Value);end;
procedure TTimesheetDetails.SetDept_ID                     (const Value: Integer   ); begin SetIntegerField('Dept_ID'                    , Value);end;
procedure TTimesheetDetails.SetDept                        (const Value: string    ); begin SetStringField('Dept'                       , Value);end;
procedure TTimesheetDetails.SetOrg                         (const Value: string    ); begin SetStringField('Org'                          , Value);end;
procedure TTimesheetDetails.SetJob_Number                  (const Value: string    ); begin SetStringField('Job_Number'                   , Value);end;
procedure TTimesheetDetails.SetJob_Name                    (const Value: string    ); begin SetStringField('Job_Name'                   , Value);end;
procedure TTimesheetDetails.SetPay_Component               (const Value: string    ); begin SetStringField('Pay_Component'                , Value);end;
procedure TTimesheetDetails.SetRate                        (const Value: Double    ); begin SetFloatField('Rate'                         , Value);end;
procedure TTimesheetDetails.SetRate_Number                 (const Value: Double    ); begin SetFloatField('Rate_Number'                  , Value);end;
procedure TTimesheetDetails.SetHours                       (const Value: Double    ); begin SetFloatField('Hours'                        , Value);end;
procedure TTimesheetDetails.SetUnits                       (const Value: Integer   ); begin SetIntegerField('Units'                        , Value);end;
procedure TTimesheetDetails.SetLine_Date                   (const Value: TDateTime ); begin SetDateTimeField('Line_Date'                    , Value);end;
procedure TTimesheetDetails.SetAmount                      (const Value: Double    ); begin SetFloatField('Amount'                       , Value);end;
procedure TTimesheetDetails.SetCheck_Seq_Number            (const Value: Integer   ); begin SetIntegerField('Check_Seq_Number'             , Value);end;
procedure TTimesheetDetails.SetOverride_State              (const Value: string    ); begin SetStringField('Override_State'               , Value);end;
procedure TTimesheetDetails.SetOverride_Local              (const Value: string    ); begin SetStringField('Override_Local'               , Value);end;
procedure TTimesheetDetails.SetOverride_Local_Jurisdiction (const Value: string    ); begin SetStringField('Override_Local_Jurisdiction' , Value);end;
procedure TTimesheetDetails.SetLabor_Override              (const Value: string    ); begin SetStringField('Labor_Override'               , Value);end;
procedure TTimesheetDetails.SetCheck_Template              (const Value: string    ); begin SetStringField('Check_Template'               , Value);end;
procedure TTimesheetDetails.SetOutput_Type                 (const Value: Integer   ); begin SetIntegerField('Output_Type'                  , Value);end;
procedure TTimesheetDetails.SetNet_Pay                     (const Value: Double    ); begin SetFloatField('Net_Pay'                      , Value);end;
procedure TTimesheetDetails.SetCheck_Number                (const Value: Integer   ); begin SetIntegerField('Check_Number'                 , Value);end;
procedure TTimesheetDetails.SetFIT_Amt                     (const Value: Double    ); begin SetFloatField('FIT_Amt'                      , Value);end;
procedure TTimesheetDetails.SetSS_Amt                      (const Value: Double    ); begin SetFloatField('SS_Amt'                       , Value);end;
procedure TTimesheetDetails.SetMedicare_Amt                (const Value: Double    ); begin SetFloatField('Medicare_Amt'                 , Value);end;
procedure TTimesheetDetails.SetFed_Backup_Withholding_Amt  (const Value: Double    ); begin SetFloatField('Fed_Backup_Withholding_Amt'   , Value);end;
procedure TTimesheetDetails.SetState_Tax_Jurisdiction      (const Value: string    ); begin SetStringField('State_Tax_Jurisdiction'       , Value);end;
procedure TTimesheetDetails.SetSIT_Amount                  (const Value: Double    ); begin SetFloatField('SIT_Amount'                   , Value);end;
procedure TTimesheetDetails.SetSDI_Amt                     (const Value: Double    ); begin SetFloatField('SDI_Amt'                      , Value);end;
procedure TTimesheetDetails.SetFam_Leave                   (const Value: Double    ); begin SetFloatField('Fam_Leave'                    , Value);end;
procedure TTimesheetDetails.SetMed_Leave                   (const Value: Double    ); begin SetFloatField('Med_Leave'                    , Value);end;
procedure TTimesheetDetails.SetSUI_Amt                     (const Value: Double    ); begin SetFloatField('SUI_Amt'                      , Value);end;
procedure TTimesheetDetails.SetState_Misc_Amt              (const Value: Double    ); begin SetFloatField('State_Misc_Amt'               , Value);end;
procedure TTimesheetDetails.SetState_Surcharge_Amt         (const Value: Double    ); begin SetFloatField('State_Surcharge_Amt'          , Value);end;
procedure TTimesheetDetails.SetState_WC_Amt                (const Value: Double    ); begin SetFloatField('State_WC_Amt'                 , Value);end;
procedure TTimesheetDetails.SetState_Transit_Tax           (const Value: Double    ); begin SetFloatField('State_Transit_Tax'            , Value);end;
procedure TTimesheetDetails.SetState_Backup_Withholding_Amt(const Value: Double    ); begin SetFloatField('State_Backup_Withholding_Amt' , Value);end;
procedure TTimesheetDetails.SetState_Allocation_Percent    (const Value: Double    ); begin SetFloatField('State_Allocation_Percent'     , Value);end;
procedure TTimesheetDetails.SetLocal_Tax_Jurisdiction      (const Value: string    ); begin SetStringField('Local_Tax_Jurisdiction'       , Value);end;
procedure TTimesheetDetails.SetLocal_Tax_Name              (const Value: string    ); begin SetStringField('Local_Tax_Name'               , Value);end;
procedure TTimesheetDetails.SetLocal_Amt                   (const Value: Double    ); begin SetFloatField('Local_Amt'                    , Value);end;
procedure TTimesheetDetails.SetLocal_Allocation_Percent    (const Value: Double    ); begin SetFloatField('Local_Allocation_Percent'     , Value);end;
procedure TTimesheetDetails.SetPayChexsynched              (const Value: Boolean   ); begin SetBooleanField('PayChexsynched'     , Value);end;

function TTimesheetEntryDetails.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then    Exit;
  TypeName := 'Payroll';
end;

function TTimesheetEntryDetails.getTimesheetDetails: TTimesheetDetails;
begin
  Result :=  TTimesheetDetails(getContainerComponent(TTimesheetDetails , 'TimeSheetEntryID =  ' + IntToStr(Self.ID)));
end;
function TTimesheetEntryDetails.Save: Boolean;
begin
  Result := inherited Save;
  if not result then exit;
  AllLinesValid := true;
  TimesheetDetails.iteraterecords(saveCallback);
end;
procedure TTimesheetEntryDetails.saveCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is TTimesheetDetails then begin
    if TTimesheetDetails(Sender).save = false then begin
      AllLinesValid:= False;
      abort := true;
      Exit;
    end;
  end;
end;

{ TPendingTimeSheetForPayroll }

constructor TPendingTimeSheetForPayroll.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT T.*  FROM tbltimesheets as T ' +
    ' INNER JOIN tbltimesheetentry as TE ON TE.TimesheetEntryID = T.TimesheetEntryID '+
    ' where T.id not in  (Select distinct ifnull(TimeSheetId,0) from tblPays AS P INNER JOIN tblpayspayrates AS PR on PR.PayID = P.PayID and P.Deleted ="F")';
end;

initialization
  RegisterClass(TTimesheetDetails);
  RegisterClassOnce(TTimeLog);
  RegisterClassOnce(TTimeSheet);
  RegisterClassOnce(TTimesheetEntryDetails);
  RegisterClassOnce(TPendingTimeSheetForPayroll);
end.
