unit VersionUtils;

interface

function VersionComp(Const Version1, Version2 :String): Integer;
function VersionToSortString(const aVer: string): string;

implementation

uses
  SysUtils, Classes, Math, Types, StrUtils;

function VersionComp(Const Version1, Version2: String): Integer;
var
  v1, v2: array [0..3] of Integer;
  sl: TStringList;
  x: Integer;
begin
  Result := 0;
  for x := 0 to 3 do begin
    v1[x] := 0;
    v2[x] := 0;
  end;

  {Return value  Condition
    -1         Version1 sorts before Version2.
    0          Version1 Same as Version2.
    1          Version1 sorts After Version2.}
  sl := TStringLIst.Create;
  try
    sl.Delimiter := '.';
    sl.DelimitedText := Version1;
    if sl.Count > 4 then raise exception.Create('VersionComp - Version1 "' + Version1 + '" invalid format, too many parts.');
    for x := 0 to sl.Count - 1 do
      V1[x] := StrToInt(sl[x]);

    sl.Clear;
    sl.DelimitedText := Version2;
    if sl.Count > 4 then raise exception.Create('VersionComp - Version2 "' + Version2 + '" invalid format, too many parts.');
    for x := 0 to sl.Count -1 do
      V2[x] := StrToInt(sl[x]);

    for x := 0 to 3 do begin
      Result := Math.CompareValue(v1[x], v2[x]);
      if Result <> 0 then Break;
    end;

  finally
    sl.Free;
  end;
end;

function VersionToSortString(const aVer: string): string;
var
  arr: TStringDynArray;
  s: string;
  x: integer;
begin
  result := '';
  arr := SplitString(aVer,'.');
  for x := Low(arr) to High(arr) do begin
    s := arr[x];
    while Length(s) < 4 do
      s := '0' + s;
    if result <> '' then result := result + '.';
    result := result + s;
  end;
end;



end.
