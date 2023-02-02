unit BusobjVS1Dashboard;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  22/01/21  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, ERPdbComponents, SysUtils;


type
  TVS1_Dashboard_summary = class(TMSBusObj)
  private
    function GetERPVersionNo                          : Integer   ;
    function GetOVERDUE_INVOICES_AMOUNT               : Double    ;
    function GetOVERDUE_INVOICES_QUANTITY             : Integer   ;
    function GetOUTSTANDING_PAYABLES_AMOUNT           : Double    ;
    function GetOUTSTANDING_PAYABLES_QUANTITY         : Integer   ;
    function GetOVERDUE_PAYABLES_AMOUNT               : Double    ;
    function GetOVERDUE_PAYABLES_QUANTITY             : Integer   ;
    function GetOUTSTANDING_INVOICES_AMOUNT           : Double    ;
    function GetOUTSTANDING_INVOICES_QUANTITY         : Integer   ;
    function GetRegionalOptions_CurrencySymbol        : string    ;
    function GetRegionalOptions_ForeignExDefault      : string    ;
    function GetRegionalOptions_TaxCodePurchaseInc    : string    ;
    function GetRegionalOptions_TaxCodeSalesInc       : string    ;
    function GetColumnHeadings_DefaultClass           : string    ;
    function GetColumnHeadings_DefaultUOM             : string    ;
    function GetCompanyinfo_POBox                     : string    ;
    function GetCompanyinfo_POBox2                    : string    ;
    function GetCompanyinfo_POBox3                    : string    ;
    function GetCompanyinfo_POCity                    : string    ;
    function GetCompanyinfo_POState                   : string    ;
    function GetCompanyinfo_POPostcode                : string    ;
    function GetCompanyinfo_POCountry                 : string    ;
    function GetCompanyinfo_ABN                       : string    ;
    function GetCompanyinfo_CompanyName               : string    ;
    function GetCompanyinfo_TradingName               : string    ;
    function GetCompanyinfo_Address                   : string    ;
    function GetCompanyinfo_Address2                  : string    ;
    function GetCompanyinfo_Address3                  : string    ;
    function GetCompanyinfo_PhoneNumber               : string    ;
    function GetCompanyinfo_URL                       : string    ;
    function GetERPVersionStr                         : string    ;
    function GetCompanyinfo_Email                     : string    ;
    function Getcompanyinfo_IsSetupWizard             : Boolean   ;
    function GetReportsDate                           : TDateTime ;
    function GetReportsDateFrom                       : TDateTime ;
    function GetReportsDateTo                         : TDateTime ;
    function GetPnL_TotalIncomeEx                     : Double    ;
    function GetPnL_TotalIncomeInc                    : Double    ;
    function GetPnL_TotalExpenseEx                    : Double    ;
    function GetPnL_TotalExpenseIn                    : Double    ;
    function GetPnL_TotalCOGSEx                       : Double    ;
    function GetPnL_TotalCOGSIn                       : Double    ;
    function GetPnL_NetIncomeEx                       : Double    ;
    function GetPnL_NetIncomeIn                       : Double    ;

    procedure SetERPVersionNo                          (const Value: Integer   );
    procedure SetOVERDUE_INVOICES_AMOUNT               (const Value: Double    );
    procedure SetOVERDUE_INVOICES_QUANTITY             (const Value: Integer   );
    procedure SetOUTSTANDING_PAYABLES_AMOUNT           (const Value: Double    );
    procedure SetOUTSTANDING_PAYABLES_QUANTITY         (const Value: Integer   );
    procedure SetOVERDUE_PAYABLES_AMOUNT               (const Value: Double    );
    procedure SetOVERDUE_PAYABLES_QUANTITY             (const Value: Integer   );
    procedure SetOUTSTANDING_INVOICES_AMOUNT           (const Value: Double    );
    procedure SetOUTSTANDING_INVOICES_QUANTITY         (const Value: Integer   );
    procedure SetRegionalOptions_CurrencySymbol        (const Value: string    );
    procedure SetRegionalOptions_ForeignExDefault      (const Value: string    );
    procedure SetRegionalOptions_TaxCodePurchaseInc    (const Value: string    );
    procedure SetRegionalOptions_TaxCodeSalesInc       (const Value: string    );
    procedure SetColumnHeadings_DefaultClass           (const Value: string    );
    procedure SetColumnHeadings_DefaultUOM             (const Value: string    );
    procedure SetCompanyinfo_POBox                     (const Value: string    );
    procedure SetCompanyinfo_POBox2                    (const Value: string    );
    procedure SetCompanyinfo_POBox3                    (const Value: string    );
    procedure SetCompanyinfo_POCity                    (const Value: string    );
    procedure SetCompanyinfo_POState                   (const Value: string    );
    procedure SetCompanyinfo_POPostcode                (const Value: string    );
    procedure SetCompanyinfo_POCountry                 (const Value: string    );
    procedure SetCompanyinfo_ABN                       (const Value: string    );
    procedure SetCompanyinfo_CompanyName               (const Value: string    );
    procedure SetCompanyinfo_TradingName               (const Value: string    );
    procedure SetCompanyinfo_Address                   (const Value: string    );
    procedure SetCompanyinfo_Address2                  (const Value: string    );
    procedure SetCompanyinfo_Address3                  (const Value: string    );
    procedure SetCompanyinfo_PhoneNumber               (const Value: string    );
    procedure SetCompanyinfo_URL                       (const Value: string    );
    procedure SetERPVersionStr                         (const Value: string    );
    procedure SetCompanyinfo_Email                     (const Value: string    );
    procedure SetCompanyinfo_IsSetupWizard             (const Value: Boolean   );
    procedure SetReportsDate                           (const Value: TDateTime );
    procedure SetReportsDateFrom                       (const Value: TDateTime );
    procedure SetReportsDateTo                         (const Value: TDateTime );
    procedure SetPnL_TotalIncomeEx                     (const Value: Double    );
    procedure SetPnL_TotalIncomeInc                    (const Value: Double    );
    procedure SetPnL_TotalExpenseEx                    (const Value: Double    );
    procedure SetPnL_TotalExpenseIn                    (const Value: Double    );
    procedure SetPnL_TotalCOGSEx                       (const Value: Double    );
    procedure SetPnL_TotalCOGSIn                       (const Value: Double    );
    procedure SetPnL_NetIncomeEx                       (const Value: Double    );
    procedure SetPnL_NetIncomeIn                       (const Value: Double    );

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
    property ERPVersionNo                           :Integer     read GetERPVersionNo                         write SetERPVersionNo                      ;
    property OVERDUE_INVOICES_AMOUNT                :Double      read GetOVERDUE_INVOICES_AMOUNT              write SetOVERDUE_INVOICES_AMOUNT           ;
    property OVERDUE_INVOICES_QUANTITY              :Integer     read GetOVERDUE_INVOICES_QUANTITY            write SetOVERDUE_INVOICES_QUANTITY         ;
    property OUTSTANDING_PAYABLES_AMOUNT            :Double      read GetOUTSTANDING_PAYABLES_AMOUNT          write SetOUTSTANDING_PAYABLES_AMOUNT       ;
    property OUTSTANDING_PAYABLES_QUANTITY          :Integer     read GetOUTSTANDING_PAYABLES_QUANTITY        write SetOUTSTANDING_PAYABLES_QUANTITY     ;
    property OVERDUE_PAYABLES_AMOUNT                :Double      read GetOVERDUE_PAYABLES_AMOUNT              write SetOVERDUE_PAYABLES_AMOUNT           ;
    property OVERDUE_PAYABLES_QUANTITY              :Integer     read GetOVERDUE_PAYABLES_QUANTITY            write SetOVERDUE_PAYABLES_QUANTITY         ;
    property OUTSTANDING_INVOICES_AMOUNT            :Double      read GetOUTSTANDING_INVOICES_AMOUNT          write SetOUTSTANDING_INVOICES_AMOUNT       ;
    property OUTSTANDING_INVOICES_QUANTITY          :Integer     read GetOUTSTANDING_INVOICES_QUANTITY        write SetOUTSTANDING_INVOICES_QUANTITY     ;
    property RegionalOptions_CurrencySymbol         :string      read GetRegionalOptions_CurrencySymbol       write SetRegionalOptions_CurrencySymbol    ;
    property RegionalOptions_ForeignExDefault       :string      read GetRegionalOptions_ForeignExDefault     write SetRegionalOptions_ForeignExDefault  ;
    property RegionalOptions_TaxCodePurchaseInc     :string      read GetRegionalOptions_TaxCodePurchaseInc   write SetRegionalOptions_TaxCodePurchaseInc;
    property RegionalOptions_TaxCodeSalesInc        :string      read GetRegionalOptions_TaxCodeSalesInc      write SetRegionalOptions_TaxCodeSalesInc   ;
    property ColumnHeadings_DefaultClass            :string      read GetColumnHeadings_DefaultClass          write SetColumnHeadings_DefaultClass       ;
    property ColumnHeadings_DefaultUOM              :string      read GetColumnHeadings_DefaultUOM            write SetColumnHeadings_DefaultUOM         ;
    property Companyinfo_POBox                      :string      read GetCompanyinfo_POBox                    write SetCompanyinfo_POBox                 ;
    property Companyinfo_POBox2                     :string      read GetCompanyinfo_POBox2                   write SetCompanyinfo_POBox2                ;
    property Companyinfo_POBox3                     :string      read GetCompanyinfo_POBox3                   write SetCompanyinfo_POBox3                ;
    property Companyinfo_POCity                     :string      read GetCompanyinfo_POCity                   write SetCompanyinfo_POCity                ;
    property Companyinfo_POState                    :string      read GetCompanyinfo_POState                  write SetCompanyinfo_POState               ;
    property Companyinfo_POPostcode                 :string      read GetCompanyinfo_POPostcode               write SetCompanyinfo_POPostcode            ;
    property Companyinfo_POCountry                  :string      read GetCompanyinfo_POCountry                write SetCompanyinfo_POCountry             ;
    property Companyinfo_ABN                        :string      read GetCompanyinfo_ABN                      write SetCompanyinfo_ABN                   ;
    property Companyinfo_CompanyName                :string      read GetCompanyinfo_CompanyName              write SetCompanyinfo_CompanyName           ;
    property Companyinfo_TradingName                :string      read GetCompanyinfo_TradingName              write SetCompanyinfo_TradingName           ;
    property Companyinfo_Address                    :string      read GetCompanyinfo_Address                  write SetCompanyinfo_Address               ;
    property Companyinfo_Address2                   :string      read GetCompanyinfo_Address2                 write SetCompanyinfo_Address2              ;
    property Companyinfo_Address3                   :string      read GetCompanyinfo_Address3                 write SetCompanyinfo_Address3              ;
    property Companyinfo_PhoneNumber                :string      read GetCompanyinfo_PhoneNumber              write SetCompanyinfo_PhoneNumber           ;
    property Companyinfo_URL                        :string      read GetCompanyinfo_URL                      write SetCompanyinfo_URL                   ;
    property ERPVersionStr                          :string      read GetERPVersionStr                        write SetERPVersionStr                     ;
    property Companyinfo_Email                      :string      read GetCompanyinfo_Email                    write SetCompanyinfo_Email                 ;
    property Companyinfo_IsSetupWizard              :Boolean     read GetCompanyinfo_IsSetupWizard            write SetCompanyinfo_IsSetupWizard         ;
    property ReportsDate                            :TDateTime   read GetReportsDate                          write SetReportsDate                       ;
    property ReportsDateFrom                        :TDateTime   read GetReportsDateFrom                      write SetReportsDateFrom                   ;
    property ReportsDateTo                          :TDateTime   read GetReportsDateTo                        write SetReportsDateTo                     ;
    property PnL_TotalIncomeEx                      :Double      read GetPnL_TotalIncomeEx                    write SetPnL_TotalIncomeEx                 ;
    property PnL_TotalIncomeInc                     :Double      read GetPnL_TotalIncomeInc                   write SetPnL_TotalIncomeInc                ;
    property PnL_TotalExpenseEx                     :Double      read GetPnL_TotalExpenseEx                   write SetPnL_TotalExpenseEx                ;
    property PnL_TotalExpenseIn                     :Double      read GetPnL_TotalExpenseIn                   write SetPnL_TotalExpenseIn                ;
    property PnL_TotalCOGSEx                        :Double      read GetPnL_TotalCOGSEx                      write SetPnL_TotalCOGSEx                   ;
    property PnL_TotalCOGSIn                        :Double      read GetPnL_TotalCOGSIn                      write SetPnL_TotalCOGSIn                   ;
    property PnL_NetIncomeEx                        :Double      read GetPnL_NetIncomeEx                      write SetPnL_NetIncomeEx                   ;
    property PnL_NetIncomeIn                        :Double      read GetPnL_NetIncomeIn                      write SetPnL_NetIncomeIn                   ;
  end;

  TVS1_Dashboard_salesperemployee = class(TMSBusObj)
  private
    function GetEmployeeID            : Integer   ;
    function Getemployeename          : string    ;
    function GetTotalsales            : Double    ;
    function Getinvoicetotal          : Double    ;
    function Getquotetotal            : Double    ;
    procedure SetEmployeeID            (const Value: Integer   );
    procedure Setemployeename          (const Value: string    );
    procedure SetTotalsales            (const Value: Double    );
    procedure Setinvoicetotal          (const Value: Double    );
    procedure Setquotetotal            (const Value: Double    );

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
    property EmployeeID             :Integer     read GetEmployeeID           write SetEmployeeID        ;
    property employeename           :string      read Getemployeename         write Setemployeename      ;
    property Totalsales             :Double      read GetTotalsales           write SetTotalsales        ;
    property invoicetotal           :Double      read Getinvoicetotal         write Setinvoicetotal      ;
    property quotetotal             :Double      read Getquotetotal           write Setquotetotal        ;
  end;

  TVS1_Dashboard_saleslist = class(TMSBusObj)
  private
    function GetDatefrom              : TDateTime ;
    function Getdateto                : TDateTime ;
    function Getmonth1                : string    ;
    function GetMONTH2                : string    ;
    function GetMONTH3                : string    ;
    function Getinvoicetotal          : Double    ;
    function Getquotetotal            : Double    ;
    procedure SetDatefrom              (const Value: TDateTime );
    procedure Setdateto                (const Value: TDateTime );
    procedure Setmonth1                (const Value: string    );
    procedure SetMONTH2                (const Value: string    );
    procedure SetMONTH3                (const Value: string    );
    procedure Setinvoicetotal          (const Value: Double    );
    procedure Setquotetotal            (const Value: Double    );

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
    property Datefrom               :TDateTime   read GetDatefrom             write SetDatefrom          ;
    property dateto                 :TDateTime   read Getdateto               write Setdateto            ;
    property month1                 :string      read Getmonth1               write Setmonth1            ;
    property MONTH2                 :string      read GetMONTH2               write SetMONTH2            ;
    property MONTH3                 :string      read GetMONTH3               write SetMONTH3            ;
    property invoicetotal           :Double      read Getinvoicetotal         write Setinvoicetotal      ;
    property quotetotal             :Double      read Getquotetotal           write Setquotetotal        ;
  end;

  TVS1_Dashboard_pnl = class(TMSBusObj)
  private
    function GetSeqNo               :Integer;
    function GetIsRoot              :Boolean;
    function GetAccountID           :Integer;
    function GetAccountNo           :String;
    function GetAccountName         :String;
    function GetAccountType         :String;
    function GetAccountTypeDesc     :String;
    function GetFinalOrder          :Integer;
    function GetAccountHeaderOrder  :String;
    function GetAccountSub1Order    :String;
    function GetAccountSub2Order    :String;
    function GetAccountSub3Order    :String;
    function GetTotalAmountInc      :Double;
    function GetTotalAmountEx       :Double;
    function GetSubTotalInc         :Double;
    function GetSubTotalEx          :Double;
    function GetHeadOfficeInc       :Double;
    function GetHeadofficeEx        :Double;
    function GetHideTotal           :Boolean;
    function GetLevel1              :String;
    function GetLevel2              :String;
    function GetLevel3              :String;
    function GetLevel4              :String;
    function GetLevel5              :String;

    procedure SetSeqNo               (const Value: Integer);
    procedure SetIsRoot              (const Value: Boolean);
    procedure SetAccountID           (const Value: Integer);
    procedure SetAccountNo           (const Value: String);
    procedure SetAccountName         (const Value: String);
    procedure SetAccountType         (const Value: String);
    procedure SetAccountTypeDesc     (const Value: String);
    procedure SetFinalOrder          (const Value: Integer);
    procedure SetAccountHeaderOrder  (const Value: String);
    procedure SetAccountSub1Order    (const Value: String);
    procedure SetAccountSub2Order    (const Value: String);
    procedure SetAccountSub3Order    (const Value: String);
    procedure SetTotalAmountInc      (const Value: Double);
    procedure SetTotalAmountEx       (const Value: Double);
    procedure SetSubTotalInc         (const Value: Double);
    procedure SetSubTotalEx          (const Value: Double);
    procedure SetHeadOfficeInc       (const Value: Double);
    procedure SetHeadofficeEx        (const Value: Double);
    procedure SetHideTotal           (const Value: Boolean);
    procedure SetLevel1              (const Value: String);
    procedure SetLevel2              (const Value: String);
    procedure SetLevel3              (const Value: String);
    procedure SetLevel4              (const Value: String);
    procedure SetLevel5              (const Value: String);

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
    property SeqNo              :Integer      read GetSeqNo               write SetAccountID;
    property IsRoot             :Boolean      read GetIsRoot              write SetIsRoot;
    property AccountID          :Integer      read GetAccountID           write SetAccountID;
    property AccountNo          :String       read GetAccountNo           write SetAccountNo;
    property AccountName        :String       read GetAccountName         write SetAccountName;
    property AccountType        :String       read GetAccountType         write SetAccountType;
    property AccountTypeDesc    :String       read GetAccountTypeDesc     write SetAccountTypeDesc;
    property FinalOrder         :Integer      read GetFinalOrder          write SetFinalOrder;
    property AccountHeaderOrder :String       read GetAccountHeaderOrder  write SetAccountHeaderOrder;
    property AccountSub1Order   :String       read GetAccountSub1Order    write SetAccountSub1Order;
    property AccountSub2Order   :String       read GetAccountSub2Order    write SetAccountSub2Order;
    property AccountSub3Order   :String       read GetAccountSub3Order    write SetAccountSub3Order;
    property TotalAmountInc     :Double       read GetTotalAmountInc      write SetTotalAmountInc;
    property TotalAmountEx      :Double       read GetTotalAmountEx       write SetTotalAmountEx;
    property SubTotalInc        :Double       read GetSubTotalInc         write SetSubTotalInc;
    property SubTotalEx         :Double       read GetSubTotalEx          write SetSubTotalEx;
    property HeadOfficeInc      :Double       read GetHeadOfficeInc       write SetHeadOfficeInc;
    property HeadOfficeEx       :Double       read GetHeadofficeEx        write SetHeadOfficeEx;
    property HideTotal          :Boolean      read GetHideTotal           write SetHideTotal;
    property Level1             :String       read GetLevel1              write SetLevel1;
    property Level2             :String       read GetLevel2              write SetLevel2;
    property Level3             :String       read GetLevel3              write SetLevel3;
    property Level4             :String       read GetLevel4              write SetLevel4;
    property Level5             :String       read GetLevel5              write SetLevel5;

  end;

  TVS1_Dashboard_pnl_period = class(TMSBusObj)
  private
    function GetDateFrom_1            : TDateTime ;
    function GetDateTo_1              : TDateTime ;
    function GetDateDesc_1            : string    ;
    function GetDateFrom_2            : TDateTime ;
    function GetDateTo_2              : TDateTime ;
    function GetDateDesc_2            : string    ;
    function GetDateFrom_3            : TDateTime ;
    function GetDateTo_3              : TDateTime ;
    function GetDateDesc_3            : string    ;
    function GetDateFrom_4            : TDateTime ;
    function GetDateTo_4              : TDateTime ;
    function GetDateDesc_4            : string    ;
    function GetDateFrom_5            : TDateTime ;
    function GetDateTo_5              : TDateTime ;
    function GetDateDesc_5            : string    ;
    function GetDateFrom_6            : TDateTime ;
    function GetDateTo_6              : TDateTime ;
    function GetDateDesc_6            : string    ;
    function GetDateFrom_7            : TDateTime ;
    function GetDateTo_7              : TDateTime ;
    function GetDateDesc_7            : string    ;
(*    function GetDateFrom_8            : TDateTime ;
    function GetDateTo_8              : TDateTime ;
    function GetDateDesc_8            : string    ;*)
    function GetHidePercentage        : Boolean   ;
    function GetAccountID             : Integer   ;
    function GetAccountType           : string    ;
    function GetAccountTypeDesc       : string    ;
    function GetAccountName           : string    ;
    function GetAmount_1              : Double    ;
    function GetPercentage_1          : string    ;
    function GetAmount_2              : Double    ;
    function GetPercentage_2          : string    ;
    function GetChange_2              : Double    ;
    function GetChangePercent_2       : Double    ;
    function GetAmount_3              : Double    ;
    function GetPercentage_3          : string    ;
    function GetChange_3              : Double    ;
    function GetChangePercent_3       : Double    ;
    function GetAmount_4              : Double    ;
    function GetPercentage_4          : string    ;
    function GetChange_4              : Double    ;
    function GetChangePercent_4       : Double    ;
    function GetAmount_5              : Double    ;
    function GetPercentage_5          : string    ;
    function GetChange_5              : Double    ;
    function GetChangePercent_5       : Double    ;
    function GetAmount_6              : Double    ;
    function GetPercentage_6          : string    ;
    function GetChange_6              : Double    ;
    function GetChangePercent_6       : Double    ;
    function GetAmount_7              : Double    ;
    function GetPercentage_7          : string    ;
    function GetChange_7              : Double    ;
    function GetChangePercent_7       : Double    ;
(*    function GetAmount_8              : Double    ;
    function GetPercentage_8          : string    ;
    function GetChange_8              : Double    ;
    function GetChangePercent_8       : Double    ;
    function GetAmount_9              : Double    ;
    function GetPercentage_9          : string    ;
    function GetAmount_10             : Double    ;
    function GetPercentage_10         : string    ;
    function GetAmount_11             : Double    ;
    function GetPercentage_11         : string    ;
    function GetAmount_12             : Double    ;
    function GetPercentage_12         : string    ;
    function GetAmount_13             : Double    ;
    function GetPercentage_13         : string    ;
    function GetAmount_14             : Double    ;
    function GetPercentage_14         : string    ;
    function GetAmount_15             : Double    ;
    function GetPercentage_15         : string    ;
    function GetAmount_16             : Double    ;
    function GetPercentage_16         : string    ;
    function GetAmount_17             : Double    ;
    function GetPercentage_17         : string    ;
    function GetAmount_18             : Double    ;
    function GetPercentage_18         : string    ;
    function GetAmount_19             : Double    ;
    function GetPercentage_19         : string    ;
    function GetAmount_20             : Double    ;
    function GetPercentage_20         : string    ;*)
    function GetTotalAmount           : Double    ;
    function GetFinalOrder            : Integer   ;
    function GetAccountHeaderOrder    : string    ;
    function GetAccountSub1Order      : string    ;
    function GetAccountSub2Order      : string    ;
    function GetAccountSub3Order      : string    ;
    function GetHideTotal             : Boolean   ;
    procedure SetDateFrom_1            (const Value: TDateTime );
    procedure SetDateTo_1              (const Value: TDateTime );
    procedure SetDateDesc_1            (const Value: string    );
    procedure SetDateFrom_2            (const Value: TDateTime );
    procedure SetDateTo_2              (const Value: TDateTime );
    procedure SetDateDesc_2            (const Value: string    );
    procedure SetDateFrom_3            (const Value: TDateTime );
    procedure SetDateTo_3              (const Value: TDateTime );
    procedure SetDateDesc_3            (const Value: string    );
    procedure SetDateFrom_4            (const Value: TDateTime );
    procedure SetDateTo_4              (const Value: TDateTime );
    procedure SetDateDesc_4            (const Value: string    );
    procedure SetDateFrom_5            (const Value: TDateTime );
    procedure SetDateTo_5              (const Value: TDateTime );
    procedure SetDateDesc_5            (const Value: string    );
    procedure SetDateFrom_6            (const Value: TDateTime );
    procedure SetDateTo_6              (const Value: TDateTime );
    procedure SetDateDesc_6            (const Value: string    );
    procedure SetDateFrom_7            (const Value: TDateTime );
    procedure SetDateTo_7              (const Value: TDateTime );
    procedure SetDateDesc_7            (const Value: string    );
(*    procedure SetDateFrom_8            (const Value: TDateTime );
    procedure SetDateTo_8              (const Value: TDateTime );
    procedure SetDateDesc_8            (const Value: string    );*)
    procedure SetHidePercentage        (const Value: Boolean   );
    procedure SetAccountID             (const Value: Integer   );
    procedure SetAccountType           (const Value: string    );
    procedure SetAccountTypeDesc       (const Value: string    );
    procedure SetAccountName           (const Value: string    );
    procedure SetAmount_1              (const Value: Double    );
    procedure SetPercentage_1          (const Value: string    );
    procedure SetAmount_2              (const Value: Double    );
    procedure SetPercentage_2          (const Value: string    );
    procedure SetChange_2              (const Value: Double    );
    procedure SetChangePercent_2       (const Value: Double    );
    procedure SetAmount_3              (const Value: Double    );
    procedure SetPercentage_3          (const Value: string    );
    procedure SetChange_3              (const Value: Double    );
    procedure SetChangePercent_3       (const Value: Double    );
    procedure SetAmount_4              (const Value: Double    );
    procedure SetPercentage_4          (const Value: string    );
    procedure SetChange_4              (const Value: Double    );
    procedure SetChangePercent_4       (const Value: Double    );
    procedure SetAmount_5              (const Value: Double    );
    procedure SetPercentage_5          (const Value: string    );
    procedure SetChange_5              (const Value: Double    );
    procedure SetChangePercent_5       (const Value: Double    );
    procedure SetAmount_6              (const Value: Double    );
    procedure SetPercentage_6          (const Value: string    );
    procedure SetChange_6              (const Value: Double    );
    procedure SetChangePercent_6       (const Value: Double    );
    procedure SetAmount_7              (const Value: Double    );
    procedure SetPercentage_7          (const Value: string    );
    procedure SetChange_7              (const Value: Double    );
    procedure SetChangePercent_7       (const Value: Double    );
(*    procedure SetAmount_8              (const Value: Double    );
    procedure SetPercentage_8          (const Value: string    );
    procedure SetChange_8              (const Value: Double    );
    procedure SetChangePercent_8       (const Value: Double    );
    procedure SetAmount_9              (const Value: Double    );
    procedure SetPercentage_9          (const Value: string    );
    procedure SetAmount_10             (const Value: Double    );
    procedure SetPercentage_10         (const Value: string    );
    procedure SetAmount_11             (const Value: Double    );
    procedure SetPercentage_11         (const Value: string    );
    procedure SetAmount_12             (const Value: Double    );
    procedure SetPercentage_12         (const Value: string    );
    procedure SetAmount_13             (const Value: Double    );
    procedure SetPercentage_13         (const Value: string    );
    procedure SetAmount_14             (const Value: Double    );
    procedure SetPercentage_14         (const Value: string    );
    procedure SetAmount_15             (const Value: Double    );
    procedure SetPercentage_15         (const Value: string    );
    procedure SetAmount_16             (const Value: Double    );
    procedure SetPercentage_16         (const Value: string    );
    procedure SetAmount_17             (const Value: Double    );
    procedure SetPercentage_17         (const Value: string    );
    procedure SetAmount_18             (const Value: Double    );
    procedure SetPercentage_18         (const Value: string    );
    procedure SetAmount_19             (const Value: Double    );
    procedure SetPercentage_19         (const Value: string    );
    procedure SetAmount_20             (const Value: Double    );
    procedure SetPercentage_20         (const Value: string    );*)
    procedure SetTotalAmount           (const Value: Double    );
    procedure SetFinalOrder            (const Value: Integer   );
    procedure SetAccountHeaderOrder    (const Value: string    );
    procedure SetAccountSub1Order      (const Value: string    );
    procedure SetAccountSub2Order      (const Value: string    );
    procedure SetAccountSub3Order      (const Value: string    );
    procedure SetHideTotal             (const Value: Boolean   );

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
    property DateFrom_1             :TDateTime   read GetDateFrom_1           write SetDateFrom_1        ;
    property DateTo_1               :TDateTime   read GetDateTo_1             write SetDateTo_1          ;
    property DateDesc_1             :string      read GetDateDesc_1           write SetDateDesc_1        ;
    property DateFrom_2             :TDateTime   read GetDateFrom_2           write SetDateFrom_2        ;
    property DateTo_2               :TDateTime   read GetDateTo_2             write SetDateTo_2          ;
    property DateDesc_2             :string      read GetDateDesc_2           write SetDateDesc_2        ;
    property DateFrom_3             :TDateTime   read GetDateFrom_3           write SetDateFrom_3        ;
    property DateTo_3               :TDateTime   read GetDateTo_3             write SetDateTo_3          ;
    property DateDesc_3             :string      read GetDateDesc_3           write SetDateDesc_3        ;
    property DateFrom_4             :TDateTime   read GetDateFrom_4           write SetDateFrom_4        ;
    property DateTo_4               :TDateTime   read GetDateTo_4             write SetDateTo_4          ;
    property DateDesc_4             :string      read GetDateDesc_4           write SetDateDesc_4        ;
    property DateFrom_5             :TDateTime   read GetDateFrom_5           write SetDateFrom_5        ;
    property DateTo_5               :TDateTime   read GetDateTo_5             write SetDateTo_5          ;
    property DateDesc_5             :string      read GetDateDesc_5           write SetDateDesc_5        ;
    property DateFrom_6             :TDateTime   read GetDateFrom_6           write SetDateFrom_6        ;
    property DateTo_6               :TDateTime   read GetDateTo_6             write SetDateTo_6          ;
    property DateDesc_6             :string      read GetDateDesc_6           write SetDateDesc_6        ;
    property DateFrom_7             :TDateTime   read GetDateFrom_7           write SetDateFrom_7        ;
    property DateTo_7               :TDateTime   read GetDateTo_7             write SetDateTo_7          ;
    property DateDesc_7             :string      read GetDateDesc_7           write SetDateDesc_7        ;
(*    property DateFrom_8             :TDateTime   read GetDateFrom_8           write SetDateFrom_8        ;
    property DateTo_8               :TDateTime   read GetDateTo_8             write SetDateTo_8          ;
    property DateDesc_8             :string      read GetDateDesc_8           write SetDateDesc_8        ;*)
    property HidePercentage         :Boolean     read GetHidePercentage       write SetHidePercentage    ;
    property AccountID              :Integer     read GetAccountID            write SetAccountID         ;
    property AccountType            :string      read GetAccountType          write SetAccountType       ;
    property AccountTypeDesc        :string      read GetAccountTypeDesc      write SetAccountTypeDesc   ;
    property AccountName            :string      read GetAccountName          write SetAccountName       ;
    property Amount_1               :Double      read GetAmount_1             write SetAmount_1          ;
    property Percentage_1           :string      read GetPercentage_1         write SetPercentage_1      ;
    property Amount_2               :Double      read GetAmount_2             write SetAmount_2          ;
    property Percentage_2           :string      read GetPercentage_2         write SetPercentage_2      ;
    property Change_2               :Double      read GetChange_2             write SetChange_2          ;
    property ChangePercent_2        :Double      read GetChangePercent_2      write SetChangePercent_2   ;
    property Amount_3               :Double      read GetAmount_3             write SetAmount_3          ;
    property Percentage_3           :string      read GetPercentage_3         write SetPercentage_3      ;
    property Change_3               :Double      read GetChange_3             write SetChange_3          ;
    property ChangePercent_3        :Double      read GetChangePercent_3      write SetChangePercent_3   ;
    property Amount_4               :Double      read GetAmount_4             write SetAmount_4          ;
    property Percentage_4           :string      read GetPercentage_4         write SetPercentage_4      ;
    property Change_4               :Double      read GetChange_4             write SetChange_4          ;
    property ChangePercent_4        :Double      read GetChangePercent_4      write SetChangePercent_4   ;
    property Amount_5               :Double      read GetAmount_5             write SetAmount_5          ;
    property Percentage_5           :string      read GetPercentage_5         write SetPercentage_5      ;
    property Change_5               :Double      read GetChange_5             write SetChange_5          ;
    property ChangePercent_5        :Double      read GetChangePercent_5      write SetChangePercent_5   ;
    property Amount_6               :Double      read GetAmount_6             write SetAmount_6          ;
    property Percentage_6           :string      read GetPercentage_6         write SetPercentage_6      ;
    property Change_6               :Double      read GetChange_6             write SetChange_6          ;
    property ChangePercent_6        :Double      read GetChangePercent_6      write SetChangePercent_6   ;
    property Amount_7               :Double      read GetAmount_7             write SetAmount_7          ;
    property Percentage_7           :string      read GetPercentage_7         write SetPercentage_7      ;
    property Change_7               :Double      read GetChange_7             write SetChange_7          ;
    property ChangePercent_7        :Double      read GetChangePercent_7      write SetChangePercent_7   ;
(*    property Amount_8               :Double      read GetAmount_8             write SetAmount_8          ;
    property Percentage_8           :string      read GetPercentage_8         write SetPercentage_8      ;
    property Change_8               :Double      read GetChange_8             write SetChange_8          ;
    property ChangePercent_8        :Double      read GetChangePercent_8      write SetChangePercent_8   ;
    property Amount_9               :Double      read GetAmount_9             write SetAmount_9          ;
    property Percentage_9           :string      read GetPercentage_9         write SetPercentage_9      ;
    property Amount_10              :Double      read GetAmount_10            write SetAmount_10         ;
    property Percentage_10          :string      read GetPercentage_10        write SetPercentage_10     ;
    property Amount_11              :Double      read GetAmount_11            write SetAmount_11         ;
    property Percentage_11          :string      read GetPercentage_11        write SetPercentage_11     ;
    property Amount_12              :Double      read GetAmount_12            write SetAmount_12         ;
    property Percentage_12          :string      read GetPercentage_12        write SetPercentage_12     ;
    property Amount_13              :Double      read GetAmount_13            write SetAmount_13         ;
    property Percentage_13          :string      read GetPercentage_13        write SetPercentage_13     ;
    property Amount_14              :Double      read GetAmount_14            write SetAmount_14         ;
    property Percentage_14          :string      read GetPercentage_14        write SetPercentage_14     ;
    property Amount_15              :Double      read GetAmount_15            write SetAmount_15         ;
    property Percentage_15          :string      read GetPercentage_15        write SetPercentage_15     ;
    property Amount_16              :Double      read GetAmount_16            write SetAmount_16         ;
    property Percentage_16          :string      read GetPercentage_16        write SetPercentage_16     ;
    property Amount_17              :Double      read GetAmount_17            write SetAmount_17         ;
    property Percentage_17          :string      read GetPercentage_17        write SetPercentage_17     ;
    property Amount_18              :Double      read GetAmount_18            write SetAmount_18         ;
    property Percentage_18          :string      read GetPercentage_18        write SetPercentage_18     ;
    property Amount_19              :Double      read GetAmount_19            write SetAmount_19         ;
    property Percentage_19          :string      read GetPercentage_19        write SetPercentage_19     ;
    property Amount_20              :Double      read GetAmount_20            write SetAmount_20         ;
    property Percentage_20          :string      read GetPercentage_20        write SetPercentage_20     ;*)
    property TotalAmount            :Double      read GetTotalAmount          write SetTotalAmount       ;
    property FinalOrder             :Integer     read GetFinalOrder           write SetFinalOrder        ;
    property AccountHeaderOrder     :string      read GetAccountHeaderOrder   write SetAccountHeaderOrder;
    property AccountSub1Order       :string      read GetAccountSub1Order     write SetAccountSub1Order  ;
    property AccountSub2Order       :string      read GetAccountSub2Order     write SetAccountSub2Order  ;
    property AccountSub3Order       :string      read GetAccountSub3Order     write SetAccountSub3Order  ;
    property HideTotal              :Boolean     read GetHideTotal            write SetHideTotal         ;
  end;

  TVS1_Dashboard_ap_report = class(TMSBusObj)
  private
    function GetDatefrom    : TDateTime ;
    function Getdateto      : TDateTime ;
    function Getmonth1      : string    ;
    function GetMONTH2      : string    ;
    function GetMONTH3      : string    ;
    function Gettotal       : Double    ;
    procedure SetDatefrom    (const Value: TDateTime );
    procedure Setdateto      (const Value: TDateTime );
    procedure Setmonth1      (const Value: string    );
    procedure SetMONTH2      (const Value: string    );
    procedure SetMONTH3      (const Value: string    );
    procedure Settotal       (const Value: Double    );

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
    property Datefrom     :TDateTime   read GetDatefrom   write SetDatefrom;
    property dateto       :TDateTime   read Getdateto     write Setdateto  ;
    property month1       :string      read Getmonth1     write Setmonth1  ;
    property MONTH2       :string      read GetMONTH2     write SetMONTH2  ;
    property MONTH3       :string      read GetMONTH3     write SetMONTH3  ;
    property total        :Double      read Gettotal      write Settotal   ;
  end;

  TVS1_Dashboard_Summary2 = class(TMSBusObj)
  private
    function GetCashReceived      : Double;
    function GetCashSpent         : Double;
    function GetCashSurplus       : Double;
    function GetCashBalance       : Double;
    function GetProfIncome        : Double;
    function GetProfGross         : Double;
    function GetProfExpenses      : Double;
    function GetProfNet           : Double;
    function GetIncomeInvoices    : Integer;
    function GetIncomeAverage     : Double;
    function GetIncometotal       : Double;
    function GetPerfGrossMargin   : Double;
    function GetPerfNetMargin     : Double;
    function GetPerfROI           : Double;
    function GetBalDebtors        : Double;
    function GetBalCreditors      : Double;
    function GetBalNetAsset       : Double;
    function GetPosAvgDebtDays    : Integer;
    function GetPosAvgCredDays    : Integer;
    function GetPosCashForecast   : Double;
    function GetPosAssetToLiab    : Double;
    function GetSheetAssetToLiab  : Double;

    procedure SetCashReceived    (const Value: Double);
    procedure SetCashSpent       (const Value: Double);
    procedure SetCashSurplus     (const Value: Double);
    procedure SetCashBalance     (const Value: Double);
    procedure SetProfIncome      (const Value: Double);
    procedure SetProfGross       (const Value: Double);
    procedure SetProfExpenses    (const Value: Double);
    procedure SetProfNet         (const Value: Double);
    procedure SetIncomeInvoices  (const Value: Integer);
    procedure SetIncomeAverage   (const Value: Double);
    procedure SetIncomeTotal     (const Value: Double);
    procedure SetPerfGrossMargin (const Value: Double);
    procedure SetPerfNetMargin   (const Value: Double);
    procedure SetPerfROI         (const Value: Double);
    procedure SetBalDebtors      (const Value: Double);
    procedure SetBalCreditors    (const Value: Double);
    procedure SetBalNetAsset     (const Value: Double);
    procedure SetPosAvgDebtDays  (const Value: Integer);
    procedure SetPosAvgCredDays  (const Value: Integer);
    procedure SetPosCashForecast (const Value: Double);
    procedure SetPosAssetToLiab  (const Value: Double);
    procedure SetSheetAssetToLiab(const Value: Double);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent); override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    procedure    CreateTemporaryTable(ADateFrom: string; ADateTo: string);

  published
    property Cash_Received    : Double   read GetCashReceived     write SetCashReceived;
    property Cash_Spent       : Double   read GetCashSpent        write SetCashSpent;
    property Cash_Surplus     : Double   read GetCashSurplus      write SetCashSurplus;
    property Cash_Balance     : Double   read GetCashBalance      write SetCashBalance;

    property Prof_Income      : Double   read GetProfIncome       write SetProfIncome;
    property Prof_Gross       : Double   read GetProfGross        write SetProfGross;
    property Prof_Expenses    : Double   read GetProfExpenses     write SetProfExpenses;
    property Prof_Net         : Double   read GetProfNet          write SetProfNet;

    property Income_Invoices  : Integer  read GetIncomeInvoices   write SetIncomeInvoices;
    property Income_Average   : Double   read GetIncomeAverage    write SetIncomeAverage;
    property Income_Total     : Double   read GetIncomeTotal      write SetIncomeTotal;

    property Perf_GrossMargin  : Double  read GetPerfGrossMargin  write SetPerfGrossMargin;
    property Perf_NetMargin    : Double  read GetPerfNetMargin    write SetPerfNetMargin;
    property Perf_ROI          : Double  read GetPerfROI          write SetPerfROI;

    property Bal_Debtors       : Double  read GetBalDebtors       write SetBalDebtors;
    property Bal_Creditors     : Double  read GetBalCreditors     write SetBalCreditors;
    property Bal_NetAsset      : Double  read GetBalNetAsset      write SetBalNetAsset;

    property Pos_AvgDebtDays   : Integer read GetPosAvgDebtDays   write SetPosAvgDebtDays;
    property Pos_AvgCredDays   : Integer read GetPosAvgCredDays   write SetPosAvgCredDays;
    property Pos_CashForecast  : Double  read GetPosCashForecast  write SetPosCashForecast;
    property Pos_AssetToLiab   : Double  read GetPosAssetToLiab   write SetPosAssetToLiab;

    property Sheet_AssetToLiab : Double  read GetSheetAssetToLiab write SetSheetAssetToLiab;
  end;

implementation

uses tcDataUtils, CommonLib, JSONObject, CommonDbLib, MySQLConst;


  {TVS1_Dashboard_summary}

constructor TVS1_Dashboard_summary.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1_dashboard_summary';
  fSQL := 'SELECT * FROM tmp_vs1_dashboard_summary';
end;

destructor TVS1_Dashboard_summary.Destroy;
begin
  inherited;
end;

procedure TVS1_Dashboard_summary.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'OVERDUE_INVOICES_AMOUNT');
  SetPropertyFromNode(node,'OVERDUE_INVOICES_QUANTITY');
  SetPropertyFromNode(node,'ERPVersionNo');
  SetPropertyFromNode(node,'OUTSTANDING_PAYABLES_AMOUNT');
  SetPropertyFromNode(node,'OUTSTANDING_PAYABLES_QUANTITY');
  SetPropertyFromNode(node,'RegionalOptions_CurrencySymbol');
  SetPropertyFromNode(node,'RegionalOptions_ForeignExDefault');
  SetPropertyFromNode(node,'RegionalOptions_TaxCodePurchaseInc');
  SetPropertyFromNode(node,'RegionalOptions_TaxCodeSalesInc');
  SetPropertyFromNode(node,'ColumnHeadings_DefaultClass');
  SetPropertyFromNode(node,'ColumnHeadings_DefaultUOM');
  SetPropertyFromNode(node,'Companyinfo_POBox');
  SetPropertyFromNode(node,'Companyinfo_POBox2');
  SetPropertyFromNode(node,'Companyinfo_POBox3');
  SetPropertyFromNode(node,'Companyinfo_POCity');
  SetPropertyFromNode(node,'Companyinfo_POState');
  SetPropertyFromNode(node,'Companyinfo_POPostcode');
  SetPropertyFromNode(node,'Companyinfo_POCountry');
  SetPropertyFromNode(node,'Companyinfo_ABN');
  SetPropertyFromNode(node,'Companyinfo_CompanyName');
  SetPropertyFromNode(node,'Companyinfo_TradingName');
  SetPropertyFromNode(node,'Companyinfo_Address');
  SetPropertyFromNode(node,'Companyinfo_Address2');
  SetPropertyFromNode(node,'Companyinfo_Address3');
  SetPropertyFromNode(node,'Companyinfo_PhoneNumber');
  SetPropertyFromNode(node,'Companyinfo_URL');
  SetPropertyFromNode(node,'ERPVersionStr');
  SetPropertyFromNode(node,'Companyinfo_Email');
  SetDateTimePropertyFromNode(node,'ReportsDate');
  SetDateTimePropertyFromNode(node,'ReportsDateFrom');
  SetDateTimePropertyFromNode(node,'ReportsDateTo');
  SetPropertyFromNode(node,'PnL_TotalIncomeEx');
  SetPropertyFromNode(node,'PnL_TotalIncomeInc');
  SetPropertyFromNode(node,'PnL_TotalExpenseEx');
  SetPropertyFromNode(node,'PnL_TotalExpenseIn');
  SetPropertyFromNode(node,'PnL_TotalCOGSEx');
  SetPropertyFromNode(node,'PnL_TotalCOGSIn');
  SetPropertyFromNode(node,'PnL_NetIncomeEx');
  SetPropertyFromNode(node,'PnL_NetIncomeIn');
end;

procedure TVS1_Dashboard_summary.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'OVERDUE_INVOICES_AMOUNT' ,OVERDUE_INVOICES_AMOUNT);
  AddXMLNode(node,'OVERDUE_INVOICES_QUANTITY' ,OVERDUE_INVOICES_QUANTITY);
  AddXMLNode(node,'ERPVersionNo' ,ERPVersionNo);
  AddXMLNode(node,'OUTSTANDING_PAYABLES_AMOUNT' ,OUTSTANDING_PAYABLES_AMOUNT);
  AddXMLNode(node,'OUTSTANDING_PAYABLES_QUANTITY' ,OUTSTANDING_PAYABLES_QUANTITY);
  AddXMLNode(node,'RegionalOptions_CurrencySymbol' ,RegionalOptions_CurrencySymbol);
  AddXMLNode(node,'RegionalOptions_ForeignExDefault' ,RegionalOptions_ForeignExDefault);
  AddXMLNode(node,'RegionalOptions_TaxCodePurchaseInc' ,RegionalOptions_TaxCodePurchaseInc);
  AddXMLNode(node,'RegionalOptions_TaxCodeSalesInc' ,RegionalOptions_TaxCodeSalesInc);
  AddXMLNode(node,'ColumnHeadings_DefaultClass' ,ColumnHeadings_DefaultClass);
  AddXMLNode(node,'ColumnHeadings_DefaultUOM' ,ColumnHeadings_DefaultUOM);
  AddXMLNode(node,'Companyinfo_POBox' ,Companyinfo_POBox);
  AddXMLNode(node,'Companyinfo_POBox2' ,Companyinfo_POBox2);
  AddXMLNode(node,'Companyinfo_POBox3' ,Companyinfo_POBox3);
  AddXMLNode(node,'Companyinfo_POCity' ,Companyinfo_POCity);
  AddXMLNode(node,'Companyinfo_POState' ,Companyinfo_POState);
  AddXMLNode(node,'Companyinfo_POPostcode' ,Companyinfo_POPostcode);
  AddXMLNode(node,'Companyinfo_POCountry' ,Companyinfo_POCountry);
  AddXMLNode(node,'Companyinfo_ABN' ,Companyinfo_ABN);
  AddXMLNode(node,'Companyinfo_CompanyName' ,Companyinfo_CompanyName);
  AddXMLNode(node,'Companyinfo_TradingName' ,Companyinfo_TradingName);
  AddXMLNode(node,'Companyinfo_Address' ,Companyinfo_Address);
  AddXMLNode(node,'Companyinfo_Address2' ,Companyinfo_Address2);
  AddXMLNode(node,'Companyinfo_Address3' ,Companyinfo_Address3);
  AddXMLNode(node,'Companyinfo_PhoneNumber' ,Companyinfo_PhoneNumber);
  AddXMLNode(node,'Companyinfo_URL' ,Companyinfo_URL);
  AddXMLNode(node,'ERPVersionStr' ,ERPVersionStr);
  AddXMLNode(node,'Companyinfo_Email' ,Companyinfo_Email);
  AddXMLNode(node,'ReportsDate' ,ReportsDate);
  AddXMLNode(node,'ReportsDateFrom' ,ReportsDateFrom);
  AddXMLNode(node,'ReportsDateTo' ,ReportsDateTo);
  AddXMLNode(node,'PnL_TotalIncomeEx' ,PnL_TotalIncomeEx);
  AddXMLNode(node,'PnL_TotalIncomeInc' ,PnL_TotalIncomeInc);
  AddXMLNode(node,'PnL_TotalExpenseEx' ,PnL_TotalExpenseEx);
  AddXMLNode(node,'PnL_TotalExpenseIn' ,PnL_TotalExpenseIn);
  AddXMLNode(node,'PnL_TotalCOGSEx' ,PnL_TotalCOGSEx);
  AddXMLNode(node,'PnL_TotalCOGSIn' ,PnL_TotalCOGSIn);
  AddXMLNode(node,'PnL_NetIncomeEx' ,PnL_NetIncomeEx);
  AddXMLNode(node,'PnL_NetIncomeIn' ,PnL_NetIncomeIn);
end;

function TVS1_Dashboard_summary.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;

function TVS1_Dashboard_summary.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TVS1_Dashboard_summary.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TVS1_Dashboard_summary.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TVS1_Dashboard_summary.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TVS1_Dashboard_summary.GetIDField: string;
begin
  Result := 'ID'
end;

class function TVS1_Dashboard_summary.GetBusObjectTablename: string;
begin
  Result:= 'tmp_vs1_dashboard_summary';
end;

function TVS1_Dashboard_summary.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
function  TVS1_Dashboard_summary.GetERPVersionNo                      : Integer   ; begin Result := GetIntegerField('ERPVersionNo')                     ;end;
function  TVS1_Dashboard_summary.GetOVERDUE_INVOICES_AMOUNT           : Double    ; begin Result := GetFloatField('OVERDUE_INVOICES_AMOUNT')            ;end;
function  TVS1_Dashboard_summary.GetOVERDUE_INVOICES_QUANTITY         : Integer   ; begin Result := GetIntegerField('OVERDUE_INVOICES_QUANTITY')        ;end;
function  TVS1_Dashboard_summary.GetOUTSTANDING_PAYABLES_AMOUNT       : Double    ; begin Result := GetFloatField('OUTSTANDING_PAYABLES_AMOUNT')        ;end;
function  TVS1_Dashboard_summary.GetOUTSTANDING_PAYABLES_QUANTITY     : Integer   ; begin Result := GetIntegerField('OUTSTANDING_PAYABLES_QUANTITY')    ;end;
function  TVS1_Dashboard_summary.GetOVERDUE_PAYABLES_AMOUNT           : Double    ; begin Result := GetFloatField('OVERDUE_PAYABLES_AMOUNT')            ;end;
function  TVS1_Dashboard_summary.GetOVERDUE_PAYABLES_QUANTITY         : Integer   ; begin Result := GetIntegerField('OVERDUE_PAYABLES_QUANTITY')        ;end;
function  TVS1_Dashboard_summary.GetOUTSTANDING_INVOICES_AMOUNT       : Double    ; begin Result := GetFloatField('OUTSTANDING_INVOICES_AMOUNT')        ;end;
function  TVS1_Dashboard_summary.GetOUTSTANDING_INVOICES_QUANTITY     : Integer   ; begin Result := GetIntegerField('OUTSTANDING_INVOICES_QUANTITY')    ;end;
function  TVS1_Dashboard_summary.GetRegionalOptions_CurrencySymbol    : string    ; begin Result := GetStringField('RegionalOptions_CurrencySymbol')    ;end;
function  TVS1_Dashboard_summary.GetRegionalOptions_ForeignExDefault  : string    ; begin Result := GetStringField('RegionalOptions_ForeignExDefault')  ;end;
function  TVS1_Dashboard_summary.GetRegionalOptions_TaxCodePurchaseInc: string    ; begin Result := GetStringField('RegionalOptions_TaxCodePurchaseInc');end;
function  TVS1_Dashboard_summary.GetRegionalOptions_TaxCodeSalesInc   : string    ; begin Result := GetStringField('RegionalOptions_TaxCodeSalesInc')   ;end;
function  TVS1_Dashboard_summary.GetColumnHeadings_DefaultClass       : string    ; begin Result := GetStringField('ColumnHeadings_DefaultClass')       ;end;
function  TVS1_Dashboard_summary.GetColumnHeadings_DefaultUOM         : string    ; begin Result := GetStringField('ColumnHeadings_DefaultUOM')         ;end;
function  TVS1_Dashboard_summary.GetCompanyinfo_POBox                 : string    ; begin Result := GetStringField('Companyinfo_POBox')                 ;end;
function  TVS1_Dashboard_summary.GetCompanyinfo_POBox2                : string    ; begin Result := GetStringField('Companyinfo_POBox2')                ;end;
function  TVS1_Dashboard_summary.GetCompanyinfo_POBox3                : string    ; begin Result := GetStringField('Companyinfo_POBox3')                ;end;
function  TVS1_Dashboard_summary.GetCompanyinfo_POCity                : string    ; begin Result := GetStringField('Companyinfo_POCity')                ;end;
function  TVS1_Dashboard_summary.GetCompanyinfo_POState               : string    ; begin Result := GetStringField('Companyinfo_POState')               ;end;
function  TVS1_Dashboard_summary.GetCompanyinfo_POPostcode            : string    ; begin Result := GetStringField('Companyinfo_POPostcode')            ;end;
function  TVS1_Dashboard_summary.GetCompanyinfo_POCountry             : string    ; begin Result := GetStringField('Companyinfo_POCountry')             ;end;
function  TVS1_Dashboard_summary.GetCompanyinfo_ABN                   : string    ; begin Result := GetStringField('Companyinfo_ABN')                   ;end;
function  TVS1_Dashboard_summary.GetCompanyinfo_CompanyName           : string    ; begin Result := GetStringField('Companyinfo_CompanyName')           ;end;
function  TVS1_Dashboard_summary.GetCompanyinfo_TradingName           : string    ; begin Result := GetStringField('Companyinfo_TradingName')           ;end;
function  TVS1_Dashboard_summary.GetCompanyinfo_Address               : string    ; begin Result := GetStringField('Companyinfo_Address')               ;end;
function  TVS1_Dashboard_summary.GetCompanyinfo_Address2              : string    ; begin Result := GetStringField('Companyinfo_Address2')              ;end;
function  TVS1_Dashboard_summary.GetCompanyinfo_Address3              : string    ; begin Result := GetStringField('Companyinfo_Address3')              ;end;
function  TVS1_Dashboard_summary.GetCompanyinfo_PhoneNumber           : string    ; begin Result := GetStringField('Companyinfo_PhoneNumber')           ;end;
function  TVS1_Dashboard_summary.GetCompanyinfo_URL                   : string    ; begin Result := GetStringField('Companyinfo_URL')                   ;end;
function  TVS1_Dashboard_summary.GetERPVersionStr                     : string    ; begin Result := GetStringField('ERPVersionStr')                     ;end;
function  TVS1_Dashboard_summary.GetCompanyinfo_Email                 : string    ; begin Result := GetStringField('Companyinfo_Email')                 ;end;
function  TVS1_Dashboard_summary.GetCompanyinfo_IsSetupWizard         : Boolean   ; begin Result := GetBooleanField('Companyinfo_IsSetupWizard')        ;end;
function  TVS1_Dashboard_summary.GetReportsDate                       : TDateTime ; begin Result := GetDateTimeField('ReportsDate')                     ;end;
function  TVS1_Dashboard_summary.GetReportsDateFrom                   : TDateTime ; begin Result := GetDateTimeField('ReportsDateFrom')                 ;end;
function  TVS1_Dashboard_summary.GetReportsDateTo                     : TDateTime ; begin Result := GetDateTimeField('ReportsDateTo')                   ;end;
function  TVS1_Dashboard_summary.GetPnL_TotalIncomeEx                 : Double    ; begin Result := GetFloatField('PnL_TotalIncomeEx')                  ;end;
function  TVS1_Dashboard_summary.GetPnL_TotalIncomeInc                : Double    ; begin Result := GetFloatField('PnL_TotalIncomeInc')                 ;end;
function  TVS1_Dashboard_summary.GetPnL_TotalExpenseEx                : Double    ; begin Result := GetFloatField('PnL_TotalExpenseEx')                 ;end;
function  TVS1_Dashboard_summary.GetPnL_TotalExpenseIn                : Double    ; begin Result := GetFloatField('PnL_TotalExpenseIn')                 ;end;
function  TVS1_Dashboard_summary.GetPnL_TotalCOGSEx                   : Double    ; begin Result := GetFloatField('PnL_TotalCOGSEx')                    ;end;
function  TVS1_Dashboard_summary.GetPnL_TotalCOGSIn                   : Double    ; begin Result := GetFloatField('PnL_TotalCOGSIn')                    ;end;
function  TVS1_Dashboard_summary.GetPnL_NetIncomeEx                   : Double    ; begin Result := GetFloatField('PnL_NetIncomeEx')                    ;end;
function  TVS1_Dashboard_summary.GetPnL_NetIncomeIn                   : Double    ; begin Result := GetFloatField('PnL_NetIncomeIn')                    ;end;

procedure TVS1_Dashboard_summary.SetERPVersionNo                      (const Value: Integer   ); begin SetIntegerField('ERPVersionNo'                      , Value);end;
procedure TVS1_Dashboard_summary.SetOVERDUE_INVOICES_AMOUNT           (const Value: Double    ); begin SetFloatField('OVERDUE_INVOICES_AMOUNT'             , Value);end;
procedure TVS1_Dashboard_summary.SetOVERDUE_INVOICES_QUANTITY         (const Value: Integer   ); begin SetIntegerField('OVERDUE_INVOICES_QUANTITY'         , Value);end;
procedure TVS1_Dashboard_summary.SetOUTSTANDING_PAYABLES_AMOUNT       (const Value: Double    ); begin SetFloatField('OUTSTANDING_PAYABLES_AMOUNT'         , Value);end;
procedure TVS1_Dashboard_summary.SetOUTSTANDING_PAYABLES_QUANTITY     (const Value: Integer   ); begin SetIntegerField('OUTSTANDING_PAYABLES_QUANTITY'     , Value);end;
procedure TVS1_Dashboard_summary.SetOVERDUE_PAYABLES_AMOUNT           (const Value: Double    ); begin SetFloatField('OVERDUE_PAYABLES_AMOUNT'             , Value);end;
procedure TVS1_Dashboard_summary.SetOVERDUE_PAYABLES_QUANTITY         (const Value: Integer   ); begin SetIntegerField('OVERDUE_PAYABLES_QUANTITY'         , Value);end;
procedure TVS1_Dashboard_summary.SetOUTSTANDING_INVOICES_AMOUNT       (const Value: Double    ); begin SetFloatField('OUTSTANDING_INVOICES_AMOUNT'         , Value);end;
procedure TVS1_Dashboard_summary.SetOUTSTANDING_INVOICES_QUANTITY     (const Value: Integer   ); begin SetIntegerField('OUTSTANDING_INVOICES_QUANTITY'     , Value);end;
procedure TVS1_Dashboard_summary.SetRegionalOptions_CurrencySymbol    (const Value: string    ); begin SetStringField('RegionalOptions_CurrencySymbol'     , Value);end;
procedure TVS1_Dashboard_summary.SetRegionalOptions_ForeignExDefault  (const Value: string    ); begin SetStringField('RegionalOptions_ForeignExDefault'   , Value);end;
procedure TVS1_Dashboard_summary.SetRegionalOptions_TaxCodePurchaseInc(const Value: string    ); begin SetStringField('RegionalOptions_TaxCodePurchaseInc' , Value);end;
procedure TVS1_Dashboard_summary.SetRegionalOptions_TaxCodeSalesInc   (const Value: string    ); begin SetStringField('RegionalOptions_TaxCodeSalesInc'    , Value);end;
procedure TVS1_Dashboard_summary.SetColumnHeadings_DefaultClass       (const Value: string    ); begin SetStringField('ColumnHeadings_DefaultClass'        , Value);end;
procedure TVS1_Dashboard_summary.SetColumnHeadings_DefaultUOM         (const Value: string    ); begin SetStringField('ColumnHeadings_DefaultUOM'          , Value);end;
procedure TVS1_Dashboard_summary.SetCompanyinfo_POBox                 (const Value: string    ); begin SetStringField('Companyinfo_POBox'                  , Value);end;
procedure TVS1_Dashboard_summary.SetCompanyinfo_POBox2                (const Value: string    ); begin SetStringField('Companyinfo_POBox2'                 , Value);end;
procedure TVS1_Dashboard_summary.SetCompanyinfo_POBox3                (const Value: string    ); begin SetStringField('Companyinfo_POBox3'                 , Value);end;
procedure TVS1_Dashboard_summary.SetCompanyinfo_POCity                (const Value: string    ); begin SetStringField('Companyinfo_POCity'                 , Value);end;
procedure TVS1_Dashboard_summary.SetCompanyinfo_POState               (const Value: string    ); begin SetStringField('Companyinfo_POState'                , Value);end;
procedure TVS1_Dashboard_summary.SetCompanyinfo_POPostcode            (const Value: string    ); begin SetStringField('Companyinfo_POPostcode'             , Value);end;
procedure TVS1_Dashboard_summary.SetCompanyinfo_POCountry             (const Value: string    ); begin SetStringField('Companyinfo_POCountry'              , Value);end;
procedure TVS1_Dashboard_summary.SetCompanyinfo_ABN                   (const Value: string    ); begin SetStringField('Companyinfo_ABN'                    , Value);end;
procedure TVS1_Dashboard_summary.SetCompanyinfo_CompanyName           (const Value: string    ); begin SetStringField('Companyinfo_CompanyName'            , Value);end;
procedure TVS1_Dashboard_summary.SetCompanyinfo_TradingName           (const Value: string    ); begin SetStringField('Companyinfo_TradingName'            , Value);end;
procedure TVS1_Dashboard_summary.SetCompanyinfo_Address               (const Value: string    ); begin SetStringField('Companyinfo_Address'                , Value);end;
procedure TVS1_Dashboard_summary.SetCompanyinfo_Address2              (const Value: string    ); begin SetStringField('Companyinfo_Address2'               , Value);end;
procedure TVS1_Dashboard_summary.SetCompanyinfo_Address3              (const Value: string    ); begin SetStringField('Companyinfo_Address3'               , Value);end;
procedure TVS1_Dashboard_summary.SetCompanyinfo_PhoneNumber           (const Value: string    ); begin SetStringField('Companyinfo_PhoneNumber'            , Value);end;
procedure TVS1_Dashboard_summary.SetCompanyinfo_URL                   (const Value: string    ); begin SetStringField('Companyinfo_URL'                    , Value);end;
procedure TVS1_Dashboard_summary.SetERPVersionStr                     (const Value: string    ); begin SetStringField('ERPVersionStr'                      , Value);end;
procedure TVS1_Dashboard_summary.SetCompanyinfo_Email                 (const Value: string    ); begin SetStringField('Companyinfo_Email'                  , Value);end;
procedure TVS1_Dashboard_summary.SetCompanyinfo_IsSetupWizard         (const Value: Boolean   ); begin SetBooleanField('Companyinfo_IsSetupWizard'         , Value);end;
procedure TVS1_Dashboard_summary.SetReportsDate                       (const Value: TDateTime ); begin SetDateTimeField('ReportsDate'                      , Value);end;
procedure TVS1_Dashboard_summary.SetReportsDateFrom                   (const Value: TDateTime ); begin SetDateTimeField('ReportsDateFrom'                  , Value);end;
procedure TVS1_Dashboard_summary.SetReportsDateTo                     (const Value: TDateTime ); begin SetDateTimeField('ReportsDateTo'                    , Value);end;
procedure TVS1_Dashboard_summary.SetPnL_TotalIncomeEx                 (const Value: Double    ); begin SetFloatField('PnL_TotalIncomeEx'                   , Value);end;
procedure TVS1_Dashboard_summary.SetPnL_TotalIncomeInc                (const Value: Double    ); begin SetFloatField('PnL_TotalIncomeInc'                  , Value);end;
procedure TVS1_Dashboard_summary.SetPnL_TotalExpenseEx                (const Value: Double    ); begin SetFloatField('PnL_TotalExpenseEx'                  , Value);end;
procedure TVS1_Dashboard_summary.SetPnL_TotalExpenseIn                (const Value: Double    ); begin SetFloatField('PnL_TotalExpenseIn'                  , Value);end;
procedure TVS1_Dashboard_summary.SetPnL_TotalCOGSEx                   (const Value: Double    ); begin SetFloatField('PnL_TotalCOGSEx'                     , Value);end;
procedure TVS1_Dashboard_summary.SetPnL_TotalCOGSIn                   (const Value: Double    ); begin SetFloatField('PnL_TotalCOGSIn'                     , Value);end;
procedure TVS1_Dashboard_summary.SetPnL_NetIncomeEx                   (const Value: Double    ); begin SetFloatField('PnL_NetIncomeEx'                     , Value);end;
procedure TVS1_Dashboard_summary.SetPnL_NetIncomeIn                   (const Value: Double    ); begin SetFloatField('PnL_NetIncomeIn'                     , Value);end;


  {TVS1_Dashboard_salesperemployee}

constructor TVS1_Dashboard_salesperemployee.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1_dashboard_salesperemployee';
  fSQL := 'SELECT * FROM tmp_vs1_dashboard_salesperemployee';
end;

destructor TVS1_Dashboard_salesperemployee.Destroy;
begin
  inherited;
end;

procedure TVS1_Dashboard_salesperemployee.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'employeename');
  SetPropertyFromNode(node,'Totalsales');
  SetPropertyFromNode(node,'invoicetotal');
  SetPropertyFromNode(node,'quotetotal');
end;

procedure TVS1_Dashboard_salesperemployee.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'employeename' ,employeename);
  AddXMLNode(node,'Totalsales' ,Totalsales);
  AddXMLNode(node,'invoicetotal' ,invoicetotal);
  AddXMLNode(node,'quotetotal' ,quotetotal);
end;

function TVS1_Dashboard_salesperemployee.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;

function TVS1_Dashboard_salesperemployee.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TVS1_Dashboard_salesperemployee.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TVS1_Dashboard_salesperemployee.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TVS1_Dashboard_salesperemployee.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TVS1_Dashboard_salesperemployee.GetIDField: string;
begin
  Result := 'ID'
end;

class function TVS1_Dashboard_salesperemployee.GetBusObjectTablename: string;
begin
  Result:= 'tmp_vs1_dashboard_salesperemployee';
end;

function TVS1_Dashboard_salesperemployee.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
function  TVS1_Dashboard_salesperemployee.GetEmployeeID        : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TVS1_Dashboard_salesperemployee.Getemployeename      : string    ; begin Result := GetStringField('employeename');end;
function  TVS1_Dashboard_salesperemployee.GetTotalsales        : Double    ; begin Result := GetFloatField('Totalsales');end;
function  TVS1_Dashboard_salesperemployee.Getinvoicetotal      : Double    ; begin Result := GetFloatField('invoicetotal');end;
function  TVS1_Dashboard_salesperemployee.Getquotetotal        : Double    ; begin Result := GetFloatField('quotetotal');end;
procedure TVS1_Dashboard_salesperemployee.SetEmployeeID        (const Value: Integer   ); begin SetIntegerField('EmployeeID'         , Value);end;
procedure TVS1_Dashboard_salesperemployee.Setemployeename      (const Value: string    ); begin SetStringField('employeename'       , Value);end;
procedure TVS1_Dashboard_salesperemployee.SetTotalsales        (const Value: Double    ); begin SetFloatField('Totalsales'         , Value);end;
procedure TVS1_Dashboard_salesperemployee.Setinvoicetotal      (const Value: Double    ); begin SetFloatField('invoicetotal'       , Value);end;
procedure TVS1_Dashboard_salesperemployee.Setquotetotal        (const Value: Double    ); begin SetFloatField('quotetotal'         , Value);end;


  {TVS1_Dashboard_saleslist}

constructor TVS1_Dashboard_saleslist.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1_dashboard_saleslist';
  fSQL := 'SELECT * FROM tmp_vs1_dashboard_saleslist';
end;

destructor TVS1_Dashboard_saleslist.Destroy;
begin
  inherited;
end;

procedure TVS1_Dashboard_saleslist.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node,'Datefrom');
  SetDateTimePropertyFromNode(node,'dateto');
  SetPropertyFromNode(node,'month1');
  SetPropertyFromNode(node,'MONTH2');
  SetPropertyFromNode(node,'MONTH3');
  SetPropertyFromNode(node,'invoicetotal');
  SetPropertyFromNode(node,'quotetotal');
end;

procedure TVS1_Dashboard_saleslist.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Datefrom' ,Datefrom);
  AddXMLNode(node,'dateto' ,dateto);
  AddXMLNode(node,'month1' ,month1);
  AddXMLNode(node,'MONTH2' ,MONTH2);
  AddXMLNode(node,'MONTH3' ,MONTH3);
  AddXMLNode(node,'invoicetotal' ,invoicetotal);
  AddXMLNode(node,'quotetotal' ,quotetotal);
end;

function TVS1_Dashboard_saleslist.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;

function TVS1_Dashboard_saleslist.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TVS1_Dashboard_saleslist.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TVS1_Dashboard_saleslist.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TVS1_Dashboard_saleslist.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TVS1_Dashboard_saleslist.GetIDField: string;
begin
  Result := 'ID'
end;

class function TVS1_Dashboard_saleslist.GetBusObjectTablename: string;
begin
  Result:= 'tmp_vs1_dashboard_saleslist';
end;

function TVS1_Dashboard_saleslist.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
function  TVS1_Dashboard_saleslist.GetDatefrom          : TDateTime ; begin Result := GetDateTimeField('Datefrom');end;
function  TVS1_Dashboard_saleslist.Getdateto            : TDateTime ; begin Result := GetDateTimeField('dateto');end;
function  TVS1_Dashboard_saleslist.Getmonth1            : string    ; begin Result := GetStringField('month1');end;
function  TVS1_Dashboard_saleslist.GetMONTH2            : string    ; begin Result := GetStringField('MONTH2');end;
function  TVS1_Dashboard_saleslist.GetMONTH3            : string    ; begin Result := GetStringField('MONTH3');end;
function  TVS1_Dashboard_saleslist.Getinvoicetotal      : Double    ; begin Result := GetFloatField('invoicetotal');end;
function  TVS1_Dashboard_saleslist.Getquotetotal        : Double    ; begin Result := GetFloatField('quotetotal');end;
procedure TVS1_Dashboard_saleslist.SetDatefrom          (const Value: TDateTime ); begin SetDateTimeField('Datefrom'           , Value);end;
procedure TVS1_Dashboard_saleslist.Setdateto            (const Value: TDateTime ); begin SetDateTimeField('dateto'             , Value);end;
procedure TVS1_Dashboard_saleslist.Setmonth1            (const Value: string    ); begin SetStringField('month1'             , Value);end;
procedure TVS1_Dashboard_saleslist.SetMONTH2            (const Value: string    ); begin SetStringField('MONTH2'             , Value);end;
procedure TVS1_Dashboard_saleslist.SetMONTH3            (const Value: string    ); begin SetStringField('MONTH3'             , Value);end;
procedure TVS1_Dashboard_saleslist.Setinvoicetotal      (const Value: Double    ); begin SetFloatField('invoicetotal'       , Value);end;
procedure TVS1_Dashboard_saleslist.Setquotetotal        (const Value: Double    ); begin SetFloatField('quotetotal'         , Value);end;

  {TVS1_Dashboard_pnl}

constructor TVS1_Dashboard_pnl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1_dashboard_pnl';
  fSQL := 'SELECT * FROM tmp_vs1_dashboard_pnl';
end;

destructor TVS1_Dashboard_pnl.Destroy;
begin
  inherited;
end;

procedure TVS1_Dashboard_pnl.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'SeqNo');
  SetBooleanPropertyFromNode(node, 'IsRoot');
  SetPropertyFromNode(node, 'AccountID');
  SetPropertyFromNode(node, 'AccountNo');
  SetPropertyFromNode(node, 'AccountName');
  SetPropertyFromNode(node, 'AccountType');
  SetPropertyFromNode(node, 'AccountTypeDesc');
  SetPropertyFromNode(node, 'FinalOrder');
  SetPropertyFromNode(node,'AccountHeaderOrder');
  SetPropertyFromNode(node, 'AccountSub1Order');
  SetPropertyFromNode(node, 'AccountSub2Order');
  SetPropertyFromNode(node, 'AccountSub3Order');
  SetPropertyFromNode(node, 'TotalAmountInc');
  SetPropertyFromNode(node, 'TotalAmountEx');
  SetPropertyFromNode(node, 'SubTotalInc');
  SetPropertyFromNode(node, 'SubTotalEx');
  SetPropertyFromNode(node, 'HeaderOfficeInc');
  SetPropertyFromNode(node, 'HeaderOfficeEx');
  SetBooleanPropertyFromNode(node, 'HideTotal');
  SetPropertyFromNode(node, 'Level1');
  SetPropertyFromNode(node, 'Level2');
  SetPropertyFromNode(node,'Level3');
  SetPropertyFromNode(node,'Level4');
  SetPropertyFromNode(node,'Level5');
end;

procedure TVS1_Dashboard_pnl.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SeqNo', SeqNo);
  AddXMLNode(node,'IsRoot', IsRoot);
  AddXMLNode(node,'AccountID', AccountID);
  AddXMLNode(node,'AccountNo', AccountNo);
  AddXMLNode(node,'AccounName', AccountName);
  AddXMLNode(node,'AccountType', AccountType);
  AddXMLNode(node,'AccountTypeDesc', AccountTypeDesc);
  AddXMLNode(node,'FinalOrder', FinalOrder);
  AddXMLNode(node,'AccountHeaderOrder', AccountHeaderOrder);
  AddXMLNode(node,'AccountSub1Order', AccountSub1Order);
  AddXMLNode(node,'AccountSub2Order', AccountSub2Order);
  AddXMLNode(node,'AccountSub3Order', AccountSub3Order);
  AddXMLNode(node,'TotalAmountInc', TotalAmountInc);
  AddXMLNode(node,'TotalAmountEx', TotalAmountEx);
  AddXMLNode(node,'SubTotalInc', SubTotalInc);
  AddXMLNode(node,'SubTotalEx', SubTotalEx);
  AddXMLNode(node,'HeaderOfficeInc', HeadOfficeInc);
  AddXMLNode(node,'HeaderOfficeEx', HeadOfficeInc);
  AddXMLNode(node,'HideTotal', HideTotal);
  AddXMLNode(node,'Level1', Level1);
  AddXMLNode(node,'Level2', Level2);
  AddXMLNode(node,'Level3', Level3);
  AddXMLNode(node,'Level4', Level4);
  AddXMLNode(node,'Level5', Level5);
end;

function TVS1_Dashboard_pnl.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;

function TVS1_Dashboard_pnl.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TVS1_Dashboard_pnl.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TVS1_Dashboard_pnl.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TVS1_Dashboard_pnl.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TVS1_Dashboard_pnl.GetIDField: string;
begin
  Result := 'seqno'
end;

class function TVS1_Dashboard_pnl.GetBusObjectTablename: string;
begin
  Result:= 'tmp_vs1_dashboard_pnl';
end;


function TVS1_Dashboard_pnl.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function  TVS1_Dashboard_pnl.GetSeqNo:                Integer;  begin Result := GetIntegerField('seqno');               end;
function  TVS1_Dashboard_pnl.GetIsRoot:               Boolean;  begin Result := GetBooleanField('IsRoot');               end;
function  TVS1_Dashboard_pnl.GetAccountID:            Integer;  begin Result := GetIntegerField('AccountID');               end;
function  TVS1_Dashboard_pnl.GetAccountNo:            String;   begin Result := GetStringField('AccountNo');                end;
function  TVS1_Dashboard_pnl.GetAccountName:          String;   begin Result := GetStringField('AccountName');                end;
function  TVS1_Dashboard_pnl.GetAccountType:          String;   begin Result := GetStringField('AccountType');                end;
function  TVS1_Dashboard_pnl.GetAccountTypeDesc:      String;   begin Result := GetStringField('AccountTypeDesc');                end;
function  TVS1_Dashboard_pnl.GetFinalOrder:           Integer;  begin Result := GetIntegerField('FinalOrder');          end;
function  TVS1_Dashboard_pnl.GetAccountHeaderOrder:   String;   begin Result := GetStringField('AccountHeaderOrder');  end;
function  TVS1_Dashboard_pnl.GetAccountSub1Order:     String;   begin Result := GetStringField('AccountSub1Order');     end;
function  TVS1_Dashboard_pnl.GetAccountSub2Order:     String;   begin Result := GetStringField('AccountSub2Order');     end;
function  TVS1_Dashboard_pnl.GetAccountSub3Order:     String;   begin Result := GetStringField('AccountSub3Order');     end;
function  TVS1_Dashboard_pnl.GetTotalAmountInc:       Double;   begin Result := GetFloatField('TotalAmountInc');        end;
function  TVS1_Dashboard_pnl.GetTotalAmountEx:        Double;   begin Result := GetFloatField('TotalAmountEx');         end;
function  TVS1_Dashboard_pnl.GetSubTotalInc:          Double;   begin Result := GetFloatField('SubTotalInc');           end;
function  TVS1_Dashboard_pnl.GetSubTotalEx:           Double;   begin Result := GetFloatField('SubTotalEx');            end;
function  TVS1_Dashboard_pnl.GetHeadOfficeInc:        Double;   begin Result := GetFloatField('HeadOfficInc');           end;
function  TVS1_Dashboard_pnl.GetHeadOfficeEx:         Double;   begin Result := GetFloatField('HeadOfficEx');            end;
function  TVS1_Dashboard_pnl.GetHideTotal:            Boolean;  begin Result := GetBooleanField('HideTotal');           end;
function  TVS1_Dashboard_pnl.GetLevel1:               String;   begin Result := GetStringField('Level1');               end;
function  TVS1_Dashboard_pnl.GetLevel2:               String;   begin Result := GetStringField('Level2');               end;
function  TVS1_Dashboard_pnl.GetLevel3:               String;   begin Result := GetStringField('Level3');               end;
function  TVS1_Dashboard_pnl.GetLevel4:               String;   begin Result := GetStringField('Level4');               end;
function  TVS1_Dashboard_pnl.GetLevel5:               String;   begin Result := GetStringField('Level5');               end;

procedure  TVS1_Dashboard_pnl.SetSeqNo                (const Value: Integer);  begin SetIntegerField('seqno', Value);               end;
procedure  TVS1_Dashboard_pnl.SetIsRoot               (const Value: Boolean);  begin SetBooleanField('IsRoot', Value);              end;
procedure  TVS1_Dashboard_pnl.SetAccountID            (const Value: Integer);  begin SetIntegerField('AccountID', Value);           end;
procedure  TVS1_Dashboard_pnl.SetAccountNo            (const Value: String);   begin SetStringField('AccountNo', Value);            end;
procedure  TVS1_Dashboard_pnl.SetAccountName          (const Value: String);   begin SetStringField('AccountName', Value);          end;
procedure  TVS1_Dashboard_pnl.SetAccountType          (const Value: String);   begin SetStringField('AccountType', Value);          end;
procedure  TVS1_Dashboard_pnl.SetAccountTypeDesc      (const Value: String);   begin SetStringField('AccountTypeDesc', Value);      end;
procedure  TVS1_Dashboard_pnl.SetFinalOrder           (const Value: Integer);  begin SetIntegerField('FinalOrder', Value);          end;
procedure  TVS1_Dashboard_pnl.SetAccountHeaderOrder   (const Value: String);   begin SetStringField('AccountHeaderOrder', Value);  end;
procedure  TVS1_Dashboard_pnl.SetAccountSub1Order     (const Value: String);   begin SetStringField('AccountSub1Order', Value);     end;
procedure  TVS1_Dashboard_pnl.SetAccountSub2Order     (const Value: String);   begin SetStringField('AccountSub2Order', Value);     end;
procedure  TVS1_Dashboard_pnl.SetAccountSub3Order     (const Value: String);   begin SetStringField('AccountSub3Order', Value);     end;
procedure  TVS1_Dashboard_pnl.SetTotalAmountInc       (const Value: Double);   begin SetFloatField('TotalAmountInc', Value);        end;
procedure  TVS1_Dashboard_pnl.SetTotalAmountEx        (const Value: Double);   begin SetFloatField('TotalAmountEx', Value);         end;
procedure  TVS1_Dashboard_pnl.SetSubTotalInc          (const Value: Double);   begin SetFloatField('SubTotalInc', Value);           end;
procedure  TVS1_Dashboard_pnl.SetSubTotalEx           (const Value: Double);   begin SetFloatField('SubTotalEx', Value);            end;
procedure  TVS1_Dashboard_pnl.SetHeadOfficeInc        (const Value: Double);   begin SetFloatField('HeadOfficeInc', Value);           end;
procedure  TVS1_Dashboard_pnl.SetHeadOfficeEx         (const Value: Double);   begin SetFloatField('HeadOfficeEx', Value);            end;
procedure  TVS1_Dashboard_pnl.SetHideTotal            (const Value: Boolean);  begin SetBooleanField('HideTotal', Value);           end;
procedure  TVS1_Dashboard_pnl.SetLevel1               (const Value: String);   begin SetStringField('Level1', Value);               end;
procedure  TVS1_Dashboard_pnl.SetLevel2               (const Value: String);   begin SetStringField('Level2', Value);               end;
procedure  TVS1_Dashboard_pnl.SetLevel3               (const Value: String);   begin SetStringField('Level3', Value);               end;
procedure  TVS1_Dashboard_pnl.SetLevel4               (const Value: String);   begin SetStringField('Level4', Value);               end;
procedure  TVS1_Dashboard_pnl.SetLevel5               (const Value: String);   begin SetStringField('Level5', Value);               end;


  {TVS1_Dashboard_pnl_period}

constructor TVS1_Dashboard_pnl_period.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1_dashboard_pnl_period';
  fSQL := 'SELECT * FROM tmp_vs1_dashboard_pnl_period';
end;

destructor TVS1_Dashboard_pnl_period.Destroy;
begin
  inherited;
end;

procedure TVS1_Dashboard_pnl_period.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node,'DateFrom_1');
  SetDateTimePropertyFromNode(node,'DateTo_1');
  SetPropertyFromNode(node,'DateDesc_1');
  SetDateTimePropertyFromNode(node,'DateFrom_2');
  SetDateTimePropertyFromNode(node,'DateTo_2');
  SetPropertyFromNode(node,'DateDesc_2');
  SetDateTimePropertyFromNode(node,'DateFrom_3');
  SetDateTimePropertyFromNode(node,'DateTo_3');
  SetPropertyFromNode(node,'DateDesc_3');
  SetDateTimePropertyFromNode(node,'DateFrom_4');
  SetDateTimePropertyFromNode(node,'DateTo_4');
  SetPropertyFromNode(node,'DateDesc_4');
  SetDateTimePropertyFromNode(node,'DateFrom_5');
  SetDateTimePropertyFromNode(node,'DateTo_5');
  SetPropertyFromNode(node,'DateDesc_5');
  SetDateTimePropertyFromNode(node,'DateFrom_6');
  SetDateTimePropertyFromNode(node,'DateTo_6');
  SetPropertyFromNode(node,'DateDesc_6');
  SetDateTimePropertyFromNode(node,'DateFrom_7');
  SetDateTimePropertyFromNode(node,'DateTo_7');
  SetPropertyFromNode(node,'DateDesc_7');
(*  SetDateTimePropertyFromNode(node,'DateFrom_8');
  SetDateTimePropertyFromNode(node,'DateTo_8');
  SetPropertyFromNode(node,'DateDesc_8');*)
  SetBooleanPropertyFromNode(node,'HidePercentage');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'AccountType');
  SetPropertyFromNode(node,'AccountTypeDesc');
  SetPropertyFromNode(node,'AccountName');
  SetPropertyFromNode(node,'Amount_1');
  SetPropertyFromNode(node,'Percentage_1');
  SetPropertyFromNode(node,'Amount_2');
  SetPropertyFromNode(node,'Percentage_2');
  SetPropertyFromNode(node,'Change_2');
  SetPropertyFromNode(node,'ChangePercent_2');
  SetPropertyFromNode(node,'Amount_3');
  SetPropertyFromNode(node,'Percentage_3');
  SetPropertyFromNode(node,'Change_3');
  SetPropertyFromNode(node,'ChangePercent_3');
  SetPropertyFromNode(node,'Amount_4');
  SetPropertyFromNode(node,'Percentage_4');
  SetPropertyFromNode(node,'Change_4');
  SetPropertyFromNode(node,'ChangePercent_4');
  SetPropertyFromNode(node,'Amount_5');
  SetPropertyFromNode(node,'Percentage_5');
  SetPropertyFromNode(node,'Change_5');
  SetPropertyFromNode(node,'ChangePercent_5');
  SetPropertyFromNode(node,'Amount_6');
  SetPropertyFromNode(node,'Percentage_6');
  SetPropertyFromNode(node,'Change_6');
  SetPropertyFromNode(node,'ChangePercent_6');
  SetPropertyFromNode(node,'Amount_7');
  SetPropertyFromNode(node,'Percentage_7');
  SetPropertyFromNode(node,'Change_7');
  SetPropertyFromNode(node,'ChangePercent_7');
(*  SetPropertyFromNode(node,'Amount_8');
  SetPropertyFromNode(node,'Percentage_8');
  SetPropertyFromNode(node,'Change_8');
  SetPropertyFromNode(node,'ChangePercent_8');
  SetPropertyFromNode(node,'Amount_9');
  SetPropertyFromNode(node,'Percentage_9');
  SetPropertyFromNode(node,'Amount_10');
  SetPropertyFromNode(node,'Percentage_10');
  SetPropertyFromNode(node,'Amount_11');
  SetPropertyFromNode(node,'Percentage_11');
  SetPropertyFromNode(node,'Amount_12');
  SetPropertyFromNode(node,'Percentage_12');
  SetPropertyFromNode(node,'Amount_13');
  SetPropertyFromNode(node,'Percentage_13');
  SetPropertyFromNode(node,'Amount_14');
  SetPropertyFromNode(node,'Percentage_14');
  SetPropertyFromNode(node,'Amount_15');
  SetPropertyFromNode(node,'Percentage_15');
  SetPropertyFromNode(node,'Amount_16');
  SetPropertyFromNode(node,'Percentage_16');
  SetPropertyFromNode(node,'Amount_17');
  SetPropertyFromNode(node,'Percentage_17');
  SetPropertyFromNode(node,'Amount_18');
  SetPropertyFromNode(node,'Percentage_18');
  SetPropertyFromNode(node,'Amount_19');
  SetPropertyFromNode(node,'Percentage_19');
  SetPropertyFromNode(node,'Amount_20');
  SetPropertyFromNode(node,'Percentage_20');*)
  SetPropertyFromNode(node,'TotalAmount');
  SetPropertyFromNode(node,'FinalOrder');
  SetPropertyFromNode(node,'AccountHeaderOrder');
  SetPropertyFromNode(node,'AccountSub1Order');
  SetPropertyFromNode(node,'AccountSub2Order');
  SetPropertyFromNode(node,'AccountSub3Order');
  SetBooleanPropertyFromNode(node,'HideTotal');
end;

procedure TVS1_Dashboard_pnl_period.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DateFrom_1' ,DateFrom_1);
  AddXMLNode(node,'DateTo_1' ,DateTo_1);
  AddXMLNode(node,'DateDesc_1' ,DateDesc_1);
  AddXMLNode(node,'DateFrom_2' ,DateFrom_2);
  AddXMLNode(node,'DateTo_2' ,DateTo_2);
  AddXMLNode(node,'DateDesc_2' ,DateDesc_2);
  AddXMLNode(node,'DateFrom_3' ,DateFrom_3);
  AddXMLNode(node,'DateTo_3' ,DateTo_3);
  AddXMLNode(node,'DateDesc_3' ,DateDesc_3);
  AddXMLNode(node,'DateFrom_4' ,DateFrom_4);
  AddXMLNode(node,'DateTo_4' ,DateTo_4);
  AddXMLNode(node,'DateDesc_4' ,DateDesc_4);
  AddXMLNode(node,'DateFrom_5' ,DateFrom_5);
  AddXMLNode(node,'DateTo_5' ,DateTo_5);
  AddXMLNode(node,'DateDesc_5' ,DateDesc_5);
  AddXMLNode(node,'DateFrom_6' ,DateFrom_6);
  AddXMLNode(node,'DateTo_6' ,DateTo_6);
  AddXMLNode(node,'DateDesc_6' ,DateDesc_6);
  AddXMLNode(node,'DateFrom_7' ,DateFrom_7);
  AddXMLNode(node,'DateTo_7' ,DateTo_7);
  AddXMLNode(node,'DateDesc_7' ,DateDesc_7);
(*  AddXMLNode(node,'DateFrom_8' ,DateFrom_8);
  AddXMLNode(node,'DateTo_8' ,DateTo_8);
  AddXMLNode(node,'DateDesc_8' ,DateDesc_8);*)
  AddXMLNode(node,'HidePercentage' ,HidePercentage);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'AccountType' ,AccountType);
  AddXMLNode(node,'AccountTypeDesc' ,AccountTypeDesc);
  AddXMLNode(node,'AccountName' ,AccountName);
  AddXMLNode(node,'Amount_1' ,Amount_1);
  AddXMLNode(node,'Percentage_1' ,Percentage_1);
  AddXMLNode(node,'Amount_2' ,Amount_2);
  AddXMLNode(node,'Percentage_2' ,Percentage_2);
  AddXMLNode(node,'Change_2' ,Change_2);
  AddXMLNode(node,'ChangePercent_2' ,ChangePercent_2);
  AddXMLNode(node,'Amount_3' ,Amount_3);
  AddXMLNode(node,'Percentage_3' ,Percentage_3);
  AddXMLNode(node,'Change_3' ,Change_3);
  AddXMLNode(node,'ChangePercent_3' ,ChangePercent_3);
  AddXMLNode(node,'Amount_4' ,Amount_4);
  AddXMLNode(node,'Percentage_4' ,Percentage_4);
  AddXMLNode(node,'Change_4' ,Change_4);
  AddXMLNode(node,'ChangePercent_4' ,ChangePercent_4);
  AddXMLNode(node,'Amount_5' ,Amount_5);
  AddXMLNode(node,'Percentage_5' ,Percentage_5);
  AddXMLNode(node,'Change_5' ,Change_5);
  AddXMLNode(node,'ChangePercent_5' ,ChangePercent_5);
  AddXMLNode(node,'Amount_6' ,Amount_6);
  AddXMLNode(node,'Percentage_6' ,Percentage_6);
  AddXMLNode(node,'Change_6' ,Change_6);
  AddXMLNode(node,'ChangePercent_6' ,ChangePercent_6);
  AddXMLNode(node,'Amount_7' ,Amount_7);
  AddXMLNode(node,'Percentage_7' ,Percentage_7);
  AddXMLNode(node,'Change_7' ,Change_7);
  AddXMLNode(node,'ChangePercent_7' ,ChangePercent_7);
(*  AddXMLNode(node,'Amount_8' ,Amount_8);
  AddXMLNode(node,'Percentage_8' ,Percentage_8);
  AddXMLNode(node,'Change_8' ,Change_8);
  AddXMLNode(node,'ChangePercent_8' ,ChangePercent_8);
  AddXMLNode(node,'Amount_9' ,Amount_9);
  AddXMLNode(node,'Percentage_9' ,Percentage_9);
  AddXMLNode(node,'Amount_10' ,Amount_10);
  AddXMLNode(node,'Percentage_10' ,Percentage_10);
  AddXMLNode(node,'Amount_11' ,Amount_11);
  AddXMLNode(node,'Percentage_11' ,Percentage_11);
  AddXMLNode(node,'Amount_12' ,Amount_12);
  AddXMLNode(node,'Percentage_12' ,Percentage_12);
  AddXMLNode(node,'Amount_13' ,Amount_13);
  AddXMLNode(node,'Percentage_13' ,Percentage_13);
  AddXMLNode(node,'Amount_14' ,Amount_14);
  AddXMLNode(node,'Percentage_14' ,Percentage_14);
  AddXMLNode(node,'Amount_15' ,Amount_15);
  AddXMLNode(node,'Percentage_15' ,Percentage_15);
  AddXMLNode(node,'Amount_16' ,Amount_16);
  AddXMLNode(node,'Percentage_16' ,Percentage_16);
  AddXMLNode(node,'Amount_17' ,Amount_17);
  AddXMLNode(node,'Percentage_17' ,Percentage_17);
  AddXMLNode(node,'Amount_18' ,Amount_18);
  AddXMLNode(node,'Percentage_18' ,Percentage_18);
  AddXMLNode(node,'Amount_19' ,Amount_19);
  AddXMLNode(node,'Percentage_19' ,Percentage_19);
  AddXMLNode(node,'Amount_20' ,Amount_20);
  AddXMLNode(node,'Percentage_20' ,Percentage_20);*)
  AddXMLNode(node,'TotalAmount' ,TotalAmount);
  AddXMLNode(node,'FinalOrder' ,FinalOrder);
  AddXMLNode(node,'AccountHeaderOrder' ,AccountHeaderOrder);
  AddXMLNode(node,'AccountSub1Order' ,AccountSub1Order);
  AddXMLNode(node,'AccountSub2Order' ,AccountSub2Order);
  AddXMLNode(node,'AccountSub3Order' ,AccountSub3Order);
  AddXMLNode(node,'HideTotal' ,HideTotal);
end;

function TVS1_Dashboard_pnl_period.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;

function TVS1_Dashboard_pnl_period.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TVS1_Dashboard_pnl_period.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TVS1_Dashboard_pnl_period.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TVS1_Dashboard_pnl_period.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TVS1_Dashboard_pnl_period.GetIDField: string;
begin
  Result := 'ID'
end;

class function TVS1_Dashboard_pnl_period.GetBusObjectTablename: string;
begin
  Result:= 'tmp_vs1_dashboard_pnl_period';
end;


function TVS1_Dashboard_pnl_period.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
function  TVS1_Dashboard_pnl_period.GetDateFrom_1        : TDateTime ; begin Result := GetDateTimeField('DateFrom_1');end;
function  TVS1_Dashboard_pnl_period.GetDateTo_1          : TDateTime ; begin Result := GetDateTimeField('DateTo_1');end;
function  TVS1_Dashboard_pnl_period.GetDateDesc_1        : string    ; begin Result := GetStringField('DateDesc_1');end;
function  TVS1_Dashboard_pnl_period.GetDateFrom_2        : TDateTime ; begin Result := GetDateTimeField('DateFrom_2');end;
function  TVS1_Dashboard_pnl_period.GetDateTo_2          : TDateTime ; begin Result := GetDateTimeField('DateTo_2');end;
function  TVS1_Dashboard_pnl_period.GetDateDesc_2        : string    ; begin Result := GetStringField('DateDesc_2');end;
function  TVS1_Dashboard_pnl_period.GetDateFrom_3        : TDateTime ; begin Result := GetDateTimeField('DateFrom_3');end;
function  TVS1_Dashboard_pnl_period.GetDateTo_3          : TDateTime ; begin Result := GetDateTimeField('DateTo_3');end;
function  TVS1_Dashboard_pnl_period.GetDateDesc_3        : string    ; begin Result := GetStringField('DateDesc_3');end;
function  TVS1_Dashboard_pnl_period.GetDateFrom_4        : TDateTime ; begin Result := GetDateTimeField('DateFrom_4');end;
function  TVS1_Dashboard_pnl_period.GetDateTo_4          : TDateTime ; begin Result := GetDateTimeField('DateTo_4');end;
function  TVS1_Dashboard_pnl_period.GetDateDesc_4        : string    ; begin Result := GetStringField('DateDesc_4');end;
function  TVS1_Dashboard_pnl_period.GetDateFrom_5        : TDateTime ; begin Result := GetDateTimeField('DateFrom_5');end;
function  TVS1_Dashboard_pnl_period.GetDateTo_5          : TDateTime ; begin Result := GetDateTimeField('DateTo_5');end;
function  TVS1_Dashboard_pnl_period.GetDateDesc_5        : string    ; begin Result := GetStringField('DateDesc_5');end;
function  TVS1_Dashboard_pnl_period.GetDateFrom_6        : TDateTime ; begin Result := GetDateTimeField('DateFrom_6');end;
function  TVS1_Dashboard_pnl_period.GetDateTo_6          : TDateTime ; begin Result := GetDateTimeField('DateTo_6');end;
function  TVS1_Dashboard_pnl_period.GetDateDesc_6        : string    ; begin Result := GetStringField('DateDesc_6');end;
function  TVS1_Dashboard_pnl_period.GetDateFrom_7        : TDateTime ; begin Result := GetDateTimeField('DateFrom_7');end;
function  TVS1_Dashboard_pnl_period.GetDateTo_7          : TDateTime ; begin Result := GetDateTimeField('DateTo_7');end;
function  TVS1_Dashboard_pnl_period.GetDateDesc_7        : string    ; begin Result := GetStringField('DateDesc_7');end;
(*function  TVS1_Dashboard_pnl_period.GetDateFrom_8        : TDateTime ; begin Result := GetDateTimeField('DateFrom_8');end;
function  TVS1_Dashboard_pnl_period.GetDateTo_8          : TDateTime ; begin Result := GetDateTimeField('DateTo_8');end;
function  TVS1_Dashboard_pnl_period.GetDateDesc_8        : string    ; begin Result := GetStringField('DateDesc_8');end;*)
function  TVS1_Dashboard_pnl_period.GetHidePercentage    : Boolean   ; begin Result := GetBooleanField('HidePercentage');end;
function  TVS1_Dashboard_pnl_period.GetAccountID         : Integer   ; begin Result := GetIntegerField('AccountID');end;
function  TVS1_Dashboard_pnl_period.GetAccountType       : string    ; begin Result := GetStringField('AccountType');end;
function  TVS1_Dashboard_pnl_period.GetAccountTypeDesc   : string    ; begin Result := GetStringField('AccountTypeDesc');end;
function  TVS1_Dashboard_pnl_period.GetAccountName       : string    ; begin Result := GetStringField('AccountName');end;
function  TVS1_Dashboard_pnl_period.GetAmount_1          : Double    ; begin Result := GetFloatField('Amount_1');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_1      : string    ; begin Result := GetStringField('Percentage_1');end;
function  TVS1_Dashboard_pnl_period.GetAmount_2          : Double    ; begin Result := GetFloatField('Amount_2');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_2      : string    ; begin Result := GetStringField('Percentage_2');end;
function  TVS1_Dashboard_pnl_period.GetChange_2          : Double    ; begin Result := GetFloatField('Change_2');end;
function  TVS1_Dashboard_pnl_period.GetChangePercent_2   : Double    ; begin Result := GetFloatField('ChangePercent_2');end;
function  TVS1_Dashboard_pnl_period.GetAmount_3          : Double    ; begin Result := GetFloatField('Amount_3');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_3      : string    ; begin Result := GetStringField('Percentage_3');end;
function  TVS1_Dashboard_pnl_period.GetChange_3          : Double    ; begin Result := GetFloatField('Change_3');end;
function  TVS1_Dashboard_pnl_period.GetChangePercent_3   : Double    ; begin Result := GetFloatField('ChangePercent_3');end;
function  TVS1_Dashboard_pnl_period.GetAmount_4          : Double    ; begin Result := GetFloatField('Amount_4');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_4      : string    ; begin Result := GetStringField('Percentage_4');end;
function  TVS1_Dashboard_pnl_period.GetChange_4          : Double    ; begin Result := GetFloatField('Change_4');end;
function  TVS1_Dashboard_pnl_period.GetChangePercent_4   : Double    ; begin Result := GetFloatField('ChangePercent_4');end;
function  TVS1_Dashboard_pnl_period.GetAmount_5          : Double    ; begin Result := GetFloatField('Amount_5');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_5      : string    ; begin Result := GetStringField('Percentage_5');end;
function  TVS1_Dashboard_pnl_period.GetChange_5          : Double    ; begin Result := GetFloatField('Change_5');end;
function  TVS1_Dashboard_pnl_period.GetChangePercent_5   : Double    ; begin Result := GetFloatField('ChangePercent_5');end;
function  TVS1_Dashboard_pnl_period.GetAmount_6          : Double    ; begin Result := GetFloatField('Amount_6');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_6      : string    ; begin Result := GetStringField('Percentage_6');end;
function  TVS1_Dashboard_pnl_period.GetChange_6          : Double    ; begin Result := GetFloatField('Change_6');end;
function  TVS1_Dashboard_pnl_period.GetChangePercent_6   : Double    ; begin Result := GetFloatField('ChangePercent_6');end;
function  TVS1_Dashboard_pnl_period.GetAmount_7          : Double    ; begin Result := GetFloatField('Amount_7');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_7      : string    ; begin Result := GetStringField('Percentage_7');end;
function  TVS1_Dashboard_pnl_period.GetChange_7          : Double    ; begin Result := GetFloatField('Change_7');end;
function  TVS1_Dashboard_pnl_period.GetChangePercent_7   : Double    ; begin Result := GetFloatField('ChangePercent_7');end;
(*function  TVS1_Dashboard_pnl_period.GetAmount_8          : Double    ; begin Result := GetFloatField('Amount_8');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_8      : string    ; begin Result := GetStringField('Percentage_8');end;
function  TVS1_Dashboard_pnl_period.GetChange_8          : Double    ; begin Result := GetFloatField('Change_8');end;
function  TVS1_Dashboard_pnl_period.GetChangePercent_8   : Double    ; begin Result := GetFloatField('ChangePercent_8');end;
function  TVS1_Dashboard_pnl_period.GetAmount_9          : Double    ; begin Result := GetFloatField('Amount_9');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_9      : string    ; begin Result := GetStringField('Percentage_9');end;
function  TVS1_Dashboard_pnl_period.GetAmount_10         : Double    ; begin Result := GetFloatField('Amount_10');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_10     : string    ; begin Result := GetStringField('Percentage_10');end;
function  TVS1_Dashboard_pnl_period.GetAmount_11         : Double    ; begin Result := GetFloatField('Amount_11');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_11     : string    ; begin Result := GetStringField('Percentage_11');end;
function  TVS1_Dashboard_pnl_period.GetAmount_12         : Double    ; begin Result := GetFloatField('Amount_12');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_12     : string    ; begin Result := GetStringField('Percentage_12');end;
function  TVS1_Dashboard_pnl_period.GetAmount_13         : Double    ; begin Result := GetFloatField('Amount_13');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_13     : string    ; begin Result := GetStringField('Percentage_13');end;
function  TVS1_Dashboard_pnl_period.GetAmount_14         : Double    ; begin Result := GetFloatField('Amount_14');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_14     : string    ; begin Result := GetStringField('Percentage_14');end;
function  TVS1_Dashboard_pnl_period.GetAmount_15         : Double    ; begin Result := GetFloatField('Amount_15');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_15     : string    ; begin Result := GetStringField('Percentage_15');end;
function  TVS1_Dashboard_pnl_period.GetAmount_16         : Double    ; begin Result := GetFloatField('Amount_16');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_16     : string    ; begin Result := GetStringField('Percentage_16');end;
function  TVS1_Dashboard_pnl_period.GetAmount_17         : Double    ; begin Result := GetFloatField('Amount_17');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_17     : string    ; begin Result := GetStringField('Percentage_17');end;
function  TVS1_Dashboard_pnl_period.GetAmount_18         : Double    ; begin Result := GetFloatField('Amount_18');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_18     : string    ; begin Result := GetStringField('Percentage_18');end;
function  TVS1_Dashboard_pnl_period.GetAmount_19         : Double    ; begin Result := GetFloatField('Amount_19');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_19     : string    ; begin Result := GetStringField('Percentage_19');end;
function  TVS1_Dashboard_pnl_period.GetAmount_20         : Double    ; begin Result := GetFloatField('Amount_20');end;
function  TVS1_Dashboard_pnl_period.GetPercentage_20     : string    ; begin Result := GetStringField('Percentage_20');end;*)
function  TVS1_Dashboard_pnl_period.GetTotalAmount       : Double    ; begin Result := GetFloatField('TotalAmount');end;
function  TVS1_Dashboard_pnl_period.GetFinalOrder        : Integer   ; begin Result := GetIntegerField('FinalOrder');end;
function  TVS1_Dashboard_pnl_period.GetAccountHeaderOrder: string    ; begin Result := GetStringField('AccountHeaderOrder');end;
function  TVS1_Dashboard_pnl_period.GetAccountSub1Order  : string    ; begin Result := GetStringField('AccountSub1Order');end;
function  TVS1_Dashboard_pnl_period.GetAccountSub2Order  : string    ; begin Result := GetStringField('AccountSub2Order');end;
function  TVS1_Dashboard_pnl_period.GetAccountSub3Order  : string    ; begin Result := GetStringField('AccountSub3Order');end;
function  TVS1_Dashboard_pnl_period.GetHideTotal         : Boolean   ; begin Result := GetBooleanField('HideTotal');end;
procedure TVS1_Dashboard_pnl_period.SetDateFrom_1        (const Value: TDateTime ); begin SetDateTimeField('DateFrom_1'         , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateTo_1          (const Value: TDateTime ); begin SetDateTimeField('DateTo_1'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateDesc_1        (const Value: string    ); begin SetStringField('DateDesc_1'         , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateFrom_2        (const Value: TDateTime ); begin SetDateTimeField('DateFrom_2'         , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateTo_2          (const Value: TDateTime ); begin SetDateTimeField('DateTo_2'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateDesc_2        (const Value: string    ); begin SetStringField('DateDesc_2'         , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateFrom_3        (const Value: TDateTime ); begin SetDateTimeField('DateFrom_3'         , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateTo_3          (const Value: TDateTime ); begin SetDateTimeField('DateTo_3'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateDesc_3        (const Value: string    ); begin SetStringField('DateDesc_3'         , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateFrom_4        (const Value: TDateTime ); begin SetDateTimeField('DateFrom_4'         , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateTo_4          (const Value: TDateTime ); begin SetDateTimeField('DateTo_4'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateDesc_4        (const Value: string    ); begin SetStringField('DateDesc_4'         , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateFrom_5        (const Value: TDateTime ); begin SetDateTimeField('DateFrom_5'         , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateTo_5          (const Value: TDateTime ); begin SetDateTimeField('DateTo_5'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateDesc_5        (const Value: string    ); begin SetStringField('DateDesc_5'         , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateFrom_6        (const Value: TDateTime ); begin SetDateTimeField('DateFrom_6'         , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateTo_6          (const Value: TDateTime ); begin SetDateTimeField('DateTo_6'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateDesc_6        (const Value: string    ); begin SetStringField('DateDesc_6'         , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateFrom_7        (const Value: TDateTime ); begin SetDateTimeField('DateFrom_7'         , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateTo_7          (const Value: TDateTime ); begin SetDateTimeField('DateTo_7'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateDesc_7        (const Value: string    ); begin SetStringField('DateDesc_7'         , Value);end;
(*procedure TVS1_Dashboard_pnl_period.SetDateFrom_8        (const Value: TDateTime ); begin SetDateTimeField('DateFrom_8'         , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateTo_8          (const Value: TDateTime ); begin SetDateTimeField('DateTo_8'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetDateDesc_8        (const Value: string    ); begin SetStringField('DateDesc_8'         , Value);end;*)
procedure TVS1_Dashboard_pnl_period.SetHidePercentage    (const Value: Boolean   ); begin SetBooleanField('HidePercentage'     , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAccountID         (const Value: Integer   ); begin SetIntegerField('AccountID'          , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAccountType       (const Value: string    ); begin SetStringField('AccountType'        , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAccountTypeDesc   (const Value: string    ); begin SetStringField('AccountTypeDesc'    , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAccountName       (const Value: string    ); begin SetStringField('AccountName'        , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_1          (const Value: Double    ); begin SetFloatField('Amount_1'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_1      (const Value: string    ); begin SetStringField('Percentage_1'       , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_2          (const Value: Double    ); begin SetFloatField('Amount_2'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_2      (const Value: string    ); begin SetStringField('Percentage_2'       , Value);end;
procedure TVS1_Dashboard_pnl_period.SetChange_2          (const Value: Double    ); begin SetFloatField('Change_2'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetChangePercent_2   (const Value: Double    ); begin SetFloatField('ChangePercent_2'    , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_3          (const Value: Double    ); begin SetFloatField('Amount_3'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_3      (const Value: string    ); begin SetStringField('Percentage_3'       , Value);end;
procedure TVS1_Dashboard_pnl_period.SetChange_3          (const Value: Double    ); begin SetFloatField('Change_3'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetChangePercent_3   (const Value: Double    ); begin SetFloatField('ChangePercent_3'    , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_4          (const Value: Double    ); begin SetFloatField('Amount_4'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_4      (const Value: string    ); begin SetStringField('Percentage_4'       , Value);end;
procedure TVS1_Dashboard_pnl_period.SetChange_4          (const Value: Double    ); begin SetFloatField('Change_4'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetChangePercent_4   (const Value: Double    ); begin SetFloatField('ChangePercent_4'    , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_5          (const Value: Double    ); begin SetFloatField('Amount_5'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_5      (const Value: string    ); begin SetStringField('Percentage_5'       , Value);end;
procedure TVS1_Dashboard_pnl_period.SetChange_5          (const Value: Double    ); begin SetFloatField('Change_5'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetChangePercent_5   (const Value: Double    ); begin SetFloatField('ChangePercent_5'    , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_6          (const Value: Double    ); begin SetFloatField('Amount_6'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_6      (const Value: string    ); begin SetStringField('Percentage_6'       , Value);end;
procedure TVS1_Dashboard_pnl_period.SetChange_6          (const Value: Double    ); begin SetFloatField('Change_6'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetChangePercent_6   (const Value: Double    ); begin SetFloatField('ChangePercent_6'    , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_7          (const Value: Double    ); begin SetFloatField('Amount_7'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_7      (const Value: string    ); begin SetStringField('Percentage_7'       , Value);end;
procedure TVS1_Dashboard_pnl_period.SetChange_7          (const Value: Double    ); begin SetFloatField('Change_7'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetChangePercent_7   (const Value: Double    ); begin SetFloatField('ChangePercent_7'    , Value);end;
(*procedure TVS1_Dashboard_pnl_period.SetAmount_8          (const Value: Double    ); begin SetFloatField('Amount_8'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_8      (const Value: string    ); begin SetStringField('Percentage_8'       , Value);end;
procedure TVS1_Dashboard_pnl_period.SetChange_8          (const Value: Double    ); begin SetFloatField('Change_8'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetChangePercent_8   (const Value: Double    ); begin SetFloatField('ChangePercent_8'    , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_9          (const Value: Double    ); begin SetFloatField('Amount_9'           , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_9      (const Value: string    ); begin SetStringField('Percentage_9'       , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_10         (const Value: Double    ); begin SetFloatField('Amount_10'          , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_10     (const Value: string    ); begin SetStringField('Percentage_10'      , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_11         (const Value: Double    ); begin SetFloatField('Amount_11'          , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_11     (const Value: string    ); begin SetStringField('Percentage_11'      , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_12         (const Value: Double    ); begin SetFloatField('Amount_12'          , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_12     (const Value: string    ); begin SetStringField('Percentage_12'      , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_13         (const Value: Double    ); begin SetFloatField('Amount_13'          , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_13     (const Value: string    ); begin SetStringField('Percentage_13'      , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_14         (const Value: Double    ); begin SetFloatField('Amount_14'          , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_14     (const Value: string    ); begin SetStringField('Percentage_14'      , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_15         (const Value: Double    ); begin SetFloatField('Amount_15'          , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_15     (const Value: string    ); begin SetStringField('Percentage_15'      , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_16         (const Value: Double    ); begin SetFloatField('Amount_16'          , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_16     (const Value: string    ); begin SetStringField('Percentage_16'      , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_17         (const Value: Double    ); begin SetFloatField('Amount_17'          , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_17     (const Value: string    ); begin SetStringField('Percentage_17'      , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_18         (const Value: Double    ); begin SetFloatField('Amount_18'          , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_18     (const Value: string    ); begin SetStringField('Percentage_18'      , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_19         (const Value: Double    ); begin SetFloatField('Amount_19'          , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_19     (const Value: string    ); begin SetStringField('Percentage_19'      , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAmount_20         (const Value: Double    ); begin SetFloatField('Amount_20'          , Value);end;
procedure TVS1_Dashboard_pnl_period.SetPercentage_20     (const Value: string    ); begin SetStringField('Percentage_20'      , Value);end;*)
procedure TVS1_Dashboard_pnl_period.SetTotalAmount       (const Value: Double    ); begin SetFloatField('TotalAmount'        , Value);end;
procedure TVS1_Dashboard_pnl_period.SetFinalOrder        (const Value: Integer   ); begin SetIntegerField('FinalOrder'         , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAccountHeaderOrder(const Value: string    ); begin SetStringField('AccountHeaderOrder' , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAccountSub1Order  (const Value: string    ); begin SetStringField('AccountSub1Order'   , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAccountSub2Order  (const Value: string    ); begin SetStringField('AccountSub2Order'   , Value);end;
procedure TVS1_Dashboard_pnl_period.SetAccountSub3Order  (const Value: string    ); begin SetStringField('AccountSub3Order'   , Value);end;
procedure TVS1_Dashboard_pnl_period.SetHideTotal         (const Value: Boolean   ); begin SetBooleanField('HideTotal'          , Value);end;

  {TVS1_Dashboard_ap_report}
constructor TVS1_Dashboard_ap_report.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1_dashboard_ap_report';
  fSQL := 'SELECT * FROM tmp_vs1_dashboard_ap_report';
end;

destructor TVS1_Dashboard_ap_report.Destroy;
begin
  inherited;
end;

procedure TVS1_Dashboard_ap_report.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node,'Datefrom');
  SetDateTimePropertyFromNode(node,'dateto');
  SetPropertyFromNode(node,'month1');
  SetPropertyFromNode(node,'MONTH2');
  SetPropertyFromNode(node,'MONTH3');
  SetPropertyFromNode(node,'total');
end;

procedure TVS1_Dashboard_ap_report.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Datefrom' ,Datefrom);
  AddXMLNode(node,'dateto' ,dateto);
  AddXMLNode(node,'month1' ,month1);
  AddXMLNode(node,'MONTH2' ,MONTH2);
  AddXMLNode(node,'MONTH3' ,MONTH3);
  AddXMLNode(node,'total' ,total);
end;

function TVS1_Dashboard_ap_report.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;

function TVS1_Dashboard_ap_report.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TVS1_Dashboard_ap_report.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TVS1_Dashboard_ap_report.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TVS1_Dashboard_ap_report.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TVS1_Dashboard_ap_report.GetIDField: string;
begin
  Result := 'ID'
end;

class function TVS1_Dashboard_ap_report.GetBusObjectTablename: string;
begin
  Result:= 'tmp_vs1_dashboard_ap_report';
end;

function TVS1_Dashboard_ap_report.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
function  TVS1_Dashboard_ap_report.GetDatefrom: TDateTime ; begin Result := GetDateTimeField('Datefrom');end;
function  TVS1_Dashboard_ap_report.Getdateto  : TDateTime ; begin Result := GetDateTimeField('dateto');end;
function  TVS1_Dashboard_ap_report.Getmonth1  : string    ; begin Result := GetStringField('month1');end;
function  TVS1_Dashboard_ap_report.GetMONTH2  : string    ; begin Result := GetStringField('MONTH2');end;
function  TVS1_Dashboard_ap_report.GetMONTH3  : string    ; begin Result := GetStringField('MONTH3');end;
function  TVS1_Dashboard_ap_report.Gettotal   : Double    ; begin Result := GetFloatField('total');end;
procedure TVS1_Dashboard_ap_report.SetDatefrom(const Value: TDateTime ); begin SetDateTimeField('Datefrom' , Value);end;
procedure TVS1_Dashboard_ap_report.Setdateto  (const Value: TDateTime ); begin SetDateTimeField('dateto'   , Value);end;
procedure TVS1_Dashboard_ap_report.Setmonth1  (const Value: string    ); begin SetStringField('month1'   , Value);end;
procedure TVS1_Dashboard_ap_report.SetMONTH2  (const Value: string    ); begin SetStringField('MONTH2'   , Value);end;
procedure TVS1_Dashboard_ap_report.SetMONTH3  (const Value: string    ); begin SetStringField('MONTH3'   , Value);end;
procedure TVS1_Dashboard_ap_report.Settotal   (const Value: Double    ); begin SetFloatField('total'    , Value);end;

  {TVS1_Dashboard_Summary2}
constructor TVS1_Dashboard_Summary2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1_dashboard_summary2';
  fSQL := 'SELECT * FROM tmp_vs1_dashboard_summary2';
end;

destructor TVS1_Dashboard_Summary2.Destroy;
begin
  inherited;
end;

procedure TVS1_Dashboard_Summary2.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'CashReceived');
  SetPropertyFromNode(node, 'CashSpent');
  SetPropertyFromNode(node, 'CashSurplus');
  SetPropertyFromNode(node, 'CashBalance');
  SetPropertyFromNode(node, 'ProfIncome');
  SetPropertyFromNode(node, 'ProfGross');
  SetPropertyFromNode(node, 'ProfExpenses');
  SetPropertyFromNode(node, 'ProfNet');
end;

procedure TVS1_Dashboard_Summary2.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'CashReceived', Cash_Received);
  AddXMLNode(node, 'CashSpent', Cash_Spent);
  AddXMLNode(node, 'CashSurplus', Cash_Surplus);
  AddXMLNode(node, 'CashBalance', Cash_Balance);
  AddXMLNode(node, 'ProfIncome', Prof_Income);
  AddXMLNode(node, 'ProfGross', Prof_Gross);
  AddXMLNode(node, 'ProfExpenses', Prof_Expenses);
  AddXMLNode(node, 'ProfNet', Prof_Net);
end;

function TVS1_Dashboard_Summary2.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;

function TVS1_Dashboard_Summary2.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TVS1_Dashboard_Summary2.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TVS1_Dashboard_Summary2.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TVS1_Dashboard_Summary2.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TVS1_Dashboard_Summary2.GetIDField: string;
begin
  Result := 'ID'
end;

class function TVS1_Dashboard_Summary2.GetBusObjectTablename: string;
begin
  Result:= 'tmp_vs1_dashboard_summary2';
end;

function TVS1_Dashboard_Summary2.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

procedure TVS1_Dashboard_Summary2.CreateTemporaryTable(ADateFrom: string; ADateTo: string);
var
  Params: TJSONObject;
  TempScript: TERPScript;
begin
  TempScript := TERPScript.Create(Self);
  try
    with TempScript do begin
      Connection := CommonDbLib.GetSharedMyDacConnection;
      SQL.Clear;
      SQL.Add('DROP TABLE IF EXISTS tmp_vs1_dashboard_summary2;');
      SQL.Add('CREATE TEMPORARY TABLE tmp_vs1_dashboard_summary2 ( ' +
                  ' ID                     INT(11)  NOT NULL AUTO_INCREMENT, ' +
                  ' Cash_Received          DOUBLE   NOT NULL DEFAULT 0, '+
                  ' Cash_Spent             DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Cash_Surplus           DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Cash_Balance           DOUBLE   NOT NULL DEFAULT 0, ' +

                  ' Prof_Income            DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Prof_Gross             DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Prof_Expenses          DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Prof_Net               DOUBLE   NOT NULL DEFAULT 0, ' +

                  ' Income_Invoices        INT(11)  NOT NULL DEFAULT 0, ' +
                  ' Income_Average         DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Income_Total           DOUBLE   NOT NULL DEFAULT 0, ' +

                  ' Perf_GrossMargin       DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Perf_NetMargin         DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Perf_ROI               DOUBLE   NOT NULL DEFAULT 0, ' +

                  ' Bal_Debtors            DOUBLE  NOT NULL DEFAULT 0, ' +
                  ' Bal_Creditors          DOUBLE  NOT NULL DEFAULT 0, ' +
                  ' Bal_NetAsset           DOUBLE  NOT NULL DEFAULT 0, ' +

                  ' Pos_AvgDebtDays        INT(11) NOT NULL DEFAULT 0, ' +
                  ' Pos_AvgCredDays        INT(11) NOT NULL DEFAULT 0, ' +
                  ' Pos_CashForecast       DOUBLE  NOT NULL DEFAULT 0, ' +
                  ' Pos_AssetToLiab        DOUBLE  NOT NULL DEFAULT 0, ' +

                  ' Sheet_AssetToLiab      DOUBLE  NOT NULL DEFAULT 0, ' +

                  ' PRIMARY KEY (ID) ' +
                  ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;');

      SQL.Add('INSERT INTO tmp_vs1_dashboard_summary2 SET Cash_Received=0.01;');

       // Cash
      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 T, (SELECT TRUNCATE(SUM(DebitsInc), 4) AS Received FROM tbltransactions WHERE AccountType="BANK" AND `Date` BETWEEN ' + QuotedStr(ADateFrom) + ' AND ' + QuotedStr(ADateTo) + ') T1 SET T.Cash_Received=T1.Received;');
      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 T, (SELECT TRUNCATE(SUM(CreditsEx), 4) AS Spent 	 FROM tbltransactions	WHERE (AccountType="BANK" OR AccountType="CCARD") AND `Date` BETWEEN ' + QuotedStr(ADateFrom) + ' AND ' + QuotedStr(ADateTo) + ') T1 SET T.Cash_Spent=T1.Spent;');
      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 T, (SELECT TRUNCATE(SUM(DebitsInc) - SUM(CreditsEx), 4) AS Surplus FROM tbltransactions WHERE AccountType="BANK" AND `Date` BETWEEN ' + QuotedStr(ADateFrom) + ' AND ' + QuotedStr(ADateTo) + ') T1 SET T.Cash_Surplus=T1.Surplus;');
      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 T, (SELECT TRUNCATE(SUM(DebitsInc), 4) AS Balance FROM tbltransactions WHERE AccountType="BANK" AND `Date` BETWEEN ' + QuotedStr(ADateFrom) + ' AND ' + QuotedStr(ADateTo) + ') T1 SET T.Cash_Balance=T1.Balance;');

      // Profitability
//      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 SET Prof_Income=(SELECT totalAmountEx FROM tmp_VS1_Dashboard_Summary_5 WHERE UCASE(`account type`)=UCASE("Total Income"));');
//      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 SET Prof_Gross=(SELECT totalAmountEx FROM tmp_VS1_Dashboard_Summary_5 WHERE UCASE(`account type`)=UCASE("Gross Profit"));');
//      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 SET Prof_Expenses=(SELECT totalAmountEx FROM tmp_VS1_Dashboard_Summary_5 WHERE UCASE(`account type`)=UCASE("Total Expenses"));');
//      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 SET Prof_Net=(SELECT totalAmountEx FROM tmp_VS1_Dashboard_Summary_5 WHERE UCASE(`account type`)=UCASE("Net Income"));');

      // Income
      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 SET Income_Invoices=' +
                    '(SELECT COUNT(*) FROM tblsales WHERE IsInvoice="T" AND Deleted="F"  AND Saledate BETWEEN ' + QuotedStr(ADateFrom) + ' AND ' + QuotedStr(ADateTo) + ');');
      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 SET Income_Average=' +
                    '(SELECT AVG(TotalAmountInc) FROM tblsales WHERE IsInvoice="T" AND Deleted="F"  AND Saledate BETWEEN ' + QuotedStr(ADateFrom) + ' AND ' + QuotedStr(ADateTo) + ');');
      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 SET Income_Total=' +
                    '(SELECT SUM(TotalAmountInc) FROM tblsales WHERE IsInvoice="T" AND Deleted="F" AND Saledate BETWEEN ' + QuotedStr(ADateFrom) + ' AND ' + QuotedStr(ADateTo) + ');');

      // Performance
      //SQL.Add('UPDATE tmp_vs1_dashboard_summary2 SET Perf_GrossMargin=TRUNCATE((Prof_Income - (SELECT totalAmountEx FROM tmp_VS1_Dashboard_Summary_5 WHERE UCASE(`account type`) = UCASE("Total COGS"))) * 100 / Prof_Income, 2);');
      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 SET Perf_NetMargin=TRUNCATE((Prof_Income - Prof_Expenses) * 100 / Prof_Income, 2);');
      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 SET Perf_ROI=TRUNCATE((Prof_Net) * 100 / (SELECT SUM(DebitsInc) FROM tbltransactions WHERE AccountType="EQUITY"), 2);');

      // Balance Sheet
      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 SET Bal_Debtors=' +
                    '(SELECT TRUNCATE(SUM(t.DebitsEx) - SUM(t.CreditsEx), 4) ' +
                    'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID = p.PurchaseOrderID ' +
                    'WHERE t.AccountType = "AR" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                    'AND `Date` BETWEEN ' + QuotedStr(ADateFrom) + ' AND ' + QuotedStr(ADateTo) + ');');
      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 SET Bal_Creditors=' +
                    '(SELECT TRUNCATE(SUM(t.CreditsEx) - SUM(t.DebitsEx), 4) ' +
                    'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID = p.PurchaseOrderID ' +
                    'WHERE t.AccountType = "AP" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                    'AND `Date` BETWEEN ' + QuotedStr(ADateFrom) + ' AND ' + QuotedStr(ADateTo) + ');');
      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 SET Bal_NetAsset=' +
                    '(SELECT TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4) FROM tbltransactions WHERE (AccountType = "AR" OR AccountType = "BANK" OR AccountType = "OCASSET" OR AccountType = "OASSET") ' +
                    'AND `Date` BETWEEN ' + QuotedStr(ADateFrom) + ' AND ' + QuotedStr(ADateTo) + ');');

      // Position
      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 SET Pos_AvgDebtDays=' +
                    '(SELECT SUM(IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date))) ' +
                    'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID=p.PurchaseOrderID ' +
                    'WHERE t.AccountType = "AR" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                    'AND `Date` BETWEEN ' + QuotedStr(ADateFrom) + ' AND ' + QuotedStr(ADateTo) + ');');
      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 SET Pos_AvgCredDays=' +
                    '(SELECT SUM(IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date))) ' +
                    'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID=p.PurchaseOrderID ' +
                    'WHERE t.AccountType = "AP" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                    'AND `Date` BETWEEN ' + QuotedStr(ADateFrom) + ' AND ' + QuotedStr(ADateTo) + ');');
      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 SET Pos_CashForecast=' +
                    'Bal_Debtors - Bal_Creditors;');
      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 SET Pos_AssetToLiab=Bal_NetAsset - ' +
                    '(SELECT IF(AccountType = "CCARD", TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4), TRUNCATE(SUM(CreditsEx) - SUM(DebitsEx), 4)) ' +
                    'FROM tbltransactions WHERE (AccountType="AP" OR AccountType="OCLIAB" OR AccountType="CCARD") ' +
                    'AND `Date` BETWEEN ' + QuotedStr(ADateFrom) + ' AND ' + QuotedStr(ADateTo) + ');');

      // Sheet
      SQL.Add('UPDATE tmp_vs1_dashboard_summary2 SET Sheet_AssetToLiab=' +
                    '(SELECT TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4) ' +
                    '  FROM tbltransactions WHERE AccountType="OCASSET" AND `Date` BETWEEN ' + QuotedStr(ADateFrom) + ' AND ' + QuotedStr(ADateTo) + ') - ' +
                    '(SELECT TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4) ' +
                    '  FROM tbltransactions WHERE AccountType="OCLIAB" AND `Date` BETWEEN ' + QuotedStr(ADateFrom) + ' AND ' + QuotedStr(ADateTo) + ');');

      if not Devmode then
        SQL.Add('DROP TABLE IF EXISTS tmp_VS1_Dashboard_Summary_5;');

      Execute;
    end;
  finally
    TempScript.Free;
  end;
end;

{Property Functions}
function  TVS1_Dashboard_Summary2.GetCashReceived:      Double ; begin Result := GetFloatField('Cash_Received');end;
function  TVS1_Dashboard_Summary2.GetCashSpent:         Double ; begin Result := GetFloatField('Cash_Spent');end;
function  TVS1_Dashboard_Summary2.GetCashSurplus:       Double ; begin Result := GetFloatField('Cash_Surplus');end;
function  TVS1_Dashboard_Summary2.GetCashBalance:       Double ; begin Result := GetFloatField('Cash_Balance');end;
function  TVS1_Dashboard_Summary2.GetProfIncome:        Double ; begin Result := GetFloatField('Prof_Income');end;
function  TVS1_Dashboard_Summary2.GetProfGross:         Double ; begin Result := GetFloatField('Prof_Gross');end;
function  TVS1_Dashboard_Summary2.GetProfExpenses:      Double ; begin Result := GetFloatField('Prof_Expenses');end;
function  TVS1_Dashboard_Summary2.GetProfNet:           Double ; begin Result := GetFloatField('Prof_Net');end;
function  TVS1_Dashboard_Summary2.GetIncomeInvoices:    Integer; begin Result := GetIntegerField('Income_Invoices');end;
function  TVS1_Dashboard_Summary2.GetIncomeAverage:     Double ; begin Result := GetFloatField('Income_Avergae');end;
function  TVS1_Dashboard_Summary2.GetIncomeTotal:       Double ; begin Result := GetFloatField('Income_Total');end;
function  TVS1_Dashboard_Summary2.GetPerfGrossMargin:   Double ; begin Result := GetFloatField('Perf_GrossMargin');end;
function  TVS1_Dashboard_Summary2.GetPerfNetMargin:     Double ; begin Result := GetFloatField('Perf_NetMargin');end;
function  TVS1_Dashboard_Summary2.GetPerfROI:           Double ; begin Result := GetFloatField('Perf_ROI');end;
function  TVS1_Dashboard_Summary2.GetBalDebtors:        Double ; begin Result := GetFloatField('Bal_Debtors');end;
function  TVS1_Dashboard_Summary2.GetBalCreditors:      Double ; begin Result := GetFloatField('Bal_Creditors');end;
function  TVS1_Dashboard_Summary2.GetBalNetAsset:       Double ; begin Result := GetFloatField('Bal_NetAsset');end;
function  TVS1_Dashboard_Summary2.GetPosAvgDebtDays:    Integer; begin Result := GetIntegerField('Pos_AvgDebtDays');end;
function  TVS1_Dashboard_Summary2.GetPosAvgCredDays:    Integer; begin Result := GetIntegerField('Pos_AvgCredDays');end;
function  TVS1_Dashboard_Summary2.GetPosCashForecast:   Double ; begin Result := GetFloatField('Pos_CashForecast');end;
function  TVS1_Dashboard_Summary2.GetPosAssetToLiab:    Double ; begin Result := GetFloatField('Pos_AssetToLiab');end;
function  TVS1_Dashboard_Summary2.GetSheetAssetToLiab:  Double ; begin Result := GetFloatField('Sheet_AssetToLiab');end;

procedure TVS1_Dashboard_Summary2.SetCashReceived(const Value: Double );        begin SetFloatField('Cash_Received', Value);end;
procedure TVS1_Dashboard_Summary2.SetCashSpent(const Value: Double );           begin SetFloatField('Cash_Spent', Value);end;
procedure TVS1_Dashboard_Summary2.SetCashSurplus(const Value: Double );         begin SetFloatField('Cash_Surplus', Value);end;
procedure TVS1_Dashboard_Summary2.SetCashBalance(const Value: Double );         begin SetFloatField('Cash_Balance', Value);end;
procedure TVS1_Dashboard_Summary2.SetProfIncome(const Value: Double );          begin SetFloatField('Prof_Income', Value);end;
procedure TVS1_Dashboard_Summary2.SetProfGross(const Value: Double );           begin SetFloatField('Prof_Gross', Value);end;
procedure TVS1_Dashboard_Summary2.SetProfExpenses(const Value: Double );        begin SetFloatField('Prof_Expenses', Value);end;
procedure TVS1_Dashboard_Summary2.SetProfNet(const Value: Double );             begin SetFloatField('Prof_Net', Value);end;
procedure TVS1_Dashboard_Summary2.SetIncomeInvoices(const Value: Integer );     begin SetIntegerField('Income_Invoices', Value);end;
procedure TVS1_Dashboard_Summary2.SetIncomeAverage(const Value: Double );       begin SetFloatField('Income_Average', Value);end;
procedure TVS1_Dashboard_Summary2.SetIncomeTotal(const Value: Double );         begin SetFloatField('Income_Total', Value);end;
procedure TVS1_Dashboard_Summary2.SetPerfGrossMargin(const Value: Double );     begin SetFloatField('Perf_GrossMargin', Value);end;
procedure TVS1_Dashboard_Summary2.SetPerfNetMargin(const Value: Double );       begin SetFloatField('Perf_NetMargin', Value);end;
procedure TVS1_Dashboard_Summary2.SetPerfROI(const Value: Double );             begin SetFloatField('Perf_ROI', Value);end;
procedure TVS1_Dashboard_Summary2.SetBalDebtors(const Value: Double );          begin SetFloatField('Bal_Debtors', Value);end;
procedure TVS1_Dashboard_Summary2.SetBalCreditors(const Value: Double );        begin SetFloatField('Bal_Creditors', Value);end;
procedure TVS1_Dashboard_Summary2.SetBalNetAsset(const Value: Double );         begin SetFloatField('Bal_NetAsset', Value);end;
procedure TVS1_Dashboard_Summary2.SetPosAvgDebtDays(const Value: Integer );     begin SetIntegerField('Pos_DebtDays', Value);end;
procedure TVS1_Dashboard_Summary2.SetPosAvgCredDays(const Value: Integer );     begin SetIntegerField('Pos_CredDays', Value);end;
procedure TVS1_Dashboard_Summary2.SetPosCashForecast(const Value: Double );     begin SetFloatField('Pos_CashForecast', Value);end;
procedure TVS1_Dashboard_Summary2.SetPosAssetToLiab(const Value: Double );      begin SetFloatField('Pos_AssetToLiab', Value);end;
procedure TVS1_Dashboard_Summary2.SetSheetAssetToLiab(const Value: Double );    begin SetFloatField('Sheet_AssetToLiab', Value);end;

initialization
  RegisterClass(TVS1_Dashboard_ap_report);
  RegisterClass(TVS1_Dashboard_pnl_period);
  RegisterClass(TVS1_Dashboard_saleslist);
  RegisterClass(TVS1_Dashboard_salesperemployee);
  RegisterClass(TVS1_Dashboard_summary);
  RegisterClass(TVS1_Dashboard_pnl);
end.

