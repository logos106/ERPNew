unit BASReturnDetailSQL;

interface

uses
  classes, ReportBaseObj;

Type
  TBASReturnDetail = class(TReportWithDateRangeBase)
  private
    fTransRef: String;
    fTransType: String;
    fID: Integer;
    fCode: String;

  protected

  public
    constructor Create; Override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

  published
    property TransRef:    String    read fTransRef    write fTransRef;
    property TransType:   String    read fTransType   write fTransType;
    property ID:          Integer   read fID          write fID;
    property Code:        String    read fCode        write fCode;

  end;

implementation

uses sysutils, ProductQtyLib, StringUtils, LogLib;

constructor TBASReturnDetail.Create;
begin
   inherited;
   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
   fTransRef := '';
   fTransType := '';
   fID := 0;
   fCode := '';
end;


function TBASReturnDetail.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
  function ReplaceAlias(AClause: string): string;
  var
    STemp: string;
  begin
    STemp := AClause;
    STemp := ReplaceStr(STemp, 'true', '"T"');
    STemp := ReplaceStr(STemp, 'false', '"F"');
    Result := STemp;
  end;
begin
  SQL.Clear;
  Result := inherited;

  SQL.Add('SELECT DISTINCT');
  SQL.Add('R.Id, RL.TransDate DATE, R.Tab1_Type Period,');
  SQL.Add('IF(RL.basCode IN ("G1","G2","G3","G7","G4","G11","G13","G14","G15","G10","G18"), STR_TO_DATE(CONCAT("01/", MonthNo(tab1_month), "/", tab1_year), "%d/%m/%Y"), IF(RL.basCode IN ("_1C","_1E","_1D","_1F","_1G"),');
  SQL.Add('STR_TO_DATE(CONCAT("01/", MonthNo(Tab2_month), "/", Tab2_year), "%d/%m/%Y"), STR_TO_DATE(CONCAT("01/" , MonthNo(Tab3_month), "/", Tab3_year), "%d/%m/%Y"))) DateFrom,');
  SQL.Add('IF(RL.basCode IN ("G1","G2","G3","G7","G4","G11","G13","G14","G15","G10","G18"), DATE_ADD(DATE_ADD(STR_TO_DATE(CONCAT("01/", MonthNo(tab1_month) , "/", tab1_year), "%d/%m/%Y"), INTERVAL DateRangetypeToMonth(tab1_type) Month),');
  SQL.Add('INTERVAL -1 DAY), IF(RL.basCode IN ("_1C","_1E","_1D","_1F","_1G") ,DATE_ADD(DATE_ADD(STR_TO_DATE(CONCAT("01/" , MonthNo(Tab2_month), "/", Tab2_year) ,"%d/%m/%Y"), INTERVAL DateRangetypeToMonth(Tab2_type ) Month), INTERVAL -1 DAY),');
  SQL.Add('DATE_ADD(DATE_ADD(STR_TO_DATE(concat("01/", MonthNo(Tab3_month), "/", Tab3_year), "%d/%m/%Y"), INTERVAL DateRangetypeToMonth(Tab3_type ) MONTH), INTERVAL -1 DAY))) Dateto,');
  SQL.Add('R.BasSheetDesc Description, R.Active Active, R.AccMethod AccMethod, R.allclass allclass, C.classname classname,');
  SQL.Add('RL.Bascode Code, RL.Amount Amount, RL.Transtype  TransType, RL.transglobalref TransRef, RL.transdate TransDate,');
  SQL.Add('CONVERT(IFNULL(T.EmployeeID, TS.EmployeeID), SIGNED) AS EmployeeID,');
  SQL.Add('CONVERT(IFNULL(T.FixedAssetID, TS.FixedAssetID), SIGNED)	AS FixedAssetID,');
  SQL.Add('CONVERT(IFNULL(T.PaymentID, TS.PaymentID), SIGNED)	AS PaymentID,');
  SQL.Add('CONVERT(IFNULL(T.PrepaymentID, TS.PrepaymentID), SIGNED)	AS PrepaymentID,');
  SQL.Add('CONVERT(IFNULL(T.PurchaseOrderID, TS.PurchaseOrderID),SIGNED)	AS PurchaseOrderID,');
  SQL.Add('CONVERT(IFNULL(T.SaleID,TS.SaleID), SIGNED) AS SaleID');
  SQL.Add('FROM  tblBASReportLines RL ');
  SQL.Add('INNER JOIN tblBasreports R  ON RL.basID = R.ID');
  SQL.Add('LEFT JOIN tblTransactions T ON T.globalref = RL.transglobalref AND T.type = RL.transtype AND T.Seqno = RL.TRansseqno');
  SQL.Add('LEFT JOIN tbltransactionsummarydetails TS ON TS.globalref = RL.transglobalref AND TS.type = RL.transtype AND TS.Seqno = RL.TRansseqno');
  SQL.Add('LEFT JOIN tblClass C ON C.ClassId = R.ClassID');
  SQL.Add('WHERE (RL.Transglobalref = ' + QuotedStr(fTransRef) + ' OR ' + QuotedStr(fTransRef) + ' = "")');
  SQL.Add('AND (Transtype = ' + QuotedStr(fTransType) + ' OR ' + QuotedStr(fTransType) + ' = "")');
  SQL.Add('AND (R.ID = ' + IntToStr(fID) + ' OR ' + IntToStr(fID) + ' = 0)');
  SQL.Add('AND (RL.bascode = ' + QuotedStr(fCode) + ' OR ' + QuotedStr(fCode) + ' = "")');

//  if not (Search = '') then
//    SQL.Add('AND P.' + ReplaceAlias(Search));
//
//  if not (OrderBy = '') then
//    SQL.Add('ORDER BY P.' + OrderBy);

end;

initialization

   RegisterClass(TBASReturnDetail);

end.
