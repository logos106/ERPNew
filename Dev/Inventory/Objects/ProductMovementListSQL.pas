unit ProductMovementListSQL;

interface
uses
  ReportBaseObj, classes;

Type
  TProductMovementList = class(TReportWithDateRangeBase)
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
    Property ProductIDs: String read fsProductIDs write fsProductIDs;
    Property ClassIDs: String read fsClassIDs write fsClassIDs;
//    Property ClassNames: String write SetClassNames;
//    Property ProductNames: String write SetProductNames;
  End;

implementation

uses DbSharedObjectsObj;

{ TProductMovementList }

constructor TProductMovementList.Create;
begin
  inherited;

end;

destructor TProductMovementList.Destroy;
begin

  inherited;
end;

function TProductMovementList.PopulateReportSQL(SQL: TStrings;  var msg: string): boolean;
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

procedure TProductMovementList.SetClassNames(const Value: STring);
begin
  fsClassIDs := ClassnamesTOIds(Value);
end;

procedure TProductMovementList.SetProductNames(const Value: STring);
begin
  fsProductIDs := ProductNamesTOIds(Value);
end;

initialization
  RegisterClass(TProductMovementList);
end.
