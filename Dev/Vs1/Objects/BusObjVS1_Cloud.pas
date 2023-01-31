unit BusObjVS1_Cloud;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  11/08/20  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf,JsonObject,ERPDbComponents , WebAPILib,
  BusObjRegionalOptions, LogThreadBase , BusobjProduct;

type
  TVS1_ClientModules= class;
  TVS1_databases = class;
  TVS1_ClientPayments= class;
  TVS1_ClientDbServers =class;
  TVS1_ClientLicenseDetails = class;
  TVS1_Clients = class;

  TVS1_ClientModulesUsage = class(TMSBusObj)
  private
    function GetClientId            : Integer   ;
    function GetLicenseLevel        : Integer   ;
    function GetModuleId            : Integer   ;
    function GetModulePriceID       : Integer   ;
    function GetClientModuleID      : Integer   ;
    function GetDateStarted         : TDateTime ;
    function GetLicenseFrom         : TDateTime ;
    function GetLicenseUntil        : TDateTime ;
    function GetPrice               : Double    ;
    function GetRenewPrice          : Double    ;
    function GetDiscountAmt         : Double    ;
    function GetRenewDiscountAmt    : Double    ;
    function GetDiscountedPrice     : Double    ;
    function GetRenewDiscountedPrice: Double    ;
    Function getDiscountDesc        : String;
    Function getRenewDiscountDesc   : String;
    function GetmoduleDiscountId    : Integer   ;
    function GetDatePaID            : TDateTime ;
    function GetClientPaymentId     : Integer   ;
    function GetActive              : Boolean   ;
    Function getLicenseExtensionDesc: String;
    procedure SetClientId            (const Value: Integer   );
    procedure SetLicenseLevel        (const Value: Integer   );
    procedure SetModuleId            (const Value: Integer   );
    procedure SetModulePriceID       (const Value: Integer   );
    procedure SetClientModuleID      (const Value: Integer   );
    procedure SetDateStarted         (const Value: TDateTime );
    procedure SetLicenseFrom         (const Value: TDateTime );
    procedure SetLicenseUntil        (const Value: TDateTime );
    procedure SetPrice               (const Value: Double    );
    procedure SetRenewPrice          (const Value: Double    );
    procedure SetDiscountAmt         (const Value: Double    );
    procedure SetRenewDiscountAmt    (const Value: Double    );
    procedure SetDiscountedPrice     (const Value: Double    );
    procedure SetRenewDiscountedPrice(const Value: Double    );
    Procedure SetDiscountDesc        (Const Value: String    );
    Procedure SetRenewDiscountDesc   (Const Value: String    );
    procedure SetmoduleDiscountId    (const Value: Integer   );
    procedure SetDatePaID            (const Value: TDateTime );
    procedure SetClientPaymentId     (const Value: Integer   );
    procedure SetActive              (const Value: Boolean   );
    function  GetLicenseRenewDuration    : Integer   ;
    function  GetLicenseRenewDurationType: string    ;
    procedure SetLicenseRenewDuration    (const Value: Integer   );
    procedure SetLicenseRenewDurationType(const Value: string    );
    Procedure SetLicenseExtensionDesc(Const Value: String    );
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
    property ClientId             :Integer     read GetClientId             write SetClientId        ;
    property LicenseLevel         :Integer     read GetLicenseLevel         write SetLicenseLevel    ;
    property ModuleId             :Integer     read GetModuleId             write SetModuleId        ;
    property ModulePriceID        :Integer     read GetModulePriceID        write SetModulePriceID   ;
    property ClientModuleID       :Integer     read GetClientModuleID       write SetClientModuleID  ;
    property DateStarted          :TDateTime   read GetDateStarted          write SetDateStarted     ;
    property LicenseFrom          :TDateTime   read GetLicenseFrom          write SetLicenseFrom     ;
    property LicenseUntil         :TDateTime   read GetLicenseUntil         write SetLicenseUntil    ;
    property Price                :Double      read GetPrice                write SetPrice           ;
    property RenewPrice           :Double      read GetRenewPrice           write SetRenewPrice      ;
    property DiscountAmt          :Double      read GetDiscountAmt          write SetDiscountAmt     ;
    property RenewDiscountAmt     :Double      read GetRenewDiscountAmt     write SetRenewDiscountAmt;
    property DiscountedPrice      :Double      read GetDiscountedPrice      write SetDiscountedPrice ;
    property RenewDiscountedPrice :Double      read GetRenewDiscountedPrice write SetRenewDiscountedPrice ;
    Property DiscountDesc         :String      read getDiscountDesc         Write SetDiscountDesc;
    Property RenewDiscountDesc    :String      read getRenewDiscountDesc    Write SetRenewDiscountDesc;
    Property LicenseExtensionDesc :String      read getLicenseExtensionDesc Write SetLicenseExtensionDesc;
    property moduleDiscountId     :Integer     read GetmoduleDiscountId     write SetmoduleDiscountId;
    property DatePaID             :TDateTime   read GetDatePaID             write SetDatePaID        ;
    property ClientPaymentId      :Integer     read GetClientPaymentId      write SetClientPaymentId ;
    property Active               :Boolean     read GetActive               write SetActive          ;
    property LicenseRenewDuration         :Integer     read GetLicenseRenewDuration       write SetLicenseRenewDuration    ;
    property LicenseRenewDurationType     :string      read GetLicenseRenewDurationType   write SetLicenseRenewDurationType;
  end;

  TVS1_ClientUsers = class(TMSBusObj)
  private
    fsLastName: String;
    fsFirstName: String;
    function GetClientID                    : Integer   ;
    function GetVS1EmployeeId               : Integer   ;
    function GetDatabaseName                : string    ;
    function GetEmailId                     : string    ;
    function GetPassword                    : string    ;
    function GetPhone                       : string    ;
    function GetActive                      : Boolean   ;
    function GetIsAdminUser                 : Boolean   ;
    function GetIsAccountant                : Boolean   ;

    procedure SetClientID                    (const Value: Integer   );
    procedure SetVS1EmployeeId               (const Value: Integer   );
    procedure SetDatabaseName                (const Value: string    );
    procedure SetEmailId                     (const Value: string    );
    procedure SetPassword                    (const Value: string    );
    procedure SetPhone                       (const Value: string    );
    procedure SetActive                      (const Value: Boolean   );
    procedure SetIsAdminUser                 (const Value: Boolean   );
    procedure SetIsAccountant                (const Value: Boolean   );

    function getVS1_database: TVS1_databases;
    function getVS1_Client: TVS1_Clients;
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
    Property VS1_database :TVS1_databases read getVS1_database;
    Property VS1_Client : TVS1_Clients read getVS1_Client;
    Property FirstName:String read fsFirstName write fsFirstName;
    Property LastName:String read fsLastName write fsLastName;
  published
    property ClientID                     :Integer     read GetClientID                   write SetClientID                ;
    property VS1EmployeeId                :Integer     read GetVS1EmployeeId              write SetVS1EmployeeId           ;
    property DatabaseName                 :string      read GetDatabaseName               write SetDatabaseName            ;
    property EmailId                      :string      read GetEmailId                    write SetEmailId                 ;
    property Password                     :string      read GetPassword                   write SetPassword                ;
    property Phone                        :string      read GetPhone                      write SetPhone                   ;
    property Active                       :Boolean     read GetActive                     write SetActive                  ;
    property IsAdminUser                  :Boolean     read GetIsAdminUser                write SetIsAdminUser             ;
    property IsAccountant                 :Boolean     read GetIsAccountant               write SetIsAccountant            ;
  end;

  TVS1_LicenseLevels = class(TMSBusObj)
  private
    function GetLicenseOrder                : Integer   ;
    function GetUsersIncluded               : Integer   ;
    function GetDescription                 : string    ;
    function GetActive                      : Boolean   ;
    procedure SetLicenseOrder                (const Value: Integer   );
    procedure SetUsersIncluded               (const Value: Integer   );
    procedure SetDescription                 (const Value: string    );
    procedure SetActive                      (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    class function GetKeyStringField: string; override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Class Function DescriptionforLevel(aLevel:Integer):String;
  published
    property LicenseOrder                 :Integer     read GetLicenseOrder               write SetLicenseOrder            ;
    property UsersIncluded                :Integer     read GetUsersIncluded              write SetUsersIncluded           ;
    property Description                  :string      read GetDescription                write SetDescription             ;
    property Active                       :Boolean     read GetActive                     write SetActive                  ;
  end;

  TVS1_ModuleDiscount = class(TMSBusObj)
  private
    function GetDescription                 : string    ;
    function GetLicenseLevel                : Integer   ;
    function GetModuleId                    : Integer   ;
    function GetDiscount                    : Double    ;
    function GetDiscountType                : string    ;
    function GetDuration                    : Integer   ;
    function GetRegionID                    : Integer   ;
    function GetDiscountFrom                : TDateTime ;
    function GetClienttype                  : string    ;
    function GetActive                      : Boolean   ;
    procedure SetDescription                 (const Value: string    );
    procedure SetLicenseLevel                (const Value: Integer   );
    procedure SetModuleId                    (const Value: Integer   );
    procedure SetDiscount                    (const Value: Double    );
    procedure SetDiscountType                (const Value: string    );
    procedure SetDuration                    (const Value: Integer   );
    procedure SetRegionID                    (const Value: Integer   );
    procedure SetDiscountFrom                (const Value: TDateTime );
    procedure SetClienttype                  (const Value: string    );
    procedure SetActive                      (const Value: Boolean   );
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
    property Description                  :string      read GetDescription                write SetDescription             ;
    property LicenseLevel                 :Integer     read GetLicenseLevel               write SetLicenseLevel            ;
    property ModuleId                     :Integer     read GetModuleId                   write SetModuleId                ;
    property Discount                     :Double      read GetDiscount                   write SetDiscount                ;
    property DiscountType                 :string      read GetDiscountType               write SetDiscountType            ;
    property Duration                     :Integer     read GetDuration                   write SetDuration                ;
    property RegionID                     :Integer     read GetRegionID                   write SetRegionID                ;
    property DiscountFrom                 :TDateTime   read GetDiscountFrom               write SetDiscountFrom            ;
    property Clienttype                   :string      read GetClienttype                 write SetClienttype              ;
    property Active                       :Boolean     read GetActive                     write SetActive                  ;
  end;

  TVS1_Clients_Simple = class(TMSBusObj)
  private
    function GetClientName                  : string    ;
    function GetRegistrationDate            : TDateTime ;
    function GetSoftwareReleaseType         : string    ;
    function GetVS1ClientName               : string    ;
    function Getvs1ClientID                 : Integer   ;
    function GetCreditCardType              : string    ;
    function GetCreditCardCardHolderName    : string    ;
    function GetCreditCardNumber            : string    ;
    function GetCreditCardCVC               : string    ;
    function GetCreditCardExpiryMonth       : Integer   ;
    function GetCreditCardExpiryYear        : Integer   ;
    function GetCreditCardNotes             : string    ;
    function GetEmailVarified               : Boolean;
    function GetServerName                  : string    ;
    function GetDatabaseID                  : Integer   ;
    function GetDatabasename                : string    ;
    function GetSampleDatabaseID            : Integer   ;
    function GetSampledatabasename          : string    ;
    function GetRegionName                  : string    ;
    function GetActive                      : Boolean   ;
    function GetLicenseUntil                : TDateTime ;
    function GetLicenseFrom                 : TDateTime ;
    function GetLicenseLevel                : Integer   ;
    function GetLicenseRenewDuration        : Integer   ;
    function GetLicenseRenewDurationType    : string    ;
    function GetAPIPort       : Integer    ;
    function GetIsHttps       : Boolean    ;

    procedure SetClientName                  (const Value: string    );
    procedure SetRegistrationDate            (const Value: TDateTime );
    procedure SetSoftwareReleaseType         (const Value: string    );
    procedure SetVS1ClientName               (const Value: string    );
    procedure Setvs1ClientID                 (const Value: Integer   );
    procedure SetCreditCardType              (const Value: string    );
    procedure SetCreditCardCardHolderName    (const Value: string    );
    procedure SetCreditCardNumber            (const Value: string    );
    procedure SetCreditCardCVC               (const Value: string    );
    procedure SetCreditCardExpiryMonth       (const Value: Integer   );
    procedure SetCreditCardExpiryYear        (const Value: Integer   );
    procedure SetCreditCardNotes             (const Value: string    );
    procedure SetEmailVarified               (const Value: Boolean);
    procedure SetServerName                  (const Value: string    );
    procedure SetDatabaseID                  (const Value: Integer   );
    procedure SetDatabasename                (const Value: string    );
    procedure SetSampleDatabaseID            (const Value: Integer   );
    procedure SetSampledatabasename          (const Value: string    );
    procedure SetRegionName                  (const Value: string    );
    procedure SetActive                      (const Value: Boolean   );
    procedure SetLicenseUntil                (const Value: TDateTime );
    procedure SetLicenseFrom                 (const Value: TDateTime );
    procedure SetLicenseLevel                (const Value: Integer   );
    procedure SetLicenseRenewDuration        (const Value: Integer   );
    procedure SetLicenseRenewDurationType    (const Value: string    );
    procedure SetAPIPort       (const Value: Integer   );
    procedure SetIsHttps       (const Value: Boolean    );

    procedure CopyModulesToHistoryCallback(const Sender: TBusObj;var Abort: Boolean);
    procedure RenewModulesCallback(const Sender: TBusObj;var Abort: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    class function GetKeyStringField: string; override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property ClientName                   :string      read GetClientName                 write SetClientName              ;
    property RegistrationDate             :TDateTime   read GetRegistrationDate           write SetRegistrationDate        ;
    property SoftwareReleaseType          :string      read GetSoftwareReleaseType        write SetSoftwareReleaseType     ;
    property VS1ClientName                :string      read GetVS1ClientName              write SetVS1ClientName           ;
    property vs1ClientID                  :Integer     read Getvs1ClientID                write Setvs1ClientID             ;
    property CreditCardType               :string      read GetCreditCardType             write SetCreditCardType          ;
    property CreditCardCardHolderName     :string      read GetCreditCardCardHolderName   write SetCreditCardCardHolderName;
    property CreditCardNumber             :string      read GetCreditCardNumber           write SetCreditCardNumber        ;
    property CreditCardCVC                :string      read GetCreditCardCVC              write SetCreditCardCVC           ;
    property CreditCardExpiryMonth        :Integer     read GetCreditCardExpiryMonth      write SetCreditCardExpiryMonth   ;
    property CreditCardExpiryYear         :Integer     read GetCreditCardExpiryYear       write SetCreditCardExpiryYear    ;
    property CreditCardNotes              :string      read GetCreditCardNotes            write SetCreditCardNotes         ;
    property EmailVarified                :Boolean     read GetEmailVarified              write SetEmailVarified           ;
    property ServerName                   :string      read GetServerName                 write SetServerName              ;
    property DatabaseID                   :Integer     read GetDatabaseID                 write SetDatabaseID              ;
    property Databasename                 :string      read GetDatabasename               write SetDatabasename            ;
    property SampleDatabaseID             :Integer     read GetSampleDatabaseID           write SetSampleDatabaseID        ;
    property Sampledatabasename           :string      read GetSampledatabasename         write SetSampledatabasename      ;
    property RegionName                   :string      read GetRegionName                 write SetRegionName              ;
    property Active                       :Boolean     read GetActive                     write SetActive                  ;
    property LicenseUntil                 :TDateTime   read GetLicenseUntil               write SetLicenseUntil            ;
    property LicenseFrom                  :TDateTime   read GetLicenseFrom                write SetLicenseFrom             ;
    property LicenseLevel                 :Integer     read GetLicenseLevel               write SetLicenseLevel            ;
    property LicenseRenewDuration         :Integer     read GetLicenseRenewDuration       write SetLicenseRenewDuration    ;
    property LicenseRenewDurationType     :string      read GetLicenseRenewDurationType   write SetLicenseRenewDurationType;
    property APIPort        :Integer     read GetAPIPort      write SetAPIPort   ;
    property IsHttps        :Boolean     read GetIsHttps      write SetIsHttps   ;
  end;

  TVS1_Clients = clasS(TVS1_Clients_Simple)
  Private
    function getClientModulesUsage: TVS1_ClientModulesUsage;
    function getClientModules: TVS1_ClientModules;
    function getClientUsers: TVS1_ClientUsers;
    function getClientPayments: TVS1_ClientPayments;
    function getvs1_licenselevels: tvs1_licenselevels;
    function Getvs1_clientdbserver: tvs1_clientdbservers;
    function getRegionalOption: TRegionalOptions;
    function getForeignExchangeCode: String;
    function getLicenseMonths: Integer;
    function getVS1_ClientLicenseDetails(aLicensecheckdate: TDateTime = 0; aDatabaseName: String = ''): TVS1_ClientLicenseDetails;
  Protected
  Public
    Property VS1_ClientLicenseDetails[aLicensecheckdate: TDateTime = 0; aDatabaseName: String = '']: TVS1_ClientLicenseDetails read getVS1_ClientLicenseDetails;
    Property LicenseMonths :Integer read getLicenseMonths;
    Function CopyModulesToHistory:Boolean;
    Function RenewModules:TDateTime;
    function LicenseRenewDurationTypeDesc: String;
    function WebAPIURL(ERPClassname: String=''): String;
  Published
    Property ClientModulesUsage : TVS1_ClientModulesUsage read getClientModulesUsage;
    Property ClientModules      : TVS1_ClientModules      read getClientModules;
    Property ClientUsers        : TVS1_ClientUsers        read getClientUsers;
    Property ClientPayments     : TVS1_ClientPayments     read getClientPayments;
    Property VS1_licenselevels  : tvs1_licenselevels      read getvs1_licenselevels;
    Property vs1_clientdbserver : tvs1_clientdbservers    read Getvs1_clientdbserver;
    Property RegionalOption     : TRegionalOptions        read getRegionalOption;
    Property ForeignExchangeCode:String                   read getForeignExchangeCode;

  end;

  TVS1_ModulePrice = class(TMSBusObj)
  private
    function GetLicenseLevel                : Integer   ;
    function GetModuleID                    : Integer   ;
    function GetDateFrom                    : TDateTime ;
    function GetDateTo                      : TDateTime ;
    function GetPrice                       : Double    ;
    function GetRegionID                    : Integer   ;
    procedure SetLicenseLevel                (const Value: Integer   );
    procedure SetModuleID                    (const Value: Integer   );
    procedure SetDateFrom                    (const Value: TDateTime );
    procedure SetDateTo                      (const Value: TDateTime );
    procedure SetPrice                       (const Value: Double    );
    procedure SetRegionID                    (const Value: Integer   );
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
    Class Function PriceIDForLicenseLevel(aLicenseLevel:Integer):Integer;
    Class Function PriceIDForModule(aModuleID:Integer):Integer;
    Class Function PriceforID(aID:Integer):Double;
  published
    property LicenseLevel                 :Integer     read GetLicenseLevel               write SetLicenseLevel            ;
    property ModuleID                     :Integer     read GetModuleID                   write SetModuleID                ;
    property DateFrom                     :TDateTime   read GetDateFrom                   write SetDateFrom                ;
    property DateTo                       :TDateTime   read GetDateTo                     write SetDateTo                  ;
    property Price                        :Double      read GetPrice                      write SetPrice                   ;
    property RegionID                     :Integer     read GetRegionID                   write SetRegionID                ;
  end;

  TVS1_ClientPayments = class(TMSBusObj)
  private
    function GetClientId                    : Integer   ;
    function GetDateFrom                    : TDateTime ;
    function GetDateTo                      : TDateTime ;
    function GetPayment                     : Double    ;
    function GetPaidOn                      : TDateTime ;
    function GetPaymethodID                 : Integer   ;
    function GetCreditCardType              : string    ;
    function GetCreditCardCardHolderName    : string    ;
    function GetCreditCardNumber            : string    ;
    function GetCreditCardExpiryMonth       : Integer   ;
    function GetCreditCardExpiryYear        : Integer   ;
    function GetCreditCardCVC               : string    ;
    procedure SetClientId                    (const Value: Integer   );
    procedure SetDateFrom                    (const Value: TDateTime );
    procedure SetDateTo                      (const Value: TDateTime );
    procedure SetPayment                     (const Value: Double    );
    procedure SetPaidOn                      (const Value: TDateTime );
    procedure SetPaymethodID                 (const Value: Integer   );
    procedure SetCreditCardType              (const Value: string    );
    procedure SetCreditCardCardHolderName    (const Value: string    );
    procedure SetCreditCardNumber            (const Value: string    );
    procedure SetCreditCardExpiryMonth       (const Value: Integer   );
    procedure SetCreditCardExpiryYear        (const Value: Integer   );
    procedure SetCreditCardCVC               (const Value: string    );
    function getPayMethod: String;
    procedure setPayMethod(const Value: String);

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
    property ClientId                     :Integer     read GetClientId                   write SetClientId                ;
    property DateFrom                     :TDateTime   read GetDateFrom                   write SetDateFrom                ;
    property DateTo                       :TDateTime   read GetDateTo                     write SetDateTo                  ;
    property Payment                      :Double      read GetPayment                    write SetPayment                 ;
    property PaidOn                       :TDateTime   read GetPaidOn                     write SetPaidOn                  ;
    property PaymethodID                  :Integer     read GetPaymethodID                write SetPaymethodID             ;
    property CreditCardType               :string      read GetCreditCardType             write SetCreditCardType          ;
    property CreditCardCardHolderName     :string      read GetCreditCardCardHolderName   write SetCreditCardCardHolderName;
    property CreditCardNumber             :string      read GetCreditCardNumber           write SetCreditCardNumber        ;
    property CreditCardExpiryMonth        :Integer     read GetCreditCardExpiryMonth      write SetCreditCardExpiryMonth   ;
    property CreditCardExpiryYear         :Integer     read GetCreditCardExpiryYear       write SetCreditCardExpiryYear    ;
    property CreditCardCVC                :string      read GetCreditCardCVC              write SetCreditCardCVC           ;
    Property PayMethod                    :String      read getPayMethod                  write setPayMethod               ;
  end;

  TVS1_Modules = class(TMSBusObj)
  private
    function GetLicenseLevel                : Integer   ;
    function GetModuleName                  : string    ;
    function GetDescription                 : string    ;
    function GetIsExtra                     : Boolean   ;
    function GetRequiredLevel               : Integer   ;
    function GetActive                      : Boolean   ;
    procedure SetLicenseLevel                (const Value: Integer   );
    procedure SetModuleName                  (const Value: string    );
    procedure SetDescription                 (const Value: string    );
    procedure SetIsExtra                     (const Value: Boolean   );
    procedure SetRequiredLevel               (const Value: Integer   );
    procedure SetActive                      (const Value: Boolean   );
    function getClientModulesUsage: TVS1_ClientModulesUsage;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    class function GetKeyStringField: string; override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property LicenseLevel                 :Integer     read GetLicenseLevel               write SetLicenseLevel            ;
    property ModuleName                   :string      read GetModuleName                 write SetModuleName              ;
    property Description                  :string      read GetDescription                write SetDescription             ;
    property IsExtra                      :Boolean     read GetIsExtra                    write SetIsExtra                 ;
    property RequiredLevel                :Integer     read GetRequiredLevel              write SetRequiredLevel           ;
    property Active                       :Boolean     read GetActive                     write SetActive                  ;
    Property ClientModulesUsage : TVS1_ClientModulesUsage read getClientModulesUsage;
  end;

  TVS1_Databases = class(TMSBusObj)
  private
    function GetDatabaseName                : string    ;
    function GetServerName                  : string    ;
    function GetRegionname                  : string    ;
    function GetStatus                      : string    ;
    function GetCreatedOn                   : TDateTime ;
    function GetUsedOn                      : TDateTime ;
    function GetDiscontinuedOn              : TDateTime ;
    function GetVs1_ClientID                : Integer   ;
    function GetAPIPort       : Integer    ;
    function GetIsHttps       : Boolean    ;
    function GetClientID      : Integer     ;

    procedure SetDatabaseName                (const Value: string    );
    procedure SetServerName                  (const Value: string    );
    procedure SetRegionname                  (const Value: string    );
    procedure SetStatus                      (const Value: string    );
    procedure SetCreatedOn                   (const Value: TDateTime );
    procedure SetUsedOn                      (const Value: TDateTime );
    procedure SetDiscontinuedOn              (const Value: TDateTime );
    procedure SetVs1_ClientID                (const Value: Integer   );
    procedure SetClientID                    (const Value: Integer   );

    function getVS1_Clients: TVS1_Clients;
    function Getvs1_clientdbserver: tvs1_clientdbservers;
    procedure SetAPIPort       (const Value: Integer   );
    procedure SetIsHttps       (const Value: Boolean    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    class function GetKeyStringField: string; override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property VS1_Clients :TVS1_Clients Read getVS1_Clients;
    Property vs1_clientdbserver : tvs1_clientdbservers read Getvs1_clientdbserver;
    function WebAPIURL(ERPClassname: String=''): String;
  published
    property DatabaseName                 :string      read GetDatabaseName               write SetDatabaseName            ;
    property ServerName                   :string      read GetServerName                 write SetServerName              ;
    property Regionname                   :string      read GetRegionname                 write SetRegionname              ;
    property Status                       :string      read GetStatus                     write SetStatus                  ;
    property CreatedOn                    :TDateTime   read GetCreatedOn                  write SetCreatedOn               ;
    property UsedOn                       :TDateTime   read GetUsedOn                     write SetUsedOn                  ;
    property DiscontinuedOn               :TDateTime   read GetDiscontinuedOn             write SetDiscontinuedOn          ;
    property Vs1_ClientID                 :Integer     read GetVs1_ClientID               write SetVs1_ClientID            ;
    property APIPort        :Integer     read GetAPIPort      write SetAPIPort   ;
    property IsHttps        :Boolean     read GetIsHttps      write SetIsHttps   ;
    property ClientID       :Integer     read GetClientID     write SetClientID  ;
  end;

  TVS1_Databases_Main = class(TVS1_Databases)
  Public
    constructor  Create(AOwner: TComponent);                            override;
  end;

  TVS1_Databases_Sample = Class(TVS1_Databases)
  Public
    constructor  Create(AOwner: TComponent);                            override;
  End;

  TVS1_ClientModules = class(TMSBusObj)
  private
    function GetClientId            : Integer   ;
    function GetLicenseLevel        : Integer   ;
    function GetModuleId            : Integer   ;
    function GetModulePriceID       : Integer   ;
    function GetDateStarted         : TDateTime ;
    function GetLicenseFrom         : TDateTime ;
    function GetLicenseUntil        : TDateTime ;
    function GetQuantity            : Integer   ;
    function GetPrice               : Double    ;
    function GetRenewPrice          : Double    ;
    function GetDiscountAmt         : Double    ;
    function GetRenewDiscountAmt    : Double    ;
    function GetDiscountedPrice     : Double    ;
    function GetRenewDiscountedPrice: Double    ;
    Function getDiscountDesc        : String    ;
    Function getRenewDiscountDesc   : String    ;
    Function getLicenseExtensionDesc: String    ;
    function GetmoduleDiscountId    : Integer   ;
    function GetDatePaID            : TDateTime ;
    function GetClientPaymentId     : Integer   ;
    function GetDatabaseName        : String    ;
    function GetActive              : Boolean   ;
    procedure SetClientId            (const Value: Integer   );
    procedure SetLicenseLevel        (const Value: Integer   );
    procedure SetModuleId            (const Value: Integer   );
    procedure SetModulePriceID       (const Value: Integer   );
    procedure SetDateStarted         (const Value: TDateTime );
    procedure SetLicenseFrom         (const Value: TDateTime );
    procedure SetLicenseUntil        (const Value: TDateTime );
    procedure SetQuantity            (const Value: Integer  );
    procedure SetPrice               (const Value: Double    );
    procedure SetRenewPrice          (const Value: Double    );
    procedure SetDiscountAmt         (const Value: Double    );
    procedure SetRenewDiscountAmt    (const Value: Double    );
    procedure SetDiscountedPrice     (const Value: Double    );
    procedure SetRenewDiscountedPrice(const Value: Double    );
    Procedure SetDiscountDesc        (Const Value: String    );
    Procedure SetRenewDiscountDesc   (Const Value: String    );
    Procedure SetLicenseExtensionDesc(Const Value: String    );
    procedure SetmoduleDiscountId    (const Value: Integer   );
    procedure SetDatePaID            (const Value: TDateTime );
    procedure SetClientPaymentId     (const Value: Integer   );
    procedure SetDatabaseName        (const Value: String   );
    procedure SetActive              (const Value: Boolean   );
    function GetLicenseRenewDuration        : Integer   ;
    function GetLicenseRenewDurationType    : string    ;
    procedure SetLicenseRenewDuration        (const Value: Integer   );
    procedure SetLicenseRenewDurationType    (const Value: string    );
    function GetCleanLicenseFrom: TDateTime;
    function GetCleanLicenseUntil: TDateTime;
    function getClientModulesUsage: TVS1_ClientModulesUsage;
    function getProduct: TProductsimple;
    function getLicenseLevelDesc: String;
    function getModuleName: String;
    function getVS1_Clients: TVS1_Clients;
    function getVS1_ClientModulesUsage: TVS1_ClientModulesUsage;
    function getDiscountdescription: String;
    function getcleanLicenseLevel: Integer;
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
    Procedure RenewModule;
    property CleanLicenseFrom      :TDateTime   read GetCleanLicenseFrom    ;
    property CleanLicenseUntil     :TDateTime   read GetCleanLicenseUntil   ;
    Property cleanLicenseLevel     :Integer     read getcleanLicenseLevel;
    //Procedure CalcPrice;
    Property Product :TProductsimple read getProduct;
    Property ModuleName:String read getModuleName;
    Property LicenseLevelDesc :String read getLicenseLevelDesc;
    Property VS1_Clients :TVS1_Clients Read getVS1_Clients;
    Property VS1_ClientModulesUsage : TVS1_ClientModulesUsage read getVS1_ClientModulesUsage;
    Property Discountdescription :String read getDiscountdescription;

  published
    property ClientId             :Integer     read GetClientId             write SetClientId        ;
    property LicenseLevel         :Integer     read GetLicenseLevel         write SetLicenseLevel    ;
    property ModuleId             :Integer     read GetModuleId             write SetModuleId        ;
    property ModulePriceID        :Integer     read GetModulePriceID        write SetModulePriceID   ;
    property DateStarted          :TDateTime   read GetDateStarted          write SetDateStarted     ;
    property LicenseFrom          :TDateTime   read GetLicenseFrom          write SetLicenseFrom     ;
    property LicenseUntil         :TDateTime   read GetLicenseUntil         write SetLicenseUntil    ;
    property Quantity             :Integer     read GetQuantity             write SetQuantity        ;
    property Price                :Double      read GetPrice                write SetPrice           ;
    property RenewPrice           :Double      read GetRenewPrice           write SetRenewPrice      ;
    property DiscountAmt          :Double      read GetDiscountAmt          write SetDiscountAmt     ;
    property RenewDiscountAmt     :Double      read GetRenewDiscountAmt     write SetRenewDiscountAmt;
    property DiscountedPrice      :Double      read GetDiscountedPrice      write SetDiscountedPrice ;
    property RenewDiscountedPrice :Double      read GetRenewDiscountedPrice write SetRenewDiscountedPrice ;
    Property DiscountDesc         :String      read getDiscountDesc         write setDiscountDesc;
    Property RenewDiscountDesc    :String      read getRenewDiscountDesc    write setRenewDiscountDesc;
    Property LicenseExtensionDesc :String      read getLicenseExtensionDesc write setLicenseExtensionDesc;
    property moduleDiscountId     :Integer     read GetmoduleDiscountId     write SetmoduleDiscountId;
    property DatePaID             :TDateTime   read GetDatePaID             write SetDatePaID        ;
    property ClientPaymentId      :Integer     read GetClientPaymentId      write SetClientPaymentId ;
    property DatabaseName         :String      read GetDatabaseName         write SetDatabaseName    ;
    property Active               :Boolean     read GetActive               write SetActive          ;
    property LicenseRenewDuration         :Integer     read GetLicenseRenewDuration       write SetLicenseRenewDuration    ;
    property LicenseRenewDurationType     :string      read GetLicenseRenewDurationType   write SetLicenseRenewDurationType;
    Property ClientModulesUsage : TVS1_ClientModulesUsage read getClientModulesUsage;
  end;

  TVS1_ClientDbServers = class(TMSBusObj)
  private
    function GetRegionId      : Integer   ;
    function GetServerName    : string    ;
    function GetAdminDB       : string    ;
    function GetAdminUser     : string    ;
    function GetAdminPass     : string    ;
    function GetAPIPort       : Integer    ;
    function GetIsHttps       : Boolean    ;
    procedure SetRegionId      (const Value: Integer   );
    procedure SetServerName    (const Value: string    );
    procedure SetAdminDB       (const Value: string    );
    procedure SetAdminUser     (const Value: string    );
    procedure SetAdminPass     (const Value: string    );
    procedure SetIsHttps       (const Value: Boolean    );
    procedure SetAPIPort       (const Value: Integer   );
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
    function WebAPIURL(ERPClassname: String=''): String;
  published
    property RegionId       :Integer     read GetRegionId     write SetRegionId  ;
    property ServerName     :string      read GetServerName   write SetServerName;
    property AdminDB        :string      read GetAdminDB      write SetAdminDB   ;
    property AdminUser      :string      read GetAdminUser    write SetAdminUser ;
    property AdminPass      :string      read GetAdminPass    write SetAdminPass ;
    property APIPort        :Integer     read GetAPIPort      write SetAPIPort   ;
    property IsHttps        :Boolean     read GetIsHttps      write SetIsHttps   ;
  end;

  TVS1_ClientDbServerSearch = Class(TVS1_ClientDbServers)
  Private
  Protected
  Public
    constructor  Create(AOwner: TComponent);                            override;
  Published
  End;

  TVS1_ClientLicenseDetails = class(TMSBusObj)
  private
    fdLicenseCheckDate: TDateTime;
    fiClientID: Integer;
    fsDatabaseName: String;
    function GetDatabaseName    : string    ;
    function GetRegionname      : string    ;
    function GetServerName      : string    ;
    function GetAPIPort         : Integer   ;
    function GetIsHttps         : Boolean    ;
    function GetLicenseFrom     : TDateTime ;
    function GetLicenseUntil    : TDateTime ;
    function GetLicenseLevelDesc: string    ;
    function GetModuleName      : string    ;
    function GetExtraModule     : Boolean   ;
    function GetModuleActive    : Boolean   ;
    function GetModuleQty       : Integer   ;
    Procedure MakeSQL;
    Procedure MakeSQL2;
    procedure SetClientID(const Value: Integer);
    procedure SetLicenseCheckDate(const Value: TDatetime);
    procedure SetDBName(const Value: String);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforeopen(Sender :TDataset) : Boolean;            override;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                   Overload;override;
    constructor  Create(AOwner: TComponent; aClientID:Integer; aLicensecheckdate: TDateTime = 0; aDatabaseName: String = ''); Overload;
    destructor   Destroy;                                               override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property LicenseCheckdate: TDatetime read fdLicensecheckdate write SetLicenseCheckDate;
    Property ClientID: Integer read fiClientID write SetClientID;
    Property DBName: String read fsDatabaseName write SetDBName;
    function WebAPIURL(ERPClassname: String=''): String;

  published
    property DatabaseName     :string      read GetDatabaseName   ;
    property Regionname       :string      read GetRegionname     ;
    property ServerName       :string      read GetServerName     ;
    property APIPort          :Integer     read GetAPIPort        ;
    property IsHttps          :Boolean     read GetIsHttps     ;
    property LicenseFrom      :TDateTime   read GetLicenseFrom    ;
    property LicenseUntil     :TDateTime   read GetLicenseUntil   ;
    property LicenseLevelDesc :string      read GetLicenseLevelDesc    ;
    property ModuleName       :string      read GetModuleName     ;
    property ExtraModule      :Boolean     read GetExtraModule    ;
    property ModuleActive     :Boolean     read GetModuleActive   ;
    property ModuleQty        :Integer     read GetModuleQty      ;
  end;

  function LicenseMonthEnd(aDate: TDate; NoofMonths:Integer): TDate;

implementation


uses tcDataUtils, CommonLib, BusObjClient, sysutils, RandomUtils,
  utServerTask, WebApiConst, busobjcompinfo, BusObjEmployee, BusObjUser, DNMLib , LogMessageTypes,
  utVS1Const, BusObjConst, dateutils, DbSharedObjectsObj, AppEnvironment,
  VS1Lib, MySQLConst, busobjPaymethods, LogLib, tcConst, BusObjCurrency;

  {TVS1_ClientModulesUsage}

constructor TVS1_ClientModulesUsage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1_clientmodulesusage';
  fSQL := 'SELECT * From tblVS1_ClientModulesUsage';
end;


destructor TVS1_ClientModulesUsage.Destroy;
begin
  inherited;
end;


procedure TVS1_ClientModulesUsage.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ClientId');
  SetPropertyFromNode(node,'LicenseLevel');
  SetPropertyFromNode(node,'ModuleId');
  SetPropertyFromNode(node,'ModulePriceID');
  SetPropertyFromNode(node,'ClientModuleID');
  SetDateTimePropertyFromNode(node,'DateStarted');
  SetDateTimePropertyFromNode(node,'LicenseFrom');
  SetDateTimePropertyFromNode(node,'LicenseUntil');
  SetPropertyFromNode(node,'Price');
  SetPropertyFromNode(node,'RenewPrice');
  SetPropertyFromNode(node,'DiscountAmt');
  SetPropertyFromNode(node,'RenewDiscountAmt');
  SetPropertyFromNode(node,'DiscountedPrice');
  SetPropertyFromNode(node,'RenewDiscountedPrice');
  SetPropertyFromNode(node,'DiscountDesc');
  SetPropertyFromNode(node,'RenewDiscountDesc');
  SetPropertyFromNode(node,'LicenseExtensionDesc');
  SetPropertyFromNode(node,'moduleDiscountId');
  SetDateTimePropertyFromNode(node,'DatePaID');
  SetPropertyFromNode(node,'ClientPaymentId');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TVS1_ClientModulesUsage.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ClientId' ,ClientId);
  AddXMLNode(node,'LicenseLevel' ,LicenseLevel);
  AddXMLNode(node,'ModuleId' ,ModuleId);
  AddXMLNode(node,'ModulePriceID' ,ModulePriceID);
  AddXMLNode(node,'ClientModuleID' ,ClientModuleID);
  AddXMLNode(node,'DateStarted' ,DateStarted);
  AddXMLNode(node,'LicenseFrom' ,LicenseFrom);
  AddXMLNode(node,'LicenseUntil' ,LicenseUntil);
  AddXMLNode(node,'Price' ,Price);
  AddXMLNode(node,'RenewPrice' ,RenewPrice);
  AddXMLNode(node,'DiscountAmt' ,DiscountAmt);
  AddXMLNode(node,'RenewDiscountAmt' ,RenewDiscountAmt);
  AddXMLNode(node,'DiscountedPrice' ,DiscountedPrice);
  AddXMLNode(node,'RenewDiscountedPrice' ,RenewDiscountedPrice);
  AddXMLNode(node,'DiscountDesc',DiscountDesc);
  AddXMLNode(node,'RenewDiscountDesc',RenewDiscountDesc);
  AddXMLNode(node,'LicenseExtensionDesc',LicenseExtensionDesc);
  AddXMLNode(node,'moduleDiscountId' ,moduleDiscountId);
  AddXMLNode(node,'DatePaID' ,DatePaID);
  AddXMLNode(node,'ClientPaymentId' ,ClientPaymentId);
  AddXMLNode(node,'Active' ,Active);
end;


function TVS1_ClientModulesUsage.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TVS1_ClientModulesUsage.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TVS1_ClientModulesUsage.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TVS1_ClientModulesUsage.DoFieldOnChange(Sender: TField);
begin
   inherited;
end;


function TVS1_ClientModulesUsage.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TVS1_ClientModulesUsage.GetIDField: string;
begin
  Result := 'ID'
end;


class function TVS1_ClientModulesUsage.GetBusObjectTablename: string;
begin
  Result:= 'tblVS1_ClientModulesUsage';
end;


function TVS1_ClientModulesUsage.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TVS1_ClientModulesUsage.GetClientId             : Integer   ; begin Result := GetIntegerField('ClientId');end;
function  TVS1_ClientModulesUsage.GetLicenseLevel         : Integer   ; begin Result := GetIntegerField('LicenseLevel');end;
function  TVS1_ClientModulesUsage.GetModuleId             : Integer   ; begin Result := GetIntegerField('ModuleId');end;
function  TVS1_ClientModulesUsage.GetModulePriceID        : Integer   ; begin Result := GetIntegerField('ModulePriceID');end;
function  TVS1_ClientModulesUsage.GetClientModuleID       : Integer   ; begin Result := GetIntegerField('ClientModuleID');end;
function  TVS1_ClientModulesUsage.GetDateStarted          : TDateTime ; begin Result := GetDateTimeField('DateStarted');end;
function  TVS1_ClientModulesUsage.GetLicenseFrom          : TDateTime ; begin Result := GetDateTimeField('LicenseFrom');end;
function  TVS1_ClientModulesUsage.GetLicenseUntil         : TDateTime ; begin Result := GetDateTimeField('LicenseUntil');end;
function  TVS1_ClientModulesUsage.GetPrice                : Double    ; begin Result := GetFloatField('Price');end;
function  TVS1_ClientModulesUsage.GetRenewPrice           : Double    ; begin Result := GetFloatField('RenewPrice');end;
function  TVS1_ClientModulesUsage.GetDiscountAmt          : Double    ; begin Result := GetFloatField('DiscountAmt');end;
function  TVS1_ClientModulesUsage.GetRenewDiscountAmt     : Double    ; begin Result := GetFloatField('RenewDiscountAmt');end;
function  TVS1_ClientModulesUsage.GetDiscountedPrice      : Double    ; begin Result := GetFloatField('DiscountedPrice');end;
function  TVS1_ClientModulesUsage.GetRenewDiscountedPrice : Double    ; begin Result := GetFloatField('RenewDiscountedPrice');end;
function  TVS1_ClientModulesUsage.GetDiscountDesc         : String    ; begin Result := GetStringfield('DiscountDesc');end;
function  TVS1_ClientModulesUsage.GetRenewDiscountDesc    : String    ; begin Result := GetStringfield('RenewDiscountDesc');end;
function  TVS1_ClientModulesUsage.GetLicenseExtensionDesc : String    ; begin Result := GetStringfield('LicenseExtensionDesc');end;
function  TVS1_ClientModulesUsage.GetmoduleDiscountId     : Integer   ; begin Result := GetIntegerField('moduleDiscountId');end;
function  TVS1_ClientModulesUsage.GetDatePaID             : TDateTime ; begin Result := GetDateTimeField('DatePaID');end;
function  TVS1_ClientModulesUsage.GetClientPaymentId      : Integer   ; begin Result := GetIntegerField('ClientPaymentId');end;
function  TVS1_ClientModulesUsage.GetActive               : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TVS1_ClientModulesUsage.SetClientId             (const Value: Integer   ); begin SetIntegerField('ClientId'         , Value);end;
procedure TVS1_ClientModulesUsage.SetLicenseLevel         (const Value: Integer   ); begin SetIntegerField('LicenseLevel'     , Value);end;
procedure TVS1_ClientModulesUsage.SetModuleId             (const Value: Integer   ); begin SetIntegerField('ModuleId'         , Value);end;
procedure TVS1_ClientModulesUsage.SetModulePriceID        (const Value: Integer   ); begin SetIntegerField('ModulePriceID'    , Value);end;
procedure TVS1_ClientModulesUsage.SetClientModuleID       (const Value: Integer   ); begin SetIntegerField('ClientModuleID'   , Value);end;
procedure TVS1_ClientModulesUsage.SetDateStarted          (const Value: TDateTime ); begin SetDateTimeField('DateStarted'      , Value);end;
procedure TVS1_ClientModulesUsage.SetLicenseFrom          (const Value: TDateTime ); begin SetDateTimeField('LicenseFrom'      , Value);end;
procedure TVS1_ClientModulesUsage.SetLicenseUntil         (const Value: TDateTime ); begin SetDateTimeField('LicenseUntil'     , Value);end;
procedure TVS1_ClientModulesUsage.SetPrice                (const Value: Double    ); begin SetFloatField('Price'            , Value);end;
procedure TVS1_ClientModulesUsage.SetRenewPrice           (const Value: Double    ); begin SetFloatField('RenewPrice'            , Value);end;
procedure TVS1_ClientModulesUsage.SetDiscountAmt          (const Value: Double    ); begin SetFloatField('DiscountAmt'      , Value);end;
procedure TVS1_ClientModulesUsage.SetRenewDiscountAmt     (const Value: Double    ); begin SetFloatField('RenewDiscountAmt'      , Value);end;
procedure TVS1_ClientModulesUsage.SetDiscountedPrice      (const Value: Double    ); begin SetFloatField('DiscountedPrice' , Value);end;
procedure TVS1_ClientModulesUsage.SetRenewDiscountedPrice (const Value: Double    ); begin SetFloatField('RenewDiscountedPrice' , Value);end;
procedure TVS1_ClientModulesUsage.SetDiscountDesc         (Const Value: String    ); begin SetStringField('DiscountDesc', Value); end;
procedure TVS1_ClientModulesUsage.SetRenewDiscountDesc    (Const Value: String    ); begin SetStringField('RenewDiscountDesc', Value); end;
procedure TVS1_ClientModulesUsage.SetLicenseExtensionDesc (Const Value: String    ); begin SetStringField('LicenseExtensionDesc', Value); end;
procedure TVS1_ClientModulesUsage.SetmoduleDiscountId     (const Value: Integer   ); begin SetIntegerField('moduleDiscountId' , Value);end;
procedure TVS1_ClientModulesUsage.SetDatePaID             (const Value: TDateTime ); begin SetDateTimeField('DatePaID'         , Value);end;
procedure TVS1_ClientModulesUsage.SetClientPaymentId      (const Value: Integer   ); begin SetIntegerField('ClientPaymentId' , Value);end;
procedure TVS1_ClientModulesUsage.SetActive               (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;
function  TVS1_ClientModulesUsage.GetLicenseRenewDuration    : Integer   ; begin Result := GetIntegerField('LicenseRenewDuration'); if result <1 then result := 1;end;
function  TVS1_ClientModulesUsage.GetLicenseRenewDurationType: string    ; begin Result := GetStringField('LicenseRenewDurationType');if (result<>'M') and (Result<>'Y') then Result :='M'; end;
procedure TVS1_ClientModulesUsage.SetLicenseRenewDuration    (const Value: Integer   ); begin SetIntegerField('LicenseRenewDuration'     , Value);end;
procedure TVS1_ClientModulesUsage.SetLicenseRenewDurationType(const Value: string    ); begin SetStringField('LicenseRenewDurationType', Value); if (Value<>'M') and (Value<>'Y') then SetStringField('LicenseRenewDurationType', 'M');  end;


constructor TVS1_ClientUsers.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1_clientusers';
  fSQL := 'SELECT * From tblVS1_ClientUsers';
end;


destructor TVS1_ClientUsers.Destroy;
begin
  inherited;
end;


procedure TVS1_ClientUsers.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ClientID');
  SetPropertyFromNode(node,'VS1EmployeeId');
  SetPropertyFromNode(node,'DatabaseName');
  SetPropertyFromNode(node,'EmailId');
  SetPropertyFromNode(node,'Password');
  SetPropertyFromNode(node,'Phone');
  SetBooleanPropertyFromNode(node,'Active');
  SetBooleanPropertyFromNode(node,'IsAdminUser');
end;


procedure TVS1_ClientUsers.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ClientID' ,ClientID);
  AddXMLNode(node,'VS1EmployeeId' ,VS1EmployeeId);
  AddXMLNode(node,'DatabaseName' ,DatabaseName);
  AddXMLNode(node,'EmailId' ,EmailId);
  AddXMLNode(node,'Password' ,Password);
  AddXMLNode(node,'Phone' ,Phone);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'IsAdminUser' ,IsAdminUser);
end;


function TVS1_ClientUsers.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TVS1_ClientUsers.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TVS1_ClientUsers.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TVS1_ClientUsers.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TVS1_ClientUsers.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TVS1_ClientUsers.GetIDField: string;
begin
  Result := 'ID'
end;


class function TVS1_ClientUsers.GetBusObjectTablename: string;
begin
  Result:= 'tblVS1_ClientUsers';
end;


function TVS1_ClientUsers.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  if Assigned(Owner) then
    if Owner is TVS1_Clients then
      ClientID := TVS1_Clients(Owner).ID;
end;

function TVS1_ClientUsers.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TVS1_ClientUsers.GetClientID                : Integer   ; begin Result := GetIntegerField('ClientID');end;
function  TVS1_ClientUsers.GetVS1EmployeeId           : Integer   ; begin Result := GetIntegerField('VS1EmployeeId');end;
function  TVS1_ClientUsers.GetDatabaseName            : string    ; begin Result := GetStringField('DatabaseName');end;
function  TVS1_ClientUsers.GetEmailId                 : string    ; begin Result := GetStringField('EmailId');end;
function  TVS1_ClientUsers.GetPassword                : string    ; begin Result := GetStringField('Password');end;
function  TVS1_ClientUsers.GetPhone                   : string    ; begin Result := GetStringField('Phone');end;
function  TVS1_ClientUsers.GetActive                  : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TVS1_ClientUsers.GetIsAdminUser             : Boolean   ; begin Result := GetBooleanField('IsAdminUser');end;
function  TVS1_ClientUsers.GetIsAccountant            : Boolean   ; begin Result := GetBooleanField('IsAccountant');end;

procedure TVS1_ClientUsers.SetClientID                (const Value: Integer   ); begin SetIntegerField('ClientID'                , Value);end;
procedure TVS1_ClientUsers.SetVS1EmployeeId           (const Value: Integer   ); begin SetIntegerField('VS1EmployeeId'           , Value);end;
procedure TVS1_ClientUsers.SetDatabaseName            (const Value: string    ); begin SetStringField('DatabaseName'             , Value);end;
procedure TVS1_ClientUsers.SetEmailId                 (const Value: string    ); begin SetStringField('EmailId'                  , Value);end;
procedure TVS1_ClientUsers.SetPassword                (const Value: string    ); begin SetStringField('Password'                 , Value);end;
procedure TVS1_ClientUsers.SetPhone                   (const Value: string    ); begin SetStringField('Phone'                    , Value);end;
procedure TVS1_ClientUsers.SetActive                  (const Value: Boolean   ); begin SetBooleanField('Active'                  , Value);end;
procedure TVS1_ClientUsers.SetIsAdminUser             (const Value: Boolean   ); begin SetBooleanField('IsAdminUser'             , Value);end;
procedure TVS1_ClientUsers.SetIsAccountant            (const Value: Boolean   ); begin SetBooleanField('IsAccountant'            , Value);end;

function TVS1_ClientUsers.getVS1_Client: TVS1_Clients;
begin
  Result := TVS1_Clients(getContainercomponent(TVS1_Clients, 'ID = ' + IntToStr(ClientId)));
end;

function TVS1_ClientUsers.getVS1_database: TVS1_databases;
begin
  Result := TVS1_databases(getContainercomponent(TVS1_databases, 'DatabaseName = ' + quotedstr(DatabaseName) ));
end;


  {TVS1_LicenseLevels}

constructor TVS1_LicenseLevels.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1_licenselevels';
  fSQL := 'SELECT * From tblVS1_LicenseLevels';
end;


class function TVS1_LicenseLevels.DescriptionforLevel(aLevel: Integer): String;
begin
  REsult := TVS1_LicenseLevels.IDToggle(TVS1_LicenseLevels.IDToggle('LicenseOrder' , inttostr(aLevel)));
end;

destructor TVS1_LicenseLevels.Destroy;
begin
  inherited;
end;


procedure TVS1_LicenseLevels.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'LicenseOrder');
  SetPropertyFromNode(node,'UsersIncluded');
  SetPropertyFromNode(node,'Description');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TVS1_LicenseLevels.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'LicenseOrder' ,LicenseOrder);
  AddXMLNode(node,'UsersIncluded' ,UsersIncluded);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'Active' ,Active);
end;


function TVS1_LicenseLevels.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TVS1_LicenseLevels.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TVS1_LicenseLevels.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TVS1_LicenseLevels.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TVS1_LicenseLevels.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TVS1_LicenseLevels.GetIDField: string;
begin
  Result := 'ID'
end;


class function TVS1_LicenseLevels.GetBusObjectTablename: string;
begin
  Result:= 'tblVS1_LicenseLevels';
end;


function TVS1_LicenseLevels.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TVS1_LicenseLevels.GetLicenseOrder            : Integer   ; begin Result := GetIntegerField('LicenseOrder');end;
function  TVS1_LicenseLevels.GetUsersIncluded           : Integer   ; begin Result := GetIntegerField('UsersIncluded');end;
function  TVS1_LicenseLevels.GetDescription             : string    ; begin Result := GetStringField('Description');end;
function  TVS1_LicenseLevels.GetActive                  : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TVS1_LicenseLevels.SetLicenseOrder            (const Value: Integer   ); begin SetIntegerField('LicenseOrder'             , Value);end;
procedure TVS1_LicenseLevels.SetUsersIncluded           (const Value: Integer   ); begin SetIntegerField('UsersIncluded'            , Value);end;
procedure TVS1_LicenseLevels.SetDescription             (const Value: string    ); begin SetStringField('Description'              , Value);end;
procedure TVS1_LicenseLevels.SetActive                  (const Value: Boolean   ); begin SetBooleanField('Active'                   , Value);end;
class function Tvs1_licenselevels.GetKeyStringField: string;
begin
  Result :='Description';
end;


{TVS1_ModuleDiscount}

constructor TVS1_ModuleDiscount.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1_modulediscount';
  fSQL := 'SELECT * From tblVS1_ModuleDiscount Where (ifnull(RegionID,0)=0 or RegionID =' + inttostr(AppEnv.RegionalOptions.ID)+')';
end;


destructor TVS1_ModuleDiscount.Destroy;
begin
  inherited;
end;


procedure TVS1_ModuleDiscount.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'LicenseLevel');
  SetPropertyFromNode(node,'ModuleId');
  SetPropertyFromNode(node,'Discount');
  SetPropertyFromNode(node,'DiscountType');
  SetPropertyFromNode(node,'Duration');
  SetPropertyFromNode(node,'RegionID');
  SetDateTimePropertyFromNode(node,'DiscountFrom');
  SetPropertyFromNode(node,'Clienttype');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TVS1_ModuleDiscount.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'LicenseLevel' ,LicenseLevel);
  AddXMLNode(node,'ModuleId' ,ModuleId);
  AddXMLNode(node,'Discount' ,Discount);
  AddXMLNode(node,'DiscountType' ,DiscountType);
  AddXMLNode(node,'Duration' ,Duration);
  AddXMLNode(node,'RegionID' ,RegionID);
  AddXMLNode(node,'DiscountFrom' ,DiscountFrom);
  AddXMLNode(node,'Clienttype' ,Clienttype);
  AddXMLNode(node,'Active' ,Active);
end;


function TVS1_ModuleDiscount.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TVS1_ModuleDiscount.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TVS1_ModuleDiscount.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TVS1_ModuleDiscount.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TVS1_ModuleDiscount.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TVS1_ModuleDiscount.GetIDField: string;
begin
  Result := 'ID'
end;


class function TVS1_ModuleDiscount.GetBusObjectTablename: string;
begin
  Result:= 'tblVS1_ModuleDiscount';
end;


function TVS1_ModuleDiscount.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TVS1_ModuleDiscount.GetDescription             : string    ; begin Result := GetStringField('Description');end;
function  TVS1_ModuleDiscount.GetLicenseLevel            : Integer   ; begin Result := GetIntegerField('LicenseLevel');end;
function  TVS1_ModuleDiscount.GetModuleId                : Integer   ; begin Result := GetIntegerField('ModuleId');end;
function  TVS1_ModuleDiscount.GetDiscount                : Double    ; begin Result := GetFloatField('Discount');end;
function  TVS1_ModuleDiscount.GetDiscountType            : string    ; begin Result := GetStringField('DiscountType');end;
function  TVS1_ModuleDiscount.GetDuration                : Integer   ; begin Result := GetIntegerField('Duration');end;
function  TVS1_ModuleDiscount.GetRegionID                : Integer   ; begin Result := GetIntegerField('RegionID');end;
function  TVS1_ModuleDiscount.GetDiscountFrom            : TDateTime ; begin Result := GetDateTimeField('DiscountFrom');end;
function  TVS1_ModuleDiscount.GetClienttype              : string    ; begin Result := GetStringField('Clienttype');end;
function  TVS1_ModuleDiscount.GetActive                  : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TVS1_ModuleDiscount.SetDescription             (const Value: string    ); begin SetStringField('Description'              , Value);end;
procedure TVS1_ModuleDiscount.SetLicenseLevel            (const Value: Integer   ); begin SetIntegerField('LicenseLevel'             , Value);end;
procedure TVS1_ModuleDiscount.SetModuleId                (const Value: Integer   ); begin SetIntegerField('ModuleId'                 , Value);end;
procedure TVS1_ModuleDiscount.SetDiscount                (const Value: Double    ); begin SetFloatField('Discount'                 , Value);end;
procedure TVS1_ModuleDiscount.SetDiscountType            (const Value: string    ); begin SetStringField('DiscountType'             , Value);end;
procedure TVS1_ModuleDiscount.SetDuration                (const Value: Integer   ); begin SetIntegerField('Duration'                 , Value);end;
procedure TVS1_ModuleDiscount.SetRegionID                (const Value: Integer   ); begin SetIntegerField('RegionID'                 , Value);end;
procedure TVS1_ModuleDiscount.SetDiscountFrom            (const Value: TDateTime ); begin SetDateTimeField('DiscountFrom'             , Value);end;
procedure TVS1_ModuleDiscount.SetClienttype              (const Value: string    ); begin SetStringField('Clienttype'               , Value);end;
procedure TVS1_ModuleDiscount.SetActive                  (const Value: Boolean   ); begin SetBooleanField('Active'                   , Value);end;


  {TVS1_Clients_Simple}
Function TVS1_Clients.RenewModules:TDateTime;
begin
  Result := LicenseUntil;
  if ClientModules.count =0 then begin
    Exit;
  end;
  REsult := ClientModules.LicenseUntil;
  ClientModules.IterateRecords(RenewModulesCallback);

  if LicenseUntil =0 then LicenseFrom := date
  else LicenseFrom := incday(LicenseUntil, 1);
  LicenseUntil :=LicenseMonthEnd(LicenseFrom , LicenseMonths );
  PostDB;
  SendEvent(BusObjEvent_ToDo, BusObjEventCall_RenewLicense);
  REsult := LicenseFrom ;
end;
function TVS1_Clients.LicenseRenewDurationTypeDesc: String;
begin
  if LicenseRenewDurationType ='Y' then result := 'Y' else REsult := 'Month';
end;
Procedure TVS1_Clients_Simple.RenewModulesCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is TVS1_clientModules then begin
    TVS1_clientModules(Sender).RenewModule;
  end;
end;

Function TVS1_Clients.CopyModulesToHistory:boolean;
begin
  Result := False;
  if ClientModules.count =0 then begin
    Result := True;
    Exit;
  end;
  ClientModules.IterateRecords(CopyModulesToHistoryCallback);
end;
Procedure TVS1_Clients_Simple.CopyModulesToHistoryCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is TVS1_clientModules then begin
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.closedb;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.OpenDB;
    if TVS1_clientModules(Sender).VS1_ClientModulesUsage.count >0 then exit;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.New;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.ClientId	                :=	TVS1_clientModules(Sender).ClientId;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.LicenseLevel	            :=	TVS1_clientModules(Sender).LicenseLevel;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.LicenseRenewDurationType	:=	TVS1_clientModules(Sender).LicenseRenewDurationType;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.LicenseRenewDuration	    :=	TVS1_clientModules(Sender).LicenseRenewDuration;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.ModuleId	                :=	TVS1_clientModules(Sender).ModuleId;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.ModulePriceID	            :=	TVS1_clientModules(Sender).ModulePriceID;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.ClientModuleID	          :=	TVS1_clientModules(Sender).ID;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.DateStarted	              :=	TVS1_clientModules(Sender).DateStarted;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.LicenseFrom	              :=	TVS1_clientModules(Sender).LicenseFrom;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.LicenseUntil	            :=	TVS1_clientModules(Sender).LicenseUntil;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.Price	                    :=	TVS1_clientModules(Sender).Price;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.DiscountAmt	              :=	TVS1_clientModules(Sender).DiscountAmt;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.DiscountedPrice	          :=	TVS1_clientModules(Sender).DiscountedPrice;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.RenewPrice	              :=	TVS1_clientModules(Sender).RenewPrice;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.RenewDiscountAmt          :=	TVS1_clientModules(Sender).RenewDiscountAmt;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.RenewDiscountedPrice      :=	TVS1_clientModules(Sender).RenewDiscountedPrice;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.DiscountDesc              :=	TVS1_clientModules(Sender).DiscountDesc;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.RenewDiscountDesc         :=	TVS1_clientModules(Sender).RenewDiscountDesc;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.LicenseExtensionDesc      :=	TVS1_clientModules(Sender).LicenseExtensionDesc;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.moduleDiscountId	        :=	TVS1_clientModules(Sender).moduleDiscountId;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.DatePaid	                :=	TVS1_clientModules(Sender).DatePaid;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.ClientPaymentId	          :=	TVS1_clientModules(Sender).ClientPaymentId;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.LicenseExtensionDesc      :=  TVS1_clientModules(Sender).LicenseExtensionDesc;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.Active	                  :=	TVS1_clientModules(Sender).Active;
    TVS1_clientModules(Sender).VS1_ClientModulesUsage.PostDB;

    TVS1_clientModules(Sender).Price	              :=	TVS1_clientModules(Sender).RenewPrice;
    TVS1_clientModules(Sender).DiscountAmt          :=	TVS1_clientModules(Sender).RenewDiscountAmt;
    TVS1_clientModules(Sender).DiscountedPrice      :=	TVS1_clientModules(Sender).RenewDiscountedPrice;
    TVS1_clientModules(Sender).PostDB;

  end;
end;
constructor TVS1_Clients_Simple.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1_clients';
  fSQL := 'SELECT * From tblVS1_Clients';
end;


destructor TVS1_Clients_Simple.Destroy;
begin
  inherited;
end;


procedure TVS1_Clients_Simple.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ClientName');
  SetDateTimePropertyFromNode(node,'RegistrationDate');
  SetDateTimePropertyFromNode(node,'LicenseUntil');
  SetDateTimePropertyFromNode(node,'LicenseFrom');
  SetPropertyFromNode(node,'SoftwareReleaseType');
  SetPropertyFromNode(node,'VS1ClientName');
  SetPropertyFromNode(node,'vs1ClientID');
  SetPropertyFromNode(node,'CreditCardType');
  SetPropertyFromNode(node,'CreditCardCardHolderName');
  SetPropertyFromNode(node,'CreditCardNumber');
  SetPropertyFromNode(node,'CreditCardCVC');
  SetPropertyFromNode(node,'CreditCardExpiryMonth');
  SetPropertyFromNode(node,'CreditCardExpiryYear');
  SetPropertyFromNode(node,'CreditCardNotes');
  SetBooleanPropertyFromNode(node,'EmailVarified');
  SetPropertyFromNode(node,'ServerName');
  SetPropertyFromNode(node,'DatabaseID');
  SetPropertyFromNode(node,'Databasename');
  SetPropertyFromNode(node,'SampleDatabaseID');
  SetPropertyFromNode(node,'Sampledatabasename');
  SetPropertyFromNode(node,'LicenseRenewDurationType');
  SetPropertyFromNode(node,'RegionName');
  SetBooleanPropertyFromNode(node,'Active');
  SetPropertyFromNode(node,'LicenseLevel');
  SetPropertyFromNode(node,'LicenseRenewDuration');
  SetPropertyFromNode(node,'APIPort');
  SetBooleanPropertyFromNode(node,'IsHttps');
end;


procedure TVS1_Clients_Simple.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ClientName' ,ClientName);
  AddXMLNode(node,'RegistrationDate' ,RegistrationDate);
  AddXMLNode(node,'LicenseUntil' ,LicenseUntil);
  AddXMLNode(node,'LicenseFrom' ,LicenseFrom);
  AddXMLNode(node,'SoftwareReleaseType' ,SoftwareReleaseType);
  AddXMLNode(node,'VS1ClientName' ,VS1ClientName);
  AddXMLNode(node,'vs1ClientID' ,vs1ClientID);
  AddXMLNode(node,'CreditCardType' ,CreditCardType);
  AddXMLNode(node,'CreditCardCardHolderName' ,CreditCardCardHolderName);
  AddXMLNode(node,'CreditCardNumber' ,CreditCardNumber);
  AddXMLNode(node,'CreditCardCVC' ,CreditCardCVC);
  AddXMLNode(node,'CreditCardExpiryMonth' ,CreditCardExpiryMonth);
  AddXMLNode(node,'CreditCardExpiryYear' ,CreditCardExpiryYear);
  AddXMLNode(node,'CreditCardNotes' ,CreditCardNotes);
  AddXMLNode(node,'EmailVarified' ,EmailVarified);
  AddXMLNode(node,'ServerName' ,ServerName);
  AddXMLNode(node,'DatabaseID' ,DatabaseID);
  AddXMLNode(node,'Databasename' ,Databasename);
  AddXMLNode(node,'SampleDatabaseID' ,SampleDatabaseID);
  AddXMLNode(node,'Sampledatabasename' ,Sampledatabasename);
  AddXMLNode(node,'LicenseRenewDurationType' ,LicenseRenewDurationType);
  AddXMLNode(node,'RegionName' ,RegionName);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'LicenseLevel' ,LicenseLevel);
  AddXMLNode(node,'LicenseRenewDuration' ,LicenseRenewDuration);
  AddXMLNode(node,'APIPort' ,APIPort);
  AddXMLNode(node,'IsHttps' ,IsHttps);
end;


function TVS1_Clients_Simple.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TVS1_Clients.WebAPIURL(ERPClassname: String): String;
begin
  REsult := VS1Lib.WebAPIURL(IsHttps,APIPort,ServerName, ERPClassname);
end;

function TVS1_Clients_Simple.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TVS1_Clients_Simple.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TVS1_Clients_Simple.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TVS1_Clients_Simple.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TVS1_Clients_Simple.GetIDField: string;
begin
  Result := 'ID'
end;


class function TVS1_Clients_Simple.GetBusObjectTablename: string;
begin
  Result:= 'tblVS1_Clients';
end;


function TVS1_Clients_Simple.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TVS1_Clients_Simple.GetClientName              : string    ; begin Result := GetStringField('ClientName');end;
function  TVS1_Clients_Simple.GetRegistrationDate        : TDateTime ; begin Result := GetDateTimeField('RegistrationDate');end;
function  TVS1_Clients_Simple.GetLicenseUntil            : TDateTime ; begin Result := GetDateTimeField('LicenseUntil');end;
function  TVS1_Clients_Simple.GetLicenseFrom             : TDateTime ; begin Result := GetDateTimeField('LicenseFrom');end;
function  TVS1_Clients_Simple.GetSoftwareReleaseType     : string    ; begin Result := GetStringField('SoftwareReleaseType');end;
function  TVS1_Clients_Simple.GetVS1ClientName           : string    ; begin Result := GetStringField('VS1ClientName');end;
function  TVS1_Clients_Simple.Getvs1ClientID             : Integer   ; begin Result := GetIntegerField('vs1ClientID');end;
function  TVS1_Clients_Simple.GetCreditCardType          : string    ; begin Result := GetStringField('CreditCardType');end;
function  TVS1_Clients_Simple.GetCreditCardCardHolderName: string    ; begin Result := GetStringField('CreditCardCardHolderName');end;
function  TVS1_Clients_Simple.GetCreditCardNumber        : string    ; begin Result := GetStringField('CreditCardNumber');end;
function  TVS1_Clients_Simple.GetCreditCardCVC           : string    ; begin Result := GetStringField('CreditCardCVC');end;
function  TVS1_Clients_Simple.GetCreditCardExpiryMonth   : Integer   ; begin Result := GetIntegerField('CreditCardExpiryMonth');end;
function  TVS1_Clients_Simple.GetCreditCardExpiryYear    : Integer   ; begin Result := GetIntegerField('CreditCardExpiryYear');end;
function  TVS1_Clients_Simple.GetCreditCardNotes         : string    ; begin Result := GetStringField('CreditCardNotes');end;
function  TVS1_Clients_Simple.GetEmailVarified           : boolean   ; begin Result := GetBooleanField('EmailVarified');end;
function  TVS1_Clients_Simple.GetServerName              : string    ; begin Result := GetStringField('ServerName');end;
function  TVS1_Clients_Simple.GetDatabaseID              : Integer   ; begin Result := GetIntegerField('DatabaseID');end;
function  TVS1_Clients_Simple.GetDatabasename            : string    ; begin Result := GetStringField('Databasename');end;
function  TVS1_Clients_Simple.GetSampleDatabaseID        : Integer   ; begin Result := GetIntegerField('SampleDatabaseID');end;
function  TVS1_Clients_Simple.GetSampledatabasename      : string    ; begin Result := GetStringField('Sampledatabasename');end;
function  TVS1_Clients_Simple.GetRegionName              : string    ; begin Result := GetStringField('RegionName');end;
function  TVS1_Clients_Simple.GetActive                  : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TVS1_Clients_Simple.GetLicenseLevel            : Integer   ; begin Result := GetIntegerField('LicenseLevel');end;
function  TVS1_Clients_Simple.GetLicenseRenewDuration    : Integer   ; begin Result := GetIntegerField('LicenseRenewDuration'); if result <1 then result := 1;end;
function  TVS1_Clients_Simple.GetLicenseRenewDurationType: string    ; begin Result := GetStringField('LicenseRenewDurationType');if (result<>'M') and (Result<>'Y') then Result :='M'; end;
function  TVS1_Clients_Simple.GetAPIPort   : Integer   ; begin Result := GetIntegerField('APIPort');end;
function  TVS1_Clients_Simple.GetIsHttps   : Boolean   ; begin Result := GetBooleanField('IsHttps');end;
procedure TVS1_Clients_Simple.SetClientName              (const Value: string    ); begin SetStringField('ClientName'               , Value);end;
procedure TVS1_Clients_Simple.SetRegistrationDate        (const Value: TDateTime ); begin SetDateTimeField('RegistrationDate'         , Value);end;
procedure TVS1_Clients_Simple.SetLicenseUntil            (const Value: TDateTime ); begin SetDateTimeField('LicenseUntil'         , Value);end;
procedure TVS1_Clients_Simple.SetLicenseFrom             (const Value: TDateTime ); begin SetDateTimeField('LicenseFrom'         , Value);end;
procedure TVS1_Clients_Simple.SetSoftwareReleaseType     (const Value: string    ); begin SetStringField('SoftwareReleaseType'      , Value);end;
procedure TVS1_Clients_Simple.SetVS1ClientName           (const Value: string    ); begin SetStringField('VS1ClientName'            , Value);end;
procedure TVS1_Clients_Simple.Setvs1ClientID             (const Value: Integer   ); begin SetIntegerField('vs1ClientID'              , Value);end;
procedure TVS1_Clients_Simple.SetCreditCardType          (const Value: string    ); begin SetStringField('CreditCardType'           , Value);end;
procedure TVS1_Clients_Simple.SetCreditCardCardHolderName(const Value: string    ); begin SetStringField('CreditCardCardHolderName' , Value);end;
procedure TVS1_Clients_Simple.SetCreditCardNumber        (const Value: string    ); begin SetStringField('CreditCardNumber'         , Value);end;
procedure TVS1_Clients_Simple.SetCreditCardCVC           (const Value: string    ); begin SetStringField('CreditCardCVC'            , Value);end;
procedure TVS1_Clients_Simple.SetCreditCardExpiryMonth   (const Value: Integer   ); begin SetIntegerField('CreditCardExpiryMonth'    , Value);end;
procedure TVS1_Clients_Simple.SetCreditCardExpiryYear    (const Value: Integer   ); begin SetIntegerField('CreditCardExpiryYear'     , Value);end;
procedure TVS1_Clients_Simple.SetCreditCardNotes         (const Value: string    ); begin SetStringField('CreditCardNotes'          , Value);end;
procedure TVS1_Clients_Simple.SetEmailVarified           (const Value: Boolean   ); begin SetBooleanField('EmailVarified'          , Value);end;
procedure TVS1_Clients_Simple.SetServerName              (const Value: string    ); begin SetStringField('ServerName'               , Value);end;
procedure TVS1_Clients_Simple.SetDatabaseID              (const Value: Integer   ); begin SetIntegerField('DatabaseID'               , Value);end;
procedure TVS1_Clients_Simple.SetDatabasename            (const Value: string    ); begin SetStringField('Databasename'             , Value);end;
procedure TVS1_Clients_Simple.SetSampleDatabaseID        (const Value: Integer   ); begin SetIntegerField('SampleDatabaseID'         , Value);end;
procedure TVS1_Clients_Simple.SetSampledatabasename      (const Value: string    ); begin SetStringField('Sampledatabasename'       , Value);end;
procedure TVS1_Clients_Simple.SetRegionName              (const Value: string    ); begin SetStringField('RegionName'               , Value);end;
procedure TVS1_Clients_Simple.SetActive                  (const Value: Boolean   ); begin SetBooleanField('Active'                   , Value);end;
procedure TVS1_Clients_Simple.SetLicenseLevel            (const Value: Integer   ); begin SetIntegerField('LicenseLevel'           , Value);end;
procedure TVS1_Clients_Simple.SetLicenseRenewDuration    (const Value: Integer   ); begin SetIntegerField('LicenseRenewDuration'     , Value);end;
procedure TVS1_Clients_Simple.SetLicenseRenewDurationType(const Value: string    ); begin SetStringField('LicenseRenewDurationType', Value); if (Value<>'M') and (Value<>'Y') then SetStringField('LicenseRenewDurationType', 'M');  end;
procedure TVS1_Clients_Simple.SetAPIPort                 (const Value: Integer   ); begin SetIntegerField('APIPort' , Value);end;
procedure TVS1_Clients_Simple.SetIsHttps                 (const Value: Boolean   ); begin SetBooleanField('IsHttps' , Value);end;
function  TVS1_Clients.getForeignExchangeCode: String;
begin
  REsult :='';
  if Appenv.CompanyPrefs.VS1useRegioncurrency then result := RegionalOption.ForeignExDefault
  else if trim(Appenv.CompanyPrefs.VS1DefaultCurrency) ='' then result := RegionalOption.ForeignExDefault
  else begin
    with TCurrency.create(Self) do try
      connection := self.connection;
      LoadSelect('Code=' +quotedstr(Appenv.CompanyPrefs.VS1DefaultCurrency));
      if count =0 then begin
        result := RegionalOption.ForeignExDefault;
      end else begin
        result := Appenv.CompanyPrefs.VS1DefaultCurrency;
      end;
    finally
      Free;
    end;
  end;
end;

function TVS1_Clients.getLicenseMonths: Integer;
begin
  Result := 1;
  if LicenseRenewDurationType='Y' then result := 12;
  result := result * LicenseRenewDuration;
end;
function TVS1_Clients.getRegionalOption: TRegionalOptions;
begin
  Result := TRegionalOptions(getContainercomponent(TRegionalOptions, 'Region = ' + quotedstr(RegionName)  ));
end;

function TVS1_Clients.Getvs1_clientdbserver: tvs1_clientdbservers;
begin
  Result := tvs1_clientdbservers(getContainercomponent(tvs1_clientdbservers, 'servername = ' + quotedstr(servername)));
end;

function TVS1_Clients.getVS1_ClientLicenseDetails(aLicensecheckdate: TDateTime = 0; aDatabaseName: String = ''): TVS1_ClientLicenseDetails;
begin
  Result := TVS1_ClientLicenseDetails(Container.ItemByClass(TVS1_ClientLicenseDetails, False));
  if not Assigned(Result) then begin
    if (Self.ID = 0) then PostDB;
    Result := TVS1_ClientLicenseDetails.Create(self, ID, aLicensecheckdate, aDatabaseName);
  end else begin
    Result.LicenseCheckDate := aLicensecheckdate;
    Result.ClientId := ID;
    Result.DBName := aDatabaseName;
  end;
  Result.Opendb;
end;

function TVS1_Clients.getvs1_licenselevels: tvs1_licenselevels;
begin
  Result := tvs1_licenselevels(getContainercomponent(tvs1_licenselevels, 'ID = ' + inttostr(LicenseLevel) ));
end;
function TVS1_Clients.getClientModules: TVS1_ClientModules;
begin
  Result := TVS1_ClientModules(getContainercomponent(TVS1_ClientModules, 'ClientId = ' + inttostr(Id) ));
end;

function TVS1_Clients.getClientModulesUsage: TVS1_ClientModulesUsage;
begin
  Result := TVS1_ClientModulesUsage(getContainercomponent(TVS1_ClientModulesUsage, 'ClientId = ' + inttostr(Id) ));
end;
function TVS1_Clients.getClientUsers: TVS1_ClientUsers;
begin
  Result := TVS1_ClientUsers(getContainercomponent(TVS1_ClientUsers, 'ClientId = ' + inttostr(Id) ));
end;
function TVS1_Clients.getClientPayments: TVS1_ClientPayments;
begin
  Result := TVS1_ClientPayments(getContainercomponent(TVS1_ClientPayments, 'ClientId = ' + inttostr(Id) ));
end;
class function TVS1_Clients_Simple.GetKeyStringField: string;
begin
  Result :='ClientName';
end;

  {TVS1_ModulePrice}

constructor TVS1_ModulePrice.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1_moduleprice';
  fSQL := 'SELECT * From tblVS1_ModulePrice Where RegionID =' + inttostr(AppEnv.RegionalOptions.ID);
end;


destructor TVS1_ModulePrice.Destroy;
begin
  inherited;
end;


procedure TVS1_ModulePrice.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'LicenseLevel');
  SetPropertyFromNode(node,'ModuleID');
  SetDateTimePropertyFromNode(node,'DateFrom');
  SetDateTimePropertyFromNode(node,'DateTo');
  SetPropertyFromNode(node,'Price');
  SetPropertyFromNode(node,'RegionID');
end;


procedure TVS1_ModulePrice.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'LicenseLevel' ,LicenseLevel);
  AddXMLNode(node,'ModuleID' ,ModuleID);
  AddXMLNode(node,'DateFrom' ,DateFrom);
  AddXMLNode(node,'DateTo' ,DateTo);
  AddXMLNode(node,'Price' ,Price);
  AddXMLNode(node,'RegionID' ,RegionID);
end;


function TVS1_ModulePrice.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TVS1_ModulePrice.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TVS1_ModulePrice.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TVS1_ModulePrice.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TVS1_ModulePrice.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TVS1_ModulePrice.GetIDField: string;
begin
  Result := 'ID'
end;


class function TVS1_ModulePrice.GetBusObjectTablename: string;
begin
  Result:= 'tblVS1_ModulePrice';
end;


function TVS1_ModulePrice.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  regionid := AppEnv.RegionalOptions.ID;
end;

function TVS1_ModulePrice.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
Class Function TVS1_ModulePrice.PriceIDForLicenseLevel(aLicenseLevel:Integer):Integer;
begin
    With TVS1_ModulePrice.CreateWithNewConn(nil) do try
       LoadSelect('LicenseLevel =' + inttostr(aLicenseLevel));
       REsult := ID;
    finally
       Free;
    end;
end;
Class Function TVS1_ModulePrice.PriceIDForModule(aModuleID:Integer):Integer;
begin
    With TVS1_ModulePrice.CreateWithNewConn(nil) do try
       LoadSelect('ModuleID =' + inttostr(aModuleID));
       REsult := ID;
    finally
       Free;
    end;
end;
Class Function TVS1_ModulePrice.PriceforID(aID:Integer):Double;
begin
    With TVS1_ModulePrice.CreateWithNewConn(nil) do try
       Load(aID);
       REsult := Price;
    finally
       Free;
    end;
end;

{Property Functions}
function  TVS1_ModulePrice.GetLicenseLevel            : Integer   ; begin Result := GetIntegerField('LicenseLevel');end;
function  TVS1_ModulePrice.GetModuleID                : Integer   ; begin Result := GetIntegerField('ModuleID');end;
function  TVS1_ModulePrice.GetDateFrom                : TDateTime ; begin Result := GetDateTimeField('DateFrom');end;
function  TVS1_ModulePrice.GetDateTo                  : TDateTime ; begin Result := GetDateTimeField('DateTo');end;
function  TVS1_ModulePrice.GetPrice                   : Double    ; begin Result := GetFloatField('Price');end;
function  TVS1_ModulePrice.GetRegionID                : Integer   ; begin Result := GetIntegerField('RegionID');end;
procedure TVS1_ModulePrice.SetLicenseLevel            (const Value: Integer   ); begin SetIntegerField('LicenseLevel'          , Value);end;
procedure TVS1_ModulePrice.SetModuleID                (const Value: Integer   ); begin SetIntegerField('ModuleID'              , Value);end;
procedure TVS1_ModulePrice.SetDateFrom                (const Value: TDateTime ); begin SetDateTimeField('DateFrom'             , Value);end;
procedure TVS1_ModulePrice.SetDateTo                  (const Value: TDateTime ); begin SetDateTimeField('DateTo'               , Value);end;
procedure TVS1_ModulePrice.SetPrice                   (const Value: Double    ); begin SetFloatField('Price'                   , Value);end;
procedure TVS1_ModulePrice.SetRegionID                (const Value: Integer   ); begin SetIntegerField('RegionID'              , Value);end;


  {TVS1_ClientPayments}

constructor TVS1_ClientPayments.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1_clientpayments';
  fSQL := 'SELECT * From tblVS1_ClientPayments';
end;


destructor TVS1_ClientPayments.Destroy;
begin
  inherited;
end;


procedure TVS1_ClientPayments.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ClientId');
  SetDateTimePropertyFromNode(node,'DateFrom');
  SetDateTimePropertyFromNode(node,'DateTo');
  SetPropertyFromNode(node,'Payment');
  SetDateTimePropertyFromNode(node,'PaidOn');
  SetPropertyFromNode(node,'PaymethodID');
  SetPropertyFromNode(node,'CreditCardType');
  SetPropertyFromNode(node,'CreditCardCardHolderName');
  SetPropertyFromNode(node,'CreditCardNumber');
  SetPropertyFromNode(node,'CreditCardExpiryMonth');
  SetPropertyFromNode(node,'CreditCardExpiryYear');
  SetPropertyFromNode(node,'CreditCardCVC');
end;


procedure TVS1_ClientPayments.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ClientId' ,ClientId);
  AddXMLNode(node,'DateFrom' ,DateFrom);
  AddXMLNode(node,'DateTo' ,DateTo);
  AddXMLNode(node,'Payment' ,Payment);
  AddXMLNode(node,'PaidOn' ,PaidOn);
  AddXMLNode(node,'PaymethodID' ,PaymethodID);
  AddXMLNode(node,'CreditCardType' ,CreditCardType);
  AddXMLNode(node,'CreditCardCardHolderName' ,CreditCardCardHolderName);
  AddXMLNode(node,'CreditCardNumber' ,CreditCardNumber);
  AddXMLNode(node,'CreditCardExpiryMonth' ,CreditCardExpiryMonth);
  AddXMLNode(node,'CreditCardExpiryYear' ,CreditCardExpiryYear);
  AddXMLNode(node,'CreditCardCVC' ,CreditCardCVC);
end;


function TVS1_ClientPayments.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TVS1_ClientPayments.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TVS1_ClientPayments.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TVS1_ClientPayments.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TVS1_ClientPayments.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TVS1_ClientPayments.GetIDField: string;
begin
  Result := 'ID'
end;


class function TVS1_ClientPayments.GetBusObjectTablename: string;
begin
  Result:= 'tblVS1_ClientPayments';
end;


function TVS1_ClientPayments.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function  TVS1_ClientPayments.DoAfterInsert(Sender:TDatasetBusObj) : Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  if Assigned(Owner) then
    if Owner is TVS1_Clients_Simple then begin
      ClientID                := TVS1_Clients_Simple(Owner).ID;
      CreditCardType          := TVS1_Clients_Simple(Owner).CreditCardType;
      CreditCardCardHolderName:= TVS1_Clients_Simple(Owner).CreditCardCardHolderName;
      CreditCardNumber        := TVS1_Clients_Simple(Owner).CreditCardNumber;
      CreditCardExpiryMonth   := TVS1_Clients_Simple(Owner).CreditCardExpiryMonth;
      CreditCardExpiryYear    := TVS1_Clients_Simple(Owner).CreditCardExpiryYear;
      CreditCardCVC           := TVS1_Clients_Simple(Owner).CreditCardCVC;
    end;
end;

{Property Functions}
function  TVS1_ClientPayments.GetClientId                : Integer   ; begin Result := GetIntegerField('ClientId');end;
function  TVS1_ClientPayments.GetDateFrom                : TDateTime ; begin Result := GetDateTimeField('DateFrom');end;
function  TVS1_ClientPayments.GetDateTo                  : TDateTime ; begin Result := GetDateTimeField('DateTo');end;
function  TVS1_ClientPayments.GetPayment                 : Double    ; begin Result := GetFloatField('Payment');end;
function  TVS1_ClientPayments.GetPaidOn                  : TDateTime ; begin Result := GetDateTimeField('PaidOn');end;
function  TVS1_ClientPayments.GetPaymethodID             : Integer   ; begin Result := GetIntegerField('PaymethodID');end;
function  TVS1_ClientPayments.GetCreditCardType          : string    ; begin Result := GetStringField('CreditCardType');end;
function  TVS1_ClientPayments.GetCreditCardCardHolderName: string    ; begin Result := GetStringField('CreditCardCardHolderName');end;
function  TVS1_ClientPayments.GetCreditCardNumber        : string    ; begin Result := GetStringField('CreditCardNumber');end;
function  TVS1_ClientPayments.GetCreditCardExpiryMonth   : Integer   ; begin Result := GetIntegerField('CreditCardExpiryMonth');end;
function  TVS1_ClientPayments.GetCreditCardExpiryYear    : Integer   ; begin Result := GetIntegerField('CreditCardExpiryYear');end;
function  TVS1_ClientPayments.GetCreditCardCVC           : string    ; begin Result := GetStringField('CreditCardCVC');end;
procedure TVS1_ClientPayments.SetClientId                (const Value: Integer   ); begin SetIntegerField('ClientId'                 , Value);end;
procedure TVS1_ClientPayments.SetDateFrom                (const Value: TDateTime ); begin SetDateTimeField('DateFrom'                 , Value);end;
procedure TVS1_ClientPayments.SetDateTo                  (const Value: TDateTime ); begin SetDateTimeField('DateTo'                   , Value);end;
procedure TVS1_ClientPayments.SetPayment                 (const Value: Double    ); begin SetFloatField('Payment'                  , Value);end;
procedure TVS1_ClientPayments.SetPaidOn                  (const Value: TDateTime ); begin SetDateTimeField('PaidOn'                   , Value);end;
procedure TVS1_ClientPayments.SetPaymethodID             (const Value: Integer   ); begin SetIntegerField('PaymethodID'              , Value);end;
procedure TVS1_ClientPayments.SetCreditCardType          (const Value: string    ); begin SetStringField('CreditCardType'           , Value);end;
procedure TVS1_ClientPayments.SetCreditCardCardHolderName(const Value: string    ); begin SetStringField('CreditCardCardHolderName' , Value);end;
procedure TVS1_ClientPayments.SetCreditCardNumber        (const Value: string    ); begin SetStringField('CreditCardNumber'         , Value);end;
procedure TVS1_ClientPayments.SetCreditCardExpiryMonth   (const Value: Integer   ); begin SetIntegerField('CreditCardExpiryMonth'    , Value);end;
procedure TVS1_ClientPayments.SetCreditCardExpiryYear    (const Value: Integer   ); begin SetIntegerField('CreditCardExpiryYear'     , Value);end;
procedure TVS1_ClientPayments.SetCreditCardCVC           (const Value: string    ); begin SetStringField('CreditCardCVC'            , Value);end;
function TVS1_ClientPayments.getPayMethod: String;
begin
  result := '';
  if PayMethodID =0 then exit;
  REsult := TPaymentMethod.idtoggle(PayMethodID);
end;
procedure TVS1_ClientPayments.setPayMethod(const Value: String);
begin
  if Value = '' then exit;
  TPaymentMethod.AddNewifnotExsist(Value, True, Connection.connection, true);
  PayMethodID := TPaymentMethod.idtoggle(Value);
end;
  {TVS1_Modules}

constructor TVS1_Modules.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1_modules';
  fSQL := 'SELECT * From tblVS1_Modules';
end;


destructor TVS1_Modules.Destroy;
begin
  inherited;
end;


procedure TVS1_Modules.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'LicenseLevel');
  SetPropertyFromNode(node,'ModuleName');
  SetPropertyFromNode(node,'Description');
  SetBooleanPropertyFromNode(node,'IsExtra');
  SetPropertyFromNode(node,'RequiredLevel');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TVS1_Modules.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'LicenseLevel' ,LicenseLevel);
  AddXMLNode(node,'ModuleName' ,ModuleName);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'IsExtra' ,IsExtra);
  AddXMLNode(node,'RequiredLevel' ,RequiredLevel);
  AddXMLNode(node,'Active' ,Active);
end;


function TVS1_Modules.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TVS1_Modules.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TVS1_Modules.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TVS1_Modules.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TVS1_Modules.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TVS1_Modules.GetIDField: string;
begin
  Result := 'ID'
end;


class function TVS1_Modules.GetBusObjectTablename: string;
begin
  Result:= 'tblVS1_Modules';
end;

function TVS1_Modules.getClientModulesUsage: TVS1_ClientModulesUsage;
begin
  //Result := TVS1_ClientModulesUsage(getContainercomponent(TVS1_ClientModulesUsage, 'ClientId = ' + inttostr(ClientId) + ' and ModuleId = ' + inttostr(ModuleId)));
  Result := TVS1_ClientModulesUsage(getContainercomponent(TVS1_ClientModulesUsage, 'ClientModuleID = ' + inttostr(ID) ));
end;

function TVS1_Modules.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TVS1_Modules.GetLicenseLevel            : Integer   ; begin Result := GetIntegerField('LicenseLevel');end;
function  TVS1_Modules.GetModuleName              : string    ; begin Result := GetStringField('ModuleName');end;
function  TVS1_Modules.GetDescription             : string    ; begin Result := GetStringField('Description');end;
function  TVS1_Modules.GetIsExtra                 : Boolean   ; begin Result := GetBooleanField('IsExtra');end;
function  TVS1_Modules.GetRequiredLevel           : Integer   ; begin Result := GetIntegerField('RequiredLevel');end;
function  TVS1_Modules.GetActive                  : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TVS1_Modules.SetLicenseLevel            (const Value: Integer   ); begin SetIntegerField('LicenseLevel'             , Value);end;
procedure TVS1_Modules.SetModuleName              (const Value: string    ); begin SetStringField('ModuleName'               , Value);end;
procedure TVS1_Modules.SetDescription             (const Value: string    ); begin SetStringField('Description'              , Value);end;
procedure TVS1_Modules.SetIsExtra                 (const Value: Boolean   ); begin SetBooleanField('IsExtra'                  , Value);end;
procedure TVS1_Modules.SetRequiredLevel           (const Value: Integer   ); begin SetIntegerField('RequiredLevel'            , Value);end;
procedure TVS1_Modules.SetActive                  (const Value: Boolean   ); begin SetBooleanField('Active'                   , Value);end;
class function TVS1_Modules.GetKeyStringField: string;
begin
  REsult := 'ModuleName';
end;



  {TVS1_Databases}

constructor TVS1_Databases.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1_databases';
  fSQL := 'SELECT * From tblVS1_Databases';
end;

destructor TVS1_Databases.Destroy;
begin
  inherited;
end;

procedure TVS1_Databases.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'DatabaseName');
  SetPropertyFromNode(node,'ServerName');
  SetPropertyFromNode(node,'Regionname');
  SetPropertyFromNode(node,'Status');
  SetDateTimePropertyFromNode(node,'CreatedOn');
  SetDateTimePropertyFromNode(node,'UsedOn');
  SetDateTimePropertyFromNode(node,'DiscontinuedOn');
  SetPropertyFromNode(node,'Vs1_ClientID');
  SetPropertyFromNode(node,'APIPort');
  SetBooleanPropertyFromNode(node,'IsHttps');
end;

procedure TVS1_Databases.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DatabaseName', DatabaseName);
  AddXMLNode(node,'ServerName', ServerName);
  AddXMLNode(node,'Regionname', Regionname);
  AddXMLNode(node,'Status', Status);
  AddXMLNode(node,'CreatedOn', CreatedOn);
  AddXMLNode(node,'UsedOn', UsedOn);
  AddXMLNode(node,'DiscontinuedOn', DiscontinuedOn);
  AddXMLNode(node,'Vs1_ClientID', Vs1_ClientID);
  AddXMLNode(node,'APIPort', APIPort);
  AddXMLNode(node,'IsHttps', IsHttps);
end;

function TVS1_Databases.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;

function TVS1_Databases.WebAPIURL(ERPClassname: String): String;
begin
  Result := VS1Lib.WebAPIURL(IsHttps, APIPort, ServerName, ERPClassname);
end;

function TVS1_Databases.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TVS1_Databases.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TVS1_Databases.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TVS1_Databases.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TVS1_Databases.GetIDField: string;
begin
  Result := 'ID'
end;

class function TVS1_Databases.GetBusObjectTablename: string;
begin
  Result:= 'tblVS1_Databases';
end;

function TVS1_Databases.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
function  TVS1_Databases.GetDatabaseName            : string    ; begin Result := GetStringField('DatabaseName');end;
function  TVS1_Databases.GetServerName              : string    ; begin Result := GetStringField('ServerName');end;
function  TVS1_Databases.GetRegionname              : string    ; begin Result := GetStringField('Regionname');end;
function  TVS1_Databases.GetStatus                  : string    ; begin Result := GetStringField('Status');end;
function  TVS1_Databases.GetCreatedOn               : TDateTime ; begin Result := GetDateTimeField('CreatedOn');end;
function  TVS1_Databases.GetUsedOn                  : TDateTime ; begin Result := GetDateTimeField('UsedOn');end;
function  TVS1_Databases.GetDiscontinuedOn          : TDateTime ; begin Result := GetDateTimeField('DiscontinuedOn');end;
function  TVS1_Databases.GetVs1_ClientID            : Integer   ; begin Result := GetIntegerField('Vs1_ClientID');end;
function  TVS1_Databases.GetAPIPort   : Integer   ; begin Result := GetIntegerField('APIPort');end;
function  TVS1_Databases.GetIsHttps   : Boolean   ; begin Result := GetBooleanField('IsHttps');end;
function  TVS1_Databases.GetClientID  : Integer   ; begin Result := GetIntegerField('ClientID');end;

procedure TVS1_Databases.SetDatabaseName            (const Value: string    ); begin SetStringField('DatabaseName'             , Value);end;
procedure TVS1_Databases.SetServerName              (const Value: string    ); begin SetStringField('ServerName'               , Value);end;
procedure TVS1_Databases.SetRegionname              (const Value: string    ); begin SetStringField('Regionname'               , Value);end;
procedure TVS1_Databases.SetStatus                  (const Value: string    ); begin SetStringField('Status'                   , Value);end;
procedure TVS1_Databases.SetCreatedOn               (const Value: TDateTime ); begin SetDateTimeField('CreatedOn'                , Value);end;
procedure TVS1_Databases.SetUsedOn                  (const Value: TDateTime ); begin SetDateTimeField('UsedOn'                   , Value);end;
procedure TVS1_Databases.SetDiscontinuedOn          (const Value: TDateTime ); begin SetDateTimeField('DiscontinuedOn'           , Value);end;
procedure TVS1_Databases.SetVs1_ClientID            (const Value: Integer   ); begin SetIntegerField('Vs1_ClientID'             , Value);end;
procedure TVS1_Databases.SetAPIPort   (const Value: Integer   ); begin SetIntegerField('APIPort' , Value);end;
procedure TVS1_Databases.SetIsHttps   (const Value: Boolean   ); begin SetBooleanField('IsHttps' , Value);end;
procedure TVS1_Databases.SetClientID  (const Value: Integer   ); begin SetIntegerField('ClientID'  , Value);end;

function TVS1_Databases.Getvs1_clientdbserver: tvs1_clientdbservers;
begin
  Result := tvs1_clientdbservers(getContainercomponent(tvs1_clientdbservers, 'servername = ' + quotedstr(servername)  ));
end;

function TVS1_Databases.getVS1_Clients: TVS1_Clients;
begin
  Result := TVS1_Clients(getContainercomponent(TVS1_Clients, 'DatabaseID = ' + inttostr(Id) ));
end;
class function TVS1_databases.GetKeyStringField: string;
begin
  Result := 'DatabaseName';
end;

{TVS1_ClientModules}

(*procedure TVS1_ClientModules.CalcPrice;
var
  Qry :TERPQuery;
  ctr:Integer;
begin
  Qry :=GetSharedDataSet('', true);
  Try
    Qry.SQl.clear;
    for ctr:= 1 to 2 do begin
      if ((ctr=1) and (LicenseLevel<> 0)) OR
         ((ctr=2) and (moduleId<> 0))  then begin
        if Qry.SQL.count >0 then Qry.SQL.add('UNION ALL');
        Qry.SQL.add('SELECT DISTINCT');
        Qry.SQL.add('C.id as ClientId, ');
        Qry.SQL.add('C.ClientName,');
        Qry.SQL.add('C.RegistrationDate,');
        Qry.SQL.add('MP.LicenseLevel,');
        Qry.SQL.add('MP.ModuleID,');
        Qry.SQL.add('MP.DateFrom,');
        Qry.SQL.add('MP.DateTo,');
        Qry.SQL.add('MP.Price,');
        Qry.SQL.add('Md.Id as moduleDiscountId,');
        Qry.SQL.add('Md.Description,');
        Qry.SQL.add('Md.Discount,');
        Qry.SQL.add('CONCAT(Md.Discount, if(Md.DiscountType="DP","%",' + quotedstr(AppEnv.RegionalOptions.CurrencySymbol)+')) AS Discounts,');
        Qry.SQL.add('if(Md.DiscountType="DP" , (MP.Price*Md.Discount/100), Md.Discount) AS DiscountAmt,');
        Qry.SQL.add('MP.Price-if(Md.DiscountType="DP" , (MP.Price*Md.Discount/100), Md.Discount) AS DiscountedPrice,');
        Qry.SQL.add('Md.DiscountType,');
        Qry.SQL.add('Md.Duration,');
        Qry.SQL.add('Md.Clienttype,');
        Qry.SQL.add('if(Md.Clienttype="New", C.RegistrationDate,Md.DiscountFrom) AS DiscountFrom,');
        Qry.SQL.add('date_add(date_add(if(Md.Clienttype="New", C.RegistrationDate,Md.DiscountFrom), INTERVAL Md.Duration MONTH), INTERVAL -1 DAY)  AS DiscountTo,');
        Qry.SQL.add('(SELECT COUNT(CMU.ID) from tblVS1_clientmodulesusage CMU where CM.ID = CMU.ClientModuleID)+1 monthno');
        Qry.SQL.add('FROM');
        Qry.SQL.add('tblVS1_clients C');
        Qry.SQL.add('inner JOIN tblVS1_clientmodules CM ON C.id = CM.ClientId');
        if ctr = 1 then begin
          Qry.SQL.add('inner JOIN tblVS1_moduleprice   MP ON MP.RegionID = (SELECT regionid FROM tblregionaloptions WHERE Region =C.regionname ) and MP.LicenseLevel = CM.LicenseLevel AND IFNULL(MP.ModuleID,0)=0');
          Qry.SQL.add('Left join tblVS1_modulediscount Md ON (ifnull(Md.RegionID,0)=0 or Md.RegionID = (SELECT regionid FROM tblregionaloptions WHERE Region =C.regionname )) AND  ((IFNULL(Md.LicenseLevel,0)=0 ) OR (Md.LicenseLevel = CM.LicenseLevel )) AND Md.Active ="T"');
          Qry.SQL.add('WHERE C.ID =' + inttostr(ClientID)+' and  CM.LicenseLevel = '+ inttostr(Licenselevel)+' and  IFNULL(CM.ModuleID,0)=0');
        end else begin
          Qry.SQL.add('inner JOIN tblVS1_moduleprice   MP ON  MP.RegionID = (SELECT regionid FROM tblregionaloptions WHERE Region =C.regionname ) and IFNULL(MP.ModuleID,0) = IFNULL(CM.ModuleID,0)');
          Qry.SQL.add('Left join tblVS1_modulediscount Md ON  (ifnull(Md.RegionID,0)=0 or Md.RegionID = (SELECT regionid FROM tblregionaloptions WHERE Region =C.regionname )) AND ((IFNULL(Md.ModuleId,0)=0) OR (Md.ModuleID = CM.ModuleID )) AND Md.Active ="T"');
          Qry.SQL.add('WHERE C.ID =' + inttostr(ClientID)+' and IFNULL(CM.ModuleID,0) = '+ inttostr(ModuleID)+' ');
        end;
        Qry.SQL.add('HAVING (Md.Clienttype IN ("New") AND monthno <=Md.Duration) OR (Md.Clienttype IN ("Old") AND monthno >1) OR (Md.Clienttype IN ("All"))');
      end;
    end;
    Qry.SQL.add('Order by DiscountAmt Limit 1'); // get the lawest dicsounted price
    Qry.open;
    if Qry.recordcount >0 then begin
      Price           := Qry.Fieldbyname('Price').asFloat;
      DiscountAmt     := Qry.Fieldbyname('DiscountAmt').asFloat;
      DiscountedPrice := Qry.Fieldbyname('DiscountedPrice').asFloat;
      moduleDiscountId:= Qry.Fieldbyname('moduleDiscountId').asInteger;
    end;
  finally
      DbSharedObj.ReleaseObj(Qry);
  end;
end;*)

constructor TVS1_ClientModules.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'VS1_ClientModules';
  fSQL := 'SELECT * From tblVS1_ClientModules';
end;


procedure TVS1_ClientModules.CreateInstance;
begin
  inherited;
  //ObjInstanceToClone := ClientModulesUsage;
end;

destructor TVS1_ClientModules.Destroy;
begin
  inherited;
end;

procedure TVS1_ClientModules.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ClientId');
  SetPropertyFromNode(node,'LicenseLevel');
  SetPropertyFromNode(node,'ModuleId');
  SetPropertyFromNode(node,'ModulePriceID');
  SetDateTimePropertyFromNode(node,'DateStarted');
  SetDateTimePropertyFromNode(node,'LicenseFrom');
  SetDateTimePropertyFromNode(node,'LicenseUntil');
  SetPropertyFromNode(node,'Price');
  SetPropertyFromNode(node,'RenewPrice');
  SetPropertyFromNode(node,'DiscountAmt');
  SetPropertyFromNode(node,'RenewDiscountAmt');
  SetPropertyFromNode(node,'DiscountedPrice');
  SetPropertyFromNode(node,'RenewDiscountedPrice');
  SetPropertyFromNode(node,'DiscountDesc');
  SetPropertyFromNode(node,'RenewDiscountDesc');
  SetPropertyFromNode(node,'LicenseExtensionDesc');
  SetPropertyFromNode(node,'moduleDiscountId');
  SetDateTimePropertyFromNode(node,'DatePaID');
  SetPropertyFromNode(node,'ClientPaymentId');
  SetBooleanPropertyFromNode(node,'Active');
end;

procedure TVS1_ClientModules.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ClientId' ,ClientId);
  AddXMLNode(node,'LicenseLevel' ,LicenseLevel);
  AddXMLNode(node,'ModuleId' ,ModuleId);
  AddXMLNode(node,'ModulePriceID' ,ModulePriceID);
  AddXMLNode(node,'DateStarted' ,DateStarted);
  AddXMLNode(node,'LicenseFrom' ,LicenseFrom);
  AddXMLNode(node,'LicenseUntil' ,LicenseUntil);
  AddXMLNode(node,'Price' ,Price);
  AddXMLNode(node,'RenewPrice' ,RenewPrice);
  AddXMLNode(node,'DiscountAmt' ,DiscountAmt);
  AddXMLNode(node,'RenewDiscountAmt' ,RenewDiscountAmt);
  AddXMLNode(node,'DiscountedPrice' ,DiscountedPrice);
  AddXMLNode(node,'RenewDiscountedPrice' ,RenewDiscountedPrice);
  AddXMLNode(node,'DiscountDesc' ,DiscountDesc);
  AddXMLNode(node,'RenewDiscountDesc' ,RenewDiscountDesc);
  AddXMLNode(node,'LicenseExtensionDesc' ,LicenseExtensionDesc);
  AddXMLNode(node,'moduleDiscountId' ,moduleDiscountId);
  AddXMLNode(node,'DatePaID' ,DatePaID);
  AddXMLNode(node,'ClientPaymentId' ,ClientPaymentId);
  AddXMLNode(node,'Active' ,Active);
end;

function TVS1_ClientModules.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;

function TVS1_ClientModules.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TVS1_ClientModules.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TVS1_ClientModules.RenewModule;
begin
  if LicenseUntil =0 then LicenseFrom := date
  else LicenseFrom := incday(LicenseUntil, 1);
  LicenseUntil :=LicenseMonthEnd(LicenseFrom , VS1_Clients.LicenseMonths );
  Active := True;
  PostDB;
  SendEvent(BusObjEvent_ToDo, BusObjEventCall_RenewLicense);

end;

procedure TVS1_ClientModules.DoFieldOnChange(Sender: TField);
begin
 if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
      inherited;
      if Sysutils.SameText(Sender.FieldName, 'DateStarted') then begin
        if LicenseFrom =0 then LicenseFrom :=DateStarted;
        if LicenseUntil =0 then LicenseUntil := LicenseMonthEnd(LicenseFrom, VS1_Clients.LicenseMonths );
      end else if Sysutils.SameText(Sender.FieldName, 'LicenseFrom') then begin
        if CleanLicenseFrom <> 0 then
          if LicenseFrom <= CleanLicenseFrom then LicenseFrom :=  incday(CleanLicenseFrom,1);
        if (LicenseFrom <= LicenseUntil) or (LicenseUntil=0) then
          LicenseUntil  := LicenseMonthEnd(LicenseFrom, VS1_Clients.LicenseMonths );
      end else if Sysutils.SameText(Sender.FieldName, 'LicenseUntil') then begin
        if CleanLicenseFrom <> 0 then
          if LicenseUntil <= CleanLicenseFrom then LicenseUntil := LicenseMonthEnd(Licensefrom, VS1_Clients.LicenseMonths );
        if LicenseUntil <  Licensefrom  then LicenseUntil := LicenseMonthEnd(Licensefrom, VS1_Clients.LicenseMonths );
        if LicenseFrom  >= LicenseUntil then LicenseUntil := LicenseMonthEnd(LicenseFrom, VS1_Clients.LicenseMonths );
      end;
end;

function TVS1_ClientModules.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

function TVS1_ClientModules.getVS1_ClientModulesUsage: TVS1_ClientModulesUsage;
begin
  Result := TVS1_ClientModulesUsage(getContainercomponent(TVS1_ClientModulesUsage, 'ClientModuleID = ' + inttostr(ID) ));
end;

function TVS1_ClientModules.getVS1_Clients: TVS1_Clients;
begin
  if Assigned(Owner) and (Owner is TVS1_Clients ) then result := TVS1_Clients(Owner)
  else   Result := TVS1_Clients(getContainercomponent(TVS1_Clients, 'ID = ' + inttostr(ClientId) ));
end;

class function TVS1_ClientModules.GetIDField: string;
begin
  Result := 'ID'
end;

class function TVS1_ClientModules.GetBusObjectTablename: string;
begin
  Result:= 'tblVS1_ClientModules';
end;

function TVS1_ClientModules.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then exit;
  if Assigned(OWner) then
    if Owner is TVS1_Clients then begin
      ClientID := TVS1_Clients(Owner).ID;
      DateStarted := TVS1_Clients(Owner).RegistrationDate;
    end;
end;

function TVS1_ClientModules.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
function  TVS1_ClientModules.GetClientId                : Integer   ; begin Result := GetIntegerField('ClientId');end;
function  TVS1_ClientModules.GetLicenseLevel            : Integer   ; begin Result := GetIntegerField('LicenseLevel');end;
function  TVS1_ClientModules.GetModuleId                : Integer   ; begin Result := GetIntegerField('ModuleId');end;
function  TVS1_ClientModules.GetModulePriceID           : Integer   ; begin Result := GetIntegerField('ModulePriceID');end;
function  TVS1_ClientModules.GetDateStarted             : TDateTime ; begin Result := GetDateTimeField('DateStarted');end;
function  TVS1_ClientModules.GetLicenseFrom             : TDateTime ; begin Result := GetDateTimeField('LicenseFrom');end;
function  TVS1_ClientModules.GetLicenseUntil            : TDateTime ; begin Result := GetDateTimeField('LicenseUntil');end;
function  TVS1_ClientModules.GetQuantity                : Integer   ; begin Result := GetIntegerField('Quantity');end;
function  TVS1_ClientModules.GetPrice                   : Double    ; begin Result := GetFloatField('Price');end;
function  TVS1_ClientModules.GetRenewPrice              : Double    ; begin Result := GetFloatField('RenewPrice');end;
function  TVS1_ClientModules.GetDiscountAmt             : Double    ; begin Result := GetFloatField('DiscountAmt');end;
function  TVS1_ClientModules.GetRenewDiscountAmt        : Double    ; begin Result := GetFloatField('RenewDiscountAmt');end;
function  TVS1_ClientModules.GetDiscountedPrice         : Double    ; begin Result := GetFloatField('DiscountedPrice');end;
function  TVS1_ClientModules.GetRenewDiscountedPrice    : Double    ; begin Result := GetFloatField('RenewDiscountedPrice');end;
function  TVS1_ClientModules.GetDiscountDesc            : String    ; begin Result := GetStringField('DiscountDesc');end;
function  TVS1_ClientModules.GetRenewDiscountDesc       : String    ; begin Result := GetStringField('RenewDiscountDesc');end;
function  TVS1_ClientModules.GetLicenseExtensionDesc    : String    ; begin Result := GetStringField('LicenseExtensionDesc');end;
function  TVS1_ClientModules.GetmoduleDiscountId        : Integer   ; begin Result := GetIntegerField('moduleDiscountId');end;
function  TVS1_ClientModules.GetDatePaID                : TDateTime ; begin Result := GetDateTimeField('DatePaID');end;
function  TVS1_ClientModules.GetClientPaymentId         : Integer   ; begin Result := GetIntegerField('ClientPaymentId');end;
function  TVS1_ClientModules.GetDatabaseName            : String    ; begin Result := GetStringField('DatabaseName');end;
function  TVS1_ClientModules.GetActive                  : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TVS1_ClientModules.GetLicenseRenewDuration    : Integer   ; begin Result := GetIntegerField('LicenseRenewDuration'); if result <1 then result := 1;end;
function  TVS1_ClientModules.GetLicenseRenewDurationType: string    ; begin Result := GetStringField('LicenseRenewDurationType');if (result<>'M') and (Result<>'Y') then Result :='M'; end;

procedure TVS1_ClientModules.SetClientId                (const Value: Integer   ); begin SetIntegerField('ClientId'         , Value);end;
procedure TVS1_ClientModules.SetLicenseLevel            (const Value: Integer   ); begin SetIntegerField('LicenseLevel'     , Value);end;
procedure TVS1_ClientModules.SetModuleId                (const Value: Integer   ); begin SetIntegerField('ModuleId'         , Value);end;
procedure TVS1_ClientModules.SetModulePriceID           (const Value: Integer   ); begin SetIntegerField('ModulePriceID'    , Value);end;
procedure TVS1_ClientModules.SetDateStarted             (const Value: TDateTime ); begin SetDateTimeField('DateStarted'      , Value);end;
procedure TVS1_ClientModules.SetLicenseFrom             (const Value: TDateTime ); begin SetDateTimeField('LicenseFrom'      , Value);end;
procedure TVS1_ClientModules.SetLicenseUntil            (const Value: TDateTime ); begin SetDateTimeField('LicenseUntil'     , Value);end;
procedure TVS1_ClientModules.SetQuantity                (const Value: Integer   ); begin SetIntegerField('Quantity'          , Value);end;
procedure TVS1_ClientModules.SetPrice                   (const Value: Double    ); begin SetFloatField('Price'            , Value);end;
procedure TVS1_ClientModules.SetRenewPrice              (const Value: Double    ); begin SetFloatField('RenewPrice'       , Value);end;
procedure TVS1_ClientModules.SetDiscountAmt             (const Value: Double    ); begin SetFloatField('DiscountAmt'      , Value);end;
procedure TVS1_ClientModules.SetRenewDiscountAmt        (const Value: Double    ); begin SetFloatField('RenewDiscountAmt'      , Value);end;
procedure TVS1_ClientModules.SetDiscountedPrice         (const Value: Double    ); begin SetFloatField('DiscountedPrice' , Value);end;
procedure TVS1_ClientModules.SetRenewDiscountedPrice    (const Value: Double    ); begin SetFloatField('RenewDiscountedPrice' , Value);end;
procedure TVS1_ClientModules.SetDiscountDesc            (Const Value: String    ); begin SetStringfield('DiscountDesc', value); end;
procedure TVS1_ClientModules.SetRenewDiscountDesc       (Const Value: String    ); begin SetStringfield('RenewDiscountDesc', value); end;
procedure TVS1_ClientModules.SetLicenseExtensionDesc    (Const Value: String    ); begin SetStringfield('LicenseExtensionDesc', value); end;
procedure TVS1_ClientModules.SetmoduleDiscountId        (const Value: Integer   ); begin SetIntegerField('moduleDiscountId' , Value);end;
procedure TVS1_ClientModules.SetDatePaID                (const Value: TDateTime ); begin SetDateTimeField('DatePaID'         , Value);end;
procedure TVS1_ClientModules.SetClientPaymentId         (const Value: Integer   ); begin SetIntegerField('ClientPaymentId' , Value);end;
procedure TVS1_ClientModules.SetDatabaseName            (const Value: String    ); begin SetStringField('DatabaseName'     , Value);end;
procedure TVS1_ClientModules.SetActive                  (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;
procedure TVS1_ClientModules.SetLicenseRenewDuration    (const Value: Integer   ); begin SetIntegerField('LicenseRenewDuration'     , Value);end;
procedure TVS1_ClientModules.SetLicenseRenewDurationType(const Value: string    ); begin SetStringField('LicenseRenewDurationType', Value); if (Value<>'M') and (Value<>'Y') then SetStringField('LicenseRenewDurationType', 'M');  end;
function TVS1_ClientModules.getDiscountdescription: String;
begin
  Result := '';
  if DiscountAmt <> 0 then REsult := 'Discount Amount : ' + Floattostrf(DiscountAmt, ffCurrency, 15,2)
  else if (DiscountedPrice <> Price) then REsult := ' Price : ' + Floattostrf(Price, ffCurrency, 15,2)+NL+'Discounted Price : ' + Floattostrf(DiscountedPrice, ffCurrency, 15,2);
  (*if result <> '' then *)REsult := trim(result + NL+ DiscountDesc)
end;

function TVS1_ClientModules.getLicenseLevelDesc: String;
begin
  Result :=TVS1_LicenseLevels.IDToggle(LicenseLevel);
end;
function TVS1_ClientModules.getModuleName: String;
begin
  Result :=TVS1_Modules.IDToggle(ModuleId);
end;

function TVS1_ClientModules.getProduct: TProductsimple;
begin
  if ModuleId <>0 then
    Result := TProductsimple(getContainercomponent(TProductsimple, 'Partname = ' + Quotedstr(ModuleName) , true, false))
  else
    Result := TProductsimple(getContainercomponent(TProductsimple, 'Partname = ' + Quotedstr(LicenseLevelDesc) , true,false));
  if result.Count = 0 then begin
    result.New;
    if ModuleId <>0 then result.Productname      :=ModuleName                    else result.Productname      := LicenseLevelDesc;
    if ModuleId <>0 then result.ProductPrintname := 'VS1 Module - ' + ModuleName else result.ProductPrintname := 'VS1 LicenseLevel - ' + LicenseLevelDesc;
    result.ProductType := 'NONINV';
    result.SellQTY1 := 1;     result.SellQty1Price := Price;
    result.SellQTY2 := 1;     result.SellQty2Price := Price;
    result.SellQTY3 := 1;     result.SellQty3Price := Price;
    result.ProductGroup1 := 'VS1';
    if ModuleId <>0 then result.ProductGroup2 := 'Module'    else result.ProductGroup2 := 'LicenseLevel';

    result.PostDB;
  end;
end;

function TVS1_ClientModules.getClientModulesUsage: TVS1_ClientModulesUsage;
begin
  //Result := TVS1_ClientModulesUsage(getContainercomponent(TVS1_ClientModulesUsage, 'ClientId = ' + inttostr(ClientId) + ' and ModuleId = ' + inttostr(ModuleId)));
  Result := TVS1_ClientModulesUsage(getContainercomponent(TVS1_ClientModulesUsage, 'ClientModuleID = ' + inttostr(ID) ));
end;
function TVS1_ClientModules.GetCleanLicenseFrom: TDateTime;
begin
  REsult := GetXMLNodeDatetimeValue(CleanXMLNode, 'LicenseFrom');
end;

function TVS1_ClientModules.getcleanLicenseLevel: Integer;
begin
  REsult := GetXMLNodeIntegerValue(CleanXMLNode, 'LicenseLevel');
end;

function TVS1_ClientModules.GetCleanLicenseUntil: TDateTime;
begin
  REsult := GetXMLNodeDatetimeValue(CleanXMLNode, 'LicenseUntil');
end;
function LicenseMonthEnd(aDate: TDate; NoofMonths:Integer): TDate;
begin
  Result := incday(incmonth(aDate,NoofMonths), -1);
end;
  {TVS1_ClientDbServers}

constructor TVS1_ClientDbServers.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'VS1_ClientDbServers';
  fSQL := 'SELECT * FROM tblVS1_clientdbservers';
end;

destructor TVS1_ClientDbServers.Destroy;
begin
  inherited;
end;

procedure TVS1_ClientDbServers.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'RegionId');
  SetPropertyFromNode(node,'ServerName');
  SetPropertyFromNode(node,'AdminDB');
  SetPropertyFromNode(node,'AdminUser');
  SetPropertyFromNode(node,'AdminPass');
  SetPropertyFromNode(node,'APIPort');
  SetBooleanPropertyFromNode(node,'IsHttps');
end;

procedure TVS1_ClientDbServers.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'RegionId' ,RegionId);
  AddXMLNode(node,'ServerName' ,ServerName);
  AddXMLNode(node,'AdminDB' ,AdminDB);
  AddXMLNode(node,'AdminUser' ,AdminUser);
  AddXMLNode(node,'AdminPass' ,AdminPass);
  AddXMLNode(node,'APIPort' ,APIPort);
  AddXMLNode(node,'IsHttps' ,IsHttps);
end;


function TVS1_ClientDbServers.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;

function TVS1_ClientDbServers.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TVS1_ClientDbServers.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TVS1_ClientDbServers.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TVS1_ClientDbServers.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TVS1_ClientDbServers.GetIDField: string;
begin
  Result := 'ID'
end;

class function TVS1_ClientDbServers.GetBusObjectTablename: string;
begin
  Result:= 'tblVS1_clientdbservers';
end;

function TVS1_ClientDbServers.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
function  TVS1_ClientDbServers.GetRegionId  : Integer   ; begin Result := GetIntegerField('RegionId');end;
function  TVS1_ClientDbServers.GetServerName: string    ; begin Result := GetStringField('ServerName');end;
function  TVS1_ClientDbServers.GetAdminDB   : string    ; begin Result := GetStringField('AdminDB');end;
function  TVS1_ClientDbServers.GetAdminUser : string    ; begin Result := GetStringField('AdminUser');end;
function  TVS1_ClientDbServers.GetAdminPass : string    ; begin Result := GetStringField('AdminPass');end;
function  TVS1_ClientDbServers.GetAPIPort   : Integer   ; begin Result := GetIntegerField('APIPort');end;
function  TVS1_ClientDbServers.GetIsHttps   : Boolean   ; begin Result := GetBooleanField('IsHttps');end;
procedure TVS1_ClientDbServers.SetRegionId  (const Value: Integer   ); begin SetIntegerField('RegionId'   , Value);end;
procedure TVS1_ClientDbServers.SetServerName(const Value: string    ); begin SetStringField('ServerName' , Value);end;
procedure TVS1_ClientDbServers.SetAdminDB   (const Value: string    ); begin SetStringField('AdminDB'    , Value);end;
procedure TVS1_ClientDbServers.SetAdminUser (const Value: string    ); begin SetStringField('AdminUser' , Value);end;
procedure TVS1_ClientDbServers.SetAdminPass (const Value: string    ); begin SetStringField('AdminPass' , Value);end;
procedure TVS1_ClientDbServers.SetAPIPort   (const Value: Integer   ); begin SetIntegerField('APIPort' , Value);end;
procedure TVS1_ClientDbServers.SetIsHttps   (const Value: Boolean   ); begin SetBooleanField('IsHttps' , Value);end;
Function  TVS1_ClientDbServers.WebAPIURL(ERPClassname:String=''):String;
begin
  Result := VS1Lib.WebAPIURL(IsHttps,APIPort,ServerName, ERPClassname);
end;

{ TVS1_ClientDbServerSearch }

constructor TVS1_ClientDbServerSearch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SQLOrder := 'RegionId DESC ';
  LimitCount := 1;
end;

{ TVS1_Databases_Main }

constructor TVS1_Databases_Main.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * From tblVS1_Databases WHERE DatabaseName like "'+ ERP_API_DB_PREFIX + 'DB_%"';
end;

{ TVS1_Databases_Sample }

constructor TVS1_Databases_Sample.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * From tblVS1_Databases WHERE DatabaseName like "'+ ERP_API_DB_PREFIX + 'SampleDB_%"';

end;

  {TVS1_ClientLicenseDetails}

constructor TVS1_ClientLicenseDetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fdLicenseCheckDate:= Date;
  fiClientID:= 0;
  fBusObjectTypeDescription:= 'VS1_ClientLicenseDetails';
  fSQL := 'SELECT * FROM tblclientdetails';
  Isreadonly := True;
end;


constructor TVS1_ClientLicenseDetails.Create(AOwner: TComponent; aClientID: Integer; aLicensecheckdate: TDateTime = 0; aDatabaseName: String = '');
begin
  inherited Create(AOwner);

  fdLicenseCheckDate := aLicensecheckdate; if fdLicenseCheckDate = 0 then fdLicenseCheckDate := Date;
  fiClientID := aClientID;
  fsDatabaseName := aDatabaseName;
  fBusObjectTypeDescription := 'VS1_ClientLicenseDetails';
  if fsDatabaseName = '' then MakeSQL
  else MakeSQL2;
  Isreadonly := True;
end;

Procedure TVS1_ClientLicenseDetails.MakeSQL;
begin
  fSQL := 'SELECT ' +
      'D.DatabaseName, ' +
      'D.Regionname, ' +
      //'S.ServerName,S.APIPort, ' +
      'C.ServerName, ' +
      'C.APIPort, ' +
      'C.IsHttps, ' +
      'C.LicenseFrom , ' +
      'C.LicenseUntil, ' +
      'LL.Description as LicenseLevelDesc, ' +
      'M.ModuleName, ' +
      'CM.Active AS ModuleActive, CM.Quantity AS ModuleQty, ' +
      '"F" AS ExtraModule ' + NL +
      'FROM tblVS1_clients C ' + NL +
      'INNER JOIN tblVS1_Databases D ON D.DatabaseName = C.Databasename ' + NL +
      'INNER JOIN tblRegionalOptions R ON D.regionname = R.Region '+ NL +
      //' INNER JOIN tblVS1_clientdbservers S ON D.ServerName = S.ServerName  AND S.regionid = R.RegionID ' +  NL+
      'INNER JOIN tblVS1_ClientModules CM ON C.ID = CM.ClientId AND IFNULL(CM.moduleID,0)=0 ' + NL +
      (*' INNER JOIN tblVS1_licenselevels LL ON CM.LicenseLevel = LL.ID ' +  NL+
      ' inner JOIN tblVS1_modules M ON M.LicenseLevel = LL.ID  AND M.isExtra ="F"' +  NL+*)
      'INNER JOIN tblVS1_LicenseLevels LL ON CM.LicenseLevel = LL.ID ' + NL +
      'INNER JOIN tblVS1_LicenseLevels LLA ON LL.LicenseOrder >= LLA.LicenseOrder ' + NL +
      'INNER JOIN tblVS1_Modules M ON M.LicenseLevel = LLA.ID AND M.isExtra ="F" ' + NL +
      'WHERE C.Id = :clientID ' + NL +
      //' AND :Licensecheckdate between C.LicenseFrom AND C.LicenseUntil ' +
      'AND C.LicenseUntil >= :Licensecheckdate ' + NL +
      'UNION ' + NL +
      'SELECT ' +
      'D.DatabaseName, ' +
      'D.Regionname, ' +
      //'S.ServerName,S.APIPort, ' +
      'C.ServerName, ' +
      'C.APIPort, ' +
      'C.IsHttps, ' +
      'C.LicenseFrom , ' +
      'C.LicenseUntil, ' +
      'LL.Description as LicenseLevelDesc, ' +
      'M.ModuleName, ' +
      'CM.Active as ModuleActive, CM.Quantity AS ModuleQty, ' +
      '"T" AS ExtraModule ' + NL +
      'FROM tblVS1_clients C ' + NL +
      'INNER JOIN tblVS1_Databases D ON D.DatabaseName = C.Databasename ' + NL +
      'INNER JOIN tblRegionalOptions R ON D.RegionName = R.Region ' + NL +
      //' INNER JOIN tblVS1_clientdbservers S ON D.ServerName = S.ServerName  AND S.regionid = R.RegionID ' +  NL+
      'INNER JOIN tblVS1_Clientmodules CM ON C.ID = CM.ClientId AND IFNULL(CM.moduleID,0) <> 0 ' + NL +
      'INNER JOIN tblVS1_LicenseLevels LL ON CM.LicenseLevel = LL.ID ' +  NL +
      'inner JOIN tblVS1_Modules M ON M.id = CM.ModuleId AND M.isExtra ="T"' +  NL +
      'WHERE C.Id = :clientID ' +  NL +
      'AND C.LicenseUntil >= :Licensecheckdate ' +  NL+
      //' AND :Licensecheckdate between C.LicenseFrom AND C.LicenseUntil ' ;
      'ORDER BY LicenseUntil';
  LogText(fSQL);
end;

Procedure TVS1_ClientLicenseDetails.MakeSQL2;
begin
  fSQL := 'SELECT ' +
      'D.DatabaseName, ' +
      'D.Regionname, ' +
      //'S.ServerName,S.APIPort, ' +
      'C.ServerName, ' +
      'C.APIPort, ' +
      'C.IsHttps, ' +
      'C.LicenseFrom , ' +
      'C.LicenseUntil, ' +
      'LL.Description as LicenseLevelDesc, ' +
      'M.ModuleName, ' +
      'CM.Active AS ModuleActive, CM.Quantity AS ModuleQty, ' +
      '"F" AS ExtraModule ' + NL +
      'FROM tblVS1_clients C ' + NL +
      'INNER JOIN tblVS1_Databases D ON C.ID = D.ClientID AND D.DatabaseName = :DatabaseName ' + NL +
      'INNER JOIN tblRegionalOptions R ON D.RegionName = R.Region '+ NL +
      'INNER JOIN tblVS1_ClientModules CM ON C.ID = CM.ClientId AND CM.DatabaseName = :DatabaseName AND IFNULL(CM.ModuleID, 0) = 0 ' + NL +
      'INNER JOIN tblVS1_LicenseLevels LL ON CM.LicenseLevel = LL.ID ' + NL +
      'INNER JOIN tblVS1_LicenseLevels LLA ON LL.LicenseOrder >= LLA.LicenseOrder ' + NL +
      'INNER JOIN tblVS1_Modules M ON M.LicenseLevel = LLA.ID AND M.isExtra ="F" ' + NL +
      'WHERE C.Id = :ClientID ' + NL +
      'AND C.LicenseUntil >= :LicenseCheckdate ' + NL +
      'UNION ' + NL +
      'SELECT ' +
      'D.DatabaseName, ' +
      'D.Regionname, ' +
      'C.ServerName, ' +
      'C.APIPort, ' +
      'C.IsHttps, ' +
      'C.LicenseFrom , ' +
      'C.LicenseUntil, ' +
      'LL.Description as LicenseLevelDesc, ' +
      'M.ModuleName, ' +
      'CM.Active as ModuleActive, CM.Quantity AS ModuleQty, ' +
      '"T" AS ExtraModule ' + NL +
      'FROM tblVS1_clients C ' + NL +
      'INNER JOIN tblVS1_Databases D ON C.ID = D.ClientID AND D.DatabaseName = :DatabaseName ' + NL +
      'INNER JOIN tblRegionalOptions R ON D.RegionName = R.Region ' + NL +
      'INNER JOIN tblVS1_Clientmodules CM ON C.ID = CM.ClientId AND CM.DatabaseName = :DatabaseName  AND IFNULL(CM.moduleID, 0) <> 0 ' + NL +
      'INNER JOIN tblVS1_LicenseLevels LL ON CM.LicenseLevel = LL.ID ' +  NL +
      'inner JOIN tblVS1_Modules M ON M.id = CM.ModuleId AND M.isExtra ="T"' +  NL +
      'WHERE C.Id = :ClientID ' +  NL +
      'AND C.LicenseUntil >= :LicenseCheckdate ' +  NL +
      'ORDER BY LicenseUntil';
  LogText(fSQL);
end;

function TVS1_ClientLicenseDetails.DoBeforeopen(Sender :TDataset): Boolean;
begin
  if sender is TERPQuery then begin
    TERPQuery(Sender).Parambyname('LicenseCheckdate').AsDate := fdLicensecheckdate;
    TERPQuery(Sender).Parambyname('ClientID').AsInteger := ficlientID;
    if fsDatabaseName <> '' then
      TERPQuery(Sender).Parambyname('DatabaseName').AsString := fsDatabaseName;
    LogText(TERPQuery(Sender).SQLtext);
  end;
end;

destructor TVS1_ClientLicenseDetails.Destroy;
begin
  inherited;
end;

procedure TVS1_ClientLicenseDetails.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DatabaseName' ,DatabaseName);
  AddXMLNode(node,'Regionname' ,Regionname);
  AddXMLNode(node,'ServerName' ,ServerName);
  AddXMLNode(node,'APIPort' ,APIPort);
  AddXMLNode(node,'LicenseFrom' ,LicenseFrom);
  AddXMLNode(node,'LicenseUntil' ,LicenseUntil);
  AddXMLNode(node,'LicenseLevelDesc' ,LicenseLevelDesc);
  AddXMLNode(node,'ModuleName' ,ModuleName);
  AddXMLNode(node,'ExtraModule' ,ExtraModule);
end;

procedure TVS1_ClientLicenseDetails.SetClientID(const Value: Integer);
begin
  ficlientID := Value;
  if fsDatabaseName = '' then MakeSQL
  else MakeSQL2;
end;

procedure TVS1_ClientLicenseDetails.SetLicenseCheckDate(const Value: TDatetime);
begin
  fdLicensecheckdate := Value;
  if fsDatabaseName = '' then MakeSQL
  else MakeSQL2;
end;

procedure TVS1_ClientLicenseDetails.SetDBName(const Value: String);
begin
  fsDatabaseName := Value;
  if fsDatabaseName = '' then MakeSQL
  else MakeSQL2;
end;

function TVS1_ClientLicenseDetails.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;

function TVS1_ClientLicenseDetails.WebAPIURL(ERPClassname: String): String;
begin
  REsult := VS1Lib.WebAPIURL(IsHttps,APIPort,ServerName, ERPClassname);
end;

function TVS1_ClientLicenseDetails.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TVS1_ClientLicenseDetails.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TVS1_ClientLicenseDetails.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TVS1_ClientLicenseDetails.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TVS1_ClientLicenseDetails.GetIDField: string;
begin
  Result := 'ID'
end;

class function TVS1_ClientLicenseDetails.GetBusObjectTablename: string;
begin
  Result:= 'tvs1_clients';
end;

function TVS1_ClientLicenseDetails.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
{Property Functions}
function  TVS1_ClientLicenseDetails.GetDatabaseName: string    ; begin Result := GetStringField('DatabaseName');end;
function  TVS1_ClientLicenseDetails.GetRegionname  : string    ; begin Result := GetStringField('Regionname');end;
function  TVS1_ClientLicenseDetails.GetServerName  : string    ; begin Result := GetStringField('ServerName');end;
function  TVS1_ClientLicenseDetails.GetAPIPort     : Integer   ; begin Result := GetIntegerField('APIPort');end;
function  TVS1_ClientLicenseDetails.GetIsHttps     : Boolean   ; begin Result := GetBooleanField('IsHttps');end;
function  TVS1_ClientLicenseDetails.GetLicenseFrom : TDateTime ; begin Result := GetDateTimeField('LicenseFrom');end;
function  TVS1_ClientLicenseDetails.GetLicenseUntil: TDateTime ; begin Result := GetDateTimeField('LicenseUntil');end;
function  TVS1_ClientLicenseDetails.GetLicenseLevelDesc : string    ; begin Result := GetStringField('LicenseLevelDesc');end;
function  TVS1_ClientLicenseDetails.GetModuleName  : string    ; begin Result := GetStringField('ModuleName');end;
function  TVS1_ClientLicenseDetails.GetExtraModule : Boolean   ; begin Result := GetBooleanField('ExtraModule');end;
function  TVS1_ClientLicenseDetails.GetModuleActive: Boolean   ; begin Result := GetBooleanField('ModuleActive');end;
function  TVS1_ClientLicenseDetails.GetModuleQty   : Integer   ; begin Result := GetIntegerField('ModuleQty');end;

initialization

  RegisterClass(TVS1_ClientLicenseDetails);
  RegisterClass(TVS1_ClientModules);
  RegisterClass(TVS1_Databases);
  RegisterClass(TVS1_Databases_Main);
  RegisterClass(TVS1_Databases_Sample);
  RegisterClass(TVS1_Modules);
  RegisterClass(TVS1_ClientPayments);
  RegisterClass(TVS1_ModulePrice);
  RegisterClass(TVS1_Clients_Simple);
  RegisterClass(TVS1_Clients);
  RegisterClass(TVS1_ModuleDiscount);
  RegisterClass(TVS1_LicenseLevels);
  RegisterClass(TVS1_ClientUsers);
  RegisterClass(TVS1_ClientModulesUsage);
  //RegisterClass(TVS1_CompInfo);
  RegisterClass(TVS1_ClientDbServers);
  RegisterClass(TVS1_ClientDbServerSearch);
end.
