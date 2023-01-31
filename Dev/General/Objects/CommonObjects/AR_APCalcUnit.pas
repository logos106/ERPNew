///////////////////////////////////////////////////////////////
  // This is a ERP specific Unit that allows us to perform
  // calculations on Accounts.
  ///////////////////////////////////////////////////////////////

unit AR_APCalcUnit;

interface

uses
   DB, SysUtils, DBAccess, MyAccess,CommonLib, ERPdbComponents;
//const

  ////////////////////////////////////
  // Procedure & Function Declarations.
  ////////////////////////////////////
  // Daniel: 19/3/2004
  ////////////////////////////////////
  // The following functions will only work if
  // if you have the preference option for
  // BATCH TRANSACTIONS FOR REPORTS
  // Turned On .. See Speed Tab.
  ////////////////////////////////////
function ReturnDueAccountsReceivableTotal (AsOf: TDateTime; fConnection : TERPConnection = nil): double;
function ReturnDueAccountsPayableTotal    (AsOf: TDateTime; fConnection : TERPConnection = nil): double;

function ReturnDueARTotalWithinRange      (AsOf: TDateTime; MinDays, MaxDays: integer; fConnection : TERPConnection = nil): double;
function ReturnDueAPTotalWithinRange      (AsOf: TDateTime; MinDays, MaxDays: integer; fConnection : TERPConnection = nil): double;
  ////////////////////////////////////
function CalcPercentage(StdValue, TotalValue: double): double;

implementation

uses
  CommonDbLib, DecimalRounding, DNMLib, {FastFuncs,} tcConst, SyncReportTableObj;

function ReturnDueAccountsReceivableTotal(AsOf: TDateTime; fConnection : TERPConnection = nil): double;
var
  qry: TERPQuery;
  Year, Month, Day: word;
  usingReportTables:Boolean;
begin
  qry := nil;
  try
    try
      // Create Query Component.
      qry := TERPQuery.Create(nil);
      qry.Options.FlatBuffers := True;
      // Set Connection.
      if fConnection = nil then fConnection := CommonDbLib.GetSharedMyDacConnection;
      qry.Connection := fConnection;

      // Decode Date String
      DecodeDate(AsOf, Year, Month, Day);

      // Enter our Query.
      qry.SQL.Clear;
      with qry.SQL do begin
        Add('SELECT');
        Add('IFNULL(Round(Sum(T.DebitsInc-T.CreditsInc),'+inttostr(CurrencyRoundPlaces)+'), 0) AS Opening_Balance');
        Add('FROM tbltransactions T');
        Add('INNER JOIN tblsales S Using(SaleID)');
        Add('WHERE AccountType = "AR" AND S.Balance <> 0.00');
        Add('AND Date < "' + IntToStr(Year) + '-' + IntToStr(Month) + '-' + IntToStr(Day) + '"')
      end;
      Qry.SQL.text := SyncReportObj.ChangeQuery(Qry.SQL.text, usingReportTables);
      // Open Query.
      qry.Open;

      // Return Balance.
      Result := qry.FieldByName('Opening_Balance').AsCurrency;

      // Shutdown Query.
      qry.Close;
    except
      Result := 0;
    end;
  finally
    // Free Objects
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function ReturnDueARTotalWithinRange(AsOf: TDateTime; MinDays, MaxDays: integer; fConnection : TERPConnection = nil): double;
var
  qry: TERPQuery;
  Year, Month, Day: word;
  usingReportTables:Boolean;
begin
  qry := nil;
  try
    try
      // Create Query Component.
      qry := TERPQuery.Create(nil);
      qry.Options.FlatBuffers := True;
      // Set Connection.
      if fConnection = nil then fConnection := CommonDbLib.GetSharedMyDacConnection;
      qry.Connection := fConnection;

      // Decode Date String
      DecodeDate(AsOf, Year, Month, Day);

      // Enter our Query.
      qry.SQL.Clear;
      with qry.SQL do begin
        Add('SELECT ');
        Add('IFNULL(Round(Sum(T.DebitsInc - T.CreditsInc),'+inttostr(CurrencyRoundPlaces)+'), 0) AS Opening_Balance ');
        Add('FROM tbltransactions T ');
        Add('INNER JOIN tblsales S Using(SaleID) ');
        Add('WHERE AccountType = "AR" AND S.Balance <> 0.00 ');
        Add('AND Date <= "' + IntToStr(Year) + '-' + IntToStr(Month) + '-' + IntToStr(Day) + '" ');
        if (MaxDays <> 0) and (MaxDays <> 99999999) then begin
          Add('AND TO_DAYS("' + IntToStr(Year) + '-' + IntToStr(Month) + '-' + IntToStr(Day) +
            '") - TO_DAYS(S.DueDate) >' + IntToStr(MinDays) + ' ');
          Add('AND TO_DAYS("' + IntToStr(Year) + '-' + IntToStr(Month) + '-' + IntToStr(Day) +
            '") - TO_DAYS(S.DueDate) <=' + IntToStr(MaxDays) + ' ');
        end else if (MaxDays = 99999999) then begin
          Add('AND TO_DAYS("' + IntToStr(Year) + '-' + IntToStr(Month) + '-' + IntToStr(Day) +
            '") - TO_DAYS(S.DueDate) >' + IntToStr(MinDays) + ' ');
        end else begin
          Add('AND TO_DAYS("' + IntToStr(Year) + '-' + IntToStr(Month) + '-' + IntToStr(Day) +
            '") - TO_DAYS(S.DueDate) <=' + IntToStr(MaxDays) + ' ');
        end;
      end;

      // Open Query.
      qry.SQL.Text := SyncReportObj.ChangeQuery(Qry.SQl.text,usingReportTables);
      qry.Open;

      // Return Balance.
      Result := qry.FieldByName('Opening_Balance').AsCurrency;

      // Shutdown Query.
      qry.Close;
    except
      Result := 0;
    end;
  finally
    // Free Objects
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function ReturnDueAccountsPayableTotal(AsOf: TDateTime; fConnection : TERPConnection = nil): double;
var
  qry: TERPQuery;
  Year, Month, Day: word;
  usingReportTables:Boolean;
begin
  qry := nil;
  try
    try
      // Create Query Component.
      qry := TERPQuery.Create(nil);
      qry.Options.FlatBuffers := True;
      // Set Connection.
      if fConnection = nil then fConnection := CommonDbLib.GetSharedMyDacConnection;
      qry.Connection := fConnection;

      // Decode Date String
      DecodeDate(AsOf, Year, Month, Day);

      // Enter our Query.
      qry.SQL.Clear;
      with qry.SQL do begin
        Add('SELECT');
        Add('IFNULL(Round(Sum(T.CreditsInc - T.DebitsInc),'+inttostr(CurrencyRoundPlaces)+'), 0) AS Opening_Balance');
        Add('FROM tbltransactions T');
        Add('INNER JOIN tblpurchaseorders S Using(PurchaseOrderID)');
        Add('WHERE AccountType = "AP"');
        Add('AND Date < "' + IntToStr(Year) + '-' + IntToStr(Month) + '-' + IntToStr(Day) + '"')
      end;
      qry.SQL.text := SyncReportObj.ChangeQuery(Qry.SQL.text, usingReportTables);
      // Open Query.
      qry.Open;

      // Return Balance.
      Result := qry.FieldByName('Opening_Balance').AsCurrency;

      // Shutdown Query.
      qry.Close;
    except
      Result := 0;
    end;
  finally
    // Free Objects
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function ReturnDueAPTotalWithinRange(AsOf: TDateTime; MinDays, MaxDays: integer; fConnection : TERPConnection = nil): double;
var
  qry: TERPQuery;
  Year, Month, Day: word;
  usingReportTables:Boolean;
begin
  qry := nil;
  try
    try
      // Create Query Component.
      qry := TERPQuery.Create(nil);
      qry.Options.FlatBuffers := True;
      // Set Connection.
      if fConnection = nil then fConnection := CommonDbLib.GetSharedMyDacConnection;
      qry.Connection := fConnection;

      // Decode Date String
      DecodeDate(AsOf, Year, Month, Day);

      // Enter our Query.
      qry.SQL.Clear;
      with qry.SQL do begin
        Add('SELECT');
        Add('IFNULL(Round(Sum(T.CreditsInc - T.DebitsInc),'+inttostr(CurrencyRoundPlaces)+'), 0) AS Opening_Balance');
        Add('FROM tbltransactions T');
        Add('INNER JOIN tblpurchaseorders S Using(PurchaseOrderID)');
        Add('WHERE AccountType = "AP"');
        Add('AND Date <= "' + IntToStr(Year) + '-' + IntToStr(Month) + '-' + IntToStr(Day) + '" ');
        if (MaxDays <> 0) and (MaxDays <> 99999999) then begin
          Add('AND TO_DAYS("' + IntToStr(Year) + '-' + IntToStr(Month) + '-' + IntToStr(Day) +
            '") - TO_DAYS(S.DueDate) >' + IntToStr(MinDays) + ' ');
          Add('AND TO_DAYS("' + IntToStr(Year) + '-' + IntToStr(Month) + '-' + IntToStr(Day) +
            '") - TO_DAYS(S.DueDate) <=' + IntToStr(MaxDays) + ' ');
        end else if (MaxDays = 99999999) then begin
          Add('AND TO_DAYS("' + IntToStr(Year) + '-' + IntToStr(Month) + '-' + IntToStr(Day) +
            '") - TO_DAYS(S.DueDate) >' + IntToStr(MinDays) + ' ');
        end else begin
          Add('AND TO_DAYS("' + IntToStr(Year) + '-' + IntToStr(Month) + '-' + IntToStr(Day) +
            '") - TO_DAYS(S.DueDate) <=' + IntToStr(MaxDays) + ' ');
        end;
      end;
      Qry.SQL.text := SyncReportObj.ChangeQuery(Qry.SQL.text, usingReportTables);
      // Open Query.
      qry.Open;

      // Return Balance.
      Result := qry.FieldByName('Opening_Balance').AsCurrency;

      // Shutdown Query.
      qry.Close;
    except
      Result := 0;
    end;
  finally
    // Free Objects
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function CalcPercentage(StdValue, TotalValue: double): double;
begin
  if TotalValue = 0 then begin
    Result := 0;
    Exit;
  end;
  Result := DecimalRoundDbl(Divzer(StdValue, TotalValue) * 100, 2, drHalfUp);
end;

end.
