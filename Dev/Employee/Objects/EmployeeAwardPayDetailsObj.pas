unit EmployeeAwardPayDetailsObj;

interface
//COLLECTS ALL RELEVANT AWARD DATA.

uses
  //CALCULATES WAGE ACCORDING TO AWARD/CLASSIFICATION/BASIS OF EMPLOYMENT
  Classes, SysUtils, Graphics, Controls, DateUtils, MyAccess,ERPdbComponents;

const
  RATE_NORMAL  = 2;
  RATE_MEAL    = 9;
  RATE_WEEKEND = 11;

type
  pHoursRec = ^THoursRec;
  THoursRec = record
    Normal: double;
    StartDay: string;
    PayRateID: integer;
    AfterHours1: double;
    AfterHours2: double;
  end;

  TEmployeeAwardRec = record
    Award: integer;
    UseAward: boolean;
    EmployeeName: string;
    BasisOfPayment: string;
    Classification: string;
    Commission: double;
  end;   

type
  TEmployeeAwardPayDetailsObj = class(TObject)
  private
    fsEmpName: string;
    fsPayPeriod: string;
    fsEmploymentBasis: string;
    fsWages: double;
    fsFullTimeRate: double;
    fsPartTimeRate: double;
    fsCasualRate: double;
    fsAllowances: double;
    fsSuperType: string;     // percentage or amount
    fsSuperValue: double;    //percentage or amount
    fsSuperTotal: double;
    fiEmployeeID: integer;
    fsDepartmentID: integer;
    fsAwardID: integer;
    fsAward: string;
    fsClassification: string;
    fiClassificationID: integer;
    fsAnnualLeaveLoading: double;
    fsCommissionLastPaid: TDateTime;
    fsCommissionOnPaid: string;
    fsCommissionOnValue: string;
    fsCommissionOnGross: double;
    fsTotalCommission: double;
    fdNormalHours: double;
    fsDeductions: double;{More fields to be added on a needs basis}
    // extra vars for internal calcs
    iAwardID: integer;
    //   iClassificationID: Integer;
    sStartDay: string;
    ddStartTime: TDateTime;
    ddEndTime: TDateTime;
    sEndDay: string;
    dNormalHours: double;
    dOverTimeHours1: double;
    dOverTimeHours2: double;
    iStartDay: integer;
    iEndDay: integer;
    iDaysDiff: integer;
    dTotalWages: double;
    lstHours: TList;
    pHours: pHoursRec;
    dMealBreakHrs: double;
    dWeekendHrs: double;
    dDayWages: double;
    dMonFriDaily: double;
    sClassificationType: string;
    dSuperCalcOn: double;
    dTmpCommission: double;
    sCommissionPaid: string;
    dtSaleDate: TDateTime;
    dTmpSuper: double;

    class procedure Instance;
  public
    property EmpName: string read fsEmpName;
    property PayPeriod: string read fsPayPeriod;
    property EmploymentBasis: string read fsEmploymentBasis;
    property Wages: double read fsWages;
    property FullTimeRate: double read fsFullTimeRate;
    property PartTimeRate: double read fsPartTimeRate;
    property CasualRate: double read fsCasualRate;
    property Allowances: double read fsAllowances;
    property SuperType: string read fsSuperType;
    property SuperValue: double read fsSuperValue;
    property SuperTotal: double read fsSuperTotal;
    property EmployeeID: integer read fiEmployeeID;
    property DepartmentID: integer read fsDepartmentID;
    property AwardID: integer read fsAwardID;
    property Award: string read fsAward;
    property Classification: string read fsClassification;
    property ClassificationID: integer read fiClassificationID;
    property AnnualLeaveLoading: double read fsAnnualLeaveLoading;
    property CommissionLastPaid: TDateTime read fsCommissionLastPaid;
    property CommissionOnPaid: string read fsCommissionOnPaid;
    property CommissionOnValue: string read fsCommissionOnValue;
    property CommissionOnGross: double read fsCommissionOnGross;
    property TotalCommission: double read fsTotalCommission;
    property NormalHours: double read fdNormalHours;
    property Deductions: double read fsDeductions;
    {More fields to be added on a needs basis}
    procedure PopulateMe(const iEmployeeID: integer); overload;
    procedure PopulateMe(const iEmployeeID: integer; const EmployeeRec: TEmployeeAwardRec); overload;
  end;

var
  EmployeeAwardPay: TEmployeeAwardPayDetailsObj;

implementation

uses
  DB, Dialogs, CommonDbLib, CommonLib;


procedure TEmployeeAwardPayDetailsObj.PopulateMe(const iEmployeeID: integer);
{ Warning: Make sure that you have posted any data required to the BackEnd
  if you are going to use this method.  If your dataset is in transaction mode then
  this could prove difficult.   Best to use the overloaded method below that includes
  the dataset. }
var
  qryEmployeeAward: TERPQuery;
  EmployeeRec: TEmployeeAwardRec;
begin
  begin
    qryEmployeeAward := TERPQuery.Create(nil);
    qryEmployeeAward.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      with qryEmployeeAward do begin
        Sql.Clear;
        Sql.Add('SELECT e.EmployeeID,e.Commission,e.Classification,e.Department,' +
          'e.EmployeeName,e.BasisOfPayment,e.UseAward,e.Award ' +
          'FROM tblemployees e  WHERE EmployeeID = :xEmployeeID');
        ParamByName('xEmployeeID').asInteger := iEmployeeID;
        Open;
        EmployeeRec.Award := FieldByName('Award').AsInteger;
        EmployeeRec.UseAward := FieldByName('UseAward').AsBoolean;
        EmployeeRec.EmployeeName := FieldByName('EmployeeName').AsString;
        EmployeeRec.BasisOfPayment := FieldByName('BasisOfPayment').AsString;
        EmployeeRec.Classification := FieldByName('Classification').AsString;
        EmployeeRec.Commission := FieldByName('Commission').AsFloat;
      end;
      PopulateMe(iEmployeeID, EmployeeRec);
    finally
      FreeandNil(qryEmployeeAward);
    end;
  end;
end;




procedure TEmployeeAwardPayDetailsObj.PopulateMe(const iEmployeeID: integer; const EmployeeRec: TEmployeeAwardRec);
var
  qryAward: TERPQuery;
  qryAwardPayDetails: TERPQuery;
  qryAwardAllowances: TERPQuery;
  qryCommission: TERPQuery;
  qryDeductions: TERPQuery;
  qrySuper: TERPQuery;
  i,k,n: integer;
  sSQL: string;

  procedure FindAwardDetails(Const qryAward: TERPQuery);
  begin
    iAwardID := EmployeeRec.Award;
    if not EmployeeRec.UseAward then begin
      CommonLib.MessageDlgXP_Vista('This employee is not currently using an award', mtWarning , [mbOK], 0);
    end;
    with qryAward do begin
      Sql.Clear;
      Sql.Add
      ('SELECT a.SuperType,a.ClassID,a.SuperValue,a.AwardName,a.AnnualLeaveLoading, a.PayPeriod, a.AnnualLeaveLoading FROM tblawards a WHERE AwardID = :xAwardID');
      ParamByName('xAwardID').asInteger := iAwardID;
      Open;
    end;
  end;

  procedure FindAwardPayDetails(Const qryAwardPayDetails: TERPQuery);
  begin
    with qryAwardPayDetails do begin
      Sql.Clear;
      sSQL := 'SELECT d.AwardID,d.Classification,d.ClassificationID,d.Type,d.FullTime,' +
        'd.PartTime,d.Casual,d.CasualLoading,s.StartDay,s.StartTime,s.EndDay,s.EndTime,' +
        's.Rate1AfterHours,Rate1PayRate,Rate2AfterHours,Rate2PayRate,s.PayRateID ' +
        ' FROM tblawardclassificationdetails d INNER JOIN tblawardshifts s using(AwardID)' +
        ' WHERE d.AwardID = :xAwardID AND d.Classification = "' + fsClassification + '"';
      Sql.Add(sSQL);
      ParamByName('xAwardID').asInteger := iAwardID;
      Open;
      fiClassificationID := qryAwardPayDetails.FieldByName('ClassificationID').AsInteger;
    end;
  end;

  procedure FindSuperDetails(Const qrySuper: TERPQuery);
  begin
    with qrySuper do begin
      Sql.Add('SELECT EmployeeID, Amount,CalcBy FROM tblsuperannuation WHERE EmployeeID = :xEmployeeID');
      ParamByName('xEmployeeID').asInteger := iEmployeeID;
      Open;
    end;
  end;

  procedure FindDeductions(Const qryDeductions: TERPQuery);
  begin
    with qryDeductions do begin
      Sql.Add('SELECT EmployeeID, Amount,TaxExempt FROM tblemployeedeductions WHERE EmployeeID = :xEmployeeID');
      ParamByName('xEmployeeID').asInteger := iEmployeeID;
      Open;
    end;
  end;

  procedure FindAwardAllowances(Const qryAwardAllowances: TERPQuery);
  begin
    with qryAwardAllowances do begin
      Sql.Clear;
      sSQL := 'SELECT d.AwardID,d.ClassificationID,d.AllowanceID,d.Amount, ' +
        'd.BasedOnID FROM tblclassificationallowances d ' + ' WHERE d.AwardID = :xAwardID AND d.ClassificationID = :xClassificationID';
      Sql.Add(sSQL);
      ParamByName('xAwardID').asInteger          := iAwardID;
      ParamByName('xClassificationID').asInteger := fiClassificationID;
      Open;
    end;
  end;

  procedure FindCommissionDetails(Const qryCommission: TERPQuery);
  begin
    with qryCommission do begin
      sSQL := 'select s.EmployeeID,s.SaleID, L.SaleID,L.TotalLineAmount,L.LineCost,s.SaleDate,' +
        ' s.Paid,s.CommissionPaid from tblsales s Inner join  tblsaleslines L using(SaleID)' + ' where s.EmployeeID = :xEmployeeID';
      Sql.Add(sSQL);
      ParamByName('xEmployeeID').asInteger := iEmployeeID;
      Open;
    end;
  end;

  function GetPayRateMultiplier(RateID: integer): double;
  var
    qryRateMultiplier: TERPQuery;
  begin
    qryRateMultiplier := TERPQuery.Create(nil);
    try
      qryRateMultiplier.Connection := CommonDbLib.GetSharedMyDacConnection;
      with qryRateMultiplier do begin
        sSQL := 'SELECT RateID,Multiplier FROM tblpayrates WHERE RateID = :xRateID';
        Sql.Add(sSQL);
        ParamByName('xRateID').asInteger := RateID;
        Open;
      end;
      Result := qryRateMultiplier.FieldByName('Multiplier').AsFloat;
    finally
      FreeandNil(qryRateMultiplier);
    end;
  end;

  procedure ClearlstHours;
  var
    i: integer;
  begin
    for i := 0 to lstHours.Count - 1 do // free memory of Tlist
      Dispose(lstHours.Items[i]);
    lstHours.Clear;
  end;

  procedure LoadHours(const sStartDay: string; const sEndDay: string; const End_Time: TDateTime; const StartTime: TDateTime);
  var
    EndTime: TDateTime;
  begin
    EndTime := End_Time;
    if sStartDay = 'Sunday' then iStartDay := 1;
    if sStartDay = 'Monday' then iStartDay := 2;
    if sStartDay = 'Tuesday' then iStartDay := 3;
    if sStartDay = 'Wednesday' then iStartDay := 4;
    if sStartDay = 'Thursday' then iStartDay := 5;
    if sStartDay = 'Friday' then iStartDay := 6;
    if sStartDay = 'Saturday' then iStartDay := 7;

    if sEndDay = 'Sunday' then iEndDay := 1;
    if sEndDay = 'Monday' then iEndDay := 2;
    if sEndDay = 'Tuesday' then iEndDay := 3;
    if sEndDay = 'Wednesday' then iEndDay := 4;
    if sEndDay = 'Thursday' then iEndDay := 5;
    if sEndDay = 'Friday' then iEndDay := 6;
    if sEndDay = 'Saturday' then iEndDay := 7;

    if iEndDay > iStartDay then begin
      iDaysDiff := iEndDay - iStartDay;
    end else begin
      iDaysDiff := (7 - iStartDay) + iEndDay;
    end;
    if (sStartDay = sEndDay) then begin
      iDaysDiff := 0;
    end;
    EndTime := EndTime + iDaysDiff;
    //load lstHours
    New(pHours);
    lstHours.Add(pHours);
    pHours^.Normal := HourSpan(EndTime, StartTime);
    pHours^.PayRateID := qryAwardPayDetails.FieldByName('PayRateID').AsInteger;
    pHours^.AfterHours1 := qryAwardPayDetails.FieldByName('Rate1AfterHours').AsFloat;
    pHours^.AfterHours2 := qryAwardPayDetails.FieldByName('Rate2AfterHours').AsFloat;
    pHours^.StartDay := sStartDay;
  end;

  function GetDayWage(const StartDay: string; const MonFriDaily: double): double;
  var
    k: integer;
  begin
    dNormalHours := MonFriDaily;
    dOverTimeHours1 := 0;
    dOverTimeHours2 := 0;

    // if no shift details then no wages
    if lstHours.Count = 0 then begin
      Result := 0;
      Exit;
    end;

    // get hours for this specific day - ( not designated as Mon-Fri )
    for k := 0 to lstHours.Count - 1 do begin
      pHours := lstHours.Items[k];
      if (pHours^.StartDay = StartDay) then begin
        if pHours^.PayRateID = RATE_NORMAL then begin
          dNormalHours := dNormalHours + pHours^.Normal;
        end else if (pHours^.PayRateID = RATE_MEAL) then begin
          dMealBreakHrs := dMealBreakHrs + pHours^.Normal;
          dNormalHours := dNormalHours - pHours^.Normal;
        end;
        //         if pHours^.PayRateID = 11 then dWeekendHrs := dWeekendHrs + pHours^.Normal;
      end;
    end;

    // point to this day in list
    for k := 0 to lstHours.Count - 1 do begin
      pHours := lstHours.Items[k];
      if (pHours^.StartDay = StartDay) then begin
        Break;
      end;
    end;

    // overtime
    if pHours^.AfterHours2 <> 0 then begin
      if dNormalHours > pHours^.AfterHours2 then begin
        dOverTimeHours2 := dNormalHours - pHours^.AfterHours2;
        dNormalHours := dNormalHours - dOverTimeHours2;
      end;
    end;
    if pHours^.AfterHours1 <> 0 then begin
      if dNormalHours > pHours^.AfterHours1 then begin
        dOverTimeHours1 := dNormalHours - pHours^.AfterHours1;
        dNormalHours := dNormalHours - dOverTimeHours1;
      end;
    end;

    if fsEmploymentBasis = 'F' then begin           //WAGES     //add weekend later
      dDayWages := dNormalHours * fsFullTimeRate;
      dDayWages := dDayWages + dOverTimeHours1 * fsFullTimeRate *
        (GetPayRateMultiplier(qryAwardPayDetails.FieldByName('Rate1PayRate').AsInteger));
      dDayWages := dDayWages + dOverTimeHours2 * fsFullTimeRate *
        (GetPayRateMultiplier(qryAwardPayDetails.FieldByName('Rate2PayRate').AsInteger));
    end else if fsEmploymentBasis = 'P' then begin
      dDayWages := dNormalHours * fsPartTimeRate;
      dDayWages := dDayWages + dOverTimeHours1 * fsPartTimeRate *
        (GetPayRateMultiplier(qryAwardPayDetails.FieldByName('Rate1PayRate').AsInteger));
      dDayWages := dDayWages + dOverTimeHours2 * fsPartTimeRate *
        (GetPayRateMultiplier(qryAwardPayDetails.FieldByName('Rate2PayRate').AsInteger));
    end else if fsEmploymentBasis = 'C' then begin
      dDayWages := dNormalHours * fsCasualRate;
      dDayWages := dDayWages + dOverTimeHours1 * fsCasualRate *
        (GetPayRateMultiplier(qryAwardPayDetails.FieldByName('Rate1PayRate').AsInteger));
      dDayWages := dDayWages + dOverTimeHours2 * fsCasualRate *
        (GetPayRateMultiplier(qryAwardPayDetails.FieldByName('Rate2PayRate').AsInteger));
    end else if fsEmploymentBasis = 'L' then begin
      //to do
    end else if fsEmploymentBasis = 'S' then begin
      // to do
    end;
    Result := dDayWages;
  end;
begin //--- Begin PopulateMe
  try

    qryAwardPayDetails := TERPQuery.Create(nil);
    qryAwardPayDetails.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryAward           := TERPQuery.Create(nil);
    qryAward.Connection := CommonDbLib.GetSharedMyDacConnection;

    FindAwardDetails(qryAward);

    with EmployeeRec do begin
      fsEmpName := EmployeeName;
      fsEmploymentBasis := BasisOfPayment;
      fsClassification := Classification;
      fsAwardID := Award;
    end;

    with qryAward do try
        fsPayPeriod := FieldByName('PayPeriod').AsString;
        fsSuperValue := FieldByName('SuperValue').AsFloat;
        fsSuperType := FieldByName('SuperType').AsString;
        fsAward := FieldByName('AwardName').AsString;
        fsAnnualLeaveLoading := FieldByName('AnnualLeaveLoading').AsFloat;
        fsDepartmentID := FieldByName('ClassID').AsInteger;
      finally
      end;

  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;

  try
    qryAwardPayDetails := TERPQuery.Create(nil);
    qryAwardPayDetails.Connection := CommonDbLib.GetSharedMyDacConnection;
    FindAwardPayDetails(qryAwardPayDetails);
    with qryAwardPayDetails do try
        //  iClassificationID := FieldByName('ClassificationID').AsInteger;
        fsFullTimeRate := FieldByName('FullTime').AsFloat;
        fsPartTimeRate := FieldByName('PartTime').AsFloat;
        fsCasualRate := FieldByName('Casual').AsFloat;
        sStartDay := FieldByName('StartDay').AsString;
        sEndDay := FieldByName('EndDay').AsString;
        sClassificationType := FieldByName('Type').AsString;
      finally

        try
          qryCommission := TERPQuery.Create(nil);
          qryCommission.Connection := CommonDbLib.GetSharedMyDacConnection;
          FindCommissionDetails(qryCommission);
          with qryCommission do try
              sCommissionPaid := FieldByName('CommissionPaid').AsString;
              dtSaleDate := FieldByName('SaleDate').AsDateTime;
            finally
            end;
        except
          on e: Exception do begin
            raise Exception.Create(e.message);
          end;
        end;
      end;
    qryAwardAllowances := TERPQuery.Create(nil);
    qryAwardAllowances.Connection := CommonDbLib.GetSharedMyDacConnection;
    FindAwardAllowances(qryAwardAllowances);
    try
      fsAllowances := 0;                       // need to take into account 'paid on'
      for i := 1 to qryAwardAllowances.RecordCount do begin
        fsAllowances := fsAllowances + qryAwardAllowances.FieldByName('Amount').AsFloat;
      end;
    finally
    end;

    try
      qrySuper := TERPQuery.Create(nil);
      qrySuper.Connection := CommonDbLib.GetSharedMyDacConnection;
      FindSuperDetails(qrySuper);
      //   with qrySuper do try

      //   end;
    except
      on e: Exception do begin
        raise Exception.Create(e.message);
      end;
    end;

    try
      qryDeductions := TERPQuery.Create(nil);
      qryDeductions.Connection := CommonDbLib.GetSharedMyDacConnection;
      FindDeductions(qryDeductions);
      with qryDeductions do try
          //  fsCommissionOnPaid :=  FieldByName('CommissionOnPaid').AsString;
        finally
        end;
    except
      on e: Exception do begin
        raise Exception.Create(e.message);
      end;
    end;

    lstHours := TList.Create;
    try                                //CALCULATIONS
      qryCommission.First;                                        //COMMISSIONS
      dTmpCommission := 0;
      if fsCommissionLastPaid <> 0 then begin
        for i := 1 to qryCommission.RecordCount do begin
          if fsCommissionOnPaid = 'T' then begin
            if (qryCommission.FieldByName('Paid').AsString = 'T') and
              (qryCommission.FieldByName('CommissionPaid').AsString = 'F') then begin
              if fsCommissionOnValue = 'TOTALSALE' then begin
                dTmpCommission := dTmpCommission + qryCommission.FieldByName('TotalLineAmount').AsFloat;
              end else begin
                dTmpCommission := dTmpCommission + (qryCommission.FieldByName('TotalLineAmount').AsFloat -
                  qryCommission.FieldByName('LineCost').AsFloat);
              end;
            end;
          end else begin
            // TO DO process commission using paid on invoice
          end;
          qryCommission.Next;
        end;
        fsCommissionOnGross := dtmpCommission;
        fsTotalCommission := dtmpCommission * EmployeeRec.Commission / 100;
      end;


      fsWages := 0;                                //WAGES
      if sClassificationType = 'Hourly' then begin
        qryAwardPayDetails.First;
        for n := 1 to qryAwardPayDetails.RecordCount do begin
          dNormalHours := 0;
          dOverTimeHours1 := 0;
          dOverTimeHours2 := 0;                       //load lstHours
          dMealBreakHrs := 0;
          dWeekendHrs := 0;
          dDayWages := 0;
          sStartDay := qryAwardPayDetails.FieldByName('StartDay').AsString;
          sEndDay := qryAwardPayDetails.FieldByName('EndDay').AsString;
          ddStartTime := qryAwardPayDetails.FieldByName('StartTime').AsDateTime;
          ddEndTime := qryAwardPayDetails.FieldByName('EndTime').AsDateTime;
          LoadHours(sStartDay, sEndDay, ddEndTime, ddStartTime);
          qryAwardPayDetails.Next;
        end;

        // Calculate regular daily hours Mon-Fri 
        dNormalHours := 0;
        for k := 0 to lstHours.Count - 1 do begin
          pHours := lstHours.Items[k];
          if (pHours^.StartDay = 'Mon-Fri') then begin
            if pHours^.PayRateID = RATE_NORMAL then begin
              dNormalHours := dNormalHours + pHours^.Normal;
            end else if pHours^.PayRateID = RATE_MEAL then begin
              dMealBreakHrs := dMealBreakHrs + pHours^.Normal;
              dNormalHours := dNormalHours - pHours^.Normal;
            end;
            //   if pHours^.PayRateID = 11 then dWeekendHrs := dWeekendHrs + pHours^.Normal;
          end;
        end;

        dMonFriDaily := dNormalHours;
        dTotalWages := 0;
        fdNormalHours := 0;
        dTotalWages := dTotalWages + GetDayWage('Monday', dMonFriDaily);
        fdNormalHours := fdNormalHours + dMonFriDaily;
        dTotalWages := dTotalWages + GetDayWage('Tuesday', dMonFriDaily);
        fdNormalHours := fdNormalHours + dMonFriDaily;
        dTotalWages := dTotalWages + GetDayWage('Wednesday', dMonFriDaily);
        fdNormalHours := fdNormalHours + dMonFriDaily;
        dTotalWages := dTotalWages + GetDayWage('Thursday', dMonFriDaily);
        fdNormalHours := fdNormalHours + dMonFriDaily;
        dTotalWages := dTotalWages + GetDayWage('Friday', dMonFriDaily);
        fdNormalHours := fdNormalHours + dMonFriDaily;
        dTotalWages := dTotalWages + GetDayWage('Saturday', 0);
        fdNormalHours := fdNormalHours + dMonFriDaily;
        dTotalWages := dTotalWages + GetDayWage('Sunday', 0);
        fdNormalHours := fdNormalHours + dMonFriDaily;
        ClearlstHours;

        fsWages := dTotalWages;

        if PayPeriod = 'Fortnightly' then begin    //26 pay per year
          fsWages := fsWages * 2;
        end;
        if PayPeriod = 'Bi-Monthly' then begin     //24 pays per year
          fsWages := fsWages * 2.667;
        end;
        if PayPeriod = 'Monthly' then begin        //12 pays per year
          fsWages := fsWages * 4.33333;
        end;
      end else begin
        if fsEmploymentBasis = 'F' then begin    // set rates
          fsWages := fsFullTimeRate;
        end;
        if fsEmploymentBasis = 'P' then begin
          fsWages := fsPartTimeRate;
        end;
        if fsEmploymentBasis = 'C' then begin
          fsWages := fsCasualRate;
        end;
        if fsEmploymentBasis = 'L' then begin
          //        fsWages :=
        end;
        if fsEmploymentBasis = 'S' then begin
          //        fsWages :=
        end;

        if sClassificationType = 'Weekly' then begin
          // weekly already set
          if PayPeriod = 'Fortnightly' then begin    //26 pay per year
            fsWages := fsWages * 2;
          end;
          if PayPeriod = 'Bi-Monthly' then begin     //24 pays per year
            fsWages := fsWages * 2.667;
          end;
          if PayPeriod = 'Monthly' then begin        //12 pays per year
            fsWages := fsWages * 4.33333;
          end;
        end;
        if sClassificationType = 'Monthly' then begin
          if PayPeriod = 'Weekly' then begin    //26 pay per year
            fsWages := fsWages / 4.33333;
          end;
          if PayPeriod = 'Fortnightly' then begin    //26 pay per year
            fsWages := fsWages / 4.33333 * 2;
          end;
          if PayPeriod = 'Bi-Monthly' then begin     //24 pays per year
            fsWages := fsWages / 2;
          end;
        end;
        if sClassificationType = 'Annually' then begin
          if PayPeriod = 'Weekly' then begin    //52 pay per year
            fsWages := fsWages / 52;
          end;
          if PayPeriod = 'Fortnightly' then begin    //26 pay per year
            fsWages := fsWages / 26;
          end;
          if PayPeriod = 'Bi-Monthly' then begin     //24 pays per year
            fsWages := fsWages / 24;
          end;
          if PayPeriod = 'Monthly' then begin        //12 pays per year
            fsWages := fsWages / 12;
          end;
        end;
      end;
      //SUPER
      dSuperCalcOn := fsWages + fsTotalCommission + fsAllowances - fsDeductions;
      dTmpSuper := 0;
      qrySuper.First;
      for i := 1 to qrySuper.RecordCount do begin
        if qrySuper.FieldByName('CalcBy').AsString = '%' then begin
          dTmpSuper := dTmpSuper + qrySuper.FieldByName('Amount').AsFloat * dSuperCalcOn / 100;
        end else begin
          dTmpSuper := dTmpSuper + dSuperCalcOn;
        end;
      end;
      fsSuperTotal := dTmpSuper;
    finally
      if Assigned(qryAward) then begin
        FreeandNil(qryAward);
      end;
      if Assigned(qryAwardPayDetails) then begin
        FreeandNil(qryAwardPayDetails);
      end;
      if Assigned(qryAwardAllowances) then begin
        FreeandNil(qryAwardAllowances);
      end;
      if Assigned(qryCommission) then begin
        FreeandNil(qryCommission);
      end;
      if Assigned(qryDeductions) then begin
        FreeandNil(qryDeductions);
      end;
      if Assigned(qrySuper) then begin
        FreeandNil(qrySuper);
      end;
    end;
  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;
end;  // end populate me

class procedure TEmployeeAwardPayDetailsObj.Instance;
begin
  if EmployeeAwardPay = nil then begin
    EmployeeAwardPay := TEmployeeAwardPayDetailsObj.Create;
  end;
end;

initialization
  TEmployeeAwardPayDetailsObj.Instance;

finalization
  if EmployeeAwardPay <> nil then begin
    FreeandNil(EmployeeAwardPay);
  end;
end.
