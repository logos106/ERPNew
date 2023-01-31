unit ChequeExSQL;

interface

uses
  classes, ReportBaseObj;

Type

  TChequeList = class(TReportWithDateRangeBase)

  Private
    FReconciled: Boolean;

  Public
    constructor Create; Override;

    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;


  Published
  //  property ByCustomer             : Boolean   Write fbByCustomer  ;

    property Reconciled: Boolean read FReconciled write FReconciled;
  end;

  TCreditList = class(TReportWithDateRangeBase)

  Private


  Public
    constructor Create; Override;

    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;


  Published
  //  property ByCustomer             : Boolean   Write fbByCustomer  ;

  end;




implementation

uses sysutils, ProductQtyLib;

{ TSalesList }

constructor TChequeList.Create;
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


function TChequeList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
  SQL.Clear;
  result := inherited;
  SQL.Add('SELECT * from tblPurchaseOrders ');
  SQL.Add(' WHERE IsCheque = "T"');
  SQL.Add(' AND  tblPurchaseOrders.OrderDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL);
  if not (Search = '') then SQL.Add('AND ' + Search);
  if not (OrderBy = '') then
      SQL.Add('ORDER BY ' + OrderBy);
end;


constructor TCreditList.Create;
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


function TCreditList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin

  SQL.Clear;
  result := inherited;

    SQL.Add('SELECT * from tblPurchaseOrders WHERE IsCredit = "T"');


   SQL.Add(' AND  tblPurchaseOrders.OrderDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL);

   if not (Search = '') then
      SQL.Add('AND ' + Search);

   if not (OrderBy = '') then
      SQL.Add('ORDER BY ' + OrderBy);


end;




initialization

   RegisterClass(TChequeList);

   RegisterClass(TCreditList);


end.
