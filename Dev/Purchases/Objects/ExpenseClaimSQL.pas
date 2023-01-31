unit ExpenseClaimSQL;

interface
uses
  classes, ReportBaseObj, Types;

type

  TExpenseClaimReport = class(TReportWithDateRangeBase)
  private
    (*fDateTo: TDateTime;
    fDateFrom: TDateTime;*)
    fStatus: string;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  published
    (*property DateFrom: TDateTime read fDateFrom write fDateFrom;
    property DateTo: TDateTime read fDateTo write fDateTo;*)
    property Status: string read fStatus write fStatus;
  end;


implementation

uses
  SysUtils;

{ TExpenseClaimReport }

constructor TExpenseClaimReport.Create;
begin
  inherited;
  DateTo :=  MaxDateTime;
  DateFrom := 0;
  fStatus := 'All';
end;

destructor TExpenseClaimReport.Destroy;
begin

  inherited;
end;

function TExpenseClaimReport.PopulateReportSQL(SQL: TStrings;
  var msg: string): boolean;
begin
  inherited;
  result := true;
  msg := '';
  SQL.Clear;
  SQL.Add('select');
  SQL.Add('1 as Seqno,');
  SQL.Add('PO.GlobalRef as GlobalRef,');
  SQL.Add('PO.PurchaseOrderID as PurchaseOrderID,');
  SQL.Add('EC.ExpenseClaimId as ExpenseClaimID,');
  SQL.Add('"Cheque" AS Type,');
  SQL.Add('E.EmployeeName as EmployeeName,');
  SQL.Add('C.ClientID as ClientID,');
  SQL.Add('C.Company as Company,');
  SQL.Add('EC.Description as Description,');
  SQL.Add('PO.PurchaseOrderNumber as ClaimNumber,');
  SQL.Add('Convert(EC.DateTime, Date) as Claimdate,');
  SQL.Add('date(PO.OrderDate) as OrderDate,');
  SQL.Add('PO.Approved as Approved,');
  SQL.Add('PO.Paid as Paid,');
  SQL.Add('PO.Comments as Comments,');
  SQL.Add('C.Contact1 as Contact,');
  SQL.Add('PO.ETADate as ETADate,');
  SQL.Add('C.Phone as Phone,');
  SQL.Add('POL.Invoiced as Invoiced,');
  SQL.Add('PO.IsCredit as IsCredit,');
  SQL.Add('PO.InvoiceNumber as InvoiceNumber,');
  SQL.Add('PO.IsRA as IsRA,');
  SQL.Add('PO.Deleted as Deleted,');
  SQL.Add('PO.SalesComments as SalesComments,');
  SQL.Add('PO.TotalAmount as TotalAmountEx,');
  SQL.Add('PO.TotalTax as TotalTax,');
  SQL.Add('PO.TotalAmountInc as TotalAmountInc,');
  SQL.Add('null as Processed,');
  SQL.Add('ECL.Approval as Status');
  SQL.Add('FROM tblexpenseclaim EC');
  SQL.Add('inner join tblexpenseclaimline ECL on EC.ExpenseClaimID = ECL.ExpenseClaimID');
  SQL.Add('inner join tblPurchaseOrders PO on ECL.ChequeId = PO.purchaseOrderId');
  SQL.Add('INNER JOIN tblPurchaseLines POL ON (PO.PurchaseOrderID = POL.PurchaseOrderID)');
  SQL.Add('LEFT JOIN tblClients C ON  (PO.SupplierName = C.Company)');
  SQL.Add('LEFT JOIN tblParts ON  (POL.ProductName = tblParts.PARTName)');
  SQL.Add('LEFT JOIN tblemployees E ON (PO.ExpenseClaimEmployee = E.EmployeeID)');
  SQL.Add('WHERE POL.AccountName <> Space(1)');
  SQL.Add('AND (PO.IsCheque = "T")');
  SQL.Add('AND (PO.ExpenseClaimEmployee <> 0)');
  SQL.Add('AND OrderDate Between ' + QuotedStr(FormatDateTime('yyyy-mm-dd',DateFrom)) + ' AND ' +QuotedStr(FormatDateTime('yyyy-mm-dd',DateTo)));
  SQL.Add('and ((PO.OrderStatus = ' + QuotedStr(Status) + ') or (' + QuotedStr(Status) + ' = "All") or (' + QuotedStr(Status) + ' = "Processed" and ECL.Processed = "T"))');
  SQL.Add('GROUP BY PO.PurchaseOrderID');
  SQL.Add('union all');
  SQL.Add('SELECT');
  SQL.Add('2 as Seqno,');
  SQL.Add('PO.GlobalRef as GlobalRef,');
  SQL.Add('PO.PurchaseOrderID as PurchaseOrderID,');
  SQL.Add('EC.ExpenseClaimId as ExpenseClaimID,');
  SQL.Add('"Bill" AS Type,');
  SQL.Add('E.EmployeeName as EmployeeName,');
  SQL.Add('C.ClientID as ClientID,');
  SQL.Add('C.Company as Company,');
  SQL.Add('EC.Description as Description,');
  SQL.Add('PO.PurchaseOrderNumber as ClaimNumber,');
  SQL.Add('Convert(EC.DateTime, Date) as Claimdate,');
  SQL.Add('date(PO.OrderDate) as OrderDate,');
  SQL.Add('PO.Approved as Approved,');
  SQL.Add('PO.Paid as Paid,');
  SQL.Add('PO.Comments as Comments,');
  SQL.Add('C.Contact1 as Contact,');
  SQL.Add('PO.ETADate as ETADate,');
  SQL.Add('C.Phone as Phone,');
  SQL.Add('POL.Invoiced as Invoiced,');
  SQL.Add('PO.IsCredit as IsCredit,');
  SQL.Add('PO.InvoiceNumber as InvoiceNumber,');
  SQL.Add('PO.IsRA as IsRA,');
  SQL.Add('PO.Deleted as Deleted,');
  SQL.Add('PO.SalesComments as SalesComments,');
  SQL.Add('PO.TotalAmount as TotalAmountEx,');
  SQL.Add('PO.TotalTax as TotalTax,');
  SQL.Add('PO.TotalAmountInc as TotalAmountInc,');
  SQL.Add('null as Processed,');
  SQL.Add('ECL.Approval as Status');
  SQL.Add('FROM tblexpenseclaim EC');
  SQL.Add('inner join tblexpenseclaimline ECL on EC.ExpenseClaimID = ECL.ExpenseClaimID');
  SQL.Add('inner join tblPurchaseOrders PO on ECL.BillID = PO.purchaseOrderId');
  SQL.Add('INNER JOIN tblPurchaseLines POL ON (PO.PurchaseOrderID = POL.PurchaseOrderID)');
  SQL.Add('LEFT JOIN tblClients C ON  (PO.SupplierName = C.Company)');
  SQL.Add('LEFT JOIN tblParts ON  (POL.ProductName = tblParts.PARTName)');
  SQL.Add('LEFT JOIN tblemployees E ON (PO.ExpenseClaimEmployee = E.EmployeeID)');
  SQL.Add('WHERE POL.AccountName <> Space(1) AND PO.OrderDate');
  SQL.Add('AND (PO.IsBill = "T")');
  SQL.Add('AND (PO.ExpenseClaimEmployee <> 0)');
  SQL.Add('AND OrderDate Between ' + QuotedStr(FormatDateTime('yyyy-mm-dd',DateFrom)) + ' AND ' +QuotedStr(FormatDateTime('yyyy-mm-dd',DateTo)));
  SQL.Add('and ((PO.OrderStatus = ' + QuotedStr(Status) + ') or (' + QuotedStr(Status) + ' = "All") or (' + QuotedStr(Status) + ' = "Processed" and ECL.Processed = "T"))');
  SQL.Add('GROUP BY PO.PurchaseOrderID');
  SQL.Add('union all');
  SQL.Add('select');
  SQL.Add('3 as Seqno,');
  SQL.Add('EC.GlobalRef as GlobalRef,');
  SQL.Add('null as PurchaseOrderID,');
  SQL.Add('EC.ExpenseClaimId as ExpenseClaimID,');
  SQL.Add('if(EC.active="F" , "Deleted Request" , "Request") as Type,');
  SQL.Add('EC.EmployeeName as EmployeeName,');
  SQL.Add('null as ClientID,');
  SQL.Add('NULL as Company,');
  SQL.Add('EC.Description as Description,');
  SQL.Add('EC.RefNo as ClaimNumber,');
  SQL.Add('Convert(EC.DateTime, Date) as Claimdate,');
  SQL.Add('Null as OrderDate,');
  SQL.Add('null as Approved,');
  SQL.Add('"F" as Paid,');
  SQL.Add('EC.Comments as Comments,');
  SQL.Add('null as Contact,');
  SQL.Add('Date("1001-01-01") as ETADate,');
  SQL.Add('null as Phone,');
  SQL.Add('"F" as Invoiced,');
  SQL.Add('"F" as IsCredit,');
  SQL.Add('Null as InvoiceNumber,');
  SQL.Add('"F" as IsRA,');
  SQL.Add('if(EC.Active = "T","F","T") as Deleted,');
  SQL.Add('null as SalesComments,');
  SQL.Add('EC.TotalAmountEx as "TotalAmountEx",');
  SQL.Add('EC.TotalTax as "TotalTax",');
  SQL.Add('EC.TotalAmountInc as "TotalAmountInc",');
  SQL.Add('EC.Processed as Processed,');
  SQL.Add('ECL.Approval as Status');
  SQL.Add('from tblExpenseClaim EC');
  SQL.Add('inner join tblExpenseClaimLine ECL on ECL.ExpenseClaimId = EC.ExpenseClaimId');
  SQL.Add('where EC.DateTime Between ' + QuotedStr(FormatDateTime('yyyy-mm-dd',DateFrom)) + ' AND ' +QuotedStr(FormatDateTime('yyyy-mm-dd',DateTo)));
  SQL.Add('and ((ECL.Approval = ' + QuotedStr(Status) + ') or (' + QuotedStr(Status) + '= "All") or (' + QuotedStr(Status) + ' = "Processed" and EC.Processed = "T"))');
  SQL.Add('group by ECL.ExpenseClaimId');
  SQL.Add('union all');
  SQL.Add('SELECT');
  SQL.Add('4 as Seqno,');
  SQL.Add('PO.GlobalRef as GlobalRef,');
  SQL.Add('PO.PurchaseOrderID as PurchaseOrderID,');
  SQL.Add('NULL as ExpenseClaimID,');
  SQL.Add('If(PO.IsBill="T","Bill",If(PO.IsCredit="T","Credit","PO")) AS Type,');
  SQL.Add('E.EmployeeName as EmployeeName,');
  SQL.Add('C.ClientID as ClientID,');
  SQL.Add('C.Company as Company,');
  SQL.Add('NULL as Description,');
  SQL.Add('PO.PurchaseOrderNumber as ClaimNumber,');
  SQL.Add('NULL as Claimdate,');
  SQL.Add('date(PO.OrderDate) as OrderDate,');
  SQL.Add('PO.Approved as Approved,');
  SQL.Add('PO.Paid as Paid,');
  SQL.Add('PO.Comments as Comments,');
  SQL.Add('C.Contact1 as Contact,');
  SQL.Add('PO.ETADate as ETADate,');
  SQL.Add('C.Phone as Phone,');
  SQL.Add('POL.Invoiced as Invoiced,');
  SQL.Add('PO.IsCredit as IsCredit,');
  SQL.Add('PO.InvoiceNumber as InvoiceNumber,');
  SQL.Add('PO.IsRA as IsRA,');
  SQL.Add('PO.Deleted as Deleted,');
  SQL.Add('PO.SalesComments as SalesComments,');
  SQL.Add('if(PO.ISCredit="T" , 0-PO.TotalAmount , PO.TotalAmount ) as TotalAmountEx,');
  SQL.Add('if(PO.ISCredit="T" , 0-PO.TotalTax , PO.TotalTax ) as TotalTax,');
  SQL.Add('if(PO.ISCredit="T" , 0-PO.TotalAmountInc , PO.TotalAmountInc ) as TotalAmountInc,');
  SQL.Add('null as Processed,');
  SQL.Add('ECL.Approval as Status');
  SQL.Add('FROM tblPurchaseOrders PO');
  SQL.Add('INNER JOIN tblPurchaseLines POL ON (PO.PurchaseOrderID = POL.PurchaseOrderID)');
  SQL.Add('LEFT JOIN tblClients C ON  (PO.SupplierName = C.Company)');
  SQL.Add('LEFT JOIN tblemployees E ON (PO.ExpenseClaimEmployee = E.EmployeeID)');
  SQL.Add('Left join tblexpenseclaimline ECL on ECL.ChequeId = PO.purchaseOrderId or ECL.BillId= PO.purchaseOrderId');
  SQL.Add('WHERE ifnull(ECL.ExpenseClaimLineID,0)=0 and   POL.AccountName <> Space(1) AND PO.OrderDate');
  SQL.Add('AND (PO.IsBill = "T" OR PO.IsCredit = "T" OR PO.IsPO = "T")');
  SQL.Add('AND (PO.ExpenseClaimEmployee <> 0)');
  SQL.Add('AND OrderDate Between '  + QuotedStr(FormatDateTime('yyyy-mm-dd',DateFrom)) + ' AND ' +QuotedStr(FormatDateTime('yyyy-mm-dd',DateTo)));
  SQL.Add('and ((PO.OrderStatus = ' + QuotedStr(Status) + ') or (' + QuotedStr(Status) + ' = "All") or (' + QuotedStr(Status) + ' = "Processed" and ECL.Processed = "T"))');
  SQL.Add('GROUP BY PO.PurchaseOrderID ');
  SQL.Add('union all');
  SQL.Add('select');
  SQL.Add('5 as Seqno,');
  SQL.Add('EC.GlobalRef as GlobalRef, ');
  SQL.Add('null as PurchaseOrderID,');
  SQL.Add('EC.ExpenseClaimId as ExpenseClaimID,');
  SQL.Add('if(EC.active="F" or ifnull(ECL.ExpenseClaimLineID,0)=0 , "Deleted Request" , "Request") as Type,');
  SQL.Add('EC.EmployeeName as EmployeeName,');
  SQL.Add('null as ClientID,');
  SQL.Add('NULL as Company,');
  SQL.Add('EC.Description as Description,');
  SQL.Add('EC.RefNo as ClaimNumber,');
  SQL.Add('Convert(EC.DateTime, Date) as Claimdate,');
  SQL.Add('Null as OrderDate,');
  SQL.Add('null as Approved,');
  SQL.Add('"F" as Paid,');
  SQL.Add('EC.Comments as Comments,');
  SQL.Add('null as Contact,');
  SQL.Add('Date("1001-01-01") as ETADate,');
  SQL.Add('null as Phone,');
  SQL.Add('"F" as Invoiced,');
  SQL.Add('"F" as IsCredit,');
  SQL.Add('Null as InvoiceNumber,');
  SQL.Add('"F" as IsRA,');
  SQL.Add('if(EC.Active = "T","F","T") as Deleted,');
  SQL.Add('null as SalesComments,');
  SQL.Add('EC.TotalAmountEx as "TotalAmountEx",');
  SQL.Add('EC.TotalTax as "TotalTax",');
  SQL.Add('EC.TotalAmountInc as "TotalAmountInc",');
  SQL.Add('EC.Processed as Processed,');
  SQL.Add('ECL.Approval as Status');
  SQL.Add('from tblExpenseClaim EC');
  SQL.Add('left join tblExpenseClaimLine ECL on ECL.ExpenseClaimId = EC.ExpenseClaimId');
  SQL.Add('where EC.DateTime Between '  + QuotedStr(FormatDateTime('yyyy-mm-dd',DateFrom)) + ' AND ' +QuotedStr(FormatDateTime('yyyy-mm-dd',DateTo)));
  SQL.Add('and ifnull(ECL.ExpenseClaimLineID,0)=0 and ' + QuotedStr(Status) + ' = "All"');
  SQL.Add('group by ECL.ExpenseClaimId');
  SQL.Add('order by claimdate desc ,ExpenseClaimID desc, orderdate desc, Type,company');

end;

initialization
  RegisterClass(TExpenseClaimReport);

end.
