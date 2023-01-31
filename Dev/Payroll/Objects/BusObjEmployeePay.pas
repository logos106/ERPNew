{ this busObj does'nt have it's own table but has a collection of other BusObjs
     EmployeePay
         |___EmployeeDetails
         |___EmployeePaySettings
         |___EmployeePayRates
         |___EmployeeLeaves
         |___LeaveTypes
         |___LeaveAccruals
         |___EmployeePaySplit
         |___EmployeeDeductions
         |___EmployeeBenefitsBase
         |               |___Superannuation
         |               |___BenefitsUK
         |___FBT
         |___reference
         |___EmployeeAllowances
         |___WorkersCompensation
         |___Award
}

unit BusObjEmployeePay;

interface

uses
  BusObjBase,Classes, BusObjEmployeeDetails,BusObjEmployeePayRates,
  BusObjEmployeeLeave, BusObjEmployeePaySettings, BusObjEmployeePaySplit,
  BusObjEmployeeDeductions, BusObjLeaveAccruals, BusObjFringeBenefitsTax,
  BusObjCorrespondence, MyAccess,ERPdbComponents, BusObjEmployeeAllowances,
  BusObjWorkersCompensation, BusObjAwards, BusObjLeaveTypes, BusObjBenefitsBase,
  busobjProductcommission , BusobjEmpskills;

type
   TEmployeepay = class(TMSBusObj)
   private
      fAddingAwardRate              :boolean;
      fEmployeeDetails              :Temployeedetails;
      fEmployeePaySettings          :Temployeepaysettings;
      fEmployeePayRates             :Temployeepayrates;
      fEmployeeLeaves               :Tleave;
      fLeaveAccruals                :Tleaveaccruals;
      fEmployeePaySplit             :Tpaysplit;
      fEmployeeDeductions           :Temployeedeductions;
      fSuperannuation               :TBenefitsBase;
      fFringeBenefits               :Tfbt;
      fEmployeeCorrespondence       :TCorrespondence;
      fEmployeeAllowances           :Temployeeallowances;
      fWorkersCompensation          :Tworkerscompensation;
      fAward                        :TAward;
      fLeaveTypes                   :Tleavetypes;
      fbAllLinesValid               :Boolean;
      fEmployeeProductCommission    :TProductCommission;
      fAllemployeeProductcommission :TProductCommission;
      fEmployeeNoCommissionProducts :TEmpNoCommsProducts;
      fEmployeeSkills               :TEmployeeSkills;
      Procedure CallbackSave(Const Sender: TBusObj; var Abort: boolean);
  protected
   public
      class function GetBusObjectTablename: string; override;
      class function  GetIDField: string; override;
      Constructor Create(AOwner: TComponent); overload;override;
      Constructor Create(AOwner: TComponent;PassedConnection:TERPConnection); reintroduce;overload;
      procedure Load(Const aId: integer;const fIsReadonly:boolean =False);override;
      Function Save:boolean; override;
      procedure RefreshAllDBs;
      procedure UpdateEmployeeWithAward;

     // Objects =====================================================================================
      property EmployeeDetails      :Temployeedetails     Read fEmployeeDetails        write  fEmployeeDetails ;
      property EmployeePaySettings  :TemployeePaySettings Read fEmployeePaySettings    write  fEmployeePaySettings ;
      Property EmployeeProductCommission    :TProductCommission   Read fEmployeeProductCommission      Write  fEmployeeProductCommission;
      Property AllemployeeProductcommission :TProductCommission   read fAllemployeeProductcommission   Write fAllemployeeProductcommission;
      Property EmployeeNoCommissionProducts :TEmpNoCommsProducts read fEmployeeNoCommissionProducts  write fEmployeeNoCommissionProducts;
      property EmployeePayRates     :Temployeepayrates    Read fEmployeePayrates       write  fEmployeePayRates ;
      property EmployeeLeaves       :Tleave               Read fEmployeeLeaves         write  fEmployeeLeaves ;
      property EmployeePaySplit     :Tpaysplit            Read fEmployeePaySplit       write  fEmployeePaySplit;
      property EmployeeDeductions   :Temployeedeductions  Read fEmployeeDeductions     write  fEmployeeDeductions ;
      property LeaveAccruals        :Tleaveaccruals       Read fLeaveAccruals          write  fLeaveAccruals ;
      property Superannuation       :TBenefitsBase        Read fsuperannuation         write  fsuperannuation;
      property FringeBenefits       :TFbt                 Read fFringeBenefits         write  fFringeBenefits;
      property EmployeeCorrespondence    :TCorrespondence          Read fEmployeeCorrespondence      write  fEmployeeCorrespondence;
      Property EmployeeSkills       :TEmployeeSkills      read fEmployeeSkills          write fEmployeeSkills;
      property EmployeeAllowances   :Temployeeallowances  Read fEmployeeAllowances     write  fEmployeeAllowances;
      property WorkersCompensation  :Tworkerscompensation Read fWorkersCompensation    write  fWorkersCompensation;
      property Award                :TAward             Read fAward                  write  fAward;
      property LeaveTypes           :Tleavetypes          Read fLeaveTypes             write  fLeaveTypes;
      property AddingAwardRate      :boolean              Read fAddingAwardRate        write  fAddingAwardRate;
   end;

implementation
uses
  SysUtils,AppEnvironment,PayCommon,CommonLib,tcDataUtils,tcTypes,
  BusObjSuperannuation;


constructor TEmployeePay.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
end;

constructor TEmployeePay.Create(AOwner: TComponent;PassedConnection:TERPConnection);
begin
   inherited Create(AOwner);
   Connection  := TMyDacDataConnection.Create(Self);
   TMyDacDataConnection(Connection).MydacConnection  := PassedConnection;

   fEmployeePaySettings                 := tEmployeePaySettings.Create(Self);
   fEmployeePaySettings.connection      := Self.connection;
   fEmployeePaySettings.SilentMode      := Self.SilentMode;

   fEmployeeProductCommission                 := tProductCommission.Create(Self);
   fEmployeeProductCommission.connection      := Self.connection;
   fEmployeeProductCommission.SilentMode      := Self.SilentMode;


   fAllemployeeProductcommission                 := tProductCommission.Create(Self);
   fAllemployeeProductcommission.connection      := Self.connection;
   fAllemployeeProductcommission.SilentMode      := Self.SilentMode;

   fEmployeeNoCommissionProducts                := TEmpNoCommsProducts.create(Self);
   fEmployeeNoCommissionProducts.connection      := Self.connection;
   fEmployeeNoCommissionProducts.SilentMode      := Self.SilentMode;

   fEmployeeDeductions                  := tEmployeeDeductions.Create(Self);
   fEmployeeDeductions.connection       := Self.connection;

   fSuperannuation                      := TSuperannuation.Create(Self);
   
   fSuperannuation.connection           := Self.connection;
   fFringeBenefits                      := Tfbt.Create(Self);
   fFringeBenefits.connection           := Self.connection;
   fEmployeeCorrespondence                   := TCorrespondence.Create(Self);
   fEmployeeCorrespondence.connection        := Self.connection;
   fEmployeeSkills                       := TEmployeeSkills.Create(Self);
   fEmployeeSkills.connection        := Self.connection;
   fEmployeeDetails                     := Temployeedetails.Create(Self);
   fEmployeeDetails.connection          := Self.connection;
   fEmployeePayRates                    := TEmployeePayRates.Create(Self);
   fEmployeePayRates.connection         := Self.connection;
   fEmployeeLeaves                      := TLeave.Create(Self);
   fEmployeeLeaves.connection           := Self.connection;
   fEmployeePaySplit                    := TPaySplit.Create(Self);
   fEmployeePaySplit.connection         := Self.connection;
   fEmployeeDeductions                  := TEmployeeDeductions.Create(Self);
   fEmployeeDeductions.connection       := Self.connection;
   fLeaveAccruals                       := TLeaveAccruals.Create(Self);
   fLeaveAccruals.connection            := Self.connection;
   fSuperannuation.connection           := Self.connection;
   fFringeBenefits                      := TFBT.Create(Self);
   fFringeBenefits.connection           := Self.connection;
   (*fEmployeeDocuments                   := Treference.Create(Self);
   fEmployeeDocuments.connection        := Self.connection;*)
   fEmployeeAllowances                  := Temployeeallowances.Create(Self);
   fEmployeeAllowances.connection       := Self.connection;
   FEmployeeAllowances.SilentMode       := Self.SilentMode;

   fWorkersCompensation                 := Tworkerscompensation.Create(Self);
   fWorkersCompensation.Connection      := Self.Connection;
   fWorkersCompensation.SilentMode      := Self.SilentMode;

   fAward                               := TAward.Create(Self,PassedConnection);
   fAward.Connection                    := Self.Connection;
   fAward.SilentMode                    := Self.SilentMode;

   fLeaveTypes                          := Tleavetypes.Create(Self);
   fLeaveTypes.Connection               := Self.Connection;
   fLeaveTypes.SilentMode               := Self.SilentMode;
end;

procedure TEmployeePay.RefreshAllDBs;
begin
  Self.EmployeePaysettings.refreshdb;
  Self.EmployeeProductCommission.RefreshDB;
  Self.AllemployeeProductcommission.RefreshDB;
  Self.EmployeeNoCommissionProducts.RefreshDB;
  Self.EmployeeDetails.RefreshDB;
  Self.EmployeePayRates.RefreshDB;
  Self.EmployeeLeaves.RefreshDB;
  Self.EmployeePaySplit.RefreshDB;
  Self.EmployeeDeductions.RefreshDB;
  Self.LeaveAccruals.RefreshDB;
  Self.Superannuation.RefreshDB;
  Self.FringeBenefits.RefreshDB;
  Self.EmployeeCorrespondence.RefreshDB;
  Self.EmployeeSkills.RefreshDB;
  Self.EmployeeAllowances.RefreshDB;
  Self.WorkersCompensation.RefreshDB;
end;

Procedure TEmployeePay.CallbackSave(Const Sender: TBusObj; var Abort: boolean);
begin
  if sender.Dirty and (not Sender.Save) then begin
    Abort := true;
    fbAllLinesValid := False;
  end;
end;

Function TEmployeePay.Save:Boolean;
begin
showProgressbar(13, 'Validating Changes');
try
  stepProgressbar('Pay Details');
  Result := False;
  if not ValidateData then Exit;
  Result := Inherited Save;
  if Result = false then Exit;

  fbAllLinesValid := True;
  {General}

  stepProgressbar('Personal Details');
  Self.EmployeeDetails.PostDb;
  Self.EmployeeDetails.IterateRecords(CallbackSave);
  if not fbAllLinesValid  then begin
    result := False;
    Exit;
  end;

  stepProgressbar('Workers compensation');
  Self.WorkersCompensation.PostDb;
  Self.WorkersCompensation.IterateRecords(CallbackSave);
  if not fbAllLinesValid  then begin
    result := False;
    Exit;
  end;

  stepProgressbar('Skills');
  Self.EmployeeSkills.PostDb;
  Self.EmployeeSkills.IterateRecords(CallbackSave);
  if not fbAllLinesValid  then begin
    result := False;
    Exit;
  end;

  stepProgressbar('Correspondence');
  Self.EmployeeCorrespondence.PostDb;
  Self.EmployeeCorrespondence.IterateRecords(CallbackSave);
  if not fbAllLinesValid  then begin
    result := False;
    Exit;
  end;

  {Payroll}

  if (AppEnv.Employee.PayrollAccess) and (AppEnv.CompanyPrefs.UsePayroll) then begin
    stepProgressbar('Pay Settings');
    Self.EmployeePaySettings.PostDb;
    Self.EmployeePaySettings.IterateRecords(CallbackSave);
    if not fbAllLinesValid  then begin
      result := False;
      Exit;
    end;

    Self.EmployeePayRates.PostDb;
    try
        stepProgressbar('Pay Rates');
        Self.EmployeePayRates.IterateRecords(CallbackSave);
    Except
      on E:Exception do begin
        ResultStatus.AddItem(False,  rsswarning,0,  E.Message);
        fbAllLinesValid  := False;
      end;
    end;
    if not fbAllLinesValid  then begin
      result := False;
      Exit;
    end;

    stepProgressbar('Leaves');
    Self.EmployeeLeaves.PostDb;
    Self.EmployeeLeaves.IterateRecords(CallbackSave);
    if not fbAllLinesValid  then begin
      result := False;
      Exit;
    end;

    stepProgressbar('Pay Splits');
    Self.EmployeePaySplit.PostDb;
    Self.EmployeePaySplit.IterateRecords(CallbackSave);
    if not fbAllLinesValid  then begin
      result := False;
      Exit;
    end;

    stepProgressbar('Deductions');
    Self.EmployeeDeductions.PostDb;
    Self.EmployeeDeductions.IterateRecords(CallbackSave);
    if not fbAllLinesValid  then begin
      result := False;
      Exit;
    end;

    stepProgressbar('Superannuation');
    Self.Superannuation.PostDb;
    Self.Superannuation.IterateRecords(CallbackSave);
    if not fbAllLinesValid  then begin
      result := False;
      Exit;
    end;

    stepProgressbar('Fringe Benefits');
    Self.FringeBenefits.PostDb;
    Self.FringeBenefits.IterateRecords(CallbackSave);
    if not fbAllLinesValid  then begin
      result := False;
      Exit;
    end;

    stepProgressbar('Allowances');
    Self.EmployeeAllowances.PostDb;
    Self.EmployeeAllowances.IterateRecords(CallbackSave);
    if not fbAllLinesValid  then begin
      result := False;
      Exit;
    end;

  end;
  result := true;
finally
  HideProgressbar;
end;
end;

procedure  TEmployeePay.Load(Const aId: integer;const fIsReadonly:boolean =False);
begin
  EmployeeDetails.Load(aID);
  EmployeePaySettings.LoadSelect('EmployeeID = ' + IntToStr(aID));
  EmployeeProductCommission.SQLOrder :=   'Partname';{for the employee commission GUI to show in order}
  EmployeeProductCommission.LoadSelect('ifnull(EmployeeID,0) = ' + IntToStr(aID));
  EmployeeNoCommissionProducts.SQLOrder :=   'ProductName'; {for the employee commission GUI to show in order}
  EmployeeNoCommissionProducts.LoadSelect('ifnull(EmployeeID,0) = ' + IntToStr(aID));
  AllemployeeProductcommission.SQLOrder :=   'Partname';{for the employee commission GUI to show in order}
  AllemployeeProductcommission.LoadSelect('ifnull(EmployeeID,0) = 0  and PartsId not in (select PartsId from tblproductcommission where ifnull(EmployeeId,0) = ' + IntToStr(aID)+')' );
  EmployeePayRates.LoadSelect('EmployeeID = ' + IntToStr(aID));
  EmployeeLeaves.LoadSelect('EmployeeID = ' + IntToStr(aID));
  EmployeePaySplit.LoadSelect('EmployeeID = ' + IntToStr(aID));
  EmployeeDeductions.LoadSelect('EmployeeID = ' + IntToStr(aID));
  LeaveAccruals.LoadSelect('EmployeeID = ' + IntToStr(aID));
  //EmployeeDetails.LoadSelect('EmployeeID = ' + IntToStr(aID));
  Superannuation.LoadSelect('EmployeeID = ' + IntToStr(aID));
  FringeBenefits.LoadSelect('EmployeeID = ' + IntToStr(aID));
  EmployeeCorrespondence.LoadSelect('EmployeeID = ' + IntToStr(aID) +
    ' AND (IsNull(ContactID) or (ContactID < 1)) AND (IsNull(CusID) or (CusID < 1)) AND (IsNull(SupID) or (SupID < 1))');
  EmployeeSkills.LoadSelect('EmployeeID = ' + IntToStr(aID));
  EmployeeAllowances.LoadSelect('EmployeeID = ' + IntToStr(aID));
  fWorkersCompensation.LoadSelect('EmployeeID = ' + IntToStr(aID));
  if Self.EmployeeDetails.Useaward then begin
    Award.Load(Self.EmployeeDetails.Award);       
  end;
  fLeaveTypes.Load;
end;

procedure TEmployeepay.UpdateEmployeeWithAward;
var
  dHourlyRate:double;
  iPeriod:integer;
begin
  try
    AddingAwardRate := True;
    if Self.EmployeeDetails.Useaward = False then begin
      Self.EmployeeDetails.Useaward := True;
      Self.EmployeeDetails.Award := Self.Award.Id;
      Self.EmployeeDetails.Paysuperonleaveloading := Self.Award.Paysuperonleaveloading;
    end;

    Self.EmployeePaySettings.Payperiod := Self.Award.Payperiod;

    //load all payrates of the first classification
    with Self.EmployeePayRates do begin
      Dataset.First;
      while not eof do begin  //delete old payrates
        delete;
      end;
  
      Self.Award.AwardClassifications.Locate('Classification',Self.EmployeeDetails.Classification,[]);

      dHourlyRate := 0;
      if Self.EmployeeDetails.Basisofpayment = 'F' then dHourlyRate := Self.Award.AwardClassifications.FullTime
      else if Self.EmployeeDetails.Basisofpayment = 'P' then dHourlyRate := Self.Award.AwardClassifications.PartTime
      else if Self.EmployeeDetails.Basisofpayment = 'C' then dHourlyRate := Self.Award.AwardClassifications.Casual;

      Self.EmployeePayRates.New;
      Self.EmployeePayRates.Qty := AppEnv.CompanyPrefs.HoursPerWeek;
      Self.EmployeePayRates.Typeid := GetPayRateTypeID(Self.Award.AwardClassifications.ClassificationType);
      Self.EmployeePayRates.Payrateid := 2;  //normal hours

      if (Self.Award.AwardClassifications.ClassificationType = 'Hourly Rate')
        or (Self.Award.AwardClassifications.ClassificationType = 'CDEP') then begin
        Self.EmployeePayrates.Hourlyrate := dHourlyRate;//Self.EmployeePayrates.Qty * dHourlyRate;
        Self.EmployeePayrates.LineTotal := RoundCurrency(Self.EmployeePayrates.HourlyRate * Self.EmployeePayrates.Qty);
        Self.EmployeePayrates.Amount    := Self.EmployeePayrates.LineTotal;
      end else if Self.Award.AwardClassifications.ClassificationType = 'Salary' then begin
        Self.EmployeePayrates.Amount := dHourlyRate;
       // if Sysutils.SameText(Sender.FieldName , 'HourlyRate') then Amount := HourlyRate;
        Self.EmployeePayrates.LineTotal := RoundCurrency(Self.EmployeePayrates.Amount);
      end else if Self.Award.AwardClassifications.ClassificationType = 'Annual Payment' then begin
        if Self.EmployeePaySettings.Payperiod = 'Weekly' then begin
          iPeriod := 52;
        end else if Self.EmployeePaySettings.Payperiod = 'Fortnightly' then begin
          iPeriod := 26;
        end else if Self.EmployeePaySettings.Payperiod = 'Monthly' then begin
          iPeriod := 12;
        end else if Self.EmployeePaySettings.Payperiod = 'Bi-Monthly' then begin
          iPeriod := 24;
        end else begin
          iPeriod := 52;
        end;
        dHourlyRate := RoundCurrency(Divzer(Self.EmployeePayrates.Amount,iPeriod));
        Self.EmployeePayrates.Amount := dHourlyRate;
        Self.EmployeePayrates.LineTotal  := RoundCurrency(Self.EmployeePayrates.Amount);
      end;

      if Self.EmployeeDetails.Defaultclassid = 0 then  Self.EmployeeDetails.DefaultClassId := AppEnv.DefaultClass.ClassID;
      Self.EmployeePayrates.Classid := Self.EmployeeDetails.Defaultclassid;
      Self.EmployeePayrates.DepartmentName := Self.EmployeeDetails.Defaultclassname;
      Self.EmployeePayrates.PostDB;

      with Self.Award.AwardClassifications.ClassificationExtraPayrates do begin
        Dataset.First;
        while not Eof do begin
          Self.EmployeePayrates.New;
          Self.EmployeePayrates.Qty := Self.Award.AwardClassifications.ClassificationExtraPayrates.Worked;
          Self.EmployeePayrates.TypeID := Self.Award.AwardClassifications.ClassificationExtraPayrates.TypeID;
          Self.EmployeePayrates.Hourlyrate := Self.Award.AwardClassifications.ClassificationExtraPayrates.Amount;
          Self.EmployeePayrates.Amount  := Self.EmployeePayrates.Hourlyrate * Self.EmployeePayrates.Qty;
          Self.EmployeePayrates.Linetotal := Self.EmployeePayrates.Hourlyrate * Self.EmployeePayrates.Qty;
          Self.EmployeePayrates.DepartmentName := Self.EmployeeDetails.Defaultclassname;
          Self.EmployeePayRates.Classid := Self.EmployeeDetails.DefaultClassID;
          Self.EmployeePayrates.Payrateid := Self.Award.AwardClassifications.ClassificationExtraPayrates.PayRate;
          Self.EmployeePayrates.PostDB;
          Next;
        end;
      end;
      //load all allowances of the first classification
      Self.EmployeeAllowances.Dataset.First;
      while not Self.EmployeeAllowances.Dataset.eof do begin  //delete old allowances
        Self.EmployeeAllowances.delete;
      end;

      with Self.Award.AwardClassifications.ClassificationAllowances do begin
        Dataset.First;
        while not Eof do begin
          Self.EmployeeAllowances.New;
          Self.EmployeeAllowances.Qty         := 1;
          Self.EmployeeAllowances.Basedonid   := Self.Award.AwardClassifications.ClassificationAllowances.Basedonid;
          Self.EmployeeAllowances.Allowanceid := Self.Award.AwardClassifications.ClassificationAllowances.Allowid;
          Self.EmployeeAllowances.Allowance   := GetAllowanceName(Self.Award.AwardClassifications.ClassificationAllowances.Allowid);
          Self.EmployeeAllowances.Amount      := Self.Award.AwardClassifications.ClassificationAllowances.Amount;

          Self.EmployeeAllowances.DepartmentName := Self.EmployeeDetails.Defaultclassname;
          Self.EmployeeAllowances.Classid := Self.EmployeeDetails.Defaultclassid;

          Self.EmployeeAllowances.PostDB;
          Next;
        end;
      end;

      //load all deductions of the first classification
      Self.EmployeeDeductions.Dataset.First;
      while not Self.EmployeeDeductions.Dataset.eof do begin  //delete old deductions
        Self.EmployeeDeductions.delete;
      end;

      with Self.Award.AwardClassifications.ClassificationDeductions do begin
        Dataset.First;
        while not Eof do begin
          Self.EmployeeDeductions.New;
          Self.EmployeeDeductions.Qty         := 1;
          Self.EmployeeDeductions.Basedonid   := Self.Award.AwardClassifications.ClassificationDeductions.Basedonid;
          Self.EmployeeDeductions.Deductionid := Self.Award.AwardClassifications.ClassificationDeductions.Deductid;
          Self.EmployeeDeductions.Deduction   := GetDeductionName(Self.Award.AwardClassifications.ClassificationDeductions.Deductid);
          Self.EmployeeDeductions.Amount      := Self.Award.AwardClassifications.ClassificationDeductions.Amount;
          Self.EmployeeDeductions.DepartmentName := Self.EmployeeDetails.Defaultclassname;
          Self.EmployeeDeductions.Classid     := Self.EmployeeDetails.Defaultclassid;

          Self.EmployeeDeductions.PostDB;
          Next;
        end;
      end;
    end;


    //load all leaves
//    Self.EmployeeLeaves.Dataset.First;
//    while not Self.EmployeeLeaves.Dataset.eof do begin  //delete old leaves
//      Self.EmployeeLeaves.delete;
//    end;

    with Self.Award.AwardLeaves do begin
      Dataset.First;
      while not Eof do begin

        If not Self.EmployeeLeaves.Dataset.Locate('Typeid',GetLeaveTypeID(Self.Award.AwardLeaves.AwardLeaveType),[]) then
          Self.EmployeeLeaves.New;
          
        Self.EmployeeLeaves.Accrueafterperiod       := Self.Award.AwardLeaves.Accrueafterperiod;
        Self.EmployeeLeaves.Accrueafterno           := Self.Award.AwardLeaves.Accrueafterno;
        Self.EmployeeLeaves.Accrueno                := Self.Award.AwardLeaves.Accrueno;
        Self.EmployeeLeaves.Accrueperiod            := Self.Award.AwardLeaves.Accrueperiod;
        Self.EmployeeLeaves.Accruehours             := Self.Award.AwardLeaves.Accruehours;
        Self.EmployeeLeaves.Typeid                  := GetLeaveTypeID(Self.Award.AwardLeaves.AwardLeaveType);
        Self.EmployeeLeaves.LeaveType               := Self.Award.AwardLeaves.AwardLeaveType;
        Self.EmployeeLeaves.Maxhours                := Self.Award.AwardLeaves.Maxhours;
        Self.EmployeeLeaves.Usestartenddates        := Self.Award.AwardLeaves.Usestartenddates;
        Self.EmployeeLeaves.Startdate               := Self.Award.AwardLeaves.Awardstartdate;
        Self.EmployeeLeaves.Enddate                 := Self.Award.AwardLeaves.Awardenddate;
        Self.EmployeeLeaves.Leaveloading            := Self.Award.AwardLeaves.Leaveloading;
        Self.EmployeeLeaves.DepartmentName          := Self.EmployeeDetails.Defaultclassname;
        Self.EmployeeLeaves.Classid                 := Self.EmployeeDetails.Defaultclassid;
        Self.EmployeeLeaves.PostDB;
        Next;
      end;
    end;

    If not Self.Superannuation.Dataset.Locate('Supertypeid',GetSuperTypeID('Super Guarantee'),[]) then
    Self.Superannuation.New;
    Tsuperannuation(Self.Superannuation).Supertypeid         := GetSuperTypeID('Super Guarantee');
    Tsuperannuation(Self.Superannuation).Classid             := Self.EmployeeDetails.Defaultclassid;
    Tsuperannuation(Self.Superannuation).DepartmentName      := Self.EmployeeDetails.Defaultclassname;
    if Self.Award.Supertype = 'Percentage' then begin
      Tsuperannuation(Self.Superannuation).Calcby := '%';
    end else begin
      Tsuperannuation(Self.Superannuation).Calcby := '$';
    end;
    Tsuperannuation(Self.Superannuation).Amount   :=  Self.Award.Supervalue;
    Self.Superannuation.PostDB;

  finally
    AddingAwardRate := False;
  end;
end;


class function TEmployeepay.GetBusObjectTablename: string;
begin
  result :='';
end;

class function TEmployeepay.GetIDField: string;
begin
  result := '';
end;


initialization
RegisterClassOnce(TEmployeePay);


end.
