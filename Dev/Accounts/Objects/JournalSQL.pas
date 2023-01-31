unit JournalSQL;


interface

uses
  classes, ReportBaseObj;

Type

  TJournalEntryList = class(TReportWithDateRangeBase)

  Private
    FReconciled: Boolean;

  Protected


  Public
    constructor Create; Override;

    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;


  Published
  //  property ByCustomer             : Boolean   Write fbByCustomer  ;

    property Reconciled: Boolean read FReconciled write FReconciled;
  end;



implementation

uses sysutils, ProductQtyLib;

{ TSalesList }

constructor TJournalEntryList.Create;
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


function TJournalEntryList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin

  SQL.Clear;
  result := inherited;

  SQL.Add('SELECT * FROM tblgeneraljournal J');
  SQL.Add(' LEFT JOIN tblgeneraljournaldetails JD ON J.GJID = JD.GJID');
  SQL.Add(' WHERE J.TransactionDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL);

 if not (Search = '') then
    SQL.Add('AND J.' + Search);

 if not (OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy);

end;

initialization

  RegisterClass(TJournalEntryList);

end.
