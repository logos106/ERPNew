unit PaySuperannuationObj;

interface

uses
  Classes, DB, kbmMemTable, MyAccess;

type
  TSuperannuationObj = class(TObject)
  private
    foOwner: TObject;
    fdTotal: double;
    fdSGCTotal: double;
    fdSGCTotalNoSuperThreshold: double;
    fdEmployerOptionalTotal: double;
    fdEmployerNegativeTotal: double;
    fdSalarySacrificeTotal: double;
    fdEmployeeOptionalTotal: double;
    fdEmployeeNegativeTotal: double;
    fdSpouseContributionTotal: double;
    fdAmountIncludedinSuper: double;    
    FDSSuperannuation: TDataset;
    fmtTotals: TkbmMemTable;
    fbCalcSuperCatchUpMode: boolean;

    procedure SetupSuperannuationMemTable;
  public
    constructor Create(const Owner: TObject);
    destructor Destroy; override;
    procedure Recalc;
    procedure PostToAccounts;
    function SuperThresholdAmount(const SuperAmount: double): double;
    function SuperThresholdCatchUpAmount(const iEmployeeID: integer; const dtPayDate: TDateTime;
      const PayID: integer = 0): double;
    property Owner: TObject read foOwner;
    property DataSet: TDataset read FDSSuperannuation write FDSSuperannuation;
    property TotalDS: TkbmMemTable read fmtTotals;
    property Total: double read fdTotal;
    property SGCTotal: double read fdSGCTotal;
    property SGCTotalNoSuperThreshold: double read fdSGCTotalNoSuperThreshold;
    property EmployerOptionalTotal: double read fdEmployerOptionalTotal;
    property EmployerNegativeTotal: double read fdEmployerNegativeTotal;
    property SalarySacrificeTotal: double read fdSalarySacrificeTotal;
    property EmployeeOptionalTotal: double read fdEmployeeOptionalTotal;
    property EmployeeNegativeTotal: double read fdEmployeeNegativeTotal;
    property SpouseContributionTotal: double read fdSpouseContributionTotal;
    property TotalAmountIncludedinSuper: double read fdAmountIncludedinSuper;
    property CalcSuperCatchUpMode: boolean write fbCalcSuperCatchUpMode;
  end;

implementation
  
uses FastFuncs, SysUtils, PayCommon, PayObj, PayFunctionObj, CommonDbLib, DNMLib, Dialogs,
   AppEnvironment, CommonLib;

{ TSuperannuationObj }

constructor TSuperannuationObj.Create(const Owner: TObject);
begin
  inherited Create;
  foOwner := Owner;
  fmtTotals := TkbmMemTable.Create(nil);
  SetupSuperannuationMemTable;
  fbCalcSuperCatchUpMode := false;  
end;

destructor TSuperannuationObj.Destroy;
begin
  FreeAndNil(fmtTotals);
  inherited;
end;

procedure TSuperannuationObj.PostToAccounts;
var
  CreditAccID: integer;
  DebitAccID: integer;
begin
  DebitAccID := 0;
  CreditAccID := 0;
  if DatasetOk(fmtTotals) then begin
    with fmtTotals do begin
      DisableControls;
      First;
      while not Eof do begin
(*        if FindInSet(FieldByName('Type').AsString, 'Super Guarantee,Salary Sacrifice,Employer Optional') then begin
          DebitAccID := TPayObj(Self.Owner).PayPreferences.SuperPaidAccountID;
          CreditAccID := TPayObj(Self.Owner).PayPreferences.SuperPayableAccountID;
        end else if FindInSet(FieldByName('Type').AsString, 'Employer Negative') then begin
          CreditAccID := TPayObj(Self.Owner).PayPreferences.SuperPayableAccountID;
          DebitAccID := TPayObj(Self.Owner).PayPreferences.SuperPaidAccountID;
        end else if FindInSet(FieldByName('Type').AsString, 'Employee Optional,Spouse Contribution') then begin
          CreditAccID := TPayObj(Self.Owner).PayPreferences.SuperPayableAccountID;
          DebitAccID := TPayObj(Self.Owner).PayPreferences.BankAccountID;
        end else if FindInSet(FieldByName('Type').AsString, 'Employee Negative') then begin
          CreditAccID := TPayObj(Self.Owner).PayPreferences.SuperPayableAccountID;
          DebitAccID := TPayObj(Self.Owner).PayPreferences.BankAccountID;
        end;*)
        if FindInSet(FieldByName('Type').AsString, 'Super Guarantee,Salary Sacrifice,Employer Optional') then begin
          DebitAccID := AppEnv.PayPrefs.SuperPaidAccountID;
          CreditAccID := AppEnv.PayPrefs.SuperPayableAccountID;
        end else if FindInSet(FieldByName('Type').AsString, 'Employer Negative') then begin
          CreditAccID := AppEnv.PayPrefs.SuperPayableAccountID;
          DebitAccID := AppEnv.PayPrefs.SuperPaidAccountID;
        end else if FindInSet(FieldByName('Type').AsString, 'Employee Optional,Spouse Contribution') then begin
          CreditAccID := AppEnv.PayPrefs.SuperPayableAccountID;
          DebitAccID := AppEnv.PayPrefs.BankAccountID;
        end else if FindInSet(FieldByName('Type').AsString, 'Employee Negative') then begin
          CreditAccID := AppEnv.PayPrefs.SuperPayableAccountID;
          DebitAccID := AppEnv.PayPrefs.BankAccountID;
        end;
        PostToPaysTransactions('Payroll Superannuation','Superannuation', 'Superannuation - ' + FieldByName('Type').AsString,
          TPayObj(Self.Owner),
          CreditAccID,
          DebitAccID,
          FieldByName('ClassID').AsInteger, FieldByName('PaylineID').AsInteger,
          FieldByName('Amount').AsFloat);

        {Extra To Remove Salary Sacrifice From Gross}
        if FindInSet(FieldByName('Type').AsString, 'Salary Sacrifice') then begin
          (*DebitAccID := TPayObj(Self.Owner).PayPreferences.BankAccountID;
          CreditAccID := TPayObj(Self.Owner).PayPreferences.GrossWagesAccountID;*)
          DebitAccID := AppEnv.PayPrefs.BankAccountID;
          CreditAccID :=AppEnv.PayPrefs.GrossWagesAccountID;
          PostToPaysTransactions('Payroll Superannuation','Superannuation', 'Superannuation - ' + FieldByName('Type').AsString+'-SS',
            TPayObj(Self.Owner),
            CreditAccID,
            DebitAccID,
            FieldByName('ClassID').AsInteger, FieldByName('PaylineID').AsInteger,
            FieldByName('Amount').AsFloat);
        end;



        Next;
      end;
      EnableControls;
    end;
  end;
end;

procedure TSuperannuationObj.Recalc;
var
  bm: TBookmark;
  dAmount: double;
  iAge: integer;
begin
  fdTotal := 0.00;
  fdSGCTotal := 0.00;
  fdSGCTotalNoSuperThreshold := 0.00;
  fdEmployerOptionalTotal := 0.00;
  fdEmployerNegativeTotal := 0.00;
  fdSalarySacrificeTotal := 0.00;
  fdEmployeeOptionalTotal := 0.00;
  fdEmployeeNegativeTotal := 0.00;
  fdSpouseContributionTotal := 0.00;
  if DatasetOk(FDSSuperannuation) then begin
    // Get the age of this employee
    iAge := GetEmployeeAge(TPayObj(Self.Owner).Employee.EmployeeDetails.DOB, TPayObj(Self.Owner).PayDate);
    with FDSSuperannuation do begin
      bm := GetBookmark;
      DisableControls;
      fmtTotals.EmptyTable;

      //No Super On Leave Loading
      if (TPayObj(Self.Owner).PayRates.TotalIncludedInSuper > 0) and
        not TPayObj(Self.Owner).Leave.LeaveTaken.PaySuperOnLeaveLoading then begin
        TPayObj(Self.Owner).PayRates.TotalIncludedInSuper := TPayObj(Self.Owner).PayRates.TotalIncludedInSuper -
          TPayObj(Self.Owner).Leave.LeaveTaken.SuperOnLeaveLoading;
      end;

      fdAmountIncludedinSuper := TPayObj(Self.Owner).PayRates.TotalIncludedInSuper +
        TPayObj(Self.Owner).Allowances.TotalIncludedInSuper + TPayObj(Self.Owner).Commission.TotalIncludedInSuper;

      //Salary Sacrifice First Because it's Deducted From fdAmountIncludedinSuper
      RemoveFilterDataset(FDSSuperannuation);
      FilterDataset(FDSSuperannuation, '[SuperTypeID]=' + FastFuncs.IntToStr(GetSuperTypeID('Salary Sacrifice')));
      First;
      while not Eof do begin
        if FieldByName('CalcBy').AsString = '%' then begin
          dAmount := fdAmountIncludedinSuper * (FieldByName('Amount').AsFloat / 100);
        end else begin
          dAmount := FieldByName('Amount').AsFloat;
        end;

        dAmount := RoundCurrency(dAmount);

        if TPayObj(Self.Owner).Paid then begin
          if (FindField('AmountToPaid') <> nil) then begin
            dAmount := FieldByName('AmountToPaid').AsFloat;
          end else if (FindField('AmountPaid') <> nil) then begin
            dAmount := FieldByName('AmountPaid').AsFloat;
          end;
        end;

        if GetSuperName(FieldByName('SuperTypeID').AsInteger) = 'Salary Sacrifice' then begin
          fdSalarySacrificeTotal := fdSalarySacrificeTotal + dAmount;
          // Add Taxable Totals
          with TPayObj(Self.Owner).PayTotals.TaxableTotals do begin
            Append;
            FieldByName('ID').AsInteger := FDSSuperannuation.FieldByName('SuperID').AsInteger;
            FieldByName('Type').AsString := GetSuperName(FDSSuperannuation.FieldByName('SuperTypeID').AsInteger);
            FieldByName('MSType').AsString := 'Superannuation';
            FieldByName('ClassID').AsInteger := FDSSuperannuation.FieldByName('ClassID').AsInteger;
            FieldByName('Amount').AsFloat := -dAmount;
            If (FDSSuperannuation.FindField('PaySuperID')<>nil) then Begin
              FieldByName('PayLineID').AsInteger := FDSSuperannuation.FieldByName('PaySuperID').AsInteger;
              Post;
            end else Begin
              Cancel;
            end;
          end;
          fdTotal := fdTotal + dAmount;


          //Set Line Totals
          if (FindField('AmountToPaid') <> nil) then begin
            Edit;
            FieldByName('AmountToPaid').AsFloat := dAmount;
          end else if (FindField('AmountPaid') <> nil) then begin
            Edit;
            FieldByName('AmountPaid').AsFloat := dAmount;
          end;
          
          fmtTotals.Append;
          fmtTotals.FieldByName('ID').AsInteger := FieldByName('SuperID').AsInteger;
          fmtTotals.FieldByName('Type').AsString := GetSuperName(FieldByName('SuperTypeID').AsInteger);
          fmtTotals.FieldByName('ClassID').AsInteger := FieldByName('ClassID').AsInteger;
          fmtTotals.FieldByName('Amount').AsFloat := dAmount;
          If (FDSSuperannuation.FindField('PaySuperID')<>nil) then begin
            fmtTotals.FieldByName('PayLineID').AsInteger := FDSSuperannuation.FieldByName('PaySuperID').AsInteger;
            fmtTotals.Post;
          end else Begin
            fmtTotals.Cancel;
          end;
        end;
        Next;
      end;

      //All But Salary Sacrifice
      RemoveFilterDataset(FDSSuperannuation);
      FilterDataset(FDSSuperannuation, '[SuperTypeID]<>' + FastFuncs.IntToStr(GetSuperTypeID('Salary Sacrifice')));
      First;
      fdAmountIncludedinSuper := fdAmountIncludedinSuper - fdSalarySacrificeTotal;
      while not Eof do begin
        if FieldByName('CalcBy').AsString = '%' then begin
          dAmount := fdAmountIncludedinSuper * (FieldByName('Amount').AsFloat / 100);
        end else begin
          dAmount := FieldByName('Amount').AsFloat;
        end;

        dAmount := RoundCurrency(dAmount);

        if TPayObj(Self.Owner).Paid and not fbCalcSuperCatchUpMode then begin
          if (FindField('AmountToPaid') <> nil) then begin
            dAmount := FieldByName('AmountToPaid').AsFloat;
          end else if (FindField('AmountPaid') <> nil) then begin
            dAmount := FieldByName('AmountPaid').AsFloat;
          end;
        end;

        if (GetSuperName(FieldByName('SuperTypeID').AsInteger) = 'Super Guarantee') then begin
          (*if not TPayObj(Self.Owner).PayPreferences.PaySuperToOver70 then begin
            if (iAge > 70) then begin
              dAmount := 0.00;
            end;
          end;
          if not TPayObj(Self.Owner).PayPreferences.PayUnder18 then begin
            if ((TPayObj(Self.Owner).PayRates.TotalStandardHours < 30) and (iAge < 18) and
              ((TPayObj(Self.Owner).Employee.EmployeeSettings.EmploymentBasis = 'P') or
              (TPayObj(Self.Owner).Employee.EmployeeSettings.EmploymentBasis = 'C'))) then begin
              dAmount := 0.00;
            end;
          end;*)
          if not AppEnv.PayPrefs.PaySuperToOver70 then begin
            if (iAge > 70) then begin
              dAmount := 0.00;
            end;
          end;
          if not AppEnv.PayPrefs.PayUnder18 then begin
            if ((TPayObj(Self.Owner).PayRates.TotalStandardHours < 30) and (iAge < 18) and
              ((TPayObj(Self.Owner).Employee.EmployeeSettings.EmploymentBasis = 'P') or
              (TPayObj(Self.Owner).Employee.EmployeeSettings.EmploymentBasis = 'C'))) then begin
              dAmount := 0.00;
            end;
          end;

          fdSGCTotalNoSuperThreshold := fdSGCTotalNoSuperThreshold + dAmount;

          if (not TPayObj(Self.Owner).Paid) or fbCalcSuperCatchUpMode then dAmount := SuperThresholdAmount(dAmount);

          fdSGCTotal := fdSGCTotal + dAmount;
        end else if GetSuperName(FieldByName('SuperTypeID').AsInteger) = 'Employer Optional' then begin
          fdEmployerOptionalTotal := fdEmployerOptionalTotal + dAmount;
        end else if GetSuperName(FieldByName('SuperTypeID').AsInteger) = 'Employer Negative' then begin
          dAmount := -dAmount;
          fdEmployerNegativeTotal := fdEmployerNegativeTotal + dAmount;
        end else if GetSuperName(FieldByName('SuperTypeID').AsInteger) = 'Salary Sacrifice' then begin
          Continue; //Just In Case ?? Should Be Done In The Above Loop
        end else if GetSuperName(FieldByName('SuperTypeID').AsInteger) = 'Employee Optional' then begin
          fdEmployeeOptionalTotal := fdEmployeeOptionalTotal + dAmount;
        end else if GetSuperName(FieldByName('SuperTypeID').AsInteger) = 'Employee Negative' then begin
          dAmount := -dAmount;
          fdEmployeeNegativeTotal := fdEmployeeNegativeTotal + dAmount;
        end else if GetSuperName(FieldByName('SuperTypeID').AsInteger) = 'Spouse Contribution' then begin
          fdSpouseContributionTotal := fdSpouseContributionTotal + dAmount;
        end;
        fdTotal := fdTotal + dAmount;

        //Set Line Totals
        if (FindField('AmountToPaid') <> nil) then begin
          Edit;
          FieldByName('AmountToPaid').AsFloat := dAmount;
        end else if (FindField('AmountPaid') <> nil) then begin
          Edit;
          FieldByName('AmountPaid').AsFloat := dAmount;
        end;

        fmtTotals.Append;
        fmtTotals.FieldByName('ID').AsInteger := FieldByName('SuperID').AsInteger;
        fmtTotals.FieldByName('Type').AsString := GetSuperName(FieldByName('SuperTypeID').AsInteger);
        fmtTotals.FieldByName('ClassID').AsInteger := FieldByName('ClassID').AsInteger;
        fmtTotals.FieldByName('Amount').AsFloat := dAmount;
        If (FDSSuperannuation.FindField('PaySuperID')<>nil) then
          fmtTotals.FieldByName('PayLineID').AsInteger := FDSSuperannuation.FieldByName('PaySuperID').AsInteger;
        fmtTotals.Post;

        Next;
      end;
      RemoveFilterDataset(FDSSuperannuation);
      fdTotal := fdSGCTotal + fdEmployerOptionalTotal + fdEmployerNegativeTotal + fdSalarySacrificeTotal +
        fdEmployeeOptionalTotal + fdEmployeeNegativeTotal + fdSpouseContributionTotal;
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
      DatasetToEditMode(FDSSuperannuation);
    end;
  end;
end;

function TSuperannuationObj.SuperThresholdCatchUpAmount(const iEmployeeID: integer;
  const dtPayDate: TDateTime; const PayID: integer = 0): double;
var
  qryPays: TMyQuery;
  wDay, wMonth, wYear: word;
  dtStartDate: TDateTime;
  PayFunctions: TPayFunctionObj;
  SGCTotal, SGCTotalNoThreshold: double;
  SGC, SGCNoThreshold: double;
  dtTestDate: TDateTime;
  iTestID: integer;
  bmTest: TBookmark;
begin
  qryPays := TMyQuery.Create(nil);
  try
    qryPays.Options.FlatBuffers := True;
    SGCTotal := 0.0;
    SGCTotalNoThreshold := 0.0;
    SGC      := 0.0;
    SGCNoThreshold := 0.0;
    qryPays.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryPays.SQL.Clear;
    qryPays.SQL.Add('SELECT PayID,PayDate,EmployeeID FROM tblpays');
    qryPays.SQL.Add('WHERE EmployeeID = :xEmployeeID AND Paid = "T" AND Deleted = "F" AND (PayDate BETWEEN :dtFrom AND :dtTo) ');
    qryPays.SQL.Add(' AND PayID <> :xPayID ');
    DecodeDate(dtPayDate, wYear, wMonth, wDay);
    dtStartDate := EncodeDate(wYear, wMonth, 1);
    qryPays.Params.ParamByName('dtFrom').AsDateTime := dtStartDate;
    qryPays.Params.ParamByName('dtTo').AsDateTime := dtPayDate;
    qryPays.Params.ParamByName('xEmployeeID').AsInteger := iEmployeeID;
    qryPays.Params.ParamByName('xPayID').AsInteger := PayID;
    qryPays.Open;
    if qryPays.RecordCount > 0 then begin
      //Test For multiple Pays on The Same Day
      qryPays.First;
      while not qryPays.Eof do begin
        dtTestDate := qryPays.FieldByName('PayDate').AsDateTime;
        iTestID := qryPays.FieldByName('PayID').AsInteger;
        bmTest := qryPays.GetBookmark;
        qryPays.First;
        while not qryPays.Eof do begin
          if (dtTestDate = qryPays.FieldByName('PayDate').AsDateTime) and (iTestID <> qryPays.FieldByName('PayID').AsInteger) then
          begin
            CommonLib.MessageDlgXP_Vista('Employee (' + DNMLib.GetEmployeeName(qryPays.FieldByName('EmployeeID').AsInteger) +
              ') Has Been Paid Twice On Same Day' + #13 + #10 + '' + #13 + #10 +
              'Superannuation Calculation May Be Incorrect.',
              mtWarning, [mbOK], 0);
            Result := 0.00;
            Exit;
          end;
          qryPays.Next;
        end;
        qryPays.GotoBookmark(bmTest);
        qryPays.FreeBookmark(bmTest);
        qryPays.Next;
      end;
      //
      PayFunctions := TPayFunctionObj.Create;
      try
        qryPays.First;
        while not qryPays.Eof do begin
          PayFunctions.SGCInThisPay(qryPays.FieldByName('PayID').AsInteger, SGC, SGCNoThreshold);
          SGCTotalNoThreshold := SGCTotalNoThreshold + SGCNoThreshold;
          SGCTotal := SGCTotal + SGC;
          qryPays.Next;
        end;
        Result := (SGCTotalNoThreshold - SGCTotal);
      finally
        FreeAndNil(PayFunctions);
      end;
    end else begin
      Result := 0.00;
    end;
  finally
    FreeAndNil(qryPays);
  end;
end;

function TSuperannuationObj.SuperThresholdAmount(const SuperAmount: double): double;
var
  ThresholdAmount: double;
begin
        { TODO -orobin : ThresholdAmount remmed out; this obj will be deleted in future }


  Result := SuperAmount;
  ThresholdAmount := 0; //SuperThreshold(TPayObj(Self.Owner).Employee.EmployeeSettings.Award,TPayObj(Self.Owner));

  //Threshold
  (*if (TPayObj(Self.Owner).PayPreferences.MonthSuperTPermanent) or (TPayObj(Self.Owner).PayPreferences.MonthSuperTPartTime) or
    (TPayObj(Self.Owner).PayPreferences.MonthSuperTCasual) then begin
    if (TPayObj(Self.Owner).Employee.EmployeeSettings.EmploymentBasis = 'F') and
      (TPayObj(Self.Owner).PayPreferences.MonthSuperTPermanent) then begin    *)
  if (AppEnv.PayPrefs.MonthSuperTPermanent) or (AppEnv.PayPrefs.MonthSuperTPartTime) or
    (AppEnv.PayPrefs.MonthSuperTCasual) then begin
    if (TPayObj(Self.Owner).Employee.EmployeeSettings.EmploymentBasis = 'F') and
      (AppEnv.PayPrefs.MonthSuperTPermanent) then begin
      if (GetMonthlyGrossTotal(TPayObj(Self.Owner).Employee.EmployeeID, TPayObj(Self.Owner).PayDate,
        TPayObj(Self.Owner).PayID) + TPayObj(Self.Owner).PayTotals.Gross) > ThresholdAmount then begin
        Result := SuperAmount;
      end else begin
        Result := 0.00;
      end;
      if Result > 0.00 then begin // All Ready Got Super so Gross , Threshold ect OK;
        Result := Result + SuperThresholdCatchUpAmount(TPayObj(Self.Owner).Employee.EmployeeID,
          TPayObj(Self.Owner).PayDate, TPayObj(Self.Owner).PayID);
      end;
    end;

(*    if (TPayObj(Self.Owner).Employee.EmployeeSettings.EmploymentBasis = 'P') and
      (TPayObj(Self.Owner).PayPreferences.MonthSuperTPartTime) then begin*)
    if (TPayObj(Self.Owner).Employee.EmployeeSettings.EmploymentBasis = 'P') and
      (AppEnv.PayPrefs.MonthSuperTPartTime) then begin
      if (GetMonthlyGrossTotal(TPayObj(Self.Owner).Employee.EmployeeID, TPayObj(Self.Owner).PayDate,
        TPayObj(Self.Owner).PayID) + TPayObj(Self.Owner).PayTotals.Gross) > ThresholdAmount then begin
        Result := SuperAmount;
      end else begin
        Result := 0.00;
      end;
      if Result > 0.00 then begin // All Ready Got Super so Gross , Threshold ect OK;
        Result := Result + SuperThresholdCatchUpAmount(TPayObj(Self.Owner).Employee.EmployeeID,
          TPayObj(Self.Owner).PayDate, TPayObj(Self.Owner).PayID);
      end;
    end;

(*    if (TPayObj(Self.Owner).Employee.EmployeeSettings.EmploymentBasis = 'C') and
      (TPayObj(Self.Owner).PayPreferences.MonthSuperTCasual) then begin*)
    if (TPayObj(Self.Owner).Employee.EmployeeSettings.EmploymentBasis = 'C') and
      (AppEnv.PayPrefs.MonthSuperTCasual) then begin
      if (GetMonthlyGrossTotal(TPayObj(Self.Owner).Employee.EmployeeID, TPayObj(Self.Owner).PayDate,
        TPayObj(Self.Owner).PayID) + TPayObj(Self.Owner).PayTotals.Gross) > ThresholdAmount then begin
        Result := SuperAmount;
      end else begin
        Result := 0.00;
      end;
      if Result > 0.00 then begin // All Ready Got Super so Gross , Threshold ect OK;
        Result := Result + SuperThresholdCatchUpAmount(TPayObj(Self.Owner).Employee.EmployeeID,
          TPayObj(Self.Owner).PayDate, TPayObj(Self.Owner).PayID);
      end;
    end;
  end else begin
    Result := SuperAmount;
  end;
end;

procedure TSuperannuationObj.SetupSuperannuationMemTable;
begin
  fmtTotals.Close;
  with fmtTotals.FieldDefs.AddFieldDef do begin
    Name     := 'AutoID';
    DataType := ftAutoInc;
  end;
  with fmtTotals.FieldDefs.AddFieldDef do begin
    Name     := 'ID';
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
    Name     := 'Amount';
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

