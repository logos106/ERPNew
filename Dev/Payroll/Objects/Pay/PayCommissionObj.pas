unit PayCommissionObj;

interface

uses
  Classes, DB, kbmMemTable;

type
  TCommissionObj = class(TObject)
  private
    foOwner: TObject;
    fdTotalNet: double;
    fdTotalGross: double;
    fdTotalBeforeTax: double;
    fdTotalAfterTax: double;
    fdTotalTax: double;
    fdTotalIncludedInSuper: double;
    FDSCommission: TDataset;
    fmtTotals: TkbmMemTable;
    procedure SetupCommissionMemTable;
  public
    constructor Create(const Owner: TObject);
    destructor Destroy; override;
    procedure Recalc;
    function CalcTax(const WeeklyGrossNoCommission, WeeklyNoCommissionTax: double): double;
    procedure PostToAccounts;
    property Owner: TObject read foOwner;
    property DataSet: TDataset read FDSCommission write FDSCommission;
    property TotalDS: TkbmMemTable read fmtTotals;
    property TotalNet: double read fdTotalNet;
    property TotalGross: double read fdTotalGross;
    property TotalTax: double read fdTotalTax;
    property TotalBeforeTax: double read fdTotalBeforeTax;
    property TotalAfterTax: double read fdTotalAfterTax;
    property TotalIncludedInSuper: double read fdTotalIncludedInSuper;
  end;

implementation
  
uses FastFuncs,SysUtils, PayCommon, PayObj, DnmLib, DecimalRounding,
   AppEnvironment;

{ TCommissionObj }

function TCommissionObj.CalcTax(const WeeklyGrossNoCommission, WeeklyNoCommissionTax: double): double;
var
  dTempTax, dTotalWeeklyCommissionTax: double;
  dWeeklyTaxableCommission, dTotalWeeklyTaxableCommission: double;
  dPercentageOfTotalTax, dWeeks: double;
  DSTaxableCommission: TkbmMemTable;

  procedure SetupTaxableCommissionMemTable(MemTable: TkbmMemTable);
  begin
    MemTable.Close;
    with MemTable.FieldDefs.AddFieldDef do begin
      Name     := 'AutoID';
      DataType := ftAutoInc;
    end;
    with MemTable.FieldDefs.AddFieldDef do begin
      Name     := 'TotalAmount';
      DataType := ftFloat;
    end;
    with MemTable.FieldDefs.AddFieldDef do begin
      Name     := 'WeeklyAmount';
      DataType := ftFloat;
    end;
    with MemTable.FieldDefs.AddFieldDef do begin
      Name     := 'WeeksinTotalAmount';
      DataType := ftFloat;
    end;
    with MemTable.FieldDefs.AddFieldDef do begin
      Name     := 'TotalTaxAmount';
      DataType := ftFloat;
    end;
    with MemTable.FieldDefs.AddFieldDef do begin
      Name     := 'TotalsAutoID';
      DataType := ftAutoInc;
    end;
    MemTable.CreateTable;
    MemTable.Open;
    MemTable.UpdateIndexes;
    MemTable.Emptytable;
  end;
begin
  Result := 0.00;
  DSTaxableCommission := TkbmMemTable.Create(nil);
  try
    SetupTaxableCommissionMemTable(DSTaxableCommission);
    if DatasetOk(fmtTotals) then begin
      with fmtTotals do begin
        DisableControls;
        {Get Weekly Amounts}
        First;
        while not Eof do begin
          dWeeklyTaxableCommission := 0.00;
          dWeeks := GetPayPeriodWeeks(FastFuncs.Trim(fmtTotals.FieldByName('Period').AsString));
          if dWeeks = 0 then begin
            dWeeks := GetPayPeriodWeeks(FastFuncs.Trim(TPayObj(Self.Owner).Employee.EmployeeSettings.PayPeriod));
          end;
          if not fmtTotals.FieldByName('TaxExempt').AsBoolean then begin
            dWeeklyTaxableCommission := DivZer(fmtTotals.FieldByName('Amount').AsFloat, dWeeks);
          end;
          DSTaxableCommission.Append;
          DSTaxableCommission.FieldByName('TotalAmount').AsFloat := fmtTotals.FieldByName('Amount').AsFloat;
          DSTaxableCommission.FieldByName('WeeklyAmount').AsFloat := dWeeklyTaxableCommission;
          DSTaxableCommission.FieldByName('WeeksinTotalAmount').AsFloat := dWeeks;
          DSTaxableCommission.FieldByName('TotalsAutoID').AsInteger := fmtTotals.FieldByName('AutoID').AsInteger;
          DSTaxableCommission.Post;
          Next;
        end;
        EnableControls;
      end;

      {Get Total Weekly Commission Tax}
      dTotalWeeklyTaxableCommission := SumField(DSTaxableCommission, 'WeeklyAmount');
      dTempTax := GetTaxComponent(TPayObj(Self.Owner).Employee.EmployeeSettings.TaxScale,
        WeeklyGrossNoCommission + dTotalWeeklyTaxableCommission, 'Weekly',TPayObj(foOwner).IsPayVerify);
      dTotalWeeklyCommissionTax := dTempTax - WeeklyNoCommissionTax;

      {Calc Total Commission Tax}
      DSTaxableCommission.First;
      while not DSTaxableCommission.Eof do begin
        dPercentageOfTotalTax := DivZer(DSTaxableCommission.FieldByName('WeeklyAmount').AsFloat,
          dTotalWeeklyTaxableCommission);
        DSTaxableCommission.Edit;
        DSTaxableCommission.FieldByName('TotalTaxAmount').AsFloat :=
          DecimalRoundDbl((dPercentageOfTotalTax * dTotalWeeklyCommissionTax) *
          DSTaxableCommission.FieldByName('WeeksinTotalAmount').AsFloat, 0, drHalfUp);
        DSTaxableCommission.Post;
        DSTaxableCommission.Next;
      end;

      with fmtTotals do begin
        DisableControls;
        First;
        while not Eof do begin
          if DSTaxableCommission.Locate('TotalsAutoID', fmtTotals.FieldByName('AutoID').AsInteger, []) then begin
            fmtTotals.Edit;
            fmtTotals.FieldByName('TaxAmount').AsFloat := DSTaxableCommission.FieldByName('TotalTaxAmount').AsFloat;
            fmtTotals.Post;
          end;
          Next;
        end;
        EnableControls;
      end;
      Result := SumField(fmtTotals, 'TaxAmount');
      fdTotalTax := Result;
    end;
  finally
    FreeAndNil(DSTaxableCommission);
  end;
end;

constructor TCommissionObj.Create(const Owner: TObject);
begin
  inherited Create;
  foOwner := Owner;
  fmtTotals := TkbmMemTable.Create(nil);
  SetupCommissionMemTable;
end;

destructor TCommissionObj.Destroy;
begin
  FreeAndNil(fmtTotals);
  inherited;
end;

procedure TCommissionObj.PostToAccounts;
var
  CreditAccID: integer;
  DebitAccID: integer;  
begin
  if DatasetOk(fmtTotals) then begin
    with fmtTotals do begin
      DisableControls;
      First;
      while not Eof do begin
        (*DebitAccID := TPayObj(Self.Owner).PayPreferences.GrossWagesAccountID;
        CreditAccID := TPayObj(Self.Owner).PayPreferences.BankAccountID;*)
        DebitAccID := AppEnv.PayPrefs.GrossWagesAccountID;
        CreditAccID := AppEnv.PayPrefs.BankAccountID;
        PostToPaysTransactions('Payroll Commission','Commission', 'Commission - ' + FieldByName('Type').AsString, TPayObj(Self.Owner),
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

procedure TCommissionObj.Recalc;
var
  bm: TBookmark;
begin
  fdTotalNet := 0.00;
  fdTotalGross := 0.00;
  fdTotalBeforeTax := 0.00;
  fdTotalAfterTax := 0.00;
  fdTotalIncludedInSuper := 0.00;
  if DatasetOk(FDSCommission) then begin
    with FDSCommission do begin
      bm := GetBookmark;
      DisableControls;
      fmtTotals.EmptyTable;      
      First;
      while not Eof do begin
        // All Commission
        fdTotalNet := fdTotalNet + FieldByName('Net').AsFloat;
        fdTotalGross := fdTotalGross + FieldByName('Gross').AsFloat;
        if (FieldByName('TaxExempt').AsString = 'F') then begin
          // Before Tax Commission
          fdTotalBeforeTax := fdTotalBeforeTax + FieldByName('Net').AsFloat;
          // Add Taxable Totals
          with TPayObj(Self.Owner).PayTotals.TaxableTotals do begin
            Append;
            FieldByName('ID').AsInteger := FDSCommission.FieldByName('CommissionID').AsInteger;
            FieldByName('Type').AsString := FDSCommission.FieldByName('CommissionDesc').AsString;
            FieldByName('MSType').AsString := 'Commission';
            FieldByName('ClassID').AsInteger := FDSCommission.FieldByName('ClassID').AsInteger;
            FieldByName('Amount').AsFloat := FDSCommission.FieldByName('Net').AsFloat;
            If (FDSCommission.FindField('PayCommissionID')<>nil) then begin
              FieldByName('PayLineID').AsInteger := FDSCommission.FieldByName('PayCommissionID').AsInteger;
              Post;
            end else Begin
              Cancel;
            end;
          end;
        end else begin
          // After Tax Commission
          fdTotalAfterTax := fdTotalAfterTax + FieldByName('Net').AsFloat;
        end;
        if (FieldByName('SuperInc').AsString = 'T') then begin
          // Commission Included In Super
          fdTotalIncludedInSuper := fdTotalIncludedInSuper + FieldByName('Net').AsFloat;
        end;

        fmtTotals.Append;
        fmtTotals.FieldByName('ID').AsInteger := FieldByName('CommissionID').AsInteger;
        fmtTotals.FieldByName('Type').AsString := FieldByName('CommissionDesc').AsString;
        fmtTotals.FieldByName('ClassID').AsInteger := FieldByName('ClassID').AsInteger;
        fmtTotals.FieldByName('Amount').AsFloat := FieldByName('Net').AsFloat;
        fmtTotals.FieldByName('Period').AsString := GetCommissionPeriod(FieldByName('PeriodID').AsInteger);
        fmtTotals.FieldByName('TaxExempt').AsBoolean := (FieldByName('TaxExempt').AsString = 'T');
        fmtTotals.FieldByName('SuperInc').AsBoolean := (FieldByName('SuperInc').AsString = 'T');
        If (FDSCommission.FindField('PayCommissionID')<>nil) then begin
          fmtTotals.FieldByName('PayLineID').AsInteger := FDSCommission.FieldByName('PayCommissionID').AsInteger;
          fmtTotals.Post;
        end else Begin
          Cancel;
        end;
        Next;
      end;
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
      DatasetToEditMode(FDSCommission);
    end;
  end;
end;

procedure TCommissionObj.SetupCommissionMemTable;
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
    Name     := 'Period';
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
    Name     := 'TaxExempt';
    DataType := ftBoolean;
  end;
  with fmtTotals.FieldDefs.AddFieldDef do begin
    Name     := 'SuperInc';
    DataType := ftBoolean;
  end;
  with fmtTotals.FieldDefs.AddFieldDef do begin
    Name     := 'TaxAmount';
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

