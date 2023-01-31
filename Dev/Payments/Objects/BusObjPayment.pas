unit BusObjPayment;

{ new payment objects that can be used from WebAPI ie non-gui }
{ tables:
    Cust Payments
      tbldeposits
      tbldepositline
    Supplier Payments
      tblwithdrawal
      tblwithdrawallines
}


interface

uses
  BusObjBase, DB, Classes, XMLIntf, BusObjClient, BusObjGLAccount,
  BusObjPayMethods, BusObjABA, BusObjBankDepost;

type
  TPaymentLine = class;

  TPayment = class(TMSBusObj)
  private
    function GetPaymentNo: integer;
    procedure SetPaymentNo(const Value: integer);
    function GetDeptClassId: integer;
    function GetDeptClassName: string;
    function GetEmployeeId: integer;
    function GetEmployeeName: string;
    procedure SetDeptClassId(const Value: integer);
    procedure SetDeptClassName(const Value: string);
    procedure SetEmployeeId(const Value: integer);
    procedure SetEmployeeName(const Value: string);
    function GetCompanyName: string;
    function GetClientPrintName: string;
    function GetPaymentDate: TDateTime;
    procedure SetPaymentDate(const Value: TDateTime);
    function GetAmount: double;
    procedure SetAmount(const Value: double);
    function GetAccountId: integer;
    procedure SetAccountId(const Value: integer);
    function GetAccountName: string;
    procedure SetAccountName(const Value: string);
    function GetPaymentMethodId: integer;
    procedure SetPaymentMethodId(const Value: integer);
    function GetPaymentMethodName: string;
    procedure SetPaymentMethodName(const Value: string);
    function GetNotes: string;
    procedure SetNotes(const Value: string);
    function GetReferenceNo: string;
    procedure SetReferenceNo(const Value: string);
    function GetIsCustomer: boolean;
    function GetIsSupplier: boolean;
    procedure SetIsCustomer(const Value: boolean);
    procedure SetIsSupplier(const Value: boolean);
    function GetForeignVariationAccountId: integer;
    procedure SetForeignVariationAccountId(const Value: integer);
    function GetForeignVariationAccountName: string;
    procedure SetForeignVariationAccountName(const Value: string);
    function GetBalance: double;
    procedure SetBalance(const Value: double);
    function GetCredit: double;
    procedure SetCredit(const Value: double);
    function GetApplied: double;
    function GetUnapplied: double;
    procedure SetApplied(const Value: double);
    procedure SetUnapplied(const Value: double);
    function GetForeignCurrencyAmount: double;
    procedure SetForeignCurrencyAmount(const Value: double);
    function GetForeignVariationAmount: double;
    procedure SetForeignVariationAmount(const Value: double);
    function GetForeignApplied: double;
    function GetForeignUnapplied: double;
    procedure SetForeignApplied(const Value: double);
    procedure SetForeignUnapplied(const Value: double);
    function GetForeignExchangeCode: string;
    function GetForeignExchangeRate: double;
    procedure SetForeignExchangeCode(const Value: string);
    procedure SetForeignExchangeRate(const Value: double);
    function GetDeleted: boolean;
    procedure SetDeleted(const Value: boolean);
    function GetReconciliationId: integer;
    procedure SetReconciliationId(const Value: integer);
    function GetBankAccountBSB: string;
    function GetBankAccountName: string;
    function GetBankAccountNo: string;
    procedure SetBankAccountBSB(const Value: string);
    procedure SetBankAccountName(const Value: string);
    procedure SetBankAccountNo(const Value: string);
    function GetEnteredAt: TDateTime;
    procedure SetEnteredAt(const Value: TDateTime);
    function GetIsFCSelected: Boolean;
    function GetGLAccount: TAccount;
    function GetPaymentMethod: TPaymentMethod;
    function GetCleanDeleted: Boolean;
    function GetBankDeposit: TBankDeposit;
  protected
    AllLinesValid: Boolean;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    procedure SetCompanyName(const Value: string); virtual;
    procedure SetClientPrintName(const Value: string); virtual;
    function GetPayment: boolean; virtual; abstract;
    procedure SetPayment(Value: boolean); virtual; abstract;
    function GetExchageSellRate: double;
    function GetPaymentLines: TPaymentLine; virtual; abstract;
    Procedure CallbackCalcTotals(Const Sender: TBusObj; var Abort: Boolean); virtual;
    Function  SetTenderAccountID: Boolean;
    function GetExchageBuyRate: Double;
    function GetTransType: String; virtual; abstract;
  public
    ValidationStage: integer;
    class function GetIDField: String; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(Const node: IXMLNode); override;
    procedure SaveToXMLNode(Const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    procedure DoFieldOnChange(Sender: TField); override;
    { hide from published visibility }
    property DeptClassId: integer read GetDeptClassId write SetDeptClassId;
    property EmployeeId: integer read GetEmployeeId write SetEmployeeId;
    property AccountId: integer read GetAccountId write SetAccountId;
    property ForeignVariationAccountId: integer read GetForeignVariationAccountId write SetForeignVariationAccountId;
    property PaymentMethodId: integer read GetPaymentMethodId write SetPaymentMethodId;
    property IsCustomer: boolean read GetIsCustomer write SetIsCustomer;
    property IsSupplier: boolean read GetIsSupplier write SetIsSupplier;
    property IsFCSelected: Boolean read GetIsFCSelected;
    Procedure CalcTotals(const AdjustAmount: boolean = false); virtual;
    property PaymentLines: TPaymentLine read GetPaymentLines;
    Property GLAccount: TAccount Read GetGLAccount;
    Property PaymentMethod: TPaymentMethod read GetPaymentMethod;
    Property CleanDeleted: Boolean Read GetCleanDeleted;
    Property TransType: String Read GetTransType;
    Property Bankdeposit: TBankDeposit Read GetBankDeposit;
  published
    property PaymentNo: integer read GetPaymentNo write SetPaymentNo;
    property DeptClassName: string read GetDeptClassName write SetDeptClassName;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property AccountName: string read GetAccountName write SetAccountName;
    property ForeignValiationAccountName: string read GetForeignVariationAccountName write SetForeignVariationAccountName;
    property CompanyName: string read GetCompanyName write SetCompanyName;
    property ClientPrintName: string read GetClientPrintName write SetClientPrintName;
    property PaymentDate: TDateTime read GetPaymentDate write SetPaymentDate;
    property PaymentMethodName: string read GetPaymentMethodName write SetPaymentMethodName;
    property Notes: string read GetNotes write SetNotes;
    property ReferenceNo: string read GetReferenceNo write SetReferenceNo;
    property Payment: boolean read GetPayment write SetPayment;
    property Amount: double read GetAmount write SetAmount;
    property Balance: double read GetBalance write SetBalance;
    property Credit: double read GetCredit write SetCredit;
    property Applied: double read GetApplied write SetApplied;
    property Unapplied: double read GetUnapplied write SetUnapplied;
    property ForeignCurrencyAmount: double read GetForeignCurrencyAmount write SetForeignCurrencyAmount;
    property ForeignVariationAmount: double read GetForeignVariationAmount write SetForeignVariationAmount;
    property ForeignApplied: double read GetForeignApplied write SetForeignApplied;
    property ForeignUnapplied: double read GetForeignUnapplied write SetForeignUnapplied;
    property ForeignExchangeRate: double read GetForeignExchangeRate write SetForeignExchangeRate;
    property ForeignExchangeCode: string read GetForeignExchangeCode write SetForeignExchangeCode;
    property Deleted: boolean read GetDeleted write SetDeleted;
    property ReconciliationId: integer read GetReconciliationId write SetReconciliationId;
    property BankAccountName: string read GetBankAccountName write SetBankAccountName;
    property BankAccountBSB: string read GetBankAccountBSB write SetBankAccountBSB;
    property BankAccountNo: string read GetBankAccountNo write SetBankAccountNo;
    property EnteredAt: TDateTime read GetEnteredAt write SetEnteredAt;

    { unused fields }
    (*
    property CardholdersName
    property CreditCardNumber
    property CreditCardExpDate
    property PrintFlag
    property PrintedBy
    property EditedFlag
    property Employee: boolean
    property Contact: boolean
    property Reconciled: boolean
    property AppliedCredits: boolean
    property MSReceived: boolean
    property Finished: boolean
    *)
  end;

  TPaymentLine = class(TMSBusObj)
  private
    function GetTrnType: string;
    procedure SetTrnType(const Value: string);
    function GetAmountDue: double;
    function GetAmountOutstanding: double;
    function GetOriginalAmount: double;
    function GetPayment: double;
    procedure SetAmountDue(const Value: double);
    procedure SetAmountOutstanding(const Value: double);
    procedure SetOriginalAmount(const Value: double);
    procedure SetPayment(const Value: double);
    function GetPaidInFull: string;
    procedure SetPaidInFull(const Value: string);
    function GetForeignAmountDue: double;
    function GetForeignAmountOutstanding: double;
    function GetForeignOriginalAmount: double;
    function GetForeignPayment: double;
    procedure SetForeignAmountDue(const Value: double);
    procedure SetForeignAmountOutstanding(const Value: double);
    procedure SetForeignOriginalAmount(const Value: double);
    procedure SetForeignPayment(const Value: double);
    function GetPaymentId: integer;
    procedure SetPaymentId(const Value: integer);
  protected
    function DoBeforeOpen(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function GetDate: TDateTime; virtual; abstract;
    procedure SetDate(Value: TDateTime); virtual; abstract;
    function GetInvoiceNo: string;
    procedure SetInvoiceNo(const Value: string);
    function GetTransNo: string; virtual; abstract;
    procedure SetTransNo(const Value: string); virtual; abstract;
  public
    class function GetIDField: String; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(Const node: IXMLNode); override;
    procedure SaveToXMLNode(Const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    procedure DoFieldOnChange(Sender: TField); override;
    property PaymentId: integer read GetPaymentId write SetPaymentId;
  published
    property TrnType: string read GetTrnType write SetTrnType;
    property Date: TDateTime read GetDate write SetDate;
    property TransNo: string read GetTransNo write SetTransNo;
    property InvoiceNo: String Read GetInvoiceNo Write SetInvoiceNo;
    property OriginalAmount: double read GetOriginalAmount write SetOriginalAmount;
    property AmountDue: double read GetAmountDue write SetAmountDue;
    property Payment: double read GetPayment write SetPayment;
    property AmountOutstanding: double read GetAmountOutstanding write SetAmountOutstanding;
    property PaidInFull: string read GetPaidInFull write SetPaidInFull;    { Yes, No }
    property ForeignOriginalAmount: double read GetForeignOriginalAmount write SetForeignOriginalAmount;
    property ForeignAmountDue: double read GetForeignAmountDue write SetForeignAmountDue;
    property ForeignPayment: double read GetForeignPayment write SetForeignPayment;
    property ForeignAmountOutstanding: double read GetForeignAmountOutstanding write SetForeignAmountOutstanding;
    Property Payment_ID :Integer read getPaymentID;

    { unused fields }
    (*
    property EditedFlag: boolean
    property MSReceived: boolean
    *)
  end;

  TCustomerPaymentLine = class;

  TCustomerPayment = class(TPayment)
  private
    fAllLinesOk: boolean;
    function GetCustomerId: integer;
    procedure SetCustomerId(const Value: integer);
    function GetDeposited: boolean;
    procedure SetDeposited(const Value: boolean);
    function GetDepositId: integer;
    procedure SetDepositId(const Value: integer);
    function GetLines: TCustomerPaymentLine;
    function GetCustomer: TCustomer;
    function ProcessPayments: boolean;
    procedure ProcessPaymentLine(Const Sender: TBusObj; var Abort: Boolean);
    procedure CreateDeposits;
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    procedure SetCompanyName(const Value: string); override;
    procedure SetClientPrintName(const Value: string); override;
    function GetPayment: boolean; override;
    procedure SetPayment(Value: boolean); override;
    function GetPaymentLines: TPaymentLine; override;
    Procedure CallbackCalcTotals(Const Sender: TBusObj; var Abort: Boolean); override;
    function GetTransType: String; override;
  public
//    class function GetIDField: String; override;
    class function GetBusObjectTablename: String; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(Const node: IXMLNode); override;
    procedure SaveToXMLNode(Const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    procedure DoFieldOnChange(Sender: TField); override;
    property CustomerId: integer read GetCustomerId write SetCustomerId;
    property Customer: TCustomer read GetCustomer;
    Procedure CalcTotals(const AdjustAmount: boolean = false); override;
  published
    property Deposited: boolean read GetDeposited write SetDeposited;
    property DepositId: integer read GetDepositId write SetDepositId;
    property Lines: TCustomerPaymentLine read GetLines;
    { unused fields }
    (*
    property DepositedBalance: double
    property Deposit: boolean
    *)
  end;

  TCustomerPaymentLine = class(TPaymentLine)
  private
    function GetInvoiceId: integer;
    function GetPrepaymentId: integer;
    function GetRefundId: integer;
    procedure SetInvoiceId(const Value: integer);
    procedure SetPrepaymentId(const Value: integer);
    procedure SetRefundId(const Value: integer);
    function GetRefNo: string;
    procedure SetRefNo(const Value: string);
    function GetEnteredBy: string;
    procedure SetEnteredBy(const Value: string);
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function GetDate: TDateTime; override;
    procedure SetDate(Value: TDateTime); override;
    function GetTransNo: string; override;
    procedure SetTransNo(const Value: string); override;
  public
//    class function GetIDField: String; override;
    class function GetBusObjectTablename: String; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(Const node: IXMLNode); override;
    procedure SaveToXMLNode(Const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    procedure DoFieldOnChange(Sender: TField); override;
  published
    property InvoiceId: integer read GetInvoiceId write SetInvoiceId;
    property RefundId: integer read GetRefundId write SetRefundId;
    property PrepaymentId: integer read GetPrepaymentId write SetPrepaymentId;
    property RefNo: string read GetRefNo write SetRefNo;
    property EnteredBy: string read GetEnteredBy write SetEnteredBy;
  end;

  TSupplierPaymentLine = class;
  TSupplierPayment = class(TPayment)
  private
    LastSupplierID: integer;
    fbAddToEFT: boolean;
    fbAInvalid4EFT: Boolean;
    fbCInvalid4EFT: Boolean;
    function GetCheque: Boolean;
    function GetChequePrinted: Boolean;
    function GetContractorPayment: boolean;
    function GetInvoiceRefNo: String;
    function GetLines: TSupplierPaymentLine;
    function GetSupplier: TSupplier;
    function GetSupplierId: integer;
    procedure SetCheque(const Value: Boolean);
    procedure SetChequePrinted(const Value: Boolean);
    procedure SetContractorPayment(const Value: boolean);
    procedure SetInvoiceRefNo(const Value: String);
    procedure SetSupplierId(const Value: integer);
    procedure SetAddToEFT(const Value: boolean);
    procedure UpdateBalance;
    Procedure CorrectOtherPayments;
    function GetABAObj: TABADetailRecord;
    Procedure UpdateLastChequeNo;
    Procedure CreateDeposits;
//    fAllLinesOk: boolean;
//    function GetCustomerId: integer;
//    procedure SetCustomerId(const Value: integer);
//    function GetDeposited: boolean;
//    procedure SetDeposited(const Value: boolean);
//    function GetDepositId: integer;
//    procedure SetDepositId(const Value: integer);
//    function GetLines: TCustomerPaymentLine;
//    function GetCustomer: TCustomer;
//    function ProcessPayments: boolean;
//    procedure ProcessPaymentLine(Const Sender: TBusObj; var Abort: Boolean);
//    procedure CreateDeposits;
  protected
    function GetUseFC: Boolean;
    property UseFC: boolean read GetUseFC;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function ValidateLines: boolean;
    Function  GetPrepaymentAmount: Double;
    function GetTransType: String; override;
    procedure CallbackValidateLines(const Sender: TBusObj; var Abort: Boolean);
    Property  BankAccountInvalid4EFT: Boolean Read fbAInvalid4EFT Write fbAInvalid4EFT;
    Property  ClientInvalid4EFT: Boolean Read fbCInvalid4EFT Write fbCInvalid4EFT;
    function GetPayment: boolean; override;
    procedure SetPayment(Value: boolean); override;
//    procedure SetCompanyName(const Value: string); override;
//    procedure SetClientPrintName(const Value: string); override;
//    function GetPayment: boolean; override;
//    procedure SetPayment(Value: boolean); override;
    function GetPaymentLines: TPaymentLine; override;
//    Procedure CallbackCalcTotals(Const Sender: TBusObj; var Abort: Boolean); override;
  public
//    class function GetIDField: String; override;
    class function GetBusObjectTablename: String; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(Const node: IXMLNode); override;
    procedure SaveToXMLNode(Const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    procedure DoFieldOnChange(Sender: TField); override;
    property SupplierId: integer read GetSupplierId write SetSupplierId;
    property Supplier: TSupplier read GetSupplier;
    Property AddToEFT: boolean Read fbAddToEFT Write SetAddToEFT;
    Procedure UpdateBankDeposit(forceDeletion: Boolean = False);
    Property  ABAObj: TABADetailRecord  Read GetABAObj;
    Procedure CreateABARecord;
    Function  Valid4EFT(OpenDetailform : Boolean = False): Boolean;
    Procedure CalcTotals(const AdjustAmount: boolean = false); override;
  published
//    property Deposited: boolean read GetDeposited write SetDeposited;
//    property DepositId: integer read GetDepositId write SetDepositId;
    property InvoiceRefNo:String  Read GetInvoiceRefNo  Write SetInvoiceRefNo;
    property Cheque       :Boolean Read GetCheque        Write SetCheque;
    property ChequePrinted:Boolean Read GetChequePrinted Write SetChequePrinted;
    property ContractorPayment: boolean read GetContractorPayment write SetContractorPayment;
    property Lines: TSupplierPaymentLine read GetLines;
  end;

  TSupplierPaymentLine = class(TPaymentLine)
  private
    function GetDeptClassId: integer;
    function GetInvoiceDate: TDateTime;
    function GetPOID: Integer;
    procedure SetDeptClassId(const Value: integer);
    procedure SetInvoiceDate(const Value: TDateTime);
    procedure SetPOID(const Value: Integer);
    function GetPrepaymentId: integer;
    procedure SetPrepaymentId(const Value: integer);
    function GetDeptClassName: string;
    procedure SetDeptClassName(const Value: string);
//    function GetInvoiceId: integer;
//    function GetPrepaymentId: integer;
//    function GetRefundId: integer;
//    procedure SetInvoiceId(const Value: integer);
//    procedure SetPrepaymentId(const Value: integer);
//    procedure SetRefundId(const Value: integer);
//    function GetRefNo: string;
//    procedure SetRefNo(const Value: string);
//    function GetEnteredBy: string;
//    procedure SetEnteredBy(const Value: string);
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function GetDate: TDateTime; override;
    procedure SetDate(Value: TDateTime); override;
    function GetTransNo: string; override;
    procedure SetTransNo(const Value: string); override;
  public
//    class function GetIDField: String; override;
    class function GetBusObjectTablename: String; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(Const node: IXMLNode); override;
    procedure SaveToXMLNode(Const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    procedure DoFieldOnChange(Sender: TField); override;
    property DeptClassId: integer read GetDeptClassId write SetDeptClassId;
  published
//    property InvoiceId: integer read GetInvoiceId write SetInvoiceId;
//    property RefundId: integer read GetRefundId write SetRefundId;
//    property PrepaymentId: integer read GetPrepaymentId write SetPrepaymentId;
//    property RefNo: string read GetRefNo write SetRefNo;
//    property EnteredBy: string read GetEnteredBy write SetEnteredBy;
    property DeptClassName: string read GetDeptClassName write SetDeptClassName;
    property InvoiceDate:TDateTime Read GetInvoiceDate Write SetInvoiceDate;
    Property POID: Integer Read GetPOID Write SetPOID;
    property PrepaymentId: integer read GetPrepaymentId write SetPrepaymentId;
  end;


implementation

uses
  BusObjClass, BusObjEmployee, AppEnvironment, SysUtils,
  tcConst, ForeignExchangeObj, CommonLib, BusObjPrepayments,
  ERPDbComponents, Math, tcTypes, tcDatautils, BusObjConst,
  DbSharedObjectsObj, JsonObject, PaymentsLib;

var
  fdTotalAmount: double;


{ TPayment }

procedure TPayment.CalcTotals(const AdjustAmount: boolean);
begin
  Dataset.DisableControls;
  try
    Applied                 := 0;
    ForeignApplied          := 0;
    ForeignVariationAmount:= 0;
    ForeignApplied          := 0;
    ForeignUnApplied        := 0;
    fdTotalAmount           := 0;
    PaymentLines.IterateRecords(CallbackCalcTotals);
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
    PaymentLines.Dataset.EnableControls;
    Dataset.EnableControls;
  end;
end;

procedure TPayment.CallbackCalcTotals(const Sender: TBusObj;
  var Abort: Boolean);
begin
//  if not(Sender is TPaymentLine) then Exit;
  if IsFCSelected then begin
    ForeignApplied:= ForeignApplied + TPaymentLine(Sender).ForeignPayment;
  end;
  Applied := applied + TPaymentLine(Sender).Payment;
  if IsFCSelected then
    ForeignVariationAmount:=
          ForeignVariationAmount + (ForeignToLocal(TPaymentLine(Sender).ForeignPayment ,ForeignExchangeRate, CurrencyRoundPlaces) - TPaymentLine(Sender).Payment);
  fdTotalAmount := fdTotalAmount + TPaymentLine(Sender).Payment;
end;

constructor TPayment.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPayment.Destroy;
begin

  inherited;
end;

function TPayment.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if not Result  then Exit;
  EnteredAt                   := Now;
end;

function TPayment.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if PaymentNo = 0 then begin
    PaymentNo := Id;
    PostDB;
  end;
end;

procedure TPayment.DoFieldOnChange(Sender: TField);
begin
  inherited;

end;

function TPayment.GetAccountId: integer;
begin
  result := GetIntegerField('AccountId');
end;

function TPayment.GetAccountName: string;
begin
  if AccountId > 0 then
    result := TAccount.IDToggle(AccountId, Connection.Connection)
  else
    result := '';
end;

function TPayment.GetAmount: double;
begin
  result := GetFloatField('Amount');
end;

function TPayment.GetApplied: double;
begin
  result := GetFloatField('Applied');
end;

function TPayment.GetBalance: double;
begin
  result := GetFloatField('Balance');
end;

function TPayment.GetBankAccountBSB: string;
begin
  result := GetStringField('BankAccountBSB');
end;

function TPayment.GetBankAccountName: string;
begin
  result := GetStringField('BankAccountName');
end;

function TPayment.GetBankAccountNo: string;
begin
  result := GetStringField('BankAccountNo');
end;

function TPayment.GetBankDeposit: TBankDeposit;
begin
    PostDB;
    Result :=  TBankDeposit(getContainerComponent(TBankDeposit , 'Details.Trnstype = ' + quotedStr(TransType) + ' and Details.PaymentId = ' + IntToStr(ID)));
end;

function TPayment.GetCompanyName: string;
begin
  result := GetStringField('CompanyName');
end;
function TPayment.GetCleanDeleted: Boolean;
begin
  Result:= GetXMLNodeBooleanValue(CleanXMLNode, 'Deleted');
end;

function TPayment.GetClientPrintName: string;
begin
  result := GetStringField('ClientPrintName');
end;

function TPayment.GetCredit: double;
begin
  result := GetFloatField('Credit');
end;

function TPayment.GetDeleted: boolean;
begin
  result := GetBooleanField('Deleted');
end;

function TPayment.GetDeptClassId: integer;
begin
  result := GetIntegerField('ClassID');
end;

function TPayment.GetDeptClassName: string;
begin
  result := TDeptClass.IDToggle(DeptClassId, Connection.Connection);
end;

function TPayment.GetEmployeeId: integer;
begin
  result := GetIntegerField('EmployeeID');
end;

function TPayment.GetEmployeeName: string;
begin
  result := TEmployee.IDToggle(EmployeeId, Connection.Connection);
end;

function TPayment.GetEnteredAt: TDateTime;
begin
  result := GetDateTimeField('EnteredAt');
end;

function TPayment.GetExchageBuyRate: Double;
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

function TPayment.GetExchageSellRate: double;
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

function TPayment.GetForeignApplied: double;
begin
  result := GetFloatField('ForeignApplied');
end;

function TPayment.GetForeignCurrencyAmount: double;
begin
  result := GetFloatField('ForeignCurrencyAmount');
end;

function TPayment.GetForeignExchangeCode: string;
begin
  result := GetStringField('ForeignExchangeCode');
end;

function TPayment.GetForeignExchangeRate: double;
begin
  result := GetFloatField('ForeignExchangeRate');
end;

function TPayment.GetForeignUnapplied: double;
begin
  result := GetFloatField('ForeignUnApplied');
end;

function TPayment.GetForeignVariationAccountId: integer;
begin
  result := GetIntegerField('ForeignVariationAccountId');
end;

function TPayment.GetForeignVariationAccountName: string;
begin
  if ForeignVariationAccountId > 0 then
    result := TAccount.IDToggle(ForeignVariationAccountId, Connection.Connection)
  else
    result := '';
end;

function TPayment.GetForeignVariationAmount: double;
begin
  result := GetFloatField('ForeignVariationAmount');
end;

function TPayment.GetGLAccount: TAccount;
begin
  Result := TAccount(GetContainerComponent(TAccount , 'AccountId = ' + IntToStr(AccountId), SilentMode, False));
end;

class function TPayment.GetIDField: String;
begin
  result := 'PaymentID';
end;

function TPayment.GetIsCustomer: boolean;
begin
  result := GetBooleanField('Customer');
end;

function TPayment.GetIsFCSelected: Boolean;
begin
  Result := (ForeignExchangeCode <> '')  and
              (ForeignExchangeCode <> AppEnv.RegionalOptions.ForeignExDefault) ;
end;

function TPayment.GetIsSupplier: boolean;
begin
  result := GetBooleanField('Supplier');
end;

function TPayment.GetNotes: string;
begin
  result := GetStringField('Notes');
end;

function TPayment.GetPaymentDate: TDateTime;
begin
  result := GetDateTimeField('PaymentDate');
end;

function TPayment.GetPaymentMethod: TPaymentMethod;
begin
  Result := TPaymentMethod(Getcontainercomponent(TPaymentMethod , 'PayMethodID = ' + IntToStr(PaymentMethodID), SilentMode, False ));
end;

function TPayment.GetPaymentMethodId: integer;
begin
  result := GetIntegerField('PayMethodId');
end;

function TPayment.GetPaymentMethodName: string;
begin
  if PaymentMethodId > 0 then
    result := TPaymentMethod.IDToggle(PaymentMethodId, Connection.Connection)
  else
    result := '';
end;

function TPayment.GetPaymentNo: integer;
begin
  result := GetIntegerField('PaymentNo');
end;

function TPayment.GetReconciliationId: integer;
begin
  result := GetIntegerField('ReconciliationId');
end;

function TPayment.GetReferenceNo: string;
begin
  result := GetStringField('ReferenceNo');
end;

function TPayment.GetUnapplied: double;
begin
  result := GetFloatField('UnApplied');
end;

procedure TPayment.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PaymentNo');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'PaymentDate');
  SetPropertyFromNode(node,'Amount');
  SetPropertyFromNode(node,'PaymentMethodID');
  SetPropertyFromNode(node,'Notes');
  SetPropertyFromNode(node,'ReferenceNo');
//  SetPropertyFromNode(node,'CardholdersName');
//  SetPropertyFromNode(node,'CreditCardNumber');
//  SetPropertyFromNode(node,'CreditCardExpDate');
//  SetPropertyFromNode(node,'PrintFlag');
//  SetPropertyFromNode(node,'PrintedBy');
  SetPropertyFromNode(node,'DeptClassID');
  SetPropertyFromNode(node,'AccountID');
//  SetPropertyFromNode(node,'Customer');
//  SetPropertyFromNode(node,'Supplier');
//  SetPropertyFromNode(node,'Employee');
//  SetPropertyFromNode(node,'Contact');
  SetPropertyFromNode(node,'CompanyName');
  SetPropertyFromNode(node,'ClientPrintName');
//  SetPropertyFromNode(node,'AppliedCredits');
  SetPropertyFromNode(node,'Deleted');
//  SetPropertyFromNode(node,'Reconciled');
//  SetPropertyFromNode(node,'AmountDue');
  SetPropertyFromNode(node,'Credit');
  SetPropertyFromNode(node,'UnApplied');
  SetPropertyFromNode(node,'Applied');
  SetPropertyFromNode(node,'ReconciliationID');
//  SetPropertyFromNode(node,'Finished');
//  SetPropertyFromNode(node,'Statement');
//  SetPropertyFromNode(node,'MSReceived');
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
//  SetPropertyFromNode(node,'ClientID');
  SetPropertyFromNode(node,'Payment');
end;

function TPayment.Save: Boolean;
begin
  result := ValidateData;
  if not result then exit;

  result := inherited;

end;

procedure TPayment.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PaymentNo'                ,PaymentNo);
  AddXMLNode(node,'EmployeeID'               ,EmployeeID);
  AddXMLNode(node,'PaymentDate'              ,PaymentDate);
  AddXMLNode(node,'Amount'                   ,Amount);
  AddXMLNode(node,'PaymentMethodID'          ,PaymentMethodID);
  AddXMLNode(node,'Notes'                    ,Notes);
  AddXMLNode(node,'ReferenceNo'              ,ReferenceNo);
//  AddXMLNode(node,'CardholdersName'          ,CardholdersName);
//  AddXMLNode(node,'CreditCardNumber'         ,CreditCardNumber);
//  AddXMLNode(node,'CreditCardExpDate'        ,CreditCardExpDate);
//  AddXMLNode(node,'PrintFlag'                ,PrintFlag);
//  AddXMLNode(node,'PrintedBy'                ,PrintedBy);
  AddXMLNode(node,'DeptClassID'              ,DeptClassID);
  AddXMLNode(node,'AccountID'                ,AccountID);
//  AddXMLNode(node,'Customer'                 ,Customer);
//  AddXMLNode(node,'Supplier'                 ,Supplier);
//  AddXMLNode(node,'Employee'                 ,Employee);
//  AddXMLNode(node,'Contact'                  ,Contact);
  AddXMLNode(node,'CompanyName'              ,CompanyName);
  AddXMLNode(node,'ClientPrintName'          ,ClientPrintName);
//  AddXMLNode(node,'AppliedCredits'           ,AppliedCredits);
  AddXMLNode(node,'Deleted'                  ,Deleted);
//  AddXMLNode(node,'Reconciled'               ,Reconciled);
//  AddXMLNode(node,'AmountDue'                ,AmountDue);
  AddXMLNode(node,'Credit'                   ,Credit);
  AddXMLNode(node,'UnApplied'                ,UnApplied);
  AddXMLNode(node,'Applied'                  ,Applied);
  AddXMLNode(node,'ReconciliationID'         ,ReconciliationID);
//  AddXMLNode(node,'Finished'                 ,Finished);
//  AddXMLNode(node,'Statement'                ,Statement);
//  AddXMLNode(node,'MSReceived'               ,MSReceived);
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
//  AddXMLNode(node,'ClientID'                 ,ClientID);
  AddXMLNode(node,'Payment'                  ,Payment);
end;

procedure TPayment.SetAccountId(const Value: integer);
begin
  SetIntegerField('AccountId', Value);
end;

procedure TPayment.SetAccountName(const Value: string);
begin
  if Value <> '' then begin
    AccountId := TAccount.IDToggle(Value, Connection.Connection);
    if AccountId = 0 then
      AccountId := -1;
  end
  else
    AccountId := 0;
end;

procedure TPayment.SetAmount(const Value: double);
begin
  SetFloatField('Amount', Value);
end;

procedure TPayment.SetApplied(const Value: double);
begin
  SetFloatField('Applied', Value);
end;

procedure TPayment.SetBalance(const Value: double);
begin
  SetFloatField('Balance', Value);
end;

procedure TPayment.SetBankAccountBSB(const Value: string);
begin
  SetStringField('BankAccountBSB', Value);
end;

procedure TPayment.SetBankAccountName(const Value: string);
begin
  SetStringField('BankAccountName', Value);
end;

procedure TPayment.SetBankAccountNo(const Value: string);
begin
  SetStringField('BankAccountNo', Value);
end;

procedure TPayment.SetCompanyName(const Value: string);
begin
  SetStringField('CompanyName', Value);
end;
procedure TPayment.SetClientPrintName(const Value: string);
begin
  SetStringField('ClientPrintName', Value);
end;

procedure TPayment.SetCredit(const Value: double);
begin
  SetFloatField('Credit', Value);
end;

procedure TPayment.SetDeleted(const Value: boolean);
begin
  SetBooleanField('Deleted', Value);
end;

procedure TPayment.SetDeptClassId(const Value: integer);
begin
  SetIntegerField('ClassID', Value)
end;

procedure TPayment.SetDeptClassName(const Value: string);
begin
  if Value <> '' then begin
    DeptClassId := TDeptClass.IDToggle(Value, Connection.Connection);
    if DeptClassId = 0 then
      DeptClassId := -1;
  end
  else
    DeptClassId := 0;
end;

procedure TPayment.SetEmployeeId(const Value: integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

procedure TPayment.SetEmployeeName(const Value: string);
begin
  if Value <> '' then begin
    EmployeeId := TEmployee.IDToggle(Value, Connection.Connection);
    if EmployeeId = 0 then
      EmployeeId := -1;
  end
  else
    EmployeeId := 0;
end;

procedure TPayment.SetEnteredAt(const Value: TDateTime);
begin
  SetDateTimeField('EnteredAt', Value);
end;

procedure TPayment.SetForeignApplied(const Value: double);
begin
  SetFloatField('ForeignApplied', Value);
end;

procedure TPayment.SetForeignCurrencyAmount(const Value: double);
begin
  SetFloatField('ForeignCurrencyAmount', Value);
end;

procedure TPayment.SetForeignExchangeCode(const Value: string);
begin
  SetStringField('ForeignExchangeCode', Value);
end;

procedure TPayment.SetForeignExchangeRate(const Value: double);
begin
  SetFloatField('ForeignExchangeRate', Value);
end;

procedure TPayment.SetForeignUnapplied(const Value: double);
begin
  SetFloatField('ForeignUnApplied', Value);
end;

procedure TPayment.SetForeignVariationAccountId(const Value: integer);
begin
  SetIntegerField('ForeignVariationAccountId', Value);
end;

procedure TPayment.SetForeignVariationAccountName(const Value: string);
begin
  if Value <> '' then begin
    ForeignVariationAccountId := TAccount.IDToggle(Value, Connection.Connection);
    if ForeignVariationAccountId = 0 then
      ForeignVariationAccountId := -1;
  end
  else
    ForeignVariationAccountId := 0;
end;

procedure TPayment.SetForeignVariationAmount(const Value: double);
begin
  SetFloatField('ForeignVariationAmount', Value);
end;

procedure TPayment.SetIsCustomer(const Value: boolean);
begin
  SetBooleanField('Customer', Value);
end;

procedure TPayment.SetIsSupplier(const Value: boolean);
begin
  SetBooleanField('Supplier', Value);
end;

procedure TPayment.SetNotes(const Value: string);
begin
  SetStringField('Notes', Value);
end;

procedure TPayment.SetPaymentDate(const Value: TDateTime);
begin
  SetDateTimeField('PaymentDate', Value);
end;

procedure TPayment.SetPaymentMethodId(const Value: integer);
begin
  SetIntegerField('PayMethodId', Value);
end;

procedure TPayment.SetPaymentMethodName(const Value: string);
begin
  if Value <> '' then begin
    PaymentMethodId := TPaymentMethod.IDToggle(Value, Connection.Connection);
    if PaymentMethodId = 0 then
      PaymentMethodId := -1;
  end
  else
    PaymentMethodId := 0;
end;

procedure TPayment.SetPaymentNo(const Value: integer);
begin
  SetIntegerField('PaymentNo', Value);
end;

procedure TPayment.SetReconciliationId(const Value: integer);
begin
  SetIntegerField('ReconciliationId', Value);
end;

procedure TPayment.SetReferenceNo(const Value: string);
begin
  SetStringField('ReferenceNo', Value);
end;

function TPayment.SetTenderAccountID: Boolean;
var
    strSQL:String;
begin
    Result := False;
    strSQL:= 'SELECT  tbltenderaccountprefs.AccountId ' +
            ' FROM tbltenderaccountprefs  ' +
            ' INNER JOIN tblchartofaccounts COA USING(AccountID) ' +
            ' WHERE tbltenderaccountprefs.Active="T"  ' +
            ' AND COA.Active="T"  ' +
            ' AND PaymethodID = ' + IntToStr(PaymentMethodID);
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

procedure TPayment.SetUnapplied(const Value: double);
begin
  SetFloatField('UnApplied', Value);
end;

function TPayment.ValidateData: Boolean;
begin
  if Deleted then begin
    result := true;
    exit;
  end;
  result := inherited;
  if not result then exit;


  result := false;

  if DeptClassId = 0 then begin
    AddResult(false, rssInfo, 0, AppEnv.DefaultClass.ClassHeading + ' is blank.');
    exit;
  end;
  if DeptClassId < 0 then begin
    AddResult(false, rssInfo, 0, AppEnv.DefaultClass.ClassHeading + ' Name not found.');
    exit;
  end;
  if EmployeeId = 0 then begin
    AddResult(false, rssInfo, 0, 'Employee is blank.');
    exit;
  end;
  if EmployeeId < 0 then begin
    AddResult(false, rssInfo, 0, 'Employee Name not found.');
    exit;
  end;
  if AccountId = 0 then begin
    AddResult(false, rssInfo, 0, 'Account is blank.');
    exit;
  end;
  if AccountId < 0 then begin
    AddResult(false, rssInfo, 0, 'Account not found.');
    exit;
  end;
  if PaymentDate = 0 then begin
    AddResult(false, rssInfo, 0, 'Payment Date not set.');
    exit;
  end;
  if self.PaymentMethodId = 0 then begin
    AddResult(false, rssInfo, 0, 'Payment Method is blank.');
    exit;
  end;
  if self.PaymentMethodId < 0 then begin
    AddResult(false, rssInfo, 0, 'Payment Method not found.');
    exit;
  end;
  if (self.ForeignCurrencyAmount <> 0) or (self.ForeignVariationAmount <> 0) or
    (self.ForeignApplied <> 0) or (self.ForeignUnapplied <> 0) then begin
    if ForeignVariationAccountId = 0 then begin
      AddResult(false, rssInfo, 0, 'Foreign Variation Account is blank.');
      exit;
    end;
    if ForeignVariationAccountId < 0 then begin
      AddResult(false, rssInfo, 0, 'Foreign Variation Account not found.');
      exit;
    end;
    if self.ForeignExchangeCode = '' then begin
      AddResult(false, rssInfo, 0, 'Foreign Exchange Code is blank.');
      exit;
    end;
    if self.ForeignExchangeRate = 0 then begin
      AddResult(false, rssInfo, 0, 'Foreign Exchange Rate is blank.');
      exit;
    end;
  end;
  if (PaymentDate <= AppEnv.CompanyPrefs.ClosingDate) or (PaymentDate <= AppEnv.CompanyPrefs.ClosingDateAR) then begin
    AddResult(false, rssInfo, 0, 'Payment date is '+ LockMsgClosingDate +'.');
    exit;
  end;
  result := true;
end;

{ TPaymentLine }

constructor TPaymentLine.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPaymentLine.Destroy;
begin

  inherited;
end;

function TPaymentLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if not Result then Exit;

  if Assigned(Self.Owner) and (Self.Owner is TPayment) then begin
    PaymentId := TPayment(Self.Owner).ID;
  end;
end;

function TPaymentLine.DoBeforeOpen(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeOpen(Sender);
  if not result then exit;
  if not(Assigned(Owner))  then isreadonly := true;
end;

procedure TPaymentLine.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.Fieldname , 'Payment') then begin
    ForeignPayment := LocalToforeign(Payment, TPayment(Owner).ForeignExchangeRate, CurrencyRoundPlaces);
    AmountOutStanding := AmountDue - Payment;
    if Math.IsZero(AmountOutStanding, 0.00001) then PaidInFull := 'Yes'
    else PaidInFull := 'No';
    ForeignAmountOutStanding := LocalToForeign(AmountOutStanding , TPayment(Owner).ForeignExchangeRate , CurrencyRoundPlaces);
    TPayment(Owner).CalcTotals;
  end
  else if Sysutils.SameText(Sender.Fieldname , 'ForeignPayment') then begin
    Payment := ForeignToLocal(ForeignPayment, TPayment(Owner).ForeignExchangeRate, CurrencyRoundPlaces);
    AmountOutStanding := AmountDue - Payment;
    if Math.IsZero(AmountOutStanding, 0.00001) then PaidInFull := 'Yes'
    else PaidInFull := 'No';
    ForeignAmountOutStanding := LocalToForeign(AmountOutStanding , TPayment(Owner).ForeignExchangeRate , CurrencyRoundPlaces);
    TPayment(Owner).CalcTotals;
  end
  else if Sysutils.SameText(Sender.Fieldname , 'OriginalAmount') then begin
    ForeignOriginalAmount := LocalToForeign(OriginalAmount, TPayment(Owner).ForeignExchangeRate, CurrencyRoundPlaces);
  end
  else if Sysutils.SameText(Sender.Fieldname , 'AmountDue') then begin
    ForeignAmountDue := LocalToForeign(AmountDue, TPayment(Owner).ForeignExchangeRate, CurrencyRoundPlaces);
    AmountOutStanding := AmountDue - Payment;
    if Math.IsZero(AmountOutStanding, 0.00001) then PaidInFull := 'Yes'
    else PaidInFull := 'No';
    ForeignAmountOutStanding := LocalToForeign(AmountOutStanding , TPayment(Owner).ForeignExchangeRate , CurrencyRoundPlaces);
  end;
end;

function TPaymentLine.GetAmountDue: double;
begin
  result := GetFloatField('AmountDue');
end;

function TPaymentLine.GetAmountOutstanding: double;
begin
  result := GetFloatField('AmountOutstanding');
end;

function TPaymentLine.GetForeignAmountDue: double;
begin
  result := GetFloatField('ForeignAmountDue');
end;

function TPaymentLine.GetForeignAmountOutstanding: double;
begin
  result := GetFloatField('ForeignAmountOutstanding');
end;

function TPaymentLine.GetForeignOriginalAmount: double;
begin
  result := GetFloatField('ForeignOriginalAmount');
end;

function TPaymentLine.GetForeignPayment: double;
begin
  result := GetFloatField('ForeignPayment');
end;

class function TPaymentLine.GetIDField: String;
begin
  result := 'PaymentLineID';
end;

function TPaymentLine.GetInvoiceNo: string;
begin
  result := GetStringField('InvoiceNo');
end;

function TPaymentLine.GetOriginalAmount: double;
begin
  result := GetFloatField('OriginalAmount');
end;

function TPaymentLine.GetPaidInFull: string;
begin
  result := GetStringField('PaidInFull');
end;

function TPaymentLine.GetPayment: double;
begin
  result := GetFloatField('Payment');
end;

function TPaymentLine.GetPaymentId: integer;
begin
  result := GetIntegerField('PaymentID');
end;

function TPaymentLine.GetTrnType: string;
begin
  result := GetStringField('TrnType');
end;

procedure TPaymentLine.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

end;

function TPaymentLine.Save: Boolean;
begin
  result := inherited;
end;

procedure TPaymentLine.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TPaymentLine.SetAmountDue(const Value: double);
begin
  SetFloatField('AmountDue', Value);
end;

procedure TPaymentLine.SetAmountOutstanding(const Value: double);
begin
  SetFloatField('AmountOutstanding', Value);
end;

procedure TPaymentLine.SetForeignAmountDue(const Value: double);
begin
  SetFloatField('ForeignAmountDue', Value);
end;

procedure TPaymentLine.SetForeignAmountOutstanding(const Value: double);
begin
  SetFloatField('ForeignAmountOutstanding', Value);
end;

procedure TPaymentLine.SetForeignOriginalAmount(const Value: double);
begin
  SetFloatField('ForeignOriginalAmount', Value);
end;

procedure TPaymentLine.SetForeignPayment(const Value: double);
begin
  SetFloatField('ForeignPayment', Value);
end;

procedure TPaymentLine.SetInvoiceNo(const Value: string);
begin
  SetStringField('InvoiceNo', Value);
end;

procedure TPaymentLine.SetOriginalAmount(const Value: double);
begin
  SetFloatField('OriginalAmount', Value);
end;

procedure TPaymentLine.SetPaidInFull(const Value: string);
begin
  SetStringField('PaidInFull', Value);
end;

procedure TPaymentLine.SetPayment(const Value: double);
begin
  SetFloatField('Payment', Value);
end;

procedure TPaymentLine.SetPaymentId(const Value: integer);
begin
  SetIntegerField('PaymentID', Value);
end;

procedure TPaymentLine.SetTrnType(const Value: string);
begin
  SetStringField('TrnType', Value);
end;

function TPaymentLine.ValidateData: Boolean;
begin
  result := inherited;

end;

{ TCustomerPayment }

procedure TCustomerPayment.CalcTotals(const AdjustAmount: boolean);
begin
  Lines.PostDb;
  inherited;
end;

procedure TCustomerPayment.CallbackCalcTotals(const Sender: TBusObj;
  var Abort: Boolean);
begin
  inherited  CallbackCalcTotals(sender , abort);
end;

constructor TCustomerPayment.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'CustomerPayment';
  fSQL := 'SELECT * FROM tbldeposits';
end;

procedure TCustomerPayment.CreateDeposits;
var
  BankDeposit: TBankDeposit;
begin
  BankDeposit := TBankDeposit.Create(nil);
  try
    BankDeposit.Connection := self.Connection;
    {header}
    if Deleted then Exit;
    BankDeposit.New;
    BankDeposit.Depositdate          := PaymentDate;
    BankDeposit.PostDB;
    BankDeposit.EmployeeId           := EmployeeID;
    BankDeposit.classId              := DeptClassId;
    BankDeposit.AccountId            := AccountId;
    BankDeposit.Notes                := Notes;
    BankDeposit.Deposit              := amount;
    BankDeposit.Deleted              := False;
    BankDeposit.PostDB;
    {details}
    BankDeposit.Lines.New;
    BankDeposit.Lines.PaymentID      := Self.ID;
    BankDeposit.Lines.TrnsType       := 'Customer Payment';
    BankDeposit.Lines.CusID          := self.CustomerId;
    BankDeposit.Lines.PayMethodID    := PaymentMethodId;
    BankDeposit.Lines.PaymentMethod  := PaymentMethodName;
    BankDeposit.Lines.PaymentDate    := PaymentDate;
    BankDeposit.Lines.Companyname    := companyName;
    BankDeposit.Lines.Referenceno    := ReferenceNo;
    BankDeposit.Lines.ClassId        := DeptClassId;
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
  finally
    BankDeposit.Free;
  end;
end;

destructor TCustomerPayment.Destroy;
begin

  inherited;
end;

function TCustomerPayment.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if not Result then exit;
//  AutoApplyDiscount           := False;
  IsCustomer                  := True;
  Payment                     := True;
  PaymentDate                 := Date;
  DeptClassID                 := AppEnv.DefaultClass.ClassID;
  AccountID                   := AppEnv.CompanyPrefs.DefaultCustPaymentAccount;
  ForeignVariationAccountID   := AppEnv.CompanyPrefs.CustomerPaymentsDefaultVariationAccountID;
  ForeignExchangeCode         := AppEnv.RegionalOptions.ForeignExDefault;
  ForeignExchangeRate         := 1;
  Amount                      := 0;
  Credit                      := 0;
  Applied                     := 0;
  UnApplied                   := 0;
  Applied                     := 0;
  UnApplied                   := 0;
  ForeignApplied              := 0;
  ForeignUnApplied            := 0;
end;

procedure TCustomerPayment.DoFieldOnChange(Sender: TField);

  procedure UpdateForeign;
  begin
    ForeigncurrencyAmount := LocalToforeign(Amount, ForeignExchangeRate, CurrencyRoundPlaces);
    ForeignApplied        := LocalToforeign(Applied, ForeignExchangeRate, CurrencyRoundPlaces);
    ForeignUnApplied      := LocalToforeign(UnApplied, ForeignExchangeRate, CurrencyRoundPlaces);
  end;


begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.FieldName , 'Amount') then begin
      UnApplied := amount - Applied + ForeignVariationAmount;
      UpdateForeign;
    end
    else if Sysutils.SameText(Sender.FieldName , 'Applied') then begin
      UnApplied := amount - Applied + ForeignVariationAmount;
      UpdateForeign;
    end
    else if Sysutils.SameText(Sender.FieldName , 'UnApplied') then begin
      Applied := amount - UnApplied + ForeignVariationAmount;
      UpdateForeign;
    end
    else if Sysutils.SameText(Sender.FieldName , 'ForeigncurrencyAmount') then begin
      Amount              := ForeigntoLocal(ForeigncurrencyAmount , ForeignExchangeRate , CurrencyRoundPlaces);
      Foreignunapplied    := ForeigncurrencyAmount - Foreignapplied;
      UnApplied           := ForeigntoLocal(Foreignunapplied , ForeignExchangeRate , CurrencyRoundPlaces);
      UpdateForeign;
    end
    else if Sysutils.SameText(Sender.FieldName , 'Foreignapplied')        then begin
      Applied             := ForeigntoLocal(ForeignApplied        , ForeignExchangeRate , CurrencyRoundPlaces);
      Foreignunapplied    := ForeigncurrencyAmount - Foreignapplied;
      UnApplied           := ForeigntoLocal(Foreignunapplied , ForeignExchangeRate , CurrencyRoundPlaces);
      UpdateForeign;
    end
    else if Sysutils.SameText(Sender.FieldName , 'Foreignunapplied')      then begin
      unApplied           := ForeigntoLocal(ForeignunApplied      , ForeignExchangeRate , CurrencyRoundPlaces);
      Foreignapplied      := ForeigncurrencyAmount - Foreignunapplied ;
      Applied             := ForeigntoLocal(Foreignapplied , ForeignExchangeRate , CurrencyRoundPlaces);
      UpdateForeign;
    end
    else if Sysutils.SameText(sender.FieldName , 'CusID') then begin
      self.CompanyName := TCustomer.IDToggle(self.CustomerId, Connection.Connection);
      self.ClientPrintName := tcdatautils.clientPrintName(CompanyName);
      ForeignExchangeCode := Customer.ForeignExchangeCode;
      Balance := Customer.Balance;
      if ForeignExchangeCode = '' then ForeignExchangeCode := AppEnv.RegionalOptions.ForeignExDefault;
      ForeignExchangeRate := getExchageSellRate;
      Amount:= ForeigntoLocal(ForeigncurrencyAmount , ForeignExchangeRate , CurrencyRoundPlaces);
      UpdateForeign;
      CalcTotals;
    end    else if Sysutils.SameText(sender.FieldName , 'CompanyName') then begin
      self.CustomerId := TCustomer.IDToggle(self.CompanyName, Connection.Connection);
      self.ClientPrintName := tcdatautils.clientPrintName(CompanyName);
      ForeignExchangeCode := Customer.ForeignExchangeCode;
      Balance := Customer.ARBalance;
      if ForeignExchangeCode = '' then ForeignExchangeCode := AppEnv.RegionalOptions.ForeignExDefault;
      ForeignExchangeRate := getExchageSellRate;
      Amount:= ForeigntoLocal(ForeigncurrencyAmount , ForeignExchangeRate , CurrencyRoundPlaces);
      UpdateForeign;
      CalcTotals;
    end    else if Sysutils.SameText(sender.FieldName , 'ClientPrintName') then begin
      self.CustomerId := clientIDForPrintname(ClientPrintName);
      DofieldOnchange(dataset.findfield('Companyname'));
    end
    else if Sysutils.SameText(Sender.fieldname , 'ForeignExchangeCode') then begin
      ForeignExchangeRate := getExchageSellRate;
      Amount:= ForeigntoLocal(ForeigncurrencyAmount , ForeignExchangeRate , CurrencyRoundPlaces);
      UpdateForeign;
      CalcTotals;
    end
    else if Sysutils.SameText(Sender.FieldName , 'ForeignExchangeRate') then begin
      Amount:= ForeigntoLocal(ForeigncurrencyAmount , ForeignExchangeRate , CurrencyRoundPlaces);
      UpdateForeign;
      CalcTotals;
    end
    else if Sysutils.SameText(Sender.FieldName , 'Amount') then begin
      ForeigncurrencyAmount := CommonLib.LocalToForeign(Amount,ForeignExchangeRate, CurrencyRoundPlaces);
    end
    else if Sysutils.SameText(Sender.fieldName , 'ForeigncurrencyAmount') then begin
      Amount := ForeigntoLocal(ForeigncurrencyAmount , ForeignExchangeRate , CurrencyRoundPlaces);
    end
    else if Sysutils.SameText(Sender.fieldname , 'PaymentDate') then begin
      ForeignExchangeRate := getExchageSellRate;
      UpdateForeign;
      CalcTotals;
    end;
end;

class function TCustomerPayment.GetBusObjectTablename: String;
begin
  result := 'tbldeposits';

end;

function TCustomerPayment.GetCustomer: TCustomer;
begin
  Result := TCustomer(GetcontainerComponent(TCustomer , 'ClientId = ' + IntToStr(CustomerID)));
end;

function TCustomerPayment.GetCustomerId: integer;
begin
  result := GetIntegerField('CusID');
end;

function TCustomerPayment.GetDeposited: boolean;
begin
  result := GetBooleanField('Deposited');
end;

function TCustomerPayment.GetDepositId: integer;
begin
  result := GetIntegerField('DepositId');
end;

function TCustomerPayment.GetLines: TCustomerPaymentLine;
begin
  result:= TCustomerPaymentLine(GetPaymentLines);
//  Result := TCustomerPaymentLine(GetContainerComponent(TCustomerPaymentLine , 'PaymentID = ' + IntToStr(ID)));
end;

function TCustomerPayment.GetPayment: boolean;
begin
  result := GetBooleanField('CustomerPayment');
end;

function TCustomerPayment.GetPaymentLines: TPaymentLine;
begin
  Result := TCustomerPaymentLine(GetContainerComponent(TCustomerPaymentLine , 'PaymentID = ' + IntToStr(ID)));
end;

function TCustomerPayment.GetTransType: String;
begin
  Result := 'Customer Payment';
end;

procedure TCustomerPayment.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TCustomerPayment.ProcessPaymentLine(const Sender: TBusObj;
  var Abort: Boolean);
var
  line: TCustomerPaymentLine;
  invQry: TERPQuery;
begin
  line := TCustomerPaymentLine(Sender);
  { lock the invoice .. }
  if not UserLock.Lock('tblsales',line.InvoiceId) then begin
    Abort := true;
    fAllLinesOk := false;
    resultstatus.AddItem(false,rssWarning,0,'Unable to lock Invoice ' +
      IntToStr(line.InvoiceId) + ' for updating. ' + Userlock.LockMessage);
    exit;
  end;
  invQry := TERPQuery.Create(nil);
  try
    invQry.Connection := Connection.Connection;
    invQry.SQL.Add('select SaleID, SaleDate, TotalAmountInc, Balance, Payment, Paid, ClientID');
    invQry.SQL.Add('from tblSales where SaleID = ' + IntToStr(line.InvoiceId));
    invQry.Open;
    { validate .. }
    if invQry.FieldByName('Paid').AsBoolean then begin
      Abort := true;
      fAllLinesOk := false;
      resultstatus.AddItem(false,rssWarning,0,'Invoice ' +
        IntToStr(line.InvoiceId) + ' has already been paid.');
      exit;
    end;
    if line.Payment > invQry.FieldByName('Balance').AsFloat then begin
      Abort := true;
      fAllLinesOk := false;
      resultstatus.AddItem(false,rssWarning,0,'Invoice ' +
        IntToStr(line.InvoiceId) + ' payment amount ' + FormatFloat('#,##0.00;(#,##0.00)',line.Payment) +
        ' is greater than balance owing ' + FormatFloat('#,##0.00;(#,##0.00)',invQry.FieldByName('Balance').AsFloat));
      exit;
    end;
    { do it .. }
    line.OriginalAmount := Round(invQry.FieldByName('TotalAmountInc').AsFloat, CurrencyRoundPlaces);
    line.AmountDue := Round(invQry.FieldByName('Balance').AsFloat, CurrencyRoundPlaces);
    line.Date := invQry.FieldByName('SaleDate').AsDateTime;
    line.PostDb;
    invQry.Edit;
      invQry.FieldByName('Balance').AsFloat := Round(invQry.FieldByName('Balance').AsFloat - line.Payment, CurrencyRoundPlaces);
      if Math.IsZero(invQry.FieldByName('Balance').AsFloat, 0.0001) then begin
        invQry.FieldByName('Paid').AsBoolean := true;
      end;
    invQry.Post;
    PostList.AddAmount('TCustomer', TCustomer.GetBusObjectTablename, invQry.FieldByName('ClientId').AsInteger, -lines.Payment, btAR);

  finally
    invQry.Free;
  end;
end;

function TCustomerPayment.ProcessPayments: boolean;
var
  ARPaymentAmount: double;
begin
  fAllLinesOk := true;
  self.Lines.DoFieldChangewhenDisabled := true;
  self.Lines.IterateRecords(ProcessPaymentLine);
  result := fAllLinesOk;
  if result then begin
    { header postings }
    ARPaymentAmount  := Amount; // - PrepaymentAmount;
    if (AppEnv.CompanyPrefs.UseForeignCurrencyonSales) and (ISFCSelected) then
        ARPaymentAmount := ARPaymentAmount - ForeignVariationAmount;

    PostList.AddAmount('TAccount', TAccount.GetBusObjectTablename, tcDatautils.GetAccountReceivableID,-ARPaymentAmount,btnormal, False);
    PostList.AddAmount('TAccount', TAccount.GetBusObjectTablename, AccountID, Amount, btnormal, False);
    if (AppEnv.CompanyPrefs.UseForeignCurrencyonPO) and (ISFCSelected) then
      PostList.AddAmount('TAccount', TAccount.GetBusObjectTablename, ForeignVariationAccountID, ForeignVariationAmount, btnormal, False);
    result := PostList.Execute;
    if not result then begin
      self.ResultStatus.AddItem(false,rssWarning,0,PostList.ErrMsg);
      exit;
    end;
    CreateDeposits;
  end;
end;

function TCustomerPayment.Save: Boolean;
begin
  PostDb;
  ResultStatus.Clear;
  result := ValidateData;
  if not result then exit;
  result := inherited;
  if not result then exit;
  Connection.BeginNestedTransaction;
  if ProcessPayments then begin
    Connection.CommitNestedTransaction;
  end
  else begin
    result := false;
    Connection.RollbackNestedTransaction;
  end;

end;

procedure TCustomerPayment.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TCustomerPayment.SetCompanyName(const Value: string);
begin
  inherited;
  if Value <> '' then
    SetIntegerField('CusID', TCustomer.IDToggle(Value, Connection.Connection))
  else
    SetIntegerField('CusID',0);
end;
procedure TCustomerPayment.SetClientPrintName(const Value: string);
begin
  SetStringfield('ClientPrintName' , Value);
end;

procedure TCustomerPayment.SetCustomerId(const Value: integer);
begin
  SetIntegerField('CusID',Value);
  if Value > 0 then
    SetStringField('CompanyName', TCustomer.IDToggle(Value, Connection.Connection))
  else
    SetStringField('CompanyName', '');
end;

procedure TCustomerPayment.SetDeposited(const Value: boolean);
begin
  SetBooleanField('Deposited', Value);
end;

procedure TCustomerPayment.SetDepositId(const Value: integer);
begin
  SetIntegerField('DepositId', Value);
end;

procedure TCustomerPayment.SetPayment(Value: boolean);
begin
  SetBooleanField('CustomerPayment', Value);
end;

function TCustomerPayment.ValidateData: Boolean;
begin
  if Deleted then begin
    result := true;
    exit;
  end;
  result := inherited;
  if not result then exit;

  result := false;
  if (self.CompanyName = '') and (self.CustomerId = 0) then begin
    AddResult(false, rssInfo, 0, 'Customer is blank.');
    exit;
  end;
  if (self.CompanyName <> '') and (self.CustomerId = 0) then begin
    AddResult(false, rssInfo, 0, 'Customer ID not found for name ' + CompanyName);
    exit;
  end;
  if (self.CompanyName = '') and (self.CustomerId > 0) then begin
    AddResult(false, rssInfo, 0, 'Customer not found for Id ' + IntToStr(CustomerId));
    exit;
  end;



  result := true;
end;

{ TCustomerPaymentLine }

constructor TCustomerPaymentLine.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'CustomerPaymentLine';
  fSQL := 'SELECT * FROM tbldepositline';
  fIsList:= true;
end;

destructor TCustomerPaymentLine.Destroy;
begin

  inherited;
end;

function TCustomerPaymentLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if not Result then Exit;

  if Assigned(Self.Owner) and (Self.Owner is TCustomerPayment) then begin
    EnteredBy := TCustomerPayment(Self.Owner).EmployeeName;
  end;
end;

procedure TCustomerPaymentLine.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName , 'SaleID') then begin      { InvoiceId property }
    SetStringField('InvoiceNo', IntToStr(Sender.AsInteger));
  end
  else if Sysutils.SameText(Sender.FieldName , 'InvoiceNo') then begin

  end
end;

class function TCustomerPaymentLine.GetBusObjectTablename: String;
begin
  result := 'tbldepositline';

end;

function TCustomerPaymentLine.GetDate: TDateTime;
begin
  result := GetDateTimeField('InvoiceDate');
end;

function TCustomerPaymentLine.GetEnteredBy: string;
begin
  result := GetStringField('EnteredBy');
end;

function TCustomerPaymentLine.GetInvoiceId: integer;
begin
  if SameText(TrnType, tcConst.InvType) then
    result := GetIntegerField('SaleID')
  else
    result := 0;
end;

function TCustomerPaymentLine.GetPrepaymentId: integer;
begin
  if SameText(TrnType, tcConst.PrePayType) then
    result := GetIntegerField('PrePaymentID')
  else
    result := 0;
end;

function TCustomerPaymentLine.GetRefNo: string;
begin
  result := GetStringField('RefNo');
end;

function TCustomerPaymentLine.GetRefundId: integer;
begin
  if SameText(TrnType, tcConst.RefundType) then
    result := GetIntegerField('SaleID')
  else
    result := 0;
end;

function TCustomerPaymentLine.GetTransNo: string;
begin
  result := InvoiceNo;
end;

procedure TCustomerPaymentLine.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

end;

function TCustomerPaymentLine.Save: Boolean;
begin
  result := inherited;

end;

procedure TCustomerPaymentLine.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TCustomerPaymentLine.SetDate(Value: TDateTime);
begin
  SetDateTimeField('InvoiceDate', Value);
end;

procedure TCustomerPaymentLine.SetEnteredBy(const Value: string);
begin
  SetStringField('EnteredBy', Value);
end;

procedure TCustomerPaymentLine.SetInvoiceId(const Value: integer);
begin
  SetIntegerField('SaleID', Value);
  TrnType := tcConst.InvType;
end;

procedure TCustomerPaymentLine.SetPrepaymentId(const Value: integer);
begin
  SetIntegerField('PrePaymentID', Value);
  TrnType := tcConst.PrePayType;
end;

procedure TCustomerPaymentLine.SetRefNo(const Value: string);
begin
  SetStringField('RefNo', Value);
end;

procedure TCustomerPaymentLine.SetRefundId(const Value: integer);
begin
  SetIntegerField('SaleID', Value);
  TrnType := tcConst.RefundType;
end;

procedure TCustomerPaymentLine.SetTransNo(const Value: string);
begin
  InvoiceNo := Value;
end;

function TCustomerPaymentLine.ValidateData: Boolean;
begin
  result := inherited;
  if not result then exit;

  result := false;
  if self.InvoiceId > 1 then begin
    with self.GetNewDataSet('select saleid from tblsales where saleid = ' + IntToStr(InvoiceId) ,true) do begin
      try
        if IsEmpty then begin
          AddResult(false, rssInfo, 0, 'Invoice not found for Id ' + IntToStr(InvoiceId));
          exit;
        end;
      finally
        Free;
      end;
    end;
  end
  else if self.RefundId > 1 then begin
    with self.GetNewDataSet('select saleid from tblsales where saleid = ' + IntToStr(RefundId) ,true) do begin
      try
        if IsEmpty then begin
          AddResult(false, rssInfo, 0, 'Refund not found for Id ' + IntToStr(RefundId));
          exit;
        end;
      finally
        Free;
      end;
    end;
  end
  else if self.PrepaymentId > 1 then begin
    with self.GetNewDataSet('select prepaymentid from tblprepayments where prepaymentid = ' + IntToStr(PrepaymentId) ,true) do begin
      try
        if IsEmpty then begin
          AddResult(false, rssInfo, 0, 'Prepayment not found for Id ' + IntToStr(PrepaymentId));
          exit;
        end;
      finally
        Free;
      end;
    end;
  end
  else begin
    AddResult(false, rssInfo, 0, 'Invalid transaction type for Payment Line "' + TrnType + '"');
    exit;
  end;

  result := true;
end;

{ TSupplierPayment }

procedure TSupplierPayment.CalcTotals(const AdjustAmount: boolean);
begin
  Lines.PostDb;
  inherited;
end;

procedure TSupplierPayment.CallbackValidateLines(const Sender: TBusObj;
  var Abort: Boolean);
begin
  if not TSupplierPaymentLine(Sender).ValidateData then begin
    AllLinesValid:= false;
    Abort:= true;
  end;
end;

procedure TSupplierPayment.CorrectOtherPayments;
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

constructor TSupplierPayment.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  fbDiscountApplied         := False;
  fBusObjectTypeDescription:= 'SuppPayments';
  fSQL := 'SELECT * FROM tblwithdrawal';
//  AddToEFT := False;
//  fUpdatedPOList := TIntegerList.Create;
end;

procedure TSupplierPayment.CreateABARecord;
begin
    if (Deleted) then begin
        if ABAObj.count > 0 then ABAObj.DeleteAll;
        Exit;
    end;
    if (not(AddtoEFT)) then Exit;

    if ABAObj.count = 0 then ABAObj.New;
    ABAObj.RecordType               := '1';
    ABAObj.BSB                      := Supplier.BankAccountBSB;
    ABAObj.CreditDebitAccountNumber := Supplier.BankAccountNo;
    ABAObj.Indicator                := ' ';
    ABAObj.TransactionCode          := '50';
    ABAObj.TransCodeDesc            := 'Credit Items';
    ABAObj.Amount                   := Amount;
    ABAObj.AccountName              := Supplier.BankAccountName;
    ABAObj.TransType                := 'Supp Pay';
    if Supplier.BankLodgementRef <> '' then
      ABAObj.LodgementReferences := Supplier.BankLodgementRef
    else
      ABAObj.LodgementReferences      := ABAObj.TransType + ' ' + IntToStr(ID)+ ' ' + appenv.CompanyInfo.Companyname;
    ABAObj.Apply                    := False;
    ABAObj.AccountID                := AccountId;
    ABAObj.TransID                  := ID;
    ABAObj.NameofRemitter           := Self.CompanyName;
    ABAObj.PostDB;
end;

procedure TSupplierPayment.CreateDeposits;
begin
    {header}
    if Deleted then Exit;
    BankDeposit.New;
    BankDeposit.Depositdate          := PaymentDate;
    BankDeposit.PostDB;
    BankDeposit.EmployeeId           := EmployeeID;
    BankDeposit.classId              := DeptClassId;
    BankDeposit.AccountId            := AccountId;
    BankDeposit.Notes                := Notes;
    BankDeposit.Deposit              := -amount;
    BankDeposit.Deleted              := False;
    BankDeposit.PostDB;
    {details}
    BankDeposit.Lines.New;
    BankDeposit.Lines.PaymentID      := Self.ID;
    BankDeposit.Lines.TrnsType       := Transtype;
    BankDeposit.Lines.CusID          := SupplierID;
    BankDeposit.Lines.PayMethodID    := PaymentMethodID;
    BankDeposit.Lines.PaymentMethod  := tcDatautils.GetPaymentMethod(PaymentMethodID);
    BankDeposit.Lines.PaymentDate    := PaymentDate;
    BankDeposit.Lines.Companyname    := companyName;
    BankDeposit.Lines.Referenceno    := ReferenceNo;
    BankDeposit.Lines.ClassId        := DeptClassId;
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

destructor TSupplierPayment.Destroy;
begin

  inherited;
end;

function TSupplierPayment.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
    Result                      := inherited DoAfterInsert(Sender);
    if not Result then exit;
    IsSupplier                  := True;
    PaymentDate                 := Date;
    self.DeptClassId            := AppEnv.DefaultClass.ClassID;
    AccountID                   := AppEnv.CompanyPrefs.DefaultSuppPaymentAccount;
    ForeignVariationAccountID   := AppEnv.CompanyPrefs.SupplierPaymentsDefaultVariationAccountID;
    Amount                      := 0;
    Credit                      := 0;
    Applied                     := 0;
    UnApplied                   := 0;
    ForeignApplied              := 0;
    ForeignUnApplied            := 0;
    //Supplier                    := True;
    Payment                     := True;
    PaymentMethodId             := AppEnv.CompanyPrefs.DefaultPayMethodID;
    Cheque                      := False;
    ChequePrinted               := False;
end;

procedure TSupplierPayment.DoFieldOnChange(Sender: TField);
var
  str: String;

  Function Isamountfield: boolean;
  begin
    result := (SysUtils.SameText(Sender.Fieldname, 'Amount')) or
      (SysUtils.SameText(Sender.Fieldname, 'Applied')) or
      (SysUtils.SameText(Sender.Fieldname, 'UnApplied')) or
      (SysUtils.SameText(Sender.Fieldname, 'ForeigncurrencyAmount')) or
      (SysUtils.SameText(Sender.Fieldname, 'Foreignapplied')) or
      (SysUtils.SameText(Sender.Fieldname, 'Foreignunapplied'));
  END;

  Procedure UpdateAmounts;
  begin
    if SysUtils.SameText(Sender.Fieldname, 'Amount') then begin
      Unapplied := Amount - Applied + ForeignVariationAmount;
      if (UseFC) and IsFCSelected then begin
        ForeignUnapplied := ForeignCurrencyAmount - ForeignApplied;
      end;
    end
    else if SysUtils.SameText(Sender.Fieldname, 'Applied') then begin
      Unapplied := Amount - Applied + ForeignVariationAmount;
    end
    else if SysUtils.SameText(Sender.Fieldname, 'UnApplied') then begin
      Applied := Amount - Unapplied + ForeignVariationAmount;
    end
    else if SysUtils.SameText(Sender.Fieldname, 'ForeigncurrencyAmount') then begin
      Amount := ForeignToLocal(ForeignCurrencyAmount, ForeignExchangeRate, CurrencyRoundPlaces);
      ForeignUnapplied := ForeignCurrencyAmount - ForeignApplied;
      Unapplied := ForeignToLocal(ForeignUnapplied, ForeignExchangeRate, CurrencyRoundPlaces);
    end
    else if SysUtils.SameText(Sender.Fieldname, 'Foreignapplied') then begin
      Applied := ForeignToLocal(ForeignApplied, ForeignExchangeRate, CurrencyRoundPlaces);
      ForeignUnapplied := ForeignCurrencyAmount - ForeignApplied;
      Unapplied := ForeignToLocal(ForeignUnapplied, ForeignExchangeRate, CurrencyRoundPlaces);
    end
    else if SysUtils.SameText(Sender.Fieldname, 'Foreignunapplied') then begin
      Unapplied := ForeignToLocal(ForeignUnapplied, ForeignExchangeRate, CurrencyRoundPlaces);
      ForeignApplied := ForeignCurrencyAmount - ForeignUnapplied;
      Applied := ForeignToLocal(ForeignApplied, ForeignExchangeRate, CurrencyRoundPlaces);
    End;
    if IsFCSelected = false then begin
      ForeignCurrencyAmount := Localtoforeign(Amount, ForeignExchangeRate, CurrencyRoundPlaces);
      ForeignApplied := Localtoforeign(Applied, ForeignExchangeRate, CurrencyRoundPlaces);
      ForeignUnapplied := Localtoforeign(Unapplied, ForeignExchangeRate, CurrencyRoundPlaces);
    End;
  end;

begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then
      Exit; // we are only interested in data fields.
  inherited;
  { -- } if SysUtils.SameText(Sender.Fieldname, 'SupplierID') or
    SysUtils.SameText(Sender.Fieldname, 'CompanyName') (* or
    Binny : Since clientPrintname is not unique, not possible to get clietnId for the printname
    Sysutils.SameText(sender.FieldName , 'ClientPrintName') *) then begin
    if SysUtils.SameText(Sender.Fieldname, 'CompanyName') then begin
      SupplierID := TClient.IDToggle(Sender.AsString, Connection.Connection);
      ClientPrintName := tcdatautils.clientPrintName(CompanyName);
      (* end else if Sysutils.SameText(sender.FieldName , 'ClientPrintName') then begin
        clientId := tcdatautils.clientIDForPrintname(ClientPrintName); *)
    end;
    UserLock.UnLock('SuppPaymentClientLock');
    if LastSupplierID <> SupplierID then begin
      if not UserLock.Lock('SupplierPaymentClient', SupplierID, 'SuppPaymentClientLock') then begin
        Sender.Clear; // AsInteger:= 0;
        SendEvent(BusObjEvent_Change, BusobjEventVal_ClientUserLockFail, self);
      end;
      LastSupplierID := SupplierID;
    end;
    if Supplier.PayMethodID <> 0 then
      PaymentMethodID := Supplier.PayMethodID;
    if Supplier.PaymentMethodName = 'E.F.T.' then begin
      AddToEFT := true;
      SendEvent(BusObjEvent_Change, BusobjEventVal_AddToEFT);
    end;
    Balance := - Supplier.APBalance;
    ForeignExchangeCode := Supplier.ForeignExchangeCode;
    if ForeignExchangeCode = '' then
      ForeignExchangeCode := AppEnv.RegionalOptions.ForeignExDefault;
    DoFieldOnChange(Dataset.findfield('ForeignExchangeCode'));
    ContractorPayment := Supplier.Contractor;
    if SysUtils.SameText(tcDatautils.GetPaymentMethod(PaymentMethodID), 'Cheque') then
      if ReferenceNo = '' then
        if GLAccount.UseLastChequeNo then
          // ReferenceNo:= IntToStr(GLAccount.LastChequeNo+1);
          ReferenceNo := IntToStr(GLAccount.Previouschequeno + 1);
    SendEvent(BusObjEvent_Change, BusObjEventVal_ClientID, self);
    { -- } end
  else if SysUtils.SameText(Sender.Fieldname, 'PaymethodID') then begin
    if setTenderAccountID then begin
      { done }
    end
    else begin
      if PaymentMethod.IsCreditCard then
        AccountId := AppEnv.CompanyPrefs.DefaultCCardPaymentAccount
      else
        AccountId := AppEnv.CompanyPrefs.DefaultSuppPaymentAccount;
    end;
    if SysUtils.SameText(tcDatautils.GetPaymentMethod(PaymentMethodID), 'Cheque') then
      if (AppEnv.CompanyPrefs.UseAutoChequeNo) and (ReferenceNo = '') then
        ReferenceNo := IntToStr(GLAccount.Previouschequeno + 1);
    { -- } end
  else if SysUtils.SameText(Sender.Fieldname, 'ForeignExchangeCode') then begin
    ForeignExchangeRate := getExchageBuyRate;
    Amount := ForeignToLocal(ForeignCurrencyAmount, ForeignExchangeRate, CurrencyRoundPlaces);
//    GuiLines.IterateRecords(ValidateFCofapplied);
//    if Assigned(ChangeDisplayLabel) then
//      ChangeDisplayLabel;
    CalcTotals;
    { -- } end
  else if SysUtils.SameText(Sender.Fieldname, 'AccountID') then begin
    if SysUtils.SameText(tcDatautils.GetPaymentMethod(PaymentMethodID), 'Cheque') then
      if ReferenceNo = '' then
        if GLAccount.UseLastChequeNo then
          ReferenceNo := IntToStr(GLAccount.Previouschequeno + 1);
    { -- } end
  else if SysUtils.SameText(Sender.Fieldname, 'PaymentDate') then begin
    if (PaymentDate <= AppEnv.CompanyPrefs.ClosingDate) or
      (PaymentDate <= AppEnv.CompanyPrefs.ClosingDateAP) then begin
      str := 'You have set this date before the closing date.  ' +
        'The date will automatically be set to today''s date OR ' +
        'reset the Closing Date In Preferences.';
      AddResult(true, rssInfo, 0, str);
      PaymentDate := Now;
    end;
    ForeignExchangeRate := getExchageBuyRate;
    DoFieldOnChange(Dataset.findfield('ForeignExchangeRate'));
    { -- } end
  else if SysUtils.SameText(Sender.Fieldname, 'ForeignExchangeRate') then begin
    if IsFCSelected then begin
      Amount := ForeignToLocal(ForeignCurrencyAmount, ForeignExchangeRate, CurrencyRoundPlaces);
      CalcTotals;
    end;
    { -- } end
  else if SysUtils.SameText(Sender.Fieldname, 'Amount') then begin
    if Amount <> 0 then begin
      if (UseFC) and IsFCSelected then begin
        { XML import will calculate the rate without any confirmation - IANOS }
        if Math.IsZero(ForeignExchangeRate, 0.000001) then begin
          if (ForeignCurrencyAmount <> 0) then begin
//             and
//            ((not(Assigned(ConfirmFromGUI))) or
//            (fconfirmFromGUI
//            ('Do you wish to Calculate the Exchange Rate Based on the Foreign Amount Divided by the Payment Amount?',
//            [mbYes, mbNo]) = mrYes)) then begin
            if Amount <> 0 then
              ForeignExchangeRate := ForeignCurrencyAmount / Amount;
          end
          else begin
            ForeignExchangeRate := getExchageBuyRate;
          end;
        end
        else if (Amount <> 0) and (ForeignCurrencyAmount <> 0) then begin
//          and (Assigned(ConfirmFromGUI)) and
//          (fconfirmFromGUI
//          ('Do you wish to Re-calculate the Exchange Rate Based on the Foreign Amount Divided by the Payment Amount?',
//          [mbYes, mbNo]) = mrYes) then begin
          { need an option to recalculate the exchange rate in any case : DENE }
          ForeignExchangeRate := ForeignCurrencyAmount / Amount;
        end;
        ForeignCurrencyAmount := CommonLib.Localtoforeign(Amount, ForeignExchangeRate,
          CurrencyRoundPlaces);
        CalcTotals();
      End;
    end;
    if (Dataset.state = dsInsert) and (Amount = 0) then
    else begin
      if IsFCSelected then
        ForeignCurrencyAmount := Localtoforeign(Amount, ForeignExchangeRate, CurrencyRoundPlaces);
    end;
    { -- } end
  else if SysUtils.SameText(Sender.Fieldname, 'ForeigncurrencyAmount') then begin
    if (Dataset.state = dsInsert) and (ForeignCurrencyAmount = 0) then
    else begin
      Amount := ForeignToLocal(ForeignCurrencyAmount, ForeignExchangeRate, CurrencyRoundPlaces);
    end;
    { -- } end
  else if SysUtils.SameText(Sender.Fieldname, 'ReferenceNo') then begin
    SendEvent(BusObjEvent_Change, BusObjEvent_PaymentRefno, self);
    { -- } end;
  if Isamountfield then
    UpdateAmounts;
end;

function TSupplierPayment.GetABAObj: TABADetailRecord;
begin
  Result := TABADetailRecord(GetContainerComponent(TABADetailRecord , 'TransID = ' + IntToStr(ID) + ' and TransType = ' + QuotedStr('Supp Pay')));
end;

class function TSupplierPayment.GetBusObjectTablename: String;
begin
  Result:= 'tblwithdrawal';
end;

function TSupplierPayment.GetCheque: Boolean;
begin
  Result := GetBooleanField('Cheque');
end;

function TSupplierPayment.GetChequePrinted: Boolean;
begin
  result := GetBooleanField('ChequePrinted');
end;

function TSupplierPayment.GetContractorPayment: boolean;
begin
  result := GetBooleanField('ContractorPayment');
end;

function TSupplierPayment.GetInvoiceRefNo: String;
begin
  result := GetStringField('InvoiceRefNo');
end;

function TSupplierPayment.GetLines: TSupplierPaymentLine;
begin
  Result := TSupplierPaymentLine(GetContainerComponent(TSupplierPaymentLine , 'PaymentID = ' + IntToStr(ID)));
end;

function TSupplierPayment.GetPayment: boolean;
begin
  result := GetBooleanField('SupplierPayment');
end;

function TSupplierPayment.GetPaymentLines: TPaymentLine;
begin
  Result := TSupplierPaymentLine(GetContainerComponent(TSupplierPaymentLine , 'PaymentID = ' + IntToStr(ID)));
end;

function TSupplierPayment.GetPrepaymentAmount: Double;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := Connection.Connection;
    qry.SQL.Add('select sum(amountOutstanding) as Amount from ' + Lines.GetBusObjectTablename );
    qry.SQL.Add('where PaymentID = ' + IntToStr(ID));
    qry.SQL.Add('and PrePaymentID > 0');
    qry.Open;
    result := qry.FieldByName('Amount').AsFloat;
  finally
    qry.Free;
  end;
end;

function TSupplierPayment.GetSupplier: TSupplier;
begin
  Result := TSupplier(GetcontainerComponent(TSupplier , 'ClientId = ' + IntToStr(SupplierID)));
end;

function TSupplierPayment.GetSupplierId: integer;
begin
  result := GetIntegerField('SupplierID');
end;

function TSupplierPayment.GetTransType: String;
begin
  Result := 'Supplier Payment';
end;

function TSupplierPayment.GetUseFC: Boolean;
begin
  Result := (AppEnv.CompanyPrefs.UseForeignCurrencyOnPO);
end;

procedure TSupplierPayment.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'InvoiceRefNo');
  SetPropertyFromNode(node,'Cheque');
  SetPropertyFromNode(node,'ChequePrinted');
end;

function TSupplierPayment.Save: Boolean;
begin
    ValidationStage:= 1;
    PostDB;
    result:= validateData;
    if not result then Exit;
    result := Inherited Save;
    if not result then Exit;
    self.Connection.BeginNestedTransaction;
    try
      PostList.Clear;
      IsNew := Lines.count = 0;
      postDB;
//      if isnew then Createlines;
//      UpdateLines;
      UpdateBalance;
      updateBankdeposit;
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
        self.Connection.RollbackNestedTransaction;
        Lines.Closedb;
        Lines;
      end;
    end;
    self.Connection.CommitNestedTransaction;
    ValidationStage:= 2;
    if not self.ValidateLines then begin
      result:= false;
      exit;
    end;
end;

procedure TSupplierPayment.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'InvoiceRefNo'    ,InvoiceRefNo);
  AddXMLNode(node,'Cheque'          ,Cheque);
  AddXMLNode(node,'ChequePrinted'   ,ChequePrinted);
end;

procedure TSupplierPayment.SetAddToEFT(const Value: boolean);
begin
  fbAddToEFT := Value;
end;

procedure TSupplierPayment.SetCheque(const Value: Boolean);
begin
  SetBooleanField('Cheque', Value);
end;

procedure TSupplierPayment.SetChequePrinted(const Value: Boolean);
begin
  SetBooleanField('ChequePrinted', Value);
end;

procedure TSupplierPayment.SetContractorPayment(const Value: boolean);
begin
  SetBooleanField('ContractorPayment', Value);
end;

procedure TSupplierPayment.SetInvoiceRefNo(const Value: String);
begin
  SetStringField('InvoiceRefNo', Value);
end;

procedure TSupplierPayment.SetPayment(Value: boolean);
begin
  SetBooleanField('SupplierPayment', Value);
end;

procedure TSupplierPayment.SetSupplierId(const Value: integer);
begin
  SetIntegerField('SupplierID', Value);
end;

procedure TSupplierPayment.UpdateBalance;
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
//    GuiLines.IterateREcords(UpdateclientBalance);
end;

procedure TSupplierPayment.UpdateBankDeposit(forceDeletion: Boolean);
var
  cmd: TERPCommand;
begin
    if not IsNew then begin
      cmd := DbSharedObj.GetCommand(self.Connection.Connection);
      try
        cmd.SQL.Add('update tblbankdepositlines');
        cmd.SQL.Add('set ReferenceNo = ' + QuotedStr(self.ReferenceNo));
        cmd.SQL.Add('where TrnsType = "Supplier Payment"');
        cmd.SQL.Add('and PaymentID = ' + IntToStr(self.ID));
        cmd.Execute;
      finally
        DbSharedObj.ReleaseObj(cmd);
      end;
    end;
    if (not isnew) and (cleanDeleted = Deleted ) then if forceDeletion =False then Exit;

    if Deleted then begin
        PostList.AddQuery('Delete  tblbankdeposit.*   ' +
             ' FROM tblbankdeposit ' +
             ' INNER JOIN tblbankdepositlines  ' +
             ' ON  tblbankdepositlines.DepositID = tblbankdeposit.DepositID ' +
             ' WHERE tblbankdepositlines.PaymentID =' + IntToStr(ID) +
             ' AND tblbankdepositlines.TrnsType =' + QuotedStr(TransType));
        PostList.AddQuery('Delete  tblbankdepositlines.*   ' +
             ' FROM tblbankdepositlines ' +
             ' WHERE tblbankdepositlines.PaymentID =' + IntToStr(ID) +
             ' AND tblbankdepositlines.TrnsType =' + quotedStr(TransType));
    end else if (Sysutils.SameText(tcDatautils.GetAccountName(AccountID),UNDEPOSITED_FUNDS)) then
    else begin
        CreateDeposits;
    end;
    PostDB;
end;

procedure TSupplierPayment.UpdateLastChequeNo;
begin
  {this is outside transaction and is ignored if cannot be locked}
    if Sysutils.SameText(tcDatautils.GetPaymentMethod(PaymentMethodID) , 'Cheque') then
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

function TSupplierPayment.Valid4EFT(OpenDetailform: Boolean): Boolean;
begin
    Result := true;
    if self.SupplierID < 1 then
      exit;
    BankAccountInvalid4EFT  := False;
    ClientInvalid4EFT       := False;
    if not AddtoEFT then exit;
    Supplier.Closedb; { force supplier to reload its data (in case user has just updated bank details) }
    if not Supplier.ValidEFTSupplier then begin
        AddResult(false, rssWarning, 0, 'This Supplier does not have all the Required Bank Account' + chr(13) +
                                'Details to use Electronic Funds Transfer !');
        Result := False;
        ClientInvalid4EFT := True;
//        if OpenDetailform then if Assigned(fGetEFTDetails) then GetEFTDetails;
        Exit;
    end;
    GLAccount.Closedb;
    if not GLAccount.ValidEFTAccount then begin
        AddResult(false, rssWarning, 0, 'The GL Bank Account ('+ GLAccount.AccountName +')  does not have all the Required Bank Account' + chr(13) +
                                'Details to use Electronic Funds Transfer !');
        Result := False;
        BankAccountInvalid4EFT := true;
//        if OpenDetailform then if Assigned(fGetEFTDetails) then GetEFTDetails;
        Exit;
    end;
end;

function TSupplierPayment.ValidateData: Boolean;
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
    if SupplierId = 0 then begin
        AddResult(True, rssinfo, 0 , 'supplier should not be blank');
        Result := False;
        Exit;
    end;
    if PaymentMethodID = 0 then begin
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

function TSupplierPayment.ValidateLines: boolean;
begin
  AllLinesValid:= true;
  Lines.IterateRecords(self.CallbackValidateLines);
  result:= AllLinesValid;
end;

{ TSupplierPaymentLine }

constructor TSupplierPaymentLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SuppPaymentLines';
  fSQL := 'SELECT * FROM tblwithdrawallines';
end;

destructor TSupplierPaymentLine.Destroy;
begin

  inherited;
end;

function TSupplierPaymentLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if Owner is TSupplierPayment then
    self.DeptClassId := TSupplierPayment(Owner).DeptClassId;
end;

procedure TSupplierPaymentLine.DoFieldOnChange(Sender: TField);
begin
  inherited;

end;

class function TSupplierPaymentLine.GetBusObjectTablename: String;
begin
  Result := 'tblwithdrawallines';
end;

function TSupplierPaymentLine.GetDate: TDateTime;
begin
  result := GetDateTimeField('OrderDate');
end;

function TSupplierPaymentLine.GetDeptClassId: integer;
begin
  Result := GetIntegerField('ClassID');
end;

function TSupplierPaymentLine.GetDeptClassName: string;
begin
  result := TDeptClass.IDToggle(DeptClassId, Connection.Connection);
end;

function TSupplierPaymentLine.GetInvoiceDate: TDateTime;
begin
  Result := GetDateTimeField('InvoiceDate');
end;

function TSupplierPaymentLine.GetPOID: Integer;
begin
  Result := GetIntegerField('POID');
end;

function TSupplierPaymentLine.GetPrepaymentId: integer;
begin
  result := GetIntegerField('PrepaymentID');
end;

function TSupplierPaymentLine.GetTransNo: string;
begin
  Result := GetStringField('PONo');
end;

procedure TSupplierPaymentLine.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'InvoiceNo');
  SetPropertyFromNode(node,'DeptClassID');
  SetPropertyFromNode(node,'InvoiceDate');

end;

function TSupplierPaymentLine.Save: Boolean;
begin
  result := inherited;
end;

procedure TSupplierPaymentLine.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'InvoiceNo'   ,InvoiceNo);
  AddXMLNode(node,'DeptClassID' ,DeptClassID);
  AddXMLNode(node,'InvoiceDate' ,InvoiceDate);
  AddXMLNode(node,'TransID'     ,POID);
end;

procedure TSupplierPaymentLine.SetDate(Value: TDateTime);
begin
  SetDateTimeField('OrderDate', Value);
end;

procedure TSupplierPaymentLine.SetDeptClassId(const Value: integer);
begin
  SetIntegerField('ClassID', Value);
end;

procedure TSupplierPaymentLine.SetDeptClassName(const Value: string);
begin
  if Value <> '' then begin
    DeptClassId := TDeptClass.IDToggle(Value, Connection.Connection);
  end
  else
    DeptClassId := 0;
end;

procedure TSupplierPaymentLine.SetInvoiceDate(const Value: TDateTime);
begin
  SetDateTimeField('InvoiceDate', Value);
end;

procedure TSupplierPaymentLine.SetPOID(const Value: Integer);
var
  qry: TERPQuery;
begin
  SetIntegerField('POID', Value);

  qry := TERPQuery.Create(nil);
  try
    qry.Connection := Self.Connection.Connection;
    qry.SQL.Text := 'select * from tblPurchaseOrders where PurchaseOrderID = ' + IntToStr(Value);
    qry.Open;
    if not qry.IsEmpty then begin
      if qry.FieldByName('IsPO').AsBoolean then begin
        TrnType := tcConst.POType;
        TransNo := qry.FieldByName('PurchaseOrderNumber').AsString;
        Date := qry.FieldByName('OrderDate').AsDateTime;
        InvoiceNo := qry.FieldByName('InvoiceNumber').AsString;
        AmountDue := qry.FieldByName('Balance').AsFloat;
        OriginalAmount := qry.FieldByName('TotalAmountInc').AsFloat;
      end
      else if qry.FieldByName('IsRA').AsBoolean then begin
        { error .. no amounts on RA }
      end
      else if qry.FieldByName('IsBill').AsBoolean then begin
        TrnType := tcConst.BillType;
        TransNo := qry.FieldByName('PurchaseOrderNumber').AsString;
        Date := qry.FieldByName('OrderDate').AsDateTime;
        InvoiceNo := qry.FieldByName('InvoiceNumber').AsString;
        AmountDue := qry.FieldByName('Balance').AsFloat;
        OriginalAmount := qry.FieldByName('TotalAmountInc').AsFloat;
      end
      else if qry.FieldByName('IsCredit').AsBoolean then begin
        TrnType := tcConst.CreditType;
        TransNo := qry.FieldByName('PurchaseOrderNumber').AsString;
        Date := qry.FieldByName('OrderDate').AsDateTime;
        InvoiceNo := qry.FieldByName('InvoiceNumber').AsString;
        AmountDue := qry.FieldByName('Balance').AsFloat;
        OriginalAmount := qry.FieldByName('TotalAmountInc').AsFloat;
      end
      else if qry.FieldByName('IsCheque').AsBoolean then begin
        { error .. cant have in supp payment }
      end
      else if qry.FieldByName('IsRefundCheque').AsBoolean then begin
        { error .. cant have in supp payment }
      end;
    end;
  finally
    qry.Free;
  end;
end;

procedure TSupplierPaymentLine.SetPrepaymentId(const Value: integer);
var
  Prepayment: TSuppPrePayments;
begin
  SetIntegerField('PrepaymentID', Value);
  TrnType := tcConst.PrePayType;
  TransNo := IntToStr(Value);

  Prepayment := TSuppPrePayments.Create(nil);
  try
    Prepayment.Connection := self.Connection;
    Prepayment.Load(Value);
    if not Prepayment.ISEmpty then begin
      Date := Prepayment.PrePaymentDate;
      AmountDue := Prepayment.Balance;
      OriginalAmount := Prepayment.Payment;
    end;
  finally
    Prepayment.Free;
  end;
end;

procedure TSupplierPaymentLine.SetTransNo(const Value: string);
begin
  SetStringField('PONo', Value);
end;

function TSupplierPaymentLine.ValidateData: Boolean;
var
  msg: string;
  data: TJsonObject;
  TransId: integer;
  Prepayment: TSuppPrePayments;
  qry: TERPQuery;
begin
  { validate payment details for each line }
  result := false;
  if (self.PrepaymentId > 0) and (self.POID > 0) then begin
    AddResult(false, rssWarning, 0, 'Payment Line is not linked to any Transaction.');
    exit;
  end;
  if (self.PrepaymentId > 0) and (self.POID > 0) then begin
    AddResult(false, rssWarning, 0, 'Payment Line is linked to a Prepayment and another Transaction, can only be one of these.');
    exit;
  end;
  if self.PrepaymentId > 0 then begin
    Prepayment := TSuppPrePayments.Create(nil);
    try
      Prepayment.Connection := self.Connection;
      Prepayment.Load(PrepaymentID);
      if Prepayment.ISEmpty then begin
        AddResult(false, rssWarning, 0, 'Prepayment not found for ID ' + IntToStr(PrepaymentID));
        exit;
      end
      else begin
        if TrnType <> tcConst.PrePayType then begin
          AddResult(false, rssWarning, 0, 'Wrong Transaction Type for a Prepayment.');
          exit;
        end;
      end;
    finally
      Prepayment.Free;
    end;
  end
  else if self.POID > 0 then begin
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := Self.Connection.Connection;
      qry.SQL.Text := 'select * from tblPurchaseOrders where PurchaseOrderID = ' + IntToStr(POID);
      qry.Open;
      if not qry.IsEmpty then begin
        if qry.FieldByName('IsPO').AsBoolean then begin
          if  TrnType <> tcConst.POType then begin
            AddResult(false, rssWarning, 0, 'Wrong Transaction Type for linked Purchase Order.');
            exit;
          end;
        end
        else if qry.FieldByName('IsRA').AsBoolean then begin
          AddResult(false, rssWarning, 0, 'Can not add a Return Authority to a Supplier Payment.');
          exit;
        end
        else if qry.FieldByName('IsBill').AsBoolean then begin
          if TrnType <> tcConst.BillType then begin
            AddResult(false, rssWarning, 0, 'Wrong Transaction Type for linked Bill.');
            exit;
          end;
        end
        else if qry.FieldByName('IsCredit').AsBoolean then begin
          if TrnType <> tcConst.CreditType then begin
            AddResult(false, rssWarning, 0, 'Wrong Transaction Type for linked Credit.');
            exit;
          end;
        end
        else if qry.FieldByName('IsCheque').AsBoolean then begin
          AddResult(false, rssWarning, 0, 'Can not add a Cheque to a Supplier Payment.');
          exit;
        end
        else if qry.FieldByName('IsRefundCheque').AsBoolean then begin
          AddResult(false, rssWarning, 0, 'Can not add a Refund Cheque to a Supplier Payment.');
          exit;
        end;
      end
      else begin
        AddResult(false, rssWarning, 0, 'No Transaction found for PO ID ' + IntToStr(POID));
        exit;
      end;
    finally
      qry.Free;
    end;
  end;
  data:= nil;
  result:= PaymentsLib.ValidatePaymentLine(self,data, self.Connection.Connection);
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
      SendPaymentError(self,TSupplierPayment(Owner).ID,TransID,TrnType,TSupplierPayment(Owner).ValidationStage,msg);
    end;
    data.Free;
  end;
end;

initialization
  RegisterClass(TCustomerPayment);
  RegisterClass(TSupplierPayment);
  RegisterClass(TCustomerPaymentLine);
  RegisterClass(TSupplierPaymentLine);

end.
