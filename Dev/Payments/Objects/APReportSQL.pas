unit APReportSQL;

interface

uses
  ERPDbComponents, DAScript, SysUtils, classes, Types, DB, ReportBaseObj;

type

  TAPReport = class(TReportWithDateRangeBase)
  private
    (*fDateTo: TDateTime;
    fDateFrom: TDateTime;
    fIgnoreDates: boolean;*)
    fIncludePrepayments: boolean;
    fCalenderAgeing: boolean;
    fAgeByTransactionDate: boolean;
    fDepartmentID: integer;
//    TblUpdateSurchargestatus: string;
//    AvgDaysTableName: string;
    fClientID: integer;
    fReportType: string;
    fReportOnForeignCurrency: boolean;
    fReportClassName: string;
(*    function DateFromSQL: string;
    function DateToSQL: string;
    procedure SetDateFrom(const Value: TDateTime);
    procedure SetDateTo(const Value: TDateTime);*)
  Protected
(*    function DateFromSQL: string;Override;
    function DateToSQL: string;Override;*)
  public
    WhereSQL: string;
    TempTableName: string;
//    AmountFieldList, AmountCaptionList: TStringDynArray;
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
    procedure PopulateReportTables;
    property ReportClassName: string read fReportClassName write fReportClassName;
  published
(*    property DateFrom: TDateTime read fDateFrom write SetDateFrom;
    property DateTo: TDateTime read fDateTo write SetDateTo;
    property IgnoreDates: boolean read fIgnoreDates write fIgnoreDates;*)
    property DepartmentID: integer read fDepartmentID write fDepartmentID;
    property IncludePrepayments: boolean read fIncludePrepayments write fIncludePrepayments;
    property AgeByTransactionDate: boolean read fAgeByTransactionDate write fAgeByTransactionDate;
    property CalenderAgeing: boolean read fCalenderAgeing write fCalenderAgeing;
    property ClientID: integer read fClientID write fClientID;
    property ReportOnForeignCurrency: boolean read fReportOnForeignCurrency write fReportOnForeignCurrency;
    property ReportType: string read fReportType write fReportType; { Summary, Detail, ExtraDetail }
  end;


implementation

uses
   (*CommonLib, *)(*AppEnvironment,*) (*{$IFNDEF CONSOLE}CommonDbLib,BusObjFCOnReport,{$ENDIF}*)Report_AP_Obj,
  TempTableUtils, AppEnvironmentVirtual, DbSharedObjectsObj, FCOnreportLib,
  UtilsLib;

{ TAPReport }

constructor TAPReport.Create;
begin
  inherited;
  DateFrom := MinDateTime;
  DateTo := MaxDateTime;
  IgnoreDates := true;
  fDepartmentID := 0;
  fIncludePrepayments := false;
  fAgeByTransactionDate := false;
//  fGroupJobsWithCustomer := false;
  fCalenderAgeing := false;
  fClientID := -1;
  WhereSQL := '';
  fReportOnForeignCurrency := false;
  fReportType := 'ExtraDetail';
  fReportClassName := 'TAccountsPayListGUI';
  TempTableName := '';
end;

(*function TAPReport.DateFromSQL: string;
var
  dt: TDateTime;
begin
  if fIgnoreDates then dt := MinDateTime
  else dt := fDateFrom;
  result := '"' + FormatDateTime('yyyy-mm-dd',dt) + '"';
end;

function TAPReport.DateToSQL: string;
var
  dt: TDateTime;
begin
  if fIgnoreDates then dt := MaxDateTime
  else dt := fDateTo;
  result := '"' + FormatDateTime('yyyy-mm-dd',dt) + '"';
end;*)

destructor TAPReport.Destroy;
begin
  //DestroyUserTemporaryTable(TempTableName);
  TempTableUtils.DestroyUserTemporaryTable(TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']), TempTableName);
  inherited;
end;

function TAPReport.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
var
  FCR: TERPQuery;
  sl: TStringList;
  TypeCount: integer;

  Procedure DetailFCs1;
  var aCode: string;
  begin
    if ReportOnForeignCurrency then begin
      FCR.First;
      while not FCR.Eof do begin
        aCode := FCR.Fieldbyname('Code').asString;//FCR.Fieldbyname('Currency').asString;
        SQL.add('Truncate(Sum(OriginalAmount * ' + aCode + '_FCRate),2) as ' + aCode + '_OriginalAmount,');
        SQL.add('Truncate(Sum(TT.AmountDue      * ' + aCode + '_FCRate),2) as ' + aCode + '_AmountDue,');
        SQL.add('Truncate(Sum(Current        * ' + aCode + '_FCRate),2) as ' + aCode + '_Current,');
        SQL.add('Truncate(Sum(30Days         * ' + aCode + '_FCRate),2) as ' + aCode + '_30Days,');
        SQL.add('Truncate(Sum(60Days         * ' + aCode + '_FCRate),2) as ' + aCode + '_60Days,');
        SQL.add('Truncate(Sum(90Days         * ' + aCode + '_FCRate),2) as ' + aCode + '_90Days,');
        SQL.add('Truncate(Sum(120Days        * ' + aCode + '_FCRate),2) as ' + aCode + '_120Days,');
        FCR.Next;
      end;
    end;
  end;

  Procedure DetailFCs2;
  var aCode: string;
  begin
    if ReportOnForeignCurrency then begin
      FCR.First;
      while not FCR.Eof do begin
        aCode := FCR.Fieldbyname('Code').asString;//FCR.Fieldbyname('Currency').asString;
        SQL.add('Truncate(OriginalAmount * ' + aCode + '_FCRate,2) as ' + aCode + '_OriginalAmount,');
        SQL.add('Truncate(TT.AmountDue      * ' + aCode + '_FCRate,2) as ' + aCode + '_AmountDue,');
        SQL.add('Truncate(Current        * ' + aCode + '_FCRate,2) as ' + aCode + '_Current,');
        SQL.add('Truncate(30Days         * ' + aCode + '_FCRate,2) as ' + aCode + '_30Days,');
        SQL.add('Truncate(60Days         * ' + aCode + '_FCRate,2) as ' + aCode + '_60Days,');
        SQL.add('Truncate(90Days         * ' + aCode + '_FCRate,2) as ' + aCode + '_90Days,');
        SQL.add('Truncate(120Days        * ' + aCode + '_FCRate,2) as ' + aCode + '_120Days,');
        FCR.Next;
      end;
    end;
  end;


  procedure AddExtraDetailSQL;
  begin
    {Need to show only approved. tmpTransTable is huge and used in many places so I inner joined to tblpurchaseOrders}
    SQL.add('SELECT TT.TransID, TT.GlobalRef,');
    SQL.add('space(50) as SupplierName,');
    SQL.add('TT.Type as Type,');
    SQL.add('TT.OrderDate as OrderDate,');
    SQL.add('TT.InvoiceDate,');                     //('TT.InvoiceDate as InvoiceDate,');
    SQL.add('TT.DueDate as DueDate,');
    SQL.add('TT.PONumber as PONumber,');
    SQL.add('TT.Name as Name,');
    SQL.add('Round(OriginalAmount,'+inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'])+') as OriginalAmount,');
    SQL.add('TT.AmountDue as AmountDue,');
    SQL.add('TT.Current as Current,');
    SQL.add('30Days as 30Days,');
    SQL.add('60Days as 60Days,');
    SQL.add('90Days as 90Days,');
    SQL.add('120Days as 120Days,');
    DetailFCs2;
    SQL.add('TT.PurchaseOrderID as PurchaseOrderID,');
    SQL.add('2 as Details,');
    SQL.add('TT.ClientID as ClientID,');
    SQL.add('C.Printname as Printname,');
    SQL.add('TT.InvoiceNumber as InvoiceNumber,');
    SQL.add('TT.AccountName as AccountName,');
    SQL.add('TT.APNotes as Notes,');
    SQL.add('if(TT.Type = "Supplier Prepayment",PP.Notes,PO.APNotes) as APNotes,');
    SQL.add('PO.GlobalRef as POGlobalRef, ');
    SQL.add('PO.Terms, ');
    SQL.add('PC.Status as PCStatus');
    SQL.add('FROM ' +  TempTablename + ' AS TT left join tblclients C on C.clientId = TT.clientID');
    SQL.add('LEFT JOIN tblPurchaseOrders PO ON TT.PurchaseOrderId = PO.PurchaseOrderID');
    SQL.add('LEFT JOIN tblPaymentConformations PC ON PC.Active = "T" AND PC.TransGlobalRef = PO.GlobalRef AND PC.TransType = TT.Type');
    SQL.add('LEFT JOIN tblPrepayments PP on PP.PrepaymentID = TT.PurchaseOrderId and TT.Type = "Supplier Prepayment"');
    //SQLList.add('Where TT.AmountDue<>0.00');
    SQL.add('Where round(abs(TT.AmountDue),' +inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) +' ) <>0.00');
    if AppEnvVirt.Bool['CompanyPrefs.UseApprovalLevels'] then SQL.Add('AND PO.Approved = "T"');
    if not CalenderAgeing then
      if AgeByTransactionDate then
        SQL.Add('AND TT.OrderDate  Between ' + DateFromSQL + ' AND ' + DateToSQL)
      else
        SQL.Add('AND TT.Duedate  Between ' + DateFromSQL + ' AND ' + DateToSQL);

    if not IncludePrepayments then begin
        SQL.add('AND TT.Type <> "Supplier Prepayment" ');
    end;
    if Wheresql <> '' then SQL.Add(' AND ' + Wheresql );
    SQL.add('Group By ClientID,Type,PurchaseOrderID');
  end;

  procedure AddDetailSQL;
  begin
    SQL.add('SELECT ');
    SQL.add('null as TransID, ');//SQL.add('TT.TransID, ');
    SQL.add('NULL as GlobalRef,');//SQL.add('TT.GlobalRef,');
    SQL.add('space(50) as SupplierName,');
    SQL.add('TT.Type as Type,');
    SQL.add('Null as OrderDate,');
    SQL.add('Null as InvoiceDate,');
    SQL.add('Null as DueDate,');
    SQL.add('Null as PONumber,');
    SQL.add('TT.Name as Name,');
    SQL.add('Sum(Round(OriginalAmount,'+inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'])+')) as OriginalAmount,');
    SQL.add('Sum(Round(TT.AmountDue,'+inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'])+')) as AmountDue,');
    SQL.add('Sum(Round(Current,'+inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'])+')) as Current,');
    SQL.add('Sum(Round(30Days,'+inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'])+')) as 30Days,');
    SQL.add('Sum(Round(60Days,'+inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'])+')) as 60Days,');
    SQL.add('Sum(Round(90Days,'+inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'])+')) as 90Days,');
    SQL.add('Sum(Round(120Days,'+inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'])+')) as 120Days,');
    DetailFCs1;
    SQL.add('NULL as PurchaseOrderID,');//SQL.add('TT.PurchaseOrderID as PurchaseOrderID,');
    SQL.add('1 as Details,');
    SQL.add('TT.ClientID as ClientID,');
    SQL.add('C.Printname as Printname,');
    SQL.add('Null as InvoiceNumber,');
    SQL.add('"" as AccountName,');
    SQL.add('"" as Notes,');
    SQL.add('"" as APNotes,');
    SQL.add('NULL as POGlobalRef, ');
    SQL.add('" " as Terms, ');
    SQL.add('Null as PCStatus');
    SQL.add('FROM ' + TempTablename+ ' AS TT  left join tblclients C on C.clientId = TT.clientID');
    SQL.add('LEFT JOIN tblPurchaseOrders PO ON TT.PurchaseOrderId = PO.PurchaseOrderID');
    //SQLList.add('Where TT.AmountDue<>0.00');
    SQL.add('Where round(abs(TT.AmountDue),' +inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) +' ) <>0.00');
    if AppEnvVirt.Bool['CompanyPrefs.UseApprovalLevels'] then SQL.Add('AND PO.Approved = "T"');
    if not CalenderAgeing then
      if AgeByTransactionDate then
        SQL.add('AND TT.OrderDate Between ' + DateFromSQL + ' AND ' + DateToSQL)
      else
        SQL.add('AND TT.DueDate Between ' + DateFromSQL + ' AND ' + DateToSQL);
    if not IncludePrepayments then begin
        SQL.add('AND TT.Type <> "Supplier Prepayment" ');
    end;
    if Wheresql <> '' then SQL.Add(' AND ' + Wheresql );
    SQL.add('Group By ClientID,Type');
  end;

  procedure AddSummarySQL;
  begin
    SQL.add('SELECT ');
    SQL.add('NULL as TransID, ');//SQL.add('TT.TransID, ');
    SQL.add('NULL as GlobalRef,');//SQL.add('TT.GlobalRef,');
    SQL.add('TT.SupplierName as SupplierName,');
    SQL.add('null as Type,');
    SQL.add('Null as OrderDate,');
    SQL.add('Null as InvoiceDate,');
    SQL.add('Null as DueDate,');
    SQL.add('Null as PONumber,');
    SQL.add('TT.Name as Name,');
    SQL.add('Sum(Round(OriginalAmount,'+inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'])+')) as OriginalAmount,');
    SQL.add('Sum(Round(TT.AmountDue,'+inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'])+')) as AmountDue,');
    SQL.add('Sum(Round(Current,'+inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'])+')) as Current,');
    SQL.add('Sum(Round(30Days,'+inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'])+')) as 30Days,');
    SQL.add('Sum(Round(60Days,'+inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'])+')) as 60Days,');
    SQL.add('Sum(Round(90Days,'+inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'])+')) as 90Days,');
    SQL.add('Sum(Round(120Days,'+inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'])+')) as 120Days,');
    DetailFCs1;
    SQL.add('NULL as PurchaseOrderID,');//SQL.add('TT.PurchaseOrderID as PurchaseOrderID,');
    SQL.add('0 as Details,');
    SQL.add('TT.ClientID,');
    SQL.add('C.Printname as Printname,');
    SQL.add('Null as InvoiceNumber,');
    SQL.add('"" as AccountName,');
    SQL.add('"" as Notes,');
    SQL.add('"" as APNotes,');
    SQL.add('NULL as POGlobalRef, ');
    SQL.add('" " as Terms, ');
    SQL.add('Null as PCStatus');
    SQL.add('FROM ' + TempTableName + ' AS TT  left join tblclients C on C.clientId = TT.clientID');
    SQL.add('LEFT JOIN tblPurchaseOrders PO ON TT.PurchaseOrderId = PO.PurchaseOrderID');

    SQL.add('Where round(abs(TT.AmountDue),' +inttostr(AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces']) +' ) <>0.00');
    if AppEnvVirt.Bool['CompanyPrefs.UseApprovalLevels'] then SQL.Add('AND PO.Approved = "T"');
    if not CalenderAgeing  then
      if AgeByTransactionDate then
        SQL.add('AND TT.OrderDate Between ' + DateFromSQL + ' AND ' + DateToSQL)
      else
       SQL.add('AND TT.DueDate Between ' + DateFromSQL + ' AND ' + DateToSQL);
    if not IncludePrepayments then begin
        SQL.add('AND TT.Type <> "Supplier Prepayment" ');
    end;
    if Wheresql <> '' then SQL.Add(' AND ' + Wheresql );
    SQL.add('Group By ClientID');
  end;


begin
  result := inherited;
  SQL.Clear;

  PopulateReportTables;

  FCR :=  DbSharedObjectsObj.DbSharedObj.GetQuery(TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']));
  try
    LoadFCPref(FCR, fReportClassName, true);
    FCR.First;

    if APIMode then begin
      sl := TStringList.Create;
      TypeCount := 0;
      try
        sl.CaseSensitive := false;
        sl.CommaText := self.ReportType;
        if sl.IndexOf('ExtraDetail') > -1 then begin
          AddExtraDetailSQL;
          Inc(TypeCount);
        end;
        if sl.IndexOf('Detail') > -1 then begin
          if TypeCount > 0 then
            SQL.add('Union All');
          AddDetailSQL;
          Inc(TypeCount);
        end;
        if sl.IndexOf('Summary') > -1 then begin
          if TypeCount > 0 then
            SQL.add('Union All');
          AddSummarySQL;
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
      AddExtraDetailSQL;
      SQL.add('UNION ALL');
      AddDetailSQL;
      SQL.add('UNION ALL');
      AddSummarySQL;

    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(FCR);
  end;
end;

procedure TAPReport.PopulateReportTables;
var
  FCFields: string;
  FCR: TERPQuery;
  SQL: string;
  AP_Report_Obj: TAP_Report_Obj;
begin
  if TempTableName <> '' then
    TempTableUtils.DestroyUserTemporaryTable(TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']), TempTableName);

  //TempTableName := commondbLib.CreateUserTemporaryTable('tmp_tblaccountspayable' , '');
  TempTableName := TempTableUtils.CreateUserTemporaryTable(TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']), 'tmp_tblaccountspayable');
  FCFields := '';


  FCR := DbSharedObjectsObj.DbSharedObj.GetQuery(TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']));
  try
    LoadFCPref(FCR,fReportClassName, true);
    if FCR.RecordCount > 0 then begin
      FCR.First;
      while not FCR.Eof do begin
        if SQL <> '' then SQL := SQL + #13#10;
        SQL := SQL + 'alter table ' + TempTableName + ' add column `' + FCR.Fieldbyname('Code').AsString + '_FCRate` Double;';
        if FCFields <> '' then FCFields := FCFields + ',' ;
        FCFields := FCFields + FCR.Fieldbyname('Code').asString + '_FCRate';
        FCR.Next;
      end;
      ExecuteSQL(SQL);
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(FCR);
  end;

  AP_Report_Obj := TAP_Report_Obj.Create(not APIMode);
  try
    if fClientId = 0 then fClientID := -1;
    AP_Report_Obj.CleanRefresh_AP_Table(
      IgnoreDates,DateTo,DepartmentID,DepartmentID = 0,ClientID,
      AgeByTransactionDate, TempTableName,FCFields,CalenderAgeing);
  finally
    AP_Report_Obj.Free;
  end;
end;

(*procedure TAPReport.SetDateFrom(const Value: TDateTime);
begin
  fDateFrom := Value;
  fIgnoreDates := (fDateFrom = MinDateTime) and (fDateTo = MaxDateTime);
end;

procedure TAPReport.SetDateTo(const Value: TDateTime);
begin
  fDateTo := Value;
  fIgnoreDates := (fDateFrom = MinDateTime) and (fDateTo = MaxDateTime);
end;*)

initialization
  RegisterClass(TAPReport);

end.
