unit ERPSets;

interface
uses
  Windows,
  Classes,
  sysutils;//,
//  angriGeneralTypes;

type

  { Types moved here to allow integration  }
  THugeIntegerArray = array [0.. (MaxInt div SizeOf(Integer)) - 1] of Integer;
  PHugeIntegerArray = ^THugeIntegerArray;

  ESetException = Exception;

{ Set Of Integer }

  TIntegerSet = class
  private
    fMemory:  PHugeIntegerArray;
    fSize:    integer;
    fCounter: integer;

    function Search(Value: integer; var index: integer): boolean;
    function getItem(index: integer): integer;

  public
    constructor Create;
    destructor Destroy; override;

    //
    procedure Assign(const aSource : TStrings);overload;
    procedure Assign(const aSource : TIntegerSet);overload;
    //

    function Add(Value: integer): boolean;
    function Exists(Value: integer): boolean;
    function Delete(Value: integer): boolean;
    procedure Clear;

    property Count: integer Read fCounter;
    property Items[index: integer]: integer Read getItem;default;
    {$IFDEF DSERVER}
    property Memory : PHugeIntegerArray read fMemory;
    {$ENDIF}
  end;


implementation

function Compare(A, B: integer): integer; overload;
begin
  if a > b then
    Result := 1
  else
    if a < b then
      Result := -1
    else
      Result := 0;
end;

function Compare(A, B : Pointer) : integer; overload;
begin
  if Cardinal(a) > cardinal(b) then
    Result := 1
  else
    if Cardinal(a) < Cardinal(b) then
      Result := -1
    else
      Result := 0;
end;

function BlockFull(aCount, aSize : integer) : boolean;
begin
  {$if defined(ver150) and not defined(borlndmmdll)}
  Result := aSize - aCount = 1;
  {$else}
  Result := aSize = aCount;
  {$ifend}
end;

{ TIntegerSet }

function TIntegerSet.Add(Value: integer): boolean;
var
  tempS: integer;

begin
  if BlockFull(fCounter, fSize) then
    begin
    tempS := fSize + 16;
    (*
    GetMem(tempA, tempS * SizeOf(integer));
    CopyMemory(tempA, fMemory, fCounter * SizeOf(integer));
    FreeMem(fMemory);
    fMemory := tempA;
    *)
    ReallocMem(fMemory, SizeOf(Integer) * tempS);
    fSize   := tempS;

    end;
  if fCounter = 0 then
    begin
    fMemory^[0] := Value;
    fCounter    := 1;
    Result      := True;
    end
  else
    begin
    Result := not Search(Value, tempS);
    if not Result then
      exit;
    if tempS <> fCounter then
      begin
      // NOTE that MoveMemory takes care of overlapped memory
      MoveMemory(@fMemory[tempS + 1], @fMemory[tempS], (fCounter - tempS + 1) *
        SizeOf(integer));
      end;
    fMemory[tempS] := Value;
    Inc(fCounter);
  end;
end;

procedure TIntegerSet.Assign(const aSource: TStrings);
var
  idx : integer;
begin
  if aSource.Count > FSize then
    begin
    FreeMem(FMemory);
    FSize := ((aSource.Count div 16) + 1) * 16;
    GetMem(FMemory, FSize * SizeOf(integer));
    end;

  FCounter := 0; //aSource.Count;

  for idx := 0 to aSource.Count - 1 do
    Add(StrToInt(aSource.Strings[idx]));
end;

procedure TIntegerSet.Assign(const aSource: TIntegerSet);
begin
  FreeMem(FMemory);
  FSize := aSource.FSize;
  FCounter := aSource.FCounter;
  GetMem(FMemory, FSize * SizeOf(integer));
  Move(aSource.FMemory^, FMemory^, FCounter * SizeOf(integer));
end;

procedure TIntegerSet.Clear;
begin
  fCounter := 0;
end;

constructor TIntegerSet.Create;
begin
  inherited;
  fSize    := 16;    // hope it's reasonable enough
  fCounter := 0;
  GetMem(fMemory, fSize * SizeOf(integer));
  {$IFDEF DSERVER}  // To debug
  FillChar(fMemory^, fSize * SizeOf(integer), 0);
  {$ENDIF}
end;

function TIntegerSet.Delete(Value: integer): boolean;
var
  index : integer;
begin
  Result := not Search(Value, index);
  if not Result then
    begin
    if index + 1 <> fCounter then
      MoveMemory(@fMemory[index], @fMemory[index + 1], (fCounter - index) * SizeOf(integer));
    Dec(fCounter);
  end;
end;

destructor TIntegerSet.Destroy;
begin
  FreeMem(fMemory);
  inherited;
end;

function TIntegerSet.Exists(Value: integer): boolean;
var
  index : integer;
begin
  Result := Search(Value, Index);
end;

function TIntegerSet.getItem(index: integer): integer;
begin
  if index < fCounter then
    Result := fMemory^[index]
  else
    Raise ESetException.Create(Format('%s: index %d out of range (%d)',
         [self.ClassName, index, fCounter]));
end;

function TIntegerSet.Search(Value: integer; var Index : integer): boolean;
var
  L, H, I, C: integer;
begin
  Result := False;
  L      := 0;
  H      := fCounter - 1;
  while L <= H do
    begin
    I := (L + H) shr 1;
    C := Compare(fMemory^[I], Value);
    if C < 0 then
      L := I + 1
    else
      begin
      H := I - 1;
      if C = 0 then
        begin
        Result := True;
        //      IF NOT Duplicates THEN
        L      := I;
        end;
      end;
    end;
  Index := L;
end;

{ TObjectSet }

end.
