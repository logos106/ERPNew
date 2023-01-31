unit PayPayRatesObj;

interface

uses
  Classes, DB, kbmMemTable;

type
  TPayRatesObj = class(TObject)
  private
    foOwner: TObject;
    fbIsFirstInstance: boolean;
    fdTotal: double;
    fdTotalCDEP: double;
    fdTotalIncludedInSuper: double;
    fdTotalStandardHours: double;
    fdTotalNonAccumLeaveHours: double;
    fdTotalHrs: double;
    fdHourlyRate: double;
    fiHourlyRateTypeCount: integer;
    FDSPayRates: TDataset;
    fmtTotals: TkbmMemTable;
    procedure SetupPayRatesMemTable;
    procedure CalcRateAmount;
  public
    constructor Create(const Owner: TObject);
    destructor Destroy; override;
    procedure Recalc;
    procedure PostToAccounts;
    procedure RemoveZeroTotalEntries;    
    function GetBasedOnWage(iBasedOnID: integer): double;
    function GetBasedOnHourlyRate(iBasedOnID: integer): double;
    function HasTerminationRecord:Boolean;
    property DataSet: TDataset read FDSPayRates write FDSPayRates;
    property Owner: TObject read foOwner;
    property TotalDS: TkbmMemTable read fmtTotals;
    property Total: double read fdTotal;
    property TotalIncludedInSuper: double read fdTotalIncludedInSuper write fdTotalIncludedInSuper;
    property TotalCDEP: double read fdTotalCDEP;
    property TotalStandardHours: double read fdTotalStandardHours; {Standard Hrs ??}
    property TotalNonAccumLeaveHours: double read fdTotalNonAccumLeaveHours;                        
    property TotalHours: double read fdTotalHrs;
    property HourlyRate: double read fdHourlyRate; {Standard Hrs Rate ??}
    property HourlyRateTypeCount: integer read fiHourlyRateTypeCount;
  end;

implementation
  
uses FastFuncs,SysUtils, PayObj, PayCommon,  CommonDbLib,
  AppEnvironment, CommonLib;

{ TPayRatesObj }

procedure TPayRatesObj.CalcRateAmount;
var
  iPeriod: integer;
  bm: TBookmark;  
begin
  if DatasetOk(FDSPayRates) and (FDSPayRates.FindField('HourlyRate') <> nil) then begin {Employee Form Only}
    with FDSPayRates do begin
      bm := GetBookmark;
      DisableControls;
      First;
      while not Eof do begin
        if (not Empty(FDSPayRates.FieldByName('HourlyRate').AsString)) and (not Empty(FDSPayRates.FieldByName('Qty').AsString)) then
        begin
          FDSPayRates.Edit;
          if FastFuncs.SameText(FastFuncs.Trim(GetPayRateType(FDSPayRates.FieldByName('TypeID').AsInteger)), 'Hourly Rate') then begin
            FDSPayRates.FieldByName('Amount').AsFloat := RoundCurrency(FDSPayRates.FieldByName('Qty').AsFloat *
              FDSPayRates.FieldByName('HourlyRate').AsFloat);
          end else if FastFuncs.SameText(FastFuncs.Trim(GetPayRateType(FDSPayRates.FieldByName('TypeID').AsInteger)), 'Salary') then begin
            FDSPayRates.FieldByName('Amount').AsFloat := RoundCurrency(FDSPayRates.FieldByName('HourlyRate').AsFloat);
          end else if FastFuncs.SameText(FastFuncs.Trim(GetPayRateType(FDSPayRates.FieldByName('TypeID').AsInteger)), 'Annual Salary') then
          begin
            if FastFuncs.SameText(TPayObj(Self.Owner).Employee.EmployeeSettings.PayPeriod, 'Weekly') then begin
              iPeriod := 52;
            end else if FastFuncs.SameText(TPayObj(Self.Owner).Employee.EmployeeSettings.PayPeriod, 'Fortnightly') then begin
              iPeriod := 26;
            end else if FastFuncs.SameText(TPayObj(Self.Owner).Employee.EmployeeSettings.PayPeriod, 'Monthly') then begin
              iPeriod := 12;
            end else if FastFuncs.SameText(TPayObj(Self.Owner).Employee.EmployeeSettings.PayPeriod, 'Bi-Monthly') then begin
              iPeriod := 24;
            end else begin
              iPeriod := 52;
            end;
            FDSPayRates.FieldByName('Amount').AsFloat := RoundCurrency(Divzer(FDSPayRates.FieldByName('HourlyRate').AsFloat,
              iPeriod));
          end;
          FDSPayRates.Post;
        end;
        Next;
      end;
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
      DatasetToEditMode(FDSPayRates);
    end;
  end;
end;

constructor TPayRatesObj.Create(const Owner: TObject);
begin
  inherited Create;
  foOwner := Owner;
  fmtTotals := TkbmMemTable.Create(nil);
  SetupPayRatesMemTable;
  fbIsFirstInstance := true;
end;

destructor TPayRatesObj.Destroy;
begin
  FreeAndNil(fmtTotals);
  inherited;
end;

function TPayRatesObj.GetBasedOnHourlyRate(iBasedOnID: integer): double;
var
  dHrs: double;
  dWages: double;
  bm: TBookmark;
begin
  Result := 0.00;
  if DatasetOk(FDSPayRates) then begin
    with FDSPayRates do begin
      bm := GetBookmark;
      DisableControls;
      FilterDataset(FDSPayRates, GetBasedOnFilter(iBasedOnID));
      dWages := SumField(FDSPayRates, 'LineTotal');
      dHrs := SumField(FDSPayRates, 'Qty');
      Result := DivZer(dWages, dHrs);
      RemoveFilterDataset(FDSPayRates);
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
      DatasetToEditMode(FDSPayRates);
    end;
  end;
end;

function TPayRatesObj.GetBasedOnWage(iBasedOnID: integer): double;
var
  bm: TBookmark;
begin
  Result := 0.00;
  if DatasetOk(FDSPayRates) then begin
    with FDSPayRates do begin
      bm := GetBookmark;
      DisableControls;
      FilterDataset(FDSPayRates, GetBasedOnFilter(iBasedOnID));
      Result := SumField(FDSPayRates, 'LineTotal');
      RemoveFilterDataset(FDSPayRates);
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
      DatasetToEditMode(FDSPayRates);      
    end;
  end;
end;


function TPayRatesObj.HasTerminationRecord: Boolean;
var
  bm: TBookmark;
begin
  result := false;
  if DatasetOk(FDSPayRates) then begin
    with FDSPayRates do begin
      bm := GetBookmark;
      DisableControls;
      FilterDataset(FDSPayRates, '[PayRateID]=' + FastFuncs.IntToStr(GetPayRateID('Termination')));
      result := (FDSPayRates.RecordCount <> 0);
      RemoveFilterDataset(FDSPayRates);
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
      DatasetToEditMode(FDSPayRates);
    end;
  end;
end;

procedure TPayRatesObj.PostToAccounts;
var
  CreditAccID: integer;
  DebitAccID: integer;
begin
  if DatasetOk(fmtTotals) then begin
    with fmtTotals do begin
      DisableControls;
      First;
      while not Eof do begin
        (*CreditAccID := TPayObj(Self.Owner).PayPreferences.BankAccountID;
        DebitAccID := TPayObj(Self.Owner).PayPreferences.GrossWagesAccountID;*)
        CreditAccID := AppEnv.PayPrefs.BankAccountID;
        DebitAccID := AppEnv.PayPrefs.GrossWagesAccountID;

        PostToPaysTransactions('Payroll Gross Wages', 'Gross Wages', 'Gross Wages - ' + FieldByName('Rate').AsString +
          ' : ' + FieldByName('Type').AsString, TPayObj(Self.Owner),
          CreditAccID,
          DebitAccID,
          FieldByName('ClassID').AsInteger, FieldByName('PaylineID').AsInteger,
          FieldByName('Amount').AsFloat);
        Next;
      end;
      EnableControls;
    end;
  end;
end;

procedure TPayRatesObj.Recalc;
var
  bm: TBookmark;
  TempEmployeePayRates: TPayRatesObj;
  TempDSEmployeePayRates: TDataset;
begin
  fdTotal := 0.00;
  fdTotalCDEP := 0.00;
  fdTotalIncludedInSuper := 0.00;
  fdTotalStandardHours := 0.00;
  fdTotalNonAccumLeaveHours := 0;             
  fdTotalHrs := 0.00;
  fdHourlyRate := 0.00;
  fiHourlyRateTypeCount := 0;
  {Check Rates}
  CalcRateAmount;
  if DatasetOk(FDSPayRates) then begin
    with FDSPayRates do begin
      bm := GetBookmark;
      DisableControls;
      fdTotal := SumField(FDSPayRates, 'LineTotal');
      fdTotalHrs := SumField(FDSPayRates, 'Qty');
      if (FDSPayRates.FindField('SuperInc') <> nil) then begin
        FilterDataset(FDSPayRates, '[SuperInc]=' + QuotedStr('T'));
      end else if (FDSPayRates.FindField('Super') <> nil) then begin
        FilterDataset(FDSPayRates, '[Super]=' + QuotedStr('T'));
      end;
      fdTotalIncludedInSuper := SumField(FDSPayRates, 'LineTotal');
      RemoveFilterDataset(FDSPayRates);

      FilterDataset(FDSPayRates, ForeignKeyFilter('PayRateID', 'RateID', 'tblpayrates', 'Multiplier:IsLeave', '1:F'));
      fiHourlyRateTypeCount := FDSPayRates.RecordCount;
      fdTotalStandardHours := SumField(FDSPayRates, 'Qty');

      fdTotalNonAccumLeaveHours :=  SumNonAccumLeave(FDSPayRates,'Qty');    

      //If No Total Standard Hours on Pay get it from Employee Rates
      if (RoundCurrency(fdTotalStandardHours) = 0) and fbIsFirstInstance then begin
        TempEmployeePayRates := TPayRatesObj.Create(TPayObj(Self.Owner));
        try
          TempEmployeePayRates.fbIsFirstInstance := false;
          TempDSEmployeePayRates := RetrieveDataset('tblemployeepayrates', 'EmployeeID',
            TPayObj(Self.Owner).Employee.EmployeeID);
          TempEmployeePayRates.DataSet := TempDSEmployeePayRates;
          TempEmployeePayRates.Recalc;
          fdTotalStandardHours := TempEmployeePayRates.TotalStandardHours;
        finally
          FreeAndNil(TempEmployeePayRates);
        end;
      end;

      fdHourlyRate := DivZer(SumField(FDSPayRates, 'LineTotal'), fdTotalStandardHours);
      if fdHourlyRate <= 0 then begin
        FDSPayRates.First;
        if (FDSPayRates.FindField('HourlyRate') <> nil) then fdHourlyRate := FDSPayRates.FieldByName('HourlyRate').AsFloat;

        if (FDSPayRates.FindField('Amount') <> nil) AND (FDSPayRates.FieldByName('Amount').AsFloat<>0.00) then begin
          if FastFuncs.SameText(FastFuncs.Trim(GetPayRateType(FDSPayRates.FieldByName('TypeID').AsInteger)), 'Hourly Rate') then begin
            fdHourlyRate := FDSPayRates.FieldByName('Amount').AsFloat;
          end else if FastFuncs.SameText(FastFuncs.Trim(GetPayRateType(FDSPayRates.FieldByName('TypeID').AsInteger)), 'Salary') then begin
            fdHourlyRate := RoundCurrency(Divzer(FDSPayRates.FieldByName('Amount').AsFloat, fdTotalStandardHours));
          end else if FastFuncs.SameText(FastFuncs.Trim(GetPayRateType(FDSPayRates.FieldByName('TypeID').AsInteger)), 'Annual Salary') then
          begin
            fdHourlyRate := RoundCurrency(Divzer(FDSPayRates.FieldByName('Amount').AsFloat, fdTotalStandardHours));
          end;
        end;
      end;
      RemoveFilterDataset(FDSPayRates);

      //If No Normal Hours on Pay get it from Employee Rates
      if (RoundCurrency(fdHourlyRate) = 0) and fbIsFirstInstance then begin
        TempEmployeePayRates := TPayRatesObj.Create(TPayObj(Self.Owner));
        try
          TempEmployeePayRates.fbIsFirstInstance := false;
          TempDSEmployeePayRates := RetrieveDataset('tblemployeepayrates', 'EmployeeID',
            TPayObj(Self.Owner).Employee.EmployeeID);
          TempEmployeePayRates.DataSet := TempDSEmployeePayRates;
          TempEmployeePayRates.Recalc;
          fdHourlyRate := TempEmployeePayRates.HourlyRate;
        finally
          FreeAndNil(TempEmployeePayRates);
        end;
      end;

      FilterDataset(FDSPayRates,'[TypeID]=' + FastFuncs.IntToStr(GetPayRateTypeID('CDEP')));
      fdTotalCDEP := SumField(FDSPayRates, 'LineTotal');
      RemoveFilterDataset(FDSPayRates);
      fmtTotals.EmptyTable;
      First;
      while not Eof do begin
        // Add Taxable Totals
        with TPayObj(Self.Owner).PayTotals.TaxableTotals do begin
          Append;
          FieldByName('ID').AsInteger := FDSPayRates.FieldByName('PayRateID').AsInteger;
          FieldByName('Rate').AsString := GetPayRate(FDSPayRates.FieldByName('PayRateID').AsInteger);
          FieldByName('Type').AsString := GetPayRateType(FDSPayRates.FieldByName('TypeID').AsInteger);
          FieldByName('MSType').AsString := 'PayRate';
          FieldByName('ClassID').AsInteger := FDSPayRates.FieldByName('ClassID').AsInteger;
          FieldByName('Amount').AsFloat := FDSPayRates.FieldByName('LineTotal').AsFloat;
          If (FDSPayRates.FindField('PaysPayRateID')<>nil) then begin
            FieldByName('PayLineID').AsInteger := FDSPayRates.FieldByName('PaysPayRateID').AsInteger;
            Post;
          end else Begin
            Cancel;
          end;
        end;
        fmtTotals.Append;
        fmtTotals.FieldByName('ID').AsInteger := FieldByName('PayRateID').AsInteger;
        fmtTotals.FieldByName('Rate').AsString := GetPayRate(FieldByName('PayRateID').AsInteger);
        fmtTotals.FieldByName('Type').AsString := GetPayRateType(FieldByName('TypeID').AsInteger);
        fmtTotals.FieldByName('ClassID').AsInteger := FieldByName('ClassID').AsInteger;
        fmtTotals.FieldByName('Amount').AsFloat := FieldByName('LineTotal').AsFloat;
        If (FindField('PaysPayRateID')<>nil) then begin
          fmtTotals.FieldByName('PayLineID').AsInteger := FieldByName('PaysPayRateID').AsInteger;
          fmtTotals.Post;
        end else Begin
          fmtTotals.Cancel;
        end;
        Next;
      end;
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
      DatasetToEditMode(FDSPayRates);
    end;
  end;
end;

procedure TPayRatesObj.RemoveZeroTotalEntries;
begin
  if DatasetOk(FDSPayRates) then begin
    with FDSPayRates do begin
      DisableControls;
      First;
      while not Eof do begin
        if (RoundCurrency(FDSPayRates.FieldByName('LineTotal').AsFloat) = 0.00) then begin
          try
            Delete;
          except
          end;
        end;
        Next;
      end;
      EnableControls;
      DatasetToEditMode(FDSPayRates);
    end;
  end;
end;

procedure TPayRatesObj.SetupPayRatesMemTable;
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
    Name     := 'Rate';
    DataType := ftString;
    Size     := 255;
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

