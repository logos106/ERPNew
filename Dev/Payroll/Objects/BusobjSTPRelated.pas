unit BusobjSTPRelated;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  08/04/20  1.00.00  A.  Initial Version.
  this object is only used for STP submission, calculating the YTD
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TSUMPayForSTPBase =class(TMSBusObj)
  Private
    fdtYTDMoneyAmountFrom: TDatetime;
    fdtPayrunDate: TDatetime;
    fiPayIDforInst :Integer;
    fbPayDatefilterUsesTime: Boolean;
  Protected
    Function  DoBeforeOpen(Dataset: TDataset):Boolean;override;
  Public
    constructor  Create(AOwner: TComponent); override;
    Property YTDMoneyAmountFrom :TDatetime read fdtYTDMoneyAmountFrom write fdtYTDMoneyAmountFrom;
    Property PayrunDate :TDatetime read fdtPayrunDate write fdtPayrunDate;
    Property PayIDforInst :Integer read fiPayIDforInst write fiPayIDforInst;
    Property PayDatefilterUsesTime :Boolean read fbPayDatefilterUsesTime write fbPayDatefilterUsesTime;
  end;
  TSUMPayTopUptoJobKeepersAllowanceForSTP = class(TSUMPayForSTPBase)
  Private
    function GetPayId          : Integer   ;
    function GetAmount         : Double    ;
    function GetYTDMoneyAmount : Double    ;
  Protected
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
  Public
      constructor  Create(AOwner: TComponent);                            override;
  Published
    property PayId           :Integer     read GetPayId         ;
    property Amount          :Double      read GetAmount        ;
    property YTDMoneyAmount  :Double      read GetYTDMoneyAmount;
  end;
  TSUMPayAllowanceForSTP = class(TSUMPayForSTPBase)
  private
    function GetPayId          : Integer   ;
    function GetIsOther        : Boolean   ;
    function GetDescription    : string    ;
    function GetAllowanceType  : string    ;
    function GetAmount         : Double    ;
    function GetYTDMoneyAmount : Double    ;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property PayId           :Integer     read GetPayId         ;
    property IsOther         :Boolean     read GetIsOther       ;
    property Description     :string      read GetDescription   ;
    property AllowanceType   :string      read GetAllowanceType ;
    property Amount          :Double      read GetAmount        ;
    property YTDMoneyAmount  :Double      read GetYTDMoneyAmount;
  end;

  TSUMPayDeductionForSTP = class(TSUMPayForSTPBase)
  private
    function GetPayId                : Integer   ;
    function GetIsWorkPlacegiving    : Boolean   ;
    function Getamount               : Double    ;
    function GetYTDMoneyAmount : Double    ;
    function GetIsChildSupportGarnishee : boolean;
    function GetIsChildSupportDeduction: boolean;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property PayId                 :Integer     read GetPayId               ;
    property IsWorkPlacegiving     :Boolean     read GetIsWorkPlacegiving   ;
    property amount                :Double      read Getamount              ;
    property YTDMoneyAmount  :Double      read GetYTDMoneyAmount;
    property IsChildSupportGarnishee : Boolean read GetIsChildSupportGarnishee;
    property IsChildSupportDeduction: boolean read GetIsChildSupportDeduction;
  end;



implementation


uses ErpDBComponents, tcDataUtils, CommonLib,SysUtils, DateUtils, BusObjPayBase,
  LogLib, tcConst;


  {TSUMPayAllowanceForSTP}

constructor TSUMPayAllowanceForSTP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SUMPayAllowanceForSTP';
  fSQL := 'SELECT PA.PayId, '+
         ' if(PA.AllowanceType="Other" , PA.AllowanceType , "")  AS AllowanceType,'+
         ' if(PA.AllowanceType="Other" , "T" , "F")  AS IsOther, '+
         ' if(PA.AllowanceType="Other" , A.Description , "")  AS Description, '+
         ' sum(PA.Amount) AS Amount ,'+NL+
         ' SUM((select sum(spa.MoneyAmount) as Amount '+
               ' from tblpaysallowances spa '+
               ' inner join tblpays sp on sp.PayID = spa.PayID and sp.Paid = "T" '+
               ' and sp.Deleted = "F" '+
               ' and sp.EmployeeId =:EmployeeId '+
               ' and sp.PayDate between :DateFrom and :DAteTo '+
               ' where spa.AllowanceID = pa.AllowanceID)) AS YTDMoneyAmount '+NL+
         ' FROM tblpaysallowances PA '+
         ' LEFT JOIN tblallowances A ON PA.AllowanceID = A.AllowanceID '+
         ' Where PA.PayId =:PayId and PA.DisplayIn = '+ quotedstr('Allowances')+
         ' GROUP BY PA.PayId, '+
         ' if(PA.AllowanceType="Other" , "T" , "F")  , '+
         ' if(PA.AllowanceType="Other" , A.Description , "") ';
  IsReadonly := True;
end;


destructor TSUMPayAllowanceForSTP.Destroy;
begin
  inherited;
end;

procedure TSUMPayAllowanceForSTP.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PayId' ,PayId);
  AddXMLNode(node,'IsOther' ,IsOther);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'AllowanceType' ,AllowanceType);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'YTDMoneyAmount' ,YTDMoneyAmount);
end;


function TSUMPayAllowanceForSTP.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TSUMPayAllowanceForSTP.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSUMPayAllowanceForSTP.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

function TSUMPayAllowanceForSTP.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSUMPayAllowanceForSTP.GetIDField: string;
begin
  Result := 'PA.PayId'
end;


class function TSUMPayAllowanceForSTP.GetBusObjectTablename: string;
begin
  Result:= 'tblpaysallowances';
end;

{Property Functions}
function  TSUMPayAllowanceForSTP.GetPayId      : Integer   ; begin Result := GetIntegerField('PayId');end;
function  TSUMPayAllowanceForSTP.GetIsOther    : Boolean   ; begin Result := GetBooleanField('IsOther');end;
function  TSUMPayAllowanceForSTP.GetDescription: string    ; begin Result := GetStringField('Description');end;
function  TSUMPayAllowanceForSTP.GetAllowanceType: string    ; begin Result := GetStringField('AllowanceType');end;
function  TSUMPayAllowanceForSTP.GetAmount     : Double    ; begin Result := GetFloatField('Amount');end;
function  TSUMPayAllowanceForSTP.GetYTDMoneyAmount : Double    ; begin Result := GetFloatField('YTDMoneyAmount');end;


  {TSUMPayDeductionForSTP}

constructor TSUMPayDeductionForSTP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SUMPayDeductionForSTP';
  fSQL := 'SELECT PayId , '+
          ' IsWorkPlacegiving, '+
          ' (select sum(sPD.MoneyAmount) as Amount '+NL+
                  ' from tblpaysdeductions spd'+
                  ' inner join tblpays sp on SP.PayID = sPD.PayID and SP.Paid = "T" '+
                  ' and SP.EmployeeId =:EmployeeId '+
                  ' and SP.Deleted = "F" '+
                  ' and SP.PayDate between :DateFrom and :Dateto'+
                  ' where sPD.DeductionID =PD.DeductionID ) as YTDMoneyAmount,'+NL+
          ' SUM(amount) AS amount  '+
          ' FROM tblpaysdeductions PD '+
          ' where PD.payid = :PayID '+
          ' GROUP BY PayId , IsWorkPlacegiving';
  IsReadonly := True;
end;


destructor TSUMPayDeductionForSTP.Destroy;
begin
  inherited;
end;


procedure TSUMPayDeductionForSTP.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PayId' ,PayId);
  AddXMLNode(node,'IsWorkPlacegiving' ,IsWorkPlacegiving);
  AddXMLNode(node,'amount' ,amount);
end;


function TSUMPayDeductionForSTP.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TSUMPayDeductionForSTP.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSUMPayDeductionForSTP.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

function TSUMPayDeductionForSTP.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSUMPayDeductionForSTP.GetIDField: string;
begin
  Result := 'PayId'
end;


class function TSUMPayDeductionForSTP.GetBusObjectTablename: string;
begin
  Result:= 'tblpaysdeductions';
end;


{Property Functions}
function  TSUMPayDeductionForSTP.GetPayId            : Integer   ; begin Result := GetIntegerField('PayId');end;
function  TSUMPayDeductionForSTP.GetIsWorkPlacegiving: Boolean   ; begin Result := GetBooleanField('IsWorkPlacegiving');end;
function  TSUMPayDeductionForSTP.Getamount           : Double    ; begin Result := GetFloatField('amount');end;
function  TSUMPayDeductionForSTP.GetYTDMoneyAmount   : Double    ; begin Result := GetFloatField('YTDMoneyAmount');end;
function TSUMPayDeductionForSTP.GetIsChildSupportGarnishee : boolean; begin Result := GetBooleanField('ChildSupportGarnishee');end;
function TSUMPayDeductionForSTP.GetIsChildSupportDeduction: boolean; begin Result := GetBooleanField('ChildSupportDeduction');end;
{ TSUMPayForSTPBase }

constructor TSUMPayForSTPBase.Create(AOwner: TComponent);
begin
  inherited;
  fdtYTDMoneyAmountFrom := 0;
  fdtPayrunDate := 0;
  fiPayIDforInst := 0;
  PayDatefilterUsesTime := true;
end;

function TSUMPayForSTPBase.DoBeforeOpen(Dataset: TDataset): Boolean;
begin
  with TERPQuery(Dataset) do begin
    if PayDatefilterUsesTime then begin
      Parambyname('DateFrom').asDatetime  := Dateof(YTDMoneyAmountFrom);
      Parambyname('DateTo').asDatetime    := Dateof(PayrunDate);//Dateof(IncYear(YTDMoneyAmountFrom,1)-1);
    end else begin
      Parambyname('DateFrom').asDate  := Dateof(YTDMoneyAmountFrom);
      Parambyname('DateTo').asDate    := Dateof(PayrunDate);//Dateof(IncYear(YTDMoneyAmountFrom,1)-1);
    end;


    Parambyname('PayId').asInteger      := PayIDforInst;
    Parambyname('EmployeeId').asInteger := 0;
    if Assigned(Self.Owner) then
      if Self.Owner is Tpaybase then
        Parambyname('EmployeeId').asInteger    := Tpaybase(Self.Owner).EmployeeId;
    logtext(SQLTExt);
  end;
end;

{ TSUMPayTopUptoJobKeepersAllowanceForSTP }

constructor TSUMPayTopUptoJobKeepersAllowanceForSTP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SUMPayTopUptoJobKeepersAllowanceForSTP';
  fSQL := 'SELECT P.PayId, '+
         ' P.TopUptoJobKeepersAllowance AS Amount ,'+NL+
         ' SUM((select sum(SP.TopUptoJobKeepersAllowance) as Amount '+
               ' from tblpays sp where sp.Paid = "T" '+
               ' and sp.Deleted = "F" '+
               ' and sp.EmployeeId =:EmployeeId '+
               ' and sp.PayDate between :DateFrom and :DAteTo )) AS YTDMoneyAmount '+NL+
         ' FROM tblpays P '+
         ' Where P.PayId =:PayId '+
         ' GROUP BY P.PayId';
  IsReadonly := True;
  PayDatefilterUsesTime := False;
end;
function  TSUMPayTopUptoJobKeepersAllowanceForSTP.GetPayId      : Integer   ; begin Result := GetIntegerField('PayId');end;
function  TSUMPayTopUptoJobKeepersAllowanceForSTP.GetAmount     : Double    ; begin Result := GetFloatField('Amount');end;
function  TSUMPayTopUptoJobKeepersAllowanceForSTP.GetYTDMoneyAmount : Double    ; begin Result := GetFloatField('YTDMoneyAmount');end;
class function TSUMPayTopUptoJobKeepersAllowanceForSTP.GetIDField: string;
begin
  Result := 'P.PayId'
end;


class function TSUMPayTopUptoJobKeepersAllowanceForSTP.GetBusObjectTablename: string;
begin
  Result:= 'tblpays';
end;


initialization
  RegisterClass(TSUMPayDeductionForSTP);
  RegisterClass(TSUMPayAllowanceForSTP);
  RegisterClass(TSUMPayTopUptoJobKeepersAllowanceForSTP);


end.
