unit BalanceSheetSQL;

interface
uses
  classes, ReportBaseObj, Types, ErpDBComponents, ReportSQLBalanceSheet,
    UserLockObj;

type

  TBalanceSheetReport = class(TReportWithDateRangeBase)
  private
    fAllDetartments: boolean;
    fReportClassName: string;
    fSelectedDepartments: TStringList;
    ReportSQLBalanceSheet: TReportSQLBalanceSheet;
    fReportonForeignCurrency: boolean;
    function GetSelectedDepartments: string;
    procedure SetSelectedDepartments(const Value: string);
    function GetTempTableName: string;
    procedure SetAllDetartments(const Value: boolean);
    procedure SetUserLock(const Value: TUserLock);
  protected
    function DepartmentSelected(const aDeptName: string): boolean;
  public
    AmountFieldList, AmountCaptionList: TStringDynArray;
    DepartmentIdsString: string;

    constructor Create; override;
    destructor Destroy; override;

    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
    Function TemplateSQL  :String;
    Function ReportTypeID :Integer;

    property UserLock       : TUserLock write SetUserLock;
    property TempTableName  : string    read  GetTempTableName;
    property ReportClassName: string    read  fReportClassName write fReportClassName;
  published
    property AllDepartments         : boolean read fAllDetartments            write SetAllDetartments;
    property SelectedDepartments    : string  read GetSelectedDepartments     write SetSelectedDepartments;
    property ReportonForeignCurrency: boolean read fReportonForeignCurrency   write fReportonForeignCurrency;
  end;

implementation

uses
  SysUtils, tcDataUtils, CommonLib, BusObjFCOnReport, BusObjBase, CommonDbLib,
  tcConst, AppEnvironment;

{ TBalanceSheetReport }

constructor TBalanceSheetReport.Create;
begin
  inherited;
  DepartmentIdsString := '';
  fSelectedDepartments := TStringList.Create;
  fReportClassName := 'TBalanceSheetGUI';
  DateTo := Date;
  DateFrom := 0;
  fReportonForeignCurrency := true;
  ReportSQLBalanceSheet := TReportSQLBalanceSheet.Create(nil);

end;

function TBalanceSheetReport.DepartmentSelected(
  const aDeptName: string): boolean;
begin
  result := fSelectedDepartments.IndexOf(aDeptName) > -1;
end;

destructor TBalanceSheetReport.Destroy;
begin
  ReportSQLBalanceSheet.Free;
  fSelectedDepartments.Free;
  inherited;
end;

function TBalanceSheetReport.GetSelectedDepartments: string;
begin
  result := fSelectedDepartments.CommaText;
end;

function TBalanceSheetReport.GetTempTableName: string;
begin
  result := ReportSQLBalanceSheet.Temptablename;
end;

function TBalanceSheetReport.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
var
  FCR: TForeignCurrencyonReport;
  function Col1: string;  begin    if APIMode then result := '`Account Tree`'                     else result := 'Column1';  end;
  function Col2: string;  begin    if APIMode then result := '`Sub Account Total`'                else result := 'Column2';  end;
  function Col3: string;  begin    if APIMode then result := '`Header Account Total`'             else result := 'Column3';  end;
  function Col4: string;  begin    if APIMode then result := '`Total Current Asset & Liability`'  else result := 'Column4';  end;
  function Col5: string;  begin    if APIMode then result := '`Total Asset & Liability`'          else result := 'Column5';  end;

  Procedure addForeigncurrencies;
  begin
    if ReportonForeignCurrency then begin
      if not Assigned(FCR) then begin
        FCR := TForeignCurrencyonReport.Create(nil);
        FCR.Connection := TMyDacDataConnection.Create(FCR);
        FCR.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
        FCR.LoadFCPref(fReportClassName);
      end;
      FCR.First;
      while FCR.Eof = False do begin
        SQL.add(',');
        SQL.add('ROUND(Column2 * ' +FCR.Code +'_FCRate,' + IntToStr(RoundPlacesforeigncurrency) + ') as ' + FCR.Code + '_'+Col2+',');
        SQL.add('ROUND(Column3 * ' +FCR.Code +'_FCRate,' + IntToStr(RoundPlacesforeigncurrency) + ') as ' + FCR.Code + '_'+Col3+',');
        SQL.add('ROUND(Column4 * ' +FCR.Code +'_FCRate,' + IntToStr(RoundPlacesforeigncurrency) + ') as ' + FCR.Code + '_'+Col4+',');
        SQL.add('ROUND(Column5 * ' +FCR.Code +'_FCRate,' + IntToStr(RoundPlacesforeigncurrency) + ') as ' + FCR.Code + '_'+Col5+'');
        FCR.Next;
      end;
    end;
  end;

begin
  inherited;
  result := true;
  ReportSQLBalanceSheet.DepartmentIDsString := DepartmentIDsString;
  ReportSQLBalanceSheet.Datefrom := DateFrom;
  ReportSQLBalanceSheet.dateTo := DateTo;
  ReportSQLBalanceSheet.EmployeeID := AppEnv.Employee.EmployeeID;
  if not ReportSQLBalanceSheet.Prepareforreport then begin
    result := false;
    msg := ReplaceStr(ReplaceStr(ReportSQLBalanceSheet.UserLock.LockMessage , 'Unable to update data.' , 'Unable to lock Transaction Table.') , 'record' , 'Table');
    exit;
  end;

  FCR := nil;
  try
//if Qrymain.active then Qrymain.close;
    SQL.Clear;
    SQL.add('SELECT ID, SortID, AccountType as TypeID, AccountName as ACCNAME, AccountNumber, ');
    SQL.add('Column1 as '+Col1+', TRUNCATE(Column2,0) as '+Col2+', TRUNCATE(Column3,0) as '+Col3+',  ');
    SQL.add('TRUNCATE(Column4,0) as '+Col4+', TRUNCATE(Column5,0) as '+Col5+' ');
    addForeigncurrencies;
    SQL.add('FROM ' + TempTableName );
    SQL.add('WHERE AccountType <> "TOTAL LIABILITIES & EQUITY"  ');
    SQL.add('AND AccountType <> "Total Capital / Equity"  ');
    SQL.add('AND AccountType <> "TOTAL ASSETS" ');
    SQL.add('Group By Column1 ');
    SQL.add('Union ALL ');
    SQL.add('SELECT ID,SortID, AccountType as TypeID, AccountName as ACCNAME,AccountNumber,  ');
    SQL.add('Column1 as '+Col1+', TRUNCATE(Column2,0) as '+Col2+', TRUNCATE(Column3,0) as '+Col3+',  ');
    SQL.add('TRUNCATE(Column4,0) as '+Col4+', TRUNCATE(Sum(Column5),0) as '+Col5+' ');
    addForeigncurrencies;
    SQL.add('FROM ' + TempTableName );
    SQL.add('WHERE AccountType = "TOTAL ASSETS" ');
    SQL.add('Group By AccountType ');
    SQL.add('Union ALL ');
    SQL.add('SELECT ID,SortID, AccountType as TypeID, AccountName as ACCNAME,AccountNumber,  ');
    SQL.add('Column1 as '+Col1+', TRUNCATE(Column2,0) as '+Col2+', TRUNCATE(Column3,0) as '+Col3+', ');
    SQL.add('TRUNCATE(Sum(Column4),0) as '+Col4+',TRUNCATE(Column5,0) as '+Col5+' ');
    addForeigncurrencies;
    SQL.add('FROM ' + TempTableName );
    SQL.add('WhERE AccountType = "Total Capital / Equity" ');
    SQL.add('Group BY Column1 ');
    SQL.add('Union ALL ');
    SQL.add('SELECT ID,SortID, AccountType as TypeID, AccountName as ACCNAME,AccountNumber,  ');
    SQL.add('Column1 as '+Col1+', TRUNCATE(Column2,0) as '+Col2+', TRUNCATE(Column3,0) as '+Col3+',  ');
    SQL.add('TRUNCATE(Column4,0) as '+Col4+', TRUNCATE(Sum(Column5),0) as '+Col5+' ');
    addForeigncurrencies;
    SQL.add('FROM ' + TempTableName );
    SQL.add('WhERE AccountType = "TOTAL LIABILITIES & EQUITY" ');
    SQL.add('Group BY SortID ');
    SQL.add('Order by ID; ');
    //RefreshOrignalSQL;
    //LabelChange;
    //Calcdiff;
  finally
    FCR.Free;
  end;
end;

function TBalanceSheetReport.ReportTypeID: Integer;
begin
  Result := ReportSQLBalanceSheet.ReportTypeID;
end;

procedure TBalanceSheetReport.SetAllDetartments(const Value: boolean);
begin
  fAllDetartments := Value;
  if Value then
    DepartmentIdsString := '';
end;

procedure TBalanceSheetReport.SetSelectedDepartments(const Value: string);
var
  x: integer;
begin
  fSelectedDepartments.CommaText := Value;
  DepartmentIdsString := '';
  for x := 0 to fSelectedDepartments.Count -1 do begin
    if x > 0 then DepartmentIdsString := DepartmentIdsString + ' or';
    DepartmentIdsString := DepartmentIdsString +
      ' ClassID = ' + IntToStr(GetDeptID(fSelectedDepartments[x])) ;
  end;

end;

procedure TBalanceSheetReport.SetUserLock(const Value: TUserLock);
begin
  ReportSQLBalanceSheet.UserLock := Value;
end;

function TBalanceSheetReport.TemplateSQL: String;
begin
  REsult := ReportSQLBalanceSheet.TemplateSQL;
end;

initialization
  RegisterClass(TBalanceSheetReport);

end.
