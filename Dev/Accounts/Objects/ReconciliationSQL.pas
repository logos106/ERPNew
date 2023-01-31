unit ReconciliationSQL;



interface

uses
  classes, ReportBaseObj;

Type

  TReconciliationList = class(TReportWithDateRangeBase)

  Private

  Protected


  Public
    constructor Create; Override;

    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;


  Published
  //  property ByCustomer             : Boolean   Write fbByCustomer  ;

  end;



implementation

uses sysutils, ProductQtyLib;

{ TSalesList }

constructor TReconciliationList.Create;
begin
  inherited;
  DateFrom             := MinDateTime;
  DateTo               := MaxDateTime;
 end;


(*function TSalesList.DateFromSQL: string;
begin
  REsult := DateSQL(fDateFrom, 'DateFrom');
end;
function TSalesList.DateToSQL: string;
begin
  REsult := DateSQL(fDateTo, 'DateTo');
end;*)


function TReconciliationList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin

  SQL.Clear;
  result := inherited;

    SQL.Add('SELECT tblreconciliation.*, tblreconciliation.Finished AS OnHold, E.EmployeeName, E.Position, C.ClassName AS Department, A.AccountName FROM tblreconciliation');
    SQL.Add('  LEFT JOIN tblemployees E ON tblreconciliation.EmployeeID = E.EmployeeID');
    SQL.Add('  LEFT JOIN tblclass C ON tblreconciliation.ClassID = C.ClassID');
    SQL.Add('  LEFT JOIN tblchartofaccounts A ON tblreconciliation.AccountID = A.AccountID');


   SQL.Add(' WHERE tblreconciliation.ReconciliationDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL);

   if not (Search = '') then
      SQL.Add('AND ' + Search);

   if not (OrderBy = '') then
      SQL.Add('ORDER BY ' + OrderBy);


end;





initialization

  RegisterClass(TReconciliationList);

end.
