unit BusObjPaysAllowances;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   10/08/07   1.00.01   A.   Initial Version.
   }


interface
{$I ERP.inc}

uses BusObjBase, DB, Classes, BusObjAllowances, XMLDoc, XMLIntf;


type
   Tpaysallowances = class(TMSBusObj)

   private
      fAllowance: TAllowance;
      fTotalAllowances                :Double;
      fTotalGrossExcludeAllowances: double;
      fAllowancesBeforeTax            :Double;
      fAllowancesAfterTax             :double;
      fAllowancesIncludedInSuper      :double;

      Function GetPayid               :Integer   ;
      Function GetAllowanceid         :Integer   ;
      Function GetQty                 :Double    ;
      Function GetBasedonid           :Integer   ;
      Function GetAmount              :Double    ;
      Function GetCalcby              :String   ;
      Function GetArea                :String   ;
      Function GetSuperinc            :Boolean   ;
      Function GetTaxexempt           :Boolean   ;
      Function GetClientid            :Integer   ;
      Function GetClassID             :Integer   ;
      Function GetClassname           :String    ;
      Function GetMoneyamount         :Double    ;
      Procedure SetPayid               (Const Value :Integer   );
      Procedure SetAllowanceid         (Const Value :Integer   );
      Procedure SetQty                 (Const Value :Double    );
      Procedure SetBasedonid           (Const Value :Integer   );
      Procedure SetAmount              (Const Value :Double    );
      Procedure SetCalcby              (Const Value :String    );
      Procedure SetArea                (Const Value :String    );
      Procedure SetSuperinc            (Const Value :Boolean   );
      Procedure SetTaxexempt           (Const Value :Boolean   );
      Procedure SetClientid            (Const Value :Integer   );
      Procedure setClassID             (Const Value :Integer   );
      Procedure SetClassname           (Const Value :String    );
      Procedure SetMoneyamount         (Const Value :Double    );

      procedure CallBackTotalAllowances(const Sender: TBusObj; var Abort: Boolean);
      procedure CallBackTotalGrossExcludeAllowances(const Sender: TBusObj; var Abort: Boolean);
      procedure CallBackAllowancesBeforeTax(const Sender: TBusObj; var Abort: Boolean);
      procedure CallBackAllowancesAfterTax(const Sender: TBusObj; var Abort: Boolean);
      procedure CallBackAllowancesIncludedInSuper(const Sender: TBusObj; var Abort: Boolean);
      procedure CallbackPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
//      procedure CallbackUnPostToAccounts(const Sender: TBusObj; var Abort: Boolean);

      Function GetAllowancesBeforeTax:double;
      Function GetAllowancesAfterTax:double;
      Function GetAllowancesIncludedInSuper:double;
      Function GetTotalAllowances:double;
    function GetAllowanceDescription: string;
    function GetAllowanceType: string;
    procedure SetAllowanceType(const Value: string);
    function GetDisplayIn: String;
    procedure SetDisplayIn(const Value: String);
    function GetGrossExcludeTotalAllowances: Double;


   Protected
      Function GetIsList: Boolean; Override;

      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;
      Function  DoBeforePost(Sender :TDatasetBusObj ):Boolean;             Override;


   Public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;
      procedure AddAllowanceDetails;
      procedure PostToAccounts;
//      procedure UnPostToAccounts;

      function getAllowance: TAllowance;


      Property Payid                :Integer      Read getPayid             Write SetPayid         ;
      Property Allowanceid          :Integer      Read getAllowanceid       Write SetAllowanceid   ;
      Property Qty                  :Double       Read GetQty               Write SetQty           ;
      Property Basedonid            :Integer      Read getBasedonid         Write SetBasedonid     ;
      Property Amount               :Double       Read getAmount            Write SetAmount        ;
      Property Calcby               :String       Read getCalcby            Write SetCalcby        ;
      Property Area                 :String       Read getArea              Write SetArea          ;
      Property Superinc             :Boolean      Read getSuperinc          Write SetSuperinc      ;
      Property Taxexempt            :Boolean      Read getTaxexempt         Write SetTaxexempt     ;
      Property Clientid             :Integer      Read getClientid          Write SetClientid      ;
      Property Classid              :Integer      Read GetClassID           Write setClassID       ;
      Property DepartmentName       :String       Read getClassname         Write SetClassname     ;
      Property Moneyamount          :Double       Read getMoneyamount       Write SetMoneyamount   ;


      Property TotalAllowances                  :Double  Read GetTotalAllowances ;
      { this is a total of allowances that have  DisplayIn = "Allowance"
        ie allowances that are going to be showen seperatly on Summary Report }
      Property TotalGrossExcludeAllowances      :Double  Read GetGrossExcludeTotalAllowances ;
      Property TotalAllowancesBeforeTax         :Double  Read GetAllowancesBeforeTax;
      Property TotalAllowancesAfterTax          :Double  Read GetAllowancesAfterTax;
      Property TotalAllowancesIncludedInSuper   :Double  Read GetAllowancesIncludedInSuper;
      property AllowanceDescription: string read GetAllowanceDescription;
      function YTDMoneyAmount(const aDate: TDateTime): double;
      { ATO allowance categorisation, one of
          Car, Transport, Laundry, Meals, Travel, Other }
      property AllowanceType: string read GetAllowanceType write SetAllowanceType;
      { One of 'Allowances','Gross','Do Not Display' }
      Property DisplayIn: String Read GetDisplayIn Write SetDisplayIn;
   End;


implementation


uses SysUtils,BusObjPaybase,BusObjConst,AppEnvironment, PayCommon,DateUtils,DnMLib,
  CommonLib, tcDataUtils, PayPreferencesObj, PayAccounts, ERPDbComponents,
  DateTimeUtils, PayConst;


{========================================================
         Tpaysallowances
========================================================}
constructor Tpaysallowances.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblpaysallowances';
   fAllowance := TAllowance.Create(Self);
   fAllowance.Connection := Self.Connection;
   fAllowance.SilentMode := Self.SilentMode;
end;


function Tpaysallowances.GetAllowance: TAllowance;
begin

   result := TAllowance(GetContainerComponent(TAllowance, 'AllowanceID = ' + IntToStr(AllowanceID)));


//   result := fAllowance;
end;




Function Tpaysallowances.GetIsList: Boolean;
Begin
  Result := Inherited;
  if not result then
  	if assigned(Owner) then
  		if owner is TPaybase then
  			Result := True;
End;



procedure Tpaysallowances.PostToAccounts;
begin
  Self.IterateRecords(CallbackPostToAccounts,False);
end;

//procedure Tpaysallowances.UnPostToAccounts;
//begin
//  Self.IterateRecords(CallbackUnPostToAccounts,False);
//end;

procedure Tpaysallowances.CallBackPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
var
  CreditAccID: integer;
  DebitAccID: integer;
  sMSType:string;
begin
  //CreditAccID := tcDataUtils.getAllowanceAccountID(AllowanceID);
//  DebitAccID   := AppEnv.PayPrefs.AllowanceLiabilityAccountID;

  CreditAccID := tcDataUtils.getAllowanceAccountID(AllowanceID);
  DebitAccID   := PayAccounts.BankAccountID(Tpaybase(Self.Owner).Employeeid); //tcDataUtils.GetAccountID('Payroll Bank Clearing');

  if TaxExempt then begin
    sMSType := MSType_AllowancesTaxExempt;
  end else begin
    sMSType := MSType_Allowances;
  end;

  Tpaybase(Self.Owner).PayTrans.LoadSelect('PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
               ' AND Type = "Payroll Allowances" AND MSType = ' + QuotedStr(sMSType) +
               ' AND Description = ' + QuotedStr('Allowance - '+ GetAllowanceName(AllowanceID)) +
               ' AND PayLineID = ' + IntToStr(ID));

  Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions(7,'Payroll Allowances', sMSType,
               'Allowance - ' + GetAllowanceName(AllowanceID),CreditAccID,DebitAccID,
                ClassID, ID,-(MoneyAmount - TPaybase(Self.Owner).PayTotals.TaxableTotals.TotalTaxForRateAndLineID('Allowance',self.ID)), self);

end;

Function Tpaysallowances.GetAllowancesBeforeTax:double;
begin
  fAllowancesBeforeTax := 0;
  Self.IterateRecords(CallbackAllowancesBeforeTax,False);
  Result := fAllowancesBeforeTax;
end;

Function Tpaysallowances.GetAllowancesAfterTax:double;
begin
  fAllowancesAfterTax := 0;
  Self.IterateRecords(CallBackAllowancesAfterTax,False);
  Result := fAllowancesAfterTax;
end;

Function Tpaysallowances.GetTotalAllowances:double;
begin
  fTotalAllowances := 0;
  Self.IterateRecords(CallBackTotalAllowances,False);
  Result := fTotalAllowances;
end;

Function Tpaysallowances.GetAllowancesIncludedInSuper:double;
begin
  fAllowancesIncludedInSuper := 0;
  Self.IterateRecords(CallbackAllowancesIncludedInSuper,False);
  Result := fAllowancesIncludedInSuper;
end;

function Tpaysallowances.GetAllowanceType: string;
begin
  result := GetStringField('AllowanceType');
end;

procedure Tpaysallowances.CallBackTotalAllowances(const Sender: TBusObj; var Abort: Boolean);
begin
  fTotalAllowances := fTotalAllowances + TPaysAllowances(Sender).Moneyamount;
end;

procedure Tpaysallowances.CallBackTotalGrossExcludeAllowances(
  const Sender: TBusObj; var Abort: Boolean);
begin
  if SameText(TPaysAllowances(Sender).DisplayIn,'Allowances') then
    fTotalGrossExcludeAllowances := fTotalGrossExcludeAllowances + TPaysAllowances(Sender).Moneyamount;
end;

procedure Tpaysallowances.CallBackAllowancesBeforeTax(const Sender: TBusObj; var Abort: Boolean);
begin
  if not TaxExempt then fAllowancesBeforeTax := fAllowancesBeforeTax +  TPaysAllowances(Sender).Moneyamount;
end;

procedure Tpaysallowances.CallBackAllowancesAfterTax(const Sender: TBusObj; var Abort: Boolean);
begin
  if TaxExempt then fAllowancesAfterTax := fAllowancesAfterTax +  TPaysAllowances(Sender).Moneyamount;
end;

procedure Tpaysallowances.CallBackAllowancesIncludedInSuper(const Sender: TBusObj; var Abort: Boolean);
begin
  if SuperInc then fAllowancesIncludedInSuper := fAllowancesIncludedInSuper + TPaysAllowances(Sender).Moneyamount;
end;


destructor Tpaysallowances.Destroy;
begin
   inherited;
   
end;

procedure Tpaysallowances.AddAllowanceDetails;
begin
  try
    fAllowance.Load(AllowanceID);
    Qty := 1;
    TaxExempt := fAllowance.Taxexempt;
    Amount := fAllowance.Amount;
    CalcBy := fAllowance.Calcby;
    Area := fAllowance.Area;
    BasedOnID := fAllowance.Basedonid;
    self.Superinc:= fAllowance.Superinc;
    AllowanceType := fAllowance.AllowanceType;
    DisplayIn := fAllowance.DisplayIn;
    DepartmentName := Tpaybase(Self.Owner).EmployeeDetails.Defaultclassname;
  except 
  end;
end;

Function  Tpaysallowances.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
      if Self.Owner is Tpaybase then begin
        PayId := Tpaybase(Self.Owner).ID;
        DepartmentName := Tpaybase(Self.Owner).EmployeeDetails.Defaultclassname;
        ClassID := GetDeptID(DepartmentName);
      end;
    Result := inherited DoAfterInsert(Sender);
end;

procedure   Tpaysallowances.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Payid');
  SetPropertyFromNode(Node,'Allowanceid');
  SetPropertyFromNode(Node,'Qty');
  SetPropertyFromNode(Node,'Basedonid');
  SetPropertyFromNode(Node,'Amount');
  SetPropertyFromNode(Node,'Calcby');
  SetPropertyFromNode(Node,'Area');
  SetBooleanPropertyFromNode(Node,'Superinc');
  SetBooleanPropertyFromNode(Node,'Taxexempt');
  SetPropertyFromNode(Node,'Clientid');
  SetPropertyFromNode(Node,'Classid');
  SetPropertyFromNode(Node,'Classname');
  SetPropertyFromNode(Node,'Moneyamount');
end;


procedure   Tpaysallowances.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Payid' ,Payid);
  AddXMLNode(node,'Allowanceid' ,Allowanceid);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'Basedonid' ,Basedonid);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Calcby' ,Calcby);
  AddXMLNode(node,'Area' ,Area);
  AddXMLNode(node,'Superinc' ,Superinc);
  AddXMLNode(node,'Taxexempt' ,Taxexempt);
  AddXMLNode(node,'Clientid' ,Clientid);
  AddXMLNode(node,'Classid' ,Classid);
  AddXMLNode(node,'DepartmentName' ,DepartmentName);
  AddXMLNode(node,'Moneyamount' ,Moneyamount);
end;


function    Tpaysallowances.ValidateData :Boolean ;
var
  tmpResultStatus: TResultStatusItem;
begin
   Result := False;
   Resultstatus.Clear;
   Try
     if Allowanceid = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_PayAllowance_Err_NoDescription,  'Allowance should not be blank' );
        Exit;
     end;
     if Qty = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_PayAllowance_Err_NoQty,  'Allowance Qty should not be 0'  );
        Exit;
     end;
     if Basedonid = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_PayAllowance_Err_NoBasedOnID,  'Based on should not be blank' );
        Exit;
     end;
     if Amount = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_PayAllowance_Err_NoAmount,  'Amount should not be 0'  );
        Exit;
     end;
     if DepartmentName = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_PayAllowance_Err_NoDepartment,  'Department name should not be blank' );
        Exit;
     end;
     if CalcBy = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_PayAllowance_Err_NoCalcBy,  'CalcBy should not be blank' , False );
        Exit;
     end;
     Result := true;
   Finally
    If not Result then Begin
      tmpResultStatus := ResultStatus.GetLastStatusItem;
      if Assigned(tmpResultStatus) then
        TBusobj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code),BusobjEventVal_FailedAllowancesValidateData);
    end;
   end;
end;


function Tpaysallowances.YTDMoneyAmount(const aDate: TDateTime): double;
var
  strFrom, strTo: string;
  dtFrom: TDateTime;
  qry: TERPQuery;
begin
  dtFrom := FiscalYearStart(aDate, AppEnv.CompanyPrefs.FiscalYearStarts);
  strFrom := FormatDateTime('yyyy-mm-dd',dtFrom);
  strTo := FormatDateTime('yyyy-mm-dd',IncYear(dtFrom,1)-1);
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := Connection.Connection;
    qry.SQL.Add('select sum(pa.MoneyAmount) as Amount from tblpaysallowances pa');
    qry.SQL.Add('inner join tblpays p on p.PayID = pa.PayID and p.Paid = "T"');
    qry.SQL.Add('and p.Deleted = "F"');
    qry.SQL.Add('and p.PayDate between ' + QuotedStr(strFrom) + ' and ' + QuotedStr(strTo));
    qry.SQL.Add('where pa.AllowanceID = ' + IntToStr(AllowanceID));

    qry.Open;
    result := qry.FieldByName('Amount').AsFloat;
  finally
    qry.Free;
  end;
end;

function    Tpaysallowances.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure Tpaysallowances.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure Tpaysallowances.DoFieldOnChange(Sender: TField);
var
  iDays,iWeeks:integer;
  amt: double;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
  if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName , 'Classname') then begin
    ClassID := tcDatautils.GetDeptID(DepartmentName);
  end;
   if (Sysutils.SameText(Sender.FieldName , 'Qty'))
     or (Sysutils.SameText(Sender.FieldName , 'CalcBy'))
     or (Sysutils.SameText(Sender.FieldName , 'Amount'))
     or (Sysutils.SameText(Sender.FieldName , 'Taxexempt'))
     or (Sysutils.SameText(Sender.FieldName , 'BasedOnID'))
   then begin
//     if FindInSet(GetBasedOnName(BasedOnID), 'None,Km,Items,Week,Hours,Day') then begin
//       if CalcBy = '%' then begin
//         SendEvent(BusobjEventVal_HandleCalcByConflict,BusObjEvent_Change );
//         exit;
//       end;
//     end;

     if (CalcBy = '$') or (CalcBy = '£') then begin
       if (BasedOnID  = PayCommon.GetBasedOnID('None'))
         or (BasedOnID = PayCommon.GetBasedOnID('Pays'))
         or (BasedOnID = PayCommon.GetBasedOnID('Km'))
         or (BasedOnID = PayCommon.GetBasedOnID('Items'))
         or (BasedOnID = PayCommon.GetBasedOnID('Hours'))
        then begin
         MoneyAmount := Qty * Amount;
       end else if BasedOnID = PayCommon.GetBasedOnID('Day') then begin
         iDays := DaysBetweenSigned(Tpaybase(Self.Owner).Paydate + 1, Tpaybase(Self.Owner).PayFromDate );
         MoneyAmount := Qty * iDays * Amount;
       end else if BasedOnID = PayCommon.GetBasedOnID('Week') then begin
         iWeeks := WeeksBetweenSigned(Tpaybase(Self.Owner).Paydate + 1, Tpaybase(Self.Owner).PayFromDate );
         MoneyAmount := Qty * iWeeks * Amount;
       end;
     end
     else if CalcBy = '%' then begin //MoneyAmount := Amount * Tpaybase(Self.Owner).Wages /100;
       if PayCommon.GetBasedOnRate(self.Basedonid,Tpaybase(Self.Owner).PayID,amt,self.Connection.Connection) then begin
         MoneyAmount:= amt * self.Qty * (Amount /100);
       end
       else begin
         MoneyAmount:= 0;
         if Sysutils.SameText(Sender.FieldName , 'BasedOnID') then
           SendEvent(BusObjEvent_Change, BusobjEventVal_HandleNoAllowanceBasedOn);
       end;
     end;
     PostDb;
     Tpaybase(Self.Owner).RecalcAll;
   end;
end;


Function Tpaysallowances.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  Tpaysallowances.GetIDField : String;
begin
   Result := 'Payallowanceid'
end;

class function Tpaysallowances.GetBusObjectTablename: string;
begin
  Result := 'tblpaysallowances';
end;


Function  Tpaysallowances.DoBeforePost(Sender :TDatasetBusObj ):Boolean;
begin

  Result := inherited DoBeforePost(sender);
end;

Function  Tpaysallowances.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin

   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  Tpaysallowances.GetPayid         :Integer   ; begin Result := GetIntegerField('Payid');End;

function Tpaysallowances.GetAllowanceDescription: string;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := Connection.Connection;
    qry.SQL.Text := 'select Description from tblallowances where AllowanceID = ' + IntToStr(AllowanceID);
    qry.Open;
    result := qry.FieldByName('Description').AsString;
  finally
    qry.Free;
  end;
end;

Function  Tpaysallowances.GetAllowanceid   :Integer   ; begin Result := GetIntegerField('Allowanceid');End;
Function  Tpaysallowances.GetQty           :Double    ; begin Result := GetFloatField('Qty');End;
Function  Tpaysallowances.GetBasedonid     :Integer   ; begin Result := GetIntegerField('Basedonid');End;
Function  Tpaysallowances.GetAmount        :Double    ; begin Result := GetFloatField('Amount');End;
Function  Tpaysallowances.GetCalcby        :String    ; begin Result := GetStringField('Calcby');End;
Function  Tpaysallowances.GetArea          :String    ; begin Result := GetStringField('Area');End;
Function  Tpaysallowances.GetSuperinc      :Boolean   ; begin Result := GetBooleanField('Superinc');End;
Function  Tpaysallowances.GetTaxexempt     :Boolean   ; begin Result := GetBooleanField('Taxexempt');End;
Function  Tpaysallowances.GetClientid      :Integer   ; begin Result := GetIntegerField('Clientid');End;
function Tpaysallowances.GetDisplayIn: String;
begin
  result := GetStringField('DisplayIn');
end;

function Tpaysallowances.GetGrossExcludeTotalAllowances: Double;
begin
  fTotalGrossExcludeAllowances := 0;
  Self.IterateRecords(CallBackTotalGrossExcludeAllowances,False);
  Result := fTotalGrossExcludeAllowances;
end;

Function  Tpaysallowances.GetClassID       :Integer   ; begin Result := GetIntegerField('Classid');End;
Function  Tpaysallowances.GetClassname     :String    ; begin Result := GetStringField('Classname');End;
Function  Tpaysallowances.GetMoneyamount   :Double    ; begin Result := GetFloatField('Moneyamount');End;
Procedure Tpaysallowances.SetPayid         (Const Value :Integer   ); begin SetIntegerField('Payid'          , Value);End;
Procedure Tpaysallowances.SetAllowanceid   (Const Value :Integer   ); begin SetIntegerField('Allowanceid'    , Value);End;
procedure Tpaysallowances.SetAllowanceType(const Value: string);
begin
  SetStringField('AllowanceType', Value);
end;

Procedure Tpaysallowances.SetQty           (Const Value :Double    ); begin SetFloatField('Qty'            , Value);End;
Procedure Tpaysallowances.SetBasedonid     (Const Value :Integer   ); begin SetIntegerField('Basedonid'      , Value);End;
Procedure Tpaysallowances.SetAmount        (Const Value :Double    ); begin SetFloatField('Amount'         , Value);End;
Procedure Tpaysallowances.SetCalcby        (Const Value :String    ); begin SetStringField('Calcby'         , Value);End;
Procedure Tpaysallowances.SetArea          (Const Value :String    ); begin SetStringField('Area'         , Value);End;
Procedure Tpaysallowances.SetSuperinc      (Const Value :Boolean   ); begin SetBooleanField('Superinc'       , Value);End;
Procedure Tpaysallowances.SetTaxexempt     (Const Value :Boolean   ); begin SetBooleanField('Taxexempt'      , Value);End;
Procedure Tpaysallowances.SetClientid      (Const Value :Integer   ); begin SetIntegerField('Clientid'       , Value);End;
procedure Tpaysallowances.SetDisplayIn(const Value: String);
begin
  SetStringField('DisplayIn', Value);
end;

Procedure Tpaysallowances.setClassID       (Const Value :Integer   ); begin SetIntegerField('Classid'        , Value);End;
Procedure Tpaysallowances.SetClassname     (Const Value :String    ); begin SetStringField('Classname'      , Value);End;
Procedure Tpaysallowances.SetMoneyamount   (Const Value :Double    ); begin SetFloatField('Moneyamount'    , Value);End;


initialization
RegisterClassOnce(Tpaysallowances);


end.
