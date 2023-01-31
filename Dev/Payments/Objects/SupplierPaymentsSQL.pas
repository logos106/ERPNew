unit SupplierPaymentsSQL;

interface

uses
   classes, ReportBaseObj;

Type

  TSupplierPaymentList = class(TReportWithDateRangeBase)

  Private
    fbIsDetailReport: Boolean;

  Protected

  Public
    constructor Create; Override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

  Published
    property IsDetailReport: Boolean read fbIsDetailReport write fbIsDetailReport;

  end;

implementation

uses sysutils, ProductQtyLib;

constructor TSupplierPaymentList.Create;
begin
   inherited;
   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;

function TSupplierPaymentList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
  SQL.Clear;
  result := inherited;

  if IsDetailReport then begin
    SQL.Add('SELECT tblwithdrawal.*, WL.*, C.ClassName AS Department from tblwithdrawal');
    SQL.Add('LEFT JOIN tblwithdrawallines WL ON tblwithdrawal.PaymentID=WL.PaymentID');
    SQL.Add('LEFT JOIN tblclass C ON tblwithdrawal.ClassID = C.ClassID');
  end
  else begin
    SQL.Add('SELECT tblwithdrawal.*, C.ClassName AS Department from tblwithdrawal');
    SQL.Add('LEFT JOIN tblclass C ON tblwithdrawal.ClassID = C.ClassID');
  end;

  SQL.Add(' WHERE tblwithdrawal.PaymentDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL);

  if not (Search = '') then
    SQL.Add('AND ' + Search);

  if not (OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy);
end;


initialization

   RegisterClass(TSupplierPaymentList);

end.
