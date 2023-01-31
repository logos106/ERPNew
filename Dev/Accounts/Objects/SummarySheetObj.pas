unit SummarySheetObj;

interface

uses classes,ERPdbComponents , kbmMemTable, Grids, db, DBSharedObjectsObj;

const
  rowText: array[1..8] of string =
    ('Cash in Bank', 'Accounts Receivable', 'Accounts Payable', 'Balance Sheet',
    'Sales', 'Cost of Goods', 'Expenses', 'Profit & Loss');
  acct: array[1..8] of string =
    ('BANK'{,CCARD'}, 'AR', 'AP', 'AR,BANK,OCASSET,OASSET,FIXASSET',
    'INC,EXINC', 'COGS', 'EXP,EXEXP', 'INC,EXINC,COGS,EXP,EXEXP');

type
  TSummarySheetParamObj = class(TComponent)
  Private
    fdReportdate: TDatetime;
    fdCustomRangeFrom: TDatetime;
    procedure SetReportdate(const Value: TDatetime);
    procedure SetCustomRangeFrom(const Value: TDatetime);
    procedure InitIt;
    function getTransQrySQL: String;
  Public
    days: array[1..6] of integer ;
    colText: array[1..6] of string ;
    constructor Create(AOwner :TComponent);override;
    Property Reportdate:TDatetime read fdReportdate write SetReportdate;
    Property CustomRangeFrom:TDatetime read fdCustomRangeFrom write SetCustomRangeFrom;
    Property TransQrySQL:String read getTransQrySQL;
  end;

  TSummarySheetObj = class(TComponent)
  Private
    fdDateTo: TDateTime;
    fConnection: TERPConnection;
    fqryTransactions: TERPQuery;
    fMemTable: TkbmMemTable;
    fgrd: TStringGrid;
    acctFilterList: TStringList;
    DateFrom:TDateTime;
    fAR_1to30: double;
    fTotalAR: double;
    fTotalAP: double;
    fTotalCashInBank: double;
    fAR_Current: double;
    fTotalBalanceSheet: double;
    fAP_1to30: double;
    fAR_90PlusPercent: double;
    fAP_90PlusPercent: double;
    fAR_61to90Percent: double;
    fAR_CurrentPercent: double;
    fAP_61to90Percent: double;
    fAP_CurrentPercent: double;
    fAR_31to60Percent: double;
    fAP_31to60Percent: double;
    fAR_90Plus: double;
    fAR_1to30Percent: double;
    fAP_90Plus: double;
    fAR_61to90: double;
    fAP_1to30Percent: double;
    fAP_61to90: double;
    fAP_Current: double;
    fAR_31to60: double;
    fAP_31to60: double;
    fDateFromCustom: TDateTime;
    FPnL_Month: double;
    FExpenses_Custom: double;
    FCOGS_HalfYear: double;
    FSales_Year: double;
    FCOGS_Year: double;
    FSales_Quater: double;
    FExpenses_Month: double;
    FSales_Custom: double;
    FCOGS_Quater: double;
    FCOGS_Custom: double;
    FSales_Month: double;
    FPnL_Week: double;
    FCOGS_Month: double;
    FPnL_HalfYear: double;
    FExpenses_Week: double;
    FPnL_Year: double;
    FExpenses_HalfYear: double;
    FPnL_Quater: double;
    FSales_Week: double;
    FPnL_Custom: double;
    FExpenses_Year: double;
    FCOGS_Week: double;
    FSales_HalfYear: double;
    FExpenses_Quater: double;
    function qryTransactions: TERPQuery;
    function grd: TStringGrid;
    Function MemTable: TkbmMemTable;
    procedure onMemtableFilterRecord(DataSet: TDataSet; var Accept: boolean);
  Protected
  Public
    constructor Create(AOwner :TComponent);override;
    Destructor Destroy; override;
    Property Connection :TERPConnection read fConnection write fConnection;
    Procedure doCalc;
    property valueGrid :TStringGrid Read fGrd write fGrd;

    Procedure LoadValues;
    Property DateTo :TDateTime read fdDateTo Write fdDateTo;
    property DateFromCustom: TDateTime read fDateFromCustom write fDateFromCustom;

  published
    property TotalCashInBank: double read fTotalCashInBank;
    property TotalAR: double read fTotalAR;
    property TotalAP: double read fTotalAP;
    property TotalBalanceSheet: double read fTotalBalanceSheet;

    property AR_Current: double read fAR_Current;
    property AR_CurrentPercent: double read fAR_CurrentPercent;
    property AR_1to30: double read fAR_1to30;
    property AR_1to30Percent: double read fAR_1to30Percent;
    property AR_31to60: double read fAR_31to60;
    property AR_31to60Percent: double read fAR_31to60Percent;
    property AR_61to90: double read fAR_61to90;
    property AR_61to90Percent: double read fAR_61to90Percent;
    property AR_90Plus: double read fAR_90Plus;
    property AR_90PlusPercent: double read fAR_90PlusPercent;

    property AP_Current: double read fAP_Current;
    property AP_CurrentPercent: double read fAP_CurrentPercent;
    property AP_1to30: double read fAP_1to30;
    property AP_1to30Percent: double read fAP_1to30Percent;
    property AP_31to60: double read fAP_31to60;
    property AP_31to60Percent: double read fAP_31to60Percent;
    property AP_61to90: double read fAP_61to90;
    property AP_61to90Percent: double read fAP_61to90Percent;
    property AP_90Plus: double read fAP_90Plus;
    property AP_90PlusPercent: double read fAP_90PlusPercent;

    property Sales_Week: double read FSales_Week write FSales_Week;
    property Sales_Month: double read FSales_Month write FSales_Month;
    property Sales_Quarter: double read FSales_Quater write FSales_Quater;
    property Sales_HalfYear: double read FSales_HalfYear write FSales_HalfYear;
    property Sales_Year: double read FSales_Year write FSales_Year;
    property Sales_Custom: double read FSales_Custom write FSales_Custom;

    property COGS_Week: double read FCOGS_Week write FCOGS_Week;
    property COGS_Month: double read FCOGS_Month write FCOGS_Month;
    property COGS_Quarter: double read FCOGS_Quater write FCOGS_Quater;
    property COGS_HalfYear: double read FCOGS_HalfYear write FCOGS_HalfYear;
    property COGS_Year: double read FCOGS_Year write FCOGS_Year;
    property COGS_Custom: double read FCOGS_Custom write FCOGS_Custom;

    property Expenses_Week: double read FExpenses_Week write FExpenses_Week;
    property Expenses_Month: double read FExpenses_Month write FExpenses_Month;
    property Expenses_Quarter: double read FExpenses_Quater write FExpenses_Quater;
    property Expenses_HalfYear: double read FExpenses_HalfYear write FExpenses_HalfYear;
    property Expenses_Year: double read FExpenses_Year write FExpenses_Year;
    property Expenses_Custom: double read FExpenses_Custom write FExpenses_Custom;

    property PnL_Week: double read FPnL_Week write FPnL_Week;
    property PnL_Month: double read FPnL_Month write FPnL_Month;
    property PnL_Quarter: double read FPnL_Quater write FPnL_Quater;
    property PnL_HalfYear: double read FPnL_HalfYear write FPnL_HalfYear;
    property PnL_Year: double read FPnL_Year write FPnL_Year;
    property PnL_Custom: double read FPnL_Custom write FPnL_Custom;
  end;

  Procedure MakeQry(AOwner:Tcomponent;Tablename, Databases :String; fDateto:TDatetime; ReportonForeignCurrency :Boolean; FConReport:TkbmMemTable; CustomRangeFrom:TDateTime);

var
  fSummarySheetParamObj : TSummarySheetParamObj;

  Function SummarySheetParamObj(fdReportdate:TDateTime =0; fdCustomRangeFrom :TDatetime =0) : TSummarySheetParamObj;

implementation

uses
  DateUtils, CommonDbLib, AppEnvironment, sysutils, MySQLConst, StringUtils,
  AR_APCalcUnit,  Progressdialog, tcConst, CommonLib, LogLib, TypInfo;


Function SummarySheetParamObj(fdReportdate:TDateTime =0; fdCustomRangeFrom :TDatetime =0) : TSummarySheetParamObj;
begin
   if fSummarySheetParamObj = nil then
    fSummarySheetParamObj := TSummarySheetParamObj.Create(nil);
   if (fdReportdate=0) and  (fdCustomRangeFrom =0) then begin
   end else begin
    if (fSummarySheetParamObj.Reportdate     <> fdReportdate      ) and (fdReportdate      <>0) then fSummarySheetParamObj.Reportdate :=  fdReportdate;
    if (fSummarySheetParamObj.CustomRangeFrom<> fdCustomRangeFrom ) and (fdCustomRangeFrom <>0) then fSummarySheetParamObj.CustomRangeFrom :=  fdCustomRangeFrom;
   end;
   result := fSummarySheetParamObj;
end;

{ TSummarySheetObj }

constructor TSummarySheetObj.Create(AOwner: TComponent);
begin
  inherited;
  fConnection:= Nil;
  fqryTransactions:= Nil;
  fMemTable:= Nil;
  fgrd:= Nil;
  acctFilterList := TStringList.Create;
end;

destructor TSummarySheetObj.Destroy;
begin
  FreeandNil(acctFilterList);
  inherited;
end;


procedure TSummarySheetObj.doCalc;
var
  r,c :Integer;

  function AccountTypeFilter(const Value :String ) :String;
  var
    ctr: Integer;
    st:TStringlist;
  begin
    Result:= '';
    st:= TStringlist.Create;
    try
      st.CommaText := value;
      for ctr:= 0 to st.Count -1 do begin
        if Result <> '' then Result := Result +' or ' ;
        Result := Result + ' AccountType = ' +quotedstr(st[ctr]);
      end;
    finally
      Freeandnil(st);
    end;
  end;

  procedure SetPL(Col, row: integer);
  var
    t: double;
  begin
    with memtable do begin
        Filtered := false;
        if (row < 5) then begin
          if (Col < 6) then Exit;                       // No period columns for Balance
          DateFrom := 0          // Balance is determined from begin of data
        end else DateFrom := (*dateof(*)incday(DateTo , 0- SummarySheetParamObj.days[Col])(*)*);
        acctFilterList.CommaText := acct[row];
        Filtered := true;
        Refresh;
        t := 0;
        First;
        while not Eof do begin
          if (row = 8) and (FieldByName('AccountType').AsString <> 'INC') and
            (FieldByName('AccountType').AsString <> 'EXINC') then
            t := t - FieldByName('Amount').AsFloat
          else
            t := t + FieldByName('Amount').AsFloat;

          Next;
        end;
        grd.Cells[Col, row] := floatTostr(t);
    end;
  end; // SetPL

begin
    FreeandNil(fmemtable);
    cLog('');
    for r := 1 to 8 do begin
      grd.Cells[0, r] := rowText[r];
      for c := 1 to 6 do begin
        if r = 1 then begin
          grd.Cells[c, 0] := SummarySheetParamObj.colText[c];
        end;
        SetPL(c, r);
      end;
    end;
end;

function TSummarySheetObj.grd: TStringGrid;
begin
  if fgrd = nil then begin
    fgrd:= TStringGrid.Create(Self);
    fgrd.DefaultColWidth := 100;
    fgrd.RowCount := 9;
    fgrd.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine];
    fgrd.Visible := False;
    fgrd.ColCount := 7;
  end;
  Result:=fgrd;
end;

(*
  result := 'SELECT Date, AccountType, '+
            ' IF (AccountType = "INC" Or AccountType = "EXINC", (Sum(CreditsEx) - Sum(DebitsEx)), (Sum(DebitsEx) - Sum(CreditsEx)) ) AS Amount  '+
            ' FROM tblTransactions  '+
            ' WHERE Active = "T" and Type <> "Closing Date Summary"  '+
            ' and Date > ' + Quotedstr(FormatDateTime(MysqlDateTimeFormat , AppEnv.CompanyPrefs.SummarisedTransDate))+' GROUP BY AccountType, Date  '+
            ' UNION ALL  '+
            ' SELECT Date, AccountType,  '+
            ' IF (AccountType = "INC" OR AccountType = "EXINC", (Sum(CreditsEx) - Sum(DebitsEx)), (Sum(DebitsEx) - Sum(CreditsEx)) ) AS Amount  '+
            ' FROM tblTransactionSummaryDetails  '+
            ' WHERE Active = "T" GROUP BY AccountType, Date';
*)

procedure TSummarySheetObj.LoadValues;
var
  qry: TERPQuery;
  I, x: Integer;
  dtFrom: TDateTime;
  PropSuffix, PropPrefix: string;
  AccountTypeList: string;
  Total: double;
  IsPnL: boolean;


  function GetValue(DateFrom, DateTo: TDateTime; AccountTypeList: string; aIsPnL: boolean = false): double;
  begin
    result := 0;
    qry.SQL.Clear;
    qry.SQL.Add('Select Date, AccountType, IF(AccountType = "INC" Or AccountType = "EXINC", (Sum(CreditsEx) - Sum(DebitsEx)), (Sum(DebitsEx) - Sum(CreditsEx)) ) AS Amount');
    qry.SQL.Add('FROM tblTransactions  WHERE Active = "T" and Type <> "Closing Date Summary"');
    qry.SQL.Add('and AccountType in (' + AccountTypeList + ')');
    qry.SQL.Add('and Date > ' + Quotedstr(FormatDateTime(MysqlDateTimeFormat , AppEnv.CompanyPrefs.SummarisedTransDate)));
    qry.SQL.Add('and Date between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, DateFrom)) + ' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, DateTo)));
    //qry.SQL.Add('group by AccountType, Date');
    qry.SQL.Add('UNION ALL');
    qry.SQL.Add('Select Date, AccountType, IF(AccountType = "INC" OR AccountType = "EXINC", (Sum(CreditsEx) - Sum(DebitsEx)), (Sum(DebitsEx) - Sum(CreditsEx)) ) AS Amount');
    qry.SQL.Add('FROM tblTransactionSummaryDetails WHERE Active = "T"');
    qry.SQL.Add('and AccountType in (' + AccountTypeList + ')');
    qry.SQL.Add('and Date between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, DateFrom)) + ' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, DateTo)));
    //qry.SQL.Add('group by AccountType, Date');
    qry.Open;
    while not qry.Eof do begin
      if aIsPnL and
         (qry.FieldByName('AccountType').AsString <> 'INC') and
         (qry.FieldByName('AccountType').AsString <> 'EXINC') then begin
        result := result - qry.FieldByName('Amount').AsFloat;
      end
      else begin
        result := result + qry.FieldByName('Amount').AsFloat;
      end;
      qry.Next;
    end;
    qry.Close;
    result := Round(result,0);
  end;

begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;

    fTotalCashInBank := GetValue(MinDateTime,DateTo,'"BANK"');
    fTotalAR := GetValue(MinDateTime,DateTo,'"AR"');
    fTotalAP := GetValue(MinDateTime,DateTo,'"AP"');
    fTotalBalanceSheet := GetValue(MinDateTime,DateTo,'"AR","BANK","OCASSET","OASSET","FIXASSET"');

    IsPnL := false;

    for x := 0 to 3 do begin
      case x of
        0: begin
             { Sales }
             PropPrefix := 'Sales';
             AccountTypeList := '"INC","EXINC"';
           end;
        1: begin
             { Cost of Goods }
             PropPrefix := 'COGS';
             AccountTypeList := '"COGS"';
           end;
        2: begin
             { Expenses }
             PropPrefix := 'Expenses';
             AccountTypeList := '"EXP","EXEXP"';
           end;
        3: begin
             { Profit and Loss }
             PropPrefix := 'PnL';
             AccountTypeList := '"INC","EXINC","COGS","EXP","EXEXP"';
             IsPnL := true;
           end;
      end;


      for I := 0 to 5 do begin
        case I of
          0: begin
               { last week }
               dtFrom := DateTo - 7;
               PropSuffix := '_Week';

             end;
          1: begin
               { last month }
               dtFrom := IncMonth(DateTo, -1);
               PropSuffix := '_Month';

             end;
          2: begin
               { last quarter }
               dtFrom := IncMonth(DateTo, -3);
               PropSuffix := '_Quarter';

             end;
          3: begin
               { last half year }
               dtFrom := IncMonth(DateTo, -6);
               PropSuffix := '_HalfYear';

             end;
          4: begin
               { last year }
               dtFrom := IncYear(DateTo, -1);
               PropSuffix := '_Year';

             end;
          5: begin
               { custom }
               dtFrom := DateFromCustom;
               PropSuffix := '_Custom';

             end;
        end;

        SetFloatProp(self,PropPrefix + PropSuffix, GetValue(dtFrom,DateTo,AccountTypeList,IsPnL));
      end;
    end;
  finally
    qry.Free;
  end;

  fAR_Current := ReturnDueARTotalWithinRange(DateTo, 0, 0);
  fAR_1to30 := ReturnDueARTotalWithinRange(DateTo, 0, 30);
  fAR_31to60 := ReturnDueARTotalWithinRange(DateTo, 30, 60);
  fAR_61to90 := ReturnDueARTotalWithinRange(DateTo, 60, 90);
  fAR_90Plus := ReturnDueARTotalWithinRange(DateTo, 90, 99999999);
  Total := fAR_Current + fAR_1to30 + fAR_31to60 + fAR_61to90 + fAR_90Plus;

  fAR_CurrentPercent := Round(DivZer(fAR_Current, Total) * 100, 2);
  fAR_1to30Percent := Round(DivZer(fAR_1to30, Total) * 100, 2);
  fAR_31to60Percent := Round(DivZer(fAR_31to60, Total) * 100, 2);
  fAR_61to90Percent := Round(DivZer(fAR_61to90, Total) * 100, 2);
  fAR_90PlusPercent := Round(DivZer(fAR_90Plus, Total) * 100, 2);

  fAP_Current := ReturnDueAPTotalWithinRange(DateTo, 0, 0);
  fAP_1to30 := ReturnDueAPTotalWithinRange(DateTo, 0, 30);
  fAP_31to60 := ReturnDueAPTotalWithinRange(DateTo, 30, 60);
  fAP_61to90 := ReturnDueAPTotalWithinRange(DateTo, 60, 90);
  fAP_90Plus := ReturnDueAPTotalWithinRange(DateTo, 90, 99999999);
  Total := fAP_Current + fAP_1to30 + fAP_31to60 + fAP_61to90 + fAP_90Plus;

  fAP_CurrentPercent := Round(DivZer(fAP_Current, Total) * 100, 2);
  fAP_1to30Percent := Round(DivZer(fAP_1to30, Total) * 100, 2);
  fAP_31to60Percent := Round(DivZer(fAP_31to60, Total) * 100, 2);
  fAP_61to90Percent := Round(DivZer(fAP_61to90, Total) * 100, 2);
  fAP_90PlusPercent := Round(DivZer(fAP_90Plus, Total) * 100, 2);
end;

function TSummarySheetObj.MemTable: TkbmMemTable;
begin
  if fMemTable = nil then begin
    fMemTable:= TkbmMemTable.Create(Self);
    fMemTable.LoadFromDataSet(qryTransactions, [mtcpoStructure, mtcpoProperties, mtcpoFieldIndex]);
    clog(qryTransactions.SQL.text);
    fMemTable.onfilterRecord := onMemtableFilterRecord;
  end;
  Result:= fMemTable;
end;


procedure TSummarySheetObj.onMemtableFilterRecord(DataSet: TDataSet; var Accept: boolean);
begin
  Accept :=
    (fMemTable.FieldByName('Date').AsDateTime >= DAteFrom) and
    (fMemTable.FieldByName('Date').AsDateTime <= DateTo) and
    (acctFilterList.IndexOf(fMemTable.FieldByName('AccountType').AsString) >= 0);
end;

function TSummarySheetObj.qryTransactions: TERPQuery;
begin
    if fqryTransactions = nil then begin
      fqryTransactions := TempMyQuery(fconnection);
      fqryTransactions.SQL.TExt := SummarySheetParamObj.TransQrySQL;
    end;
    if fqryTransactions.Connection <> fConnection then begin
      CloseDb(fqryTransactions);
      fqryTransactions.Connection := fConnection;
    end;
    if (fqryTransactions.Connection <> nil) and (fqryTransactions.Connection.Connected) then
      opendb(fqryTransactions);
    result := fqryTransactions;
end;



Procedure makeQry(AOwner:Tcomponent;Tablename, Databases :String; fDateto:TDatetime; ReportonForeignCurrency :Boolean; FConReport:TkbmMemTable; CustomRangeFrom:TDateTime);
var
  st:TStringlist;
  ctr:Integer;
  conn : TERPConnection;
  s:String;
  Total, fdValue:double;
  exRate: double;
  closingdate:tDatetime;
  RecDate: TDateTime;

  function GetclosingDate(const dbname:String):tdatetime;
  var
    qry: TERPQuery;
    fconn : TERPConnection;
  begin
    fconn := GetNewMyDacConnection(nil);
    try
      fconn.connected := False;
      fconn.database := dbname;
      fconn.connected := True;
      qry := DbSharedObj.GetQuery(fconn);
      try
        qry.SQL.text := 'SELECT  * FROM tbldbpreferences WHERE Name = "ClosingDate"';
        qry.open;
        result := StrToFloatDef(Qry.fieldByname('fieldValue').asString,0);
      finally
        DbSharedObj.ReleaseObj(qry);
      end;
    finally
      Freeandnil(fconn);
    end;
  end;

  function GetExchangeRate: double;
  var
    qryCode: TERPQuery;
    qryRate: TERPQuery;
  begin
    result := 1;
    qryCode := DbSharedObj.GetQuery(conn);
    try
      qryCode.SQL.Add('select tblregionaloptions.ForeignExDefault, tbldbpreferences.FieldValue');
      qryCode.SQL.Add('from tbldbpreferences, tblregionaloptions where tbldbpreferences.name = "CompanyRegion"');
      qryCode.SQL.Add('and tblregionaloptions.Region = tbldbpreferences.FieldValue');
      qryCode.Open;

      qryRate := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
      try
        qryRate.SQL.Add('select BuyRate from tblcurrencyconversionhistory');
        qryRate.SQL.Add('where Code = ' + QuotedStr(qryCode.FieldByName('ForeignExDefault').AsString));
        qryRate.SQL.Add('and Date <= "' + FormatDateTime('yyyy-mm-dd',fDateto)  + '"');
        qryRate.SQL.Add('order by Date Desc limit 1');
        qryRate.Open;
        if qryRate.FieldByName('BuyRate').AsFloat <> 0 then
          result := Round(qryRate.FieldByName('BuyRate').AsFloat, tcConst.GeneralRoundPlaces);
      finally
        DbSharedObj.ReleaseObj(qryRate);
      end;
    finally
      DbSharedObj.ReleaseObj(qryCode);
    end;
  end;

  function Convert(val: double): double;
  begin
    if exRate <> 0 then
      result := round(val / exRate,tcConst.RoundPlacesforeigncurrency)
    else
      result := 0;
  end;

  function GetMostRecentBankRecDate: TDateTime;
  var
    qry: TERPQuery;
  begin
    result := 0;
    qry := DbSharedObj.GetQuery(conn);
    try
      qry.SQL.Add('select Max(ReconciliationDate) as RecDate from tblreconciliation');
      qry.SQL.Add('where Finished = "T" and Deleted = "F"');
      qry.Open;
      if not qry.IsEmpty then
        result := qry.FieldByName('RecDate').AsDateTime;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  end;


begin
  SummarySheetParamObj.Reportdate := fDateto;
  SummarySheetParamObj.CustomRangeFrom := CustomRangeFrom;
  With TempMyScript do begin
    SQL.clear;

    st:= TStringlist.Create;
    try
      st.CommaText := Databases;
      SQL.Add(commondbLib.CreateUserTemporaryTableSQL(tablename , 'tmp_SummarySheets' ));

      if  ReportonForeignCurrency then begin
        if FConReport.RecordCount > 0 then begin
              FCOnReport.first;
              while FConReport.Eof = False do begin
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_FCRate double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt1 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt2 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt3 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt4 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt5 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt6 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt7 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt8 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt9 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_APtotal double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt10 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt11 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt12 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt13 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt14 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_ARtotal double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt15 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt16 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt17 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt18 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt19 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt20 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt21 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt22 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt23 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt24 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt25 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt26 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt27 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt28 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt29 double;'    );
                Sql.Add('Alter table ' + Tablename + ' Add column ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt30 double;'    );
                FConReport.Next;
              end;
        end;
      end;
      DoShowProgressbar(st.Count , WAITMSG);
      try
        for ctr:= 0 to st.count-1 do begin
          conn := GetNewMyDacConnection(AOwner, st[ctr]);
          exRate:= GetExchangeRate;
          closingdate := Getclosingdate(st[ctr]);

          s :=
            'insert into ' + tablename +' set dbname = ' +quotedstr(st[ctr])+
            ', ExchangeRate = ' + FloatToStr(exRate);
          recDate := GetMostRecentBankRecDate;
          if recDate > 0 then
            s := s +
              ', LastBankRecDate = ' + QuotedStr(FormatDateTime(MySqlDateTimeFormat,GetMostRecentBankRecDate));
          s := s +
            ',closingdate ='+ quotedstr(formatDateTime(MySqlDatetimeformat , closingdate))+',';
          DoStepProgressbar(st[ctr]);
          with TSummarySheetObj.create(AOwner) do try
            connection := conn;
            DateTo := fDateto;
            DoCalc;
            s:= s + 'Amt1 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[6, 1]))))+',';
            s:= s + 'Amt2 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[6, 2]))))+',';
            s:= s + 'Amt3 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[6, 3]))))+',';
            s:= s + 'Amt4 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[6, 4]))))+',';

            s:= s + 'Amt15 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[1, 5]))))+',';
            s:= s + 'Amt16 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[1, 6]))))+',';
            s:= s + 'Amt17 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[1, 7]))))+',';
            s:= s + 'Amt18 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[1, 8]))))+',';

            s:= s + 'Amt19 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[2, 5]))))+',';
            s:= s + 'Amt20 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[2, 6]))))+',';
            s:= s + 'Amt21 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[2, 7]))))+',';
            s:= s + 'Amt22 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[2, 8]))))+',';

            s:= s + 'Amt23 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[3, 5]))))+',';
            s:= s + 'Amt24 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[3, 6]))))+',';
            s:= s + 'Amt25 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[3, 7]))))+',';
            s:= s + 'Amt26 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[3, 8]))))+',';

            s:= s + 'Amt27 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[4, 5]))))+',';
            s:= s + 'Amt28 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[4, 6]))))+',';
            s:= s + 'Amt29 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[4, 7]))))+',';
            s:= s + 'Amt30 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[4, 8]))))+',';

            s:= s + 'Amt31 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[5, 5]))))+',';
            s:= s + 'Amt32 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[5, 6]))))+',';
            s:= s + 'Amt33 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[5, 7]))))+',';
            s:= s + 'Amt34 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[5, 8]))))+',';


            s:= s + 'Amt35 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[6, 5]))))+',';
            s:= s + 'Amt36 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[6, 6]))))+',';
            s:= s + 'Amt37 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[6, 7]))))+',';
            s:= s + 'Amt38 = ' +  FloatTostr(Convert(StringToFloat(Trim(valueGrid.Cells[6, 8]))))+',';


          finally
            Free;
          end;

          Total   := Convert(ReturnDueAccountsPayableTotal(fDateTo, conn));
          s:= s + 'APtotal = ' +FloatTostr( total)+',';
          fdValue := Convert(ReturnDueAPTotalWithinRange(fDateTo, 0,  0 , Conn));        s:= s + 'Amt5 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt5Percent = ' +FloatTostr(CalcPercentage(fdValue, total))+',';
          fdValue := Convert(ReturnDueAPTotalWithinRange(fDateTo, 0,  30, Conn));        s:= s + 'Amt6 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt6Percent = ' +FloatTostr(CalcPercentage(fdValue, total))+',';
          fdValue := Convert(ReturnDueAPTotalWithinRange(fDateTo, 30, 60, Conn));        s:= s + 'Amt7 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt7Percent = ' +FloatTostr(CalcPercentage(fdValue, total))+',';
          fdValue := Convert(ReturnDueAPTotalWithinRange(fDateTo, 60, 90, Conn));        s:= s + 'Amt8 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt8Percent = ' +FloatTostr(CalcPercentage(fdValue, total))+',';
          fdValue := Convert(ReturnDueAPTotalWithinRange(fDateTo, 90, 99999999 , Conn)); s:= s + 'Amt9 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt9Percent = ' +FloatTostr(CalcPercentage(fdValue, total))+',';

          Total   := Convert(ReturnDueAccountsReceivableTotal(fDateTo, conn));
          s:= s + 'ARtotal = ' +FloatTostr( total)+',';
          fdValue := Convert(ReturnDueARTotalWithinRange(fDateTo, 0,  0 , Conn));        s:= s + 'Amt10 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt10Percent = ' +FloatTostr(CalcPercentage(fdValue, total))+',';
          fdValue := Convert(ReturnDueARTotalWithinRange(fDateTo, 0,  30, Conn));        s:= s + 'Amt11 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt11Percent = ' +FloatTostr(CalcPercentage(fdValue, total))+',';
          fdValue := Convert(ReturnDueARTotalWithinRange(fDateTo, 30, 60, Conn));        s:= s + 'Amt12 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt12Percent = ' +FloatTostr(CalcPercentage(fdValue, total))+',';
          fdValue := Convert(ReturnDueARTotalWithinRange(fDateTo, 60, 90, Conn));        s:= s + 'Amt13 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt13Percent = ' +FloatTostr(CalcPercentage(fdValue, total))+',';
          fdValue := Convert(ReturnDueARTotalWithinRange(fDateTo, 90, 99999999 , Conn)); s:= s + 'Amt14 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt14Percent = ' +FloatTostr(CalcPercentage(fdValue, total));
          SQL.add(s +';');
        end;
        DoStepProgressbar;
      finally
        DoHideProgressbar;
      end;

      if  ReportonForeignCurrency then begin
        if FConReport.RecordCount > 0 then begin
              FCOnReport.first;
              while FConReport.Eof = False do begin

                SQL.Add('Update  ' + tablename  +
                       ' set ' + FConReport.FieldByName('Code').AsString + '_FCRate' + '  =   '+
                       '   (SELECT SellRate from tblcurrencyconversionhistory as main  '+
                       '    where date <=  CurDate()  '+
                       '    and main.Code = ' + quotedStr(FConReport.FieldByName('Code').AsString)  +
                       '    and main.Date in   '+
                       '       (Select max(date) from tblcurrencyconversionhistory as sub   '+
                       '        where sub.CurrencyID = main.CurrencyID    '+
                       '        and date <=  CurDate() )  '+
                       ' union  '+
                       ' SELECT SellRate  '+
                       ' from tblcurrencyconversion  '+
                       ' where active = ''T''  '+
                       ' and tblcurrencyconversion.Code = ' + quotedStr(FConReport.FieldByName('Code').AsString)  +
                       ' and currencyId not in   '+
                       '   (select currencyId from tblcurrencyconversionhistory    '+
                       '    where  date <=  CurDate())  )   '+
                       '    Where ifnull(' + FConReport.FieldByName('Code').AsString + '_FCRate,0) = 0;');
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt1 = Amt1 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt2 = Amt2 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt3 = Amt3 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt4 = Amt4 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt5 = Amt5 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt6 = Amt6 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt7 = Amt7 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt8 = Amt8 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt9 = Amt9 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt10 = Amt10 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt11 = Amt11 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt12 = Amt12 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt13 = Amt13 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt14 = Amt14 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt15 = Amt15 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt16 = Amt16 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt17 = Amt17 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt18 = Amt18 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt19 = Amt19 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt20 = Amt20 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt21 = Amt21 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt22 = Amt22 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt23 = Amt23 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt24 = Amt24 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt25 = Amt25 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt26 = Amt26 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt27 = Amt27 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt28 = Amt28 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt29 = Amt29 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt30 = Amt30 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt31 = Amt31 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt32 = Amt32 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt33 = Amt33 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt34 = Amt34 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt35 = Amt35 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt36 = Amt36 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt37 = Amt37 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                Sql.Add('update ' + Tablename + ' Set ' + trim(FConReport.FieldByName('Code').AsString)+'_Amt38 = Amt38 * ' + trim(FConReport.FieldByName('Code').AsString)+'_FcRate ;'    );
                FConReport.Next;
              end;
        end;
      end;

      Execute;
    finally
      Freeandnil(st);
    end;
  end;
end;
{ TSummarySheetParamObj }

constructor TSummarySheetParamObj.Create(AOwner: TComponent);
begin
  inherited;
  fdCustomRangeFrom:= Date;
  Reportdate := Date;
end;

procedure TSummarySheetParamObj.SetCustomRangeFrom(const Value: TDatetime);
begin
  fdCustomRangeFrom := Value;
  InitIt;
end;

procedure TSummarySheetParamObj.SetReportdate(const Value: TDatetime);
begin
  fdReportdate := Value;
  InitIt;
end;
function TSummarySheetParamObj.getTransQrySQL: String;
begin
  result := 'SELECT Date, AccountType, '+
            ' IF (AccountType = "INC" Or AccountType = "EXINC", (Sum(CreditsEx) - Sum(DebitsEx)), (Sum(DebitsEx) - Sum(CreditsEx)) ) AS Amount  '+
            ' FROM tblTransactions  '+
            ' WHERE Active = "T" and Type <> "Closing Date Summary"  '+
            ' and Date > ' + Quotedstr(FormatDateTime(MysqlDateTimeFormat , AppEnv.CompanyPrefs.SummarisedTransDate))+' GROUP BY AccountType, Date  '+
            ' UNION ALL  '+
            ' SELECT Date, AccountType,  '+
            ' IF (AccountType = "INC" OR AccountType = "EXINC", (Sum(CreditsEx) - Sum(DebitsEx)), (Sum(DebitsEx) - Sum(CreditsEx)) ) AS Amount  '+
            ' FROM tblTransactionSummaryDetails  '+
            ' WHERE Active = "T" GROUP BY AccountType, Date';
end;

procedure TSummarySheetParamObj.InitIt;
begin
  days[1]:= DaysBetween(Reportdate , incweek(Reportdate, -1) );
  if dateof(EndOfTheMonth(Reportdate)) = dateof(Reportdate) then begin
    days[2]:= DaysBetween(Reportdate , incsecond(StartOfTheMonth(Reportdate),-1));
    days[3]:= DaysBetween(Reportdate , incMonth(incsecond(StartOfTheMonth(Reportdate),-1), -2)) ;
    days[4]:= DaysBetween(Reportdate , incMonth(incsecond(StartOfTheMonth(Reportdate),-1), -5)) ;
    days[5]:= DaysBetween(Reportdate , incMonth(incsecond(StartOfTheMonth(Reportdate),-1), -11)) ;

  end else begin
  days[2]:= DaysBetween(Reportdate , incMonth(Reportdate, -1) );
  days[3]:= DaysBetween(Reportdate , incMonth(Reportdate, -3) );
  days[4]:= DaysBetween(Reportdate , incMonth(Reportdate, -6) );
  days[5]:= DaysBetween(Reportdate , incMonth(Reportdate, -12) );
  end;

  days[6]:= DaysBetween(Reportdate , incday(CustomRangeFrom,-1) ); // incday -1 to include the day selected as well

  colText[1]:= 'last Week (Ex)';
  colText[2]:= 'last Month (Ex)';
  colText[3]:= 'last 3 Months (Ex)';
  colText[4]:= 'last 6 Months (Ex)';
  colText[5]:= 'last 12 Months (Ex)';
  colText[6]:= FormatDatetime(FormatSettings.ShortDateFormat , CustomRangeFrom)+' to ' + FormatDatetime(FormatSettings.ShortDateFormat , Reportdate);
end;

initialization
  fSummarySheetParamObj := nil;

finalization
  if fSummarySheetParamObj <> nil then Freeandnil(fSummarySheetParamObj);
end.



