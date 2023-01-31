unit BusobjReconciliationGUILines;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/12/20  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type

  TGUIReconciliationLines = class(TMSBusObj)
  private
    fdGUILineDate :TDateTime;
    function GetSeqno                       : Integer   ;
    function GetNotes                       : string    ;
    function GetDepositID                   : Integer   ;
    function GetDepositLineID               : Integer   ;
    function GetDepositDate                 : TDateTime ;
    function GetAmount                      : Double    ;
    function GetPaymentID                   : Integer   ;
    function GetCusID                       : Integer   ;
    function GetReferenceNo                 : string    ;
    function GetCompanyName                 : string    ;
    function GetStatementLineID             : Integer   ;
    function GetStatementTransactionDate    : string    ;
    function GetStatementAmount             : string    ;
    function GetStatementDescription        : string    ;
    procedure SetSeqno                       (const Value: Integer   );
    procedure SetNotes                       (const Value: string    );
    procedure SetDepositID                   (const Value: Integer   );
    procedure SetDepositLineID               (const Value: Integer   );
    procedure SetDepositDate                 (const Value: TDateTime );
    procedure SetAmount                      (const Value: Double    );
    procedure SetPaymentID                   (const Value: Integer   );
    procedure SetCusID                       (const Value: Integer   );
    procedure SetReferenceNo                 (const Value: string    );
    procedure SetCompanyName                 (const Value: string    );
    procedure SetStatementLineID             (const Value: Integer   );
    procedure SetStatementTransactionDate    (const Value: string    );
    procedure SetStatementAmount             (const Value: string    );
    procedure SetStatementDescription        (const Value: string    );
    function getBankRecAccountID: Integer;
    function getGUILineAccountID: Integer;
    function getFilterLinesDate: TDateTime;
    function getFilterLinesforDate: Boolean;
    function getListofToBeReconciled: Boolean;
    function getUseStatements: Boolean;
    function getReconciliationID: Integer;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
    Function  DoBeforeOpen(Sender :TDataset):Boolean;override;
    function getBankRecSQL: String;Virtual;
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
    Property     BankRecAccountID :Integer read getBankRecAccountID;
    Property BankRecSQL :String read getBankRecSQL;
    Property FilterLinesforDate       : Boolean   Read getFilterLinesforDate   ;
    Property ListofToBeReconciled     : Boolean   Read getListofToBeReconciled ;
    Property UseStatements            : Boolean   Read getUseStatements        ;
    Property FilterLinesDate          : TDateTime Read getFilterLinesDate      ;
    Property ReconciliationID         : Integer   Read getReconciliationID     ;

    Property GUILineAccountID         : Integer    read getGUILineAccountID;
    Property GUILineDate              : TDatetime  read fdGUILineDate;

  published
    property Seqno                        :Integer     read GetSeqno                      write SetSeqno                   ;
    property Notes                        :string      read GetNotes                      write SetNotes                   ;
    property DepositID                    :Integer     read GetDepositID                  write SetDepositID               ;
    property DepositLineID                :Integer     read GetDepositLineID              write SetDepositLineID           ;
    property DepositDate                  :TDateTime   read GetDepositDate                write SetDepositDate             ;
    property Amount                       :Double      read GetAmount                     write SetAmount                  ;
    property PaymentID                    :Integer     read GetPaymentID                  write SetPaymentID               ;
    property CusID                        :Integer     read GetCusID                      write SetCusID                   ;
    property ReferenceNo                  :string      read GetReferenceNo                write SetReferenceNo             ;
    property CompanyName                  :string      read GetCompanyName                write SetCompanyName             ;
    property StatementLineID              :Integer     read GetStatementLineID            write SetStatementLineID         ;
    property StatementTransactionDate     :string      read GetStatementTransactionDate   write SetStatementTransactionDate;
    property StatementAmount              :string      read GetStatementAmount            write SetStatementAmount         ;
    property StatementDescription         :string      read GetStatementDescription       write SetStatementDescription    ;
  end;
  TGUIDepositReconciliationLines = class(TGUIReconciliationLines)
  Private
  Protected
    function getBankRecSQL: String;Override;
  Public
  Published
  end;
  TGUIWithDrawReconciliationLines = class(TGUIReconciliationLines)
  Private
  Protected
    function getBankRecSQL: String;Override;
  Public
  Published
  end;

implementation


uses ERPdbComponents, tcDataUtils, CommonLib, BusobjReconciliation, tcConst, sysutils,
  MySQLConst, RecLib;

  {TGUIReconciliationLines}

constructor TGUIReconciliationLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL:= BankRecSQL;
  fdGUILineDate :=0;
end;


destructor TGUIReconciliationLines.Destroy;
begin
  inherited;
end;




procedure TGUIReconciliationLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Seqno');
  SetPropertyFromNode(node,'Notes');
  SetPropertyFromNode(node,'DepositID');
  SetPropertyFromNode(node,'DepositLineID');
  SetDateTimePropertyFromNode(node,'DepositDate');
  SetPropertyFromNode(node,'Amount');
  SetPropertyFromNode(node,'PaymentID');
  SetPropertyFromNode(node,'CusID');
  SetPropertyFromNode(node,'ReferenceNo');
  SetPropertyFromNode(node,'CompanyName');
  SetPropertyFromNode(node,'StatementLineID');
  SetPropertyFromNode(node,'StatementTransactionDate');
  SetPropertyFromNode(node,'StatementAmount');
  SetPropertyFromNode(node,'StatementDescription');
end;


procedure TGUIReconciliationLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Seqno'                   ,Seqno);
  AddXMLNode(node,'Notes'                   ,Notes);
  AddXMLNode(node,'DepositID'               ,DepositID);
  AddXMLNode(node,'DepositLineID'           ,DepositLineID);
  AddXMLNode(node,'DepositDate'             ,DepositDate);
  AddXMLNode(node,'Amount'                  ,Amount);
  AddXMLNode(node,'PaymentID'               ,PaymentID);
  AddXMLNode(node,'CusID'                   ,CusID);
  AddXMLNode(node,'ReferenceNo'             ,ReferenceNo);
  AddXMLNode(node,'CompanyName'             ,CompanyName);
  AddXMLNode(node,'StatementLineID'         ,StatementLineID);
  AddXMLNode(node,'StatementTransactionDate',StatementTransactionDate);
  AddXMLNode(node,'StatementAmount'         ,StatementAmount);
  AddXMLNode(node,'StatementDescription'    ,StatementDescription);
end;


function TGUIReconciliationLines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;

function TGUIReconciliationLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TGUIReconciliationLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TGUIReconciliationLines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TGUIReconciliationLines.getGUILineAccountID: Integer;
begin
  REsult := 0;
  try
    if datasetAssigned then
      result := Dataset.parambyname('XAccountID').asInteger;
  Except
    // kill the exception
  end;
end;

function TGUIReconciliationLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TGUIReconciliationLines.GetIDField: string;
begin
  Result := 'DescriptiveRecordID'
end;

function TGUIReconciliationLines.GetIsList: Boolean;
begin
  Result := True;
end;

class function TGUIReconciliationLines.GetBusObjectTablename: string;
begin
end;

function TGUIReconciliationLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TGUIReconciliationLines.DoBeforeOpen(Sender: TDataset): Boolean;
begin
  result := inherited DoBeforeOpen(Sender);
  if not result then exit;
  TERPQuery(Sender).parambyname('XAccountID').asInteger :=BankRecAccountID;
end;

function TGUIReconciliationLines.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(Sender);
end;

function TGUIReconciliationLines.getListofToBeReconciled: Boolean   ;begin  Result := False;  if Assigned(Owner) then if Owner is TReconciliation then Result := TReconciliation(Owner).ListofToBeReconciled; end;
function TGUIReconciliationLines.getUseStatements       : Boolean   ;begin  Result := False;  if Assigned(Owner) then if Owner is TReconciliation then Result := TReconciliation(Owner).UseStatements;end;
function TGUIReconciliationLines.getFilterLinesDate     : TDateTime ;begin  Result := 0;      if Assigned(Owner) then if Owner is TReconciliation then Result := TReconciliation(Owner).FilterLinesDate;end;
function TGUIReconciliationLines.getFilterLinesforDate  : Boolean   ;begin  Result := False;  if Assigned(Owner) then if Owner is TReconciliation then Result := TReconciliation(Owner).FilterLinesforDate;end;
function TGUIReconciliationLines.getBankRecAccountID    : Integer   ;begin  Result := 0;      if Assigned(Owner) then if Owner is TReconciliation then Result := TReconciliation(Owner).AccountID;end;
function TGUIReconciliationLines.getBankRecSQL: String;
begin
  if FilterLinesforDate then fdGUILineDate := FilterLinesDate;
end;

function TGUIReconciliationLines.getReconciliationID    : Integer   ;begin  Result := 0;      if Assigned(Owner) then if Owner is TReconciliation then Result := TReconciliation(Owner).Id; end;

{Property Functions}
function  TGUIReconciliationLines.GetSeqno                   : Integer   ; begin Result := GetIntegerField('Seqno');end;
function  TGUIReconciliationLines.GetNotes                   : string    ; begin Result := GetStringField('Notes');end;
function  TGUIReconciliationLines.GetDepositID               : Integer   ; begin Result := GetIntegerField('DepositID');end;
function  TGUIReconciliationLines.GetDepositLineID           : Integer   ; begin Result := GetIntegerField('DepositLineID');end;
function  TGUIReconciliationLines.GetDepositDate             : TDateTime ; begin Result := GetDateTimeField('DepositDate');end;
function  TGUIReconciliationLines.GetAmount                  : Double    ; begin Result := GetFloatField('Amount');end;
function  TGUIReconciliationLines.GetPaymentID               : Integer   ; begin Result := GetIntegerField('PaymentID');end;
function  TGUIReconciliationLines.GetCusID                   : Integer   ; begin Result := GetIntegerField('CusID');end;
function  TGUIReconciliationLines.GetReferenceNo             : string    ; begin Result := GetStringField('ReferenceNo');end;
function  TGUIReconciliationLines.GetCompanyName             : string    ; begin Result := GetStringField('CompanyName');end;
function  TGUIReconciliationLines.GetStatementLineID         : Integer   ; begin Result := GetIntegerField('StatementLineID');end;
function  TGUIReconciliationLines.GetStatementTransactionDate: string    ; begin Result := GetStringField('StatementTransactionDate');end;

function  TGUIReconciliationLines.GetStatementAmount         : string    ; begin Result := GetStringField('StatementAmount');end;
function  TGUIReconciliationLines.GetStatementDescription    : string    ; begin Result := GetStringField('StatementDescription');end;
procedure TGUIReconciliationLines.SetSeqno                   (const Value: Integer   ); begin SetIntegerField('Seqno'                    , Value);end;
procedure TGUIReconciliationLines.SetNotes                   (const Value: string    ); begin SetStringField('Notes'                    , Value);end;
procedure TGUIReconciliationLines.SetDepositID               (const Value: Integer   ); begin SetIntegerField('DepositID'                , Value);end;
procedure TGUIReconciliationLines.SetDepositLineID           (const Value: Integer   ); begin SetIntegerField('DepositLineID'            , Value);end;
procedure TGUIReconciliationLines.SetDepositDate             (const Value: TDateTime ); begin SetDateTimeField('DepositDate'              , Value);end;
procedure TGUIReconciliationLines.SetAmount                  (const Value: Double    ); begin SetFloatField('Amount'                   , Value);end;
procedure TGUIReconciliationLines.SetPaymentID               (const Value: Integer   ); begin SetIntegerField('PaymentID'                , Value);end;
procedure TGUIReconciliationLines.SetCusID                   (const Value: Integer   ); begin SetIntegerField('CusID'                    , Value);end;
procedure TGUIReconciliationLines.SetReferenceNo             (const Value: string    ); begin SetStringField('ReferenceNo'              , Value);end;
procedure TGUIReconciliationLines.SetCompanyName             (const Value: string    ); begin SetStringField('CompanyName'              , Value);end;
procedure TGUIReconciliationLines.SetStatementLineID         (const Value: Integer   ); begin SetIntegerField('StatementLineID'          , Value);end;
procedure TGUIReconciliationLines.SetStatementTransactionDate(const Value: string    ); begin SetStringField('StatementTransactionDate' , Value);end;
procedure TGUIReconciliationLines.SetStatementAmount         (const Value: string    ); begin SetStringField('StatementAmount'          , Value);end;
procedure TGUIReconciliationLines.SetStatementDescription    (const Value: string    ); begin SetStringField('StatementDescription'     , Value);end;



{ TGUIWithDrawReconciliationLines }


function TGUIWithDrawReconciliationLines.getBankRecSQL: String;
begin
  REsult := ToBeReconciledWithdrawalSQL(FilterLinesDate,FilterLinesforDate,ListofToBeReconciled,UseStatements,ReconciliationID);
(*    Function BDnBDLTable                  (FilterBDAccount:Boolean)                         :String;begin  Result := 'FROM tblbankdeposit BD INNER JOIN tblbankdepositlines BDL Using (DepositID)  WHERE '+
                                                                                                                      iif(FilterBDAccount, 'BD.AccountID' , 'BDL.AccountID')+' = :xAccountID  ' ;end;
    function FilterForListofToBeReconciled(afieldName:String)                               :String;begin  Result := '';  if ListofToBeReconciled      then Result := Result +' AND '+aFieldname +' <> "T"  ' ;end;
    Function FilterLinesforDateCond       (aFieldname:String)                               :String;begin  Result := '';  if FilterLinesforDate        then Result := ' AND '+afieldname+' <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, FilterLinesDate));end;
    Function FieldReconciled              (const aFieldname:String)                         :String;begin  Result := '';  if not(ListofToBeReconciled) then Result := aFieldname +',';end;
    Function CustomerField                (SingleOrNocusIDValue, MultipleCusIDValue:String) :String;begin  Result := 'If((Max(CusID)-Min(CusID)=0) OR IsNull(CusID) ,'+SingleOrNocusIDValue+','+MultipleCusIDValue+') ';end;
    Function CUSIDField                                                                     :String;begin  Result := 'If(IsNull(CusID),0,CusID) as CusID,';end;
    Function BlankStatementfields                                                           :string;begin  Result :=  '0 AS StatementLineID,null AS StatementTransactionDate,null AS StatementAmount,null AS StatementDescription ';end;
begin
    inherited;
    Result := '';
    Result := Result +'SELECT   ' +
                       FieldReconciled('BDL.Reconciled')+
                       '1'                                                  +' as Seqno, ' +
                       CustomerField('BDL.TrnsType' ,'"Split Deposit"')     +' as Notes, ' +
                       'BD.DepositID'                                       +' as DepositID,' +
                       'BDL.DepositLineID'                                  +' as DepositLineID,' +
                       'DepositDate'                                        +' as DepositDate, ' +
                       'ABS(Amount)'                                        +' as Amount, ' +
                       'PaymentID'                                          +' as PaymentID,' +
                       CUSIDField+
                       CustomerField('BDL.ReferenceNo' ,'""')               +' as ReferenceNo, ' +
                       CustomerField('BDL.CompanyName' ,'""')               +' as CompanyName, ' +
                       BlankStatementfields+
                       BDnBDLTable(False)+
                       FilterForListofToBeReconciled('BDL.Reconciled')+
                       ' AND BDL.TrnsType<>"Deposit Entry" ' +
                                            ' AND BDL.TrnsType<>"Cheque"  ' +
                                            ' AND BDL.TrnsType<>"Cheque Deposit" ' +
                                            ' AND BDL.TrnsType<> '+quotedstr(CUSTOMER_PREPAYMENT)+'  ' +
                                            ' AND BDL.TrnsType<>'+ quotedstr(SUPPLIER_PREPAYMENT) + '   ' +
                                            ' AND BD.Deleted <>"T"  ' +
                                            ' AND FromDeposited<>"T" ' +
                                            ' AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 '+
                       FilterLinesforDateCond('DepositDate')+
                       ' Group By BDL.DepositLineID ';


    //Bank Deposit
    Result := Result + NL + ' UNION ALL SELECT   ' +
                       FieldReconciled('BD.Reconciled')+
                       '2 '                     +' as Seqno, ' +
                       '"Bank Deposit" '        +' as Notes, ' +
                       'BD.DepositID '          +' as DepositID,' +
                       '0 '                     +' as DepositLineID,' +
                       'DepositDate '           +' as DepositDate, ' +
                       'ABS(Deposit) '          +' as Amount, ' +
                       'BD.DepositID '          +' as PaymentID,' +
                       CUSIDField+
                       'BD.Notes '              +' as ReferenceNo, ' +
                       '"" '                    +' as CompanyName, ' +
                       BlankStatementfields+
                       BDnBDLTable(true)+
                       FilterForListofToBeReconciled('BD.Reconciled')+
                       ' AND BDL.TrnsType<>"Deposit Entry"      AND BDL.TrnsType<>"Cheque" ' +
                                                              ' AND BDL.TrnsType<> '+quotedstr(CUSTOMER_PREPAYMENT)+'   ' +
                                                              ' AND BDL.TrnsType<>'+ quotedstr(SUPPLIER_PREPAYMENT) + '   ' +
                                                              ' AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 AND FromDeposited="T" ' +
                                                              ' AND BD.Deleted <>"T" '+
                       FilterLinesforDateCond('DepositDate')+
                       ' Group By  BD.DepositID ';

    //Deposit Entry
    Result := Result + NL + 'UNION ALL SELECT   '+
                       FieldReconciled('BD.Reconciled')+
                       '3 '                                               +' as Seqno, ' +
                       CustomerField('BDL.TrnsType' ,'"Deposit Entry"')+''+' as Notes, ' +
                       'BD.DepositID '                                    +' as DepositID,' +
                       '0 '                                               +' as DepositLineID,' +
                       'DepositDate '                                     +' as DepositDate, ' +
                       'ABS(Deposit) '                                    +' as Amount, ' +
                       'BD.DepositID '                                    +' as PaymentID,' +
                       CUSIDField+
                       CustomerField('BDL.ReferenceNo' ,'""')             +' as ReferenceNo, ' +
                       CustomerField('BDL.CompanyName' ,'""')             +' as CompanyName, ' +
                       BlankStatementfields+
                       BDnBDLTable(true)+
                       FilterForListofToBeReconciled('BD.Reconciled')+    ' AND BDL.TrnsType="Deposit Entry" ' +
                                                                          ' AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' +
                                                                          ' AND BD.Deleted <>"T"  '+
                       FilterLinesforDateCond('DepositDate')+
                       ' Group By  BD.DepositID ';

    //Deposit Entry Split
    Result := Result + NL + ' UNION ALL SELECT   ' +
                       FieldReconciled('BDL.Reconciled')+
                       '4 '                                         +' as Seqno, ' +
                       '"Split Deposit" '                           +' as Notes, ' +
                       'BD.DepositID '                              +' as DepositID,' +
                       'DepositLineID '                             +' as DepositLineID,' +
                       'DepositDate '                               +' as DepositDate, ' +
                       'ABS(Amount) '                               +' as Amount, ' +
                       'BD.DepositID '                              +' as PaymentID,' +
                       CUSIDField+
                       CustomerField('BDL.ReferenceNo' ,'""')       +' as ReferenceNo, ' +
                       CustomerField('BDL.CompanyName' ,'""')       +' as CompanyName, ' +
                       BlankStatementfields+
                       BDnBDLTable(False)+
                       FilterForListofToBeReconciled('BDL.Reconciled')+' AND BDL.TrnsType="Deposit Entry" ' +
                                                                       'AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' +
                                                                       'AND BD.Deleted <>"T"  '+
                       FilterLinesforDateCond('DepositDate')+
                       ' Group By BDL.DepositLineID  ';

    //Supplier Prepayment
    Result := Result + NL + 'UNION ALL  SELECT   ' +
                       FieldReconciled('BDL.Reconciled')+
                       '5 '                                                 +' as Seqno, ' +
                       CustomerField('BDL.TrnsType' ,'"Split Deposit"')     +' as Notes, ' +
                       'BD.DepositID '                                      +' as DepositID,' +
                       'BDL.DepositLineID '                                 +' as DepositLineID,' +
                       'DepositDate '                                       +' as DepositDate, ' +
                       'ABS(Sum(Amount)) '                                  +' as Amount, ' +
                       'PaymentID '                                         +' as PaymentID,' +
                       CUSIDField+
                       CustomerField('BDL.ReferenceNo' ,'""')               +' as ReferenceNo, ' +
                       CustomerField('BDL.CompanyName' ,'""')               +' as CompanyName,  ' +
                       BlankStatementfields+
                       BDnBDLTable(False)+
                       FilterForListofToBeReconciled('BDL.Reconciled')+'AND BDL.TrnsType='+ quotedstr(SUPPLIER_PREPAYMENT) + '   ' +
                                                                        'AND BD.Deleted <>"T" AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 '+
                       FilterLinesforDateCond('DepositDate')+
                       ' Group By BDL.DepositLineID  ';

    //Customer Prepayment
    Result := Result + NL + ' UNION ALL SELECT   ' +
                       FieldReconciled('BDL.Reconciled')+
                       '6 '                                                +' as Seqno, ' +
                       CustomerField('BDL.TrnsType' ,'"Deposit Entry"')    +' as Notes, ' +
                       'BD.DepositID '                                     +' as DepositID,' +
                       'BDL.DepositLineID '                                +' as DepositLineID,' +
                       'DepositDate '                                      +' as DepositDate,  ' +
                       'ABS(Deposit) '                                     +' as Amount, ' +
                       'BD.DepositID '                                     +' as PaymentID,' +
                       CUSIDField+
                       CustomerField('BDL.ReferenceNo' ,'""')              +' as ReferenceNo, ' +
                       CustomerField('BDL.CompanyName' ,'""')              +' as CompanyName, ' +
                       BlankStatementfields+
                       BDnBDLTable(true)+
                       FilterForListofToBeReconciled('BDL.Reconciled')+   ' AND BDL.TrnsType= '+quotedstr(CUSTOMER_PREPAYMENT)+'  ' +
                                                                          ' AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' +
                                                                          ' AND BD.Deleted <>"T"  '+
                       FilterLinesforDateCond('DepositDate')+
                       ' Group By BDL.DepositLineID ';

    //Cheques
    Result := Result + NL + 'UNION ALL  SELECT   ' +
                        FieldReconciled('BD.Reconciled')+
                        '7 '                                                +' as Seqno, ' +
                        CustomerField('BDL.TrnsType' ,'"Split Deposit"')    +' as Notes, ' +
                        'BD.DepositID '                                     +' as DepositID,' +
                        '0 '                                                +' as DepositLineID,' +
                        'DepositDate '                                      +' as DepositDate, ' +
                        'ABS(Deposit) '                                     +' as Amount, ' +
                        'PaymentID '                                        +' as PaymentID,' +
                        CUSIDField+
                        CustomerField('BDL.ReferenceNo' ,'""')              +' as ReferenceNo, ' +
                        CustomerField('BDL.CompanyName' ,'""')              +' as CompanyName,  ' +
                        BlankStatementfields+
                        BDnBDLTable(true)+
                        FilterForListofToBeReconciled('BD.Reconciled')+ ' AND BDL.TrnsType="Cheque" ' +
                                                                        ' AND BD.Deleted <>"T" ' +
                                                                        ' AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 '+
                        FilterLinesforDateCond('DepositDate')+
                        ' Group By BD.DepositID  '; //Not BDL.DepositLineID  Because Sum Of Cheque Header Account

    //Cheque Deposits
    Result := Result + NL + 'UNION ALL SELECT   ' +
                        FieldReconciled('BD.Reconciled')+
                        '8 '                                                +' as Seqno, ' +
                        CustomerField('BDL.TrnsType' ,'"Deposit Entry"')    +' as Notes, ' +
                        'BD.DepositID '                                     +' as DepositID,' +
                        'BDL.DepositLineID '                                +' as DepositLineID,' +
                        'DepositDate '                                      +' as DepositDate, ' +
                        'ABS(Sum(Amount)) '                                 +' as Amount, ' +
                        'PaymentID '                                        +' as PaymentID,' +
                        CUSIDField+
                        CustomerField('BDL.ReferenceNo' ,'""')              +' as ReferenceNo, ' +
                        CustomerField('BDL.CompanyName' ,'""')              +' as CompanyName, ' +
                        BlankStatementfields+
                        BDnBDLTable(true)+
                        FilterForListofToBeReconciled('BD.Reconciled')+ ' AND BDL.TrnsType="Cheque Deposit" ' +
                                                                        ' AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' +
                                                                        ' AND BD.Deleted <>"T"  '+
                        FilterLinesforDateCond('DepositDate')+
                        ' Group By BDL.DepositLineID ';

    if self.UseStatements then begin
      Result := Result + NL + 'UNION ALL SELECT   ' +
                            FieldReconciled('Null')+
                             '0 '+' as Seqno, ' +
                              'bsl.DescriptionSimple '+' as Notes, ' +
                              'IfNull(rwl.PaymentID,0) '+' as DepositID, ' +
                              'IfNull(rwl.DepositLineID,0) '+' as DepositLineID, ' +
                              'bsl.TransactionDate '+' as DepositDate, ' +
                              'bsl.Amount '+' as Amount, ' +
                              '0 '+' as PaymentID, ' +
                              '0 '+' as CusID, ' +
                              'null '+' as ReferenceNo, ' +
                              'null '+' as CompanyName, ' +
                              'bsl.ID '+' as StatementLineID, ' +
                              'bsl.TransactionDate '+' as StatementTransactionDate, ' +
                              'bsl.Amount '+' as StatementAmount, ' +
                              'bsl.DescriptionSimple '+' as StatementDescription ' +
                              'from  tblbankstatementline bsl ' +
                              'left join tblReconciliationWithdrawalLines rwl on rwl.ReconciliationLineID = bsl.ReconciliationLineID ' +
                              'where bsl.AccountID = :xAccountID ' +
                              'and bsl.Active = "T"' +
                              'and bsl.BaseType = "DEBIT" ' +
                              'and ((IfNull(bsl.ReconciliationLineID,0) = 0) or (IfNull(rwl.ReconciliationId,0) > 0 and rwl.ReconciliationId = ' + IntToStr(ReconciliationID)+ '))';
                              FilterLinesforDateCond('bsl.TransactionDate');
    end;

    Result := Result + NL +' Order by DepositDate';*)
end;

{ TGUIDepositReconciliationLines }

function TGUIDepositReconciliationLines.getBankRecSQL: String;
begin
  REsult := ToBeReconciledDepositsSQL(FilterLinesDate,FilterLinesforDate,ListofToBeReconciled,UseStatements,ReconciliationID);
(*    Function BDnBDLTable                  (FilterBDAccount:Boolean)                         :String;begin  Result := 'FROM tblbankdeposit BD INNER JOIN tblbankdepositlines BDL Using (DepositID)  WHERE '+
                                                                                                                      iif(FilterBDAccount, 'BD.AccountID' , 'BDL.AccountID')+' = :xAccountID  ' ;end;
    function FilterForListofToBeReconciled(afieldName:String)                               :String;begin  Result := '';  if ListofToBeReconciled      then Result := ' AND '+aFieldname +' <> "T"  ' ;end;
    Function FilterLinesforDateCond       (aFieldname:String)                               :String;begin  Result := '';  if FilterLinesforDate        then Result := ' AND '+afieldname+' <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, FilterLinesDate));end;
    Function FieldReconciled              (const aFieldname:String)                         :String;begin  Result := '';  if not(ListofToBeReconciled) then Result := aFieldname +' as Reconciled,';end;
    Function CustomerField                (SingleOrNocusIDValue, MultipleCusIDValue:String) :String;begin  Result := 'If((Max(CusID)-Min(CusID)=0) OR IsNull(CusID) ,'+SingleOrNocusIDValue+','+MultipleCusIDValue+') ';end;
    Function CUSIDField                                                                     :String;begin  Result := 'If(IsNull(CusID),0,CusID) as CusID,';end;
    Function BlankStatementfields                                                           :string;begin  Result :=  '0 AS StatementLineID,null AS StatementTransactionDate,null AS StatementAmount,null AS StatementDescription ';end;
begin
    inherited;
    Result := '';
    Result := Result +' SELECT  '+
                        FieldReconciled('BDL.Reconciled')+
                        '1'                                                 +' AS Seqno,  ' +
                        CustomerField('BDL.TrnsType','"Split Deposit"') +'' +' AS Notes, ' +
                        'BD.DepositID'                                      +' AS DepositID,' +
                        'BDL.DepositLineID'                                 +' AS DepositLineID,' +
                        'DepositDate'                                     +' AS DepositDate, ' +
                        'ABS(Amount)'                                     +' AS Amount, ' +
                        'PaymentID'                                     +' AS PaymentID,' +
                        CUSIDfield+
                        CustomerField('BDL.ReferenceNo' ,'""')+''           +' AS ReferenceNo, ' +
                        CustomerField('BDL.CompanyName' ,'""')+''           +' AS CompanyName, ' +
                        BlankStatementfields+
                        BDnBDLTable(False)+//'FROM tblbankdeposit BD INNER JOIN tblbankdepositlines BDL Using (DepositID) WHERE BDL.AccountID = :xAccountID   ' +
                         FilterForListofToBeReconciled('BDL.Reconciled')+
                        ' AND BDL.TrnsType<>"Deposit Entry" ' +
                        ' AND BDL.TrnsType<>"Cheque Deposit" ' +
                        ' AND BDL.TrnsType<>"Cheque" ' +
                        ' AND BDL.TrnsType<> '+quotedstr(CUSTOMER_PREPAYMENT)+'   ' +
                        ' AND BDL.TrnsType<>'+ quotedstr(SUPPLIER_PREPAYMENT) + '   ' +
                        ' AND FromDeposited<>"T" ' +
                        ' AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00  ' +
                        ' AND BD.Deleted <>"T"  '+
                        FilterLinesforDateCond('DepositDate')+
                        ' Group By BDL.DepositLineID ';


      //Customer Prepayment
      Result := Result +NL + ' UNION ALL  '+
                          'SELECT  '+ FieldReconciled('BDL.Reconciled')+
                          '2'                                                 +' AS Seqno,  ' +
                          CustomerField('BDL.TrnsType' ,'"Deposit Entry"')+'' +' AS Notes, ' +
                          'BD.DepositID '                                     +' AS DepositID,' +
                          'BDL.DepositLineID'                                 +' AS DepositLineID,' +
                          'DepositDate  '                                     +' AS DepositDate, ' +
                          'ABS(Deposit) '                                     +' AS Amount, ' +
                          'BD.DepositID '                                     +' AS PaymentID,' +
                          CUSIDfield+
                          CustomerField('BDL.ReferenceNo' ,'""')+''           +' AS ReferenceNo, ' +
                          CustomerField('BDL.CompanyName' ,'""')+''           +' AS CompanyName, ' +
                          BlankStatementfields+
                          BDnBDLTable(False)+//'FROM tblbankdeposit BD INNER JOIN tblbankdepositlines BDL Using (DepositID)  WHERE BDL.AccountID = :xAccountID    ' +
                          FilterForListofToBeReconciled('BDL.Reconciled')+
                          'AND BDL.TrnsType= '+quotedstr(CUSTOMER_PREPAYMENT)+'  ' +
                          'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' +
                          'AND BD.Deleted <>"T"  '+
                          FilterLinesforDateCond('DepositDate')+
                          ' Group By BDL.DepositLineID ';



      //Supplier Prepayment
      Result := Result + NL  + ' UNION ALL ' +
                          'SELECT   '+ FieldReconciled('BDL.Reconciled')+
                          '3'                                                 +' AS Seqno,  ' +
                          CustomerField('BDL.TrnsType' ,'"Split Deposit"') +' AS Notes, ' +
                          'BD.DepositID '                                     +' AS DepositID  ,' +
                          'BDL.DepositLineID'                                 +' AS DepositLineID,' +
                          'DepositDate  '                                     +' AS DepositDate, ' +
                          'ABS(Sum(Amount))'                                  +' AS Amount, ' +
                          'PaymentID    '                                     +' AS PaymentID,' +
                          CUSIDfield+
                          CustomerField('BDL.ReferenceNo' ,'""')+''           +' AS ReferenceNo, ' +
                          CustomerField('BDL.CompanyName' ,'""')+''           +' AS CompanyName,  ' +
                          BlankStatementfields+
                          BDnBDLTable(False)+//'FROM tblbankdeposit BD  INNER JOIN tblbankdepositlines BDL Using (DepositID)  WHERE BDL.AccountID = :xAccountID  ' +
                          FilterForListofToBeReconciled('BDL.Reconciled')+
                          ' AND BDL.TrnsType='+ quotedstr(SUPPLIER_PREPAYMENT) + '   ' +
                          'AND BD.Deleted <>"T" AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 '+
                          FilterLinesforDateCond('DepositDate')+
                          ' Group By BDL.DepositLineID  ';

      //Deposit Entry
      Result := Result + NL  + ' UNION ALL  ' +
                          'SELECT   '+ FieldReconciled('BD.Reconciled')+
                          '4'                                                 +' AS Seqno,  ' +
                          CustomerField('BDL.TrnsType' ,'"Deposit Entry"')+'' +' AS Notes, ' +
                          'BD.DepositID '                                     +' AS DepositID,' +
                          '0'                                                 +' AS DepositLineID,' +
                          'DepositDate  '                                     +' AS DepositDate  , ' +
                          'ABS(Deposit) '                                     +' AS Amount, ' +
                          'BD.DepositID '                                     +' AS PaymentID,' +
                          CUSIDfield+
                          CustomerField('BDL.ReferenceNo' ,'""')+''           +' AS ReferenceNo, ' +
                          CustomerField('BDL.CompanyName' ,'""')+''           +' AS CompanyName, ' +
                          BlankStatementfields+
                          BDnBDLTable(true)+//'FROM tblbankdeposit BD INNER JOIN tblbankdepositlines BDL Using (DepositID) WHERE BD.AccountID = :xAccountID  ' +
                          FilterForListofToBeReconciled('BD.Reconciled')+
                          ' AND BDL.TrnsType="Deposit Entry" ' +
                          'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' +
                          'AND BD.Deleted <>"T"  '+
                          FilterLinesforDateCond('DepositDate')+
                          ' Group By  BD.DepositID ';

      //Deposit Entry Split
      Result := Result + NL  + 'UNION ALL ' +
                          'SELECT   '+ FieldReconciled('BDL.Reconciled')+
                          '5'                                               +' AS Seqno,  ' +
                          '"Split Deposit"'                                 +' AS Notes, ' +
                          'BD.DepositID'                                    +' AS DepositID,' +
                          'DepositLineID'                                   +' AS DepositLineID,' +
                          'DepositDate'                                     +' AS DepositDate, ' +
                          'ABS(Amount)'                                     +' AS Amount, ' +
                          'BD.DepositID'                                    +' AS PaymentID,' +
                          CUSIDfield+
                          CustomerField('BDL.ReferenceNo' ,'""')+''         +' AS ReferenceNo, ' +
                          CustomerField('BDL.CompanyName' ,'""')+''         +' AS CompanyName, ' +
                          BlankStatementfields+
                          BDnBDLTable(False)+//'FROM tblbankdeposit BD INNER JOIN tblbankdepositlines BDL Using (DepositID) WHERE BDL.AccountID = :xAccountID  ' +
                          FilterForListofToBeReconciled('BDL.Reconciled')+
                          ' AND BDL.TrnsType="Deposit Entry" ' +
                          'AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' +
                          'AND BD.Deleted <>"T"  '+
                          FilterLinesforDateCond('DepositDate')+
                          ' Group By BDL.DepositLineID  ';

      //Bank Deposit
      Result := Result + NL  + ' UNION ALL ' +
                          'SELECT   '+ FieldReconciled('BD.Reconciled ')+
                          '6'                                                         +' AS Seqno,  ' +
                          '"Bank Deposit"       '                                     +' AS Notes, ' +
                          'BD.DepositID         '                                     +' AS DepositID,' +
                          '0'                                                         +' AS DepositLineID,' +
                          'DepositDate'                                               +' AS DepositDate  , ' +
                          'ABS(Deposit)         '                                     +' AS Amount, ' +
                          'BD.DepositID         '                                     +' AS PaymentID, ' +
                          'CusID    '                                                 +' AS CusID, ' +
                          'BD.Notes '                                                 +' AS ReferenceNo, ' +
                          '""       '                                                 +' AS CompanyName, ' +
                          BlankStatementfields+
                          BDnBDLTable(true)+//'FROM tblbankdeposit BD INNER JOIN tblbankdepositlines BDL Using (DepositID) WHERE BD.AccountID = :xAccountID    ' +
                          FilterForListofToBeReconciled('BD.Reconciled')+
                          ' AND BDL.TrnsType<>"Deposit Entry" AND BDL.TrnsType<>"Cheque Deposit" ' +
                          'AND BDL.TrnsType<> '+quotedstr(CUSTOMER_PREPAYMENT)+'  AND BDL.TrnsType<>'+ quotedstr(SUPPLIER_PREPAYMENT) + '   ' +
                          'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 AND FromDeposited="T" ' +
                          'AND BD.Deleted <>"T" '+
                          FilterLinesforDateCond('DepositDate')+
                          ' Group By  BD.DepositID ';

      //Cheques
      Result := Result + NL  + ' UNION ALL  ' +
                          'SELECT   '+ FieldReconciled('BD.Reconciled ')+
                          '7'                                                 +' AS Seqno,  ' +
                          CustomerField('BDL.TrnsType' ,'"Split Deposit"') +' AS Notes, ' +
                          'BD.DepositID '                                     +' AS DepositID  ,' +
                          '0'                                                 +' AS DepositLineID,' +
                          'DepositDate  '                                     +' AS DepositDate, ' +
                          'ABS(Deposit) '                                     +' AS Amount, ' +
                          // 0 AS DepositLineID Due To
                          'PaymentID    '                                     +' AS PaymentID,' +
                          CUSIDfield+
                          CustomerField('BDL.ReferenceNo' ,'""')+''           +' AS ReferenceNo, ' +
                          CustomerField('BDL.CompanyName' ,'""')+''           +' AS CompanyName,  ' +
                          BlankStatementfields+
                          BDnBDLTable(true)+//'FROM tblbankdeposit BD  INNER JOIN tblbankdepositlines BDL Using (DepositID) WHERE BD.AccountID = :xAccountID  ' +
                          FilterForListofToBeReconciled('BD.Reconciled')+
                          'AND BDL.TrnsType="Cheque" ' +
                          'AND BD.Deleted <>"T" ' +
                          'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 '+
                          FilterLinesforDateCond('DepositDate')+
                          ' Group By BD.DepositID  '; //Not BDL.DepositLineID  Because Sum Of Cheque Header Account

      //Cheque Deposits
      Result := Result + NL  + ' UNION ALL  ' +
                          'SELECT   '+ FieldReconciled('BD.Reconciled ')+
                          '8'                                                 +' AS Seqno,  ' +
                          CustomerField('BDL.TrnsType' ,'"Deposit Entry"')+'' +' AS Notes, ' +
                          'BD.DepositID '                                     +' AS DepositID,' +
                          'BDL.DepositLineID'                                 +' AS DepositLineID,' +
                          'DepositDate  '                                     +' AS DepositDate, ' +
                          'ABS(Sum(Amount))'                                  +' AS Amount, ' +
                          'PaymentID    '                                     +' AS PaymentID,' +
                          CUSIDfield+
                          CustomerField('BDL.ReferenceNo' ,'""')+''           +' AS ReferenceNo, ' +
                          CustomerField('BDL.CompanyName' ,'""')+''           +' AS CompanyName, ' +
                          BlankStatementfields+
                          BDnBDLTable(True)+//'FROM tblbankdeposit BD INNER JOIN tblbankdepositlines BDL Using (DepositID) WHERE BD.AccountID = :xAccountID   ' +
                          FilterForListofToBeReconciled('BD.Reconciled')+
                          ' AND BDL.TrnsType="Cheque Deposit" ' +
                          'AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' +
                          'AND BD.Deleted <>"T"  '+
                          FilterLinesforDateCond('DepositDate')+
                          ' group by BDL.DepositLineID ';

    if self.UseStatements then begin
      Result := Result + NL  + 'UNION ALL ' +
                          'SELECT   '+ FieldReconciled('Null')+
                          '0'                                 +' AS Seqno,  ' +
                          'bsl.DescriptionSimple'             +' AS Notes, ' +
                          'IfNull(rdl.PaymentID,0)'           +' AS DepositID, ' +
                          'IfNull(rdl.DepositLineID,0)'       +' AS DepositLineID, ' +
                          'bsl.TransactionDate'               +' AS DepositDate, ' +
                          'bsl.Amount'                        +' AS Amount, ' +
                          '0'                                 +' AS PaymentID, ' +
                          '0'                                 +' AS CusID, ' +
                          'null'                              +' AS ReferenceNo, ' +
                          'null'                              +' AS CompanyName, ' +
                          'bsl.ID'                            +' AS StatementLineID, ' +
                          'bsl.TransactionDate'               +' AS StatementTransactionDate, ' +
                          'bsl.Amount'                        +' AS StatementAmount, ' +
                          'bsl.DescriptionSimple'             +' AS StatementDescription ' +
                          'from  tblbankstatementline bsl left join tblReconciliationDepositLines rdl on rdl.ReconciliationLineID = bsl.ReconciliationLineID where bsl.AccountID = :xAccountID ' +
                          'and bsl.Active = "T"' +
                          'and bsl.BaseType = "CREDIT"' +
                          'and ((IfNull(bsl.ReconciliationLineID,0) = 0) or (IfNull(rdl.ReconciliationId,0) > 0 and rdl.ReconciliationId = ' + IntToStr(ID)+ '))'+
                          FilterLinesforDateCond('bsl.TransactionDate');
    end;

    Result := Result + NL +' Order by DepositDate';*)
end;

initialization
  RegisterClass(TGUIDepositReconciliationLines);
  RegisterClass(TGUIWithDrawReconciliationLines);
end.

