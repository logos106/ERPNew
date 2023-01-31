unit busObjBankDepost;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  10/09/07  1.00.01  bs  Initial Version.
  }


interface


uses BusObjBase, DB, Classes,  BusObjGLAccount, AdvProgr,
     Busobjclient, tcTypes, XMLDoc, XMLIntf;


type
    TBankDeposit        = Class;
    TGuiBankDepositDet  = Class;

    TGuiBankDeposit = Class(TMSBusObj)
    Private
        fsLockMsg                   : String;
        LinkedTransAssigned         : Boolean;
        AlllinesValid               : boolean;
        Function GetDepositId       : Integer   ;
        Function GetTrntype         : String    ;
        Function GetPaidDate        : TDateTime ;
        Function GetcompanyName     : String    ;
        Function GetAmount          : Double    ;
        Function GetTransactionID   : Integer   ;
        Function GetAccountName     : String    ;
        Function GetClassName       : String    ;
        Function GetChequeNo        : String    ;
        Function GetPaymentMethod   : String    ;
        Function GetTransID         : Integer   ;
        Function GetClientID        : Integer   ;
        Function GetPayMethodID     : Integer   ;
        Function GetAccountID       : Integer   ;
        Function getLinkedTrans     : TGuiBankDepositDet;
        Function getDeposited       : Boolean;
        Procedure SetDepositId      (Const Value: Integer   );
        Procedure SetTrntype        (Const Value: String    );
        Procedure SetPaidDate       (Const Value: TDateTime );
        Procedure SetcompanyName    (Const Value: String    );
        Procedure SetAmount         (Const Value: Double    );
        Procedure SetTransactionID  (Const Value: Integer   );
        Procedure SetAccountName    (Const Value: String    );
        Procedure SetClassName      (Const Value: String    );
        Procedure SetChequeNo       (Const Value: String    );
        Procedure SetPaymentMethod  (Const Value: String    );
        Procedure SetTransID        (Const Value: Integer   );
        Procedure SetClientID       (Const Value: Integer   );
        Procedure SetPayMethodID    (Const Value: Integer   );
        Procedure SetAccountID      (Const Value: Integer   );
        Procedure setdeposited      (Const Value: Boolean   );
        function getPaymentId: Integer;
        procedure SetPaymentId(const Value: Integer);
        procedure CallbackLockTrans(const Sender: Tbusobj; var Abort: Boolean);
    Protected
        Procedure OnDataIdChange(Const ChngType:TBusObjDataChangeType); Override;
        Procedure DoFieldOnChange(Sender: TField);                      Override;
        Function  GetSQL: String;                                       Override;
        Function  DoAfterPost(Sender: TDatasetBusObj): Boolean;         Override;
    Public
        Class Function GetIDField: String;                              Override;
        Class Function GetBusObjectTablename :String;                   Override;
        Constructor  Create(AOwner: TComponent);                        Override;
        Destructor   Destroy;                                           Override;
        Procedure    LoadFromXMLNode(Const node: IXMLNode);             Override;
        Procedure    SaveToXMLNode(Const node: IXMLNode);               Override;
        Procedure    Calctotals(Autoselecting :Boolean  =False);
        Function     ValidateData: Boolean ;                            Override;
        Function     Save: Boolean ;                                    Override;
        Property     LinkedTrans    : TGuiBankDepositDet Read getLinkedTrans;
        Property     LockMsg        : String             Read fsLockMsg Write fsLockMsg;
        Function AssignedLinkedtrans:Boolean;
        function LockTransactions:Boolean;
        function LockTransaction(fsTablename :String; TransactionID:Integer;var Msg:STring): boolean;
    Published
        Property DepositId         :Integer     Read GetDepositId       Write SetDepositId    ;
        Property TrnType           :String      Read GetTrntype         Write SetTrntype      ;
        Property PaidDate          :TDateTime   Read GetPaidDate        Write SetPaidDate     ;
        Property companyName       :String      Read GetcompanyName     Write SetcompanyName  ;
        Property Amount            :Double      Read GetAmount          Write SetAmount       ;
        Property TransactionID     :Integer     Read GetTransactionID   Write SetTransactionID;
        Property PaymentId         :Integer     Read getPaymentId       Write SetPaymentId;
        Property AccountName       :String      Read GetAccountName     Write SetAccountName  ;
        Property DeptClassName     :String      Read GetClassName       Write SetClassName    ;
        Property ChequeNo          :String      Read GetChequeNo        Write SetChequeNo     ;
        Property PaymentMethod     :String      Read GetPaymentMethod   Write SetPaymentMethod;
        Property TransID           :Integer     Read GetTransID         Write SetTransID      ;
        Property ClientID          :Integer     Read GetClientID        Write SetClientID     ;
        Property PayMethodID       :Integer     Read GetPayMethodID     Write SetPayMethodID  ;
        Property AccountID         :Integer     Read GetAccountID       Write SetAccountID    ;
        Property Deposited         :Boolean     Read getDeposited       Write SetDeposited;
    end;

    TGuiBankDepositDet = Class(TGuiBankDeposit)
    Private
        Function  GetLineID        : Integer   ;
        Function  getTransTablename     : String    ;
        Procedure SetLineID        (Const Value: Integer);
        Procedure setTransTablename     (Const Value: String );
        function getPaymentId: Integer;
        procedure SetPaymentID(const Value: Integer);
    public
        Procedure LoadFromXMLNode  (Const node: IXMLNode);              Override;
        Procedure SaveToXMLNode    (Const node: IXMLNode);              Override;
    Protected
    published
        Property  LineID           : Integer     Read GetLineID         Write SetLineID       ;
        Property TransTablename         : String      Read getTransTablename      Write setTransTablename    ;
        Property PaymentId         : Integer     Read getPaymentId      Write SetPaymentID;

    End;
    TBankDepositLinesSales = class(TMSBusObj)
    private
      function GetbankdepositlinesID         : Integer   ;
      function GetTransID                    : Integer   ;
      procedure SetbankdepositlinesID         (const Value: Integer   );
      procedure SetTransID                    (const Value: Integer   );
      function getPaymentMethod: String;
      procedure setPaymentMethod(const Value: String);
      function getPaymentID: Integer;
      procedure setPaymentID(const Value: Integer);
      function getAmount: double;
      procedure setAmount(const Value: double);
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
      property bankdepositlinesID          :Integer     read GetbankdepositlinesID        write SetbankdepositlinesID     ;
      property TransID                     :Integer     read GetTransID                   write SetTransID                ;
      Property PaymentMethod               :String      read getPaymentMethod             Write setPaymentMethod;
      Property PaymentID                   :Integer     Read getPaymentID                 write setPaymentID;
      Property Amount                      :double      read getAmount                    write setAmount;
    end;

    TBankDepositLines = Class(TMSBusObj)
    Private
        Function GetDepositID         : Integer   ;
        Function GetPaymentID         : Integer   ;
        Function GetTrnsType          : String    ;
        Function GetCusID             : Integer   ;
        Function GetPayMethodID       : Integer   ;
        Function GetPaymentMethod     : String    ;
        Function GetPaymentDate       : TDateTime ;
        Function GetCompanyName       : String    ;
        Function GetReferenceNo       : String    ;
        Function GetClassID           : Integer   ;
        Function GetTransClassName    : String    ;
        Function GetAccountID         : Integer   ;
        Function GetAccountName       : String    ;
        Function GetName              : String    ;
        Function GetAmount            : Double    ;
        Function GetNotes             : String    ;
        Function GetCustomer          : Boolean   ;
        Function GetSupplier          : Boolean   ;
        Function GetEmployee          : Boolean   ;
        Function GetContact           : Boolean   ;
        Function GetDeposited         : Boolean   ;
        Function GetDeleted           : Boolean   ;
        Function GetStatementNo       : Integer   ;
        Function GetFromDeposited     : Boolean   ;
        Function GetReconciled        : Boolean   ;
        Function GetTransID           : String    ;
        Function GetHeader            : TBankDeposit;
        Function getAccount           : TAccount;
        Function getclient            : Tclient;
        Function getTranstype         : String;
        function getTransPaymentID: Integer;
        Procedure SetDepositID         (Const Value: Integer   );
        Procedure SetPaymentID         (Const Value: Integer   );
        Procedure SetTrnsType          (Const Value: String    );
        Procedure SetCusID             (Const Value: Integer   );
        Procedure SetPayMethodID       (Const Value: Integer   );
        Procedure SetPaymentMethod     (Const Value: String    );
        Procedure SetPaymentDate       (Const Value: TDateTime );
        Procedure SetCompanyName       (Const Value: String    );
        Procedure SetReferenceNo       (Const Value: String    );
        Procedure setClassID           (Const Value: Integer   );
        Procedure SetTransClassName    (Const Value: String    );
        Procedure SetAccountID         (Const Value: Integer   );
        Procedure SetAccountName       (Const Value: String    );
        Procedure SetDEpositLineName   (Const Value: String    );
        Procedure SetAmount            (Const Value: Double    );
        Procedure SetNotes             (Const Value: String    );
        Procedure SetCustomer          (Const Value: Boolean   );
        Procedure SetSupplier          (Const Value: Boolean   );
        Procedure SetEmployee          (Const Value: Boolean   );
        Procedure SetContact           (Const Value: Boolean   );
        Procedure SetDeposited         (Const Value: Boolean   );
        Procedure SetDeleted           (Const Value: Boolean   );
        Procedure SetStatementNo       (Const Value: Integer   );
        Procedure SetFromDeposited     (Const Value: Boolean   );
        Procedure SetReconciled        (Const Value: Boolean   );
        Procedure SetTransID           (Const Value: String    );
        procedure setTransPaymentID(const Value: Integer);
    Protected
        Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);Override;
        Procedure DoFieldOnChange(Sender: TField);                        Override;
        Function  GetSQL: String;                                         Override;
        Function  DoBeforePost(Sender :TDatasetBusObj ):Boolean;            override;
        Function  DoAfterPost  (Sender: TDatasetBusObj): Boolean;         Override;
        Function  DoAfterInsert(Sender: TDatasetBusObj): Boolean;         Override;
        Function  DoBeforeDelete(Sender :TDatasetBusObj ):Boolean; override;

    Public
        Class Function  GetIDField: String;                               Override;
        Class Function GetBusObjectTablename: String;                     Override;
        Constructor  Create(AOwner: TComponent);                          Override;
        Destructor   Destroy;                                             Override;
        Procedure    LoadFromXMLNode(Const node: IXMLNode);               Override;
        Procedure    SaveToXMLNode(Const node: IXMLNode);                 Override;
        Function     ValidateData : Boolean ;                             Override;
        Function     Save         : Boolean ;                             Override;
        Function     Isemptyrecord: boolean;
        Property     Header       : TBankDeposit Read getHeader;
        Property     Account      : TAccount     Read getAccount;
        Property     client       : TClient      Read getclient;
        Property     Transtype    : String       Read getTranstype;

    Published
        Property DepositID        : Integer      Read GetDepositID        Write SetDepositID     ;
        Property PaymentID        : Integer      Read GetPaymentID        Write SetPaymentID     ;
        Property TransPaymentID   : Integer      Read getTransPaymentID   Write setTransPaymentID;
        Property TrnsType         : String       Read GetTrnsType         Write SetTrnsType      ;
        Property CusID            : Integer      Read GetCusID            Write SetCusID         ;
        Property PayMethodID      : Integer      Read GetPayMethodID      Write SetPayMethodID   ;
        Property PaymentMethod    : String       Read GetPaymentMethod    Write SetPaymentMethod ;
        Property PaymentDate      : TDateTime    Read GetPaymentDate      Write SetPaymentDate   ;
        Property CompanyName      : String       Read GetCompanyName      Write SetCompanyName   ;
        Property ReferenceNo      : String       Read GetReferenceNo      Write SetReferenceNo   ;
        Property ClassID          : Integer      Read GetClassID          Write setClassID       ;
        Property TransClassName   : String       Read GetTransClassName   Write SetTransClassName;
        Property AccountID        : Integer      Read GetAccountID        Write SetAccountID     ;
        Property AccountName      : String       Read GetAccountName      Write SetAccountName   ;
        Property LineName         : String       Read GetName             Write SetDEpositLineName;
        Property Amount           : Double       Read GetAmount           Write SetAmount        ;
        Property Notes            : String       Read GetNotes            Write SetNotes         ;
        Property Customer         : Boolean      Read GetCustomer         Write SetCustomer      ;
        Property Supplier         : Boolean      Read GetSupplier         Write SetSupplier      ;
        Property Employee         : Boolean      Read GetEmployee         Write SetEmployee      ;
        Property Contact          : Boolean      Read GetContact          Write SetContact       ;
        Property Deposited        : Boolean      Read GetDeposited        Write SetDeposited     ;
        Property Deleted          : Boolean      Read GetDeleted          Write SetDeleted       ;
        Property StatementNo      : Integer      Read GetStatementNo      Write SetStatementNo   ;
        Property FromDeposited    : Boolean      Read GetFromDeposited    Write SetFromDeposited ;
        Property Reconciled       : Boolean      Read GetReconciled       Write SetReconciled    ;
        Property TransID          : String       Read GetTransID          Write SetTransID       ;
    end;

    TBankDeposit = Class(TMSBusObj)
    Private
        AlllinesValid                       : Boolean;
        fsLockMsg                           : String;
        fdTotalAmount                       : Double;
        fdBankDepositTotal                  : double;
        fsGuiTableName                      : String;
        fsGuiTableNameDet                   : String;
        fbGroupCashSales                    : Boolean;
        fbIsDepositEntry                    : boolean;
        fbIsTobeDeposited                   : boolean;
        fsPayMethod                         : String;
        fProgressbar                        : TAdvProgress;
        guiBankDepositAssigned              : boolean;
        fiListforDepartmentID: Integer;

        Function GetDepositDate             : TDateTime ;
        Function GetEmployeeID              : Integer   ;
        Function GetClassID                 : Integer   ;
        Function GetClassName               : String    ;
        Function GetAccountName             : String    ;
        Function GetEmployeeName            : String    ;
        Function GetAccountID               : Integer   ;
        Function GetNotes                   : String    ;
        Function GetDeposit                 : Double    ;
        Function GetDeleted                 : Boolean   ;
        Function GetReconciled              : Boolean   ;
        Function GetLines                   : TBankDepositLines;
        Function getIsDepositEntryLocked    : TTransLockType;
        Function getIsDepositLocked         : TTransLockType;
        Function GetTotalamount             : Double;
        Function GetUnDepositedTotal        : Double;
        Function GetDepositedTotal          : Double;
        Function GetUnDeposittot            : Double;
        Function GetDeposittot              : Double;
        Function getReconcilations          (Const TransLockType:TTransLockType):Boolean;
        Function getGuiBankDeposit          : TGuiBankDeposit;
        Function getCountselected           : Integer;
        Function getTransType               : String;
        Function getCountUnselected         : Integer;
        Function UndepositedEntries        : String;
        Function GetCustField1             : String;
        Function GetCustField2             : String;
        Function GetCustField3             : String;
        Function GetCustField4             : String;
        Function GetCustField5             : String;
        Function GetCustField6             : String;
        Function GetCustField7             : String;
        Function GetCustField8             : String;
        Function GetCustField9             : String;
        Function GetCustField10            : String;
        function GetTypeOfBasedOn   : String;
        function GetFrequencyValues : String;
        function GetCopyStartDate   : TDateTime;
        function GetCopyFinishDate  : TDateTime;

        Procedure ValidateLines             (Const Sender: TBusObj; var Abort: Boolean);
        Procedure CalcTotalamount           (Const Sender: Tbusobj; Var Abort :Boolean);
        Procedure CalcUnDepoitedtotal       (Const Sender: Tbusobj; Var Abort :Boolean);
        Procedure CalcDepoitedtotal         (Const Sender: Tbusobj; Var Abort :Boolean);
        Procedure CallbackUpdateAccounts     (Const Sender: Tbusobj; Var Abort :Boolean);
        Procedure CallbackLock              (Const Sender: Tbusobj; Var Abort :Boolean);
        Procedure CallbackLockTrans         (Const Sender: Tbusobj; Var Abort :Boolean);
        Procedure SetDepositflags           (Const Sender: Tbusobj; Var Abort :Boolean);
        Procedure CallBackSetDepositflags   (Const Sender: Tbusobj; Var Abort :Boolean);
        Procedure CallbackDepositLine       (Const Sender: Tbusobj; Var Abort :Boolean);
        Procedure AutoDepositLines          (Const Sender: Tbusobj; Var Abort :Boolean);
        Procedure CallbackUnDepositLine     (Const Sender: Tbusobj; Var Abort :Boolean);
        Procedure SetEmployeeID             (Const Value : Integer   );
        Procedure SetDepositDate            (Const Value : TDateTime );
        Procedure setClassID                (Const Value : Integer   );
        Procedure SetClassName              (Const Value : String    );
        Procedure SetAccountName            (Const Value : String    );
        Procedure SetEmployeeName           (Const Value : String    );
        Procedure SetAccountID              (Const Value : Integer   );
        Procedure SetNotes                  (Const Value : String    );
        Procedure SetDeposit                (Const Value : Double    );
        Procedure SetDeleted                (Const Value : Boolean   );
        Procedure SetReconciled             (Const Value : Boolean   );
        Procedure setGroupCashSales         (Const Value : Boolean   );
        Procedure SetUnDeposittot           (Const Value : Double);
        Procedure SetDeposittot             (Const Value : Double);
        Procedure UpdateAccounts;
        Procedure UpdateDepositFlags;
        Procedure SetCustField1             (Const VAlue : String);
        Procedure SetCustField2             (Const VAlue : String);
        Procedure SetCustField3             (Const VAlue : String);
        Procedure SetCustField4             (Const VAlue : String);
        Procedure SetCustField5             (Const VAlue : String);
        Procedure SetCustField6             (Const VAlue : String);
        Procedure SetCustField7             (Const VAlue : String);
        Procedure SetCustField8             (Const VAlue : String);
        Procedure SetCustField9             (Const VAlue : String);
        Procedure SetCustField10            (Const VAlue : String);
        procedure SetTypeOfBasedOn          (Const Value: String);
        procedure SetFrequencyValues        (Const Value: String);
        procedure SetCopyStartDate          (Const Value: TDateTime);
        procedure SetCopyFinishDate         (Const Value: TDateTime);

        Procedure LoadGuitable;
        procedure DeleteFlaggedLines;
        function getLinesSales: TBankDepositLinesSales;
        procedure ShowProgressbar(Progresscount: Integer);
        procedure HideProgressbar;
        procedure StepProgressbar;

    Protected
        Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);  Override;
        Procedure DoFieldOnChange(Sender: TField);                          Override;
        Function  GetSQL: String;                                           Override;
        Function  DoAfterPost(Sender: TDatasetBusObj): Boolean;             Override;
        Function  DoAfterInsert(Sender: TDatasetBusObj): Boolean;           Override;

    Public
        Class Function GetIDField: String;                                  Override;
        Class Function GetBusObjectTablename: String;                       Override;
        Constructor Create(AOwner: TComponent);                             Override;
        Destructor  Destroy;                                                Override;
        Procedure   LoadFromXMLNode(Const node: IXMLNode);                  Override;
        Procedure   SaveToXMLNode(Const node: IXMLNode);                    Override;
        Procedure   Load(const fIsReadonly:boolean =False);Override;
        Function    Lock                        : Boolean;                  Override;
        Function    ValidateData                : Boolean;                  Override;
        Function    Save                        : Boolean;                  Override;
        Function    DepositEntrySplitReconciled : boolean;
        Function    DepositEntrySplitOnHOLD     : boolean;
        Function    DepositReconciled           : Boolean;
        Function    DepositOnHOLD               : Boolean;
        Function    AutoDepositTenderAccounts   : Boolean;
        Procedure   DepositLines;
        Procedure   UnDepositLines;
        Procedure   AutoSelect;
        function    LockTransactions: boolean;
        function    LockTransaction(fsTablename :String; TransactionID:Integer;var Msg:STring): boolean;
        Procedure   ResetDepositflags;

        Property    LinesSales          : TBankDepositLinesSales read getLinesSales;
        Property    IsDepositEntryLocked: TTransLockType    Read getIsDepositEntryLocked;
        Property    IsDepositLocked     : TTransLockType    Read getIsDepositLocked;
        Property    LockMsg             : String            Read fsLockMsg          Write fsLockMsg;
        Property    Totalamount         : Double            Read gettotalamount;
        Property    UnDepositedTotal    : Double            Read getUnDepositedTotal;
        Property    DepositedTotal      : Double            Read getDepositedTotal;
        Property    BankDepositTotal    : double            Read fdBankDepositTotal Write fdBankDepositTotal;
        Property    GuiTableName        : String            Read fsGuiTableName     Write fsGuiTableName;
        Property    GuiTableNameDet     : String            Read fsGuiTableNameDet  Write fsGuiTableNameDet;
        Property    GroupCashSales      : Boolean           Read fbGroupCashSales   Write setGroupCashSales;
        Property    IsDepositEntry      : Boolean           Read fbIsDepositEntry   Write fbIsDepositEntry;
        Property    IsTobeDeposited      : Boolean           Read fbIsTobeDeposited   Write fbIsTobeDeposited;
        Property    GuiBankDeposit      : TGuiBankDeposit   Read getGuiBankDeposit;
        Property    PayMethod           : String            Read fsPayMethod        Write fsPayMethod;
        Property    Progressbar         : TAdvProgress      Read fProgressbar       Write fProgressbar;
        Property    CountUnselected     : Integer           Read getCountUnselected;
        Property    Countselected       : Integer           Read getCountselected;
        Property    Transtype           : String            Read getTransType;
        Property    ListforDepartmentID : Integer           read fiListforDepartmentID write fiListforDepartmentID;

    Published
        Property    DepositDate         : TDateTime         Read GetDepositDate     Write SetDepositDate;
        Property    EmployeeID          : Integer           Read GetEmployeeID      Write SetEmployeeID ;
        Property    ClassID             : Integer           Read GetClassID         Write setClassID    ;
        Property    DepositClassName    : String            Read GetClassName       Write SetClassName  ;
        Property    AccountName         : String            Read GetAccountName     Write SetAccountName;
        Property    EmployeeName        : String            Read GetEmployeeName    Write SetEmployeeName;
        Property    AccountID           : Integer           Read GetAccountID       Write SetAccountID  ;
        Property    Notes               : String            Read GetNotes           Write SetNotes      ;
        Property    Deposit             : Double            Read GetDeposit         Write SetDeposit    ;
        Property    Deleted             : Boolean           Read GetDeleted         Write SetDeleted    ;
        Property    Reconciled          : Boolean           Read GetReconciled      Write SetReconciled ;
        Property    UnDeposittot        : Double            Read getUnDeposittot    Write SetUnDeposittot;
        Property    Deposittot          : Double            Read getDeposittot      Write SetDeposittot;
        Property    Lines               : TBankDepositLines Read GetLines;
        Property    CustField1:  String    read GetCustField1    write SetCustField1;
        Property    CustField2:  String    read GetCustField2    write SetCustField2;
        Property    CustField3:  String    read GetCustField3    write SetCustField3;
        Property    CustField4:  String    read GetCustField4    write SetCustField4;
        Property    CustField5:  String    read GetCustField5    write SetCustField5;
        Property    CustField6:  String    read GetCustField6    write SetCustField6;
        Property    CustField7:  String    read GetCustField7    write SetCustField7;
        Property    CustField8:  String    read GetCustField8    write SetCustField8;
        Property    CustField9:  String    read GetCustField9    write SetCustField9;
        Property    CustField10: String    read GetCustField10   write SetCustField10;
        Property    TypeOfBasedOn      : String    read GetTypeOfBasedOn     write SetTypeOfBasedOn;
        Property    FrequenctyValues   : String    read GetFrequencyValues   write SetFrequencyValues;
        Property    CopyStartDate      : TDateTime read GetCopyStartDate     write SetCopyStartDate;
        Property    CopyFinishDate     : TDateTime read GetCopyFinishDate    write SetCopyFinishDate;
    end;

    TVS1BankDeposit = Class(TBankDeposit)
      Private
      Protected
        Function  DoAfterOpen(Sender :TDatasetBusObj ):Boolean; Override;
      Public
        Constructor Create(AOwner: TComponent); Override;
        Function    ValidateData: Boolean;Override;
      Published
    End;

    TVS1DepositList = Class(TBankDeposit)
      Private
      Protected
        Class Function GetIDField: String;                      Override;
        Function  DoAfterOpen(Sender :TDatasetBusObj ):Boolean; Override;
      Public
        Constructor Create(AOwner: TComponent); Override;
      Published
    End;



implementation


uses AppEnvironment, sysutils, Dialogs,controls,
  tcDataUtils, DateUtils, CommonDbLib, tcConst, CommonLib,
  ERPdbComponents, TransLockManagementObj, DNMLib, BusObjConst, UserLockBaseObj, Math, LogLib,
  DbSharedObjectsObj, BusObjEmployee;



      {TBankDepositLines}

Constructor TBankDepositLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'BankDepositLines';
  fSQL := 'SELECT * FROM tblbankdepositlines';
end;


Destructor TBankDepositLines.Destroy;
begin
  inherited;
end;


Procedure TBankDepositLines.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'DepositID');
  SetPropertyFromNode(node,'PaymentID');
  SetPropertyFromNode(node,'TrnsType');
  SetPropertyFromNode(node,'CusID');
  SetPropertyFromNode(node,'PayMethodID');
  SetPropertyFromNode(node,'PaymentMethod');
  SetPropertyFromNode(node,'PaymentDate');
  SetPropertyFromNode(node,'CompanyName');
  SetPropertyFromNode(node,'ReferenceNo');
  SetPropertyFromNode(node,'ClassID');
  SetPropertyFromNode(node,'TransClassName');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'AccountName');
  SetPropertyFromNode(node,'Name');
  SetPropertyFromNode(node,'Amount');
  SetPropertyFromNode(node,'Notes');
  SetPropertyFromNode(node,'Customer');
  SetPropertyFromNode(node,'Supplier');
  SetPropertyFromNode(node,'Employee');
  SetPropertyFromNode(node,'Contact');
  SetPropertyFromNode(node,'Deposited');
  SetPropertyFromNode(node,'Deleted');
  SetPropertyFromNode(node,'StatementNo');
  SetPropertyFromNode(node,'FromDeposited');
  SetPropertyFromNode(node,'Reconciled');
  SetPropertyFromNode(node,'TransID');
end;


Procedure TBankDepositLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DepositID'       ,DepositID);
  AddXMLNode(node,'PaymentID'       ,PaymentID);
  AddXMLNode(node,'TrnsType'        ,TrnsType);
  AddXMLNode(node,'CusID'           ,CusID);
  AddXMLNode(node,'PayMethodID'     ,PayMethodID);
  AddXMLNode(node,'PaymentMethod'   ,PaymentMethod);
  AddXMLNode(node,'PaymentDate'     ,PaymentDate);
  AddXMLNode(node,'CompanyName'     ,CompanyName);
  AddXMLNode(node,'ReferenceNo'     ,ReferenceNo);
  AddXMLNode(node,'ClassID'         ,ClassID);
  AddXMLNode(node,'TransClassName'  ,TransClassName);
  AddXMLNode(node,'AccountID'       ,AccountID);
  AddXMLNode(node,'AccountName'     ,AccountName);
  AddXMLNode(node,'AccountType'     ,Account.AccountTypeName);
  AddXMLNode(node,'Name'            ,LineName);
  AddXMLNode(node,'Amount'          ,Amount);
  AddXMLNode(node,'Notes'           ,Notes);
  AddXMLNode(node,'Customer'        ,Customer);
  AddXMLNode(node,'Supplier'        ,Supplier);
  AddXMLNode(node,'Employee'        ,Employee);
  AddXMLNode(node,'Contact'         ,Contact);
  AddXMLNode(node,'Deposited'       ,Deposited);
  AddXMLNode(node,'Deleted'         ,Deleted);
  AddXMLNode(node,'StatementNo'     ,StatementNo);
  AddXMLNode(node,'FromDeposited'   ,FromDeposited);
  AddXMLNode(node,'Reconciled'      ,Reconciled);
  AddXMLNode(node,'TransID'         ,TransID);
end;


Function TBankDepositLines.ValidateData: Boolean ;
begin
    Result := False;
    if (AccountName = '') or (AccountId = 0) then begin
        AddResult(False, rssError , 0, 'Accountname should not be blank' );
        Exit;
    end;
    if (Account.AccountTypeName = 'AP') or (Account.AccountTypeName = 'AR') then
        if CusID = 0 then begin
            AddResult(False, rssError , 0, 'Customer should not be blank' );
            Exit;
        end;
    if (Account.AccountTypeName = 'AP') and (not (client.Supplier))  then begin
        AddResult(False, rssError , 0, AccountName + ' requires supplier');
        Exit;
    end;
    if (Account.AccountTypeName = 'AR') and (not (client.Customer))  then begin
        AddResult(False, rssError , 0, AccountName + ' requires customer');
        Exit;
    end;
//    if (Account.AccountTypeName = ACCOUNT_TYPE_BANK) then begin
//        AddResult(False, rssError , 0, 'Can not select a Bank type account ('+AccountName+') on a Bank Deposit Line');
//        Exit;
//    end;

    if ClassId  = 0  then ClassId  := AppEnv.DefaultClass.ClassID;
    if TrnsType = '' then TrnsType := Transtype;
    PostDB;

    Result := True;
end;

Function TBankDepositLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

Procedure TBankDepositLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

Procedure TBankDepositLines.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.fieldName,'ClassID') then begin
        if TransClassName = '' then TransClassName := tcDatautils.GetClassName(ClassID);
    end else if Sysutils.SameText(Sender.FieldName , 'TransClassName') then begin
        ClassId := tcDataUtils.GetDeptID(TransClassName);
        DoFieldOnChange(Dataset.FindField('ClassID'));
    end else if Sysutils.SameText(Sender.Fieldname , 'AccountID') then begin
        if AccountName = '' then Account.AccountName;
        If assigned(Self.Owner) and (Self.Owner is TBankDeposit) And (TBankDeposit(Self.Owner).IsDepositEntry) then
          FromDeposited := true;
    end else if Sysutils.SameText(sender.FieldName , 'AccountName') then begin
        AccountID := tcDatautils.GetAccountID(Accountname);
        DoFieldOnChange(Dataset.FindField('AccountID'));
    end else if Sysutils.SameText(Sender.FieldName , 'CusID') then begin
        Customer := client.Customer;
        Supplier := Client.Supplier;
        Contact := client.OtherContact;
    end else if Sysutils.SameText(Sender.fieldname , 'PaymentMethod') then begin
        PayMethodID := tcDataUtils.GetPaymentMethod(PaymentMethod);
        DoFieldOnChange(Dataset.FindField('PayMethodID'));
    end else if Sysutils.SameText(Sender.FieldName , 'PayMethodID') then begin
        if PaymentMethod = '' then PaymentMethod := tcDataUtils.GetPaymentMethod(PayMethodID);
        PostDB;
    end else if Sysutils.SameText(Sender.fieldname , 'Companyname') then begin
      With TClient.Create(Self) do try
        Connection := self.connection;
        Loadselect('Company =' + Quotedstr(Self.Companyname));
        if count >0 then begin
          Self.CusId := id;
          Self.customer := IsCustomer;
          Self.Supplier := IsSupplier;
        end;
      finally
        Free;
      end;
    end;
end;

Function TBankDepositLines.GetSQL: String;
begin
  Result := inherited GetSQL;
end;

Class Function TBankDepositLines.GetIDField: String;
begin
  Result := 'DepositLineID'
end;

Class Function TBankDepositLines.GetBusObjectTablename: String;
begin
  Result := 'tblbankdepositlines';
end;
Function  TBankDepositLines.Isemptyrecord         : boolean;
begin
    Result := (PaymentID = 0) and (PayMethodID = 0) and
              (CusID     = 0) and (AccountID   = 0) and
              (Amount    = 0);
end;

Function  TBankDepositLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
    Result := inherited  DoAfterInsert(Sender);
    if not Result then Exit;
    if Assigned(Self.Owner) then
        if Self.Owner is TBankDeposit then
            DepositId :=TBankDeposit(Self.Owner).ID;
    ClassId := AppEnv.DefaultClass.ClassID;
    TrnsType := Transtype;//'Deposit Entry';
    Deleted := False;
end;

function TBankDepositLines.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited  DoAfterInsert(Sender);
  if not result then exit;
  if {(not DatasetPosting) and} (not deleted) and (Isemptyrecord) then
    Deleted := True;
end;

Function TBankDepositLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
    Result := inherited DoAfterPost(Sender);
end;

Function TBankDepositLines.GetHeader            : TBankDeposit;
begin
    Result := nil;
    if Assigned(Self.Owner) then
        if Self.Owner is TBankDeposit then
            Result := TBankDeposit(self.Owner);
end;
Function TBankDepositLines.getAccount: TAccount;
begin
    Result := TAccount(getcontainercomponent(TAccount , 'AccountID = ' + IntToStr(AccountID) , False , False ,true));
end;
Function TBankDepositLines.getClient: TClient;
begin
    Result := TClient(getcontainercomponent(TClient , 'ClientID = ' + IntToStr(CusID) , False , False ,true));
end;
Function  TBankDepositLines.getTranstype:String;
begin
    Result := 'Deposit Entry';
    if Assigned(self.Owner) then
        if Self.Owner is TBankDeposit then
            Result :=TBankDeposit(Self.Owner).TransType;
end;
{Property Functions}
Function  TBankDepositLines.GetDepositID     : Integer   ; begin Result := GetIntegerField('DepositID');end;
Function  TBankDepositLines.GetPaymentID     : Integer   ; begin Result := GetIntegerField('PaymentID');end;
Function  TBankDepositLines.GetTrnsType      : String    ; begin Result := GetStringField('TrnsType');end;
Function  TBankDepositLines.GetCusID         : Integer   ; begin Result := GetIntegerField('CusID');end;
Function  TBankDepositLines.GetPayMethodID   : Integer   ; begin Result := GetIntegerField('PayMethodID');end;
Function  TBankDepositLines.GetPaymentMethod : String    ; begin Result := GetStringField('PaymentMethod');end;
Function  TBankDepositLines.GetPaymentDate   : TDateTime ; begin Result := GeTDateTimeField('PaymentDate');end;
Function  TBankDepositLines.GetCompanyName   : String    ; begin Result := GetStringField('CompanyName');end;
Function  TBankDepositLines.GetReferenceNo   : String    ; begin Result := GetStringField('ReferenceNo');end;
Function  TBankDepositLines.GetClassID       : Integer   ; begin Result := GetIntegerField('ClassID');end;
Function  TBankDepositLines.GetTransClassName: String    ; begin Result := GetStringField('TransClassName');end;
Function  TBankDepositLines.GetAccountID     : Integer   ; begin Result := GetIntegerField('AccountID');end;
Function  TBankDepositLines.GetAccountName   : String    ; begin Result := GetStringField('AccountName');end;
Function  TBankDepositLines.GetName          : String    ; begin Result := GetStringField('Name');end;
Function  TBankDepositLines.GetAmount        : Double    ; begin Result := GetFloatField('Amount');end;
Function  TBankDepositLines.GetNotes         : String    ; begin Result := GetStringField('Notes');end;
Function  TBankDepositLines.GetCustomer      : Boolean   ; begin Result := GetBooleanField('Customer');end;
Function  TBankDepositLines.GetSupplier      : Boolean   ; begin Result := GetBooleanField('Supplier');end;
Function  TBankDepositLines.GetEmployee      : Boolean   ; begin Result := GetBooleanField('Employee');end;
Function  TBankDepositLines.GetContact       : Boolean   ; begin Result := GetBooleanField('Contact');end;
Function  TBankDepositLines.GetDeposited     : Boolean   ; begin Result := GetBooleanField('Deposited');end;
Function  TBankDepositLines.GetDeleted       : Boolean   ; begin Result := GetBooleanField('Deleted');end;
Function  TBankDepositLines.GetStatementNo   : Integer   ; begin Result := GetIntegerField('StatementNo');end;
Function  TBankDepositLines.GetFromDeposited : Boolean   ; begin Result := GetBooleanField('FromDeposited');end;
Function  TBankDepositLines.GetReconciled    : Boolean   ; begin Result := GetBooleanField('Reconciled');end;
Function  TBankDepositLines.GetTransID       : String    ; begin Result := GetStringField('TransID');end;
Procedure TBankDepositLines.SetDepositID     (Const Value: Integer   ); begin SetIntegerField('DepositID'      , Value);end;
Procedure TBankDepositLines.SetPaymentID     (Const Value: Integer   ); begin SetIntegerField('PaymentID'      , Value);end;
Procedure TBankDepositLines.SetTrnsType      (Const Value: String    ); begin SetStringField('TrnsType'       , Value);end;
Procedure TBankDepositLines.SetCusID         (Const Value: Integer   ); begin SetIntegerField('CusID'          , Value);end;
Procedure TBankDepositLines.SetPayMethodID   (Const Value: Integer   ); begin SetIntegerField('PayMethodID'    , Value);end;
Procedure TBankDepositLines.SetPaymentMethod (Const Value: String    ); begin SetStringField('PaymentMethod'    , Value);end;
Procedure TBankDepositLines.SetPaymentDate   (Const Value: TDateTime ); begin SeTDateTimeField('PaymentDate'    , Value);end;
Procedure TBankDepositLines.SetCompanyName   (Const Value: String    ); begin SetStringField('CompanyName'    , Value);end;
Procedure TBankDepositLines.SetReferenceNo   (Const Value: String    ); begin SetStringField('ReferenceNo'    , Value);end;
Procedure TBankDepositLines.setClassID       (Const Value: Integer   ); begin SetIntegerField('ClassID'        , Value);end;
Procedure TBankDepositLines.SetTransClassName(Const Value: String    ); begin SetStringField('TransClassName'  , Value);end;
Procedure TBankDepositLines.SetAccountID     (Const Value: Integer   ); begin SetIntegerField('AccountID'      , Value);end;
Procedure TBankDepositLines.SetAccountName   (Const Value: String    ); begin SetStringField('AccountName'    , Value);end;
Procedure TBankDepositLines.SetDEpositLineName(Const Value: String    ); begin SetStringField('Name'           , Value);end;
Procedure TBankDepositLines.SetAmount        (Const Value: Double    ); begin SetFloatField('Amount'         , Value);end;
Procedure TBankDepositLines.SetNotes         (Const Value: String    ); begin SetStringField('Notes'          , Value);end;
Procedure TBankDepositLines.SetCustomer      (Const Value: Boolean   ); begin SetBooleanField('Customer'       , Value);end;
Procedure TBankDepositLines.SetSupplier      (Const Value: Boolean   ); begin SetBooleanField('Supplier'       , Value);end;
Procedure TBankDepositLines.SetEmployee      (Const Value: Boolean   ); begin SetBooleanField('Employee'       , Value);end;
Procedure TBankDepositLines.SetContact       (Const Value: Boolean   ); begin SetBooleanField('Contact'        , Value);end;
Procedure TBankDepositLines.SetDeposited     (Const Value: Boolean   ); begin SetBooleanField('Deposited'      , Value);end;
Procedure TBankDepositLines.SetDeleted       (Const Value: Boolean   ); begin SetBooleanField('Deleted'      , Value);end;
Procedure TBankDepositLines.SetStatementNo   (Const Value: Integer   ); begin SetIntegerField('StatementNo'    , Value);end;
Procedure TBankDepositLines.SetFromDeposited (Const Value: Boolean   ); begin SetBooleanField('FromDeposited'    , Value);end;
Procedure TBankDepositLines.SetReconciled    (Const Value: Boolean   ); begin SetBooleanField('Reconciled'     , Value);end;
Procedure TBankDepositLines.SetTransID       (Const Value: String    ); begin SetStringField('TransID'        , Value);end;

function TBankDepositLines.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited  DoBeforeDelete(Sender);
end;

function TBankDepositLines.getTransPaymentID: Integer;
begin
  REsult := getIntegerField('TransPaymentID');
end;

procedure TBankDepositLines.setTransPaymentID(const Value: Integer);
begin
  SetIntegerField('TransPaymentID', Value)
end;

{TBankDeposit}

Constructor TBankDeposit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'BankDeposit';
  fSQL := 'SELECT Header.* FROM tblbankdeposit AS Header ' +
          'INNER JOIN tblbankdepositLines AS Details ON Header.depositId = Details.DepositId';
  fbGroupCashSales := False;
  IsDepositEntry := False;
  IsTobeDeposited := False;
  fProgressbar := nil;
  guiBankDepositAssigned := False;
  fiListforDepartmentID := -1;
end;

Destructor TBankDeposit.Destroy;
begin
  guiBankDepositAssigned := False;
  inherited;
end;

Procedure TBankDeposit.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'DepositDate');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'ClassID');
  SetPropertyFromNode(node,'ClassName');
  SetPropertyFromNode(node,'AccountName');
  SetPropertyFromNode(node,'EmployeeName');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'Notes');
  SetPropertyFromNode(node,'Deposit');
  SetPropertyFromNode(node,'Deleted');
  SetPropertyFromNode(node,'Reconciled');
end;

Procedure TBankDeposit.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DepositDate' ,DepositDate);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'ClassID' ,ClassID);
  AddXMLNode(node,'ClassName' ,DepositClassName);
  AddXMLNode(node,'AccountName' ,AccountName);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'Notes' ,Notes);
  AddXMLNode(node,'Deposit' ,Deposit);
  AddXMLNode(node,'Deleted' ,Deleted);
  AddXMLNode(node,'Reconciled' ,Reconciled);
end;

Procedure TBankDeposit.ValidateLines     (Const Sender: TBusObj; var Abort: Boolean);
begin
  if not TBankDepositLines(Sender).ValidateData then AllLinesValid := False;
end;

Function TBankDeposit.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;

  PostDB;
  if not IsDepositEntry then GuiBankDeposit.PostDB;

  if IsDepositEntry then begin
      if BankDepositTotal <> totalamount then begin
        if (Lines.Count > 1) or (not Lines.Isemptyrecord) then begin
          if (not (assigned(ConfirmFromGUI))) or
                  (fConfirmFromGUI('Total Deposit does not equal Total Deposited !' + chr(13) +chr(13) +
                          'Do You Wish To Update Total ?' , [mbYes,MbNO]) = mrno) then begin
              Exit;
           end;
        end;
      end;
  end else begin
      if DepositedTotal = 0 then
          if Countselected = 0 then begin
              Resultstatus.AddItem(False, rssWarning, 0, 'Deposited amount 0, deposit record cannot be saved.');
              Exit;
          end;
      if not Math.SameValue(DepositedTotal,Deposit,0.0000001) then begin
          Resultstatus.AddItem(False, rssWarning, 0, 'Deposit Total Does Not Equal Total Deposited.');
          Exit;
      end;
      if AccountID = 0 then begin
          Resultstatus.AddItem(False, rssWarning, 0, 'Account Name cannot be blank.');
          Exit;
      end;
  end;
  if AppEnv.CompanyPrefs.ClosingDate >= DepositDate then begin
      Resultstatus.AddItem(True, rssWarning , 0, 'Deposit date Must Be Bigger Than Closing Date.');
      DepositDate := IncDay(AppEnv.CompanyPrefs.ClosingDate,1);
  End;
  allLinesValid := True;
  Lines.PostDb;
  Lines.IterateRecords(ValidateLines);
  if deleted then AllLinesValid:= True; // ignore the line validations if deleted. This is to enable deleting invalid bank deposits of Electonauts - they have deposit entries with blank account ids
  Result := AllLinesValid;
  if IsDepositEntry then Deposit := Totalamount;
end;

Procedure TBankDeposit.ResetDepositflags;
var
  strSQL :String;
begin
  {cash sale and refund}
  ShowProgressbar(2);
  try
    {deposits}
    strSQL := 'SELECT PaymentID FROM tbldeposits WHERE DepositID = ' + IntToStr(ID);
    with getNewDataset(strSQL , TRue) do try
        StepProgressbar;
        if recordcount > 0 then begin
            first;
            While eof = False do begin
                strSQL :='update tbldeposits  ' +
                         ' Set DEpositId = 0, Deposited= "F"  ' +
                         ' where PaymentID = ' + IntToStr(FieldByname('PaymentID').asInteger)+';'+NL;
                PostList.AddQuery(strSQL , FieldByname('PaymentID').asInteger , 'tbldeposits'  );
                Next;
            end;
        end;
    finally
      if Active then Close;
      Free;
    end;
    {prepayments}
    strSQL := 'SELET PrePaymentID FROM tblPrePayments WHERE DepositID = ' + IntToStr(ID);
    with getNewDataset(strSQL , TRue) do try
        StepProgressbar;
        if recordcount > 0 then begin
            first;
            While eof = False do begin
                strSQL :='UPDATE tblPrePayments   ' +
                         ' SET DEpositId = 0, Deposited= "F"  ' +
                         ' WHERE PrePaymentID = ' + IntToStr(FieldByname('PrePaymentID').asInteger)+';'+NL;
                PostList.AddQuery(strSQL , FieldByname('PrePaymentID').asInteger , 'tblPrePayments'  );
                Next;
            end;
        end;
    finally
      if Active then Close;
      Free;
    end;
  Finally
      HideProgressbar;
  end;
end;

Procedure TBankDeposit.SetDepositflags(Const Sender: Tbusobj; Var Abort :Boolean);
begin
    StepProgressbar;
    if not (sender is  TGuiBankDeposit) then Exit;
    if not TGuiBankDeposit(Sender).Deposited then Exit;

    Lines.New;
    Lines.Deposited	      := True;
    Lines.DepositID       := Self.ID;
    Lines.TrnsType	      := TGuiBankDeposit(Sender).TrnType;
    Lines.PaymentDate     := TGuiBankDeposit(Sender).PaidDate;
    Lines.CompanyName     := TGuiBankDeposit(Sender).CompanyName;
    Lines.Amount	        := TGuiBankDeposit(Sender).Amount;
    if Sysutils.SameText(TGuiBankDeposit(Sender).CompanyName , 'Grouped Clients') then
         Lines.PaymentID  := Self.ID
    else Lines.PaymentID  := TGuiBankDeposit(Sender).TransactionID;
    Lines.TransPaymentID  := TGuiBankDeposit(Sender).PaymentId;
    Lines.AccountName	    := TGuiBankDeposit(Sender).AccountName;
    Lines.TransClassName  := TGuiBankDeposit(Sender).DeptClassName;
    Lines.ReferenceNo	    := TGuiBankDeposit(Sender).ChequeNo;
    Lines.PaymentMethod	  := TGuiBankDeposit(Sender).PaymentMethod;
    Lines.TransID	        := IntToStr(TGuiBankDeposit(Sender).TransID);
    Lines.CusID	          := TGuiBankDeposit(Sender).ClientID;
    Lines.PayMethodID	    := TGuiBankDeposit(Sender).PayMethodID;
    Lines.AccountID	      := TGuiBankDeposit(Sender).AccountID;
    Lines.FromDeposited   := True;
    Lines.ClassId         := ClassID;
    Lines.PostDb;
    (*if (TGuiBankDeposit(Sender).TrnType <> 'Cash Sale')  then*)
      TGuiBankDeposit(Sender).LinkedTrans.Iteraterecords(CallBackSetDepositflags);
end;

Procedure TBankDeposit.CallBackSetDepositflags(Const Sender: Tbusobj; Var Abort :Boolean);
var
  strSQL:String;
begin

  if not Sysutils.SameText(TGuiBankDepositdet(Sender).TransTablename,'tblsalespayments') then begin
    if not (Sender is   TGuiBankDepositdet) then exit;
    strSQL := 'UPDATE ' + TGuiBankDepositdet(Sender).TransTablename +
              ' SET DepositId = ' + IntToStr(ID) + ' ,' +
              ' Deposited ="T" ' ;
    if Sysutils.SameText(TGuiBankDepositdet(Sender).TransTablename , 'tblPrePayments')      then begin
        strSQL  := strSQL + ' WHERE PrePaymentID=' + IntToStr(TGuiBankDepositdet(Sender).TRansactionID) +
                            ' AND Paymethodid   =' + IntToStr(TGuiBankDepositdet(Sender).PayMethodID);
    end else if Sysutils.SameText(TGuiBankDepositdet(Sender).TransTablename,'tbldeposits')      then begin
        strSQL  := strSQL + ' WHERE PaymentID   =' + IntToStr(TGuiBankDepositdet(Sender).TRansactionID)+
                            ' AND Paymethodid   =' + IntToStr(TGuiBankDepositdet(Sender).PayMethodID);
    end else if Sysutils.SameText(TGuiBankDepositdet(Sender).TransTablename,'tblsalespayments') then begin
        strSQL  := strSQL + ' WHERE SaleID      =' + IntToStr(TGuiBankDepositdet(Sender).TRansactionID)+
                            ' AND Paymethod     =' + QuotedStr(TGuiBankDepositdet(Sender).PaymentMethod)+
                            ' AND Amount        =' + floatToStr(TGuiBankDepositdet(Sender).Amount);
    end;
    PostList.AddQuery(strSQL , TGuiBankDepositdet(Sender).TransactionID , TGuiBankDepositdet(Sender).TransTablename);
  end else begin
    LinesSales.New;
    LinesSales.bankdepositlinesID := Lines.Id;
    LinesSales.TransID            := TGuiBankDepositdet(Sender).TransID;
    LinesSales.PaymentMethod      := TGuiBankDepositdet(Sender).PaymentMethod;
    LinesSales.PaymentID          := TGuiBankDepositdet(Sender).PaymentId;
    LinesSales.amount             := TGuiBankDepositdet(Sender).Amount;
    LinesSales.PostDB;
  end;
end;

Procedure TBankDeposit.CallbackUpdateAccounts(Const Sender: Tbusobj; Var Abort :Boolean);
var
    cleanclientID:Integer;
    cleanamount :double;
    CleanNode       : IXMLNode;
    cleanAccountId  : Integer;
    CleanAccounttype: String;
begin
    if not (Sender is TBankdepositLines) then Exit;
    CleanNode:= TBankdepositLines(Sender).CleanXMLNode;
    if assigned(CleanNode) then begin
        Cleanamount       := GetXMLNodefloatValue(CleanNode,'amount');
        cleanclientID     := GetXMLNodeIntegerValue(CleanNode,'CusID');
        cleanAccountId    := GetXMLNodeIntegerValue(CleanNode,'AccountID');
        CleanAccounttype  := GetXMLNodeStringValue(CleanNode,'AccountType');
        PostList.AddAmount('ChartOfAccounts', 'tblChartOfAccounts' ,CleanAccountID, Cleanamount, btNormal,false);
        if (cleanclientID <> 0) and ((CleanAccounttype = 'AR') or (CleanAccounttype = 'AP')) then
            PostList.AddAmount('Client', 'tblClients' ,CleanclientID, Cleanamount, btNormal,false);
    end;

    if (Deleted) or (TBankdepositLines(Sender).Deleted) then Exit;

    if (TBankdepositLines(Sender).cusID <> 0) and
        ((TBankdepositLines(Sender).Account.AccountTypeName = 'AR') or
         (TBankdepositLines(Sender).Account.AccountTypeName = 'AP')) then
        PostList.AddAmount('Client',      'tblClients' ,        TBankdepositLines(Sender).cusID,    -TBankdepositLines(Sender).Amount, btNormal,false);
    PostList.AddAmount('ChartOfAccounts', 'tblChartOfAccounts' ,TBankdepositLines(Sender).AccountID,-TBankdepositLines(Sender).Amount, btNormal,false);
end;

Function TBankDeposit.Save: Boolean ;
begin

    PostDB;
    if not IsDepositEntry then GuiBankDeposit.PostDB;
    if not dirty then begin
        Result := True;
        Exit;
    end;
    Result      := False;
    if not ValidateData then Exit;
    PostList.Clear;
    if IsTobeDeposited then begin
        UpdateDepositFlags;
    end;
    UpdateAccounts;

    Result      := inherited Save;
    if not PostList.Execute then begin
        Result  := False;
        Exit;
    end;
    DeleteFlaggedLines;
    Dirty := False;
end;

procedure TBankDeposit.DeleteFlaggedLines;
var
    IsFiltered: boolean;
begin
    Lines.Dataset.DisableControls;
    IsFiltered := Lines.Dataset.Filtered;
    Lines.Dataset.Filtered := false;
    if Lines.Count > 0 then begin
        Lines.First;
        while not Lines.Dataset.Eof do
            if Lines.Deleted then Lines.Delete
            else Lines.Dataset.Next;
        Lines.Dataset.Filtered := IsFiltered;
    end;
    Lines.Dataset.EnableControls;
end;

Procedure TBankDeposit.UpdateAccounts;
var
  Cleanamount     : Double;
  cleanAccountId  : Integer;
  CleanNode       : IXMLNode;
begin
  CleanNode:= CleanXMLNode;
  if assigned(CleanNode) then begin
      Cleanamount       := GetXMLNodefloatValue(CleanNode,'Deposit');
      cleanAccountId    := GetXMLNodeIntegerValue(CleanNode,'AccountID');
      if cleanAccountId <> 0 then
        PostList.AddAmount('ChartOfAccounts', 'tblChartOfAccounts' ,CleanAccountID, -Cleanamount, btNormal,false);
  end;
  if not deleted then
      PostList.AddAmount('ChartOfAccounts', 'tblChartOfAccounts' ,AccountId, Deposit, btNormal,false);

  Lines.IterateREcords(CallbackUpdateAccounts,True);
end;

Procedure TBankDeposit.UpdateDepositFlags;
begin
  if Deleted then
      ResetDepositflags
  else if IsNew then begin
    ShowProgressbar(GuiBankDeposit.count);
    try
      GuiBankDeposit.IterateRecords(SetDepositflags);
    Finally
      HideProgressbar;
    end;
  end;
end;

Procedure TBankDeposit.Load(const fIsReadonly:boolean =False);
begin
  inherited Load(fIsReadonly);
end;

Function TBankDeposit.Lock : Boolean ;
begin
    Result := False;
    LockMsg := '';
    if DepositOnHOLD then
      LockMsg := LockMsgReconcileHold
    else if DepositReconciled   then
      LockMsg := LockMsgReconciled
    else if DepositDate <= AppEnv.CompanyPrefs.ClosingDate then
      LockMsg := LockMsgClosingDate
    else if Deleted then
      LockMsg := LockMsgDeletedBankDeposit
    else
      Result := inherited lock;

    if Result then
      REsult := LockTransactions;
end;

function TBankDeposit.LockTransactions:boolean;
begin
    AlllinesValid := true;
    if not isdepositEntry then GuiBankDeposit.Iteraterecords(CallbackLock);
    Result := AlllinesValid ;
end;


Procedure TBankDeposit.CallbackLock(Const Sender: Tbusobj; Var Abort :Boolean);
begin
    if not (Sender is TGuiBankDeposit) then exit;
    TGuiBankDeposit(Sender).LinkedTrans.Iteraterecords(CallbackLockTrans);
    if not AlllinesValid then abort := True;
end;
Procedure TBankDeposit.CallbackLockTrans(Const Sender: Tbusobj; Var Abort :Boolean);
var
  fsTable:String;
  msg:String;
begin
    if not (Sender is TGuiBankDepositdet) then exit;
    fsTable :=TGuiBankDepositdet(Sender).TransTablename;
    if sameText(fstable, 'tblsalespayments') then fsTable := 'tblSales';
    (*if not Userlock.Lock(fstable, TGuiBankDepositdet(Sender).TransactionID) then begin*)
    if not(LockTransaction(fstable ,TGuiBankDepositdet(Sender).TransactionID, msg)) then begin
        ResultStatus.AddItem(False,rssWarning,0,ReplaceStr(msg, 'this record' , TGuiBankDepositdet(Sender).TrnType + '#' +
            IntToStr(TGuiBankDepositdet(Sender).TransactionID)));
        AlllinesValid := False;
        abort := True;
    end;
end;

Function TBankDeposit.getReconcilations(Const TransLockType:TTransLockType):Boolean;
Var
  LockManagement :TLockManagement;
  ResultLocked :Boolean;
  ResultTransLockType :TTransLockType;
begin
  ResultLocked := True;
  LockManagement := TLockManagement.Create;
  try
    if self.IsDepositEntry then
      ResultLocked := LockManagement.IsDepositEntryLocked(ID,ResultTransLockType)
    else if self.IsTobeDeposited then
      ResultLocked := LockManagement.IsDepositLocked(ID,ResultTransLockType);
    Result := ResultLocked and (ResultTransLockType=TransLockType);
  finally
    LockManagement.Free;
  end;
end;

Function TBankDeposit.getGuiBankDeposit      : TGuiBankDeposit;
begin
    if  GuiTableName = '' then begin
      { LoadGuitable creates new table with new name so make sure we don't have
        an istance of TGuiBankDeposit with wrong table name }
      ContainerList.Clear;
      LoadGuitable;
    end;
    Result :=TGuiBankDeposit(getcontainercomponent(TGuiBankDeposit,'',True, False ));
    if (Result.Datasetassigned=False) or (Result.Datasetactive = False) then Result.Load;
    guiBankDepositAssigned := True;
end;
Function TBankDeposit.getTransType:String;
begin
    if IsDepositEntry then result := 'Deposit Entry'
    else Result := 'Bank Deposit'
end;
Function TBankDeposit.getCountselected           : Integer;
begin
    GuiBankDeposit.postDB;
    with getnewdataset('select * from ' + GuiTableName + ' where Deposited = "T"' , true) do try
        Result := Recordcount;
    finally
        if Active then close;
        Free;
    end;
end;

Function TBankDeposit.getCountUnselected         : Integer;
begin
    GuiBankDeposit.postDB;
    with getnewdataset('select * from ' + GuiTableName + ' where Deposited = "F"' , true) do try
        Result := Recordcount;
    finally
        if Active then close;
        Free;
    end;

end;

Function TBankDeposit.DepositReconciled: boolean;
begin
    Result := getReconcilations(ltReconciled);
end;

Function TBankDeposit.DepositOnHOLD:Boolean;
begin
    Result := getReconcilations(ltOnHoldRec);
end;

Function TBankDeposit.DepositEntrySplitReconciled : boolean;
begin
    Result := getReconcilations(ltReconciled);
End;
Function TBankDeposit.DepositEntrySplitOnHOLD     : boolean;
begin
    Result := getReconcilations(ltOnHoldRec);
End;

Procedure TBankDeposit.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
    inherited;
    if ClearContainerListOnLoad then ContainerList.Clear;
    GuiTableName := ''; // to force recreating the temp table
    guiBankDepositAssigned := False;
end;

Procedure TBankDeposit.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.fieldName , 'DepositDate') then begin
        if AppEnv.CompanyPrefs.ClosingDate >= DepositDate then begin
            Resultstatus.AddItem(True, rssWarning , 0, 'Deposit date must be bigger than closing date.');
            DepositDate := IncDay(AppEnv.CompanyPrefs.ClosingDate,1);
        End;
    end else if Sysutils.SameText(Sender.fieldName, 'ClassID') then begin
        DepositClassName := tcDatautils.GetClassName(ClassId);
    end else if Sysutils.SameText(Sender.fieldName, 'ClassName') then begin
        ClassId:= tcDatautils.GetDeptID(DepositClassName);
    end;
end;

Function TBankDeposit.GetSQL: String;
begin
    Result := inherited GetSQL;
end;

Class Function TBankDeposit.GetIDField: String;
begin
  Result := 'DepositID'
end;

Class Function TBankDeposit.GetBusObjectTablename: String;
begin
  Result := 'tblbankdeposit';
end;

Function TBankDeposit.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

Function TBankDeposit.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
    Result      := inherited DoAfterInsert(Sender);
    if not Result then Exit;
    DepositDate := Date;
    Deposit     := 0;
    AccountID   := AppEnv.CompanyPrefs.DefaultDepositsAccount;
    Reconciled  := False;
    Deleted     := False;
    classID     := AppEnv.DefaultClass.ClassID;
    EmployeeID  := AppEnv.Employee.EmployeeID;

End;

Procedure TBankDeposit.LoadGuitable;
var
    DID:Integer;
    SQLList :TStringList;
    strSQL:String;
    filename:String;
    xguitablename:STring;
    xguitablenamedet:STring;
    st:TStringList;
    x: integer;
    scr :TERPScript;
begin
  SQLList :=TStringList.create;
  st:=TStringList.create;
  try
      filename:= '';
      DID := 0;
      if Lines.count > 0 then DID := ID;
      if GuiTableName = '' then
        GuiTableName := CommonDbLib.GetUserTemporaryTableName('BankDeposit');
      GuiTableNamedet := GuiTableName +'_det';
          strSql:= '';
          if not TableExists(GuiTableNamedet) then begin
             strSQL:= strSql +' CREATE TABLE ' + GuiTableNamedet + '  ('+
                     ' ID             INT(11) NOT NULL auto_increment,' +
                     ' LineID         INT(11)              default 0,' +
                     ' PaymentID      INT(11)              default 0,' +
                     ' Trntype        VARCHAR(16) NOT NULL default "",' +
                     ' PaidDate       Date                 default NULL,' +
                     ' companyName    VARCHAR(160)         default NULL,' +
                     ' Amount         double               default NULL,' +
                     ' TransactionID  INT(11)     NOT NULL default 0,' +
                     ' AccountName    VARCHAR(50)          default NULL,' +
                     ' ClassName      VARCHAR(60)         default NULL,' +
                     ' ClassID       INT(11)              default NULL,' +
                     ' ChequeNo       VARCHAR(50)          default NULL,' +
                     ' PaymentMethod  VARCHAR(255)         default NULL,' +
                     ' PaymentMethodID    INT(11)              default NULL,' +
                     ' PayMethodID    INT(11)              default NULL,' +
                     ' TransID        INT(11)     NOT NULL default 0,' +
                     ' ClientID       INT(11)              default NULL,' +
                     ' AccountID      INT(11)     NOT NULL default 0,' +
                     ' TableName      VARCHAR(16) NOT NULL default "",' +
                     ' DepositID      INT(11)              default 0,' +
                     ' Deposited      enum("T","F")        default "F",' +
                     ' PRIMARY KEY    (ID));'+NL ;
             strSQL:= strSQL+
                        ' ALTER TABLE ' + GuiTableNamedet + ' ADD INDEX `PaymentMethodidx`       ( PaymentMethod);'+NL ;
             strSQL:= strSQL+
                        ' ALTER TABLE ' + GuiTableNamedet + ' ADD INDEX `ClassNameidx`       ( ClassName);'+NL ;
                     strSQL:= strSQL+
                        ' ALTER TABLE ' + GuiTableNamedet + ' ADD INDEX `joinidx`       (`Trntype`,`PaidDate`,`ClassID`,`PaymentMethodID`);'+NL ;
          end else strSQL:= strSql+' Truncate ' + GuiTableNameDet +';'+NL ;


          if not TableExists(GuiTableName) then begin
             strSql:= strSql+' CREATE TABLE ' + GuiTableName + '  (' +
                     ' ID             INT(11) NOT NULL auto_increment,' +
                     ' LineID         INT(11)              default 0,' +
                     ' Trntype        VARCHAR(16) NOT NULL default "",' +
                     ' PaidDate       Date                 default NULL,' +
                     ' companyName    VARCHAR(160)         default NULL,' +
                     ' Amount         double               default NULL,' +
                     ' TransactionID  INT(11)     NOT NULL default 0,' +
                     ' AccountName    VARCHAR(50)          default NULL,' +
                     ' ClassName      VARCHAR(60)         default NULL,' +
                     ' ClassID       INT(11)              default NULL,' +
                     ' ChequeNo       VARCHAR(50)          default NULL,' +
                     ' PaymentMethod  VARCHAR(255)         default NULL,' +
                     ' PaymentMethodID    INT(11)              default NULL,' +
                     ' PayMethodID    INT(11)              default NULL,' +
                     ' TransID        INT(11)     NOT NULL default 0,' +
                     ' ClientID       INT(11)              default NULL,' +
                     ' AccountID      INT(11)     NOT NULL default 0,' +
                     ' TableName      VARCHAR(16) NOT NULL default "",' +
                     ' DepositID      INT(11)              default 0,' +
                     ' Deposited      enum("T","F")        default "F",' +
                     ' PRIMARY KEY    (ID));'+NL ;
             strSQL:= strSQL+
                        ' ALTER TABLE ' + GuiTableName + ' ADD INDEX `PaymentMethodidx`       ( PaymentMethod);'+NL ;
             strSQL:= strSQL+
                        ' ALTER TABLE ' + GuiTableName + ' ADD INDEX `ClassNameidx`       ( ClassName);'+NL ;
             strSQL:= strSQL+
                        ' ALTER TABLE ' + GuiTableName + ' ADD INDEX `joinidx`       ( `Trntype`,`PaidDate`,`ClassID`,`PaymentMethodID`);'+NL ;
          End else  strSql := strSql +' Truncate ' + GuiTableName +';'+NL ;
          SQLList.add(strSQL);
          xguitablename:=guitablename;
          xguitablenamedet:=guitablenamedet;

          if DID > 0 then begin
              strSQL := 'SELECT Deposited, DepositID, TrnsType as Trntype, '+
                         'PaymentDate as PaidDate,CompanyName, Amount, '+
                         'PaymentID as TransactionID, AccountName, '+
                         'TransClassName as ClassName,ReferenceNo as ChequeNo, '+
                         'PaymentMethod, TransID, CusID as ClientID, PayMethodID, '+
                         'AccountID '+
                         'from tblbankdepositlines '+
                         'Where DepositId = ' + inttoStr(DID);
              strSQL:= CreateTemporaryTableusingfile('' , strsql ,
                         'Deposited, DepositID, Trntype,PaidDate,CompanyName, Amount,TransactionID, AccountName,ClassName,ChequeNo,PaymentMethod, TransID, ClientID, PayMethodID,AccountID' ,
                         xguitablename , filename)+NL;
              SQLList.add(strSQL);
              st.add(filename);
          end else begin
            strSQL:= CreateTemporaryTableusingfile('' , UnDepositedEntries ,
                         'Trntype,PaidDate,companyName,Amount,TransactionID,PaymentID,AccountName,ClassName,ChequeNo,PaymentMethod,TransID,ClientID,PayMethodID,AccountID , TableName' ,
                         xGuiTableNameDet , filename)+NL;
            SQLList.add(strSQL);
              st.add(filename);


              if GroupCashSales then begin
                  strSQL:= ' SELECT Deposited, DepositID, Trntype,PaidDate,'+
                  ' Companyname,Amount,TransactionID,'+
                  ' AccountName,ClassName,ChequeNo,PaymentMethod,TransID,'+
                  ' ClientID,PayMethodID,AccountID from  ' + GuiTableNamedet +
                  ' WHERE Trntype <>"Cash Sale" and Trntype <> "POS Cash Sale" '+
                  ' UNION'+
                  ' SELECT Deposited,0, Trntype,PaidDate,"Grouped Clients",'+
                  ' Sum(Amount),0,AccountName,ClassName,ChequeNo,'+
                  ' PaymentMethod,0,ClientID,PayMethodID,AccountID '+
                  ' FROM  ' + GuiTableNamedet +
                  ' WHERE (Trntype ="Cash Sale" or Trntype ="POS Cash Sale") '+
                  ' GROUP BY PaidDate, ClassName , PaymentMethod';
                  strSQl:= CreateTemporaryTableusingfile('' , strSQL,
                         'Deposited, DepositID, Trntype,PaidDate,Companyname,Amount,TransactionID,AccountName,ClassName,ChequeNo,PaymentMethod,TransID,ClientID,PayMethodID,AccountID',
                         xGuiTableName , filename)+NL;
                  SQLList.add(strSQL);
              st.add(filename);



                  strSQL:= ' UPDATE     ' + GuiTableNamedet + ' as T ' +
                              ' INNER JOIN tblclass as C on C.classname = T.classname set T.classid = c.classid;'+NL ;
                  SQLList.add(strSQL);
                  strSQL:= ' UPDATE     ' + GuiTableName + ' as T ' +
                              ' INNER JOIN tblclass as C on C.classname = T.classname set T.classid = c.classid;'+NL ;
                  SQLList.add(strSQL);

                  strSQL:= ' UPDATE     ' + GuiTableNamedet + ' as T ' +
                              ' INNER JOIN tblpaymentmethods as P on P.Name = T.PaymentMethod Set T.PaymentMethodId = P.PayMethodID;'+NL ;
                  SQLList.add(strSQL);
                  strSQL:= ' UPDATE     ' + GuiTableName + ' as T ' +
                              ' INNER JOIN tblpaymentmethods as P on P.Name = T.PaymentMethod Set T.PaymentMethodId = P.PayMethodID;'+NL ;
                  SQLList.add(strSQL);


                  strSQL:= ' UPDATE     ' + GuiTableNamedet + ' as det ' +
                  ' INNER JOIN ' + GuiTableName    + ' as main ' +
                  ' ON    det.Trntype      = main.Trntype ' +
                  ' AND   det.PaidDate     = main.PaidDate ' +
                  ' AND   det.Classid    = main.Classid ' +
                  ' AND   det.PaymentMethodID= main.PaymentMethodID ' +
                  ' SET   det.LineId       = main.ID' +
                  ' WHERE main.TransactionID = 0;'+NL;
                  SQLList.add(strSQL);

                  strSQL:= ' UPDATE     ' + GuiTableNamedet + ' as det ' +
                  ' INNER JOIN ' + GuiTableName    + ' as main ' +
                  ' ON    det.Trntype      = main.Trntype ' +
                  ' AND   det.PaidDate     = main.PaidDate ' +
                  ' AND   det.Classid    = main.Classid ' +
                  ' AND   det.PaymentMethodID= main.PaymentMethodID ' +
                  ' AND   det.TransactionID = main.TransactionID ' +
                  ' SET   det.LineId       = main.ID' +
                  ' WHERE main.TransactionID <> 0;'+NL;
                  SQLList.add(strSQL);

              end else begin
                  strSQL:= ' Select ' +
                  ' Deposited, DepositID, Trntype,PaidDate,CompanyName,' +
                  ' Amount,TransactionID, AccountName,ClassName,ChequeNo,' +
                  ' PaymentMethod, TransID, ClientID, PayMethodID,AccountID' +
                  ' FROM  ' + GuiTableNamedet ;
                  strSQL:= CreateTemporaryTableusingfile('' , strSQL,
                         'Deposited, DepositID, Trntype,PaidDate,CompanyName,Amount,TransactionID, AccountName,ClassName,ChequeNo,PaymentMethod, TransID, ClientID, PayMethodID,AccountID',
                         xGuiTableName , filename)+NL;
                  SQLList.add(strSQL);
                  st.add(filename);


                  strSQl:= 'UPDATE ' + GuiTableNamedet + ' set LineId = ID;'+NL;
                  SQLList.add(strSQL);
              end;
          end;
          for x:= 0 to st.Count -1 do AppEnv.UtilsClient.DeleteServerFile(st[x]);
(*          With CommonDbLib.TempMyScript do try
            SQL.add(SQLList.text);
            clog(SQL.text);
            Execute;
          finally
            free;
          end;*)

      scr := getSharedScript(SQLList.text , false); //DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
      try
        clog(scr.SQL.text);
        scr.Execute;
      finally
        DbSharedObj.ReleaseObj(scr);
      end;

  finally
    for x:= 0 to st.Count -1 do AppEnv.UtilsClient.DeleteServerFile(st[x]);
    st.Free;
    freeandNil(SQLList);
  end;
end;

(*Procedure TBankDeposit.LoadGuitable;
var
    DID:Integer;
    SQLList :TStringList;
    strSQL:String;
    Qry :TDataset;
    Firstrec:Boolean;
begin
    DID := 0;
    if Lines.count > 0 then DID := ID;
    if GuiTableName = '' then GuiTableName := CommonDbLib.GetUserTemporaryTableName('BankDeposit');
    GuiTableNamedet := GuiTableName +'_det';
    SQLList :=TStringList.create;
    try
        if not TableExists(GuiTableNamedet) then begin
            SQLList.add('CREATE TABLE ' + GuiTableNamedet + '  (');
            SQLList.add('ID             INT(11) NOT NULL auto_increment,');
            SQLList.add('LineID         INT(11)              default 0,');
            SQLList.add('PaymentID      INT(11)              default 0,');
            SQLList.add('Trntype        VARCHAR(16) NOT NULL default "",');
            SQLList.add('PaidDate       Date                 default NULL,');
            SQLList.add('companyName    VARCHAR(255)         default NULL,');
            SQLList.add('Amount         double               default NULL,');
            SQLList.add('TransactionID  INT(11)     NOT NULL default 0,');
            SQLList.add('AccountName    VARCHAR(50)          default NULL,');
            SQLList.add('ClassName      VARCHAR(255)         default NULL,');
            SQLList.add('ChequeNo       VARCHAR(50)          default NULL,');
            SQLList.add('PaymentMethod  VARCHAR(255)         default NULL,');
            SQLList.add('TransID        INT(11)     NOT NULL default 0,');
            SQLList.add('ClientID       INT(11)              default NULL,');
            SQLList.add('PayMethodID    INT(11)              default NULL,');
            SQLList.add('AccountID      INT(11)     NOT NULL default 0,');
            SQLList.add('TableName      VARCHAR(16) NOT NULL default "",');
            SQLList.add('DepositID      INT(11)              default 0,');
            SQLList.add('Deposited      enum("T","F")        default "F",');
            SQLList.add('PRIMARY KEY    (ID));');
            SQLList.add('ALTER TABLE ' + GuiTableNamedet + ' ADD INDEX `Trntypeidx`       (`Trntype`);');
            SQLList.add('ALTER TABLE ' + GuiTableNamedet + ' ADD INDEX `PaidDateidx`      (`PaidDate`);');
            SQLList.add('ALTER TABLE ' + GuiTableNamedet + ' ADD INDEX `ClassNameidx`     (`ClassName`);');
            SQLList.add('ALTER TABLE ' + GuiTableNamedet + ' ADD INDEX `PaymentMethodidx` (`PaymentMethod`);');
            SQLList.add('ALTER TABLE ' + GuiTableNamedet + ' ADD INDEX `LineIdidx`        (`LineId`);');

        end else SQLList.add('Truncate ' + GuiTableNameDet +';');


        if not TableExists(GuiTableName) then begin
            SQLList.add('CREATE TABLE ' + GuiTableName + '  (');
            SQLList.add('ID             INT(11) NOT NULL auto_increment,');
            SQLList.add('LineID         INT(11)              default 0,');
            SQLList.add('Trntype        VARCHAR(16) NOT NULL default "",');
            SQLList.add('PaidDate       Date                 default NULL,');
            SQLList.add('companyName    VARCHAR(255)         default NULL,');
            SQLList.add('Amount         double               default NULL,');
            SQLList.add('TransactionID  INT(11)     NOT NULL default 0,');
            SQLList.add('AccountName    VARCHAR(50)          default NULL,');
            SQLList.add('ClassName      VARCHAR(255)         default NULL,');
            SQLList.add('ChequeNo       VARCHAR(50)          default NULL,');
            SQLList.add('PaymentMethod  VARCHAR(255)         default NULL,');
            SQLList.add('TransID        INT(11)     NOT NULL default 0,');
            SQLList.add('ClientID       INT(11)              default NULL,');
            SQLList.add('PayMethodID    INT(11)              default NULL,');
            SQLList.add('AccountID      INT(11)     NOT NULL default 0,');
            SQLList.add('TableName      VARCHAR(16) NOT NULL default "",');
            SQLList.add('DepositID      INT(11)              default 0,');
            SQLList.add('Deposited      enum("T","F")        default "F",');
            SQLList.add('PRIMARY KEY    (ID));');
            SQLList.add('ALTER TABLE ' + GuiTableName + ' ADD INDEX `Trntypeidx`       (`Trntype`);');
            SQLList.add('ALTER TABLE ' + GuiTableName + ' ADD INDEX `PaidDateidx`      (`PaidDate`);');
            SQLList.add('ALTER TABLE ' + GuiTableName + ' ADD INDEX `ClassNameidx`     (`ClassName`);');
            SQLList.add('ALTER TABLE ' + GuiTableName + ' ADD INDEX `PaymentMethodidx` (`PaymentMethod`);');
        End else SQLList.add('Truncate ' + GuiTableName +';');


        if DID > 0 then begin
            strSQL := 'SELECT Deposited, DepositID, TrnsType as Trntype, '+
                       'PaymentDate as PaidDate,CompanyName, Amount, '+
                       'PaymentID as TransactionID, AccountName, '+
                       'TransClassName as ClassName,ReferenceNo as ChequeNo, '+
                       'PaymentMethod, TransID, CusID as ClientID, PayMethodID, '+
                       'AccountID '+
                       'from tblbankdepositlines '+
                       'Where DepositId = ' + IntToStr(DID);
            Qry := getNewDataset(strSQL , true);
            With Qry  do try
                if recordcount > 0 then begin
                    firstRec := True;
                    First;
                    SQLList.add('INSERT INTO ' + GuiTableName);
                        SQLList.add('(Deposited, DepositID, Trntype, ');
                        SQLList.Add('PaidDate,CompanyName, Amount, ');
                        SQLList.Add('TransactionID, AccountName, ');
                        SQLList.Add('ClassName,ChequeNo, ');
                        SQLList.Add('PaymentMethod, TransID, ClientID, PayMethodID, ');
                        SQLList.Add('AccountID)');
                        SQLList.Add(' Values ');
                    While EOF = False do begin
                        if not firstrec then SQLList.Add(' ,');
                        SQLList.Add(' ('+
                                  QuotedStr(FieldByname('Deposited').asString)                                    +','+
                                  IntToStr(FieldByname('DepositID').asInteger)                          +','+
                                  QuotedStr(FieldByname('Trntype').asString)                                      +','+
                                  QuotedStr(FormaTDateTime(MysqlDateFormat , FieldByname('PaidDate').asDatetime)) +','+
                                  QuotedStr(FieldByname('CompanyName').asString)                                  +','+
                                  FloatToStr(FieldByname('Amount').asFloat)                                       +','+
                                  IntToStr(FieldByname('TransactionID').asInteger)                      +','+
                                  QuotedStr(FieldByname('AccountName').asString)                                  +','+
                                  QuotedStr(FieldByname('ClassName').asString)                                    +','+
                                  QuotedStr(FieldByname('ChequeNo').asString)                                     +','+
                                  QuotedStr(FieldByname('PaymentMethod').asString)                                +','+
                                  IntToStr(FieldByname('TransID').asInteger)                            +','+
                                  IntToStr(FieldByname('ClientID').asInteger)                           +','+
                                  IntToStr(FieldByname('PayMethodID').asInteger)                        +','+
                                  IntToStr(FieldByname('AccountID').asInteger)+')');
                        FirstRec := False;
                        Next;
                    end;
                end;
                SQLList.Add(' ;');
            finally
                if active then close;
                FreeAndNil(Qry);
            end;
        end else begin
            qry := GetNewDataset(UnDepositedEntries, true);
            With Qry do try
                if recordcount > 0 then begin
                    Firstrec := True;
                    First;
                    SQLList.add('INSERT INTO ' + GuiTableNameDet);
                    SQLList.add('(Trntype,PaidDate,companyName,Amount,TransactionID,');
                    SQLList.add('AccountName,ClassName,ChequeNo,PaymentMethod,TransID,');
                    SQLList.add('ClientID,PayMethodID,AccountID,TableName, PaymentID)');
                    SQLList.add('Values ');
                    While Eof = False do begin
                        if not firstRec then SQLList.add(',');
                        SQLList.add('('+
                          QuotedStr(FieldByname('Trntype').asString)                                      +','+
                          QuotedStr(FormaTDateTime(MysqlDateFormat , FieldByname('PaidDate').asDatetime)) +','+
                          QuotedStr(FieldByname('companyName').AsString)                                  +','+
                          FloattoStr(FieldByname('Amount').AsFloat)                                       +','+
                          IntToStr(FieldByname('TransactionID').asInteger)                      +','+
                          QuotedStr(FieldByname('AccountName').AsString)                                  +','+
                          QuotedStr(FieldByname('ClassName').ASString)                                    +','+
                          QuotedStr(FieldByname('ChequeNo').ASString)                                     +','+
                          QuotedStr(FieldByname('PaymentMethod').AsString)                                +','+
                          IntToStr(FieldByname('TransID').asInteger)                            +','+
                          IntToStr(FieldByname('ClientID').asInteger)                           +','+
                          IntToStr(FieldByname('PayMethodID').asInteger)                        +','+
                          IntToStr(FieldByname('AccountID').asInteger)                          +','+
                          QuotedStr(FieldByname('TableName').AsString)                                    +','+
                          IntToStr(FieldByname('PaymentID').asInteger) +')');
                          firstRec := False;
                        Next;
                    end;
                    SQLList.add(';');
                end;
            finally
                if Active then close;
                FreeAndNil(Qry);
            end;
            SQLList.add('INSERT INTO ' + GuiTableName );
            SQLList.add('(Deposited, DepositID, Trntype, ');
            SQLList.Add('PaidDate,CompanyName, Amount, ');
            SQLList.Add('TransactionID, AccountName, ');
            SQLList.Add('ClassName,ChequeNo, ');
            SQLList.Add('PaymentMethod, TransID, ClientID, PayMethodID, ');
            SQLList.Add('AccountID)');
            if GroupCashSales then begin
                SQLList.add('SELECT Deposited, DepositID, Trntype,PaidDate,');
                SQLList.Add('Companyname,Amount,TransactionID,');
                SQLList.Add('AccountName,ClassName,ChequeNo,PaymentMethod,TransID,');
                SQLList.Add('ClientID,PayMethodID,AccountID from  ' + GuiTableNamedet );
                SQLList.Add('WHERE Trntype <>"Cash Sale"') ;
                SQLList.add('UNION');
                SQLList.add('SELECT Deposited,0, Trntype,PaidDate,"Grouped Clients",');
                SQLList.Add('Sum(Amount),0,AccountName,ClassName,ChequeNo,');
                SQLList.Add('PaymentMethod,0,ClientID,PayMethodID,AccountID ');
                SQLList.Add('FROM  ' + GuiTableNamedet);
                SQLList.Add('WHERE Trntype ="Cash Sale"') ;
                SQLList.Add('GROUP BY PaidDate, ClassName , PaymentMethod;');
                SQLList.add('UPDATE     ' + GuiTableNamedet + ' as det ');
                SQLList.Add('INNER JOIN ' + GuiTableName    + ' as main ');
                SQLList.add('ON    det.Trntype      = main.Trntype ');
                SQLList.add('AND   det.PaidDate     = main.PaidDate ');
                SQLList.add('AND   det.ClassName    = main.ClassName ');
                SQLList.add('AND   det.PaymentMethod= main.PaymentMethod ');
                SQLList.add('SET   det.LineId       = main.ID;');
            end else begin
                SQLList.add('Select ');
                SQLList.add('Deposited, DepositID, Trntype,PaidDate,CompanyName,');
                SQLList.Add('Amount,TransactionID, AccountName,ClassName,ChequeNo,');
                SQLList.Add('PaymentMethod, TransID, ClientID, PayMethodID,AccountID');
                SQLList.Add('FROM  ' + GuiTableNamedet+';');
                SQLList.add('UPDATE ' + GuiTableNamedet + ' set LineId = ID;')
            end;
        end;
        ExecuteSQL(SQLList);
    finally
        FreeandNil(SQLList);
    end;
end;*)

Function TBankDeposit.UnDepositedEntries:String;
var
    SQLList :TStringList;
begin
    SQLList :=TStringList.Create;
    try
    {cashSale}
        SQLList.Add('SELECT if(tblSales.IsRefund="T", "Refund",if(ISPos="T" and ISCashSale="T" , "POS Cash Sale" , "Cash Sale")) as Trntype,');
        SQLList.Add('tblSales.SaleDate as "PaidDate",');
        SQLList.Add('tblClients.Company as companyName,');
        SQLList.Add('tblsalespayments.Amount as Amount,');
        SQLList.Add('tblSales.SaleID as TransactionID,');
        SQLList.Add('tblsalespayments.PaymentID as PaymentID,');
        SQLList.Add('tblchartofaccounts.AccountName as "AccountName",');
        SQLList.Add('tblSales.Class as ClassName,');
        SQLList.Add('tblSales.ChequeNo as "ChequeNo",');
        SQLList.Add('tblsalespayments.PayMethod as "PaymentMethod",');
        SQLList.Add('tblSales.SaleID AS TransID,');
        SQLList.Add('tblClients.ClientID,');
        SQLList.Add('tblpaymentmethods.PayMethodID,');
        SQLList.Add('tblchartofaccounts.AccountID , "tblsalespayments" as TableName');
        SQLList.Add('FROM tblSales ');
        SQLList.Add('INNER JOIN tblsalespayments USING(SaleID) ');
        SQLList.Add('Left join tblPurchaseorders Cheque on Cheque.IsRefundCheque ="T" and  ifnull(Cheque.RefundGlobalref,"") <> "" and ifnull(Cheque.RefundGlobalref,"")  = tblsales.Globalref ');
        SQLList.Add('INNER JOIN tblchartofaccounts  ON  IFNULL(tblSales.AccountID,0) = tblchartofaccounts.AccountID ');
        SQLList.Add('LEFT JOIN tblClients ON  tblSales.ClientID = tblClients.ClientID ');
        SQLList.Add('LEFT JOIN tblpaymentmethods  ON  tblSales.PayMethod = tblpaymentmethods.Name ');
        SQLList.Add('LEFT JOIN tblbankdepositlines bdl on bdl.TransId = tblSalesPayments.SaleId' +
          ' and (bdl.TrnsType in ("Cash Sale","POS Cash Sale" , "Refund"))' +
          ' and bdl.TransPaymentID =tblSalesPayments.PaymentID ' +
          ' and bdl.Deleted <> "T"' +
          ' and (select Deleted from tblbankdeposit bd where bdl.DepositId = bd.DepositId) <> "T"');
        SQLList.Add('LEFT JOIN (tblbankdepositlinessales bdls ' +
                                    ' inner join tblbankdepositlines bdlsd on bdlsd.DepositLineID =bdls.bankdepositlinesID and bdlsd.deleted = "F"  ' +
                                    ' inner join tblbankdeposit bdlsdd on bdlsdd.DepositID = bdlsd.DepositID and bdlsdd.deleted ="F")  ' +
          ' on bdls.TransId = tblSalesPayments.SaleId and bdls.PaymentId = tblSalesPayments.PaymentID' );
        SQLList.Add('WHERE tblsalespayments.Amount<>0.00 ');
        SQLList.Add('AND (tblsalespayments.PayMethod <> ' + Quotedstr(CHEQUE) +' OR  ifnull(Cheque.PurchaseOrderId,0)=0)');
        SQLList.Add('AND tblSales.Deleted<>"T" ');
        SQLList.Add('AND (tblSales.IsRefund ="T" OR tblSales.IsCashSale="T" ) ');
        SQLList.Add('AND tblSales.IsInvoice="F" AND tblSales.POS = "F" ');
        SQLList.Add('AND tblSales.IsSalesOrder="F" AND  tblSales.IsQuote="F"  ');
        SQLList.Add('AND tblSales.Deposited = "F"  ');
        SQLList.Add('AND IfNull(bdl.DepositLineId,0)=0');
        SQLList.Add('AND IfNull(bdls.bankdepositlinesSalesID,0)=0');
        SQLList.Add('AND tblsalespayments.PayMethod <> "Layby" ');
//        SQLList.Add('and not tblSales.SaleId in (select bdl.TransId from tblBankDepositLines bdl, tblBankDeposit bd where bdl.TrnsType = "Cash Sale" and bd.DepositID = bdl.DEpositID and bd.Deleted <> "T")');
        if PayMethod <> '' then SQLList.Add('and tblsalespayments.PayMethod = ' + QuotedStr(PayMethod));
        if fiListforDepartmentID <> 0 then SQLList.add(' and tblSales.classId = ' + IntToStr(fiListforDepartmentID));

    {customer payment}
        SQLList.Add('Union ALL ');
        SQLList.Add('SELECT "Customer Payment" as Trntype,');
        SQLList.Add('PaymentDate as "PaidDate",');
        SQLList.Add('tblClients.Company as companyName,');
        SQLList.Add('Amount,');
        SQLList.Add('PaymentID as TransID,');
        SQLList.Add('tbldeposits.PaymentID AS PaymentID,');
        SQLList.Add('tblchartofaccounts.AccountName as "AccountName",');
        SQLList.Add('tblClass.ClassName as ClassName,');
        SQLList.Add('ReferenceNo as "ChequeNo",');
        SQLList.Add('tblpaymentmethods.NAME as "PaymentMethod",');
        SQLList.Add('tbldeposits.PaymentID AS TransactionID,');
        SQLList.Add('tblClients.ClientID,');
        SQLList.Add('tblpaymentmethods.PayMethodID,');
        SQLList.Add('tblchartofaccounts.AccountID , "tbldeposits" as Tablename');
        SQLList.Add('FROM tbldeposits ');
        SQLList.Add('INNER JOIN tblchartofaccounts  ON  IFNULL(tbldeposits.AccountID,0) = tblchartofaccounts.AccountID ');
        SQLList.Add('LEFT JOIN tblClients  ON  tblClients.ClientID = tbldeposits.CusID ');
        SQLList.Add('LEFT JOIN tblpaymentmethods  ON  tbldeposits.PayMethodID = tblpaymentmethods.PayMethodID ');
        SQLList.Add('LEFT JOIN tblClass On tblClass.ClassID = tbldeposits.ClassID ');
        SQLList.Add('Where Amount<>0.00 ');
        SQLList.Add('AND tbldeposits.Customer = "T" ');
        SQLList.Add('And tbldeposits.CustomerPayment = "T" ' );
        SQLList.Add('AND tbldeposits.Deposited<>"T" ');
        SQLList.Add('AND IFNULL(tbldeposits.AccountID,0) =' + IntToStr(tcDataUtils.GetAccountID(UNDEPOSITED_FUNDS)) + ' ');
        SQLList.Add('and tbldeposits.Deleted ="F"  ');
        if PayMethod <> '' then SQLList.Add('and tblpaymentmethods.NAME = ' + QuotedStr(PayMethod));
        if fiListforDepartmentID <> 0 then SQLList.Add(' and tbldeposits.classId = ' + IntToStr(fiListforDepartmentID));
    { Prepayment }
        SQLList.Add('Union ALL ');
        SQLList.Add('SELECT  "Prepayment" as Trntype, ');
        SQLList.Add('tblprepayments.PrePaymentDate as "PaidDate", ');
        SQLList.Add('tblprepayments.CompanyName as companyName, ');
        SQLList.Add('tblprepayments.PayAmount as Amount, ');
        SQLList.Add('tblprepayments.PrePaymentID as TransID, ');
        SQLList.Add('tblprepayments.PrePaymentID AS PaymentID,');
        SQLList.Add('tblchartofaccounts.AccountName as "AccountName", ');
        SQLList.Add('tblClass.ClassName as ClassName, ');
        SQLList.Add('tblprepayments.ReferenceNo as "ChequeNo", ');
        SQLList.Add('tblpaymentmethods.Name as "PaymentMethod", ');
        SQLList.Add('tblprepayments.PrePaymentID AS TransactionID, ');
        SQLList.Add('tblprepayments.ClientID, ');
        SQLList.Add('tblprepayments.PayMethodID, ');
        SQLList.Add('tblchartofaccounts.AccountID, "tblPrePayments" as Tablename ');
        SQLList.Add('FROM tblprepayments ');
        SQLList.Add('INNER JOIN tblchartofaccounts  ON  tblprepayments.BankAccountID = tblchartofaccounts.AccountID ');
        SQLList.Add('INNER JOIN tblClass ON  tblprepayments.ClassID = tblClass.ClassID ');
        SQLList.Add('LEFT JOIN tblpaymentmethods ON tblprepayments.PayMethodID = tblpaymentmethods.PayMethodID ');
        SQLList.Add('WHERE tblprepayments.PayAmount<>0.00 ');
        SQLList.Add('AND tblprepayments.Deleted="F" ');
        SQLList.Add('AND tblprepayments.Deposited="F" ');
        SQLList.Add('AND tblprepayments.Customer="T" ');
        SQLList.Add('AND tblprepayments.BankAccountID =' + IntToStr(tcDatautils.GetAccountID(UNDEPOSITED_FUNDS)) + ' ');
        if PayMethod <> '' then SQLList.Add('and tblpaymentmethods.Name = ' + QuotedStr(PayMethod));
        if fiListforDepartmentID <> 0 then SQLList.Add(' and tblprepayments.classId = ' + IntToStr(fiListforDepartmentID));
        Result :=SQLList.Text;
    finally
        FreeandNil(SQLList);
    end;
end;

Function TBankDeposit.GetLines :TBankDepositLines;
begin
  Result := TBankDepositLines(Getcontainercomponent(TBankDepositLines, 'DepositID = ' + IntToStr(ID)));
  If Assigned(Result) Then Result.IsList := True;
end;

Function TBankDeposit.getIsDepositEntryLocked       : TTransLockType;
begin
    Result := ltNone;
         if DepositReconciled           then Result := ltReconciled
    else if DepositEntrySplitReconciled then Result := ltReconciled
    else if DepositOnHOLD               then Result := ltOnHoldRec
    else if DepositEntrySplitOnHOLD     then Result := ltOnHoldRec;
end;

Function TBankDeposit.getIsDepositLocked : TTransLockType;
begin
    Result := ltNone;
         if DepositReconciled   then Result := ltReconciled
    else if DepositOnHOLD       then Result := ltOnHoldRec;
end;

Procedure TBankDeposit.setGroupCashSales     (Const Value : Boolean   );
begin
    fbGroupCashSales := Value;
    (*LoadGuitable;*)
end;

Procedure   TBankDeposit.DepositLines;
var
  fbFlag:Boolean;
begin
  ShowProgressbar(GuiBankDeposit.count);
    try
      fbflag:= GuiBankDeposit.DoFieldChangewhenDisabled ;
      GuiBankDeposit.DoFieldChangewhenDisabled := True;
      try
        GuiBankDeposit.Iteraterecords(CallbackDepositLine);
      finally
        GuiBankDeposit.DoFieldChangewhenDisabled := fbFlag;
      end;
    finally
      HideProgressbar;
    end;
end;

Procedure   TBankDeposit.UnDepositLines;
begin
    ShowProgressbar(GuiBankDeposit.count);
    try
      GuiBankDeposit.Iteraterecords(CallbackUnDepositLine);
    finally
      HideProgressbar;
    end;

end;

Procedure   TBankDeposit.AutoSelect;
begin
    if GuiBankDeposit.count = 0 then
      exit;
    UnDepositLines;
    GuiBankDeposit.Iteraterecords(AutoDepositLines);
    GuiBankDeposit.Calctotals(True);
end;

Procedure TBankDeposit.AutoDepositLines(Const Sender: Tbusobj; Var Abort :Boolean);
begin
    if Deposit> DepositedTotal then begin
        TGuiBankDeposit(sender).Deposited := true;
        TGuiBankDeposit(Sender).PostDB;
    end else Abort := True;
end;

Procedure TBankDeposit.CallbackDepositLine(Const Sender: Tbusobj; Var Abort :Boolean);
begin
    StepProgressbar;
    if not (Sender is TGuiBankDeposit) then Exit;
    TGuiBankDeposit(sender).Deposited := true;
    TGuiBankDeposit(Sender).PostDB;

end;

Procedure TBankDeposit.CallbackUnDepositLine(Const Sender: Tbusobj; Var Abort :Boolean);
begin
    StepProgressbar;
    if not (Sender is TGuiBankDeposit) then Exit;

    TGuiBankDeposit(sender).Deposited := False;
    TGuiBankDeposit(Sender).PostDB;
end;

Function  TBankDeposit.AutoDepositTenderAccounts:Boolean;
var
    strSQL:String;
begin
    Result := False;
    strSQL := 'SELECT TAP.TAPID,TAP.PaymethodID,TAP.Paymethod,  ' +
              ' TAP.AccountID, TAP.Account  ' +
              ' FROM tbltenderaccountprefs as TAP ' +
              ' INNER JOIN tblchartofaccounts COA USING(AccountID)  ' +
              ' WHERE TAP.Active="T" AND COA.Active="T"; ';

    with getNewDataset(strSQL) do try
        if recordcount = 0 then begin
            SendEvent(BusObjEvent_Change, BusObjEventVal_MissingTenderAccounts,Self ); {will create the accounts - so close and open the data set }
            close;
            Open;
          if recordcount =0 then begin
            ResultStatus.AddItem(False, rssWarning, 0 , 'Tender Accounts for Auto Deposit are not selected.');
            Result := false;
            Exit;
          end;
        end;
        First;
        Self.Connection.BeginTransaction;
        try
            while Eof = False do begin
                Self.Connection.BeginNestedTransaction;
                new;
                PayMethod := fieldByname('Paymethod').asString;
                try
                    if GuiBankDeposit.count > 0 then begin
                        AccountID   := fieldByname('AccountID').asInteger;;
                        ClassId     := tcDatautils.GetDeptID(DepositClassName);
                        DepositDate := now;
                        DepositLines;
                        GuiBankDeposit.Calctotals;
                        PostDB;
                        if Save then begin
                           Self.Connection.CommitNestedTransaction;
                        end else begin
                            Result := False;
                            Self.connection.RollbackTransaction;
                            Exit;
                        end;
                    end else begin
                        Self.Connection.RollbackNestedTransaction;
                    end;
                Finally
                   PayMethod := '';
                end;
                next;
            end;
            Self.connection.CommitTransaction;
            Result := TRue;
        Except
            Self.Connection.RollbackTransaction;
        end;

    finally
        if Active then close;
        Free;
    end;
end;

{Property Functions}
Function  TBankDeposit.GetDepositDate   : TDateTime ; begin Result := GeTDateTimeField('DepositDate');  end;
Function  TBankDeposit.GetEmployeeID    : Integer   ; begin Result := GetIntegerField('EmployeeID');    end;
Function  TBankDeposit.GetClassID       : Integer   ; begin Result := GetIntegerField('ClassID');       end;
Function  TBankDeposit.GetClassName     : String    ; begin Result := GetStringField('ClassName');      end;
Function  TBankDeposit.GetAccountName   : String    ; begin Result := TAccount.IDToggle(AccountId);   end;
Function  TBankDeposit.GetEmployeeName  : String    ; begin Result := TEmployee.IDToggle(EmployeeId);   end;
Function  TBankDeposit.GetAccountID     : Integer   ; begin Result := GetIntegerField('AccountID');     end;
Function  TBankDeposit.GetNotes         : String    ; begin Result := GetStringField('Notes');          end;
Function  TBankDeposit.GetDeposit       : Double    ; begin Result := GetFloatField('Deposit');         end;
Function  TBankDeposit.GetDeleted       : Boolean   ; begin Result := GetBooleanField('Deleted');       end;
Function  TBankDeposit.GetReconciled    : Boolean   ; begin Result := GetBooleanField('Reconciled');    end;
Function  TBankDeposit.GetUnDeposittot  : Double    ; begin Result := GetFloatField('UnDeposittot' );   end;
Function  TBankDeposit.GetDeposittot    : Double    ; begin Result := GetFloatField('Deposittot');      end;
Function  TBankDeposit.GetCustField1    : String    ; begin	Result := GetStringfield('CustField1'); End;
Function  TBankDeposit.GetCustField2    : String    ; begin	Result := GetStringfield('CustField2'); End;
Function  TBankDeposit.GetCustField3    : String    ; begin	Result := GetStringfield('CustField3'); End;
Function  TBankDeposit.GetCustField4    : String    ; begin	Result := GetStringfield('CustField4'); End;
Function  TBankDeposit.GetCustField5    : String    ; begin	Result := GetStringfield('CustField5'); End;
Function  TBankDeposit.GetCustField6    : String    ; begin	Result := GetStringfield('CustField6'); End;
Function  TBankDeposit.GetCustField7    : String    ; begin	Result := GetStringfield('CustField7'); End;
Function  TBankDeposit.GetCustField8    : String    ; begin	Result := GetStringfield('CustField8'); End;
Function  TBankDeposit.GetCustField9    : String    ; begin	Result := GetStringfield('CustField9'); End;
Function  TBankDeposit.GetCustField10   : String    ; begin	Result := GetStringfield('CustField10'); End;
Function  TBankDeposit.GetTypeOfBasedOn    : String;     Begin Result := GetStringField('TypeOfBasedOn'); End;
Function  TBankDeposit.GetFrequencyValues  : String;     Begin Result := GetStringField('FrequencyValues'); End;
Function  TBankDeposit.GetCopyStartDate    : TDateTime;  Begin Result := GetDateTimeField('CopyStartDate'); End;
Function  TBankDeposit.GetCopyFinishDate   : TDateTime;  Begin Result := GetDateTimeField('CopyFinishDate'); End;

Procedure TBankDeposit.SetDepositDate   (Const Value: TDateTime ); begin SeTDateTimeField('DepositDate', Value);end;
Procedure TBankDeposit.SetEmployeeID    (Const Value: Integer   ); begin SetIntegerField('EmployeeID'  , Value);end;
Procedure TBankDeposit.setClassID       (Const Value: Integer   ); begin SetIntegerField('ClassID'     , Value);end;
Procedure TBankDeposit.SetClassName     (Const Value: String    ); begin SetStringField('ClassName'    , Value);end;
Procedure TBankDeposit.SetAccountName   (Const Value: String    ); begin AccountId := TAccount.IDToggle(Value);end;
Procedure TBankDeposit.SetEmployeeName  (Const Value: String    ); begin EmployeeId := TEmployee.IDToggle(Value);end;
Procedure TBankDeposit.SetAccountID     (Const Value: Integer   ); begin SetIntegerField('AccountID'   , Value);end;
Procedure TBankDeposit.SetNotes         (Const Value: String    ); begin SetStringField('Notes'        , Value);end;
Procedure TBankDeposit.SetDeposit       (Const Value: Double    ); begin SetFloatField('Deposit'       , Value);end;
Procedure TBankDeposit.SetDeleted       (Const Value: Boolean   ); begin SetBooleanField('Deleted'     , Value);end;
Procedure TBankDeposit.SetReconciled    (Const Value: Boolean   ); begin SetBooleanField('Reconciled'  , Value);end;
Procedure TBankDeposit.SetUnDeposittot  (Const Value: Double    ); begin SetFloatField('UnDeposittot'  , Value);end;
Procedure TBankDeposit.SetDeposittot    (Const Value: Double    ); begin SetFloatField('Deposittot'    , Value);end;
procedure TBankDeposit.SetCustField1    (const Value: String);   begin SetStringfield('CustField1',   Value);   end;
procedure TBankDeposit.SetCustField2    (const Value: String);   begin SetStringfield('CustField2',   Value);   end;
procedure TBankDeposit.SetCustField3    (const Value: String);   begin SetStringfield('CustField3',   Value);   end;
procedure TBankDeposit.SetCustField4    (const Value: String);   begin SetStringfield('CustField4',   Value);   end;
procedure TBankDeposit.SetCustField5    (const Value: String);   begin SetStringfield('CustField5',   Value);   end;
procedure TBankDeposit.SetCustField6    (const Value: String);   begin SetStringfield('CustField6',   Value);   end;
procedure TBankDeposit.SetCustField7    (const Value: String);   begin SetStringfield('CustField7',   Value);   end;
procedure TBankDeposit.SetCustField8    (const Value: String);   begin SetStringfield('CustField8',   Value);   end;
procedure TBankDeposit.SetCustField9    (const Value: String);   begin SetStringfield('CustField9',   Value);   end;
procedure TBankDeposit.SetCustField10   (const Value: String);   begin SetStringfield('CustField10',  Value);   end;
Procedure TBankDeposit.SetTypeOfBasedOn   (Const Value: String);      Begin  SetStringField('TypeOfBasedOn', Value);  End;
Procedure TBankDeposit.SetFrequencyValues (Const Value: String);      Begin  SetStringField('FrequencyValues', Value);  End;
Procedure TBankDeposit.SetCopyStartDate   (Const Value: TDateTime);   Begin  SetDateTimeField('CopyStartDate', Value);  End;
Procedure TBankDeposit.SetCopyFinishDate  (Const Value: TDateTime);   Begin  SetDateTimeField('CopyFinishDate', Value);  End;

function TBankDeposit.getLinesSales: TBankDepositLinesSales;
begin
  Result := TBankDepositLinesSales(Getcontainercomponent(TBankDepositLinesSales ,'bankdepositlinesID = ' + IntToStr(Lines.ID)));
end;

function TBankDeposit.LockTransaction(fsTablename: String;TransactionID: Integer;var Msg:STring): boolean;
begin
     Result := Userlock.Lock(fsTablename, TransactionID , LockGroupName);
     if not result then
        Msg :=Userlock.LockMessage;
end;

{TGuiBankDeposit}

Constructor TGuiBankDeposit.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
    fSQL := '';
    if Assigned(Self.Owner) then
        if Self.Owner is TBankDeposit then begin
            fSQL := 'Select * from ' + TBankDeposit(Self.Owner).GuiTableName
        end else if Self.Owner is TGuiBankDeposit then
            if Assigned(Self.Owner.Owner) then
                if Self.Owner.owner is TBankDeposit then
                    if Self.ClassnameIs('TGuiBankDepositdet') then
                        fSQL := 'Select * from ' + TBankDeposit(Self.Owner.Owner).GuiTableNameDet;
    LinkedTransAssigned := False;
end;

Function TGuiBankDeposit.GetSQL:String;
begin
    if FSQL = '' then
        if Assigned(Self.Owner) then
            if Self.Owner is TBankDeposit then begin
                fSQL := 'Select * from ' + TBankDeposit(Self.Owner).GuiTableName
            end else if Self.Owner is TGuiBankDeposit then
                if Assigned(Self.Owner.Owner) then
                    if Self.Owner.owner is TBankDeposit then
                        if Self.ClassnameIs('TGuiBankDepositdet') then
                            fSQL := 'Select * from ' + TBankDeposit(Self.Owner.Owner).GuiTableNameDet;

    Result := inherited GetSQL;
end;

Class Function TGuiBankDeposit.GetBusObjectTablename :String;
begin
    Result := '';
end;

Destructor TGuiBankDeposit.Destroy;
var
    strSQL :String;
begin
    if self is TGuiBankDepositdet then begin
        if DatasetAssigned then if datasetActive then close;
        if (Assigned(Self.Owner)) and (self.owner is TBankdeposit) and (TBankDeposit(Self.Owner).GuiTableNamedet <> '') then begin
            strSQL := 'Drop table if exists ' + TBankDeposit(Self.Owner).GuiTableNamedet ;
            TBankDeposit(Self.Owner).GuiTableNamedet := '';
            getnewDataset(strSQL);
        end;
    end else if self is TGuiBankDeposit then
        if LinkedTransAssigned then
            if AssignedLinkedtrans and LinkedTrans.DatasetAssigned then
                if LinkedTrans.DatasetActive then
                    LinkedTrans.Dataset.close;
        LinkedTransAssigned  := False;
        if DatasetAssigned then if datasetActive then close;
        if (Assigned(Self.Owner)) and (self.owner is TBankdeposit) and (TBankDeposit(Self.Owner).GuiTableName <> '') then begin
                strSQL := 'Drop table if exists ' + TBankDeposit(Self.Owner).GuiTableName ;
                getnewDataset(strSQL);
                TBankDeposit(Self.Owner).GuiTableName:= '';
        end;

  inherited;
end;

Procedure TGuiBankDeposit.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'DepositId');
  SetPropertyFromNode(node,'Trntype');
  SetPropertyFromNode(node,'PaidDate');
  SetPropertyFromNode(node,'companyName');
  SetPropertyFromNode(node,'Amount');
  SetPropertyFromNode(node,'TransactionID');
  SetPropertyFromNode(node,'AccountName');
  SetPropertyFromNode(node,'ClassName');
  SetPropertyFromNode(node,'ChequeNo');
  SetPropertyFromNode(node,'PaymentMethod');
  SetPropertyFromNode(node,'TransID');
  SetPropertyFromNode(node,'ClientID');
  SetPropertyFromNode(node,'PayMethodID');
  SetPropertyFromNode(node,'AccountID');
end;

Procedure TGuiBankDeposit.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DepositId' ,DepositId);
  AddXMLNode(node,'Trntype' ,trnType);
  AddXMLNode(node,'PaidDate' ,PaidDate);
  AddXMLNode(node,'companyName' ,companyName);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'TransactionID' ,TransactionID);
  AddXMLNode(node,'AccountName' ,AccountName);
  AddXMLNode(node,'ClassName' ,ClassName);
  AddXMLNode(node,'ChequeNo' ,ChequeNo);
  AddXMLNode(node,'PaymentMethod' ,PaymentMethod);
  AddXMLNode(node,'TransID' ,TransID);
  AddXMLNode(node,'ClientID' ,ClientID);
  AddXMLNode(node,'PayMethodID' ,PayMethodID);
  AddXMLNode(node,'AccountID' ,AccountID);
end;

Function TGuiBankDeposit.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;

Function TGuiBankDeposit.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

Procedure TGuiBankDeposit.OnDataIdChange(Const ChngType: TBusObjDataChangeType);
begin
    inherited;
    if LinkedTransAssigned then
        if (Assigned(Self.Owner)) and (self.owner is TBankdeposit) and (TBankDeposit(Self.Owner).GuiTableNameDet <> '') then
            if LinkedTrans.DatasetAssigned then
                if LinkedTrans.DatasetActive then
                    LinkedTrans.Dataset.close;
    LinkedTransAssigned := False;
end;

Procedure TGuiBankDeposit.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.fieldName , 'Deposited') then begin
      if deposited then begin
          if not LockTransactions then begin
              Deposited := False;
              Exit;
          end;
      end;
        CalcTotals;
    end;
end;

Procedure TGuiBankDeposit.Calctotals(Autoselecting :Boolean  =False);
var
    fdDepositedtotal :Double;
    fdUnDepositedTotal :Double;
    bm: TBookmark;
begin
    if assigned(Self.Owner) then
        if Self.Owner is TBankDeposit then begin
          Dataset.DisableControls;
          bm:= Dataset.GetBookmark;
          try
            fdDepositedTotal := TBankDeposit(Self.Owner).Depositedtotal;
            fdUnDepositedTotal:= TBankDeposit(Self.Owner).UnDepositedTotal;
            if TBankDeposit(Self.Owner).UnDeposittot <> fdUnDepositedTotal then
                TBankDeposit(Self.Owner).UnDeposittot := fdUnDepositedTotal;
            if TBankDeposit(Self.Owner).Deposittot   <> fdDepositedtotal then
                TBankDeposit(Self.Owner).Deposittot   := fdDepositedtotal;
            if not Autoselecting then
                if TBankDeposit(Self.Owner).Deposit <> fdDepositedtotal then
                    TBankDeposit(Self.Owner).Deposit := fdDepositedtotal;
          finally
            Dataset.first;
            Dataset.GotoBookmark(bm);
            Dataset.FreeBookmark(bm);
            Dataset.EnableControls;
          end;
        end;
end;

Class Function TGuiBankDeposit.GetIDField: String;
begin
  Result := 'ID'
end;


Function TGuiBankDeposit.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

Function TGuiBankDeposit.getLinkedTrans      : TGuiBankDepositDet;
begin
  Result:=
    TGuiBankDepositDet(getcontainercomponent(TGuiBankDepositDet, 'LineId = ' + IntToStr(ID)));
  LinkedTransAssigned := true;
end;

Function TBankDeposit.GetUnDepositedTotal    : Double;
begin
    fdtotalAmount := 0;
    GuiBankDeposit.Iteraterecords(CalcUnDepoitedtotal);
    Result := fdTotalamount
end;

Procedure TBankDeposit.CalcUnDepoitedtotal   (Const Sender: Tbusobj; Var Abort :Boolean);
begin
    if not (Sender is TGuiBankDeposit) then Exit;
    if not TGuiBankDeposit(Sender).Deposited then
        fdTotalamount  := fdTotalamount  + TGuiBankDeposit(Sender).Amount;
end;

Function TBankDeposit.GetDepositedTotal      : Double;
begin
    fdtotalAmount := 0;
    GuiBankDeposit.Iteraterecords(CalcDepoitedtotal);
    Result := Round(fdTotalamount,CurrencyRoundPlaces);
end;

Procedure TBankDeposit.CalcDepoitedtotal   (Const Sender: Tbusobj; Var Abort :Boolean);
begin
    if not (SEnder is TGuiBankDeposit) then Exit;
    if TGuiBankDeposit(Sender).Deposited then
        fdTotalamount  := fdTotalamount  + TGuiBankDeposit(Sender).Amount;
end;

Function TBankDeposit.GetTotalamount:Double;
begin
    fdtotalAmount := 0;
    if Lines.Dataset.State in [dsInsert, dsEdit] then
      Lines.PostDb;
    Lines.Iteraterecords(CalctotalAmount);
    Result := Round(fdTotalamount,CurrencyRoundPlaces);
end;

Procedure TBankDeposit.CalcTotalamount(Const Sender: Tbusobj; Var Abort :Boolean);
begin
    if not (SEnder is TBankdepositlines) then Exit;
    fdTotalamount  := fdTotalamount  + TBankdepositlines(Sender).Amount;
end;

{Property Functions}
Function  TGuiBankDeposit.GetDepositId    : Integer   ; begin Result := GetIntegerField('DepositId');end;
Function  TGuiBankDeposit.GetTrntype      : String    ; begin Result := GetStringField('Trntype');end;
Function  TGuiBankDeposit.GetPaidDate     : TDateTime ; begin Result := GeTDateTimeField('PaidDate');end;
Function  TGuiBankDeposit.GetcompanyName  : String    ; begin Result := GetStringField('companyName');end;
Function  TGuiBankDeposit.GetAmount       : Double    ; begin Result := GetFloatField('Amount');end;
Function  TGuiBankDeposit.GetTransactionID: Integer   ; begin Result := GetIntegerField('TransactionID');end;
Function  TGuiBankDeposit.GetAccountName  : String    ; begin Result := GetStringField('AccountName');end;
Function  TGuiBankDeposit.GetClassName    : String    ; begin Result := GetStringField('ClassName');end;
Function  TGuiBankDeposit.GetChequeNo     : String    ; begin Result := GetStringField('ChequeNo');end;
Function  TGuiBankDeposit.GetPaymentMethod: String    ; begin Result := GetStringField('PaymentMethod');end;
Function  TGuiBankDeposit.GetTransID      : Integer   ; begin Result := GetIntegerField('TransID');end;
Function  TGuiBankDeposit.GetClientID     : Integer   ; begin Result := GetIntegerField('ClientID');end;
Function  TGuiBankDeposit.GetPayMethodID  : Integer   ; begin Result := GetIntegerField('PayMethodID');end;
Function  TGuiBankDeposit.GetAccountID    : Integer   ; begin Result := GetIntegerField('AccountID');end;
Function  TGuiBankDeposit.GetDeposited    : Boolean   ; begin Result := GetBooleanField('Deposited');end;

Procedure TGuiBankDeposit.SetDepositID    (Const Value: Integer   ); begin SetIntegerField('DepositId'  ,Value);end;
Procedure TGuiBankDeposit.SetTrnType      (Const Value: String    ); begin SetStringField('Trntype'     ,Value);end;
Procedure TGuiBankDeposit.SetPaidDate     (Const Value: TDateTime ); begin SeTDateTimeField('PaidDate'  ,Value);end;
Procedure TGuiBankDeposit.SetcompanyName  (Const Value: String    ); begin SetStringField('companyName' ,Value);end;
Procedure TGuiBankDeposit.SetAmount       (Const Value: Double    ); begin SetFloatField('Amount'       ,Value);end;
Procedure TGuiBankDeposit.SetTransactionID(Const Value: Integer   ); begin SetIntegerField('Amount'     ,Value);end;
Procedure TGuiBankDeposit.SetAccountName  (Const Value: String    ); begin SetStringField('AccountName' ,Value);end;
Procedure TGuiBankDeposit.SetClassName    (Const Value: String    ); begin SetStringField('ClassName'   ,Value);end;
Procedure TGuiBankDeposit.SetChequeNo     (Const Value: String    ); begin SetStringField('ChequeNo'    ,Value);end;
Procedure TGuiBankDeposit.SetPaymentMethod(Const Value: String    ); begin SetStringField('ChequeNo'    ,Value);end;
Procedure TGuiBankDeposit.SetTransID      (Const Value: Integer   ); begin SetIntegerField('TransID'    ,Value);end;
Procedure TGuiBankDeposit.SetClientID     (Const Value: Integer   ); begin SetIntegerField('ClientID'   ,Value);end;
Procedure TGuiBankDeposit.SetPayMethodID  (Const Value: Integer   ); begin SetIntegerField('PayMethodID',Value);end;
Procedure TGuiBankDeposit.SetAccountID    (Const Value: Integer   ); begin SetIntegerField('AccountID'  ,Value);end;
Procedure TGuiBankDeposit.SetDeposited    (Const Value: Boolean   ); begin SetBooleanfield('Deposited'  ,Value);end;
function TGuiBankDeposit.getPaymentId: Integer;
begin
  result := getIntegerfield('PaymentId');
  if result = 0 then
    result := LinkedTrans.PaymentId;
end;

procedure TGuiBankDeposit.SetPaymentId(const Value: Integer);
begin
  SetIntegerfield('PaymentId' , Value);
end;

function TGuiBankDeposit.AssignedLinkedtrans: Boolean;
begin
  Result := getContainerComponentifExists(TGuiBankDepositDet)<> nil;
end;

function TGuiBankDeposit.LockTransactions: Boolean;
begin
    AlllinesValid := true;
    LinkedTrans.Iteraterecords(CallbackLockTrans);
    Result := AlllinesValid ;
end;

Procedure TGuiBankDeposit.CallbackLockTrans(Const Sender: Tbusobj; Var Abort :Boolean);
var
  fsTable:String;
  Msg:String;
begin
    if not (Sender is TGuiBankDepositdet) then exit;
    fsTable :=TGuiBankDepositdet(Sender).TransTablename;

    if sameText(fstable, 'tblsalespayments') then fsTable := 'tblSales';

    if not(LockTransaction(fstable ,TGuiBankDepositdet(Sender).TransactionID, msg)) then begin
    (*if not Userlock.Lock(fsTable, TGuiBankDepositdet(Sender).TransactionID) then begin*)
        ResultStatus.AddItem(False,rssWarning,0,ReplaceStr(msg, 'this record' , TGuiBankDepositdet(Sender).TrnType + '#' +
            IntToStr(TGuiBankDepositdet(Sender).TransactionID)));
        AlllinesValid := False;
        abort := True;
    end;
end;

function TGuiBankDeposit.LockTransaction(fsTablename: String;TransactionID: Integer; var Msg: STring): boolean;
begin
     result := False;
     if assigned(Self.owner) then
        if self.Owner is TBankDeposit then
           result := TBankDeposit(Self.Owner).LockTransaction(fsTablename , TransactionID , msg)

end;

{TGuiBankDepositDet}
Function  TGuiBankDepositDet.GetLineID    : Integer   ; begin Result := GetIntegerField('LineID');end;
Function  TGuiBankDepositDet.getTransTablename : String    ; begin Result := GetStringField('TableName');end;
function  TGuiBankDepositDet.getPaymentId: Integer;begin  Result := getIntegerField('PaymentID');end;
Procedure TGuiBankDepositDet.SetLineID    (Const Value: Integer   ); begin SetIntegerField('LineID'        , Value);end;
Procedure TGuiBankDepositDet.setTransTablename (Const Value: String    ); begin SetStringField('TableName'   ,Value);end;
procedure TGuiBankDepositDet.SetPaymentID (const Value: Integer);begin  SetIntegerField('PaymentID' , Value);end;
Procedure TGuiBankDepositDet.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'LineID' ,LineID);
  AddXMLNode(node,'PaymentId' ,PaymentId);
  AddXMLNode(node,'TransTablename' ,TransTablename);
end;
Procedure TGuiBankDepositDet.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'LineID');
  SetPropertyFromNode(node,'PaymentID');
  SetPropertyFromNode(node,'TransTablename');
end;

{TBankDepositLinesSales}
constructor TBankDepositLinesSales.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'BankDepositLinesSales';
  fSQL := 'SELECT * FROM tblbankdepositlinessales';
end;


destructor TBankDepositLinesSales.Destroy;
begin
  inherited;
end;


procedure TBankDepositLinesSales.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'bankdepositlinesID');
  SetPropertyFromNode(node,'TransID');
  SetPropertyFromNode(node,'Amount');
  SetPropertyFromNode(node,'PaymentMethod');
  SetPropertyFromNode(node,'PaymentID');

end;


procedure TBankDepositLinesSales.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'bankdepositlinesID' ,bankdepositlinesID);
  AddXMLNode(node,'TransID' ,TransID);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'PaymentMethod',PaymentMethod);
  AddXMLNode(node,'PaymentID', PaymentID);
end;

function TBankDepositLinesSales.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;

function TBankDepositLinesSales.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TBankDepositLinesSales.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TBankDepositLinesSales.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TBankDepositLinesSales.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TBankDepositLinesSales.GetIDField: string;
begin
  Result := 'bankdepositlinesSalesID'
end;

class function TBankDepositLinesSales.GetBusObjectTablename: string;
begin
  Result:= 'tblbankdepositlinessales';
end;

function TBankDepositLinesSales.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
function  TBankDepositLinesSales.GetbankdepositlinesID     : Integer   ; begin Result := GetIntegerField('bankdepositlinesID');end;
function  TBankDepositLinesSales.GetTransID                : Integer   ; begin Result := GetIntegerField('TransID');end;
function  TBankDepositLinesSales.getPaymentMethod          : String    ; begin result := getStringField('PaymentMethod'); end;
function  TBankDepositLinesSales.getPaymentID              : Integer   ; begin result := GetIntegerField('PaymentID');end;
procedure TBankDepositLinesSales.SetbankdepositlinesID     (const Value: Integer   ); begin SetIntegerField('bankdepositlinesID'      , Value);end;
procedure TBankDepositLinesSales.SetTransID                (const Value: Integer   ); begin SetIntegerField('TransID'                 , Value);end;
procedure TBankDepositLinesSales.setPaymentMethod          (const Value: String    ); begin SetStringfield('PaymentMethod'            , Value);end;
procedure TBankDepositLinesSales.setPaymentID              (const Value: Integer   ); begin SetIntegerField('PaymentID',Value);end;

function TBankDepositLinesSales.getAmount: double;
begin
  REsult := getFloatField('Amount');
end;

procedure TBankDepositLinesSales.setAmount(const Value: double);
begin
  SetFloatField('Amount', Value)
end;
Procedure   TBankDeposit.ShowProgressbar(Progresscount:Integer);
begin
    if not Assigned(fProgressbar) then Exit;
    fProgressbar.Visible := TRue;
    Progressbar.Min := 1;
    Progressbar.Max := Progresscount;
    Progressbar.Step := 1;
    Progressbar.Position := 0;
end;
Procedure   TBankDeposit.HideProgressbar;
begin
  if not Assigned(fProgressbar) then Exit;
  fProgressbar.visible := False;
end;
Procedure   TBankDeposit.StepProgressbar;
begin
  if not Assigned(fProgressbar) then Exit;
  Progressbar.StepIt;
end;
{ TVS1BankDeposit }

constructor TVS1BankDeposit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'VS1BankDeposit';
  fSQL := 'SELECT * FROM tblbankdeposit ';
end;

function TVS1BankDeposit.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterOpen(Sender);
  if not result then exit;
  if (ID<>0) and (Count>0) then begin
    //Lines.fbIsReadonly := true;
    IsDepositEntry := True;
    BankDepositTotal :=totalamount;
  end;
end;
function TVS1BankDeposit.ValidateData: Boolean;
begin
    if IsDepositEntry then
        BankDepositTotal := totalamount;
  result := inherited ValidateData;
end;

{ TVS1DepositList }

constructor TVS1DepositList.Create(AOwner: TComponent);
begin
  inherited;
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'VS1BankDeposit';
  fSQL := 'SELECT Header.* FROM tblbankdeposit as Header ' +
          ' inner join tblbankdepositLines as Details on Header.depositId = Details.DepositId '+
          ' WHERE Details.TrnsType<>"Cheque Deposit" '+
          ' AND Details.TrnsType<>"Cheque" '+
          ' AND Details.TrnsType<>"Customer Prepayment" '+
          ' AND Details.TrnsType<>"Supplier Prepayment" '+
          ' AND Deposit <> 0.00 '+
          ' AND FromDeposited="T" ';
  fSQLGroup := 'Header.DepositID';
  ExportExcludeList.add('Lines');
end;

function TVS1DepositList.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterOpen(Sender);
  if not result then exit;
end;

class function TVS1DepositList.GetIDField: String;
begin
  REsult := 'Header.depositId';
end;


initialization

  RegisterClass(TBankDepositLinesSales);
  RegisterClassOnce(TBankDeposit);
  RegisterClassOnce(TVS1BankDeposit);
  RegisterClassOnce(TVS1DepositList);
  RegisterClassOnce(TBankDepositLines);

end.




