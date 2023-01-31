unit PurchasesBackorderSQL;

interface

uses
  classes, ReportBaseObj, Types;

type

  TPurchasesBackOrderReport = class(TReportWithDateRangeBase)
  private
    fsExtraFilter: String;
    fiCustomerId: Integer;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  published
    Property ExtraFilter :String read fsExtraFilter write fsExtraFilter;
    Property CustomerId :Integer read fiCustomerId write fiCustomerId;
  end;



implementation

uses
  SysUtils, ProductQtyLib, ClipBrd;


constructor TPurchasesBackOrderReport.Create;
begin
  inherited;
  DateTo :=  MaxDateTime;
  DateFrom := 0;
  fsExtraFilter := '';
  CustomerId := 0;
end;

destructor TPurchasesBackOrderReport.Destroy;
begin

  inherited;
end;


function TPurchasesBackOrderReport.PopulateReportSQL(SQL: TStrings;
  var msg: string): boolean;
begin
  result := true;
  msg := '';
  SQL.Clear;
    SQL.add('SELECT S.*, SL.*, C.*');
    SQL.add('FROM tblpurchaseorders S');
    SQL.add('INNER JOIN tblpurchaselines SL on S.PurchaseOrderID = Sl.PurchaseOrderID');
    SQL.add('INNER JOIN tblParts P ON SL.ProductID=P.PartsID');
    SQL.add('INNER JOIN tblClients C ON  (S.ClientID = C.ClientID)');
    SQL.add('LEFT JOIN tblclienttype CT on CT.ClientTypeID = C.ClientTypeID');
    SQL.add('INNER JOIN tblEmployees E ON  S.EmployeeID = E.EmployeeID');
    SQL.add(' WHERE S.Deleted="F"');
    if CustomerId <> 0 then SQL.add('AND   S.clientId =' + inttostr(CustomerId));
    SQL.add(' AND   S.OrderDate Between ' + QuotedStr(FormatDateTime('yyyy-mm-dd',DateFrom)) + ' AND ' +QuotedStr(FormatDateTime('yyyy-mm-dd',DateTo)));
    SQL.add(' AND   SL.Invoiced = "F" AND SL.BackOrder <> 0');
    SQL.add('AND   ifnull(S.BOID , "") = ""');
    if ExtraFilter <> '' then SQL.add('AND   (' + ExtraFilter +')');
   if not (Search = '') then
      SQL.Add('AND ' + Search);
   if not (OrderBy = '') then
      SQL.Add('ORDER BY ' + OrderBy);
end;



initialization

  //removing this object as  TPurchaseOrderList does the same
  //RegisterClass(TPurchasesBackOrderReport);

end.
