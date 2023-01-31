unit BusObjPayBase;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   27/03/07   1.00.01   RM   Initial Version.

       Paybase
        |____BenefitsBase
        |        |________PaysSuperannation
        |        |________PaysBenefitsUK
        |                       |______UKNICs
        |____PaysPayratesBase
        |        |________PaysPayratesUK
        |        |________PaysPayratesAUS
        |
        |____PaysAllowancesBase
        |        |________PaysAllownacesUK
        |        |________PaysAllowancesAUS
        |
        |____PaysDeductionsBase
        |        |_______PaysDeductionsUK
        |        |_______PaysDeductionsAUS
        |
        |____PaysLeave
        |____CommissionTypes
        |____PaySundriesBase
        |        |______PaySundriesUK
        |        |______PaySundriesAUS
        |____Payssplits
        |        |______PayssplitsUK
        |        |______PayssplitsAUS
        |
        |____EmployeeLeave
        |____LeaveAccruals
 }

interface
{$I ERP.inc}

uses BusObjBase, DB, Classes, BusObjEmployeeDetails,
    BusObjEmployeePayRates,BusObjPaysPayratesBASE,BusObjPaysLeave,BusObjLeaveAccruals,
    BusObjEmployeePaySettings,BusObjPaysDeductions,kbmMemTable,BusObjEmployeeLeave,{BusObjTaxBase,}
    BusObjBenefitsBase,tcTypes,MyAccess,ERPdbComponents,BusObjPaysAllowances,BusObjPayCommissionsBASE,
    BusObjCommissionTypes,BusObjPaysTransactions,BusObjTimesheet,
    BusObjPaySundriesBase,BusObjPayPaysplits, XMLDoc, XMLIntf, BusObjPayLine,
    BusObjTerminationSimple, PayTaxableTotalObj, BusObjPayTax, BusobjSTPRelated, BusObjPaysSuperannuation;


type
  TPayTotals = class(TObject)

  private
    foOwner: TObject;
    fdWages: double;
    fdWagesIncludedInSuper: double;
    fdAllowancesBeforeTax: double;
    fdAllowancesAfterTax: double;
    fdAllowancesIncludedInSuper: double;
    fdAllowances: double;
    fdTaxableSundries: double;
    fdTaxExemptSundries: double;

    fdSundries: double;
    fdCommissionBeforeTax: double;
    fdCommissionAfterTax: double;
    fdCommissionIncludedInSuper: double;
    fdCommission: double;
    fdSuperannuation: double;
    fdDeductionBeforeTax: double;
    fdDeductionAfterTax: double;
    fdDeduction: double;
    fdWorkplacegivingBeforeTax: double;
    fdWorkplacegivingAfterTax: double;
    fdWorkplacegiving: double;
    fdGross: double;
    fdGrossTaxable: double;
    fdFITWages: double;
    fdSocWages: double;
    fdMedWages: double;
    fdStateWages: double;
    fdGrossCDEP: double;
    fdTax: double;
    fdEmployeeNICs:double;
    fdEmployerNICs:double;
    fdNet: double;

    {YTD Totals}
    fdYTDWages: double;
    fdYTDAllowances: double;
    fdYTDSundries: double;
    fdYTDCommission: double;
    fdYTDSuperannuation: double;
    fdYTDDeduction: double;
    fdYTDWorkplacegiving: double;
    fdYTDGrossTaxable: double;
    fdYTDGross: double;
    fdYTDTax: double;
    fdYTDNet: double;
    fTaxableTotals: TTaxableTotalList;
    fCompanyTax: double;
    fdGrossExcludeAllowances: double;
    fdYTDGrossExcludeAllowances: double;
    fdYTDCDEPGross: double;

  public
    constructor Create(const Owner: TObject);
    destructor Destroy; override;
    procedure CalcTax;
    procedure Tax_PostToAccounts;
//    procedure Tax_UnPostToAccounts;
//    procedure NICs_PostToAccounts;
    property Owner: TObject read foOwner;
    property TaxableTotals: TTaxableTotalList read fTaxableTotals;
    property Wages: double read fdWages write fdWages;
    property WagesIncludedInSuper: double read fdWagesIncludedInSuper write fdWagesIncludedInSuper;
    property AllowancesBeforeTax: double read fdAllowancesBeforeTax write fdAllowancesBeforeTax;
    property AllowancesAfterTax: double read fdAllowancesAfterTax write fdAllowancesAfterTax;
    property AllowancesIncludedInSuper: double read fdAllowancesIncludedInSuper write fdAllowancesIncludedInSuper;
    property Allowances: double read fdAllowances write fdAllowances;
    property GrossExcludeAllowances: double read fdGrossExcludeAllowances write fdGrossExcludeAllowances;
    property TaxableSundries: double read fdTaxableSundries write fdTaxableSundries;
    property TaxExemptSundries : double read fdTaxExemptSundries write fdTaxExemptSundries;
    property Sundries: double read fdSundries write fdSundries;
    property CommissionBeforeTax: double read fdCommissionBeforeTax write fdCommissionBeforeTax;
    property CommissionAfterTax: double read fdCommissionAfterTax write fdCommissionAfterTax;
    property CommissionIncludedInSuper: double read fdCommissionIncludedInSuper write fdCommissionIncludedInSuper;
    property Commission: double read fdCommission write fdCommission;
    property Superannuation: double read fdSuperannuation write fdSuperannuation;
    property DeductionBeforeTax: double read fdDeductionBeforeTax write fdDeductionBeforeTax;
    property DeductionAfterTax: double read fdDeductionAfterTax write fdDeductionAfterTax;
    property Deduction: double read fdDeduction write fdDeduction;
    property WorkplacegivingBeforeTax: double read fdWorkplacegivingBeforeTax write fdWorkplacegivingBeforeTax;
    property WorkplacegivingAfterTax: double read fdWorkplacegivingAfterTax write fdWorkplacegivingAfterTax;
    property Workplacegiving: double read fdWorkplacegiving write fdWorkplacegiving;
    property Gross: double read fdGross write fdGross;
    property GrossTaxable: double read fdGrossTaxable write fdGrossTaxable;
    property FITWages: double read fdFITWages write fdFITWages;
    property SocWages: double read fdSocWages write fdSocWages;
    property MedWages: double read fdMedWages write fdMedWages;
    property StateWages: double read fdStateWages write fdStateWages;
    property GrossCDEP: double read fdGrossCDEP write fdGrossCDEP;
    property Tax: double read fdTax write fdTax;
    property CompanyTax: double read fCompanyTax write fCompanyTax;

    property EmployeeNICs: double read fdEmployeeNICs write fdEmployeeNICs;
    property EmployerNICs: double read fdEmployerNICs write fdEmployerNICs;

    property Net: double read fdNet write fdNet;
    property YTDWages: double read fdYTDWages write fdYTDWages;
    property YTDAllowances: double read fdYTDAllowances write fdYTDAllowances;
    property YTDGrossExcludeAllowances: double read fdYTDGrossExcludeAllowances write fdYTDGrossExcludeAllowances;
    property YTDSundries: double read fdYTDSundries write fdYTDSundries;
    property YTDCommission: double read fdYTDCommission write fdYTDCommission;
    property YTDSuperannuation: double read fdYTDSuperannuation write fdYTDSuperannuation;
    property YTDDeduction: double read fdYTDDeduction write fdYTDDeduction;
    property YTDWorkplacegiving: double read fdYTDWorkplacegiving write fdYTDWorkplacegiving;
    property YTDGross: double read fdYTDGross write fdYTDGross;
    property YTDGrossTaxable: double read fdYTDGrossTaxable write fdYTDGrossTaxable;
    property YTDTax: double read fdYTDTax write fdYTDTax;
    property YTDNet: double read fdYTDNet write fdYTDNet;
    property YTDCDEPGross: double read fdYTDCDEPGross write fdYTDCDEPGross;

  end;

type
   Tpaybase = class(TMSBusObj)

   private
      fLoadingEmployeeSuper     :Boolean;
      fValidationDisabled       :Boolean;
      fPayPayRatesObj           :Tpayspayrates;
      fEmployeePaySettingsObj   :Temployeepaysettings;
      fBenefitsObj              :TBenefitsBase; //AUS  super  ,UK Benefits/Expenses
      fPayCommissionsObj        :TPaysCommission;
      fPaysDeductionsObj        :Tpaysdeductions;
      fPaysAllowancesObj        :Tpaysallowances;
      fSUMPayAllowanceForSTP    :TSUMPayAllowanceForSTP;
      fSUMPayTopUptoJobKeepersAllowanceForSTP    :TSUMPayTopUptoJobKeepersAllowanceForSTP;
      fSUMPayDeductionForSTP    :TSUMPayDeductionForSTP;
      fPayLeavesObj             :TPaysleave ;
      fCommissionTypesObj       :Tcommissiontypes;
      fLeaveAccrualsObj         :Tleaveaccruals;
      fPaySundriesObj           :Tpayssundries;
      fPayPaysplitsObj          :Tpayssplits;
      fEmployeeLeaveObj         :Tleave;
      fTimesheetObj             :TTimesheet;

      fEmployeeDetails          :Temployeedetails;
      fEmployeePayRates         :Temployeepayrates;

      fPayTransObj               :Tpaystransactions;
      fPayTotals                :TPayTotals;
      fRecalcInProgress         :Boolean;
      fPayFromDate              :TDateTime;
      fbCreatingNewPay          :boolean;
      fCreateRegion             :string;

      fEmployeeNICsTotal        :double;
      fEmployerNICsTotal        :double;
      fbIsPayVerify             :Boolean;
      fbAllLinesValid           :Boolean;
      Procedure CallbackSave(Const Sender: TBusObj; var Abort: boolean);
//      procedure UnPostToAccounts;
      Function GetPayID                       :Integer;
      Function GetEmployeeid                  :Integer   ;
      Function GetPaydate                     :TDatetime ;
      Function GetDatepaid                    :TDatetime ;
      Function GetPayperiods                  :Integer   ;
      Function GetWages                       :Double    ;
      Function GetCommission                  :Double    ;
      Function GetDeductions                  :Double    ;
      Function GetWorkplacegiving             :Double    ;
      Function GetAllowances                  :Double    ;
      Function GetAllowancesbeforetax         :Double    ;
      Function GetSundries                    :Double    ;
      Function GetSuperannuation              :Double    ;
      Function GetGross                       :Double    ;
      Function GetGrosstaxable                :Double    ;
      Function GetFITWages                    :Double    ;
      Function GetSocWages                    :Double    ;
      Function GetMedWages                    :Double    ;
      Function GetStateWages                  :Double    ;
      Function GetTax                         :Double    ;
      Function GetNet                         :Double    ;
      Function GetPay                         :Boolean   ;
      Function GetPaid                        :Boolean   ;
      Function GetPrinted                     :Boolean   ;
      Function GetEmpname                     :String    ;
      Function GetLeaveloading                :Double    ;
      Function GetClassID                     :Integer   ;
      Function GetClass                       :String    ;
      Function GetIstimesheet                 :Boolean   ;
      Function GetPayperiod                   :String    ;
      Function GetAnnualleaverate             :Double    ;
      Function GetCdepgross                   :Double    ;
      Function GetLumpa                       :Double    ;
      Function GetLumpb                       :Double    ;
      Function GetLumpd                       :Double    ;
      Function GetLumpe                       :Double    ;
      Function GetEtp                         :Double    ;
      Function GetManualtax                   :Boolean   ;
      Function GetDeleted                     :Boolean   ;
      Function GetIsnewtypepay                :Boolean   ;
      Function GetPaysuperonleaveloading      :Boolean   ;
      Function GetPayversion                  :Integer   ;
      Function GetPaynotes                    :String    ;
      Function GetPayxmldata                  :String    ;
      Function GetPrepared                    :Boolean   ;
      Function GetCountryCode                 :String    ;
      Function GetUKTaxCodeUsed               :String    ;
      Function GetNICsClass1                  :Double    ;
      Function GetNICsOther                   :Double    ;
      Function GetRegion                      :String;

      Function GetEmployerNICsClass1          :Double    ;
      Function GetEmployerNICsOther           :Double    ;
      Function GetTopUptoJobKeepersAllowance  :Double    ;

      Procedure SetEmployeeid                  (Const Value :Integer   );
      Procedure SetPaydate                     (Const Value :TDatetime );
      Procedure SetDatepaid                    (Const Value :TDatetime );
      Procedure SetPayperiods                  (Const Value :Integer   );
      Procedure SetWages                       (Const Value :Double    );
      Procedure SetCommission                  (Const Value :Double    );
      Procedure SetDeductions                  (Const Value :Double    );
      Procedure SetWorkplacegiving             (Const Value :Double    );
      Procedure SetAllowances                  (Const Value :Double    );
      Procedure SetAllowancesbeforetax         (Const Value :Double    );
      Procedure SetSundries                    (Const Value :Double    );
      Procedure SetSuperannuation              (Const Value :Double    );
      Procedure SetGross                       (Const Value :Double    );
      Procedure SetGrosstaxable                (Const Value :Double    );
      Procedure SetFITWages                    (Const Value :Double    );
      Procedure SetSocWages                    (Const Value :Double    );
      Procedure SetMedWages                    (Const Value :Double    );
      Procedure SetStateWages                  (Const Value :Double    );
      Procedure SetTax                         (Const Value :Double    );
      Procedure SetNet                         (Const Value :Double    );
      Procedure SetPay                         (Const Value :Boolean   );
      Procedure SetPaid                        (Const Value :Boolean   );
      Procedure SetPrinted                     (Const Value :Boolean   );
      Procedure SetEmpname                     (Const Value :String    );
      Procedure SetLeaveloading                (Const Value :Double    );
      Procedure setClassID                     (Const Value :Integer   );
      Procedure SetClass                       (Const Value :String    );
      Procedure SetIstimesheet                 (Const Value :Boolean   );
      Procedure SetPayperiod                   (Const Value :String    );
      Procedure SetAnnualleaverate             (Const Value :Double    );
      Procedure SetCdepgross                   (Const Value :Double    );
      Procedure SetLumpa                       (Const Value :Double    );
      Procedure SetLumpb                       (Const Value :Double    );
      Procedure SetLumpd                       (Const Value :Double    );
      Procedure SetLumpe                       (Const Value :Double    );
      Procedure SetEtp                         (Const Value :Double    );
      Procedure SetManualtax                   (Const Value :Boolean   );
      Procedure SetDeleted                     (Const Value :Boolean   );
      Procedure SetIsnewtypepay                (Const Value :Boolean   );
      Procedure SetPaysuperonleaveloading      (Const Value :Boolean   );
      Procedure SetPayversion                  (Const Value :Integer   );
      Procedure SetPaynotes                    (Const Value :String    );
      Procedure SetPayxmldata                  (Const Value :String    );
      Procedure SetPrepared                    (Const Value :Boolean   );
      Procedure SetNICsClass1                  (Const Value :double    );
      Procedure SetNICsOther                   (Const Value :double    );
      Procedure SetTopUptoJobKeepersAllowance  (Const Value :Double    );

      Procedure SetEmployerNICsClass1          (Const Value :double    );
      Procedure SetEmployerNICsOther           (Const Value :double    );

      Procedure SetCountryCode                 (Const Value :String    );
      Procedure SetUKTaxCodeUsed               (Const Value :String    );
      Procedure SetRegion                     (Const Value :String    );
      procedure LoadPayTotals;
      function GetEmployeeDetails:TEmployeeDetails;
      procedure SetEmployeeDetails(Const Value:Temployeedetails);
      function GetEmployeePayrates:Temployeepayrates;
      procedure SetEmployeePayrates(Const Value:Temployeepayrates);
      function GetPayTotals:TPayTotals;
      procedure SetPayTotals(Const Value:TPayTotals);
      procedure SetPayTotalsValues;

      procedure CallbackLoadPayrateTotals(const Sender: TBusObj; var Abort: Boolean);
//      procedure CallbackLoadDeductionsTotals(const Sender: TBusObj; var Abort: Boolean);
      procedure CallbackLoadAllowancesTotals(const Sender: TBusObj; var Abort: Boolean);
      procedure CallbackLoadCommissionTotals(const Sender: TBusObj; var Abort: Boolean);
      procedure CallbackLoadSundriesTotals(const Sender: TBusObj; var Abort: Boolean);
      procedure AdjustUnProcessedPayPayDate(EmployeeLastPayDate:TDateTime);
      Function GetTaxableTotals                :Double;
      Function GetPayFromDate                  :TDateTime;
    function GetLines: TPayLine;
    function GetTermination: TTerminationSimple;
    function GetIsTermination: Boolean;
    procedure SetIsTermination(const Value: Boolean);
    function GetPayTax: TPayTax;
     procedure SetCompanyTax(value: double);
     function GetCompanyTax: double;
    function GetPayRunID: integer;
    procedure SetPayRunID(const Value: integer);
    function GetPayPeriodStartDate: TDateTime;
    function GetGrossExcludeAllowances: Double;
    procedure SetGrossExcludeAllowances(const Value: Double);
    function GetSUMPayAllowanceForSTP(aDate: TDateTime): TSUMPayAllowanceForSTP;
    function GetSUMPayTopUptoJobKeepersAllowanceForSTP(aDate: TDateTime): TSUMPayTopUptoJobKeepersAllowanceForSTP;
    function GetSUMPayDeductionForSTP(aDate: TDateTime): TSUMPayDeductionForSTP;

    procedure Burden_PostToAccounts;

   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;

      Function GetIsList: Boolean; Override;

   Public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor Create(AOwner: TComponent); overload; override;
      constructor Create(AOwner: TComponent;aRegion:string;PassedConnection:TERPConnection); reintroduce; overload;
      constructor Create(AOwner: TComponent;iPayID:integer;PassedConnection:TERPConnection); reintroduce; overload;
      Destructor   Destroy;  override;
      procedure Initialise;
      procedure DoFieldOnChange(Sender: TField);                           Override;

      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;

      procedure Load(Const aId: integer;const fIsReadonly:boolean =False); override;
      procedure RecalcAll;
      procedure PostToAccounts;
      procedure AddLeavesToPay;
      procedure DeletePay;
      procedure UnDeletePay;
      procedure RefreshAllDBs;
      function VerifyBanking:Boolean;

      function GetIncomeStreamType: String;

      function GetSuperannuationObj: TPaysSuperannuation;
      function GetAllowancesObj: Tpaysallowances;

      procedure CreateAndConnectSubObjs;

      function GetPayPeriodStartDatePaid: TDateTime;



      //tblpays properties ==========================================================================

   published
     Property PayID                        :Integer      Read getPayID;
      Property Employeeid                   :Integer      Read getEmployeeid                Write SetEmployeeid            ;
      Property PayDate                      :TDatetime    Read getPaydate                   Write SetPaydate               ;
      property PayPeriodStartDate: TDateTime read GetPayPeriodStartDate;
      Property DatePaid                     :TDatetime    Read getDatepaid                  Write SetDatepaid              ;
      Property Payperiods                   :Integer      Read getPayperiods                Write SetPayperiods            ;
      Property Wages                        :Double       Read getWages                     Write SetWages                 ;
      Property Commission                   :Double       Read getCommission                Write SetCommission            ;
      Property Deductions                   :Double       Read getDeductions                Write SetDeductions            ;
      Property Workplacegiving              :Double       Read getWorkplacegiving           Write SetWorkplacegiving       ;
      Property Allowances                   :Double       Read getAllowances                Write SetAllowances            ;
      { this is a total of allowances that have  DisplayIn = "Allowance"
        ie allowances that are going to be showen seperatly on Summary Report }
      Property GrossExcludeAllowances: Double Read GetGrossExcludeAllowances Write SetGrossExcludeAllowances;
      Property Allowancesbeforetax          :Double       Read getAllowancesbeforetax       Write SetAllowancesbeforetax   ;
      Property Sundries                     :Double       Read getSundries                  Write SetSundries              ;
      Property Superannuation               :Double       Read getSuperannuation            Write SetSuperannuation        ;
      Property Gross                        :Double       Read getGross                     Write SetGross                 ;
      Property Grosstaxable                 :Double       Read getGrosstaxable              Write SetGrosstaxable          ;
      Property FITWages                     :Double       Read GetFITWages                  Write SetFITWages              ;
      Property SocWages                     :Double       Read GetSocWages                  Write SetSocWages              ;
      Property MedWages                     :Double       Read GetMedWages                  Write SetMedWages              ;
      Property StateWages                   :Double       Read GetMedWages                  Write SetStateWages            ;
      Property Tax                          :Double       Read getTax                       Write SetTax                   ;
      property CompanyTax: double read GetCompanyTax write SetCompanyTax;
      Property Net                          :Double       Read getNet                       Write SetNet                   ;
      Property Pay                          :Boolean      Read getPay                       Write SetPay                   ;
      Property Paid                         :Boolean      Read getPaid                      Write SetPaid                  ;
      Property Printed                      :Boolean      Read getPrinted                   Write SetPrinted               ;
      Property Empname                      :String       Read getEmpname                   Write SetEmpname               ;
      Property Leaveloading                 :Double       Read getLeaveloading              Write SetLeaveloading          ;
      Property Classid                      :Integer      Read GetClassID                   Write setClassID               ;
      Property Department                   :String       Read getClass                     Write SetClass                 ;
      Property Istimesheet                  :Boolean      Read getIstimesheet               Write SetIstimesheet           ;
      Property Payperiod                    :String       Read getPayperiod                 Write SetPayperiod             ;
      Property Annualleaverate              :Double       Read getAnnualleaverate           Write SetAnnualleaverate       ;
      Property Cdepgross                    :Double       Read getCdepgross                 Write SetCdepgross             ;
      Property Lumpa                        :Double       Read getLumpa                     Write SetLumpa                 ;
      Property Lumpb                        :Double       Read getLumpb                     Write SetLumpb                 ;
      Property Lumpd                        :Double       Read getLumpd                     Write SetLumpd                 ;
      Property Lumpe                        :Double       Read getLumpe                     Write SetLumpe                 ;
      Property Etp                          :Double       Read getEtp                       Write SetEtp                   ;
      Property Manualtax                    :Boolean      Read getManualtax                 Write SetManualtax             ;
      Property Deleted                      :Boolean      Read getDeleted                   Write SetDeleted               ;
      Property Isnewtypepay                 :Boolean      Read getIsnewtypepay              Write SetIsnewtypepay          ;
      Property Paysuperonleaveloading       :Boolean      Read getPaysuperonleaveloading    Write SetPaysuperonleaveloading;
      Property Payversion                   :Integer      Read getPayversion                Write SetPayversion            ;
      Property Paynotes                     :String       Read getPaynotes                  Write SetPaynotes              ;
      Property Payxmldata                   :String       Read getPayxmldata                Write SetPayxmldata            ;
      Property Prepared                     :Boolean      Read getPrepared                  Write SetPrepared              ;
      Property CountryCode                  :String       Read getCountryCode               Write SetCountryCode           ;
      Property UKTaxCodeUsed                :String       Read getUKTaxCodeUsed             Write SetUKTaxCodeUsed         ;
      Property EmployeeNICsClass1                   :Double       Read getNICsClass1                Write SetNICsClass1                  ;
      Property EmployeeNICsOther                    :Double       Read getNICsOther                 Write SetNICsOther                  ;

      Property EmployerNICsClass1           :Double       Read getEmployerNICsClass1        Write SetEmployerNICsClass1                  ;
      Property EmployerNICsOther            :Double       Read getEmployerNICsOther         Write SetEmployerNICsOther                  ;
      property Region                       :string       Read GetRegion                    write SetRegion ;
      property IsPayVerify                  :Boolean      read fbIsPayVerify                write fbIsPayVerify;
      Property ValidationDisabled           :Boolean      read fValidationDisabled          write fValidationDisabled;
      Property IsTermination                :Boolean      read GetIsTermination              write SetIsTermination;

   Public
      // Objects =====================================================================================
      property EmployeeDetails      :Temployeedetails     Read GetEmployeeDetails       write  SetEmployeeDetails ;
      property EmployeePaySettings  :Temployeepaysettings Read fEmployeePaySettingsObj  write  fEmployeePaySettingsObj;
      property EmployeePayRates     :Temployeepayrates    Read GetEmployeePayrates      write  SetEmployeePayRates ;
      property EmployeeLeave        :Tleave               Read fEmployeeLeaveObj        write  fEmployeeLeaveObj ;
      property CommissionTypes      :Tcommissiontypes     Read fCommissionTypesObj      write  fCommissionTypesObj;
      property TimeSheet            :TTimeSheet           Read fTimeSheetObj            write fTimeSheetObj;

      property PayLeaves            :TPaysLeave           Read fPayLeavesObj            write  fPayLeavesObj ;
      property PayCommissions       :Tpayscommission      Read fPayCommissionsObj       write  fPayCommissionsObj;
      property LeaveAccruals        :TLeaveaccruals       Read fLeaveAccrualsObj        write  fLeaveAccrualsObj ;
      property PaySundries          :Tpayssundries        Read fPaySundriesObj          write  fPaySundriesObj;
      property PayPaysplits         :Tpayssplits          Read fPayPaysplitsObj         write  fPayPaysplitsObj;
      property PayTrans             :Tpaystransactions    Read fPayTransObj             write  fPayTransObj;
      property PayTotals            :TPayTotals           read GetPayTotals             write  SetPayTotals;
      property PayTax               :TPayTax              read GetPayTax;

      property TaxableTotals                :Double       Read getTaxableTotals;
      property PayFromDate                  :TDateTime    Read getPayFromDate;

      property EmployeeNICsTotal:double read fEmployeeNICsTotal write fEmployeeNICsTotal;
      property EmployerNICsTotal:double read fEmployerNICsTotal write fEmployerNICsTotal;


      property RecalcInProgress             :Boolean      Read fRecalcInProgress write fRecalcInProgress;
      Property CreatingNewPay               :boolean      Read fbCreatingNewPay  Write fbCreatingNewPay;
      Property LoadingEmployeeSuper         :boolean      Read fLoadingEmployeeSuper     Write fLoadingEmployeeSuper;
      Property TopUptoJobKeepersAllowance   :Double       Read getTopUptoJobKeepersAllowance   Write SetTopUptoJobKeepersAllowance ;

      property PaysPayRates     :Tpayspayrates  Read fPayPayratesObj    write fPayPayRatesObj ;
      property PayBenefits      :TBenefitsBase  Read fBenefitsObj       write fBenefitsObj ;
      property PayDeductions   :Tpaysdeductions Read fPaysDeductionsObj write fPaysDeductionsObj ;
      property PayAllowances   :Tpaysallowances Read fPaysAllowancesObj write fPaysAllowancesObj;


 //  Public
      property SUMPayAllowanceForSTP[aDate: TDateTime] : TSUMPayAllowanceForSTP read GetSUMPayAllowanceForSTP;
      property SUMPayTopUptoJobKeepersAllowanceForSTP[aDate: TDateTime] : TSUMPayTopUptoJobKeepersAllowanceForSTP read GetSUMPayTopUptoJobKeepersAllowanceForSTP;
      property SUMPayDeductionForSTP[aDate: TDateTime] : TSUMPayDeductionForSTP read GetSUMPayDeductionForSTP;
      property Termination: TTerminationSimple read GetTermination;
      property Lines: TPayLine read GetLines;
      property PayRunID: integer read GetPayRunID write SetPayRunID;

   End;

type
  TPayHistory = class(Tpaybase)

 end;


implementation

uses tcDataUtils, SysUtils,DnMLib,Dialogs,Controls,PayCommon,AppEnvironment,
     BusObjTaxAUS,BusObjPaysPayratesAUS,
     BusObjEmpPaySettingsAUS,
     BusObjPaysDeductionsAUS,DateUtils,
     BusObjPaysAllowancesAUS,BusObjPayLeavesAUS,
     BusObjPaySundriesAUS,BusObjPayPaysplitsAUS,
  BusObjPayCommissionsAUS, CommonLib, MySQLConst, BusObjConst, BusObjPayRun,
  PayPreferencesObj, BusObjLeavetypes, Variants, PayAccounts,
  DbSharedObjectsObj, CommonDbLib, PayConst, DateTimeUtils;

{========================================================
         Tpays
========================================================}

constructor Tpaybase.Create(AOwner: TComponent;aRegion: string;PassedConnection:TERPConnection);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblpays';
  fCreateRegion := aRegion;
  Connection  := TMyDacDataConnection.Create(Self);
  TMyDacDataConnection(Connection).MydacConnection  := PassedConnection;
  fSUMPayAllowanceForSTP := nil;
  fSUMPayTopUptoJobKeepersAllowanceForSTP := nil;
  fSUMPayDeductionForSTP := nil;
  CreateAndConnectSubObjs;
end;

Function TPaybase.GetIsList: Boolean;
Begin
  Result := Inherited;
  if not result then
  	if assigned(Owner) then
  		if owner is TPayrun then
  			Result := True;
End;

procedure Tpaybase.CreateAndConnectSubObjs;
begin
   if Assigned(fPayPayRatesObj) then
    if PaysPayRates.PayId = Id then
      exit;
    if assigned(fPayPayRatesObj)          then Freeandnil(fPayPayRatesObj);
    if assigned(fEmployeePaySettingsObj)  then Freeandnil(fEmployeePaySettingsObj);
    if assigned(fBenefitsObj)             then Freeandnil(fBenefitsObj);
    if assigned(fPaysDeductionsObj)       then Freeandnil(fPaysDeductionsObj);
    if assigned(fPaysAllowancesObj)       then Freeandnil(fPaysAllowancesObj);
    if assigned(fPayLeavesObj)            then Freeandnil(fPayLeavesObj);
    if assigned(fPayCommissionsObj)       then Freeandnil(fPayCommissionsObj);
    if assigned(fPaySundriesObj)          then Freeandnil(fPaySundriesObj);
    if assigned(fPayPaysplitsObj)         then Freeandnil(fPayPaysplitsObj);
    if assigned(fCommissionTypesObj)      then Freeandnil(fCommissionTypesObj);
    if assigned(fLeaveAccrualsObj)        then Freeandnil(fLeaveAccrualsObj);
    if assigned(fEmployeeLeaveObj)        then Freeandnil(fEmployeeLeaveObj);
    if assigned(fPayTransObj)             then Freeandnil(fPayTransObj);
    if assigned(fTimeSheetObj)            then Freeandnil(fTimeSheetObj);
    if assigned(fPayPayRatesObj)          then Freeandnil(fPayPayRatesObj);
    if assigned(fPayPayRatesObj)          then Freeandnil(fPayPayRatesObj);
    if assigned(fPayPayRatesObj)          then Freeandnil(fPayPayRatesObj);

   fPayPayRatesObj            := TpayspayratesAUS.Create(Self);
   fEmployeePaySettingsObj    := TEmpPaySettingsAUS.Create(Self);

   if AppEnv.RegionalOptions.RegionType <> rAUST then begin

   end
   else begin
     fBenefitsObj               := Tpayssuperannuation.Create(Self);
   end;

   fPaysDeductionsObj         := TpaysdeductionsAUS.Create(Self);
   fPaysAllowancesObj         := TpaysallowancesAUS.Create(Self);
   fPayLeavesObj              := TpayleavesAUS.Create(Self);
   fPayCommissionsObj         := TPayCommissionsAUS.Create(Self);
   fPaySundriesObj            := TPaySundriesAUS.Create(Self);
   fPayPaysplitsObj           := TpayssplitsAUS.Create(Self);

   fCommissionTypesObj          := Tcommissiontypes.Create(Self);
   fCommissionTypesObj.Connection  := Self.Connection;
   fCommissionTypesObj.SilentMode  := Self.SilentMode;

   fLeaveAccrualsObj               := Tleaveaccruals.Create(Self);
   fLeaveAccrualsObj.Connection    := Self.Connection;
   fLeaveAccrualsObj.SilentMode    := Self.SilentMode;

   fEmployeeLeaveObj               := Tleave.Create(Self);
   fEmployeeLeaveObj.Connection    := Self.Connection;
   fEmployeeLeaveObj.SilentMode    := Self.SilentMode;

   fPayTransObj                    := Tpaystransactions.Create(Self);
   fPayTransObj.Connection         := Self.Connection;
   fPayTransObj.SilentMode         := Self.SilentMode;

   fTimeSheetObj                   := TTimeSheet.Create(Self);
   fTimeSheetObj.Connection        := Self.Connection;
   fTimeSheetObj.SilentMode        := Self.SilentMode;


   fPayPayRatesObj.Connection   := Self.Connection;
   fPayPayRatesObj.SilentMode   := Self.SilentMode;
   fEmployeePaySettingsObj.Connection := Self.Connection;
   fEmployeePaySettingsObj.SilentMode := Self.SilentMode;
   fPaysDeductionsObj.Connection := Self.Connection;
   fPaysDeductionsObj.SilentMode := Self.SilentMode;
   fPaysAllowancesObj.Connection := Self.Connection;
   fPaysAllowancesObj.SilentMode := Self.SilentMode;
   if Assigned(fBenefitsObj) then begin
     fBenefitsObj.Connection       := Self.Connection;
     fBenefitsObj.SilentMode       := Self.SilentMode;
   end;
   fPayLeavesObj.Connection      := Self.Connection;
   fPayLeavesObj.SilentMode      := Self.SilentMode;
   fPayCommissionsObj.Connection := Self.Connection;
   fPayCommissionsObj.SilentMode := Self.SilentMode;
   fPaySundriesObj.Connection    := Self.Connection;
   fPaySundriesObj.SilentMode    := Self.SilentMode;
   fPayPaysplitsObj.Connection   := Self.Connection;
   fPayPaysplitsObj.SilentMode   := Self.SilentMode;



  if ConnectionAssigned and (Connection.connected) then
  begin
    EmployeeDetails.Load(0);
    EmployeePaySettings.LoadSelect('EmployeeID = 0');
    EmployeePayRates.LoadSelect('EmployeeID = 0' );
    PaysPayRates.LoadSelect('PayID = 0' );
    PayDeductions.LoadSelect('PayID = 0');
    PayAllowances.LoadSelect('PayID = 0');
    PayLeaves.LoadSelect('PayID = 0');
    LeaveAccruals.LoadSelect('EmployeeID =0');
    EmployeeLeave.LoadSelect('EmployeeID = 0');
//    PayBenefits.LoadSelect('PayID =0');
    PayCommissions.LoadSelect('PayID = 0');
    PaySundries.LoadSelect('PayID = 0');
    PayPaysplits.LoadSelect('PayID = 0');
    TimeSheet.LoadSelect('EmployeeID = 0');
    PayTrans.LoadSelect('PayID = 0');
  end;
end;

constructor Tpaybase.Create(AOwner: TComponent;iPayID:integer;PassedConnection:TERPConnection);
var
  strsql:string;
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblpays';
  strsql := 'SELECT PayID,Region FROM tblpays WHERE PayID = ' + IntToStr(iPayID);
  Connection  := TMyDacDataConnection.Create(Self);
  TMyDacDataConnection(Connection).MydacConnection  := PassedConnection;
  CreateAndConnectSubObjs;
  fSUMPayAllowanceForSTP := nil;
  fSUMPayTopUptoJobKeepersAllowanceForSTP := nil;
  fSUMPayDeductionForSTP := nil;

  With GetNewDataSet(strsql, True) do begin
    try
      fCreateRegion  :=  fieldByname('Region').AsString;
    finally
      if active then close;
      Free;
    end;
  end;



//  CreateAndConnectSubObjs;
end;

constructor Tpaybase.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblpays';
   CreateAndConnectSubObjs;
   fSUMPayAllowanceForSTP := nil;
   fSUMPayTopUptoJobKeepersAllowanceForSTP := nil;
   fSUMPayDeductionForSTP := nil;
end;

procedure Tpaybase.RefreshAllDBs;
begin
   fPayPayRatesObj.RefreshDB;
   fEmployeePaySettingsObj.RefreshDB;
   if Assigned(fBenefitsObj) then begin
     fBenefitsObj.RefreshDB;
   end;
   fPaysDeductionsObj.RefreshDB;
   fPaysAllowancesObj.RefreshDB;
   fPayLeavesObj.RefreshDB;
   fPayCommissionsObj.RefreshDB;
   fCommissionTypesObj.RefreshDB;
   fPaySundriesObj.RefreshDB;
   fPayPaysplitsObj.RefreshDB;
   fEmployeeLeaveObj.RefreshDB;
end;

procedure TPaybase.RecalcAll;

  procedure AddLumpSumDComment(val: double);
  var
    sl: TStringList;
    x: integer;
  begin
    if self.Paynotes = '' then begin
      if val > 0 then
        self.Paynotes := 'Termination Lump Sum D: ' + FormatFloat('$#,##0.00;($#,##0.00)',val) + #13#10;
    end
    else begin
      sl := TStringList.Create;
      try
        sl.Text := self.Paynotes;
        for x := 0 to sl.Count -1 do begin
          if Pos('termination lump sum d',Lowercase(sl[x])) > 0 then begin
            if val <> 0 then
              sl[x] := 'Termination Lump Sum D: ' + FormatFloat('$#,##0.00;($#,##0.00)',val)
            else
              sl.Delete(x);
            self.Paynotes := SL.Text;
            exit;
          end;
        end;
        if val <> 0 then begin
          sl.Add('Termination Lump Sum D: ' + FormatFloat('$#,##0.00;($#,##0.00)',val));
          self.Paynotes := SL.Text;
        end;
      finally
        sl.Free;
      end;
    end;
  end;

begin
  if Self.RecalcInProgress = True then exit;
  Self.RecalcInProgress := True;

  Self.PaysPayRates.ReCalc;

  if self.Termination.Count > 0 then begin
    self.Lumpd := Termination.LumpSumD;
    AddLumpSumDComment(Termination.LumpSumD);
  end
  else begin
    self.Lumpd := 0;
    AddLumpSumDComment(0);
  end;

  LoadPayTotals;

  SetPayTotalsValues;
  Gross  := Self.PayTotals.Gross;

  Deductions      := Self.PayDeductions.TotalDeductions;
  Workplacegiving := Self.PayDeductions.TotalWPGiving;
  Allowances      := Self.PayAllowances.TotalAllowances;
  GrossExcludeAllowances := Self.PayAllowances.TotalGrossExcludeAllowances;
  Commission      :=  Self.PayCommissions.TotalGross;
  Sundries        := Self.PaySundries.TotalSundries;

  if AppEnv.RegionalOptions.RegionType <> rAUST then  begin
    Superannuation := 0;
  end
  else begin
    if Self.Paid then begin
      Superannuation := tpayssuperannuation(Self.PayBenefits).TotalSuper;

    end else begin
      Self.PayBenefits.ReCalc;
      Superannuation := tpayssuperannuation(Self.PayBenefits).TotalSuper;
    end;
    //if super = 0 cause of thresholds or whatever set the payssuperannuation recs amountpaid to zero
    if Superannuation < 1 then begin

    end;
  end;

  Self.SetPayTotalsValues;  //again cause super might have changed the gross

  Gross  := Self.PayTotals.Gross;
  GrossTaxable  := Self.PayTotals.GrossTaxable;
  FITWages := Self.PayTotals.FITWages;
  SocWages := Self.PayTotals.SocWages;
  MedWages := Self.PayTotals.MedWages;
  StateWages := Self.PayTotals.StateWages;
  Tax := Self.PayTotals.Tax;
  CompanyTax := PayTotals.CompanyTax;
  Net := Self.Paytotals.Net;

  //round all to 2 dec places
  Gross := RoundCurrency(Gross);
  GrossTaxable := RoundCurrency(GrossTaxable);
  Tax   := RoundCurrency(Tax);
  CompanyTax := RoundCurrency(CompanyTax);

  self.RecalcInProgress := False;
end;

procedure Tpaybase.PostToAccounts;
var
  CreditAccountId: integer;
  DebitAccountId: integer;
begin
//  LoadPayTotals;
////  Self.PayTotals.CalcTax;
//  PayTax.CalculateTax;

  Self.PaysPayRates.PostToAccounts;
  Self.PayDeductions.PostToAccounts;
  Self.PayAllowances.PostToAccounts;
  Self.PaySundries.PostToAccounts;
  Self.PayCommissions.PostToAccounts;

  if AppEnv.RegionalOptions.RegionType <> rAUST then begin
    { no super in other countries }
  end
  else begin
    Self.PayBenefits.PostToAccounts;

    { Lump Sum D }
    if self.Lumpd > 0 then begin
      CreditAccountId:= PayAccounts.BankAccountID(self.Employeeid);
      DebitAccountId:= PayAccounts.LumpSumDPaidAccountID(self.Employeeid);

      PayTrans.LoadSelect('PayID = ' + IntToStr(PayID) +
                     ' AND Type = ' + '"Payroll Nett Wages" AND MSType = "'+MSType_NetWages+'" ' +
                     ' AND Description = "Nett Wages - Lump Sum D"' +
                     ' AND PayLineID = ' + IntToStr(ID));


      PayTrans.PostToPaysTransactions(22,'Payroll Nett Wages', MSType_NetWages,
                     'Nett Wages - Lump Sum D',
                     CreditAccountId,DebitAccountId,
                     ClassID, ID,LumpD, self);
    end;

  end;

  Self.PayLeaves.PostToAccounts;  //leave taken
  Self.LeaveAccruals.PostToAccounts;

//  if not Self.IsTermination then Self.LeaveAccruals.PostToAccounts;

  PostList.Execute;

//  LoadPayTotals;
  Self.SetPayTotalsValues;

  Self.PayTotals.Tax_PostToAccounts;

  // By Wang 2022-04-22
  Self.Burden_PostToAccounts;
end;

procedure Tpaybase.AddLeavesToPay;
begin
  Self.PaysPayRates.AllowRecalc := False;
  Self.PayLeaves.UpdatePayRatesWithLeaves;
  Self.PaysPayRates.AllowRecalc := True;
end;

function Tpaybase.VerifyBanking:Boolean;
var
  dAmount:double;
begin {checks if bank amounts greater than net and gives warning}
  Result := True;
  dAmount := 0;
  self.PayPaysplits.First;
  while not self.PayPaysplits.EOF do begin
    if self.PayPaysplits.SplitType = '$' then dAmount := dAmount + self.PayPaysplits.Amount;
    self.PayPaysplits.Next;
  end;
  if dAmount > Self.Net then begin
    Self.PayPaysplits.AdjustBanking;
    Sendevent(BusObjEvent_Change,BusObjEventVal_BankSplitsError);
    Result := False;
  end;
end;

procedure Tpaybase.Initialise;
begin
  Self.RecalcAll;
end;

procedure Tpaybase.Load(Const aId: integer;const fIsReadonly:boolean =False);

function LoadPayREadonly:Boolean;
begin
  result := false;
  (*if APIMode then result := false
  else Result :=fIsReadonly;*)
end;
begin
  inherited Load(aid, LoadPayREadonly(*fIsReadonly*) ); // read as NOT readonly as it does the calculations
  EmployeeDetails.Load(EmployeeID);
  EmployeePaySettings.LoadSelect('EmployeeID = ' + IntToStr(EmployeeID));
  EmployeePayRates.LoadSelect('EmployeeID = ' + IntToStr(EmployeeID));
  PaysPayRates.LoadSelect('PayID = ' + IntToStr(aID));
  PayDeductions.LoadSelect('PayID = ' + IntToStr(aID));
  PayAllowances.LoadSelect('PayID = ' + IntToStr(aID));
  PayLeaves.LoadSelect('PayID = ' + IntToStr(aID));
  LeaveAccruals.LoadSelect('EmployeeID = ' + IntToStr(EmployeeID));
  EmployeeLeave.LoadSelect('EmployeeID = ' + IntToStr(EmployeeID));

  if AppEnv.RegionalOptions.RegionType <> rAUST then begin
    { no super in other countries }
  end
  else begin
    PayBenefits.LoadSelect('PayID = ' + IntToStr(aID));
    PayBenefits.ReCalc;
  end;

  PayCommissions.LoadSelect('PayID = ' + IntToStr(aID));
  PaySundries.LoadSelect('PayID = ' + IntToStr(aID));
  PayPaysplits.LoadSelect('PayID = ' + IntToStr(aID));
  TimeSheet.LoadSelect('EmployeeID = ' + IntToStr(EmployeeID) + ' AND TimeSheetDate BETWEEN ' + QuotedStr(FormatDateTime(MysqlDateFormat,PayCommon.PayFromDate(Self.Paydate,Self.Payperiod))) + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat,Self.Paydate)));

  CommissionTypes.Load; //load all
  PayTrans.LoadSelect('PayID = ' + IntToStr(aID));
  if CreatingNewPay then exit;
  LoadPayTotals;
  SetPayTotalsValues;
end;

procedure Tpaybase.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Employeeid');
  SetDateTimePropertyFromNode(Node,'Paydate');
  SetDateTimePropertyFromNode(Node,'Datepaid');
  SetPropertyFromNode(Node,'Payperiods');
  SetPropertyFromNode(Node,'Wages');
  SetPropertyFromNode(Node,'Commission');
  SetPropertyFromNode(Node,'Deductions');
  SetPropertyFromNode(Node,'Workplacegiving');
  SetPropertyFromNode(Node,'Allowances');
  SetPropertyFromNode(Node,'GrossExcludeAllowances');
  SetPropertyFromNode(Node,'Allowancesbeforetax');
  SetPropertyFromNode(Node,'Sundries');
  SetPropertyFromNode(Node,'Superannuation');
  SetPropertyFromNode(Node,'Gross');
  SetPropertyFromNode(Node,'Grosstaxable');
  SetPropertyFromNode(Node,'Tax');
  SetPropertyFromNode(Node,'Net');
  SetBooleanPropertyFromNode(Node,'Pay');
  SetBooleanPropertyFromNode(Node,'Paid');
  SetBooleanPropertyFromNode(Node,'Printed');
  SetPropertyFromNode(Node,'Empname');
  SetPropertyFromNode(Node,'Leaveloading');
  SetPropertyFromNode(Node,'Classid');
  SetPropertyFromNode(Node,'Class');
  SetBooleanPropertyFromNode(Node,'Istimesheet');
  SetPropertyFromNode(Node,'Payperiod');
  SetPropertyFromNode(Node,'Annualleaverate');
  SetPropertyFromNode(Node,'Cdepgross');
  SetPropertyFromNode(Node,'Lumpa');
  SetPropertyFromNode(Node,'Lumpb');
  SetPropertyFromNode(Node,'Lumpd');
  SetPropertyFromNode(Node,'Lumpe');
  SetPropertyFromNode(Node,'Etp');
  SetBooleanPropertyFromNode(Node,'Manualtax');
  SetBooleanPropertyFromNode(Node,'Deleted');
  SetBooleanPropertyFromNode(Node,'Isnewtypepay');
  SetBooleanPropertyFromNode(Node,'Paysuperonleaveloading');
  SetPropertyFromNode(Node,'Payversion');
  SetPropertyFromNode(Node,'Paynotes');
  SetPropertyFromNode(Node,'Payxmldata');
  SetBooleanPropertyFromNode(Node,'Prepared');
  SetPropertyFromNode(Node,'Region');
  SetBooleanPropertyFromNode(Node,'IsTermination');
  SetPropertyFromNode(Node,'TopUptoJobKeepersAllowance');
end;

procedure Tpaybase.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Employeeid' ,Employeeid);
  AddXMLNode(node,'Paydate' ,Paydate);
  AddXMLNode(node,'Datepaid' ,Datepaid);
  AddXMLNode(node,'Payperiods' ,Payperiods);
  AddXMLNode(node,'Wages' ,Wages);
  AddXMLNode(node,'Commission' ,Commission);
  AddXMLNode(node,'Deductions' ,Deductions);
  AddXMLNode(node,'Workplacegiving' ,Workplacegiving);
  AddXMLNode(node,'Allowances' ,Allowances);
  AddXMLNode(node,'GrossExcludeAllowances' ,GrossExcludeAllowances);
  AddXMLNode(node,'Allowancesbeforetax' ,Allowancesbeforetax);
  AddXMLNode(node,'Sundries' ,Sundries);
  AddXMLNode(node,'Superannuation' ,Superannuation);
  AddXMLNode(node,'Gross' ,Gross);
  AddXMLNode(node,'Grosstaxable' ,Grosstaxable);
  AddXMLNode(node,'Tax' ,Tax);
  AddXMLNode(node,'Net' ,Net);
  AddXMLNode(node,'Pay' ,Pay);
  AddXMLNode(node,'Paid' ,Paid);
  AddXMLNode(node,'Printed' ,Printed);
  AddXMLNode(node,'Empname' ,Empname);
  AddXMLNode(node,'Leaveloading' ,Leaveloading);
  AddXMLNode(node,'Classid' ,Classid);
  AddXMLNode(node,'Class' ,Department);
  AddXMLNode(node,'Istimesheet' ,Istimesheet);
  AddXMLNode(node,'Payperiod' ,Payperiod);
  AddXMLNode(node,'Annualleaverate' ,Annualleaverate);
  AddXMLNode(node,'Cdepgross' ,Cdepgross);
  AddXMLNode(node,'Lumpa' ,Lumpa);
  AddXMLNode(node,'Lumpb' ,Lumpb);
  AddXMLNode(node,'Lumpd' ,Lumpd);
  AddXMLNode(node,'Lumpe' ,Lumpe);
  AddXMLNode(node,'Etp' ,Etp);
  AddXMLNode(node,'Manualtax' ,Manualtax);
  AddXMLNode(node,'Deleted' ,Deleted);
  AddXMLNode(node,'Isnewtypepay' ,Isnewtypepay);
  AddXMLNode(node,'Paysuperonleaveloading' ,Paysuperonleaveloading);
  AddXMLNode(node,'Payversion' ,Payversion);
  AddXMLNode(node,'Paynotes' ,Paynotes);
  AddXMLNode(node,'Payxmldata' ,Payxmldata);
  AddXMLNode(node,'Prepared' ,Prepared);
  AddXMLNode(node,'Region' ,Region);
  AddXMLNode(node,'IsTermination' ,IsTermination);
  AddXMLNode(node,'TopUptoJobKeepersAllowance' ,TopUptoJobKeepersAllowance);
end;

function Tpaybase.ValidateData :Boolean ;
//var
//  tmpResultStatus: TResultStatusItem;
begin
   Result := False;
   Resultstatus.Clear;
   Try
     if Employeeid = 0 then begin
        Resultstatus.AddItem(False , rssError , 0,  'Employeeid should not be 0'  );
        Exit;
     end;
     if Paydate = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeePay_Err_NoPaydate,  'Paydate should not be blank'  );
        SendEvent(IntToStr(BOR_EmployeePay_Err_NoPaydate),BusobjEventVal_FailedEmployeePayValidateData);
        Exit;
     end;
     if Payperiods = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeePay_Err_NoPayPeriods,  'Pay Periods should not be 0');
        SendEvent(IntToStr(BOR_EmployeePay_Err_NoPayPeriods),BusobjEventVal_FailedEmployeePayValidateData);
        Exit;
     end;
     if Empname = '' then begin
        Resultstatus.AddItem(False , rssError , 0,  'Employee name should not be blank' , true );
        Exit;
     end;
     if Payperiod = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeePay_Err_NoPayPeriod,  'Pay period should not be blank' , true);
        SendEvent(IntToStr(BOR_EmployeePay_Err_NoPayPeriod),BusobjEventVal_FailedEmployeePayValidateData);
        Exit;
     end;
     Result := true;
   Finally
//    If not Result then Begin
//      tmpResultStatus := ResultStatus.GetLastStatusItem;
//      if Assigned(tmpResultStatus) then
//        TBusobj(Self).SendEvent(IntToStr(tmpResultStatus.Code),BusobjEventVal_FailedEmployeePayValidateData);
//    end;
   end;
end;

Procedure Tpaybase.CallbackSave(Const Sender: TBusObj; var Abort: boolean);
begin
  if Sender.Save = False then begin
    Abort := true;
    fbAllLinesValid := False;
  end;
end;

function Tpaybase.Save :Boolean ;
begin
  Result := False;
  PostDB;
  if not ValidateData then Exit;
  Result := Inherited Save;
  if Result = false then Exit;
  
  fbAllLinesValid := True;

  Self.PaysPayRates.PostDb;
  Self.PaysPayRates.IterateRecords(CallbackSave);
  if not fbAllLinesValid  then begin
    result := False;
    Exit;
  end;

  Self.PayCommissions.PostDb;
  Self.PayCommissions.IterateRecords(CallbackSave);
  if not fbAllLinesValid  then begin
    result := False;
    Exit;
  end;

   Self.PayAllowances.PostDb;
  Self.PayAllowances.IterateRecords(CallbackSave);
  if not fbAllLinesValid  then begin
    result := False;
    Exit;
  end;

  Self.PayDeductions.PostDb;
  Self.PayDeductions.IterateRecords(CallbackSave);
  if not fbAllLinesValid  then begin
    result := False;
    Exit;
  end;

  if AppEnv.RegionalOptions.RegionType <> rAUST then begin
    { no super in other countries }
  end
  else begin
    Self.PayBenefits.PostDb;
    Self.PayBenefits.IterateRecords(CallbackSave);
    if not fbAllLinesValid  then begin
      result := False;
      Exit;
    end;
  end;

  Self.PaySundries.PostDb;
  Self.PaySundries.IterateRecords(CallbackSave);
  if not fbAllLinesValid  then begin
    result := False;
    Exit;
  end;

  Self.PayPaysplits.PostDb;
  Self.PayPaysplits.IterateRecords(CallbackSave);
  if not fbAllLinesValid  then begin
    result := False;
    Exit;
  end;

  Self.PayLeaves.PostDb;
  Self.PayLeaves.IterateRecords(CallbackSave);
  if not fbAllLinesValid  then begin
    result := False;
    Exit;
  end;

  if self.IsTermination then begin
    if (not Termination.Save) then begin
      result := false;
      exit;
    end;
  end
  else
    Termination.PostDb;

  Self.RecalcAll;
  result := true;
end;

procedure Tpaybase.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;

procedure Tpaybase.DoFieldOnChange(Sender: TField);
begin
  if Self.Dataset.State =  dsInsert then exit;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
  if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;

  if Sysutils.SameText(Sender.FieldName , 'PayDate') then begin
    if VarIsNull(Sender.OldValue) or (Sender.Value <> Sender.OldValue) then
      if not fbCreatingNewPay then
        if RecalcInProgress = False then begin
          PostDb;
          Self.RecalcAll;
        end;
  end
  else if Sysutils.SameText(Sender.FieldName , 'DatePaid') then begin
    if VarIsNull(Sender.OldValue) or (Sender.Value <> Sender.OldValue) then
      if not fbCreatingNewPay then
        if RecalcInProgress = False then begin
          PostDb;
          Self.RecalcAll;
        end;
  end
  else if (Sysutils.SameText(Sender.FieldName , 'ManualTax')) then begin
    if VarIsNull(Sender.OldValue) or (Sender.Value <> Sender.OldValue) then begin
      if ManualTax = False then begin
        PostDb;
        Self.RecalcAll;
      end;
      Sendevent(BusObjEvent_Change,BusObjEventVal_Pay_ManualTax,self);
    end;
  end
  else if (Sysutils.SameText(Sender.FieldName , 'Tax')) then begin
    if VarIsNull(Sender.OldValue) or (Sender.Value <> Sender.OldValue) then
      if ManualTax = True then begin
        PostDb;
        Self.RecalcAll;
      end;
  end;
end;

Function Tpaybase.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;

function Tpaybase.GetSUMPayAllowanceForSTP(aDate: TDateTime): TSUMPayAllowanceForSTP;
begin
  //aDate := FiscalYearStart(aDate, AppEnv.CompanyPrefs.FiscalYearStarts);
  if (fSUMPayAllowanceForSTP <> nil) then begin
      if (fSUMPayAllowanceForSTP.PayrunDate =aDAte) and (fSUMPayAllowanceForSTP.PayIDforInst = ID) then begin
        REsult := fSUMPayAllowanceForSTP;
        Exit;
      end;
      Freeandnil(fSUMPayAllowanceForSTP);
  end;
  fSUMPayAllowanceForSTP := TSUMPayAllowanceForSTP.create(Self);
  fSUMPayAllowanceForSTP.connection := Self.connection;
  fSUMPayAllowanceForSTP.YTDMoneyAmountFrom := FiscalYearStart(aDate, AppEnv.CompanyPrefs.FiscalYearStarts);
  fSUMPayAllowanceForSTP.PayrunDate := aDAte;
  fSUMPayAllowanceForSTP.PayIDforInst :=  ID;
  fSUMPayAllowanceForSTP.Load;
  fSUMPayAllowanceForSTP.IsReadonly := true;
  REsult := fSUMPayAllowanceForSTP;
end;

function Tpaybase.GetSUMPayTopUptoJobKeepersAllowanceForSTP(aDate: TDateTime): TSUMPayTopUptoJobKeepersAllowanceForSTP;
begin
  //aDate := FiscalYearStart(aDate, AppEnv.CompanyPrefs.FiscalYearStarts);
  if (fSUMPayTopUptoJobKeepersAllowanceForSTP <> nil) then begin
      if (fSUMPayTopUptoJobKeepersAllowanceForSTP.PayrunDate =aDAte) and (fSUMPayTopUptoJobKeepersAllowanceForSTP.PayIDforInst = ID) then begin
        REsult := fSUMPayTopUptoJobKeepersAllowanceForSTP;
        Exit;
      end;
      Freeandnil(fSUMPayTopUptoJobKeepersAllowanceForSTP);
  end;
  fSUMPayTopUptoJobKeepersAllowanceForSTP := TSUMPayTopUptoJobKeepersAllowanceForSTP.create(Self);
  fSUMPayTopUptoJobKeepersAllowanceForSTP.connection := Self.connection;
  fSUMPayTopUptoJobKeepersAllowanceForSTP.YTDMoneyAmountFrom := FiscalYearStart(aDate, AppEnv.CompanyPrefs.FiscalYearStarts);
  fSUMPayTopUptoJobKeepersAllowanceForSTP.PayrunDate := aDAte;
  fSUMPayTopUptoJobKeepersAllowanceForSTP.PayIDforInst :=  ID;
  fSUMPayTopUptoJobKeepersAllowanceForSTP.Load;
  fSUMPayTopUptoJobKeepersAllowanceForSTP.IsReadonly := true;
  REsult := fSUMPayTopUptoJobKeepersAllowanceForSTP;
end;

function Tpaybase.GetSUMPayDeductionForSTP(aDate: TDateTime): TSUMPayDeductionForSTP;
begin
  //aDate := FiscalYearStart(aDate, AppEnv.CompanyPrefs.FiscalYearStarts);
  if (fSUMPayDeductionForSTP <> nil) then begin
      if (fSUMPayDeductionForSTP.PayrunDate =aDAte) and (fSUMPayDeductionForSTP.PayIDforInst = ID) then begin
        REsult := fSUMPayDeductionForSTP;
        Exit;
      end;
      Freeandnil(fSUMPayDeductionForSTP);
  end;
  fSUMPayDeductionForSTP := TSUMPayDeductionForSTP.create(Self);
  fSUMPayDeductionForSTP.connection := Self.connection;
  fSUMPayDeductionForSTP.YTDMoneyAmountFrom := FiscalYearStart(aDAte, AppEnv.CompanyPrefs.FiscalYearStarts);
  fSUMPayDeductionForSTP.PayrunDate :=aDAte;
  fSUMPayDeductionForSTP.PayIDforInst :=  ID;
  fSUMPayDeductionForSTP.Load;
  fSUMPayDeductionForSTP.IsReadonly := true;
  REsult := fSUMPayDeductionForSTP;
end;

class function Tpaybase.GetIDField : String;
begin
   Result := 'Payid'
end;

class function Tpaybase.GetBusObjectTablename: string;
begin
  Result := 'tblpays';
end;

Function  Tpaybase.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;
                 
{Property functions}

Function  Tpaybase.GetPayID                 :Integer   ; begin Result := GetIntegerField('PayID');End;
Function  Tpaybase.GetEmployeeid            :Integer   ; begin Result := GetIntegerField('Employeeid');End;
Function  Tpaybase.GetPaydate               :TDatetime ; begin Result := GetDatetimeField('Paydate');End;
Function  Tpaybase.GetDatepaid              :TDatetime ; begin Result := GetDatetimeField('Datepaid');End;
Function  Tpaybase.GetPayperiods            :Integer   ; begin Result := GetIntegerField('Payperiods');End;



function Tpaybase.GetPayPeriodStartDatePaid: TDateTime;
var
  year,month,day: word;
  monthDays: integer;
begin
  if SameText(Payperiod, 'Weekly') then begin
    result := DatePaid - 7;
  end
  else if SameText(Payperiod, 'Fortnightly') then begin
    result := DatePaid - 14;
  end
  else if SameText(Payperiod, 'Monthly') then begin
    DecodeDate(DatePaid,year,month,day);
    if month = 1 then
      month := 1
    else
      month := month -1;
    monthDays := DaysInMonth(EncodeDate(year,month,1));
    if monthDays < (day + 1) then begin
      result := IncDay(EncodeDate(year,month,monthDays),(day+1) - monthDays);
    end
    else
      result := EncodeDate(year,month,day+1);
  end
  else if SameText(Payperiod, 'Bi-Monthly') then begin
    monthDays := DaysInMonth(DatePaid);
    result := IncDay(DatePaid,-(Trunc(monthDays/2)+1));
  end
  else if SameText(Payperiod, 'None') then begin
    result := DatePaid;
  end
  else
    raise Exception.Create('Invalid pay period "' + PayPeriod + '"');

   result := result + 1;
end;



function Tpaybase.GetPayPeriodStartDate: TDateTime;
var
  year,month,day: word;
  monthDays: integer;
begin
  if SameText(Payperiod, 'Weekly') then begin
    result := PayDate - 7;
  end
  else if SameText(Payperiod, 'Fortnightly') then begin
    result := PayDate - 14;
  end
  else if SameText(Payperiod, 'Monthly') then begin
    DecodeDate(PayDate,year,month,day);
    if month = 1 then
      month := 1
    else
      month := month -1;
    monthDays := DaysInMonth(EncodeDate(year,month,1));
    if monthDays < (day + 1) then begin
      result := IncDay(EncodeDate(year,month,monthDays),(day+1) - monthDays);
    end
    else
      result := EncodeDate(year,month,day+1);
  end
  else if SameText(Payperiod, 'Bi-Monthly') then begin
    monthDays := DaysInMonth(PayDate);
    result := IncDay(PayDate,-(Trunc(monthDays/2)+1));
  end
  else if SameText(Payperiod, 'None') then begin
    result := PayDate;
  end
  else
    raise Exception.Create('Invalid pay period "' + PayPeriod + '"');
end;


function Tpaybase.GetPayRunID: integer;
begin
  result := GetIntegerField('PayRunID');
end;

Function  Tpaybase.GetWages                 :Double    ; begin Result := GetFloatField('Wages');End;
Function  Tpaybase.GetCommission            :Double    ; begin Result := GetFloatField('Commission');End;
Function  Tpaybase.GetDeductions            :Double    ; begin Result := GetFloatField('Deductions');End;
Function  Tpaybase.GetWorkplacegiving       :Double    ; begin Result := GetFloatField('Workplacegiving');End;
Function  Tpaybase.GetAllowances            :Double    ; begin Result := GetFloatField('Allowances');End;
Function  Tpaybase.GetAllowancesbeforetax   :Double    ; begin Result := GetFloatField('Allowancesbeforetax');End;
Function  Tpaybase.GetSundries              :Double    ; begin Result := GetFloatField('Sundries');End;
Function  Tpaybase.GetSuperannuation        :Double    ; begin Result := GetFloatField('Superannuation');End;
Function  Tpaybase.GetGross                 :Double    ; begin Result := GetFloatField('Gross');End;
function Tpaybase.GetGrossExcludeAllowances: Double;
begin
  result := GetFloatField('GrossExcludeAllowances');
end;

Function  Tpaybase.GetGrosstaxable          :Double    ; begin Result := GetFloatField('Grosstaxable');End;
Function  Tpaybase.GetFITWages              :Double    ; begin Result := GetFloatField('FITWages');End;
Function  Tpaybase.GetSocWages              :Double    ; begin Result := GetFloatField('SocWages');End;
Function  Tpaybase.GetMedWages              :Double    ; begin Result := GetFloatField('MedWages');End;
Function  Tpaybase.GetStateWages            :Double    ; begin Result := GetFloatField('StateWages');End;
Function  Tpaybase.GetTax                   :Double    ; begin Result := GetFloatField('Tax');End;
Function  Tpaybase.GetNet                   :Double    ; begin Result := GetFloatField('Net');End;
Function  Tpaybase.GetPay                   :Boolean   ; begin Result := GetBooleanField('Pay');End;
Function  Tpaybase.GetPaid                  :Boolean   ; begin Result := GetBooleanField('Paid');End;
Function  Tpaybase.GetPrinted               :Boolean   ; begin Result := GetBooleanField('Printed');End;
Function  Tpaybase.GetEmpname               :String    ; begin Result := GetStringField('Empname');End;
Function  Tpaybase.GetLeaveloading          :Double    ; begin Result := GetFloatField('Leaveloading');End;
function Tpaybase.GetLines: TPayLine;
begin
  result := TPayLine(GetContainerComponent(TPayLine ,'PayId = ' + IntToStr(Self.ID)));
end;

Function  Tpaybase.GetClassID               :Integer   ; begin Result := GetIntegerField('Classid');End;
Function  Tpaybase.GetClass                 :String    ; begin Result := GetStringField('Class');End;
Function  Tpaybase.GetIstimesheet           :Boolean   ; begin Result := GetBooleanField('Istimesheet');End;
Function  Tpaybase.GetPayperiod             :String    ; begin Result := GetStringField('Payperiod');End;
Function  Tpaybase.GetAnnualleaverate       :Double    ; begin Result := GetFloatField('Annualleaverate');End;
Function  Tpaybase.GetCdepgross             :Double    ; begin Result := GetFloatField('Cdepgross');End;
Function  Tpaybase.GetLumpa                 :Double    ; begin Result := GetFloatField('Lumpa');End;
Function  Tpaybase.GetLumpb                 :Double    ; begin Result := GetFloatField('Lumpb');End;
Function  Tpaybase.GetLumpd                 :Double    ; begin Result := GetFloatField('Lumpd');End;
Function  Tpaybase.GetLumpe                 :Double    ; begin Result := GetFloatField('Lumpe');End;
Function  Tpaybase.GetEtp                   :Double    ; begin Result := GetFloatField('Etp');End;
Function  Tpaybase.GetManualtax             :Boolean   ; begin Result := GetBooleanField('Manualtax');End;
Function  Tpaybase.GetDeleted               :Boolean   ; begin Result := GetBooleanField('Deleted');End;
Function  Tpaybase.GetIsnewtypepay          :Boolean   ; begin Result := GetBooleanField('Isnewtypepay');End;
function  Tpaybase.GetIsTermination         :Boolean   ; begin result := GetBooleanField('IsTermination');end;
Function  Tpaybase.GeTpaysuperonleaveloading:Boolean   ; begin Result := GetBooleanField('Paysuperonleaveloading');End;
Function  Tpaybase.GeTpayversion            :Integer   ; begin Result := GetIntegerField('Payversion');End;
Function  Tpaybase.GeTpaynotes              :String    ; begin Result := GetStringField('Paynotes');End;
Function  Tpaybase.GeTpayxmldata            :String    ; begin Result := GetStringField('Payxmldata');End;
Function  Tpaybase.GetPrepared              :Boolean   ; begin Result := GetBooleanField('Prepared');End;
Function  Tpaybase.GeTCountryCode           :String    ; begin Result := GetStringField('CountryCode');End;
Function  Tpaybase.GetUKTaxCodeUsed         :String    ; begin Result := GetStringField('UKTaxCodeUsed');End;
Function  Tpaybase.GetNICsClass1            :Double    ; begin Result := GetFloatField('UKNICsClass1');End;
Function  Tpaybase.GetNICsOther             :Double    ; begin Result := GetFloatField('UKNICsOther');End;
Function  Tpaybase.GetRegion                :String    ; begin Result := GetStringField('Region');End;

Function  Tpaybase.GetEmployerNICsClass1    :Double    ; begin Result := GetFloatField('UKEmployerNICsClass1');End;
Function  Tpaybase.GetEmployerNICsOther     :Double    ; begin Result := GetFloatField('UKEmployerNICsOther');End;
Function  Tpaybase.GetTopUptoJobKeepersAllowance:Double; begin Result := GetFloatField('TopUptoJobKeepersAllowance');End;
Procedure Tpaybase.SetEmployeeid            (Const Value :Integer   ); begin SetIntegerField('Employeeid'             , Value);End;
Procedure Tpaybase.SeTpaydate               (Const Value :TDatetime ); begin SetDatetimeField('Paydate'                , Value);End;
Procedure Tpaybase.SetDatepaid              (Const Value :TDatetime ); begin SetDatetimeField('Datepaid'               , Value);End;
Procedure Tpaybase.SeTpayperiods            (Const Value :Integer   ); begin SetIntegerField('Payperiods'             , Value);End;
procedure Tpaybase.SetPayRunID(const Value: integer);
begin
  SetIntegerField('PayRunID', Value);
end;

Procedure Tpaybase.SetWages                 (Const Value :Double    ); begin SetFloatField('Wages'                  , Value);End;
Procedure Tpaybase.SetCommission            (Const Value :Double    ); begin SetFloatField('Commission'             , Value);End;
Procedure Tpaybase.SetDeductions            (Const Value :Double    ); begin SetFloatField('Deductions'             , Value);End;
Procedure Tpaybase.SetWorkplacegiving       (Const Value :Double    ); begin SetFloatField('Workplacegiving'        , Value);End;
Procedure Tpaybase.SetAllowances            (Const Value :Double    ); begin SetFloatField('Allowances'             , Value);End;
Procedure Tpaybase.SetAllowancesbeforetax   (Const Value :Double    ); begin SetFloatField('Allowancesbeforetax'    , Value);End;
Procedure Tpaybase.SetSundries              (Const Value :Double    ); begin SetFloatField('Sundries'               , Value);End;
Procedure Tpaybase.SetSuperannuation        (Const Value :Double    ); begin SetFloatField('Superannuation'         , Value);End;
Procedure Tpaybase.SetGross                 (Const Value :Double    ); begin SetFloatField('Gross'                  , Value);End;
procedure Tpaybase.SetGrossExcludeAllowances(const Value: Double);
begin
  SetFloatField('GrossExcludeAllowances', Value);
end;

Procedure Tpaybase.SetGrosstaxable          (Const Value :Double    ); begin SetFloatField('Grosstaxable'           , Value);End;
Procedure Tpaybase.SetFITWages              (Const Value :Double    ); begin SetFloatField('FITWages'               , Value);End;
Procedure Tpaybase.SetSocWages              (Const Value :Double    ); begin SetFloatField('SocWages'               , Value);End;
Procedure Tpaybase.SetMedWages              (Const Value :Double    ); begin SetFloatField('MedWages'               , Value);End;
Procedure Tpaybase.SetStateWages            (Const Value :Double    ); begin SetFloatField('StateWages'             , Value);End;
Procedure Tpaybase.SetTax                   (Const Value :Double    ); begin SetFloatField('Tax'                    , Value);End;
Procedure Tpaybase.SetNet                   (Const Value :Double    ); begin SetFloatField('Net'                    , Value);End;
Procedure Tpaybase.SeTpay                   (Const Value :Boolean   ); begin SetBooleanField('Pay'                    , Value);End;
Procedure Tpaybase.SetPaid                  (Const Value :Boolean   ); begin SetBooleanField('Paid'                   , Value);End;
Procedure Tpaybase.SetPrinted               (Const Value :Boolean   ); begin SetBooleanField('Printed'                , Value);End;
Procedure Tpaybase.SetEmpname               (Const Value :String    ); begin SetStringField('Empname'                , Value);End;
Procedure Tpaybase.SetLeaveloading          (Const Value :Double    ); begin SetFloatField('Leaveloading'           , Value);End;
Procedure Tpaybase.setClassID               (Const Value :Integer   ); begin SetIntegerField('Classid'                , Value);End;
Procedure Tpaybase.SetClass                 (Const Value :String    ); begin SetStringField('Class'                  , Value);End;
Procedure Tpaybase.SetIstimesheet           (Const Value :Boolean   ); begin SetBooleanField('Istimesheet'            , Value);End;
Procedure Tpaybase.SeTpayperiod             (Const Value :String    ); begin SetStringField('Payperiod'              , Value);End;
Procedure Tpaybase.SetAnnualleaverate       (Const Value :Double    ); begin SetFloatField('Annualleaverate'        , Value);End;
Procedure Tpaybase.SetCdepgross             (Const Value :Double    ); begin SetFloatField('Cdepgross'              , Value);End;
Procedure Tpaybase.SetLumpa                 (Const Value :Double    ); begin SetFloatField('Lumpa'                  , Value);End;
Procedure Tpaybase.SetLumpb                 (Const Value :Double    ); begin SetFloatField('Lumpb'                  , Value);End;
Procedure Tpaybase.SetLumpd                 (Const Value :Double    ); begin SetFloatField('Lumpd'                  , Value);End;
Procedure Tpaybase.SetLumpe                 (Const Value :Double    ); begin SetFloatField('Lumpe'                  , Value);End;
Procedure Tpaybase.SetEtp                   (Const Value :Double    ); begin SetFloatField('Etp'                    , Value);End;
Procedure Tpaybase.SetManualtax             (Const Value :Boolean   ); begin SetBooleanField('Manualtax'            , Value);End;
Procedure Tpaybase.SetDeleted               (Const Value :Boolean   ); begin SetBooleanField('Deleted'              , Value);End;
Procedure Tpaybase.SetIsnewtypepay          (Const Value :Boolean   ); begin SetBooleanField('Isnewtypepay'         , Value);End;
procedure Tpaybase.SetIsTermination         (const Value :Boolean   ); begin SetBooleanField('IsTermination'        , Value);end;
Procedure Tpaybase.SetTopUptoJobKeepersAllowance(Const Value :Double); begin SetFloatField('TopUptoJobKeepersAllowance', Value);End;

Procedure Tpaybase.SeTpaysuperonleaveloading(Const Value :Boolean   ); begin SetBooleanField('Isnewtypepay'           , Value);End;
Procedure Tpaybase.SeTpayversion            (Const Value :Integer   ); begin SetIntegerField('Payversion'             , Value);End;
Procedure Tpaybase.SeTpaynotes              (Const Value :String    ); begin SetStringField('Paynotes'               , Value);End;
Procedure Tpaybase.SeTpayxmldata            (Const Value :String    ); begin SetStringField('Payxmldata'             , Value);End;
Procedure Tpaybase.SetPrepared              (Const Value :Boolean   ); begin SetBooleanField('Prepared'               , Value);End;
Procedure Tpaybase.SetCountryCode           (Const Value :String    ); begin SetStringField('CountryCode'             , Value);End;
Procedure Tpaybase.SetUKTaxCodeUsed         (Const Value :String    ); begin SetStringField('UKTaxCodeUsed'             , Value);End;
Procedure Tpaybase.SetNICsClass1            (Const Value :Double    ); begin SetFloatField('UKNICsClass1'               , Value);End;
Procedure Tpaybase.SetNICsOther             (Const Value :Double    ); begin SetFloatField('UKNICsOther'               , Value);End;
Procedure Tpaybase.SetRegion                (Const Value :String    ); begin SetStringField('Region'             , Value);End;

Procedure Tpaybase.SetEmployerNICsClass1            (Const Value :Double    ); begin SetFloatField('UKEmployerNICsClass1'      , Value);End;
Procedure Tpaybase.SetEmployerNICsOther             (Const Value :Double    ); begin SetFloatField('UKEmployerNICsOther'       , Value);End;

//========================Employee=================================

function Tpaybase.GetEmployeeDetails:TEmployeeDetails;
begin
  if not Assigned(fEmployeeDetails) then begin
    fEmployeeDetails := TEmployeeDetails.Create(Self);
    fEmployeeDetails.Connection := Self.Connection;
    fEmployeeDetails.SilentMode := Self.SilentMode;
  end;
  result := fEmployeeDetails;
End;

procedure Tpaybase.SetEmployeeDetails(const Value:Temployeedetails);
begin
  fEmployeeDetails := Value;
end;


//=======================Other=====================================

Function Tpaybase.GetPayFromDate:TDateTime;
begin 
  fPayFromDate :=  PayCommon.PayFromDate(PayDate, Self.EmployeePaySettings.PayPeriod);
  Result := fPayFromDate;
end;

Function Tpaybase.getTaxableTotals :Double;
begin
  Result := 0; //stub
end;

function Tpaybase.GetTermination: TTerminationSimple;
begin
  result := TTerminationSimple(self.getContainerComponent(TTerminationSimple,'PayID = '+ IntToStr(self.PayID)));
//  if self.EmployeeDetails.IsTerminated then begin
//    if result.Count = 0 then begin
//      { should be a record }
//      result.New;
//      result.PostDb;
//    end;
//  end
//  else begin
//    { employee is not terminated }
//    if (result.Count > 0) and (result.LumpSumD = 0) then begin
//      result.DeleteAll;
//      result.PostDb;
//    end;
//  end;
end;

function Tpaybase.GetEmployeePayRates:TEmployeePayRates;
begin
  if not Assigned(fEmployeePayRates) then begin
    fEmployeePayRates := Temployeepayrates.Create(Self);
    fEmployeePayRates.Connection := Self.Connection;
    fEmployeePayRates.SilentMode := Self.SilentMode;
  end;
  result := fEmployeePayRates;
End;

procedure Tpaybase.SetEmployeePayRates(const Value:TemployeePayRates);
begin
  fEmployeePayRates := Value;
end;

//Function Tpaybase.getSundriesBeforeTax :Double;
//begin
//  Result := 0; //stub
//end;

//Function Tpaybase.getSundriesAfterTax :Double;
//begin
//  Result := 0; //stub
//end;

Procedure Tpaybase.SetPayTotals(const Value:Tpaytotals);
begin
  fPaytotals := Value;
end;

function Tpaybase.GetPayTax: TPayTax;
begin
  result := TPayTax(GetContainerComponent(TPayTax, 'PayId = ' + IntToStr(PayId)));
end;

procedure TPayBase.SetCompanyTax(value: double);
begin
  SetFloatField('CompanyTax',value);
end;

function TPayBase.GetCompanyTax: double;
begin
  result := GetFloatField('CompanyTax');
end;

function Tpaybase.GetPayTotals:Tpaytotals;
begin
  if not Assigned(fPaytotals) then begin
    fPaytotals := Tpaytotals.Create(Self);
  end;
  result := fPaytotals;
end;

procedure TPaybase.LoadPayTotals;
begin
  { The following add amounts to the PayTotals.TaxableTotals memory table to
    be used for calculating tax amounts for the postings }
  Self.PayTotals.TaxableTotals.Clear;
  Self.PaysPayRates.IterateRecords(CallbackLoadPayrateTotals);
  (* The following has been removed because tax should not be calculated for
    deductions, the total deductions will either:
    (Pre-Tax) reduce the gross amount (therfore reducing tax and net, or
    (Post-Tax) reduce the net amout (gross and tax remain unchanged) }
    Self.PayDeductions.IterateRecords(CallbackLoadDeductionsTotals);
  *)
  Self.PayAllowances.IterateRecords(CallbackLoadAllowancesTotals);
  Self.PayCommissions.IterateRecords(CallbackLoadCommissionTotals);
  Self.PaySundries.IterateRecords(CallbackLoadSundriesTotals);

end;

procedure TPaybase.CallbackLoadSundriesTotals(const Sender: TBusObj; var Abort: Boolean);
begin
  if Tpayssundries(Sender).Taxexempt = True then exit;
  with PayTotals.TaxableTotals.AddItem(Tpayssundries(Sender).SundryID,'Sundry') do begin
    TypeName := Tpayssundries(Sender).Sundry;
    ClassId := Tpayssundries(Sender).ClassID;
    Amount := Tpayssundries(Sender).Amount;
    PayLineId := Tpayssundries(Sender).ID;
  end;
end;

procedure TPaybase.CallbackLoadCommissionTotals(const Sender: TBusObj; var Abort: Boolean);
begin
  if Tpayscommission(Sender).Taxexempt = True then exit;
  with PayTotals.TaxableTotals.AddItem(TpaysCommission(Sender).CommissionID,'Commission') do begin
    TypeName := GetCommissionName(Tpayscommission(Sender).CommissionID);
    RateName := 'Commission';
    ClassId := Tpayscommission(Sender).ClassID;
    Amount := Tpayscommission(Sender).Gross;
    PayLineId := Tpayscommission(Sender).ID;
  end;
end;

//procedure TPaybase.CallbackLoadDeductionsTotals(const Sender: TBusObj; var Abort: Boolean);
//begin
//  if Tpaysdeductions(Sender).Taxexempt = True then exit;
//
//  with Self.PayTotals.TaxableTotals do begin
//    Append;
//    FieldByName('ID').AsInteger := Tpaysdeductions(Sender).DeductionID;
//    FieldByName('Type').AsString := GetDeductionName(Tpaysdeductions(Sender).DeductionID);
//    FieldByName('MSType').AsString := 'Deduction';
//    FieldByName('Rate').AsString := 'Deduction';
//    FieldByName('ClassID').AsInteger := Tpaysdeductions(Sender).ClassID;
//    FieldByName('Amount').AsFloat := Tpaysdeductions(Sender).MoneyAmount;
//    If (Tpaysdeductions(Sender).ID <> 0) then begin
//      FieldByName('PayLineID').AsInteger := Tpaysdeductions(Sender).ID;
//      Post;
//    end else Begin
//      Cancel;
//    end;
//  end;
//end;

procedure TPaybase.CallbackLoadAllowancesTotals(const Sender: TBusObj; var Abort: Boolean);
begin
  if TpaysAllowances(Sender).Taxexempt = True then exit;
  with PayTotals.TaxableTotals.AddItem(TpaysAllowances(Sender).AllowanceID,'Allowance') do begin
    TypeName := GetAllowanceName(TpaysAllowances(Sender).AllowanceID);
    RateName := 'Allowance';
    ClassId := Tpaysallowances(Sender).ClassID;
    Amount := Tpaysallowances(Sender).MoneyAmount;
    PayLineId := Tpaysallowances(Sender).ID;
  end;
end;

procedure TPaybase.CallbackLoadPayrateTotals(const Sender: TBusObj; var Abort: Boolean);
begin
  with PayTotals.TaxableTotals.AddItem(Tpayspayrates(Sender).PayRateID,'PayRate') do begin
    TypeName := GetPayRateType(Tpayspayrates(Sender).TypeID);
    RateName := GetPayRate(Tpayspayrates(Sender).PayRateID);
    ClassId := Tpayspayrates(Sender).ClassID;
    Amount := Tpayspayrates(Sender).LineTotal;
    PayLineId := Tpayspayrates(Sender).ID;
  end;
end;

procedure TPaybase.SetPayTotalsValues;
var
  { Allowances: Non-taxed - add to Net After tax
                Taxed     - add to Gross Before tax
    Deductions: Non-taxed - take from Gross Before tax
                Taxed     - take from Net After tax
  }
  strsql: String;
  dNetAffectedSuperTemp : double;
begin
    Paytotals.Wages                     := Self.Wages; // + Termination.LumpSumD;
    Paytotals.WagesIncludedInSuper      := Self.PaysPayRates.TotalIncludedInSuper;
    Paytotals.Allowances                := Self.PayAllowances.TotalAllowances;
    Paytotals.GrossExcludeAllowances    := Self.PayAllowances.TotalGrossExcludeAllowances;
    Paytotals.AllowancesBeforeTax       := Self.PayAllowances.TotalAllowancesBeforeTax;
    Paytotals.AllowancesAfterTax        := Self.PayAllowances.TotalAllowancesAfterTax;
    Paytotals.AllowancesIncludedInSuper := Self.PayAllowances.TotalAllowancesIncludedInSuper;
    Paytotals.Deduction                 := Self.PayDeductions.TotalDeductions;
    Paytotals.Workplacegiving           := Self.PayDeductions.TotalWPGiving;
    Paytotals.DeductionBeforeTax        := Self.PayDeductions.TotalDeductionsBeforeTax;
    Paytotals.DeductionAfterTax         := Self.PayDeductions.TotalDeductionsAfterTax;
    Paytotals.Sundries                  := Self.PaySundries.TotalSundries;
    Paytotals.TaxableSundries           := Self.PaySundries.TaxableSundries;
    Paytotals.TaxExemptSundries         := Self.PaySundries.TaxExemptSundries;
    Paytotals.Commission                := Self.PayCommissions.TotalGross;  //was net??
    Paytotals.CommissionBeforeTax       := Self.PayCommissions.TotalBeforeTax;
    Paytotals.CommissionAfterTax        := Self.PayCommissions.TotalAfterTax;

    Paytotals.GrossTaxable := (Paytotals.Wages - Paytotals.DeductionBeforeTax) + Paytotals.CommissionBeforeTax
                              + Paytotals.AllowancesBeforeTax + Paytotals.TaxableSundries;
    { ATO changed this, from 1 July 2014 leave loading should be taxed same way as a normal payment }
//    Paytotals.GrossTaxable := Paytotals.GrossTaxable - Self.PayLeaves.NonTaxableLeaveLoading;

    Paytotals.Gross        := Paytotals.Wages + Paytotals.Commission + Paytotals.Allowances +
                              Paytotals.Sundries - Paytotals.DeductionBeforeTax +
                              Termination.LumpSumD;

    Paytotals.CommissionIncludedInSuper := Self.PayCommissions.TotalIncludedInSuper;

    if AppEnv.RegionalOptions.RegionType <> rAUST then begin
      { no super in other countries }
       Paytotals.Superannuation := 0;
       Paytotals.GrossCDEP      := 0;

       dNetAffectedSuperTemp    := 0;
    end
    else begin
       Paytotals.Superannuation := tpayssuperannuation(Self.PayBenefits).TotalSuper;
       Paytotals.Gross          := Paytotals.Gross - tpayssuperannuation(Self.PayBenefits).SalarySacrificeTotal;
       Paytotals.GrossTaxable   := Paytotals.GrossTaxable - tpayssuperannuation(Self.PayBenefits).SalarySacrificeTotal;
       Paytotals.GrossCDEP      := TPaysPayRatesAUS(Self.PaysPayRates).TotalCDEP;

       dNetAffectedSuperTemp    := Tpayssuperannuation(Self.PayBenefits).EmployeeOptionalTotal
                                 + Tpayssuperannuation(Self.PayBenefits).SpouseContributionTotal
                                 + Tpayssuperannuation(Self.PayBenefits).EmployeeNegativeTotal ;
    end;

    if ManualTax then begin
      PayTax.DeleteAll();
//      Paytotals.Tax := Self.Tax;
    end;
//    else
      PayTax.CalculateTax;

    if Paytotals.Tax < 0 then Paytotals.Tax := 0;

    Paytotals.Net :=  {Positives}
                      (Paytotals.GrossTaxable
//                      + Self.PayLeaves.NonTaxableLeaveLoading
                      + Paytotals.CommissionAfterTax
                      + Paytotals.AllowancesAfterTax
                      + Paytotals.TaxExemptSundries)
                      + Termination.LumpSumD
                      {Negitives}
                      - (Paytotals.Tax
                         + Paytotals.DeductionAfterTax
//                         + tpayssuperannuation(Self.PayBenefits).SalarySacrificeTotal
                         + dNetAffectedSuperTemp);


    // YTD Totals
    strsql :=
        'SELECT Sum(Wages) as Wages, ' +
        'Sum(Allowances) as Allowances, ' +
        'Sum(GrossExcludeAllowances) as GrossExcludeAllowances, ' +
        'Sum(Sundries) as Sundries, ' +
        'Sum(Commission) as Commission, ' +
        'Sum(Superannuation) as Superannuation, ' +
        'Sum(Deductions) as Deductions, ' +
        'Sum(Workplacegiving) as Workplacegiving, ' +
        'Sum(Gross) as Gross, ' +
        'Sum(Tax) as Tax, ' +
        'Sum(Net) as Net, ' +
        'Sum(CDEPGross) as CDEPGross ' +
        'FROM tblpays WHERE Paid="T" AND Deleted="F" ' +
{=============================binny - ytd calculations should be done based on date paid}
        //'AND EmployeeID=' + IntToStr(Self.EmployeeDetails.Id) + ' AND PayDate BETWEEN ' +
        'AND EmployeeID=' + IntToStr(Self.EmployeeDetails.Id) + ' AND DatePaid BETWEEN ' +
        //QuotedStr(FormatDateTime(MysqlDateFormat, GetCurrentFiscalYearStart(Self.PayDate))) + ' AND ' +
        QuotedStr(FormatDateTime(MysqlDateFormat, GetCurrentFiscalYearStart(Self.DatePaid))) + ' AND ' +
        //QuotedStr(FormatDateTime(MysqlDateFormat, Self.PayDate)) + ';';
        QuotedStr(FormatDateTime(MysqlDatetimeFormat, IncSecond(IncDay(dateof(Self.DatePaid), 1), -1))) + ';';

{=============================}

    With GetNewDataSet(strsql, True) do try
      Self.PayTotals.fdYTDWages           := FieldByName('Wages').AsFloat;
      Self.PayTotals.fdYTDAllowances      := FieldByName('Allowances').AsFloat;
      Self.PayTotals.fdYTDGrossExcludeAllowances := FieldByName('GrossExcludeAllowances').AsFloat;
      Self.PayTotals.fdYTDSundries        := FieldByName('Sundries').AsFloat;
      Self.PayTotals.fdYTDCommission      := FieldByName('Commission').AsFloat;
      Self.PayTotals.fdYTDSuperannuation  := FieldByName('Superannuation').AsFloat;
      Self.PayTotals.fdYTDDeduction       := FieldByName('Deductions').AsFloat;
      Self.PayTotals.fdYTDWorkplacegiving := FieldByName('Workplacegiving').AsFloat;
      Self.PayTotals.fdYTDGross           := FieldByName('Gross').AsFloat;
      Self.PayTotals.fdYTDTax             := FieldByName('Tax').AsFloat;
      Self.PayTotals.fdYTDNet             := FieldByName('Net').AsFloat;
      Self.PayTotals.fdYTDCDEPGross       := FieldByName('CDEPGross').AsFloat;
    finally
      if active then close;
      Free;
    end;

end;

procedure TPaybase.DeletePay;
(*var
  iDays:integer;*)
begin
  { Reverse old values }
//  UnPostToAccounts;

  if Termination.Count > 0 then
    Termination.Delete;

  ReallyDeletePayRecords('tblleaveaccruals', Self);
  ReallyDeletePayRecords('tblpaystransactions', Self);

  //handle last paid date
 // Self.EmployeePaySettings.LastPaid := GetLastPayDate(Self.Employeeid,Self.Connection);
  { the following seems to assume that the deleted pay was for a single period,
    this will not work if pay was for multiple periods }
(*
  if Trim(Self.EmployeePaySettings.PayPeriod) = 'Weekly' then Begin
     Self.EmployeePaySettings.LastPaid := IncDay(Self.EmployeePaySettings.LastPaid,-7);
  end else if Trim(Self.EmployeePaySettings.PayPeriod) = 'Fortnightly' then Begin
     Self.EmployeePaySettings.LastPaid := IncDay(Self.EmployeePaySettings.LastPaid,-14);
  end else if Trim(Self.EmployeePaySettings.PayPeriod) = 'Monthly' then Begin
     Self.EmployeePaySettings.LastPaid := IncMonth(Self.EmployeePaySettings.LastPaid,-1);
  end else if Trim(Self.EmployeePaySettings.PayPeriod) = 'Bi-Monthly' then Begin
     iDays :=  Trunc(DaysInMonth(Self.EmployeePaySettings.LastPaid)/2); //get approx half month for bi-month case
     Self.EmployeePaySettings.LastPaid := IncDay(Self.EmployeePaySettings.LastPaid,-iDays);
  end;
*)
  { .. use this instead }
  Self.EmployeePaySettings.LastPaid := GetLastPayDateFromPays(Self.Employeeid, TERPConnection(Self.Connection.Connection));
  Self.EmployeePaySettings.PostDb;
  AdjustUnProcessedPayPayDate(Self.EmployeePaySettings.LastPaid);


  PaysPayRates.Dataset.First;
  while not PaysPayRates.Dataset.Eof do begin
    PaysPayRates.Delete;
  end;

  PayAllowances.dataset.First;
  while not PayAllowances.dataset.eof do begin   //delete any unprocessed allowances
    PayAllowances.Delete;
  end;

  PayDeductions.dataset.First;
  while not PayDeductions.dataset.eof do begin   //delete any unprocessed deductions
    PayDeductions.Delete;
  end;

  PaySundries.dataset.First;
  while not PaySundries.dataset.eof do begin   //delete any unprocessed sundries
    PaySundries.Delete;
 end;

//      fPay.LeaveAccruals.dataset.First;
     // while not fPay.LeaveAccruals.dataset.eof do begin   //delete any unprocessed leave accruals
//        fPay.LeaveAccruals.Delete;
//      end;
  PayCommissions.dataset.First;
  while not PayCommissions.dataset.eof do begin   //delete any unprocessed commissions
    PayCommissions.Delete;
  end;

  if Assigned(fBenefitsObj) then begin
    { no super for USA }
    while not fBenefitsObj.Dataset.eof do begin   //delete any unprocessed superannuations
      fBenefitsObj.Delete;
    end;
  end;

  PayTax.DeleteAll;

  { for each LeaveType in the pay, ReCalc AccruedHoursTotal from tblleaveaccruals
    and assign that value to AccuredHours in tblleave, also set date to last pay date }
  Self.EmployeeLeave.VerifyEmployeeLeave;

end;

procedure TPaybase.UnDeletePay;
begin
  ReallyDeletePayRecords('tblleaveaccruals', Self.PayID);
//  ReallyDeletePayRecords('tblpaystransactions', Self.PayID);
{TODO  DELETE THE UnPostToAccounts Recs}

  Self.EmployeeLeave.AccrueLeaves;
  Self.LeaveAccruals.UpdateLeaveTaken;
  if self.IsTermination then
    Self.LeaveAccruals.ZeroOutAccruals;
  Self.PostToAccounts;
  Self.EmployeeLeave.VerifyEmployeeLeave;
end;

procedure TPaybase.AdjustUnProcessedPayPayDate(EmployeeLastPayDate:TDateTime);
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    with qry do begin
      qry.Connection := TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection);
      SQL.Clear;
      SQL.Add('SELECT PayID,PayDate,EmployeeID FROM tblpays WHERE Pay = "T" AND Paid <> "T"');
      SQL.Add('AND Deleted = "F" AND PayDate <> 0 AND EmployeeID = ' + IntToStr(Self.EmployeeID));
      Open;
      Edit;
      if RecordCount <> 0 then begin
        FieldByName('PayDate').AsDateTime := EmployeeLastPayDate;
        Post;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TPaybase.GetIncomeStreamType: String;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    with qry do begin
      qry.Connection := TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection);
      SQL.Clear;
      SQL.Add('SELECT RateID, Description, Multiplier, IncomeType FROM tblpayrates WHERE RateID = ' + IntToStr(EmployeePayRates.Payrateid));
      Open;
      if RecordCount <> 0 then begin
        GetIncomeStreamType := FieldByName('IncomeType').AsString;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TPaybase.GetSuperannuationObj: TPaysSuperannuation;
begin

   result := TPaysSuperannuation(GetContainerComponent(TPaysSuperannuation, 'PayID = ' + IntToStr(PayID)));

end;

function TPaybase.GetAllowancesObj: TPaysAllowances;
begin

   result := TPaysAllowances(GetContainerComponent(TPaysAllowances, 'PayID = ' + IntToStr(PayID)));

end;

procedure TPaybase.Burden_PostToAccounts;
var
  i: Integer;
  qry: TERPQuery;
  dAmount: Double;
  iBurden, iCreditAccountID, iDebitAccountID: Integer;
  iSeqNo: Integer;
  sTransType: string;
  sMSType: string;
  sDescription: string;
  iClassID, iPayLineID, iClientID: Integer;
  JobIDs : array of Integer;
  Amounts : array of Double;
  iCount, iIndex : Integer;

  function FindJobID(JID: Integer) : Integer;
  var
    k : Integer;
  begin
    Result := -1;
    for k := Low(JobIDs) to High(JobIDs) do
      if JobIDs[k] = JID then begin
        Result := k;
        Break;
      end;
  end;

begin
  TimeSheet.First;

  SetLength(JobIDs, TimeSheet.Count);
  for i := Low(JobIDs) to High(JobIDs) do JobIDs[i] := 0;
  SetLength(Amounts, TimeSheet.Count);
  for i := Low(Amounts) to High(Amounts) do Amounts[i] := 0.0;

  iCount := 0;
  for i := 0 to TimeSheet.Count - 1 do begin
    iCreditAccountID := 0;
    iDebitAccountID := 0;

    // Get the account IDs from client table
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    try
      qry.SQL.Add('SELECT Burden, ACCOUNT1ID, ACCOUNT2ID FROM tblclients');
      qry.SQL.Add('WHERE ClientID=' + IntToStr(TimeSheet.JobID) + ' AND isJob="T"');
      qry.Open;
      if qry.RecordCount > 0 then begin
        iBurden := qry.Fields[0].AsInteger;
        iDebitAccountID := qry.Fields[1].AsInteger;
        iCreditAccountID := qry.Fields[2].AsInteger;
      end;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;

    // If no timesheet booked to a job
    if (iCreditAccountID = 0) or (iDebitAccountID = 0) then
      Continue;

    iClientID := Timesheet.JobID;
    dAmount := TimeSheet.Total * iBurden * 0.01;

    // Save Job ID and amount into array
    iIndex := FindJobID(iClientID);
    if iIndex <> -1 then begin
      Amounts[iIndex] := Amounts[iIndex] + dAmount;
    end
    else begin
       JobIDs[iCount] := iClientID;
       Amounts[iCount] := dAmount;
       Inc(iCount);
    end;

    TimeSheet.Next;
  end;

  for i := Low(JobIDs) to High(JobIDs) do begin
    if JobIDs[i] = 0 then Break;

    // Post to the accounts
    iSeqno := 33;
    sTransType := 'Payroll Job Burden';
    sMSType := 'Job Burden';
    sDescription := IntToStr(iBurden) +  '% Burden Applied';
    iClassID := Self.ClassId;

    iClientID := JobIDs[i];
    dAmount := Amounts[i];

    PayTrans.LoadSelect('PayID = ' + IntToStr(PayID) +
                      ' AND Type = ' + QuotedStr(sTRansType) + ' AND MSType = ' + QuotedStr(sMSType) +
                      ' AND Description = ' + QuotedStr(sDescription) +
                      ' AND ClientID = ' + IntToStr(iClientID) +
                      ' AND PayLineID = ' + IntToStr(ID));

    PayTrans.PostToPaysTransactions(iSeqno, sTransType, sMSType,
                sDescription, iCreditAccountID, iDebitAccountID,
                iClassID, iPayLineId, dAmount, self, iClientID);
  end;
end;

destructor Tpaybase.Destroy;
begin
  FreeAndNil(fPaytotals);
  inherited;
end;

constructor TPayTotals.Create(const Owner: TObject);
begin
  inherited Create;
  foOwner := Owner;
  fTaxableTotals := TTaxableTotalList.Create;
end;

destructor TPayTotals.Destroy;
begin
  fTaxableTotals.Free;
  inherited;
end;

procedure TPayTotals.CalcTax;
begin
end;

procedure TPayTotals.Tax_PostToAccounts;
var
  taRec: TTaxAmount;
  ttRec: TTaxableTotal;
  x, y: integer;
  qry: TERPQuery;
  { post to trans params }
  sSeqno: Integer;
  sTransType, sMS_TransType, sDescription: string;
  iCreditAccountID, iDebitAccountID, iClassID, iPayLineID: integer;
  dAmount: currency;
begin
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select tblPayTaxScaleConfig.PayTaxConfigId, tblpaytaxconfig.TaxName,');
    qry.SQL.Add('tblpaytaxconfig.ExpenseAccountId, tblpaytaxconfig.LiabilityAccountId,');
    qry.SQL.Add('tblPayTaxScaleConfig.ExpenseAccountId as EmpExpenseAccountId, tblPayTaxScaleConfig.LiabilityAccountId as EmpLiabilityAccountId');
    qry.SQL.Add('from tblpaytaxconfig') ;
    qry.SQL.Add('inner join tblPayTaxScaleConfig on tblPayTaxScaleConfig.PayTaxConfigId = tblpaytaxconfig.Id' +
      ' and tblPayTaxScaleConfig.EmployeeId = ' + IntToStr(TPayBase(Owner).Employeeid));
    qry.SQL.Add('where tblpaytaxconfig.RegionId = ' + IntToStr(AppEnv.RegionalOptions.ID));
    qry.Open;

    for x := 0 to TaxableTotals.Count -1 do begin
      ttRec := TaxableTotals[x];
      for y := 0 to ttRec.TaxList.Count -1 do begin
        taRec := ttRec.TaxList[y];
        if qry.Locate('PayTaxConfigId',taRec.PayTaxConfigId, []) then begin

          sSeqno := 3;
          sTransType := 'Payroll ' + qry.FieldByName('TaxName').AsString;
          sMS_TransType := qry.FieldByName('TaxName').AsString + ' - ' + ttRec.MSType;
          sDescription := qry.FieldByName('TaxName').AsString + ' - ' + ttRec.RateName + ' : ' + ttRec.TypeName;

          iCreditAccountID := qry.FieldByName('EmpLiabilityAccountId').AsInteger;
          if iCreditAccountID < 1 then
            iCreditAccountID := qry.FieldByName('LiabilityAccountId').AsInteger;

          iDebitAccountID := qry.FieldByName('EmpExpenseAccountId').AsInteger;
          if iDebitAccountID < 1 then
            iDebitAccountID := qry.FieldByName('ExpenseAccountId').AsInteger;

          iClassID := ttREc.ClassId;
          iPayLineID := ttRec.PayLineId;
          dAmount := taRec.TaxAmount;


          Tpaybase(Self.Owner).PayTrans.LoadSelect('PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
                      ' AND Type = '+QuotedStr(sTRansType)+' AND MSType = '+QuotedStr(sMS_TransType)+
                      ' AND Description = ' + QuotedStr(sDescription) +
                      ' AND PayLineID = ' + IntToStr(iPayLineId));

          Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions(sSeqno,sTransType,sMS_TransType,
                      sDescription,iCreditAccountID,
                      iDebitAccountID,iClassID, iPayLineId,dAmount, self);
        end
        else
          raise Exception.Create(ClassName + ' - Can not post to Accounts, Pay Tax Config ID not found: ' + IntToStr(taRec.PayTaxConfigId));
      end;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;



initialization

   RegisterClassOnce(Tpaybase);

   RegisterClassOnce(TPayHistory);


end.
