unit BusObjEmployeeLeave;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   16/05/07   1.00.01   A.   Initial Version.

   tblleave - contains leaves and how to accumulate data for each employee
   }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
   TLeave = class(TMSBusObj)
   private
      fVerifyAndFixAccruedLeaves           :boolean;
      fAutoCreateNewLeaveType              :boolean;
      Function GetEmployeeid               :Integer   ;
      Function GetType                     :String    ;
      Function GetAccrueafterno            :Double    ;
      Function GetAccrueafterperiod        :String    ;
      Function GetAccrueno                 :Double    ;
      Function GetAccrueperiod             :String    ;
      Function GetAccruehours              :Double    ;
      Function GetAccruedhours             :Double    ;
      Function GetAccrueddate              :TDatetime ;
      Function GetMaxhours                 :Double    ;
      Function GetTypeid                   :Integer   ;
      Function GetClassID                  :Integer   ;
      Function GetClassname                :String    ;
      Function GetOpenningbalancehrs       :Double    ;
      Function GetOpenningbalancedate      :TDatetime ;
      Function GetStartdate                :TDatetime ;
      Function GetEnddate                  :TDatetime ;
      Function GetUsestartenddates         :Boolean   ;
      Function GetLeaveloading             :Double    ;
      function getCleanAccruedhours: Double;
      Function GetUnits                    :string    ;
      Function GetLeaveName                :string    ;
      Function GetNormalEntitlement        :string    ;
      Function GetShowBalanceOnPayslip     :Boolean   ;
      Function GetActive                   :Boolean   ;

      Procedure SetEmployeeid               (Const Value :Integer   );
      Procedure SetType                     (Const Value :String    );
      Procedure SetAccrueafterno            (Const Value :Double    );
      Procedure SetAccrueafterperiod        (Const Value :String    );
      Procedure SetAccrueno                 (Const Value :Double    );
      Procedure SetAccrueperiod             (Const Value :String    );
      Procedure SetAccruehours              (Const Value :Double    );
      Procedure SetAccruedhours             (Const Value :Double    );
      Procedure SetAccrueddate              (Const Value :TDatetime );
      Procedure SetMaxhours                 (Const Value :Double    );
      Procedure SetTypeid                   (Const Value :Integer   );
      Procedure setClassID                  (Const Value :Integer   );
      Procedure SetClassname                (Const Value :String    );
      Procedure SetOpenningbalancehrs       (Const Value :Double    );
      Procedure SetOpenningbalancedate      (Const Value :TDatetime );
      Procedure SetStartdate                (Const Value :TDatetime );
      Procedure SetEnddate                  (Const Value :TDatetime );
      Procedure SetUsestartenddates         (Const Value :Boolean   );
      Procedure SetLeaveloading             (Const Value :Double    );
      Procedure SetUnits                    (Const Value :string    );
      Procedure SetLeaveName                (Const Value :string    );
      Procedure SetNormalEntitlement        (Const Value :string    );
      Procedure SetShowBalanceOnPayslip     (Const Value :Boolean   );
      Procedure SetActive                   (Const Value :Boolean   );

      procedure CallbackVerifyEmployeeLeave(const Sender: TBusObj; var Abort: Boolean);
      procedure CallbackAccrueLeaves(const Sender: TBusObj; var Abort: Boolean);

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
      Procedure    VerifyEmployeeLeave;
      procedure    AccrueLeaves;
      function     GetTypeLeaveLoading(Const LeaveType:String; Const iEmployeeID:integer):double;
      procedure    CreateNewLeaveType;
      Property CleanAccruedhours         :Double      Read getCleanAccruedhours;

  published
      Property Employeeid                :Integer      Read getEmployeeid             Write SetEmployeeid         ;
      Property LeaveType                 :String       Read getType                   Write SetType               ;
      Property Accrueafterno             :Double       Read getAccrueafterno          Write SetAccrueafterno      ;
      Property Accrueafterperiod         :String       Read getAccrueafterperiod      Write SetAccrueafterperiod  ;
      Property Accrueno                  :Double       Read getAccrueno               Write SetAccrueno           ;
      Property Accrueperiod              :String       Read getAccrueperiod           Write SetAccrueperiod       ;
      Property Accruehours               :Double       Read getAccruehours            Write SetAccruehours        ;
      Property Accruedhours              :Double       Read getAccruedhours           Write SetAccruedhours       ;
      Property Accrueddate               :TDatetime    Read getAccrueddate            Write SetAccrueddate        ;
      Property Maxhours                  :Double       Read getMaxhours               Write SetMaxhours           ;
      Property Typeid                    :Integer      Read getTypeid                 Write SetTypeid             ;
      Property Classid                   :Integer      Read GetClassID                Write setClassID            ;
      Property DepartmentName            :String       Read getClassname              Write SetClassname          ;
      Property Openningbalancehrs        :Double       Read getOpenningbalancehrs     Write SetOpenningbalancehrs ;
      Property Openningbalancedate       :TDatetime    Read getOpenningbalancedate    Write SetOpenningbalancedate;
      Property Startdate                 :TDatetime    Read getStartdate              Write SetStartdate          ;
      Property Enddate                   :TDatetime    Read getEnddate                Write SetEnddate            ;
      Property Usestartenddates          :Boolean      Read getUsestartenddates       Write SetUsestartenddates   ;
      Property Leaveloading              :Double       Read getLeaveloading           Write SetLeaveloading       ;
      property AutoCreateNewLeaveType    :boolean      Read fAutoCreateNewLeaveType   Write fAutoCreateNewLeaveType;
      property VerifyAndFixAccruedLeaves :boolean      read fVerifyAndFixAccruedLeaves Write fVerifyAndFixAccruedLeaves;

      property Units                     :string      read GetUnits                   write SetUnits      ;
      property LeaveName                 :string      read GetLeaveName               write SetLeaveName  ;
      property NormalEntitlement         :string      read GetNormalEntitlement       write SetNormalEntitlement   ;
      property ShowBalanceOnPayslip      :Boolean     read GetShowBalanceOnPayslip    write SetShowBalanceOnPayslip;
      property Active                    :Boolean     read GetActive                  write SetActive;

   end;

implementation

uses BusObjPaybase,BusObjEmployeePay,PayCommon,SysUtils,BusObjLeaveAccruals,
  Variants,DNMLib,DateUtils,AppEnvironment,BusObjConst,CommonLib,BusObjLeaveTypes,
  tcDataUtils, tcConst;

{========================================================
         TLeave
========================================================}
constructor TLeave.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblleave';
end;

function  TLeave.GetTypeLeaveLoading(Const LeaveType:String; Const iEmployeeID:integer):double;
var
  strsql:string;
begin
  strsql := 'SELECT * FROM tblleave ' + ' WHERE Type = ' + QuotedStr(LeaveType)
  + ' AND EmployeeID = ' + IntToStr(iEmployeeID) + ';';
  With GetNewDataSet(strsql, True) do try
    Result  := fieldByname('LeaveLoading').asFloat/100;
  finally
    if active then close;
    Free;
  end;    
end;

destructor TLeave.Destroy;
begin
   inherited;
end;

procedure TLeave.AccrueLeaves;
begin
//  if (Owner is TPayBase) and TPayBase(Owner).IsTermination then
//    exit;
  Self.IterateRecords(CallbackAccrueLeaves,False);
end;

procedure TLeave.CallbackAccrueLeaves(const Sender: TBusObj; var Abort: Boolean);
var
  iNumPays: integer;
  intDays: double;
  intWeeks: double;
  intMonths: double;
  intYears: double;
//  intBirthdays: integer;
//  dtTemp: TDateTime;
  bDoAccrual: boolean;
  dtLastAccruedDate: TDateTime;
  dAccrueHours: double;
  dPayAccruedHours:double;
  dMaxSickLeaveDays:double;
  dTotalAccruedBeforeThisPay:double;
  HoursForAccrual: double;
begin
  // Setup Variables
  dPayAccruedHours := 0;
  bDoAccrual := false;
  dAccrueHours := TLeave(Sender).Accruehours;
  iNumPays := GetNumberOfPays(Self.Employeeid, Tpaybase(Self.Owner).Paydate);

  if TLeave(Sender).Accrueddate > 0 then begin
    dtLastAccruedDate := TLeave(Sender).Accrueddate;
  end else begin
    dtLastAccruedDate := Tpaybase(Self.Owner).EmployeeDetails.Datestarted;
  end;

  // First check if the Accrual threshold has been met for this leave
  if TLeave(Sender).Accrueafterperiod = 'Pay' then begin
    if iNumPays >= TLeave(Sender).Accrueafterno then begin
      bDoAccrual := true;
    end;
  end else if TLeave(Sender).Accrueafterperiod = 'Week' then begin
    intWeeks := WeeksBetweenSigned(Tpaybase(Self.Owner).PayDate,
      Tpaybase(Self.Owner).EmployeeDetails.DateStarted);
    if intWeeks >= TLeave(Sender).AccrueAfterNo then begin
      bDoAccrual := true;
    end
  end else if TLeave(Sender).Accrueafterperiod =  'Month' then begin
    intMonths := MonthsBetweenSigned(Tpaybase(Self.Owner).PayDate,
      Tpaybase(Self.Owner).EmployeeDetails.DateStarted) + 0.00;
    if intMonths >= TLeave(Sender).AccrueAfterNo then begin
      bDoAccrual := true;
    end
  end else if TLeave(Sender).Accrueafterperiod = 'Year' then begin
    intYears := YearsBetweenSigned(Tpaybase(Self.Owner).PayDate,
      Tpaybase(Self.Owner).EmployeeDetails.DateStarted) + 0.00;
    if intYears >= TLeave(Sender).AccrueAfterNo then begin
      bDoAccrual := true;
    end
  end;

  if (TLeave(Sender).UseStartEndDates) and (bDoAccrual = true) then begin
    if VarIsNull(TLeave(Sender).StartDate) then begin
      if (Tpaybase(Self.Owner).PayDate > TLeave(Sender).StartDate) and
        (Tpaybase(Self.Owner).PayDate < TLeave(Sender).EndDate) then begin
        bDoAccrual := true;
      end else begin
        bDoAccrual := false;
      end;
    end else begin
      bDoAccrual := true;   //if date empty go ahead and accrue
    end;
  end;

  if bDoAccrual then begin
    {Setup Fields}

    intDays := DaysBetweenSigned(Tpaybase(Self.Owner).PayDate, dtLastAccruedDate); {DaysBetweenSigned(Now,Then)}
    if intDays <= 0 then begin
      intDays := DaysBetweenSigned(Tpaybase(Self.Owner).PayDate, Tpaybase(Self.Owner).PayFromDate) + 1;
    end;

    intWeeks := Divzer(intDays, 7);

    if TLeave(Sender).AccruePeriod = 'Hour'  then begin
      {Hours}

//      if (Tpaybase(Self.Owner).PaysPayRates.TotalHoursForAccrual > 0.00) then begin
//        dPayAccruedHours := dPayAccruedHours + (Tpaybase(Self.Owner).PaysPayRates.TotalHoursForAccrual *
//          Divzer(dAccrueHours, TLeave(Sender).AccrueNo));
//      end;
      HoursForAccrual := Tpaybase(Self.Owner).PaysPayRates.GetHoursForAccrual(TLeave(Sender).LeaveType);
      if (HoursForAccrual > 0.00) then begin
        dPayAccruedHours := dPayAccruedHours + (HoursForAccrual * Divzer(dAccrueHours, TLeave(Sender).AccrueNo));
      end;
    end else if TLeave(Sender).AccruePeriod = 'Pay' then begin
      {Pay}
      dPayAccruedHours := dPayAccruedHours + Divzer(dAccrueHours, TLeave(Sender).AccrueNo);
    end else if TLeave(Sender).AccruePeriod = 'Week' then begin
      {Week}
      if intWeeks >= 1 then begin
        dPayAccruedHours := dPayAccruedHours + (dAccruehours * intWeeks * TLeave(Sender).AccrueNo);
      end;
    end;

     // if sick leave, will the accrual go over the yearly threshold?
    //if TLeave(Sender).LeaveType = 'Sick Leave' then begin   //TO DO awards
    if TLeave(Sender).LeaveType =  Appenv.RegionalOptions.SLName  then begin   //TO DO awards
      if temployeepay(Self.Owner).Award.Sickleavedaysthreshold <> 0 then begin
        dMaxSickLeaveDays := temployeepay(Self.Owner).Award.Sickleavedaysthreshold;
      end else begin
        dMaxSickLeaveDays := AppEnv.CompanyPrefs.SickLeaveDays;
      end;

      if  dMaxSickLeaveDays <> 0 then begin
        if (TLeave(Sender).AccruedHours + dPayAccruedHours) > (dMaxSickLeaveDays  * AppEnv.CompanyPrefs.HoursPerWeek/5) then begin
          //accrue only enough sick leave to reach max
          dPayAccruedHours := (dMaxSickLeaveDays  * AppEnv.CompanyPrefs.HoursPerWeek/5) - TLeave(Sender).AccruedHours;
        end;
      end;
    end;
  end;
  if VerifyAndFixAccruedLeaves then begin
    if Tpaybase(Self.Owner).LeaveAccruals.Dataset.Locate('PayId;LeaveType',
            VarArrayOf([Tpaybase(Self.Owner).PayId,TLeave(Sender).LeaveType]),[]) then begin
      Tpaybase(Self.Owner).LeaveAccruals.Accruedhours := dPayAccruedHours;
      Tpaybase(Self.Owner).LeaveAccruals.PostDb;

      dTotalAccruedBeforeThisPay := Tpaybase(Self.Owner).LeaveAccruals.GetAccruedHrsUpToThisPay(TLeave(Sender).LeaveType);

      dPayAccruedHours:= Tpaybase(Self.Owner).LeaveAccruals.GetThisPayAccruedHrs(TLeave(Sender).LeaveType);
      Accruedhours := dPayAccruedHours + dTotalAccruedBeforeThisPay + OpenningBalanceHrs;
    //  Self.PostDb;
    end;
  end
  else begin
    Tpaybase(Self.Owner).LeaveAccruals.New;
    Tpaybase(Self.Owner).LeaveAccruals.Payid := Tpaybase(Self.Owner).PayID;
    Tpaybase(Self.Owner).LeaveAccruals.Date := Tpaybase(Self.Owner).Paydate;
    Tpaybase(Self.Owner).LeaveAccruals.Leavetype := TLeave(Sender).LeaveType;
    Tpaybase(Self.Owner).LeaveAccruals.Leavetypeid := TLeave(Sender).Typeid;
    Tpaybase(Self.Owner).LeaveAccruals.Currenthourlyrate := Tpaybase(Self.Owner).EmployeePayRates.Hourlyrate;
    Tpaybase(Self.Owner).LeaveAccruals.Accruedhours := dPayAccruedHours;
    Tpaybase(Self.Owner).LeaveAccruals.PostDb;

    Accruedhours := Round(Tpaybase(Self.Owner).LeaveAccruals.GetAccruedHrs(TLeave(Sender).LeaveType) + OpenningBalanceHrs,GeneralRoundPlaces);
    AccruedDate  := Tpaybase(Self.Owner).Paydate;

    { now check for any Pay Rates with Extra Leave Accluals of this leave type }
    Tpaybase(Self.Owner).PaysPayRates.First;
    while not Tpaybase(Self.Owner).PaysPayRates.EOF do begin
      if Tpaybase(Self.Owner).PaysPayRates.PayRate.ExtraLeaveAccrual and
         (Tpaybase(Self.Owner).PaysPayRates.PayRate.ExtraLeaveTypeID = TLeave(Sender).Typeid) then begin

        Tpaybase(Self.Owner).LeaveAccruals.New;
        Tpaybase(Self.Owner).LeaveAccruals.Payid := Tpaybase(Self.Owner).PayID;
        Tpaybase(Self.Owner).LeaveAccruals.Date := Tpaybase(Self.Owner).Paydate;
        Tpaybase(Self.Owner).LeaveAccruals.Leavetype := TLeave(Sender).LeaveType;
        Tpaybase(Self.Owner).LeaveAccruals.Leavetypeid := TLeave(Sender).Typeid;
        Tpaybase(Self.Owner).LeaveAccruals.Currenthourlyrate := Tpaybase(Self.Owner).EmployeePayRates.Hourlyrate;

        Tpaybase(Self.Owner).LeaveAccruals.Accruedhours :=
          Tpaybase(Self.Owner).PaysPayRates.Qty * Tpaybase(Self.Owner).PaysPayRates.PayRate.ExtraLeaveMultiplier;
        Tpaybase(Self.Owner).LeaveAccruals.PostDb;
        Accruedhours := Tpaybase(Self.Owner).LeaveAccruals.GetAccruedHrs(Tpaybase(Self.Owner).LeaveAccruals.Leavetype) + OpenningBalanceHrs;
        AccruedDate  := Tpaybase(Self.Owner).Paydate;

      end;
      Tpaybase(Self.Owner).PaysPayRates.Next;
    end;

  end;
end;

Procedure TLeave.VerifyEmployeeLeave;
begin
   { for each LeaveType in the pay, ReCalc AccruedHoursTotal from tblleaveaccruals
    and assign that value to AccuredHours in tblleave, also set date to last pay date }
  Self.IterateRecords(CallbackVerifyEmployeeLeave);
end;

procedure TLeave.CallbackVerifyEmployeeLeave(const Sender: TBusObj; var Abort: Boolean);
var
  dTotalAccruedHrs:double;
begin
  {total the accumulated hours for the LeaveType from tblleaveaccrual and write to the accruedhours
   and date := LastDatePaid}

 // Tpaybase(Self.Owner).LeaveAccruals.LoadSelect('EmployeeID = ' + IntToStr(Tpaybase(Self.Owner).Employeeid) +
//      ' AND LeaveType = ' + QuotedStr(TLeave(Sender).LeaveType ));

  dTotalAccruedHrs := 0;
  with Tpaybase(Self.Owner).LeaveAccruals.Dataset do begin
    First;
    while not Eof do begin
      if Tpaybase(Self.Owner).LeaveAccruals.Leavetype = TLeave(Sender).LeaveType then begin
        if Tpaybase(Self.Owner).LeaveAccruals.Payid = Tpaybase(Self.Owner).PayID then begin
          if not Tpaybase(Self.Owner).Deleted then begin
            dTotalAccruedHrs := dTotalAccruedHrs + Tpaybase(Self.Owner).LeaveAccruals.Accruedhours;
          end;
        end
        else begin
          dTotalAccruedHrs := dTotalAccruedHrs + Tpaybase(Self.Owner).LeaveAccruals.Accruedhours;
        end;
      end;
      Next;
    end;
    TLeave(Sender).Accruedhours := dTotalAccruedHrs + OpenningBalanceHrs;
    TLeave(Sender).Accrueddate  := GetLastPayDate(Tpaybase(Self.Owner).Employeeid, Self.Connection);
  end; 
end;

Function  TLeave.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
      if Self.Owner is Temployeepay then begin
        EmployeeId := Temployeepay(Self.Owner).EmployeeDetails.id;
        DepartmentName := Temployeepay(Self.Owner).EmployeeDetails.Defaultclassname;
      end;
    Result := inherited DoAfterInsert(Sender);            
end;

procedure   TLeave.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Employeeid');
  SetPropertyFromNode(Node,'LeaveType');
  SetPropertyFromNode(Node,'Accrueafterno');
  SetPropertyFromNode(Node,'Accrueafterperiod');
  SetPropertyFromNode(Node,'Accrueno');
  SetPropertyFromNode(Node,'Accrueperiod');
  SetPropertyFromNode(Node,'Accruehours');
  SetPropertyFromNode(Node,'Accruedhours');
  SetDateTimePropertyFromNode(Node,'Accrueddate');
  SetPropertyFromNode(Node,'Maxhours');
  SetPropertyFromNode(Node,'Typeid');
  SetPropertyFromNode(Node,'Classid');
  SetPropertyFromNode(Node,'Classname');
  SetPropertyFromNode(Node,'Openningbalancehrs');
  SetDateTimePropertyFromNode(Node,'Openningbalancedate');
  SetDateTimePropertyFromNode(Node,'Startdate');
  SetDateTimePropertyFromNode(Node,'Enddate');
  SetBooleanPropertyFromNode(Node,'Usestartenddates');
  SetPropertyFromNode(Node,'Leaveloading');
end;


procedure   TLeave.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Employeeid' ,Employeeid);
  AddXMLNode(node,'LeaveType' ,LeaveType);
  AddXMLNode(node,'Accrueafterno' ,Accrueafterno);
  AddXMLNode(node,'Accrueafterperiod' ,Accrueafterperiod);
  AddXMLNode(node,'Accrueno' ,Accrueno);
  AddXMLNode(node,'Accrueperiod' ,Accrueperiod);
  AddXMLNode(node,'Accruehours' ,Accruehours);
  AddXMLNode(node,'Accruedhours' ,Accruedhours);
  AddXMLNode(node,'Accrueddate' ,Accrueddate);
  AddXMLNode(node,'Maxhours' ,Maxhours);
  AddXMLNode(node,'Typeid' ,Typeid);
  AddXMLNode(node,'Classid' ,Classid);
  AddXMLNode(node,'Classname' ,DepartmentName);
  AddXMLNode(node,'Openningbalancehrs' ,Openningbalancehrs);
  AddXMLNode(node,'Openningbalancedate' ,Openningbalancedate);
  AddXMLNode(node,'Startdate' ,Startdate);
  AddXMLNode(node,'Enddate' ,Enddate);
  AddXMLNode(node,'Usestartenddates' ,Usestartenddates);
  AddXMLNode(node,'Leaveloading' ,Leaveloading);
end;

function    TLeave.ValidateData :Boolean ;
//var
//  tmpResultStatus: TResultStatusItem;
begin
   Result := False;
   Resultstatus.Clear;
   Try
     if Employeeid = 0 then begin
        Resultstatus.AddItem(False , rssError , 0,  'Employeeid should not be 0');
        Exit;
     end;
     if LeaveType = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeeLeave_Err_NoType,  'Leave type should not be blank' );
        SendEvent(IntToStr(BOR_EmployeeLeave_Err_NoType),BusobjEventVal_FailedLeavesValidateData);
        Exit;
     end;
     if Accrueafterperiod = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeeLeave_Err_NoAccrueAfterPeriod,  'Accrueafterperiod should not be blank' );
        SendEvent(IntToStr(BOR_EmployeeLeave_Err_NoAccrueAfterPeriod),BusobjEventVal_FailedLeavesValidateData);
        Exit;
     end;
     if Accrueperiod = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeeLeave_Err_AccruePeriod,  'Accrueperiod should not be blank');
        SendEvent(IntToStr(BOR_EmployeeLeave_Err_AccruePeriod),BusobjEventVal_FailedLeavesValidateData);
        Exit;
     end;
     if Accruehours = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeeLeave_Err_NoAccrueNo,  'Accruehours should not be 0');
        SendEvent(IntToStr(BOR_EmployeeLeave_Err_NoAccrueNo),BusobjEventVal_FailedLeavesValidateData);
        Exit;
     end;
     if Typeid = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeeLeave_Err_NoType,  'Typeid should not be 0');
        SendEvent(IntToStr(BOR_EmployeeLeave_Err_NoType),BusobjEventVal_FailedLeavesValidateData);
        Exit;
     end;
     if DepartmentName = '' then begin
        Resultstatus.AddItem(False , rssError , BOR_EmployeeLeave_Err_NoDepartment,  'Department name should not be blank');
        SendEvent(IntToStr(BOR_EmployeeLeave_Err_NoDepartment),BusobjEventVal_FailedLeavesValidateData);
        Exit;
     end;
     Result := true;
   Finally
//    If not Result then Begin
//      tmpResultStatus := ResultStatus.GetLastStatusItem;
//      if Assigned(tmpResultStatus) then
//        TBusobj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code),BusobjEventVal_FailedLeavesValidateData);
//    end;
   end;
end;


function TLeave.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
   PostDb;
end;

procedure TLeave.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;

procedure TLeave.CreateNewLeaveType;
begin
  TEmployeePay(Self.Owner).LeaveTypes.New;
  TEmployeePay(Self.Owner).LeaveTypes.Leavetype             := Leavetype;
  TEmployeePay(Self.Owner).LeaveTypes.Accrueliability       := True;
  TEmployeePay(Self.Owner).LeaveTypes.Active                := True;

  TEmployeePay(Self.Owner).LeaveTypes.PostDb;
    //new payrate
  SendEvent(BusobjEventVal_HandleNewPayRate,BusObjEvent_Change );
end;

procedure TLeave.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
  if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName , 'Classname') then begin
    ClassID := tcDatautils.GetDeptID(DepartmentName);
  end;
   if (Sysutils.SameText(Sender.FieldName , 'LeaveType')) then
     TypeID := GeTLeaveTypeID(LeaveType);

   if (Sysutils.SameText(Sender.FieldName , 'Type')) then begin
     TypeID := GetLeaveTypeID(LeaveType);
     if TypeID = 0 then begin
       if fAutoCreateNewLeaveType then begin
         CreateNewLeaveType;
       end else begin
         SendEvent(BusobjEventVal_HandleNewLeaveType,BusObjEvent_Change );
       end;
       if fAutoCreateNewLeaveType then CreateNewLeaveType;
     end;
   end;

   if (Sysutils.SameText(Sender.FieldName , 'OpenningBalanceHrs')) then
      AccruedHours := CleanAccruedhours  + OpenningBalanceHrs;

end;



Function TLeave.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  TLeave.GetIDField : String;
begin
   Result := 'Leaveid'
end;

class function TLeave.GetBusObjectTablename: string;
begin
  Result := 'tblleave';
end;

Function  TLeave.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  TLeave.GetEmployeeid         :Integer   ; begin Result := GetIntegerField('Employeeid');End;
Function  TLeave.GetType               :String    ; begin Result := GetStringField('Type');End;
Function  TLeave.GetAccrueafterno      :Double    ; begin Result := GetFloatField('Accrueafterno');End;
Function  TLeave.GetAccrueafterperiod  :String    ; begin Result := GetStringField('Accrueafterperiod');End;
Function  TLeave.GetAccrueno           :Double    ; begin Result := GetFloatField('Accrueno');End;
Function  TLeave.GetAccrueperiod       :String    ; begin Result := GetStringField('Accrueperiod');End;
Function  TLeave.GetAccruehours        :Double    ; begin Result := GetFloatField('Accruehours');End;
Function  TLeave.GetAccruedhours       :Double    ; begin Result := GetFloatField('Accruedhours');End;
Function  TLeave.GetAccrueddate        :TDatetime ; begin Result := GetDatetimeField('Accrueddate');End;
Function  TLeave.GetMaxhours           :Double    ; begin Result := GetFloatField('Maxhours');End;
Function  TLeave.GetTypeid             :Integer   ; begin Result := GetIntegerField('Typeid');End;
Function  TLeave.GetClassID            :Integer   ; begin Result := GetIntegerField('Classid');End;
Function  TLeave.GetClassname          :String    ; begin Result := GetStringField('Classname');End;
Function  TLeave.GetOpenningbalancehrs :Double    ; begin Result := GetFloatField('Openningbalancehrs');End;
Function  TLeave.GetOpenningbalancedate:TDatetime ; begin Result := GetDatetimeField('Openningbalancedate');End;
Function  TLeave.GetStartdate          :TDatetime ; begin Result := GetDatetimeField('Startdate');End;
Function  TLeave.GetEnddate            :TDatetime ; begin Result := GetDatetimeField('Enddate');End;
Function  TLeave.GetUsestartenddates   :Boolean   ; begin Result := GetBooleanField('Usestartenddates');End;
Function  TLeave.GetLeaveloading       :Double    ; begin Result := GetFloatField('Leaveloading');End;
Function  TLeave.GetUnits              :string    ; begin Result := GetStringField('Units');End;
Function  TLeave.GetLeaveName          :string    ; begin Result := GetStringField('LeaveName');End;
Function  TLeave.GetNormalEntitlement  :string    ; begin Result := GetStringField('NormalEntitlement');End;
Function  TLeave.GetShowBalanceOnPayslip       :Boolean   ; begin Result := GetBooleanField('ShowBalanceOnPayslip');End;
Function  TLeave.GetActive             :Boolean   ; begin Result := GetBooleanField('Active');End;

Procedure TLeave.SetEmployeeid         (Const Value :Integer   ); begin SetIntegerField('Employeeid'          , Value);End;
Procedure TLeave.SetType               (Const Value :String    ); begin SetStringField('Type'                , Value);End;
Procedure TLeave.SetAccrueafterno      (Const Value :Double    ); begin SetFloatField('Accrueafterno'       , Value);End;
Procedure TLeave.SetAccrueafterperiod  (Const Value :String    ); begin SetStringField('Accrueafterperiod'   , Value);End;
Procedure TLeave.SetAccrueno           (Const Value :Double    ); begin SetFloatField('Accrueno'            , Value);End;
Procedure TLeave.SetAccrueperiod       (Const Value :String    ); begin SetStringField('Accrueperiod'        , Value);End;
Procedure TLeave.SetAccruehours        (Const Value :Double    ); begin SetFloatField('Accruehours'         , Value);End;
Procedure TLeave.SetAccruedhours       (Const Value :Double    ); begin SetFloatField('Accruedhours'        , Value);End;
Procedure TLeave.SetAccrueddate        (Const Value :TDatetime ); begin SetDatetimeField('Accrueddate'         , Value);End;
Procedure TLeave.SetMaxhours           (Const Value :Double    ); begin SetFloatField('Maxhours'            , Value);End;
Procedure TLeave.SetTypeid             (Const Value :Integer   ); begin SetIntegerField('Typeid'              , Value);End;
Procedure TLeave.setClassID            (Const Value :Integer   ); begin SetIntegerField('Classid'             , Value);End;
Procedure TLeave.SetClassname          (Const Value :String    ); begin SetStringField('Classname'           , Value);End;
Procedure TLeave.SetOpenningbalancehrs (Const Value :Double    ); begin SetFloatField('Openningbalancehrs'  , Value);End;
Procedure TLeave.SetOpenningbalancedate(Const Value :TDatetime ); begin SetDatetimeField('Openningbalancedate' , Value);End;
Procedure TLeave.SetStartdate          (Const Value :TDatetime ); begin SetDatetimeField('Startdate'           , Value);End;
Procedure TLeave.SetEnddate            (Const Value :TDatetime ); begin SetDatetimeField('Enddate'             , Value);End;
Procedure TLeave.SetUsestartenddates   (Const Value :Boolean   ); begin SetBooleanField('Usestartenddates'    , Value);End;
Procedure TLeave.SetLeaveloading       (Const Value :Double    ); begin SetFloatField('Leaveloading'        , Value);End;
Procedure TLeave.SetUnits              (Const Value :string    ); begin SetStringField('Units'                  , Value);End;
Procedure TLeave.SetLeaveName          (Const Value :string    ); begin SetStringField('LeaveName'              , Value);End;
Procedure TLeave.SetNormalEntitlement  (Const Value :string    ); begin SetStringField('NormalEntitlement'      , Value);End;
Procedure TLeave.SetShowBalanceOnPayslip  (Const Value :Boolean   ); begin SetBooleanField('ShowBalanceOnPayslip'  , Value);End;
Procedure TLeave.SetActive             (Const Value :Boolean   ); begin SetBooleanField('Active'                , Value);End;


function TLeave.getCleanAccruedhours: Double;
begin
  result:= Temployeepay(Self.Owner).LeaveAccruals.GetAccruedHrs(Self.LeaveType);
end;

initialization
RegisterClassOnce(TLeave);


end.
