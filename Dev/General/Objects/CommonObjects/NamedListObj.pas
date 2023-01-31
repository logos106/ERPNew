unit NamedListObj;

interface

uses
  contnrs, classes;

type

  TNamedStringList = class(TObject)
  private
    fList: TStringList;
    FItemIndex: integer;
    FName: string;
    fEOF,
    fBOF: boolean;
    function GetCount: integer;
    procedure SetItemIndex(const Value: integer);
    procedure SetName(const Value: string);
    function GetCommaText: string;
    procedure SetCommaText(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    property Name: string read FName write SetName;
    property Count: integer read GetCount;
    property ItemIndex: integer read FItemIndex write SetItemIndex;
    function Item(aItemIndex: integer): string; overload;
    function Item: string; overload;
    procedure Add(Const Value: String);
    procedure Clear;
    property CommaText: string read GetCommaText write SetCommaText;
    procedure First;
    procedure Last;
    procedure Next;
    procedure Prior;
    function EOF: boolean;
    function BOF: boolean;
  end;

  TNamedStringListList = class(TObject)
  private
    fList: TObjectList;
    fLevel: integer;
    function GetCount: integer;
    function GetItem(const index: integer): TNamedStringList;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Item[const index: integer]: TNamedStringList read GetItem; default;
    procedure Add(Const aListName: String; Const aListCommaText: string = '');
    procedure Clear;
    procedure First;
    procedure Last;
    procedure Next;
//    procedure Prior;
    function EOF: boolean;
    function BOF: boolean;
    property Level: integer read fLevel;
  end;


implementation

{ TNamedStringList }

constructor TNamedStringList.Create;
begin
  inherited;
  fList:= TStringList.Create;
end;

destructor TNamedStringList.Destroy;
begin
  fList.Free;
  inherited;
end;

procedure TNamedStringList.Add(Const Value: String);
begin
  fList.Add(Value);
end;

procedure TNamedStringList.Clear;
begin
  fList.Free;
end;

function TNamedStringList.GetCount: integer;
begin
  result:= fList.Count;
end;

procedure TNamedStringList.SetItemIndex(const Value: integer);
begin
  FItemIndex := Value;
end;

procedure TNamedStringList.SetName(const Value: string);
begin
  FName := Value;
end;

function TNamedStringList.GetCommaText: string;
begin
  result:= fList.CommaText;
end;

procedure TNamedStringList.SetCommaText(const Value: string);
begin
  fList.CommaText:= Value;
  First;
end;

function TNamedStringList.Item(aItemIndex: integer): string;
begin
  result:= fList[aItemindex];
end;

function TNamedStringList.Item: string;
begin
  result:= Item(fItemIndex);
end;

function TNamedStringList.BOF: boolean;
begin
  result:= fBOF;
end;

function TNamedStringList.EOF: boolean;
begin
  result:= fEOF;
end;

procedure TNamedStringList.First;
begin
  fBOF:= true;
  fEOF:= true;
  fItemIndex:= -1;
  if Count > 0 then begin
    fItemIndex:= 0;
    fEOF:= false;
  end;
end;

procedure TNamedStringList.Last;
begin
  fBOF:= true;
  fEOF:= true;
  fItemIndex:= -1;
  if Count > 0 then begin
    fItemIndex:= Count -1;
    fBOF:= false;
  end;
end;

procedure TNamedStringList.Next;
begin
  if fItemIndex < Count -1 then
    Inc(fItemIndex)
  else
    fEOF:= true;
end;

procedure TNamedStringList.Prior;
begin
  if fItemIndex > 0 then
    Dec(fItemIndex)
  else
    fBOF:= true;
end;

{ TNamedStringListList }

constructor TNamedStringListList.Create;
begin
  inherited;
  fList:= TObjectList.Create(true);
  fLevel:= 0;
end;

destructor TNamedStringListList.Destroy;
begin
  fList.Free;
  inherited;
end;

procedure TNamedStringListList.Add(Const aListName, aListCommaText: string);
var
  nl: TNamedStringList;
begin
  nl:= TNamedStringList.Create;
  nl.Name:= aListName;
  nl.CommaText:= aListCommaText;
  fList.Add(nl);
end;

procedure TNamedStringListList.Clear;
begin
  fList.Clear;
end;

function TNamedStringListList.GetCount: integer;
begin
  result:= fList.Count;
end;

function TNamedStringListList.GetItem(const index: integer): TNamedStringList;
begin
  result:= TNamedStringList(fList[index]);
end;

function TNamedStringListList.BOF: boolean;
var x: integer;
begin
  result:= true;
  for x:= 0 to Count -1 do begin
    if not Item[x].BOF then begin
      result:= false;
      break;
    end;  
  end;
end;

function TNamedStringListList.EOF: boolean;
var x: integer;
begin
  result:= true;
  for x:= 0 to Count -1 do begin
    if not Item[x].EOF then begin
      result:= false;
      break;
    end;
  end;
end;

procedure TNamedStringListList.First;
var x: integer;
begin
  for x:= 0 to Count -1 do begin
    Item[x].First;
  end;
  fLevel:= 0;
end;

procedure TNamedStringListList.Last;
var x: integer;
begin
  for x:= 0 to Count -1 do begin
    Item[x].Last;
  end;
  fLevel:= 0;
end;

procedure TNamedStringListList.Next;

  function IncLevel(aLevel: integer): boolean;
  begin
    result:= false;
    Item[aLevel].Next;
    if not Item[aLevel].EOF then begin
      result:= true;
      fLevel:= aLevel;
    end
    else begin
      if (aLevel > 0) and IncLevel(aLevel -1) then begin
        result:= true;
        Item[aLevel].First;
      end;
    end;
  end;

begin
  if Count > 0 then
    IncLevel(Count-1);
end;

//procedure TNamedStringListList.Prior;
//begin
//
//end;

end.
