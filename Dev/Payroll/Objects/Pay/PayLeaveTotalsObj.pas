unit PayLeaveTotalsObj;

interface

uses
  Classes, DB, kbmMemTable, Dialogs;

type
  TLeaveTotals = class(TObject)
  private
    foOwner: TObject;
    TempFilterID: integer;
    TempFilterDate: TDateTime;
    fdYTDLeaveLoading: double;
    fmtTotals: TkbmMemTable;
    fmtAccruedTotals: TkbmMemTable;
    fmtTakenTotals: TkbmMemTable;
    fmtYTDTotals: TkbmMemTable;
    fmtYTDAccruedTotals: TkbmMemTable;
    fmtYTDTakenTotals: TkbmMemTable;

    procedure SetupTotalsMemTable;
    procedure SetupAccruedTotalsMemTable;
    procedure SetupTakenTotalsMemTable;
    procedure SetupYTDTotalsMemTable;
    procedure SetupYTDAccruedMemTable;
    procedure SetupYTDTakenMemTable;
    procedure MemTableFilterRecordLeaveID(DataSet: TDataSet; var Accept: boolean);
    procedure MemTableFilterRecordLeaveTypeID(DataSet: TDataSet; var Accept: boolean);
  public
    constructor Create(const Owner: TObject);
    destructor Destroy; override;
    procedure Recalc;
    procedure AddLeaveAccrued;
    procedure DeductLeaveTaken;
    function GetLeaveClassID(const LeaveID: integer): integer;
    function GetLeaveID(const LeaveType: string): integer;
    function GetHrs(const LeaveID: integer): double; overload;

    function GetAmount(const LeaveID: integer): double; overload;
    function GetHrs(const LeaveID: integer; const AsOfDate: TDateTime): double; overload;
    function GetAmount(const LeaveID: integer; const AsOfDate: TDateTime): double; overload;
    function GetTakenHrs(const LeaveID: integer; const AsOfDate: TDateTime): double;

    function GetYTDHrs(const LeaveTypeID: integer): double; overload;
    function GetYTDAmount(const LeaveTypeID: integer): double; overload;
    function GetYTDHrs(const LeaveTypeID: integer; const AsOfDate: TDateTime): double; overload;
    function GetYTDAmount(const LeaveTypeID: integer; const AsOfDate: TDateTime): double; overload;
    function GetOpeningBalanceHrs(const LeaveTypeID: integer): double;

    property Owner: TObject read foOwner;
    property YTDLeaveLoading: double read fdYTDLeaveLoading;
    property Totals: TkbmMemTable read fmtTotals;
    property AccruedTotals: TkbmMemTable read fmtAccruedTotals;
    property TakenTotals: TkbmMemTable read fmtTakenTotals;
    property YTDTotals: TkbmMemTable read fmtYTDTotals;
    property YTDAccruedTotals: TkbmMemTable read fmtYTDAccruedTotals;
    property YTDTakenTotals: TkbmMemTable read fmtYTDTakenTotals;

  end;

implementation
  
uses FastFuncs,SysUtils, DnMLib, PayCommon, PayObj, CommonDbLib, CommonLib;

{ TAccruedLeavesObj }

constructor TLeaveTotals.Create(const Owner: TObject);
begin
  inherited Create;
  foOwner := Owner;
  fmtTotals := TkbmMemTable.Create(nil);
  fmtAccruedTotals := TkbmMemTable.Create(nil);
  fmtTakenTotals := TkbmMemTable.Create(nil);
  fmtYTDTotals := TkbmMemTable.Create(nil);
  fmtYTDAccruedTotals := TkbmMemTable.Create(nil);
  fmtYTDTakenTotals := TkbmMemTable.Create(nil);
  SetupTotalsMemTable;
  SetupAccruedTotalsMemTable;
  SetupTakenTotalsMemTable;
  SetupYTDTotalsMemTable;
  SetupYTDAccruedMemTable;
  SetupYTDTakenMemTable;
end;

destructor TLeaveTotals.Destroy;
begin
  FreeAndNil(fmtTotals);
  FreeAndNil(fmtAccruedTotals);
  FreeAndNil(fmtTakenTotals);
  FreeAndNil(fmtYTDTotals);
  FreeAndNil(fmtYTDAccruedTotals);
  FreeAndNil(fmtYTDTakenTotals);
  inherited;
end;

procedure TLeaveTotals.SetupTotalsMemTable;
begin
  fmtTotals.Close;
  with fmtTotals.FieldDefs.AddFieldDef do begin
    Name     := 'AutoID';
    DataType := ftAutoInc;
  end;
  with fmtTotals.FieldDefs.AddFieldDef do begin
    Name     := 'Date';
    DataType := ftDateTime;
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
    Name     := 'AccruedHours';
    DataType := ftFloat;
  end;
  fmtTotals.CreateTable;
  fmtTotals.Open;
  fmtTotals.UpdateIndexes;
  fmtTotals.Emptytable;
end;

procedure TLeaveTotals.SetupAccruedTotalsMemTable;
begin
  fmtAccruedTotals.Close;
  with fmtAccruedTotals.FieldDefs.AddFieldDef do begin
    Name     := 'AutoID';
    DataType := ftAutoInc;
  end;
  with fmtAccruedTotals.FieldDefs.AddFieldDef do begin
    Name     := 'Date';
    DataType := ftDateTime;
  end;
  with fmtAccruedTotals.FieldDefs.AddFieldDef do begin
    Name     := 'LeaveID';
    DataType := ftInteger;
  end;
  with fmtAccruedTotals.FieldDefs.AddFieldDef do begin
    Name     := 'LeaveTypeID';
    DataType := ftInteger;
  end;
  with fmtAccruedTotals.FieldDefs.AddFieldDef do begin
    Name     := 'Type';
    DataType := ftString;
    Size     := 255;
  end;
  with fmtAccruedTotals.FieldDefs.AddFieldDef do begin
    Name     := 'ClassID';
    DataType := ftInteger;
  end;
  with fmtAccruedTotals.FieldDefs.AddFieldDef do begin
    Name     := 'AccruedHours';
    DataType := ftFloat;
  end;
  fmtAccruedTotals.CreateTable;
  fmtAccruedTotals.Open;
  fmtAccruedTotals.UpdateIndexes;
  fmtAccruedTotals.Emptytable;
end;

procedure TLeaveTotals.SetupTakenTotalsMemTable;
begin
  fmtTakenTotals.Close;
  with fmtTakenTotals.FieldDefs.AddFieldDef do begin
    Name     := 'AutoID';
    DataType := ftAutoInc;
  end;
  with fmtTakenTotals.FieldDefs.AddFieldDef do begin
    Name     := 'Date';
    DataType := ftDateTime;
  end;
  with fmtTakenTotals.FieldDefs.AddFieldDef do begin
    Name     := 'LeaveID';
    DataType := ftInteger;
  end;
  with fmtTakenTotals.FieldDefs.AddFieldDef do begin
    Name     := 'LeaveTypeID';
    DataType := ftInteger;
  end;
  with fmtTakenTotals.FieldDefs.AddFieldDef do begin
    Name     := 'Type';
    DataType := ftString;
    Size     := 255;
  end;
  with fmtTakenTotals.FieldDefs.AddFieldDef do begin
    Name     := 'ClassID';
    DataType := ftInteger;
  end;
  with fmtTakenTotals.FieldDefs.AddFieldDef do begin
    Name     := 'HoursTaken';
    DataType := ftFloat;
  end;
  with fmtTakenTotals.FieldDefs.AddFieldDef do begin
    Name     := 'HourlyRate';
    DataType := ftFloat;
  end;
  fmtTakenTotals.CreateTable;
  fmtTakenTotals.Open;
  fmtTakenTotals.UpdateIndexes;
  fmtTakenTotals.Emptytable;
end;

procedure TLeaveTotals.SetupYTDTotalsMemTable;
begin
  fmtYTDTotals.Close;
  with fmtYTDTotals.FieldDefs.AddFieldDef do begin
    Name     := 'AutoID';
    DataType := ftAutoInc;
  end;
  with fmtYTDTotals.FieldDefs.AddFieldDef do begin
    Name     := 'Date';
    DataType := ftDateTime;
  end;
  with fmtYTDTotals.FieldDefs.AddFieldDef do begin
    Name     := 'LeaveID';
    DataType := ftInteger;
  end;
  with fmtYTDTotals.FieldDefs.AddFieldDef do begin
    Name     := 'LeaveTypeID';
    DataType := ftInteger;
  end;
  with fmtYTDTotals.FieldDefs.AddFieldDef do begin
    Name     := 'Type';
    DataType := ftString;
    Size     := 255;
  end;
  with fmtYTDTotals.FieldDefs.AddFieldDef do begin
    Name     := 'ClassID';
    DataType := ftInteger;
  end;
  with fmtYTDTotals.FieldDefs.AddFieldDef do begin
    Name     := 'AccruedHours';
    DataType := ftFloat;
  end;

  fmtYTDTotals.CreateTable;
  fmtYTDTotals.Open;
  fmtYTDTotals.UpdateIndexes;
  fmtYTDTotals.Emptytable;
end;

procedure TLeaveTotals.SetupYTDAccruedMemTable;
begin
  fmtYTDAccruedTotals.Close;
  with fmtYTDAccruedTotals.FieldDefs.AddFieldDef do begin
    Name     := 'AutoID';
    DataType := ftAutoInc;
  end;
  with fmtYTDAccruedTotals.FieldDefs.AddFieldDef do begin
    Name     := 'Date';
    DataType := ftDateTime;
  end;
  with fmtYTDAccruedTotals.FieldDefs.AddFieldDef do begin
    Name     := 'LeaveID';
    DataType := ftInteger;
  end;
  with fmtYTDAccruedTotals.FieldDefs.AddFieldDef do begin
    Name     := 'LeaveTypeID';
    DataType := ftInteger;
  end;
  with fmtYTDAccruedTotals.FieldDefs.AddFieldDef do begin
    Name     := 'Type';
    DataType := ftString;
    Size     := 255;
  end;
  with fmtYTDAccruedTotals.FieldDefs.AddFieldDef do begin
    Name     := 'ClassID';
    DataType := ftInteger;
  end;
  with fmtYTDAccruedTotals.FieldDefs.AddFieldDef do begin
    Name     := 'AccruedHours';
    DataType := ftFloat;
  end;
  fmtYTDAccruedTotals.CreateTable;
  fmtYTDAccruedTotals.Open;
  fmtYTDAccruedTotals.UpdateIndexes;
  fmtYTDAccruedTotals.Emptytable;
end;

procedure TLeaveTotals.SetupYTDTakenMemTable;
begin
  fmtYTDTakenTotals.Close;
  with fmtYTDTakenTotals.FieldDefs.AddFieldDef do begin
    Name     := 'AutoID';
    DataType := ftAutoInc;
  end;
  with fmtYTDTakenTotals.FieldDefs.AddFieldDef do begin
    Name     := 'Date';
    DataType := ftDateTime;
  end;
  with fmtYTDTakenTotals.FieldDefs.AddFieldDef do begin
    Name     := 'LeaveID';
    DataType := ftInteger;
  end;
  with fmtYTDTakenTotals.FieldDefs.AddFieldDef do begin
    Name     := 'LeaveTypeID';
    DataType := ftInteger;
  end;
  with fmtYTDTakenTotals.FieldDefs.AddFieldDef do begin
    Name     := 'Type';
    DataType := ftString;
    Size     := 255;
  end;
  with fmtYTDTakenTotals.FieldDefs.AddFieldDef do begin
    Name     := 'ClassID';
    DataType := ftInteger;
  end;
  with fmtYTDTakenTotals.FieldDefs.AddFieldDef do begin
    Name     := 'HoursTaken';
    DataType := ftFloat;
  end;
  with fmtYTDTakenTotals.FieldDefs.AddFieldDef do begin
    Name     := 'HourlyRate';
    DataType := ftFloat;
  end;
  fmtYTDTakenTotals.CreateTable;
  fmtYTDTakenTotals.Open;
  fmtYTDTakenTotals.UpdateIndexes;
  fmtYTDTakenTotals.Emptytable;
end;

procedure TLeaveTotals.Recalc;
var
  DSLeaveHistory: TDataset;
begin
  //####################################
  {ALL LEAVE DATASETS}
  //First add the opening totals
  DSLeaveHistory := RetrieveDataset('tblleave', 'EmployeeID=' + FastFuncs.IntToStr(TPayObj(Self.Owner).Employee.EmployeeID));
  try
    {ALL LEAVE Totals}
    with DSLeaveHistory do begin
      fmtTotals.EmptyTable;
      fmtYTDTotals.EmptyTable;
      fmtYTDAccruedTotals.EmptyTable;

      RemoveFilterDataset(DSLeaveHistory); //No Filter
      First;
      while not Eof do begin
        if not Empty(FieldByName('Type').AsString) then begin
          {Totals OpenningBalance}
          fmtTotals.Append;
          fmtTotals.FieldByName('LeaveTypeID').AsInteger := FieldByName('TypeID').AsInteger;
          fmtTotals.FieldByName('LeaveID').AsInteger := GetLeaveID(FieldByName('Type').AsString);
          fmtTotals.FieldByName('Type').AsString := FieldByName('Type').AsString;
          fmtTotals.FieldByName('ClassID').AsInteger := GetLeaveClassID(fmtTotals.FieldByName('LeaveID').AsInteger);
          fmtTotals.FieldByName('AccruedHours').AsFloat :=   FieldByName('OpenningBalanceHrs').AsFloat; // + FieldByName('AccruedHours').AsFloat
          fmtTotals.FieldByName('Date').AsDateTime := FieldByName('AccruedDate').AsDateTime;  //FieldByName('OpenningBalanceDate').AsDateTime;
          fmtTotals.Post;
          {YTD Totals OpenningBalance}
          fmtYTDTotals.Append;
          fmtYTDTotals.FieldByName('LeaveTypeID').AsInteger := FieldByName('TypeID').AsInteger;
          fmtYTDTotals.FieldByName('LeaveID').AsInteger := GetLeaveID(FieldByName('Type').AsString);
          fmtYTDTotals.FieldByName('Type').AsString := FieldByName('Type').AsString;
          fmtYTDTotals.FieldByName('ClassID').AsInteger := GetLeaveClassID(fmtTotals.FieldByName('LeaveID').AsInteger);
          fmtYTDTotals.FieldByName('AccruedHours').AsFloat := FieldByName('OpenningBalanceHrs').AsFloat;
          fmtYTDTotals.FieldByName('Date').AsDateTime := FieldByName('OpenningBalanceDate').AsDateTime;
          fmtYTDTotals.Post;
          {YTDAccruedTotals  OpenningBalance}
          fmtYTDAccruedTotals.Append;
          fmtYTDAccruedTotals.FieldByName('LeaveTypeID').AsInteger := FieldByName('TypeID').AsInteger;
          fmtYTDAccruedTotals.FieldByName('LeaveID').AsInteger := GetLeaveID(FieldByName('Type').AsString);
          fmtYTDAccruedTotals.FieldByName('Type').AsString := FieldByName('Type').AsString;
          fmtYTDAccruedTotals.FieldByName('ClassID').AsInteger := GetLeaveClassID(fmtTotals.FieldByName('LeaveID').AsInteger);
          fmtYTDAccruedTotals.FieldByName('AccruedHours').AsFloat := FieldByName('OpenningBalanceHrs').AsFloat;
          fmtYTDAccruedTotals.FieldByName('Date').AsDateTime := FieldByName('OpenningBalanceDate').AsDateTime;
          fmtYTDAccruedTotals.Post;
        end;
        Next;
      end;
    end;
    RemoveFilterDataset(DSLeaveHistory);

    DSLeaveHistory := RetrieveDataset('tblleaveaccruals', 'EmployeeID=' + FastFuncs.IntToStr(TPayObj(Self.Owner).Employee.EmployeeID));
    //  try
    {ALL LEAVE Totals}
    with DSLeaveHistory do begin
     // fmtTotals.EmptyTable;
      RemoveFilterDataset(DSLeaveHistory); //No Filter
      First;
      while not Eof do begin
        if not Empty(FieldByName('LeaveType').AsString) then begin
          fmtTotals.Append;
          fmtTotals.FieldByName('LeaveTypeID').AsInteger := FieldByName('LeaveTypeID').AsInteger;
          fmtTotals.FieldByName('LeaveID').AsInteger := GetLeaveID(FieldByName('LeaveType').AsString);
          fmtTotals.FieldByName('Type').AsString := FieldByName('LeaveType').AsString;
          fmtTotals.FieldByName('ClassID').AsInteger := GetLeaveClassID(fmtTotals.FieldByName('LeaveID').AsInteger);
          fmtTotals.FieldByName('AccruedHours').AsFloat := FieldByName('AccruedHours').AsFloat;
          fmtTotals.FieldByName('Date').AsDateTime := FieldByName('Date').AsDateTime;
          fmtTotals.Post;
        end;
        Next;
      end;
    end;
    RemoveFilterDataset(DSLeaveHistory);
    {ALL LEAVE Accrued}
    with DSLeaveHistory do begin
      fmtAccruedTotals.EmptyTable;
      FilterDataset(DSLeaveHistory, 'AccrualType=' + QuotedStr('Accrued'));
      First;
      while not Eof do begin
        if not Empty(FieldByName('LeaveType').AsString) then begin
          fmtAccruedTotals.Append;
          fmtAccruedTotals.FieldByName('LeaveTypeID').AsInteger := FieldByName('LeaveTypeID').AsInteger;
          fmtAccruedTotals.FieldByName('LeaveID').AsInteger := GetLeaveID(FieldByName('LeaveType').AsString);
          fmtAccruedTotals.FieldByName('Type').AsString := FieldByName('LeaveType').AsString;
          fmtAccruedTotals.FieldByName('ClassID').AsInteger :=
            GetLeaveClassID(fmtAccruedTotals.FieldByName('LeaveID').AsInteger);
          fmtAccruedTotals.FieldByName('AccruedHours').AsFloat := FieldByName('AccruedHours').AsFloat;
          fmtAccruedTotals.FieldByName('Date').AsDateTime := FieldByName('Date').AsDateTime;
          fmtAccruedTotals.Post;
        end;
        Next;
      end;
    end;
    RemoveFilterDataset(DSLeaveHistory);
    {ALL LEAVE Taken}
    with DSLeaveHistory do begin
      fmtTakenTotals.EmptyTable;
      FilterDataset(DSLeaveHistory, 'AccrualType=' + QuotedStr('Leave Taken'));
      First;
      while not Eof do begin
        if not Empty(FieldByName('LeaveType').AsString) then begin
          fmtTakenTotals.Append;
          fmtTakenTotals.FieldByName('LeaveTypeID').AsInteger := FieldByName('LeaveTypeID').AsInteger;
          fmtTakenTotals.FieldByName('LeaveID').AsInteger := GetLeaveID(FieldByName('LeaveType').AsString);
          fmtTakenTotals.FieldByName('Type').AsString := FieldByName('LeaveType').AsString;
          fmtTakenTotals.FieldByName('ClassID').AsInteger := GetLeaveClassID(fmtTakenTotals.FieldByName('LeaveID').AsInteger);
          fmtTakenTotals.FieldByName('HoursTaken').AsFloat := -FieldByName('AccruedHours').AsFloat;
          fmtTakenTotals.FieldByName('HourlyRate').AsFloat := FieldByName('CurrentHourlyRate').AsFloat;
          fmtTakenTotals.FieldByName('Date').AsDateTime := FieldByName('Date').AsDateTime;
          fmtTakenTotals.Post;
        end;
        Next;
      end;
    end;
    RemoveFilterDataset(DSLeaveHistory);
  finally
    FreeAndNil(DSLeaveHistory);
  end;
  //####################################
  {YTD DATASETS}
  DSLeaveHistory := RetrieveDataset('tblleaveaccruals', 'EmployeeID=' +
    FastFuncs.IntToStr(TPayObj(Self.Owner).Employee.EmployeeID) + ' AND Date >= ' +
    QuotedStr(FormatDateTime('yyyy-mm-dd', GetCurrentFiscalYearStart)));
  try
    {YTD Totals}
    with DSLeaveHistory do begin
      //fmtYTDTotals.EmptyTable;
      RemoveFilterDataset(DSLeaveHistory); //No Filter
      First;
      while not Eof do begin
        if not Empty(FieldByName('LeaveType').AsString) then begin
          fmtYTDTotals.Append;
          fmtYTDTotals.FieldByName('LeaveTypeID').AsInteger := FieldByName('LeaveTypeID').AsInteger;
          fmtYTDTotals.FieldByName('LeaveID').AsInteger := GetLeaveID(FieldByName('LeaveType').AsString);
          fmtYTDTotals.FieldByName('Type').AsString := FieldByName('LeaveType').AsString;
          fmtYTDTotals.FieldByName('ClassID').AsInteger := GetLeaveClassID(fmtYTDTotals.FieldByName('LeaveID').AsInteger);
          fmtYTDTotals.FieldByName('AccruedHours').AsFloat := FieldByName('AccruedHours').AsFloat;
          fmtYTDTotals.FieldByName('Date').AsDateTime := FieldByName('Date').AsDateTime;
          fmtYTDTotals.Post;
        end;
        Next;
      end;
    end;
    RemoveFilterDataset(DSLeaveHistory);
    {YTD Accrued}
    with DSLeaveHistory do begin
    //  fmtYTDAccruedTotals.EmptyTable;
      FilterDataset(DSLeaveHistory, 'AccrualType=' + QuotedStr('Accrued'));
      First;
      while not Eof do begin
        if not Empty(FieldByName('LeaveType').AsString) then begin
          fmtYTDAccruedTotals.Append;
          fmtYTDAccruedTotals.FieldByName('LeaveTypeID').AsInteger := FieldByName('LeaveTypeID').AsInteger;
          fmtYTDAccruedTotals.FieldByName('LeaveID').AsInteger := GetLeaveID(FieldByName('LeaveType').AsString);
          fmtYTDAccruedTotals.FieldByName('Type').AsString := FieldByName('LeaveType').AsString;
          fmtYTDAccruedTotals.FieldByName('ClassID').AsInteger := GetLeaveClassID(fmtYTDAccruedTotals.FieldByName('LeaveID').AsInteger);
          fmtYTDAccruedTotals.FieldByName('AccruedHours').AsFloat := FieldByName('AccruedHours').AsFloat;
          fmtYTDAccruedTotals.FieldByName('Date').AsDateTime := FieldByName('Date').AsDateTime;
          fmtYTDAccruedTotals.Post;
        end;
        Next;

      end;
    end;
    RemoveFilterDataset(DSLeaveHistory);
    {YTD Taken}
    with DSLeaveHistory do begin
      fdYTDLeaveLoading := 0;
      fmtYTDTakenTotals.EmptyTable;
      FilterDataset(DSLeaveHistory, 'PayID<>'+FastFuncs.IntToStr(TPayObj(Self.Owner).PayID)+' AND AccrualType=' + QuotedStr('Leave Taken'));
      First;
      while not Eof do begin
        if not Empty(FieldByName('LeaveType').AsString) then begin
          fmtYTDTakenTotals.Append;
          fmtYTDTakenTotals.FieldByName('LeaveTypeID').AsInteger := FieldByName('LeaveTypeID').AsInteger;
          fmtYTDTakenTotals.FieldByName('LeaveID').AsInteger := GetLeaveID(FieldByName('LeaveType').AsString);
          fmtYTDTakenTotals.FieldByName('Type').AsString := FieldByName('LeaveType').AsString;
          fmtYTDTakenTotals.FieldByName('ClassID').AsInteger := GetLeaveClassID(fmtYTDAccruedTotals.FieldByName('LeaveID').AsInteger);
          fmtYTDTakenTotals.FieldByName('HoursTaken').AsFloat := -FieldByName('AccruedHours').AsFloat;
          fmtYTDTakenTotals.FieldByName('HourlyRate').AsFloat := FieldByName('CurrentHourlyRate').AsFloat;
          fmtYTDTakenTotals.FieldByName('Date').AsDateTime := FieldByName('Date').AsDateTime;
          fmtYTDTakenTotals.Post;
          //Calc YTD Leave Loading
          if FindInSet(FastFuncs.Trim(FieldByName('LeaveType').AsString), 'Annual Leave') then begin
            fdYTDLeaveLoading := fdYTDLeaveLoading + (fmtYTDTakenTotals.FieldByName('HoursTaken').AsFloat *
              fmtYTDTakenTotals.FieldByName('HourlyRate').AsFloat * TPayObj(Self.Owner).Employee.EmployeeSettings.LeaveLoading);
          end;
        end;
        Next;
      end;
    end;
    RemoveFilterDataset(DSLeaveHistory);
  finally
    FreeAndNil(DSLeaveHistory);
  end;

  //####################################
end;

procedure TLeaveTotals.AddLeaveAccrued;
var
  bm: TBookmark;
begin
  if TPayObj(Self.Owner).PayRates.HasTerminationRecord then Exit;
  if TPayObj(Self.Owner).Employee.EmployeeDetails.IsTerminated then Exit;
  if DatasetOk(TPayObj(Self.Owner).Leave.LeaveAccrued.DataSet) then begin
    with TPayObj(Self.Owner).Leave.LeaveAccrued.DataSet do begin
      bm := GetBookmark;
      DisableControls;
      if (FindField('LeaveID') <> nil) then begin
        TPayObj(Self.Owner).Leave.LeaveAccrued.TotalDS.First;
        while not TPayObj(Self.Owner).Leave.LeaveAccrued.TotalDS.Eof do begin
          FilterDataset(TPayObj(Self.Owner).Leave.LeaveAccrued.DataSet,
            '[LeaveID]=' + FastFuncs.IntToStr(TPayObj(Self.Owner).Leave.LeaveAccrued.TotalDS.FieldByName('LeaveID').AsInteger));
          if (RecordCount = 1) then begin
            Edit;
            if (FindField('AccruedHours') <> nil) then begin
              FieldByName('AccruedHours').AsFloat := FieldByName('AccruedHours').AsFloat +
                TPayObj(Self.Owner).Leave.LeaveAccrued.TotalDS.FieldByName('AccrueHours').AsFloat;
            end;
            if (FindField('AccruedDate') <> nil) then begin
              FieldByName('AccruedDate').AsDateTime := TPayObj(Self.Owner).PayDate;
            end;
            Post;
            AddAccruedHoursAdjustmentToDB(TPayObj(Self.Owner), 'Accrued', FieldByName('Type').AsString,
              TPayObj(Self.Owner).Leave.LeaveAccrued.TotalDS.FieldByName('AccrueHours').AsFloat, TPayObj(Self.Owner).PayRates.HourlyRate,
              TPayObj(Self.Owner).Leave.LeaveAccrued.TotalDS.FieldByName('PayLineID').AsInteger);
          end;
          RemoveFilterDataset(TPayObj(Self.Owner).Leave.LeaveAccrued.DataSet);
          TPayObj(Self.Owner).Leave.LeaveAccrued.TotalDS.Next;
        end;
      end;
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
    end;
  end;
end;

procedure TLeaveTotals.DeductLeaveTaken;
var
  bm: TBookmark;
begin
  if DatasetOk(TPayObj(Self.Owner).Leave.LeaveAccrued.DataSet) then begin
    with TPayObj(Self.Owner).Leave.LeaveAccrued.DataSet do begin
      bm := GetBookmark;
      DisableControls;
      if (FindField('LeaveID') <> nil) then begin
        TPayObj(Self.Owner).Leave.LeaveTaken.TotalDS.First;
        while not TPayObj(Self.Owner).Leave.LeaveTaken.TotalDS.Eof do begin
          FilterDataset(TPayObj(Self.Owner).Leave.LeaveAccrued.DataSet,
            '[LeaveID]=' + FastFuncs.IntToStr(TPayObj(Self.Owner).Leave.LeaveTaken.TotalDS.FieldByName('LeaveID').AsInteger));
          if (RecordCount = 1) then begin
            Edit;
            if (FindField('AccruedHours') <> nil) then begin
              FieldByName('AccruedHours').AsFloat := FieldByName('AccruedHours').AsFloat -
                TPayObj(Self.Owner).Leave.LeaveTaken.TotalDS.FieldByName('HoursTaken').AsFloat;
            end;
            Post;
            AddAccruedHoursAdjustmentToDB(TPayObj(Self.Owner), 'Leave Taken', FieldByName('Type').AsString,
              - TPayObj(Self.Owner).Leave.LeaveTaken.TotalDS.FieldByName('HoursTaken').AsFloat, TPayObj(Self.Owner).PayRates.HourlyRate,
                TPayObj(Self.Owner).Leave.LeaveTaken.TotalDS.FieldByName('PayLineID').AsInteger);
          end;
          RemoveFilterDataset(TPayObj(Self.Owner).Leave.LeaveAccrued.DataSet);
          TPayObj(Self.Owner).Leave.LeaveTaken.TotalDS.Next;
        end;
      end;
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
    end;
  end;
end;

function TLeaveTotals.GetLeaveID(const LeaveType: string): integer;
var
  bm: TBookmark;
begin
  Result := 0;
  if DatasetOk(TPayObj(Self.Owner).Leave.LeaveAccrued.DataSet) then begin
    with TPayObj(Self.Owner).Leave.LeaveAccrued.DataSet do begin
      bm := GetBookmark;
      DisableControls;
      if (TPayObj(Self.Owner).Leave.LeaveAccrued.DataSet.FindField('Type') <> nil) then begin
        FilterDataset(TPayObj(Self.Owner).Leave.LeaveAccrued.DataSet, '[Type]=' + QuotedStr(LeaveType));
        if (RecordCount <> 0) then begin
          Result := FieldByName('LeaveID').AsInteger;
        end;
        RemoveFilterDataset(TPayObj(Self.Owner).Leave.LeaveAccrued.DataSet);
      end;
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
    end;
  end;
end;

function TLeaveTotals.GetLeaveClassID(const LeaveID: integer): integer;
var
  bm: TBookmark;
begin
  Result := 0;
  if DatasetOk(TPayObj(Self.Owner).Leave.LeaveAccrued.DataSet) then begin
    with TPayObj(Self.Owner).Leave.LeaveAccrued.DataSet do begin
      bm := GetBookmark;
      DisableControls;
      if (TPayObj(Self.Owner).Leave.LeaveAccrued.DataSet.FindField('LeaveID') <> nil) then begin
        FilterDataset(TPayObj(Self.Owner).Leave.LeaveAccrued.DataSet, '[LeaveID]=' + FastFuncs.IntToStr(LeaveID));
        if (RecordCount > 0) then begin
          Result := FieldByName('ClassID').AsInteger;
        end;
        RemoveFilterDataset(TPayObj(Self.Owner).Leave.LeaveAccrued.DataSet);
      end;
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
    end;
  end;
end;

function TLeaveTotals.GetAmount(const LeaveID: integer): double;
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
            Result := Result + FieldByName('AccruedHours').AsFloat * TPayObj(Self.Owner).PayRates.HourlyRate;
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

function TLeaveTotals.GetAmount(const LeaveID: integer; const AsOfDate: TDateTime): double;
var
  bm: TBookmark;
begin
  Result := 0;
  if DatasetOk(fmtTotals) then begin
    with fmtTotals do begin
      bm := GetBookmark;
      DisableControls;
      if (fmtTotals.FindField('LeaveID') <> nil) then begin
        TempFilterID := LeaveID;
        TempFilterDate := AsOfDate;
        fmtTotals.OnFilterRecord := MemTableFilterRecordLeaveID;
        fmtTotals.Filtered := true;
        if (RecordCount > 0) then begin
          First;
          while not Eof do begin
            Result := Result + FieldByName('AccruedHours').AsFloat * TPayObj(Self.Owner).PayRates.HourlyRate;
            Next;
          end;
        end;
        RemoveFilterDataset(fmtTotals);
        fmtTotals.OnFilterRecord := nil;        
      end;
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
    end;
  end;
end;

procedure TLeaveTotals.MemTableFilterRecordLeaveTypeID(DataSet: TDataSet; var Accept: boolean);
begin
  Accept := (DataSet.FieldByName('LeaveTypeID').AsInteger = TempFilterID) and
    (DataSet.FieldByName('Date').AsDateTime <= TempFilterDate);
end;


procedure TLeaveTotals.MemTableFilterRecordLeaveID(DataSet: TDataSet; var Accept: boolean);
begin
  Accept := (DataSet.FieldByName('LeaveID').AsInteger = TempFilterID) and
    (DataSet.FieldByName('Date').AsDateTime <= TempFilterDate);
end;

function TLeaveTotals.GetHrs(const LeaveID: integer; const AsOfDate: TDateTime): double;
var
  bm: TBookmark;
begin
  Result := 0;
  if DatasetOk(fmtTotals) then begin
    with fmtTotals do begin
      bm := GetBookmark;
      DisableControls;
      if (fmtTotals.FindField('LeaveID') <> nil) then begin
        TempFilterID := LeaveID;
        TempFilterDate := AsOfDate;
        fmtTotals.OnFilterRecord := MemTableFilterRecordLeaveID;
        fmtTotals.Filtered := true;
        if (RecordCount > 0) then begin
          First;
          while not Eof do begin
            Result := Result + FieldByName('AccruedHours').AsFloat;
            Next;
          end;
        end;
        RemoveFilterDataset(fmtTotals);
        fmtTotals.OnFilterRecord := nil;
      end;
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
    end;
  end;
end;

function TLeaveTotals.GetHrs(const LeaveID: integer): double;
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

function TLeaveTotals.GetYTDAmount(const LeaveTypeID: integer): double;
var
  bm: TBookmark;
begin
  Result := 0;
  if DatasetOk(fmtYTDTotals) then begin
    with fmtYTDTotals do begin
      bm := GetBookmark;
      DisableControls;
      if (fmtYTDTotals.FindField('LeaveTypeID') <> nil) then begin
        FilterDataset(fmtYTDTotals, '[LeaveTypeID]=' + FastFuncs.IntToStr(LeaveTypeID));
        if (RecordCount > 0) then begin
          First;
          while not Eof do begin
            Result := Result + (FieldByName('AccruedHours').AsFloat * TPayObj(Self.Owner).PayRates.HourlyRate)
                      +  (FieldByName('OpenningBalanceHrs').AsFloat * TPayObj(Self.Owner).PayRates.HourlyRate);

            Next;
          end;
        end;
        RemoveFilterDataset(fmtYTDTotals);
      end;
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
    end;
  end;
end;

function TLeaveTotals.GetYTDHrs(const LeaveTypeID: integer): double;
var
  bm: TBookmark;
begin
  Result := 0;
  if DatasetOk(fmtTotals) then begin
    with fmtTotals do begin
      bm := GetBookmark;
      DisableControls;
      if (fmtTotals.FindField('LeaveTypeID') <> nil) then begin
        FilterDataset(fmtTotals, '[LeaveTypeID]=' + FastFuncs.IntToStr(LeaveTypeID));
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


function TLeaveTotals.GetTakenHrs(const LeaveID: integer; const AsOfDate: TDateTime): double;
var
  bm: TBookmark;
begin
  Result := 0;
  if DatasetOk(fmtTakenTotals) then begin
    with fmtTakenTotals do begin
      bm := GetBookmark;
      DisableControls;
      if (fmtTakenTotals.FindField('LeaveID') <> nil) then begin
        TempFilterID := LeaveID;
        TempFilterDate := AsOfDate;
        fmtTakenTotals.OnFilterRecord := MemTableFilterRecordLeaveID;
        fmtTakenTotals.Filtered := true;
        if (RecordCount > 0) then begin
          First;
          while not Eof do begin
            Result := Result + FieldByName('HoursTaken').AsFloat;
            Next;
          end;
        end;
        RemoveFilterDataset(fmtTakenTotals);
        fmtTakenTotals.OnFilterRecord := nil;
      end;
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
    end;
  end;
end;

function TLeaveTotals.GetYTDAmount(const LeaveTypeID: integer; const AsOfDate: TDateTime): double;
var
  bm: TBookmark;
begin
  Result := 0;
  if DatasetOk(fmtTotals) then begin
    with fmtTotals do begin
      bm := GetBookmark;
      DisableControls;
      if (fmtTotals.FindField('LeaveTypeID') <> nil) then begin
        TempFilterID := LeaveTypeID;
        TempFilterDate := AsOfDate;
        fmtTotals.OnFilterRecord := MemTableFilterRecordLeaveTypeID;
        fmtTotals.Filtered := true;
        if (RecordCount > 0) then begin
          First;
          while not Eof do begin
            Result := Result + FieldByName('AccruedHours').AsFloat * TPayObj(Self.Owner).PayRates.HourlyRate;
            Next;
          end;
        end;
        RemoveFilterDataset(fmtTotals);
        fmtTotals.OnFilterRecord := nil;
      end;
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
    end;
  end;
end;

function TLeaveTotals.GetYTDHrs(const LeaveTypeID: integer; const AsOfDate: TDateTime): double;
var
  bm: TBookmark;
begin
  Result := 0;
  if DatasetOk(fmtYTDAccruedTotals) then begin
    with fmtYTDAccruedTotals do begin
      bm := GetBookmark;
      DisableControls;
      if (fmtYTDAccruedTotals.FindField('LeaveTypeID') <> nil) then begin
        TempFilterID := LeaveTypeID;
        TempFilterDate := AsOfDate;
        fmtYTDAccruedTotals.OnFilterRecord := MemTableFilterRecordLeaveTypeID;
        fmtYTDAccruedTotals.Filtered := true;
        if (RecordCount > 0) then begin
          First;
          while not Eof do begin
            Result := Result + FieldByName('AccruedHours').AsFloat;
            Next;
          end;
        end;
        RemoveFilterDataset(fmtYTDAccruedTotals);
        fmtTotals.OnFilterRecord := nil;
      end;
      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
    end;
  end;
end;

  //function TLeaveTotals.GetYTDHrs(const LeaveTypeID: integer; const AsOfDate: TDateTime): double;
//var
//  bm: TBookmark;
//begin
//  Result := 0;
//  if DatasetOk(fmtTotals) then begin
//    with fmtTotals do begin
//      bm := GetBookmark;
//      DisableControls;
//      if (fmtTotals.FindField('LeaveTypeID') <> nil) then begin
//        TempFilterID := LeaveTypeID;
//        TempFilterDate := AsOfDate;
//        fmtTotals.OnFilterRecord := MemTableFilterRecordLeaveTypeID;
//        fmtTotals.Filtered := true;
//        if (RecordCount > 0) then begin
//          First;
//          while not Eof do begin
//            Result := Result + FieldByName('AccruedHours').AsFloat;
//            Next;
//          end;
//        end;
//        RemoveFilterDataset(fmtTotals);
//        fmtTotals.OnFilterRecord := nil;
//      end;
//      EnableControls;
//      GotoBookmark(bm);
//      FreeBookmark(bm);
//    end;
//  end;
//end;

function TLeaveTotals.GetOpeningBalanceHrs(const LeaveTypeID: integer): double;
var
  bm: TBookmark;
  DSOpeningBalanceHrs: TDataSet;
  fmtOpening: TkbmMemTable;
  procedure SetupOpeningMemTable;
  begin
    fmtOpening := TkbmMemTable.Create(nil);
    fmtOpening.Close;
    with fmtOpening.FieldDefs.AddFieldDef do begin
      Name     := 'AutoID';
      DataType := ftAutoInc;
    end;
    with fmtOpening.FieldDefs.AddFieldDef do begin
      Name     := 'Date';
      DataType := ftDateTime;
    end;
    with fmtOpening.FieldDefs.AddFieldDef do begin
      Name     := 'LeaveID';
      DataType := ftInteger;
    end;
    with fmtOpening.FieldDefs.AddFieldDef do begin
      Name     := 'LeaveTypeID';
      DataType := ftInteger;
    end;
    with fmtOpening.FieldDefs.AddFieldDef do begin
      Name     := 'Type';
      DataType := ftString;
      Size     := 255;
    end;
    with fmtOpening.FieldDefs.AddFieldDef do begin
      Name     := 'ClassID';
      DataType := ftInteger;
    end;
    with fmtOpening.FieldDefs.AddFieldDef do begin
      Name     := 'AccruedHours';
      DataType := ftFloat;
    end;
    fmtOpening.CreateTable;
    fmtOpening.Open;
    fmtOpening.UpdateIndexes;
    fmtOpening.Emptytable;
  end;


begin
  Result := 0;
  SetupOpeningMemTable;
  DSOpeningBalanceHrs := RetrieveDataset('tblleave', 'EmployeeID=' + FastFuncs.IntToStr(TPayObj(Self.Owner).Employee.EmployeeID));
  fmtOpening.EmptyTable;
  RemoveFilterDataset(DSOpeningBalanceHrs); //No Filter
  with DSOpeningBalanceHrs do begin
    First;
    while not Eof do begin
      if not Empty(FieldByName('Type').AsString) then begin
        fmtOpening.Append;
        fmtOpening.FieldByName('LeaveTypeID').AsInteger := GetLeaveTypeID(FieldByName('Type').AsString);
        fmtOpening.FieldByName('LeaveID').AsInteger := GetLeaveID(FieldByName('Type').AsString);
        fmtOpening.FieldByName('Type').AsString := FieldByName('Type').AsString;
        fmtOpening.FieldByName('ClassID').AsInteger := GetLeaveClassID(fmtOpening.FieldByName('LeaveID').AsInteger);
        fmtOpening.FieldByName('AccruedHours').AsFloat := FieldByName('OpenningBalanceHrs').AsFloat;
        fmtOpening.FieldByName('Date').AsDateTime := FieldByName('OpenningBalanceDate').AsDateTime;
        fmtOpening.Post;
      end;
      Next;
    end;
  end;

  if DatasetOk(fmtOpening) then begin
    with fmtOpening do begin
      bm := GetBookmark;
      DisableControls;
      if (fmtOpening.FindField('LeaveTypeID') <> nil) then begin
        FilterDataset(fmtOpening, '[LeaveTypeID]=' + FastFuncs.IntToStr(LeaveTypeID));
        if (RecordCount > 0) then begin
          First;
          while not Eof do begin
            Result := Result + FieldByName('AccruedHours').AsFloat;
            Next;
          end;
        end;
        RemoveFilterDataset(fmtOpening);
      end;

      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
    end;
  end;

end;

end.
