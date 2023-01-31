unit busobjPrepayments;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  26/10/07  1.00.01  bS  Initial Version.
  }


interface


Uses
  TypesLib, BusObjBase, DB, Classes,
  BusObjClient,busObjBankDepost,BusObjGLAccount,BusobjABA, tcTypes, XMLDoc,
  XMLIntf, BusObjPayMethods;


type
  TPrePayments = class(TMSBusObj)
  private
    fsLockMsg                       : String    ;
    Function GetEmployeeID          : Integer   ;
    Function GetClientID            : Integer   ;
    Function GetCompanyName         : string    ;
    Function GetPrePaymentDate      : TDateTime ;
    Function GetPayAmount           : Double    ;
    Function GetPayMethodID         : Integer   ;
    Function GetNotes               : string    ;
    Function GetReferenceNo         : string    ;
    Function GetClassID             : Integer   ;
    Function GetMasterAccountID     : Integer   ;
    Function GetBankAccountID       : Integer   ;
    Function GetCustomer            : Boolean   ;
    Function GetSupplier            : Boolean   ;
    Function GetDeleted             : Boolean   ;
    Function GetReconciled          : Boolean   ;
    Function GetDepositID           : Integer   ;
    Function GetDeposited           : Boolean   ;
    Function GetReconciliationID    : Integer   ;
    Function GetPaID                : Boolean   ;
    Function GetBalance             : Double    ;
    Function GetPayment             : Double    ;
    Function GetBankAccountName     : string    ;
    Function GetBankAccountBSB      : string    ;
    Function GetBankAccountNo       : string    ;
    Function GetForeignExchangeCode : string    ;
    Function GetForeignExchangeRate : Double    ;
    Function GetForeignPayAmount    : Double    ;
    Function GetForeignPaID         : Double    ;
    Function GetForeignBalance      : Double    ;
    Function GetForeignPayment      : Double    ;
    Function GetCleanDeleted        : Boolean   ;
    function getBankDeposit         : TBankDeposit;
    Function getBankAccount         : TAccount;

    
    Procedure SetEmployeeID         (const Value: Integer   );
    Procedure SetClientID           (const Value: Integer   );
    Procedure SetCompanyName        (const Value: string    );
    Procedure SetPrePaymentDate     (const Value: TDateTime );
    Procedure SetPayAmount          (const Value: Double    );
    Procedure SetPayMethodID        (const Value: Integer   );
    Procedure SetNotes              (const Value: string    );
    Procedure SetReferenceNo        (const Value: string    );
    Procedure setClassID            (const Value: Integer   );
    Procedure SetMasterAccountID    (const Value: Integer   );
    Procedure SetBankAccountID      (const Value: Integer   );
    Procedure SetCustomer           (const Value: Boolean   );
    Procedure SetSupplier           (const Value: Boolean   );
    Procedure SetDeleted            (const Value: Boolean   );
    Procedure SetReconciled         (const Value: Boolean   );
    Procedure SetDepositID          (const Value: Integer   );
    Procedure SetDeposited          (const Value: Boolean   );
    Procedure SetReconciliationID   (const Value: Integer   );
    Procedure SetPaID               (const Value: Boolean   );
    Procedure SetBalance            (const Value: Double    );
    Procedure SetPayment            (const Value: Double    );
    Procedure SetBankAccountName    (const Value: string    );
    Procedure SetBankAccountBSB     (const Value: string    );
    Procedure SetBankAccountNo      (const Value: string    );
    Procedure SetForeignExchangeCode(const Value: string    );
    Procedure SetForeignExchangeRate(const Value: Double    );
    Procedure SetForeignPayAmount   (const Value: Double    );
    Procedure SetForeignPaID        (const Value: Double    );
    Procedure SetForeignBalance     (const Value: Double    );
    Procedure SetForeignPayment     (const Value: Double    );
    Procedure UpdateAccounts;
    Procedure CreateDeposits;
    Procedure UpdateFCRate;
    Procedure UpdateFCAmount;
    Procedure UpdateDCAmount;
    Procedure UpdateFCHistory;
    Function  setTenderAccountID:Boolean;
    Function  getclient         : Tclient;
    Function  getReconciliations(Const TransLockType: TTransLockType):Boolean; Virtual; abstract;
    function getEnteredAt: TDateTime;
    procedure setEnteredAt(const Value: TDateTime);
    function GetEmployeeName: string;
    procedure SetEmployeeName(const Value: string);
    function GetDeptClassName: string;
    procedure SetDeptClassName(const Value: string);
    function GetPayMethodName: string;
    procedure SetPayMethodName(const Value: string);
    function GetBankAccountAccountName: string;
    procedure SetBankAccountAccountName(const Value: string);
    function GetPrintName: string;
    procedure SetPrintName(const Value: string);
    function GetPayMethod: TPaymentMethod;
  Protected
    Procedure OnDataIdChange    (const ChangeType   : TBusObjDataChangeType);   Override;
    Procedure DoFieldOnChange   (Sender             : TField);                  Override;
    Function  DoAfterPost       (Sender             : TDatasetBusObj):Boolean;  Override;
    Function  DoAfterInsert     (Sender             : TDatasetBusObj):Boolean;  Override;
    Function  GetSQL                                : string;                   Override;
    Function  GetPrepaymentAccountID                : Integer;                  Virtual; abstract;
    Procedure CheckPaymethod    (const Sender: TField);
  Public
    Class Function  GetIDField                      : string;                   Override;
    Class Function  GetBusObjectTablename           : String;                   Override;
    Destructor   Destroy;                                  Override;
    Constructor  Create         (AOwner      : TComponent);Override;
    Procedure    LoadFromXMLNode(const node  : IXMLNode);  Override;
    Procedure    SaveToXMLNode  (const node  : IXMLNode);  Override;
    Function     ValidateData                : Boolean ;   Override;
    Function     Save                        : Boolean ;   Override;
    Function     Lock                        : Boolean ;   Override;
    Function     IsPrepaymentApplied         : Boolean;    Virtual ; Abstract;
    Class Function  getTranstype             : String;     Virtual;abstract;
    function     IsPrepaymentReconciled      : boolean;
    function     IsPrepaymentonHold          : boolean;
    Function     IsAccountTypeBank           : Boolean;

    Property Transtype          :String             Read getTranstype;
    Property LockMsg            :String             Read fsLockMsg              Write fsLockMsg;
    Property Client             :TClient            Read getclient;
    Property PrepaymentAccountID:Integer            Read GetPrepaymentAccountID;
    Property CleanDeleted       :Boolean            Read GetCleanDeleted;
    Property BankDeposit        :TBankDeposit       Read getBankDeposit;
    Property GLAccount          :TAccount           Read getBankAccount;
    function ReferenceNoExists(var aCompany: string; var aDate: TDateTime; var aAmount: double): boolean;
    Property PaymentMethod: TPaymentMethod  read GetPayMethod;

  Published
    property EmployeeID         :Integer   Read GetEmployeeID          Write SetEmployeeID         ;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property ClientID           :Integer   Read GetClientID            Write SetClientID           ;
    property CompanyName        :string    Read GetCompanyName         Write SetCompanyName        ;
    property PrintName: string read GetPrintName write SetPrintName;
    property PrePaymentDate     :TDateTime Read GetPrePaymentDate      Write SetPrePaymentDate     ;
    property PayAmount          :Double    Read GetPayAmount           Write SetPayAmount          ;
    property PayMethodID        :Integer   Read GetPayMethodID         Write SetPayMethodID        ;
    property PayMethodName: string read GetPayMethodName write SetPayMethodName;
    property Notes              :string    Read GetNotes               Write SetNotes              ;
    property ReferenceNo        :string    Read GetReferenceNo         Write SetReferenceNo        ;
    property ClassID            :Integer   Read GetClassID             Write setClassID            ;
    property DeptClassName: string read GetDeptClassName write SetDeptClassName;
    property BankAccountID      :Integer   Read GetBankAccountID       Write SetBankAccountID      ;
    property BankAccountAccountName :string Read GetBankAccountAccountName  Write SetBankAccountAccountName;
    property MasterAccountID    :Integer   Read GetMasterAccountID     Write SetMasterAccountID    ;
    property Customer           :Boolean   Read GetCustomer            Write SetCustomer           ;
    property Supplier           :Boolean   Read GetSupplier            Write SetSupplier           ;
    property Deleted            :Boolean   Read GetDeleted             Write SetDeleted            ;
    property Reconciled         :Boolean   Read GetReconciled          Write SetReconciled         ;
    property DepositID          :Integer   Read GetDepositID           Write SetDepositID          ;
    property Deposited          :Boolean   Read GetDeposited           Write SetDeposited          ;
    property ReconciliationID   :Integer   Read GetReconciliationID    Write SetReconciliationID   ;
    property Paid               :Boolean   Read GetPaID                Write SetPaID               ;
    property Balance            :Double    Read GetBalance             Write SetBalance            ;
    property Payment            :Double    Read GetPayment             Write SetPayment            ;
    property BankAccountName    :string    Read GetBankAccountName     Write SetBankAccountName    ;
    property BankAccountBSB     :string    Read GetBankAccountBSB      Write SetBankAccountBSB     ;
    property BankAccountNo      :string    Read GetBankAccountNo       Write SetBankAccountNo      ;
    property ForeignExchangeCode:string    Read GetForeignExchangeCode Write SetForeignExchangeCode;
    property ForeignExchangeRate:Double    Read GetForeignExchangeRate Write SetForeignExchangeRate;
    property ForeignPayAmount   :Double    Read GetForeignPayAmount    Write SetForeignPayAmount   ;
    property ForeignPaid        :Double    Read GetForeignPaID         Write SetForeignPaID        ;
    property ForeignBalance     :Double    Read GetForeignBalance      Write SetForeignBalance     ;
    property ForeignPayment     :Double    Read GetForeignPayment      Write SetForeignPayment     ;
    Property EnteredAt          : TDateTime Read getEnteredAt           Write setEnteredAt;

  end;
  TCustPrePayments = class(TPrePayments)
  Private
    Function getReconciliations(Const TransLockType:TTransLockType):Boolean; Override;
    function getRepId: Integer;
    function getRepName: String;
    procedure setRepName(const Value: String);
    procedure setRepID(const Value: Integer);
  Protected
    Function GetPrepaymentAccountID : Integer;  Override;
    Procedure DoFieldOnChange (Sender: TField); Override;
  Public
    Constructor  Create(AOwner      : TComponent);Override;
    Function IsPrepaymentApplied    : Boolean;  Override;
    Function IsPrepaymentDeposited  : Boolean;
    function Save                   : boolean; Override;
    Function Lock                   : Boolean; Override;
    Class function getTranstype     : String;   Override;
    Procedure    LoadFromXMLNode(const node  : IXMLNode);  Override;
    Procedure    SaveToXMLNode  (const node  : IXMLNode);  Override;
    Procedure ApplyToInvoice(const InvoiceID:Integer;var invoiceBalance:Double);
    Function     ValidateData                : Boolean ;   Override;
  Published
    Property RepId :Integer read getRepId write setRepID;
    Property RepName:String Read getRepName write setRepName;
  end;

  TCustomerPrepayment = class(TCustPrePayments);


  TSuppPrePayments = class(TPrePayments)
  Private
    fbAddToEFT                      : Boolean;
    fbAInvalid4EFT                  : Boolean;
    fbCInvalid4EFT                  : boolean;
    fGetEFTDetails                  : TGeneralProc;
    Function getABAObj              : TABADetailRecord;
    Procedure CreateABARecord;
    Function getReconciliations(Const TransLockType:TTransLockType):Boolean; Override;
    function getChequePrinted: Boolean;
    procedure setChequePrinted(const Value: Boolean);
    procedure MakeChequeno;
    procedure UpdateLastChequeNo;
  Protected
    Function GetPrepaymentAccountID : Integer;  Override;
    Procedure OnDataIdChange    (const ChangeType   : TBusObjDataChangeType);   Override;
    Procedure DoFieldOnChange   (Sender             : TField);                  Override;
    Function  DoAfterInsert(Sender      : TDatasetBusObj): Boolean;             Override;
  Public
    Constructor Create(AOwner      : TComponent);Override;
    Function  IsPrepaymentApplied   : Boolean;  Override;
    Function  Save                  : Boolean;  Override;
    Function  ValidateData          : Boolean;  Override;
    Function  Valid4EFT(OpenDetailform:Boolean= False): Boolean;
    Function Lock                   : Boolean; Override;
    Class function getTranstype     : String;   Override;
    Procedure    LoadFromXMLNode(const node  : IXMLNode);  Override;
    Procedure    SaveToXMLNode  (const node  : IXMLNode);  Override;

    Property AddToEFT               : Boolean           Read fbAddToEFT     Write fbAddToEFT;
    Property ABAObj                 : TABADetailRecord  Read getABAObj;
    Property BankAccountInvalid4EFT : Boolean           Read fbAInvalid4EFT Write fbAInvalid4EFT;
    Property ClientInvalid4EFT      : Boolean           Read fbCInvalid4EFT Write fbCInvalid4EFT;
    Property GetEFTDetails          : TGeneralProc      Read fGetEFTDetails Write fGetEFTDetails;
  Protected
  Published
    Property ChequePrinted :Boolean read getChequePrinted write setChequePrinted;
  end;

implementation


uses tcDataUtils, CommonLib, {FastFuncs,} sysUtils, AppEnvironment, tcConst,
    Dialogs, Controls,ForeignExchangeObj, Variants, TransLockManagementObj,
    Math, MyAccess, BusObjPayments, BusObjEmployee, BusObjClass,
    BusObjConst, CardPaymentObj, ERPdbComponents, PaymentsLib, CommonDbLib, DbSharedObjectsObj;

      {TPrePayments}

Constructor TPrePayments.Create(AOwner: TComponent);
begin
  inherited Create(AOwner) ;
  fBusObjectTypeDescription:= 'PrePayments';
  fSQL := 'SELECT * FROM tblprepayments';
  ExportExcludeList.Add('customer');
  ExportExcludeList.Add('supplier');
  ExportExcludeList.Add('employeeid');
  ExportExcludeList.Add('clientid');
  ExportExcludeList.Add('classid');
  ExportExcludeList.Add('paymethodid');
  ExportExcludeList.Add('masteraccountid');
  ExportExcludeList.Add('bankaccountid');
  ExportExcludeList.Add('isempty');
end;


Destructor TPrePayments.Destroy;
begin
  inherited;
end;


Procedure TPrePayments.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeID'         );
  SetPropertyFromNode(node,'ClientID'           );
  SetPropertyFromNode(node,'CompanyName'        );
  SetPropertyFromNode(node,'PrePaymentDate'     );
  SetPropertyFromNode(node,'PayAmount'          );
  SetPropertyFromNode(node,'PayMethodID'        );
  SetPropertyFromNode(node,'Notes'              );
  SetPropertyFromNode(node,'ReferenceNo'        );
  SetPropertyFromNode(node,'ClassID'            );
  SetPropertyFromNode(node,'MasterAccountID'    );
  SetPropertyFromNode(node,'BankAccountID'      );
  SetPropertyFromNode(node,'Customer'           );
  SetPropertyFromNode(node,'Supplier'           );
  SetPropertyFromNode(node,'Deleted'            );
  SetPropertyFromNode(node,'Reconciled'         );
  SetPropertyFromNode(node,'DepositID'          );
  SetPropertyFromNode(node,'Deposited'          );
  SetPropertyFromNode(node,'ReconciliationID'   );
  SetPropertyFromNode(node,'PaID'               );
  SetPropertyFromNode(node,'Balance'            );
  SetPropertyFromNode(node,'Payment'            );
  SetPropertyFromNode(node,'BankAccountName'    );
  SetPropertyFromNode(node,'BankAccountBSB'     );
  SetPropertyFromNode(node,'BankAccountNo'      );
  SetPropertyFromNode(node,'ForeignExchangeCode');
  SetPropertyFromNode(node,'ForeignExchangeRate');
  SetPropertyFromNode(node,'ForeignPayAmount'   );
  SetPropertyFromNode(node,'ForeignPaID'        );
  SetPropertyFromNode(node,'ForeignBalance'     );
  SetPropertyFromNode(node,'ForeignPayment'     );
end;


Procedure TPrePayments.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EmployeeID'          ,EmployeeID         );
  AddXMLNode(node,'ClientID'            ,ClientID           );
  AddXMLNode(node,'CompanyName'         ,CompanyName        );
  AddXMLNode(node,'PrePaymentDate'      ,PrePaymentDate     );
  AddXMLNode(node,'PayAmount'           ,PayAmount          );
  AddXMLNode(node,'PayMethodID'         ,PayMethodID        );
  AddXMLNode(node,'Notes'               ,Notes              );
  AddXMLNode(node,'ReferenceNo'         ,ReferenceNo        );
  AddXMLNode(node,'ClassID'             ,ClassID            );
  AddXMLNode(node,'MasterAccountID'     ,MasterAccountID    );
  AddXMLNode(node,'BankAccountID'       ,BankAccountID      );
  AddXMLNode(node,'Customer'            ,Customer           );
  AddXMLNode(node,'Supplier'            ,Supplier           );
  AddXMLNode(node,'Deleted'             ,Deleted            );
  AddXMLNode(node,'Reconciled'          ,Reconciled         );
  AddXMLNode(node,'DepositID'           ,DepositID          );
  AddXMLNode(node,'Deposited'           ,Deposited          );
  AddXMLNode(node,'ReconciliationID'    ,ReconciliationID   );
  AddXMLNode(node,'PaID'                ,PaID               );
  AddXMLNode(node,'Balance'             ,Balance            );
  AddXMLNode(node,'Payment'             ,Payment            );
  AddXMLNode(node,'BankAccountName'     ,BankAccountName    );
  AddXMLNode(node,'BankAccountBSB'      ,BankAccountBSB     );
  AddXMLNode(node,'BankAccountNo'       ,BankAccountNo      );
  AddXMLNode(node,'ForeignExchangeCode' ,ForeignExchangeCode);
  AddXMLNode(node,'ForeignExchangeRate' ,ForeignExchangeRate);
  AddXMLNode(node,'ForeignPayAmount'    ,ForeignPayAmount   );
  AddXMLNode(node,'ForeignPaID'         ,ForeignPaID        );
  AddXMLNode(node,'ForeignBalance'      ,ForeignBalance     );
  AddXMLNode(node,'ForeignPayment'      ,ForeignPayment     );
end;


Function TPrePayments.ValidateData: Boolean ;
begin
    REsult := False;
    Resultstatus.Clear;
    if MasterAccountID = 0 then MasterAccountID   := PrepaymentAccountID;
    if Math.IsZero(PayAmount, 0.000001) then begin
        ResultStatus.AddItem(False, rssWarning, 0 , 'Payment Amount should not be zero');
        Exit;
    end;
    if BankAccountID = 0 then begin
        ResultStatus.AddItem(False, rssWarning, 0 , 'Bank Account should not be blank');
        Exit;
    end;
    if ClientId = 0 then begin
        ResultStatus.AddItem(False, rssWarning, 0 , 'Client should not be blank');
        Exit;
    end;
    if self.ClassID < 1 then begin
      ResultStatus.AddItem(false, rssInfo,0,AppEnv.DefaultClass.ClassHeading + ' is missing.');
      exit;
    end;
    CheckPaymethod(Dataset.findField('PaymethodID'));
    if PayMethodID = 0 then begin
        ResultStatus.AddItem(False, rssWarning, 0 , 'Payment method should not be blank');
        Exit;
    end;

    Result := True;
end;

Procedure TPrePayments.CheckPaymethod(const Sender: TField);
begin
    //descendants will override if required
end;

Function TPrePayments.Save: Boolean ;
begin
    Result := False;
    if not ValidateData then Exit;
    Result := inherited Save;
    if not result then Exit;
    UpdateFCHistory;
    UpdateAccounts;
    CreateDeposits;
    if not PostList.Execute then begin
        REsult := False;
        Exit;
    end;
    Dirty := False;
end;

Function  TPrePayments.IsAccountTypeBank         : Boolean;
begin
    REsult := not Sysutils.SameText(tcdataUtils.GetAccountName(BankAccountID) , UNDEPOSITED_FUNDS);
end;

Procedure TPrePayments.CreateDeposits;
begin
    if not IsAccountTypeBank then begin
        if BankDeposit.count >0 then begin
            if BankDeposit.Lines.count > 0 then BankDeposit.Lines.DeleteAll;
            BankDeposit.DeleteAll;
        end;
      Exit;
    end;
    {header}
    if Deleted then begin
        if BankDeposit.count >0 then begin
            if BankDeposit.Lines.count > 0 then BankDeposit.Lines.DeleteAll;
            BankDeposit.DeleteAll;
        end;
    end else begin
        if BankDeposit.count     = 0 then BankDeposit.New;
        BankDeposit.DepositDate := PrePaymentDate;
        BankDeposit.EmployeeID  := EmployeeID;
        BankDeposit.ClassID     := ClassID;
        BankDeposit.AccountID   := BankAccountID;
        BankDeposit.Notes       := Notes;
        BankDeposit.Deposit     := PayAmount;
        BankDeposit.Deleted     := Deleted;
        BankDeposit.PostDB;
        {details}
        if BankDeposit.Lines.count       = 0 then BankDeposit.Lines.New;
        BankDeposit.Lines.PaymentID     := ID;
        BankDeposit.Lines.TrnsType      := TRansType;
        BankDeposit.Lines.CusID         := ClientID;
        BankDeposit.Lines.CompanyName   := Self.companyName;
        BankDeposit.Lines.PayMethodID   := PayMethodID;
        BankDeposit.Lines.PaymentDate   := PrePaymentDate;
        BankDeposit.Lines.CompanyName   := CompanyName;
        BankDeposit.Lines.ReferenceNo   := ReferenceNo;
        BankDeposit.Lines.ClassID       := ClassID;
        BankDeposit.Lines.AccountID     := BankAccountID;
        BankDeposit.Lines.Amount        := PayAmount;
        BankDeposit.Lines.Notes         := Notes;
        BankDeposit.Lines.Deposited     := True;
        BankDeposit.Lines.FromDeposited := False;
        BankDeposit.Lines.Customer      := customer;
        BankDeposit.Lines.Supplier      := supplier;
        BankDeposit.Lines.StatementNo   := 0;
        BankDeposit.Lines.PostDB;
    End;
end;
Procedure TPrepayments.UpdateFCHistory;
var
    BuyRate, SellRate:Double;
begin
    if not Assigned(confirmFromGUI) then Exit;
    if AppEnv.CompanyPrefs.UseForeignCurrencyonPO then begin
    With TForeignExchangeObj.Create do Try
        GetForeignExchangeRatesForDate(ForeignExchangeCode, PrepaymentDate, BuyRate, SellRate);
        if ForeignExchangeRate <> SellRate then
            if fconfirmFromGUI('Do you want to update the rate in "Foreign Exchange Rate" list for ' + ForeignExchangeCode + '?',[mbYes, mbNo]) = mrYes then
                AddForeignExchangeRateHistory(tcdatautils.getCurrencyID(ForeignExchangeCode),BuyRate, ForeignExchangeRate, PrePaymentDate);
    finally
      Free;
    end;
  end;

end;
Procedure TPrePayments.UpdateAccounts;
var
     CleanMasterAccountID   : Integer;
     CleanBankAccountID     : Integer;
     CleanNode              : IXMLNode;
     CleanPayAmount         : Double;
     cleanclientID          : Integer;
begin
    CleanNode:= self.CleanXMLNode;
    if assigned(CleanNode) and (CleanDeleted = False) then begin
        CleanMasterAccountID:= GetXMLNodeIntegerValue(CleanXMLNode, 'MasterAccountID');
        CleanBankAccountID  := GetXMLNodeIntegerValue(CleanXMLNode, 'BankAccountID');
        CleanPayAmount      := GetXMLNodeFloatValue(CleanNode,'PayAmount');
        if CleanPayAmount <> 0 then begin
            if CleanMasterAccountID <> 0 then
                PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,CleanMasterAccountID, CleanPayAmount);
            if CleanBankAccountID <> 0 then
               PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,CleanBankAccountID, -CleanPayAmount);
        End;
        cleanclientID := GetXMLNodeIntegerValue(CleanXMLNode, 'clientID');
        if cleanclientID<> 0 then begin
            if Self is TCustPrePayments then
                 PostList.AddAmount(Client.ClassName, client.BusObjectTableName,cleanclientID,CleanPayAmount,btAR)
            else
                 PostList.AddAmount(Client.ClassName, client.BusObjectTableName,cleanclientID,CleanPayAmount,btAP);
        End;
    End;

    if Deleted then exit;

    if PayAmount <> 0 then begin
        if MasterAccountID <> 0 then
            PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,MasterAccountID, -PayAmount);
        if BankAccountID <> 0 then
            PostList.AddAmount(GLAccount.ClassName, GLAccount.BusObjectTableName,BankAccountID, PayAmount);
        if ClientID<> 0 then begin
            if Self is TCustPrePayments then
                PostList.AddAmount(Client.ClassName, client.BusObjectTableName,ClientID,-PayAmount,btAR)
            else
                PostList.AddAmount(Client.ClassName, client.BusObjectTableName,ClientID,-PayAmount,btAP);
        end;
    End;
end;

Procedure TPrePayments.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;
Procedure TPrepayments.UpdateDCAmount;
begin
        if ForeignExchangeRate <> 0 then
             PayAmount := CommonLib.Round(ForeignPayAmount /ForeignExchangeRate, CurrencyRoundPlaces)
        else PayAmount := 0;
        Balance := PayAmount - Payment;
end;
Procedure TPrepayments.UpdateFCAmount;
begin
    if (ForeignExchangeRate = 0) or (PayAmount=0) then ForeignPayAmount := 0
        else ForeignPayAmount := Round(PayAmount*ForeignExchangeRate, CurrencyRoundPlaces);
    ForeignBalance := ForeignPayAmount - ForeignPayment; //ForeignPayAmount;
end;
Procedure TPrePayments.UpdateFCRate;
var
   FxObj: TForeignExchangeObj;
   BuyRate, SellRate :Double;
begin
    FxObj := TForeignExchangeObj.Create;
    Try
        FxObj.GetForeignExchangeRatesForDate(ForeignExchangeCode, PrepaymentDate, BuyRate, SellRate);
        ForeignExchangeRate:= SellRate;
    finally
        FreeandNil(FxObj);
    end;
end;
Procedure TPrePayments.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.fieldname, 'PayAmount') then begin
        if balance = 0 then
          Balance := PayAmount
        else
          Balance:= Sender.AsFloat - Payment;
        updateFCAmount;
    end else if Sysutils.SameText(Sender.FieldName, 'ForeignExchangeCode') then begin
        updateFCRate;
        UpdateFCAmount;
    end else if Sysutils.SameText(Sender.FieldName, 'ForeignExchangeRate') then begin
        UpdateFCAmount;
    end else if Sysutils.SameText(Sender.Fieldname , 'PrepaymentDate') then begin
        if PrepaymentDate <= AppEnv.CompanyPrefs.ClosingDate then begin
            ResultStatus.AddItem(False , rssWarning, 0, 'Prepayment date should not be before the closing date.' +
                                                        'The date will automatically be set to today''s date.' + chr(13) +
                                                        'Reset the closing date in preferences.');
            PrepaymentDate := now;
        End;
    end else if Sysutils.SameText(sender.fieldname , 'ForeignPayAmount') then begin
        Sender.AsFloat:= Round(Sender.AsFloat,self.CurrencyRoundPlaces);
        //if ForeignBalance = 0 then ForeignBalance := ForeignPayAmount;
        ForeignBalance := ForeignPayAmount - ForeignPayment; //ForeignPayAmount;
        updateDCAmount;
    end else if Sysutils.SameText(Sender.fieldName, 'ClientId') or Sysutils.SameText(Sender.fieldName, 'CompanyName') (*or Sysutils.SameText(Sender.fieldName, 'ClientPrintName')*) then begin
        (*if Sysutils.SameText(Sender.fieldName, 'ClientPrintName') then begin
          CompanyName:= clientNameForPrintname(Sender.asString);
          DoFieldOnChange(Dataset.findfield('CompanyName'));
        end else *)if Sysutils.SameText(Sender.fieldName, 'CompanyName') then begin
          ClientID:= TClient.IDToggle(Sender.AsString, Connection.Connection);
        end else begin
          CompanyName:= TClient.IDToggle(Sender.AsInteger, Connection.Connection);
        end;
        if ClientID <> 0 then begin
            Customer            := Self is TCustPrePayments;
            Supplier            := Self is TSuppPrePayments;
            PrintName := Client.PrintName;
            ForeignExchangeCode := client.ForeignExchangeCode;
            if ForeignExchangeCode = '' then ForeignExchangeCode := AppEnv.RegionalOptions.ForeignExDefault;
            DoFieldOnChange(Dataset.findfield('ForeignExchangeCode'));
            if BankAccountID < 1 then begin
              If Self is TCustPrePayments then
                BankAccountID := AppEnv.CompanyPrefs.DefaultCustPaymentAccount;
              If Self is TSuppPrePayments then
                BankAccountID := AppEnv.CompanyPrefs.DefaultSuppPaymentAccount;
            end;
            if PayMethodID < 1 then
              PayMethodID := Client.PayMethodID;
            CheckPaymethod(Dataset.findField('PaymethodID'));
            if (PaymethodID <> 0) then
              setTenderAccountID;
            PostDB;
            SendEvent(BusObjEvent_Change, BusObjEventVal_ClientID, Self);
        End;
    end else if Sysutils.SameText(Sender.FieldName, 'PaymethodId') then begin
        CheckPaymethod(Sender);
        if (PaymethodID<>0) and (setTenderAccountID) then
            DoFieldOnChange(Dataset.findfield('BankAccountID'));
        PostDB;
    end;
end;
Function TPrePayments.setTenderAccountID:Boolean;
var
    strSQL:String;
begin
    REsult := False;
    strSQL:= 'SELECT  tbltenderaccountprefs.AccountId ' +
            ' FROM tbltenderaccountprefs  ' +
            ' INNER JOIN tblchartofaccounts COA USING(AccountID) ' +
            ' WHERE tbltenderaccountprefs.Active="T"  ' +
            ' AND COA.Active="T"  ' +
            ' AND PaymethodID = ' + IntToStr(PaymethodID);
   with getNewDataset(strSQL) do try
        if (recordcount = 1) and (fieldbyname('AccountID').asInteger <> 0) then begin
            BankAccountID:= FieldByname('AccountID').ASInteger;
            result := True;
        End;
   finally
        if Active then close;
        Free;
   end;
end;

Function TPrePayments.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

Function TPrePayments.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
Function TPrePayments.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result            := inherited DoAfterInsert(Sender);
  if not Result then exit;
  PrePaymentDate    := Date;
  ClassID           := AppEnv.DefaultClass.ClassID;
  PayAmount         := 0.00;
  EmployeeID        := AppEnv.Employee.EmployeeID;
  MasterAccountID   := PrepaymentAccountID;
  Customer          := Self is TCustPrePayments;
  Supplier          := Self is TSuppPrepayments;
  EnteredAt         := now; 
End;
function TPrePayments.IsPrepaymentReconciled          : boolean;
begin
    REsult := getReconciliations(ltReconciled);
end;
function TPrePayments.IsPrepaymentonHold          : boolean;
begin
    REsult := getReconciliations(ltOnHoldRec);
end;
Function TPrePayments.Lock : Boolean ;
begin
    Result  := False;
    LockMsg := '';
    if IsPrepaymentReconciled   then
      LockMsg := LockMsgReconciled
    else if IsPrepaymentonHold  then
      LockMsg := LockMsgReconcileHold
    else if IsPrepaymentApplied then
      LockMsg := LockMsgApplied
    else if (Self is TCustPrePayments) and (TCustPrePayments(self).IsPrepaymentDeposited) then
      LockMsg := LockMsgDeposited
    else if Deleted then
      LockMsg := LockMsgDeletedPrepayment
    else Begin
      Result := inherited lock;
      if not Result then
        LockMsg := LockMsgInUse;
    end;
end;

Function  TPrePayments.getclient: Tclient;
begin
    Result := TClient(getContainerComponent(Tclient , 'ClientID = ' +IntToStr(ClientID)));
end;
Function  TPrePayments.GetCleanDeleted:Boolean;
begin
      result:= GetXMLNodeBooleanValue(CleanXMLNode, 'Deleted');
end;
Function TPrePayments.getBankAccount         : TAccount;
begin
    REsult :=  TAccount(getContainerComponent(TAccount , 'AccountID = ' + IntToStr(BankAccountID)));
end;
function TPrePayments.getBankDeposit         : TBankDeposit;
begin
    PostDB;
    REsult :=  TBankDeposit(getContainerComponent(TBankDeposit , 'Details.Trnstype = ' + QuotedStr(Transtype) +' and Details.PaymentId = ' + IntToStr(ID)));
end;
{Property Functions}
Class function TPrePayments.GetBusObjectTablename: String; begin Result := 'tblprepayments';end;
Class Function TPrePayments.GetIDField           : string; begin Result := 'PrePaymentID'end;
Function  TPrePayments.GetEmployeeID         : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function TPrePayments.GetEmployeeName: string;
begin
  result := TEmployee.IDToggle(EmployeeID, Connection.Connection);
end;

Function  TPrePayments.GetClientID           : Integer   ; begin Result := GetIntegerField('ClientID');end;
Function  TPrePayments.GetCompanyName        : string    ; begin Result := GetStringField('CompanyName');end;
Function  TPrePayments.GetPrePaymentDate     : TDateTime ; begin Result := GetDateTimeField('PrePaymentDate');end;
function TPrePayments.GetPrintName           : string    ; begin result := GetStringField('ClientPrintName');end;
Function  TPrePayments.GetPayAmount          : Double    ; begin Result := GetFloatField('PayAmount');end;
function TPrePayments.GetPayMethod: TPaymentMethod;
begin
  Result := TPaymentMethod(Getcontainercomponent(TPaymentMethod , 'PayMethodID = ' + IntToStr(PaymethodID), SilentMode, False ));
end;

Function  TPrePayments.GetPayMethodID        : Integer   ; begin Result := GetIntegerField('PayMethodID');end;
function TPrePayments.GetPayMethodName       : string    ; begin result := TPaymentMethod.IDToggle(PayMethodID, Connection.Connection);end;
Function  TPrePayments.GetNotes              : string    ; begin Result := GetStringField('Notes');end;
Function  TPrePayments.GetReferenceNo        : string    ; begin Result := GetStringField('ReferenceNo');end;
Function  TPrePayments.GetClassID            : Integer   ; begin Result := GetIntegerField('ClassID');end;
Function  TPrePayments.GetMasterAccountID    : Integer   ; begin Result := GetIntegerField('MasterAccountID');end;
Function  TPrePayments.GetBankAccountID      : Integer   ; begin Result := GetIntegerField('BankAccountID');end;
Function  TPrePayments.GetCustomer           : Boolean   ; begin Result := GetBooleanField('Customer');end;
Function  TPrePayments.GetSupplier           : Boolean   ; begin Result := GetBooleanField('Supplier');end;
Function  TPrePayments.GetDeleted            : Boolean   ; begin Result := GetBooleanField('Deleted');end;
Function  TPrePayments.GetReconciled         : Boolean   ; begin Result := GetBooleanField('Reconciled');end;
Function  TPrePayments.GetDepositID          : Integer   ; begin Result := GetIntegerField('DepositID');end;
function TPrePayments.GetDeptClassName: string;
begin
  result := TDeptClass.IDToggle(ClassID, Connection.Connection);
end;

Function  TPrePayments.GetDeposited          : Boolean   ; begin Result := GetBooleanField('Deposited');end;
Function  TPrePayments.GetReconciliationID   : Integer   ; begin Result := GetIntegerField('ReconciliationID');end;
Function  TPrePayments.GetPaID               : Boolean   ; begin Result := GetBooleanField('PaID');end;
Function  TPrePayments.GetBalance            : Double    ; begin Result := GetFloatField('Balance');end;
Function  TPrePayments.GetPayment            : Double    ; begin Result := GetFloatField('Payment');end;
Function  TPrePayments.GetBankAccountName    : string    ; begin Result := GetStringField('BankAccountName');end;
function TPrePayments.GetBankAccountAccountName: string;
begin
  result := TAccount.IDToggle(BankAccountID, Connection.Connection);
end;

Function  TPrePayments.GetBankAccountBSB     : string    ; begin Result := GetStringField('BankAccountBSB');end;
Function  TPrePayments.GetBankAccountNo      : string    ; begin Result := GetStringField('BankAccountNo');end;
Function  TPrePayments.GetForeignExchangeCode: string    ; begin Result := GetStringField('ForeignExchangeCode');end;
Function  TPrePayments.GetForeignExchangeRate: Double    ; begin Result := GetFloatField('ForeignExchangeRate');end;
Function  TPrePayments.GetForeignPayAmount   : Double    ; begin Result := GetFloatField('ForeignPayAmount');end;
Function  TPrePayments.GetForeignPaID        : Double    ; begin Result := GetFloatField('ForeignPaID');end;
Function  TPrePayments.GetForeignBalance     : Double    ; begin Result := GetFloatField('ForeignBalance');end;
Function  TPrePayments.GetForeignPayment     : Double    ; begin Result := GetFloatField('ForeignPayment');end;
function  TPrePayments.getEnteredAt          : TDateTime ; begin REsult := GetDateTimeField('EnteredAt');end;

Procedure TPrePayments.SetEmployeeID         (const Value: Integer   ); begin SetIntegerField('EmployeeID'          , Value);end;
procedure TPrePayments.SetEmployeeName       (const Value: string    ); begin  EmployeeId := TEmployee.IDToggle(Value, Connection.Connection);end;
Procedure TPrePayments.SetClientID           (const Value: Integer   ); begin SetIntegerField('ClientID'            , Value);end;
Procedure TPrePayments.SetCompanyName        (const Value: string    ); begin SetStringField('CompanyName'         , Value);end;
Procedure TPrePayments.SetPrePaymentDate     (const Value: TDateTime ); begin SetDateTimeField('PrePaymentDate'      , Value);end;
procedure TPrePayments.SetPrintName          (const Value: string    ); begin SetStringField('ClientPrintName'      ,Value);end;
Procedure TPrePayments.SetPayAmount          (const Value: Double    ); begin SetFloatField('PayAmount'           , Value);end;
Procedure TPrePayments.SetPayMethodID        (const Value: Integer   ); begin SetIntegerField('PayMethodID'         , Value);end;
procedure TPrePayments.SetPayMethodName      (const Value: string    ); begin PayMethodId := TPaymentMethod.IDToggle(Value, Connection.Connection);end;
Procedure TPrePayments.SetNotes              (const Value: string    ); begin SetStringField('Notes'               , Value);end;
Procedure TPrePayments.SetReferenceNo        (const Value: string    ); begin SetStringField('ReferenceNo'         , Value);end;
Procedure TPrePayments.setClassID            (const Value: Integer   ); begin SetIntegerField('ClassID'             , Value);end;
Procedure TPrePayments.SetMasterAccountID    (const Value: Integer   ); begin SetIntegerField('MasterAccountID'     , Value);end;
Procedure TPrePayments.SetBankAccountID      (const Value: Integer   ); begin SetIntegerField('BankAccountID'       , Value);end;
Procedure TPrePayments.SetCustomer           (const Value: Boolean   ); begin SetBooleanField('Customer'            , Value);end;
Procedure TPrePayments.SetSupplier           (const Value: Boolean   ); begin SetBooleanField('Supplier'            , Value);end;
Procedure TPrePayments.SetDeleted            (const Value: Boolean   ); begin SetBooleanField('Deleted'             , Value);end;
Procedure TPrePayments.SetReconciled         (const Value: Boolean   ); begin SetBooleanField('Reconciled'          , Value);end;
Procedure TPrePayments.SetDepositID          (const Value: Integer   ); begin SetIntegerField('DepositID'           , Value);end;
procedure TPrePayments.SetDeptClassName      (const Value: string    ); begin ClassId := TDeptClass.IDToggle(Value, Connection.Connection);end;
Procedure TPrePayments.SetDeposited          (const Value: Boolean   ); begin SetBooleanField('Deposited'           , Value);end;
Procedure TPrePayments.SetReconciliationID   (const Value: Integer   ); begin SetIntegerField('ReconciliationID'    , Value);end;
Procedure TPrePayments.SetPaID               (const Value: Boolean   ); begin SetBooleanField('PaID'                , Value);end;
Procedure TPrePayments.SetBalance            (const Value: Double    ); begin SetFloatField('Balance'             , Value);end;
Procedure TPrePayments.SetPayment            (const Value: Double    ); begin SetFloatField('Payment'             , Value);end;
Procedure TPrePayments.SetBankAccountName    (const Value: string    ); begin SetStringField('BankAccountName'     , Value);end;
procedure TPrePayments.SetBankAccountAccountName(const Value: string ); begin  BankAccountId := TAccount.IDToggle(Value, Connection.Connection);end;
Procedure TPrePayments.SetBankAccountBSB     (const Value: string    ); begin SetStringField('BankAccountBSB'      , Value);end;
Procedure TPrePayments.SetBankAccountNo      (const Value: string    ); begin SetStringField('BankAccountNo'       , Value);end;
Procedure TPrePayments.SetForeignExchangeCode(const Value: string    ); begin SetStringField('ForeignExchangeCode'       , Value);end;
Procedure TPrePayments.SetForeignExchangeRate(const Value: Double    ); begin SetFloatField('ForeignExchangeRate'       , Value);end;
Procedure TPrePayments.SetForeignPayAmount   (const Value: Double    ); begin SetFloatField('ForeignPayAmount'    , Value);end;
Procedure TPrePayments.SetForeignPaID        (const Value: Double    ); begin SetFloatField('ForeignPaID'         , Value);end;
Procedure TPrePayments.SetForeignBalance     (const Value: Double    ); begin SetFloatField('ForeignBalance'      , Value);end;
Procedure TPrePayments.SetForeignPayment     (const Value: Double    ); begin SetFloatField('ForeignPayment'      , Value);end;
procedure TPrePayments.setEnteredAt          (const Value: TDateTime ); begin SetDateTimeField('EnteredAt'        , Value);end;

function TPrePayments.ReferenceNoExists(var aCompany: string;
  var aDate: TDateTime; var aAmount: double): boolean;
var
  qry: TMyQuery;
begin
  result:= false;
  if self.ReferenceNo = '' then exit;
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= self.Connection.Connection;
    qry.SQL.Add('select CompanyName, PrePaymentDate, PayAmount');
    qry.SQL.Add('from tblprepayments where PrepaymentID <> ' + IntToStr(self.ID));
    qry.SQL.Add('and (not IsNull(ReferenceNo)) and (ReferenceNo = ' + QuotedStr(self.ReferenceNo) + ')');
    if self.Supplier then
      qry.SQL.Add('and Supplier = "T"')
    else if self.Customer then
      qry.SQL.Add('and Customer = "T"');
    qry.SQL.Add('and Deleted <> "T"');
    qry.Open;
    if not qry.IsEmpty then begin
      result:= true;
      aCompany:= qry.FieldByName('CompanyName').AsString;
      aDate:= qry.FieldByName('PrePaymentDate').AsDateTime;
      aAmount:= qry.FieldByName('PayAmount').AsFloat;
    end;
  finally
    qry.Free;
  end;
end;

{TSuppPrePayments}
Class Function  TSuppPrePayments.getTranstype:String;
begin
    Result := SUPPLIER_PREPAYMENT;
end;
Function TSuppPrePayments.getABAObj: TABADetailRecord;
begin
   Result := TABADetailRecord(getContainerComponent(TABADetailRecord , 'TransID = ' + IntToStr(ID) + ' and TransType = ' + QuotedStr('Supp Prepay')));
end;
function TSuppPrePayments.getChequePrinted: Boolean;
begin
  Result := getBooleanfield('ChequePrinted');
end;

Function TSuppPrepayments.Valid4EFT(OpenDetailform:Boolean= False):Boolean;
begin
    Result := true;
    if self.ClientID < 1 then
      exit;
    BankAccountInvalid4EFT  := False;
    ClientInvalid4EFT       := False;
    if not AddtoEFT then exit;
    if not TSupplier(Client).ValidEFTSupplier then begin
        ResultStatus.AddItem(false, rssWarning, 0, 'This Supplier does not have all the Required Bank Account' + chr(13) +
                                'Details to use Electronic Funds Transfer !');
        Result := False;
        ClientInvalid4EFT := True;
        if OpenDetailform then if Assigned(fGetEFTDetails) then GetEFTDetails;
        Exit;
    end;
    if  not GLAccount.ValidEFTAccount then begin
        ResultStatus.AddItem(false, rssWarning, 0, 'The GL Bank Account ('+GLAccount.AccountName+') does not have all the Required Bank Account' + chr(13) +
                                'Details to use Electronic Funds Transfer !');
        Result := False;
        BankAccountInvalid4EFT := true;
        if OpenDetailform then if Assigned(fGetEFTDetails) then GetEFTDetails;
        Exit;
    end;
end;
Function TsuppPrepayments.ValidateData:Boolean;
begin
    Result := inherited ValidateData;
    if not result then Exit;
    if AddToEFT then REsult := Valid4EFT;
end;
Procedure TSuppPrepayments.UpdateLastChequeNo;
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

Function TSuppPrepayments.Save:Boolean;
begin
    REsult := inherited Save;
    if not Result then Exit;
    CreateABARecord;
    Dirty := False;
    if result then UpdateLastChequeNo;
end;
procedure TSuppPrePayments.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ChequePrinted'            ,ChequePrinted           );
end;

procedure TSuppPrePayments.setChequePrinted(const Value: Boolean);
begin
  SetBooleanField('ChequePrinted' , Value);
end;

Procedure TSuppPrePayments.CreateABARecord;
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
    ABAObj.Amount                   := PayAmount;
    ABAObj.AccountName              := Client.BankAccountName;
    ABAObj.TransType                := 'Supp Prepay';
    ABAObj.LodgementReferences      := ABAObj.TransType + '  ' + IntToStr(ID)+ ' ' + appenv.CompanyInfo.Companyname;
    ABAObj.Apply                    := False;
    ABAObj.AccountID                := BankAccountID;
    ABAObj.TransID                  := ID;
    ABAObj.NameofRemitter           := Self.CompanyName;
    ABAObj.PostDB;
end;
Constructor  TSuppPrePayments.Create(AOwner      : TComponent);
begin
    inherited Create(AOwner);
    fBusObjectTypeDescription:= 'SuppPrePayments';
end;
Function TSuppPrePayments.IsPrepaymentApplied:Boolean;
Var
  LockManagement :TLockManagement;
begin
  LockManagement := TLockManagement.Create;
  try
    Result :=  LockManagement.SupplierPrepaymentApplied(ID);
  finally
    LockManagement.Free;
  end;
end;
Function TSuppPrePayments.GetPrepaymentAccountID : Integer;
begin
    REsult := tcDatautils.GetAccountID(GLACCOUNT_SUPPPREPAYMENT);
end;
function TSuppPrePayments.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
    Result       := inherited DoAfterInsert(Sender);
    if not Result then exit;
    PayMethodID  := AppEnv.CompanyPrefs.DefaultPayMethodID;
end;

Procedure TSuppPrePayments.DoFieldOnChange   (Sender             : TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.fieldname , 'clinetID') then begin
        Valid4EFT(true);
    end else if Sysutils.SameText(Sender.fieldName , 'BankAccountID') then begin
        Valid4EFT(true);
        MakeChequeno;
    end else if Sysutils.SameText(Sender.FieldName, 'PaymethodId') then begin
      MakeChequeno;
    end;
end;
Procedure TSuppPrePayments.MakeChequeno;
begin
        if Sysutils.SameText(tcDatautils.GetPaymentMethod(PaymethodID) , 'Cheque') and (BankAccountID<>0) then
          if (AppEnv.CompanyPrefs.UseAutoChequeNo) and (ReferenceNo ='') then
            ReferenceNo := IntToStr(GLAccount.Previouschequeno+1);

end;
Procedure TSuppPrePayments.OnDataIdChange    (const ChangeType   : TBusObjDataChangeType);
begin
    AddToEFT                := False;
    BankAccountInvalid4EFT  := False;
    clientInvalid4EFT       := False;
end;
procedure TSuppPrePayments.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetBooleanPropertyFromNode(node,'ChequePrinted');

end;

Function TSuppPrePayments.Lock: Boolean;
begin
    Result := inherited Lock;
    if not REsult then exit;
    if ABAObj.count = 1 then
        if not ABAObj.UserLock.Lock(ABAObj.BusObjectTableName, ABAObj.Id, Lockgroupname) then begin
            ResultStatus.AddItem(false, rssWarning, 0,
                    StringReplace(ABAObj.UserLock.LockMessage , 'Unable to update data.' ,'Unable to update the E.F.T. details.' , [rfReplaceAll, rfIgnoreCase]));
            result := False;
        end;
end;
function TSuppPrePayments.getReconciliations(const TransLockType: TTransLockType): Boolean;
Var
  LockManagement :TLockManagement;
  ResultLocked :Boolean;
  ResultTransLockType :TTransLockType;
begin
  LockManagement := TLockManagement.Create;
  try
    ResultLocked := LockManagement.IsSupplierPrepaymentLocked(ID,ResultTransLockType);
    Result :=  ResultLocked and (ResultTransLockType=TransLockType);
  finally
    LockManagement.Free;
  end;
end;

{TCustPrePayments}
Function TCustPrePayments.Lock: Boolean;
begin
    Result := inherited Lock;
    if not REsult then exit;
end;
Function TCustPrePayments.Save:Boolean;
begin
    Result := inherited Save;
    if not result then Exit;
    Dirty := False;
end;
Function TCustPrePayments.IsPrepaymentApplied:Boolean;
Var
  LockManagement :TLockManagement;
begin
  LockManagement := TLockManagement.Create;
  try
    result := LockManagement.CustomerPrepaymentApplied(ID);
  finally
    LockManagement.Free;
  end;
end;
procedure TCustPrePayments.ApplyToInvoice(const InvoiceID: Integer;var invoiceBalance:Double);
var
    CustPayments :TCustPayments;
    fdPayment:Double;
    Qry :TERPQuery;
    x:Integer;
begin
    CustPayments :=TCustPayments.Create(Self);
    try
      CustPayments.Connection :=Self.Connection;
      CustPayments.Load(0);
      CustPayments.UserLock.IgnoreClassnameinLock:= True;
      CustPayments.BusObjEvent := Self.BusObjEvent;
      CustPayments.connection.BeginNestedTransaction;
      try
        CustPayments.New;
        CustPayments.ClientID := Self.ClientId;
        CustPayments.Customer := True;
        CustPayments.ForeignExchangeCode :=Self.ForeignExchangeCode;
        CustPayments.ForeignExchangeRate :=Self.ForeignExchangeRate;
        CustPayments.PaymentDate :=Date;
        {binny : All the following is copied from the prepayment
        each prepayment is applied as a separtae payment as the followinf informations can be different.}
        CustPayments.PayMethodID:=Self.PayMethodID;
        CustPayments.ReferenceNo :=Self.ReferenceNo;
        CustPayments.ClassID :=Self.ClassID;
        CustPayments.BankAccountName :=Self.BankAccountName;
        CustPayments.BankAccountNo :=Self.BankAccountNo;
        CustPayments.PostDB;
        CustPayments.GUILines;

        {Create the gui line record for the invoice ad GUI line loads empty when not in GUIMODE}
        if not CustPayments.GUILines.Locate('Type;SaleID' , vararrayof(['Invoice' , invoiceid]), []) then begin
              qry := DbSharedObjectsObj.DbSharedObj.GetQuery(CustPayments.Connection.Connection);
              try
                SalesOutStandingTrans(qry, ClientId, 'Invoice' , invoiceid);
                qry.Open;
                while not qry.Eof do begin
                  CustPayments.GUILines.New;
                  for x:= 0 to qry.FieldCount -1 do begin
                      try
                        CustPayments.GUILines.EditDB;
                        CustPayments.GUILines.dataset.fieldbyname(qry.Fields[x].fieldname).Value:= qry.Fields[x].Value;
                      Except
                        on E:EXception do begin
                        end;
                      end;
                  end;
                  CustPayments.GUILines.Postdb;
                  qry.Next;
                end;

              finally
                DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
              end;
        end;

        if CustPayments.GUILines.Locate('Type;SaleID' , vararrayof(['Invoice' , invoiceid]), []) then begin
          CustPayments.GUILines.Applied := TRue;
          if Self.Balance >invoiceBalance then
              CustPayments.GUILines.Payment :=invoiceBalance
          else CustPayments.GUILines.Payment := Self.Balance;
          fdPayment:=CustPayments.GUILines.Payment;
          CustPayments.GUILines.PostDb;
        end else begin
          CustPayments.Connection.RollbackNestedTransaction;
          exit;
        end;

        if not CustPayments.GUILines.Locate('Type;SaleID' , vararrayof(['Prepayment' , Self.id]), []) then begin
              qry := DbSharedObjectsObj.DbSharedObj.GetQuery(CustPayments.Connection.Connection);
              try
                SalesOutStandingTrans(qry, ClientId, 'Prepayment' , Self.id);
                qry.Open;
                while not qry.Eof do begin
                  CustPayments.GUILines.New;
                  for x:= 0 to qry.FieldCount -1 do begin
                      try
                        CustPayments.GUILines.EditDB;
                        CustPayments.GUILines.dataset.fieldbyname(qry.Fields[x].fieldname).Value:= qry.Fields[x].Value;
                      Except
                        on E:EXception do begin
                        end;
                      end;
                  end;
                  CustPayments.GUILines.Postdb;
                  qry.Next;
                end;

              finally
                DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
              end;
        end;


        if CustPayments.GUILines.Locate('Type;SaleID' , vararrayof(['Prepayment' , Self.id]), []) then begin
          CustPayments.GUILines.Applied := TRue;
          CustPayments.GUILines.Payment :=0-fdPayment;
          CustPayments.GUILines.PostDB;
        end else begin
          CustPayments.Connection.RollbackNestedTransaction;
          exit;
        end;

        CustPayments.CalcTotals;
        if not CustPayments.Save then begin
          CustPayments.Connection.RollbackNestedTransaction;
          Exit;
        end;



        CustPayments.Connection.CommitNestedTransaction;
        invoiceBalance:= invoiceBalance -fdPayment;
      Except
        on E:Exception do begin
          MessageDlgXP_Vista('Linking the prepayment to invoice Failed.'+NL+NL+E.Message, mtWarning, [mbOK], 0);
          CustPayments.Connection.RollbackNestedTransaction;
        end;
      end;
    finally
      Freeandnil(CustPayments);
    end;
end;

Constructor  TCustPrePayments.Create(AOwner      : TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'CustPrePayments';
  ExportExcludeList.Add('repid');
end;

procedure TCustPrePayments.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.fieldname , 'RepID') then begin
      RepName := TEmployee.IDToggle(RepID, Connection.Connection);
    end
    else if Sysutils.SameText(Sender.fieldname , 'RepName') then begin
      RepID := TEmployee.IDToggle(RepName, Connection.Connection);
    end;

end;

Function  TCustPrePayments.IsPrepaymentDeposited:Boolean;
Var
  LockManagement :TLockManagement;
  ResultLocked :Boolean;
  ResultTransLockType :TTransLockType;
begin
  LockManagement := TLockManagement.Create;
  try
    ResultLocked := LockManagement.IsCustomerPrepaymentLocked(ID,ResultTransLockType);
    Result :=  ResultLocked and (ResultTransLockType=ltDeposited);
  finally
    LockManagement.Free;
  end;
end;

Function TCustPrePayments.GetPrepaymentAccountID : Integer;
begin
    REsult := tcDatautils.GetAccountID(GLACCOUNT_CUSTPREPAYMENT);
end;
Class Function  TCustPrePayments.getTranstype:String;
begin
    Result := CUSTOMER_PREPAYMENT;
end;

function TCustPrePayments.getReconciliations(const TransLockType: TTransLockType): Boolean;
Var
  LockManagement :TLockManagement;
  ResultLocked :Boolean;
  ResultTransLockType :TTransLockType;
begin
  LockManagement := TLockManagement.Create;
  try
    ResultLocked := LockManagement.IsCustomerPrepaymentLocked(ID,ResultTransLockType);
    Result :=  ResultLocked and (ResultTransLockType=TransLockType);
  finally
    LockManagement.Free;
  end;
end;

function TCustPrePayments.getRepId: Integer;
begin
  REsult := getintegerfield('RepId');
end;

function TCustPrePayments.getRepName: String;
begin
    REsult := getstringfield('Repname');
end;

procedure TCustPrePayments.setRepName(const Value: String);
begin
    setStringfield('Repname', value);
end;

function TCustPrePayments.ValidateData: Boolean;
begin
  result := inherited;
  if not result then exit;

  if self.Deleted and TCardPayment.PaymentMade('CustomerPrepayment',ID,Connection.Connection.Database,Connection.Connection.Server) then begin
    AddResult(False, rssWarning, 0 ,'Can not delete a payment with a Card Payment.');
    Result := False;
    Exit;
  end;

end;

procedure TCustPrePayments.setRepID(const Value: Integer);
begin
    setintegerfield('RepId', Value);
end;

procedure TCustPrePayments.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'RepId'           );
  SetPropertyFromNode(node,'RepName'        );

end;

procedure TCustPrePayments.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'RepId'            ,RepId           );
  AddXMLNode(node,'repname'         ,Repname        );

end;

initialization
  RegisterClassOnce(TPrePayments);
  RegisterClass(TCustomerPrepayment);

end.
