unit PaySundriesObj;

interface

uses
  Classes, DB, kbmMemTable;

type
  TSundriesObj = class(TObject)
  private
    foOwner: TObject;
    fdTotal: double;
    fdTotalBeforeTax: double;
    fdTotalAfterTax: double;
    FDSSundries: TDataset;
    fmtTotals: TkbmMemTable;
    procedure SetupSundriesMemTable;
  public
    constructor Create(const Owner: TObject);
    destructor Destroy; override;
    procedure Recalc;
    procedure PostToAccounts;
    property Owner: TObject read foOwner;
    property DataSet: TDataset read FDSSundries write FDSSundries;
    property TotalDS: TkbmMemTable read fmtTotals;
    property Total: double read fdTotal write fdTotal;
    property TotalBeforeTax: double read fdTotalBeforeTax;
    property TotalAfterTax: double read fdTotalAfterTax;
  end;

implementation
  
uses SysUtils, PayCommon, PayObj,  AppEnvironment;

{ TSundriesObj }

constructor TSundriesObj.Create(const Owner: TObject);
begin
  inherited Create;
  foOwner := Owner;
  fmtTotals := TkbmMemTable.Create(nil);
  SetupSundriesMemTable;
end;

destructor TSundriesObj.Destroy;
begin
  FreeAndNil(fmtTotals);
  inherited;
end;

procedure TSundriesObj.PostToAccounts;
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
        DebitAccID := TPayObj(Self.Owner).PayPreferences.SundriesPaidAccountID;*)
        CreditAccID := AppEnv.PayPrefs.BankAccountID;
        DebitAccID := AppEnv.PayPrefs.SundriesPaidAccountID;
        PostToPaysTransactions('Payroll Sundries','Sundries', 'Sundries - ' + FieldByName('Type').AsString, TPayObj(Self.Owner),
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

procedure TSundriesObj.Recalc;
var
  bm: TBookmark;
begin
  fdTotal := 0.00;
  fdTotalBeforeTax := 0.00;
  fdTotalAfterTax := 0.00;
  if DatasetOk(FDSSundries) then begin
    with FDSSundries do begin
      bm := GetBookmark;
      DisableControls;
      fmtTotals.EmptyTable;       
      First;
      while not Eof do begin
        // All Sundries
        fdTotal := fdTotal + FieldByName('Amount').AsFloat;
        if (FieldByName('TaxExempt').AsString = 'F') then begin
          // Before Tax Sundries
          fdTotalBeforeTax := fdTotalBeforeTax + FieldByName('Amount').AsFloat;
          // Add Taxable Totals
          with TPayObj(Self.Owner).PayTotals.TaxableTotals do begin
            Append;
            FieldByName('ID').AsInteger := FDSSundries.FieldByName('SundryID').AsInteger;
            FieldByName('Type').AsString := FDSSundries.FieldByName('Sundry').AsString;
            FieldByName('MSType').AsString := 'Sundry';
            FieldByName('ClassID').AsInteger := FDSSundries.FieldByName('ClassID').AsInteger;
            FieldByName('Amount').AsFloat := FDSSundries.FieldByName('Amount').AsFloat;
            If (FDSSundries.FindField('PaySundryID')<>nil) then begin
              FieldByName('PayLineID').AsInteger := FDSSundries.FieldByName('PaySundryID').AsInteger;
              Post;
            end else Begin
              Cancel;
            end;
          end;
        end else begin
          // After Tax Sundries
          fdTotalAfterTax := fdTotalAfterTax + FieldByName('Amount').AsFloat;
        end;

        fmtTotals.Append;
        fmtTotals.FieldByName('ID').AsInteger := FieldByName('SundryID').AsInteger;
        fmtTotals.FieldByName('Type').AsString := FieldByName('Sundry').AsString;
        fmtTotals.FieldByName('ClassID').AsInteger := FieldByName('ClassID').AsInteger;
        fmtTotals.FieldByName('Amount').AsFloat := FieldByName('Amount').AsFloat;
        fmtTotals.FieldByName('TaxExempt').AsBoolean := (FieldByName('TaxExempt').AsString = 'T');
        If (FDSSundries.FindField('PaySundryID')<>nil) then begin
          fmtTotals.FieldByName('PayLineID').AsInteger := FDSSundries.FieldByName('PaySundryID').AsInteger;
          fmtTotals.Post;
        end else Begin
          fmtTotals.Cancel;
        end;
        Next;
      end;
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
      DatasetToEditMode(FDSSundries);
    end;
  end;
end;

procedure TSundriesObj.SetupSundriesMemTable;
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
    Name     := 'PayLineID';
    DataType := ftInteger;
  end;
  fmtTotals.CreateTable;
  fmtTotals.Open;
  fmtTotals.UpdateIndexes;
  fmtTotals.Emptytable;
end;

end.

