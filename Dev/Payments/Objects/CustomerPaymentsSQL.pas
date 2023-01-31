unit CustomerPaymentsSQL;



interface

uses
  classes, ReportBaseObj;

Type

  TCustomerPaymentList = class(TReportWithDateRangeBase)

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

constructor TCustomerPaymentList.Create;
begin
  inherited;
  DateFrom             := MinDateTime;
  DateTo               := MaxDateTime;
 end;

function TCustomerPaymentList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
  SQL.Clear;
  result := inherited;

  if IsDetailReport then begin
    SQL.Add('SELECT tbldeposits.*, DL.*, C.ClassName AS Department FROM tbldeposits');
    SQL.Add('LEFT JOIN tbldepositline DL ON tbldeposits.PaymentID=DL.PaymentID');
    SQL.Add('LEFT JOIN tblclass C ON tbldeposits.ClassID = C.ClassID');
  end
  else begin
    SQL.Add('SELECT tbldeposits.*, C.ClassName AS Department FROM tbldeposits');
    SQL.Add('LEFT JOIN tblclass C ON tbldeposits.ClassID = C.ClassID');
  end;

  SQL.Add(' WHERE tbldeposits.PaymentDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL);

  if not (Search = '') then
    SQL.Add('AND ' + Search);

  if not (OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy);

end;

initialization

  RegisterClass(TCustomerPaymentList);

end.
