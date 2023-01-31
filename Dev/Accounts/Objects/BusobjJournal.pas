unit BusobjJournal;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  07/09/07  1.00.01  bs  Initial Version.
  }


interface


uses
  BusObjBase, DB, Classes,  BusObjGLAccount,BusobjTaxCodes,
  BusObjclient, busObjBankDepost, tcTypes, XMLDoc, XMLIntf, MyAccess,
  ERPdbComponents, ApprovalObj;


type

  TJournalEntryLines = class(TMSBusObj)
  private
    fAccount                        : TAccount  ;
    fTaxCodeobj                     : TTaxCode  ;
    fClient                         : TClient ;
    fInvalidLineId: integer;
    fiLinesOrder :Integer;
    Function GetGJID                : Integer   ;
    Function GetAccountName         : String    ;
    Function GetAccountID           : Integer   ;
    Function GetAccountNumber       : String    ;
    Function GetDebitAmount         : Double    ;
    Function GetDebitAmountInc      : Double    ;
    Function GetCreditAmount        : Double    ;
    Function GetCreditAmountInc     : Double    ;
    Function GetTaxCode             : String    ;
    Function GetTaxCodeID           : Integer   ;
    Function GetTaxRate             : Double    ;
    Function GetTaxAmount           : Double    ;
    Function GetMemo                : String    ;
    Function GetManCOGSAdjustmentMemo: String    ;
    Function GetClientName          : String    ;
    Function GetClientID            : Integer   ;
    Function GetDeptName            : String    ;
    Function GetClassID             : Integer   ;
    Function GetEmployeeId          : Integer   ;
    Function GetLinesOrder          : Integer   ;
    Function GetReconciled          : Boolean   ;
    Function GetEmployeeName        : String    ;
    Function getAreaCode            : String    ;
    Function getHeaderID            : Integer   ;
    function GetAccount             : TAccount  ;
    Function getClient              : TClient   ;
    Function GetTaxCodeobj          : TTaxCode  ;
    Function getIsAccountTypeBank   : Boolean   ;
    function getBankDeposit         : TBankDeposit;
    function getDeleted             : Boolean   ;
    Procedure SetGJID               (const Value: Integer   );
    Procedure SetAccountName        (const Value: String    );
    Procedure SetAccountID          (const Value: Integer   );
    Procedure SetAccountNumber      (const Value: String    );
    Procedure SetDebitAmount        (const Value: Double    );
    Procedure SetDebitAmountInc     (const Value: Double    );
    Procedure SetCreditAmount       (const Value: Double    );
    Procedure SetCreditAmountInc    (const Value: Double    );
    Procedure SetTaxCode            (const Value: String    );
    Procedure SetTaxCodeID          (const Value: Integer   );
    Procedure SetTaxRate            (const Value: Double    );
    Procedure SetTaxAmount          (const Value: Double    );
    Procedure SetMemo               (const Value: String    );
    Procedure SetManCOGSAdjustmentMemo(const Value: String    );
    Procedure SetClientName         (const Value: String    );
    Procedure SetClientID           (const Value: Integer   );
    Procedure SetDeptName           (const Value: String    );
    Procedure setEmployeeId         (const Value: Integer   );
    Procedure setLinesOrder         (const Value: Integer   );
    Procedure setClassID            (const Value: Integer   );
    Procedure SetReconciled         (const Value: Boolean   );
    Procedure SetEmployeeName       (const Value: String    );
    Procedure SetAreaCode           (const Value: String    );
    Procedure SetAccount            (Const Value: TAccount  );
    procedure SetTaxCodeObj         (Const Value: TTaxCode  );
    Procedure SetDeleted            (Const Value: Boolean   );
    Function  Isemptyrecord         : boolean;
    procedure RefreshJournalTotals;
    function getLineAmountsValid: Boolean;
    procedure ResetLinesOrder(Sender:TBusObj);
    function getLineInserting: Boolean;
    procedure setLineInserting(const Value: Boolean);
  Protected
    Procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    Procedure DoFieldOnChange(Sender: TField);                           override;
    Function  GetSQL: String;                                            override;
    Function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    Function  DoBeforePost(Sender: TDatasetBusObj): Boolean;             override;
    Function  DoAfterInsert(Sender: TDatasetBusObj): Boolean;            override;
    Function  DoBeforeInsert(Sender: TDatasetBusObj): Boolean;            override;
    function  GetCleanXMLNode: IXMLNode;                                 Override;
    Procedure CreateInstance; Override;
  Public
    class Function  GetIDField: String;                                  override;
    class function GetKeyStringField: string; override;
    class function GetBusObjectTablename: string; Override;
    class function AccountNumberToggle(const ID: Integer; Connection: TCustomMyConnection = nil): string; overload;
    class function AccountNumberToggle(const aAccountNumber: string; Connection: TCustomMyConnection = nil): integer; overload;
    Constructor  Create             (AOwner: TComponent);                override;
    Destructor   Destroy;                                                override;
    Procedure    LoadFromXMLNode    (const node: IXMLNode);              override;
    Procedure    SaveToXMLNode      (const node: IXMLNode);              override;
    Function     ValidateData       : Boolean ;                          override;
    Function     Save               : Boolean ;                          override;
    Property     HeaderId           : Integer       Read getHeaderID;
    Property     Account            : TAccount      Read getAccount      Write SetAccount;
    Property     Client             : TClient       Read getClient       Write fclient;
    Property     TaxCodeObj         : TTaxcode      Read getTaxcodeObj   Write SetTaxcodeObj;
    Property     IsAccountTypeBank  : Boolean       Read getIsAccountTypeBank;
    Property     BankDeposit        : TBankDeposit  Read getBankDeposit;
    property InvalidLIneId: integer read fInvalidLineId write fInvalidLineId;
    Property LineAmountsValid :Boolean read getLineAmountsValid;
    property Reconciled         : Boolean   Read GetReconciled        Write SetReconciled     ;
    procedure OnCreditAmtIncChange;
    procedure OnDebitAmtIncChange;
    Property LineInserting :Boolean read getLineInserting write setLineInserting;
  Published
    property GJID               : Integer   Read GetGJID              Write SetGJID           ;
    property AccountName        : String    Read GetAccountName       Write SetAccountName    ;
    property AccountID          : Integer   Read GetAccountID         Write SetAccountID      ;
    property AccountNumber      : String    Read GetAccountNumber     Write SetAccountNumber  ;
    property DebitAmount        : Double    Read GetDebitAmount       Write SetDebitAmount    ;
    property DebitAmountInc     : Double    Read GetDebitAmountInc    Write SetDebitAmountInc ;
    property CreditAmount       : Double    Read GetCreditAmount      Write SetCreditAmount   ;
    property CreditAmountInc    : Double    Read GetCreditAmountInc   Write SetCreditAmountInc;
    property TaxAmount          : Double    Read GetTaxAmount         Write SetTaxAmount      ;
    property TaxCode            : String    Read GetTaxCode           Write SetTaxCode        ;
    property TaxCodeID          : Integer   Read GetTaxCodeID         Write SetTaxCodeID      ;
    property TaxRate            : Double    Read GetTaxRate           Write SetTaxRate        ;
    property Memo               : String    Read GetMemo              Write SetMemo           ;
    property ManCOGSAdjustmentMemo: String    Read GetManCOGSAdjustmentMemo Write SetManCOGSAdjustmentMemo;
    property ClientName         : String    Read GetClientName        Write SetClientName     ;
    property ClientID           : Integer   Read GetClientID          Write SetClientID       ;
    property DeptName           : String    Read GetDeptName          Write SetDeptName       ;
    property ClassID            : Integer   Read GetClassID           Write setClassID        ;
    property EmployeeId         : Integer   Read GetEmployeeId        Write setEmployeeId        ;
    property LinesOrder         : Integer   Read GetLinesOrder        Write setLinesOrder        ;
    property EmployeeName       : String    Read GetEmployeeName      Write SetEmployeeName   ;
    property AreaCode           : String    Read getAreaCode          Write SetAreaCode       ;
    Property Deleted            : Boolean   Read getDeleted           Write setDeleted        ;
  end;

  TJournalEntry = class(TMSBusObj)
  private
    fsLockMsg                       : String;
    AllLinesValid                   : Boolean;
    fdDebitAmount                   : Double;
    fdCreditAmount                  : Double;
    fdDebitAmountInc                : Double;
    fdDebitAmountExnTax             : Double;
    fdCreditAmountInc               : Double;
    fdCreditAmountExnTax            : Double;
    fdTaxAmount                     : Double;
    fbHasRetainedErnings            : Boolean;
    fLoading: boolean;
    fbcheckApprovalLevels: Boolean;
    fbLineInserting: Boolean;
    fbIsOneSide: Boolean;

    Function GetTransactionDate     : TDateTime ;
    Function GetTransactionNo       : String    ;
    Function GetAmount              : Double    ;
    Function GetTaxSelect           : String    ;
    Function GetDeleted             : Boolean   ;
    Function GetRepeated            : Integer   ;
    Function GetLines               : TJournalEntryLines;
    function GetDepositType         : String;
    function getIsJELocked          : TTransLockType;
    function GetTypeOfBasedOn   : String;
    function GetFrequencyValues : String;
    function GetCopyStartDate   : TDateTime;
    function GetCopyFinishDate  : TDateTime;

    function JournalEntryReconciled : Boolean   ;
    function JournalEntryOnHOLD     : Boolean   ;
    Procedure SetTransactionDate    (const Value: TDateTime );
    Procedure SetTransactionNo      (const Value: String    );
    Procedure SetAmount             (const Value: Double    );
    Procedure SetTaxSelect          (const Value: String    );
    Procedure SetDeleted            (const Value: Boolean   );
    Procedure SetRepeated           (const Value: Integer);
    Procedure UpdateAccountLines    (const Sender: TBusObj; var Abort: Boolean);
    Procedure ValidateLines         (const Sender: TBusObj; var Abort: Boolean);
    Procedure UpdateAccounts;
    Procedure UpdateDeposits;
    Procedure CreateDeposits        (const Sender: TBusObj; var Abort: Boolean);
    Procedure TotalLines            (const Sender: TBusObj; var Abort: Boolean);
    procedure DeleteFlaggedLines;
    procedure CloneLines(const Sender: TBusObj; var Abort: boolean);
    function GetApproved: boolean;
    procedure SetApproved(const Value: boolean);
    function GetMemo: string;
    procedure SetMemo(const Value: string);
    procedure SetTypeOfBasedOn(Const Value: String);
    procedure SetFrequencyValues(Const Value: String);
    procedure SetCopyStartDate(Const Value: TDateTime);
    procedure SetCopyFinishDate(Const Value: TDateTime);

  Protected
    Procedure OnDataIdChange (const ChangeType: TBusObjDataChangeType);Override;
    Procedure DoFieldOnChange(Sender: TField);                         Override;
    Function  GetSQL         : String;                                 Override;
    Function  DoAfterPost    (Sender: TDatasetBusObj): Boolean;        Override;
    Function  DoBeforePost   (Sender: TDatasetBusObj): Boolean;        Override;
    Function  DoAfterInsert  (Sender: TDatasetBusObj): Boolean;        Override;
    Function  DoAfterOpen    (Sender: TDatasetBusObj): Boolean;        Override;

  Public
    class Function  GetIDField     : String;                                 Override;
    class function GetBusObjectTablename: string; Override;
    Property     LockMsg              : String                Read fsLockMsg            Write fsLockMsg;
    Property     Deposittype          : String                Read GetDeposittype;
    Property     IsJELocked           : TTransLockType        Read getIsJELocked;
    Procedure    LoadFromXMLNode      (const node: IXMLNode);     Override;
    Procedure    SaveToXMLNode        (const node: IXMLNode);     Override;
    function     Lock                 : Boolean ;                 Override;
    Function     ValidateData         : Boolean ;                 Override;
    Function     Save                 : Boolean ;                 Override;
    Constructor  Create               (AOwner: TComponent);       Override;
    Destructor   Destroy;                                       Override;
    Function     ExportsubClasses(Const node: IXMLNode):Boolean;Override;
    Procedure    RefreshTotals;
    Procedure    ClonePropertyObjects; override;
    Property     checkApprovalLevels :Boolean read fbcheckApprovalLevels write fbcheckApprovalLevels;
    Property     LineInserting :Boolean read fbLineInserting write fbLineInserting;
    Property     IsOneSide            :Boolean read fbIsOneSide write fbIsOneSide;

  Published
    property TransactionDate     :TDateTime   Read GetTransactionDate   Write SetTransactionDate;
    property TransactionNo       :String      Read GetTransactionNo     Write SetTransactionNo  ;
    property Amount              :Double      Read GetAmount            Write SetAmount         ;
    property TaxSelect           :String      Read GetTaxSelect         Write SetTaxSelect      ;
    property Deleted             :Boolean     Read GetDeleted           Write SetDeleted        ;
    property Memo: string read GetMemo write SetMemo;
    property Approved: boolean read GetApproved write SetApproved;

    Property TotDebitAmount       : Double                Read fdDebitAmount        Write fdDebitAmount;
    Property TotCreditAmount      : Double                Read fdCreditAmount       Write fdCreditAmount;
    Property TotDebitAmountInc    : Double                Read fdDebitAmountInc     Write fdDebitAmountInc;
    Property TotDebitAmountExnTax : Double                Read fdDebitAmountExnTax  Write fdDebitAmountExnTax;
    Property TotCreditAmountInc   : Double                Read fdCreditAmountInc    Write fdCreditAmountInc;
    Property TotCreditAmountExnTax: Double                Read fdCreditAmountExnTax Write fdCreditAmountExnTax;
    Property TotTaxAmount         : Double                Read fdTaxAmount          Write fdTaxAmount;
    Property Lines                : TJournalEntryLines    Read GetLines             ;

    Property IsReconciled :boolean read JournalEntryReconciled;
    Property IsOnHOLD  :boolean read JournalEntryOnHOLD;
    Property TypeOfBasedOn      : String    read GetTypeOfBasedOn     write SetTypeOfBasedOn;
    Property FrequenctyValues   : String    read GetFrequencyValues   write SetFrequencyValues;
    Property CopyStartDate      : TDateTime read GetCopyStartDate     write SetCopyStartDate;
    Property CopyFinishDate     : TDateTime read GetCopyFinishDate    write SetCopyFinishDate;
    Property RepeatedFrom       : Integer   read GetRepeated          write SetRepeated;

  end;


implementation


uses tcDataUtils, CommonLib, AppEnvironment, sysutils,
  tcConst, DNMLib, TransLockManagementObj, BusObjConst, Variants,
  CommonDbLib, Math, LogLib;



      {TJournalEntry}

Constructor TJournalEntry.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fLoading := false;
  fBusObjectTypeDescription:= 'JournalEntry';
  fSQL := 'SELECT * FROM tblgeneraljournal';
  fbcheckApprovalLevels := True;
  fbIsOneSide := False;
end;


Destructor TJournalEntry.Destroy;
begin
  inherited;
end;


Procedure TJournalEntry.LoadFromXMLNode(const node: IXMLNode);
var
  LinesNode: IXMLNode;
  x: integer;
begin
    inherited;
    SetDatetimePropertyFromNode(node,'TransactionDate');
    SetPropertyFromNode(node,'TransactionNo');
    SetPropertyFromNode(node,'Amount');
    SetPropertyFromNode(node,'TaxSelect');

    SetPropertyFromNode(node,'TotDebitAmount');
    SetPropertyFromNode(node,'TotCreditAmount');
    SetPropertyFromNode(node,'TotDebitAmountInc');
    SetPropertyFromNode(node,'TotDebitAmountExnTax');
    SetPropertyFromNode(node,'TotCreditAmountInc');
    SetPropertyFromNode(node,'TotCreditAmountExnTax');
    SetPropertyFromNode(node,'TotTaxAmount');
    SetBooleanPropertyFromNode(node,'Approved');

    SetBooleanPropertyFromNode(node,'Deleted');
    Postdb;
    while Lines.Count > 0 do Lines.Delete;
    LinesNode := node.ChildNodes.FindNode(Lines.XMLBranchName);
    if Assigned(LinesNode) then begin
        for x := 0 to LinesNode.ChildNodes.Count - 1 do begin
            Lines.New;
            Lines.LoadFromXMLNode(LinesNode.ChildNodes[x]);
            Lines.PostDB;
        end;
    end;
end;


Procedure TJournalEntry.SaveToXMLNode(Const node: IXMLNode);
begin
  if fLoading then
    self.RefreshTotals;
  inherited;
  AddXMLNode(node,'TransactionDate' ,TransactionDate);
  AddXMLNode(node,'TransactionNo' ,TransactionNo);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'TaxSelect' ,TaxSelect);
  AddXMLNode(node,'Deleted' ,Deleted);

  AddXMLNode(node,'TotDebitAmount', TotDebitAmount);
  AddXMLNode(node,'TotCreditAmount', TotCreditAmount);
  AddXMLNode(node,'TotDebitAmountInc', TotDebitAmountInc);
  AddXMLNode(node,'TotDebitAmountExnTax', TotDebitAmountExnTax);
  AddXMLNode(node,'TotCreditAmountInc', TotCreditAmountInc);
  AddXMLNode(node,'TotCreditAmountExnTax', TotCreditAmountExnTax);
  AddXMLNode(node,'TotTaxAmount', TotTaxAmount);
  AddXMLNode(node,'Approved', Approved);

  ExportsubClasses(node);
end;
Function    TJournalEntry.ExportsubClasses(Const node: IXMLNode):Boolean;
begin
    self.Lines.XMLPropertyNode := node.AddChild('Lines');
    self.Lines.XMLPropertyName:= XMLNodeName+'Line';
    self.Lines.IterateRecords(GetPropertyXMLCallback);
    REsult := True;
end;

Function TJournalEntry.ValidateData: Boolean ;
var
  ErrMsg: string;
begin
  Result := False;
  Resultstatus.Clear;
  PostDB;

  if checkApprovalLevels then
    if not TApprovalCheck.Approved(self) then
      Exit;

  if not IsOneSide then begin
    if not Math.SameValue(self.TotDebitAmountInc, self.TotCreditAmountInc, 0.00001) then begin
      ErrMsg := 'Journal entry is not Balanced.' + chr(13) + chr(13) +
            '    - Total Debit  Amount  = ' + FloatToStrF(TotDebitAmountInc ,ffCurrency, 15, 5) + ' (Inc) ' + chr(13) +
            '    - Total Credit Amount  = ' + FloatToStrF(TotCreditAmountInc,ffCurrency,15, 5)+ ' (Inc) ' ;
        if Math.SameValue(abs(self.TotDebitAmountInc),abs(self.TotCreditAmountInc),0.00001) then
          ErrMsg := ErrMsg + NL +NL+'Note : Both Credit and Debit Expect to be Positive';
        REsultStatus.AddItem(False, rssError, 0, ErrMsg);
        Exit;
    end;

    if not Math.SameValue(self.totDebitAmountExnTax, self.totCreditAmountExnTax, 0.00001) then begin
      ErrMsg := 'Journal entry is not Balanced.' + chr(13) + chr(13) +
            '    - Total Debit  Amount  = ' + FloatToStrF(totDebitAmountExnTax ,ffCurrency, 15, 5) + ' (Ex+Tax) ' + chr(13) +
            '    - Total Credit Amount  = ' + FloatToStrF(totCreditAmountExnTax,ffCurrency,15, 5)+ ' (Ex+Tax) ';
      if Math.SameValue(abs(self.totDebitAmountExnTax),abs(self.totCreditAmountExnTax),0.00001) then
        ErrMsg := ErrMsg + NL +NL+'Note : Both Credit and Debit Expect to be Positive';
      REsultStatus.AddItem(False  , rssError, 0 , ErrMsg);
      Exit;
    end;
  end;

  if (TransactionDate <= AppEnv.CompanyPrefs.ClosingDate) then begin
    ErrMsg := 'Date is before the Global closing date!' + chr(13)+
              'This date will automatically be set to today''s date.';
    ResultStatus.AddItem(True, rsswarning, 0, ErrMsg);
    TransactionDate := Now;
    PostDB;
  end;

  AllLinesValid := true;
  fbHasRetainedErnings := False;
  Lines.InvalidLIneId := 0;
  Lines.IterateRecords(ValidateLines);
  if not AllLinesValid then
    Lines.Locate('GJDID',Lines.InvalidLIneId,[]);
  Result := AllLinesValid;
  if result then
    if fbHasRetainedErnings then
      AddResult(False, rssWarning, 0, 'You are creating a Journal Entry for account "Retained Earnings", We suggest to use "Retained Earnings Adjustments" instead.');
end;

Procedure TJournalEntry.ValidateLines(const Sender: TBusObj; var Abort: Boolean);
begin
    if  not (sender is TJournalEntryLines) then exit;
    if not TJournalEntryLines(Sender).ValidateData then allLinesValid := False;
    if sametext(TJournalEntryLines(Sender).Accountname , 'Retained Earnings') then fbHasRetainedErnings := True;
    if not allLinesValid then Abort := true;
end;

Procedure    TJournalEntry.RefreshTotals;
begin
    Lines.PostDB;
    fdDebitAmount                   := 0;
    fdCreditAmount                  := 0;
    fdDebitAmountInc                := 0;
    fdDebitAmountExnTax             := 0;
    fdCreditAmountInc               := 0;
    fdCreditAmountExnTax            := 0;
    fdTaxAmount                     := 0;
    Lines.IterateRecords(TotalLines);
    fdDebitAmount       := Round(fdDebitAmount        , RoundPlacesGeneral);
    fdCreditAmount      := Round(fdCreditAmount       , RoundPlacesGeneral);
    fdDebitAmountInc    := Round(fdDebitAmountInc     , RoundPlacesGeneral);
    fdDebitAmountExnTax := Round(fdDebitAmountExnTax  , RoundPlacesGeneral);
    fdCreditAmountInc   := Round(fdCreditAmountInc    , RoundPlacesGeneral);
    fdCreditAmountExnTax:= Round(fdCreditAmountExnTax , RoundPlacesGeneral);
    fdTaxAmount         := Round(fdTaxAmount          , RoundPlacesGeneral);
    SendEvent(BusObjEvent_Change, BusObjEvent_TotalsChanged, self);
    if checkApprovalLevels then  TApprovalCheck.Approved(self);
end;

Procedure TJournalEntry.TotalLines            (const Sender: TBusObj; var Abort: Boolean);
begin
  if not TJournalEntryLines(sender).Deleted then begin
      fdDebitAmount       := fdDebitAmount          + TJournalEntryLines(sender).DebitAmount;
      fdCreditAmount      := fdCreditAmount         + TJournalEntryLines(sender).CreditAmount;
      fdDebitAmountInc    := fdDebitAmountInc       + TJournalEntryLines(sender).DebitAmountInc ;
      fdDebitAmountExnTax := fdDebitAmountExnTax    + TJournalEntryLines(sender).DebitAmount +iif(TJournalEntryLines(sender).DebitAmount<>0 , TJournalEntryLines(sender).TaxAmount,0);
      fdCreditAmountInc   := fdCreditAmountInc      + TJournalEntryLines(sender).CreditAmountInc ;
      fdCreditAmountExnTax:= fdCreditAmountExnTax   + TJournalEntryLines(sender).CreditAmount++iif(TJournalEntryLines(sender).CreditAmount<>0 , TJournalEntryLines(sender).TaxAmount,0);
      fdTaxAmount         := fdTaxAmount            + TJournalEntryLines(sender).TaxAmount ;
  end;
end;
Function TJournalEntry.Save: Boolean ;
begin
    if not dirty then begin
        result := True;
        Exit;
    end;
    Result      := False;
    if not ValidateData then Exit;
    PostList.Clear;
    UpdateAccounts;
    UpdateDeposits;
    Result      := inherited Save;
    if not PostList.Execute then begin
        Result  := False;
        Exit;
    end;
    DeleteFlaggedLines;
end;
procedure TJournalEntry.DeleteFlaggedLines;
var
  IsFiltered :Boolean;
  SavedAccessLevel: integer;
begin
    lines.Dataset.DisableControls;
    SavedAccessLevel:= lines.AccessManager.AccessLevel;
    lines.AccessManager.AccessLevel:= 1;
    try
      IsFiltered              := lines.Dataset.Filtered;
      lines.Dataset.Filtered  := false;
      if lines.Count > 0 then begin
          lines.First;
          while not lines.Dataset.Eof do begin
              if lines.Deleted then begin
                if not lines.Delete then begin
                  raise exception.Create('TJournalEntry.DeleteFlaggedLines - Deletion of flagged lines failed');
                  break;
                end;
              end
              else
                lines.Dataset.Next;
          end;
          lines.Dataset.Filtered := IsFiltered;
      end;
    finally
      lines.Dataset.EnableControls;
      lines.AccessManager.AccessLevel:= SavedAccessLevel;
    end;
end;
Procedure TJournalEntry.CreateDeposits(const Sender: TBusObj; var Abort: Boolean);
begin
    if not TJournalEntryLines(Sender).IsAccountTypeBank then Exit;
    {header}
    if TJournalEntryLines(Sender).Deleted then Exit;
    TJournalEntryLines(Sender).BankDeposit.New;
    TJournalEntryLines(Sender).BankDeposit.Depositdate          := TransactionDate;
    TJournalEntryLines(Sender).BankDeposit.PostDB;
    TJournalEntryLines(Sender).BankDeposit.EmployeeId           := 0;
    TJournalEntryLines(Sender).BankDeposit.classId              := 0;
    TJournalEntryLines(Sender).BankDeposit.AccountId            := TJournalEntryLines(Sender).AccountId;
    TJournalEntryLines(Sender).BankDeposit.Notes                := Memo;
    TJournalEntryLines(Sender).BankDeposit.Deposit              := Round(TJournalEntryLines(Sender).DebitAmount - TJournalEntryLines(Sender).CreditAmount, CurrencyRoundPlaces);
    TJournalEntryLines(Sender).BankDeposit.Deleted              := False;
    TJournalEntryLines(Sender).BankDeposit.PostDB;
    {details}
    TJournalEntryLines(Sender).BankDeposit.Lines.New;
    TJournalEntryLines(Sender).BankDeposit.Lines.PaymentID      := Self.ID;
    TJournalEntryLines(Sender).BankDeposit.Lines.TrnsType       := Deposittype;
    TJournalEntryLines(Sender).BankDeposit.Lines.CusID          := 0;
    TJournalEntryLines(Sender).BankDeposit.Lines.PayMethodID    := 0;
    TJournalEntryLines(Sender).BankDeposit.Lines.PaymentMethod  := DepositType;
    TJournalEntryLines(Sender).BankDeposit.Lines.PaymentDate    := TransactionDate;
    TJournalEntryLines(Sender).BankDeposit.Lines.Companyname    := '';
    TJournalEntryLines(Sender).BankDeposit.Lines.Referenceno    := Memo;
    TJournalEntryLines(Sender).BankDeposit.Lines.ClassId        := TJournalEntryLines(Sender).ClassId;
    TJournalEntryLines(Sender).BankDeposit.Lines.AccountID      := TJournalEntryLines(Sender).AccountId;
    TJournalEntryLines(Sender).BankDeposit.Lines.Amount         := Round(TJournalEntryLines(Sender).DebitAmount - TJournalEntryLines(Sender).CreditAmount, CurrencyRoundPlaces);
    TJournalEntryLines(Sender).BankDeposit.Lines.Name           := '';
    TJournalEntryLines(Sender).BankDeposit.Lines.Notes          := TJournalEntryLines(Sender).memo;
    TJournalEntryLines(Sender).BankDeposit.Lines.Customer       := False;
    TJournalEntryLines(Sender).BankDeposit.Lines.Supplier       := False;
    TJournalEntryLines(Sender).BankDeposit.Lines.Employee       := False;
    TJournalEntryLines(Sender).BankDeposit.Lines.contact        := false;
    TJournalEntryLines(Sender).BankDeposit.Lines.Deposited      := True;
    TJournalEntryLines(Sender).BankDeposit.Lines.Statementno    := 0;
    TJournalEntryLines(Sender).BankDeposit.Lines.PostDB;
end;
Procedure TJournalEntry.UpdateDeposits;
begin
    GetNewDataset('Delete  tblbankdeposit.*  FROM tblbankdeposit ' +
         ' INNER JOIN tblbankdepositlines ON  tblbankdepositlines.DepositID = tblbankdeposit.DepositID ' +
         ' WHERE tblbankdepositlines.PaymentID =' + IntToStr(ID) +
         ' AND tblbankdepositlines.TrnsType ="Journal Entry"  ' , True);
    GetNewDataset('Delete  tblbankdepositlines.*  FROM tblbankdepositlines ' +
         ' WHERE tblbankdepositlines.PaymentID =' + IntToStr(ID) +
         ' AND tblbankdepositlines.TrnsType ="Journal Entry"  ' , true);
    Lines.IterateRecords(CreateDeposits);
end;

Procedure TJournalEntry.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  fLoading := true;
  try
    inherited;
    RefreshTotals;
  finally
    fLoading := false;
  end;
end;


Procedure TJournalEntry.DoFieldOnChange(Sender: TField);
var
  ErrMsg :String;
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.fieldname , 'TransactionDate') then begin
        if (TransactionDate <= AppEnv.CompanyPrefs.ClosingDate) then begin
            ErrMsg := 'Date is before the Global closing date !' + chr(13)+
                       'This date will automatically be set to today''s date.';
            ResultStatus.AddItem(True  , rsswarning, 0 , ErrMsg);
            TransactionDate := Now;
            PostDB;
        end;
    end;
    if Sysutils.SameText(Sender.fieldname , 'Approved') then
    begin
      TApprovalCheck.Approved(self,Sender);
    end;
end;


Function TJournalEntry.GetSQL: String;
begin
  Result := inherited GetSQL;
end;


class Function TJournalEntry.GetIDField: String;
begin
  Result := 'GJID'
end;

class function TJournalEntry.GetBusObjectTablename: string;
begin
  Result := 'tblgeneraljournal';
end;


Function  TJournalEntry.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
    Result := inherited DoAfterInsert(Sender);
    if not result then Exit;
    TaxSelect       := 'INPUT';
    TransactionDate := Now;
end;
function TJournalEntry.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterOpen(Sender);
  if not result then exit;
  LineInserting := False;
end;

Function  TJournalEntry.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
    Result := inherited DoBeforePost(Sender);
    if not result then exit;
end;
Function TJournalEntry.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then Exit;
  if (TransactionNo = '') or (TransactionNo = '0') then  begin
    TransactionNo := IntToStr(ID);
    PostDB;
  end ;
end;
Function TJournalEntry.getDeposittype:String;
begin
    REsult := 'Journal Entry';
end;
Function TJournalEntry.GetLines:TJournalEntryLines;
begin
    result := TJournalEntryLines(Getcontainercomponent(TJournalEntryLines ,'GJID = ' + IntToStr(Self.ID)));
end;
function TJournalEntry.GetMemo: string;
begin
  result := GetStringField('Memo');
end;

function TJournalEntry.JournalEntryOnHOLD     : Boolean;
Var
  LockManagement :TLockManagement;
  ResultLocked :Boolean;
  ResultTransLockType :TTransLockType;
begin
  LockManagement := TLockManagement.Create;
  try
    ResultLocked := LockManagement.IsJournalEntryLocked(ID,ResultTransLockType);
    Result :=  ResultLocked and (ResultTransLockType=ltOnHoldRec);
  finally
    LockManagement.Free;
  end;
end;

function TJournalEntry.JournalEntryReconciled : Boolean;
Var
  LockManagement :TLockManagement;
  ResultLocked :Boolean;
  ResultTransLockType :TTransLockType;
begin
  LockManagement := TLockManagement.Create;
  try
    ResultLocked := LockManagement.IsJournalEntryLocked(ID,ResultTransLockType);
    Result :=  ResultLocked and (ResultTransLockType=ltReconciled);
  finally
    LockManagement.Free;
  end;
end;

function TJournalEntry.getIsJELocked:TTransLockType;
begin
  Result := ltNone;
  if JournalEntryReconciled then  {RECONCILED}
      Result := ltReconciled
  else if JournalEntryOnHOLD then  {ON HOLD}
      Result := ltOnHoldRec;
end;
function  TJournalEntry.Lock:Boolean ;
begin
    result := False;
    LockMsg := '';
    if JournalEntryReconciled then  begin {RECONCILED}
        LockMsg := LockMsgReconciled;
        Exit;
    end else if JournalEntryOnHOLD then  begin {ON HOLD}
        LockMsg := LockMsgReconcileHold;
        Exit;
    end else if ValidateClosingDate(TransactionDate, false, false) then begin
        {function returns false when date is valid !!!!!}
        LockMsg := LockMsgClosingDate;
        Exit;
    end else Begin
      Result := inherited lock;
      if not Result then
        LockMsg := LockMsgInUse;
    end;

end;

Procedure TJournalEntry.UpdateAccountLines    (const Sender: TBusObj; var Abort: Boolean);
var
    CleanclientID       : Integer;
    CleanAccountID      : Integer;
    CleanDebitamountInc : Double;
    CleanCreditamountInc: Double;
    CleanDebitamount    : Double;
    CleanCreditamount   : Double;
    CleanTaxAmount      : Double;
    CleanNode           : IXMLNode;
    cleanTaxSelect      : String;
begin
    CleanNode:= TJournalEntryLines(Sender).CleanXMLNode;
    if assigned(CleanNode) then begin
        CleanAccountID      := GetXMLNodeIntegerValue(CleanNode,'AccountID');
        if CleanAccountID =0 then else begin
          CleanclientID       := GetXMLNodeIntegerValue(CleanNode,'ClientID');
          CleanTaxSelect      := GetXMLNodeStringValue(CleanXMLNode,'TaxSelect'); // TaxSelect is a property of header
          CleanDebitamountinc := GetXMLNodeFloatValue(CleanNode,'DebitamountInc');
          CleanCreditamountinc:= GetXMLNodeFloatValue(CleanNode,'CreditamountInc');
          CleanDebitamount    := GetXMLNodeFloatValue(CleanNode,'Debitamount');
          CleanCreditamount   := GetXMLNodeFloatValue(CleanNode,'Creditamount');
          CleanTaxAmount      := GetXMLNodeFloatValue(CleanNode,'TaxAmount');
          if (CleanDebitamount<> 0) or (cleanCreditAmount <> 0) then begin
              if cleanClientID <> 0 then //undo customer balance
                  if CleanDebitamount > 0 then
                      PostList.AddAmount('Client', 'tblClients' ,CleanclientID, -CleanDebitamountInc,btNormal, false)
                  else
                      PostList.AddAmount('Client', 'tblClients' ,CleanclientID, CleanCreditamountInc, btNormal,false);
              if CleanAccountID <> 0 then //undo account balance
                  if CleanDebitamount > 0 then
                      PostList.AddAmount('ChartOfAccounts', 'tblChartOfAccounts' ,CleanAccountID, - CleanDebitamount, btNormal,false)
                  else
                      PostList.AddAmount('ChartOfAccounts', 'tblChartOfAccounts' ,CleanAccountID, CleanCreditamount, btNormal,false);
          end;
          if CleanTaxAmount <> 0 then begin  //undo tax
              if CleanTaxSelect = 'INPUT' then
                  PostList.AddAmount('ChartOfAccounts', 'tblChartOfAccounts' ,getAccountID(GLACCOUNT_TAX_PAID),-(CleanTaxAmount), btNormal,false )
              else if CleanTaxSelect = 'OUTPUT' then
                  PostList.AddAmount('ChartOfAccounts', 'tblChartOfAccounts' ,getAccountID(GLACCOUNT_TAX_COLLECTED),(CleanTaxAmount) , btNormal,false);
          end;
        end;
    end;
    with TJournalEntryLines(Sender) do begin
        if (Debitamount <> 0) or (CreditAmount <> 0) then begin
            if TJournalEntryLines(Sender).ClientID <> 0 then //client balance
                if Debitamount > 0 then
                    PostList.AddAmount('Client', 'tblClients' ,TJournalEntryLines(Sender).clientID, DebitamountInc, btNormal,false)
                else
                    PostList.AddAmount('Client', 'tblClients' ,TJournalEntryLines(Sender).clientID, -CreditAmountInc, btNormal,false);
            if TJournalEntryLines(Sender).AccountID <> 0 then //account balance
                if Debitamount > 0 then
                    PostList.AddAmount('ChartOfAccounts', 'tblChartOfAccounts' ,TJournalEntryLines(Sender).AccountID,  Debitamount, btNormal,false)
                else
                    PostList.AddAmount('ChartOfAccounts', 'tblChartOfAccounts' ,TJournalEntryLines(Sender).AccountID, -CreditAmount, btNormal,false);
        End;
        if TaxAmount <> 0 then begin  //Tax
            if TaxSelect = 'INPUT' then
                PostList.AddAmount('ChartOfAccounts', 'tblChartOfAccounts' ,tcDatautils.getAccountID(GLACCOUNT_TAX_PAID),(TaxAmount) , btNormal,false)
            else if TaxSelect = 'OUTPUT' then
                PostList.AddAmount('ChartOfAccounts', 'tblChartOfAccounts' ,tcDatautils.getAccountID(GLACCOUNT_TAX_COLLECTED),-(TaxAmount) , btNormal,false);
        end;
    end;
end;
Procedure    TJournalEntry.UpdateAccounts;
begin
    Lines.IterateRecords(UpdateAccountLines, True); // should disable the filter to Save the deleted records
end;
{Property Functions}
Function  TJournalEntry.GetTransactionDate: TDateTime ; begin Result := GetDateTimeField('TransactionDate');end;
Function  TJournalEntry.GetTransactionNo  : String    ; begin Result := GetStringField('TransactionNo');end;
Function  TJournalEntry.GetAmount         : Double    ; begin Result := GetFloatField('Amount');end;
function TJournalEntry.GetApproved: boolean;
begin
  result := GetBooleanField('Approved');
end;

Function  TJournalEntry.GetTaxSelect      : String    ; begin Result := GetStringField('TaxSelect');end;
Function  TJournalEntry.GetDeleted        : Boolean   ; begin Result := GetBooleanField('Deleted');end;
Function  TJournalEntry.GetRepeated       : Integer   ; begin Result := GetIntegerField('RepeatedFrom');end;
Function  TJournalEntry.GetTypeOfBasedOn    : String;     Begin Result := GetStringField('TypeOfBasedOn'); End;
Function  TJournalEntry.GetFrequencyValues  : String;     Begin Result := GetStringField('FrequencyValues'); End;
Function  TJournalEntry.GetCopyStartDate    : TDateTime;  Begin Result := GetDateTimeField('CopyStartDate'); End;
Function  TJournalEntry.GetCopyFinishDate   : TDateTime;  Begin Result := GetDateTimeField('CopyFinishDate'); End;

Procedure TJournalEntry.SetTransactionDate(const Value: TDateTime ); begin SetDateTimeField('TransactionDate', Value);end;
Procedure TJournalEntry.SetTransactionNo  (const Value: String    ); begin SetStringField('TransactionNo'   , Value);end;
Procedure TJournalEntry.SetAmount         (const Value: Double    ); begin SetFloatField('Amount'          , Value);end;
Procedure TJournalEntry.SetTypeOfBasedOn(Const Value: String);       Begin  SetStringField('TypeOfBasedOn', Value);  End;
Procedure TJournalEntry.SetFrequencyValues(Const Value: String);     Begin  SetStringField('FrequencyValues', Value);  End;
Procedure TJournalEntry.SetCopyStartDate(Const Value: TDateTime);    Begin  SetDateTimeField('CopyStartDate', Value);  End;
Procedure TJournalEntry.SetCopyFinishDate(Const Value: TDateTime);   Begin  SetDateTimeField('CopyFinishDate', Value);  End;

procedure TJournalEntry.SetApproved(const Value: boolean);
begin
  SetBooleanField('Approved', Value);
end;

Procedure TJournalEntry.SetTaxSelect      (const Value: String    ); begin SetStringField('TaxSelect'       , Value);end;
Procedure TJournalEntry.SetDeleted        (const Value: Boolean   ); begin SetBooleanField('Deleted'         , Value);end;
Procedure TJournalEntry.SetRepeated       (const Value: Integer   ); begin SetIntegerField('RepeatedFrom'    , Value);end;

procedure TJournalEntry.SetMemo(const Value: string);
begin
  SetStringField('Memo',Value);
end;

procedure TJournalEntry.ClonePropertyObjects;
begin
    Lines.IterateRecords(CloneLines);
end;

procedure TJournalEntry.CloneLines(const Sender: TBusObj;  var Abort: boolean);
begin
  // copy line only if the line has records in it.
  if Sender.Dataset.REcordcount > 0 then begin
    Sender.CloneBusObj(IDFieldName , ObjInstanceToClone.ID, False);
    if Sender.ObjInstanceToClone  = nil then begin
        fbObjectCopied := False;
        Exit;
    end;
  end;
end;

{TJournalEntryLines}

Constructor TJournalEntryLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'JournalEntryLines';
  fSQL := 'SELECT * FROM tblgeneraljournaldetails';
  fInvalidLineId:= 0;
  fIsList:= true;
end;


procedure TJournalEntryLines.CreateInstance;
begin
    if Owner is TJournalEntry then
        if Assigned(TJournalEntry(Owner).ObjInstanceToClone) then
          if TJournalEntry(Owner).ObjInstanceToClone is TJournalEntry then
            ObjInstanceToClone :=TJournalEntry(TJournalEntry(Owner).ObjInstanceToClone).Lines;

end;

Destructor TJournalEntryLines.Destroy;
begin
  inherited;
end;


Procedure TJournalEntryLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'GJID');
  SetPropertyFromNode(node,'AccountNumber');
  SetPropertyFromNode(node,'AccountName');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'TaxCode');
  SetPropertyFromNode(node,'TaxCodeID');
  SetPropertyFromNode(node,'TaxRate');
  SetPropertyFromNode(node,'TaxAmount');
  SetPropertyFromNode(node,'DebitAmount');
  SetPropertyFromNode(node,'DebitAmountInc');
  SetPropertyFromNode(node,'CreditAmount');
  SetPropertyFromNode(node,'CreditAmountInc');
  SetPropertyFromNode(node,'Memo');
  SetPropertyFromNode(node,'ManCOGSAdjustmentMemo');
  SetPropertyFromNode(node,'ClientName');
  SetPropertyFromNode(node,'ClientID');
  SetPropertyFromNode(node,'DeptName');
  SetPropertyFromNode(node,'ClassID');
  SetPropertyFromNode(node,'EmployeeId');
  SetPropertyFromNode(node,'LinesOrder');
  SetBooleanPropertyFromNode(node,'Reconciled');
  SetPropertyFromNode(node,'EmployeeName');
  SetPropertyFromNode(node,'AreaCode');
  SetBooleanPropertyFromNode(node,'Deleted');
end;


Procedure TJournalEntryLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'GJID' ,GJID);
  AddXMLNode(node,'AccountName' ,AccountName);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'AccountNumber' ,AccountNumber);
  AddXMLNode(node,'DebitAmount' ,DebitAmount);
  AddXMLNode(node,'DebitAmountInc' ,DebitAmountInc);
  AddXMLNode(node,'CreditAmount' ,CreditAmount);
  AddXMLNode(node,'CreditAmountInc' ,CreditAmountInc);
  AddXMLNode(node,'TaxCode' ,TaxCode);
  AddXMLNode(node,'TaxCodeID' ,TaxCodeID);
  AddXMLNode(node,'TaxRate' ,TaxRate);
  AddXMLNode(node,'TaxAmount' ,TaxAmount);
  AddXMLNode(node,'Memo' ,Memo);
  AddXMLNode(node,'ManCOGSAdjustmentMemo' ,ManCOGSAdjustmentMemo);
  AddXMLNode(node,'ClientName' ,ClientName);
  AddXMLNode(node,'ClientID' ,ClientID);
  AddXMLNode(node,'DeptName' ,DeptName);
  AddXMLNode(node,'ClassID' ,ClassID);
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
  AddXMLNode(node,'LinesOrder' ,LinesOrder);
  AddXMLNode(node,'Reconciled' ,Reconciled);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'AreaCode' ,AreaCode);
  AddXMLNode(node,'Deleted', Deleted);
end;


Function TJournalEntryLines.ValidateData: Boolean ;
begin
    Result := False;
    if (AccountName = '') or (AccountId = 0) then begin
        AddResult(False, rssError , 0, 'Accountname should not be blank' );
        InvalidLineId:= Id;
        Exit;
    end;
    if (Account.AccountTypeName = 'AP') or (Account.AccountTypeName = 'AR') then
        if ClientId = 0 then begin
            AddResult(False, rssError , BOR_Journal_ClientBlank, 'Customer should not be blank for ' + Account.AccountName );
            InvalidLineId:= Id;
            Exit;
        end;
    if (Account.AccountTypeName = 'AP') and (not (client.Supplier))  then begin
        AddResult(False, rssError , BOR_Journal_ClientBlank, AccountName + ' requires supplier');
        InvalidLineId:= Id;
        Exit;
    end;
    if (Account.AccountTypeName = 'AR') and (not (client.Customer))  then begin
        AddResult(False, rssError , BOR_Journal_ClientBlank, AccountName + ' requires customer');
        InvalidLineId:= Id;
        Exit;
    end;
    if Math.IsZero(TaxRate,0.000001) and (not Math.IsZero(TaxAmount,0.000001)) then begin
        AddResult(False, rssError, 0, 'Zero Tax Rate ' + self.TaxCode + ' should not have a Tax Amount');
        InvalidLineId:= Id;
        Exit;
    end;
(*    if sametext(Accountname , 'Retained Earnings') then begin
        AddResult(False, rssWarning, 0, 'You are creating a Journal Entry for account "Retained Earnings", We suggest to use "Retained Earnings Adjustments" instead.');
        InvalidLineId:= Id;
        Exit;
    end;*)
    if (not Math.IsZero(DebitAmount)) and (not Math.IsZero(CreditAmount)) then begin
      AddResult(false, rssError, 0, 'Line can not have both a Debit and a Credit amount.');
      InvalidLineId:= Id;
      Exit;
    end;
    if (not Math.IsZero(DebitAmountInc)) and (not Math.IsZero(CreditAmountInc)) then begin
      AddResult(false, rssError, 0, 'Line can not have both a Debit(Inc) and a Credit(Inc) amount.');
      InvalidLineId:= Id;
      Exit;
    end;
    if (not Math.IsZero(TaxAmount)) then begin
      if (not Math.IsZero(DebitAmount)) then begin
        if not Math.SameValue(DebitAmount + TaxAmount, DebitAmountInc, 0.000001) then begin
          AddResult(false, rssError, 0, 'Line Debit(Inc) amount does not equal Debit + Tax Amount.');
          InvalidLineId:= Id;
          Exit;
        end;
      end
      else begin
        if not Math.SameValue(CreditAmount + TaxAmount, CreditAmountInc, 0.000001) then begin
          AddResult(false, rssError, 0, 'Line Credit(Inc) amount does not equal Credit + Tax Amount.');
          InvalidLineId:= Id;
          Exit;
        end;
      end;
    end;

    Result := True;
end;


Function TJournalEntryLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;
Function  TJournalEntryLines.Isemptyrecord         : boolean;
begin
    Result :=     (accountId    = 0)
              and (clientId     = 0)
              and (Debitamount  = 0)
              and (creditamount = 0)
              and (taxamount    = 0);
end;

function TJournalEntryLines.GetCleanXMLNode: IXMLNode;
begin
    REsult := inherited GetCleanXMLNode;
end;

Procedure TJournalEntryLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  FreeandNil(fAccount);
  FreeandNil(fTaxcodeObj);
end;
Procedure TJournalEntryLines.OnDebitAmtIncChange;
var
  fb:Boolean;
begin
  fb:= DoFieldChange;
  DoFieldChange := False;
  try
        Creditamount := 0;
        CreditamountInc:= 0;
        Debitamount:= Round(GetAmountEx(DebitamountInc, Taxrate), CurrencyRoundPlaces);
        TaxAmount:= DebitamountInc  - Debitamount;
        RefreshJournalTotals;
  finally
    DoFieldChange := fb;
  end;
end;
Procedure TJournalEntryLines.OnCreditAmtIncChange;
var
  fb:Boolean;
begin
  fb:= DoFieldChange;
  DoFieldChange := False;
  try
        Debitamount := 0;
        DebitamountInc := 0;
        Creditamount:= Round(GetAmountEx(CreditamountInc, Taxrate), CurrencyRoundPlaces);
        TaxAmount:= CreditamountInc - Creditamount;
        RefreshJournalTotals;
  finally
    DoFieldChange := fb;
  end;
end;
Procedure TJournalEntryLines.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;

      if Sysutils.SameText(Sender.fieldName , 'AccountNumber') then begin
      if trim(sender.AsString)<> '' then begin
        AccountId := AccountIDForNumber(AccountNumber);
        if AccountId <> 0 then  DoFieldOnChange(Dataset.findfield('AccountID'));
      end;
    end else if Sysutils.SameText(Sender.fieldName , 'AccountName') then begin
      if trim(sender.AsString)<> '' then begin
        AccountId := AccountIDForName(AccountName);
        if AccountId <> 0 then  DoFieldOnChange(Dataset.findfield('AccountID'));
      end;
    end else if Sysutils.SameText(Sender.fieldname,'classname') then begin
        classId := tcdatautils.GetDeptID(DeptName);
    end else if Sysutils.SameText(Sender.fieldname,'classId') then begin
        DeptName := tcdatautils.GetClassName(classid);
    end else if Sysutils.SameText(Sender.fieldname,'EmployeeName') then begin
        EmployeeId := tcdatautils.GetEmployeeID(EmployeEName);
    end else if Sysutils.SameText(Sender.FieldName , 'AccountID') then begin
        Account.Load(sender.AsInteger);
        if Account.AccountName <> '' then begin
          self.AccountName:= Account.AccountName;
          self.AccountNumber:= Account.AccountNumber;
          self.TaxCode:= Account.TaxCode;
          TaxcodeObj.LoadSelect('Name  = ' + QuotedStr(Self.Taxcode));
          if TaxCodeObj.ID > 0 then begin
            self.TaxCodeID:= TaxCodeObj.ID;
            self.TaxRate:= TaxCodeObj.Rate;
          end
          else begin
            self.TaxCode:= '';
            self.TaxCodeID:= 0;
            self.TaxRate:= 0;
          end;
        end
        else begin
          self.AccountID:= 0;
          self.AccountName:= '';
          self.AccountNumber:= '';
          self.TaxCode:= '';
        end;
        if DebitAmount <> 0 then begin
          DebitamountInc:= Round(GetAmountInc(Debitamount, Taxrate), CurrencyRoundPlaces);
          TaxAmount:= DebitamountInc  - Debitamount;
        end
        else if CreditAmount <> 0 then begin
          CreditamountInc:= Round(GetAmountInc(Creditamount, Taxrate), CurrencyRoundPlaces);
          TaxAmount:= CreditamountInc  - Creditamount;
        end;
        PostDB;
        RefreshJournalTotals;
        SendEvent(BusObjEvent_Change,BusObjEvent_AccountName, self);
    end else if Sysutils.SameText(Sender.fieldname, 'TaxRate') then begin
        if DebitAmount <> 0 then begin
          DebitamountInc:= Round(GetAmountInc(Debitamount, Taxrate), CurrencyRoundPlaces);
          TaxAmount:= DebitamountInc  - Debitamount;
        end
        else if CreditAmount <> 0 then begin
          CreditamountInc:= Round(GetAmountInc(Creditamount, Taxrate), CurrencyRoundPlaces);
          TaxAmount:= CreditamountInc  - Creditamount;
        end;
        RefreshJournalTotals;
    end else if Sysutils.SameText(Sender.fieldname, 'TaxAmount') then begin
        if DebitAmount <> 0 then begin
          DebitamountInc:= Round(Debitamount + TaxAmount, CurrencyRoundPlaces);
        end
        else if CreditAmount <> 0 then begin
          CreditamountInc:= Round(Creditamount + TaxAmount, CurrencyRoundPlaces);
        end;
        RefreshJournalTotals;
    end else if Sysutils.SameText(Sender.fieldname, 'Debitamount') then begin
        Creditamount := 0;
        CreditamountInc := 0;
        DebitamountInc:= Round(GetAmountInc(Debitamount, Taxrate), CurrencyRoundPlaces);
        TaxAmount:= DebitamountInc  - Debitamount;
        RefreshJournalTotals;
    end else if Sysutils.SameText(Sender.fieldname, 'CreditAmount') then begin
        Debitamount := 0;
        DebitamountInc := 0;
        CreditamountInc:= Round(GetAmountInc(Creditamount, Taxrate), CurrencyRoundPlaces);
        TaxAmount:= CreditamountInc - Creditamount;
        RefreshJournalTotals;
    end else if Sysutils.SameText(Sender.fieldname, 'CreditAmountInc') then begin
        OnCreditAmtIncChange;
    end else if Sysutils.SameText(Sender.fieldname, 'DebitamountInc') then begin
        OnDebitAmtIncChange;
    end else if Sysutils.SameText(Sender.fieldName,'Taxcode') then begin
        TaxcodeObj.LoadSelect('Name  = ' + QuotedStr(sender.AsString));
        if TaxCodeObj.ID > 0 then begin
          self.TaxCodeID:= TaxCodeObj.ID;
          self.TaxRate:= TaxCodeObj.Rate;
          if DebitAmount <> 0 then begin
            DebitamountInc:= Round(GetAmountInc(Debitamount, Taxrate), CurrencyRoundPlaces);
            TaxAmount:= DebitamountInc  - Debitamount;
          end  else if CreditAmount <> 0 then begin
            CreditamountInc:= Round(GetAmountInc(Creditamount, Taxrate), CurrencyRoundPlaces);
            TaxAmount:= CreditamountInc  - Creditamount;
          end;
        end else begin
          self.TaxCode    := '';
          self.TaxCodeID  := 0;
          self.TaxRate    := 0;
          if DebitamountInc <> 0 then DebitAmount :=DebitamountInc
          else if CreditamountInc <> 0 then CreditAmount :=CreditamountInc;
          TaxAmount:=0;
        end;
        RefreshJournalTotals;
    end else if Sysutils.SameText(Sender.fieldName , 'ClientName') then begin
        clientId := tcDatautils.getclientID(ClientName);
    end else if Sysutils.SameText(Sender.FieldName , 'ClassName') then begin
        classId := TcDatautils.GetDeptID(DeptName);
    end else if Sysutils.SameText(Sender.FieldName , 'EmployeeName') then begin
        EmployeeId := tcdatautils.GetEmployeeID(EmployeEName);
    end else if Sysutils.SameText(Sender.FieldName , 'Deleted') then begin
        RefreshJournalTotals;
    end;
end;

Function TJournalEntryLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
    Result      := inherited DoAfterInsert(Sender);
    if not result then Exit;
    GJID        := HeaderID;
    DeptName    := AppEnv.DefaultClass.DefaultClassName;
end;

Function TJournalEntryLines.GetSQL: String;
begin
  Result := inherited GetSQL;
end;

class Function TJournalEntryLines.GetIDField: String;
begin
    Result := 'GJDID'
end;

class function TJournalEntryLines.GetBusObjectTablename: string;
begin
  Result := 'tblgeneraljournaldetails';
end;

function TJournalEntryLines.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeInsert(Sender);
  if not result then exit;
  fiLinesOrder := LinesOrder;
  if LineInserting then fiLinesOrder := fiLinesOrder -5 else fiLinesOrder := fiLinesOrder+10;
end;
Function  TJournalEntryLines.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
    Result := inherited DoBeforePost(Sender);
    if not result then Exit;
end;
Function TJournalEntryLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
    Result := inherited DoAfterPost(Sender);
    if not result then Exit;
    if (ID <> 0 ) and (not deleted) and (Isemptyrecord) then begin
        Deleted := True;
        PostDB;
        SendEvent(BusObjEvent_Change, BusObjEventVal_LineDeleted, self);
        Exit;
    End;
    if (ID<>0) and (Linesorder =0) then begin
      if fiLinesOrder =0 then fiLinesOrder := 10;
      LinesOrder := fiLinesOrder;
      if Dataset.State in [dsEdit,dsInsert] then Dataset.Post;

      if (count > 1) and (LineInserting) then
        RunProc(ResetLinesOrder);
      LineInserting := False;
    end;
end;
Procedure TJournalEntryLines.ResetLinesOrder(Sender:TBusObj);
begin
  ReGenerateNumber('LinesOrder' , 10);
end;

Function TJournalEntryLines.getHeaderID           : Integer   ;
begin
    Result := 0;
    if Assigned(Self.Owner) then
        if Self.Owner is TJournalEntry then
            REsult := TJournalEntry(Self.Owner).ID;
end;
Function TJournalEntryLines.getIsAccountTypeBank   : Boolean;
begin
    Result := Account.IsAccountTypeBank;
end;
function TJournalEntryLines.getBankDeposit         : TBankDeposit;
begin
    PostDB;
    REsult :=  TBankDeposit(getContainerComponent(TBankDeposit , 'Details.Trnstype = "Journal Entry" and Details.PaymentId = ' + IntToStr(ID)));
end;
Function TJournalEntryLines.GetTaxCodeobj          : TTaxCode  ;
begin
    if not Assigned(fTaxcodeObj) then begin
        fTaxcodeObj := TTaxcode.Create(Self);
        fTaxcodeObj.Load(self.TaxCodeId);
    end;
    Result := fTaxcodeObj;
end;

Function  TJournalEntryLines.getClient :TClient;
begin
  if not Assigned(fClient) then begin
    fClient:= TClient.Create(Self);
    fClient.IgnoreAccesslevel := true;
    fClient.Connection:= GetDefaultConnection; // should be outside transaction
  end;

  if (self.ClientId > 0) and (self.ClientId <> fClient.ID) then begin
    fClient.LoadSelect('ClientId = ' + IntToStr(self.ClientId));
  end
  else if (self.ClientName <> '') and (self.ClientName <> fClient.ClientName) then begin
    fClient.LoadSelect('Company = ' + QuotedStr(self.ClientName));
  end else if (self.ClientId = 0)  then
    fClient.LoadSelect('ClientId = 0' );
  result:= fClient;
end;

Function  TJournalEntryLines.getAccount :TAccount;
begin
    if not Assigned(fAccount) then begin
      fAccount := TAccount.Create(Self);
      if self.AccountID <> fAccount.Id then
        fAccount.Load(self.AccountID);
    end;
    Result := fAccount;
end;
Procedure TJournalEntryLines.SetTaxCodeobj(Const value :TTAxCode);
begin
    fTaxCodeobj := Value;
end;
Procedure TJournalEntryLines.SetAccount(Const value :TAccount);
begin
    fAccount := value;
end;

{Property Functions}
Function  TJournalEntryLines.GetGJID           : Integer   ; begin Result := GetIntegerField('GJID');end;
Function  TJournalEntryLines.GetAccountName    : String    ; begin Result := GetStringField('AccountName');end;
Function  TJournalEntryLines.GetAccountID      : Integer   ; begin Result := GetIntegerField('AccountID');end;
Function  TJournalEntryLines.GetAccountNumber  : String    ; begin Result := GetStringField('AccountNumber');end;
Function  TJournalEntryLines.GetDebitAmount    : Double    ; begin Result := GetFloatField('DebitAmount');end;
Function  TJournalEntryLines.GetDebitAmountInc : Double    ; begin Result := GetFloatField('DebitAmountInc');end;
Function  TJournalEntryLines.GetCreditAmount   : Double    ; begin Result := GetFloatField('CreditAmount');end;
Function  TJournalEntryLines.GetCreditAmountInc: Double    ; begin Result := GetFloatField('CreditAmountInc');end;
Function  TJournalEntryLines.GetTaxCode        : String    ; begin Result := GetStringField('TaxCode');end;
Function  TJournalEntryLines.GetTaxCodeID      : Integer   ; begin Result := GetIntegerField('TaxCodeID');end;
Function  TJournalEntryLines.GetTaxRate        : Double    ; begin Result := GetFloatField('TaxRate');end;
Function  TJournalEntryLines.GetTaxAmount      : Double    ; begin Result := GetFloatField('TaxAmount');end;
Function  TJournalEntryLines.GetMemo           : String    ; begin Result := GetStringField('Memo');end;
Function  TJournalEntryLines.GetManCOGSAdjustmentMemo: String    ; begin Result := GetStringField('ManCOGSAdjustmentMemo');end;
Function  TJournalEntryLines.GetClientName     : String    ; begin Result := GetStringField('ClientName');end;
Function  TJournalEntryLines.GetClientID       : Integer   ; begin Result := GetIntegerField('ClientID');end;
Function  TJournalEntryLines.GetDeptName       : String    ; begin Result := GetStringField('ClassName');end;
Function  TJournalEntryLines.GetClassID        : Integer   ; begin Result := GetIntegerField('ClassID');end;
Function  TJournalEntryLines.GetEmployeeId     : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
Function  TJournalEntryLines.GetLinesOrder     : Integer   ; begin Result := GetIntegerField('LinesOrder');end;
Function  TJournalEntryLines.GetReconciled     : Boolean   ; begin Result := GetBooleanField('Reconciled');end;
Function  TJournalEntryLines.GetDeleted        : Boolean   ; begin Result := GetBooleanField('Deleted');end;
Function  TJournalEntryLines.GetEmployeeName   : String    ; begin Result := GetStringField('EmployeeName');end;
Function  TJournalEntryLines.getAreaCode       : String    ; begin Result := GetStringField('AreaCode');end;
Procedure TJournalEntryLines.SetGJID           (const Value: Integer   ); begin SetIntegerField('GJID'          , Value);end;
Procedure TJournalEntryLines.SetAccountName    (const Value: String    ); begin SetStringField('AccountName'    , Value);end;
Procedure TJournalEntryLines.SetAccountID      (const Value: Integer   ); begin SetIntegerField('AccountID'     , Value);end;
Procedure TJournalEntryLines.SetAccountNumber  (const Value: String    ); begin SetStringField('AccountNumber'  , Value);end;
Procedure TJournalEntryLines.SetDebitAmount    (const Value: Double    ); begin SetFloatField('DebitAmount'     , Value);end;
Procedure TJournalEntryLines.SetDebitAmountInc (const Value: Double    ); begin SetFloatField('DebitAmountinc'  , Value);end;
Procedure TJournalEntryLines.SetCreditAmount   (const Value: Double    ); begin SetFloatField('CreditAmount'    , Value);end;
Procedure TJournalEntryLines.SetCreditAmountInc(const Value: Double    ); begin SetFloatField('CreditAmountinc' , Value);end;
Procedure TJournalEntryLines.SetTaxCode        (const Value: String    ); begin SetStringField('TaxCode'        , Value);end;
Procedure TJournalEntryLines.SetTaxCodeID      (const Value: Integer   ); begin SetIntegerField('TaxCodeID'     , Value);end;
Procedure TJournalEntryLines.SetTaxRate        (const Value: Double    ); begin SetFloatField('TaxRate'         , Value);end;
Procedure TJournalEntryLines.SetTaxAmount      (const Value: Double    ); begin SetFloatField('TaxAmount'       , Value);end;
Procedure TJournalEntryLines.SetMemo           (const Value: String    ); begin SetStringField('Memo'           , Value);end;
Procedure TJournalEntryLines.SetManCOGSAdjustmentMemo(const Value: String    ); begin SetStringField('ManCOGSAdjustmentMemo', Value);end;
Procedure TJournalEntryLines.SetClientName     (const Value: String    ); begin SetStringField('ClientName'     , Value);end;
Procedure TJournalEntryLines.SetClientID       (const Value: Integer   ); begin SetIntegerField('ClientID'      , Value);end;
Procedure TJournalEntryLines.SetDeptName       (const Value: String    ); begin SetStringField('ClassName'      , Value);end;
Procedure TJournalEntryLines.setClassID        (const Value: Integer   ); begin SetIntegerField('ClassID'       , Value);end;
Procedure TJournalEntryLines.setEmployeeId     (const Value: Integer   ); begin SetIntegerField('EmployeeId'       , Value);end;
Procedure TJournalEntryLines.setLinesOrder     (const Value: Integer   ); begin SetIntegerField('LinesOrder'       , Value); end;
Procedure TJournalEntryLines.SetReconciled     (const Value: Boolean   ); begin SetBooleanField('Reconciled'    , Value);end;
Procedure TJournalEntryLines.SetDeleted        (const Value: Boolean   ); begin SetBooleanField('Deleted'       , Value);end;
Procedure TJournalEntryLines.SetEmployeeName   (const Value: String    ); begin SetStringField('EmployeeName'   , Value);end;
Procedure TJournalEntryLines.SetAreaCode       (const Value: String    ); begin SetStringField('AreaCode'       , Value);end;
function TJournalEntryLines.getLineInserting: Boolean;
begin
  result := False;
  if Assigned(Owner) then
    if owner is TJournalEntry then
      result := TJournalEntry(Owner).LineInserting ;

end;
procedure TJournalEntryLines.setLineInserting(const Value: Boolean);
begin
  if Assigned(Owner) then
    if owner is TJournalEntry then
      TJournalEntry(Owner).LineInserting := Value;
end;


procedure TJournalEntryLines.RefreshJournalTotals;
begin
  TJournalEntry(Owner).RefreshTotals;
end;

class function TJournalEntryLines.GetKeyStringField: string;
begin
  result:= 'AccountName';
end;

function TJournalEntryLines.getLineAmountsValid: Boolean;
begin
  REsult := False;
  if (DebitAmount  <> 0) or (DebitAmountInc <>0) then
    if not Math.SameValue(round(DebitAmount , CurrencyRoundPlaces) + round(TaxAmount,CurrencyRoundPlaces) , round(DebitAmountInc,CurrencyRoundPlaces),0.001)  then exit;
  if (CreditAmount  <> 0) or (CreditAmountInc <>0) then
    if not Math.SameValue(Round(CreditAmount,CurrencyRoundPlaces) + round(TaxAmount,CurrencyRoundPlaces) , round(CreditAmountInc,CurrencyRoundPlaces),0.001)  then exit;
  if (CreditAmount =0) and (CreditAmount=0) and (TaxAmount<>0) then exit;
  REsult := True;
end;


class function TJournalEntryLines.AccountNumberToggle(const ID: Integer;
  Connection: TCustomMyConnection): string;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Connection) then
      qry.Connection:= Connection
    else
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text:= 'select AccountNumber from tblgeneraljournaldetails where GJDID = ' + IntToStr(ID);
    qry.Open;
    result:= qry.FieldByName('AccountNumber').AsString;
  finally
    qry.Free;
  end;
end;

class function TJournalEntryLines.AccountNumberToggle(
  const aAccountNumber: string; Connection: TCustomMyConnection): integer;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Connection) then
      qry.Connection:= Connection
    else
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text:= 'select GJDID from tblgeneraljournaldetails where AccountNumber = ' + QuotedStr(aAccountNumber);
    qry.Open;
    result:= qry.FieldByName('GJDID').AsInteger;
  finally
    qry.Free;
  end;
end;

initialization
  RegisterClassOnce(TJournalEntryLines);
  RegisterClassOnce(TJournalEntry);
end.


