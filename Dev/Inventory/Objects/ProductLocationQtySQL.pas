unit ProductLocationQtySQL;

interface
uses
  ReportBaseObj, classes;

Type
  TProductLocationQty = class(TReportWithDateRangeBase)
  Private
    fsProductIDs: STring;
    fsClassIDs: STring;
    procedure SetClassNames(const Value: STring);
    procedure SetProductNames(const Value: STring);
  Protected
  Public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  Published
    Property ProductIDs:STring read fsProductIDs write fsProductIDs;
    Property ClassIDs:STring read fsClassIDs write fsClassIDs;
    Property ClassNames:STring write SetClassNames;
    Property ProductNames:STring write SetProductNames;
  End;

implementation

uses DbSharedObjectsObj;

{ TProductLocationQty }

constructor TProductLocationQty.Create;
begin
  inherited;

end;

destructor TProductLocationQty.Destroy;
begin

  inherited;
end;

function TProductLocationQty.PopulateReportSQL(SQL: TStrings;  var msg: string): boolean;
begin
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('T.ProductID            as  ProductID,');
          SQL.Add('T.ClassID              as  ClassID,');
          SQL.Add('T.ProductName          as  ProductName,');
          SQL.Add('C.ClassName            as  Deptname  ,');
          SQL.Add('T.FirstColumn          as  FirstColumn,');
          SQL.Add('T.SecondColumn         as  SecondColumn,');
          SQL.Add('T.ThirdColumn          as  ThirdColumn,');
          SQL.Add('T.Cost                 as  Cost,');
          SQL.Add('T.Qty                  as  Qty,');
          SQL.Add('T.Available            as  Available,');
          SQL.Add('T.InStock              as  InStock,');
          SQL.Add('T.so                   as  so,');
          SQL.Add('T.invbo                as  invbo,');
          SQL.Add('T.pobo                 as  pobo,');
          SQL.Add('T.onbuild              as  onbuild,');
          SQL.Add('T.building             as  building,');
          SQL.Add('(T.Qty*T.Cost)         as  QtyTotalCost,');
          SQL.Add('(T.Available*T.Cost)   as  AvailableTotalCost,');
          SQL.Add('(T.InStock*T.Cost)     as  InStockTotalCost,');
          SQL.Add('(T.so*T.Cost)          as  soTotalCost,');
          SQL.Add('(T.invbo*T.Cost)       as  invboTotalCost,');
          SQL.Add('(T.pobo*T.Cost)        as  poboTotalCost,');
          SQL.Add('(T.onbuild*T.Cost)     as  onbuildTotalCost,');
          SQL.Add('(T.building*T.cost)    as  buildingTtoalCost');
          SQL.Add('FROM tmp_vs1_report_productmovement T');
          SQL.Add('inner JOIN tblclass C ON T.classId = C.ClassId');
          SQL.Add('Where T.Productname <> ""');
          if fsClassIDs <> '' then SQL.Add('AND T.classId in (' + fsClassIDs+')');
          if fsProductIDs <> '' then SQL.Add('AND T.ProductID in (' + fsProductIDs+')');
          SQL.Add('group by ProductID,ClassID');
          SQL.Add('ORDER BY Productname, deptname');
          Result := true;
end;

procedure TProductLocationQty.SetClassNames(const Value: STring);
begin
  fsClassIDs:= ClassnamesTOIds(Value);
end;
procedure TProductLocationQty.SetProductNames(const Value: STring);
begin
  fsProductIDs:= ProductNamesTOIds(Value);
end;
initialization
  RegisterClass(TProductLocationQty);
end.
