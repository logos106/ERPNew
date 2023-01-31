unit ContractorPaymentSummarySQL;

interface
uses
  ERPDbComponents, DAScript, SysUtils, classes, Types, DB, ReportBaseObj;

type

  TContractorPaymentSummary = class(TReportWithDateRangeBase)
  Private
  Protected
  Public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  Published
  end;


implementation

{ TContractorPaymentSummary }

constructor TContractorPaymentSummary.Create;
begin
  inherited;
end;


destructor TContractorPaymentSummary.Destroy;
begin

  inherited;
end;

function TContractorPaymentSummary.PopulateReportSQL(SQL: TStrings;
  var msg: string): boolean;
begin
  result := inherited;
  SQL.Clear;
  SQL.Add('SELECT');
  SQL.Add('"Supplier Payment" AS PaymentType,');
  SQL.Add('meth.NAME          AS PaymentMethod,');
  SQL.Add('meth.IsCreditCard  AS IsCardPayment,');
  SQL.Add('pay.PaymentID      AS PaymentID,');
  SQL.Add('pay.PaymentDate    AS PaymentDate,');
  SQL.Add('pay.Amount         AS PaymentAmount,');
  SQL.Add('if(meth.IsCreditCard = "T",pay.Amount,0.0) AS CardAmount,');
  SQL.Add('if(meth.IsCreditCard = "T",0.0,pay.Amount) AS NonCardAmount,');
  SQL.Add('c.ClientID         AS ClientID,');
  SQL.Add('c.PrintName        AS SupplierPrintName,');
  SQL.Add('c.BillStreet       AS BillStreet,');
  SQL.Add('c.BillStreet2      AS BillStreet2,');
  SQL.Add('c.BillStreet3      AS BillStreed3,');
  SQL.Add('c.BillSuburb       AS BillPlace,');
  SQL.Add('c.BillState        AS BillState,');
  SQL.Add('c.BillPostcode     AS BillPostCode,');
  SQL.Add('c.BillCountry      AS BillCountry,');
  SQL.Add('c.ABN              AS BusinessNumber');
  SQL.Add('from tblwithdrawal AS pay');
  SQL.Add('inner join tblclients c on C.ClientId = pay.SupplierID');
  SQL.Add('inner join tblpaymentmethods meth on meth.PayMethodID = pay.PayMethodID');
  SQL.Add('where pay.ContractorPayment = "T"');
  SQL.Add('and pay.Deleted = "F"');
  SQL.Add('and pay.SupplierPayment = "T"');
  SQL.Add('and pay.PaymentDate between ' + DateFromSQL +' and ' + DateToSQL +'');
  SQL.Add('union all');
  SQL.Add('select');
  SQL.Add('"Cheque"             AS PaymentType,');
  SQL.Add('"Cheque"             AS PaymentMethod,');
  SQL.Add('"F"                  AS IsCardPayment,');
  SQL.Add('chk.PurchaseOrderID  AS PaymentID,');
  SQL.Add('chk.OrderDate        AS PaymentDate,');
  SQL.Add('chk.TotalAmountInc   AS PaymentAmount,');
  SQL.Add('0.0                  AS CardAmount,');
  SQL.Add('chk.TotalAmountInc   AS NonCardAmount,');
  SQL.Add('c.ClientID           AS ClientID,');
  SQL.Add('c.PrintName          AS SupplierPrintName,');
  SQL.Add('c.BillStreet         AS BillStreet,');
  SQL.Add('c.BillStreet2        AS BillStreet2,');
  SQL.Add('c.BillStreet3        AS BillStreed3,');
  SQL.Add('c.BillSuburb         AS BillPlace,');
  SQL.Add('c.BillState          AS BillState,');
  SQL.Add('c.BillPostcode       AS BillPostCode,');
  SQL.Add('c.BillCountry        AS BillCountry,');
  SQL.Add('c.ABN                AS BusinessNumber');
  SQL.Add('FROM tblpurchaseorders chk');
  SQL.Add('INNER JOIN tblclients c on C.ClientId = chk.ClientID');
  SQL.Add('WHERE chk.ContractorPayment = "T"');
  SQL.Add('AND chk.IsCheque = "T"');
  SQL.Add('AND chk.Deleted = "F"');
  SQL.Add('AND chk.OrderDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL + '');
  SQL.Add('ORDER BY SupplierPrintName, PaymentDate');
end;

initialization
  RegisterClass(TContractorPaymentSummary);

end.
