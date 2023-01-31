unit HireClasses;

interface
uses
  Sysutils, Classes, DB, MemDS, DBAccess, MyAccess,
  contnrs, ERPSets;

type
  TPlannerSet = class(TIntegerSet)
  private
    fHireLineId: integer;
    fAssetName: string;
    fLinked: boolean;
  public
    constructor Create(AHireLineId : integer; const AAssetName : string);
    property HireLineId : integer read fHireLineId write fHireLineId;
    property AssetName : string read fAssetName write fAssetName;
    property Linked : boolean read fLinked write fLinked;
  end;


  THireLineRec = class(TObject)
  private
    fActualHireTo: TDateTime;
    fHireTo: TDateTime;
    fHireLineId: integer;
    fActualHireFrom: TDateTime;
    fHireFrom: TDateTime;
    fHireId: integer;
    fDirty: boolean;
    fAssetId: integer;
    fDeleted: boolean;
    fAssetName: string;
  public
    constructor Create;
    destructor Destroy; override;
    property HireId: integer read fHireId write fHireId;
    property HireLineId: integer read fHireLineId write fHireLineId;
    property AssetId: integer read fAssetId write fAssetId;
    property AssetName: string read fAssetName write fAssetName;
    property HireFrom: TDateTime read fHireFrom write fHireFrom;
    property HireTo: TDateTime read fHireTo write fHireTo;
    property ActualHireFrom: TDateTime read fActualHireFrom write fActualHireFrom;
    property ActualHireTo: TDateTime read fActualHireTo write fActualHireTo;
    property Deleted: boolean read fDeleted write fDeleted;
    property Dirty: boolean read fDirty write fDirty;
  end;

  THireLineList = class(TObject)
  private
    fList: TObjectList;
    function GetCount: integer;
    function GetItem(index: integer): THireLineRec;
    function GetDirty: boolean;
    procedure SetDirty(const Value: boolean);
    function GetOwnsObjects: boolean;
    procedure SetOwnsObjects(const Value: boolean);
  public
    constructor Create;
    destructor Destroy; override;
//    function ItemForHireLineId(aHireLineId: integer): THireLineRec;
    function ItemForHireLineIdAndAssetId(aHireLineId, aAssetId: integer): THireLineRec;
    procedure Add(aItem: THireLineRec);
    function AddData(qry: TDataset): THireLineRec;
    procedure Clear;
    procedure Delete(idx : integer);
    function IndexOf(AObject : TObject) : integer;
    property Count: integer read GetCount;
    property Item[index: integer]: THireLineRec read GetItem;
    function HireLineIdForAssetName(aAssetName: string; aHireId: integer): integer;
    function Overlapped(ARec : THireLineRec) : boolean;
    function ItemForHireAssetName(aHireId: integer; const aAssetName: string): THireLineRec;
    function ItemForHireAssetId(AHireId, AAssetId : integer) : THireLineRec;
    property Dirty: boolean read GetDirty write SetDirty;
    property OwnsObjects : boolean read GetOwnsObjects write SetOwnsObjects;
  end;

implementation

{ TPlannerSet }

constructor TPlannerSet.Create(AHireLineId: integer; const AAssetName : string);
begin
  inherited Create;
  HireLineId := AHireLineId;
  AssetName := AAssetName;
end;

{ THireLineList }

procedure THireLineList.Add(aItem: THireLineRec);
begin
  fList.Add(aItem);
end;

function THireLineList.AddData(qry: TDataset): THireLineRec;
var
  newItem: THireLineRec;
begin
  newItem := ItemForHireLineIdAndAssetId(qry.FieldByName('HireLineId').AsInteger,qry.FieldByName('AssetId').AsInteger);
  if not Assigned(newItem) then begin
    newItem := THireLineRec.Create;
    newItem.HireId := qry.FieldByName('HireId').AsInteger;
    newItem.HireLineId := qry.FieldByName('HireLineId').AsInteger;
    newItem.AssetId := qry.FieldByName('AssetId').AsInteger;
    newItem.AssetName := qry.FieldByName('AssetName').AsString;
    newItem.HireFrom := qry.FieldByName('HireFrom').AsDateTime;
    newItem.HireTo := qry.FieldByName('HireTo').AsDateTime;
    newItem.ActualHireFrom := qry.FieldByName('ActualHireFrom').AsDateTime;
    newItem.ActualHireTo := qry.FieldByName('ActualHireTo').AsDateTime;
    newItem.Dirty := false;
    fList.Add(newItem);
  end;
  result := newItem;
end;

procedure THireLineList.Clear;
begin
  fList.Clear;
end;

constructor THireLineList.Create;
begin
  fList := TObjectList.Create(true);
end;

procedure THireLineList.Delete(idx: integer);
begin
  fList.Delete(idx);
end;

destructor THireLineList.Destroy;
begin
  fList.Free;
  inherited;
end;

function THireLineList.GetCount: integer;
begin
  result := fList.Count;
end;

function THireLineList.GetDirty: boolean;
var
  x: integer;
begin
  result := false;
  for x := 0 to Count -1 do begin
    if Item[x].Dirty then begin
      result := true;
      exit;
    end;
  end;
end;

function THireLineList.GetItem(index: integer): THireLineRec;
begin
  result := THireLineRec(fList[index]);
end;

function THireLineList.GetOwnsObjects: boolean;
begin
  Result := fList.OwnsObjects;
end;

function THireLineList.HireLineIdForAssetName(aAssetName: string; aHireId: integer): integer;
var
  x: integer;
begin
  result := 0;
  for x := 0 to Count -1 do begin
    if (Item[x].HireId = aHireId) and SameText(Item[x].AssetName,aAssetName) and (Item[x].HireLineId > 0) then begin
      result := Item[x].HireLineId;
      break;
    end;
  end;
end;

//function THireLineList.ItemForHireLineId(aHireLineId: integer): THireLineRec;
//var
//  x: integer;
//begin
//  result := nil;
//  for x := 0 to fList.Count -1 do begin
//    if Item[x].HireLineId = aHireLineId then begin
//      result := Item[x];
//      break;
//    end;
//  end;
//end;

function THireLineList.IndexOf(AObject: TObject): integer;
begin
  Result := fList.IndexOf(AObject);
end;

function THireLineList.ItemForHireAssetId(AHireId,
  AAssetId: integer): THireLineRec;
var
  idx : integer;
begin
  for idx := 0 to fList.Count - 1 do
    if (Item[idx].HireId = aHireId) and (Item[idx].AssetId = AAssetId) then
    begin
      Result := Item[idx];
      exit;
    end;
  Result := nil;
end;

function THireLineList.ItemForHireAssetName(aHireId: integer;
  const aAssetName: string): THireLineRec;
var
  x: integer;
begin
  result := nil;
  for x := 0 to fList.Count -1 do begin
    if (Item[x].HireId = aHireId) and SameText(Item[x].AssetName,aAssetName) then begin
      result := Item[x];
      break;
    end;
  end;
end;

function THireLineList.ItemForHireLineIdAndAssetId(aHireLineId,
  aAssetId: integer): THireLineRec;
var
  x: integer;
begin
  result := nil;
  for x := 0 to fList.Count -1 do begin
    if (Item[x].HireLineId = aHireLineId) and (Item[x].AssetId = aAssetId) then begin
      result := Item[x];
      break;
    end;
  end;
end;

function THireLineList.Overlapped(ARec: THireLineRec): boolean;
  function Between(AValue, aLeft, ARight : TDateTime) : boolean;
  begin
    Result := (AValue >= ALeft) and (AValue <= ARight);
  end;
var
  idx : integer;
begin
  Result := false;
  for idx := 0 to Count - 1 do
  begin
    if (ARec.AssetId = Item[idx].AssetId) then
      if Between(ARec.HireFrom, Item[idx].HireFrom, Item[idx].HireTo) or
         Between(ARec.HireTo,  Item[idx].HireFrom, Item[idx].HireTo) or
         Between(Item[idx].HireFrom, ARec.HireFrom, ARec.HireTo) or
         Between(Item[idx].HireTo, ARec.HireFrom, ARec.HireTo) then
      begin
        Result := true;
        exit;
      end;
  end;
end;

procedure THireLineList.SetDirty(const Value: boolean);
var
  x: integer;
begin
  for x := 0 to Count -1 do
    Item[x].Dirty := false;
end;

procedure THireLineList.SetOwnsObjects(const Value: boolean);
begin
  fList.OwnsObjects := Value;
end;

{ THireLineRec }

constructor THireLineRec.Create;
begin
  fDeleted := false;
  fHireId := 0;
  fHireLineId := 0;
end;

destructor THireLineRec.Destroy;
begin

  inherited;
end;
end.
