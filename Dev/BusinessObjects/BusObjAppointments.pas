unit BusObjAppointments;

interface

uses
  BusObjBase, DB, Classes,  BusObjRepServices, BusObjClient, XMLDoc, XMLIntf,
  ERPdbComponents, BusObjEmployee,BusObjEquipment, BusObjAttachment, BusObjSales, Types;

type

  TRescheduleAction = (raPost = 0, raDrop = 1, raShiftAfter = 2, raShiftBefore = 3);
  TRescheduleActions = class(TObject)
  public
    Saturday: TRescheduleAction;
    Sunday: TRescheduleAction;
    Holiday: TRescheduleAction;
    function GetAction(const dt: TDateTime): TRescheduleAction;
    //function IsHoliday(const dt: TDateTime): Boolean;
    function IsSaturday(const dt: TDateTime): Boolean;
    function IsSunday(const dt: TDateTime): Boolean;
    procedure LoadFromXMLNode(const node: IXMLNode);
    procedure SaveToXMLNode(const node: IXMLNode);
  end;
  TAppointmentsTimeLog = class(TMSBusObj)
  private
    function GetAppointID             : Integer   ;
    Function getDuration              : double;
    Function getIncludeForInvoice     : Boolean;
    Function getDescription           : String;
    Function getEmployeename          : String;
    function GetStartDatetime         : TDateTime ;
    function GetEndDatetime           : TDateTime ;
    function GetEnteredByEmployeeID   : Integer   ;
    function GetEmployeeID            : Integer   ;
    procedure SetAppointID            (const Value: Integer   );
    procedure SetDuration             (const Value: Double);
    procedure SetIncludeForInvoice    (const Value: Boolean);
    procedure SetDescription          (const Value: String);
    procedure SetEmployeename         (const Value: String);

    procedure SetStartDatetime        (const Value: TDateTime );
    procedure SetEndDatetime          (const Value: TDateTime );
    procedure SetEnteredByEmployeeID  (const Value: Integer   );
    procedure SetEmployeeID           (const Value: Integer   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj)   : Boolean;           override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function  DoCalcFields(Sender :TDatasetBusObj) : Boolean;           override;
    Function GetIsList: Boolean; Override;
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
    property AppointID              :Integer     read GetAppointID             write SetAppointID          ;
    property Duration               :Double      read GetDuration              write SetDuration           ;
    property IncludeForInvoice      :Boolean     read GetIncludeForInvoice     write SetIncludeForInvoice  ;
    property Description            :String      read GetDescription           write SetDescription        ;
    property Employeename           :String      read GetEmployeename          write SetEmployeename        ;
    property StartDatetime          :TDateTime   read GetStartDatetime         write SetStartDatetime     ;
    property EndDatetime            :TDateTime   read GetEndDatetime           write SetEndDatetime       ;
    property EnteredByEmployeeID    :Integer     read GetEnteredByEmployeeID   write SetEnteredByEmployeeID;
    property EmployeeID             :Integer     read GetEmployeeID            write SetEmployeeID;
  end;

  TAppointment = class(TMSBusObj)
  private
    aqryTotalLogTime:TERPQuery;
    function GetClientID                   : Integer   ;
    function GetAppDate                    : TDateTime ;
    function GetActual_AppDate             : TDateTime ;
    function GetCreationDate               : TDateTime ;
    function GetUpdateDate                 : TDateTime ;
    function GetGoogleUpdated              : TDateTime ;
    function GetCancellation               : Boolean   ;
    function GetCancellationReason         : string    ;
//    function GetTrainRateID                : Integer   ;
    function GetTrainerID                  : Integer   ;
    function GetLastTrainerID              : Integer   ;
    function GetMedTypeID                  : Integer   ;
    function GetContact                    : string    ;
    function GetReschedulled               : Boolean   ;
    function GetCancellationDate           : TDateTime ;
    function GetRescheduledDate            : TDateTime ;
    function GetStart_time                 : string    ;
    function GetActual_start_time          : string    ;
    function GetEnd_time                   : string    ;
    function GetActual_end_time            : string    ;
    function GetStartVal                   : Double    ;
    function GetEndVal                     : Double    ;
    function GetPh_support_till            : TDateTime ;
    function GetRate                       : Double    ;
    function GetTrainerCode                : string    ;
    function GetNotes                      : string    ;
    function GetFeedbackNotes              : string    ;
    function GetCalloutValue               : Double    ;
    function GetServiceDesc                : string    ;
    function GetProductDesc                : string    ;
    function GetOther                      : Boolean   ;
    function GetOthertxt                   : string    ;
    function GetFeedback                   : Boolean   ;
    function GetTotalInc                   : Double    ;
    function GetTotalCost                  : Double    ;
    function GetMsref                      : string    ;
    function GetAppearDays                 : Integer   ;
    function GetClassID                    : Integer   ;
    function GetRescheduledFrom            : TDateTime ;
    function GetCustomerDetails            : string    ;
    function GetStreet                     : string    ;
    function GetStreet2                    : string    ;
    function GetStreet3                    : string    ;
    function GetSuburb                     : string    ;
    function GetState                      : string    ;
    function GetCountry                    : string    ;
    function GetPostcode                   : string    ;
    function GetPhone                      : string    ;
    function GetAltPhone                   : string    ;
    function GetFax                        : string    ;
    function GetMobile                     : string    ;
    function GetStartTime                  : TDateTime ;
    function GetActual_StartTime           : TDateTime ;
    function GetEndTime                    : TDateTime ;
    function GetActual_EndTime             : TDateTime ;
    function GetJobDueDate                 : TDateTime ;
    function GetServiceID                  : Integer   ;
    function GetProductID                  : Integer   ;
//    function GetResourceID                 : Integer   ;
    function GetPosID                      : Integer   ;
    function GetConverted                  : Boolean   ;
    function GetUnavailable                : Boolean   ;
    function GetEnteredByEmployeeID        : Integer   ;
    function GetEnteredByEmployeeName      : string    ;
    function GetActive                     : Boolean   ;
    function GetLinkAppointID              : Integer   ;
    function GetIsGroupParent              : Boolean   ;
    function GetTimesheetID                : Integer   ;
    function GetHrsToInvoice               : Double    ;
    function GetStatus                     : string    ;
    function GetTypeOfBasedOn   : String;
    function GetFrequencyValues : String;
    function GetCopyStartDate   : TDateTime;
    function GetCopyFinishDate  : TDateTime;

    procedure SetClientID                   (const Value: Integer   );
    procedure SetAppDate                    (const Value: TDateTime );
    procedure SetActual_AppDate             (const Value: TDateTime );
    procedure SetCreationDate               (const Value: TDateTime );
    procedure SetUpdateDate                 (const Value: TDateTime );
    procedure SetGoogleUpdated              (const Value: TDateTime );
    procedure SetCancellation               (const Value: Boolean   );
    procedure SetCancellationReason         (const Value: string    );
//    procedure SetTrainRateID                (const Value: Integer   );
    procedure SetTrainerID                  (const Value: Integer   );
    procedure SetLastTrainerID              (const Value: Integer   );
    procedure SetMedTypeID                  (const Value: Integer   );
    procedure SetContact                    (const Value: string    );
    procedure SetReschedulled               (const Value: Boolean   );
    procedure SetCancellationDate           (const Value: TDateTime );
    procedure SetRescheduledDate            (const Value: TDateTime );
    procedure SetStart_time                 (const Value: string    );
    procedure SetActual_start_time          (const Value: string    );
    procedure SetEnd_time                   (const Value: string    );
    procedure SetActual_end_time            (const Value: string    );
    procedure SetStartVal                   (const Value: Double    );
    procedure SetEndVal                     (const Value: Double    );
    procedure SetPh_support_till            (const Value: TDateTime );
    procedure SetRate                       (const Value: Double    );
    procedure SetTrainerCode                (const Value: string    );
    procedure SetNotes                      (const Value: string    );
    procedure SetFeedbackNotes              (const Value: string    );
    procedure SetCalloutValue               (const Value: Double    );
    procedure SetServiceDesc                (const Value: string    );
    procedure SetProductDesc                (const Value: string    );
    procedure SetOther                      (const Value: Boolean   );
    procedure SetOthertxt                   (const Value: string    );
    procedure SetFeedback                   (const Value: Boolean   );
    procedure SetTotalInc                   (const Value: Double    );
    procedure SetTotalCost                  (const Value: Double    );
    procedure SetMsref                      (const Value: string    );
    procedure SetAppearDays                 (const Value: Integer   );
    procedure SetClassID                    (const Value: Integer   );
    procedure SetRescheduledFrom            (const Value: TDateTime );
    procedure SetCustomerDetails            (const Value: string    );
    procedure SetStreet                     (const Value: string    );
    procedure SetStreet2                    (const Value: string    );
    procedure SetStreet3                    (const Value: string    );
    procedure SetSuburb                     (const Value: string    );
    procedure SetState                      (const Value: string    );
    procedure SetCountry                    (const Value: string    );
    procedure SetPostcode                   (const Value: string    );
    procedure SetPhone                      (const Value: string    );
    procedure SetAltPhone                   (const Value: string    );
    procedure SetFax                        (const Value: string    );
    procedure SetMobile                     (const Value: string    );
    procedure SetStartTime                  (const Value: TDateTime );
    procedure SetActual_StartTime           (const Value: TDateTime );
    procedure SetEndTime                    (const Value: TDateTime );
    procedure SetActual_EndTime             (const Value: TDateTime );
    procedure SetJobDueDate                 (const Value: TDateTime );
    procedure SetServiceID                  (const Value: Integer   );
    procedure SetProductID                  (const Value: Integer   );
//    procedure SetResourceID                 (const Value: Integer   );
    procedure SetPosID                      (const Value: Integer   );
    procedure SetConverted                  (const Value: Boolean   );
    procedure SetUnavailable                (const Value: Boolean   );
    procedure SetEnteredByEmployeeID        (const Value: Integer   );
    procedure SetEnteredByEmployeeName      (const Value: string    );
    procedure SetActive                     (const Value: Boolean   );
    procedure SetLinkAppointID              (const Value: Integer   );
    procedure SetIsGroupParent              (const Value: Boolean   );
    procedure SetTimesheetID                (const Value: Integer   );
    procedure SetHrsToInvoice               (const Value: Double    );
    procedure SetStatus                     (const Value: string    );
    procedure SetTypeOfBasedOn              (const Value: String);
    procedure SetFrequencyValues            (const Value: String);
    procedure SetCopyStartDate              (const Value: TDateTime);
    procedure SetCopyFinishDate             (const Value: TDateTime);

    procedure SetTrainerName(const Value: string);
    function GetClientName: string;
    function GetClientPrintName: string;
    procedure SetClientName(const Value: string);
    procedure SetClientPrintName(const Value: string);
    function GetCUSTDATE1: TDateTime;
    function GetCUSTDATE2: TDateTime;
    function GetCUSTDATE3: TDateTime;
    function GetCUSTFLD1: string;
    function GetCUSTFLD10: string;
    function GetCUSTFLD11: string;
    function GetCUSTFLD12: string;
    function GetCUSTFLD13: string;
    function GetCUSTFLD14: string;
    function GetCUSTFLD15: string;
    function GetCUSTFLD2: string;
    function GetCUSTFLD3: string;
    function GetCUSTFLD4: string;
    function GetCUSTFLD5: string;
    function GetCUSTFLD6: string;
    function GetCUSTFLD7: string;
    function GetCUSTFLD8: string;
    function GetCUSTFLD9: string;
    function GetCustomerID: Integer;
    function GetLeadID: Integer;
    function GetSupplierID: Integer;
    function GetExtraProducts: String;

    procedure SetCUSTDATE1(const Value: TDateTime);
    procedure SetCUSTDATE2(const Value: TDateTime);
    procedure SetCUSTDATE3(const Value: TDateTime);
    procedure SetCUSTFLD1(const Value: string);
    procedure SetCUSTFLD10(const Value: string);
    procedure SetCUSTFLD11(const Value: string);
    procedure SetCUSTFLD12(const Value: string);
    procedure SetCUSTFLD13(const Value: string);
    procedure SetCUSTFLD14(const Value: string);
    procedure SetCUSTFLD15(const Value: string);
    procedure SetCUSTFLD2(const Value: string);
    procedure SetCUSTFLD3(const Value: string);
    procedure SetCUSTFLD4(const Value: string);
    procedure SetCUSTFLD5(const Value: string);
    procedure SetCUSTFLD6(const Value: string);
    procedure SetCUSTFLD7(const Value: string);
    procedure SetCUSTFLD8(const Value: string);
    procedure SetCUSTFLD9(const Value: string);
    procedure SetCustomerID(const Value: Integer);
    procedure SetLeadID(const Value: Integer);
    procedure SetSupplierID(const Value: Integer);
    procedure SetExtraProducts(const Value: String);

    function getRepairID: Integer;
    procedure setRepairID(const Value: Integer);
    function getTrainer: TEmployee;
    function  QryTotalLogTime:TERPQuery;
  private
    fGUIMode: Boolean;
    fRescheduled: Boolean;
    fRescheduleActions: TRescheduleActions;
    fOldDate: TDateTime;
    fStartTime: TDateTime;
    fActual_StartTime: TDateTime;
    fClientHoursLeft: Double;
    fOnTotalsChange: TNotifyEvent;
    fOnRefreshAvailableServices: TNotifyEvent;
    fOnServiceIDChange: TNotifyEvent;
    fOnClientIDChange: TNotifyEvent;
    AllLinesValid: Boolean;
    AllLinesSavedOK: Boolean;
    fbTimeLogchanged:Boolean;
    fbUpdateLinkedAppointmentsonReschedule: Boolean;
    //fdTotalLogTime :double;
    function GetEquipment: TEquipmentxRef;
    function GetAppointmentsTimeLog: TAppointmentsTimeLog;
    (*procedure SetEquipment(const Value: TApptEquipment);*)
    function GetService: TRepServices;
    function GetClient: TClient;
    function GetActual_TotalHours: Double;
    function GetTotalLogTime: Double;
    function GetTotalHours: Double;
    function GetActual_TotalHoursStr: string;
    function GetTotalHoursStr: string;
    function GetClientAppointmentCount: Integer;
    function GetTrainerName: string;
    function GetClientEmail: string;
    function GetRepEmail: string;
    procedure CalcTotals;
    procedure RefreshServiceDetails(DeleteRepService: Boolean = False; Recalculating: Boolean = False);
    procedure DoClientIDChange;
    (*procedure DoEquipmentChange(Sender: TObject);*)
    procedure CalcClientHoursLeft;
    function Reschedule(ShiftByDays: Integer; const aRescheduleActions: TRescheduleActions): Boolean;
    procedure RescheduleLinkedAppointments;
    procedure MakeTimesheetEntry;
    // if calling date/time validate methods outside DoFieldOnChange, set DoFieldChange := False
    procedure ValidateStartTime(const ChangingTime: Boolean);
    Procedure CalcnValidatedates(const Sender: TField);
    Procedure HandleDatechanges(Const Sender:TField);
    procedure ValidateEndTime(const ChangingTime: Boolean);
    procedure ValidateActual_StartTime(const ChangingTime: Boolean);
    procedure ValidateActual_EndTime(const ChangingTime: Boolean);
    procedure LineValidateCallbackProc(const Sender: TBusObj; var Abort: Boolean);
    procedure LineSaveCallbackProc(const Sender: TBusObj; var Abort: Boolean);
    procedure SetLastTrainerName(const Value: string);
    function GetLastTrainerName: string;
    function GetMediaType: string;
    procedure SetMediaType(const Value: string);
    function GetRepairGlobalRef: string;
    procedure SetRepairGlobalRef(const Value: string);
    function GetDeptClassName: string;
    procedure SetDeptClassName(const Value: string);
    function GetPosSaleGlobalRef: string;
    procedure SetPosSaleGlobalRef(const Value: string);
    function GetLinkedAppointmentGlobalRef: string;
    procedure SetLinkedAppointmentGlobalRef(const Value: string);
    function GetTimeSheetGlobalRef: string;
    procedure SetTimeSheetGlobalRef(const Value: string);
    function GetClientMobile: string;
    function GetRepMobile: string;
    function GetGoogleId: string;
    procedure SetGoogleId(const Value: string);
    function GetSynchWithGoogle: boolean;
    procedure SetSynchWithGoogle(const Value: boolean);
    function GetCleanTrainerId: integer;
    function GetLocalApp: Boolean;
    procedure SetLocalApp(const Value: Boolean);
    procedure CheckForProductService;
    //procedure TotalLogTimeCallback(const Sender: TBusObj; var Abort: Boolean);
    function LocateActiveLog: Boolean;
    procedure LocateActiveLogCallback(const Sender: TBusObj;
      var Abort: Boolean);
    Procedure UserInputStartdate;
    procedure UserInputEnddate;
    function DefaultAppointmentDuration: Integer;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj ):Boolean;              override;
    function  DoBeforePost(Sender: TDatasetBusObj ):Boolean;              override;
    Function  DoAfterInsert(Sender:TDatasetBusobj):Boolean; override;
  public
    (*function ValidStrToTime(const S: string): TDateTime;*)
    class Function GetIDField: String; Override;
    class function GetBusObjectTablename: string; Override;
    constructor  Create(AOwner: TComponent);                             override;
    destructor   Destroy;                                                override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                  override;
    procedure    SaveToXMLNode(const node: IXMLNode);                    override;
    function     ValidateData: Boolean ;                                 override;
    function     ValidateForInvoicing: Boolean;
    function     Lock: Boolean;                                          override;
    function     Save: Boolean;                                          override;

    procedure Recalculate;
    function IsCustomerCreditOk: Boolean;
    function IsCustomerTermsOk: Boolean;

    function ConvertToInvoice(var Invoice: TInvoice): Boolean; overload;
    function ConvertToInvoice(out NewInvoiceID: Integer): Boolean; overload;

    function RescheduleWillOccurOnSave: Boolean;

    property GUIMode: Boolean read fGUIMode write fGUIMode;
    property OnTotalsChange: TNotifyEvent read fOnTotalsChange write fOnTotalsChange;
    property OnRefreshAvailableServices: TNotifyEvent read fOnRefreshAvailableServices write fOnRefreshAvailableServices;
    property OnServiceIDChange: TNotifyEvent read fOnServiceIDChange write fOnServiceIDChange;
    property OnClientIDChange: TNotifyEvent read fOnClientIDChange write fOnClientIDChange;
    property Equipment: TEquipmentxRef read GetEquipment ;(*write SetEquipment;*)
    property Service: TRepServices read GetService;
    Property Trainer :TEmployee REad getTrainer;
    property CleanTrainerId: integer read GetCleanTrainerId;
    class function _Schema: string; override;
    Property UpdateLinkedAppointmentsonReschedule :Boolean read fbUpdateLinkedAppointmentsonReschedule write fbUpdateLinkedAppointmentsonReschedule;
    property Start_Time                  :string       read GetStart_time               write SetStart_time           ;
    property End_Time                    :string       read GetEnd_time                 write SetEnd_time             ;
    property Actual_Start_Time           :string       read GetActual_start_time        write SetActual_start_time    ;
    property Actual_End_Time             :string       read GetActual_end_time          write SetActual_end_time      ;
    Function NewLog(aStartTime:TDateTime=0):Integer;
    Function EndLog(aEndTime:TDateTime=0):Integer;

  published
    property ClientID                    :Integer      read GetClientID                 write SetClientID             ;
    property ClientName                  :string       read GetClientName               write SetClientName;
    property ClientPrintName             :string       read GetClientPrintName          write SetClientPrintName      ;
    property AppDate                     :TDateTime    read GetAppDate                  write SetAppDate              ;
    property StartTime                   :TDateTime    read GetStartTime                write SetStartTime            ;
    property EndTime                     :TDateTime    read GetEndTime                  write SetEndTime              ;
    property Actual_AppDate              :TDateTime    read GetActual_AppDate           write SetActual_AppDate       ;
    property Actual_StartTime            :TDateTime    read GetActual_StartTime         write SetActual_StartTime     ;
    property Actual_EndTime              :TDateTime    read GetActual_EndTime           write SetActual_EndTime       ;
    property CreationDate                :TDateTime    read GetCreationDate             write SetCreationDate         ;
    property UpdateDate                  :TDateTime    read GetUpdateDate               write SetUpdateDate           ;
    property GoogleUpdated               :TDateTime    read GetGoogleUpdated            write SetGoogleUpdated        ;
    property Cancellation                :Boolean      read GetCancellation             write SetCancellation         ;
    property CancellationReason          :string       read GetCancellationReason       write SetCancellationReason   ;
    property TrainerID                   :Integer      read GetTrainerID                write SetTrainerID            ;
    property TrainerName: string read GetTrainerName write SetTrainerName;
    property LastTrainerID               :Integer      read GetLastTrainerID            write SetLastTrainerID        ;
    property LastTrainerName: string read GetLastTrainerName write SetLastTrainerName;
    property MedTypeID                   :Integer      read GetMedTypeID                write SetMedTypeID            ;
    property MediaType: string read GetMediaType write SetMediaType;
    property Contact                     :string       read GetContact                  write SetContact              ;
    property Reschedulled                :Boolean      read GetReschedulled             write SetReschedulled         ;
    property CancellationDate            :TDateTime    read GetCancellationDate         write SetCancellationDate     ;
    property RescheduledDate             :TDateTime    read GetRescheduledDate          write SetRescheduledDate      ;
    property StartVal                    :Double       read GetStartVal                 write SetStartVal             ;
    property EndVal                      :Double       read GetEndVal                   write SetEndVal               ;
    property Ph_Support_Till             :TDateTime    read GetPh_support_till          write SetPh_support_till      ;
    property Rate                        :Double       read GetRate                     write SetRate                 ;
    property TrainerCode                 :string       read GetTrainerCode              write SetTrainerCode          ;
    property Notes                       :string       read GetNotes                    write SetNotes                ;
    property FeedbackNotes               :string       read GetFeedbackNotes            write SetFeedbackNotes        ;
    property ServiceID                   :Integer      read GetServiceID                write SetServiceID            ;
    property ServiceDesc                 :string       read GetServiceDesc              write SetServiceDesc          ;
    property ProductID                   :Integer      read GetProductID                write SetProductID            ;
    property ProductDesc                 :string       read GetProductDesc              write SetProductDesc          ;
    Property RepairID                    :Integer      read getRepairID                 write setRepairID;
    property RepairGlobalRef: string read GetRepairGlobalRef write SetRepairGlobalRef;
    property CalloutValue                :Double       read GetCalloutValue             write SetCalloutValue         ;
    property TotalInc                    :Double       read GetTotalInc                 write SetTotalInc             ;
    property ClientHoursLeft             :Double       read fClientHoursLeft;
    property HrsToInvoice                :Double       read GetHrsToInvoice             write SetHrsToInvoice         ;
    property TotalCost                   :Double       read GetTotalCost                write SetTotalCost            ;
    property Other                       :Boolean      read GetOther                    write SetOther                ;
    property Othertxt                    :string       read GetOthertxt                 write SetOthertxt             ;
    property Feedback                    :Boolean      read GetFeedback                 write SetFeedback             ;
    property MsRef                       :string       read GetMsref                    write SetMsref                ;
    property AppearDays                  :Integer      read GetAppearDays               write SetAppearDays           ;
    property ClassID                     :Integer      read GetClassID                  write setClassID              ;
    property DeptClassName: string read GetDeptClassName write SetDeptClassName;
    property RescheduledFrom             :TDateTime    read GetRescheduledFrom          write SetRescheduledFrom      ;
    property CustomerDetails             :string       read GetCustomerDetails          write SetCustomerDetails      ;
    property Street                      :string       read GetStreet                   write SetStreet               ;
    property Street2                     :string       read GetStreet2                  write SetStreet2              ;
    property Street3                     :string       read GetStreet3                  write SetStreet3              ;
    property Suburb                      :string       read GetSuburb                   write SetSuburb               ;
    property State                       :string       read GetState                    write SetState                ;
    property Country                     :string       read GetCountry                  write SetCountry              ;
    property Postcode                    :string       read GetPostcode                 write SetPostcode             ;
    property Phone                       :string       read GetPhone                    write SetPhone                ;
    property AltPhone                    :string       read GetAltPhone                 write SetAltPhone             ;
    property Fax                         :string       read GetFax                      write SetFax                  ;
    property Mobile                      :string       read GetMobile                   write SetMobile               ;
    property JobDueDate                  :TDateTime    read GetJobDueDate               write SetJobDueDate           ;
    property PosID                       :Integer      read GetPosID                    write SetPosID                ;
    property PosSaleGlobalRef: string read GetPosSaleGlobalRef write SetPosSaleGlobalRef;
    property Converted                   :Boolean      read GetConverted                write SetConverted            ;
    property Unavailable                 :Boolean      read GetUnavailable              write SetUnavailable          ;
    property LocalApp                    : Boolean     read GetLocalApp                 Write SetLocalApp;
    property EnteredByEmployeeID         :Integer      read GetEnteredByEmployeeID      write SetEnteredByEmployeeID  ;
    property EnteredByEmployeeName       :string       read GetEnteredByEmployeeName    write SetEnteredByEmployeeName;
    property Active                      :Boolean      read GetActive                   write SetActive               ;
    property LinkAppointID               :Integer      read GetLinkAppointID            write SetLinkAppointID        ;
    property LinkedAppointmentGlobalRef: string read GetLinkedAppointmentGlobalRef write SetLinkedAppointmentGlobalRef;
    property IsGroupParent               :Boolean      read GetIsGroupParent            write SetIsGroupParent        ;
    property TimesheetID                 :Integer      read GetTimesheetID              write SetTimesheetID          ;
    property TimeSheetGlobalRef: string read GetTimeSheetGlobalRef write SetTimeSheetGlobalRef;
    property Status                      :string       read GetStatus                   write SetStatus               ;
    property TotalHours: Double read GetTotalHours;
    property TotalHoursStr: string read GetTotalHoursStr;
    property Actual_TotalHours: Double read GetActual_TotalHours;
    property TotalLogTime: Double read GetTotalLogTime;
    property Actual_TotalHoursStr: string read GetActual_TotalHoursStr;

    property ClientAppointmentCount: Integer read GetClientAppointmentCount;
    property ClientEmail: string read GetClientEmail;
    property RepEmail: string read GetRepEmail;
    property ClientMobile: string read GetClientMobile;
    property RepMobile: string read GetRepMobile;
    property RescheduleActions: TRescheduleActions read fRescheduleActions;
    property GoogleId: string read GetGoogleId write SetGoogleId;
    property SynchWithGoogle: boolean read GetSynchWithGoogle write SetSynchWithGoogle;

    // Client is not validated or saved
    property Client: TClient read GetClient;
    // When Equipment needs an external Dataset, create TApptEquipment and assign to Equipment
    property CUSTFLD1              :string read GetCUSTFLD1 write SetCUSTFLD1;
    property CUSTFLD2              :string read GetCUSTFLD2 write SetCUSTFLD2;
    property CUSTFLD3              :string read GetCUSTFLD3 write SetCUSTFLD3;
    property CUSTFLD4              :string read GetCUSTFLD4 write SetCUSTFLD4;
    property CUSTFLD5              :string read GetCUSTFLD5 write SetCUSTFLD5;
    property CUSTFLD6              :string read GetCUSTFLD6 write SetCUSTFLD6;
    property CUSTFLD7              :string read GetCUSTFLD7 write SetCUSTFLD7;
    property CUSTFLD8              :string read GetCUSTFLD8 write SetCUSTFLD8;
    property CUSTFLD9              :string read GetCUSTFLD9 write SetCUSTFLD9;
    property CUSTFLD10             :string read GetCUSTFLD10 write SetCUSTFLD10;
    property CUSTFLD11             :string read GetCUSTFLD11 write SetCUSTFLD11;
    property CUSTFLD12             :string read GetCUSTFLD12 write SetCUSTFLD12;
    property CUSTFLD13             :string read GetCUSTFLD13 write SetCUSTFLD13;
    property CUSTFLD14             :string read GetCUSTFLD14 write SetCUSTFLD14;
    property CUSTFLD15             :string read GetCUSTFLD15 write SetCUSTFLD15;
    property CUSTDATE1             :TDateTime read GetCUSTDATE1    write SetCUSTDATE1;
    property CUSTDATE2             :TDateTime read GetCUSTDATE2    write SetCUSTDATE2;
    property CUSTDATE3             :TDateTime read GetCUSTDATE3                 write SetCUSTDATE3;
    property AppointmentsTimeLog: TAppointmentsTimeLog read GetAppointmentsTimeLog ;(*write SetEquipment;*)
    property CustomerID             :Integer read GetCustomerID write SetCustomerID;
    property LeadID                 :Integer read GetLeadID     write SetLeadID;
    property SupplierID             :Integer read GetSupplierID write SetSupplierID;
    property ExtraProducts          :String  read GetExtraProducts  write SetExtraProducts;
    Property TypeOfBasedOn      : String    read GetTypeOfBasedOn     write SetTypeOfBasedOn;
    Property FrequenctyValues   : String    read GetFrequencyValues   write SetFrequencyValues;
    Property CopyStartDate      : TDateTime read GetCopyStartDate     write SetCopyStartDate;
    Property CopyFinishDate     : TDateTime read GetCopyFinishDate    write SetCopyFinishDate;

    { the following don't seem to be used any more }
//    property TrainRateID                 :Integer      read GetTrainRateID              write SetTrainRateID          ;
//    property ResourceID                  :Integer      read GetResourceID               write SetResourceID           ;
  end;
  TAppointmentEx = class(TAppointment)
  Private
    function Getattachments: TAttachment;
  published
    property Attachments: TAttachment read Getattachments;
  end;


implementation

uses
  tcDataUtils, CommonLib, CommonDbLib, SysUtils, DateUtils, MyAccess,Variants,
  DNMLib, TypInfo, MySQLConst, AppEnvironment, Math,
  BusObjMarketingLeads, tcconst,
  CustomFieldConfigObj, BusObjConst, CompanyPrefObj, timelib, BusObjSchemaLib,
  BusObjCommon, BusObjRepairs, BusObjClass, BusObjSaleBase, BusObjTimeSheet, GoogleApi,
  DbSharedObjectsObj, BusObjStock, BusobjProduct, LogLib, StringUtils;

resourcestring
  rsNoEndBeforeStart = 'An appointment cannot end before it starts.';

const
  AppointmentStatusTypeNA           = 1000;
  AppointmentStatusTypeApproved     = 1001;
  AppointmentStatusTypeCancelled    = 1002;
  AppointmentStatusTypeNotApproved  = 1003;
  AppointmentStatusTypeWaiting      = 1004;
  AppointmentStatusTypeConverted    = 1005;
  AppointmentStatusTypeFollowUp     = 1006;

{ TRescheduleActions }

function TRescheduleActions.GetAction(const dt: TDateTime): TRescheduleAction;
begin
  if IsSaturday(dt) then
    Result := Self.Saturday
  else if IsSunday(dt) then
    Result := Self.Sunday
  else if tcDataUtils.IsHoliday(dt) then
    Result := Self.Holiday
  else
    Result := raPost;
end;

(*function TRescheduleActions.IsHoliday(const dt: TDateTime): Boolean;
var
  Qry:TERPQuery;
begin
  //with Datautilsdataset(Format('SELECT ID FROM tblpublicholidays WHERE Day = "%s"', [FormatDateTime(MysqlDateFormat, dt)])) do begin
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
        if Qry.active then Qry.Close;
        Qry.SQL.Text :=Format('SELECT ID FROM tblpublicholidays WHERE Day = "%s"', [FormatDateTime(MysqlDateFormat, dt)]);
        Qry.open;
    Result := not Qry.Eof;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;*)

function TRescheduleActions.IsSaturday(const dt: TDateTime): Boolean;
begin
  Result := DayofTheWeek(dt) = 6;
end;

function TRescheduleActions.IsSunday(const dt: TDateTime): Boolean;
begin
  Result := DayofTheWeek(dt) = 7;
end;

procedure TRescheduleActions.LoadFromXMLNode(const node: IXMLNode);
var
  lNode: IXMLNode;
  tmp: Boolean;
begin
  lNode := Node.ChildNodes.FindNode('rescheduleactions');
  if Assigned(lNode) then begin
    Self.Saturday := TRescheduleAction(GetEnumValue(TypeInfo(TRescheduleAction), GetXMLNodeStringValue(Node,'Saturday',tmp)));
    Self.Sunday := TRescheduleAction(GetEnumValue(TypeInfo(TRescheduleAction), GetXMLNodeStringValue(Node,'Sunday',tmp)));
    Self.Holiday := TRescheduleAction(GetEnumValue(TypeInfo(TRescheduleAction), GetXMLNodeStringValue(Node,'Holiday',tmp)));
  end;
end;

procedure TRescheduleActions.SaveToXMLNode(const node: IXMLNode);
var
  lNode: IXMLNode;
begin
  lNode := node.AddChild('rescheduleactions');
  AddXMLNode(lNode, 'Saturday', GetEnumName(TypeInfo(TRescheduleAction), Integer(Self.Saturday)));
  AddXMLNode(lNode, 'Sunday', GetEnumName(TypeInfo(TRescheduleAction), Integer(Self.Sunday)));
  AddXMLNode(lNode, 'Holiday', GetEnumName(TypeInfo(TRescheduleAction), Integer(Self.Holiday)));
end;

{ TAppointment }

constructor TAppointment.Create(AOwner: TComponent);
begin
  fbUpdateLinkedAppointmentsonReschedule := True;
  fbTimeLogchanged:=true;
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblappointments where (Not IsNull(AppDate))';
  fRescheduleActions := TRescheduleActions.Create;
  ExportExcludeList.Add('clientid');
  ExportExcludeList.Add('trainerid');
  ExportExcludeList.Add('lasttrainerid');
  ExportExcludeList.Add('medtypeid');
  ExportExcludeList.Add('serviceid');
  ExportExcludeList.Add('Productid');
  ExportExcludeList.Add('repairid');
  ExportExcludeList.Add('classid');
  ExportExcludeList.Add('posid');
  ExportExcludeList.Add('enteredbyemployeeid');
  ExportExcludeList.Add('linkappointid');
  ExportExcludeList.Add('timesheetid');
  ExportExcludeList.Add('clientappointmentcount');
  ExportExcludeList.Add('clientemail');
  ExportExcludeList.Add('repemail');
  ExportExcludeList.Add('rescheduleactions');
  ExportExcludeList.Add('client');
  aqryTotalLogTime:= nil;
end;


destructor TAppointment.Destroy;
begin
  FreeAndNil(fRescheduleActions);
  if aqryTotalLogTime <> nil then DbSharedObjectsObj.DbSharedObj.ReleaseObj(aqryTotalLogTime);
  inherited;
end;


procedure   TAppointment.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
    SetPropertyFromNode(Node,'ClientID');
    SetPropertyFromNode(Node,'ClientName');
    SetPropertyFromNode(Node,'ClientPrintName');
    SetDateTimePropertyFromNode(Node,'AppDate');
    SetDateTimePropertyFromNode(Node,'Actual_AppDate');
    SetDateTimePropertyFromNode(Node,'CreationDate');
    SetDateTimePropertyFromNode(Node,'UpdateDate');
    SetDateTimePropertyFromNode(Node,'GoogleUpdated');
    SetBooleanPropertyFromNode(Node,'Cancellation');
    SetPropertyFromNode(Node,'CancellationReason');
//    SetPropertyFromNode(Node,'TrainRateID');
    SetPropertyFromNode(Node,'Trainerid');
    SetPropertyFromNode(Node,'TrainerName');
    SetPropertyFromNode(Node,'LastTrainerID');
    SetPropertyFromNode(Node,'MedTypeID');
    SetPropertyFromNode(Node,'Contact');
    SetBooleanPropertyFromNode(Node,'Reschedulled');
    SetDateTimePropertyFromNode(Node,'CancellationDate');
    SetDateTimePropertyFromNode(Node,'RescheduledDate');
    SetPropertyFromNode(Node,'Start_time');
    SetPropertyFromNode(Node,'Actual_start_time');
    SetPropertyFromNode(Node,'End_time');
    SetPropertyFromNode(Node,'Actual_end_time');
    SetPropertyFromNode(Node,'StartVal');
    SetPropertyFromNode(Node,'EndVal');
    SetDateTimePropertyFromNode(Node,'Ph_support_till');
    SetPropertyFromNode(Node,'Rate');
    SetPropertyFromNode(Node,'TrainerCode');
    SetPropertyFromNode(Node,'Notes');
    SetPropertyFromNode(Node,'FeedbackNotes');
    SetPropertyFromNode(Node,'CalloutValue');
    SetPropertyFromNode(Node,'ServiceDesc');
    SetPropertyFromNode(Node,'ProductDesc');
    SetBooleanPropertyFromNode(Node,'Other');
    SetPropertyFromNode(Node,'Othertxt');
    SetBooleanPropertyFromNode(Node,'Feedback');
    SetPropertyFromNode(Node,'TotalInc');
    SetPropertyFromNode(Node,'TotalCost');
    SetPropertyFromNode(Node,'Msref');
    SetPropertyFromNode(Node,'AppearDays');
    SetPropertyFromNode(Node,'Classid');
    SetDateTimePropertyFromNode(Node,'RescheduledFrom');
    SetPropertyFromNode(Node,'CustomerDetails');
    SetPropertyFromNode(Node,'Street');
    SetPropertyFromNode(Node,'Street2');
    SetPropertyFromNode(Node,'Street3');
    SetPropertyFromNode(Node,'Suburb');
    SetPropertyFromNode(Node,'State');
    SetPropertyFromNode(Node,'Country');
    SetPropertyFromNode(Node,'Postcode');
    SetPropertyFromNode(Node,'Phone');
    SetPropertyFromNode(Node,'AltPhone');
    SetPropertyFromNode(Node,'Fax');
    SetPropertyFromNode(Node,'Mobile');
    SetDateTimePropertyFromNode(Node,'StartTime');
    SetDateTimePropertyFromNode(Node,'Actual_StartTime');
    SetDateTimePropertyFromNode(Node,'EndTime');
    SetDateTimePropertyFromNode(Node,'Actual_EndTime');
    SetDateTimePropertyFromNode(Node,'JobDueDate');
    SetPropertyFromNode(Node,'ServiceID');
    SetPropertyFromNode(Node,'ProductID');
    SetPropertyFromNode(Node, 'RepairID');
//    SetPropertyFromNode(Node,'ResourceID');
    SetPropertyFromNode(Node,'Posid');
    SetBooleanPropertyFromNode(Node,'Converted');
    SetBooleanPropertyFromNode(Node,'Unavailable');
    SetPropertyFromNode(Node,'EnteredByEmployeeID');
    SetPropertyFromNode(Node,'EnteredByEmployeeName');
    SetBooleanPropertyFromNode(Node,'Active');
    SetPropertyFromNode(Node,'LinkAppointID');
    SetBooleanPropertyFromNode(Node,'IsGroupParent');
    SetPropertyFromNode(Node,'Timesheetid');
    SetPropertyFromNode(Node,'HrsToInvoice');
    SetPropertyFromNode(Node,'Status');
    SetPropertyFromNode(Node,'GoogleId');
    SetBooleanPropertyFromNode(Node,'SynchWithGoogle');
  RescheduleActions.LoadFromXMLNode(Node);
end;


procedure TAppointment.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ClientID' ,ClientID);
  AddXMLNode(node ,'ClientName', ClientName);
  AddXMLNode(node ,'ClientPrintName', ClientPrintName);
  AddXMLNode(node,'AppDate' ,AppDate);
  AddXMLNode(node,'Actual_AppDate' ,Actual_AppDate);
  AddXMLNode(node,'CreationDate' ,CreationDate);
  AddXMLNode(node,'UpdateDate' ,UpdateDate);
  AddXMLNode(node,'GoogleUpdated' ,GoogleUpdated);
  AddXMLNode(node,'Cancellation' ,Cancellation);
  AddXMLNode(node,'CancellationReason' ,CancellationReason);
//  AddXMLNode(node,'TrainRateID' ,TrainRateID);
  AddXMLNode(node,'Trainerid' ,Trainerid);
  AddXMLNode(node,'TrainerName' ,TrainerName);
  AddXMLNode(node,'LastTrainerID' ,LastTrainerID);
  AddXMLNode(node,'MedTypeID' ,MedTypeID);
  AddXMLNode(node,'Contact' ,Contact);
  AddXMLNode(node,'Reschedulled' ,Reschedulled);
  AddXMLNode(node,'CancellationDate' ,CancellationDate);
  AddXMLNode(node,'RescheduledDate' ,RescheduledDate);
  AddXMLNode(node,'Start_time' ,Start_time);
  AddXMLNode(node,'Actual_start_time' ,Actual_start_time);
  AddXMLNode(node,'End_time' ,End_time);
  AddXMLNode(node,'Actual_end_time' ,Actual_end_time);
  AddXMLNode(node,'StartVal' ,StartVal);
  AddXMLNode(node,'EndVal' ,EndVal);
  AddXMLNode(node,'Ph_support_till' ,Ph_support_till);
  AddXMLNode(node,'Rate' ,Rate);
  AddXMLNode(node,'TrainerCode' ,TrainerCode);
  AddXMLNode(node,'Notes' ,Notes);
  AddXMLNode(node,'FeedbackNotes' ,FeedbackNotes);
  AddXMLNode(node,'CalloutValue' ,CalloutValue);
  AddXMLNode(node,'ServiceDesc' ,ServiceDesc);
  AddXMLNode(node,'ProductDesc' ,ProductDesc);
  AddXMLNode(node,'Other' ,Other);
  AddXMLNode(node,'Othertxt' ,Othertxt);
  AddXMLNode(node,'Feedback' ,Feedback);
  AddXMLNode(node,'TotalInc' ,TotalInc);
  AddXMLNode(node,'TotalCost' ,TotalCost);
  AddXMLNode(node,'Msref' ,Msref);
  AddXMLNode(node,'AppearDays' ,AppearDays);
  AddXMLNode(node,'Classid' ,Classid);
  AddXMLNode(node,'RescheduledFrom' ,RescheduledFrom);
  AddXMLNode(node,'CustomerDetails' ,CustomerDetails);
  AddXMLNode(node,'Street' ,Street);
  AddXMLNode(node,'Street2' ,Street2);
  AddXMLNode(node,'Street3' ,Street3);
  AddXMLNode(node,'Suburb' ,Suburb);
  AddXMLNode(node,'State' ,State);
  AddXMLNode(node,'Country' ,Country);
  AddXMLNode(node,'Postcode' ,Postcode);
  AddXMLNode(node,'Phone' ,Phone);
  AddXMLNode(node,'AltPhone' ,AltPhone);
  AddXMLNode(node,'Fax' ,Fax);
  AddXMLNode(node,'Mobile' ,Mobile);
  AddXMLNode(node,'StartTime' ,StartTime);
  AddXMLNode(node,'Actual_StartTime' ,Actual_StartTime);
  AddXMLNode(node,'EndTime' ,EndTime);
  AddXMLNode(node,'Actual_EndTime' ,Actual_EndTime);
  AddXMLNode(node,'JobDueDate' ,JobDueDate);
  AddXMLNode(node,'ServiceID' ,ServiceID);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'RepairID' , RepairID);
//  AddXMLNode(node,'ResourceID' ,ResourceID);
  AddXMLNode(node,'Posid' ,Posid);
  AddXMLNode(node,'Converted' ,Converted);
  AddXMLNode(node,'Unavailable' ,Unavailable);
  AddXMLNode(node,'EnteredByEmployeeID' ,EnteredByEmployeeID);
  AddXMLNode(node,'EnteredByEmployeeName' ,EnteredByEmployeeName);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'LinkAppointID' ,LinkAppointID);
  AddXMLNode(node,'IsGroupParent' ,IsGroupParent);
  AddXMLNode(node,'Timesheetid' ,Timesheetid);
  AddXMLNode(node,'HrsToInvoice' ,HrsToInvoice);
  AddXMLNode(node,'Status' ,Status);
  AddXMLNode(node,'GoogleId' ,GoogleId);
  AddXMLNode(node,'SynchWithGoogle', SynchWithGoogle);
  RescheduleActions.SaveToXMLNode(node);
end;

function TAppointment.ValidateData :Boolean ;
begin
  Resultstatus.Clear;
  result:= inherited ValidateData;
  if not result then exit;
  Result := False;
  if (ClientID = 0) and not (self.Unavailable or Self.LocalApp) then begin
    AddResult(False , rssError , 0,  'Company Name cannot be blank');
    Exit;
  end;
  if AppDate = 0 then begin
    AddResult(False , rssError , 0,  'Please enter the appointment date');
    Exit;
  end;
  if CreationDate = 0 then begin
    AddResult(False , rssError , 0,  'CreationDate should not be blank');
    Exit;
  end;
  if UpdateDate = 0 then begin
    AddResult(False , rssError , 0,  'UpdateDate should not be blank');
    Exit;
  end;
  if TrainerID = 0 then begin
    AddResult(False , rssError , 0,  'Please enter a Rep');
    Exit;
  end;
  if Start_time = '' then begin
    AddResult(False , rssError , 0,  'Start_time should not be blank');
    Exit;
  end;
  if End_time = '' then begin
    AddResult(False , rssError , 0,  'End_time should not be blank');
    Exit;
  end;
  if StartTime = 0 then begin
    AddResult(False , rssError , 0,  'StartTime should not be blank');
    Exit;
  end;
  if EndTime = 0 then begin
    AddResult(False , rssError , 0,  'EndTime should not be blank');
    Exit;
  end;
  if EnteredByEmployeeName = '' then begin
    AddResult(False , rssError , 0,  'EnteredByEmployeeName should not be blank');
    Exit;
  end;
  if EnteredByEmployeeID = 0 then begin
    AddResult(False , rssError , 0,  'EnteredByEmployeeID should not be 0');
    Exit;
  end;
  if Status = '' then begin
    AddResult(False , rssError , 0,  'Status should not be blank');
    Exit;
  end;
  if Cancellation and (Trim(CancellationReason) = '') then begin
    AddResult(False , rssError , 0,  'Please enter a Cancellation Reason');
    Exit;
  end;
  if fRescheduled and (RescheduledDate = fOldDate) then begin
    AddResult(False , rssError , 0,  'Cannot Reschedule to the same date');
    Exit;
  end;
  if LastTrainerID < 0 then begin
    AddResult(False , rssError , 0,  'Last Trainer not found');
    Exit;
  end;
  if MedTypeID < 0 then begin
    AddResult(False , rssError , 0,  'Media Type not found');
    Exit;
  end;
  if ServiceID < 0 then begin
    AddResult(False , rssError , 0,  'Service not found');
    Exit;
  end;
  if RepairID < 0 then begin
    AddResult(False , rssError , 0,  'Repair GlobalRef not found');
    Exit;
  end;
  if ClassID < 0 then begin
    AddResult(False , rssError , 0,  'Department/Class not found');
    Exit;
  end;
  if PosID < 0 then begin
    AddResult(False , rssError , 0,  'Pos Sale GlobalRef not found');
    Exit;
  end;
  if LinkAppointID < 0 then begin
    AddResult(False , rssError , 0, 'Linked Appointment GlobalRef not found');
    Exit;
  end;
  if TimesheetID < 0 then begin
    AddResult(False , rssError , 0, 'Timesheet GlobalRef not found');
    Exit;
  end;
  if clientId =0 then begin
    if Unavailable or LocalApp then begin
      client.MakeClientFromCmpanyInfo(Appenv.CompanyInfo, True, False, False);
      ClientId :=client.ID;
      PostDB;
    end;
  end;
  if (AppEnv.CompanyPrefs.CreditCheckAppointment = 'T') and Active and not Converted then begin
    IsCustomerCreditOk;
    IsCustomerTermsOk;
  end;
  AllLinesValid := True;
  if Container.Exists(TEquipmentxRef) then begin
    Equipment.PostDb;
    Equipment.IterateRecords(LineValidateCallbackProc);
  end;
  if Container.Exists(TAppointmentsTimeLog) then begin
    AppointmentsTimeLog.PostDb;
    AppointmentsTimeLog.IterateRecords(LineValidateCallbackProc);
  end;
  Result := AllLinesValid;
end;


function TAppointment.Save: Boolean ;
var
  ShiftByDays: Integer;
  lIsNew, lDirty: Boolean;
begin
  lIsNew := IsNew;
  lDirty := Dirty;
  Result := False;
  if inherited Save then
  try
    try
      Equipment.PostDb;
    except
      on EAbort do begin end;
    end;
    if not ValidateData then Exit;
    AllLinesSavedOK := True;
    Equipment.IterateRecords(LineSaveCallbackProc, True);
    if not AllLinesSavedOK then Exit;
    AppointmentsTimeLog.IterateRecords(LineSaveCallbackProc, True);
    if not AllLinesSavedOK then Exit;

    //lStatusID := GetSimpleType(Status, SimpleTypes_AppointmentStatusType);

    if fRescheduled then
      try
        
        DoFieldChange := False;
        ShiftByDays := Trunc(RescheduledDate) - Trunc(fOldDate);
        AppDate := Trunc(RescheduledDate);
        StartTime := Trunc(RescheduledDate) + TimeOf(StartTime);
        EndTime := IncDay(EndTime, ShiftByDays);
        Start_time := FormatDateTime(MysqlTimeFormat12hr, StartTime);
        End_time := FormatDateTime(MysqlTimeFormat12hr, EndTime);
        AppDate := Trunc(StartTime);
        FieldByName('RescheduledDate').Clear;
        PostDB;
        
        RescheduleLinkedAppointments;
        try
          TLeadToAddProgressionRecord.AddProgressionRecord(ClientID, LeadActionAppointment, Id, globalref,
            Format('Appointment#' + Trim(GlobalRef) + ' rescheduled from %s to %s', [FormatDateTime('d mmm yyyy', fOldDate), FormatDateTime('d mmm yyyy', AppDate)]),fOldDate  ,
            0, '', True, TrainerID , tcDatautils.GetSimpleType('Rescheduled',SimpleTypes_AppointmentStatusType));
        except
          on E: Exception do begin end;
        end;
      finally
        fRescheduled:= false;
        DoFieldChange := True;
      end;
    fOldDate := AppDate;
    MakeTimesheetEntry;
    PostDB;
    Result := True;
    try
        if Active = FAlse then
            TLeadToAddProgressionRecord.AddProgressionRecord(ClientID, LeadActionAppointment, Id, GlobalRef, Notes, AppDate, Id, globalref, True, TrainerID, GetSimpleType('Deleted', SimpleTypes_AppointmentStatusType))
        else if Cancellation then
            TLeadToAddProgressionRecord.AddProgressionRecord(ClientID, LeadActionAppointment, Id, GlobalRef, Notes, AppDate, Id, globalref, True, TrainerID, GetSimpleType('Cancelled', SimpleTypes_AppointmentStatusType))
        else if Actual_StartTime <> 0 then
            TLeadToAddProgressionRecord.AddProgressionRecord(ClientID, LeadActionAppointment, Id, GlobalRef, Notes, Actual_StartTime, Id, globalref, True, TrainerID, GetSimpleType('Sat', SimpleTypes_AppointmentStatusType))
        else if Actual_AppDate <> 0 then
            TLeadToAddProgressionRecord.AddProgressionRecord(ClientID, LeadActionAppointment, Id, GlobalRef, Notes, Actual_AppDate, Id, globalref, True, TrainerID, GetSimpleType('Sat', SimpleTypes_AppointmentStatusType))
        else if Starttime <> 0 then
            TLeadToAddProgressionRecord.AddProgressionRecord(ClientID, LeadActionAppointment, Id, GlobalRef, Notes, Starttime, Id, globalref, True, TrainerID, GetSimpleType(Status, SimpleTypes_AppointmentStatusType))
        else if Actual_AppDate <> 0 then
            TLeadToAddProgressionRecord.AddProgressionRecord(ClientID, LeadActionAppointment, Id, GlobalRef, Notes, AppDate, Id, globalref, True, TrainerID, GetSimpleType(Status, SimpleTypes_AppointmentStatusType))
        else TLeadToAddProgressionRecord.AddProgressionRecord(ClientID, LeadActionAppointment, Id, GlobalRef, Notes, AppDate, Id, globalref, False, TrainerID, GetSimpleType(Status, SimpleTypes_AppointmentStatusType));
    except
      on E: Exception do begin end;
    end;

  finally
    if not Result then begin
      if lIsNew then IsNew := True;
      if lDirty then Dirty := True;
    end;
  end;
end;

procedure TAppointment.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
var
  lChangeType: TBusObjDataChangeType;
  lStr: string;
begin
  inherited;
//  TBusObjDataChangeType = (dcLoad, dcDelete, dcNew, dcSave, dcClose);
  if (ChangeType = dcLoad) and (Dataset.State = dsInsert) then
    lChangeType := dcNew
  else
    lChangeType := ChangeType;
  if GUIMode and (lChangeType = dcLoad) then begin
    IgnoreAccesslevel := True;
    DoFieldChange := False;
    try
      if DateOf(StartTime) <> DateOf(AppDate) then
        StartTime := DateOf(AppDate) + TimeOf(StartTime);
      lStr := FormatDateTime(MysqlTimeFormat12hr, StartTime);
      if Start_time <> lStr then
        Start_time := lStr;
      lStr := FormatDateTime(MysqlTimeFormat12hr, EndTime);
      if End_time <> lStr then
        End_time := lStr;
      PostDB;
    finally
      IgnoreAccesslevel := False;
      DoFieldChange := True;
    end;
    fRescheduled := False;
    fOldDate := AppDate;
  end;
end;


procedure TAppointment.DoFieldOnChange(Sender: TField);

  function SenderIs(const AFieldName: string): Boolean;
  begin
    Result := uppercase(Sender.FieldName) = uppercase(AFieldName);
  end;

begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then Exit;
  inherited;

  if SenderIs('ClientName') then begin
    ClientID := TClient.IDToggle(Sender.AsString, Connection.Connection);
    DoFieldOnChange(dataset.FindField('CusID'));
  end else if SenderIs('TrainerID') then begin
    if not RawMode then begin
      if not VArIsNull(Sender.OldValue) and (Sender.OldValue <> Sender.Value) then
        SendEvent(BusObjEvent_Change,BusObjEvent_TrainerChanged, self);
      GetService; // Check that the employee has this service
      if Assigned(fOnRefreshAvailableServices) then
        fOnRefreshAvailableServices(Self);
    end;
  end else if SenderIs('CalloutValue') then begin
    if not RawMode then begin
      CalcTotals;
    end;
  end else if SenderIs('CusID') then begin
    ClientName := TClient.IDToggle(Sender.asInteger, Connection.Connection);
    if not RawMode then begin
      DoClientIDChange;
    end;
  end else if SenderIs('ProductID') then begin
    if ProductDesc = '' then ProductDesc := TProduct.IDToggle(ProductID);
    if ProductID<> 0 then begin
      CheckForProductService;
      DoFieldOnChange(Dataset.Findfield('ServiceID'));
      SendEvent(BusObjEvent_Change,BusObjEventVal_ProductID, self);
    end;
  end else if SenderIs('ProductDesc') then begin
    if ProductDesc <> '' then begin
      ProductId := TProduct.IDToggle(ProductDesc);
      if ProductId =0 then ProductDesc := '';
      DoFieldOnChange(Dataset.Findfield('ProductID'));
    end;
  end else if SenderIs('ServiceID') then begin
    if ServiceID > 0 then
      ServiceDesc:= TServices.IDToggle(ServiceID, Connection.Connection)
    else begin
      ServiceDesc:= '';
    end;
    if not RawMode then begin
      RefreshServiceDetails;
    end;
  end else if SenderIs('ServiceDesc') then begin
    if ServiceDesc <> '' then begin
      ServiceID:= TServices.IDToggle(ServiceDesc, Connection.Connection);
      if ServiceID = 0 then
        ServiceID := -1;
    end
    else
      ServiceID:= 0;
    if not RawMode then begin
      if (Sender.AsString = '') or not Service.FindService(ServiceDesc) then
        if ProductId =0 then ServiceID := 0;
    end;
  end else if SenderIs('Cancellation') then begin
    if not RawMode then begin
      if Sender.Value = Sender.OldValue then Exit;
      if Cancellation then
        CancellationDate := Now
      else begin
        FieldByName('CancellationDate').Clear;
        FieldByName('CancellationReason').Clear;
      end;
    end;
  end else if SenderIs('Reschedulled') then begin
    if not RawMode then begin
      if (Sender.AsString = 'F') and not VarIsNull(Sender.OldValue) and not fRescheduled then
        Sender.AsString := 'T'
      else begin
        if (Sender.AsString = 'T') and (Sender.OldValue <> 'T') then
          SetDateTimeField('RescheduledDate', AppDate);
        fRescheduled := (Sender.AsString = 'T');
        if not fRescheduled then begin
          FieldByName('RescheduledDate').Clear;
          FieldByName('RescheduledFrom').Clear;
        end;
      end;
    end;
  end else if SenderIs('RescheduledDate') then begin
    if not RawMode then begin
      if fOldDate = 0 then fOldDate := AppDate;
      RescheduledFrom := fOldDate ;
    end
  end
  else if SenderIs('EnteredByEmployeeID') then begin
    if EnteredByEmployeeID > 0 then
      EnteredByEmployeeName:= TEmployee.IDToggle(EnteredByEmployeeID, Connection.Connection)
    else
      EnteredByEmployeeName := '';
  end
  else if SenderIs('EnteredByEmployeeName') then begin
    if EnteredByEmployeeName <> '' then
      EnteredByEmployeeID:= TEmployee.IDToggle(EnteredByEmployeeName, Connection.Connection)
    else
      EnteredByEmployeeID := 0;
  end
  else begin
    if not RawMode then begin
      Handledatechanges(Sender);
    end;
  end;
end;

Procedure TAppointment.CheckForProductService;
begin
  if productId =0 then exit;

  With TProduct.CreateWithNewConn(Owner) do try
    Connection.Connection := CommonDBLib.GetSharedMyDacConnection;//Self.Connection;
    Load(Self.ProductID);
    if isInvProduct then begin
      ProductDesc := '';
      ServiceId :=0;
      ServiceDesc := '';
      Exit;
    end;
    Self.Rate := SellQty1PriceInc;
  finally
    Free;
  end;

  with Tservices.CreateWithNewConn(Owner) do try
    Connection.Connection := CommonDBLib.GetSharedMyDacConnection;//Self.Connection;
    LoadSelect('ProductId =' + inttostr(Self.ProductId));
    if count =0 then begin
      New;
      ProductId := Self.ProductID;
      ServiceDesc := ProductDesc;
      StandardRate := TProductSimple.ProductPrice(Self.ProductID);
      PostDB;
    end;
    Self.ServiceID := ID;
    Self.ServiceDesc :=ServiceDesc ;
  finally
    Free;
  end;
  Self.PostDB;
end;
function TAppointment.GetSQL: string;
begin
  Result := Inherited GetSQL;
end;

class function TAppointment.GetIDField: string;
begin
  Result := 'Appointid'
end;

class function TAppointment.GetBusObjectTablename: string;
begin
  Result := 'tblappointments';
end;

function TAppointment.DoAfterPost(Sender: TDatasetBusObj ):Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function  TAppointment.DoBeforePost(Sender: TDatasetBusObj ):Boolean;
begin
    Result := inherited DoBeforePost(Sender);
    if not result then exit;
    UpdateDate := now;
end;

{property functions}
function  TAppointment.GetClientID             : Integer   ; begin Result := GetIntegerField('Cusid');end;
function TAppointment.GetClientMobile: string;
begin
  Result := FieldByNameValue('SELECT Mobile FROM tblClients WHERE ClientID = ' + IntToStr(ClientID), 'Mobile');
end;

function  TAppointment.GetAppDate              : TDateTime ; begin Result := GetDatetimeField('AppDate');end;
function  TAppointment.GetActual_AppDate       : TDateTime ; begin Result := GetDatetimeField('Actual_AppDate');end;
function  TAppointment.GetCreationDate         : TDateTime ; begin Result := GetDatetimeField('CreationDate');end;
function  TAppointment.GetUpdateDate           : TDateTime ; begin Result := GetDatetimeField('UpdateDate');end;
function  TAppointment.GetGoogleUpdated        : TDateTime ; begin Result := GetDatetimeField('GoogleUpdated');end;
function  TAppointment.GetCancellation         : Boolean   ; begin Result := GetBooleanField('Cancellation');end;
function  TAppointment.GetCancellationReason   : string    ; begin Result := GetStringField('CancellationReason');end;
//function  TAppointment.GetTrainRateID          : Integer   ; begin Result := GetIntegerField('TrainRateID');end;
function  TAppointment.GetTrainerID            : Integer   ; begin Result := GetIntegerField('Trainerid');end;
function  TAppointment.GetLastTrainerID        : Integer   ; begin Result := GetIntegerField('LastTrainerID');end;
function TAppointment.GetLastTrainerName: string;
begin
  if LastTrainerID > 0 then
    result:= TEmployee.IDToggle(LastTrainerID, Connection.Connection)
  else
    result:= '';
end;

function TAppointment.GetMediaType: string;
begin
  if MedTypeID > 0 then
    result:= TSource.IDToggle(MedTypeID, Connection.Connection)
  else
    result:= '';
end;

function  TAppointment.GetMedTypeID            : Integer   ; begin Result := GetIntegerField('MedTypeID');end;
function  TAppointment.GetContact              : string    ; begin Result := GetStringField('Contact');end;
function  TAppointment.GetReschedulled         : Boolean   ; begin Result := GetBooleanField('Reschedulled');end;
function  TAppointment.GetCancellationDate     : TDateTime ; begin Result := GetDatetimeField('CancellationDate');end;
function  TAppointment.GetRescheduledDate      : TDateTime ; begin Result := GetDatetimeField('RescheduledDate');end;
function  TAppointment.GetStart_time           : string    ; begin Result := GetStringField('Start_time');end;
function  TAppointment.GetActual_start_time    : string    ; begin Result := GetStringField('Actual_start_time');end;
function  TAppointment.GetEnd_time             : string    ; begin Result := GetStringField('End_time');end;
function  TAppointment.GetActual_end_time      : string    ; begin Result := GetStringField('Actual_end_time');end;
function  TAppointment.GetStartVal             : Double    ; begin Result := GetFloatField('StartVal');end;
function  TAppointment.GetEndVal               : Double    ; begin Result := GetFloatField('EndVal');end;
function  TAppointment.GetPh_support_till      : TDateTime ; begin Result := GetDatetimeField('Ph_support_till');end;
function  TAppointment.GetRate                 : Double    ; begin Result := GetFloatField('Rate');end;
function TAppointment.GetRepairGlobalRef: string;
begin
  if RepairID > 0 then
    result := TRepairs.IDGlobalRefToggle(RepairID, Connection.Connection)
  else
    result:= '';
end;

function  TAppointment.GetTrainerCode          : string    ; begin Result := GetStringField('TrainerCode');end;
function  TAppointment.GetNotes                : string    ; begin Result := GetStringField('Notes');end;
function  TAppointment.GetFeedbackNotes        : string    ; begin Result := GetStringField('FeedbackNotes');end;
function TAppointment.GetGoogleId: string;
begin
  result := GetStringField('GoogleId');
end;

function  TAppointment.GetCalloutValue         : Double    ; begin Result := GetFloatField('CalloutValue');end;
function  TAppointment.GetServiceDesc          : string    ; begin Result := GetStringField('ServiceDesc');end;
function  TAppointment.GetProductDesc          : string    ; begin Result := GetStringField('ProductDesc');end;
function  TAppointment.GetOther                : Boolean   ; begin Result := GetBooleanField('Other');end;
function  TAppointment.GetOthertxt             : string    ; begin Result := GetStringField('Othertxt');end;
function  TAppointment.GetFeedback             : Boolean   ; begin Result := GetBooleanField('Feedback');end;
function  TAppointment.GetTotalInc             : Double    ; begin Result := GetFloatField('TotalInc');end;
function  TAppointment.GetTotalCost            : Double    ; begin Result := GetFloatField('TotalCost');end;
function  TAppointment.GetMsref                : string    ; begin Result := GetStringField('Msref');end;
function  TAppointment.GetAppearDays           : Integer   ; begin Result := GetIntegerField('AppearDays');end;
function  TAppointment.GetClassID              : Integer   ; begin Result := GetIntegerField('Classid');end;
function TAppointment.GetCleanTrainerId: integer;
begin
  result := self.GetXMLNodeIntegerValue(self.GetCleanXMLNode, 'TrainerId');
end;

function  TAppointment.GetRescheduledFrom      : TDateTime ; begin Result := GetDatetimeField('RescheduledFrom');end;
function  TAppointment.GetCustomerDetails      : string    ; begin Result := GetStringField('CustomerDetails');end;
function  TAppointment.GetStreet               : string    ; begin Result := GetStringField('Street');end;
function  TAppointment.GetStreet2              : string    ; begin Result := GetStringField('Street2');end;
function  TAppointment.GetStreet3              : string    ; begin Result := GetStringField('Street3');end;
function  TAppointment.GetSuburb               : string    ; begin Result := GetStringField('Suburb');end;
function  TAppointment.GetState                : string    ; begin Result := GetStringField('State');end;
function  TAppointment.GetCountry              : string    ; begin Result := GetStringField('Country');end;
function  TAppointment.GetPostcode             : string    ; begin Result := GetStringField('Postcode');end;
function TAppointment.GetDeptClassName: string;
begin
  if ClassID > 0 then
    result := TDeptClass.IDToggle(ClassID, Connection.Connection)
  else
    result := '';
end;

function  TAppointment.GetPhone                : string    ; begin Result := GetStringField('Phone');end;
function  TAppointment.GetAltPhone             : string    ; begin Result := GetStringField('AltPhone');end;
function  TAppointment.GetFax                  : string    ; begin Result := GetStringField('Fax');end;
function  TAppointment.GetMobile               : string    ; begin Result := GetStringField('Mobile');end;
function  TAppointment.GetStartTime            : TDateTime ; begin Result := GetDatetimeField('StartTime');end;
function  TAppointment.GetActual_StartTime     : TDateTime ; begin Result := GetDatetimeField('Actual_StartTime');end;
function  TAppointment.GetEndTime              : TDateTime ; begin Result := GetDatetimeField('EndTime');end;
function  TAppointment.GetActual_EndTime       : TDateTime ; begin Result := GetDatetimeField('Actual_EndTime');end;
function  TAppointment.GetJobDueDate           : TDateTime ; begin Result := GetDatetimeField('JobDueDate');end;
function  TAppointment.GetServiceID            : Integer   ; begin Result := GetIntegerField('ServiceID');end;
function  TAppointment.GetProductID            : Integer   ; begin Result := GetIntegerField('ProductID');end;
//function  TAppointment.GetResourceID           : Integer   ; begin Result := GetIntegerField('ResourceID');end;
function  TAppointment.GetPosID                : Integer   ; begin Result := GetIntegerField('Posid');end;
function TAppointment.GetPosSaleGlobalRef: string;
begin
  if PosId > 0 then
    result:= TSalesBase.IDGlobalRefToggle(PosID, Connection.Connection)
  else
    result:= '';
end;

function  TAppointment.GetConverted            : Boolean   ; begin Result := GetBooleanField('Converted');end;
function  TAppointment.GetUnavailable          : Boolean   ; begin Result := GetBooleanField('Unavailable');end;
function  TAppointment.GetEnteredByEmployeeID  : Integer   ; begin Result := GetIntegerField('EnteredByEmployeeID');end;
function  TAppointment.GetEnteredByEmployeeName: string    ; begin Result := GetStringField('EnteredByEmployeeName');end;
function  TAppointment.GetActive               : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TAppointment.GetLinkAppointID        : Integer   ; begin Result := GetIntegerField('LinkAppointID');end;
function  TAppointment.GetLinkedAppointmentGlobalRef: string;
begin
  if (LinkAppointID > 0) and (LinkAppointID <> ID) then
    result := TAppointment.IDGlobalRefToggle(LinkAppointID, Connection.Connection)
  else
    result := '';
end;

function TAppointment.GetLocalApp: Boolean;
begin
  Result := GetBooleanField('LocalApp');
end;

function  TAppointment.GetIsGroupParent        : Boolean   ; begin Result := GetBooleanField('IsGroupParent');end;
function TAppointment.GetTimeSheetGlobalRef: string;
begin
  if TimesheetID > 0 then
    result := TTimeSheet.IDGlobalRefToggle(TimesheetID, Connection.Connection)
  else
    result := '';
end;

function  TAppointment.GetTimesheetID          : Integer   ; begin Result := GetIntegerField('Timesheetid');end;
function  TAppointment.GetHrsToInvoice         : Double    ; begin Result := GetFloatField('HrsToInvoice');end;
function  TAppointment.GetStatus               : string    ; begin Result := GetStringField('Status');end;
Function  TAppointment.GetTypeOfBasedOn    : String;     Begin Result := GetStringField('TypeOfBasedOn'); End;
Function  TAppointment.GetFrequencyValues  : String;     Begin Result := GetStringField('FrequencyValues'); End;
Function  TAppointment.GetCopyStartDate    : TDateTime;  Begin Result := GetDateTimeField('CopyStartDate'); End;
Function  TAppointment.GetCopyFinishDate   : TDateTime;  Begin Result := GetDateTimeField('CopyFinishDate'); End;

function TAppointment.GetSynchWithGoogle: boolean;
begin
  result := GetBooleanField('SynchWithGoogle');
end;

procedure TAppointment.SetClientID             (const Value: Integer   ); begin SetIntegerField('Cusid'                 , Value);end;
procedure TAppointment.SetAppDate              (const Value: TDateTime ); begin
  SetDateTimeField('AppDate'              , Value);
end;
procedure TAppointment.SetActual_AppDate       (const Value: TDateTime ); begin SetDateTimeField('Actual_AppDate'       , Value);end;
procedure TAppointment.SetCreationDate         (const Value: TDateTime ); begin SetDateTimeField('CreationDate'         , Value);end;
procedure TAppointment.SetUpdateDate           (const Value: TDateTime ); begin SetDateTimeField('UpdateDate'           , Value);end;
Procedure TAppointment.SetTypeOfBasedOn(Const Value: String);       Begin  SetStringField('TypeOfBasedOn', Value);  End;
Procedure TAppointment.SetFrequencyValues(Const Value: String);     Begin  SetStringField('FrequencyValues', Value);  End;
Procedure TAppointment.SetCopyStartDate(Const Value: TDateTime);    Begin  SetDateTimeField('CopyStartDate', Value);  End;
Procedure TAppointment.SetCopyFinishDate(Const Value: TDateTime);   Begin  SetDateTimeField('CopyFinishDate', Value);  End;
procedure TAppointment.SetGoogleUpdated        (const Value: TDateTime );
var
  flag:Boolean;
begin
  Flag := NullWhenDateIs0;
  NullWhenDateIs0:= true;
  try
    SetDateTimeField('GoogleUpdated' , Value);
  finally
    NullWhenDateIs0 := flag;
  end;
end;
function TAppointment.qryTotalLogTime: TERPQuery;
begin
  if aqryTotalLogTime = nil then begin
    aqryTotalLogTime:= DbSharedObjectsObj.DbSharedObj.GetQuery(Self.Connection.Connection);
    commondblib.closedb(aqryTotalLogTime);
    aqryTotalLogTime.SQL.TExt := //'SELECT sum(SecondsBetween(startdatetime,enddatetime)/60/60) as Seconds '+
                                ' SELECT sum( (time_to_sec(enddatetime) - TIME_TO_SEC(startdatetime)))/60/60 as Seconds '+
                                ' FROM tblappointmentstimelog   '+
                                ' WHERE IncludeForInvoice<> "F" and  startdatetime>0 and enddatetime>0  '+
                                ' AND appointId = '+ inttostr(ID);
    commondblib.OpenDB(aqryTotalLogTime);
  end else if fbTimeLogchanged or not(aqryTotalLogTime.active) then begin
    commondblib.closedb(aqryTotalLogTime);
    commondblib.OpenDB(aqryTotalLogTime);
  end;
  fbTimeLogchanged := False;
  result := aqryTotalLogTime;
end;

procedure TAppointment.SetCancellation         (const Value: Boolean   ); begin SetBooleanField('Cancellation'          , Value);end;
procedure TAppointment.SetCancellationReason   (const Value: string    ); begin SetStringField('CancellationReason'     , Value);end;
//procedure TAppointment.SetTrainRateID          (const Value: Integer   ); begin SetIntegerField('TrainRateID'           , Value);end;
procedure TAppointment.SetTrainerID            (const Value: Integer   ); begin SetIntegerField('Trainerid'             , Value);end;
procedure TAppointment.SetLastTrainerID        (const Value: Integer   ); begin SetIntegerField('LastTrainerID'         , Value);end;
procedure TAppointment.SetLastTrainerName(const Value: string);
begin
  if Value <> '' then begin
    LastTrainerID := TEmployee.IDToggle(Value, Connection.Connection);
    if LastTrainerID = 0 then
      LastTrainerID := -1;
  end
  else
    LastTrainerID := 0;
end;

procedure TAppointment.SetMediaType(const Value: string);
begin
  if Value <> '' then begin
    MedTypeID := TSource.IDToggle(Value, Connection.Connection);
    if MedTypeID = 0 then
      MedTypeID := -1;
  end
  else
    MedTypeID:= 0;
end;

procedure TAppointment.SetMedTypeID            (const Value: Integer   ); begin SetIntegerField('MedTypeID'             , Value);end;
procedure TAppointment.SetContact              (const Value: string    ); begin SetStringField('Contact'                , Value);end;
procedure TAppointment.SetReschedulled         (const Value: Boolean   ); begin SetBooleanField('Reschedulled'          , Value);end;
procedure TAppointment.SetCancellationDate     (const Value: TDateTime ); begin SetDateTimeField('CancellationDate'     , Value);end;
procedure TAppointment.SetRescheduledDate      (const Value: TDateTime ); begin SetDateTimeField('RescheduledDate'      , Value);end;
procedure TAppointment.SetStart_time           (const Value: string    ); begin SetStringField('Start_time'             , Value);(*SendEvent(BusObjEvent_Change,BusObjEvent_start_time, self);*)end;
procedure TAppointment.SetActual_start_time    (const Value: string    ); begin SetStringField('Actual_start_time'      , Value);end;
procedure TAppointment.SetEnd_time             (const Value: string    ); begin SetStringField('End_time'               , Value);(*SendEvent(BusObjEvent_Change,BusObjEvent_start_time, self);*)end;
procedure TAppointment.SetActual_end_time      (const Value: string    ); begin SetStringField('Actual_end_time'        , Value);end;
procedure TAppointment.SetStartVal             (const Value: Double    ); begin SetFloatField('StartVal'                , Value);end;
procedure TAppointment.SetEndVal               (const Value: Double    ); begin SetFloatField('EndVal'                  , Value);end;
procedure TAppointment.SetPh_support_till      (const Value: TDateTime ); begin SetDateTimeField('Ph_support_till'      , Value);end;
procedure TAppointment.SetRate                 (const Value: Double    ); begin SetFloatField('Rate'                    , Value);end;
procedure TAppointment.SetRepairGlobalRef(const Value: string);
begin
  if Value <> '' then begin
    RepairID := TRepairs.IDGlobalRefToggle(Value, Connection.Connection);
    if RepairID = 0 then
      RepairID := -1;
  end
  else
    RepairID:= 0;
end;

procedure TAppointment.SetTrainerCode          (const Value: string    ); begin SetStringField('TrainerCode'            , Value);end;
procedure TAppointment.SetNotes                (const Value: string    ); begin SetStringField('Notes'                  , Value);end;
procedure TAppointment.SetFeedbackNotes        (const Value: string    ); begin SetStringField('FeedbackNotes'          , Value);end;
procedure TAppointment.SetGoogleId(const Value: string);
begin
  SetStringField('GoogleId', Value);
end;

procedure TAppointment.SetCalloutValue         (const Value: Double    ); begin SetFloatField('CalloutValue'            , Value);end;
procedure TAppointment.SetServiceDesc          (const Value: string    ); begin SetStringField('ServiceDesc'            , Value);end;
procedure TAppointment.SetProductDesc          (const Value: string    ); begin SetStringField('ProductDesc'            , Value);end;
procedure TAppointment.SetOther                (const Value: Boolean   ); begin SetBooleanField('Other'                 , Value);end;
procedure TAppointment.SetOthertxt             (const Value: string    ); begin SetStringField('Othertxt'               , Value);end;
procedure TAppointment.SetFeedback             (const Value: Boolean   ); begin SetBooleanField('Feedback'              , Value);end;
procedure TAppointment.SetTotalInc             (const Value: Double    ); begin SetFloatField('TotalInc'                , Value);end;
procedure TAppointment.SetTotalCost            (const Value: Double    ); begin SetFloatField('TotalCost'               , Value);end;
procedure TAppointment.SetMsref                (const Value: string    ); begin SetStringField('Msref'                  , Value);end;
procedure TAppointment.SetAppearDays           (const Value: Integer   ); begin SetIntegerField('AppearDays'            , Value);end;
procedure TAppointment.setClassID              (const Value: Integer   ); begin SetIntegerField('Classid'               , Value);end;
procedure TAppointment.SetRescheduledFrom      (const Value: TDateTime ); begin SetDateTimeField('RescheduledFrom'      , Value);end;
procedure TAppointment.SetCustomerDetails      (const Value: string    ); begin SetStringField('CustomerDetails'        , Value);end;
procedure TAppointment.SetStreet               (const Value: string    ); begin SetStringField('Street'                 , Value);end;
procedure TAppointment.SetStreet2              (const Value: string    ); begin SetStringField('Street2'                , Value);end;
procedure TAppointment.SetStreet3              (const Value: string    ); begin SetStringField('Street3'                , Value);end;
procedure TAppointment.SetSuburb               (const Value: string    ); begin SetStringField('Suburb'                 , Value);end;
procedure TAppointment.SetState                (const Value: string    ); begin SetStringField('State'                  , Value);end;
procedure TAppointment.SetCountry              (const Value: string    ); begin SetStringField('Country'                , Value);end;
procedure TAppointment.SetPostcode             (const Value: string    ); begin SetStringField('Postcode'               , Value);end;


procedure TAppointment.SetDeptClassName(const Value: string);
begin
  if Value <> '' then begin
    ClassID := TDeptClass.IDToggle(Value, Connection.Connection);
    if ClassID = 0 then
      ClassID := -1;
  end
  else
    ClassID := 0;
end;

procedure TAppointment.SetPhone                (const Value: string    ); begin SetStringField('Phone'                  , Value);end;
procedure TAppointment.SetAltPhone             (const Value: string    ); begin SetStringField('AltPhone'               , Value);end;
procedure TAppointment.SetFax                  (const Value: string    ); begin SetStringField('Fax'                    , Value);end;
procedure TAppointment.SetMobile               (const Value: string    ); begin SetStringField('Mobile'                 , Value);end;
procedure TAppointment.SetJobDueDate           (const Value: TDateTime ); begin SetDateTimeField('JobDueDate'           , Value);end;
procedure TAppointment.SetServiceID            (const Value: Integer   ); begin SetIntegerField('ServiceID'             , Value);end;
procedure TAppointment.SetProductID            (const Value: Integer   ); begin SetIntegerField('ProductID'             , Value);end;
//procedure TAppointment.SetResourceID           (const Value: Integer   ); begin SetIntegerField('ResourceID'            , Value);end;
procedure TAppointment.SetPosID                (const Value: Integer   ); begin SetIntegerField('Posid'                 , Value);end;
procedure TAppointment.SetPosSaleGlobalRef(const Value: string);
begin
  if Value <> '' then begin
    PosID:= TSalesBase.IDGlobalRefToggle(Value, Connection.Connection);
    if PosID = 0 then
      PosID := -1;
  end
  else
    PosID:= 0;
end;

procedure TAppointment.SetConverted            (const Value: Boolean   ); begin SetBooleanField('Converted'             , Value);end;
procedure TAppointment.SetUnavailable          (const Value: Boolean   ); begin SetBooleanField('Unavailable'           , Value);end;
procedure TAppointment.SetActive               (const Value: Boolean   ); begin SetBooleanField('Active'                , Value);end;
procedure TAppointment.SetLinkAppointID        (const Value: Integer   ); begin SetIntegerField('LinkAppointID'         , Value);end;

procedure TAppointment.SetLinkedAppointmentGlobalRef(const Value: string);
begin
  if Value <> '' then begin
    LinkAppointID := TAppointment.IDGlobalRefToggle(Value, Connection.Connection);
    if LinkAppointID = 0 then
      LinkAppointID := -1;
  end
  else
    LinkAppointID:= 0;
end;

procedure TAppointment.SetLocalApp(const Value: Boolean);
begin
  SetBooleanField('LocalApp', Value);
end;

procedure TAppointment.SetIsGroupParent        (const Value: Boolean   ); begin SetBooleanField('IsGroupParent'         , Value);end;
procedure TAppointment.SetTimeSheetGlobalRef(const Value: string);
begin
  if Value <> '' then begin
    TimesheetID := TTimeSheet.IDGlobalRefToggle(Value, Connection.Connection);
    if TimesheetID = 0 then
      TimesheetID := -1;
  end
  else
    TimesheetID := 0;
end;

procedure TAppointment.SetTimesheetID          (const Value: Integer   ); begin SetIntegerField('Timesheetid'           , Value);end;
procedure TAppointment.SetHrsToInvoice         (const Value: Double    ); begin SetFloatField('HrsToInvoice'            , Value);end;
procedure TAppointment.SetStatus               (const Value: string    ); begin SetStringField('Status'                 , Value);end;

procedure TAppointment.SetSynchWithGoogle(const Value: boolean);
begin
  SetBooleanField('SynchWithGoogle', Value);
end;

procedure TAppointment.SetEnteredByEmployeeID(const Value: Integer);
begin
  SetIntegerField('EnteredByEmployeeID', Value);
end;

procedure TAppointment.SetEnteredByEmployeeName(const Value: string);
begin
  SetStringField('EnteredByEmployeeName', Value);
end;

procedure TAppointment.SetStartTime(const Value: TDateTime);
begin
  if DoFieldChange then
  try
    DoFieldChange := appdate =0;
    SetDateTimeField('StartTime', Value);
    ValidateStartTime(True);
  finally
    DoFieldChange := True;
  end
  else
    SetDateTimeField('StartTime', Value);
end;

procedure TAppointment.SetActual_StartTime(const Value: TDateTime);
begin
  if DoFieldChange then
  try
    DoFieldChange := False;
    SetDateTimeField('Actual_StartTime', Value);
    ValidateActual_StartTime(True);
  finally
    DoFieldChange := True;
  end
  else
    SetDateTimeField('Actual_StartTime', Value);
end;

procedure TAppointment.SetEndTime(const Value: TDateTime);
begin
  if DoFieldChange then
  try
    DoFieldChange := False;
    SetDateTimeField('EndTime', Value);
    ValidateEndTime(True);
  finally
    DoFieldChange := True;
  end
  else
    SetDateTimeField('EndTime', Value);
end;

procedure TAppointment.SetActual_EndTime(const Value: TDateTime);
begin
  if DoFieldChange then
  try
    DoFieldChange := False;
    SetDateTimeField('Actual_EndTime', Value);
    ValidateActual_EndTime(True);
  finally
    DoFieldChange := True;
  end
  else
    SetDateTimeField('Actual_EndTime', Value);
end;

function TAppointment.GetEquipment: TEquipmentxRef;
begin
  result := TEquipmentxRef(Getcontainercomponent(TEquipmentxRef ,'AppointmentID = '+ IntToStr(Self.Id)));
end;
function TAppointment.GetAppointmentsTimeLog: TAppointmentsTimeLog;
begin
  result := TAppointmentsTimeLog(Getcontainercomponent(TAppointmentsTimeLog ,'AppointID = '+ IntToStr(Self.Id)));
end;
function TAppointment.GetTotalLogTime: Double;
begin
  result := round(qryTotalLogTime.Fieldbyname('Seconds').asFloat,2);
(*  fdTotalLogTime := 0;
  try
    AppointmentsTimeLog.PostDB;
    if AppointmentsTimeLog.count =0 then exit;
    AppointmentsTimeLog.Iteraterecords(TotalLogTimeCallback);
  finally
    REsult :=fdTotalLogTime;
  end;*)
end;
(*Procedure TAppointment.TotalLogTimeCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is TAppointmentsTimeLog then begin
    if (TAppointmentsTimeLog(Sender).EndDAteTime<>0) and (TAppointmentsTimeLog(Sender).StartDateTime <> 0) then
      fdTotalLogTime := fdTotalLogTime + round((TAppointmentsTimeLog(Sender).EndDAteTime - TAppointmentsTimeLog(Sender).StartDateTime) * 24, 2)
  end;
end;*)

function TAppointment.GetActual_TotalHours: Double;
begin
  Result := TotalLogTime;
  if result >0 then exit;
  if (Actual_EndTime<>0) and (Actual_StartTime <> 0) then
    Result := round((Actual_EndTime - Actual_StartTime) * 24, 2)
  else Result := TotalHours;
  if Result < 0 then result:= 0;
end;

function TAppointment.GetTotalHours: Double;
begin
  result := 0;
  if(EndTime<>0) and ( StartTime<>0) then Result := RoundTo((EndTime - StartTime) * 24, -2);
  if result < 0 then result:= 0;
end;

function TAppointment.GetActual_TotalHoursStr: string;
begin
  //if (Actual_Start_time = '') or (Actual_End_time = '') then
  if Actual_TotalHours =0 then
    Result := '0.0'
  else
    Result := (*Format('%.1f', [Actual_TotalHours])*)FloatToStr(Actual_TotalHours);
end;

function TAppointment.GetTotalHoursStr: string;
begin
  if (Start_time = '') or (End_time = '') then
    Result := '0.0'
  else
    Result := (*Format('%.1f', [TotalHours])*)FloattoStr(TotalHours);
end;

function TAppointment.GetService: TRepServices;
begin
  REsult :=  TRepServices(getContainerComponent(TRepServices ,'ServiceID = ' + IntToStr(ServiceID) +
                                                              ' and EmployeeId = ' + IntToStr(trainerID), Self.SilentMode,true  ));
end;

function TAppointment.GetClientAppointmentCount: Integer;
begin
  Result := Client.Apptcount[StartTime];
end;

procedure TAppointment.CalcTotals;
begin
  if Converted then Exit;
  if Service.IsFixedRate then begin
    TotalInc := Rate(* + CalloutValue*);
    if Service.PayRate <> 0 then
      TotalCost := Service.PayRate
    else
      TotalCost := Rate;
    HrsToInvoice := 0;
  end else begin
    if (Actual_Start_time <> '') and (Actual_End_time <> '') then begin
      if ClientHoursLeft >= Actual_TotalHours then
        HrsToInvoice := 0
      else
        HrsToInvoice := Actual_TotalHours - ClientHoursLeft;
    end else if (Start_time <> '') and (End_time <> '') then begin
      if ClientHoursLeft >= TotalHours then
        HrsToInvoice := 0
      else
        HrsToInvoice := TotalHours - ClientHoursLeft;
    end;
    if (HrsToInvoice <> 0) and (Rate <> 0) then begin
      TotalInc := (HrsToInvoice * Rate) (*+ CalloutValue*);
      TotalCost := (HrsToInvoice * Service.PayRate);
      if TotalCost = 0 then
        TotalCost := (HrsToInvoice * Rate);
    end else begin
      TotalInc := 0;
      TotalCost := 0;
    end;
  end;
  TotalInc := TotalInc + CalloutValue;

  if Assigned(fOnTotalsChange) then
    fOnTotalsChange(Self);
end;

function TAppointment.GetTrainerName: string;
begin
  result:= TEmployee.IDToggle(self.TrainerID, self.Connection.Connection);
end;

procedure TAppointment.SetTrainerName(const Value: string);
begin
  TrainerId:= TEmployee.IDToggle(Value, self.Connection.Connection);
end;

procedure TAppointment.RefreshServiceDetails(DeleteRepService, Recalculating: Boolean);
var
  lDoFieldChange: Boolean;
begin
  lDoFieldChange := DoFieldChange;
  DoFieldChange := False;
  try
    Service.Closedb;
    Logtext(Service.SQL);
    Logtext(inttostr(Service.count));
    if (ServiceID <> 0) and not(DeleteRepService) and (Service.count=0) then begin
      {just making sure the employee has the service - this is becuase the forms doesn't filter for services of hte employee }
      Service.NewService(trainerID, ServiceID , Rate);
      (*Service.New;
      Service.EmployeeId := trainerID;
      Service.ServiceID  := ServiceID;
      Service.Rate :=Rate;
      Service.PostDB;*)
      SendEvent(BusObjEvent_Change,BusObjEvent_RepServiceCreate, self);
    end;
    if (ServiceID = 0) or DeleteRepService or ((Service.count=0) and (ProductID=0)) then begin
      ServiceID := 0;
      ServiceDesc := '';
      if not DeleteRepService and not Recalculating and not Converted then
        Rate := 0.0;
    end else if not (Service.count=0) then begin
      EnsureMyQuery(Service.Dataset);
      TERPQuery(Service.Dataset).RefreshRecord;
      ServiceDesc := Service.ServiceDesc;
      if not Recalculating and not Converted then
        Rate := Service.Rate;
    end;
    CalcClientHoursLeft;
    if Assigned(fOnServiceIDChange) then
      fOnServiceIDChange(Self);
    CalcTotals;
  finally
    DoFieldChange := lDoFieldChange;
  end;
end;

function TAppointment.GetClientEmail: string;
begin
  Result := FieldByNameValue('SELECT Email FROM tblClients WHERE ClientID = ' + IntToStr(ClientID), 'Email');
end;

function TAppointment.GetRepEmail: string;
begin
  Result := FieldByNameValue('SELECT Email FROM tblEmployees WHERE EmployeeID = ' + IntToStr(TrainerID), 'Email');
end;

function TAppointment.GetRepMobile: string;
begin
  Result := FieldByNameValue('SELECT Mobile FROM tblEmployees WHERE EmployeeID = ' + IntToStr(TrainerID), 'Mobile');
end;

procedure TAppointment.DoClientIDChange;
var
  lClass: string;
  lQuery: TDataset;
begin
  lClass := GetClientDefaultClass(ClientID);
  ClientPrintName := Client.Printname;
  if Empty(lClass) then
    ClassID := AppEnv.DefaultClass.ClassID
  else
    ClassID := GetDeptID(lClass);

  if ClientID > 0 then begin
    CustomerDetails := RemoveBlankLines(Client.ClientDetails);
    Street := Client.Street;
    Street2 := Client.Street2;
    Street3 := Client.Street3;
    Suburb := Client.Suburb;
    State := Client.State;
    Country := Client.Country;
    Postcode := Client.Postcode;
    Phone := Client.Phone;
    AltPhone := Client.AltPhone;
    Self.Fax := Client.FaxNumber;
    Mobile := Client.Mobile;
    MedTypeID := Client.MedTypeID;
    AssignCustomFields(Client, Self, cftAppointment);

    lQuery := nil;
    try
      lQuery := GetNewDataset(Format('SELECT TrainerID FROM tblAppointments '
        + 'WHERE CusID = %d ORDER BY AppointID desc LIMIT 1', [ClientID]));
      if lQuery.Eof then
        LastTrainerID := 0
      else
        LastTrainerID := lQuery.FieldByName('TrainerID').AsInteger;
    finally
      FreeandNil(lQuery);
    end;
  end else begin
    CustomerDetails := '';
    Street := '';
    Street2 := '';
    Street3 := '';
    Suburb := '';
    State := '';
    Country := '';
    Postcode := '';
    Phone := '';
    AltPhone := '';
    Fax := '';
    Mobile := '';
    MedTypeID := 0;
    LastTrainerID := 0
  end;
  CalcTotals;
  if Assigned(fOnClientIDChange) then
    fOnClientIDChange(Self);
end;

procedure TAppointment.CalcClientHoursLeft;
begin
  if Converted or (ServiceID = 0) or Service.IsFixedRate then
    fClientHoursLeft := 0.0
  else
    fClientHoursLeft := Client.Hours;
end;

function TAppointment.Lock: Boolean;
var
  lQuery: TDataset;
  strSQL:String;
begin
  result := True;
  try
      Result := inherited Lock;
      if not result then exit;

      lQuery := nil;
      try
        strSQL:='SELECT AppointID FROM tblappointments '  +
                ' WHERE (LinkAppointId = ' +IntToStr(id)+') ';
        if LinkAppointID <> 0 then
          strSQL:= strSQL+ '  OR (LinkAppointId = ' +IntToStr(LinkAppointID)+') OR (AppointID = ' +IntToStr(LinkAppointID)+')';

        lQuery := GetNewDataSet(strSQL);
        while not lQuery.Eof do begin
          Result := UserLock.Lock(BusObjectTableName, lQuery.FieldByName('AppointID').AsInteger, BusObjectTypeDescription);
          if not result then break;
          lQuery.Next;
        end;
      finally
        FreeandNil(lQuery);
      end;
  finally
    if not Result then begin
      Unlock;
      AccessManager.AccessLevel := 5; //Read only
    end;
  end;
end;

procedure TAppointment.Recalculate;
begin
  RefreshServiceDetails(False, True);
end;

function TAppointment.GetClient: TClient;
begin
  Result := TClient(getContainerComponent(Tclient, 'ClientID = ' + IntToStr(ClientID), true, true, true, '',true));
end;

function TAppointment.IsCustomerCreditOk: Boolean;
var
  rBalance: Currency;
  strMsg: string;
  function AppointmentDate:TdateTime;
  begin
      if Actual_AppDate<> 0 then result :=Actual_AppDate
      else result := AppDate; 
  end;
begin
  rBalance := Client.CreditBalance + TotalInc;
  Result := (rBalance = 0) or ((rBalance < Client.CreditLimit) and (Date > (incDay(AppointmentDate, Client.GracePeriod))))  ;
  if not Result then begin
    strMsg := Format('Customer has Exceeded Credit Limit'#13#10'Limit: %m'#13#10'Amount: %m', [Client.CreditLimit, rBalance]);

    if not Service.IsFixedRate and (ClientHoursLeft <> 0) then
      strMsg := Format('%s'#13#10'Client has %d hours left', [strMsg, ClientHoursLeft]);
    AddResult(True, rssWarning, 0, strMsg);
  end;
end;

function TAppointment.IsCustomerTermsOk: boolean;
var
  lQuery: TERPQuery;
begin
  Result := True;
  lQuery := TERPQuery.Create(Self);
  try
    lQuery.Options.FlatBuffers := True;
    lQuery.Connection := GetSharedMyDacConnection;
    lQuery.SQL.Text := Format('SELECT DueDate FROM tblsales '
      + 'WHERE (ClientID = %d) AND (IsInvoice = "T") AND (PAID <> "T")'
      + '  AND (TotalAmountInc > 0.00) AND (Balance > 0.0)'
      + '  AND (DueDate < :CreditExpiry) ORDER BY DueDate LIMIT 1', [ClientID]);
    lQuery.ParamByName('CreditExpiry').AsDate := Today - Client.GracePeriod;
    lQuery.Open;
    if not lQuery.Eof then begin
      AddResult(True, rssWarning, 0, Format(
        'Customer has exceeded Terms on previous Sale'#13#10'Date Due: %s', [lQuery.FieldByName('DueDate').AsString]));
      Result := False;
    end;
  finally
    FreeandNil(lQuery);
  end;
end;

function TAppointment.ConvertToInvoice(var Invoice: TInvoice): Boolean;
var
  iClientID: Integer; // Client to bill for services
  dTotalHours, AdjustedTotalHours: Double;
  qryParts: TERPQuery;
  SaveIsReadOnly: Boolean;

  Procedure addProgressmsg(Const Value:string);
  begin
    SendEvent(BusObjEvent_Log, Value, self);
  end;

  procedure AdjustOutstandingHours;
  begin
    AdjustedTotalHours := 0;
    {when the preference is off, should not consider the customer free hours - dene }
    //if companypref.ShowServiceHrsInInvoiceQty = False then begin
    if Service.IsFixedRate then
      AdjustedTotalHours := dTotalHours
    else begin
      if Invoice.Customer.Hours > 0 then begin
        if Invoice.Customer.Lock then begin
          SaveIsReadOnly := Invoice.Customer.IsReadonly;
          Invoice.Customer.IsReadonly := False;
          try
            if Invoice.Customer.Hours >= dTotalHours then begin
              Invoice.Customer.Hours := Invoice.Customer.Hours - dTotalHours;
              Invoice.Customer.PostDb;
              AdjustedTotalHours := 0;
            end else begin
              AdjustedTotalHours := dTotalHours - Invoice.Customer.Hours;
              Invoice.Customer.Hours := 0;
              Invoice.Customer.PostDb;
            end;
          finally
            Invoice.Customer.IsReadonly:= SaveIsReadOnly;
          end;
        end;
      end else
        AdjustedTotalHours := dTotalHours;
    end;
  end;

  function GetPartDetails(const PartName: string):Boolean;
  begin
    if not Assigned(qryParts) then begin
      qryParts := TERPQuery.Create(nil);
      qryParts.Options.FlatBuffers := True;
      qryParts.Connection := GetSharedMyDacConnection;
    end;
    qryParts.SQL.Text := Format('SELECT IncomeAccnt, AssetAccnt, COGSAccnt,PARTSID, PartName, ' +
      ' PartsDescription, PartType, tbltaxcodes.Name as TaxCode,PRICE1, Rate ' + //, UnitOfMeasureSales, UnitOfMeasureIDSales, tblunitsofMeasure.Multiplier ' +
      ' FROM tblParts ' +
      //' LEFT JOIN tblunitsofMeasure  on tblunitsofMeasure.UnitId  = tblParts.UnitOfMeasureIDSales  ' +
      ' LEFT JOIN tbltaxcodes ON (tbltaxcodes.Name = TaxCode) AND (RegionID = %d)' +
      ' WHERE (PartName = "%s")', [AppEnv.RegionalOptions.ID, PartName]);
    qryParts.Open;
    Result := not qryParts.Eof;
    if not Result then begin
      AddResult(False, rssError, 0, PartName + ' not found in tblParts. Cannot convert this transaction.');
    end;
  end;

  function GetPartDetails2(const PartID: string): Boolean;
  begin
    if not Assigned(qryParts) then begin
      qryParts := TERPQuery.Create(nil);
      qryParts.Options.FlatBuffers := True;
      qryParts.Connection := GetSharedMyDacConnection;
    end;
    qryParts.SQL.Text := Format('SELECT IncomeAccnt, AssetAccnt, COGSAccnt, PARTSID, PARTNAME, ' +
      ' PartsDescription, PartType, tbltaxcodes.Name AS TaxCode, PRICE1, Rate ' + //, UnitOfMeasureSales, UnitOfMeasureIDSales, tblunitsofMeasure.Multiplier ' +
      ' FROM tblParts ' +
      //' LEFT JOIN tblunitsofMeasure  on tblunitsofMeasure.UnitId  = tblParts.UnitOfMeasureIDSales  ' +
      ' LEFT JOIN tbltaxcodes ON (tbltaxcodes.Name = TaxCode) AND (RegionID = %d)' +
      ' WHERE (PARTSID = %s)', [AppEnv.RegionalOptions.ID, PartID]);
    qryParts.Open;
    Result := not qryParts.Eof;
    if not Result then begin
      AddResult(False, rssError, 0, PartID + ' not found in tblParts. Cannot convert this transaction.');
    end;
  end;

  Procedure AddInvoiceLine;
  begin
    Invoice.Lines.New;
    Invoice.Lines.SaleId                 := Invoice.ID;
    Invoice.Lines.IncomeAccount          := qryParts.FieldByName('IncomeAccnt').AsString;
    Invoice.Lines.AssetAccount           := qryParts.FieldByName('AssetAccnt').AsString;
    Invoice.Lines.CogsAccount            := qryParts.FieldByName('COGSAccnt').AsString;
    Invoice.Lines.ProductType            := qryParts.FieldByName('PartType').AsString;
    Invoice.Lines.ProductID              := qryParts.FieldByName('PARTSID').asInteger;
    Invoice.Lines.ProductName            := qryParts.FieldByName('PartName').AsString;
    Invoice.Lines.ProductDescription     := qryParts.FieldByName('PartsDescription').AsString;
    Invoice.Lines.LineTaxCode            := qryParts.FieldByName('TaxCode').AsString;
    Invoice.Lines.LineTaxRate            := qryParts.FieldByName('Rate').AsFloat;
    Invoice.Lines.UnitOfMeasure          := AppEnv.DefaultClass.DefaultUOM;
    Invoice.Lines.UnitOfMeasureID        := GetUnitOfMeasureID(AppEnv.DefaultClass.DefaultUOM);
    Invoice.Lines.Invoiced               := True;
    Invoice.Lines.UOMMultiplier          := 1;

    if Invoice.Lines.UnitOfMeasure = '' then begin
      Invoice.Lines.UnitOfMeasure := 'Units';
      Invoice.Lines.UnitOfMeasureID := GetUnitOfMeasureID('Units', qryParts.FieldByName('PARTSID').AsInteger);
      Invoice.Lines.UOMMultiplier := 1;
    end;
  end;

  function InsertAppointmentLines: Boolean;
  var
    dPrice: double;
    list: TStringDynArray;
    k: Integer;
  begin
    {labour}
    if (AdjustedTotalHours <> 0) then begin
      if GetPartDetails(PART_LABOUR) then begin
        AddInvoiceLine;
        if not Service.IsFixedRate then begin
          Invoice.Lines.QtySold        := AdjustedTotalHours;
          Invoice.Lines.QtyShipped     := AdjustedTotalHours;
          Invoice.Lines.UOMQtySold     := AdjustedTotalHours;
          Invoice.Lines.UOMQtyShipped  := AdjustedTotalHours;
        end else begin
          Invoice.Lines.QtySold        := 1;
          Invoice.Lines.QtyShipped     := 1;
          Invoice.Lines.UOMQtySold     := 1;
          Invoice.Lines.UOMQtyShipped  := 1;
        end;
        dPrice := (TotalInc - CalloutValue);
        Invoice.Lines.OriginalLinePrice := GetAmountEx(dPrice, GetTaxRate(qryParts.FieldByName('TaxCode').AsString));
        Invoice.Lines.LinePrice := GetAmountEx(dPrice, GetTaxRate(qryParts.FieldByName('TaxCode').AsString));
        Invoice.Lines.LinePrice := Invoice.Lines.LinePrice / Invoice.Lines.QtyShipped;
        Invoice.Lines.LineCost := TotalCost / Invoice.Lines.QtyShipped;
        Invoice.Lines.LineCostInc := TotalCost / Invoice.Lines.QtyShipped;
        Invoice.Lines.ProductDescription := 'Service Provided :'+ ServiceDesc + ' by ' + TrainerName + ' @ ' + FloatToStr(Rate);
        if not Service.IsFixedRate then Invoice.Lines.ProductDescription := Invoice.Lines.ProductDescription +' per hr';
        Invoice.Lines.PostDb;
      end;
    end;

    {call out}
    if (CalloutValue <> 0) then
      if GetPartDetails('Call Out') then begin
        AddInvoiceLine;
        Invoice.Lines.QtySold        := 1;
        Invoice.Lines.QtyShipped     := 1;
        Invoice.Lines.UOMQtySold     := 1;
        Invoice.Lines.UOMQtyShipped  := 1;

        dPrice := CalloutValue;
        Invoice.Lines.OriginalLinePrice := GetAmountEx(dPrice, GetTaxRate(qryParts.FieldByName('TaxCode').AsString));
        Invoice.Lines.LinePrice := GetAmountEx(dPrice, GetTaxRate(qryParts.FieldByName('TaxCode').AsString));
        Invoice.Lines.LinePriceInc := dPrice;
        Invoice.Lines.ProductDescription := 'appointment #' +IntToStr(ID) + ' Call out';
        Invoice.Lines.PostDb;
      end;

    {free time for customer}
    if (AdjustedTotalHours <> dTotalHours) then
      if GetPartDetails(PART_LABOUR) then begin
        AddInvoiceLine;
        if not Service.IsFixedRate then begin
          Invoice.Lines.QtySold        := dTotalHours - AdjustedTotalHours;
          Invoice.Lines.QtyShipped     := dTotalHours - AdjustedTotalHours;
          Invoice.Lines.UOMQtySold     := dTotalHours - AdjustedTotalHours;
          Invoice.Lines.UOMQtyShipped  := dTotalHours - AdjustedTotalHours;
        end else begin
          Invoice.Lines.QtySold        := 1;
          Invoice.Lines.QtyShipped     := 1;
          Invoice.Lines.UOMQtySold     := 1;
          Invoice.Lines.UOMQtyShipped  := 1;
        end;

        dPrice := 0;
        Invoice.Lines.ProductDescription := qryParts.FieldByName('PartsDescription').AsString + '(Customer''s free hours)';
        Invoice.Lines.OriginalLinePrice := GetAmountEx(dPrice, GetTaxRate(qryParts.FieldByName('TaxCode').AsString));
        Invoice.Lines.LinePrice := GetAmountEx(dPrice, GetTaxRate(qryParts.FieldByName('TaxCode').AsString));

        Invoice.Lines.PostDb;
      end;

    {extra products}
    if (ExtraProducts <> '') then begin
      list := StringUtils.SplitString(ExtraProducts, ':');
      for k := Low(list) to High(list) do begin
        if GetPartDetails2(list[k]) then begin
          AddInvoiceLine;
          Invoice.Lines.QtySold        := 1;
          Invoice.Lines.QtyShipped     := 1;
          Invoice.Lines.UOMQtySold     := 1;
          Invoice.Lines.UOMQtyShipped  := 1;

          dPrice := 0;
          Invoice.Lines.ProductDescription := qryParts.FieldByName('PartsDescription').AsString + '(Extra product)';
          Invoice.Lines.OriginalLinePrice := GetAmountEx(dPrice, GetTaxRate(qryParts.FieldByName('TaxCode').AsString));
          Invoice.Lines.LinePrice := GetAmountEx(dPrice, GetTaxRate(qryParts.FieldByName('TaxCode').AsString));

          Invoice.Lines.PostDb;
        end;
      end;
    end;

    Result := True;
  end;

begin
  try
    if (Invoice = nil) then
    begin
      ResultStatus.Reset;
      Result := ValidateForInvoicing;
      if not Result then Exit;

      if Service.ClientID <> 0 then
        iClientID := Service.ClientID
      else begin
        iClientID := ClientID;
        if not Client.Customer then begin
          Client.Customer := True;
          Client.PostDb;
        end;
      end;

      Invoice := TInvoice.Create(Self);
      Invoice.Connection := Self.connection;
      Invoice.BusObjEvent := Self.BusObjEvent;
      Invoice.Load(0);
      Invoice.SilentMode:= Self.silentMode or not(Appenv.CompanyPrefs.CreditCheckInv); // if credit cheque is true should get the message
      Invoice.New;
      Invoice.GLAccountId      := AppEnv.CompanyPrefs.DefaultSalesAccount;
      Invoice.InvoiceToDesc    := GetShippingAddress(iClientID);
      Invoice.ShipToDesc       := GetPhysicalAddress(iClientID);
      Invoice.SaleDate         := Now;
      Invoice.SaleClassId      := ClassID;
      Invoice.ClientID         := iClientID;
      Invoice.CustomerName     := ClientName;
      Invoice.PostDb;
      Invoice.GlobalRef        := AppEnv.Branch.SiteCode + IntToStr(Invoice.ID);
      Invoice.OriginalDocNumber:= Invoice.GlobalRef;
      Invoice.Deleted          := False;
      Invoice.DocNumber        := IntToStr(Invoice.ID);
      Invoice.EmployeeId       := TrainerID;
      Invoice.AppointID        := ID;
    end;

    dTotalHours                := CommonLib.Round(Actual_TotalHours, RoundPlacesGeneral);
    if AppEnv.Companyprefs.MinimumChargeAppointmentTime <> 0 then
      if dTotalHours < AppEnv.Companyprefs.MinimumChargeAppointmentTime  then
        dTotalHours :=  AppEnv.Companyprefs.MinimumChargeAppointmentTime;
    AdjustOutstandingHours;

    qryParts := nil;
    if not InsertAppointmentLines then begin
      Result := False;
      Exit;
    end;
  except
    FreeAndNil(Invoice);
  end;

  Converted := True;
  Result := Save;
end;

function TAppointment.ConvertToInvoice(out NewInvoiceID: Integer): Boolean;
var
  Invoice: TInvoice;
begin
  Invoice := nil;
  try
    Result := ConvertToInvoice(Invoice);
    if Result then
    begin
      Result := Invoice.Save;
      if Result then
        NewInvoiceID := Invoice.ID;
    end;
  finally
    Invoice.Free;
  end;
end;

procedure TAppointment.RescheduleLinkedAppointments;
var
  LinkedAppts: TAppointment;
  ShiftByDays: Integer;
  lSelect: string;
  lDate: TDateTime;
  lTrainerID:Integer;
begin
  if not (UpdateLinkedAppointmentsonReschedule) then exit;
  LinkedAppts := TAppointment.Create(nil);
  try
    LinkedAppts.Connection := Self.Connection;
    ShiftByDays := Trunc(AppDate) - Trunc(fOldDate);

    lSelect := Format('(LinkAppointID = %d) AND (IsGroupParent = "F")', [Id]);
    if not IsGroupParent then
      lSelect := lSelect + Format(' AND (AppDate > "%s")', [FormatDateTime(MysqlDateFormat, AppDate)]);
    lSelect := lSelect + ' AND (Cancellation = "F") AND (Converted = "F") AND (Active = "T")';
    SQLOrder := 'AppDate';

    LinkedAppts.LoadSelect(lSelect);
    if LinkedAppts.EOF then
      Exit;
    while not LinkedAppts.EOF do begin
      if LinkedAppts.Reschedule(ShiftByDays, RescheduleActions) then
        LinkedAppts.Dataset.Next
      else
        LinkedAppts.Dataset.Delete;
    end;
    // Delete appointments that have been shifted to the same day
    // when done from the project managers roster, if moved for the same trainer and the same date
    LinkedAppts.Dataset.First;
    lDate := LinkedAppts.AppDate;
    lTrainerID:= LinkedAppts.TrainerID;
    LinkedAppts.Dataset.Next;
    while not LinkedAppts.EOF do begin
      if (lDate = LinkedAppts.AppDate) and (lTrainerID= LinkedAppts.TrainerID) then
        LinkedAppts.Delete
      else begin
        lDate := LinkedAppts.AppDate;
        lTrainerID:= LinkedAppts.TrainerID;
        LinkedAppts.Dataset.Next;
      end;
    end;
    LinkedAppts.Save;
  finally
    FreeandNil(LinkedAppts);
  end;
end;

function TAppointment.Reschedule(ShiftByDays: Integer; const aRescheduleActions: TRescheduleActions): Boolean;
var
  lDate: TDateTime;
begin
  Result := True;
  DoFieldChange := False;
  try
    lDate := IncDay(AppDate, ShiftByDays);
    case aRescheduleActions.GetAction(lDate) of
      raPost: begin end;
      raDrop: begin
        Result := False;
        Exit;
      end;
      raShiftBefore: Inc(ShiftByDays, -1);
      raShiftAfter: Inc(ShiftByDays);
    end;
    if ShiftByDays = 0 then
      Exit;
    Reschedulled := True;
    RescheduledFrom := AppDate;
    StartTime := IncDay(StartTime, ShiftByDays);
    EndTime := IncDay(EndTime, ShiftByDays);
    Start_time := FormatDateTime(MysqlTimeFormat12hr, StartTime);
    End_time := FormatDateTime(MysqlTimeFormat12hr, EndTime);
    AppDate := Trunc(StartTime);
    PostDB;
  finally
    DoFieldChange := True;
  end;
end;

function TAppointment.RescheduleWillOccurOnSave: Boolean;
begin
  Result := fRescheduled;
end;

function TAppointment.ValidateForInvoicing: Boolean;
begin
  Result := ValidateData;
  if not Result then Exit;
  CalcClientHoursLeft;
  CalcTotals;

  if not(Active) then begin
    AddResult(False, rssError, 0, 'This is a Deleted Appointemnt. It is not possible to convert this to Invocie.');
    Exit;
  end;


  if ServiceID = 0 then begin
    AddResult(False, rssError, 0, 'Please select the Service');
    Result := False;
    Exit;
  end;
  (*if (DateOf(Actual_StartTime) = 0) or (TimeOf(Actual_StartTime) = 0) then begin
    AddResult(False , rssError , 0,  'Actual Start Date/Time should not be blank');
    Result := False;
    Exit;
  end;
  if (DateOf(Actual_EndTime) = 0) or (TimeOf(Actual_EndTime) = 0) then begin
    AddResult(False , rssError , 0,  'Actual End Date/Time should not be blank');
    Result := False;
    Exit;
  end;*)
  if (DateOf(Actual_StartTime) = 0) or (TimeOf(Actual_StartTime) = 0) then
    if (DateOf(StartTime) = 0) (*or (TimeOf(StartTime) = 0)*) then begin
      AddResult(False , rssError , 0,  'Actual/Booking Start Date/Time should not be blank');
      Result := False;
      Exit;
    end;

  if (DateOf(EndTime) = 0) or (TimeOf(EndTime) = 0) then
    if (DateOf(EndTime) = 0) or (TimeOf(EndTime) = 0) then begin
      AddResult(False , rssError , 0,  'Actual/Booking End Date/Time should not be blank');
      Result := False;
      Exit;
    end;

  if(EndTime<>0) and (StartTime<>0) then
    if TimeOf(EndTime) < TimeOf(StartTime) then begin
      AddResult(False, rssError, 0, rsNoEndBeforeStart);
      Result := False;
      Exit;
    end;

  if(Actual_EndTime<>0) and (Actual_StartTime<>0) then
    if TimeOf(Actual_EndTime) < TimeOf(Actual_StartTime) then begin
      AddResult(False, rssError, 0, rsNoEndBeforeStart);
      Result := False;
      Exit;
    end;
end;


procedure TAppointment.MakeTimesheetEntry;
var
  lQuery: TDataSet;
begin
  if Actual_AppDate = 0 then Exit;

  lQuery := GetNewDataset('SELECT * FROM tbltimesheets WHERE Id = ' + IntToStr(TimeSheetID), True);
  try
    {insert a new timsheet record when creating an appointment with actual date and time information }
    if TimesheetID = 0 then begin
        lQuery.Insert;
        lQuery.FieldByName('Active').asString := 'T' ;
        lQuery.Post;
        TimesheetID := lQuery.FieldByname('ID').AsInteger;
        PostDb;
        lQuery.Close;
        EnsureMyQuery(lQuery);
        TERPQuery(lQuery).SQL.Text := 'SELECT * FROM tbltimesheets WHERE Id = ' + IntToStr(TimeSheetID);
        lQuery.Open;
    end ;
    {update with the latest time and rate infomation}
    lQuery.Edit;
    lQuery.FieldByname('TimesheetDate').AsDateTime := Actual_AppDate;
    lQuery.FieldByname('Hours').AsFloat := Actual_TotalHours;
    lQuery.FieldByname('Total').AsFloat := TotalInc;
    lQuery.FieldByname('EmployeeName').AsString := TrainerName;
    lQuery.FieldByname('EmployeeId').AsInteger := TrainerID;
    lQuery.FieldByname('Labourcost').AsFloat := TotalCost;
    lQuery.FieldByname('ServiceId').AsInteger := ServiceID;
    lQuery.FieldByname('ServiceName').AsString := Service.ServiceDesc;
    lQuery.FieldByname('ServiceDate').AsDatetime := Actual_AppDate;
    lQuery.FieldByname('ChargeRate').AsFloat := CalloutValue;
    lQuery.FieldByname('HourlyRate').AsFloat := Rate;
    lQuery.FieldByname('Qty').AsFloat := Actual_TotalHours;
    if Client.IsJob then begin
 //     lQuery.FieldByname('Job').AsString := Client.DisplayName;
      lQuery.FieldByname('JobId').AsInteger := ClientID;
    end;
    lQuery.Post;
  finally
    FreeandNil(lQuery);
  end;
end;
Function TAppointment.LocateActiveLog:Boolean;
begin
    AllLinesValid := false;
    AppointmentsTimeLog.Iteraterecords(LocateActiveLogCallback);
    result := AllLinesValid;
end;
Procedure TAppointment.LocateActiveLogCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is TAppointmentsTimeLog then begin
    if TAppointmentsTimeLog(Sender).EndDatetime =0 then begin
      AllLinesValid:= true;
      Abort := true;
      Exit;
    end;
  end;
end;

Function TAppointment.NewLog(aStartTime: TDateTime=0):Integer;
begin
  if aStarttime =0 then aStarttime := now;
  //if AppointmentsTimeLog.Locate('EndDateTime',0,[]) then
  if LocateActiveLog then
    AddResult(False, rssInfo, 0, 'The job is Already Started at ' + quotedstr(FormatDatetime(shortdateformat +' HH:NN AM/PM', AppointmentsTimeLog.StartDateTime))+'.  Please End that')
  else begin
    AppointmentsTimeLog.New;
    AppointmentsTimeLog.StartDateTime := aStarttime;
    AppointmentsTimeLog.PostDB;
    UserInputStartdate;
  end;
  result := AppointmentsTimeLog.ID;
end;
Procedure TAppointment.UserInputStartdate;
begin
  SendEvent(BusobjEvent_ToDo,BusObjEventVal_StartDateTime, AppointmentsTimeLog);
end;
Procedure TAppointment.UserInputEnddate;
begin
  SendEvent(BusobjEvent_ToDo,BusObjEventVal_EndDateTime, AppointmentsTimeLog);
end;
function TAppointment.EndLog(aEndTime: TDateTime=0): Integer;
begin
  REsult := 0;
  if aEndtime =0 then aEndtime := now;
  //if AppointmentsTimeLog.Locate('EndDateTime',0,[]) then begin
  if LocateActiveLog then begin
    result := AppointmentsTimeLog.ID;
    AppointmentsTimeLog.EndDateTime := aEndTime;
    AppointmentsTimeLog.PostDB;
    UserInputEnddate;
  end else begin
    AddResult(False, rssInfo, 0, 'Please Start the job')
  end;
end;

function TAppointment.DoAfterInsert(Sender: TDatasetBusobj): Boolean;
var
  lStr:String;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;

  CreationDate := Now;
  EnteredByEmployeeID := AppEnv.Employee.EmployeeID;
  TrainerID := AppEnv.Employee.EmployeeID;
  lStr := GetSimpleTypeDefaultStr(SimpleTypes_AppointmentStatusType);
  if lStr <> '' then
      Status := lStr
  else
      Status := 'N/A';
end;
Function TAppointment.DefaultAppointmentDuration:Integer;
begin
  result := Appenv.CompanyPrefs.AppointmentDuration;
  if result =0 then result := Appenv.CompanyPrefs.MinimumChargeAppointmentTime;
  if result < Appenv.CompanyPrefs.MinimumChargeAppointmentTime then result := Appenv.CompanyPrefs.MinimumChargeAppointmentTime;
end;
procedure TAppointment.ValidateStartTime(const ChangingTime: Boolean);
begin
  if DateOf(StartTime) <> DateOf(AppDate) then
    AppDate := DateOf(StartTime);
  if (DateOf(StartTime) > DateOf(EndTime)) and (EndTime <> 0) then begin
    EndTime := EndTime + Trunc(StartTime - fStartTime);
    if ChangingTime then
      End_time := FormatDateTime(MysqlTimeFormat12hr, EndTime);
  end;
  if ChangingTime or (Start_time <> '') then begin
    Start_time := FormatDateTime(MysqlTimeFormat12hr, StartTime);
    if (End_time <> '') and (TotalHours > 24.0) then begin
      Endtime := IncMinute(starttime , DefaultAppointmentDuration);
      End_time := FormatDateTime(MysqlTimeFormat12hr, EndTime);
    end;
    if (EndTime<>0) and (StartTime <>0) then
      if GUIMode and (End_time <> '') and (EndTime < StartTime) then
        AddResult(False, rssError, 0, rsNoEndBeforeStart);
  end;
  fStartTime := StartTime;
  CalcTotals;
end;

class function TAppointment._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','TrainerID','ID');
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','TrainerName','EmployeeName');
end;

procedure TAppointment.ValidateEndTime(const ChangingTime: Boolean);
begin
  if (EndTime<>0) and (StartTime<>0) then
    if DateOf(EndTime) < DateOf(StartTime) then begin
      AddResult(False, rssError, 0, rsNoEndBeforeStart);
    end;
  if ChangingTime or (End_time <> '') then begin
    End_time := FormatDateTime(MysqlTimeFormat12hr, EndTime);
    if (Start_time <> '') and (TotalHours > 24.0) then begin
      StartTime := IncDay(EndTime, -1);
      Start_time := FormatDateTime(MysqlTimeFormat12hr, StartTime);
      HandleDatechanges(Dataset.findfield('StartTime'));
    end;
    if (EndTime<>0) and (StartTime<>0) then
      if GUIMode and (Start_time <> '') and (EndTime < StartTime) then
        AddResult(False, rssError, 0, rsNoEndBeforeStart);
  end;
  CalcTotals;
end;

procedure TAppointment.ValidateActual_StartTime(const ChangingTime: Boolean);
begin
  if DateOf(Actual_StartTime) <> DateOf(Actual_AppDate) then
    Actual_AppDate := DateOf(Actual_StartTime);
  if (DateOf(Actual_StartTime) > DateOf(Actual_EndTime)) and (Actual_EndTime <> 0) then begin
    Actual_EndTime := Actual_EndTime + Trunc(Actual_StartTime - fActual_StartTime);
    if ChangingTime or (Actual_End_time <> '') then
      Actual_End_time := FormatDateTime(MysqlTimeFormat12hr, Actual_EndTime);
  end;
  if ChangingTime or (Actual_Start_time <> '') then begin
    Actual_Start_time := FormatDateTime(MysqlTimeFormat12hr, Actual_StartTime);
    if (Actual_End_time <> '') and (Actual_TotalHours > 24.0) then begin
      Actual_EndTime := IncDay(Actual_StartTime);
      Actual_End_time := FormatDateTime(MysqlTimeFormat12hr, Actual_EndTime);
    end;
    if(Actual_EndTime<>0) and ( Actual_StartTime<>0) then
      if GUIMode and (Actual_End_time <> '') and (Actual_EndTime < Actual_StartTime) then
        AddResult(False, rssError, 0, rsNoEndBeforeStart);
  end;
  fActual_StartTime := Actual_StartTime;
  CalcTotals;
end;

procedure TAppointment.ValidateActual_EndTime(const ChangingTime: Boolean);
begin
  if (Actual_EndTime<>0) and  (Actual_StartTime<>0) then
    if DateOf(Actual_EndTime) < DateOf(Actual_StartTime) then begin
      AddResult(False, rssError, 0, rsNoEndBeforeStart);
    end;
  if ChangingTime or (Actual_End_time <> '') then begin
    Actual_End_time := FormatDateTime(MysqlTimeFormat12hr, Actual_EndTime);
    if (Actual_Start_time <> '') and (Actual_TotalHours > 24.0) then begin
      Actual_StartTime := IncDay(Actual_EndTime, -1);
      Actual_Start_time := FormatDateTime(MysqlTimeFormat12hr, Actual_StartTime);
    end;
    if (Actual_EndTime<>0) and (Actual_StartTime<>0) then
      if GUIMode and (Actual_Start_time <> '') and (Actual_EndTime < Actual_StartTime) then
        AddResult(False, rssError, 0, rsNoEndBeforeStart);
  end;
  CalcTotals;
end;

procedure TAppointment.LineSaveCallbackProc(const Sender: TBusObj; var Abort: Boolean);
begin
  if Sender is TEquipmentxRef then
    if not TEquipmentxRef(Sender).Save then  begin
      AllLinesSavedOK := False;
      Abort := True;
    end;

  if sender is TAppointmentsTimeLog then
    if not TAppointmentsTimeLog(Sender).Save then  begin
      AllLinesSavedOK := False;
      Abort := True;
    end;
end;

procedure TAppointment.LineValidateCallbackProc(const Sender: TBusObj; var Abort: Boolean);
begin
//  if not TApptEquipment(Sender).ValidateData then {todo create new equipment bus obj (not multisite base)}
//  begin
//    AllLinesValid := False;
//    Abort := True;
//  end;
end;

function TAppointment.GetClientName: string;
begin
  result:= getStringfield('ClientName');
end;
function TAppointment.GetClientPrintName: string;
begin
  result:= getStringfield('ClientPrintName');
end;

procedure TAppointment.SetClientName(const Value: string);
begin
  SetStringField('ClientName' , Value);
end;
procedure TAppointment.SetClientPrintName(const Value: string);
begin
  SetStringField('ClientPrintName' , Value);
end;

function TAppointment.GetCUSTDATE1: TDateTime;
begin
  Result := GetDateTimeField('CUSTDATE1');
end;

function TAppointment.GetCUSTDATE2: TDateTime;
begin
  Result := GetDateTimeField('CUSTDATE2');
end;

function TAppointment.GetCUSTDATE3: TDateTime;
begin
  Result := GetDateTimeField('CUSTDATE3');
end;

function TAppointment.GetCUSTFLD1: string;
begin
  Result := GetStringField('CUSTFLD1');
end;

function TAppointment.GetCUSTFLD10: string;
begin
  Result := GetStringField('CUSTFLD10');
end;

function TAppointment.GetCUSTFLD11: string;
begin
  Result := GetStringField('CUSTFLD11');
end;

function TAppointment.GetCUSTFLD12: string;
begin
  Result := GetStringField('CUSTFLD12');
end;

function TAppointment.GetCUSTFLD13: string;
begin
  Result := GetStringField('CUSTFLD13');
end;

function TAppointment.GetCUSTFLD14: string;
begin
  Result := GetStringField('CUSTFLD4');
end;

function TAppointment.GetCUSTFLD15: string;
begin
  Result := GetStringField('CUSTFLD15');
end;

function TAppointment.GetCUSTFLD2: string;
begin
  Result := GetStringField('CUSTFLD2');
end;

function TAppointment.GetCUSTFLD3: string;
begin
  Result := GetStringField('CUSTFLD3');
end;

function TAppointment.GetCUSTFLD4: string;
begin
  Result := GetStringField('CUSTFLD4');
end;

function TAppointment.GetCUSTFLD5: string;
begin
  Result := GetStringField('CUSTFLD5');
end;

function TAppointment.GetCUSTFLD6: string;
begin
  Result := GetStringField('CUSTFLD6');
end;

function TAppointment.GetCUSTFLD7: string;
begin
  Result := GetStringField('CUSTFLD7');
end;

function TAppointment.GetCUSTFLD8: string;
begin
  Result := GetStringField('CUSTFLD8');
end;

function TAppointment.GetCUSTFLD9: string;
begin
  Result := GetStringField('CUSTFLD9');
end;

function TAppointment.GetCustomerID: Integer;
begin
  Result := GetIntegerField('CustomerID');
end;

function TAppointment.GetLeadID: Integer;
begin
  Result := GetIntegerField('LeadID');
end;

function TAppointment.GetSupplierID: Integer;
begin
  Result := GetIntegerField('SupplierID');
end;

function TAppointment.GetExtraProducts: String;
begin
  Result := GetStringField('ExtraProducts');
end;

procedure TAppointment.SetCUSTDATE1(const Value: TDateTime);
begin
  SetDateTimeField('CUSTDATE1', Value);
end;

procedure TAppointment.SetCUSTDATE2(const Value: TDateTime);
begin
  SetDateTimeField('CUSTDATE2', Value);
end;

procedure TAppointment.SetCUSTDATE3(const Value: TDateTime);
begin
  SetDateTimeField('CUSTDATE3', Value);
end;

procedure TAppointment.SetCUSTFLD1(const Value: string);
begin
  SetStringField('CUSTFLD1', Value);
end;

procedure TAppointment.SetCUSTFLD10(const Value: string);
begin
  SetStringField('CUSTFLD10', Value);
end;

procedure TAppointment.SetCUSTFLD11(const Value: string);
begin
  SetStringField('CUSTFLD11', Value);
end;

procedure TAppointment.SetCUSTFLD12(const Value: string);
begin
  SetStringField('CUSTFLD12', Value);
end;

procedure TAppointment.SetCUSTFLD13(const Value: string);
begin
  SetStringField('CUSTFLD13', Value);
end;

procedure TAppointment.SetCUSTFLD14(const Value: string);
begin
  SetStringField('CUSTFLD14', Value);
end;

procedure TAppointment.SetCUSTFLD15(const Value: string);
begin
  SetStringField('CUSTFLD15', Value);
end;

procedure TAppointment.SetCUSTFLD2(const Value: string);
begin
  SetStringField('CUSTFLD2', Value);
end;

procedure TAppointment.SetCUSTFLD3(const Value: string);
begin
  SetStringField('CUSTFLD3', Value);
end;

procedure TAppointment.SetCUSTFLD4(const Value: string);
begin
  SetStringField('CUSTFLD4', Value);
end;

procedure TAppointment.SetCUSTFLD5(const Value: string);
begin
  SetStringField('CUSTFLD5', Value);
end;

procedure TAppointment.SetCUSTFLD6(const Value: string);
begin
  SetStringField('CUSTFLD6', Value);
end;

procedure TAppointment.SetCUSTFLD7(const Value: string);
begin
  SetStringField('CUSTFLD7', Value);
end;

procedure TAppointment.SetCUSTFLD8(const Value: string);
begin
  SetStringField('CUSTFLD8', Value);
end;

procedure TAppointment.SetCUSTFLD9(const Value: string);
begin
  SetStringField('CUSTFLD9', Value);
end;

function TAppointment.getRepairID: Integer;
begin
  Result := getIntegerfield('RepairID');
end;

procedure TAppointment.setRepairID(const Value: Integer);
begin
  Setintegerfield('RepairID' , Value);
end;

procedure TAppointment.SetCustomerID(const Value: Integer);
begin
  SetIntegerField('CustomerID', Value);
end;

procedure TAppointment.SetLeadID(const Value: Integer);
begin
  SetIntegerField('LeadID', Value);
end;

procedure TAppointment.SetSupplierID(const Value: Integer);
begin
  SetIntegerField('SupplierID', Value);
end;

procedure TAppointment.SetExtraProducts(const Value: String);
begin
  SetStringField('ExtraProducts', Value);
end;

procedure TAppointment.CalcnValidatedates(const Sender: TField);
begin
  if Sysutils.SameText(Sender.Fieldname , 'AppDate') then begin {fromdate}
    if Endtime = 0 then begin
       endtime := IncMinute(starttime , DefaultAppointmentDuration);
       Start_time := formatDateTime(FormatSettings.ShortTimeFormat , Starttime);
       end_Time := formatDateTime(MysqlTimeFormat12hr , endTime);
    end;
  end else if Sysutils.SameText(Sender.Fieldname , 'ENDTIME') then begin{toDate}
    end_Time := formatDateTime(MysqlTimeFormat12hr , endTime);
  end else if Sysutils.SameText(Sender.Fieldname , 'Start_Time') then begin{fromtime}
    if (Endtime = 0) or (endtime<starttime) or (endtime <IncMinute(starttime , DefaultAppointmentDuration)) then begin
       endtime := IncMinute(starttime , DefaultAppointmentDuration);
       Start_time := formatDateTime(FormatSettings.ShortTimeFormat , Starttime);
       end_Time := formatDateTime(MysqlTimeFormat12hr , endTime);
    end;
  end;


  if (Sysutils.SameText(Sender.Fieldname , 'Actual_StartTime'))  or
      (Sysutils.SameText(Sender.Fieldname , 'Actual_AppDate')) then begin {fromdate}
    if (Actual_Endtime = 0) or (Actual_Endtime <= Actual_StartTime) then begin
       Actual_endtime := IncMinute(Actual_starttime , DefaultAppointmentDuration);
       Actual_Start_time := formatDateTime(FormatSettings.ShortTimeFormat , Actual_Starttime);
       Actual_end_Time := formatDateTime(FormatSettings.ShortTimeFormat , Actual_endTime);
    end;
  end else if SameText(Sender.Fieldname , 'Actual_ENDTIME') then begin{toDate}
    Actual_end_Time := formatDateTime(formatSettings.ShortTimeFormat , Actual_endTime);
  end else if Sysutils.SameText(Sender.Fieldname , 'Actual_ENDTIME') then begin{toDate}
  end else if SameText(Sender.Fieldname , 'Actual_ENDTIME') then begin{toDate}
    Actual_end_Time := formatDateTime(FormatSettings.ShortTimeFormat , Actual_endTime);
  end else if Sysutils.SameText(Sender.Fieldname , 'Actual_Start_Time') then begin{fromtime}
    if (Actual_Endtime = 0) or (Actual_endtime<Actual_starttime) or (Actual_endtime <IncMinute(Actual_starttime , DefaultAppointmentDuration)) then begin
       Actual_endtime := IncMinute(Actual_starttime , DefaultAppointmentDuration);
       Actual_Start_time := formatDateTime(FormatSettings.ShortTimeFormat , Actual_Starttime);
       Actual_end_Time := formatDateTime(FormatSettings.ShortTimeFormat , Actual_endTime);
    end;
  end;
  if not(Sysutils.SameText(copy(Sender.Fieldname +'      ' , 1, 6) , 'Actual')) then begin
    if (appenv.Companyprefs.AutoUpdateActual)  then begin
        actual_AppDAte := AppDAte;
        Actual_starttime:= StartTime;
        ACtual_Endtime := endtime;
        Actual_Start_time := start_time;
        Actual_End_Time := End_time;
        CalcnValidatedates(dataset.findfield('Actual_StartTime'));
    end else if appenv.CompanyPrefs.AutoLoadActualDatetimeFromscheduled  then begin
      if ((Actual_StartTime = 0) or (Actual_StartTime<starttime))  then begin
         Actual_StartTime := StartTime;
         Actual_AppDate := AppDate;
         Actual_endtime := endtime;
         Actual_Start_time :=Start_time;
         Actual_end_Time := End_time;
         CalcnValidatedates(dataset.findfield('Actual_StartTime'));
      end;
    end;
  end;
end;

procedure TAppointment.HandleDatechanges(const Sender: TField);

begin

  if Sysutils.SameText(Sender.fieldname ,'StartTime') then begin
    appDate := dateOf(starttime);
    start_Time := formatDateTime(FormatSettings.ShortTimeFormat , StartTime);
    HandleDatechanges(Dataset.findfield('appDate'));
  end else if Sysutils.SameText(Sender.fieldname ,'AppDate') then begin
    if Start_time = '' then begin
      start_Time := formatDateTime(FormatSettings.ShortTimeFormat , appenv.companyPrefs.StartOfDay);
    end;
    StartTime := DateOf(AppDate) + ValidStrToTime(start_Time);

    CalcnValidatedates(Sender);
    ValidateStartTime(False);
  end else if Sysutils.SameText(Sender.fieldname ,'Actual_AppDate') (*and (DateOf(Sender.AsDateTime) <> DateOf(Actual_StartTime))*) then begin
    if Actual_start_Time = '' then Actual_start_Time := Start_time;
    Actual_StartTime := DateOf(Actual_AppDate) + ValidStrToTime(Actual_start_Time);

    CalcnValidatedates(Sender);
    ValidateActual_StartTime(False);
  end else if Sysutils.SameText(Sender.fieldname ,'StartTime') then begin
    ValidateStartTime(False);
  end else if Sysutils.SameText(Sender.fieldname ,'EndTime') then begin

    CalcnValidatedates(Sender);ValidateEndTime(False);
  end else if Sysutils.SameText(Sender.fieldname ,'Actual_StartTime') then begin
    ValidateActual_StartTime(False);
  end else if Sysutils.SameText(Sender.fieldname ,'Actual_EndTime') then begin
    ValidateActual_EndTime(False);
  end else  begin
      try // Push changes to string fields through to TDateTime fields
        if Sysutils.SameText(Sender.fieldname ,'Start_time') then begin
          StartTime := DateOf(StartTime) + ValidStrToTime(Start_time);

          CalcnValidatedates(Sender);ValidateStartTime(True);
        end else if Sysutils.SameText(Sender.fieldname ,'End_time') then begin
          EndTime := DateOf(EndTime) + ValidStrToTime(End_time);

          CalcnValidatedates(Sender);ValidateEndTime(True);
        end else if Sysutils.SameText(Sender.fieldname ,'Actual_start_time') then begin
          Actual_StartTime := DateOf(Actual_StartTime) + ValidStrToTime(Actual_start_time);
          ValidateActual_StartTime(True);
        end else if Sysutils.SameText(Sender.fieldname ,'Actual_end_time') then begin
          Actual_EndTime := DateOf(Actual_EndTime) + ValidStrToTime(Actual_end_time);
          ValidateActual_EndTime(True);
        end;
      except
        on EAbort do begin end;
        on EConvertError do AddResult(False , rssError , 0, '"' + Sender.AsString + '" is not a valid time.');
      end;
  end;
  SendEvent(BusObjEvent_Change,BusObjEvent_DatetimeChanged, self);
end;
function TAppointment.getTrainer: TEmployee;
begin
  Result := TEmployee(getContainerComponent(TEmployee, 'EmployeeID = ' +IntToStr(trainerId) , true, False ));
end;

  {TAppointmentsTimeLog}

constructor TAppointmentsTimeLog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'appointmentstimelog';
  fSQL := 'SELECT * FROM tblappointmentstimelog';
end;


destructor TAppointmentsTimeLog.Destroy;
begin
  inherited;
end;


procedure TAppointmentsTimeLog.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'AppointID');
  SetPropertyFromNode(node,'Duration');
  SetBooleanPropertyFromNode(node,'IncludeForInvoice');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'Employeename');
  SetDateTimePropertyFromNode(node,'StartDatetime');
  SetDateTimePropertyFromNode(node,'EndDatetime');
  SetPropertyFromNode(node,'EnteredByEmployeeID');
  SetPropertyFromNode(node,'EmployeeID');
end;


procedure TAppointmentsTimeLog.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'AppointID' ,AppointID);
  AddXMLNode(node,'Duration' ,Duration);
  AddXMLNode(node,'IncludeForInvoice' ,IncludeForInvoice);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'Employeename' ,Employeename);
  AddXMLNode(node,'StartDatetime' ,StartDatetime);
  AddXMLNode(node,'EndDatetime' ,EndDatetime);
  AddXMLNode(node,'EnteredByEmployeeID' ,EnteredByEmployeeID);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
end;


function TAppointmentsTimeLog.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TAppointmentsTimeLog.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TAppointmentsTimeLog.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TAppointmentsTimeLog.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then Exit;
  inherited;

  if SameTExt(Sender.Fieldname, 'EmployeeID') then begin
    Employeename := TEmployee.IDToggle(EmployeeID);
  end else if SameTExt(Sender.Fieldname, 'EmployeeName') then begin
    EmployeeID := TEmployee.IDToggle(EmployeeName);
  end;
end;


function TAppointmentsTimeLog.GetIsList: Boolean;
begin
    Result := true;
end;

function TAppointmentsTimeLog.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TAppointmentsTimeLog.GetIDField: string;
begin
  Result := 'ID'
end;


class function TAppointmentsTimeLog.GetBusObjectTablename: string;
begin
  Result:= 'tblappointmentstimelog';
end;


function TAppointmentsTimeLog.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if owner is TAppointment then begin
      AppointId := TAppointment(Owner).ID;
      EmployeeID := TAppointment(Owner).TrainerID;
    end;
  StartdateTime:=0;
  enddateTime := 0;
  EnteredByEmployeeID := AppEnv.Employee.EmployeeID;

end;

function TAppointmentsTimeLog.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if owner is TAppointment then
      TAppointment(Owner).fbTimeLogchanged:= true;
end;


function TAppointmentsTimeLog.DoCalcFields(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoCalcFields(Sender);
  if not result then exit;
  if (StartDateTime<>0) and (EndDatetime<>0) then Duration := Round((EndDateTime - StartDateTime) * 24, 2)
end;

{Property Functions}
function  TAppointmentsTimeLog.GetAppointID          : Integer   ; begin Result := GetIntegerField('AppointID');end;
function  TAppointmentsTimeLog.GetDuration           : Double    ; begin Result := GetFloatField('Duration');end;
function  TAppointmentsTimeLog.GetIncludeForInvoice  : Boolean   ; begin Result := GetBooleanField('IncludeForInvoice');end;
function  TAppointmentsTimeLog.GetDescription        : String    ; begin Result := GetStringField('Description');end;
function  TAppointmentsTimeLog.GetEmployeename       : String    ; begin Result := GetStringField('Employeename');end;
function  TAppointmentsTimeLog.GetStartDatetime     : TDateTime ; begin Result := GetDateTimeField('StartDatetime');end;
function  TAppointmentsTimeLog.GetEndDatetime       : TDateTime ; begin Result := GetDateTimeField('EndDatetime');end;
function  TAppointmentsTimeLog.GetEnteredByEmployeeID: Integer   ; begin Result := GetIntegerField('EnteredByEmployeeID');end;
function  TAppointmentsTimeLog.GetEmployeeID         : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
procedure TAppointmentsTimeLog.SetAppointID          (const Value: Integer   ); begin SetIntegerField('AppointID'          , Value);end;
procedure TAppointmentsTimeLog.SetDuration           (const Value: Double    ); begin SetFloatField('Duration'             , Value);end;
procedure TAppointmentsTimeLog.SetIncludeForInvoice  (const Value: Boolean   ); begin SetBooleanField('IncludeForInvoice'  , Value);end;
procedure TAppointmentsTimeLog.SetDescription        (const Value: String    ); begin SetStringField('Description'         , Value);end;
procedure TAppointmentsTimeLog.SetEmployeename       (const Value: String    ); begin SetStringField('Employeename'        , Value);end;
procedure TAppointmentsTimeLog.SetStartDatetime     (const Value: TDateTime ); begin SetDateTimeField('StartDatetime'      , Value);end;
procedure TAppointmentsTimeLog.SetEndDatetime       (const Value: TDateTime ); begin SetDateTimeField('EndDatetime'        , Value);end;
procedure TAppointmentsTimeLog.SetEnteredByEmployeeID(const Value: Integer   ); begin SetIntegerField('EnteredByEmployeeID', Value);end;
procedure TAppointmentsTimeLog.SetEmployeeID        (const Value: Integer   ); begin SetIntegerField('EmployeeID'          , Value);end;
{ TAppointmentEx }

function TAppointmentEx.Getattachments: TAttachment;
begin
  Result := TAttachment(GetcontainerComponent(TAttachment,
    'Tablename = ' + Quotedstr(GetBusObjectTablename) + ' and TableID =' + IntToStr(ID)));

end;

initialization
  RegisterClass(TAppointmentsTimeLog);
  RegisterClassOnce(TAppointment);
  RegisterClassOnce(TAppointmentEx);
end.













