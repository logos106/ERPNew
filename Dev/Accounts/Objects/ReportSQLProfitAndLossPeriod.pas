unit ReportSQLProfitAndLossPeriod;

interface

uses ERPDbComponents, ReportSQLBase, classes;

const
       Month1  = '1 Month';
       Months2 = '2 Months';
       Months3 = '3 Months';
       Months6 = '6 Months';
       Months12 = '12 Months';

type
  TPeriodtype = (ptMonth=1, pt2Month=2,  ptQuarter =3,pt6Month=4,  ptYear =5);
  pColumnRec = ^TColumnRec;
  TColumnRec = record
    ColumnNo: integer;
    ColumnName: string;
    Amt1: string;
    Amt2: string;
    ColumnFrom: TDateTime;
    ColumnTo: TDateTime;
  end;

  TReportSQLProfitAndLossBase = Class(TReportSQLBase)
    Private
      fsQrymaintablename:String;
      fsTransTableName :String;
      fbIncludedataPriorToClosingDate:Boolean;
      fPeriodtype :TPeriodtype;
      fQryBudgets :TERPQuery;
      fQryAccounts :TERPQuery;
      fQryAccountAmtforPeriod :TERPQuery;
      ColumnCount:Integer;
      amtPercent:Integer;
      fiBudgetID :Integer;
      fsSelectedPnLIds:String;
      function getQryBudgets: TERPQuery;
      function getQryAccounts: TERPQuery;
      procedure setQryBudgets(const Value: TERPQuery);
      procedure setQryAccounts(const Value: TERPQuery);
      function AccountSummaryTable: String;
      function AmountfieldsForTable: String;
      function BlankcolumnsForTable(amountCols: Integer): String;
      function FCFieldsForTable(ColumnNo: Integer): String;
      Function AddFCFieldsToSQL(ColumnNo :Integer; AmountZero :Boolean = False ):String ;
      function AddtotalFCField(AmountZero :Boolean = False ):String ;
      function PercentCalc(const fFieldname: String): String;
      function BudgetFields(const Value: Integer; isZero:Boolean; isSum: Boolean):String;
      function Accountfields(const Value: pColumnRec; isZero:Boolean; isSum: Boolean):String;
      function Blankcolumns(amountCols: Integer; PercentValue: String): String;
      Procedure DoProcessScriptExecteError(const Value:String);
      procedure setBudgetID(const Value: Integer);
      function ISBudgetSelected:Boolean;
      (*function AccountAmtforPeriod(const TableID:Integer; Colno :Integer):Double;*)
      procedure MyScriptBeforeExecute(Sender: TObject; var SQL: String; var Omit: Boolean);
      function IdofSales: Integer;
      procedure SetSelectedPnLIds(const Value: String);
      function getPeriodtypeDesc: String;
      procedure setPeriodtypeDesc(const Value: String);
    Protected
      fStringListForSQL :TStringlist;
      function reportCaption:String;virtual;
      function GetReportTypeID: integer;override;
      Function FCfieldNames(ColumnNo :Integer; AmountZero :Boolean = False ):String ;
      Procedure AddFCFields(Tablename:String ='');override;
      Function ReportDetailsforTable:string ; virtual;abstract;
      function AddAmountfields(isZero:Boolean; isSum:Boolean ;  isnegativePercent:Boolean = False; accountType:String = ''; whereCaluse:String = ''):String;
      function BlankLine(FinalOrder :Integer; AccountType:String = ''; accountTypeDesc:String = ''):String;
      function AccountSummary(HidePercentage:string  ; finalOrder:String ;
                              Accttype:String; accountTypeDesc :STring;AccountName:String;AccountID:String ;
                              accountTypes:String; groupby:String;
                              AccountSub1Order:String ='AccountSub1Order';AccountSub2Order:String ='AccountSub2Order'; AccountSub3Order:String ='AccountSub3Order'; whereCaluse:String = ''; Hidetotal :String = '"T"';
                              ExcludeAccountIDs :String = ''; IcludeAccountIDs:String = ''):string;
      Procedure initTablename; Virtual;
      procedure SetEmployeeID(const Value: Integer);Override;
      Function ExtraProcessSQL:String;virtual;
    Public
      LstColumn: TList;
      constructor Create(Aowner:TComponent);override;
      Destructor Destroy;override;
      Property Qrymaintablename :String read fsQrymaintablename write fsQrymaintablename;
      Property TransTableName :String read fsTransTableName write fsTransTableName;
      Property IncludedataPriorToClosingDate :Boolean read fbIncludedataPriorToClosingDate write fbIncludedataPriorToClosingDate;
      function PrepareForReport:Boolean; override;
      Property Periodtype :TPeriodtype read fPeriodtype write fPeriodtype;
      Property PeriodtypeDesc :String read getPeriodtypeDesc write setPeriodtypeDesc;
      Property QryBudgets :TERPQuery read getQryBudgets write setQryBudgets;
      Property QryAccounts :TERPQuery read getQryAccounts write setQryAccounts;
      procedure CreateTempPLPeriodTable;
      procedure AddDataToTempPLPeriodTable;
      procedure MakeMainQryTable;
      //function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
      procedure ClearColumns;
      procedure GetColumns;
      function ReportSQL:String;
      function ReportSQLMain:String;
      function ReportSQLMain_Heading:String;
      function ReportSQLMain_Details:String;
      Property BudgetID :Integer read fiBudgetID write setBudgetID;
      Property SelectedPnLIds:String read fsSelectedPnLIds write SetSelectedPnLIds;


End;

  TReportSQLProfitAndLossPeriod = class(TReportSQLProfitAndLossBase)
    Private
      (*procedure ReportDetails;*)
    Protected
      Function ReportDetailsforTable:string ; Override;
      Procedure initTablename; Override;
      function GetTemplateSQL: String;Override;
      function reportCaption:String;Override;
    Public
        constructor Create(Aowner:TComponent);override;
  end;

  TProfitandLossPeriodCompare = class(TReportSQLProfitAndLossBase)
    Private
      (*procedure ReportDetails;*)
      function AccountcomparePercent: String;
    Protected
      Function ReportDetailsforTable:string ; Override;
      Procedure initTablename; Override;
      function GetTemplateSQL: String;Override;
      function reportCaption:String;Override;
      Function ExtraProcessSQL:String;Override;
    Public
      constructor Create(Aowner:TComponent);override;
  end;

  TReportSQLProfitAndLossPeriodCompare = class(TReportSQLProfitAndLossBase)
    Private
      (*procedure ReportDetails;*)
      function AmountComparePercent: String;
    Protected
      Function ReportDetailsforTable:string ; Override;
      Procedure initTablename; Override;
      function GetTemplateSQL: String;Override;
      function reportCaption:String;Override;
      Function ExtraProcessSQL:String;Override;
    Public
      constructor Create(Aowner:TComponent);override;
  end;
  TReportSQLIncomeandExpenditure= class(TReportSQLProfitAndLossBase)
    Private
      SelectedIDs:String;
      function AllAccountIds(const Accountname: String): String;
      function COGSConfigAccountsSQL: String;
      function ExpenseConfigAccountsSQL: String;
      function IncomeExpenseConfigAccountsSQL: String;
      (*procedure ReportDetails;*)
    Protected
      Procedure initTablename; Override;
      Function ReportDetailsforTable:string ; Override;
      function GetTemplateSQL: String;Override;
      function reportCaption:String;Override;
    Public
        constructor Create(Aowner:TComponent);override;
  end;

Function InttoPeriodtype(const Value :Integer):TPeriodtype;
function AccnameFldName(const AccName:String; fieldno :Integer; firecno:Integer):String;
implementation

uses Dateutils,TempTableUtils, tcConst, sysutils, Report_ProfitnLossPeriod_Obj,
	MySQLConst, SyncReportTableObj, AppEnvironmentVirtual ,BusObjectListObj, SystemLib, 
	DateTimeUtils, UtilsLib,  MySQLUtils , ProgressInfoObj, DbSharedObjectsObj(*,
  CommonDbLib*), LogLib;

Function InttoPeriodtype(const Value :Integer):TPeriodtype;
begin
       if Value = 0 then result := ptMonth
  else if Value = 1 then result := pt2month
  else if Value = 2 then result := ptQuarter
  else if Value = 3 then result := pt6month
  else Result := ptYear;
end;

{ TReportSQLProfitAndLossBase }

procedure TReportSQLProfitAndLossBase.AddFCFields(Tablename: String);
var
  qry: TERPQuery;
begin
  if sametext(tablename , TransTableName) then begin
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
        With qry do begin
          if active then close;
          SQL.Text := 'show columns from ' + tablename +'  like "TotalAmountInc"';
          Open;
          if not IsEmpty then
            exit;
        end;
(*    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;


    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try*)
        With qry do begin
          if active then close;
          SQL.Clear;
          SQL.add('Alter table ' + tablename + ' Add column  TotalamountEX Double, Add column TotalAmountInc Double;');
          try
            Execute;
          Except
            // kill exception if the field already exists
          end;
        end;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
    //GetColumns;
  end;
  inherited;
end;

function TReportSQLProfitAndLossBase.AddFCFieldsToSQL(ColumnNo: Integer; AmountZero: Boolean): String;
begin
  Result := '';
  if FConReport.RecordCount > 0 then begin
      FCOnReport.First;
      while FConReport.Eof = False do begin
          if AmountZero then begin
              result:= result + '  0 as ' + FCOnReport.FieldByname('Code').asString+ '_Amount_' +IntToStr(Columnno) + ',';
              result:= result + '  0 as ' + FCOnReport.FieldByname('Code').asString+ '_Amount1_' +IntToStr(Columnno) + ',';
              result:= result + '  0 as ' + FCOnReport.FieldByname('Code').asString+ '_Amount1_v' +IntToStr(Columnno) + ',';
              result:= result + '  0 as ' + FCOnReport.FieldByname('Code').asString+ '_Amount2_' +IntToStr(Columnno) + ',';
              result:= result + '  0 as ' + FCOnReport.FieldByname('Code').asString+ '_Amount2_v' +IntToStr(Columnno) + ',';
          end else begin
              result:= result + ' sum(' + FCOnReport.FieldByname('Code').asString+ '_Amount_' +IntToStr(Columnno) + '),';
              result:= result + ' sum(' + FCOnReport.FieldByname('Code').asString+ '_Amount1_' +IntToStr(Columnno) + '),';
              result:= result + ' sum(' + FCOnReport.FieldByname('Code').asString+ '_Amount1_v' +IntToStr(Columnno) + '),';
              result:= result + ' sum(' + FCOnReport.FieldByname('Code').asString+ '_Amount2_' +IntToStr(Columnno) + '),';
              result:= result + ' sum(' + FCOnReport.FieldByname('Code').asString+ '_Amount2_v' +IntToStr(Columnno) + '),';
          end;
          FCOnReport.Next;
      End;
  End;
end;

constructor TReportSQLProfitAndLossBase.Create(Aowner: TComponent);
begin
  fiBudgetID :=0;
  fsSelectedPnLIds:='';
  inherited;
  fStringListForSQL :=TStringlist.Create;
  amtPercent:=0;
  fQryBudgets:= nil;
  fQryAccounts:= nil;
  fQryAccountAmtforPeriod:= nil;
  usingReportTables:= True;
  ReportonForeignCurrency:= true;
  inittablename;
  ReportSQLSupplied:= TRue;
  AddFCFields;
  AddFCFields(TransTableName);
  LstColumn := TList.Create;
  Periodtype := InttoPeriodtype(GuiPrefs.Node['Grpfilters.ItemIndex'].asInteger);
end;

destructor TReportSQLProfitAndLossBase.Destroy;
begin
  FreeandNil(LstColumn);
  FreeandNil(fStringListForSQL);
  if TempTablename <> '' then TempTableUtils.DestroyUserTemporaryTable(GetSharedMyDacConnection,  TempTablename);
  if Qrymaintablename <> '' then TempTableUtils.DestroyUserTemporaryTable(GetSharedMyDacConnection,  Qrymaintablename);
  if TransTableName <> '' then TempTableUtils.DestroyUserTemporaryTable(GetSharedMyDacConnection,  TransTableName);
  inherited;
end;

procedure TReportSQLProfitAndLossBase.DoProcessScriptExecteError(const Value: String);
begin
      UtilsLib.DoProcessScriptExecteError(Value);
end;

function TReportSQLProfitAndLossBase.ExtraProcessSQL: String;
begin

end;

function TReportSQLProfitAndLossBase.GetReportTypeID: integer;
begin
    Result := 76;
end;

procedure TReportSQLProfitAndLossBase.initTablename;
begin
  inherited;
end;

function TReportSQLProfitAndLossBase.ISBudgetSelected: Boolean;
begin
  result:= (BudgetID<>0) and (QryBudgets.recordcount > 0);
end;

function TReportSQLProfitAndLossBase.Prepareforreport: Boolean;
var
  ProfitnLossPeriod_Report_Obj: TProfitnLossPeriod_Report_Obj;
begin
  if BudgetId = 0 then BudgetId := GuiPrefs.Node['Budget.Id'].AsInteger;
  ClosenfreeFCOnReport; // will reopen the fc table if any new currency is selected
  AddFCFields; // this is to make sure if any new currecny field is selected
  ProfitnLossPeriod_Report_Obj := TProfitnLossPeriod_Report_Obj.Create(True);
  try
    ProfitnLossPeriod_Report_Obj.CleanRefresh_PLPeriod_Table(TransTableName, FCFields, sametext(reportClassname, 'TProfitnLosschartGUI')  or IncludedataPriorToClosingDate);
    Result := True;
  finally
    FreeandNil(ProfitnLossPeriod_Report_Obj);
  end;
  CreateTempPLPeriodTable;
  AddDataToTempPLPeriodTable;
  MakeMainQryTable;
end;
function TReportSQLProfitAndLossBase.reportCaption: String;
begin
  Result:='';
end;

procedure TReportSQLProfitAndLossBase.setQryBudgets(const Value: TERPQuery);
begin
  if (fQryBudgets <> nil) and (fQryBudgets.owner  = self) then begin
    fQryBudgets.closenfree;
  end;
  fQryBudgets := value;
end;
procedure TReportSQLProfitAndLossBase.SetSelectedPnLIds(const Value: String);
begin
  fsSelectedPnLIds := Value;
end;

procedure TReportSQLProfitAndLossBase.setQryAccounts(const Value: TERPQuery);
begin
  if (fQryAccounts <> nil) and (fQryAccounts.owner  = self) then begin
    fQryAccounts.closenfree;
  end;
  fQryAccounts := value;
end;

procedure TReportSQLProfitAndLossBase.ClearColumns;
var
  i: integer;
begin
  for i := 0 to LstColumn.Count - 1 do  Dispose(LstColumn.Items[i]);
  LstColumn.Clear;
end;
Function TReportSQLProfitAndLossBase.ReportSQL:String;
var
  I: integer;
  pColumn: pColumnRec;
  Amount1Caption, Amount2Caption: string;
begin
          Result := Result + ' {Master}';
          Result := Result + ' Select ';
          if Periodtype = ptMonth     then Result := Result + ' ' +QuotedStr(reportCaption +'(Monthly)') + '  as rptcaption ,';
          if Periodtype = pt2Month    then Result := Result + ' ' +QuotedStr(reportCaption +'(2 Monthly)') + '  as rptcaption ,';
          if Periodtype = ptQuarter   then Result := Result + ' ' +QuotedStr(reportCaption +'(Quarterly)') + '  as rptcaption ,';
          if Periodtype = pt6Month    then Result := Result + ' ' +QuotedStr(reportCaption +'(6 Monthly)') + '  as rptcaption ,';
          if Periodtype = PtYear      then Result := Result + ' ' +QuotedStr(reportCaption +'(Yearly)') + '  as rptcaption , ';

          Result := Result + ' DATE_FORMAT("' + FormatDateTime(MysqlDateFormat, DateFrom) + '", "%W %D %M, %Y") as FromDate,';
          Result := Result + ' DATE_FORMAT("' + FormatDateTime(MysqlDateFormat, DateTo) + '" , "%W %D %M, %Y") as ToDate,';
          Result := Result + ' CO.CompanyName,CO.Address, CO.Address2, CO.City, CO.State, ';
          Result := Result + ' CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, ';
          Result := Result + ' Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN  ';
          Result := Result + ' FROM tblCompanyInformation AS CO;';
          Result := Result + ' ~|||~{Periods}';
          Result := Result + ' SELECT ' + QuotedStr('AccountID') + '  as AccountID,';
          Result := Result + ' "AccountType" as AccountType,';
          Result := Result + ' "Account Type" as "AccountTypeDesc" ,';
          Result := Result + ' "Account Name"  as AccountName, ';
          ColumnCount := LstColumn.Count - 1;
          Amount1Caption := 'Amount1';
          Amount2Caption := 'Amount2';
          if columncount >= 0 then begin
            pColumn := LstColumn.Items[0];
            Amount1Caption := pColumn^.amt1;
            Amount2Caption := pColumn^.amt2;
          end;

          for I := 0 to ColumnCount do begin
            pColumn := LstColumn.Items[I];
            Result := Result + ' ' + FCfieldNames(pColumn^.ColumnNo, True);
            Result := Result + ' ' + AddtotalFCField(True);
            Result := Result + ' ' + QuotedStr(pColumn^.Columnname) +' as columnName_' +IntToStr(pColumn^.ColumnNo) + ',';
            Result := Result + ' ' + QuotedStr('Actual ') +   ' as Amount_' +IntToStr(pColumn^.ColumnNo) + ',';
            Result := Result + ' ' + QuotedStr('Percentage ') + ' as Percentage_' +IntToStr(pColumn^.ColumnNo) + ',';
            Result := Result + ' ' + QuotedStr('Budget ' + ' ' + Amount1Caption) + ' as Amount1_' +IntToStr(pColumn^.ColumnNo) + ',';
            Result := Result + ' ' + QuotedStr('Variance '+' ' + Amount1Caption) + ' as Amount1_v' +IntToStr(pColumn^.ColumnNo) + ',';
            Result := Result + ' ' + QuotedStr('Budget ' + ' ' + Amount2Caption) + ' as Amount2_' +IntToStr(pColumn^.ColumnNo) + ',';
            Result := Result + ' ' + QuotedStr('Variance '  + ' ' + Amount2Caption) + ' as Amount2_v' +IntToStr(pColumn^.ColumnNo) + ',';
          end;

          if ColumnCount < 20 - 1 then for I := ColumnCount + 2 to 20 do begin
            Result := Result + ' ' + QuotedStr(IntToStr(i)) +' as columnName_' +IntToStr(i) + ',';
            Result := Result + ' ' + QuotedStr('Actual') + ' as Amount_' +IntToStr(i) + ',';
            Result := Result + ' ' + QuotedStr('Percentage ') + ' as Percentage_' +IntToStr(i) + ',';
            Result := Result + ' ' + QuotedStr('Budget ' +Amount1Caption) + ' as Amount1_' +IntToStr(i) + ',';
            Result := Result + ' ' + QuotedStr('Variance '+ Amount1Caption) + ' as Amount1_v' +IntToStr(i) + ',';
            Result := Result + ' ' + QuotedStr('Budget ' + Amount2Caption) + ' as Amount2_' +IntToStr(i) + ',';
            Result := Result + ' ' + QuotedStr('Variance '+ Amount2Caption) + ' as Amount2_v' +IntToStr(i) + ',';
          end;

          Result := Result + ' ' + QuotedStr('Totalamount') + ' as TotalAmount,';
          Result := Result + ' ' + QuotedStr('2') + '  As FinalOrder,';
          Result := Result + ' ' + QuotedStr('AccountHeaderOrder') + ' as AccountHeaderOrder,';
          Result := Result + ' ' + QuotedStr('AccountSub1Order') + ' as AccountSub1Order,';
          Result := Result + ' ' + QuotedStr('AccountSub2Order') + ' as AccountSub2Order,';
          Result := Result + ' ' + QuotedStr('AccountSub3Order') + ' as AccountSub3Order,';
          Result := Result + '  "T" as HideTotal ';
          Result := Result + ' FROM tblCompanyInformation AS CO; ';
          Result := Result + ' ~|||~{Deails}';
          Result := Result + ' Select * from ' + Qrymaintablename+' where HideTotal ="T"' ;
          Result := Result + ' Order By FinalOrder,AccountHeaderOrder,AccountSub1Order,AccountSub2Order ,AccountSub3Order,TotalAmount; ';
end;
function TReportSQLProfitAndLossBase.ReportSQLMain_Heading:String;
var
  I: integer;
  pColumn: pColumnRec;
begin
  Result := '';
  Result := Result + ' SELECT  ';
  for I := 0 to ColumnCount do begin
      pColumn := LstColumn.Items[I];
      REsult := result + 'H.`DateFrom_' + IntToStr(pColumn^.ColumnNo) + '` ,';
      REsult := result + 'H.`DateTo_' + IntToStr(pColumn^.ColumnNo) + '` ,';
      REsult := result + 'H.`DateDesc_' + IntToStr(pColumn^.ColumnNo) + '` ,';

  end;
  Result := Result + ' from ' + Qrymaintablename+'_CH H';
end;

function TReportSQLProfitAndLossBase.ReportSQLMain_Details:String;
begin
  Result := '';
  Result := Result + ' SELECT  ';
  Result := Result + ' M.* from ' + Qrymaintablename+' M';
  Result := Result + ' Order by  M.FinalOrder,M.AccountHeaderOrder,M.AccountSub1Order,M.AccountSub2Order ,M.AccountSub3Order,M.TotalAmount ';
end;

function TReportSQLProfitAndLossBase.ReportSQLMain: String;
var
  I: integer;
  pColumn: pColumnRec;
begin
  Result := '';
  Result := Result + ' SELECT  ';
  for I := 0 to ColumnCount do begin
    pColumn := LstColumn.Items[I];
    Result := Result + 'H.`DateFrom_' + IntToStr(pColumn^.ColumnNo) + '` ,';
    Result := Result + 'H.`DateTo_' + IntToStr(pColumn^.ColumnNo) + '` ,';
    Result := Result + 'H.`DateDesc_' + IntToStr(pColumn^.ColumnNo) + '` ,';

  end;
  Result := Result + ' M.* FROM ' + Qrymaintablename + ' M, ' + Qrymaintablename+'_CH H';
  Result := Result + ' ORDER BY M.FinalOrder,M.AccountHeaderOrder,M.AccountSub1Order,M.AccountSub2Order, M.AccountSub3Order, M.TotalAmount ';
end;

procedure TReportSQLProfitAndLossBase.setBudgetID(const Value: Integer);
begin
  if fiBudgetID <> Value then begin
    fiBudgetID := Value;
    QryBudgets;
  end;
end;

procedure TReportSQLProfitAndLossBase.SetEmployeeID(const Value: Integer);
begin
  inherited;
  AddFCFields(TransTableName);
end;

Function TReportSQLProfitAndLossBase.FCfieldNames(ColumnNo :Integer; AmountZero :Boolean = False ):String ;
begin
  result:= '';
  if FConReport.RecordCount > 0 then begin
      FCOnReport.First;
      while FConReport.Eof = False do begin
          if AmountZero then begin
              Result := Result + ' 0 as ' + FCOnReport.FieldByname('Code').asString+ '_Amount_' +IntToStr(Columnno) + ',';
              Result := Result + ' 0 as ' + FCOnReport.FieldByname('Code').asString+ '_Amount1_' +IntToStr(Columnno) + ',';
              Result := Result + ' 0 as ' + FCOnReport.FieldByname('Code').asString+ '_Amount1_v' +IntToStr(Columnno) + ',';
              Result := Result + ' 0 as ' + FCOnReport.FieldByname('Code').asString+ '_Amount2_' +IntToStr(Columnno) + ',';
              Result := Result + ' 0 as ' + FCOnReport.FieldByname('Code').asString+ '_Amount2_v' +IntToStr(Columnno) + ',';
          end else begin
              Result := Result + ' sum(' + FCOnReport.FieldByname('Code').asString+ '_Amount_' +IntToStr(Columnno) + '),';
              Result := Result + ' sum(' + FCOnReport.FieldByname('Code').asString+ '_Amount1_' +IntToStr(Columnno) + '),';
              Result := Result + ' sum(' + FCOnReport.FieldByname('Code').asString+ '_Amount1_v' +IntToStr(Columnno) + '),';
              Result := Result + ' sum(' + FCOnReport.FieldByname('Code').asString+ '_Amount2_' +IntToStr(Columnno) + '),';
              Result := Result + ' sum(' + FCOnReport.FieldByname('Code').asString+ '_Amount2_v' +IntToStr(Columnno) + '),';
          end;
          FCOnReport.Next;
      End;
  End;
end;

procedure TReportSQLProfitAndLossBase.GetColumns;
var
  pColumn: pColumnRec;
  TempColumnCount, fd1: integer;
  FromDate, ToDate, StartDate, EndDate: TDateTime;
  ColumnName: string;
  Amt1, amt2: string;

  Function IsOkToHavemorePeriodcolumn:Boolean;
  var
    ctr,ColumnCount:Integer;
  begin
    if not (Self is TProfitandLossPeriodCompare) then begin
      Result := LstColumn.Count < 250;
      Exit;
    end;
  	ColumnCount := LstColumn.Count+1; // current no of columns +1
    ctr := 14;
    ctr := ctr + ColumnCount *6;
    ctr := ctr + ColumnCount *2 * QryAccounts.recordcount ;
    ctr := ctr + 2 * FConReport.RecordCount ;
    ctr := ctr + ColumnCount * 5 * FConReport.RecordCount ;
    ctr := ctr + 13;
    Result := ctr < 250;
  end;
begin
  ClearColumns;
  StartDate       := DateFrom;
  EndDate         := DateTo;
  TempColumnCount := 0;
  FromDate        := StartDate;
  ToDate          := EndDate; {To Remove Hint}

  case Periodtype of
    ptMonth  :  ToDate := IncMonth(StartDate  , TempColumnCount);
    pt2Month :  ToDate := IncMonth(StartDate  , TempColumnCount*2);
    ptQuarter:  ToDate := incQuarter(StartDate, TempColumnCount) ;
    pt6Month :  ToDate := IncMonth(StartDate  , TempColumnCount*6);
    ptYear   :  ToDate := IncYear(StartDate   , TempColumnCount);
  end;

  fd1 := TempColumnCount;
  while ToDate <= EndDate do begin
    if not IsOkToHavemorePeriodcolumn then begin
      DateTo := ToDate;
      if Assigned(fOnChangeToDate) then fOnChangeToDate(ToDate);
      Break;
    end;
    TempColumnCount := TempColumnCount + 1;
    case Periodtype of
      ptMonth:begin {Month}
          fd1 := fd1 + 1;
          FromDate := IncSecond(ToDate);
          ToDate  := EndOfTheMonth(IncMonth(StartDate, fd1 - 1));
          ColumnName := (*dotranslate(*)GetMonthName(MonthOfTheYear(FromDate))(*)*) + '(' +IntToStr(YearOf(FromDate)) + ')';
        end;
      pt2Month:begin {Month}
          fd1 := fd1 + 2;
          FromDate := IncSecond(ToDate);
          ToDate  := EndOfTheMonth(IncMonth(StartDate, fd1 -1));
          ColumnName := GetMonthName(MonthOfTheYear(FromDate)) + ' - ' +GetMonthName(MonthOfTheYear(ToDate)) + ' (' +IntToStr(YearOf(FromDate)) + ')';
        end;
      ptQuarter:begin {Quarter}
          fd1 := fd1 + 1;
          FromDate := IncSecond(ToDate);
          ToDate := EndOfTheQuarter(IncQuarter(StartDate, fd1 - 1));
          //ColumnName := (*dotranslate(*)'Quarter'(*)*)+' '+ IntToStr(QuarterOf(FromDate)) + '(' +IntToStr(YearOf(FromDate)) + ')';
          ColumnName := GetMonthName(MonthOfTheYear(FromDate)) + ' - ' +GetMonthName(MonthOfTheYear(ToDate)) + ' (' +IntToStr(YearOf(FromDate)) + ')';
        end;
      pt6Month:begin {Month}
          fd1 := fd1 + 6;
          FromDate := IncSecond(ToDate);
          ToDate  := EndOfTheMonth(IncMonth(StartDate, fd1 -1));
          ColumnName := GetMonthName(MonthOfTheYear(FromDate)) + ' - ' +GetMonthName(MonthOfTheYear(ToDate)) + ' (' +IntToStr(YearOf(FromDate)) + ')';
        end;
      ptYear:begin {Year}
          fd1 := fd1 + 1;
          FromDate := IncSecond(ToDate);
          ToDate := EndOfAYear(YearOf(IncYear(StartDate, fd1 - 1)));
          //ColumnName := (*dotranslate(*)'Year'(*)*)+' - ' +IntToStr(YearOf(FromDate));
          ColumnName := GetMonthName(MonthOfTheYear(FromDate)) + ' - ' +GetMonthName(MonthOfTheYear(ToDate)) + ' (' +IntToStr(YearOf(FromDate)) + ')';
      end;
    end;

    if ISBudgetSelected then begin
        Amt1 := QryBudgets.FieldByName('Amount1Label').AsString;
        Amt2 := QryBudgets.FieldByName('Amount2Label').AsString;
    end;

    New(pColumn);
    LstColumn.Add(pColumn);
    pColumn^.ColumnNo   := TempColumnCount;
    pColumn^.ColumnName := ColumnName;
    pColumn^.ColumnFrom := FromDate;
    pColumn^.ColumnTo   := ToDate;
    pColumn^.Amt1       := amt1;
    pColumn^.amt2       := amt2;
  end;
end;

function TReportSQLProfitAndLossBase.getQryBudgets: TERPQuery;
var
  S:String;
begin
  s:= 'SELECT BudgetID, Name, Description , Amount1Label, Amount2Label, ShowAmount1, Showamount2  , startdate , enddate  ' +
            ' FROM tblBudgets ' +
            ' WHERE Active = ''T'' ' +
            ' and ((startdate between :DateFrom and :Dateto) ' +
            ' or  (endDate between :DateFrom and :Dateto) ' +
            ' or (startDate  <= :DateFrom and endDate >= :DateTo)) ' +
            ' ORDER BY Name ASC;';

  if fQryBudgets = nil then fQryBudgets := TempMyquery;

  if not(Sametext(s, fQryBudgets.SQL.text)) then begin
    if fQryBudgets.active then fQryBudgets.close;
    fQryBudgets.SQL.text := s;
  end;

  if  (fQryBudgets.Parambyname('datefrom').asDatetime <> dateFrom) or (fQryBudgets.Parambyname('DateTo').asDatetime <> DateTo) then begin
    if fQryBudgets.active then fQryBudgets.close;
    fQryBudgets.Parambyname('datefrom').asDatetime :=  dateFrom;
    fQryBudgets.Parambyname('DateTo').asDatetime   :=  DateTo;
  end;

  if fQryBudgets.active =False then fQryBudgets.open;

  if budgetId <> 0 then fQryBudgets.Locate('budgetID' , budgetID, []);

  Result := fQryBudgets;
end;

function TReportSQLProfitAndLossBase.IdofSales:Integer;
var
  qry: TERPQuery;
begin
  result:= 0;
  qry := UtilsLib.GetQuery;
  try
    qry.SQL.Text := 'show tables like "'+Qrymaintablename+'"';
    qry.Open;
    if qry.IsEmpty then
      exit;

    qry.Close;
    qry.SQL.Text := 'show columns from '+Qrymaintablename+' like "ID"';
    qry.Open;
    if qry.IsEmpty then
      exit;

    qry.Close;
    qry.SQL.Text := 'Select Id from ' + Qrymaintablename+' where accountname = "Sales"';
    qry.Open;
    result := qry.FieldByName('ID').AsInteger;
    qry.Close;
  finally
    UtilsLib.ReleaseDbObj(qry);
  end;
end;

function TReportSQLProfitAndLossBase.getQryAccounts: TERPQuery;
var
  s:String;
begin

  //if SelectedPnLIds = '' then SelectedPnLIds:= '0';
  if (SelectedPnLIds = '') or (SelectedPnLIds= '0') then
      SelectedPnLIds := inttostr(IdofSales);
  if SelectedPnLIds = '' then SelectedPnLIds:= '0';
  (*s:= ' SELECT ' +
      ' C.AccountId , C.accountname , ' +
      ' C.AccountType, ' +
      ' IF(char_length(C.Level4)>0,Concat(Space(15),C.AccountName),IF(char_length(C.Level3)>0,Concat(Space(10),C.AccountName),IF(char_length(C.Level2)>0,Concat(Space(5),C.AccountName),Concat(Space(0),C.AccountName)))) as Accounts, ' +
      ' sum(T.CreditsEx - T.DebitsEx) as exAmt, ' +
      ' sum(T.CreditsInc - T.DebitsInc) as incAmt ' +
      ' FROM tblchartofaccounts C ' +
      ' Left join tbltransactions  T  on C.accountID = T.accountID ' +
      ' where c.Accountid in (' +  AccountIDs+') ' +
      ' group by accountId ' +
      ' order by accountname';*)
  //s:= 'Select AccountID, AccountNAme from tblchartofaccounts where Accountid in (' +  AccountIDs+') order by accountname';

  //if tableexists(Qrymaintablename) then
  if TempTableUtils.TableExists(GetSharedMyDacConnection, Qrymaintablename) then
    s:= 'select distinct ' +
      ' ID, '+
      'if(ifnull(Accountname,'''')='''', AccounttypeDesc,Accountname) as description' +
      ' from ' + Qrymaintablename +
      ' Where id in (' +  SelectedPnLIds+')' +
      ' order by description'
  else s:= 'Select  '+
      '0 as ID,  '+
      '"" as  description limit 0';

  if fQryAccounts = nil then fQryAccounts := TempMyquery;

  if not(Sametext(trim(s), trim(fQryAccounts.SQL.text))) then begin
    if fQryAccounts.active then fQryAccounts.close;
    fQryAccounts.SQL.text := s;
  end;

  if fQryAccounts.active =False then fQryAccounts.open;
  Result := fQryAccounts;
end;

procedure TReportSQLProfitAndLossBase.CreateTempPLPeriodTable;
var
  pColumn: pColumnRec;
  I, ColumnCount: integer;
  cmd: TERPScript;
begin
  GetColumns;
  cmd := DbSharedObj.GetScript(GetSharedMyDacConnection);
  try
  With cmd do begin
    SQL.Clear;
    SQL.Add('DROP TABLE IF EXISTS ' + TempTablename + ' ;');
    SQL.Add('CREATE TABLE ' + TempTablename + ' ( ');
    SQL.Add('`ID` int(11) NOT NULL auto_increment,');
    SQL.Add('`TransID` int(11) default "0",');
    SQL.Add('`AccountID` int(11) default "0",');
    SQL.Add('`AccountType` varchar(50) default NULL,');
    SQL.Add('`Date` date default NULL,');
    SQL.Add('`Description` varchar(50) default NULL,');
    SQL.Add('`Accounts` varchar(255) default NULL,');
    SQL.Add('`Account_Type` varchar(50) default NULL,');
    SQL.Add('`AccountName` varchar(50) default NULL,');
    SQL.Add('`AccountGroupLevels` varchar(255) default NULL,');
    SQL.Add('`Level1` varchar(255) default NULL,');
    SQL.Add('`Level2` varchar(255) default NULL,');
    SQL.Add('`Level3` varchar(255) default NULL,');
    SQL.Add('`Level4` varchar(255) default NULL,');
    ColumnCount := LstColumn.Count - 1;
    for I := 0 to ColumnCount do begin
      pColumn := LstColumn.Items[I];
      SQL.Add('`Amount_' +IntToStr(pColumn^.ColumnNo) + '` double default NULL,');
      SQL.Add('`Percentage_' +IntToStr(pColumn^.ColumnNo) + '` /*double */ varchar(100) default NULL,');
      { add change columns .. }
      if I  > 0 then  begin
        SQL.Add('`Change_' +IntToStr(pColumn^.ColumnNo) + '` double default NULL,');
        SQL.Add('`ChangePercent_' +IntToStr(pColumn^.ColumnNo) + '` double default NULL,');
      end;

      {fields for budget}
      SQL.Add('`Amount1_' +IntToStr(pColumn^.ColumnNo) + '` double default NULL,');
      SQL.Add('`Amount1_v' +IntToStr(pColumn^.ColumnNo) + '` double default NULL,');
      SQL.Add('`Amount2_' +IntToStr(pColumn^.ColumnNo) + '` double default NULL,');
      SQL.Add('`Amount2_v' +IntToStr(pColumn^.ColumnNo) + '` double default NULL,');

      try
        {fields for account comparisson}
        if self is TProfitandLossPeriodCompare then
          if QryAccounts.recordcount >0 then begin
              QryAccounts.first;
              While QryAccounts.eof = False do begin
                SQL.Add('`' + AccnameFldName(QryAccounts.fieldbyname('Description').asString , pColumn^.ColumnNo, QryAccounts.recno) + '_amt`      double default NULL,');
                SQL.Add('`' + AccnameFldName(QryAccounts.fieldbyname('Description').asString , pColumn^.ColumnNo, QryAccounts.recno) + '_Percent`  double default NULL,');
                QryAccounts.Next;
              end;
          end;
      except

      end;

      if Self is TReportSQLProfitAndLossPeriodCompare then begin
        SQL.Add('Amount_diff' + IntToStr(pColumn^.ColumnNo) + ' double default NULL,');
        SQL.Add('Amount_Perc' + IntToStr(pColumn^.ColumnNo) + ' double default NULL,');
      end;
    end;

    if FConReport.RecordCount > 0 then begin
        FCOnReport.first;
        while FConReport.Eof = False do begin
            SQL.Add('`' + FCOnReport.Fieldbyname('Code').asString + '_FCRate` double default NULL , ');
            for I := 0 to ColumnCount do begin
                pColumn   := LstColumn.Items[I];
                SQL.Add('`' + FCOnReport.Fieldbyname('Code').asString + '_amount_'+IntToStr(pColumn^.ColumnNo) + '` double default NULL , ');
                SQL.Add('`' + FCOnReport.Fieldbyname('Code').asString + '_amount1_'+IntToStr(pColumn^.ColumnNo) + '` double default NULL , ');
                SQL.Add('`' + FCOnReport.Fieldbyname('Code').asString + '_amount2_'+IntToStr(pColumn^.ColumnNo) + '` double default NULL , ');
                SQL.Add('`' + FCOnReport.Fieldbyname('Code').asString + '_amount1_v'+IntToStr(pColumn^.ColumnNo) + '` double default NULL , ');
                SQL.Add('`' + FCOnReport.Fieldbyname('Code').asString + '_amount2_v'+IntToStr(pColumn^.ColumnNo) + '` double default NULL , ');
            end;
            SQL.Add('`' + FCOnReport.Fieldbyname('Code').asString + '_Totalamount` double default NULL , ');
            FCOnReport.Next;
        end;
      end;

    SQL.Add('`TotalAmount` double default NULL,');
    SQL.Add('`AccountHeaderOrder` varchar(255) default NULL,');
    SQL.Add('`AccountSub1Order` varchar(255) default NULL,');
    SQL.Add('`AccountSub2Order` varchar(255) default NULL,');
    SQL.Add('`AccountSub3Order` varchar(255) default NULL,');
    SQL.Add('`FilterDate` date default NULL,');
    SQL.Add('`FilterWeekday` varchar(255) default NULL,');
    SQL.Add('`FilterWeekdayNumber` int(11) default NULL,');
    SQL.Add('`FilterWeekNumber` int(11) default NULL,');
    SQL.Add('`FilterMonthNumber` int(11) default NULL,');
    SQL.Add('`FilterMonthName` varchar(255) default NULL,');
    SQL.Add('`FilterQuarterNumber` int(11) default NULL,');
    SQL.Add('`FilterYEAR` int(11) default NULL, ');
    SQL.Add('PRIMARY KEY  (`ID`) ');
    SQL.Add(') ENGINE=MyISAM;');

    SQL.Add('DROP TABLE IF EXISTS ' + Qrymaintablename + '_CH ;');
    SQL.Add('CREATE TABLE ' + Qrymaintablename + '_CH ( ');
    SQL.Add('`ID` int(11) NOT NULL auto_increment,');
    for I := 0 to ColumnCount do begin
      pColumn := LstColumn.Items[I];
      SQL.Add('`DateFrom_' +IntToStr(pColumn^.ColumnNo) + '` DAtetime null default NULL,');
      SQL.Add('`DateTo_' +IntToStr(pColumn^.ColumnNo) + '` DAtetime null default NULL,');
      SQL.Add('`Datedesc_' +IntToStr(pColumn^.ColumnNo) + '` varchar(50) null default NULL,');
    end;
    SQL.Add('PRIMARY KEY  (`ID`) ');
    SQL.Add(') ENGINE=MyISAM;');

    SQL.Add('INSERT IGNORE INTO ' + Qrymaintablename + '_CH SET ');
    for I := 0 to ColumnCount do begin
      pColumn := LstColumn.Items[I];
      SQL.Add('`DateFrom_' +IntToStr(pColumn^.ColumnNo) + '` = ' + quotedstr(FormatDateTime(MysqlDateFormat, pColumn^.ColumnFrom))+',');

           if Periodtype =ptYear   then SQL.Add('`DateDesc_' +IntToStr(pColumn^.ColumnNo) + '` = YEAR(' + quotedstr(FormatDateTime(MysqlDateFormat, pColumn^.ColumnTo))+ '),')
      else if Periodtype =ptMonth  then SQL.Add('`DateDesc_' +IntToStr(pColumn^.ColumnNo) + '` = DATE_FORMAT(' + quotedstr(FormatDateTime(MysqlDateFormat, pColumn^.ColumnTo))+ ' , "%b %Y"),')
      else if Periodtype =pt2Month then SQL.Add('`DateDesc_' +IntToStr(pColumn^.ColumnNo) + '` = DATE_FORMAT(' + quotedstr(FormatDateTime(MysqlDateFormat, pColumn^.ColumnTo))+ ' , "%b %Y"),')
      else if Periodtype =pt6Month then SQL.Add('`DateDesc_' +IntToStr(pColumn^.ColumnNo) + '` = DATE_FORMAT(' + quotedstr(FormatDateTime(MysqlDateFormat, pColumn^.ColumnTo))+ ' , "%b %Y"),')
      else SQL.Add('`DateDesc_' +IntToStr(pColumn^.ColumnNo) + '` = concat(DATE_FORMAT(' + quotedstr(FormatDateTime(MysqlDateFormat, pColumn^.ColumnFrom))+ ', "%b"), "-" ,'+
                           ' DATE_FORMAT(' + quotedstr(FormatDateTime(MysqlDateFormat, pColumn^.ColumnTo))+ ' , "%b %Y")),');

      SQL.Add('`DateTo_' +IntToStr(pColumn^.ColumnNo) + '` = '+ quotedstr(FormatDateTime(MysqlDateFormat, pColumn^.ColumnTo))+iif(I<Columncount,  ',',';'));
    end;

    BeforeExecute := MyScriptBeforeExecute;
    stepProgressbar;
    try
//      SQL.Savetofile('c:\temp\temp.sql');
      Execute;
    finally
      HideProgressbar;
    end;
  end;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;

procedure TReportSQLProfitAndLossBase.MyScriptBeforeExecute(Sender: TObject; var SQL: String; var Omit: Boolean);
begin
  StepProgressbar;
end;

procedure TReportSQLProfitAndLossBase.AddDataToTempPLPeriodTable;
var
  InsertSQL: string;
  Qry1, Qry2: TERPQuery;
  pColumn: pColumnRec;
  I: integer;
  aType: string;
  ctr:Integer;
  st:TStringlist;
begin
  InsertSQL := 'INSERT HIGH_PRIORITY INTO ' + Temptablename + '(TransID , AccountID,AccountType,Date,Description,Accounts,Account_Type,AccountName,AccountGroupLevels,Level1,' + 'Level2,Level3,Level4,';
  ColumnCount := LstColumn.Count - 1;
  for I := 0 to ColumnCount do begin
    pColumn   := LstColumn.Items[I];
    InsertSQL := InsertSQL + 'Amount_' +IntToStr(pColumn^.ColumnNo) + ',';
  end;
  //if Fcfields <> '' then InsertSQL := InsertSQL + FCFields +',';
  InsertSQL := InsertSQL + 'TotalAmount,AccountHeaderOrder,AccountSub1Order,AccountSub2Order,AccountSub3Order,FilterDate,FilterWeekday,FilterWeekdayNumber,' + 'FilterWeekNumber,FilterMonthNumber,FilterMonthName,FilterQuarterNumber,FilterYEAR)';
  With TempMyscript do try
    IgnorenContinueOnError:= TRue;
    Sql.Clear;
    Sql.Add('Truncate  ' + TempTablename + '; ');
    Sql.Add(InsertSQL);
    Sql.Add('SELECT ID, AccountID,AccountType,Date,Description,Accounts,Account_Type,AccountName,AccountGroupLevels,Level1,Level2,Level3,Level4,');

    ColumnCount := LstColumn.Count - 1;
    for I := 0 to ColumnCount do begin
      pColumn := LstColumn.Items[I];
      Sql.Add('If(Date Between "' + FormatDateTime(MysqlDateFormat, pColumn^.ColumnFrom) +
        '" AND "' + FormatDateTime(MysqlDateFormat, pColumn^.ColumnTo) + '"  ,TotalAmountEx,0.00)   as "Amount' +
       IntToStr(pColumn^.ColumnNo) + '" ,');
    end;

    //if Fcfields <> '' then Sql.Add(FCFields + ',');

    Sql.Add('TotalAmountEx as TotalAmount , ');
    Sql.Add('`AccountHeaderOrder`,');
    Sql.Add('`AccountSub1Order`,');
    Sql.Add('`AccountSub2Order`,');
    Sql.Add('`AccountSub3Order`,');
    Sql.Add('Date as FilterDate,');
    Sql.Add('DAYNAME(Date) as FilterWeekday,');
    Sql.Add('WEEKDAY(Date) as FilterWeekdayNumber,');
    Sql.Add('WEEK(Date,3)  AS FilterWeekNumber,');
    Sql.Add('MONTH(Date) as FilterMonthNumber,');
    Sql.Add('MONTHNAME(Date) as FilterMonthName,');
    Sql.Add('QUARTER(Date) AS FilterQuarterNumber,');
    Sql.Add('YEAR(Date) AS FilterYEAR ');
    Sql.Add('FROM ' + TransTableName);
    Sql.Add('WHERE (AccountType = "EXEXP" OR AccountType = "EXINC" OR AccountType = "EXP" OR AccountType = "INC" OR AccountType = "COGS") ');
    Sql.Add('AND Date Between "' + FormatDateTime(MysqlDateFormat, DateFrom) + '" AND "' +
      FormatDateTime(MysqlDateFormat, DateTo) + '" ');
    Sql.Add('GROUP BY ID ;');

    {runing separate query to update FC rate incase if the field is missing in the transtable}
    if Fcfields <> '' then begin
       st:= TStringlist.create;
       try
         st.commatext :=Fcfields;
         for ctr:= 0 to st.count-1 do begin
          if TableHasFCRate(TempTablename, st[ctr]) and TableHasFCRate(TransTableName, st[ctr])  then
            SQL.add('update ' + TempTablename +' T inner join ' + TransTableName +' TR on T.TransID = TR.ID Set T.' + trim(st[ctr]) +' = TR.' +trim(st[ctr])+';');
         end;
       finally
         freeandnil(st);
       end;
    end;

    ProcessScriptExecteError := DoProcessScriptExecteError;
    BeforeExecute := MyScriptBeforeExecute;
    showProgressbar('Please Wait' , SQL.Count);
    try
      Execute;
    finally
      HideProgressbar;
    end;

    if IsbudgetSelected then begin
      Qry1 := TempMyQuery;
      Qry2 := TempMyQuery;
      try
        qry1.SQL.Clear;
        qry1.SQL.Add('Select * from  ' + TempTablename);
        qry1.Open;
        for I := 0 to ColumnCount do begin
          pColumn := LstColumn.Items[I];
          InsertSQL := '  SELECT 	tblchartofaccounts.AccountType , bl.AccountId,  ' +
                          ' SUM(bl.Conservative) as Amt2, SUM(bl.aggressive) as Amt1' +
                          ' FROM tblBudgetLines as bl,  tblchartofaccounts  ' +
                          ' WHERE bl.AccountId =  tblchartofaccounts.AccountId ' +
                          ' And  (bl.BudgetID = ' + inttostr(BudgetID) + ' ) ' +
                          ' AND (bl.Date BETWEEN ' + QuotedStr(FormatDateTime(MysqlDateFormat, pcolumn^.ColumnFrom)) + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, pcolumn^.ColumnTo)) + ') ' +
                          ' Group by AccountId';
          Qry2.SQL.Clear;
          Qry2.SQL.add(InsertSQL);
          Qry2.Open;
          Qry2.First;
          while Qry2.Eof = false do begin
            if Qry1.Locate('AccountId', Qry2.FieldByName('AccountId').AsInteger, []) then begin
              Qry1.Edit;
              {negating the expense amounts}
              aType := uppercase(Qry2.FieldByName('Accounttype').AsString);
              if (aType = 'EXP') or (aType = 'EXEXP') or (aType = 'COGS') or (aType = 'AP') or (aType = 'AR') then begin
                Qry1.FieldByName('Amount1_' +IntToStr(pColumn^.ColumnNo)).AsFloat := -(Qry2.FieldByName('Amt1').AsFloat);
                Qry1.FieldByName('Amount2_' +IntToStr(pColumn^.ColumnNo)).AsFloat := -(Qry2.FieldByName('Amt2').AsFloat);
              end else begin
                Qry1.FieldByName('Amount1_' +IntToStr(pColumn^.ColumnNo)).AsFloat := Qry2.FieldByName('Amt1').AsFloat;
                Qry1.FieldByName('Amount2_' +IntToStr(pColumn^.ColumnNo)).AsFloat := Qry2.FieldByName('Amt2').AsFloat;
              end;
              Qry1.Post;
            end;
            Qry2.Next;
          end;
        end;

        qry1.First;
        while Qry1.Eof = false do begin
          Qry1.Edit;
          for I := 0 to ColumnCount do begin
            pColumn := LstColumn.Items[I];
            Qry1.FieldByName('Amount1_v' +IntToStr(pColumn^.ColumnNo)).AsFloat :=
              Qry1.FieldByName('Amount_' +IntToStr(pColumn^.ColumnNo)).AsFloat - Qry1.FieldByName('Amount1_' +IntToStr(pColumn^.ColumnNo)).AsFloat;

            Qry1.FieldByName('Amount2_v' +IntToStr(pColumn^.ColumnNo)).AsFloat :=
              Qry1.FieldByName('Amount_' +IntToStr(pColumn^.ColumnNo)).AsFloat - Qry1.FieldByName('Amount2_' +IntToStr(pColumn^.ColumnNo)).AsFloat;
          end;
          Qry1.Post;
          Qry1.Next;
        end;
      finally
        if Qry1.Active then Qry1.Close;
        if Qry2.Active then Qry2.Close;
        FreeandNil(Qry1);
        FreeandNil(Qry2);
      end;

    end;

    SQL.Clear;
    if FConReport.RecordCount > 0 then begin
      FCOnReport.first;
      Sql.Add('UPDATE ' + TempTablename + ' SET ' );
      while FConReport.Eof = False do begin
        for I := 0 to ColumnCount do begin
            pColumn   := LstColumn.Items[I];
            if Sql.count > 1 then Sql.add(',');

            if ISBudgetSelected  then begin
                Sql.Add( FCOnReport.Fieldbyname('Code').asString + '_amount1_'+IntToStr(pColumn^.ColumnNo) + ' = ' +
                                'TRUNCATE(amount1_'+IntToStr(pColumn^.ColumnNo) + '* ' +
                                FCOnReport.Fieldbyname('Code').asString + '_FCRate,' + IntToStr(RoundPlacesforeigncurrency) + '),');
                Sql.Add( FCOnReport.Fieldbyname('Code').asString + '_amount1_v'+IntToStr(pColumn^.ColumnNo) + ' = ' +
                                'TRUNCATE(amount1_v'+IntToStr(pColumn^.ColumnNo) + '* ' +
                                FCOnReport.Fieldbyname('Code').asString + '_FCRate,' + IntToStr(RoundPlacesforeigncurrency) + '),');
                Sql.Add( FCOnReport.Fieldbyname('Code').asString + '_amount2_'+IntToStr(pColumn^.ColumnNo) + ' = ' +
                                'TRUNCATE(amount2_'+IntToStr(pColumn^.ColumnNo) + '* ' +
                                FCOnReport.Fieldbyname('Code').asString + '_FCRate,' + IntToStr(RoundPlacesforeigncurrency) + '),');
                Sql.Add( FCOnReport.Fieldbyname('Code').asString + '_amount2_v'+IntToStr(pColumn^.ColumnNo) + ' = ' +
                                'TRUNCATE(amount2_v'+IntToStr(pColumn^.ColumnNo) + '* ' +
                                FCOnReport.Fieldbyname('Code').asString + '_FCRate,' + IntToStr(RoundPlacesforeigncurrency) + '),');
            end;
            Sql.Add( FCOnReport.Fieldbyname('Code').asString + '_amount_'+IntToStr(pColumn^.ColumnNo) + ' = ' +
                            'TRUNCATE(amount_'+IntToStr(pColumn^.ColumnNo) + '* ' +
                            FCOnReport.Fieldbyname('Code').asString + '_FCRate,' + IntToStr(RoundPlacesforeigncurrency) + ')');
        end;

        if Sql.count > 1 then Sql.add(',');
        Sql.Add( FCOnReport.Fieldbyname('Code').asString + '_totalamount = ' +
                'TRUNCATE(TotalAmount * ' + FCOnReport.Fieldbyname('Code').asString + '_FCRate,' + IntToStr(RoundPlacesforeigncurrency) + ')');
        FCOnReport.Next;
      end;
      if SQL.count > 0 then begin
        SQL.text := SyncReportObj.ChangeQuery(SQL.text, usingReportTables);
        BeforeExecute := MyScriptBeforeExecute;
        showProgressbar('Please Wait' , SQL.Count);
        try
          Execute;
        finally
          HideProgressbar;
        end;
      end;
    end;
  finally
    free;
  end;
end;

function TReportSQLProfitAndLossBase.AccountSummaryTable:String;
begin
  Result := 'DROP TABLE IF EXISTS ' + Qrymaintablename + ';' + #13#10 +
            ' CREATE TABLE ' + Qrymaintablename + #13#10 +
            '  (HidePercentage Enum("T","F") DEFAULT "F",' + #13#10 +
            ' AccountID int(11),' + #13#10 +
            ' AccountType VARCHAR(20),' + #13#10 +
            'AccountTypeDesc VARCHAR(255) , '+ #13#10 +
            'AccountName VARCHAR(255), ' + #13#10 +
            AmountfieldsForTable + #13#10 +
            'FinalOrder INT(11),' + #13#10 +
            ' AccountHeaderOrder VARCHAR(100),' + #13#10 +
            ' AccountSub1Order  VARCHAR(100),' + #13#10 +
            ' AccountSub2Order VARCHAR(100),' + #13#10 +
            ' AccountSub3Order VARCHAR(100),' + #13#10 +
            ' HideTotal ENUM("T","F") DEFAULT "F"  ' + #13#10 +
            ')  ENGINE=MyIsam;';
end;

function TReportSQLProfitAndLossBase.AmountFieldsForTable : String;
var
  ColumnCount, x: Integer;
  pColumn: pColumnRec;
begin
  Result := '';
  ColumnCount := LstColumn.Count - 1;
  for x := 0 to ColumnCount do begin
    pColumn := LstColumn.Items[x];
    Result := Result + FCFieldsForTable(pColumn^.ColumnNo);

    if FConReport.RecordCount > 0 then begin
      FCOnReport.First;
      while FConReport.Eof = False do begin
        Result := Result + FCOnReport.FieldByname('Code').AsString + '_' + IntToStr(pColumn^.ColumnNo) + '_totalAmount Double,';
        FCOnReport.Next;
      End;
    End;

    Result := Result + 'Amount_' + IntToStr(pColumn^.ColumnNo) + ' DOUBLE,';
    Result := Result + 'Percentage_' + IntToStr(pColumn^.ColumnNo) + ' VARCHAR(100),';

    if x > 0 then begin
      Result := Result + 'Change_' + IntToStr(pColumn^.ColumnNo) + ' DOUBLE,';
      Result := Result + 'ChangePercent_' + IntToStr(pColumn^.ColumnNo) + ' DOUBLE,';
    end;

(*      if  self is TReportSQLProfitAndLossPeriodCompare then begin
        Result  := Result   + 'Amount_diff' +IntToStr(pColumn^.ColumnNo) + ' Double,';
        Result  := Result   + 'Amount_Perc' +IntToStr(pColumn^.ColumnNo) + ' Double,';
      end;*)

    if isBudgetSelected then begin
      Result := Result + 'Amount1_'  + IntToStr(pColumn^.ColumnNo) + ' DOUBLE,';
      Result := Result + 'Amount1_v' + IntToStr(pColumn^.ColumnNo) + ' DOUBLE,';
      Result := Result + 'Amount2_'  + IntToStr(pColumn^.ColumnNo) + ' DOUBLE,';
      Result := Result + 'Amount2_v' + IntToStr(pColumn^.ColumnNo) + ' DOUBLE,';
    end;

    With QryAccounts do
      if recordcount >0 then begin
        First;
        While Eof = False do begin
          Result  := Result   +'`' + AccnameFldName(QryAccounts.fieldbyname('Description').asString , pColumn^.ColumnNo, QryAccounts.recno) + '_amt`      double default NULL,';
          Result  := Result   +'`' + AccnameFldName(QryAccounts.fieldbyname('Description').asString , pColumn^.ColumnNo, QryAccounts.recno) + '_Percent`  double default NULL,';
          Next;
        end;
      end;
  end;

  Result := Result + BlankcolumnsForTable(columncount);
  Result := Result + 'TotalAmount DOUBLE,';
end;

function TReportSQLProfitAndLossBase.BlankcolumnsForTable(amountCols:Integer): String;
var
  I:Integer;
begin
  REsult := '';
    if amountCols < 20 - 1 then
      for I := amountCols   + 2 to 20 do begin
        REsult := REsult +'Amount_'  + IntToStr(I) + ' Double,';
        REsult := REsult +'Percentage_' +IntToStr(I) + ' varchar(100),';
        IF isBudgetSelected then begin
          REsult := REsult +'Amount1_' + IntToStr(I) + ' Double,';
          REsult := REsult +'Amount1_v'+ IntToStr(I) + ' Double,';
          REsult := REsult +'Amount2_' + IntToStr(I) + ' Double,';
          REsult := REsult +'Amount2_v'+ IntToStr(I) + ' Double,';
        end;
        With QryAccounts do
          if recordcount >0 then begin
            First;
            While Eof = False do begin
              Result := Result + '`' + AccnameFldName(QryAccounts.fieldbyname('Description').AsString, I, QryAccounts.recno) + '_amt`      double default NULL,';
              Result := Result + '`' + AccnameFldName(QryAccounts.fieldbyname('Description').AsString, I, QryAccounts.recno) + '_Percent`  double default NULL,';
              Next;
            end;
          end;
      end;
end;


Procedure TReportSQLProfitAndLossBase.MakeMainQryTable;
begin
  With tempMyScript do try
    try
      SQL.Add(AccountSummaryTable);
      SQL.Add(ReportDetailsforTable);
      SQL.Add('ALTER TABLE ' + Qrymaintablename + ' ADD COLUMN `id` INT(10) not NULL AUTO_INCREMENT AFTER `HideTotal`,  ADD PRIMARY KEY (`id`);');
      SQL.Add(ExtraProcessSQL);
      LogText(SQL.Text);
      BeforeExecute := MyScriptBeforeExecute;
//      sql.savetofile('c:\temp\temp.sql');
      showProgressbar('Please Wait', SQL.Count);
      try
        Execute;
      finally
        HideProgressbar;
      end;

    Except
    end;
  finally
    free;
  end;
end;

{ TReportSQLProfitAndLossPeriod }

constructor TReportSQLProfitAndLossPeriod.Create(Aowner: TComponent);
begin
    inherited;

end;

function TReportSQLProfitAndLossPeriod.getTemplateSQL: String;
begin
  REsult:= ReportSQL ;
  exit;
  (*ReportDetails;
  REsult:= fStringListForSQL.TExt;*)
end;

procedure TReportSQLProfitAndLossPeriod.initTablename;
begin
  inherited;
  BaseTemptablename := 'tblBalancesheet';
  ReportClassName   := 'TProfitandLossByPeriodGUI';
  TempTablename     := 'tmp_PL_' + GetMachineIdentification(true, true, true, true);
  Qrymaintablename  := 'tmp_PL_' + ReportClassName + '_' + GetMachineIdentification(true, true, true, true);;
  TransTableName    := TempTableUtils.CreateUserTemporaryTable(GetSharedMyDacConnection, TABLE_PROFITANDLOSSREPORT , 'period' );
end;

function TReportSQLProfitAndLossPeriod.reportCaption: String;
begin
  Result:= 'Profit and Loss Report';
end;

(*procedure TReportSQLProfitAndLossPeriod.ReportDetails;
begin
  inherited;
  fStringListForSQL.Clear;
  with fStringListForSQL do begin
    Add(BlankLine(2,'INC', 'Income' ));
    Add('UNION ALL ');Add(AccountSummary('F'  , '3'   , '"INC"'       , ''                ,'Accounts'   ,'AccountID'    , '"EXINC","INC"'                        , 'Accounts'   ));
    Add('UNION ALL ');Add(AccountSummary('F'  , '4'   , '"INC"'       , 'Total Income'    ,'""'         , '0'           , '"EXINC","INC"'                        , '"INC"'      ));Add('UNION ALL ');Add(BlankLine(5))  ;Add('UNION ALL ');Add(BlankLine( 6,'COGS', 'Cost of Goods Sold' ));
    Add('UNION ALL ');Add(AccountSummary('F'  , '7'   , '"COGS"'      , ''                ,'Accounts'   ,'AccountId'    , '"COGS"'                               , 'Accounts'   ));
    Add('UNION ALL ');Add(AccountSummary('F'  , '8'   , 'Accounttype' , 'Total COGS'      ,'""'         ,'0'            , '"COGS"'                               , '"COGS"'     ));Add('UNION ALL ');Add(BlankLine(9))  ;
    Add('UNION ALL ');Add(AccountSummary('T'  , '10'  , '""'          , 'Gross Profit'    ,'""'         ,'0'            , '"COGS", "EXINC","INC"'                , 'FinalOrder' ));Add('UNION ALL ');Add(BlankLine(11)) ;Add('UNION ALL ');Add(BlankLine(12,'EXP', 'Expense' ));
    Add('UNION ALL ');Add(AccountSummary('F'  , '13'  , 'AccountType' , ''                ,'Accounts'   ,'AccountId'    , '"EXEXP","EXP"  '                      , 'Accounts'   ));
    Add('UNION ALL ');Add(AccountSummary('F'  , '14'  , '"EXP"'       , 'Total Expenses'  ,'""'         ,'0'            , '"EXEXP","EXP" '                       , '"EXP"'      ));Add('UNION ALL ');Add(BlankLine(15)) ;
    Add('UNION ALL ');Add(AccountSummary('T'  , '16'  , '"NI"'        , 'Net Income'      ,'""'         ,'0'            , '"EXEXP","EXP"  ,"EXINC", "INC", "COGS"' , 'FinalOrder'));
    Add('UNION ALL ');AdD(AccountSummary('T'  , ''    , '""'          , ''                ,'Concat("Total ",Level1,"")'                   ,'0','','AccountHeaderOrder'                  , '"ZZZZZZZZZZZZ"'  , '"ZZZZZZZZZZZZ"'    , '"ZZZZZZZZZZZZ"'  ,' and (AccountName <> Level1)                                                          and char_length(Level1)>0  And TotalAmount<>0.00 ' , 'If( char_length(Max(Level2))>0 ,"T","F")' ));
    Add('Union All ');Add(AccountSummary('T'  , ''    , '""'          , ''                ,'Concat(Space(5),Concat("Total ",Level2,""))'  ,'0','','AccountType,Concat(Space(5),Level2)' , 'AccountSub1Order', '"ZZZZZZZZZZZZ"'    , '"ZZZZZZZZZZZZ"'  ,' and (AccountName <> Level1)  And (AccountName <> Level2)                             And char_length(Level2)>0  And TotalAmount<>0.00 ' , 'If( char_length(Max(Level3))>0 ,"T","F")'));
    Add('Union All ');Add(AccountSummary('F'  , ''    , '""'          , ''                ,'Concat(Space(10),Concat("Total ",Level3,""))' ,'0','','AccountType,Concat(Space(10),Level3)', 'AccountSub1Order', 'AccountSub2Order'  , '"ZZZZZZZZZZZZ"'  ,' and (AccountName <> Level1)  And (AccountName <> Level2) And (AccountName <> Level3) And char_length(Level3)>0  And TotalAmount<>0.00 ' , 'If( char_length(Max(Level4))>0 ,"T","F")'));
  end;

end;*)

function TReportSQLProfitAndLossPeriod.ReportDetailsforTable: string;
begin
    result:= '';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + BlankLine(2,'INC', 'Income' )+';';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '3'   , '"INC"'       , ''                ,'Accounts'   ,'AccountID'    , '"EXINC","INC"'                        , 'Accounts'   )+';' + #13#10;
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '4'   , '"INC"'       , 'Total Income'    ,'""'         , '0'           , '"EXINC","INC"'                        , '"INC"'      )+';' + #13#10;
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + BlankLine(5)+';' + #13#10;
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + BlankLine( 6,'COGS', 'Cost of Goods Sold' )+';' + #13#10;
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '7'   , '"COGS"'      , ''                ,'Accounts'   ,'AccountId'    , '"COGS"'                               , 'Accounts'   )+';' + #13#10;
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '8'   , 'Accounttype' , 'Total COGS'      ,'""'         ,'0'            , '"COGS"'                               , '"COGS"'     )+';' + #13#10;
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + BlankLine(9)+';' + #13#10;
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('T'  , '10'  , '""'          , 'Gross Profit'    ,'""'         ,'0'            , '"COGS", "EXINC","INC"'                , 'FinalOrder' )+';' + #13#10;
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + BlankLine(11)+';' + #13#10;
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + BlankLine(12,'EXP', 'Expense' )+';' + #13#10;
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '13'  , 'AccountType' , ''                ,'Accounts'   ,'AccountId'    , '"EXEXP","EXP"  '                      , 'Accounts'   )+';' + #13#10;
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '14'  , '"EXP"'       , 'Total Expenses'  ,'""'         ,'0'            , '"EXEXP","EXP" '                       , '"EXP"'      )+';' + #13#10;
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + BlankLine(15)+';' + #13#10;
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('T'  , '16'  , '"NI"'        , 'Net Income'      ,'""'         ,'0'            , '"EXEXP","EXP"  ,"EXINC", "INC", "COGS"' , 'FinalOrder')+';' + #13#10;
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('T'  , ''    , '""'          , ''                ,'Concat("Total ",Level1,"")'                   ,'0','','AccountHeaderOrder'                  , '"ZZZZZZZZZZZZ"'  , '"ZZZZZZZZZZZZ"'    , '"ZZZZZZZZZZZZ"'  ,' and (AccountName <> Level1)                                                          and char_length(Level1)>0  And TotalAmount<>0.00 ' , 'If( char_length(Max(Level2))>0 ,"T","F")' )+';' + #13#10;
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('T'  , ''    , '""'          , ''                ,'Concat(Space(5),Concat("Total ",Level2,""))'  ,'0','','AccountType,Concat(Space(5),Level2)' , 'AccountSub1Order', '"ZZZZZZZZZZZZ"'    , '"ZZZZZZZZZZZZ"'  ,' and (AccountName <> Level1)  And (AccountName <> Level2)                             And char_length(Level2)>0  And TotalAmount<>0.00 ' , 'If( char_length(Max(Level3))>0 ,"T","F")')+';' + #13#10;
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , ''    , '""'          , ''                ,'Concat(Space(10),Concat("Total ",Level3,""))' ,'0','','AccountType,Concat(Space(10),Level3)', 'AccountSub1Order', 'AccountSub2Order'  , '"ZZZZZZZZZZZZ"'  ,' and (AccountName <> Level1)  And (AccountName <> Level2) And (AccountName <> Level3) And char_length(Level3)>0  And TotalAmount<>0.00 ' , 'If( char_length(Max(Level4))>0 ,"T","F")')+';' + #13#10;
end;
Function TReportSQLProfitAndLossBase.BlankLine(FinalOrder :Integer; AccountType:String = ''; accountTypeDesc:String = ''):String;
begin
      Result:= ' SELECT "T" as HidePercentage, 0 as AccountID,';
      result:= result + '  ' +quotedStr(AccountType) +' as AccountType,';
      result:= result + '  ' +quotedStr(AccountTypedesc) +' as "AccountTypeDesc",';
      result:= result + ' "" as  AccountName,';
      result:= result + '  ' +AddAmountfields(True, False );
      result:= result + '  ' +IntToStr(FinalOrder) + ' As FinalOrder,"" as AccountHeaderOrder,"" as AccountSub1Order,"" as AccountSub2Order,"" as AccountSub3Order,"T" as HideTotal ';
      result:= result + ' FROM tblCompanyInformation AS CO ';
end;
Function  TReportSQLProfitAndLossBase.AddAmountfields(isZero:Boolean; isSum:Boolean ;  isnegativePercent:Boolean = False; accountType:String = ''; whereCaluse:String = ''):String;
var
  ColumnCount,x:Integer;
  pColumn: pColumnRec;

  function GetTotal(i:Integer):String ;
  begin
    result := 'Select Sum(ifnull(Perc.Amount_' +IntToStr(i)+',0)) from ' + Temptablename +' as Perc where  Perc.Date Between "' + FormatDateTime(MysqlDateFormat, DateFrom) + '" AND "' + FormatDateTime(MysqlDateFormat, DateTo) + '"  ';
    if accounttype <> '' then result := result + ' and Perc.accountType in  (' +accountType+') ';
    if whereCaluse <> '' then result := result + whereCaluse;
    result := 'sum(ifnull(Amount_' +IntToStr(i)+',0))/(' + result + ')';
  end;

begin
  result:= '';
  ColumnCount := LstColumn.Count - 1;
    for x := 0 to ColumnCount do begin
      pColumn := LstColumn.Items[x];
      result:= result + '  ' + AddFCFieldsToSQL(pColumn^.ColumnNo, isZero);
      result:= result + '  ' + AddtotalFCField(isZero);
      if isZero then begin
        result:= result + ' 0 as Amount_' +IntToStr(pColumn^.ColumnNo) + ',';
        result:= result + ' Space(100) as Percentage_' +IntToStr(pColumn^.ColumnNo) + ',';
      end else begin
        result:= result + '  ' +PercentCalc(' Sum(Amount_' +IntToStr(pColumn^.ColumnNo) + ')')+' as Amount_' +IntToStr(pColumn^.ColumnNo) + ',';
        if isnegativePercent then
          result:= result + '   if(Sum(Amount_' +IntToStr(pColumn^.ColumnNo) + ')=0, "" ,  concat(ROUND(-100*'+ getTotal(pColumn^.ColumnNo) +',1), "%"))  as Percentage_' +IntToStr(pColumn^.ColumnNo) + ','
        else
          result:= result + '   if(Sum(Amount_' +IntToStr(pColumn^.ColumnNo) + ')=0, "" , concat(ROUND(100*'+ getTotal(pColumn^.ColumnNo)+',1) , "%"))  as Percentage_' +IntToStr(pColumn^.ColumnNo) + ',';
      end;

      if x > 0 then begin
        result:= result + ' 0 as Change_' +IntToStr(pColumn^.ColumnNo) + ',';
        result:= result + ' 0 as ChangePercent_' +IntToStr(pColumn^.ColumnNo) + ',';
      end;
      result:= result + '  ' +BudgetFields(pcolumn^.columnNo, isZero, isSum);
      result:= result + '  ' +Accountfields(pcolumn, isZero, isSum);

    end;
    result:= result + '  ' +BlankColumns( columncount, QuotedStr('0%'));
    if isZero then result:= result + '  0 as TotalAmount, ' else result:= result + '  ' +PercentCalc(' Sum(TotalAmount)')+' as TotalAmount, ';
end;
function TReportSQLProfitAndLossBase.PercentCalc(const fFieldname:String):String ;
begin
  if amtPercent <> 0 then begin
    if AppEnvVirt.Bool['CompanyPrefs.ZerotaxWhenLoss'] then begin
      if amtPercent = AppEnvVirt.Float['CompanyPrefs.IncomeTaxPercentage'] then {income tax should be 0}
        Result  := 'if(ifnull('+fFieldname +',0) <=0 , 0 , '+fFieldname  + ' * ' +floatToStr(amtPercent)+'/100)'
      else {after tax should be same as before tax as there will not be any tax}
        Result  := 'if(ifnull('+fFieldname +',0) <=0 , '+fFieldname  + ' , '+fFieldname  + ' * ' +floatToStr(amtPercent)+'/100)';
    end else begin
      Result  := fFieldname + ' * ' +floatToStr(amtPercent)+'/100';
    end;
  end else begin
    Result  := fFieldname;
  end;
end;

(*function TReportSQLProfitAndLossBase.PopulateReportSQL(SQL: TStrings;
  var msg: string): boolean;
begin
  Prepareforreport;
    SQL.Clear;
    SQL.add('Select * from ' + Qrymaintablename+' where HideTotal ="T"' +
            ' Order By FinalOrder,AccountHeaderOrder,AccountSub1Order,AccountSub2Order ,AccountSub3Order,TotalAmount; ');

end;*)

Function TReportSQLProfitAndLossBase.AddtotalFCField(AmountZero :Boolean = False ):String ;
begin
  REsult:= '';
  if FConReport.RecordCount > 0 then begin
      FCOnReport.First;
      while FConReport.Eof = False do begin
          if AmountZero then
              result:= result + '  0 as ' + FCOnReport.FieldByname('Code').asString + '_totalAmount,'
          else
              result:= result + ' sum(' + FCOnReport.FieldByname('Code').asString + '_totalAmount),';
          FCOnReport.Next;
      End;
  End;
end;


Function TReportSQLProfitAndLossBase.AccountSummary(HidePercentage:string  ; finalOrder:String ;
        Accttype:String; accountTypeDesc :STring;AccountName:String;AccountID:String ;
        accountTypes:String; groupby:String;
        AccountSub1Order:String ='AccountSub1Order';AccountSub2Order:String ='AccountSub2Order'; AccountSub3Order:String ='AccountSub3Order'; whereCaluse:String = ''; Hidetotal :String = '"T"';
        ExcludeAccountIDs :String = ''; IcludeAccountIDs:String = ''):string;
begin
      Result:= '';
      result:= result + ' SELECT ' +QuotedStr(HidePercentage) +' as HidePercentage,';
      result:= result + '  ' +AccountID +' as AccountID, ';
      result:= result + '  ' +Accttype +'  as AccountType,';
      result:= result + '  ' +QuotedStr(accountTypeDesc) +' as "AccountTypeDesc",'+AccountName +' as Accounts, ';
      result:= result + '  ' +AddAmountfields(False, TRue,False,  accountTypes, whereCaluse);
      if finalorder = '' then finalorder := 'IF((AccountType = "EXINC" OR AccountType = "INC"),3,IF((AccountType = "COGS"),7,13))';
      result:= result + '  ' +FinalOrder + ' As FinalOrder,';
      result:= result + ' AccountHeaderOrder,';
      result:= result + '  ' +AccountSub1Order+' as AccountSub1Order,';
      result:= result + '  ' +AccountSub2Order+' as AccountSub2Order,';
      result:= result + '  ' +AccountSub3Order+' as AccountSub3Order,' + Hidetotal+' as HideTotal ';
      result:= result + ' FROM ' + Temptablename ;
      result:= result + ' Where Date Between "' + FormatDateTime(MysqlDateFormat, DateFrom) + '" AND "' + FormatDateTime(MysqlDateFormat, DateTo) + '" ';
      if accountTypes <> '' then result:= result + '  and (AccountType in (' +accountTypes+') )  ';
      if IcludeAccountIDs <> '' then result:= result + '  and AccountID in (' +IcludeAccountIDs+')';
      if ExcludeAccountIDs <> '' then result:= result + ' and  not(AccountID in (' +ExcludeAccountIDs+'))';
      result:= result + '  ' +whereCaluse;
      result:= result + ' Group By '+Groupby;
end;
Function TReportSQLProfitAndLossBase.FCFieldsForTable(ColumnNo :Integer):String ;
begin
  Result  := '';
  if FConReport.RecordCount > 0 then begin
      FCOnReport.First;
      while FConReport.Eof = False do begin
              Result  := Result  + FCOnReport.FieldByname('Code').asString+ '_Amount_' +IntToStr(Columnno) + ' Double,';
              Result  := Result  + FCOnReport.FieldByname('Code').asString+ '_Amount1_' +IntToStr(Columnno) + ' Double,';
              Result  := Result  + FCOnReport.FieldByname('Code').asString+ '_Amount1_v' +IntToStr(Columnno) + ' Double,';
              Result  := Result  + FCOnReport.FieldByname('Code').asString+ '_Amount2_' +IntToStr(Columnno) + ' Double,';
              Result  := Result  + FCOnReport.FieldByname('Code').asString+ '_Amount2_v' +IntToStr(Columnno) + ' Double,';
          FCOnReport.Next;
      End;
  End;
end;
function TReportSQLProfitAndLossBase.BudgetFields(const Value: Integer; isZero:Boolean; isSum: Boolean):String;
  function sum:STring ; begin result := ''; if issum then result:= 'Sum';end;
begin
  With TStringList.create do try
    if ISBudgetSelected then begin
      if isZero then begin
        Add('0  as Amount1_' +IntToStr(Value) + ',');
        Add('0  as Amount1_v' +IntToStr(Value) + ',');
        Add('0  as Amount2_' +IntToStr(Value) + ',');
        Add('0  as Amount2_v' +IntToStr(Value) + ',');
      end else begin
        Add(sum +'(Amount1_' +IntToStr(Value) + ') as Amount1_' +IntToStr(Value) + ',');
        Add(sum+ '(Amount1_v' +IntToStr(Value) + ') as Amount1_v' +IntToStr(Value) + ',');
        Add(sum +'(Amount2_' +IntToStr(Value) + ') as Amount2_' +IntToStr(Value) + ',');
        Add(Sum +'(Amount2_v' +IntToStr(Value) + ') as Amount2_v' +IntToStr(Value) + ',');
      end;
    end;
    Result := Text;
  finally
      Free;
  end;
end;


function TReportSQLProfitAndLossBase.Accountfields(const Value: pColumnRec; isZero:Boolean; isSum: Boolean):String;
begin
  result:= '';
  With QryAccounts do
      if recordcount >0 then begin
        first;
        While eof =False do begin
          (*if isZero then begin
            result:= result + '  0 as `' + AccnameFldName(fieldbyname('Description').asString , Value^.columnNo) + '_amt` '+ ',';
          end else begin
            fd:=AccountAmtforPeriod(fieldbyname('AccountID').asInteger, Value^.ColumnFrom, Value^.ColumnTo);
            result:= result +  floatTostr(fd) +   '   as `' + AccnameFldName(fieldbyname('Description').asString , Value^.columnNo) + '_amt` '+ ',';
          end;*)
          result:= result + '  0 as `' + AccnameFldName(fieldbyname('Description').asString , Value^.columnNo, QryAccounts.recno) + '_amt` '+ ',';
          result:= result + '  0 as `' + AccnameFldName(fieldbyname('Description').asString , Value^.columnNo, QryAccounts.recno) + '_Percent` '+ ',';
          Next;
        end;
      end;
end;

{function TReportSQLProfitAndLossBase.AccountAmtforPeriod(const TableID:Integer; Colno :Integer): Double;
var
  s:String;
begin
  (*s:= ' SELECT ' +
      ' sum(T.CreditsEx - T.DebitsEx) as exAmt, ' +
      ' sum(T.CreditsInc - T.DebitsInc) as incAmt ' +
      ' from tbltransactions  T  ' +
      ' where T.Accountid = ' +  inttostr(AccountID)+' and Date between ' +Quotedstr(FormatDateTime(MYSQLDateTimeformat, dtfrom))+ ' and  ' +Quotedstr(FormatDateTime(MYSQLDateTimeformat, dtTo));*)
  s:= 'Select amount_'+trim(inttostr(Colno))+' as Amount from '+qrymaintablename +' where id = ' + inttostr(TableID);

  if fQryAccountAmtforPeriod = nil then fQryAccountAmtforPeriod := TempMyquery;

  if not(Sametext(trim(s), trim(fQryAccountAmtforPeriod.SQL.text))) then begin
    if fQryAccountAmtforPeriod.active then fQryAccountAmtforPeriod.close;
    fQryAccountAmtforPeriod.SQL.text := s;
  end;

  if fQryAccountAmtforPeriod.active =False then fQryAccountAmtforPeriod.open;
  result := fQryAccountAmtforPeriod.fieldbyname('Amount').asFloat;
end;   }

function TReportSQLProfitAndLossBase.Blankcolumns(amountCols:Integer; PercentValue:String): String;
var
  I:Integer;
begin
  result := '';
    if amountCols < 20 - 1 then
        for I := amountCols   + 2 to 20 do begin
            result:= result + ' 0 as Amount_'  + IntToStr(I) + ',';
            result:= result + '  ' +PercentValue    + ' as Percentage_' +IntToStr(I) + ',';
            IF ISBudgetSelected then begin
              result:= result + ' 0 as Amount1_' + IntToStr(I) + ',';
              result:= result + ' 0 as Amount1_v'+ IntToStr(I) + ',';
              result:= result + ' 0 as Amount2_' + IntToStr(I) + ',';
              result:= result + ' 0 as Amount2_v'+ IntToStr(I) + ',';
          end;
          With QryAccounts do
            if recordcount >0 then begin
              First;
              While Eof = False do begin
                Result  := Result   +'0 as `' + AccnameFldName(QryAccounts.fieldbyname('Description').asString , I, QryAccounts.recno) + '_amt` ,';
                Result  := Result   +'0 as `' + AccnameFldName(QryAccounts.fieldbyname('Description').asString , I, QryAccounts.recno) + '_Percent`,';
                Next;
              end;
            end;
        end;
end;

{ TReportSQLIncomeandExpenditure }


constructor TReportSQLIncomeandExpenditure.Create(Aowner: TComponent);
begin
  inherited;
  SelectedIDs:= '';
end;

procedure TReportSQLIncomeandExpenditure.initTablename;
begin
  inherited;
  BaseTemptablename := '';
  ReportClassName   := 'TIncomeandExpenditureGUI';
  TempTablename     := 'tmp_IncomeExp_' + GetMachineIdentification(true, true, true, true);
  Qrymaintablename  := 'tmp_IncomeExp_' + ReportClassName + '_' + GetMachineIdentification(true, true, true, true);;
  TransTableName    := TempTableUtils.CreateUserTemporaryTable(GetSharedMyDacConnection, TABLE_PROFITANDLOSSREPORT , 'period' );
end;

function TReportSQLIncomeandExpenditure.reportCaption: String;
begin
  Result:= 'Income and Expenditure Report';
end;

function TReportSQLIncomeandExpenditure.ReportDetailsforTable: string;
begin
  Result := '';
  inherited;
  Result := 'insert into ' +Qrymaintablename + ' '  + BlankLine(2,'INC', 'Income' )+';';
  selectedIDS := '';
  Result:= Result + IncomeExpenseConfigAccountsSQL;
  Result := Result+ 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '4'   , '"INC"'       , 'Total Income'    ,'""'         , '0'           , '"EXINC","INC"'                        , '"INC"'      )+';';
  Result:= Result+ 'INSERT INTO ' +Qrymaintablename + ' '  +  BlankLine( 6,'COGS', 'Cost of Goods Sold' )+';';
  selectedIDS := '';
  Result:= Result + COGSConfigAccountsSQL;
  Result := Result+ 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '8'   , 'Accounttype' , 'Total COGS'      ,'""'         ,'0'            , '"COGS"'                               , '"COGS"'     )+';';
  Result := Result+ 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('T'  , '10'  , '""'          , 'Gross Profit'    ,'""'         ,'0'            , '"COGS", "EXINC","INC"'                , 'FinalOrder' )+';';
  Result := Result+ 'INSERT INTO ' +Qrymaintablename + ' '  + BlankLine(12,'EXP', 'Expense' )+';';
  selectedIDS := '';
  Result:= Result + ExpenseConfigAccountsSQL;
  Result := Result+ 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '14'  , '"EXP"'       , 'Total Expenses'  ,'""'         ,'0'            , '"EXEXP","EXP" '                       , '"EXP"'      )+';';
  Result := Result+ 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('T'  , '16'  , '"NI"'        , 'Net Income (Before Tax)'      ,'""'         ,'0'            , '"EXEXP","EXP"  ,"EXINC", "INC", "COGS"' , 'FinalOrder')+';';
  amtPercent := system.round(AppEnvVirt.float['CompanyPrefs.IncomeTaxPercentage']);
  Result := Result+ 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('T'  , '17'  , '"IT"'        , '    Income Tax('+floatToStr(AppEnvVirt.float['CompanyPrefs.IncomeTaxPercentage'])+'%)'      ,'""'         ,'0'            , '"EXEXP","EXP"  ,"EXINC", "INC", "COGS"' , 'FinalOrder')+';';
  amtPercent := 100-system.round(AppEnvVirt.float['CompanyPrefs.IncomeTaxPercentage']);
  Result := Result+ 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('T'  , '18'  , '"NI"'        , 'Net Income(After Tax)'      ,'""'         ,'0'            , '"EXEXP","EXP"  ,"EXINC", "INC", "COGS"' , 'FinalOrder')+';';
  amtPercent :=0;
end;

function TReportSQLIncomeandExpenditure.ExpenseConfigAccountsSQL:String;
var
  Ids:String;
  strSQL:String;
begin
  strSQL :='';
    With tempMyquery do try
      SQL.Add('SELECT * FROM tblSelectedAccountsforReprots where  accounttype  in (' + QuotedStr('EXP')+')' );
      open;
      if recordcount >0 then begin
        SelectedIDs := '';
        first ;
        while eof = False do begin
          if sametext(FieldByname('Accountname').AsString , 'Others') then
          else if Fieldbyname('AccountID').asInteger = 0 then else
          Ids:=AllAccountIds(FieldByname('Accountname').AsString);
          if selectedIDS<> '' then SelectedIDs :=SelectedIDs + ',';
          SelectedIDs :=SelectedIDs + Ids;
(*           with fStringListForSQL do begin
              Add('UNION ALL ');Add(AccountSummary('F' , '13'  , 'AccountType' , ''                ,QuotedStr(TSelectedAccountsforReports(Sender).Accountname)   ,QuotedStr(IntToStr(TSelectedAccountsforReports(Sender).AccountId ))  , '"EXEXP","EXP"  '                      , QuotedStr(TSelectedAccountsforReports(Sender).Accountname)   ,  'AccountSub1Order' , 'Accountsub2Order' , 'AccountSub3Order ' , '' , '"T"' , '' , Ids));
           end;*)
          Next;
        end;
            strSQL := strSQL+ 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '13.1'  , '"EXP"' , ''                ,'"Others"'   ,'0'    , '"EXEXP","EXP"  '                , '"EXP"'   ,  'AccountSub1Order' , 'Accountsub2Order' , 'AccountSub3Order ' , '' , '"T"' , SelectedIDs)+';';
      end else begin
            strSQL := strSQL+ 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '13'  , 'AccountType' , ''                ,'Accounts'   ,'AccountId'    , '"EXEXP","EXP"  '                      , 'Accounts'   )+';';
      end;
    finally
      ClosenFree;
    end;
    Result := strSQL;
end;

function TReportSQLIncomeandExpenditure.getTemplateSQL: String;
begin
  REsult:= ReportSQL ;
  exit;
  (*ReportDetails;
  REsult:= fStringListForSQL.TExt;*)
end;

function TReportSQLIncomeandExpenditure.COGSConfigAccountsSQL:String;
var
  Ids:String;
  strSQL:String;
begin
  strSQL :='';
    With tempMyquery do try
      SQL.Add('SELECT * FROM tblSelectedAccountsforReprots where  accounttype  in (' + QuotedStr('COGS')+')' );
      open;
      if recordcount >0 then begin
        SelectedIDs := '';
        first ;
        while eof = False do begin
          if sametext(FieldByname('Accountname').AsString , 'Others') then
          else if Fieldbyname('AccountID').asInteger = 0 then else
          Ids:=AllAccountIds(FieldByname('Accountname').AsString);
          if selectedIDS<> '' then SelectedIDs :=SelectedIDs + ',';
          SelectedIDs :=SelectedIDs + Ids;
(*           with fStringListForSQL do begin
            Add('UNION ALL ');Add(AccountSummary('F', '7'   , '"COGS"'      , ''                ,QuotedStr(TSelectedAccountsforReports(Sender).Accountname)   ,QuotedStr(IntToStr(TSelectedAccountsforReports(Sender).AccountId )) , '"COGS"'                               , QuotedStr(TSelectedAccountsforReports(Sender).Accountname)   ,  'AccountSub1Order' , 'Accountsub2Order' , 'AccountSub3Order ' , '' , '"T"' , '' , Ids));
           end;*)
          Next;
        end;
        strSQL := strSQL+ 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '7.1'   , '"COGS"'      , ''                ,'"Others"'   ,'0'    , '"COGS"'                         , '"COGS"'   ,  'AccountSub1Order' , 'Accountsub2Order' , 'AccountSub3Order ' , '' , '"T"' ,  SelectedIDs)+';';
      end else begin
        strSQL := strSQL+ 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '7'   , '"COGS"'      , ''                ,'Accounts'   ,'AccountId'    , '"COGS"'                               , 'Accounts'   )+';';
      end;
    finally
      ClosenFree;
    end;
    Result:= strSQL;
end;
function TReportSQLIncomeandExpenditure.IncomeExpenseConfigAccountsSQL:String;
var
  Ids:String;
  strSQL:String;
begin
  strSQL :='';
    With tempMyquery do try
      SQL.Add('SELECT * FROM tblSelectedAccountsforReprots where  accounttype  in (' + QuotedStr('INC')+')' );
      open;
      if recordcount >0 then begin
        SelectedIDs := '';
        first ;
        while eof = False do begin
          if sametext(FieldByname('Accountname').AsString , 'Others') then
          else if Fieldbyname('AccountID').asInteger = 0 then else
          Ids:=AllAccountIds(FieldByname('Accountname').AsString);
          if selectedIDS<> '' then SelectedIDs :=SelectedIDs + ',';
          SelectedIDs :=SelectedIDs + Ids;
(*           with fStringListForSQL do begin
            Add('UNION ALL ');Add(AccountSummary('F', '3'   , '"INC"'       , ''                ,QuotedStr(TSelectedAccountsforReports(Sender).Accountname)   ,QuotedStr(IntToStr(TSelectedAccountsforReports(Sender).AccountId )) , '"EXINC","INC"'                        , QuotedStr(TSelectedAccountsforReports(Sender).Accountname)   , 'AccountSub1Order' , 'Accountsub2Order' , 'AccountSub3Order ' , '' , '"T"' , '' , Ids));
           end;*)

          Next;
        end;
        strSQL := strSQL + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F', '3.1'   , '"INC"'       , ''                ,'"Others"'   ,'0'    , '"EXINC","INC"'                  , '"INC"'   , 'AccountSub1Order' , 'Accountsub2Order' , 'AccountSub3Order ' , '' , '"T"' ,  SelectedIDs)+';';
      end else begin
        strSQL := strSQL + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '3'   , '"INC"'       , ''                ,'Accounts'   ,'AccountID'    , '"EXINC","INC"'                        , 'Accounts'   )+';';
      end;
    finally
      ClosenFree;
    end;
    REsult:= strSQL;
end;

function TReportSQLIncomeandExpenditure.AllAccountIds(const Accountname :String): String;
var
  strSQL:String;
begin
  strSQL:= 'Select AccountID  from tblchartofaccounts ' +
            ' where AccountName ='+QuotedStr(Accountname) +
            ' or Level1 = '+QuotedStr(Accountname) +
            ' or Level2 = '+QuotedStr(Accountname) +
            ' or LEVEL3 = '+QuotedStr(Accountname) +
            ' or Level4 = '+QuotedStr(Accountname) ;
  With TempMyquery do try
    SQL.Add(strSQL);
    open;
    Result := groupconcat('accountIDs');
    //Result := FieldByname('accountIDs').asString;
  finally
      if active then close;
      Free;
  end;
end;

(*procedure TReportSQLIncomeandExpenditure.ReportDetails;
begin
  inherited;
    fStringListForSQL.Clear;
      with fStringListForSQL do begin
        Add(BlankLine(2,'INC', 'Income' ));
        selectedIDS := '';
        add(IncomeExpenseConfigAccountsSQL);
        Add('UNION ALL ');Add(AccountSummary('F'  , '4'   , '"INC"'       , 'Total Income'    ,'""'         , '0'           , '"EXINC","INC"'                        , '"INC"'      ));
        Add('UNION ALL ');Add(BlankLine( 6,'COGS', 'Cost of Goods Sold' ));
        selectedIDS := '';
        add(IncomeExpenseConfigAccountsSQL);

        Add('UNION ALL ');Add(AccountSummary('F'  , '8'   , 'Accounttype' , 'Total COGS'      ,'""'         ,'0'            , '"COGS"'                               , '"COGS"'     ));
        Add('UNION ALL ');Add(AccountSummary('T'  , '10'  , '""'          , 'Gross Profit'    ,'""'         ,'0'            , '"COGS", "EXINC","INC"'                , 'FinalOrder' ));
        Add('UNION ALL ');Add(BlankLine(12,'EXP', 'Expense' ));
        selectedIDS := '';
        add(IncomeExpenseConfigAccountsSQL);
        Add('UNION ALL ');Add(AccountSummary('F'  , '14'  , '"EXP"'       , 'Total Expenses'  ,'""'         ,'0'            , '"EXEXP","EXP" '                       , '"EXP"'      ));
        Add('UNION ALL ');Add(AccountSummary('T'  , '16'  , '"NI"'        , 'Net Income (Before Tax)'      ,'""'         ,'0'            , '"EXEXP","EXP"  ,"EXINC", "INC", "COGS"' , 'FinalOrder'));

        amtPercent :=system.Round(AppEnvVirt.float['CompanyPrefs.IncomeTaxPercentage']);
        Add('UNION ALL ');Add(AccountSummary('T'  , '17'  , '"IT"'        , '    Income Tax('+floatToStr(AppEnvVirt.float['CompanyPrefs.IncomeTaxPercentage'])+'%)'      ,'""'         ,'0'            , '"EXEXP","EXP"  ,"EXINC", "INC", "COGS"' , 'FinalOrder'));
        amtPercent := 100-system.Round(AppEnvVirt.float['CompanyPrefs.IncomeTaxPercentage']);
        Add('UNION ALL ');Add(AccountSummary('T'  , '18'  , '"NI"'        , 'Net Income(After Tax)'      ,'""'         ,'0'            , '"EXEXP","EXP"  ,"EXINC", "INC", "COGS"' , 'FinalOrder'));
        amtPercent :=0;
      end;
end;*)

{ TProfitandLossPeriodCompare }

constructor TProfitandLossPeriodCompare.Create(Aowner: TComponent);
begin
  inherited;
end;

function TProfitandLossPeriodCompare.ExtraProcessSQL: String;
begin
  result:=AccountComparePercent;
end;

function TProfitandLossPeriodCompare.getTemplateSQL: String;
begin
  REsult:= ReportSQL ;
  exit;
  (*ReportDetails;
  REsult:= fStringListForSQL.TExt;*)
end;

procedure TProfitandLossPeriodCompare.initTablename;
begin
  inherited;
  BaseTemptablename := TABLE_PROFITANDLOSSREPORT;
  ReportClassName   := 'TProfitandLossPeriodCompareGUI';
  TempTablename     := 'tmp_PLC_' + GetMachineIdentification(true, true, true, true);
  Qrymaintablename  := 'tmp_PLC_' + ReportClassName + '_' + GetMachineIdentification(true, true, true, true);;
  TransTableName    := TempTableUtils.CreateUserTemporaryTable(GetSharedMyDacConnection, TABLE_PROFITANDLOSSREPORT , 'period' );
end;

function TProfitandLossPeriodCompare.reportCaption: String;
begin
  Result:= 'Profit and Loss Comparison Report';

end;

(*procedure TProfitandLossPeriodCompare.ReportDetails;
begin
  fStringListForSQL.Clear;
  with fStringListForSQL do begin
    Add(BlankLine(2,'INC', 'Income' ));
    Add('UNION ALL ');Add(AccountSummary('F'  , '3'   , '"INC"'       , ''                ,'Accounts'   ,'AccountID'    , '"EXINC","INC"'                        , 'Accounts'   ));
    Add('UNION ALL ');Add(AccountSummary('F'  , '4'   , '"INC"'       , 'Total Income'    ,'""'         , '0'           , '"EXINC","INC"'                        , '"INC"'      ));Add('UNION ALL ');Add(BlankLine(5))  ;Add('UNION ALL ');Add(BlankLine( 6,'COGS', 'Cost of Goods Sold' ));
    Add('UNION ALL ');Add(AccountSummary('F'  , '7'   , '"COGS"'      , ''                ,'Accounts'   ,'AccountId'    , '"COGS"'                               , 'Accounts'   ));
    Add('UNION ALL ');Add(AccountSummary('F'  , '8'   , 'Accounttype' , 'Total COGS'      ,'""'         ,'0'            , '"COGS"'                               , '"COGS"'     ));Add('UNION ALL ');Add(BlankLine(9))  ;
    Add('UNION ALL ');Add(AccountSummary('T'  , '10'  , '""'          , 'Gross Profit'    ,'""'         ,'0'            , '"COGS", "EXINC","INC"'                , 'FinalOrder' ));Add('UNION ALL ');Add(BlankLine(11)) ;Add('UNION ALL ');Add(BlankLine(12,'EXP', 'Expense' ));
    Add('UNION ALL ');Add(AccountSummary('F'  , '13'  , 'AccountType' , ''                ,'Accounts'   ,'AccountId'    , '"EXEXP","EXP"  '                      , 'Accounts'   ));
    Add('UNION ALL ');Add(AccountSummary('F'  , '14'  , '"EXP"'       , 'Total Expenses'  ,'""'         ,'0'            , '"EXEXP","EXP" '                       , '"EXP"'      ));Add('UNION ALL ');Add(BlankLine(15)) ;
    Add('UNION ALL ');Add(AccountSummary('T'  , '16'  , '"NI"'        , 'Net Income'      ,'""'         ,'0'            , '"EXEXP","EXP"  ,"EXINC", "INC", "COGS"' , 'FinalOrder'));
    Add('UNION ALL ');AdD(AccountSummary('T'  , ''    , '""'          , ''                ,'Concat("Total ",Level1,"")'                   ,'0','','AccountHeaderOrder'                  , '"ZZZZZZZZZZZZ"'  , '"ZZZZZZZZZZZZ"'    , '"ZZZZZZZZZZZZ"'  ,' and (AccountName <> Level1)                                                          and char_length(Level1)>0  And TotalAmount<>0.00 ' , 'If( char_length(Max(Level2))>0 ,"T","F")' ));
    Add('Union All ');Add(AccountSummary('T'  , ''    , '""'          , ''                ,'Concat(Space(5),Concat("Total ",Level2,""))'  ,'0','','AccountType,Concat(Space(5),Level2)' , 'AccountSub1Order', '"ZZZZZZZZZZZZ"'    , '"ZZZZZZZZZZZZ"'  ,' and (AccountName <> Level1)  And (AccountName <> Level2)                             And char_length(Level2)>0  And TotalAmount<>0.00 ' , 'If( char_length(Max(Level3))>0 ,"T","F")'));
    Add('Union All ');Add(AccountSummary('F'  , ''    , '""'          , ''                ,'Concat(Space(10),Concat("Total ",Level3,""))' ,'0','','AccountType,Concat(Space(10),Level3)', 'AccountSub1Order', 'AccountSub2Order'  , '"ZZZZZZZZZZZZ"'  ,' and (AccountName <> Level1)  And (AccountName <> Level2) And (AccountName <> Level3) And char_length(Level3)>0  And TotalAmount<>0.00 ' , 'If( char_length(Max(Level4))>0 ,"T","F")'));
  end;

end;*)

function TProfitandLossPeriodCompare.ReportDetailsforTable: string;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    sl.Add('insert into ' +Qrymaintablename + ' '  + BlankLine(2,'INC', 'Income' )+';');
    sl.Add('insert into ' +Qrymaintablename + ' '  + AccountSummary('F'  , '3'   , '"INC"'       , ''                ,'Accounts'   ,'AccountID'    , '"EXINC","INC"'                        , 'Accounts'   )+';');
    sl.Add('insert into ' +Qrymaintablename + ' '  + AccountSummary('F'  , '4'   , '"INC"'       , 'Total Income'    ,'""'         , '0'           , '"EXINC","INC"'                        , '"INC"'      )+';');
    sl.Add('insert into ' +Qrymaintablename + ' '  + BlankLine(5)+';');
    sl.Add('insert into ' +Qrymaintablename + ' '  + BlankLine( 6,'COGS', 'Cost of Goods Sold' )+';');
    sl.Add('insert into ' +Qrymaintablename + ' '  + AccountSummary('F'  , '7'   , '"COGS"'      , ''                ,'Accounts'   ,'AccountId'    , '"COGS"'                               , 'Accounts'   )+';');
    sl.Add('insert into ' +Qrymaintablename + ' '  + AccountSummary('F'  , '8'   , 'Accounttype' , 'Total COGS'      ,'""'         ,'0'            , '"COGS"'                               , '"COGS"'     )+';');
    sl.Add('insert into ' +Qrymaintablename + ' '  + BlankLine(9)+';');
    sl.Add('insert into ' +Qrymaintablename + ' '  + AccountSummary('T'  , '10'  , '""'          , 'Gross Profit'    ,'""'         ,'0'            , '"COGS", "EXINC","INC"'                , 'FinalOrder' )+';');
    sl.Add('insert into ' +Qrymaintablename + ' '  + BlankLine(11)+';');
    sl.Add('insert into ' +Qrymaintablename + ' '  + BlankLine(12,'EXP', 'Expense' )+';');
    sl.Add('insert into ' +Qrymaintablename + ' '  + AccountSummary('F'  , '13'  , 'AccountType' , ''                ,'Accounts'   ,'AccountId'    , '"EXEXP","EXP"  '                      , 'Accounts'   )+';');
    sl.Add('insert into ' +Qrymaintablename + ' '  + AccountSummary('F'  , '14'  , '"EXP"'       , 'Total Expenses'  ,'""'         ,'0'            , '"EXEXP","EXP" '                       , '"EXP"'      )+';');
    sl.Add('insert into ' +Qrymaintablename + ' '  + BlankLine(15)+';');
    sl.Add('insert into ' +Qrymaintablename + ' '  + AccountSummary('T'  , '16'  , '"NI"'        , 'Net Income'      ,'""'         ,'0'            , '"EXEXP","EXP"  ,"EXINC", "INC", "COGS"' , 'FinalOrder')+';');
    sl.Add('insert into ' +Qrymaintablename + ' '  + AccountSummary('T'  , ''    , '""'          , ''                ,'Concat("Total ",Level1,"")'                   ,'0','','AccountHeaderOrder'                  , '"ZZZZZZZZZZZZ"'  , '"ZZZZZZZZZZZZ"'    , '"ZZZZZZZZZZZZ"'  ,' and (AccountName <> Level1)                                                          and char_length(Level1)>0  And TotalAmount<>0.00 ' , 'If( char_length(Max(Level2))>0 ,"T","F")' )+';');
    sl.Add('insert into ' +Qrymaintablename + ' '  + AccountSummary('T'  , ''    , '""'          , ''                ,'Concat(Space(5),Concat("Total ",Level2,""))'  ,'0','','AccountType,Concat(Space(5),Level2)' , 'AccountSub1Order', '"ZZZZZZZZZZZZ"'    , '"ZZZZZZZZZZZZ"'  ,' and (AccountName <> Level1)  And (AccountName <> Level2)                             And char_length(Level2)>0  And TotalAmount<>0.00 ' , 'If( char_length(Max(Level3))>0 ,"T","F")')+';');
    sl.Add('insert into ' +Qrymaintablename + ' '  + AccountSummary('F'  , ''    , '""'          , ''                ,'Concat(Space(10),Concat("Total ",Level3,""))' ,'0','','AccountType,Concat(Space(10),Level3)', 'AccountSub1Order', 'AccountSub2Order'  , '"ZZZZZZZZZZZZ"'  ,' and (AccountName <> Level1)  And (AccountName <> Level2) And (AccountName <> Level3) And char_length(Level3)>0  And TotalAmount<>0.00 ' , 'If( char_length(Max(Level4))>0 ,"T","F")')+';');
    result := SL.Text;
  finally
    sl.Free;
  end;
end;

function TProfitandLossPeriodCompare.AccountcomparePercent:String;
var
  ColumnCount:Integer;
  pColumn: pColumnRec;
  x: Integer;
  col: integer;
begin
  result:= '';
  ColumnCount := LstColumn.Count - 1;
  result:= 'drop table if exists ' + Qrymaintablename+'_1;';
  Result:= result + ' Create table  ' + Qrymaintablename+'_1 Select ID';
  for x := 0 to ColumnCount do begin
    pColumn := LstColumn.Items[x];
    result := result +', amount_' +trim(inttostr(pColumn^.ColumnNo));
  end;
  result := result +' from  ' + Qrymaintablename+';';



    for x := 0 to ColumnCount do begin
      pColumn := LstColumn.Items[x];
        { change ammounts }
        if x > 0 then begin
          col := pColumn^.ColumnNo;
          result := result +
            ' update ' + Qrymaintablename + //' main ' +
            ' set Change_' + IntToStr(col) +
            ' = Amount_' + IntToStr(col) + ' - Amount_' + IntToStr(col -1) + ';';

          result := result +
            ' update ' + Qrymaintablename + //' main ' +
            ' set ChangePercent_' + IntToStr(col) + ' = ' +
            ' CASE ' +
            ' WHEN Amount_' + IntToStr(col -1) + ' <> 0 THEN ROUND(Change_' + IntToStr(col) + ' / Amount_'+IntToStr(col-1)+' * 100,1) ' +
            ' ELSE 0.0 ' +
            ' END; ';
        end;
        if QryAccounts.recordcount >0 then begin
            QryAccounts.first;
            While QryAccounts.eof =False do begin
              result := result  +' update  ' + Qrymaintablename +' main '+
                                  ' Set `' + AccnameFldName(QryAccounts.fieldbyname('Description').asString , pColumn^.ColumnNo, QryAccounts.recno) + '_amt` = '+
                                  '(Select Amount_' +trim(inttostr(pColumn^.ColumnNo))+' from ' + Qrymaintablename+'_1 sub where sub.id = ' + trim(inttostr(qryaccounts.fieldbyname('ID').asInteger)) +');' +
                        ' update  ' + Qrymaintablename +' Set '+
                                                              '`' + AccnameFldName(QryAccounts.fieldbyname('Description').asString , pColumn^.ColumnNo, QryAccounts.recno) + '_Percent` = ' +
                                                              '100 *  Amount_' +IntToStr(pColumn^.ColumnNo) + ' / `' + AccnameFldName(QryAccounts.fieldbyname('Description').asString , pColumn^.ColumnNo, QryAccounts.recno) + '_amt`; ';
              QryAccounts.Next;
            end;
        end;
    end;
end;
function AccnameFldName(const AccName: String; fieldno: Integer; firecno:Integer): String;
begin
  result:= AccName + '_' + inttostr(firecno)+ '_' + inttostr(fieldno);
end;

{ TReportSQLProfitAndLossPeriodCompare }

function TReportSQLProfitAndLossPeriodCompare.AmountComparePercent: String;
var
  ColumnCount:Integer;
  pColumn: pColumnRec;
  x:Integer;
begin
  result:= '';
  ColumnCount := LstColumn.Count ;
  if ColumnCount <=1 then exit;

  result:= 'drop table if exists ' + Qrymaintablename+'_1;';
  Result:= result + ' Create table  ' + Qrymaintablename+'_1 Select ID';

  for x := 1 to ColumnCount-1 do begin
    pColumn := LstColumn.Items[x];
    result := result +', amount_' +trim(inttostr(pColumn^.ColumnNo));
  end;
  result := result +' from  ' + Qrymaintablename+';';

    for x := 1 to ColumnCount-1 do begin
      pColumn := LstColumn.Items[x];

        Result  := result  +' alter table  ' + Qrymaintablename +' add column Amount_diff' +IntToStr(pColumn^.ColumnNo) + ' Double;';
        Result  := result  +' alter table  ' + Qrymaintablename +' add column Amount_Perc' +IntToStr(pColumn^.ColumnNo) + ' Double;';

        result := result  +' update  ' + Qrymaintablename +' main '+
                                  ' Set amount_diff' +trim(inttostr(pColumn^.ColumnNo))+' = amount_' +trim(inttostr(pColumn^.ColumnNo))+' - amount_' +trim(inttostr(pColumn^.ColumnNo-1))+';' ;
        result := result + ' update  ' + Qrymaintablename +' main '+
                                  ' Set amount_Perc' +trim(inttostr(pColumn^.ColumnNo))+' = amount_Diff' +trim(inttostr(pColumn^.ColumnNo))+' / amount_' +trim(inttostr(pColumn^.ColumnNo))+'*100;'
    end;

end;

constructor TReportSQLProfitAndLossPeriodCompare.Create(Aowner: TComponent);
begin
  inherited;

end;

function TReportSQLProfitAndLossPeriodCompare.ExtraProcessSQL: String;
begin
  result:=AmountComparePercent;
end;

function TReportSQLProfitAndLossPeriodCompare.getTemplateSQL: String;
begin
  REsult:= ReportSQL ;
  exit;

end;

procedure TReportSQLProfitAndLossPeriodCompare.initTablename;
begin
  inherited;
  BaseTemptablename := TABLE_PROFITANDLOSSREPORT;
  ReportClassName   := 'TProfitandLossReportByPeriodCompareGUI';
  TempTablename     := 'tmp_PLC_' + GetMachineIdentification(true, true, true, true);
  Qrymaintablename  := 'tmp_PLC_' + ReportClassName + '_' + GetMachineIdentification(true, true, true, true);;
  TransTableName    := TempTableUtils.CreateUserTemporaryTable(GetSharedMyDacConnection, TABLE_PROFITANDLOSSREPORT , 'PeriodCompare' );

end;

function TReportSQLProfitAndLossPeriodCompare.reportCaption: String;
begin
  Result:= 'Profit and Loss Comparison by Period Report';

end;

function TReportSQLProfitAndLossPeriodCompare.ReportDetailsforTable: string;
begin
    result:= '';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + BlankLine(2,'INC', 'Income' )+';';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '3'   , '"INC"'       , ''                ,'Accounts'   ,'AccountID'    , '"EXINC","INC"'                        , 'Accounts'   )+';';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '4'   , '"INC"'       , 'Total Income'    ,'""'         , '0'           , '"EXINC","INC"'                        , '"INC"'      )+';';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + BlankLine(5)+';';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + BlankLine( 6,'COGS', 'Cost of Goods Sold' )+';';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '7'   , '"COGS"'      , ''                ,'Accounts'   ,'AccountId'    , '"COGS"'                               , 'Accounts'   )+';';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '8'   , 'Accounttype' , 'Total COGS'      ,'""'         ,'0'            , '"COGS"'                               , '"COGS"'     )+';';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + BlankLine(9)+';';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('T'  , '10'  , '""'          , 'Gross Profit'    ,'""'         ,'0'            , '"COGS", "EXINC","INC"'                , 'FinalOrder' )+';';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + BlankLine(11)+';';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + BlankLine(12,'EXP', 'Expense' )+';';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '13'  , 'AccountType' , ''                ,'Accounts'   ,'AccountId'    , '"EXEXP","EXP"  '                      , 'Accounts'   )+';';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , '14'  , '"EXP"'       , 'Total Expenses'  ,'""'         ,'0'            , '"EXEXP","EXP" '                       , '"EXP"'      )+';';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + BlankLine(15)+';';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('T'  , '16'  , '"NI"'        , 'Net Income'      ,'""'         ,'0'            , '"EXEXP","EXP"  ,"EXINC", "INC", "COGS"' , 'FinalOrder')+';';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('T'  , ''    , '""'          , ''                ,'Concat("Total ",Level1,"")'                   ,'0','','AccountHeaderOrder'                  , '"ZZZZZZZZZZZZ"'  , '"ZZZZZZZZZZZZ"'    , '"ZZZZZZZZZZZZ"'  ,' and (AccountName <> Level1)                                                          and char_length(Level1)>0  And TotalAmount<>0.00 ' , 'If( char_length(Max(Level2))>0 ,"T","F")' )+';';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('T'  , ''    , '""'          , ''                ,'Concat(Space(5),Concat("Total ",Level2,""))'  ,'0','','AccountType,Concat(Space(5),Level2)' , 'AccountSub1Order', '"ZZZZZZZZZZZZ"'    , '"ZZZZZZZZZZZZ"'  ,' and (AccountName <> Level1)  And (AccountName <> Level2)                             And char_length(Level2)>0  And TotalAmount<>0.00 ' , 'If( char_length(Max(Level3))>0 ,"T","F")')+';';
    Result := Result + 'INSERT INTO ' +Qrymaintablename + ' '  + AccountSummary('F'  , ''    , '""'          , ''                ,'Concat(Space(10),Concat("Total ",Level3,""))' ,'0','','AccountType,Concat(Space(10),Level3)', 'AccountSub1Order', 'AccountSub2Order'  , '"ZZZZZZZZZZZZ"'  ,' and (AccountName <> Level1)  And (AccountName <> Level2) And (AccountName <> Level3) And char_length(Level3)>0  And TotalAmount<>0.00 ' , 'If( char_length(Max(Level4))>0 ,"T","F")')+';';
end;
function TReportSQLProfitAndLossBase.getPeriodtypeDesc: String;
begin
       if Periodtype = ptMonth   then result := Month1
  else if Periodtype = pt2Month  then result := Months2
  else if Periodtype = ptQuarter then result := Months3
  else if Periodtype = pt6Month  then result := Months6
  else result := Months12;
end;

procedure TReportSQLProfitAndLossBase.setPeriodtypeDesc(const Value: String);
begin
       if sametext(Value,Month1) then Periodtype := ptMonth
  else if sametext(Value,Months2) then Periodtype:= pt2Month
  else if sametext(Value,Months3) then Periodtype:= ptQuarter
  else if sametext(Value,Months6) then Periodtype:= pt6Month
  else Periodtype := ptYear;
end;

initialization
  BusObjectListObj.TScheduledReportObjInfoList.Inst.Add('Income and Expenditure Report','TReportSQLIncomeandExpenditure','TIncomeandExpenditureGUI');
  BusObjectListObj.TScheduledReportObjInfoList.Inst.Add('Profit and Loss (Period)','TReportSQLProfitAndLossPeriod','TProfitandLossByPeriodGUI');
  Classes.RegisterClass(TReportSQLIncomeandExpenditure);
  Classes.RegisterClass(TReportSQLProfitAndLossPeriod);

end.

