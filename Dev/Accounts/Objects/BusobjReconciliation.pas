unit BusobjReconciliation;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/12/20  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf , BusobjReconciliationGUILines, ReconciliationFlagsObj;


type
  //TRecLineType = (rltDeposit =1 , rltWithdrawal=2);
  TBankStatementLine = class(TMSBusObj)
  private
    function GetSource                  : string    ;
    function GetYodleeContainer         : string    ;
    function GetYodleeID                : Integer   ;
    function GetBankStatementImportID   : Integer   ;
    function GetYodleeAccountID         : Integer   ;
    function GetReconciliationId        : Integer   ;
    function GetAmount                  : Double    ;
    function GetCurrency                : string    ;
    function GetTransactionDate         : TDateTime ;
    function GetStatmentType            : string    ;
    function GetSubType                 : string    ;
    function GetCategory                : string    ;
    function GetCategoryType            : string    ;
    function GetCategoryID              : Integer   ;
    function GetBaseType                : string    ;
    function GetDescriptionSimple       : string    ;
    function GetDescriptionOriginal     : string    ;
    function GetDescriptionConsumer     : string    ;
    function GetCheckNumber             : string    ;
    function GetAccountID               : Integer   ;
    function GetAccountName             : string    ;
    function GetReconciliationLineID    : Integer   ;
    function GetJSON                    : string    ;
    function GetActive                  : Boolean   ;
    procedure SetSource                  (const Value: string    );
    procedure SetYodleeContainer         (const Value: string    );
    procedure SetYodleeID                (const Value: Integer   );
    procedure SetBankStatementImportID   (const Value: Integer   );
    procedure SetYodleeAccountID         (const Value: Integer   );
    procedure SetReconciliationId        (const Value: Integer   );
    procedure SetAmount                  (const Value: Double    );
    procedure SetCurrency                (const Value: string    );
    procedure SetTransactionDate         (const Value: TDateTime );
    procedure SetStatmentType            (const Value: string    );
    procedure SetSubType                 (const Value: string    );
    procedure SetCategory                (const Value: string    );
    procedure SetCategoryType            (const Value: string    );
    procedure SetCategoryID              (const Value: Integer   );
    procedure SetBaseType                (const Value: string    );
    procedure SetDescriptionSimple       (const Value: string    );
    procedure SetDescriptionOriginal     (const Value: string    );
    procedure SetDescriptionConsumer     (const Value: string    );
    procedure SetCheckNumber             (const Value: string    );
    procedure SetAccountID               (const Value: Integer   );
    procedure SetAccountName             (const Value: string    );
    procedure SetReconciliationLineID    (const Value: Integer   );
    procedure SetJSON                    (const Value: string    );
    procedure SetActive                  (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function  DoAfterOpen(Sender:TDatasetBusObj) : Boolean;             override;
    function GetIsList: Boolean; override;
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
    property Source                   :string      read GetSource                 write SetSource              ;
    property YodleeContainer          :string      read GetYodleeContainer        write SetYodleeContainer     ;
    property YodleeID                 :Integer     read GetYodleeID               write SetYodleeID            ;
    property BankStatementImportID    :Integer     read GetBankStatementImportID  write SetBankStatementImportID;
    property YodleeAccountID          :Integer     read GetYodleeAccountID        write SetYodleeAccountID     ;
    property Amount                   :Double      read GetAmount                 write SetAmount              ;
    property Currency                 :string      read GetCurrency               write SetCurrency            ;
    property TransactionDate          :TDateTime   read GetTransactionDate        write SetTransactionDate     ;
    property StatmentType             :string      read GetStatmentType           write SetStatmentType                ;
    property SubType                  :string      read GetSubType                write SetSubType             ;
    property Category                 :string      read GetCategory               write SetCategory            ;
    property CategoryType             :string      read GetCategoryType           write SetCategoryType        ;
    property CategoryID               :Integer     read GetCategoryID             write SetCategoryID          ;
    property BaseType                 :string      read GetBaseType               write SetBaseType            ;
    property DescriptionSimple        :string      read GetDescriptionSimple      write SetDescriptionSimple   ;
    property DescriptionOriginal      :string      read GetDescriptionOriginal    write SetDescriptionOriginal ;
    property DescriptionConsumer      :string      read GetDescriptionConsumer    write SetDescriptionConsumer ;
    property CheckNumber              :string      read GetCheckNumber            write SetCheckNumber         ;
    property AccountID                :Integer     read GetAccountID              write SetAccountID           ;
    property AccountName              :string      read GetAccountName            write SetAccountName         ;
    property ReconciliationId         :Integer     read GetReconciliationId       write SetReconciliationId    ;
    property ReconciliationLineID     :Integer     read GetReconciliationLineID   write SetReconciliationLineID;
    property JSON                     :string      read GetJSON                   write SetJSON                ;
    property Active                   :Boolean     read GetActive                 write SetActive              ;

  end;

  TBankStatementImports = class(TMSBusObj)
  private
    function GetImportDate          : TDateTime ;
    function GetEmployeeId          : Integer   ;
    procedure SetImportDate          (const Value: TDateTime );
    procedure SetEmployeeId          (const Value: Integer   );
    function getBankStatementLine: TBankStatementLine;
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
    property ImportDate           :TDateTime   read GetImportDate         write SetImportDate      ;
    property EmployeeId           :Integer     read GetEmployeeId         write SetEmployeeId      ;
    Property BankStatementLine        :TBankStatementLine read  getBankStatementLine;
  end;

  TReconciliationLineBase = class(TMSBusObj)
  private
    FLinkedBSLIds                       : String    ;
    function GeTReconciliationID        : Integer   ;
    function GetPaymentID               : Integer   ;
    function GetReference               : String    ;
    function GetPayee                   : String    ;
    function GetDepositDate             : TDateTime ;
    function GetAccountID               : Integer   ;
    function GetAccountName             : String    ;
    function GetAmount                  : Double    ;
    function GetNotes                   : String    ;
    function GetDeposited               : Boolean   ;
    //function GetDeleted                 : Boolean   ;
    function GetReconciled              : Boolean   ;
    function GetDepositLineID           : Integer   ;
    function GetClientID                : Integer   ;
    function GetStatementDate           : TDateTime ;
    function GetStatementAmount         : Double    ;
    function GetStatementDesc           : String    ;
    function GetStatementId             : Integer   ;
    procedure SeTReconciliationID        (const Value: Integer   );
    procedure SetPaymentID               (const Value: Integer   );
    procedure SetReference               (const Value: String    );
    procedure SetPayee                   (const Value: String    );
    procedure SetDepositDate             (const Value: TDateTime );
    procedure SetAccountID               (const Value: Integer   );
    procedure SetAccountName             (const Value: String    );
    procedure SetAmount                  (const Value: Double    );
    procedure SetNotes                   (const Value: String    );
    procedure SetDeposited               (const Value: Boolean   );
    //procedure SetDeleted                 (const Value: Boolean   );
    procedure SetReconciled              (const Value: Boolean   );
    procedure SetDepositLineID           (const Value: Integer   );
    procedure SetClientID                (const Value: Integer   );
    function getBankStatementLineID: Integer;
    procedure setBankStatementLineID(const Value: Integer);
    function GetClientName: String;
    procedure SetClientName(const Value: String);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : String;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function  DoAfterOpen(Sender:TDatasetBusObj) : Boolean;           override;
    function  DoBeforeClose(Sender:TDatasetBusObj) : Boolean;           override;
    function GetBankStatementLine: TBankStatementLine;Virtual;abstract;
    function GetDepositPaymentID: integer;
    function GetIsList: Boolean; override;
    Procedure DeleteReconsLine;
  public
    class function  GetIDField                   : String;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    function LockTrans: Boolean;
    Property BankStatementLine        :TBankStatementLine read GetBankStatementLine;
    procedure UpdateBSL;

  published
    property ReconciliationID         :Integer     Read GeTReconciliationID       Write SeTReconciliationID    ;
    property PaymentID                :Integer     Read GetPaymentID              Write SetPaymentID           ;
    property Reference                :String      Read GetReference              Write SetReference           ;
    property Payee                    :String      Read GetPayee                  Write SetPayee               ;
    property DepositDate              :TDateTime   Read GetDepositDate            Write SetDepositDate         ;
    property AccountID                :Integer     Read GetAccountID              Write SetAccountID           ;
    property AccountName              :String      Read GetAccountName            Write SetAccountName         ;
    property Amount                   :Double      Read GetAmount                 Write SetAmount              ;
    property Notes                    :String      Read GetNotes                  Write SetNotes               ;
    property Deposited                :Boolean     Read GetDeposited              Write SetDeposited           ;
    //property Deleted                  :Boolean     Read GetDeleted                Write SetDeleted             ;
    property Reconciled               :Boolean     Read GetReconciled             Write SetReconciled          ;
    property DepositLineID            :Integer     Read GetDepositLineID          Write SetDepositLineID       ;
    property ClientID                 :Integer     Read GetClientID               Write SetClientID            ;
    property ClientName               :String      Read GetClientName             Write SetClientName          ;
    property BankStatementLineID      :Integer     read getBankStatementLineID    write setBankStatementLineID;
    property StatementDate            :TDateTime   read GetStatementDate          ;
    property StatementDesc            :String      read GetStatementDesc          ;
    property StatementAmount          :Double      read GetStatementAmount        ;
    property StatementId              :Integer     read GetStatementId            ;
    property LinkedBSLids             :String      read FLinkedBSLIds             write FLinkedBSLIds;
  end;

  TReconciliationWithdrawalLines = class(TReconciliationLineBase)
  Private
  Protected
    function GetBankStatementLine: TBankStatementLine; override;
    function DoBeforeDelete(Sender:TDatasetBusObj): Boolean; override;

  Public
    constructor Create(AOwner: TComponent); override;
    class function GetBusObjectTablename: String; override;
  end;

  TReconciliationDepositLines = class(TReconciliationLineBase)
  Private
  Protected
    function GetBankStatementLine: TBankStatementLine;Override;
    function  DoBeforeDelete(Sender:TDatasetBusObj) : Boolean; override;
  Public
    constructor  Create(AOwner: TComponent);override;
    class function  GetBusObjectTablename        : string;              override;
  end;

  TReconciliation = class(TMSBusObj)
  private
    fbFilterLinesforDate: Boolean;
    fbListofToBeReconciled: Boolean;
    fbUseStatements: Boolean;
    fdFilterLinesDate: TDateTime;
    fGuiWithdrawLines: TGUIWithDrawReconciliationLines;
    fGuiDepositLines: TGUIDepositReconciliationLines;
    AllLinesValid :Boolean;
    fdDepositAmount: Double;
    fdWithdrawalAmount: Double;
    fdBalance: Double;
    function GeTReconciliationDate    : TDateTime ;
    function GetEmployeeID            : Integer   ;
    function GetClassID               : Integer   ;
    function GetAccountID             : Integer   ;
    function GetStatementNo           : String    ;
    function GetAccountName           : String    ;
    function GetDeptName              : String    ;
    function GetEmployeeName          : String    ;
    function GetNotes                 : String    ;
    function GetOpenBalance           : Double    ;
    function GetCloseBalance          : Double    ;
    function GetDeleted               : Boolean   ;
    function GetFinished              : Boolean   ;
    function GetOnHold                : Boolean   ;
    procedure SeTReconciliationDate    (const Value: TDateTime );
    procedure SetEmployeeID            (const Value: Integer   );
    procedure SetClassID               (const Value: Integer   );
    procedure SetAccountID             (const Value: Integer   );
    procedure SetStatementNo           (const Value: String    );
    procedure SetAccountName           (const Value: String    );
    procedure SetDeptName              (const Value: String    );
    procedure SetEmployeeName          (const Value: String    );
    procedure SetNotes                 (const Value: String    );
    procedure SetOpenBalance           (const Value: Double    );
    procedure SetCloseBalance          (const Value: Double    );
    procedure SetDeleted               (const Value: Boolean   );
    procedure SetFinished              (const Value: Boolean   );
    procedure SetOnHold                (const Value: Boolean   );
    function GetDepositLines:     TReconciliationDepositLines;
    function GetWithdrawalLines:  TReconciliationWithdrawalLines;

    function getGuiDepositLines: TGUIDepositReconciliationLines;
    function getGuiWithdrawLines: TGUIWithDrawReconciliationLines;
    procedure SaveDepositCallback(Const Sender: TBusObj; var Abort: boolean);
    procedure SaveWithdrawalCallback(Const Sender: TBusObj; var Abort: boolean);
    procedure SaveCallback(const Sender: TBusObj; var Abort: boolean;aRecType: TRecType);
    function getCleanDeleted: Boolean;
    procedure CalcTotalsCallback(const Sender: TBusObj; var Abort: boolean);
    procedure CheckForLineParams(Var fGUIReconciliationLines : TGUIReconciliationLines);
    (*function DeleteFlaggedLines: Boolean;
    procedure DeleteFlaggedLinesCallback(const Sender: TBusObj;
      var Abort: boolean);*)
    (*procedure TestDeletecallback(const Sender: TBusObj; var Abort: boolean);*)
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : String;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;

  public
    class function  GetIDField                   : String;              override;
    class function  GetBusObjectTablename        : String;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Procedure CalcOpeningBalance;
    {GUI Lines related Properties}
    property GuiDepositLines          : TGUIDepositReconciliationLines  Read getGuiDepositLines           ;
    property GuiWithdrawLines         : TGUIWithDrawReconciliationLines Read getGuiWithdrawLines          ;
    Property ListofToBeReconciled     : Boolean                         Read fbListofToBeReconciled         Write fbListofToBeReconciled;
    Property FilterLinesforDate       : Boolean                         Read fbFilterLinesforDate           Write fbFilterLinesforDate;
    Property UseStatements            : Boolean                         Read fbUseStatements                Write fbUseStatements;
    Property FilterLinesDate          : TDateTime                       Read fdFilterLinesDate              Write fdFilterLinesDate   ;
    procedure DeleteRecons(aDepositLineID:Integer; aWithdrawalLineID:Integer);
    function ProcessDelete: boolean;
    Property CleanDeleted :Boolean read getCleanDeleted;
    procedure CalcTotals;
    Property DepositAmount    : Double read fdDepositAmount;
    Property WithdrawalAmount : Double read fdWithdrawalAmount;
    Property Balance          : Double read fdBalance;
    procedure RefreshGuiWithdrawLines;
    procedure RefreshGuiDepositLines;
    (*procedure TestDelete;*)


    //function LoadDepositQry(ListofToBeReconciled: Boolean): String;
    //function LoadWithdrawalQry(ListofToBeReconciled: Boolean): String;

  published
    property ReconciliationDate     : TDateTime   Read GeTReconciliationDate   Write SeTReconciliationDate ;
    property EmployeeID             : Integer     Read GetEmployeeID           Write SetEmployeeID         ;
    property ClassID                : Integer     Read GetClassID              Write SetClassID            ;
    property AccountID              : Integer     Read GetAccountID            Write SetAccountID          ;
    property AccountName            : String      Read GetAccountName          Write SetAccountName        ;
    property DeptName               : String      Read GetDeptName             Write SetDeptName           ;
    property EmployeeName           : String      Read GetEmployeeName         Write SetEmployeeName       ;
    property StatementNo            : String      Read GetStatementNo          Write SetStatementNo        ;
    property Notes                  : String      Read GetNotes                Write SetNotes              ;
    property OpenBalance            : Double      Read GetOpenBalance          Write SetOpenBalance        ;
    property CloseBalance           : Double      Read GetCloseBalance         Write SetCloseBalance       ;
    property Deleted                : Boolean     Read GetDeleted              Write SetDeleted            ;
    property Finished               : Boolean     Read GetFinished             Write SetFinished           ;
    property OnHold                 : Boolean     Read GetOnHold               Write SetOnHold             ;
    Property WithdrawalLines        : TReconciliationWithdrawalLines           Read  Getwithdrawallines    ;
    Property DepositLines           : TReconciliationDepositLines              Read  Getdepositlines       ;
  end;



implementation


uses ERPdbComponents, tcDataUtils, CommonLib, sysutils,
  TempTableUtils, CommonDbLib, MySQLConst, tcConst, BusObjGLAccount,
  BusObjClass, BusObjEmployee, AppEnvironment, BusObjConst, DbSharedObjectsObj,
  LogLib , SystemLib, BusObjClient;


{TBankStatementImports}

constructor TBankStatementImports.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'BankStatementImports';
  fSQL := 'SELECT * FROM tblbankstatementimports';
end;


destructor TBankStatementImports.Destroy;
begin
  inherited;
end;


procedure TBankStatementImports.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node,'ImportDate');
  SetPropertyFromNode(node,'EmployeeId');
end;


procedure TBankStatementImports.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ImportDate' ,ImportDate);
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
end;


function TBankStatementImports.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TBankStatementImports.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TBankStatementImports.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TBankStatementImports.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TBankStatementImports.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TBankStatementImports.GetIDField: string;
begin
  Result := 'ID'
end;


class function TBankStatementImports.GetBusObjectTablename: string;
begin
  Result:= 'tblbankstatementimports';
end;


function TBankStatementImports.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(SendeR);
  if not result then exit;
  EmployeeId := Appenv.Employee.EmployeeID;
  ImportDate := now;
end;

function TBankStatementImports.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TBankStatementImports.GetImportDate      : TDateTime ; begin Result := GetDateTimeField('ImportDate');end;
function  TBankStatementImports.GetEmployeeId      : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
procedure TBankStatementImports.SetImportDate      (const Value: TDateTime ); begin SetDateTimeField('ImportDate'       , Value);end;
procedure TBankStatementImports.SetEmployeeId      (const Value: Integer   ); begin SetIntegerField('EmployeeId'        , Value);end;
function TBankStatementImports.getBankStatementLine: TBankStatementLine;
begin
  result := TBankStatementLine(GetContainerComponent(TBankStatementLine ,'BankStatementImportID = ' + IntToStr(ID) ));
end;

  {TReconciliationLineBase}

constructor TReconciliationLineBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLinkedBSLIds := '-1';
end;


procedure TReconciliationLineBase.DeleteReconsLine;
begin
  if Assigned(Owner) then
    if Owner is TReconciliation then
      if self is TReconciliationWithdrawalLines then
          TReconciliation(Owner).DeleteRecons(0,ID)
      else if self is TReconciliationDepositLines then
        TReconciliation(Owner).DeleteRecons(ID, 0);
end;

destructor TReconciliationLineBase.Destroy;
begin
  inherited;
end;


procedure TReconciliationLineBase.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ReconciliationID');
  SetPropertyFromNode(node,'PaymentID');
  SetPropertyFromNode(node,'Reference');
  SetPropertyFromNode(node,'Payee');
  SetDateTimePropertyFromNode(node,'DepositDate');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'Amount');
  SetPropertyFromNode(node,'Notes');
  SetBooleanPropertyFromNode(node,'Deposited');
  //SetBooleanPropertyFromNode(node,'Deleted');
  SetBooleanPropertyFromNode(node,'Reconciled');
  SetPropertyFromNode(node,'DepositLineID');
  SetPropertyFromNode(node,'ClientID');
end;


procedure TReconciliationLineBase.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ReconciliationID' ,ReconciliationID);
  AddXMLNode(node,'PaymentID' ,PaymentID);
  AddXMLNode(node,'Reference' ,Reference);
  AddXMLNode(node,'Payee' ,Payee);
  AddXMLNode(node,'DepositDate' ,DepositDate);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Notes' ,Notes);
  AddXMLNode(node,'Deposited' ,Deposited);
  //AddXMLNode(node,'Deleted' ,Deleted);
  AddXMLNode(node,'Reconciled' ,Reconciled);
  AddXMLNode(node,'DepositLineID' ,DepositLineID);
  AddXMLNode(node,'ClientID' ,ClientID);
end;


function TReconciliationLineBase.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TReconciliationLineBase.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TReconciliationLineBase.UpdateBSL;
var
  qry: TERPQuery;
begin
  if LinkedBSLIds = '-1' then exit;
  qry := Self.SharedQuery;
  try
    //if Assigned(fAssignedConnection) then qry.Connection:= fAssignedConnection
    //else
    //qry.Connection := Self.GetSharedMyDAcDataconnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('UPDATE tblbankstatementline  SET ReconciliationLineId = ' +  IntToStr(self.id) +
              ' WHERE id IN ( ' + LinkedBSLIds + ')');
      Logtext(sql.Text);
      ExecSQL;
    end;
  finally
    //qry.Free;
  end;
end;


procedure TReconciliationLineBase.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TReconciliationLineBase.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
      inherited;
      if Sysutils.SameText(Sender.FieldName, 'Accountname') then begin
        AccountId := TAccount.idToggle(Accountname);
      end else if Sysutils.SameText(Sender.FieldName, 'AccountId ') then begin
        Accountname := TAccount.idToggle(AccountId);
      end;
end;


function TReconciliationLineBase.GetSQL: String;
begin
  Result := inherited GetSQL;
end;

class function TReconciliationLineBase.GetIDField: String;
begin
  Result := 'ReconciliationLineID'
end;

function TReconciliationLineBase.GetIsList: Boolean;
begin
  Result := True;
end;

function TReconciliationLineBase.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Owner) then
    if Owner is TReconciliation then begin
      ReconciliationID := TReconciliation(Owner).ID;
      AccountId := TReconciliation(Owner).AccountID;
    end;
  Reconciled:= true;
end;

function TReconciliationLineBase.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterOpen(Sender);
  if not result then exit;
  Logtext('After Open - ' + Classname +':' +SQL);
  Logtext(inttostr(count));
end;
(*Procedure TReconciliation.TestDelete;
begin
  Withdrawallines.Iteraterecords(TestDeletecallback);
  DepositLines.Iteraterecords(TestDeletecallback);
end;
Procedure TReconciliation.TestDeletecallback(const Sender: TBusObj; var Abort: boolean);
begin
  with TReconciliationLineBase(Sender) do begin
        Logtext('Before -> ' +Classname +'(' +dataset.name +') :' +inttostr(id)+','+booleantostr(deleted)+','+inttostr(count));
        try
          Deleted := not(deleted);
          PostDB;
        Except
          on E:Exception do begin
            Logtext(E.message);
          end;
        end;
        Logtext('After -> ' +Classname +'(' +dataset.name+') :' +inttostr(id)+','+booleantostr(deleted)+','+inttostr(count));
  end;
end;*)
function TReconciliationLineBase.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function TReconciliationLineBase.DoBeforeClose(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeClose(Sender);
  if not result then exit;
  Logtext('Before Close - ' +Classname +':' +SQL);
  Logtext(inttostr(count));

end;

{Property Functions}
function  TReconciliationLineBase.GeTReconciliationID    : Integer   ; begin Result := GetIntegerField('ReconciliationID');end;
function  TReconciliationLineBase.GetPaymentID           : Integer   ; begin Result := GetIntegerField('PaymentID');end;
function  TReconciliationLineBase.GetReference           : String    ; begin Result := GetStringField('Reference');end;
function  TReconciliationLineBase.GetPayee               : String    ; begin Result := GetStringField('Payee');end;
function  TReconciliationLineBase.GetDepositDate         : TDateTime ; begin Result := GetDateTimeField('DepositDate');end;
function  TReconciliationLineBase.GetAccountID           : Integer   ; begin Result := GetIntegerField('AccountID');end;
function  TReconciliationLineBase.GetAccountName         : String    ; begin Result := TAccount.idtoggle(AccountID);end;
function  TReconciliationLineBase.GetAmount              : Double    ; begin Result := GetFloatField('Amount');end;

function  TReconciliationLineBase.GetNotes               : String    ; begin Result := GetStringField('Notes');end;
function  TReconciliationLineBase.GetDeposited           : Boolean   ; begin Result := GetBooleanField('Deposited');end;
//function  TReconciliationLineBase.GetDeleted             : Boolean   ; begin Result := GetBooleanField('Deleted');end;
function  TReconciliationLineBase.GetReconciled          : Boolean   ; begin Result := GetBooleanField('Reconciled');end;
function  TReconciliationLineBase.GetDepositLineID       : Integer   ; begin Result := GetIntegerField('DepositLineID');end;
function  TReconciliationLineBase.GetClientID            : Integer   ; begin Result := GetIntegerField('ClientID');end;
function  TReconciliationLineBase.GetClientName          : String    ; begin Result :=''; if clientID<>0 then result := Tclient.idtoggle(clientID);end;
function  TReconciliationLineBase.GetStatementDate       : TDateTime ; begin Result := GetDateTimeField('TransactionDate');end;
function  TReconciliationLineBase.GetStatementDesc       : String    ; begin Result := GetStringField('DescriptionSimple');end;
function  TReconciliationLineBase.GetStatementAmount     : Double    ; begin Result := GetFloatField('StatementAmount');end;
function  TReconciliationLineBase.GetStatementId         : Integer   ; begin Result := GetIntegerField('StatementId');end;
procedure TReconciliationLineBase.SeTReconciliationID    (const Value: Integer  ); begin SetIntegerField('ReconciliationID'     , Value);end;
procedure TReconciliationLineBase.SetPaymentID           (const Value: Integer  ); begin SetIntegerField('PaymentID'            , Value);end;
procedure TReconciliationLineBase.SetReference           (const Value: String   ); begin SetStringField('Reference'            , Value);end;
procedure TReconciliationLineBase.SetPayee               (const Value: String   ); begin SetStringField('Payee'                , Value);end;
procedure TReconciliationLineBase.SetDepositDate         (const Value: TDateTime); begin SetDateTimeField('DepositDate'          , Value);end;
procedure TReconciliationLineBase.SetAccountID           (const Value: Integer  ); begin SetIntegerField('AccountID'            , Value);end;
procedure TReconciliationLineBase.SetAccountName         (const Value: String   ); begin SetIntegerField('AccountId', TAccount.idtoggle(Value)); end;
procedure TReconciliationLineBase.SetAmount              (const Value: Double   ); begin SetFloatField('Amount'               , Value);end;
procedure TReconciliationLineBase.SetNotes               (const Value: String   ); begin SetStringField('Notes'                , Value);end;
procedure TReconciliationLineBase.SetDeposited           (const Value: Boolean  ); begin SetBooleanField('Deposited'            , Value);end;
//procedure TReconciliationLineBase.SetDeleted           (const Value: Boolean  ); begin SetBooleanField('Deleted'            , Value);end;
procedure TReconciliationLineBase.SetReconciled          (const Value: Boolean  ); begin SetBooleanField('Reconciled'           , Value);end;
procedure TReconciliationLineBase.SetDepositLineID       (const Value: Integer  ); begin SetIntegerField('DepositLineID'        , Value);end;
procedure TReconciliationLineBase.SetClientID            (const Value: Integer  ); begin SetIntegerField('ClientID'             , Value);end;
procedure TReconciliationLineBase.SetClientName          (const Value: String   ); begin if trim(value) = '' then exit; ClientId := Tclient.idtoggle(Value);end;

function TReconciliationLineBase.getBankStatementLineID: Integer;
begin
  REsult := BankStatementLine.Id;
end;
procedure TReconciliationLineBase.setBankStatementLineID(const Value: Integer);
begin
  with BankStatementLine do begin
    if (count>0) and (Value <> ID) then begin
      REconciliationLineID := 0;
      Postdb;
    end;
    LoadSelect('ID =' + inttostr(value));
    if count <> 0 then begin
      ReconciliationLineID := Self.ID;
      PostDB;
    end;
  end;
  BankStatementLine.closedb;
  BankStatementLine.opendb;
end;

function TReconciliationLineBase.GetDepositPaymentID: integer;
var
  qryTemp: TERPQuery;
begin
  qryTemp := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    if Empty(Notes) then begin
      qryTemp.Sql.Add('SELECT PaymentID  FROM tblbankdepositlines Where DepositID = ' + QuotedStr(IntToStr(PaymentId)) + ';');
    end else begin
      qryTemp.Sql.Add('SELECT PaymentID  FROM tblbankdepositlines WHERE DepositID = ' + QuotedStr(IntToStr(PaymentId)));
      qryTemp.Sql.Add(' AND TrnsType=' + QuotedStr(Trim(Notes)) + ';');
    end;

    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('PaymentID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryTemp);
  end;
end;

function TReconciliationLineBase.LockTrans:Boolean;
var
  iPayID:Integer;
  sTransType:String;
  function LockTran(TransID:Integer;Tablename:String;TransDesc:String):Boolean;
  var
    s:String;
  begin
    REsult := True;
   if not Userlock.Lock(Tablename ,TransID) then begin
      Result := False;
      s:= Userlock.LockMessage;
      s:= replaceStr(s , 'Unable to update data.' , 'Unable to Lock '+TransDesc+' # '+inttostr(TransID) +'.');
      REsultStatus.AddItem(False , rssError , 0,  s,true);
    end;
  end;

 begin
      result:= true;
      if PaymentId = 0 then Exit;
      sTransType := Notes;
      if (sTransType = DEPOSIT_ENTRY) or (sTransType = BANK_DEPOSIT) or (sTransType = DEPOSIT_SPLIT) then begin
        iPayID := PaymentId;
      end else begin
        iPayID := GetDepositPaymentID;
      end;
      if iPayID <> 0 then begin
        if Sysutils.SameText(sTransType, CUSTOMER_PAYMENT) then begin
          if not LockTran(iPayID , 'tbldeposits' , 'Customer Payment') then begin
            Result := False;
            Exit;
          end;
        end else if Sysutils.SameText(sTransType, SUPPLIER_PAYMENT) then begin
          if not LockTran(iPayID, 'tblwithdrawal' ,'Supplier Payment') then begin
            Result := False;
            Exit;
          end;
        end else if Sysutils.SameText(sTransType, CUSTOMER_PREPAYMENT) then begin
          if not LockTran(iPayID, 'tblPrePayments' , 'Customer Pre-Payment') then begin
            Result := False;
            Exit;
          end;
        end else if Sysutils.SameText(sTransType, SUPPLIER_PREPAYMENT) then begin
          if not LockTran(iPayID, 'tblPrePayments' ,'Supplier Pre-Payment') then begin
            Result := False;
            Exit;
          end;
        end else if Sysutils.SameText(sTransType, JOURNAL_ENTRY) then begin
          if not LockTran(iPayID, 'tblgeneraljournal' ,'Jounrnal entry') then begin
            Result := False;
            Exit;
          end;
        end else if Sysutils.SameText(sTransType, CHEQUE) then begin
          if not LockTran(iPayID, 'tblpurchaseOrders' ,'Cheque') then begin
            Result := False;
            Exit;
          end;
        end else if Sysutils.SameText(sTransType, CHEQUE_DEPOSIT) then begin
          if not LockTran(iPayID, 'tblpurchaseOrders' ,'Cheque') then begin
            Result := False;
            Exit;
          end;
        end else if Sysutils.SameText(sTransType, BANK_DEPOSIT) then begin
          if not LockTran(iPayID, 'tblbankdeposit' ,'Bank Deposit') then begin
            Result := False;
            Exit;
          end;
        end else if Sysutils.SameText(sTransType, DEPOSIT_ENTRY) then begin
          if not LockTran(iPayID, 'tblbankdeposit' ,'Bank Deposit') then begin
            Result := False;
            Exit;
          end;
        end else if Sysutils.SameText(sTransType, DEPOSIT_SPLIT) then begin
          if not LockTran(iPayID, 'tblbankdeposit' ,'Bank Deposit') then begin
            Result := False;
            Exit;
          end;
        end;
      end;
      REsult := True;
 end;

{ TReconciliationWithdrawalLines }
constructor TReconciliationWithdrawalLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'reconciliationwithdrawallines';
  fSQL := 'SELECT twl.*, bsl.DescriptionSimple, bsl.TransactionDate, bsl.Amount as StatementAmount, bsl.id as StatementId FROM tblreconciliationwithdrawallines twl LEFT JOIN tblbankstatementline bsl ON ' +
          'twl.reconciliationlineid = bsl.reconciliationlineid and bsl.BaseType = ' + QuotedStr('DEBIT');
end;

function TReconciliationWithdrawalLines.DoBeforeDelete( Sender: TDatasetBusObj): Boolean;
begin
  DeleteReconsLine;//DeleteRecons(0, ID);
end;

function TReconciliationWithdrawalLines.GetBankStatementLine: TBankStatementLine;
begin
  Result := TBankStatementLine(GetContainerComponent(TBankStatementLine ,'ReconciliationlineId = ' + IntToStr(ID) + ' and BaseType = "CREDIT"'));
end;

class function TReconciliationWithdrawalLines.GetBusObjectTablename: String;
begin
  Result := 'tblreconciliationwithdrawallines';
end;

{ TReconciliationDepositLines }
constructor TReconciliationDepositLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'reconciliationdepositlines';
  fSQL := 'SELECT tdl.*, bsl.DescriptionSimple, bsl.TransactionDate, bsl.Amount as StatementAmount, bsl.id as StatementId FROM tblreconciliationdepositlines tdl LEFT JOIN tblbankstatementline bsl ON ' +
          'tdl.reconciliationlineid = bsl.reconciliationlineid AND baseType = ' + QuotedStr('CREDIT');
end;

function TReconciliationDepositLines.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
begin
  DeleteReconsLine;//DeleteRecons(ID, 0);
end;

function TReconciliationDepositLines.GetBankStatementLine: TBankStatementLine;
begin
  result := TBankStatementLine(GetContainerComponent(TBankStatementLine ,'ReconciliationlineId = ' + IntToStr(ID) + ' and BaseType = "DEBIT"'));
end;

class function TReconciliationDepositLines.GetBusObjectTablename: string;
begin
  Result := 'tblreconciliationdepositlines';
end;

{TReconciliation}

procedure TReconciliation.CalcTotals;
begin
  fdDepositAmount := 0;
  fdWithdrawalAmount:= 0;
  fdBalance:= OpenBalance;
  WithdrawalLines.IterateRecords(CalcTotalsCallback);
  DepositLines.IterateRecords(CalcTotalsCallback);
  if Silentmode then Closebalance := Balance;
end;

procedure TReconciliation.CalcTotalsCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
  if Sender is TReconciliationWithdrawalLines then begin
    //if not TReconciliationLineBase(Sender).Deleted then begin
    fdBalance := fdBalance - TReconciliationLineBase(Sender).Amount;
    fdWithdrawalAmount := fdWithdrawalAmount + TReconciliationLineBase(Sender).Amount;
    //end;
  end else if Sender is TReconciliationDepositLines then begin
    //if not TReconciliationLineBase(Sender).Deleted then begin
    fdBalance := fdBalance + TReconciliationLineBase(Sender).Amount;
    fdDepositAmount := fdDepositAmount + TReconciliationLineBase(Sender).Amount;
    //end;
  end;
end;

constructor TReconciliation.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'reconciliation';
  fSQL := 'SELECT * FROM tblreconciliation';
  fbFilterLinesforDate := False;
  fbListofToBeReconciled := False;
  fbUseStatements := False;
  fdFilterLinesDate:= 0;
  fGuiWithdrawLines:= nil;
  fGuiDepositLines:= nil;
  fdDepositAmount := 0;
  fdWithdrawalAmount:= 0;
  fdBalance:= 0;
end;

destructor TReconciliation.Destroy;
begin

  inherited;
end;

procedure TReconciliation.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node,'ReconciliationDate');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'ClassID');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'StatementNo');
  SetPropertyFromNode(node,'Notes');
  SetPropertyFromNode(node,'OpenBalance');
  SetPropertyFromNode(node,'CloseBalance');
  SetBooleanPropertyFromNode(node,'Deleted');
  SetBooleanPropertyFromNode(node,'Finished');
end;

procedure TReconciliation.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ReconciliationDate' ,ReconciliationDate);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'ClassID' ,ClassID);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'StatementNo' ,StatementNo);
  AddXMLNode(node,'Notes' ,Notes);
  AddXMLNode(node,'OpenBalance' ,OpenBalance);
  AddXMLNode(node,'CloseBalance' ,CloseBalance);
  AddXMLNode(node,'Deleted' ,Deleted);
  AddXMLNode(node,'Finished' ,Finished);
  AddXMLNode(node,'OnHold' ,OnHold);
end;

function TReconciliation.ValidateData: Boolean ;
begin
  Result := False;
//  Resultstatus.Clear;
//  if (depositlines.Count = 0) and (WithdrawalLines.Count = 0) then begin
//    REsultStatus.AddItem(False , rssError , 0,'No Transactions have been cleared!',true);
//    Exit;
//  end;
//  if trim(StatementNo)='' then begin
//    REsultStatus.AddItem(False , rssError , 0,'You must enter a Statement Number',true);
//    Exit;
//  end;
  Result := True;
end;
(*Function TReconciliation.DeleteFlaggedLines: Boolean;
begin
  result := False;
  AllLinesValid := True;
  WithdrawalLines.IterateRecordsReverse(DeleteFlaggedLinesCallback);
  if not AllLinesValid then exit;
  DepositLines.IterateRecordsReverse(DeleteFlaggedLinesCallback);
  if not AllLinesValid then exit;
  Result := true;
end;
procedure TReconciliation.DeleteFlaggedLinesCallback(Const Sender: TBusObj; var Abort: boolean);
begin
  if sender is  TReconciliationLineBase then  begin
    //if TReconciliationLineBase(Sender).Deleted then begin
      logtext('Before Delete -> '+TReconciliationLineBase(Sender).ClassName+':'+inttostr(TReconciliationLineBase(Sender).count)+','+ inttostr(TReconciliationLineBase(Sender).ID));
      TReconciliationLineBase(Sender).Delete;
      logtext('After Delete -> '+TReconciliationLineBase(Sender).ClassName+':'+inttostr(TReconciliationLineBase(Sender).count)+','+ inttostr(TReconciliationLineBase(Sender).ID));
    //end;
  end;
end;*)
Procedure TReconciliation.CalcOpeningBalance;
var
  qry: TERPQuery;
begin
  OpenBalance:= 0;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    OpenBalance:= 0;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT CloseBalance,ReconciliationDate ' +
              ' FROM tblReconciliation ' +
              ' WHERE AccountID = '+ inttostr(AccountID)+' AND Finished = "T" ' +
              ' AND Deleted<>"T" ' +
              ' ORDER BY ReconciliationID desc limit 1');
      Open;
      if RecordCount > 0 then  OpenBalance:= FieldByName('CloseBalance').asCurrency;;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function TReconciliation.Save: Boolean ;
begin
  Result := False;
  if ProcessDelete() then begin
    REsult := true;
    Exit;
  end;

  if not ValidateData then Exit;
  CalcTotals;
  AllLinesValid := True;
  WithdrawalLines.iteraterecords(SaveWithdrawalCallback);
  if not AllLinesValid then exit;
  DepositLines.iteraterecords(SaveDepositCallback);
  if not AllLinesValid then exit;
  Result := inherited Save;
end;

procedure TReconciliation.SaveDepositCallback(Const Sender: TBusObj; var Abort: boolean);
begin
  SaveCallback(Sender, Abort, rtDeposits);
  if Abort then Exit;
end;

procedure TReconciliation.SaveWithdrawalCallback(Const Sender: TBusObj; var Abort: boolean);
begin
  SaveCallback(Sender, Abort, rtWithdrawals);
  if abort then exit;
end;

procedure TReconciliation.SaveCallback(Const Sender: TBusObj; var Abort: boolean; aRecType : TRecType);
var
  ReconciliationRecord: TReconciliationInfo;
begin
  if not TReconciliationLineBase(Sender).LockTrans then begin
    Abort := True;
    Exit;
  end;

  TReconciliationFlagsObj.Instance(TERPConnection(Connection.Connection));
  //ReconciliationFlags.AssignedConnection:= TERPConnection(Connection.Connection);
  try
    //Setup Record
    ReconciliationRecord.ReconciliationID     := TReconciliationLineBase(Sender).ReconciliationID;
    ReconciliationRecord.ReconciliationLineID := TReconciliationLineBase(Sender).ID;
    ReconciliationRecord.RecType              := aRecType;
    ReconciliationRecord.AccountID            := TReconciliationLineBase(Sender).AccountID;
    ReconciliationRecord.DepositID            := TReconciliationLineBase(Sender).PaymentID;
    ReconciliationRecord.DepositLineID        := TReconciliationLineBase(Sender).DepositLineID;
    ReconciliationRecord.Notes                := TReconciliationLineBase(Sender).Notes;
    ReconciliationRecord.ClientID             := TReconciliationLineBase(Sender).ClientID;
    ReconciliationRecord.Payee                := TReconciliationLineBase(Sender).Payee;
    ReconciliationRecord.Reference            := TReconciliationLineBase(Sender).Reference;
    ReconciliationRecord.Date                 := TReconciliationLineBase(Sender).DepositDate;
    ReconciliationRecord.Amount               := TReconciliationLineBase(Sender).Amount;
   //Set Flag
    if not ReconciliationFlags.FlagReconciled(ReconciliationRecord) then begin
      AllLinesValid:= False;
      abort := True;
      ResultStatus.AddItem(False, rssError, 0, 'Unable to flag ' +
                              iif(aREctype =rtDeposits , 'deposit', 'withdrawal')+' : ' +
                              TReconciliationLineBase(Sender).Notes +
                              ' for Payee: ' + TReconciliationLineBase(Sender).Payee +
                              ' Date: ' + FormatDateTime(ShortDateformat,TReconciliationLineBase(Sender).DepositDate) +
                              ' Amount: ' + FloattostrF(TReconciliationLineBase(Sender).Amount,ffCurrency,15,2), True);
      Exit;
    end;
  finally
    FreeAndNil(ReconciliationFlags);
  end;
end;

procedure TReconciliation.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  fdDepositAmount := 0;
  fdWithdrawalAmount:= 0;
  fdBalance:= 0;

end;

procedure TReconciliation.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
    inherited;
    if sametext(Sender.fieldname , 'AccountID') then begin
      CalcOpeningBalance;
    end else if sametext(Sender.fieldname , 'ClassID') then begin
      CalcOpeningBalance;
    end else if sametext(Sender.fieldname , 'ReconciliationDate') then begin
      CalcOpeningBalance;
    end else if sametext(Sender.fieldname , 'Onhold') then begin
      beep;
      SendEvent(BusObjEvent_Change, BusObjEventVal_ResStats, self);
    end else if sametext(Sender.fieldname , 'Finished') then begin
      beep;
      SendEvent(BusObjEvent_Change, BusObjEventVal_ResStats, self);
    end else if sametext(Sender.fieldname , 'Delted') then begin
      beep;
      SendEvent(BusObjEvent_Change, BusObjEventVal_ResStats, self);
    end;
end;

function TReconciliation.GetSQL: String;
begin
  Result := inherited GetSQL;
end;

class function TReconciliation.GetIDField: String;
begin
  Result := 'ReconciliationID'
end;

class function TReconciliation.GetBusObjectTablename: String;
begin
  Result:= 'tblreconciliation';
end;

function TReconciliation.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  Onhold := True;
end;

function TReconciliation.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function TReconciliation.getCleanDeleted: Boolean;
begin
  Result := GetXMLNodeBooleanValue(CleanXMLNode, 'Deleted');
end;

{Property Functions}
function  TReconciliation.GeTReconciliationDate: TDateTime ; begin Result := GetDateTimeField('ReconciliationDate');end;
function  TReconciliation.GetEmployeeID        : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TReconciliation.GetClassID           : Integer   ; begin Result := GetIntegerField('ClassID');end;
function  TReconciliation.GetAccountID         : Integer   ; begin Result := GetIntegerField('AccountID');end;
function  TReconciliation.GetStatementNo       : String    ; begin Result := GetStringField('StatementNo');end;
function  TReconciliation.GetAccountName       : String    ; begin Result := ''; if AccountID     <> 0 then result := TAccount.idtoggle(AccountID ); end;
function  TReconciliation.GetDeptName          : String    ; begin Result := ''; if ClassID       <> 0 then result := TDeptClass.idtoggle(ClassId   ); end;
function  TReconciliation.GetEmployeeName      : String    ; begin Result := ''; if EmployeeID    <> 0 then result := TEmployee.idtoggle(EmployeeID ); end;
function  TReconciliation.GetNotes             : String    ; begin Result := GetStringField('Notes');end;
function  TReconciliation.GetOpenBalance       : Double    ; begin Result := GetFloatField('OpenBalance');end;
function  TReconciliation.GetCloseBalance      : Double    ; begin Result := GetFloatField('CloseBalance');end;
function  TReconciliation.GetDeleted           : Boolean   ; begin Result := GetBooleanField('Deleted');end;
function  TReconciliation.GetFinished          : Boolean   ; begin Result := GetBooleanField('Finished');end;
function  TReconciliation.GetOnHold            : Boolean   ; begin Result := not(GetBooleanField('Finished'));end;
procedure TReconciliation.SeTReconciliationDate(const Value: TDateTime ); begin SetDateTimeField('ReconciliationDate' , Value);end;
procedure TReconciliation.SetEmployeeID        (const Value: Integer   ); begin SetIntegerField('EmployeeID'         , Value);end;
procedure TReconciliation.SetClassID           (const Value: Integer   ); begin SetIntegerField('ClassID'            , Value);end;
procedure TReconciliation.SetAccountID         (const Value: Integer   ); begin SetIntegerField('AccountID'          , Value);end;
procedure TReconciliation.SetStatementNo       (const Value: String    ); begin SetStringField('StatementNo'        , Value);end;
procedure TReconciliation.SetAccountName       (const Value: String    ); begin if Value <> '' then SetIntegerField('AccountID' ,TAccount.idtoggle(Value));end;
procedure TReconciliation.SetDeptName          (const Value: String    ); begin if Value <> '' then SetIntegerField('ClassID'   ,TDeptClass.idtoggle(Value));end;
procedure TReconciliation.SetEmployeeName      (const Value: String    ); begin if Value <> '' then SetIntegerField('EmployeeID',TEmployee.idtoggle(Value)) ;end;
procedure TReconciliation.SetNotes             (const Value: String    ); begin SetStringField('Notes'              , Value);end;
procedure TReconciliation.SetOpenBalance       (const Value: Double    ); begin SetFloatField('OpenBalance'        , Value);end;
procedure TReconciliation.SetCloseBalance      (const Value: Double    ); begin SetFloatField('CloseBalance'       , Value);end;
procedure TReconciliation.SetDeleted           (const Value: Boolean   ); begin SetBooleanField('Deleted'            , Value);end;
procedure TReconciliation.SetFinished          (const Value: Boolean   ); begin SetBooleanField('Finished'           , Value);end;
procedure TReconciliation.SetOnHold            (const Value: Boolean   ); begin SetBooleanField('Finished'           , not(Value));end;

function TReconciliation.Getwithdrawallines: TReconciliationWithdrawalLines;
begin
  if Id = 0 then Postdb; // this is to make sure the Id is generated before createing the container items
  Result := TReconciliationWithdrawalLines(GetContainerComponent(TReconciliationWithdrawalLines, 'ReconciliationID = ' + IntToStr(ID)));
end;

function TReconciliation.getdepositlines: TReconciliationDepositLines;
begin
  if Id = 0 then Postdb; // this is to make sure the Id is generated before createing the container items
  Result := TReconciliationDepositLines(GetContainerComponent(TReconciliationDepositLines, 'ReconciliationID = ' + IntToStr(ID)));
end;

Procedure TReconciliation.CheckForLineParams(Var fGUIReconciliationLines : TGUIReconciliationLines);
begin
    if Assigned(fGUIReconciliationLines) then begin
        if (fGUIReconciliationLines.GUILineAccountID <> AccountID) then begin
          Freeandnil(fGUIReconciliationLines);
        end;
        if FilterLinesforDate then
            if (fGUIReconciliationLines.GUILineDate  <> FilterLinesDate) then begin
              Freeandnil(fGUIReconciliationLines);
            end;

    end;
end;

function TReconciliation.getGuiDepositLines: TGUIDepositReconciliationLines;
begin
    (*if Assigned(fGuiDepositLines) then begin
        if (fGuiDepositLines.accountId <> GUILineAccountID) then begin
          Freeandnil(fGuiDepositLines);
        end;
        if FilterLinesforDate then
            if (fGuiDepositLines.GUILineDate : <> FilterLinesDate) then begin
              Freeandnil(fGuiDepositLines);
            end;

    end;*)
    CheckForLineParams(TGUIReconciliationLines(fGuiDepositLines));

    if fGuiDepositLines = nil then begin
      fGuiDepositLines:= TGUIDepositReconciliationLines.Create(Self);
      fGuiDepositLines.Connection := Self.connection;
      fGuiDepositLines.Load;
    end;
    REsult := fGuiDepositLines;
end;

function TReconciliation.getGuiWithdrawLines: TGUIWithDrawReconciliationLines;
begin
    (*if Assigned(fGuiWithdrawLines) then begin
        if (fGuiWithdrawLines.accountId <> GUILineAccountID) then begin
          Freeandnil(fGuiWithdrawLines);
        end;
        if FilterLinesforDate then
            if (fGuiWithdrawLines.GUILineDate : <> FilterLinesDate) then begin
              Freeandnil(fGuiWithdrawLines);
            end;

    end;*)
    CheckForLineParams(TGUIReconciliationLines(fGuiWithdrawLines));

(*    if Assigned(fGuiWithdrawLines) and (fGuiWithdrawLines.accountId <> AccountId) then begin
      Freeandnil(fGuiWithdrawLines);
    end;*)
    if fGuiWithdrawLines = nil then begin
      fGuiWithdrawLines:= TGUIWithDrawReconciliationLines.Create(Self);
      fGuiWithdrawLines.Connection := Self.connection;
      fGuiWithdrawLines.Load;
    end;
    result := fGuiWithdrawLines;
end;

procedure TReconciliation.DeleteRecons(aDepositLineID:Integer; aWithdrawalLineID:Integer);
var
  iReconsID, i: integer;
  ReconciliationRecord: TReconciliationInfo;
begin
  EmployeeId := AppEnv.Employee.EmployeeID;
  ClassId := AppEnv.DefaultClass.ClassID;
  if (aDepositLineID = 0) and (aWithdrawalLineID = 0) then Finished := True;
  iReconsID  := ID;

  // Undo Post Deposits details
  if DepositLines.Count > 0 then begin
    if aDepositLineID <> 0 then DepositLines.Locate('ReconciliationLineID', aDepositLineID, []) else DepositLines.First;
    //TReconciliationFlagsObj.Instance;
    TReconciliationFlagsObj.Instance(TERPConnection(Connection.Connection));
    try
      fiProgresscount := DepositLines.Count;
      SendEvent(BusobjEvent_ToDo, BusobjEvent_ShowProgressbar, Self);//ProgressDialog.DoShowProgressbar(DepositLines.count , 'Deposits');
      try
        //if aDepositLineID <> 0 then DepositLines.Locate('ReconciliationLineID' ,aDepositLineID, []);
        if ((aDepositLineID = 0) and (aWithdrawalLineID = 0)) or (DepositLines.ID = aDepositLineID) then
          while not DepositLines.EOf do begin
            //Setup Record
            if ((aDepositLineID = 0) and (aWithdrawalLineID = 0)) or (DepositLines.ID = aDepositLineID) then begin
              ReconciliationRecord.ReconciliationID     := DepositLines.ReconciliationID;
              ReconciliationRecord.ReconciliationLineID := DepositLines.ID;
              ReconciliationRecord.RecType              := rtDeposits;
              ReconciliationRecord.AccountID            := DepositLines.AccountID;
              ReconciliationRecord.DepositID            := DepositLines.PaymentID;
              ReconciliationRecord.DepositLineID        := DepositLines.DepositLineID;
              ReconciliationRecord.Notes                := DepositLines.Notes;
              ReconciliationRecord.ClientID             := DepositLines.ClientID;
              ReconciliationRecord.Payee                := DepositLines.Payee;
              ReconciliationRecord.Reference            := DepositLines.Reference;
              ReconciliationRecord.Date                 := DepositLines.DepositDate;
              ReconciliationRecord.Amount               := DepositLines.Amount;
              ReconciliationFlags.FlagUnReconciled(ReconciliationRecord);
              if DepositLines.BankStatementLine.Count > 0 then begin
                DepositLines.BankStatementLine.ReconciliationlineId := 0;
                DepositLines.BankStatementLine.PostDB;
              end;
            end;
            if aDepositLineID <> 0 then Break;
            DepositLines.Next;
            SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
          end;
      finally
        SendEvent(BusobjEvent_ToDo, BusobjEvent_HideProgressbar, Self);//ProgressDialog.doHideProgressbar;
      end;
    finally
      FreeAndNil(ReconciliationFlags);
    end;
  end;

  // Undo Post Withdrawals Details
  if WithdrawalLines.count > 0 then begin
    if aWithdrawalLineID <> 0 then WithdrawalLines.Locate('ReconciliationLineID', aWithdrawalLineID, []) else WithdrawalLines.First;
    TReconciliationFlagsObj.Instance(TERPConnection(Connection.Connection));
    try
      fiProgresscount := WithdrawalLines.Count;
      SendEvent(BusobjEvent_ToDo, BusobjEvent_ShowProgressbar, Self);//ProgressDialog.DoShowProgressbar(tblReconWithdrawalLines.recordcount , 'Withdrawals');
      try
        //if aWithdrawalLineID <> 0 then WithdrawalLines.Locate('ReconciliationLineID' ,aWithdrawalLineID, []);
        if ((aDepositLineID = 0) and (aWithdrawalLineID = 0)) or (WithdrawalLines.ID = aWithdrawalLineID) then
            while not WithdrawalLines.Eof do begin
              //Setup Record
              if ((aDepositLineID =0) and (aWithdrawalLineID = 0)) or (WithdrawalLines.ID =aWithdrawalLineID) then begin
                ReconciliationRecord.ReconciliationID     := WithdrawalLines.ReconciliationID;
                ReconciliationRecord.ReconciliationLineID := WithdrawalLines.ID;
                ReconciliationRecord.RecType              := rtWithdrawals;
                ReconciliationRecord.AccountID            := WithdrawalLines.AccountID;
                ReconciliationRecord.DepositID            := WithdrawalLines.PaymentID;
                ReconciliationRecord.DepositLineID        := WithdrawalLines.DepositLineID;
                ReconciliationRecord.Notes                := WithdrawalLines.Notes;
                ReconciliationRecord.ClientID             := WithdrawalLines.ClientID;
                ReconciliationRecord.Payee                := WithdrawalLines.Payee;
                ReconciliationRecord.Reference            := WithdrawalLines.Reference;
                ReconciliationRecord.Date                 := WithdrawalLines.DepositDate;
                ReconciliationRecord.Amount               := WithdrawalLines.Amount;
                //Set Flag
                ReconciliationFlags.FlagUnReconciled(ReconciliationRecord);
                if WithdrawalLines.BankStatementLine.Count > 0 then begin
                  WithdrawalLines.BankStatementLine.ReconciliationlineId := 0;
                  WithdrawalLines.BankStatementLine.PostDB;
                end;
              end;
              if aWithdrawalLineID <> 0 then Break;
              WithdrawalLines.Next;
              SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);//ProgressDialog.DoStepProgressbar;
            end;
      finally
        SendEvent(BusobjEvent_ToDo, BusobjEvent_HideProgressbar, Self);//ProgressDialog.doHideProgressbar;
      end;
    finally
      FreeAndNil(ReconciliationFlags);
    end;
  end;
end;

function TReconciliation.ProcessDelete: boolean;
begin
  Result := False;
  if not Deleted then Exit;

  if Deleted and not CleanDeleted then DeleteRecons(0, 0);
  PostDB;
  Result := True;
end;

procedure TReconciliation.RefreshGuiDepositLines;
begin
  if fGuiDepositLines <> nil then FreeAndNil(fGuiDepositLines);
  GuiDepositLines;
end;

procedure TReconciliation.REfreshGuiWithdrawLines;
begin
    if fGuiWithdrawLines <> nil then freeandnil(fGuiWithdrawLines);
    GuiWithdrawLines;
end;

{TBankStatementLine}

constructor TBankStatementLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'BankStatementLine';
  fSQL := 'SELECT * FROM tblbankstatementline';
end;


destructor TBankStatementLine.Destroy;
begin
  inherited;
end;


procedure TBankStatementLine.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Source');
  SetPropertyFromNode(node,'YodleeContainer');
  SetPropertyFromNode(node,'YodleeID');
  SetPropertyFromNode(node,'BankStatementImportID');
  SetPropertyFromNode(node,'YodleeAccountID');
  SetPropertyFromNode(node,'ReconciliationId');
  SetPropertyFromNode(node,'Amount');
  SetPropertyFromNode(node,'Currency');
  SetDateTimePropertyFromNode(node,'TransactionDate');
  SetPropertyFromNode(node,'StatmentType');
  SetPropertyFromNode(node,'SubType');
  SetPropertyFromNode(node,'Category');
  SetPropertyFromNode(node,'CategoryType');
  SetPropertyFromNode(node,'CategoryID');
  SetPropertyFromNode(node,'BaseType');
  SetPropertyFromNode(node,'DescriptionSimple');
  SetPropertyFromNode(node,'DescriptionOriginal');
  SetPropertyFromNode(node,'DescriptionConsumer');
  SetPropertyFromNode(node,'CheckNumber');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'AccountName');
  SetPropertyFromNode(node,'ReconciliationLineID');
  SetPropertyFromNode(node,'JSON');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TBankStatementLine.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Source' ,Source);
  AddXMLNode(node,'YodleeContainer' ,YodleeContainer);
  AddXMLNode(node,'YodleeID' ,YodleeID);
  AddXMLNode(node,'BankStatementImportID' ,BankStatementImportID);
  AddXMLNode(node,'YodleeAccountID' ,YodleeAccountID);
  AddXMLNode(node,'ReconciliationId' ,ReconciliationId);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Currency' ,Currency);
  AddXMLNode(node,'TransactionDate' ,TransactionDate);
  AddXMLNode(node,'StatmentType' ,StatmentType);
  AddXMLNode(node,'SubType' ,SubType);
  AddXMLNode(node,'Category' ,Category);
  AddXMLNode(node,'CategoryType' ,CategoryType);
  AddXMLNode(node,'CategoryID' ,CategoryID);
  AddXMLNode(node,'BaseType' ,BaseType);
  AddXMLNode(node,'DescriptionSimple' ,DescriptionSimple);
  AddXMLNode(node,'DescriptionOriginal' ,DescriptionOriginal);
  AddXMLNode(node,'DescriptionConsumer' ,DescriptionConsumer);
  AddXMLNode(node,'CheckNumber' ,CheckNumber);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'AccountName' ,AccountName);
  AddXMLNode(node,'ReconciliationLineID' ,ReconciliationLineID);
  AddXMLNode(node,'JSON' ,JSON);
  AddXMLNode(node,'Active' ,Active);
end;


function TBankStatementLine.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TBankStatementLine.Save: Boolean ;
begin
    Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TBankStatementLine.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TBankStatementLine.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
      inherited;
      if Sysutils.SameText(Sender.FieldName, 'Accountname') then begin
        AccountId := TAccount.idToggle(Accountname);
      end;
end;


function TBankStatementLine.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TBankStatementLine.GetIDField: string;
begin
  Result := 'ID'
end;


function TBankStatementLine.GetIsList: Boolean;
begin
  REsult := TRue;
end;

class function TBankStatementLine.GetBusObjectTablename: string;
begin
  Result:= 'tblbankstatementline';
end;


function TBankStatementLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(OWner) then begin
    if Owner is TReconciliationLineBase then begin
      ReconciliationId := TReconciliationLineBase(Owner).ID;
      if Owner is TReconciliationWithdrawalLines then BaseType := 'CREDIT' else BaseType := 'DEBIT' ;
    end else if owner is TBankStatementImports then begin
        BankStatementImportID := TBankStatementImports(Owner).ID;
    end;
  end;
end;

function TBankStatementLine.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterOpen(Sender);
end;

function TBankStatementLine.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TBankStatementLine.GetSource              : string    ; begin Result := GetStringField('Source');end;
function  TBankStatementLine.GetYodleeContainer     : string    ; begin Result := GetStringField('YodleeContainer');end;
function  TBankStatementLine.GetYodleeID            : Integer   ; begin Result := GetIntegerField('YodleeID');end;
function  TBankStatementLine.GetBankStatementImportID: Integer   ; begin Result := GetIntegerField('BankStatementImportID');end;
function  TBankStatementLine.GetYodleeAccountID     : Integer   ; begin Result := GetIntegerField('YodleeAccountID');end;
function  TBankStatementLine.GetReconciliationId    : Integer   ; begin Result := GetIntegerField('ReconciliationId');end;
function  TBankStatementLine.GetAmount              : Double    ; begin Result := GetFloatField('Amount');end;
function  TBankStatementLine.GetCurrency            : string    ; begin Result := GetStringField('Currency');end;
function  TBankStatementLine.GetTransactionDate     : TDateTime ; begin Result := GetDateTimeField('TransactionDate');end;
function  TBankStatementLine.GetStatmentType        : string    ; begin Result := GetStringField('Type');end;
function  TBankStatementLine.GetSubType             : string    ; begin Result := GetStringField('SubType');end;
function  TBankStatementLine.GetCategory            : string    ; begin Result := GetStringField('Category');end;
function  TBankStatementLine.GetCategoryType        : string    ; begin Result := GetStringField('CategoryType');end;
function  TBankStatementLine.GetCategoryID          : Integer   ; begin Result := GetIntegerField('CategoryID');end;
function  TBankStatementLine.GetBaseType            : string    ; begin Result := GetStringField('BaseType');end;
function  TBankStatementLine.GetDescriptionSimple   : string    ; begin Result := GetStringField('DescriptionSimple');end;
function  TBankStatementLine.GetDescriptionOriginal : string    ; begin Result := GetStringField('DescriptionOriginal');end;
function  TBankStatementLine.GetDescriptionConsumer : string    ; begin Result := GetStringField('DescriptionConsumer');end;
function  TBankStatementLine.GetCheckNumber         : string    ; begin Result := GetStringField('CheckNumber');end;
function  TBankStatementLine.GetAccountID           : Integer   ; begin Result := GetIntegerField('AccountID');end;
function  TBankStatementLine.GetAccountName         : string    ; begin Result := GetStringField('AccountName');end;
function  TBankStatementLine.GetReconciliationLineID: Integer   ; begin Result := GetIntegerField('ReconciliationLineID');end;
function  TBankStatementLine.GetJSON                : string    ; begin Result := GetStringField('JSON');end;
function  TBankStatementLine.GetActive              : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TBankStatementLine.SetSource              (const Value: string    ); begin SetStringField('Source'               , Value);end;
procedure TBankStatementLine.SetYodleeContainer     (const Value: string    ); begin SetStringField('YodleeContainer'      , Value);end;
procedure TBankStatementLine.SetYodleeID            (const Value: Integer   ); begin SetIntegerField('YodleeID'             , Value);end;
procedure TBankStatementLine.SetBankStatementImportID(const Value: Integer   ); begin SetIntegerField('BankStatementImportID', Value);end;
procedure TBankStatementLine.SetYodleeAccountID     (const Value: Integer   ); begin SetIntegerField('YodleeAccountID'      , Value);end;
procedure TBankStatementLine.SetReconciliationId    (const Value: Integer   ); begin SetIntegerField('ReconciliationId'      , Value);end;
procedure TBankStatementLine.SetAmount              (const Value: Double    ); begin SetFloatField('Amount'               , Value);end;
procedure TBankStatementLine.SetCurrency            (const Value: string    ); begin SetStringField('Currency'             , Value);end;
procedure TBankStatementLine.SetTransactionDate     (const Value: TDateTime ); begin SetDateTimeField('TransactionDate'      , Value);end;
procedure TBankStatementLine.SetStatmentType        (const Value: string    ); begin SetStringField('Type'                 , Value);end;
procedure TBankStatementLine.SetSubType             (const Value: string    ); begin SetStringField('SubType'              , Value);end;
procedure TBankStatementLine.SetCategory            (const Value: string    ); begin SetStringField('Category'             , Value);end;
procedure TBankStatementLine.SetCategoryType        (const Value: string    ); begin SetStringField('CategoryType'         , Value);end;
procedure TBankStatementLine.SetCategoryID          (const Value: Integer   ); begin SetIntegerField('CategoryID'           , Value);end;
procedure TBankStatementLine.SetBaseType            (const Value: string    ); begin SetStringField('BaseType'             , Value);end;
procedure TBankStatementLine.SetDescriptionSimple   (const Value: string    ); begin SetStringField('DescriptionSimple'    , Value);end;
procedure TBankStatementLine.SetDescriptionOriginal (const Value: string    ); begin SetStringField('DescriptionOriginal' , Value);end;
procedure TBankStatementLine.SetDescriptionConsumer (const Value: string    ); begin SetStringField('DescriptionConsumer' , Value);end;
procedure TBankStatementLine.SetCheckNumber         (const Value: string    ); begin SetStringField('CheckNumber'          , Value);end;
procedure TBankStatementLine.SetAccountID           (const Value: Integer   ); begin SetIntegerField('AccountID'            , Value);end;
procedure TBankStatementLine.SetAccountName         (const Value: string    ); begin SetStringField('AccountName'          , Value);end;
procedure TBankStatementLine.SetReconciliationLineID(const Value: Integer   ); begin SetIntegerField('ReconciliationLineID' , Value);end;
procedure TBankStatementLine.SetJSON                (const Value: string    ); begin SetStringField('JSON'                 , Value);end;
procedure TBankStatementLine.SetActive              (const Value: Boolean   ); begin SetBooleanField('Active'               , Value);end;


{ TBankStatementImports }


initialization
  RegisterClass(TBankStatementImports);
  RegisterClass(TBankStatementLine);
  RegisterClass(TReconciliation);
  RegisterClass(TReconciliationWithdrawalLines);
  RegisterClass(TReconciliationDepositLines);


end.



