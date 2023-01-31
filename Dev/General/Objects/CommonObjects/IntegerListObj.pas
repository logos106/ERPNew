unit IntegerListObj;

interface

uses
  Classes;

type

  TIntegerList = class(TObject)
  private
    fList: TList;
    fOnChange: TNotifyEvent;
    fTotal: integer;
    function GetItem(const index: integer): integer;
    function GetCommaText: string;
    procedure SetCommaText(const Value: string);
    procedure SetItem(const index: integer; const Value: integer);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(const i: integer);
    procedure AddSort(const i: integer);
    procedure Remove(const i: integer; removeAll: boolean = false);
    procedure Insert(const index, value: integer);
    function InList(const i: integer): boolean;
    function Indexof(const i: integer): Integer;
    Function AddIfNotInList(const i: integer):Boolean;
    property Item[const index: integer]: integer read GetItem write SetItem; default;
    procedure Clear;
    function Count: integer;
    property CommaText: string read GetCommaText write SetCommaText;
    function IsEmpty: boolean;
    procedure Sort(Compare: TListSortCompare);
    procedure Delete(index: integer);
    function Last: integer;
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
    property Total: integer read fTotal;
  end;

implementation

{ TIntegerList }

uses
  sysutils;

constructor TIntegerList.Create;
begin
  inherited;
  fList:= TList.Create;
  fTotal:= 0;
end;

destructor TIntegerList.Destroy;
begin
  fList.Free;
  inherited;
end;

procedure TIntegerList.Add(const i: integer);
begin
  fList.Add(Pointer(i));
  fTotal:= fTotal + i;
  if Assigned(fOnChange) then
    fOnChange(self);
end;

procedure TIntegerList.Insert(const index, value: integer);
begin
  fList.Insert(index, Pointer(value));
  fTotal:= fTotal + value;
end;

function TIntegerList.AddIfNotInList(const i: integer):Boolean;
begin
  result := False;
  if not InList(i) then begin
    Add(i);
    result := True;
  end;
end;

procedure TIntegerList.AddSort(const i: integer);
var
  ctr:Integer;
begin
  if count=0 then begin
    Add(i);
    exit;
  end else begin
    for ctr:= 0 to count-1 do begin
      if Integer(fList[ctr]) < i then continue
      else begin
         Insert(ctr , i);
         Exit;
      end;
    end;
    Add(i);
  end;
end;

procedure TIntegerList.Clear;
begin
  fList.Clear;
  fTotal:= 0;
end;

function TIntegerList.Count: integer;
begin
  result:= fList.Count;
end;

function TIntegerList.GetItem(const index: integer): integer;
begin
  result:= Integer(fList[index]);
end;

procedure TIntegerList.SetItem(const index: integer; const Value: integer);
begin
  fList[index]:= Pointer(value);
  if Assigned(fOnChange) then
    fOnChange(self);
end;

function TIntegerList.InList(const i: integer): boolean;
begin
  result:= fList.IndexOf(Pointer(i)) > -1;
end;
function TIntegerList.Indexof(const i: integer): Integer;
begin
  result:= fList.IndexOf(Pointer(i));
end;
function TIntegerList.GetCommaText: string;
var
  x: integer;
begin
  result:= '';
  for x:= 0 to Count -1 do begin
    if x > 0 then result:= result + ',';
    result:= result + IntToStr(Item[x]);
  end;
end;

procedure TIntegerList.SetCommaText(const Value: string);
var
  sl: TStringList;
  x: integer;
begin
  Clear;
  sl:= TStringList.Create;
  try
    sl.CommaText:= Value;
    for x:= 0 to sl.Count -1 do
      self.Add(StrToInt(sl[x]));
  finally
    sl.Free;
  end;
  if Assigned(fOnChange) then
    fOnChange(self);
end;

function TIntegerList.IsEmpty: boolean;
begin
  result:= Count = 0;
end;

procedure TIntegerList.Sort(Compare: TListSortCompare);
begin
  fList.Sort(Compare);
end;

procedure TIntegerList.Delete(index: integer);
begin
  fTotal:= fTotal - Item[index];
  fList.Delete(index);
  if Assigned(fOnChange) then
    fOnChange(self);
end;

function TIntegerList.Last: integer;
begin
  result:= Item[Count-1];
end;

procedure TIntegerList.Remove(const i: integer; removeAll: boolean);
var
  x: integer;
begin
  x:= 0;
  while  x <= fList.Count -1 do begin
    if Integer(fList[x]) = i then begin
      fTotal:= fTotal - i;
      fLIst.Delete(x);
      fTotal:= fTotal - i;
      if not removeAll then
        break;
    end
    else begin
      inc(x);
    end;
  end;
end;

end.

