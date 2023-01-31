unit BusObjPaysTransactions;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  11/03/08  1.00.01  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tpaystransactions = class(TMSBusObj)
  private
    Function GetDate                  : TDateTime ;
    Function GetType                  : string    ;
    Function GetClassID               : Integer   ;
    Function GetPayID                 : Integer   ;
    Function GetAccountName           : string    ;
    Function GetAccountGroupLevels    : string    ;
    Function GetAccountID             : Integer   ;
    Function GetAccountType           : string    ;
    Function GetClientName            : string    ;
    Function GetClientID              : Integer   ;
    Function GetDescription           : string    ;
    Function GetEmployeeName          : string    ;
    Function GetEmployeeID            : Integer   ;
    Function GetAmount                : Double    ;
    Function GetActive                : Boolean   ;
    Function GetReconciled            : Boolean   ;
    Function GetPayLineID             : Integer   ;
    Function GetMSType                : string    ;
    Procedure SetDate                  (const Value: TDateTime );
    Procedure SetType                  (const Value: string    );
    Procedure setClassID               (const Value: Integer   );
    Procedure SetPayID                 (const Value: Integer   );
    Procedure SetAccountName           (const Value: string    );
    Procedure SetAccountGroupLevels    (const Value: string    );
    Procedure SetAccountID             (const Value: Integer   );
    Procedure SetAccountType           (const Value: string    );
    Procedure SetClientName            (const Value: string    );
    Procedure SetClientID              (const Value: Integer   );
    Procedure SetDescription           (const Value: string    );
    Procedure SetEmployeeName          (const Value: string    );
    Procedure SetEmployeeID            (const Value: Integer   );
    Procedure SetAmount                (const Value: Double    );
    Procedure SetActive                (const Value: Boolean   );
    Procedure SetReconciled            (const Value: Boolean   );
    Procedure SetPayLineID             (const Value: Integer   );
    Procedure SetMSType                (const Value: string    );
    function getSeqno: Integer;
    procedure setSeqno(const Value: Integer);
  Protected
    Procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    Function  GetSQL                             : string;              override;
    Function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    Function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function  getPostPayId:Integer ; virtual;
    Function  getPostDatepaid:TDateTime; virtual;
    Function  getPostemployeeId:Integer ; virtual;
    Function  getPostemployeeName:String ; virtual;
  Public
    Class Function  GetIDField                   : string;              override;
    Class Function  GetBusObjectTablename        : string;              override;
    Constructor  Create(AOwner: TComponent);                            override;
    Destructor   Destroy;                                               override;
    Procedure DoFieldOnChange(Sender: TField);                          override;
    Procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    Procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    Function     ValidateData: Boolean ;                                override;
    Function     Save: Boolean ;                                        override;
    procedure    PostToPaysTransactions(const sSeqno:Integer; const sTransType, sMS_TransType, sDescription: string;
                    const iCreditAccountID, iDebitAccountID, iClassID, iPayLineID: integer;
                    const dAmount: currency; Sender: TObject; iclientID:Integer=0);
    property PostPayId        : Integer   read getPostPayId;
    property PostDatepaid     : TDatetime read getPostDatepaid;
    property PostemployeeId   : Integer   read getPostemployeeId;
    property PostemployeeName : String    read getPostemployeeName;

  Published
    property Date                   :TDateTime   read GetDate                 write SetDate              ;
    property TypeDescription        :string      read GetType                 write SetType              ;
    property ClassID                :Integer     read GetClassID              write setClassID           ;
    property PayID                  :Integer     read GetPayID                write SetPayID             ;
    property AccountName            :string      read GetAccountName          write SetAccountName       ;
    property AccountGroupLevels     :string      read GetAccountGroupLevels   write SetAccountGroupLevels;
    property AccountID              :Integer     read GetAccountID            write SetAccountID         ;
    property AccountType            :string      read GetAccountType          write SetAccountType       ;
    property ClientName             :string      read GetClientName           write SetClientName        ;
    property ClientID               :Integer     read GetClientID             write SetClientID          ;
    property Description            :string      read GetDescription          write SetDescription       ;
    property EmployeeName           :string      read GetEmployeeName         write SetEmployeeName      ;
    property EmployeeID             :Integer     read GetEmployeeID           write SetEmployeeID        ;
    property Amount                 :Double      read GetAmount               write SetAmount            ;
    property Active                 :Boolean     read GetActive               write SetActive            ;
    property Reconciled             :Boolean     read GetReconciled           write SetReconciled        ;
    property PayLineID              :Integer     read GetPayLineID            write SetPayLineID         ;
    property MSType                 :string      read GetMSType               write SetMSType            ;
    Property Seqno                  :Integer     read getSeqno                write setSeqno             ;
  end;

implementation


uses tcDataUtils, CommonLib,BusObjPaybase, BusObjEmployeeDetails,DnMLib,tcTypes,
  BusObjGLAccount, sysutils;

      {Tpaystransactions}
Function Tpaystransactions.getPostPayId       :Integer  ; begin Result := tpaybase(Self.Owner).PayID                        ; end;
Function Tpaystransactions.getPostDatepaid    :TDateTime; begin Result := tpaybase(Self.Owner).Datepaid                     ; end;
Function Tpaystransactions.getPostemployeeId  :Integer  ; begin Result := tpaybase(Self.Owner).EmployeeDetails.Id           ; end;
Function Tpaystransactions.getPostemployeeName:String   ; begin Result := tpaybase(Self.Owner).EmployeeDetails.Employeename ; end;

Procedure Tpaystransactions.PostToPaysTransactions(const sSeqno:Integer; const sTransType, sMS_TransType, sDescription: string;
  const iCreditAccountID, iDebitAccountID, iClassID, iPayLineID: integer; const dAmount: currency; Sender: TObject; iclientID:Integer=0);
{ ****************************************************************************
  TransTypes Used - 'Payroll Accrued Leave'
                  - 'Payroll Leave Taken'
                  - 'Payroll Deductions'
                  - 'Payroll Allowance'
                  - 'Payroll Gross Wages'
                  - 'Payroll Commission'
                  - 'Payroll Superannuation'
                  - 'Payroll Sundries'
                  - 'Payroll Net Wages'
                  - 'Payroll PAYG'
                  - 'Payroll NICs'
                  - 'Payroll Job Burden'
  **************************************************************************** }
//var
//  sl: TStringList;
//  postNo: integer;
begin
  if dAmount = 0.00 then Exit;
//  sl:= TStringList.Create;
  try
//    if FileExists('PayAccountPostings.csv') then begin
//      sl.LoadFromFile('PayAccountPostings.csv');
//      if sl.Count > 1 then
//        postNo:= StrToInt(Copy(sl[sl.count-1],1,Pos(',',sl[sl.count-1])-1)) + 1
//      else
//        postNo:= 1;
//    end
//    else begin
//      sl.Add('No,Obj,TransType,MSTransType,Desc,AccountName,AccountType,CreditAmount,DebitAmount');
//      postNo:= 1;
//    end;
    if (iDebitAccountID <> 0) AND (iCreditAccountID <> 0) then begin
      if Self.Dataset.RecordCount = 0 Then begin
        New;
        Seqno           := sSeqno;
        PayID           := PostPayId;//tpaybase(Self.Owner).PayID;
        Date            := PostDatepaid;//tpaybase(Self.Owner).Datepaid;
        TypeDescription := sTransType;
        MSType          := sMS_TransType;
        AccountName     := tcDataUtils.GetAccountName(iDebitAccountID);
        AccountType     := DNMLib.GetAccountType(iDebitAccountID);
        AccountGroupLevels := GetAccountGroup(iDebitAccountID);
        AccountID       := iDebitAccountID;
        EmployeeID      := PostemployeeId; //tpaybase(Self.Owner).EmployeeDetails.Id ;
        EmployeeName    := PostemployeeName; //tpaybase(Self.Owner).EmployeeDetails.Employeename;
        Description     := sDescription;
        Amount          := -dAmount;
        ClassID         := iClassID;
        clientID        := iclientID;
        PayLineID       := iPayLineID;
        Self.PostDb;
        PostList.AddAmount(TAccount.ClassName, TAccount.GetBusObjectTablename,iDebitAccountID, dAmount,btNormal);

//        sl.Add(IntToStr(PostNo) + ',' + Sender.ClassName + ',' +
//          '"' + sTransType + '",' +
//          '"' + sMS_TransType + '",' +
//          '"' + sDescription + '",' +
//          '"' + AccountName + '",' +
//          '"' + AccountType + '",' +
//          '0,' +
//          FloatToStr(-dAmount));

        New;
        Seqno           := sSeqno;
        PayID           := PostPayId;//tpaybase(Self.Owner).PayID;
        Date            := PostDatepaid;//tpaybase(Self.Owner).Datepaid;
        TypeDescription := sTransType;
        MSType          := sMS_TransType;
        AccountName     := tcDataUtils.GetAccountName(iCreditAccountID);
        AccountType     := DNMLib.GetAccountType(iCreditAccountID);
        AccountGroupLevels := GetAccountGroup(iCreditAccountID);
        AccountID       := iCreditAccountID;
        EmployeeID      := PostemployeeId; //tpaybase(Self.Owner).EmployeeDetails.Id;
        EmployeeName    := PostemployeeName; //tpaybase(Self.Owner).EmployeeDetails.Employeename;
        Description     := sDescription;
        Amount          := dAmount;
        ClassID         := iClassID;
        clientID        := iclientID;
        PayLineID       := iPayLineID;
        Self.PostDb;
        PostList.AddAmount(TAccount.ClassName, TAccount.GetBusObjectTablename,
                                iCreditAccountID, dAmount,btNormal);

//        sl.Add(IntToStr(PostNo) + ',' + Sender.ClassName + ',' +
//          '"' + sTransType + '",' +
//          '"' + sMS_TransType + '",' +
//          '"' + sDescription + '",' +
//          '"' + AccountName + '",' +
//          '"' + AccountType + '",' +
//          FloatToStr(dAmount) + ',' +
//          '0');

      end else if Self.Dataset.RecordCount = 2 Then begin
        PayID           := PostPayId;//tpaybase(Self.Owner).PayID;
        Date            := PostDatepaid;//tpaybase(Self.Owner).Datepaid;
        TypeDescription := sTransType;
        MSType          := sMS_TransType;
        AccountName     := tcDataUtils.GetAccountName(iDebitAccountID);
        AccountType     := DNMLib.GetAccountType(iDebitAccountID);;
        AccountGroupLevels := GetAccountGroup(iDebitAccountID);
        AccountID       := iDebitAccountID;
        EmployeeID      := PostemployeeId; //tpaybase(Self.Owner).EmployeeDetails.Id;
        EmployeeName    := PostemployeeName;//tpaybase(Self.Owner).EmployeeDetails.Employeename;
        Description     := sDescription;
        Amount          := -dAmount;
        ClassID         := iClassID;
        ClientID        := iclientID;
        PayLineID       := iPayLineID;
        Self.PostDb;
        PostList.AddAmount(TAccount.ClassName, TAccount.GetBusObjectTablename,
                                iDebitAccountID, dAmount,btNormal);

//        sl.Add(IntToStr(PostNo) + ',' + Sender.ClassName + ',' +
//          '"' + sTransType + '",' +
//          '"' + sMS_TransType + '",' +
//          '"' + sDescription + '",' +
//          '"' + AccountName + '",' +
//          '"' + AccountType + '",' +
//          '0,' +
//          FloatToStr(-dAmount));

        Self.Dataset.Next;

        PayID           := PostPayId;//tpaybase(Self.Owner).PayID;
        Date            := PostDatepaid;//tpaybase(Self.Owner).Datepaid;
        TypeDescription := sTransType;
        MSType          := sMS_TransType;
        AccountName     := tcDataUtils.GetAccountName(iCreditAccountID);
        AccountType     := DNMLib.GetAccountType(iCreditAccountID);;
        AccountGroupLevels := GetAccountGroup(iCreditAccountID);
        AccountID       := iCreditAccountID;
        EmployeeID      := PostemployeeId; //tpaybase(Self.Owner).EmployeeDetails.Id;
        EmployeeName    := PostemployeeName; //tpaybase(Self.Owner).EmployeeDetails.Employeename;
        Description     := sDescription;
        Amount          := dAmount;
        ClassID         := iClassID;
        ClientID        := iclientID;
        PayLineID       := iPayLineID;
        Self.PostDb;
        PostList.AddAmount(TAccount.ClassName, TAccount.GetBusObjectTablename,
                                iCreditAccountID, dAmount,btNormal);

//        sl.Add(IntToStr(PostNo) + ',' + Sender.ClassName + ',' +
//          '"' + sTransType + '",' +
//          '"' + sMS_TransType + '",' +
//          '"' + sDescription + '",' +
//          '"' + AccountName + '",' +
//          '"' + AccountType + '",' +
//          FloatToStr(dAmount) + ',' +
//          '0');

      end;
    end;
  finally
//    sl.SaveToFile('PayAccountPostings.csv');
//    sl.Free;
  end;
end;

Constructor Tpaystransactions.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'paystransactions';
  fSQL := 'SELECT * FROM tblpaystransactions';
end;


Destructor Tpaystransactions.Destroy;
begin
  inherited;
end;


Procedure Tpaystransactions.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Date');
  SetPropertyFromNode(node,'Type');
  SetPropertyFromNode(node,'ClassID');
  SetPropertyFromNode(node,'Seqno');
  SetPropertyFromNode(node,'PayID');
  SetPropertyFromNode(node,'AccountName');
  SetPropertyFromNode(node,'AccountGroupLevels');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'AccountType');
  SetPropertyFromNode(node,'ClientName');
  SetPropertyFromNode(node,'ClientID');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'EmployeeName');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'Amount');
  SetPropertyFromNode(node,'Active');
  SetPropertyFromNode(node,'Reconciled');
  SetPropertyFromNode(node,'PayLineID');
  SetPropertyFromNode(node,'MSType');
end;


Procedure Tpaystransactions.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Date' ,Date);
  AddXMLNode(node,'TypeDescription' ,TypeDescription);
  AddXMLNode(node,'ClassID' ,ClassID);
  AddXMLNode(node,'PayID' ,PayID);
  AddXMLNode(node,'Seqno' ,Seqno);
  AddXMLNode(node,'AccountName' ,AccountName);
  AddXMLNode(node,'AccountGroupLevels' ,AccountGroupLevels);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'AccountType' ,AccountType);
  AddXMLNode(node,'ClientName' ,ClientName);
  AddXMLNode(node,'ClientID' ,ClientID);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'Reconciled' ,Reconciled);
  AddXMLNode(node,'PayLineID' ,PayLineID);
  AddXMLNode(node,'MSType' ,MSType);
end;


Function Tpaystransactions.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if Date = 0 then begin
    AddResult(False , rssError , 0,  'Date should not be blank' , False );
    Exit;
  end;
  if ClassID = 0 then begin
    AddResult(False , rssError , 0,  'ClassID should not be 0' , False );
    Exit;
  end;
  if PayID = 0 then begin
    AddResult(False , rssError , 0,  'PayID should not be 0' , False );
    Exit;
  end;
  if AccountID = 0 then begin
    AddResult(False , rssError , 0,  'AccountID should not be 0' , False );
    Exit;
  end;
  if ClientID = 0 then begin
    AddResult(False , rssError , 0,  'ClientID should not be 0' , False );
    Exit;
  end;
  if EmployeeID = 0 then begin
    AddResult(False , rssError , 0,  'EmployeeID should not be 0' , False );
    Exit;
  end;
  if Amount = 0 then begin
    AddResult(False , rssError , 0,  'Amount should not be 0' , False );
    Exit;
  end;
  if PayLineID = 0 then begin
    AddResult(False , rssError , 0,  'PayLineID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


Function Tpaystransactions.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


Procedure Tpaystransactions.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


Procedure Tpaystransactions.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


Function Tpaystransactions.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


Class Function Tpaystransactions.GetIDField: string;
begin
  Result := 'TransID'
end;


Class Function Tpaystransactions.GetBusObjectTablename: string;
begin
  Result:= 'tblpaystransactions';
end;


function Tpaystransactions.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
end;

Function Tpaystransactions.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
Function  Tpaystransactions.GetDate              : TDateTime ; begin Result := GetDateTimeField('Date');end;
Function  Tpaystransactions.GetType              : string    ; begin Result := GetStringField('Type');end;
Function  Tpaystransactions.GetClassID           : Integer   ; begin Result := GetIntegerField('ClassID');end;
Function  Tpaystransactions.GetPayID             : Integer   ; begin Result := GetIntegerField('PayID');end;
Function  Tpaystransactions.GetAccountName       : string    ; begin Result := GetStringField('AccountName');end;
Function  Tpaystransactions.GetAccountGroupLevels: string    ; begin Result := GetStringField('AccountGroupLevels');end;
Function  Tpaystransactions.GetAccountID         : Integer   ; begin Result := GetIntegerField('AccountID');end;
Function  Tpaystransactions.GetAccountType       : string    ; begin Result := GetStringField('AccountType');end;
Function  Tpaystransactions.GetClientName        : string    ; begin Result := GetStringField('ClientName');end;
Function  Tpaystransactions.GetClientID          : Integer   ; begin Result := GetIntegerField('ClientID');end;
Function  Tpaystransactions.GetDescription       : string    ; begin Result := GetStringField('Description');end;
Function  Tpaystransactions.GetEmployeeName      : string    ; begin Result := GetStringField('EmployeeName');end;
Function  Tpaystransactions.GetEmployeeID        : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
Function  Tpaystransactions.GetAmount            : Double    ; begin Result := GetFloatField('Amount');end;
Function  Tpaystransactions.GetActive            : Boolean   ; begin Result := GetBooleanField('Active');end;
Function  Tpaystransactions.GetReconciled        : Boolean   ; begin Result := GetBooleanField('Reconciled');end;
function Tpaystransactions.getSeqno: Integer;
begin
  REsult := getIntegerField('Seqno');
end;

Function  Tpaystransactions.GetPayLineID         : Integer   ; begin Result := GetIntegerField('PayLineID');end;
Function  Tpaystransactions.GetMSType            : string    ; begin Result := GetStringField('MSType');end;
Procedure Tpaystransactions.SetDate              (const Value: TDateTime ); begin SetDateTimeField('Date'               , Value);end;
Procedure Tpaystransactions.SetType              (const Value: string    ); begin SetStringField('Type'               , Value);end;
Procedure Tpaystransactions.setClassID           (const Value: Integer   ); begin SetIntegerField('ClassID'            , Value);end;
Procedure Tpaystransactions.SetPayID             (const Value: Integer   ); begin SetIntegerField('PayID'              , Value);end;
Procedure Tpaystransactions.SetAccountName       (const Value: string    ); begin SetStringField('AccountName'        , Value);end;
Procedure Tpaystransactions.SetAccountGroupLevels(const Value: string    ); begin SetStringField('AccountGroupLevels'        , Value);end;
Procedure Tpaystransactions.SetAccountID         (const Value: Integer   ); begin SetIntegerField('AccountID'          , Value);end;
Procedure Tpaystransactions.SetAccountType       (const Value: string    ); begin SetStringField('AccountType'        , Value);end;
Procedure Tpaystransactions.SetClientName        (const Value: string    ); begin SetStringField('ClientName'         , Value);end;
Procedure Tpaystransactions.SetClientID          (const Value: Integer   ); begin SetIntegerField('ClientID'           , Value);end;
Procedure Tpaystransactions.SetDescription       (const Value: string    ); begin SetStringField('Description'        , Value);end;
Procedure Tpaystransactions.SetEmployeeName      (const Value: string    ); begin SetStringField('EmployeeName'       , Value);end;
Procedure Tpaystransactions.SetEmployeeID        (const Value: Integer   ); begin SetIntegerField('EmployeeID'         , Value);end;
Procedure Tpaystransactions.SetAmount            (const Value: Double    ); begin SetFloatField('Amount'             , Value);end;
Procedure Tpaystransactions.SetActive            (const Value: Boolean   ); begin SetBooleanField('Active'             , Value);end;
Procedure Tpaystransactions.SetReconciled        (const Value: Boolean   ); begin SetBooleanField('Reconciled'         , Value);end;
procedure Tpaystransactions.setSeqno(const Value: Integer);
begin
  SetIntegerField('Seqno' , Value);
end;

Procedure Tpaystransactions.SetPayLineID         (const Value: Integer   ); begin SetIntegerField('PayLineID'          , Value);end;
Procedure Tpaystransactions.SetMSType            (const Value: string    ); begin SetStringField('MSType'             , Value);end;



initialization
  RegisterClassOnce(Tpaystransactions);
end.
