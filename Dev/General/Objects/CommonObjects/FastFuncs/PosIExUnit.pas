unit PosIExUnit;

interface

function PosIEx_DKC_Pas_24_a(const SubStr, S: string; Offset: Integer = 1): Integer;

implementation

uses
 FastFuncs;

var
 LookUpTable : array of Char;

procedure InitializeLookUpTable;
var
 I : Byte;
 S1, S2 : AnsiString;

begin
 SetLength(LookUpTable, 256);
 for I := 0 to 255 do
  begin
   S1 := Char(I);
   S2 := FastFuncs.UpperCase(S1);
   LookUpTable[I] := S2[1];
  end;
end;

function PosIEx_DKC_Pas_24_a(const SubStr, S: string; Offset: Integer = 1): Integer;
var
 I2, SubStrLength, StrLength : Integer;
 SubStrFirstCharUpper : Char;

begin
 Result := 0;
 if (Offset <= 0) then
  Exit;
 if S <> '' then
  StrLength := PInteger(Integer(S)-4)^
 else
  Exit;
 if SubStr <> '' then
  SubStrLength := PInteger(Integer(SubStr)-4)^
 else
  Exit;
 if (SubStrLength <= 0) then
  Exit;
 if (StrLength <= 0) then
  Exit;
 if (Integer(Offset) > StrLength) then
  Exit;
 if (StrLength - Integer(Offset) + 1 < SubStrLength) then //No room for match
  Exit;
 Result := Offset;
 SubStrFirstCharUpper := LookUpTable[Ord(SubStr[1])];
 repeat
  if SubStrFirstCharUpper = LookUpTable[Ord(S[Result])] then
   begin
    if Result + SubStrLength - 1 > StrLength then
     begin
      Result := 0;
      Exit;
     end;
    I2 := 1;
    repeat
     if (I2 >= SubStrLength) then
      Exit;
     if S[Result+I2] <> SubStr[I2+1] then
      if LookUpTable[Ord(S[Result+I2])] <> LookUpTable[Ord(SubStr[I2+1])] then
       Break;
     Inc(I2);
    until(False);
   end;
  Inc(Result);
 until(Result > StrLength);
 Result := 0;
end;

initialization
  InitializeLookUpTable;
end.
