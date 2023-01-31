unit BusObjEmployeePaySettings;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   30/05/07   1.00.01   A.   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjEmployeeDetails;


type
   TEmployeepaysettings = class(TMSBusObj)

   private
      Function GetEmployeeid                :Integer   ;
      Function GetUktaxcode                 :String    ;
      Function GetUknino                    :String   ;
      Function GetAbn                       :Integer   ;
      Function GetSTPTier                   :Integer   ;
      Function GetSTPTierDesc               :String;
      Function GetSTPTierAmount(aPayDate:TDatetime):Double;
      Function GetSTPJobkeeperStartFN       :String;
      Function GetSTPJobkeeperStartFNDesc   :String;
      Function GetSTPJobkeeperStartDateDesc :String;
      Function GetSTPJobkeeperFinishFN      :String;
      Function GetSTPJobkeeperFinishFNDesc  :String;
      Function GetSTPJobkeeperFinishDateDesc:String;
      Function GetPayperiod                 :String    ;
      Function GetEmployeepaynotes          :String    ;
      Function GetIsontheroster             :Boolean   ;
      Function GetFirstPayDate              :TDatetime ;
      Function GetLastPaid                  :TDatetime ;
      Function GetDateLastActuallyPaid      :TDatetime ;

      Function GetNICTableLetter            :String   ;
      Function GetIsDirector                :Boolean   ;
      Function GetIsMarriedWoman            :Boolean   ;
      Function GetIsContractedOut           :Boolean   ;
      Function GetPayPeriodDays             :Double;
      Function GetNonWageIncome             :Double;


      function GetEmployeeDetails: TEmployeeDetails;


      Procedure SetEmployeeid                (Const Value :Integer   );
      Procedure SetUktaxcode                 (Const Value :String    );
      Procedure SetUknino                    (Const Value :String   );
      Procedure SetAbn                       (Const Value :Integer   );
      Procedure SetSTPTier                   (Const Value :Integer   );
      Procedure SetSTPJobkeeperStartFN       (Const Value :String);
      Procedure SetSTPJobkeeperFinishFN      (Const Value :String);
      Procedure SetPayperiod                 (Const Value :String    );
      Procedure SetEmployeepaynotes          (Const Value :String    );
      Procedure SetIsontheroster             (Const Value :Boolean   );
      Procedure SetFirstPayDate              (Const Value :TDatetime );
      Procedure SetLastPaid                  (Const Value :TDatetime );
      Procedure SetDateLastActuallyPaid      (Const Value :TDatetime );

      Procedure SetNICTableLetter            (Const Value :String );
      Procedure SetIsDirector                (Const Value :Boolean );
      Procedure SetIsMarriedWoman            (Const Value :Boolean );
      Procedure SetIsContractedOut           (Const Value :Boolean );
      Procedure SetNonWageIncome             (Const Value :Double );
      Procedure SetStatement                 (Const Value :string );
      Procedure SetBankAccountNo             (Const Value :string );
      Procedure SetBankAccountName           (Const Value :string );
      Procedure SetBankAccountBSB            (Const Value :string );

      function GetAnnualSalary: Double;
      function GetEarningYTD: Double;
      function GetNextPayDate: TDateTime;

      function GetStatement: String;
      function GetBankAccountName: String;
      function GetBankAccountNo: String;
      function GetBankAccountBSB: String;

   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;

   Public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;

      Property STPTierAmount[aPayDate:TDatetime]:Double read getSTPTierAmount;

   Published

      Property Employeeid                 :Integer      Read getEmployeeid              Write SetEmployeeid          ;
      Property Uktaxcode                  :String       Read getUktaxcode               Write SetUktaxcode           ;
      Property Uknino                     :String       Read getUknino                  Write SetUknino              ;
      Property Abn                        :Integer      Read getAbn                     Write SetAbn                 ;
      Property STPTier                    :Integer      Read getSTPTier                  Write SetSTPTier            ;
      Property STPTierDesc                :String       read getSTPTierDesc;
      Property STPJobkeeperStartFN        :String       Read getSTPJobkeeperStartFN     Write SetSTPJobkeeperStartFN ;
      Property STPJobkeeperStartFNDesc    :String       Read getSTPJobkeeperStartFNDesc;
      Property STPJobkeeperStartDateDesc  :String       Read getSTPJobkeeperStartDateDesc;
      Property STPJobkeeperFinishFN       :String       Read getSTPJobkeeperFinishFN    Write SetSTPJobkeeperFinishFN ;
      Property STPJobkeeperFinishFNDesc   :String       Read getSTPJobkeeperFinishFNDesc;
      Property STPJobkeeperFinishDateDesc :String       Read getSTPJobkeeperFinishDateDesc;
      Property Payperiod                  :String       Read getPayperiod               Write SetPayperiod           ;
      Property Employeepaynotes           :String       Read getEmployeepaynotes        Write SetEmployeepaynotes    ;
      Property Isontheroster              :Boolean      Read getIsontheroster           Write SetIsontheroster       ;
      Property FirstPayDate               :TDatetime    Read getFirstPayDate            Write SetFirstPayDate        ;
      Property LastPaid                   :TDatetime    Read getLastPaid                Write SetLastPaid            ;
      Property DateLastActuallyPaid       :TDatetime    Read getDateLastActuallyPaid    Write SetDateLastActuallyPaid            ;
      Property PayPeriodInDays            :double       Read GetPayPeriodDays;
      Property NonWageIncome              :Double       Read GetNonWageIncome           Write SetNonWageIncome;   // Wang 2021-09-23

      Property NICTableLetter             :String       Read getNICTableLetter          Write SetNICTableLetter       ;
      Property IsDirector                 :Boolean      Read getIsDirector              Write SetIsDirector       ;
      Property IsMarriedWoman             :Boolean      Read getIsMarriedWoman          Write SetIsMarriedWoman       ;
      Property IsContractedOut            :Boolean      Read getIsContractedOut         Write SetIsContractedOut       ;

      property Employee: TEmployeeDetails read GetEmployeeDetails;

      property AnnualSalary: Double read GetAnnualSalary;
      property EarningYTD: Double read GetEarningYTD;
      property NextPayDate: TDateTime read GetNextPayDate;

      property Statement                  :String       read GetStatement               write SetStatement;
      property BankAccountName            :String       read GetBankAccountNo           write SetBankAccountNo;
      property BankAccountNo              :String       read GetBankAccountName         write SetBankAccountName;
      property BankAccountBSB             :String       read GetBankAccountBSB          write SetBankAccountBSB;
   End;

TSTPJobKeeperPaymentPhases = class(TMSBusObj)
  private
    function GetPhaseNo             : Integer   ;
    function GetDateFrom            : TDateTime ;
    function GetDateTo              : TDateTime ;
    function GetTier1Rate           : Double    ;
    function GetTier2Rate           : Double    ;
    procedure SetPhaseNo             (const Value: Integer   );
    procedure SetDateFrom            (const Value: TDateTime );
    procedure SetDateTo              (const Value: TDateTime );
    procedure SetTier1Rate           (const Value: Double    );
    procedure SetTier2Rate           (const Value: Double    );

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
    Class Function Ratefor(AOwner:TComponent;aSTPTier:Integer; aDate :TDate):Double;

  published
    property PhaseNo              :Integer     read GetPhaseNo            write SetPhaseNo         ;
    property DateFrom             :TDateTime   read GetDateFrom           write SetDateFrom        ;
    property DateTo               :TDateTime   read GetDateTo             write SetDateTo          ;
    property Tier1Rate            :Double      read GetTier1Rate          write SetTier1Rate       ;
    property Tier2Rate            :Double      read GetTier2Rate          write SetTier2Rate       ;
  end;


  TSTPJobKeeperFNList = class(TMSBusObj)
  private
    function GetFN                                 : string    ;
    function GetDateFrom                           : TDateTime ;
    function GetDateto                             : TDateTime ;
    function GetOtherAllowanceStartDescription     : string    ;
    function GetOtherAllowanceFinishDescription    : string    ;
    procedure SetFN                                 (const Value: string    );
    procedure SetDateFrom                           (const Value: TDateTime );
    procedure SetDateto                             (const Value: TDateTime );
    procedure SetOtherAllowanceStartDescription     (const Value: string    );
    procedure SetOtherAllowanceFinishDescription    (const Value: string    );

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
    Class Function StartDateDescForFn(AOwner: TComponent ;aFN:String):String;
    Class Function FinishDateDescForFn(AOwner: TComponent ;aFN:String):String;

  published
    property FN                                  :string      read GetFN                                write SetFN                             ;
    property DateFrom                            :TDateTime   read GetDateFrom                          write SetDateFrom                       ;
    property Dateto                              :TDateTime   read GetDateto                            write SetDateto                         ;
    property OtherAllowanceStartDescription      :string      read GetOtherAllowanceStartDescription    write SetOtherAllowanceStartDescription ;
    property OtherAllowanceFinishDescription     :string      read GetOtherAllowanceFinishDescription   write SetOtherAllowanceFinishDescription;
  end;


implementation


uses BusObjConst,BusObjEmployeePay,CommonLib, sysutils, MySQLConst;


{========================================================
         TEmployeepaysettings
========================================================}


constructor TEmployeepaysettings.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   NullWhenDateIs0 := True;
   fSQL := 'SELECT * FROM tblemployeepaysettings';

(*   FSQL :=
     ' SELECT * FROM tblemployeepaysettings P ' +
     ' LEFT JOIN ' +
     ' ( ' +
     '   SELECT EmployeeID, IFNULL(Statement, PaymentNo) Statement, BankAccountName, BankAccountNo, BankAccountBSB ' +
     '   FROM tbldeposits ' +
     '   WHERE PaymentID IN ' +
     '     ( ' +
     '       SELECT MAX(PaymentID) ' +
     '       FROM tbldeposits ' +
     '       WHERE IF(TRIM(BankAccountName) = '''', NULL, BankAccountName) IS NOT NULL ' +
     '         AND IF(TRIM(BankAccountNo) = '''', NULL, BankAccountNo) IS NOT NULL ' +
     '         AND IF(TRIM(BankAccountBSB) = '''', NULL, BankAccountBSB) IS NOT NULL ' +
     '       GROUP BY EmployeeID ' +
     '     ) ' +
     ' ) B USING (EmployeeID) WHERE (1 = 1) ';*)
end;


destructor TEmployeepaysettings.Destroy;
begin
   inherited;
end;

Function  TEmployeepaysettings.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin

    Result := inherited DoAfterInsert(Sender);
    if not result then exit;
    if Assigned(Self.Owner) then
        if Self.Owner is TEmployeePay then  begin
          EmployeeId := Temployeepay(Self.Owner).EmployeeDetails.id;
        end;
    DateLastActuallyPaid:= 0;
end;

Function TEmployeepaysettings.GetPayPeriodDays:double;
begin
  if Payperiod = 'Weekly' then Result := 7
  else if Payperiod = 'Fortnightly' then Result := 14
  else if Payperiod = 'Bi-monthly' then Result := 30.4375 / 2
  else if Payperiod = 'Monthly' then Result := 30.4375     //averaged over 4 year span.
  else Result := 7;
end;

procedure   TEmployeepaysettings.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node, 'Employeeid');
  SetPropertyFromNode(Node, 'Uktaxcode');
  SetPropertyFromNode(Node, 'Uknino');
  SetPropertyFromNode(Node, 'Abn');
  SetPropertyFromNode(Node, 'STPTier');
  SetPropertyFromNode(Node, 'STPJobkeeperStartFN');
  SetPropertyFromNode(Node, 'STPJobkeeperFinishFN');
  SetPropertyFromNode(Node, 'Payperiod');
  SetPropertyFromNode(Node, 'Employeepaynotes');
  SetBooleanPropertyFromNode(Node, 'Isontheroster');
  SetDateTimePropertyFromNode(Node, 'FirstPayDate');
  SetDateTimePropertyFromNode(Node, 'LastPaid');
  SetDateTimePropertyFromNode(Node, 'DateLastActuallyPaid');

  SetPropertyFromNode(Node, 'NICTableLetter');
  SetBooleanPropertyFromNode(Node, 'IsDirector');
  SetBooleanPropertyFromNode(Node, 'IsMarriedWoman');
  SetBooleanPropertyFromNode(Node, 'IsContractedOut');

  SetPropertyFromNode(Node, 'Statement');
  SetPropertyFromNode(Node, 'BankAccountName');
  SetPropertyFromNode(Node, 'BankAccountNo');
  SetPropertyFromNode(Node, 'BankAccountBSB');
end;


procedure   TEmployeepaysettings.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Employeeid', Employeeid);
  AddXMLNode(node, 'Uktaxcode', Uktaxcode);
  AddXMLNode(node, 'Uknino', Uknino);
  AddXMLNode(node, 'Abn', Abn);
  AddXMLNode(node, 'STPTier', STPTier);
  AddXMLNode(node, 'STPJobkeeperStartFN', STPJobkeeperStartFN);
  AddXMLNode(node, 'STPJobkeeperFinishFN', STPJobkeeperFinishFN);
  AddXMLNode(node, 'Payperiod', Payperiod);
  AddXMLNode(node, 'Employeepaynotes', Employeepaynotes);
  AddXMLNode(node, 'Isontheroster', Isontheroster);
  AddXMLNode(node, 'FirstPayDate', FirstPayDate);
  AddXMLNode(node, 'LastPaid', LastPaid);
  AddXMLNode(node, 'DateLastActuallyPaid', DateLastActuallyPaid);
  AddXMLNode(node, 'NICTableLetter', NICTableLetter);
  AddXMLNode(node, 'IsDirector', IsDirector);
  AddXMLNode(node, 'IsMarriedWoman', IsMarriedWoman);
  AddXMLNode(node, 'IsContractedOut', IsContractedOut);

  AddXMLNode(node, 'Statement', Statement);
  AddXMLNode(node, 'BankAccountName', BankAccountName);
  AddXMLNode(node, 'BankAccountNo', BankAccountNo);
  AddXMLNode(node, 'BankAccountBSB', BankAccountBSB);
end;

function TEmployeepaysettings.ValidateData :Boolean ;
//var
//  tmpResultStatus: TResultStatusItem;
begin
   Result := False;
   Resultstatus.Clear;
   if Self.Dataset.RecordCount = 0 then Result := True; //don't force a payset up at this stage

   Try
     if Payperiod = '' then begin
        AddResult(False , rssError , BOR_EmployeePay_Err_NoPayPeriod,  'Pay period should not be blank');
        SendEvent(IntToStr(BOR_EmployeePay_Err_NoPayPeriod),BusobjEventVal_FailedPay_DetailsValidateData);
        Exit;
     end;
     if FirstPayDate = 0 then begin
        AddResult(False , rssError , BOR_EmployeePay_Err_EmpNoFirstPayDate,  'First Pay Date should not be blank');
        SendEvent(IntToStr(BOR_EmployeePay_Err_EmpNoFirstPayDate),BusobjEventVal_FailedPay_DetailsValidateData);
        Exit;
     end;
     Result := true;
   Finally
//    If not Result then Begin
//      tmpResultStatus := ResultStatus.GetLastStatusItem;
//      if Assigned(tmpResultStatus) then
//        TBusobj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code),BusobjEventVal_FailedPay_DetailsValidateData);
//    end;
   end;
end;


function    TEmployeepaysettings.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
   PostDb;
end;


procedure TEmployeepaysettings.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TEmployeepaysettings.DoFieldOnChange(Sender: TField);
begin
   inherited;
//   if Sysutils.SameText(Sender.FieldName , 'Payperiod') then Self.PostDb;
end;



Function TEmployeepaysettings.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  TEmployeepaysettings.GetIDField : String;
begin
   Result := 'Employeepaysettingid'
end;

class function TEmployeepaysettings.GetBusObjectTablename: string;
begin
  Result := 'tblemployeepaysettings';
end;

Function  TEmployeepaysettings.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;

{Property functions}
Function  TEmployeepaysettings.GetEmployeeid          :Integer   ; begin Result := GetIntegerField('EmployeeID');End;
Function  TEmployeepaysettings.GetUktaxcode           :String    ; begin Result := GetStringField('UKTaxcode');End;
Function  TEmployeepaysettings.GetUknino              :String    ; begin Result := GetStringField('UKNINO');End;
Function  TEmployeepaysettings.GetAbn                 :Integer   ; begin Result := GetIntegerField('ABN');End;
Function  TEmployeepaysettings.GetSTPTier             :Integer   ; begin Result := GetIntegerField('STPTier');End;
Function  TEmployeepaysettings.GetSTPJobkeeperStartFN :String    ; begin Result := GetStringField('STPJobkeeperStartFN');End;
Function  TEmployeepaysettings.GetSTPJobkeeperFinishFN:String    ; begin Result := GetStringField('STPJobkeeperFinishFN');End;
Function  TEmployeepaysettings.GetPayperiod           :String    ; begin Result := GetStringField('PayPeriod');End;
Function  TEmployeepaysettings.GetEmployeepaynotes    :String    ; begin Result := GetStringField('EmployeePayNotes');End;
Function  TEmployeepaysettings.GetIsontheroster       :Boolean   ; begin Result := GetBooleanField('IsOnTheRoster');End;
Function  TEmployeepaysettings.GetFirstPayDate        :TDatetime ; begin Result := GetDatetimeField('FirstPayDate');End;
Function  TEmployeepaysettings.GetLastPaid            :TDatetime ; begin Result := GetDatetimeField('LastPaid');End;
Function  TEmployeepaysettings.GetDateLastActuallyPaid :TDatetime ; begin Result := GetDatetimeField('DateLastActuallyPaid');End;
Function  TEmployeepaysettings.GetNICTableLetter      :String    ; begin Result := GetStringField('NICTableLetter');End;
Function  TEmployeepaysettings.GetIsDirector          :Boolean   ; begin Result := GetBooleanField('IsDirector');End;
Function  TEmployeepaysettings.GetIsMarriedWoman      :Boolean   ; begin Result := GetBooleanField('IsMarriedWoman');End;
Function  TEmployeepaysettings.GetIsContractedOut     :Boolean   ; begin Result := GetBooleanField('IsContractedOut');End;
Function  TEmployeepaysettings.GetNonWageIncome       :Double    ; begin Result := GetFloatField('NonWageIncome');End;
function TEmployeepaysettings.GetStatement            :String    ; begin Result := GetStringField('Statement');end;
function TEmployeepaysettings.GetBankAccountNo        :String    ; begin Result := GetStringField('AccountNo');end;
function TEmployeepaysettings.GetBankAccountName      :String    ; begin Result := GetStringField('AccountName');end;
function TEmployeepaysettings.GetBankAccountBSB       :String    ; begin Result := GetStringField('AccountBSB');end;

function TEmployeepaysettings.GetEmployeeDetails: TEmployeeDetails;
begin

   result := TEmployeeDetails(GetContainerComponent(TEmployeeDetails, 'EmployeeID = ' + IntToStr(EmployeeID)));

end;



Function  TEmployeepaysettings.GetSTPJobkeeperStartFNDesc :String    ;
begin
  With TSTPJobKeeperFNList.Create(Self.Owner) do try
    Connection := Self.Connection;
    LoadSelect('FN='+quotedstr(STPJobkeeperStartFN));
    Result := OtherAllowanceStartDescription;
  finally
    Free;
  end;
end;
Function  TEmployeepaysettings.GetSTPJobkeeperStartDateDesc :String    ;
begin
  With TSTPJobKeeperFNList.Create(Self.Owner) do try
    Connection := Self.Connection;
    LoadSelect('FN='+quotedstr(STPJobkeeperStartFN));
    Result := FormatDateTime(ShortDateFormat, DateFrom)+' - ' + FormatDateTime(ShortDateFormat, DateTo);
  finally
    Free;
  end;
end;
function TEmployeepaysettings.GetSTPTierDesc: String;
begin
       if STPTier =1 then result := 'JK-TIER1'
  else if STPTier =2 then result := 'JK-TIER2'
  else Result := '';
end;
function TEmployeepaysettings.GetSTPTierAmount(aPayDate:TDatetime): Double;
begin
      Result := TSTPJobKeeperPaymentPhases.Ratefor(Owner,STPTier,aPaydate);
end;
Function  TEmployeepaysettings.GetSTPJobkeeperFinishFNDesc :String    ;
begin
  With TSTPJobKeeperFNList.Create(Self.Owner) do try
    Connection := Self.Connection;
    LoadSelect('FN='+quotedstr(STPJobkeeperFinishFN));
    Result := OtherAllowanceFinishDescription;
  finally
    Free;
  end;
end;
Function  TEmployeepaysettings.GetSTPJobkeeperFinishDateDesc :String    ;
begin
  With TSTPJobKeeperFNList.Create(Self.Owner) do try
    Connection := Self.Connection;
    LoadSelect('FN='+quotedstr(STPJobkeeperFinishFN));
    Result := FormatDateTime(ShortDateFormat, DateFrom)+' - ' + FormatDateTime(ShortDateFormat, DateTo);
  finally
    Free;
  end;
end;


Procedure TEmployeepaysettings.SetEmployeeid          (Const Value :Integer   ); begin SetIntegerField('EmployeeID'           , Value);End;
Procedure TEmployeepaysettings.SetUktaxcode           (Const Value :String    ); begin SetStringField('UKTaxcode'            , Value);End;
Procedure TEmployeepaysettings.SetUknino              (Const Value :String   ); begin SetStringField('UKNINO'               , Value);End;
Procedure TEmployeepaysettings.SetAbn                 (Const Value :Integer   ); begin SetIntegerField('ABN'                  , Value);End;
Procedure TEmployeepaysettings.SetSTPTier             (Const Value :Integer   ); begin SetIntegerField('STPTier'                  , Value);End;
Procedure TEmployeepaysettings.SetSTPJobkeeperStartFN (Const Value :String    ); begin SetStringField('STPJobkeeperStartFN'                  , Value);End;
Procedure TEmployeepaysettings.SetSTPJobkeeperFinishFN(Const Value :String    ); begin SetStringField('STPJobkeeperFinishFN'                  , Value);End;
Procedure TEmployeepaysettings.SetPayperiod           (Const Value :String    ); begin SetStringField('PayPeriod'            , Value);End;
Procedure TEmployeepaysettings.SetEmployeepaynotes    (Const Value :String    ); begin SetStringField('EmployeePayNotes'     , Value);End;
Procedure TEmployeepaysettings.SetIsontheroster       (Const Value :Boolean   ); begin SetBooleanField('IsOnTheRoster'        , Value);End;
Procedure TEmployeepaysettings.SetFirstPayDate        (Const Value :TDatetime ); begin SetDatetimeField('FirstPayDate'          , Value);End;
Procedure TEmployeepaysettings.SetLastPaid            (Const Value :TDatetime ); begin SetDatetimeField('LastPaid'         , Value);End;
Procedure TEmployeepaysettings.SetDateLastActuallyPaid (Const Value :TDatetime ); begin SetDatetimeField('DateLastActuallyPaid'  , Value);End;


Procedure TEmployeepaysettings.SetNICTableLetter      (Const Value :String    ); begin SetStringField('NICTableLetter'            , Value);End;
Procedure TEmployeepaysettings.SetIsDirector          (Const Value :Boolean   ); begin SetBooleanField('IsDirector'        , Value);End;
Procedure TEmployeepaysettings.SetIsMarriedWoman      (Const Value :Boolean   ); begin SetBooleanField('IsMarriedWoman'        , Value);End;
Procedure TEmployeepaysettings.SetIsContractedOut     (Const Value :Boolean   ); begin SetBooleanField('IsContractedOut'        , Value);End;
Procedure TEmployeepaysettings.SetNonWageIncome       (Const Value :Double    ); begin SetFloatField('NonWageIncome', Value);End;
Procedure TEmployeepaysettings.SetStatement           (Const Value :String    ); begin SetStringField('Statement', Value);End;
Procedure TEmployeepaysettings.SetBankAccountNo       (Const Value :String    ); begin SetStringField('AccountNo', Value);End;
Procedure TEmployeepaysettings.SetBankAccountName     (Const Value :String    ); begin SetStringField('AccountName', Value);End;
Procedure TEmployeepaysettings.SetBankAccountBSB      (Const Value :String    ); begin SetStringField('AccountBSB', Value);End;

function TEmployeepaysettings.GetAnnualSalary: Double;
begin
  Result := 0.0;
end;

function TEmployeepaysettings.GetEarningYTD: Double;
begin
  Result := 0.0;
end;

function TEmployeepaysettings.GetNextPayDate: TDateTime;
begin
  Result := GetLastPaid + GetPayPeriodDays;
end;


  {TSTPJobKeeperPaymentPhases}

constructor TSTPJobKeeperPaymentPhases.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'stpjobkeeperpaymentphases';
  fSQL := 'SELECT * FROM tblstpjobkeeperpaymentphases';
end;


destructor TSTPJobKeeperPaymentPhases.Destroy;
begin
  inherited;
end;


procedure TSTPJobKeeperPaymentPhases.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'PhaseNo');
  SetDateTimePropertyFromNode(node, 'DateFrom');
  SetDateTimePropertyFromNode(node, 'DateTo');
  SetPropertyFromNode(node, 'Tier1Rate');
  SetPropertyFromNode(node, 'Tier2Rate');
end;


procedure TSTPJobKeeperPaymentPhases.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'PhaseNo', PhaseNo);
  AddXMLNode(node, 'DateFrom', DateFrom);
  AddXMLNode(node, 'DateTo', DateTo);
  AddXMLNode(node, 'Tier1Rate', Tier1Rate);
  AddXMLNode(node, 'Tier2Rate', Tier2Rate);
end;


function TSTPJobKeeperPaymentPhases.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TSTPJobKeeperPaymentPhases.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSTPJobKeeperPaymentPhases.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


class function TSTPJobKeeperPaymentPhases.Ratefor(AOwner:TComponent;aSTPTier: Integer;  aDate: TDate): Double;
begin
  result := 0;
  if (aSTPTier<>1) and (aSTPTier<>2) then exit;
  With TSTPJobKeeperPaymentPhases.CreateWithNewConn(AOwner) do try
    LoadSelect(Quotedstr(FormatDateTime(mysqldateformat, aDate))+' between datefrom and dateto');
    if count = 0 then exit;
       if aSTPTier =1 then result := Tier1Rate
       else result := Tier2Rate;
  finally
    Free;
  end;
end;

procedure TSTPJobKeeperPaymentPhases.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TSTPJobKeeperPaymentPhases.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSTPJobKeeperPaymentPhases.GetIDField: string;
begin
  Result := 'ID'
end;


class function TSTPJobKeeperPaymentPhases.GetBusObjectTablename: string;
begin
  Result:= 'tblstpjobkeeperpaymentphases';
end;


function TSTPJobKeeperPaymentPhases.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TSTPJobKeeperPaymentPhases.GetPhaseNo         : Integer   ; begin Result := GetIntegerField('PhaseNo');end;
function  TSTPJobKeeperPaymentPhases.GetDateFrom        : TDateTime ; begin Result := GetDateTimeField('DateFrom');end;
function  TSTPJobKeeperPaymentPhases.GetDateTo          : TDateTime ; begin Result := GetDateTimeField('DateTo');end;
function  TSTPJobKeeperPaymentPhases.GetTier1Rate       : Double    ; begin Result := GetFloatField('Tier1Rate');end;
function  TSTPJobKeeperPaymentPhases.GetTier2Rate       : Double    ; begin Result := GetFloatField('Tier2Rate');end;
procedure TSTPJobKeeperPaymentPhases.SetPhaseNo         (const Value: Integer   ); begin SetIntegerField('PhaseNo'          , Value);end;
procedure TSTPJobKeeperPaymentPhases.SetDateFrom        (const Value: TDateTime ); begin SetDateTimeField('DateFrom'         , Value);end;
procedure TSTPJobKeeperPaymentPhases.SetDateTo          (const Value: TDateTime ); begin SetDateTimeField('DateTo'           , Value);end;
procedure TSTPJobKeeperPaymentPhases.SetTier1Rate       (const Value: Double    ); begin SetFloatField('Tier1Rate'        , Value);end;
procedure TSTPJobKeeperPaymentPhases.SetTier2Rate       (const Value: Double    ); begin SetFloatField('Tier2Rate'        , Value);end;


  {TSTPJobKeeperFNList}

constructor TSTPJobKeeperFNList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'stpjobkeeperfnlist';
  fSQL := 'SELECT * FROM tblstpjobkeeperfnlist';
end;


destructor TSTPJobKeeperFNList.Destroy;
begin
  inherited;
end;


procedure TSTPJobKeeperFNList.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'FN');
  SetDateTimePropertyFromNode(node, 'DateFrom');
  SetDateTimePropertyFromNode(node, 'Dateto');
  SetPropertyFromNode(node, 'OtherAllowanceStartDescription');
  SetPropertyFromNode(node, 'OtherAllowanceFinishDescription');
end;


procedure TSTPJobKeeperFNList.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'FN', FN);
  AddXMLNode(node, 'DateFrom', DateFrom);
  AddXMLNode(node, 'Dateto', Dateto);
  AddXMLNode(node, 'OtherAllowanceStartDescription', OtherAllowanceStartDescription);
  AddXMLNode(node, 'OtherAllowanceFinishDescription', OtherAllowanceFinishDescription);
end;


function TSTPJobKeeperFNList.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TSTPJobKeeperFNList.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSTPJobKeeperFNList.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSTPJobKeeperFNList.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TSTPJobKeeperFNList.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSTPJobKeeperFNList.GetIDField: string;
begin
  Result := 'ID'
end;


class function TSTPJobKeeperFNList.GetBusObjectTablename: string;
begin
  Result:= 'tblstpjobkeeperfnlist';
end;


function TSTPJobKeeperFNList.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
class function TSTPJobKeeperFNList.StartDateDescForFn(AOwner: TComponent ;aFN: String): String;
begin
  With TSTPJobKeeperFNList.CreateWithNewConn(AOwner) do try
    LoadSelect('FN=' +quotedstr(aFN));
    Result := FormatDateTime(ShortDateFormat, DateFrom)+' - ' + FormatDateTime(ShortDateFormat, DateTo);
  finally
    Free;
  end;
end;
class function TSTPJobKeeperFNList.FinishDateDescForFn(AOwner: TComponent ;aFN: String): String;
begin
  With TSTPJobKeeperFNList.CreateWithNewConn(AOwner) do try
    LoadSelect('FN=' +quotedstr(aFN));
    Result := FormatDateTime(ShortDateFormat, DateFrom)+' - ' + FormatDateTime(ShortDateFormat, DateTo);
  finally
    Free;
  end;

end;


{Property Functions}
function  TSTPJobKeeperFNList.GetFN                             : string    ; begin Result := GetStringField('FN');end;
function  TSTPJobKeeperFNList.GetDateFrom                       : TDateTime ; begin Result := GetDateTimeField('DateFrom');end;
function  TSTPJobKeeperFNList.GetDateto                         : TDateTime ; begin Result := GetDateTimeField('Dateto');end;
function  TSTPJobKeeperFNList.GetOtherAllowanceStartDescription : string    ; begin Result := GetStringField('OtherAllowanceStartDescription');end;
function  TSTPJobKeeperFNList.GetOtherAllowanceFinishDescription: string    ; begin Result := GetStringField('OtherAllowanceFinishDescription');end;
procedure TSTPJobKeeperFNList.SetFN                             (const Value: string    ); begin SetStringField('FN'                              , Value);end;
procedure TSTPJobKeeperFNList.SetDateFrom                       (const Value: TDateTime ); begin SetDateTimeField('DateFrom'                        , Value);end;
procedure TSTPJobKeeperFNList.SetDateto                         (const Value: TDateTime ); begin SetDateTimeField('Dateto'                          , Value);end;
procedure TSTPJobKeeperFNList.SetOtherAllowanceStartDescription (const Value: string    ); begin SetStringField('OtherAllowanceStartDescription', Value);end;
procedure TSTPJobKeeperFNList.SetOtherAllowanceFinishDescription(const Value: string    ); begin SetStringField('OtherAllowanceFinishDescription', Value);end;


initialization
  RegisterClass(TSTPJobKeeperFNList);
  RegisterClass(TSTPJobKeeperPaymentPhases);
  RegisterClassOnce(TEmployeePaySettings);


end.
