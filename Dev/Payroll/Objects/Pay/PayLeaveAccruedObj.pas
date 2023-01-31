unit PayLeaveAccruedObj;

interface

uses
  Classes, DB, kbmMemTable;

type
  TLeaveAccrued = class(TObject)
  private
    foOwner: TObject;
    fmtTotals: TkbmMemTable;
    FDSLeaveAccrued: TDataset;
    procedure SetupLeaveAccruedMemTable;
  public
    constructor Create(const Owner: TObject);
    destructor Destroy; override;
    procedure Recalc;
    procedure PostToAccounts;
    property Owner: TObject read foOwner;
    function GetHrs(const LeaveID: integer): double;
    property DataSet: TDataset read FDSLeaveAccrued write FDSLeaveAccrued;
    property TotalDS: TkbmMemTable read fmtTotals;
  end;

implementation
  
uses FastFuncs,SysUtils, DateUtils, DnMlib, PayCommon, PayObj,
   AppEnvironment;

{ TAccruedLeavesObj }

constructor TLeaveAccrued.Create(const Owner: TObject);
begin
  inherited Create;
  foOwner := Owner;
  fmtTotals := TkbmMemTable.Create(nil);
  SetupLeaveAccruedMemTable;
end;

destructor TLeaveAccrued.Destroy;
begin
  FreeAndNil(fmtTotals);
  inherited;
end;

procedure TLeaveAccrued.Recalc;
var
  bm: TBookmark;
  iNumPays: integer;
  intDays: double;
  intWeeks: double;
  intMonths: double;
  intYears: double;
  intBirthdays: integer;
  dtTemp: TDateTime;
  bDoAccrual: boolean;
  dtLastAccruedDate: TDateTime;
  dAccrueHours: double;
  dPayAccruedHours: double;
  dMaxSickLeaveDays:double;
begin
  if DatasetOk(FDSLeaveAccrued) then begin
    with FDSLeaveAccrued do begin
      bm := GetBookmark;
      DisableControls;
      fmtTotals.EmptyTable;
      First;

      while not Eof do begin
        // Setup Variables
        dPayAccruedHours := 0;
        bDoAccrual := false;
        dAccrueHours := FieldByName('AccrueHours').AsFloat;
        iNumPays := GetNumberOfPays(TPayObj(Self.Owner).Employee.EmployeeID, TPayObj(Self.Owner).PayDate);
        if not FieldByName('AccruedDate').IsNull then begin
          dtLastAccruedDate := FieldByName('AccruedDate').AsDateTime;
        end else begin
          dtLastAccruedDate := TPayObj(Self.Owner).Employee.EmployeeDetails.DateStarted;
        end;

        // First check if the Accrual threshold has been met for this leave
        if FindInSet(FieldByName('AccrueAfterPeriod').AsString, 'Pay') then begin
          if iNumPays >= FieldByName('AccrueAfterNo').AsFloat then begin
            bDoAccrual := true;
          end;
        end else if FindInSet(FieldByName('AccrueAfterPeriod').AsString, 'Week') then begin
          intWeeks := WeeksBetweenSigned(TPayObj(Self.Owner).PayDate,
            TPayObj(Self.Owner).Employee.EmployeeDetails.DateStarted);
          if intWeeks >= FieldByName('AccrueAfterNo').AsFloat then begin
            bDoAccrual := true;
          end
        end else if FindInSet(FieldByName('AccrueAfterPeriod').AsString, 'Month') then begin
          intMonths := MonthsBetweenSigned(TPayObj(Self.Owner).PayDate,
            TPayObj(Self.Owner).Employee.EmployeeDetails.DateStarted) + 0.00;
          if intMonths >= FieldByName('AccrueAfterNo').AsFloat then begin
            bDoAccrual := true;
          end;
        end else if FindInSet(FieldByName('AccrueAfterPeriod').AsString, 'Year') then begin
          intYears := YearsBetweenSigned(TPayObj(Self.Owner).PayDate,
            TPayObj(Self.Owner).Employee.EmployeeDetails.DateStarted) + 0.00;
          if intYears >= FieldByName('AccrueAfterNo').AsFloat then begin
            bDoAccrual := true;
          end
        end else if FindInSet(FieldByName('AccrueAfterPeriod').AsString, 'Birthday') then begin
          if DayOfTheYear(TPayObj(Self.Owner).Employee.EmployeeDetails.DateStarted) >
            DayOfTheYear(TPayObj(Self.Owner).Employee.EmployeeDetails.DOB) then begin
            dtTemp := IncYear(dtLastAccruedDate);
          end else begin
            dtTemp := dtLastAccruedDate;
          end;
          dtTemp := StartOfTheYear(dtTemp) + MonthOfTheYear(TPayObj(Self.Owner).Employee.EmployeeDetails.DOB);
          intBirthdays := YearsBetweenSigned(TPayObj(Self.Owner).PayDate, dtTemp);
          if intBirthdays >= FieldByName('AccrueAfterNo').AsFloat then begin
            bDoAccrual := true;
          end
        end;

        if (FieldByName('UseStartEndDates').AsString = 'T') and (bDoAccrual = true) then begin
          if FieldByName('StartDate').AsDateTime <> 0 then begin
            if (TPayObj(Self.Owner).PayDate > FieldByName('StartDate').AsDateTime) and
              (TPayObj(Self.Owner).PayDate < FieldByName('EndDate').AsDateTime) then begin
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
          intDays := DaysBetweenSigned(TPayObj(Self.Owner).PayDate, dtLastAccruedDate); {DaysBetweenSigned(Now,Then)}
          if intDays <= 0 then begin
            intDays := DaysBetweenSigned(TPayObj(Self.Owner).EndPayPeriod, TPayObj(Self.Owner).StartPayPeriod) + 1;
          end;

          intWeeks := Divzer(intDays, 7);
          intMonths := Divzer(intWeeks, (13 / 3));
          intYears := Divzer(intDays, 365.25);

          if FindInSet(FieldByName('AccruePeriod').AsString, 'Hour') then begin
            {Hours}
            if (TPayObj(Self.Owner).Payrates.TotalHours > 0.00) then begin
              dPayAccruedHours := dPayAccruedHours + (TPayObj(Self.Owner).Payrates.TotalHours *
                Divzer(dAccrueHours, FieldByName('AccrueNo').AsFloat));
            end;
          end else if FindInSet(FieldByName('AccruePeriod').AsString, 'Pay') then begin
            {Pay}
            dPayAccruedHours := dPayAccruedHours + Divzer(dAccrueHours, FieldByName('AccrueNo').AsFloat);
          end else if FindInSet(FieldByName('AccruePeriod').AsString, 'Week') then begin
            {Week}
            if intDays > 0 then begin
              dPayAccruedHours := dPayAccruedHours + (dAccrueHours * Divzer(intWeeks, FieldByName('AccrueNo').AsFloat));
            end;
          end else if FindInSet(FieldByName('AccruePeriod').AsString, 'Month') then begin
            {Month}
            if intDays > 0 then begin
              dPayAccruedHours := dPayAccruedHours + (dAccrueHours * Divzer(intMonths, FieldByName('AccrueNo').AsFloat));
            end;
          end else if FindInSet(FieldByName('AccruePeriod').AsString, 'Year') then begin
            {Year}
            if intDays > 0 then begin
              dPayAccruedHours := dPayAccruedHours + (dAccrueHours * Divzer(intYears, FieldByName('AccrueNo').AsFloat));
            end;
          end else if FindInSet(FieldByName('AccruePeriod').AsString, 'Birthday') then begin
            {Birthday}
            if (Trunc(dtLastAccruedDate) <= Trunc(TPayObj(Self.Owner).Employee.EmployeeDetails.DOB)) and
              (Trunc(TPayObj(Self.Owner).Employee.EmployeeDetails.DOB) >= Trunc(TPayObj(Self.Owner).PayDate)) then begin
              dPayAccruedHours := dPayAccruedHours + (Divzer(dAccrueHours, FieldByName('AccrueNo').AsFloat));
            end;
          end;
        end;

         // if sick leave, will the accrual go over the yearly threshold?
        if FDSLeaveAccrued.FieldByName('Type').AsString = 'Sick Leave' then begin
          if TPayObj(Self.Owner).Employee.EmployeeSettings.Award <> 0 then begin
            dMaxSickLeaveDays := TPayObj(Self.Owner).Employee.EmployeeSettings.AwardSickDayThreshold;
          end else begin
            dMaxSickLeaveDays := AppEnv.CompanyPrefs.SickLeaveDays;
          end;

          if  dMaxSickLeaveDays <> 0 then begin
            if (FDSLeaveAccrued.FieldByName('AccruedHours').AsFloat + dPayAccruedHours) > (dMaxSickLeaveDays  * AppEnv.CompanyPrefs.HoursPerWeek/5) then begin
              //accrue only enough sick leave to reach max
              dPayAccruedHours := (dMaxSickLeaveDays  * AppEnv.CompanyPrefs.HoursPerWeek/5) - FDSLeaveAccrued.FieldByName('AccruedHours').AsFloat;
            end;
          end else begin
            dPayAccruedHours := FDSLeaveAccrued.FieldByName('AccrueHours').AsFloat;
          end;
        end;

        fmtTotals.Append;
        fmtTotals.FieldByName('LeaveTypeID').AsInteger := GetLeaveTypeID(FieldByName('Type').AsString);
        fmtTotals.FieldByName('LeaveID').AsInteger := FDSLeaveAccrued.FieldByName('LeaveID').AsInteger;
        fmtTotals.FieldByName('Type').AsString := FDSLeaveAccrued.FieldByName('Type').AsString;
        fmtTotals.FieldByName('ClassID').AsInteger := FDSLeaveAccrued.FieldByName('ClassID').AsInteger;
        fmtTotals.FieldByName('AccrueHours').AsFloat := dPayAccruedHours;
        If (FDSLeaveAccrued.FindField('LeaveID')<>nil) then
          fmtTotals.FieldByName('PayLineID').AsInteger := FDSLeaveAccrued.FieldByName('LeaveID').AsInteger;
        fmtTotals.Post;
        Next;
      end;
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
    end;
  end
end;


function TLeaveAccrued.GetHrs(const LeaveID: integer): double;
var
  bm: TBookmark;
begin
  Result := 0;
  if DatasetOk(fmtTotals) then begin
    with fmtTotals do begin
      bm := GetBookmark;
      DisableControls;
      if (fmtTotals.FindField('LeaveID') <> nil) then begin

        FilterDataset(fmtTotals, '[LeaveID]=' + FastFuncs.IntToStr(LeaveID));
        if (RecordCount > 0) then begin
          First;
          while not Eof do begin
            Result := Result + fmtTotals.FieldByName('AccrueHours').AsFloat;
            Next;
          end;
        end;
        RemoveFilterDataset(fmtTotals);

      end;
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
    end;
  end;
end;

procedure TLeaveAccrued.PostToAccounts;
var
  CreditAccID: integer;
  DebitAccID: integer;
  PostLeave: boolean;
begin
  if DatasetOk(fmtTotals) then begin
    with fmtTotals do begin
      DisableControls;
      First;
      while not Eof do begin
(*        DebitAccID := TPayObj(Self.Owner).PayPreferences.LeaveProvisionAccountID;
        CreditAccID := TPayObj(Self.Owner).PayPreferences.LeaveLiabilityAccountID;*)
        DebitAccID := AppEnv.PayPrefs.LeaveProvisionAccountID;
        CreditAccID :=AppEnv.PayPrefs.LeaveLiabilityAccountID;

        PostLeave := true;
(*        if (FastFuncs.Trim(FieldByName('Type').AsString) = 'Annual Leave') and
          Not TPayObj(Self.Owner).PayPreferences.ShowAccruedAnnualLeaveLiability then begin
          PostLeave := false;
        end else if (FastFuncs.Trim(FieldByName('Type').AsString) = 'Sick Leave') and
          Not TPayObj(Self.Owner).PayPreferences.ShowAccruedSickLeaveLiability then begin
          PostLeave := false;
        end;*)
        if (FastFuncs.Trim(FieldByName('Type').AsString) = 'Annual Leave') and
          Not AppEnv.PayPrefs.ShowAccruedAnnualLeaveLiability then begin
          PostLeave := false;
        end else if (FastFuncs.Trim(FieldByName('Type').AsString) = 'Sick Leave') and
          Not AppEnv.PayPrefs.ShowAccruedSickLeaveLiability then begin
          PostLeave := false;
        end;

        if PostLeave then begin
          PostToPaysTransactions('Payroll Accrued Leave','Accrued Leave', FieldByName('Type').AsString + ' Accrued', TPayObj(Self.Owner),
            CreditAccID,
            DebitAccID,
            FieldByName('ClassID').AsInteger, FieldByName('PaylineID').AsInteger,
            FieldByName('AccrueHours').AsFloat * TPayObj(Self.Owner).PayRates.HourlyRate);
        end;

        Next;
      end;
      EnableControls;
    end;
  end;
end;

procedure TLeaveAccrued.SetupLeaveAccruedMemTable;
begin
  fmtTotals.Close;
  with fmtTotals.FieldDefs.AddFieldDef do begin
    Name     := 'AutoID';
    DataType := ftAutoInc;
  end;
  with fmtTotals.FieldDefs.AddFieldDef do begin
    Name     := 'LeaveID';
    DataType := ftInteger;
  end;
  with fmtTotals.FieldDefs.AddFieldDef do begin
    Name     := 'LeaveTypeID';
    DataType := ftInteger;
  end;
  with fmtTotals.FieldDefs.AddFieldDef do begin
    Name     := 'Type';
    DataType := ftString;
    Size     := 255;
  end;
  with fmtTotals.FieldDefs.AddFieldDef do begin
    Name     := 'ClassID';
    DataType := ftInteger;
  end;
  with fmtTotals.FieldDefs.AddFieldDef do begin
    Name     := 'AccrueHours';
    DataType := ftFloat;
  end;
  with fmtTotals.FieldDefs.AddFieldDef do begin
    Name     := 'LeaveLoading';
    DataType := ftFloat;
  end;
  with fmtTotals.FieldDefs.AddFieldDef do begin
    Name     := 'PayLineID';
    DataType := ftInteger;
  end;  
  fmtTotals.CreateTable;
  fmtTotals.Open;
  fmtTotals.UpdateIndexes;
  fmtTotals.Emptytable;
end;

end.


