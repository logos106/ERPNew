unit QuickBooksIDListObj;

interface

uses Classes;

type
  TSubItem = Class;
  TQBFieldList = class(TComponent)
    Private
    Protected
    Public
    Stringfields :TStringList;
    Booleanfield :TStringList;
    Integerfields :TStringList;
    Doublefields :TStringList;
    Constructor Create(AOwner:TComponent); Override;
    Destructor Destroy; Override;
  end;
  TQBitem = Class(TComponent)
  Private
  Protected
  Public
    QbFieldList : TQBFieldList;
    SubItem :Array of TSubItem;
    Constructor Create(AOwner:TComponent); Override;
    Destructor Destroy; Override;
    function NewSubItem :TSubItem;
  End;
  TSubItem = Class(TComponent)
  Private
  Protected
  Public
    ITemName:String;
    ArrayName: string;
    ArrayItemname: string;
    HeaderIDField :String;
    Tablename :String;
    QbFieldList : TQBFieldList;
    Constructor Create(AOwner:TComponent); Override;
    Destructor Destroy; Override;
  end;

implementation

uses sysutils;
{ TQBitem }

constructor TQBitem.Create(AOwner: TComponent);
begin
  inherited;
  QBFieldList := TQBFieldList.create(Self);
  SetLength(SubItem , 0);
end;

destructor TQBitem.Destroy;
begin
  Freeandnil(QBFieldList);
  SetLength(SubItem , 0);
  Finalize(SubItem);
  inherited;
end;
function TQBitem.NewSubItem: TSubItem;
begin
  SetLength(SubItem,length(SubItem)+1);
  SubItem[high(SubItem)] :=TSubItem.create(Self);
  result :=SubItem[high(SubItem)];
end;

{ TSubItem }

constructor TSubItem.Create(AOwner: TComponent);
begin
  inherited;
  QBFieldList := TQBFieldList.create(Self);
end;

destructor TSubItem.Destroy;
begin
  Freeandnil(QBFieldList);
  inherited;
end;

{ TQBFieldList }

constructor TQBFieldList.Create(AOwner: TComponent);
begin
  inherited;
  Stringfields := TStringlist.Create;
  Integerfields := TStringlist.Create;
  Booleanfield := TStringlist.Create;
  Doublefields := TStringlist.Create;
end;

destructor TQBFieldList.Destroy;
begin
  Freeandnil(Stringfields);
  Freeandnil(Integerfields);
  Freeandnil(Booleanfield);
  Freeandnil(Doublefields);
  inherited;
end;

end.
