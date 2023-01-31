unit BusobjABA;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  17/09/07  1.00.01  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TABADetailRecord = class(TMSBusObj)
  private
    Function GetDescriptiveRecordID         : Integer   ;
    Function GetRecordType                  : String   ;
    Function GetBSB                         : string    ;
    Function GetCreditDebitAccountNumber    : string    ;
    Function GetIndicator                   : String    ;
    Function GetTransactionCode             : string    ;
    Function GetAmount                      : Double    ;
    Function GetAccountName                 : string    ;
    Function GetLodgementReferences         : string    ;
    Function GetUsersBSB                    : string    ;
    Function GetUsersAccountNumber          : string    ;
    Function GetNameofRemitter              : string    ;
    Function GetAmountOfWithholdingTax      : string    ;
    Function GetApply                       : Boolean   ;
    Function GetAccountID                   : Integer   ;
    Function GetTransType                   : string    ;
    Function GetTransID                     : Integer   ;
    Function GetTransCodeDesc               : string    ;
    Procedure SetDescriptiveRecordID         (const Value: Integer   );
    Procedure SetRecordType                  (const Value: String   );
    Procedure SetBSB                         (const Value: string    );
    Procedure SetCreditDebitAccountNumber    (const Value: string    );
    Procedure SetIndicator                   (const Value: String   );
    Procedure SetTransactionCode             (const Value: string    );
    Procedure SetAmount                      (const Value: Double    );
    Procedure SetAccountName                 (const Value: string    );
    Procedure SetLodgementReferences         (const Value: string    );
    Procedure SetUsersBSB                    (const Value: string    );
    Procedure SetUsersAccountNumber          (const Value: string    );
    Procedure SetNameofRemitter              (const Value: string    );
    Procedure SetAmountOfWithholdingTax      (const Value: string    );
    Procedure SetApply                       (const Value: Boolean   );
    Procedure SetAccountID                   (const Value: Integer   );
    Procedure SetTransType                   (const Value: string    );
    Procedure SetTransID                     (const Value: Integer   );
    Procedure SetTransCodeDesc               (const Value: string    );
  Protected
    Procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    Procedure DoFieldOnChange(Sender: TField);                           override;
    Function  GetSQL: string;                                            override;
    Function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
  Public
    class Function  GetIDField: string;                                  override;
    class function GetBusObjectTablename: string;                        Override;
    Constructor  Create(AOwner: TComponent);                             override;
    Destructor   Destroy;                                                override;
    Procedure    LoadFromXMLNode(const node: IXMLNode);                  override;
    Procedure    SaveToXMLNode(const node: IXMLNode);                    override;
    Function     ValidateData: Boolean ;                                 override;
    Function     Save: Boolean ;                                         override;
  Published
    property DescriptiveRecordID          :Integer     read GetDescriptiveRecordID        write SetDescriptiveRecordID     ;
    property RecordType                   :String      read GetRecordType                 write SetRecordType              ;
    property BSB                          :string      read GetBSB                        write SetBSB                     ;
    property CreditDebitAccountNumber     :string      read GetCreditDebitAccountNumber   write SetCreditDebitAccountNumber;
    property Indicator                    :String      read GetIndicator                  write SetIndicator               ;
    property TransactionCode              :string      read GetTransactionCode            write SetTransactionCode         ;
    property Amount                       :Double      read GetAmount                     write SetAmount                  ;
    property AccountName                  :string      read GetAccountName                write SetAccountName             ;
    property LodgementReferences          :string      read GetLodgementReferences        write SetLodgementReferences     ;
    property UsersBSB                     :string      read GetUsersBSB                   write SetUsersBSB                ;
    property UsersAccountNumber           :string      read GetUsersAccountNumber         write SetUsersAccountNumber      ;
    property NameofRemitter               :string      read GetNameofRemitter             write SetNameofRemitter          ;
    property AmountOfWithholdingTax       :string      read GetAmountOfWithholdingTax     write SetAmountOfWithholdingTax  ;
    property Apply                        :Boolean     read GetApply                      write SetApply                   ;
    property AccountID                    :Integer     read GetAccountID                  write SetAccountID               ;
    property TransType                    :string      read GetTransType                  write SetTransType               ;
    property TransID                      :Integer     read GetTransID                    write SetTransID                 ;
    property TransCodeDesc                :string      read GetTransCodeDesc              write SetTransCodeDesc           ;
  end;

  TABADescriptiveRecord = class(TMSBusObj)
  private
    Function GetRecordType                : String   ;
    Function GetBlank1                    : string    ;
    Function GetReelSequenceNumber        : string    ;
    Function GetUserBankName              : string    ;
    Function GetBlank2                    : string    ;
    Function GetDirectEntryUserName       : string    ;
    Function GetDirectEntryUserID         : string    ;
    Function GetTransactionDescription    : string    ;
    Function GetProcessingDate            : TDateTime ;
    Function GetProcessingIndicator       : Boolean   ;
    Function GetBlank3                    : string    ;
    Function GetAccountID                 : Integer   ;
    Function GetIncludeBalanceRecord      : Boolean   ;
    Function GetIncludeNetTotal           : Boolean   ;
    Function GetIncludeCreditTotal        : Boolean   ;
    Function GetIncludeDebitTotal         : Boolean   ;
    Procedure SetRecordType                (const Value: String   );
    Procedure SetBlank1                    (const Value: string    );
    Procedure SetReelSequenceNumber        (const Value: string    );
    Procedure SetUserBankName              (const Value: string    );
    Procedure SetBlank2                    (const Value: string    );
    Procedure SetDirectEntryUserName       (const Value: string    );
    Procedure SetDirectEntryUserID         (const Value: string    );
    Procedure SetTransactionDescription    (const Value: string    );
    Procedure SetProcessingDate            (const Value: TDateTime );
    Procedure SetProcessingIndicator       (const Value: Boolean   );
    Procedure SetBlank3                    (const Value: string    );
    Procedure SetAccountID                 (const Value: Integer   );
    Procedure SetIncludeBalanceRecord      (const Value: Boolean   );
    Procedure SetIncludeNetTotal           (const Value: Boolean   );
    Procedure SetIncludeCreditTotal        (const Value: Boolean   );
    Procedure SetIncludeDebitTotal         (const Value: Boolean   );
  Protected
    Procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    Procedure DoFieldOnChange(Sender: TField);                           override;
    Function  GetSQL: string;                                            override;
    Function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
  Public
    class Function  GetIDField: string;                                  override;
    class function GetBusObjectTablename: string;                        Override;
    Constructor  Create(AOwner: TComponent);                             override;
    Destructor   Destroy;                                                override;
    Procedure    LoadFromXMLNode(const node: IXMLNode);                  override;
    Procedure    SaveToXMLNode(const node: IXMLNode);                    override;
    Function     ValidateData: Boolean ;                                 override;
    Function     Save: Boolean ;                                         override;
  Published
    property RecordType                 :String      read GetRecordType               write SetRecordType            ;
    property Blank1                     :string      read GetBlank1                   write SetBlank1                ;
    property ReelSequenceNumber         :string      read GetReelSequenceNumber       write SetReelSequenceNumber    ;
    property UserBankName               :string      read GetUserBankName             write SetUserBankName          ;
    property Blank2                     :string      read GetBlank2                   write SetBlank2                ;
    property DirectEntryUserName        :string      read GetDirectEntryUserName      write SetDirectEntryUserName   ;
    property DirectEntryUserID          :string      read GetDirectEntryUserID        write SetDirectEntryUserID     ;
    property TransactionDescription     :string      read GetTransactionDescription   write SetTransactionDescription;
    property ProcessingDate             :TDateTime   read GetProcessingDate           write SetProcessingDate        ;
    property ProcessingIndicator        :Boolean     read GetProcessingIndicator      write SetProcessingIndicator   ;
    property Blank3                     :string      read GetBlank3                   write SetBlank3                ;
    property AccountID                  :Integer     read GetAccountID                write SetAccountID             ;
    property IncludeBalanceRecord       :Boolean     read GetIncludeBalanceRecord     write SetIncludeBalanceRecord  ;
    property IncludeNetTotal            :Boolean     read GetIncludeNetTotal          write SetIncludeNetTotal       ;
    property IncludeCreditTotal         :Boolean     read GetIncludeCreditTotal       write SetIncludeCreditTotal    ;
    property IncludeDebitTotal          :Boolean     read GetIncludeDebitTotal        write SetIncludeDebitTotal     ;
  end;
  TABATransactionDescriptions = class(TMSBusObj)
  private
    Function GetDescription    : string    ;
    Function GetActive         : Boolean   ;
    Procedure SetDescription    (const Value: string    );
    Procedure SetActive         (const Value: Boolean   );
  Protected
    Procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    Procedure DoFieldOnChange(Sender: TField);                           override;
    Function  GetSQL: string;                                            override;
    Function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
  Public
    class Function  GetIDField: string;                                  override;
    class function GetBusObjectTablename: string;                        Override;
    Constructor  Create(AOwner: TComponent);                             override;
    Destructor   Destroy;                                                override;
    Procedure    LoadFromXMLNode(const node: IXMLNode);                  override;
    Procedure    SaveToXMLNode(const node: IXMLNode);                    override;
    Function     ValidateData: Boolean ;                                 override;
    Function     Save: Boolean ;                                         override;
  Published
    property Description     :string      read GetDescription   write SetDescription;
    property Active          :Boolean     read GetActive        write SetActive     ;
  end;

implementation

uses
  CommonLib;






      {TABADetailRecord}

Constructor TABADetailRecord.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ABADetailRecord';
  fSQL := 'SELECT * FROM tblabadetailrecord';
end;


Destructor TABADetailRecord.Destroy;
begin
  inherited;
end;


Procedure TABADetailRecord.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'DescriptiveRecordID');
  SetPropertyFromNode(node,'RecordType');
  SetPropertyFromNode(node,'BSB');
  SetPropertyFromNode(node,'CreditDebitAccountNumber');
  SetPropertyFromNode(node,'Indicator');
  SetPropertyFromNode(node,'TransactionCode');
  SetPropertyFromNode(node,'Amount');
  SetPropertyFromNode(node,'AccountName');
  SetPropertyFromNode(node,'LodgementReferences');
  SetPropertyFromNode(node,'UsersBSB');
  SetPropertyFromNode(node,'UsersAccountNumber');
  SetPropertyFromNode(node,'NameofRemitter');
  SetPropertyFromNode(node,'AmountOfWithholdingTax');
  SetPropertyFromNode(node,'Apply');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'TransType');
  SetPropertyFromNode(node,'TransID');
  SetPropertyFromNode(node,'TransCodeDesc');
end;


Procedure TABADetailRecord.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DescriptiveRecordID' ,DescriptiveRecordID);
  AddXMLNode(node,'RecordType' ,RecordType);
  AddXMLNode(node,'BSB' ,BSB);
  AddXMLNode(node,'CreditDebitAccountNumber' ,CreditDebitAccountNumber);
  AddXMLNode(node,'Indicator' ,Indicator);
  AddXMLNode(node,'TransactionCode' ,TransactionCode);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'AccountName' ,AccountName);
  AddXMLNode(node,'LodgementReferences' ,LodgementReferences);
  AddXMLNode(node,'UsersBSB' ,UsersBSB);
  AddXMLNode(node,'UsersAccountNumber' ,UsersAccountNumber);
  AddXMLNode(node,'NameofRemitter' ,NameofRemitter);
  AddXMLNode(node,'AmountOfWithholdingTax' ,AmountOfWithholdingTax);
  AddXMLNode(node,'Apply' ,Apply);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'TransType' ,TransType);
  AddXMLNode(node,'TransID' ,TransID);
  AddXMLNode(node,'TransCodeDesc' ,TransCodeDesc);
end;


Function TABADetailRecord.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


Function TABADetailRecord.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


Procedure TABADetailRecord.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


Procedure TABADetailRecord.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


Function TABADetailRecord.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


Class Function TABADetailRecord.GetIDField: string;
begin
  Result := 'DetailRecordID'
end;
class function TABADetailRecord.GetBusObjectTablename: string;
begin
    Result:= 'tblabadetailrecord';
end;
Function TABADetailRecord.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
Function  TABADetailRecord.GetDescriptiveRecordID     : Integer   ; begin Result := GetIntegerField('DescriptiveRecordID');end;
Function  TABADetailRecord.GetRecordType              : String    ; begin Result := GetStringField('RecordType');end;
Function  TABADetailRecord.GetBSB                     : string    ; begin Result := GetStringField('BSB');end;
Function  TABADetailRecord.GetCreditDebitAccountNumber: string    ; begin Result := GetStringField('CreditDebitAccountNumber');end;
Function  TABADetailRecord.GetIndicator               : String    ; begin Result := GetStringField('Indicator');end;
Function  TABADetailRecord.GetTransactionCode         : string    ; begin Result := GetStringField('TransactionCode');end;
Function  TABADetailRecord.GetAmount                  : Double    ; begin Result := GetFloatField('Amount');end;
Function  TABADetailRecord.GetAccountName             : string    ; begin Result := GetStringField('AccountName');end;
Function  TABADetailRecord.GetLodgementReferences     : string    ; begin Result := GetStringField('LodgementReferences');end;
Function  TABADetailRecord.GetUsersBSB                : string    ; begin Result := GetStringField('UsersBSB');end;
Function  TABADetailRecord.GetUsersAccountNumber      : string    ; begin Result := GetStringField('UsersAccountNumber');end;
Function  TABADetailRecord.GetNameofRemitter          : string    ; begin Result := GetStringField('NameofRemitter');end;
Function  TABADetailRecord.GetAmountOfWithholdingTax  : string    ; begin Result := GetStringField('AmountOfWithholdingTax');end;
Function  TABADetailRecord.GetApply                   : Boolean   ; begin Result := GetBooleanField('Apply');end;
Function  TABADetailRecord.GetAccountID               : Integer   ; begin Result := GetIntegerField('AccountID');end;
Function  TABADetailRecord.GetTransType               : string    ; begin Result := GetStringField('TransType');end;
Function  TABADetailRecord.GetTransID                 : Integer   ; begin Result := GetIntegerField('TransID');end;
Function  TABADetailRecord.GetTransCodeDesc           : string    ; begin Result := GetStringField('TransCodeDesc');end;
Procedure TABADetailRecord.SetDescriptiveRecordID     (const Value: Integer   ); begin SetIntegerField('DescriptiveRecordID'      , Value);end;
Procedure TABADetailRecord.SetRecordType              (const Value: String    ); begin SetStringField('RecordType'               , Value);end;
Procedure TABADetailRecord.SetBSB                     (const Value: string    ); begin SetStringField('BSB'                      , Value);end;
Procedure TABADetailRecord.SetCreditDebitAccountNumber(const Value: string    ); begin SetStringField('CreditDebitAccountNumber'                      , Value);end;
Procedure TABADetailRecord.SetIndicator               (const Value: String    ); begin SetStringField('Indicator'                , Value);end;
Procedure TABADetailRecord.SetTransactionCode         (const Value: string    ); begin SetStringField('TransactionCode'          , Value);end;
Procedure TABADetailRecord.SetAmount                  (const Value: Double    ); begin SetFloatField('Amount'                   , Value);end;
Procedure TABADetailRecord.SetAccountName             (const Value: string    ); begin SetStringField('AccountName'              , Value);end;
Procedure TABADetailRecord.SetLodgementReferences     (const Value: string    ); begin SetStringField('LodgementReferences'      , Value);end;
Procedure TABADetailRecord.SetUsersBSB                (const Value: string    ); begin SetStringField('UsersBSB'                 , Value);end;
Procedure TABADetailRecord.SetUsersAccountNumber      (const Value: string    ); begin SetStringField('UsersAccountNumber'       , Value);end;
Procedure TABADetailRecord.SetNameofRemitter          (const Value: string    ); begin SetStringField('NameofRemitter'           , Value);end;
Procedure TABADetailRecord.SetAmountOfWithholdingTax  (const Value: string    ); begin SetStringField('AmountOfWithholdingTax'   , Value);end;
Procedure TABADetailRecord.SetApply                   (const Value: Boolean   ); begin SetBooleanField('Apply'                    , Value);end;
Procedure TABADetailRecord.SetAccountID               (const Value: Integer   ); begin SetIntegerField('AccountID'                , Value);end;
Procedure TABADetailRecord.SetTransType               (const Value: string    ); begin SetStringField('TransType'                , Value);end;
Procedure TABADetailRecord.SetTransID                 (const Value: Integer   ); begin SetIntegerField('TransID'                  , Value);end;
Procedure TABADetailRecord.SetTransCodeDesc           (const Value: string    ); begin SetStringField('TransCodeDesc'            , Value);end;


      {TABADescriptiveRecord}

Constructor TABADescriptiveRecord.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ABADescriptiveRecord';
  fSQL := 'SELECT * FROM tblabadescriptiverecord';
end;


Destructor TABADescriptiveRecord.Destroy;
begin
  inherited;
end;


Procedure TABADescriptiveRecord.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'RecordType');
  SetPropertyFromNode(node,'Blank1');
  SetPropertyFromNode(node,'ReelSequenceNumber');
  SetPropertyFromNode(node,'UserBankName');
  SetPropertyFromNode(node,'Blank2');
  SetPropertyFromNode(node,'DirectEntryUserName');
  SetPropertyFromNode(node,'DirectEntryUserID');
  SetPropertyFromNode(node,'TransactionDescription');
  SetPropertyFromNode(node,'ProcessingDate');
  SetPropertyFromNode(node,'ProcessingIndicator');
  SetPropertyFromNode(node,'Blank3');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'IncludeBalanceRecord');
  SetPropertyFromNode(node,'IncludeNetTotal');
  SetPropertyFromNode(node,'IncludeCreditTotal');
  SetPropertyFromNode(node,'IncludeDebitTotal');
end;


Procedure TABADescriptiveRecord.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'RecordType' ,RecordType);
  AddXMLNode(node,'Blank1' ,Blank1);
  AddXMLNode(node,'ReelSequenceNumber' ,ReelSequenceNumber);
  AddXMLNode(node,'UserBankName' ,UserBankName);
  AddXMLNode(node,'Blank2' ,Blank2);
  AddXMLNode(node,'DirectEntryUserName' ,DirectEntryUserName);
  AddXMLNode(node,'DirectEntryUserID' ,DirectEntryUserID);
  AddXMLNode(node,'TransactionDescription' ,TransactionDescription);
  AddXMLNode(node,'ProcessingDate' ,ProcessingDate);
  AddXMLNode(node,'ProcessingIndicator' ,ProcessingIndicator);
  AddXMLNode(node,'Blank3' ,Blank3);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'IncludeBalanceRecord' ,IncludeBalanceRecord);
  AddXMLNode(node,'IncludeNetTotal' ,IncludeNetTotal);
  AddXMLNode(node,'IncludeCreditTotal' ,IncludeCreditTotal);
  AddXMLNode(node,'IncludeDebitTotal' ,IncludeDebitTotal);
end;


Function TABADescriptiveRecord.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


Function TABADescriptiveRecord.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


Procedure TABADescriptiveRecord.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


Procedure TABADescriptiveRecord.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


Function TABADescriptiveRecord.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class Function TABADescriptiveRecord.GetIDField: string;
begin
  Result := 'DescriptiveRecordID'
end;
class function TABADescriptiveRecord.GetBusObjectTablename: string;
begin
    REsult := 'tblabadescriptiverecord';
end;

Function TABADescriptiveRecord.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
Function  TABADescriptiveRecord.GetRecordType            : String    ; begin Result := GetStringField('RecordType');end;
Function  TABADescriptiveRecord.GetBlank1                : string    ; begin Result := GetStringField('Blank1');end;
Function  TABADescriptiveRecord.GetReelSequenceNumber    : string    ; begin Result := GetStringField('ReelSequenceNumber');end;
Function  TABADescriptiveRecord.GetUserBankName          : string    ; begin Result := GetStringField('UserBankName');end;
Function  TABADescriptiveRecord.GetBlank2                : string    ; begin Result := GetStringField('Blank2');end;
Function  TABADescriptiveRecord.GetDirectEntryUserName   : string    ; begin Result := GetStringField('DirectEntryUserName');end;
Function  TABADescriptiveRecord.GetDirectEntryUserID     : string    ; begin Result := GetStringField('DirectEntryUserID');end;
Function  TABADescriptiveRecord.GetTransactionDescription: string    ; begin Result := GetStringField('TransactionDescription');end;
Function  TABADescriptiveRecord.GetProcessingDate        : TDateTime ; begin Result := GetDateTimeField('ProcessingDate');end;
Function  TABADescriptiveRecord.GetProcessingIndicator   : Boolean   ; begin Result := GetBooleanField('ProcessingIndicator');end;
Function  TABADescriptiveRecord.GetBlank3                : string    ; begin Result := GetStringField('Blank3');end;
Function  TABADescriptiveRecord.GetAccountID             : Integer   ; begin Result := GetIntegerField('AccountID');end;
Function  TABADescriptiveRecord.GetIncludeBalanceRecord  : Boolean   ; begin Result := GetBooleanField('IncludeBalanceRecord');end;
Function  TABADescriptiveRecord.GetIncludeNetTotal       : Boolean   ; begin Result := GetBooleanField('IncludeNetTotal');end;
Function  TABADescriptiveRecord.GetIncludeCreditTotal    : Boolean   ; begin Result := GetBooleanField('IncludeCreditTotal');end;
Function  TABADescriptiveRecord.GetIncludeDebitTotal     : Boolean   ; begin Result := GetBooleanField('IncludeDebitTotal');end;
Procedure TABADescriptiveRecord.SetRecordType            (const Value: String    ); begin SetStringField('RecordType'             , Value);end;
Procedure TABADescriptiveRecord.SetBlank1                (const Value: string    ); begin SetStringField('Blank1'                 , Value);end;
Procedure TABADescriptiveRecord.SetReelSequenceNumber    (const Value: string    ); begin SetStringField('ReelSequenceNumber'     , Value);end;
Procedure TABADescriptiveRecord.SetUserBankName          (const Value: string    ); begin SetStringField('UserBankName'           , Value);end;
Procedure TABADescriptiveRecord.SetBlank2                (const Value: string    ); begin SetStringField('Blank2'                 , Value);end;
Procedure TABADescriptiveRecord.SetDirectEntryUserName   (const Value: string    ); begin SetStringField('DirectEntryUserName'    , Value);end;
Procedure TABADescriptiveRecord.SetDirectEntryUserID     (const Value: string    ); begin SetStringField('DirectEntryUserID'      , Value);end;
Procedure TABADescriptiveRecord.SetTransactionDescription(const Value: string    ); begin SetStringField('TransactionDescription'      , Value);end;
Procedure TABADescriptiveRecord.SetProcessingDate        (const Value: TDateTime ); begin SetDateTimeField('ProcessingDate'         , Value);end;
Procedure TABADescriptiveRecord.SetProcessingIndicator   (const Value: Boolean   ); begin SetBooleanField('ProcessingIndicator'    , Value);end;
Procedure TABADescriptiveRecord.SetBlank3                (const Value: string    ); begin SetStringField('Blank3'                 , Value);end;
Procedure TABADescriptiveRecord.SetAccountID             (const Value: Integer   ); begin SetIntegerField('AccountID'              , Value);end;
Procedure TABADescriptiveRecord.SetIncludeBalanceRecord  (const Value: Boolean   ); begin SetBooleanField('IncludeBalanceRecord'   , Value);end;
Procedure TABADescriptiveRecord.SetIncludeNetTotal       (const Value: Boolean   ); begin SetBooleanField('IncludeNetTotal'        , Value);end;
Procedure TABADescriptiveRecord.SetIncludeCreditTotal    (const Value: Boolean   ); begin SetBooleanField('IncludeCreditTotal'     , Value);end;
Procedure TABADescriptiveRecord.SetIncludeDebitTotal     (const Value: Boolean   ); begin SetBooleanField('IncludeDebitTotal'      , Value);end;


      {TABATransactionDescriptions}
class function TABATransactionDescriptions.GetBusObjectTablename: string;
begin
    REsult:= 'tblabatransactiondescriptions';
end;
Constructor TABATransactionDescriptions.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ABATransactionDescriptions';
  fSQL := 'SELECT * FROM tblabatransactiondescriptions';
end;


Destructor TABATransactionDescriptions.Destroy;
begin
  inherited;
end;


Procedure TABATransactionDescriptions.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'Active');
end;


Procedure TABATransactionDescriptions.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'Active' ,Active);
end;


Function TABATransactionDescriptions.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


Function TABATransactionDescriptions.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


Procedure TABATransactionDescriptions.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


Procedure TABATransactionDescriptions.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


Function TABATransactionDescriptions.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class Function TABATransactionDescriptions.GetIDField: string;
begin
  Result := 'ID'
end;


Function TABATransactionDescriptions.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
Function  TABATransactionDescriptions.GetDescription: string    ; begin Result := GetStringField('Description');end;
Function  TABATransactionDescriptions.GetActive     : Boolean   ; begin Result := GetBooleanField('Active');end;
Procedure TABATransactionDescriptions.SetDescription(const Value: string    ); begin SetStringField( 'Description', Value);end;
Procedure TABATransactionDescriptions.SetActive     (const Value: Boolean   ); begin SetBooleanField('Active'      , Value);end;


initialization
  RegisterClassOnce(TABATransactionDescriptions);
  RegisterClassOnce(TABADescriptiveRecord);
  RegisterClassOnce(TABADetailRecord);
end.
