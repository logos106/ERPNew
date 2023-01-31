unit PayAllowancesObj;

interface

uses
  Classes, DB, kbmMemTable;

type
  TAllowancesObj = class(TObject)
  private
    foOwner: TObject;
    fdTotal: double;
    fdTotalBeforeTax: double;
    fdTotalAfterTax: double;
    fdTotalIncludedInSuper: double;
    FDSAllowances: TDataset;
    fmtTotals: TkbmMemTable;
    procedure SetupAllowancesMemTable;
  public
    constructor Create(const Owner: TObject);
    destructor Destroy; override;
    procedure Recalc;
    procedure PostToAccounts;
    property Owner: TObject read foOwner;
    property DataSet: TDataset read FDSAllowances write FDSAllowances;
    property TotalDS: TkbmMemTable read fmtTotals;
    property Total: double read fdTotal;
    property TotalBeforeTax: double read fdTotalBeforeTax;
    property TotalAfterTax: double read fdTotalAfterTax;
    property TotalIncludedInSuper: double read fdTotalIncludedInSuper;
  end;

implementation
  
uses SysUtils, PayCommon, PayObj,  AppEnvironment;

{ TAllowancesObj }

constructor TAllowancesObj.Create(const Owner: TObject);
begin
  inherited Create;
  foOwner := Owner;
  fmtTotals := TkbmMemTable.Create(nil);
  SetupAllowancesMemTable;
end;

destructor TAllowancesObj.Destroy;
begin
  FreeAndNil(fmtTotals);
  inherited;
end;

procedure TAllowancesObj.PostToAccounts;
var
  CreditAccID: integer;
  DebitAccID: integer;
begin
  if DatasetOk(fmtTotals) then begin
    with fmtTotals do begin
      DisableControls;
      First;
      while not Eof do begin
        DebitAccID := GetAllowanceAccountID(fmtTotals.FieldByName('ID').AsInteger);
        (*if (DebitAccID = 0) then DebitAccID := TPayObj(Self.Owner).PayPreferences.GrossWagesAccountID;
        CreditAccID := TPayObj(Self.Owner).PayPreferences.BankAccountID;*)
        if (DebitAccID = 0) then DebitAccID := AppEnv.PayPrefs.GrossWagesAccountID;
        CreditAccID := AppEnv.PayPrefs.BankAccountID;
        PostToPaysTransactions('Payroll Allowance','Allowance', 'Allowance - ' + FieldByName('Type').AsString, TPayObj(Self.Owner),
          CreditAccID,
          DebitAccID,
          FieldByName('ClassID').AsInteger, FieldByName('PaylineID').AsInteger,
          FieldByName('TotalAmount').AsFloat);
        Next;
      end;
      EnableControls;
    end;
  end;
end;

procedure TAllowancesObj.Recalc;
var
  bm: TBookmark;
  dBasedOnWage: double;
  dAmount: double;
begin
  fdTotal := 0.00;
  fdTotalBeforeTax := 0.00;
  fdTotalAfterTax := 0.00;
  fdTotalIncludedInSuper := 0.00;
  if DatasetOk(FDSAllowances) then begin
    with FDSAllowances do begin
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

        If (FDSAllowances.FindField('PayAllowanceID')= nil) then begin //if tblemployeeallowances loades
          if FieldByName('UseStartEndDates').AsString = 'T' then begin
            if (TPayObj(foOwner).PayDate <= FieldByName('StartDate').AsDateTime)
               or (TPayObj(foOwner).PayDate >= FieldByName('EndDate').AsDateTime)  then begin
              dAmount := 0;
            end;
          end;
        end;

        // All Allowances
        fdTotal := fdTotal + (dAmount * FieldByName('Qty').AsFloat);
        if (FieldByName('TaxExempt').AsString = 'F') then begin
          // Before Tax Allowances
          fdTotalBeforeTax := fdTotalBeforeTax + (dAmount * FieldByName('Qty').AsFloat);
          // Add Taxable Totals
          with TPayObj(Self.Owner).PayTotals.TaxableTotals do begin
            Append;
            FieldByName('ID').AsInteger := FDSAllowances.FieldByName('AllowanceID').AsInteger;
            if (FDSAllowances.FindField('Allowance') <> nil) then begin
              FieldByName('Type').AsString := FDSAllowances.FieldByName('Allowance').AsString;
            end else if (Dataset.FindField('Super') = nil) then begin
              FieldByName('Type').AsString := GetAllowanceName(FieldByName('ID').AsInteger);
            end;
            FieldByName('MSType').AsString := 'Allowance';
            FieldByName('ClassID').AsInteger := FDSAllowances.FieldByName('ClassID').AsInteger;
            FieldByName('Amount').AsFloat := (dAmount * FDSAllowances.FieldByName('Qty').AsFloat);
            If (FDSAllowances.FindField('PayAllowanceID')<>nil) then Begin
              FieldByName('PayLineID').AsInteger := FDSAllowances.FieldByName('PayAllowanceID').AsInteger;
              Post;
            end else Begin
              Cancel;
            end;
          end;
        end else begin
          // After Tax Allowances
          fdTotalAfterTax := fdTotalAfterTax + (dAmount * FieldByName('Qty').AsFloat);
        end;
        if (FieldByName('SuperInc').AsString = 'T') then begin
          // Allowances Included In Super
          fdTotalIncludedInSuper := fdTotalIncludedInSuper + (dAmount * FieldByName('Qty').AsFloat);
        end;

        fmtTotals.Append;
        fmtTotals.FieldByName('ID').AsInteger := FieldByName('AllowanceID').AsInteger;
        if (FDSAllowances.FindField('Allowance') <> nil) then begin
          fmtTotals.FieldByName('Type').AsString := FieldByName('Allowance').AsString;
        end else if (Dataset.FindField('Super') = nil) then begin
          fmtTotals.FieldByName('Type').AsString := GetAllowanceName(FieldByName('AllowanceID').AsInteger);
        end;
        fmtTotals.FieldByName('ClassID').AsInteger := FieldByName('ClassID').AsInteger;
        fmtTotals.FieldByName('Amount').AsFloat := dAmount;
        fmtTotals.FieldByName('TaxExempt').AsBoolean := (FieldByName('TaxExempt').AsString = 'T');
        fmtTotals.FieldByName('TotalAmount').AsFloat := (dAmount * FDSAllowances.FieldByName('Qty').AsFloat);
        If (FDSAllowances.FindField('PayAllowanceID')<>nil) then Begin
          fmtTotals.FieldByName('PayLineID').AsInteger := FDSAllowances.FieldByName('PayAllowanceID').AsInteger;
          fmtTotals.Post;
        end else Begin
          Cancel;
        end;
        Next;
      end;
      
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
      DatasetToEditMode(FDSAllowances);
    end;
  end;
end;

procedure TAllowancesObj.SetupAllowancesMemTable;
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
  fmtTotals.CreateTable;
  fmtTotals.Open;
  fmtTotals.UpdateIndexes;
  fmtTotals.Emptytable;
end;

end.

