unit PayLeaveTakenObj;

interface

uses
  Classes, DB, kbmMemTable, MyAccess;

type
  TLeaveTaken = class(TObject)
  private
    foOwner: TObject;
    fdLeaveLoading: double;
    fbPaySuperOnLeaveLoading: boolean;
    fdSuperOnLeaveLoading: double;
    fmtTotals: TkbmMemTable;
    procedure SetupLeaveTakenMemTable;
    function GetLeaveLoading(TypeID: integer): double;
  public
    constructor Create(const Owner: TObject);
    destructor Destroy; override;
    procedure Recalc;
    procedure PostToAccounts;
    property Owner: TObject read foOwner;
    function NonTaxableLeaveLoading: double;
    function GetHrs(const LeaveID: integer): double;
    function GetAmount(const LeaveID: integer): double;
    property TotalDS: TkbmMemTable read fmtTotals;
    property ThisPayLeaveLoading: double read fdLeaveLoading;
    property PaySuperOnLeaveLoading: boolean read fbPaySuperOnLeaveLoading write fbPaySuperOnLeaveLoading;
    property SuperOnLeaveLoading: double read fdSuperOnLeaveLoading;
  end;

implementation
  
uses FastFuncs,SysUtils, DateUtils,  PayCommon, PayObj, CommonDbLib,
   AppEnvironment, CommonLib;

{ TAccruedLeavesObj }

constructor TLeaveTaken.Create(const Owner: TObject);
begin
  inherited Create;
  foOwner := Owner;
  fmtTotals := TkbmMemTable.Create(nil);
  SetupLeaveTakenMemTable;
end;

destructor TLeaveTaken.Destroy;
begin
  FreeAndNil(fmtTotals);
  inherited;
end;

procedure TLeaveTaken.Recalc;
var
  HoursTaken: double;
  bm: TBookmark;
  fdLineLeaveLoading: double;
begin
  if DatasetOk(TPayObj(Self.Owner).Leave.LeaveAccrued.TotalDS) then begin
    fmtTotals.EmptyTable;
    fdLeaveLoading        := 0;
    fdSuperOnLeaveLoading := 0;
    TPayObj(Self.Owner).Leave.LeaveAccrued.TotalDS.First;
    bm := TPayObj(Self.Owner).PayRates.DataSet.GetBookmark;
    
    try
      TPayObj(Self.Owner).PayRates.DataSet.DisableControls;
      while not TPayObj(Self.Owner).Leave.LeaveAccrued.TotalDS.Eof do begin
        if DatasetOk(TPayObj(Self.Owner).PayRates.DataSet) then begin
          with TPayObj(Self.Owner).PayRates.DataSet do begin
            if not Empty(TPayObj(Self.Owner).Leave.LeaveAccrued.TotalDS.FieldByName('Type').AsString) then begin
              FilterDataset(TPayObj(Self.Owner).PayRates.DataSet,
                GetBasedOnFilter(GetBasedOnID(FastFuncs.Trim(TPayObj(Self.Owner).Leave.LeaveAccrued.TotalDS.FieldByName('Type').AsString))));
              HoursTaken := SumField(TPayObj(Self.Owner).PayRates.DataSet, 'Qty');
              fmtTotals.Append;
              fmtTotals.FieldByName('LeaveTypeID').AsInteger := FieldByName('TypeID').AsInteger;
              fmtTotals.FieldByName('LeaveID').AsInteger := TPayObj(Self.Owner).Leave.LeaveTotals.GetLeaveID(TPayObj(Self.Owner).Leave.LeaveAccrued.TotalDS.FieldByName('Type').AsString);
              fmtTotals.FieldByName('Type').AsString := TPayObj(Self.Owner).Leave.LeaveAccrued.TotalDS.FieldByName('Type').AsString;
              fmtTotals.FieldByName('ClassID').AsInteger := FieldByName('ClassID').AsInteger;
              fmtTotals.FieldByName('HoursTaken').AsFloat := HoursTaken;
              fmtTotals.FieldByName('HourlyRate').AsFloat := DivZer(FieldByName('LineTotal').AsFloat, FieldByName('Qty').AsFloat);//TPayObj(Self.Owner).PayRates.HourlyRate;
              If (FindField('PaysPayRateID')<>nil) then
                fmtTotals.FieldByName('PayLineID').AsInteger := FieldByName('PaysPayRateID').AsInteger;
              fmtTotals.Post;

              //Calc This Pay's Leave Loading for annual leave
              if FindInSet(FastFuncs.Trim(fmtTotals.FieldByName('Type').AsString), 'Annual Leave') then begin
                fdLineLeaveLoading := (HoursTaken * TPayObj(Self.Owner).PayRates.HourlyRate *
                  TPayObj(Self.Owner).Employee.EmployeeSettings.LeaveLoading);
                fdLeaveLoading := fdLeaveLoading + fdLineLeaveLoading;
                if (TPayObj(Self.Owner).PayRates.DataSet.FindField('SuperInc') <> nil) then begin
                  if TPayObj(Self.Owner).PayRates.DataSet.FieldByName('SuperInc').AsString = 'T' then begin
                    fdSuperOnLeaveLoading := fdSuperOnLeaveLoading + fdLineLeaveLoading;
                  end;
                end else if (TPayObj(Self.Owner).PayRates.DataSet.FindField('Super') <> nil) then begin
                  if TPayObj(Self.Owner).PayRates.DataSet.FieldByName('Super').AsString = 'T' then begin
                    fdSuperOnLeaveLoading := fdSuperOnLeaveLoading + fdLineLeaveLoading;
                  end;
                end;
              end;
              //needs to handle all other leave loading here
              if not FindInSet(FastFuncs.Trim(fmtTotals.FieldByName('Type').AsString), 'Annual Leave') then begin
                fdLineLeaveLoading := (HoursTaken * TPayObj(Self.Owner).PayRates.HourlyRate *
                  GetLeaveLoading(fmtTotals.FieldByName('LeaveID').AsInteger));
                fdLeaveLoading := fdLeaveLoading + fdLineLeaveLoading;

                if (TPayObj(Self.Owner).PayRates.DataSet.FindField('SuperInc') <> nil) then begin
                  if TPayObj(Self.Owner).PayRates.DataSet.FieldByName('SuperInc').AsString = 'T' then begin
                    fdSuperOnLeaveLoading := fdSuperOnLeaveLoading + fdLineLeaveLoading;
                  end;
                end else if (TPayObj(Self.Owner).PayRates.DataSet.FindField('Super') <> nil) then begin
                  if TPayObj(Self.Owner).PayRates.DataSet.FieldByName('Super').AsString = 'T' then begin
                    fdSuperOnLeaveLoading := fdSuperOnLeaveLoading + fdLineLeaveLoading;
                  end;
                end;
              end;
            end;
          end;
        end;
        RemoveFilterDataset(TPayObj(Self.Owner).PayRates.DataSet);
        TPayObj(Self.Owner).Leave.LeaveAccrued.TotalDS.Next;
      end;
      TPayObj(Self.Owner).PayRates.DataSet.EnableControls;
      TPayObj(Self.Owner).PayRates.DataSet.GotoBookmark(bm);
    finally
      TPayObj(Self.Owner).PayRates.DataSet.FreeBookmark(bm);
    end;

    DatasetToEditMode(TPayObj(Self.Owner).PayRates.DataSet);
  end;
end;

function TLeaveTaken.GetLeaveLoading(TypeID: integer): double;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT LeaveID,LeaveLoading FROM tblleave WHERE LeaveID = ' + FastFuncs.IntToStr(TypeID));
    qry.Open;
    Result := qry.FieldByName('LeaveLoading').AsFloat / 100;
  finally
    FreeAndNil(qry);
  end;
end;

function TLeaveTaken.GetHrs(const LeaveID: integer): double;
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
            Result := Result + FieldByName('AccruedHours').AsFloat;
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

function TLeaveTaken.GetAmount(const LeaveID: integer): double;
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
            Result := Result + (FieldByName('HoursTaken').AsFloat * FieldByName('HourlyRate').AsFloat);
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

procedure TLeaveTaken.PostToAccounts;
var
  CreditAccID: integer;
  DebitAccID: integer;
begin
  if DatasetOk(fmtTotals) then begin
    with fmtTotals do begin
      DisableControls;
      First;
      while not Eof do begin
(*        DebitAccID := TPayObj(Self.Owner).PayPreferences.LeaveLiabilityAccountID;
        CreditAccID := TPayObj(Self.Owner).PayPreferences.LeaveProvisionAccountID;*)
        DebitAccID := AppEnv.PayPrefs.LeaveLiabilityAccountID;
        CreditAccID := AppEnv.PayPrefs.LeaveProvisionAccountID;
        PostToPaysTransactions('Payroll Leave Taken','Leave Taken', FieldByName('Type').AsString + ' Taken', TPayObj(Self.Owner),
          CreditAccID,
          DebitAccID,
          FieldByName('ClassID').AsInteger, FieldByName('PaylineID').AsInteger,
          FieldByName('HoursTaken').AsFloat * FieldByName('HourlyRate').AsFloat);
        Next;
      end;
      EnableControls;
    end;
  end;
end;

procedure TLeaveTaken.SetupLeaveTakenMemTable;
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
    Name     := 'HoursTaken';
    DataType := ftFloat;
  end;
  with fmtTotals.FieldDefs.AddFieldDef do begin
    Name     := 'HourlyRate';
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

function TLeaveTaken.NonTaxableLeaveLoading: double;
var
  TotalLeaveLoading: double;
begin
  TotalLeaveLoading := TPayObj(Self.Owner).Leave.LeaveTotals.YTDLeaveLoading + fdLeaveLoading;
  if TPayObj(Self.Owner).Leave.LeaveTotals.YTDLeaveLoading < AppEnv.CompanyPrefs.LeaveLoadTaxThreshold then begin
    if TotalLeaveLoading < AppEnv.CompanyPrefs.LeaveLoadTaxThreshold then begin
      Result := fdLeaveLoading;
    end else begin
      Result := TotalLeaveLoading - AppEnv.CompanyPrefs.LeaveLoadTaxThreshold;
    end;
  end else begin
    Result := 0.00;
  end;
end;

end.


