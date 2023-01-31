unit BusObjPaysSuperannuation;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   14/08/07   1.00.01   A.   Initial Version.
   }
   {                }

interface

uses BusObjBase, DB, Classes, BusObjBenefitsBase, XMLDoc, XMLIntf;

type
   TPaysSuperannuation = class(TBenefitsBase)

   private
      fdTotalSuper                      :double;
      fdSGCTotal                        :double;
//      fdSGCTotalNoSuperThreshold        :double;
      fdEmployerOptionalTotal           :double;
      fdEmployerNegativeTotal           :double;
      fdSalarySacrificeTotal            :double;
      fdEmployeeOptionalTotal           :double;
      fdEmployeeNegativeTotal           :double;
      fdSpouseContributionTotal         :double;

      fdAmountIncludedInSuper           :double;
      fdAmountIncludedInSuperLessSalarySacrifice: double;
      fdMTDTotalSGC: double;
      fiEmployeeAge                     :integer;

//      fTotalSuperPaid                 :double;
      iRecalcLinePassNo: integer;
      bContainsSGCLines: boolean;
//      bBelowthreshold: boolean;
//      Function GetTotalSuperPaid      :double;

      Function GetPayid               :Integer   ;
      Function GetSuperid             :Integer   ;
      Function GetSupertypeid         :Integer   ;
      Function GetClientid            :Integer   ;
      Function GetAccountno           :String    ;
      Function GetDatejoined          :TDatetime ;
      Function GetAmount              :Double    ;
      Function GetCalcby              :String   ;
      Function GetArea                :String   ;
      Function GetAmountpaid          :Double    ;
      Function GetBelowthreshold      :Boolean   ;
      Function GetClassID             :Integer   ;
      Function GetClassname           :String    ;
      Function GetAllclasses          :Boolean   ;
      Function GetThisPaysProportion  :Double;
      Function GetNonCatchUpAmount  :Double;

      Procedure SetPayid               (Const Value :Integer   );
      Procedure SetSuperid             (Const Value :Integer   );
      Procedure SetSupertypeid         (Const Value :Integer   );
      Procedure SetClientid            (Const Value :Integer   );
      Procedure SetAccountno           (Const Value :String    );
      Procedure SetDatejoined          (Const Value :TDatetime );
      Procedure SetAmount              (Const Value :Double    );
      Procedure SetCalcby              (Const Value :String   );
      Procedure SetArea                (Const Value :String   );
      Procedure SetAmountpaid          (Const Value :Double    );
      Procedure SetBelowthreshold      (Const Value :Boolean   );
      Procedure setClassID             (Const Value :Integer   );
      Procedure SetClassname           (Const Value :String    );
      Procedure SetAllclasses          (Const Value :Boolean   );
      Procedure SetThisPaysProportion  (Const Value :Double    );
      Procedure SetNonCatchUpAmount   (Const Value :Double    );

//      procedure CallbackTotalSuperPaid(const Sender: TBusObj; var Abort: Boolean);
//      procedure CallbackSubtractPaids(const Sender: TBusObj; var Abort: Boolean);
//      procedure CallbackSuperCalcs(const Sender: TBusObj; var Abort: Boolean);
//      procedure CallbackSetFieldVars(const Sender: TBusObj; var Abort: Boolean);
//      procedure CallbackSalarySacrificeCalcs(const Sender: TBusObj; var Abort: Boolean);
      procedure CallbackPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
      procedure CallbackUnPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
//      function GetMonthWageTotalForSuper:Double;
//      function GetMonthAllowancesTotalForSuper:Double;
//      function GetMonthCommissionsTotalForSuper:Double;
//      function GetMonthsSalarySacrificeTotal:Double;
//      function GetMonthlySuper(iSuperTypeId: integer):Double;
      procedure RemoveZeroTotalEntries;

      procedure CallbackCalcLine(const Sender: TBusObj; var Abort: Boolean);
      procedure CallbackCalcSalarySacrificeLine(const Sender: TBusObj; var Abort: Boolean);
      function GetMTDCatchupAmount(iSuperTypeId: integer):Double;
      function GetMTDPaidAmount(iSuperTypeId: integer):Double;
      function GetMTDWageTotalForSuper: double;
      function GetMTDAllowancesTotalForSuper: double;
      function GetMTDCommissionsTotalForSuper: double;
      function GetMTDSalarySacrificeTotal:Double;
      function UpdateData: boolean;
    function GetSuperTypeName: string;


     function GetSuperEntitlementCode: string;



   protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;


   public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                 override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
//      procedure    ReCalc;                                                 Override;
      procedure    ReCalc;                                                 override;
      function     GetSuperThresholdAmount: double;
      procedure PostToAccounts; Override;
      procedure UnPostToAccounts; Override;





   Published

      Property Payid                :Integer      Read getPayid             Write SetPayid         ;

      Property Superid              :Integer      Read getSuperid           Write SetSuperid       ;
      Property SuperTypeID          :Integer      Read getSupertypeid       Write SetSupertypeid   ;
      property SuperTypeName: string read GetSuperTypeName;

      property SuperEntitlementCode: string read GetSuperEntitlementCode;

      Property Clientid             :Integer      Read getClientid          Write SetClientid      ;
      Property Accountno            :String       Read getAccountno         Write SetAccountno     ;
      Property Datejoined           :TDatetime    Read getDatejoined        Write SetDatejoined    ;
      Property Amount               :Double       Read getAmount            Write SetAmount        ;
      Property Calcby               :String       Read getCalcby            Write SetCalcby        ;
      Property Area                 :String       Read getArea              Write SetArea          ;
      Property Amountpaid           :Double       Read getAmountpaid        Write SetAmountpaid    ;
      Property Belowthreshold       :Boolean      Read getBelowthreshold    Write SetBelowthreshold;
      Property Classid              :Integer      Read GetClassID           Write setClassID       ;
      Property DepartmentName       :String       Read getClassname         Write SetClassname     ;
      Property Allclasses           :Boolean      Read getAllclasses        Write SetAllclasses    ;
      Property ThisPaysProportion   :Double       Read getThisPaysProportion Write SetThisPaysProportion;
      Property NonCatchUpAmount     :Double       Read GetNonCatchUpAmount  Write SetNonCatchUpAmount;

//      property TotalSuperPaid       :Double       Read fdTotalSuper; //GetTotalSuperPaid;

      Property TotalSuper           :Double       Read fdTotalSuper ;
//      Property TotalAmountIncludedInSuper :Double Read fdAmountIncludedinSuper ;
      property SalarySacrificeTotal :Double  Read fdSalarySacrificeTotal;

//      property SGCTotalNoSuperThreshold: double read fdSGCTotalNoSuperThreshold;
      property SGCTotal: double read fdSGCTotal;
      property EmployerOptionalTotal: double read fdEmployerOptionalTotal;
      property EmployerNegativeTotal: double read fdEmployerNegativeTotal;
      property EmployeeOptionalTotal: double read fdEmployeeOptionalTotal;
      property EmployeeNegativeTotal: double read fdEmployeeNegativeTotal;
      property SpouseContributionTotal: double read fdSpouseContributionTotal;
      function YTDAmountPaid(const aDate: TDateTime): double;

      class function YTDSuperGuarantee(const aDate: TDateTime; aEmployeeID: integer): double;

      class function YTDSuperGuaranteePaid(const aDate: TDateTime; aEmployeeID: integer): double;
      class function YTDOtherPaid(const aDate: TDateTime; aEmployeeID: integer): double;
      class function EmployerReportableTotal(const aPayID: integer): double;
      class function YTDEmployerReportableTotal(const aDate: TDateTime; aEmployeeID: integer): double;
      class function GetYTDSalarySacrificeTotal(const aDate: TDateTime; aEmployeeID: integer): double;
   end;

const
  SUPER_TYPE_SUPER_GUARANTEE = 'Super Guarantee';
  SUPER_TYPE_EMPLOYER_OPTIONAL = 'Employer Optional';
  SUPER_TYPE_EMPLOYER_NEGATIVE = 'Employer Negative';
  SUPER_TYPE_SALARY_SACRIFICE = 'Salary Sacrifice';
  SUPER_TYPE_EMPLOYEE_OPTIONAL = 'Employee Optional';
  SUPER_TYPE_EMPLOYEE_NEGATIVE = 'Employee Negative';
  SUPER_TYPE_SPOUSE_CONTRIBUTION = 'Spouse Contribution';


implementation


uses CommonLib,BusObjConst,BusObjPaybase,SysUtils,PayCommon,AppEnvironment,Dialogs,
     MyAccess,ERPdbComponents,Commondblib, tcDataUtils, DateUtils, PayAccounts,
     DateTimeUtils, PayConst, ClipBrd;


{ TPaysSuperannuation }


constructor Tpayssuperannuation.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblpayssuperannuation';
end;

procedure Tpayssuperannuation.PostToAccounts;
begin
  Self.IterateRecords(CallbackPostToAccounts,False);
end;

procedure Tpayssuperannuation.UnPostToAccounts;
begin
  Self.IterateRecords(CallbackUnPostToAccounts,False);
end;

function TPaysSuperannuation.UpdateData: boolean;
begin
  result:= not TPaybase(Self.Owner).Paid;
end;



function Tpayssuperannuation.GetSuperEntitlementCode: string;
var
  qry: TERPQuery;

begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    with qry do begin
      qry.Connection := TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection);
      SQL.Clear;
      SQL.Add('SELECT SuperTypeID, Description, EntitlementCode FROM tblsupertype WHERE SuperTypeID = ' + IntToStr(SuperTypeID));
      Open;
      if RecordCount <> 0 then begin
        result := FieldByName('EntitlementCode').AsString;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;





procedure Tpayssuperannuation.CallbackPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
var
  CreditAccID,CreditAccID_2: integer;
  DebitAccID,DebitAccID_2: integer;
begin
  if Self.AmountPaid = 0 then exit;

  CreditAccID := 0; {+}
  DebitAccID  := 0; {-}
  if FindInSet(GetSuperName(Tpayssuperannuation(Sender).SuperTypeID), 'Super Guarantee,Employer Optional') then begin
    CreditAccID := PayAccounts.SuperPayableAccountID(Tpaybase(Self.Owner).EmployeeID); {+ Liab}
    DebitAccID := PayAccounts.SuperPaidAccountID(Tpaybase(Self.Owner).EmployeeID); {- Expense}
  end else if FindInSet(GetSuperName(Tpayssuperannuation(Sender).SuperTypeID), 'Employer Negative') then begin
    CreditAccID := PayAccounts.SuperPayableAccountID(Tpaybase(Self.Owner).EmployeeID); {- Liab}
    DebitAccID := PayAccounts.SuperPaidAccountID(Tpaybase(Self.Owner).EmployeeID); {+ Expense}
  end else if FindInSet(GetSuperName(Tpayssuperannuation(Sender).SuperTypeID), 'Employee Optional,Spouse Contribution') then begin
    CreditAccID := PayAccounts.SuperPayableAccountID(Tpaybase(Self.Owner).EmployeeID); {+ Liab}
    DebitAccID := PayAccounts.BankAccountID(Tpaybase(Self.Owner).EmployeeID);  {- Net Pay}
  end else if FindInSet(GetSuperName(Tpayssuperannuation(Sender).SuperTypeID), 'Employee Negative') then begin
    CreditAccID := PayAccounts.SuperPayableAccountID(Tpaybase(Self.Owner).EmployeeID); {- Liab}
    DebitAccID :=  PayAccounts.BankAccountID(Tpaybase(Self.Owner).EmployeeID); {+ Net Pay}
  end else if FindInSet(GetSuperName(Tpayssuperannuation(Sender).SuperTypeID), SUPER_TYPE_SALARY_SACRIFICE) then begin
    CreditAccID := PayAccounts.SuperPayableAccountID(Tpaybase(Self.Owner).EmployeeID); {+ Liab}
    DebitAccID := PayAccounts.SuperPaidAccountID(Tpaybase(Self.Owner).EmployeeID); {- Expense}
    {Extra To Remove Salary Sacrifice From Gross}
    CreditAccID_2 := PayAccounts.GrossWagesAccountID(Tpaybase(Self.Owner).EmployeeID); {+ Gross Wages}
    DebitAccID_2  := PayAccounts.BankAccountID(Tpaybase(Self.Owner).EmployeeID); {- Net Pay}
    Tpaybase(Self.Owner).PayTrans.LoadSelect('PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
                                  ' AND Type = "Payroll Superannuation" AND MSType = "'+MSType_Superannuation+'"' +
                                  ' AND Description = '+ QuotedStr('Superannuation - '+ GetSuperName(Tpayssuperannuation(Sender).SuperTypeID)) +
                                  ' AND PayLineID = ' + IntToStr(ID)+
                                  ' AND (AccountID = ' + IntToStr(CreditAccID_2)+ ' OR AccountID = ' + IntToStr(DebitAccID_2)+ ')');

    Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions(15,'Payroll Superannuation',MSType_Superannuation,
                                  'Superannuation - ' + GetSuperName(Tpayssuperannuation(Sender).SuperTypeID),CreditAccID_2,
                                  DebitAccID_2,ClassID, ID,AmountPaid, self);
  end;

  Tpaybase(Self.Owner).PayTrans.LoadSelect('PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
                                ' AND Type = "Payroll Superannuation" AND MSType = "'+MSType_Superannuation+'"' +
                                ' AND Description = '+ QuotedStr('Superannuation - '+ GetSuperName(Tpayssuperannuation(Sender).SuperTypeID)) +
                                ' AND PayLineID = ' + IntToStr(ID)+
                                ' AND (AccountID = ' + IntToStr(CreditAccID)+ ' OR AccountID = ' + IntToStr(DebitAccID)+ ')');

  Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions(16,'Payroll Superannuation',MSType_Superannuation,
                                'Superannuation - ' + GetSuperName(Tpayssuperannuation(Sender).SuperTypeID),CreditAccID,
                                DebitAccID,ClassID, ID,AmountPaid, self);
end;

procedure Tpayssuperannuation.CallbackUnPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
var
  CreditAccID,CreditAccID_2: integer;
  DebitAccID,DebitAccID_2: integer;
begin
  if Self.AmountPaid = 0 then exit;

  CreditAccID := 0; {+}
  DebitAccID  := 0; {-}
  if FindInSet(GetSuperName(Tpayssuperannuation(Sender).SuperTypeID), 'Super Guarantee,Employer Optional') then begin
    CreditAccID := PayAccounts.SuperPayableAccountID(Tpaybase(Self.Owner).EmployeeID); {+ Liab}
    DebitAccID := PayAccounts.SuperPaidAccountID(Tpaybase(Self.Owner).EmployeeID); {- Expense}
  end else if FindInSet(GetSuperName(Tpayssuperannuation(Sender).SuperTypeID), 'Employer Negative') then begin
    CreditAccID := PayAccounts.SuperPayableAccountID(Tpaybase(Self.Owner).EmployeeID); {- Liab}
    DebitAccID := PayAccounts.SuperPaidAccountID(Tpaybase(Self.Owner).EmployeeID); {+ Expense}
  end else if FindInSet(GetSuperName(Tpayssuperannuation(Sender).SuperTypeID), 'Employee Optional,Spouse Contribution') then begin
    CreditAccID := PayAccounts.SuperPayableAccountID(Tpaybase(Self.Owner).EmployeeID); {+ Liab}
    DebitAccID := PayAccounts.BankAccountID(Tpaybase(Self.Owner).EmployeeID);  {- Net Pay}
  end else if FindInSet(GetSuperName(Tpayssuperannuation(Sender).SuperTypeID), 'Employee Negative') then begin
    CreditAccID := PayAccounts.SuperPayableAccountID(Tpaybase(Self.Owner).EmployeeID); {- Liab}
    DebitAccID :=  PayAccounts.BankAccountID(Tpaybase(Self.Owner).EmployeeID); {+ Net Pay}
  end else if FindInSet(GetSuperName(Tpayssuperannuation(Sender).SuperTypeID), SUPER_TYPE_SALARY_SACRIFICE) then begin
    CreditAccID := PayAccounts.SuperPayableAccountID(Tpaybase(Self.Owner).EmployeeID); {+ Liab}
    DebitAccID := PayAccounts.SuperPaidAccountID(Tpaybase(Self.Owner).EmployeeID); {- Expense}
    {Extra To Remove Salary Sacrifice From Gross}
    CreditAccID_2 := PayAccounts.GrossWagesAccountID(Tpaybase(Self.Owner).EmployeeID); {+ Gross Wages}
    DebitAccID_2  := PayAccounts.BankAccountID(Tpaybase(Self.Owner).EmployeeID); {- Net Pay}
    Tpaybase(Self.Owner).PayTrans.LoadSelect('PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
                                  ' AND Type = "Payroll Superannuation" AND MSType = "'+MSType_Superannuation+'"' +
                                  ' AND Description = '+ QuotedStr('Superannuation - '+ GetSuperName(Tpayssuperannuation(Sender).SuperTypeID)) +
                                  ' AND PayLineID = ' + IntToStr(ID)+
                                  ' AND (AccountID = ' + IntToStr(CreditAccID_2)+ ' OR AccountID = ' + IntToStr(DebitAccID_2)+ ')');

    Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions(17,'Payroll Superannuation',MSType_Superannuation,
                                  'Superannuation - ' + GetSuperName(Tpayssuperannuation(Sender).SuperTypeID),CreditAccID_2,
                                  DebitAccID_2,ClassID, ID,AmountPaid * -1, self);
  end;

  Tpaybase(Self.Owner).PayTrans.LoadSelect('PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
                                ' AND Type = "Payroll Superannuation" AND MSType = "'+MSType_Superannuation+'"' +
                                ' AND Description = '+ QuotedStr('Superannuation - '+ GetSuperName(Tpayssuperannuation(Sender).SuperTypeID)) +
                                ' AND PayLineID = ' + IntToStr(ID)+
                                ' AND (AccountID = ' + IntToStr(CreditAccID)+ ' OR AccountID = ' + IntToStr(DebitAccID)+ ')');

  Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions(18,'Payroll Superannuation',MSType_Superannuation,
                                'Superannuation - ' + GetSuperName(Tpayssuperannuation(Sender).SuperTypeID),CreditAccID,
                                DebitAccID,ClassID, ID,AmountPaid * -1, self);
end;

procedure TPaysSuperannuation.CallbackCalcSalarySacrificeLine(
  const Sender: TBusObj; var Abort: Boolean);
var
  SuperLine: TPaysSuperannuation;
  dAmount: double;
begin
  SuperLine:= TPaysSuperannuation(Sender);
  if (SuperLine.SuperTypeName = SUPER_TYPE_SALARY_SACRIFICE) then begin
    if UpdateData then begin
      SuperLine.Belowthreshold:= false;
      if SuperLine.CalcBy = '%' then
        dAmount := RoundCurrency(fdAmountIncludedInSuper * (SuperLine.Amount/100))
      else
        dAmount := RoundCurrency(SuperLine.Amount);
      SuperLine.NonCatchUpAmount:= dAmount;
      SuperLine.ThisPaysProportion:= dAmount;
      SuperLine.Amountpaid:= dAmount;
      SuperLine.PostDb;
    end;
    fdSalarySacrificeTotal := fdSalarySacrificeTotal + SuperLine.AmountPaid;
  end
end;

procedure TPaysSuperannuation.CallbackCalcLine(const Sender: TBusObj;
  var Abort: Boolean);
var
  SuperLine: TPaysSuperannuation;
  dAmount: double;

begin
  SuperLine:= TPaysSuperannuation(Sender);

  if (SuperLine.SuperTypeName = SUPER_TYPE_SUPER_GUARANTEE) then begin
    if UpdateData then begin
      if iRecalcLinePassNo = 1 then begin
        if SuperLine.CalcBy = '%' then begin
          if AppEnv.PayPrefs.CalcSGCOnSS then
            dAmount := RoundCurrency(fdAmountIncludedInSuper * (SuperLine.Amount/100))
          else
            dAmount := RoundCurrency(fdAmountIncludedInSuperLessSalarySacrifice * (SuperLine.Amount/100));
        end
        else
          dAmount := RoundCurrency(SuperLine.Amount);
        if not AppEnv.PayPrefs.PaySuperToOver70 then begin
          if (fiEmployeeAge > 70) then begin
            dAmount := 0.00;
          end;
        end;
        if not AppEnv.PayPrefs.PayUnder18 then begin
          if ((TPaybase(Self.Owner).PaysPayRates.TotalStandardHours < 30) and (fiEmployeeAge < 18) and
            ((TPaybase(Self.Owner).EmployeeDetails.Basisofpayment = 'P') or
            (TPaybase(Self.Owner).EmployeeDetails.Basisofpayment = 'C'))) then begin
            dAmount := 0.00;
          end;
        end;
        SuperLine.NonCatchUpAmount:= dAmount;
        SuperLine.Belowthreshold:= false;
        SuperLine.ThisPaysProportion:= 0;
        SuperLine.Amountpaid:= 0;
        SuperLine.PostDb;
      end
      else if (iRecalcLinePassNo = 2) and (SuperLine.NonCatchUpAmount <> 0) then  begin

        if fdMTDTotalSGC > SuperThreshold(TPaybase(Self.Owner).EmployeeDetails.Award) then begin
          SuperLine.BelowThreshold := False;
          SuperLine.Amountpaid:= SuperLine.NonCatchUpAmount +
            (GetMTDCatchupAmount(SuperLine.SuperTypeID) - GetMTDPaidAmount(SuperLine.SuperTypeID));
          SuperLine.ThisPaysProportion:= SuperLine.Amountpaid;
        end
        else begin
          SuperLine.BelowThreshold := True;
          SuperLine.ThisPaysProportion:= 0;
          SuperLine.Amountpaid:= 0;
        end;
        SuperLine.PostDb;
      end;
    end;
    fdSGCTotal:= fdSGCTotal + SuperLine.AmountPaid;
    if NonCatchUpAmount <> 0 then
      bContainsSGCLines:= true;
  end
  else if (SuperLine.SuperTypeName = SUPER_TYPE_EMPLOYER_OPTIONAL) then begin
    if UpdateData then begin
      if iRecalcLinePassNo = 1 then begin
        if SuperLine.CalcBy = '%' then
          dAmount := RoundCurrency(fdAmountIncludedInSuperLessSalarySacrifice * (SuperLine.Amount/100))
        else
          dAmount := RoundCurrency(SuperLine.Amount);
        SuperLine.NonCatchUpAmount:= dAmount;
        SuperLine.Belowthreshold:= false;
        SuperLine.ThisPaysProportion:= dAmount;
        SuperLine.Amountpaid:= dAmount;
        SuperLine.PostDb;
      end;
    end;
    fdEmployerOptionalTotal := fdEmployerOptionalTotal + SuperLine.AmountPaid;
  end
  else if (SuperLine.SuperTypeName = SUPER_TYPE_EMPLOYER_NEGATIVE) then begin
    if UpdateData then begin
      if iRecalcLinePassNo = 1 then begin
        if SuperLine.CalcBy = '%' then
          dAmount := RoundCurrency(fdAmountIncludedInSuperLessSalarySacrifice * (SuperLine.Amount/100))
        else
          dAmount := RoundCurrency(SuperLine.Amount);
        SuperLine.NonCatchUpAmount:= dAmount;
        SuperLine.Belowthreshold:= false;
        SuperLine.ThisPaysProportion:= dAmount;
        SuperLine.Amountpaid:= dAmount;
        SuperLine.PostDb;
      end;
    end;
    fdEmployerNegativeTotal := fdEmployerNegativeTotal - SuperLine.AmountPaid;
  end
  else if (SuperLine.SuperTypeName = SUPER_TYPE_SALARY_SACRIFICE) then begin
    { this type already done in CallbackCalcSalarySacrificeLine }
    fdSalarySacrificeTotal := fdSalarySacrificeTotal + SuperLine.AmountPaid;
  end
  else if (SuperLine.SuperTypeName = SUPER_TYPE_EMPLOYEE_OPTIONAL) then begin
    if UpdateData then begin
      if iRecalcLinePassNo = 1 then begin
        if SuperLine.CalcBy = '%' then
          dAmount := RoundCurrency(fdAmountIncludedInSuperLessSalarySacrifice * (SuperLine.Amount/100))
        else
          dAmount := RoundCurrency(SuperLine.Amount);
        SuperLine.NonCatchUpAmount:= dAmount;
        SuperLine.Belowthreshold:= false;
        SuperLine.ThisPaysProportion:= dAmount;
        SuperLine.Amountpaid:= dAmount;
        SuperLine.PostDb;
      end;
    end;
    fdEmployeeOptionalTotal := fdEmployeeOptionalTotal + SuperLine.AmountPaid;
  end
  else if (SuperLine.SuperTypeName = SUPER_TYPE_EMPLOYEE_NEGATIVE) then begin
    if UpdateData then begin
      if iRecalcLinePassNo = 1 then begin
        if SuperLine.CalcBy = '%' then
          dAmount := RoundCurrency(fdAmountIncludedInSuperLessSalarySacrifice * (SuperLine.Amount/100))
        else
          dAmount := RoundCurrency(SuperLine.Amount);
        SuperLine.NonCatchUpAmount:= dAmount;
        SuperLine.Belowthreshold:= false;
        SuperLine.ThisPaysProportion:= dAmount;
        SuperLine.Amountpaid:= dAmount;
        SuperLine.PostDb;
      end;
    end;
    fdEmployeeNegativeTotal := fdEmployeeNegativeTotal - SuperLine.AmountPaid;
  end
  else if (SuperLine.SuperTypeName = SUPER_TYPE_SPOUSE_CONTRIBUTION) then begin
    if UpdateData then begin
      if iRecalcLinePassNo = 1 then begin
        if SuperLine.CalcBy = '%' then
          dAmount := RoundCurrency(fdAmountIncludedInSuperLessSalarySacrifice * (SuperLine.Amount/100))
        else
          dAmount := RoundCurrency(SuperLine.Amount);
        SuperLine.NonCatchUpAmount:= dAmount;
        SuperLine.Belowthreshold:= false;
        SuperLine.ThisPaysProportion:= dAmount;
        SuperLine.Amountpaid:= dAmount;
        SuperLine.PostDb;
      end;
    end;
    fdSpouseContributionTotal := fdSpouseContributionTotal + SuperLine.AmountPaid;
  end;
end;


procedure Tpayssuperannuation.ReCalc;
begin
  fdSGCTotal := 0.00;
  fdEmployerOptionalTotal := 0.00;
  fdEmployerNegativeTotal := 0.00;
  fdSalarySacrificeTotal := 0.00;
  fdEmployeeOptionalTotal := 0.00;
  fdEmployeeNegativeTotal := 0.00;
  fdSpouseContributionTotal := 0.00;

  if UpdateData then begin

    if TPaybase(Self.Owner).Paydate = 0 then begin
      fiEmployeeAge := GetEmployeeAge(TPaybase(Self.Owner).EmployeeDetails.Dob,Now());
    end else begin
      fiEmployeeAge := GetEmployeeAge(TPaybase(Self.Owner).EmployeeDetails.Dob, TPaybase(Self.Owner).DatePaid);
    end;

    fdAmountIncludedInSuper := TPaybase(Self.Owner).PaysPayRates.TotalIncludedInSuper +
      TPaybase(Self.Owner).PayAllowances.TotalAllowancesIncludedInSuper +
      TPaybase(Self.Owner).PayCommissions.TotalIncludedInSuper;

    if (TPaybase(Self.Owner).Termination.Count > 0) and AppEnv.PayPrefs.PaySuperOnLumpSumD then
      fdAmountIncludedInSuper := fdAmountIncludedInSuper + TPaybase(Self.Owner).Termination.LumpSumD;


    { process any "Salary Sacrifice" type lines and
      total up fdSalarySacrificeTotal }
    Self.IterateRecords(CallbackCalcSalarySacrificeLine, false);

    { amount to be used for all other super calcs }
    fdAmountIncludedInSuperLessSalarySacrifice:=
      fdAmountIncludedInSuper - fdSalarySacrificeTotal;

    fdSalarySacrificeTotal := 0.00;

  end;

  bContainsSGCLines:= false;


  { first pass will get totals AND calculate super amounts if we are
    editing (ie new pay) }
  iRecalcLinePassNo:= 1;
  Self.IterateRecords(CallbackCalcLine, false);

  fdTotalSuper:=
    fdSGCTotal +
    fdEmployerOptionalTotal +
    fdEmployerNegativeTotal +
    fdSalarySacrificeTotal +
    fdEmployeeOptionalTotal +
    fdEmployeeNegativeTotal +
    fdSpouseContributionTotal;

  if UpdateData and bContainsSGCLines then begin
    { there are Super Guarantee lines so we need to do a second pass to
      check threshold level }
    iRecalcLinePassNo:= 2;

    fdSGCTotal := 0.00;
    fdEmployerOptionalTotal := 0.00;
    fdEmployerNegativeTotal := 0.00;
    fdSalarySacrificeTotal := 0.00;
    fdEmployeeOptionalTotal := 0.00;
    fdEmployeeNegativeTotal := 0.00;
    fdSpouseContributionTotal := 0.00;

    { we need total MTD amount including this pay to check
      Super Quarantee threshold }
    fdMTDTotalSGC:=
      GetMTDWageTotalForSuper +
      GetMTDAllowancesTotalForSuper +
      GetMTDCommissionsTotalForSuper -
      GetMTDSalarySacrificeTotal;


    Self.IterateRecords(CallbackCalcLine, false);

    fdTotalSuper:=
      fdSGCTotal +
      fdEmployerOptionalTotal +
      fdEmployerNegativeTotal +
      fdSalarySacrificeTotal +
      fdEmployeeOptionalTotal +
      fdEmployeeNegativeTotal +
      fdSpouseContributionTotal;
  end;

end;

//procedure Tpayssuperannuation.ReCalc;
//var
//  ThresholdAmount: double;
//begin
//  fdTotalSuper := 0.00;
//  fdSGCTotal := 0.00;
////  fdSGCTotalNoSuperThreshold := 0.00;
//  fdEmployerOptionalTotal := 0.00;
//  fdEmployerNegativeTotal := 0.00;
//  fdSalarySacrificeTotal := 0.00;
//  fdEmployeeOptionalTotal := 0.00;
//  fdEmployeeNegativeTotal := 0.00;
//  fdSpouseContributionTotal := 0.00;
//
//    // Get the age of this employee
//  if TPaybase(Self.Owner).Paydate = 0 then begin
//    fiEmployeeAge := GetEmployeeAge(TPaybase(Self.Owner).EmployeeDetails.Dob,Now());
//  end else begin
//    fiEmployeeAge := GetEmployeeAge(TPaybase(Self.Owner).EmployeeDetails.Dob, TPaybase(Self.Owner).Paydate);
//  end;
////Step 1. Calc NonCatchup super Amounts for this pay (the straight out amounts ignoring threshold)
//  fdAmountIncludedinSuper := TPaybase(Self.Owner).PaysPayRates.TotalIncludedInSuper +
//        TPaybase(Self.Owner).PayAllowances.TotalAllowancesIncludedInSuper +
//        TPaybase(Self.Owner).PayCommissions.TotalIncludedInSuper;
//
//  //Salary Sacrifice First Because it's Deducted From fdAmountIncludedinSuper
//  Self.IterateRecords(CallbackSalarySacrificeCalcs,False);
//
//  //All But Salary Sacrifice
//  fdAmountIncludedinSuper := fdAmountIncludedinSuper - fdSalarySacrificeTotal;
//
//  if not TPayBase(self.Owner).Paid then
//    Self.IterateRecords(CallbackSuperCalcs,False);
//
////Step 2. Calc Amounts Paid according to threshold ; possibly resetting Amount Paids
//  fdAmountIncludedinSuper := GetMonthWageTotalForSuper + GetMonthAllowancesTotalForSuper +
//                             GetMonthCommissionsTotalForSuper ;
//
//  //Salary Sacrifice is Deducted From fdAmountIncludedinSuper
//  fdAmountIncludedinSuper := fdAmountIncludedinSuper - GetMonthsSalarySacrificeTotal - fdSalarySacrificeTotal;
//
//  ThresholdAmount := SuperThreshold(TPaybase(Self.Owner).EmployeeDetails.Award);
//  if fdAmountIncludedinSuper > ThresholdAmount then
//    BelowThreshold := False
//  else
//    BelowThreshold := True;
//
//  //Now we have super for the whole month in this pay, so we have to subtract any already paid in this month
//  // for each super
//  if not TPayBase(self.Owner).Paid then
//    Self.IterateRecords(CallbackSubtractPaids);
//  //reset field vars
//  fdSGCTotal := 0;
//  Self.IterateRecords(CallbackSetFieldVars);
//  fdTotalSuper := fdSGCTotal + fdEmployerOptionalTotal + fdEmployerNegativeTotal + fdSalarySacrificeTotal +
//        fdEmployeeOptionalTotal + fdEmployeeNegativeTotal + fdSpouseContributionTotal;
//
//end;



//procedure Tpayssuperannuation.CallbackSetFieldVars(const Sender: TBusObj; var Abort: Boolean);
//begin
//  if (GetSuperName(Tpayssuperannuation(Sender).SuperTypeID) = 'Super Guarantee') then begin
//    fdSGCTotal := fdSGCTotal + Tpayssuperannuation(Sender).AmountPaid;
//  end else if GetSuperName(Tpayssuperannuation(Sender).SuperTypeID) = 'Employer Negative' then begin
//    fdEmployerNegativeTotal := fdEmployerNegativeTotal - Tpayssuperannuation(Sender).AmountPaid;
//  end else if GetSuperName(Tpayssuperannuation(Sender).SuperTypeID) = SUPER_TYPE_SALARY_SACRIFICE then begin
////    fdSalarySacrificeTotal := fdSalarySacrificeTotal + Tpayssuperannuation(Sender).AmountPaid;
//  end else if GetSuperName(Tpayssuperannuation(Sender).SuperTypeID) = 'Employee Optional' then begin
////    fdEmployeeOptionalTotal := fdEmployeeOptionalTotal + Tpayssuperannuation(Sender).AmountPaid;
//  end else if GetSuperName(Tpayssuperannuation(Sender).SuperTypeID) = 'Employee Negative' then begin
//    fdEmployeeNegativeTotal := fdEmployeeNegativeTotal - Tpayssuperannuation(Sender).AmountPaid;
//  end else if GetSuperName(Tpayssuperannuation(Sender).SuperTypeID) = 'Spouse Contribution' then begin
//    fdSpouseContributionTotal := fdSpouseContributionTotal + Tpayssuperannuation(Sender).AmountPaid;
//  end;
//end;

//function Tpayssuperannuation.GetMonthsSalarySacrificeTotal:Double;
//var
//  qryPays: TERPQuery;
//  wDay, wMonth, wYear: word;
//  dtStartDate: TDateTime;
//  tmpAmount:double;
//begin
//  qryPays := TERPQuery.Create(nil);
//  try
//    qryPays.Options.FlatBuffers := True;
//    qryPays.Connection := TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection );
//    qryPays.SQL.Clear;
//    qryPays.SQL.Add('SELECT Sum(AmountPaid) AS TotalSuper');
//    qryPays.SQL.Add('FROM tblpays INNER JOIN tblpayssuperannuation USING(PayID)');// INNER JOIN  tblsupertype ON  tblsupertype.SuperTypeID = tblpayssuperannuation.SuperTypeID');
//    qryPays.SQL.Add('WHERE EmployeeID = :xEmployeeID ');
//    qryPays.SQL.Add('AND Paid = "T" AND Deleted = "F"  ');
//    qryPays.SQL.Add('AND (PayDate BETWEEN :dtFrom AND :dtTo) ');
//    qryPays.SQL.Add('AND tblpayssuperannuation.SuperTypeID = 4');  //sacrifice
//    qryPays.SQL.Add('GROUP BY tblpayssuperannuation.SuperTypeID;');
//
//    DecodeDate(TPaybase(Self.Owner).PayDate, wYear, wMonth, wDay);
//    dtStartDate := EncodeDate(wYear, wMonth, wDay);
//    dtStartDate := IncMonth(dtStartDate,-1);
//    qryPays.Params.ParamByName('dtFrom').AsDateTime := dtStartDate;
//    qryPays.Params.ParamByName('dtTo').AsDateTime := TPaybase(Self.Owner).PayDate;
//    qryPays.Params.ParamByName('xEmployeeID').AsInteger := TPaybase(Self.Owner).EmployeeDetails.ID;
//    qryPays.Open;
//    if qryPays.RecordCount > 0 then begin
//      tmpAmount := 0;
//      qryPays.First;
//      while not qryPays.Eof do begin
//        tmpAmount  := tmpAmount + qryPays.FieldByName('TotalSuper').AsFloat;
//        qryPays.Next;
//      end;
//      Result := tmpAmount;
//    end else begin
//      Result := 0.00;
//    end;
//  finally
//    FreeAndNil(qryPays);
//  end;
//end;


//function Tpayssuperannuation.GetMonthWageTotalForSuper:Double;
//var
//  qryPays: TERPQuery;
//  dtStartDate: TDateTime;
//  tmpAmount:double;
//begin
//  qryPays := TERPQuery.Create(nil);
//  try
//    qryPays.Options.FlatBuffers := True;
//    qryPays.Connection := TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection );
//    qryPays.SQL.Clear;
//    qryPays.SQL.Add('SELECT Sum(LineTotal) AS TotalForSuper');
//    qryPays.SQL.Add('FROM tblpays INNER JOIN tblpayspayrates USING(PayID)');
//
//    qryPays.SQL.Add('WHERE EmployeeID = :xEmployeeID  ');
//    qryPays.SQL.Add('AND Deleted = "F"  ');
//    qryPays.SQL.Add('AND tblpayspayrates.SuperInc = "T"');
//    qryPays.SQL.Add('AND (PayDate BETWEEN :dtFrom AND :dtTo) ');
//    qryPays.SQL.Add('GROUP BY tblpays.Wages;');
//
//    dtStartDate := TPaybase(Self.Owner).PayDate;
//    dtStartDate := IncMonth(dtStartDate,-1);
//    qryPays.Params.ParamByName('dtFrom').AsDateTime := dtStartDate;
//    qryPays.Params.ParamByName('dtTo').AsDateTime := TPaybase(Self.Owner).PayDate + 1 ;
//    qryPays.Params.ParamByName('xEmployeeID').AsInteger := TPaybase(Self.Owner).EmployeeDetails.ID;
//
//    qryPays.Open;
//    if qryPays.RecordCount > 0 then begin
//      tmpAmount := 0;
//      qryPays.First;
//      while not qryPays.Eof do begin
//        tmpAmount := tmpAmount + qryPays.FieldByName('TotalForSuper').AsFloat;
//        qryPays.Next;
//      end;
//      Result := tmpAmount;
//    end else begin
//      Result := 0.00;
//    end;
//  finally
//    FreeAndNil(qryPays);
//  end;
//end;

function TPaysSuperannuation.GetMTDAllowancesTotalForSuper: Double;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := self.Connection.Connection;
    qry.SQL.Add('SELECT Sum(MoneyAmount) AS TotalForSuper');
    qry.SQL.Add('FROM tblpays INNER JOIN tblpaysallowances USING(PayID)');
    qry.SQL.Add('WHERE EmployeeID = :xEmployeeID  ');
    qry.SQL.Add('AND Deleted = "F"  ');
    qry.SQL.Add('AND tblpaysallowances.SuperInc = "T"');
    qry.SQL.Add('AND (DatePaid BETWEEN :dtFrom AND :dtTo) ');
    qry.Params.ParamByName('dtFrom').AsDateTime := StartOfAMonth(YearOf(TPaybase(Self.Owner).DatePaid),MonthOf(TPaybase(Self.Owner).DatePaid));
//    qry.Params.ParamByName('dtTo').AsDateTime := TPaybase(Self.Owner).DatePaid;
    qry.Params.ParamByName('dtTo').AsDateTime := EndOfAMonth(YearOf(TPaybase(Self.Owner).DatePaid),MonthOf(TPaybase(Self.Owner).DatePaid));
    qry.Params.ParamByName('xEmployeeID').AsInteger := TPaybase(Self.Owner).EmployeeDetails.ID;
    qry.Open;
    result := qry.FieldByName('TotalForSuper').AsFloat;
  finally
    qry.Free;;
  end;
end;

function TPaysSuperannuation.GetMTDCatchupAmount(iSuperTypeId: integer): Double;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection := self.Connection.Connection;
    qry.SQL.Add('SELECT Sum(NonCatchupAmount) AS TotalSuper');
    qry.SQL.Add('FROM tblpays INNER JOIN tblpayssuperannuation USING(PayID) INNER JOIN  tblsupertype ON  tblsupertype.SuperTypeID = tblpayssuperannuation.SuperTypeID');
    qry.SQL.Add(' AND  tblpayssuperannuation.superTypeID  = ' + IntToStr(iSuperTypeId));
    qry.SQL.Add('WHERE EmployeeID = :xEmployeeID AND ');
    qry.SQL.Add('Paid = "T" AND Deleted = "F"  ');
    qry.SQL.Add('AND (DatePaid BETWEEN :dtFrom AND :dtTo) ');
    qry.SQL.Add('GROUP BY tblpayssuperannuation.SuperTypeID;');
    qry.Params.ParamByName('dtFrom').AsDateTime := StartOfAMonth(YearOf(TPaybase(Self.Owner).DatePaid),MonthOf(TPaybase(Self.Owner).DatePaid));
//    qry.Params.ParamByName('dtTo').AsDateTime := TPaybase(Self.Owner).DatePaid;
    qry.Params.ParamByName('dtTo').AsDateTime := EndOfAMonth(YearOf(TPaybase(Self.Owner).DatePaid),MonthOf(TPaybase(Self.Owner).DatePaid));
    qry.Params.ParamByName('xEmployeeID').AsInteger := TPaybase(Self.Owner).EmployeeDetails.ID ;
    qry.Open;
    result:= qry.FieldByName('TotalSuper').AsFloat;
  finally
    qry.Free;
  end;
end;

function TPaysSuperannuation.GetMTDCommissionsTotalForSuper: double;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := self.Connection.Connection;
    qry.SQL.Add('SELECT Sum(tblpaysCommission.Gross) AS TotalForSuper');
    qry.SQL.Add('FROM tblpays INNER JOIN tblpayscommission USING(PayID)');
    qry.SQL.Add('WHERE tblpayscommission.EmployeeID = :xEmployeeID  ');
    qry.SQL.Add('AND Deleted = "F"  ');
    qry.SQL.Add('AND tblpayscommission.SuperInc = "T"');
    qry.SQL.Add('AND (DatePaid BETWEEN :dtFrom AND :dtTo) ');
    qry.Params.ParamByName('dtFrom').AsDateTime := StartOfAMonth(YearOf(TPaybase(Self.Owner).DatePaid),MonthOf(TPaybase(Self.Owner).DatePaid));
//    qry.Params.ParamByName('dtTo').AsDateTime := TPaybase(Self.Owner).DatePaid;
    qry.Params.ParamByName('dtTo').AsDateTime := EndOfAMonth(YearOf(TPaybase(Self.Owner).DatePaid),MonthOf(TPaybase(Self.Owner).DatePaid));
    qry.Params.ParamByName('xEmployeeID').AsInteger := TPaybase(Self.Owner).EmployeeDetails.ID;
    qry.Open;
    result := qry.FieldByName('TotalForSuper').AsFloat;
  finally
    qry.Free;
  end;
end;

function TPaysSuperannuation.GetMTDPaidAmount(iSuperTypeId: integer): Double;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection := self.Connection.Connection;
    qry.SQL.Add('SELECT Sum(ThisPaysProportion) AS TotalSuper');
    qry.SQL.Add('FROM tblpays INNER JOIN tblpayssuperannuation USING(PayID) INNER JOIN  tblsupertype ON  tblsupertype.SuperTypeID = tblpayssuperannuation.SuperTypeID');
    qry.SQL.Add(' AND  tblpayssuperannuation.superTypeID  = ' + IntToStr(iSuperTypeId));
    qry.SQL.Add('WHERE EmployeeID = :xEmployeeID AND ');
    qry.SQL.Add('Paid = "T" AND Deleted = "F"  ');
    qry.SQL.Add('AND (DatePaid BETWEEN :dtFrom AND :dtTo) ');
    qry.SQL.Add('GROUP BY tblpayssuperannuation.SuperTypeID;');
    qry.Params.ParamByName('dtFrom').AsDateTime := StartOfAMonth(YearOf(TPaybase(Self.Owner).DatePaid),MonthOf(TPaybase(Self.Owner).DatePaid));
//    qry.Params.ParamByName('dtTo').AsDateTime := TPaybase(Self.Owner).DatePaid;
    qry.Params.ParamByName('dtTo').AsDateTime := EndOfAMonth(YearOf(TPaybase(Self.Owner).DatePaid),MonthOf(TPaybase(Self.Owner).DatePaid));
    qry.Params.ParamByName('xEmployeeID').AsInteger := TPaybase(Self.Owner).EmployeeDetails.ID ;
    qry.Open;
    result:= qry.FieldByName('TotalSuper').AsFloat;
  finally
    qry.Free;
  end;
end;

class function TPaysSuperannuation.GetYTDSalarySacrificeTotal(
  const aDate: TDateTime; aEmployeeID: integer): double;
var
  qry: TERPQuery;
  dtFrom, dtTo: TDateTime;
begin
  dtFrom := FiscalYearStart(aDate, AppEnv.CompanyPrefs.FiscalYearStarts);

  //binny : Its year to date, so dateto should be adate, akubra had issue with pay run #48 for CRICK JOHN
  //dtTo := IncYear(dtFrom,1)-1;
  dtTo := adate;

  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('SELECT Sum(AmountPaid) AS TotalSuper');
    qry.SQL.Add('FROM tblpays INNER JOIN tblpayssuperannuation USING(PayID)');
    qry.SQL.Add('INNER JOIN  tblsupertype ON  tblsupertype.SuperTypeID = tblpayssuperannuation.SuperTypeID');
    qry.SQL.Add('WHERE EmployeeID = :xEmployeeID ');
    qry.SQL.Add('AND Paid = "T" AND Deleted = "F"  ');
    qry.SQL.Add('AND (DatePaid BETWEEN :dtFrom AND :dtTo) ');
    qry.SQL.Add('AND tblsupertype.Description = ' + QuotedStr(SUPER_TYPE_SALARY_SACRIFICE));
    qry.SQL.Add('GROUP BY tblpayssuperannuation.SuperTypeID;');
    qry.Params.ParamByName('dtFrom').AsDateTime := Trunc(dtFrom);
    qry.Params.ParamByName('dtTo').AsDateTime := Trunc(dtTo);
    qry.Params.ParamByName('xEmployeeID').AsInteger := aEmployeeID;
    qry.Open;
    result:= qry.FieldByName('TotalSuper').AsFloat;
  finally
    qry.Free;
  end;
end;

function TPaysSuperannuation.GetMTDSalarySacrificeTotal: Double;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := self.Connection.Connection;
    qry.SQL.Add('SELECT Sum(AmountPaid) AS TotalSuper');
    qry.SQL.Add('FROM tblpays INNER JOIN tblpayssuperannuation USING(PayID)');
    qry.SQL.Add('INNER JOIN  tblsupertype ON  tblsupertype.SuperTypeID = tblpayssuperannuation.SuperTypeID');
    qry.SQL.Add('WHERE EmployeeID = :xEmployeeID ');
    qry.SQL.Add('AND Paid = "T" AND Deleted = "F"  ');
    qry.SQL.Add('AND (DatePaid BETWEEN :dtFrom AND :dtTo) ');
    qry.SQL.Add('AND tblsupertype.Description = ' + QuotedStr(SUPER_TYPE_SALARY_SACRIFICE));
    qry.SQL.Add('GROUP BY tblpayssuperannuation.SuperTypeID;');
    qry.Params.ParamByName('dtFrom').AsDateTime := StartOfAMonth(YearOf(TPaybase(Self.Owner).DatePaid),MonthOf(TPaybase(Self.Owner).DatePaid));
//    qry.Params.ParamByName('dtTo').AsDateTime := TPaybase(Self.Owner).DatePaid;
    qry.Params.ParamByName('dtTo').AsDateTime := EndOfAMonth(YearOf(TPaybase(Self.Owner).DatePaid),MonthOf(TPaybase(Self.Owner).DatePaid));
    qry.Params.ParamByName('xEmployeeID').AsInteger := TPaybase(Self.Owner).EmployeeDetails.ID;
    qry.Open;
    result:= qry.FieldByName('TotalSuper').AsFloat;
  finally
    qry.Free;
  end;
end;

function TPaysSuperannuation.GetMTDWageTotalForSuper: double;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := Self.Connection.Connection;
    qry.SQL.Add('SELECT Sum(LineTotal) AS TotalForSuper');
    qry.SQL.Add('FROM tblpays INNER JOIN tblpayspayrates USING(PayID)');
    qry.SQL.Add('WHERE EmployeeID = :xEmployeeID  ');
    qry.SQL.Add('AND Deleted = "F"  ');
    qry.SQL.Add('AND tblpayspayrates.SuperInc = "T"');
    qry.SQL.Add('AND (DatePaid BETWEEN :dtFrom AND :dtTo) ');
//    qry.SQL.Add('GROUP BY tblpays.Wages;');
    qry.Params.ParamByName('dtFrom').AsDateTime := StartOfAMonth(YearOf(TPaybase(Self.Owner).DatePaid),MonthOf(TPaybase(Self.Owner).DatePaid));
//    qry.Params.ParamByName('dtTo').AsDateTime := TPaybase(Self.Owner).DatePaid;
    qry.Params.ParamByName('dtTo').AsDateTime := EndOfAMonth(YearOf(TPaybase(Self.Owner).DatePaid),MonthOf(TPaybase(Self.Owner).DatePaid));
    qry.Params.ParamByName('xEmployeeID').AsInteger := TPaybase(Self.Owner).EmployeeDetails.ID;
    qry.Open;
    result:= qry.FieldByName('TotalForSuper').AsFloat;
  finally
    FreeAndNil(qry);
  end;
end;

//function Tpayssuperannuation.GetMonthCommissionsTotalForSuper:Double;
//var
//  qryPays: TERPQuery;
//  dtStartDate: TDateTime;
//  tmpAmount:double;
//begin
//  qryPays := TERPQuery.Create(nil);
//  try
//    qryPays.Options.FlatBuffers := True;
//    qryPays.Connection := TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection );
//    qryPays.SQL.Clear;
//    qryPays.SQL.Add('SELECT Sum(tblpaysCommission.Gross) AS TotalForSuper');
//    qryPays.SQL.Add('FROM tblpays INNER JOIN tblpayscommission USING(PayID)');
//
//    qryPays.SQL.Add('WHERE tblpayscommission.EmployeeID = :xEmployeeID  ');
//    qryPays.SQL.Add('AND Deleted = "F"  ');
//    qryPays.SQL.Add('AND tblpayscommission.SuperInc = "T"');
//    qryPays.SQL.Add('AND (PayDate BETWEEN :dtFrom AND :dtTo) ');
//    qryPays.SQL.Add('GROUP BY tblpays.Wages;');
//
//    dtStartDate := TPaybase(Self.Owner).PayDate;
//    dtStartDate := IncMonth(dtStartDate,-1);
//    qryPays.Params.ParamByName('dtFrom').AsDateTime := dtStartDate;
//    qryPays.Params.ParamByName('dtTo').AsDateTime := TPaybase(Self.Owner).PayDate + 1 ;
//    qryPays.Params.ParamByName('xEmployeeID').AsInteger := TPaybase(Self.Owner).EmployeeDetails.ID;
//
//    qryPays.Open;
//    if qryPays.RecordCount > 0 then begin
//      tmpAmount := 0;
//      qryPays.First;
//      while not qryPays.Eof do begin
//        tmpAmount := tmpAmount + qryPays.FieldByName('TotalForSuper').AsFloat;
//        qryPays.Next;
//      end;
//      Result := tmpAmount;
//    end else begin
//      Result := 0.00;
//    end;
//  finally
//    FreeAndNil(qryPays);
//  end;
//end;

//function Tpayssuperannuation.GetMonthAllowancesTotalForSuper:Double;
//var
//  qryPays: TERPQuery;
//  dtStartDate: TDateTime;
//  tmpAmount:double;
//begin
//  qryPays := TERPQuery.Create(nil);
//  try
//    qryPays.Options.FlatBuffers := True;
//    qryPays.Connection := TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection );
//    qryPays.SQL.Clear;
//    qryPays.SQL.Add('SELECT Sum(MoneyAmount) AS TotalForSuper');
//    qryPays.SQL.Add('FROM tblpays INNER JOIN tblpaysallowances USING(PayID)');
//
//    qryPays.SQL.Add('WHERE EmployeeID = :xEmployeeID  ');
//    qryPays.SQL.Add('AND Deleted = "F"  ');
//    qryPays.SQL.Add('AND tblpaysallowances.SuperInc = "T"');
//    qryPays.SQL.Add('AND (PayDate BETWEEN :dtFrom AND :dtTo) ');
//    qryPays.SQL.Add('GROUP BY tblpays.Wages;');
//
//    dtStartDate := TPaybase(Self.Owner).PayDate;
//    dtStartDate := IncMonth(dtStartDate,-1);
//    qryPays.Params.ParamByName('dtFrom').AsDateTime := dtStartDate;
//    qryPays.Params.ParamByName('dtTo').AsDateTime := TPaybase(Self.Owner).PayDate + 1 ;
//    qryPays.Params.ParamByName('xEmployeeID').AsInteger := TPaybase(Self.Owner).EmployeeDetails.ID;
//
//    qryPays.Open;
//    if qryPays.RecordCount > 0 then begin
//      tmpAmount := 0;
//      qryPays.First;
//      while not qryPays.Eof do begin
//        tmpAmount := tmpAmount + qryPays.FieldByName('TotalForSuper').AsFloat;
//        qryPays.Next;
//      end;
//      Result := tmpAmount;
//    end else begin
//      Result := 0.00;
//    end;
//  finally
//    FreeAndNil(qryPays);
//  end;
//end;

//procedure Tpayssuperannuation.CallbackSalarySacrificeCalcs(const Sender: TBusObj; var Abort: Boolean);
//var
//  dAmount: double;
//begin
//  if Tpayssuperannuation(Sender).CalcBy = '%' then begin
//    dAmount := fdAmountIncludedinSuper * (Tpayssuperannuation(Sender).Amount/100);
//  end else begin
//    dAmount := Tpayssuperannuation(Sender).Amount;
//  end;
//
//  dAmount := RoundCurrency(dAmount);
//
//  if TPaybase(Self.Owner).Paid then begin
//    dAmount := Tpayssuperannuation(Sender).AmountPaid;
//  end;
//
//  if (GetSuperName(Tpayssuperannuation(Sender).SuperTypeID) = SUPER_TYPE_SALARY_SACRIFICE) then begin
//    fdSalarySacrificeTotal := fdSalarySacrificeTotal + dAmount;
//    Tpayssuperannuation(Sender).AmountPaid := dAmount;
//    PostDB;
//  end;
//end;


//procedure Tpayssuperannuation.CallbackSubtractPaids(const Sender: TBusObj; var Abort: Boolean);
//var
//  qryPays: TERPQuery;
//  dtStartDate: TDateTime;
//  tmpAmount:double;
//  function GetPreviouslyPaid(iSuperTypeId:integer):Double;
//  begin
//    qryPays := TERPQuery.Create(nil);
//    try
//      qryPays.Options.FlatBuffers := True;
//      qryPays.Connection := TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection );
//      qryPays.SQL.Clear;
//      qryPays.SQL.Add('SELECT Sum(ThisPaysProportion) AS TotalSuper');
//      qryPays.SQL.Add('FROM tblpays INNER JOIN tblpayssuperannuation USING(PayID) INNER JOIN  tblsupertype ON  tblsupertype.SuperTypeID = tblpayssuperannuation.SuperTypeID');
//      qryPays.SQL.Add(' AND  tblpayssuperannuation.superTypeID  = ' + IntToStr(iSuperTypeId));
//      qryPays.SQL.Add('WHERE EmployeeID = :xEmployeeID AND ');
//      qryPays.SQL.Add('Paid = "T" AND Deleted = "F"  ');
//      qryPays.SQL.Add('AND (PayDate BETWEEN :dtFrom AND :dtTo) ');
//      qryPays.SQL.Add('GROUP BY tblpayssuperannuation.SuperTypeID;');
//
//
//      dtStartDate := TPaybase(Self.Owner).PayDate;
//      dtStartDate := IncMonth(dtStartDate,-1);
//      qryPays.Params.ParamByName('dtFrom').AsDateTime := dtStartDate;
//      qryPays.Params.ParamByName('dtTo').AsDateTime := TPaybase(Self.Owner).PayDate;
//      qryPays.Params.ParamByName('xEmployeeID').AsInteger := TPaybase(Self.Owner).EmployeeDetails.id ;
//      qryPays.Open;
//      if qryPays.RecordCount > 0 then begin
//        qryPays.First;
//        tmpAmount := 0;
//        while not qryPays.Eof do begin
//          tmpAmount := tmpAmount + qryPays.FieldByName('TotalSuper').AsFloat;
//          qryPays.Next;
//        end;
//        Result := tmpAmount;
//      end else begin
//        Result := 0.00;
//      end;
//    finally
//      FreeAndNil(qryPays);
//    end;
//  end;
//begin
//  if (GetSuperName(Tpayssuperannuation(Sender).SuperTypeID) = SUPER_TYPE_SALARY_SACRIFICE) then exit;
//
//  Self.Amountpaid := GetMonthlySuper(Self.SupertypeID) - GetPreviouslyPaid(Self.Supertypeid);
//  if Belowthreshold then
//    Self.Amountpaid := 0 ;
//  Self.ThisPaysProportion := (fdAmountIncludedinSuper * divzer(Self.Amountpaid,fdAmountIncludedinSuper));
//  Self.PostDb;
//end;

//function Tpayssuperannuation.GetMonthlySuper(iSuperTypeId:integer):Double;
//var
//  qryPaysSuper:TERPQuery;
//  dtStartDate:TDateTime;
//begin
//  qryPaysSuper := TERPQuery.Create(nil);
//  try
//    qryPaysSuper.Options.FlatBuffers := True;
//    qryPaysSuper.Connection := TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection );//CommonDbLib.GetSharedMyDacConnection;
//    qryPaysSuper.SQL.Clear;
//
//    qryPaysSuper.SQL.Add('SELECT Sum(tblpayssuperannuation.NonCatchUpAmount) as TotalNonCatchUpAmount');
//    qryPaysSuper.SQL.Add('FROM tblpays INNER JOIN tblpayssuperannuation USING(PayID) INNER JOIN  tblsupertype ON  tblsupertype.SuperTypeID = tblpayssuperannuation.SuperTypeID');
//    qryPaysSuper.SQL.Add(' AND  tblpayssuperannuation.superTypeID  = ' + IntToStr(iSuperTypeId));
//    qryPaysSuper.SQL.Add('WHERE EmployeeID = :xEmployeeID');
//    qryPaysSuper.SQL.Add('AND Deleted = "F"  ');
//    qryPaysSuper.SQL.Add('AND (PayDate BETWEEN :dtFrom AND :dtTo) ');
//    qryPaysSuper.SQL.Add('GROUP BY tblpayssuperannuation.SuperTypeID;');
//
//    dtStartDate := TPaybase(Self.Owner).PayDate;
//    dtStartDate := IncMonth(dtStartDate,-1);
//    qryPaysSuper.Params.ParamByName('dtFrom').AsDateTime := dtStartDate;
//    qryPaysSuper.Params.ParamByName('dtTo').AsDateTime := TPaybase(Self.Owner).PayDate;
//    qryPaysSuper.Params.ParamByName('xEmployeeID').AsInteger := TPaybase(Self.Owner).EmployeeDetails.id ;
//    qryPaysSuper.Open;
//    if qryPaysSuper.RecordCount > 0 then begin
//      qryPaysSuper.First;
//      Result := qryPaysSuper.fieldByName('TotalNonCatchUpAmount').AsFloat;
//    end else begin
//      Result := 0;
//    end;
//  finally
//    FreeAndNil(qryPaysSuper);
//  end;
//end;


//procedure Tpayssuperannuation.CallbackSuperCalcs(const Sender: TBusObj; var Abort: Boolean);
//var
//  dAmount: double;
//begin
//  if (GetSuperName(Tpayssuperannuation(Sender).SuperTypeID) = SUPER_TYPE_SALARY_SACRIFICE) then exit;
//  if Tpayssuperannuation(Sender).CalcBy = '%' then begin
//    dAmount := fdAmountIncludedinSuper * (Tpayssuperannuation(Sender).Amount/100);
//  end else begin
//    dAmount := Tpayssuperannuation(Sender).Amount;
//  end;
//
//  dAmount := RoundCurrency(dAmount);
//
//  if (GetSuperName(Tpayssuperannuation(Sender).SuperTypeID) = 'Super Guarantee') then begin
//    if not AppEnv.PayPrefs.PaySuperToOver70 then begin
//      if (fiEmployeeAge > 70) then begin
//        dAmount := 0.00;
//      end;
//    end;
//    if not AppEnv.PayPrefs.PayUnder18 then begin
//      if ((TPaybase(Self.Owner).PaysPayRates.TotalStandardHours < 30) and (fiEmployeeAge < 18) and
//        ((TPaybase(Self.Owner).EmployeeDetails.Basisofpayment = 'P') or
//        (TPaybase(Self.Owner).EmployeeDetails.Basisofpayment = 'C'))) then begin
//        dAmount := 0.00;
//      end;
//    end;
//
//    fdSGCTotal := fdSGCTotal + dAmount;
//
//
//  end else if GetSuperName(Tpayssuperannuation(Sender).SuperTypeID) = 'Employer Optional' then begin
//    fdEmployerOptionalTotal := fdEmployerOptionalTotal + dAmount;
//  end else if GetSuperName(Tpayssuperannuation(Sender).SuperTypeID) = 'Employer Negative' then begin
//    dAmount := -dAmount;
//    fdEmployerNegativeTotal := fdEmployerNegativeTotal + dAmount;
//  end else if GetSuperName(Tpayssuperannuation(Sender).SuperTypeID) = SUPER_TYPE_SALARY_SACRIFICE then begin
//
//  end else if GetSuperName(Tpayssuperannuation(Sender).SuperTypeID) = 'Employee Optional' then begin
//    fdEmployeeOptionalTotal := fdEmployeeOptionalTotal + dAmount;
//  end else if GetSuperName(Tpayssuperannuation(Sender).SuperTypeID) = 'Employee Negative' then begin
//    dAmount := -dAmount;
//    fdEmployeeNegativeTotal := fdEmployeeNegativeTotal + dAmount;
//  end else if GetSuperName(Tpayssuperannuation(Sender).SuperTypeID) = 'Spouse Contribution' then begin
//    fdSpouseContributionTotal := fdSpouseContributionTotal + dAmount;
//  end;
//  fdTotalSuper := fdTotalSuper + dAmount;
//
//  Tpayssuperannuation(Sender).NonCatchUpAmount := dAmount;
//
//  if BelowThreshold then begin
//    Tpayssuperannuation(Sender).AmountPaid := 0 ;
//    fdSGCTotal := 0;
//  end else
//    Tpayssuperannuation(Sender).AmountPaid := dAmount;
//  PostDB;
//
//end;

function Tpayssuperannuation.GetSuperThresholdAmount: double;
begin
  Result := SuperThreshold(Tpaybase(Self.Owner).EmployeeDetails.Award);
end;

destructor Tpayssuperannuation.Destroy;
begin
   inherited;
end;


procedure   Tpayssuperannuation.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Payid');
  SetPropertyFromNode(Node,'Superid');
  SetPropertyFromNode(Node,'Supertypeid');
  SetPropertyFromNode(Node,'Clientid');
  SetPropertyFromNode(Node,'Accountno');
  GetXMLNodeDatetimeValue(Node,'Datejoined');
  SetPropertyFromNode(Node,'Amount');
  SetPropertyFromNode(Node,'Calcby');
  SetPropertyFromNode(Node,'Area');
  SetPropertyFromNode(Node,'Amountpaid');
  GetXMLNodeBooleanValue(Node,'Belowthreshold');
  SetPropertyFromNode(Node,'Classid');
  SetPropertyFromNode(Node,'Classname');
  SetBooleanPropertyFromNode(Node,'Allclasses');
  SetBooleanPropertyFromNode(Node,'ThisPaysProportion');
  SetBooleanPropertyFromNode(Node,'NonCatchUpAmount');
end;


procedure   Tpayssuperannuation.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Payid' ,Payid);
  AddXMLNode(node,'Superid' ,Superid);
  AddXMLNode(node,'Supertypeid' ,Supertypeid);
  AddXMLNode(node,'Clientid' ,Clientid);
  AddXMLNode(node,'Accountno' ,Accountno);
  AddXMLNode(node,'Datejoined' ,Datejoined);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Calcby' ,Calcby);
  AddXMLNode(node,'Area' ,Area);
  AddXMLNode(node,'Amountpaid' ,Amountpaid);
  AddXMLNode(node,'Belowthreshold' ,Belowthreshold);
  AddXMLNode(node,'Classid' ,Classid);
  AddXMLNode(node,'Classname' ,DepartmentName);
  AddXMLNode(node,'Allclasses' ,Allclasses);
  AddXMLNode(node,'ThisPaysProportion' ,ThisPaysProportion);
  AddXMLNode(node,'NonCatchUpAmount' ,NonCatchUpAmount);
end;

procedure Tpayssuperannuation.RemoveZeroTotalEntries;
begin
  Self.First;
  while not Self.EOF do begin
    if RoundCurrency(Amount) = 0.00 then begin
      try
        Self.Delete;
      except
      end;
    end;
    Self.Next;
  end;
end;


function    Tpayssuperannuation.ValidateData :Boolean ;
var
  tmpResultStatus: TResultStatusItem;
begin
   Result := False;
   Resultstatus.Clear;
   Try
     if Supertypeid = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_PayBenefit_Err_NoSuperType,  'Super type should not be blank'  );
        Exit;
     end;
     if Amount = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_PayBenefit_Err_NoAmount,  'Amount should not be 0' );
        Exit;
     end;
     if DepartmentName = '' then begin
        Resultstatus.AddItem(False , rssError ,BOR_PayBenefit_Err_NoDepartmentAust ,  'Department Name should not be blank' );
        Exit;
     end;
     if GetSuperName(Supertypeid) = SUPER_TYPE_SALARY_SACRIFICE then begin
      if (Amount > Tpaybase(Self.Owner).PayTotals.Wages) AND not Tpaybase(Self.Owner).LoadingEmployeeSuper then begin
        Resultstatus.AddItem(False , rssError , BOR_PayBenefit_Err_SalarySacrifice,  'Salary Sacrifice should not be Greater than Total Salary'  );
        Exit;
      end;
     end;
     Result := true;
   Finally
    If not Result then Begin
      tmpResultStatus := ResultStatus.GetLastStatusItem;
      if Assigned(tmpResultStatus) then
        TBusobj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code),BusobjEventVal_FailedSuperannuationValidateData);
    end;
   end;
end;


function TPaysSuperannuation.YTDAmountPaid(const aDate: TDateTime): double;
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
    qry.SQL.Add('select sum(ps.AmountPaid) as Amount from tblpayssuperannuation ps');
    qry.SQL.Add('inner join tblpays p on p.PayID = ps.PayID and p.Paid = "T"');
    qry.SQL.Add('and p.Deleted = "F"');
    qry.SQL.Add('and p.PayDate between ' + QuotedStr(strFrom) + ' and ' + QuotedStr(strTo));
    qry.SQL.Add('where ps.SuperTypeID = ' + IntToStr(self.SuperTypeID));
    qry.Open;
    result := qry.FieldByName('Amount').AsFloat;
  finally
    qry.Free;
  end;
end;

class function TPaysSuperannuation.YTDEmployerReportableTotal(
  const aDate: TDateTime; aEmployeeID: integer): double;
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
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select sum(ps.AmountPaid) as AmountPaid from tblpayssuperannuation ps');
    qry.SQL.Add('inner join tblsupertype st on st.SuperTypeID = ps.SuperTypeID and st.IncludeInEmployeeReportableContribution = "T"');
    qry.SQL.Add('inner join tblpays p on p.PayID = ps.PayID');
    qry.SQL.Add('and p.Paid = "T" and p.Deleted = "F"');
    qry.SQL.Add('and p.PayDate between ' + QuotedStr(strFrom) + ' and ' + QuotedStr(strTo));
    qry.SQL.Add('where p.EmployeeID = ' + IntToStr(aEmployeeID));
    qry.Open;
    result := qry.FieldByName('AmountPaid').AsFloat;
  finally
    qry.Free;
  end;
end;


class function TPaysSuperannuation.YTDOtherPaid(const aDate: TDateTime;
  aEmployeeID: integer): double;
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
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select sum(ps.AmountPaid) as Amount from tblpayssuperannuation ps');
    qry.SQL.Add('inner join tblpays p on p.PayID = ps.PayID and p.EmployeeID = ' + IntToStr(aEmployeeID));
    qry.SQL.Add('and p.Paid = "T"');
    qry.SQL.Add('and p.Deleted = "F"');
    qry.SQL.Add('and p.PayDate between ' + QuotedStr(strFrom) + ' and ' + QuotedStr(strTo));
    qry.SQL.Add('inner join tblsupertype st on st.SuperTypeID = ps.SuperTypeID');
    qry.SQL.Add('and st.Description <> "Super Guarantee"');
    qry.Open;
    result := qry.FieldByName('Amount').AsFloat;
  finally
    qry.Free;
  end;
end;


class function TPaysSuperannuation.YTDSuperGuarantee(const aDate: TDateTime; aEmployeeID: integer): double;
var
  strFrom, strTo: string;
  dtFrom: TDateTime;
  qry: TERPQuery;
  SuperAmount : Double;
  lastDate : TDateTime;
begin
  dtFrom := FiscalYearStart(aDate, AppEnv.CompanyPrefs.FiscalYearStarts);
  strFrom := FormatDateTime('yyyy-mm-dd',dtFrom);
  strTo := FormatDateTime('yyyy-mm-dd',IncYear(dtFrom,1)-1);
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;



    qry.SQL.Add('SELECT tblPays.EmployeeID AS EmployeeID, Concat(FirstName,  " ",LastName) AS EmployeeName, tblPays.DatePaid AS DatePaid, tblPays.Superannuation AS Super');
    qry.SQL.Add('FROM tblPays');
    qry.SQL.Add('LEFT JOIN tblEmployees ON tblPays.EmployeeID = tblEmployees.EmployeeID');
    qry.SQL.Add('LEFT JOIN tblClass ON tblPays.ClassID = tblClass.ClassID');
    qry.SQL.Add('LEFT JOIN tblPaysTransactions pt on pt.PayID = tblPays.PayID and pt.AccountId = 0');
    qry.SQL.Add('WHERE tblPays.EmployeeID = ' + IntToStr(aEmployeeID) + ' AND tblPays.PayDate BETWEEN ' + QuotedStr(strFrom) + ' AND '  + QuotedStr(strTo) + ' AND Paid="T"');

    if  aEmployeeID = 7 then
       ClipBoard.AsText := qry.SQL.Text;

    qry.Open;

    SuperAmount := 0;

    while not qry.Eof do
    begin
        if DateOf(qry.FieldByName('DatePaid').AsDateTime) = lastDate then
        begin
          qry.Next;
          continue;
        end;

       SuperAmount := SuperAmount + qry.FieldByName('Super').AsFloat;

       lastDate := DateOf(qry.FieldByName('DatePaid').AsDateTime);

        qry.Next;

    end;

     result := SuperAmount;

   //  ShowMessage( 'emp ' +  IntToStr(aEmployeeID) + '  super ' + FloatToStr(SuperAmount));

  finally
    qry.Free;
  end;
end;



class function TPaysSuperannuation.YTDSuperGuaranteePaid(const aDate: TDateTime;
  aEmployeeID: integer): double;
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
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select sum(ps.AmountPaid) as Amount from tblpayssuperannuation ps');
    qry.SQL.Add('inner join tblpays p on p.PayID = ps.PayID and p.EmployeeID = ' + IntToStr(aEmployeeID));
    qry.SQL.Add('and p.Paid = "T"');
    qry.SQL.Add('and p.Deleted = "F"');
    qry.SQL.Add('and p.PayDate between ' + QuotedStr(strFrom) + ' and ' + QuotedStr(strTo));
    qry.SQL.Add('inner join tblsupertype st on st.SuperTypeID = ps.SuperTypeID');
    qry.SQL.Add('and st.Description = "Super Guarantee"');

    if  aEmployeeID = 7 then
       ClipBoard.AsText := qry.SQL.Text;

    qry.Open;
    result := qry.FieldByName('Amount').AsFloat;
  finally
    qry.Free;
  end;
end;


function    Tpayssuperannuation.Save :Boolean ;
begin
   Result := False;
   Self.RemoveZeroTotalEntries;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure Tpayssuperannuation.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tpayssuperannuation.DoFieldOnChange(Sender: TField);
begin
  if Tpaybase(Self.Owner).LoadingEmployeeSuper then exit;
  if not (Self.Dataset.State in [dsEdit, dsInsert]) then Exit;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
   if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Supertypeid = 0 then exit;  // type not set yet

  if (Sysutils.SameText(Sender.FieldName , 'CalcBy'))
   or (Sysutils.SameText(Sender.FieldName , 'SuperTypeID'))
   or (Sysutils.SameText(Sender.FieldName , 'Amount'))
     then  begin
       Tpaybase(Self.Owner).RecalcAll;
     end;

  if Sysutils.SameText(Sender.FieldName , 'Classname') then begin
    ClassID := tcDatautils.GetDeptID(DepartmentName);
  end;
end;

class function TPaysSuperannuation.EmployerReportableTotal(
  const aPayID: integer): double;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select sum(ps.AmountPaid) as AmountPaid from tblpayssuperannuation ps');
    qry.SQL.Add('inner join tblsupertype st on st.SuperTypeID = ps.SuperTypeID and st.IncludeInEmployeeReportableContribution = "T"');
    qry.SQL.Add('where ps.PayID = ' + IntToStr(aPayID));
    qry.Open;
    result := qry.FieldByName('AmountPaid').AsFloat;
  finally
    qry.Free;
  end;
end;

Function Tpayssuperannuation.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  Tpayssuperannuation.GetIDField : String;
begin
   Result := 'Paysuperid'
end;

class function Tpayssuperannuation.GetBusObjectTablename: string;
begin
  Result := 'tblpayssuperannuation';
end;

Function  Tpayssuperannuation.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;

Function  Tpayssuperannuation.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
      if Self.Owner is TPaybase then begin
        PayId := TPaybase(Self.Owner).ID;
        DepartmentName := Tpaybase(Self.Owner).EmployeeDetails.Defaultclassname;
      end;
    Result := inherited DoAfterInsert(Sender);
end;

//Function Tpayssuperannuation.GetTotalSuperPaid :double; {for this pay; this will only be for pays already paid}
//begin
//  fTotalSuperPaid := 0;
//  Self.IterateRecords(CallbackTotalSuperPaid);
//  Result := fTotalSuperPaid;
//end;

//procedure Tpayssuperannuation.CallbackTotalSuperPaid(const Sender: TBusObj; var Abort: Boolean);
//begin
//  fTotalSuperPaid := fTotalSuperPaid + Self.Amountpaid;
//end;

{Property functions}
Function  Tpayssuperannuation.GetPayid         :Integer   ; begin Result := GetIntegerField('Payid');End;
Function  Tpayssuperannuation.GetSuperid       :Integer   ; begin Result := GetIntegerField('Superid');End;
Function  Tpayssuperannuation.GetSupertypeid   :Integer   ; begin Result := GetIntegerField('Supertypeid');End;
function TPaysSuperannuation.GetSuperTypeName: string;
begin
  result:= GetSuperName(SuperTypeID);
end;

Function  Tpayssuperannuation.GetClientid      :Integer   ; begin Result := GetIntegerField('Clientid');End;
Function  Tpayssuperannuation.GetAccountno     :String    ; begin Result := GetStringField('Accountno');End;
Function  Tpayssuperannuation.GetDatejoined    :TDatetime ; begin Result := GetDatetimeField('Datejoined');End;
Function  Tpayssuperannuation.GetAmount        :Double    ; begin Result := GetFloatField('Amount');End;
Function  Tpayssuperannuation.GetCalcby        :String    ; begin Result := GetStringField('Calcby');End;
Function  Tpayssuperannuation.GetArea          :String    ; begin Result := GetStringField('Area');End;
Function  Tpayssuperannuation.GetAmountpaid    :Double    ; begin Result := GetFloatField('Amountpaid');End;
Function  Tpayssuperannuation.GetBelowthreshold:Boolean   ; begin Result := GetBooleanField('Belowthreshold');End;
Function  Tpayssuperannuation.GetClassID       :Integer   ; begin Result := GetIntegerField('Classid');End;
Function  Tpayssuperannuation.GetClassname     :String    ; begin Result := GetStringField('Classname');End;
Function  Tpayssuperannuation.GetAllclasses    :Boolean   ; begin Result := GetBooleanField('Allclasses');End;
Function  Tpayssuperannuation.getThisPaysProportion  :Double ; begin Result := GetFloatField('ThisPaysProportion');End;
Function  Tpayssuperannuation.getNonCatchUpAmount  :Double ; begin Result := GetFloatField('NonCatchUpAmount');End;


Procedure Tpayssuperannuation.SetPayid         (Const Value :Integer   ); begin SetIntegerField('Payid'          , Value);End;
Procedure Tpayssuperannuation.SetSuperid       (Const Value :Integer   ); begin SetIntegerField('Superid'        , Value);End;
Procedure Tpayssuperannuation.SetSupertypeid   (Const Value :Integer   ); begin SetIntegerField('Supertypeid'    , Value);End;
Procedure Tpayssuperannuation.SetClientid      (Const Value :Integer   ); begin SetIntegerField('Clientid'       , Value);End;
Procedure Tpayssuperannuation.SetAccountno     (Const Value :String    ); begin SetStringField('Accountno'      , Value);End;
Procedure Tpayssuperannuation.SetDatejoined    (Const Value :TDatetime ); begin SetDatetimeField('Datejoined'     , Value);End;
Procedure Tpayssuperannuation.SetAmount        (Const Value :Double    ); begin SetFloatField('Amount'         , Value);End;
Procedure Tpayssuperannuation.SetCalcby        (Const Value :String    ); begin SetStringField('Calcby'         , Value);End;
Procedure Tpayssuperannuation.SetArea          (Const Value :String    ); begin SetStringField('Area'         , Value);End;
Procedure Tpayssuperannuation.SetAmountpaid    (Const Value :Double    ); begin SetFloatField('Amountpaid'     , Value);End;
Procedure Tpayssuperannuation.SetBelowthreshold(Const Value :Boolean   ); begin SetBooleanField('Belowthreshold' , Value);End;
Procedure Tpayssuperannuation.setClassID       (Const Value :Integer   ); begin SetIntegerField('Classid'        , Value);End;
Procedure Tpayssuperannuation.SetClassname     (Const Value :String    ); begin SetStringField('Classname'      , Value);End;
Procedure Tpayssuperannuation.SetAllclasses    (Const Value :Boolean   ); begin SetBooleanField('Allclasses'     , Value);End;
Procedure Tpayssuperannuation.SetThisPaysProportion (Const Value :Double ); begin SetFloatField('ThisPaysProportion' , Value);End;
Procedure Tpayssuperannuation.SetNonCatchUpAmount (Const Value :Double ); begin SetFloatField('NonCatchUpAmount' , Value);End;


initialization
RegisterClassOnce(Tpayssuperannuation);


end.
