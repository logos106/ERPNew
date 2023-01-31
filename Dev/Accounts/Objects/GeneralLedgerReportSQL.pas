unit GeneralLedgerReportSQL;

interface

uses
  ERPDbComponents, DAScript, SysUtils, classes, Types, DB, ReportBaseObj;

type

  TGeneralLedgerReport = class(TReportWithDateRangeBase)
  private
(*    fDateTo: TDateTime;
    fDateFrom: TDateTime;
    fIgnoreDates: boolean;*)
    fReportOnForeignCurrency: boolean;
    fReportType: string;
    fReportClassName: string;
    fDepartmentID: integer;
    FCFields: string;
    AmountFieldList, AmountCaptionList: TStringDynArray;
    fAccountID: integer;
    procedure PopulateReportTables;
(*    procedure SetDateFrom(const Value: TDateTime);
    procedure SetDateTo(const Value: TDateTime);
    function DateFromSQL: string;
    function DateToSQL: string;*)
  public
    TempTableName: string;
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
    property ReportClassName: string read fReportClassName write fReportClassName;
  published
(*    property DateFrom: TDateTime read fDateFrom write SetDateFrom;
    property DateTo: TDateTime read fDateTo write SetDateTo;
    property IgnoreDates: boolean read fIgnoreDates write fIgnoreDates;*)
    property DepartmentID: integer read fDepartmentID write fDepartmentID;
    property AccountID: integer read fAccountID write fAccountID;
    property ReportOnForeignCurrency: boolean read fReportOnForeignCurrency write fReportOnForeignCurrency;
    property ReportType: string read fReportType write fReportType; { Summary, Detail, ExtraDetail }
  end;


implementation

uses
  CommonDbLib, BusObjFCOnReport, BaseListUtilsObj, tcConst, SyncReportTableObj;

{ TAPReport }

constructor TGeneralLedgerReport.Create;
begin
  inherited;
  DateFrom := MinDateTime;
  DateTo := MaxDateTime;
  IgnoreDates := true;

  fReportOnForeignCurrency := false;
  fDepartmentID := 0;
  fAccountID := 0;
  fReportType := 'ExtraDetail';
  fReportClassName := 'TGeneralLedgerReportGUI';
end;

(*function TGeneralLedgerReport.DateFromSQL: string;
var
  dt: TDateTime;
begin
  if fIgnoreDates then dt := MinDateTime
  else dt := fDateFrom;
  result := '"' + FormatDateTime('yyyy-mm-dd',dt) + '"';
end;

function TGeneralLedgerReport.DateToSQL: string;
var
  dt: TDateTime;
begin
  if fIgnoreDates then dt := MaxDateTime
  else dt := fDateTo;
  result := '"' + FormatDateTime('yyyy-mm-dd',dt) + '"';
end;*)

destructor TGeneralLedgerReport.Destroy;
begin
  if TempTableName <> '' then
    DestroyUserTemporaryTable(TempTableName);

  inherited;
end;

function TGeneralLedgerReport.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
var
  FCR: TForeignCurrencyOnReport;
  scr: TERPScript;
  UsingReportTables: boolean;
  ctr: integer;
  sl: TStringList;
  TypeCount: integer;


  procedure AddExtraDetail;
  begin
    scr.SQL.add('SELECT');
    scr.SQL.add('Space(255) as Accounts,');
    scr.SQL.add('Trans.Type,');
    scr.SQL.add('Trans.Date,');
    scr.SQL.add('Trans.GlobalRef,');
    scr.SQL.add('CL.ClassName as Class,');
    scr.SQL.add('Trans.AccountName as AccountName,');
    scr.SQL.add('Trans.ClientName as "Client Name",');
    scr.SQL.add('Trans.ProductName,');
    scr.SQL.add('Trans.ProductDesc as ProductDescription,');
    scr.SQL.add('RepName,');
    scr.SQL.add('Trans.TaxCode,');
    scr.SQL.add('(Trans.TaxRate* 100) as TaxRate,');
    scr.SQL.add('DebitsEx as DebitsEx,');
    scr.SQL.add('CreditsEx as CreditsEx,');
    scr.SQL.add('DebitsInc as DebitsInc,');
    scr.SQL.add('CreditsInc as CreditsInc,');
    scr.SQL.add('If((Trans.AccountType = "AR" OR Trans.AccountType = "OASSET" OR Trans.AccountType = "BANK" OR Trans.AccountType = "OCASSET" OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_PAID) + '   OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_COLLECTED) + '),');
    scr.SQL.add('(DebitsEx-CreditsEx),(CreditsEx-DebitsEx)) as "AmountEx",');
    scr.SQL.add('If((Trans.AccountType = "AR" OR Trans.AccountType = "OASSET" OR Trans.AccountType = "BANK" OR Trans.AccountType = "OCASSET" OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_PAID) + '   OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_COLLECTED) + '),');
    scr.SQL.add('(DebitsInc-CreditsInc),(CreditsInc-DebitsInc)) as "AmountInc",');
    scr.SQL.add('COA.AccountNumber,');
    scr.SQL.add('Trans.ClassID,');
    scr.SQL.add('Trans.SaleID,');
    scr.SQL.add('Trans.PurchaseOrderID,');
    scr.SQL.add('Trans.PaymentID,');
    scr.SQL.add('Trans.PrepaymentID,');
    scr.SQL.add('Trans.FixedAssetID,');
    scr.SQL.add('2 as Details,');
    scr.SQL.add('Trans.AccountID,');
    scr.SQL.add('PO.InvoiceNumber as ChequeNumber,');
    scr.SQL.add('if(not IsNull(GLL.GJDID),GLL.Memo,if(not IsNull(ChequeLine.PurchaseLineID),ChequeLine.Product_Description,if (not IsNull(BillLine.PurchaseLineID),BillLine.Product_Description,NULL))) as Memo,');
    scr.SQL.add('if(not IsNull(Bill.PurchaseOrderID),Bill.RefNo,if(not IsNull(SP.PaymentID),SP.ReferenceNo,null))  as ReferenceNo');
    if FCFields <> '' then scr.SQL.add(',' + FCFields);
    scr.SQL.add('FROM tbltransactions as Trans');
    scr.SQL.add('INNER JOIN tblchartofaccounts COA Using(AccountID)');
    scr.SQL.add('Left JOIN tblclass CL on CL.ClassID = Trans.ClassID');
    scr.SQL.add('left join tblPurchaseOrders as PO on PO.PurchaseOrderID = Trans.PurchaseOrderID and Trans.Type = "Cheque"');
    scr.SQL.add('left join tblgeneraljournaldetails as GLL on GLL.GJDID = Trans.Salelineid and Trans.Type = "Journal Entry"');
    scr.SQL.add('left join tblPurchaseOrders as Bill on Bill.PurchaseOrderID = Trans.PurchaseOrderID and Trans.Type = "Bill"');
    scr.SQL.add('left join tblPurchaseLines as ChequeLine on ChequeLine.PurchaseLineID = Trans.PurchaseLineID and Trans.Type = "Cheque"');
    scr.SQL.add('left join tblPurchaseLines as BillLine on BillLine.PurchaseLineID = Trans.PurchaseLineID and Trans.Type = "Bill"');
    scr.SQL.add('left join tblwithdrawal as SP on SP.PaymentID = Trans.PaymentID and Trans.Type = "Supplier Payment"');
    scr.SQL.add('Where Trans.Date Between ' + DateFromSQL + '  AND ' + DateToSQL);
    if DepartmentID <> 0 then
        scr.SQL.add('AND Trans.ClassID = ' + IntToStr(DepartmentID));
    if AccountID > 0 then
        scr.SQL.add('AND Trans.AccountID = ' + IntToStr(AccountID));
  end;

  procedure AddDetail;
  begin
    scr.SQL.add('SELECT');
    scr.SQL.add('"" as AccountName,');
    scr.SQL.add('Trans.Type,');
    scr.SQL.add('Null as Date,');
    scr.SQL.add('"" as GlobalRef,');
    scr.SQL.add('"" as Class,');
    scr.SQL.add('Trans.AccountName as AccountName,');
    scr.SQL.add('""  as "Client Name",');
    scr.SQL.add('"" as ProductName, "" as ProductDescription,');
    scr.SQL.add('"" as RepName,');
    scr.SQL.add('"" as TaxCode,');
    scr.SQL.add('NULL as TaxRate,');
    scr.SQL.add('Sum(DebitsEx) as DebitsEx,');
    scr.SQL.add('Sum(CreditsEx) as CreditsEx,');
    scr.SQL.add('Sum(DebitsInc) as DebitsInc,');
    scr.SQL.add('Sum(CreditsInc) as CreditsInc,');
    scr.SQL.add('If((Trans.AccountType = "AR" OR Trans.AccountType = "OASSET" OR Trans.AccountType = "BANK" OR Trans.AccountType = "OCASSET" OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_PAID) + '   OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_COLLECTED) + '),');
    scr.SQL.add('Sum(DebitsEx) - Sum(CreditsEx),Sum(CreditsEx) - Sum(DebitsEx)) as "AmountEx",');
    scr.SQL.add('If((Trans.AccountType = "AR" OR Trans.AccountType = "OASSET" OR Trans.AccountType = "BANK" OR Trans.AccountType = "OCASSET" OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_PAID) + '   OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_COLLECTED) + '),');
    scr.SQL.add('Sum(DebitsInc) - Sum(CreditsInc),Sum(CreditsInc) - Sum(DebitsInc)) as "AmountInc",');
    scr.SQL.add('COA.AccountNumber,');
    scr.SQL.add('Null as ClassID,');
    scr.SQL.add('Null as SaleID,');
    scr.SQL.add('Null as PurchaseOrderID,');
    scr.SQL.add('Null as PaymentID,');
    scr.SQL.add('Null as PrepaymentID,');
    scr.SQL.add('Null as FixedAssetID,');
    scr.SQL.add('1 as Details,');
    scr.SQL.add('Trans.AccountID,');
    scr.SQL.add('Null as ChequeNumber,');
    scr.SQL.add('Null as Memo,');
    scr.SQL.add('Null as ReferenceNo');
    if FCFields <> '' then scr.SQL.add(',' + FCFields);
    scr.SQL.add('FROM tbltransactions as Trans');
    scr.SQL.add('INNER JOIN tblchartofaccounts COA Using(AccountID)');
    scr.SQL.add('Left JOIN tblclass CL on CL.ClassID = Trans.ClassID');
    scr.SQL.add('Where Trans.Date Between ' + DateFromSQL + '  AND ' + DateToSQL);
    if DepartmentID <> 0 then
        scr.SQL.add('AND Trans.ClassID = ' + IntToStr(DepartmentID));
    if AccountID > 0 then
        scr.SQL.add('AND Trans.AccountID = ' + IntToStr(AccountID));
    scr.SQL.add('Group By Trans.AccountID,Type');
  end;

  procedure AddSummary;
  begin
    scr.SQL.add('SELECT');
    scr.SQL.add('SUBSTRING(If((char_length(COA.AccountGroup)>0),Concat(Replace(COA.AccountGroup,"^"," - ") ," - ",Trans.AccountName),Trans.AccountName),1,255) as Accounts,');
    scr.SQL.add('Null as Type,');
    scr.SQL.add('Null as Date,');
    scr.SQL.add('"" as GlobalRef,');
    scr.SQL.add('"" as Class,');
    scr.SQL.add('Trans.AccountName as AccountName,');
    scr.SQL.add('""  as "Client Name",');
    scr.SQL.add('"" as ProductName,');
    scr.SQL.add('"" as ProductDescription,');
    scr.SQL.add('"" as RepName,');
    scr.SQL.add('"" as TaxCode,');
    scr.SQL.add('NULL as TaxRate,');
    scr.SQL.add('Sum(DebitsEx) as DebitsEx,');
    scr.SQL.add('Sum(CreditsEx) as CreditsEx,');
    scr.SQL.add('Sum(DebitsInc) as DebitsInc,');
    scr.SQL.add('Sum(CreditsInc) as CreditsInc,');
    scr.SQL.add('If((Trans.AccountType = "AR" OR Trans.AccountType = "OASSET" OR Trans.AccountType = "BANK" OR Trans.AccountType = "OCASSET" OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_PAID) + '   OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_COLLECTED) + '),');
    scr.SQL.add('Sum(DebitsEx) - Sum(CreditsEx),Sum(CreditsEx) - Sum(DebitsEx)) as "AmountEx",');
    scr.SQL.add('If((Trans.AccountType = "AR" OR Trans.AccountType = "OASSET" OR Trans.AccountType = "BANK" OR Trans.AccountType = "OCASSET" OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_PAID) + '   OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_COLLECTED) + '),');
    scr.SQL.add('Sum(DebitsInc) - Sum(CreditsInc),Sum(CreditsInc) - Sum(DebitsInc)) as "AmountInc",');
    scr.SQL.add('COA.AccountNumber,');
    scr.SQL.add('Null as ClassID,');
    scr.SQL.add('Null as SaleID,');
    scr.SQL.add('Null as PurchaseOrderID,');
    scr.SQL.add('Null as PaymentID,');
    scr.SQL.add('Null as PrepaymentID,');
    scr.SQL.add('Null as FixedAssetID,');
    scr.SQL.add('0 as Details,');
    scr.SQL.add('Trans.AccountID,');
    scr.SQL.add('Null as ChequeNumber,');
    scr.SQL.add('Null as Memo,');
    scr.SQL.add('Null as ReferenceNo');
    if FCFields <> '' then scr.SQL.add(',' + FCFields);
    scr.SQL.add('FROM tbltransactions as Trans');
    scr.SQL.add('INNER JOIN tblchartofaccounts COA Using(AccountID)');
    scr.SQL.add('Left JOIN tblclass CL on CL.ClassID = Trans.ClassID');
    scr.SQL.add('Where Trans.Date Between ' + DateFromSQL + '  AND ' + DateToSQL);
    if DepartmentID <> 0 then
        scr.SQL.add('AND Trans.ClassID = ' + IntToStr(DepartmentID));
    if AccountID > 0 then
        scr.SQL.add('AND Trans.AccountID = ' + IntToStr(AccountID));
    scr.SQL.add('Group By Trans.AccountID');
  end;


begin
  result := inherited;
  SQL.Clear;

  PopulateReportTables;

  FCR := TForeignCurrencyOnReport.CreateWithSharedConn(nil);
  scr := TERPScript.Create(nil);
  try
    scr.Connection := CommonDbLib.GetSharedMyDacConnection;
    FCR.LoadFCPref(fReportClassName);
    FCR.First;


      scr.SQL.Add('truncate ' + TempTableName +';');
      scr.SQL.add('insert into ' + TempTableName);
      scr.SQL.add('(Accounts , Type , Date , GlobalRef, Class , AccountName , `Client Name` , ProductName ,');
      scr.SQL.add('ProductDescription ,RepName, TaxCode , TaxRate , DebitsEx, CreditsEx, DebitsInc,');
      scr.SQL.add('CreditsInc, AmountEx, AmountInc, AccountNumber, ClassID, SaleID, PurchaseOrderID, PaymentID,');
      scr.SQL.add('PrepaymentID, FixedAssetID, Details, AccountID, ChequeNumber, Memo, ReferenceNo');
      if FCFields <> '' then scr.SQL.add(',' + FCFields);
      scr.SQL.add(')');

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
              scr.SQL.add('Union All');
            AddDetail;
            Inc(TypeCount);
          end;
          if sl.IndexOf('Summary') > -1 then begin
            if TypeCount > 0 then
              scr.SQL.add('Union All');
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
        scr.SQL.add('Union All');
        AddDetail;
        scr.SQL.add('Union All');
        AddSummary;
      end;

      scr.SQL.add('Order By AccountID, Details');
      scr.SQL.add('; ');

      if FCR.Count > 0 then begin
        FCR.First;
        while not FCR.EOF do begin
          for ctr := low(AmountFieldList) to high(AmountFieldList) do
            scr.SQL.add('update ' + TempTableName + ' set ' + FCR.Code + '_' + AmountFieldList[ctr] + '  = ' + AmountFieldList[ctr] + ' * ' + FCR.Code + '_FCRate;' );
          FCR.next;
        end;
      end;

      Scr.SQL.Text := SyncReportObj.ChangeQuery(Scr.SQL.Text, UsingReportTables);
      scr.Execute;

      SQL.Text := 'select * from ' + TempTableName;

  finally
    scr.Free;
    FCR.Free;
  end;

end;

procedure TGeneralLedgerReport.PopulateReportTables;
var
  FCR: TForeignCurrencyOnReport;
  SQL: string;
  ctr: integer;
begin
  if TempTableName <> '' then
    DestroyUserTemporaryTable(TempTableName);
  TempTableName := CommonDBLib.CreateUserTemporaryTable('tmp_GeneralLedger' , '');
  FCFields := '';
  FCR := TForeignCurrencyOnReport.CreateWithSharedConn(nil);
  try
    FCR.LoadFCPref(fReportClassName);
    if FCR.Count > 0 then begin
      SQL := '';
      TBaseListUtils.InitFCFields(AmountFieldList,AmountCaptionList,fReportClassName,SharedConnection,APIMode);
      FCR.First;
      while FCR.Eof = False do begin
        SQL := SQL + 'Alter table ' + TempTableName + ' Add column  `' + FCR.Code + '_FCRate` Double, ';
        for ctr := low(AmountFieldList) to high(AmountFieldList) do begin
          if ctr > 0 then SQL := SQL + ', ';
          SQL := SQL + 'Add column  `' + FCR.Code + '_' + AmountFieldList[ctr] + '` Double';
        end;
        SQL := SQL +'; ';
        if FCFields <> '' then FCFields := FCFields + ',' ;
        FCFields := FCFields + FCR.Code + '_FCRate';
        FCR.Next;
      end;
      ExecuteSQL(SQL);
    end;

  finally
    FCR.Free;
  end;
end;

(*procedure TGeneralLedgerReport.SetDateFrom(const Value: TDateTime);
begin
  fDateFrom := Value;
end;

procedure TGeneralLedgerReport.SetDateTo(const Value: TDateTime);
begin
  fDateTo := Value;
end;*)


initialization
  RegisterClass(TGeneralLedgerReport);

end.
