unit StockQuantityLocationSQL;

interface

uses
  ReportBaseObj, classes;

type

  TStockQuantityLocation = class(TReportWithDateRangeBase)
  private
    fTableName: string;
    fIncludeNIP: Boolean;
    fFilterIndex: Integer;
    fProductID: Integer;
    fClassID: Integer;

    procedure CreateTempStockQtyTable;

  protected

  public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

  published
    property IncludeNonInventoryParts: Boolean read fIncludeNIP write fIncludeNIP;
    property FilterIndex: Integer read fFilterIndex write fFilterIndex;
    property ProductID: Integer read fProductID write fProductID;
    property ClassID: Integer read fClassID write fClassID;
  end;


implementation

uses ProductQtyLib, CommonLib, dateutils, sysutils, ERPdbComponents,
  CommonDbLib, LogLib, PQALib, SyncReportTableObj;

{  TStockQuantityLocation }

constructor  TStockQuantityLocation.Create;
begin
  inherited;

  ProductID := 0;
  ClassID := 0;
  DateTo := EndOfAMonth(YearOf(Date), MonthOf(Date));
  DateFrom := Trunc(IncDay(IncYear(DateTo, -1), 1));
end;

destructor  TStockQuantityLocation.Destroy;
begin
  inherited;
end;

procedure TStockQuantityLocation.CreateTempStockQtyTable;
var
  SQLList: TStringList;
  Scriptmain: TERPScript;
  TableName: string;
  usingReportTables: Boolean;
begin
  fTableName := Commondblib.GetUserTemporaryTableName('StockQtyLocation');
  SQLList := TStringList.Create;
  try
    SQLList.Add('DROP TABLE IF EXISTS ' + fTableName + ';' );
    SQLList.Add('CREATE TABLE ' + fTableName + ' (');
    SQLList.Add('AutoID             int(11)      NOT NULL  auto_increment,');
    SQLList.Add('PartsId            int(11)      NOT NULL  default "0",');
    SQLList.Add('DepartmentID       int(11)               default NULL,');
    SQLList.Add('UOMID       int(11)               default NULL,');
    SQLList.Add('UOM                varchar(50)  NOT NULL  default "",');
    SQLList.Add('UOMMultiplier      double       NOT NULL  default "0",');
    SQLList.Add('UOMVolume      double       NOT NULL  default "0",');
    SQLList.Add('UOMTotalAvailableVolume      double       NOT NULL  default "0",');
    SQLList.Add('UOMTotalinstockVolume      double       NOT NULL  default "0",');
    SQLList.Add('gLevel             int(20)               default "0",');
    SQLList.Add('PartType           varchar(13)           default "INV",');
    SQLList.Add('ProductName        varchar(60)           default NULL,');
    SQLList.Add('ProductPrintName   varchar(255)          default NULL,');
    SQLList.Add('ProductColumn1     varchar(255)          default NULL,');
    SQLList.Add('ProductColumn2     varchar(255)          default NULL,');
    SQLList.Add('ProductColumn3     varchar(255)          default NULL,');
    SQLList.Add('PartsDescription   varchar(255)          default NULL,');
    SQLList.Add('Classname          varchar(255)          default NULL,');
    SQLList.Add('Batchnumber        varchar(100)          default NULL,');
    SQLList.Add('TruckLoadNo        varchar(100)          default NULL,');
    SQLList.Add('ExpiryDate         varchar(10)           default NULL,');
    SQLList.Add('BatchExpiryDate    datetime              default NULL,');
    SQLList.Add('Binlocation        varchar(100) NULL     default "",');
    SQLList.Add('Binnumber          varchar(100) NULL     default "",');
    SQLList.Add('Serialnumber       varchar(100) NULL     default "",');
    SQLList.Add('UOMQty             double                default NULL,');
    SQLList.Add('Qty                double                default NULL,');
    SQLList.Add('CUSTFLD1           double                default NULL,');
    SQLList.Add('InstockUOMQty      double                default NULL,');
    SQLList.Add('InstockQty         double                default NULL,');
    SQLList.Add('SOUOMQty           double                default NULL,');
    SQLList.Add('SOQty              double                default NULL,');
    SQLList.Add('Cost               double       NOT NULL  default "0",');
    SQLList.Add('Value              double                default NULL,');
    SQLList.Add('Bin                enum("T","F")         default "F",');
    SQLList.Add('Batch              enum("T","F")         default "F",');
    SQLList.Add('SN                 enum("T","F")         default "F",');
    SQLList.Add('Active             enum("T","F")         default "T",');
    SQLList.Add('UOMMultiplierDesc1 varchar(100)          default NULL,');
    SQLList.Add('UOMMultiplierDesc2 varchar(100)          default NULL,');
    SQLList.Add('AvailableUOMQty    Double                 default NULL,');
    SQLList.Add('AvailableQty       Double                 default NULL,');
    SQLList.Add('PreferredSupplier  varchar(55)            default NULL,'); //##
    SQLList.Add('PRIMARY KEY  (AutoID)');
    SQLList.Add(') ENGINE=MyISAM;');

    SQLList.Add('INSERT INTO ' + fTableName +  ' (');
    SQLList.Add('PartsId, DepartmentID, UOMID, UOM, UOMMultiplier, gLevel, ProductName,');
    SQLList.Add('ProductColumn1, ProductColumn2, ProductColumn3, PartsDescription,');
    SQLList.Add('Classname, Batchnumber, TruckLoadNo, ExpiryDate, BatchExpiryDate, Binlocation,');
    SQLList.Add('Binnumber, Serialnumber, UOMQty, Qty, CUSTFLD1, InstockUOMQty, InstockQty,');
    SQLList.Add('SOUOMQty, SOQty, Cost, Value )');
    if IncludeNonInventoryParts then begin
      { note: we set the glevel initially to 0 here to prevent the line being deleted below ..}
      SQLList.Add(ProductQtyLib.NonStockQtySummary(false, 0, 0, 0, false, 0));
      SQLList.Add('UNION ALL');
    end;

    if      FilterIndex = 0 then SQLList.Add(ProductQtyLib.StockQty(True, ProductID, ClassID, tSummary       , DateTo))
    else if FilterIndex = 1 then SQLList.Add(ProductQtyLib.StockQty(True, ProductID, ClassID, tDetails       , DateTo))
    else if FilterIndex = 2 then SQLList.Add(ProductQtyLib.StockQty(True, ProductID, ClassID, tExtraDetails  , DateTo))
    else if FilterIndex = 3 then SQLList.Add(ProductQtyLib.StockQty(True, ProductID, ClassID, tDetailswithSno, DateTo));
    SQLList.Add(';');

    SQLList.Add('UPDATE ' + fTableName +' T SET  AvailableUOMQty = UOMQty;');
    SQLList.Add('UPDATE ' + fTableName +' T SET  AvailableQty = Qty;');
    SQLList.Add('UPDATE ' + fTableName +' T INNER JOIN tblParts P on T.PartsID = P.PartsID set T.ProductPrintName = P.ProductPrintName ;');

    if self.IncludeNonInventoryParts then
      SQLList.Add('update ' + fTableName +' T INNER JOIN  tblParts P on T.PartsID = P.PartsID set T.PartType = P.PartType ;');

    SQLList.Add(' DELETE FROM '+ fTableName +' WHERE gLevel >=2 '+
                                                    ' AND ifnull(Batchnumber,"")=""  '+
                                                    ' AND ifnull(Expirydate,0)=0  '+
                                                    ' AND ifnull(TruckLoadNo , "") = ""  '+
                                                    ' AND ifnull(binlocation,"")=""  '+
                                                    ' AND ifnull(Binnumber,"")=""  '+
                                                    ' AND  ifnull(Serialnumber,"") = ""  '+
                                                    ' AND ifnull(Qty,0) =0;');
    SQLList.Add(' DELETE FROM '+ fTableName +' WHERE gLevel >=3 '+
                                                    ' AND ifnull(binlocation,"")=""  '+
                                                    ' AND ifnull(Binnumber,"")=""  '+
                                                    ' AND  ifnull(Serialnumber,"") = ""  '+
                                                    ' AND ifnull(Qty,0) =0;');
    SQLList.Add(' DELETE FROM ' + fTableName + ' WHERE gLevel >=4 '+
                                                    ' AND  ifnull(Serialnumber,"") = "";');
    if FilterIndex = 3 then
      SQLList.Add(' DELETE FROM '+ fTableName +' WHERE gLevel = 4 and  ifnull(Serialnumber,"") <> "" and ifnull(Qty,0) <= 0;'); // delete serial numbers -ive Qtys as its only history

    SQLList.Add('UPDATE ' + fTableName +  ' AS tmp '+
                ' INNER JOIN tblParts AS P on P.PartsId = tmp.PartsID  '+
                ' SET tmp.bin = P.Multiplebins, tmp.batch = P.batch, tmp.SN = P.SNTracking, tmp.Active = P.Active;');
    SQLList.Add('UPDATE ' + fTableName +  ' as tmp ' +
                ' SET AvailableQty = (SELECT ' + SQL4Qty(tAvailable, 'PQA', 'PQA.Qty') +
                ' FROM tblPQa as PQA WHERE  PQA.ProductID = tmp.PartsID  '+
                ' AND PQA.DEpartmentId = tmp.DepartmentID) WHERE tmp.GLevel = 1; ' );
    SQLList.Add('UPDATE ' + fTableName +  ' as tmp ' +
                ' SET AvailableUOMQty = AvailableQty / UOMMultiplier , ' +
                ' UOMMultiplierDesc1 = concat(" X " ,UOMMultiplier), '+
                ' UOMMultiplierDesc2 = concat(" / " ,UOMMultiplier) '+
                ' WHERE tmp.GLevel = 1; ');
    if ProductID <> 0 then
      SQLList.Add('DELETE FROM ' + fTableName + ' WHERE PartsId <> ' + IntToStr(ProductID) + ' OR departmentid <> ' + IntToStr(ClassID) + ';' );
    { now set the gLevel back }
    SQLList.Add('UPDATE ' + fTableName +  ' SET gLevel = 4 WHERE gLevel = 0;');

    SQLList.Add('UPDATE ' + fTableName);
    SQLList.Add('INNER JOIN tblParts ON tblParts.PartsId=' + fTableName + '.PartsId');
    SQLList.Add('SET ' + fTableName + '.PreferredSupplier = tblParts.PreferedSupp;');
    SQLList.Add('UPDATE ' + fTableName + ' T ');
    SQLList.Add('INNER JOIN tblunitsofmeasure uom on uom.unitID=T.UOMID SET T.UOMVolume = UOM.Volume;');
    SQLList.Add('UPDATE ' + fTableName + ' T SET UOMTotalAvailableVolume = UOMVolume * AvailableUOMQty;');
    SQLList.Add('UPDATE ' + fTableName + ' T SET UOMTotalinstockVolume = UOMVolume * InstockUOMQty;');

    Scriptmain := TERPScript.Create(nil);
    try
      with Scriptmain do begin
        Connection := CommonDbLib.GetSharedMyDacConnection;
        SQL.Text := SyncReportObj.ChangeQuery(SQLList.Text, usingReportTables); // (SQLList.Text);//, nil, MyScriptBeforeExecute);
        LogText(SQL.Text);
        Execute;
      end;
    finally
      Scriptmain.Free;
    end;

  finally
    FreeAndNil(SQLList);
  end;
end;

function TStockQuantityLocation.PopulateReportSQL(SQL: TStrings; var msg: string): Boolean;
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
  Result := inherited;

  CreateTempStockQtyTable;

  SQL.Clear;

  SQL.Add('SELECT');
  SQL.Add('*');
  SQL.Add('FROM ' + fTableName);
  SQL.Add('WHERE Active="T" ');

  if not (Search = '') then
    SQL.Add('AND ' + ReplaceAlias(Search));

  if not (OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy);
end;

initialization
  RegisterClass( TStockQuantityLocation);

end.
