unit LeaveTakenSQL;

interface

uses
  classes, ReportBaseObj;

Type
  TLeaveTaken = class(TReportWithDateRangeBase)
  Private

  Protected

  Public
    constructor Create; Override;

    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  Published

  end;

implementation

uses sysutils, ProductQtyLib, StringUtils;


constructor TLeaveTaken.Create;
begin
   inherited;
   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;


function TLeaveTaken.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
  function ReplaceAlias(AClause: string): string;
  var
    STemp: string;
  begin
    STemp := AClause;
    STemp := ReplaceStr(STemp, 'true', '"T"');
    STemp := ReplaceStr(STemp, 'false', '"F"');
    STemp := ReplaceStr(STemp, 'PayID', '"P.PayID"');
    STemp := ReplaceStr(STemp, 'PayDate', '"P.PayDate"');
    STemp := ReplaceStr(STemp, 'EmployeeID', '"E.PayID"');
    STemp := ReplaceStr(STemp, 'EmployeeName', '"E.EmployeeName"');
    Result := STemp;
  end;
begin
  SQL.Clear;
  result := inherited;

  SQL.Add('SELECT P.PayID, E.EmployeeID, E.EmployeeName, P.PayDate,');
  SQL.Add('L.DateTaken, L.LeaveType, L.Qty as Hours,L.IsCertified');
  SQL.Add('FROM tblPays as P');
  SQL.Add('INNER JOIN tblpaysleave as L using (PayID)');
  SQL.Add('INNER JOIN tblEmployees as E ON E.EmployeeID = P.EmployeeID');

  if not (Search = '') then
    SQL.Add('WHERE ' + ReplaceAlias(Search));

  if not (OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy);

end;

initialization

   RegisterClass(TLeaveTaken);

end.
