unit PayDeductionsObj;

interface

uses
  Classes, DB, kbmMemTable;

type
  TDeductionsObj = class(TObject)
  private
    foOwner: TObject;
    fdTotal: double;
    fdTotalBeforeTax: double;
    fdTotalAfterTax: double;
    FDSDeductions: TDataset;
    fmtTotals: TkbmMemTable;
    procedure SetupDeductionsMemTable;
  public
    constructor Create(const Owner: TObject);
    destructor Destroy; override;
    procedure Recalc;
    procedure PostToAccounts;
    property Owner: TObject read foOwner;
    property DataSet: TDataset read FDSDeductions write FDSDeductions;
    property TotalDS: TkbmMemTable read fmtTotals;
    property Total: double read fdTotal write fdTotal;
    property TotalBeforeTax: double read fdTotalBeforeTax;
    property TotalAfterTax: double read fdTotalAfterTax;
  end;

implementation
  
uses SysUtils, PayCommon, PayObj,  AppEnvironment;

{ TDeductionsObj }

constructor TDeductionsObj.Create(const Owner: TObject);
begin
  inherited Create;
  foOwner := Owner;
  fmtTotals := TkbmMemTable.Create(nil);
  SetupDeductionsMemTable;
end;

destructor TDeductionsObj.Destroy;
begin
  FreeAndNil(fmtTotals);
  inherited;
end;

procedure TDeductionsObj.PostToAccounts;
var
  CreditAccID: integer;
  DebitAccID: integer;
begin
  if DatasetOk(fmtTotals) then begin
    with fmtTotals do begin
      DisableControls;
      First;
      while not Eof do begin
        {Because Amount is Whole (not Neg) Debit=Credit etc}

        CreditAccID := FieldByName('AccountID').AsInteger;
        
        if FieldByName('TaxExempt').AsBoolean then begin
          (*DebitAccID := TPayObj(Self.Owner).PayPreferences.BankAccountID;*)
          DebitAccID := AppEnv.PayPrefs.BankAccountID;
        end else begin
          (*DebitAccID := TPayObj(Self.Owner).PayPreferences.GrossWagesAccountID;*)
          DebitAccID := AppEnv.PayPrefs.GrossWagesAccountID;
        end;

        PostToPaysTransactions('Payroll Deductions','Deductions', 'Deduction - ' + FieldByName('Type').AsString, TPayObj(Self.Owner),
          CreditAccID,
          DebitAccID,
          FieldByName('ClassID').AsInteger, FieldByName('PaylineID').AsInteger,
          FieldByName('TotalAmount').AsFloat);

        {Remove From Gross For TaxExempt}
        if not FieldByName('TaxExempt').AsBoolean then begin
          (*DebitAccID := TPayObj(Self.Owner).PayPreferences.BankAccountID;
          CreditAccID := TPayObj(Self.Owner).PayPreferences.GrossWagesAccountID;*)
          DebitAccID := AppEnv.PayPrefs.BankAccountID;
          CreditAccID := AppEnv.PayPrefs.GrossWagesAccountID;
          PostToPaysTransactions('Payroll Deductions','Deductions TaxExempt', 'Deduction - ' + FieldByName('Type').AsString, TPayObj(Self.Owner),
            CreditAccID,
            DebitAccID,
            FieldByName('ClassID').AsInteger, FieldByName('PaylineID').AsInteger,
            FieldByName('TotalAmount').AsFloat);
        end;
        Next;
      end;
      EnableControls;
    end;
  end;
end;

procedure TDeductionsObj.Recalc;
var
  bm: TBookmark;
  dBasedOnWage: double;
  dAmount: double;
begin
  fdTotal := 0.00;
  fdTotalBeforeTax := 0.00;
  fdTotalAfterTax := 0.00;
  if DatasetOk(FDSDeductions) then begin
    with FDSDeductions do begin
      bm := GetBookmark;
      DisableControls;
      fmtTotals.EmptyTable;
      First;
      while not Eof do begin
        if FieldByName('CalcBy').AsString = '%' then begin
          dBasedOnWage := TPayObj(Self.Owner).PayRates.GetBasedOnWage(FieldByName('BasedOnID').AsInteger);
          dAmount := dBasedOnWage * FieldByName('Amount').AsFloat / 100;
        end else begin
          dAmount := FieldByName('Amount').AsFloat;
        end;
        If (FDSDeductions.FindField('PayDeductionID')= nil) then begin //if tblemployeedeductions loades
          if FieldByName('UseStartEndDates').AsString = 'T' then begin
            if (TPayObj(foOwner).PayDate <= FieldByName('StartDate').AsDateTime)
               or (TPayObj(foOwner).PayDate >= FieldByName('EndDate').AsDateTime)  then begin
              dAmount := 0;
            end;
          end;
        end;
        
        // All Deductions
        fdTotal := fdTotal + (dAmount * FieldByName('Qty').AsFloat);
        if (FieldByName('TaxExempt').AsString = 'F') then begin
          // Before Tax Deductions
          fdTotalBeforeTax := fdTotalBeforeTax + (dAmount * FieldByName('Qty').AsFloat);
          // Add Taxable Totals
          with TPayObj(Self.Owner).PayTotals.TaxableTotals do begin
            Append;
            FieldByName('ID').AsInteger := FDSDeductions.FieldByName('DeductionID').AsInteger;
            if (FDSDeductions.FindField('Deduction') <> nil) then begin
              FieldByName('Type').AsString := FDSDeductions.FieldByName('Deduction').AsString;
            end else if (Dataset.FindField('Super') = nil) then begin
              FieldByName('Type').AsString := GetDeductionName(FieldByName('ID').AsInteger);
            end;
            FieldByName('MSType').AsString := 'Deduction';
            FieldByName('ClassID').AsInteger := FDSDeductions.FieldByName('ClassID').AsInteger;
            FieldByName('Amount').AsFloat := (dAmount * FDSDeductions.FieldByName('Qty').AsFloat);
            If (FDSDeductions.FindField('PayDeductionID')<>nil) then begin
              FieldByName('PayLineID').AsInteger := FDSDeductions.FieldByName('PayDeductionID').AsInteger;
              Post;
            end else Begin
              Cancel;
            end;
          end;
        end else begin
          // After Tax Deductions
          fdTotalAfterTax := fdTotalAfterTax + (dAmount * FieldByName('Qty').AsFloat);
        end;

        fmtTotals.Append;
        fmtTotals.FieldByName('ID').AsInteger := FieldByName('DeductionID').AsInteger;
        if (FDSDeductions.FindField('Deduction') <> nil) then begin
          fmtTotals.FieldByName('Type').AsString := FDSDeductions.FieldByName('Deduction').AsString;
        end else if (Dataset.FindField('Super') = nil) then begin
          fmtTotals.FieldByName('Type').AsString := GetDeductionName(FieldByName('DeductionID').AsInteger);
        end;
        fmtTotals.FieldByName('ClassID').AsInteger := FieldByName('ClassID').AsInteger;
        fmtTotals.FieldByName('Amount').AsFloat := dAmount;
        fmtTotals.FieldByName('TaxExempt').AsBoolean := (FieldByName('TaxExempt').AsString = 'T');
        fmtTotals.FieldByName('TotalAmount').AsFloat := (dAmount * FDSDeductions.FieldByName('Qty').AsFloat);
        if GetDeductionAccountID(FieldByName('DeductionID').AsInteger) = 0 then begin
          (*fmtTotals.FieldByName('AccountID').AsInteger := TPayObj(Self.Owner).PayPreferences.DeductionLiabilityAccountID;*)
          fmtTotals.FieldByName('AccountID').AsInteger := AppEnv.PayPrefs.DeductionLiabilityAccountID;
        end else begin
          fmtTotals.FieldByName('AccountID').AsInteger := GetDeductionAccountID(FieldByName('DeductionID').AsInteger);
        end;

        If (FDSDeductions.FindField('PayDeductionID')<>nil) then Begin
          fmtTotals.FieldByName('PayLineID').AsInteger := FDSDeductions.FieldByName('PayDeductionID').AsInteger;
          fmtTotals.Post;
            end else Begin
              Cancel;
            end;
        Next;
      end;
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
      DatasetToEditMode(FDSDeductions);
    end;
  end;
end;

procedure TDeductionsObj.SetupDeductionsMemTable;
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
    Name     := 'TaxExempt';
    DataType := ftBoolean;
  end;
  with fmtTotals.FieldDefs.AddFieldDef do begin
    Name     := 'TotalAmount';
    DataType := ftFloat;
  end;
  with fmtTotals.FieldDefs.AddFieldDef do begin
    Name     := 'PayLineID';
    DataType := ftInteger;
  end;
  with fmtTotals.FieldDefs.AddFieldDef do begin
    Name     := 'AccountID';
    DataType := ftInteger;
  end;

  fmtTotals.CreateTable;
  fmtTotals.Open;
  fmtTotals.UpdateIndexes;
  fmtTotals.Emptytable;
end;

end.

