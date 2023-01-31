unit XMLFuncLib;

interface

uses
  classes;

function ReplaceNonAlphaNumeric(const aString: string): string;
function ReinstateNonAlphaNumeric(const aString: string): string;
function RemoveIllegalCharacters(const inStr: string): string;

implementation

uses
  SysUtils;

function ReplaceNonAlphaNumeric(const aString: string): string;
var
  x: byte;
begin
  Result := aString;
  // Null
  Result := StringReplace(Result, Chr(0), '_x' + IntToHex(0, 2) + '_',[rfReplaceAll,rfIgnoreCase]);

  for x := 8 to 13 do begin
    Result := StringReplace(Result, Chr(x), '_x' + IntToHex(x, 2) + '_',[rfReplaceAll,rfIgnoreCase]);
  end;
  // ESC
  Result := StringReplace(Result, Chr(27), '_x' + IntToHex(27, 2) + '_',[rfReplaceAll,rfIgnoreCase]);

  for x := 23 to 47 do begin
    Result := StringReplace(Result, Chr(x), '_x' + IntToHex(x, 2) + '_',[rfReplaceAll,rfIgnoreCase]);
  end;

  for x := 58 to 64 do begin
    Result := StringReplace(Result, Chr(x), '_x' + IntToHex(x, 2) + '_',[rfReplaceAll,rfIgnoreCase]);
  end;

  for x := 91 to 96 do begin
    if x <> 95 then Result := StringReplace(Result, Chr(x), '_x' + IntToHex(x, 2) + '_',[rfReplaceAll,rfIgnoreCase]);
  end;

  for x := 123 to 126 do begin
    Result := StringReplace(Result, Chr(x), '_x' + IntToHex(x, 2) + '_',[rfReplaceAll,rfIgnoreCase]);
  end;
  // £
  Result := StringReplace(Result, Chr(163), '_x' + IntToHex(163, 2) + '_',[rfReplaceAll,rfIgnoreCase]);
end;

function ReinstateNonAlphaNumeric(const aString: string): string;
var
  x: byte;
begin
  Result := aString;
  // Null
  Result := StringReplace(Result, '_x' + IntToHex(0, 2) + '_', Chr(0),[rfReplaceAll,rfIgnoreCase]);

  for x := 8 to 13 do begin
    Result := StringReplace(Result, '_x' + IntToHex(x, 2) + '_', Chr(x),[rfReplaceAll,rfIgnoreCase]);
  end;
  // ESC
  Result := StringReplace(Result, '_x' + IntToHex(27, 2) + '_', Chr(27),[rfReplaceAll,rfIgnoreCase]);

  for x := 23 to 47 do begin
    Result := StringReplace(Result, '_x' + IntToHex(x, 2) + '_', Chr(x),[rfReplaceAll,rfIgnoreCase]);
  end;

  for x := 58 to 64 do begin
    Result := StringReplace(Result, '_x' + IntToHex(x, 2) + '_', Chr(x),[rfReplaceAll,rfIgnoreCase]);
  end;

  for x := 91 to 96 do begin
    if x <> 95 then Result := StringReplace(Result, '_x' + IntToHex(x, 2) + '_', Chr(x),[rfReplaceAll,rfIgnoreCase]);
  end;

  for x := 123 to 126 do begin
    Result := StringReplace(Result, '_x' + IntToHex(x, 2) + '_', Chr(x),[rfReplaceAll,rfIgnoreCase]);
  end;
  // £
  Result := StringReplace(Result, '_x' + IntToHex(163, 2) + '_', Chr(163),[rfReplaceAll,rfIgnoreCase]);
end;

function RemoveIllegalCharacters(const inStr: string): string;
var
  x: integer;
begin
  result := '';
  for x:= 1 to System.Length(inStr) do begin
    if CharInSet(inStr[x],[#9,#10,#13]) or
       ((Ord(inStr[x]) >= $20) and (Ord(inStr[x]) <= $D7FF)) or
       ((Ord(inStr[x]) >= $E000) and (Ord(inStr[x]) <= $FFFD)) then
//       ((Ord(inStr[x]) >= $10000) and (Ord(inStr[x]) <= $10FFFF)) then
      result := result + inStr[x];

  end;
end;

end.
