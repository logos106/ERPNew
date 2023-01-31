unit ARReportSQL;

interface
uses
  ERPDbComponents, DAScript, SysUtils, classes, Types, DB, ReportBaseObj;

type

  TARReport = class(TReportWithDateRangeBase)
  private
(*    fDateTo: TDateTime;
    fDateFrom: TDateTime;
    fIgnoreDates: boolean;*)
    fGroupJobsWithCustomer: boolean;
    fIncludePrepayments: boolean;
    fIncludeRefunds: boolean;
    fCalenderAgeing: boolean;
    fAgeByTransactionDate: boolean;
    fDepartmentID: integer;
    TempTableName: string;
    TblUpdateSurchargestatus: string;
    AvgDaysTableName: string;
    fClientID: integer;
    fReportType: string;
(*    function DateFromSQL: string;
    function DateToSQL: string;
    procedure SetDateFrom(const Value: TDateTime);
    procedure SetDateTo(const Value: TDateTime);*)
  public
    WhereSQL: string;
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
    procedure PopulateReportTables;
  published
(*    property DateFrom: TDateTime read fDateFrom write SetDateFrom;
    property DateTo: TDateTime read fDateTo write SetDateTo;
    property IgnoreDates: boolean read fIgnoreDates write fIgnoreDates;*)
    property DepartmentID: integer read fDepartmentID write fDepartmentID;
    property IncludePrepayments: boolean read fIncludePrepayments write fIncludePrepayments;
    property IncludeRefunds: boolean read fIncludeRefunds write fIncludeRefunds;
    property AgeByTransactionDate: boolean read fAgeByTransactionDate write fAgeByTransactionDate;
    property GroupJobsWithCustomer: boolean read fGroupJobsWithCustomer write fGroupJobsWithCustomer;
    property CalenderAgeing: boolean read fCalenderAgeing write fCalenderAgeing;
    property ClientID: integer read fClientID write fClientID;
    property ReportType: string read fReportType write fReportType; { Summary, Detail, ExtraDetail }
  end;

implementation

uses
  CommonDbLib, CommonLib, Report_AR_Obj, tcConst;

{ TARReport }

constructor TARReport.Create;
begin
  inherited;
  DateFrom := MinDateTime;
  DateTo := MaxDateTime;
  IgnoreDates := true;
  fDepartmentID := 0;
  fIncludePrepayments := false;
  fIncludeRefunds := true;
  fAgeByTransactionDate := false;
  fGroupJobsWithCustomer := false;
  fCalenderAgeing := false;
  fClientID := -1;
  WhereSQL := '';
  fReportType := 'ExtraDetail';
  TempTableName := commondbLib.CreateUserTemporaryTable('tmp_tblaccountsreceivable' , '');
end;

(*function TARReport.DateFromSQL: string;
var
  dt: TDateTime;
begin
  if fIgnoreDates then dt := MinDateTime
  else dt := fDateFrom;
  result := '"' + FormatDateTime('yyyy-mm-dd',dt) + '"';
end;

function TARReport.DateToSQL: string;
var
  dt: TDateTime;
begin
  if fIgnoreDates then dt := MaxDateTime
  else dt := fDateTo;
  result := '"' + FormatDateTime('yyyy-mm-dd',dt) + '"';
end;*)

destructor TARReport.Destroy;
begin
  DestroyUserTemporaryTable(TempTableName);
  DestroyUserTemporaryTable(TblUpdateSurchargestatus);
  DestroyUserTemporaryTable(AvgDaysTableName);

  inherited;
end;

function TARReport.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
var
  sl: TStringList;
  TypeCount: integer;

  Procedure DetailFCs1;
  begin
    SQL.add('Round(Sum(AR.`OriginalAmount` ),'+inttostr(CurrencyRoundPlaces)+') as `OriginalAmount`,');
    SQL.add('Round(Sum(AR.`AmountDue` ),'+inttostr(CurrencyRoundPlaces)+') as `AmountDue`,');
    SQL.add('Round(Sum(AR.`Current` ),'+inttostr(CurrencyRoundPlaces)+') as `Current`,');
    SQL.add('Round(Sum(AR.`1-7Days` ),'+inttostr(CurrencyRoundPlaces)+') as `1-7Days`,');
    SQL.add('Round(Sum(AR.`7-14Days` ),'+inttostr(CurrencyRoundPlaces)+') as `7-14Days`,');
    SQL.add('Round(Sum(AR.`14-21Days` ),'+inttostr(CurrencyRoundPlaces)+') as `14-21Days`,');
    SQL.add('Round(Sum(AR.`>21Days` ),'+inttostr(CurrencyRoundPlaces)+') as `>21Days`,');
    SQL.add('Round(Sum(AR.`1-30Days` ),'+inttostr(CurrencyRoundPlaces)+') as `1-30Days`,');
    SQL.add('Round(Sum(AR.`30-60Days` ),'+inttostr(CurrencyRoundPlaces)+') as `30-60Days`,');
    SQL.add('Round(Sum(AR.`60-90Days` ),'+inttostr(CurrencyRoundPlaces)+') as `60-90Days`,');
    SQL.add('Round(Sum(AR.`>90Days` ),'+inttostr(CurrencyRoundPlaces)+') as `>90Days`,');
    SQL.add('Round(C1.creditlimit,'+inttostr(CurrencyRoundPlaces)+') as creditlimit,')
  end;

  Procedure DetailFCs2;
  begin
    SQL.add('AR.`OriginalAmount`  as `OriginalAmount`,');
    SQL.add('AR.`AmountDue`  as `AmountDue`,');
    SQL.add('AR.`Current`  as `Current`,');
    SQL.add('AR.`1-7Days`  as `1-7Days`,');
    SQL.add('AR.`7-14Days`  as `7-14Days`,');
    SQL.add('AR.`14-21Days`  as `14-21Days`,');
    SQL.add('AR.`>21Days`  as `>21Days`,');
    SQL.add('AR.`1-30Days`  as `1-30Days`,');
    SQL.add('AR.`30-60Days`  as `30-60Days`,');
    SQL.add('AR.`60-90Days`  as `60-90Days`,');
    SQL.add('AR.`>90Days`  as `>90Days`,');
    SQL.add('C1.creditlimit as creditlimit,')
  end;

  procedure AddSummary;
  begin
    with SQL do begin
      Add('SELECT ');
      if GroupJobsWithCustomer then
        Add('If(InStr(AR.CustomerName,"(") -1 >0,Left(AR.CustomerName,InStr(AR.CustomerName,"(")-1),AR.CustomerName) as CustomerName, ')
      else Add(' AR.CustomerName as CustomerName, ');
      Add('space(50) as RelatedCustomerName,');
      Add('space(50) as PO_Number,CustomerType as CustomerType, ');
      Add('null as Type, ');
      Add('Null as SaleDate, ');
      Add('Null as DueDate, ');
      Add('Null as Prepaymentno,  ');
      Add('Null as InvoiceNumber, ');
      if GroupJobsWithCustomer then Add(' If(InStr(Name,"(") -1 >0,Left(Name,InStr(Name,"(")-1),Name) as Name, ')
      else Add(' Name as Name, ');
      DetailFCs1;
      Add('0 as SaleID, ');
      Add('null as ConNote,');
      Add('AR.CUSTFLD1 as CUSTFLD1, ');
      Add('AR.CUSTFLD2 as CUSTFLD2, ');
      Add('AR.CUSTFLD3 as CUSTFLD3, ');
      Add('AR.CUSTFLD4 as CUSTFLD4, ');
      Add('AR.CUSTFLD5 as CUSTFLD5, ');
      Add('AR.CUSTFLD6 as CUSTFLD6, ');
      Add('AR.CUSTFLD7 as CUSTFLD7, ');
      Add('AR.CUSTFLD8 as CUSTFLD8, ');
      Add('AR.CUSTFLD9 as CUSTFLD9, ');
      Add('AR.CUSTFLD10 as CUSTFLD10, ');
      Add('AR.CUSTFLD11 as CUSTFLD11, ');
      Add('AR.CUSTFLD12 as CUSTFLD12, ');
      Add('AR.CUSTFLD13 as CUSTFLD13, ');
      Add('AR.CUSTFLD14 as CUSTFLD14, ');
      Add('AR.CUSTFLD15 as CUSTFLD15, ');
      Add('AR.Phone as Phone, ');
      Add('AR.FaxNumber as FaxNumber, ');
      Add('AR.Mobile as Mobile, ');
      Add('AR.AltPhone as AltPhone, ');
      Add('0 as Details, ');
      if GroupJobsWithCustomer then Add(' if(isnull(C2.ClientID), AR.ClientID, AR.ParentClientID) as ClientID, ')
      else Add(' if(isnull(AR.ClientID), AR.ClientID, AR.ClientID)  as ClientID, ');
      Add('"" as Notes, ');
      Add('"" as ARNotes, ');
      Add('AR.StopCredit as StopCredit, ');
      Add('"" as AccountName, ');
      Add('TransactionName as TransactionName ,');
      Add('S.EmployeeName, tmpAr.AvgDays, Space(100) as ChequeNo, "", "","","" , C1.Printname, C1.ClientNo, C1.Email , Null as OverdueSurcharge , Null as OverdueSurchargeDesc');
      Add('FROM ' + TempTableName + ' AR ');
      Add('LEFT JOIN tblClients as C1 on AR.ClientID = C1.ClientID ');
      Add('LEFT JOIN ' + AvgDaysTablename +'  as tmpAR on C1.ClientID = tmpAR.cusID');
      Add('LEFT JOIN tblClients as C2 on C1.ParentClientID = C2.ClientID ');
      Add('LEFT JOIN tblsales S ON (AR.SaleId = S.SaleID) AND (AR.Type <> "'+CUSTOMER_PREPAYMENT+'") AND (AR.Type <> "Customer Payment")');

      Add('WHERE round(AR.AmountDue,' +inttostr(CurrencyRoundPlaces) +')<>0.00 ');
      if Wheresql <> '' then Add(' AND ' + Wheresql );
      if not CalenderAgeing  then
        if AgeByTransactionDate then
          Add('AND AR.SaleDate  Between ' + DateFromSQL + ' AND ' + DateToSQL)
        else Add('AND AR.Duedate  Between ' + DateFromSQL + ' AND ' + DateToSQL);
      if not IncludePrepayments then
          Add(' AND AR.Type <> "'+CUSTOMER_PREPAYMENT+'" ');
      if not IncludeRefunds then
          Add(' AND AR.Type <> "'+RefundType+'" ');
      Add('Group By ClientID ');

    end;
  end;

  procedure AddDetail;
  begin
    with SQL do begin
      Add('SELECT ');
      Add('space(50) as CustomerName,');
      Add('space(50) as RelatedCustomerName, AR.PO_Number,');
      Add('CustomerType as CustomerType, ');
      Add('AR.Type as Type, ');
      Add('Null as SaleDate, ');
      Add('Null as DueDate, ');
      Add('Null as Prepaymentno,  ');
      Add('Null as InvoiceNumber, ');
      if GroupJobsWithCustomer then Add(' If(InStr(Name,"(") -1 >0,Left(Name,InStr(Name,"(")-1),Name) as Name, ')
      else Add(' Name as Name, ');
      DetailFCs1;
      Add('0 as SaleID, ');
      Add('null as ConNote,');
      Add('AR.CUSTFLD1 as CUSTFLD1, ');
      Add('AR.CUSTFLD2 as CUSTFLD2, ');
      Add('AR.CUSTFLD3 as CUSTFLD3, ');
      Add('AR.CUSTFLD4 as CUSTFLD4, ');
      Add('AR.CUSTFLD5 as CUSTFLD5, ');
      Add('AR.CUSTFLD6 as CUSTFLD6, ');
      Add('AR.CUSTFLD7 as CUSTFLD7, ');
      Add('AR.CUSTFLD8 as CUSTFLD8, ');
      Add('AR.CUSTFLD9 as CUSTFLD9, ');
      Add('AR.CUSTFLD10 as CUSTFLD10, ');
      Add('AR.CUSTFLD11 as CUSTFLD11, ');
      Add('AR.CUSTFLD12 as CUSTFLD12, ');
      Add('AR.CUSTFLD13 as CUSTFLD13, ');
      Add('AR.CUSTFLD14 as CUSTFLD14, ');
      Add('AR.CUSTFLD15 as CUSTFLD15, ');
      Add('AR.Phone as Phone, ');
      Add('AR.FaxNumber as FaxNumber, ');
      Add('AR.Mobile as Mobile, ');
      Add('AR.AltPhone as AltPhone, ');
      Add('1 as Details, ');
      if GroupJobsWithCustomer then Add(' if(isnull(C2.ClientID), AR.ClientID, AR.ParentClientID) as ClientID, ')
      else Add('if(isnull(AR.ClientID), AR.ClientID, AR.ClientID)  as ClientID, ');
      Add('"" as Notes, ');
      Add('"" as ARNotes, ');
      Add('AR.StopCredit as StopCredit, ');
      Add('"" as AccountName, ');
      Add('TransactionName as TransactionName, ');
      Add('S.EmployeeName, tmpAr.AvgDays, space(100) as ChequeNo, "", "", S.QuoteStatus as Status, D.ClassName, C1.Printname, C1.ClientNo, C1.Email , Null as OverdueSurcharge , Null as OverdueSurchargeDesc');
      Add('FROM ' + TempTableName + ' AR ');
      Add('LEFT JOIN tblClients as C1 on AR.ClientID = C1.ClientID ');
      Add('LEFT JOIN ' + AvgDaysTablename +'  as tmpAR on C1.ClientID = tmpAR.cusID');
      Add('LEFT JOIN tblClients as C2 on C1.ParentClientID = C2.ClientID ');
      Add('LEFT JOIN tblsales S ON (AR.SaleId = S.SaleID) AND (AR.Type <> "'+CUSTOMER_PREPAYMENT+'") AND (AR.Type <> "Customer Payment")');
      Add('LEFT JOIN tblClass D ON AR.ClassID = D.ClassID');

      Add('WHERE round(AR.AmountDue,' +inttostr(CurrencyRoundPlaces) +')<>0.00 ');
      if Wheresql <> '' then Add(' AND ' + Wheresql );
      if not CalenderAgeing  then
        if AgeByTransactionDate then
          Add('AND AR.SaleDate  Between ' + DateFromSQL + ' AND ' + DateToSQL)
        else
          Add('AND AR.Duedate  Between ' + DateFromSQL + ' AND ' + DateToSQL);

      if not IncludePrepayments then
          Add(' AND AR.Type <> "'+CUSTOMER_PREPAYMENT+'" ');
      if not IncludeRefunds then
          Add(' AND AR.Type <> "'+RefundType+'" ');
      Add('GROUP BY ClientID,Type ');
    end;
  end;

  procedure AddExtraDetail;
  begin
    with SQL do begin
      Add('SELECT ');
      Add('space(50) as CustomerName,');
      Add('rc.ChildCompany as RelatedCustomerName,');
      Add('AR.PO_Number as PO_Number,');
      Add('CustomerType as CustomerType, ');
      Add('AR.Type as Type, ');
      Add('AR.SaleDate as SaleDate, ');
      Add('AR.DueDate as DueDate, ');
      Add('if(AR.Type = "'+CUSTOMER_PREPAYMENT+'" , AR.SaleID , NULL) as Prepaymentno, ');
      Add('if(AR.Type = "'+CUSTOMER_PREPAYMENT+'" ,  NULL,AR.InvoiceNumber) as InvoiceNumber, ');
      if GroupJobsWithCustomer then Add(' If(InStr(Name,"(") -1 >0,Left(Name,InStr(Name,"(")-1),Name) as Name, ')
      else Add(' Name as Name, ');
      DetailFCs2;
      Add('AR.SaleID as SaleID, ');
      Add('AR.ConNote as ConNote, ');
      Add('AR.CUSTFLD1 as CUSTFLD1, ');
      Add('AR.CUSTFLD2 as CUSTFLD2, ');
      Add('AR.CUSTFLD3 as CUSTFLD3, ');
      Add('AR.CUSTFLD4 as CUSTFLD4, ');
      Add('AR.CUSTFLD5 as CUSTFLD5, ');
      Add('AR.CUSTFLD6 as CUSTFLD6, ');
      Add('AR.CUSTFLD7 as CUSTFLD7, ');
      Add('AR.CUSTFLD8 as CUSTFLD8, ');
      Add('AR.CUSTFLD9 as CUSTFLD9, ');
      Add('AR.CUSTFLD10 as CUSTFLD10, ');
      Add('AR.CUSTFLD11 as CUSTFLD11,    ');
      Add('AR.CUSTFLD12 as CUSTFLD12, ');
      Add('AR.CUSTFLD13 as CUSTFLD13, ');
      Add('AR.CUSTFLD14 as CUSTFLD14, ');
      Add('AR.CUSTFLD15 as CUSTFLD15, ');
      Add('AR.Phone as Phone, ');
      Add('AR.FaxNumber as FaxNumber, ');
      Add('AR.Mobile as Mobile, ');
      Add('AR.AltPhone as AltPhone, ');
      Add('2 as Details, ');
      if GroupJobsWithCustomer then Add(' if(isnull(C2.ClientID), AR.ClientID, AR.ParentClientID) as ClientID, ')
      else Add(' AR.ClientID as ClientID, ');
      Add('AR.ARNotes as Notes, ');
      Add('if(AR.Type = ' +Quotedstr(CUSTOMER_PREPAYMENT) +',PP.Notes,S.ARNotes) as ARNotes,');
      Add('AR.StopCredit as StopCredit, ');
      Add('AR.AccountName as AccountName, ');
      Add('TransactionName as TransactionName, ');
      Add('S.EmployeeName, tmpAr.AvgDays, S.ChequeNo , S.Shipping ,S.Terms, S.QuoteStatus as Status, D.ClassName, C1.Printname, C1.ClientNo, C1.Email, AR.OverdueSurcharge , AR.OverdueSurchargeDesc ');
      Add('FROM ' + TempTableName + ' AR ');
      Add('LEFT JOIN tblClients as C1 on AR.ClientID = C1.ClientID ');
      Add('LEFT JOIN ' + AvgDaysTablename +'  as tmpAR on C1.ClientID = tmpAR.cusID');
      Add('LEFT JOIN tblClients as C2 on C1.ParentClientID = C2.ClientID ');
      Add('LEFT JOIN tblsales S ON (AR.SaleId = S.SaleID) AND (AR.Type <> "'+CUSTOMER_PREPAYMENT+'") AND (AR.Type <> "Customer Payment")');
      Add('LEFT JOIN tblClass D ON AR.ClassID = D.ClassID');
      Add('INNER JOIN tblTransActions Trans ON Trans.TransID = AR.TransID');
      Add('LEFT JOIN tblRelatedClients rc ON rc.ChildClientID = Trans.ClientID');
      Add('LEFT JOIN tblPrepayments PP on PP.PrepaymentID = AR.SaleID and AR.Type = "Customer Payment"');
      Add('WHERE round(AR.AmountDue,' +inttostr(CurrencyRoundPlaces) +')<>0.00 ');
      if Wheresql <> '' then Add(' AND ' + Wheresql );
      if not CalenderAgeing  then
      if AgeByTransactionDate then
        Add('AND AR.SaleDate  Between ' + DateFromSQL + ' AND ' + DateToSQL)
      else
        Add('AND AR.Duedate  Between ' + DateFromSQL + ' AND ' + DateToSQL);
      if not IncludePrepayments then
          Add(' AND AR.Type <> "'+CUSTOMER_PREPAYMENT+'" ');
      if not IncludeRefunds then
          Add(' AND AR.Type <> "'+RefundType+'" ');

      Add('Group By ClientID,Type,SaleID ');

    end;
  end;

begin
  result := inherited;
  SQL.Clear;
(*  if IgnoreDates then begin
    fDateFrom := MinDateTime;
    fDateTo := MaxDateTime;
  end;*)
  PopulateReportTables;

  if APIMode then begin
    sl := TStringList.Create;
    TypeCount := 0;
    try
      sl.CaseSensitive := false;
      sl.CommaText := self.ReportType;
      if sl.IndexOf('ExtraDetail') > -1 then begin
        AddExtraDetail;
        Inc(TypeCount);
      end;
      if sl.IndexOf('Detail') > -1 then begin
        if TypeCount > 0 then
          SQL.add('Union All');
        AddDetail;
        Inc(TypeCount);
      end;
      if sl.IndexOf('Summary') > -1 then begin
        if TypeCount > 0 then
          SQL.add('Union All');
        AddSummary;
        Inc(TypeCount);
      end;
      if TypeCount = 0 then begin
        result := false;
        msg := 'Invalid ReportType Parameter';
        exit;
      end;
    finally
      sl.Free;
    end;
  end
  else begin
    AddExtraDetail;
    SQL.add('Union All');
    AddDetail;
    SQL.add('Union All');
    AddSummary;
  end;
end;

procedure TARReport.PopulateReportTables;
var
  strSQL:String;
  AR_Report_Obj: TAR_Report_Obj;
begin
  AvgDaysTablename := CommonDbLib.GetUserTemporaryTableName('AR');
  strSQL:= 'Drop table if exists ' +AvgDaysTablename+';';
  strSQL:= strSQL+'Create Table ' + AvgDaysTablename +' ENGINE = MYISAM ';
  strSQL:= strSQL+' SELECT D.CusID, Avg(DateDiff(D.PaymentDate,DL.InvoiceDate)) AS AvgDays';
  strSQL:= strSQL+' FROM tbldepositline AS DL';
  strSQL:= strSQL+' Inner Join tbldeposits AS D ON DL.PaymentID = D.PaymentID';
  strSQL:= strSQL+' WHERE ifnull(DL.AmountOutstanding,0) =  0';
  strSQL:= strSQL+' GROUP BY D.CusID;';
  strSQL:= strSQL+' Alter table ' + AvgDaysTablename +' Add PRIMARY KEY  (`CusID`);';
  ExecuteSQL(strSQL);

  AR_Report_Obj := TAR_Report_Obj.Create(True);
  try
    if fClientID = 0 then
      fClientID := -1;

    AR_Report_Obj.CleanRefresh_AR_Table(IgnoreDates, DateTo,
      DepartmentID, DepartmentID = 0, ClientID,
      AgeByTransactionDate, TempTableName, '', CalenderAgeing);

  finally
  AR_Report_Obj.Free;
  end;
end;

(*procedure TARReport.SetDateFrom(const Value: TDateTime);
begin
  fDateFrom := Value;
  fIgnoreDates := (fDateFrom = MinDateTime) and (fDateTo = MaxDateTime);
end;

procedure TARReport.SetDateTo(const Value: TDateTime);
begin
  fDateTo := Value;
  fIgnoreDates := (fDateFrom = MinDateTime) and (fDateTo = MaxDateTime);
end;*)

initialization
  RegisterClass(TARReport);

end.
