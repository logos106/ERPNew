unit companypreferencesdeleted;

interface

uses CompanyPrefObj , PayPreferencesObj , BusObjProcPrefs , EmployeeObj  , BusobjPersonalPreference , XMLIntf ,Graphics , BusobjcolumnHeadings;

type
TColumnHeadingsDeleted = class(TColumnHeadings)
  Private
    function GetComField1Name         : string    ;
    function GetComField2Name         : string    ;
    function GetComField3Name         : string    ;
    function GetComField4Name         : string    ;
    function GetCommAgg1              : String   ;
    function GetCommAgg2              : String   ;
    function GetCommAgg3              : String   ;
    function GetCommAgg4              : String   ;
    procedure SetComField1Name        (const Value: string    );
    procedure SetComField2Name        (const Value: string    );
    procedure SetComField3Name        (const Value: string    );
    procedure SetComField4Name        (const Value: string    );
    procedure SetCommAgg1             (const Value: String   );
    procedure SetCommAgg2             (const Value: String   );
    procedure SetCommAgg3             (const Value: String   );
    procedure SetCommAgg4             (const Value: String   );
  Protected
  Public
    property ComField1Name        :string     read GetComField1Name         write SetComField1Name   ;
    property ComField2Name        :string     read GetComField2Name         write SetComField2Name   ;
    property ComField3Name        :string     read GetComField3Name         write SetComField3Name   ;
    property ComField4Name        :string     read GetComField4Name         write SetComField4Name   ;
    property CommAgg1             :String     read GetCommAgg1              write SetCommAgg1        ;
    property CommAgg2             :String     read GetCommAgg2              write SetCommAgg2        ;
    property CommAgg3             :String     read GetCommAgg3              write SetCommAgg3        ;
    property CommAgg4             :String     read GetCommAgg4              write SetCommAgg4        ;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
end;
TPersonalPreferencesDeleted = class(TPersonalPreferences)
  Private
    function GetTips                                    : Boolean   ;
    procedure SetTips                                    (const Value: Boolean   );
    function GetMaxButton                               : Boolean   ;
    procedure SetMaxButton                               (const Value: Boolean   );
    function GetPOStandard                              : Boolean   ;
    procedure SetPOStandard                              (const Value: Boolean   );
    function GetPOColumn                                : Boolean   ;
    function GetPOColumnLandscape                       : Boolean   ;
    procedure SetPOColumn                                (const Value: Boolean   );
    procedure SetPOColumnLandscape                       (const Value: Boolean   );
    function GetPOInvoiceNoOFF                          : Boolean   ;
    procedure SetPOInvoiceNoOFF                          (const Value: Boolean   );
    function GetTurnSoundOff                            : Boolean   ;
    procedure SetTurnSoundOff                            (const Value: Boolean   );
    function GetRepairAppearDays                        : Integer   ;
    procedure SetRepairAppearDays                        (const Value: Integer   );
    function GetSortByColumn                            : Integer   ;
    procedure SetSortByColumn                            (const Value: Integer   );
    function GetShowProductsWithQty                     : Boolean   ;
    procedure SetShowProductsWithQty                     (const Value: Boolean   );
    function GetShowAllProducts                         : Boolean   ;
    procedure SetShowAllProducts                         (const Value: Boolean   );
    function GetShowReOrderLevel                        : Boolean   ;
    function GetShowReOrderPoint                        : Boolean   ;
    procedure SetShowReOrderLevel                        (const Value: Boolean   );
    procedure SetShowReOrderPoint                        (const Value: Boolean   );
    function GetShowCostEx                              : Boolean   ;
    function GetShowSellInc                             : Boolean   ;
    procedure SetShowCostEx                              (const Value: Boolean   );
    procedure SetShowSellInc                             (const Value: Boolean   );
    function GetDateNow                                 : Boolean   ;
    procedure SetDateNow                                 (const Value: Boolean   );
    function GetSOrderListIsLayBy                       : Boolean   ;
    procedure SetSOrderListIsLayBy                       (const Value: Boolean   );
    function GetAutoApplyCustPay                        : Boolean   ;
    procedure SetAutoApplyCustPay                        (const Value: Boolean   );
    function GetAutoApplySuppPay                        : Boolean   ;
    procedure SetAutoApplySuppPay                        (const Value: Boolean   );
    function GetSmallBtnColour                          : string    ;
    procedure SetSmallBtnColour                          (const Value: string    );
    function GetProgressPaymentsAppearDays              : Integer   ;
    procedure SetProgressPaymentsAppearDays              (const Value: Integer   );
    function GetProjectPurchasesAppearDays              : Integer   ;
    procedure SetProjectPurchasesAppearDays              (const Value: Integer   );
    function GetHireInvDueNotify                        : Boolean   ;
    procedure SetHireInvDueNotify                        (const Value: Boolean   );
    function GetBookingReminderInterval                 : Integer   ;
    procedure SetBookingReminderInterval                 (const Value: Integer   );
    function GetEmployeeReminderInterval                 : Integer   ;
    procedure SetEmployeeReminderInterval                 (const Value: Integer   );
    function GetLastRemindedDate                        : TDateTime ;
    procedure SetLastRemindedDate                        (const Value: TDateTime );
    function GetUseSnapshotProductsComboInv             : Boolean   ;
    procedure SetUseSnapshotProductsComboInv             (const Value: Boolean   );
    function GetUseSnapshotProductList             : Boolean   ;
    procedure SetUseSnapshotProductList             (const Value: Boolean   );
    function GetUseSearchLikeProductComboInv             : Boolean   ;
    procedure SetUseSearchLikeProductComboInv             (const Value: Boolean   );
    function GetCalendarReps                            : string    ;
    procedure SetCalendarReps                            (const Value: string    );
    function GetActiveGant                              : Integer   ;
    procedure SetActiveGant                              (const Value: Integer   );
    function GetGantShowAddress                         : Boolean   ;
    procedure SetGantShowAddress                         (const Value: Boolean   );
    function GetFuncBookingAppearDays                   : Integer   ;
    procedure SetFuncBookingAppearDays                   (const Value: Integer   );
    function GetHireContractEndAppearDays               : Integer   ;
    procedure SetHireContractEndAppearDays               (const Value: Integer   );
    function GetOverrideAutoRepairs                     : Boolean   ;
    procedure SetOverrideAutoRepairs                     (const Value: Boolean   );
    function GetShowCompanyAsDefaultOnRun               : Boolean   ;
    procedure SetShowCompanyAsDefaultOnRun               (const Value: Boolean   );
    function GetHintStartColor                          : string    ;
    procedure SetHintStartColor                          (const Value: string    );
    function GetHintEndColor                            : string    ;
    function GetHintFontName                            : string    ;
    function GetHintFontSize                            : Integer   ;
    function GetHintFontStyle                           : Integer   ;
    function GetHintFontColor                           : string    ;
    procedure SetHintEndColor                            (const Value: string    );
    procedure SetHintFontName                            (const Value: string    );
    procedure SetHintFontSize                            (const Value: Integer   );
    procedure SetHintFontStyle                           (const Value: Integer   );
    procedure SetHintFontColor                           (const Value: string    );
    function GetNextDeliveryRunAppearDays               : Integer   ;
    procedure SetNextDeliveryRunAppearDays               (const Value: Integer   );
    function Getshowhints                               : Boolean   ;
    procedure Setshowhints                               (const Value: Boolean   );
    function Getskinoption                              : string    ;
    function GetskinoptionMarble                        : Boolean   ;
    procedure Setskinoption                              (const Value: string    );
    procedure SetskinoptionMarble                        (const Value: Boolean   );
    function GetAppointmentServiceColumns               : Integer   ;
    procedure SetAppointmentServiceColumns               (const Value: Integer   );
    function GetRegInvoiceAppearDays                    : Integer   ;
    procedure SetRegInvoiceAppearDays                    (const Value: Integer   );
    function GetEmailPromptAttach                       : Boolean   ;
    procedure SetEmailPromptAttach                       (const Value: Boolean   );
    function GetResetToHrsTabPayEmployee                : Boolean   ;
    procedure SetResetToHrsTabPayEmployee                (const Value: Boolean   );
    function GetEquipmentServiceAppearDays              : Integer   ;
    procedure SetEquipmentServiceAppearDays              (const Value: Integer   );
    function GetERPLicenseRenewalAppearDays              : Integer   ;
    procedure SetERPLicenseRenewalAppearDays              (const Value: Integer   );
    function GetShowNewInstallDoc                       : Boolean   ;
    procedure SetShowNewInstallDoc                       (const Value: Boolean   );
    function GetShowMarketingContactInGlobalList        : Boolean   ;
    procedure SetShowMarketingContactInGlobalList        (const Value: Boolean   );
    (*function GetPAYGExpenseAccountID                    : integer   ;*)
    (*procedure SetPAYGExpenseAccountID                    (const Value: integer);*)

  Public
    property Tips                                       :Boolean     read GetTips                                     write SetTips                                ;
    property MaxButton                                  :Boolean     read GetMaxButton                                write SetMaxButton                           ;
    property POStandard                                 :Boolean     read GetPOStandard                               write SetPOStandard                          ;
    property POColumn                                   :Boolean     read GetPOColumn                                 write SetPOColumn                            ;
    property POColumnLandscape                          :Boolean     read GetPOColumnLandscape                        write SetPOColumnLandscape                   ;
    property POInvoiceNoOFF                             :Boolean     read GetPOInvoiceNoOFF                           write SetPOInvoiceNoOFF                      ;
    property TurnSoundOff                               :Boolean     read GetTurnSoundOff                             write SetTurnSoundOff                        ;
    property RepairAppearDays                           :Integer     read GetRepairAppearDays                         write SetRepairAppearDays                    ;
    property SortByColumn                               :Integer     read GetSortByColumn                             write SetSortByColumn                        ;
    property ShowProductsWithQty                        :Boolean     read GetShowProductsWithQty                      write SetShowProductsWithQty                 ;
    property ShowAllProducts                            :Boolean     read GetShowAllProducts                          write SetShowAllProducts                     ;
    property ShowReOrderLevel                           :Boolean     read GetShowReOrderLevel                         write SetShowReOrderLevel                    ;
    property ShowReOrderPoint                           :Boolean     read GetShowReOrderPoint                         write SetShowReOrderPoint                    ;
    property ShowCostEx                                 :Boolean     read GetShowCostEx                               write SetShowCostEx                          ;
    property ShowSellInc                                :Boolean     read GetShowSellInc                              write SetShowSellInc                         ;
    property DateNow                                    :Boolean     read GetDateNow                                  write SetDateNow                             ;
    property SOrderListIsLayBy                          :Boolean     read GetSOrderListIsLayBy                        write SetSOrderListIsLayBy                   ;
    property AutoApplyCustPay                           :Boolean     read GetAutoApplyCustPay                         write SetAutoApplyCustPay                    ;
    property AutoApplySuppPay                           :Boolean     read GetAutoApplySuppPay                         write SetAutoApplySuppPay                    ;
    property SmallBtnColour                             :string      read GetSmallBtnColour                           write SetSmallBtnColour                      ;
    property ProgressPaymentsAppearDays                 :Integer     read GetProgressPaymentsAppearDays               write SetProgressPaymentsAppearDays          ;
    property ProjectPurchasesAppearDays                 :Integer     read GetProjectPurchasesAppearDays               write SetProjectPurchasesAppearDays          ;
    property HireInvDueNotify                           :Boolean     read GetHireInvDueNotify                         write SetHireInvDueNotify                    ;
    property BookingReminderInterval                    :Integer     read GetBookingReminderInterval                  write SetBookingReminderInterval             ;
    property EmployeeReminderInterval                    :Integer     read GetEmployeeReminderInterval                  write SetEmployeeReminderInterval             ;
    property LastRemindedDate                           :TDateTime   read GetLastRemindedDate                         write SetLastRemindedDate                    ;
    property UseSnapshotProductsComboInv                :Boolean     read GetUseSnapshotProductsComboInv              write SetUseSnapshotProductsComboInv         ;
    property UseSnapshotProductList                     :Boolean     read GetUseSnapshotProductList              write SetUseSnapshotProductList         ;
    property UseSearchLikeProductComboInv                     :Boolean     read GetUseSearchLikeProductComboInv              write SetUseSearchLikeProductComboInv         ;
    property CalendarReps                               :string      read GetCalendarReps                             write SetCalendarReps                        ;
    property ActiveGant                                 :Integer     read GetActiveGant                               write SetActiveGant                          ;
    property GantShowAddress                            :Boolean     read GetGantShowAddress                          write SetGantShowAddress                     ;
    property FuncBookingAppearDays                      :Integer     read GetFuncBookingAppearDays                    write SetFuncBookingAppearDays               ;
    property HireContractEndAppearDays                  :Integer     read GetHireContractEndAppearDays                write SetHireContractEndAppearDays           ;
    property OverrideAutoRepairs                        :Boolean     read GetOverrideAutoRepairs                      write SetOverrideAutoRepairs                 ;
    property ShowCompanyAsDefaultOnRun                  :Boolean     read GetShowCompanyAsDefaultOnRun                write SetShowCompanyAsDefaultOnRun           ;
    property HintStartColor                             :string      read GetHintStartColor                           write SetHintStartColor                      ;
    property HintEndColor                               :string      read GetHintEndColor                             write SetHintEndColor                        ;
    property HintFontName                               :string      read GetHintFontName                             write SetHintFontName                        ;
    property HintFontSize                               :Integer     read GetHintFontSize                             write SetHintFontSize                        ;
    property HintFontStyle                              :Integer     read GetHintFontStyle                            write SetHintFontStyle                       ;
    property HintFontColor                              :string      read GetHintFontColor                            write SetHintFontColor                       ;
    property NextDeliveryRunAppearDays                  :Integer     read GetNextDeliveryRunAppearDays                write SetNextDeliveryRunAppearDays           ;
    property showhints                                  :Boolean     read Getshowhints                                write Setshowhints                           ;
    property skinoption                                 :string      read Getskinoption                               write Setskinoption                          ;
    property skinoptionMarble                           :Boolean     read GetskinoptionMarble                         write SetskinoptionMarble                    ;
    property AppointmentServiceColumns                  :Integer     read GetAppointmentServiceColumns                write SetAppointmentServiceColumns           ;
    property RegInvoiceAppearDays                       :Integer     read GetRegInvoiceAppearDays                     write SetRegInvoiceAppearDays                ;
    property EmailPromptAttach                          :Boolean     read GetEmailPromptAttach                        write SetEmailPromptAttach                   ;
    property ResetToHrsTabPayEmployee                   :Boolean     read GetResetToHrsTabPayEmployee                 write SetResetToHrsTabPayEmployee            ;
    property EquipmentServiceAppearDays                 :Integer     read GetEquipmentServiceAppearDays               write SetEquipmentServiceAppearDays          ;
    property ERPLicenseRenewalAppearDays                :Integer     read GetERPLicenseRenewalAppearDays              write SetERPLicenseRenewalAppearDays         ;
    property ShowNewInstallDoc                          :Boolean     read GetShowNewInstallDoc                        write SetShowNewInstallDoc                   ;
    property ShowMarketingContactInGlobalList           :Boolean     read GetShowMarketingContactInGlobalList         write SetShowMarketingContactInGlobalList    ;
    (*property PAYGExpenseAccountID                       :integer     read GetPAYGExpenseAccountID                     write SetPAYGExpenseAccountID;*)






  protected
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;

end;
TEmployeeDeleted = Class(TEmployeeObj)
  Private
    fbTips: boolean;
    fbMaxButton: boolean;
    fbPOStandard: boolean;
    fbPOColumn: boolean;
    fbPOColumnLandscape: boolean;
    fbPOInvoiceNoOFF: boolean;
    fbTurnSoundOff: boolean;
    fiRepairAppearDays: integer;
    fiSortByColumn: integer;
    fbShowProductsWithQty: boolean;
    fbShowAllProducts: boolean;
    fbShowReorderLevel: boolean;
    fbShowReorderPoint: boolean;
    fbShowCostEx: boolean;
    fbShowSellInc: boolean;
    fbDateNow: boolean;
    fbSOrderListIsLayBy: boolean;
    fsSmallBtnColour: TColor;
    fsHireInvDueNotify: string;
    fbBookingReminderInterval: integer;
    fbEmployeeReminderInterval: integer;
    fiActiveGant: integer;
    fbGantShowAddress: boolean;
    fiFuncBookingAppearDays: integer;
    fiHireContractEndingAppearDays: integer;
    fbOverrideAutoRepairs: boolean;
    fbShowCompanyAsDefaultOnRun: boolean;
    fiNextDeliveryRunAppearDays: integer;
    fbShowHint : boolean;
    fiRegInvoiceAppearDays:integer;
    fbEmailPromptAttach: boolean;
    fbResetToHrsTabPayEmployee: boolean;
    fbShowNewInstallDoc:boolean;



    procedure SetActiveGant(Value: integer);
    procedure SetGantShowAddress(Value: boolean);
    procedure SetShowNewInstallDoc(Value: boolean);

  Protected
  public

    property Tips: boolean read fbTips;
    property MaxButton: boolean read fbMaxButton;
    property POStandard: boolean read fbPOStandard;
    property POColumn: boolean read fbPOColumn;
    property POColumnLandscape: boolean read fbPOColumnLandscape;
    property POInvoiceNoOFF: boolean read fbPOInvoiceNoOFF;
    property TurnSoundOff: boolean read fbTurnSoundOff;
    property RepairAppearDays: integer read fiRepairAppearDays;
    property SortByColumn: integer read fiSortByColumn;
    property ShowProductsWithQty: boolean read fbShowProductsWithQty;
    property ShowAllProducts: boolean read fbShowAllProducts;
    property ShowReorderLevel: boolean read fbShowReorderLevel;
    property ShowReorderPoint: boolean read fbShowReorderPoint;
    property ShowCostEx: boolean read fbShowCostEx;
    property ShowSellInc: boolean read fbShowSellInc;
    property DateNow: boolean read fbDateNow;
    property SOrderListIsLayBy: boolean read fbSOrderListIsLayBy;
    property SmallBtnColour: TColor read fsSmallBtnColour;
    property HireInvDueNotify: string read fsHireInvDueNotify;
    property BookingReminderInterval: integer read fbBookingReminderInterval;
    property EmployeeReminderInterval: integer read fbEmployeeReminderInterval;
    property ActiveGant: integer read fiActiveGant write SetActiveGant;
    property GantShowAddress: boolean read fbGantShowAddress write SetGantShowAddress;
    property FuncBookingAppearDays: integer read fiFuncBookingAppearDays;
    property HireContractEndingAppearDays: integer read fiHireContractEndingAppearDays;
    property OverrideAutoRepairs: boolean read fbOverrideAutoRepairs write fbOverrideAutoRepairs;
    property ShowCompanyAsDefaultOnRun: boolean read fbShowCompanyAsDefaultOnRun write fbShowCompanyAsDefaultOnRun;
    property NextDeliveryRunAppearDays: integer read fiNextDeliveryRunAppearDays;
    property ShowHint: Boolean read fbShowHint ;
    property RegInvoiceAppearDays : integer read fiRegInvoiceAppearDays ;
    property EmailPromptAttach: boolean read fbEmailPromptAttach ;
    property ShowNewInstallDoc :Boolean read fbShowNewInstallDoc Write SetShowNewInstallDoc;


    procedure PopulateMe(const iEmployeeID: integer; const UserOnly: boolean = true);Override;

End;
TBusObjProcPrefsDeleted = class(TBusObjProcPrefs)
  Private
    fbUpdateFormulawhenManufacturingUpdateBatch: boolean;
    fbUpdateLinenowhenManufacturingUpdateBatch: boolean;

    procedure SetUpdateFormulawhenManufacturingUpdateBatch(const Value: boolean);
    procedure SetUpdateLinenowhenManufacturingUpdateBatch(const Value: boolean);

  Protected
  Public
    property UpdateFormulawhenManufacturingUpdateBatch : boolean read fbUpdateFormulawhenManufacturingUpdateBatch write SetUpdateFormulawhenManufacturingUpdateBatch;
    property UpdateLinenowhenManufacturingUpdateBatch : boolean read fbUpdateLinenowhenManufacturingUpdateBatch write SetUpdateLinenowhenManufacturingUpdateBatch;
end;
TPayPreferencesDEleted = class(TPayPreferencesObj)
  Private
    fiARAccountID: integer;
    fiDefaultPaperID: integer;
    fbEFTIncBalance: boolean;
    fbEFTIncNet: boolean;
    fbEFTIncCredit: boolean;
    fbEFTIncDebit: boolean;
    fiExpensesAccountID: integer;
    fdGSTTaxRateWC: double;
    fiLabourIncomeAccountID: integer;
    fiNICsEmployeePaidAccountID: integer;
    fiNICsEmployeePayableAccountID: integer;
    fiNICsEmployerPaidAccountID: integer;
    fiNICsEmployerPayableAccountID: integer;
    fiNoABNAccountID: integer;
    fiNoABNExpenseAccountID: integer;
    fiPAYGTaxPaidAccountID: integer;
    fiPayrollTaxPaidAccountID: integer;
    fiPayrollTaxPayableAccountID: integer;
    fiPayslipType: integer;
    fsPaySummaryType: string;
    fbTaxOnSuperWC: boolean;
    fsTaxPaidIn: string;
    fUKNICClass3Rate:double;
    fdUKTaxBasicAllowance: double;
    fdUKTaxStartRateUpperThreshold:double;
    fdUKTaxBasicRateUpperThreshold:double;
    fdUKTaxStartingRateDividend:double;
    fdUKTaxStartingRateSavings:double;
    fdUKTaxStartingRateOther:double;
    fdUKTaxBasicRateDividend:double;
    fdUKTaxBasicRateSavings:double;
    fdUKTaxBasicRateOther:double;
    fdUKTaxHigherRateDividend:double;
    fdUKTaxHigherRateSavings:double;
    fdUKTaxHigherRateOther:double;
    fdUKTaxMaxRate:double;
    fdUKTaxEmergencyCode:String;
    fdUKTaxAllowance6574:double;
    fdUKTaxAllowance75:double;
    fdUKTaxBasicAllowanceLimit:double;
    fdUKTaxAllowance6574Limit:double;
    fdUKTaxAllowance75Limit:double;
    fUKNICEarningsThreshold1:double;
    fUKNICEarningsThreshold2:double;
    fUKNICEmployeeClass1Rate2:double;
    fUKNICEmployeesClass1Rate1:double;
    fUKNICEmployeesContractedOutRebate:double;
    fUKNICEmployersClass1Rate1:double;
    fUKNICEmployersClass1Rate2:double;
    fUKNICEmployersContractedOutRebateM:double;
    fUKNICEmployersContractedOutRebateS:double;
    fUKNICLowerEarningsLimit:double;
    fUKNICUpperEarningsLimit:double;
    fUKNICMarriedWomanClass1Rate1:double;
    fUKNICMarriedWomanClass1Rate2:double;


    fUKNICLowerEarningsLimitWK:double;
    fUKNICLowerEarningsLimitMTH:double;
    fUKNICEarningsThreshold1WK:double;
    fUKNICEarningsThreshold1MTH:double;
    fUKNICEarningsThreshold2WK:double;
    fUKNICEarningsThreshold2MTH:double;
    fUKNICUpperEarningsLimitWK:double;
    fUKNICUpperEarningsLimitMTH:double;
    fUKStartFiscalYear:TDateTime;
    fiWagesPayableAccountID: integer;
    fiWorkCoverPaidAccountID: integer;
    fiWorkersCompPaidAccountID: integer;
    fiWorkCoverPayableAccountID: integer;
    fiWorkersCompPayableAccountID: integer;
    //fiPAYGExpenseAccountID:integer;

  Protected
  Public
    property ARAccountID: integer read fiARAccountID;
    function PopulateMe: boolean;
    property DefaultPaperID: integer read fiDefaultPaperID;
    property EFTIncBalance: boolean read fbEFTIncBalance;
    property EFTIncNet: boolean read fbEFTIncNet;
    property EFTIncCredit: boolean read fbEFTIncCredit;
    property EFTIncDebit: boolean read fbEFTIncDebit;
    property ExpensesAccountID: integer read fiExpensesAccountID;
    property GSTTaxRateWC: double read fdGSTTaxRateWC;
    property LabourIncomeAccountID: integer read fiLabourIncomeAccountID;
    property NICsEmployeePaidAccountID: integer read fiNICsEmployeePaidAccountID;
    property NICsEmployeePayableAccountID: integer read fiNICsEmployeePayableAccountID;
    property NICsEmployerPaidAccountID: integer read fiNICsEmployerPaidAccountID;
    property NICsEmployerPayableAccountID: integer read fiNICsEmployerPayableAccountID;
    property NoABNAccountID: integer read fiNoABNAccountID;
    property NoABNExpenseAccountID: integer read fiNoABNExpenseAccountID;
    property PAYGTaxPaidAccountID: integer read fiPAYGTaxPaidAccountID;
    property PayrollTaxPaidAccountID: integer read fiPayrollTaxPaidAccountID;
    property PayrollTaxPayableAccountID: integer read fiPayrollTaxPayableAccountID;
    property PayslipType: integer read fiPayslipType;
    property PaySummaryType: string read fsPaySummaryType;
    property TaxOnSuperWC: boolean read fbTaxOnSuperWC;
    property TaxPaidIn: string read fsTaxPaidIn;
    property UKNICClass3Rate:double read fUKNICClass3Rate;
    property UKTaxBasicAllowance: double read fdUKTaxBasicAllowance;
    property UKTaxAllowance6574:double read fdUKTaxAllowance6574;
    property UKTaxAllowance75:double read fdUKTaxAllowance75;
    property UKTaxBasicAllowanceLimit:double read fdUKTaxBasicAllowanceLimit;
    property UKTaxAllowance6574Limit:double read fdUKTaxAllowance6574Limit;
    property UKTaxAllowance75Limit:double read fdUKTaxAllowance75Limit;

    property UKTaxStartRateUpperThreshold:double read fdUKTaxStartRateUpperThreshold;
    property UKTaxBasicRateUpperThreshold:double read fdUKTaxBasicRateUpperThreshold;
    property UKTaxStartingRateDividend:double read fdUKTaxStartingRateDividend;
    property UKTaxStartingRateSavings:double read fdUKTaxStartingRateSavings;
    property UKTaxStartingRateOther:double read fdUKTaxStartingRateOther;
    property UKTaxBasicRateDividend:double read fdUKTaxBasicRateDividend;
    property UKTaxBasicRateSavings:double read fdUKTaxBasicRateSavings;
    property UKTaxBasicRateOther:double read fdUKTaxBasicRateOther;
    property UKTaxHigherRateDividend:double read fdUKTaxHigherRateDividend;
    property UKTaxHigherRateSavings:double read fdUKTaxHigherRateSavings;
    property UKTaxHigherRateOther:double read fdUKTaxHigherRateOther;
    property UKTaxMaxRate:double read fdUKTaxMaxRate;
    property UKTaxEmergencyCode:String read fdUKTaxEmergencyCode;

    property UKNICEarningsThreshold1:double read fUKNICEarningsThreshold1;
    property UKNICEarningsThreshold2:double read fUKNICEarningsThreshold2;
    property UKNICEmployeeClass1Rate2:double read fUKNICEmployeeClass1Rate2;
    property UKNICEmployeesClass1Rate1:double read fUKNICEmployeesClass1Rate1;
    property UKNICEmployeesContractedOutRebate:double read fUKNICEmployeesContractedOutRebate;
    property UKNICEmployersClass1Rate1:double read fUKNICEmployersClass1Rate1;
    property UKNICEmployersClass1Rate2:double read fUKNICEmployersClass1Rate2;
    property UKNICEmployersContractedOutRebateM:double read fUKNICEmployersContractedOutRebateM;
    property UKNICEmployersContractedOutRebateS:double read fUKNICEmployersContractedOutRebateS;
    property UKNICLowerEarningsLimit:double read fUKNICLowerEarningsLimit;
    property UKNICUpperEarningsLimit:double read fUKNICUpperEarningsLimit;
    property UKNICMarriedWomanClass1Rate1:double read fUKNICMarriedWomanClass1Rate1;
    property UKNICMarriedWomanClass1Rate2:double read fUKNICMarriedWomanClass1Rate2;


    property UKNICLowerEarningsLimitWK:double read fUKNICLowerEarningsLimitWK;
    property UKNICLowerEarningsLimitMTH:double read fUKNICLowerEarningsLimitMTH;
    property UKNICEarningsThreshold1WK:double read fUKNICEarningsThreshold1WK;
    property UKNICEarningsThreshold1MTH:double read fUKNICEarningsThreshold1MTH;
    property UKNICEarningsThreshold2WK:double read fUKNICEarningsThreshold2WK;
    property UKNICEarningsThreshold2MTH:double read fUKNICEarningsThreshold2MTH;
    property UKNICUpperEarningsLimitWK:double read fUKNICUpperEarningsLimitWK;
    property UKNICUpperEarningsLimitMTH:double read fUKNICUpperEarningsLimitMTH;
    property UKStartFiscalYear:TDateTime read fUKStartFiscalYear;
    property WorkCoverPaidAccountID: integer read fiWorkCoverPaidAccountID;
    property WorkersCompPaidAccountID: integer read fiWorkersCompPaidAccountID;
    property WorkCoverPayableAccountID: integer read fiWorkCoverPayableAccountID;
    property WorkersCompPayableAccountID: integer read fiWorkersCompPayableAccountID;
    //property PAYGExpenseAccountID:integer read fiPAYGExpenseAccountID;

end;
TCompanyPrefdeleted = Class(TCompanyPrefObj)
  Private
    FiARTerms3                         : Integer;
    FiARTerms5                         : Integer;
    FiARTerms2                         : Integer;
    FiARTerms1                         : Integer;
    FiAPTerms2                         : Integer;
    FiAPTerms4                         : Integer;
    FiAPTerms5                         : Integer;
    FiARTerms4                         : Integer;
    FiAPTerms3: Integer;
    FiAPTerms1: Integer;
    FbAskForInvoiceNumberOnRefund              : Boolean;
    FbAutoOrder                        : Boolean;
    FbAutoPeriodChange                         : Boolean;
    fbAutoReceiveonPortionControl: boolean;
    fbAutoShiponPortionControl: boolean;
    FbCalcUsingDepot                   : Boolean;
    FbUseCallMonitor                         : Boolean;
    FiCallMonitorHideTime                      : Integer;
    FsRecordingDirectory                     : String;
    FbClassCompany              : Boolean;
    FbClassRequired              : Boolean;
    FbClassVisible              : Boolean;
    FiDepositsAccountID                        : Integer;
    FbDupPartsOK                : Boolean;
    FdEmailMaxSize                             : Double;
    FbEnableCogsAdjustmentPosting            : Boolean;
    FbHideLetterHeadsCashSale: Boolean;
    FbHideLetterHeadsCustPayment: Boolean;
    FbHideLetterHeadsQ          : Boolean;
    FbHideLetterHeadsPO       : Boolean;
    FbHideLetterHeadsINV               : Boolean;
    FiInventoryDecimal                 : Integer;
    FsInvoiceLayout                    : String;
    FbJobsRequired              : Boolean;
    FbJobsVisible               : Boolean;
    FsKeyboardType                     : String;
    FsMatrixSortPriority                       : String;
    fOpenLogwhenupdated: boolean;
    FsPOLayout                         : String;
    FbPriceUpdateOnCostDec                   : Boolean;
    FbPriceUpdateOnCostInc                   : Boolean;
    FsPrimaryFax                             : String;
    FbPrintEquipment          : Boolean;
    FbPrjStatusColours             : Boolean;
    FbRemittance              : Boolean;
    FsScannerType                      : String;
    FbRemoteSite                                : Boolean;
    FbShowDepositsInGL                         : Boolean;
    FbShowGroupLines          : Boolean;
    FbShowGroupLinesOnQuote            : Boolean;
    FbShowOnlyQualifiedCrew                  : Boolean;
    FbShowPOValues              : Boolean;
    FbShowPaymentAmountsAgainstInvoice       : Boolean;
    FsSmartOrderPrintDevice                    : String;
    FsSmartOrderPrintDriver                    : String;
    FsSmartOrderPrintPort                      : String;
    FsSpaceRentPartName                        : String;
    FbTOSLaybys                              : Boolean; // Report laybys at Time Of Sale
    FbTransferMode1           : Boolean;
    FsUnitBookingServiceEndHeader              : String;
    FsUnitBookingServiceStartHeader            : String;
    FsUnitBookingUnitStartHeader               : String;
    FsUnitBookingUnitEndHeader                 : String;
    FbUseForeignCurrencyonCustPay            : Boolean;
    FbUseForeignCurrencyonSuppPay            : Boolean;
    FbUseHospitality               : Boolean;
    FbUsePersonalPreference     : Boolean;
    FbUsePoolCare                              : Boolean;
    FbUseRadioFreqTracking                     : Boolean;
    FbUseRaptor                   : Boolean;
    FbUseRollaBlinds                           : Boolean;
    FbUseRunAndSequenceOnSO                    : Boolean;
    FbUseScoping                               : Boolean;
    FdVerifyLockdownDate                       : TDateTime;
    FbUpdateFormulawhenManufacturingUpdateBatch : Boolean;
        //FbEnforceSerialTracking            : Boolean;



    Function GetSpaceRentPartName: String;
  Protected
  Public
    Property APTerms1: Integer Read FiAPTerms1;
    Property APTerms2: Integer Read FiAPTerms2;
    Property APTerms3: Integer Read FiAPTerms3;
    Property APTerms4: Integer Read FiAPTerms4;
    Property APTerms5: Integer Read FiAPTerms5;
    Property ARTerms1: Integer Read FiARTerms1;
    Property ARTerms2: Integer Read FiARTerms2;
    Property ARTerms3: Integer Read FiARTerms3;
    Property ARTerms4: Integer Read FiARTerms4;
    Property ARTerms5: Integer Read FiARTerms5;
    Property AskForInvoiceNumberOnRefund: Boolean Read FbAskForInvoiceNumberOnRefund;
    Property AutoOrder: Boolean Read FbAutoOrder;
    Property AutoPeriodChange: Boolean Read FbAutoPeriodChange;
    property AutoReceiveonPortionControl: boolean read fbAutoReceiveonPortionControl;
    property AutoShiponPortionControl: boolean read fbAutoShiponPortionControl;
    Property CalcUsingDepot: Boolean Read FbCalcUsingDepot;
    Property UseCallMonitor: Boolean Read FbUseCallMonitor;
    Property CallMonitorHideTime: Integer Read FiCallMonitorHideTime;
    Property RecordingDirectory: String Read FsRecordingDirectory;
    Property ClassCompany: Boolean Read FbClassCompany;
    Property ClassRequired: Boolean Read FbClassRequired;
    Property ClassVisible: Boolean Read FbClassVisible;
    Property DepositsAccountID: Integer Read FiDepositsAccountID;
    Property DupPartsOK: Boolean Read FbDupPartsOK;
    Property EmailMaxSize: Double Read FdEmailMaxSize;
    Property EnableCogsAdjustmentPosting: Boolean Read FbEnableCogsAdjustmentPosting;
    Property HideLetterHeadsCashSale: Boolean Read FbHideLetterHeadsCashSale;
    Property HideLetterHeadsCustPayment: Boolean Read FbHideLetterHeadsCustPayment;
    Property HideLetterHeadsPO: Boolean Read FbHideLetterHeadsPO;
    Property HideLetterHeadsINV: Boolean Read FbHideLetterHeadsINV;
    Property HideLetterHeadsQ: Boolean Read FbHideLetterHeadsQ;
    Property InventoryDecimal: Integer Read FiInventoryDecimal;
    Property InvoiceLayout: String Read FsInvoiceLayout;
    Property JobsRequired: Boolean Read FbJobsRequired;
    Property JobsVisible: Boolean Read FbJobsVisible;
    Property KeyboardType: String Read FsKeyboardType;
    property OpenLogwhenupdated: boolean read fOpenLogwhenupdated;
    Property POLayout: String Read FsPOLayout;
    Property PriceUpdateOnCostDec: Boolean Read FbPriceUpdateOnCostDec;
    Property PriceUpdateOnCostInc: Boolean Read FbPriceUpdateOnCostInc;
    Property PrimaryFax: String Read FsPrimaryFax;
    Property PrintEquipment: Boolean Read FbPrintEquipment;
    Property PrjStatusColours: Boolean Read FbPrjStatusColours;
    Property Remittance: Boolean Read FbRemittance;
    Property ScannerType: String Read FsScannerType;
    Property RemoteSite: Boolean Read FbRemoteSite Write FbRemoteSite;
    Property ShowDepositsInGL: Boolean Read FbShowDepositsInGL;
    Property ShowGroupLines: Boolean Read FbShowGroupLines;
    Property ShowGroupLinesOnQuote: Boolean Read FbShowGroupLinesOnQuote;
    Property ShowOnlyQualifiedCrew: Boolean Read FbShowOnlyQualifiedCrew;
    Property ShowPOValues: Boolean Read FbShowPOValues;
    Property ShowPaymentAmountsAgainstInvoice: Boolean Read FbShowPaymentAmountsAgainstInvoice;
    Property SmartOrderPrintDevice: String Read FsSmartOrderPrintDevice;
    Property SmartOrderPrintDriver: String Read FsSmartOrderPrintDriver;
    Property SmartOrderPrintPort: String Read FsSmartOrderPrintPort;
    Property SpaceRentPartName: String Read GetSpaceRentPartName;
    Property TOSLaybys: Boolean Read FbTOSLaybys;
    Property TransferMode1: Boolean Read FbTransferMode1;
    Property UnitBookingServiceEndHeader: String Read FsUnitBookingServiceEndHeader;
    Property UnitBookingServiceStartHeader: String Read FsUnitBookingServiceStartHeader;
    Property UnitBookingUnitStartHeader: String Read FsUnitBookingUnitStartHeader;
    Property UnitBookingUnitEndHeader: String Read FsUnitBookingUnitEndHeader;
    Property UseForeignCurrencyonCustPay: Boolean Read FbUseForeignCurrencyonCustPay;
    Property UseForeignCurrencyonSuppPay: Boolean Read FbUseForeignCurrencyonSuppPay;
    Property UseHospitality: Boolean Read FbUseHospitality;
    Property UsePersonalPreference: Boolean Read FbUsePersonalPreference;
    Property UsePoolCare: Boolean Read FbUsePoolCare;
    Property UseRadioFreqTracking: Boolean Read FbUseRadioFreqTracking;
    Property UseRaptor: Boolean Read FbUseRaptor;
    Property UseRollaBlinds: Boolean Read FbUseRollaBlinds;
    Property UseRunAndSequenceOnSO: Boolean Read FbUseRunAndSequenceOnSO;
    Property UseScoping: Boolean Read FbUseScoping;
    Property VerifyLockdownDate: TDateTime Read FdVerifyLockdownDate;
    Property UpdateFormulawhenManufacturingUpdateBatch: Boolean Read FbUpdateFormulawhenManufacturingUpdateBatch;
    //Property EnforceSerialTracking: Boolean Read FbEnforceSerialTracking;

    Procedure DoPopulateMe;
End;


implementation

uses ERPdbComponents, SysUtils, CommonDbLib;

{ TCompanyPrefdeleted }

procedure TCompanyPrefdeleted.DoPopulateMe;
begin
    FiARTerms3                := FieldByName('ARTerms3').AsInteger;
    FiARTerms5                := FieldByName('ARTerms5').AsInteger;
    FiARTerms2                := FieldByName('ARTerms2').AsInteger;
    FiARTerms1                := FieldByName('ARTerms1').AsInteger;
    FiAPTerms2                := FieldByName('APTerms2').AsInteger;
    FiAPTerms4                := FieldByName('APTerms4').AsInteger;
    FiAPTerms5                := FieldByName('APTerms5').AsInteger;
    FiARTerms4                := FieldByName('ARTerms4').AsInteger;
    FbAskForInvoiceNumberOnRefund                    := FieldByName('AskForInvoiceNumberOnRefund').AsBoolean;
    FbAutoOrder               := FieldByName('AutoOrder').AsBoolean;
    FbAutoPeriodChange                               := FieldByName('AutoPeriodChange').AsBoolean;
    fbAutoReceiveonPortionControl := FieldByName('AutoReceiveonPortionControl').AsBoolean;
    fbAutoShiponPortionControl := FieldByName('AutoShiponPortionControl').AsBoolean;
    FbCalcUsingDepot                                 := FieldByName('CalcUsingDepot').AsBoolean;
    FbUseCallMonitor                                                                                 := FieldByName('UseCallMonitor').AsBoolean;
    FiCallMonitorHideTime                                                  := FieldByName('CallMonitorHideTime').AsInteger;
    FsRecordingDirectory                                                                             := FieldByName('RecordingDirectory').AsString;
    FbClassCompany               := FieldByName('ClassCompany').AsBoolean;
    FbClassRequired               := FieldByName('ClassRequired').AsBoolean;
    FbClassVisible               := FieldByName('ClassVisible').AsBoolean;
    FbDupPartsOK                 := FieldByName('DupPartsOK').AsBoolean;
    FdEmailMaxSize                      := FieldByName('EmailMaxSize').AsFloat;
    FbEnableCogsAdjustmentPosting  := FieldByName('EnableCogsAdjustmentPosting').AsBoolean;
    FbHideLetterHeadsCashSale := FieldByName('HideLetterHeadsCashSale').AsBoolean;
    FbHideLetterHeadsCustPayment := FieldByName('HideLetterHeadsCustPayment').AsBoolean;
    FbHideLetterHeadsQ           := FieldByName('HideLetterHeadsQ').AsBoolean;
    FbHideLetterHeadsPO             := FieldByName('HideLetterHeadsPO').AsBoolean;
    FbHideLetterHeadsINV      := FieldByName('HideLetterHeadsINV').AsBoolean;
    FiInventoryDecimal           := FieldByName('InventoryDecimal').AsInteger;
    FsInvoiceLayout              := FieldByName('InvoiceLayout').AsString;
    FbJobsRequired               := FieldByName('JobsRequired').AsBoolean;
    FbJobsVisible                := FieldByName('JobsVisible').AsBoolean;
    FsKeyboardType               := FieldByName('KeyboardType').AsString;
    FsMatrixSortPriority                                                   := FieldByName('MatrixSortPriority').AsString;
    fOpenLogwhenupdated := FieldByName('OpenLogwhenupdated').AsBoolean;
    FsPOLayout                   := FieldByName('POLayout').AsString;
    FbPriceUpdateOnCostDec                                                                           := FieldByName('PriceUpdateOnCostDec').AsBoolean;
    FbPriceUpdateOnCostInc                                                                           := FieldByName('PriceUpdateOnCostInc').AsBoolean;
    FsPrimaryFax                              := FieldByName('PrimaryFax').AsString;
    FbPrintEquipment                := FieldByName('PrintEquipment').AsBoolean;
    FbPrjStatusColours               := FieldByName('PrjStatusColours').AsBoolean;
    FbRemittance                    := FieldByName('Remittance').AsBoolean;
    FsScannerType                := FieldByName('ScannerType').AsString;
    FbRemoteSite                                  := FieldByName('RemoteSite').AsBoolean;
    FbShowGroupLines                := FieldByName('ShowGroupLines').AsBoolean;
    FbShowGroupLinesOnQuote   := FieldByName('ShowGroupLinesOnQuote').AsBoolean;
    FbShowOnlyQualifiedCrew                      := FieldByName('ShowOnlyQualifiedCrew').AsBoolean;
    FbShowPOValues               := FieldByName('ShowPOValues').AsBoolean;
    FbShowPaymentAmountsAgainstInvoice        := FieldByName('Show_Amounts_Against_Inv').AsBoolean;
    FsSmartOrderPrintDevice                          := FieldByName('SmartOrderPrintDevice').AsString;
    FsSmartOrderPrintDriver                          := FieldByName('SmartOrderPrintDriver').AsString;
    FsSmartOrderPrintPort                            := FieldByName('SmartOrderPrintPort').AsString;
    FsSpaceRentPartName                                                    := FieldByName('SpaceRentPartName').AsString;
    FbTOSLaybys                               := FieldByName('TOSLaybys').AsBoolean;
    FbTransferMode1                 := FieldByName('TransferMode1').AsBoolean;
    FsUnitBookingServiceEndHeader                    := FieldByName('UnitBookingServiceEndHeader').AsString;
    FsUnitBookingServiceStartHeader                  := FieldByName('UnitBookingServiceStartHeader').AsString;
    FsUnitBookingUnitStartHeader                     := FieldByName('UnitBookingUnitStartHeader').AsString;
    FsUnitBookingUnitEndHeader                       := FieldByName('UnitBookingUnitEndHeader').AsString;
    FbUseForeignCurrencyonCustPay                                                                    := FieldByName('UseForeignCurrencyonCustPay').AsBoolean;
    FbUseForeignCurrencyonSuppPay                                                                    := FieldByName('UseForeignCurrencyonSuppPay').AsBoolean;
    FbUseHospitality                := FieldByName('UseHospitality').AsBoolean;
    FbUsePersonalPreference      := FieldByName('UsePersonalPreference').AsBoolean;
    FbUsePoolCare                       := FieldByName('UsePoolCare').AsBoolean;
    FbUseRadioFreqTracking              := FieldByName('UseRadioFreqTracking').AsBoolean;
    FbUseRaptor                    := FieldByName('UseRaptor').AsBoolean;
    FbUseRollaBlinds                    := FieldByName('UseRollaBlinds').AsBoolean;
    FbUseRunAndSequenceOnSO                          := FieldByName('UseRunAndSequenceOnSO').AsBoolean;
    FbUseScoping                        := FieldByName('UseScoping').AsBoolean;
    FdVerifyLockdownDate                := FieldByName('VerifyLockdownDate').AsDateTime;
    FbUpdateFormulawhenManufacturingUpdateBatch  := FieldByName('UpdateFormulawhenManufacturingUpdateBatch').AsBoolean;
    //FbEnforceSerialTracking        := FieldByName('EnforceSerialTracking').AsBoolean;


end;
Function TCompanyPrefdeleted.GetSpaceRentPartName: String;
Begin
  FsSpaceRentPartName := LoadFieldValue('SpaceRentPartName');
  Result              := FsSpaceRentPartName;
End;

{ TPayPreferencesDEleted }

function TPayPreferencesDEleted.PopulateMe: boolean;
begin
        fiARAccountID := FieldByName('ARAccountID').AsInteger;
        fiDefaultPaperID := FieldByName('DefaultPaperID').AsInteger;
        fbEFTIncBalance := FieldByName('EFTIncBalance').AsBoolean;
        fbEFTIncNet := FieldByName('EFTIncNet').AsBoolean;
        fbEFTIncCredit := FieldByName('EFTIncCredit').AsBoolean;
        fbEFTIncDebit := FieldByName('EFTIncDebit').AsBoolean;
        fiExpensesAccountID := FieldByName('ExpensesAccountID').AsInteger;
        fdGSTTaxRateWC := FieldByName('GSTTaxRateWC').AsFloat;
        fiLabourIncomeAccountID := FieldByName('LabourIncomeAccountID').AsInteger;
        fiNICsEmployeePaidAccountID := FieldByName('NICsEmployeePaidAccountID').AsInteger;
        fiNICsEmployeePayableAccountID := FieldByName('NICsEmployeePayableAccountID').AsInteger;
        fiNICsEmployerPaidAccountID := FieldByName('NICsEmployerPaidAccountID').AsInteger;
        fiNICsEmployerPayableAccountID := FieldByName('NICsEmployerPayableAccountID').AsInteger;
        fiNoABNAccountID := FieldByName('NoABNAccountID').AsInteger;
        fiNoABNExpenseAccountID := FieldByName('NoABNExpenseAccountID').AsInteger;
        fiPAYGTaxPaidAccountID := FieldByName('PAYGTaxPaidAccountID').AsInteger;
        fiPayrollTaxPaidAccountID := FieldByName('PayrollTaxPaidAccountID').AsInteger;
        fiPayrollTaxPayableAccountID := FieldByName('PayrollTaxPayableAccountID').AsInteger;
        fiPaySlipType := FieldByName('PaySlipType').AsInteger;
        fsPaySummaryType := FieldByName('PaySummaryType').AsString;
        fbTaxOnSuperWC := FieldByName('TaxOnSuperWC').AsBoolean;
        fsTaxPaidIn := FieldByName('TaxPaidIn').AsString;
        fUKNICClass3Rate := FieldByName('UKNICClass3Rate').AsFloat;
        fdUKTaxBasicAllowance := FieldByName('UKTaxBasicAllowance').AsFloat;
        fdUKTaxAllowance6574 := FieldByName('UKTaxAllowance6574').AsFloat;
        fdUKTaxAllowance75 := FieldByName('UKTaxAllowance75').AsFloat;
        fdUKTaxBasicAllowanceLimit := FieldByName('UKTaxBasicAllowanceLimit').AsFloat;
        fdUKTaxAllowance6574Limit := FieldByName('UKTaxAllowance6574Limit').AsFloat;
        fdUKTaxAllowance75Limit := FieldByName('UKTaxAllowance75Limit').AsFloat;
        fdUKTaxStartRateUpperThreshold := FieldByName('UKTaxStartRateUpperThreshold').AsFloat;
        fdUKTaxBasicRateUpperThreshold := FieldByName('UKTaxBasicRateUpperThreshold').AsFloat;
        fdUKTaxStartingRateDividend := FieldByName('UKTaxStartingRateDividend').AsFloat;
        fdUKTaxStartingRateSavings := FieldByName('UKTaxStartingRateSavings').AsFloat;
        fdUKTaxStartingRateOther := FieldByName('UKTaxStartingRateOther').AsFloat;
        fdUKTaxBasicRateDividend := FieldByName('UKTaxBasicRateDividend').AsFloat;
        fdUKTaxBasicRateSavings := FieldByName('UKTaxBasicRateSavings').AsFloat;
        fdUKTaxBasicRateOther := FieldByName('UKTaxBasicRateOther').AsFloat;
        fdUKTaxHigherRateDividend := FieldByName('UKTaxHigherRateDividend').AsFloat;
        fdUKTaxHigherRateSavings := FieldByName('UKTaxHigherRateSavings').AsFloat;
        fdUKTaxHigherRateOther := FieldByName('UKTaxHigherRateOther').AsFloat;
        fdUKTaxMaxRate := FieldByName('UKTaxMaxRate').AsFloat;
        fdUKTaxEmergencyCode := FieldByName('UKTaxEmergencyTaxCode').AsString;

        fUKNICEarningsThreshold1 := FieldByName('UKNICEarningsThreshold1').AsFloat;
        fUKNICEarningsThreshold2 := FieldByName('UKNICEarningsThreshold2').AsFloat;
        fUKNICEmployeeClass1Rate2 := FieldByName('UKNICEmployeeClass1Rate2').AsFloat;
        fUKNICEmployeesClass1Rate1 := FieldByName('UKNICEmployeesClass1Rate1').AsFloat;
        fUKNICEmployeesContractedOutRebate := FieldByName('UKNICEmployeesContractedOutRebate').AsFloat;
        fUKNICEmployersClass1Rate1 := FieldByName('UKNICEmployersClass1Rate1').AsFloat;
        fUKNICEmployersClass1Rate2 := FieldByName('UKNICEmployersClass1Rate2').AsFloat;
        fUKNICEmployersContractedOutRebateM := FieldByName('UKNICEmployersContractedOutRebateM').AsFloat;
        fUKNICEmployersContractedOutRebateS := FieldByName('UKNICEmployersContractedOutRebateS').AsFloat;
        fUKNICLowerEarningsLimit := FieldByName('UKNICLowerEarningsLimit').AsFloat;
        fUKNICUpperEarningsLimit := FieldByName('UKNICUpperEarningsLimit').AsFloat;
        fUKNICMarriedWomanClass1Rate1 := FieldByName('UKNICMarriedWomanClass1Rate1').AsFloat;
        fUKNICMarriedWomanClass1Rate2 := FieldByName('UKNICMarriedWomanClass1Rate2').AsFloat;

        fUKNICLowerEarningsLimitWK := FieldByName('UKNICLowerEarningsLimitWK').AsFloat;
        fUKNICLowerEarningsLimitMTH := FieldByName('UKNICLowerEarningsLimitMTH').AsFloat;
        fUKNICEarningsThreshold1WK := FieldByName('UKNICEarningsThreshold1WK').AsFloat;
        fUKNICEarningsThreshold1MTH := FieldByName('UKNICEarningsThreshold1MTH').AsFloat;
        fUKNICEarningsThreshold2WK := FieldByName('UKNICEarningsThreshold2WK').AsFloat;
        fUKNICEarningsThreshold2MTH := FieldByName('UKNICEarningsThreshold2MTH').AsFloat;
        fUKNICUpperEarningsLimitWK := FieldByName('UKNICUpperEarningsLimitWK').AsFloat;
        fUKNICUpperEarningsLimitMTH := FieldByName('UKNICUpperEarningsLimitMTH').AsFloat;
        fUKStartFiscalYear := FieldByName('UKStartFiscalYear').AsDateTime;
        fiWagesPayableAccountID := FieldByName('WagesPayableAccountID').AsInteger;
        fiWorkCoverPayableAccountID := FieldByName('WorkCoverPayableAccountID').AsInteger;
        fiWorkersCompPayableAccountID := FieldByName('WorkersCompPayableAccountID').AsInteger;
        fiWorkersCompPaidAccountID := FieldByName('WorkersCompPaidAccountID').AsInteger;
                //fiPAYGExpenseAccountID := FieldByName('PAYGExpenseAccountID').AsInteger;


end;
procedure TBusObjProcPrefsDeleted.SetUpdateFormulawhenManufacturingUpdateBatch(const Value: boolean);
begin
  if fbUpdateFormulawhenManufacturingUpdateBatch <> Value then
  begin
    fbUpdateFormulawhenManufacturingUpdateBatch := Value;
    MakeDirty;
  end;
end;
procedure TBusObjProcPrefsDeleted.SetUpdateLinenowhenManufacturingUpdateBatch(const Value: boolean);
begin
  if fbUpdateLinenowhenManufacturingUpdateBatch <> Value then
  begin
    fbUpdateLinenowhenManufacturingUpdateBatch := Value;
    MakeDirty;
  end;
end;

{ TEmployeeDeleted }

procedure TEmployeeDeleted.PopulateMe(const iEmployeeID: integer;  const UserOnly: boolean);
begin
  inherited;
    with qryPersonalPreferences do try
          fbTips := FieldByName('Tips').AsBoolean;
          fbMaxButton := FieldByName('MaxButton').AsBoolean;
          fbPOStandard := FieldByName('POStandard').AsBoolean;
          fbPOColumn := FieldByName('POColumn').AsBoolean;
          fbPOColumnLandscape := FieldByName('POColumnLandscape').AsBoolean;
          fbPOInvoiceNoOFF := FieldByName('POInvoiceNoOFF').AsBoolean;
          fbTurnSoundOff := FieldByName('TurnSoundOff').AsBoolean;
          fiRepairAppearDays := FieldByName('RepairAppearDays').AsInteger;
          fiSortByColumn := FieldByName('SortByColumn').AsInteger;
          fbShowProductsWithQty := FieldByName('ShowProductsWithQty').AsBoolean;
          fbShowAllProducts := FieldByName('ShowAllProducts').AsBoolean;
          fbShowReorderLevel := FieldByName('ShowReorderLevel').AsBoolean;
          fbShowReorderPoint := FieldByName('ShowReorderPoint').AsBoolean;
          fbShowCostEx := FieldByName('ShowCostEx').AsBoolean;
          fbShowSellInc := FieldByName('ShowSellInc').AsBoolean;
          fbDateNow := FieldByName('DateNow').AsBoolean;
          fbSOrderListIsLayBy := FieldByName('SOrderListIsLayBy').AsBoolean;
          if FieldByName('SmallBtnColour').AsString<> '' then
            fsSmallBtnColour := StrToInt(FieldByName('SmallBtnColour').AsString);
          fsHireInvDueNotify := FieldByName('HireInvDueNotify').AsString;
          fbBookingReminderInterval := FieldByName('BookingReminderInterval').AsInteger;
          fbEmployeeReminderInterval := FieldByName('EmployeeReminderInterval').AsInteger;
          fiActiveGant := FieldByName('ActiveGant').AsInteger;
          fbGantShowAddress := FieldByName('GantShowAddress').AsBoolean;
          fiFuncBookingAppearDays := FieldByName('FuncBookingAppearDays').AsInteger;
          fiHireContractEndingAppearDays := FieldByName('HireContractEndAppearDays').AsInteger;
          fbOverrideAutoRepairs := FieldByName('OverrideAutoRepairs').AsBoolean;
          fbShowCompanyAsDefaultOnRun := FieldByName('ShowCompanyAsDefaultOnRun').AsBoolean;
          fiNextDeliveryRunAppearDays := FieldByName('NextDeliveryRunAppearDays').AsInteger;
          fbShowHint := FieldByname('ShowHints').ASBoolean;
          fiRegInvoiceAppearDays := FieldByName('RegInvoiceAppearDays').AsInteger;
          fbEmailPromptAttach := FieldByName('EmailPromptAttach').AsBoolean;
          fbResetToHrsTabPayEmployee := FieldByName('ResetToHrsTabPayEmployee').AsBoolean;
          fbShowNewInstallDoc := FieldByName('ShowNewInstallDoc').AsBoolean;
    finally
    end;
end;
procedure TEmployeeDeleted.SetGantShowAddress(Value: boolean);
var
  qryTemp: TERPCommand;
  ValueStr: string;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;

  if Value then begin
    ValueStr := 'T';
  end else begin
    ValueStr := 'F';
  end;

  try
    qryTemp.Sql.Add('UPDATE tblpersonalpreferences SET GantShowAddress= ' + QuotedStr(ValueStr) +
      ' Where EmployeeID=' + IntToStr(fiEmployeeID) + ';');
    qryTemp.Execute;
    fbGantShowAddress := Value;
  finally
    FreeAndNil(qryTemp);
  end;
end;
procedure TEmployeeDeleted.SetActiveGant(Value: integer);
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;

  try
    qryTemp.Sql.Add('UPDATE tblpersonalpreferences SET ActiveGant = ' + IntToStr(Value) +
      ' Where EmployeeID=' + IntToStr(fiEmployeeID) + ';');
    qryTemp.Execute;
    fiActiveGant := Value;
  finally
    FreeAndNil(qryTemp);
  end;
end;
procedure TEmployeeDeleted.SetShowNewInstallDoc(Value: boolean);
var
  qryTemp: TERPCommand;
  ValueStr: string;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;

  if Value then begin
    ValueStr := 'T';
  end else begin
    ValueStr := 'F';
  end;

  try
    qryTemp.Sql.Add('UPDATE tblpersonalpreferences SET ShowNewInstallDoc= ' +
      QuotedStr(ValueStr) + ' Where EmployeeID=' + IntToStr(fiEmployeeID) + ';');
    qryTemp.Execute;
    fbShowNewInstallDoc := Value;
  finally
    FreeAndNil(qryTemp);
  end;
end;

{ TPersonalPreferencesDeleted }


procedure TPersonalPreferencesDeleted.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  SetBooleanPropertyFromNode(node,'MaxButton');
  SetBooleanPropertyFromNode(node,'Tips');
  SetBooleanPropertyFromNode(node,'POStandard');
  SetBooleanPropertyFromNode(node,'POColumn');
  SetBooleanPropertyFromNode(node,'POColumnLandscape');
  SetBooleanPropertyFromNode(node,'POInvoiceNoOFF');
  SetBooleanPropertyFromNode(node,'TurnSoundOff');
  SetPropertyFromNode(node,'RepairAppearDays');
  SetPropertyFromNode(node,'SortByColumn');
  SetBooleanPropertyFromNode(node,'ShowProductsWithQty');
  SetBooleanPropertyFromNode(node,'ShowAllProducts');
  SetBooleanPropertyFromNode(node,'ShowReOrderLevel');
  SetBooleanPropertyFromNode(node,'ShowReOrderPoint');
  SetBooleanPropertyFromNode(node,'ShowCostEx');
  SetBooleanPropertyFromNode(node,'ShowSellInc');
  SetBooleanPropertyFromNode(node,'DateNow');
  SetBooleanPropertyFromNode(node,'SOrderListIsLayBy');
  SetBooleanPropertyFromNode(node,'AutoApplyCustPay');
  SetBooleanPropertyFromNode(node,'AutoApplySuppPay');
  SetPropertyFromNode(node,'SmallBtnColour');
  SetPropertyFromNode(node,'ProgressPaymentsAppearDays');
  SetPropertyFromNode(node,'ProjectPurchasesAppearDays');
  SetBooleanPropertyFromNode(node,'HireInvDueNotify');
  SetPropertyFromNode(node,'BookingReminderInterval');
  SetPropertyFromNode(node,'EmployeeReminderInterval');
  SetDateTimePropertyFromNode(node,'LastRemindedDate');
  SetBooleanPropertyFromNode(node,'UseSnapshotProductsComboInv');
  SetBooleanPropertyFromNode(node,'UseSnapshotProductList');
  SetBooleanPropertyFromNode(node,'UseSearchLikeProductComboInv');
  SetPropertyFromNode(node,'CalendarReps');
  SetPropertyFromNode(node,'ActiveGant');
  SetBooleanPropertyFromNode(node,'GantShowAddress');
  SetPropertyFromNode(node,'FuncBookingAppearDays');
  SetPropertyFromNode(node,'HireContractEndAppearDays');
  SetBooleanPropertyFromNode(node,'OverrideAutoRepairs');
  SetBooleanPropertyFromNode(node,'ShowCompanyAsDefaultOnRun');
  SetPropertyFromNode(node,'HintStartColor');
  SetPropertyFromNode(node,'HintEndColor');
  SetPropertyFromNode(node,'HintFontName');
  SetPropertyFromNode(node,'HintFontSize');
  SetPropertyFromNode(node,'HintFontStyle');
  SetPropertyFromNode(node,'HintFontColor');
  SetPropertyFromNode(node,'NextDeliveryRunAppearDays');
  SetBooleanPropertyFromNode(node,'showhints');
  SetPropertyFromNode(node,'skinoption');
  SetBooleanPropertyFromNode(node,'skinoptionMarble');
  SetPropertyFromNode(node,'AppointmentServiceColumns');
  SetPropertyFromNode(node,'RegInvoiceAppearDays');
  SetBooleanPropertyFromNode(node,'EmailPromptAttach');
  SetBooleanPropertyFromNode(node,'ResetToHrsTabPayEmployee');
  SetPropertyFromNode(node,'EquipmentServiceAppearDays');
  SetPropertyFromNode(node,'ERPLicenseRenewalAppearDays');
  SetBooleanPropertyFromNode(node,'ShowNewInstallDoc');
  SetBooleanPropertyFromNode(node,'ShowMarketingContactInGlobalList');
  (*SetPropertyFromNode(node,'PAYGExpenseAccountID');*)
end;
procedure TPersonalPreferencesDeleted.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Tips' ,Tips);
  AddXMLNode(node,'MaxButton' ,MaxButton);
  AddXMLNode(node,'POStandard' ,POStandard);
  AddXMLNode(node,'POColumn' ,POColumn);
  AddXMLNode(node,'POColumnLandscape' ,POColumnLandscape);
  AddXMLNode(node,'POInvoiceNoOFF' ,POInvoiceNoOFF);
  AddXMLNode(node,'TurnSoundOff' ,TurnSoundOff);
  AddXMLNode(node,'RepairAppearDays' ,RepairAppearDays);
  AddXMLNode(node,'SortByColumn' ,SortByColumn);
  AddXMLNode(node,'ShowProductsWithQty' ,ShowProductsWithQty);
  AddXMLNode(node,'ShowAllProducts' ,ShowAllProducts);
  AddXMLNode(node,'ShowReOrderLevel' ,ShowReOrderLevel);
  AddXMLNode(node,'ShowReOrderPoint' ,ShowReOrderPoint);
  AddXMLNode(node,'ShowCostEx' ,ShowCostEx);
  AddXMLNode(node,'ShowSellInc' ,ShowSellInc);
  AddXMLNode(node,'DateNow' ,DateNow);
  AddXMLNode(node,'SOrderListIsLayBy' ,SOrderListIsLayBy);
  AddXMLNode(node,'AutoApplyCustPay' ,AutoApplyCustPay);
  AddXMLNode(node,'AutoApplySuppPay' ,AutoApplySuppPay);
  AddXMLNode(node,'SmallBtnColour' ,SmallBtnColour);
  AddXMLNode(node,'ProgressPaymentsAppearDays' ,ProgressPaymentsAppearDays);
  AddXMLNode(node,'ProjectPurchasesAppearDays' ,ProjectPurchasesAppearDays);
  AddXMLNode(node,'HireInvDueNotify' ,HireInvDueNotify);
  AddXMLNode(node,'BookingReminderInterval' ,BookingReminderInterval);
  AddXMLNode(node,'EmployeeReminderInterval' ,EmployeeReminderInterval);
  AddXMLNode(node,'LastRemindedDate' ,LastRemindedDate);
  AddXMLNode(node,'UseSnapshotProductsComboInv' ,UseSnapshotProductsComboInv);
  AddXMLNode(node,'UseSnapshotProductList' ,UseSnapshotProductList);
  AddXMLNode(node,'UseSearchLikeProductComboInv' ,UseSearchLikeProductComboInv);
  AddXMLNode(node,'CalendarReps' ,CalendarReps);
  AddXMLNode(node,'ActiveGant' ,ActiveGant);
  AddXMLNode(node,'GantShowAddress' ,GantShowAddress);
  AddXMLNode(node,'FuncBookingAppearDays' ,FuncBookingAppearDays);
  AddXMLNode(node,'HireContractEndAppearDays' ,HireContractEndAppearDays);
  AddXMLNode(node,'OverrideAutoRepairs' ,OverrideAutoRepairs);
  AddXMLNode(node,'ShowCompanyAsDefaultOnRun' ,ShowCompanyAsDefaultOnRun);
  AddXMLNode(node,'HintStartColor' ,HintStartColor);
  AddXMLNode(node,'HintEndColor' ,HintEndColor);
  AddXMLNode(node,'HintFontName' ,HintFontName);
  AddXMLNode(node,'HintFontSize' ,HintFontSize);
  AddXMLNode(node,'HintFontStyle' ,HintFontStyle);
  AddXMLNode(node,'HintFontColor' ,HintFontColor);
  AddXMLNode(node,'NextDeliveryRunAppearDays' ,NextDeliveryRunAppearDays);
  AddXMLNode(node,'showhints' ,showhints);
  AddXMLNode(node,'skinoption' ,skinoption);
  AddXMLNode(node,'skinoptionMarble' ,skinoptionMarble);
  AddXMLNode(node,'AppointmentServiceColumns' ,AppointmentServiceColumns);
  AddXMLNode(node,'RegInvoiceAppearDays' ,RegInvoiceAppearDays);
  AddXMLNode(node,'EmailPromptAttach' ,EmailPromptAttach);
  AddXMLNode(node,'ResetToHrsTabPayEmployee' ,ResetToHrsTabPayEmployee);
  AddXMLNode(node,'EquipmentServiceAppearDays' ,EquipmentServiceAppearDays);
  AddXMLNode(node,'ERPLicenseRenewalAppearDays' ,ERPLicenseRenewalAppearDays);
  AddXMLNode(node,'ShowNewInstallDoc' ,ShowNewInstallDoc);
  AddXMLNode(node,'ShowMarketingContactInGlobalList' ,ShowMarketingContactInGlobalList);
  (*AddXMLNode(node,'PAYGExpenseAccountID', PAYGExpenseAccountID);*)
end;


function  TPersonalPreferencesDeleted.GetTips                                    : Boolean   ; begin Result := GetBooleanField('Tips')                                      ;end;
procedure TPersonalPreferencesDeleted.SetTips                                    (const Value: Boolean   ); begin SetBooleanField('Tips'                                       , Value);end;
function  TPersonalPreferencesDeleted.GetMaxButton                               : Boolean   ; begin Result := GetBooleanField('MaxButton')                                 ;end;
procedure TPersonalPreferencesDeleted.SetMaxButton                               (const Value: Boolean   ); begin SetBooleanField('MaxButton'                                  , Value);end;
function  TPersonalPreferencesDeleted.GetPOStandard                              : Boolean   ; begin Result := GetBooleanField('POStandard')                                ;end;
procedure TPersonalPreferencesDeleted.SetPOStandard                              (const Value: Boolean   ); begin SetBooleanField('POStandard'                                 , Value);end;
function  TPersonalPreferencesDeleted.GetPOColumn                                : Boolean   ; begin Result := GetBooleanField('POColumn')                                  ;end;
function  TPersonalPreferencesDeleted.GetPOColumnLandscape                       : Boolean   ; begin Result := GetBooleanField('POColumnLandscape')                         ;end;
procedure TPersonalPreferencesDeleted.SetPOColumn                                (const Value: Boolean   ); begin SetBooleanField('POColumn'                                   , Value);end;
procedure TPersonalPreferencesDeleted.SetPOColumnLandscape                       (const Value: Boolean   ); begin SetBooleanField('POColumnLandscape'                          , Value);end;
function  TPersonalPreferencesDeleted.GetPOInvoiceNoOFF                          : Boolean   ; begin Result := GetBooleanField('POInvoiceNoOFF')                            ;end;
procedure TPersonalPreferencesDeleted.SetPOInvoiceNoOFF                          (const Value: Boolean   ); begin SetBooleanField('POInvoiceNoOFF'                             , Value);end;
function  TPersonalPreferencesDeleted.GetTurnSoundOff                            : Boolean   ; begin Result := GetBooleanField('TurnSoundOff')                              ;end;
procedure TPersonalPreferencesDeleted.SetTurnSoundOff                            (const Value: Boolean   ); begin SetBooleanField('TurnSoundOff'                               , Value);end;
function  TPersonalPreferencesDeleted.GetRepairAppearDays                        : Integer   ; begin Result := GetIntegerField('RepairAppearDays')                          ;end;
procedure TPersonalPreferencesDeleted.SetRepairAppearDays                        (const Value: Integer   ); begin SetIntegerField('RepairAppearDays'                           , Value);end;
function  TPersonalPreferencesDeleted.GetSortByColumn                            : Integer   ; begin Result := GetIntegerField('SortByColumn')                              ;end;
procedure TPersonalPreferencesDeleted.SetSortByColumn                            (const Value: Integer   ); begin SetIntegerField('SortByColumn'                               , Value);end;
function  TPersonalPreferencesDeleted.GetShowProductsWithQty                     : Boolean   ; begin Result := GetBooleanField('ShowProductsWithQty')                       ;end;
procedure TPersonalPreferencesDeleted.SetShowProductsWithQty                     (const Value: Boolean   ); begin SetBooleanField('ShowProductsWithQty'                        , Value);end;
function  TPersonalPreferencesDeleted.GetShowAllProducts                         : Boolean   ; begin Result := GetBooleanField('ShowAllProducts')                           ;end;
procedure TPersonalPreferencesDeleted.SetShowAllProducts                         (const Value: Boolean   ); begin SetBooleanField('ShowAllProducts'                            , Value);end;
function  TPersonalPreferencesDeleted.GetShowReOrderLevel                        : Boolean   ; begin Result := GetBooleanField('ShowReOrderLevel')                          ;end;
function  TPersonalPreferencesDeleted.GetShowReOrderPoint                        : Boolean   ; begin Result := GetBooleanField('ShowReOrderPoint')                          ;end;
procedure TPersonalPreferencesDeleted.SetShowReOrderLevel                        (const Value: Boolean   ); begin SetBooleanField('ShowReOrderLevel'                           , Value);end;
procedure TPersonalPreferencesDeleted.SetShowReOrderPoint                        (const Value: Boolean   ); begin SetBooleanField('ShowReOrderPoint'                           , Value);end;
function  TPersonalPreferencesDeleted.GetShowCostEx                              : Boolean   ; begin Result := GetBooleanField('ShowCostEx')                                ;end;
function  TPersonalPreferencesDeleted.GetShowSellInc                             : Boolean   ; begin Result := GetBooleanField('ShowSellInc')                               ;end;
procedure TPersonalPreferencesDeleted.SetShowCostEx                              (const Value: Boolean   ); begin SetBooleanField('ShowCostEx'                                 , Value);end;
procedure TPersonalPreferencesDeleted.SetShowSellInc                             (const Value: Boolean   ); begin SetBooleanField('ShowSellInc'                                , Value);end;
function  TPersonalPreferencesDeleted.GetDateNow                                 : Boolean   ; begin Result := GetBooleanField('DateNow')                                   ;end;
procedure TPersonalPreferencesDeleted.SetDateNow                                 (const Value: Boolean   ); begin SetBooleanField('DateNow'                                    , Value);end;
function  TPersonalPreferencesDeleted.GetSOrderListIsLayBy                       : Boolean   ; begin Result := GetBooleanField('SOrderListIsLayBy')                         ;end;
procedure TPersonalPreferencesDeleted.SetSOrderListIsLayBy                       (const Value: Boolean   ); begin SetBooleanField('SOrderListIsLayBy'                          , Value);end;
function  TPersonalPreferencesDeleted.GetAutoApplyCustPay                        : Boolean   ; begin Result := GetBooleanField('AutoApplyCustPay')                          ;end;
procedure TPersonalPreferencesDeleted.SetAutoApplyCustPay                        (const Value: Boolean   ); begin SetBooleanField('AutoApplyCustPay'                           , Value);end;
function  TPersonalPreferencesDeleted.GetAutoApplySuppPay                        : Boolean   ; begin Result := GetBooleanField('AutoApplySuppPay')                          ;end;
procedure TPersonalPreferencesDeleted.SetAutoApplySuppPay                        (const Value: Boolean   ); begin SetBooleanField('AutoApplySuppPay'                           , Value);end;
function  TPersonalPreferencesDeleted.GetSmallBtnColour                          : string    ; begin Result := GetStringField('SmallBtnColour')                             ;end;
procedure TPersonalPreferencesDeleted.SetSmallBtnColour                          (const Value: string    ); begin SetStringField('SmallBtnColour'                              , Value);end;
function  TPersonalPreferencesDeleted.GetProgressPaymentsAppearDays              : Integer   ; begin Result := GetIntegerField('ProgressPaymentsAppearDays')                ;end;
procedure TPersonalPreferencesDeleted.SetProgressPaymentsAppearDays              (const Value: Integer   ); begin SetIntegerField('ProgressPaymentsAppearDays'                 , Value);end;
function  TPersonalPreferencesDeleted.GetProjectPurchasesAppearDays              : Integer   ; begin Result := GetIntegerField('ProjectPurchasesAppearDays')                ;end;
procedure TPersonalPreferencesDeleted.SetProjectPurchasesAppearDays              (const Value: Integer   ); begin SetIntegerField('ProjectPurchasesAppearDays'                 , Value);end;
function  TPersonalPreferencesDeleted.GetHireInvDueNotify                        : Boolean   ; begin Result := GetBooleanField('HireInvDueNotify')                          ;end;
procedure TPersonalPreferencesDeleted.SetHireInvDueNotify                        (const Value: Boolean   ); begin SetBooleanField('HireInvDueNotify'                           , Value);end;
function  TPersonalPreferencesDeleted.GetBookingReminderInterval                 : Integer   ; begin Result := GetIntegerField('BookingReminderInterval')                   ;end;
procedure TPersonalPreferencesDeleted.SetBookingReminderInterval                 (const Value: Integer   ); begin SetIntegerField('BookingReminderInterval'                    , Value);end;
function  TPersonalPreferencesDeleted.GetEmployeeReminderInterval                 : Integer   ; begin Result := GetIntegerField('EmployeeReminderInterval')                   ;end;
procedure TPersonalPreferencesDeleted.SetEmployeeReminderInterval                 (const Value: Integer   ); begin SetIntegerField('EmployeeReminderInterval'                    , Value);end;
function  TPersonalPreferencesDeleted.GetLastRemindedDate                        : TDateTime ; begin Result := GetDateTimeField('LastRemindedDate')                         ;end;
procedure TPersonalPreferencesDeleted.SetLastRemindedDate                        (const Value: TDateTime ); begin SetDateTimeField('LastRemindedDate'                          , Value);end;
function  TPersonalPreferencesDeleted.GetUseSnapshotProductsComboInv             : Boolean   ; begin Result := GetBooleanField('UseSnapshotProductsComboInv')               ;end;
procedure TPersonalPreferencesDeleted.SetUseSnapshotProductsComboInv             (const Value: Boolean   ); begin SetBooleanField('UseSnapshotProductsComboInv'                , Value);end;
function  TPersonalPreferencesDeleted.GetUseSnapshotProductList                  : Boolean   ; begin Result := GetBooleanField('UseSnapshotProductList')               ;end;
procedure TPersonalPreferencesDeleted.SetUseSnapshotProductList                  (const Value: Boolean   ); begin SetBooleanField('UseSnapshotProductList'                , Value);end;
function  TPersonalPreferencesDeleted.GetUseSearchLikeProductComboInv                  : Boolean   ; begin Result := GetBooleanField('UseSearchLikeProductComboInv')               ;end;
procedure TPersonalPreferencesDeleted.SetUseSearchLikeProductComboInv                  (const Value: Boolean   ); begin SetBooleanField('UseSearchLikeProductComboInv'                , Value);end;
function  TPersonalPreferencesDeleted.GetCalendarReps                            : string    ; begin Result := GetStringField('CalendarReps')                               ;end;
procedure TPersonalPreferencesDeleted.SetCalendarReps                            (const Value: string    ); begin SetStringField('CalendarReps'                                , Value);end;
function  TPersonalPreferencesDeleted.GetActiveGant                              : Integer   ; begin Result := GetIntegerField('ActiveGant')                                ;end;
procedure TPersonalPreferencesDeleted.SetActiveGant                              (const Value: Integer   ); begin SetIntegerField('ActiveGant'                                 , Value);end;
function  TPersonalPreferencesDeleted.GetGantShowAddress                         : Boolean   ; begin Result := GetBooleanField('GantShowAddress')                           ;end;
procedure TPersonalPreferencesDeleted.SetGantShowAddress                         (const Value: Boolean   ); begin SetBooleanField('GantShowAddress'                            , Value);end;
function  TPersonalPreferencesDeleted.GetFuncBookingAppearDays                   : Integer   ; begin Result := GetIntegerField('FuncBookingAppearDays')                     ;end;
procedure TPersonalPreferencesDeleted.SetFuncBookingAppearDays                   (const Value: Integer   ); begin SetIntegerField('FuncBookingAppearDays'                      , Value);end;
function  TPersonalPreferencesDeleted.GetHireContractEndAppearDays               : Integer   ; begin Result := GetIntegerField('HireContractEndAppearDays')                 ;end;
procedure TPersonalPreferencesDeleted.SetHireContractEndAppearDays               (const Value: Integer   ); begin SetIntegerField('HireContractEndAppearDays'                  , Value);end;
function  TPersonalPreferencesDeleted.GetOverrideAutoRepairs                     : Boolean   ; begin Result := GetBooleanField('OverrideAutoRepairs')                       ;end;
procedure TPersonalPreferencesDeleted.SetOverrideAutoRepairs                     (const Value: Boolean   ); begin SetBooleanField('OverrideAutoRepairs'                        , Value);end;
function  TPersonalPreferencesDeleted.GetShowCompanyAsDefaultOnRun               : Boolean   ; begin Result := GetBooleanField('ShowCompanyAsDefaultOnRun')                 ;end;
procedure TPersonalPreferencesDeleted.SetShowCompanyAsDefaultOnRun               (const Value: Boolean   ); begin SetBooleanField('ShowCompanyAsDefaultOnRun'                  , Value);end;
function  TPersonalPreferencesDeleted.GetHintStartColor                          : string    ; begin Result := GetStringField('HintStartColor')                             ;end;
procedure TPersonalPreferencesDeleted.SetHintStartColor                          (const Value: string    ); begin SetStringField('HintStartColor'                              , Value);end;
function  TPersonalPreferencesDeleted.GetHintEndColor                            : string    ; begin Result := GetStringField('HintEndColor')                               ;end;
function  TPersonalPreferencesDeleted.GetHintFontName                            : string    ; begin Result := GetStringField('HintFontName')                               ;end;
function  TPersonalPreferencesDeleted.GetHintFontSize                            : Integer   ; begin Result := GetIntegerField('HintFontSize')                              ;end;
function  TPersonalPreferencesDeleted.GetHintFontStyle                           : Integer   ; begin Result := GetIntegerField('HintFontStyle')                             ;end;
function  TPersonalPreferencesDeleted.GetHintFontColor                           : string    ; begin Result := GetStringField('HintFontColor')                              ;end;
procedure TPersonalPreferencesDeleted.SetHintEndColor                            (const Value: string    ); begin SetStringField('HintEndColor'                                , Value);end;
procedure TPersonalPreferencesDeleted.SetHintFontName                            (const Value: string    ); begin SetStringField('HintFontName'                                , Value);end;
procedure TPersonalPreferencesDeleted.SetHintFontSize                            (const Value: Integer   ); begin SetIntegerField('HintFontSize'                               , Value);end;
procedure TPersonalPreferencesDeleted.SetHintFontStyle                           (const Value: Integer   ); begin SetIntegerField('HintFontStyle'                              , Value);end;
procedure TPersonalPreferencesDeleted.SetHintFontColor                           (const Value: string    ); begin SetStringField('HintFontColor'                               , Value);end;
function  TPersonalPreferencesDeleted.GetNextDeliveryRunAppearDays               : Integer   ; begin Result := GetIntegerField('NextDeliveryRunAppearDays')                 ;end;
procedure TPersonalPreferencesDeleted.SetNextDeliveryRunAppearDays               (const Value: Integer   ); begin SetIntegerField('NextDeliveryRunAppearDays'                  , Value);end;
function  TPersonalPreferencesDeleted.Getshowhints                               : Boolean   ; begin Result := GetBooleanField('showhints')                                 ;end;
procedure TPersonalPreferencesDeleted.Setshowhints                               (const Value: Boolean   ); begin SetBooleanField('showhints'                                  , Value);end;
function  TPersonalPreferencesDeleted.Getskinoption                              : string    ; begin Result := GetStringField('skinoption')                                 ;end;
function  TPersonalPreferencesDeleted.GetskinoptionMarble                        : Boolean   ; begin Result := GetBooleanField('skinoptionMarble')                          ;end;
procedure TPersonalPreferencesDeleted.Setskinoption                              (const Value: string    ); begin SetStringField('skinoption'                                  , Value);end;
procedure TPersonalPreferencesDeleted.SetskinoptionMarble                        (const Value: Boolean   ); begin SetBooleanField('skinoptionMarble'                           , Value);end;
function  TPersonalPreferencesDeleted.GetAppointmentServiceColumns               : Integer   ; begin Result := GetIntegerField('AppointmentServiceColumns')                 ;end;
procedure TPersonalPreferencesDeleted.SetAppointmentServiceColumns               (const Value: Integer   ); begin SetIntegerField('AppointmentServiceColumns'                  , Value);end;
function  TPersonalPreferencesDeleted.GetRegInvoiceAppearDays                    : Integer   ; begin Result := GetIntegerField('RegInvoiceAppearDays')                      ;end;
procedure TPersonalPreferencesDeleted.SetRegInvoiceAppearDays                    (const Value: Integer   ); begin SetIntegerField('RegInvoiceAppearDays'                       , Value);end;
function  TPersonalPreferencesDeleted.GetEmailPromptAttach                       : Boolean   ; begin Result := GetBooleanField('EmailPromptAttach')                         ;end;
procedure TPersonalPreferencesDeleted.SetEmailPromptAttach                       (const Value: Boolean   ); begin SetBooleanField('EmailPromptAttach'                          , Value);end;
function  TPersonalPreferencesDeleted.GetResetToHrsTabPayEmployee                : Boolean   ; begin Result := GetBooleanField('ResetToHrsTabPayEmployee')                  ;end;
procedure TPersonalPreferencesDeleted.SetResetToHrsTabPayEmployee                (const Value: Boolean   ); begin SetBooleanField('ResetToHrsTabPayEmployee'                   , Value);end;
function  TPersonalPreferencesDeleted.GetEquipmentServiceAppearDays              : Integer   ; begin Result := GetIntegerField('EquipmentServiceAppearDays')                ;end;
procedure TPersonalPreferencesDeleted.SetEquipmentServiceAppearDays              (const Value: Integer   ); begin SetIntegerField('EquipmentServiceAppearDays'                 , Value);end;
function  TPersonalPreferencesDeleted.GetERPLicenseRenewalAppearDays             : Integer   ; begin Result := GetIntegerField('ERPLicenseRenewalAppearDays')                ;end;
procedure TPersonalPreferencesDeleted.SetERPLicenseRenewalAppearDays             (const Value: Integer   ); begin SetIntegerField('ERPLicenseRenewalAppearDays'                 , Value);end;
function  TPersonalPreferencesDeleted.GetShowNewInstallDoc                       : Boolean   ; begin Result := GetBooleanField('ShowNewInstallDoc')                         ;end;
procedure TPersonalPreferencesDeleted.SetShowNewInstallDoc                       (const Value: Boolean   ); begin SetBooleanField('ShowNewInstallDoc'                          , Value);end;
function  TPersonalPreferencesDeleted.GetShowMarketingContactInGlobalList        : Boolean   ; begin Result := GetBooleanField('ShowMarketingContactInGlobalList')          ;end;
procedure TPersonalPreferencesDeleted.SetShowMarketingContactInGlobalList        (const Value: Boolean   ); begin SetBooleanField('ShowMarketingContactInGlobalList'           , Value);end;
(*function  TPersonalPreferencesDeleted.GetPAYGExpenseAccountID                    : integer   ; begin result := GetIntegerField('PAYGExpenseAccountID')                      ;end;*)
(*procedure TPersonalPreferencesDeleted.SetPAYGExpenseAccountID                    (const Value: integer   ); begin SetIntegerField('PAYGExpenseAccountID'                       , Value);end;*)
{TColumnHeadingsDeleted}
procedure    TColumnHeadingsDeleted.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ComField1Name');
  SetPropertyFromNode(node,'ComField2Name');
  SetPropertyFromNode(node,'ComField3Name');
  SetPropertyFromNode(node,'ComField4Name');
  SetPropertyFromNode(node,'CommAgg1');
  SetPropertyFromNode(node,'CommAgg2');
  SetPropertyFromNode(node,'CommAgg3');
  SetPropertyFromNode(node,'CommAgg4');

end;
procedure    TColumnHeadingsDeleted.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ComField1Name' ,ComField1Name);
  AddXMLNode(node,'ComField2Name' ,ComField2Name);
  AddXMLNode(node,'ComField3Name' ,ComField3Name);
  AddXMLNode(node,'ComField4Name' ,ComField4Name);
  AddXMLNode(node,'CommAgg1' ,CommAgg1);
  AddXMLNode(node,'CommAgg2' ,CommAgg2);
  AddXMLNode(node,'CommAgg3' ,CommAgg3);
  AddXMLNode(node,'CommAgg4' ,CommAgg4);
end;
function  TColumnHeadingsDeleted.GetComField1Name          : string    ; begin Result := GetStringField('ComField1Name');end;
function  TColumnHeadingsDeleted.GetComField2Name          : string    ; begin Result := GetStringField('ComField2Name');end;
function  TColumnHeadingsDeleted.GetComField3Name          : string    ; begin Result := GetStringField('ComField3Name');end;
function  TColumnHeadingsDeleted.GetComField4Name          : string    ; begin Result := GetStringField('ComField4Name');end;
function  TColumnHeadingsDeleted.GetCommAgg1               : String    ; begin Result := GetStringField('CommAgg1');end;
function  TColumnHeadingsDeleted.GetCommAgg2               : String    ; begin Result := GetStringField('CommAgg2');end;
function  TColumnHeadingsDeleted.GetCommAgg3               : String    ; begin Result := GetStringField('CommAgg3');end;
function  TColumnHeadingsDeleted.GetCommAgg4               : String    ; begin Result := GetStringField('CommAgg4');end;
procedure TColumnHeadingsDeleted.SetComField1Name          (const Value: string    ); begin SetStringField('ComField1Name'    , Value);end;
procedure TColumnHeadingsDeleted.SetComField2Name          (const Value: string    ); begin SetStringField('ComField2Name'    , Value);end;
procedure TColumnHeadingsDeleted.SetComField3Name          (const Value: string    ); begin SetStringField('ComField3Name'    , Value);end;
procedure TColumnHeadingsDeleted.SetComField4Name          (const Value: string    ); begin SetStringField('ComField4Name'    , Value);end;
procedure TColumnHeadingsDeleted.SetCommAgg1               (const Value: String   ); begin SetStringField('CommAgg1'         , Value);end;
procedure TColumnHeadingsDeleted.SetCommAgg2               (const Value: String   ); begin SetStringField('CommAgg2'         , Value);end;
procedure TColumnHeadingsDeleted.SetCommAgg3               (const Value: String   ); begin SetStringField('CommAgg3'         , Value);end;
procedure TColumnHeadingsDeleted.SetCommAgg4               (const Value: String   ); begin SetStringField('CommAgg4'         , Value);end;

end.
