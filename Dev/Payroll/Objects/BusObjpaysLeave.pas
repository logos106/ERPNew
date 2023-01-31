unit BusObjpaysLeave;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   22/05/07   1.00.01   A.   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
   Tpaysleave = class(TMSBusObj)

   private
      fSickLeaveHrs                 :double;
      fNonSickLeaveHrs              :double;
      fLeaveChanged                 :boolean;
      fTotalLeaveLoading       :double;
      Function GetPayid             :Integer   ;
      Function GetLeavetype         :String    ;
      Function GetLeavepaytype      :String    ;
      Function GetQty               :Double    ;
      Function GetAmount            :Double    ;
      Function GetSuperinc          :Boolean   ;
      Function GetClientid          :Integer   ;
      Function GetClassID           :Integer   ;
      Function GetDatetaken         :TDatetime ;
      Function GetClassname         :String    ;
      Function GetIscertified       :Boolean   ;
      Function GetTakenFrom         :TDatetime ;
      Function GetTakenTo         :TDatetime ;

      Function GetLeaveChanged      :Boolean   ;
      Function GetNonTaxableLeaveLoading : Double;

      Procedure SetPayid             (Const Value :Integer   );
      Procedure SetLeavetype         (Const Value :String    );
      Procedure SetLeavepaytype      (Const Value :String    );
      Procedure SetQty               (Const Value :Double    );
      Procedure SetAmount            (Const Value :Double    );
      Procedure SetSuperinc          (Const Value :Boolean   );
      Procedure SetClientid          (Const Value :Integer   );
      Procedure setClassID           (Const Value :Integer   );
      Procedure SetDatetaken         (Const Value :TDatetime );
      Procedure SetClassname         (Const Value :String    );
      Procedure SetIscertified       (Const Value :Boolean   );
      Procedure SetTakenFrom         (Const Value :TDatetime );
      Procedure SetTakenTo           (Const Value :TDatetime );

      Procedure SetLeaveChanged      (Const Value :Boolean   );
      procedure CallbackAddLeaveToPay(const Sender: TBusObj; var Abort: Boolean);

   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function  DoBeforePost(Sender :TDatasetBusObj ):Boolean;             Override;
      procedure CallBackPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
      procedure CallBackUnPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
      procedure CallbackReAdjustPayRates(const Sender: TBusObj; var Abort: Boolean);
      procedure CallBackTotalLeaveLoading(const Sender: TBusObj; var Abort: Boolean);
      procedure SetNormalHrsToInitialTotal;

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

      procedure UpdatePayRatesWithLeaves;
      procedure PostToAccounts;
      procedure UnPostToAccounts;
      function  GetThisPayLeaveHrsEntitlement(const LeaveType:String):double;
      function  GetLeaveTotalHrs(const LeaveType:string):double;
      procedure AdjustNormalHrsOnDeleteLeave(const LeaveHrs:double);

   Published

      Property Payid              :Integer      Read getPayid           Write SetPayid       ;
      Property Leavetype          :String       Read getLeavetype       Write SetLeavetype   ;
      Property Leavepaytype       :String       Read getLeavepaytype    Write SetLeavepaytype;
      Property Qty                :Double       Read GetQty             Write SetQty         ;
      Property Amount             :Double       Read getAmount          Write SetAmount      ;
      Property Superinc           :Boolean      Read getSuperinc        Write SetSuperinc    ;
      Property Clientid           :Integer      Read getClientid        Write SetClientid    ;
      Property Classid            :Integer      Read GetClassID         Write setClassID     ;
      Property Datetaken          :TDatetime    Read getDatetaken       Write SetDatetaken   ;
      Property DepartmentName     :String       Read getClassname       Write SetClassname   ;
      Property Iscertified        :Boolean      Read getIscertified     Write SetIscertified ;
      Property TakenFrom          :TDatetime    Read getTakenFrom       Write SetTakenFrom;
      Property TakenTo            :TDatetime    Read getTakenTo         Write SetTakenTo;


      Property LeaveChanged       :Boolean       Read GetLeaveChanged    Write SetLeaveChanged;
      Property NonTaxableLeaveLoading :double    Read GetNonTaxableLeaveLoading;

   End;


implementation


uses BusObjPaybase,SysUtils,DnMLib,BusObjLeaveAccruals,Dialogs,PayCommon,
  CommonLib,BusObjConst,AppEnvironment,DateUtils,Variants, PayConst,
  tcDataUtils,Math, tcConst, frmDelayMessageDlg, PayAccounts;


{========================================================
         Tpaysleave
========================================================}
constructor Tpaysleave.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblpaysleave';
end;

destructor Tpaysleave.Destroy;
begin
   inherited;
end;


procedure Tpaysleave.PostToAccounts;
begin
  Self.IterateRecords(CallbackPostToAccounts,False);
end;

procedure Tpaysleave.UnPostToAccounts;
begin
  Self.IterateRecords(CallbackUnPostToAccounts,False);
end;

procedure Tpaysleave.CallBackPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
var
  CreditAccID: integer;
  DebitAccID: integer;
begin
  { Note: Leave Taken postings where wrong.
          The postings for leave (accrual) are to the liability account and
          expense account so when leave is taken we need to reduce the liability
          and reduce the expence (cos expence already recorded at accrual time)}
  DebitAccID := PayAccounts.LeaveLiabilityAccountID(Tpaybase(Self.Owner).Employeeid);
  CreditAccID := PayAccounts.LeaveProvisionAccountID(Tpaybase(Self.Owner).Employeeid);

  Tpaybase(Self.Owner).PayTrans.LoadSelect('PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
                                ' AND Type = "Payroll Leave Taken" AND MSType = "'+MSType_LeaveTaken+'"' +
                                ' AND Description = '+ QuotedStr(LeaveType + ' Taken') +
                                ' AND PayLineID = ' + IntToStr(ID));

  Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions(11,'Payroll Leave Taken',MSType_LeaveTaken,
                                LeaveType + ' Taken',CreditAccID,
                                DebitAccID,ClassID, ID,Qty*Amount, self);
end;

procedure Tpaysleave.CallBackUnPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
var
  CreditAccID: integer;
  DebitAccID: integer;
begin
  { Note: Leave Taken postings where wrong.
          The postings for leave (accrual) are to the liability account and
          expense account so when leave is taken we need to reduce the liability
          and reduce the expence (cos expence already recorded at accrual time)}
  DebitAccID := PayAccounts.LeaveLiabilityAccountID(Tpaybase(Self.Owner).Employeeid);
  CreditAccID := PayAccounts.LeaveProvisionAccountID(Tpaybase(Self.Owner).Employeeid);

  Tpaybase(Self.Owner).PayTrans.LoadSelect('PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
                                ' AND Type = "Payroll Leave Taken" AND MSType = "'+MSType_LeaveTaken+'"' +
                                ' AND Description = '+ QuotedStr(LeaveType + ' Taken') +
                                ' AND PayLineID = ' + IntToStr(ID));

  Tpaybase(Self.Owner).PayTrans.PostToPaysTransactions(12,'Payroll Leave Taken',MSType_LeaveTaken,
                                LeaveType + ' Taken',CreditAccID,
                                DebitAccID,ClassID, ID,Qty*Amount * -1, self);
end;

Function  Tpaysleave.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
      if Self.Owner is Tpaybase then begin
        PayId := Tpaybase(Self.Owner).ID;
        DepartmentName := Tpaybase(Self.Owner).EmployeeDetails.Defaultclassname;
      end;
   Result := inherited DoAfterInsert(Sender);
end;

Function Tpaysleave.GetNonTaxableLeaveLoading : Double;
begin
 //Get the total leave loading amount for the year
  fTotalLeaveLoading := 0;
  Self.IterateRecords(CallBackTotalLeaveLoading);
  if fTotalLeaveLoading < AppEnv.CompanyPrefs.LeaveLoadTaxThreshold then begin
    result:= fTotalLeaveLoading;
  end
  else begin
    result:= AppEnv.CompanyPrefs.LeaveLoadTaxThreshold;
  end;
end;


procedure Tpaysleave.CallBackTotalLeaveLoading(const Sender: TBusObj; var Abort: Boolean);
begin
  fTotalLeaveLoading := fTotalLeaveLoading +
     (GetLeaveLoading(Tpaybase(Self.Owner).Employeeid,LeaveType) * TPaybase(Self.Owner).EmployeePayRates.HighestStandardHourlyRate * Qty);
end;

procedure Tpaysleave.SetNormalHrsToInitialTotal;
var          {assumes leave taken hours will are not more than the original standard hours}
  sqlStr:string;
  dTotalHrs:double;
  bNormalHoursSet :Boolean;
begin
  bNormalHoursSet := False;
   sqlStr := 'SELECT PayID, Sum(Qty) AS totalAmount FROM tblpayspayrates, tblpayrates' +
             ' where tblpayspayrates.PayRateID = tblpayrates.RateId' +
             ' and tblpayspayrates.PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
             ' AND (tblpayspayrates.PayRateId = 2 or tblpayrates.IsLeave = "T")' +
             ' GROUP BY tblpayspayrates.PayID;';
    With GetNewDataSet(sqlStr, True) do try
      dTotalHrs  := fieldByname('totalAmount').asFloat;
    finally
      Free;
    end;

    with Tpaybase(Self.Owner).PaysPayRates.Dataset do begin
      First;
      While not Eof do begin
        if Tpaybase(Self.Owner).PaysPayRates.Payrateid = 2 then begin  //normal hours
          if not bNormalHoursSet then begin
            Tpaybase(Self.Owner).PaysPayRates.Qty := dTotalHrs;
//            Tpaybase(Self.Owner).PaysPayRates.Qty := Tpaybase(Self.Owner).NormalHours;
            bNormalHoursSet := True;
          end else begin
            Tpaybase(Self.Owner).PaysPayRates.Delete;
          end;  
        end;
        Next;
      end;
    end;
end;

procedure Tpaysleave.UpdatePayRatesWithLeaves;
begin
  try
    //set normal hours back to the initial total
    SetNormalHrsToInitialTotal;

    Tpaybase(Self.Owner).PaysPayRates.First;

    if fLeaveChanged then begin
      { set normal hours back to total of all hours before calling
        CallbackReAdjustPayRates which will reduce normal hours for each non-normal
        rate type ie annual leave, sick leave etc }
      //if Tpaybase(Self.Owner).PaysPayRates.Locate('PayRateId',2,[]) then
      //  Tpaybase(Self.Owner).PaysPayRates.Qty:= Tpaybase(Self.Owner).PaysPayRates.GetTotalHours;
      // Removed the above 2 lines because if there is more than one type of
      // hours (eg Normal hours and Time and a half hours) they all get added
      // togeather onto the normal hours line which makes no sense.

      // The following will reduce normal hours by annual leave hours etc
      Self.IterateRecords(CallbackReAdjustPayRates,False);
    end;


    Tpaybase(Self.Owner).PaysPayRates.RemoveZeroTotalEntries;

    //delete all old leaves from payrates
    with Tpaybase(Self.Owner).PaysPayRates.Dataset do begin
      First;
      While not Eof do begin
        if IsLeave(Tpaybase(Self.Owner).PaysPayRates.PayRateID) then begin
          Delete;
        end else begin
          Next;
        end;
      end;
    end;
    fSickLeaveHrs := 0;
    fNonSickLeaveHrs := 0;

    //copy all leaves to payrates
    Tpaybase(Self.Owner).PaysPayRates.AllowRecalc := False;
    Self.IterateRecords(CallbackAddLeaveToPay,False);
    Tpaybase(Self.Owner).PaysPayRates.AllowRecalc := True;
    Tpaybase(Self.Owner).PaysPayRates.PostDb;
  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;
end;


function  Tpaysleave.GetLeaveTotalHrs(const LeaveType:string):double;
var
  sqlStr:string;
begin
  sqlStr := 'SELECT PayID,LeaveType, Sum(Qty) AS totalAmount FROM tblpaysleave' +
                ' WHERE PayID = ' + IntToStr(Tpaybase(Self.Owner).PayID) +
                ' AND LeaveType = ' + QuotedStr(LeaveType) + ' GROUP BY PayID;';
    With GetNewDataSet(sqlStr, True) do try
      Result  := fieldByname('totalAmount').asFloat;
    finally
      if active then close;
      Free;
    end;
end;

procedure Tpaysleave.CallbackReAdjustPayRates(const Sender: TBusObj; var Abort: Boolean);
var
  tmpTotalLeaveHrs:double;
  dRemainder:double;
begin
  Tpaybase(Self.Owner).PaysPayRates.First;
  tmpTotalLeaveHrs := 0;       //get total of this leave in payspayrates
  while not (Tpaybase(Self.Owner).PaysPayRates.EOF) do begin
    if Self.Leavetype  = PayCommon.GetLeaveType(Tpaybase(Self.Owner).PaysPayRates.Payrateid) then
      tmpTotalLeaveHrs := tmpTotalLeaveHrs +  Tpaybase(Self.Owner).PaysPayRates.Qty;
    Tpaybase(Self.Owner).PaysPayRates.Next;
  end;

  Tpaybase(Self.Owner).PaysPayRates.First;
  dRemainder := GetLeaveTotalHrs(Self.Leavetype) - tmpTotalLeaveHrs;//dDiff; //initialise
  while not (Tpaybase(Self.Owner).PaysPayRates.EOF) do begin
    if Tpaybase(Self.Owner).PaysPayRates.Payrateid = 2 then begin  //normal hours
      if dRemainder <= Tpaybase(Self.Owner).PaysPayRates.Qty then  begin
        Tpaybase(Self.Owner).PaysPayRates.Qty := Tpaybase(Self.Owner).PaysPayRates.Qty - Qty;
        dRemainder := 0;
        Tpaybase(Self.Owner).PaysPayRates.PostDb;
      end else begin
        dRemainder := Qty - Tpaybase(Self.Owner).PaysPayRates.Qty ;
        Tpaybase(Self.Owner).PaysPayRates.Qty := 0;
        Tpaybase(Self.Owner).PaysPayRates.PostDb;
      end;
    end;
    Tpaybase(Self.Owner).PaysPayRates.Next;
  end;
  Tpaybase(Self.Owner).PaysPayRates.RemoveZeroTotalEntries;
end;

procedure Tpaysleave.AdjustNormalHrsOnDeleteLeave(const LeaveHrs:double);
begin
  if Tpaybase(Self.Owner).PaysPayRates.Dataset.Locate('PayrateID',2,[]) then
    Tpaybase(Self.Owner).PaysPayRates.Qty  := Tpaybase(Self.Owner).PaysPayRates.Qty +  LeaveHrs;
end;


procedure Tpaysleave.CallbackAddLeaveToPay(const Sender: TBusObj; var Abort: Boolean);
begin
  Tpaybase(Self.Owner).PaysPayRates.New;
  Tpaybase(Self.Owner).PaysPayRates.Payid := Tpaysleave(Sender).Payid;
  Tpaybase(Self.Owner).PaysPayRates.Classid := Tpaysleave(Sender).Classid;
  Tpaybase(Self.Owner).PaysPayRates.DepartmentName := Tpaysleave(Sender).DepartmentName;
  Tpaybase(Self.Owner).PaysPayRates.Payrateid := GetPayRateID(Tpaysleave(Sender).LeaveType);
  Tpaybase(Self.Owner).PaysPayRates.SuperInc:= Tpaybase(Self.Owner).PaysPayRates.payrate.IsSuperEnabled;
  Tpaybase(Self.Owner).PaysPayRates.Qty := Tpaysleave(Sender).Qty;
  Tpaybase(Self.Owner).PaysPayRates.Amount := Tpaysleave(Sender).Amount;
  Tpaybase(Self.Owner).PaysPayRates.Linetotal := Tpaysleave(Sender).Qty * Tpaysleave(Sender).Amount;
  Tpaybase(Self.Owner).PaysPayRates.Typeid := GetPayRateTypeID('Hourly Rate');
  //if LeaveType = 'Sick Leave' then
  if LeaveType =  Appenv.RegionalOptions.SLName  then
    fSickLeaveHrs := fSickLeaveHrs + Tpaysleave(Sender).Qty else fNonSickLeaveHrs := fNonSickLeaveHrs + Tpaysleave(Sender).Qty ;
  Tpaybase(Self.Owner).PaysPayRates.PostDb;
end;


procedure   Tpaysleave.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Payid');
  SetPropertyFromNode(Node,'Leavetype');
  SetPropertyFromNode(Node,'Leavepaytype');
  SetPropertyFromNode(Node,'Qty');
  SetPropertyFromNode(Node,'Amount');
  SetBooleanPropertyFromNode(Node,'Superinc');
  SetPropertyFromNode(Node,'Clientid');
  SetPropertyFromNode(Node,'Classid');
  SetDateTimePropertyFromNode(Node,'Datetaken');
  SetPropertyFromNode(Node,'Classname');
  SetBooleanPropertyFromNode(Node,'Iscertified');
end;


procedure   Tpaysleave.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Payid' ,Payid);
  AddXMLNode(node,'Leavetype' ,Leavetype);
  AddXMLNode(node,'Leavepaytype' ,Leavepaytype);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Superinc' ,Superinc);
  AddXMLNode(node,'Clientid' ,Clientid);
  AddXMLNode(node,'Classid' ,Classid);
  AddXMLNode(node,'Datetaken' ,Datetaken);
  AddXMLNode(node,'Classname' ,DepartmentName);
  AddXMLNode(node,'Iscertified' ,Iscertified);
end;


function    Tpaysleave.ValidateData :Boolean ;
var
  tmpResultStatus: TResultStatusItem;
begin
   Result := False;
   Resultstatus.Clear;
   Try
     if Tpaybase(Self.Owner).ValidationDisabled then begin
       Result := True;
       exit;
     end;
     if Leavetype = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_PayLeaves_Err_NoType,  'Leave type should not be blank'  );
        Exit;
     end;
        if Datetaken = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_PayLeaves_Err_NoDateTaken,  'Date for leave taken should not be blank'  );
        Exit;
     end;
     if Qty = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_PayLeaves_Err_NoQty ,  'Leave Hours should not be 0'  );
        Exit;
     end;
     if DepartmentName = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_PayLeaves_Err_NoDepartment,  'Department for leave taken should not be blank'  );
        Exit;
     end;
     if (TakenFrom <> 0) and (TakenTo <> 0) then begin
       if TakenFrom > TakenTo then begin
         Resultstatus.AddItem(False , rssError , BOR_PayLeaves_Err_FromAfterTo,'Leave taken From date cannot be on or after To date.');
         exit;
       end;
     end;
     Result := true;
   Finally
    If not Result then Begin
      tmpResultStatus := ResultStatus.GetLastStatusItem;
      if Assigned(tmpResultStatus) then
        TBusobj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code),BusobjEventVal_FailedLeavesValidateData);
    end;
   end;
end;


function    Tpaysleave.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure Tpaysleave.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if ChangeType <> dcSave then exit;
end;

function Tpaysleave.GetThisPayLeaveHrsEntitlement(const LeaveType:string):double;
var
  ThisPayLeaveHrsEntitlement:double;
  intDays: double;
  intWeeks: double;
//  intMonths: double;
//  intYears: double;
//  intBirthdays: integer;
//  dtTemp: TDateTime;
  bCalcAccrual: boolean;
  dtLastAccruedDate: TDateTime;
  dAccrueHours: double;
  dYTDSickHours: double;
  dYTDSickHoursRemaining: double;
  dMaxSickLeaveDays:double;
begin
   ThisPayLeaveHrsEntitlement := 0;

   tpaybase(Self.Owner).EmployeeLeave.First;
   while not tpaybase(Self.Owner).EmployeeLeave.EOF do begin
     bCalcAccrual := False;      

     if tpaybase(Self.Owner).EmployeeLeave.Accrueddate > 0 then begin
       dtLastAccruedDate := tpaybase(Self.Owner).EmployeeLeave.Accrueddate;
     end else begin
       dtLastAccruedDate := Tpaybase(Self.Owner).EmployeeDetails.Datestarted;
     end;

     if tpaybase(Self.Owner).EmployeeLeave.LeaveType = LeaveType then begin
       dAccrueHours := tpaybase(Self.Owner).EmployeeLeave.Accruehours;
       if tpaybase(Self.Owner).EmployeeLeave.Accrueafterperiod = 'Pay' then begin
         bCalcAccrual := True;
       end else if tpaybase(Self.Owner).EmployeeLeave.Accrueafterperiod = 'Week' then begin
         intWeeks := WeeksBetweenSigned(Tpaybase(Self.Owner).PayDate,Tpaybase(Self.Owner).EmployeeDetails.DateStarted);
          if intWeeks >= tpaybase(Self.Owner).EmployeeLeave.Accrueafterno then begin
            bCalcAccrual := True;
          end;

       end;

       if (tpaybase(Self.Owner).EmployeeLeave.UseStartEndDates) and (bCalcAccrual = true) then begin
         if VarIsNull(tpaybase(Self.Owner).EmployeeLeave.StartDate) then begin
           if (Tpaybase(Self.Owner).PayDate > tpaybase(Self.Owner).EmployeeLeave.StartDate) and
             (Tpaybase(Self.Owner).PayDate < tpaybase(Self.Owner).EmployeeLeave.EndDate) then begin
             bCalcAccrual := true;
           end else begin
             bCalcAccrual := false;
           end;
         end else begin
           bCalcAccrual := true;   //if date empty calc anyway
         end;
       end;

       if bCalcAccrual then begin           {Setup Fields}
         intDays := DaysBetweenSigned(Tpaybase(Self.Owner).PayDate, dtLastAccruedDate); {DaysBetweenSigned(Now,Then)}
         if intDays <= 0 then begin
           intDays := DaysBetweenSigned(Tpaybase(Self.Owner).PayDate, Tpaybase(Self.Owner).PayFromDate) + 1;
         end;

         intWeeks := Divzer(intDays, 7);

         if tpaybase(Self.Owner).EmployeeLeave.AccruePeriod = 'Hour'  then begin
           {Hours}
           if (Tpaybase(Self.Owner).PaysPayRates.TotalHours > 0.00) then begin
             ThisPayLeaveHrsEntitlement := ThisPayLeaveHrsEntitlement + (Tpaybase(Self.Owner).PaysPayRates.TotalHours *
               Divzer(dAccrueHours, tpaybase(Self.Owner).EmployeeLeave.AccrueNo));
           end;
         end else if tpaybase(Self.Owner).EmployeeLeave.AccruePeriod = 'Pay' then begin
           {Pay}
           ThisPayLeaveHrsEntitlement := ThisPayLeaveHrsEntitlement + Divzer(tpaybase(Self.Owner).EmployeeLeave.Accruehours,tpaybase(Self.Owner).EmployeeLeave.AccrueNo);
         end else if tpaybase(Self.Owner).EmployeeLeave.AccruePeriod = 'Week' then begin
           {Week}
           if intWeeks >= 1 then begin
             ThisPayLeaveHrsEntitlement := ThisPayLeaveHrsEntitlement + (tpaybase(Self.Owner).EmployeeLeave.Accruehours * (intWeeks * tpaybase(Self.Owner).EmployeeLeave.AccrueNo));
           end;
         end;

        // if sick leave, will the accrual go over the yearly threshold?
         //if tpaybase(Self.Owner).EmployeeLeave.LeaveType = 'Sick Leave' then begin
         if tpaybase(Self.Owner).EmployeeLeave.LeaveType =  Appenv.RegionalOptions.SLName  then begin
           dMaxSickLeaveDays:=
             getAwardSickLeaveDaysThreshold(tpaybase(Self.Owner).EmployeeDetails.Award);
           if dMaxSickLeaveDays <> 0 then begin
             { award has a threshold for total number of sick days employees can
               accumulate ... so use this }
             if (tpaybase(Self.Owner).EmployeeLeave.AccruedHours + ThisPayLeaveHrsEntitlement) >
               (dMaxSickLeaveDays  * AppEnv.CompanyPrefs.HoursPerWeek/5) then begin
               { accrue only enough sick leave to reach max }
               ThisPayLeaveHrsEntitlement := (dMaxSickLeaveDays  * AppEnv.CompanyPrefs.HoursPerWeek/5) - tpaybase(Self.Owner).EmployeeLeave.AccruedHours;
             end else begin
               ThisPayLeaveHrsEntitlement := tpaybase(Self.Owner).EmployeeLeave.AccrueHours;
             end;
           end
           else if AppEnv.CompanyPrefs.SickLeaveDays > 0 then  begin
             { ... else use the max number of days PER YEAR from company pref }
             dYTDSickHours:=
               //TPayBase(Self.Owner).LeaveAccruals.GetYTDHrs('Sick Leave',TPayBase(Self.Owner).PayDate);
               TPayBase(Self.Owner).LeaveAccruals.GetYTDHrs( Appenv.RegionalOptions.SLName ,TPayBase(Self.Owner).PayDate);
             dYTDSickHoursRemaining:=
               (AppEnv.CompanyPrefs.SickLeaveDays * (AppEnv.CompanyPrefs.HoursPerWeek/5)) -
                dYTDSickHours;

             if tpaybase(Self.Owner).EmployeeLeave.AccrueHours <= dYTDSickHoursRemaining then begin
               ThisPayLeaveHrsEntitlement := tpaybase(Self.Owner).EmployeeLeave.AccrueHours;
             end
             else begin
               if dYTDSickHoursRemaining > 0 then begin
                 ThisPayLeaveHrsEntitlement:=
                   tpaybase(Self.Owner).EmployeeLeave.AccrueHours - dYTDSickHoursRemaining;
               end
               else begin
                 { negative remaining }
                 ThisPayLeaveHrsEntitlement:=
                   tpaybase(Self.Owner).EmployeeLeave.AccrueHours + dYTDSickHoursRemaining;
               end;
             end;
           end
           else begin
             ThisPayLeaveHrsEntitlement := tpaybase(Self.Owner).EmployeeLeave.AccrueHours;
           end;
         end;
       end;
     end;
     tpaybase(Self.Owner).EmployeeLeave.Next;
   end;
   Result := ThisPayLeaveHrsEntitlement;
end;


procedure Tpaysleave.DoFieldOnChange(Sender: TField);
var
  dHrsEntitled:double;

  procedure ProcessFieldChanges;
  begin
    if LeaveType = '' then exit;
    LeaveChanged := True;
    dHrsEntitled := 0;
    if LeaveType <> '' then begin
      dHrsEntitled := Tpaybase(Self.Owner).LeaveAccruals.GetAccruedHrs(LeaveType,tpaybase(Self.Owner).Paydate) + GetThisPayLeaveHrsEntitlement(LeaveType);
      if Tpaybase(Self.Owner).EmployeeLeave.Locate('Type',LeaveType,[loCaseInsensitive]) then
        dHrsEntitled := dHrsEntitled + Tpaybase(Self.Owner).EmployeeLeave.Openningbalancehrs;
    end;
    if Qty > dHrsEntitled then begin
      DelayMessageDlg('The Amount of Leave requested for ' + tpaybase(Self.Owner).EmployeeDetails.Employeename   + ' is Greater than the Accrued Amount of ' +
      FloatToStr(Round(dHrsEntitled,OtherRoundPlaces)) + ' hrs', mtWarning, [mbOK], 0);
    end;
    //if LeaveType = 'Sick Leave' then begin
    if LeaveType =  Appenv.RegionalOptions.SLName  then begin
      if Qty > Tpaybase(Self.Owner).PaysPayRates.TotalStandardHours then
        //DelayMessageDlg('The Amount of Sick Leave requested is Greater than the employees ' +
        DelayMessageDlg('The Amount of ' + Appenv.RegionalOptions.SLName +' requested is Greater than the employees ' +
        FloatToStr(Round(Tpaybase(Self.Owner).PaysPayRates.TotalStandardHours,OtherRoundPlaces)) + ' Normal hours', mtWarning, [mbOK], 0);
    end;
    Amount := Tpaybase(Self.Owner).PaysPayRates.HourlyRate * ( 1 + GetLeaveLoading(Tpaybase(Self.Owner).EmployeeID,LeaveType));
  end;

begin
//  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
//  if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;

//  dHrsEntitled := 0;
//  if LeaveType <> '' then begin
//    dHrsEntitled := Tpaybase(Self.Owner).LeaveAccruals.GetAccruedHrs(LeaveType,tpaybase(Self.Owner).Paydate) + GetThisPayLeaveHrsEntitlement(LeaveType);
//    if Tpaybase(Self.Owner).EmployeeLeave.Locate('Type',LeaveType,[loCaseInsensitive]) then
//      dHrsEntitled := dHrsEntitled + Tpaybase(Self.Owner).EmployeeLeave.Openningbalancehrs;
//  end;
  fLeaveChanged := True;
  if Sysutils.SameText(Sender.FieldName , 'Classname') then begin
    ClassID := tcDatautils.GetDeptID(DepartmentName);
  end;

  if (Sysutils.SameText(Sender.FieldName , 'TakenFrom')) or (Sysutils.SameText(Sender.FieldName , 'TakenTo'))then begin
    if TakenFrom <> 0 then DateTaken := TakenFrom;
    if (TakenFrom <> 0) and (TakenTo <> 0) then begin
      if TakenFrom > TakenTo then begin
        exit;
      end;
      Qty := (TakenTo - TakenFrom + 1) * AppEnv.CompanyPrefs.HoursPerWeek/5;
      ProcessFieldChanges;
    end;
  end;

//   dHrsEntitled := Tpaybase(Self.Owner).LeaveAccruals.GetYTDHrs(LeaveType,tpaybase(Self.Owner).Paydate) + GetThisPayLeaveHrsEntitlement(LeaveType);
   if Sysutils.SameText(Sender.FieldName , 'Qty') then begin
     ProcessFieldChanges;
   end;
   //Amount := Tpaybase(Self.Owner).PaysPayRates.HourlyRate * ( 1 + GetLeaveLoading(Tpaybase(Self.Owner).EmployeeID,LeaveType));
   if Sysutils.SameText(Sender.FieldName , 'LeaveType') then begin
     ProcessFieldChanges;
   end;
end;



Function Tpaysleave.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  Tpaysleave.GetIDField : String;
begin
   Result := 'Payleaveid'
end;
class function Tpaysleave.GetBusObjectTablename: string;
begin
  Result := 'tblpaysleave';
end;

Function  Tpaysleave.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
   if not result then exit;
   if assigned(Owner) then
    if owner is Tpaybase then
      Tpaybase(Owner).RecalcAll;;
End;


Function  Tpaysleave.DoBeforePost(Sender :TDatasetBusObj ):Boolean;
begin
  ClassID := GetDeptID(DepartmentName);
  Result := inherited DoBeforePost(Sender);
end;



{Property functions}
Function  Tpaysleave.GetPayid       :Integer   ; begin Result := GetIntegerField('Payid');End;
Function  Tpaysleave.GetLeavetype   :String    ; begin Result := GetStringField('LeaveType');End;
Function  Tpaysleave.GetLeavepaytype:String    ; begin Result := GetStringField('Leavepaytype');End;
Function  Tpaysleave.GetQty         :Double    ; begin Result := GetFloatField('Qty');End;
Function  Tpaysleave.GetAmount      :Double    ; begin Result := GetFloatField('Amount');End;
Function  Tpaysleave.GetSuperinc    :Boolean   ; begin Result := GetBooleanField('Superinc');End;
Function  Tpaysleave.GetClientid    :Integer   ; begin Result := GetIntegerField('Clientid');End;
Function  Tpaysleave.GetClassID     :Integer   ; begin Result := GetIntegerField('Classid');End;
Function  Tpaysleave.GetDatetaken   :TDatetime ; begin Result := GetDatetimeField('Datetaken');End;
Function  Tpaysleave.GetClassname   :String    ; begin Result := GetStringField('Classname');End;
Function  Tpaysleave.GetIscertified :Boolean   ; begin Result := GetBooleanField('Iscertified');End;
Function  Tpaysleave.GetTakenFrom   :TDateTime   ; begin Result := GetDateTimeField('TakenFrom');End;
Function  Tpaysleave.GetTakenTo     :TDateTime   ; begin Result := GetDatetimeField('TakenTo');End;
Function  Tpaysleave.GetLeaveChanged :Boolean  ; begin Result := fLeaveChanged; End;
Procedure Tpaysleave.SetPayid       (Const Value :Integer   ); begin SetIntegerField('Payid'        , Value);End;
Procedure Tpaysleave.SetLeavetype   (Const Value :String    ); begin SetStringField('LeaveType'    , Value);End;
Procedure Tpaysleave.SetLeavepaytype(Const Value :String    ); begin SetStringField('Leavepaytype' , Value);End;
Procedure Tpaysleave.SetQty         (Const Value :Double    ); begin SetFloatField('Qty'          , Value);End;
Procedure Tpaysleave.SetAmount      (Const Value :Double    ); begin SetFloatField('Amount'       , Value);End;
Procedure Tpaysleave.SetSuperinc    (Const Value :Boolean   ); begin SetBooleanField('Superinc'     , Value);End;
Procedure Tpaysleave.SetClientid    (Const Value :Integer   ); begin SetIntegerField('Clientid'     , Value);End;
Procedure Tpaysleave.setClassID     (Const Value :Integer   ); begin SetIntegerField('Classid'      , Value);End;
Procedure Tpaysleave.SetDatetaken   (Const Value :TDatetime ); begin SetDatetimeField('Datetaken'    , Value);End;
Procedure Tpaysleave.SetClassname   (Const Value :String    ); begin SetStringField('Classname'    , Value);End;
Procedure Tpaysleave.SetIscertified (Const Value :Boolean   ); begin SetBooleanField('Iscertified'  , Value);End;

Procedure Tpaysleave.SetTakenFrom (Const Value :TDateTime  ); begin SetDatetimeField('TakenFrom'  , Value);End;
Procedure Tpaysleave.SetTakenTo (Const Value :TDateTime  ); begin SetDatetimeField('TakenTo'  , Value);End;

Procedure Tpaysleave.SetLeaveChanged (Const Value :Boolean   ); begin fLeaveChanged := Value;End;



initialization
RegisterClassOnce(Tpaysleave);


end.

