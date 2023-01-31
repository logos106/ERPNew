unit BusObjPaysPayratesBASE;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   08/05/07   1.00.01   rm.   Initial Version.
   }

interface
{$I ERP.inc}

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjPayRate;
 
type
   Tpayspayrates = class(TMSBusObj)
   private
      fdTempHrs                      :double;
      fdTempAmount                   :double;
      fbAllowRecalc                  :boolean;
      fTotalIncludedInSuper          :double;
      //Trans                          :TTransBase;
      Function GetTotalIncludedInSuper:double;

      Function GetPayid              :Integer   ;
      Function GetPayrateid          :Integer   ;
      Function GetTypeid             :Integer   ;
      Function GetQty                :Double    ;
      Function GetAmount             :Double    ;
      Function GetLinetotal          :Double    ;
      Function GetSuperinc           :Boolean   ;
      Function GetClientid           :Integer   ;
      Function GetClassID            :Integer   ;
      Function GetClassname          :String    ;
      Function GetTimesheetid        :Integer   ;
      Procedure SetPayid              (Const Value :Integer   );
      Procedure SetPayrateid          (Const Value :Integer   );
      Procedure SetTypeid             (Const Value :Integer   );
      Procedure SetQty                (Const Value :Double    );
      Procedure SetAmount             (Const Value :Double    );
      Procedure SetLinetotal          (Const Value :Double    );
      Procedure SetSuperinc           (Const Value :Boolean   );
      Procedure SetClientid           (Const Value :Integer   );
      Procedure setClassID            (Const Value :Integer   );
      Procedure SetClassname          (Const Value :String    );
      Procedure SetTimesheetid        (Const Value :Integer   );

      Function  GetHourlyRate:double;

      procedure CallbackSumTemps(const Sender: TBusObj; var Abort: Boolean);
      procedure CallbackPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
      procedure CallbackUnPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
      procedure CallbackTotalIncludedInSuper(const Sender: TBusObj; var Abort: Boolean);
    function getPayRateObj: TPayRate;
   Protected
      fdTotalStandardHrs        :double;
      fdTotalHrs                :double;
      fdTotalHrsForAccrual      :double;
      fdTotal                   :double;
      fdTotalNonAccumLeaveHrs   :double;
      fdHourlyRate              :double;
      fiHourlyRateTypeCount     :integer;

      fdTotalStandardAmount     :double;
      fChangeSuperDefaultResult: integer;
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoBeforePost(Sender:TDatasetBusObj):Boolean;               Override;
      function DoAfterInsert(Sender: TDatasetBusObj): boolean; Override;
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


      Property Payid               :Integer      Read getPayid            Write SetPayid        ;
      Property Payrateid           :Integer      Read getPayrateid        Write SetPayrateid    ;
      Property Typeid              :Integer      Read getTypeid           Write SetTypeid       ;
      Property Qty                 :Double       Read GetQty              Write SetQty          ;
      Property Amount              :Double       Read getAmount           Write SetAmount       ;
      Property Linetotal           :Double       Read getLinetotal        Write SetLinetotal    ;
      Property Superinc            :Boolean      Read getSuperinc         Write SetSuperinc     ;
      Property Clientid            :Integer      Read getClientid         Write SetClientid     ;
      Property Classid             :Integer      Read GetClassID          Write setClassID      ;
      Property DepartmentName      :String       Read getClassname        Write SetClassname    ;
      Property Timesheetid         :Integer      Read getTimesheetid      Write SetTimesheetid  ;


      property Wages                :double read fdTotal write fdTotal;
      property Total                : double read fdTotal;
      property TotalIncludedInSuper :double read GetTotalIncludedInSuper;
      Property PayRate              : TPayRate read getPayRateObj;


      property TotalStandardHours: double read fdTotalStandardHrs;
      property TotalNonAccumLeaveHours: double read fdTotalNonAccumLeaveHrs;
      function GetTotalHours(AccrualOnly: boolean = false): double;
      function GetHoursForAccrual(const RateType: string): double;
      property TotalHours: double read fdTotalHrs;
      property TotalHoursForAccrual: double read fdTotalHrsForAccrual;
      property HourlyRate: double read GetHourlyRate;//fdHourlyRate; {Standard Hrs Rate }
      property HourlyRateTypeCount: integer read fiHourlyRateTypeCount;
      property AllowRecalc :boolean read fbAllowRecalc write fbAllowRecalc ;
      procedure RemoveZeroTotalEntries;
      procedure ReCalc;
      procedure PostToAccounts;
      procedure UnPostToAccounts;
      procedure SetPayRateAmount;

      function GetBasedOnWage(iBasedOnID: integer): double;
      function GetBasedOnHourlyRate(iBasedOnID: integer): double;
   End;

implementation


uses Controls,SysUtils,BusObjPayBASE,BusObjConst,
  BusObjEmployeepayrates,Dialogs,AppEnvironment, CommonLib,
  tcDataUtils, PayCommon, BusObjLeavetypes, MyAccess, PayAccounts,
  ERPDbComponents, DbSharedObjectsObj, PayConst, LogLib;


{========================================================
         Tpayspayrates
========================================================}
constructor Tpayspayrates.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   AllowRecalc := True;
   fSQL := 'SELECT * FROM tblpayspayrates';
   fdTotalHrs := 0.00;
   fChangeSuperDefaultResult := -1;
end;

destructor Tpayspayrates.Destroy;
begin
   inherited;
end;

Function Tpayspayrates.GetTotalIncludedInSuper:double;
begin
  fTotalIncludedInSuper := 0;
  Self.IterateRecords(CallbackTotalIncludedInSuper);
  Result := fTotalIncludedInSuper;
end;

procedure Tpayspayrates.CallbackTotalIncludedInSuper(const Sender: TBusObj; var Abort: Boolean);
begin 
  if SuperInc then begin
    if (*IsLeave(PayRateID)*)Payrate.IsLeave then begin
      if Tpaybase(Self.Owner).EmployeeDetails.Paysuperonleaveloading then begin
        fTotalIncludedInSuper := fTotalIncludedInSuper + TPayspayrates(Sender).Linetotal;
      end else begin
          //assume one record for each leave type in employee leave  {WRONG ASSUMTION; FIX THIS!}
        if Tpaybase(Self.Owner).EmployeeLeave.Dataset.Locate('Type',(*GetPayRate(PayRateID)*)Payrate.Description,[loCaseInsensitive])     then begin
          fTotalIncludedInSuper := fTotalIncludedInSuper + (TPayspayrates(Sender).Linetotal/(1 + (Tpaybase(Self.Owner).EmployeeLeave.Leaveloading /100)));
        end;
      end;
      exit;
    end;
    fTotalIncludedInSuper := fTotalIncludedInSuper + TPayspayrates(Sender).Linetotal;
  end;
end;

Function Tpayspayrates.GetHourlyRate:double;
var
  strsql:string;
begin
  try
    //not loaded initially
    if Self.Dataset.RecordCount = 0 then Self.LoadSelect('PayID = ' + IntToStr(TPayBase(Self.Owner).PayID));

    fdTotal := 0.00;
    fdTotalStandardHrs := 0.00;
    fdTotalNonAccumLeaveHrs := 0;
//    fdTotalHrs := 0.00;
    fdTotalHrsForAccrual:= 0;
    fdHourlyRate := 0.00;
    fiHourlyRateTypeCount := 0;
    fdTotalStandardAmount := 0;

    strsql := 'SELECT PayID, Sum(LineTotal) AS totalAmount FROM tblpayspayrates' +
                ' WHERE PayID = ' + IntToStr(PayID) + ' GROUP BY PayID;';
    With GetNewDataSet(strsql, True) do try
      fdTotal  := fieldByname('totalAmount').asFloat;
    finally
      if active then close;
      Free;
    end;

    strsql := 'SELECT *, Sum(Qty) AS totalAmount FROM tblpayspayrates PS ' +
                'inner join tblpayrates PR on PS.PayRateID = PR.RateID ' +
                ' WHERE PS.PayID = ' + IntToStr(PayID) +
                ' and PR.multiplier = 1' +
                ' and PS.PayRateID = 2' +
                ' GROUP BY PS.PayID;';
    With GetNewDataSet(strsql, True) do try
      fdTotalStandardHrs  := fieldByname('totalAmount').asFloat;
    finally
      if active then close;
      Free;
    end;

    strsql := 'SELECT *, Sum(LineTotal) AS totalAmount FROM tblpayspayrates PS ' +
                'inner join tblpayrates PR on PS.PayRateID = PR.RateID ' +
                ' WHERE PayID = ' + IntToStr(PayID) +
                ' and PR.multiplier = 1 ' +
                ' and PS.PayRateID = 2' +
                ' GROUP BY PS.PayID;';
    With GetNewDataSet(strsql, True) do try
      fdTotalStandardAmount  := fieldByname('totalAmount').asFloat;
    finally
      if active then close;
      Free;
    end;

    if fdTotalStandardHrs <= 0 then begin
      //If No Total Standard Hours on Pay get it from Employee Rates
      fdTotalStandardHrs := tpaybase(Self.Owner).EmployeePayRates.TotalStandardHrs;
    end;
    //Calc hourly rate
    fdHourlyRate := DivZer(fdTotalStandardAmount, fdTotalStandardHrs);
    tpaybase(Self.Owner).Wages := fdTotal;
    Result := fdHourlyRate;

  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;

end;

function Tpayspayrates.GetHoursForAccrual(const RateType: string): double;
var
  qry: TERPQuery;
begin
  qry := DbSharedObj.GetQuery(self.Connection.Connection);
  try
    qry.SQL.Add('SELECT pr.PayID, Sum(pr.Qty) AS totalHours');
    qry.SQL.Add('FROM tblpayspayrates pr, tblpayrates p, tblpays py');
    qry.SQL.Add('WHERE pr.PayRateID = p.RateID');
    qry.SQL.Add('and py.PayID = pr.PayId');
    qry.SQL.Add('AND pr.PayID = ' + IntToStr(PayID));
    if SameText(RateType, 'Annual Leave') then begin
      if not AppEnv.PayPrefs.LeaveAccrueDuringAL then
        qry.SQL.Add('and ((p.Description in ("RDO","Special Leave")) or (p.IsLeave = "F"))');
      if not AppEnv.PayPrefs.RDOAccrueDuringAL then
        qry.SQL.Add('and ((not p.Description in ("RDO","Special Leave")) or (p.IsLeave = "F"))');
    //end else if SameText(RateType, 'Sick Leave') then begin
    end else if SameText(RateType,  Appenv.RegionalOptions.SLName ) then begin
      if not AppEnv.PayPrefs.LeaveAccrueDuringSick then
        qry.SQL.Add('and ((p.Description in ("RDO","Special Leave")) or (p.IsLeave = "F"))');
      if not AppEnv.PayPrefs.RDOAccrueDuringSick then
        qry.SQL.Add('and ((not p.Description in ("RDO","Special Leave")) or (p.IsLeave = "F"))');
    end
    else if SameText(RateType, 'Leave without Pay') then begin
      if not AppEnv.PayPrefs.LeaveAccrueDuringUL then
        qry.SQL.Add('and ((p.Description in ("RDO","Special Leave")) or (p.IsLeave = "F"))');
      if not AppEnv.PayPrefs.RDOAccrueDuringUL then
        qry.SQL.Add('and ((not p.Description in ("RDO","Special Leave")) or (p.IsLeave = "F"))');
    end;
    { do not include any leaves in total hours if this is a final pay ... }
    qry.SQL.Add('AND (not (py.IsTermination = "T" and p.IsLeave = "T"))');
    qry.SQL.Add('AND p.AccrueLeave = "T"');
    qry.SQL.Add('GROUP BY pr.PayID');
    qry.Open;
    result:= qry.FieldByName('totalHours').AsFloat;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure Tpayspayrates.PostToAccounts;
begin
  try
    Self.IterateRecords(CallBackPostToAccounts);
  except

  end;
end;

procedure Tpayspayrates.UnPostToAccounts;
begin
  try
    Self.IterateRecords(CallBackUnPostToAccounts);
  except

  end;
end;

procedure Tpayspayrates.CallBackUnPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
var
  CreditAccountId, DebitAccountId: integer;
begin
  CreditAccountId:= PayAccounts.BankAccountID(Tpaybase(Self.Owner).Employeeid);
  DebitAccountId:= PayAccounts.NetWagesAccountID(Tpaybase(Self.Owner).Employeeid);

  { if this is for an accruable leave we need to change the debit account from
    expence account to liability (to reduce the liability we have already accrued) }

//  if PayRate.IsLeave and TLeavetypes.AccreLiabilityForLeave(PayRate.Description) then
//    DebitAccountId:= AppEnv.PayPrefs.LeaveLiabilityAccountID;

  Tpaybase(Self.Owner).PayTrans.LoadSelect('PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
                 ' AND Type = ' + '"Payroll Gross Wages" AND MSType = "'+MSType_GrossWages+'" ' +
                 ' AND Description = "Gross Wages - ' + (*GetPayRate(PayRateID)*)Payrate.Description + ' : ' + (*GetPayRateType(TypeID)*)Payrate.Description + '"' +
                 ' AND PayLineID = ' + IntToStr(ID));


  Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions(13,'Payroll Gross Wages', MSType_GrossWages,
                 'Gross Wages - ' + (*GetPayRate(PayRateID)*)Payrate.Description + ' : ' + (*GetPayRateType(TypeID)*)Payrate.Description,
                 CreditAccountId,DebitAccountId,
                 ClassID, ID,0{LineTotal * -1}, self);
end;


procedure Tpayspayrates.CallBackPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
var
  CreditAccountId, DebitAccountId: integer;
begin
  CreditAccountId:= PayAccounts.BankAccountID(Tpaybase(Self.Owner).Employeeid);
  DebitAccountId:= PayAccounts.NetWagesAccountID(Tpaybase(Self.Owner).Employeeid);

{ we have now decided that this is wrong! }
//  { if this is for an accruable leave we need to change the debit account from
//    expence account to liability (to reduce the liability we have already accrued) }
//
//  if PayRate.IsLeave and TLeavetypes.AccreLiabilityForLeave(PayRate.Description) then
//    DebitAccountId:= AppEnv.PayPrefs.LeaveLiabilityAccountID;

  Tpaybase(Self.Owner).PayTrans.LoadSelect('PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
                 ' AND Type = ' + '"Payroll Nett Wages" AND MSType = "'+MSType_GrossWages+'" ' +
                 ' AND Description = "Nett Wages - ' + Payrate.Description + ' : ' + Payrate.Description + '"' +
                 ' AND PayLineID = ' + IntToStr(ID));


  Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions(14,'Payroll Nett Wages', MSType_GrossWages,
                 'Nett Wages - ' + Payrate.Description + ' : ' + Payrate.Description,
                 CreditAccountId,DebitAccountId,
                 ClassID, ID,LineTotal - TPaybase(Self.Owner).PayTax.TotlEmployeeTaxForPayPayRate(ID), self); //   TPaybase(Self.Owner).paytotals.TaxableTotals.TotalTaxForRateAndLineID(PayRate.Description{'PayRate'},ID), self);
end;

function Tpayspayrates.GetTotalHours(AccrualOnly: boolean = false): double;
var
  strsql: string;
begin
  strsql:=
    'SELECT pr.PayID, Sum(pr.Qty) AS totalHours ' +
    'FROM tblpayspayrates pr, tblpayrates p ' +
    'WHERE pr.PayRateID = p.RateID ' +
    'AND pr.PayID = ' + IntToStr(PayID) + ' ';
  if AccrualOnly then
    strsql:= strsql +
      'and p.AccrueLeave = "T" ';
  strsql:= strsql +
    'GROUP BY pr.PayID;';
  with GetNewDataSet(strsql, True) do begin
    try
      result:= fieldByname('totalHours').asFloat;
    finally
      Free;
    end;
  end;
end;

procedure Tpayspayrates.ReCalc;
var
  strsql:string;
begin
  try
    if not AllowRecalc then exit;
    //not loaded initially
    if Self.Dataset.RecordCount = 0 then Self.LoadSelect('PayID = ' + IntToStr(TPayBase(Self.Owner).PayID));

  //  Self.RemoveZeroTotalEntries;  //maybe payroll preferences

    fdTotal := 0.00;
    fdTotalStandardHrs := 0.00;
    fdTotalNonAccumLeaveHrs := 0;
    fdTotalHrs := 0.00;
    fdTotalHrsForAccrual:= 0;
    fdHourlyRate := 0.00;
    fiHourlyRateTypeCount := 0;
    fdTotalStandardAmount := 0;

    fdTotalHrs:= GetTotalHours;
    fdTotalHrsForAccrual:= GetTotalHours(true);
     clog('');
    strsql := 'SELECT PayID, Sum(LineTotal) AS totalAmount FROM tblpayspayrates' +
                ' WHERE PayID = ' + IntToStr(PayID) + ' GROUP BY PayID;';
    With GetNewDataSet(strsql, True) do try
      fdTotal  := fieldByname('totalAmount').asFloat;
    finally
      if active then close;
      Free;
    end;
    logtext('fdTotal =' + floattostr(fdTotal));
    logtext(strSQL);

    strsql := 'SELECT *, Sum(Qty) AS totalAmount FROM tblpayspayrates PS ' +
                'inner join tblpayrates PR on PS.PayRateID = PR.RateID ' +
                ' WHERE PS.PayID = ' + IntToStr(PayID) +
                ' and PR.multiplier = 1' +
                ' GROUP BY PS.PayID;';
    With GetNewDataSet(strsql, True) do try
      fdTotalStandardHrs  := fieldByname('totalAmount').asFloat;
    finally
      if active then close;
      Free;
    end;
    logtext('fdTotalStandardHrs =' + floattostr(fdTotalStandardHrs));
    logtext(strSQL);

    strsql := 'SELECT *, Sum(LineTotal) AS totalAmount FROM tblpayspayrates PS ' +
                'inner join tblpayrates PR on PS.PayRateID = PR.RateID ' +
                ' WHERE PayID = ' + IntToStr(PayID) +
                ' and PR.multiplier = 1 ' +
                ' GROUP BY PS.PayID;';
    With GetNewDataSet(strsql, True) do try
      fdTotalStandardAmount  := fieldByname('totalAmount').asFloat;
    finally
      if active then close;
      Free;
    end;
    logtext('fdTotalStandardAmount =' + floattostr(fdTotalStandardAmount));
    logtext(strSQL);

    if fdTotalStandardHrs <= 0 then begin
      //If No Total Standard Hours on Pay get it from Employee Rates
      fdTotalStandardHrs := tpaybase(Self.Owner).EmployeePayRates.TotalStandardHrs;
    end;
    //Calc hourly rate
    fdHourlyRate := DivZer(fdTotalStandardAmount, fdTotalStandardHrs);

    logtext('fdTotalStandardHrs =' + floattostr(fdTotalStandardHrs));
    logtext('fdHourlyRate =' + floattostr(fdHourlyRate));
    logtext('fdTotal =' + floattostr(fdTotal));


    tpaybase(Self.Owner).Wages := fdTotal;
  except

  end;
end;

function Tpayspayrates.GetBasedOnWage(iBasedOnID: integer): double;
begin
  fdTempHrs     := 0;
  fdTempAmount  := 0;
  Self.Dataset.Filter :=  GetBasedOnFilter(iBasedOnID);
  Self.Dataset.Filtered := True;
  Self.IterateRecords(CallbackSumTemps);
  Self.Dataset.Filtered := False;
  Result := fdTempAmount;
end;

function Tpayspayrates.GetBasedOnHourlyRate(iBasedOnID: integer): double;
begin
  fdTempHrs     := 0;
  fdTempAmount  := 0;
  Self.Dataset.Filter := GetBasedOnFilter(iBasedOnID);
  Self.Dataset.Filtered := True;
  Self.IterateRecords(CallbackSumTemps,False);
  Result := DivZer(fdTempAmount,fdTempHrs);
  Self.Dataset.Filtered := False;
end;

procedure Tpayspayrates.CallbackSumTemps(const Sender: TBusObj; var Abort: Boolean);
begin
  fdTempAmount  := fdTempAmount + LineTotal;
  fdTempHrs     := fdTempHrs + Qty;
end;

procedure Tpayspayrates.RemoveZeroTotalEntries;
begin
  Self.First;
  while not Self.EOF do begin
    if RoundCurrency(LineTotal) = 0.00 then begin
      try
        Self.Delete;
      except
      end;
    end;
    Self.Next;
  end;
end;



procedure   Tpayspayrates.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Payid');
  SetPropertyFromNode(Node,'Payrateid');
  SetPropertyFromNode(Node,'Typeid');
  SetPropertyFromNode(Node,'Qty');
  SetPropertyFromNode(Node,'Amount');
  SetPropertyFromNode(Node,'Linetotal');
  SetBooleanPropertyFromNode(Node,'Superinc');
  SetPropertyFromNode(Node,'Clientid');
  SetPropertyFromNode(Node,'Classid');
  SetPropertyFromNode(Node,'Classname');
  SetPropertyFromNode(Node,'Timesheetid');
end;


procedure   Tpayspayrates.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Payid' ,Payid);
  AddXMLNode(node,'Payrateid' ,Payrateid);
  AddXMLNode(node,'Typeid' ,Typeid);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Linetotal' ,Linetotal);
  AddXMLNode(node,'Superinc' ,Superinc);
  AddXMLNode(node,'Clientid' ,Clientid);
  AddXMLNode(node,'Classid' ,Classid);
  AddXMLNode(node,'Classname' ,DepartmentName);
  AddXMLNode(node,'Timesheetid' ,Timesheetid);
end;


function    Tpayspayrates.ValidateData :Boolean ;
var
  tmpResultStatus: TResultStatusItem;

  function AllQtyZero: boolean;
  var qry: TMyQuery;
  begin
    qry:= TMyQuery.Create(nil);
    try
      qry.Connection:= self.Connection.Connection;
      qry.SQL.Text:= self.sql;
      qry.SQL.Add('and Qty <> 0');
      qry.Open;
      result:= qry.IsEmpty;
    finally
      qry.Free;
    end;
  end;

begin
   Result := False;
   Resultstatus.Clear;
   Try
     if Tpaybase(Self.Owner).ValidationDisabled then begin
       Result := True;
       exit;
     end;
     if Payrateid = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_PayPayrates_Err_NoRate,  'Pay rate should not be blank' );
        Exit;
     end;
     if Typeid = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_PayPayrates_Err_NoType,  'Type should not be blank'  );
        Exit;
     end;
     if (Qty = 0) and AllQtyZero then begin
        Resultstatus.AddItem(False , rssError , BOR_PayPayrates_Err_NoQty,  'Hours Qty should not be 0' );
        Exit;
     end;
     if DepartmentName = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_PayPayrates_Err_NoDepartment,  'Department name should not be blank' );
        Exit;
     end;
     Result := true;
   Finally
    If not Result then Begin
      tmpResultStatus := ResultStatus.GetLastStatusItem;
      if Assigned(tmpResultStatus) then
        TBusobj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code),BusobjEventVal_FailedHoursValidateData);
    end;
   end;
end;


function    Tpayspayrates.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure Tpayspayrates.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
   if (ChangeType <> dcSave) then exit;
end;


procedure Tpayspayrates.SetPayRateAmount;
begin
  Amount := (*GetPayRateMultiplier(PayRateID) *) Payrate.Multiplier*  Tpaybase(Self.Owner).EmployeePayRates.HighestStandardHourlyRate;
end;

procedure Tpayspayrates.DoFieldOnChange(Sender: TField);
var
  iPeriod:integer;
  dlgResult: integer;
begin
     if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
     if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

     if tpaybase(Self.Owner).CreatingNewPay then exit;
     if TypeID = 0 then exit;  // type not set yet
     if PayRateID = 0 then exit;
     dlgResult := mrNo;
     if Sysutils.SameText(Sender.fieldname , 'Superinc') then begin
      if Superinc <> PayRate.IsSuperEnabled then begin
        if Assigned(confirmFromGUI) then begin
          if (fChangeSuperDefaultResult <> 100 {mrYesToAll}) then begin
            dlgResult := fconfirmFromGUI('Do you wish to update the Super default flag for this Pay Rate?' , [mbYes, mbYesToAll, mbNo]);
            fChangeSuperDefaultResult := dlgResult;
          end;

          if (fChangeSuperDefaultResult = 100 {mrYesToAll}) or (dlgResult = mrYes) then begin
            if Payrate.Lock = false then begin
                ResultStatus.AddItem(False, rssWarning , 0,  StringReplace(Payrate.UserLock.LockMessage , 'Unable to update data.' , 'Unable to change the Super flag in Pay Rate:' + Payrate.Description  + ' .' +chr(13) , [rfIgnoreCase])  );
            end else begin
              Payrate.IsSuperEnabled := Superinc;
              Payrate.PostDB;
            end;
          end;
        end;
      end;
      if Tpaybase(Self.Owner).RecalcInProgress = False then Tpaybase(Self.Owner).RecalcAll;
     end;
     if (*IsLeave(PayRateID)*)Payrate.IsLeave then exit; //don't want leaves edited from payrates.

     inherited;
      if Sysutils.SameText(Sender.FieldName , 'Classname') then begin
        ClassID := tcDatautils.GetDeptID(DepartmentName);
      end;
     if Sysutils.SameText(Sender.FieldName , 'PayRateID') then begin
       Amount := (*GetPayRateMultiplier(PayRateID) *)PayRate.Multiplier*  Tpaybase(Self.Owner).EmployeePayRates.HighestStandardHourlyRate;
       Superinc := PayRate.IsSuperEnabled;
     end;
     if (Sysutils.SameText(Sender.FieldName , 'Qty')) or (Sysutils.SameText(Sender.FieldName , 'PayRateID'))
       or (Sysutils.SameText(Sender.FieldName , 'TypeID')) or (Sysutils.SameText(Sender.FieldName , 'HourlyRate')) then begin
      if  TypeID = GetPayRateTypeID('Annual Payment') then begin
        if Tpaybase(Self.Owner).EmployeeDetails.Payperiod = 'Weekly' then begin
          iPeriod := 52;
        end else if Tpaybase(Self.Owner).EmployeeDetails.Payperiod = 'Fortnightly' then begin
          iPeriod := 26;
        end else if Tpaybase(Self.Owner).EmployeeDetails.Payperiod = 'Monthly' then begin
          iPeriod := 12;
        end else if Tpaybase(Self.Owner).EmployeeDetails.Payperiod = 'Bi-Monthly' then begin
          iPeriod := 24;
        end else begin
          iPeriod := 52;
        end;
        LineTotal  := RoundCurrency(Divzer((Amount * Qty),iPeriod));
        PostDB;
        if Tpaybase(Self.Owner).RecalcInProgress = False then Tpaybase(Self.Owner).RecalcAll;
      end else if (TypeID = GetPayRateTypeID('Salary')) then begin
        LineTotal := RoundCurrency(GetHourlyRate   * Qty);           //Amount * Qty);
        Amount := LineTotal;
        PostDB;
        if Tpaybase(Self.Owner).RecalcInProgress = False then Tpaybase(Self.Owner).RecalcAll;
      end else begin
        if (PayRateID = (tcdatautils.GetPayRateID('Normal Hours')))
          and (TypeID = GetPayRateTypeID('Hourly Rate'))
          or (TypeID = GetPayRateTypeID('CDEP'))   then begin
            LineTotal := RoundCurrency(Amount * Qty);
            PostDB;
            if Tpaybase(Self.Owner).RecalcInProgress = False then Tpaybase(Self.Owner).RecalcAll;

        end else begin
          LineTotal := RoundCurrency(Amount * Qty);
          PostDB;
          if Tpaybase(Self.Owner).RecalcInProgress = False then Tpaybase(Self.Owner).RecalcAll;
        end;
      end;
  end;

  if (Sysutils.SameText(Sender.FieldName , 'Amount')) then begin
    if  TypeID = GetPayRateTypeID('Annual Payment') then begin
      if Tpaybase(Self.Owner).EmployeeDetails.Payperiod = 'Weekly' then begin
          iPeriod := 52;
        end else if Tpaybase(Self.Owner).EmployeeDetails.Payperiod = 'Fortnightly' then begin
          iPeriod := 26;
        end else if Tpaybase(Self.Owner).EmployeeDetails.Payperiod = 'Monthly' then begin
          iPeriod := 12;
        end else if Tpaybase(Self.Owner).EmployeeDetails.Payperiod = 'Bi-Monthly' then begin
          iPeriod := 24;
        end else begin
          iPeriod := 52;
        end;
        LineTotal  := RoundCurrency(Divzer(Amount,iPeriod));
        PostDB;
        if Tpaybase(Self.Owner).RecalcInProgress = False then Tpaybase(Self.Owner).RecalcAll;
    end else if (TypeID = GetPayRateTypeID('Salary')) then begin
      LineTotal := RoundCurrency(Amount);// * Qty);
      Amount := LineTotal; 
      PostDB;
      if Tpaybase(Self.Owner).RecalcInProgress = False then Tpaybase(Self.Owner).RecalcAll;
    end else begin
      LineTotal := Amount * Qty;
      PostDb;
      if Tpaybase(Self.Owner).RecalcInProgress = False then Tpaybase(Self.Owner).RecalcAll;
    end;
  end;
end;

Function Tpayspayrates.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  Tpayspayrates.GetIDField : String;
begin
   Result := 'Payspayrateid'
end;

class function Tpayspayrates.GetBusObjectTablename: string;
begin
  Result := 'tblpayspayrates';
end;



Function  Tpayspayrates.DoBeforePost(Sender :TDatasetBusObj ):Boolean;
begin
  Result := inherited DoBeforePost(Sender);
end;

{Property functions}
Function  Tpayspayrates.GetPayid        :Integer   ; begin Result := GetIntegerField('Payid');End;
Function  Tpayspayrates.GetPayrateid    :Integer   ; begin Result := GetIntegerField('Payrateid');End;
Function  Tpayspayrates.GetTypeid       :Integer   ; begin Result := GetIntegerField('Typeid');End;
Function  Tpayspayrates.GetQty          :Double    ; begin Result := GetFloatField('Qty');End;
Function  Tpayspayrates.GetAmount       :Double    ; begin Result := GetFloatField('Amount');End;
Function  Tpayspayrates.GetLinetotal    :Double    ; begin Result := GetFloatField('Linetotal');End;
Function  Tpayspayrates.GetSuperinc     :Boolean   ; begin Result := GetBooleanField('Superinc');End;
Function  Tpayspayrates.GetClientid     :Integer   ; begin Result := GetIntegerField('Clientid');End;
Function  Tpayspayrates.GetClassID      :Integer   ; begin Result := GetIntegerField('Classid');End;
Function  Tpayspayrates.GetClassname    :String    ; begin Result := GetStringField('Classname');End;
Function  Tpayspayrates.GetTimesheetid  :Integer   ; begin Result := GetIntegerField('Timesheetid');End;
Procedure Tpayspayrates.SetPayid        (Const Value :Integer   ); begin SetIntegerField('Payid'         , Value);End;
Procedure Tpayspayrates.SetPayrateid    (Const Value :Integer   ); begin SetIntegerField('Payrateid'     , Value);End;
Procedure Tpayspayrates.SetTypeid       (Const Value :Integer   ); begin SetIntegerField('Typeid'        , Value);End;
Procedure Tpayspayrates.SetQty          (Const Value :Double    ); begin SetFloatField('Qty'           , Value);End;
Procedure Tpayspayrates.SetAmount       (Const Value :Double    ); begin SetFloatField('Amount'        , Value);End;
Procedure Tpayspayrates.SetLinetotal    (Const Value :Double    ); begin SetFloatField('Linetotal'     , Value);End;
Procedure Tpayspayrates.SetSuperinc     (Const Value :Boolean   ); begin SetBooleanField('Superinc'      , Value);End;
Procedure Tpayspayrates.SetClientid     (Const Value :Integer   ); begin SetIntegerField('Clientid'      , Value);End;
Procedure Tpayspayrates.setClassID      (Const Value :Integer   ); begin SetIntegerField('Classid'       , Value);End;
Procedure Tpayspayrates.SetClassname    (Const Value :String    ); begin SetStringField('Classname'     , Value);End;
Procedure Tpayspayrates.SetTimesheetid  (Const Value :Integer   ); begin SetIntegerField('Timesheetid'   , Value);End;

function Tpayspayrates.getPayRateObj: TPayRate;
begin
  Result := TPayRate(getContainerComponent(TPayRate, 'RateID = '+ IntToStr(PayRateID)));
end;

function Tpayspayrates.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
  if Assigned(Self.Owner) then
    if Self.Owner is Tpaybase then begin
      PayId := Tpaybase(Self.Owner).ID;
      DepartmentName := Tpaybase(Self.Owner).EmployeeDetails.Defaultclassname;
      ClassID := tcDatautils.GetDeptID(DepartmentName);
    end;
  Result := inherited DoAfterInsert(Sender);
end;

initialization
RegisterClassOnce(Tpayspayrates);


end.
