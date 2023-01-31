unit BusobjPersonalPreference;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  23/06/10  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TPersonalPreferences = class(TMSBusObj)
  private
    function GetEmployeeID                              : Integer   ;
    function GetAPPAppearDays                           : Integer   ;
    function GetToDoAppearDays                          : Integer   ;
    function GetPendingSOAppearDays                     : Integer   ;
    function GetOthContactAppearDays                    : Integer   ;
    function GetQuoteAppearDays                         : Integer   ;
    function GetMemTransAppearDays                      : Integer   ;
    function GetListDaysPast                            : Integer   ;
    function GetListDaysFuture                          : Integer   ;
    function GetUseWord                                 : Boolean   ;
    function GetCustomerLoyaltyAppearDays               : Integer   ;
    function GetContactLoyaltyAppearDays                : Integer   ;
    function GetEmployeeskillRenewalAppearDays          : Integer   ;
    function GetPOSAutoLoad                             : Boolean   ;
    function GetShowPrintDialog                         : Boolean   ;
    function GetShowPreview                             : Boolean   ;
    function GetListSelectionColour                     : string    ;
    function GetReceivedBOAppearDays                    : Integer   ;
    function GetPayrollAccess                           : Boolean   ;
    function GetUseSnapshotProductList                  : Boolean   ;
    function GetAutoApplyDeposits                       : Boolean   ;
    function GetNoQtyDrillDownOnSales                   : Boolean   ;
    function GetCloseOnPrint                            : Boolean   ;
    function GetProductClassWarning                     : Boolean   ;
    function GetUseClientAccountNoOnPayments            : Boolean   ;
    function GetOverrideAutoSmartOrders                 : Boolean   ;
    function GetImageScheme                             : string    ;
    function GetFixedAssetInsuranceExpiresAppearDays    : Integer   ;
    function GetFixedAssetWarrantyExpiresAppearDays     : Integer   ;
    function GetMarketingContactsAppearDays             : Integer   ;
    function GetActiveWindow                            : Integer   ;
    function GetReminderHideDays                        : Integer   ;
    function GetCalender24hr                            : Boolean   ;
    function GetPopRemindersToDo                        : Boolean   ;
    function GetShowERPTips                             : Boolean   ;
    function GetRunManufacturingUpdateBatch             : Boolean   ;
    function GetDefaultOrderinTransForms                : Boolean   ;
    function GetPopRemindersMFollowup                   : Boolean   ;
    function GetLeadsAppearDays                         : Integer   ;
    function getServiceLogAprearDays                    : Integer;
    function GetGoodToReceiveReminderDays               : Integer   ;
    function GetPopRemindersMessages                    : Boolean   ;
    function GetShowDeliveryDetailsformonDeldocketprint : Boolean   ;
    function GetShowManufacutresummarywhenchangedfromSl : Boolean   ;
    function GetShowImageOnMainBackGround               : Boolean   ;
    function GetShowPrintOptionsinTransforms            : Boolean   ;
    function GetHideMSgonEmployeeCalendar               : Boolean   ;
    function GetOpenTreeFromSalesOrder                  : Boolean   ;
    function GetCapacityplannerSelectionOptionBeforeLoad: Boolean   ;
    function GetManufacturePartSourceStockconfirm       : Boolean   ;
    function GetPreviewAllreport                        : Boolean   ;
    function GetShowVideoMenuAtStartup                  : Boolean   ;
    function GetShowOverduesalesReminders               : Boolean   ;
    function GetShowFinishedProgressBuildReminder       : Boolean   ;
    function GetShowRelatedProductSelectioninSale       : Boolean   ;
    function GetMaxDiscountPercentage                   : double    ;
    function GetMinMarkupPercentage                     : double    ;
    function GetMinimumMarginPercentage                 : double    ;
    function GetAllowanceLiabilityAccountID             : integer   ;
    function GetAllowancePaidAccountID                  : integer   ;
    function GetCommissionPaidAccountID                 : integer   ;
    function GetDeductionLiabilityAccountID             : integer   ;
    function GetDeductionsPaidAccountID                 : integer   ;
    function GetLeaveLiabilityAccountID                 : integer   ;
    function GetLeaveProvisionAccountID                 : integer   ;
    function GetLumpSumDPaidAccountID                   : integer   ;
    function GetNetWagesAccountID                       : integer   ;
    function GetPAYGTaxPayableAccountID                 : integer   ;
    function GetSundriesPaidAccountID                   : integer   ;
    function GetSuperPaidAccountID                      : integer   ;
    function GetSuperPayableAccountID                   : integer   ;
    function GetWageAccountID                           : integer   ;
    function GetWagesPaidAccountID                      : integer   ;
    Function getProductListType                         : String    ;
    Function GetShowProductListtypeSelection            : boolean   ;
    Function GetShowProductListtypeSelectionforExpress  : boolean   ;
    Function GetShowProductListtypeSelectionforDetails  : boolean   ;
    Function GetShowProductListtypeSelectionforQtyList  : boolean   ;
    Function getBOMSalesList                            : String;
    Function getStockanalysisReport                     : String;
    Function GetShowReportTablesMsg                     : boolean   ;
    function GetCustomerPriceLsitOption                 : integer   ;
    function GetShortListDaysPast                       : Integer   ;
    function GetShortListDaysFuture                     : Integer   ;
    function GetLongListDaysPast                        : Integer   ;
    function GetLongListDaysFuture                      : Integer   ;
    Function GetShowGrossWeightnQtyCalcMsg              : boolean   ;
    Function GetUseGradBackground                       : boolean   ;
    Function GetCalcnshowAvailaibityinCapacityPlanner   : boolean   ;
    Function getDefaultServiceProduct                   : String;
    Function GetShowSundayinApptCalendar                : boolean   ;
    Function GetShowMondayinApptCalendar                : boolean   ;
    Function GetShowTuesdayinApptCalendar               : boolean   ;
    Function GetShowWednesdayinApptCalendar             : boolean   ;
    Function GetShowThursdayinApptCalendar              : boolean   ;
    Function GetShowFridayinApptCalendar                : boolean   ;
    Function GetShowSaturdayinApptCalendar              : boolean   ;
    function GetMinimumChargeAppointmentTime            : Integer   ;

    procedure SetEmployeeID                              (const Value: Integer   );
    procedure SetAPPAppearDays                           (const Value: Integer   );
    procedure SetToDoAppearDays                          (const Value: Integer   );
    procedure SetPendingSOAppearDays                     (const Value: Integer   );
    procedure SetOthContactAppearDays                    (const Value: Integer   );
    procedure SetQuoteAppearDays                         (const Value: Integer   );
    procedure SetMemTransAppearDays                      (const Value: Integer   );
    procedure SetListDaysPast                            (const Value: Integer   );
    procedure SetListDaysFuture                          (const Value: Integer   );
    procedure SetUseWord                                 (const Value: Boolean   );
    procedure SetCustomerLoyaltyAppearDays               (const Value: Integer   );
    procedure SetContactLoyaltyAppearDays                (const Value: Integer   );
    procedure SetEmployeeskillRenewalAppearDays          (const Value: Integer   );
    procedure SetPOSAutoLoad                             (const Value: Boolean   );
    procedure SetShowPrintDialog                         (const Value: Boolean   );
    procedure SetShowPreview                             (const Value: Boolean   );
    procedure SetListSelectionColour                     (const Value: string    );
    procedure SetReceivedBOAppearDays                    (const Value: Integer   );
    procedure SetPayrollAccess                           (const Value: Boolean   );
    procedure SetUseSnapshotProductList                  (const Value: Boolean   );
    procedure SetAutoApplyDeposits                       (const Value: Boolean   );
    procedure SetNoQtyDrillDownOnSales                   (const Value: Boolean   );
    procedure SetCloseOnPrint                            (const Value: Boolean   );
    procedure SetProductClassWarning                     (const Value: Boolean   );
    procedure SetUseClientAccountNoOnPayments            (const Value: Boolean   );
    procedure SetOverrideAutoSmartOrders                 (const Value: Boolean   );
    procedure SetImageScheme                             (const Value: string    );
    procedure SetFixedAssetInsuranceExpiresAppearDays    (const Value: Integer   );
    procedure SetFixedAssetWarrantyExpiresAppearDays     (const Value: Integer   );
    procedure SetMarketingContactsAppearDays             (const Value: Integer   );
    procedure SetActiveWindow                            (const Value: Integer   );
    procedure SetReminderHideDays                        (const Value: Integer   );
    procedure SetCalender24hr                            (const Value: Boolean   );
    procedure SetPopRemindersToDo                        (const Value: Boolean   );
    procedure SetShowERPTips                             (const Value: Boolean   );
    procedure SetRunManufacturingUpdateBatch             (const Value: Boolean   );
    procedure SetDefaultOrderinTransForms                (const Value: Boolean   );
    procedure SetPopRemindersMFollowup                   (const Value: Boolean   );
    procedure SetLeadsAppearDays                         (const Value: Integer   );
    Procedure SetServiceLogAprearDays                    (Const Value: Integer   );
    procedure SetGoodToReceiveReminderDays               (const Value: Integer   );
    procedure SetPopRemindersMessages                    (const Value: Boolean   );
    procedure SetShowDeliveryDetailsformonDeldocketprint (const Value: Boolean   );
    procedure SetShowManufacutresummarywhenchangedfromSl (const Value: Boolean   );
    procedure SetHideMSgonEmployeeCalendar               (const Value: Boolean   );
    procedure SetShowImageOnMainBackGround               (const Value: Boolean   );
    procedure SetShowPrintOptionsinTransforms            (const Value: Boolean   );
    procedure SetOpenTreeFromSalesOrder                  (const Value: Boolean   );
    procedure SetCapacityplannerSelectionOptionBeforeLoad(const Value: Boolean   );
    procedure SetManufacturePartSourceStockconfirm       (const Value: Boolean   );
    procedure SetPreviewAllreport                        (const Value: Boolean   );
    procedure SetShowVideoMenuAtStartup                  (const Value: Boolean   );
    procedure SetShowOverduesalesReminders               (const Value: Boolean   );
    procedure SetShowFinishedProgressBuildReminder       (const Value: Boolean   );
    procedure SetShowRelatedProductSelectioninSale       (const Value: Boolean   );
    procedure SetMaxDiscountPercentage                   (const Value: double);
    procedure SetMinMarkupPercentage                     (const Value: double);
    procedure SetMinimumMarginPercentage                 (const Value: double);
    procedure SetAllowanceLiabilityAccountID             (const Value: integer);
    procedure SetAllowancePaidAccountID                  (const Value: integer);
    procedure SetCommissionPaidAccountID                 (const Value: integer);
    procedure SetDeductionLiabilityAccountID             (const Value: integer);
    procedure SetDeductionsPaidAccountID                 (const Value: integer);
    procedure SetLeaveLiabilityAccountID                 (const Value: integer);
    procedure SetLeaveProvisionAccountID                 (const Value: integer);
    procedure SetLumpSumDPaidAccountID                   (const Value: integer);
    procedure SetNetWagesAccountID                       (const Value: integer);
    procedure SetPAYGTaxPayableAccountID                 (const Value: integer);
    procedure SetSundriesPaidAccountID                   (const Value: integer);
    procedure SetSuperPaidAccountID                      (const Value: integer);
    procedure SetSuperPayableAccountID                   (const Value: integer);
    procedure SetWageAccountID                           (const Value: integer);
    procedure SetWagesPaidAccountID                      (const Value: integer);
    Procedure SetProductListType                         (Const Value: String );
    Procedure SetShowProductListtypeSelection            (Const Value: Boolean);
    Procedure SetShowProductListtypeSelectionforExpress  (Const Value: Boolean);
    Procedure SetShowProductListtypeSelectionforDetails  (Const Value: Boolean);
    Procedure SetShowProductListtypeSelectionforQtyList  (Const Value: Boolean);
    Procedure SetBOMSalesList                            (Const Value: String);
    Procedure SetStockanalysisReport                     (Const Value: String);
    Procedure SetShowReportTablesMsg                     (Const Value: Boolean);
    procedure SetCustomerPriceLsitOption                 (const Value: integer);
    procedure SetShortListDaysPast                       (const Value: Integer   );
    procedure SetShortListDaysFuture                     (const Value: Integer   );
    procedure SetLongListDaysPast                        (const Value: Integer   );
    procedure SetLongListDaysFuture                      (const Value: Integer   );
    Procedure SetShowGrossWeightnQtyCalcMsg              (Const Value: Boolean);
    Procedure SetUseGradBackground                       (Const Value: Boolean);
    Procedure SetCalcnshowAvailaibityinCapacityPlanner   (Const Value: Boolean);
    Procedure SetApptStartTime                           (Const Value: String);
    Procedure SetApptEndtime                             (Const Value: String);
    procedure SetDefaultApptDuration                     (const Value: Integer);
    procedure SetRoundApptDurationTo                     (const Value: Integer);
    procedure SetShowApptDurationin                      (const Value: Integer);
    procedure SetDefaultServiceProductID                 (const Value: Integer);
    Procedure SetDefaultServiceProduct                   (Const Value: String);
    Procedure SetShowSundayinApptCalendar                (Const Value: Boolean);
    Procedure SetShowMondayinApptCalendar                (Const Value: Boolean);
    Procedure SetShowTuesdayinApptCalendar               (Const Value: Boolean);
    Procedure SetShowWednesdayinApptCalendar             (Const Value: Boolean);
    Procedure SetShowThursdayinApptCalendar              (Const Value: Boolean);
    Procedure SetShowFridayinApptCalendar                (Const Value: Boolean);
    Procedure SetShowSaturdayinApptCalendar              (Const Value: Boolean);
    procedure SetMinimumChargeAppointmentTime            (const Value: Integer);

    function GetShowReorder: boolean;
    procedure SetShowReorder(const Value: boolean);
    function GetPasswordNeverExpires: boolean;
    procedure SetPasswordNeverExpires(const Value: boolean);
    function GetCanChangePassword: boolean;
    procedure SetCanChangePassword(const Value: boolean);

    function GetUseAlternatingRowColor: boolean;
    function GetColourAlternatingRow                    : Integer   ;
    function GetGradIntensityAlternatingRow             : Integer   ;
    function GetUseERPSingleColor: boolean;
    function GetColourERPSingle                    : Integer   ;
    function GetGradIntensityERPSingle             : Integer   ;
    function GetUseERPButtonColor: boolean;
    function GetColourERPButton                    : Integer   ;
    function GetGradIntensityERPButton             : Integer   ;
    function GetColourERPButtonFont                : Integer   ;
    function GetGradIntensityERPButtonFont         : Integer   ;
    function GetColourERPButtonHT                  : Integer   ;
    function GetGradIntensityERPButtonHT           : Integer   ;

    procedure SetUseAlternatingRowColor(const Value: boolean);
    procedure SetColourAlternatingRow                    (const Value: Integer   );
    procedure SetGradIntensityAlternatingRow             (const Value: Integer   );
    procedure SetUseERPSingleColor(const Value: boolean);
    procedure SetColourERPSingle                    (const Value: Integer   );
    procedure SetGradIntensityERPSingle             (const Value: Integer   );
    procedure SetUseERPButtonColor(const Value: boolean);
    procedure SetColourERPButton                    (const Value: Integer   );
    procedure SetGradIntensityERPButton             (const Value: Integer   );
    procedure SetColourERPButtonFont                (const Value: Integer   );
    procedure SetGradIntensityERPButtonFont         (const Value: Integer   );
    procedure SetColourERPButtonHT                  (const Value: Integer   );
    procedure SetGradIntensityERPButtonHT           (const Value: Integer   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function  DoBeforeInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function getApptStartTime                           : String    ;Virtual;
    Function getApptEndtime                             : String    ;Virtual;
    function GetDefaultApptDuration                     : Integer   ;Virtual;
    function GetRoundApptDurationTo                     : Integer   ;Virtual;
    function GetShowApptDurationin                      : Integer   ;Virtual;
    function GetDefaultServiceProductID                 : Integer   ;Virtual;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    class function PropAsBool(aEmployeeID: integer; PropName: string): boolean;
    class function UserPasswordNeverExpires( const aLogonName, aServer, aDatabase: string): boolean;
    class function UserCanChangePassword( const aLogonName, aServer, aDatabase: string): boolean;
  published
    property EmployeeID                                 :Integer     read GetEmployeeID                               write SetEmployeeID                          ;
    property APPAppearDays                              :Integer     read GetAPPAppearDays                            write SetAPPAppearDays                       ;
    property ToDoAppearDays                             :Integer     read GetToDoAppearDays                           write SetToDoAppearDays                      ;
    property PendingSOAppearDays                        :Integer     read GetPendingSOAppearDays                      write SetPendingSOAppearDays                 ;
    property OthContactAppearDays                       :Integer     read GetOthContactAppearDays                     write SetOthContactAppearDays                ;
    property QuoteAppearDays                            :Integer     read GetQuoteAppearDays                          write SetQuoteAppearDays                     ;
    property MemTransAppearDays                         :Integer     read GetMemTransAppearDays                       write SetMemTransAppearDays                  ;
    property ListDaysPast                               :Integer     read GetListDaysPast                             write SetListDaysPast                        ;
    property ListDaysFuture                             :Integer     read GetListDaysFuture                           write SetListDaysFuture                      ;
    property UseWord                                    :Boolean     read GetUseWord                                  write SetUseWord                             ;
    property CustomerLoyaltyAppearDays                  :Integer     read GetCustomerLoyaltyAppearDays                write SetCustomerLoyaltyAppearDays           ;
    property ContactLoyaltyAppearDays                   :Integer     read GetContactLoyaltyAppearDays                 write SetContactLoyaltyAppearDays            ;
    property EmployeeskillRenewalAppearDays             :Integer     read GetEmployeeskillRenewalAppearDays           write SetEmployeeskillRenewalAppearDays      ;
    property POSAutoLoad                                :Boolean     read GetPOSAutoLoad                              write SetPOSAutoLoad                         ;
    property ShowPrintDialog                            :Boolean     read GetShowPrintDialog                          write SetShowPrintDialog                     ;
    property ShowPreview                                :Boolean     read GetShowPreview                              write SetShowPreview                         ;
    property ListSelectionColour                        :string      read GetListSelectionColour                      write SetListSelectionColour                 ;
    property ReceivedBOAppearDays                       :Integer     read GetReceivedBOAppearDays                     write SetReceivedBOAppearDays                ;
    property PayrollAccess                              :Boolean     read GetPayrollAccess                            write SetPayrollAccess                       ;
    property UseSnapshotProductList                     :Boolean     read GetUseSnapshotProductList                   write SetUseSnapshotProductList              ;
    property AutoApplyDeposits                          :Boolean     read GetAutoApplyDeposits                        write SetAutoApplyDeposits                   ;
    property NoQtyDrillDownOnSales                      :Boolean     read GetNoQtyDrillDownOnSales                    write SetNoQtyDrillDownOnSales               ;
    property CloseOnPrint                               :Boolean     read GetCloseOnPrint                             write SetCloseOnPrint                        ;
    property ProductClassWarning                        :Boolean     read GetProductClassWarning                      write SetProductClassWarning                 ;
    property UseClientAccountNoOnPayments               :Boolean     read GetUseClientAccountNoOnPayments             write SetUseClientAccountNoOnPayments        ;
    property OverrideAutoSmartOrders                    :Boolean     read GetOverrideAutoSmartOrders                  write SetOverrideAutoSmartOrders             ;
    property ImageScheme                                :string      read GetImageScheme                              write SetImageScheme                         ;
    property FixedAssetInsuranceExpiresAppearDays       :Integer     read GetFixedAssetInsuranceExpiresAppearDays     write SetFixedAssetInsuranceExpiresAppearDays;
    property FixedAssetWarrantyExpiresAppearDays        :Integer     read GetFixedAssetWarrantyExpiresAppearDays      write SetFixedAssetWarrantyExpiresAppearDays ;
    property MarketingContactsAppearDays                :Integer     read GetMarketingContactsAppearDays              write SetMarketingContactsAppearDays         ;
    property ActiveWindow                               :Integer     read GetActiveWindow                             write SetActiveWindow                        ;
    property ReminderHideDays                           :Integer     read GetReminderHideDays                         write SetReminderHideDays                    ;
    property Calender24hr                               :Boolean     read GetCalender24hr                             write SetCalender24hr                        ;
    property PopRemindersToDo                           :Boolean     read GetPopRemindersToDo                         write SetPopRemindersToDo                    ;
    property ShowERPTips                                :Boolean     read GetShowERPTips                              write SetShowERPTips                         ;
    property RunManufacturingUpdateBatch                :Boolean     read GetRunManufacturingUpdateBatch              write SetRunManufacturingUpdateBatch         ;
    property DefaultOrderinTransForms                   :Boolean     read GetDefaultOrderinTransForms                 write SetDefaultOrderinTransForms            ;
    property PopRemindersMFollowup                      :Boolean     read GetPopRemindersMFollowup                    write SetPopRemindersMFollowup               ;
    property LeadsAppearDays                            :Integer     read GetLeadsAppearDays                          write SetLeadsAppearDays                     ;
    Property ServiceLogAprearDays                       :Integer     read getServiceLogAprearDays                     write setServiceLogAprearDays                ;
    property GoodToReceiveReminderDays                  :Integer     read GetGoodToReceiveReminderDays                write SetGoodToReceiveReminderDays           ;
    property PopRemindersMessages                       :Boolean     read GetPopRemindersMessages                     write SetPopRemindersMessages                ;
    property ShowDeliveryDetailsformonDeldocketprint    :Boolean     read GetShowDeliveryDetailsformonDeldocketprint  write SetShowDeliveryDetailsformonDeldocketprint  ;
    property ShowManufacutresummarywhenchangedfromSales :Boolean     read GetShowManufacutresummarywhenchangedfromSl  write SetShowManufacutresummarywhenchangedfromSl  ;
    property HideMSgonEmployeeCalendar                  :Boolean     read GetHideMSgonEmployeeCalendar                write SetHideMSgonEmployeeCalendar  ;
    property ShowImageOnMainBackGround                  :Boolean     read GetShowImageOnMainBackGround                write SetShowImageOnMainBackGround  ;
    property ShowPrintOptionsinTransforms               :Boolean     read GetShowPrintOptionsinTransforms             write SetShowPrintOptionsinTransforms  ;
    property OpenTreeFromSalesOrder                     :Boolean     read GetOpenTreeFromSalesOrder                   write SetOpenTreeFromSalesOrder    ;
    property CapacityplannerSelectionOptionBeforeLoad   :Boolean     read GetCapacityplannerSelectionOptionBeforeLoad write SetCapacityplannerSelectionOptionBeforeLoad    ;
    property ManufacturePartSourceStockconfirm          :Boolean     read GetManufacturePartSourceStockconfirm        write SetManufacturePartSourceStockconfirm    ;
    property PreviewAllreport                           :Boolean     read GetPreviewAllreport                         write SetPreviewAllreport                    ;
    property ShowVideoMenuAtStartup                     :Boolean     read GetShowVideoMenuAtStartup                   write SetShowVideoMenuAtStartup              ;
    property MaxDiscountPercentage                      :double      read GetMaxDiscountPercentage                    write SetMaxDiscountPercentage;
    property MinMarkupPercentage                        :double      read GetMinMarkupPercentage                      write SetMinMarkupPercentage;
    property MinimumMarginPercentage                    :double      read GetMinimumMarginPercentage                  write SetMinimumMarginPercentage;
    property ShowOverduesalesReminders                  :Boolean     read GetShowOverduesalesReminders                write SetShowOverduesalesReminders            ;
    property ShowFinishedProgressBuildReminder          :Boolean     read GetShowFinishedProgressBuildReminder        write SetShowFinishedProgressBuildReminder    ;
    property ShowRelatedProductSelectioninSale          :Boolean     read GetShowRelatedProductSelectioninSale        write SetShowRelatedProductSelectioninSale    ;
    property WageAccountID                              :integer     read GetWageAccountID                            write SetWageAccountID;
    property WagesPaidAccountID                         :integer     read GetWagesPaidAccountID                       write SetWagesPaidAccountID;
    property DeductionsPaidAccountID                    :integer     read GetDeductionsPaidAccountID                  write SetDeductionsPaidAccountID;
    property LeaveProvisionAccountID                    :integer     read GetLeaveProvisionAccountID                  write SetLeaveProvisionAccountID;
    property NetWagesAccountID                          :integer     read GetNetWagesAccountID                        write SetNetWagesAccountID;
    property AllowancePaidAccountID                     :integer     read GetAllowancePaidAccountID                   write SetAllowancePaidAccountID;
    property SuperPaidAccountID                         :integer     read GetSuperPaidAccountID                       write SetSuperPaidAccountID;
    property SundriesPaidAccountID                      :integer     read GetSundriesPaidAccountID                    write SetSundriesPaidAccountID;
    property CommissionPaidAccountID                    :integer     read GetCommissionPaidAccountID                  write SetCommissionPaidAccountID;
    property DeductionLiabilityAccountID                :integer     read GetDeductionLiabilityAccountID              write SetDeductionLiabilityAccountID;
    property SuperPayableAccountID                      :integer     read GetSuperPayableAccountID                    write SetSuperPayableAccountID;
    property AllowanceLiabilityAccountID                :integer     read GetAllowanceLiabilityAccountID              write SetAllowanceLiabilityAccountID;
    property LeaveLiabilityAccountID                    :integer     read GetLeaveLiabilityAccountID                  write SetLeaveLiabilityAccountID;
    property PAYGTaxPayableAccountID                    :integer     read GetPAYGTaxPayableAccountID                  write SetPAYGTaxPayableAccountID;
    property LumpSumDPaidAccountID                      :integer     read GetLumpSumDPaidAccountID                    write SetLumpSumDPaidAccountID;
    property ShowReorder                                :boolean     read GetShowReorder                              write SetShowReorder;
    Property ProductListType                            :String      read getProductListType                          write setProductListType;
    Property ShowProductListtypeSelection               :Boolean     Read getShowProductListtypeSelection             Write SetShowProductListtypeSelection;
    Property ShowProductListtypeSelectionforExpress     :Boolean     Read getShowProductListtypeSelectionforExpress   Write SetShowProductListtypeSelectionforExpress;
    Property ShowProductListtypeSelectionforDetails     :Boolean     Read getShowProductListtypeSelectionforDetails   Write SetShowProductListtypeSelectionforDetails;
    Property ShowProductListtypeSelectionforQtyList     :Boolean     Read getShowProductListtypeSelectionforQtyList   Write SetShowProductListtypeSelectionforQtyList;
    Property ShowReportTablesMsg                        :Boolean     Read getShowReportTablesMsg                      Write SetShowReportTablesMsg;
    Property BOMSalesList                               :String      Read getBOMSalesList                             Write SetBOMSalesList;
    Property StockanalysisReport                        :String      Read getStockanalysisReport                      Write SetStockanalysisReport;
    property CustomerPriceLsitOption                    :integer     read GetCustomerPriceLsitOption                  write SetCustomerPriceLsitOption;
    property ShortListDaysPast                          :Integer     read GetShortListDaysPast                        write SetShortListDaysPast;
    property ShortListDaysFuture                        :Integer     read GetShortListDaysFuture                      write SetShortListDaysFuture;
    property LongListDaysPast                           :Integer     read GetLongListDaysPast                         write SetLongListDaysPast;
    property LongListDaysFuture                         :Integer     read GetLongListDaysFuture                       write SetLongListDaysFuture;
    property PasswordNeverExpires                       :boolean     read GetPasswordNeverExpires                     write SetPasswordNeverExpires;
    property CanChangePassword                          :boolean     read GetCanChangePassword                        write SetCanChangePassword;
    property UseAlternatingRowColor                     :boolean     read GetUseAlternatingRowColor                   write SetUseAlternatingRowColor;
    property ColourAlternatingRow                       :Integer     read GetColourAlternatingRow                     write SetColourAlternatingRow;
    property GradIntensityAlternatingRow                :Integer     read GetGradIntensityAlternatingRow              write SetGradIntensityAlternatingRow;
    property UseERPSingleColor                          :boolean     read GetUseERPSingleColor                        write SetUseERPSingleColor;
    property ColourERPSingle                            :Integer     read GetColourERPSingle                          write SetColourERPSingle;
    property GradIntensityERPSingle                     :Integer     read GetGradIntensityERPSingle                   write SetGradIntensityERPSingle;
    property UseERPButtonColor                          :boolean     read GetUseERPButtonColor                        write SetUseERPButtonColor;
    property ColourERPButton                            :Integer     read GetColourERPButton                          write SetColourERPButton;
    property GradIntensityERPButton                     :Integer     read GetGradIntensityERPButton                   write SetGradIntensityERPButton;
    property ColourERPButtonFont                        :Integer     read GetColourERPButtonFont                      write SetColourERPButtonFont;
    property GradIntensityERPButtonFont                 :Integer     read GetGradIntensityERPButtonFont               write SetGradIntensityERPButtonFont;
    property ColourERPButtonHT                          :Integer     read GetColourERPButtonHT                        write SetColourERPButtonHT;
    property GradIntensityERPButtonHT                   :Integer     read GetGradIntensityERPButtonHT                 write SetGradIntensityERPButtonHT;
    Property ShowGrossWeightnQtyCalcMsg                 :Boolean     Read getShowGrossWeightnQtyCalcMsg               Write SetShowGrossWeightnQtyCalcMsg;
    Property UseGradBackground                          :Boolean     Read getUseGradBackground                        Write SetUseGradBackground;
    Property CalcnshowAvailaibityinCapacityPlanner      :Boolean     Read getCalcnshowAvailaibityinCapacityPlanner    Write SetCalcnshowAvailaibityinCapacityPlanner;
    Property ApptStartTime                              :String      Read getApptStartTime                            Write SetApptStartTime;
    Property ApptEndtime                                :String      Read getApptEndtime                              Write SetApptEndtime;
    property DefaultApptDuration                        :Integer     read GetDefaultApptDuration                      write SetDefaultApptDuration;
    property RoundApptDurationTo                        :Integer     read GetRoundApptDurationTo                      write SetRoundApptDurationTo;
    property ShowApptDurationin                         :Integer     read GetShowApptDurationin                       write SetShowApptDurationin;
    property DefaultServiceProductID                    :Integer     read GetDefaultServiceProductID                  write SetDefaultServiceProductID;
    Property DefaultServiceProduct                      :String      Read getDefaultServiceProduct                    Write SetDefaultServiceProduct;

    Property ShowSundayinApptCalendar                   :Boolean     Read getShowSundayinApptCalendar                 Write SetShowSundayinApptCalendar;
    Property ShowMondayinApptCalendar                   :Boolean     Read getShowMondayinApptCalendar                 Write SetShowMondayinApptCalendar;
    Property ShowTuesdayinApptCalendar                  :Boolean     Read getShowTuesdayinApptCalendar                Write SetShowTuesdayinApptCalendar;
    Property ShowWednesdayinApptCalendar                :Boolean     Read getShowWednesdayinApptCalendar              Write SetShowWednesdayinApptCalendar;
    Property ShowThursdayinApptCalendar                 :Boolean     Read getShowThursdayinApptCalendar               Write SetShowThursdayinApptCalendar;
    Property ShowFridayinApptCalendar                   :Boolean     Read getShowFridayinApptCalendar                 Write SetShowFridayinApptCalendar;
    Property ShowSaturdayinApptCalendar                 :Boolean     Read getShowSaturdayinApptCalendar               Write SetShowSaturdayinApptCalendar;

    property MinimumChargeAppointmentTime               :Integer     read GetMinimumChargeAppointmentTime             write SetDefaultServiceProductID;
  end;
  TAppointmentPreferences = class(TPersonalPreferences)
  Private
  Protected
    Function getApptStartTime           : String    ;Override;
    Function getApptEndtime             : String    ;Override;
    function GetDefaultApptDuration     : Integer   ;Override;
    function GetRoundApptDurationTo     : Integer   ;Override;
    function GetShowApptDurationin      : Integer   ;Override;
    function GetDefaultServiceProductID : Integer   ;Override;
  Public
    constructor  Create(AOwner: TComponent);                            override;
  Published
  end;

implementation


uses
  tcDataUtils, CommonLib, SysUtils, TypInfo, ERPDbComponents, DBUtils, tcConst,
  AppEnvironment, BusObjStock;



  {TPersonalPreferences}

constructor TPersonalPreferences.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'PersonalPreferences';
  fSQL := 'SELECT * FROM tblpersonalpreferences';
end;


destructor TPersonalPreferences.Destroy;
begin
  inherited;
end;


procedure TPersonalPreferences.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'APPAppearDays');
  SetPropertyFromNode(node,'ToDoAppearDays');
  SetPropertyFromNode(node,'PendingSOAppearDays');
  SetPropertyFromNode(node,'OthContactAppearDays');
  SetPropertyFromNode(node,'QuoteAppearDays');
  SetPropertyFromNode(node,'MemTransAppearDays');
  SetPropertyFromNode(node,'ListDaysPast');
  SetPropertyFromNode(node,'ListDaysFuture');
  SetBooleanPropertyFromNode(node,'UseWord');
  SetPropertyFromNode(node,'CustomerLoyaltyAppearDays');
  SetPropertyFromNode(node,'ContactLoyaltyAppearDays');
  SetPropertyFromNode(node,'EmployeeskillRenewalAppearDays');
  SetBooleanPropertyFromNode(node,'POSAutoLoad');
  SetBooleanPropertyFromNode(node,'ShowPrintDialog');
  SetBooleanPropertyFromNode(node,'ShowPreview');
  SetPropertyFromNode(node,'ListSelectionColour');
  SetPropertyFromNode(node,'ReceivedBOAppearDays');
  SetBooleanPropertyFromNode(node,'PayrollAccess');
  SetBooleanPropertyFromNode(node,'UseSnapshotProductList');
  SetBooleanPropertyFromNode(node,'AutoApplyDeposits');
  SetBooleanPropertyFromNode(node,'NoQtyDrillDownOnSales');
  SetBooleanPropertyFromNode(node,'CloseOnPrint');
  SetBooleanPropertyFromNode(node,'ProductClassWarning');
  SetBooleanPropertyFromNode(node,'UseClientAccountNoOnPayments');
  SetBooleanPropertyFromNode(node,'OverrideAutoSmartOrders');
  SetPropertyFromNode(node,'ImageScheme');
  SetPropertyFromNode(node,'FixedAssetInsuranceExpiresAppearDays');
  SetPropertyFromNode(node,'FixedAssetWarrantyExpiresAppearDays');
  SetPropertyFromNode(node,'MarketingContactsAppearDays');
  SetPropertyFromNode(node,'ActiveWindow');
  SetPropertyFromNode(node,'ReminderHideDays');
  SetBooleanPropertyFromNode(node,'Calender24hr');
  SetBooleanPropertyFromNode(node,'PopRemindersToDo');
  SetBooleanPropertyFromNode(node,'ShowERPTips');
  SetBooleanPropertyFromNode(node,'RunManufacturingUpdateBatch');
  SetBooleanPropertyFromNode(node,'DefaultOrderinTransForms');
  SetBooleanPropertyFromNode(node,'PopRemindersMFollowup');
  SetPropertyFromNode(node,'LeadsAppearDays');
  SetPropertyFromNode(node,'ServiceLogAprearDays');
  SetPropertyFromNode(node,'GoodToReceiveReminderDays');
  SetBooleanPropertyFromNode(node,'PopRemindersMessages');
  SetBooleanPropertyFromNode(node,'ShowDeliveryDetailsformonDeldocketprint');
  SetBooleanPropertyFromNode(node,'ShowManufacutresummarywhenchangedfromSales');
  SetBooleanPropertyFromNode(node,'HideMSgonEmployeeCalendar');
  SetBooleanPropertyFromNode(node,'ShowImageOnMainBackGround');
  SetBooleanPropertyFromNode(node,'ShowPrintOptionsinTransforms');
  SetBooleanPropertyFromNode(node,'OpenTreeFromSalesOrder');
  SetBooleanPropertyFromNode(node,'CapacityplannerSelectionOptionBeforeLoad');
  SetBooleanPropertyFromNode(node,'ManufacturePartSourceStockconfirm');
  SetPropertyFromNode(node,'VideoUseInternet');
  SetPropertyFromNode(node,'VideoLocalDir');
  SetBooleanPropertyFromNode(node,'PreviewAllreport');
  SetBooleanPropertyFromNode(node,'ShowVideoMenuAtStartup');
  SetBooleanPropertyFromNode(node,'ShowOverduesalesReminders');
  SetBooleanPropertyFromNode(node,'ShowFinishedProgressBuildReminder');
  SetBooleanPropertyFromNode(node,'ShowRelatedProductSelectioninSale');
  SetPropertyFromNode(node,'WageAccountID');
  SetPropertyFromNode(node,'WagesPaidAccountID');
  SetPropertyFromNode(node,'CustomerPriceLsitOption');
  SetPropertyFromNode(node,'DeductionsPaidAccountID');
  SetPropertyFromNode(node,'LeaveProvisionAccountID');
  SetPropertyFromNode(node,'NetWagesAccountID');
  SetPropertyFromNode(node,'AllowancePaidAccountID');
  SetPropertyFromNode(node,'SuperPaidAccountID');
  SetPropertyFromNode(node,'SundriesPaidAccountID');
  SetPropertyFromNode(node,'CommissionPaidAccountID');
  SetPropertyFromNode(node,'DeductionLiabilityAccountID');
  SetPropertyFromNode(node,'SuperPayableAccountID');
  SetPropertyFromNode(node,'AllowanceLiabilityAccountID');
  SetPropertyFromNode(node,'LeaveLiabilityAccountID');
  SetPropertyFromNode(node,'PAYGTaxPayableAccountID');
  SetPropertyFromNode(node,'LumpSumDPaidAccountID');
  SetBooleanPropertyFromNode(node,'ShowReorder');
  SetPropertyFromNode(node,'ProductListType');
  SetBooleanPropertyFromNode(node,'ShowProductListtypeSelection');
  SetBooleanPropertyFromNode(node,'ShowProductListtypeSelectionforExpress');
  SetBooleanPropertyFromNode(node,'ShowProductListtypeSelectionforDetails');
  SetBooleanPropertyFromNode(node,'ShowProductListtypeSelectionforQtyList');
  SetPropertyFromNode(node,'BOMSalesList');
  SetPropertyFromNode(node,'StockanalysisReport');
  SetBooleanPropertyFromNode(node,'ShowReportTablesMsg');
  SetPropertyFromNode(node,'ShortListDaysPast');
  SetPropertyFromNode(node,'ShortListDaysFuture');
  SetPropertyFromNode(node,'LongListDaysPast');
  SetPropertyFromNode(node,'LongListDaysFuture');

  SetBooleanPropertyFromNode(node,'UseAlternatingRowColor');
  SetPropertyFromNode(node,'ColourAlternatingRow');
  SetPropertyFromNode(node,'GradIntensityAlternatingRow');
  SetBooleanPropertyFromNode(node,'UseERPSingleColor');
  SetPropertyFromNode(node,'ColourERPSingle');
  SetPropertyFromNode(node,'GradIntensityERPSingle');
  SetBooleanPropertyFromNode(node,'UseERPButtonColor');
  SetPropertyFromNode(node,'ColourERPButton');
  SetPropertyFromNode(node,'GradIntensityERPButton');
  SetPropertyFromNode(node,'ColourERPButtonFont');
  SetPropertyFromNode(node,'GradIntensityERPButtonFont');
  SetPropertyFromNode(node,'ColourERPButtonHT');
  SetPropertyFromNode(node,'GradIntensityERPButtonHT');
  SetBooleanPropertyFromNode(node,'ShowGrossWeightnQtyCalcMsg');
  SetBooleanPropertyFromNode(node,'UseGradBackground');
  SetBooleanPropertyFromNode(node,'CalcnshowAvailaibityinCapacityPlanner');
  SetPropertyFromNode(node,'ApptStartTime');
  SetPropertyFromNode(node,'ApptEndtime');
  SetPropertyFromNode(node,'DefaultApptDuration');
  SetPropertyFromNode(node,'RoundApptDurationTo');
  SetPropertyFromNode(node,'ShowApptDurationin');
  SetPropertyFromNode(node,'DefaultServiceProductID');
  SetPropertyFromNode(node,'DefaultServiceProduct');
  SetBooleanPropertyFromNode(node,'ShowSundayinApptCalendar');
  SetBooleanPropertyFromNode(node,'ShowMondayinApptCalendar');
  SetBooleanPropertyFromNode(node,'ShowTuesdayinApptCalendar');
  SetBooleanPropertyFromNode(node,'ShowWednesdayinApptCalendar');
  SetBooleanPropertyFromNode(node,'ShowThursdayinApptCalendar');
  SetBooleanPropertyFromNode(node,'ShowFridayinApptCalendar');
  SetBooleanPropertyFromNode(node,'ShowSaturdayinApptCalendar');
  SetPropertyFromNode(node,'MinimumChargeAppointmentTime');
end;


procedure TPersonalPreferences.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'APPAppearDays' ,APPAppearDays);
  AddXMLNode(node,'ToDoAppearDays' ,ToDoAppearDays);
  AddXMLNode(node,'PendingSOAppearDays' ,PendingSOAppearDays);
  AddXMLNode(node,'OthContactAppearDays' ,OthContactAppearDays);
  AddXMLNode(node,'QuoteAppearDays' ,QuoteAppearDays);
  AddXMLNode(node,'MemTransAppearDays' ,MemTransAppearDays);
  AddXMLNode(node,'ListDaysPast' ,ListDaysPast);
  AddXMLNode(node,'ListDaysFuture' ,ListDaysFuture);
  AddXMLNode(node,'UseWord' ,UseWord);
  AddXMLNode(node,'CustomerLoyaltyAppearDays' ,CustomerLoyaltyAppearDays);
  AddXMLNode(node,'ContactLoyaltyAppearDays' ,ContactLoyaltyAppearDays);
  AddXMLNode(node,'EmployeeskillRenewalAppearDays' ,EmployeeskillRenewalAppearDays);
  AddXMLNode(node,'POSAutoLoad' ,POSAutoLoad);
  AddXMLNode(node,'ShowPrintDialog' ,ShowPrintDialog);
  AddXMLNode(node,'ShowPreview' ,ShowPreview);
  AddXMLNode(node,'ListSelectionColour' ,ListSelectionColour);
  AddXMLNode(node,'ReceivedBOAppearDays' ,ReceivedBOAppearDays);
  AddXMLNode(node,'PayrollAccess' ,PayrollAccess);
  AddXMLNode(node,'UseSnapshotProductList' ,UseSnapshotProductList);
  AddXMLNode(node,'AutoApplyDeposits' ,AutoApplyDeposits);
  AddXMLNode(node,'NoQtyDrillDownOnSales' ,NoQtyDrillDownOnSales);
  AddXMLNode(node,'CloseOnPrint' ,CloseOnPrint);
  AddXMLNode(node,'ProductClassWarning' ,ProductClassWarning);
  AddXMLNode(node,'UseClientAccountNoOnPayments' ,UseClientAccountNoOnPayments);
  AddXMLNode(node,'OverrideAutoSmartOrders' ,OverrideAutoSmartOrders);
  AddXMLNode(node,'ImageScheme' ,ImageScheme);
  AddXMLNode(node,'FixedAssetInsuranceExpiresAppearDays' ,FixedAssetInsuranceExpiresAppearDays);
  AddXMLNode(node,'FixedAssetWarrantyExpiresAppearDays' ,FixedAssetWarrantyExpiresAppearDays);
  AddXMLNode(node,'MarketingContactsAppearDays' ,MarketingContactsAppearDays);
  AddXMLNode(node,'ActiveWindow' ,ActiveWindow);
  AddXMLNode(node,'ReminderHideDays' ,ReminderHideDays);
  AddXMLNode(node,'Calender24hr' ,Calender24hr);
  AddXMLNode(node,'PopRemindersToDo' ,PopRemindersToDo);
  AddXMLNode(node,'ShowERPTips' ,ShowERPTips);
  AddXMLNode(node,'RunManufacturingUpdateBatch' ,RunManufacturingUpdateBatch);
  AddXMLNode(node,'DefaultOrderinTransForms' ,DefaultOrderinTransForms);
  AddXMLNode(node,'PopRemindersMFollowup' ,PopRemindersMFollowup);
  AddXMLNode(node,'LeadsAppearDays' ,LeadsAppearDays);
  AddXMLNode(node,'ServiceLogAprearDays' ,ServiceLogAprearDays);
  AddXMLNode(node,'GoodToReceiveReminderDays' ,GoodToReceiveReminderDays);
  AddXMLNode(node,'PopRemindersMessages' ,PopRemindersMessages);
  AddXMLNode(node,'ShowDeliveryDetailsformonDeldocketprint' ,ShowDeliveryDetailsformonDeldocketprint);
  AddXMLNode(node,'ShowManufacutresummarywhenchangedfromSales' ,ShowManufacutresummarywhenchangedfromSales);
  AddXMLNode(node,'HideMSgonEmployeeCalendar' ,HideMSgonEmployeeCalendar);
  AddXMLNode(node,'ShowImageOnMainBackGround' ,ShowImageOnMainBackGround);
  AddXMLNode(node,'ShowPrintOptionsinTransforms' ,ShowPrintOptionsinTransforms);
  AddXMLNode(node,'OpenTreeFromSalesOrder' ,OpenTreeFromSalesOrder);
  AddXMLNode(node,'CapacityplannerSelectionOptionBeforeLoad' ,CapacityplannerSelectionOptionBeforeLoad);
  AddXMLNode(node,'ManufacturePartSourceStockconfirm' ,ManufacturePartSourceStockconfirm);
  AddXMLNode(node,'PreviewAllreport' ,PreviewAllreport);
  AddXMLNode(node,'ShowVideoMenuAtStartup' ,ShowVideoMenuAtStartup);
  AddXMLNode(node,'ShowOverduesalesReminders' ,ShowOverduesalesReminders);
  AddXMLNode(node,'ShowFinishedProgressBuildReminder' ,ShowFinishedProgressBuildReminder);
  AddXMLNode(node,'ShowRelatedProductSelectioninSale' ,ShowRelatedProductSelectioninSale);
  AddXMLNode(node,'WageAccountID', WageAccountID);
  AddXMLNode(node,'WagesPaidAccountID', WagesPaidAccountID);
  AddXMLNode(node,'CustomerPriceLsitOption', CustomerPriceLsitOption);
  AddXMLNode(node,'DeductionsPaidAccountID', DeductionsPaidAccountID);
  AddXMLNode(node,'LeaveProvisionAccountID', LeaveProvisionAccountID);
  AddXMLNode(node,'NetWagesAccountID', NetWagesAccountID);
  AddXMLNode(node,'AllowancePaidAccountID', AllowancePaidAccountID);
  AddXMLNode(node,'SuperPaidAccountID', SuperPaidAccountID);
  AddXMLNode(node,'SundriesPaidAccountID', SundriesPaidAccountID);
  AddXMLNode(node,'CommissionPaidAccountID', CommissionPaidAccountID);
  AddXMLNode(node,'DeductionLiabilityAccountID', DeductionLiabilityAccountID);
  AddXMLNode(node,'SuperPayableAccountID', SuperPayableAccountID);
  AddXMLNode(node,'AllowanceLiabilityAccountID', AllowanceLiabilityAccountID);
  AddXMLNode(node,'LeaveLiabilityAccountID', LeaveLiabilityAccountID);
  AddXMLNode(node,'PAYGTaxPayableAccountID', PAYGTaxPayableAccountID);
  AddXMLNode(node,'LumpSumDPaidAccountID', LumpSumDPaidAccountID);
  AddXMLNode(node,'ShowReorder',ShowReorder);
  AddXMLNode(node,'ProductListType', ProductListType);
  AddXMLNode(node,'ShowProductListtypeSelection', ShowProductListtypeSelection);
  AddXMLNode(node,'ShowProductListtypeSelectionforExpress', ShowProductListtypeSelectionforExpress);
  AddXMLNode(node,'ShowProductListtypeSelectionforDetails', ShowProductListtypeSelectionforDetails);
  AddXMLNode(node,'ShowProductListtypeSelectionforQtyList', ShowProductListtypeSelectionforQtyList);
  AddXMLNode(node,'BOMSalesList', BOMSalesList);
  AddXMLNode(node,'StockanalysisReport', StockanalysisReport);
  AddXMLNode(node,'ShowReportTablesMsg', ShowReportTablesMsg);
  AddXMLNode(node,'ShortListDaysPast' ,ShortListDaysPast);
  AddXMLNode(node,'ShortListDaysFuture' ,ShortListDaysFuture);
  AddXMLNode(node,'LongListDaysPast' ,LongListDaysPast);
  AddXMLNode(node,'LongListDaysFuture' ,LongListDaysFuture);

  AddXMLNode(node,'UseAlternatingRowColor' ,UseAlternatingRowColor);
  AddXMLNode(node,'ColourAlternatingRow' ,ColourAlternatingRow);
  AddXMLNode(node,'GradIntensityAlternatingRow' ,GradIntensityAlternatingRow);
  AddXMLNode(node,'UseERPSingleColor' ,UseERPSingleColor);
  AddXMLNode(node,'ColourERPSingle' ,ColourERPSingle);
  AddXMLNode(node,'GradIntensityERPSingle' ,GradIntensityERPSingle);
  AddXMLNode(node,'UseERPButtonColor' ,UseERPButtonColor);
  AddXMLNode(node,'ColourERPButton' ,ColourERPButton);
  AddXMLNode(node,'GradIntensityERPButton' ,GradIntensityERPButton);
  AddXMLNode(node,'ColourERPButtonFont' ,ColourERPButtonFont);
  AddXMLNode(node,'GradIntensityERPButtonFont' ,GradIntensityERPButtonFont);
  AddXMLNode(node,'ColourERPButtonHT' ,ColourERPButtonHT);
  AddXMLNode(node,'GradIntensityERPButtonHT' ,GradIntensityERPButtonHT);
  AddXMLNode(node,'ShowGrossWeightnQtyCalcMsg', ShowGrossWeightnQtyCalcMsg);
  AddXMLNode(node,'UseGradBackground', UseGradBackground);
  AddXMLNode(node,'CalcnshowAvailaibityinCapacityPlanner', CalcnshowAvailaibityinCapacityPlanner);
  AddXMLNode(node,'ApptStartTime', ApptStartTime);
  AddXMLNode(node,'ApptEndtime', ApptEndtime);
  AddXMLNode(node,'DefaultApptDuration' ,DefaultApptDuration);
  AddXMLNode(node,'RoundApptDurationTo' ,RoundApptDurationTo);
  AddXMLNode(node,'ShowApptDurationin' ,ShowApptDurationin);
  AddXMLNode(node,'DefaultServiceProductID' ,DefaultServiceProductID);
  AddXMLNode(node,'DefaultServiceProduct', DefaultServiceProduct);
  AddXMLNode(node,'ShowSundayinApptCalendar', ShowSundayinApptCalendar);
  AddXMLNode(node,'ShowMondayinApptCalendar', ShowMondayinApptCalendar);
  AddXMLNode(node,'ShowTuesdayinApptCalendar', ShowTuesdayinApptCalendar);
  AddXMLNode(node,'ShowWednesdayinApptCalendar', ShowWednesdayinApptCalendar);
  AddXMLNode(node,'ShowThursdayinApptCalendar', ShowThursdayinApptCalendar);
  AddXMLNode(node,'ShowFridayinApptCalendar', ShowFridayinApptCalendar);
  AddXMLNode(node,'ShowSaturdayinApptCalendar', ShowSaturdayinApptCalendar);
  AddXMLNode(node,'MinimumChargeAppointmentTime' ,MinimumChargeAppointmentTime);
end;


function TPersonalPreferences.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if EmployeeID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'EmployeeID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TPersonalPreferences.Save: Boolean ;
begin
  PostDb;
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPersonalPreferences.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


class function TPersonalPreferences.PropAsBool(aEmployeeID: integer;
  PropName: string): boolean;
var
  pp: TPersonalPreferences;
begin
  pp := TPersonalPreferences.CreateWithSharedConn(nil);
  try
    pp.LoadSelect('EmployeeID = ' + IntToStr(aEmployeeID));
    result := TypInfo.GetVariantProp(pp,PropName);
  finally
    pp.Free;
  end;
end;

procedure TPersonalPreferences.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TPersonalPreferences.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

function TPersonalPreferences.GetSundriesPaidAccountID: integer;
begin
  result := GetIntegerField('');
end;

function TPersonalPreferences.GetSuperPaidAccountID: integer;
begin
  result := GetIntegerField('');
end;

function TPersonalPreferences.GetSuperPayableAccountID: integer;
begin
  result := GetIntegerField('');
end;

class function TPersonalPreferences.GetIDField: string;
begin
  Result := 'PPID'
end;


class function TPersonalPreferences.GetBusObjectTablename: string;
begin
  Result:= 'tblpersonalpreferences';
end;


function TPersonalPreferences.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  UseAlternatingRowColor      := True;
  ColourAlternatingRow        := Default_ColourAlternatingRow;
  GradIntensityAlternatingRow := 0;

  UseERPSingleColor           := True;
  ColourERPSingle             := Default_ColourERPSingle;
  GradIntensityERPSingle      := 0;

  UseERPButtonColor           := True;
  ColourERPButton             := Default_ColourERPButton;
  GradIntensityERPButton      := 0;

  ColourERPButtonFont         := Default_ColourERPButtonFont;
  GradIntensityERPButtonFont  := 0;

  ColourERPButtonHT           := Default_ColourERPButtonHT;
  GradIntensityERPButtonHT    := 0;
  if Appenv.AppDb.apimode then
      MaxDiscountPercentage := 1;
end;

function TPersonalPreferences.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


function TPersonalPreferences.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeInsert(Sender);
end;

{Property Functions}
function  TPersonalPreferences.GetEmployeeID                              : Integer   ; begin Result := GetIntegerField('EmployeeID')                                ;end;
function  TPersonalPreferences.GetMaxDiscountPercentage                   : double    ; begin result := GetFloatField('MaxDiscountPercentage')                       ;end;
function  TPersonalPreferences.GetMinMarkupPercentage                     : double    ; begin result := GetFloatField('MinMarkupPercentage')                         ;end;
function  TPersonalPreferences.GetMinimumMarginPercentage                 : double    ; begin result := GetFloatField('MinimumMarginPercentage')                     ;end;
function  TPersonalPreferences.GetAPPAppearDays                           : Integer   ; begin Result := GetIntegerField('APPAppearDays')                             ;end;
function  TPersonalPreferences.GetToDoAppearDays                          : Integer   ; begin Result := GetIntegerField('ToDoAppearDays')                            ;end;
function  TPersonalPreferences.GetPendingSOAppearDays                     : Integer   ; begin Result := GetIntegerField('PendingSOAppearDays')                       ;end;
function  TPersonalPreferences.GetOthContactAppearDays                    : Integer   ; begin Result := GetIntegerField('OthContactAppearDays')                      ;end;
function  TPersonalPreferences.GetQuoteAppearDays                         : Integer   ; begin Result := GetIntegerField('QuoteAppearDays')                           ;end;
function  TPersonalPreferences.GetMemTransAppearDays                      : Integer   ; begin Result := GetIntegerField('MemTransAppearDays')                        ;end;
function  TPersonalPreferences.GetListDaysPast                            : Integer   ; begin Result := GetIntegerField('ListDaysPast')                              ;end;
function  TPersonalPreferences.GetListDaysFuture                          : Integer   ; begin Result := GetIntegerField('ListDaysFuture')                            ;end;
function  TPersonalPreferences.GetDeductionLiabilityAccountID             : integer   ; begin result := GetIntegerField('DeductionLiabilityAccountID')               ;end;
function  TPersonalPreferences.GetDeductionsPaidAccountID                 : integer   ; begin result := GetIntegerField('DeductionsPaidAccountID')                   ;end;
function  TPersonalPreferences.GetUseWord                                 : Boolean   ; begin Result := GetBooleanField('UseWord')                                   ;end;
function  TPersonalPreferences.GetWageAccountID                           : integer   ; begin result := GetIntegerField('WageAccountID')                             ;end;
function  TPersonalPreferences.GetWagesPaidAccountID                      : integer   ; begin result := GetIntegerField('WagesPaidAccountID')                        ;end;
function  TPersonalPreferences.GetCustomerLoyaltyAppearDays               : Integer   ; begin Result := GetIntegerField('CustomerLoyaltyAppearDays')                 ;end;
function  TPersonalPreferences.GetCommissionPaidAccountID                 : integer   ; begin result := GetIntegerField('CommissionPaidAccountID')                   ;end;
function  TPersonalPreferences.GetContactLoyaltyAppearDays                : Integer   ; begin Result := GetIntegerField('ContactLoyaltyAppearDays')                  ;end;
function  TPersonalPreferences.GetEmployeeskillRenewalAppearDays          : Integer   ; begin Result := GetIntegerField('EmployeeskillRenewalAppearDays')            ;end;
function  TPersonalPreferences.GetPOSAutoLoad                             : Boolean   ; begin Result := GetBooleanField('POSAutoLoad')                               ;end;
function  TPersonalPreferences.GetShowPrintDialog                         : Boolean   ; begin Result := GetBooleanField('ShowPrintDialog')                           ;end;
function  TPersonalPreferences.GetListSelectionColour                     : string    ; begin Result := GetStringField('ListSelectionColour')                        ;end;
function  TPersonalPreferences.GetLumpSumDPaidAccountID                   : integer   ; begin result := GetIntegerField('LumpSumDPaidAccountID')                     ;end;
function  TPersonalPreferences.GetReceivedBOAppearDays                    : Integer   ; begin Result := GetIntegerField('ReceivedBOAppearDays')                      ;end;
function  TPersonalPreferences.GetPasswordNeverExpires                    : boolean   ; begin result := GetBooleanField('PasswordNeverExpires')                      ;end;
function  TPersonalPreferences.GetCanChangePassword                       : boolean   ; begin result := GetBooleanField('CanChangePassword')                         ;end;

function  TPersonalPreferences.GetPAYGTaxPayableAccountID                 : integer   ; begin result := GetIntegerField('PAYGTaxPayableAccountID')                   ;end;
function  TPersonalPreferences.GetPayrollAccess                           : Boolean   ; begin Result := GetBooleanField('PayrollAccess')                             ;end;
function  TPersonalPreferences.GetUseSnapshotProductList                  : Boolean   ; begin Result := GetBooleanField('UseSnapshotProductList')                    ;end;
function  TPersonalPreferences.GetAutoApplyDeposits                       : Boolean   ; begin Result := GetBooleanField('AutoApplyDeposits')                         ;end;
function  TPersonalPreferences.GetNoQtyDrillDownOnSales                   : Boolean   ; begin Result := GetBooleanField('NoQtyDrillDownOnSales')                     ;end;
function  TPersonalPreferences.GetCloseOnPrint                            : Boolean   ; begin Result := GetBooleanField('CloseOnPrint')                              ;end;
function  TPersonalPreferences.GetProductClassWarning                     : Boolean   ; begin Result := GetBooleanField('ProductClassWarning')                       ;end;
function  TPersonalPreferences.GetUseClientAccountNoOnPayments            : Boolean   ; begin Result := GetBooleanField('UseClientAccountNoOnPayments')              ;end;
function  TPersonalPreferences.GetOverrideAutoSmartOrders                 : Boolean   ; begin Result := GetBooleanField('OverrideAutoSmartOrders')                   ;end;
function  TPersonalPreferences.GetNetWagesAccountID                       : integer   ; begin result := GetIntegerField('NetWagesAccountID')                         ;end;
function  TPersonalPreferences.GetImageScheme                             : string    ; begin Result := GetStringField('ImageScheme')                                ;end;
function  TPersonalPreferences.GetFixedAssetInsuranceExpiresAppearDays    : Integer   ; begin Result := GetIntegerField('FixedAssetInsuranceExpiresAppearDays')      ;end;
function  TPersonalPreferences.GetFixedAssetWarrantyExpiresAppearDays     : Integer   ; begin Result := GetIntegerField('FixedAssetWarrantyExpiresAppearDays')       ;end;
function  TPersonalPreferences.GetMarketingContactsAppearDays             : Integer   ; begin Result := GetIntegerField('MarketingContactsAppearDays')               ;end;
function  TPersonalPreferences.GetActiveWindow                            : Integer   ; begin Result := GetIntegerField('ActiveWindow')                              ;end;
function  TPersonalPreferences.GetAllowanceLiabilityAccountID             : integer   ; begin result := GetIntegerField('AllowanceLiabilityAccountID')               ;end;
function  TPersonalPreferences.GetAllowancePaidAccountID                  : integer   ; begin result := GetIntegerField('AllowancePaidAccountID')                    ;end;
function  TPersonalPreferences.GetReminderHideDays                        : Integer   ; begin Result := GetIntegerField('ReminderHideDays')                          ;end;
function  TPersonalPreferences.GetCalender24hr                            : Boolean   ; begin Result := GetBooleanField('Calender24hr')                              ;end;
function  TPersonalPreferences.GetLeadsAppearDays                         : Integer   ; begin Result := GetIntegerField('LeadsAppearDays')                           ;end;
function  TPersonalPreferences.GetLeaveLiabilityAccountID                 : integer   ; begin result := GetIntegerField('LeaveLiabilityAccountID')                   ;end;
function  TPersonalPreferences.GetLeaveProvisionAccountID                 : integer   ; begin result := GetIntegerField('LeaveProvisionAccountID')                   ;end;
function  TPersonalPreferences.GetServiceLogAprearDays                    : Integer   ; begin Result := GetIntegerField('ServiceLogAprearDays')                      ;end;
function  TPersonalPreferences.GetGoodToReceiveReminderDays               : Integer   ; begin Result := GetIntegerField('GoodToReceiveReminderDays')                 ;end;
function  TPersonalPreferences.GetShowERPTips                             : Boolean   ; begin Result := GetBooleanField('ShowERPTips')                               ;end;
function  TPersonalPreferences.GetRunManufacturingUpdateBatch             : Boolean   ; begin Result := GetBooleanField('RunManufacturingUpdateBatch')               ;end;
function  TPersonalPreferences.GetDefaultOrderinTransForms                : Boolean   ; begin Result := GetBooleanField('DefaultOrderinTransForms')                  ;end;
function  TPersonalPreferences.GetShowDeliveryDetailsformonDeldocketprint : Boolean   ; begin Result := GetBooleanField('ShowDeliveryDetailsformonDeldocketprint')   ;end;
function  TPersonalPreferences.GetShowManufacutresummarywhenchangedfromSl : Boolean   ; begin Result := GetBooleanField('ShowManufacutresummarywhenchangedfromSales');end;
function  TPersonalPreferences.GetHideMSgonEmployeeCalendar               : Boolean   ; begin Result := GetBooleanField('HideMSgonEmployeeCalendar')                 ;end;
function  TPersonalPreferences.GetShowImageOnMainBackGround               : Boolean   ; begin Result := GetBooleanField('ShowImageOnMainBackGround')                 ;end;
function  TPersonalPreferences.GetShowPrintOptionsinTransforms            : Boolean   ; begin Result := GetBooleanField('ShowPrintOptionsinTransforms')              ;end;
function  TPersonalPreferences.GetOpenTreeFromSalesOrder                  : Boolean   ; begin Result := GetBooleanField('OpenTreeFromSalesOrder')                    ;end;
function  TPersonalPreferences.GetCapacityplannerSelectionOptionBeforeLoad: Boolean   ; begin Result := GetBooleanField('CapacityplannerSelectionOptionBeforeLoad')  ;end;
function  TPersonalPreferences.GetManufacturePartSourceStockconfirm       : Boolean   ; begin Result := GetBooleanField('ManufacturePartSourceStockconfirm')         ;end;
function  TPersonalPreferences.GetPreviewAllreport                        : Boolean   ; begin Result := GetBooleanField('PreviewAllreport')                          ;end;
function  TPersonalPreferences.GetShowVideoMenuAtStartup                  : Boolean   ; begin Result := GetBooleanField('ShowVideoMenuAtStartup')                    ;end;
function  TPersonalPreferences.GetShowOverduesalesReminders               : Boolean   ; begin Result := GetBooleanField('ShowOverduesalesReminders')                 ;end;
function  TPersonalPreferences.GetShowFinishedProgressBuildReminder       : Boolean   ; begin Result := GetBooleanField('ShowFinishedProgressBuildReminder')         ;end;
function  TPersonalPreferences.GetShowRelatedProductSelectioninSale       : Boolean   ; begin Result := GetBooleanField('ShowRelatedProductSelectioninSale')         ;end;
function  TPersonalPreferences.GetProductListType                         : String    ; begin Result := GetStringField('ProductListType')                            ;end;
function  TPersonalPreferences.GetShowProductListtypeSelection            : Boolean   ; begin Result := GetBooleanField('ShowProductListtypeSelection')              ;end;
function  TPersonalPreferences.GetShowProductListtypeSelectionforExpress  : Boolean   ; begin Result := GetBooleanField('ShowProductListtypeSelectionforExpress')    ;end;
function  TPersonalPreferences.GetShowProductListtypeSelectionforDetails  : Boolean   ; begin Result := GetBooleanField('ShowProductListtypeSelectionforDetails')    ;end;
function  TPersonalPreferences.GetShowProductListtypeSelectionforQtyList  : Boolean   ; begin Result := GetBooleanField('ShowProductListtypeSelectionforQtyList')    ;end;
function  TPersonalPreferences.getBOMSalesList                            : String    ; begin Result := GetStringField('BOMSalesList')                               ;end;
function  TPersonalPreferences.getStockanalysisReport                     : String    ; begin Result := GetStringField('StockanalysisReport')                        ;end;
function TPersonalPreferences.GetShowReorder                              : boolean   ; begin result := GetBooleanField('ShowReorder')                               ;end;
function  TPersonalPreferences.GetPopRemindersToDo                        : Boolean   ; begin (*Result := GetBooleanField('PopRemindersToDo');*)      result:= false;end;
function  TPersonalPreferences.GetPopRemindersMFollowup                   : Boolean   ; begin (*Result := GetBooleanField('PopRemindersMFollowup');*) result:= false;end;
function  TPersonalPreferences.GetPopRemindersMessages                    : Boolean   ; begin (*Result := GetBooleanField('PopRemindersMessages');*)  result:= false;end;
function  TPersonalPreferences.GetShowPreview                             : Boolean   ; begin if devmode then result := false else Result := GetBooleanField('ShowPreview');end;
function  TPersonalPreferences.GetShowReportTablesMsg                     : Boolean   ; begin Result := GetBooleanField('ShowReportTablesMsg')                      ;end;
function  TPersonalPreferences.GetCustomerPriceLsitOption                 : integer   ; begin result := GetIntegerField('CustomerPriceLsitOption')                   ;end;
function  TPersonalPreferences.GetShortListDaysPast                       : Integer   ; begin Result := GetIntegerField('ShortListDaysPast')                         ;end;
function  TPersonalPreferences.GetShortListDaysFuture                     : Integer   ; begin Result := GetIntegerField('ShortListDaysFuture')                       ;end;
function  TPersonalPreferences.GetLongListDaysPast                        : Integer   ; begin Result := GetIntegerField('LongListDaysPast')                         ;end;
function  TPersonalPreferences.GetLongListDaysFuture                      : Integer   ; begin Result := GetIntegerField('LongListDaysFuture')                       ;end;
function  TPersonalPreferences.getApptStartTime                           : String    ; begin Result := GetStringField('ApptStartTime')                             ;end;
function  TPersonalPreferences.getApptEndtime                             : String    ; begin Result := GetStringField('ApptEndtime')                               ;end;
function  TPersonalPreferences.GetDefaultApptDuration                     : Integer   ; begin Result := GetIntegerField('DefaultApptDuration')                      ;end;
function  TPersonalPreferences.GetRoundApptDurationTo                     : Integer   ; begin Result := GetIntegerField('RoundApptDurationTo')                      ;end;
function  TPersonalPreferences.GetShowApptDurationin                      : Integer   ; begin Result := GetIntegerField('ShowApptDurationin')                       ;end;
function  TPersonalPreferences.GetDefaultServiceProductID                 : Integer   ; begin Result := GetIntegerField('DefaultServiceProductID')                  ;end;
function  TPersonalPreferences.getDefaultServiceProduct                   : String    ; begin Result := TProduct.IDToggle(DefaultServiceProductID)                  ;end;

function  TPersonalPreferences.GetUseAlternatingRowColor                  : boolean   ; begin result := GetBooleanField('UseAlternatingRowColor')                   ;end;
function  TPersonalPreferences.GetColourAlternatingRow                    : Integer   ; begin Result := GetIntegerField('ColourAlternatingRow')                     ; if result = 0 then result := Default_ColourAlternatingRow;end;
function  TPersonalPreferences.GetGradIntensityAlternatingRow             : Integer   ; begin Result := GetIntegerField('GradIntensityAlternatingRow')              ;end;
function  TPersonalPreferences.GetUseERPSingleColor                       : boolean   ; begin result := GetBooleanField('UseERPSingleColor')                        ;end;
function  TPersonalPreferences.GetColourERPSingle                         : Integer   ; begin Result := GetIntegerField('ColourERPSingle')                          ; if result = 0 then result := Default_ColourERPSingle;end;
function  TPersonalPreferences.GetGradIntensityERPSingle                  : Integer   ; begin Result := GetIntegerField('GradIntensityERPSingle')                   ;end;
function  TPersonalPreferences.GetUseERPButtonColor                       : boolean   ; begin result := GetBooleanField('UseERPButtonColor')                        ;end;
function  TPersonalPreferences.GetColourERPButton                         : Integer   ; begin Result := GetIntegerField('ColourERPButton')                          ; if result = 0 then result := Default_ColourERPButton;end;
function  TPersonalPreferences.GetGradIntensityERPButton                  : Integer   ; begin Result := GetIntegerField('GradIntensityERPButton')                   ;end;
function  TPersonalPreferences.GetColourERPButtonFont                     : Integer   ; begin Result := GetIntegerField('ColourERPButtonFont')                      ; if result = 0 then result := Default_ColourERPButtonFont;end;
function  TPersonalPreferences.GetGradIntensityERPButtonFont              : Integer   ; begin Result := GetIntegerField('GradIntensityERPButtonFont')               ;end;
function  TPersonalPreferences.GetColourERPButtonHT                       : Integer   ; begin Result := GetIntegerField('ColourERPButtonHT')                        ; if result = 0 then result := Default_ColourERPButtonHT;end;
function  TPersonalPreferences.GetGradIntensityERPButtonHT                : Integer   ; begin Result := GetIntegerField('GradIntensityERPButtonHT')                 ;end;
function  TPersonalPreferences.GetShowGrossWeightnQtyCalcMsg              : Boolean   ; begin Result := GetBooleanField('ShowGrossWeightnQtyCalcMsg')               ;end;
function  TPersonalPreferences.GetUseGradBackground                       : Boolean   ; begin Result := GetBooleanField('UseGradBackground')                        ;end;
function  TPersonalPreferences.GetCalcnshowAvailaibityinCapacityPlanner   : Boolean   ; begin Result := GetBooleanField('CalcnshowAvailaibityinCapacityPlanner')    ;end;

function  TPersonalPreferences.GetMinimumChargeAppointmentTime            : Integer   ; begin Result := GetIntegerField('MinimumChargeAppointmentTime');if result =0 then  result := Appenv.companyprefs.MinimumChargeAppointmentTime; end;
function  TPersonalPreferences.GetShowSundayinApptCalendar                : Boolean   ; begin if sametext(GetStringField('ShowSundayinApptCalendar')   ,'U') then REsult := Appenv.companyprefs.ShowSundayinApptCalendar     else  Result := GetBooleanField('ShowSundayinApptCalendar')   ;end;
function  TPersonalPreferences.GetShowMondayinApptCalendar                : Boolean   ; begin if sametext(GetStringField('ShowMondayinApptCalendar')   ,'U') then REsult := Appenv.companyprefs.ShowMondayinApptCalendar     else  Result := GetBooleanField('ShowMondayinApptCalendar')   ;end;
function  TPersonalPreferences.GetShowTuesdayinApptCalendar               : Boolean   ; begin if sametext(GetStringField('ShowTuesdayinApptCalendar')  ,'U') then REsult := Appenv.companyprefs.ShowTuesdayinApptCalendar    else  Result := GetBooleanField('ShowTuesdayinApptCalendar')  ;end;
function  TPersonalPreferences.GetShowWednesdayinApptCalendar             : Boolean   ; begin if sametext(GetStringField('ShowWednesdayinApptCalendar'),'U') then REsult := Appenv.companyprefs.ShowWednesdayinApptCalendar  else  Result := GetBooleanField('ShowWednesdayinApptCalendar');end;
function  TPersonalPreferences.GetShowThursdayinApptCalendar              : Boolean   ; begin if sametext(GetStringField('ShowThursdayinApptCalendar') ,'U') then REsult := Appenv.companyprefs.ShowThursdayinApptCalendar   else  Result := GetBooleanField('ShowThursdayinApptCalendar') ;end;
function  TPersonalPreferences.GetShowFridayinApptCalendar                : Boolean   ; begin if sametext(GetStringField('ShowFridayinApptCalendar')   ,'U') then REsult := Appenv.companyprefs.ShowFridayinApptCalendar     else  Result := GetBooleanField('ShowFridayinApptCalendar')   ;end;
function  TPersonalPreferences.GetShowSaturdayinApptCalendar              : Boolean   ; begin if sametext(GetStringField('ShowSaturdayinApptCalendar') ,'U') then REsult := Appenv.companyprefs.ShowSaturdayinApptCalendar   else  Result := GetBooleanField('ShowSaturdayinApptCalendar') ;end;

procedure TPersonalPreferences.SetEmployeeID                              (const Value: Integer   ); begin SetIntegerField('EmployeeID'                                 , Value);end;
procedure TPersonalPreferences.SetMaxDiscountPercentage                   (const Value: double    ); begin  SetFloatField('MaxDiscountPercentage'                       , Value);end;
procedure TPersonalPreferences.SetMinMarkupPercentage                     (const Value: double    ); begin  SetFloatField('MinMarkupPercentage'                         , Value);end;
procedure TPersonalPreferences.SetMinimumMarginPercentage                 (const Value: double    ); begin  SetFloatField('MinimumMarginPercentage'                     , Value);end;
procedure TPersonalPreferences.SetAPPAppearDays                           (const Value: Integer   ); begin SetIntegerField('APPAppearDays'                              , Value);end;
procedure TPersonalPreferences.SetToDoAppearDays                          (const Value: Integer   ); begin SetIntegerField('ToDoAppearDays'                             , Value);end;
procedure TPersonalPreferences.SetPendingSOAppearDays                     (const Value: Integer   ); begin SetIntegerField('PendingSOAppearDays'                        , Value);end;
procedure TPersonalPreferences.SetOthContactAppearDays                    (const Value: Integer   ); begin SetIntegerField('OthContactAppearDays'                       , Value);end;
procedure TPersonalPreferences.SetQuoteAppearDays                         (const Value: Integer   ); begin SetIntegerField('QuoteAppearDays'                            , Value);end;
procedure TPersonalPreferences.SetMemTransAppearDays                      (const Value: Integer   ); begin SetIntegerField('MemTransAppearDays'                         , Value);end;
procedure TPersonalPreferences.SetSundriesPaidAccountID                   (const Value: integer   ); begin SetIntegerField('SundriesPaidAccountID'                      , Value);end;
procedure TPersonalPreferences.SetSuperPaidAccountID                      (const Value: integer   ); begin SetIntegerField('SuperPaidAccountID'                         , Value);end;
procedure TPersonalPreferences.SetSuperPayableAccountID                   (const Value: integer   ); begin SetIntegerField('SuperPayableAccountID'                      , Value);end;
procedure TPersonalPreferences.SetListDaysPast                            (const Value: Integer   ); begin SetIntegerField('ListDaysPast'                               , Value);end;
procedure TPersonalPreferences.SetListDaysFuture                          (const Value: Integer   ); begin SetIntegerField('ListDaysFuture'                             , Value);end;
procedure TPersonalPreferences.SetDeductionLiabilityAccountID             (const Value: integer   ); begin SetIntegerField('DeductionLiabilityAccountID'                , Value);end;
procedure TPersonalPreferences.SetDeductionsPaidAccountID                 (const Value: integer   ); begin SetIntegerField('DeductionsPaidAccountID'                    , Value);end;
procedure TPersonalPreferences.SetUseWord                                 (const Value: Boolean   ); begin SetBooleanField('UseWord'                                    , Value);end;
procedure TPersonalPreferences.SetWageAccountID                           (const Value: integer   ); begin SetIntegerField('WageAccountID'                              , Value);end;
procedure TPersonalPreferences.SetWagesPaidAccountID                      (const Value: integer   ); begin SetIntegerField('WagesPaidAccountID'                         , Value);end;

class function TPersonalPreferences.UserPasswordNeverExpires(const aLogonName,
  aServer, aDatabase: string): boolean;
var
  conn: TERPConnection;
  qry: TERPQuery;
begin
  result := false;
  if (aServer = '') or (aLogonName = '') or (aDatabase = '') then
    exit;
  try
    conn := DBUtils.GetNewDbConnection(aServer,aDatabase);
    qry := TERPQuery.Create(nil);
    try
      conn.Connect;
      qry.Connection := conn;
      qry.SQL.Add('select * from  tblPersonalPreferences');
      qry.SQL.Add('inner join tblpassword on tblpassword.EmployeeID = tblPersonalPreferences.EmployeeID');
      qry.SQL.Add('and tblpassword.Logon_Name = ' + QuotedStr(aLogonName));
      qry.Open;
      result := qry.Fields.FieldByName('PasswordNeverExpires').AsBoolean;
    finally
      qry.Free;
      conn.Free;
    end;
  except

  end;
end;
class function TPersonalPreferences.UserCanChangePassword(const aLogonName,
  aServer, aDatabase: string): boolean;
var
  conn: TERPConnection;
  qry: TERPQuery;
begin
  result := false;
  if (aServer = '') or (aLogonName = '') or (aDatabase = '') then
    exit;
  try
    conn := DBUtils.GetNewDbConnection(aServer,aDatabase);
    qry := TERPQuery.Create(nil);
    try
      conn.Connect;
      qry.Connection := conn;
      qry.SQL.Add('select CanChangePassword from  tblPersonalPreferences');
      qry.SQL.Add('inner join tblpassword on tblpassword.EmployeeID = tblPersonalPreferences.EmployeeID');
      qry.SQL.Add('and tblpassword.Logon_Name = ' + QuotedStr(aLogonName));
      qry.Open;
      result := qry.Fields.FieldByName('CanChangePassword').AsBoolean;
    finally
      qry.Free;
      conn.Free;
    end;
  except

  end;
end;
procedure TPersonalPreferences.SetCustomerLoyaltyAppearDays               (const Value: Integer   ); begin SetIntegerField('CustomerLoyaltyAppearDays'                  , Value);end;
procedure TPersonalPreferences.SetCommissionPaidAccountID                 (const Value: integer   ); begin SetIntegerField('CommissionPaidAccountID'                    , Value);end;
procedure TPersonalPreferences.SetContactLoyaltyAppearDays                (const Value: Integer   ); begin SetIntegerField('ContactLoyaltyAppearDays'                   , Value);end;
procedure TPersonalPreferences.SetEmployeeskillRenewalAppearDays          (const Value: Integer   ); begin SetIntegerField('EmployeeskillRenewalAppearDays'             , Value);end;
procedure TPersonalPreferences.SetPOSAutoLoad                             (const Value: Boolean   ); begin SetBooleanField('POSAutoLoad'                                , Value);end;
procedure TPersonalPreferences.SetShowPrintDialog                         (const Value: Boolean   ); begin SetBooleanField('ShowPrintDialog'                            , Value);end;
procedure TPersonalPreferences.SetShowPreview                             (const Value: Boolean   ); begin SetBooleanField('ShowPreview'                                , Value);end;
procedure TPersonalPreferences.SetListSelectionColour                     (const Value: string    ); begin SetStringField('ListSelectionColour'                         , Value);end;
procedure TPersonalPreferences.SetLumpSumDPaidAccountID                   (const Value: integer   ); begin SetIntegerField('LumpSumDPaidAccountID'                      , Value);end;
procedure TPersonalPreferences.SetReceivedBOAppearDays                    (const Value: Integer   ); begin SetIntegerField('ReceivedBOAppearDays'                       , Value);end;
procedure TPersonalPreferences.SetPasswordNeverExpires                    (const Value: boolean   ); begin SetBooleanField('PasswordNeverExpires'                       , Value);end;
procedure TPersonalPreferences.SetCanChangePassword                       (const Value: boolean   ); begin SetBooleanField('CanChangePassword'                          , Value);end;
procedure TPersonalPreferences.SetPAYGTaxPayableAccountID                 (const Value: integer   ); begin SetIntegerField('PAYGTaxPayableAccountID'                    , Value);end;
procedure TPersonalPreferences.SetPayrollAccess                           (const Value: Boolean   ); begin SetBooleanField('PayrollAccess'                              , Value);end;
procedure TPersonalPreferences.SetUseSnapshotProductList                  (const Value: Boolean   ); begin SetBooleanField('UseSnapshotProductList'                     , Value);end;
procedure TPersonalPreferences.SetAutoApplyDeposits                       (const Value: Boolean   ); begin SetBooleanField('AutoApplyDeposits'                          , Value);end;
procedure TPersonalPreferences.SetNoQtyDrillDownOnSales                   (const Value: Boolean   ); begin SetBooleanField('NoQtyDrillDownOnSales'                      , Value);end;
procedure TPersonalPreferences.SetCloseOnPrint                            (const Value: Boolean   ); begin SetBooleanField('CloseOnPrint'                               , Value);end;
procedure TPersonalPreferences.SetProductClassWarning                     (const Value: Boolean   ); begin SetBooleanField('ProductClassWarning'                        , Value);end;
procedure TPersonalPreferences.SetUseClientAccountNoOnPayments            (const Value: Boolean   ); begin SetBooleanField('UseClientAccountNoOnPayments'               , Value);end;
procedure TPersonalPreferences.SetOverrideAutoSmartOrders                 (const Value: Boolean   ); begin SetBooleanField('OverrideAutoSmartOrders'                    , Value);end;
procedure TPersonalPreferences.SetNetWagesAccountID                       (const Value: integer   ); begin SetIntegerField('NetWagesAccountID'                          , Value);end;
procedure TPersonalPreferences.SetImageScheme                             (const Value: string    ); begin SetStringField('ImageScheme'                                 , Value);end;
procedure TPersonalPreferences.SetFixedAssetInsuranceExpiresAppearDays    (const Value: Integer   ); begin SetIntegerField('skinoptionMarble'                           , Value);end;
procedure TPersonalPreferences.SetFixedAssetWarrantyExpiresAppearDays     (const Value: Integer   ); begin SetIntegerField('skinoptionMarble'                           , Value);end;
procedure TPersonalPreferences.SetMarketingContactsAppearDays             (const Value: Integer   ); begin SetIntegerField('MarketingContactsAppearDays'                , Value);end;
procedure TPersonalPreferences.SetActiveWindow                            (const Value: Integer   ); begin SetIntegerField('ActiveWindow'                               , Value);end;
procedure TPersonalPreferences.SetAllowanceLiabilityAccountID             (const Value: integer   ); begin SetIntegerField('AllowanceLiabilityAccountID'                , Value);end;
procedure TPersonalPreferences.SetAllowancePaidAccountID                  (const Value: integer   ); begin SetIntegerField('AllowancePaidAccountID'                     , Value);end;
procedure TPersonalPreferences.SetReminderHideDays                        (const Value: Integer   ); begin SetIntegerField('ReminderHideDays'                           , Value);end;
procedure TPersonalPreferences.SetCalender24hr                            (const Value: Boolean   ); begin SetBooleanField('Calender24hr'                               , Value);end;
procedure TPersonalPreferences.SetPopRemindersToDo                        (const Value: Boolean   ); begin SetBooleanField('PopRemindersToDo'                           , Value);end;
procedure TPersonalPreferences.SetShowERPTips                             (const Value: Boolean   ); begin SetBooleanField('ShowERPTips'                                , Value);end;
procedure TPersonalPreferences.SetRunManufacturingUpdateBatch             (const Value: Boolean   ); begin SetBooleanField('RunManufacturingUpdateBatch'                , Value);end;
procedure TPersonalPreferences.SetDefaultOrderinTransForms                (const Value: Boolean   ); begin SetBooleanField('DefaultOrderinTransForms'                   , Value);end;
procedure TPersonalPreferences.SetPopRemindersMFollowup                   (const Value: Boolean   ); begin SetBooleanField('PopRemindersMFollowup'                      , Value);end;
procedure TPersonalPreferences.SetLeadsAppearDays                         (const Value: Integer   ); begin SetIntegerField('LeadsAppearDays'                            , Value);end;
procedure TPersonalPreferences.SetLeaveLiabilityAccountID                 (const Value: integer   );begin  SetIntegerField('LeaveLiabilityAccountID'                    , Value);end;
procedure TPersonalPreferences.SetLeaveProvisionAccountID                 (const Value: integer   );begin  SetIntegerField('LeaveProvisionAccountID'                    , Value);end;
procedure TPersonalPreferences.SetServiceLogAprearDays                    (const Value: Integer   ); begin SetIntegerField('ServiceLogAprearDays'                       , Value);end;
procedure TPersonalPreferences.SetGoodToReceiveReminderDays               (const Value: Integer   ); begin SetIntegerField('GoodToReceiveReminderDays'                  , Value);end;
procedure TPersonalPreferences.SetPopRemindersMessages                    (const Value: Boolean   ); begin SetBooleanField('PopRemindersMessages'                       , Value);end;
procedure TPersonalPreferences.SetShowDeliveryDetailsformonDeldocketprint (const Value: Boolean   ); begin SetBooleanField('ShowDeliveryDetailsformonDeldocketprint'    , Value);end;
procedure TPersonalPreferences.SetShowManufacutresummarywhenchangedfromSl (const Value: Boolean   ); begin SetBooleanField('ShowManufacutresummarywhenchangedfromSales' , Value);end;
procedure TPersonalPreferences.SetHideMSgonEmployeeCalendar               (const Value: Boolean   ); begin SetBooleanField('HideMSgonEmployeeCalendar'                  , Value);end;
procedure TPersonalPreferences.SetShowImageOnMainBackGround               (const Value: Boolean   ); begin SetBooleanField('ShowImageOnMainBackGround'                  , Value);end;
procedure TPersonalPreferences.SetShowPrintOptionsinTransforms            (const Value: Boolean   ); begin SetBooleanField('ShowPrintOptionsinTransforms'               , Value);end;
procedure TPersonalPreferences.SetOpenTreeFromSalesOrder                  (const Value: Boolean   ); begin SetBooleanField('OpenTreeFromSalesOrder'                     , Value);end;
procedure TPersonalPreferences.SetCapacityplannerSelectionOptionBeforeLoad(const Value: Boolean   ); begin SetBooleanField('CapacityplannerSelectionOptionBeforeLoad'   , Value);end;
procedure TPersonalPreferences.SetManufacturePartSourceStockconfirm       (const Value: Boolean   ); begin SetBooleanField('ManufacturePartSourceStockconfirm'          , Value);end;
procedure TPersonalPreferences.SetPreviewAllreport                        (const Value: Boolean   ); begin SetBooleanField('PreviewAllreport'                           , Value);end;
procedure TPersonalPreferences.SetShowVideoMenuAtStartup                  (const Value: Boolean   ); begin SetBooleanField('ShowVideoMenuAtStartup'                     , Value);end;
procedure TPersonalPreferences.SetShowOverduesalesReminders               (const Value: Boolean   ); begin SetBooleanField('ShowOverduesalesReminders'                  , Value);end;
procedure TPersonalPreferences.SetShowFinishedProgressBuildReminder       (const Value: Boolean   ); begin SetBooleanField('ShowFinishedProgressBuildReminder'          , Value);end;
procedure TPersonalPreferences.SetShowRelatedProductSelectioninSale       (const Value: Boolean   ); begin SetBooleanField('ShowRelatedProductSelectioninSale'          , Value);end;
procedure TPersonalPreferences.SetProductListType                         (const Value: String    ); begin SetStringfield('ProductListType'                             , Value);end;
procedure TPersonalPreferences.SetShowProductListtypeSelection            (const Value: Boolean   ); begin SetBooleanField('ShowProductListtypeSelection'               , Value);end;
procedure TPersonalPreferences.SetShowProductListtypeSelectionforExpress  (const Value: Boolean   ); begin SetBooleanField('ShowProductListtypeSelectionforExpress'     , Value);end;
procedure TPersonalPreferences.SetShowProductListtypeSelectionforDetails  (const Value: Boolean   ); begin SetBooleanField('ShowProductListtypeSelectionforDetails'     , Value);end;
procedure TPersonalPreferences.SetShowProductListtypeSelectionforQtyList  (const Value: Boolean   ); begin SetBooleanField('ShowProductListtypeSelectionforQtyList'     , Value);end;
procedure TPersonalPreferences.SetBOMSalesList                            (const Value: String    ); begin SetStringfield('BOMSalesList'                                , Value);end;
procedure TPersonalPreferences.SetStockanalysisReport                     (const Value: String    ); begin SetStringfield('StockanalysisReport'                         , Value);end;
procedure TPersonalPreferences.SetShowReorder                             (const Value: boolean   ); begin SetBooleanField('ShowReorder'                                , Value);end;
procedure TPersonalPreferences.SetShowReportTablesMsg                     (const Value: Boolean   ); begin SetBooleanField('ShowReportTablesMsg'                        , Value);end;
procedure TPersonalPreferences.SetCustomerPriceLsitOption                 (const Value: integer   ); begin SetIntegerField('CustomerPriceLsitOption'                    , Value);end;
procedure TPersonalPreferences.SetShortListDaysPast                       (const Value: Integer   ); begin SetIntegerField('ShortListDaysPast'                          , Value);end;
procedure TPersonalPreferences.SetShortListDaysFuture                     (const Value: Integer   ); begin SetIntegerField('ShortListDaysFuture'                        , Value);end;
procedure TPersonalPreferences.SetLongListDaysPast                        (const Value: Integer   ); begin SetIntegerField('LongListDaysPast'                           , Value);end;
procedure TPersonalPreferences.SetLongListDaysFuture                      (const Value: Integer   ); begin SetIntegerField('LongListDaysFuture'                         , Value);end;
procedure TPersonalPreferences.SetUseAlternatingRowColor                  (const Value: boolean   ); begin SetBooleanField('UseAlternatingRowColor'                     , Value);end;
procedure TPersonalPreferences.SetColourAlternatingRow                    (const Value: Integer   ); begin SetIntegerField('ColourAlternatingRow'                       , Value);end;
procedure TPersonalPreferences.SetGradIntensityAlternatingRow             (const Value: Integer   ); begin SetIntegerField('GradIntensityAlternatingRow'                , Value);end;
procedure TPersonalPreferences.SetUseERPSingleColor                       (const Value: boolean   ); begin SetBooleanField('UseERPSingleColor'                          , Value);end;
procedure TPersonalPreferences.SetColourERPSingle                         (const Value: Integer   ); begin SetIntegerField('ColourERPSingle'                            , Value);end;
procedure TPersonalPreferences.SetGradIntensityERPSingle                  (const Value: Integer   ); begin SetIntegerField('GradIntensityERPSingle'                     , Value);end;
procedure TPersonalPreferences.SetUseERPButtonColor                       (const Value: boolean   ); begin SetBooleanField('UseERPButtonColor'                          , Value);end;
procedure TPersonalPreferences.SetColourERPButton                         (const Value: Integer   ); begin SetIntegerField('ColourERPButton'                            , Value);end;
procedure TPersonalPreferences.SetGradIntensityERPButton                  (const Value: Integer   ); begin SetIntegerField('GradIntensityERPButton'                     , Value);end;
procedure TPersonalPreferences.SetColourERPButtonFont                     (const Value: Integer   ); begin SetIntegerField('ColourERPButtonFont'                        , Value);end;
procedure TPersonalPreferences.SetGradIntensityERPButtonFont              (const Value: Integer   ); begin SetIntegerField('GradIntensityERPButtonFont'                 , Value);end;
procedure TPersonalPreferences.SetColourERPButtonHT                       (const Value: Integer   ); begin SetIntegerField('ColourERPButtonHT'                          , Value);end;
procedure TPersonalPreferences.SetGradIntensityERPButtonHT                (const Value: Integer   ); begin SetIntegerField('GradIntensityERPButtonHT'                   , Value);end;
procedure TPersonalPreferences.SetShowGrossWeightnQtyCalcMsg              (const Value: Boolean   ); begin SetBooleanField('ShowGrossWeightnQtyCalcMsg'                 , Value);end;
procedure TPersonalPreferences.SetUseGradBackground                       (const Value: Boolean   ); begin SetBooleanField('UseGradBackground'                          , Value);end;
procedure TPersonalPreferences.SetCalcnshowAvailaibityinCapacityPlanner   (const Value: Boolean   ); begin SetBooleanField('CalcnshowAvailaibityinCapacityPlanner'      , Value);end;
procedure TPersonalPreferences.SetApptStartTime                           (const Value: String    ); begin SetStringfield('ApptStartTime'                               , Value);end;
procedure TPersonalPreferences.SetApptEndtime                             (const Value: String    ); begin SetStringfield('ApptEndtime'                                 , Value);end;
procedure TPersonalPreferences.SetDefaultApptDuration                     (const Value: Integer   ); begin SetIntegerField('DefaultApptDuration'                        , Value);end;
procedure TPersonalPreferences.SetRoundApptDurationTo                     (const Value: Integer   ); begin SetIntegerField('RoundApptDurationTo'                        , Value);end;
procedure TPersonalPreferences.SetShowApptDurationin                      (const Value: Integer   ); begin SetIntegerField('ShowApptDurationin'                         , Value);end;
procedure TPersonalPreferences.SetDefaultServiceProductID                 (const Value: Integer   ); begin SetIntegerField('DefaultServiceProductID'                    , Value);end;
procedure TPersonalPreferences.SetDefaultServiceProduct                   (const Value: String    ); begin SetIntegerField('DefaultServiceProduct'                      , TProduct.IDToggle(Value));end;
procedure TPersonalPreferences.SetShowSundayinApptCalendar                (const Value: Boolean   ); begin SetBooleanField('ShowSundayinApptCalendar'                   , Value);end;
procedure TPersonalPreferences.SetShowMondayinApptCalendar                (const Value: Boolean   ); begin SetBooleanField('ShowMondayinApptCalendar'                   , Value);end;
procedure TPersonalPreferences.SetShowTuesdayinApptCalendar               (const Value: Boolean   ); begin SetBooleanField('ShowTuesdayinApptCalendar'                  , Value);end;
procedure TPersonalPreferences.SetShowWednesdayinApptCalendar             (const Value: Boolean   ); begin SetBooleanField('ShowWednesdayinApptCalendar'                , Value);end;
procedure TPersonalPreferences.SetShowThursdayinApptCalendar              (const Value: Boolean   ); begin SetBooleanField('ShowThursdayinApptCalendar'                 , Value);end;
procedure TPersonalPreferences.SetShowFridayinApptCalendar                (const Value: Boolean   ); begin SetBooleanField('ShowFridayinApptCalendar'                   , Value);end;
procedure TPersonalPreferences.SetShowSaturdayinApptCalendar              (const Value: Boolean   ); begin SetBooleanField('ShowSaturdayinApptCalendar'                 , Value);end;
procedure TPersonalPreferences.SetMinimumChargeAppointmentTime            (const Value: Integer   ); begin SetIntegerField('MinimumChargeAppointmentTime'               , Value);end;
{ TAppointmentPreferences }

constructor TAppointmentPreferences.Create(AOwner: TComponent);
var
  count, x: integer;
  PropList: PPropList;
  propName: string;
  PropInfo: PPropInfo;
  s:string;
begin
  inherited;
  Count := GetPropList(self.ClassInfo, tkProperties, nil);
  GetMem(PropList, Count * SizeOf(PPropInfo));
  try
    GetPropList(Self.ClassInfo, tkProperties, PropList);
    for x := 0 to Count -1 do begin
      s:= String(PropList[x].Name);
       if not sametext(s,'ApptStartTime')
      and not sametext(s,'ApptEndtime')
      and not sametext(s,'DefaultApptDuration')
      and not sametext(s,'RoundApptDurationTo')
      and not sametext(s,'ShowApptDurationin')
      and not sametext(s,'DefaultServiceProductID')
      and not sametext(s,'DefaultServiceProduct')
      and not sametext(s,'ShowSundayinApptCalendar')
      and not sametext(s,'ShowMondayinApptCalendar')
      and not sametext(s,'ShowTuesdayinApptCalendar')
      and not sametext(s,'ShowWednesdayinApptCalendar')
      and not sametext(s,'ShowThursdayinApptCalendar')
      and not sametext(s,'ShowFridayinApptCalendar')
      and not sametext(s,'ShowSaturdayinApptCalendar')
      and not sametext(s,'MinimumChargeAppointmentTime')
      and not sametext(s,'ID')
      and not sametext(s,'Globalref')
      and not sametext(s,'EmployeeID')
      and not sametext(s,'mstimestamp')
      and not sametext(s,'msupdatesitecode') then
        ExportExcludeList.Add(s);
    end;
  finally
    FreeMem(PropList, Count * SizeOf(PPropInfo));
  end;
end;
Function TAppointmentPreferences.getApptStartTime                           : String    ;
begin
  if trim(GetStringField('ApptStartTime'))='' then result := Appenv.companyprefs.ApptStartTime
  else result := inherited getApptStartTime;
end;
Function TAppointmentPreferences.getApptEndtime                             : String    ;
begin
  if trim(GetStringField('ApptEndtime'))='' then result := Appenv.companyprefs.ApptEndtime
  else result := inherited getApptEndtime;
end;
Function TAppointmentPreferences.GetDefaultApptDuration                     : Integer   ;
begin
  result := inherited getDefaultApptDuration;
  if result = 0 then result := Appenv.companyprefs.DefaultApptDuration;
end;
Function TAppointmentPreferences.GetRoundApptDurationTo                     : Integer   ;
begin
  result := inherited getRoundApptDurationTo;
  if result = 0 then result := Appenv.companyprefs.RoundApptDurationTo;
end;
Function TAppointmentPreferences.GetShowApptDurationin                      : Integer   ;
begin
  result := inherited getShowApptDurationin;
  if result = 0 then result := Appenv.companyprefs.ShowApptDurationin;
end;
Function TAppointmentPreferences.GetDefaultServiceProductID                 : Integer   ;
begin
  result := inherited getDefaultServiceProductID;
  if result = 0 then result := Appenv.companyprefs.DefaultServiceProductID;
end;
initialization
  RegisterClass(TPersonalPreferences);
  RegisterClass(TAppointmentPreferences);
end.
