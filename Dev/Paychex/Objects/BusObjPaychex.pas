unit BusObjPaychex;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  14/06/21  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjPaysTransactions;

type
  Tpaychexpaypaytaxes = Class;
  Tpaychexpaypayinformal = Class;
  Tpaychexpaypayearning = Class;
  Tpaychexpaypaydeductions = Class;
  TpayChextransactions = Class;

  TpaychexBase =class(TMSBusObj)
  Protected
    Function getPostToAccountType:String;Virtual;Abstract;
    Function getPostToAccountMSType:String;Virtual;Abstract;
    Function getPostToAccountDescription:String;Virtual;Abstract;
    function GetIsList: Boolean; override;
  Public
    constructor  Create(AOwner: TComponent);                            override;
    Property PostToAccountType :String read getPostToAccountType;
    Property PostToAccountMSType :String read getPostToAccountMSType;
    Property PostToAccountDescription :String read getPostToAccountDescription;
  end;

  Tpaychexpays = class(TpaychexBase)
  private
    //fPayTransObj                    :TpayChextransactions;
    function GetpayPeriodId         : string    ;
    function GetpaycheckId          : string    ;
    function GetEmployeeID          : Integer;
    function GetDeptId              : Integer;
    function GetworkerId            : string    ;
    function GetDeptName            : string    ;
    function GetEmployeeName        : string    ;
    function GetcheckDate           : TDateTime ;
    function GetnetPay              : Double    ;
    function GetcheckType           : string    ;
    function GetcheckNumber         : string    ;
    procedure SetpayPeriodId         (const Value: string    );
    procedure SetpaycheckId          (const Value: string    );
    procedure SetEmployeeID          (const Value: Integer);
    procedure SetDeptId              (const Value: Integer);
    procedure SetworkerId            (const Value: string    );
    procedure SetDeptName            (const Value: string    );
    procedure SetEmployeeName        (const Value: string    );
    procedure SetcheckDate           (const Value: TDateTime );
    procedure SetnetPay              (const Value: Double    );
    procedure SetcheckType           (const Value: string    );
    procedure SetcheckNumber         (const Value: string    );
    Function Getpaychexpaypaytaxes   : Tpaychexpaypaytaxes;
    function Getpaychexpaypaydeductions: Tpaychexpaypaydeductions;
    function Getpaychexpaypayearning: Tpaychexpaypayearning;
    function Getpaychexpaypayinformal: Tpaychexpaypayinformal;
    Procedure PostToAccounts;
    Procedure PostToAccountsCallback(const Sender: TBusObj; var Abort: Boolean);
    function GetPayTransObj: TpayChextransactions;
    function GetPayTransEarningObj: TpayChextransactions;
    function GetPayTransDeductionObj: TpayChextransactions;
    function GetPayTransTaxObj: TpayChextransactions;
  Protected
    Function getPostToAccountType:String;override;
    Function getPostToAccountMSType:String;override;
    Function getPostToAccountDescription:String;override;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
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
    //property PayTrans  :TpayChextransactions    Read fPayTransObj  write  fPayTransObj;
    property PayTransObj  :TpayChextransactions    Read GetPayTransObj  ;
    property PayTransEarningObj  :TpayChextransactions    Read GetPayTransEarningObj  ;
    property PayTransDeductionObj:TpayChextransactions    Read GetPayTransDeductionObj  ;
    property PayTransTaxObj:TpayChextransactions    Read GetPayTransTaxObj  ;
    property DeptId      : Integer     read GetDeptId             write SetDeptId          ;
    property EmployeeID  : Integer     read GetEmployeeID         write SetEmployeeID      ;

  published
    property payPeriodId : string      read GetpayPeriodId        write SetpayPeriodId     ;
    property paycheckId  : string      read GetpaycheckId         write SetpaycheckId      ;
    property workerId    : string      read GetworkerId           write SetworkerId        ;
    property DeptName    : string      read GetDeptName           write SetDeptName        ;
    property EmployeeName: string      read GetEmployeeName       write SetEmployeeName    ;
    property checkDate   : TDateTime   read GetcheckDate          write SetcheckDate       ;
    property netPay      : Double      read GetnetPay             write SetnetPay          ;
    property checkType   : string      read GetcheckType          write SetcheckType       ;
    property checkNumber : string      read GetcheckNumber        write SetcheckNumber     ;
    Property paychexpaypaytaxes     : Tpaychexpaypaytaxes      read Getpaychexpaypaytaxes;
    Property paychexpaypayinformal  : Tpaychexpaypayinformal   read Getpaychexpaypayinformal;
    Property paychexpaypayearning   : Tpaychexpaypayearning    read Getpaychexpaypayearning;
    Property paychexpaypaydeductions: Tpaychexpaypaydeductions read Getpaychexpaypaydeductions;
  end;

  TpaychexpaypayDetails = class(TpaychexBase)
  private
    function GetpaychexpaysId         : Integer   ;
    function GetcomponentId           : string    ;
    function GetcheckComponentId      : string    ;
    function GetPayname               : Integer   ; // 1:Hourly etc
    function GetclassificationType    : Integer   ; // 1:REGULAR , 2: SUPPLEMENTAL
    function GeteffectOnPay           : Integer   ; // 1:ADDITION
    function Getamount                : Double    ;
    procedure SetpaychexpaysId         (const Value: Integer   );
    procedure SetcomponentId           (const Value: string    );
    procedure SetcheckComponentId      (const Value: string    );
    procedure SetPayname               (const Value: Integer   );
    procedure SetclassificationType    (const Value: Integer   );
    procedure SeteffectOnPay           (const Value: Integer   );
    procedure Setamount                (const Value: Double    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property paychexpaysId          :Integer     read GetpaychexpaysId        write SetpaychexpaysId     ;
  published
    property componentId            :string      read GetcomponentId          write SetcomponentId       ;
    property checkComponentId       :string      read GetcheckComponentId     write SetcheckComponentId  ;
    property Payname                :Integer     read GetPayname              write SetPayname           ;
    property classificationType     :Integer     read GetclassificationType   write SetclassificationType;
    property effectOnPay            :Integer     read GeteffectOnPay          write SeteffectOnPay       ;
    property amount                 :Double      read Getamount               write Setamount            ;
  end;
  Tpaychexpaypayinformal = class(TpaychexpaypayDetails)
  Protected
    Function getPostToAccountType:String;Override;
    Function getPostToAccountMSType:String;Override;
    Function getPostToAccountDescription:String;Override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
  end;
  TpaychexpaypayEarnDed = class(TpaychexpaypayDetails)
  private
    function Getmemoed                : Boolean   ;
    function GetlaborAssignmentId     : string    ;
    function GetorganizationId        : string    ;
    function GetOrganizationname      : string    ;
    function GetjobName               : string    ;
    function Getrate                  : Double    ;
    function Gethours                 : Double    ;
    procedure Setmemoed                (const Value: Boolean   );
    procedure SetlaborAssignmentId     (const Value: string    );
    procedure SetorganizationId        (const Value: string    );
    procedure SetOrganizationname      (const Value: string    );
    procedure SetjobName               (const Value: string    );
    procedure Setrate                  (const Value: Double    );
    procedure Sethours                 (const Value: Double    );
  protected
  public
    class function  GetIDField                   : string;              override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property memoed                 :Boolean     read Getmemoed               write Setmemoed            ;
    property laborAssignmentId      :string      read GetlaborAssignmentId    write SetlaborAssignmentId ;
    property organizationId         :string      read GetorganizationId       write SetorganizationId    ;
    property Organizationname       :string      read GetOrganizationname     write SetOrganizationname  ;
    property jobName                :string      read GetjobName              write SetjobName           ;
    property rate                   :Double      read Getrate                 write Setrate              ;
    property hours                  :Double      read Gethours                write Sethours             ;
  end;
  Tpaychexpaypaydeductions = Class(TpaychexpaypayEarnDed)
  Protected
    Function getPostToAccountType:String;Override;
    Function getPostToAccountMSType:String;Override;
    Function getPostToAccountDescription:String;Override;
  public
    class function GetBusObjectTablename: string;override;
    constructor  Create(AOwner: TComponent);                            override;
  End;
  Tpaychexpaypayearning = Class(TpaychexpaypayEarnDed)
  private
  Protected
    Function getPostToAccountType:String;Override;
    Function getPostToAccountMSType:String;Override;
    Function getPostToAccountDescription:String;Override;
  public
    class function GetBusObjectTablename: string;override;
    constructor  Create(AOwner: TComponent);     override;
  published
  end;

  Tpaychexpaypaytaxes = Class(TpaychexBase)
  private
    function GetpaychexpaysId        : Integer   ;
    function Gettaxname              : string    ;
    function GetlaborAssignmentId    : string    ;
    function GetjobId                : string    ;
    function GetPaidby               : string    ;
    function Getamount               : Double    ;
    procedure SetpaychexpaysId        (const Value: Integer   );
    procedure Settaxname              (const Value: string    );
    procedure SetlaborAssignmentId    (const Value: string    );
    procedure SetjobId                (const Value: string    );
    procedure SetPaidby               (const Value: string    );
    procedure Setamount               (const Value: Double    );
  protected
    Function getPostToAccountType:String;Override;
    Function getPostToAccountMSType:String;Override;
    Function getPostToAccountDescription:String;Override;
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
    property paychexpaysId         :Integer     read GetpaychexpaysId       write SetpaychexpaysId    ;
  published
    property taxname               :string      read Gettaxname             write Settaxname          ;
    property laborAssignmentId     :string      read GetlaborAssignmentId   write SetlaborAssignmentId;
    property jobId                 :string      read GetjobId               write SetjobId            ;
    property Paidby                :string      read GetPaidby              write SetPaidby           ;
    property amount                :Double      read Getamount              write Setamount           ;
  end;

  Tpaychexpayperiods = class(TMSBusObj)
  private
    function GetpayPeriodId         : string    ;
    function GetintervalCode        : Integer   ;
    function Getstatus              : Integer   ;
    function Getdescription         : string    ;
    function GetstartDate           : TDateTime ;
    function GetendDate             : TDateTime ;
    function GetsubmitByDate        : TDateTime ;
    function GetcheckDate           : TDateTime ;
    function GetcheckCount          : Integer   ;
    procedure SetpayPeriodId         (const Value: string    );
    procedure SetintervalCode        (const Value: Integer   );
    procedure Setstatus              (const Value: Integer   );
    procedure Setdescription         (const Value: string    );
    procedure SetstartDate           (const Value: TDateTime );
    procedure SetendDate             (const Value: TDateTime );
    procedure SetsubmitByDate        (const Value: TDateTime );
    procedure SetcheckDate           (const Value: TDateTime );
    procedure SetcheckCount          (const Value: Integer   );

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
    property payPeriodId          :string      read GetpayPeriodId        write SetpayPeriodId     ;
    property intervalCode         :Integer     read GetintervalCode       write SetintervalCode    ;
    property status               :Integer     read Getstatus             write Setstatus          ;
    property description          :string      read Getdescription        write Setdescription     ;
    property startDate            :TDateTime   read GetstartDate          write SetstartDate       ;
    property endDate              :TDateTime   read GetendDate            write SetendDate         ;
    property submitByDate         :TDateTime   read GetsubmitByDate       write SetsubmitByDate    ;
    property checkDate            :TDateTime   read GetcheckDate          write SetcheckDate       ;
    property checkCount           :Integer     read GetcheckCount         write SetcheckCount      ;

  end;
  TpayChextransactions = class(Tpaystransactions)
  Protected
    Function  getPostPayId:Integer ; Override;
    Function  getPostDatepaid:TDateTime; Override;
    Function  getPostemployeeId:Integer ; Override;
    Function  getPostemployeeName:String ; Override;
  Public
    Class Function  GetBusObjectTablename        : string;              override;
    Constructor  Create(AOwner: TComponent);                            override;
  end;




implementation


uses tcDataUtils, CommonLib, sysutils, PayAccounts, PayConst, PaychexLib,
  BusObjClass, BusObjEmployee, BusObjClient;



  {Tpaychexpays}

constructor Tpaychexpays.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'paychexpays';
  fSQL := 'SELECT * FROM tblpaychexpays';
   (*fPayTransObj                    := TpayChextransactions.Create(Self);
   fPayTransObj.Connection         := Self.Connection;
   fPayTransObj.SilentMode         := Self.SilentMode;*)

end;


destructor Tpaychexpays.Destroy;
begin
  inherited;
end;


procedure Tpaychexpays.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'payPeriodId');
  SetPropertyFromNode(node,'paycheckId');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'DeptId');
  SetPropertyFromNode(node,'workerId');
  SetPropertyFromNode(node,'DeptName');
  SetPropertyFromNode(node,'EmployeeName');
  SetDateTimePropertyFromNode(node,'checkDate');
  SetPropertyFromNode(node,'netPay');
  SetPropertyFromNode(node,'checkType');
  SetPropertyFromNode(node,'checkNumber');
end;


procedure Tpaychexpays.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'payPeriodId' ,payPeriodId);
  AddXMLNode(node,'paycheckId' ,paycheckId);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'DeptId' ,DeptId);
  AddXMLNode(node,'workerId' ,workerId);
  AddXMLNode(node,'DeptName' ,DeptName);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'checkDate' ,checkDate);
  AddXMLNode(node,'netPay' ,netPay);
  AddXMLNode(node,'checkType' ,checkType);
  AddXMLNode(node,'checkNumber' ,checkNumber);
end;


function Tpaychexpays.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tpaychexpays.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
  if not Result then exit;
  PostToAccounts;
end;

procedure Tpaychexpays.PostToAccounts;
var
  CreditAccountId: integer;
  DebitAccountId: integer;
begin
      CreditAccountId:= PayAccounts.BankAccountID(self.Employeeid);
      DebitAccountId:= PayAccounts.LumpSumDPaidAccountID(self.Employeeid);
      PayTransObj.PostToPaysTransactions(1,PostToAccountType ,PostToAccountMSType, PostToAccountDescription, CreditAccountId,DebitAccountId, DeptId, ID,netPay, self);
      paychexpaypayearning.IterateRecords(PostToAccountsCallback);
      paychexpaypayDeductions.IterateRecords(PostToAccountsCallback);
      paychexpaypayTaxes.IterateRecords(PostToAccountsCallback);
end;
procedure Tpaychexpays.PostToAccountsCallback(const Sender: TBusObj; var Abort: Boolean);
var
  CreditAccountId, DebitAccountId: integer;
begin
  CreditAccountId:= PayAccounts.BankAccountID(Employeeid);
  DebitAccountId:= PayAccounts.NetWagesAccountID(Employeeid);

  if sender is  Tpaychexpaypayearning then begin
    PayTransEarningObj.PostToPaysTransactions(2, Tpaychexpaypayearning(Sender).PostToAccountType,
                                                 Tpaychexpaypayearning(Sender).PostToAccountMSType,
                                                 Tpaychexpaypayearning(Sender).PostToAccountDescription,
                                                 CreditAccountId,DebitAccountId,
                                                 DeptId, ID,Tpaychexpaypayearning(Sender).amount, self, Tclient.IDToggle(Tpaychexpaypayearning(Sender).jobname));
    end else if sender is  TpaychexpaypayDeductions then begin
        PayTransDeductionObj.PostToPaysTransactions(3, TpaychexpaypayDeductions(Sender).PostToAccountType,
                                                       TpaychexpaypayDeductions(Sender).PostToAccountMSType,
                                                       TpaychexpaypayDeductions(Sender).PostToAccountDescription,
                                                       CreditAccountId,DebitAccountId,
                                                       DeptId, ID,0-TpaychexpaypayDeductions(Sender).amount, self, Tclient.IDToggle(TpaychexpaypayDeductions(Sender).jobname));
    end else if sender is  TpaychexpaypayTaxes then begin
        PayTransTaxObj.PostToPaysTransactions(4, TpaychexpaypayTaxes(Sender).PostToAccountType,
                                                       TpaychexpaypayTaxes(Sender).PostToAccountMSType,
                                                       TpaychexpaypayTaxes(Sender).PostToAccountDescription,
                                                       CreditAccountId,DebitAccountId,
                                                       DeptId, ID,0-TpaychexpaypayTaxes(Sender).amount, self);
    end;
end;

procedure Tpaychexpays.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tpaychexpays.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tpaychexpays.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tpaychexpays.GetIDField: string;
begin
  Result := 'ID'
end;


function Tpaychexpays.GetIsList: Boolean;
begin
  REsult := False;
end;

class function Tpaychexpays.GetBusObjectTablename: string;
begin
  Result:= 'tblpaychexpays';
end;


function Tpaychexpays.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Tpaychexpays.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
end;

function Tpaychexpays.GetPayTransObj         : TpayChextransactions;begin Result := TpayChextransactions(getcontainercomponent(TpayChextransactions , 'PayID = ' + IntToStr(ID) + ' AND Type = ' + quotedstr(PostToAccountType)                        + ' AND MSType = '+quotedstr(PostToAccountMsType)                        +' AND Description = '+Quotedstr(PostToAccountType                        +' - ' +PostToAccountMSType)                           + ' AND PayLineID = ' + IntToStr(ID)                        )); end;
function Tpaychexpays.GetPayTransEarningObj  : TpayChextransactions;begin Result := TpayChextransactions(getcontainercomponent(TpayChextransactions , 'PayID = ' + IntToStr(ID) + ' AND Type = ' + quotedstr(paychexpaypayearning.PostToAccountType)   + ' AND MSType = '+quotedstr(paychexpaypayearning.PostToAccountMSType)   +' AND Description = '+quotedstr(paychexpaypayearning.PostToAccountDescription   )+ ' AND PayLineID = ' + IntToStr(paychexpaypayearning.ID)   )); end;
function Tpaychexpays.GetPayTransDeductionObj: TpayChextransactions;begin Result := TpayChextransactions(getcontainercomponent(TpayChextransactions , 'PayID = ' + IntToStr(ID) + ' AND Type = ' + quotedstr(paychexpaypayDeductions.PostToAccountType)+ ' AND MSType = '+quotedstr(paychexpaypayDeductions.PostToAccountMSType)+' AND Description = '+quotedstr(paychexpaypayDeductions.PostToAccountDescription)+ ' AND PayLineID = ' + IntToStr(paychexpaypayDeductions.ID))); end;
function Tpaychexpays.GetPayTransTaxObj      : TpayChextransactions;begin Result := TpayChextransactions(getcontainercomponent(TpayChextransactions , 'PayID = ' + IntToStr(ID) + ' AND Type = ' + quotedstr(paychexpaypayTaxes.PostToAccountType)     + ' AND MSType = '+quotedstr(paychexpaypayTaxes.PostToAccountMSType)     +' AND Description = '+quotedstr(paychexpaypayTaxes.PostToAccountDescription     )+ ' AND PayLineID = ' + IntToStr(paychexpaypayTaxes.ID)     )); end;

{Property Functions}
function  Tpaychexpays.GetpayPeriodId     : string    ; begin Result := GetStringField('payPeriodId');end;
function  Tpaychexpays.GetpaycheckId      : string    ; begin Result := GetStringField('paycheckId');end;
function  Tpaychexpays.GetEmployeeID      : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  Tpaychexpays.GetDeptId          : Integer   ; begin Result := GetIntegerField('DeptId');end;
function  Tpaychexpays.GetworkerId        : string    ; begin Result := GetStringField('workerId');end;
function  Tpaychexpays.GetDeptName        : string    ; begin Result := TDeptClass.IDtoggle(GetIntegerField('DeptId'));end;
function  Tpaychexpays.GetEmployeeName    : string    ; begin Result := TEmployee.IDtoggle(GetIntegerField('EmployeeID'));end;
function  Tpaychexpays.GetcheckDate       : TDateTime ; begin Result := GetDatetimeField('checkDate');end;
function  Tpaychexpays.GetnetPay          : Double    ; begin Result := GetFloatField('netPay');end;
function  Tpaychexpays.GetcheckType       : string    ; begin Result := GetStringField('checkType');end;
function  Tpaychexpays.GetcheckNumber     : string    ; begin Result := GetStringField('checkNumber');end;
procedure Tpaychexpays.SetpayPeriodId     (const Value: string    ); begin SetStringField('payPeriodId'      , Value);end;
procedure Tpaychexpays.SetpaycheckId      (const Value: string    ); begin SetStringField('paycheckId'       , Value);end;
procedure Tpaychexpays.SetEmployeeID      (const Value: Integer   ); begin SetIntegerField('EmployeeID'       , Value);end;
procedure Tpaychexpays.SetDeptId          (const Value: Integer   ); begin SetIntegerField('DeptId'       , Value);end;
procedure Tpaychexpays.SetworkerId        (const Value: string    ); begin SetStringField('workerId'         , Value);end;
procedure Tpaychexpays.SetDeptName        (const Value: string    ); begin SetIntegerField('DeptId'       , TDeptClass.IDtoggle(Value));end;
procedure Tpaychexpays.SetEmployeeName    (const Value: string    ); begin SetIntegerField('EmployeeId'   , TEmployee.IDtoggle(Value));end;
procedure Tpaychexpays.SetcheckDate       (const Value: TDateTime ); begin SetDateTimeField('checkDate'        , Value);end;
procedure Tpaychexpays.SetnetPay          (const Value: Double    ); begin SetFloatField('netPay'           , Value);end;
procedure Tpaychexpays.SetcheckType       (const Value: string    ); begin SetStringField('checkType'        , Value);end;
procedure Tpaychexpays.SetcheckNumber     (const Value: string    ); begin SetStringField('checkNumber'      , Value);end;


  {Tpaychexpayperiods}

constructor Tpaychexpayperiods.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'paychexpayperiods';
  fSQL := 'SELECT * FROM tblpaychexpayperiods';
end;


destructor Tpaychexpayperiods.Destroy;
begin
  inherited;
end;


procedure Tpaychexpayperiods.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'payPeriodId');
  SetPropertyFromNode(node,'intervalCode');
  SetPropertyFromNode(node,'status');
  SetPropertyFromNode(node,'description');
  SetDateTimePropertyFromNode(node,'startDate');
  SetDateTimePropertyFromNode(node,'endDate');
  SetDateTimePropertyFromNode(node,'submitByDate');
  SetDateTimePropertyFromNode(node,'checkDate');
  SetPropertyFromNode(node,'checkCount');
end;


procedure Tpaychexpayperiods.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'payPeriodId' ,payPeriodId);
  AddXMLNode(node,'intervalCode' ,intervalCode);
  AddXMLNode(node,'status' ,status);
  AddXMLNode(node,'description' ,description);
  AddXMLNode(node,'startDate' ,startDate);
  AddXMLNode(node,'endDate' ,endDate);
  AddXMLNode(node,'submitByDate' ,submitByDate);
  AddXMLNode(node,'checkDate' ,checkDate);
  AddXMLNode(node,'checkCount' ,checkCount);
end;


function Tpaychexpayperiods.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tpaychexpayperiods.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tpaychexpayperiods.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tpaychexpayperiods.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tpaychexpayperiods.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tpaychexpayperiods.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tpaychexpayperiods.GetBusObjectTablename: string;
begin
  Result:= 'tblpaychexpayperiods';
end;


function Tpaychexpayperiods.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function Tpaychexpayperiods.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
end;

{Property Functions}
function Tpaychexpays.Getpaychexpaypaydeductions: Tpaychexpaypaydeductions;begin Result := Tpaychexpaypaydeductions(Getcontainercomponent(Tpaychexpaypaydeductions, 'paychexpaysId = ' + IntToStr(ID)));end;
function Tpaychexpays.Getpaychexpaypayearning   : Tpaychexpaypayearning   ;begin Result := Tpaychexpaypayearning    (Getcontainercomponent(Tpaychexpaypayearning  , 'paychexpaysId = ' + IntToStr(ID)));end;
function Tpaychexpays.Getpaychexpaypayinformal  : Tpaychexpaypayinformal  ;begin Result := Tpaychexpaypayinformal   (Getcontainercomponent(Tpaychexpaypayinformal , 'paychexpaysId = ' + IntToStr(ID)));end;
function Tpaychexpays.Getpaychexpaypaytaxes     : Tpaychexpaypaytaxes     ;begin Result := Tpaychexpaypaytaxes      (Getcontainercomponent(Tpaychexpaypaytaxes    , 'paychexpaysId = ' + IntToStr(ID)));end;

function  Tpaychexpayperiods.GetpayPeriodId     : string    ; begin Result := GetStringField('payPeriodId');end;
function  Tpaychexpayperiods.GetintervalCode    : Integer   ; begin Result := GetIntegerField('intervalCode');end;
function  Tpaychexpayperiods.Getstatus          : Integer   ; begin Result := GetIntegerField('status');end;
function  Tpaychexpayperiods.Getdescription     : string    ; begin Result := GetStringField('description');end;
function  Tpaychexpayperiods.GetstartDate       : TDateTime ; begin Result := GetDateTimeField('startDate');end;
function  Tpaychexpayperiods.GetendDate         : TDateTime ; begin Result := GetDateTimeField('endDate');end;
function  Tpaychexpayperiods.GetsubmitByDate    : TDateTime ; begin Result := GetDateTimeField('submitByDate');end;
function  Tpaychexpayperiods.GetcheckDate       : TDateTime ; begin Result := GetDateTimeField('checkDate');end;
function  Tpaychexpayperiods.GetcheckCount      : Integer   ; begin Result := GetIntegerField('checkCount');end;
procedure Tpaychexpayperiods.SetpayPeriodId     (const Value: string    ); begin SetStringField('payPeriodId'      , Value);end;
procedure Tpaychexpayperiods.SetintervalCode    (const Value: Integer   ); begin SetIntegerField('intervalCode'     , Value);end;
procedure Tpaychexpayperiods.Setstatus          (const Value: Integer   ); begin SetIntegerField('status'           , Value);end;
procedure Tpaychexpayperiods.Setdescription     (const Value: string    ); begin SetStringField('description'      , Value);end;
procedure Tpaychexpayperiods.SetstartDate       (const Value: TDateTime ); begin SetDateTimeField('startDate'        , Value);end;
procedure Tpaychexpayperiods.SetendDate         (const Value: TDateTime ); begin SetDateTimeField('endDate'          , Value);end;
procedure Tpaychexpayperiods.SetsubmitByDate    (const Value: TDateTime ); begin SetDateTimeField('submitByDate'     , Value);end;
procedure Tpaychexpayperiods.SetcheckDate       (const Value: TDateTime ); begin SetDateTimeField('checkDate'        , Value);end;
procedure Tpaychexpayperiods.SetcheckCount      (const Value: Integer   ); begin SetIntegerField('checkCount'       , Value);end;

  {Tpaychexpaypaytaxes}

constructor Tpaychexpaypaytaxes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'paychexpaypaytaxes';
  fSQL := 'SELECT * FROM tblpaychexpaypaytaxes';
end;


destructor Tpaychexpaypaytaxes.Destroy;
begin
  inherited;
end;


procedure Tpaychexpaypaytaxes.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'paychexpaysId');
  SetPropertyFromNode(node,'taxname');
  SetPropertyFromNode(node,'laborAssignmentId');
  SetPropertyFromNode(node,'jobId');
  SetPropertyFromNode(node,'Paidby');
  SetPropertyFromNode(node,'amount');
end;


procedure Tpaychexpaypaytaxes.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'paychexpaysId' ,paychexpaysId);
  AddXMLNode(node,'taxname' ,taxname);
  AddXMLNode(node,'laborAssignmentId' ,laborAssignmentId);
  AddXMLNode(node,'jobId' ,jobId);
  AddXMLNode(node,'Paidby' ,Paidby);
  AddXMLNode(node,'amount' ,amount);
end;


function Tpaychexpaypaytaxes.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tpaychexpaypaytaxes.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tpaychexpaypaytaxes.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tpaychexpaypaytaxes.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tpaychexpaypaytaxes.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tpaychexpaypaytaxes.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tpaychexpaypaytaxes.GetBusObjectTablename: string;
begin
  Result:= 'tblpaychexpaypaytaxes';
end;


function Tpaychexpaypaytaxes.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function Tpaychexpaypaytaxes.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  if assigned(Owner) then
    if owner is Tpaychexpays then
      paychexpaysId := Tpaychexpays(Owner).ID;
end;

{Property Functions}
function  Tpaychexpaypaytaxes.GetpaychexpaysId    : Integer   ; begin Result := GetIntegerField('paychexpaysId');end;
function  Tpaychexpaypaytaxes.Gettaxname          : string    ; begin Result := GetStringField('taxname');end;
function  Tpaychexpaypaytaxes.GetlaborAssignmentId: string    ; begin Result := GetStringField('laborAssignmentId');end;
function  Tpaychexpaypaytaxes.GetjobId            : string    ; begin Result := GetStringField('jobId');end;
function  Tpaychexpaypaytaxes.GetPaidby           : string    ; begin Result := GetStringField('Paidby');end;
function  Tpaychexpaypaytaxes.Getamount           : Double    ; begin Result := GetFloatField('amount');end;
procedure Tpaychexpaypaytaxes.SetpaychexpaysId    (const Value: Integer   ); begin SetIntegerField('paychexpaysId'     , Value);end;
procedure Tpaychexpaypaytaxes.Settaxname          (const Value: string    ); begin SetStringField('taxname'           , Value);end;
procedure Tpaychexpaypaytaxes.SetlaborAssignmentId(const Value: string    ); begin SetStringField('laborAssignmentId' , Value);end;
procedure Tpaychexpaypaytaxes.SetjobId            (const Value: string    ); begin SetStringField('jobId'             , Value);end;
procedure Tpaychexpaypaytaxes.SetPaidby           (const Value: string    ); begin SetStringField('Paidby'            , Value);end;
procedure Tpaychexpaypaytaxes.Setamount           (const Value: Double    ); begin SetFloatField('amount'            , Value);end;

  {Tpaychexpaypayinformal}

constructor Tpaychexpaypayinformal.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'paychexpaypayinformal';
  fSQL := 'SELECT * FROM tblpaychexpaypayinformal';
end;


procedure TpaychexpaypayDetails.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'paychexpaysId');
  SetPropertyFromNode(node,'componentId');
  SetPropertyFromNode(node,'checkComponentId');
  SetPropertyFromNode(node,'Payname');
  SetPropertyFromNode(node,'classificationType');
  SetPropertyFromNode(node,'effectOnPay');
  SetPropertyFromNode(node,'amount');
end;


procedure TpaychexpaypayDetails.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'paychexpaysId' ,paychexpaysId);
  AddXMLNode(node,'componentId' ,componentId);
  AddXMLNode(node,'checkComponentId' ,checkComponentId);
  AddXMLNode(node,'Payname' ,Payname);
  AddXMLNode(node,'classificationType' ,classificationType);
  AddXMLNode(node,'effectOnPay' ,effectOnPay);
  AddXMLNode(node,'amount' ,amount);
end;


function TpaychexpaypayDetails.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TpaychexpaypayDetails.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TpaychexpaypayDetails.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TpaychexpaypayDetails.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TpaychexpaypayDetails.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tpaychexpaypayinformal.GetIDField: string;
begin
  Result := 'ID'
end;




class function Tpaychexpaypayinformal.GetBusObjectTablename: string;
begin
  Result:= 'tblpaychexpaypayinformal';
end;


function TpaychexpaypayDetails.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TpaychexpaypayDetails.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  if assigned(Owner) then
    if owner is Tpaychexpays then
      paychexpaysId := Tpaychexpays(Owner).ID;
end;

{Property Functions}
function  TpaychexpaypayDetails.GetpaychexpaysId     : Integer   ; begin Result := GetIntegerField('paychexpaysId');end;
function  TpaychexpaypayDetails.GetcomponentId       : string    ; begin Result := GetStringField('componentId');end;
function  TpaychexpaypayDetails.GetcheckComponentId  : string    ; begin Result := GetStringField('checkComponentId');end;
function  TpaychexpaypayDetails.GetPayname           : Integer   ; begin Result := GetIntegerField('Payname');end;
function  TpaychexpaypayDetails.GetclassificationType: Integer   ; begin Result := GetIntegerField('classificationType');end;
function  TpaychexpaypayDetails.GeteffectOnPay       : Integer   ; begin Result := GetIntegerField('effectOnPay');end;
function  TpaychexpaypayDetails.Getamount            : Double    ; begin Result := GetFloatField('amount');end;
procedure TpaychexpaypayDetails.SetpaychexpaysId     (const Value: Integer   ); begin SetIntegerField('paychexpaysId'      , Value);end;
procedure TpaychexpaypayDetails.SetcomponentId       (const Value: string    ); begin SetStringField('componentId'        , Value);end;
procedure TpaychexpaypayDetails.SetcheckComponentId  (const Value: string    ); begin SetStringField('checkComponentId'   , Value);end;
procedure TpaychexpaypayDetails.SetPayname           (const Value: Integer   ); begin SetIntegerField('Payname'            , Value);end;
procedure TpaychexpaypayDetails.SetclassificationType(const Value: Integer   ); begin SetIntegerField('classificationType' , Value);end;
procedure TpaychexpaypayDetails.SeteffectOnPay       (const Value: Integer   ); begin SetIntegerField('effectOnPay'        , Value);end;
procedure TpaychexpaypayDetails.Setamount            (const Value: Double    ); begin SetFloatField('amount'             , Value);end;



procedure TpaychexpaypayEarnDed.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetBooleanPropertyFromNode(node,'memoed');
  SetPropertyFromNode(node,'laborAssignmentId');
  SetPropertyFromNode(node,'organizationId');
  SetPropertyFromNode(node,'Organizationname');
  SetPropertyFromNode(node,'jobName');
  SetPropertyFromNode(node,'rate');
  SetPropertyFromNode(node,'hours');
end;


procedure TpaychexpaypayEarnDed.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'memoed' ,memoed);
  AddXMLNode(node,'laborAssignmentId' ,laborAssignmentId);
  AddXMLNode(node,'organizationId' ,organizationId);
  AddXMLNode(node,'Organizationname' ,Organizationname);
  AddXMLNode(node,'jobName' ,jobName);
  AddXMLNode(node,'rate' ,rate);
  AddXMLNode(node,'hours' ,hours);
end;


function TpaychexpaypayEarnDed.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TpaychexpaypayEarnDed.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;



Class function TpaychexpaypayEarnDed.GetIDField: string;
begin
  Result := 'ID'
end;

  {TpaychexpaypayEarnDed}

constructor Tpaychexpaypaydeductions.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'paychexpaypaydeductions';
  fSQL := 'SELECT * FROM tblpaychexpaypaydeductions';
end;

class function Tpaychexpaypaydeductions.GetBusObjectTablename: string;
begin
  Result:= 'tblpaychexpaypaydeductions';
end;


{Tpaychexpaypayearning}

constructor Tpaychexpaypayearning.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'paychexpaypayearning';
  fSQL := 'SELECT * FROM tblpaychexpaypayearning';
end;
class function Tpaychexpaypayearning.GetBusObjectTablename: string;
begin
  Result:= 'tblpaychexpaypayearning';
end;


{Property Functions}
function  TpaychexpaypayEarnDed.Getmemoed            : Boolean   ; begin Result := GetBooleanField('memoed');end;
function  TpaychexpaypayEarnDed.GetlaborAssignmentId : string    ; begin Result := GetStringField('laborAssignmentId');end;
function  TpaychexpaypayEarnDed.GetorganizationId    : string    ; begin Result := GetStringField('organizationId');end;
function  TpaychexpaypayEarnDed.GetOrganizationname  : string    ; begin Result := GetStringField('Organizationname');end;
function  TpaychexpaypayEarnDed.GetjobName           : string    ; begin Result := GetStringField('jobName');end;
function  TpaychexpaypayEarnDed.Getrate              : Double    ; begin Result := GetFloatField('rate');end;
function  TpaychexpaypayEarnDed.Gethours             : Double    ; begin Result := GetFloatField('hours');end;
procedure TpaychexpaypayEarnDed.Setmemoed            (const Value: Boolean   ); begin SetBooleanField('memoed'             , Value);end;
procedure TpaychexpaypayEarnDed.SetlaborAssignmentId (const Value: string    ); begin SetStringField('laborAssignmentId' , Value);end;
procedure TpaychexpaypayEarnDed.SetorganizationId    (const Value: string    ); begin SetStringField('organizationId'     , Value);end;
procedure TpaychexpaypayEarnDed.SetOrganizationname  (const Value: string    ); begin SetStringField('Organizationname'   , Value);end;
procedure TpaychexpaypayEarnDed.SetjobName           (const Value: string    ); begin SetStringField('jobName'            , Value);end;
procedure TpaychexpaypayEarnDed.Setrate              (const Value: Double    ); begin SetFloatField('rate'               , Value);end;
procedure TpaychexpaypayEarnDed.Sethours             (const Value: Double    ); begin SetFloatField('hours'              , Value);end;

{ TpayChextransactions }

constructor TpayChextransactions.Create(AOwner: TComponent);
begin
  inherited;
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'paychextransactions';
  fSQL := 'SELECT * FROM tblpaychextransactions';
end;

class function TpayChextransactions.GetBusObjectTablename: string;
begin
  Result:= 'tblpaychextransactions';
end;
Function  TpayChextransactions.getPostPayId       :Integer  ; begin result := Tpaychexpays(Owner).ID;           end;
Function  TpayChextransactions.getPostDatepaid    :TDateTime; begin result := Tpaychexpays(Owner).checkDate;    end;
Function  TpayChextransactions.getPostemployeeId  :Integer  ; begin result := Tpaychexpays(Owner).employeeid;   end;
Function  TpayChextransactions.getPostemployeeName:String   ; begin result := Tpaychexpays(Owner).employeename; end;

Function Tpaychexpays.getPostToAccountType            : String;begin Result := 'Payroll Nett Wages' ;end;
function Tpaychexpaypaytaxes.getPostToAccountType     : String;begin Result := 'Taxes'              ;end;
function Tpaychexpaypayearning.getPostToAccountType   : String;begin Result := 'Earnings'           ;end;
function Tpaychexpaypaydeductions.getPostToAccountType: String;begin Result := 'Deductions'         ;end;
function Tpaychexpaypayinformal.getPostToAccountType  : String;begin Result :='Informal'            ;end;

Function Tpaychexpays.getPostToAccountDescription            : String;begin Result := PostToAccountType+' - ' + PostToAccountMSType ;end;
function Tpaychexpaypaytaxes.getPostToAccountDescription     : String;begin Result := PostToAccountType+' - ' + Taxname             ;end;
function Tpaychexpaypayearning.getPostToAccountDescription   : String;begin Result := PostToAccountType+' - ' + PaynameToDEsc(Payname)+' - ' + Jobname;end;
function Tpaychexpaypaydeductions.getPostToAccountDescription: String;begin Result := PostToAccountType+' - ' + PaynameToDEsc(Payname)+' - ' + Jobname;end;
function Tpaychexpaypayinformal.getPostToAccountDescription  : String;begin Result := PostToAccountType+' - ' + PaynameToDEsc(Payname);end;

function Tpaychexpaypaytaxes.getPostToAccountMSType     : String;begin Result := taxname          ;end;
function Tpaychexpaypayearning.getPostToAccountMSType   : String;begin Result := MSType_GrossWages;end;
function Tpaychexpaypaydeductions.getPostToAccountMSType: String;begin Result := 'Deductions'     ;end;
function Tpaychexpaypayinformal.getPostToAccountMSType  : String;begin Result := 'Informal'       ;end;
Function Tpaychexpays.getPostToAccountMSType            : String;begin Result := MSType_NetWages  ;end;


{ TpaychexBase }

constructor TpaychexBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ExportExcludeList.Add('ISEmpty');
  ExportExcludeList.Add('KeyValue');
  ExportExcludeList.Add('MsTimeStamp');
  ExportExcludeList.Add('MsUpdateSiteCode');
  ExportExcludeList.Add('Recno');
end;

function TpaychexBase.GetIsList: Boolean;
begin
  REsult := True;
end;

initialization
  RegisterClass(Tpaychexpaypaydeductions);
  RegisterClass(Tpaychexpaypayearning);
  RegisterClass(Tpaychexpaypayinformal);
  RegisterClass(Tpaychexpaypaytaxes);
  RegisterClass(Tpaychexpayperiods);
  RegisterClass(Tpaychexpays);
  RegisterClassOnce(TpayChextransactions);



end.

