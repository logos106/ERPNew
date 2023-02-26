unit BusObjPayments;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  31/10/07  1.00.01  A.  Initial Version.
  }


interface


Uses TypesLib, BusObjBase, DB, Classes, BusObjClient,
     BusObjSales,BusObjGLAccount,busObjBankDepost,
     BusobjABA, busobjPaymethods, MyAccess,ERPdbComponents, tcTypes,
     XMLDoc, XMLIntf,
     BusobjGeneral,IntegerListObj, BusObjTenderAccountPrefs, BusObjOrderBase;

Type

  TGUIPaymentLines = class(TMSBusObj)
  private
    Function GetType                    : String    ;
    Function GetApplied                 : Boolean   ;
    Function GetOriginalAmount          : Double    ;
    Function GetAmountDue               : Double    ;
    Function GetPaID                    : Boolean   ;
    Function GetForeignExchangeCode     : String    ;
    Function GetForeignExchangeRate     : Double    ;
    Function GetForeignOriginalAmt      : Double    ;
    Function GetForeignAmountDue        : Double    ;
    Function GetAmountOutStanding       : Double    ;
    Function GetForeignOutStanding      : Double    ;
    Function GetPayment                 : Double    ;
    Function GetForeignPayment          : Double    ;
    function getHeaderFCCode            : String;
    function getHeaderUnapplied         : Double;
    function getHeaderapplied           : Double;
    function getHeaderForeignUnapplied  : Double;
    function getHeaderForeignapplied    : Double;
    function getHeaderBalance           : Double;
    Function getHeaderPaymentDate       : TDatetime;
    Function getIsFCSelected            : Boolean;
    Procedure SetType                    (Const Value: String    );
    Procedure SetApplied                 (Const Value: Boolean   );
    Procedure SetOriginalAmount          (Const Value: Double    );
    Procedure SetAmountDue               (Const Value: Double    );
    Procedure SetPaID                    (Const Value: Boolean   );
    Procedure SetForeignExchangeCode     (Const Value: String    );
    Procedure SetForeignExchangeRate     (Const Value: Double    );
    Procedure SetForeignOriginalAmt      (Const Value: Double    );
    Procedure SetForeignAmountDue        (Const Value: Double    );
    Procedure SetAmountOutstanding       (Const Value: Double    );
    Procedure SetForeignOutstanding      (Const Value: Double    );
    Procedure SetPayment                 (Const Value: Double    );
    Procedure SetForeignPayment          (Const Value: Double    );
    Function  GetRefunding              : Double;
    Procedure SetRefunding               (Const Value: Double);
    function GetRefundPercent: Double;
    procedure SetRefundPercent(const Value: Double);
    function GetIsEarlyPaymentDiscount: boolean;
    procedure SetIsEarlyPaymentDiscount(const Value: boolean);
    function GetCleanDiscount: double;
    function GetDiscount: Double;
    procedure SetDiscount(const Value: Double);
    Function  GetCleanRefunding         : Double;

  Protected
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);  Override;
    Procedure DoFieldOnChange(Sender: TField);              Override;
    Function  GetSQL                             : String;  Override;
    Function  DoAfterPost(Sender:TDatasetBusObj) : Boolean; Override;
    Function  DoAfterOpen(Sender:TDatasetBusObj) : Boolean; Override;
    Function  GetClientName     : String    ;               Virtual;abstract;
    Function  GetTransDate      : TDateTime ;               Virtual;abstract;
    Function  GetTransNumber    : String    ;               Virtual;abstract;
    Function  GetTransID        : Integer   ;               Virtual;abstract;
    Procedure SetClientName     (Const Value: String    );  Virtual;abstract;
    Procedure SetTransDate      (Const Value: TDateTime );  Virtual;abstract;
    Procedure SetTransNumber    (Const Value: String    );  Virtual;abstract;
    Procedure SetTransID        (Const Value: Integer   );  Virtual;abstract;
    Procedure changePayment;

  Public
    Class Function  GetIDField               : String;      Override;
    Class Function  GetBusObjectTablename    : String;      Override;
    Constructor     Create(AOwner: TComponent);             Override;
    Destructor      Destroy;                                Override;
    Procedure       LoadFromXMLNode(Const node: IXMLNode);  Override;
    Procedure       SaveToXMLNode(Const   node: IXMLNode);  Override;
    Function        ValidateData: Boolean ;                 Override;
    Function        Save: Boolean ;                         Override;
    Property        HeaderForeignExchangeCode: String       Read getHeaderFCCode;
    Property        HeaderPaymentDate        : TDateTime    Read getHeaderPaymentDate;
    Property        HeaderUnApplied          : Double       Read getHeaderUnapplied;
    Property        HeaderApplied            : Double       Read getHeaderapplied;
    Property        HeaderForeignUnApplied   : Double       Read getHeaderForeignUnapplied;
    Property        HeaderForeignApplied     : Double       Read getHeaderForeignapplied;
    Property        HeaderBalance            : Double       Read getHeaderBalance;
    Property        IsFCSelected             : Boolean      Read getIsFCSelected;
    Property        CleanDiscount               : Double        Read getCleanDiscount;
    Property        CleanRefunding              : Double        Read getcleanRefunding;

  Published
    property TransType                :String      Read GetType                     Write SetType                ;
    Property Applied                  :Boolean     Read getApplied                  Write SetApplied;
    property ClientName               :String      Read GetClientName               Write SetClientName        ;
    property TransDate                :TDateTime   Read GetTransDate                Write SetTransDate           ;
    Property TransNumber              :String      Read getTransNumber              Write SetTransNumber;
    Property TransID                  :Integer     Read getTransID                  Write SetTransID;
    property OriginalAmount           :Double      Read GetOriginalAmount           Write SetOriginalAmount      ;
    property AmountDue                :Double      Read GetAmountDue                Write SetAmountDue             ;
    property Paid                     :Boolean     Read GetPaID                     Write SetPaID                ;
    property ForeignExchangeCode      :String      Read GetForeignExchangeCode      Write SetForeignExchangeCode ;
    property ForeignExchangeRate      :Double      Read GetForeignExchangeRate      Write SetForeignExchangeRate ;
    property ForeignOriginalAmt       :Double      Read GetForeignOriginalAmt       Write SetForeignOriginalAmt  ;
    property ForeignAmountDue         :Double      Read GetForeignAmountDue         Write SetForeignAmountDue;
    property AmountOutStanding        :Double      Read GetAmountOutstanding        Write SetamountOutStanding   ;
    property ForeignOutStanding       :Double      Read GetForeignOutstanding       Write SetForeignOutStanding  ;
    property Payment                  :Double      Read GetPayment                  Write SetPayment             ;
    property ForeignPayment           :Double      Read GetForeignPayment           Write SetForeignPayment      ;
    Property Discount   : Double    Read GetDiscount    Write SetDiscount;
    Property Refunding  : Double    Read GetRefunding   Write SetRefunding;
    Property RefundPercent : Double Read GetRefundPercent  Write SetRefundPercent;
    property IsEarlyPaymentDiscount: boolean read GetIsEarlyPaymentDiscount write SetIsEarlyPaymentDiscount;
  end;

  TGuiSuppPaymentLines = class(TGUIPaymentLines)
  Private
    fOrder: TOrderBase;
    fbCheckEarlyPayment                 : Boolean;
    Function        GetInvoiceDate          : TDatetime;
    Function        GetInvoiceNumber        : String    ;
    Function        GetComments             : String    ;
    Procedure       SetInvoiceDate          (Const Value: TDateTime);
    Procedure       SetInvoiceNumber        (Const Value: String    );
    Procedure       SetComments             (Const Value: String    );
    function GetOrderObj: TOrderBase;
    procedure InitTransDetails;
  Public
    Class Function  GetBusObjectTablename   : String;               Override;
    Constructor     Create(AOwner           : TComponent);          Override;
    Destructor      Destroy;                                        Override;
    Procedure       LoadFromXMLNode(Const node: IXMLNode);          Override;
    Procedure       SaveToXMLNode  (Const node: IXMLNode);          Override;
    Function        GetClientName           : String    ;           Override;
    Function        GetTransDate            : TDateTime ;           Override;
    Function        GetTransNumber          : String    ;           Override;
    Function        GetTransID              : Integer   ;           Override;
    Procedure       SetClientName           (Const Value:String   );Override;
    Procedure       SetTransDate            (Const Value:TDateTime);Override;
    Procedure       SetTransNumber          (Const Value:String   );Override;
    Procedure       SetTransID              (Const Value:Integer  );Override;
    Property        OrderObj: TOrderBase Read GetOrderObj;
    Procedure   EarlyPayment;
  Protected
    Function        GetSQL                  : String;               Override;
    Procedure       DoFieldOnChange(Sender: TField);                Override;
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);      Override;
  Published
    property InvoiceDate    :TDateTime  Read GetInvoiceDate     Write SetInvoiceDate         ;
    property InvoiceNumber  :String     Read GetInvoiceNumber   Write SetInvoiceNumber       ;
    property Comments       :String     Read GetComments        Write SetComments            ;
    Function        ValidateData: Boolean ;                 Override;
  End;

  TGuiCustPaymentLines = class(TGUIPaymentLines)
  Private
    fbCheckEarlyPayment                 : Boolean;
    fInvoice :TInvoice;
    Function  GetRefNo                  : String;
    Function  getWithHolding            : Double;
    Function  GetCleanWithholding       : Double;
    Function  GetinvoiceObj             : TInvoice;
    Procedure SetRefNo                  (Const Value: String);
    Procedure SetWithHolding             (Const Value: Double);
    Function GetSplitForeignExchangeCode: String;
    Function GetSplitForeignExchangeRate: Double;
    Function GetSplitForeignPayment     : Double;
    Procedure SetSplitForeignExchangeCode(Const Value: String    );
    Procedure SetSplitForeignExchangeRate(Const Value: Double    );
    Procedure SetSplitForeignPayment     (Const Value: Double    );
    procedure InitTransDetails;
  Protected
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);  Override;
    Procedure DoFieldOnChange(Sender: TField);              Override;
    Function  GetClientName     : String    ;               Override;
    Function  GetTransDate      : TDateTime ;               Override;
    Function  GetTransNumber    : String    ;               Override;
    Function  GetTransID        : Integer   ;               Override;
    Procedure SetClientName     (Const Value:String   );    Override;
    Procedure SetTransDate      (Const Value:TDateTime);    Override;
    Procedure SetTransNumber    (Const Value:String   );    Override;
    Procedure SetTransID        (Const Value:Integer  );    Override;
    Function  GetSQL            : String;                   Override;
    Function  DoAfterPost(Sender:TDatasetBusObj)  :Boolean; Override;
    Function  DoAfterInsert(Sender:TDatasetBusObj):Boolean; Override;
  Public
    Class Function  GetBusObjectTablename       : String;   Override;
    Constructor Create(AOwner: TComponent);                 Override;
    Destructor  Destroy;                                    Override;
    Procedure   LoadFromXMLNode(Const node  : IXMLNode);    Override;
    Procedure   SaveToXMLNode(Const node    : IXMLNode);    Override;
    Function    ValidateData                : Boolean ;     Override;
    Function    PrepaymentAccountID         : Integer;
    Procedure   EarlyPayment;
    Property    Cleanwithholding            : Double        Read getcleanwithholding;
    Property    InvoiceObj                  : TInvoice      Read GetInvoiceObj;
    Procedure   CalcforeignFromSplitforeign;

  Published
    property RefNo      : String    Read GetRefNo       Write SetRefNo;
    Property Withholding: Double    Read getWithholding Write SetWithholding;
    property SplitForeignExchangeCode :String      REad getSplitForeignExchangeCode Write setSplitForeignExchangeCode;
    property SplitForeignExchangeRate :Double      Read getSplitForeignExchangeRate write setSplitForeignExchangeRate;
    property SplitForeignPayment      :Double      read getSplitForeignPayment      write setSplitForeignPayment;
  End;

  TPaymentLines = class(TMSBusObj)
  Private
    Function GetPaymentID                   : Integer   ;
    Function GetPrePaymentID                : Integer   ;
    Function GetTrnType                     : String    ;
    Function GetOriginalAmount              : Double    ;
    Function GetPayment                     : Double    ;
    Function GetAmountOutstanding           : Double    ;
    Function GetAmountDue                   : Double    ;
    Function GetPaidInFull                  : String    ;
    Function GetForeignOriginalAmt          : Double    ;
    Function GetForeignAmountDue            : Double    ;
    Function GetForeignPayment              : Double    ;
    Function GetForeignOutStanding          : Double    ;
    Function GetEnteredBy                   : String    ;
    Procedure SetPaymentID                  (Const Value: Integer   );
    Procedure SetPrePaymentID               (Const Value: Integer   );
    Procedure SetTrnType                    (Const Value: String    );
    Procedure SetOriginalAmount             (Const Value: Double    );
    Procedure SetPayment                    (Const Value: Double    );
    Procedure SetAmountOutstanding          (Const Value: Double    );
    Procedure SetAmountDue                  (Const Value: Double    );
    Procedure SetPaidInFull                 (Const Value: String    );
    Procedure SetForeignOriginalAmt         (Const Value: Double    );
    Procedure SetForeignAmountDue           (Const Value: Double    );
    Procedure SetForeignPayment             (Const Value: Double    );
    Procedure SetForeignOutStanding         (Const Value: Double    );
    Procedure SetEnteredBy                  (Const Value: String    );

  Protected
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);  Override;
    Procedure DoFieldOnChange(Sender: TField);              Override;
    Function GetSQL                              : String ; Override;
    Function DoAfterPost(Sender:TDatasetBusObj)  : Boolean; Override;
    Function DoAfterInsert(Sender:TDatasetBusObj): Boolean; Override;
    Function    GetTransDate    :TDateTime;                 Virtual; abstract;
    Function    GetTransNo      :String;                    Virtual; abstract;
    Procedure   SetTransDate    (Const Value:TDateTime);    Virtual; abstract;
    Procedure   SetTransNo      (Const Value:String);       Virtual; abstract;

  Public
    Class Function  GetIDField                   : String ; Override;
    Destructor  Destroy;                                    Override;
    Procedure   LoadFromXMLNode (Const node: IXMLNode);     Override;
    Procedure   SaveToXMLNode   (Const node: IXMLNode);     Override;
    Function    ValidateData    :Boolean ;                  Override;
    Function    Save            :Boolean ;                  Override;
    property    PaymentID       :Integer    Read GetPaymentID          Write SetPaymentID               ;

  Published
    property PrePaymentID       :Integer    Read GetPrePaymentID       Write SetPrePaymentID            ;
    property OriginalAmount     :Double     Read GetOriginalAmount     Write SetOriginalAmount          ;
    property Payment            :Double     Read GetPayment            Write SetPayment                 ;
    property AmountOutstanding  :Double     Read GetAmountOutstanding  Write SetAmountOutstanding       ;
    property AmountDue          :Double     Read GetAmountDue          Write SetAmountDue               ;
    property PaidInFull         :String     Read GetPaidInFull         Write SetPaidInFull              ;
    property ForeignOriginalAmt :Double     Read GetForeignOriginalAmt Write SetForeignOriginalAmt      ;
    property ForeignAmountDue   :Double     Read GetForeignAmountDue   Write SetForeignAmountDue          ;
    property ForeignPayment     :Double     Read GetForeignPayment     Write SetForeignPayment          ;
    property ForeignOutStanding :Double     Read GetForeignOutStanding Write SetForeignOutStanding;
    property TransDate          :TDateTime  Read GetTransDate          Write SetTransDate             ;
    property TransNo            :String     Read GetTransNo            Write SetTransNo               ;
    property TrnType            :String     Read GetTrnType            Write SetTrnType                 ;

    property EnteredBy          :String     Read GetEnteredBy          Write SetEnteredBy ;
  end;

  TCustPaymentLines = class(TPaymentLines)
  Private
    Function GetMSReceived  : Boolean   ;
    Function GetRefNo       : String    ;
    function  getSaleID     : Integer;
    Procedure SetMSReceived (Const Value: Boolean   );
    Procedure SetRefNo      (Const Value: String    );
    Procedure SetSaleID     (Const Value :Integer);
    function GetInvoiceId: integer;
    function GetRefundId: integer;
    procedure SetInvoiceId(const Value: integer);
    procedure SetSefundIf(const Value: integer);
    Function GetSplitForeignExchangeCode: String;
    Function GetSplitForeignExchangeRate: Double;
    Function GetSplitForeignPayment     : Double;
    Procedure SetSplitForeignExchangeCode(Const Value: String    );
    Procedure SetSplitForeignExchangeRate(Const Value: Double    );
    Procedure SetSplitForeignPayment     (Const Value: Double    );
  Protected
    Function  GetTransDate  : TDateTime;                Override;
    Function  GetTransNo    : String;                   Override;
    Procedure SetTransDate  (Const Value:TDateTime);    Override;
    Procedure SetTransNo    (Const Value:String);       Override;
    Procedure DoFieldOnChange(Sender: TField);          Override;
  Public
    Class Function  GetBusObjectTablename: String;      Override;
    Constructor  Create(AOwner: TComponent);            Override;
    Procedure    LoadFromXMLNode(Const node: IXMLNode); Override;
    Procedure    SaveToXMLNode(Const node: IXMLNode);   Override;
    function ValidateData: boolean; override;
    property MSReceived : Boolean   Read GetMSReceived  Write SetMSReceived              ;
  Published
    property RefNo      : String    Read GetRefNo       Write SetRefNo                   ;
    Property SaleID     : Integer   Read getSaleID      Write setSaleID;
    property RefundId: integer read GetRefundId write SetSefundIf;
    property InvoiceId: integer read GetInvoiceId write SetInvoiceId;
    property SplitForeignExchangeCode :String      REad getSplitForeignExchangeCode Write setSplitForeignExchangeCode;
    property SplitForeignExchangeRate :Double      Read getSplitForeignExchangeRate write setSplitForeignExchangeRate;
    property SplitForeignPayment      :Double      read getSplitForeignPayment      write setSplitForeignPayment;
  end;

  TSuppPaymentLines = class(TPaymentLines)
  Private
    Function GetInvoiceNo   : String    ;
    Function GetClassID     : Integer   ;
    Function GetInvoiceDate : TDateTime ;
    function getPOID        : Integer;
    Procedure SetInvoiceNo  (Const Value: String    );
    Procedure setClassID    (Const Value: Integer   );
    Procedure SetInvoiceDate(Const Value: TDateTime );
    Procedure SetPOID       (Const Value :Integer);
  Protected
    Function  GetTransDate  : TDateTime;                    Override;
    Function  GetTransNo    : String;                       Override;
    Procedure SetTransDate  (Const Value:TDateTime);        Override;
    Procedure SetTransNo    (Const Value:String);           Override;
  Public
    Class Function  GetBusObjectTablename: String;          Override;
    Constructor     Create(AOwner: TComponent);             Override;
    Procedure       LoadFromXMLNode(Const node: IXMLNode);  Override;
    Procedure       SaveToXMLNode(Const node: IXMLNode);    Override;
    function ValidateData: boolean; override;
  Published
    property InvoiceNo  :String     Read GetInvoiceNo   Write SetInvoiceNo               ;
    property ClassID    :Integer    Read GetClassID     Write setClassID                 ;
    property InvoiceDate:TDateTime  Read GetInvoiceDate Write SetInvoiceDate             ;
    Property POID       : Integer   Read getPOID        Write SetPOID;
  end;

  TPayments = class(TMSBusObj)
  private
    fsGuiTablename          : String;
    fsLockMsg               : String;
    fChangeDisplayLabel     : TGeneralProc;
    fdPrepaymentAmount      : Double;
    fsSalePOIDs             : String;
    fsPrepayIDS             : String;
    fiselectedLines         : Integer;
    fbBulkPayment           : Boolean;
    fbSelectingAll: boolean;
    fbGUIMode: Boolean;
    fbDisableCalcOrderTotals: Boolean;
    Function GetPaymentNo                   : Integer   ;
    Function GetEmployeeID                  : Integer   ;
    Function GetPaymentDate                 : TDateTime ;
    Function GetAmount                      : Double    ;
    Function GetPayMethodID                 : Integer   ;
    Function GetNotes                       : String    ;
    Function GetReferenceNo                 : String    ;
    Function GetCardholdersName             : String    ;
    Function GetCreditCardNumber            : String    ;
    Function GetCreditCardExpDate           : TDateTime ;
    Function GetPrintFlag                   : Boolean   ;
    Function GetPrintedBy                   : Integer   ;
    Function GetClassID                     : Integer   ;
    Function GetAccountID                   : Integer   ;
    Function GetCustomer                    : Boolean   ;
    Function GetSupplier                    : Boolean   ;
    Function GetEmployee                    : Boolean   ;
    Function GetContact                     : Boolean   ;
    Function GetCompanyName                 : String    ;
    Function GetClientPrintName             : String    ;
    Function GetAppliedCredits              : Boolean   ;
    Function GetDeleted                     : Boolean   ;
    Function GetReconciled                  : Boolean   ;
    Function GetAmountDue                   : Double    ;
    Function GetCredit                      : Double    ;
    Function GetUnApplied                   : Double    ;
    Function GetApplied                     : Double    ;
    Function GetReconciliationID            : Integer   ;
    Function GetFinished                    : Boolean   ;
    Function GetStatement                   : Integer   ;
    Function GetMSReceived                  : Boolean   ;
    Function GetForeignExchangeRate         : Double    ;
    Function GetForeignExchangeCode         : String    ;
    Function GetForeigncurrencyAmount       : Double    ;
    Function GetBankAccountName             : String    ;
    Function GetBankAccountBSB              : String    ;
    Function GetBankAccountNo               : String    ;
    Function GetForeignVariationAccountID   : Integer   ;
    Function GetForeignVariationAmount      : Double    ;
    Function GetForeignUnApplied            : Double    ;
    Function GetForeignApplied              : Double    ;
    Function getFullyApplied                : Boolean   ;
    Function getAnyPaymentsApplied          : Boolean   ;
    Function getIsFCSelected                : Boolean   ;
    function GetcleanDeleted                : Boolean   ;
    Function getclient                      : TClient;
    function GetGLAccount                   : TAccount  ;
    Function getBankDeposit                 : TBankDeposit;
    Function getReconcilations              (Const TransLockType:TTransLockType):Boolean; Virtual; abstract;
    Function getpayMethod                   : TPaymentMethod;
    function GetselectedLines               : Integer;
    Procedure SetPaymentNo                  (Const Value: Integer   );
    Procedure SetEmployeeID                 (Const Value: Integer   );
    Procedure SetPaymentDate                (Const Value: TDateTime );
    Procedure SetAmount                     (Const Value: Double    );
    Procedure SetPayMethodID                (Const Value: Integer   );
    Procedure SetNotes                      (Const Value: String    );
    Procedure SetReferenceNo                (Const Value: String    );
    Procedure SetCardholdersName            (Const Value: String    );
    Procedure SetCreditCardNumber           (Const Value: String    );
    Procedure SetCreditCardExpDate          (Const Value: TDateTime );
    Procedure SetPrintFlag                  (Const Value: Boolean   );
    Procedure SetPrintedBy                  (Const Value: Integer   );
    Procedure setClassID                    (Const Value: Integer   );
    Procedure SetAccountID                  (Const Value: Integer   );
    Procedure SetCustomer                   (Const Value: Boolean   );
    Procedure SetSupplier                   (Const Value: Boolean   );
    Procedure SetEmployee                   (Const Value: Boolean   );
    Procedure SetContact                    (Const Value: Boolean   );
    Procedure SetCompanyName                (Const Value: String    );
    Procedure SetClientPrintName            (Const Value: String    );
    Procedure SetAppliedCredits             (Const Value: Boolean   );
    Procedure SetDeleted                    (Const Value: Boolean   );
    Procedure SetReconciled                 (Const Value: Boolean   );
    Procedure SetAmountDue                  (Const Value: Double    );
    Procedure SetCredit                     (Const Value: Double    );
    Procedure SetUnApplied                  (Const Value: Double    );
    Procedure SetApplied                    (Const Value: Double    );
    Procedure SetReconciliationID           (Const Value: Integer   );
    Procedure SetFinished                   (Const Value: Boolean   );
    Procedure SetStatement                  (Const Value: Integer   );
    Procedure SetMSReceived                 (Const Value: Boolean   );
    Procedure SetForeignExchangeRate        (Const Value: Double    );
    Procedure SetForeignExchangeCode        (Const Value: String    );
    Procedure SetForeigncurrencyAmount      (Const Value: Double    );
    Procedure SetBankAccountName            (Const Value: String    );
    Procedure SetBankAccountBSB             (Const Value: String    );
    Procedure SetBankAccountNo              (Const Value: String    );
    Procedure SetForeignVariationAccountID  (Const Value: Integer   );
    Procedure SetForeignVariationAmount     (Const Value: Double    );
    Procedure SetForeignUnApplied           (Const Value: Double    );
    Procedure SetForeignApplied             (Const Value: Double    );
    Procedure CallbackPrepaymentamount      (Const Sender: TBusObj; var Abort: Boolean);
    Procedure CallbackSelectAll             (Const Sender: TBusObj; var Abort: Boolean);
    Procedure CallBackselectedLines         (Const Sender: TBusobj; Var abort: Boolean);
    function getEnteredAt: TDateTime;
    procedure setEnteredAt(const Value: TDateTime);
    procedure ShowProgressbar(ProgressCount: integer; ProgressBarCaption: string; ProgressBarMessage: string = '';IsPercenage:boolean =true);
    procedure StepProgressbar(const ProgressBarMessage:String = '');
    procedure HideProgressbar;
    function GetTenderAccountPrefs: TTenderAccountPrefs;
    function GetEmployeeName: string;
    procedure SetEmployeeName(const Value: string);
    function GetDeptClassName: string;
    procedure SetDeptClassName(const Value: string);
    function GetAccountName: string;
    procedure SetAccountName(const Value: string);
    function GetForeignVariationAccountName: string;
    procedure SetForeignVariationAccountName(const Value: string);
    function GetPayMethodName: string;
    procedure SetPayMethodName(const Value: string);

  Protected
    AllLinesValid                           : Boolean   ;
    AllGuiLinesValid: boolean;
    fdTotalwithholding  : Double;
    fdTotalRefunding    : Double;
    fdTotalDiscount     : Double;
    fdTotalAmount       : Double;
    fsBulkPaymentIDs    : String;
    procedure DoOnUserLockOnUnlockItem(sender: TObject);
    Procedure OnDataIdChange (Const ChangeType: TBusObjDataChangeType); Override;
    Procedure DoFieldOnChange(Sender: TField);                  Override;
    Function  DoAfterPost    (Sender: TDatasetBusObj): Boolean; Override;
    Function  DoAfterInsert  (Sender: TDatasetBusObj): Boolean; Override;
    Function  GetClientID           : Integer   ;               virtual;Abstract;
    Function  GetPayment            : Boolean   ;               virtual;Abstract;
    Function  GetGUIPaymentLines    : TGUIPaymentLines;         Virtual;Abstract;
    Function  GetTransactionsChanged: Boolean;                  Virtual;Abstract;
    Function  GetSQL                : String;                   Override;
    function  getExchageBuyRate     : Double;
    function  getExchageSellRate    : Double;
    Function  GetPrepaymentAmount   : Double;
    Procedure SetClientID           (Const Value: Integer   );  virtual;Abstract;
    Procedure SetPayment            (Const Value: Boolean   );  virtual;Abstract;
    Procedure CallbackCalcTotals    (Const Sender: TBusObj; var Abort: Boolean); virtual;
    Function  setTenderAccountID:Boolean;
    procedure InitializeNewObject; override;
    function getUseFC                       : Boolean; virtual;
    Procedure AssignProgressdialog(const xPostList: TPostList);Override;
    procedure CallbackValidateGuiLines(const Sender: TBusObj; var Abort: Boolean); virtual;
    function ValidateGuiLines: boolean;
    Function  getTotalRefunding             : Double;
    Procedure CallbacktotalRefunding        (Const Sender: TBusObj; var Abort: Boolean);

  Public
    Qrybulkpay          : TERPQuery;
    ValidationStage: integer;
    Class function  GetTranstype          : String;             Virtual;Abstract;
    Class Function  GetIDField      : String;                   Override;
    Procedure   Load(const fIsReadonly:boolean =False);override;
    Procedure   RefreshguiLines;                        virtual;Abstract;
    Constructor Create(AOwner: TComponent);             Override;
    Destructor  Destroy;                                Override;
    Procedure   LoadFromXMLNode(Const node: IXMLNode);  Override;
    Procedure   SaveToXMLNode(Const node: IXMLNode);    Override;
    Function    ValidateData        : Boolean ;         Override;
    Function    Save                : Boolean ;         Override;
    Function    Lock                : Boolean ;         Override;
    //Property    GUILines            : TGUIPaymentLines  Read getGUIPaymentLines;
    Property    GuiTablename        : String            Read fsGuiTablename     Write fsGuiTablename;
    Property    LockMsg             : String            Read fsLockMsg          Write fsLockMsg;
    Property    FullyApplied        : Boolean           Read getFullyApplied;
    Property    AnyPaymentsApplied  : Boolean           Read getAnyPaymentsApplied;
    Property    IsFCSelected        : Boolean           Read getIsFCSelected;
    Property    UseFC               : Boolean           Read getUseFC;
    Property    client              : Tclient           Read getclient;
    Property    GLAccount           : TAccount          Read GetGLAccount;
    Property    Transtype           : String            Read getTransType;
    Property    TransactionsChanged : Boolean           Read getTransactionsChanged;
    Property    cleanDeleted        : Boolean           Read getcleanDeleted;
    Property    ChangeDisplayLabel  : TGeneralProc      Read fChangeDisplayLabel Write fChangeDisplayLabel;
    Property    Bankdeposit         : TBankDeposit      Read getBankDeposit;
    Property    SalePOIDs           : String            Read fsSalePOIDs        Write fsSalePOIDs;
    Property    PrepayIDS           : String            Read fsPrepayIDS        Write fsPrepayIDS;
    Property    PaymentMethod       : TPaymentMethod    read getpayMethod;
    Property    BulkPaymentIDs      : String            Read fsBulkPaymentIDs;
    Property    selectedLines       : Integer           Read getselectedLines;
    Function    PaymentReconciled   : Boolean;
    Property    GUIMode : Boolean read  fbGUIMode write fbGUIMode;
    Function    PaymentOnHold       : Boolean;
    Procedure   CalcTotals(const AdjustAmount: boolean = false);
    function    DoBulkPay(Const strSQL,fsPaymethod,Payclass:String; Const fdPaydate :TDatetime; Const BankAccountID :Integer; chequeno:String =''):Boolean;overload;
    property TenderAccountPrefs: TTenderAccountPrefs read GetTenderAccountPrefs;
    property CardholdersName            : String    Read GetCardholdersName             Write SetCardholdersName          ;
    property CreditCardNumber           : String    Read GetCreditCardNumber            Write SetCreditCardNumber         ;
    property CreditCardExpDate          : TDateTime Read GetCreditCardExpDate           Write SetCreditCardExpDate        ;
    property MSReceived                 : Boolean   Read GetMSReceived                  Write SetMSReceived               ;
    Property    TotalRefunding      : Double            Read getTotalRefunding;
    Property SelectingAll :boolean read fbSelectingAll write fbSelectingAll;
    Procedure SelectAll;
    Property IsBulkPayment :boolean read fbBulkPayment write fbBulkPayment;
    Property DisableCalcOrderTotals :Boolean read fbDisableCalcOrderTotals write fbDisableCalcOrderTotals;
    procedure DoCalcOrderTotals;

  Published
    property PaymentNo                  : Integer   Read GetPaymentNo                   Write SetPaymentNo                ;
    property EmployeeID                 : Integer   Read GetEmployeeID                  Write SetEmployeeID               ;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property ClientID                   : Integer   Read GetClientID                    Write SetClientID                    ;
    property PaymentDate                : TDateTime Read GetPaymentDate                 Write SetPaymentDate              ;
    property Amount                     : Double    Read GetAmount                      Write SetAmount                   ;
    property PayMethodID                : Integer   Read GetPayMethodID                 Write SetPayMethodID              ;
    property PayMethodName: string read GetPayMethodName write SetPayMethodName;
    property Notes                      : String    Read GetNotes                       Write SetNotes                    ;
    property ReferenceNo                : String    Read GetReferenceNo                 Write SetReferenceNo              ;
    property PrintFlag                  : Boolean   Read GetPrintFlag                   Write SetPrintFlag                ;
    property PrintedBy                  : Integer   Read GetPrintedBy                   Write SetPrintedBy                ;
    property ClassID                    : Integer   Read GetClassID                     Write setClassID                  ;
    property DeptClassName: string read GetDeptClassName write SetDeptClassName;
    property AccountID                  : Integer   Read GetAccountID                   Write SetAccountID                ;
    property AccountName: string   Read GetAccountName Write SetAccountName;
    property Customer                   : Boolean   Read GetCustomer                    Write SetCustomer                 ;
    property Supplier                   : Boolean   Read GetSupplier                    Write SetSupplier                 ;
    property Employee                   : Boolean   Read GetEmployee                    Write SetEmployee                 ;
    property Contact                    : Boolean   Read GetContact                     Write SetContact                  ;
    property Payment                    : Boolean   Read GetPayment                     Write SetPayment                  ;
    property CompanyName                : String    Read GetCompanyName                 Write SetCompanyName              ;
    property ClientPrintName            : String    Read GetClientPrintName             Write SetClientPrintName          ;
    property AppliedCredits             : Boolean   Read GetAppliedCredits              Write SetAppliedCredits           ;
    property Deleted                    : Boolean   Read GetDeleted                     Write SetDeleted                  ;
    property Reconciled                 : Boolean   Read GetReconciled                  Write SetReconciled               ;
    property AmountDue                  : Double    Read GetAmountDue                   Write SetAmountDue                  ;
    property Credit                     : Double    Read GetCredit                      Write SetCredit                   ;
    property UnApplied                  : Double    Read GetUnApplied                   Write SetUnApplied                ;
    property Applied                    : Double    Read GetApplied                     Write SetApplied                  ;
    property ReconciliationID           : Integer   Read GetReconciliationID            Write SetReconciliationID         ;
    property Finished                   : Boolean   Read GetFinished                    Write SetFinished                 ;
    property Statement                  : Integer   Read GetStatement                   Write SetStatement                ;
    property BankAccountName            : String    Read GetBankAccountName             Write SetBankAccountName          ;
    property BankAccountBSB             : String    Read GetBankAccountBSB              Write SetBankAccountBSB           ;
    property BankAccountNo              : String    Read GetBankAccountNo               Write SetBankAccountNo            ;
    property ForeignExchangeRate        : Double    Read GetForeignExchangeRate         Write SetForeignExchangeRate      ;
    property ForeignExchangeCode        : String    Read GetForeignExchangeCode         Write SetForeignExchangeCode      ;
    property ForeigncurrencyAmount      : Double    Read GetForeigncurrencyAmount       Write SetForeigncurrencyAmount    ;
    property ForeignVariationAccountID  : Integer   Read GetForeignVariationAccountID   Write SetForeignVariationAccountID;
    property ForeignVariationAccountName: string read GetForeignVariationAccountName write SetForeignVariationAccountName;
    property ForeignVariationAmount     : Double    Read GetForeignVariationAmount      Write SetForeignVariationAmount   ;
    property ForeignUnApplied           : Double    Read GetForeignUnApplied            Write SetForeignUnApplied         ;
    property ForeignApplied             : Double    Read GetForeignApplied              Write SetForeignApplied           ;
    Property EnteredAt                  : TDateTime Read getEnteredAt           Write setEnteredAt;
    Property GUILines                   : TGUIPaymentLines  Read GetGUIPaymentLines;
  end;

  TSuppPayments = class(TPayments)
  private
    fbAddToEFT                   : Boolean;
    fbAInvalid4EFT               : Boolean;
    fbCInvalid4EFT               : boolean;
    fGetEFTDetails               : TGeneralProc;
    LastSupplierID: integer;
    fbDiscountApplied: Boolean;
    fUpdatedPOList: TIntegerList;
    fiOpenForOrderId: Integer;
    fDoEarlyPayment: TGeneralProc;
    Function GetInvoiceRefNo     : String    ;
    Function GetCheque           : Boolean   ;
    Function GetChequePrinted    : Boolean   ;
    Function getPaymentLines     : TSuppPaymentLines;
    Function  getABAObj          : TABADetailRecord;
    Procedure SetInvoiceRefNo    (Const Value: String    );
    Procedure SetCheque          (Const Value: Boolean   );
    Procedure SetChequePrinted   (Const Value: Boolean   );
    Procedure SetAddtoEFT        (Const Value: Boolean   );
    Procedure CallbackCreateLines(Const Sender: TBusObj; var Abort: Boolean);
    Procedure CallbackUpdateLines(Const Sender: TBusObj; var Abort: Boolean);
    Procedure UpdateclientBalance(Const Sender: TBusObj; var Abort: Boolean);
    Procedure Createlines;
    Procedure UpdateLines;
    Procedure udpateBalance;

    Procedure CorrectOtherPayments;
    Procedure CreateDeposits;
    Procedure UpdateLastChequeNo;
    Procedure ValidateFCofapplied(Const Sender: TBusObj; var Abort: Boolean);
    Function getReconcilations(Const TransLockType:TTransLockType):Boolean; Override;
    procedure CallbackLock(Const Sender: TBusObj; var Abort: Boolean);
    function GetTotalDiscount: Double;
    Procedure CallBackAddDiscountToOrder     (Const Sender: TBusObj; var Abort: Boolean);
    Function  AddOrderLine(Const fOrderObj: TOrderBase; Const ProductName :String; Const Price ,Qty :Double; var msg: string) :Boolean;
    Function  AddBillLine(Const fOrderObj: TOrderBase; Const AccountName: String; Const CostInc: Double; var msg: string): Boolean;
    function GetContractorPayment: boolean;
    procedure SetContractorPayment(const Value: boolean);
    function MakeCredit(const fOrderObj: TOrderBase; const Price, Qty: Double; IsEarlyPaymentDiscount: boolean; var msg: string): Boolean;
    procedure POOutStandingTrans(var QrySource: TERPQuery; aPOtype:String = ''; aPOID:Integer = 0);
    procedure POPaymentLines(var QrySource: TERPQuery);

  Protected
    Function  DoAfterInsert(Sender      : TDatasetBusObj): Boolean;                 Override;
    Function  GetClientID               : Integer   ;                               Override;
    Function  GetPayment                : Boolean   ;                               Override;
    Function  GetGUIPaymentLines        : TGUIPaymentLines;                         Override;
    Function  GetTransactionsChanged    : Boolean;                                  Override;
    Procedure SetClientID               (Const Value: Integer   );                  Override;
    Procedure SetPayment                (Const Value: Boolean   );                  Override;
    Procedure DoFieldOnChange           (Sender: TField);                           Override;
    Procedure OnDataIdChange            (Const ChangeType: TBusObjDataChangeType);  Override;
    function  getUseFC                  : Boolean; override;
    procedure CallbackValidateLines(const Sender: TBusObj; var Abort: Boolean);
    function  ValidateLines: boolean;
    Procedure CallbackCalcTotals(const Sender: TBusObj; var Abort: Boolean); override;

  Public
    Class function  GetTranstype              : String;                             Override;
    Class Function GetBusObjectTablename: String;                                   Override;
    Procedure RefreshguiLines;                                                      Override;
    Constructor Create(AOwner          : TComponent);               Override;
    destructor Destroy; override;
    Procedure LoadFromXMLNode        (Const node     : IXMLNode); Override;
    Procedure SaveToXMLNode          (Const node     : IXMLNode); Override;
    function  ValidateData           : Boolean ;                  Override;
    Function  Save                   : boolean ;                  Override;
    Function  Lock                   : Boolean ;                  Override;
    Procedure CreateABARecord;
    Procedure UpdateFCHistory;
    Function  Payapproved            : boolean;
    Function  Valid4EFT              (OpenDetailform : Boolean= False)   : Boolean;
    Function  Valid4Email            : Boolean;
    Property  AddToEFT               : boolean           Read fbAddToEFT         Write setAddtoeft;
    Property  BankAccountInvalid4EFT : Boolean           Read fbAInvalid4EFT     Write fbAInvalid4EFT;
    Property  ClientInvalid4EFT      : Boolean           Read fbCInvalid4EFT     Write fbCInvalid4EFT;
    Property  GetEFTDetails          : TGeneralProc      Read fGetEFTDetails     Write fGetEFTDetails;
    Property  ABAObj                 : TABADetailRecord  Read getABAObj;
    Procedure updateBankdeposit(forceDeletion:Boolean =False);
    Property TotalDiscount: Double read GetTotalDiscount;
    function AddDiscountToOrder(var msg: string): Boolean;
    property UpdatedPOList: TIntegerList read fUpdatedPOList;
    procedure New; override;
    Property OpenForOrderId :Integer read fiOpenForOrderId write fiOpenForOrderId;
    Property DoEarlyPayment: TGeneralProc read fDoEarlyPayment write fDoEarlyPayment;

  Published
    Property Lines            : TSuppPaymentLines Read getPaymentLines;
    property InvoiceRefNo     : String    Read GetInvoiceRefNo  Write SetInvoiceRefNo             ;
    property Cheque           : Boolean   Read GetCheque        Write SetCheque                   ;
    property ChequePrinted    : Boolean   Read GetChequePrinted Write SetChequePrinted           ;
    property DiscountApplied  : Boolean   Read fbDiscountApplied      Write fbDiscountApplied;
    property ContractorPayment: boolean   Read GetContractorPayment write SetContractorPayment;
  end;

  TCustPayments = class(TPayments)
  private
    fbDiscountApplied                       : Boolean   ;
    fbSurchargeApplied : boolean;
    fbAutoApplyDiscount                     : Boolean;
    ISNew                                   : Boolean;
    fDoEarlyPayment                         : TGeneralproc;
    fUpdatedSalesList: TIntegerList;
    LastCustID: integer;
    fiOpenForSalesId: Integer;
    fSurchargePercent: double;
    Function  GetSplitPaymentID             : Integer   ;
    Function  GetSplitPaymentLineID         : Integer   ;
    Function  GetDeposit                    : Boolean   ;
    Function  GetDeposited                  : Boolean   ;
    Function  GetDepositedBalance           : Double    ;
    Function  GetDepositID                  : Integer   ;
    Function  getTotalDiscount              : Double;
    Function  getTotalwithHolding           : Double;
    Function  getTotalLinesamount           : double;
    Function  getPaymentLines               : TcustPaymentLines;
    Procedure SetSplitPaymentID             (Const Value: Integer   );
    Procedure SetSplitPaymentLineID         (Const Value: Integer   );
    Procedure SetDeposit                    (Const Value: Boolean   );
    Procedure SetDeposited                  (Const Value: Boolean   );
    Procedure SetDepositedBalance           (Const Value: Double    );
    Procedure SetDepositID                  (Const Value: Integer   );
    Procedure CallBackAddDiscounttoSale     (Const Sender: TBusObj; var Abort: Boolean);
    Procedure CallBackAddSurchargeToSale    (Const Sender: TBusObj; var Abort: Boolean);
    Procedure CallbackLock                  (Const Sender: TBusObj; var Abort: Boolean);
    Procedure CallbackCreateLines           (Const Sender: TBusObj; var Abort: Boolean);
    Procedure CallbackUpdateLines           (Const Sender: TBusObj; var Abort: Boolean);
    Procedure UpdateclientBalance           (Const Sender: TBusObj; var Abort: Boolean);
    Procedure ValidateFCofapplied           (Const Sender: TBusObj; var Abort: Boolean);
    Procedure CreateLines;
    Procedure UpdateLines;
    Procedure udpateBalance;
    Procedure CreateDeposits;
    Procedure CorrectOtherPayments;
    Function  AddSalesLine(Const fInvoiceObj :TInvoice; Const ProductName :String; Const Price ,Qty :Double; msg: string) :Boolean;
    Function getReconcilations(Const TransLockType:TTransLockType):Boolean; Override;
    function MakeRefund(const fInvoiceObj: TInvoice; const Price, Qty: Double; IsEarlyPaymentDiscount: boolean; var msg: string): Boolean;
    function GetCleanDeposited: boolean;
    procedure SalesOutStandingTrans(var QrySource: TERPQuery; aSaleType:String= '' ; aTransId :Integer=0);
    procedure SalesPaymentLines(var QrySource: TERPQuery);

  Protected
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);      Override;
    Function  DoAfterInsert(Sender: TDatasetBusObj): Boolean;               Override;
    Procedure CallbackCalcTotals(Const Sender: TBusObj; var Abort: Boolean);Override;
    Procedure DoFieldOnChange(Sender: TField);          Override;
    Function  GetClientID  : Integer   ;                Override;
    Function  GetPayment   : Boolean   ;                Override;
    Procedure SetClientID  (Const Value: Integer   );   Override;
    Procedure SetPayment   (Const Value: Boolean   );   Override;
    Function  GetGUIPaymentLines :TGUIPaymentLines;     Override;
    Function  GetTransactionsChanged: Boolean;          Override;
    function getUseFC                    : Boolean; override;
    procedure CallbackValidateLines(const Sender: TBusObj; var Abort: Boolean);
    function ValidateLines: boolean;

  Public
    Class function  GetTranstype          : String;     Override;
    Class Function  GetBusObjectTablename :String;      Override;
    Procedure   RefreshguiLines;                        Override;
    Constructor Create(AOwner: TComponent);             Override;
    destructor Destroy; override;
    Procedure   LoadFromXMLNode(Const node: IXMLNode);  Override;
    Procedure   SaveToXMLNode(Const node: IXMLNode);    Override;
    Function    Lock                : Boolean ;         Override;
    Procedure   UpdateFCHistory;
    function    AddDiscountToSale(var msg: string)   : Boolean;
    function    AddSurchargeToSale(const Percent: double): Boolean;
    function    Save                : Boolean;          Override;
    function    ValidateData        : Boolean;          Override;
    function    IsPaymentDeposited  : Boolean;
    Property    TotalDiscount       : Double            Read getTotalDiscount;
    Property    TotalWithholding    : Double            Read getTotalWithholding;
    Property    TotalLinesAmount    : Double            Read getTotalLinesamount;
    Property    DoEarlyPayment      : TGeneralProc      Read fDoEarlyPayment    Write fDoEarlyPayment;
    property UpdatedSalesList: TIntegerList read fUpdatedSalesList;
    procedure New; override;
    Property OpenForSalesId :Integer read fiOpenForSalesId write fiOpenForSalesId;
    property CleanDeposited: boolean read GetCleanDeposited;
    Procedure updateBankdeposit(forceDeletion:Boolean =False);

  Published
    Property Lines              : TcustPaymentLines Read getPaymentLines;
    property SplitPaymentID     : Integer   Read GetSplitPaymentID      Write SetSplitPaymentID           ;
    property SplitPaymentLineID : Integer   Read GetSplitPaymentLineID  Write SetSplitPaymentLineID       ;
    property Deposit            : Boolean   Read GetDeposit             Write SetDeposit         ;
    property Deposited          : Boolean   Read GetDeposited           Write SetDeposited       ;
    property DepositedBalance   : Double    Read GetDepositedBalance    Write SetDepositedBalance;
    property DepositID          : Integer   Read GetDepositID           Write SetDepositID       ;
    property DiscountApplied    : Boolean   Read fbDiscountApplied      Write fbDiscountApplied;
    property SurchargeApplied: boolean read fbSurchargeApplied write fbSurchargeApplied;
    Property AutoApplyDiscount  : Boolean   Read fbAutoApplyDiscount    Write fbAutoApplyDiscount;
  end;

  TSupplierPayments = class(TSuppPayments)
  end;

  TCustomerPayments = class(TCustPayments)
  end;

implementation

uses CommonDbLib, Sysutils, AppEnvironment,
  ForeignExchangeObj, MySQLConst, tcConst, dialogs, controls,
  Variants, BusObjTrans, tcDataUtils, CommonLib, TransLockManagementObj,
  BusObjConst, Math, ProgressDialog, PaymentsLib, JsonObject, BusobjCash,
  BusObjEmployee, BusObjClass, Forms, DbSharedObjectsObj, TempTableUtils,
  CardPaymentObj, BusObjOrders, BusObjExpenses, BusObjStock, SystemLib;

var
  GuiCustPaymentLinesTablename: string;
  GuiSuppPaymentLinesTablename: string;

{TPayments}

Constructor TPayments.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fbDisableCalcOrderTotals := False;
  fChangeDisplayLabel := nil;
  Qrybulkpay := nil;
  fbBulkPayment := False;
  ExportExcludeList.Add('employeeid');
  ExportExcludeList.Add('classid');
  ExportExcludeList.Add('accountid');
  ExportExcludeList.Add('printedby');
  ExportExcludeList.Add('printflag');
  ExportExcludeList.Add('foreignvariationaccountid');
  ExportExcludeList.Add('customer');
  ExportExcludeList.Add('supplier');
  ExportExcludeList.Add('employee');
  ExportExcludeList.Add('contact');
  ExportExcludeList.Add('clientid');
  ExportExcludeList.Add('paymethidid');
  SelectingAll := false;
  fbGUIMode := False;
end;

Procedure   TPayments.Load(const fIsReadonly:boolean =False);
begin
    inherited Load(fIsReadonly);
    RefreshguiLines;
end;

Destructor TPayments.Destroy;
begin
  inherited;
end;
Function TPayments.setTenderAccountID:Boolean;
var
    strSQL:String;
begin
    Result := False;
    strSQL:= 'SELECT  tbltenderaccountprefs.AccountId ' +
            ' FROM tbltenderaccountprefs  ' +
            ' INNER JOIN tblchartofaccounts COA USING(AccountID) ' +
            ' WHERE tbltenderaccountprefs.Active="T"  ' +
            ' AND COA.Active="T"  ' +
            ' AND PaymethodID = ' + IntToStr(PaymethodID);
   with getNewDataset(strSQL) do try
        if (recordcount = 1) and (fieldbyname('AccountID').asInteger <> 0) then begin
            AccountID:= FieldByname('AccountID').ASInteger;
            Result := True;
        end;
   finally
        if Active then close;
        Free;
   end;
end;
Procedure TPayments.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PaymentNo');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'PaymentDate');
  SetPropertyFromNode(node,'Amount');
  SetPropertyFromNode(node,'PayMethodID');
  SetPropertyFromNode(node,'Notes');
  SetPropertyFromNode(node,'ReferenceNo');
  SetPropertyFromNode(node,'CardholdersName');
  SetPropertyFromNode(node,'CreditCardNumber');
  SetPropertyFromNode(node,'CreditCardExpDate');
  SetPropertyFromNode(node,'PrintFlag');
  SetPropertyFromNode(node,'PrintedBy');
  SetPropertyFromNode(node,'ClassID');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'Customer');
  SetPropertyFromNode(node,'Supplier');
  SetPropertyFromNode(node,'Employee');
  SetPropertyFromNode(node,'Contact');
  SetPropertyFromNode(node,'CompanyName');
  SetPropertyFromNode(node,'ClientPrintName');
  SetPropertyFromNode(node,'AppliedCredits');
  SetPropertyFromNode(node,'Deleted');
  SetPropertyFromNode(node,'Reconciled');
  SetPropertyFromNode(node,'AmountDue');
  SetPropertyFromNode(node,'Credit');
  SetPropertyFromNode(node,'UnApplied');
  SetPropertyFromNode(node,'Applied');
  SetPropertyFromNode(node,'ReconciliationID');
  SetPropertyFromNode(node,'Finished');
  SetPropertyFromNode(node,'Statement');
  SetPropertyFromNode(node,'MSReceived');
  SetPropertyFromNode(node,'ForeignExchangeRate');
  SetPropertyFromNode(node,'ForeignExchangeCode');
  SetPropertyFromNode(node,'ForeignCurrencyAmount');
  SetPropertyFromNode(node,'BankAccountName');
  SetPropertyFromNode(node,'BankAccountBSB');
  SetPropertyFromNode(node,'BankAccountNo');
  SetPropertyFromNode(node,'ForeignVariationAccountID');
  SetPropertyFromNode(node,'ForeignVariationAmount');
  SetPropertyFromNode(node,'ForeignUnApplied');
  SetPropertyFromNode(node,'ForeignApplied');
  SetPropertyFromNode(node,'ClientID');
  SetPropertyFromNode(node,'Payment');

end;


Procedure TPayments.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PaymentNo'                ,PaymentNo);
  AddXMLNode(node,'EmployeeID'               ,EmployeeID);
  AddXMLNode(node,'PaymentDate'              ,PaymentDate);
  AddXMLNode(node,'Amount'                   ,Amount);
  AddXMLNode(node,'PayMethodID'              ,PayMethodID);
  AddXMLNode(node,'Notes'                    ,Notes);
  AddXMLNode(node,'ReferenceNo'              ,ReferenceNo);
  AddXMLNode(node,'CardholdersName'          ,CardholdersName);
  AddXMLNode(node,'CreditCardNumber'         ,CreditCardNumber);
  AddXMLNode(node,'CreditCardExpDate'        ,CreditCardExpDate);
  AddXMLNode(node,'PrintFlag'                ,PrintFlag);
  AddXMLNode(node,'PrintedBy'                ,PrintedBy);
  AddXMLNode(node,'ClassID'                  ,ClassID);
  AddXMLNode(node,'AccountID'                ,AccountID);
  AddXMLNode(node,'Customer'                 ,Customer);
  AddXMLNode(node,'Supplier'                 ,Supplier);
  AddXMLNode(node,'Employee'                 ,Employee);
  AddXMLNode(node,'Contact'                  ,Contact);
  AddXMLNode(node,'CompanyName'              ,CompanyName);
  AddXMLNode(node,'ClientPrintName'          ,ClientPrintName);
  AddXMLNode(node,'AppliedCredits'           ,AppliedCredits);
  AddXMLNode(node,'Deleted'                  ,Deleted);
  AddXMLNode(node,'Reconciled'               ,Reconciled);
  AddXMLNode(node,'AmountDue'                ,AmountDue);
  AddXMLNode(node,'Credit'                   ,Credit);
  AddXMLNode(node,'UnApplied'                ,UnApplied);
  AddXMLNode(node,'Applied'                  ,Applied);
  AddXMLNode(node,'ReconciliationID'         ,ReconciliationID);
  AddXMLNode(node,'Finished'                 ,Finished);
  AddXMLNode(node,'Statement'                ,Statement);
  AddXMLNode(node,'MSReceived'               ,MSReceived);
  AddXMLNode(node,'ForeignExchangeRate'      ,ForeignExchangeRate);
  AddXMLNode(node,'ForeignExchangeCode'      ,ForeignExchangeCode);
  AddXMLNode(node,'ForeigncurrencyAmount'    ,ForeigncurrencyAmount);
  AddXMLNode(node,'BankAccountName'          ,BankAccountName);
  AddXMLNode(node,'BankAccountBSB'           ,BankAccountBSB);
  AddXMLNode(node,'BankAccountNo'            ,BankAccountNo);
  AddXMLNode(node,'ForeignVariationAccountID',ForeignVariationAccountID);
  AddXMLNode(node,'ForeignVariationAmount'   ,ForeignVariationAmount);
  AddXMLNode(node,'ForeignUnApplied'         ,ForeignUnApplied);
  AddXMLNode(node,'ForeignApplied'           ,ForeignApplied);
  AddXMLNode(node,'ClientID'                 ,ClientID);
  AddXMLNode(node,'Payment'                  ,Payment);

end;


Function TPayments.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  if IsFCSelected then begin
    if not Math.SameValue(Applied, amount - ForeignVariationAmount, 0.00001) then begin
      AddResult(False, rssWarning, 0,'Applied amount should equal payment amount less variation amount');
      Result := False;
      Exit;
    end;
  end else begin
    if not Math.SameValue(Applied,amount,0.00001) then begin
      AddResult(False, rssWarning, 0,'Applied amount and the payment amount should be equal');
      Result := False;
      Exit;
    end;
  end;

  if Self.ClassID < 1 then begin
    AddResult(false, rssInfo,0,AppEnv.DefaultClass.ClassHeading + ' is missing or not found.');
    Result:= false;
    exit;
  end;

  if (selectedLines = 0) and (not Deleted) then begin
    AddResult(False, rssWarning, 0, 'None of the transaction is selected to Pay.');
    Result := False;
    Exit;
  end;

  if Self.Deleted and self.Reconciled then begin
    AddResult(False, rssWarning, 0 ,'Can not delete a reconciled payment.');
    Result := False;
    Exit;
  end;
  Result := ValidateGuiLines;
end;

function  TPayments.getExchageSellRate            : Double;
var
    BuyRate, SellRate:Double;
begin
    With TForeignExchangeObj.Create do Try
        GetForeignExchangeRatesForDate(ForeignExchangeCode, PaymentDate, BuyRate, SellRate);
        Result := SellRate;
    finally
      Free;
    end;
end;
Function  TPayments.GetPrepaymentAmount           : Double;
begin
    fdPrepaymentAmount  := 0;
    ShowProgressbar(GUILines.count, 'check for Prepayment Amount');
    try
      GUILines.Iteraterecords(CallbackPrepaymentamount);
    finally
      HideProgressbar;
    end;
    Result := fdPrepaymentAmount;
end;
Procedure TPayments.CallbackPrepaymentamount      (Const Sender: TBusObj; var Abort: Boolean);
begin
    StepProgressbar;
    if not(Sender is TGuiPaymentLines) then exit;
    if TGuiPaymentLines(Sender).TransType = Prepaytype then
        fdPrepaymentAmount := fdPrepaymentAmount + TGuiPaymentLines(Sender).Payment;
end;

function  TPayments.getExchageBuyRate            : Double;
var
    BuyRate, SellRate:Double;
begin
    With TForeignExchangeObj.Create do Try
        GetForeignExchangeRatesForDate(ForeignExchangeCode, PaymentDate, BuyRate, SellRate);
        Result := BuyRate;
    finally
      Free;
    end;
end;

Function TPayments.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

Function TPayments.Lock : Boolean ;
begin
    Result := False;
    LockMsg := '';
    if PaymentOnHold then
      LockMsg := LockMsgReconcileHold
    else if PaymentReconciled then
      LockMsg := LockMsgReconciled
    else if Deleted then
      LockMsg := LockMsgDeletedPayment 
    else if (PaymentDate <= AppEnv.CompanyPrefs.ClosingDate) OR
        ((Self is TCustPayments) AND (PaymentDate <= AppEnv.CompanyPrefs.ClosingDateAR)) OR
        ((Self is TSuppPayments) AND (PaymentDate <= AppEnv.CompanyPrefs.ClosingDateAP)) then
      LockMsg := 'Payment date is '+ LockMsgClosingDate
    else if (Deleted) and (TransactionsChanged) then
      LockMsg := LockMsgAlteredTrans
    else Begin
      Result := inherited lock;
      if not Result then
        LockMsg := LockMsgInUse;
    end;
end;
Procedure TPayments.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  RefreshguiLines;
end;


Procedure TPayments.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(sender.FieldName, 'SupplierID') then begin
    CompanyName:= TClient.IDToggle(Sender.AsInteger, Connection.Connection);
    ClientPrintName:= tcdatautils.clientPrintName(CompanyName);
  end else if Sysutils.SameText(sender.FieldName, 'CompanyName') then begin
  end else if Sysutils.SameText(sender.FieldName, 'paymentdate') then begin
    if self is TSuppPayments then begin
           if not (EmployeeHasAccess('AllowFutureDateinSupplierPayment')) and (Paymentdate >date) then PaymentDate := date
      else if not (EmployeeHasAccess('AllowPastDateinSupplierPayment'  )) and (Paymentdate <date) then PaymentDate := date;
    end else if self is TCustPayments then begin
           if not (EmployeeHasAccess('AllowFutureDateinCustomerPayment')) and (Paymentdate >date) then PaymentDate := date
      else if not (EmployeeHasAccess('AllowPastDateinCustomerPayment'  )) and (Paymentdate <date) then PaymentDate := date;
    end;
  end;
end;


Function TPayments.GetSQL: String;
begin
  Result := inherited GetSQL;
end;
Class Function TPayments.GetIDField: String;
begin
  Result := 'PaymentID'
end;
Function TPayments.getFullyApplied:Boolean;
begin
    Result := (UnApplied = 0) and (ForeignUnApplied = 0);
end;
Function TPayments.getUseFC:Boolean;
begin
    Result := (ForeignApplied<> 0);
end;
Function TPayments.getcleanDeleted :Boolean;
begin
    Result:= GetXMLNodeBooleanValue(CleanXMLNode, 'Deleted');
end;

Function TPayments.PaymentReconciled: Boolean;
begin
    Result := getReconcilations(ltReconciled);
end;
Function TPayments.PaymentOnHold: Boolean;
begin
    Result := getReconcilations(ltOnHoldRec);
end;
Procedure   TPayments.SelectAll;
var
  fbDoFieldChangewhenDisabled :Boolean;
begin
    if GuiLines.count = 0 then Exit;
    ShowProgressbar(GuiLines.count+1 ,'Selecting All' );
    try
      fbDoFieldChangewhenDisabled :=GuiLines.DoFieldChangewhenDisabled;
      GuiLines.DoFieldChangewhenDisabled := true;
      try
        SelectingAll := True;
        try
          GuiLines.IterateRecords(CallbackSelectAll);
        finally
          SelectingAll := false;
        end;
      finally
        GuiLines.DoFieldChangewhenDisabled := fbDoFieldChangewhenDisabled;
      end;
      stepProgressbar('Calculating totals');
      CalcTotals;
    finally
      HideProgressbar;
    end;
end;

Procedure TPayments.CallbackSelectAll(Const Sender: TBusObj; var Abort: Boolean);
var
    BookMark :TBookmark;
    bEOF :Boolean;
begin
    if not (Sender is TGuiPaymentLines) then Exit;
    stepProgressbar(inttostr(TGuiPaymentLines(Sender).recno)+' of '+ inttostr(TGuiPaymentLines(Sender).count) + '  -  ' + TGuiPaymentLines(Sender).ClientName +'  : ' + FloatToStrF(TGuiPaymentLines(Sender).AmountOutStanding , ffCurrency , 15,2));
    TGuiPaymentLines(Sender).Applied := True;
    if TGuiPaymentLines(Sender).Applied then begin
      if Assigned(Qrybulkpay) then begin
          bEOF :=Qrybulkpay.EOF;
          Bookmark := Qrybulkpay.GetBookmark;
          try
              if Qrybulkpay.Locate('TransID' ,TGuiPaymentLines(Sender).TransID , []) then
                  TGuiPaymentLines(Sender).Payment :=  Qrybulkpay.fieldByname('Amount').asfloat;
          finally
            Qrybulkpay.GotoBookmark(bookmark);
            Qrybulkpay.FreeBookmark(bookmark);
            if bEOF then Qrybulkpay.Next; // temp fix as book mark get the last record pointer when its in eof
          end;
      end;
      TGuiPaymentLines(Sender).PostDB;
    end;
    if not self.ResultStatus.OperationOk then
      Abort:= true;
end;

Procedure TPayments.CallbackCalcTotals(Const Sender: TBusObj; var Abort: Boolean);
begin
    if not(Sender is TGuiPaymentLines) then Exit;
    if TGuiPaymentLines(Sender).Applied then begin
        if IsFCSelected then begin
            ForeignApplied          := ForeignApplied +   TGuiPaymentLines(Sender).ForeignPayment;
        end;
        Applied                 := applied +   TGuiPaymentLines(Sender).Payment;
        if IsFCSelected and (not(Sender is TGuiCustPaymentLines) or (TGuiCustPaymentLines(Sender).splitforeignExchangecode= '') or Sametext(TGuiCustPaymentLines(Sender).foreignExchangecode, TGuiCustPaymentLines(Sender).splitforeignExchangecode)) then
            ForeignVariationAmount:=
              ForeignVariationAmount + (ForeignToLocal(TGuiPaymentLines(Sender).ForeignPayment ,ForeignExchangeRate, CurrencyRoundPlaces) - TGuiPaymentLines(Sender).Payment);
    end;
    fdTotalAmount := fdTotalAmount + TGuiPaymentLines(Sender).Payment;
end;

function  TPayments.DoBulkPay(Const strSQL,fsPaymethod,Payclass:String; Const fdPaydate :TDatetime; Const BankAccountID :Integer; chequeno:String = ''):Boolean;
var
    iClientId : Integer;
    iClassId  : Integer;
    Procedure NextChequeno;
    begin
      try
        chequeno := inttostr(strtoInt(trim(chequeno))+1);
      Except
      end;
    end;
begin

    Result := True;
    Connection.BeginTransaction;
    fsBulkPaymentIDs := '';
    Qrybulkpay :=TERPQuery(getnewDataset(strSQL, false));
    with Qrybulkpay do try
        if recordcount = 0 then exit;
        first;
        While (Eof = False) do begin
            iClassId  := fieldByname('classId').asInteger;
            iClientId := fieldByname('clientID').asInteger;
            fbBulkPayment := True;
            New;
            clientId := fieldByname('clientID').asInteger ;
            ForeignExchangeCode := (*Client.ForeignExchangeCode; // *)AppEnv.RegionalOptions.ForeignExDefault ;
            PaymentDate         := fdPaydate;
            if fsPaymethod <> '' then
                PayMethodID     := tcdatautils.GetPaymentMethod(fsPaymethod);
            if Payclass = '' then
              ClassID         := FieldByname('ClassId').asInteger
            else
              ClassId        := tcdatautils.GetDeptID(Payclass);

            If BankAccountID<>0 then
              AccountID         := BankAccountID;
            if chequeno <> '' then begin
               ReferenceNo := chequeno;
               SetSequenceNumber(SEQ_LAST_CHEQUENO, chequeno);
               nextchequeno;
            end;

            PrepayIDS           := '0';
            SalePOIDs           := '0';
            while (Eof = False)  and
                    (fieldByname('clientID').asInteger = iclientId) and
                    ((fieldByname('classId').asInteger =     iClassId) or (Payclass <> '')) do begin
                if (Sysutils.SameText(fieldbyname('type').asString , CUSTOMER_PREPAYMENT))  Or
                    (Sysutils.SameText(fieldbyname('type').asString , 'Supplier Prepayment')) then
                    PrepayIDS := PrepayIDS + ',' + IntToStr(FieldByname('TransID').asInteger)
                else
                    SalePOIDs := SalePOIDs + ',' + IntToStr(FieldByname('TransID').asInteger);
                Next;
            end;
            Container.clear(TGuiCustPaymentLines);
            Container.clear(TGuiSuppPaymentLines);
            GUILines;
            GUILines.DoFieldChangewhenDisabled := True; // itereate records disabled the dataset
            SelectAll;
            if ForeignExchangeCode = AppEnv.RegionalOptions.ForeignExDefault then
              self.Amount:= self.Applied
            else
              self.ForeigncurrencyAmount := self.ForeignApplied;
            if not self.ResultStatus.OperationOk then begin
                Self.connection.RollbackTransaction;
                result := False;
                Exit;
            end;

            if (GUILines.count =0) or (not (Save)) then begin
                Self.connection.RollbackTransaction;
                result := False;
                Exit;
            end;
            if fsBulkPaymentIDs <> '' then fsBulkPaymentIDs := fsBulkPaymentIDs + ',' ;
            fsBulkPaymentIDs := fsBulkPaymentIDs + IntToStr(ID);
        end;
    finally
        if Qrybulkpay.Active then Qrybulkpay.Close;
        FreeandNil(Qrybulkpay);
    end;
    Self.connection.CommitTransaction;

end;
Procedure TPayments.DoCalcOrderTotals;
Begin
  if fbDisableCalcOrderTotals then exit;
  if Self is TCustPayments then begin
    If ( Appenv.CompanyPrefs.CustPayLinesToDisableCalcs = 0) or
      (guiLines.Count <= Appenv.CompanyPrefs.CustPayLinesToDisableCalcs)  Then CalcTotals;
  end else  if Self is TSuppPayments then begin
    If ( Appenv.CompanyPrefs.SuppPayLinesToDisableCalcs = 0) or
      (guiLines.Count <= Appenv.CompanyPrefs.SuppPayLinesToDisableCalcs)  Then CalcTotals;
  end;
  SendEvent(BusobjEvent_ToDo, BusobjEvent_CalculationsDisabled, Self);
End;

Procedure TPayments.CalcTotals(const AdjustAmount: boolean = false);
begin
    GUILines.Dataset.DisableControls;
    Dataset.DisableControls;
    try
      ShowProgressbar(GuiLines.count+1 ,'Calculating totals' );
      try
        Applied                 := 0;
        ForeignApplied          := 0;
        ForeignVariationAmount:= 0;
        fdTotalwithholding      := 0;
        fdTotalRefunding        := 0;
        fdTotalDiscount         := 0;
        ForeignApplied          := 0;
        ForeignUnApplied        := 0;
        fdTotalAmount           := 0;
        GUILines.IterateRecords(CallbackCalcTotals);
        if AdjustAmount and (Amount < Applied) then begin
          ForeigncurrencyAmount:= ForeignApplied;
          Amount:= Applied + ForeignVariationAmount;
        end;
        if not IsFCSelected then begin
            ForeignApplied          := Localtoforeign(Applied , ForeignExchangeRate , CurrencyRoundPlaces);
            ForeigncurrencyAmount   := Localtoforeign(Amount , ForeignExchangeRate , CurrencyRoundPlaces);
            ForeignVariationAmount  := 0;
        end;


        unapplied := amount - (applied + ForeignVariationAmount);
        Foreignunapplied := ForeigncurrencyAmount - foreignapplied;
        if IsFCSelected and (unapplied <> 0) and (Foreignunapplied = 0) then begin
          ForeignVariationAmount:= ForeignVariationAmount + unapplied;
          unapplied := amount - (applied + ForeignVariationAmount);
        end;
      finally
        HideProgressbar;
      end;
    finally
        GUILines.Dataset.EnableControls;
        Dataset.EnableControls;
    end;
    SendEvent(BusObjEvent_Change,BusObjEvent_TotalsChanged, self);
end;

Function TPayments.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
    Result      := inherited DoAfterInsert(Sender);
    InitializeNewObject;
    if not Result  then Exit;
    EnteredAt                   := Now;
end;
Function  TPayments.getclient: TClient;
begin
    Result := TClient(Getcontainercomponent(TClient , 'clientId = ' + IntToStr(ClientID)));
end;
Function  TPayments.getGLAccount: TAccount;
begin
    Result := TAccount(Getcontainercomponent(TAccount , 'AccountId = ' + IntToStr(AccountId), SilentMode, False ));
end;

Procedure TPayments.CallbackselectedLines(Const Sender: TBusobj; Var abort: Boolean);
begin
  StepProgressbar;
  if not (Sender is TGUIPaymentLines) then Exit;
  if TGuiPaymentLines(Sender).applied then
    fiselectedLines := fiselectedLines + 1;
end;

Function TPayments.GetselectedLines :Integer;
begin
  fiselectedLines := 0;
  ShowProgressbar(GUILines.count, 'Check for Selected Items');
  try
    GuiLines.IterateRecords(callbackselectedLines);
  finally
    HideProgressbar
  end;
  Result := fiselectedLines;
end;

Function TPayments.getpayMethod: TPaymentMethod;
begin
    Result := TPaymentMethod(Getcontainercomponent(TPaymentMethod , 'PayMethodID = ' + IntToStr(PaymethodID), SilentMode, False ));
end;


Function TPayments.getIsFCSelected:Boolean;
begin
    Result := (ForeignExchangeCode <> '')  and
              (ForeignExchangeCode <> AppEnv.RegionalOptions.ForeignExDefault) ;
end;

Function  TPayments.getAnyPaymentsApplied : Boolean;
begin
    Result := GUILines.dataset.Locate('Apply' , 'T' , []);
end;
Function TPayments.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if Paymentno = 0 then begin
    Paymentno := Id;
    PostDB;
  end;

end;
Function  TPayments.getBankDeposit: TBankDeposit;
begin
    PostDB;
    Result :=  TBankDeposit(getContainerComponent(TBankDeposit , 'Details.Trnstype = ' + quotedStr(TransType) + ' and Details.PaymentId = ' + IntToStr(ID)));
end;

{Property Functions}
Function  TPayments.GetPaymentNo                : Integer   ; begin Result := GetIntegerField('PaymentNo')                  ;end;
Function  TPayments.GetEmployeeID               : Integer   ; begin Result := GetIntegerField('EmployeeID')                 ;end;
function TPayments.GetEmployeeName              : string    ; begin result := TEmployee.IDToggle(EmployeeID, Connection.Connection); end;
Function  TPayments.GetPaymentDate              : TDateTime ; begin Result := GetDateTimeField('PaymentDate')               ;end;
Function  TPayments.GetAmount                   : Double    ; begin Result := GetFloatField('Amount')                       ;end;
Function  TPayments.GetPayMethodID              : Integer   ; begin Result := GetIntegerField('PayMethodID')                ;end;
function TPayments.GetPayMethodName             : string    ; begin result := TPaymentMethod.IDToggle(PayMethodId, Connection.Connection);end;
Function  TPayments.GetNotes                    : String    ; begin Result := GetStringField('Notes')                       ;end;
Function  TPayments.GetReferenceNo              : String    ; begin Result := GetStringField('ReferenceNo')                 ;end;
Function  TPayments.GetCardholdersName          : String    ; begin Result := GetStringField('CardholdersName')             ;end;
Function  TPayments.GetCreditCardNumber         : String    ; begin Result := GetStringField('CreditCardNumber')            ;end;
Function  TPayments.GetCreditCardExpDate        : TDateTime ; begin Result := GetDateTimeField('CreditCardExpDate')         ;end;
Function  TPayments.GetPrintFlag                : Boolean   ; begin Result := GetBooleanField('PrintFlag')                  ;end;
Function  TPayments.GetPrintedBy                : Integer   ; begin Result := GetIntegerField('PrintedBy')                  ;end;
Function  TPayments.GetClassID                  : Integer   ; begin Result := GetIntegerField('ClassID')                    ;end;
Function  TPayments.GetAccountID                : Integer   ; begin Result := GetIntegerField('AccountID')                  ;end;
function TPayments.GetAccountName               : string    ; begin result := TAccount.IDToggle(AccountId, Connection.Connection);end;
Function  TPayments.GetCustomer                 : Boolean   ; begin Result := GetBooleanField('Customer')                   ;end;
Function  TPayments.GetSupplier                 : Boolean   ; begin Result := GetBooleanField('Supplier')                   ;end;
Function  TPayments.GetEmployee                 : Boolean   ; begin Result := GetBooleanField('Employee')                   ;end;
Function  TPayments.GetContact                  : Boolean   ; begin Result := GetBooleanField('Contact')                    ;end;
Function  TPayments.GetCompanyName              : String    ; begin Result := GetStringField('CompanyName')                 ;end;
Function  TPayments.GetClientPrintName          : String    ; begin Result := GetStringField('ClientPrintName')             ;end;
Function  TPayments.GetAppliedCredits           : Boolean   ; begin Result := GetBooleanField('AppliedCredits')             ;end;
Function  TPayments.GetDeleted                  : Boolean   ; begin Result := GetBooleanField('Deleted')                    ;end;
Function  TPayments.GetReconciled               : Boolean   ; begin Result := GetBooleanField('Reconciled')                 ;end;
Function  TPayments.GetAmountDue                : Double    ; begin Result := GetFloatField('Balance')                      ;end;
Function  TPayments.GetCredit                   : Double    ; begin Result := GetFloatField('Credit')                       ;end;
Function  TPayments.GetUnApplied                : Double    ; begin Result := GetFloatField('UnApplied')                    ;end;
Function  TPayments.GetApplied                  : Double    ; begin Result := GetFloatField('Applied')                      ;end;
Function  TPayments.GetReconciliationID         : Integer   ; begin Result := GetIntegerField('ReconciliationID')           ;end;
Function  TPayments.GetFinished                 : Boolean   ; begin Result := GetBooleanField('Finished')                   ;end;
Function  TPayments.GetStatement                : Integer   ; begin Result := GetIntegerField('Statement')                  ;end;
Function  TPayments.GetMSReceived               : Boolean   ; begin Result := GetBooleanField('MSReceived')                 ;end;
Function  TPayments.GetForeignExchangeRate      : Double    ; begin Result := GetFloatField('ForeignExchangeRate')          ;end;
Function  TPayments.GetForeignExchangeCode      : String    ; begin Result := GetStringField('ForeignExchangeCode')         ;end;
Function  TPayments.GetForeigncurrencyAmount    : Double    ; begin Result := GetFloatField('ForeignCurrencyAmount')        ;end;
Function  TPayments.GetBankAccountName          : String    ; begin Result := GetStringField('BankAccountName')             ;end;
Function  TPayments.GetBankAccountBSB           : String    ; begin Result := GetStringField('BankAccountBSB')              ;end;
Function  TPayments.GetBankAccountNo            : String    ; begin Result := GetStringField('BankAccountNo')               ;end;
Function  TPayments.GetForeignVariationAccountID: Integer   ; begin Result := GetIntegerField('ForeignVariationAccountID')  ;end;
Function  TPayments.GetForeignVariationAmount   : Double    ; begin Result := GetFloatField('ForeignVariationAmount')       ;end;
Function  TPayments.GetForeignUnApplied         : Double    ; begin Result := GetFloatField('ForeignUnApplied')             ;end;
Function  TPayments.GetForeignApplied           : Double    ; begin Result := GetFloatField('ForeignApplied')               ;end;

function TPayments.GetTenderAccountPrefs: TTenderAccountPrefs;
begin
  result := TTenderAccountPrefs(GetContainerComponent(TTenderAccountPrefs,'PayMethodID = ' + IntToStr(self.PayMethodID)));
end;

function TPayments.getTotalRefunding: Double;
begin
    Result := fdTotalRefunding;
end;
function TPayments.GetDeptClassName: string;
begin
  result := TDeptClass.IDToggle(ClassID, Connection.Connection);
end;
function TPayments.GetForeignVariationAccountName: string;
begin
  result := TAccount.IDToggle(ForeignVariationAccountId, Connection.Connection);
end;
Procedure TPayments.SetPaymentNo                (Const Value: Integer   ); begin SetIntegerField('PaymentNo'                , Value);end;
Procedure TPayments.SetEmployeeID               (Const Value: Integer   ); begin SetIntegerField('EmployeeID'               , Value);end;
procedure TPayments.SetEmployeeName(const Value: string);begin  EmployeeId := TEmployee.IDToggle(Value, Connection.Connection);end;
Procedure TPayments.SetPaymentDate              (Const Value: TDateTime ); begin SetDateTimeField('PaymentDate'             , Value);end;
Procedure TPayments.SetAmount                   (Const Value: Double    ); begin SetFloatField('Amount'                     , Value);end;
Procedure TPayments.SetPayMethodID              (Const Value: Integer   ); begin SetIntegerField('PayMethodID'              , Value);end;
Procedure TPayments.SetNotes                    (Const Value: String    ); begin SetStringField('Notes'                     , Value);end;
Procedure TPayments.SetReferenceNo              (Const Value: String    ); begin SetStringField('ReferenceNo'               , Value);end;
Procedure TPayments.SetCardholdersName          (Const Value: String    ); begin SetStringField('CardholdersName'           , Value);end;
Procedure TPayments.SetCreditCardNumber         (Const Value: String    ); begin SetStringField('CreditCardNumber'          , Value);end;
Procedure TPayments.SetCreditCardExpDate        (Const Value: TDateTime ); begin SetDateTimeField('CreditCardExpDate'       , Value);end;
Procedure TPayments.SetPrintFlag                (Const Value: Boolean   ); begin SetBooleanField('PrintFlag'                , Value);end;
Procedure TPayments.SetPrintedBy                (Const Value: Integer   ); begin SetIntegerField('PrintedBy'                , Value);end;
Procedure TPayments.setClassID                  (Const Value: Integer   ); begin SetIntegerField('ClassID'                  , Value);end;
Procedure TPayments.SetAccountID                (Const Value: Integer   ); begin SetIntegerField('AccountID'                , Value);end;
Procedure TPayments.SetCustomer                 (Const Value: Boolean   ); begin SetBooleanField('Customer'                 , Value);end;
Procedure TPayments.SetSupplier                 (Const Value: Boolean   ); begin SetBooleanField('Supplier'                 , Value);end;
Procedure TPayments.SetEmployee                 (Const Value: Boolean   ); begin SetBooleanField('Employee'                 , Value);end;
Procedure TPayments.SetContact                  (Const Value: Boolean   ); begin SetBooleanField('Contact'                  , Value);end;
Procedure TPayments.SetCompanyName              (Const Value: String    ); begin SetStringField('CompanyName'               , Value);end;
Procedure TPayments.SetClientPrintName          (Const Value: String    ); begin SetStringField('ClientPrintName'           , Value);end;
Procedure TPayments.SetAppliedCredits           (Const Value: Boolean   ); begin SetBooleanField('AppliedCredits'           , Value);end;
Procedure TPayments.SetDeleted                  (Const Value: Boolean   ); begin SetBooleanField('Deleted'                  , Value);end;
Procedure TPayments.SetReconciled               (Const Value: Boolean   ); begin SetBooleanField('Reconciled'               , Value);end;
Procedure TPayments.SetAmountDue                (Const Value: Double    ); begin SetFloatField('Balance'                    , Value);end;
Procedure TPayments.SetCredit                   (Const Value: Double    ); begin SetFloatField('Credit'                     , Value);end;
Procedure TPayments.SetUnApplied                (Const Value: Double    ); begin SetFloatField('UnApplied'                  , Value);end;
Procedure TPayments.SetApplied                  (Const Value: Double    ); begin SetFloatField('Applied'                    , Value);end;
Procedure TPayments.SetReconciliationID         (Const Value: Integer   ); begin SetIntegerField('ReconciliationID'         , Value);end;
Procedure TPayments.SetFinished                 (Const Value: Boolean   ); begin SetBooleanField('Finished'                 , Value);end;
Procedure TPayments.SetStatement                (Const Value: Integer   ); begin SetIntegerField('Statement'                , Value);end;
Procedure TPayments.SetMSReceived               (Const Value: Boolean   ); begin SetBooleanField('MSReceived'               , Value);end;
Procedure TPayments.SetForeignExchangeRate      (Const Value: Double    ); begin SetFloatField('ForeignExchangeRate'        , Value);end;
Procedure TPayments.SetForeignExchangeCode      (Const Value: String    ); begin SetStringField('ForeignExchangeCode'       , Value);end;
Procedure TPayments.SetForeigncurrencyAmount    (Const Value: Double    ); begin SetFloatField('ForeignCurrencyAmount'      , Value);end;
Procedure TPayments.SetBankAccountName          (Const Value: String    ); begin SetStringField('BankAccountName'           , Value);end;
Procedure TPayments.SetBankAccountBSB           (Const Value: String    ); begin SetStringField('BankAccountBSB'            , Value);end;
Procedure TPayments.SetBankAccountNo            (Const Value: String    ); begin SetStringField('BankAccountNo'             , Value);end;
Procedure TPayments.SetForeignVariationAccountID(Const Value: Integer   ); begin SetIntegerField('ForeignVariationAccountID', Value);end;
Procedure TPayments.SetForeignVariationAmount   (Const Value: Double    ); begin SetFloatField('ForeignVariationAmount'     , Value);end;
Procedure TPayments.SetForeignUnApplied         (Const Value: Double    ); begin SetFloatField('ForeignUnApplied'           , Value);end;
Procedure TPayments.SetForeignApplied           (Const Value: Double    ); begin SetFloatField('ForeignApplied'             , Value);end;


procedure TPayments.SetPayMethodName(const Value: string);
begin
  PayMethodId := TPaymentMethod.IDToggle(Value, Connection.Connection);
  if PayMethodId =0 then begin
    TPaymentMethod.AddNewifnotExsist(Value, False , Connection.Connection);
    PayMethodId := TPaymentMethod.IDToggle(Value, Connection.Connection);
  end;
end;
procedure TPayments.SetAccountName(const Value: string);
begin
  AccountId := TAccount.IDToggle(Value, Connection.Connection);
end;
procedure TPayments.SetDeptClassName(const Value: string);
begin
  ClassID := TDeptClass.IDToggle(Value, Connection.Connection);
end;
procedure TPayments.SetForeignVariationAccountName(const Value: string);
begin
  ForeignVariationAccountId := TAccount.IDToggle(Value, Connection.Connection);
end;


procedure TPayments.InitializeNewObject;
begin
  inherited;
  PaymentDate := Date;
  EmployeeID:= AppEnv.Employee.EmployeeID;
end;

procedure TPayments.DoOnUserLockOnUnlockItem(sender: TObject);
begin
  ProgressDialog.DoStepProgressbar;
end;

procedure TPayments.AssignProgressdialog(const xPostList: TPostList);
begin
  inherited;
  xPostList.ShowProgressbar := ShowProgressbar;
  xPostList.HideProgressbar := HideProgressbar;
  xPostList.StepProgressbar := StepProgressbar;
end;

procedure TPayments.HideProgressbar;
begin
  if appenv.appdb.apimode then exit;
  ProgressDialog.DoHideProgressbar;
end;

procedure TPayments.ShowProgressbar(ProgressCount: integer;
  ProgressBarCaption, ProgressBarMessage: string; IsPercenage: boolean);
begin
  if appenv.appdb.apimode then exit;
  ProgressDialog.DoShowProgressbar(ProgressCount,ProgressBarCaption, ProgressBarMessage, IsPercenage);
end;

procedure TPayments.StepProgressbar(const ProgressBarMessage: String);
begin
  if appenv.appdb.apimode then exit;
  ProgressDialog.DoStepProgressbar(ProgressBarMessage);
end;

procedure TPayments.CallbacktotalRefunding(const Sender: TBusObj;
  var Abort: Boolean);
begin
  if not (Sender is TGUIPaymentLines) then Exit;
  fdTotalRefunding := fdTotalRefunding + TGUIPaymentLines(sender).Refunding;
end;

procedure TPayments.CallbackValidateGuiLines(const Sender: TBusObj; var Abort: Boolean);
begin
  StepProgressbar;
  if TGUIPaymentLines(Sender).Applied then begin
    if not TGUIPaymentLines(Sender).ValidateData then begin
      AllGuiLinesValid:= false;
      Abort:= true;
    end;
  end;
end;

function TPayments.ValidateGuiLines: boolean;
begin
  AllGuiLinesValid:= true;
  ShowProgressbar(GUILines.count, 'Valdiate Lines');
  try
    GUILines.IterateRecords(self.CallbackValidateGuiLines);
  finally
    HideProgressbar;
  end;
  result:= AllGuiLinesValid;
end;

{TCustPayments}

function TCustPayments.IsPaymentDeposited: Boolean;
var
  LockManagement :TLockManagement;
begin
  LockManagement := TLockManagement.Create;
  try
    result := LockManagement.CustomerPaymentDeposited(ID);
  finally
    LockManagement.Free;
  end;
(*var
  strSQL :String;
begin
    strSQL := 'Select ' +
               ' D.PaymentID ' +
               ' From tbldeposits D ' +
               ' INNER JOIN tbldepositline DL USING(PaymentID) ' +
               ' INNER JOIN tblbankdepositlines BDL ON ' +
               ' BDL.PaymentID      = D.PaymentID  ' +
               ' AND BDL.PaymentDate= D.PaymentDate ' +
               ' AND BDL.AccountID  = D.AccountID ' +
               ' AND BDL.Amount     = D.Amount  ' +
               ' AND BDL.CompanyName= D.CompanyName ' +
               ' AND BDL.CusID      = D.CusID ' +
               ' AND BDL.TrnsType   = "Customer Payment" ' +
               ' INNER JOIN tblbankdeposit BD on BD.DEpositID = BDL.DepositID and ifnull(BD.Deleted,"F") <> "T" ' +
               ' Where D.PaymentID  = ' + IntToStr(ID) +
               ' AND D.Deleted      <>"T" AND D.Deposited="T" ' +
               ' AND BDL.FromDeposited = "T" ' +
               ' Group By D.PaymentID ';
    with getNewDataset(strSQL) do try
        Result := recordcount > 0;
    finally
        if Active then close;
        Free;
    end;*)
end;
Class function  TCustPayments.GetTranstype: String;
begin
    Result := 'Customer Payment';
end;
Function TCustPayments.GetTransactionsChanged: Boolean;
var
    StrSQL:String;
begin
{sales and prepayment transactions are locked when the payment is done
and are unlocked when the payment is deleted.
so before 'UNDELETE' , make sure the transactions are not changed - only check the total amount inc}
    strSQL:= ' Select tblSales.SaleID  as Id, If(IsRefund="T",' + QuotedStr(REfundtype) +' ,' + quotedstr(Invtype) + ') as Type'+
             ' FROM tbldeposits INNER JOIN tbldepositline Using(PaymentID)'+
             ' inner join tblSales on  tblSales.SaleID = tbldepositline.SaleID'+
             ' Where tbldepositline.PaymentId = ' + IntToStr(ID) +
             ' and tbldepositline.TrnType <> "Prepayment"' +
             ' and tbldepositline.Originalamount <> tblSales.TotalamountINc'+
             ' union'+
             ' Select tblprepayments.PrepaymentID as ID , ' + QuotedStr(PrePayType) + ' as Type'+
             ' FROM tbldeposits INNER JOIN tbldepositline Using(PaymentID)'+
             ' inner join tblprepayments on  tblprepayments.PrepaymentID = tbldepositline.PrepaymentID'+
             ' Where tbldepositline.PaymentId =  ' + IntToStr(ID) +
             ' and tbldepositline.TrnType= "Prepayment"'+
             ' and abs(tbldepositline.Originalamount)<> abs( tblprepayments.PayAmount)';
    with getNewdataset(strSQL ) do try
        Result := Recordcount > 0;
        if Result then begin
            First;
            LockMsg := '';
            While Eof = False do begin
                if LockMsg <> '' then LockMsg := chr(13);
                LockMsg := LockMsg + fieldByname('ID').AsString + ' - ' + Fieldbyname('Type').asString;
                Next;
            end;
        end;
    finally
        if Active then close;
        Free;
    end;
end;
procedure TCustPayments.SalesOutStandingTrans(var QrySource: TERPQuery; aSaleType:String= '' ; aTransId :Integer=0);
begin
  Paymentslib.SalesOutStandingTrans(QrySource,clientID,aSaleType,aTransId, SalePOIDs,PrepayIDS);
end;
procedure TCustPayments.SalesPaymentLines(var QrySource: TERPQuery);
begin
                  qrySource.SQL.Clear;
                  qrySource.SQL.Add('SELECT');
                  qrySource.SQL.Add('if (Details.TrnType="Prepayment",PrepaymentID,Details.SaleID) ,');
                  qrySource.SQL.Add('Details.TrnType,');
                  qrySource.SQL.Add('Header.CompanyName,');
                  (*qrySource.SQL.Add('Header.PaymentDate,');*)
                  qrySource.SQL.Add('Details.Invoicedate,');
                  qrySource.SQL.Add('Details.GlobalRef,');
                  qrySource.SQL.Add('Details.InvoiceNo,');
                  qrySource.SQL.Add('Details.OriginalAmount,');
                  qrySource.SQL.Add('Details.AmountDue 	   ,');
                  qrySource.SQL.Add('Details.AmountOutstanding,');
                  qrySource.SQL.Add('Details.ForeignOriginalAmount,');
                  qrySource.SQL.Add('Details.ForeignAmountDue,');
                  qrySource.SQL.Add('Details.ForeignAmountOutstanding,');
                  qrySource.SQL.Add('Details.Payment, Details.ForeignPayment,');
                  qrySource.SQL.Add('Header.ForeignExchangeCode,');
                  qrySource.SQL.Add('Header.ForeignExchangeRate,');
                  qrySource.SQL.Add('"T",');
                  qrySource.SQL.Add('0,0,0,0,"T", convert(REfno , char(255)) as Refno,Details.EnteredBy');
                  qrySource.SQL.Add('FROM tbldepositline as Details');
                  qrySource.SQL.Add('Inner Join tbldeposits  as Header ON Details.PaymentID = Header.PaymentID');
                  qrySource.SQL.Add('Where Details.PaymentID = ' + IntToStr(ID) +';');
end;

Function TCustPayments.getGUIPaymentLines :TGUIPaymentLines;
var
    SQLList:TStringList;
    qrySource, qryDest: TERPQuery;
    x: integer;
begin
    if Id =0 then postdb; // this is to make sure the Id is generated before createing the container items

    Result := TGUICustPaymentLines(Container.ItemByClass(TGUICustPaymentLines, false));

    If Assigned(Result) then exit;

    SQLList := TStringList.Create;
    try
        GuiCustPaymentLinesTablename := '';
        GuiTablename := TGuiCustPaymentLines.GetBusObjectTablename ;
        SQLList.Add('Create table '+ GuiTablename );
        SQLList.Add('(ID                        int             NOT NULL AUTO_INCREMENT, ');
        SQLList.Add('Type                       Varchar(10)     NOT NULL DEFAULT "",');
        SQLList.Add('CustomerName               Varchar(255)             DEFAULT NULL,');
        SQLList.Add('SaleDate                   date                     DEFAULT NULL,');
        SQLList.Add('GlobalRef                  Varchar(255)             DEFAULT NULL,');
        SQLList.Add('InvoiceDocNumber           Varchar(30)              DEFAULT NULL,');
        SQLList.Add('OriginalAmount             Double                   DEFAULT NULL,');
        SQLList.Add('Balance                    Double                   DEFAULT NULL,');
        SQLList.Add('AmountOutstanding          Double                   DEFAULT NULL,');
        SQLList.Add('Paid                       Varchar(1)               DEFAULT NULL,');
        SQLList.Add('SaleID                     Int(11)         NOT NULL DEFAULT 0,');
        SQLList.Add('ForeignExchangeCode        char(3)                  DEFAULT NULL,');
        SQLList.Add('ForeignExchangeRate        Double                   DEFAULT NULL,');
        SQLList.Add('`SplitForeignExchangeCode` VARCHAR(3)      NULL     DEFAULT NULL ,');
        SQLList.Add('`SplitForeignExchangeRate` DOUBLE          NULL     DEFAULT NULL ,');
        SQLList.Add('`SplitForeignPayment`      DOUBLE          NULL     DEFAULT NULL,');
        SQLList.Add('ForeignOriginalAmt         Double                   DEFAULT NULL,');
        SQLList.Add('ForeignBalanceAmount       Double                   DEFAULT NULL,');
        SQLList.Add('ForeignAmountOutstanding   Double                   DEFAULT NULL,');
        SQLList.Add('Payment                    Double                   DEFAULT 0,');
        SQLList.Add('ForeignPayment             Double                   DEFAULT 0,');
        SQLList.Add('Discount                   Double                   DEFAULT 0,');
        SQLList.Add('Withholding                Double                   DEFAULT 0,');
        SQLList.Add('Refunding                  Double                   DEFAULT 0,');
        SQLList.Add('RefundPercent              Double                   DEFAULT 0,');
        SQLList.Add('Apply                      Enum("T","F")            DEFAULT "F",');
        SQLList.Add('IsEarlyPaymentDiscount     Enum("T","F")            DEFAULT "F",');
        SQLList.Add('RefNo                      Varchar(255)             DEFAULT NULL,');
        SQLList.Add('EnteredBy                  Varchar(255)             DEFAULT NULL,');
        SQLList.Add('Primary Key (ID)) ENGINE=MYISAM ;');
        ExecuteSQL(SQLList); //keep this outside transaction, otherwise CREATE TABLE calls commit as the table cretion cannot be rolled back
        SQLList.Clear;

        if  (ClientID <> 0) and (GUIMode or (cleanid <>0) or (fbBulkPayment)) then begin
            qrySource:= TERPQuery.Create(nil);
            qryDest:= TERPQuery.Create(nil);
            try
              (*qrySource.Connection:= GetSharedMyDacConnection;*)
              qrySource.Connection:= (*CommonDbLib.GetSharedMyDacConnection; //  *)self.Connection.Connection;
              {Binny - this needs to be self.connection - When discount is applied (PLLY Discnt), the discount line is added to the invoice and totoal is recalculated and saved with this connection in transaction
              Then the form is rereshed to have the values after the discounts.
              using shared connection doesn't see those changes}



              qryDest.Connection:= CommonDbLib.GetSharedMyDacConnection; //  self.Connection.Connection;
              if Lines.count = 0 then begin

                  qryDest.SQL.Add('SELECT SaleID,Type,CustomerName,SaleDate,GlobalRef,InvoiceDocNumber,');
                  qryDest.SQL.Add('OriginalAmount,Balance,AmountOutstanding,');
                  qryDest.SQL.Add('ForeignOriginalAmt,ForeignBalanceAmount,');
                  qryDest.SQL.Add('ForeignAmountOutstanding,Payment,ForeignPayment,');
                  qryDest.SQL.Add('ForeignExchangeCode,ForeignExchangeRate,Paid,');
                  qryDest.SQL.Add('Discount,Withholding,Refunding,RefundPercent,Apply,RefNo,EnteredBy FROM ' + GuiTablename);
                  SalesOutStandingTrans(qrySource);

              end else begin

                  qryDest.SQL.Add('SELECT SaleID,Type,CustomerName,SaleDate,GlobalRef,InvoiceDocNumber,');
                  qryDest.SQL.Add('OriginalAmount,Balance,AmountOutstanding,');
                  qryDest.SQL.Add('ForeignOriginalAmt,ForeignBalanceAmount,');
                  qryDest.SQL.Add('ForeignAmountOutstanding,Payment,ForeignPayment,');
                  qryDest.SQL.Add('ForeignExchangeCode,ForeignExchangeRate,Paid,');
                  qryDest.SQL.Add('Discount,Withholding,Refunding,RefundPercent,Apply,RefNo,EnteredBy FROM ' + GuiTablename);
                  SalesPaymentLines(qrySource);
              end;
              qrySource.Open;
              qryDest.Open;
              while not qrySource.Eof do begin
                qryDest.Insert;
                for x:= 0 to qrySource.FieldCount -1 do
                    qryDest.Fields[x].Value:= qrySource.Fields[x].Value;
                qryDest.Post;
                qrySource.Next;
              end;
              qryDest.Close;
              qrySource.Close;
            finally
              qrySource.Free;
              qryDest.Free;
            end;
            SQLList.Add('UPDATE ' + GuiTablename + ' set ForeignOriginalAmt      = OriginalAmount   * ForeignExchangeRate Where ifnull(ForeignOriginalAmt,0)      = 0;');
            SQLList.Add('UPDATE ' + GuiTablename + ' set ForeignPayment          = Payment          * ForeignExchangeRate Where ifnull(ForeignPayment,0)          = 0;');
            SQLList.Add('UPDATE ' + GuiTablename + ' set ForeignBalanceAmount    = Balance          * ForeignExchangeRate Where ifnull(ForeignBalanceAmount,0)    = 0;');
            SQLList.Add('UPDATE ' + GuiTablename + ' set ForeignAmountOutstanding= AmountOutstanding* ForeignExchangeRate Where ifnull(ForeignAmountOutstanding,0)= 0;');
        End;
        ExecuteSQL(SQLList,true);
    Finally
        FreeAndNil(SQLList);
    end;
    Result      := TGUICustPaymentLines(getcontainerComponent(TGUICustPaymentLines));
    Result.Load;
    if Result.Count > 0 then Lock;
    if Lines.count = 0 then begin
        if Amount <> 0      then Amount      := 0;
        if applied <> 0     then Applied     := 0;
        if unapplied <> 0   then UnApplied   := 0;
    end;
 end;

Function TCustPayments.getPaymentLines :TcustPaymentLines;
begin
  Result := TCustPaymentLines(GetContainerComponent(TCustPaymentLines, 'PaymentID = ' + IntToStr(ID)));
end;

Constructor TCustPayments.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'CustPayments';
  fSQL                      := 'SELECT * FROM tbldeposits';
  fbDiscountApplied         := False;
  fbSurchargeApplied := false;
  fbAutoApplyDiscount       := False;
  fUpdatedSalesList:= TIntegerList.Create;
  fiOpenForSalesId := 0;
  ExportExcludeList.Add('SplitPaymentID');
  ExportExcludeList.Add('SplitPaymentLineID');
end;

Procedure TCustPayments.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Deposit');
  SetPropertyFromNode(node,'Deposited');
  SetPropertyFromNode(node,'DepositedBalance');
  SetPropertyFromNode(node,'DepositID');
  SetBooleanPropertyFromNode(node,'AutoApplyDiscount');
  SetPropertyFromNode(node,'SplitPaymentID');
  SetPropertyFromNode(node,'SplitPaymentLineID');
end;


Procedure TCustPayments.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Deposit'                  ,Deposit);
  AddXMLNode(node,'Deposited'                ,Deposited);
  AddXMLNode(node,'DepositedBalance'         ,DepositedBalance);
  AddXMLNode(node,'DepositID'                ,DepositID);
  AddXMLNode(node,'AutoApplyDiscount'        ,AutoApplyDiscount);
  AddXMLNode(node,'SplitPaymentID'           ,SplitPaymentID);
  AddXMLNode(node,'SplitPaymentLineID'       ,SplitPaymentLineID);
end;
Procedure TCustPayments.CallbackLock(Const Sender: TBusObj; var Abort: Boolean);
begin
    StepProgressbar;
    if not (Sender is TGUIPaymentLines) then exit;

    if TGUIPaymentLines(sender).TransType = PrePayType then begin
        if not Userlock.Lock('tblPrepayments', TGUIPaymentLines(Sender).TransID, self.LockGroupName ) then begin
            AddResult(False,rssWarning,0,
                StringReplace(userlock.LockMessage, 'this record' , 'Prepayment record#' +IntToStr(TGUIPaymentLines(Sender).TransID), [rfReplaceAll, rfIgnoreCase]));
            AlllinesValid := False;
            abort := True;
        end;
    end else begin
        if not Userlock.Lock('tblSales', TGUIPaymentLines(Sender).TransID, self.LockGroupName ) then begin
            AddResult(False,rssWarning,0,StringReplace(userlock.LockMessage, 'this record' , 'Sales record' + '#' +
                IntToStr(TGUIPaymentLines(Sender).TransID),[rfReplaceAll, rfIgnoreCase]));
            AlllinesValid := False;
            abort := True;
        end;
    end;
end;

Procedure TCustPayments.CorrectOtherPayments;
var
    strSQL:String;
begin
    if (isnew) or (deleted = CleanDeleted) then Exit;

    strSQL := 'SELECT  ' +
            ' OriginalDesposit.Payment, ' +
            ' OriginalDesposit.ForeignPayment,' +
            ' OtherDeposits.PaymentLineID , ' +
            ' OtherDepositsHeader.PaymentId' +
            ' from tbldepositline as OriginalDesposit, ' +
            ' tbldepositline as OtherDeposits , ' +
            ' tblDeposits as OtherDepositsHeader ' +
            ' where OtherDeposits.PaymentId         > OriginalDesposit.PaymentID' +
            ' AND   OtherDeposits.SaleID            = OriginalDesposit.SaleID   ' +
            ' AND   OtherDepositsHeader.PaymentId   = OtherDeposits.PaymentID   ' +
            ' AND   OriginalDesposit.PaymentId      = ' + IntToStr(ID)  +
            ' AND   OtherDepositsHeader.Deleted     = "F"' ;
    With GetNewDataset(strSQL,true) do try
        if recordCount > 0 then begin
            First;
            While Eof = False do begin
                if deleted then
                    StrSQL := ' update tbldepositline Set ' +
                        ' AmountOutstanding         = AmountOutstanding         + ' + FloatToStr(FieldByname('Payment').asFloat)        +',' +
                        ' AmountDue                 = AmountDue                 + ' + FloatToStr(FieldByname('Payment').asFloat)        +',' +
                        ' ForeignAmountOutstanding  = ForeignAmountOutstanding  + ' + FloatToStr(FieldByname('ForeignPayment').asFloat) +',' +
                        ' ForeignAmountDue          = ForeignAmountDue          + ' + FloatToStr(FieldByname('ForeignPayment').asFloat) +
                        ' where PaymentLineId       = ' + IntToStr(fieldByname('PaymentLineId').asInteger)
                else
                    StrSQL := ' update tbldepositline Set ' +
                        ' AmountOutstanding         = AmountOutstanding         - ' + FloatToStr(FieldByname('Payment').asFloat)        +',' +
                        ' AmountDue                 = AmountDue                 - ' + FloatToStr(FieldByname('Payment').asFloat)        +',' +
                        ' ForeignAmountOutstanding  = ForeignAmountOutstanding  - ' + FloatToStr(FieldByname('ForeignPayment').asFloat) +',' +
                        ' ForeignAmountDue          = ForeignAmountDue          - ' + FloatToStr(FieldByname('ForeignPayment').asFloat) +
                        ' where PaymentLineId       = ' + IntToStr(fieldByname('PaymentLineId').asInteger);
                PostList.AddQuery(strSQL , FieldByname('PaymentId').asInteger ,'tblDeposits' );
                Next;
            end;
        end;
    finally
        if Active then close;
        Free;
    end;

end;

Function    TCustPayments.Lock                : Boolean ;
begin
    if IsPaymentDeposited then begin
      LockMsg := LockMsgDeposited;
      result:= false;
      exit;
    end;

    Result := inherited Lock;

    if Result then begin

        UserLock.OnUnlockItem:= DoOnUserLockOnUnlockItem;
        ShowProgressbar(UserLock.LockList.Count, 'Unlocking the Transactions');
        try
          UserLock.Unlock(self.LockGroupName );
        finally
          UserLock.OnUnlockItem:= nil;
          HideProgressbar;
        end;

        AlllinesValid := true;
        showProgressbar(GUILInes.count , 'Locking the Transactions');
        try
          GUILines.Iteraterecords(CallbackLock);
          Result := AlllinesValid ;
          if result then inherited Lock;
        finally
          HideProgressbar;
        end;
    end else begin
      if lockmsg <> '' then
        if silentMode then
          AddResult(False, rssWarning, 0,lockmsg);
    end;
end;

Procedure TCustPayments.CallbackCreateLines(Const Sender: TBusObj; var Abort: Boolean);
begin
    StepProgressbar;
    if not (Sender is TGuiCustPaymentLines) then Exit;
    if TGuiCustPaymentLines(Sender).Applied = False then Exit;
    Lines.New;
    Lines.TrnType := TGuiCustPaymentLines(Sender).TransType;
    if Lines.TrnType <> PrePayType then
        lines.SaleID := TGuiCustPaymentLines(Sender).TransID
    else
        Lines.PrePaymentID := TGuiCustPaymentLines(Sender).TransID;

    Lines.TransDate                 := TGuiCustPaymentLines(Sender).TransDate;
    Lines.TransNo                   := TGuiCustPaymentLines(Sender).TransNumber;
    Lines.OriginalAmount            := TGuiCustPaymentLines(Sender).OriginalAmount;
    Lines.ForeignOriginalAmt        := LocalToForeign(Lines.OriginalAmount , TGuiCustPaymentLines(Sender).ForeignExchangeRate , CurrencyRoundPlaces);
    Lines.AmountDue                 := TGuiCustPaymentLines(Sender).AmountDue;
    Lines.Payment                   := TGuiCustPaymentLines(Sender).payment;
    Lines.AmountOutstanding         := TGuiCustPaymentLines(Sender).AmountDue-TGuiCustPaymentLines(Sender).payment;
    Lines.ForeignPayment            := LocalToForeign(Lines.Payment , TGuiCustPaymentLines(Sender).ForeignExchangeRate , CurrencyRoundPlaces);
    Lines.ForeignOutStanding        := LocalToForeign(Lines.AmountOutstanding , TGuiCustPaymentLines(Sender).ForeignExchangeRate , CurrencyRoundPlaces);
    Lines.ForeignAmountDue          := LocalToForeign(Lines.AmountDue , TGuiCustPaymentLines(Sender).ForeignExchangeRate , CurrencyRoundPlaces);
    if Lines.AmountOutstanding=0 then
            Lines.PaidInFull        := 'Yes'
    else    Lines.PaidInFull        := 'No';
    Lines.RefNo                     := TGuiCustPaymentLines(Sender).RefNo;
    Lines.SplitForeignExchangeCode := TGuiCustPaymentLines(Sender).SplitForeignExchangeCode ;
    Lines.SplitForeignExchangeRate := TGuiCustPaymentLines(Sender).SplitForeignExchangeRate ;
    Lines.SplitForeignPayment      := TGuiCustPaymentLines(Sender).SplitForeignPayment      ;
    Lines.PostDB;
end;
Procedure TCustPayments.CallbackUpdateLines(Const Sender: TBusObj; var Abort: Boolean);
var
    strSQL :String;
begin
    {here I assume that the payment amount cannot be changed once if the record is saved
    only can delete or undelete

    note: Otherwise shoudl take the cleanPayment-payment}

    {if the payment is 0, nothing to be done. }
    StepProgressbar;
    if (TGuiCustPaymentLines(Sender).payment = 0) and
        (TGuiCustPaymentLines(Sender).ForeignPayment =0) then exit;


    if TGuiCustPaymentLines(Sender).TransType = PrePaytype then begin
        if not Deleted then begin
            strSQL := 'update tblprepayments ' +
                        ' Set Payment           =round(ifnull(Payment,0) - ' +FloatToStr(TGuiCustPaymentLines(Sender).payment)+','+inttostr(CurrencyRoundPlaces)+')' +',' +
                        ' ForeignPayment        =round(ifnull(ForeignPayment,0) - ' +FloatToStr(TGuiCustPaymentLines(Sender).ForeignPayment)+','+inttostr(CurrencyRoundPlaces)+')' +','+
                        ' Balance               =round(ifnull(Balance,0)+' +FloatToStr(TGuiCustPaymentLines(Sender).payment)+','+inttostr(CurrencyRoundPlaces)+')' +',' +
                        ' ForeignBalance        =round(ifnull(ForeignBalance,0) +' +FloatToStr(TGuiCustPaymentLines(Sender).ForeignPayment)+','+inttostr(CurrencyRoundPlaces)+')' +
                        ' where PrePaymentID    = ' + IntToStr(TGuiCustPaymentLines(Sender).TransID) +';' ;
            PostList.AddAmount('TAccount' , TAccount.GetBusObjectTablename, TGuiCustPaymentLines(Sender).PrepaymentAccountID , -TGuiCustPaymentLines(Sender).payment);
        end else begin
            strSQL := 'update tblprepayments ' +
                        ' Set Payment           =round(ifnull(Payment,0) + ' +FloatToStr(TGuiCustPaymentLines(Sender).payment)+','+inttostr(CurrencyRoundPlaces)+')' +',' +
                        ' ForeignPayment        =round(ifnull(ForeignPayment,0) + ' +FloatToStr(TGuiCustPaymentLines(Sender).ForeignPayment)+','+inttostr(CurrencyRoundPlaces)+')' +','+
                        ' Balance               =round(ifnull(Balance,0)-' +FloatToStr(TGuiCustPaymentLines(Sender).payment)+','+inttostr(CurrencyRoundPlaces)+')' +',' +
                        ' ForeignBalance        =round(ifnull(ForeignBalance,0) - ' +FloatToStr(TGuiCustPaymentLines(Sender).ForeignPayment)+','+inttostr(CurrencyRoundPlaces)+')' +
                        ' where PrePaymentID    = ' + IntToStr(TGuiCustPaymentLines(Sender).TransID) +';' ;
            PostList.AddAmount('TAccount' , TAccount.GetBusObjectTablename, TGuiCustPaymentLines(Sender).PrepaymentAccountID , TGuiCustPaymentLines(Sender).payment);
        end;
        PostList.AddQuery(strSQL , TGuiCustPaymentLines(Sender).TransID , 'tblPrepayments', False);
        strSQL :=     'update tblprepayments set Paid = "T" where Balance = 0 ' +
                        ' and PrePaymentID = ' + IntToStr(TGuiCustPaymentLines(Sender).TransID);
        PostList.AddQuery(strSQL , TGuiCustPaymentLines(Sender).TransID , 'tblPrepayments', False);
        strSQL :=     'update tblprepayments set Paid = "F" where Balance <> 0 ' +
                        ' and PrePaymentID = ' + IntToStr(TGuiCustPaymentLines(Sender).TransID);
        PostList.AddQuery(strSQL , TGuiCustPaymentLines(Sender).TransID , 'tblPrepayments', False);
    end else begin
        if not Deleted then begin
            strSQL := 'update tblSales ' +
                        ' Set Payment           = round(ifnull(Payment,0)            + ' +FloatToStr(TGuiCustPaymentLines(Sender).payment) +','+inttostr(CurrencyRoundPlaces)+')'+',' +
                        ' ForeignPaidAmount     = round(ifnull(ForeignPaidAmount,0)  + ' +FloatToStr(TGuiCustPaymentLines(Sender).ForeignPayment(* TGuiCustPaymentLines(Sender).ForeignPaymentinTranscur*) )+','+inttostr(CurrencyRoundPlaces)+')' +',' +
                        ' Balance               = round(ifnull(Balance,0)     -  ' +FloatToStr(TGuiCustPaymentLines(Sender).payment)+','+inttostr(CurrencyRoundPlaces)+')' +',' +
                        ' ForeignBalanceAmount  = round(ifnull(ForeignBalanceAmount,0) - ' +FloatToStr(TGuiCustPaymentLines(Sender).ForeignPayment(* TGuiCustPaymentLines(Sender).ForeignPaymentinTranscur*) )+','+inttostr(CurrencyRoundPlaces)+')' +
                        ' where SaleID          = ' + IntToStr(TGuiCustPaymentLines(Sender).TransID)+';' ;

        end else begin
            strSQL := 'update tblSales ' +
                        ' Set Payment           = round(ifnull(Payment,0)            - ' +FloatToStr(TGuiCustPaymentLines(Sender).payment)+','+inttostr(CurrencyRoundPlaces)+')' +',' +
                        ' ForeignPaidAmount     = round(ifnull(ForeignPaidAmount,0)  - ' +FloatToStr(TGuiCustPaymentLines(Sender).ForeignPayment(* TGuiCustPaymentLines(Sender).ForeignPaymentinTranscur*) )+','+inttostr(CurrencyRoundPlaces)+')' +','+
                        ' Balance               = round(ifnull(Balance,0)     + ' +FloatToStr(TGuiCustPaymentLines(Sender).payment)+','+inttostr(CurrencyRoundPlaces)+')' +',' +
                        ' ForeignBalanceAmount  = round(ifnull(ForeignBalanceAmount,0) +' +FloatToStr(TGuiCustPaymentLines(Sender).ForeignPayment(* TGuiCustPaymentLines(Sender).ForeignPaymentinTranscur*) )+','+inttostr(CurrencyRoundPlaces)+')' +
                        ' where SaleID          = ' + IntToStr(TGuiCustPaymentLines(Sender).TransID) +';' ;
        end;
        PostList.AddQuery(strSQL , TGuiCustPaymentLines(Sender).TransID , 'tblSales', False);
        strSQL := 'update tblSales set Paid = "T" where Balance = 0 ' +
                    ' and SaleID = ' + IntToStr(TGuiCustPaymentLines(Sender).TransID) +';' ;
        PostList.AddQuery(strSQL , TGuiCustPaymentLines(Sender).TransID , 'tblSales', False);

        strSQL := 'update tblSales set Paid = "F" where Balance <> 0 ' +
                    ' and SaleID = ' + IntToStr(TGuiCustPaymentLines(Sender).TransID) +';' ;
        PostList.AddQuery(strSQL , TGuiCustPaymentLines(Sender).TransID , 'tblSales', False);

        strSQL := 'update tblSales Set HoldSale ="F" where Balance = 0 ' +
                    ' and SaleID = ' + IntToStr(TGuiCustPaymentLines(Sender).TransID) +';' ;
        PostList.AddQuery(strSQL , TGuiCustPaymentLines(Sender).TransID , 'tblSales', False);

    end;
end;
Procedure TCustPayments.CreateLines;
begin
  ShowProgressbar(GUILines.Count, 'Check for Customer''s Transactions');
  try
    GuiLines.IterateRecords(CallbackCreateLines);
  finally
    HideProgressbar;
  end;
end;
Procedure TCustPayments.UpdateLines;
begin
    if (not(Isnew)) and (Deleted = Cleandeleted) then Exit;
    ShowProgressbar(GUILines.Count, 'Update Transactions');
    try
      GuiLines.IterateRecords(CallbackUpdateLines);
    finally
      HideProgressbar;
    end;
end;

Procedure TCustPayments.UpdateBankdeposit(forceDeletion:Boolean =False);
begin
    if (not isnew) and (cleanDeleted = Deleted ) then if forceDeletion =False then  Exit;
    if (not isnew) and (cleanDeleted = Deleted ) then if forceDeletion =False then  Exit;
        if Deleted then begin
          Deposited := False;
          PostList.AddQuery('Delete  tblbankdeposit.*   ' +
                 ' FROM tblbankdeposit ' +
                 ' INNER JOIN tblbankdepositlines  ' +
                 ' ON  tblbankdepositlines.DepositID = tblbankdeposit.DepositID ' +
                 ' WHERE tblbankdepositlines.PaymentID =' + IntToStr(ID) +
                 ' AND tblbankdepositlines.TrnsType =' + quotedStr(TransType));
          PostList.AddQuery('Delete  tblbankdepositlines.*   ' +
                 ' FROM tblbankdepositlines ' +
                 ' WHERE tblbankdepositlines.PaymentID =' + IntToStr(ID) +
                 ' AND tblbankdepositlines.TrnsType =' + quotedStr(TransType));
        end else if (Sysutils.SameText(tcDatautils.GetAccountName(AccountID),UNDEPOSITED_FUNDS)) then
          Deposited := False
        else begin
          Deposited := False;
          CreateDeposits
        end;
end;
Procedure TCustPayments.CreateDeposits;
begin
    {header}
    if Deleted then Exit;
    BankDeposit.New;
    BankDeposit.Depositdate          := PaymentDate;
    BankDeposit.PostDB;
    BankDeposit.EmployeeId           := EmployeeID;
    BankDeposit.classId              := ClassID;
    BankDeposit.AccountId            := AccountId;
    BankDeposit.Notes                := Notes;
    BankDeposit.Deposit              := amount;
    BankDeposit.Deleted              := False;
    BankDeposit.PostDB;
    {details}
    BankDeposit.Lines.New;
    BankDeposit.Lines.PaymentID      := Self.ID;
    BankDeposit.Lines.TrnsType       := Transtype;
    BankDeposit.Lines.CusID          := ClientID;
    BankDeposit.Lines.PayMethodID    := PayMethodID;
    BankDeposit.Lines.PaymentMethod  := tcDatautils.GetPaymentMethod(PayMethodID);
    BankDeposit.Lines.PaymentDate    := PaymentDate;
    BankDeposit.Lines.Companyname    := companyName;
    BankDeposit.Lines.Referenceno    := ReferenceNo;
    BankDeposit.Lines.ClassId        := ClassId;
    BankDeposit.Lines.AccountID      := AccountId;
    BankDeposit.Lines.Amount         := amount;
    BankDeposit.Lines.Name           := '';
    BankDeposit.Lines.Notes          := Notes;
    BankDeposit.Lines.Customer       := True;
    BankDeposit.Lines.Supplier       := False;
    BankDeposit.Lines.Employee       := False;
    BankDeposit.Lines.contact        := false;
    BankDeposit.Lines.Deposited      := True;
    BankDeposit.Lines.Statementno    := 0;
    BankDeposit.Lines.FromDeposited  := False;
    BankDeposit.Lines.PostDB;
end;

Procedure TCustPayments.udpateBalance;
var
    PrepaymentAmount : Double;
    ARPaymentAmount  : Double;
    Function GetPrepaymentAccountID : Integer;
    begin
        Result := tcDatautils.GetAccountID(GLACCOUNT_CUSTPREPAYMENT);
    end;
begin
    if (not ISNew) and (cleanDeleted = Deleted) then Exit;

    PrepaymentAmount := GetPrepaymentAmount;
    ARPaymentAmount  := Amount - PrepaymentAmount;
    if (AppEnv.CompanyPrefs.UseForeignCurrencyonSales) and (ISFCSelected) then
        ARPaymentAmount := ARPaymentAmount - ForeignVariationAmount;

    if not Deleted then begin
        PostList.AddAmount('TAccount', TAccount.GetBusObjectTablename, tcDatautils.GetAccountReceivableID,-ARPaymentAmount,btnormal, False);
        PostList.AddAmount('TAccount', TAccount.GetBusObjectTablename, AccountID,Amount,btnormal, False);
        if (AppEnv.CompanyPrefs.UseForeignCurrencyonPO) and (ISFCSelected) then
            PostList.AddAmount('TAccount', TAccount.GetBusObjectTablename, ForeignVariationAccountID,ForeignVariationAmount,btnormal, False);
    end;
    if (not ISNew) and (Deleted) then begin
        PostList.AddAmount('TAccount', TAccount.GetBusObjectTablename, tcDatautils.GetAccountReceivableID,ARPaymentAmount,btnormal, False);
        PostList.AddAmount('TAccount', TAccount.GetBusObjectTablename, AccountID,-Amount,btnormal, False);
        if (AppEnv.CompanyPrefs.UseForeignCurrencyonPO) and (ISFCSelected) then
            PostList.AddAmount('TAccount', TAccount.GetBusObjectTablename, ForeignVariationAccountID,-ForeignVariationAmount,btnormal, False);
    end;
    ShowProgressbar(GUILines.Count, 'Update Transaction Balances');
    try
      GuiLines.IterateREcords(UpdateclientBalance);
    finally
      HideProgressbar;
    end;
end;
Procedure TCustPayments.UpdateclientBalance(Const Sender: TBusObj; var Abort: Boolean);
begin
    StepProgressbar;
    if not (Sender is TGuiCustPaymentLines) then Exit;
    if not TGuiCustPaymentLines(Sender).Applied then Exit;
    if Deleted then
        PostList.AddAmount(client.ClassName, client.GetBusObjectTablename,ClientID, TGuiCustPaymentLines(Sender).Payment,btAR)
    else
        PostList.AddAmount(client.ClassName, client.GetBusObjectTablename,ClientID, -TGuiCustPaymentLines(Sender).Payment,btAR);
end;

Function TCustPayments.Save: Boolean;
var
  msg: string;
begin
  if SilentMode then
    if CleanID = 0 then
      CalcTotals(True);

  ValidationStage := 1;
  PostDB;
(*    result:= validateData;
  if not result then Exit;*)
  Result := inherited Save;
  if not Result then Exit;
  {invoices are saved if the Discount/withholding are given. Payment will not
  be applied in that case}
  if (not DiscountApplied) then
    if (TotalDiscount <> 0) or (TotalWithholding <> 0) or (TotalRefunding <> 0)then begin
      if (SilentMode) and (AutoApplyDiscount) then begin
        Result := AddDiscounttoSale(msg);
        if Result then
          AddResult(True, rssInfo , 0 , 'Invoices are updated for the Discount/Withholding/Refunding')
        else begin
          AddResult(false, rssWarning, 0, msg);
          Exit;
        end;
      end else begin
          Result := False;
          AddResult(False, rssWarning, 0, 'Please apply Discounts/Withholding/Refunding before Saving.');
          Exit;
      end;
    end;

  Self.Connection.BeginNestedTransaction;
  try
    PostList.Clear;
    IsNew := Lines.count = 0;
    if ISNew  then CreateLines;
    UpdateLines;
    udpateBalance;
    updateBankdeposit;
    CorrectOtherPayments;
    if not PostList.Execute then begin
      Result := False;
      Exit;
    end;
  finally
    if not Result then begin
      Self.Connection.RollbackNestedTransaction;
      Lines.CloseDb;
      Lines;
    end;
  end;
  Self.Connection.CommitNestedTransaction;
  ValidationStage := 2;
  if not Self.ValidateLines then begin
    Result := False;
    Exit;
  end;
  Dirty := False;
end;

Function TCustPayments.ValidateData: Boolean;
var
  str: String;
begin
  if Self.Deleted then begin
    if TCardPayment.PaymentMade(self.ClassName,ID,Connection.Connection.Database,Connection.Connection.Server) then begin
      AddResult(False, rssWarning, 0 ,'Can not delete a payment with a Processed Card Payment.');
      Result := False;
      Exit;
    end
    else begin
      result:= true;
      exit;
    end;
  end;

  if ClientId = 0 then begin
    AddResult(False, rssWarning, 0, 'Customer blank or not found.');
    Result := False;
    Exit;
  end;

  if Client.ClientName = '' then begin
    AddResult(False, rssWarning, 0, 'Customer not found for ID: ' + IntToStr(self.ClientID));
    Result := False;
    Exit;
  end;

  if (not Deleted) and Self.CleanDeposited then begin
    AddResult(False, rssWarning, 0, 'Can not Save, Payment has been deposited.');
    Result := False;
    Exit;
  end;

  if (PaymentDate <= AppEnv.CompanyPrefs.ClosingDate) or (PaymentDate <= AppEnv.CompanyPrefs.ClosingDateAR) then begin
    str := 'You have set this date before the closing date !' +
            'the date will automatically be set to today''s date OR '+
            'reset the Closing Date In Preferences.';
    AddResult(True, rssinfo, 0, str);
    PaymentDate := Now;
    ForeignExchangeRate := getExchageSellRate;
    DoFieldOnChange(Dataset.findfield('ForeignExchangeRate'));
  end;

  Result := inherited ValidateData;
  if not Result then Exit;

  if PayMethodID = 0 then begin
    AddResult(False, rssWarning, 0, 'Payment method should not be blank.');
    Result := False;
    Exit;
  end;

  if AccountID = 0 then begin
    AddResult(False, rssWarning, 0, 'Account should not be blank.');
    Result := False;
    Exit;
  end;

  if not IsZero(ForeignVariationAmount, 0.00001) then
    if ForeignVariationAccountID = 0 then begin
      AddResult(False, rssWarning, 0, 'Variation account should not be blank.');
      Result := False;
      Exit;
    end;

  if not IsZero(Unapplied, 0.00001) then begin
      AddResult(False, rssWarning, 0, 'Payment cannot be saved with an unapplied amount');
      Result := False;
      Exit;
  end;
end;

Procedure TCustPayments.RefreshguiLines;
begin
    SendEvent(BusobjEvent_Event, BusObjEventVal_BeforeRefreshGuiLines);
    try
      Container.clear(TGuiCustPaymentLines);
      GUILines;
      if assigned(ChangeDisplayLabel) then ChangeDisplayLabel;
    finally
      SendEvent(BusobjEvent_Event, BusObjEventVal_AfterRefreshGuiLines);
    end;
end;

Function TCustPayments.AddDiscounttoSale(var msg: string) :Boolean;
begin
  Result := true;
  if fbDiscountApplied then Exit;
  Connection.BeginNestedTransaction;
  try
    AllLinesValid := False;
    ShowProgressbar(GUILines.Count, 'Add Discounts');
    try
      GuiLines.IterateRecords(CallBackAddDiscounttoSale);
    finally
      HideProgressbar;
    end;
    Result := AllLinesValid;
    if Result then begin
        RefreshguiLines;
        fbDiscountApplied := true;
        if not silentMode then begin
            CalcTotals;
        end;
       connection.CommitNestedTransaction;
       result:= true;
       SendEvent(BusObjEvent_Change,BusobjEventVal_SalesDiscountApplied, self);
    end else begin
      msg := ResultStatus.Messages;
      result:= false;
      connection.RollbackNestedTransaction;
    end;
  Except
    result:= false;
    connection.RollbackNestedTransaction;
  end;
end;

Function TCustPayments.AddSalesLine(Const fInvoiceObj :TInvoice; Const ProductName :String; Const Price,Qty :Double; msg: string) :Boolean;
var
  SEQNo,sortID:Integer;
begin
    Result := False;
    if fInvoiceObj.Dataset.recordcount = 0 then Exit;
    fInvoiceObj.UserLock.enabled := false; // the record is locked by the repayment so safe to overWrite.
    fInvoiceObj.lines.Last;
    SeqNo := fInvoiceObj.lines.SeqNo;
    SortId := fInvoiceObj.lines.SortID;
    fInvoiceObj.lines.New;
    fInvoiceObj.lines.ProductName    := Productname;
    fInvoiceObj.lines.UOMMultiplier  := 1;
    fInvoiceObj.lines.UOMQtySold     := Qty;
    fInvoiceObj.lines.UOMQtyShipped  := Qty; //-1;
    fInvoiceObj.lines.LinePriceInc   := Price;
    fInvoiceObj.lines.SeqNo:= SeqNo+1;
    fInvoiceObj.lines.SortID:= SortID+10;
    fInvoiceObj.Lines.PostDB;
    fInvoiceObj.ResultStatus.Clear;
    if fInvoiceObj.Lines.ValidateData then begin
      fUpdatedSalesList.AddIfNotInList(fInvoiceObj.ID);
      Result := true;
    end
    else
      msg := fInvoiceObj.ResultStatus.Messages;
end;

Function TCustPayments.MakeRefund(Const fInvoiceObj :TInvoice;
  Const Price,Qty :Double; IsEarlyPaymentDiscount: boolean; var msg: string) :Boolean;
var
  RefundObj :TRefundSale;
begin
    Result := False;
    if fInvoiceObj.Dataset.recordcount = 0 then Exit;
    RefundObj := TRefundSale.CreateWithNewConn(nil);
    try
      RefundObj.Connection.BeginTransaction;

      RefundObj.SilentMode := True;
      { only want one Refund for any refund ammounts .. so check if one evists .. }
      RefundObj.LoadSelect('ChequeNo = ' + QuotedStr('Cust Pmt ' + IntToStr(ID)) + ' and ForeignExchangeCode = ' + QuotedStr(fInvoiceObj.ForeignExchangeCode));
      if RefundObj.Count = 0 then begin
        RefundObj.New;
        RefundObj.CustomerName :=fInvoiceObj.CustomerName;
        RefundObj.SaleDate := Date;
        RefundObj.ChequeNumber := 'Cust Pmt ' + IntToStr(ID);
        RefundObj.ShipToDesc:=fInvoiceObj.ShipToDesc;
        RefundObj.InvoiceToDesc:=fInvoiceObj.InvoiceToDesc;
        RefundObj.SaleClassName := fInvoiceObj.SaleClassName;
        RefundObj.ForeignExchangeCode:= fInvoiceObj.ForeignExchangeCode;
        RefundObj.ForeignExchangeRate:= fInvoiceObj.ForeignExchangeRate;
        RefundObj.Comments := 'Refund created from Customer Payment #' + inttostr(ID); // + ' for invoice # ' + inttostr(fInvoiceObj.ID);
        RefundObj.PostDB;
      end;
      RefundObj.InvoiceRefund := true;

      RefundObj.Lines.New;
      if IsEarlyPaymentDiscount then
        RefundObj.Lines.ProductName := EARLY_PAYMENT_DISCOUNT_PRODUCT
      else
        RefundObj.Lines.ProductName := PART_DOL_DISC;
      RefundObj.Lines.RefundQty := Qty;
      RefundObj.Lines.LinePriceInc := Price;
      RefundObj.Lines.Product_Description := 'Refund for Invoice: ' + IntToStr(fInvoiceObj.ID);
      RefundObj.Lines.PostDB;
      if RefundObj.Save then begin
        result := true;
        RefundObj.Connection.CommitTransaction;
        fUpdatedSalesList.AddIfNotInList(fInvoiceObj.ID);
        fUpdatedSalesList.AddIfNotInList(RefundObj.ID);
      end
      else begin
        msg := RefundObj.ResultStatus.Messages;
        RefundObj.Connection.RollbackTransaction;
      end;
    finally
      Freeandnil(RefundObj);
    end;
end;

function TCustPayments.AddSurchargeToSale(const Percent: double): Boolean;
begin
  Result := true;
  if fbSurchargeApplied then Exit;
  fSurchargePercent:= Percent;
  Connection.BeginNestedTransaction;
  try
    AllLinesValid := False;
    ShowProgressbar(GUILines.Count, 'Add Surcharges to Sale');
    try
      GuiLines.IterateRecords(CallBackAddSurchargeToSale);
    finally
      HideProgressbar;
    end;
    Result := AllLinesValid;
    if Result then begin
        RefreshguiLines;
        fbSurchargeApplied := true;
       connection.CommitNestedTransaction;
       result:= true;
    end else begin
      result:= false;
      Connection.RollbackNestedTransaction;
    end;
  Except
    result:= false;
    Connection.RollbackNestedTransaction;
  end;
end;

Procedure TCustPayments.CallBackAddDiscounttoSale(Const Sender: TBusObj; var Abort: Boolean);
var
  fbFlag:Boolean;
  DiscProd: string;
  msg: string;
begin
    StepProgressbar;
    if not (Sender is TGuiCustPaymentLines) then Exit;
    if TGuiCustPaymentLines(Sender).TransType =PrePayType then Exit;
    if (TGuiCustPaymentLines(Sender).Discount = 0) and
        (TGuiCustPaymentLines(Sender).Withholding = 0) and
        (TGuiCustPaymentLines(Sender).Refunding = 0) then exit;
    Try
        if (TGuiCustPaymentLines(Sender).Discount <> TGuiCustPaymentLines(Sender).CleanDiscount)  then begin
            if TGuiCustPaymentLines(Sender).IsEarlyPaymentDiscount then
              DiscProd := EARLY_PAYMENT_DISCOUNT_PRODUCT
            else
              DiscProd := PAYMENT_Discount_PRODUCT;
            if not AddSalesLine(TGuiCustPaymentLines(Sender).InvoiceObj, DiscProd, TGuiCustPaymentLines(Sender).Discount, -1,msg) then begin
                AddResult(false,rssWarning,0,'Could not add Line to Invoice: ' + msg);
                abort := true;
                Exit;
            End;
            fbFlag:=TGuiCustPaymentLines(Sender).InvoiceObj.OverrideHoldSale;
            TGuiCustPaymentLines(Sender).InvoiceObj.OverrideHoldSale := True;
            try
              if not TGuiCustPaymentLines(Sender).InvoiceObj.Save then begin
                  msg := TGuiCustPaymentLines(Sender).InvoiceObj.ResultStatus.Messages;
                  AddResult(false,rssWarning,0,'Could not add Line to Invoice: ' + msg);
                  abort := True;
                  Exit;
              End;
            finally
              TGuiCustPaymentLines(Sender).InvoiceObj.OverrideHoldSale := fbFlag;
            end;
        end;
        if (TGuiCustPaymentLines(Sender).Withholding <> TGuiCustPaymentLines(Sender).CleanWithholding) then begin
            if not AddSalesLine(TGuiCustPaymentLines(Sender).InvoiceObj, INVOICE_RETENTION_PRODUCT , TGuiCustPaymentLines(Sender).Withholding, -1, msg) then  begin
                AddResult(false,rssWarning,0,'Could not add Line to Invoice: ' + msg);
                abort := True;
                Exit;
            end;
            fbFlag:=TGuiCustPaymentLines(Sender).InvoiceObj.OverrideHoldSale;
            TGuiCustPaymentLines(Sender).InvoiceObj.OverrideHoldSale := True;
            try
              if not TGuiCustPaymentLines(Sender).InvoiceObj.Save then begin
                  msg := TGuiCustPaymentLines(Sender).InvoiceObj.ResultStatus.Messages;
                  AddResult(false,rssWarning,0,'Could not add Line to Invoice: ' + msg);
                  abort := True;
                  Exit;
              End;
            finally
              TGuiCustPaymentLines(Sender).InvoiceObj.OverrideHoldSale := fbFlag;
            end;
        end;
        if (TGuiCustPaymentLines(Sender).Refunding <> TGuiCustPaymentLines(Sender).CleanRefunding) then
            if not MakeRefund(TGuiCustPaymentLines(Sender).InvoiceObj, TGuiCustPaymentLines(Sender).Refunding, 1, TGuiCustPaymentLines(Sender).IsEarlyPaymentDiscount, msg) then  begin
              AddResult(false,rssWarning,0,'Could not create Refund: ' + msg);
              abort := True;
              Exit;
            end;
    finally
        AllLinesValid := true;
    end;
end;

procedure TCustPayments.CallBackAddSurchargeToSale(const Sender: TBusObj;
  var Abort: Boolean);
var
  Inv: TInvoice;
  SurchargeAmount: double;
  fbFlag:Boolean;
  msg: string;
begin
  StepProgressbar;
  if not (Sender is TGuiCustPaymentLines) then Exit;
  if TGuiCustPaymentLines(Sender).TransType = PrePayType then Exit;
  if not TGuiCustPaymentLines(Sender).Applied then exit;

  try
    Inv := TGuiCustPaymentLines(Sender).InvoiceObj;
    // first does invoice already have a surcharge line
    if Inv.Lines.Dataset.Locate('ProductName',PART_PCENT_SURCH,[loCaseInsensitive]) then begin
      // how much should the surcharge be
      SurchargeAmount := Round((fSurchargePercent/100) * (Inv.TotalAmountInc - Inv.Lines.TotalLineAmountInc), 2);
      if Inv.Lines.LinePriceInc <> SurchargeAmount then begin
        // change to corrent/new discount
        Inv.Lines.LinePriceInc := SurchargeAmount;

        fbFlag:=Inv.OverrideHoldSale;
        Inv.OverrideHoldSale := True;
        try
          if not Inv.Save then begin
            abort := true;
            exit;
          end;
        finally
         Inv.OverrideHoldSale := fbFlag;
        end;
      end;
    end
    else begin
      // no surcharge line found
      // calculate the surcharge amount
      SurchargeAmount := Round((fSurchargePercent/100) * Inv.TotalAmountInc, 2);
      // add the surcharge line to invoice
      if not AddSalesLine(Inv,PART_PCENT_SURCH,SurchargeAmount,1,msg) then begin
        abort := true;
        exit;
      end;
        fbFlag:=Inv.OverrideHoldSale;
        Inv.OverrideHoldSale := True;
        try
          if not Inv.Save then begin
            abort := true;
            exit;
          end;
        finally
         Inv.OverrideHoldSale := fbFlag;
        end;
    end;
  finally
    AllLinesValid := true;
  end;
end;

Procedure TCustPayments.UpdateFCHistory;
var
    BuyRate, SellRate:Double;
begin
    if not Assigned(confirmFromGUI) then Exit;
    if not IsFCSelected then Exit;
    if AppEnv.CompanyPrefs.UseForeignCurrencyonSales then begin
        With TForeignExchangeObj.Create do Try
            GetForeignExchangeRatesForDate(ForeignExchangeCode, PaymentDate, BuyRate, SellRate);
            if ForeignExchangeRate <> SellRate then
                if fconfirmFromGUI('Do you want to update the rate in "Foreign Exchange Rate" list for ' + ForeignExchangeCode + '?',[mbYes, mbNo]) = mrYes then
                    AddForeignExchangeRateHistory(tcdatautils.getCurrencyID(ForeignExchangeCode),BuyRate, ForeignExchangeRate, PaymentDate);
        finally
          Free;
        end;
    end;
end;

Class Function  TCustPayments.GetBusObjectTablename :String;
begin
    Result:= 'tbldeposits';
end;

Procedure TCustPayments.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  fbDiscountApplied := False;
  fbSurchargeApplied := false;
  fiOpenForSalesId := 0;
end;

Procedure TCustPayments.CallbackCalcTotals(Const Sender: TBusObj; var Abort: Boolean);
begin
  StepProgressbar;
  inherited  CallbackCalcTotals(sender , abort);
  if Abort then Exit;
  fdTotalDiscount    := fdTotalDiscount    + TGuiCustPaymentLines(Sender).Discount;
  fdTotalwithholding := fdTotalwithholding + TGuiCustPaymentLines(Sender).Withholding;
  fdTotalRefunding := fdTotalRefunding + TGuiCustPaymentLines(Sender).Refunding;
end;
Function  TCustPayments.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
    Result := inherited DoAfterInsert(Sender);
    if not Result then exit;
    AutoApplyDiscount           := False;
    Customer                    := True;
    Payment                     := True;
    PaymentDate                 := Date;
    ClassID                     := AppEnv.DefaultClass.ClassID;
    AccountID                   := AppEnv.CompanyPrefs.DefaultCustPaymentAccount;
    ForeignVariationAccountID   := AppEnv.CompanyPrefs.CustomerPaymentsDefaultVariationAccountID;
    Amount                      := 0;
    Credit                      := 0;
    Applied                     := 0;
    UnApplied                   := 0;
    Applied                     := 0;
    UnApplied                   := 0;
    ForeignApplied              := 0;
    ForeignUnApplied            := 0;

    //EnteredBy   :=     { TODO :  }
    RefreshguiLines;
    fUpdatedSalesList.Clear;
end;
Procedure TCustPayments.ValidateFCofapplied(Const Sender: TBusObj; var Abort: Boolean);
begin
    StepProgressbar;
    if not(Sender is TGuicustPaymentlines) then Exit;
    if TGuicustPaymentlines(Sender).ForeignExchangeCode <> ForeignExchangeCode then
        if TGuicustPaymentlines(Sender).Applied then
            TGuicustPaymentlines(Sender).applied := False;
end;
Procedure TCustPayments.DoFieldOnChange(Sender: TField);
    var
        str:String;
    Function Isamountfield:Boolean;
    begin
         Result :=  (Sysutils.SameText(Sender.FieldName , 'Amount'               )) or
                    (Sysutils.SameText(Sender.FieldName , 'Applied'              )) or
                    (Sysutils.SameText(Sender.FieldName , 'UnApplied'            )) or
                    (Sysutils.SameText(Sender.FieldName , 'ForeigncurrencyAmount')) or
                    (Sysutils.SameText(Sender.FieldName , 'Foreignapplied'       )) or
                    (Sysutils.SameText(Sender.FieldName , 'Foreignunapplied'     ));
    END;
    Procedure UpdateAmounts;
    begin
        if Sysutils.SameText(Sender.FieldName , 'Amount')                then begin
            UnApplied := amount - Applied + ForeignVariationAmount;
        end else if Sysutils.SameText(Sender.FieldName , 'Applied')               then begin
            UnApplied := amount - Applied + ForeignVariationAmount;
        end else if Sysutils.SameText(Sender.FieldName , 'UnApplied')             then begin
            Applied := amount - UnApplied + ForeignVariationAmount;
        end else if Sysutils.SameText(Sender.FieldName , 'ForeigncurrencyAmount') then begin
            Amount              := ForeigntoLocal(ForeigncurrencyAmount , ForeignExchangeRate , CurrencyRoundPlaces);
            Foreignunapplied    := ForeigncurrencyAmount - Foreignapplied;
            UnApplied           := ForeigntoLocal(Foreignunapplied , ForeignExchangeRate , CurrencyRoundPlaces);
        end else if Sysutils.SameText(Sender.FieldName , 'Foreignapplied')        then begin
            Applied             := ForeigntoLocal(ForeignApplied        , ForeignExchangeRate , CurrencyRoundPlaces);
            Foreignunapplied    := ForeigncurrencyAmount - Foreignapplied;
            UnApplied           := ForeigntoLocal(Foreignunapplied , ForeignExchangeRate , CurrencyRoundPlaces);
        end else if Sysutils.SameText(Sender.FieldName , 'Foreignunapplied')      then begin
            unApplied           := ForeigntoLocal(ForeignunApplied      , ForeignExchangeRate , CurrencyRoundPlaces);
            Foreignapplied      := ForeigncurrencyAmount - Foreignunapplied ;
            Applied             := ForeigntoLocal(Foreignapplied , ForeignExchangeRate , CurrencyRoundPlaces);
        End;
        ForeigncurrencyAmount := LocalToforeign(Amount                , ForeignExchangeRate , CurrencyRoundPlaces);
        ForeignApplied        := LocalToforeign(Applied               , ForeignExchangeRate , CurrencyRoundPlaces);
        ForeignUnApplied      := LocalToforeign(UnApplied             , ForeignExchangeRate , CurrencyRoundPlaces);
    end;
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(sender.FieldName , 'CusID') then begin
        UserLock.UnLock('CustPaymentClientLock');
        if LastCustID <> Sender.AsInteger then begin
          if not UserLock.Lock('CustomerPaymentClient',Sender.asInteger,'CustPaymentClientLock') then begin
            Sender.AsInteger:= 0;
              SendEvent(BusObjEvent_Change, BusobjEventVal_ClientUserLockFail, self);
          end;
          LastCustID:= Sender.AsInteger;
        end;
        if appenv.companyPrefs.DefaultCustomerClassInPayments then
          ClassId := CustomerDefaultClassID(ClientID);
        RefreshguiLines;
        if Companyname <> client.clientName then companyname := client.clientName;
        if ClientPrintName <> client.Printname then ClientPrintName := client.Printname;
        if Client.PayMethodID <> 0 then PayMethodID := Client.PayMethodID;
        AmountDue := client.ARBalance;
        ForeignExchangeCode := client.ForeignExchangeCode;
        if ForeignExchangeCode = '' then ForeignExchangeCode := AppEnv.RegionalOptions.ForeignExDefault;
        DoFieldOnChange(Dataset.findField('ForeignExchangeCode'));
        SendEvent(BusObjEvent_Change, BusObjEventVal_ClientID, self);
        Editdb;
    end else if Sysutils.SameText(Sender.FieldName , 'ForeignExchangeRate') then begin
        if ISFCSelected then begin
          Amount:= ForeigntoLocal(ForeigncurrencyAmount , ForeignExchangeRate , CurrencyRoundPlaces);
          DoCalcOrderTotals;//CalcTotals;
        end;
    end else if Sysutils.SameText(Sender.fieldname , 'ForeignExchangeCode') then begin
        ShowProgressbar(GuiLines.count+1 ,'Checking for Foreign Exchange Code/Rate' );
        try
            ForeignExchangeRate := getExchageSellRate;
            Amount:= ForeigntoLocal(ForeigncurrencyAmount , ForeignExchangeRate , CurrencyRoundPlaces);
            GuiLines.IterateRecords(ValidateFCofapplied, False);
            if Assigned(ChangeDisplayLabel) then ChangeDisplayLabel;
            DoCalcOrderTotals;//CalcTotals;
        finally
          HideProgressbar;
        end;
    end else if Sysutils.SameText(Sender.FieldName ,'PaymethodID') then begin
        setTenderAccountID;
    end else if Sysutils.SameText(Sender.fieldName , 'CompanyName') then begin
        clientId := tcdatautils.getclientID(CompanyName, False, connection.connection);
        DoFieldOnChange(Dataset.Findfield('CusId'));
(*  Binny : Since clientPrintname is not unique, not possible to get clietnId for the printname
    end else if Sysutils.SameText(Sender.fieldName , 'ClientPrintName') then begin
        clientId := tcdatautils.clientIDForPrintname(ClientPrintName);
        DoFieldOnChange(Dataset.Findfield('CusId'));*)
    end else if Sysutils.SameText(Sender.FieldName , 'Amount') then begin
        if amount <> 0 then begin
            if (UseFC) and ISFCSelected then begin
                {XML import will calculate the rate without any confirmation - IANOS}
                if Math.IsZero(ForeignExchangeRate,0.000001) then begin
                  if  (ForeigncurrencyAmount <> 0) and
                      ((not (Assigned(ConfirmFromGUI))) or
                      (fconfirmFromGUI('Do you wish to Calculate the Exchange Rate Based on the Foreign Amount Divided by the Payment Amount?' ,[mbYes, mbNo] ) = mrYes)) then begin
                       if amount <> 0 then
                          ForeignExchangeRate := ForeigncurrencyAmount/amount;
                  end else begin
                        ForeignExchangeRate := getExchageSellRate;
                  end;
                end;
                ForeigncurrencyAmount := CommonLib.LocalToForeign(Amount,ForeignExchangeRate, CurrencyRoundPlaces);
            End;
        end;
        if (Dataset.state = dsInsert) and (Amount = 0) then

    end else if Sysutils.SameText(Sender.fieldName , 'ForeigncurrencyAmount') then begin
        if (Dataset.state = dsInsert) and (ForeigncurrencyAmount = 0) then
        else begin
            amount := ForeigntoLocal(ForeigncurrencyAmount , ForeignExchangeRate , CurrencyRoundPlaces);
        end;

    end else if Sysutils.SameText(Sender.fieldname , 'PaymentDate') then begin
        if (PaymentDate <= AppEnv.CompanyPrefs.ClosingDate) or (PaymentDate <= AppEnv.CompanyPrefs.ClosingDateAR) then begin
            str := 'You have set this date before the closing date !' +
                    'the date will automatically be set to today''s date OR '+
                    'reset the Closing Date In Preferences.';
            AddResult(True, rssinfo, 0 , str);
            PaymentDate := now;
        end;
        ForeignExchangeRate := getExchageSellRate;
        DoFieldOnChange(Dataset.findfield('ForeignExchangeRate'));
    end;
    if IsAmountField then UpdateAmounts;
end;

Function TCustPayments.getTotalDiscount               : Double;
begin
    Result := fdtotalDiscount;
end;

Function TCustPayments.getTotalwithHolding            : Double;
begin
    Result := fdTotalwithholding;
end;

Function  TCustPayments.getTotalLinesamount           : double;
begin
  result := fdTotalAmount;
end;

function TCustPayments.GetCleanDeposited: boolean;
begin
  result := GetXMLNodeBooleanValue(CleanXMLNode, 'Deposited');
end;

Function  TCustPayments.GetSplitPaymentID     : Integer   ; begin Result := GetIntegerField('SplitPaymentID')     ;end;
Function  TCustPayments.GetSplitPaymentLineID : Integer   ; begin Result := GetIntegerField('SplitPaymentLineID')     ;end;
Function  TCustPayments.GetClientID           : Integer   ; begin Result := GetIntegerField('CusId')              ;end;
Function  TCustPayments.GetPayment            : Boolean   ; begin Result := GetBooleanField('CustomerPayment')    ;end;
Function  TCustPayments.GetDeposit            : Boolean   ; begin Result := GetBooleanField('Deposit')            ;end;
Function  TCustPayments.GetDeposited          : Boolean   ; begin Result := GetBooleanField('Deposited')          ;end;
Function  TCustPayments.GetDepositedBalance   : Double    ; begin Result := GetFloatField('DepositedBalance')     ;end;
Function  TCustPayments.GetDepositID          : Integer   ; begin Result := GetIntegerField('DepositID')          ;end;
Procedure TCustPayments.SetSplitPaymentID     (Const Value: Integer   ); begin SetIntegerField('SplitPaymentID'   , Value);end;
Procedure TCustPayments.SetSplitPaymentLineID (Const Value: Integer   ); begin SetIntegerField('SplitPaymentLineID'   , Value);end;
Procedure TCustPayments.SetClientID           (Const Value: Integer   ); begin SetIntegerField('CusId'            , Value);end;

Procedure TCustPayments.SetPayment            (Const Value: Boolean   ); begin SetBooleanField('CustomerPayment'  , Value);end;
Procedure TCustPayments.SetDeposit            (Const Value: Boolean   ); begin SetBooleanField('Deposit'          , Value);end;
Procedure TCustPayments.SetDeposited          (Const Value: Boolean   ); begin SetBooleanField('Deposited'        , Value);end;
Procedure TCustPayments.SetDepositedBalance   (Const Value: Double    ); begin SetFloatField('DepositedBalance'   , Value);end;
Procedure TCustPayments.SetDepositID          (Const Value: Integer   ); begin SetIntegerField('DepositID'        , Value);end;

function TCustPayments.getReconcilations(const TransLockType: TTransLockType): Boolean;
Var
  LockManagement :TLockManagement;
  ResultLocked :Boolean;
  ResultTransLockType :TTransLockType;
begin
  LockManagement := TLockManagement.Create;
  try
    ResultLocked := LockManagement.IsCustomerPaymentLocked(ID,ResultTransLockType);
    Result := ResultLocked and (ResultTransLockType=TransLockType);
  finally
    LockManagement.Free;
  end;
end;

function TCustPayments.getUseFC: Boolean;
begin
  result:= inherited getUseFC;
  if not result then
    Result := (AppEnv.CompanyPrefs.UseForeignCurrencyOnSales);
end;

destructor TCustPayments.Destroy;
begin
  fUpdatedSalesList.Free;
  DestroyUserTemporaryTable(TERPConnection(Connection.Connection),  GuiCustPaymentLinesTablename);
  inherited;
end;

procedure TCustPayments.New;
begin
  inherited;
  fUpdatedSalesList.Clear;
end;

function TPayments.getEnteredAt: TDateTime;
begin
  REsult := GetDateTimeField('EnteredAt');
end;

procedure TPayments.setEnteredAt(const Value: TDateTime);
begin
   SetDateTimeField('EnteredAt' , Value);
end;

procedure TCustPayments.CallbackValidateLines(const Sender: TBusObj;
  var Abort: Boolean);
begin
  StepProgressbar;
  if not TCustPaymentLines(Sender).ValidateData then begin
    AllLinesValid:= false;
    Abort:= true;
  end;
end;

function TCustPayments.ValidateLines: boolean;
begin
  AllLinesValid:= true;
  ShowProgressbar(Lines.Count, 'Validate');
  try
    Lines.IterateRecords(self.CallbackValidateLines);
  finally
    HideProgressbar;
  end;
  result:= AllLinesValid;
end;

{TSuppPayments}
Procedure TSuppPayments.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
    fbDiscountApplied := False;
    if not(fbBulkPayment) then AddToEFT := False;
end;

Procedure TSuppPayments.ValidateFCofapplied(Const Sender: TBusObj; var Abort: Boolean);
begin
    StepProgressbar;
    if not(Sender is TGuiSuppPaymentlines) then Exit;
    if TGuiSuppPaymentlines(Sender).ForeignExchangeCode <> ForeignExchangeCode then
        if TGuiSuppPaymentlines(Sender).Applied then
            TGuiSuppPaymentlines(Sender).applied := False;
end;

Procedure TSuppPayments.DoFieldOnChange(Sender: TField);
var
  str: String;

    Function Isamountfield:Boolean;
    begin
         Result :=  (Sysutils.SameText(Sender.FieldName , 'Amount'               )) or
                    (Sysutils.SameText(Sender.FieldName , 'Applied'              )) or
                    (Sysutils.SameText(Sender.FieldName , 'UnApplied'            )) or
                    (Sysutils.SameText(Sender.FieldName , 'ForeigncurrencyAmount')) or
                    (Sysutils.SameText(Sender.FieldName , 'Foreignapplied'       )) or
                    (Sysutils.SameText(Sender.FieldName , 'Foreignunapplied'     ));
    END;

    Procedure UpdateAmounts;
    begin
        if Sysutils.SameText(Sender.FieldName , 'Amount')                then begin
            UnApplied := amount - Applied + ForeignVariationAmount;
            if (UseFC) and ISFCSelected then begin
              Foreignunapplied    := ForeigncurrencyAmount - Foreignapplied;
            end;
        end else if Sysutils.SameText(Sender.FieldName , 'Applied')               then begin
            UnApplied := amount - Applied + ForeignVariationAmount;
        end else if Sysutils.SameText(Sender.FieldName , 'UnApplied')             then begin
            Applied := amount - UnApplied + ForeignVariationAmount;
        end else if Sysutils.SameText(Sender.FieldName , 'ForeigncurrencyAmount') then begin
            Amount              := ForeigntoLocal(ForeigncurrencyAmount , ForeignExchangeRate , CurrencyRoundPlaces);
            Foreignunapplied    := ForeigncurrencyAmount - Foreignapplied;
            UnApplied           := ForeigntoLocal(Foreignunapplied , ForeignExchangeRate , CurrencyRoundPlaces);
        end else if Sysutils.SameText(Sender.FieldName , 'Foreignapplied')        then begin
            Applied             := ForeigntoLocal(ForeignApplied        , ForeignExchangeRate , CurrencyRoundPlaces);
            Foreignunapplied    := ForeigncurrencyAmount - Foreignapplied;
            UnApplied           := ForeigntoLocal(Foreignunapplied , ForeignExchangeRate , CurrencyRoundPlaces);
        end else if Sysutils.SameText(Sender.FieldName , 'Foreignunapplied')      then begin
            unApplied           := ForeigntoLocal(ForeignunApplied      , ForeignExchangeRate , CurrencyRoundPlaces);
            Foreignapplied      := ForeigncurrencyAmount - Foreignunapplied ;
            Applied             := ForeigntoLocal(Foreignapplied , ForeignExchangeRate , CurrencyRoundPlaces);
        End;
        if ISFCSelected = False then begin
            ForeigncurrencyAmount := LocalToforeign(Amount                , ForeignExchangeRate , CurrencyRoundPlaces);
            ForeignApplied        := LocalToforeign(Applied               , ForeignExchangeRate , CurrencyRoundPlaces);
            ForeignUnApplied      := LocalToforeign(UnApplied             , ForeignExchangeRate , CurrencyRoundPlaces);
        End;
    end;
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
{--}if Sysutils.SameText(sender.FieldName , 'SupplierID') or
       Sysutils.SameText(sender.FieldName , 'CompanyName') (*or
       Binny : Since clientPrintname is not unique, not possible to get clietnId for the printname
      Sysutils.SameText(sender.FieldName , 'ClientPrintName')*) then begin
        if Sysutils.SameText(sender.FieldName , 'CompanyName') then begin
          ClientID:= TClient.IDToggle(Sender.AsString,Connection.Connection);
(*        end else if Sysutils.SameText(sender.FieldName , 'ClientPrintName') then begin
          clientId := tcdatautils.clientIDForPrintname(ClientPrintName);*)
        end;
        UserLock.UnLock('SuppPaymentClientLock');
        if LastSupplierID <> ClientID then begin
          if not UserLock.Lock('SupplierPaymentClient',ClientID,'SuppPaymentClientLock') then begin
            Sender.Clear; // AsInteger:= 0;
            SendEvent(BusObjEvent_Change, BusobjEventVal_ClientUserLockFail, self);
          end;
          LastSupplierID:= ClientID;
        end;
        RefreshguiLines;
        if Client.PayMethodID <> 0 then PayMethodID := Client.PayMethodID;
        if Client.PaymentMethodName = 'E.F.T.' then begin
            AddToEFT:= True;
            SendEvent(BusObjEvent_Change,BusobjEventVal_AddToEFT);
          end;
        AmountDue               := - client.APBalance;
        ForeignExchangeCode     := client.ForeignExchangeCode;
        if ForeignExchangeCode   = '' then ForeignExchangeCode := AppEnv.RegionalOptions.ForeignExDefault;
        DoFieldOnChange(Dataset.findField('ForeignExchangeCode'));
        ContractorPayment := Client.Contractor;
        if Sysutils.SameText(tcDatautils.GetPaymentMethod(PaymethodID) , 'Cheque') then
            if ReferenceNo = '' then
                if GLAccount.UseLastChequeNo then
                    //ReferenceNo:= IntToStr(GLAccount.LastChequeNo+1);
                    ReferenceNo := IntToStr(GLAccount.Previouschequeno+1);
        SendEvent(BusObjEvent_Change, BusObjEventVal_ClientID, self);
{--}end else if Sysutils.SameText(Sender.fieldName, 'PaymethodID') then begin
        if setTenderAccountID then begin
          { done }
        end
        else begin
          if PaymentMethod.IsCreditCard then
            accountId :=AppEnv.CompanyPrefs.DefaultCCardPaymentAccount
          else
            accountId :=AppEnv.CompanyPrefs.DefaultSuppPaymentAccount;
        end;
        if Sysutils.SameText(tcDatautils.GetPaymentMethod(PaymethodID) , 'Cheque') then
          if (AppEnv.CompanyPrefs.UseAutoChequeNo) and (ReferenceNo ='') then
            ReferenceNo := IntToStr(GLAccount.Previouschequeno+1);
{--}end else if Sysutils.SameText(Sender.fieldname , 'ForeignExchangeCode') then begin
        ForeignExchangeRate := getExchageBuyRate;
        Amount:= ForeigntoLocal(ForeigncurrencyAmount , ForeignExchangeRate , CurrencyRoundPlaces);
        ShowProgressbar(GUILines.Count, 'Update Transactions');
        try
          GuiLines.IterateRecords(ValidateFCofapplied);
        finally
          HideProgressbar;
        end;
        if Assigned(ChangeDisplayLabel) then ChangeDisplayLabel;
        DoCalcOrderTotals;//CalcTotals;
{--}end else if Sysutils.SameText(Sender.fieldname , 'AccountID') then begin
        if Sysutils.SameText(tcDatautils.GetPaymentMethod(PaymethodID) , 'Cheque') then
            if ReferenceNo = '' then
                if GLAccount.UseLastChequeNo then
                    ReferenceNo:= IntToStr(GLAccount.Previouschequeno+1);
{--}end else if Sysutils.SameText(Sender.FieldName , 'PaymentDate') then begin
        if (PaymentDate <= AppEnv.CompanyPrefs.ClosingDate) or (PaymentDate <= AppEnv.CompanyPrefs.ClosingDateAP) then begin
            str := 'You have set this date before the closing date.  ' +
                    'The date will automatically be set to today''s date OR '+
                    'reset the Closing Date In Preferences.';
            AddResult(True, rssinfo, 0 , str);
            PaymentDate := now ;
        end;
        ForeignExchangeRate := getExchageBuyRate;
        DoFieldOnChange(Dataset.findfield('ForeignExchangeRate'));
{--}end else if Sysutils.SameText(Sender.FieldName , 'ForeignExchangeRate') then begin
        if ISFCSelected then begin
          Amount:= ForeigntoLocal(ForeigncurrencyAmount , ForeignExchangeRate , CurrencyRoundPlaces);
          DoCalcOrderTotals;//CalcTotals;
        end;
{--}end else if Sysutils.SameText(Sender.fieldName , 'Amount') then begin
        if amount <> 0 then begin
            if (UseFC) and ISFCSelected then begin
                {XML import will calculate the rate without any confirmation - IANOS}
                if Math.IsZero(ForeignExchangeRate,0.000001) then begin
                  if  (ForeigncurrencyAmount <> 0) and
                      ((not (Assigned(ConfirmFromGUI))) or
                      (fconfirmFromGUI('Do you wish to Calculate the Exchange Rate Based on the Foreign Amount Divided by the Payment Amount?' ,[mbYes, mbNo] ) = mrYes)) then begin
                       if amount <> 0 then
                          ForeignExchangeRate := ForeigncurrencyAmount/amount;
                  end else begin
                        ForeignExchangeRate := getExchageBuyRate;
                  end;
                end else if (Amount<>0) and (ForeigncurrencyAmount<> 0)  and (Assigned(ConfirmFromGUI)) and (fconfirmFromGUI('Do you wish to Re-calculate the Exchange Rate Based on the Foreign Amount Divided by the Payment Amount?' ,[mbYes, mbNo] ) = mrYes) then begin
                  {need an option to recalculate the exchange rate in any case : DENE}
                  ForeignExchangeRate := ForeigncurrencyAmount/amount;
                end;
                ForeigncurrencyAmount := CommonLib.LocalToForeign(Amount,ForeignExchangeRate, CurrencyRoundPlaces);
                DoCalcOrderTotals;//CalcTotals();
            End;
        end;
        if (Dataset.state = dsInsert) and (Amount = 0) then
        else begin
            if IsFCSelected then ForeigncurrencyAmount := LocalToForeign(amount , ForeignExchangeRate , CurrencyRoundPlaces);
        end;
{--}end else if Sysutils.SameText(Sender.fieldName , 'ForeigncurrencyAmount') then begin
        if (Dataset.state = dsInsert) and (ForeigncurrencyAmount = 0) then
        else begin
            amount := ForeigntoLocal(ForeigncurrencyAmount , ForeignExchangeRate , CurrencyRoundPlaces);
        end;
{--}end else if Sysutils.SameText(sender.FieldName, 'ReferenceNo') then begin
      SendEvent(BusObjEvent_Change,BusObjEvent_PaymentRefno, self);
{--}end;
    if IsAmountField then UpdateAmounts;
end;

Procedure TSuppPayments.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'InvoiceRefNo');
  SetPropertyFromNode(node,'Cheque');
  SetPropertyFromNode(node,'ChequePrinted');
end;
Procedure TSuppPayments.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'InvoiceRefNo'    ,InvoiceRefNo);
  AddXMLNode(node,'Cheque'          ,Cheque);
  AddXMLNode(node,'ChequePrinted'   ,ChequePrinted);
End;

Constructor TSuppPayments.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fbDiscountApplied         := False;
  fBusObjectTypeDescription := 'SuppPayments';
  fSQL := 'SELECT * FROM tblwithdrawal';
  AddToEFT := False;
  fUpdatedPOList := TIntegerList.Create;
end;

function TSuppPayments.ValidateData           : Boolean ;
var
    str:STring;
begin
    ResultStatus.Clear;
    if self.Deleted then begin
      result:= true;
      exit;
    end;
    result := inherited ValidateData ;
    if not result then exit;
    if not Valid4EFT(true) then begin
      result:= false;
      SendEvent(BusObjEvent_Change,BusobjEventVal_AddToEFT);
      exit;
    end;
    if (PaymentDate <= AppEnv.CompanyPrefs.ClosingDate) or (PaymentDate <= AppEnv.CompanyPrefs.ClosingDateAP) then begin
        str := 'You have set this date before the closing date.  ' +
            'The date will automatically be set to today''s date OR '+
            'reset the Closing Date In Preferences.';
        AddResult(True, rssinfo, 0 , str);
        PaymentDate := now ;
        ForeignExchangeRate := getExchageSellRate;
        DoFieldOnChange(Dataset.findfield('ForeignExchangeRate'));
    end;
    if clientId = 0 then begin
        AddResult(True, rssinfo, 0 , 'supplier should not be blank');
        Result := False;
        Exit;
    end;
    if PayMethodID = 0 then begin
        AddResult(True, rssinfo, 0 , 'Payment methid should not be blank');
        Result := False;
        Exit;
    end;
    if PaymentDate = 0 then begin
        AddResult(True, rssinfo, 0 , 'Payment date should not be blank');
        Result := False;
        Exit;
    end;
    if AccountId = 0 then begin
        AddResult(True, rssinfo, 0 , 'Account should not be bkank');
        Result := False;
        Exit;
    end;
    if not IsZero(ForeignVariationAmount,0.00001) then
        if ForeignVariationAccountID= 0 then begin
            AddResult(False, rssWarning, 0, 'Variation account should not be blank.');
            Result := False;
            Exit;
        end;
    if not IsZero(Unapplied, 0.00001) then begin
        AddResult(False, rssWarning, 0, 'Payment cannot be saved with an unapplied amount');
        Result := False;
        Exit;
    end;
    if not self.ValidateLines then begin
      result:= false;
      exit;
    end;
end;

Procedure TSuppPayments.UpdateFCHistory;
var
    BuyRate, SellRate:Double;
begin
    if not Assigned(confirmFromGUI) then Exit;
    if not IsFCSelected then Exit;
    if AppEnv.CompanyPrefs.UseForeignCurrencyonPO then begin
        With TForeignExchangeObj.Create do Try
            GetForeignExchangeRatesForDate(ForeignExchangeCode, PaymentDate, BuyRate, SellRate);
            if ForeignExchangeRate <> BuyRate then
                if fconfirmFromGUI('Do you want to update the rate in "Foreign Exchange Rate" list for ' + ForeignExchangeCode + '?',[mbYes, mbNo]) = mrYes then
                    AddForeignExchangeRateHistory(tcdatautils.getCurrencyID(ForeignExchangeCode),ForeignExchangeRate, SellRate, PaymentDate);
        finally
          Free;
        end;
    end;
end;
function TSuppPayments.Payapproved: Boolean;
var
    strSQL:STring;
    strMSg :String;
begin
    result := false;

    strSQL := 'SELECT ' +
                ' C.ClientID,PC.TransType AS type, ' +
                ' P.PrePaymentID AS transID,P.ClassID, PC.Amount ' +
                ' FROM tblpaymentconformations  as PC ' +
                ' Inner Join tblclients         as C ON PC.ClientName = C.Company ' +
                ' Inner Join tblprepayments     as P ON PC.TransGlobalRef = P.GlobalRef ' +
                ' Where P.Balance <> 0 and PC.Active = "T" ' +
                ' union  ' +
                ' SELECT C.ClientID, PC.TransType AS type, P.PurchaseOrderID AS TransID,  ' +
                IntToStr(AppEnv.DefaultClass.ClassID) + ', PC.Amount ' +
                ' FROM tblpaymentconformations  as PC ' +
                ' Inner Join tblclients         as C ON PC.ClientName = C.Company ' +
                ' Inner Join tblpurchaseorders  as P ON PC.TransGlobalRef = P.GlobalRef ' +
                ' where P.Balance <> 0 and PC.Active = "T" ' +
                'order by ClassId , clientID';
    with getNewDataset(StrSQL) do try
        if recordcount = 0 then begin
            AddResult(True, rssInfo , BORSCode_No_Data , 'No Pending transactions to pay');
            exit;
        end;
        if not (Assigned(ConfirmFromGui)) then Exit;
        strMsg := 'This Function will Create Supplier Payments.  ' +
            'Cancelling these Payments will also Remove them from the Approved List.  ' +
            'Proceed with Payment of Approved Payments ?';
        if fconfirmFromGUI(strMsg ,[mbYes, mbNo]) = mrYes then
            result := DoBulkPay(strSQL , '' , appenv.DefaultClass.DefaultClassName, date,0);
        if result then begin
            strSQL :='UPDATE tblpaymentconformations SET Active= "F" WHERE `Status` = "A";';
            getnewDataset(strSQL);
        end;
    finally
        if active then Close;
        Free;
    end;

end;
Function TSuppPayments.Lock: Boolean;
begin
    Result := inherited Lock;
    if not REsult then exit;
    if ABAObj.count = 1 then begin
        if not ABAObj.UserLock.Lock(ABAObj.BusObjectTableName, ABAObj.Id, Lockgroupname) then begin
            AddResult(false, rssWarning, 0,
                    StringReplace(ABAObj.UserLock.LockMessage , 'Unable to update data.' ,'Unable to update the E.F.T. details.' , [rfReplaceAll, rfIgnoreCase]));
            result := False;
        end;
    end;

    if Result then begin
        UserLock.OnUnlockItem:= DoOnUserLockOnUnlockItem;
        ShowProgressbar(UserLock.LockList.Count, 'Unlocking the Transactions');
        try
          UserLock.Unlock(self.LockGroupName );
        finally
          UserLock.OnUnlockItem:= nil;
          HideProgressbar;
        end;

        AlllinesValid := true;
        ShowProgressbar(GUILInes.count , 'Locking the Transactions');
        try
          GUILines.Iteraterecords(CallbackLock);
        finally
          HideProgressbar;
        end;

        Result := AlllinesValid ;
    end;
end;

function TSuppPayments.MakeCredit(const fOrderObj: TOrderBase; const Price,
  Qty: Double; IsEarlyPaymentDiscount: boolean; var msg: string): Boolean;
var
  CreditObj: TCredit;
begin
    Result := False;
    if fOrderObj.Dataset.recordcount = 0 then Exit;
    CreditObj := TCredit.CreateWithNewConn(nil);
    try
      CreditObj.Connection.BeginTransaction;

      CreditObj.SilentMode := True;
      { only want one Credit for any refund ammounts .. so check if one evists .. }
      CreditObj.LoadSelect('InvoiceNumber = ' + QuotedStr('Supp Pmt ' + IntToStr(ID)) + ' and ForeignExchangeCode = ' + QuotedStr(fOrderObj.ForeignExchangeCode));
      if CreditObj.Count = 0 then begin
        CreditObj.New;
        CreditObj.SupplierName :=fOrderObj.SupplierName;
        CreditObj.OrderDate := Date;
        CreditObj.SupplierInvoiceNumber := 'Supp Pmt ' + IntToStr(ID);
        CreditObj.ShipTo := fOrderObj.ShipTo;
        CreditObj.OrderTo := fOrderObj.OrderTo;
        CreditObj.ForeignExchangeCode:= fOrderObj.ForeignExchangeCode;
        CreditObj.ForeignExchangeRate:= fOrderObj.ForeignExchangeRate;
        CreditObj.Comments := 'Credit created from Supplier Payment #' + inttostr(ID); // + ' for invoice # ' + inttostr(fInvoiceObj.ID);
        CreditObj.PostDB;
      end;

      CreditObj.Lines.New;
      if IsEarlyPaymentDiscount then
        CreditObj.Lines.AccountName := TProduct.ProductCOGSAccount(EARLY_PAYMENT_DISCOUNT_PRODUCT)
      else
        CreditObj.Lines.AccountName := TProduct.ProductCOGSAccount(PART_DOL_DISC);
      CreditObj.Lines.LineCostInc := Price;
      CreditObj.Lines.ProductDescription := 'Credit for Order: ' + IntToStr(fOrderObj.ID);
      CreditObj.Lines.PostDB;
      if CreditObj.Save then begin
        result := true;
        CreditObj.Connection.CommitTransaction;
        UpdatedPOList.AddIfNotInList(fOrderObj.ID);
        UpdatedPOList.AddIfNotInList(CreditObj.ID);
      end
      else begin
        msg := CreditObj.ResultStatus.Messages;
        CreditObj.Connection.RollbackTransaction;
      end;
    finally
      Freeandnil(CreditObj);
    end;
end;

procedure TSuppPayments.New;
begin
  inherited;
  fUpdatedPOList.Clear;
end;

Procedure TSuppPayments.UpdateLastChequeNo;
begin
  {this is outside transaction and is ignored if cannot be locked}
    if Sysutils.SameText(tcDatautils.GetPaymentMethod(PaymethodID) , 'Cheque') then
        if (GLAccount.UseLastChequeNo) and (AppEnv.CompanyPrefs.UseAutoChequeNo) then
            if (ReferenceNo <> '') and (isnumeric(ReferenceNo)) then begin
                if userLock.Lock(GLAccount.BusObjectTableName , GLAccount.ID , Lockgroupname) then begin
                    GLAccount.NewChequeNo := StrToInt(ReferenceNo);
                    GLAccount.PostDb;
                End else begin
                    AddResult(True,rssInfo,0,
                        StringReplace(ABAObj.UserLock.LockMessage , 'Unable to update data.' ,'Unable to update the Last cheque no of ' +GLAccount.Accountname +'.'  , [rfReplaceAll, rfIgnoreCase]));
                end;
            end;
end;

Function TSuppPayments.Save: Boolean;
begin
  if SilentMode then
    if (CleanID = 0) or (Deleted) then
      CalcTotals(True);

  ValidationStage := 1;
  PostDB;
  Result := ValidateData;
  if not Result then Exit;

  Result := Inherited Save;
  if not Result then Exit;

  Self.Connection.BeginNestedTransaction;
  try
    PostList.Clear;
    IsNew := Lines.Count = 0;
    PostDB;
    if IsNew then Createlines;
    UpdateLines;
    UdpateBalance;
    UpdateBankdeposit;
    CorrectOtherPayments;
    CreateABARecord;
    UpdatelastChequeNo;
    if not PostList.Execute then begin
      Result := False;
      Exit;
    end;
    Dirty := False;
  finally
    if not result then begin
      Self.Connection.RollbackNestedTransaction;
      Lines.Closedb;
      Lines;
    end;
  end;
  Self.Connection.CommitNestedTransaction;
  ValidationStage := 2;
  if not Self.ValidateLines then begin
    result := False;
    Exit;
  end;
end;

Procedure TSuppPayments.udpateBalance;
var
  PrepaymentAmount : Double;
  APPaymentAmount  : Double;

  Function GetPrepaymentAccountID : Integer;
  begin
    Result := tcDatautils.GetAccountID(GLACCOUNT_SUPPPREPAYMENT);
  end;
begin
    if (not ISNew) and (cleanDeleted = Deleted) then Exit;

    PrepaymentAmount := GetPrepaymentAmount;
    APPaymentAmount  := Amount + PrepaymentAmount;
    if (AppEnv.CompanyPrefs.UseForeignCurrencyonPO) and (ISFCSelected) then
        APPaymentAmount := APPaymentAmount - ForeignVariationAmount;

    if not Deleted then begin
        PostList.AddAmount('TAccount', TAccount.GetBusObjectTablename, tcDatautils.GetAccountPayableID, -APPaymentAmount,btnormal, False);
        PostList.AddAmount('TAccount', TAccount.GetBusObjectTablename, AccountID,                       -Amount,btnormal, False);
        PostList.AddAmount('TAccount', TAccount.GetBusObjectTablename, GetPrepaymentAccountID,          -PrepaymentAmount,btnormal, False);
        if (AppEnv.CompanyPrefs.UseForeignCurrencyonPO) and (ISFCSelected) then
            PostList.AddAmount('TAccount', TAccount.GetBusObjectTablename, ForeignVariationAccountID,       ForeignVariationAmount,btnormal, False);
    end;

    if (not ISNew) and (Deleted) then begin
        PostList.AddAmount('TAccount', TAccount.GetBusObjectTablename, tcDatautils.GetAccountPayableID, APPaymentAmount,btnormal, False);
        PostList.AddAmount('TAccount', TAccount.GetBusObjectTablename, AccountID,                       Amount,btnormal, False);
        PostList.AddAmount('TAccount', TAccount.GetBusObjectTablename, GetPrepaymentAccountID,          PrepaymentAmount,btnormal, False);
       if (AppEnv.CompanyPrefs.UseForeignCurrencyonPO) and (ISFCSelected) then
        PostList.AddAmount('TAccount', TAccount.GetBusObjectTablename, ForeignVariationAccountID,       -ForeignVariationAmount,btnormal, False);
    end;

    ShowProgressbar(GUILines.Count, 'Update Transactions');
    try
      GuiLines.IterateREcords(UpdateclientBalance);
    finally
      HideProgressbar;
    end;
end;

Procedure TSuppPayments.UpdateclientBalance(Const Sender: TBusObj; var Abort: Boolean);
begin
  StepProgressbar;
  if not (Sender is TGuiSuppPaymentLines) then Exit;
  if not TGuiSuppPaymentLines(Sender).Applied then Exit;

  if Deleted then
    PostList.AddAmount(client.ClassName, client.GetBusObjectTablename,ClientID, TGuiSuppPaymentLines(Sender).Payment,btAP)
  else
    PostList.AddAmount(client.ClassName, client.GetBusObjectTablename,ClientID, -TGuiSuppPaymentLines(Sender).Payment,btAP);
end;

Procedure TSuppPayments.correctOtherPayments;
var
    strSQL:String;
begin
    if (isnew) or (deleted = CleanDeleted) then Exit;

    strSQL := 'SELECT  ' +
            ' Originalwithdrawal.Payment, ' +
            ' Originalwithdrawal.ForeignPayment,' +
            ' Otherwithdrawal.PaymentLineID , ' +
            ' OtherwithdrawalHeader.PaymentId' +
            ' from tblwithdrawallines as Originalwithdrawal, ' +
            ' tblwithdrawallines as Otherwithdrawal , ' +
            ' tblwithdrawal as OtherwithdrawalHeader ' +
            ' where Otherwithdrawal.PaymentId         > Originalwithdrawal.PaymentID' +
            ' AND   Otherwithdrawal.POID            = Originalwithdrawal.POID   ' +
            ' AND   OtherwithdrawalHeader.PaymentId = Otherwithdrawal.PaymentID   ' +
            ' AND   Originalwithdrawal.PaymentId      = ' + IntToStr(ID)  +
            ' AND   OtherwithdrawalHeader.Deleted     = "F"' ;
    With GetNewDataset(strSQL,true) do try
        if recordCount > 0 then begin
            First;
            While Eof = False do begin
                if deleted then
                    StrSQL := ' update tblwithdrawallines Set ' +
                        ' AmountOutstanding         = AmountOutstanding         + ' + FloatToStr(FieldByname('Payment').asFloat)        +',' +
                        ' AmountDue                 = AmountDue                 + ' + FloatToStr(FieldByname('Payment').asFloat)        +',' +
                        ' ForeignAmountOutstanding  = ForeignAmountOutstanding  + ' + FloatToStr(FieldByname('ForeignPayment').asFloat) +',' +
                        ' ForeignAmountDue          = ForeignAmountDue          + ' + FloatToStr(FieldByname('ForeignPayment').asFloat) +
                        ' where PaymentLineId       = ' + IntToStr(fieldByname('PaymentLineId').asInteger)
                else
                    StrSQL := ' update tblwithdrawallines Set ' +
                        ' AmountOutstanding         = AmountOutstanding         - ' + FloatToStr(FieldByname('Payment').asFloat)        +',' +
                        ' AmountDue                 = AmountDue                 - ' + FloatToStr(FieldByname('Payment').asFloat)        +',' +
                        ' ForeignAmountOutstanding  = ForeignAmountOutstanding  - ' + FloatToStr(FieldByname('ForeignPayment').asFloat) +',' +
                        ' ForeignAmountDue          = ForeignAmountDue          - ' + FloatToStr(FieldByname('ForeignPayment').asFloat) +
                        ' where PaymentLineId       = ' + IntToStr(fieldByname('PaymentLineId').asInteger);
                PostList.AddQuery(strSQL , FieldByname('PaymentId').asInteger ,'tblwithdrawal' );
                Next;
            end;
        end;
    finally
        if Active then close;
        Free;
    end;
end;
Procedure TSuppPayments.updateBankdeposit(forceDeletion: Boolean = False);
var
  cmd: TERPCommand;
begin
  if not IsNew then begin
    cmd := DbSharedObj.GetCommand(self.Connection.Connection);
    try
      cmd.SQL.Add('UPDATE tblbankdepositlines');
      cmd.SQL.Add('SET ReferenceNo = ' + QuotedStr(self.ReferenceNo));
      cmd.SQL.Add('WHERE TrnsType = "Supplier Payment"');
      cmd.SQL.Add('AND PaymentID = ' + IntToStr(self.ID));
      cmd.Execute;
    finally
      DbSharedObj.ReleaseObj(cmd);
    end;
  end;
  if (not isnew) and (cleanDeleted = Deleted ) then if forceDeletion =False then Exit;

  if Deleted then begin
    PostList.AddQuery('DELETE tblbankdeposit.* ' +
         ' FROM tblbankdeposit ' +
         ' INNER JOIN tblbankdepositlines  ' +
         ' ON tblbankdepositlines.DepositID = tblbankdeposit.DepositID ' +
         ' WHERE tblbankdepositlines.PaymentID =' + IntToStr(ID) +
         ' AND tblbankdepositlines.TrnsType =' + quotedStr(TransType));

    PostList.AddQuery('DELETE tblbankdepositlines.*   ' +
         ' FROM tblbankdepositlines ' +
         ' WHERE tblbankdepositlines.PaymentID =' + IntToStr(ID) +
         ' AND tblbankdepositlines.TrnsType =' + quotedStr(TransType));
  end else if (Sysutils.SameText(tcDatautils.GetAccountName(AccountID),UNDEPOSITED_FUNDS)) then
  else begin
    CreateDeposits;
  end;
  PostDB;
end;

Procedure TSuppPayments.CreateABARecord;
begin
    if (Deleted) then begin
        if ABAObj.count > 0 then ABAObj.DeleteAll;
        Exit;
    end;
    if (not(AddtoEFT)) then Exit;

    if ABAObj.count = 0 then ABAObj.New;
    ABAObj.RecordType               := '1';
    ABAObj.BSB                      := Client.BankAccountBSB;
    ABAObj.CreditDebitAccountNumber := Client.BankAccountNo;
    ABAObj.Indicator                := ' ';
    ABAObj.TransactionCode          := '50';
    ABAObj.TransCodeDesc            := 'Credit Items';
    ABAObj.Amount                   := Amount;
    ABAObj.AccountName              := Client.BankAccountName;
    ABAObj.TransType                := 'Supp Pay';
    if TSupplier(self.client).BankLodgementRef <> '' then
      ABAObj.LodgementReferences := TSupplier(self.client).BankLodgementRef
    else
      ABAObj.LodgementReferences      := ABAObj.TransType + ' ' + IntToStr(ID)+ ' ' + appenv.CompanyInfo.Companyname;
    ABAObj.Apply                    := False;
    ABAObj.AccountID                := AccountId;
    ABAObj.TransID                  := ID;
    ABAObj.NameofRemitter           := Self.CompanyName;
    ABAObj.PostDB;
end;

Procedure TSuppPayments.CreateDeposits;
begin
  {header}
  if Deleted then Exit;

  BankDeposit.New;
  BankDeposit.Depositdate          := PaymentDate;
  BankDeposit.PostDB;
  BankDeposit.EmployeeId           := EmployeeID;
  BankDeposit.classId              := ClassID;
  BankDeposit.AccountId            := AccountId;
  BankDeposit.Notes                := Notes;
  BankDeposit.Deposit              := -amount;
  BankDeposit.Deleted              := False;
  BankDeposit.PostDB;
  {details}
  BankDeposit.Lines.New;
  BankDeposit.Lines.PaymentID      := Self.ID;
  BankDeposit.Lines.TrnsType       := Transtype;
  BankDeposit.Lines.CusID          := ClientID;
  BankDeposit.Lines.PayMethodID    := PayMethodID;
  BankDeposit.Lines.PaymentMethod  := tcDatautils.GetPaymentMethod(PayMethodID);
  BankDeposit.Lines.PaymentDate    := PaymentDate;
  BankDeposit.Lines.Companyname    := companyName;
  BankDeposit.Lines.Referenceno    := ReferenceNo;
  BankDeposit.Lines.ClassId        := ClassId;
  BankDeposit.Lines.AccountID      := AccountId;
  BankDeposit.Lines.Amount         := -amount;
  BankDeposit.Lines.Name           := '';
  BankDeposit.Lines.Notes          := Notes;
  BankDeposit.Lines.Customer       := False;
  BankDeposit.Lines.Supplier       := True;
  BankDeposit.Lines.Employee       := False;
  BankDeposit.Lines.contact        := false;
  BankDeposit.Lines.Deposited      := True;
  BankDeposit.Lines.Statementno    := 0;
  BankDeposit.Lines.FromDeposited  := False;
  BankDeposit.Lines.PostDB;
end;

Procedure TSuppPayments.UpdateLines;
begin
  if (not(Isnew)) and (Deleted = Cleandeleted) then Exit;
  ShowProgressbar(GUILines.Count, 'Update Transactions');
  try
    GuiLines.IterateRecords(CallbackUpdateLines);
  finally
    Hideprogressbar;
  end;
end;

Procedure TSuppPayments.CallbackUpdateLines(Const Sender: TBusObj; var Abort: Boolean);
var
  strSQL:String;
begin
  StepProgressbar;
  {here I assume that the payment amount cannot be changed once if the record is saved
  only can delete or undelete

  note: Otherwise should take the cleanPayment-payment}

  if (TGuiSuppPaymentLines(Sender).payment = 0) and
      (TGuiSuppPaymentLines(Sender).ForeignPayment =0) then Exit;

  if TGuiSuppPaymentLines(Sender).TransType = PrePaytype then begin
    if not (Deleted) then begin
      strSQL := 'UPDATE tblPrePayments SET ' +
                    ' Payment               = ROUND(Payment           - ' + FloatToStr( TGuiSuppPaymentLines(Sender).Payment) +','+inttostr(CurrencyRoundPlaces)+'),' +
                    ' Balance               = ROUND(Balance           + ' + FloatToStr( TGuiSuppPaymentLines(Sender).Payment) +','+inttostr(CurrencyRoundPlaces)+'),' +
                    ' ForeignPaid           = ROUND(ForeignPaid  - ' + FloatToStr( TGuiSuppPaymentLines(Sender).ForeignPayment) +','+inttostr(CurrencyRoundPlaces)+'),' +
                    ' ForeignBalance        = ROUND(ForeignBalance    + ' + FloatToStr( TGuiSuppPaymentLines(Sender).ForeignPayment) +','+inttostr(CurrencyRoundPlaces)+')' +
                    ' WHERE PrePaymentID    = ' + IntToStr(TGuiSuppPaymentLines(Sender).TransID)  ;
    end else begin
      strSQL := 'UPDATE tblPrePayments SET ' +
                    ' Payment               = ROUND(Payment           + ' + FloatToStr( TGuiSuppPaymentLines(Sender).Payment) +','+inttostr(CurrencyRoundPlaces)+'),' +
                    ' Balance               = ROUND(Balance           - ' + FloatToStr( TGuiSuppPaymentLines(Sender).Payment) +','+inttostr(CurrencyRoundPlaces)+'),' +
                    ' ForeignPaid           = ROUND(ForeignPaid  + ' + FloatToStr( TGuiSuppPaymentLines(Sender).ForeignPayment) +','+inttostr(CurrencyRoundPlaces)+'),' +
                    ' ForeignBalance        = ROUND(ForeignBalance    - ' + FloatToStr( TGuiSuppPaymentLines(Sender).ForeignPayment) + ','+inttostr(CurrencyRoundPlaces)+')'+
                    ' WHERE PrePaymentID    = ' + IntToStr(TGuiSuppPaymentLines(Sender).TransID)  ;
    end;

    PostList.AddQuery(strSQL, TGuiSuppPaymentLines(Sender).TransID , 'tblPrePayments', False);
    strSQL :='UPDATE tblPrePayments SET Paid = "T" WHERE PrePaymentID = ' + IntToStr(TGuiSuppPaymentLines(Sender).TransID)  +
                    ' and Balance = 0;' +
             'UPDATE tblPrePayments SET Paid = "F" WHERE PrePaymentID = ' + IntToStr(TGuiSuppPaymentLines(Sender).TransID)  +
                    ' and Balance <> 0;';
    PostList.AddQuery(strSQL, TGuiSuppPaymentLines(Sender).TransID , 'tblPrePayments', False);
  end else begin
    if not (Deleted) then begin
      strSQL := ' UPDATE tblPurchaseOrders SET ' +
                    ' Payment                 = ROUND(Payment                + ' + FloatToStr( TGuiSuppPaymentLines(Sender).Payment) + ', ' + IntToStr(CurrencyRoundPlaces)+ '), ' +
                    ' Balance                 = ROUND(Balance                - ' + FloatToStr( TGuiSuppPaymentLines(Sender).Payment) + ', ' + IntToStr(CurrencyRoundPlaces) + '), ' +
                    ' ForeignPaidAmount       = ROUND(ForeignPaidAmount      + ' + FloatToStr( TGuiSuppPaymentLines(Sender).ForeignPayment) + ', ' + IntToStr(CurrencyRoundPlaces) + '), ' +
                    ' foreignBalanceAmount    = ROUND(foreignBalanceAmount   - ' + FloatToStr( TGuiSuppPaymentLines(Sender).ForeignPayment) + ', ' + IntToStr(CurrencyRoundPlaces) + ') ' +
                    ' WHERE IsCredit         = "F" and PurchaseOrderID= ' + IntToStr(TGuiSuppPaymentLines(Sender).TransID) +';' +
                  ' UPDATE tblPurchaseOrders SET ' +
                    ' Payment                 = ROUND(Payment                - ' + FloatToStr( TGuiSuppPaymentLines(Sender).Payment) + ', ' + IntToStr(CurrencyRoundPlaces) + '), ' +
                    ' Balance                 = ROUND(Balance                + ' + FloatToStr( TGuiSuppPaymentLines(Sender).Payment) + ', ' + IntToStr(CurrencyRoundPlaces) + '), ' +
                    ' ForeignPaidAmount       = ROUND(ForeignPaidAmount      - ' + FloatToStr( TGuiSuppPaymentLines(Sender).ForeignPayment) + ', ' + IntToStr(CurrencyRoundPlaces) + '), ' +
                    ' foreignBalanceAmount    = ROUND(foreignBalanceAmount   + ' + FloatToStr( TGuiSuppPaymentLines(Sender).ForeignPayment) + ', ' + IntToStr(CurrencyRoundPlaces) + ')' +
                    ' WHERE IsCredit          = "T" and PurchaseOrderID= ' + IntToStr(TGuiSuppPaymentLines(Sender).TransID) +';' ;
    end else begin
      strSQL := ' UPDATE tblPurchaseOrders SET ' +
                    ' Payment                = ROUND(Payment                + ' + FloatToStr( TGuiSuppPaymentLines(Sender).Payment) + ', ' + IntToStr(CurrencyRoundPlaces)+'), ' +
                    ' Balance                = ROUND(Balance                - ' + FloatToStr( TGuiSuppPaymentLines(Sender).Payment) + ', ' + IntToStr(CurrencyRoundPlaces)+'), ' +
                    ' ForeignPaidAmount      = ROUND(ForeignPaidAmount      + ' + FloatToStr( TGuiSuppPaymentLines(Sender).ForeignPayment) + ', ' + IntToStr(CurrencyRoundPlaces) + '), ' +
                    ' foreignBalanceAmount   = ROUND(foreignBalanceAmount   - ' + FloatToStr( TGuiSuppPaymentLines(Sender).ForeignPayment) + ', ' + IntToStr(CurrencyRoundPlaces) + ') ' +
                    ' WHERE IsCredit         = "T" and PurchaseOrderID= ' + IntToStr(TGuiSuppPaymentLines(Sender).TransID) +';' +
                  ' UPDATE tblPurchaseOrders SET ' +
                    ' Payment                = ROUND(Payment                - ' + FloatToStr( TGuiSuppPaymentLines(Sender).Payment) + ', ' + IntToStr(CurrencyRoundPlaces) + '), ' +
                    ' Balance                = ROUND(Balance                + ' + FloatToStr( TGuiSuppPaymentLines(Sender).Payment) + ', ' + IntToStr(CurrencyRoundPlaces) + '), ' +
                    ' ForeignPaidAmount      = ROUND(ForeignPaidAmount      - ' + FloatToStr( TGuiSuppPaymentLines(Sender).ForeignPayment) + ', ' + IntToStr(CurrencyRoundPlaces) + '), ' +
                    ' foreignBalanceAmount   = ROUND(foreignBalanceAmount   + ' + FloatToStr( TGuiSuppPaymentLines(Sender).ForeignPayment) + ', ' + IntToStr(CurrencyRoundPlaces) + ') ' +
                    ' WHERE IsCredit         = "F" and PurchaseOrderID= ' + IntToStr(TGuiSuppPaymentLines(Sender).TransID) +';' ;
    end;
    PostList.AddQuery(strSQL, TGuiSuppPaymentLines(Sender).TransID , 'tblPurchaseOrders', False);
    strSQL :='UPDATE tblPurchaseOrders Set Paid = "T" WHERE PurchaseOrderID = ' + IntToStr(TGuiSuppPaymentLines(Sender).TransID)  +
                    ' and Balance = 0;' +
             'UPDATE tblPurchaseOrders Set Paid = "F" WHERE PurchaseOrderID = ' + IntToStr(TGuiSuppPaymentLines(Sender).TransID)  +
                    ' and Balance <> 0;';
    PostList.AddQuery(strSQL, TGuiSuppPaymentLines(Sender).TransID , 'tblPurchaseOrders', False);
  end;
end;

Procedure TSuppPayments.Createlines;
begin
  ShowProgressbar(GUILines.Count, 'Check for Transactions');
  try
    GuiLines.IterateRecords(CallbackCreateLines);
  finally
    HideProgressbar;
  end;
end;

function TSuppPayments.AddDiscountToOrder(var msg: string): Boolean;
begin
  Result := true;
  if fbDiscountApplied then Exit;
  Connection.BeginNestedTransaction;
  try
    AllLinesValid := False;
    ShowProgressbar(GUILines.Count, 'Add discount to the Order');
    try
      GuiLines.IterateRecords(CallBackAddDiscountToOrder);
    finally
      HideProgressbar;
    end;
    Result := AllLinesValid;
    if Result then begin
        RefreshguiLines;
        fbDiscountApplied := true;
        if not silentMode then begin
            CalcTotals;
        end;
       connection.CommitNestedTransaction;
       result:= true;
       SendEvent(BusObjEvent_Change,BusobjEventVal_PurchaseDiscountApplied, self);
    end else begin
      result:= false;
      msg := ResultStatus.Messages;
      connection.RollbackNestedTransaction;
    end;
  Except
    result:= false;
    connection.RollbackNestedTransaction;
  end;
end;

function TSuppPayments.AddOrderLine(const fOrderObj: TOrderBase;
  const ProductName: String; const Price, Qty: Double; var msg: string): Boolean;
var
  SEQNo, sortID: Integer;
begin
    Result := False;
    if fOrderObj.Dataset.RecordCount = 0 then Exit;
    fOrderObj.UserLock.enabled := False; // the record is locked by the repayment so safe to overWrite.
    fOrderObj.Lines.Last;
    SeqNo := fOrderObj.Lines.SeqNo;
    SortId := fOrderObj.Lines.SortID;
    fOrderObj.AllowNewRecordWhenLocked:= true;
    fOrderObj.Lines.New;
    fOrderObj.Lines.ProductName    := Productname;
    fOrderObj.Lines.UOMMultiplier  := 1;
    fOrderObj.Lines.UOMQtySold     := Qty;
    fOrderObj.Lines.UOMOrderQty    := Qty;
    fOrderObj.Lines.LineCostInc := Price;
    fOrderObj.Lines.UOMQtyShipped  := Qty; //-1;
    fOrderObj.Lines.SeqNo:= SeqNo+1;
    fOrderObj.Lines.SortID:= SortID+10;
    fOrderObj.Lines.PostDB;
    fOrderObj.ResultStatus.Clear;
    if fOrderObj.Lines.ValidateData then begin
      fUpdatedPOList.AddIfNotInList(fOrderObj.ID);
      Result := true;
    end
    else
      msg := fOrderObj.ResultStatus.Messages;
end;

function TSuppPayments.AddBillLine(const fOrderObj: TOrderBase;
  const AccountName: String; const CostInc: Double; var msg: string): Boolean;
var
  SEQNo, sortID: Integer;
begin
    Result := False;
    if fOrderObj.Dataset.RecordCount = 0 then Exit;
    fOrderObj.UserLock.enabled := False; // the record is locked by the repayment so safe to overWrite.
    fOrderObj.Lines.Last;
    SeqNo := fOrderObj.Lines.SeqNo;
    SortId := fOrderObj.Lines.SortID;
    fOrderObj.Lines.New;
    fOrderObj.Lines.AccountName := AccountName;
    fOrderObj.Lines.LineCostInc := CostInc;
    fOrderObj.Lines.SeqNo:= SeqNo+1;
    fOrderObj.Lines.SortID:= SortID+10;
    fOrderObj.Lines.PostDB;
    TBill(fOrderObj).Billtotal := fOrderObj.TotalAmountInc;
    fOrderObj.ResultStatus.Clear;
    if fOrderObj.Lines.ValidateData then begin
      fUpdatedPOList.AddIfNotInList(fOrderObj.ID);
      Result := true;
    end
    else
      msg := fOrderObj.ResultStatus.Messages;
end;

procedure TSuppPayments.CallBackAddDiscountToOrder(const Sender: TBusObj;
  var Abort: Boolean);
var
  DiscProd: string;
  msg: string;
begin
    StepProgressbar;
    if not (Sender is TGuiSuppPaymentLines) then Exit;
    { can only apply a discount to a Purchase Order or a Bill }
    if not (SameText(TGuiSuppPaymentLines(Sender).TransType,POType) or SameText(TGuiSuppPaymentLines(Sender).TransType,Billtype)) then exit;

    if (TGuiSuppPaymentLines(Sender).Discount = 0) and (TGuiSuppPaymentLines(Sender).Refunding = 0) then exit;
    Try
        if (TGuiSuppPaymentLines(Sender).Discount <> TGuiSuppPaymentLines(Sender).CleanDiscount)  then begin
            if TGuiSuppPaymentLines(Sender).IsEarlyPaymentDiscount then
              DiscProd := EARLY_PAYMENT_DISCOUNT_PRODUCT
            else
              DiscProd := PAYMENT_Discount_PRODUCT;

            if SameText(TGuiSuppPaymentLines(Sender).TransType, POType) then begin
              if not AddOrderLine(TGuiSuppPaymentLines(Sender).OrderObj, DiscProd , TGuiSuppPaymentLines(Sender).Discount, -1, msg) then begin
                  AddResult(false,rssWarning,0,'Could not Add Line to Purchase Order: ' + msg);
                  abort := true;
                  Exit;
              End;
              if not TGuiSuppPaymentLines(Sender).OrderObj.Save then begin
                  msg := TGuiSuppPaymentLines(Sender).OrderObj.ResultStatus.Messages;
                  AddResult(false,rssWarning,0,'Could not Add Line to Purchase Order: ' + msg);
                  abort := True;
                  Exit;
              End;
            end
            else if SameText(TGuiSuppPaymentLines(Sender).TransType, BillType) then begin
              if not AddBillLine(TGuiSuppPaymentLines(Sender).OrderObj, DiscProd, -1 * TGuiSuppPaymentLines(Sender).Discount,msg) then begin
                  AddResult(false,rssWarning,0,'Could not Add Line to Bill: ' + msg);
                  abort := true;
                  Exit;
              End;
              if not TGuiSuppPaymentLines(Sender).OrderObj.Save then begin
                  msg := TGuiSuppPaymentLines(Sender).OrderObj.ResultStatus.Messages;
                  AddResult(false,rssWarning,0,'Could not Add Line to Bill: ' + msg);
                  abort := True;
                  Exit;
              End;
            end;
        end;
        if (TGuiSuppPaymentLines(Sender).Refunding <> TGuiCustPaymentLines(Sender).CleanRefunding) then
            if not MakeCredit(TGuiSuppPaymentLines(Sender).OrderObj, TGuiSuppPaymentLines(Sender).Refunding, 1, TGuiSuppPaymentLines(Sender).IsEarlyPaymentDiscount, msg) then  begin
              AddResult(false,rssWarning,0,'Could not create Credit: ' + msg);
              abort := True;
              Exit;
            end;
    finally
        AllLinesValid := true;
    end;
end;

procedure TSuppPayments.CallbackCalcTotals(const Sender: TBusObj;
  var Abort: Boolean);
begin
  inherited;
  fdTotalDiscount := fdTotalDiscount + TGuiSuppPaymentLines(Sender).Discount;
  fdTotalRefunding := fdTotalRefunding + TGuiSuppPaymentLines(Sender).Refunding;
end;

Procedure TSuppPayments.CallbackCreateLines(Const Sender: TBusObj; var Abort: Boolean);
begin
  StepProgressbar;
  if not (Sender is TGuiSuppPaymentLines) then Exit;
  if not(TGuiSuppPaymentLines(Sender).Applied) then Exit;

  Lines.New;
  Lines.TrnType           := TGuiSuppPaymentLines(Sender).TransType;
  if Sysutils.SameText(Lines.TrnType,Prepaytype) then
    Lines.PrePaymentID  := TGuiSuppPaymentLines(Sender).TransID
  else
    Lines.POID         := TGuiSuppPaymentLines(Sender).TransID;
  Lines.TransDate           := TGuiSuppPaymentLines(Sender).TransDate;
  Lines.TransNo             := TGuiSuppPaymentLines(Sender).TransNumber;
  Lines.InvoiceNo           := TGuiSuppPaymentLines(Sender).InvoiceNumber;
  Lines.InvoiceDate         := TGuiSuppPaymentLines(Sender).InvoiceDate;
  Lines.OriginalAmount      := TGuiSuppPaymentLines(Sender).OriginalAmount;
  Lines.ForeignOriginalAmt  := TGuiSuppPaymentLines(Sender).ForeignOriginalAmt;
  Lines.AmountDue           := TGuiSuppPaymentLines(Sender).AmountDue;
  Lines.ForeignAmountDue    := TGuiSuppPaymentLines(Sender).ForeignAmountDue;
  Lines.Payment             := TGuiSuppPaymentLines(Sender).Payment;
  Lines.ForeignPayment      := TGuiSuppPaymentLines(Sender).ForeignPayment;
  Lines.AmountOutstanding   := TGuiSuppPaymentLines(Sender).AmountOutStanding;
  Lines.ForeignOutStanding  := TGuiSuppPaymentLines(Sender).ForeignOutStanding;
  if TGuiSuppPaymentLines(Sender).amountOutstanding = 0 then
    Lines.PaidInfull   := 'Yes'
  else
    Lines.PaidInfull   := 'No';
  Lines.ClassId           := Self.ClassId;
  Lines.PostDB;
end;

Function TSuppPayments.getABAObj: TABADetailRecord;
begin
  Result := TABADetailRecord(getContainerComponent(TABADetailRecord , 'TransID = ' + IntToStr(ID) + ' and TransType = ' + QuotedStr('Supp Pay')));
end;

Function TSuppPayments.Valid4Email : Boolean;
var
  list: string;
begin
    result := false;

    if clientId = 0 then begin
        AddResult(False, rssWarning, 0 , 'Client should not be blank');
        Exit;
    end;
    list := GetContactEmails(ClientId, 'MainContactForSupplierPayment');
    if list = '' then begin // Client.email = '' then begin
      if SilentMode then begin
        AddResult(False, rssWarning, 0 , client.clientName + ' does not have an email address to send to.  ' +
                    'Please review customer information to add an email address.');
        exit;
      end
      else begin
        if CommonLib.MessageDlgXP_Vista(Client.clientName +
          ' does not have an email address to send to.' +#13#10+
          'Do you wish to load the email program anyway?',  mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
      end;
    end;
  Result := true;
end;

Function TSuppPayments.Valid4EFT(OpenDetailform:Boolean= False):Boolean;
begin
  Result := true;
  if self.ClientID < 1 then
    exit;
  BankAccountInvalid4EFT  := False;
  ClientInvalid4EFT       := False;
  if not AddtoEFT then Exit;
  Client.Closedb; { force supplier to reload its data (in case user has just updated bank details) }
  if not TSupplier(Client).ValidEFTSupplier then begin
    AddResult(false, rssWarning, 0, 'This Supplier does not have all the Required Bank Account' + chr(13) +
                            'Details to use Electronic Funds Transfer !');
    Result := False;
    ClientInvalid4EFT := True;
    if OpenDetailform then if Assigned(fGetEFTDetails) then GetEFTDetails;
    Exit;
  end;
  GLAccount.Closedb;
  if not GLAccount.ValidEFTAccount then begin
    AddResult(false, rssWarning, 0, 'The GL Bank Account ('+ GLAccount.AccountName +')  does not have all the Required Bank Account' + chr(13) +
                            'Details to use Electronic Funds Transfer !');
    Result := False;
    BankAccountInvalid4EFT := true;
    if OpenDetailform then if Assigned(fGetEFTDetails) then GetEFTDetails;
    Exit;
  end;
end;

Class Function  TSuppPayments.GetBusObjectTablename: String;
begin
    Result:= 'tblwithdrawal';
end;

Class function  TSuppPayments.GetTranstype: String;
begin
    Result := 'Supplier Payment';
end;

function TSuppPayments.GetTotalDiscount: Double;
begin
  Result := fdtotalDiscount;
end;

Function  TSuppPayments.GetTransactionsChanged: Boolean;
var
    StrSQL:String;
begin
    strSQL := 'Select  tblPurchaseOrders.PurchaseOrderId as ID,' +
                ' If(tblpurchaseorders.IsBill="T","Bill",If(tblpurchaseorders.IsPO="T",' + QuotedStr(POType) +' ,If(tblpurchaseorders.IsCredit="T",' + QuotedStr(CreditType) + ' ,' + QuotedStr(RAType) + ' ))) as Type' +
                ' FROM tblpurchaseorders' +
                ' INNER JOIN tblwithdrawallines ON tblwithdrawallines.POID = tblpurchaseorders.PurchaseOrderID' +
                ' INNER JOIN tblwithdrawal ON tblwithdrawal.PaymentID = tblwithdrawallines.PaymentID' +
                ' WHERE tblwithdrawallines.TrnType <>  "Prepayment"' +
                ' AND tblwithdrawal.PaymentID = ' + IntToStr(ID) +
                ' AND tblwithdrawallines.Originalamount <> if(ISCredit,-tblpurchaseorders.TotalamountInc, tblpurchaseorders.TotalamountInc)' +
                ' UNION' +
                ' SELECT tblPrepayments.PrePaymentId as IT, ' + QuotedStr(PrePayType) +
                ' FROM tblPrepayments' +
                ' INNER JOIN tblwithdrawallines on tblwithdrawallines.PrepaymentID = tblPrepayments.PrePaymentId' +
                ' INNER JOIN tblwithdrawal on tblwithdrawal.PaymentID = tblwithdrawallines.PaymentID' +
                ' WHERE tblPrepayments.Supplier="T"' +
                ' AND ((Payamount <> originalAmount) Or (OrderDate <> PrepaymentDate))' +
                ' AND tblwithdrawallines.`TrnType` =  "Prepayment"' +
                ' AND tblwithdrawal.PaymentID = ' + IntToStr(ID) ;
    with getNewdataset(strSQL ) do try
        Result := Recordcount > 0;
        if Result then begin
            First;
            LockMsg := '';
            While Eof = False do begin
                if LockMsg <> '' then LockMsg := chr(13);
                LockMsg := LockMsg + fieldByname('ID').AsString + ' - ' + Fieldbyname('Type').asString;
                Next;
            end;
        end;
    finally
        if Active then close;
        Free;
    end;
end;

Procedure TSuppPayments.POPaymentLines(Var QrySource:TERPQuery);
begin
  qrySource.SQL.Clear;
  qrySource.SQL.Add('SELECT TrnType,tblwithdrawallines.OrderDate,tblwithdrawallines.InvoiceDate,InvoiceNo,');
  qrySource.SQL.Add('PONo,tblpurchaseorders.Comments ,OriginalAmount,tblwithdrawallines.AmountDue,tblwithdrawallines.Payment,AmountOutstanding,');
  qrySource.SQL.Add('"T" ,If(IsNull(POID),PrepaymentID,POID),tblwithdrawal.ForeignExchangeCode,');
  qrySource.SQL.Add('tblwithdrawal.ForeignExchangeRate,ForeignOriginalAmount,');
  qrySource.SQL.Add('ForeignAmountDue,ForeignPayment,ForeignAmountOutstanding,');
  qrySource.SQL.Add('PaidInFull,E.EmployeeName from tblwithdrawal');
  qrySource.SQL.Add('INNER JOIN tblemployees E ON tblwithdrawal.EmployeeID = E.EmployeeID');
  qrySource.SQL.Add('Inner Join (tblwithdrawallines ');
  qrySource.SQL.Add('LEFT join tblpurchaseOrders ON tblwithdrawallines.POID = tblpurchaseorders.purchaseorderid)');
  qrySource.SQL.Add('ON tblwithdrawal.PaymentID = tblwithdrawallines.PaymentID');
  qrySource.SQL.Add('Where tblwithdrawal.PaymentID =' + IntToStr(ID));
end;

Procedure TSuppPayments.POOutStandingTrans(Var QrySource:TERPQuery; aPOtype:String = ''; aPOID:Integer = 0);
begin
  qrySource.SQL.Clear;
  if (aPOtype = '') or not sametext(aPOtype , PrePayType) then begin
      qrySource.SQL.Add('SELECT If(tblpurchaseorders.IsBill="T",' + QuotedStr(Billtype) +' ,If(tblpurchaseorders.IsPO="T",' + QuotedStr(POType)  +' ,If(tblpurchaseorders.IsCredit="T",' + QuotedStr(Credittype) + ',If(tblpurchaseorders.Ischeque="T" ,' + QuotedStr(ChequeType) +',' +  QuotedStr(RAType)+')))) as Type,');
      qrySource.SQL.Add('SupplierName                           as SupplierName, ');
      qrySource.SQL.Add('OrderDate                              as OrderDate,');
      qrySource.SQL.Add('InvoiceDate                            as InvoiceDate,');
      qrySource.SQL.Add('InvoiceNumber                          as InvoiceNumber, ');
      qrySource.SQL.Add('tblpurchaseorders.GlobalRef            as GlobalRef, ');
      qrySource.SQL.Add('tblpurchaseorders.Comments             as Comments, ');
      qrySource.SQL.Add('PurchaseOrderNumber                    as PurchaseOrderNumber, ');
      qrySource.SQL.Add('If(IsCredit="T",-tblpurchaseorders.TotalAmountInc,tblpurchaseorders.TotalAmountInc) as TotalAmountInc, ');
      qrySource.SQL.Add('If(IsCredit="T",-tblpurchaseorders.Balance,tblpurchaseorders.Balance) as Balance,');
      qrySource.SQL.Add('0, ');
      qrySource.SQL.Add('If(IsCredit="T",-tblpurchaseorders.Balance,tblpurchaseorders.Balance) , ');
      qrySource.SQL.Add('Paid                                   as Paid, ');
      qrySource.SQL.Add('tblpurchaseorders.PurchaseOrderID      as PurchaseOrderID, ');
      qrySource.SQL.Add('tblpurchaseorders.ForeignExchangeCode  as ForeignExchangeCode, ');
      qrySource.SQL.Add('tblpurchaseorders.ForeignExchangeRate  as ForeignExchangeRate, ');
      qrySource.SQL.Add('If(IsCredit="T",-tblpurchaseorders.ForeignTotalAmount, tblpurchaseorders.ForeignTotalAmount) as ForeignTotalAmount, ');
      qrySource.SQL.Add('0, ');
      qrySource.SQL.Add('If(IsCredit="T",-tblpurchaseorders.ForeignBalanceAmount, tblpurchaseorders.ForeignBalanceAmount) as ForeignBalanceAmount ,');
      qrySource.SQL.Add('If(IsCredit="T",-tblpurchaseorders.ForeignBalanceAmount, tblpurchaseorders.ForeignBalanceAmount), ');
      qrySource.SQL.Add('tblpurchaseorders.RefNo                as RefNo,');
      qrySource.SQL.Add('tblpurchaseorders.EnteredBy            as EnteredBy');
      qrySource.SQL.Add('FROM tblpurchaseorders');
      qrySource.SQL.Add('INNER JOIN tblpurchaselines ON tblpurchaselines.PurchaseOrderID = tblpurchaseorders.PurchaseOrderID  ');
      qrySource.SQL.Add('INNER JOIN tblClients  ON  tblpurchaseorders.ClientID = tblClients.ClientID  ');
      qrySource.SQL.Add('WHERE tblpurchaseorders.ClientID =' + IntToStr(clientID) );
      qrySource.SQL.Add('AND (IsBill ="T" OR IsPO ="T" OR IsCredit ="T") AND IsRA ="F" ');
      qrySource.SQL.Add('AND tblpurchaseorders.Deleted<>"T" And TotalAmountInc <> 0 AND Paid="F" ');
      {For VS1, PO doesn't need invoice number to pay}
      qrySource.SQL.Add('AND If((IsCredit="T" OR IsBill="T" or ' + Quotedstr(BooleanToStr(appenv.appdb.apimode))+ '="T" ),1,char_length(tblpurchaseorders.InvoiceNumber))>0  ');
      qrySource.SQL.Add('AND tblpurchaseorders.Balance <> 0');
      if SalePOIDs <> '' then qrySource.SQL.Add('AND tblpurchaseorders.PurchaseOrderId In (' + SalePOIDs +')');
      if aPOtype   <> '' then qrySource.SQL.Add('AND If(tblpurchaseorders.IsBill="T",' + QuotedStr(Billtype) +' ,If(tblpurchaseorders.IsPO="T",' + QuotedStr(POType)  +' ,If(tblpurchaseorders.IsCredit="T",' + QuotedStr(Credittype) + ',If(tblpurchaseorders.Ischeque="T" ,' + QuotedStr(ChequeType) +',' +  QuotedStr(RAType)+')))) =' + quotedstr(aPOtype));
      if aPOID     <> 0  then qrySource.SQL.Add('AND tblpurchaseorders.PurchaseOrderId In (' + inttostr(aPOID) +')');
      if AppEnv.CompanyPrefs.POOnlyApprovedTransInSuppPayment then begin
        qrySource.SQL.Add('AND Approved = "T" ');
      end;
      qrySource.SQL.Add('GROUP BY tblpurchaseorders.PurchaseOrderID ');
  end;

  if (aPOtype = '') or  sametext(aPOtype , PrePayType) then begin
    if qrySource.SQL.count >0 then qrySource.SQL.Add('UNION ALL ');
    qrySource.SQL.Add('SELECT');
    qrySource.SQL.Add(QuotedStr(PrePayType) + '                 as Type, ');
    qrySource.SQL.Add('CompanyName                              as SupplierName, ');
    qrySource.SQL.Add('tblprepayments.PrePaymentDate            as OrderDate,');
    qrySource.SQL.Add('tblprepayments.PrePaymentDate            as InvoiceDate, ');
    qrySource.SQL.Add('""                                       as InvoiceNumber, ');
    qrySource.SQL.Add('tblprepayments.GlobalRef                 as GlobalRef, ');
    qrySource.SQL.Add('tblprepayments.Notes                     as "Comments", ');
    qrySource.SQL.Add('tblprepayments.PrePaymentID              as PurchaseOrderNumber, ');
    qrySource.SQL.Add('-tblprepayments.PayAmount                as TotalAmountInc, ');
    qrySource.SQL.Add('-tblprepayments.Balance                  as Balance,');
    qrySource.SQL.Add('0,');
    qrySource.SQL.Add('-tblprepayments.Balance, ');
    qrySource.SQL.Add('tblprepayments.Paid                      as Paid, ');
    qrySource.SQL.Add('tblprepayments.PrePaymentID              as PurchaseOrderID,');
    qrySource.SQL.Add('tblprepayments.ForeignExchangeCode       as ForeignExchangeCode, ');
    qrySource.SQL.Add('tblprepayments.ForeignExchangeRate       as ForeignExchangeRate, ');
    qrySource.SQL.Add('-tblprepayments.ForeignPayAmount         as ForeignTotalAmount, ');
    qrySource.SQL.Add('0, ');
    qrySource.SQL.Add('-tblprepayments.ForeignBalance           as ForeignBalanceAmount, ');
    qrySource.SQL.Add('-tblprepayments.ForeignBalance           as ForeignBalance,');
    qrySource.SQL.Add('tblprepayments.ReferenceNo               as RefNo,');
    qrySource.SQL.Add('E.EmployeeName                           as EnteredBy');
    qrySource.SQL.Add('FROM tblprepayments');
    qrySource.SQL.Add('INNER JOIN tblemployees E ON tblprepayments.EmployeeId=E.EmployeeId');
    qrySource.SQL.Add('WHERE Supplier="T" AND tblprepayments.Paid="F" AND tblprepayments.Deleted="F" ');
    qrySource.SQL.Add('AND tblprepayments.Balance <> 0');
    qrySource.SQL.Add('AND tblprepayments.ClientID = ' + IntToStr(clientID) );
    if PrepayIDS <> '' then qrySource.SQL.Add('AND tblprepayments.PrePaymentID In (' + PrepayIDS +')');
    if aPOID     <> 0  then qrySource.SQL.Add('AND tblprepayments.PrePaymentID In (' + inttostr(aPOID) +')');
    qrySource.SQL.Add('GROUP By tblprepayments.PrePaymentID ');
  end;
  qrySource.SQL.Add('ORDER BY PurchaseOrderID;');
end;

Function TSuppPayments.getGUIPaymentLines :TGUIPaymentLines;
var
    SQLList:TStringList;
    qrySource, qryDest: TERPQuery;
    x: integer;
begin
    Result := TGUISuppPaymentLines(Container.ItemByClass(TGUISuppPaymentLines, false));

    If Assigned(Result) then exit;

    SQLList := TStringList.Create;
    try
        GuiSuppPaymentLinesTablename := '';
        GuiTablename := TGUISuppPaymentLines.GetBusObjectTablename;
        SQLList.Add('Create table '+ GuiTablename );
        SQLList.Add('(ID                    int             NOT NULL    AUTO_INCREMENT, ');
        SQLList.Add('Type                   varchar(16)     NOT NULL    default "",');
        SQLList.Add('SupplierName           varchar(255)                default NULL,');
        SQLList.Add('OrderDate              date                        default NULL,');
        SQLList.Add('InvoiceDate            Date                        default NULL,');
        SQLList.Add('InvoiceNumber          varchar(30)                 default NULL,');
        SQLList.Add('GlobalRef              varchar(255)                default NULL,');
        SQLList.Add('Comments               varchar(255)                default NULL,');
        SQLList.Add('PurchaseOrderNumber    varchar(30)               default NULL,');
        SQLList.Add('OriginalAmount         double                      default NULL,');
        SQLList.Add('Balance                double                      default NULL,');
        SQLList.Add('Paid                   Enum("T","F")               Default "F",');
        SQLList.Add('Payment                double                      default NULL,');
        SQLList.Add('AmountOutStanding      double                      default NULL,');
        SQLList.Add('PurchaseOrderID        int(11)         NOT NULL    default 0,');
        SQLList.Add('ForeignExchangeCode    char(3)                     default NULL,');
        SQLList.Add('ForeignExchangeRate    double                      default NULL,');
        SQLList.Add('`SplitForeignExchangeCode` VARCHAR(3)      NULL     DEFAULT NULL ,');
        SQLList.Add('`SplitForeignExchangeRate` DOUBLE          NULL     DEFAULT NULL ,');
        SQLList.Add('`SplitForeignPayment`      DOUBLE          NULL     DEFAULT NULL,');
        SQLList.Add('ForeignOriginalAmt     double                      default NULL,');
        SQLList.Add('ForeignBalanceAmount   double                      default NULL,');
        SQLList.Add('ForeignPayment         double                      default NULL,');
        SQLList.Add('Discount                   Double                   DEFAULT 0,');
        SQLList.Add('Refunding                  Double                   DEFAULT 0,');
        SQLList.Add('RefundPercent              Double                   DEFAULT 0,');
        SQLList.Add('ForeignAmountOutstanding  Double                   default NULL,');
        SQLList.Add('PaidInFull             varchar(3),');
        SQLList.Add('Apply                  Enum("T","F")               DEFAULT "F",');
        SQLList.Add('IsEarlyPaymentDiscount     Enum("T","F")            DEFAULT "F",');
        SQLList.Add('RefNo                  Varchar(255)                DEFAULT NULL,');
        SQLList.Add('EnteredBy              Varchar(255)                DEFAULT NULL,');
        SQLList.Add('Primary Key (ID)) ENGINE=MYISAM ');
        ExecuteSQL(SQLList); //keep this outside transaction, otherwise CREATE TABLE calls commit as the table cretion cannot be rolled back
        SQLList.Clear;
        if  (ClientID <> 0) and (GUIMode or (cleanid <>0) or (fbBulkPayment)) then begin
            qrySource:= TERPQuery.Create(nil);
            qryDest:= TERPQuery.Create(nil);
            try
              qrySource.Connection := self.Connection.Connection;
              {Binny - this needs to be self.connection - When discount is applied (PLLY Discnt), the discount line is added to the invoice and totoal is recalculated and saved with this connection in transaction
              Then the form is rereshed to have the values after the discounts.
              using shared connection doesn't see those changes}
              qryDest.Connection:= CommonDbLib.GetSharedMyDacConnection;
              if Lines.count = 0 then begin
                  qryDest.SQL.Add('SELECT Type,SupplierName, OrderDate, InvoiceDate, InvoiceNumber,');
                  qryDest.SQL.Add('GlobalRef, Comments, PurchaseOrderNumber, OriginalAmount, Balance,Payment, AmountOutStanding,');
                  qryDest.SQL.Add(' Paid, PurchaseOrderID, ForeignExchangeCode, ForeignExchangeRate,');
                  qryDest.SQL.Add(' ForeignOriginalAmt, ForeignPayment, ForeignBalanceAmount, ForeignAmountOutstanding,RefNo,EnteredBy FROM ' + GuiTableName);
                  POOutstandingTrans(QrySource);
              end else begin
                  qryDest.SQL.Add('SELECT Type,OrderDate,InvoiceDate,InvoiceNumber,PurchaseOrderNumber,Comments,');
                  qryDest.SQL.Add('OriginalAmount,Balance,Payment,AmountOutStanding,');
                  qryDest.SQL.Add('apply,PurchaseOrderID,ForeignExchangeCode,ForeignExchangeRate,');
                  qryDest.SQL.Add('ForeignOriginalAmt,ForeignBalanceAmount,ForeignPayment,');
                  qryDest.SQL.Add('ForeignAmountOutstanding,');
                  qryDest.SQL.Add('Paidinfull,EnteredBy  FROM ' + GuiTableName);
                  POPaymentLines(qrySource);
              end;
              qrySource.Open;
              qryDest.Open;
              while not qrySource.Eof do begin
                qryDest.Insert;
                for x:= 0 to qrySource.FieldCount - 1 do
                  qryDest.Fields[x].Value:= qrySource.Fields[x].Value;
                qryDest.Post;
                qrySource.Next;
              end;
              qryDest.Close;
              qrySource.Close;
            finally
              qrySource.Free;
              qryDest.Free;
            end;
        end;
        ExecuteSQL(SQLList, true);
    Finally
        FreeAndNil(SQLList);
    end;
    Result      := TGUISuppPaymentLines(getcontainerComponent(TGUISuppPaymentLines));
    REsult.Load;
    if Result.Count > 0 then Lock;
    if Lines.count = 0 then begin
        if Amount <> 0      then Amount      := 0;
        if applied <> 0     then Applied     := 0;
        if unapplied <> 0   then UnApplied   := 0;
    end;
end;

Procedure TSuppPayments.RefreshguiLines;
begin
  SendEvent(BusobjEvent_Event, BusObjEventVal_BeforeRefreshGuiLines);
  try
    Container.clear(TGuiSuppPaymentLines);
    GUILines;
    if assigned(ChangeDisplayLabel) then ChangeDisplayLabel;
  finally
    SendEvent(BusobjEvent_Event, BusObjEventVal_AfterRefreshGuiLines);
  end;
end;

destructor TSuppPayments.Destroy;
begin
  fUpdatedPOList.Free;
  DestroyUserTemporaryTable(TERPConnection(Connection.Connection), GuiSuppPaymentLinesTablename);
  inherited;
end;

Function TSuppPayments.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
    Result                      := inherited DoAfterInsert(Sender);
    if not Result then exit;
    PaymentDate                 := Date;
    ClassID                     := AppEnv.DefaultClass.ClassID;
    AccountID                   := AppEnv.CompanyPrefs.DefaultSuppPaymentAccount;
    ForeignVariationAccountID   := AppEnv.CompanyPrefs.SupplierPaymentsDefaultVariationAccountID;
    Amount                      := 0;
    Credit                      := 0;
    Applied                     := 0;
    UnApplied                   := 0;
    ForeignApplied              := 0;
    ForeignUnApplied            := 0;
    Supplier                    := True;
    Payment                     := True;
    PayMethodID                 := AppEnv.CompanyPrefs.DefaultPayMethodID;
    Cheque                      := False;
    ChequePrinted               := False;
    RefreshguiLines;
    fUpdatedPOList.Clear;
end;

Function TSuppPayments.getPaymentLines :TSuppPaymentLines;
begin
    Result := TSuppPaymentLines(GetContainerComponent(TSuppPaymentLines , 'PaymentID = ' + IntToStr(ID)));
end;

Procedure TSuppPayments.SetAddtoEFT(Const Value :Boolean);
begin
  fbAddToEFt:= Value;
end;

Function  TSuppPayments.GetInvoiceRefNo             : String    ; begin Result := GetStringField('InvoiceRefNo') ;end;
Function  TSuppPayments.GetCheque                   : Boolean   ; begin Result := GetBooleanField('Cheque')      ;end;
Function  TSuppPayments.GetChequePrinted            : Boolean   ; begin Result := GetBooleanField('ChequePrinted');end;
Function  TSuppPayments.GetClientID                 : Integer   ; begin Result := GetIntegerField('SupplierID')  ;end;
Function  TSuppPayments.GetPayment                  : Boolean   ; begin Result := GetBooleanField('SupplierPayment')      ;end;
Procedure TSuppPayments.SetInvoiceRefNo             (Const Value: String    ); begin SetStringField('InvoiceRefNo' , Value);end;
Procedure TSuppPayments.SetCheque                   (Const Value: Boolean   ); begin SetBooleanField('Cheque'      , Value);end;
Procedure TSuppPayments.SetChequePrinted            (Const Value: Boolean   ); begin SetBooleanField('ChequePrinted' , Value);end;
Procedure TSuppPayments.SetClientID                 (Const Value: Integer   ); begin SetIntegerField('SupplierID'  , Value);end;
Procedure TSuppPayments.SetPayment                  (Const Value: Boolean   ); begin SetBooleanField('SupplierPayment'      , Value);end;

function TSuppPayments.getReconcilations(const TransLockType: TTransLockType): Boolean;
Var
  LockManagement :TLockManagement;
  ResultLocked :Boolean;
  ResultTransLockType :TTransLockType;
begin
  LockManagement := TLockManagement.Create;
  try
    ResultLocked := LockManagement.IsSupplierPaymentLocked(ID,ResultTransLockType);
    Result := ResultLocked and (ResultTransLockType=TransLockType);
  finally
    LockManagement.Free;
  end;
end;

function TSuppPayments.getUseFC: Boolean;
begin
  result:= inherited getUseFC;
  if not result then
    Result := (AppEnv.CompanyPrefs.UseForeignCurrencyOnPO);
end;

procedure TSuppPayments.CallbackLock(const Sender: TBusObj;
  var Abort: Boolean);
begin
    StepProgressbar;
    if not (Sender is TGUIPaymentLines) then exit;

    if TGUIPaymentLines(sender).TransType = PrePayType then begin
        if not Userlock.Lock('tblPrepayments', TGUIPaymentLines(Sender).TransID, self.LockGroupName ) then begin
            AddResult(False,rssWarning,0,
                StringReplace(userlock.LockMessage, 'this record' , 'Prepayment record#' +IntToStr(TGUIPaymentLines(Sender).TransID), [rfReplaceAll, rfIgnoreCase]));
            AlllinesValid := False;
            abort := True;
        end;
    end else begin
        if not Userlock.Lock('tblPurchaseOrders', TGUIPaymentLines(Sender).TransID, self.LockGroupName ) then begin
            AddResult(False,rssWarning,0,StringReplace(userlock.LockMessage, 'this record' , 'Purchase record' + '#' +
                IntToStr(TGUIPaymentLines(Sender).TransID),[rfReplaceAll, rfIgnoreCase]));
            AlllinesValid := False;
            abort := True;
        end;
    end;
end;

procedure TSuppPayments.CallbackValidateLines(const Sender: TBusObj;
  var Abort: Boolean);
begin
  StepProgressbar;
  if not TSuppPaymentLines(Sender).ValidateData then begin
    AllLinesValid:= false;
    Abort:= true;
  end;
end;

function TSuppPayments.ValidateLines: boolean;
begin
  AllLinesValid:= true;
  ShowProgressbar(Lines.Count, 'Validate');
  try
    Lines.IterateRecords(self.CallbackValidateLines);
  finally
    HideProgressbar;
  end;
  result:= AllLinesValid;
end;

function TSuppPayments.GetContractorPayment: boolean;
begin
  result := GetBooleanField('ContractorPayment');
end;

procedure TSuppPayments.SetContractorPayment(const Value: boolean);
begin
  SetBooleanField('ContractorPayment',Value);
end;

{TPaymentLines}

Destructor TPaymentLines.Destroy;
begin
  inherited;
end;

Procedure TPaymentLines.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PaymentID');
  SetPropertyFromNode(node,'PrePaymentID');
  SetPropertyFromNode(node,'TrnType');
  SetPropertyFromNode(node,'OriginalAmount');
  SetPropertyFromNode(node,'Payment');
  SetPropertyFromNode(node,'AmountOutstanding');
  SetPropertyFromNode(node,'AmountDue');
  SetPropertyFromNode(node,'PaidInFull');
  SetPropertyFromNode(node,'ForeignOriginalAmt');
  SetPropertyFromNode(node,'ForeignAmountDue');
  SetPropertyFromNode(node,'ForeignPayment');
  SetPropertyFromNode(node,'ForeignOutStanding');
  SetPropertyFromNode(node,'TransID');
  SetPropertyFromNode(node,'TransDate');
  SetPropertyFromNode(node,'TransNo');
end;


Procedure TPaymentLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PaymentID'                   ,PaymentID);
  AddXMLNode(node,'PrePaymentID'                ,PrePaymentID);
  AddXMLNode(node,'TrnType'                     ,TrnType);
  AddXMLNode(node,'OriginalAmount'              ,OriginalAmount);
  AddXMLNode(node,'Payment'                     ,Payment);
  AddXMLNode(node,'AmountOutstanding'           ,AmountOutstanding);
  AddXMLNode(node,'AmountDue'                   ,AmountDue);
  AddXMLNode(node,'PaidInFull'                  ,PaidInFull);
  AddXMLNode(node,'ForeignOriginalAmt'          ,ForeignOriginalAmt);
  AddXMLNode(node,'ForeignAmountDue'            ,ForeignAmountDue  );
  AddXMLNode(node,'ForeignPayment'              ,ForeignPayment);
  AddXMLNode(node,'ForeignOutStanding'          ,ForeignOutStanding);
  AddXMLNode(node,'TransDate'       ,TransDate);
  AddXMLNode(node,'TransNo'         ,TransNo);
end;


Function TPaymentLines.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


Function TPaymentLines.Save: Boolean ;
begin
  Result := inherited Save;
end;


Procedure TPaymentLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


Procedure TPaymentLines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


Function TPaymentLines.GetSQL: String;
begin
  Result := inherited GetSQL;
end;


Class Function TPaymentLines.GetIDField: String;
begin
  Result := 'PaymentLineID'
end;

Function TPaymentLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
Function TPaymentLines.DoAfterInsert(Sender:TDatasetBusObj):Boolean;
begin
    Result := inherited DoAfterInsert(Sender);
    if not Result then Exit;

    if Assigned(Self.Owner) then
      if Self.Owner is TPayments then begin
        PaymentId := TPayments(Self.Owner).ID;
        EnteredBy := AppEnv.Employee.EmployeeName;
      end;
end;
{Property Functions}
Function  TPaymentLines.GetPaymentID                 : Integer   ; begin Result := GetIntegerField('PaymentID')             ;end;
Function  TPaymentLines.GetPrePaymentID              : Integer   ; begin Result := GetIntegerField('PrePaymentID')          ;end;

Function  TPaymentLines.GetTrnType                   : String    ; begin Result := GetStringField('TrnType')                ;end;
Function  TPaymentLines.GetOriginalAmount            : Double    ; begin Result := GetFloatField('OriginalAmount')          ;end;
Function  TPaymentLines.GetPayment                   : Double    ; begin Result := GetFloatField('Payment')                 ;end;
Function  TPaymentLines.GetAmountOutstanding         : Double    ; begin Result := GetFloatField('AmountOutstanding')       ;end;

Function  TPaymentLines.GetAmountDue                 : Double    ; begin Result := GetFloatField('AmountDue')               ;end;
Function  TPaymentLines.GetPaidInFull                : String    ; begin Result := GetStringField('PaidInFull')             ;end;
Function  TPaymentLines.GetEnteredBy                 : String    ; begin Result := GetStringField('EnteredBy ')             ;end;

Function  TPaymentLines.GetForeignOriginalAmt        : Double    ; begin Result := GetFloatField('ForeignOriginalAmount')   ;end;
Function  TPaymentLines.GetForeignAmountDue          : Double    ; begin Result := GetFloatField('ForeignAmountDue')        ;end;
Function  TPaymentLines.GetForeignPayment            : Double    ; begin Result := GetFloatField('ForeignPayment')          ;end;
Function  TPaymentLines.GetForeignOutStanding        : Double    ; begin Result := GetFloatField('ForeignAmountOutstanding');end;
Procedure TPaymentLines.SetPaymentID                 (Const Value: Integer   ); begin SetIntegerField('PaymentID'             ,Value);end;

Procedure TPaymentLines.SetPrePaymentID(Const Value: Integer);
begin
  SetIntegerField('PrePaymentID', Value);
  TrnType := PrePayType;
end;

Procedure TPaymentLines.SetTrnType                   (Const Value: String    ); begin SetStringField('TrnType'                ,Value);end;
Procedure TPaymentLines.SetOriginalAmount            (Const Value: Double    ); begin SetFloatField('OriginalAmount'          ,Value);end;
Procedure TPaymentLines.SetPayment                   (Const Value: Double    ); begin SetFloatField('Payment'                 ,Value);end;
Procedure TPaymentLines.SetAmountOutstanding         (Const Value: Double    ); begin SetFloatField('AmountOutstanding'       ,Value);end;

Procedure TPaymentLines.SetAmountDue                 (Const Value: Double    ); begin SetFloatField('AmountDue'               ,Value);end;
Procedure TPaymentLines.SetPaidInFull                (Const Value: String    ); begin SetStringField('PaidInFull'             ,Value);end;
Procedure TPaymentLines.SetForeignOriginalAmt        (Const Value: Double    ); begin SetFloatField('ForeignOriginalAmount'   ,Value);end;
Procedure TPaymentLines.SetForeignAmountDue          (Const Value: Double    ); begin SetFloatField('ForeignAmountDue'        ,Value);end;
Procedure TPaymentLines.SetForeignPayment            (Const Value: Double    ); begin SetFloatField('ForeignPayment'          ,Value);end;

Procedure TPaymentLines.SetForeignOutStanding        (Const Value: Double    ); begin SetFloatField('ForeignAmountOutstanding',Value);end;
Procedure TPaymentLines.SetEnteredBy                 (Const Value: String    ); begin SetStringField('EnteredBy'              ,Value);end;

{TCustPaymentLines}
Constructor TCustPaymentLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'CustPaymentLines';
  fSQL                      := 'SELECT * FROM tbldepositline';
  ExportExcludeList.Add('saleid');
  //ExportExcludeList.Add('trntype');
end;
Procedure TCustPaymentLines.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'MSReceived');
  SetPropertyFromNode(node,'RefNo');
end;
Procedure TCustPaymentLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'MSReceived' ,MSReceived);
  AddXMLNode(node,'RefNo'      ,RefNo);
  AddXMLNode(node,'TransID'    ,SaleID);

end;
Class Function  TCustPaymentLines.GetBusObjectTablename :String;
begin
    Result := 'tbldepositline';
end;
function TCustPaymentLines.GetInvoiceId: integer;
begin
  if SameText(TrnType, InvType) then
    result := self.SaleID
  else
    result := 0;
end;

Procedure TCustPaymentLines.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
end;
Function  TCustPaymentLines.GetMSReceived   : Boolean   ; begin Result := GetBooleanField('MSReceived')     ;end;
Function  TCustPaymentLines.GetRefNo        : String    ; begin Result := GetStringField('RefNo')           ;end;

function TCustPaymentLines.GetRefundId: integer;
begin
  if SameText(TrnType, RefundType) then
    result := self.SaleID
  else
    result := 0;
end;

Function  TCustPaymentLines.GetSaleID       : Integer   ; begin Result := GetIntegerField('SaleID')         ;end;
Function  TCustPaymentLines.GetTransDate    : TDateTime ; begin Result := GetDateTimeField('InvoiceDate')   ;end;
Function  TCustPaymentLines.GetTransNo      : String    ; begin Result := GetStringField('InvoiceNo')       ;end;

procedure TCustPaymentLines.SetInvoiceId(const Value: integer);
begin
  TrnType := InvType;
  SaleId := Value;
end;

Procedure TCustPaymentLines.SetMSReceived   (Const Value: Boolean   ); begin SetBooleanField('MSReceived'   ,Value);end;
Procedure TCustPaymentLines.SetRefNo        (Const Value: String    ); begin SetStringField('RefNo'         ,Value);end;
Procedure TCustPaymentLines.SetSaleID       (Const Value: Integer   ); begin SetIntegerField('SaleID'       ,Value);end;

procedure TCustPaymentLines.SetSefundIf(const Value: integer);
begin
  TrnType := RefundType;
  SaleId := Value;
end;
function TCustPaymentLines.GetSplitForeignExchangeCode: String   ; begin Result := GetStringField('SplitForeignExchangeCode')             ;end;
function TCustPaymentLines.GetSplitForeignExchangeRate: Double   ; begin Result := GetFloatField('SplitForeignExchangeRate')             ; end;
function TCustPaymentLines.GetSplitForeignPayment    : Double    ; begin Result := GetFloatField('splitForeignPayment')             ; end;
Procedure TCustPaymentLines.SetSplitForeignExchangeCode(Const Value: String  ); begin SetStringField('SplitForeignExchangeCode', Value)             ;end;
Procedure TCustPaymentLines.SetSplitForeignExchangeRate(Const Value: Double  ); begin SetFloatField('SplitForeignExchangeRate', Value)             ; end;
Procedure TCustPaymentLines.SetSplitForeignPayment    (Const Value: Double   ); begin SetFloatField('splitForeignPayment', Value)             ; end;

Procedure TCustPaymentLines.SetTransDate    (Const Value: TDateTime ); begin SetDateTimeField('InvoiceDate' ,Value);end;
Procedure TCustPaymentLines.SetTransNo      (Const Value: String    ); begin SetStringField('InvoiceNo'     ,Value);end;

function TCustPaymentLines.ValidateData: boolean;
var
  msg: string;
  data: TJsonObject;
  TransId: integer;
begin
  { validate payment details for each line }
  data:= nil;
  result:= ValidatePaymentLine(self,data, self.Connection.Connection);
  try
    if not result then begin
      msg:= data.S['message'];
      AddResult(False, rssWarning, 0, msg);
      Exit;
    end;
  finally
    if not result then begin
      if self.TrnType = PrePayType then TransId:= self.PrePaymentID
      else TransId:= self.SaleID;
      SendPaymentError(self,TPayments(Owner).ID,TransID,TrnType,TPayments(Owner).ValidationStage,msg);
    end;
    data.Free;
  end;

end;

{TSuppPaymentLines}
Constructor TSuppPaymentLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SuppPaymentLines';
  fSQL := 'SELECT * FROM tblwithdrawallines';
end;
Procedure TSuppPaymentLines.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'InvoiceNo');
  SetPropertyFromNode(node,'ClassID');
  SetPropertyFromNode(node,'InvoiceDate');
end;
Procedure TSuppPaymentLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'InvoiceNo'   ,InvoiceNo);
  AddXMLNode(node,'ClassID'     ,ClassID);
  AddXMLNode(node,'InvoiceDate' ,InvoiceDate);
  AddXMLNode(node,'TransID'     ,POID);


end;
Class Function  TSuppPaymentLines.GetBusObjectTablename :String;
begin
    Result := 'tblwithdrawallines';
end;
Function  TSuppPaymentLines.GetInvoiceNo    : String    ; begin Result := GetStringField('InvoiceNo')    ;end;
Function  TSuppPaymentLines.GetClassID      : Integer   ; begin Result := GetIntegerField('ClassID')     ;end;
Function  TSuppPaymentLines.GetInvoiceDate  : TDateTime ; begin Result := GetDateTimeField('InvoiceDate');end;
Function  TSuppPaymentLines.GetPOID         : Integer   ; begin Result := GetIntegerField('POID')        ;end;
Function  TSuppPaymentLines.GetTransDate    : TDateTime ; begin Result := GetDateTimeField('OrderDate')  ;end;
Function  TSuppPaymentLines.GetTransNo      : String    ; begin Result := GetStringField('PONo')         ;end;
Procedure TSuppPaymentLines.SetInvoiceNo    (Const Value: String    ); begin SetStringField('InvoiceNo'      , Value);end;
Procedure TSuppPaymentLines.setClassID      (Const Value: Integer   ); begin SetIntegerField('ClassID'       , Value);end;
Procedure TSuppPaymentLines.SetInvoiceDate  (Const Value: TDateTime ); begin SetDateTimeField('InvoiceDate'  , Value);end;
Procedure TSuppPaymentLines.SetPOID         (Const Value: Integer   ); begin SetIntegerField('POID'          , Value);end;
Procedure TSuppPaymentLines.SetTransDate    (Const Value: TDateTime ); begin SetDateTimeField('OrderDate'    , Value);end;
Procedure TSuppPaymentLines.SetTransNo      (Const Value: String    ); begin SetStringField('PONo'           , Value);end;

function TSuppPaymentLines.ValidateData: boolean;
var
  msg: string;
  data: TJsonObject;
  TransId: integer;
begin
  { validate payment details for each line }
  data:= nil;
  result:= ValidatePaymentLine(self,data, self.Connection.Connection);
  try
    if not result then begin
      msg:= data.S['message'];
      AddResult(False, rssWarning, 0, msg);
      Exit;
    end;
  finally
    if not result then begin
      if self.TrnType = PrePayType then TransId:= self.PrePaymentID
      else TransId:= self.POID;
      SendPaymentError(self,TPayments(Owner).ID,TransID,TrnType,TPayments(Owner).ValidationStage,msg);
    end;
    data.Free;
  end;
end;


{TGUIPaymentLines}

Function  TGUIPaymentLines.GetRefunding: Double;
begin
  Result := GetFloatField('Refunding');
End;

Procedure TGUIPaymentLines.SetRefunding(Const Value: Double);
begin
  SetFloatField('Refunding', Value);
end;

function TGUIPaymentLines.GetRefundPercent: Double;
begin
  result := GetFloatField('RefundPercent');
end;

procedure TGUIPaymentLines.SetRefundPercent(const Value: Double);
begin
  SetFloatField('RefundPercent',Value);
end;

function TGUIPaymentLines.GetIsEarlyPaymentDiscount: boolean;
begin
  result := GetBooleanField('IsEarlyPaymentDiscount');
end;

procedure TGUIPaymentLines.SetIsEarlyPaymentDiscount(const Value: boolean);
begin
  SetBooleanField('IsEarlyPaymentDiscount',Value);
end;

function TGUIPaymentLines.GetDiscount: Double;
begin
  Result := GetFloatField('Discount');
end;

Function TGUIPaymentLines.GetCleanRefunding: Double;
begin
    Result:= GetXMLNodeFloatValue(CleanXMLNode, 'Refunding');
end;

Constructor TGUIPaymentLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'GUIPaymentLines';
  fSQL := '';
  fIsList := true;
end;

function TGUIPaymentLines.GetCleanDiscount: Double;
begin
  Result:= GetXMLNodeFloatValue(CleanXMLNode, 'Discount');
end;


Destructor TGUIPaymentLines.Destroy;
begin
  inherited;
end;


Procedure TGUIPaymentLines.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TransType');
  SetPropertyFromNode(node,'OriginalAmount');
  SetPropertyFromNode(node,'AmountDue');
  SetPropertyFromNode(node,'Paid');
  SetPropertyFromNode(node,'Applied');
  SetPropertyFromNode(node,'ForeignExchangeCode');
  SetPropertyFromNode(node,'ForeignExchangeRate');
  SetPropertyFromNode(node,'ForeignOriginalAmt');
  SetPropertyFromNode(node,'ForeignAmountDue');
  SetPropertyFromNode(node,'ClientName');
  SetPropertyFromNode(node,'TransDate');
  SetPropertyFromNode(node,'TransNumber');
  SetPropertyFromNode(node,'TransID');
end;


Procedure TGUIPaymentLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TransType' ,TransType);
  AddXMLNode(node,'OriginalAmount' ,OriginalAmount);
  AddXMLNode(node,'AmountDue' ,AmountDue);
  AddXMLNode(node,'Paid' ,Paid);
  AddXMLNode(node,'Applied' ,Applied);
  AddXMLNode(node,'ForeignExchangeCode' ,ForeignExchangeCode);
  AddXMLNode(node,'ForeignExchangeRate' ,ForeignExchangeRate);
  AddXMLNode(node,'ForeignOriginalAmt' ,ForeignOriginalAmt);
  AddXMLNode(node,'ForeignAmountDue' ,ForeignAmountDue);
  AddXMLNode(node,'ClientNameName' ,ClientName);
  AddXMLNode(node,'TransDate' ,TransDate);
  AddXMLNode(node,'TransNumber' ,TransNumber);
  AddXMLNode(node,'TransID' ,TransID);
end;


Function TGUIPaymentLines.ValidateData: Boolean ;
var
  data: TJsonObject;
  msg: string;
begin
  result:= true;
  msg:= '';
  if TPayments(owner).cleanid > 0 then exit;
  { validate payment details for each gui line using out of transaction connection
    to check figures before updating with new payment data }
  result:= ValidatePaymentLine(self,data);
  try
    if not result then begin
      result:= false;
      msg:= 'Existing transaction is incorrect: ' + data.S['message'];
      AddResult(False, rssWarning, 0, msg);
      Exit;
    end;
    if data.B['paid'] then begin
      result:= false;
      msg:= TransType + ' ' + IntToStr(TransId) + ' has already been flagged as paid.';
      AddResult(False, rssWarning, 0, msg);
      exit;
    end;
  finally
    if (not result) then
      SendPaymentError(self,TPayments(Owner).ID,TransID,TransType,TPayments(Owner).ValidationStage,msg);
    data.Free;
  end;
end;


Function TGUIPaymentLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


Procedure TGUIPaymentLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


Procedure TGUIPaymentLines.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.Fieldname , 'Payment') then begin
        ForeignPayment             := Localtoforeign(Payment, ForeignExchangeRate , CurrencyRoundPlaces);
        changePayment;
        PostDB;
        DoFieldOnChange(Dataset.findfield('Apply'));
    end else if Sysutils.SameText(Sender.Fieldname , 'ForeignPayment') then begin
        if (Sysutils.SameText(TransType , PrePayType)) or (Sysutils.SameText(TransType , CreditType)) (*or (Sysutils.SameText(TransType , RefundType))*)     then begin
            PostDB;// don;t remove it as otherwise the grid forces its value to the dataset when posted - when called from the form
            if ForeignPayment   > 0 then ForeignPayment := -(ForeignPayment);
            if ForeignPayment   < ForeignAmountDue  then    ForeignPayment := ForeignAmountDue;
            Payment             := ForeignToLocal(ForeignPayment, ForeignExchangeRate , CurrencyRoundPlaces);
            if Payment          < AmountDue         then    Payment := AmountDue;
        end else begin
            if ForeignPayment   > ForeignAmountDue  then    ForeignPayment := ForeignAmountDue;
            Payment             := ForeignToLocal(ForeignPayment, ForeignExchangeRate , CurrencyRoundPlaces);
            if Payment          > AmountDue         then    Payment := AmountDue;
        end;
        AmountOutStanding       := AmountDue - Payment;
        ForeignOutStanding      := LocalToForeign(AmountOutStanding , ForeignExchangeRate , CurrencyRoundPlaces);
        Applied                 := ForeignPayment <> 0;
        PostDB;
        DoFieldOnChange(Dataset.findfield('Apply'));
    end else if Sysutils.SameText(Sender.fieldName , 'Apply') then begin
        if Applied then begin
          SendEvent(BusObjEvent_Change,BusobjEventVal_applied);
            if Applied then begin
                if Payment = 0 then begin
                  Payment:= AmountOutStanding;
                  AmountOutStanding:= 0;
                  ForeignPayment:= ForeignOutStanding;
                  ForeignOutStanding:= 0;
                  PostDb;
                end;
                if Assigned(Self.Owner) and (Self.Owner is TPayments) and not(TPayments(Self.Owner).selectingall) then
                  TPayments(Self.Owner).DoCalcOrderTotals;//CalcTotals;
            end;
            //end;
        end else begin
           AmountOutStanding := AmountOutStanding + Payment ;
           Payment           := 0;
           ForeignOutStanding:= ForeignOutStanding+ForeignPayment;
           ForeignPayment    := 0;
           PostDB;
           if Assigned(Self.Owner) and (Self.Owner is TPayments) and not(TPayments(Self.Owner).SelectingAll) then
            TPayments(Self.Owner).DoCalcOrderTotals;//CalcTotals;
        end;
        PostDB;
    end;
end;


Function TGUIPaymentLines.GetSQL: String;
begin
  Result := inherited GetSQL;
end;


Class Function TGUIPaymentLines.GetIDField: String;
begin
  Result := 'ID'
end;


Class Function TGUIPaymentLines.GetBusObjectTablename: String;
begin
  Result:= '';
end;


Function TGUIPaymentLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
Function  TGUIPaymentLines.DoAfterOpen(Sender:TDatasetBusObj) : Boolean;
begin
  Result := inherited DoAfterOpen(Sender);
  if not Result then Exit;
  if Assigned(Self.Owner) and (Self.Owner is TPayments) and (assigned(TPayments(Self.Owner).ChangeDisplayLabel)) then
        TPayments(Self.Owner).ChangeDisplayLabel;

end;
procedure TGuiCustPaymentLines.CalcforeignFromSplitforeign;
begin
  if (SplitForeignExchangeCode<> '') and not(sametext(SplitForeignExchangeCode , ForeignExchangeCode)) then begin
      ForeignPayment      := Payment            * ForeignExchangeRate;
  end;
end;

Procedure TGuiPaymentLines.changePayment;
begin
    if (Sysutils.SameText(TransType , PrePayType)) or (Sysutils.SameText(Transtype, CreditType)) or (Sysutils.SameText(TransType , RefundType)) then begin
        PostDB;// don't remove it as otherwise the grid forces its value to the dataset when posted - when called from the form
        if Payment          > 0                 then    Payment := -(Payment);
        if Payment          < AmountDue         then    payment := amountdue;
        ForeignPayment      := LocaltoForeign(Payment,  ForeignExchangeRate , CurrencyRoundPlaces);
        if ForeignPayment   < ForeignAmountDue  then    ForeignPayment := ForeignAmountDue;
    end else begin
        if Payment          > AmountDue         then    payment := amountdue;
        ForeignAmountDue    := LocaltoForeign(AmountDue,  ForeignExchangeRate , CurrencyRoundPlaces);
        ForeignPayment      := LocaltoForeign(Payment,  ForeignExchangeRate , CurrencyRoundPlaces);
        if ForeignPayment   > ForeignAmountDue  then    ForeignPayment := ForeignAmountDue;
    end;
    AmountOutStanding       := AmountDue - Payment;
    ForeignOutStanding      := LocalToForeign(AmountOutStanding , ForeignExchangeRate , CurrencyRoundPlaces);
    Applied                 := Payment <> 0;
end;

Function  TGUIPaymentLines.GetForeignExchangeCode : String    ;
begin
    Result   := GetStringField('ForeignExchangeCode');
    if Result = '' then REsult := AppEnv.RegionalOptions.ForeignExDefault; // refund has blank exchange code which should be the default curency
end;

Function  TGuiPaymentLines.getIsFCSelected:Boolean;
begin
    Result := False;
    if Assigned(Self.Owner) then
        if Self.Owner is TPayments then
            Result := TPayments(Self.Owner).IsFCSelected;
end;
Function  TGuiPaymentLines.GetHeaderPaymentDate:TDatetime;
begin
    Result := 0;
    if Assigned(Self.Owner) then
        if Self.Owner is TPayments then
            Result := TPayments(Self.Owner).PaymentDate;
end;
Function  TGuiPaymentLines.GetHeaderFCCode  :String;
begin
    Result := '';
    if Assigned(Self.Owner) then
        if Self.Owner is TPayments then
            Result := TPayments(Self.Owner).ForeignExchangeCode;
end;
function  TGuiPaymentLines.getHeaderUnapplied        : Double;
begin
    Result := 0;
    if Assigned(Self.Owner) then
        if Self.Owner is TPayments then
            Result := TPayments(Self.Owner).Unapplied;
end;

function  TGuiPaymentLines.getHeaderapplied          : Double;
begin
    Result := 0;
    if Assigned(Self.Owner) then
        if Self.Owner is TPayments then
            Result := TPayments(Self.Owner).ForeignApplied;
end;
function  TGuiPaymentLines.getHeaderForeignUnapplied        : Double;
begin
    Result := 0;
    if Assigned(Self.Owner) then
        if Self.Owner is TPayments then
            Result := TPayments(Self.Owner).ForeignUnapplied;
end;
function  TGuiPaymentLines.getHeaderForeignapplied          : Double;
begin
    Result := 0;
    if Assigned(Self.Owner) then
        if Self.Owner is TPayments then
            Result := TPayments(Self.Owner).Applied;
end;
function  TGuiPaymentLines.getHeaderBalance          : Double;
begin
    Result := 0;
    if Assigned(Self.Owner) then
        if Self.Owner is TPayments then
            Result := TPayments(Self.Owner).AmountDue;
end;
{Property Functions}
Function  TGUIPaymentLines.GetType                  : String    ; begin Result := GetStringField('Type')                      ;end;
Function  TGUIPaymentLines.GetOriginalAmount        : Double    ; begin Result := GetFloatField('OriginalAmount')             ;end;
Function  TGUIPaymentLines.GetAmountDue             : Double    ; begin Result := GetFloatField('Balance')                    ;end;
Function  TGUIPaymentLines.GetPaID                  : Boolean   ; begin Result := GetBooleanField('Paid')                     ;end;
Function  TGUIPaymentLines.getApplied               : Boolean   ; begin Result := GetBooleanField('Apply')                    ;end;
Function  TGUIPaymentLines.GetForeignExchangeRate   : Double    ; begin Result := GetFloatField('ForeignExchangeRate')        ;if result = 0 then result := 1;end;
Function  TGUIPaymentLines.GetAmountOutstanding     : Double    ; begin Result := GetFloatField('AmountOutStanding')          ;end;
Function  TGUIPaymentLines.GetForeignOutstanding    : Double    ; begin Result := GetFloatField('ForeignAmountOutstanding')   ;end;
Function  TGUIPaymentLines.GetPayment               : Double    ; begin Result := GetFloatField('Payment')                    ;end;
Function  TGUIPaymentLines.GetForeignPayment        : Double    ; begin Result := GetFloatField('ForeignPayment')             ;end;
Function  TGUIPaymentLines.GetForeignOriginalAmt    : Double    ; begin Result := GetFloatField('ForeignOriginalAmt')         ;end;

Procedure TGUIPaymentLines.SetType                  (Const Value: String    ); begin SetStringField('Type'                    , Value);end;
Procedure TGUIPaymentLines.SetOriginalAmount        (Const Value: Double    ); begin SetFloatField('OriginalAmount'           , Value);end;
Procedure TGUIPaymentLines.SetAmountDue             (Const Value: Double    ); begin SetFloatField('Balance'                  , Value);end;
Procedure TGUIPaymentLines.SetPaID                  (Const Value: Boolean   ); begin SetBooleanField('Paid'                   , Value);end;
Procedure TGUIPaymentLines.SetApplied               (Const Value: Boolean   ); begin SetBooleanField('Apply'                  , Value);end;
procedure TGUIPaymentLines.SetDiscount              (const Value: Double    ); begin SetFloatField('Discount'                 , Value);end;

Procedure TGUIPaymentLines.SetForeignExchangeCode   (Const Value: String    ); begin SetStringField('ForeignExchangeCode'     , Value);end;
Procedure TGUIPaymentLines.SetForeignExchangeRate   (Const Value: Double    ); begin SetFloatField('ForeignExchangeRate'      , Value);end;
Procedure TGUIPaymentLines.SetAmountOutStanding     (Const Value: Double    ); begin SetFloatField('AmountOutstanding'        , Value);end;
Procedure TGUIPaymentLines.SetForeignOutStanding    (Const Value: Double    ); begin SetFloatField('ForeignAmountOutstanding' , Value);end;
Procedure TGUIPaymentLines.SetPayment               (Const Value: Double    ); begin SetFloatField('Payment'                  , Value);end;
Procedure TGUIPaymentLines.SetForeignPayment        (Const Value: Double    ); begin SetFloatField('ForeignPayment'           , Value);end;
Procedure TGUIPaymentLines.SetForeignOriginalAmt    (Const Value: Double    ); begin SetFloatField('ForeignOriginalAmt'       , Value);end;
Procedure TGUIPaymentLines.SetForeignAmountDue      (Const Value: Double    ); begin SetFloatField('ForeignBalanceAmount'        , Value);end;
{TGuiSuppPaymentLines}
Procedure TGuiSuppPaymentLines.InitTransDetails;
var
  Qry:TERPQuery;
begin
  if Assigned(OwneR) and (Owner is TSuppPayments) then else exit;
  qry := GetSharedDataSet('', true);
  try
    TSuppPayments(Owner).POOutStandingTrans(Qry , TransType, TransID);
    commondblib.opendb(Qry);
    if qry.recordcount >0 then begin
        ClientName          := Qry.fieldbyname('SupplierName').asString;
        TransDate           := Qry.fieldbyname('OrderDate').asDateTime;
        InvoiceDate         := Qry.fieldbyname('InvoiceDate').asDateTime;
        InvoiceNumber       := Qry.fieldbyname('InvoiceNumber').asString;
        Comments            := Qry.fieldbyname('Comments').asString;
        TransNumber         := Qry.fieldbyname('PurchaseOrderNumber').asString;
        OriginalAmount      := Qry.fieldbyname('TotalAmountInc').asFloat;
        AmountDue           := Qry.fieldbyname('Balance').asFloat;
        ForeignExchangeCode := Qry.fieldbyname('ForeignExchangeCode').asString;
        ForeignExchangeRate := Qry.fieldbyname('ForeignExchangeRate').asFloat;
        ForeignOriginalAmt  := Qry.fieldbyname('ForeignTotalAmount').asFloat;
        ForeignAmountDue    := Qry.fieldbyname('ForeignBalanceAmount').asFloat;
        PostDB;
    end;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;

end;
Procedure TGuiSuppPaymentLines.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

    if Sysutils.SameText(sender.FieldName , 'Type') or
       Sysutils.SameText(sender.FieldName , 'PurchaseOrderID')  then begin
      if (TransID<>0) and (trim(TransType)<>'') then begin
        InitTransDetails;
      end;
    end;

    inherited;
    if Sysutils.SameText(Sender.fieldName , 'Apply') then begin
        if Applied then begin
            if (Sysutils.SameText(TransType , POType) or Sysutils.SameText(TransType, Billtype)) and (fbCheckEarlyPayment  = False ) and (Assigned(Self.Owner)) and
                (Self.owner is TSuppPayments) and  (Assigned(TSuppPayments(Self.Owner).DoEarlyPayment)) then begin
                fbCheckEarlyPayment := true;
                TSuppPayments(Self.Owner).DoEarlyPayment;
            end;
        end;
    end
    else if Sysutils.SameText(Sender.FieldName , 'RefundPercent') then begin
        PostDB;
        if not ((Sysutils.SameText(TransType , POType)) or (Sysutils.SameText(TransType , BillType))) then
          if RefundPercent <> 0 then
            RefundPercent := 0;
        if (RefundPercent <> 0) and (AmountDue <> 0) then
          Refunding := Round((RefundPercent / 100)  * self.AmountDue, CurrencyRoundPlaces)
        else
          Refunding := 0;
        if not silentMode then
            if  Assigned(Self.Owner) and (Self.Owner is TSuppPayments) then
                TSuppPayments(Self.Owner).DoCalcOrderTotals;//CalcTotals;
    end else if Sysutils.SameText(Sender.FieldName , 'Refunding') then begin
        PostDB;
        if not ((Sysutils.SameText(TransType , POType)) or (Sysutils.SameText(TransType , BillType))) then
          if Refunding <> 0 then
            Refunding := 0;
        if (Refunding <> 0) and (AmountDue <> 0) then
          RefundPercent := Round(Refunding  / self.AmountDue * 100,2)
        else
          RefundPercent := 0;
        if not silentMode then
            if  Assigned(Self.Owner) and (Self.Owner is TSuppPayments) then
                TSuppPayments(Self.Owner).DoCalcOrderTotals;//CalcTotals;
    end
    else if Sysutils.SameText(Sender.FieldName, 'Discount') then begin
        PostDB;
        if not (Sysutils.SameText(TransType, POType) or Sysutils.SameText(TransType, Billtype)) then begin
          if Discount <> 0 then begin
            SendEvent(BusObjEvent_UserInfoMessage, 'Can not apply a Discount to a ' +TransType+'. Discount will be set to 0.' , self);
            Discount := 0;
          end;
        end
        else begin
          if not silentMode then
            if Assigned(Self.Owner) and (Self.Owner is TSuppPayments) then
                TSuppPayments(Self.Owner).DoCalcOrderTotals;//CalcTotals;
        end;
    end;
end;

procedure TGuiSuppPaymentLines.EarlyPayment;
var
  EarlyPaymentDiscount        : Double;
  EarlyDiscountOrderLineID     : Integer;
  strSQL                      : String;
  qry: TERPQuery;

  Function OpenedForThisOrder: Boolean;
  begin
      Result := False;
      if Assigned(Owner) and (Owner is TSuppPayments) then begin
        if TSuppPayments(Self.Owner).OpenForOrderId = 0 then exit;
        result := (OrderObj.ID = TSuppPayments(Self.Owner).OpenForOrderId);
      end;
  end;
begin
    if ((TransType = POType) or (TransType = BillType)) and (not(IsFCSelected)) then begin
        strSQL := 'SELECT' +
                ' tblterms.EarlyPaymentDiscount,' +
                ' tblpurchaselines.PurchaseLineID, ' +
                ' DATE_ADD(tblpurchaseorders.DueDate, INTERVAL 0-tblterms.EarlyPaymentDays DAY) Duedate '+
                ' FROM tblpurchaseorders' +
                ' INNER JOIN tblterms ON tblterms.Terms = tblpurchaseorders.Terms' +
                ' INNER JOIN tblParts on PartName = ' + QuotedStr(EARLY_PAYMENT_Discount_PRODUCT) +
                ' LEFT JOIN tblpurchaselines ON ' +
                ' tblpurchaseorders.PurchaseOrderID = tblpurchaselines.PurchaseOrderID ' +
                ' AND tblpurchaselines.ProductName = ' + QuotedStr(EARLY_PAYMENT_Discount_PRODUCT) +
                ' WHERE tblpurchaseorders.PurchaseOrderID = ' + IntToStr(TransID)   +
                ' AND tblpurchaseorders.DueDate> ' + Quotedstr(FormatDateTime(MysqlDateFormat , HeaderPaymentDate));
        EarlyPaymentDiscount    :=0;
        EarlyDiscountOrderLineID :=0;
        qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.connection.connection);
        try
            Qry.SQL.text := strSQL;
            Qry.Open;
            if (qry.recordcount > 0) and (qry.FieldByname('Duedate').asDateTime >= TCustPayments(Owner).paymentdate ) then begin
                EarlyPaymentDiscount := qry.FieldByname('EarlyPaymentDiscount').asFloat;
                EarlyDiscountOrderLineID:= qry.FieldByname('PurchaseLineID').asInteger;
            end;
        finally
            DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
        end;
        if (EarlyDiscountOrderLineID = 0) and   (EarlyPaymentDiscount <> 0) then


            if Assigned(Owner) and (Owner is TSuppPayments) then begin
                PostDB;
                EarlyPaymentDiscount := EarlyPaymentDiscount*OrderObj.TotalAmountInc/100;
                if AppEnv.CompanyPrefs.SuppEarlyPaymentAction = 0 then begin
                  { Add a discount to the order line .. }
                  self.Discount :=  EarlyPaymentDiscount;
                  self.IsEarlyPaymentDiscount := true;
                end
                else if AppEnv.CompanyPrefs.SuppEarlyPaymentAction = 1 then begin
                  { Create a credit .. }
                  self.Refunding := EarlyPaymentDiscount;
                  self.IsEarlyPaymentDiscount := true;
                end;
            end;

    End;
end;

Class Function  TGuiSuppPaymentLines.GetBusObjectTablename    : String;
begin
  if GuiSuppPaymentLinesTablename = '' then
    GuiSuppPaymentLinesTablename := TempTableUtils.UniqueTableName('SuppPayments');
  result := GuiSuppPaymentLinesTablename;
end;

Function  TGuiSuppPaymentLines.GetSQL: String;
begin
    if FSQL = '' then
        fSQL := 'Select * from ' + GetBusObjectTablename;
    Result := inherited GetSQL;
end;

Destructor   TGuiSuppPaymentLines.Destroy;
begin
    closeDB;
    FreeandNil(fOrder);
    Inherited;
end;

Constructor  TGuiSuppPaymentLines.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
    fSQL := 'Select * from ' + GetBusObjectTablename;
    fbCheckEarlyPayment := False;
end;

Procedure    TGuiSuppPaymentLines.LoadFromXMLNode(Const node: IXMLNode);
begin
    inherited;
    SetPropertyFromNode(node,'InvoiceDate');
    SetPropertyFromNode(node,'InvoiceNumber');
    SetPropertyFromNode(node,'Comments');
    SetPropertyFromNode(node,'Discount');
end;
procedure TGuiSuppPaymentLines.OnDataIdChange(
  const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  fbCheckEarlyPayment := False;
  FreeAndNil(fOrder);
end;

Procedure    TGuiSuppPaymentLines.SaveToXMLNode(Const node: IXMLNode);
begin
    inherited;
    AddXMLNode(node,'InvoiceDate' ,InvoiceDate);
    AddXMLNode(node,'InvoiceNumber' ,InvoiceNumber);
    AddXMLNode(node,'Comments' ,Comments);
    AddXMLNode(node,'Discount' ,Discount);
end;
Function  TGuiSuppPaymentLines.GetInvoiceDate   : TDateTime ; begin Result := GetDateTimeField('InvoiceDate');end;
Function  TGuiSuppPaymentLines.GetInvoiceNumber : String    ; begin Result := GetStringField('InvoiceNumber');end;

function TGuiSuppPaymentLines.GetOrderObj: TOrderBase;
begin
  if not (Assigned(fOrder)) then begin
    if SameText(TransType,POType) then begin
      fOrder := TPurchaseOrder.Create(nil);
      fOrder.connection := Self.connection;
      fOrder.Load(TransID);
    end
    else if SameText(TransType,Billtype) then begin
      fOrder := TBill.Create(nil);
      fOrder.connection := Self.connection;
      fOrder.Load(TransID);
    end;
  end;
  result := fOrder;
end;

Function  TGuiSuppPaymentLines.GetComments      : String    ; begin Result := GetStringField('Comments');end;
Function  TGuiSuppPaymentLines.GetClientName    : String    ; begin Result := GetStringField('SupplierName');end;
Function  TGuiSuppPaymentLines.GetTransDate     : TDateTime ; begin Result := GetDateTimeField('OrderDate');end;
Function  TGuiSuppPaymentLines.GetTransNumber   : String    ; begin Result := GetStringField('PurchaseOrderNumber');end;
Function  TGuiSuppPaymentLines.GetTransID       : Integer   ; begin Result := GetIntegerField('PurchaseOrderID');end;
Procedure TGuiSuppPaymentLines.SetTransDate     (Const Value: TDateTime ); begin SetDateTimeField('OrderDate'            , Value);end;
Procedure TGuiSuppPaymentLines.SetTransNumber   (Const Value: String    ); begin SetStringField('PurchaseOrderNumber'             , Value);end;
function TGuiSuppPaymentLines.ValidateData: Boolean;
begin
  if Applied then
      if ForeignExchangeCode <> HeaderForeignExchangeCode then begin
          AddResult(False, rssWarning, 0, 'Transaction selected for the payment has a different Foreign Exchange code.');
          Result := False;
          Exit;
      end;
  result := inherited  ValidateData;
end;

Procedure TGuiSuppPaymentLines.SetTransID       (Const Value: Integer   ); begin SetIntegerField('PurchaseOrderID'      , Value);end;
Procedure TGuiSuppPaymentLines.SetInvoiceDate   (Const Value: TDatetime ); begin SetDateTimeField('InvoiceDate'          , Value);end;
Procedure TGuiSuppPaymentLines.SetInvoiceNumber (Const Value: String    ); begin SetStringField('InvoiceNumber'        , Value);end;
Procedure TGuiSuppPaymentLines.SetComments      (Const Value: String    ); begin SetStringField('Comments'             , Value);end;
Procedure TGuiSuppPaymentLines.SetClientName    (Const Value: String    ); begin SetStringField('SupplierName'         , Value);end;

{TGuiCustPaymentLines}

Procedure TGuiCustPaymentLines.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'RefNo');
  SetPropertyFromNode(node,'Discount');
end;

Procedure TGuiCustPaymentLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'RefNo', RefNo);
  AddXMLNode(node,'Discount', Discount);
end;

Function TGuiCustPaymentLines.ValidateData        : Boolean ;
begin
  Result := inherited ValidateData;
  if not result then exit;
end;

Function TGuiCustPaymentLines.GetSQL: String;
begin
  if FSQL = '' then
    fSQL := 'Select * from ' + GetBusObjectTablename;
  Result := inherited GetSQL;
end;

Class Function TGuiCustPaymentLines.GetBusObjectTablename : String;
begin
  if GuiCustPaymentLinesTablename = '' then
    GuiCustPaymentLinesTablename := TempTableUtils.UniqueTableName('CustPayments');
  result := GuiCustPaymentLinesTablename;
end;

Destructor TGuiCustPaymentLines.Destroy;
begin
    closedb;
    FreeandNil(fInvoice);
    inherited;
end;
Constructor  TGuiCustPaymentLines.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
    fSQL := 'Select * from ' + GetBusObjectTablename;
    fbCheckEarlyPayment := False;
    fInvoice := nil;
end;
Procedure TGuiCustPaymentLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
    inherited OnDataIdChange(ChangeType);
    fbCheckEarlyPayment := False;
    fInvoice:= nil;
end;
Function  TGuiCustPaymentLines.DoAfterInsert(Sender:TDatasetBusObj):Boolean;
begin
    Result := inherited DoAfterInsert(Sender);
end;

Function  TGuiCustPaymentLines.DoAfterPost(Sender:TDatasetBusObj) : Boolean;
begin
    Result := inherited DoAfterPost(Sender);
end;

Procedure TGuiCustPaymentLines.EarlyPayment;
var
    EarlyPaymentDiscount        : Double;
    EarlyDiscountSaleLineID     : Integer;
    strSQL                      : String;
    qry: TERPQuery;
    //fbFlag :boolean ;

(*    Function OpenedForthisSale:Boolean;
    begin
        Result := False;
        if Assigned(Owner) and (Owner is TCustPayments) then begin
          if TCustPayments(Self.Owner).OpenForSalesId = 0 then exit;
          result := (invoiceobj.ID = TCustPayments(Self.Owner).OpenForSalesId);
        end;
    end;*)

begin
    if (TransType = InvType) and (not(IsFCSelected)) then begin
        strSQL := 'SELECT' +
                ' tblterms.EarlyPaymentDiscount,' +
                ' tblsaleslines.SaleLineID, ' +
                ' DATE_ADD(tblsales.DueDate, INTERVAL 0-tblterms.EarlyPaymentDays DAY) Duedate '+
                ' FROM tblsales' +
                ' INNER JOIN tblterms ON tblterms.Terms = tblsales.Terms' +
                ' INNER JOIN tblParts on PartName = ' + QuotedStr(EARLY_PAYMENT_Discount_PRODUCT) +
                ' LEFT    JOIN tblsaleslines ON ' +
                ' tblsales.SaleID = tblsaleslines.SaleID ' +
                ' AND tblsaleslines.ProductNAme = ' + QuotedStr(EARLY_PAYMENT_Discount_PRODUCT) +
                ' WHERE tblsales.SaleID = ' + IntToStr(TransID)   +
                ' AND tblsales.DueDate> ' + Quotedstr(FormatDateTime(MysqlDateFormat , HeaderPaymentDate));
        EarlyPaymentDiscount    :=0;
        EarlyDiscountSaleLineID :=0;
        qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.connection.connection);
        try
            Qry.SQL.text := strSQL;
            Qry.Open;
            if (qry.recordcount > 0) and (qry.FieldByname('Duedate').asDateTime >= TCustPayments(Owner).paymentdate ) then begin
                EarlyPaymentDiscount := qry.FieldByname('EarlyPaymentDiscount').asFloat;
                EarlyDiscountSaleLineID:= qry.FieldByname('SaleLineID').asInteger;
            end;
        finally
            DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
        end;
        if (EarlyDiscountSaleLineID = 0) and   (EarlyPaymentDiscount <> 0) then begin
            if Assigned(Owner) and (Owner is TCustPayments) then begin
                PostDB;
                EarlyPaymentDiscount := EarlyPaymentDiscount*InvoiceObj.TotalAmountInc/100;
                if AppEnv.CompanyPrefs.CustEarlyPaymentAction = 0 then begin
                  { Add a discount to the sale line .. }
                  self.Discount :=  EarlyPaymentDiscount;
                  self.IsEarlyPaymentDiscount := true;
                end
                else if AppEnv.CompanyPrefs.CustEarlyPaymentAction = 1 then begin
                  { Create a refund .. }
                  self.Refunding := EarlyPaymentDiscount;
                  self.IsEarlyPaymentDiscount := true;
                end;
            end;
        end;
    End;
end;
Procedure TGuiCustPaymentLines.InitTransDetails;
var
  Qry:TERPQuery;
begin
  if Assigned(OwneR) and (Owner is TCustPayments) then else exit;
  qry := GetSharedDataSet('', true);
  try
    TCustPayments(Owner).SalesOutStandingTrans(Qry , TransType, TransID);
    commondblib.opendb(Qry);
    if qry.recordcount >0 then begin
        ClientName          := Qry.fieldbyname('CustomerName').asString;
        TransDate           := Qry.fieldbyname('SaleDate').asDateTime;
        TransNumber         := Qry.fieldbyname('InvoiceDocNumber').asString;
        OriginalAmount      := Qry.fieldbyname('TotalAmountInc').asFloat;
        AmountDue           := Qry.fieldbyname('Balance').asFloat;
        AmountOutstanding   := Qry.fieldbyname('AmountOutstanding').asFloat;
        ForeignOriginalAmt  := Qry.fieldbyname('ForeignTotalAmount').asFloat;
        ForeignAmountDue    := Qry.fieldbyname('ForeignBalanceAmount').asFloat;
        AmountOutStanding   := Qry.fieldbyname('ForeignAmountOutstanding').asFloat;
        ForeignExchangeCode := Qry.fieldbyname('ForeignExchangeCode').asString;
        ForeignExchangeRate := Qry.fieldbyname('ForeignExchangeRate').asFloat;
        RefNo               := Qry.fieldbyname('RefNo').asString;
        PostDB;
    end;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;
Procedure TGuiCustPaymentLines.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

    if Sysutils.SameText(sender.FieldName , 'Type') or
       Sysutils.SameText(sender.FieldName , 'SaleID')  then begin
      if (TransID<>0) and (trim(TransType)<>'') then begin
        InitTransDetails;
      end;
    end;

    inherited;
    if Sysutils.SameText(Sender.fieldName , 'Apply') then begin
        if Applied then begin
            if (Sysutils.SameText(TransType , InvType)) and (fbCheckEarlyPayment  = False ) and (Assigned(Self.Owner)) and
                (Self.owner is TCustPayments) and  (Assigned(TCustPayments(Self.Owner).DoEarlyPayment)) then begin
                fbCheckEarlyPayment := TRue;
                TCustPayments(Self.Owner).DoEarlyPayment;
            end;
        end
        else begin
          Discount := 0;
          Refunding := 0;
          RefundPercent := 0;
          IsEarlyPaymentDiscount := false;

//          x

        end;

    end else if Sysutils.SameText(Sender.FieldName , 'Withholding') then begin
        PostDB;
        if not (Sysutils.SameText(TransType , InvType)) then if Withholding <> 0 then Withholding := 0;
        if not silentMode then
            if  Assigned(Self.Owner) and (Self.Owner is TCustPayments) then
                TCustPayments(Self.Owner).DoCalcOrderTotals;//CalcTotals;
    end else if Sysutils.SameText(Sender.FieldName , 'RefundPercent') then begin
        PostDB;
        if not (Sysutils.SameText(TransType , InvType)) then if RefundPercent <> 0 then RefundPercent := 0;
        if (RefundPercent <> 0) and (AmountDue <> 0) then
          Refunding := Round((RefundPercent / 100)  * self.AmountDue, CurrencyRoundPlaces)
        else
          Refunding := 0;
        if not silentMode then
            if  Assigned(Self.Owner) and (Self.Owner is TCustPayments) then
                TCustPayments(Self.Owner).DoCalcOrderTotals;//CalcTotals;
    end else if Sysutils.SameText(Sender.FieldName , 'Refunding') then begin
        PostDB;
        if not (Sysutils.SameText(TransType , InvType)) then if Refunding <> 0 then Refunding := 0;
        if (Refunding <> 0) and (AmountDue <> 0) then
          RefundPercent := Round(Refunding  / self.AmountDue * 100,2)
        else
          RefundPercent := 0;
        if not silentMode then
            if  Assigned(Self.Owner) and (Self.Owner is TCustPayments) then
                TCustPayments(Self.Owner).DoCalcOrderTotals;//CalcTotals;
    end else if Sysutils.SameText(Sender.FieldName, 'SplitForeignPayment') then begin
                Payment             := ForeignToLocal(SplitForeignPayment, SplitForeignExchangeRate , CurrencyRoundPlaces);
                CalcforeignFromSplitforeign;
                DoFieldOnChange(Dataset.findfield('Payment'));
    end else if Sysutils.SameText(Sender.FieldName, 'SplitForeignExchangeRate') then begin
                Payment             := ForeignToLocal(SplitForeignPayment, SplitForeignExchangeRate , CurrencyRoundPlaces);
                CalcforeignFromSplitforeign;
                DoFieldOnChange(Dataset.findfield('Payment'));
    end else if Sysutils.SameText(Sender.FieldName, 'Discount') then begin
        PostDB;
        if not(Sysutils.SameText(TransType , InvType)) then if Discount <> 0 then Discount := 0;
        if not silentMode then
            if  Assigned(Self.Owner) and (Self.Owner is TCustPayments) then
                TCustPayments(Self.Owner).DoCalcOrderTotals;//CalcTotals;
    end;
end;

Function  TGuiCustPaymentLines.GetCleanWithholding: Double;
begin
    Result:= GetXMLNodeFloatValue(CleanXMLNode, 'Withholding');
end;

Function  TGuiCustPaymentLines.GetInvoiceObj :TInvoice;
begin
if not (Assigned(fInvoice)) then begin
    fInvoice := TInvoice.Create(Nil);
    fInvoice.connection := Self.connection;
    fInvoice.LoadSelect('SaleID = ' + IntToStr(TransID));
end;
  result := fInvoice;
end;

Function  TGuiCustPaymentLines.PrepaymentAccountID           : Integer;
begin
    Result := 0;
    with getNewDataset('select MasterAccountID from tblPrepayments where PrePaymentID = ' + IntToStr(TransID)) do try
        if recordcount = 0 then Exit;
        Result := fieldByname('MasterAccountID').asInteger;
    Finally
        if active then Close;
        Free;
    end;
end;


Function  TGuiCustPaymentLines.GetClientName    : String    ; begin Result := GetStringField('CustomerName')        ;end;
Function  TGuiCustPaymentLines.GetTransDate     : TDateTime ; begin Result := GetDateTimeField('SaleDate')          ;end;
Function  TGuiCustPaymentLines.GetTransNumber   : String    ; begin Result := GetStringField('InvoiceDocNumber')    ;end;
Function  TGuiCustPaymentLines.GetTransID       : Integer   ; begin Result := GetIntegerField('SaleID')             ;end;
Function  TGuiCustPaymentLines.GetRefNo         : String    ; begin Result := GetStringField('RefNo')               ;end;
Function  TGuiCustPaymentLines.Getwithholding   : Double    ; begin Result := GetFloatField('Withholding')          ;End;
Procedure TGuiCustPaymentLines.SetClientName    (Const Value: String    ); begin SetStringField('SupplierName'      , Value);end;
Procedure TGuiCustPaymentLines.SetTransDate     (Const Value: TDateTime ); begin SetDateTimeField('SaleDate'        , Value);end;
Procedure TGuiCustPaymentLines.SetTransNumber   (Const Value: String    ); begin SetStringField('InvoiceDocNumber'  , Value);end;
Procedure TGuiCustPaymentLines.SetTransID       (Const Value: Integer   ); begin SetIntegerField('SaleID'           , Value);end;
Procedure TGuiCustPaymentLines.SetRefNo         (Const Value: String    ); begin SetStringField('RefNo'             , Value);end;

Procedure TGuiCustPaymentLines.SetWithholding   (Const Value: Double    ); begin SetFloatField('Withholding'        , Value);end;
Function  TGUIPaymentLines.GetForeignAmountDue      : Double    ; begin Result := GetFloatField('ForeignBalanceAmount')       ;end;
function TGuiCustPaymentLines.GetSplitForeignExchangeCode: String   ; begin Result := GetStringField('SplitForeignExchangeCode')             ;end;
function TGuiCustPaymentLines.GetSplitForeignExchangeRate: Double   ; begin Result := GetFloatField('SplitForeignExchangeRate')             ; end;
function TGuiCustPaymentLines.GetSplitForeignPayment    : Double    ; begin Result := GetFloatField('splitForeignPayment')             ; end;
Procedure TGuiCustPaymentLines.SetSplitForeignExchangeCode(Const Value: String  ); begin SetStringField('SplitForeignExchangeCode', Value)             ;end;
Procedure TGuiCustPaymentLines.SetSplitForeignExchangeRate(Const Value: Double  ); begin SetFloatField('SplitForeignExchangeRate', Value)             ; end;
Procedure TGuiCustPaymentLines.SetSplitForeignPayment    (Const Value: Double   ); begin SetFloatField('splitForeignPayment', Value)             ; end;


initialization
  GuiCustPaymentLinesTablename := '';
  GuiSuppPaymentLinesTablename := '';
  RegisterClass(TCustPayments);
  RegisterClass(TCustomerPayments);
  RegisterClass(TSupplierPayments);


end.

